Return-Path: <linux-cifs+bounces-443-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3E081175A
	for <lists+linux-cifs@lfdr.de>; Wed, 13 Dec 2023 16:38:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D430E1C210D0
	for <lists+linux-cifs@lfdr.de>; Wed, 13 Dec 2023 15:38:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 897D58184D;
	Wed, 13 Dec 2023 15:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HxA1pocf"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E34119AE
	for <linux-cifs@vger.kernel.org>; Wed, 13 Dec 2023 07:26:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702481204;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=DMHsdIxXvUk6Wbv0Mmvq6RSRYJtgXuGRYMsHtscd1pE=;
	b=HxA1pocfarDTlyKebJaeSmwWER4pir9XRdQxJosxGBFRRlnZH2iqm/8amZT4gmfuHNJlY8
	eUzz5BMSiKyd0o0U1CvNMZYzcg7+B39fy61P5Pvypl7YFWWVVetO9hg5SUN+jQrJwLnBAk
	+GiEvtttaq49Q6MYhzjJd5HEIHKNBHc=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-694-Er9oBpO1OKyr_sJ9-Ser6g-1; Wed,
 13 Dec 2023 10:26:41 -0500
X-MC-Unique: Er9oBpO1OKyr_sJ9-Ser6g-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id DE2AF3811F29;
	Wed, 13 Dec 2023 15:26:38 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.2])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 84755492BC6;
	Wed, 13 Dec 2023 15:26:35 +0000 (UTC)
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
Subject: [PATCH v4 36/39] netfs: Implement a write-through caching option
Date: Wed, 13 Dec 2023 15:23:46 +0000
Message-ID: <20231213152350.431591-37-dhowells@redhat.com>
In-Reply-To: <20231213152350.431591-1-dhowells@redhat.com>
References: <20231213152350.431591-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

Provide a flag whereby a filesystem may request that cifs_perform_write()
perform write-through caching.  This involves putting pages directly into
writeback rather than dirty and attaching them to a write operation as we
go.

Further, the writes being made are limited to the byte range being written
rather than whole folios being written.  This can be used by cifs, for
example, to deal with strict byte-range locking.

This can't be used with content encryption as that may require expansion of
the write RPC beyond the write being made.

This doesn't affect writes via mmap - those are written back in the normal
way; similarly failed writethrough writes are marked dirty and left to
writeback to retry.  Another option would be to simply invalidate them, but
the contents can be simultaneously accessed by read() and through mmap.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/buffered_write.c    | 69 +++++++++++++++++++++++----
 fs/netfs/internal.h          |  3 ++
 fs/netfs/main.c              |  1 +
 fs/netfs/objects.c           |  1 +
 fs/netfs/output.c            | 90 ++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h        |  2 +
 include/trace/events/netfs.h |  8 +++-
 7 files changed, 162 insertions(+), 12 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 8e0ebb7175a4..dce6995fb644 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -26,6 +26,8 @@ enum netfs_how_to_modify {
 	NETFS_FLUSH_CONTENT,		/* Flush incompatible content. */
 };
 
+static void netfs_cleanup_buffered_write(struct netfs_io_request *wreq);
+
 static void netfs_set_group(struct folio *folio, struct netfs_group *netfs_group)
 {
 	if (netfs_group && !folio_get_private(folio))
@@ -133,6 +135,14 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	struct inode *inode = file_inode(file);
 	struct address_space *mapping = inode->i_mapping;
 	struct netfs_inode *ctx = netfs_inode(inode);
+	struct writeback_control wbc = {
+		.sync_mode	= WB_SYNC_NONE,
+		.for_sync	= true,
+		.nr_to_write	= LONG_MAX,
+		.range_start	= iocb->ki_pos,
+		.range_end	= iocb->ki_pos + iter->count,
+	};
+	struct netfs_io_request *wreq = NULL;
 	struct netfs_folio *finfo;
 	struct folio *folio;
 	enum netfs_how_to_modify howto;
@@ -143,6 +153,30 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	size_t max_chunk = PAGE_SIZE << MAX_PAGECACHE_ORDER;
 	bool maybe_trouble = false;
 
+	if (unlikely(test_bit(NETFS_ICTX_WRITETHROUGH, &ctx->flags) ||
+		     iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC))
+	    ) {
+		if (pos < i_size_read(inode)) {
+			ret = filemap_write_and_wait_range(mapping, pos, pos + iter->count);
+			if (ret < 0) {
+				goto out;
+			}
+		}
+
+		wbc_attach_fdatawrite_inode(&wbc, mapping->host);
+
+		wreq = netfs_begin_writethrough(iocb, iter->count);
+		if (IS_ERR(wreq)) {
+			wbc_detach_inode(&wbc);
+			ret = PTR_ERR(wreq);
+			wreq = NULL;
+			goto out;
+		}
+		if (!is_sync_kiocb(iocb))
+			wreq->iocb = iocb;
+		wreq->cleanup = netfs_cleanup_buffered_write;
+	}
+
 	do {
 		size_t flen;
 		size_t offset;	/* Offset into pagecache folio */
@@ -315,7 +349,25 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 		}
 		written += copied;
 
