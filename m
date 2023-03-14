Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09FA36BA38D
	for <lists+linux-cifs@lfdr.de>; Wed, 15 Mar 2023 00:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjCNXdM (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 14 Mar 2023 19:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjCNXdK (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 14 Mar 2023 19:33:10 -0400
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57A6523A5B
        for <linux-cifs@vger.kernel.org>; Tue, 14 Mar 2023 16:33:08 -0700 (PDT)
From:   Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1678836786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZ6RfcWY1tW2/no2bHJ+d2/n7VQ2xxPczS8o8hWeYDo=;
        b=RjKPrDPmV4dPotAj6Mer2QjvHXYfLV5Q61iwBraVORf0Rf90AGFeePICDlF6arSoQOepyx
        MkmXuiXcpxD26MdV7eA8yokkLzNkiZCYfSSfDxez+a6FVQLcRPHVbt+vSl0v/fVR84kn1C
        sYJxlESkdeVwsU7HB8pgO81JhnnXfKng4yePCFnKOyUf3QAc76tycGWQkKKjYYdVQDhCoW
        5wzmRiuTVHfd9trPMxuQyxeJ5cyPRqoIGSGZBz7WJtn5UCQqfZHPQHnYhs2oWV6U/X/bPe
        XIuJmlgXdBm5Ot5hEw28z5wqJLhTBnL2h/CoyaNcjLvvujfIsdx9G6Y53+JYFA==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1678836786; a=rsa-sha256;
        cv=none;
        b=A7eERzfySBIQd50xMFtsde+9MTCO6ub7U62jyQ5XNcT5nr/vhcoOk7aS8Bqixl3FYg1dIX
        Z/2HSUTNd+77eYES14hm1AUbGvHJZIcG+GQRX5CHPdHoVDlyK5yDk5zEWW1kou/l9UWwWp
        Kve2MTI7DY7rEjSzbqYBp3bbYjs9XV05ptHkOSjjLPZcYGl3q/olavC1IbjmrxPFzZn5CG
        3vn1XXRg08o97VhunNcQ9lrx9ZmbMLHKOPFIK3TEvXGXsK4fg9geP9d30RaFw40XW5/EFF
        3TnOvrs00/ihMcaElYDb/+m3zxW26jHL4/L7Eh/IBRgMPJEGxMUh/OseVUK0pA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1678836786;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AZ6RfcWY1tW2/no2bHJ+d2/n7VQ2xxPczS8o8hWeYDo=;
        b=iMeT/HgRqwqyvmEKcA9PPnwHafH88kD62nvLxoUzXrYe+mDZxrmwb+bclwtg7cy/rfwtqV
        7nFkuJAjUFPT20zKVJVgCUUOoxxBSJf3fysKYY1HDDbkdbOGn2uz2czdrkrDulYXczC2Re
        KzQ5MLLCRJZjRxbozddTgVwz57hFbAVylzOMFmppltbW9mlfxiIfa8onOjfVQFADhL27h9
        rduLWS4drX/nSki231/wrqGK9Uyt1NIfcDeZBXBrAeguC8w19+QIqaV/xt3gQkhBl93IZc
        I/RzthEZubXSjkmqTiqjfkgj0j06jBlkHbAZBe//OGX8TkEmfn/lVmRHEDS27A==
To:     smfrench@gmail.com
Cc:     linux-cifs@vger.kernel.org, Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 2/4] cifs: fix use-after-free bug in refresh_cache_worker()
Date:   Tue, 14 Mar 2023 20:32:54 -0300
Message-Id: <20230314233256.16468-2-pc.crab@mail.manguebit.com>
In-Reply-To: <20230314233256.16468-1-pc@manguebit.com>
References: <20230314233256.16468-1-pc@manguebit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The UAF bug occurred because we were putting DFS root sessions in
cifs_umount() while DFS cache refresher was being executed.

Make DFS root sessions have same lifetime as DFS tcons so we can avoid
the use-after-free bug is DFS cache refresher and other places that
require IPCs to get new DFS referrals on.  Also, get rid of mount
group handling in DFS cache as we no longer need it.

This fixes below use-after-free bug catched by KASAN

[ 379.946955] BUG: KASAN: use-after-free in __refresh_tcon.isra.0+0x10b/0xc10 [cifs]
[ 379.947642] Read of size 8 at addr ffff888018f57030 by task kworker/u4:3/56
[ 379.948096]
[ 379.948208] CPU: 0 PID: 56 Comm: kworker/u4:3 Not tainted 6.2.0-rc7-lku #23
[ 379.948661] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
rel-1.16.0-0-gd239552-rebuilt.opensuse.org 04/01/2014
[ 379.949368] Workqueue: cifs-dfscache refresh_cache_worker [cifs]
[ 379.949942] Call Trace:
[ 379.950113] <TASK>
[ 379.950260] dump_stack_lvl+0x50/0x67
[ 379.950510] print_report+0x16a/0x48e
[ 379.950759] ? __virt_addr_valid+0xd8/0x160
[ 379.951040] ? __phys_addr+0x41/0x80
[ 379.951285] kasan_report+0xdb/0x110
[ 379.951533] ? __refresh_tcon.isra.0+0x10b/0xc10 [cifs]
[ 379.952056] ? __refresh_tcon.isra.0+0x10b/0xc10 [cifs]
[ 379.952585] __refresh_tcon.isra.0+0x10b/0xc10 [cifs]
[ 379.953096] ? __pfx___refresh_tcon.isra.0+0x10/0x10 [cifs]
[ 379.953637] ? __pfx___mutex_lock+0x10/0x10
[ 379.953915] ? lock_release+0xb6/0x720
[ 379.954167] ? __pfx_lock_acquire+0x10/0x10
[ 379.954443] ? refresh_cache_worker+0x34e/0x6d0 [cifs]
[ 379.954960] ? __pfx_wb_workfn+0x10/0x10
[ 379.955239] refresh_cache_worker+0x4ad/0x6d0 [cifs]
[ 379.955755] ? __pfx_refresh_cache_worker+0x10/0x10 [cifs]
[ 379.956323] ? __pfx_lock_acquired+0x10/0x10
[ 379.956615] ? read_word_at_a_time+0xe/0x20
[ 379.956898] ? lockdep_hardirqs_on_prepare+0x12/0x220
[ 379.957235] process_one_work+0x535/0x990
[ 379.957509] ? __pfx_process_one_work+0x10/0x10
[ 379.957812] ? lock_acquired+0xb7/0x5f0
[ 379.958069] ? __list_add_valid+0x37/0xd0
[ 379.958341] ? __list_add_valid+0x37/0xd0
[ 379.958611] worker_thread+0x8e/0x630
[ 379.958861] ? __pfx_worker_thread+0x10/0x10
[ 379.959148] kthread+0x17d/0x1b0
[ 379.959369] ? __pfx_kthread+0x10/0x10
[ 379.959630] ret_from_fork+0x2c/0x50
[ 379.959879] </TASK>

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
---
 fs/cifs/cifs_fs_sb.h |   2 -
 fs/cifs/cifsglob.h   |   3 +-
 fs/cifs/connect.c    |   9 +--
 fs/cifs/dfs.c        |  52 ++++++++++++----
 fs/cifs/dfs.h        |  16 +++++
 fs/cifs/dfs_cache.c  | 140 -------------------------------------------
 fs/cifs/dfs_cache.h  |   2 -
 fs/cifs/misc.c       |   7 +++
 8 files changed, 67 insertions(+), 164 deletions(-)

diff --git a/fs/cifs/cifs_fs_sb.h b/fs/cifs/cifs_fs_sb.h
index 013a4bd65280..651759192280 100644
--- a/fs/cifs/cifs_fs_sb.h
+++ b/fs/cifs/cifs_fs_sb.h
@@ -61,8 +61,6 @@ struct cifs_sb_info {
 	/* only used when CIFS_MOUNT_USE_PREFIX_PATH is set */
 	char *prepath;
 
-	/* randomly generated 128-bit number for indexing dfs mount groups in referral cache */
-	uuid_t dfs_mount_id;
 	/*
 	 * Indicate whether serverino option was turned off later
 	 * (cifs_autodisable_serverino) in order to match new mounts.
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index a6f3e03e5790..9da301d18491 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1233,6 +1233,7 @@ struct cifs_tcon {
 	/* BB add field for back pointer to sb struct(s)? */
 #ifdef CONFIG_CIFS_DFS_UPCALL
 	struct list_head ulist; /* cache update list */
+	struct list_head dfs_ses_list;
 #endif
 	struct delayed_work	query_interfaces; /* query interfaces workqueue job */
 };
@@ -1749,8 +1750,8 @@ struct cifs_mount_ctx {
 	struct TCP_Server_Info *server;
 	struct cifs_ses *ses;
 	struct cifs_tcon *tcon;
-	uuid_t mount_id;
 	char *origin_fullpath, *leaf_fullpath;
+	struct list_head dfs_ses_list;
 };
 
 static inline void free_dfs_info_param(struct dfs_info3_param *param)
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 5038dcd045b9..a356c8c2fae0 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -3408,7 +3408,8 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 	bool isdfs;
 	int rc;
 
-	uuid_gen(&mnt_ctx.mount_id);
+	INIT_LIST_HEAD(&mnt_ctx.dfs_ses_list);
+
 	rc = dfs_mount_share(&mnt_ctx, &isdfs);
 	if (rc)
 		goto error;
@@ -3428,7 +3429,6 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 	kfree(cifs_sb->prepath);
 	cifs_sb->prepath = ctx->prepath;
 	ctx->prepath = NULL;
-	uuid_copy(&cifs_sb->dfs_mount_id, &mnt_ctx.mount_id);
 
 out:
 	cifs_try_adding_channels(cifs_sb, mnt_ctx.ses);
@@ -3440,7 +3440,7 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 	return rc;
 
 error:
-	dfs_cache_put_refsrv_sessions(&mnt_ctx.mount_id);
+	dfs_put_root_smb_sessions(&mnt_ctx.dfs_ses_list);
 	kfree(mnt_ctx.origin_fullpath);
 	kfree(mnt_ctx.leaf_fullpath);
 	cifs_mount_put_conns(&mnt_ctx);
@@ -3638,9 +3638,6 @@ cifs_umount(struct cifs_sb_info *cifs_sb)
 	spin_unlock(&cifs_sb->tlink_tree_lock);
 
 	kfree(cifs_sb->prepath);
-#ifdef CONFIG_CIFS_DFS_UPCALL
-	dfs_cache_put_refsrv_sessions(&cifs_sb->dfs_mount_id);
-#endif
 	call_rcu(&cifs_sb->rcu, delayed_free);
 }
 
