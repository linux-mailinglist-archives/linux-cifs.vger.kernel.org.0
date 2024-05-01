Return-Path: <linux-cifs+bounces-2007-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 610BD8B8971
	for <lists+linux-cifs@lfdr.de>; Wed,  1 May 2024 13:51:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 690801C217E8
	for <lists+linux-cifs@lfdr.de>; Wed,  1 May 2024 11:51:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4DCF81736;
	Wed,  1 May 2024 11:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CFBCYqd/"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D431C7CF3A
	for <linux-cifs@vger.kernel.org>; Wed,  1 May 2024 11:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714564284; cv=none; b=Hd3bxMxK4UBUs+66C0D7XBtxinQMdBeDHDeyBXM4gD0/9V+Jk2TmZGlIBQfBkpu1l3TFdewEZqsNnoZtOkg6f50OxETAgpejsHgqP5mxpNCHl3RgTEyZqypZAlax+tBCgzew7dapztGeBNcjNYCbyO1bYG6Z3rMc2MbEzeZAnyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714564284; c=relaxed/simple;
	bh=oVTq80pkXwyoy7TcJqALMpS8YpNVIddBTvSgvA6rBi8=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=knw/4SXL9YSLv5CzfSvs07tydnccHlQ76LrEhKcXMU9VtCQ3Lxz9odh+/dAfGvgIiEOAvLRlF+QgNaIaQ6UzAlb7CUegzD9rAYgLeVUTcbYP9HWEOMtAkYhjOPhbhSP8rnidpP7TLAngd+3VrQFgTCnaX3DadJfknHlt4mj3dyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CFBCYqd/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714564281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=nnkmVhq2S0BNaQkleOd6XJ3VpQjTfweOjGM/NIr2sKM=;
	b=CFBCYqd/luYa+50a2QF+KFOJgF5I43PQjZVwILEyml38tx7IyVl9QWh+9t5RP/cm3ERjae
	T9hLka/cavGX07CrGkjJiTvPeRwjfZetcHIPc48f3OUOKpvK5Nt47Lks1VbUmiaTawZDLk
	gsc6BvVuTDWRn+Q0LcRTE57mH/kYVnU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-140-U1b9OOAKMZWq_gl7OFzGfQ-1; Wed, 01 May 2024 07:51:19 -0400
X-MC-Unique: U1b9OOAKMZWq_gl7OFzGfQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 67ED7812C52;
	Wed,  1 May 2024 11:51:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.22])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E08F740C6CC0;
	Wed,  1 May 2024 11:51:13 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240430140056.261997-8-dhowells@redhat.com>
References: <20240430140056.261997-8-dhowells@redhat.com> <20240430140056.261997-1-dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
    Jeff Layton <jlayton@kernel.org>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>
Cc: David Howells <dhowells@redhat.com>,
    Matthew Wilcox <willy@infradead.org>,
    Steve French <smfrench@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org, Miklos Szeredi <miklos@szeredi.hu>,
    Trond Myklebust <trond.myklebust@hammerspace.com>,
    Christoph Hellwig <hch@lst.de>,
    Andrew Morton <akpm@linux-foundation.org>,
    Alexander Viro <viro@zeniv.linux.org.uk>,
    Christian Brauner <brauner@kernel.org>, devel@lists.orangefs.org
Subject: Re: [PATCH v2 07/22] mm: Provide a means of invalidation without using launder_folio
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <438907.1714564273.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 01 May 2024 12:51:13 +0100
Message-ID: <438908.1714564273@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2

David Howells <dhowells@redhat.com> wrote:

> +			.range_start	=3D first,
> +			.range_end	=3D last,
> ...
> +	truncate_inode_pages_range(mapping, first, last);

These actually take file offsets and not page ranges and so the attached
change is needed.  Without this, the generic/412 xfstest fails.

David
---
diff --git a/mm/filemap.c b/mm/filemap.c
index 53516305b4b4..3916fc8b10e6 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4171,15 +4171,15 @@ int filemap_invalidate_inode(struct inode *inode, =
bool flush,
 		struct writeback_control wbc =3D {
 			.sync_mode	=3D WB_SYNC_ALL,
 			.nr_to_write	=3D LONG_MAX,
-			.range_start	=3D first,
-			.range_end	=3D last,
+			.range_start	=3D start,
+			.range_end	=3D end,
 		};
 =

 		filemap_fdatawrite_wbc(mapping, &wbc);
 	}
 =

 	/* Wait for writeback to complete on all folios and discard. */
-	truncate_inode_pages_range(mapping, first, last);
+	truncate_inode_pages_range(mapping, start, end);
 =

 unlock:
 	filemap_invalidate_unlock(mapping);


