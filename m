Return-Path: <linux-cifs+bounces-3644-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01C7A9F3AE3
	for <lists+linux-cifs@lfdr.de>; Mon, 16 Dec 2024 21:35:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4031D16C5BA
	for <lists+linux-cifs@lfdr.de>; Mon, 16 Dec 2024 20:35:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2E641D47AF;
	Mon, 16 Dec 2024 20:35:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nf+agUPJ"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 697E71D2785
	for <linux-cifs@vger.kernel.org>; Mon, 16 Dec 2024 20:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381301; cv=none; b=juM8KS4n3DPru9IvPakQl9F6IVM7VCdNSoyZ+0P+yngjtq1llujG7k8WDonNdLyKVyFEaAUKRhZT/2Fk9OjjfFjBrD4np/jSnoMjw0klGkZIUssHtTy6sQzxeOhOuKtUZ20nb3LKnjgNe1zInSmnox0HtUHD4kIM2TV3Xlt5PCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381301; c=relaxed/simple;
	bh=SZDZJSjVc5zhdXXeycEYKDY+bf6/mxmwzv0HttjJEA0=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=sBdKK3+trSivqta1obhn1tnW/NO4D8anYXG0eCXbksDRHuJ2VFoN+T1HbK6n45WSJGhdrFXul0fLpdFrzaAylCgDYCOCHrTi8MsSqPVmozxYAv6m6qpsGjaPWnbizmhigpZDSC5YdNCE8RBsbWuIrPbt3DE80blPsulDMkk3up0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Nf+agUPJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3uel8b3F42MjWx1FV4MNqrLkM5e1s0/oyCwTXY7gJWI=;
	b=Nf+agUPJsqDviwGD4epPEcSKSGM6TiF1BgYs6ppn+34gpoKVqKj83PSCTF4qhD8JN0n1Ot
	o03Zly60VqUckNAOJe9vtvq0T3cQLNAKfowa/aolK8qzAyQLm/qY2KDBCREMzrwu++dupB
	1bzbI4olAbKkDX8fr7fHEBzCVOumPEo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-PLpJV9waPvq0rsK0CpjcQA-1; Mon,
 16 Dec 2024 15:34:55 -0500
X-MC-Unique: PLpJV9waPvq0rsK0CpjcQA-1
X-Mimecast-MFC-AGG-ID: PLpJV9waPvq0rsK0CpjcQA
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B245219560A3;
	Mon, 16 Dec 2024 20:34:51 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.48])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 6A88819560A2;
	Mon, 16 Dec 2024 20:34:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: dhowells@redhat.com, Max Kellermann <max.kellermann@ionos.com>,
    Ilya Dryomov <idryomov@gmail.com>, Xiubo Li <xiubli@redhat.com>,
    Trond Myklebust <trondmy@kernel.org>,
    Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, netfs@lists.linux.dev,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-erofs@lists.ozlabs.org,
    linux-fsdevel@vger.kernel.org, linux-mm@kvack.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH 11/10] netfs: Fix is-caching check in read-retry
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3752047.1734381285.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Dec 2024 20:34:45 +0000
Message-ID: <3752048.1734381285@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12

netfs: Fix is-caching check in read-retry

The read-retry code checks the NETFS_RREQ_COPY_TO_CACHE flag to determine
if there might be failed reads from the cache that need turning into reads
from the server, with the intention of skipping the complicated part if it
can.  The code that set the flag, however, got lost during the read-side
rewrite.

Fix the check to see if the cache_resources are valid instead.  The flag
can then be removed.

Fixes: ee4cdf7ba857 ("netfs: Speed up buffered reading")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/netfs/read_retry.c |    2 +-
 include/linux/netfs.h |    1 -
 2 files changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/netfs/read_retry.c b/fs/netfs/read_retry.c
index 0e72e9226fc8..21b4a54e545e 100644
--- a/fs/netfs/read_retry.c
+++ b/fs/netfs/read_retry.c
@@ -49,7 +49,7 @@ static void netfs_retry_read_subrequests(struct netfs_io=
_request *rreq)
 	 * up to the first permanently failed one.
 	 */
 	if (!rreq->netfs_ops->prepare_read &&
-	    !test_bit(NETFS_RREQ_COPY_TO_CACHE, &rreq->flags)) {
+	    !rreq->cache_resources.ops) {
 		struct netfs_io_subrequest *subreq;
 =

 		list_for_each_entry(subreq, &rreq->subrequests, rreq_link) {
diff --git a/include/linux/netfs.h b/include/linux/netfs.h
index 4083d77e3f39..ecdd5ced16a8 100644
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@ -269,7 +269,6 @@ struct netfs_io_request {
 	size_t			prev_donated;	/* Fallback for subreq->prev_donated */
 	refcount_t		ref;
 	unsigned long		flags;
-#define NETFS_RREQ_COPY_TO_CACHE	1	/* Need to write to the cache */
 #define NETFS_RREQ_NO_UNLOCK_FOLIO	2	/* Don't unlock no_unlock_folio on c=
ompletion */
 #define NETFS_RREQ_DONT_UNLOCK_FOLIOS	3	/* Don't unlock the folios on com=
pletion */
 #define NETFS_RREQ_FAILED		4	/* The request failed */