diff --git a/fs/cifs/dfs.c b/fs/cifs/dfs.c
index eb35259b48fa..fc86de9ebea7 100644
--- a/fs/cifs/dfs.c
+++ b/fs/cifs/dfs.c
@@ -99,18 +99,27 @@ static int get_session(struct cifs_mount_ctx *mnt_ctx, const char *full_path)
 	return rc;
 }
 
-static void set_root_ses(struct cifs_mount_ctx *mnt_ctx)
+static int get_root_smb_session(struct cifs_mount_ctx *mnt_ctx)
 {
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
+	struct dfs_root_ses *root_ses;
 	struct cifs_ses *ses = mnt_ctx->ses;
 
 	if (ses) {
+		root_ses = kmalloc(sizeof(*root_ses), GFP_KERNEL);
+		if (!root_ses)
+			return -ENOMEM;
+
+		INIT_LIST_HEAD(&root_ses->list);
+
 		spin_lock(&cifs_tcp_ses_lock);
 		ses->ses_count++;
 		spin_unlock(&cifs_tcp_ses_lock);
-		dfs_cache_add_refsrv_session(&mnt_ctx->mount_id, ses);
+		root_ses->ses = ses;
+		list_add_tail(&root_ses->list, &mnt_ctx->dfs_ses_list);
 	}
-	ctx->dfs_root_ses = mnt_ctx->ses;
+	ctx->dfs_root_ses = ses;
+	return 0;
 }
 
 static int get_dfs_conn(struct cifs_mount_ctx *mnt_ctx, const char *ref_path, const char *full_path,
@@ -118,7 +127,8 @@ static int get_dfs_conn(struct cifs_mount_ctx *mnt_ctx, const char *ref_path, co
 {
 	struct smb3_fs_context *ctx = mnt_ctx->fs_ctx;
 	struct dfs_info3_param ref = {};
-	int rc;
+	bool is_refsrv = false;
+	int rc, rc2;
 
 	rc = dfs_cache_get_tgt_referral(ref_path + 1, tit, &ref);
 	if (rc)
@@ -133,8 +143,7 @@ static int get_dfs_conn(struct cifs_mount_ctx *mnt_ctx, const char *ref_path, co
 	if (rc)
 		goto out;
 
-	if (ref.flags & DFSREF_REFERRAL_SERVER)
-		set_root_ses(mnt_ctx);
+	is_refsrv = !!(ref.flags & DFSREF_REFERRAL_SERVER);
 
 	rc = -EREMOTE;
 	if (ref.flags & DFSREF_STORAGE_SERVER) {
@@ -143,13 +152,17 @@ static int get_dfs_conn(struct cifs_mount_ctx *mnt_ctx, const char *ref_path, co
 			goto out;
 
 		/* some servers may not advertise referral capability under ref.flags */
-		if (!(ref.flags & DFSREF_REFERRAL_SERVER) &&
-		    is_tcon_dfs(mnt_ctx->tcon))
-			set_root_ses(mnt_ctx);
+		is_refsrv |= is_tcon_dfs(mnt_ctx->tcon);
 
 		rc = cifs_is_path_remote(mnt_ctx);
 	}
 
+	if (rc == -EREMOTE && is_refsrv) {
+		rc2 = get_root_smb_session(mnt_ctx);
+		if (rc2)
+			rc = rc2;
+	}
+
 out:
 	free_dfs_info_param(&ref);
 	return rc;
@@ -162,6 +175,7 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 	char *ref_path = NULL, *full_path = NULL;
 	struct dfs_cache_tgt_iterator *tit;
 	struct TCP_Server_Info *server;
+	struct cifs_tcon *tcon;
 	char *origin_fullpath = NULL;
 	int num_links = 0;
 	int rc;
@@ -231,12 +245,22 @@ static int __dfs_mount_share(struct cifs_mount_ctx *mnt_ctx)
 
 	if (!rc) {
 		server = mnt_ctx->server;
+		tcon = mnt_ctx->tcon;
 
 		mutex_lock(&server->refpath_lock);
-		server->origin_fullpath = origin_fullpath;
-		server->current_fullpath = server->leaf_fullpath;
+		if (!server->origin_fullpath) {
+			server->origin_fullpath = origin_fullpath;
+			server->current_fullpath = server->leaf_fullpath;
+			origin_fullpath = NULL;
+		}
 		mutex_unlock(&server->refpath_lock);
-		origin_fullpath = NULL;
+
+		if (list_empty(&tcon->dfs_ses_list)) {
+			list_replace_init(&mnt_ctx->dfs_ses_list,
+					  &tcon->dfs_ses_list);
+		} else {
+			dfs_put_root_smb_sessions(&mnt_ctx->dfs_ses_list);
+		}
 	}
 
 out:
@@ -277,7 +301,9 @@ int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs)
 	}
 
 	*isdfs = true;
-	set_root_ses(mnt_ctx);
+	rc = get_root_smb_session(mnt_ctx);
+	if (rc)
+		return rc;
 
 	return __dfs_mount_share(mnt_ctx);
 }
diff --git a/fs/cifs/dfs.h b/fs/cifs/dfs.h
index baf16df55d7e..13f26e01f7b9 100644
--- a/fs/cifs/dfs.h
+++ b/fs/cifs/dfs.h
@@ -10,6 +10,11 @@
 #include "fs_context.h"
 #include "cifs_unicode.h"
 
+struct dfs_root_ses {
+	struct list_head list;
+	struct cifs_ses *ses;
+};
+
 int dfs_parse_target_referral(const char *full_path, const struct dfs_info3_param *ref,
 			      struct smb3_fs_context *ctx);
 int dfs_mount_share(struct cifs_mount_ctx *mnt_ctx, bool *isdfs);
@@ -44,4 +49,15 @@ static inline char *dfs_get_automount_devname(struct dentry *dentry, void *page)
 							true);
 }
 
