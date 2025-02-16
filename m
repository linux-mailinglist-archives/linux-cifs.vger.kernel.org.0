Return-Path: <linux-cifs+bounces-4090-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC0B5A375E8
	for <lists+linux-cifs@lfdr.de>; Sun, 16 Feb 2025 17:42:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EE2113A7994
	for <lists+linux-cifs@lfdr.de>; Sun, 16 Feb 2025 16:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 051F919D086;
	Sun, 16 Feb 2025 16:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XbYMQD7G"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CC1D219C558;
	Sun, 16 Feb 2025 16:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739724139; cv=none; b=p4LvEHQ97MAkVSe/9q4OYqMt2x+cyinaRFWiFeME7WQh2k8Ab6CCJeJmWQz8NpfS2S8n3UU0aDdEVxhbObYEoAFm0dby3wrYBEy3IGtiimmMaLnS1IK4h3elALZ1k7M37fN7Wh12Jga/QolCB8vX5T3d5VQdp36jyuuYC4zcTXs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739724139; c=relaxed/simple;
	bh=RGGcyeHiog1KdXGjsvhFU0C6fu7FKSWGs4nXS+PgjfU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MUQrerH6TSJtOwOANHL3mOcq63GqtsJwWYuosGWP4ROSfnumm/Ar0iSmy8kcSidpMlejTztZqeT9sNm9jfP6BRZpz8JHkgxKo2IQgWoIo8FRmKjEeFqLVQAxkZQ9myknfXgK7kAZCrmCqGslfvJ5r/N7PwXhBovF+R0YXjdXK5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XbYMQD7G; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25AD1C4CEE8;
	Sun, 16 Feb 2025 16:42:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739724139;
	bh=RGGcyeHiog1KdXGjsvhFU0C6fu7FKSWGs4nXS+PgjfU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=XbYMQD7G8F3Hv+GsBBgFG5Xc7/hqAFD4+PE+XD88b9nu06i0Zy4PXyGKd+t7d9fJf
	 5pNNTLrrDZxdJo9NlTisUa/L91ib/x526j0cdxFlV2rXNVeq/IKR+L9Xuz9S1xq9Qu
	 v63Rj3cUqGolEWgGrvFsU6JYOc27kAxhQnbF9+W9vQNqXbAiZ6LffmVOanXlJSe2ya
	 0cTA3vkZTYuFEapj6YdheLOZlhW8A4xcQSbm+fY5yc8Un99FQknQ4Dt4W2tJZkqPtf
	 x8oerz50XwyNnD9BF2hbMK3DqdQOokJSqxwm7INf5HYwlzavndLAZaRF9YAZRs6jWP
	 G7slU7mA1z03g==
Received: by pali.im (Postfix)
	id 9E644F2E; Sun, 16 Feb 2025 17:42:06 +0100 (CET)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Amir Goldstein <amir73il@gmail.com>,
	"Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>
