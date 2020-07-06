Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 271AD215AC1
	for <lists+linux-cifs@lfdr.de>; Mon,  6 Jul 2020 17:32:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729338AbgGFPcF (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 6 Jul 2020 11:32:05 -0400
Received: from mx.cjr.nz ([51.158.111.142]:53950 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729248AbgGFPcE (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 6 Jul 2020 11:32:04 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id D60C47FF33;
        Mon,  6 Jul 2020 15:25:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1594049119;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zYpPOt4NU3XQ+Ma5SjTLNkzkWT+LtpJcGEoCEJhNgCs=;
        b=s40uIvBVOytPlGasdc1U/5emA+iRwKmJ6tYIJpN8ayGleFBTfE80THxxEXHQaPji0oduI/
        lcqoJtpVdWoI/AXvHCmaNN4liSjtoodnlFZXGOwFit3ucF/9CpqDmXOKs685yqy/Fv7q+5
        1tOd7//+TEFPFJW/4jhuGE+efccQFeoPlGzgCqykn+rAWbobeAkjvdGRVI7jZbcJslrWST
        YoZFJVMvREwA6SnNZt/4AFHuZmbgHw7+OSN77z5sd6wNFJa/gEMNH9+g9mUXkTYeAeCJ+4
        yj7bvk95FtiE9HrzwHkZbTM7HB48PUVsIQMIQ2q1e2UrOdgxynSwLaJZYK4+cg==
From:   Paulo Alcantara <pc@cjr.nz>
To:     linux-cifs@vger.kernel.org, smfrench@gmail.com
Cc:     Stefan Metzmacher <metze@samba.org>, Paulo Alcantara <pc@cjr.nz>
Subject: [PATCH 1/7] cifs: merge __{cifs,smb2}_reconnect[_tcon]() into cifs_tree_connect()
Date:   Mon,  6 Jul 2020 12:23:56 -0300
Message-Id: <20200706152402.5721-2-pc@cjr.nz>
In-Reply-To: <20200706152402.5721-1-pc@cjr.nz>
References: <20200706152402.5721-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

From: Stefan Metzmacher <metze@samba.org>

They were identical execpt to CIFSTCon() vs. SMB2_tcon().
These are also available via ops->tree_connect().

Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---
 fs/cifs/cifsproto.h |   3 ++
 fs/cifs/cifssmb.c   | 112 +------------------------------------------
 fs/cifs/connect.c   | 100 +++++++++++++++++++++++++++++++++++++++
 fs/cifs/smb2pdu.c   | 113 +-------------------------------------------
 4 files changed, 105 insertions(+), 223 deletions(-)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 7a836ec0438e..93b018723abf 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -271,6 +271,9 @@ extern void cifs_move_llist(struct list_head *source, struct list_head *dest);
 extern void cifs_free_llist(struct list_head *llist);
 extern void cifs_del_lock_waiters(struct cifsLockInfo *lock);
 
+extern int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon,
+			     const struct nls_table *nlsc);
+
 extern int cifs_negotiate_protocol(const unsigned int xid,
 				   struct cifs_ses *ses);
 extern int cifs_setup_session(const unsigned int xid, struct cifs_ses *ses,
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index bf41ee048396..a6ea7e7b18cd 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -124,116 +124,6 @@ cifs_mark_open_files_invalid(struct cifs_tcon *tcon)
 	 */
 }
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
-static int __cifs_reconnect_tcon(const struct nls_table *nlsc,
-				 struct cifs_tcon *tcon)
-{
-	int rc;
-	struct TCP_Server_Info *server = tcon->ses->server;
-	struct dfs_cache_tgt_list tl;
-	struct dfs_cache_tgt_iterator *it = NULL;
-	char *tree;
-	const char *tcp_host;
-	size_t tcp_host_len;
-	const char *dfs_host;
-	size_t dfs_host_len;
-
-	tree = kzalloc(MAX_TREE_SIZE, GFP_KERNEL);
-	if (!tree)
-		return -ENOMEM;
-
-	if (!tcon->dfs_path) {
-		if (tcon->ipc) {
-			scnprintf(tree, MAX_TREE_SIZE, "\\\\%s\\IPC$",
-				  server->hostname);
-			rc = CIFSTCon(0, tcon->ses, tree, tcon, nlsc);
-		} else {
-			rc = CIFSTCon(0, tcon->ses, tcon->treeName, tcon, nlsc);
-		}
-		goto out;
-	}
-
-	rc = dfs_cache_noreq_find(tcon->dfs_path + 1, NULL, &tl);
-	if (rc)
-		goto out;
-
-	extract_unc_hostname(server->hostname, &tcp_host, &tcp_host_len);
-
-	for (it = dfs_cache_get_tgt_iterator(&tl); it;
-	     it = dfs_cache_get_next_tgt(&tl, it)) {
-		const char *share, *prefix;
-		size_t share_len, prefix_len;
-		bool target_match;
-
-		rc = dfs_cache_get_tgt_share(it, &share, &share_len, &prefix,
-					     &prefix_len);
-		if (rc) {
-			cifs_dbg(VFS, "%s: failed to parse target share %d\n",
-				 __func__, rc);
-			continue;
-		}
-
-		extract_unc_hostname(share, &dfs_host, &dfs_host_len);
-
-		if (dfs_host_len != tcp_host_len
-		    || strncasecmp(dfs_host, tcp_host, dfs_host_len) != 0) {
-			cifs_dbg(FYI, "%s: %.*s doesn't match %.*s\n",
-				 __func__,
-				 (int)dfs_host_len, dfs_host,
-				 (int)tcp_host_len, tcp_host);
-
-			rc = match_target_ip(server, dfs_host, dfs_host_len,
-					     &target_match);
-			if (rc) {
-				cifs_dbg(VFS, "%s: failed to match target ip: %d\n",
-					 __func__, rc);
-				break;
-			}
-
-			if (!target_match) {
-				cifs_dbg(FYI, "%s: skipping target\n", __func__);
-				continue;
-			}
-		}
-
-		if (tcon->ipc) {
-			scnprintf(tree, MAX_TREE_SIZE, "\\\\%.*s\\IPC$",
-				  (int)share_len, share);
-			rc = CIFSTCon(0, tcon->ses, tree, tcon, nlsc);
-		} else {
-			scnprintf(tree, MAX_TREE_SIZE, "\\%.*s", (int)share_len,
-				  share);
-			rc = CIFSTCon(0, tcon->ses, tree, tcon, nlsc);
-			if (!rc) {
-				rc = update_super_prepath(tcon, prefix,
-							  prefix_len);
-				break;
-			}
-		}
-		if (rc == -EREMOTE)
-			break;
-	}
-
-	if (!rc) {
-		if (it)
-			rc = dfs_cache_noreq_update_tgthint(tcon->dfs_path + 1,
-							    it);
-		else
-			rc = -ENOENT;
-	}
-	dfs_cache_free_tgts(&tl);
-out:
-	kfree(tree);
-	return rc;
-}
-#else
-static inline int __cifs_reconnect_tcon(const struct nls_table *nlsc,
-					struct cifs_tcon *tcon)
-{
-	return CIFSTCon(0, tcon->ses, tcon->treeName, tcon, nlsc);
-}
-#endif
-
 /* reconnect the socket, tcon, and smb session if needed */
 static int
 cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
@@ -338,7 +228,7 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 	}
 
 	cifs_mark_open_files_invalid(tcon);
-	rc = __cifs_reconnect_tcon(nls_codepage, tcon);
+	rc = cifs_tree_connect(0, tcon, nls_codepage);
 	mutex_unlock(&ses->session_mutex);
 	cifs_dbg(FYI, "reconnect tcon rc = %d\n", rc);
 
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index a61abde09ffe..5c3c65265478 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -5533,3 +5533,103 @@ cifs_prune_tlinks(struct work_struct *work)
 	queue_delayed_work(cifsiod_wq, &cifs_sb->prune_tlinks,
 				TLINK_IDLE_EXPIRE);
 }
