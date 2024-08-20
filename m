Return-Path: <linux-cifs+bounces-2526-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A55959127
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Aug 2024 01:23:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7FF211F241F2
	for <lists+linux-cifs@lfdr.de>; Tue, 20 Aug 2024 23:23:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 833B31CB303;
	Tue, 20 Aug 2024 23:21:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="B9hGyRkP"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81021C9ECC
	for <linux-cifs@vger.kernel.org>; Tue, 20 Aug 2024 23:21:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724196107; cv=none; b=ULEycJhWHcjk1ucGU3uATs+/rKsxDaX8NWY1KawFRZZwFNRQ+g5Q1njsmd7MU1oEx1xNiCTIxGYrsT1PmrLtaI9flQ+ahBbJd2QAgpCvs48smKPCi5eju3/4L/wyHGN/l39y6OvIQcPECsiJ5e3rj/hKRU35TYtJ/QpUy+qurD4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724196107; c=relaxed/simple;
	bh=ht8EIVhw2/1il8Rsom6afgUGDhA62o/6wQOgoApvk7U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bnsIKEzrIMLJgyD+gsE02UBt8VlaV1aElDNlXpjSV24HgBHtb5p6eYyItXRt8gOIw2g5jkyZ3PzCy5YWwTPryPhdwG3sfK8bAwybdth6fRPvYWPiHrJeWCAQ+/9PejJ6KoOK+dDLaCuAKMOu1HXuNGp2uvIT6FPgGDnfKm5XbXw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=B9hGyRkP; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724196105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=B4tfOtZ3an7b1aGGuqLauY14dten5jR69+zwwl0cSBE=;
	b=B9hGyRkPueEE9mcewQNeRdtS8YyQ4/PQoatgXoy8SBn2dPNzXx73L/VecYxllF234Xbg8a
	e0A4psSvFS6MmesTwX1QyCLJ+0HNGbLlfvgf5EFhTs2B0XbKdswEYSBcP8KDQe/FPDp0VY
	/Ccf1NpoyTvmu8IpJfkZ1pfD7G0oJpg=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-354-Mj8yoYdJNz-fatkw3PTnGQ-1; Tue,
 20 Aug 2024 19:21:36 -0400
X-MC-Unique: Mj8yoYdJNz-fatkw3PTnGQ-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 29EA31955D52;
	Tue, 20 Aug 2024 23:21:31 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id B0C261955F54;
	Tue, 20 Aug 2024 23:21:26 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Marc Dionne <marc.dionne@auristor.com>
Subject: [PATCH 3/4] netfs: Fix netfs_release_folio() to say no if folio dirty
Date: Wed, 21 Aug 2024 00:20:57 +0100
Message-ID: <20240820232105.3792638-4-dhowells@redhat.com>
In-Reply-To: <20240820232105.3792638-1-dhowells@redhat.com>
References: <20240820232105.3792638-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix netfs_release_folio() to say no (ie. return false) if the folio is
dirty (analogous with iomap's behaviour).  Without this, it will say yes to
the release of a dirty page by split_huge_page_to_list_to_order(), which
will result in the loss of untruncated data in the folio.

Without this, the generic/075 and generic/112 xfstests (both fsx-based
tests) fail with minimum folio size patches applied[1].

Fixes: c1ec4d7c2e13 ("netfs: Provide invalidate_folio and release_folio calls")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Matthew Wilcox (Oracle) <willy@infradead.org>
cc: Pankaj Raghav <p.raghav@samsung.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-mm@kvack.org
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/20240815090849.972355-1-kernel@pankajraghav.com/ [1]
---
 fs/netfs/misc.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
index 554a1a4615ad..69324761fcf7 100644
--- a/fs/netfs/misc.c
+++ b/fs/netfs/misc.c
@@ -161,6 +161,9 @@ bool netfs_release_folio(struct folio *folio, gfp_t gfp)
 	struct netfs_inode *ctx = netfs_inode(folio_inode(folio));
 	unsigned long long end;
 
+	if (folio_test_dirty(folio))
+		return false;
+
 	end = folio_pos(folio) + folio_size(folio);
 	if (end > ctx->zero_point)
 		ctx->zero_point = end;


