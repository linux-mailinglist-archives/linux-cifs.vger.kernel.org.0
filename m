Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D517F7C8A93
	for <lists+linux-cifs@lfdr.de>; Fri, 13 Oct 2023 18:16:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232736AbjJMQIA (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 13 Oct 2023 12:08:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbjJMQHZ (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 13 Oct 2023 12:07:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67B1D103
        for <linux-cifs@vger.kernel.org>; Fri, 13 Oct 2023 09:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1697213154;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=qXcme0kNMrH3V4PIjyzNcjxLbny8iXa7oebH1ad5t2M=;
        b=dUU79WV7w3MiBV8XfAp/mRIt18d+jC3LhvE2nvPzKlfRFNNEanw61RCzfM3vrh5dDdA9iO
        q4nt7rGm5IpW9q6Jrq0arpv+SVCsRJZVc5WpetAYHNUJN8DMdRVSEsBqbdIYDsnoHCNWux
        mbp56lP9T6OHzNaQ5zBzcGqRLJrfc+8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-110-wbIsFAmxMSm-WFxmFZQxmw-1; Fri, 13 Oct 2023 12:05:47 -0400
X-MC-Unique: wbIsFAmxMSm-WFxmFZQxmw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2D4EF280D584;
        Fri, 13 Oct 2023 16:05:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.226])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A81CC201F457;
        Fri, 13 Oct 2023 16:05:42 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Jeff Layton <jlayton@kernel.org>, Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Subject: [RFC PATCH 22/53] netfs: Prep to use folio->private for write grouping and streaming write
Date:   Fri, 13 Oct 2023 17:03:51 +0100
Message-ID: <20231013160423.2218093-23-dhowells@redhat.com>
In-Reply-To: <20231013160423.2218093-1-dhowells@redhat.com>
References: <20231013160423.2218093-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Prepare to use folio->private to hold information write grouping and
streaming write.  These are implemented in the same commit as they both
make use of folio->private and will be both checked at the same time in
several places.

"Write grouping" involves ordering the writeback of groups of writes, such
as is needed for ceph snaps.  A group is represented by a
filesystem-supplied object which must contain a netfs_group struct.  This
contains just a refcount and a pointer to a destructor.

"Streaming write" is the storage of data in folios that are marked dirty,
but not uptodate, to avoid unnecessary reads of data.  This is represented
by a netfs_folio struct.  This contains the offset and length of the
modified region plus the otherwise displaced write grouping pointer.

The way folio->private is multiplexed is:

 (1) If private is NULL then neither is in operation on a dirty folio.

 (2) If private is set, with bit 0 clear, then this points to a group.

 (3) If private is set, with bit 0 set, then this points to a netfs_folio
     struct (with bit 0 AND'ed out).

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/internal.h   | 28 ++++++++++++++++++++++++++
 fs/netfs/misc.c       | 46 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/netfs.h | 41 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 115 insertions(+)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index 46183dad4d50..83418a918ee1 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -147,6 +147,34 @@ static inline bool netfs_is_cache_enabled(struct netfs_inode *ctx)
 #endif
 }
 
+/*
+ * Get a ref on a netfs group attached to a dirty page (e.g. a ceph snap).
+ */
+static inline struct netfs_group *netfs_get_group(struct netfs_group *netfs_group)
+{
+	if (netfs_group)
+		refcount_inc(&netfs_group->ref);
+	return netfs_group;
+}
+
+/*
+ * Dispose of a netfs group attached to a dirty page (e.g. a ceph snap).
+ */
+static inline void netfs_put_group(struct netfs_group *netfs_group)
+{
+	if (netfs_group && refcount_dec_and_test(&netfs_group->ref))
+		netfs_group->free(netfs_group);
+}
+
+/*
+ * Dispose of a netfs group attached to a dirty page (e.g. a ceph snap).
+ */
+static inline void netfs_put_group_many(struct netfs_group *netfs_group, int nr)
+{
+	if (netfs_group && refcount_sub_and_test(nr, &netfs_group->ref))
+		netfs_group->free(netfs_group);
+}
+
 /*****************************************************************************/
 /*
  * debug tracing
diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index c70f856f3129..8a2a56f1f623 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -159,9 +159,55 @@ void netfs_clear_buffer(struct xarray *buffer)
  */
 void netfs_invalidate_folio(struct folio *folio, size_t offset, size_t length)
 {
+	struct netfs_folio *finfo = NULL;
+	size_t flen = folio_size(folio);
+
 	_enter("{%lx},%zx,%zx", folio_index(folio), offset, length);
 
 	folio_wait_fscache(folio);
+
+	if (!folio_test_private(folio))
+		return;
+
+	finfo = netfs_folio_info(folio);
+
+	if (offset == 0 && length >= flen)
+		goto erase_completely;
+
+	if (finfo) {
+		/* We have a partially uptodate page from a streaming write. */
+		unsigned int fstart = finfo->dirty_offset;
+		unsigned int fend = fstart + finfo->dirty_len;
+		unsigned int end = offset + length;
+
+		if (offset >= fend)
+			return;
+		if (end <= fstart)
+			return;
+		if (offset <= fstart && end >= fend)
+			goto erase_completely;
+		if (offset <= fstart && end > fstart)
+			goto reduce_len;
+		if (offset > fstart && end >= fend)
+			goto move_start;
+		/* A partial write was split.  The caller has already zeroed
+		 * it, so just absorb the hole.
+		 */
+	}
+	return;
+
+erase_completely:
+	netfs_put_group(netfs_folio_group(folio));
+	folio_detach_private(folio);
+	folio_clear_uptodate(folio);
+	kfree(finfo);
+	return;
+reduce_len:
+	finfo->dirty_len = offset + length - finfo->dirty_offset;
+	return;
+move_start:
+	finfo->dirty_len -= offset - finfo->dirty_offset;
+	finfo->dirty_offset = offset;
 }
 EXPORT_SYMBOL(netfs_invalidate_folio);
 
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 39b3eeefa03c..11a073506f98 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -142,6 +142,47 @@ struct netfs_inode {
 #define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
 };
 
+/*
+ * A netfs group - for instance a ceph snap.  This is marked on dirty pages and
+ * pages marked with a group must be flushed before they can be written under
+ * the domain of another group.
+ */
+struct netfs_group {
+	refcount_t		ref;
+	void (*free)(struct netfs_group *netfs_group);
+};
+
+/*
+ * Information about a dirty page (attached only if necessary).
+ * folio->private
+ */
+struct netfs_folio {
+	struct netfs_group	*netfs_group;	/* Filesystem's grouping marker (or NULL). */
+	unsigned int		dirty_offset;	/* Write-streaming dirty data offset */
+	unsigned int		dirty_len;	/* Write-streaming dirty data length */
+};
+#define NETFS_FOLIO_INFO	0x1UL	/* OR'd with folio->private. */
+
+static inline struct netfs_folio *netfs_folio_info(struct folio *folio)
+{
+	void *priv = folio_get_private(folio);
+
+	if ((unsigned long)priv & NETFS_FOLIO_INFO)
+		return (struct netfs_folio *)((unsigned long)priv & ~NETFS_FOLIO_INFO);
+	return NULL;
+}
+
+static inline struct netfs_group *netfs_folio_group(struct folio *folio)
+{
+	struct netfs_folio *finfo;
+	void *priv = folio_get_private(folio);
+
+	finfo = netfs_folio_info(folio);
+	if (finfo)
+		return finfo->netfs_group;
+	return priv;
+}
+
 /*
  * Resources required to do operations on a cache.
  */

