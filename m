Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 95321489782
	for <lists+linux-cifs@lfdr.de>; Mon, 10 Jan 2022 12:32:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244757AbiAJLce (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 10 Jan 2022 06:32:34 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:26115 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244758AbiAJLcP (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 10 Jan 2022 06:32:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1641814334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hrEu87EnXQ6Fg7UvjXggUKw0Jcqes+nBaSmxrmpEEwU=;
        b=RwLLNVKszlImAFDlZuJa0wx98kI1MAfRxIcK6fGCwqXPbA0Vm1vo7ojR5Jl3SfDpdG/NhI
        CFv1/h+Mfrdwq1PzXLkJaRTsiFyNUizyepOMpjeITQXbrTDlAgj51LSJhuGlR9htUB1+y3
        l+0kUI94odfB+wHg5onJ3pWNPBwB9Vg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-54-MsPtVj76MgWGNWERMB4MZg-1; Mon, 10 Jan 2022 06:32:09 -0500
X-MC-Unique: MsPtVj76MgWGNWERMB4MZg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 4E8BB1898292;
        Mon, 10 Jan 2022 11:32:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1F9507B6C9;
        Mon, 10 Jan 2022 11:31:55 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <Ydvl8Dk8z0mF0KFl@infradead.org>
References: <Ydvl8Dk8z0mF0KFl@infradead.org> <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk> <164021541207.640689.564689725898537127.stgit@warthog.procyon.org.uk> <CAOQ4uxjEcvffv=rNXS-r+NLz+=6yk4abRuX_AMq9v-M4nf_PtA@mail.gmail.com> <Ydk6jWmFH6TZLPZq@casper.infradead.org>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, Matthew Wilcox <willy@infradead.org>,
        Amir Goldstein <amir73il@gmail.com>, linux-cachefs@redhat.com,
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
Content-ID: <3735738.1641814315.1@warthog.procyon.org.uk>
Date:   Mon, 10 Jan 2022 11:31:55 +0000
Message-ID: <3735739.1641814315@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> So let's name it that way.  We have plenty of files in kernel use using
> filp_open and this flag very obviously means something else.

S_KERNEL_LOCK?

David

