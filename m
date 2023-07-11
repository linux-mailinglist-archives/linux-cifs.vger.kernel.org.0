Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FED974EEF5
	for <lists+linux-cifs@lfdr.de>; Tue, 11 Jul 2023 14:32:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232415AbjGKMch (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 11 Jul 2023 08:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232445AbjGKMcf (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 11 Jul 2023 08:32:35 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96891728
        for <linux-cifs@vger.kernel.org>; Tue, 11 Jul 2023 05:32:02 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1b8b2886364so36514095ad.0
        for <linux-cifs@vger.kernel.org>; Tue, 11 Jul 2023 05:32:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689078666; x=1691670666;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZdhhpjkEblTp35HtMfU7WgaHTvxknTHNGt3ZoGm+U0g=;
        b=VX+CHWnkQ6Bo+Iau3zG5pmiXb0rPoh11ntmlQDC6/zPwolurUmjdEZoqpk60/3vPM+
         2sNqLGtqaNKhW2M6WfWb+fs3VC4beJpGsZ1Ho948IMjA0SzCyIUXSfbqwEnyuAqrdjw1
         Nkqs4dkLddtSKrJdEBj7l/uvscGFqweOy4MdJLh5OdrwzPsmzN5bj/36zmdR5vewpYcw
         9VB7DqOcn1Hb9VyoepFgSRVsDI+6tXoawFcxaAX67QKvskcdKx9JgyTuMpPctW59Yrxd
         vZCQI3QktdUwe+/Vi8D02Lw5R3cCr64rwBipPUQ6YOeLOu9UCpi2hCzwrbhIUYfqImp9
         nsxQ==
X-Gm-Message-State: ABy/qLYeETPsCOstFpAnXXO/dorzl1040Zn61sHObwhNBv4b7l2h94nL
        kx9qbHb90eySHXxxHa1FYEnD8b6X3GQ=
X-Google-Smtp-Source: APBJJlERZkKCjRT0Al8Cr0iQoKM+UPon7Trx+tBv8r1bNUaFqFayuY60X8k+9IkrcvWDe04J9O2w+A==
X-Received: by 2002:a17:903:230d:b0:1b8:7bd2:f77d with SMTP id d13-20020a170903230d00b001b87bd2f77dmr14179107plh.64.1689078666537;
        Tue, 11 Jul 2023 05:31:06 -0700 (PDT)
Received: from localhost.localdomain ([211.49.23.9])
        by smtp.gmail.com with ESMTPSA id 17-20020a170902e9d100b001b8ab115ce4sm1774040plk.278.2023.07.11.05.31.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Jul 2023 05:31:06 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
        hyc.lee@gmail.com, atteh.mailbox@gmail.com,
        Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH] ksmbd: check if a mount point is crossed during path lookup
Date:   Tue, 11 Jul 2023 21:30:34 +0900
Message-Id: <20230711123034.23856-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Since commit 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name"),
ksmbd can not lookup cross mount points. If last component is a cross
mount point during path lookup, check if it is crossed to follow it
down.

Fixes: 74d7970febf7 ("ksmbd: fix racy issue from using ->d_parent and ->d_name")
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/smb/server/smb2pdu.c | 27 ++++++++++++--------
 fs/smb/server/vfs.c     | 56 +++++++++++++++++++++++------------------
 fs/smb/server/vfs.h     |  4 +--
 3 files changed, 49 insertions(+), 38 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index cf8822103f50..ca276634fd58 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2467,8 +2467,9 @@ static void smb2_update_xattrs(struct ksmbd_tree_connect *tcon,
 	}
 }
 
