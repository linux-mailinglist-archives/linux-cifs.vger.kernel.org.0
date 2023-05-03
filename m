Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627826F6138
	for <lists+linux-cifs@lfdr.de>; Thu,  4 May 2023 00:22:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229459AbjECWWD (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 3 May 2023 18:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjECWWC (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 3 May 2023 18:22:02 -0400
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90A587D8E;
        Wed,  3 May 2023 15:21:58 -0700 (PDT)
From:   Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1683152517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ep9s90pSLXshI0xZy/YXg0rPz4K8PKNb6ZVynztGc7Y=;
        b=eYfI4p9Z+W3IvqQkxdbmGniLvwF/bRDnCzeOGgA4JH+VbKvBAtx3DCla1WoCVcCZWDthmb
        IgGnhDaK8iwp+mxpGdPSnuIQU/RRQKJ5lIKLENVLP+/dx1dUrvK06BIpWmSPhWekpy/YcY
        cymE8I5YmLEd5ixebUAbGO+zY7No8T3Gn4GufSx3Ecm+sYgD3VkIqi6i+2VpTUP+/4mYlS
        kw50nuLCzbgnm/z97tYsKONvyRqaU4f4hOJ/m2BxG2zFeGLd0ncBpmk/v5dI4RdnEJDxzE
        oDUzWBESsDk5X2FoeaInM5RVuT6Ry+iKIA1D+jJ4udW6VARSjblmNerACZTHgw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1683152517;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ep9s90pSLXshI0xZy/YXg0rPz4K8PKNb6ZVynztGc7Y=;
        b=ehpYLsbCemv4I968WgGIjvI1TzPGG44R7TZHrBLQkowEsILinqT49FcGx1pe2k+lgLpd1T
        /z4beNNd4S8NjlkmrvGk73uvg1GjcXrUl/MjuPpFrd30nwb5Js8/NZVfMqPXZzSZtZny2f
        IYU0dN5EYc40/8Bq1zHU8zjFHW689OlOSboNvpC1m3XRBJr/Pqr5ER9oKMgVKbMWddV39E
        pNe/yIdWSHOouwvOiaNwvwb7lLLGAFCoP2zgeRlCb/J+qkbTafvulJXvb+P5c7iKgSydyC
        RPXzGaEVjQ8DauIROEcTAZ7VnI67gdkK2260bWKeOO36ShRGdQAiZAiNi3K53A==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1683152517; a=rsa-sha256;
        cv=none;
        b=Tn1gAVEKkGDqzJmclaD2NwMKGDf1yg0g6xhOvCKjZ7BCRgWkcYsf4kDSN8yqlZgtcSCAXY
        F+bAF9R8+A8oPb4GnFZmhf9PDRFzPJFqUsEiGejZVMDlcBvn22sepptBK6GB8v96cVQjv5
        boWI5AEezdjj8XKkzdlhOAc7XlyNoMAqDM1zeUFCl2iCGytisH8/AId5pGBrjnlueaRsqT
        S8784X6RvdHb4ZIiWazmqZ0I+De2pTruh8jVwcQj7Iu9LOyJMA8mvGliJ3OW2lRGYCiz/H
        zQy2qssceUpibtTZpLeBugymDyBCYZpJg5fXJQdnfH6xscdc3rmWfarbML99yA==
To:     smfrench@gmail.com
Cc:     linux-cifs@vger.kernel.org, Paulo Alcantara <pc@manguebit.com>,
        stable@vger.kernel.org
Subject: [PATCH 7/7] cifs: fix sharing of DFS connections
Date:   Wed,  3 May 2023 19:21:17 -0300
Message-Id: <20230503222117.7609-8-pc@manguebit.com>
In-Reply-To: <20230503222117.7609-1-pc@manguebit.com>
References: <20230503222117.7609-1-pc@manguebit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

When matching DFS connections, we can't rely on the values set in
cifs_sb_info::prepath and cifs_tcon::tree_name as they might change
during DFS failover.  The DFS referrals related to a specific DFS tcon
are already matched earlier in match_server(), therefore we can safely
skip those checks altogether as the connection is guaranteed to be
unique for the DFS tcon.

Besides, when creating or finding an SMB session, make sure to also
refcount any DFS root session related to it (cifs_ses::dfs_root_ses),
so if a new DFS mount ends up reusing the connection from the old
mount while there was an umount(2) still in progress (e.g. umount(2)
-> cifs_umount() -> reconnect -> cifs_put_tcon()), the connection
could potentially be put right after the umount(2) finished.

Cc: stable@vger.kernel.org # v6.2+
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
---
 fs/cifs/cifsglob.h  |   1 -
 fs/cifs/cifsproto.h |  44 ++++++++++++++++-
 fs/cifs/connect.c   | 118 +++++++++++++++++++++++---------------------
 fs/cifs/dfs.c       |  62 ++++++++++++++++-------
 fs/cifs/ioctl.c     |   2 +-
 fs/cifs/smb2pdu.c   |   4 +-
 6 files changed, 150 insertions(+), 81 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 9c5cd332ce14..414685c5d530 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1756,7 +1756,6 @@ struct cifs_mount_ctx {
 	struct TCP_Server_Info *server;
 	struct cifs_ses *ses;
 	struct cifs_tcon *tcon;
-	char *origin_fullpath, *leaf_fullpath;
 	struct list_head dfs_ses_list;
 };
 
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index e2eff66eefab..c1c704990b98 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -8,6 +8,7 @@
 #ifndef _CIFSPROTO_H
 #define _CIFSPROTO_H
 #include <linux/nls.h>
+#include <linux/ctype.h>
 #include "trace.h"
 #ifdef CONFIG_CIFS_DFS_UPCALL
 #include "dfs_cache.h"
@@ -572,7 +573,7 @@ extern int E_md4hash(const unsigned char *passwd, unsigned char *p16,
 extern struct TCP_Server_Info *
 cifs_find_tcp_session(struct smb3_fs_context *ctx);
 
-extern void cifs_put_smb_ses(struct cifs_ses *ses);
+void __cifs_put_smb_ses(struct cifs_ses *ses);
 
 extern struct cifs_ses *
 cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx);
@@ -696,4 +697,45 @@ struct super_block *cifs_get_tcon_super(struct cifs_tcon *tcon);
 void cifs_put_tcon_super(struct super_block *sb);
 int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server, bool retry);
 
+/* Put references of @ses and @ses->dfs_root_ses */
+static inline void cifs_put_smb_ses(struct cifs_ses *ses)
+{
+	struct cifs_ses *rses = ses->dfs_root_ses;
+
+	__cifs_put_smb_ses(ses);
+	if (rses)
+		__cifs_put_smb_ses(rses);
+}
+
+/* Get an active reference of @ses and @ses->dfs_root_ses.
+ *
+ * NOTE: make sure to call this function when incrementing reference count of
+ * @ses to ensure that any DFS root session attached to it (@ses->dfs_root_ses)
+ * will also get its reference count incremented.
+ *
+ * cifs_put_smb_ses() will put both references, so call it when you're done.
+ */
+static inline void cifs_smb_ses_inc_refcount(struct cifs_ses *ses)
+{
+	lockdep_assert_held(&cifs_tcp_ses_lock);
+
+	ses->ses_count++;
+	if (ses->dfs_root_ses)
+		ses->dfs_root_ses->ses_count++;
+}
+
+static inline bool dfs_src_pathname_equal(const char *s1, const char *s2)
+{
+	if (strlen(s1) != strlen(s2))
+		return false;
+	for (; *s1; s1++, s2++) {
+		if (*s1 == '/' || *s1 == '\\') {
+			if (*s2 != '/' && *s2 != '\\')
+				return false;
+		} else if (tolower(*s1) != tolower(*s2))
+			return false;
+	}
+	return true;
+}
+
 #endif			/* _CIFSPROTO_H */
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 71966db89b6a..9a9d1b561175 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -996,10 +996,8 @@ static void clean_demultiplex_info(struct TCP_Server_Info *server)
 		 */
 	}
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
 	kfree(server->origin_fullpath);
 	kfree(server->leaf_fullpath);
