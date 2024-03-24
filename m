Return-Path: <linux-cifs+bounces-1553-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 8BFB988843D
	for <lists+linux-cifs@lfdr.de>; Mon, 25 Mar 2024 01:34:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 186E61F2A123
	for <lists+linux-cifs@lfdr.de>; Mon, 25 Mar 2024 00:34:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 75DB41A9F4C;
	Sun, 24 Mar 2024 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a/M8XC5V"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D541A9F48;
	Sun, 24 Mar 2024 22:43:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711320231; cv=none; b=rgSZmvl6/awBf+kLOTUEvdOCJKn0xjKBEaAQ46YTQAJx13qtLohlGLMZftlDZjEr5LRD3Y20xRpjPrTaqyLCOqChxcn7MbUNWf/t2IuBAiBzG5i+4WeHwSTPTBQPuEdeLxqSEV9ZWjCF1QkksoMU9anAxePlRoYPYP6x6xz0LUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711320231; c=relaxed/simple;
	bh=GAVXf9YXxEUZ/lbuVjAGJeaAdXVYPo2oppfNF8GcC5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kWxGHTKW5XekEiMtbkdBSNRwoG56EynmB53ujRMbgNGpPUeVrSsZXgmF8U8j2/ItDjN6jRlH+AJa5vJ8ukzW+cLh382P8XcxpRNfP6ykvBpEFwPdBRpOFAWdsAeVNFgXSjZRUokWHQiWe0ia1ryN3gUzXybL4OotiKzvG7OiR3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a/M8XC5V; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96B17C433F1;
	Sun, 24 Mar 2024 22:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711320231;
	bh=GAVXf9YXxEUZ/lbuVjAGJeaAdXVYPo2oppfNF8GcC5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=a/M8XC5Ve1samqsVyjaAo91rFQ+vazQmIUV0MFUwf0yE3D6gH4pxSWOstmD5NuBR1
	 ClLomEJBXkEUV6ODxrw9NnjZNrXuhG1XisaZvJS2z4hFByjclw9ADSqLTU4TT95h7m
	 kH7V0Cjm87dsbD9sPl99rc8qiwI8pkCamSGlx+ftBRD8n5pm2WpPhm5xKAmq8sq6HM
	 NWWq3NSUb7bNkQrWY/J8dH1ZRQxKoIOYXdi/EBFDAYrv//Mm102htXuqQeC5HHaG/l
	 +FkF3+gSdwQwNqP+3gkdgHlxzR8K+YV+RLvnCZh6JDCxu0+DsfQrHXd4SmChMI7Hr8
	 6pQKxCen+GF5w==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.8 537/715] cifs: Fix writeback data corruption
Date: Sun, 24 Mar 2024 18:31:56 -0400
Message-ID: <20240324223455.1342824-538-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240324223455.1342824-1-sashal@kernel.org>
References: <20240324223455.1342824-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit

From: David Howells <dhowells@redhat.com>

[ Upstream commit f3dc1bdb6b0b0693562c7c54a6c28bafa608ba3c ]

cifs writeback doesn't correctly handle the case where
cifs_extend_writeback() hits a point where it is considering an additional
folio, but this would overrun the wsize - at which point it drops out of
the xarray scanning loop and calls xas_pause().  The problem is that
xas_pause() advances the loop counter - thereby skipping that page.

What needs to happen is for xas_reset() to be called any time we decide we
don't want to process the page we're looking at, but rather send the
request we are building and start a new one.

Fix this by copying and adapting the netfslib writepages code as a
temporary measure, with cifs writeback intending to be offloaded to
netfslib in the near future.

This also fixes the issue with the use of filemap_get_folios_tag() causing
retry of a bunch of pages which the extender already dealt with.

This can be tested by creating, say, a 64K file somewhere not on cifs
(otherwise copy-offload may get underfoot), mounting a cifs share with a
wsize of 64000, copying the file to it and then comparing the original file
and the copy:

        dd if=/dev/urandom of=/tmp/64K bs=64k count=1
        mount //192.168.6.1/test /mnt -o user=...,pass=...,wsize=64000
        cp /tmp/64K /mnt/64K
        cmp /tmp/64K /mnt/64K

