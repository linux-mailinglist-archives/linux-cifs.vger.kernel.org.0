Return-Path: <linux-cifs+bounces-207-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 160917FC705
	for <lists+linux-cifs@lfdr.de>; Tue, 28 Nov 2023 22:08:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 392AE1C21287
	for <lists+linux-cifs@lfdr.de>; Tue, 28 Nov 2023 21:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C927640BF8;
	Tue, 28 Nov 2023 21:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mSYymles"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8B893527B;
	Tue, 28 Nov 2023 21:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D253C433C8;
	Tue, 28 Nov 2023 21:07:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701205658;
	bh=u7PzsmwPJaURQO1EHl2EHlLOT/jblLrMFyg9gZsyaCo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=mSYymles82xKrW4dAyedemN6990VuIjzo+Ms3+QEhL6PsZ6zn8eaez4aYMCT/+eTV
	 h2r2qpWFtIxzp1HMY6PEd1ovMsKQkjlrhlsuPr4KjTSTE+g3VmgxosWb9DxINjLq5Q
	 jlfNiArvqukzX0Ky4D91HtqURdRBCuhdHRvCxPwYXK0CvR0V3/3Q5LQuUgw1v3carJ
	 rw2Isgr8zOQ+Fn3jVPULhuOdUUFdsi6s69jjieBGNEeG5IgsP+OQMGWlrLwa0ysRbN
	 72HrWDfQRi5m6XKF/2/tC0O4iwpzFglb8pKjmSRihkNk9Jh0xINtwrNfkQTw3jPB7T
	 z5B9UIZY+fXbg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.6 39/40] smb: client: set correct file type from NFS reparse points
Date: Tue, 28 Nov 2023 16:05:45 -0500
Message-ID: <20231128210615.875085-39-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231128210615.875085-1-sashal@kernel.org>
References: <20231128210615.875085-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.3
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 45e724022e2704b5a5193fd96f378822b0448e07 ]

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
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h  |   8 ++-
 fs/smb/client/cifspdu.h   |   2 +-
 fs/smb/client/cifsproto.h |   4 +-
 fs/smb/client/inode.c     |  51 +++++++++++++++++--
 fs/smb/client/readdir.c   |   6 ++-
 fs/smb/client/smb1ops.c   |   3 +-
 fs/smb/client/smb2inode.c |   2 +-
 fs/smb/client/smb2ops.c   | 101 ++++++++++++++++++++------------------
 8 files changed, 116 insertions(+), 61 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 1f84e302122f6..1137c4d628b04 100644
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
index efaf22c42ed00..009555383f44f 100644
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
index a51b4308da9d7..ed6d1c5969b36 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -209,7 +209,7 @@ int cifs_get_inode_info(struct inode **inode, const char *full_path,
 			const struct cifs_fid *fid);
 bool cifs_reparse_point_to_fattr(struct cifs_sb_info *cifs_sb,
 				 struct cifs_fattr *fattr,
-				 u32 tag);
+				 struct cifs_open_info_data *data);
 extern int smb311_posix_get_inode_info(struct inode **pinode, const char *search_path,
 			struct super_block *sb, unsigned int xid);
 extern int cifs_get_inode_info_unix(struct inode **pinode,
@@ -664,7 +664,7 @@ char *extract_hostname(const char *unc);
 char *extract_sharename(const char *unc);
 int parse_reparse_point(struct reparse_data_buffer *buf,
 			u32 plen, struct cifs_sb_info *cifs_sb,
-			bool unicode, char **target_path);
+			bool unicode, struct cifs_open_info_data *data);
 
 #ifdef CONFIG_CIFS_DFS_UPCALL
 static inline int get_dfs_path(const unsigned int xid, struct cifs_ses *ses,
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index f67080e27d8e5..c4cd75a4ca014 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -715,10 +715,51 @@ static void smb311_posix_info_to_fattr(struct cifs_fattr *fattr,
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
@@ -784,7 +825,7 @@ static void cifs_open_info_to_fattr(struct cifs_fattr *fattr,
 	fattr->cf_nlink = le32_to_cpu(info->NumberOfLinks);
 
 	if (cifs_open_data_reparse(data) &&
-	    cifs_reparse_point_to_fattr(cifs_sb, fattr, data->reparse_tag))
+	    cifs_reparse_point_to_fattr(cifs_sb, fattr, data))
 		goto out_reparse;
 
 	if (fattr->cf_cifsattrs & ATTR_DIRECTORY) {
@@ -849,7 +890,7 @@ cifs_get_file_info(struct file *filp)
 		data.adjust_tz = false;
 		if (data.symlink_target) {
 			data.symlink = true;
-			data.reparse_tag = IO_REPARSE_TAG_SYMLINK;
+			data.reparse.tag = IO_REPARSE_TAG_SYMLINK;
 		}
 		cifs_open_info_to_fattr(&fattr, &data, inode->i_sb);
 		break;
@@ -1018,7 +1059,7 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct kvec rsp_iov, *iov = NULL;
 	int rsp_buftype = CIFS_NO_BUFFER;
-	u32 tag = data->reparse_tag;
+	u32 tag = data->reparse.tag;
 	int rc = 0;
 
 	if (!tag && server->ops->query_reparse_point) {
@@ -1030,7 +1071,7 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 	}
 
 	rc = -EOPNOTSUPP;
-	switch ((data->reparse_tag = tag)) {
+	switch ((data->reparse.tag = tag)) {
 	case 0: /* SMB1 symlink */
 		if (server->ops->query_symlink) {
 			rc = server->ops->query_symlink(xid, tcon,
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 47fc22de8d20c..d30ea2005eb36 100644
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
index 0dd599004e042..64e25233e85de 100644
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
index 0b89f7008ac0f..c94940af5d4b8 100644
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
index 33b20e43372d0..28566671f2a73 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2858,89 +2858,95 @@ smb2_get_dfs_refer(const unsigned int xid, struct cifs_ses *ses,
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
-
-	/* See MS-FSCC 2.1.2.6 for the 'NFS' style reparse tags */
-	len = le16_to_cpu(symlink_buf->ReparseDataLength);
-
-	if (le64_to_cpu(symlink_buf->InodeType) != NFS_SPECFILE_LNK) {
-		cifs_dbg(VFS, "%lld not a supported symlink type\n",
-			le64_to_cpu(symlink_buf->InodeType));
+	u64 type;
+
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
@@ -2948,8 +2954,8 @@ int parse_reparse_point(struct reparse_data_buffer *buf,
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
@@ -2964,8 +2970,7 @@ static int smb2_parse_reparse_point(struct cifs_sb_info *cifs_sb,
 
 	buf = (struct reparse_data_buffer *)((u8 *)io +
 					     le32_to_cpu(io->OutputOffset));
-	return parse_reparse_point(buf, plen, cifs_sb,
-				   true, &data->symlink_target);
+	return parse_reparse_point(buf, plen, cifs_sb, true, data);
 }
 
 static int smb2_query_reparse_point(const unsigned int xid,
-- 
2.42.0


