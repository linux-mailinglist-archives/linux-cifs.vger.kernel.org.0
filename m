Return-Path: <linux-cifs+bounces-1704-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2E2B28948E2
	for <lists+linux-cifs@lfdr.de>; Tue,  2 Apr 2024 03:44:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99B3B1F22F93
	for <lists+linux-cifs@lfdr.de>; Tue,  2 Apr 2024 01:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 683578F7D;
	Tue,  2 Apr 2024 01:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="AzUOUKpG"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF9B0945A
	for <linux-cifs@vger.kernel.org>; Tue,  2 Apr 2024 01:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=167.235.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712022277; cv=pass; b=faqP9ylJ4rU7r3mQM/qSjerA4rNVHCYfGYLgRRL4hKddq4hR8I42CZKPmnGm0pO7Xc5SrYtCNz4uCEKG++ay5kka8k0IaV0TtGObC+vNt1PNVq+25FNApiv8/ORnMzGdAkjJBrQ0Ac/dSQZquiCKH3CfeNI78ZIGI65EWTXY5Bc=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712022277; c=relaxed/simple;
	bh=yFeioWhzqmVIQtTy+/7fTui85gkfo2nWafODwWxMY7o=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sualRwoA+9vsIh5eBZOhbEJAzbVkyW3W7XWo2BPEwpe1WqLiRIMhxvhYr0wL+FGei9q1WJiMcH6U3He2eLmFPaZ9MEqZql6Kr5mxo0mpLyG85ZyCTaI8zqqeMaL79tQcn/mHCJmFXjQmY/XA604zUbWvaCmkvZKBH2qId1WBt8c=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=AzUOUKpG; arc=pass smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
From: Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1712022270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=DB5GM1Bv4ZnqikFsZsWbzaHlnmM+4rTeweB5ikWXuAk=;
	b=AzUOUKpGKkbVgxne0R1swKQLf8QaeiPUxM/lnVmG7cRl+1hP+ZXnOinlBKYKc+3zgV385Q
	pQ/kb01y2fLfkxcJ2VYCgstvfhWTs5MM1ClO3SvdGkFOB8DU8/2FKqyXRoS69YiJ9q5zz7
	Tf9aAH4IsB5e6JmE3T6XjfXZS+vUiDXe97d8fJ6+wiS9eEn1qDX06f4uy1BAYC6ZRUBxgu
	D6aUbBD3mDqniU6Ozv+hCOWqtI8RIaFoHH3nzd0OHYGC1/hbNsnQ2KreEWW9pn7V0SUkSH
	BwjOUiw9ELJ+63ZZg5zzOUr+0YwqXOeSgi0ndKcLQv2gauKQ4mzp9vuaZGBueQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1712022270; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=DB5GM1Bv4ZnqikFsZsWbzaHlnmM+4rTeweB5ikWXuAk=;
	b=rIs/NMYuSLMXFxW4G/DJz9OaBd1gJS6yTyRQBWmEVbEtAWO4ht17K8TQq44ZsbvDnlHDL0
	uMv9/1XNtyRTBwZxg9sgMGuYcfU7WwtH5dMcW7jXvxOdVM2OSCuhi22xXOS+KnxFilJrcp
	D++z649tOInqxkkkIXbkTUuMGMDx7/4UmLtKKnKG135IcnsM7DmuZb1VGyB1DXZfeAYD27
	qmcSvmGU4gcszpkPF6Kp6NlQ7XT7LfIMVs25AZeBI3/dkTphOz/2tHA+O42X5G3WyZqDAM
	EuXRuDeGkcjA9g+6lGDwP1Pf5EugCDBty7YEKGxI9vki4+fJERgE1AM0mkB3pA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1712022270; a=rsa-sha256;
	cv=none;
	b=gB5Xk/1Q5zpT6JApCMFpYCdO6eI4JlX12ka6h4MS7nITCwGwV+2r7RolXkax6YbzWF0JpU
	0yq5o3o1eHoSSrWw9xyEvsXaEhxB5jK7pBrLKaq8qIUF4ooRUeWy6FAxsf/fZ6kFE1y21y
	QjSCwl812FdJMZ3awLXzYIrTCw6lhNaPpa9Bv92uuqkDMLULPR6BNLmxVIyDfyL65lgoMh
	lgcgFiwYS8+QSJwUYmE0TCb3B5bx0k4nZjDD/xE9guBSR51v5UaBiQNk6hyLTKFcQEthl8
	6qyKYQx4fQWGh/ffEVvlOP1K+ChandbYfwSAkdP/RtMgY4/BedrnWTI9cVBF9g==
