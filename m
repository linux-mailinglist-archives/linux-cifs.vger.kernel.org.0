Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F08FF41150F
	for <lists+linux-cifs@lfdr.de>; Mon, 20 Sep 2021 14:55:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232413AbhITM5G (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 20 Sep 2021 08:57:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:34712 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S237338AbhITM5F (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 20 Sep 2021 08:57:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632142534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=2pfCQSUTEHtxvGUE7L+msEadtTL5UoS3j8kSdpaAr2M=;
        b=O2B5G1kr+d860mSLzxlNOSKoR6jyNQwdJRl4aMKW3seW+CN08TJdpib03rF3qSSiPYQqxr
        KtAIwlwSaxSwHHmpY5EAeyCAwlxAtt02GesSdf3p370vNuhqiUJNPn+rArczHsifOEbWZa
        Gr0idIlv78hX4CqOTlIqBUZEqR31qZo=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-aaaUc8oCODmaXRUraPJUAg-1; Mon, 20 Sep 2021 08:55:33 -0400
X-MC-Unique: aaaUc8oCODmaXRUraPJUAg-1
Received: by mail-ed1-f71.google.com with SMTP id q17-20020a50c351000000b003d81427d25cso9056887edb.15
        for <linux-cifs@vger.kernel.org>; Mon, 20 Sep 2021 05:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2pfCQSUTEHtxvGUE7L+msEadtTL5UoS3j8kSdpaAr2M=;
        b=NyqDnzttVHrt1/mzePcx4IWO3UzVrNj6BIi+vwC+NYkD+b29turIcCvz8/BtFaMi9c
         EUaaK2vKoX0YOaPcQ4llf3tvCQh21hdniVqzja31JgxuE3cAorO8n6kn+N3LXh12Laxf
         Rt4tHSsCcWIc6z324lJUPfjSvHIJPnj/QMFeORgBniWTS+AEp9tL83JYIN+3i7oDY5CR
         H/j7V3w1P66DCb0qSZgtDvLR9W3st0c8ZDyRElW5uziid65Pmveb4hemmmAcQ5JtTIHW
         foBIa2dn/gO5DZZwByic72SwPle1j21zrZ7gz4UMFgn8mYz9++b3KyJ/b6YVgEj+2Gcr
         /kNA==
X-Gm-Message-State: AOAM533uXALu9LpwG3+SthNIvxUZWSV3mLlqkJjxjix/pccWRyUzXl2L
        xaQFJKr+pQK5Vz+qjyNtrRiCfGFujSWF7cTehGQdVLJvS3KrmVmrI07ALhGkXPyZzVGC3asyCX0
        qIjTOYV4Lcb9IrAyObw6c/5KJ5a6nYgS1q6qtPQ==
X-Received: by 2002:a05:6402:897:: with SMTP id e23mr29275324edy.366.1632142532342;
        Mon, 20 Sep 2021 05:55:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlDFvRn78rkRZA594LdXUAWQmcz2jxyF/fehBHkaHwnv53x2WQ0in/WyUSP9JJllei7jnYtq334xLMF93TdIE=
X-Received: by 2002:a05:6402:897:: with SMTP id e23mr29275298edy.366.1632142532147;
 Mon, 20 Sep 2021 05:55:32 -0700 (PDT)
MIME-Version: 1.0
References: <163162767601.438332.9017034724960075707.stgit@warthog.procyon.org.uk>
 <CALF+zO=VHPzcp0A0KxpYW-0WnyxvM5gW5HmorzrMJ_arxxBchA@mail.gmail.com>
In-Reply-To: <CALF+zO=VHPzcp0A0KxpYW-0WnyxvM5gW5HmorzrMJ_arxxBchA@mail.gmail.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Mon, 20 Sep 2021 08:54:56 -0400
Message-ID: <CALF+zOkz8M_uwJRK_q=TVANrF=0=W2WAbL2Y-JBDrq2ZuRpcDg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/8] fscache: Replace and remove old I/O API
To:     David Howells <dhowells@redhat.com>
Cc:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-nfs <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, ceph-devel@vger.kernel.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Tue, Sep 14, 2021 at 11:30 AM David Wysochanski <dwysocha@redhat.com> wrote:
>
> On Tue, Sep 14, 2021 at 9:55 AM David Howells <dhowells@redhat.com> wrote:
> >
> >
> > Here's a set of patches that removes the old fscache I/O API by the following
> > means:
> >
> >  (1) A simple fallback API is added that can read or write a single page
> >      synchronously.  The functions for this have "deprecated" in their names
> >      as they have to be removed at some point.
> >
> >  (2) An implementation of this is provided in cachefiles.  It creates a kiocb
> >      to use DIO to the backing file rather than calling readpage on the
> >      backing filesystem page and then snooping the page wait queue.
> >
> >  (3) NFS is switched to use the fallback API.
> >
> >  (4) CIFS is switched to use the fallback API also for the moment.
> >
> >  (5) 9P is switched to using netfslib.
> >
> >  (6) The old I/O API is removed from fscache and the page snooping
> >      implementation is removed from cachefiles.
> >
> > The reasons for doing this are:
> >
> >  (A) Using a kiocb to do asynchronous DIO from/to the pages of the backing
> >      file is now a possibility that didn't exist when cachefiles was created.
> >      This is much simpler than the snooping mechanism with a proper callback
> >      path and it also requires fewer copies and less memory.
> >
> >  (B) We have to stop using bmap() or SEEK_DATA/SEEK_HOLE to work out what
> >      blocks are present in the backing file is dangerous and can lead to data
> >      corruption if the backing filesystem can insert or remove blocks of zeros
> >      arbitrarily in order to optimise its extent list[1].
> >
> >      Whilst this patchset doesn't fix that yet, it does simplify the code and
> >      the fix for that can be made in a subsequent patchset.
> >
> >  (C) In order to fix (B), the cache will need to keep track itself of what
> >      data is present.  To make this easier to manage, the intention is to
> >      increase the cache block granularity to, say, 256KiB - importantly, a
> >      size that will span multiple pages - which means the single-page
> >      interface will have to go away.  netfslib is designed to deal with
> >      that on behalf of a filesystem, though a filesystem could use raw
> >      cache calls instead and manage things itself.
> >
> > These patches can be found also on:
> >
> >         https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter-3
> >
> > David
> >
> > Link: https://lore.kernel.org/r/YO17ZNOcq+9PajfQ@mit.edu [1]
> > ---
> > David Howells (8):
> >       fscache: Generalise the ->begin_read_operation method
> >       fscache: Implement an alternate I/O interface to replace the old API
> >       nfs: Move to using the alternate (deprecated) fscache I/O API
> >       9p: (untested) Convert to using the netfs helper lib to do reads and caching
> >       cifs: (untested) Move to using the alternate (deprecated) fscache I/O API
> >       fscache: Remove the old I/O API
> >       fscache: Remove stats that are no longer used
> >       fscache: Update the documentation to reflect I/O API changes
> >
> >
> >  .../filesystems/caching/backend-api.rst       |  138 +--
> >  .../filesystems/caching/netfs-api.rst         |  386 +-----
> >  fs/9p/Kconfig                                 |    1 +
> >  fs/9p/cache.c                                 |  137 ---
> >  fs/9p/cache.h                                 |   98 +-
> >  fs/9p/v9fs.h                                  |    9 +
> >  fs/9p/vfs_addr.c                              |  174 ++-
> >  fs/9p/vfs_file.c                              |   21 +-
> >  fs/cachefiles/Makefile                        |    1 -
> >  fs/cachefiles/interface.c                     |   15 -
> >  fs/cachefiles/internal.h                      |   38 -
> >  fs/cachefiles/io.c                            |   28 +-
> >  fs/cachefiles/main.c                          |    1 -
> >  fs/cachefiles/rdwr.c                          |  972 ---------------
> >  fs/cifs/file.c                                |   64 +-
> >  fs/cifs/fscache.c                             |  105 +-
> >  fs/cifs/fscache.h                             |   74 +-
> >  fs/fscache/cache.c                            |    6 -
> >  fs/fscache/cookie.c                           |   10 -
> >  fs/fscache/internal.h                         |   58 +-
> >  fs/fscache/io.c                               |  140 ++-
> >  fs/fscache/object.c                           |    2 -
> >  fs/fscache/page.c                             | 1066 -----------------
> >  fs/fscache/stats.c                            |   73 +-
> >  fs/nfs/file.c                                 |   14 +-
> >  fs/nfs/fscache-index.c                        |   26 -
> >  fs/nfs/fscache.c                              |  161 +--
> >  fs/nfs/fscache.h                              |   84 +-
> >  fs/nfs/read.c                                 |   25 +-
> >  fs/nfs/write.c                                |    7 +-
> >  include/linux/fscache-cache.h                 |  131 --
> >  include/linux/fscache.h                       |  418 ++-----
> >  include/linux/netfs.h                         |   17 +-
> >  33 files changed, 508 insertions(+), 3992 deletions(-)
> >  delete mode 100644 fs/cachefiles/rdwr.c
> >
> >
>
> I tested an earlier version of these with NFS, which identified a
> couple issues which you fixed.  Last I checked my unit tests and
> xfstests were looking good. I'll do some testing on this latest branch
> / patches and report back.

For the series, you can add
Tested-by: Dave Wysochanski <dwysocha@redhat.com>

Testing was limited to NFS enabled code paths.  I ran custom unit
tests, as well as a series of xfstest generic runs with various NFS
versions, both fscache enabled and not enabled, as well as various NFS
servers, comparing 5.15.0-rc1 runs vs runs with these patches.  I did
not see any failures with these new patches that were not already
present with 5.15.0-rc1.

Here are the list of xfstest generic runs:
1. Hammerspace (pNFS flexfiles) version 4.6.3-166: vers=4.1,fsc
2. Hammerspace (pNFS flexfiles) version 4.6.3-166: vers=4.2
3. Netapp (pNFS filelayout) version 9.5RC1: vers=4.1
4. Netapp (pNFS filelayout) version 9.5RC1: vers=4.1,fsc
5. Red Hat version 8.2 (kernel-4.18.0-193.el8): vers=4.2,fsc
6. Red Hat version 8.2 (kernel-4.18.0-193.el8): vers=4.0,fsc
7. Red Hat version 8.2 (kernel-4.18.0-193.el8): vers=3,fsc

