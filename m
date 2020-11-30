Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 392DF2C8C08
	for <lists+linux-cifs@lfdr.de>; Mon, 30 Nov 2020 19:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387913AbgK3SEe (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 30 Nov 2020 13:04:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:45750 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729435AbgK3SEd (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 30 Nov 2020 13:04:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7A685AF26
        for <linux-cifs@vger.kernel.org>; Mon, 30 Nov 2020 18:03:11 +0000 (UTC)
From:   Samuel Cabrero <scabrero@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     Samuel Cabrero <scabrero@suse.de>
Subject: [PATCH v4 05/11] cifs: Send witness register and unregister commands to userspace daemon
Date:   Mon, 30 Nov 2020 19:02:51 +0100
Message-Id: <20201130180257.31787-6-scabrero@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130180257.31787-1-scabrero@suse.de>
References: <20201130180257.31787-1-scabrero@suse.de>
Reply-To: scabrero@suse.de
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

+ Define the generic netlink family commands and message attributes to
  communicate with the userspace daemon

+ The register and unregister commands are sent when connecting or
  disconnecting a tree. The witness registration keeps a pointer to
  the tcon and has the same lifetime.

+ Each registration has an id allocated by an IDR. This id is sent to the
  userspace daemon in the register command, and will be included in the
  notification messages from the userspace daemon to retrieve from the
  IDR the matching registration.

+ The authentication information is bundled in the register message.
  If kerberos is used the message just carries a flag.

Signed-off-by: Samuel Cabrero <scabrero@suse.de>
---
 fs/cifs/Makefile                       |   2 +-
 fs/cifs/cifs_swn.c                     | 421 +++++++++++++++++++++++++
 fs/cifs/cifs_swn.h                     |  17 +
 fs/cifs/connect.c                      |  26 +-
 fs/cifs/netlink.c                      |  11 +
 include/uapi/linux/cifs/cifs_netlink.h |  15 +
 6 files changed, 489 insertions(+), 3 deletions(-)
 create mode 100644 fs/cifs/cifs_swn.c
 create mode 100644 fs/cifs/cifs_swn.h

diff --git a/fs/cifs/Makefile b/fs/cifs/Makefile
index b88fd46ac597..abb2fbc0f904 100644
--- a/fs/cifs/Makefile
+++ b/fs/cifs/Makefile
@@ -18,7 +18,7 @@ cifs-$(CONFIG_CIFS_UPCALL) += cifs_spnego.o
 
 cifs-$(CONFIG_CIFS_DFS_UPCALL) += dns_resolve.o cifs_dfs_ref.o dfs_cache.o
 
-cifs-$(CONFIG_CIFS_SWN_UPCALL) += netlink.o
+cifs-$(CONFIG_CIFS_SWN_UPCALL) += netlink.o cifs_swn.o
 
 cifs-$(CONFIG_CIFS_FSCACHE) += fscache.o cache.o
 
diff --git a/fs/cifs/cifs_swn.c b/fs/cifs/cifs_swn.c
new file mode 100644
index 000000000000..c0af03955d0c
--- /dev/null
+++ b/fs/cifs/cifs_swn.c
@@ -0,0 +1,421 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Witness Service client for CIFS
+ *
+ * Copyright (c) 2020 Samuel Cabrero <scabrero@suse.de>
+ */
+
+#include <linux/kref.h>
+#include <net/genetlink.h>
+#include <uapi/linux/cifs/cifs_netlink.h>
+
+#include "cifs_swn.h"
+#include "cifsglob.h"
+#include "cifsproto.h"
+#include "fscache.h"
+#include "cifs_debug.h"
+#include "netlink.h"
+
+static DEFINE_IDR(cifs_swnreg_idr);
+static DEFINE_MUTEX(cifs_swnreg_idr_mutex);
+
+struct cifs_swn_reg {
+	int id;
+	struct kref ref_count;
+
+	const char *net_name;
+	const char *share_name;
+	bool net_name_notify;
+	bool share_name_notify;
+	bool ip_notify;
+
+	struct cifs_tcon *tcon;
+};
+
+static int cifs_swn_auth_info_krb(struct cifs_tcon *tcon, struct sk_buff *skb)
+{
+	int ret;
+
+	ret = nla_put_flag(skb, CIFS_GENL_ATTR_SWN_KRB_AUTH);
+	if (ret < 0)
+		return ret;
+
+	return 0;
+}
+
+static int cifs_swn_auth_info_ntlm(struct cifs_tcon *tcon, struct sk_buff *skb)
+{
+	int ret;
+
+	if (tcon->ses->user_name != NULL) {
+		ret = nla_put_string(skb, CIFS_GENL_ATTR_SWN_USER_NAME, tcon->ses->user_name);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (tcon->ses->password != NULL) {
+		ret = nla_put_string(skb, CIFS_GENL_ATTR_SWN_PASSWORD, tcon->ses->password);
+		if (ret < 0)
+			return ret;
+	}
+
+	if (tcon->ses->domainName != NULL) {
+		ret = nla_put_string(skb, CIFS_GENL_ATTR_SWN_DOMAIN_NAME, tcon->ses->domainName);
+		if (ret < 0)
+			return ret;
+	}
+
+	return 0;
+}
+
+/*
+ * Sends a register message to the userspace daemon based on the registration.
+ * The authentication information to connect to the witness service is bundled
+ * into the message.
+ */
+static int cifs_swn_send_register_message(struct cifs_swn_reg *swnreg)
+{
+	struct sk_buff *skb;
+	struct genlmsghdr *hdr;
+	enum securityEnum authtype;
+	int ret;
+
+	skb = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (skb == NULL) {
+		ret = -ENOMEM;
+		goto fail;
+	}
+
+	hdr = genlmsg_put(skb, 0, 0, &cifs_genl_family, 0, CIFS_GENL_CMD_SWN_REGISTER);
+	if (hdr == NULL) {
+		ret = -ENOMEM;
+		goto nlmsg_fail;
+	}
+
+	ret = nla_put_u32(skb, CIFS_GENL_ATTR_SWN_REGISTRATION_ID, swnreg->id);
+	if (ret < 0)
+		goto nlmsg_fail;
+
+	ret = nla_put_string(skb, CIFS_GENL_ATTR_SWN_NET_NAME, swnreg->net_name);
+	if (ret < 0)
+		goto nlmsg_fail;
+
+	ret = nla_put_string(skb, CIFS_GENL_ATTR_SWN_SHARE_NAME, swnreg->share_name);
+	if (ret < 0)
+		goto nlmsg_fail;
+
+	ret = nla_put(skb, CIFS_GENL_ATTR_SWN_IP, sizeof(struct sockaddr_storage),
+			&swnreg->tcon->ses->server->dstaddr);
+	if (ret < 0)
+		goto nlmsg_fail;
+
+	if (swnreg->net_name_notify) {
+		ret = nla_put_flag(skb, CIFS_GENL_ATTR_SWN_NET_NAME_NOTIFY);
+		if (ret < 0)
+			goto nlmsg_fail;
+	}
+
+	if (swnreg->share_name_notify) {
+		ret = nla_put_flag(skb, CIFS_GENL_ATTR_SWN_SHARE_NAME_NOTIFY);
+		if (ret < 0)
+			goto nlmsg_fail;
+	}
+
+	if (swnreg->ip_notify) {
+		ret = nla_put_flag(skb, CIFS_GENL_ATTR_SWN_IP_NOTIFY);
+		if (ret < 0)
+			goto nlmsg_fail;
+	}
+
+	authtype = cifs_select_sectype(swnreg->tcon->ses->server, swnreg->tcon->ses->sectype);
+	switch (authtype) {
+	case Kerberos:
+		ret = cifs_swn_auth_info_krb(swnreg->tcon, skb);
+		if (ret < 0) {
+			cifs_dbg(VFS, "%s: Failed to get kerberos auth info: %d\n", __func__, ret);
+			goto nlmsg_fail;
+		}
+		break;
+	case LANMAN:
+	case NTLM:
+	case NTLMv2:
+	case RawNTLMSSP:
+		ret = cifs_swn_auth_info_ntlm(swnreg->tcon, skb);
+		if (ret < 0) {
+			cifs_dbg(VFS, "%s: Failed to get NTLM auth info: %d\n", __func__, ret);
+			goto nlmsg_fail;
+		}
+		break;
+	default:
+		cifs_dbg(VFS, "%s: secType %d not supported!\n", __func__, authtype);
+		ret = -EINVAL;
+		goto nlmsg_fail;
+	}
+
+	genlmsg_end(skb, hdr);
+	genlmsg_multicast(&cifs_genl_family, skb, 0, CIFS_GENL_MCGRP_SWN, GFP_ATOMIC);
+
+	cifs_dbg(FYI, "%s: Message to register for network name %s with id %d sent\n", __func__,
+			swnreg->net_name, swnreg->id);
+
+	return 0;
+
+nlmsg_fail:
+	genlmsg_cancel(skb, hdr);
+	nlmsg_free(skb);
+fail:
+	return ret;
+}
+
+/*
+ * Sends an uregister message to the userspace daemon based on the registration
+ */
+static int cifs_swn_send_unregister_message(struct cifs_swn_reg *swnreg)
+{
+	struct sk_buff *skb;
+	struct genlmsghdr *hdr;
+	int ret;
+
+	skb = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
+	if (skb == NULL)
+		return -ENOMEM;
+
+	hdr = genlmsg_put(skb, 0, 0, &cifs_genl_family, 0, CIFS_GENL_CMD_SWN_UNREGISTER);
+	if (hdr == NULL) {
+		ret = -ENOMEM;
+		goto nlmsg_fail;
+	}
+
+	ret = nla_put_u32(skb, CIFS_GENL_ATTR_SWN_REGISTRATION_ID, swnreg->id);
+	if (ret < 0)
+		goto nlmsg_fail;
+
+	ret = nla_put_string(skb, CIFS_GENL_ATTR_SWN_NET_NAME, swnreg->net_name);
+	if (ret < 0)
+		goto nlmsg_fail;
+
+	ret = nla_put_string(skb, CIFS_GENL_ATTR_SWN_SHARE_NAME, swnreg->share_name);
+	if (ret < 0)
+		goto nlmsg_fail;
+
+	ret = nla_put(skb, CIFS_GENL_ATTR_SWN_IP, sizeof(struct sockaddr_storage),
+			&swnreg->tcon->ses->server->dstaddr);
+	if (ret < 0)
+		goto nlmsg_fail;
+
+	if (swnreg->net_name_notify) {
+		ret = nla_put_flag(skb, CIFS_GENL_ATTR_SWN_NET_NAME_NOTIFY);
+		if (ret < 0)
+			goto nlmsg_fail;
+	}
+
+	if (swnreg->share_name_notify) {
+		ret = nla_put_flag(skb, CIFS_GENL_ATTR_SWN_SHARE_NAME_NOTIFY);
+		if (ret < 0)
+			goto nlmsg_fail;
+	}
+
+	if (swnreg->ip_notify) {
+		ret = nla_put_flag(skb, CIFS_GENL_ATTR_SWN_IP_NOTIFY);
+		if (ret < 0)
+			goto nlmsg_fail;
+	}
+
+	genlmsg_end(skb, hdr);
+	genlmsg_multicast(&cifs_genl_family, skb, 0, CIFS_GENL_MCGRP_SWN, GFP_ATOMIC);
+
+	cifs_dbg(FYI, "%s: Message to unregister for network name %s with id %d sent\n", __func__,
+			swnreg->net_name, swnreg->id);
+
+	return 0;
+
+nlmsg_fail:
+	genlmsg_cancel(skb, hdr);
+	nlmsg_free(skb);
+	return ret;
+}
+
+/*
+ * Try to find a matching registration for the tcon's server name and share name.
+ * Calls to this funciton must be protected by cifs_swnreg_idr_mutex.
+ * TODO Try to avoid memory allocations
+ */
+static struct cifs_swn_reg *cifs_find_swn_reg(struct cifs_tcon *tcon)
+{
+	struct cifs_swn_reg *swnreg;
+	int id;
+	const char *share_name;
+	const char *net_name;
+
+	net_name = extract_hostname(tcon->treeName);
+	if (IS_ERR_OR_NULL(net_name)) {
+		int ret;
+
+		ret = PTR_ERR(net_name);
+		cifs_dbg(VFS, "%s: failed to extract host name from target '%s': %d\n",
+				__func__, tcon->treeName, ret);
+		return NULL;
+	}
+
+	share_name = extract_sharename(tcon->treeName);
+	if (IS_ERR_OR_NULL(share_name)) {
+		int ret;
+
+		ret = PTR_ERR(net_name);
+		cifs_dbg(VFS, "%s: failed to extract share name from target '%s': %d\n",
+				__func__, tcon->treeName, ret);
+		kfree(net_name);
+		return NULL;
+	}
+
+	idr_for_each_entry(&cifs_swnreg_idr, swnreg, id) {
+		if (strcasecmp(swnreg->net_name, net_name) != 0
+		    || strcasecmp(swnreg->share_name, share_name) != 0) {
+			continue;
+		}
+
+		mutex_unlock(&cifs_swnreg_idr_mutex);
+
+		cifs_dbg(FYI, "Existing swn registration for %s:%s found\n", swnreg->net_name,
+				swnreg->share_name);
+
+		kfree(net_name);
+		kfree(share_name);
+
+		return swnreg;
+	}
+
+	kfree(net_name);
+	kfree(share_name);
+
+	return NULL;
+}
+
+/*
+ * Get a registration for the tcon's server and share name, allocating a new one if it does not
+ * exists
+ */
+static struct cifs_swn_reg *cifs_get_swn_reg(struct cifs_tcon *tcon)
+{
+	struct cifs_swn_reg *reg = NULL;
+	int ret;
+
+	mutex_lock(&cifs_swnreg_idr_mutex);
+
+	/* Check if we are already registered for this network and share names */
+	reg = cifs_find_swn_reg(tcon);
+	if (IS_ERR(reg)) {
+		return reg;
+	} else if (reg != NULL) {
+		kref_get(&reg->ref_count);
+		mutex_unlock(&cifs_swnreg_idr_mutex);
+		return reg;
+	}
+
+	reg = kmalloc(sizeof(struct cifs_swn_reg), GFP_ATOMIC);
+	if (reg == NULL) {
+		mutex_unlock(&cifs_swnreg_idr_mutex);
+		return ERR_PTR(-ENOMEM);
+	}
+
+	kref_init(&reg->ref_count);
+
+	reg->id = idr_alloc(&cifs_swnreg_idr, reg, 1, 0, GFP_ATOMIC);
+	if (reg->id < 0) {
+		cifs_dbg(FYI, "%s: failed to allocate registration id\n", __func__);
+		ret = reg->id;
+		goto fail;
+	}
+
+	reg->net_name = extract_hostname(tcon->treeName);
+	if (IS_ERR(reg->net_name)) {
+		ret = PTR_ERR(reg->net_name);
+		cifs_dbg(VFS, "%s: failed to extract host name from target: %d\n", __func__, ret);
+		goto fail_idr;
+	}
+
+	reg->share_name = extract_sharename(tcon->treeName);
+	if (IS_ERR(reg->share_name)) {
+		ret = PTR_ERR(reg->share_name);
+		cifs_dbg(VFS, "%s: failed to extract share name from target: %d\n", __func__, ret);
+		goto fail_net_name;
+	}
+
+	reg->net_name_notify = true;
+	reg->share_name_notify = true;
+	reg->ip_notify = (tcon->capabilities & SMB2_SHARE_CAP_SCALEOUT);
+
+	reg->tcon = tcon;
+
+	mutex_unlock(&cifs_swnreg_idr_mutex);
+
+	return reg;
+
+fail_net_name:
+	kfree(reg->net_name);
+fail_idr:
+	idr_remove(&cifs_swnreg_idr, reg->id);
+fail:
+	kfree(reg);
+	mutex_unlock(&cifs_swnreg_idr_mutex);
+	return ERR_PTR(ret);
+}
+
+static void cifs_swn_reg_release(struct kref *ref)
+{
+	struct cifs_swn_reg *swnreg = container_of(ref, struct cifs_swn_reg, ref_count);
+	int ret;
+
+	ret = cifs_swn_send_unregister_message(swnreg);
+	if (ret < 0)
+		cifs_dbg(VFS, "%s: Failed to send unregister message: %d\n", __func__, ret);
+
+	idr_remove(&cifs_swnreg_idr, swnreg->id);
+	kfree(swnreg->net_name);
+	kfree(swnreg->share_name);
+	kfree(swnreg);
+}
+
+static void cifs_put_swn_reg(struct cifs_swn_reg *swnreg)
+{
+	mutex_lock(&cifs_swnreg_idr_mutex);
+	kref_put(&swnreg->ref_count, cifs_swn_reg_release);
+	mutex_unlock(&cifs_swnreg_idr_mutex);
+}
+
+int cifs_swn_register(struct cifs_tcon *tcon)
+{
+	struct cifs_swn_reg *swnreg;
+	int ret;
+
+	swnreg = cifs_get_swn_reg(tcon);
+	if (IS_ERR(swnreg))
+		return PTR_ERR(swnreg);
+
+	ret = cifs_swn_send_register_message(swnreg);
+	if (ret < 0) {
+		cifs_dbg(VFS, "%s: Failed to send swn register message: %d\n", __func__, ret);
+		/* Do not put the swnreg or return error, the echo task will retry */
+	}
+
+	return 0;
+}
+
+int cifs_swn_unregister(struct cifs_tcon *tcon)
+{
+	struct cifs_swn_reg *swnreg;
+
+	mutex_lock(&cifs_swnreg_idr_mutex);
+
+	swnreg = cifs_find_swn_reg(tcon);
+	if (swnreg == NULL) {
+		mutex_unlock(&cifs_swnreg_idr_mutex);
+		return -EEXIST;
+	}
+
+	mutex_unlock(&cifs_swnreg_idr_mutex);
+
+	cifs_put_swn_reg(swnreg);
+
+	return 0;
+}
diff --git a/fs/cifs/cifs_swn.h b/fs/cifs/cifs_swn.h
new file mode 100644
index 000000000000..69c7bd1035da
--- /dev/null
+++ b/fs/cifs/cifs_swn.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Witness Service client for CIFS
+ *
+ * Copyright (c) 2020 Samuel Cabrero <scabrero@suse.de>
+ */
+
+#ifndef _CIFS_SWN_H
+#define _CIFS_SWN_H
+
+struct cifs_tcon;
+
+extern int cifs_swn_register(struct cifs_tcon *tcon);
+
+extern int cifs_swn_unregister(struct cifs_tcon *tcon);
+
+#endif /* _CIFS_SWN_H */
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 22d46c8acc7f..7fbb201b42c3 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -62,6 +62,9 @@
 #include "dfs_cache.h"
 #endif
 #include "fs_context.h"
+#ifdef CONFIG_CIFS_SWN_UPCALL
+#include "cifs_swn.h"
+#endif
 
 extern mempool_t *cifs_req_poolp;
 extern bool disable_legacy_dialects;
@@ -3168,7 +3171,17 @@ cifs_put_tcon(struct cifs_tcon *tcon)
 		return;
 	}
 
-	/* TODO witness unregister */
+#ifdef CONFIG_CIFS_SWN_UPCALL
+	if (tcon->use_witness) {
+		int rc;
+
+		rc = cifs_swn_unregister(tcon);
+		if (rc < 0) {
+			cifs_dbg(VFS, "%s: Failed to unregister for witness notifications: %d\n",
+					__func__, rc);
+		}
+	}
+#endif
 
 	list_del_init(&tcon->tcon_list);
 	spin_unlock(&cifs_tcp_ses_lock);
@@ -3336,8 +3349,17 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb_vol *volume_info)
 	if (volume_info->witness) {
 		if (ses->server->vals->protocol_id >= SMB30_PROT_ID) {
 			if (tcon->capabilities & SMB2_SHARE_CAP_CLUSTER) {
-				/* TODO witness register */
+				/*
+				 * Set witness in use flag in first place
+				 * to retry registration in the echo task
+				 */
 				tcon->use_witness = true;
+				/* And try to register immediately */
+				rc = cifs_swn_register(tcon);
+				if (rc < 0) {
+					cifs_dbg(VFS, "Failed to register for witness notifications: %d\n", rc);
+					goto out_fail;
+				}
 			} else {
 				cifs_dbg(VFS, "witness requested on mount but no CLUSTER capability on share\n");
 				rc = -EOPNOTSUPP;
diff --git a/fs/cifs/netlink.c b/fs/cifs/netlink.c
index b9154661fa85..83008a56def5 100644
--- a/fs/cifs/netlink.c
+++ b/fs/cifs/netlink.c
@@ -13,6 +13,17 @@
 #include "cifs_debug.h"
 
 static const struct nla_policy cifs_genl_policy[CIFS_GENL_ATTR_MAX + 1] = {
+	[CIFS_GENL_ATTR_SWN_REGISTRATION_ID]	= { .type = NLA_U32 },
+	[CIFS_GENL_ATTR_SWN_NET_NAME]		= { .type = NLA_STRING },
+	[CIFS_GENL_ATTR_SWN_SHARE_NAME]		= { .type = NLA_STRING },
+	[CIFS_GENL_ATTR_SWN_IP]			= { .len = sizeof(struct sockaddr_storage) },
+	[CIFS_GENL_ATTR_SWN_NET_NAME_NOTIFY]	= { .type = NLA_FLAG },
+	[CIFS_GENL_ATTR_SWN_SHARE_NAME_NOTIFY]	= { .type = NLA_FLAG },
+	[CIFS_GENL_ATTR_SWN_IP_NOTIFY]		= { .type = NLA_FLAG },
+	[CIFS_GENL_ATTR_SWN_KRB_AUTH]		= { .type = NLA_FLAG },
+	[CIFS_GENL_ATTR_SWN_USER_NAME]		= { .type = NLA_STRING },
+	[CIFS_GENL_ATTR_SWN_PASSWORD]		= { .type = NLA_STRING },
+	[CIFS_GENL_ATTR_SWN_DOMAIN_NAME]	= { .type = NLA_STRING },
 };
 
 static struct genl_ops cifs_genl_ops[] = {
diff --git a/include/uapi/linux/cifs/cifs_netlink.h b/include/uapi/linux/cifs/cifs_netlink.h
index cdb1bd78fbc7..5662e2774513 100644
--- a/include/uapi/linux/cifs/cifs_netlink.h
+++ b/include/uapi/linux/cifs/cifs_netlink.h
@@ -19,11 +19,26 @@ enum cifs_genl_multicast_groups {
 };
 
 enum cifs_genl_attributes {
+	CIFS_GENL_ATTR_UNSPEC,
+	CIFS_GENL_ATTR_SWN_REGISTRATION_ID,
+	CIFS_GENL_ATTR_SWN_NET_NAME,
+	CIFS_GENL_ATTR_SWN_SHARE_NAME,
+	CIFS_GENL_ATTR_SWN_IP,
+	CIFS_GENL_ATTR_SWN_NET_NAME_NOTIFY,
+	CIFS_GENL_ATTR_SWN_SHARE_NAME_NOTIFY,
+	CIFS_GENL_ATTR_SWN_IP_NOTIFY,
+	CIFS_GENL_ATTR_SWN_KRB_AUTH,
+	CIFS_GENL_ATTR_SWN_USER_NAME,
+	CIFS_GENL_ATTR_SWN_PASSWORD,
+	CIFS_GENL_ATTR_SWN_DOMAIN_NAME,
 	__CIFS_GENL_ATTR_MAX,
 };
 #define CIFS_GENL_ATTR_MAX (__CIFS_GENL_ATTR_MAX - 1)
 
 enum cifs_genl_commands {
+	CIFS_GENL_CMD_UNSPEC,
+	CIFS_GENL_CMD_SWN_REGISTER,
+	CIFS_GENL_CMD_SWN_UNREGISTER,
 	__CIFS_GENL_CMD_MAX
 };
 #define CIFS_GENL_CMD_MAX (__CIFS_GENL_CMD_MAX - 1)
-- 
2.29.2