-		folio_mark_dirty(folio);
+		if (likely(!wreq)) {
+			folio_mark_dirty(folio);
+		} else {
+			if (folio_test_dirty(folio))
+				/* Sigh.  mmap. */
+				folio_clear_dirty_for_io(folio);
+			/* We make multiple writes to the folio... */
+			if (!folio_test_writeback(folio)) {
+				folio_wait_fscache(folio);
+				folio_start_writeback(folio);
+				folio_start_fscache(folio);
+				if (wreq->iter.count == 0)
+					trace_netfs_folio(folio, netfs_folio_trace_wthru);
+				else
+					trace_netfs_folio(folio, netfs_folio_trace_wthru_plus);
+			}
+			netfs_advance_writethrough(wreq, copied,
+						   offset + copied == flen);
+		}
 	retry:
 		folio_unlock(folio);
 		folio_put(folio);
@@ -325,17 +377,14 @@ ssize_t netfs_perform_write(struct kiocb *iocb, struct iov_iter *iter,
 	} while (iov_iter_count(iter));
 
 out:
-	if (likely(written)) {
-		/* Flush and wait for a write that requires immediate synchronisation. */
-		if (iocb->ki_flags & (IOCB_DSYNC | IOCB_SYNC)) {
-			_debug("dsync");
-			ret = filemap_fdatawait_range(mapping, iocb->ki_pos,
-						      iocb->ki_pos + written);
-		}
-
-		iocb->ki_pos += written;
+	if (unlikely(wreq)) {
+		ret = netfs_end_writethrough(wreq, iocb);
+		wbc_detach_inode(&wbc);
+		if (ret == -EIOCBQUEUED)
+			return ret;
 	}
 
+	iocb->ki_pos += written;
 	_leave(" = %zd [%zd]", written, ret);
 	return written ? written : ret;
 
diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index fe72280b0f30..b3749d6ec1ff 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -101,6 +101,9 @@ static inline void netfs_see_request(struct netfs_io_request *rreq,
  */
 int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
 		      enum netfs_write_trace what);
+struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len);
+int netfs_advance_writethrough(struct netfs_io_request *wreq, size_t copied, bool to_page_end);
+int netfs_end_writethrough(struct netfs_io_request *wreq, struct kiocb *iocb);
 
 /*
  * stats.c
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index 8d5ee0f56f28..7139397931b7 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -33,6 +33,7 @@ static const char *netfs_origins[nr__netfs_io_origin] = {
 	[NETFS_READPAGE]		= "RP",
 	[NETFS_READ_FOR_WRITE]		= "RW",
 	[NETFS_WRITEBACK]		= "WB",
+	[NETFS_WRITETHROUGH]		= "WT",
 	[NETFS_LAUNDER_WRITE]		= "LW",
 	[NETFS_UNBUFFERED_WRITE]	= "UW",
 	[NETFS_DIO_READ]		= "DR",
diff --git a/fs/netfs/objects.c b/fs/netfs/objects.c
index 16252cc4576e..37626328577e 100644
--- a/fs/netfs/objects.c
+++ b/fs/netfs/objects.c
@@ -42,6 +42,7 @@ struct netfs_io_request *netfs_alloc_request(struct address_space *mapping,
 	rreq->debug_id	= atomic_inc_return(&debug_ids);
 	xa_init(&rreq->bounce);
 	INIT_LIST_HEAD(&rreq->subrequests);
+	INIT_WORK(&rreq->work, NULL);
 	refcount_set(&rreq->ref, 1);
 
 	__set_bit(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
diff --git a/fs/netfs/output.c b/fs/netfs/output.c
index cc9065733b42..625eb68f3e5a 100644
--- a/fs/netfs/output.c
+++ b/fs/netfs/output.c
@@ -386,3 +386,93 @@ int netfs_begin_write(struct netfs_io_request *wreq, bool may_wait,
 		    TASK_UNINTERRUPTIBLE);
 	return wreq->error;
 }
+
+/*
+ * Begin a write operation for writing through the pagecache.
+ */
+struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len)
+{
+	struct netfs_io_request *wreq;
+	struct file *file = iocb->ki_filp;
+
+	wreq = netfs_alloc_request(file->f_mapping, file, iocb->ki_pos, len,
+				   NETFS_WRITETHROUGH);
+	if (IS_ERR(wreq))
+		return wreq;
+
+	trace_netfs_write(wreq, netfs_write_trace_writethrough);
+
+	__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
+	iov_iter_xarray(&wreq->iter, ITER_SOURCE, &wreq->mapping->i_pages, wreq->start, 0);
+	wreq->io_iter = wreq->iter;
+
+	/* ->outstanding > 0 carries a ref */
+	netfs_get_request(wreq, netfs_rreq_trace_get_for_outstanding);
+	atomic_set(&wreq->nr_outstanding, 1);
+	return wreq;
+}
+
+static void netfs_submit_writethrough(struct netfs_io_request *wreq, bool final)
+{
+	struct netfs_inode *ictx = netfs_inode(wreq->inode);
+	unsigned long long start;
+	size_t len;
+
+	if (!test_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags))
+		return;
+
+	start = wreq->start + wreq->submitted;
+	len = wreq->iter.count - wreq->submitted;
+	if (!final) {
+		len /= wreq->wsize; /* Round to number of maximum packets */
+		len *= wreq->wsize;
+	}
+
+	ictx->ops->create_write_requests(wreq, start, len);
+	wreq->submitted += len;
+}
+
+/*
+ * Advance the state of the write operation used when writing through the
+ * pagecache.  Data has been copied into the pagecache that we need to append
+ * to the request.  If we've added more than wsize then we need to create a new
+ * subrequest.
+ */
+int netfs_advance_writethrough(struct netfs_io_request *wreq, size_t copied, bool to_page_end)
+{
+	_enter("ic=%zu sb=%zu ws=%u cp=%zu tp=%u",
+	       wreq->iter.count, wreq->submitted, wreq->wsize, copied, to_page_end);
+
+	wreq->iter.count += copied;
+	wreq->io_iter.count += copied;
+	if (to_page_end && wreq->io_iter.count - wreq->submitted >= wreq->wsize)
+		netfs_submit_writethrough(wreq, false);
+
+	return wreq->error;
+}
+
+/*
+ * End a write operation used when writing through the pagecache.
+ */
+int netfs_end_writethrough(struct netfs_io_request *wreq, struct kiocb *iocb)
+{
+	int ret = -EIOCBQUEUED;
+
+	_enter("ic=%zu sb=%zu ws=%u",
+	       wreq->iter.count, wreq->submitted, wreq->wsize);
+
+	if (wreq->submitted < wreq->io_iter.count)
+		netfs_submit_writethrough(wreq, true);
+
+	if (atomic_dec_and_test(&wreq->nr_outstanding))
+		netfs_write_terminated(wreq, false);
+
+	if (is_sync_kiocb(iocb)) {
+		wait_on_bit(&wreq->flags, NETFS_RREQ_IN_PROGRESS,
+			    TASK_UNINTERRUPTIBLE);
+		ret = wreq->error;
+	}
+
+	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
+	return ret;
+}
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index a7c2cb856e81..fc77f7be220a 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -139,6 +139,7 @@ struct netfs_inode {
 	unsigned long		flags;
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 #define NETFS_ICTX_UNBUFFERED	1		/* I/O should not use the pagecache */
+#define NETFS_ICTX_WRITETHROUGH	2		/* Write-through caching */
 };
 
 /*
@@ -227,6 +228,7 @@ enum netfs_io_origin {
 	NETFS_READPAGE,			/* This read is a synchronous read */
 	NETFS_READ_FOR_WRITE,		/* This read is to prepare a write */
 	NETFS_WRITEBACK,		/* This write was triggered by writepages */
