Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EE3E948828E
	for <lists+linux-cifs@lfdr.de>; Sat,  8 Jan 2022 09:43:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiAHInc (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 8 Jan 2022 03:43:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:21341 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233957AbiAHIn2 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 8 Jan 2022 03:43:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641631407;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CuAQLvFAvrXC/CGaNT1eE7oPqrX2KbSln6Qc3hozJtk=;
        b=EUHK/6g5AIERKm2PuBh3Mx/SvYrM6gQJWAZtfPvKUHiKrx/MUjUcSYIaKTUNpk8cTQYZwT
        vrPD1l7F6pM6unKx6FxWkeolL8rjL2nhjZeiFkut5rg9lBw1b2I0/P8W3Zu+/nuI58regp
        FN3m5pFDKNt57dQTS4jnpoXmUjvABF8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-118-xHmu0LN6MMyH2esABKG0fQ-1; Sat, 08 Jan 2022 03:43:22 -0500
X-MC-Unique: xHmu0LN6MMyH2esABKG0fQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E3CF418397A7;
        Sat,  8 Jan 2022 08:43:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2554F5F4EA;
        Sat,  8 Jan 2022 08:43:11 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Ydk6jWmFH6TZLPZq@casper.infradead.org>
References: <Ydk6jWmFH6TZLPZq@casper.infradead.org> <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk> <164021541207.640689.564689725898537127.stgit@warthog.procyon.org.uk> <CAOQ4uxjEcvffv=rNXS-r+NLz+=6yk4abRuX_AMq9v-M4nf_PtA@mail.gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     dhowells@redhat.com, Amir Goldstein <amir73il@gmail.com>,
        linux-cachefs@redhat.com,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        ceph-devel <ceph-devel@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 38/68] vfs, cachefiles: Mark a backing file in use with an inode flag
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3492247.1641631391.1@warthog.procyon.org.uk>
Date:   Sat, 08 Jan 2022 08:43:11 +0000
Message-ID: <3492248.1641631391@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Matthew Wilcox <willy@infradead.org> wrote:

> 
> Huh?  If some other kernel module sets it, cachefiles will try to set it,
> see it's already set, and fail.  Presumably cachefiles does not go round
> randomly "unusing" files that it has not previously started using.

Correct.  It only unuses a file that it marked in-use in the first place.

David

