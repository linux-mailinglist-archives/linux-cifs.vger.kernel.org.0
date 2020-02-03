Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 89888151073
	for <lists+linux-cifs@lfdr.de>; Mon,  3 Feb 2020 20:46:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726187AbgBCTq6 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 3 Feb 2020 14:46:58 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:33269 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725372AbgBCTq6 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 3 Feb 2020 14:46:58 -0500
Received: by mail-wm1-f68.google.com with SMTP id m10so607907wmc.0
        for <linux-cifs@vger.kernel.org>; Mon, 03 Feb 2020 11:46:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=KUU21cXloxNxOMt4PD5uDRdDWyyybg/kvfonXwgvoJQ=;
        b=q27EP5pLBRPSknNaYNruyrDBtqZnjCEzPI0aSSP2Wnt5mFh8IHdQlNhdMGvAQKhu7h
         QKxw0StPSqeDCB6GvJ6xwsYZ31lumKbit+oAMlZJvA3oQJw9hyDJdGT2t6FAhPGcFOKe
         oe7lHSj3h8un4CVYP6o5A6B1ZJ8gZviG/iEYGLkgH2q9OQbc2jPg/uDzXuck8n1l9WSX
         0vA+iRIZncJdZijfClTEXrYMVTeT9YQFw4ZqUv01jLWLabep/vZ5OnNJl3wPY+4GCz/Z
         2qx2+G4zTUq91Lgxc5srKarMcRIqV6RwfQeNxGNF3QVIDtZw1zfDZgJwgOrxKwa10edv
         Kc8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=KUU21cXloxNxOMt4PD5uDRdDWyyybg/kvfonXwgvoJQ=;
        b=IquY0nI0jTgIA7q+lEBz1GkkUSKB6ruQMtLkg2yofBUGaQNRWSGVJkPrb2GotbCWv2
         /wnW/pixU7rjMzPjgUg+aUzcZaMIaMvHj8MAHiWDsTODwxCX6pl/uKeM9o1jL9kb1o9V
         l1BmGV17cU1+tcyE/B5omG4bDR8bCLNJOymz+n3jet+p4FGYt7lbb4Tq92hA2dRz9m/0
         8mQnGUYHf98vFgi7W1BE9mUUb3Fv/iM2zOQjwQAq5IwYurq4eh/f6rQ2OL4FZSy4dmWF
         1J2RZr7smFfTDBKXo8CcoxVGTZoVjQtdnmFwZA2/577CYo4FybLhpca6D+UCm7KeLKAs
         mMhQ==
X-Gm-Message-State: APjAAAWLE52lALmSksiVVsaeSSJ9hkBKGuhRhgQH3jAXgH44KYcdQvR5
        bHphMit6OHPiV9KiuLl1egU=
X-Google-Smtp-Source: APXvYqwDqqsdA4+RkhcRAmm4a9FEVtKC7FHJLtPQvkJzyRld7zi3yw5im/fp/jAgCwuaG/UsKPawnA==
X-Received: by 2002:a05:600c:2c06:: with SMTP id q6mr685377wmg.154.1580759211975;
        Mon, 03 Feb 2020 11:46:51 -0800 (PST)
Received: from localhost.localdomain ([141.226.11.142])
        by smtp.gmail.com with ESMTPSA id h13sm15213815wrw.54.2020.02.03.11.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 11:46:50 -0800 (PST)
From:   Amir Goldstein <amir73il@gmail.com>
To:     Steve French <sfrench@samba.org>
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>, whh@rubrik.com,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: [PATCH] SMB3: Backup intent flag missing from some more ops
Date:   Mon,  3 Feb 2020 21:46:43 +0200
Message-Id: <20200203194643.21698-1-amir73il@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

When "backup intent" is requested on the mount (e.g. backupuid or
backupgid mount options), the corresponding flag was missing from
some of the operations.

Change all operations to use the macro cifs_create_options() to
set the backup intent flag if needed.

Signed-off-by: Amir Goldstein <amir73il@gmail.com>
---

Hi Steve,

We have a backup test case which failed on some operations, so I tried
to fix all operations. Hope I found them all.
This change fixed the backup test case failure, but I did not run any
other cifs sanity tests.

I also have a v4.19.y backport patch. Will post it if and when this
patch is merged.

