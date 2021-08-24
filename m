Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BEDA3F5EEE
	for <lists+linux-cifs@lfdr.de>; Tue, 24 Aug 2021 15:25:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237555AbhHXNZo (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 24 Aug 2021 09:25:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:47059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237551AbhHXNZn (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 24 Aug 2021 09:25:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629811499;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G+4vtigOnbB4xKnVedwIs1VfbakOzdLgEC5FdZhN+eM=;
        b=Oq3mLaGXsa67GBSeyXWzmb/RhQSZvRbP2/tfOGuj1QLj+kyTiMdqXumSlXm263Th48l4ha
        JKiRtOIGxblRKPKfXVH/TkoDvu8Ug3DpfAUoK7hPqfYCDF8KDUWksijt/54lePPsJfMz8M
        KGcuUJ5kF2pEAEdLWNwZ9W++yBmGuRk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-264-rXlAd7NoOhOg2t924fZCug-1; Tue, 24 Aug 2021 09:24:55 -0400
X-MC-Unique: rXlAd7NoOhOg2t924fZCug-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D95B91082921;
        Tue, 24 Aug 2021 13:24:53 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.86])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5F82F5DF21;
        Tue, 24 Aug 2021 13:24:48 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 1/6] afs: Fix afs_launder_page() to set correct start file
 position
From:   David Howells <dhowells@redhat.com>
To:     "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Jeffrey Altman <jaltman@auristor.com>,
        linux-afs@lists.infradead.org, dhowells@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        linux-fsdevel@vger.kernel.org, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net, devel@lists.orangefs.org,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Date:   Tue, 24 Aug 2021 14:24:47 +0100
Message-ID: <162981148752.1901565.3663780601682206026.stgit@warthog.procyon.org.uk>
In-Reply-To: <162981147473.1901565.1455657509200944265.stgit@warthog.procyon.org.uk>
References: <162981147473.1901565.1455657509200944265.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Fix afs_launder_page() to set the starting position of the StoreData RPC at
the offset into the page at which the modified data starts instead of at
the beginning of the page (the iov_iter is correctly offset).

The offset got lost during the conversion to passing an iov_iter into
afs_store_data().

Fixes: bd80d8a80e12 ("afs: Use ITER_XARRAY for writing")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeffrey Altman <jaltman@auristor.com>
cc: linux-afs@lists.infradead.org
Link: https://lore.kernel.org/r/162880783179.3421678.7795105718190440134.stgit@warthog.procyon.org.uk/
---

 fs/afs/write.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/afs/write.c b/fs/afs/write.c
index fb7d5c1cabde..fff4c7d88e0d 100644
--- a/fs/afs/write.c
+++ b/fs/afs/write.c
@@ -950,8 +950,8 @@ int afs_launder_page(struct page *page)
 		iov_iter_bvec(&iter, WRITE, bv, 1, bv[0].bv_len);
 
 		trace_afs_page_dirty(vnode, tracepoint_string("launder"), page);
-		ret = afs_store_data(vnode, &iter, (loff_t)page->index * PAGE_SIZE,
-				     true);
+		ret = afs_store_data(vnode, &iter,
+				     (loff_t)page->index * PAGE_SIZE + f, true);
 	}
 
 	trace_afs_page_dirty(vnode, tracepoint_string("laundered"), page);