+static inline void dfs_put_root_smb_sessions(struct list_head *head)
+{
+	struct dfs_root_ses *root, *tmp;
+
+	list_for_each_entry_safe(root, tmp, head, list) {
+		list_del_init(&root->list);
+		cifs_put_smb_ses(root->ses);
+		kfree(root);
+	}
+}
+
 #endif /* _CIFS_DFS_H */
diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index ac86bd0ebd63..1c59811bfa73 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -49,17 +49,6 @@ struct cache_entry {
 	struct cache_dfs_tgt *tgthint;
 };
 
-/* List of referral server sessions per dfs mount */
-struct mount_group {
-	struct list_head list;
-	uuid_t id;
-	struct cifs_ses *sessions[CACHE_MAX_ENTRIES];
-	int num_sessions;
-	spinlock_t lock;
-	struct list_head refresh_list;
-	struct kref refcount;
-};
-
 static struct kmem_cache *cache_slab __read_mostly;
 static struct workqueue_struct *dfscache_wq __read_mostly;
 
@@ -76,85 +65,10 @@ static atomic_t cache_count;
 static struct hlist_head cache_htable[CACHE_HTABLE_SIZE];
 static DECLARE_RWSEM(htable_rw_lock);
 
-static LIST_HEAD(mount_group_list);
-static DEFINE_MUTEX(mount_group_list_lock);
-
 static void refresh_cache_worker(struct work_struct *work);
 
 static DECLARE_DELAYED_WORK(refresh_task, refresh_cache_worker);
 
