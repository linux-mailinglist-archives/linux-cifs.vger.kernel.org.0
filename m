Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1C1C740AFDF
	for <lists+linux-cifs@lfdr.de>; Tue, 14 Sep 2021 15:56:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233607AbhINN5Z (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 14 Sep 2021 09:57:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:44277 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233705AbhINN5N (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 14 Sep 2021 09:57:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631627755;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ZYmEyowrXXy1ngQgXPFHU9auJfrxv3UHhxatQxn00xo=;
        b=VGid1jouJYl566Gm/EaQgltuAPeaJsej8RCrMQpAXh5lAYHHiQBNYoIS+WTZLUVbksDb8f
        DR2oG3uvi2HnCQLBiB+wTYY/vw+uExIXqU2WKCX174/P5v+V11Tfjp6aQQcI8D4L0DmiGc
        /luzKj0UITFGWL/yqTpht92cMivsJ7Q=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-fh5LngymOpKsRae7DZcsmQ-1; Tue, 14 Sep 2021 09:55:51 -0400
X-MC-Unique: fh5LngymOpKsRae7DZcsmQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 374CA108468C;
        Tue, 14 Sep 2021 13:55:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B762100164A;
        Tue, 14 Sep 2021 13:55:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 5/8] cifs: (untested) Move to using the alternate (deprecated)
 fscache I/O API
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs@vger.kernel.org, linux-cachefs@redhat.com,
        dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 14 Sep 2021 14:55:38 +0100
Message-ID: <163162773867.438332.3585429891151112562.stgit@warthog.procyon.org.uk>
In-Reply-To: <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk>
References: <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Move cifs/smb to using the alternate (deprecated) fscache I/O API instead
of the old upstream I/O API as that is about to be deleted.  The alternate
API will also be deleted at some point in the future as it's dangerous (as
is the old API) and can lead to data corruption if the backing filesystem
can insert/remove bridging blocks of zeros into its extent list[1].

The alternate API reads and writes pages synchronously, with the intention
of allowing removal of the operation management framework and thence the
object management framework from fscache.

The preferred change would be to use the netfs lib, but the new I/O API can
be used directly.  It's just that as the cache now needs to track data for
itself, caching blocks may exceed page size...

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: linux-cifs@vger.kernel.org
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/YO17ZNOcq+9PajfQ@mit.edu [1]
---

 fs/cifs/file.c    |   64 ++++++++++++++++++--------------
 fs/cifs/fscache.c |  105 ++---------------------------------------------------
 fs/cifs/fscache.h |   75 +++-----------------------------------
 3 files changed, 43 insertions(+), 201 deletions(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index d0216472f1c6..865802a97ad5 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4174,11 +4174,8 @@ static vm_fault_t
 cifs_page_mkwrite(struct vm_fault *vmf)
 {
 	struct page *page = vmf->page;
-	struct file *file = vmf->vma->vm_file;
-	struct inode *inode = file_inode(file);
-
-	cifs_fscache_wait_on_page_write(inode, page);
 
+	wait_on_page_fscache(page);
 	lock_page(page);
 	return VM_FAULT_LOCKED;
 }
@@ -4251,8 +4248,6 @@ cifs_readv_complete(struct work_struct *work)
 		if (rdata->result == 0 ||
 		    (rdata->result == -EAGAIN && got_bytes))
 			cifs_readpage_to_fscache(rdata->mapping->host, page);
-		else
-			cifs_fscache_uncache_page(rdata->mapping->host, page);
 
 		got_bytes -= min_t(unsigned int, PAGE_SIZE, got_bytes);
 
@@ -4375,6 +4370,7 @@ readpages_get_pages(struct address_space *mapping, struct list_head *page_list,
 
 	INIT_LIST_HEAD(tmplist);
 
+again:
 	page = lru_to_page(page_list);
 
 	/*
@@ -4392,6 +4388,18 @@ readpages_get_pages(struct address_space *mapping, struct list_head *page_list,
 		return rc;
 	}
 
+	rc = cifs_readpage_from_fscache(mapping->host, page);
+	if (rc == 0) {
+		list_del_init(&page->lru);
+		SetPageUptodate(page);
+		lru_cache_add(page);
+		unlock_page(page);
+		put_page(page);
+		if (list_empty(page_list))
+			return 0;
+		goto again;
+	}
+
 	/* move first page to the tmplist */
 	*offset = (loff_t)page->index << PAGE_SHIFT;
 	*bytes = PAGE_SIZE;
@@ -4415,10 +4423,20 @@ readpages_get_pages(struct address_space *mapping, struct list_head *page_list,
 			__ClearPageLocked(page);
 			break;
 		}
-		list_move_tail(&page->lru, tmplist);
-		(*bytes) += PAGE_SIZE;
+
+		rc = cifs_readpage_from_fscache(mapping->host, page);
+		if (rc == 0) {
+			list_del_init(&page->lru);
+			SetPageUptodate(page);
+			lru_cache_add(page);
+			unlock_page(page);
+			put_page(page);
+		} else {
+			list_move_tail(&page->lru, tmplist);
+			(*bytes) += PAGE_SIZE;
+			(*nr_pages)++;
+		}
 		expected_index++;
-		(*nr_pages)++;
 	}
 	return rc;
 }
