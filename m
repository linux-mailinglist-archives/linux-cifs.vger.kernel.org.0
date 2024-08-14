Return-Path: <linux-cifs+bounces-2468-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C9CF952400
	for <lists+linux-cifs@lfdr.de>; Wed, 14 Aug 2024 22:48:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05089281834
	for <lists+linux-cifs@lfdr.de>; Wed, 14 Aug 2024 20:48:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 332F01E2130;
	Wed, 14 Aug 2024 20:41:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BkqXXHWx"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CC991E2867
	for <linux-cifs@vger.kernel.org>; Wed, 14 Aug 2024 20:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723668102; cv=none; b=Jlvv4AiR2LdDcOdWCt92N9nWnnxqSVOhD9N+5n+rMMmbagqvUH8nGeBEiU2VpXq1Bxh04aCaQ9Omn09PHbkfZvKvc5oOZRwRlb3b+NFjFVhi+QnFnGPpAoSo7uyRtrau+ggmMDlWkVk/u3wssgmC97ZEaz5+WgBWPc9O7Osfn+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723668102; c=relaxed/simple;
	bh=jTR0PP8fEz/2UEZFz2wPI1qAphlKiuf7sp2Zpnx/5So=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fDIG+jDvwbSa0CH7V1d6rXAr/Q+OJz02JF3l1VEiDVmDXrUNjXv4pwpJ3yGsLLMSOqZeWu+GgO5FPIebju/6PQfBN1jo5zc22Yxg17g3VXc5dtzpBUXbNh1/PuaeLq0XkLmqS9xYxam2zqvFKWhVg1yWon9ybXyUBfKHQBqOCaw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BkqXXHWx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723668098;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fDuOF0s2BOs8KZl66qGdXe3l4UUO6Nb/3xLiR9dgE/s=;
	b=BkqXXHWxZ8gWA9VpJ2/irA4KZgf7KXJSQUlb4FW27yGAkT5QYa5mnnY2wTH4h6i05Ls9Jj
	8zrncTTnj+qevTEvN5H1fPo8yZgtNAzG9kRLz6rKzSkJk3NIafkUkDBfmOFGeWk3LDgG/p
	VyEAenMZerbgTWQ21cSZa0wBkVMyTN4=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-_KCJxC8hOEaZzlOi1GU9WA-1; Wed,
 14 Aug 2024 16:41:34 -0400
X-MC-Unique: _KCJxC8hOEaZzlOi1GU9WA-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4B0321944F02;
	Wed, 14 Aug 2024 20:41:31 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6990B3001FDD;
	Wed, 14 Aug 2024 20:41:25 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 20/25] netfs: Remove fs/netfs/io.c
