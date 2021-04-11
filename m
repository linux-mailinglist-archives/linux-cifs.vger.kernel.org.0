Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0108135B6A0
	for <lists+linux-cifs@lfdr.de>; Sun, 11 Apr 2021 20:50:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236308AbhDKSuS (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 11 Apr 2021 14:50:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235559AbhDKSuR (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 11 Apr 2021 14:50:17 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9746BC061574
        for <linux-cifs@vger.kernel.org>; Sun, 11 Apr 2021 11:50:00 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id u4so12627442ljo.6
        for <linux-cifs@vger.kernel.org>; Sun, 11 Apr 2021 11:50:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=jFoZrOfRl/LdzFKgvdNW2NDBdhbJVy75+noIDAX49qw=;
        b=DZ7e2OPVFtNvUqprGpSOFFJw6truR6tbA99yMLgnyiGY/6pZsdz/h8BDM6+ktlxoVj
         /gyo2JcXcj5fiCj8xu2WpxIQzUvxjtfexDbnbN2MaMaHWrs966H1snL2DJJzX2GYkL9S
         Suu2CD5i52POi25+gR1xBCfCo5J/aktYTEZiS5de9aDXUZzYWmrJd0HdAH/IKXV6gKpN
         JMTWH+a8URHNXHXRGgyB1OwKJx1LwcDAqOxktHh2brNzCN3kZrOUkZkL4lSuzuhkGPZe
         rVdEza70hkySZLYEBezLBa8kwMvh/gM7KQHEN3pz4mvbyWMTEc+RyWURMtsCg1Yi0ow1
         /iog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jFoZrOfRl/LdzFKgvdNW2NDBdhbJVy75+noIDAX49qw=;
        b=Lr64Bs/yLPPiazCiwuysv39SI3CZAiFk/jcuQ4H9COXbM7VRaj6OI3S5NUf6LIAser
         PK3gGl0NEsEfqNqVdsw4IGoMZfR7ZB3fVLDI5Zp2LRayNUToJxLwIU6xYfRaoy6sRPxX
         NekTtnBuwkaRXUvz4cXZMF9u7m0hlc7tpZsEnoHfOS7R/O87dnvqtNlsFhgGfHtT1yBx
         n9W18uik5T/Gj6GKwbLH2i7UhpTrbpkg2dq21GBUWXMRtjCV2/3ij3pRfnjOwPQu1tDO
         ryto5n8QSG3RVFgW7c7kPuLreaLBUCyjVNZkGu4bFWLqHcvBWKwM7Mk531wl0YsHsf3n
         WG7g==
X-Gm-Message-State: AOAM530cO9fNKc+LL2WS1nmyHTPMsxLZat5tF2jjwVNJwPy4vcHUtFlt
        P6AJ5t75v9bvGD+XbeAoCB356OtQtwBjyRRWO5M=
X-Google-Smtp-Source: ABdhPJx4txjWJ4reru2iceX97qN3NaxXqHKk1JjCosUGyxY5qxNTU2Zdv8TSQBpN5vgmTWQ18yc3vL1WtMXT3SJlHYs=
X-Received: by 2002:a2e:98c5:: with SMTP id s5mr15306810ljj.218.1618166998898;
 Sun, 11 Apr 2021 11:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <CACdtm0Y1NeC0jNTOtjhTtGRt0sfyhyxC=wNfMu1eqibe6qJbwA@mail.gmail.com>
 <CANT5p=pFU=1OKiBA0m0_Pqms4Vsxz7omEgvfDDAb8U3M4-3qbA@mail.gmail.com>
 <461d79c3-1b32-b0f8-157c-b5d4b25507d7@talpey.com> <CACdtm0agzeVRiQg1zZjm=jFrf-gSQ-+YGc1Zm1xN1Pd9tJia4Q@mail.gmail.com>
 <49874720-dc76-2660-17e7-f7157a9725d4@talpey.com> <CACdtm0Z5BfbHp8Y2nFLv0k854hDe6-j4xtYDP4oruKPOtxxz2Q@mail.gmail.com>
 <CACdtm0ZYHjHXt-n8xnRQgZ+ZdLw4XVdb_yCK3Q_QSG4SrK6_Lw@mail.gmail.com> <CACdtm0YhpOW+7-ELLOk97utOikU-06Zccwq-2HK+h3aFumnedg@mail.gmail.com>
In-Reply-To: <CACdtm0YhpOW+7-ELLOk97utOikU-06Zccwq-2HK+h3aFumnedg@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 11 Apr 2021 13:49:47 -0500
Message-ID: <CAH2r5muCvxAHPOac4Ai5fxK_TLYiSw4LKy0QZv9iVVJoRkdCew@mail.gmail.com>
Subject: Re: cifs: Deferred close for files
To:     Rohith Surabattula <rohiths.msft@gmail.com>
Cc:     Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs <linux-cifs@vger.kernel.org>, sribhat.msa@outlook.com,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Could you rerun test 422 to Windows? It just failed with:

    -Space used before and after writeback is equal
    +Files /mnt/scratch/422.before and /mnt/scratch/422.after differ

and tests 023 and 024 to Samba and 024 to Windows which failed with:

    -samedir  tree/none -> none/tree.
    +samedir  tree/none -> Permission denied

and git tests 0000, 0002, 0003 and 0022 to Windows

See http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/557

It may be unrelated but worked without the patch the previous day:

http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/556

On Sun, Apr 11, 2021 at 7:19 AM Rohith Surabattula
<rohiths.msft@gmail.com> wrote:
>
> Hi All,
>
> Have updated the patch with some optimizations.
>
> Patch V3:
> Moved the deferred file list and lock from TCON to inode structures.
>
> Regards,
> Rohith
>
> On Wed, Apr 7, 2021 at 8:27 PM Rohith Surabattula
> <rohiths.msft@gmail.com> wrote:
> >
> > Hi All,
> >
> > Have updated the patch.
> >
> > patch v2:
> > 1)  Close the file immediately during unlink of file.
> > 2)  Update the reference count properly when deferred work is already scheduled.
> >
> > Regards,
> > Rohith
> >
> > On Thu, Mar 25, 2021 at 8:12 AM Rohith Surabattula
> > <rohiths.msft@gmail.com> wrote:
> > >
> > > >>> Hi Rohith,
> > > >>>
> > > >>> The changes look good at a high level.
> > > >>>
> > > >>> Just a few points worth checking:
> > > >>> 1. In cifs_open(), should be perform deferred close for certain cases
> > > >>> like O_DIRECT? AFAIK, O_DIRECT is just a hint to the filesystem to
> > > >>> perform less data caching. By deferring close, aren't we delaying
> > > >>> flushing dirty pages? @Steve French ?
> > > >>
> > > >> With O_DIRECT flag, data is not cached locally and will be sent to
> > > >> server immediately.
> > > >>
> > > >>> 2. I see that you're maintaining a new list of files for deferred
> > > >>> closing. Since there could be a large number of such files for a big
> > > >>> share with sufficient I/O, maybe we should think of a structure with
> > > >>> faster lookups (rb trees?).
> > > >>> I know we already have a bunch of linked lists in cifs.ko, and we need
> > > >>> to review perf impact for all those lists. But this one sounds like a
> > > >>> candidate for faster lookups.
> > > >>
> > > >> Entries will be added into this list only once file is closed and will
> > > >> remain for acregmax amount interval.
> > >
> > > >I think you mean once the "file descriptor" is closed, right? But now
> > > >that you mention it, caching the attributes sounds a lot like the
> > > >NFS close-to-open semantic, which is itself optional with the "nocto"
> > > >mount option.
> > >
> > > >Because some applications use close() to perform flush, there may be
> > > >some silent side effects as well. I don't see anything special in the
> > > >patch regarding this. Have you considered it?
> > > >The change to promptly close the handle on oplock or lease break looks
> > > >reasonable. The rewording in the patch description is better too.
> > >
> > > Yes, as the handle is closed immediately when oplock/lease breaks,
> > > will there be any
> > > silent side effects still?
> > >
> > > >>> What happens if the handle is durable or persistent, and the connection
> > > >>> to the server times out? Is the handle recovered, then closed?
> > > >>
> > > >> Do you mean when the session gets reconnected, the deferred handle
> > > >> will be recovered and closed?
> > >
> > > >Yes, because I expect the client to attempt to reclaim its handles upon
> > > >reconnection. I don't see any particular code change regarding this.
> > >
> > > >My question is, if there's a deferred close pending, should it do that,
> > > >or should it simply cut to the chase and close any such handle(s)?
> > >
> > > As the handles are persistent once the session gets reconnected,
> > > applications can reclaim
> > > the handle. So, i believe no need to close handles immediately until
> > > timeout(i.e acregmax interval)
> > >
> > > Regards,
> > > Rohith
> > >
> > > On Wed, Mar 24, 2021 at 7:50 PM Tom Talpey <tom@talpey.com> wrote:
> > > >
> > > > On 3/22/2021 1:07 PM, Rohith Surabattula wrote:
> > > > > On 3/11/2021 8:47 AM, Shyam Prasad N wrote:
> > > > >> Hi Rohith,
> > > > >>
> > > > >> The changes look good at a high level.
> > > > >>
> > > > >> Just a few points worth checking:
> > > > >> 1. In cifs_open(), should be perform deferred close for certain cases
> > > > >> like O_DIRECT? AFAIK, O_DIRECT is just a hint to the filesystem to
> > > > >> perform less data caching. By deferring close, aren't we delaying
> > > > >> flushing dirty pages? @Steve French ?
> > > > >
> > > > > With O_DIRECT flag, data is not cached locally and will be sent to
> > > > > server immediately.
> > > > >
> > > > >> 2. I see that you're maintaining a new list of files for deferred
> > > > >> closing. Since there could be a large number of such files for a big
> > > > >> share with sufficient I/O, maybe we should think of a structure with
> > > > >> faster lookups (rb trees?).
> > > > >> I know we already have a bunch of linked lists in cifs.ko, and we need
> > > > >> to review perf impact for all those lists. But this one sounds like a
> > > > >> candidate for faster lookups.
> > > > >
> > > > > Entries will be added into this list only once file is closed and will
> > > > > remain for acregmax amount interval.
> > > >
> > > > I think you mean once the "file descriptor" is closed, right? But now
> > > > that you mention it, caching the attributes sounds a lot like the
> > > > NFS close-to-open semantic, which is itself optional with the "nocto"
> > > > mount option.
> > > >
> > > > Because some applications use close() to perform flush, there may be
> > > > some silent side effects as well. I don't see anything special in the
> > > > patch regarding this. Have you considered it?
> > > >
> > > > > So,  Will this affect performance i.e during lookups ?
> > > > >
> > > > >> 3. Minor comment. Maybe change the field name oplock_deferred_close to
> > > > >> oplock_break_received?
> > > > >
> > > > > Addressed. Attached the patch.
> > > > >>
> > > > >> Regards,
> > > > >> Shyam
> > > > >
> > > > >> I wonder why the choice of 5 seconds? It seems to me a more natural
> > > > >> interval on the order of one or more of
> > > > >> - attribute cache timeout
> > > > >> - lease time
> > > > >> - echo_interval
> > > > >
> > > > > Yes, This sounds good. I modified the patch to defer by attribute
> > > > > cache timeout interval.
> > > > >
> > > > >> Also, this wording is rather confusing:
> > > > >
> > > > >>> When file is closed, SMB2 close request is not sent to server
> > > > >>> immediately and is deferred for 5 seconds interval. When file is
> > > > >>> reopened by same process for read or write, previous file handle
> > > > >>> can be used until oplock is held.
> > > > >
> > > > >> It's not a "previous" filehandle if it's open, and "can be used" is
> > > > >> a rather passive statement. A better wording may be "the filehandle
> > > > >> is reused".
> > > > >
> > > > >> And, "until oplock is held" is similarly awkward. Do you mean "*if*
> > > > >> an oplock is held", or "*provided" an oplock is held"?
> > > > >
> > > > >>> When same file is reopened by another client during 5 second
> > > > >>> interval, oplock break is sent by server and file is closed immediately
> > > > >>> if reference count is zero or else oplock is downgraded.
> > > > >
> > > > >> Only the second part of the sentence is relevant to the patch. Also,
> > > > >> what about lease break?
> > > > >
> > > > > Modified the patch.
> > > >
> > > > The change to promptly close the handle on oplock or lease break looks
> > > > reasonable. The rewording in the patch description is better too.
> > > >
> > > > >> What happens if the handle is durable or persistent, and the connection
> > > > >> to the server times out? Is the handle recovered, then closed?
> > > > >
> > > > > Do you mean when the session gets reconnected, the deferred handle
> > > > > will be recovered and closed?
> > > >
> > > > Yes, because I expect the client to attempt to reclaim its handles upon
> > > > reconnection. I don't see any particular code change regarding this.
> > > >
> > > > My question is, if there's a deferred close pending, should it do that,
> > > > or should it simply cut to the chase and close any such handle(s)?
> > > >
> > > > Tom.
> > > >
> > > > > Regards,
> > > > > Rohith
> > > > >
> > > > > On Thu, Mar 11, 2021 at 11:25 PM Tom Talpey <tom@talpey.com> wrote:
> > > > >>
> > > > >> On 3/11/2021 8:47 AM, Shyam Prasad N wrote:
> > > > >>> Hi Rohith,
> > > > >>>
> > > > >>> The changes look good at a high level.
> > > > >>>
> > > > >>> Just a few points worth checking:
> > > > >>> 1. In cifs_open(), should be perform deferred close for certain cases
> > > > >>> like O_DIRECT? AFAIK, O_DIRECT is just a hint to the filesystem to
> > > > >>> perform less data caching. By deferring close, aren't we delaying
> > > > >>> flushing dirty pages? @Steve French ?
> > > > >>> 2. I see that you're maintaining a new list of files for deferred
> > > > >>> closing. Since there could be a large number of such files for a big
> > > > >>> share with sufficient I/O, maybe we should think of a structure with
> > > > >>> faster lookups (rb trees?).
> > > > >>> I know we already have a bunch of linked lists in cifs.ko, and we need
> > > > >>> to review perf impact for all those lists. But this one sounds like a
> > > > >>> candidate for faster lookups.
> > > > >>> 3. Minor comment. Maybe change the field name oplock_deferred_close to
> > > > >>> oplock_break_received?
> > > > >>>
> > > > >>> Regards,
> > > > >>> Shyam
> > > > >>
> > > > >> I wonder why the choice of 5 seconds? It seems to me a more natural
> > > > >> interval on the order of one or more of
> > > > >> - attribute cache timeout
> > > > >> - lease time
> > > > >> - echo_interval
> > > > >>
> > > > >> Also, this wording is rather confusing:
> > > > >>
> > > > >>> When file is closed, SMB2 close request is not sent to server
> > > > >>> immediately and is deferred for 5 seconds interval. When file is
> > > > >>> reopened by same process for read or write, previous file handle
> > > > >>> can be used until oplock is held.
> > > > >>
> > > > >> It's not a "previous" filehandle if it's open, and "can be used" is
> > > > >> a rather passive statement. A better wording may be "the filehandle
> > > > >> is reused".
> > > > >>
> > > > >> And, "until oplock is held" is similarly awkward. Do you mean "*if*
> > > > >> an oplock is held", or "*provided" an oplock is held"?
> > > > >>
> > > > >>> When same file is reopened by another client during 5 second
> > > > >>> interval, oplock break is sent by server and file is closed immediately
> > > > >>> if reference count is zero or else oplock is downgraded.
> > > > >>
> > > > >> Only the second part of the sentence is relevant to the patch. Also,
> > > > >> what about lease break?
> > > > >>
> > > > >> What happens if the handle is durable or persistent, and the connection
> > > > >> to the server times out? Is the handle recovered, then closed?
> > > > >>
> > > > >> Tom.
> > > > >>
> > > > >>
> > > > >>> On Tue, Mar 9, 2021 at 2:41 PM Rohith Surabattula
> > > > >>> <rohiths.msft@gmail.com> wrote:
> > > > >>>>
> > > > >>>> Hi All,
> > > > >>>>
> > > > >>>> Please find the attached patch which will defer the close to server.
> > > > >>>> So, performance can be improved.
> > > > >>>>
> > > > >>>> i.e When file is open, write, close, open, read, close....
> > > > >>>> As close is deferred and oplock is held, cache will not be invalidated
> > > > >>>> and same handle can be used for second open.
> > > > >>>>
> > > > >>>> Please review the changes and let me know your thoughts.
> > > > >>>>
> > > > >>>> Regards,
> > > > >>>> Rohith
> > > > >>>
> > > > >>>
> > > > >>>



-- 
Thanks,

Steve