-static void __mount_group_release(struct mount_group *mg)
-{
-	int i;
-
-	for (i = 0; i < mg->num_sessions; i++)
-		cifs_put_smb_ses(mg->sessions[i]);
-	kfree(mg);
-}
-
-static void mount_group_release(struct kref *kref)
-{
-	struct mount_group *mg = container_of(kref, struct mount_group, refcount);
-
-	mutex_lock(&mount_group_list_lock);
-	list_del(&mg->list);
-	mutex_unlock(&mount_group_list_lock);
-	__mount_group_release(mg);
-}
-
-static struct mount_group *find_mount_group_locked(const uuid_t *id)
-{
-	struct mount_group *mg;
-
-	list_for_each_entry(mg, &mount_group_list, list) {
-		if (uuid_equal(&mg->id, id))
-			return mg;
-	}
-	return ERR_PTR(-ENOENT);
-}
-
-static struct mount_group *__get_mount_group_locked(const uuid_t *id)
-{
-	struct mount_group *mg;
-
-	mg = find_mount_group_locked(id);
-	if (!IS_ERR(mg))
-		return mg;
-
-	mg = kmalloc(sizeof(*mg), GFP_KERNEL);
-	if (!mg)
-		return ERR_PTR(-ENOMEM);
-	kref_init(&mg->refcount);
-	uuid_copy(&mg->id, id);
-	mg->num_sessions = 0;
-	spin_lock_init(&mg->lock);
-	list_add(&mg->list, &mount_group_list);
-	return mg;
-}
-
-static struct mount_group *get_mount_group(const uuid_t *id)
-{
-	struct mount_group *mg;
-
-	mutex_lock(&mount_group_list_lock);
-	mg = __get_mount_group_locked(id);
-	if (!IS_ERR(mg))
-		kref_get(&mg->refcount);
-	mutex_unlock(&mount_group_list_lock);
-
-	return mg;
-}
-
-static void free_mount_group_list(void)
-{
-	struct mount_group *mg, *tmp_mg;
-
-	list_for_each_entry_safe(mg, tmp_mg, &mount_group_list, list) {
-		list_del_init(&mg->list);
-		__mount_group_release(mg);
-	}
-}
-
 /**
  * dfs_cache_canonical_path - get a canonical DFS path
  *
@@ -704,7 +618,6 @@ void dfs_cache_destroy(void)
 {
 	cancel_delayed_work_sync(&refresh_task);
 	unload_nls(cache_cp);
-	free_mount_group_list();
 	flush_cache_ents();
 	kmem_cache_destroy(cache_slab);
 	destroy_workqueue(dfscache_wq);
@@ -1111,54 +1024,6 @@ int dfs_cache_get_tgt_referral(const char *path, const struct dfs_cache_tgt_iter
 	return rc;
 }
 
-/**
- * dfs_cache_add_refsrv_session - add SMB session of referral server
- *
- * @mount_id: mount group uuid to lookup.
- * @ses: reference counted SMB session of referral server.
- */
-void dfs_cache_add_refsrv_session(const uuid_t *mount_id, struct cifs_ses *ses)
-{
-	struct mount_group *mg;
-
-	if (WARN_ON_ONCE(!mount_id || uuid_is_null(mount_id) || !ses))
-		return;
-
-	mg = get_mount_group(mount_id);
-	if (WARN_ON_ONCE(IS_ERR(mg)))
-		return;
-
-	spin_lock(&mg->lock);
-	if (mg->num_sessions < ARRAY_SIZE(mg->sessions))
-		mg->sessions[mg->num_sessions++] = ses;
-	spin_unlock(&mg->lock);
-	kref_put(&mg->refcount, mount_group_release);
-}
-
-/**
- * dfs_cache_put_refsrv_sessions - put all referral server sessions
- *
- * Put all SMB sessions from the given mount group id.
- *
- * @mount_id: mount group uuid to lookup.
- */
-void dfs_cache_put_refsrv_sessions(const uuid_t *mount_id)
-{
-	struct mount_group *mg;
-
-	if (!mount_id || uuid_is_null(mount_id))
-		return;
-
-	mutex_lock(&mount_group_list_lock);
-	mg = find_mount_group_locked(mount_id);
-	if (IS_ERR(mg)) {
-		mutex_unlock(&mount_group_list_lock);
-		return;
-	}
-	mutex_unlock(&mount_group_list_lock);
-	kref_put(&mg->refcount, mount_group_release);
-}
-
 /* Extract share from DFS target and return a pointer to prefix path or NULL */
 static const char *parse_target_share(const char *target, char **share)
 {
@@ -1384,11 +1249,6 @@ int dfs_cache_remount_fs(struct cifs_sb_info *cifs_sb)
 		cifs_dbg(FYI, "%s: not a dfs mount\n", __func__);
 		return 0;
 	}
