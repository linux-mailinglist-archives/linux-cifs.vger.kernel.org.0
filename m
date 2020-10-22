Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED8529647A
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Oct 2020 20:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2897861AbgJVSNx (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 22 Oct 2020 14:13:53 -0400
Received: from mx2.suse.de ([195.135.220.15]:58806 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2505941AbgJVSNx (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 22 Oct 2020 14:13:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 5070FB90F
        for <linux-cifs@vger.kernel.org>; Thu, 22 Oct 2020 18:13:51 +0000 (UTC)
From:   Samuel Cabrero <scabrero@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     Samuel Cabrero <scabrero@suse.de>
Subject: [PATCH 10/11] cifs: Handle witness client move notification
Date:   Thu, 22 Oct 2020 20:13:38 +0200
Message-Id: <20201022181339.30771-11-scabrero@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201022181339.30771-1-scabrero@suse.de>
References: <20201022181339.30771-1-scabrero@suse.de>
Reply-To: scabrero@suse.de
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

This message is sent to tell a client to close its current connection
and connect to the specified address.

Signed-off-by: Samuel Cabrero <scabrero@suse.de>
---
 fs/cifs/cifs_swn.c | 140 ++++++++++++++++++++++++++++++++++++++++++++-
 fs/cifs/cifsglob.h |   4 ++
 fs/cifs/connect.c  |  26 +++++++--
 3 files changed, 162 insertions(+), 8 deletions(-)

diff --git a/fs/cifs/cifs_swn.c b/fs/cifs/cifs_swn.c
index 93e31e4a9d99..b71b05638b1c 100644
--- a/fs/cifs/cifs_swn.c
+++ b/fs/cifs/cifs_swn.c
@@ -78,6 +78,7 @@ static int cifs_swn_send_register_message(struct cifs_swn_reg *swnreg)
 	struct sk_buff *skb;
 	struct genlmsghdr *hdr;
 	enum securityEnum authtype;
+	struct sockaddr_storage *addr;
 	int ret;
 
 	skb = genlmsg_new(NLMSG_DEFAULT_SIZE, GFP_KERNEL);
@@ -104,8 +105,18 @@ static int cifs_swn_send_register_message(struct cifs_swn_reg *swnreg)
 	if (ret < 0)
 		goto nlmsg_fail;
 
-	ret = nla_put(skb, CIFS_GENL_ATTR_SWN_IP, sizeof(struct sockaddr_storage),
-			&swnreg->tcon->ses->server->dstaddr);
+	/*
+	 * If there is an address stored use it instead of the server address, because we are
+	 * in the process of reconnecting to it after a share has been moved or we have been
+	 * told to switch to it (client move message). In these cases we unregister from the
+	 * server address and register to the new address when we receive the notification.
+	 */
+	if (swnreg->tcon->ses->server->use_swn_dstaddr)
+		addr = &swnreg->tcon->ses->server->swn_dstaddr;
+	else
+		addr = &swnreg->tcon->ses->server->dstaddr;
+
+	ret = nla_put(skb, CIFS_GENL_ATTR_SWN_IP, sizeof(struct sockaddr_storage), addr);
 	if (ret < 0)
 		goto nlmsg_fail;
 
@@ -409,6 +420,120 @@ static int cifs_swn_resource_state_changed(struct cifs_swn_reg *swnreg, const ch
 	return 0;
 }
 
+static bool cifs_sockaddr_equal(struct sockaddr_storage *addr1, struct sockaddr_storage *addr2)
+{
+	if (addr1->ss_family != addr2->ss_family)
+		return false;
+
+	if (addr1->ss_family == AF_INET) {
+		return (memcmp(&((const struct sockaddr_in *)addr1)->sin_addr,
+				&((const struct sockaddr_in *)addr2)->sin_addr,
+				sizeof(struct in_addr)) == 0);
+	}
+
+	if (addr1->ss_family == AF_INET6) {
+		return (memcmp(&((const struct sockaddr_in6 *)addr1)->sin6_addr,
+				&((const struct sockaddr_in6 *)addr2)->sin6_addr,
+				sizeof(struct in6_addr)) == 0);
+	}
+
+	return false;
+}
+
+static int cifs_swn_store_swn_addr(const struct sockaddr_storage *new,
+				   const struct sockaddr_storage *old,
+				   struct sockaddr_storage *dst)
+{
+	__be16 port;
+
+	if (old->ss_family == AF_INET) {
+		struct sockaddr_in *ipv4 = (struct sockaddr_in *)old;
+
+		port = ipv4->sin_port;
+	}
+
+	if (old->ss_family == AF_INET6) {
+		struct sockaddr_in6 *ipv6 = (struct sockaddr_in6 *)old;
+
+		port = ipv6->sin6_port;
+	}
+
+	if (new->ss_family == AF_INET) {
+		struct sockaddr_in *ipv4 = (struct sockaddr_in *)new;
+
+		ipv4->sin_port = port;
+	}
+
+	if (new->ss_family == AF_INET6) {
+		struct sockaddr_in6 *ipv6 = (struct sockaddr_in6 *)new;
+
+		ipv6->sin6_port = port;
+	}
+
+	*dst = *new;
+
+	return 0;
+}
+
+static int cifs_swn_reconnect(struct cifs_tcon *tcon, struct sockaddr_storage *addr)
+{
+	/* Store the reconnect address */
+	mutex_lock(&tcon->ses->server->srv_mutex);
+	if (!cifs_sockaddr_equal(&tcon->ses->server->dstaddr, addr)) {
+		int ret;
+
+		ret = cifs_swn_store_swn_addr(addr, &tcon->ses->server->dstaddr,
+				&tcon->ses->server->swn_dstaddr);
+		if (ret < 0) {
+			cifs_dbg(VFS, "%s: failed to store address: %d\n", __func__, ret);
+			return ret;
+		}
+		tcon->ses->server->use_swn_dstaddr = true;
+
+		/*
+		 * Unregister to stop receiving notifications for the old IP address.
+		 */
+		ret = cifs_swn_unregister(tcon);
+		if (ret < 0) {
+			cifs_dbg(VFS, "%s: Failed to unregister for witness notifications: %d\n",
+					__func__, ret);
+			return ret;
+		}
+
+		/*
+		 * And register to receive notifications for the new IP address now that we have
+		 * stored the new address.
+		 */
+		ret = cifs_swn_register(tcon);
+		if (ret < 0) {
+			cifs_dbg(VFS, "%s: Failed to register for witness notifications: %d\n",
+					__func__, ret);
+			return ret;
+		}
+
+		spin_lock(&GlobalMid_Lock);
+		if (tcon->ses->server->tcpStatus != CifsExiting)
+			tcon->ses->server->tcpStatus = CifsNeedReconnect;
+		spin_unlock(&GlobalMid_Lock);
+	}
+	mutex_unlock(&tcon->ses->server->srv_mutex);
+
+	return 0;
+}
+
+static int cifs_swn_client_move(struct cifs_swn_reg *swnreg, struct sockaddr_storage *addr)
+{
+	struct sockaddr_in *ipv4 = (struct sockaddr_in *)addr;
+	struct sockaddr_in6 *ipv6 = (struct sockaddr_in6 *)addr;
+
+	if (addr->ss_family == AF_INET)
+		cifs_dbg(FYI, "%s: move to %pI4\n", __func__, &ipv4->sin_addr);
+	else if (addr->ss_family == AF_INET6)
+		cifs_dbg(FYI, "%s: move to %pI6\n", __func__, &ipv6->sin6_addr);
+
+	return cifs_swn_reconnect(swnreg->tcon, addr);
+}
+
 int cifs_swn_notify(struct sk_buff *skb, struct genl_info *info)
 {
 	struct cifs_swn_reg *swnreg;
@@ -457,6 +582,17 @@ int cifs_swn_notify(struct sk_buff *skb, struct genl_info *info)
 		}
 		return cifs_swn_resource_state_changed(swnreg, name, state);
 	}
+	case CIFS_SWN_NOTIFICATION_CLIENT_MOVE: {
+		struct sockaddr_storage addr;
+
+		if (info->attrs[CIFS_GENL_ATTR_SWN_IP]) {
+			nla_memcpy(&addr, info->attrs[CIFS_GENL_ATTR_SWN_IP], sizeof(addr));
+		} else {
+			cifs_dbg(FYI, "%s: missing IP address attribute\n", __func__);
+			return -EINVAL;
+		}
+		return cifs_swn_client_move(swnreg, &addr);
+	}
 	default:
 		cifs_dbg(FYI, "%s: unknown notification type %d\n", __func__, type);
 		break;
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 5ca3a5568ac5..4a9089f9948c 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -775,6 +775,10 @@ struct TCP_Server_Info {
 	int nr_targets;
 	bool noblockcnt; /* use non-blocking connect() */
 	bool is_channel; /* if a session channel */
+#ifdef CONFIG_CIFS_SWN_UPCALL
+	bool use_swn_dstaddr;
+	struct sockaddr_storage swn_dstaddr;
+#endif
 };
 
 struct cifs_credits {
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 14bbec0aeccf..0da10d199f47 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -520,13 +520,24 @@ cifs_reconnect(struct TCP_Server_Info *server)
 		try_to_freeze();
 
 		mutex_lock(&server->srv_mutex);
+
+#ifdef CONFIG_CIFS_SWN_UPCALL
+		if (server->use_swn_dstaddr) {
+			server->dstaddr = server->swn_dstaddr;
+		} else {
+#endif
+
 #ifdef CONFIG_CIFS_DFS_UPCALL
-		/*
-		 * Set up next DFS target server (if any) for reconnect. If DFS
-		 * feature is disabled, then we will retry last server we
-		 * connected to before.
-		 */
-		reconn_set_next_dfs_target(server, cifs_sb, &tgt_list, &tgt_it);
+			/*
+			 * Set up next DFS target server (if any) for reconnect. If DFS
+			 * feature is disabled, then we will retry last server we
+			 * connected to before.
+			 */
+			reconn_set_next_dfs_target(server, cifs_sb, &tgt_list, &tgt_it);
+#endif
+
+#ifdef CONFIG_CIFS_SWN_UPCALL
+		}
 #endif
 
 		if (cifs_rdma_enabled(server))
@@ -544,6 +555,9 @@ cifs_reconnect(struct TCP_Server_Info *server)
 			if (server->tcpStatus != CifsExiting)
 				server->tcpStatus = CifsNeedNegotiate;
 			spin_unlock(&GlobalMid_Lock);
+#ifdef CONFIG_CIFS_SWN_UPCALL
+			server->use_swn_dstaddr = false;
+#endif
 			mutex_unlock(&server->srv_mutex);
 		}
 	} while (server->tcpStatus == CifsNeedReconnect);
-- 
2.28.0

