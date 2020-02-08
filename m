Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2ACE21564D9
	for <lists+linux-cifs@lfdr.de>; Sat,  8 Feb 2020 15:51:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727335AbgBHOvW (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 8 Feb 2020 09:51:22 -0500
Received: from mx2.suse.de ([195.135.220.15]:39622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727383AbgBHOvW (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sat, 8 Feb 2020 09:51:22 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 43382AC2C;
        Sat,  8 Feb 2020 14:51:17 +0000 (UTC)
From:   Aurelien Aptel <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH 3/3] cifs: plumb smb2 POSIX dir enumeration
Date:   Sat,  8 Feb 2020 15:50:58 +0100
Message-Id: <20200208145058.10429-3-aaptel@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200208145058.10429-1-aaptel@suse.com>
References: <20200208145058.10429-1-aaptel@suse.com>
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

* add code to request POSIX info level
* parse dir entries and fill cifs_fattr to get correct inode data

since the POSIX payload is variable size the number of entries in a
FIND response needs to be computed differently.

Dirs and regular files are properly reported along with mode bits,
hardlink number, c/m/atime. No special files yet (see below).

Current experimental version of Samba with the extension unfortunately
has issues with wildcards and needs the following patch:

> --- i/source3/smbd/smb2_query_directory.c
> +++ w/source3/smbd/smb2_query_directory.c
> @@ -397,9 +397,7 @@ smbd_smb2_query_directory_send(TALLOC_CTX
> *mem_ctx,
> 		}
> 	}
>
> -       if (!state->smbreq->posix_pathnames) {
> 		wcard_has_wild = ms_has_wild(state->in_file_name);
> -       }
>
> 	/* Ensure we've canonicalized any search path if not a wildcard. */
> 	if (!wcard_has_wild) {
>

Also for special files despite reporting them as reparse point samba
doesnt set the reparse tag field. This patch will mark them as needing
re-evaluation but the re-evaluate code doesn't deal with it yet.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 fs/cifs/readdir.c | 82 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
 fs/cifs/smb2pdu.c | 34 ++++++++++++++++++-----
 2 files changed, 109 insertions(+), 7 deletions(-)

diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index ba9dadf3be24..753ca064e2b3 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -32,6 +32,7 @@
 #include "cifs_debug.h"
 #include "cifs_fs_sb.h"
 #include "cifsfs.h"
+#include "smb2proto.h"
 
 /*
  * To be safe - for UCS to UTF-8 with strings loaded with the rare long
@@ -217,6 +218,60 @@ cifs_fill_common_info(struct cifs_fattr *fattr, struct cifs_sb_info *cifs_sb)
 	}
 }
 
+/* Fill a cifs_fattr struct with info from SMB_FIND_FILE_POSIX_INFO. */
+static void
+cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
+		    struct cifs_sb_info *cifs_sb)
+{
+	struct smb2_posix_info_parsed parsed;
+
+	posix_info_parse(info, NULL, &parsed);
+
+	memset(fattr, 0, sizeof(*fattr));
+	fattr->cf_uniqueid = le64_to_cpu(info->Inode);
+	fattr->cf_bytes = le64_to_cpu(info->AllocationSize);
+	fattr->cf_eof = le64_to_cpu(info->EndOfFile);
+
+	fattr->cf_atime = cifs_NTtimeToUnix(info->LastAccessTime);
+	fattr->cf_mtime = cifs_NTtimeToUnix(info->LastWriteTime);
+	fattr->cf_ctime = cifs_NTtimeToUnix(info->CreationTime);
+
+	fattr->cf_nlink = le64_to_cpu(info->HardLinks);
+	fattr->cf_cifsattrs = le32_to_cpu(info->DosAttributes);
+
+	/*
+	 * Since we set the inode type below we need to mask off
+	 * to avoid strange results if bits set above.
+	 * XXX: why not make server&client use the type bits?
+	 */
+	fattr->cf_mode = le32_to_cpu(info->Mode) & ~S_IFMT;
+
+	cifs_dbg(VFS, "XXX dev %d, reparse %d, mode %o",
+		 le32_to_cpu(info->DeviceId),
+		 le32_to_cpu(info->ReparseTag),
+		 le32_to_cpu(info->Mode));
+
+	if (fattr->cf_cifsattrs & ATTR_DIRECTORY) {
+		fattr->cf_mode |= S_IFDIR;
+		fattr->cf_dtype = DT_DIR;
+	} else {
+		/*
+		 * mark anything that is not a dir as regular
+		 * file. special files should have the REPARSE
+		 * attribute and will be marked as needing revaluation
+		 */
+		fattr->cf_mode |= S_IFREG;
+		fattr->cf_dtype = DT_REG;
+	}
+
+	if (reparse_file_needs_reval(fattr))
+		fattr->cf_flags |= CIFS_FATTR_NEED_REVAL;
+
+	/* TODO map SIDs */
+	fattr->cf_uid = cifs_sb->mnt_uid;
+	fattr->cf_gid = cifs_sb->mnt_gid;
+}
+
 static void __dir_info_to_fattr(struct cifs_fattr *fattr, const void *info)
 {
 	const FILE_DIRECTORY_INFO *fi = info;
@@ -359,6 +414,8 @@ initiate_cifs_search(const unsigned int xid, struct file *file)
 	/* if (cap_unix(tcon->ses) { */
 	if (tcon->unix_ext)
 		cifsFile->srch_inf.info_level = SMB_FIND_FILE_UNIX;
+	else if (tcon->posix_extensions)
+		cifsFile->srch_inf.info_level = SMB_FIND_FILE_POSIX_INFO;
 	else if ((tcon->ses->capabilities &
 		  tcon->ses->server->vals->cap_nt_find) == 0) {
 		cifsFile->srch_inf.info_level = SMB_FIND_FILE_INFO_STANDARD;
@@ -451,6 +508,23 @@ struct cifs_dirent {
 	u64		ino;
 };
 
+static void cifs_fill_dirent_posix(struct cifs_dirent *de,
+				   const struct smb2_posix_info *info)
+{
+	struct smb2_posix_info_parsed parsed;
+
+	/* payload should have already been checked at this point */
+	if (posix_info_parse(info, NULL, &parsed) < 0) {
+		cifs_dbg(VFS, "invalid POSIX info payload");
+		return;
+	}
+
+	de->name = parsed.name;
+	de->namelen = parsed.name_len;
+	de->resume_key = info->Ignored;
+	de->ino = le64_to_cpu(info->Inode);
+}
+
 static void cifs_fill_dirent_unix(struct cifs_dirent *de,
 		const FILE_UNIX_INFO *info, bool is_unicode)
 {
@@ -511,6 +585,9 @@ static int cifs_fill_dirent(struct cifs_dirent *de, const void *info,
 	memset(de, 0, sizeof(*de));
 
 	switch (level) {
+	case SMB_FIND_FILE_POSIX_INFO:
+		cifs_fill_dirent_posix(de, info);
+		break;
 	case SMB_FIND_FILE_UNIX:
 		cifs_fill_dirent_unix(de, info, is_unicode);
 		break;
@@ -786,6 +863,11 @@ static int cifs_filldir(char *find_entry, struct file *file,
 	}
 
 	switch (file_info->srch_inf.info_level) {
+	case SMB_FIND_FILE_POSIX_INFO:
+		cifs_posix_to_fattr(&fattr,
+				    (struct smb2_posix_info *)find_entry,
+				    cifs_sb);
+		break;
 	case SMB_FIND_FILE_UNIX:
 		cifs_unix_basic_to_fattr(&fattr,
 					 &((FILE_UNIX_INFO *)find_entry)->basic,
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 174ae2ef6310..abc0a0512181 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -4386,7 +4386,8 @@ static int posix_info_extra_size(const void *beg, const void *end)
 }
 
 static unsigned int
-num_entries(char *bufstart, char *end_of_buf, char **lastentry, size_t size)
+num_entries(int infotype, char *bufstart, char *end_of_buf, char **lastentry,
+	    size_t size)
 {
 	int len;
 	unsigned int entrycount = 0;
@@ -4410,8 +4411,13 @@ num_entries(char *bufstart, char *end_of_buf, char **lastentry, size_t size)
 		entryptr = entryptr + next_offset;
 		dir_info = (FILE_DIRECTORY_INFO *)entryptr;
 
-		len = le32_to_cpu(dir_info->FileNameLength);
-		if (entryptr + len < entryptr ||
+		if (infotype == SMB_FIND_FILE_POSIX_INFO)
+			len = posix_info_extra_size(entryptr, end_of_buf);
+		else
+			len = le32_to_cpu(dir_info->FileNameLength);
+
+		if (len < 0 ||
+		    entryptr + len < entryptr ||
 		    entryptr + len > end_of_buf ||
 		    entryptr + len + size > end_of_buf) {
 			cifs_dbg(VFS, "directory entry name would overflow frame end of buf %p\n",
@@ -4461,6 +4467,9 @@ int SMB2_query_directory_init(const unsigned int xid,
 	case SMB_FIND_FILE_ID_FULL_DIR_INFO:
 		req->FileInformationClass = FILEID_FULL_DIRECTORY_INFORMATION;
 		break;
+	case SMB_FIND_FILE_POSIX_INFO:
+		req->FileInformationClass = SMB_FIND_FILE_POSIX_INFO;
+		break;
 	default:
 		cifs_tcon_dbg(VFS, "info level %u isn't supported\n",
 			info_level);
@@ -4526,6 +4535,10 @@ smb2_parse_query_directory(struct cifs_tcon *tcon,
 	case SMB_FIND_FILE_ID_FULL_DIR_INFO:
 		info_buf_size = sizeof(SEARCH_ID_FULL_DIR_INFO) - 1;
 		break;
+	case SMB_FIND_FILE_POSIX_INFO:
+		/* note that posix payload are variable size */
+		info_buf_size = sizeof(struct smb2_posix_info);
+		break;
 	default:
 		cifs_tcon_dbg(VFS, "info level %u isn't supported\n",
 			 srch_inf->info_level);
@@ -4535,8 +4548,10 @@ smb2_parse_query_directory(struct cifs_tcon *tcon,
 	rc = smb2_validate_iov(le16_to_cpu(rsp->OutputBufferOffset),
 			       le32_to_cpu(rsp->OutputBufferLength), rsp_iov,
 			       info_buf_size);
-	if (rc)
+	if (rc) {
+		cifs_tcon_dbg(VFS, "bad info payload");
 		return rc;
+	}
 
 	srch_inf->unicode = true;
 
@@ -4550,9 +4565,14 @@ smb2_parse_query_directory(struct cifs_tcon *tcon,
 	srch_inf->srch_entries_start = srch_inf->last_entry =
 		(char *)rsp + le16_to_cpu(rsp->OutputBufferOffset);
 	end_of_smb = rsp_iov->iov_len + (char *)rsp;
-	srch_inf->entries_in_buffer =
-			num_entries(srch_inf->srch_entries_start, end_of_smb,
-				    &srch_inf->last_entry, info_buf_size);
+
+	srch_inf->entries_in_buffer = num_entries(
+		srch_inf->info_level,
+		srch_inf->srch_entries_start,
+		end_of_smb,
+		&srch_inf->last_entry,
+		info_buf_size);
+
 	srch_inf->index_of_last_entry += srch_inf->entries_in_buffer;
 	cifs_dbg(FYI, "num entries %d last_index %lld srch start %p srch end %p\n",
 		 srch_inf->entries_in_buffer, srch_inf->index_of_last_entry,
-- 
2.16.4

