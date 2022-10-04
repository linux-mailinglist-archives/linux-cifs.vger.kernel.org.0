Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C28515F4917
	for <lists+linux-cifs@lfdr.de>; Tue,  4 Oct 2022 20:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbiJDSMz (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 4 Oct 2022 14:12:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbiJDSMy (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 4 Oct 2022 14:12:54 -0400
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0192C4DB50
        for <linux-cifs@vger.kernel.org>; Tue,  4 Oct 2022 11:12:50 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id DA5EB7FC9E;
        Tue,  4 Oct 2022 18:12:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1664907168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=HF0rT0fgdt2km3xGqteTsWV3uCAkW8QkHjGPYg+vLlA=;
        b=TM0iT0NsIwEWXBfABgVVoAgXAHoRfoAnKUeEWEM+vJXtF4q54PUN6I19DMjgNu46Tu4Swu
        iXJo7inAQ9W3bAOHWngUnoUDVM0fbNEZzB7MKvG4QrlgJilqqTl+5KCJKIKzyZ4XmXD6yH
        VQs4J8zDSR+5EwT1tphmj8VOxDVggOHrI8MUpaKN+m0PUMbwy2pnw4BPt94Z+0TQz7D2jZ
        yNRDGuIaIleAcpj3bCHV0NZOe9zjS5qTCrKeGIE7NgY9S4wXaC1xfB28Z1DO6hROzOPlfH
        bOisuzOEN0rMSxnL7MaPV0U9DNBIjtRZfiyNGu6cU4Rr3nFN7tLuXflhV+ltAA==
From:   Paulo Alcantara <pc@cjr.nz>
To:     smfrench@gmail.com
Cc:     linux-cifs@vger.kernel.org, Paulo Alcantara <pc@cjr.nz>
Subject: [PATCH v2 1/2] cifs: improve symlink handling for smb2+
Date:   Tue,  4 Oct 2022 15:13:24 -0300
Message-Id: <20221004181325.15207-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

When creating inode for symlink, the client used to send below
requests to fill it in:

    * create+query_info+close (STATUS_STOPPED_ON_SYMLINK)
    * create(+reparse_flag)+query_info+close (set file attrs)
    * create+ioctl(get_reparse)+close (query reparse tag)

and then for every access to the symlink dentry, the ->link() method
would send another:

    * create+ioctl(get_reparse)+close (parse symlink)

So, in order to improve:

    (i) Get rid of unnecessary roundtrips and then resolve symlinks as
	follows:

        * create+query_info+close (STATUS_STOPPED_ON_SYMLINK + parse symlink + get reparse tag)
        * create(+reparse_flag)+query_info+close (set file attrs)

    (ii) Set the resolved symlink target directly in inode->i_link and
         use simple_get_link() for ->link() to simply return it.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---
 fs/cifs/cifsfs.c    |   9 ++-
 fs/cifs/cifsglob.h  |  43 ++++++++---
 fs/cifs/cifsproto.h |  13 ++--
 fs/cifs/dir.c       |  30 +++-----
 fs/cifs/file.c      |  41 ++++++-----
 fs/cifs/inode.c     | 170 ++++++++++++++++++++++++++------------------
 fs/cifs/link.c      | 107 +---------------------------
 fs/cifs/readdir.c   |   2 +
 fs/cifs/smb1ops.c   |  56 +++++++++------
 fs/cifs/smb2file.c  | 127 +++++++++++++++++++++++++++------
 fs/cifs/smb2inode.c | 169 ++++++++++++++++++++++---------------------
 fs/cifs/smb2ops.c   | 109 ++++++----------------------
 fs/cifs/smb2pdu.h   |   3 +
 fs/cifs/smb2proto.h |  22 +++---
 14 files changed, 448 insertions(+), 453 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 8042d7280dec..c6ac19223ddc 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -396,6 +396,7 @@ cifs_alloc_inode(struct super_block *sb)
 	cifs_inode->epoch = 0;
 	spin_lock_init(&cifs_inode->open_file_lock);
 	generate_random_uuid(cifs_inode->lease_key);
+	cifs_inode->symlink_target = NULL;
 
 	/*
 	 * Can not set i_flags here - they get immediately overwritten to zero
@@ -412,7 +413,11 @@ cifs_alloc_inode(struct super_block *sb)
 static void
 cifs_free_inode(struct inode *inode)
 {
-	kmem_cache_free(cifs_inode_cachep, CIFS_I(inode));
+	struct cifsInodeInfo *cinode = CIFS_I(inode);
+
+	if (S_ISLNK(inode->i_mode))
+		kfree(cinode->symlink_target);
+	kmem_cache_free(cifs_inode_cachep, cinode);
 }
 
 static void
@@ -1139,7 +1144,7 @@ const struct inode_operations cifs_file_inode_ops = {
 };
 
 const struct inode_operations cifs_symlink_inode_ops = {
-	.get_link = cifs_get_link,
+	.get_link = simple_get_link,
 	.permission = cifs_permission,
 	.listxattr = cifs_listxattr,
 };
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 52ddf4163b98..9a3386d827b6 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -185,6 +185,19 @@ struct cifs_cred {
 	struct cifs_ace *aces;
 };
 
+struct cifs_open_info_data {
+	char *symlink_target;
+	union {
+		struct smb2_file_all_info fi;
+		struct smb311_posix_qinfo posix_fi;
+	};
+};
+
+static inline void cifs_free_open_info(struct cifs_open_info_data *data)
+{
+	kfree(data->symlink_target);
+}
+
 /*
  *****************************************************************
  * Except the CIFS PDUs themselves all the
@@ -307,20 +320,18 @@ struct smb_version_operations {
 	int (*is_path_accessible)(const unsigned int, struct cifs_tcon *,
 				  struct cifs_sb_info *, const char *);
 	/* query path data from the server */
-	int (*query_path_info)(const unsigned int, struct cifs_tcon *,
-			       struct cifs_sb_info *, const char *,
-			       FILE_ALL_INFO *, bool *, bool *);
+	int (*query_path_info)(const unsigned int, struct cifs_tcon *, struct cifs_sb_info *,
+			       const char *, struct cifs_open_info_data *, bool *, bool *);
 	/* query file data from the server */
-	int (*query_file_info)(const unsigned int, struct cifs_tcon *,
-			       struct cifs_fid *, FILE_ALL_INFO *);
+	int (*query_file_info)(const unsigned int, struct cifs_tcon *, struct cifsFileInfo *,
+			       struct cifs_open_info_data *);
 	/* query reparse tag from srv to determine which type of special file */
 	int (*query_reparse_tag)(const unsigned int xid, struct cifs_tcon *tcon,
 				struct cifs_sb_info *cifs_sb, const char *path,
 				__u32 *reparse_tag);
 	/* get server index number */
-	int (*get_srv_inum)(const unsigned int, struct cifs_tcon *,
-			    struct cifs_sb_info *, const char *,
-			    u64 *uniqueid, FILE_ALL_INFO *);
+	int (*get_srv_inum)(const unsigned int, struct cifs_tcon *, struct cifs_sb_info *,
+			    const char *, u64 *uniqueid, struct cifs_open_info_data *);
 	/* set size by path */
 	int (*set_path_size)(const unsigned int, struct cifs_tcon *,
 			     const char *, __u64, struct cifs_sb_info *, bool);
@@ -369,8 +380,7 @@ struct smb_version_operations {
 			     struct cifs_sb_info *, const char *,
 			     char **, bool);
 	/* open a file for non-posix mounts */
-	int (*open)(const unsigned int, struct cifs_open_parms *,
-		    __u32 *, FILE_ALL_INFO *);
+	int (*open)(const unsigned int, struct cifs_open_parms *, __u32 *, void *);
 	/* set fid protocol-specific info */
 	void (*set_fid)(struct cifsFileInfo *, struct cifs_fid *, __u32);
 	/* close a file */
@@ -1123,6 +1133,7 @@ struct cifs_fattr {
 	struct timespec64 cf_mtime;
 	struct timespec64 cf_ctime;
 	u32             cf_cifstag;
+	char            *cf_symlink_target;
 };
 
 /*
@@ -1385,6 +1396,7 @@ struct cifsFileInfo {
 	struct work_struct put; /* work for the final part of _put */
 	struct delayed_work deferred;
 	bool deferred_close_scheduled; /* Flag to indicate close is scheduled */
+	char *symlink_target;
 };
 
 struct cifs_io_parms {
@@ -1543,6 +1555,7 @@ struct cifsInodeInfo {
 	struct list_head deferred_closes; /* list of deferred closes */
 	spinlock_t deferred_lock; /* protection on deferred list */
 	bool lease_granted; /* Flag to indicate whether lease or oplock is granted. */
+	char *symlink_target;
 };
 
 static inline struct cifsInodeInfo *
@@ -2111,4 +2124,14 @@ static inline size_t ntlmssp_workstation_name_size(const struct cifs_ses *ses)
 	return sizeof(ses->workstation_name);
 }
 
+static inline void move_cifs_info_to_smb2(struct smb2_file_all_info *dst, const FILE_ALL_INFO *src)
+{
+	memcpy(dst, src, (size_t)((u8 *)&src->AccessFlags - (u8 *)src));
+	dst->AccessFlags = src->AccessFlags;
+	dst->CurrentByteOffset = src->CurrentByteOffset;
+	dst->Mode = src->Mode;
+	dst->AlignmentRequirement = src->AlignmentRequirement;
+	dst->FileNameLength = src->FileNameLength;
+}
+
 #endif	/* _CIFS_GLOB_H */
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index f5adcb8ea04d..13a675d9d3b9 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -182,10 +182,9 @@ extern int cifs_unlock_range(struct cifsFileInfo *cfile,
 extern int cifs_push_mandatory_locks(struct cifsFileInfo *cfile);
 
 extern void cifs_down_write(struct rw_semaphore *sem);
-extern struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid,
-					      struct file *file,
-					      struct tcon_link *tlink,
-					      __u32 oplock);
+struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
+				       struct tcon_link *tlink, __u32 oplock,
+				       const char *symlink_target);
 extern int cifs_posix_open(const char *full_path, struct inode **inode,
 			   struct super_block *sb, int mode,
 			   unsigned int f_flags, __u32 *oplock, __u16 *netfid,
@@ -200,9 +199,9 @@ extern int cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr);
 extern struct inode *cifs_iget(struct super_block *sb,
 			       struct cifs_fattr *fattr);
 