Without the fix, the cmp fails at position 64000 (or shortly thereafter).

Fixes: d08089f649a0 ("cifs: Change the I/O paths to use an iterator rather than a page list")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
cc: Shyam Prasad N <sprasad@microsoft.com>
cc: Tom Talpey <tom@talpey.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: samba-technical@lists.samba.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/file.c | 283 ++++++++++++++++++++++++-------------------
 1 file changed, 157 insertions(+), 126 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index f391c9b803d84..98514f2f2d7b1 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -2624,20 +2624,20 @@ static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
  * dirty pages if possible, but don't sleep while doing so.
  */
 static void cifs_extend_writeback(struct address_space *mapping,
+				  struct xa_state *xas,
 				  long *_count,
 				  loff_t start,
 				  int max_pages,
-				  size_t max_len,
-				  unsigned int *_len)
+				  loff_t max_len,
+				  size_t *_len)
 {
 	struct folio_batch batch;
 	struct folio *folio;
-	unsigned int psize, nr_pages;
-	size_t len = *_len;
-	pgoff_t index = (start + len) / PAGE_SIZE;
+	unsigned int nr_pages;
+	pgoff_t index = (start + *_len) / PAGE_SIZE;
+	size_t len;
 	bool stop = true;
 	unsigned int i;
-	XA_STATE(xas, &mapping->i_pages, index);
 
 	folio_batch_init(&batch);
 
@@ -2648,54 +2648,64 @@ static void cifs_extend_writeback(struct address_space *mapping,
 		 */
 		rcu_read_lock();
 
-		xas_for_each(&xas, folio, ULONG_MAX) {
+		xas_for_each(xas, folio, ULONG_MAX) {
 			stop = true;
-			if (xas_retry(&xas, folio))
+			if (xas_retry(xas, folio))
 				continue;
 			if (xa_is_value(folio))
 				break;
-			if (folio->index != index)
+			if (folio->index != index) {
+				xas_reset(xas);
 				break;
+			}
+
 			if (!folio_try_get_rcu(folio)) {
-				xas_reset(&xas);
+				xas_reset(xas);
 				continue;
 			}
 			nr_pages = folio_nr_pages(folio);
-			if (nr_pages > max_pages)
+			if (nr_pages > max_pages) {
+				xas_reset(xas);
 				break;
+			}
 
 			/* Has the page moved or been split? */
-			if (unlikely(folio != xas_reload(&xas))) {
+			if (unlikely(folio != xas_reload(xas))) {
 				folio_put(folio);
+				xas_reset(xas);
 				break;
 			}
 
 			if (!folio_trylock(folio)) {
 				folio_put(folio);
+				xas_reset(xas);
 				break;
 			}
-			if (!folio_test_dirty(folio) || folio_test_writeback(folio)) {
+			if (!folio_test_dirty(folio) ||
+			    folio_test_writeback(folio)) {
 				folio_unlock(folio);
 				folio_put(folio);
+				xas_reset(xas);
 				break;
 			}
 
 			max_pages -= nr_pages;
-			psize = folio_size(folio);
-			len += psize;
+			len = folio_size(folio);
 			stop = false;
-			if (max_pages <= 0 || len >= max_len || *_count <= 0)
-				stop = true;
 
 			index += nr_pages;
+			*_count -= nr_pages;
+			*_len += len;
+			if (max_pages <= 0 || *_len >= max_len || *_count <= 0)
+				stop = true;
+
 			if (!folio_batch_add(&batch, folio))
 				break;
 			if (stop)
 				break;
 		}
 
-		if (!stop)
-			xas_pause(&xas);
+		xas_pause(xas);
 		rcu_read_unlock();
 
 		/* Now, if we obtained any pages, we can shift them to being
@@ -2712,16 +2722,12 @@ static void cifs_extend_writeback(struct address_space *mapping,
 			if (!folio_clear_dirty_for_io(folio))
 				WARN_ON(1);
 			folio_start_writeback(folio);
-
-			*_count -= folio_nr_pages(folio);
 			folio_unlock(folio);
 		}
 
 		folio_batch_release(&batch);
 		cond_resched();
 	} while (!stop);
-
-	*_len = len;
 }
 
 /*
@@ -2729,8 +2735,10 @@ static void cifs_extend_writeback(struct address_space *mapping,
  */
 static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
 						 struct writeback_control *wbc,
+						 struct xa_state *xas,
 						 struct folio *folio,
-						 loff_t start, loff_t end)
+						 unsigned long long start,
+						 unsigned long long end)
 {
 	struct inode *inode = mapping->host;
 	struct TCP_Server_Info *server;
@@ -2739,17 +2747,18 @@ static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
 	struct cifs_credits credits_on_stack;
 	struct cifs_credits *credits = &credits_on_stack;
 	struct cifsFileInfo *cfile = NULL;
-	unsigned int xid, wsize, len;
-	loff_t i_size = i_size_read(inode);
-	size_t max_len;
+	unsigned long long i_size = i_size_read(inode), max_len;
+	unsigned int xid, wsize;
+	size_t len = folio_size(folio);
 	long count = wbc->nr_to_write;
 	int rc;
 
 	/* The folio should be locked, dirty and not undergoing writeback. */
+	if (!folio_clear_dirty_for_io(folio))
+		WARN_ON_ONCE(1);
 	folio_start_writeback(folio);
 
 	count -= folio_nr_pages(folio);
-	len = folio_size(folio);
 
 	xid = get_xid();
 	server = cifs_pick_channel(cifs_sb_master_tcon(cifs_sb)->ses);
@@ -2779,9 +2788,10 @@ static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
 	wdata->server = server;
 	cfile = NULL;
 
-	/* Find all consecutive lockable dirty pages, stopping when we find a
-	 * page that is not immediately lockable, is not dirty or is missing,
-	 * or we reach the end of the range.
+	/* Find all consecutive lockable dirty pages that have contiguous
+	 * written regions, stopping when we find a page that is not
+	 * immediately lockable, is not dirty or is missing, or we reach the
+	 * end of the range.
 	 */
 	if (start < i_size) {
 		/* Trim the write to the EOF; the extra data is ignored.  Also
@@ -2801,19 +2811,18 @@ static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
 			max_pages -= folio_nr_pages(folio);
 
 			if (max_pages > 0)
-				cifs_extend_writeback(mapping, &count, start,
+				cifs_extend_writeback(mapping, xas, &count, start,
 						      max_pages, max_len, &len);
 		}
-		len = min_t(loff_t, len, max_len);
 	}
-
-	wdata->bytes = len;
+	len = min_t(unsigned long long, len, i_size - start);
 
 	/* We now have a contiguous set of dirty pages, each with writeback
 	 * set; the first page is still locked at this point, but all the rest
 	 * have been unlocked.
 	 */
 	folio_unlock(folio);
+	wdata->bytes = len;
 
 	if (start < i_size) {
 		iov_iter_xarray(&wdata->iter, ITER_SOURCE, &mapping->i_pages,
@@ -2864,102 +2873,118 @@ static ssize_t cifs_write_back_from_locked_folio(struct address_space *mapping,
 /*
  * write a region of pages back to the server
  */
-static int cifs_writepages_region(struct address_space *mapping,
-				  struct writeback_control *wbc,
-				  loff_t start, loff_t end, loff_t *_next)
+static ssize_t cifs_writepages_begin(struct address_space *mapping,
+				     struct writeback_control *wbc,
+				     struct xa_state *xas,
+				     unsigned long long *_start,
+				     unsigned long long end)
 {
-	struct folio_batch fbatch;
+	struct folio *folio;
+	unsigned long long start = *_start;
+	ssize_t ret;
 	int skips = 0;
 
-	folio_batch_init(&fbatch);
-	do {
-		int nr;
-		pgoff_t index = start / PAGE_SIZE;
+search_again:
+	/* Find the first dirty page. */
+	rcu_read_lock();
 
-		nr = filemap_get_folios_tag(mapping, &index, end / PAGE_SIZE,
-					    PAGECACHE_TAG_DIRTY, &fbatch);
-		if (!nr)
+	for (;;) {
+		folio = xas_find_marked(xas, end / PAGE_SIZE, PAGECACHE_TAG_DIRTY);
+		if (xas_retry(xas, folio) || xa_is_value(folio))
+			continue;
+		if (!folio)
 			break;
 
-		for (int i = 0; i < nr; i++) {
-			ssize_t ret;
-			struct folio *folio = fbatch.folios[i];
+		if (!folio_try_get_rcu(folio)) {
+			xas_reset(xas);
+			continue;
+		}
 
-redo_folio:
-			start = folio_pos(folio); /* May regress with THPs */
+		if (unlikely(folio != xas_reload(xas))) {
+			folio_put(folio);
+			xas_reset(xas);
+			continue;
+		}
 
-			/* At this point we hold neither the i_pages lock nor the
-			 * page lock: the page may be truncated or invalidated
-			 * (changing page->mapping to NULL), or even swizzled
-			 * back from swapper_space to tmpfs file mapping
-			 */
-			if (wbc->sync_mode != WB_SYNC_NONE) {
-				ret = folio_lock_killable(folio);
-				if (ret < 0)
-					goto write_error;
-			} else {
-				if (!folio_trylock(folio))
-					goto skip_write;
-			}
+		xas_pause(xas);
+		break;
+	}
+	rcu_read_unlock();
+	if (!folio)
+		return 0;
 
-			if (folio->mapping != mapping ||
-			    !folio_test_dirty(folio)) {
-				start += folio_size(folio);
-				folio_unlock(folio);
-				continue;
-			}
+	start = folio_pos(folio); /* May regress with THPs */
 
-			if (folio_test_writeback(folio) ||
-			    folio_test_fscache(folio)) {
-				folio_unlock(folio);
-				if (wbc->sync_mode == WB_SYNC_NONE)
-					goto skip_write;
+	/* At this point we hold neither the i_pages lock nor the page lock:
+	 * the page may be truncated or invalidated (changing page->mapping to
+	 * NULL), or even swizzled back from swapper_space to tmpfs file
+	 * mapping
+	 */
+lock_again:
+	if (wbc->sync_mode != WB_SYNC_NONE) {
+		ret = folio_lock_killable(folio);
+		if (ret < 0)
+			return ret;
+	} else {
+		if (!folio_trylock(folio))
+			goto search_again;
+	}
 
-				folio_wait_writeback(folio);
+	if (folio->mapping != mapping ||
+	    !folio_test_dirty(folio)) {
+		start += folio_size(folio);
+		folio_unlock(folio);
+		goto search_again;
+	}
+
+	if (folio_test_writeback(folio) ||
+	    folio_test_fscache(folio)) {
+		folio_unlock(folio);
+		if (wbc->sync_mode != WB_SYNC_NONE) {
+			folio_wait_writeback(folio);
 #ifdef CONFIG_CIFS_FSCACHE
-				folio_wait_fscache(folio);
+			folio_wait_fscache(folio);
 #endif
-				goto redo_folio;
-			}
-
-			if (!folio_clear_dirty_for_io(folio))
-				/* We hold the page lock - it should've been dirty. */
-				WARN_ON(1);
-
-			ret = cifs_write_back_from_locked_folio(mapping, wbc, folio, start, end);
-			if (ret < 0)
-				goto write_error;
-
-			start += ret;
-			continue;
-
-write_error:
-			folio_batch_release(&fbatch);
-			*_next = start;
-			return ret;
+			goto lock_again;
+		}
 
-skip_write:
-			/*
-			 * Too many skipped writes, or need to reschedule?
-			 * Treat it as a write error without an error code.
-			 */
+		start += folio_size(folio);
+		if (wbc->sync_mode == WB_SYNC_NONE) {
 			if (skips >= 5 || need_resched()) {
 				ret = 0;
-				goto write_error;
+				goto out;
 			}
-
-			/* Otherwise, just skip that folio and go on to the next */
 			skips++;
-			start += folio_size(folio);
-			continue;
 		}
+		goto search_again;
+	}
 
-		folio_batch_release(&fbatch);		
-		cond_resched();
-	} while (wbc->nr_to_write > 0);
+	ret = cifs_write_back_from_locked_folio(mapping, wbc, xas, folio, start, end);
+out:
+	if (ret > 0)
+		*_start = start + ret;
+	return ret;
+}
 
-	*_next = start;
-	return 0;
+/*
+ * Write a region of pages back to the server
+ */
+static int cifs_writepages_region(struct address_space *mapping,
+				  struct writeback_control *wbc,
+				  unsigned long long *_start,
+				  unsigned long long end)
+{
+	ssize_t ret;
+
+	XA_STATE(xas, &mapping->i_pages, *_start / PAGE_SIZE);
+
+	do {
+		ret = cifs_writepages_begin(mapping, wbc, &xas, _start, end);
+		if (ret > 0 && wbc->nr_to_write > 0)
+			cond_resched();
+	} while (ret > 0 && wbc->nr_to_write > 0);
+
+	return ret > 0 ? 0 : ret;
 }
 
 /*
@@ -2968,7 +2993,7 @@ static int cifs_writepages_region(struct address_space *mapping,
 static int cifs_writepages(struct address_space *mapping,
 			   struct writeback_control *wbc)
 {
-	loff_t start, next;
+	loff_t start, end;
 	int ret;
 
 	/* We have to be careful as we can end up racing with setattr()
@@ -2976,28 +3001,34 @@ static int cifs_writepages(struct address_space *mapping,
 	 * to prevent it.
 	 */
 
-	if (wbc->range_cyclic) {
+	if (wbc->range_cyclic && mapping->writeback_index) {
 		start = mapping->writeback_index * PAGE_SIZE;
-		ret = cifs_writepages_region(mapping, wbc, start, LLONG_MAX, &next);
-		if (ret == 0) {
-			mapping->writeback_index = next / PAGE_SIZE;
-			if (start > 0 && wbc->nr_to_write > 0) {
-				ret = cifs_writepages_region(mapping, wbc, 0,
-							     start, &next);
-				if (ret == 0)
-					mapping->writeback_index =
-						next / PAGE_SIZE;
-			}
+		ret = cifs_writepages_region(mapping, wbc, &start, LLONG_MAX);
+		if (ret < 0)
+			goto out;
+
+		if (wbc->nr_to_write <= 0) {
+			mapping->writeback_index = start / PAGE_SIZE;
+			goto out;
 		}
+
+		start = 0;
+		end = mapping->writeback_index * PAGE_SIZE;
+		mapping->writeback_index = 0;
+		ret = cifs_writepages_region(mapping, wbc, &start, end);
+		if (ret == 0)
+			mapping->writeback_index = start / PAGE_SIZE;
 	} else if (wbc->range_start == 0 && wbc->range_end == LLONG_MAX) {
-		ret = cifs_writepages_region(mapping, wbc, 0, LLONG_MAX, &next);
+		start = 0;
+		ret = cifs_writepages_region(mapping, wbc, &start, LLONG_MAX);
 		if (wbc->nr_to_write > 0 && ret == 0)
-			mapping->writeback_index = next / PAGE_SIZE;
+			mapping->writeback_index = start / PAGE_SIZE;
 	} else {
-		ret = cifs_writepages_region(mapping, wbc,
-					     wbc->range_start, wbc->range_end, &next);
+		start = wbc->range_start;
+		ret = cifs_writepages_region(mapping, wbc, &start, wbc->range_end);
 	}
 
+out:
 	return ret;
 }
 
-- 
2.43.0


