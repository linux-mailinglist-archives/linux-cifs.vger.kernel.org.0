Return-Path: <linux-cifs+bounces-364-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 909DA8094AC
	for <lists+linux-cifs@lfdr.de>; Thu,  7 Dec 2023 22:38:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AFBE11C21053
	for <lists+linux-cifs@lfdr.de>; Thu,  7 Dec 2023 21:38:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCCE257881;
	Thu,  7 Dec 2023 21:27:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y/aiDUGy"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91486210C
	for <linux-cifs@vger.kernel.org>; Thu,  7 Dec 2023 13:25:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701984306;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=k4HAFHu9OSz/FL7gRMcGAXT680m4oDbQX9I9K1yPxLs=;
	b=Y/aiDUGyVR1KLa5R/wtcFZQ3v2B6Yp4WLZcnFMnGdU7R5JQp/JTSs4p9xq3Bzd2FG2VpC/
	FkqmOmmUZo1lEksbKhjv7wcpTfgqFzQ5rGfQNH0TLGul/nHgzc0yndc9bz0XguB/lYfNLo
	avIko7H9Kg1VaDwMRjpyVoXwicyFgrM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-621-92enf5t1NDi-pAifyCbPOw-1; Thu, 07 Dec 2023 16:25:00 -0500
X-MC-Unique: 92enf5t1NDi-pAifyCbPOw-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id CEE6C85A596;
	Thu,  7 Dec 2023 21:24:58 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A4BF58174;
	Thu,  7 Dec 2023 21:24:55 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>,
	Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	Christian Brauner <christian@brauner.io>,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v3 48/59] cifs: Share server EOF pos with netfslib
Date: Thu,  7 Dec 2023 21:21:55 +0000
Message-ID: <20231207212206.1379128-49-dhowells@redhat.com>
In-Reply-To: <20231207212206.1379128-1-dhowells@redhat.com>
References: <20231207212206.1379128-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

Use cifsi->netfs_ctx.remote_i_size instead of cifsi->server_eof so that
netfslib can refer to it to.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/cifsfs.c   | 17 ++++++++++++++---
 fs/smb/client/cifsglob.h |  1 -
 fs/smb/client/file.c     |  8 ++++----
 fs/smb/client/inode.c    |  8 +++++---
 fs/smb/client/smb2ops.c  | 18 +++++++++++++-----
 5 files changed, 36 insertions(+), 16 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 07cd88897c33..078cff36cd2e 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -395,7 +395,7 @@ cifs_alloc_inode(struct super_block *sb)
 	spin_lock_init(&cifs_inode->writers_lock);
 	cifs_inode->writers = 0;
 	cifs_inode->netfs.inode.i_blkbits = 14;  /* 2**14 = CIFS_MAX_MSGSIZE */
-	cifs_inode->server_eof = 0;
+	cifs_inode->netfs.remote_i_size = 0;
 	cifs_inode->uniqueid = 0;
 	cifs_inode->createtime = 0;
 	cifs_inode->epoch = 0;
@@ -1377,6 +1377,7 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	struct inode *src_inode = file_inode(src_file);
 	struct inode *target_inode = file_inode(dst_file);
 	struct cifsInodeInfo *src_cifsi = CIFS_I(src_inode);
+	struct cifsInodeInfo *target_cifsi = CIFS_I(target_inode);
 	struct cifsFileInfo *smb_file_src;
 	struct cifsFileInfo *smb_file_target;
 	struct cifs_tcon *src_tcon;
@@ -1425,7 +1426,7 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	 * Advance the EOF marker after the flush above to the end of the range
 	 * if it's short of that.
 	 */
