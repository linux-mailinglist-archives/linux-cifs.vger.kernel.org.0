Return-Path: <linux-cifs+bounces-130-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87E307F0930
	for <lists+linux-cifs@lfdr.de>; Sun, 19 Nov 2023 22:45:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F129EB207D9
	for <lists+linux-cifs@lfdr.de>; Sun, 19 Nov 2023 21:45:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 96CD8199A2;
	Sun, 19 Nov 2023 21:45:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="I18Nhn6s"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8278131
	for <linux-cifs@vger.kernel.org>; Sun, 19 Nov 2023 13:45:20 -0800 (PST)
From: Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1700430319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZayOGldjKyeupsvJcFupAnoC9fSCsRo8GZ3Uo09Tqs4=;
	b=I18Nhn6sTb/A9ygM+vG7vTkG+1nfK5n5dw1u1vS5jWnP5ZW/uxjrvM8GY2+MZH3BTo2ekC
	yO/GL+o/HGqnUfQX+ZSoAYJNDnGGiV6hmLBxliwU5TDmgOtsd0AZ7CeexX4WdG+zH2Hxcq
	LtHuY9VWRMXsSjlax80du7EECwWUuxrxYMX5utIX+rmsjCimTWTMYxYu0cte5f9LJgeHMf
	llyMMfT9kX8cTyyt6nN6+K1zvo3fkGEPrpF0w5ewVoGFA1ad/ALSqJYLocouzW1Z82uZnC
	Jutlahi+kSlMrSjMN5OCf3vezWd8Ya1pZAIx/pfmCwKxkpN459eK1tPMY7FlHw==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1700430319; a=rsa-sha256;
	cv=none;
	b=UIAYXMRE+Afj7zmdL70o6I4BSkEVWG4LjagdTpjNv2SqPc5Gmlm0DUTsh/a4g6Evqx2w4c
	h8JHZYnbPrWuB874xgil6pzDY229vBN3PQFaKeJgyetd4HKzjjmXZ+q1MoZOUou5YEOz9v
	aRAZE4MgKwunN/qn9tGavEqfP5JwXEe4QFp9mMuuoybvl05P9ZaD+L7c5grj4a1JFXOXf8
	LKW1pe6Rjfo0HYHfy3eY6BJn9LB1aB6ul3MicrjCekB1KwMKH8iE3+Y1XNgXGiGAU21M8h
	SQCMtxi4HOyldprG8+77owLw7+BJ2RFYV98RroLkqbVqAVTEAzdwuRC3eJIiow==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1700430319; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZayOGldjKyeupsvJcFupAnoC9fSCsRo8GZ3Uo09Tqs4=;
	b=VfOUSb4BJLi+JU5y36Mkyq2HKUp/GC/HetGLGAf10Gouuf/W6FK8u/JmAX+RMKbireqtUt
	gJzcWPf4Krls+Gy57hEQZY81h4ijDGSIvtkRBRKFebQZ6og+SHyp9NPfyM9e9ZIVpngKgp
	hetHll+jY4hd5voDfYflRvGP++TWr6s4tkioHYFMxv/dHOe4AYHuJ6XZANTUrBTXC+EpRE
	dmB149i3/MGIzDFUIdo0fTzpV59o2d9qHpRTXdZkBCR9gtDgeHrz6pvgiuUcnzqAtfeXG0
	2DMMvaKMyshMHQI15GfSXx8cydB8zctLiG4v6a//qUvDFuazkvzM0rLlRArrQQ==
To: smfrench@gmail.com
Cc: linux-cifs@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH v2 3/3] smb: client: set correct file type from NFS reparse points
Date: Sun, 19 Nov 2023 18:44:50 -0300
Message-ID: <20231119214450.23779-3-pc@manguebit.com>
In-Reply-To: <20231119214450.23779-1-pc@manguebit.com>
References: <20231119182209.5140-1-pc@manguebit.com>
 <20231119214450.23779-1-pc@manguebit.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Handle all file types in NFS reparse points as specified in MS-FSCC
2.1.2.6 Network File System (NFS) Reparse Data Buffer.

The client is now able to set all file types based on the parsed NFS
reparse point, which used to support only symlinks.  This works for
SMB1+.

Before patch:

