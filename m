Return-Path: <linux-cifs+bounces-3205-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 508C19B109F
	for <lists+linux-cifs@lfdr.de>; Fri, 25 Oct 2024 22:50:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C82F51F21651
	for <lists+linux-cifs@lfdr.de>; Fri, 25 Oct 2024 20:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C307F21FD89;
	Fri, 25 Oct 2024 20:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MM1LT1ep"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 573C821FD8C
	for <linux-cifs@vger.kernel.org>; Fri, 25 Oct 2024 20:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888956; cv=none; b=FfNMX5Lj3LNM1tXtRwgac8DU1Z/X0xbvriv8aPDY2JLPcbW6IowQqgNsEb0ifeZBnn2ntwqyWoux6YJeD/p8+XomKHkB55y36P/ZKC762tGOaGlvJ5Thxy11Alfj3GMBozmVDKne2SVf0rg4+g0F9jDYZMFcXgTiMUbG7Q3Bh+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888956; c=relaxed/simple;
	bh=nkE4MVxEsDjUpzt0UPjtwcqvHFnylhRjXNXoFmQlpmU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mkq3O3AfZtcy81cR0nPxmaoeSosseTV0Nd7IFIEf0cSvF7lmY+bEVlrYRImfDpTlOu/KOIVH9ewAMXciiUoAkkCfNPfdk9r6xziFoFfDIpoEjptQT6XfEzR+1r020axkLQzLC0S5xsI/cHMP8g4XWegLm01gBlzsxDGWMT+ftNc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=MM1LT1ep; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729888953;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NCjiDuYPLh8EX/SFjmoUAd9DPkvd6EWcQ/jqW9O8MdE=;
	b=MM1LT1epbudSunRo19scUecU5CreZBffvLli7MVl3JfFMhMxlwdfiqWPSMoRMUwUZYslA8
	eqkiw6TJWDowvLerdJosoWBl5AfDc3NzG7ufj52MTtcoSG3A8BIssHi/JojNVg4io9NoYy
	5E/l6GC6prkFPG5Y0rotZGiRavjonYY=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-383-4854QUjvPuqip3OEMXye1Q-1; Fri,
 25 Oct 2024 16:42:29 -0400
X-MC-Unique: 4854QUjvPuqip3OEMXye1Q-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 733CB19560A7;
	Fri, 25 Oct 2024 20:42:26 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id A50F6196BB7D;
	Fri, 25 Oct 2024 20:42:21 +0000 (UTC)
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
Subject: [PATCH v2 19/31] netfs: Add functions to build/clean a buffer in a folio_queue
Date: Fri, 25 Oct 2024 21:39:46 +0100
Message-ID: <20241025204008.4076565-20-dhowells@redhat.com>
In-Reply-To: <20241025204008.4076565-1-dhowells@redhat.com>
References: <20241025204008.4076565-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Add two netfslib functions to build up or clean up a buffer in a
folio_queue.  The first, netfs_alloc_folioq_buffer() will add folios to a
buffer, extending up at least to the given size.  If it can, it will add
multipage folios.  The folios are optionally have the mapping set and will
have the index set according to the distance from the front of the folio
queue.

The second function will free up a folio queue and put any folios in the
queue that have the first mark set.

The netfs_folio tracepoint is also altered to cope with folios that have a
NULL mapping, and the folios being added/put will have trace lines emitted
and will be accounted in the stats.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: netfs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/misc.c              | 95 ++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h        |  6 +++
 include/trace/events/netfs.h |  6 +--
 3 files changed, 103 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 4249715f4171..01a6ba0e2f82 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -8,6 +8,101 @@
 #include <linux/swap.h>
 #include "internal.h"
 