To: smfrench@gmail.com
Cc: linux-cifs@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 1/4] smb: client: guarantee refcounted children from parent session
Date: Mon,  1 Apr 2024 22:44:06 -0300
Message-ID: <20240402014409.145562-1-pc@manguebit.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Avoid potential use-after-free bugs when walking DFS referrals,
mounting and performing DFS failover by ensuring that all children
from parent @tcon->ses are also refcounted.  They're all needed across
the entire DFS mount.  Get rid of @tcon->dfs_ses_list while we're at
it, too.

Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
---
 fs/smb/client/cifsglob.h  |  2 --
 fs/smb/client/cifsproto.h | 20 +++++++--------
 fs/smb/client/connect.c   | 25 +++++++++++++++----
 fs/smb/client/dfs.c       | 51 ++++++++++++++++++---------------------
 fs/smb/client/dfs.h       | 33 ++++++++++++++++---------
 fs/smb/client/dfs_cache.c | 11 +--------
 fs/smb/client/misc.c      |  6 -----
 7 files changed, 76 insertions(+), 72 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 7ed9d05f6890..286afbe346be 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1281,7 +1281,6 @@ struct cifs_tcon {
 	struct cached_fids *cfids;
 	/* BB add field for back pointer to sb struct(s)? */
 #ifdef CONFIG_CIFS_DFS_UPCALL
-	struct list_head dfs_ses_list;
 	struct delayed_work dfs_cache_work;
 #endif
 	struct delayed_work	query_interfaces; /* query interfaces workqueue job */
@@ -1804,7 +1803,6 @@ struct cifs_mount_ctx {
 	struct TCP_Server_Info *server;
 	struct cifs_ses *ses;
 	struct cifs_tcon *tcon;
-	struct list_head dfs_ses_list;
 };
 
 static inline void __free_dfs_info_param(struct dfs_info3_param *param)
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 0723e1b57256..8e0a348f1f66 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -725,31 +725,31 @@ struct super_block *cifs_get_tcon_super(struct cifs_tcon *tcon);
 void cifs_put_tcon_super(struct super_block *sb);
 int cifs_wait_for_server_reconnect(struct TCP_Server_Info *server, bool retry);
 
-/* Put references of @ses and @ses->dfs_root_ses */
+/* Put references of @ses and its children */
 static inline void cifs_put_smb_ses(struct cifs_ses *ses)
 {
-	struct cifs_ses *rses = ses->dfs_root_ses;
+	struct cifs_ses *next;
 
-	__cifs_put_smb_ses(ses);
-	if (rses)
-		__cifs_put_smb_ses(rses);
+	do {
+		next = ses->dfs_root_ses;
+		__cifs_put_smb_ses(ses);
+	} while ((ses = next));
 }
 
-/* Get an active reference of @ses and @ses->dfs_root_ses.
+/* Get an active reference of @ses and its children.
  *
  * NOTE: make sure to call this function when incrementing reference count of
  * @ses to ensure that any DFS root session attached to it (@ses->dfs_root_ses)
  * will also get its reference count incremented.
  *
- * cifs_put_smb_ses() will put both references, so call it when you're done.
+ * cifs_put_smb_ses() will put all references, so call it when you're done.
  */
 static inline void cifs_smb_ses_inc_refcount(struct cifs_ses *ses)
 {
 	lockdep_assert_held(&cifs_tcp_ses_lock);
 
-	ses->ses_count++;
-	if (ses->dfs_root_ses)
-		ses->dfs_root_ses->ses_count++;
+	for (; ses; ses = ses->dfs_root_ses)
+		ses->ses_count++;
 }
 
 static inline bool dfs_src_pathname_equal(const char *s1, const char *s2)
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index ee29bc57300c..22d152cd24d1 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1866,6 +1866,9 @@ static int match_session(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 	    ctx->sectype != ses->sectype)
 		return 0;
 
+	if (ctx->dfs_root_ses != ses->dfs_root_ses)
+		return 0;
+
 	/*
 	 * If an existing session is limited to less channels than
 	 * requested, it should not be reused
@@ -2358,9 +2361,9 @@ cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 	 * need to lock before changing something in the session.
 	 */
 	spin_lock(&cifs_tcp_ses_lock);
+	if (ctx->dfs_root_ses)
+		cifs_smb_ses_inc_refcount(ctx->dfs_root_ses);
 	ses->dfs_root_ses = ctx->dfs_root_ses;
-	if (ses->dfs_root_ses)
-		ses->dfs_root_ses->ses_count++;
 	list_add(&ses->smb_ses_list, &server->smb_ses_list);
 	spin_unlock(&cifs_tcp_ses_lock);
 
@@ -3311,6 +3314,9 @@ void cifs_mount_put_conns(struct cifs_mount_ctx *mnt_ctx)
 		cifs_put_smb_ses(mnt_ctx->ses);
 	else if (mnt_ctx->server)
 		cifs_put_tcp_session(mnt_ctx->server, 0);
+	mnt_ctx->ses = NULL;
+	mnt_ctx->tcon = NULL;
+	mnt_ctx->server = NULL;
 	mnt_ctx->cifs_sb->mnt_cifs_flags &= ~CIFS_MOUNT_POSIX_PATHS;
 	free_xid(mnt_ctx->xid);
 }
