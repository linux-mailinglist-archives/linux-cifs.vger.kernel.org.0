Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 732F63CB27D
	for <lists+linux-cifs@lfdr.de>; Fri, 16 Jul 2021 08:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231778AbhGPG35 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 16 Jul 2021 02:29:57 -0400
Received: from mx.cjr.nz ([51.158.111.142]:57294 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231431AbhGPG35 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 16 Jul 2021 02:29:57 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 366FB7FEDD;
        Fri, 16 Jul 2021 06:26:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1626416821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=dUzGVQhVFh6hKh5GJWzOnVnw30lHsGIiVsgX5iJ5TrY=;
        b=u7liLuObHQdSC+ZRlfxdFKxo/9ZrkykNoi9fd7gj6nTiyaRmY67/0m9C5EH0Cu6DQBy82H
        poA/CyAppCFZt9HZgwXtrnLSJTUVPyYkSRLnvRJVqWw/4WW+nyxwqRRzb7qPKa3MQYVPJ4
        qPmkpy9edYmqZoiIMN7fS3Z/eI0snPb8ysL5O56Qev4gb7Jzr4/OCSCzncQOQsPnfMXaBG
        0DGLR5ivFdBps4VUWAod4O5InvGsM1vSQILfMu5gVH0BUpjXu5PQAlIrCxOmV6YpfpMkPm
        WHVBy0zaTQvsXA8KHEFA/G6jjH94dgdEZ+LqKagPWIA9irL22K0VvF0G4rAAAQ==
From:   Paulo Alcantara <pc@cjr.nz>
To:     linux-cifs@vger.kernel.org, smfrench@gmail.com
Cc:     Paulo Alcantara <pc@cjr.nz>
Subject: [PATCH] cifs: support share failover when remounting
Date:   Fri, 16 Jul 2021 03:26:41 -0300
Message-Id: <20210716062641.11086-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

When remouting a DFS share, force a new DFS referral of the path and
if the currently cached targets do not match any of the new targets or
there was no cached targets, then mark it for reconnect.

For example:

    $ mount //dom/dfs/link /mnt -o username=foo,password=bar
    $ ls /mnt
    oldfile.txt

    change target share of 'link' in server settings

    $ mount /mnt -o remount,username=foo,password=bar
    $ ls /mnt
    newfile.txt

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---
 fs/cifs/connect.c    |   4 +-
 fs/cifs/dfs_cache.c  | 229 ++++++++++++++++++++++++++++++++++++-------
 fs/cifs/dfs_cache.h  |   3 +
 fs/cifs/fs_context.c |   7 ++
 4 files changed, 203 insertions(+), 40 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 463cae116c12..fc69b04b79e8 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -220,7 +220,7 @@ cifs_reconnect(struct TCP_Server_Info *server)
 #ifdef CONFIG_CIFS_DFS_UPCALL
 	struct super_block *sb = NULL;
 	struct cifs_sb_info *cifs_sb = NULL;
-	struct dfs_cache_tgt_list tgt_list = {0};
+	struct dfs_cache_tgt_list tgt_list = DFS_CACHE_TGT_LIST_INIT(tgt_list);
 	struct dfs_cache_tgt_iterator *tgt_it = NULL;
 #endif
 
@@ -3126,7 +3126,7 @@ static int do_dfs_failover(const char *path, const char *full_path, struct cifs_
 {
 	int rc;
 	char *npath = NULL;
-	struct dfs_cache_tgt_list tgt_list = {0};
+	struct dfs_cache_tgt_list tgt_list = DFS_CACHE_TGT_LIST_INIT(tgt_list);
 	struct dfs_cache_tgt_iterator *tgt_it = NULL;
 	struct smb3_fs_context tmp_ctx = {NULL};
 
diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 7c1769714609..283745592844 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -19,6 +19,7 @@
 #include "cifs_debug.h"
 #include "cifs_unicode.h"
 #include "smb2glob.h"
+#include "dns_resolve.h"
 
 #include "dfs_cache.h"
 
@@ -911,6 +912,7 @@ static int get_targets(struct cache_entry *ce, struct dfs_cache_tgt_list *tl)
 
 err_free_it:
 	list_for_each_entry_safe(it, nit, head, it_list) {
+		list_del(&it->it_list);
 		kfree(it->it_name);
 		kfree(it);
 	}
@@ -1293,6 +1295,194 @@ int dfs_cache_get_tgt_share(char *path, const struct dfs_cache_tgt_iterator *it,
 	return 0;
 }
 
+static bool target_share_equal(struct TCP_Server_Info *server, const char *s1, const char *s2)
+{
+	char unc[sizeof("\\\\") + SERVER_NAME_LENGTH] = {0};
+	const char *host;
+	size_t hostlen;
+	char *ip = NULL;
+	struct sockaddr sa;
+	bool match;
+	int rc;
+
+	if (strcasecmp(s1, s2))
+		return false;
+
+	/*
+	 * Resolve share's hostname and check if server address matches.  Otherwise just ignore it
+	 * as we could not have upcall to resolve hostname or failed to convert ip address.
+	 */
+	match = true;
+	extract_unc_hostname(s1, &host, &hostlen);
+	scnprintf(unc, sizeof(unc), "\\\\%.*s", (int)hostlen, host);
+
+	rc = dns_resolve_server_name_to_ip(unc, &ip, NULL);
+	if (rc < 0) {
+		cifs_dbg(FYI, "%s: could not resolve %.*s. assuming server address matches.\n",
+			 __func__, (int)hostlen, host);
+		return true;
+	}
+
+	if (!cifs_convert_address(&sa, ip, strlen(ip))) {
+		cifs_dbg(VFS, "%s: failed to convert address \'%s\'. skip address matching.\n",
+			 __func__, ip);
+	} else {
+		mutex_lock(&server->srv_mutex);
+		match = cifs_match_ipaddr((struct sockaddr *)&server->dstaddr, &sa);
+		mutex_unlock(&server->srv_mutex);
+	}
+
+	kfree(ip);
+	return match;
+}
+
+/*
+ * Mark dfs tcon for reconnecting when the currently connected tcon does not match any of the new
+ * target shares in @refs.
+ */
+static void mark_for_reconnect_if_needed(struct cifs_tcon *tcon, struct dfs_cache_tgt_list *tl,
+					 const struct dfs_info3_param *refs, int numrefs)
+{
+	struct dfs_cache_tgt_iterator *it;
+	int i;
+
+	for (it = dfs_cache_get_tgt_iterator(tl); it; it = dfs_cache_get_next_tgt(tl, it)) {
+		for (i = 0; i < numrefs; i++) {
+			if (target_share_equal(tcon->ses->server, dfs_cache_get_tgt_name(it),
+					       refs[i].node_name))
+				return;
+		}
+	}
+
+	cifs_dbg(FYI, "%s: no cached or matched targets. mark dfs share for reconnect.\n", __func__);
+	for (i = 0; i < tcon->ses->chan_count; i++) {
+		spin_lock(&GlobalMid_Lock);
+		if (tcon->ses->chans[i].server->tcpStatus != CifsExiting)
+			tcon->ses->chans[i].server->tcpStatus = CifsNeedReconnect;
+		spin_unlock(&GlobalMid_Lock);
+	}
+}
+
+/* Refresh dfs referral of tcon and mark it for reconnect if needed */
+static int refresh_tcon(struct cifs_ses **sessions, struct cifs_tcon *tcon, bool force_refresh)
+{
+	const char *path = tcon->dfs_path + 1;
+	struct cifs_ses *ses;
+	struct cache_entry *ce;
+	struct dfs_info3_param *refs = NULL;
+	int numrefs = 0;
+	bool needs_refresh = false;
+	struct dfs_cache_tgt_list tl = DFS_CACHE_TGT_LIST_INIT(tl);
+	int rc = 0;
+	unsigned int xid;
+
+	ses = find_ipc_from_server_path(sessions, path);
+	if (IS_ERR(ses)) {
+		cifs_dbg(FYI, "%s: could not find ipc session\n", __func__);
+		return PTR_ERR(ses);
+	}
+
+	down_read(&htable_rw_lock);
+	ce = lookup_cache_entry(path);
+	needs_refresh = force_refresh || IS_ERR(ce) || cache_entry_expired(ce);
+	if (!IS_ERR(ce)) {
+		rc = get_targets(ce, &tl);
+		if (rc)
+			cifs_dbg(FYI, "%s: could not get dfs targets: %d\n", __func__, rc);
+	}
+	up_read(&htable_rw_lock);
+
+	if (!needs_refresh) {
+		rc = 0;
+		goto out;
+	}
+
+	xid = get_xid();
+	rc = get_dfs_referral(xid, ses, path, &refs, &numrefs);
+	free_xid(xid);
+
+	/* Create or update a cache entry with the new referral */
+	if (!rc) {
+		dump_refs(refs, numrefs);
+
+		down_write(&htable_rw_lock);
+		ce = lookup_cache_entry(path);
+		if (IS_ERR(ce))
+			add_cache_entry_locked(refs, numrefs);
+		else if (force_refresh || cache_entry_expired(ce))
+			update_cache_entry_locked(ce, refs, numrefs);
+		up_write(&htable_rw_lock);
+
+		mark_for_reconnect_if_needed(tcon, &tl, refs, numrefs);
+	}
+
+out:
+	dfs_cache_free_tgts(&tl);
+	free_dfs_info_array(refs, numrefs);
+	return rc;
+}
+
+/**
+ * dfs_cache_remount_fs - remount a DFS share
+ *
+ * Reconfigure dfs mount by forcing a new DFS referral and if the currently cached targets do not
+ * match any of the new targets, mark it for reconnect.
+ *
+ * @cifs_sb: cifs superblock.
+ *
+ * Return zero if remounted, otherwise non-zero.
+ */
+int dfs_cache_remount_fs(struct cifs_sb_info *cifs_sb)
+{
+	struct cifs_tcon *tcon;
+	struct mount_group *mg;
+	struct cifs_ses *sessions[CACHE_MAX_ENTRIES + 1] = {NULL};
+	int rc;
+
+	if (!cifs_sb || !cifs_sb->master_tlink)
+		return -EINVAL;
+
+	tcon = cifs_sb_master_tcon(cifs_sb);
+	if (!tcon->dfs_path) {
+		cifs_dbg(FYI, "%s: not a dfs tcon\n", __func__);
+		return 0;
+	}
+
+	if (uuid_is_null(&cifs_sb->dfs_mount_id)) {
+		cifs_dbg(FYI, "%s: tcon has no dfs mount group id\n", __func__);
+		return -EINVAL;
+	}
+
+	mutex_lock(&mount_group_list_lock);
+	mg = find_mount_group_locked(&cifs_sb->dfs_mount_id);
+	if (IS_ERR(mg)) {
+		mutex_unlock(&mount_group_list_lock);
+		cifs_dbg(FYI, "%s: tcon has ipc session to refresh referral\n", __func__);
+		return PTR_ERR(mg);
+	}
+	kref_get(&mg->refcount);
+	mutex_unlock(&mount_group_list_lock);
+
+	spin_lock(&mg->lock);
+	memcpy(&sessions, mg->sessions, mg->num_sessions * sizeof(mg->sessions[0]));
+	spin_unlock(&mg->lock);
+
+	/*
+	 * After reconnecting to a different server, unique ids won't match anymore, so we disable
+	 * serverino. This prevents dentry revalidation to think the dentry are stale (ESTALE).
+	 */
+	cifs_autodisable_serverino(cifs_sb);
+	/*
+	 * Force the use of prefix path to support failover on DFS paths that resolve to targets
+	 * that have different prefix paths.
+	 */
+	cifs_sb->mnt_cifs_flags |= CIFS_MOUNT_USE_PREFIX_PATH;
+	rc = refresh_tcon(sessions, tcon, true);
+
+	kref_put(&mg->refcount, mount_group_release);
+	return rc;
+}
+
 /*
  * Refresh all active dfs mounts regardless of whether they are in cache or not.
  * (cache can be cleared)
@@ -1303,7 +1493,6 @@ static void refresh_mounts(struct cifs_ses **sessions)
 	struct cifs_ses *ses;
 	struct cifs_tcon *tcon, *ntcon;
 	struct list_head tcons;
-	unsigned int xid;
 
 	INIT_LIST_HEAD(&tcons);
 
@@ -1321,44 +1510,8 @@ static void refresh_mounts(struct cifs_ses **sessions)
 	spin_unlock(&cifs_tcp_ses_lock);
 
 	list_for_each_entry_safe(tcon, ntcon, &tcons, ulist) {
-		const char *path = tcon->dfs_path + 1;
-		struct cache_entry *ce;
-		struct dfs_info3_param *refs = NULL;
-		int numrefs = 0;
-		bool needs_refresh = false;
-		int rc = 0;
-
 		list_del_init(&tcon->ulist);
-
-		ses = find_ipc_from_server_path(sessions, path);
-		if (IS_ERR(ses))
-			goto next_tcon;
-
-		down_read(&htable_rw_lock);
-		ce = lookup_cache_entry(path);
-		needs_refresh = IS_ERR(ce) || cache_entry_expired(ce);
-		up_read(&htable_rw_lock);
-
-		if (!needs_refresh)
-			goto next_tcon;
-
-		xid = get_xid();
-		rc = get_dfs_referral(xid, ses, path, &refs, &numrefs);
-		free_xid(xid);
-
-		/* Create or update a cache entry with the new referral */
-		if (!rc) {
-			down_write(&htable_rw_lock);
-			ce = lookup_cache_entry(path);
-			if (IS_ERR(ce))
-				add_cache_entry_locked(refs, numrefs);
-			else if (cache_entry_expired(ce))
-				update_cache_entry_locked(ce, refs, numrefs);
-			up_write(&htable_rw_lock);
-		}
-
-next_tcon:
-		free_dfs_info_array(refs, numrefs);
+		refresh_tcon(sessions, tcon, false);
 		cifs_put_tcon(tcon);
 	}
 }
diff --git a/fs/cifs/dfs_cache.h b/fs/cifs/dfs_cache.h
index b29d3ae64829..52070d1df189 100644
--- a/fs/cifs/dfs_cache.h
+++ b/fs/cifs/dfs_cache.h
@@ -13,6 +13,8 @@
 #include <linux/uuid.h>
 #include "cifsglob.h"
 
+#define DFS_CACHE_TGT_LIST_INIT(var) { .tl_numtgts = 0, .tl_list = LIST_HEAD_INIT((var).tl_list), }
+
 struct dfs_cache_tgt_list {
 	int tl_numtgts;
 	struct list_head tl_list;
@@ -44,6 +46,7 @@ int dfs_cache_get_tgt_share(char *path, const struct dfs_cache_tgt_iterator *it,
 void dfs_cache_put_refsrv_sessions(const uuid_t *mount_id);
 void dfs_cache_add_refsrv_session(const uuid_t *mount_id, struct cifs_ses *ses);
 char *dfs_cache_canonical_path(const char *path, const struct nls_table *cp, int remap);
+int dfs_cache_remount_fs(struct cifs_sb_info *cifs_sb);
 
 static inline struct dfs_cache_tgt_iterator *
 dfs_cache_get_next_tgt(struct dfs_cache_tgt_list *tl,
diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 553adfbcc22a..9a59d7ff9a11 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -13,6 +13,9 @@
 #include <linux/magic.h>
 #include <linux/security.h>
 #include <net/net_namespace.h>
+#ifdef CONFIG_CIFS_DFS_UPCALL
+#include "dfs_cache.h"
+#endif
 */
 
 #include <linux/ctype.h>
@@ -779,6 +782,10 @@ static int smb3_reconfigure(struct fs_context *fc)
 	smb3_cleanup_fs_context_contents(cifs_sb->ctx);
 	rc = smb3_fs_context_dup(cifs_sb->ctx, ctx);
 	smb3_update_mnt_flags(cifs_sb);
+#ifdef CONFIG_CIFS_DFS_UPCALL
+	if (!rc)
+		rc = dfs_cache_remount_fs(cifs_sb);
+#endif
 
 	return rc;
 }
-- 
2.32.0

