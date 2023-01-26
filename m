Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A937E67D1F9
	for <lists+linux-cifs@lfdr.de>; Thu, 26 Jan 2023 17:42:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjAZQmi (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 26 Jan 2023 11:42:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232336AbjAZQmc (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 26 Jan 2023 11:42:32 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C43654DE06
        for <linux-cifs@vger.kernel.org>; Thu, 26 Jan 2023 08:41:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1674751295;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/KtFX/q2/0OOZvzDHVqjHXs3eBRAU+KUlsybGLpin4A=;
        b=fDXmgJ4M4pIWHVjdTMjtVzS0OaOyfZ68KD6VNs6w28HfN/+kZd/EkgfNzUGLrdXgebI6DT
        m2BwRUE0/LMGVMjFp/SRaZDfMrDeu7HB1Lc6Sn1cnoA0L+SSbIcBPkbmz8haXaHh4uNha3
        Ob6EbrsWDXKTvYNVtZmRIaIqxyPzQ7w=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-199-3lTw8DidPgaiMarBdmojow-1; Thu, 26 Jan 2023 11:41:32 -0500
X-MC-Unique: 3lTw8DidPgaiMarBdmojow-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE65B3C38FEF;
        Thu, 26 Jan 2023 16:41:31 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 02F4AC15BA0;
        Thu, 26 Jan 2023 16:41:29 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <5d0bc437eebb4d5aa4774962a4970095@AcuMS.aculab.com>
References: <5d0bc437eebb4d5aa4774962a4970095@AcuMS.aculab.com> <0d53a3cc9f9448298bba04d06f51b23d@AcuMS.aculab.com> <20230125214543.2337639-1-dhowells@redhat.com> <20230125214543.2337639-9-dhowells@redhat.com> <2862713.1674747841@warthog.procyon.org.uk>
To:     David Laight <David.Laight@ACULAB.COM>
Cc:     dhowells@redhat.com, Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Steve French <sfrench@samba.org>
Subject: Re: [RFC 08/13] cifs: Add a function to read into an iter from a socket
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2878214.1674751289.1@warthog.procyon.org.uk>
Date:   Thu, 26 Jan 2023 16:41:29 +0000
Message-ID: <2878215.1674751289@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

David Laight <David.Laight@ACULAB.COM> wrote:

> > It shouldn't matter as the only problematic iterator is ITER_PIPE
> > (advancing that has side effects) - and splice_read is handled specially
> > by patch 4.  The problem with splice_read with the way cifs works is that
> > it likes to subdivide its read/write requests across multiple reqs and
> > then subsubdivide them if certain types of failure occur.  But you can't
> > do that with ITER_PIPE.
> 
> I was thinking that even if ok at the moment it might be troublesome later.
> Somewhere I started writing a patch to put the iov_cache[] for user
> requests into the same structure as the iterator.
> Copying those might cause oddities.

Well, there is dup_iter(), but that copies the vector table, which isn't what
we want in a number of cases.  You probably need to come up with a wrapper for
that.

But we copy iters by assignment in a lot of places.  With regards to msg_hdr,
it might be worth giving it an iterator pointer rather than its own iterator.

I've just had a go at attempting to modify the code.
cifs_read_iter_from_socket() wants to copy the iterator and truncate the copy,
which makes things slightly trickier.  For both of the call sites,
receive_encrypted_read() and cifs_readv_receive(), it can do the truncation
before calling cifs_read_iter_from_socket(), I think - but it may have to undo
the truncation afterwards.

> > I build an ITER_BVEC from ITER_PIPE, ITER_UBUF and ITER_IOVEC in the top
> > levels with pins inserted as appropriate and hand the ITER_BVEC down.  For
> > user-backed iterators it has to be done this way because the I/O may get
> > shuffled off to a different thread.
> 
> For sub-page sided transfers it is probably worth doing a bounce buffer
> copy of user requests - just to save all the complex page pinning code.

You can't avoid it for async DIO reads.  But that sort of thing I'm intending
to do in netfslib.

David

