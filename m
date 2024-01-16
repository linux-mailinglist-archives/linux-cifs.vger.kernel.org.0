Return-Path: <linux-cifs+bounces-781-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5365E82E6D5
	for <lists+linux-cifs@lfdr.de>; Tue, 16 Jan 2024 02:27:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DAB211C229D2
	for <lists+linux-cifs@lfdr.de>; Tue, 16 Jan 2024 01:27:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC307200D4;
	Tue, 16 Jan 2024 01:06:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NsvrZdv6"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E5EB208BC;
	Tue, 16 Jan 2024 01:06:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81482C43390;
	Tue, 16 Jan 2024 01:06:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705367166;
	bh=XGdICq+l18TSqFMJA84pLGYa5We5RAii7DbgeMs2CJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NsvrZdv6/7v4e6GzT2kAehsXi0rWZDo66+7qGiSRtsgpoam3RXPz3xLGb5hWd1auf
	 +z9bjXQf15O6Lmmp77TLjaZ0YcdLe0yomqlavCJTFgTs9/Y/szj4LCgxX9PZjlDgHn
	 OJIcbglzAmJv6tiHV4PnNvJNh99j/SyETSK443Z3xHNTMG71bEImM3mRUMIy+BfeIg
	 tyzoS7iFSbuFLGFvn9x/RRv4QSmiJoYU3wCAsObH1YEVDROkbY1KRpoJHB4t/Ohns1
	 CGPLKho/LlSGe92s1+7Di05Vox9B1yj9hgM1wbDzzCkkW0WDI/acuXX4xJKw5HfqdB
	 wFmoum6tv0IUg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.6 13/19] smb: client: fix renaming of reparse points
Date: Mon, 15 Jan 2024 20:05:08 -0500
Message-ID: <20240116010532.218428-13-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240116010532.218428-1-sashal@kernel.org>
References: <20240116010532.218428-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.12
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 7435d51b7ea2ab7801279c43ecd72063e9d5c92f ]

The client was sending an SMB2_CREATE request without setting
OPEN_REPARSE_POINT flag thus failing the entire rename operation.

Fix this by setting OPEN_REPARSE_POINT in create options for
SMB2_CREATE request when the source inode is a repase point.

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h  | 22 +++++++++++++++++-----
 fs/smb/client/cifsproto.h |  7 ++++---
 fs/smb/client/cifssmb.c   |  8 ++++----
 fs/smb/client/inode.c     |  3 ++-
 fs/smb/client/smb2inode.c | 38 +++++++++++++++++++++++---------------
 fs/smb/client/smb2proto.h |  8 +++++---
 6 files changed, 55 insertions(+), 31 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 4eac7dcb82f9..3650094590b3 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -205,9 +205,18 @@ struct cifs_open_info_data {
 	};
 };
 
-#define cifs_open_data_reparse(d) \
-	((d)->reparse_point || \
-	 (le32_to_cpu((d)->fi.Attributes) & ATTR_REPARSE))
+static inline bool cifs_open_data_reparse(struct cifs_open_info_data *data)
+{
+	struct smb2_file_all_info *fi = &data->fi;
+	u32 attrs = le32_to_cpu(fi->Attributes);
+	bool ret;
+
+	ret = data->reparse_point || (attrs & ATTR_REPARSE);
+	if (ret)
+		attrs |= ATTR_REPARSE;
+	fi->Attributes = cpu_to_le32(attrs);
+	return ret;
+}
 
 static inline void cifs_free_open_info(struct cifs_open_info_data *data)
 {
@@ -390,8 +399,11 @@ struct smb_version_operations {
 	int (*rename_pending_delete)(const char *, struct dentry *,
 				     const unsigned int);
 	/* send rename request */
-	int (*rename)(const unsigned int, struct cifs_tcon *, const char *,
-		      const char *, struct cifs_sb_info *);
+	int (*rename)(const unsigned int xid,
+		      struct cifs_tcon *tcon,
+		      struct dentry *source_dentry,
+		      const char *from_name, const char *to_name,
+		      struct cifs_sb_info *cifs_sb);
 	/* send create hardlink request */
 	int (*create_hardlink)(const unsigned int, struct cifs_tcon *,
 			       const char *, const char *,
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index c858feaf4f92..35b58c2d81dd 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -434,9 +434,10 @@ extern int CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tcon *tcon,
 			int remap_special_chars);
 extern int CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon,
 			  const char *name, struct cifs_sb_info *cifs_sb);
-extern int CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
-			 const char *from_name, const char *to_name,
-			 struct cifs_sb_info *cifs_sb);
+int CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
+		  struct dentry *source_dentry,
+		  const char *from_name, const char *to_name,
+		  struct cifs_sb_info *cifs_sb);
 extern int CIFSSMBRenameOpenFile(const unsigned int xid, struct cifs_tcon *tcon,
 				 int netfid, const char *target_name,
 				 const struct nls_table *nls_codepage,
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index bad91ba6c3a9..43a90e646a7a 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -2147,10 +2147,10 @@ CIFSSMBFlush(const unsigned int xid, struct cifs_tcon *tcon, int smb_file_id)
 	return rc;
 }
 
