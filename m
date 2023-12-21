Return-Path: <linux-cifs+bounces-555-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E47C81B837
	for <lists+linux-cifs@lfdr.de>; Thu, 21 Dec 2023 14:42:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B9B03B22456
	for <lists+linux-cifs@lfdr.de>; Thu, 21 Dec 2023 13:42:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56B46138D23;
	Thu, 21 Dec 2023 13:26:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EuWr2JYs"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 886FE138758
	for <linux-cifs@vger.kernel.org>; Thu, 21 Dec 2023 13:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1703165163;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=vhj2Y8KYft067ELIpO6r3sU2SMWERPoSzBATHSVTvjY=;
	b=EuWr2JYs9KTYEahTzDuqELktmGCBnzTCb1VnJDib2oZY/h5mJh9jHD/kBFSuYllQRypKav
	rEifOy2BFmTMeNoT6cj92RAUwxNxpR6KsVmHFDI2KlV2Mbp5Eoosns0DhgXdzG+c7ZAWJc
	45vu8iWk1EHIQQ42mLfynquoGur1rOY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-571-_L6us540NiO7KrI-69BrLw-1; Thu, 21 Dec 2023 08:25:57 -0500
X-MC-Unique: _L6us540NiO7KrI-69BrLw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 6D2CA85A588;
	Thu, 21 Dec 2023 13:25:56 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 6DB541121313;
	Thu, 21 Dec 2023 13:25:53 +0000 (UTC)
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
	linux-kernel@vger.kernel.org
Subject: [PATCH v5 29/40] netfs: Implement unbuffered/DIO write support
Date: Thu, 21 Dec 2023 13:23:24 +0000
Message-ID: <20231221132400.1601991-30-dhowells@redhat.com>
In-Reply-To: <20231221132400.1601991-1-dhowells@redhat.com>
References: <20231221132400.1601991-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Implement support for unbuffered writes and direct I/O writes.  If the
write is misaligned with respect to the fscrypt block size, then RMW cycles
are performed if necessary.  DIO writes are a special case of unbuffered
writes with extra restriction imposed, such as block size alignment
requirements.

Also provide a field that can tell the code to add some extra space onto
the bounce buffer for use by the filesystem in the case of a
content-encrypted file.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/afs/inode.c               |   2 +-
 fs/netfs/Makefile            |   1 +
 fs/netfs/direct_write.c      | 166 +++++++++++++++++++++++++++++++++++
 fs/netfs/internal.h          |   6 ++
 fs/netfs/io.c                |   2 +-
 fs/netfs/main.c              |  12 +--
 fs/netfs/objects.c           |   6 +-
 fs/netfs/output.c            |  30 +++++++
 include/linux/netfs.h        |   4 +
 include/trace/events/netfs.h |   4 +-
 mm/filemap.c                 |   1 +
 11 files changed, 224 insertions(+), 10 deletions(-)
 create mode 100644 fs/netfs/direct_write.c

