Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC19231A30A
	for <lists+linux-cifs@lfdr.de>; Fri, 12 Feb 2021 17:46:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbhBLQnh (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 12 Feb 2021 11:43:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55673 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231256AbhBLQmr (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 12 Feb 2021 11:42:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1613148078;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ft1B0dmqfZyPUoyDvwnAfTze1mns3d3CFcFjBHQ5YEA=;
        b=aNRt9Ee3sV2xdj2/G38YJVresg4eVETnPdP9xDWtHOPJMqJe0efT11qDj6gc7WEQExSZGP
        N7/Y+Gsts8Ww7CUbqTDLJqyaxZ5vprO30+olfCn9kIjcjU4OnFYwHGeWme5ErQJOdiPEfT
        cJJ9GTyWMLNlBxzi8f30HU2JxnQJd9A=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-107-B-RQRYovMoqRaRE_jNVVCw-1; Fri, 12 Feb 2021 11:41:16 -0500
X-MC-Unique: B-RQRYovMoqRaRE_jNVVCw-1
Received: by mail-ed1-f70.google.com with SMTP id m16so272144edd.21
        for <linux-cifs@vger.kernel.org>; Fri, 12 Feb 2021 08:41:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ft1B0dmqfZyPUoyDvwnAfTze1mns3d3CFcFjBHQ5YEA=;
        b=eh4svss+T1mdHRJR/FcHzqyfvHGus3lG2Tky9eAzZtwVDlJrIWZ6eqRte31bSselIp
         hNJJZ0X9+i+RgfTBAx9DbrgHh21b9oq7HhjmQXCQ6uFCKj1JwJwOCkT3eyhhiXmMj4Eb
         zr8sGkE5oNAU6ZeV1D0G7S4DE3sMx5UPIZnQ1VCFYfe8PPQIP9dm70extxXkkSN9Sowj
         L6Ck070k9YwCgA3K3TaiXqzWjQtOzCnhINtbSHc9WA0LggoOV7jDB7exauzfcsKgR+yv
         lx5smW7CA7lqjn1ij0AMs+TtgXsQhvNSBvZjV8jyaaKLMo7RVF39b+q8I/hlJs2vBCG1
         il+A==
X-Gm-Message-State: AOAM530G8R/FPoSUWzy2fmNyRuCtysvIkD0sDzCASfUu6iP1Tr2X5Vqj
        VfAFKex9ksQMAOlTWmvzSFPBsIM/cp9milqbN4VofMC7mRki/WKq8/0QkHDHNcLcVOBKavUO8KP
        dlecqpkNERx00DOHaZ5ixL8h4JNJoqzNGgUA89Q==
X-Received: by 2002:a17:906:1681:: with SMTP id s1mr3897285ejd.229.1613148074944;
        Fri, 12 Feb 2021 08:41:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTIgnx7LJiTFOW+mhqlshoZww0YFi52MiJxBqcnsY+RGcoAoY9xA8AY8Yu0JSD5ZHRlga8wGOKDsNd1QerD6Y=
X-Received: by 2002:a17:906:1681:: with SMTP id s1mr3897262ejd.229.1613148074745;
 Fri, 12 Feb 2021 08:41:14 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wj-k86FOqAVQ4ScnBkX3YEKuMzqTEB2vixdHgovJpHc9w@mail.gmail.com>
 <591237.1612886997@warthog.procyon.org.uk> <1330473.1612974547@warthog.procyon.org.uk>
 <1330751.1612974783@warthog.procyon.org.uk> <CAHk-=wjgA-74ddehziVk=XAEMTKswPu1Yw4uaro1R3ibs27ztw@mail.gmail.com>
 <27816.1613085646@warthog.procyon.org.uk>
In-Reply-To: <27816.1613085646@warthog.procyon.org.uk>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 12 Feb 2021 11:40:38 -0500
Message-ID: <CALF+zOkRhZ6SfotHbWFMDYJ-qJxxOSMd8SUbrXd4w7rpOMoPKw@mail.gmail.com>
Subject: Re: [GIT PULL] fscache: I/O API modernisation and netfs helper library
To:     David Howells <dhowells@redhat.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@redhat.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Trond Myklebust <trondmy@hammerspace.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        ceph-devel@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cachefs <linux-cachefs@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        v9fs-developer@lists.sourceforge.net,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Thu, Feb 11, 2021 at 6:20 PM David Howells <dhowells@redhat.com> wrote:
>
> Linus Torvalds <torvalds@linux-foundation.org> wrote:
>
> > Also, honestly, I really *REALLY* want your commit messages to talk
> > about who has been cc'd, who has been part of development, and point
> > to the PUBLIC MAILING LISTS WHERE THAT DISCUSSION WAS TAKING PLACE, so
> > that I can actually see that "yes, other people were involved"
>
> Most of the development discussion took place on IRC and waving snippets of
> code about in pastebin rather than email - the latency of email is just too
> high.  There's not a great deal I can do about that now as I haven't kept IRC
> logs.  I can do that in future if you want.
>
> > No, I don't require this in general, but exactly because of the
> > history we have, I really really want to see that. I want to see a
> >
> >    Link: https://lore.kernel.org/r/....
>
> I can add links to where I've posted the stuff for review.  Do you want this
> on a per-patch basis or just in the cover for now?
>
> Also, do you want things like these:
>
>  https://lore.kernel.org/linux-fsdevel/3326.1579019665@warthog.procyon.org.uk/
>  https://lore.kernel.org/linux-fsdevel/4467.1579020509@warthog.procyon.org.uk/
>
> which pertain to the overall fscache rewrite, but where the relevant changes
> didn't end up included in this particular patchset?  Or this:
>
>  https://listman.redhat.com/archives/linux-cachefs/2020-December/msg00000.html
>
> where someone was testing the overall patchset of which this is a subset?
>
> > and the Cc's - or better yet, the Reviewed-by's etc - so that when I
> > get a pull request, it really is very obvious to me when I look at it
> > that others really have been involved.
> >
> > So if I continue to see just
> >
> >     Signed-off-by: David Howells <dhowells@redhat.com>
> >
> > at the end of the commit messages, I will not pull.
> >
> > Yes, in this thread a couple of people have piped up and said that
> > they were part of the discussion and that they are interested, but if
> > I have to start asking around just to see that, then it's too little,
> > too late.
> >
> > No more of this "it looks like David Howells did things in private". I
> > want links I can follow to see the discussion, and I really want to
> > see that others really have been involved.
> >
> > Ok?
>
> Sure.
>
> I can go and edit in link pointers into the existing patches if you want and
> add Jeff's Review-and-tested-by into the appropriate ones.  You would be able
> to compare against the existing tag, so it wouldn't entirely invalidate the
> testing.
>
You can add my Tested-by for your fscache-next branch series ending at
commit  235299002012 netfs: Hold a ref on a page when PG_private_2 is set
This series includes your commit c723f0232c9f8928b3b15786499637bda3121f41
discussed a little earlier in this email thread.

I ran over 24 hours of NFS tests (unit, connectathon, xfstests,
various servers and all NFS versions) on your latest series
and it looks good.  Note I did not run against pNFS servers
due to known issue, and I did not do more advanced tests like
error injections.  I did get one OOM on xfstest generic/551 on
one testbed, but that same' test passed on another testbed,
so it's not clear what is happening there and it could very
well be testbed or NFS related.

In addition, I reviewed various patches in the series, especially the
API portions of the netfs patches, so for those, Reviewed-by is
appropriate as well. I have also reviewed some of the internals
of the other infrastructure patches, but my review is more limited
there.





> Also, do you want links inserting into all the patches of the two keyrings
> pull requests I've sent you?
>
> David
>

