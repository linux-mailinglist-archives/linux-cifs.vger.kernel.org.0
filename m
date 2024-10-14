Return-Path: <linux-cifs+bounces-3123-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 67A6799BE7C
	for <lists+linux-cifs@lfdr.de>; Mon, 14 Oct 2024 06:00:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8910D1C221F3
	for <lists+linux-cifs@lfdr.de>; Mon, 14 Oct 2024 04:00:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 130F914D70E;
	Mon, 14 Oct 2024 03:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="grdwz/Kv"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD48B14D452;
	Mon, 14 Oct 2024 03:57:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728878270; cv=none; b=EN+xWogdG+dZOOcaCS/Q0Smt66LXTgrXWpO2SQFGWZDzaEdBiUO+PRGc3UEg76obCBEgNEQR5Vm6msWKR4+3IA4EZ/pY2D3apVdZMYoL6HPSV4F2V+VYM62Rw3xUdi2+YrtnOfq4P0pya9QfP/C4NOkaVBaJ7XVpqcwtjUmdHzc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728878270; c=relaxed/simple;
	bh=D6bXhsYIb7g30WKDjXfP2pXOOm1gcnpCt/6ktHs4L78=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=r7STTd5U7WqfcpINyPhsOkHZT89vCIcIzo/TSdtks99ZISuVCqwGdwbGR1wNJh/J8c9A/Jru4xEw4E9XcGLXikn7/RwPOBjc3T5wMFofccTkgNjuV0zYy5xkt0IY0fEIW699I7Gfy2SDLfmdvcvZ7acWxUot3DwA3pbVSZw7GB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=grdwz/Kv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B38DDC4CECE;
	Mon, 14 Oct 2024 03:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728878269;
	bh=D6bXhsYIb7g30WKDjXfP2pXOOm1gcnpCt/6ktHs4L78=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=grdwz/KvJW4jpjfqSIzt1N1OdbcmcqSBUkhC67BZ3zgpQNlPN646QWPueao6RB51m
	 0nxVYQUSKWlHwB3AWs2ST9B4/YS8iD3DH6AhNNAvk/9bnvsTc18R63GrMAafmjZKqT
	 aRnR8QiG1EATMdfHwnqNoAC9bhKtzJQxkaoVNFlRHlgURtppnCxMY79HJfFF7/b6SW
	 rjcK4SqWAz1ST9/9vs26jfFmwAVOpQqynYh01lHARU1orrn7ipYbspZpwCoquQYXZU
	 QXkZ+5hzkB/CgwgoTTZXJ5BhL013MeRY+Gmb40yeJCNwgCgaCJ54yxc8eXSkpURrjx
	 CbJPDBwSM8s1g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.11 12/20] cifs: Improve creating native symlinks pointing to directory
Date: Sun, 13 Oct 2024 23:57:14 -0400
Message-ID: <20241014035731.2246632-12-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241014035731.2246632-1-sashal@kernel.org>
References: <20241014035731.2246632-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.11.3
Content-Transfer-Encoding: 8bit

From: Pali Rohár <pali@kernel.org>

[ Upstream commit 3eb40512530e4f64f819d8e723b6f41695dace5a ]

SMB protocol for native symlinks distinguish between symlink to directory
and symlink to file. These two symlink types cannot be exchanged, which
means that symlink of file type pointing to directory cannot be resolved at
all (and vice-versa).

Windows follows this rule for local filesystems (NTFS) and also for SMB.

Linux SMB client currenly creates all native symlinks of file type. Which
means that Windows (and some other SMB clients) cannot resolve symlinks
pointing to directory created by Linux SMB client.

As Linux system does not distinguish between directory and file symlinks,
its API does not provide enough information for Linux SMB client during
creating of native symlinks.

Add some heuristic into the Linux SMB client for choosing the correct
symlink type during symlink creation. Check if the symlink target location
ends with slash, or last path component is dot or dot-dot, and check if the
target location on SMB share exists and is a directory. If at least one
condition is truth then create a new SMB symlink of directory type.
Otherwise create it as file type symlink.

This change improves interoperability with Windows systems. Windows systems
would be able to resolve more SMB symlinks created by Linux SMB client
which points to existing directory.

Signed-off-by: Pali Rohár <pali@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/reparse.c   | 164 +++++++++++++++++++++++++++++++++++++-
 fs/smb/client/smb2inode.c |   3 +-
 fs/smb/client/smb2proto.h |   1 +
 3 files changed, 164 insertions(+), 4 deletions(-)

diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
index ad0e0de9a165d..b15b0ac302ef6 100644
--- a/fs/smb/client/reparse.c
+++ b/fs/smb/client/reparse.c
@@ -14,6 +14,12 @@
 #include "fs_context.h"
 #include "reparse.h"
 
