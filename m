Return-Path: <linux-cifs+bounces-1646-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D987B8905CA
	for <lists+linux-cifs@lfdr.de>; Thu, 28 Mar 2024 17:41:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 10C2BB219E4
	for <lists+linux-cifs@lfdr.de>; Thu, 28 Mar 2024 16:41:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E53C12FB21;
	Thu, 28 Mar 2024 16:37:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Klbz+VSx"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F0312F391
	for <linux-cifs@vger.kernel.org>; Thu, 28 Mar 2024 16:37:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711643841; cv=none; b=qm3/L3TRA0UO+VhWYi1Z2yTxTI9jL5wt3iolrmbIOislXK13/KjfXjonxK4oSLTud9IH2ffasivGPQVKl6EMu3MBRrKEtrnvcg4emEY6Xwjqug1dHLiQ5hcWQN9bA3CVj4hLP9b7pkRYLR7KrcNHKpiDn7MbmXIiMIwxg/6q+BM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711643841; c=relaxed/simple;
	bh=ac+GfpTCxYNZC3SQIAsHI4Ej2LDwFDWNL7Cm4QVLZ8U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZCp5lfipnQOWucBGz1yUHv7XdpQliYKx+/FARnqXcqt748igujGgAj0tdlOrYLuLxiFBqEjsWMwCnDHjzUH/dbFU2txmB6AVL+kFda6wesOi8aBqI17k9lc9d+sglEBicx7XkDTWIw5XRsRZx5arDLLJmNf38/iK7pagXTbEPtc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Klbz+VSx; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711643838;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Mem7lNP+7V6c2t0lUM5oHWZtR8iLqSZVCInVABGeIfQ=;
	b=Klbz+VSxnroq74C8+Tn/+eW7dyPBdSh/V7qJy9L7L6dvdVjVD+gJfTzO/pxgsTosYYCWhZ
	sBv+bkDsWSKvQw/yswMDdmd9E0HiMzMJ2cBOWGfQjKwLMsHz85RWj0hJ738Iz0MyZIpBBO
	5e5KGQ1U4tMfFQswq6/sKJtMQjobHDA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-350-kZUy3AvkNlqShTvnlBvVOQ-1; Thu, 28 Mar 2024 12:37:15 -0400
X-MC-Unique: kZUy3AvkNlqShTvnlBvVOQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 97891185A78E;
	Thu, 28 Mar 2024 16:37:14 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 3F62F200AFFC;
	Thu, 28 Mar 2024 16:37:11 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
	Matthew Wilcox <willy@infradead.org>,
	Steve French <smfrench@gmail.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-cachefs@redhat.com,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Steve French <sfrench@samba.org>,
	devel@lists.orangefs.org
Subject: [PATCH 13/26] netfs: Remove ->launder_folio() support
Date: Thu, 28 Mar 2024 16:34:05 +0000
Message-ID: <20240328163424.2781320-14-dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-1-dhowells@redhat.com>
References: <20240328163424.2781320-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4

Remove support for ->launder_folio() from netfslib and expect filesystems
to use filemap_invalidate_inode() instead.  netfs_launder_folio() can then
be got rid of.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Steve French <sfrench@samba.org>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
cc: netfs@lists.linux.dev
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: ceph-devel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
cc: devel@lists.orangefs.org
---
 fs/netfs/buffered_write.c    | 74 ------------------------------------
 fs/netfs/main.c              |  1 -
 include/linux/netfs.h        |  2 -
 include/trace/events/netfs.h |  3 --
 4 files changed, 80 deletions(-)

diff --git a/fs/netfs/buffered_write.c b/fs/netfs/buffered_write.c
index 576a68b7887e..624d8859c2fa 100644
--- a/fs/netfs/buffered_write.c
+++ b/fs/netfs/buffered_write.c
@@ -1199,77 +1199,3 @@ int netfs_writepages(struct address_space *mapping,
 	return ret;
 }
 EXPORT_SYMBOL(netfs_writepages);
