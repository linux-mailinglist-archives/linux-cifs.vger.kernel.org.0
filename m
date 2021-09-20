Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A44674114D2
	for <lists+linux-cifs@lfdr.de>; Mon, 20 Sep 2021 14:47:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238612AbhITMsn (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 20 Sep 2021 08:48:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23165 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238570AbhITMsn (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 20 Sep 2021 08:48:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632142035;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=N/2Pe4Rx8NqNClTKB4DSeOEu5W1xviKvYQ55s0CgCms=;
        b=BcL1FjfxS2XXPys/9Y4iLprIWAcnvq9J589YXkQKDWugjI/NOJGW169jSC6/LkIdMhTt5O
        1SYOQDlkZzk0haWeUpXmYo+YyBmQ3QFombRs6N8WNNBxS9gwNxr+0RrzQN9hfe+lRJxIXI
        lLDvaLnZsWbJ9Xsc/d56tmgKGN8Kfi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-602-p4w5CPeYMlu6gISbMFeP6Q-1; Mon, 20 Sep 2021 08:47:14 -0400
X-MC-Unique: p4w5CPeYMlu6gISbMFeP6Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1C1D184A5E0;
        Mon, 20 Sep 2021 12:47:12 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.44])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E44E10027C4;
        Mon, 20 Sep 2021 12:47:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YUiAmnMV7+fprNC1@casper.infradead.org>
References: <YUiAmnMV7+fprNC1@casper.infradead.org> <163214005516.2945267.7000234432243167892.stgit@warthog.procyon.org.uk>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        Jeff Layton <jlayton@kernel.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] fscache, 9p, afs, cifs, nfs: Deal with some warnings from W=1
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2950843.1632142024.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date:   Mon, 20 Sep 2021 13:47:04 +0100
Message-ID: <2950844.1632142024@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> > +++ b/fs/9p/vfs_addr.c
> > @@ -88,7 +88,7 @@ static const struct netfs_read_request_ops v9fs_req_=
ops =3D {
> >  =

> >  /**
> >   * v9fs_vfs_readpage - read an entire page in from 9P
> > - * @filp: file being read
> > + * @file: file being read
> >   * @page: structure to page
> >   *
> >   */
> =

> This is an example of a weird pattern in filesystems.  Several of
> them have kernel-doc for the implementation of various ->ops methods.
> I don't necessarily believe we should delete the comments (although is
> there any useful information in the above?), but I don't see the point
> in the comment being kernel-doc.

Yeah - I would prefer to do that.  Only kdoc it if it's inter-(sub-)driver=
 API
- and if it is, it must have a namespacing prefix so that it is obvious in
amongst a kernel-wide general index.

David

