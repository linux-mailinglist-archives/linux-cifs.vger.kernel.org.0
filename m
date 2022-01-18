Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA861492CC6
	for <lists+linux-cifs@lfdr.de>; Tue, 18 Jan 2022 18:54:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244344AbiARRyM (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 18 Jan 2022 12:54:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:23163 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S244169AbiARRyL (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 18 Jan 2022 12:54:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642528451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nPPBU7fRyyAQC3IqAePmc/y5C5VKzN6r/ufwnOhkpIs=;
        b=iE3uhSSDdIuO00kVaKVJLqcK0SL7Qojtwarw4xnZst3SEooCMXgh2tOhpaj4ViyhmLbR93
        p21ZX7GL7VYHH22/xALm8VF4BLjJVb3y9oMNTYvneXtxjRXiB+1u13CHWf4ObHCTRcXFYu
        brRsTsRlGPjIf2XOLPsri8WXYmky7D8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-dYizNdE7Pt6DN4j2koeeug-1; Tue, 18 Jan 2022 12:54:08 -0500
X-MC-Unique: dYizNdE7Pt6DN4j2koeeug-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B8231109455A;
        Tue, 18 Jan 2022 17:40:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A82257ED93;
        Tue, 18 Jan 2022 17:40:15 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <YebpktrcUZOlBHkZ@infradead.org>
References: <YebpktrcUZOlBHkZ@infradead.org> <164251396932.3435901.344517748027321142.stgit@warthog.procyon.org.uk> <164251409447.3435901.10092442643336534999.stgit@warthog.procyon.org.uk>
To:     Christoph Hellwig <hch@infradead.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        Jeff Layton <jlayton@kernel.org>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <smfrench@gmail.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 09/11] vfs, fscache: Add an IS_KERNEL_FILE() macro for the S_KERNEL_FILE flag
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3613680.1642527614.1@warthog.procyon.org.uk>
Date:   Tue, 18 Jan 2022 17:40:14 +0000
Message-ID: <3613681.1642527614@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:

> On Tue, Jan 18, 2022 at 01:54:54PM +0000, David Howells wrote:
> > Add an IS_KERNEL_FILE() macro to test the S_KERNEL_FILE inode flag as is
> > common practice for the other inode flags[1].
> 
> Please fix the flag to have a sensible name first, as the naming of the
> flag and this new helper is utterly wrong as we already discussed.

And I suggested a new name, which you didn't comment on.

David

