Return-Path: <linux-cifs+bounces-511-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD23818A42
	for <lists+linux-cifs@lfdr.de>; Tue, 19 Dec 2023 15:41:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E436D28D908
	for <lists+linux-cifs@lfdr.de>; Tue, 19 Dec 2023 14:41:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B0FC21BDF4;
	Tue, 19 Dec 2023 14:41:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a0gv2AAJ"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5471C2AC
	for <linux-cifs@vger.kernel.org>; Tue, 19 Dec 2023 14:41:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702996867;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:to:
	 cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=7TWKhr2LMbpjEPBw/2MEwrqBs0s6c+M03rN98iODU4U=;
	b=a0gv2AAJXp3Ke6BrLokSmefzF9rYGmm4tavxRl09a2pUFbgyFRIDLpdee2f9ExhpD5Cq8K
	AqNnwOuddYBajjDgHaYk68aPCXZw2ldQYq58iBxohK02zDxSZ7nSkfmqM2oomemuntMj+F
	uk1OM+im6TSnUddzikWnU2LBLm/ADKs=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-53-pxkXtkAlOI-jeHJPe9wIAw-1; Tue,
 19 Dec 2023 09:41:01 -0500
X-MC-Unique: pxkXtkAlOI-jeHJPe9wIAw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E7A47299E748;
	Tue, 19 Dec 2023 14:40:59 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.39.195.169])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 27B1F1121306;
	Tue, 19 Dec 2023 14:40:57 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <488523.1702996313@warthog.procyon.org.uk>
References: <488523.1702996313@warthog.procyon.org.uk> <367107fa03540f7ddd2e8de51c751348bd7eb42c.camel@kernel.org> <20231213152350.431591-1-dhowells@redhat.com> <20231213152350.431591-13-dhowells@redhat.com>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Steve French <smfrench@gmail.com>,
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
Content-ID: <488793.1702996856.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 19 Dec 2023 14:40:56 +0000
Message-ID: <488794.1702996856@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

David Howells <dhowells@redhat.com> wrote:

> > > @@ -88,6 +78,11 @@ static void netfs_read_from_server(struct netfs_i=
o_request *rreq,
> > >  				   struct netfs_io_subrequest *subreq)
> > >  {
> > >  	netfs_stat(&netfs_n_rh_download);
> > > +	if (iov_iter_count(&subreq->io_iter) !=3D subreq->len - subreq->tr=
ansferred)
> > > +		pr_warn("R=3D%08x[%u] ITER PRE-MISMATCH %zx !=3D %zx-%zx %lx\n",
> > > +			rreq->debug_id, subreq->debug_index,
> > > +			iov_iter_count(&subreq->io_iter), subreq->len,
> > > +			subreq->transferred, subreq->flags);
> > =

> > pr_warn is a bit alarmist, esp given the cryptic message.  Maybe demot=
e
> > this to INFO or DEBUG?
> > =

> > Does this indicate a bug in the client or that the server is sending u=
s
> > malformed frames?
> =

> Good question.  The network filesystem updated subreq->transferred to in=
dicate
> it had transferred X amount of data, but the iterator had been updated t=
o
> indicate Y amount of data was transferred.  They really ought to match a=
s it
> may otherwise indicate an underrun (and potential leakage of old data).
> Overruns are less of a problem since the iterator would have to 'go nega=
tive'
> as it were.
> =

> However, it might be better just to leave io_iter unchecked since we end=
 up
> resetting it anyway each time we reinvoke the ->issue_read() op.  It's a=
lways
> possible that it will get copied and a different iterator get passed to =
the
> network layer or cache fs - and so the change to the iterator then has t=
o be
> manually propagated just to avoid the warning.

Actually, it's more complicated than that.  It's an assertion that netfsli=
b is
doing the right prep.  This assertion is checked both when we initially ma=
ke a
request (in which case it definitely shouldn't fire) and when we perform a
resubmission on partial/complete read failure when we need to carefully
revalidate the numbers to make sure we don't end up with holes or wrinkles=
 in
the buffer.

Anyway, it shouldn't happen - but if it does, it probably presages data
corruption.

David


