Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F17E4D3D0C
	for <lists+linux-cifs@lfdr.de>; Wed,  9 Mar 2022 23:35:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238742AbiCIWga (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 9 Mar 2022 17:36:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238739AbiCIWg3 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 9 Mar 2022 17:36:29 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7B91B1216AA
        for <linux-cifs@vger.kernel.org>; Wed,  9 Mar 2022 14:35:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646865328;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=7BCptgTn0msFj3Lu2nO08V4lR03WYPl53I+vGTYn7fk=;
        b=gSNXI8vgGTo67NIFjpEAQcJcIK2L4YE1lTEVUPnpo8Ms8CFQwyhAwNnsGdykxK7OMCzenC
        uaJlzMkzZZI+s4zENJfJFpkLf/7WP40+3iuv12MUzR2tlIKaX3pdz9Cr9LsN8lf8dfOE8e
        KVbUYQglm1lm8ys1Gg+SqJqpo6Z+2eg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-578-P-IsmW0HMkWz7wctcP4Pcg-1; Wed, 09 Mar 2022 17:35:27 -0500
X-MC-Unique: P-IsmW0HMkWz7wctcP4Pcg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AE0D7835DE0;
        Wed,  9 Mar 2022 22:35:23 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 954F945302;
        Wed,  9 Mar 2022 22:35:02 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <92ebc9fbdda967c14274f2b246ef3f77a1f21224.camel@kernel.org>
References: <92ebc9fbdda967c14274f2b246ef3f77a1f21224.camel@kernel.org> <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk> <164678220204.1200972.17408022517463940584.stgit@warthog.procyon.org.uk>
To:     Jeff Layton <jlayton@kernel.org>
Cc:     dhowells@redhat.com, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 19/19] afs: Maintain netfs_i_context::remote_i_size
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1842057.1646865301.1@warthog.procyon.org.uk>
Date:   Wed, 09 Mar 2022 22:35:01 +0000
Message-ID: <1842058.1646865301@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Jeff Layton <jlayton@kernel.org> wrote:

> > -	op->store.i_size = max(pos + size, i_size);
> > +	op->store.i_size = max(pos + size, ictx->remote_i_size);
> 
> Ahh ok, so if i_size is larger than is represented by this write, you'll
> have a zeroed out region until writeback catches up. Makes sense.

That's the way it was working.  With this change, we track the server's idea
of the file size separately from our local inode->i_size (which is updated by
the modifications into the pagecache) and only expand the server's setting to
the end of the data we're storing, not to our local i_size.  I'm trying to
avoid zeroed-out regions appearing in the file.

Forcible expansion by truncate is a different matter.

David