-extern int cifs_get_inode_info(struct inode **inode, const char *full_path,
-			       FILE_ALL_INFO *data, struct super_block *sb,
-			       int xid, const struct cifs_fid *fid);
+int cifs_get_inode_info(struct inode **inode, const char *full_path,
+			struct cifs_open_info_data *data, struct super_block *sb, int xid,
+			const struct cifs_fid *fid);
 extern int smb311_posix_get_inode_info(struct inode **pinode, const char *search_path,
 			struct super_block *sb, unsigned int xid);
 extern int cifs_get_inode_info_unix(struct inode **pinode,
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index f58869306309..4edd55384662 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -165,10 +165,9 @@ check_name(struct dentry *direntry, struct cifs_tcon *tcon)
 
 /* Inode operations in similar order to how they appear in Linux file fs.h */
 
-static int
-cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
-	       struct tcon_link *tlink, unsigned oflags, umode_t mode,
-	       __u32 *oplock, struct cifs_fid *fid)
+static int cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
+			  struct tcon_link *tlink, unsigned oflags, umode_t mode, __u32 *oplock,
+			  struct cifs_fid *fid, struct cifs_open_info_data *buf)
 {
 	int rc = -ENOENT;
 	int create_options = CREATE_NOT_DIR;
@@ -177,7 +176,6 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	struct cifs_tcon *tcon = tlink_tcon(tlink);
 	const char *full_path;
 	void *page = alloc_dentry_path();
-	FILE_ALL_INFO *buf = NULL;
 	struct inode *newinode = NULL;
 	int disposition;
 	struct TCP_Server_Info *server = tcon->ses->server;
@@ -290,12 +288,6 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 		goto out;
 	}
 
-	buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
-	if (buf == NULL) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
 	/*
 	 * if we're not using unix extensions, see if we need to set
 	 * ATTR_READONLY on the create call
@@ -364,8 +356,7 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	{
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 		/* TODO: Add support for calling POSIX query info here, but passing in fid */
-		rc = cifs_get_inode_info(&newinode, full_path, buf, inode->i_sb,
-					 xid, fid);
+		rc = cifs_get_inode_info(&newinode, full_path, buf, inode->i_sb, xid, fid);
 		if (newinode) {
 			if (server->ops->set_lease_key)
 				server->ops->set_lease_key(newinode, fid);
@@ -402,7 +393,6 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	d_add(direntry, newinode);
 
 out:
-	kfree(buf);
 	free_dentry_path(page);
 	return rc;
 
@@ -427,6 +417,7 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	struct cifs_pending_open open;
 	__u32 oplock;
 	struct cifsFileInfo *file_info;
+	struct cifs_open_info_data buf = {};
 
 	if (unlikely(cifs_forced_shutdown(CIFS_SB(inode->i_sb))))
 		return -EIO;
@@ -484,8 +475,7 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	cifs_add_pending_open(&fid, tlink, &open);
 
 	rc = cifs_do_create(inode, direntry, xid, tlink, oflags, mode,
-			    &oplock, &fid);
-
+			    &oplock, &fid, &buf);
 	if (rc) {
 		cifs_del_pending_open(&open);
 		goto out;
@@ -510,7 +500,7 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 			file->f_op = &cifs_file_direct_ops;
 		}
 
-	file_info = cifs_new_fileinfo(&fid, file, tlink, oplock);
+	file_info = cifs_new_fileinfo(&fid, file, tlink, oplock, buf.symlink_target);
 	if (file_info == NULL) {
 		if (server->ops->close)
 			server->ops->close(xid, tcon, &fid);
@@ -526,6 +516,7 @@ cifs_atomic_open(struct inode *inode, struct dentry *direntry,
 	cifs_put_tlink(tlink);
 out_free_xid:
 	free_xid(xid);
+	cifs_free_open_info(&buf);
 	return rc;
 }
 
@@ -547,6 +538,7 @@ int cifs_create(struct user_namespace *mnt_userns, struct inode *inode,
 	struct TCP_Server_Info *server;
 	struct cifs_fid fid;
 	__u32 oplock;
+	struct cifs_open_info_data buf = {};
 
 	cifs_dbg(FYI, "cifs_create parent inode = 0x%p name is: %pd and dentry = 0x%p\n",
 		 inode, direntry, direntry);
@@ -565,11 +557,11 @@ int cifs_create(struct user_namespace *mnt_userns, struct inode *inode,
 	if (server->ops->new_lease_key)
 		server->ops->new_lease_key(&fid);
 
-	rc = cifs_do_create(inode, direntry, xid, tlink, oflags, mode,
-			    &oplock, &fid);
+	rc = cifs_do_create(inode, direntry, xid, tlink, oflags, mode, &oplock, &fid, &buf);
 	if (!rc && server->ops->close)
 		server->ops->close(xid, tcon, &fid);
 
+	cifs_free_open_info(&buf);
 	cifs_put_tlink(tlink);
 out_free_xid:
 	free_xid(xid);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 7d756721e1a6..dcec1690312b 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -209,16 +209,14 @@ int cifs_posix_open(const char *full_path, struct inode **pinode,
 }
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 
-static int
-cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_sb_info *cifs_sb,
-	     struct cifs_tcon *tcon, unsigned int f_flags, __u32 *oplock,
-	     struct cifs_fid *fid, unsigned int xid)
+static int cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_sb_info *cifs_sb,
+			struct cifs_tcon *tcon, unsigned int f_flags, __u32 *oplock,
+			struct cifs_fid *fid, unsigned int xid, struct cifs_open_info_data *buf)
 {
 	int rc;
 	int desired_access;
 	int disposition;
 	int create_options = CREATE_NOT_DIR;
-	FILE_ALL_INFO *buf;
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct cifs_open_parms oparms;
 
@@ -255,10 +253,6 @@ cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_sb_info *ci
 
 	/* BB pass O_SYNC flag through on file attributes .. BB */
 
-	buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
 	/* O_SYNC also has bit for O_DSYNC so following check picks up either */
 	if (f_flags & O_SYNC)
 		create_options |= CREATE_WRITE_THROUGH;
@@ -276,9 +270,8 @@ cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_sb_info *ci
 	oparms.reconnect = false;
 
 	rc = server->ops->open(xid, &oparms, oplock, buf);
-
 	if (rc)
-		goto out;
+		return rc;
 
 	/* TODO: Add support for calling posix query info but with passing in fid */
 	if (tcon->unix_ext)
@@ -294,8 +287,6 @@ cifs_nt_open(const char *full_path, struct inode *inode, struct cifs_sb_info *ci
 			rc = -EOPENSTALE;
 	}
 
-out:
-	kfree(buf);
 	return rc;
 }
 
@@ -325,9 +316,9 @@ cifs_down_write(struct rw_semaphore *sem)
 
 static void cifsFileInfo_put_work(struct work_struct *work);
 
-struct cifsFileInfo *
-cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
-		  struct tcon_link *tlink, __u32 oplock)
+struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
+				       struct tcon_link *tlink, __u32 oplock,
+				       const char *symlink_target)
 {
 	struct dentry *dentry = file_dentry(file);
 	struct inode *inode = d_inode(dentry);
@@ -347,6 +338,15 @@ cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 		return NULL;
 	}
 
+	if (symlink_target) {
+		cfile->symlink_target = kstrdup(symlink_target, GFP_KERNEL);
+		if (!cfile->symlink_target) {
+			kfree(fdlocks);
+			kfree(cfile);
+			return NULL;
+		}
+	}
+
 	INIT_LIST_HEAD(&fdlocks->locks);
 	fdlocks->cfile = cfile;
 	cfile->llist = fdlocks;
@@ -440,6 +440,7 @@ static void cifsFileInfo_put_final(struct cifsFileInfo *cifs_file)
 	cifs_put_tlink(cifs_file->tlink);
 	dput(cifs_file->dentry);
 	cifs_sb_deactive(sb);
+	kfree(cifs_file->symlink_target);
 	kfree(cifs_file);
 }
 
@@ -572,6 +573,7 @@ int cifs_open(struct inode *inode, struct file *file)
 	bool posix_open_ok = false;
 	struct cifs_fid fid;
 	struct cifs_pending_open open;
+	struct cifs_open_info_data data = {};
 
 	xid = get_xid();
 
@@ -662,15 +664,15 @@ int cifs_open(struct inode *inode, struct file *file)
 		if (server->ops->get_lease_key)
 			server->ops->get_lease_key(inode, &fid);
 
-		rc = cifs_nt_open(full_path, inode, cifs_sb, tcon,
-				  file->f_flags, &oplock, &fid, xid);
+		rc = cifs_nt_open(full_path, inode, cifs_sb, tcon, file->f_flags, &oplock, &fid,
+				  xid, &data);
 		if (rc) {
 			cifs_del_pending_open(&open);
 			goto out;
 		}
 	}
 
-	cfile = cifs_new_fileinfo(&fid, file, tlink, oplock);
+	cfile = cifs_new_fileinfo(&fid, file, tlink, oplock, data.symlink_target);
 	if (cfile == NULL) {
 		if (server->ops->close)
 			server->ops->close(xid, tcon, &fid);
@@ -712,6 +714,7 @@ int cifs_open(struct inode *inode, struct file *file)
 	free_dentry_path(page);
 	free_xid(xid);
 	cifs_put_tlink(tlink);
+	cifs_free_open_info(&data);
 	return rc;
 }
 
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 3784d3a88053..37ada3912022 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -212,6 +212,17 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 	}
 	spin_unlock(&inode->i_lock);
 
+	if (S_ISLNK(fattr->cf_mode)) {
+		kfree(cifs_i->symlink_target);
+		cifs_i->symlink_target = fattr->cf_symlink_target;
+		fattr->cf_symlink_target = NULL;
+
+		if (unlikely(!cifs_i->symlink_target))
+			inode->i_link = ERR_PTR(-EOPNOTSUPP);
+		else
+			inode->i_link = cifs_i->symlink_target;
+	}
+
 	if (fattr->cf_flags & CIFS_FATTR_DFS_REFERRAL)
 		inode->i_flags |= S_AUTOMOUNT;
 	if (inode->i_state & I_NEW)