+	NETFS_WRITETHROUGH,		/* This write was made by netfs_perform_write() */
 	NETFS_LAUNDER_WRITE,		/* This is triggered by ->launder_folio() */
 	NETFS_UNBUFFERED_WRITE,		/* This is an unbuffered write */
 	NETFS_DIO_READ,			/* This is a direct I/O read */
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index cc998798e20a..447a8c21cf57 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -27,13 +27,15 @@
 	EM(netfs_write_trace_dio_write,		"DIO-WRITE")	\
 	EM(netfs_write_trace_launder,		"LAUNDER  ")	\
 	EM(netfs_write_trace_unbuffered_write,	"UNB-WRITE")	\
-	E_(netfs_write_trace_writeback,		"WRITEBACK")
+	EM(netfs_write_trace_writeback,		"WRITEBACK")	\
+	E_(netfs_write_trace_writethrough,	"WRITETHRU")
 
 #define netfs_rreq_origins					\
 	EM(NETFS_READAHEAD,			"RA")		\
 	EM(NETFS_READPAGE,			"RP")		\
 	EM(NETFS_READ_FOR_WRITE,		"RW")		\
 	EM(NETFS_WRITEBACK,			"WB")		\
+	EM(NETFS_WRITETHROUGH,			"WT")		\
 	EM(NETFS_LAUNDER_WRITE,			"LW")		\
 	EM(NETFS_UNBUFFERED_WRITE,		"UW")		\
 	EM(NETFS_DIO_READ,			"DR")		\
@@ -136,7 +138,9 @@
 	EM(netfs_folio_trace_redirty,		"redirty")	\
 	EM(netfs_folio_trace_redirtied,		"redirtied")	\
 	EM(netfs_folio_trace_store,		"store")	\
-	E_(netfs_folio_trace_store_plus,	"store+")
+	EM(netfs_folio_trace_store_plus,	"store+")	\
+	EM(netfs_folio_trace_wthru,		"wthru")	\
+	E_(netfs_folio_trace_wthru_plus,	"wthru+")
 
 #ifndef __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY
 #define __NETFS_DECLARE_TRACE_ENUMS_ONCE_ONLY