-static int smb2_creat(struct ksmbd_work *work, struct path *path, char *name,
-		      int open_flags, umode_t posix_mode, bool is_dir)
+static int smb2_creat(struct ksmbd_work *work, struct path *parent_path,
+		      struct path *path, char *name, int open_flags,
+		      umode_t posix_mode, bool is_dir)
 {
 	struct ksmbd_tree_connect *tcon = work->tcon;
 	struct ksmbd_share_config *share = tcon->share_conf;
@@ -2495,7 +2496,7 @@ static int smb2_creat(struct ksmbd_work *work, struct path *path, char *name,
 			return rc;
 	}
 
-	rc = ksmbd_vfs_kern_path_locked(work, name, 0, path, 0);
+	rc = ksmbd_vfs_kern_path_locked(work, name, 0, parent_path, path, 0);
 	if (rc) {
 		pr_err("cannot get linux path (%s), err = %d\n",
 		       name, rc);
@@ -2565,7 +2566,7 @@ int smb2_open(struct ksmbd_work *work)
 	struct ksmbd_tree_connect *tcon = work->tcon;
 	struct smb2_create_req *req;
 	struct smb2_create_rsp *rsp;
-	struct path path;
+	struct path path, parent_path;
 	struct ksmbd_share_config *share = tcon->share_conf;
 	struct ksmbd_file *fp = NULL;
 	struct file *filp = NULL;
@@ -2786,7 +2787,8 @@ int smb2_open(struct ksmbd_work *work)
 		goto err_out1;
 	}
 
-	rc = ksmbd_vfs_kern_path_locked(work, name, LOOKUP_NO_SYMLINKS, &path, 1);
+	rc = ksmbd_vfs_kern_path_locked(work, name, LOOKUP_NO_SYMLINKS,
+					&parent_path, &path, 1);
 	if (!rc) {
 		file_present = true;
 
@@ -2906,7 +2908,8 @@ int smb2_open(struct ksmbd_work *work)
 
 	/*create file if not present */
 	if (!file_present) {
-		rc = smb2_creat(work, &path, name, open_flags, posix_mode,
+		rc = smb2_creat(work, &parent_path, &path, name, open_flags,
+				posix_mode,
 				req->CreateOptions & FILE_DIRECTORY_FILE_LE);
 		if (rc) {
 			if (rc == -ENOENT) {
@@ -3321,8 +3324,9 @@ int smb2_open(struct ksmbd_work *work)
 
 err_out:
 	if (file_present || created) {
-		inode_unlock(d_inode(path.dentry->d_parent));
-		dput(path.dentry);
+		inode_unlock(d_inode(parent_path.dentry));
+		path_put(&path);
+		path_put(&parent_path);
 	}
 	ksmbd_revert_fsids(work);
 err_out1:
@@ -5545,7 +5549,7 @@ static int smb2_create_link(struct ksmbd_work *work,
 			    struct nls_table *local_nls)
 {
 	char *link_name = NULL, *target_name = NULL, *pathname = NULL;
-	struct path path;
+	struct path path, parent_path;
 	bool file_present = false;
 	int rc;
 
@@ -5575,7 +5579,7 @@ static int smb2_create_link(struct ksmbd_work *work,
 
 	ksmbd_debug(SMB, "target name is %s\n", target_name);
 	rc = ksmbd_vfs_kern_path_locked(work, link_name, LOOKUP_NO_SYMLINKS,
-					&path, 0);
+					&parent_path, &path, 0);
 	if (rc) {
 		if (rc != -ENOENT)
 			goto out;
@@ -5605,8 +5609,9 @@ static int smb2_create_link(struct ksmbd_work *work,
 		rc = -EINVAL;
 out:
 	if (file_present) {
-		inode_unlock(d_inode(path.dentry->d_parent));
+		inode_unlock(d_inode(parent_path.dentry));
 		path_put(&path);
+		path_put(&parent_path);
 	}
 	if (!IS_ERR(link_name))
 		kfree(link_name);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index e35914457350..fd06d267de61 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -63,13 +63,13 @@ int ksmbd_vfs_lock_parent(struct dentry *parent, struct dentry *child)
 
 static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 					char *pathname, unsigned int flags,
+					struct path *parent_path,
 					struct path *path)
 {
 	struct qstr last;
 	struct filename *filename;
 	struct path *root_share_path = &share_conf->vfs_path;
 	int err, type;
-	struct path parent_path;
 	struct dentry *d;
 
 	if (pathname[0] == '\0') {
@@ -84,7 +84,7 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 		return PTR_ERR(filename);
 
 	err = vfs_path_parent_lookup(filename, flags,
-				     &parent_path, &last, &type,
+				     parent_path, &last, &type,
 				     root_share_path);
 	if (err) {
 		putname(filename);
@@ -92,13 +92,13 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 	}
 
 	if (unlikely(type != LAST_NORM)) {
-		path_put(&parent_path);
+		path_put(parent_path);
 		putname(filename);
 		return -ENOENT;
 	}
 
-	inode_lock_nested(parent_path.dentry->d_inode, I_MUTEX_PARENT);
-	d = lookup_one_qstr_excl(&last, parent_path.dentry, 0);
+	inode_lock_nested(parent_path->dentry->d_inode, I_MUTEX_PARENT);
+	d = lookup_one_qstr_excl(&last, parent_path->dentry, 0);
 	if (IS_ERR(d))
 		goto err_out;
 
@@ -108,15 +108,20 @@ static int ksmbd_vfs_path_lookup_locked(struct ksmbd_share_config *share_conf,
 	}
 
 	path->dentry = d;
-	path->mnt = share_conf->vfs_path.mnt;
-	path_put(&parent_path);
-	putname(filename);
+	path->mnt = mntget(parent_path->mnt);
+
+	err = follow_down(path, 0);
+	if (err < 0) {
+		path_put(path);
+		goto err_out;
+	}
 
+	putname(filename);
 	return 0;
 
 err_out:
-	inode_unlock(parent_path.dentry->d_inode);
-	path_put(&parent_path);
+	inode_unlock(d_inode(parent_path->dentry));
+	path_put(parent_path);
 	putname(filename);
 	return -ENOENT;
 }
@@ -1194,14 +1199,14 @@ static int ksmbd_vfs_lookup_in_dir(const struct path *dir, char *name,
  * Return:	0 on success, otherwise error
  */
 int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
-			       unsigned int flags, struct path *path,
-			       bool caseless)
+			       unsigned int flags, struct path *parent_path,
+			       struct path *path, bool caseless)
 {
 	struct ksmbd_share_config *share_conf = work->tcon->share_conf;
 	int err;
-	struct path parent_path;
 
-	err = ksmbd_vfs_path_lookup_locked(share_conf, name, flags, path);
+	err = ksmbd_vfs_path_lookup_locked(share_conf, name, flags, parent_path,
+					   path);
 	if (!err)
 		return 0;
 
@@ -1216,10 +1221,10 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 		path_len = strlen(filepath);
 		remain_len = path_len;
 
-		parent_path = share_conf->vfs_path;
-		path_get(&parent_path);
+		*parent_path = share_conf->vfs_path;
+		path_get(parent_path);
 
-		while (d_can_lookup(parent_path.dentry)) {
+		while (d_can_lookup(parent_path->dentry)) {
 			char *filename = filepath + path_len - remain_len;
 			char *next = strchrnul(filename, '/');
 			size_t filename_len = next - filename;
@@ -1228,7 +1233,7 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 			if (filename_len == 0)
 				break;
 
-			err = ksmbd_vfs_lookup_in_dir(&parent_path, filename,
+			err = ksmbd_vfs_lookup_in_dir(parent_path, filename,
 						      filename_len,
 						      work->conn->um);
 			if (err)
@@ -1245,8 +1250,8 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 				goto out2;
 			else if (is_last)
 				goto out1;
-			path_put(&parent_path);
-			parent_path = *path;
+			path_put(parent_path);
+			*parent_path = *path;
 
 			next[0] = '/';
 			remain_len -= filename_len + 1;
@@ -1254,16 +1259,17 @@ int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
 
 		err = -EINVAL;
 out2:
-		path_put(&parent_path);
+		path_put(parent_path);
 out1:
 		kfree(filepath);
 	}
 
 	if (!err) {
-		err = ksmbd_vfs_lock_parent(parent_path.dentry, path->dentry);
-		if (err)
-			dput(path->dentry);
-		path_put(&parent_path);
+		err = ksmbd_vfs_lock_parent(parent_path->dentry, path->dentry);
+		if (err) {
+			path_put(path);
+			path_put(parent_path);
+		}
 	}
 	return err;
 }
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index 80039312c255..72f9fb4b48d1 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -115,8 +115,8 @@ int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
 int ksmbd_vfs_remove_xattr(struct mnt_idmap *idmap,
 			   const struct path *path, char *attr_name);
 int ksmbd_vfs_kern_path_locked(struct ksmbd_work *work, char *name,
-			       unsigned int flags, struct path *path,
-			       bool caseless);
+			       unsigned int flags, struct path *parent_path,
+			       struct path *path, bool caseless);
 struct dentry *ksmbd_vfs_kern_path_create(struct ksmbd_work *work,
 					  const char *name,
 					  unsigned int flags,
-- 
2.25.1

