Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9714E1D155
	for <lists+linux-cifs@lfdr.de>; Tue, 14 May 2019 23:33:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726513AbfENVd6 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 14 May 2019 17:33:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:39906 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726089AbfENVd6 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 14 May 2019 17:33:58 -0400
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 2BF78307D96D;
        Tue, 14 May 2019 21:33:58 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-44.bne.redhat.com [10.64.54.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8B4F85D6A6;
        Tue, 14 May 2019 21:33:57 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH] cifs: add support for SEEK_DATA and SEEK_HOLE
Date:   Wed, 15 May 2019 07:17:02 +1000
Message-Id: <20190514211702.19269-2-lsahlber@redhat.com>
In-Reply-To: <20190514211702.19269-1-lsahlber@redhat.com>
References: <20190514211702.19269-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.48]); Tue, 14 May 2019 21:33:58 +0000 (UTC)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/cifsfs.c   |  9 ++++++
 fs/cifs/cifsglob.h |  2 ++
 fs/cifs/smb2ops.c  | 88 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 99 insertions(+)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index b1a5fcfa3ce1..75fef9fb78d8 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -878,6 +878,9 @@ static ssize_t cifs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 static loff_t cifs_llseek(struct file *file, loff_t offset, int whence)
 {
+	struct cifsFileInfo *cfile = file->private_data;
+	struct cifs_tcon *tcon;
+
 	/*
 	 * whence == SEEK_END || SEEK_DATA || SEEK_HOLE => we must revalidate
 	 * the cached file length
@@ -909,6 +912,12 @@ static loff_t cifs_llseek(struct file *file, loff_t offset, int whence)
 		if (rc < 0)
 			return (loff_t)rc;
 	}
+	if (cfile && cfile->tlink) {
+		tcon = tlink_tcon(cfile->tlink);
+		if (tcon->ses->server->ops->llseek)
+			return tcon->ses->server->ops->llseek(file, tcon,
+							      offset, whence);
+	}
 	return generic_file_llseek(file, offset, whence);
 }
 
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 33c251b408aa..334ff5f9c3f3 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -497,6 +497,8 @@ struct smb_version_operations {
 	/* version specific fiemap implementation */
 	int (*fiemap)(struct cifs_tcon *tcon, struct cifsFileInfo *,
 		      struct fiemap_extent_info *, u64, u64);
+	/* version specific llseek implementation */
+	loff_t (*llseek)(struct file *, struct cifs_tcon *, loff_t, int);
 };
 
 struct smb_version_values {
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 542b50c0b292..e921e6511728 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -2922,6 +2922,90 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 	return rc;
 }
 
+static loff_t smb3_llseek(struct file *file, struct cifs_tcon *tcon, loff_t offset, int whence)
+{
+	struct cifsFileInfo *wrcfile, *cfile = file->private_data;
+	struct cifsInodeInfo *cifsi;
+	struct inode *inode;
+	int rc = 0;
+	struct file_allocated_range_buffer in_data, *out_data = NULL;
+	u32 out_data_len;
+	unsigned int xid;
+
+	if (whence != SEEK_HOLE && whence != SEEK_DATA)
+		return generic_file_llseek(file, offset, whence);
+
+	inode = d_inode(cfile->dentry);
+	cifsi = CIFS_I(inode);
+
+	if (offset < 0 || offset >= i_size_read(inode))
+		return -ENXIO;
+
+	xid = get_xid();
+	/*
+	 * We need to be sure that all dirty pages are written as they
+	 * might fill holes on the server.
+	 * Note that we also MUST flush any written pages since at least
+	 * some servers (Windows2016) will not reflect recent writes in
+	 * QUERY_ALLOCATED_RANGES until SMB2_flush is called.
+	 */
+	wrcfile = find_writable_file(cifsi, false);
+	if (wrcfile) {
+		filemap_write_and_wait(inode->i_mapping);
+		smb2_flush_file(xid, tcon, &wrcfile->fid);
+		cifsFileInfo_put(wrcfile);
+	}
+
+	if (!(cifsi->cifsAttrs & FILE_ATTRIBUTE_SPARSE_FILE)) {
+		if (whence == SEEK_HOLE)
+			offset = i_size_read(inode);
+		goto lseek_exit;
+	}
+
+	in_data.file_offset = cpu_to_le64(offset);
+	in_data.length = cpu_to_le64(i_size_read(inode));
+
+	rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
+			cfile->fid.volatile_fid,
+			FSCTL_QUERY_ALLOCATED_RANGES, true,
+			(char *)&in_data, sizeof(in_data),
+			sizeof(struct file_allocated_range_buffer),
+			(char **)&out_data, &out_data_len);
+	if (rc == -E2BIG)
+		rc = 0;
+	if (rc)
+		goto lseek_exit;
+
+	if (whence == SEEK_HOLE && out_data_len == 0)
+		goto lseek_exit;
+
+	if (whence == SEEK_DATA && out_data_len == 0) {
+		rc = -ENXIO;
+		goto lseek_exit;
+	}
+
+	if (out_data_len < sizeof(struct file_allocated_range_buffer)) {
+		rc = -EINVAL;
+		goto lseek_exit;
+	}
+	if (whence == SEEK_DATA) {
+		offset = le64_to_cpu(out_data->file_offset);
+		goto lseek_exit;
+	}
+	if (offset < le64_to_cpu(out_data->file_offset))
+		goto lseek_exit;
+
+	offset = le64_to_cpu(out_data->file_offset) + le64_to_cpu(out_data->length);
+
+ lseek_exit:
+	free_xid(xid);
+	kfree(out_data);
+	if (!rc)
+		return vfs_setpos(file, offset, inode->i_sb->s_maxbytes);
+	else
+		return rc;
+}
+
 static int smb3_fiemap(struct cifs_tcon *tcon,
 		       struct cifsFileInfo *cfile,
 		       struct fiemap_extent_info *fei, u64 start, u64 len)
@@ -4166,6 +4250,7 @@ struct smb_version_operations smb20_operations = {
 	.ioctl_query_info = smb2_ioctl_query_info,
 	.make_node = smb2_make_node,
 	.fiemap = smb3_fiemap,
+	.llseek = smb3_llseek,
 };
 
 struct smb_version_operations smb21_operations = {
@@ -4266,6 +4351,7 @@ struct smb_version_operations smb21_operations = {
 	.ioctl_query_info = smb2_ioctl_query_info,
 	.make_node = smb2_make_node,
 	.fiemap = smb3_fiemap,
+	.llseek = smb3_llseek,
 };
 
 struct smb_version_operations smb30_operations = {
@@ -4375,6 +4461,7 @@ struct smb_version_operations smb30_operations = {
 	.ioctl_query_info = smb2_ioctl_query_info,
 	.make_node = smb2_make_node,
 	.fiemap = smb3_fiemap,
+	.llseek = smb3_llseek,
 };
 
 struct smb_version_operations smb311_operations = {
@@ -4485,6 +4572,7 @@ struct smb_version_operations smb311_operations = {
 	.ioctl_query_info = smb2_ioctl_query_info,
 	.make_node = smb2_make_node,
 	.fiemap = smb3_fiemap,
+	.llseek = smb3_llseek,
 };
 
 struct smb_version_values smb20_values = {
-- 
2.13.6