@@ -347,13 +358,20 @@ cifs_get_file_info_unix(struct file *filp)
 	int rc;
 	unsigned int xid;
 	FILE_UNIX_BASIC_INFO find_data;
-	struct cifs_fattr fattr;
+	struct cifs_fattr fattr = {};
 	struct inode *inode = file_inode(filp);
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct cifsFileInfo *cfile = filp->private_data;
 	struct cifs_tcon *tcon = tlink_tcon(cfile->tlink);
 
 	xid = get_xid();
+
+	if (cfile->symlink_target) {
+		fattr.cf_symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
+		if (!fattr.cf_symlink_target)
+			return -ENOMEM;
+	}
+
 	rc = CIFSSMBUnixQFileInfo(xid, tcon, cfile->fid.netfid, &find_data);
 	if (!rc) {
 		cifs_unix_basic_to_fattr(&fattr, &find_data, cifs_sb);
@@ -378,6 +396,7 @@ int cifs_get_inode_info_unix(struct inode **pinode,
 	FILE_UNIX_BASIC_INFO find_data;
 	struct cifs_fattr fattr;
 	struct cifs_tcon *tcon;
+	struct TCP_Server_Info *server;
 	struct tcon_link *tlink;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 
@@ -387,10 +406,12 @@ int cifs_get_inode_info_unix(struct inode **pinode,
 	if (IS_ERR(tlink))
 		return PTR_ERR(tlink);
 	tcon = tlink_tcon(tlink);
+	server = tcon->ses->server;
 
 	/* could have done a find first instead but this returns more info */
 	rc = CIFSSMBUnixQPathInfo(xid, tcon, full_path, &find_data,
 				  cifs_sb->local_nls, cifs_remap(cifs_sb));
+	cifs_dbg(FYI, "%s: query path info: rc = %d\n", __func__, rc);
 	cifs_put_tlink(tlink);
 
 	if (!rc) {
@@ -410,6 +431,17 @@ int cifs_get_inode_info_unix(struct inode **pinode,
 			cifs_dbg(FYI, "check_mf_symlink: %d\n", tmprc);
 	}
 
+	if (S_ISLNK(fattr.cf_mode) && !fattr.cf_symlink_target) {
+		if (!server->ops->query_symlink)
+			return -ENOSYS;
+		rc = server->ops->query_symlink(xid, tcon, cifs_sb, full_path,
+						&fattr.cf_symlink_target, false);
+		if (rc) {
+			cifs_dbg(FYI, "%s: query_symlink: %d\n", __func__, rc);
+			goto cgiiu_exit;
+		}
+	}
+
 	if (*pinode == NULL) {
 		/* get new inode */
 		cifs_fill_uniqueid(sb, &fattr);
@@ -432,6 +464,7 @@ int cifs_get_inode_info_unix(struct inode **pinode,
 	}
 
 cgiiu_exit:
+	kfree(fattr.cf_symlink_target);
 	return rc;
 }
 #else
@@ -601,10 +634,10 @@ static int cifs_sfu_mode(struct cifs_fattr *fattr, const unsigned char *path,
 }
 
 /* Fill a cifs_fattr struct with info from POSIX info struct */
-static void
-smb311_posix_info_to_fattr(struct cifs_fattr *fattr, struct smb311_posix_qinfo *info,
-			   struct super_block *sb, bool adjust_tz, bool symlink)
+static void smb311_posix_info_to_fattr(struct cifs_fattr *fattr, struct cifs_open_info_data *data,
+				       struct super_block *sb, bool adjust_tz, bool symlink)
 {
+	struct smb311_posix_qinfo *info = &data->posix_fi;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
 
@@ -639,6 +672,8 @@ smb311_posix_info_to_fattr(struct cifs_fattr *fattr, struct smb311_posix_qinfo *
 	if (symlink) {
 		fattr->cf_mode |= S_IFLNK;
 		fattr->cf_dtype = DT_LNK;
+		fattr->cf_symlink_target = data->symlink_target;
+		data->symlink_target = NULL;
 	} else if (fattr->cf_cifsattrs & ATTR_DIRECTORY) {
 		fattr->cf_mode |= S_IFDIR;
 		fattr->cf_dtype = DT_DIR;
@@ -655,13 +690,11 @@ smb311_posix_info_to_fattr(struct cifs_fattr *fattr, struct smb311_posix_qinfo *
 		fattr->cf_mode, fattr->cf_uniqueid, fattr->cf_nlink);
 }
 
-
-/* Fill a cifs_fattr struct with info from FILE_ALL_INFO */
-static void
-cifs_all_info_to_fattr(struct cifs_fattr *fattr, FILE_ALL_INFO *info,
-		       struct super_block *sb, bool adjust_tz,
-		       bool symlink, u32 reparse_tag)
+static void cifs_open_info_to_fattr(struct cifs_fattr *fattr, struct cifs_open_info_data *data,
+				    struct super_block *sb, bool adjust_tz, bool symlink,
+				    u32 reparse_tag)
 {
+	struct smb2_file_all_info *info = &data->fi;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
 
@@ -703,7 +736,8 @@ cifs_all_info_to_fattr(struct cifs_fattr *fattr, FILE_ALL_INFO *info,
 	} else if (reparse_tag == IO_REPARSE_TAG_LX_BLK) {
 		fattr->cf_mode |= S_IFBLK | cifs_sb->ctx->file_mode;
 		fattr->cf_dtype = DT_BLK;
-	} else if (symlink) { /* TODO add more reparse tag checks */
+	} else if (symlink || reparse_tag == IO_REPARSE_TAG_SYMLINK ||
+		   reparse_tag == IO_REPARSE_TAG_NFS) {
 		fattr->cf_mode = S_IFLNK;
 		fattr->cf_dtype = DT_LNK;
 	} else if (fattr->cf_cifsattrs & ATTR_DIRECTORY) {
@@ -735,6 +769,11 @@ cifs_all_info_to_fattr(struct cifs_fattr *fattr, FILE_ALL_INFO *info,
 		}
 	}
 
+	if (S_ISLNK(fattr->cf_mode)) {
+		fattr->cf_symlink_target = data->symlink_target;
+		data->symlink_target = NULL;
+	}
+
 	fattr->cf_uid = cifs_sb->ctx->linux_uid;
 	fattr->cf_gid = cifs_sb->ctx->linux_gid;
 }
@@ -744,23 +783,28 @@ cifs_get_file_info(struct file *filp)
 {
 	int rc;
 	unsigned int xid;
-	FILE_ALL_INFO find_data;
+	struct cifs_open_info_data data = {};
 	struct cifs_fattr fattr;
 	struct inode *inode = file_inode(filp);
 	struct cifsFileInfo *cfile = filp->private_data;
 	struct cifs_tcon *tcon = tlink_tcon(cfile->tlink);
 	struct TCP_Server_Info *server = tcon->ses->server;
+	bool symlink = false;
+	u32 tag = 0;
 
 	if (!server->ops->query_file_info)
 		return -ENOSYS;
 
 	xid = get_xid();
-	rc = server->ops->query_file_info(xid, tcon, &cfile->fid, &find_data);
+	rc = server->ops->query_file_info(xid, tcon, cfile, &data);
 	switch (rc) {
 	case 0:
 		/* TODO: add support to query reparse tag */
-		cifs_all_info_to_fattr(&fattr, &find_data, inode->i_sb, false,
-				       false, 0 /* no reparse tag */);
+		if (data.symlink_target) {
+			symlink = true;
+			tag = IO_REPARSE_TAG_SYMLINK;
+		}
+		cifs_open_info_to_fattr(&fattr, &data, inode->i_sb, false, symlink, tag);
 		break;
 	case -EREMOTE:
 		cifs_create_dfs_fattr(&fattr, inode->i_sb);
@@ -789,6 +833,7 @@ cifs_get_file_info(struct file *filp)
 	/* if filetype is different, return error */
 	rc = cifs_fattr_to_inode(inode, &fattr);
 cgfi_exit:
+	cifs_free_open_info(&data);
 	free_xid(xid);
 	return rc;
 }
@@ -860,14 +905,9 @@ cifs_backup_query_path_info(int xid,
 }
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 
-static void
-cifs_set_fattr_ino(int xid,
-		   struct cifs_tcon *tcon,
-		   struct super_block *sb,
-		   struct inode **inode,
-		   const char *full_path,
-		   FILE_ALL_INFO *data,
-		   struct cifs_fattr *fattr)
+static void cifs_set_fattr_ino(int xid, struct cifs_tcon *tcon, struct super_block *sb,
+			       struct inode **inode, const char *full_path,
+			       struct cifs_open_info_data *data, struct cifs_fattr *fattr)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct TCP_Server_Info *server = tcon->ses->server;
@@ -885,11 +925,8 @@ cifs_set_fattr_ino(int xid,
 	 * If we have an inode pass a NULL tcon to ensure we don't
 	 * make a round trip to the server. This only works for SMB2+.
 	 */
-	rc = server->ops->get_srv_inum(xid,
-				       *inode ? NULL : tcon,
-				       cifs_sb, full_path,
-				       &fattr->cf_uniqueid,
-				       data);
+	rc = server->ops->get_srv_inum(xid, *inode ? NULL : tcon, cifs_sb, full_path,
+				       &fattr->cf_uniqueid, data);
 	if (rc) {
 		/*
 		 * If that fails reuse existing ino or generate one
@@ -923,14 +960,10 @@ static inline bool is_inode_cache_good(struct inode *ino)
 	return ino && CIFS_CACHE_READ(CIFS_I(ino)) && CIFS_I(ino)->time != 0;
 }
 
-int
-cifs_get_inode_info(struct inode **inode,
-		    const char *full_path,
-		    FILE_ALL_INFO *in_data,
-		    struct super_block *sb, int xid,
-		    const struct cifs_fid *fid)
+int cifs_get_inode_info(struct inode **inode, const char *full_path,
+			struct cifs_open_info_data *data, struct super_block *sb, int xid,
+			const struct cifs_fid *fid)
 {
-
 	struct cifs_tcon *tcon;
 	struct TCP_Server_Info *server;
 	struct tcon_link *tlink;
@@ -938,8 +971,7 @@ cifs_get_inode_info(struct inode **inode,
 	bool adjust_tz = false;
 	struct cifs_fattr fattr = {0};
 	bool is_reparse_point = false;
-	FILE_ALL_INFO *data = in_data;
-	FILE_ALL_INFO *tmp_data = NULL;
+	struct cifs_open_info_data tmp_data = {};
 	void *smb1_backup_rsp_buf = NULL;
 	int rc = 0;
 	int tmprc = 0;
@@ -960,21 +992,15 @@ cifs_get_inode_info(struct inode **inode,
 			cifs_dbg(FYI, "No need to revalidate cached inode sizes\n");
 			goto out;
 		}
-		tmp_data = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
-		if (!tmp_data) {
-			rc = -ENOMEM;
-			goto out;
-		}
-		rc = server->ops->query_path_info(xid, tcon, cifs_sb,
-						 full_path, tmp_data,
-						 &adjust_tz, &is_reparse_point);
+		rc = server->ops->query_path_info(xid, tcon, cifs_sb, full_path, &tmp_data,
+						  &adjust_tz, &is_reparse_point);
 #ifdef CONFIG_CIFS_DFS_UPCALL
 		if (rc == -ENOENT && is_tcon_dfs(tcon))
 			rc = cifs_dfs_query_info_nonascii_quirk(xid, tcon,
 								cifs_sb,
 								full_path);
 #endif
-		data = tmp_data;
+		data = &tmp_data;
 	}
 
 	/*
@@ -988,14 +1014,24 @@ cifs_get_inode_info(struct inode **inode,
 		 * since we have to check if its reparse tag matches a known
 		 * special file type e.g. symlink or fifo or char etc.
 		 */
-		if ((le32_to_cpu(data->Attributes) & ATTR_REPARSE) &&
-		    server->ops->query_reparse_tag) {
-			rc = server->ops->query_reparse_tag(xid, tcon, cifs_sb,
-						full_path, &reparse_tag);
-			cifs_dbg(FYI, "reparse tag 0x%x\n", reparse_tag);
+		if (is_reparse_point && data->symlink_target) {
+			reparse_tag = IO_REPARSE_TAG_SYMLINK;
+		} else if ((le32_to_cpu(data->fi.Attributes) & ATTR_REPARSE) &&
+			   server->ops->query_reparse_tag) {
+			tmprc = server->ops->query_reparse_tag(xid, tcon, cifs_sb, full_path,
+							    &reparse_tag);
+			if (tmprc)
+				cifs_dbg(FYI, "%s: query_reparse_tag: rc = %d\n", __func__, tmprc);
+			if (server->ops->query_symlink) {
+				tmprc = server->ops->query_symlink(xid, tcon, cifs_sb, full_path,
+								   &data->symlink_target,
+								   is_reparse_point);
+				if (tmprc)
+					cifs_dbg(FYI, "%s: query_symlink: rc = %d\n", __func__,
+						 tmprc);
+			}
 		}
-		cifs_all_info_to_fattr(&fattr, data, sb, adjust_tz,
-				       is_reparse_point, reparse_tag);
+		cifs_open_info_to_fattr(&fattr, data, sb, adjust_tz, is_reparse_point, reparse_tag);
 		break;
 	case -EREMOTE:
 		/* DFS link, no metadata available on this server */
@@ -1014,18 +1050,20 @@ cifs_get_inode_info(struct inode **inode,
 		 */
 		if (backup_cred(cifs_sb) && is_smb1_server(server)) {
 			/* for easier reading */
+			FILE_ALL_INFO *fi;
 			FILE_DIRECTORY_INFO *fdi;
 			SEARCH_ID_FULL_DIR_INFO *si;
 
 			rc = cifs_backup_query_path_info(xid, tcon, sb,
 							 full_path,
 							 &smb1_backup_rsp_buf,
-							 &data);
+							 &fi);
 			if (rc)
 				goto out;
 
-			fdi = (FILE_DIRECTORY_INFO *)data;
-			si = (SEARCH_ID_FULL_DIR_INFO *)data;
+			move_cifs_info_to_smb2(&data->fi, fi);
+			fdi = (FILE_DIRECTORY_INFO *)fi;
+			si = (SEARCH_ID_FULL_DIR_INFO *)fi;
 
 			cifs_dir_info_to_fattr(&fattr, fdi, cifs_sb);
 			fattr.cf_uniqueid = le64_to_cpu(si->UniqueId);
@@ -1123,7 +1161,8 @@ cifs_get_inode_info(struct inode **inode,
 out:
 	cifs_buf_release(smb1_backup_rsp_buf);
 	cifs_put_tlink(tlink);
-	kfree(tmp_data);
+	cifs_free_open_info(&tmp_data);
+	kfree(fattr.cf_symlink_target);
 	return rc;
 }
 
@@ -1138,7 +1177,7 @@ smb311_posix_get_inode_info(struct inode **inode,
 	bool adjust_tz = false;
 	struct cifs_fattr fattr = {0};
 	bool symlink = false;
-	struct smb311_posix_qinfo *data = NULL;
+	struct cifs_open_info_data data = {};
 	int rc = 0;
 	int tmprc = 0;
 
@@ -1155,15 +1194,9 @@ smb311_posix_get_inode_info(struct inode **inode,
 		cifs_dbg(FYI, "No need to revalidate cached inode sizes\n");
 		goto out;
 	}
-	data = kmalloc(sizeof(struct smb311_posix_qinfo), GFP_KERNEL);
-	if (!data) {
-		rc = -ENOMEM;
-		goto out;
-	}
 
-	rc = smb311_posix_query_path_info(xid, tcon, cifs_sb,
-						  full_path, data,
-						  &adjust_tz, &symlink);
+	rc = smb311_posix_query_path_info(xid, tcon, cifs_sb, full_path, &data, &adjust_tz,
+					  &symlink);
 
 	/*
 	 * 2. Convert it to internal cifs metadata (fattr)
@@ -1171,7 +1204,7 @@ smb311_posix_get_inode_info(struct inode **inode,
 
 	switch (rc) {
 	case 0:
-		smb311_posix_info_to_fattr(&fattr, data, sb, adjust_tz, symlink);
+		smb311_posix_info_to_fattr(&fattr, &data, sb, adjust_tz, symlink);
 		break;
 	case -EREMOTE:
 		/* DFS link, no metadata available on this server */
@@ -1228,7 +1261,8 @@ smb311_posix_get_inode_info(struct inode **inode,
 	}
 out:
 	cifs_put_tlink(tlink);
-	kfree(data);
+	cifs_free_open_info(&data);
+	kfree(fattr.cf_symlink_target);
 	return rc;
 }
 
diff --git a/fs/cifs/link.c b/fs/cifs/link.c
index cd29c296cec6..bd374feeccaa 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -201,40 +201,6 @@ create_mf_symlink(const unsigned int xid, struct cifs_tcon *tcon,
 	return rc;
 }
 
-static int
-query_mf_symlink(const unsigned int xid, struct cifs_tcon *tcon,
-		 struct cifs_sb_info *cifs_sb, const unsigned char *path,
-		 char **symlinkinfo)
-{
-	int rc;
-	u8 *buf = NULL;
-	unsigned int link_len = 0;
-	unsigned int bytes_read = 0;
-
-	buf = kmalloc(CIFS_MF_SYMLINK_FILE_SIZE, GFP_KERNEL);
-	if (!buf)
-		return -ENOMEM;
-
-	if (tcon->ses->server->ops->query_mf_symlink)
-		rc = tcon->ses->server->ops->query_mf_symlink(xid, tcon,
-					      cifs_sb, path, buf, &bytes_read);
-	else
-		rc = -ENOSYS;
-
-	if (rc)
-		goto out;
-
-	if (bytes_read == 0) { /* not a symlink */
-		rc = -EINVAL;
-		goto out;
-	}
-
-	rc = parse_mf_symlink(buf, bytes_read, &link_len, symlinkinfo);
-out:
-	kfree(buf);
-	return rc;
-}
-
 int
 check_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 		 struct cifs_sb_info *cifs_sb, struct cifs_fattr *fattr,
@@ -244,6 +210,7 @@ check_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	u8 *buf = NULL;
 	unsigned int link_len = 0;
 	unsigned int bytes_read = 0;
+	char *symlink = NULL;
 
 	if (!couldbe_mf_symlink(fattr))
 		/* it's not a symlink */
@@ -265,7 +232,7 @@ check_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	if (bytes_read == 0) /* not a symlink */
 		goto out;
 
-	rc = parse_mf_symlink(buf, bytes_read, &link_len, NULL);
+	rc = parse_mf_symlink(buf, bytes_read, &link_len, &symlink);
 	if (rc == -EINVAL) {
 		/* it's not a symlink */
 		rc = 0;
@@ -280,6 +247,7 @@ check_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	fattr->cf_mode &= ~S_IFMT;
 	fattr->cf_mode |= S_IFLNK | S_IRWXU | S_IRWXG | S_IRWXO;
 	fattr->cf_dtype = DT_LNK;
+	fattr->cf_symlink_target = symlink;
 out:
 	kfree(buf);
 	return rc;
@@ -599,75 +567,6 @@ cifs_hardlink(struct dentry *old_file, struct inode *inode,
 	return rc;
 }
 
-const char *
-cifs_get_link(struct dentry *direntry, struct inode *inode,
-	      struct delayed_call *done)
-{
-	int rc = -ENOMEM;
-	unsigned int xid;
-	const char *full_path;
-	void *page;
-	char *target_path = NULL;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
-	struct tcon_link *tlink = NULL;
-	struct cifs_tcon *tcon;
-	struct TCP_Server_Info *server;
-
-	if (!direntry)
-		return ERR_PTR(-ECHILD);
-
-	xid = get_xid();
-
-	tlink = cifs_sb_tlink(cifs_sb);
-	if (IS_ERR(tlink)) {
-		free_xid(xid);
-		return ERR_CAST(tlink);
-	}
-	tcon = tlink_tcon(tlink);
-	server = tcon->ses->server;
-
-	page = alloc_dentry_path();
-	full_path = build_path_from_dentry(direntry, page);
-	if (IS_ERR(full_path)) {
-		free_xid(xid);
-		cifs_put_tlink(tlink);
-		free_dentry_path(page);
-		return ERR_CAST(full_path);
-	}
-
-	cifs_dbg(FYI, "Full path: %s inode = 0x%p\n", full_path, inode);
-
-	rc = -EACCES;
-	/*
-	 * First try Minshall+French Symlinks, if configured
-	 * and fallback to UNIX Extensions Symlinks.
-	 */
-	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_MF_SYMLINKS)
-		rc = query_mf_symlink(xid, tcon, cifs_sb, full_path,
-				      &target_path);
-
-	if (rc != 0 && server->ops->query_symlink) {
-		struct cifsInodeInfo *cifsi = CIFS_I(inode);
-		bool reparse_point = false;
-
-		if (cifsi->cifsAttrs & ATTR_REPARSE)
-			reparse_point = true;
-
-		rc = server->ops->query_symlink(xid, tcon, cifs_sb, full_path,
-						&target_path, reparse_point);
-	}
-
-	free_dentry_path(page);
-	free_xid(xid);
-	cifs_put_tlink(tlink);
-	if (rc != 0) {
-		kfree(target_path);
-		return ERR_PTR(rc);
-	}
-	set_delayed_call(done, kfree_link, target_path);
-	return target_path;
-}
-
 int
 cifs_symlink(struct user_namespace *mnt_userns, struct inode *inode,
 	     struct dentry *direntry, const char *symname)
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 8e060c00c969..6a78bcc51e81 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -994,6 +994,8 @@ static int cifs_filldir(char *find_entry, struct file *file,
 		cifs_unix_basic_to_fattr(&fattr,
 					 &((FILE_UNIX_INFO *)find_entry)->basic,
 					 cifs_sb);
+		if (S_ISLNK(fattr.cf_mode))
+			fattr.cf_flags |= CIFS_FATTR_NEED_REVAL;
 		break;
 	case SMB_FIND_FILE_INFO_STANDARD:
 		cifs_std_info_to_fattr(&fattr,
diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
index f36b2d2d40ca..50480751e521 100644
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -542,31 +542,32 @@ cifs_is_path_accessible(const unsigned int xid, struct cifs_tcon *tcon,
 	return rc;
 }
 
-static int
-cifs_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
-		     struct cifs_sb_info *cifs_sb, const char *full_path,
-		     FILE_ALL_INFO *data, bool *adjustTZ, bool *symlink)
+static int cifs_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
+				struct cifs_sb_info *cifs_sb, const char *full_path,
+				struct cifs_open_info_data *data, bool *adjustTZ, bool *symlink)
 {
 	int rc;
+	FILE_ALL_INFO fi = {};
 
 	*symlink = false;
 
 	/* could do find first instead but this returns more info */
-	rc = CIFSSMBQPathInfo(xid, tcon, full_path, data, 0 /* not legacy */,
-			      cifs_sb->local_nls, cifs_remap(cifs_sb));
+	rc = CIFSSMBQPathInfo(xid, tcon, full_path, &fi, 0 /* not legacy */, cifs_sb->local_nls,
+			      cifs_remap(cifs_sb));
 	/*
 	 * BB optimize code so we do not make the above call when server claims
 	 * no NT SMB support and the above call failed at least once - set flag
 	 * in tcon or mount.
 	 */
 	if ((rc == -EOPNOTSUPP) || (rc == -EINVAL)) {
-		rc = SMBQueryInformation(xid, tcon, full_path, data,
-					 cifs_sb->local_nls,
+		rc = SMBQueryInformation(xid, tcon, full_path, &fi, cifs_sb->local_nls,
 					 cifs_remap(cifs_sb));
+		if (!rc)
+			move_cifs_info_to_smb2(&data->fi, &fi);
 		*adjustTZ = true;
 	}
 
-	if (!rc && (le32_to_cpu(data->Attributes) & ATTR_REPARSE)) {
+	if (!rc && (le32_to_cpu(fi.Attributes) & ATTR_REPARSE)) {
 		int tmprc;
 		int oplock = 0;
 		struct cifs_fid fid;
@@ -592,10 +593,9 @@ cifs_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
 	return rc;
 }
 
-static int
-cifs_get_srv_inum(const unsigned int xid, struct cifs_tcon *tcon,
-		  struct cifs_sb_info *cifs_sb, const char *full_path,
-		  u64 *uniqueid, FILE_ALL_INFO *data)
+static int cifs_get_srv_inum(const unsigned int xid, struct cifs_tcon *tcon,
+			     struct cifs_sb_info *cifs_sb, const char *full_path,
+			     u64 *uniqueid, struct cifs_open_info_data *unused)
 {
 	/*
 	 * We can not use the IndexNumber field by default from Windows or
@@ -613,11 +613,22 @@ cifs_get_srv_inum(const unsigned int xid, struct cifs_tcon *tcon,
 				     cifs_remap(cifs_sb));
 }
 
-static int
-cifs_query_file_info(const unsigned int xid, struct cifs_tcon *tcon,
-		     struct cifs_fid *fid, FILE_ALL_INFO *data)
+static int cifs_query_file_info(const unsigned int xid, struct cifs_tcon *tcon,
+				struct cifsFileInfo *cfile, struct cifs_open_info_data *data)
 {
-	return CIFSSMBQFileInfo(xid, tcon, fid->netfid, data);
+	int rc;
+	FILE_ALL_INFO fi = {};
+
+	if (cfile->symlink_target) {
+		data->symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
+		if (!data->symlink_target)
+			return -ENOMEM;
+	}
+
+	rc = CIFSSMBQFileInfo(xid, tcon, cfile->fid.netfid, &fi);
+	if (!rc)
+		move_cifs_info_to_smb2(&data->fi, &fi);
+	return rc;
 }
 
 static void
@@ -702,19 +713,20 @@ cifs_mkdir_setinfo(struct inode *inode, const char *full_path,
 		cifsInode->cifsAttrs = dosattrs;
 }
 
-static int
-cifs_open_file(const unsigned int xid, struct cifs_open_parms *oparms,
-	       __u32 *oplock, FILE_ALL_INFO *buf)
+static int cifs_open_file(const unsigned int xid, struct cifs_open_parms *oparms, __u32 *oplock,
+			  void *buf)
 {
+	FILE_ALL_INFO *fi = buf;
+
 	if (!(oparms->tcon->ses->capabilities & CAP_NT_SMBS))
 		return SMBLegacyOpen(xid, oparms->tcon, oparms->path,
 				     oparms->disposition,
 				     oparms->desired_access,
 				     oparms->create_options,
-				     &oparms->fid->netfid, oplock, buf,
+				     &oparms->fid->netfid, oplock, fi,
 				     oparms->cifs_sb->local_nls,
 				     cifs_remap(oparms->cifs_sb));
-	return CIFS_open(xid, oparms, oplock, buf);
+	return CIFS_open(xid, oparms, oplock, fi);
 }
 
 static void
diff --git a/fs/cifs/smb2file.c b/fs/cifs/smb2file.c
index 9dfd2dd612c2..4992b43616a7 100644
--- a/fs/cifs/smb2file.c
+++ b/fs/cifs/smb2file.c
@@ -20,40 +20,125 @@
 #include "cifs_unicode.h"
 #include "fscache.h"
 #include "smb2proto.h"
+#include "smb2status.h"
 
-int
-smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms,
-	       __u32 *oplock, FILE_ALL_INFO *buf)
+static struct smb2_symlink_err_rsp *symlink_data(const struct kvec *iov)
+{
+	struct smb2_err_rsp *err = iov->iov_base;
+	struct smb2_symlink_err_rsp *sym = ERR_PTR(-EINVAL);
+	u32 len;
+
+	if (err->ErrorContextCount) {
+		struct smb2_error_context_rsp *p, *end;
+
+		len = (u32)err->ErrorContextCount * (offsetof(struct smb2_error_context_rsp,
+							      ErrorContextData) +
+						     sizeof(struct smb2_symlink_err_rsp));
+		if (le32_to_cpu(err->ByteCount) < len || iov->iov_len < len + sizeof(*err))
+			return ERR_PTR(-EINVAL);
+
+		p = (struct smb2_error_context_rsp *)err->ErrorData;
+		end = (struct smb2_error_context_rsp *)((u8 *)err + iov->iov_len);
+		do {
+			if (le32_to_cpu(p->ErrorId) == SMB2_ERROR_ID_DEFAULT) {
+				sym = (struct smb2_symlink_err_rsp *)&p->ErrorContextData;
+				break;
+			}
+			cifs_dbg(FYI, "%s: skipping unhandled error context: 0x%x\n",
+				 __func__, le32_to_cpu(p->ErrorId));
+
+			len = ALIGN(le32_to_cpu(p->ErrorDataLength), 8);
+			p = (struct smb2_error_context_rsp *)((u8 *)&p->ErrorContextData + len);
+		} while (p < end);
+	} else if (le32_to_cpu(err->ByteCount) >= sizeof(*sym) &&
+		   iov->iov_len >= SMB2_SYMLINK_STRUCT_SIZE) {
+		sym = (struct smb2_symlink_err_rsp *)err->ErrorData;
+	}
+
+	if (!IS_ERR(sym) && (le32_to_cpu(sym->SymLinkErrorTag) != SYMLINK_ERROR_TAG ||
+			     le32_to_cpu(sym->ReparseTag) != IO_REPARSE_TAG_SYMLINK))
+		sym = ERR_PTR(-EINVAL);
+
+	return sym;
+}
+
+int smb2_parse_symlink_response(struct cifs_sb_info *cifs_sb, const struct kvec *iov, char **path)
+{
+	struct smb2_symlink_err_rsp *sym;
+	unsigned int sub_offs, sub_len;
+	unsigned int print_offs, print_len;
+	char *s;
+
+	if (!cifs_sb || !iov || !iov->iov_base || !iov->iov_len || !path)
+		return -EINVAL;
+
+	sym = symlink_data(iov);
+	if (IS_ERR(sym))
+		return PTR_ERR(sym);
+
+	sub_len = le16_to_cpu(sym->SubstituteNameLength);
+	sub_offs = le16_to_cpu(sym->SubstituteNameOffset);
+	print_len = le16_to_cpu(sym->PrintNameLength);
+	print_offs = le16_to_cpu(sym->PrintNameOffset);
+
+	if (iov->iov_len < SMB2_SYMLINK_STRUCT_SIZE + sub_offs + sub_len ||
+	    iov->iov_len < SMB2_SYMLINK_STRUCT_SIZE + print_offs + print_len)
+		return -EINVAL;
+
+	s = cifs_strndup_from_utf16((char *)sym->PathBuffer + sub_offs, sub_len, true,
+				    cifs_sb->local_nls);
+	if (!s)
+		return -ENOMEM;
+	convert_delimiter(s, '/');
+	cifs_dbg(FYI, "%s: symlink target: %s\n", __func__, s);
+
+	*path = s;
+	return 0;
+}
+
+int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms, __u32 *oplock, void *buf)
 {
 	int rc;
 	__le16 *smb2_path;
-	struct smb2_file_all_info *smb2_data = NULL;
 	__u8 smb2_oplock;
+	struct cifs_open_info_data *data = buf;
+	struct smb2_file_all_info file_info = {};
+	struct smb2_file_all_info *smb2_data = data ? &file_info : NULL;
+	struct kvec err_iov = {};
+	int err_buftype = CIFS_NO_BUFFER;
 	struct cifs_fid *fid = oparms->fid;
 	struct network_resiliency_req nr_ioctl_req;
 
 	smb2_path = cifs_convert_path_to_utf16(oparms->path, oparms->cifs_sb);
-	if (smb2_path == NULL) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
-	smb2_data = kzalloc(sizeof(struct smb2_file_all_info) + PATH_MAX * 2,
-			    GFP_KERNEL);
-	if (smb2_data == NULL) {
-		rc = -ENOMEM;
-		goto out;
-	}
+	if (smb2_path == NULL)
+		return -ENOMEM;
 
 	oparms->desired_access |= FILE_READ_ATTRIBUTES;
 	smb2_oplock = SMB2_OPLOCK_LEVEL_BATCH;
 
-	rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock, smb2_data, NULL,
-		       NULL, NULL);
+	rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock, smb2_data, NULL, &err_iov,
+		       &err_buftype);
+	if (rc && data) {
+		struct smb2_hdr *hdr = err_iov.iov_base;
+
+		if (unlikely(!err_iov.iov_base || err_buftype == CIFS_NO_BUFFER))
+			rc = -ENOMEM;
+		else if (hdr->Status == STATUS_STOPPED_ON_SYMLINK && oparms->cifs_sb) {
+			rc = smb2_parse_symlink_response(oparms->cifs_sb, &err_iov,
+							 &data->symlink_target);
+			if (!rc) {
+				memset(smb2_data, 0, sizeof(*smb2_data));
+				oparms->create_options |= OPEN_REPARSE_POINT;
+				rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock, smb2_data,
+					       NULL, NULL, NULL);
+				oparms->create_options &= ~OPEN_REPARSE_POINT;
+			}
+		}
+	}
+
 	if (rc)
 		goto out;
 
-
 	if (oparms->tcon->use_resilient) {
 		/* default timeout is 0, servers pick default (120 seconds) */
 		nr_ioctl_req.Timeout =
@@ -73,7 +158,7 @@ smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms,
 		rc = 0;
 	}
 
-	if (buf) {
+	if (smb2_data) {
 		/* if open response does not have IndexNumber field - get it */
 		if (smb2_data->IndexNumber == 0) {
 			rc = SMB2_get_srv_num(xid, oparms->tcon,
@@ -89,12 +174,12 @@ smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms,
 				rc = 0;
 			}
 		}
-		move_smb2_info_to_cifs(buf, smb2_data);
+		memcpy(&data->fi, smb2_data, sizeof(data->fi));
 	}
 
 	*oplock = smb2_oplock;
 out:
-	kfree(smb2_data);
+	free_rsp_buf(err_buftype, err_iov.iov_base);
 	kfree(smb2_path);
 	return rc;
 }
diff --git a/fs/cifs/smb2inode.c b/fs/cifs/smb2inode.c
index bb3e3d5a0cda..adf71b328f32 100644
--- a/fs/cifs/smb2inode.c
+++ b/fs/cifs/smb2inode.c
@@ -24,6 +24,7 @@
 #include "smb2pdu.h"
 #include "smb2proto.h"
 #include "cached_dir.h"
+#include "smb2status.h"
 
 static void
 free_set_inf_compound(struct smb_rqst *rqst)
@@ -50,13 +51,15 @@ struct cop_vars {
 /*
  * note: If cfile is passed, the reference to it is dropped here.
  * So make sure that you do not reuse cfile after return from this func.
+ *
+ * If passing @err_iov and @err_buftype, ensure to make them both large enough (>= 3) to hold all
+ * error responses.  Caller is also responsible for freeing them up.
  */
-static int
-smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
-		 struct cifs_sb_info *cifs_sb, const char *full_path,
-		 __u32 desired_access, __u32 create_disposition,
-		 __u32 create_options, umode_t mode, void *ptr, int command,
-		 struct cifsFileInfo *cfile)
+static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
+			    struct cifs_sb_info *cifs_sb, const char *full_path,
+			    __u32 desired_access, __u32 create_disposition, __u32 create_options,
+			    umode_t mode, void *ptr, int command, struct cifsFileInfo *cfile,
+			    struct kvec *err_iov, int *err_buftype)
 {
 	struct cop_vars *vars = NULL;
 	struct kvec *rsp_iov;
@@ -70,6 +73,7 @@ smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 	int num_rqst = 0;
 	int resp_buftype[3];
 	struct smb2_query_info_rsp *qi_rsp = NULL;
+	struct cifs_open_info_data *idata;
 	int flags = 0;
 	__u8 delete_pending[8] = {1, 0, 0, 0, 0, 0, 0, 0};
 	unsigned int size[2];
@@ -385,14 +389,19 @@ smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 
 	switch (command) {
 	case SMB2_OP_QUERY_INFO:
+		idata = ptr;
+		if (rc == 0 && cfile && cfile->symlink_target) {
+			idata->symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
+			if (!idata->symlink_target)
+				rc = -ENOMEM;
+		}
 		if (rc == 0) {
 			qi_rsp = (struct smb2_query_info_rsp *)
 				rsp_iov[1].iov_base;
 			rc = smb2_validate_and_copy_iov(
 				le16_to_cpu(qi_rsp->OutputBufferOffset),
 				le32_to_cpu(qi_rsp->OutputBufferLength),
-				&rsp_iov[1], sizeof(struct smb2_file_all_info),
-				ptr);
+				&rsp_iov[1], sizeof(idata->fi), (char *)&idata->fi);
 		}
 		if (rqst[1].rq_iov)
 			SMB2_query_info_free(&rqst[1]);
@@ -406,13 +415,19 @@ smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 						tcon->tid);
 		break;
 	case SMB2_OP_POSIX_QUERY_INFO:
+		if (rc == 0 && cfile && cfile->symlink_target) {
+			idata->symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
+			if (!idata->symlink_target)
+				rc = -ENOMEM;
+		}
 		if (rc == 0) {
 			qi_rsp = (struct smb2_query_info_rsp *)
 				rsp_iov[1].iov_base;
 			rc = smb2_validate_and_copy_iov(
 				le16_to_cpu(qi_rsp->OutputBufferOffset),
 				le32_to_cpu(qi_rsp->OutputBufferLength),
-				&rsp_iov[1], sizeof(struct smb311_posix_qinfo) /* add SIDs */, ptr);
+				&rsp_iov[1], sizeof(idata->posix_fi) /* add SIDs */,
+				(char *)&idata->posix_fi);
 		}
 		if (rqst[1].rq_iov)
 			SMB2_query_info_free(&rqst[1]);
@@ -477,42 +492,33 @@ smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 		free_set_inf_compound(rqst);
 		break;
 	}
-	free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
-	free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
-	free_rsp_buf(resp_buftype[2], rsp_iov[2].iov_base);
+
+	if (rc && err_iov && err_buftype) {
+		memcpy(err_iov, rsp_iov, 3 * sizeof(*err_iov));
+		memcpy(err_buftype, resp_buftype, 3 * sizeof(*err_buftype));
+	} else {
+		free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
+		free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
+		free_rsp_buf(resp_buftype[2], rsp_iov[2].iov_base);
+	}
 	kfree(vars);
 	return rc;
 }
 
-void
-move_smb2_info_to_cifs(FILE_ALL_INFO *dst, struct smb2_file_all_info *src)
-{
-	memcpy(dst, src, (size_t)(&src->CurrentByteOffset) - (size_t)src);
-	dst->CurrentByteOffset = src->CurrentByteOffset;
-	dst->Mode = src->Mode;
-	dst->AlignmentRequirement = src->AlignmentRequirement;
-	dst->IndexNumber1 = 0; /* we don't use it */
-}
-
-int
-smb2_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
-		     struct cifs_sb_info *cifs_sb, const char *full_path,
-		     FILE_ALL_INFO *data, bool *adjust_tz, bool *reparse)
+int smb2_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
+			 struct cifs_sb_info *cifs_sb, const char *full_path,
+			 struct cifs_open_info_data *data, bool *adjust_tz, bool *reparse)
 {
 	int rc;
-	struct smb2_file_all_info *smb2_data;
 	__u32 create_options = 0;
 	struct cifsFileInfo *cfile;
 	struct cached_fid *cfid = NULL;
+	struct kvec err_iov[3] = {};
+	int err_buftype[3] = {};
 
 	*adjust_tz = false;
 	*reparse = false;
 
-	smb2_data = kzalloc(sizeof(struct smb2_file_all_info) + PATH_MAX * 2,
-			    GFP_KERNEL);
-	if (smb2_data == NULL)
-		return -ENOMEM;
-
 	if (strcmp(full_path, ""))
 		rc = -ENOENT;
 	else
@@ -520,63 +526,58 @@ smb2_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
 	/* If it is a root and its handle is cached then use it */
 	if (!rc) {
 		if (cfid->file_all_info_is_valid) {
-			move_smb2_info_to_cifs(data,
-					       &cfid->file_all_info);
+			memcpy(&data->fi, &cfid->file_all_info, sizeof(data->fi));
 		} else {
-			rc = SMB2_query_info(xid, tcon,
-					     cfid->fid.persistent_fid,
-					     cfid->fid.volatile_fid, smb2_data);
-			if (!rc)
-				move_smb2_info_to_cifs(data, smb2_data);
+			rc = SMB2_query_info(xid, tcon, cfid->fid.persistent_fid,
+					     cfid->fid.volatile_fid, &data->fi);
 		}
 		close_cached_dir(cfid);
-		goto out;
+		return rc;
 	}
 
 	cifs_get_readable_path(tcon, full_path, &cfile);
-	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
-			      FILE_READ_ATTRIBUTES, FILE_OPEN, create_options,
-			      ACL_NO_MODE, smb2_data, SMB2_OP_QUERY_INFO, cfile);
+	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path, FILE_READ_ATTRIBUTES, FILE_OPEN,
+			      create_options, ACL_NO_MODE, data, SMB2_OP_QUERY_INFO, cfile,
+			      err_iov, err_buftype);
 	if (rc == -EOPNOTSUPP) {
+		if (err_iov[0].iov_base && err_buftype[0] != CIFS_NO_BUFFER &&
+		    ((struct smb2_hdr *)err_iov[0].iov_base)->Command == SMB2_CREATE &&
+		    ((struct smb2_hdr *)err_iov[0].iov_base)->Status == STATUS_STOPPED_ON_SYMLINK) {
+			rc = smb2_parse_symlink_response(cifs_sb, err_iov, &data->symlink_target);
+			if (rc)
+				goto out;
+		}
 		*reparse = true;
 		create_options |= OPEN_REPARSE_POINT;
 
 		/* Failed on a symbolic link - query a reparse point info */
 		cifs_get_readable_path(tcon, full_path, &cfile);
-		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
-				      FILE_READ_ATTRIBUTES, FILE_OPEN,
-				      create_options, ACL_NO_MODE,
-				      smb2_data, SMB2_OP_QUERY_INFO, cfile);
+		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path, FILE_READ_ATTRIBUTES,
+				      FILE_OPEN, create_options, ACL_NO_MODE, data,
+				      SMB2_OP_QUERY_INFO, cfile, NULL, NULL);
 	}
-	if (rc)
-		goto out;
 
-	move_smb2_info_to_cifs(data, smb2_data);
 out:
-	kfree(smb2_data);
+	free_rsp_buf(err_buftype[0], err_iov[0].iov_base);
+	free_rsp_buf(err_buftype[1], err_iov[1].iov_base);
+	free_rsp_buf(err_buftype[2], err_iov[2].iov_base);
 	return rc;
 }
 
 
-int
-smb311_posix_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
-		     struct cifs_sb_info *cifs_sb, const char *full_path,
-		     struct smb311_posix_qinfo *data, bool *adjust_tz, bool *reparse)
+int smb311_posix_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
+				 struct cifs_sb_info *cifs_sb, const char *full_path,
+				 struct cifs_open_info_data *data, bool *adjust_tz, bool *reparse)
 {
 	int rc;
 	__u32 create_options = 0;
 	struct cifsFileInfo *cfile;
-	struct smb311_posix_qinfo *smb2_data;
+	struct kvec err_iov[3] = {};
+	int err_buftype[3] = {};
 
 	*adjust_tz = false;
 	*reparse = false;
 
-	/* BB TODO: Make struct larger when add support for parsing owner SIDs */
-	smb2_data = kzalloc(sizeof(struct smb311_posix_qinfo),
-			    GFP_KERNEL);
-	if (smb2_data == NULL)
-		return -ENOMEM;
-
 	/*
 	 * BB TODO: Add support for using the cached root handle.
 	 * Create SMB2_query_posix_info worker function to do non-compounded query
@@ -585,29 +586,32 @@ smb311_posix_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
 	 */
 
 	cifs_get_readable_path(tcon, full_path, &cfile);
-	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
-			      FILE_READ_ATTRIBUTES, FILE_OPEN, create_options,
-			      ACL_NO_MODE, smb2_data, SMB2_OP_POSIX_QUERY_INFO, cfile);
+	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path, FILE_READ_ATTRIBUTES, FILE_OPEN,
+			      create_options, ACL_NO_MODE, data, SMB2_OP_POSIX_QUERY_INFO, cfile,
+			      err_iov, err_buftype);
 	if (rc == -EOPNOTSUPP) {
 		/* BB TODO: When support for special files added to Samba re-verify this path */
+		if (err_iov[0].iov_base && err_buftype[0] != CIFS_NO_BUFFER &&
+		    ((struct smb2_hdr *)err_iov[0].iov_base)->Command == SMB2_CREATE &&
+		    ((struct smb2_hdr *)err_iov[0].iov_base)->Status == STATUS_STOPPED_ON_SYMLINK) {
+			rc = smb2_parse_symlink_response(cifs_sb, err_iov, &data->symlink_target);
+			if (rc)
+				goto out;
+		}
 		*reparse = true;
 		create_options |= OPEN_REPARSE_POINT;
 
 		/* Failed on a symbolic link - query a reparse point info */
 		cifs_get_readable_path(tcon, full_path, &cfile);
-		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
-				      FILE_READ_ATTRIBUTES, FILE_OPEN,
-				      create_options, ACL_NO_MODE,
-				      smb2_data, SMB2_OP_POSIX_QUERY_INFO, cfile);
+		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path, FILE_READ_ATTRIBUTES,
+				      FILE_OPEN, create_options, ACL_NO_MODE, data,
+				      SMB2_OP_POSIX_QUERY_INFO, cfile, NULL, NULL);
 	}