+static int detect_directory_symlink_target(struct cifs_sb_info *cifs_sb,
+					   const unsigned int xid,
+					   const char *full_path,
+					   const char *symname,
+					   bool *directory);
+
 int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
 				struct dentry *dentry, struct cifs_tcon *tcon,
 				const char *full_path, const char *symname)
@@ -24,6 +30,7 @@ int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
 	struct inode *new;
 	struct kvec iov;
 	__le16 *path;
+	bool directory;
 	char *sym, sep = CIFS_DIR_SEP(cifs_sb);
 	u16 len, plen;
 	int rc = 0;
@@ -45,6 +52,18 @@ int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
 		goto out;
 	}
 
+	/*
+	 * SMB distinguish between symlink to directory and symlink to file.
+	 * They cannot be exchanged (symlink of file type which points to
+	 * directory cannot be resolved and vice-versa). Try to detect if
+	 * the symlink target could be a directory or not. When detection
+	 * fails then treat symlink as a file (non-directory) symlink.
+	 */
+	directory = false;
+	rc = detect_directory_symlink_target(cifs_sb, xid, full_path, symname, &directory);
+	if (rc < 0)
+		goto out;
+
 	plen = 2 * UniStrnlen((wchar_t *)path, PATH_MAX);
 	len = sizeof(*buf) + plen * 2;
 	buf = kzalloc(len, GFP_KERNEL);
@@ -69,7 +88,8 @@ int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
 	iov.iov_base = buf;
 	iov.iov_len = len;
 	new = smb2_get_reparse_inode(&data, inode->i_sb, xid,
-				     tcon, full_path, &iov, NULL);
+				     tcon, full_path, directory,
+				     &iov, NULL);
 	if (!IS_ERR(new))
 		d_instantiate(dentry, new);
 	else
@@ -81,6 +101,144 @@ int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
 	return rc;
 }
 
+static int detect_directory_symlink_target(struct cifs_sb_info *cifs_sb,
+					   const unsigned int xid,
+					   const char *full_path,
+					   const char *symname,
+					   bool *directory)
+{
+	char sep = CIFS_DIR_SEP(cifs_sb);
+	struct cifs_open_parms oparms;
+	struct tcon_link *tlink;
+	struct cifs_tcon *tcon;
+	const char *basename;
+	struct cifs_fid fid;
+	char *resolved_path;
+	int full_path_len;
+	int basename_len;
+	int symname_len;
+	char *path_sep;
+	__u32 oplock;
+	int open_rc;
+
+	/*
+	 * First do some simple check. If the original Linux symlink target ends
+	 * with slash, or last path component is dot or dot-dot then it is for
+	 * sure symlink to the directory.
+	 */
+	basename = kbasename(symname);
+	basename_len = strlen(basename);
+	if (basename_len == 0 || /* symname ends with slash */
+	    (basename_len == 1 && basename[0] == '.') || /* last component is "." */
+	    (basename_len == 2 && basename[0] == '.' && basename[1] == '.')) { /* or ".." */
+		*directory = true;
+		return 0;
+	}
+
+	/*
+	 * For absolute symlinks it is not possible to determinate
+	 * if it should point to directory or file.
+	 */
+	if (symname[0] == '/') {
+		cifs_dbg(FYI,
+			 "%s: cannot determinate if the symlink target path '%s' "
+			 "is directory or not, creating '%s' as file symlink\n",
+			 __func__, symname, full_path);
+		return 0;
+	}
+
+	/*
+	 * If it was not detected as directory yet and the symlink is relative
+	 * then try to resolve the path on the SMB server, check if the path
+	 * exists and determinate if it is a directory or not.
+	 */
+
+	full_path_len = strlen(full_path);
+	symname_len = strlen(symname);
+
+	tlink = cifs_sb_tlink(cifs_sb);
+	if (IS_ERR(tlink))
+		return PTR_ERR(tlink);
+
+	resolved_path = kzalloc(full_path_len + symname_len + 1, GFP_KERNEL);
+	if (!resolved_path) {
+		cifs_put_tlink(tlink);
+		return -ENOMEM;
+	}
+
+	/*
+	 * Compose the resolved SMB symlink path from the SMB full path
+	 * and Linux target symlink path.
+	 */
+	memcpy(resolved_path, full_path, full_path_len+1);
+	path_sep = strrchr(resolved_path, sep);
+	if (path_sep)
+		path_sep++;
+	else
+		path_sep = resolved_path;
+	memcpy(path_sep, symname, symname_len+1);
+	if (sep == '\\')
+		convert_delimiter(path_sep, sep);
+
+	tcon = tlink_tcon(tlink);
+	oparms = CIFS_OPARMS(cifs_sb, tcon, resolved_path,
+			     FILE_READ_ATTRIBUTES, FILE_OPEN, 0, ACL_NO_MODE);
+	oparms.fid = &fid;
+
+	/* Try to open as a directory (NOT_FILE) */
+	oplock = 0;
+	oparms.create_options = cifs_create_options(cifs_sb,
+						    CREATE_NOT_FILE | OPEN_REPARSE_POINT);
+	open_rc = tcon->ses->server->ops->open(xid, &oparms, &oplock, NULL);
+	if (open_rc == 0) {
+		/* Successful open means that the target path is definitely a directory. */
+		*directory = true;
+		tcon->ses->server->ops->close(xid, tcon, &fid);
+	} else if (open_rc == -ENOTDIR) {
+		/* -ENOTDIR means that the target path is definitely a file. */
+		*directory = false;
+	} else if (open_rc == -ENOENT) {
+		/* -ENOENT means that the target path does not exist. */
+		cifs_dbg(FYI,
+			 "%s: symlink target path '%s' does not exist, "
+			 "creating '%s' as file symlink\n",
+			 __func__, symname, full_path);
+	} else {
+		/* Try to open as a file (NOT_DIR) */
+		oplock = 0;
+		oparms.create_options = cifs_create_options(cifs_sb,
+							    CREATE_NOT_DIR | OPEN_REPARSE_POINT);
+		open_rc = tcon->ses->server->ops->open(xid, &oparms, &oplock, NULL);
+		if (open_rc == 0) {
+			/* Successful open means that the target path is definitely a file. */
+			*directory = false;
+			tcon->ses->server->ops->close(xid, tcon, &fid);
+		} else if (open_rc == -EISDIR) {
+			/* -EISDIR means that the target path is definitely a directory. */
+			*directory = true;
+		} else {
+			/*
+			 * This code branch is called when we do not have a permission to
+			 * open the resolved_path or some other client/process denied
+			 * opening the resolved_path.
+			 *
+			 * TODO: Try to use ops->query_dir_first on the parent directory
+			 * of resolved_path, search for basename of resolved_path and
+			 * check if the ATTR_DIRECTORY is set in fi.Attributes. In some
+			 * case this could work also when opening of the path is denied.
+			 */
+			cifs_dbg(FYI,
+				 "%s: cannot determinate if the symlink target path '%s' "
+				 "is directory or not, creating '%s' as file symlink\n",
+				 __func__, symname, full_path);
+		}
+	}
+
+	kfree(resolved_path);
+	cifs_put_tlink(tlink);
+	return 0;
+}
+
 static int nfs_set_reparse_buf(struct reparse_posix_data *buf,
 			       mode_t mode, dev_t dev,
 			       struct kvec *iov)
