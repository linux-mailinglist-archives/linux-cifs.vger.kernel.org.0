Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CF9D2402517
	for <lists+linux-cifs@lfdr.de>; Tue,  7 Sep 2021 10:25:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242568AbhIGI0v (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 7 Sep 2021 04:26:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:39030 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242608AbhIGI0v (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 7 Sep 2021 04:26:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631003145;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ys3c6X+TtDlCGH8+TwHDvNB2LEnc0qZsLvXIT8kosh4=;
        b=bxJHZPCsO7fuCDQdMEyQKZz+KJsXTyqTJF++uuSyj0nMRmLnAqsPBc/5jrLLDnbSx+u3vf
        RJvun0ISQhzbc6eX/wxp3+LASIOhonhduKSyqq+ETorErbgQHnuuCbpWcLy5qXCr0YXTyk
        +xEPwli+6mIuO7EfN2oTWDP2bKOcnYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-149-G0vWZNWfPU6G34hVgTx0tg-1; Tue, 07 Sep 2021 04:25:41 -0400
X-MC-Unique: G0vWZNWfPU6G34hVgTx0tg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C53FD1006C92;
        Tue,  7 Sep 2021 08:25:40 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-114.bne.redhat.com [10.64.54.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8645A19724;
        Tue,  7 Sep 2021 08:25:39 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: [PATCH 4/4] ksmbd: Use the SMB3_Create definitions from the shared area
Date:   Tue,  7 Sep 2021 18:25:23 +1000
Message-Id: <20210907082523.2087981-4-lsahlber@redhat.com>
In-Reply-To: <20210907082523.2087981-1-lsahlber@redhat.com>
References: <20210907082523.2087981-1-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/ksmbd/smb2pdu.c    |  68 +++++++++----------
 fs/ksmbd/smb2pdu.h    | 153 +-----------------------------------------
 fs/ksmbd/smb_common.h |  37 ----------
 fs/ksmbd/vfs.c        |   8 +--
 fs/ksmbd/vfs.h        |  43 ------------
 5 files changed, 37 insertions(+), 272 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index cb4aa64b2098..2572bd7fe9f5 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -733,17 +733,17 @@ static int smb2_get_dos_mode(struct kstat *stat, int attribute)
 	int attr = 0;
 
 	if (S_ISDIR(stat->mode)) {
-		attr = ATTR_DIRECTORY |
-			(attribute & (ATTR_HIDDEN | ATTR_SYSTEM));
+		attr = FILE_ATTRIBUTE_DIRECTORY |
+			(attribute & (FILE_ATTRIBUTE_HIDDEN | FILE_ATTRIBUTE_SYSTEM));
 	} else {
-		attr = (attribute & 0x00005137) | ATTR_ARCHIVE;
-		attr &= ~(ATTR_DIRECTORY);
+		attr = (attribute & 0x00005137) | FILE_ATTRIBUTE_ARCHIVE;
+		attr &= ~(FILE_ATTRIBUTE_DIRECTORY);
 		if (S_ISREG(stat->mode) && (server_conf.share_fake_fscaps &
 				FILE_SUPPORTS_SPARSE_FILES))
-			attr |= ATTR_SPARSE;
+			attr |= FILE_ATTRIBUTE_SPARSE_FILE;
 
 		if (smb2_get_reparse_tag_special_file(stat->mode))
-			attr |= ATTR_REPARSE;
+			attr |= FILE_ATTRIBUTE_REPARSE_POINT;
 	}
 
 	return attr;
@@ -2060,7 +2060,7 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
 	rsp->hdr.Status = STATUS_SUCCESS;
 	rsp->StructureSize = cpu_to_le16(89);
 	rsp->OplockLevel = SMB2_OPLOCK_LEVEL_NONE;
-	rsp->Reserved = 0;
+	rsp->Flags = 0;
 	rsp->CreateAction = cpu_to_le32(FILE_OPENED);
 
 	rsp->CreationTime = cpu_to_le64(0);
@@ -2068,7 +2068,7 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
 	rsp->ChangeTime = cpu_to_le64(0);
 	rsp->AllocationSize = cpu_to_le64(0);
 	rsp->EndofFile = cpu_to_le64(0);
-	rsp->FileAttributes = ATTR_NORMAL_LE;
+	rsp->FileAttributes = FILE_ATTRIBUTE_NORMAL_LE;
 	rsp->Reserved2 = 0;
 	rsp->VolatileFileId = cpu_to_le64(id);
 	rsp->PersistentFileId = 0;
@@ -2302,7 +2302,7 @@ static void smb2_update_xattrs(struct ksmbd_tree_connect *tcon,
 	struct xattr_dos_attrib da;
 	int rc;
 
-	fp->f_ci->m_fattr &= ~(ATTR_HIDDEN_LE | ATTR_SYSTEM_LE);
+	fp->f_ci->m_fattr &= ~(FILE_ATTRIBUTE_HIDDEN_LE | FILE_ATTRIBUTE_SYSTEM_LE);
 
 	/* get FileAttributes from XATTR_NAME_DOS_ATTRIBUTE */
 	if (!test_share_config_flag(tcon->share_conf,
@@ -2507,7 +2507,7 @@ int smb2_open(struct ksmbd_work *work)
 	if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE)
 		lc = parse_lease_state(req);
 
-	if (le32_to_cpu(req->ImpersonationLevel) > le32_to_cpu(IL_DELEGATE_LE)) {
+	if (le32_to_cpu(req->ImpersonationLevel) > le32_to_cpu(IL_DELEGATE)) {
 		pr_err("Invalid impersonationlevel : 0x%x\n",
 		       le32_to_cpu(req->ImpersonationLevel));
 		rc = -EIO;
@@ -2515,7 +2515,7 @@ int smb2_open(struct ksmbd_work *work)
 		goto err_out1;
 	}
 
-	if (req->CreateOptions && !(req->CreateOptions & CREATE_OPTIONS_MASK)) {
+	if (req->CreateOptions && !(req->CreateOptions & CREATE_OPTIONS_MASK_LE)) {
 		pr_err("Invalid create options : 0x%x\n",
 		       le32_to_cpu(req->CreateOptions));
 		rc = -EINVAL;
@@ -2525,9 +2525,7 @@ int smb2_open(struct ksmbd_work *work)
 		    req->CreateOptions & FILE_RANDOM_ACCESS_LE)
 			req->CreateOptions = ~(FILE_SEQUENTIAL_ONLY_LE);
 
-		if (req->CreateOptions &
-		    (FILE_OPEN_BY_FILE_ID_LE | CREATE_TREE_CONNECTION |
-		     FILE_RESERVE_OPFILTER_LE)) {
+		if (req->CreateOptions & FILE_OPEN_BY_FILE_ID_LE) {
 			rc = -EOPNOTSUPP;
 			goto err_out1;
 		}
@@ -2557,7 +2555,7 @@ int smb2_open(struct ksmbd_work *work)
 		goto err_out1;
 	}
 
-	if (req->FileAttributes && !(req->FileAttributes & ATTR_MASK_LE)) {
+	if (req->FileAttributes && !(req->FileAttributes & FILE_ATTRIBUTE_MASK_LE)) {
 		pr_err("Invalid file attribute : 0x%x\n",
 		       le32_to_cpu(req->FileAttributes));
 		rc = -EINVAL;
@@ -2698,7 +2696,7 @@ int smb2_open(struct ksmbd_work *work)
 		}
 
 		if (req->CreateOptions & FILE_DIRECTORY_FILE_LE &&
-		    req->FileAttributes & ATTR_NORMAL_LE) {
+		    req->FileAttributes & FILE_ATTRIBUTE_NORMAL_LE) {
 			rsp->hdr.Status = STATUS_NOT_A_DIRECTORY;
 			rc = -EIO;
 		}
@@ -3062,7 +3060,7 @@ int smb2_open(struct ksmbd_work *work)
 	opinfo = rcu_dereference(fp->f_opinfo);
 	rsp->OplockLevel = opinfo != NULL ? opinfo->level : 0;
 	rcu_read_unlock();
-	rsp->Reserved = 0;
+	rsp->Flags = 0;
 	rsp->CreateAction = cpu_to_le32(file_info);
 	rsp->CreationTime = cpu_to_le64(fp->create_time);
 	time = ksmbd_UnixTimeToNT(stat.atime);
@@ -3369,9 +3367,9 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 		ffdinfo->EaSize =
 			smb2_get_reparse_tag_special_file(ksmbd_kstat->kstat->mode);
 		if (ffdinfo->EaSize)
-			ffdinfo->ExtFileAttributes = ATTR_REPARSE_POINT_LE;
+			ffdinfo->ExtFileAttributes = FILE_ATTRIBUTE_REPARSE_POINT_LE;
 		if (d_info->hide_dot_file && d_info->name[0] == '.')
-			ffdinfo->ExtFileAttributes |= ATTR_HIDDEN_LE;
+			ffdinfo->ExtFileAttributes |= FILE_ATTRIBUTE_HIDDEN_LE;
 		memcpy(ffdinfo->FileName, conv_name, conv_len);
 		ffdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
 		break;
@@ -3385,11 +3383,11 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 		fbdinfo->EaSize =
 			smb2_get_reparse_tag_special_file(ksmbd_kstat->kstat->mode);
 		if (fbdinfo->EaSize)
-			fbdinfo->ExtFileAttributes = ATTR_REPARSE_POINT_LE;
+			fbdinfo->ExtFileAttributes = FILE_ATTRIBUTE_REPARSE_POINT_LE;
 		fbdinfo->ShortNameLength = 0;
 		fbdinfo->Reserved = 0;
 		if (d_info->hide_dot_file && d_info->name[0] == '.')
-			fbdinfo->ExtFileAttributes |= ATTR_HIDDEN_LE;
+			fbdinfo->ExtFileAttributes |= FILE_ATTRIBUTE_HIDDEN_LE;
 		memcpy(fbdinfo->FileName, conv_name, conv_len);
 		fbdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
 		break;
@@ -3401,7 +3399,7 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 		fdinfo = (struct file_directory_info *)kstat;
 		fdinfo->FileNameLength = cpu_to_le32(conv_len);
 		if (d_info->hide_dot_file && d_info->name[0] == '.')
-			fdinfo->ExtFileAttributes |= ATTR_HIDDEN_LE;
+			fdinfo->ExtFileAttributes |= FILE_ATTRIBUTE_HIDDEN_LE;
 		memcpy(fdinfo->FileName, conv_name, conv_len);
 		fdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
 		break;
@@ -3425,11 +3423,11 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 		dinfo->EaSize =
 			smb2_get_reparse_tag_special_file(ksmbd_kstat->kstat->mode);
 		if (dinfo->EaSize)
-			dinfo->ExtFileAttributes = ATTR_REPARSE_POINT_LE;
+			dinfo->ExtFileAttributes = FILE_ATTRIBUTE_REPARSE_POINT_LE;
 		dinfo->Reserved = 0;
 		dinfo->UniqueId = cpu_to_le64(ksmbd_kstat->kstat->ino);
 		if (d_info->hide_dot_file && d_info->name[0] == '.')
-			dinfo->ExtFileAttributes |= ATTR_HIDDEN_LE;
+			dinfo->ExtFileAttributes |= FILE_ATTRIBUTE_HIDDEN_LE;
 		memcpy(dinfo->FileName, conv_name, conv_len);
 		dinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
 		break;
@@ -3443,13 +3441,13 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 		fibdinfo->EaSize =
 			smb2_get_reparse_tag_special_file(ksmbd_kstat->kstat->mode);
 		if (fibdinfo->EaSize)
-			fibdinfo->ExtFileAttributes = ATTR_REPARSE_POINT_LE;
+			fibdinfo->ExtFileAttributes = FILE_ATTRIBUTE_REPARSE_POINT_LE;
 		fibdinfo->UniqueId = cpu_to_le64(ksmbd_kstat->kstat->ino);
 		fibdinfo->ShortNameLength = 0;
 		fibdinfo->Reserved = 0;
 		fibdinfo->Reserved2 = cpu_to_le16(0);
 		if (d_info->hide_dot_file && d_info->name[0] == '.')
-			fibdinfo->ExtFileAttributes |= ATTR_HIDDEN_LE;
+			fibdinfo->ExtFileAttributes |= FILE_ATTRIBUTE_HIDDEN_LE;
 		memcpy(fibdinfo->FileName, conv_name, conv_len);
 		fibdinfo->NextEntryOffset = cpu_to_le32(next_entry_offset);
 		break;
@@ -3475,9 +3473,9 @@ static int smb2_populate_readdir_entry(struct ksmbd_conn *conn, int info_level,
 		posix_info->Mode = cpu_to_le32(ksmbd_kstat->kstat->mode);
 		posix_info->Inode = cpu_to_le64(ksmbd_kstat->kstat->ino);
 		posix_info->DosAttributes =
-			S_ISDIR(ksmbd_kstat->kstat->mode) ? ATTR_DIRECTORY_LE : ATTR_ARCHIVE_LE;
+			S_ISDIR(ksmbd_kstat->kstat->mode) ? FILE_ATTRIBUTE_DIRECTORY_LE : FILE_ATTRIBUTE_ARCHIVE_LE;
 		if (d_info->hide_dot_file && d_info->name[0] == '.')
-			posix_info->DosAttributes |= ATTR_HIDDEN_LE;
+			posix_info->DosAttributes |= FILE_ATTRIBUTE_HIDDEN_LE;
 		id_to_sid(from_kuid(user_ns, ksmbd_kstat->kstat->uid),
 			  SIDNFS_USER, (struct smb_sid *)&posix_info->SidBuffer[0]);
 		id_to_sid(from_kgid(user_ns, ksmbd_kstat->kstat->gid),
@@ -5480,14 +5478,14 @@ static int set_file_basic_info(struct ksmbd_file *fp, char *buf,
 
 	if (file_info->Attributes) {
 		if (!S_ISDIR(inode->i_mode) &&
-		    file_info->Attributes & ATTR_DIRECTORY_LE) {
+		    file_info->Attributes & FILE_ATTRIBUTE_DIRECTORY_LE) {
 			pr_err("can't change a file to a directory\n");
 			return -EINVAL;
 		}
 
-		if (!(S_ISDIR(inode->i_mode) && file_info->Attributes == ATTR_NORMAL_LE))
+		if (!(S_ISDIR(inode->i_mode) && file_info->Attributes == FILE_ATTRIBUTE_NORMAL_LE))
 			fp->f_ci->m_fattr = file_info->Attributes |
-				(fp->f_ci->m_fattr & ATTR_DIRECTORY_LE);
+				(fp->f_ci->m_fattr & FILE_ATTRIBUTE_DIRECTORY_LE);
 	}
 
 	if (test_share_config_flag(share, KSMBD_SHARE_FLAG_STORE_DOS_ATTRS) &&
@@ -5719,9 +5717,7 @@ static int set_file_mode_info(struct ksmbd_file *fp, char *buf)
 	file_info = (struct smb2_file_mode_info *)buf;
 	mode = file_info->Mode;
 
-	if ((mode & ~FILE_MODE_INFO_MASK) ||
-	    (mode & FILE_SYNCHRONOUS_IO_ALERT_LE &&
-	     mode & FILE_SYNCHRONOUS_IO_NONALERT_LE)) {
+	if (mode & ~FILE_MODE_INFO_MASK) {
 		pr_err("Mode is not valid : 0x%x\n", le32_to_cpu(mode));
 		return -EINVAL;
 	}
@@ -7310,9 +7306,9 @@ static inline int fsctl_set_sparse(struct ksmbd_work *work, u64 id,
 
 	old_fattr = fp->f_ci->m_fattr;
 	if (sparse->SetSparse)
-		fp->f_ci->m_fattr |= ATTR_SPARSE_FILE_LE;
+		fp->f_ci->m_fattr |= FILE_ATTRIBUTE_SPARSE_FILE_LE;
 	else
-		fp->f_ci->m_fattr &= ~ATTR_SPARSE_FILE_LE;
+		fp->f_ci->m_fattr &= ~FILE_ATTRIBUTE_SPARSE_FILE_LE;
 
 	if (fp->f_ci->m_fattr != old_fattr &&
 	    test_share_config_flag(work->tcon->share_conf,
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index 41e3dde87f49..4608cab0f708 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -99,157 +99,6 @@ struct preauth_integrity_info {
 #define SMB2_SESSION_IN_PROGRESS	BIT(0)
 #define SMB2_SESSION_VALID		BIT(1)
 
-#define ATTR_READONLY_LE	cpu_to_le32(ATTR_READONLY)
-#define ATTR_HIDDEN_LE		cpu_to_le32(ATTR_HIDDEN)
-#define ATTR_SYSTEM_LE		cpu_to_le32(ATTR_SYSTEM)
-#define ATTR_DIRECTORY_LE	cpu_to_le32(ATTR_DIRECTORY)
-#define ATTR_ARCHIVE_LE		cpu_to_le32(ATTR_ARCHIVE)
-#define ATTR_NORMAL_LE		cpu_to_le32(ATTR_NORMAL)
-#define ATTR_TEMPORARY_LE	cpu_to_le32(ATTR_TEMPORARY)
-#define ATTR_SPARSE_FILE_LE	cpu_to_le32(ATTR_SPARSE)
-#define ATTR_REPARSE_POINT_LE	cpu_to_le32(ATTR_REPARSE)
-#define ATTR_COMPRESSED_LE	cpu_to_le32(ATTR_COMPRESSED)
-#define ATTR_OFFLINE_LE		cpu_to_le32(ATTR_OFFLINE)
-#define ATTR_NOT_CONTENT_INDEXED_LE	cpu_to_le32(ATTR_NOT_CONTENT_INDEXED)
-#define ATTR_ENCRYPTED_LE	cpu_to_le32(ATTR_ENCRYPTED)
-#define ATTR_INTEGRITY_STREAML_LE	cpu_to_le32(0x00008000)
-#define ATTR_NO_SCRUB_DATA_LE	cpu_to_le32(0x00020000)
-#define ATTR_MASK_LE		cpu_to_le32(0x00007FB7)
-
-/* Oplock levels */
-#define SMB2_OPLOCK_LEVEL_NONE		0x00
-#define SMB2_OPLOCK_LEVEL_II		0x01
-#define SMB2_OPLOCK_LEVEL_EXCLUSIVE	0x08
-#define SMB2_OPLOCK_LEVEL_BATCH		0x09
-#define SMB2_OPLOCK_LEVEL_LEASE		0xFF
-/* Non-spec internal type */
-#define SMB2_OPLOCK_LEVEL_NOCHANGE	0x99
-
-/* Desired Access Flags */
-#define FILE_READ_DATA_LE		cpu_to_le32(0x00000001)
-#define FILE_LIST_DIRECTORY_LE		cpu_to_le32(0x00000001)
-#define FILE_WRITE_DATA_LE		cpu_to_le32(0x00000002)
-#define FILE_ADD_FILE_LE		cpu_to_le32(0x00000002)
-#define FILE_APPEND_DATA_LE		cpu_to_le32(0x00000004)
-#define FILE_ADD_SUBDIRECTORY_LE	cpu_to_le32(0x00000004)
-#define FILE_READ_EA_LE			cpu_to_le32(0x00000008)
-#define FILE_WRITE_EA_LE		cpu_to_le32(0x00000010)
-#define FILE_EXECUTE_LE			cpu_to_le32(0x00000020)
-#define FILE_TRAVERSE_LE		cpu_to_le32(0x00000020)
-#define FILE_DELETE_CHILD_LE		cpu_to_le32(0x00000040)
-#define FILE_READ_ATTRIBUTES_LE		cpu_to_le32(0x00000080)
-#define FILE_WRITE_ATTRIBUTES_LE	cpu_to_le32(0x00000100)
-#define FILE_DELETE_LE			cpu_to_le32(0x00010000)
-#define FILE_READ_CONTROL_LE		cpu_to_le32(0x00020000)
-#define FILE_WRITE_DAC_LE		cpu_to_le32(0x00040000)
-#define FILE_WRITE_OWNER_LE		cpu_to_le32(0x00080000)
-#define FILE_SYNCHRONIZE_LE		cpu_to_le32(0x00100000)
-#define FILE_ACCESS_SYSTEM_SECURITY_LE	cpu_to_le32(0x01000000)
-#define FILE_MAXIMAL_ACCESS_LE		cpu_to_le32(0x02000000)
-#define FILE_GENERIC_ALL_LE		cpu_to_le32(0x10000000)
-#define FILE_GENERIC_EXECUTE_LE		cpu_to_le32(0x20000000)
-#define FILE_GENERIC_WRITE_LE		cpu_to_le32(0x40000000)
-#define FILE_GENERIC_READ_LE		cpu_to_le32(0x80000000)
-#define DESIRED_ACCESS_MASK		cpu_to_le32(0xF21F01FF)
-
-/* ShareAccess Flags */
-#define FILE_SHARE_READ_LE		cpu_to_le32(0x00000001)
-#define FILE_SHARE_WRITE_LE		cpu_to_le32(0x00000002)
-#define FILE_SHARE_DELETE_LE		cpu_to_le32(0x00000004)
-#define FILE_SHARE_ALL_LE		cpu_to_le32(0x00000007)
-
-/* CreateDisposition Flags */
-#define FILE_SUPERSEDE_LE		cpu_to_le32(0x00000000)
-#define FILE_OPEN_LE			cpu_to_le32(0x00000001)
-#define FILE_CREATE_LE			cpu_to_le32(0x00000002)
-#define	FILE_OPEN_IF_LE			cpu_to_le32(0x00000003)
-#define FILE_OVERWRITE_LE		cpu_to_le32(0x00000004)
-#define FILE_OVERWRITE_IF_LE		cpu_to_le32(0x00000005)
-#define FILE_CREATE_MASK_LE		cpu_to_le32(0x00000007)
-
-#define FILE_READ_DESIRED_ACCESS_LE	(FILE_READ_DATA_LE |		\
-					FILE_READ_EA_LE |		\
-					FILE_GENERIC_READ_LE)
-#define FILE_WRITE_DESIRE_ACCESS_LE	(FILE_WRITE_DATA_LE |		\
-					FILE_APPEND_DATA_LE |		\
-					FILE_WRITE_EA_LE |		\
-					FILE_WRITE_ATTRIBUTES_LE |	\
-					FILE_GENERIC_WRITE_LE)
-
-/* Impersonation Levels */
-#define IL_ANONYMOUS_LE		cpu_to_le32(0x00000000)
-#define IL_IDENTIFICATION_LE	cpu_to_le32(0x00000001)
-#define IL_IMPERSONATION_LE	cpu_to_le32(0x00000002)
-#define IL_DELEGATE_LE		cpu_to_le32(0x00000003)
-
-/* Create Context Values */
-#define SMB2_CREATE_EA_BUFFER			"ExtA" /* extended attributes */
-#define SMB2_CREATE_SD_BUFFER			"SecD" /* security descriptor */
-#define SMB2_CREATE_DURABLE_HANDLE_REQUEST	"DHnQ"
-#define SMB2_CREATE_DURABLE_HANDLE_RECONNECT	"DHnC"
-#define SMB2_CREATE_ALLOCATION_SIZE		"AlSi"
-#define SMB2_CREATE_QUERY_MAXIMAL_ACCESS_REQUEST "MxAc"
-#define SMB2_CREATE_TIMEWARP_REQUEST		"TWrp"
-#define SMB2_CREATE_QUERY_ON_DISK_ID		"QFid"
-#define SMB2_CREATE_REQUEST_LEASE		"RqLs"
-#define SMB2_CREATE_DURABLE_HANDLE_REQUEST_V2   "DH2Q"
-#define SMB2_CREATE_DURABLE_HANDLE_RECONNECT_V2 "DH2C"
-#define SMB2_CREATE_APP_INSTANCE_ID     "\x45\xBC\xA6\x6A\xEF\xA7\xF7\x4A\x90\x08\xFA\x46\x2E\x14\x4D\x74"
- #define SMB2_CREATE_APP_INSTANCE_VERSION	"\xB9\x82\xD0\xB7\x3B\x56\x07\x4F\xA0\x7B\x52\x4A\x81\x16\xA0\x10"
-#define SVHDX_OPEN_DEVICE_CONTEXT       0x83CE6F1AD851E0986E34401CC9BCFCE9
-#define SMB2_CREATE_TAG_POSIX		"\x93\xAD\x25\x50\x9C\xB4\x11\xE7\xB4\x23\x83\xDE\x96\x8B\xCD\x7C"
-
-struct smb2_create_req {
-	struct smb2_hdr hdr;
-	__le16 StructureSize;	/* Must be 57 */
-	__u8   SecurityFlags;
-	__u8   RequestedOplockLevel;
-	__le32 ImpersonationLevel;
-	__le64 SmbCreateFlags;
-	__le64 Reserved;
-	__le32 DesiredAccess;
-	__le32 FileAttributes;
-	__le32 ShareAccess;
-	__le32 CreateDisposition;
-	__le32 CreateOptions;
-	__le16 NameOffset;
-	__le16 NameLength;
-	__le32 CreateContextsOffset;
-	__le32 CreateContextsLength;
-	__u8   Buffer[0];
-} __packed;
-
-struct smb2_create_rsp {
-	struct smb2_hdr hdr;
-	__le16 StructureSize;	/* Must be 89 */
-	__u8   OplockLevel;
-	__u8   Reserved;
-	__le32 CreateAction;
-	__le64 CreationTime;
-	__le64 LastAccessTime;
-	__le64 LastWriteTime;
-	__le64 ChangeTime;
-	__le64 AllocationSize;
-	__le64 EndofFile;
-	__le32 FileAttributes;
-	__le32 Reserved2;
-	__le64  PersistentFileId;
-	__le64  VolatileFileId;
-	__le32 CreateContextsOffset;
-	__le32 CreateContextsLength;
-	__u8   Buffer[1];
-} __packed;
-
-struct create_context {
-	__le32 Next;
-	__le16 NameOffset;
-	__le16 NameLength;
-	__le16 Reserved;
-	__le16 DataOffset;
-	__le32 DataLength;
-	__u8 Buffer[0];
-} __packed;
-
 struct create_durable_req_v2 {
 	struct create_context ccontext;
 	__u8   Name[8];
@@ -1002,7 +851,7 @@ struct smb2_file_pos_info {
 	__le64 CurrentByteOffset;
 } __packed;
 
-#define FILE_MODE_INFO_MASK cpu_to_le32(0x0000103e)
+#define FILE_MODE_INFO_MASK cpu_to_le32(0x0000100e)
 
 struct smb2_file_mode_info {
 	__le32 Mode;
diff --git a/fs/ksmbd/smb_common.h b/fs/ksmbd/smb_common.h
index ebd6715d7533..047a23aea396 100644
--- a/fs/ksmbd/smb_common.h
+++ b/fs/ksmbd/smb_common.h
@@ -55,21 +55,6 @@
 /*
  * File Attribute flags
  */
-#define ATTR_READONLY			0x0001
-#define ATTR_HIDDEN			0x0002
-#define ATTR_SYSTEM			0x0004
-#define ATTR_VOLUME			0x0008
-#define ATTR_DIRECTORY			0x0010
-#define ATTR_ARCHIVE			0x0020
-#define ATTR_DEVICE			0x0040
-#define ATTR_NORMAL			0x0080
-#define ATTR_TEMPORARY			0x0100
-#define ATTR_SPARSE			0x0200
-#define ATTR_REPARSE			0x0400
-#define ATTR_COMPRESSED			0x0800
-#define ATTR_OFFLINE			0x1000
-#define ATTR_NOT_CONTENT_INDEXED	0x2000
-#define ATTR_ENCRYPTED			0x4000
 #define ATTR_POSIX_SEMANTICS		0x01000000
 #define ATTR_BACKUP_SEMANTICS		0x02000000
 #define ATTR_DELETE_ON_CLOSE		0x04000000
@@ -78,23 +63,6 @@
 #define ATTR_NO_BUFFERING		0x20000000
 #define ATTR_WRITE_THROUGH		0x80000000
 
-#define ATTR_READONLY_LE		cpu_to_le32(ATTR_READONLY)
-#define ATTR_HIDDEN_LE			cpu_to_le32(ATTR_HIDDEN)
-#define ATTR_SYSTEM_LE			cpu_to_le32(ATTR_SYSTEM)
-#define ATTR_DIRECTORY_LE		cpu_to_le32(ATTR_DIRECTORY)
-#define ATTR_ARCHIVE_LE			cpu_to_le32(ATTR_ARCHIVE)
-#define ATTR_NORMAL_LE			cpu_to_le32(ATTR_NORMAL)
-#define ATTR_TEMPORARY_LE		cpu_to_le32(ATTR_TEMPORARY)
-#define ATTR_SPARSE_FILE_LE		cpu_to_le32(ATTR_SPARSE)
-#define ATTR_REPARSE_POINT_LE		cpu_to_le32(ATTR_REPARSE)
-#define ATTR_COMPRESSED_LE		cpu_to_le32(ATTR_COMPRESSED)
-#define ATTR_OFFLINE_LE			cpu_to_le32(ATTR_OFFLINE)
-#define ATTR_NOT_CONTENT_INDEXED_LE	cpu_to_le32(ATTR_NOT_CONTENT_INDEXED)
-#define ATTR_ENCRYPTED_LE		cpu_to_le32(ATTR_ENCRYPTED)
-#define ATTR_INTEGRITY_STREAML_LE	cpu_to_le32(0x00008000)
-#define ATTR_NO_SCRUB_DATA_LE		cpu_to_le32(0x00020000)
-#define ATTR_MASK_LE			cpu_to_le32(0x00007FB7)
-
 /* List of FileSystemAttributes - see 2.5.1 of MS-FSCC */
 #define FILE_SUPPORTS_SPARSE_VDL	0x10000000 /* faster nonsparse extend */
 #define FILE_SUPPORTS_BLOCK_REFCOUNTING	0x08000000 /* allow ioctl dup extents */
@@ -156,11 +124,6 @@
 /* file_execute, file_read_attributes*/
 /* write_dac, and delete.           */
 
-#define FILE_READ_RIGHTS (FILE_READ_DATA | FILE_READ_EA | FILE_READ_ATTRIBUTES)
-#define FILE_WRITE_RIGHTS (FILE_WRITE_DATA | FILE_APPEND_DATA \
-		| FILE_WRITE_EA | FILE_WRITE_ATTRIBUTES)
-#define FILE_EXEC_RIGHTS (FILE_EXECUTE)
-
 #define SET_FILE_READ_RIGHTS (FILE_READ_DATA | FILE_READ_EA \
 		| FILE_READ_ATTRIBUTES \
 		| DELETE | READ_CONTROL | WRITE_DAC \
diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
index aee28ee6b19c..b5383c96579e 100644
--- a/fs/ksmbd/vfs.c
+++ b/fs/ksmbd/vfs.c
@@ -1033,7 +1033,7 @@ int ksmbd_vfs_zero_data(struct ksmbd_work *work, struct ksmbd_file *fp,
 			loff_t off, loff_t len)
 {
 	smb_break_all_levII_oplock(work, fp, 1);
-	if (fp->f_ci->m_fattr & ATTR_SPARSE_FILE_LE)
+	if (fp->f_ci->m_fattr & FILE_ATTRIBUTE_SPARSE_FILE_LE)
 		return vfs_fallocate(fp->filp,
 				     FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
 				     off, len);
@@ -1625,7 +1625,7 @@ void *ksmbd_vfs_init_kstat(char **p, struct ksmbd_kstat *ksmbd_kstat)
 	time = ksmbd_UnixTimeToNT(kstat->ctime);
 	info->ChangeTime = cpu_to_le64(time);
 
-	if (ksmbd_kstat->file_attributes & ATTR_DIRECTORY_LE) {
+	if (ksmbd_kstat->file_attributes & FILE_ATTRIBUTE_DIRECTORY_LE) {
 		info->EndOfFile = 0;
 		info->AllocationSize = 0;
 	} else {
@@ -1655,9 +1655,9 @@ int ksmbd_vfs_fill_dentry_attrs(struct ksmbd_work *work,
 	 * or that acl is disable in server's filesystem and the config is yes.
 	 */
 	if (S_ISDIR(ksmbd_kstat->kstat->mode))
-		ksmbd_kstat->file_attributes = ATTR_DIRECTORY_LE;
+		ksmbd_kstat->file_attributes = FILE_ATTRIBUTE_DIRECTORY_LE;
 	else
-		ksmbd_kstat->file_attributes = ATTR_ARCHIVE_LE;
+		ksmbd_kstat->file_attributes = FILE_ATTRIBUTE_ARCHIVE_LE;
 
 	if (test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_STORE_DOS_ATTRS)) {
diff --git a/fs/ksmbd/vfs.h b/fs/ksmbd/vfs.h
index cb0cba0d5d07..729f2be2cbd0 100644
--- a/fs/ksmbd/vfs.h
+++ b/fs/ksmbd/vfs.h
@@ -24,49 +24,6 @@ enum {
 	DIR_STREAM		/* type $INDEX_ALLOCATION */
 };
 
-/* CreateOptions */
-/* Flag is set, it must not be a file , valid for directory only */
-#define FILE_DIRECTORY_FILE_LE			cpu_to_le32(0x00000001)
-#define FILE_WRITE_THROUGH_LE			cpu_to_le32(0x00000002)
-#define FILE_SEQUENTIAL_ONLY_LE			cpu_to_le32(0x00000004)
-
-/* Should not buffer on server*/
-#define FILE_NO_INTERMEDIATE_BUFFERING_LE	cpu_to_le32(0x00000008)
-/* MBZ */
-#define FILE_SYNCHRONOUS_IO_ALERT_LE		cpu_to_le32(0x00000010)
-/* MBZ */
-#define FILE_SYNCHRONOUS_IO_NONALERT_LE		cpu_to_le32(0x00000020)
-
-/* Flaf must not be set for directory */
-#define FILE_NON_DIRECTORY_FILE_LE		cpu_to_le32(0x00000040)
-
-/* Should be zero */
-#define CREATE_TREE_CONNECTION			cpu_to_le32(0x00000080)
-#define FILE_COMPLETE_IF_OPLOCKED_LE		cpu_to_le32(0x00000100)
-#define FILE_NO_EA_KNOWLEDGE_LE			cpu_to_le32(0x00000200)
-#define FILE_OPEN_REMOTE_INSTANCE		cpu_to_le32(0x00000400)
-
-/**
- * Doc says this is obsolete "open for recovery" flag should be zero
- * in any case.
- */
-#define CREATE_OPEN_FOR_RECOVERY		cpu_to_le32(0x00000400)
-#define FILE_RANDOM_ACCESS_LE			cpu_to_le32(0x00000800)
-#define FILE_DELETE_ON_CLOSE_LE			cpu_to_le32(0x00001000)
-#define FILE_OPEN_BY_FILE_ID_LE			cpu_to_le32(0x00002000)
-#define FILE_OPEN_FOR_BACKUP_INTENT_LE		cpu_to_le32(0x00004000)
-#define FILE_NO_COMPRESSION_LE			cpu_to_le32(0x00008000)
-
-/* Should be zero*/
-#define FILE_OPEN_REQUIRING_OPLOCK		cpu_to_le32(0x00010000)
-#define FILE_DISALLOW_EXCLUSIVE			cpu_to_le32(0x00020000)
-#define FILE_RESERVE_OPFILTER_LE		cpu_to_le32(0x00100000)
-#define FILE_OPEN_REPARSE_POINT_LE		cpu_to_le32(0x00200000)
-#define FILE_OPEN_NO_RECALL_LE			cpu_to_le32(0x00400000)
-
-/* Should be zero */
-#define FILE_OPEN_FOR_FREE_SPACE_QUERY_LE	cpu_to_le32(0x00800000)
-#define CREATE_OPTIONS_MASK			cpu_to_le32(0x00FFFFFF)
 #define CREATE_OPTION_READONLY			0x10000000
 /* system. NB not sent over wire */
 #define CREATE_OPTION_SPECIAL			0x20000000
-- 
2.30.2