-	if (rc)
-		goto out;
-
-	 /* TODO: will need to allow for the 2 SIDs when add support for getting owner UID/GID */
-	memcpy(data, smb2_data, sizeof(struct smb311_posix_qinfo));
 
 out:
-	kfree(smb2_data);
+	free_rsp_buf(err_buftype[0], err_iov[0].iov_base);
+	free_rsp_buf(err_buftype[1], err_iov[1].iov_base);
+	free_rsp_buf(err_buftype[2], err_iov[2].iov_base);
 	return rc;
 }
 
@@ -619,7 +623,7 @@ smb2_mkdir(const unsigned int xid, struct inode *parent_inode, umode_t mode,
 	return smb2_compound_op(xid, tcon, cifs_sb, name,
 				FILE_WRITE_ATTRIBUTES, FILE_CREATE,
 				CREATE_NOT_FILE, mode, NULL, SMB2_OP_MKDIR,
-				NULL);
+				NULL, NULL, NULL);
 }
 
 void
@@ -641,7 +645,7 @@ smb2_mkdir_setinfo(struct inode *inode, const char *name,
 	tmprc = smb2_compound_op(xid, tcon, cifs_sb, name,
 				 FILE_WRITE_ATTRIBUTES, FILE_CREATE,
 				 CREATE_NOT_FILE, ACL_NO_MODE,
-				 &data, SMB2_OP_SET_INFO, cfile);
+				 &data, SMB2_OP_SET_INFO, cfile, NULL, NULL);
 	if (tmprc == 0)
 		cifs_i->cifsAttrs = dosattrs;
 }