@@ -4436,19 +4454,6 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 	unsigned int xid;
 
 	xid = get_xid();
-	/*
-	 * Reads as many pages as possible from fscache. Returns -ENOBUFS
-	 * immediately if the cookie is negative
-	 *
-	 * After this point, every page in the list might have PG_fscache set,
-	 * so we will need to clean that up off of every page we don't use.
-	 */
-	rc = cifs_readpages_from_fscache(mapping->host, mapping, page_list,
-					 &num_pages);
-	if (rc == 0) {
-		free_xid(xid);
-		return rc;
-	}
 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_RWPIDFORWARD)
 		pid = open_file->pid;
@@ -4573,7 +4578,6 @@ static int cifs_readpages(struct file *file, struct address_space *mapping,
 	 * the pagecache must be uncached before they get returned to the
 	 * allocator.
 	 */
-	cifs_fscache_readpages_cancel(mapping->host, page_list);
 	free_xid(xid);
 	return rc;
 }
@@ -4777,17 +4781,19 @@ static int cifs_release_page(struct page *page, gfp_t gfp)
 {
 	if (PagePrivate(page))
 		return 0;
-
-	return cifs_fscache_release_page(page, gfp);
+	if (PageFsCache(page)) {
+		if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))
+			return false;
+		wait_on_page_fscache(page);
+	}
+	return true;
 }
 
 static void cifs_invalidate_page(struct page *page, unsigned int offset,
 				 unsigned int length)
 {
-	struct cifsInodeInfo *cifsi = CIFS_I(page->mapping->host);
-
 	if (offset == 0 && length == PAGE_SIZE)
-		cifs_fscache_invalidate_page(page, &cifsi->vfs_inode);
+		wait_on_page_fscache(page);
 }
 
 static int cifs_launder_page(struct page *page)
@@ -4807,7 +4813,7 @@ static int cifs_launder_page(struct page *page)
 	if (clear_page_dirty_for_io(page))
 		rc = cifs_writepage_locked(page, &wbc);
 
-	cifs_fscache_invalidate_page(page, page->mapping->host);
+	wait_on_page_fscache(page);
 	return rc;
 }
 
diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
index fab47fa7df74..d00f7ad61c5b 100644
--- a/fs/cifs/fscache.c
+++ b/fs/cifs/fscache.c
@@ -223,30 +223,6 @@ void cifs_fscache_reset_inode_cookie(struct inode *inode)
 	}
 }
 
-int cifs_fscache_release_page(struct page *page, gfp_t gfp)
-{
-	if (PageFsCache(page)) {
-		struct inode *inode = page->mapping->host;
-		struct cifsInodeInfo *cifsi = CIFS_I(inode);
-
-		cifs_dbg(FYI, "%s: (0x%p/0x%p)\n",
-			 __func__, page, cifsi->fscache);
-		if (!fscache_maybe_release_page(cifsi->fscache, page, gfp))
-			return 0;
-	}
-
-	return 1;
-}
-
-static void cifs_readpage_from_fscache_complete(struct page *page, void *ctx,
-						int error)
-{
-	cifs_dbg(FYI, "%s: (0x%p/%d)\n", __func__, page, error);
-	if (!error)
-		SetPageUptodate(page);
-	unlock_page(page);
-}
-
 /*
  * Retrieve a page from FS-Cache
  */
@@ -256,12 +232,9 @@ int __cifs_readpage_from_fscache(struct inode *inode, struct page *page)
 
 	cifs_dbg(FYI, "%s: (fsc:%p, p:%p, i:0x%p\n",
 		 __func__, CIFS_I(inode)->fscache, page, inode);