-int
-CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
-	      const char *from_name, const char *to_name,
-	      struct cifs_sb_info *cifs_sb)
+int CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
+		  struct dentry *source_dentry,
+		  const char *from_name, const char *to_name,
+		  struct cifs_sb_info *cifs_sb)
 {
 	int rc = 0;
 	RENAME_REQ *pSMB = NULL;
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 09c5c0f5c96e..eb54e4893777 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2219,7 +2219,8 @@ cifs_do_rename(const unsigned int xid, struct dentry *from_dentry,
 		return -ENOSYS;
 
 	/* try path-based rename first */
-	rc = server->ops->rename(xid, tcon, from_path, to_path, cifs_sb);
+	rc = server->ops->rename(xid, tcon, from_dentry,
+				 from_path, to_path, cifs_sb);
 
 	/*
 	 * Don't bother with rename by filehandle unless file is busy and
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index c94940af5d4b..c3e28673e0cd 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -781,11 +781,11 @@ smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 				ACL_NO_MODE, NULL, SMB2_OP_DELETE, NULL, NULL, NULL, NULL, NULL);
 }
 
-static int
-smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
-		   const char *from_name, const char *to_name,
-		   struct cifs_sb_info *cifs_sb, __u32 access, int command,
-		   struct cifsFileInfo *cfile)
+static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
+			      const char *from_name, const char *to_name,
+			      struct cifs_sb_info *cifs_sb,
+			      __u32 create_options, __u32 access,
+			      int command, struct cifsFileInfo *cfile)
 {
 	__le16 *smb2_to_name = NULL;
 	int rc;
@@ -796,25 +796,33 @@ smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
 		goto smb2_rename_path;
 	}
 	rc = smb2_compound_op(xid, tcon, cifs_sb, from_name, access,
-			      FILE_OPEN, 0, ACL_NO_MODE, smb2_to_name,
+			      FILE_OPEN, create_options, ACL_NO_MODE, smb2_to_name,
 			      command, cfile, NULL, NULL, NULL, NULL);
 smb2_rename_path:
 	kfree(smb2_to_name);
 	return rc;
 }
 
-int
-smb2_rename_path(const unsigned int xid, struct cifs_tcon *tcon,
-		 const char *from_name, const char *to_name,
-		 struct cifs_sb_info *cifs_sb)
+int smb2_rename_path(const unsigned int xid,
+		     struct cifs_tcon *tcon,
+		     struct dentry *source_dentry,
+		     const char *from_name, const char *to_name,
+		     struct cifs_sb_info *cifs_sb)
 {
+	struct cifsInodeInfo *ci;
 	struct cifsFileInfo *cfile;
+	__u32 co = 0;
 
+	if (source_dentry) {
+		ci = CIFS_I(d_inode(source_dentry));
+		if (ci->cifsAttrs & ATTR_REPARSE)
+			co |= OPEN_REPARSE_POINT;
+	}
 	drop_cached_dir_by_name(xid, tcon, from_name, cifs_sb);
 	cifs_get_writable_path(tcon, from_name, FIND_WR_WITH_DELETE, &cfile);
 
-	return smb2_set_path_attr(xid, tcon, from_name, to_name,
-				  cifs_sb, DELETE, SMB2_OP_RENAME, cfile);
+	return smb2_set_path_attr(xid, tcon, from_name, to_name, cifs_sb,
+				  co, DELETE, SMB2_OP_RENAME, cfile);
 }
 
 int
@@ -822,9 +830,9 @@ smb2_create_hardlink(const unsigned int xid, struct cifs_tcon *tcon,
 		     const char *from_name, const char *to_name,
 		     struct cifs_sb_info *cifs_sb)
 {
-	return smb2_set_path_attr(xid, tcon, from_name, to_name, cifs_sb,
-				  FILE_READ_ATTRIBUTES, SMB2_OP_HARDLINK,
-				  NULL);
+	return smb2_set_path_attr(xid, tcon, from_name, to_name,
+				  cifs_sb, 0, FILE_READ_ATTRIBUTES,
+				  SMB2_OP_HARDLINK, NULL);
 }
 
 int
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 0e371f7e2854..7cbf1a76b42d 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -80,9 +80,11 @@ extern int smb2_rmdir(const unsigned int xid, struct cifs_tcon *tcon,
 		      const char *name, struct cifs_sb_info *cifs_sb);
 extern int smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon,
 		       const char *name, struct cifs_sb_info *cifs_sb);
-extern int smb2_rename_path(const unsigned int xid, struct cifs_tcon *tcon,
-			    const char *from_name, const char *to_name,
-			    struct cifs_sb_info *cifs_sb);
+int smb2_rename_path(const unsigned int xid,
+		     struct cifs_tcon *tcon,
+		     struct dentry *source_dentry,
+		     const char *from_name, const char *to_name,
+		     struct cifs_sb_info *cifs_sb);
 extern int smb2_create_hardlink(const unsigned int xid, struct cifs_tcon *tcon,
 				const char *from_name, const char *to_name,
 				struct cifs_sb_info *cifs_sb);
-- 
2.43.0