$ mount.cifs //srv/share /mnt -o ...
$ ls -l /mnt
ls: cannot access 'block': Operation not supported
ls: cannot access 'char': Operation not supported
ls: cannot access 'fifo': Operation not supported
ls: cannot access 'sock': Operation not supported
total 1
l????????? ? ?    ?    ?            ? block
l????????? ? ?    ?    ?            ? char
-rwxr-xr-x 1 root root 5 Nov 18 23:22 f0
l????????? ? ?    ?    ?            ? fifo
l--------- 1 root root 0 Nov 18 23:23 link -> f0
l????????? ? ?    ?    ?            ? sock

After patch:

$ mount.cifs //srv/share /mnt -o ...
$ ls -l /mnt
total 1
brwxr-xr-x 1 root root  123,  123 Nov 18 00:34 block
crwxr-xr-x 1 root root 1234, 1234 Nov 18 00:33 char
-rwxr-xr-x 1 root root          5 Nov 18 23:22 f0
prwxr-xr-x 1 root root          0 Nov 18 23:23 fifo
lrwxr-xr-x 1 root root          0 Nov 18 23:23 link -> f0
srwxr-xr-x 1 root root          0 Nov 19  2023 sock

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
---
 fs/smb/client/cifsglob.h  |  8 +++-
 fs/smb/client/cifspdu.h   |  2 +-
 fs/smb/client/cifsproto.h |  4 +-
 fs/smb/client/inode.c     | 51 ++++++++++++++++++--
 fs/smb/client/readdir.c   |  6 ++-
 fs/smb/client/smb1ops.c   |  3 +-
 fs/smb/client/smb2inode.c |  2 +-
 fs/smb/client/smb2ops.c   | 99 ++++++++++++++++++++-------------------
 8 files changed, 115 insertions(+), 60 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 111daa4ff261..7558167f603c 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -191,7 +191,13 @@ struct cifs_open_info_data {
 		bool reparse_point;
 		bool symlink;
 	};