@@ -137,7 +295,7 @@ static int mknod_nfs(unsigned int xid, struct inode *inode,
 	};
 
 	new = smb2_get_reparse_inode(&data, inode->i_sb, xid,
-				     tcon, full_path, &iov, NULL);
+				     tcon, full_path, false, &iov, NULL);
 	if (!IS_ERR(new))
 		d_instantiate(dentry, new);
 	else
@@ -283,7 +441,7 @@ static int mknod_wsl(unsigned int xid, struct inode *inode,
 	data.wsl.eas_len = len;
 
 	new = smb2_get_reparse_inode(&data, inode->i_sb,
-				     xid, tcon, full_path,
+				     xid, tcon, full_path, false,
 				     &reparse_iov, &xattr_iov);
 	if (!IS_ERR(new))
 		d_instantiate(dentry, new);
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index a6dab60e2c01e..cdb0e028e73c4 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -1198,6 +1198,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 				     const unsigned int xid,
 				     struct cifs_tcon *tcon,
 				     const char *full_path,
+				     bool directory,
 				     struct kvec *reparse_iov,
 				     struct kvec *xattr_iov)
 {
@@ -1217,7 +1218,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 			     FILE_READ_ATTRIBUTES |
 			     FILE_WRITE_ATTRIBUTES,
 			     FILE_CREATE,
-			     CREATE_NOT_DIR | OPEN_REPARSE_POINT,
+			     (directory ? CREATE_NOT_FILE : CREATE_NOT_DIR) | OPEN_REPARSE_POINT,
 			     ACL_NO_MODE);
 	if (xattr_iov)
 		oparms.ea_cctx = xattr_iov;
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index b208232b12a24..5e0855fefcfe6 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -61,6 +61,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 				     const unsigned int xid,
 				     struct cifs_tcon *tcon,
 				     const char *full_path,
+				     bool directory,
 				     struct kvec *reparse_iov,
 				     struct kvec *xattr_iov);
 int smb2_query_reparse_point(const unsigned int xid,
-- 
2.43.0