Thanks,
Amir.

 fs/cifs/cifsacl.c   | 14 +++-----
 fs/cifs/cifsfs.c    |  2 +-
 fs/cifs/cifsglob.h  |  6 ++--
 fs/cifs/cifsproto.h |  8 +++++
 fs/cifs/connect.c   |  2 +-
 fs/cifs/dir.c       |  5 +--
 fs/cifs/file.c      | 10 ++----
 fs/cifs/inode.c     |  8 ++---
 fs/cifs/ioctl.c     |  2 +-
 fs/cifs/link.c      | 18 +++-------
 fs/cifs/smb1ops.c   | 19 +++++------
 fs/cifs/smb2inode.c |  9 ++---
 fs/cifs/smb2ops.c   | 81 +++++++++++++++------------------------------
 fs/cifs/smb2proto.h |  2 +-
 14 files changed, 68 insertions(+), 118 deletions(-)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index fb41e51dd574..440828afcdde 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -1084,7 +1084,7 @@ static struct cifs_ntsd *get_cifs_acl_by_path(struct cifs_sb_info *cifs_sb,
 	struct cifs_ntsd *pntsd = NULL;
 	int oplock = 0;
 	unsigned int xid;
-	int rc, create_options = 0;
+	int rc;
 	struct cifs_tcon *tcon;
 	struct tcon_link *tlink = cifs_sb_tlink(cifs_sb);
 	struct cifs_fid fid;
@@ -1096,13 +1096,10 @@ static struct cifs_ntsd *get_cifs_acl_by_path(struct cifs_sb_info *cifs_sb,
 	tcon = tlink_tcon(tlink);
 	xid = get_xid();
 
-	if (backup_cred(cifs_sb))
-		create_options |= CREATE_OPEN_BACKUP_INTENT;
-
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
 	oparms.desired_access = READ_CONTROL;
-	oparms.create_options = create_options;
+	oparms.create_options = cifs_create_options(cifs_sb, 0);
 	oparms.disposition = FILE_OPEN;
 	oparms.path = path;
 	oparms.fid = &fid;
@@ -1147,7 +1144,7 @@ int set_cifs_acl(struct cifs_ntsd *pnntsd, __u32 acllen,
 {
 	int oplock = 0;
 	unsigned int xid;
-	int rc, access_flags, create_options = 0;
+	int rc, access_flags;
 	struct cifs_tcon *tcon;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct tcon_link *tlink = cifs_sb_tlink(cifs_sb);
@@ -1160,9 +1157,6 @@ int set_cifs_acl(struct cifs_ntsd *pnntsd, __u32 acllen,
 	tcon = tlink_tcon(tlink);
 	xid = get_xid();
 
-	if (backup_cred(cifs_sb))
-		create_options |= CREATE_OPEN_BACKUP_INTENT;
-
 	if (aclflag == CIFS_ACL_OWNER || aclflag == CIFS_ACL_GROUP)
 		access_flags = WRITE_OWNER;
 	else
@@ -1171,7 +1165,7 @@ int set_cifs_acl(struct cifs_ntsd *pnntsd, __u32 acllen,
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
 	oparms.desired_access = access_flags;
-	oparms.create_options = create_options;
+	oparms.create_options = cifs_create_options(cifs_sb, 0);
 	oparms.disposition = FILE_OPEN;
 	oparms.path = path;
 	oparms.fid = &fid;
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 5492b9860baa..febab27cd838 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -275,7 +275,7 @@ cifs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_ffree = 0;	/* unlimited */
 
 	if (server->ops->queryfs)
-		rc = server->ops->queryfs(xid, tcon, buf);
+		rc = server->ops->queryfs(xid, tcon, cifs_sb, buf);
 
 	free_xid(xid);
 	return 0;
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 239338d57086..1205041fd966 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -298,7 +298,8 @@ struct smb_version_operations {
 			     const char *, struct dfs_info3_param **,
 			     unsigned int *, const struct nls_table *, int);
 	/* informational QFS call */
-	void (*qfs_tcon)(const unsigned int, struct cifs_tcon *);
+	void (*qfs_tcon)(const unsigned int, struct cifs_tcon *,
+			 struct cifs_sb_info *);
 	/* check if a path is accessible or not */
 	int (*is_path_accessible)(const unsigned int, struct cifs_tcon *,
 				  struct cifs_sb_info *, const char *);
@@ -409,7 +410,7 @@ struct smb_version_operations {
 			       struct cifsInodeInfo *);
 	/* query remote filesystem */
 	int (*queryfs)(const unsigned int, struct cifs_tcon *,
-		       struct kstatfs *);
+		       struct cifs_sb_info *, struct kstatfs *);
 	/* send mandatory brlock to the server */
 	int (*mand_lock)(const unsigned int, struct cifsFileInfo *, __u64,
 			 __u64, __u32, int, int, bool);
@@ -490,6 +491,7 @@ struct smb_version_operations {
 	/* ioctl passthrough for query_info */
 	int (*ioctl_query_info)(const unsigned int xid,
 				struct cifs_tcon *tcon,
+				struct cifs_sb_info *cifs_sb,
 				__le16 *path, int is_dir,
 				unsigned long p);
 	/* make unix special files (block, char, fifo, socket) */
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 948bf3474db1..748bd00cb5f1 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -612,4 +612,12 @@ static inline int get_dfs_path(const unsigned int xid, struct cifs_ses *ses,
 }
 #endif
 
+static inline int cifs_create_options(struct cifs_sb_info *cifs_sb, int options)
+{
+	if (backup_cred(cifs_sb))
+		return options | CREATE_OPEN_BACKUP_INTENT;
+	else
+		return options;
+}
+
 #endif			/* _CIFSPROTO_H */
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 0aa3623ae0e1..a941ac7a659d 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -4365,7 +4365,7 @@ static int mount_get_conns(struct smb_vol *vol, struct cifs_sb_info *cifs_sb,
 
 	/* do not care if a following call succeed - informational */
 	if (!tcon->pipe && server->ops->qfs_tcon) {
-		server->ops->qfs_tcon(*xid, tcon);
+		server->ops->qfs_tcon(*xid, tcon, cifs_sb);
 		if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RO_CACHE) {
 			if (tcon->fsDevInfo.DeviceCharacteristics &
 			    cpu_to_le32(FILE_READ_ONLY_DEVICE))
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index f3b79012ff29..0ef099442f20 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -355,13 +355,10 @@ cifs_do_create(struct inode *inode, struct dentry *direntry, unsigned int xid,
 	if (!tcon->unix_ext && (mode & S_IWUGO) == 0)
 		create_options |= CREATE_OPTION_READONLY;
 
-	if (backup_cred(cifs_sb))
-		create_options |= CREATE_OPEN_BACKUP_INTENT;
-
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
 	oparms.desired_access = desired_access;
-	oparms.create_options = create_options;
+	oparms.create_options = cifs_create_options(cifs_sb, create_options);
 	oparms.disposition = disposition;
 	oparms.path = full_path;
 	oparms.fid = fid;
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index a4e8f7d445ac..79e6f4f55b9b 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -222,9 +222,6 @@ cifs_nt_open(char *full_path, struct inode *inode, struct cifs_sb_info *cifs_sb,
 	if (!buf)
 		return -ENOMEM;
 
-	if (backup_cred(cifs_sb))
-		create_options |= CREATE_OPEN_BACKUP_INTENT;
-
 	/* O_SYNC also has bit for O_DSYNC so following check picks up either */
 	if (f_flags & O_SYNC)
 		create_options |= CREATE_WRITE_THROUGH;
@@ -235,7 +232,7 @@ cifs_nt_open(char *full_path, struct inode *inode, struct cifs_sb_info *cifs_sb,
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
 	oparms.desired_access = desired_access;
-	oparms.create_options = create_options;
+	oparms.create_options = cifs_create_options(cifs_sb, create_options);
 	oparms.disposition = disposition;
 	oparms.path = full_path;
 	oparms.fid = fid;
@@ -752,9 +749,6 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 
 	desired_access = cifs_convert_flags(cfile->f_flags);
 
-	if (backup_cred(cifs_sb))
-		create_options |= CREATE_OPEN_BACKUP_INTENT;
-
 	/* O_SYNC also has bit for O_DSYNC so following check picks up either */
 	if (cfile->f_flags & O_SYNC)
 		create_options |= CREATE_WRITE_THROUGH;
@@ -768,7 +762,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can_flush)
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
 	oparms.desired_access = desired_access;
-	oparms.create_options = create_options;
+	oparms.create_options = cifs_create_options(cifs_sb, create_options);
 	oparms.disposition = disposition;
 	oparms.path = full_path;
 	oparms.fid = &cfile->fid;
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 9b547f7f5f5d..b1383c524b98 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -472,9 +472,7 @@ cifs_sfu_type(struct cifs_fattr *fattr, const char *path,
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
 	oparms.desired_access = GENERIC_READ;
-	oparms.create_options = CREATE_NOT_DIR;
-	if (backup_cred(cifs_sb))
-		oparms.create_options |= CREATE_OPEN_BACKUP_INTENT;
+	oparms.create_options = cifs_create_options(cifs_sb, CREATE_NOT_DIR);
 	oparms.disposition = FILE_OPEN;
 	oparms.path = path;
 	oparms.fid = &fid;
@@ -1284,7 +1282,7 @@ cifs_rename_pending_delete(const char *full_path, struct dentry *dentry,
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
 	oparms.desired_access = DELETE | FILE_WRITE_ATTRIBUTES;
-	oparms.create_options = CREATE_NOT_DIR;
+	oparms.create_options = cifs_create_options(cifs_sb, CREATE_NOT_DIR);
 	oparms.disposition = FILE_OPEN;
 	oparms.path = full_path;
 	oparms.fid = &fid;
@@ -1822,7 +1820,7 @@ cifs_do_rename(const unsigned int xid, struct dentry *from_dentry,
 	oparms.cifs_sb = cifs_sb;
 	/* open the file to be renamed -- we need DELETE perms */
 	oparms.desired_access = DELETE;
-	oparms.create_options = CREATE_NOT_DIR;
+	oparms.create_options = cifs_create_options(cifs_sb, CREATE_NOT_DIR);
 	oparms.disposition = FILE_OPEN;
 	oparms.path = from_path;
 	oparms.fid = &fid;
diff --git a/fs/cifs/ioctl.c b/fs/cifs/ioctl.c
index 1a01e108d75e..e4c935026d5e 100644
--- a/fs/cifs/ioctl.c
+++ b/fs/cifs/ioctl.c
@@ -65,7 +65,7 @@ static long cifs_ioctl_query_info(unsigned int xid, struct file *filep,
 
 	if (tcon->ses->server->ops->ioctl_query_info)
 		rc = tcon->ses->server->ops->ioctl_query_info(
-				xid, tcon, utf16_path,
+				xid, tcon, cifs_sb, utf16_path,
 				filep->private_data ? 0 : 1, p);
 	else
 		rc = -EOPNOTSUPP;
diff --git a/fs/cifs/link.c b/fs/cifs/link.c
index b736acd3917b..852aa00ec729 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -315,7 +315,7 @@ cifs_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
 	oparms.desired_access = GENERIC_READ;
-	oparms.create_options = CREATE_NOT_DIR;
+	oparms.create_options = cifs_create_options(cifs_sb, CREATE_NOT_DIR);
 	oparms.disposition = FILE_OPEN;
 	oparms.path = path;
 	oparms.fid = &fid;
@@ -353,15 +353,11 @@ cifs_create_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	struct cifs_fid fid;
 	struct cifs_open_parms oparms;
 	struct cifs_io_parms io_parms;
-	int create_options = CREATE_NOT_DIR;
-
-	if (backup_cred(cifs_sb))
-		create_options |= CREATE_OPEN_BACKUP_INTENT;
 
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
 	oparms.desired_access = GENERIC_WRITE;
-	oparms.create_options = create_options;
+	oparms.create_options = cifs_create_options(cifs_sb, CREATE_NOT_DIR);
 	oparms.disposition = FILE_CREATE;
 	oparms.path = path;
 	oparms.fid = &fid;
@@ -402,9 +398,7 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
 	oparms.desired_access = GENERIC_READ;
-	oparms.create_options = CREATE_NOT_DIR;
-	if (backup_cred(cifs_sb))
-		oparms.create_options |= CREATE_OPEN_BACKUP_INTENT;
+	oparms.create_options = cifs_create_options(cifs_sb, CREATE_NOT_DIR);
 	oparms.disposition = FILE_OPEN;
 	oparms.fid = &fid;
 	oparms.reconnect = false;
@@ -457,14 +451,10 @@ smb3_create_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	struct cifs_fid fid;
 	struct cifs_open_parms oparms;
 	struct cifs_io_parms io_parms;
-	int create_options = CREATE_NOT_DIR;
 	__le16 *utf16_path;
 	__u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
 	struct kvec iov[2];
 
-	if (backup_cred(cifs_sb))
-		create_options |= CREATE_OPEN_BACKUP_INTENT;
-
 	cifs_dbg(FYI, "%s: path: %s\n", __func__, path);
 
 	utf16_path = cifs_convert_path_to_utf16(path, cifs_sb);
@@ -474,7 +464,7 @@ smb3_create_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
 	oparms.desired_access = GENERIC_WRITE;
-	oparms.create_options = create_options;
+	oparms.create_options = cifs_create_options(cifs_sb, CREATE_NOT_DIR);
 	oparms.disposition = FILE_CREATE;
 	oparms.fid = &fid;
 	oparms.reconnect = false;
diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
index d70a2bb062df..eb994e313c6a 100644
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -504,7 +504,8 @@ cifs_negotiate_rsize(struct cifs_tcon *tcon, struct smb_vol *volume_info)
 }
 
 static void
-cifs_qfs_tcon(const unsigned int xid, struct cifs_tcon *tcon)
+cifs_qfs_tcon(const unsigned int xid, struct cifs_tcon *tcon,
+	      struct cifs_sb_info *cifs_sb)
 {
 	CIFSSMBQFSDeviceInfo(xid, tcon);
 	CIFSSMBQFSAttributeInfo(xid, tcon);
@@ -565,7 +566,7 @@ cifs_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
 		oparms.tcon = tcon;
 		oparms.cifs_sb = cifs_sb;
 		oparms.desired_access = FILE_READ_ATTRIBUTES;
-		oparms.create_options = 0;
+		oparms.create_options = cifs_create_options(cifs_sb, 0);
 		oparms.disposition = FILE_OPEN;
 		oparms.path = full_path;
 		oparms.fid = &fid;
@@ -793,7 +794,7 @@ smb_set_file_info(struct inode *inode, const char *full_path,
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
 	oparms.desired_access = SYNCHRONIZE | FILE_WRITE_ATTRIBUTES;
-	oparms.create_options = CREATE_NOT_DIR;
+	oparms.create_options = cifs_create_options(cifs_sb, CREATE_NOT_DIR);
 	oparms.disposition = FILE_OPEN;
 	oparms.path = full_path;
 	oparms.fid = &fid;
@@ -872,7 +873,7 @@ cifs_oplock_response(struct cifs_tcon *tcon, struct cifs_fid *fid,
 
 static int
 cifs_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
-	     struct kstatfs *buf)
+	     struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
 {
 	int rc = -EOPNOTSUPP;
 
@@ -970,7 +971,8 @@ cifs_query_symlink(const unsigned int xid, struct cifs_tcon *tcon,
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
 	oparms.desired_access = FILE_READ_ATTRIBUTES;
-	oparms.create_options = OPEN_REPARSE_POINT;
+	oparms.create_options = cifs_create_options(cifs_sb,
+						    OPEN_REPARSE_POINT);
 	oparms.disposition = FILE_OPEN;
 	oparms.path = full_path;
 	oparms.fid = &fid;
@@ -1029,7 +1031,6 @@ cifs_make_node(unsigned int xid, struct inode *inode,
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	struct inode *newinode = NULL;
 	int rc = -EPERM;
-	int create_options = CREATE_NOT_DIR | CREATE_OPTION_SPECIAL;
 	FILE_ALL_INFO *buf = NULL;
 	struct cifs_io_parms io_parms;
 	__u32 oplock = 0;
@@ -1090,13 +1091,11 @@ cifs_make_node(unsigned int xid, struct inode *inode,
 		goto out;
 	}
 
-	if (backup_cred(cifs_sb))
-		create_options |= CREATE_OPEN_BACKUP_INTENT;
-
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
 	oparms.desired_access = GENERIC_WRITE;
-	oparms.create_options = create_options;
+	oparms.create_options = cifs_create_options(cifs_sb, CREATE_NOT_DIR |
+						    CREATE_OPTION_SPECIAL);
 	oparms.disposition = FILE_CREATE;
 	oparms.path = full_path;
 	oparms.fid = &fid;
diff --git a/fs/cifs/smb2inode.c b/fs/cifs/smb2inode.c
index 5ef5e97a6d13..1cf207564ff9 100644
--- a/fs/cifs/smb2inode.c
+++ b/fs/cifs/smb2inode.c
@@ -99,9 +99,7 @@ smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 	oparms.tcon = tcon;
 	oparms.desired_access = desired_access;
 	oparms.disposition = create_disposition;
-	oparms.create_options = create_options;
-	if (backup_cred(cifs_sb))
-		oparms.create_options |= CREATE_OPEN_BACKUP_INTENT;
+	oparms.create_options = cifs_create_options(cifs_sb, create_options);
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 	oparms.mode = mode;
@@ -457,7 +455,7 @@ smb2_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
 
 	/* If it is a root and its handle is cached then use it */
 	if (!strlen(full_path) && !no_cached_open) {
-		rc = open_shroot(xid, tcon, &fid);
+		rc = open_shroot(xid, tcon, cifs_sb, &fid);
 		if (rc)
 			goto out;
 
@@ -474,9 +472,6 @@ smb2_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
 		goto out;
 	}
 
-	if (backup_cred(cifs_sb))
-		create_options |= CREATE_OPEN_BACKUP_INTENT;
-
 	cifs_get_readable_path(tcon, full_path, &cfile);
 	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 			      FILE_READ_ATTRIBUTES, FILE_OPEN, create_options,
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 6787fce26f20..33bb86cae369 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -655,7 +655,8 @@ smb2_cached_lease_break(struct work_struct *work)
 /*
  * Open the directory at the root of a share
  */
-int open_shroot(unsigned int xid, struct cifs_tcon *tcon, struct cifs_fid *pfid)
+int open_shroot(unsigned int xid, struct cifs_tcon *tcon,
+		struct cifs_sb_info *cifs_sb, struct cifs_fid *pfid)
 {
 	struct cifs_ses *ses = tcon->ses;
 	struct TCP_Server_Info *server = ses->server;
@@ -702,7 +703,7 @@ int open_shroot(unsigned int xid, struct cifs_tcon *tcon, struct cifs_fid *pfid)
 	rqst[0].rq_nvec = SMB2_CREATE_IOV_SIZE;
 
 	oparms.tcon = tcon;
-	oparms.create_options = 0;
+	oparms.create_options = cifs_create_options(cifs_sb, 0);
 	oparms.desired_access = FILE_READ_ATTRIBUTES;
 	oparms.disposition = FILE_OPEN;
 	oparms.fid = pfid;
@@ -818,7 +819,8 @@ int open_shroot(unsigned int xid, struct cifs_tcon *tcon, struct cifs_fid *pfid)
 }
 
 static void
-smb3_qfs_tcon(const unsigned int xid, struct cifs_tcon *tcon)
+smb3_qfs_tcon(const unsigned int xid, struct cifs_tcon *tcon,
+	      struct cifs_sb_info *cifs_sb)
 {
 	int rc;
 	__le16 srch_path = 0; /* Null - open root of share */
@@ -830,7 +832,7 @@ smb3_qfs_tcon(const unsigned int xid, struct cifs_tcon *tcon)
 	oparms.tcon = tcon;
 	oparms.desired_access = FILE_READ_ATTRIBUTES;
 	oparms.disposition = FILE_OPEN;
-	oparms.create_options = 0;
+	oparms.create_options = cifs_create_options(cifs_sb, 0);
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
@@ -838,7 +840,7 @@ smb3_qfs_tcon(const unsigned int xid, struct cifs_tcon *tcon)
 		rc = SMB2_open(xid, &oparms, &srch_path, &oplock, NULL, NULL,
 			       NULL);
 	else
-		rc = open_shroot(xid, tcon, &fid);
+		rc = open_shroot(xid, tcon, cifs_sb, &fid);
 
 	if (rc)
 		return;
@@ -860,7 +862,8 @@ smb3_qfs_tcon(const unsigned int xid, struct cifs_tcon *tcon)
 }
 
 static void
-smb2_qfs_tcon(const unsigned int xid, struct cifs_tcon *tcon)
+smb2_qfs_tcon(const unsigned int xid, struct cifs_tcon *tcon,
+	      struct cifs_sb_info *cifs_sb)
 {
 	int rc;
 	__le16 srch_path = 0; /* Null - open root of share */
@@ -871,7 +874,7 @@ smb2_qfs_tcon(const unsigned int xid, struct cifs_tcon *tcon)
 	oparms.tcon = tcon;
 	oparms.desired_access = FILE_READ_ATTRIBUTES;
 	oparms.disposition = FILE_OPEN;
-	oparms.create_options = 0;
+	oparms.create_options = cifs_create_options(cifs_sb, 0);
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
@@ -906,10 +909,7 @@ smb2_is_path_accessible(const unsigned int xid, struct cifs_tcon *tcon,
 	oparms.tcon = tcon;
 	oparms.desired_access = FILE_READ_ATTRIBUTES;
 	oparms.disposition = FILE_OPEN;
-	if (backup_cred(cifs_sb))
-		oparms.create_options = CREATE_OPEN_BACKUP_INTENT;
-	else
-		oparms.create_options = 0;
+	oparms.create_options = cifs_create_options(cifs_sb, 0);
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
@@ -1151,10 +1151,7 @@ smb2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
 	oparms.tcon = tcon;
 	oparms.desired_access = FILE_WRITE_EA;
 	oparms.disposition = FILE_OPEN;
-	if (backup_cred(cifs_sb))
-		oparms.create_options = CREATE_OPEN_BACKUP_INTENT;
-	else
-		oparms.create_options = 0;
+	oparms.create_options = cifs_create_options(cifs_sb, 0);
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
@@ -1422,6 +1419,7 @@ SMB2_request_res_key(const unsigned int xid, struct cifs_tcon *tcon,
 static int
 smb2_ioctl_query_info(const unsigned int xid,
 		      struct cifs_tcon *tcon,
+		      struct cifs_sb_info *cifs_sb,
 		      __le16 *path, int is_dir,
 		      unsigned long p)
 {
@@ -1447,6 +1445,7 @@ smb2_ioctl_query_info(const unsigned int xid,
 	struct kvec close_iov[1];
 	unsigned int size[2];
 	void *data[2];
+	int create_options = is_dir ? CREATE_NOT_FILE : CREATE_NOT_DIR;
 
 	memset(rqst, 0, sizeof(rqst));
 	resp_buftype[0] = resp_buftype[1] = resp_buftype[2] = CIFS_NO_BUFFER;
@@ -1477,10 +1476,7 @@ smb2_ioctl_query_info(const unsigned int xid,
 	memset(&oparms, 0, sizeof(oparms));
 	oparms.tcon = tcon;
 	oparms.disposition = FILE_OPEN;
-	if (is_dir)
-		oparms.create_options = CREATE_NOT_FILE;
-	else
-		oparms.create_options = CREATE_NOT_DIR;
+	oparms.create_options = cifs_create_options(cifs_sb, create_options);
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
@@ -2086,10 +2082,7 @@ smb2_query_dir_first(const unsigned int xid, struct cifs_tcon *tcon,
 	oparms.tcon = tcon;
 	oparms.desired_access = FILE_READ_ATTRIBUTES | FILE_READ_DATA;
 	oparms.disposition = FILE_OPEN;
-	if (backup_cred(cifs_sb))
-		oparms.create_options = CREATE_OPEN_BACKUP_INTENT;
-	else
-		oparms.create_options = 0;
+	oparms.create_options = cifs_create_options(cifs_sb, 0);
 	oparms.fid = fid;
 	oparms.reconnect = false;
 
@@ -2343,10 +2336,7 @@ smb2_query_info_compound(const unsigned int xid, struct cifs_tcon *tcon,
 	oparms.tcon = tcon;
 	oparms.desired_access = desired_access;
 	oparms.disposition = FILE_OPEN;
-	if (cifs_sb && backup_cred(cifs_sb))
-		oparms.create_options = CREATE_OPEN_BACKUP_INTENT;
-	else
-		oparms.create_options = 0;
+	oparms.create_options = cifs_create_options(cifs_sb, 0);
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
@@ -2402,7 +2392,7 @@ smb2_query_info_compound(const unsigned int xid, struct cifs_tcon *tcon,
 
 static int
 smb2_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
-	     struct kstatfs *buf)
+	     struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
 {
 	struct smb2_query_info_rsp *rsp;
 	struct smb2_fs_full_size_info *info = NULL;
@@ -2439,7 +2429,7 @@ smb2_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
 
 static int
 smb311_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
-	     struct kstatfs *buf)
+	       struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
 {
 	int rc;
 	__le16 srch_path = 0; /* Null - open root of share */
@@ -2448,12 +2438,12 @@ smb311_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
 	struct cifs_fid fid;
 
 	if (!tcon->posix_extensions)
-		return smb2_queryfs(xid, tcon, buf);
+		return smb2_queryfs(xid, tcon, cifs_sb, buf);
 
 	oparms.tcon = tcon;
 	oparms.desired_access = FILE_READ_ATTRIBUTES;
 	oparms.disposition = FILE_OPEN;
-	oparms.create_options = 0;
+	oparms.create_options = cifs_create_options(cifs_sb, 0);
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
@@ -2722,6 +2712,7 @@ smb2_query_symlink(const unsigned int xid, struct cifs_tcon *tcon,
 	struct smb2_create_rsp *create_rsp;
 	struct smb2_ioctl_rsp *ioctl_rsp;
 	struct reparse_data_buffer *reparse_buf;
+	int create_options = is_reparse_point ? OPEN_REPARSE_POINT : 0;
 	u32 plen;
 
 	cifs_dbg(FYI, "%s: path: %s\n", __func__, full_path);
@@ -2748,14 +2739,7 @@ smb2_query_symlink(const unsigned int xid, struct cifs_tcon *tcon,
 	oparms.tcon = tcon;
 	oparms.desired_access = FILE_READ_ATTRIBUTES;
 	oparms.disposition = FILE_OPEN;
-
-	if (backup_cred(cifs_sb))
-		oparms.create_options = CREATE_OPEN_BACKUP_INTENT;
-	else
-		oparms.create_options = 0;
-	if (is_reparse_point)
-		oparms.create_options = OPEN_REPARSE_POINT;
-
+	oparms.create_options = cifs_create_options(cifs_sb, create_options);
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
@@ -2934,11 +2918,6 @@ get_smb2_acl_by_path(struct cifs_sb_info *cifs_sb,
 	tcon = tlink_tcon(tlink);
 	xid = get_xid();
 
-	if (backup_cred(cifs_sb))
-		oparms.create_options = CREATE_OPEN_BACKUP_INTENT;
-	else
-		oparms.create_options = 0;
-
 	utf16_path = cifs_convert_path_to_utf16(path, cifs_sb);
 	if (!utf16_path) {
 		rc = -ENOMEM;
@@ -2949,6 +2928,7 @@ get_smb2_acl_by_path(struct cifs_sb_info *cifs_sb,
 	oparms.tcon = tcon;
 	oparms.desired_access = READ_CONTROL;
 	oparms.disposition = FILE_OPEN;
+	oparms.create_options = cifs_create_options(cifs_sb, 0);
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
@@ -2990,11 +2970,6 @@ set_smb2_acl(struct cifs_ntsd *pnntsd, __u32 acllen,
 	tcon = tlink_tcon(tlink);
 	xid = get_xid();
 
-	if (backup_cred(cifs_sb))
-		oparms.create_options = CREATE_OPEN_BACKUP_INTENT;
-	else
-		oparms.create_options = 0;
-
 	if (aclflag == CIFS_ACL_OWNER || aclflag == CIFS_ACL_GROUP)
 		access_flags = WRITE_OWNER;
 	else
@@ -3009,6 +2984,7 @@ set_smb2_acl(struct cifs_ntsd *pnntsd, __u32 acllen,
 
 	oparms.tcon = tcon;
 	oparms.desired_access = access_flags;
+	oparms.create_options = cifs_create_options(cifs_sb, 0);
 	oparms.disposition = FILE_OPEN;
 	oparms.path = path;
 	oparms.fid = &fid;
@@ -4491,7 +4467,6 @@ smb2_make_node(unsigned int xid, struct inode *inode,
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
 	int rc = -EPERM;
-	int create_options = CREATE_NOT_DIR | CREATE_OPTION_SPECIAL;
 	FILE_ALL_INFO *buf = NULL;
 	struct cifs_io_parms io_parms;
 	__u32 oplock = 0;
@@ -4527,13 +4502,11 @@ smb2_make_node(unsigned int xid, struct inode *inode,
 		goto out;
 	}
 
-	if (backup_cred(cifs_sb))
-		create_options |= CREATE_OPEN_BACKUP_INTENT;
-
 	oparms.tcon = tcon;
 	oparms.cifs_sb = cifs_sb;
 	oparms.desired_access = GENERIC_WRITE;
-	oparms.create_options = create_options;
+	oparms.create_options = cifs_create_options(cifs_sb, CREATE_NOT_DIR |
+						    CREATE_OPTION_SPECIAL);
 	oparms.disposition = FILE_CREATE;
 	oparms.path = full_path;
 	oparms.fid = &fid;
diff --git a/fs/cifs/smb2proto.h b/fs/cifs/smb2proto.h
index 6c678e00046f..de6388ef344f 100644
--- a/fs/cifs/smb2proto.h
+++ b/fs/cifs/smb2proto.h
@@ -68,7 +68,7 @@ extern int smb3_handle_read_data(struct TCP_Server_Info *server,
 				 struct mid_q_entry *mid);
 
 extern int open_shroot(unsigned int xid, struct cifs_tcon *tcon,
-			struct cifs_fid *pfid);
+		       struct cifs_sb_info *cifs_sb, struct cifs_fid *pfid);
 extern void close_shroot(struct cached_fid *cfid);
 extern void close_shroot_lease(struct cached_fid *cfid);
 extern void close_shroot_lease_locked(struct cached_fid *cfid);
-- 
2.17.1