-#endif
 	kfree(server);
 
 	length = atomic_dec_return(&tcpSesAllocCount);
@@ -1387,23 +1385,8 @@ match_security(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 	return true;
 }
 
-static bool dfs_src_pathname_equal(const char *s1, const char *s2)
-{
-	if (strlen(s1) != strlen(s2))
-		return false;
-	for (; *s1; s1++, s2++) {
-		if (*s1 == '/' || *s1 == '\\') {
-			if (*s2 != '/' && *s2 != '\\')
-				return false;
-		} else if (tolower(*s1) != tolower(*s2))
-			return false;
-	}
-	return true;
-}
-
 /* this function must be called with srv_lock held */
-static int match_server(struct TCP_Server_Info *server, struct smb3_fs_context *ctx,
-			bool dfs_super_cmp)
+static int match_server(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 {
 	struct sockaddr *addr = (struct sockaddr *)&ctx->dstaddr;
 
@@ -1434,27 +1417,41 @@ static int match_server(struct TCP_Server_Info *server, struct smb3_fs_context *
 			       (struct sockaddr *)&server->srcaddr))
 		return 0;
 	/*
-	 * When matching DFS superblocks, we only check for original source pathname as the
-	 * currently connected target might be different than the one parsed earlier in i.e.
-	 * mount.cifs(8).
+	 * - Match for an DFS tcon (@server->origin_fullpath).
+	 * - Match for an DFS root server connection (@server->leaf_fullpath).
+	 * - If none of the above and @ctx->leaf_fullpath is set, then
+	 *   it is a new DFS connection.
+	 * - If 'nodfs' mount option was passed, then match only connections
+	 *   that have no DFS referrals set
+	 *   (e.g. can't failover to other targets).
 	 */
-	if (dfs_super_cmp) {
-		if (!ctx->source || !server->origin_fullpath ||
-		    !dfs_src_pathname_equal(server->origin_fullpath, ctx->source))
-			return 0;
-	} else {
-		/* Skip addr, hostname and port matching for DFS connections */
-		if (server->leaf_fullpath) {
+	if (!ctx->nodfs) {
+		if (ctx->source && server->origin_fullpath) {
+			if (!dfs_src_pathname_equal(ctx->source,
+						    server->origin_fullpath))
+				return 0;
+		} else if (server->leaf_fullpath) {
 			if (!ctx->leaf_fullpath ||
-			    strcasecmp(server->leaf_fullpath, ctx->leaf_fullpath))
+			    strcasecmp(server->leaf_fullpath,
+				       ctx->leaf_fullpath))
 				return 0;
-		} else if (strcasecmp(server->hostname, ctx->server_hostname) ||
-			   !match_server_address(server, addr) ||
-			   !match_port(server, addr)) {
+		} else if (ctx->leaf_fullpath) {
 			return 0;
 		}
+	} else if (server->origin_fullpath || server->leaf_fullpath) {
+		return 0;
 	}
 
+	/*
+	 * Match for a regular connection (address/hostname/port) which has no
+	 * DFS referrals set.
+	 */
+	if (!server->origin_fullpath && !server->leaf_fullpath &&
+	    (strcasecmp(server->hostname, ctx->server_hostname) ||
+	     !match_server_address(server, addr) ||
+	     !match_port(server, addr)))
+		return 0;
+
 	if (!match_security(server, ctx))
 		return 0;
 
@@ -1485,7 +1482,7 @@ cifs_find_tcp_session(struct smb3_fs_context *ctx)
 		 * Skip ses channels since they're only handled in lower layers
 		 * (e.g. cifs_send_recv).
 		 */
-		if (CIFS_SERVER_IS_CHAN(server) || !match_server(server, ctx, false)) {
+		if (CIFS_SERVER_IS_CHAN(server) || !match_server(server, ctx)) {
 			spin_unlock(&server->srv_lock);
 			continue;
 		}
@@ -1869,7 +1866,7 @@ cifs_free_ipc(struct cifs_ses *ses)
 static struct cifs_ses *
 cifs_find_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 {
-	struct cifs_ses *ses;
+	struct cifs_ses *ses, *ret = NULL;
 
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(ses, &server->smb_ses_list, smb_ses_list) {
@@ -1879,23 +1876,22 @@ cifs_find_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 			continue;
 		}
 		spin_lock(&ses->chan_lock);
-		if (!match_session(ses, ctx)) {
+		if (match_session(ses, ctx)) {
 			spin_unlock(&ses->chan_lock);
 			spin_unlock(&ses->ses_lock);
-			continue;
+			ret = ses;
+			break;
 		}
 		spin_unlock(&ses->chan_lock);
 		spin_unlock(&ses->ses_lock);
-
-		++ses->ses_count;
-		spin_unlock(&cifs_tcp_ses_lock);
-		return ses;
 	}
+	if (ret)
+		cifs_smb_ses_inc_refcount(ret);
 	spin_unlock(&cifs_tcp_ses_lock);
-	return NULL;
+	return ret;
 }
 
-void cifs_put_smb_ses(struct cifs_ses *ses)
+void __cifs_put_smb_ses(struct cifs_ses *ses)
 {
 	unsigned int rc, xid;
 	unsigned int chan_count;
@@ -2246,6 +2242,8 @@ cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 	 */
 	spin_lock(&cifs_tcp_ses_lock);
 	ses->dfs_root_ses = ctx->dfs_root_ses;
+	if (ses->dfs_root_ses)
+		ses->dfs_root_ses->ses_count++;
 	list_add(&ses->smb_ses_list, &server->smb_ses_list);
 	spin_unlock(&cifs_tcp_ses_lock);
 
@@ -2262,12 +2260,15 @@ cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 }
 
 /* this function must be called with tc_lock held */
-static int match_tcon(struct cifs_tcon *tcon, struct smb3_fs_context *ctx, bool dfs_super_cmp)
+static int match_tcon(struct cifs_tcon *tcon, struct smb3_fs_context *ctx)
 {
+	struct TCP_Server_Info *server = tcon->ses->server;
+
 	if (tcon->status == TID_EXITING)
 		return 0;
-	/* Skip UNC validation when matching DFS superblocks */
-	if (!dfs_super_cmp && strncmp(tcon->tree_name, ctx->UNC, MAX_TREE_SIZE))
+	/* Skip UNC validation when matching DFS connections or superblocks */
+	if (!server->origin_fullpath && !server->leaf_fullpath &&
+	    strncmp(tcon->tree_name, ctx->UNC, MAX_TREE_SIZE))
 		return 0;
 	if (tcon->seal != ctx->seal)
 		return 0;
@@ -2290,7 +2291,7 @@ cifs_find_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(tcon, &ses->tcon_list, tcon_list) {
 		spin_lock(&tcon->tc_lock);
-		if (!match_tcon(tcon, ctx, false)) {
+		if (!match_tcon(tcon, ctx)) {
 			spin_unlock(&tcon->tc_lock);
 			continue;
 		}
@@ -2306,8 +2307,9 @@ cifs_find_tcon(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 void
 cifs_put_tcon(struct cifs_tcon *tcon)
 {
-	unsigned int xid;
+	struct TCP_Server_Info *server;
 	struct cifs_ses *ses;
+	unsigned int xid;
 
 	/*
 	 * IPC tcon share the lifetime of their session and are
@@ -2317,6 +2319,7 @@ cifs_put_tcon(struct cifs_tcon *tcon)
 		return;
 
 	ses = tcon->ses;
+	server = ses->server;
 	cifs_dbg(FYI, "%s: tc_count=%d\n", __func__, tcon->tc_count);
 	spin_lock(&cifs_tcp_ses_lock);
 	spin_lock(&tcon->tc_lock);
@@ -2666,9 +2669,11 @@ compare_mount_options(struct super_block *sb, struct cifs_mnt_data *mnt_data)
 	return 1;
 }
 
-static int
-match_prepath(struct super_block *sb, struct cifs_mnt_data *mnt_data)
+static int match_prepath(struct super_block *sb,
+			 struct TCP_Server_Info *server,
+			 struct cifs_mnt_data *mnt_data)
 {
+	struct smb3_fs_context *ctx = mnt_data->ctx;
 	struct cifs_sb_info *old = CIFS_SB(sb);
 	struct cifs_sb_info *new = mnt_data->cifs_sb;
 	bool old_set = (old->mnt_cifs_flags & CIFS_MOUNT_USE_PREFIX_PATH) &&
@@ -2676,6 +2681,10 @@ match_prepath(struct super_block *sb, struct cifs_mnt_data *mnt_data)
 	bool new_set = (new->mnt_cifs_flags & CIFS_MOUNT_USE_PREFIX_PATH) &&
 		new->prepath;
 
+	if (server->origin_fullpath &&
+	    dfs_src_pathname_equal(server->origin_fullpath, ctx->source))
+		return 1;
+
 	if (old_set && new_set && !strcmp(new->prepath, old->prepath))
 		return 1;
 	else if (!old_set && !new_set)
@@ -2694,7 +2703,6 @@ cifs_match_super(struct super_block *sb, void *data)
 	struct cifs_ses *ses;
 	struct cifs_tcon *tcon;
 	struct tcon_link *tlink;
-	bool dfs_super_cmp;
 	int rc = 0;
 
 	spin_lock(&cifs_tcp_ses_lock);
@@ -2709,18 +2717,16 @@ cifs_match_super(struct super_block *sb, void *data)
 	ses = tcon->ses;
 	tcp_srv = ses->server;
 
-	dfs_super_cmp = IS_ENABLED(CONFIG_CIFS_DFS_UPCALL) && tcp_srv->origin_fullpath;
-
 	ctx = mnt_data->ctx;
 
 	spin_lock(&tcp_srv->srv_lock);
 	spin_lock(&ses->ses_lock);
 	spin_lock(&ses->chan_lock);
 	spin_lock(&tcon->tc_lock);
-	if (!match_server(tcp_srv, ctx, dfs_super_cmp) ||
+	if (!match_server(tcp_srv, ctx) ||
 	    !match_session(ses, ctx) ||
-	    !match_tcon(tcon, ctx, dfs_super_cmp) ||
-	    !match_prepath(sb, mnt_data)) {
+	    !match_tcon(tcon, ctx) ||
+	    !match_prepath(sb, tcp_srv, mnt_data)) {
 		rc = 0;
 		goto out;
 	}
@@ -3465,8 +3471,6 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 
 error:
 	dfs_put_root_smb_sessions(&mnt_ctx.dfs_ses_list);
-	kfree(mnt_ctx.origin_fullpath);
-	kfree(mnt_ctx.leaf_fullpath);
 	cifs_mount_put_conns(&mnt_ctx);
 	return rc;
 }
diff --git a/fs/cifs/dfs.c b/fs/cifs/dfs.c
index da4e083b1ab4..a93dbca1411b 100644
--- a/fs/cifs/dfs.c
+++ b/fs/cifs/dfs.c
@@ -99,7 +99,7 @@ static int get_session(struct cifs_mount_ctx *mnt_ctx, const char *full_path)
 	return rc;
 }
 
-static int get_root_smb_session(struct cifs_mount_ctx *mnt_ctx)
+static int add_root_smb_session(struct cifs_mount_ctx *mnt_ctx)
 {
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
 	struct dfs_root_ses *root_ses;
@@ -127,7 +127,7 @@ static int get_dfs_conn(struct cifs_mount_ctx *mnt_ctx, const char *ref_path, co
 {
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
 	struct dfs_info3_param ref = {};
-	bool is_refsrv = false;
+	bool is_refsrv;
 	int rc, rc2;
 
 	rc = dfs_cache_get_tgt_referral(ref_path + 1, tit, &ref);
@@ -160,7 +160,7 @@ static int get_dfs_conn(struct cifs_mount_ctx *mnt_ctx, const char *ref_path, co
 	dfs_cache_noreq_update_tgthint(ref_path + 1, tit);
 
 	if (rc == -EREMOTE && is_refsrv) {
-		rc2 = get_root_smb_session(mnt_ctx);
+		rc2 = add_root_smb_session(mnt_ctx);
 		if (rc2)
 			rc = rc2;
 	}
@@ -277,15 +277,21 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 
 int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs)
 {
-	struct cifs_sb_info *cifs_sb = mnt_ctx->cifs_sb;
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
+	struct cifs_ses *ses;
+	char *source = ctx->source;
+	bool nodfs = ctx->nodfs;
 	int rc;
 
 	*isdfs = false;
-
+	/* Temporarily set @ctx->source to NULL as we're not matching DFS
+	 * superblocks yet.  See cifs_match_super() and match_server().
+	 */
+	ctx->source = NULL;
 	rc = get_session(mnt_ctx, NULL);
 	if (rc)
-		return rc;
+		goto out;
+
 	ctx->dfs_root_ses = mnt_ctx->ses;
 	/*
 	 * If called with 'nodfs' mount option, then skip DFS resolving.  Otherwise unconditionally
@@ -294,23 +300,41 @@ int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs)
 	 * Skip prefix path to provide support for DFS referrals from w2k8 servers which don't seem
 	 * to respond with PATH_NOT_COVERED to requests that include the prefix.
 	 */
-	if ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS) ||
-	    dfs_get_referral(mnt_ctx, ctx->UNC + 1, NULL, NULL)) {
+	if (!nodfs) {
+		rc = dfs_get_referral(mnt_ctx, ctx->UNC + 1, NULL, NULL);
+		if (rc) {
+			if (rc != -ENOENT && rc != -EOPNOTSUPP)
+				goto out;
+			nodfs = true;
+		}
+	}
+	if (nodfs) {
 		rc = cifs_mount_get_tcon(mnt_ctx);
-		if (rc)
-			return rc;
-
-		rc = cifs_is_path_remote(mnt_ctx);
-		if (!rc || rc != -EREMOTE)
-			return rc;
+		if (!rc)
+			rc = cifs_is_path_remote(mnt_ctx);
+		goto out;
 	}
 
 	*isdfs = true;
-	rc = get_root_smb_session(mnt_ctx);
-	if (rc)
-		return rc;
-
-	return __dfs_mount_share(mnt_ctx);
+	/*
+	 * Prevent DFS root session of being put in the first call to
+	 * cifs_mount_put_conns().  If another DFS root server was not found
+	 * while chasing the referrals (@ctx->dfs_root_ses == @ses), then we
+	 * can safely put extra refcount of @ses.
+	 */
+	ses = mnt_ctx->ses;
+	mnt_ctx->ses = NULL;
+	mnt_ctx->server = NULL;
+	rc = __dfs_mount_share(mnt_ctx);
+	if (ses == ctx->dfs_root_ses)
+		cifs_put_smb_ses(ses);
+out:
+	/*
+	 * Restore previous value of @ctx->source so DFS superblock can be
+	 * matched in cifs_match_super().
+	 */
+	ctx->source = source;
+	return rc;
 }
 
 /* Update dfs referral path of superblock */
diff --git a/fs/cifs/ioctl.c b/fs/cifs/ioctl.c
index 6419ec47c2a8..cb3be58cd55e 100644
--- a/fs/cifs/ioctl.c
+++ b/fs/cifs/ioctl.c
@@ -239,7 +239,7 @@ static int cifs_dump_full_key(struct cifs_tcon *tcon, struct smb3_full_key_debug
 					 * section, we need to make sure it won't be released
 					 * so increment its refcount
 					 */
-					ses->ses_count++;
+					cifs_smb_ses_inc_refcount(ses);
 					found = true;
 					goto search_end;
 				}
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 6a9661f3d324..d24118917610 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3856,7 +3856,7 @@ void smb2_reconnect_server(struct work_struct *work)
 		if (ses->tcon_ipc && ses->tcon_ipc->need_reconnect) {
 			list_add_tail(&ses->tcon_ipc->rlist, &tmp_list);
 			tcon_selected = tcon_exist = true;
-			ses->ses_count++;
+			cifs_smb_ses_inc_refcount(ses);
 		}
 		/*
 		 * handle the case where channel needs to reconnect
@@ -3867,7 +3867,7 @@ void smb2_reconnect_server(struct work_struct *work)
 		if (!tcon_selected && cifs_chan_needs_reconnect(ses, server)) {
 			list_add_tail(&ses->rlist, &tmp_ses_list);
 			ses_exist = true;
-			ses->ses_count++;
+			cifs_smb_ses_inc_refcount(ses);
 		}
 		spin_unlock(&ses->chan_lock);
 	}
-- 
2.40.1