@@ -652,7 +656,7 @@ smb2_rmdir(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 {
 	return smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FILE_OPEN,
 				CREATE_NOT_FILE, ACL_NO_MODE,
-				NULL, SMB2_OP_RMDIR, NULL);
+				NULL, SMB2_OP_RMDIR, NULL, NULL, NULL);
 }
 
 int
@@ -661,7 +665,7 @@ smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 {
 	return smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FILE_OPEN,
 				CREATE_DELETE_ON_CLOSE | OPEN_REPARSE_POINT,
-				ACL_NO_MODE, NULL, SMB2_OP_DELETE, NULL);
+				ACL_NO_MODE, NULL, SMB2_OP_DELETE, NULL, NULL, NULL);
 }
 
 static int
@@ -680,7 +684,7 @@ smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
 	}
 	rc = smb2_compound_op(xid, tcon, cifs_sb, from_name, access,
 			      FILE_OPEN, 0, ACL_NO_MODE, smb2_to_name,
-			      command, cfile);
+			      command, cfile, NULL, NULL);
 smb2_rename_path:
 	kfree(smb2_to_name);
 	return rc;
@@ -720,7 +724,7 @@ smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
 	cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
 	return smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				FILE_WRITE_DATA, FILE_OPEN, 0, ACL_NO_MODE,