+/**
+ * netfs_alloc_folioq_buffer - Allocate buffer space into a folio queue
+ * @mapping: Address space to set on the folio (or NULL).
+ * @_buffer: Pointer to the folio queue to add to (may point to a NULL; updated).
+ * @_cur_size: Current size of the buffer (updated).
+ * @size: Target size of the buffer.
+ * @gfp: The allocation constraints.
+ */
+int netfs_alloc_folioq_buffer(struct address_space *mapping,
+			      struct folio_queue **_buffer,
+			      size_t *_cur_size, ssize_t size, gfp_t gfp)
+{
+	struct folio_queue *tail = *_buffer, *p;
+
+	size = round_up(size, PAGE_SIZE);
+	if (*_cur_size >= size)
+		return 0;
+
+	if (tail)
+		while (tail->next)
+			tail = tail->next;
+
+	do {
+		struct folio *folio;
+		int order = 0, slot;
+
+		if (!tail || folioq_full(tail)) {
+			p = netfs_folioq_alloc(0, GFP_NOFS, netfs_trace_folioq_alloc_buffer);
+			if (!p)
+				return -ENOMEM;
+			if (tail) {
+				tail->next = p;
+				p->prev = tail;
+			} else {
+				*_buffer = p;
+			}
+			tail = p;
+		}
+
+		if (size - *_cur_size > PAGE_SIZE)
+			order = umin(ilog2(size - *_cur_size) - PAGE_SHIFT,
+				     MAX_PAGECACHE_ORDER);
+
+		folio = folio_alloc(gfp, order);
+		if (!folio && order > 0)
+			folio = folio_alloc(gfp, 0);
+		if (!folio)
+			return -ENOMEM;
+
+		folio->mapping = mapping;
+		folio->index = *_cur_size / PAGE_SIZE;
+		trace_netfs_folio(folio, netfs_folio_trace_alloc_buffer);
+		slot = folioq_append_mark(tail, folio);
+		*_cur_size += folioq_folio_size(tail, slot);
+	} while (*_cur_size < size);
+
+	return 0;
+}
+EXPORT_SYMBOL(netfs_alloc_folioq_buffer);
+
+/**
+ * netfs_free_folioq_buffer - Free a folio queue.
+ * @fq: The start of the folio queue to free
+ *
+ * Free up a chain of folio_queues and, if marked, the marked folios they point
+ * to.
+ */
+void netfs_free_folioq_buffer(struct folio_queue *fq)
+{
+	struct folio_queue *next;
+	struct folio_batch fbatch;
+
+	folio_batch_init(&fbatch);
+
+	for (; fq; fq = next) {
+		for (int slot = 0; slot < folioq_count(fq); slot++) {
+			struct folio *folio = folioq_folio(fq, slot);
+			if (!folio ||
+			    !folioq_is_marked(fq, slot))
+				continue;
+
+			trace_netfs_folio(folio, netfs_folio_trace_put);
+			if (folio_batch_add(&fbatch, folio))
+				folio_batch_release(&fbatch);
+		}
+
+		netfs_stat_d(&netfs_n_folioq);
+		next = fq->next;
+		kfree(fq);
+	}
+
+	folio_batch_release(&fbatch);
+}
+EXPORT_SYMBOL(netfs_free_folioq_buffer);
+
 /*
  * Reset the subrequest iterator to refer just to the region remaining to be
  * read.  The iterator may or may not have been advanced by socket ops or
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 738c9c8763f0..921cfcfc62f1 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -458,6 +458,12 @@ struct folio_queue *netfs_folioq_alloc(unsigned int rreq_id, gfp_t gfp,
 void netfs_folioq_free(struct folio_queue *folioq,
 		       unsigned int /*enum netfs_trace_folioq*/ trace);
 
+/* Buffer wrangling helpers API. */
+int netfs_alloc_folioq_buffer(struct address_space *mapping,
+			      struct folio_queue **_buffer,
+			      size_t *_cur_size, ssize_t size, gfp_t gfp);
+void netfs_free_folioq_buffer(struct folio_queue *fq);
+
 /**
  * netfs_inode - Get the netfs inode context from the inode
  * @inode: The inode to query
diff --git a/include/trace/events/netfs.h b/include/trace/events/netfs.h
index 7c3c866ae183..167c89bc62e0 100644
--- a/include/trace/events/netfs.h
+++ b/include/trace/events/netfs.h
@@ -155,6 +155,7 @@
 	EM(netfs_streaming_filled_page,		"mod-streamw-f") \
 	EM(netfs_streaming_cont_filled_page,	"mod-streamw-f+") \
 	EM(netfs_folio_trace_abandon,		"abandon")	\
+	EM(netfs_folio_trace_alloc_buffer,	"alloc-buf")	\
 	EM(netfs_folio_trace_cancel_copy,	"cancel-copy")	\
 	EM(netfs_folio_trace_cancel_store,	"cancel-store")	\
 	EM(netfs_folio_trace_clear,		"clear")	\
@@ -195,10 +196,7 @@
 	E_(netfs_trace_donate_to_deferred_next,	"defer-next")
 
 #define netfs_folioq_traces					\
-	EM(netfs_trace_folioq_alloc_append_folio, "alloc-apf")	\
-	EM(netfs_trace_folioq_alloc_read_prep,	"alloc-r-prep")	\
-	EM(netfs_trace_folioq_alloc_read_prime,	"alloc-r-prime") \
-	EM(netfs_trace_folioq_alloc_read_sing,	"alloc-r-sing")	\
+	EM(netfs_trace_folioq_alloc_buffer,	"alloc-buf")	\
 	EM(netfs_trace_folioq_clear,		"clear")	\
 	EM(netfs_trace_folioq_delete,		"delete")	\
 	EM(netfs_trace_folioq_make_space,	"make-space")	\


