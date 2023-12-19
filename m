Return-Path: <linux-cifs+bounces-509-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 528B2818A1F
	for <lists+linux-cifs@lfdr.de>; Tue, 19 Dec 2023 15:37:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E1E7E28AA4C
	for <lists+linux-cifs@lfdr.de>; Tue, 19 Dec 2023 14:37:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07DE20332;
	Tue, 19 Dec 2023 14:32:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hTcQST0n"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61F7B20DC7
	for <linux-cifs@vger.kernel.org>; Tue, 19 Dec 2023 14:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702996320;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fcH5mhNCfy4Npx8m9bnDGoyerhb2vmsJtBvMFIY3PE4=;
	b=hTcQST0nZBBU7EPKnY9+QU/TV9sNoFwfkV2d3AR3p4Lx0gvctdhcQZRuMu8bNcBYYFZ9XX
	sGrA3nkaN4BcJBFdOwPbDRZhoKl0YkByNEyQ8w8SwUDqdilJN6AFTF7AmhNprbGaLe/NeW
	+2P3a/IlijXlfG2P1mBZMI4STEsdnDA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-646-E3lE2-3DM7eN9FhE4GCjsQ-1; Tue, 19 Dec 2023 09:31:58 -0500
X-MC-Unique: E3lE2-3DM7eN9FhE4GCjsQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A58A6101AA4D;
	Tue, 19 Dec 2023 14:31:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id A72882166B31;
	Tue, 19 Dec 2023 14:31:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <367107fa03540f7ddd2e8de51c751348bd7eb42c.camel@kernel.org>
References: <367107fa03540f7ddd2e8de51c751348bd7eb42c.camel@kernel.org> <20231213152350.431591-1-dhowells@redhat.com> <20231213152350.431591-13-dhowells@redhat.com>
To: Jeff Layton <jlayton@kernel.org>
Cc: dhowells@redhat.com, Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 12/39] netfs: Add iov_iters to (sub)requests to describe various buffers
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <488522.1702996313.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Dec 2023 14:31:53 +0000
Message-ID: <488523.1702996313@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Jeff Layton <jlayton@kernel.org> wrote:

> > @@ -408,6 +417,10 @@ int netfs_write_begin(struct netfs_inode *ctx,
> >  	ractl._nr_pages =3D folio_nr_pages(folio);
> >  	netfs_rreq_expand(rreq, &ractl);
> >  =

> > +	/* Set up the output buffer */
> > +	iov_iter_xarray(&rreq->iter, ITER_DEST, &mapping->i_pages,
> > +			rreq->start, rreq->len);
> =

> Should the above be ITER_SOURCE ?

No - we're in ->write_begin() and are prefetching.  If you look in the cod=
e,
there's a netfs_begin_read() call a few lines below.  The output buffer fo=
r
the read is the page we're going to write into.

Note that netfs_write_begin() should be considered deprecated as the whole
perform_write thing will get replaced.

> > @@ -88,6 +78,11 @@ static void netfs_read_from_server(struct netfs_io_=
request *rreq,
> >  				   struct netfs_io_subrequest *subreq)
> >  {
> >  	netfs_stat(&netfs_n_rh_download);
> > +	if (iov_iter_count(&subreq->io_iter) !=3D subreq->len - subreq->tran=
sferred)
> > +		pr_warn("R=3D%08x[%u] ITER PRE-MISMATCH %zx !=3D %zx-%zx %lx\n",
> > +			rreq->debug_id, subreq->debug_index,
> > +			iov_iter_count(&subreq->io_iter), subreq->len,
> > +			subreq->transferred, subreq->flags);
> =

> pr_warn is a bit alarmist, esp given the cryptic message.  Maybe demote
> this to INFO or DEBUG?
> =

> Does this indicate a bug in the client or that the server is sending us
> malformed frames?

Good question.  The network filesystem updated subreq->transferred to indi=
cate
it had transferred X amount of data, but the iterator had been updated to
indicate Y amount of data was transferred.  They really ought to match as =
it
may otherwise indicate an underrun (and potential leakage of old data).
Overruns are less of a problem since the iterator would have to 'go negati=
ve'
as it were.

However, it might be better just to leave io_iter unchecked since we end u=
p
resetting it anyway each time we reinvoke the ->issue_read() op.  It's alw=
ays
possible that it will get copied and a different iterator get passed to th=
e
network layer or cache fs - and so the change to the iterator then has to =
be
manually propagated just to avoid the warning.

David