-	__u32 reparse_tag;
+	struct {
+		__u32 tag;
+		union {
+			struct reparse_data_buffer *buf;
+			struct reparse_posix_data *posix;
+		};
+	} reparse;
 	char *symlink_target;
 	union {
 		struct smb2_file_all_info fi;
diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index 2a90134331a4..83ccc51a54d0 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -1509,7 +1509,7 @@ struct reparse_posix_data {
 	__le16	ReparseDataLength;
 	__u16	Reserved;
 	__le64	InodeType; /* LNK, FIFO, CHR etc. */
-	char	PathBuffer[];
+	__u8	DataBuffer[];
 } __attribute__((packed));
 
 struct cifs_quota_data {
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 8a739c10d634..c00f84420559 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -210,7 +210,7 @@ int cifs_get_inode_info(struct inode **inode, const char *full_path,
 			const struct cifs_fid *fid);
 bool cifs_reparse_point_to_fattr(struct cifs_sb_info *cifs_sb,
 				 struct cifs_fattr *fattr,
-				 u32 tag);
+				 struct cifs_open_info_data *data);
 extern int smb311_posix_get_inode_info(struct inode **pinode, const char *search_path,
 			struct super_block *sb, unsigned int xid);
 extern int cifs_get_inode_info_unix(struct inode **pinode,
@@ -667,7 +667,7 @@ char *extract_hostname(const char *unc);
 char *extract_sharename(const char *unc);
 int parse_reparse_point(struct reparse_data_buffer *buf,
 			u32 plen, struct cifs_sb_info *cifs_sb,
-			bool unicode, char **target_path);
+			bool unicode, struct cifs_open_info_data *data);
 
 #ifdef CONFIG_CIFS_DFS_UPCALL
 static inline int get_dfs_path(const unsigned int xid, struct cifs_ses *ses,
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index dd482de3dc3f..47f49be69ced 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -721,10 +721,51 @@ static void smb311_posix_info_to_fattr(struct cifs_fattr *fattr,
 		fattr->cf_mode, fattr->cf_uniqueid, fattr->cf_nlink);
 }
 
+static inline dev_t nfs_mkdev(struct reparse_posix_data *buf)
+{
+	u64 v = le64_to_cpu(*(__le64 *)buf->DataBuffer);
+
+	return MKDEV(v >> 32, v & 0xffffffff);
+}
+
 bool cifs_reparse_point_to_fattr(struct cifs_sb_info *cifs_sb,
 				 struct cifs_fattr *fattr,
-				 u32 tag)
+				 struct cifs_open_info_data *data)
 {
+	struct reparse_posix_data *buf = data->reparse.posix;
+	u32 tag = data->reparse.tag;
+
+	if (tag == IO_REPARSE_TAG_NFS && buf) {
+		switch (le64_to_cpu(buf->InodeType)) {
+		case NFS_SPECFILE_CHR:
+			fattr->cf_mode |= S_IFCHR | cifs_sb->ctx->file_mode;
+			fattr->cf_dtype = DT_CHR;
+			fattr->cf_rdev = nfs_mkdev(buf);
+			break;
+		case NFS_SPECFILE_BLK:
+			fattr->cf_mode |= S_IFBLK | cifs_sb->ctx->file_mode;
+			fattr->cf_dtype = DT_BLK;
+			fattr->cf_rdev = nfs_mkdev(buf);
+			break;
+		case NFS_SPECFILE_FIFO:
+			fattr->cf_mode |= S_IFIFO | cifs_sb->ctx->file_mode;
+			fattr->cf_dtype = DT_FIFO;
+			break;
+		case NFS_SPECFILE_SOCK:
+			fattr->cf_mode |= S_IFSOCK | cifs_sb->ctx->file_mode;
+			fattr->cf_dtype = DT_SOCK;
+			break;
+		case NFS_SPECFILE_LNK:
+			fattr->cf_mode = S_IFLNK | cifs_sb->ctx->file_mode;
+			fattr->cf_dtype = DT_LNK;
+			break;
+		default:
+			WARN_ON_ONCE(1);
+			return false;
+		}
+		return true;
+	}
+
 	switch (tag) {
 	case IO_REPARSE_TAG_LX_SYMLINK:
 		fattr->cf_mode |= S_IFLNK | cifs_sb->ctx->file_mode;
@@ -790,7 +831,7 @@ static void cifs_open_info_to_fattr(struct cifs_fattr *fattr,
 	fattr->cf_nlink = le32_to_cpu(info->NumberOfLinks);
 
 	if (cifs_open_data_reparse(data) &&
-	    cifs_reparse_point_to_fattr(cifs_sb, fattr, data->reparse_tag))
+	    cifs_reparse_point_to_fattr(cifs_sb, fattr, data))
 		goto out_reparse;
 
 	if (fattr->cf_cifsattrs & ATTR_DIRECTORY) {
@@ -855,7 +896,7 @@ cifs_get_file_info(struct file *filp)
 		data.adjust_tz = false;
 		if (data.symlink_target) {
 			data.symlink = true;
-			data.reparse_tag = IO_REPARSE_TAG_SYMLINK;
+			data.reparse.tag = IO_REPARSE_TAG_SYMLINK;
 		}
 		cifs_open_info_to_fattr(&fattr, &data, inode->i_sb);
 		break;
@@ -1024,7 +1065,7 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct kvec rsp_iov, *iov = NULL;
 	int rsp_buftype = CIFS_NO_BUFFER;
-	u32 tag = data->reparse_tag;
+	u32 tag = data->reparse.tag;
 	int rc = 0;
 
 	if (!tag && server->ops->query_reparse_point) {
@@ -1036,7 +1077,7 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 	}
 
 	rc = -EOPNOTSUPP;
-	switch ((data->reparse_tag = tag)) {
+	switch ((data->reparse.tag = tag)) {
 	case 0: /* SMB1 symlink */
 		if (server->ops->query_symlink) {
 			rc = server->ops->query_symlink(xid, tcon,
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 47fc22de8d20..d30ea2005eb3 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -153,6 +153,10 @@ static bool reparse_file_needs_reval(const struct cifs_fattr *fattr)
 static void
 cifs_fill_common_info(struct cifs_fattr *fattr, struct cifs_sb_info *cifs_sb)
 {
+	struct cifs_open_info_data data = {
+		.reparse = { .tag = fattr->cf_cifstag, },
+	};
+
 	fattr->cf_uid = cifs_sb->ctx->linux_uid;
 	fattr->cf_gid = cifs_sb->ctx->linux_gid;
 
@@ -165,7 +169,7 @@ cifs_fill_common_info(struct cifs_fattr *fattr, struct cifs_sb_info *cifs_sb)
 	 * reasonably map some of them to directories vs. files vs. symlinks
 	 */
 	if ((fattr->cf_cifsattrs & ATTR_REPARSE) &&
-	    cifs_reparse_point_to_fattr(cifs_sb, fattr, fattr->cf_cifstag))
+	    cifs_reparse_point_to_fattr(cifs_sb, fattr, &data))
 		goto out_reparse;
 
 	if (fattr->cf_cifsattrs & ATTR_DIRECTORY) {
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 0dd599004e04..64e25233e85d 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -1004,8 +1004,7 @@ static int cifs_parse_reparse_point(struct cifs_sb_info *cifs_sb,
 
 	buf = (struct reparse_data_buffer *)((__u8 *)&io->hdr.Protocol +
 					     le32_to_cpu(io->DataOffset));
-	return parse_reparse_point(buf, plen, cifs_sb, unicode,
-				   &data->symlink_target);
+	return parse_reparse_point(buf, plen, cifs_sb, unicode, data);
 }
 
 static bool
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 0b89f7008ac0..c94940af5d4b 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -555,7 +555,7 @@ static int parse_create_response(struct cifs_open_info_data *data,
 		break;
 	}
 	data->reparse_point = reparse_point;
-	data->reparse_tag = tag;
+	data->reparse.tag = tag;
 	return rc;
 }
 
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 2955eaa51d4d..f01a929a7a3a 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2866,89 +2866,95 @@ smb2_get_dfs_refer(const unsigned int xid, struct cifs_ses *ses,
 	return rc;
 }
 
-static int
-parse_reparse_posix(struct reparse_posix_data *symlink_buf,
-		      u32 plen, char **target_path,
-		      struct cifs_sb_info *cifs_sb)
+/* See MS-FSCC 2.1.2.6 for the 'NFS' style reparse tags */
+static int parse_reparse_posix(struct reparse_posix_data *buf,
+			       struct cifs_sb_info *cifs_sb,
+			       struct cifs_open_info_data *data)
 {
 	unsigned int len;
+	u64 type;
 
-	/* See MS-FSCC 2.1.2.6 for the 'NFS' style reparse tags */
-	len = le16_to_cpu(symlink_buf->ReparseDataLength);
-
-	if (le64_to_cpu(symlink_buf->InodeType) != NFS_SPECFILE_LNK) {
-		cifs_dbg(VFS, "%lld not a supported symlink type\n",
-			le64_to_cpu(symlink_buf->InodeType));
+	switch ((type = le64_to_cpu(buf->InodeType))) {
+	case NFS_SPECFILE_LNK:
+		len = le16_to_cpu(buf->ReparseDataLength);
+		data->symlink_target = cifs_strndup_from_utf16(buf->DataBuffer,
+							       len, true,
+							       cifs_sb->local_nls);
+		if (!data->symlink_target)
+			return -ENOMEM;
+		convert_delimiter(data->symlink_target, '/');
+		cifs_dbg(FYI, "%s: target path: %s\n",
+			 __func__, data->symlink_target);
+		break;
+	case NFS_SPECFILE_CHR:
+	case NFS_SPECFILE_BLK:
+	case NFS_SPECFILE_FIFO:
+	case NFS_SPECFILE_SOCK:
+		break;
+	default:
+		cifs_dbg(VFS, "%s: unhandled inode type: 0x%llx\n",
+			 __func__, type);
 		return -EOPNOTSUPP;
 	}
-
-	*target_path = cifs_strndup_from_utf16(
-				symlink_buf->PathBuffer,
-				len, true, cifs_sb->local_nls);
-	if (!(*target_path))
-		return -ENOMEM;
-
-	convert_delimiter(*target_path, '/');
-	cifs_dbg(FYI, "%s: target path: %s\n", __func__, *target_path);
-
 	return 0;
 }
 
 static int parse_reparse_symlink(struct reparse_symlink_data_buffer *sym,
-				 u32 plen, bool unicode, char **target_path,
-				 struct cifs_sb_info *cifs_sb)
+				 u32 plen, bool unicode,
+				 struct cifs_sb_info *cifs_sb,
+				 struct cifs_open_info_data *data)
 {
-	unsigned int sub_len;
-	unsigned int sub_offset;
+	unsigned int len;
+	unsigned int offs;
 
 	/* We handle Symbolic Link reparse tag here. See: MS-FSCC 2.1.2.4 */
 
-	sub_offset = le16_to_cpu(sym->SubstituteNameOffset);
-	sub_len = le16_to_cpu(sym->SubstituteNameLength);
-	if (sub_offset + 20 > plen ||
-	    sub_offset + sub_len + 20 > plen) {
+	offs = le16_to_cpu(sym->SubstituteNameOffset);
+	len = le16_to_cpu(sym->SubstituteNameLength);
+	if (offs + 20 > plen || offs + len + 20 > plen) {
 		cifs_dbg(VFS, "srv returned malformed symlink buffer\n");
 		return -EIO;
 	}
 
-	*target_path = cifs_strndup_from_utf16(sym->PathBuffer + sub_offset,
-					       sub_len, unicode,
-					       cifs_sb->local_nls);
-	if (!(*target_path))
+	data->symlink_target = cifs_strndup_from_utf16(sym->PathBuffer + offs,
+						       len, unicode,
+						       cifs_sb->local_nls);
+	if (!data->symlink_target)
 		return -ENOMEM;
 
-	convert_delimiter(*target_path, '/');
-	cifs_dbg(FYI, "%s: target path: %s\n", __func__, *target_path);
+	convert_delimiter(data->symlink_target, '/');
+	cifs_dbg(FYI, "%s: target path: %s\n", __func__, data->symlink_target);
 
 	return 0;
 }
 
 int parse_reparse_point(struct reparse_data_buffer *buf,
 			u32 plen, struct cifs_sb_info *cifs_sb,
-			bool unicode, char **target_path)
+			bool unicode, struct cifs_open_info_data *data)
 {
 	if (plen < sizeof(*buf)) {
-		cifs_dbg(VFS, "reparse buffer is too small. Must be at least 8 bytes but was %d\n",
-			 plen);
+		cifs_dbg(VFS, "%s: reparse buffer is too small. Must be at least 8 bytes but was %d\n",
+			 __func__, plen);
 		return -EIO;
 	}
 
 	if (plen < le16_to_cpu(buf->ReparseDataLength) + sizeof(*buf)) {
-		cifs_dbg(VFS, "srv returned invalid reparse buf length: %d\n",
-			 plen);
+		cifs_dbg(VFS, "%s: invalid reparse buf length: %d\n",
+			 __func__, plen);
 		return -EIO;
 	}
 
+	data->reparse.buf = buf;
+
 	/* See MS-FSCC 2.1.2 */
 	switch (le32_to_cpu(buf->ReparseTag)) {
 	case IO_REPARSE_TAG_NFS:
-		return parse_reparse_posix(
-			(struct reparse_posix_data *)buf,
-			plen, target_path, cifs_sb);
+		return parse_reparse_posix((struct reparse_posix_data *)buf,
+					   cifs_sb, data);
 	case IO_REPARSE_TAG_SYMLINK:
 		return parse_reparse_symlink(
 			(struct reparse_symlink_data_buffer *)buf,
-			plen, unicode, target_path, cifs_sb);
+			plen, unicode, cifs_sb, data);
 	case IO_REPARSE_TAG_LX_SYMLINK:
 	case IO_REPARSE_TAG_AF_UNIX:
 	case IO_REPARSE_TAG_LX_FIFO:
@@ -2956,8 +2962,8 @@ int parse_reparse_point(struct reparse_data_buffer *buf,
 	case IO_REPARSE_TAG_LX_BLK:
 		return 0;
 	default:
-		cifs_dbg(VFS, "srv returned unknown symlink buffer tag:0x%08x\n",
-			 le32_to_cpu(buf->ReparseTag));
+		cifs_dbg(VFS, "%s: unhandled reparse tag: 0x%08x\n",
+			 __func__, le32_to_cpu(buf->ReparseTag));
 		return -EOPNOTSUPP;
 	}
 }
@@ -2972,8 +2978,7 @@ static int smb2_parse_reparse_point(struct cifs_sb_info *cifs_sb,
 
 	buf = (struct reparse_data_buffer *)((u8 *)io +
 					     le32_to_cpu(io->OutputOffset));
-	return parse_reparse_point(buf, plen, cifs_sb,
-				   true, &data->symlink_target);
+	return parse_reparse_point(buf, plen, cifs_sb, true, data);
 }
 
 static int smb2_query_reparse_point(const unsigned int xid,
-- 
2.42.1