diff --git a/fs/afs/inode.c b/fs/afs/inode.c
index 6f375f0cf650..37485ae31471 100644
--- a/fs/afs/inode.c
+++ b/fs/afs/inode.c
@@ -250,7 +250,7 @@ static void afs_apply_status(struct afs_operation *op,
 		 * what's on the server.
 		 */
 		vnode->netfs.remote_i_size = status->size;
-		if (change_size) {
+		if (change_size || status->size > i_size_read(inode)) {
 			afs_set_i_size(vnode, status->size);
 			inode_set_ctime_to_ts(inode, t);
 			inode_set_atime_to_ts(inode, t);
diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
index e968ab1eca40..d4d1d799819e 100644
--- a/fs/netfs/Makefile
+++ b/fs/netfs/Makefile
@@ -4,6 +4,7 @@ netfs-y := \
 	buffered_read.o \
 	buffered_write.o \
 	direct_read.o \
+	direct_write.o \
 	io.o \
 	iterator.o \
 	locking.o \
diff --git a/fs/netfs/direct_write.c b/fs/netfs/direct_write.c
new file mode 100644
index 000000000000..bb0c2718f57b
--- /dev/null
+++ b/fs/netfs/direct_write.c
@@ -0,0 +1,166 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/* Unbuffered and direct write support.
+ *
+ * Copyright (C) 2023 Red Hat, Inc. All Rights Reserved.
+ * Written by David Howells (dhowells@redhat.com)
+ */
+
+#include <linux/export.h>
+#include <linux/uio.h>
+#include "internal.h"
+
+static void netfs_cleanup_dio_write(struct netfs_io_request *wreq)
+{
+	struct inode *inode = wreq->inode;
+	unsigned long long end = wreq->start + wreq->len;
+
+	if (!wreq->error &&
+	    i_size_read(inode) < end) {
+		if (wreq->netfs_ops->update_i_size)
+			wreq->netfs_ops->update_i_size(inode, end);
+		else
+			i_size_write(inode, end);
+	}
+}
+
+/*
+ * Perform an unbuffered write where we may have to do an RMW operation on an
+ * encrypted file.  This can also be used for direct I/O writes.
+ */
+ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *iter,
+					   struct netfs_group *netfs_group)
+{
+	struct netfs_io_request *wreq;
+	unsigned long long start = iocb->ki_pos;
+	unsigned long long end = start + iov_iter_count(iter);
+	ssize_t ret, n;
+	bool async = !is_sync_kiocb(iocb);
+
+	_enter("");
+
+	/* We're going to need a bounce buffer if what we transmit is going to
+	 * be different in some way to the source buffer, e.g. because it gets
+	 * encrypted/compressed or because it needs expanding to a block size.
+	 */
+	// TODO
+
+	_debug("uw %llx-%llx", start, end);
+
+	wreq = netfs_alloc_request(iocb->ki_filp->f_mapping, iocb->ki_filp,
+				   start, end - start,
+				   iocb->ki_flags & IOCB_DIRECT ?
+				   NETFS_DIO_WRITE : NETFS_UNBUFFERED_WRITE);
+	if (IS_ERR(wreq))
+		return PTR_ERR(wreq);
+
+	{
+		/* If this is an async op and we're not using a bounce buffer,
+		 * we have to save the source buffer as the iterator is only
+		 * good until we return.  In such a case, extract an iterator
+		 * to represent as much of the the output buffer as we can
+		 * manage.  Note that the extraction might not be able to
+		 * allocate a sufficiently large bvec array and may shorten the
+		 * request.
+		 */
+		if (async || user_backed_iter(iter)) {
+			n = netfs_extract_user_iter(iter, wreq->len, &wreq->iter, 0);
+			if (n < 0) {
+				ret = n;
+				goto out;
+			}
+			wreq->direct_bv = (struct bio_vec *)wreq->iter.bvec;
+			wreq->direct_bv_count = n;
+			wreq->direct_bv_unpin = iov_iter_extract_will_pin(iter);
+			wreq->len = iov_iter_count(&wreq->iter);
+		} else {
+			wreq->iter = *iter;
+		}
+
+		wreq->io_iter = wreq->iter;
+	}
+
+	/* Copy the data into the bounce buffer and encrypt it. */
+	// TODO
+
+	/* Dispatch the write. */
+	__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
+	if (async)
+		wreq->iocb = iocb;
+	wreq->cleanup = netfs_cleanup_dio_write;
+	ret = netfs_begin_write(wreq, is_sync_kiocb(iocb),
+				iocb->ki_flags & IOCB_DIRECT ?
+				netfs_write_trace_dio_write :
+				netfs_write_trace_unbuffered_write);
+	if (ret < 0) {
+		_debug("begin = %zd", ret);
+		goto out;
+	}
+
+	if (!async) {
+		trace_netfs_rreq(wreq, netfs_rreq_trace_wait_ip);
+		wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
+			    TASK_UNINTERRUPTIBLE);
+
+		ret = wreq->error;
+		_debug("waited = %zd", ret);
+		if (ret == 0) {
+			ret = wreq->transferred;
+			iocb->ki_pos += ret;
+		}
+	} else {
+		ret = -EIOCBQUEUED;
+	}
+
+out:
+	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
+	return ret;
+}
+
+/**
+ * netfs_unbuffered_write_iter - Unbuffered write to a file
+ * @iocb: IO state structure
+ * @from: iov_iter with data to write
+ *
+ * Do an unbuffered write to a file, writing the data directly to the server
+ * and not lodging the data in the pagecache.
+ *
+ * Return:
+ * * Negative error code if no data has been written at all of
+ *   vfs_fsync_range() failed for a synchronous write
+ * * Number of bytes written, even for truncated writes
+ */
+ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from)
+{
+	struct file *file = iocb->ki_filp;
+	struct inode *inode = file->f_mapping->host;
+	struct netfs_inode *ictx = netfs_inode(inode);
+	ssize_t ret;
+
+	_enter("%llx,%zx,%llx", iocb->ki_pos, iov_iter_count(from), i_size_read(inode));
+
+	trace_netfs_write_iter(iocb, from);
+
+	ret = netfs_start_io_direct(inode);
+	if (ret < 0)
+		return ret;
+	ret = generic_write_checks(iocb, from);
+	if (ret < 0)
+		goto out;
+	ret = file_remove_privs(file);
+	if (ret < 0)
+		goto out;
+	ret = file_update_time(file);
+	if (ret < 0)
+		goto out;
+	ret = kiocb_invalidate_pages(iocb, iov_iter_count(from));
+	if (ret < 0)
+		goto out;
+
+	fscache_invalidate(netfs_i_cookie(ictx), NULL, i_size_read(inode),
+			   FSCACHE_INVAL_DIO_WRITE);
+	ret = netfs_unbuffered_write_iter_locked(iocb, from, NULL);
+out:
+	netfs_end_io_direct(inode);
+	return ret;
+}
+EXPORT_SYMBOL(netfs_unbuffered_write_iter);
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 886c2e8f841f..2de4f826dbe4 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -26,6 +26,12 @@ void netfs_rreq_unlock_folios(struct netfs_io_request *rreq);
 int netfs_prefetch_for_write(struct file *file, struct folio *folio,
 			     size_t offset, size_t len);
 