-				&eof, SMB2_OP_SET_EOF, cfile);
+				&eof, SMB2_OP_SET_EOF, cfile, NULL, NULL);
 }
 
 int
@@ -746,7 +750,8 @@ smb2_set_file_info(struct inode *inode, const char *full_path,
 	cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
 	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 			      FILE_WRITE_ATTRIBUTES, FILE_OPEN,
-			      0, ACL_NO_MODE, buf, SMB2_OP_SET_INFO, cfile);
+			      0, ACL_NO_MODE, buf, SMB2_OP_SET_INFO, cfile,
+			      NULL, NULL);
 	cifs_put_tlink(tlink);
 	return rc;
 }
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index c82b0871341c..363cd6f6ca75 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -817,33 +817,25 @@ smb2_is_path_accessible(const unsigned int xid, struct cifs_tcon *tcon,
 	return rc;
 }
 
-static int
-smb2_get_srv_inum(const unsigned int xid, struct cifs_tcon *tcon,
-		  struct cifs_sb_info *cifs_sb, const char *full_path,
-		  u64 *uniqueid, FILE_ALL_INFO *data)
+static int smb2_get_srv_inum(const unsigned int xid, struct cifs_tcon *tcon,
+			     struct cifs_sb_info *cifs_sb, const char *full_path,
+			     u64 *uniqueid, struct cifs_open_info_data *data)
 {
-	*uniqueid = le64_to_cpu(data->IndexNumber);
+	*uniqueid = le64_to_cpu(data->fi.IndexNumber);
 	return 0;
 }
 
