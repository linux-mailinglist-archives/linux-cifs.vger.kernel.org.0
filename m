Return-Path: <linux-cifs+bounces-2219-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 146BB910EE8
	for <lists+linux-cifs@lfdr.de>; Thu, 20 Jun 2024 19:36:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4598A1C23141
	for <lists+linux-cifs@lfdr.de>; Thu, 20 Jun 2024 17:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B63B1B4C4A;
	Thu, 20 Jun 2024 17:32:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VtdWAfmA"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C01E1B29C7
	for <linux-cifs@vger.kernel.org>; Thu, 20 Jun 2024 17:32:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718904750; cv=none; b=tS189f1Pc/astx65pr+BoxAemUEApu+HhteI0bTP8leyVZZtePBQMLUQVnhKEmQlv0EmiPmaXdZhrMHTVLmEcWhXCA4Be+EXjUl9X10o9Vcu5WKkxsomOWhILEr53HZq9uMxKYvTE4NGesrZ5BTnHM8YA2zD6aNDA0dRSA94A0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718904750; c=relaxed/simple;
	bh=uqr+c6TSD+IA6jAqPedpS4BUZPZmSd7r1lKskAQEvlI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BeM6JqoOJ2yJl4MAs0jpeFUF5IM8yjGpH3LhCxEXdRtqh+HMXBHPG6jnJca+69S+eWFy826GX/CVAAokKajD3jRVzUEU7T4G7sh8PYwrYySZUgMV9FIqlyIcsKclkE4t3K5RncieKDvkbvTq/XAU3aZ64IfI5ILS7Q0dO6HklAQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VtdWAfmA; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1718904747;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9Za3sI46DNoDRS2zLMaVKKAo5577Q7Mj2mbpphqJpg8=;
	b=VtdWAfmATd+WnUj5+hK9xWmq88oXubWhdhUy3+vxt5DtS9tBDBOUTI4xPSkAUGJ4cz1A5O
	qKSDJzbRIvwsrhVzDGNGEF2RFQSFmg6sGhe3Nm9Y5Tnf++gPzN6eQFbrvTeeJzTF/EvK0u
	OzQGXxqA5kIpIvzEPyS22/+dfTBZiqA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-133-lamvqmTDOOq2ya95QZA4mQ-1; Thu,
 20 Jun 2024 13:32:23 -0400
X-MC-Unique: lamvqmTDOOq2ya95QZA4mQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 270E61956068;
	Thu, 20 Jun 2024 17:32:16 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.39.195.156])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7215F3000602;
	Thu, 20 Jun 2024 17:32:08 +0000 (UTC)
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
	linux-kernel@vger.kernel.org,
	Latchesar Ionkov <lucho@ionkov.net>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Steve French <sfrench@samba.org>
Subject: [PATCH 03/17] netfs: Fix early issue of write op on partial write to folio tail
Date: Thu, 20 Jun 2024 18:31:21 +0100
Message-ID: <20240620173137.610345-4-dhowells@redhat.com>
In-Reply-To: <20240620173137.610345-1-dhowells@redhat.com>
References: <20240620173137.610345-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

During the writeback procedure, at the end of netfs_write_folio(), pending
write operations are flushed if the amount of write-streaming data stored
in a page is less than the size of the folio because if we haven't modified
a folio to the end, it cannot be contiguous with the following folio...
except if the dirty region of the folio is right at the end of the folio
space.

Fix the test to take the offset into the folio into account as well, such
that if the dirty region runs right up to the end of the folio, we leave
the flushing for later.

Fixes: 288ace2f57c9 ("netfs: New writeback implementation")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com> (DFS, global name space)
cc: v9fs@lists.linux.dev
cc: linux-afs@lists.infradead.org
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/write_issue.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 3aa86e268f40..ec6cf8707fb0 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -483,7 +483,7 @@ static int netfs_write_folio(struct netfs_io_request *wreq,
 	if (!debug)
 		kdebug("R=%x: No submit", wreq->debug_id);
 
-	if (flen < fsize)
+	if (foff + flen < fsize)
 		for (int s = 0; s < NR_IO_STREAMS; s++)
 			netfs_issue_write(wreq, &wreq->io_streams[s]);
 