@@ -3589,8 +3595,6 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 	bool isdfs;
 	int rc;
 
-	INIT_LIST_HEAD(&mnt_ctx.dfs_ses_list);
-
 	rc = dfs_mount_share(&mnt_ctx, &isdfs);
 	if (rc)
 		goto error;
@@ -3621,7 +3625,6 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 	return rc;
 
 error:
-	dfs_put_root_smb_sessions(&mnt_ctx.dfs_ses_list);
 	cifs_mount_put_conns(&mnt_ctx);
 	return rc;
 }
@@ -3636,6 +3639,18 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 		goto error;
 
 	rc = cifs_mount_get_tcon(&mnt_ctx);
+	if (!rc) {
+		/*
+		 * Prevent superblock from being created with any missing
+		 * connections.
+		 */
+		if (WARN_ON(!mnt_ctx->server))
+			rc = -EHOSTDOWN;
+		else if (WARN_ON(!mnt_ctx->ses))
+			rc = -EACCES;
+		else if (WARN_ON(!mnt_ctx->tcon))
+			rc = -ENOENT;
+	}
 	if (rc)
 		goto error;
 
diff --git a/fs/smb/client/dfs.c b/fs/smb/client/dfs.c
index 449c59830039..3ec965547e3d 100644
--- a/fs/smb/client/dfs.c
+++ b/fs/smb/client/dfs.c
@@ -66,33 +66,20 @@ static int get_session(struct cifs_mount_ctx *mnt_ctx, const char *full_path)
 }
 
 /*
- * Track individual DFS referral servers used by new DFS mount.
- *
- * On success, their lifetime will be shared by final tcon (dfs_ses_list).
- * Otherwise, they will be put by dfs_put_root_smb_sessions() in cifs_mount().
+ * Get an active reference of @ses so that next call to cifs_put_tcon() won't
+ * release it as any new DFS referrals must go through its IPC tcon.
  */