+
+#ifdef CONFIG_CIFS_DFS_UPCALL
+int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const struct nls_table *nlsc)
+{
+	int rc;
+	struct TCP_Server_Info *server = tcon->ses->server;
+	const struct smb_version_operations *ops = server->ops;
+	struct dfs_cache_tgt_list tl;
+	struct dfs_cache_tgt_iterator *it = NULL;
+	char *tree;
+	const char *tcp_host;
+	size_t tcp_host_len;
+	const char *dfs_host;
+	size_t dfs_host_len;
+
+	tree = kzalloc(MAX_TREE_SIZE, GFP_KERNEL);
+	if (!tree)
+		return -ENOMEM;
+
+	if (!tcon->dfs_path) {
+		if (tcon->ipc) {
+			scnprintf(tree, MAX_TREE_SIZE, "\\\\%s\\IPC$", server->hostname);
+			rc = ops->tree_connect(xid, tcon->ses, tree, tcon, nlsc);
+		} else {
+			rc = ops->tree_connect(xid, tcon->ses, tcon->treeName, tcon, nlsc);
+		}
+		goto out;
+	}
+
+	rc = dfs_cache_noreq_find(tcon->dfs_path + 1, NULL, &tl);
+	if (rc)
+		goto out;
+
+	extract_unc_hostname(server->hostname, &tcp_host, &tcp_host_len);
+
+	for (it = dfs_cache_get_tgt_iterator(&tl); it; it = dfs_cache_get_next_tgt(&tl, it)) {
+		const char *share, *prefix;
+		size_t share_len, prefix_len;
+		bool target_match;
+
+		rc = dfs_cache_get_tgt_share(it, &share, &share_len, &prefix, &prefix_len);
+		if (rc) {
+			cifs_dbg(VFS, "%s: failed to parse target share %d\n",
+				 __func__, rc);
+			continue;
+		}
+
+		extract_unc_hostname(share, &dfs_host, &dfs_host_len);
+
+		if (dfs_host_len != tcp_host_len
+		    || strncasecmp(dfs_host, tcp_host, dfs_host_len) != 0) {
+			cifs_dbg(FYI, "%s: %.*s doesn't match %.*s\n", __func__, (int)dfs_host_len,
+				 dfs_host, (int)tcp_host_len, tcp_host);
+
+			rc = match_target_ip(server, dfs_host, dfs_host_len, &target_match);
+			if (rc) {
+				cifs_dbg(VFS, "%s: failed to match target ip: %d\n", __func__, rc);
+				break;
+			}
+
+			if (!target_match) {
+				cifs_dbg(FYI, "%s: skipping target\n", __func__);
+				continue;
+			}
+		}
+
+		if (tcon->ipc) {
+			scnprintf(tree, MAX_TREE_SIZE, "\\\\%s\\IPC$", share);
+			rc = ops->tree_connect(xid, tcon->ses, tree, tcon, nlsc);
+		} else {
+			scnprintf(tree, MAX_TREE_SIZE, "\\%s", share);
+			rc = ops->tree_connect(xid, tcon->ses, tree, tcon, nlsc);
+			if (!rc) {
+				rc = update_super_prepath(tcon, prefix, prefix_len);
+				break;
+			}
+		}
+		if (rc == -EREMOTE)
+			break;
+	}
+
+	if (!rc) {
+		if (it)
+			rc = dfs_cache_noreq_update_tgthint(tcon->dfs_path + 1, it);
+		else
+			rc = -ENOENT;
+	}
+	dfs_cache_free_tgts(&tl);
+out:
+	kfree(tree);
+	return rc;
+}
+#else
+int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const struct nls_table *nlsc)
+{
+	const struct smb_version_operations *ops = tcon->ses->server->ops;
+
+	return ops->tree_connect(xid, tcon->ses, tcon->treeName, tcon, nlsc);
+}
+#endif
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 2f4cdd290c46..c03e5b79a969 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -152,117 +152,6 @@ smb2_hdr_assemble(struct smb2_sync_hdr *shdr, __le16 smb2_cmd,
 	return;
 }
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
-static int __smb2_reconnect(const struct nls_table *nlsc,
-			    struct cifs_tcon *tcon)
-{
-	int rc;
-	struct TCP_Server_Info *server = tcon->ses->server;
-	struct dfs_cache_tgt_list tl;
-	struct dfs_cache_tgt_iterator *it = NULL;
-	char *tree;
-	const char *tcp_host;
-	size_t tcp_host_len;
-	const char *dfs_host;
-	size_t dfs_host_len;
-
-	tree = kzalloc(MAX_TREE_SIZE, GFP_KERNEL);
-	if (!tree)
-		return -ENOMEM;
-
-	if (!tcon->dfs_path) {
-		if (tcon->ipc) {
-			scnprintf(tree, MAX_TREE_SIZE, "\\\\%s\\IPC$",
-				  server->hostname);
-			rc = SMB2_tcon(0, tcon->ses, tree, tcon, nlsc);
-		} else {
-			rc = SMB2_tcon(0, tcon->ses, tcon->treeName, tcon,
-				       nlsc);
-		}
-		goto out;
-	}
-
-	rc = dfs_cache_noreq_find(tcon->dfs_path + 1, NULL, &tl);
-	if (rc)
-		goto out;
-
-	extract_unc_hostname(server->hostname, &tcp_host, &tcp_host_len);
-
-	for (it = dfs_cache_get_tgt_iterator(&tl); it;
-	     it = dfs_cache_get_next_tgt(&tl, it)) {
-		const char *share, *prefix;
-		size_t share_len, prefix_len;
-		bool target_match;
-
-		rc = dfs_cache_get_tgt_share(it, &share, &share_len, &prefix,
-					     &prefix_len);
-		if (rc) {
-			cifs_dbg(VFS, "%s: failed to parse target share %d\n",
-				 __func__, rc);
-			continue;
-		}
-
-		extract_unc_hostname(share, &dfs_host, &dfs_host_len);
-
-		if (dfs_host_len != tcp_host_len
-		    || strncasecmp(dfs_host, tcp_host, dfs_host_len) != 0) {
-			cifs_dbg(FYI, "%s: %.*s doesn't match %.*s\n",
-				 __func__,
-				 (int)dfs_host_len, dfs_host,
-				 (int)tcp_host_len, tcp_host);
-
-			rc = match_target_ip(server, dfs_host, dfs_host_len,
-					     &target_match);
-			if (rc) {
-				cifs_dbg(VFS, "%s: failed to match target ip: %d\n",
-					 __func__, rc);
-				break;
-			}
-
-			if (!target_match) {
-				cifs_dbg(FYI, "%s: skipping target\n", __func__);
-				continue;
-			}
-		}
-
-		if (tcon->ipc) {
-			scnprintf(tree, MAX_TREE_SIZE, "\\\\%.*s\\IPC$",
-				  (int)share_len, share);
-			rc = SMB2_tcon(0, tcon->ses, tree, tcon, nlsc);
-		} else {
-			scnprintf(tree, MAX_TREE_SIZE, "\\%.*s", (int)share_len,
-				  share);
-			rc = SMB2_tcon(0, tcon->ses, tree, tcon, nlsc);
-			if (!rc) {
-				rc = update_super_prepath(tcon, prefix,
-							  prefix_len);
-				break;
-			}
-		}
-		if (rc == -EREMOTE)
-			break;
-	}
-
-	if (!rc) {
-		if (it)
-			rc = dfs_cache_noreq_update_tgthint(tcon->dfs_path + 1,
-							    it);
-		else
-			rc = -ENOENT;
-	}
-	dfs_cache_free_tgts(&tl);
-out:
-	kfree(tree);
-	return rc;
-}
-#else
-static inline int __smb2_reconnect(const struct nls_table *nlsc,
-				   struct cifs_tcon *tcon)
-{
-	return SMB2_tcon(0, tcon->ses, tcon->treeName, tcon, nlsc);
-}
-#endif
-
 static int
 smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	       struct TCP_Server_Info *server)
@@ -409,7 +298,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon,
 	if (tcon->use_persistent)
 		tcon->need_reopen_files = true;
 
-	rc = __smb2_reconnect(nls_codepage, tcon);
+	rc = cifs_tree_connect(0, tcon, nls_codepage);
 	mutex_unlock(&tcon->ses->session_mutex);
 
 	cifs_dbg(FYI, "reconnect tcon rc = %d\n", rc);
-- 
2.27.0

