Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A45A52D9350
	for <lists+linux-cifs@lfdr.de>; Mon, 14 Dec 2020 07:42:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2438786AbgLNGmR (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 14 Dec 2020 01:42:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:28354 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2438782AbgLNGmQ (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 14 Dec 2020 01:42:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607928049;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=8lafd9RsaslFJIafxtB4tBoVDMaTxFwk3hmM3QH3MMg=;
        b=bIFT4zrM3IObXDiEBPF2yuBCpI8CDt1LUTzJbi2m1We6TUTVbDpay2RuG3Blxx6xRHdWnM
        rokekffmmylhxxZf0+IdSPOKZDc9WBmkNeQ+PZsXPkxiu/Oda0Xb3bW7BJP5SutFgJzlXt
        bAsY2qhc8rUuBuTW3BzT72dCa1RzYvM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-596-AKIM_X3kPBi3n3N0kJympw-1; Mon, 14 Dec 2020 01:40:47 -0500
X-MC-Unique: AKIM_X3kPBi3n3N0kJympw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA5BB18C89D9;
        Mon, 14 Dec 2020 06:40:46 +0000 (UTC)
Received: from test1103.test.redhat.com (vpn2-54-107.bne.redhat.com [10.64.54.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C67DA60BE2;
        Mon, 14 Dec 2020 06:40:45 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: [PATCH 01/12] cifs: move cifs_cleanup_volume_info[_content] to fs_context.c
Date:   Mon, 14 Dec 2020 16:40:16 +1000
Message-Id: <20201214064027.2885-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

and rename it to smb3_cleanup_fs_context[_content]

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/cifsfs.c     |  2 +-
 fs/cifs/cifsproto.h  |  3 ---
 fs/cifs/connect.c    | 47 ++++-------------------------------------------
 fs/cifs/dfs_cache.c  |  4 ++--
 fs/cifs/fs_context.c | 45 ++++++++++++++++++++++++++++++++++++++++++---
 fs/cifs/fs_context.h |  2 ++
 6 files changed, 51 insertions(+), 52 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 0932a3b225be..9c2959f552e0 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -874,7 +874,7 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 out:
 	if (cifs_sb) {
 		kfree(cifs_sb->prepath);
-		cifs_cleanup_volume_info(cifs_sb->ctx);
+		smb3_cleanup_fs_context(cifs_sb->ctx);
 		kfree(cifs_sb);
 	}
 	return root;
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index b80b57a66804..891c8d8c2bb5 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -237,7 +237,6 @@ extern int cifs_read_page_from_socket(struct TCP_Server_Info *server,
 extern int cifs_setup_cifs_sb(struct smb3_fs_context *ctx,
 			       struct cifs_sb_info *cifs_sb);
 extern int cifs_match_super(struct super_block *, void *);
-extern void cifs_cleanup_volume_info(struct smb3_fs_context *ctx);
 extern int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx);
 extern void cifs_umount(struct cifs_sb_info *);
 extern void cifs_mark_open_files_invalid(struct cifs_tcon *tcon);
@@ -552,8 +551,6 @@ extern int SMBencrypt(unsigned char *passwd, const unsigned char *c8,
 
 extern int
 cifs_setup_volume_info(struct smb3_fs_context *ctx);
-extern void
-cifs_cleanup_volume_info_contents(struct smb3_fs_context *ctx);
 
 extern struct TCP_Server_Info *
 cifs_find_tcp_session(struct smb3_fs_context *ctx);
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 1c8b08c06ad7..068b13e1b499 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2806,45 +2806,6 @@ int cifs_setup_cifs_sb(struct smb3_fs_context *ctx,
 	return 0;
 }
 
-void
-cifs_cleanup_volume_info_contents(struct smb3_fs_context *ctx)
-{
-	if (ctx == NULL)
-		return;
-
-	/*
-	 * Make sure this stays in sync with smb3_fs_context_dup()
-	 */
-	kfree(ctx->mount_options);
-	ctx->mount_options = NULL;
-	kfree(ctx->username);
-	ctx->username = NULL;
-	kfree_sensitive(ctx->password);
-	ctx->password = NULL;
-	kfree(ctx->UNC);
-	ctx->UNC = NULL;
-	kfree(ctx->domainname);
-	ctx->domainname = NULL;
-	kfree(ctx->nodename);
-	ctx->nodename = NULL;
-	kfree(ctx->iocharset);
-	ctx->iocharset = NULL;
-	kfree(ctx->prepath);
-	ctx->prepath = NULL;
-
-	unload_nls(ctx->local_nls);
-	ctx->local_nls = NULL;
-}
-
-void
-cifs_cleanup_volume_info(struct smb3_fs_context *ctx)
-{
-	if (!ctx)
-		return;
-	cifs_cleanup_volume_info_contents(ctx);
-	kfree(ctx);
-}
-
 /* Release all succeed connections */
 static inline void mount_put_conns(struct cifs_sb_info *cifs_sb,
 				   unsigned int xid,
@@ -3055,7 +3016,7 @@ expand_dfs_referral(const unsigned int xid, struct cifs_ses *ses,
 			rc = PTR_ERR(mdata);
 			mdata = NULL;
 		} else {
-			cifs_cleanup_volume_info_contents(ctx);
+			smb3_cleanup_fs_context_contents(ctx);
 			rc = cifs_setup_volume_info(ctx);
 		}
 		kfree(cifs_sb->ctx->mount_options);
@@ -3147,7 +3108,7 @@ static int setup_dfs_tgt_conn(const char *path, const char *full_path,
 			rc = update_vol_info(tgt_it, &fake_ctx, ctx);
 		}
 	}
-	cifs_cleanup_volume_info_contents(&fake_ctx);
+	smb3_cleanup_fs_context_contents(&fake_ctx);
 	return rc;
 }
 
@@ -3395,7 +3356,7 @@ static int check_dfs_prepath(struct cifs_sb_info *cifs_sb, struct smb3_fs_contex
 					break;
 				rc = -EREMOTE;
 				npath = build_unc_path_to_root(&v, cifs_sb, true);
-				cifs_cleanup_volume_info_contents(&v);
+				smb3_cleanup_fs_context_contents(&v);
 			} else {
 				v.UNC = ctx->UNC;
 				v.prepath = path + 1;
@@ -3759,7 +3720,7 @@ static void delayed_free(struct rcu_head *p)
 	struct cifs_sb_info *cifs_sb = container_of(p, struct cifs_sb_info, rcu);
 
 	unload_nls(cifs_sb->local_nls);
-	cifs_cleanup_volume_info(cifs_sb->ctx);
+	smb3_cleanup_fs_context(cifs_sb->ctx);
 	kfree(cifs_sb);
 }
 
diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 6bccff4596bf..6ad6ba5f6ebe 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -587,7 +587,7 @@ static void __vol_release(struct vol_info *vi)
 {
 	kfree(vi->fullpath);
 	kfree(vi->mntdata);
-	cifs_cleanup_volume_info_contents(&vi->ctx);
+	smb3_cleanup_fs_context_contents(&vi->ctx);
 	kfree(vi);
 }
 
@@ -1468,7 +1468,7 @@ static struct cifs_ses *find_root_ses(struct vol_info *vi,
 	ses = cifs_get_smb_ses(server, &ctx);
 
 out:
-	cifs_cleanup_volume_info_contents(&ctx);
+	smb3_cleanup_fs_context_contents(&ctx);
 	kfree(mdata);
 	kfree(rpath);
 
diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index fe5cc60f4393..4739caa0af97 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -289,7 +289,7 @@ do {									\
 	if (ctx->field) {						\
 		new_ctx->field = kstrdup(ctx->field, GFP_ATOMIC);	\
 		if (new_ctx->field == NULL) {				\
-			cifs_cleanup_volume_info_contents(new_ctx);	\
+			smb3_cleanup_fs_context_contents(new_ctx);	\
 			return -ENOMEM;					\
 		}							\
 	}								\
@@ -312,7 +312,7 @@ smb3_fs_context_dup(struct smb3_fs_context *new_ctx, struct smb3_fs_context *ctx
 	new_ctx->iocharset = NULL;
 
 	/*
-	 * Make sure to stay in sync with cifs_cleanup_volume_info_contents()
+	 * Make sure to stay in sync with smb3_cleanup_fs_context_contents()
 	 */
 	DUP_CTX_STR(prepath);
 	DUP_CTX_STR(mount_options);
@@ -617,7 +617,7 @@ static void smb3_fs_context_free(struct fs_context *fc)
 {
 	struct smb3_fs_context *ctx = smb3_fc2context(fc);
 
-	cifs_cleanup_volume_info(ctx);
+	smb3_cleanup_fs_context(ctx);
 }
 
 static int smb3_reconfigure(struct fs_context *fc)
@@ -1243,3 +1243,42 @@ int smb3_init_fs_context(struct fs_context *fc)
 	fc->ops = &smb3_fs_context_ops;
 	return 0;
 }
+
+void
+smb3_cleanup_fs_context_contents(struct smb3_fs_context *ctx)
+{
+	if (ctx == NULL)
+		return;
+
+	/*
+	 * Make sure this stays in sync with smb3_fs_context_dup()
+	 */
+	kfree(ctx->mount_options);
+	ctx->mount_options = NULL;
+	kfree(ctx->username);
+	ctx->username = NULL;
+	kfree_sensitive(ctx->password);
+	ctx->password = NULL;
+	kfree(ctx->UNC);
+	ctx->UNC = NULL;
+	kfree(ctx->domainname);
+	ctx->domainname = NULL;
+	kfree(ctx->nodename);
+	ctx->nodename = NULL;
+	kfree(ctx->iocharset);
+	ctx->iocharset = NULL;
+	kfree(ctx->prepath);
+	ctx->prepath = NULL;
+
+	unload_nls(ctx->local_nls);
+	ctx->local_nls = NULL;
+}
+
+void
+smb3_cleanup_fs_context(struct smb3_fs_context *ctx)
+{
+	if (!ctx)
+		return;
+	smb3_cleanup_fs_context_contents(ctx);
+	kfree(ctx);
+}
diff --git a/fs/cifs/fs_context.h b/fs/cifs/fs_context.h
index aaec8a819d34..4c4c392b9767 100644
--- a/fs/cifs/fs_context.h
+++ b/fs/cifs/fs_context.h
@@ -254,6 +254,8 @@ extern int cifs_parse_cache_flavor(char *value,
 extern int cifs_parse_security_flavors(char *value,
 				       struct smb3_fs_context *ctx);
 extern int smb3_init_fs_context(struct fs_context *fc);
+extern void smb3_cleanup_fs_context_contents(struct smb3_fs_context *ctx);
+extern void smb3_cleanup_fs_context(struct smb3_fs_context *ctx);
 
 static inline struct smb3_fs_context *smb3_fc2context(const struct fs_context *fc)
 {
-- 
2.13.6

