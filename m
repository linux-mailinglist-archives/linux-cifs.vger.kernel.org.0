Return-Path: <linux-cifs+bounces-1008-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6806A84021B
	for <lists+linux-cifs@lfdr.de>; Mon, 29 Jan 2024 10:50:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1680B1F22620
	for <lists+linux-cifs@lfdr.de>; Mon, 29 Jan 2024 09:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 604AC55E4E;
	Mon, 29 Jan 2024 09:49:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="C+ovavLR"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 008E75645F
	for <linux-cifs@vger.kernel.org>; Mon, 29 Jan 2024 09:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706521778; cv=none; b=uQ/LzLSLxA6z3i+YiSXQ06wVSiFbsbHq9XkpLOkRo16pmfnT7IhHjCBUSMEMYz3+MH3t5y/+1s+9I5dgx3Nm7m2rbagSju5Kwk6I6P2BZWF4hSgy1dRI4n2fhO67YJF5/a2EaZvHmAP5LjZXj3wg+MXyjZyO2lpB1iUdGDBy6qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706521778; c=relaxed/simple;
	bh=3SKQ1UY5AtuT9Hi3kMvGeBfzklACbNG9lR2rVyYGSFM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e1Ja2zMFNFnWkEWb1KJikZsmRoopVIO8++TyTnmYpCJCKnfe7VXcOxiJuvc5ggJf4KaZNRDZNCb+d8krT2DNpL+ZCGqR2VN/ADA//eaa9uLyDKUJkLpF3KF5mCsqyju+wTc+iVVu+Qq+r5E1M357cW9QS7KTWPewtZQwlI2NK6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=C+ovavLR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706521774;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=pRcl53v/D7LNYmHWLVDHFLzWMRLsRvElPDySPluG9Xk=;
	b=C+ovavLRBE7UFrezDOlKwLgut6MKJdxjY5j9aFrPIUUZm2DhPCXOoA+65C8gkQFP7Tf9UB
	VOrTrEpgya1NuhFJX/SkQpXtUeBhw/4rJMbk6QT9g3+4TEFFl7fja8iXbv6CdYU26zFUVt
	aeDqR8Zz8jxamyR9LPxZKCvIwmdpVFU=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-581-2MqNdY6VNp-CfaPkR9IzXg-1; Mon,
 29 Jan 2024 04:49:32 -0500
X-MC-Unique: 2MqNdY6VNp-CfaPkR9IzXg-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C0F563C2B606;
	Mon, 29 Jan 2024 09:49:31 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.245])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 4EF73492BC7;
	Mon, 29 Jan 2024 09:49:29 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
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
Subject: [PATCH 1/2] netfs: Fix i_dio_count leak on DIO read past i_size
Date: Mon, 29 Jan 2024 09:49:18 +0000
Message-ID: <20240129094924.1221977-2-dhowells@redhat.com>
In-Reply-To: <20240129094924.1221977-1-dhowells@redhat.com>
References: <20240129094924.1221977-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9

From: Marc Dionne <marc.dionne@auristor.com>

If netfs_begin_read gets a NETFS_DIO_READ request that begins
past i_size, it won't perform any i/o and just return 0.  This
will leak an increment to i_dio_count that is done at the top
of the function.

This can cause subsequent buffered read requests to block
indefinitely, waiting for a non existing dio operation to complete.

Add a inode_dio_end() for the NETFS_DIO_READ case, before returning.

Signed-off-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-afs@lists.infradead.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/io.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/netfs/io.c b/fs/netfs/io.c
index e8ff1e61ce79..4261ad6c55b6 100644
--- a/fs/netfs/io.c
+++ b/fs/netfs/io.c
@@ -748,6 +748,8 @@ int netfs_begin_read(struct netfs_io_request *rreq, bool sync)
 
 	if (!rreq->submitted) {
 		netfs_put_request(rreq, false, netfs_rreq_trace_put_no_submit);
+		if (rreq->origin == NETFS_DIO_READ)
+			inode_dio_end(rreq->inode);
 		ret = 0;
 		goto out;
 	}