+/*
+ * direct_write.c
+ */
+ssize_t netfs_unbuffered_write_iter_locked(struct kiocb *iocb, struct iov_iter *iter,
+					   struct netfs_group *netfs_group);
+
 /*
  * io.c
  */
diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index c972415c8aad..01c7ff27228e 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -645,7 +645,7 @@ static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
 
 	subreq->debug_index	= (*_debug_index)++;
 	subreq->start		= rreq->start + rreq->submitted;
-	subreq->len		= rreq->len   - rreq->submitted;
+	subreq->len		= io_iter->count;
 
 	_debug("slice %llx,%zx,%zx", subreq->start, subreq->len, rreq->submitted);
 	list_add_tail(&subreq->rreq_link, &rreq->subrequests);
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index abb8857486ee..8e4db9ff40c4 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -26,11 +26,13 @@ LIST_HEAD(netfs_io_requests);
 DEFINE_SPINLOCK(netfs_proc_lock);
 
 static const char *netfs_origins[nr__netfs_io_origin] = {
-	[NETFS_READAHEAD]	= "RA",
-	[NETFS_READPAGE]	= "RP",
-	[NETFS_READ_FOR_WRITE]	= "RW",
-	[NETFS_WRITEBACK]	= "WB",
-	[NETFS_DIO_READ]	= "DR",
+	[NETFS_READAHEAD]		= "RA",
+	[NETFS_READPAGE]		= "RP",
+	[NETFS_READ_FOR_WRITE]		= "RW",
+	[NETFS_WRITEBACK]		= "WB",
+	[NETFS_UNBUFFERED_WRITE]	= "UW",
+	[NETFS_DIO_READ]		= "DR",
+	[NETFS_DIO_WRITE]		= "DW",
 };
 
 /*
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 7153f24e8034..93f1d7431199 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -20,8 +20,10 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	struct inode *inode = file ? file_inode(file) : mapping->host;
 	struct netfs_inode *ctx = netfs_inode(inode);
 	struct netfs_io_request *rreq;
-	bool is_dio = (origin == NETFS_DIO_READ);
-	bool cached = is_dio && netfs_is_cache_enabled(ctx);
+	bool is_unbuffered = (origin == NETFS_UNBUFFERED_WRITE ||
+			      origin == NETFS_DIO_READ ||
+			      origin == NETFS_DIO_WRITE);
+	bool cached = !is_unbuffered && netfs_is_cache_enabled(ctx);
 	int ret;
 
 	rreq = kzalloc(ctx->ops->io_request_size ?: sizeof(struct netfs_io_request),
diff --git a/fs/netfs/output.c b/fs/netfs/output.c
index 2ad0fd8c32be..560cbcea0c0a 100644
--- a/fs/netfs/output.c
+++ b/fs/netfs/output.c
@@ -74,11 +74,21 @@ static void netfs_write_terminated(struct netfs_io_request *wreq, bool was_async
 {
 	struct netfs_io_subrequest *subreq;
 	struct netfs_inode *ctx = netfs_inode(wreq->inode);
+	size_t transferred = 0;
 
 	_enter("R=%x[]", wreq->debug_id);
 
 	trace_netfs_rreq(wreq, netfs_rreq_trace_write_done);
 
+	list_for_each_entry(subreq, &wreq->subrequests, rreq_link) {
+		if (subreq->error || subreq->transferred == 0)
+			break;
+		transferred += subreq->transferred;
+		if (subreq->transferred < subreq->len)
+			break;
+	}
+	wreq->transferred = transferred;
+
 	list_for_each_entry(subreq, &wreq->subrequests, rreq_link) {
 		if (!subreq->error)
 			continue;
@@ -110,11 +120,28 @@ static void netfs_write_terminated(struct netfs_io_request *wreq, bool was_async
 
 	wreq->cleanup(wreq);
 
+	if (wreq->origin == NETFS_DIO_WRITE &&
+	    wreq->mapping->nrpages) {
+		pgoff_t first = wreq->start >> PAGE_SHIFT;
+		pgoff_t last = (wreq->start + wreq->transferred - 1) >> PAGE_SHIFT;
+		invalidate_inode_pages2_range(wreq->mapping, first, last);
+	}
+
+	if (wreq->origin == NETFS_DIO_WRITE)
+		inode_dio_end(wreq->inode);
+
 	_debug("finished");
 	trace_netfs_rreq(wreq, netfs_rreq_trace_wake_ip);
 	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &wreq->flags);
 	wake_up_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS);
 
+	if (wreq->iocb) {
+		wreq->iocb->ki_pos += transferred;
+		if (wreq->iocb->ki_complete)
+			wreq->iocb->ki_complete(
+				wreq->iocb, wreq->error ? wreq->error : transferred);
+	}
+
 	netfs_clear_subrequests(wreq, was_async);
 	netfs_put_request(wreq, was_async, netfs_rreq_trace_put_complete);
 }
@@ -329,6 +356,9 @@ int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
 		return -EIO;
 	}
 
+	if (wreq->origin == NETFS_DIO_WRITE)
+		inode_dio_begin(wreq->inode);
+
 	wreq->io_iter = wreq->iter;
 
 	/* ->outstanding > 0 carries a ref */
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 784afaff8c78..47efa8596527 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -138,6 +138,7 @@ struct netfs_inode {
 	loff_t			remote_i_size;	/* Size of the remote file */
 	unsigned long		flags;
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
+#define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
 };
 
 /*
@@ -226,7 +227,9 @@ enum netfs_io_origin {
 	NETFS_READPAGE,			/* This read is a synchronous read */
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
 	NETFS_WRITEBACK,		/* This write was triggered by writepages */
