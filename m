Return-Path: <linux-cifs+bounces-3258-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A17419BEA20
	for <lists+linux-cifs@lfdr.de>; Wed,  6 Nov 2024 13:41:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D41541C23AF6
	for <lists+linux-cifs@lfdr.de>; Wed,  6 Nov 2024 12:41:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A0DD1F5851;
	Wed,  6 Nov 2024 12:37:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Irqe8oFF"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50D5D1F6673
	for <linux-cifs@vger.kernel.org>; Wed,  6 Nov 2024 12:37:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730896644; cv=none; b=Q6vQHr3zIUU1OJ84R7M42uPl3KrHUM7LL7EmD0EVSXkVtqU32nNoXUnoDT2tRVWsVkuTyfgo5OjQaxxOmb/ljUp3ofszFCsuWNLnaLmdjMFmFM7rY3fNIFib6uTmqOAWgI7CC9EenUaaAB4hdPWwoiL2C8XPGOfMRHF2tbDY/Vc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730896644; c=relaxed/simple;
	bh=9SCEKbNtvAFB8fJZcHIRQXCI/OprF81chlgQt47QcC0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NZGo72DI180AqfQI/izHppDd6WsI1UzmWg2dd2Dnj1Bv4lyZnBRLZ9LppqVk/+ddis+5Nqcg/fB3BayDsuKXKjDVJj224AhFqJoNYyPv8+PyoXsDPJGPKML22ZBd5H4kZoiFALeUkzKXUZEumOZb4lVPfPmInb+ukUZ3Ry5JWTs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Irqe8oFF; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1730896642;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X3twVFG043O59vporSoGB49KW0yXOb7j0HiRw4sYWo4=;
	b=Irqe8oFF151aG9nzwM8cfUogyuRRjf713i6+6WPddbBvj0S5Qai9ywMUWt6BaI99IGYtB0
	UXC6/SBZHLabmduGnjfBBwkUOII0HmMt/0mcDRoUN5A5WQcj2OfXCCgSU21sx2k51ySPVn
	6yRqQzUrTzfI3W7+NNAloVwQveFY9g8=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-471--vc-UjHAN7GH84QOk_v9DA-1; Wed,
 06 Nov 2024 07:37:17 -0500
X-MC-Unique: -vc-UjHAN7GH84QOk_v9DA-1
X-Mimecast-MFC-AGG-ID: -vc-UjHAN7GH84QOk_v9DA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3A0371955D91;
	Wed,  6 Nov 2024 12:37:14 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id C38391956088;
	Wed,  6 Nov 2024 12:37:07 +0000 (UTC)
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
	linux-cachefs@redhat.com
Subject: [PATCH v3 08/33] netfs: Make netfs_advance_write() return size_t
Date: Wed,  6 Nov 2024 12:35:32 +0000
Message-ID: <20241106123559.724888-9-dhowells@redhat.com>
In-Reply-To: <20241106123559.724888-1-dhowells@redhat.com>
References: <20241106123559.724888-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

netfs_advance_write() calculates the amount of data it's attaching to a
stream with size_t, but then returns this as an int.  Switch the return
value to size_t for consistency.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/netfs/internal.h    | 6 +++---
 fs/netfs/write_issue.c | 6 +++---
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
index ccd9058acb61..6aa2a8d49b37 100644
--- a/fs/netfs/internal.h
+++ b/fs/netfs/internal.h
@@ -178,9 +178,9 @@ void netfs_reissue_write(struct netfs_io_stream *stream,
 			 struct iov_iter *source);
 void netfs_issue_write(struct netfs_io_request *wreq,
 		       struct netfs_io_stream *stream);
-int netfs_advance_write(struct netfs_io_request *wreq,
-			struct netfs_io_stream *stream,
-			loff_t start, size_t len, bool to_eof);
+size_t netfs_advance_write(struct netfs_io_request *wreq,
+			   struct netfs_io_stream *stream,
+			   loff_t start, size_t len, bool to_eof);
 struct netfs_io_request *netfs_begin_writethrough(struct kiocb *iocb, size_t len);
 int netfs_advance_writethrough(struct netfs_io_request *wreq, struct writeback_control *wbc,
 			       struct folio *folio, size_t copied, bool to_page_end,
diff --git a/fs/netfs/write_issue.c b/fs/netfs/write_issue.c
index 993cc6def38e..c186221b45c0 100644
--- a/fs/netfs/write_issue.c
+++ b/fs/netfs/write_issue.c
@@ -271,9 +271,9 @@ void netfs_issue_write(struct netfs_io_request *wreq,
  * we can avoid overrunning the credits obtained (cifs) and try to parallelise
  * content-crypto preparation with network writes.
  */
-int netfs_advance_write(struct netfs_io_request *wreq,
-			struct netfs_io_stream *stream,
-			loff_t start, size_t len, bool to_eof)
+size_t netfs_advance_write(struct netfs_io_request *wreq,
+			   struct netfs_io_stream *stream,
+			   loff_t start, size_t len, bool to_eof)
 {
 	struct netfs_io_subrequest *subreq = stream->construct;
 	size_t part;