-	if (src_cifsi->server_eof < off + len) {
+	if (src_cifsi->netfs.remote_i_size < off + len) {
 		rc = cifs_precopy_set_eof(src_inode, src_cifsi, src_tcon, xid, off + len);
 		if (rc < 0)
 			goto unlock;
@@ -1449,12 +1450,22 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 	/* Discard all the folios that overlap the destination region. */
 	truncate_inode_pages_range(&target_inode->i_data, fstart, fend);
 
+	fscache_invalidate(cifs_inode_cookie(target_inode), NULL,
+			   i_size_read(target_inode), 0);
+
 	rc = file_modified(dst_file);
 	if (!rc) {
 		rc = target_tcon->ses->server->ops->copychunk_range(xid,
 			smb_file_src, smb_file_target, off, len, destoff);
-		if (rc > 0 && destoff + rc > i_size_read(target_inode))
+		if (rc > 0 && destoff + rc > i_size_read(target_inode)) {
 			truncate_setsize(target_inode, destoff + rc);
+			netfs_resize_file(&target_cifsi->netfs,
+					  i_size_read(target_inode), true);
+			fscache_resize_cookie(cifs_inode_cookie(target_inode),
+					      i_size_read(target_inode));
+		}
+		if (rc > 0 && destoff + rc > target_cifsi->netfs.zero_point)
+			target_cifsi->netfs.zero_point = destoff + rc;
 	}
 
 	file_accessed(src_file);
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 65820f40f7f4..ed456c6a2752 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1539,7 +1539,6 @@ struct cifsInodeInfo {
 	spinlock_t writers_lock;
 	unsigned int writers;		/* Number of writers on this inode */
 	unsigned long time;		/* jiffies of last update of inode */
-	u64  server_eof;		/* current file size on server -- protected by i_lock */
 	u64  uniqueid;			/* server inode number */
 	u64  createtime;		/* creation time on server */
 	__u8 lease_key[SMB2_LEASE_KEY_SIZE];	/* lease key for this inode */
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index ca697bda4666..1074d56573b7 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2118,8 +2118,8 @@ cifs_update_eof(struct cifsInodeInfo *cifsi, loff_t offset,
 {
 	loff_t end_of_write = offset + bytes_written;
 
-	if (end_of_write > cifsi->server_eof)
-		cifsi->server_eof = end_of_write;
+	if (end_of_write > cifsi->netfs.remote_i_size)
+		netfs_resize_file(&cifsi->netfs, end_of_write, true);
 }
 
 static ssize_t
@@ -3245,8 +3245,8 @@ cifs_uncached_writev_complete(struct work_struct *work)
 
 	spin_lock(&inode->i_lock);
 	cifs_update_eof(cifsi, wdata->offset, wdata->bytes);
-	if (cifsi->server_eof > inode->i_size)
-		i_size_write(inode, cifsi->server_eof);
+	if (cifsi->netfs.remote_i_size > inode->i_size)
+		i_size_write(inode, cifsi->netfs.remote_i_size);
 	spin_unlock(&inode->i_lock);
 
 	complete(&wdata->done);
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 09c5c0f5c96e..e8afdc969226 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -104,7 +104,7 @@ cifs_revalidate_cache(struct inode *inode, struct cifs_fattr *fattr)
 	fattr->cf_mtime = timestamp_truncate(fattr->cf_mtime, inode);
 	mtime = inode_get_mtime(inode);
 	if (timespec64_equal(&mtime, &fattr->cf_mtime) &&
-	    cifs_i->server_eof == fattr->cf_eof) {
+	    cifs_i->netfs.remote_i_size == fattr->cf_eof) {
 		cifs_dbg(FYI, "%s: inode %llu is unchanged\n",
 			 __func__, cifs_i->uniqueid);
 		return;
@@ -193,7 +193,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 	else
 		clear_bit(CIFS_INO_DELETE_PENDING, &cifs_i->flags);
 
-	cifs_i->server_eof = fattr->cf_eof;
+	cifs_i->netfs.remote_i_size = fattr->cf_eof;
 	/*
 	 * Can't safely change the file size here if the client is writing to
 	 * it due to potential races.
@@ -2827,7 +2827,7 @@ cifs_set_file_size(struct inode *inode, struct iattr *attrs,
 
 set_size_out:
 	if (rc == 0) {
-		cifsInode->server_eof = attrs->ia_size;
+		netfs_resize_file(&cifsInode->netfs, attrs->ia_size, true);
 		cifs_setsize(inode, attrs->ia_size);
 		/*
 		 * i_blocks is not related to (i_size / i_blksize), but instead
@@ -2980,6 +2980,7 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 	if ((attrs->ia_valid & ATTR_SIZE) &&
 	    attrs->ia_size != i_size_read(inode)) {
 		truncate_setsize(inode, attrs->ia_size);
+		netfs_resize_file(&cifsInode->netfs, attrs->ia_size, true);
 		fscache_resize_cookie(cifs_inode_cookie(inode), attrs->ia_size);
 	}
 
@@ -3179,6 +3180,7 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	if ((attrs->ia_valid & ATTR_SIZE) &&
 	    attrs->ia_size != i_size_read(inode)) {
 		truncate_setsize(inode, attrs->ia_size);
+		netfs_resize_file(&cifsInode->netfs, attrs->ia_size, true);
 		fscache_resize_cookie(cifs_inode_cookie(inode), attrs->ia_size);
 	}
 
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 3fa80c1420d4..ebc0f0246126 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3351,6 +3351,9 @@ static long smb3_zero_range(struct file *file, struct cifs_tcon *tcon,
 				  cfile->fid.volatile_fid, cfile->pid, &eof);
 		if (rc >= 0) {
 			truncate_setsize(inode, new_size);
+			netfs_resize_file(&cifsi->netfs, new_size, true);
+			if (offset < cifsi->netfs.zero_point)
+				cifsi->netfs.zero_point = offset;
 			fscache_resize_cookie(cifs_inode_cookie(inode), new_size);
 		}
 	}
@@ -3574,7 +3577,7 @@ static long smb3_simple_falloc(struct file *file, struct cifs_tcon *tcon,
 		rc = SMB2_set_eof(xid, tcon, cfile->fid.persistent_fid,
 				  cfile->fid.volatile_fid, cfile->pid, &eof);
 		if (rc == 0) {
-			cifsi->server_eof = off + len;
+			netfs_resize_file(&cifsi->netfs, off + len, true);
 			cifs_setsize(inode, off + len);
 			cifs_truncate_page(inode->i_mapping, inode->i_size);
 			truncate_setsize(inode, off + len);
@@ -3666,8 +3669,9 @@ static long smb3_collapse_range(struct file *file, struct cifs_tcon *tcon,
 	int rc;
 	unsigned int xid;
 	struct inode *inode = file_inode(file);
-	struct cifsFileInfo *cfile = file->private_data;
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
+	struct cifsFileInfo *cfile = file->private_data;
+	struct netfs_inode *ictx = &cifsi->netfs;
 	__le64 eof;
 	loff_t old_eof;
 
@@ -3688,6 +3692,7 @@ static long smb3_collapse_range(struct file *file, struct cifs_tcon *tcon,
 		goto out_2;
 
 	truncate_pagecache_range(inode, off, old_eof);
+	ictx->zero_point = old_eof;
 
 	rc = smb2_copychunk_range(xid, cfile, cfile, off + len,
 				  old_eof - off - len, off);
@@ -3702,9 +3707,10 @@ static long smb3_collapse_range(struct file *file, struct cifs_tcon *tcon,
 
 	rc = 0;
 
-	cifsi->server_eof = i_size_read(inode) - len;
-	truncate_setsize(inode, cifsi->server_eof);
-	fscache_resize_cookie(cifs_inode_cookie(inode), cifsi->server_eof);
+	truncate_setsize(inode, eof);
+	netfs_resize_file(&cifsi->netfs, eof, true);
+	ictx->zero_point = eof;
+	fscache_resize_cookie(cifs_inode_cookie(inode), eof);
 out_2:
 	filemap_invalidate_unlock(inode->i_mapping);
  out:
@@ -3720,6 +3726,7 @@ static long smb3_insert_range(struct file *file, struct cifs_tcon *tcon,
 	unsigned int xid;
 	struct cifsFileInfo *cfile = file->private_data;
 	struct inode *inode = file_inode(file);
+	struct cifsInodeInfo *cifsi = CIFS_I(inode);
 	__le64 eof;
 	__u64  count, old_eof;
 
@@ -3748,6 +3755,7 @@ static long smb3_insert_range(struct file *file, struct cifs_tcon *tcon,
 		goto out_2;
 
 	truncate_setsize(inode, old_eof + len);
+	netfs_resize_file(&cifsi->netfs, i_size_read(inode), true);
 	fscache_resize_cookie(cifs_inode_cookie(inode), i_size_read(inode));
 
 	rc = smb2_copychunk_range(xid, cfile, cfile, off, count, off + len);