-	ret = fscache_read_or_alloc_page(CIFS_I(inode)->fscache, page,
-					 cifs_readpage_from_fscache_complete,
-					 NULL,
-					 GFP_KERNEL);
-	switch (ret) {
 
+	ret = fscache_deprecated_read_page(cifs_inode_cookie(inode), page);
+	switch (ret) {
 	case 0: /* page found in fscache, read submitted */
 		cifs_dbg(FYI, "%s: submitted\n", __func__);
 		return ret;
@@ -276,86 +249,14 @@ int __cifs_readpage_from_fscache(struct inode *inode, struct page *page)
 	return ret;
 }
 
-/*
- * Retrieve a set of pages from FS-Cache
- */
-int __cifs_readpages_from_fscache(struct inode *inode,
-				struct address_space *mapping,
-				struct list_head *pages,
-				unsigned *nr_pages)
-{
-	int ret;
-
-	cifs_dbg(FYI, "%s: (0x%p/%u/0x%p)\n",
-		 __func__, CIFS_I(inode)->fscache, *nr_pages, inode);
-	ret = fscache_read_or_alloc_pages(CIFS_I(inode)->fscache, mapping,
-					  pages, nr_pages,
-					  cifs_readpage_from_fscache_complete,
-					  NULL,
-					  mapping_gfp_mask(mapping));
-	switch (ret) {
-	case 0:	/* read submitted to the cache for all pages */
-		cifs_dbg(FYI, "%s: submitted\n", __func__);
-		return ret;
-
-	case -ENOBUFS:	/* some pages are not cached and can't be */
-	case -ENODATA:	/* some pages are not cached */
-		cifs_dbg(FYI, "%s: no page\n", __func__);
-		return 1;
-
-	default:
-		cifs_dbg(FYI, "unknown error ret = %d\n", ret);
-	}
-
-	return ret;
-}
-
 void __cifs_readpage_to_fscache(struct inode *inode, struct page *page)
 {
 	struct cifsInodeInfo *cifsi = CIFS_I(inode);
-	int ret;
 
 	WARN_ON(!cifsi->fscache);
 
 	cifs_dbg(FYI, "%s: (fsc: %p, p: %p, i: %p)\n",
 		 __func__, cifsi->fscache, page, inode);
-	ret = fscache_write_page(cifsi->fscache, page,
-				 cifsi->vfs_inode.i_size, GFP_KERNEL);
-	if (ret != 0)
-		fscache_uncache_page(cifsi->fscache, page);
-}
-
-void __cifs_fscache_readpages_cancel(struct inode *inode, struct list_head *pages)
-{
-	cifs_dbg(FYI, "%s: (fsc: %p, i: %p)\n",
-		 __func__, CIFS_I(inode)->fscache, inode);
-	fscache_readpages_cancel(CIFS_I(inode)->fscache, pages);
-}
-
-void __cifs_fscache_invalidate_page(struct page *page, struct inode *inode)
-{
-	struct cifsInodeInfo *cifsi = CIFS_I(inode);
-	struct fscache_cookie *cookie = cifsi->fscache;
-
-	cifs_dbg(FYI, "%s: (0x%p/0x%p)\n", __func__, page, cookie);
-	fscache_wait_on_page_write(cookie, page);
-	fscache_uncache_page(cookie, page);
-}
-
-void __cifs_fscache_wait_on_page_write(struct inode *inode, struct page *page)
-{
-	struct cifsInodeInfo *cifsi = CIFS_I(inode);
-	struct fscache_cookie *cookie = cifsi->fscache;
-
-	cifs_dbg(FYI, "%s: (0x%p/0x%p)\n", __func__, page, cookie);
-	fscache_wait_on_page_write(cookie, page);
-}
-
-void __cifs_fscache_uncache_page(struct inode *inode, struct page *page)
-{
-	struct cifsInodeInfo *cifsi = CIFS_I(inode);
-	struct fscache_cookie *cookie = cifsi->fscache;
 
-	cifs_dbg(FYI, "%s: (0x%p/0x%p)\n", __func__, page, cookie);
-	fscache_uncache_page(cookie, page);
+	fscache_deprecated_write_page(cifs_inode_cookie(inode), page);
 }
diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
index cfea3cf5d2af..fbc0b0632169 100644
--- a/fs/cifs/fscache.h
+++ b/fs/cifs/fscache.h
@@ -9,7 +9,7 @@
 #ifndef _CIFS_FSCACHE_H
 #define _CIFS_FSCACHE_H
 
-#define FSCACHE_USE_OLD_IO_API
+#define FSCACHE_USE_DEPRECATED_IO_API
 #include <linux/fscache.h>
 
 #include "cifsglob.h"
@@ -60,40 +60,9 @@ extern void cifs_fscache_update_inode_cookie(struct inode *inode);
 extern void cifs_fscache_set_inode_cookie(struct inode *, struct file *);
 extern void cifs_fscache_reset_inode_cookie(struct inode *);
 
-extern void __cifs_fscache_invalidate_page(struct page *, struct inode *);
-extern void __cifs_fscache_wait_on_page_write(struct inode *inode, struct page *page);
-extern void __cifs_fscache_uncache_page(struct inode *inode, struct page *page);
-extern int cifs_fscache_release_page(struct page *page, gfp_t gfp);
 extern int __cifs_readpage_from_fscache(struct inode *, struct page *);
-extern int __cifs_readpages_from_fscache(struct inode *,
-					 struct address_space *,
-					 struct list_head *,
-					 unsigned *);
-extern void __cifs_fscache_readpages_cancel(struct inode *, struct list_head *);
-
 extern void __cifs_readpage_to_fscache(struct inode *, struct page *);
 
-static inline void cifs_fscache_invalidate_page(struct page *page,
-					       struct inode *inode)
-{
-	if (PageFsCache(page))
-		__cifs_fscache_invalidate_page(page, inode);
-}
-
-static inline void cifs_fscache_wait_on_page_write(struct inode *inode,
-						   struct page *page)
-{
-	if (PageFsCache(page))
-		__cifs_fscache_wait_on_page_write(inode, page);
-}
-
-static inline void cifs_fscache_uncache_page(struct inode *inode,
-						   struct page *page)
-{
-	if (PageFsCache(page))
-		__cifs_fscache_uncache_page(inode, page);
-}
-
 static inline int cifs_readpage_from_fscache(struct inode *inode,
 					     struct page *page)
 {
@@ -103,17 +72,6 @@ static inline int cifs_readpage_from_fscache(struct inode *inode,
 	return -ENOBUFS;
 }
 
-static inline int cifs_readpages_from_fscache(struct inode *inode,
-					      struct address_space *mapping,
-					      struct list_head *pages,
-					      unsigned *nr_pages)
-{
-	if (CIFS_I(inode)->fscache)
-		return __cifs_readpages_from_fscache(inode, mapping, pages,
-						     nr_pages);
-	return -ENOBUFS;
-}
-
 static inline void cifs_readpage_to_fscache(struct inode *inode,
 					    struct page *page)
 {
@@ -121,11 +79,9 @@ static inline void cifs_readpage_to_fscache(struct inode *inode,
 		__cifs_readpage_to_fscache(inode, page);
 }
 
-static inline void cifs_fscache_readpages_cancel(struct inode *inode,
-						 struct list_head *pages)
+static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode)
 {
-	if (CIFS_I(inode)->fscache)
-		return __cifs_fscache_readpages_cancel(inode, pages);
+	return CIFS_I(inode)->fscache;
 }
 
 #else /* CONFIG_CIFS_FSCACHE */
@@ -145,17 +101,7 @@ static inline void cifs_fscache_update_inode_cookie(struct inode *inode) {}
 static inline void cifs_fscache_set_inode_cookie(struct inode *inode,
 						 struct file *filp) {}
 static inline void cifs_fscache_reset_inode_cookie(struct inode *inode) {}
-static inline int cifs_fscache_release_page(struct page *page, gfp_t gfp)
-{
-	return 1; /* May release page */
-}
 
-static inline void cifs_fscache_invalidate_page(struct page *page,
-			struct inode *inode) {}
-static inline void cifs_fscache_wait_on_page_write(struct inode *inode,
-						   struct page *page) {}
-static inline void cifs_fscache_uncache_page(struct inode *inode,
-						   struct page *page) {}
 
 static inline int
 cifs_readpage_from_fscache(struct inode *inode, struct page *page)
@@ -163,21 +109,10 @@ cifs_readpage_from_fscache(struct inode *inode, struct page *page)
 	return -ENOBUFS;
 }
 
-static inline int cifs_readpages_from_fscache(struct inode *inode,
-					      struct address_space *mapping,
-					      struct list_head *pages,
-					      unsigned *nr_pages)
-{
-	return -ENOBUFS;
-}
-
 static inline void cifs_readpage_to_fscache(struct inode *inode,
 			struct page *page) {}
-
-static inline void cifs_fscache_readpages_cancel(struct inode *inode,
-						 struct list_head *pages)
-{
-}
+static inline struct fscache_cookie *cifs_inode_cookie(struct inode *inode)
+{ return NULL; }
 
 #endif /* CONFIG_CIFS_FSCACHE */
 