-
-/*
- * Deal with the disposition of a laundered folio.
- */
-static void netfs_cleanup_launder_folio(struct netfs_io_request *wreq)
-{
-	if (wreq->error) {
-		pr_notice("R=%08x Laundering error %d\n", wreq->debug_id, wreq->error);
-		mapping_set_error(wreq->mapping, wreq->error);
-	}
-}
-
-/**
- * netfs_launder_folio - Clean up a dirty folio that's being invalidated
- * @folio: The folio to clean
- *
- * This is called to write back a folio that's being invalidated when an inode
- * is getting torn down.  Ideally, writepages would be used instead.
- */
-int netfs_launder_folio(struct folio *folio)
-{
-	struct netfs_io_request *wreq;
-	struct address_space *mapping = folio->mapping;
-	struct netfs_folio *finfo = netfs_folio_info(folio);
-	struct netfs_group *group = netfs_folio_group(folio);
-	struct bio_vec bvec;
-	unsigned long long i_size = i_size_read(mapping->host);
-	unsigned long long start = folio_pos(folio);
-	size_t offset = 0, len;
-	int ret = 0;
-
-	if (finfo) {
-		offset = finfo->dirty_offset;
-		start += offset;
-		len = finfo->dirty_len;
-	} else {
-		len = folio_size(folio);
-	}
-	len = min_t(unsigned long long, len, i_size - start);
-
-	wreq = netfs_alloc_request(mapping, NULL, start, len, NETFS_LAUNDER_WRITE);
-	if (IS_ERR(wreq)) {
-		ret = PTR_ERR(wreq);
-		goto out;
-	}
-
-	if (!folio_clear_dirty_for_io(folio))
-		goto out_put;
-
-	trace_netfs_folio(folio, netfs_folio_trace_launder);
-
-	_debug("launder %llx-%llx", start, start + len - 1);
-
-	/* Speculatively write to the cache.  We have to fix this up later if
-	 * the store fails.
-	 */
-	wreq->cleanup = netfs_cleanup_launder_folio;
-
-	bvec_set_folio(&bvec, folio, len, offset);
-	iov_iter_bvec(&wreq->iter, ITER_SOURCE, &bvec, 1, len);
-	if (group != NETFS_FOLIO_COPY_TO_CACHE)
-		__set_bit(NETFS_RREQ_UPLOAD_TO_SERVER, &wreq->flags);
-	ret = netfs_begin_write(wreq, true, netfs_write_trace_launder);
-
-out_put:
-	folio_detach_private(folio);
-	netfs_put_group(group);
-	kfree(finfo);
-	netfs_put_request(wreq, false, netfs_rreq_trace_put_return);
-out:
-	_leave(" = %d", ret);
-	return ret;
-}
-EXPORT_SYMBOL(netfs_launder_folio);
diff --git a/fs/netfs/main.c b/fs/netfs/main.c
index c5a73c9ed126..844efbb2e7a2 100644
--- a/fs/netfs/main.c
+++ b/fs/netfs/main.c
@@ -34,7 +34,6 @@ static const char *netfs_origins[nr__netfs_io_origin] = {
 	[NETFS_COPY_TO_CACHE]		= "CC",
 	[NETFS_WRITEBACK]		= "WB",
 	[NETFS_WRITETHROUGH]		= "WT",
-	[NETFS_LAUNDER_WRITE]		= "LW",
 	[NETFS_UNBUFFERED_WRITE]	= "UW",
 	[NETFS_DIO_READ]		= "DR",
 	[NETFS_DIO_WRITE]		= "DW",
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index ddafc6ebff42..3af589dabd7f 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -172,7 +172,6 @@ enum netfs_io_origin {
 	NETFS_COPY_TO_CACHE,		/* This write is to copy a read to the cache */
 	NETFS_WRITEBACK,		/* This write was triggered by writepages */
 	NETFS_WRITETHROUGH,		/* This write was made by netfs_perform_write() */
-	NETFS_LAUNDER_WRITE,		/* This is triggered by ->launder_folio() */
 	NETFS_UNBUFFERED_WRITE,		/* This is an unbuffered write */
 	NETFS_DIO_READ,			/* This is a direct I/O read */
 	NETFS_DIO_WRITE,		/* This is a direct I/O write */
@@ -352,7 +351,6 @@ int netfs_unpin_writeback(struct inode *inode, struct writeback_control *wbc);
 void netfs_clear_inode_writeback(struct inode *inode, const void *aux);
 void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length);
 bool netfs_release_folio(struct folio *folio, gfp_t gfp);
-int netfs_launder_folio(struct folio *folio);
 
 /* VMA operations API. */
 vm_fault_t netfs_page_mkwrite(struct vm_fault *vmf, struct netfs_group *netfs_group);
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index e03fafb0c1e3..30769103638f 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -26,7 +26,6 @@
 #define netfs_write_traces					\
 	EM(netfs_write_trace_copy_to_cache,	"COPY2CACH")	\
 	EM(netfs_write_trace_dio_write,		"DIO-WRITE")	\
-	EM(netfs_write_trace_launder,		"LAUNDER  ")	\
 	EM(netfs_write_trace_unbuffered_write,	"UNB-WRITE")	\
 	EM(netfs_write_trace_writeback,		"WRITEBACK")	\
 	E_(netfs_write_trace_writethrough,	"WRITETHRU")
@@ -38,7 +37,6 @@
 	EM(NETFS_COPY_TO_CACHE,			"CC")		\
 	EM(NETFS_WRITEBACK,			"WB")		\
 	EM(NETFS_WRITETHROUGH,			"WT")		\
-	EM(NETFS_LAUNDER_WRITE,			"LW")		\
 	EM(NETFS_UNBUFFERED_WRITE,		"UW")		\
 	EM(NETFS_DIO_READ,			"DR")		\
 	E_(NETFS_DIO_WRITE,			"DW")
@@ -135,7 +133,6 @@
 	EM(netfs_folio_trace_end_copy,		"end-copy")	\
 	EM(netfs_folio_trace_filled_gaps,	"filled-gaps")	\
 	EM(netfs_folio_trace_kill,		"kill")		\
-	EM(netfs_folio_trace_launder,		"launder")	\
 	EM(netfs_folio_trace_mkwrite,		"mkwrite")	\
 	EM(netfs_folio_trace_mkwrite_plus,	"mkwrite+")	\
 	EM(netfs_folio_trace_read_gaps,		"read-gaps")	\