-static int add_root_smb_session(struct cifs_mount_ctx *mnt_ctx)
+static void add_root_smb_session(struct cifs_mount_ctx *mnt_ctx)
 {
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
-	struct dfs_root_ses *root_ses;
 	struct cifs_ses *ses = mnt_ctx->ses;
 
 	if (ses) {
-		root_ses = kmalloc(sizeof(*root_ses), GFP_KERNEL);
-		if (!root_ses)
-			return -ENOMEM;
-
-		INIT_LIST_HEAD(&root_ses->list);
-
 		spin_lock(&cifs_tcp_ses_lock);
 		cifs_smb_ses_inc_refcount(ses);
 		spin_unlock(&cifs_tcp_ses_lock);
-		root_ses->ses = ses;
-		list_add_tail(&root_ses->list, &mnt_ctx->dfs_ses_list);
 	}
-	/* Select new DFS referral server so that new referrals go through it */
 	ctx->dfs_root_ses = ses;
-	return 0;
 }
 
 static inline int parse_dfs_target(struct smb3_fs_context *ctx,
@@ -185,11 +172,8 @@ static int __dfs_referral_walk(struct cifs_mount_ctx *mnt_ctx,
 					continue;
 			}
 
-			if (is_refsrv) {
-				rc = add_root_smb_session(mnt_ctx);
-				if (rc)
-					goto out;
-			}
+			if (is_refsrv)
+				add_root_smb_session(mnt_ctx);
 
 			rc = ref_walk_advance(rw);
 			if (!rc) {
@@ -232,6 +216,7 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
 	struct cifs_tcon *tcon;
 	char *origin_fullpath;
+	bool new_tcon = true;
 	int rc;
 
 	origin_fullpath = dfs_get_path(cifs_sb, ctx->source);
@@ -239,6 +224,18 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 		return PTR_ERR(origin_fullpath);
 
 	rc = dfs_referral_walk(mnt_ctx);
+	if (!rc) {
+		/*
+		 * Prevent superblock from being created with any missing
+		 * connections.
+		 */
+		if (WARN_ON(!mnt_ctx->server))
+			rc = -EHOSTDOWN;
+		else if (WARN_ON(!mnt_ctx->ses))
+			rc = -EACCES;
+		else if (WARN_ON(!mnt_ctx->tcon))
+			rc = -ENOENT;
+	}
 	if (rc)
 		goto out;
 
@@ -247,15 +244,14 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 	if (!tcon->origin_fullpath) {
 		tcon->origin_fullpath = origin_fullpath;
 		origin_fullpath = NULL;
+	} else {
+		new_tcon = false;
 	}
 	spin_unlock(&tcon->tc_lock);
 
-	if (list_empty(&tcon->dfs_ses_list)) {
-		list_replace_init(&mnt_ctx->dfs_ses_list, &tcon->dfs_ses_list);
+	if (new_tcon) {
 		queue_delayed_work(dfscache_wq, &tcon->dfs_cache_work,
 				   dfs_cache_get_ttl() * HZ);
-	} else {
-		dfs_put_root_smb_sessions(&mnt_ctx->dfs_ses_list);
 	}
 
 out:
@@ -298,7 +294,6 @@ int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs)
 	if (rc)
 		return rc;
 
-	ctx->dfs_root_ses = mnt_ctx->ses;
 	/*
 	 * If called with 'nodfs' mount option, then skip DFS resolving.  Otherwise unconditionally
 	 * try to get an DFS referral (even cached) to determine whether it is an DFS mount.
@@ -324,7 +319,9 @@ int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs)
 
 	*isdfs = true;
 	add_root_smb_session(mnt_ctx);
-	return __dfs_mount_share(mnt_ctx);
+	rc = __dfs_mount_share(mnt_ctx);
+	dfs_put_root_smb_sessions(mnt_ctx);
+	return rc;
 }
 
 /* Update dfs referral path of superblock */
diff --git a/fs/smb/client/dfs.h b/fs/smb/client/dfs.h
index 875ab7ae57fc..e5c4dcf83750 100644
--- a/fs/smb/client/dfs.h
+++ b/fs/smb/client/dfs.h
@@ -7,7 +7,9 @@
 #define _CIFS_DFS_H
 
 #include "cifsglob.h"
+#include "cifsproto.h"
 #include "fs_context.h"
+#include "dfs_cache.h"
 #include "cifs_unicode.h"
 #include <linux/namei.h>
 
@@ -114,11 +116,6 @@ static inline void ref_walk_set_tgt_hint(struct dfs_ref_walk *rw)
 				       ref_walk_tit(rw));
 }
 
-struct dfs_root_ses {
-	struct list_head list;
-	struct cifs_ses *ses;
-};
-
 int dfs_parse_target_referral(const char *full_path, const struct dfs_info3_param *ref,
 			      struct smb3_fs_context *ctx);
 int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs);
