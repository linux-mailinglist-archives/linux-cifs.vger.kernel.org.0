Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 20E4041C0E4
	for <lists+linux-cifs@lfdr.de>; Wed, 29 Sep 2021 10:45:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244795AbhI2IrE (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 29 Sep 2021 04:47:04 -0400
Received: from mail-pl1-f181.google.com ([209.85.214.181]:36430 "EHLO
        mail-pl1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244787AbhI2IrD (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 29 Sep 2021 04:47:03 -0400
Received: by mail-pl1-f181.google.com with SMTP id y5so1031667pll.3
        for <linux-cifs@vger.kernel.org>; Wed, 29 Sep 2021 01:45:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7bvjMrwfQmvc0gFcVkdgjUBH6ua8zcPG4es1pN+YYL8=;
        b=AauShN56R5pZOC/mxGKz3mVL2sNb0dc3mdC3de7cLhsFNqdLV6xobn7wzBcdjdQx5T
         wyGnRVsd5+VKljUkMGzh1hbDeA1roa9qJO9xCOUOGQ609EV3m/JPgRq6oCqyGvjatfLo
         jfpsfcaezHxSyUaqZRYts92i/v+irw+EwuB4o3o/t6sMXc3uTuuFo6C7U6epaEzFPaaR
         r44f4drGrhOH7VLAs5Htv8OKA0d/v/QkKq8P6rL2HLJGHEscsX7ugTRRp684dpL2WtpY
         oAY9JiCpEeP0jpIWErSbRVh2iEImyrhPn89Y8uxzQklmOarg45rpiiB49RcAEGAyoeK1
         wV8Q==
X-Gm-Message-State: AOAM533X4oFREHH33RBxvjpSzpvM8eEfh88KecOO2yw07FnGGgetP/Y6
        6fgf+TmON9e9VDar1HMYh/73//nb5EqpkQ==
X-Google-Smtp-Source: ABdhPJx9JHPdylycayJZQLddfhfnjV8uJTrAajFHapucF7m/PxyQgfSuR3jh1eREnd9zXufzQFmtlQ==
X-Received: by 2002:a17:902:ce88:b0:13d:fc33:fc9f with SMTP id f8-20020a170902ce8800b0013dfc33fc9fmr9297803plg.37.1632905122624;
        Wed, 29 Sep 2021 01:45:22 -0700 (PDT)
Received: from localhost.localdomain ([61.74.27.164])
        by smtp.gmail.com with ESMTPSA id q3sm1912344pgf.18.2021.09.29.01.45.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Sep 2021 01:45:22 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>, Tom Talpey <tom@talpey.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        =?UTF-8?q?Ralph=20B=C3=B6hme?= <slow@samba.org>,
        Steve French <smfrench@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hyunchul Lee <hyc.lee@gmail.com>
Subject: [PATCH v4 4/9] ksmbd: add request buffer validation in smb2_set_info
Date:   Wed, 29 Sep 2021 17:44:56 +0900
Message-Id: <20210929084501.94846-5-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210929084501.94846-1-linkinjeon@kernel.org>
References: <20210929084501.94846-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Add buffer validation in smb2_set_info, and remove unused variable
in set_file_basic_info. and smb2_set_info infolevel functions take
structure pointer argument.

Cc: Tom Talpey <tom@talpey.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Ralph Böhme <slow@samba.org>
Cc: Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Acked-by: Hyunchul Lee <hyc.lee@gmail.com>
Reviewed-by: Ralph Boehme <slow@samba.org>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ksmbd/smb2pdu.c | 149 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 107 insertions(+), 42 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index d874813aca90..c434390ffcae 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2102,16 +2102,22 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
  * smb2_set_ea() - handler for setting extended attributes using set
  *		info command
  * @eabuf:	set info command buffer
+ * @buf_len:	set info command buffer length
  * @path:	dentry path for get ea
  *
  * Return:	0 on success, otherwise error
  */
-static int smb2_set_ea(struct smb2_ea_info *eabuf, struct path *path)
+static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
+		       struct path *path)
 {
 	struct user_namespace *user_ns = mnt_user_ns(path->mnt);
 	char *attr_name = NULL, *value;
 	int rc = 0;
-	int next = 0;
+	unsigned int next = 0;
+
+	if (buf_len < sizeof(struct smb2_ea_info) + eabuf->EaNameLength +
+			le16_to_cpu(eabuf->EaValueLength))
+		return -EINVAL;
 
 	attr_name = kmalloc(XATTR_NAME_MAX + 1, GFP_KERNEL);
 	if (!attr_name)
@@ -2176,7 +2182,13 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, struct path *path)
 
 next:
 		next = le32_to_cpu(eabuf->NextEntryOffset);
+		if (next == 0 || buf_len < next)
+			break;
+		buf_len -= next;
 		eabuf = (struct smb2_ea_info *)((char *)eabuf + next);
+		if (next < (u32)eabuf->EaNameLength + le16_to_cpu(eabuf->EaValueLength))
+			break;
+
 	} while (next != 0);
 
 	kfree(attr_name);
@@ -2757,7 +2769,15 @@ int smb2_open(struct ksmbd_work *work)
 		created = true;
 		user_ns = mnt_user_ns(path.mnt);
 		if (ea_buf) {
-			rc = smb2_set_ea(&ea_buf->ea, &path);
+			if (le32_to_cpu(ea_buf->ccontext.DataLength) <
+			    sizeof(struct smb2_ea_info)) {
+				rc = -EINVAL;
+				goto err_out;
+			}
+
+			rc = smb2_set_ea(&ea_buf->ea,
+					 le32_to_cpu(ea_buf->ccontext.DataLength),
+					 &path);
 			if (rc == -EOPNOTSUPP)
 				rc = 0;
 			else if (rc)
@@ -5341,7 +5361,7 @@ static int smb2_rename(struct ksmbd_work *work,
 static int smb2_create_link(struct ksmbd_work *work,
 			    struct ksmbd_share_config *share,
 			    struct smb2_file_link_info *file_info,
-			    struct file *filp,
+			    unsigned int buf_len, struct file *filp,
 			    struct nls_table *local_nls)
 {
 	char *link_name = NULL, *target_name = NULL, *pathname = NULL;
@@ -5349,6 +5369,10 @@ static int smb2_create_link(struct ksmbd_work *work,
 	bool file_present = true;
 	int rc;
 
+	if (buf_len < (u64)sizeof(struct smb2_file_link_info) +
+			le32_to_cpu(file_info->FileNameLength))
+		return -EINVAL;
+
 	ksmbd_debug(SMB, "setting FILE_LINK_INFORMATION\n");
 	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!pathname)
@@ -5408,10 +5432,10 @@ static int smb2_create_link(struct ksmbd_work *work,
 	return rc;
 }
 
-static int set_file_basic_info(struct ksmbd_file *fp, char *buf,
+static int set_file_basic_info(struct ksmbd_file *fp,
+			       struct smb2_file_basic_info *file_info,
 			       struct ksmbd_share_config *share)
 {
-	struct smb2_file_basic_info *file_info;
 	struct iattr attrs;
 	struct timespec64 ctime;
 	struct file *filp;
@@ -5422,7 +5446,6 @@ static int set_file_basic_info(struct ksmbd_file *fp, char *buf,
 	if (!(fp->daccess & FILE_WRITE_ATTRIBUTES_LE))
 		return -EACCES;
 
-	file_info = (struct smb2_file_basic_info *)buf;
 	attrs.ia_valid = 0;
 	filp = fp->filp;
 	inode = file_inode(filp);
@@ -5499,7 +5522,8 @@ static int set_file_basic_info(struct ksmbd_file *fp, char *buf,
 }
 
 static int set_file_allocation_info(struct ksmbd_work *work,
-				    struct ksmbd_file *fp, char *buf)
+				    struct ksmbd_file *fp,
+				    struct smb2_file_alloc_info *file_alloc_info)
 {
 	/*
 	 * TODO : It's working fine only when store dos attributes
@@ -5507,7 +5531,6 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 	 * properly with any smb.conf option
 	 */
 
-	struct smb2_file_alloc_info *file_alloc_info;
 	loff_t alloc_blks;
 	struct inode *inode;
 	int rc;
@@ -5515,7 +5538,6 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 	if (!(fp->daccess & FILE_WRITE_DATA_LE))
 		return -EACCES;
 
-	file_alloc_info = (struct smb2_file_alloc_info *)buf;
 	alloc_blks = (le64_to_cpu(file_alloc_info->AllocationSize) + 511) >> 9;
 	inode = file_inode(fp->filp);
 
@@ -5551,9 +5573,8 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 }
 
 static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
-				char *buf)
+				struct smb2_file_eof_info *file_eof_info)
 {
-	struct smb2_file_eof_info *file_eof_info;
 	loff_t newsize;
 	struct inode *inode;
 	int rc;
@@ -5561,7 +5582,6 @@ static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 	if (!(fp->daccess & FILE_WRITE_DATA_LE))
 		return -EACCES;
 
-	file_eof_info = (struct smb2_file_eof_info *)buf;
 	newsize = le64_to_cpu(file_eof_info->EndOfFile);
 	inode = file_inode(fp->filp);
 
@@ -5588,7 +5608,8 @@ static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 }
 
 static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
-			   char *buf)
+			   struct smb2_file_rename_info *rename_info,
+			   unsigned int buf_len)
 {
 	struct user_namespace *user_ns;
 	struct ksmbd_file *parent_fp;
@@ -5601,6 +5622,10 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 		return -EACCES;
 	}
 
+	if (buf_len < (u64)sizeof(struct smb2_file_rename_info) +
+			le32_to_cpu(rename_info->FileNameLength))
+		return -EINVAL;
+
 	user_ns = file_mnt_user_ns(fp->filp);
 	if (ksmbd_stream_fd(fp))
 		goto next;
@@ -5623,14 +5648,13 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 		}
 	}
 next:
-	return smb2_rename(work, fp, user_ns,
-			   (struct smb2_file_rename_info *)buf,
+	return smb2_rename(work, fp, user_ns, rename_info,
 			   work->sess->conn->local_nls);
 }
 
-static int set_file_disposition_info(struct ksmbd_file *fp, char *buf)
+static int set_file_disposition_info(struct ksmbd_file *fp,
+				     struct smb2_file_disposition_info *file_info)
 {
-	struct smb2_file_disposition_info *file_info;
 	struct inode *inode;
 
 	if (!(fp->daccess & FILE_DELETE_LE)) {
@@ -5639,7 +5663,6 @@ static int set_file_disposition_info(struct ksmbd_file *fp, char *buf)
 	}
 
 	inode = file_inode(fp->filp);
-	file_info = (struct smb2_file_disposition_info *)buf;
 	if (file_info->DeletePending) {
 		if (S_ISDIR(inode->i_mode) &&
 		    ksmbd_vfs_empty_dir(fp) == -ENOTEMPTY)
@@ -5651,15 +5674,14 @@ static int set_file_disposition_info(struct ksmbd_file *fp, char *buf)
 	return 0;
 }
 
-static int set_file_position_info(struct ksmbd_file *fp, char *buf)
+static int set_file_position_info(struct ksmbd_file *fp,
+				  struct smb2_file_pos_info *file_info)
 {
-	struct smb2_file_pos_info *file_info;
 	loff_t current_byte_offset;
 	unsigned long sector_size;
 	struct inode *inode;
 
 	inode = file_inode(fp->filp);
-	file_info = (struct smb2_file_pos_info *)buf;
 	current_byte_offset = le64_to_cpu(file_info->CurrentByteOffset);
 	sector_size = inode->i_sb->s_blocksize;
 
@@ -5675,12 +5697,11 @@ static int set_file_position_info(struct ksmbd_file *fp, char *buf)
 	return 0;
 }
 
-static int set_file_mode_info(struct ksmbd_file *fp, char *buf)
+static int set_file_mode_info(struct ksmbd_file *fp,
+			      struct smb2_file_mode_info *file_info)
 {
-	struct smb2_file_mode_info *file_info;
 	__le32 mode;
 
-	file_info = (struct smb2_file_mode_info *)buf;
 	mode = file_info->Mode;
 
 	if ((mode & ~FILE_MODE_INFO_MASK) ||
@@ -5710,40 +5731,74 @@ static int set_file_mode_info(struct ksmbd_file *fp, char *buf)
  * TODO: need to implement an error handling for STATUS_INFO_LENGTH_MISMATCH
  */
 static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
-			      int info_class, char *buf,
+			      struct smb2_set_info_req *req,
 			      struct ksmbd_share_config *share)
 {
-	switch (info_class) {
+	unsigned int buf_len = le32_to_cpu(req->BufferLength);
+
+	switch (req->FileInfoClass) {
 	case FILE_BASIC_INFORMATION:
-		return set_file_basic_info(fp, buf, share);
+	{
+		if (buf_len < sizeof(struct smb2_file_basic_info))
+			return -EINVAL;
 
+		return set_file_basic_info(fp, (struct smb2_file_basic_info *)req->Buffer, share);
+	}
 	case FILE_ALLOCATION_INFORMATION:
-		return set_file_allocation_info(work, fp, buf);
+	{
+		if (buf_len < sizeof(struct smb2_file_alloc_info))
+			return -EINVAL;
 
+		return set_file_allocation_info(work, fp,
+						(struct smb2_file_alloc_info *)req->Buffer);
+	}
 	case FILE_END_OF_FILE_INFORMATION:
-		return set_end_of_file_info(work, fp, buf);
+	{
+		if (buf_len < sizeof(struct smb2_file_eof_info))
+			return -EINVAL;
 
+		return set_end_of_file_info(work, fp,
+					    (struct smb2_file_eof_info *)req->Buffer);
+	}
 	case FILE_RENAME_INFORMATION:
+	{
 		if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
 			ksmbd_debug(SMB,
 				    "User does not have write permission\n");
 			return -EACCES;
 		}
-		return set_rename_info(work, fp, buf);
 
+		if (buf_len < sizeof(struct smb2_file_rename_info))
+			return -EINVAL;
+
+		return set_rename_info(work, fp,
+				       (struct smb2_file_rename_info *)req->Buffer,
+				       buf_len);
+	}
 	case FILE_LINK_INFORMATION:
+	{
+		if (buf_len < sizeof(struct smb2_file_link_info))
+			return -EINVAL;
+
 		return smb2_create_link(work, work->tcon->share_conf,
-					(struct smb2_file_link_info *)buf, fp->filp,
+					(struct smb2_file_link_info *)req->Buffer,
+					buf_len, fp->filp,
 					work->sess->conn->local_nls);
-
+	}
 	case FILE_DISPOSITION_INFORMATION:
+	{
 		if (!test_tree_conn_flag(work->tcon, KSMBD_TREE_CONN_FLAG_WRITABLE)) {
 			ksmbd_debug(SMB,
 				    "User does not have write permission\n");
 			return -EACCES;
 		}
-		return set_file_disposition_info(fp, buf);
 
+		if (buf_len < sizeof(struct smb2_file_disposition_info))
+			return -EINVAL;
+
+		return set_file_disposition_info(fp,
+						 (struct smb2_file_disposition_info *)req->Buffer);
+	}
 	case FILE_FULL_EA_INFORMATION:
 	{
 		if (!(fp->daccess & FILE_WRITE_EA_LE)) {
@@ -5752,18 +5807,29 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
 			return -EACCES;
 		}
 
-		return smb2_set_ea((struct smb2_ea_info *)buf,
-				   &fp->filp->f_path);
-	}
+		if (buf_len < sizeof(struct smb2_ea_info))
+			return -EINVAL;
 
+		return smb2_set_ea((struct smb2_ea_info *)req->Buffer,
+				   buf_len, &fp->filp->f_path);
+	}
 	case FILE_POSITION_INFORMATION:
-		return set_file_position_info(fp, buf);
+	{
+		if (buf_len < sizeof(struct smb2_file_pos_info))
+			return -EINVAL;
 
+		return set_file_position_info(fp, (struct smb2_file_pos_info *)req->Buffer);
+	}
 	case FILE_MODE_INFORMATION:
-		return set_file_mode_info(fp, buf);
+	{
+		if (buf_len < sizeof(struct smb2_file_mode_info))
+			return -EINVAL;
+
+		return set_file_mode_info(fp, (struct smb2_file_mode_info *)req->Buffer);
+	}
 	}
 
-	pr_err("Unimplemented Fileinfoclass :%d\n", info_class);
+	pr_err("Unimplemented Fileinfoclass :%d\n", req->FileInfoClass);
 	return -EOPNOTSUPP;
 }
 
@@ -5824,8 +5890,7 @@ int smb2_set_info(struct ksmbd_work *work)
 	switch (req->InfoType) {
 	case SMB2_O_INFO_FILE:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILE\n");
-		rc = smb2_set_info_file(work, fp, req->FileInfoClass,
-					req->Buffer, work->tcon->share_conf);
+		rc = smb2_set_info_file(work, fp, req, work->tcon->share_conf);
 		break;
 	case SMB2_O_INFO_SECURITY:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_SECURITY\n");
-- 
2.25.1

