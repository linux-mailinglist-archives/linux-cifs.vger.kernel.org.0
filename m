Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42DEA31DDCD
	for <lists+linux-cifs@lfdr.de>; Wed, 17 Feb 2021 18:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234315AbhBQRAL (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 17 Feb 2021 12:00:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234310AbhBQRAH (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 17 Feb 2021 12:00:07 -0500
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17AB9C0613D6
        for <linux-cifs@vger.kernel.org>; Wed, 17 Feb 2021 08:59:27 -0800 (PST)
Received: by mail-ot1-x32e.google.com with SMTP id c16so12649225otp.0
        for <linux-cifs@vger.kernel.org>; Wed, 17 Feb 2021 08:59:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=omnibond-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7sO3sUZqmmuiy5ZWICfkEsaBnSxzPGcJa4JjW5AEhLI=;
        b=wkvcOIo/YOiyjJMcPp9t49oCoUuB0gAAXQOA0MaUAjtskFk4Y0zabPTmfPgIVj7S9X
         6m4bAQCAN+3eyk2moKhxkMLMHHsa4aCZhxjaV8ydaA1JKvJevC6E7yHwnT+GGn2n6Ozi
         46vBTDf/msm46ed3SMv2GWg6LW7yHHgTcQP8J1x7kK5lUTCGzzB3bPk5SP4FKAeyEFDz
         p6ciTaj85L6iXgw0dC/67tFnsvY0vAY/nZ4dNNdw2UUOJTgGSEEbrdVEXlJxJJZIm1BJ
         TuwrXToQ9KalPFlBbTGo7eqFOHbfFuTrqO8W7W9EGN/qBxvcyw3G+iuQ9petlOE3k5Wu
         UoWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7sO3sUZqmmuiy5ZWICfkEsaBnSxzPGcJa4JjW5AEhLI=;
        b=c89LoXIj3EnpkRJ3ietyA0vFPHCZKNbw6UxZ0cLz/ThJdlCjtxUVe3P3UeElKqhzyj
         1Wq9CnTfD7TP7BG9dUTAnEJtE/zc4Bswd7VYr9n5bfWN+uUumPrP/j/LCvotPqnFqSuk
         QP1LMG30salrmOvn3yrKfnGZ/7ley00tMKSEJPuorji6GTm5rHz7udoSWd/FJJBTRLgh
         28H7EIRsMxkrXjjE2v8I9lbSqNO+zAZHdmf7TfrF4+r+UJlfcSkjgrko/ZjrkKJ4666g
         SqHMbNfYj82leGdUM3B/+JZdOXh3O6zTIS43/XXWkI/x/R0KwtdGZdkvr3NHsteMU+Yq
         Z4lw==
X-Gm-Message-State: AOAM532FSVSbSnWuoHkTGfMQfRF8cTYfE1ORw4BvsCQAPatmYJ8+qw1X
        2aQZlKYkslAdc9aN/tHZLtpWpCuu8ql8rhqIWzwVLA==
X-Google-Smtp-Source: ABdhPJwChss0o2dxG2RNWJW1xeyysww7AKgNgkTjjECbssh7P0+Vree7tQLd/y6uY6aD7E7WIsZvOGZ0HXpRVi3fZGQ=
X-Received: by 2002:a9d:6c4c:: with SMTP id g12mr66707otq.53.1613581166449;
 Wed, 17 Feb 2021 08:59:26 -0800 (PST)
MIME-Version: 1.0
References: <161340385320.1303470.2392622971006879777.stgit@warthog.procyon.org.uk>
 <161340389201.1303470.14353807284546854878.stgit@warthog.procyon.org.uk>
 <20210216103215.GB27714@lst.de> <20210216132251.GI2858050@casper.infradead.org>
 <CAOg9mSQYBjnMsDj5pMd6MOGTY5w_ZR=pw7VRYKfP5ZwmHBj2=Q@mail.gmail.com> <1586931.1613576553@warthog.procyon.org.uk>
In-Reply-To: <1586931.1613576553@warthog.procyon.org.uk>
From:   Mike Marshall <hubcap@omnibond.com>
Date:   Wed, 17 Feb 2021 11:59:15 -0500
Message-ID: <CAOg9mSTyFX+2MMSV77hLDUpHogQ=KXO5oNduA90FLoowPGk0Jw@mail.gmail.com>
Subject: Re: [PATCH 03/33] mm: Implement readahead_control pageset expansion
To:     David Howells <dhowells@redhat.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-mm <linux-mm@kvack.org>, linux-cachefs@redhat.com,
        linux-afs@lists.infradead.org,
        Linux NFS Mailing List <linux-nfs@vger.kernel.org>,
        linux-cifs@vger.kernel.org,
        ceph-devel <ceph-devel@vger.kernel.org>,
        V9FS Developers <v9fs-developer@lists.sourceforge.net>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Matthew has looked at how I'm fumbling about
trying to deal with Orangefs's need for much larger
than page-sized IO...

I think I need to implement orangefs_readahead
and from there fire off an asynchronous read
and while that's going I'll call readahead_page
with a rac that I've cranked up with readahead_expand
and when the read gets done I'll have plenty of pages
for the large IO I did.

Even if what I think I need to do is somewhere
near right, the async code in the Orangefs
kernel module didn't make it into the upstream
version, so I have to refurbish that. All that to
say: I don't need readahead_expand
"tomorrow", but it fits into my plan to
get Orangefs the extra pages it needs
without me having open-coded page cache
code in orangefs_readpage.

-Mike

On Wed, Feb 17, 2021 at 10:42 AM David Howells <dhowells@redhat.com> wrote:
>
> Mike Marshall <hubcap@omnibond.com> wrote:
>
> > I plan to try and use readahead_expand in Orangefs...
>
> Would it help if I shuffled the readahead_expand patch to the bottom of the
> pack?
>
> David
>
