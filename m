Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05FE7412E00
	for <lists+linux-cifs@lfdr.de>; Tue, 21 Sep 2021 06:41:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229667AbhIUEmj (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 21 Sep 2021 00:42:39 -0400
Received: from mail-pg1-f181.google.com ([209.85.215.181]:41487 "EHLO
        mail-pg1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbhIUEmi (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 21 Sep 2021 00:42:38 -0400
Received: by mail-pg1-f181.google.com with SMTP id k24so19560692pgh.8
        for <linux-cifs@vger.kernel.org>; Mon, 20 Sep 2021 21:41:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QKg8L4ATXd737XtTpF1bmC7D3pe33d9YpOqC4XOihq8=;
        b=MIVbJ9Ax6mO3nNvpniTemN95jRSwN2JLCjq1jqH0/2hrrQzSvDQtmulvUqeApISPm4
         ekuVot8JK33S1qxaQEXK6e1KcESUMuFHxnCUk5WVvMOeE+CbIfOcr4jA9M1YLfBMl+uF
         NpoEShesMYXm98jqi4WnZJ4+vGr8c1Q5dwwxtr/sCtGAZ/ufvHcyjSTLH2L9K6R2pijT
         pszxk4IO26Zz/UzLxYR6aQ6rFIGgTxdJ0dCO/9uJRmZBxJJU0nxxaGB6M4Fv2oWHGnXb
         ExKQ9CfviVstP5YQ4/8ZIEEN4/F8IW+AglIDpTLl4TTjallOAJvfn7cheQ702K1WTf+S
         GjKQ==
X-Gm-Message-State: AOAM532c8HxfbrD6go1o8+/HjIslK9cAGD/uOf/7OM8lmtG0NyD/YGCo
        vypmpiTrGOoeTCVJqHvNSPF+O8tXeZU7wA==
X-Google-Smtp-Source: ABdhPJyxWElowgl/WdlPVUkLV0zeQNS9UrOg3PWnW3M9pEU2NEyqRwF3wyA5xbxDA6RTBGC1T2otww==
X-Received: by 2002:a63:235f:: with SMTP id u31mr27015013pgm.248.1632199270604;
        Mon, 20 Sep 2021 21:41:10 -0700 (PDT)
Received: from localhost.localdomain ([61.74.27.164])
        by smtp.gmail.com with ESMTPSA id u24sm16863257pfm.81.2021.09.20.21.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 21:41:10 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        =?UTF-8?q?Ralph=20B=C3=B6hme?= <slow@samba.org>,
        Steve French <smfrench@gmail.com>
Subject: [PATCH v2] ksmbd: add request buffer validation in smb2_set_info
Date:   Tue, 21 Sep 2021 13:40:40 +0900
Message-Id: <20210921044040.624769-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210921044040.624769-1-linkinjeon@kernel.org>
References: <20210921044040.624769-1-linkinjeon@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Add buffer validation in smb2_set_info.

Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Ralph Böhme <slow@samba.org>
Cc: Steve French <smfrench@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 v2:
   - smb2_set_info infolevel functions take structure pointer argument.

 fs/ksmbd/smb2pdu.c | 141 ++++++++++++++++++++++++++++++++-------------
 fs/ksmbd/smb2pdu.h |   9 +++
 2 files changed, 109 insertions(+), 41 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index de044802fc5b..e26e6b29e655 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -2107,17 +2107,23 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
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
 	int next = 0;
 
+	if (buf_len < sizeof(struct smb2_ea_info) + eabuf->EaNameLength +
+			le16_to_cpu(eabuf->EaValueLength))
+		return -EINVAL;
+
 	attr_name = kmalloc(XATTR_NAME_MAX + 1, GFP_KERNEL);
 	if (!attr_name)
 		return -ENOMEM;
@@ -2181,7 +2187,13 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, struct path *path)
 
 next:
 		next = le32_to_cpu(eabuf->NextEntryOffset);
+		if (next == 0 || buf_len < next)
+			break;
+		buf_len -= next;
 		eabuf = (struct smb2_ea_info *)((char *)eabuf + next);
+		if (next < eabuf->EaNameLength + le16_to_cpu(eabuf->EaValueLength))
+			break;
+
 	} while (next != 0);
 
 	kfree(attr_name);
@@ -2787,7 +2799,9 @@ int smb2_open(struct ksmbd_work *work)
 		created = true;
 		user_ns = mnt_user_ns(path.mnt);
 		if (ea_buf) {
-			rc = smb2_set_ea(&ea_buf->ea, &path);
+			rc = smb2_set_ea(&ea_buf->ea,
+					 le32_to_cpu(ea_buf->ccontext.DataLength),
+					 &path);
 			if (rc == -EOPNOTSUPP)
 				rc = 0;
 			else if (rc)
@@ -5377,7 +5391,7 @@ static int smb2_rename(struct ksmbd_work *work,
 static int smb2_create_link(struct ksmbd_work *work,
 			    struct ksmbd_share_config *share,
 			    struct smb2_file_link_info *file_info,
-			    struct file *filp,
+			    int buf_len, struct file *filp,
 			    struct nls_table *local_nls)
 {
 	char *link_name = NULL, *target_name = NULL, *pathname = NULL;
@@ -5385,6 +5399,10 @@ static int smb2_create_link(struct ksmbd_work *work,
 	bool file_present = true;
 	int rc;
 
+	if (buf_len < sizeof(struct smb2_file_link_info) +
+			le32_to_cpu(file_info->FileNameLength))
+		return -EINVAL;
+
 	ksmbd_debug(SMB, "setting FILE_LINK_INFORMATION\n");
 	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
 	if (!pathname)
@@ -5441,10 +5459,10 @@ static int smb2_create_link(struct ksmbd_work *work,
 	return rc;
 }
 
-static int set_file_basic_info(struct ksmbd_file *fp, char *buf,
+static int set_file_basic_info(struct ksmbd_file *fp,
+			       struct smb2_file_basic_info *file_info,
 			       struct ksmbd_share_config *share)
 {
-	struct smb2_file_all_info *file_info;
 	struct iattr attrs;
 	struct timespec64 ctime;
 	struct file *filp;
@@ -5455,7 +5473,6 @@ static int set_file_basic_info(struct ksmbd_file *fp, char *buf,
 	if (!(fp->daccess & FILE_WRITE_ATTRIBUTES_LE))
 		return -EACCES;
 
-	file_info = (struct smb2_file_all_info *)buf;
 	attrs.ia_valid = 0;
 	filp = fp->filp;
 	inode = file_inode(filp);
@@ -5532,7 +5549,8 @@ static int set_file_basic_info(struct ksmbd_file *fp, char *buf,
 }
 
 static int set_file_allocation_info(struct ksmbd_work *work,
-				    struct ksmbd_file *fp, char *buf)
+				    struct ksmbd_file *fp,
+				    struct smb2_file_alloc_info *file_alloc_info)
 {
 	/*
 	 * TODO : It's working fine only when store dos attributes
@@ -5540,7 +5558,6 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 	 * properly with any smb.conf option
 	 */
 
-	struct smb2_file_alloc_info *file_alloc_info;
 	loff_t alloc_blks;
 	struct inode *inode;
 	int rc;
@@ -5548,7 +5565,6 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 	if (!(fp->daccess & FILE_WRITE_DATA_LE))
 		return -EACCES;
 
-	file_alloc_info = (struct smb2_file_alloc_info *)buf;
 	alloc_blks = (le64_to_cpu(file_alloc_info->AllocationSize) + 511) >> 9;
 	inode = file_inode(fp->filp);
 
@@ -5584,9 +5600,8 @@ static int set_file_allocation_info(struct ksmbd_work *work,
 }
 
 static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
-				char *buf)
+				struct smb2_file_eof_info *file_eof_info)
 {
-	struct smb2_file_eof_info *file_eof_info;
 	loff_t newsize;
 	struct inode *inode;
 	int rc;
@@ -5594,7 +5609,6 @@ static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 	if (!(fp->daccess & FILE_WRITE_DATA_LE))
 		return -EACCES;
 
-	file_eof_info = (struct smb2_file_eof_info *)buf;
 	newsize = le64_to_cpu(file_eof_info->EndOfFile);
 	inode = file_inode(fp->filp);
 
@@ -5621,7 +5635,8 @@ static int set_end_of_file_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 }
 
 static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
-			   char *buf)
+			   struct smb2_file_rename_info *rename_info,
+			   int buf_len)
 {
 	struct user_namespace *user_ns;
 	struct ksmbd_file *parent_fp;
@@ -5634,6 +5649,10 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
 		return -EACCES;
 	}
 
+	if (buf_len < sizeof(struct smb2_file_rename_info) +
+			le32_to_cpu(rename_info->FileNameLength))
+		return -EINVAL;
+
 	user_ns = file_mnt_user_ns(fp->filp);
 	if (ksmbd_stream_fd(fp))
 		goto next;
@@ -5656,14 +5675,13 @@ static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file *fp,
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
@@ -5672,7 +5690,6 @@ static int set_file_disposition_info(struct ksmbd_file *fp, char *buf)
 	}
 
 	inode = file_inode(fp->filp);
-	file_info = (struct smb2_file_disposition_info *)buf;
 	if (file_info->DeletePending) {
 		if (S_ISDIR(inode->i_mode) &&
 		    ksmbd_vfs_empty_dir(fp) == -ENOTEMPTY)
@@ -5684,15 +5701,14 @@ static int set_file_disposition_info(struct ksmbd_file *fp, char *buf)
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
 
@@ -5708,12 +5724,11 @@ static int set_file_position_info(struct ksmbd_file *fp, char *buf)
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
@@ -5743,40 +5758,74 @@ static int set_file_mode_info(struct ksmbd_file *fp, char *buf)
  * TODO: need to implement an error handling for STATUS_INFO_LENGTH_MISMATCH
  */
 static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
-			      int info_class, char *buf,
+			      struct smb2_set_info_req *req,
 			      struct ksmbd_share_config *share)
 {
-	switch (info_class) {
+	int buf_len = le32_to_cpu(req->BufferLength);
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
@@ -5785,18 +5834,29 @@ static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_file *fp,
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
 
@@ -5857,8 +5917,7 @@ int smb2_set_info(struct ksmbd_work *work)
 	switch (req->InfoType) {
 	case SMB2_O_INFO_FILE:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILE\n");
-		rc = smb2_set_info_file(work, fp, req->FileInfoClass,
-					req->Buffer, work->tcon->share_conf);
+		rc = smb2_set_info_file(work, fp, req, work->tcon->share_conf);
 		break;
 	case SMB2_O_INFO_SECURITY:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_SECURITY\n");
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index bcec845b03f3..261825d06391 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -1464,6 +1464,15 @@ struct smb2_file_all_info { /* data block encoding of response to level 18 */
 	char   FileName[1];
 } __packed; /* level 18 Query */
 
+struct smb2_file_basic_info { /* data block encoding of response to level 18 */
+	__le64 CreationTime;	/* Beginning of FILE_BASIC_INFO equivalent */
+	__le64 LastAccessTime;
+	__le64 LastWriteTime;
+	__le64 ChangeTime;
+	__le32 Attributes;
+	__u32  Pad1;		/* End of FILE_BASIC_INFO_INFO equivalent */
+} __packed;
+
 struct smb2_file_alt_name_info {
 	__le32 FileNameLength;
 	char FileName[0];
-- 
2.25.1