-static int
-smb2_query_file_info(const unsigned int xid, struct cifs_tcon *tcon,
-		     struct cifs_fid *fid, FILE_ALL_INFO *data)
+static int smb2_query_file_info(const unsigned int xid, struct cifs_tcon *tcon,
+				struct cifsFileInfo *cfile, struct cifs_open_info_data *data)
 {
-	int rc;
-	struct smb2_file_all_info *smb2_data;
+	struct cifs_fid *fid = &cfile->fid;
 
-	smb2_data = kzalloc(sizeof(struct smb2_file_all_info) + PATH_MAX * 2,
-			    GFP_KERNEL);
-	if (smb2_data == NULL)
-		return -ENOMEM;
-
-	rc = SMB2_query_info(xid, tcon, fid->persistent_fid, fid->volatile_fid,
-			     smb2_data);
-	if (!rc)
-		move_smb2_info_to_cifs(data, smb2_data);
-	kfree(smb2_data);
-	return rc;
+	if (cfile->symlink_target) {
+		data->symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
+		if (!data->symlink_target)
+			return -ENOMEM;
+	}
+	return SMB2_query_info(xid, tcon, fid->persistent_fid, fid->volatile_fid, &data->fi);
 }
 
 #ifdef CONFIG_CIFS_XATTR
