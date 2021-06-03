Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2B8399A0A
	for <lists+linux-cifs@lfdr.de>; Thu,  3 Jun 2021 07:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbhFCFdB (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 3 Jun 2021 01:33:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:31423 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229663AbhFCFdB (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 3 Jun 2021 01:33:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1622698277;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=3GBQnqmxa6HwQVZOC/olgD9jsJm1ESvZD+EVLBsml1w=;
        b=fWmuG9cDlFZYLVc8o8CUCh0DB6ZdDmG+XZEBwtQONJnRUqw/LTRi1Z+M9oFgRqemlTLFM9
        E39RPhI+WDpYBNyIoE+FAt0X6gVA/btAohTLQR5/FFVt32evvmvR/HB1D/82BrJBJsEakb
        utcE8zobkxDYoksTXrmBwnPCc3sCA00=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-227-NqxItu13N2-Lw2FIvCimEA-1; Thu, 03 Jun 2021 01:31:13 -0400
X-MC-Unique: NqxItu13N2-Lw2FIvCimEA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D9B5801B14;
        Thu,  3 Jun 2021 05:31:12 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-178.bne.redhat.com [10.64.54.178])
        by smtp.corp.redhat.com (Postfix) with ESMTP id D5E98100760F;
        Thu,  3 Jun 2021 05:31:11 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: [PATCH] cifs: improve fallocate emulation
Date:   Thu,  3 Jun 2021 15:31:01 +1000
Message-Id: <20210603053101.1229297-2-lsahlber@redhat.com>
In-Reply-To: <20210603053101.1229297-1-lsahlber@redhat.com>
References: <20210603053101.1229297-1-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

RHBZ: 1866684

We don't have a real fallocate in the SMB2 protocol so we used to emulate fallocate
by simply switching the file to become non-sparse. But as that could potantially
consume a lot more data than we intended to fallocate (large sparse file and fallocating a thin
slice in the middle) we would only do this IFF the fallocate request was for virtually the entire file.

This patch improves this and starts allowing us to fallocate smaller chunks of a file by
overwriting the region with 0, for the parts that are unallocated.

The method used is to first query the server for FSCTL_QUERY_ALLOCATED_RANGES to find what
is unallocated in teh fallocate range and then to only overwrite-with-zero the unallocated ranges to fill
in the holes.
As overwriting-with-zero is different from just allocating blocks, and potentially much more expensive,
we limit this to only allow fallocate ranges up to 1Mb in size.

Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/smb2ops.c | 133 ++++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 133 insertions(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 21ef51d338e0..b68ba92893b6 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -3601,6 +3601,119 @@ static long smb3_punch_hole(struct file *file, struct cifs_tcon *tcon,
 	return rc;
 }
 
+static int smb3_simple_fallocate_write_range(unsigned int xid,
+					     struct cifs_tcon *tcon,
+					     struct cifsFileInfo *cfile,
+					     loff_t off, loff_t len,
+					     char *buf)
+{
+	struct cifs_io_parms io_parms = {0};
+	int nbytes;
+	struct kvec iov[2];
+
+	io_parms.netfid = cfile->fid.netfid;
+	io_parms.pid = current->tgid;
+	io_parms.tcon = tcon;
+	io_parms.persistent_fid = cfile->fid.persistent_fid;
+	io_parms.volatile_fid = cfile->fid.volatile_fid;
+	io_parms.offset = off;
+	io_parms.length = len;
+
+	/* iov[0] is reserved for smb header */
+	iov[1].iov_base = buf;
+	iov[1].iov_len = io_parms.length;
+	return SMB2_write(xid, &io_parms, &nbytes, iov, 1);
+}
+
+static int smb3_simple_fallocate_range(unsigned int xid,
+				       struct cifs_tcon *tcon,
+				       struct cifsFileInfo *cfile,
+				       loff_t off, loff_t len)
+{
+	struct file_allocated_range_buffer in_data, *out_data = NULL, *tmp_data;
+	u32 out_data_len;
+	char *buf = NULL;
+	loff_t l;
+	int rc;
+
+	in_data.file_offset = cpu_to_le64(off);
+	in_data.length = cpu_to_le64(len);
+	rc = SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
+			cfile->fid.volatile_fid,
+			FSCTL_QUERY_ALLOCATED_RANGES, true,
+			(char *)&in_data, sizeof(in_data),
+			1024 * sizeof(struct file_allocated_range_buffer),
+			(char **)&out_data, &out_data_len);
+	if (rc)
+		goto out;
+	/*
+	 * It is already all allocated
+	 */
+	if (out_data_len == 0)
+		goto out;
+
+	buf = kzalloc(1024 * 1024, GFP_KERNEL);
+	if (buf == NULL) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	tmp_data = out_data;
+	while (len) {
+		/*
+		 * The rest of the region is unmapped so write it all.
+		 */
+		if (out_data_len == 0) {
+			rc = smb3_simple_fallocate_write_range(xid, tcon,
+					       cfile, off, len, buf);
+			goto out;
+		}
+
+		if (out_data_len < sizeof(struct file_allocated_range_buffer)) {
+			rc = -EINVAL;
+			goto out;
+		}
+
+		if (off < le64_to_cpu(tmp_data->file_offset)) {
+			/*
+			 * We are at a hole. Write until the end of the region
+			 * or until the next allocated data,
+			 * whichever comes next.
+			 */
+			l = le64_to_cpu(tmp_data->file_offset) - off;
+			if (len < l)
+				l = len;
+			rc = smb3_simple_fallocate_write_range(xid, tcon,
+					       cfile, off, l, buf);
+			if (rc)
+				goto out;
+			off = off + l;
+			len = len - l;
+			if (len == 0)
+				goto out;
+		}
+		/*
+		 * We are at a section of allocated data, just skip forward
+		 * until the end of the data or the end of the region
+		 * we are supposed to fallocate, whichever comes first.
+		 */
+		l = le64_to_cpu(tmp_data->length);
+		if (len < l)
+			l = len;
+		off += l;
+		len -= l;
+
+		tmp_data = &tmp_data[1];
+		out_data_len -= sizeof(struct file_allocated_range_buffer);
+	}
+
+ out:
+	kfree(out_data);
+	kfree(buf);
+	return rc;
+}
+
+
 static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 			    loff_t off, loff_t len, bool keep_size)
 {
@@ -3661,6 +3774,26 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 	}
 
 	if ((keep_size == true) || (i_size_read(inode) >= off + len)) {
+		/*
+		 * At this point, we are trying to fallocate an internal
+		 * regions of a sparse file. Since smb2 does not have a
+		 * fallocate command we have two otions on how to emulate this.
+		 * We can either turn the entire file to become non-sparse
+		 * which we only do if the fallocate is for virtually
+		 * the whole file,  or we can overwrite the region with zeroes
+		 * using SMB2_write, which could be prohibitevly expensive
+		 * if len is large.
+		 */
+		/*
+		 * We are only trying to fallocate a small region so
+		 * just write it with zero.
+		 */
+		if (len <= 1024 * 1024) {
+			rc = smb3_simple_fallocate_range(xid, tcon, cfile,
+							 off, len);
+			goto out;
+		}
+
 		/*
 		 * Check if falloc starts within first few pages of file
 		 * and ends within a few pages of the end of file to
-- 
2.30.2

