Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4B5BA3E1BAE
	for <lists+linux-cifs@lfdr.de>; Thu,  5 Aug 2021 20:50:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241786AbhHESuu (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 5 Aug 2021 14:50:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:56990 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241757AbhHESut (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 5 Aug 2021 14:50:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1628189434;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IiYjOVol2JvYBzSm9nmbOsFi1gSlVR+sNt5v+Iro+eM=;
        b=ZHbbAU61oS1H+2oKLhh8moglBhhHg9ftrLE4x06oC+5N59lgrVeSpWNOFolj5VDfdjOBjg
        JHdkv0sLAG+RU8NV0HI3je+fFAMDQabsFcLI6ODWV8Z0zBC50uzg2lkHxV5LkcU81uU/9x
        ldeg5zLEeBhlU26u5Fl6xXD+FK36/ZQ=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-MhSjKDgUPW-A7BjpncDdew-1; Thu, 05 Aug 2021 14:50:33 -0400
X-MC-Unique: MhSjKDgUPW-A7BjpncDdew-1
Received: by mail-qk1-f199.google.com with SMTP id e11-20020a05620a208bb02903b854c43335so4746995qka.21
        for <linux-cifs@vger.kernel.org>; Thu, 05 Aug 2021 11:50:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=IiYjOVol2JvYBzSm9nmbOsFi1gSlVR+sNt5v+Iro+eM=;
        b=fa07HHq1RZNyBdA0gI8iAD0hPPWc9VBRlJsNbiQkTm5nlhDdNeVZUYgqpeZFhp1fIZ
         VfWBi8pfCeyeF1FbNDSTMNknulpdXOQZjIhhDbWp33+9l4A/3o5mNEc6Bv0337XEWOFV
         cnz6Sb+iGbRqGv5J8qeHWAFlOaMNddfg9jC+zhYLAtfelRS0Gnjj7l8VKtZ30lVYhtsr
         9CEPXzsR03tIbGBZvcmbXLcfXpZAbHJN0HscfyXrtqDqSaie6jHChfPoJdey2dstNnWs
         71KKTjyzoukzO6jPAHqun3T3svsjv3dpKwieC7HNowPe0v0Q5rFFzvIrIMbH+oTp/wbI
         xSpw==
X-Gm-Message-State: AOAM533a7JSY1R/VLTvIvZSHQbH4EANgtxb3mY1ZE+sHDcRb6I+zDkqR
        b2Bzm8NTDNKSTyXi7whPhObQNjKYr96nzUq2CorU9mFsp9VVhC2PEcljwMKoSCA6s9PxHi+vmWO
        JoFDA6ksqI7633drf3L83WQ==
X-Received: by 2002:a05:620a:b44:: with SMTP id x4mr4723780qkg.11.1628189432780;
        Thu, 05 Aug 2021 11:50:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCNAmptp/YxuNLEFQ2GKThqZsDaw/EkAl6/uzN/fIMPdEnuhdMjnc4Ro9mfYivPJI45LPC9Q==
X-Received: by 2002:a05:620a:b44:: with SMTP id x4mr4723755qkg.11.1628189432545;
        Thu, 05 Aug 2021 11:50:32 -0700 (PDT)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id c190sm3509913qkg.46.2021.08.05.11.50.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Aug 2021 11:50:32 -0700 (PDT)
Message-ID: <90a2a17aeae0447793496426d21794a3b0f7c197.camel@redhat.com>
Subject: Re: Canvassing for network filesystem write size vs page size
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Miklos Szeredi <miklos@szeredi.hu>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        devel@lists.orangefs.org, linux-mm@kvack.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 05 Aug 2021 14:50:30 -0400
In-Reply-To: <1219713.1628181333@warthog.procyon.org.uk>
References: <YQv+iwmhhZJ+/ndc@casper.infradead.org>
         <YQvpDP/tdkG4MMGs@casper.infradead.org>
         <YQvbiCubotHz6cN7@casper.infradead.org>
         <1017390.1628158757@warthog.procyon.org.uk>
         <1170464.1628168823@warthog.procyon.org.uk>
         <1186271.1628174281@warthog.procyon.org.uk>
         <1219713.1628181333@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.40.3 (3.40.3-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Thu, 2021-08-05 at 17:35 +0100, David Howells wrote:
> With Willy's upcoming folio changes, from a filesystem point of view, we're
> going to be looking at folios instead of pages, where:
> 
>  - a folio is a contiguous collection of pages;
> 
>  - each page in the folio might be standard PAGE_SIZE page (4K or 64K, say) or
>    a huge pages (say 2M each);
> 
>  - a folio has one dirty flag and one writeback flag that applies to all
>    constituent pages;
> 
>  - a complete folio currently is limited to PMD_SIZE or order 8, but could
>    theoretically go up to about 2GiB before various integer fields have to be
>    modified (not to mention the memory allocator).
> 
> Willy is arguing that network filesystems should, except in certain very
> special situations (eg. O_SYNC), only write whole folios (limited to EOF).
> 
> Some network filesystems, however, currently keep track of which byte ranges
> are modified within a dirty page (AFS does; NFS seems to also) and only write
> out the modified data.
> 
> Also, there are limits to the maximum RPC payload sizes, so writing back large
> pages may necessitate multiple writes, possibly to multiple servers.
> 
> What I'm trying to do is collate each network filesystem's properties (I'm
> including FUSE in that).
> 
> So we have the following filesystems:
> 
>  Plan9
>  - Doesn't track bytes
>  - Only writes single pages
> 
>  AFS
>  - Max RPC payload theoretically ~5.5 TiB (OpenAFS), ~16EiB (Auristor/kAFS)
>  - kAFS (Linux kernel)
>    - Tracks bytes, only writes back what changed
>    - Writes from up to 65535 contiguous pages.
>  - OpenAFS/Auristor (UNIX/Linux)
>    - Deal with cache-sized blocks (configurable, but something from 8K to 2M),
>      reads and writes in these blocks
>  - OpenAFS/Auristor (Windows)
>    - Track bytes, write back only what changed
> 
>  Ceph
>  - File divided into objects (typically 2MiB in size), which may be scattered
>    over multiple servers.

The default is 4M in modern cephfs clusters, but the rest is correct.

>  - Max RPC size is therefore object size.
>  - Doesn't track bytes.
> 
>  CIFS/SMB
>  - Writes back just changed bytes immediately under some circumstances

cifs.ko can also just do writes to specific byte ranges synchronously
when it doesn't have the ability to use the cache (i.e. no oplock or
lease). CephFS also does this when it doesn't have the necessary
capabilities (aka caps) to use the pagecache.

If we want to add infrastructure for netfs writeback, then it would be
nice to consider similar infrastructure to handle those cases as well.

>  - Doesn't track bytes and writes back whole pages otherwise.
>  - SMB3 has a max RPC size of 16MiB, with a default of 4MiB
> 
>  FUSE
>  - Doesn't track bytes.
>  - Max 'RPC' size of 256 pages (I think).
> 
>  NFS
>  - Tracks modified bytes within a page.
>  - Max RPC size of 1MiB.
>  - Files may be constructed of objects scattered over different servers.
> 
>  OrangeFS
>  - Doesn't track bytes.
>  - Multipage writes possible.
> 
> If you could help me fill in the gaps, that would be great.


-- 
Jeff Layton <jlayton@redhat.com>