Date: Wed, 14 Aug 2024 21:38:40 +0100
Message-ID: <20240814203850.2240469-21-dhowells@redhat.com>
In-Reply-To: <20240814203850.2240469-1-dhowells@redhat.com>
References: <20240814203850.2240469-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Remove fs/netfs/io.c as it is no longer used.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/io.c | 794 --------------------------------------------------
 1 file changed, 794 deletions(-)
 delete mode 100644 fs/netfs/io.c

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
deleted file mode 100644
index 8b9aaa99d787..000000000000
--- a/fs/netfs/io.c
+++ /dev/null
@@ -1,794 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0-or-later
-/* Network filesystem high-level read support.
- *
- * Copyright (C) 2021 Red Hat, Inc. All Rights Reserved.
- * Written by David Howells (dhowells@redhat.com)
- */
-
-#include <linux/module.h>
-#include <linux/export.h>
-#include <linux/fs.h>
-#include <linux/mm.h>
-#include <linux/pagemap.h>
-#include <linux/slab.h>
-#include <linux/uio.h>
-#include <linux/sched/mm.h>
-#include <linux/task_io_accounting_ops.h>
-#include "internal.h"
-
-/*
- * Clear the unread part of an I/O request.
- */
-static void netfs_clear_unread(struct netfs_io_subrequest *subreq)
-{
-	iov_iter_zero(iov_iter_count(&subreq->io_iter), &subreq->io_iter);
-}
-
-static void netfs_cache_read_terminated(void *priv, ssize_t transferred_or_error,
-					bool was_async)
-{
-	struct netfs_io_subrequest *subreq = priv;
-
-	netfs_subreq_terminated(subreq, transferred_or_error, was_async);
-}
-
-/*
- * Issue a read against the cache.
- * - Eats the caller's ref on subreq.
- */
-static void netfs_read_from_cache(struct netfs_io_request *rreq,
-				  struct netfs_io_subrequest *subreq,
-				  enum netfs_read_from_hole read_hole)
-{
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-
-	netfs_stat(&netfs_n_rh_read);
-	cres->ops->read(cres, subreq->start, &subreq->io_iter, read_hole,
-			netfs_cache_read_terminated, subreq);
-}
-
-/*
- * Fill a subrequest region with zeroes.
- */
-static void netfs_fill_with_zeroes(struct netfs_io_request *rreq,
-				   struct netfs_io_subrequest *subreq)
-{
-	netfs_stat(&netfs_n_rh_zero);
-	__set_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags);
-	netfs_subreq_terminated(subreq, 0, false);
-}
-
-/*
- * Ask the netfs to issue a read request to the server for us.
- *
- * The netfs is expected to read from subreq->pos + subreq->transferred to
- * subreq->pos + subreq->len - 1.  It may not backtrack and write data into the
- * buffer prior to the transferred point as it might clobber dirty data
- * obtained from the cache.
- *
- * Alternatively, the netfs is allowed to indicate one of two things:
- *
- * - NETFS_SREQ_SHORT_READ: A short read - it will get called again to try and
- *   make progress.
- *
- * - NETFS_SREQ_CLEAR_TAIL: A short read - the rest of the buffer will be
- *   cleared.
- */
-static void netfs_read_from_server(struct netfs_io_request *rreq,
-				   struct netfs_io_subrequest *subreq)
-{
-	netfs_stat(&netfs_n_rh_download);
-
-	if (rreq->origin != NETFS_DIO_READ &&
-	    iov_iter_count(&subreq->io_iter) != subreq->len - subreq->transferred)
-		pr_warn("R=%08x[%u] ITER PRE-MISMATCH %zx != %zx-%zx %lx\n",
-			rreq->debug_id, subreq->debug_index,
-			iov_iter_count(&subreq->io_iter), subreq->len,
-			subreq->transferred, subreq->flags);
-	rreq->netfs_ops->issue_read(subreq);
-}
-
-/*
- * Release those waiting.
- */
-static void netfs_rreq_completed(struct netfs_io_request *rreq, bool was_async)
-{
-	trace_netfs_rreq(rreq, netfs_rreq_trace_done);
-	netfs_clear_subrequests(rreq, was_async);
-	netfs_put_request(rreq, was_async, netfs_rreq_trace_put_complete);
-}
-
-/*
- * [DEPRECATED] Deal with the completion of writing the data to the cache.  We
- * have to clear the PG_fscache bits on the folios involved and release the
- * caller's ref.
- *
- * May be called in softirq mode and we inherit a ref from the caller.
- */
-static void netfs_rreq_unmark_after_write(struct netfs_io_request *rreq,
-					  bool was_async)
-{
-	struct netfs_io_subrequest *subreq;
-	struct folio *folio;
-	pgoff_t unlocked = 0;
-	bool have_unlocked = false;
-
-	rcu_read_lock();
-
-	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-		XA_STATE(xas, &rreq->mapping->i_pages, subreq->start / PAGE_SIZE);
-
-		xas_for_each(&xas, folio, (subreq->start + subreq->len - 1) / PAGE_SIZE) {
-			if (xas_retry(&xas, folio))
-				continue;
-
-			/* We might have multiple writes from the same huge
-			 * folio, but we mustn't unlock a folio more than once.
-			 */
-			if (have_unlocked && folio->index <= unlocked)
-				continue;
-			unlocked = folio_next_index(folio) - 1;
-			trace_netfs_folio(folio, netfs_folio_trace_end_copy);
-			folio_end_private_2(folio);
-			have_unlocked = true;
-		}
-	}
-
-	rcu_read_unlock();
-	netfs_rreq_completed(rreq, was_async);
-}
-
-static void netfs_rreq_copy_terminated(void *priv, ssize_t transferred_or_error,
-				       bool was_async) /* [DEPRECATED] */
-{
-	struct netfs_io_subrequest *subreq = priv;
-	struct netfs_io_request *rreq = subreq->rreq;
-
-	if (IS_ERR_VALUE(transferred_or_error)) {
-		netfs_stat(&netfs_n_rh_write_failed);
-		trace_netfs_failure(rreq, subreq, transferred_or_error,
-				    netfs_fail_copy_to_cache);
-	} else {
-		netfs_stat(&netfs_n_rh_write_done);
-	}
-
-	trace_netfs_sreq(subreq, netfs_sreq_trace_write_term);
-
-	/* If we decrement nr_copy_ops to 0, the ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_copy_ops))
-		netfs_rreq_unmark_after_write(rreq, was_async);
-
-	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
-}
-
-/*
- * [DEPRECATED] Perform any outstanding writes to the cache.  We inherit a ref
- * from the caller.
- */
-static void netfs_rreq_do_write_to_cache(struct netfs_io_request *rreq)
-{
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-	struct netfs_io_subrequest *subreq, *next, *p;
-	struct iov_iter iter;
-	int ret;
-
-	trace_netfs_rreq(rreq, netfs_rreq_trace_copy);
-
-	/* We don't want terminating writes trying to wake us up whilst we're
-	 * still going through the list.
-	 */
-	atomic_inc(&rreq->nr_copy_ops);
-
-	list_for_each_entry_safe(subreq, p, &rreq->subrequests, rreq_link) {
-		if (!test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags)) {
-			list_del_init(&subreq->rreq_link);
-			netfs_put_subrequest(subreq, false,
-					     netfs_sreq_trace_put_no_copy);
-		}
-	}
-
-	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-		/* Amalgamate adjacent writes */
-		while (!list_is_last(&subreq->rreq_link, &rreq->subrequests)) {
-			next = list_next_entry(subreq, rreq_link);
-			if (next->start != subreq->start + subreq->len)
-				break;
-			subreq->len += next->len;
-			list_del_init(&next->rreq_link);
-			netfs_put_subrequest(next, false,
-					     netfs_sreq_trace_put_merged);
-		}
-
-		ret = cres->ops->prepare_write(cres, &subreq->start, &subreq->len,
-					       subreq->len, rreq->i_size, true);
-		if (ret < 0) {
-			trace_netfs_failure(rreq, subreq, ret, netfs_fail_prepare_write);
-			trace_netfs_sreq(subreq, netfs_sreq_trace_write_skip);
-			continue;
-		}
-
-		iov_iter_xarray(&iter, ITER_SOURCE, &rreq->mapping->i_pages,
-				subreq->start, subreq->len);
-
-		atomic_inc(&rreq->nr_copy_ops);
-		netfs_stat(&netfs_n_rh_write);
-		netfs_get_subrequest(subreq, netfs_sreq_trace_get_copy_to_cache);
-		trace_netfs_sreq(subreq, netfs_sreq_trace_write);
-		cres->ops->write(cres, subreq->start, &iter,
-				 netfs_rreq_copy_terminated, subreq);
-	}
-
-	/* If we decrement nr_copy_ops to 0, the usage ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_copy_ops))
-		netfs_rreq_unmark_after_write(rreq, false);
-}
-
-static void netfs_rreq_write_to_cache_work(struct work_struct *work) /* [DEPRECATED] */
-{
-	struct netfs_io_request *rreq =
-		container_of(work, struct netfs_io_request, work);
-
-	netfs_rreq_do_write_to_cache(rreq);
-}
-
-static void netfs_rreq_write_to_cache(struct netfs_io_request *rreq) /* [DEPRECATED] */
-{
-	rreq->work.func = netfs_rreq_write_to_cache_work;
-	if (!queue_work(system_unbound_wq, &rreq->work))
-		BUG();
-}
-
-/*
- * Handle a short read.
- */
-static void netfs_rreq_short_read(struct netfs_io_request *rreq,
-				  struct netfs_io_subrequest *subreq)
-{
-	__clear_bit(NETFS_SREQ_SHORT_IO, &subreq->flags);
-	__set_bit(NETFS_SREQ_SEEK_DATA_READ, &subreq->flags);
-
-	netfs_stat(&netfs_n_rh_short_read);
-	trace_netfs_sreq(subreq, netfs_sreq_trace_resubmit_short);
-
-	netfs_get_subrequest(subreq, netfs_sreq_trace_get_short_read);
-	atomic_inc(&rreq->nr_outstanding);
-	if (subreq->source == NETFS_READ_FROM_CACHE)
-		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_CLEAR);
-	else
-		netfs_read_from_server(rreq, subreq);
-}
-
-/*
- * Reset the subrequest iterator prior to resubmission.
- */
-static void netfs_reset_subreq_iter(struct netfs_io_request *rreq,
-				    struct netfs_io_subrequest *subreq)
-{
-	size_t remaining = subreq->len - subreq->transferred;
-	size_t count = iov_iter_count(&subreq->io_iter);
-
-	if (count == remaining)
-		return;
-
-	_debug("R=%08x[%u] ITER RESUB-MISMATCH %zx != %zx-%zx-%llx %x\n",
-	       rreq->debug_id, subreq->debug_index,
-	       iov_iter_count(&subreq->io_iter), subreq->transferred,
-	       subreq->len, rreq->i_size,
-	       subreq->io_iter.iter_type);
-
-	if (count < remaining)
-		iov_iter_revert(&subreq->io_iter, remaining - count);
-	else
-		iov_iter_advance(&subreq->io_iter, count - remaining);
-}
-
-/*
- * Resubmit any short or failed operations.  Returns true if we got the rreq
- * ref back.
- */
-static bool netfs_rreq_perform_resubmissions(struct netfs_io_request *rreq)
-{
-	struct netfs_io_subrequest *subreq;
-
-	WARN_ON(in_interrupt());
-
-	trace_netfs_rreq(rreq, netfs_rreq_trace_resubmit);
-
-	/* We don't want terminating submissions trying to wake us up whilst
-	 * we're still going through the list.
-	 */
-	atomic_inc(&rreq->nr_outstanding);
-
-	__clear_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
-	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-		if (subreq->error) {
-			if (subreq->source != NETFS_READ_FROM_CACHE)
-				break;
-			subreq->source = NETFS_DOWNLOAD_FROM_SERVER;
-			subreq->error = 0;
-			netfs_stat(&netfs_n_rh_download_instead);
-			trace_netfs_sreq(subreq, netfs_sreq_trace_download_instead);
-			netfs_get_subrequest(subreq, netfs_sreq_trace_get_resubmit);
-			atomic_inc(&rreq->nr_outstanding);
-			netfs_reset_subreq_iter(rreq, subreq);
-			netfs_read_from_server(rreq, subreq);
-		} else if (test_bit(NETFS_SREQ_SHORT_IO, &subreq->flags)) {
-			netfs_rreq_short_read(rreq, subreq);
-		}
-	}
-
-	/* If we decrement nr_outstanding to 0, the usage ref belongs to us. */
-	if (atomic_dec_and_test(&rreq->nr_outstanding))
-		return true;
-
-	wake_up_var(&rreq->nr_outstanding);
-	return false;
-}
-
-/*
- * Check to see if the data read is still valid.
- */
-static void netfs_rreq_is_still_valid(struct netfs_io_request *rreq)
-{
-	struct netfs_io_subrequest *subreq;
-
-	if (!rreq->netfs_ops->is_still_valid ||
-	    rreq->netfs_ops->is_still_valid(rreq))
-		return;
-
-	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-		if (subreq->source == NETFS_READ_FROM_CACHE) {
-			subreq->error = -ESTALE;
-			__set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
-		}
-	}
-}
-
-/*
- * Determine how much we can admit to having read from a DIO read.
- */
-static void netfs_rreq_assess_dio(struct netfs_io_request *rreq)
-{
-	struct netfs_io_subrequest *subreq;
-	unsigned int i;
-	size_t transferred = 0;
-
-	for (i = 0; i < rreq->direct_bv_count; i++) {
-		flush_dcache_page(rreq->direct_bv[i].bv_page);
-		// TODO: cifs marks pages in the destination buffer
-		// dirty under some circumstances after a read.  Do we
-		// need to do that too?
-		set_page_dirty(rreq->direct_bv[i].bv_page);
-	}
-
-	list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
-		if (subreq->error || subreq->transferred == 0)
-			break;
-		transferred += subreq->transferred;
-		if (subreq->transferred < subreq->len)
-			break;
-	}
-
-	for (i = 0; i < rreq->direct_bv_count; i++)
-		flush_dcache_page(rreq->direct_bv[i].bv_page);
-
-	rreq->transferred = transferred;
-	task_io_account_read(transferred);
-
-	if (rreq->iocb) {
-		rreq->iocb->ki_pos += transferred;
-		if (rreq->iocb->ki_complete)
-			rreq->iocb->ki_complete(
-				rreq->iocb, rreq->error ? rreq->error : transferred);
-	}
-	if (rreq->netfs_ops->done)
-		rreq->netfs_ops->done(rreq);
-	inode_dio_end(rreq->inode);
-}
-
-/*
- * Assess the state of a read request and decide what to do next.
- *
- * Note that we could be in an ordinary kernel thread, on a workqueue or in
- * softirq context at this point.  We inherit a ref from the caller.
- */
-static void netfs_rreq_assess(struct netfs_io_request *rreq, bool was_async)
-{
-	trace_netfs_rreq(rreq, netfs_rreq_trace_assess);
-
-again:
-	netfs_rreq_is_still_valid(rreq);
-
-	if (!test_bit(NETFS_RREQ_FAILED, &rreq->flags) &&
-	    test_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags)) {
-		if (netfs_rreq_perform_resubmissions(rreq))
-			goto again;
-		return;
-	}
-
-	if (rreq->origin != NETFS_DIO_READ)
-		netfs_rreq_unlock_folios(rreq);
-	else
-		netfs_rreq_assess_dio(rreq);
-
-	trace_netfs_rreq(rreq, netfs_rreq_trace_wake_ip);
-	clear_bit_unlock(NETFS_RREQ_IN_PROGRESS, &rreq->flags);
-	wake_up_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS);
-
-	if (test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags) &&
-	    test_bit(NETFS_RREQ_USE_PGPRIV2, &rreq->flags))
-		return netfs_rreq_write_to_cache(rreq);
-
-	netfs_rreq_completed(rreq, was_async);
-}
-
-void netfs_rreq_work(struct work_struct *work)
-{
-	struct netfs_io_request *rreq =
-		container_of(work, struct netfs_io_request, work);
-	netfs_rreq_assess(rreq, false);
-}
-
-/*
- * Handle the completion of all outstanding I/O operations on a read request.
- * We inherit a ref from the caller.
- */
-static void netfs_rreq_terminated(struct netfs_io_request *rreq,
-				  bool was_async)
-{
-	if (test_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags) &&
-	    was_async) {
-		if (!queue_work(system_unbound_wq, &rreq->work))
-			BUG();
-	} else {
-		netfs_rreq_assess(rreq, was_async);
-	}
-}
-
-/**
- * netfs_subreq_terminated - Note the termination of an I/O operation.
- * @subreq: The I/O request that has terminated.
- * @transferred_or_error: The amount of data transferred or an error code.
- * @was_async: The termination was asynchronous
- *
- * This tells the read helper that a contributory I/O operation has terminated,
- * one way or another, and that it should integrate the results.
- *
- * The caller indicates in @transferred_or_error the outcome of the operation,
- * supplying a positive value to indicate the number of bytes transferred, 0 to
- * indicate a failure to transfer anything that should be retried or a negative
- * error code.  The helper will look after reissuing I/O operations as
- * appropriate and writing downloaded data to the cache.
- *
- * If @was_async is true, the caller might be running in softirq or interrupt
- * context and we can't sleep.
- */
-void netfs_subreq_terminated(struct netfs_io_subrequest *subreq,
-			     ssize_t transferred_or_error,
-			     bool was_async)
-{
-	struct netfs_io_request *rreq = subreq->rreq;
-	int u;
-
-	_enter("R=%x[%x]{%llx,%lx},%zd",
-	       rreq->debug_id, subreq->debug_index,
-	       subreq->start, subreq->flags, transferred_or_error);
-
-	switch (subreq->source) {
-	case NETFS_READ_FROM_CACHE:
-		netfs_stat(&netfs_n_rh_read_done);
-		break;
-	case NETFS_DOWNLOAD_FROM_SERVER:
-		netfs_stat(&netfs_n_rh_download_done);
-		break;
-	default:
-		break;
-	}
-
-	if (IS_ERR_VALUE(transferred_or_error)) {
-		subreq->error = transferred_or_error;
-		trace_netfs_failure(rreq, subreq, transferred_or_error,
-				    netfs_fail_read);
-		goto failed;
-	}
-
-	if (WARN(transferred_or_error > subreq->len - subreq->transferred,
-		 "Subreq overread: R%x[%x] %zd > %zu - %zu",
-		 rreq->debug_id, subreq->debug_index,
-		 transferred_or_error, subreq->len, subreq->transferred))
-		transferred_or_error = subreq->len - subreq->transferred;
-
-	subreq->error = 0;
-	subreq->transferred += transferred_or_error;
-	if (subreq->transferred < subreq->len)
-		goto incomplete;
-
-complete:
-	__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
-	if (test_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags))
-		set_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags);
-
-out:
-	trace_netfs_sreq(subreq, netfs_sreq_trace_terminated);
-
-	/* If we decrement nr_outstanding to 0, the ref belongs to us. */
-	u = atomic_dec_return(&rreq->nr_outstanding);
-	if (u == 0)
-		netfs_rreq_terminated(rreq, was_async);
-	else if (u == 1)
-		wake_up_var(&rreq->nr_outstanding);
-
-	netfs_put_subrequest(subreq, was_async, netfs_sreq_trace_put_terminated);
-	return;
-
-incomplete:
-	if (test_bit(NETFS_SREQ_CLEAR_TAIL, &subreq->flags)) {
-		netfs_clear_unread(subreq);
-		subreq->transferred = subreq->len;
-		goto complete;
-	}
-
-	if (transferred_or_error == 0) {
-		if (__test_and_set_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags)) {
-			if (rreq->origin != NETFS_DIO_READ)
-				subreq->error = -ENODATA;
-			goto failed;
-		}
-	} else {
-		__clear_bit(NETFS_SREQ_NO_PROGRESS, &subreq->flags);
-	}
-
-	__set_bit(NETFS_SREQ_SHORT_IO, &subreq->flags);
-	set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
-	goto out;
-
-failed:
-	if (subreq->source == NETFS_READ_FROM_CACHE) {
-		netfs_stat(&netfs_n_rh_read_failed);
-		set_bit(NETFS_RREQ_INCOMPLETE_IO, &rreq->flags);
-	} else {
-		netfs_stat(&netfs_n_rh_download_failed);
-		set_bit(NETFS_RREQ_FAILED, &rreq->flags);
-		rreq->error = subreq->error;
-	}
-	goto out;
-}
-EXPORT_SYMBOL(netfs_subreq_terminated);
-
-static enum netfs_io_source netfs_cache_prepare_read(struct netfs_io_subrequest *subreq,
-						       loff_t i_size)
-{
-	struct netfs_io_request *rreq = subreq->rreq;
-	struct netfs_cache_resources *cres = &rreq->cache_resources;
-
-	if (cres->ops)
-		return cres->ops->prepare_read(subreq, i_size);
-	if (subreq->start >= rreq->i_size)
-		return NETFS_FILL_WITH_ZEROES;
-	return NETFS_DOWNLOAD_FROM_SERVER;
-}
-
-/*
- * Work out what sort of subrequest the next one will be.
- */
-static enum netfs_io_source
-netfs_rreq_prepare_read(struct netfs_io_request *rreq,
-			struct netfs_io_subrequest *subreq,
-			struct iov_iter *io_iter)
-{
-	enum netfs_io_source source = NETFS_DOWNLOAD_FROM_SERVER;
-	struct netfs_inode *ictx = netfs_inode(rreq->inode);
-	size_t lsize;
-
-	_enter("%llx-%llx,%llx", subreq->start, subreq->start + subreq->len, rreq->i_size);
-
-	if (rreq->origin != NETFS_DIO_READ) {
-		source = netfs_cache_prepare_read(subreq, rreq->i_size);
-		if (source == NETFS_INVALID_READ)
-			goto out;
-	}
-
-	if (source == NETFS_DOWNLOAD_FROM_SERVER) {
-		/* Call out to the netfs to let it shrink the request to fit
-		 * its own I/O sizes and boundaries.  If it shinks it here, it
-		 * will be called again to make simultaneous calls; if it wants
-		 * to make serial calls, it can indicate a short read and then
-		 * we will call it again.
-		 */
-		if (rreq->origin != NETFS_DIO_READ) {
-			if (subreq->start >= ictx->zero_point) {
-				source = NETFS_FILL_WITH_ZEROES;
-				goto set;
-			}
-			if (subreq->len > ictx->zero_point - subreq->start)
-				subreq->len = ictx->zero_point - subreq->start;
-
-			/* We limit buffered reads to the EOF, but let the
-			 * server deal with larger-than-EOF DIO/unbuffered
-			 * reads.
-			 */
-			if (subreq->len > rreq->i_size - subreq->start)
-				subreq->len = rreq->i_size - subreq->start;
-		}
-		if (rreq->rsize && subreq->len > rreq->rsize)
-			subreq->len = rreq->rsize;
-
-		if (rreq->netfs_ops->clamp_length &&
-		    !rreq->netfs_ops->clamp_length(subreq)) {
-			source = NETFS_INVALID_READ;
-			goto out;
-		}
-
-		if (rreq->io_streams[0].sreq_max_segs) {
-			lsize = netfs_limit_iter(io_iter, 0, subreq->len,
-						 rreq->io_streams[0].sreq_max_segs);
-			if (subreq->len > lsize) {
-				subreq->len = lsize;
-				trace_netfs_sreq(subreq, netfs_sreq_trace_limited);
-			}
-		}
-	}
-
-set:
-	if (subreq->len > rreq->len)
-		pr_warn("R=%08x[%u] SREQ>RREQ %zx > %llx\n",
-			rreq->debug_id, subreq->debug_index,
-			subreq->len, rreq->len);
-
-	if (WARN_ON(subreq->len == 0)) {
-		source = NETFS_INVALID_READ;
-		goto out;
-	}
-
-	subreq->source = source;
-	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
-
-	subreq->io_iter = *io_iter;
-	iov_iter_truncate(&subreq->io_iter, subreq->len);
-	iov_iter_advance(io_iter, subreq->len);
-out:
-	subreq->source = source;
-	trace_netfs_sreq(subreq, netfs_sreq_trace_prepare);
-	return source;
-}
-
-/*
- * Slice off a piece of a read request and submit an I/O request for it.
- */
-static bool netfs_rreq_submit_slice(struct netfs_io_request *rreq,
-				    struct iov_iter *io_iter)
-{
-	struct netfs_io_subrequest *subreq;
-	enum netfs_io_source source;
-
-	subreq = netfs_alloc_subrequest(rreq);
-	if (!subreq)
-		return false;
-
-	subreq->start		= rreq->start + rreq->submitted;
-	subreq->len		= io_iter->count;
-
-	_debug("slice %llx,%zx,%llx", subreq->start, subreq->len, rreq->submitted);
-	list_add_tail(&subreq->rreq_link, &rreq->subrequests);
-
-	/* Call out to the cache to find out what it can do with the remaining
-	 * subset.  It tells us in subreq->flags what it decided should be done
-	 * and adjusts subreq->len down if the subset crosses a cache boundary.
-	 *
-	 * Then when we hand the subset, it can choose to take a subset of that
-	 * (the starts must coincide), in which case, we go around the loop
-	 * again and ask it to download the next piece.
-	 */
-	source = netfs_rreq_prepare_read(rreq, subreq, io_iter);
-	if (source == NETFS_INVALID_READ)
-		goto subreq_failed;
-
-	atomic_inc(&rreq->nr_outstanding);
-
-	rreq->submitted += subreq->len;
-
-	trace_netfs_sreq(subreq, netfs_sreq_trace_submit);
-	switch (source) {
-	case NETFS_FILL_WITH_ZEROES:
-		netfs_fill_with_zeroes(rreq, subreq);
-		break;
-	case NETFS_DOWNLOAD_FROM_SERVER:
-		netfs_read_from_server(rreq, subreq);
-		break;
-	case NETFS_READ_FROM_CACHE:
-		netfs_read_from_cache(rreq, subreq, NETFS_READ_HOLE_IGNORE);
-		break;
-	default:
-		BUG();
-	}
-
-	return true;
-
-subreq_failed:
-	rreq->error = subreq->error;
-	netfs_put_subrequest(subreq, false, netfs_sreq_trace_put_failed);
-	return false;
-}
-
-/*
- * Begin the process of reading in a chunk of data, where that data may be
- * stitched together from multiple sources, including multiple servers and the
- * local cache.
- */
-int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
-{
-	struct iov_iter io_iter;
-	int ret;
-
-	_enter("R=%x %llx-%llx",
-	       rreq->debug_id, rreq->start, rreq->start + rreq->len - 1);
-
-	if (rreq->len == 0) {
-		pr_err("Zero-sized read [R=%x]\n", rreq->debug_id);
-		return -EIO;
-	}
-
-	if (rreq->origin == NETFS_DIO_READ)
-		inode_dio_begin(rreq->inode);
-
-	// TODO: Use bounce buffer if requested
-	rreq->io_iter = rreq->iter;
-
-	/* Chop the read into slices according to what the cache and the netfs
-	 * want and submit each one.
-	 */
-	netfs_get_request(rreq, netfs_rreq_trace_get_for_outstanding);
-	atomic_set(&rreq->nr_outstanding, 1);
-	io_iter = rreq->io_iter;
-	do {
-		_debug("submit %llx + %llx >= %llx",
-		       rreq->start, rreq->submitted, rreq->i_size);
-		if (!netfs_rreq_submit_slice(rreq, &io_iter))
-			break;
-		if (test_bit(NETFS_SREQ_NO_PROGRESS, &rreq->flags))
-			break;
-		if (test_bit(NETFS_RREQ_BLOCKED, &rreq->flags) &&
-		    test_bit(NETFS_RREQ_NONBLOCK, &rreq->flags))
-			break;
-
-	} while (rreq->submitted < rreq->len);
-
-	if (!rreq->submitted) {
-		netfs_put_request(rreq, false, netfs_rreq_trace_put_no_submit);
-		if (rreq->origin == NETFS_DIO_READ)
-			inode_dio_end(rreq->inode);
-		ret = 0;
-		goto out;
-	}
-
-	if (sync) {
-		/* Keep nr_outstanding incremented so that the ref always
-		 * belongs to us, and the service code isn't punted off to a
-		 * random thread pool to process.  Note that this might start
-		 * further work, such as writing to the cache.
-		 */
-		wait_var_event(&rreq->nr_outstanding,
-			       atomic_read(&rreq->nr_outstanding) == 1);
-		if (atomic_dec_and_test(&rreq->nr_outstanding))
-			netfs_rreq_assess(rreq, false);
-
-		trace_netfs_rreq(rreq, netfs_rreq_trace_wait_ip);
-		wait_on_bit(&rreq->flags, NETFS_RREQ_IN_PROGRESS,
-			    TASK_UNINTERRUPTIBLE);
-
-		ret = rreq->error;
-		if (ret == 0 && rreq->submitted < rreq->len &&
-		    rreq->origin != NETFS_DIO_READ) {
-			trace_netfs_failure(rreq, NULL, ret, netfs_fail_short_read);
-			ret = -EIO;
-		}
-	} else {
-		/* If we decrement nr_outstanding to 0, the ref belongs to us. */
-		if (atomic_dec_and_test(&rreq->nr_outstanding))
-			netfs_rreq_assess(rreq, false);
-		ret = -EIOCBQUEUED;
-	}
-
-out:
-	return ret;
-}