+	NETFS_UNBUFFERED_WRITE,		/* This is an unbuffered write */
 	NETFS_DIO_READ,			/* This is a direct I/O read */
+	NETFS_DIO_WRITE,		/* This is a direct I/O write */
 	nr__netfs_io_origin
 } __mode(byte);
 
@@ -380,6 +383,7 @@ ssize_t netfs_unbuffered_read_iter(struct kiocb *iocb, struct iov_iter *iter);
 /* High-level write API */
 ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 			    struct netfs_group *netfs_group);
+ssize_t netfs_unbuffered_write_iter(struct kiocb *iocb, struct iov_iter *from);
 
 /* Address operations API */
 struct readahead_control;
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 5a4edadf0e59..914a24b03d08 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -33,7 +33,9 @@
 	EM(NETFS_READPAGE,			"RP")		\
 	EM(NETFS_READ_FOR_WRITE,		"RW")		\
 	EM(NETFS_WRITEBACK,			"WB")		\
-	E_(NETFS_DIO_READ,			"DR")
+	EM(NETFS_UNBUFFERED_WRITE,		"UW")		\
+	EM(NETFS_DIO_READ,			"DR")		\
+	E_(NETFS_DIO_WRITE,			"DW")
 
 #define netfs_rreq_traces					\
 	EM(netfs_rreq_trace_assess,		"ASSESS ")	\
diff --git a/mm/filemap.c b/mm/filemap.c
index 1c5271ed0cc0..73626eb323f3 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -2706,6 +2706,7 @@ int kiocb_invalidate_pages(struct kiocb *iocb, size_t count)
 	return invalidate_inode_pages2_range(mapping, pos >> PAGE_SHIFT,
 					     end >> PAGE_SHIFT);
 }
+EXPORT_SYMBOL_GPL(kiocb_invalidate_pages);
 
 /**
  * generic_file_read_iter - generic filesystem read routine