-
-	if (uuid_is_null(&cifs_sb->dfs_mount_id)) {
-		cifs_dbg(FYI, "%s: no dfs mount group id\n", __func__);
-		return -EINVAL;
-	}
 	/*
 	 * After reconnecting to a different server, unique ids won't match anymore, so we disable
 	 * serverino. This prevents dentry revalidation to think the dentry are stale (ESTALE).
diff --git a/fs/cifs/dfs_cache.h b/fs/cifs/dfs_cache.h
index be3b5a44cf82..e0d39393035a 100644
--- a/fs/cifs/dfs_cache.h
+++ b/fs/cifs/dfs_cache.h
@@ -40,8 +40,6 @@ int dfs_cache_get_tgt_referral(const char *path, const struct dfs_cache_tgt_iter
 			       struct dfs_info3_param *ref);
 int dfs_cache_get_tgt_share(char *path, const struct dfs_cache_tgt_iterator *it, char **share,
 			    char **prefix);
-void dfs_cache_put_refsrv_sessions(const uuid_t *mount_id);
-void dfs_cache_add_refsrv_session(const uuid_t *mount_id, struct cifs_ses *ses);
 char *dfs_cache_canonical_path(const char *path, const struct nls_table *cp, int remap);
 int dfs_cache_remount_fs(struct cifs_sb_info *cifs_sb);
 
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index a0d286ee723d..6f9c78650528 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -22,6 +22,7 @@
 #ifdef CONFIG_CIFS_DFS_UPCALL
 #include "dns_resolve.h"
 #include "dfs_cache.h"
+#include "dfs.h"
 #endif
 #include "fs_context.h"
 #include "cached_dir.h"
@@ -134,6 +135,9 @@ tconInfoAlloc(void)
 	spin_lock_init(&ret_buf->stat_lock);
 	atomic_set(&ret_buf->num_local_opens, 0);
 	atomic_set(&ret_buf->num_remote_opens, 0);
+#ifdef CONFIG_CIFS_DFS_UPCALL
+	INIT_LIST_HEAD(&ret_buf->dfs_ses_list);
+#endif
 
 	return ret_buf;
 }
@@ -149,6 +153,9 @@ tconInfoFree(struct cifs_tcon *tcon)
 	atomic_dec(&tconInfoAllocCount);
 	kfree(tcon->nativeFileSystem);
 	kfree_sensitive(tcon->password);
+#ifdef CONFIG_CIFS_DFS_UPCALL
+	dfs_put_root_smb_sessions(&tcon->dfs_ses_list);
+#endif
 	kfree(tcon);
 }
 
-- 
2.39.2