Cc: linux-fsdevel@vger.kernel.org,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC PATCH 4/4] cifs: Implement FS_IOC_FS[GS]ETXATTR API for Windows attributes
Date: Sun, 16 Feb 2025 17:40:29 +0100
Message-Id: <20250216164029.20673-5-pali@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250216164029.20673-1-pali@kernel.org>
References: <20250216164029.20673-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/smb/client/cifsfs.c    |   4 +
 fs/smb/client/cifsfs.h    |   2 +
 fs/smb/client/cifsglob.h  |   4 +-
 fs/smb/client/cifsproto.h |   2 +-
 fs/smb/client/cifssmb.c   |   4 +-
 fs/smb/client/inode.c     | 181 ++++++++++++++++++++++++++++++++++++++
 fs/smb/client/ioctl.c     |   8 +-
 fs/smb/client/smb1ops.c   |   4 +-
 fs/smb/client/smb2ops.c   |   8 +-
 fs/smb/client/smb2pdu.c   |   4 +-
 fs/smb/client/smb2proto.h |   2 +-
 fs/smb/common/smb2pdu.h   |   2 +
 12 files changed, 209 insertions(+), 16 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index ea31d693ea9f..b441675f9afd 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1182,6 +1182,8 @@ const struct inode_operations cifs_dir_inode_ops = {
 	.listxattr = cifs_listxattr,
 	.get_acl = cifs_get_acl,
 	.set_acl = cifs_set_acl,
+	.fileattr_get = cifs_fileattr_get,
+	.fileattr_set = cifs_fileattr_set,
 };
 
 const struct inode_operations cifs_file_inode_ops = {
@@ -1192,6 +1194,8 @@ const struct inode_operations cifs_file_inode_ops = {
 	.fiemap = cifs_fiemap,
 	.get_acl = cifs_get_acl,
 	.set_acl = cifs_set_acl,
+	.fileattr_get = cifs_fileattr_get,
+	.fileattr_set = cifs_fileattr_set,
 };
 
 const char *cifs_get_link(struct dentry *dentry, struct inode *inode,
diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 831fee962c4d..b1e6025e2cbc 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -77,6 +77,8 @@ extern int cifs_setattr(struct mnt_idmap *, struct dentry *,
 			struct iattr *);
 extern int cifs_fiemap(struct inode *, struct fiemap_extent_info *, u64 start,
 		       u64 len);
+extern int cifs_fileattr_get(struct dentry *dentry, struct fileattr *fa);
+extern int cifs_fileattr_set(struct mnt_idmap *idmap, struct dentry *dentry, struct fileattr *fa);
 
 extern const struct inode_operations cifs_file_inode_ops;
 extern const struct inode_operations cifs_symlink_inode_ops;
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index b764bfe916b4..233a0a13b0e2 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -426,7 +426,7 @@ struct smb_version_operations {
 	int (*set_file_info)(struct inode *, const char *, FILE_BASIC_INFO *,
 			     const unsigned int);
 	int (*set_compression)(const unsigned int, struct cifs_tcon *,
-			       struct cifsFileInfo *);
+			       struct cifsFileInfo *, bool);
 	/* check if we can send an echo or nor */
 	bool (*can_echo)(struct TCP_Server_Info *);
 	/* send echo request */
@@ -538,7 +538,7 @@ struct smb_version_operations {
 	int (*calc_signature)(struct smb_rqst *, struct TCP_Server_Info *,
 				bool allocate_crypto);
 	int (*set_integrity)(const unsigned int, struct cifs_tcon *tcon,
-			     struct cifsFileInfo *src_file);
+			     struct cifsFileInfo *src_file, bool enable);
 	int (*enum_snapshots)(const unsigned int xid, struct cifs_tcon *tcon,
 			     struct cifsFileInfo *src_file, void __user *);
 	int (*notify)(const unsigned int xid, struct file *pfile,
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 47ecc0884a74..f5f6be6f343e 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -506,7 +506,7 @@ extern struct inode *cifs_create_reparse_inode(struct cifs_open_info_data *data,
 					       struct kvec *reparse_iov,
 					       struct kvec *xattr_iov);
 extern int CIFSSMB_set_compression(const unsigned int xid,
-				   struct cifs_tcon *tcon, __u16 fid);
+				   struct cifs_tcon *tcon, __u16 fid, bool enable);
 extern int CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms,
 		     int *oplock, FILE_ALL_INFO *buf);
 extern int SMBOldOpen(const unsigned int xid, struct cifs_tcon *tcon,
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 3dbff55b639d..643a55db3ca9 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -3454,7 +3454,7 @@ struct inode *cifs_create_reparse_inode(struct cifs_open_info_data *data,
 
 int
 CIFSSMB_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
-		    __u16 fid)
+		    __u16 fid, bool enable)
 {
 	int rc = 0;
 	int bytes_returned;
@@ -3467,7 +3467,7 @@ CIFSSMB_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
 	if (rc)
 		return rc;
 
-	pSMB->compression_state = cpu_to_le16(COMPRESSION_FORMAT_DEFAULT);
+	pSMB->compression_state = cpu_to_le16(enable ? COMPRESSION_FORMAT_DEFAULT : COMPRESSION_FORMAT_NONE);
 
 	pSMB->TotalParameterCount = 0;
 	pSMB->TotalDataCount = cpu_to_le32(2);
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index dfad9284a87c..d07ebb99c262 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -13,6 +13,7 @@
 #include <linux/sched/signal.h>
 #include <linux/wait_bit.h>
 #include <linux/fiemap.h>
+#include <linux/fileattr.h>
 #include <asm/div64.h>
 #include "cifsfs.h"
 #include "cifspdu.h"
@@ -83,6 +84,7 @@ static void cifs_set_ops(struct inode *inode)
 		inode->i_op = &cifs_symlink_inode_ops;
 		break;
 	default:
+		inode->i_op = &cifs_file_inode_ops;
 		init_special_inode(inode, inode->i_mode, inode->i_rdev);
 		break;
 	}
@@ -3282,3 +3284,182 @@ cifs_setattr(struct mnt_idmap *idmap, struct dentry *direntry,
 	/* BB: add cifs_setattr_legacy for really old servers */
 	return rc;
 }
+
+int cifs_fileattr_get(struct dentry *dentry, struct fileattr *fa)
+{
+	struct cifs_sb_info *cifs_sb = CIFS_SB(dentry->d_sb);
+	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
+	struct inode *inode = d_inode(dentry);
+	u32 attrs = CIFS_I(inode)->cifsAttrs;
+	u32 fsattrs = le32_to_cpu(tcon->fsAttrInfo.Attributes);
+	u32 xflags = 0;
+	u32 xflags_mask = FS_XFLAG_IMMUTABLEUSER;
+	u16 xflags2 = 0;
+	u16 xflags2_mask = FS_XFLAG2_HIDDEN | FS_XFLAG2_SYSTEM | FS_XFLAG2_ARCHIVE |
+			   FS_XFLAG2_TEMPORARY | FS_XFLAG2_NOTINDEXED |
+			   FS_XFLAG2_NOSCRUBDATA | FS_XFLAG2_OFFLINE |
+			   FS_XFLAG2_PINNED | FS_XFLAG2_UNPINNED;
+
+	if (fsattrs & FILE_FILE_COMPRESSION)
+		xflags_mask |= FS_XFLAG_COMPRESSED;
+	if (fsattrs & FILE_SUPPORTS_ENCRYPTION)
+		xflags_mask |= FS_XFLAG_COMPRESSED;
+	if (fsattrs & FILE_SUPPORT_INTEGRITY_STREAMS)
+		xflags_mask |= FS_XFLAG_CHECKSUMS;
+
+	if (attrs & FILE_ATTRIBUTE_READONLY)
+		xflags |= FS_XFLAG_IMMUTABLEUSER;
+	if (attrs & FILE_ATTRIBUTE_HIDDEN)
+		xflags2 |= FS_XFLAG2_HIDDEN;
+	if (attrs & FILE_ATTRIBUTE_SYSTEM)
+		xflags2 |= FS_XFLAG2_SYSTEM;
+	if (attrs & FILE_ATTRIBUTE_ARCHIVE)
+		xflags2 |= FS_XFLAG2_ARCHIVE;
+	if (attrs & FILE_ATTRIBUTE_TEMPORARY)
+		xflags2 |= FS_XFLAG2_TEMPORARY;
+	if (attrs & FILE_ATTRIBUTE_COMPRESSED)
+		xflags |= FS_XFLAG_COMPRESSED;
+	if (attrs & FILE_ATTRIBUTE_OFFLINE)
+		xflags2 |= FS_XFLAG2_OFFLINE;
+	if (attrs & FILE_ATTRIBUTE_NOT_CONTENT_INDEXED)
+		xflags2 |= FS_XFLAG2_NOTINDEXED;
+	if (attrs & FILE_ATTRIBUTE_ENCRYPTED)
+		xflags |= FS_XFLAG_ENCRYPTED;
+	if (attrs & FILE_ATTRIBUTE_INTEGRITY_STREAM)
+		xflags |= FS_XFLAG_CHECKSUMS;
+	if (attrs & FILE_ATTRIBUTE_NO_SCRUB_DATA)
+		xflags2 |= FS_XFLAG2_NOSCRUBDATA;
+	if (attrs & FILE_ATTRIBUTE_PINNED)
+		xflags2 |= FS_XFLAG2_PINNED;
+	if (attrs & FILE_ATTRIBUTE_UNPINNED)
+		xflags2 |= FS_XFLAG2_UNPINNED;
+
+	fileattr_fill_xflags(fa, xflags, xflags_mask, xflags2, xflags2_mask);
+	return 0;
+}
+
+#define MODIFY_ATTRS_COND(attrs, xflags, xflag, attr) (attrs) ^= ((-(!!((xflags) & (xflag))) ^ (attrs)) & (attr))
+
+int cifs_fileattr_set(struct mnt_idmap *idmap,
+		      struct dentry *dentry, struct fileattr *fa)
+{
+	struct cifs_sb_info *cifs_sb = CIFS_SB(dentry->d_sb);
+	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
+	struct inode *inode = d_inode(dentry);
+	u32 attrs = CIFS_I(inode)->cifsAttrs;
+	struct cifsFileInfo open_file_tmp = {};
+	struct cifsFileInfo *open_file = NULL;
+	struct cifs_open_parms oparms;
+	FILE_BASIC_INFO info_buf = {};
+	bool do_close = false;
+	const char *full_path;
+	unsigned int xid;
+	__u32 oplock;
+	void *page;
+	int rc;
+
+	if ((fa->fsx_xflags_mask & ~(FS_XFLAG_IMMUTABLEUSER | FS_XFLAG_COMPRESSED |
+				 FS_XFLAG_ENCRYPTED | FS_XFLAG_CHECKSUMS)) ||
+	    (fa->fsx_xflags2_mask & ~(FS_XFLAG2_HIDDEN | FS_XFLAG2_SYSTEM | FS_XFLAG2_ARCHIVE |
+				  FS_XFLAG2_TEMPORARY | FS_XFLAG2_NOTINDEXED |
+				  FS_XFLAG2_NOSCRUBDATA | FS_XFLAG2_OFFLINE |
+				  FS_XFLAG2_PINNED | FS_XFLAG2_UNPINNED)) ||
+	    (fa->flags & ~FS_COMMON_FL))
+		return -EOPNOTSUPP;
+
+	if (fa->fsx_xflags_mask & FS_XFLAG_IMMUTABLEUSER)
+		MODIFY_ATTRS_COND(attrs, fa->fsx_xflags, FS_XFLAG_IMMUTABLEUSER, FILE_ATTRIBUTE_READONLY);
+	if (fa->fsx_xflags2_mask & FS_XFLAG2_HIDDEN)
+		MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_HIDDEN, FILE_ATTRIBUTE_HIDDEN);
+	if (fa->fsx_xflags2_mask & FS_XFLAG2_SYSTEM)
+		MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_SYSTEM, FILE_ATTRIBUTE_SYSTEM);
+	if (fa->fsx_xflags2_mask & FS_XFLAG2_ARCHIVE)
+		MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_ARCHIVE, FILE_ATTRIBUTE_ARCHIVE);
+	if (fa->fsx_xflags2_mask & FS_XFLAG2_TEMPORARY)
+		MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_TEMPORARY, FILE_ATTRIBUTE_TEMPORARY);
+	if (fa->fsx_xflags2_mask & FS_XFLAG2_NOTINDEXED)
+		MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_NOTINDEXED, FILE_ATTRIBUTE_NOT_CONTENT_INDEXED);
+	if (fa->fsx_xflags2_mask & FS_XFLAG2_NOSCRUBDATA)
+		MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_NOSCRUBDATA, FILE_ATTRIBUTE_NO_SCRUB_DATA);
+	if (fa->fsx_xflags2_mask & FS_XFLAG2_OFFLINE)
+		MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_OFFLINE, FILE_ATTRIBUTE_OFFLINE);
+	if (fa->fsx_xflags2_mask & FS_XFLAG2_PINNED)
+		MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_PINNED, FILE_ATTRIBUTE_PINNED);
+	if (fa->fsx_xflags2_mask & FS_XFLAG2_UNPINNED)
+		MODIFY_ATTRS_COND(attrs, fa->fsx_xflags2, FS_XFLAG2_UNPINNED, FILE_ATTRIBUTE_UNPINNED);
+
+	page = alloc_dentry_path();
+
+	full_path = build_path_from_dentry(dentry, page);
+	if (IS_ERR(full_path)) {
+		rc = PTR_ERR(full_path);
+		goto out_page;
+	}
+
+	xid = get_xid();
+
+	if (attrs != CIFS_I(inode)->cifsAttrs) {
+		info_buf.Attributes = cpu_to_le32(attrs);
+		if (tcon->ses->server->ops->set_file_info)
+			rc = tcon->ses->server->ops->set_file_info(inode, full_path, &info_buf, xid);
+		else
+			rc = -EOPNOTSUPP;
+		if (rc)
+			goto out_xid;
+		CIFS_I(inode)->cifsAttrs = attrs;
+	}
+
+	if (fa->fsx_xflags_mask & (FS_XFLAG_COMPRESSED | FS_XFLAG_ENCRYPTED | FS_XFLAG_CHECKSUMS)) {
+		open_file = find_writable_file(CIFS_I(inode), FIND_WR_FSUID_ONLY);
+		if (!open_file) {
+			oparms = CIFS_OPARMS(cifs_sb, tcon, full_path, FILE_WRITE_DATA, FILE_OPEN, 0, ACL_NO_MODE);
+			oparms.fid = &open_file_tmp.fid;
+			oplock = 0;
+			oparms.create_options = cifs_create_options(cifs_sb, 0);
+			rc = tcon->ses->server->ops->open(xid, &oparms, &oplock, NULL);
+			if (rc)
+				goto out_file;
+			do_close = true;
+			open_file = &open_file_tmp;
+		}
+	}
+
+	if (fa->fsx_xflags_mask & FS_XFLAG_COMPRESSED) {
+		if (tcon->ses->server->ops->set_compression)
+			rc = tcon->ses->server->ops->set_compression(xid, tcon, open_file, fa->fsx_xflags & FS_XFLAG_COMPRESSED);
+		else
+			rc = -EOPNOTSUPP;
+		if (rc)
+			goto out_file;
+		CIFS_I(inode)->cifsAttrs |= FILE_ATTRIBUTE_COMPRESSED;
+	}
+
+	if (fa->fsx_xflags_mask & FS_XFLAG_ENCRYPTED) {
+		/* TODO */
+		rc = -EOPNOTSUPP;
+		if (rc)
+			goto out_file;
+		CIFS_I(inode)->cifsAttrs |= FILE_ATTRIBUTE_ENCRYPTED;
+	}
+
+	if (fa->fsx_xflags_mask & FS_XFLAG_CHECKSUMS) {
+		if (tcon->ses->server->ops->set_integrity)
+			rc = tcon->ses->server->ops->set_integrity(xid, tcon, open_file, fa->fsx_xflags & FS_XFLAG_CHECKSUMS);
+		else
+			rc = -EOPNOTSUPP;
+		if (rc)
+			goto out_file;
+		CIFS_I(inode)->cifsAttrs |= FILE_ATTRIBUTE_INTEGRITY_STREAM;
+	}
+
+out_file:
+	if (do_close)
+		tcon->ses->server->ops->close(xid, tcon, oparms.fid);
+	else if (open_file)
+		cifsFileInfo_put(open_file);
+out_xid:
+	free_xid(xid);
+out_page:
+	free_dentry_path(page);
+	return rc;
+}
diff --git a/fs/smb/client/ioctl.c b/fs/smb/client/ioctl.c
index 56439da4f119..7c245085f891 100644
--- a/fs/smb/client/ioctl.c
+++ b/fs/smb/client/ioctl.c
@@ -356,12 +356,14 @@ long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg)
 	struct cifs_tcon *tcon;
 	struct tcon_link *tlink;
 	struct cifs_sb_info *cifs_sb;