@@ -133,20 +130,32 @@ static inline int dfs_get_referral(struct cifs_mount_ctx *mnt_ctx, const char *p
 {
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
 	struct cifs_sb_info *cifs_sb = mnt_ctx->cifs_sb;
+	struct cifs_ses *rses = ctx->dfs_root_ses ?: mnt_ctx->ses;
 
-	return dfs_cache_find(mnt_ctx->xid, ctx->dfs_root_ses, cifs_sb->local_nls,
+	return dfs_cache_find(mnt_ctx->xid, rses, cifs_sb->local_nls,
 			      cifs_remap(cifs_sb), path, ref, tl);
 }
 
-static inline void dfs_put_root_smb_sessions(struct list_head *head)
+/*
+ * cifs_get_smb_ses() already guarantees an active reference of
+ * @ses->dfs_root_ses when a new session is created, so we need to put extra
+ * references of all DFS root sessions that were used across the mount process
+ * in dfs_mount_share().
+ */
+static inline void dfs_put_root_smb_sessions(struct cifs_mount_ctx *mnt_ctx)
 {
-	struct dfs_root_ses *root, *tmp;
+	const struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
+	struct cifs_ses *ses = ctx->dfs_root_ses;
+	struct cifs_ses *cur;
 
-	list_for_each_entry_safe(root, tmp, head, list) {
-		list_del_init(&root->list);
-		cifs_put_smb_ses(root->ses);
-		kfree(root);
+	if (!ses)
+		return;
+
+	for (cur = ses; cur; cur = cur->dfs_root_ses) {
+		if (cur->dfs_root_ses)
+			cifs_put_smb_ses(cur->dfs_root_ses);
 	}
+	cifs_put_smb_ses(ses);
 }
 
 #endif /* _CIFS_DFS_H */
diff --git a/fs/smb/client/dfs_cache.c b/fs/smb/client/dfs_cache.c
index 508d831fabe3..0552a864ff08 100644
--- a/fs/smb/client/dfs_cache.c
+++ b/fs/smb/client/dfs_cache.c
@@ -1278,21 +1278,12 @@ int dfs_cache_remount_fs(struct cifs_sb_info *cifs_sb)
 void dfs_cache_refresh(struct work_struct *work)
 {
 	struct TCP_Server_Info *server;
-	struct dfs_root_ses *rses;
 	struct cifs_tcon *tcon;
 	struct cifs_ses *ses;
 
 	tcon = container_of(work, struct cifs_tcon, dfs_cache_work.work);
-	ses = tcon->ses;
-	server = ses->server;
 
-	mutex_lock(&server->refpath_lock);
-	if (server->leaf_fullpath)
-		__refresh_tcon(server->leaf_fullpath + 1, ses, false);
-	mutex_unlock(&server->refpath_lock);
-
-	list_for_each_entry(rses, &tcon->dfs_ses_list, list) {
-		ses = rses->ses;
+	for (ses = tcon->ses; ses; ses = ses->dfs_root_ses) {
 		server = ses->server;
 		mutex_lock(&server->refpath_lock);
 		if (server->leaf_fullpath)
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index c3771fc81328..1ea22b3955a2 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -138,9 +138,6 @@ tcon_info_alloc(bool dir_leases_enabled)
 	atomic_set(&ret_buf->num_local_opens, 0);
 	atomic_set(&ret_buf->num_remote_opens, 0);
 	ret_buf->stats_from_time = ktime_get_real_seconds();
-#ifdef CONFIG_CIFS_DFS_UPCALL
-	INIT_LIST_HEAD(&ret_buf->dfs_ses_list);
-#endif
 
 	return ret_buf;
 }
@@ -156,9 +153,6 @@ tconInfoFree(struct cifs_tcon *tcon)
 	atomic_dec(&tconInfoAllocCount);
 	kfree(tcon->nativeFileSystem);
 	kfree_sensitive(tcon->password);
-#ifdef CONFIG_CIFS_DFS_UPCALL
-	dfs_put_root_smb_sessions(&tcon->dfs_ses_list);
-#endif
 	kfree(tcon->origin_fullpath);
 	kfree(tcon);
 }
-- 
2.44.0


