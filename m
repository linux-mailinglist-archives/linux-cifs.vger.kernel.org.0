Return-Path: <linux-cifs+bounces-1976-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D830D8B7855
	for <lists+linux-cifs@lfdr.de>; Tue, 30 Apr 2024 16:08:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 935EC281DBA
	for <lists+linux-cifs@lfdr.de>; Tue, 30 Apr 2024 14:08:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D25B172BCA;
	Tue, 30 Apr 2024 14:02:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WRmTiO5X"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8ECA175555
	for <linux-cifs@vger.kernel.org>; Tue, 30 Apr 2024 14:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714485733; cv=none; b=HhTri34jEujgfWaJVwBw58jMh2idEszusq6glke4jiJunbyTbQpKcxrbKIfLZq52ysCdiM8hPD+/K6NI+PtW4vS13+i/b64O5vAu5OfvC2G7852xA8uFAoff1za9X5YGV/MppaAvi8GnpHCVkhC2mSuYuPvP/L7IwYPU90f4ebc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714485733; c=relaxed/simple;
	bh=b31u1bZv47KcpUE2YEcbeJ9EX9O+/YAoXgPL9zxJe9E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kv29Z6tO6XEtYokIlDzfuGXntoWfPdvwxMUmABC/A69SYnp9lUg33oQ7qi8Z+IgR5ssqEEZAIkismOBKp5Vb9k7Y9a6hFwyL2tgdr6iPcIfHg7GCwPIcTDNJgLkuU1iKTsKnduIfOcn7+TPrqU3OqqoJpUxuYtvs3iKFEbsQNDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=WRmTiO5X; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714485731;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kjFRfxxSIhn/sZySlzA+YPg8ujVk0zbXsyNAbtLG88o=;
	b=WRmTiO5XOrVbdJe3hyVSWzSmUbxUlvxgPBPPyrDFn55MD/gZsit8rlBNcFUaLj+T56GbvX
	x/tmeX0bnGp9JaqwcsSceqbN0sCTqgJuRqWnDK0c5dYMF9dvVm2H7P6X+n4jAOzJPpm5lz
	h7ODe2oCiyKkFW60wLnt2Z2ImyEblbc=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-78-ESWFmT24OQqLiwHsx02-fA-1; Tue, 30 Apr 2024 10:02:03 -0400
X-MC-Unique: ESWFmT24OQqLiwHsx02-fA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9306E834FBF;
	Tue, 30 Apr 2024 14:01:55 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id CD5441C0654E;
	Tue, 30 Apr 2024 14:01:48 +0000 (UTC)
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
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 12/22] mm: Export writeback_iter()
Date: Tue, 30 Apr 2024 15:00:43 +0100
Message-ID: <20240430140056.261997-13-dhowells@redhat.com>
In-Reply-To: <20240430140056.261997-1-dhowells@redhat.com>
References: <20240430140056.261997-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Export writeback_iter() so that it can be used by netfslib as a module.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Jeff Layton <jlayton@kernel.org>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Christoph Hellwig <hch@lst.de>
cc: linux-mm@kvack.org
---

Notes:
    Changes
    =======
    ver #2)
     - Mark the symbol _GPL.

 mm/page-writeback.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/mm/page-writeback.c b/mm/page-writeback.c
index 3e19b87049db..06fc89d981e8 100644
--- a/mm/page-writeback.c
+++ b/mm/page-writeback.c
@@ -2546,6 +2546,7 @@ struct folio *writeback_iter(struct address_space *mapping,
 	folio_batch_release(&wbc->fbatch);
 	return NULL;
 }
+EXPORT_SYMBOL_GPL(writeback_iter);
 
 /**
  * write_cache_pages - walk the list of dirty pages of the given address space and write all of them.