+#if 0
 	__u64	ExtAttrBits = 0;
 #ifdef CONFIG_CIFS_POSIX
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 	__u64   caps;
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 #endif /* CONFIG_CIFS_POSIX */
+#endif
 
 	xid = get_xid();
 
@@ -372,6 +374,7 @@ long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg)
 		trace_smb3_ioctl(xid, pSMBFile->fid.persistent_fid, command);
 
 	switch (command) {
+#if 0
 		case FS_IOC_GETFLAGS:
 			if (pSMBFile == NULL)
 				break;
@@ -429,10 +432,11 @@ long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg)
 			/* Try to set compress flag */
 			if (tcon->ses->server->ops->set_compression) {
 				rc = tcon->ses->server->ops->set_compression(
-							xid, tcon, pSMBFile);
+							xid, tcon, pSMBFile, true);
 				cifs_dbg(FYI, "set compress flag rc %d\n", rc);
 			}
 			break;
+#endif
 		case CIFS_IOC_COPYCHUNK_FILE:
 			rc = cifs_ioctl_copychunk(xid, filep, arg);
 			break;
@@ -445,7 +449,7 @@ long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg)
 			tcon = tlink_tcon(pSMBFile->tlink);
 			if (tcon->ses->server->ops->set_integrity)
 				rc = tcon->ses->server->ops->set_integrity(xid,
-						tcon, pSMBFile);
+						tcon, pSMBFile, true);
 			else
 				rc = -EOPNOTSUPP;
 			break;
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index ba6452d89df3..2e854bde67de 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -1245,9 +1245,9 @@ smb_set_file_info(struct inode *inode, const char *full_path,
 
 static int
 cifs_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
-		   struct cifsFileInfo *cfile)
+		   struct cifsFileInfo *cfile, bool enable)
 {
-	return CIFSSMB_set_compression(xid, tcon, cfile->fid.netfid);
+	return CIFSSMB_set_compression(xid, tcon, cfile->fid.netfid, enable);
 }
 
 static int
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index f8445a9ff9a1..9c66e413c59c 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2106,20 +2106,20 @@ smb2_duplicate_extents(const unsigned int xid,
 
 static int
 smb2_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
-		   struct cifsFileInfo *cfile)
+		   struct cifsFileInfo *cfile, bool enable)
 {
 	return SMB2_set_compression(xid, tcon, cfile->fid.persistent_fid,
-			    cfile->fid.volatile_fid);
+			    cfile->fid.volatile_fid, enable);
 }
 
 static int
 smb3_set_integrity(const unsigned int xid, struct cifs_tcon *tcon,
-		   struct cifsFileInfo *cfile)
+		   struct cifsFileInfo *cfile, bool enable)
 {
 	struct fsctl_set_integrity_information_req integr_info;
 	unsigned int ret_data_len;
 
-	integr_info.ChecksumAlgorithm = cpu_to_le16(CHECKSUM_TYPE_UNCHANGED);
+	integr_info.ChecksumAlgorithm = cpu_to_le16(enable ? CHECKSUM_TYPE_CRC64 : CHECKSUM_TYPE_NONE);
 	integr_info.Flags = 0;
 	integr_info.Reserved = 0;
 
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index a75947797d58..57d716cfc800 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3537,14 +3537,14 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
 
 int
 SMB2_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
-		     u64 persistent_fid, u64 volatile_fid)
+		     u64 persistent_fid, u64 volatile_fid, bool enable)
 {
 	int rc;
 	struct  compress_ioctl fsctl_input;
 	char *ret_data = NULL;
 
 	fsctl_input.CompressionState =
-			cpu_to_le16(COMPRESSION_FORMAT_DEFAULT);
+			cpu_to_le16(enable ? COMPRESSION_FORMAT_DEFAULT : COMPRESSION_FORMAT_NONE);
 
 	rc = SMB2_ioctl(xid, tcon, persistent_fid, volatile_fid,
 			FSCTL_SET_COMPRESSION,
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index cec5921bfdd2..6086bbdeeae0 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -250,7 +250,7 @@ extern int SMB2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
 		       u64 persistent_fid, u64 volatile_fid,
 		       struct smb2_file_full_ea_info *buf, int len);
 extern int SMB2_set_compression(const unsigned int xid, struct cifs_tcon *tcon,
-				u64 persistent_fid, u64 volatile_fid);
+				u64 persistent_fid, u64 volatile_fid, bool enable);
 extern int SMB2_oplock_break(const unsigned int xid, struct cifs_tcon *tcon,
 			     const u64 persistent_fid, const u64 volatile_fid,
 			     const __u8 oplock_level);
diff --git a/fs/smb/common/smb2pdu.h b/fs/smb/common/smb2pdu.h
index ab902b155650..a24194bef849 100644
--- a/fs/smb/common/smb2pdu.h
+++ b/fs/smb/common/smb2pdu.h
@@ -1077,6 +1077,8 @@ struct smb2_server_client_notification {
 #define FILE_ATTRIBUTE_ENCRYPTED		0x00004000
 #define FILE_ATTRIBUTE_INTEGRITY_STREAM		0x00008000
 #define FILE_ATTRIBUTE_NO_SCRUB_DATA		0x00020000
+#define FILE_ATTRIBUTE_PINNED			0x00080000
+#define FILE_ATTRIBUTE_UNPINNED			0x00100000
 #define FILE_ATTRIBUTE__MASK			0x00007FB7
 
 #define FILE_ATTRIBUTE_READONLY_LE              cpu_to_le32(0x00000001)
-- 
2.20.1