@@ -2814,9 +2806,6 @@ parse_reparse_point(struct reparse_data_buffer *buf,
 	}
 }
 
-#define SMB2_SYMLINK_STRUCT_SIZE \
-	(sizeof(struct smb2_err_rsp) - 1 + sizeof(struct smb2_symlink_err_rsp))
-
 static int
 smb2_query_symlink(const unsigned int xid, struct cifs_tcon *tcon,
 		   struct cifs_sb_info *cifs_sb, const char *full_path,
@@ -2828,13 +2817,7 @@ smb2_query_symlink(const unsigned int xid, struct cifs_tcon *tcon,
 	struct cifs_open_parms oparms;
 	struct cifs_fid fid;
 	struct kvec err_iov = {NULL, 0};
-	struct smb2_err_rsp *err_buf = NULL;
-	struct smb2_symlink_err_rsp *symlink;
 	struct TCP_Server_Info *server = cifs_pick_channel(tcon->ses);
-	unsigned int sub_len;
-	unsigned int sub_offset;
-	unsigned int print_len;
-	unsigned int print_offset;
 	int flags = CIFS_CP_CREATE_CLOSE_OP;
 	struct smb_rqst rqst[3];
 	int resp_buftype[3];
@@ -2951,47 +2934,7 @@ smb2_query_symlink(const unsigned int xid, struct cifs_tcon *tcon,
 		goto querty_exit;
 	}
 
-	err_buf = err_iov.iov_base;
-	if (le32_to_cpu(err_buf->ByteCount) < sizeof(struct smb2_symlink_err_rsp) ||
-	    err_iov.iov_len < SMB2_SYMLINK_STRUCT_SIZE) {
-		rc = -EINVAL;
-		goto querty_exit;
-	}
-
-	symlink = (struct smb2_symlink_err_rsp *)err_buf->ErrorData;
-	if (le32_to_cpu(symlink->SymLinkErrorTag) != SYMLINK_ERROR_TAG ||
-	    le32_to_cpu(symlink->ReparseTag) != IO_REPARSE_TAG_SYMLINK) {
-		rc = -EINVAL;
-		goto querty_exit;
-	}
-
-	/* open must fail on symlink - reset rc */
-	rc = 0;
-	sub_len = le16_to_cpu(symlink->SubstituteNameLength);
-	sub_offset = le16_to_cpu(symlink->SubstituteNameOffset);
-	print_len = le16_to_cpu(symlink->PrintNameLength);
-	print_offset = le16_to_cpu(symlink->PrintNameOffset);
-
-	if (err_iov.iov_len < SMB2_SYMLINK_STRUCT_SIZE + sub_offset + sub_len) {
-		rc = -EINVAL;
-		goto querty_exit;
-	}
-
-	if (err_iov.iov_len <
-	    SMB2_SYMLINK_STRUCT_SIZE + print_offset + print_len) {
-		rc = -EINVAL;
-		goto querty_exit;
-	}
-
-	*target_path = cifs_strndup_from_utf16(
-				(char *)symlink->PathBuffer + sub_offset,
-				sub_len, true, cifs_sb->local_nls);
-	if (!(*target_path)) {
-		rc = -ENOMEM;
-		goto querty_exit;
-	}
-	convert_delimiter(*target_path, '/');
-	cifs_dbg(FYI, "%s: target path: %s\n", __func__, *target_path);
+	rc = smb2_parse_symlink_response(cifs_sb, &err_iov, target_path);
 
  querty_exit:
 	cifs_dbg(FYI, "query symlink rc %d\n", rc);
@@ -5101,7 +5044,7 @@ smb2_make_node(unsigned int xid, struct inode *inode,
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	int rc = -EPERM;
-	FILE_ALL_INFO *buf = NULL;
+	struct cifs_open_info_data buf = {};
 	struct cifs_io_parms io_parms = {0};
 	__u32 oplock = 0;
 	struct cifs_fid fid;
@@ -5117,7 +5060,7 @@ smb2_make_node(unsigned int xid, struct inode *inode,
 	 * and was used by default in earlier versions of Windows
 	 */
 	if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_UNX_EMUL))
-		goto out;
+		return rc;
 
 	/*
 	 * TODO: Add ability to create instead via reparse point. Windows (e.g.
@@ -5126,16 +5069,10 @@ smb2_make_node(unsigned int xid, struct inode *inode,
 	 */
 
 	if (!S_ISCHR(mode) && !S_ISBLK(mode))
-		goto out;
+		return rc;
 
 	cifs_dbg(FYI, "sfu compat create special file\n");
 
-	buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
-	if (buf == NULL) {
-		rc = -ENOMEM;
-		goto out;
-	}
-
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
 	oparms.desired_access = GENERIC_WRITE;
@@ -5150,21 +5087,21 @@ smb2_make_node(unsigned int xid, struct inode *inode,
 		oplock = REQ_OPLOCK;
 	else
 		oplock = 0;
-	rc = tcon->ses->server->ops->open(xid, &oparms, &oplock, buf);
+	rc = tcon->ses->server->ops->open(xid, &oparms, &oplock, &buf);
 	if (rc)
-		goto out;
+		return rc;
 
 	/*
 	 * BB Do not bother to decode buf since no local inode yet to put
 	 * timestamps in, but we can reuse it safely.
 	 */
 
-	pdev = (struct win_dev *)buf;
+	pdev = (struct win_dev *)&buf.fi;
 	io_parms.pid = current->tgid;
 	io_parms.tcon = tcon;
 	io_parms.offset = 0;
 	io_parms.length = sizeof(struct win_dev);
-	iov[1].iov_base = buf;
+	iov[1].iov_base = &buf.fi;
 	iov[1].iov_len = sizeof(struct win_dev);
 	if (S_ISCHR(mode)) {
 		memcpy(pdev->type, "IntxCHR", 8);
@@ -5183,8 +5120,8 @@ smb2_make_node(unsigned int xid, struct inode *inode,
 	d_drop(dentry);
 
 	/* FIXME: add code here to set EAs */
-out:
-	kfree(buf);
+
+	cifs_free_open_info(&buf);
 	return rc;
 }
 
diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index f57881b8464f..1237bb86e93a 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -56,6 +56,9 @@ struct smb2_rdma_crypto_transform {
 
 #define COMPOUND_FID 0xFFFFFFFFFFFFFFFFULL
 
+#define SMB2_SYMLINK_STRUCT_SIZE \
+	(sizeof(struct smb2_err_rsp) - 1 + sizeof(struct smb2_symlink_err_rsp))
+
 #define SYMLINK_ERROR_TAG 0x4c4d5953
 
 struct smb2_symlink_err_rsp {
diff --git a/fs/cifs/smb2proto.h b/fs/cifs/smb2proto.h
index 3f740f24b96a..7818d0b83567 100644
--- a/fs/cifs/smb2proto.h
+++ b/fs/cifs/smb2proto.h
@@ -53,16 +53,12 @@ extern bool smb2_is_valid_oplock_break(char *buffer,
 				       struct TCP_Server_Info *srv);
 extern int smb3_handle_read_data(struct TCP_Server_Info *server,
 				 struct mid_q_entry *mid);
-
-extern void move_smb2_info_to_cifs(FILE_ALL_INFO *dst,
-				   struct smb2_file_all_info *src);
 extern int smb2_query_reparse_tag(const unsigned int xid, struct cifs_tcon *tcon,
 				struct cifs_sb_info *cifs_sb, const char *path,
 				__u32 *reparse_tag);
-extern int smb2_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
-				struct cifs_sb_info *cifs_sb,
-				const char *full_path, FILE_ALL_INFO *data,
-				bool *adjust_tz, bool *symlink);
+int smb2_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
+			 struct cifs_sb_info *cifs_sb, const char *full_path,
+			 struct cifs_open_info_data *data, bool *adjust_tz, bool *reparse);
 extern int smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
 			      const char *full_path, __u64 size,
 			      struct cifs_sb_info *cifs_sb, bool set_alloc);
@@ -95,9 +91,9 @@ extern int smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 			  struct cifs_sb_info *cifs_sb,
 			  const unsigned char *path, char *pbuf,
 			  unsigned int *pbytes_read);
-extern int smb2_open_file(const unsigned int xid,
-			  struct cifs_open_parms *oparms,
-			  __u32 *oplock, FILE_ALL_INFO *buf);
+int smb2_parse_symlink_response(struct cifs_sb_info *cifs_sb, const struct kvec *iov, char **path);
+int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms, __u32 *oplock,
+		   void *buf);
 extern int smb2_unlock_range(struct cifsFileInfo *cfile,
 			     struct file_lock *flock, const unsigned int xid);
 extern int smb2_push_mandatory_locks(struct cifsFileInfo *cfile);
@@ -278,9 +274,9 @@ extern int smb2_query_info_compound(const unsigned int xid,
 				    struct kvec *rsp, int *buftype,
 				    struct cifs_sb_info *cifs_sb);
 /* query path info from the server using SMB311 POSIX extensions*/
-extern int smb311_posix_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
-			struct cifs_sb_info *sb, const char *path, struct smb311_posix_qinfo *qinf,
-			bool *adjust_tx, bool *symlink);
+int smb311_posix_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
+				 struct cifs_sb_info *cifs_sb, const char *full_path,
+				 struct cifs_open_info_data *data, bool *adjust_tz, bool *reparse);
 int posix_info_parse(const void *beg, const void *end,
 		     struct smb2_posix_info_parsed *out);
 int posix_info_sid_size(const void *beg, const void *end);
-- 
2.37.3

