Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 107CEDC23B
	for <lists+linux-cifs@lfdr.de>; Fri, 18 Oct 2019 12:12:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2633281AbfJRKMp (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 18 Oct 2019 06:12:45 -0400
Received: from mx1.redhat.com ([209.132.183.28]:15290 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2633218AbfJRKMo (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 18 Oct 2019 06:12:44 -0400
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com [209.85.160.197])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id CF3B579705
        for <linux-cifs@vger.kernel.org>; Fri, 18 Oct 2019 10:12:43 +0000 (UTC)
Received: by mail-qt1-f197.google.com with SMTP id d6so5424192qtn.2
        for <linux-cifs@vger.kernel.org>; Fri, 18 Oct 2019 03:12:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LGtNhMHz7AToyha3EPhU8mcRNY5g7GdVHfXctiNx/hE=;
        b=pVmWnpeJB1ZgJnDGdH+enOQ/cMY/nQxc/eAnqwnIMy5uWqjt1Jd6hGacOMEfuZEebE
         zq6OIOLc5GPsiFNrkm136TrHyVpQY5Ad6sInXfRlfnhVztXHBgJJaNQXSVykKFmnnoCy
         pMlA7T1XTQ4NwjxRtAYr8+noQTgyanlp2Qkixytp9tmtlvahA3aYYtuPqP8L+QTVKSOf
         xNOYWzri202YpEizRMfKaLSdTgNKMQYvENMFTVtAhf1uDeroZ2Vp6qEVNLa7IFTXNSm6
         MbAxcLKS5Hg6BklhIMMILHzRy3kbGIf960JrFpghUzOnWtxYH3PB0oxRVWhI0Oc4Pe5S
         5sNg==
X-Gm-Message-State: APjAAAXatw8WMNyVevzCiFdY35aTGPtezBFU24xZEvYhaO75V3uXR7cV
        k3ACTnBUD3kZpix7sqBDbdxIzoRLUFs9bJecN27ZBclM/1twQ5z4I+FsHOFrSkYi9dLxaiUZ6+f
        VQPZEuAD2X2jQmkyyf31GdfLTlc7azU6n/gY1wA==
X-Received: by 2002:ae9:e90e:: with SMTP id x14mr1095789qkf.229.1571393562694;
        Fri, 18 Oct 2019 03:12:42 -0700 (PDT)
X-Google-Smtp-Source: APXvYqxLKADZMStMMxHjXL+IY0SWS7xA6DpOV+1v1RIRO1XcKDUn7CQbzOy9Owt+CmC/p0XJfMw7rhEha/DkxF9bNaY=
X-Received: by 2002:ae9:e90e:: with SMTP id x14mr1095760qkf.229.1571393562292;
 Fri, 18 Oct 2019 03:12:42 -0700 (PDT)
MIME-Version: 1.0
References: <CALF+zOkugWpn6aCApqj8dF+AovgbQ8zgC-Hf8_0uvwqwHYTPiw@mail.gmail.com>
 <CALF+zO=8ZJkqR951NsxOf4hDDyUZzMfyiEN-j8DgA+i+FzcfGw@mail.gmail.com>
 <DM5PR21MB018515AFDDDE766D318BC489B66D0@DM5PR21MB0185.namprd21.prod.outlook.com>
 <CALF+zOmz5LFkzHrLpLGWcfwkOD7s-VhVz39pFgMNAFRT9_-KYg@mail.gmail.com>
 <58429039.7213410.1571348691819.JavaMail.zimbra@redhat.com>
 <DM5PR21MB0185FD6A138A5682BB9DE310B66D0@DM5PR21MB0185.namprd21.prod.outlook.com>
 <106934753.7215598.1571352823170.JavaMail.zimbra@redhat.com>
 <CALF+zOn-J9KyDDTL6dJ23RbQ9Gh+V3ti+4-O051zqOur6Fv-PA@mail.gmail.com> <1884745525.7250940.1571390858862.JavaMail.zimbra@redhat.com>
In-Reply-To: <1884745525.7250940.1571390858862.JavaMail.zimbra@redhat.com>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Fri, 18 Oct 2019 06:12:05 -0400
Message-ID: <CALF+zOkmFMtxsnrUR-anXOdMzUFxtAWG+VYLAQuq3DJuH=eDMw@mail.gmail.com>
Subject: Re: list_del corruption while iterating retry_list in cifs_reconnect
 still seen on 5.4-rc3
To:     Ronnie Sahlberg <lsahlber@redhat.com>
Cc:     Pavel Shilovskiy <pshilov@microsoft.com>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        Frank Sorenson <sorenson@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Fri, Oct 18, 2019 at 5:27 AM Ronnie Sahlberg <lsahlber@redhat.com> wrote:
>
>
> ----- Original Message -----
> > From: "David Wysochanski" <dwysocha@redhat.com>
> > To: "Ronnie Sahlberg" <lsahlber@redhat.com>
> > Cc: "Pavel Shilovskiy" <pshilov@microsoft.com>, "linux-cifs" <linux-cifs@vger.kernel.org>, "Frank Sorenson"
> > <sorenson@redhat.com>
> > Sent: Friday, 18 October, 2019 6:16:45 PM
> > Subject: Re: list_del corruption while iterating retry_list in cifs_reconnect still seen on 5.4-rc3
> >
> > On Thu, Oct 17, 2019 at 6:53 PM Ronnie Sahlberg <lsahlber@redhat.com> wrote:
> > >
> > >
> > >
> > >
>
> Good comments.
> New version of the patch, please test and see comments inline below
>
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index bdea4b3e8005..8a78358693a5 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -564,8 +564,13 @@ cifs_reconnect(struct TCP_Server_Info *server)
>         spin_lock(&GlobalMid_Lock);
>         list_for_each_safe(tmp, tmp2, &server->pending_mid_q) {
>                 mid_entry = list_entry(tmp, struct mid_q_entry, qhead);
> -               if (mid_entry->mid_state == MID_REQUEST_SUBMITTED)
> -                       mid_entry->mid_state = MID_RETRY_NEEDED;
> +               kref_get(&mid_entry->refcount);
> +               WARN_ON(mid_entry->mid_state != MID_REQUEST_SUBMITTED);
> +               /*
> +                * Set MID_RETRY_NEEDED to prevent the demultiplex loop from
> +                * removing us, or our neighbours, from the linked list.
> +                */
> +               mid_entry->mid_state = MID_RETRY_NEEDED;
>                 list_move(&mid_entry->qhead, &retry_list);
>         }
>         spin_unlock(&GlobalMid_Lock);
> @@ -575,7 +580,9 @@ cifs_reconnect(struct TCP_Server_Info *server)
>         list_for_each_safe(tmp, tmp2, &retry_list) {
>                 mid_entry = list_entry(tmp, struct mid_q_entry, qhead);
>                 list_del_init(&mid_entry->qhead);
> +
>                 mid_entry->callback(mid_entry);
> +               cifs_mid_q_entry_release(mid_entry);
>         }
>
>         if (cifs_rdma_enabled(server)) {
> @@ -895,7 +902,7 @@ dequeue_mid(struct mid_q_entry *mid, bool malformed)
>         if (mid->mid_flags & MID_DELETED)
>                 printk_once(KERN_WARNING
>                             "trying to dequeue a deleted mid\n");
> -       else
> +       else if (mid->mid_state != MID_RETRY_NEEDED)

I'm just using an 'if' here not 'else if'.  Do you see any issue with that?

Actually this section needed a little of reorganizing due to the
setting of the mid_state.  So I have this now for this hunk:

        mid->when_received = jiffies;
 #endif
        spin_lock(&GlobalMid_Lock);
-       if (!malformed)
-               mid->mid_state = MID_RESPONSE_RECEIVED;
-       else
-               mid->mid_state = MID_RESPONSE_MALFORMED;
        /*
         * Trying to handle/dequeue a mid after the send_recv()
         * function has finished processing it is a bug.
@@ -895,8 +893,14 @@ static inline int reconn_setup_dfs_targets(struct
cifs_sb_info *cifs_sb,
        if (mid->mid_flags & MID_DELETED)
                printk_once(KERN_WARNING
                            "trying to dequeue a deleted mid\n");
-       else
+       if (mid->mid_state != MID_RETRY_NEEDED)
                list_del_init(&mid->qhead);
+
+       if (!malformed)
+               mid->mid_state = MID_RESPONSE_RECEIVED;
+       else
+               mid->mid_state = MID_RESPONSE_MALFORMED;
+
        spin_unlock(&GlobalMid_Lock);
 }



>                 list_del_init(&mid->qhead);
>         spin_unlock(&GlobalMid_Lock);
>  }
> diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
> index 308ad0f495e1..17a430b58673 100644
> --- a/fs/cifs/transport.c
> +++ b/fs/cifs/transport.c
> @@ -173,7 +173,8 @@ void
>  cifs_delete_mid(struct mid_q_entry *mid)
>  {
>         spin_lock(&GlobalMid_Lock);
> -       list_del_init(&mid->qhead);
> +       if (mid->mid_state != MID_RETRY_NEEDED)
> +               list_del_init(&mid->qhead);
>         mid->mid_flags |= MID_DELETED;
>         spin_unlock(&GlobalMid_Lock);
>
> @@ -872,7 +873,8 @@ cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
>                 rc = -EHOSTDOWN;
>                 break;
>         default:
> -               list_del_init(&mid->qhead);
> +               if (mid->mid_state != MID_RETRY_NEEDED)
> +                       list_del_init(&mid->qhead);
>                 cifs_server_dbg(VFS, "%s: invalid mid state mid=%llu state=%d\n",
>                          __func__, mid->mid, mid->mid_state);
>                 rc = -EIO;
>
>
>
>
>
>
> > >
> > > ----- Original Message -----
> > > > From: "Pavel Shilovskiy" <pshilov@microsoft.com>
> > > > To: "Ronnie Sahlberg" <lsahlber@redhat.com>, "David Wysochanski"
> > > > <dwysocha@redhat.com>
> > > > Cc: "linux-cifs" <linux-cifs@vger.kernel.org>, "Frank Sorenson"
> > > > <sorenson@redhat.com>
> > > > Sent: Friday, 18 October, 2019 8:02:23 AM
> > > > Subject: RE: list_del corruption while iterating retry_list in
> > > > cifs_reconnect still seen on 5.4-rc3
> > > >
> > > > Ok, looking at cifs_delete_mid():
> > > >
> > > >  172 void
> > > >  173 cifs_delete_mid(struct mid_q_entry *mid)
> > > >  174 {
> > > >  175 >-------spin_lock(&GlobalMid_Lock);
> > > >  176 >-------list_del_init(&mid->qhead);
> > > >  177 >-------mid->mid_flags |= MID_DELETED;
> > > >  178 >-------spin_unlock(&GlobalMid_Lock);
> > > >  179
> > > >  180 >-------DeleteMidQEntry(mid);
> > > >  181 }
> > > >
> > > > So, regardless of us taking references on the mid itself or not, the mid
> > > > might be removed from the list. I also don't think taking GlobalMid_Lock
> > > > would help much because the next mid in the list might be deleted from
> > > > the
> > > > list by another process while cifs_reconnect is calling callback for the
> > > > current mid.
> > > >
> >
> > Yes the above is consistent with my tracing the crash after the first
> > initial refcount patch was applied.
> > After the simple refcount patch, when iterating the retry_loop, it was
> > processing an orphaned list with a single item over and over and
> > eventually ran itself down to refcount == 0 and crashed like before.
> >
> >
> > > > Instead, shouldn't we try marking the mid as being reconnected? Once we
> > > > took
> > > > a reference, let's mark mid->mid_flags with a new flag MID_RECONNECT
> > > > under
> > > > the GlobalMid_Lock. Then modify cifs_delete_mid() to check for this flag
> > > > and
> > > > do not remove the mid from the list if the flag exists.
> > >
> > > That could work. But then we should also use that flag to suppress the
> > > other places where we do a list_del*, so something like this ?
> > >
> > > diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> > > index 50dfd9049370..b324fff33e53 100644
> > > --- a/fs/cifs/cifsglob.h
> > > +++ b/fs/cifs/cifsglob.h
> > > @@ -1702,6 +1702,7 @@ static inline bool is_retryable_error(int error)
> > >  /* Flags */
> > >  #define   MID_WAIT_CANCELLED    1 /* Cancelled while waiting for response
> > >  */
> > >  #define   MID_DELETED            2 /* Mid has been dequeued/deleted */
> > > +#define   MID_RECONNECT          4 /* Mid is being used during reconnect
> > > */
> > >
> > Do we need this extra flag?  Can just use  mid_state ==
> > MID_RETRY_NEEDED in the necessary places?
>
> That is a good point.
> It saves us a redundant flag.
>
> >
> >
> > >  /* Types of response buffer returned from SendReceive2 */
> > >  #define   CIFS_NO_BUFFER        0    /* Response buffer not returned */
> > > diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> > > index bdea4b3e8005..b142bd2a3ef5 100644
> > > --- a/fs/cifs/connect.c
> > > +++ b/fs/cifs/connect.c
> > > @@ -564,6 +564,8 @@ cifs_reconnect(struct TCP_Server_Info *server)
> > >         spin_lock(&GlobalMid_Lock);
> > >         list_for_each_safe(tmp, tmp2, &server->pending_mid_q) {
> > >                 mid_entry = list_entry(tmp, struct mid_q_entry, qhead);
> > > +               kref_get(&mid_entry->refcount);
> > > +               mid_entry->mid_flags |= MID_RECONNECT;
> > >                 if (mid_entry->mid_state == MID_REQUEST_SUBMITTED)
> > >                         mid_entry->mid_state = MID_RETRY_NEEDED;
> >
> > What happens if the state is wrong going in there, and it is not set
> > to MID_RETRY_NEEDED, but yet we queue up the retry_list and run it
> > below?
> > Should the above 'if' check for MID_REQUEST_SUBMITTED be a WARN_ON
> > followed by unconditionally setting the state?
> >
> > WARN_ON(mid_entry->mid_state != MID_REQUEST_SUBMITTED);
> > /* Unconditionally set MID_RETRY_NEEDED */
> > mid_etnry->mid_state = MID_RETRY_NEEDED;
>
> Yepp.
>
> >
> >
> > >                 list_move(&mid_entry->qhead, &retry_list);
> > > @@ -575,7 +577,9 @@ cifs_reconnect(struct TCP_Server_Info *server)
> > >         list_for_each_safe(tmp, tmp2, &retry_list) {
> > >                 mid_entry = list_entry(tmp, struct mid_q_entry, qhead);
> > >                 list_del_init(&mid_entry->qhead);
> > > +
> > >                 mid_entry->callback(mid_entry);
> > > +               cifs_mid_q_entry_release(mid_entry);
> > >         }
> > >
> > >         if (cifs_rdma_enabled(server)) {
> > > @@ -895,7 +899,7 @@ dequeue_mid(struct mid_q_entry *mid, bool malformed)
> > >         if (mid->mid_flags & MID_DELETED)
> > >                 printk_once(KERN_WARNING
> > >                             "trying to dequeue a deleted mid\n");
> > > -       else
> > > +       else if (!(mid->mid_flags & MID_RECONNECT))
> >
> > Instead of the above,
> >
> >  -       else
> > +          else if (mid_entry->mid_state == MID_RETRY_NEEDED)
>
> Yes, but mid_state != MID_RETRY_NEEDED
>

Yeah good catch on that - somehow I reversed the logic, and when I
tested the former it blew up spectacularly almost instantaenously!
Doh!

So far the latest patch has been running for about 25 minutes, which
is I think the longest this test has survived.
I need a bit more runtime to be sure it's good, but if it keeps going
I'll plan to create a patch header and submit to list by end of today.
Thanks Ronnie and Pavel for the help tracking this down.


>
> >                   list_del_init(&mid->qhead);
> >
> >
> > >         spin_unlock(&GlobalMid_Lock);
> > >  }
> > > diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
> > > index 308ad0f495e1..ba4b5ab9cf35 100644
> > > --- a/fs/cifs/transport.c
> > > +++ b/fs/cifs/transport.c
> > > @@ -173,7 +173,8 @@ void
> > >  cifs_delete_mid(struct mid_q_entry *mid)
> > >  {
> > >         spin_lock(&GlobalMid_Lock);
> > > -       list_del_init(&mid->qhead);
> > > +       if (!(mid->mid_flags & MID_RECONNECT))
> > > +               list_del_init(&mid->qhead);
> >
> > Same check as above.
> >
> >
> > >         mid->mid_flags |= MID_DELETED;
> > >         spin_unlock(&GlobalMid_Lock);
> > >
> > > @@ -872,7 +873,8 @@ cifs_sync_mid_result(struct mid_q_entry *mid, struct
> > > TCP_Server_Info *server)
> > >                 rc = -EHOSTDOWN;
> > >                 break;
> > >         default:
> > > -               list_del_init(&mid->qhead);
> > > +               if (!(mid->mid_flags & MID_RECONNECT))
> > > +                       list_del_init(&mid->qhead);
> >
> > Same check as above.
> >
> > >                 cifs_server_dbg(VFS, "%s: invalid mid state mid=%llu
> > >                 state=%d\n",
> > >                          __func__, mid->mid, mid->mid_state);
> > >                 rc = -EIO;
> > >
> > >
> > > >
> > > > --
> > > > Best regards,
> > > > Pavel Shilovsky
> > > >
> > > > -----Original Message-----
> > > > From: Ronnie Sahlberg <lsahlber@redhat.com>
> > > > Sent: Thursday, October 17, 2019 2:45 PM
> > > > To: David Wysochanski <dwysocha@redhat.com>
> > > > Cc: Pavel Shilovskiy <pshilov@microsoft.com>; linux-cifs
> > > > <linux-cifs@vger.kernel.org>; Frank Sorenson <sorenson@redhat.com>
> > > > Subject: Re: list_del corruption while iterating retry_list in
> > > > cifs_reconnect
> > > > still seen on 5.4-rc3
> > > >
> > > > Dave, Pavel
> > > >
> > > > If it takes longer to trigger it might indicate we are on the right path
> > > > but
> > > > there are additional places to fix.
> > > >
> > > > I still think you also need to protect the list mutate functions as well
> > > > using the global mutex, so something like this :
> > > >
> > > > diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c index
> > > > bdea4b3e8005..16705a855818 100644
> > > > --- a/fs/cifs/connect.c
> > > > +++ b/fs/cifs/connect.c
> > > > @@ -564,6 +564,7 @@ cifs_reconnect(struct TCP_Server_Info *server)
> > > >         spin_lock(&GlobalMid_Lock);
> > > >         list_for_each_safe(tmp, tmp2, &server->pending_mid_q) {
> > > >                 mid_entry = list_entry(tmp, struct mid_q_entry, qhead);
> > > > +               kref_get(&mid_entry->refcount);
> > > >                 if (mid_entry->mid_state == MID_REQUEST_SUBMITTED)
> > > >                         mid_entry->mid_state = MID_RETRY_NEEDED;
> > > >                 list_move(&mid_entry->qhead, &retry_list); @@ -572,11
> > > >                 +573,18
> > > >                 @@ cifs_reconnect(struct TCP_Server_Info *server)
> > > >         mutex_unlock(&server->srv_mutex);
> > > >
> > > >         cifs_dbg(FYI, "%s: issuing mid callbacks\n", __func__);
> > > > +       spin_lock(&GlobalMid_Lock);
> > > >         list_for_each_safe(tmp, tmp2, &retry_list) {
> > > >                 mid_entry = list_entry(tmp, struct mid_q_entry, qhead);
> > > >                 list_del_init(&mid_entry->qhead);
> > > > +               spin_unlock(&GlobalMid_Lock);
> > > > +
> > > >                 mid_entry->callback(mid_entry);
> > > > +               cifs_mid_q_entry_release(mid_entry);
> > > > +
> > > > +               spin_lock(&GlobalMid_Lock);
> > > >         }
> > > > +       spin_unlock(&GlobalMid_Lock);
> > > >
> > > >         if (cifs_rdma_enabled(server)) {
> > > >                 mutex_lock(&server->srv_mutex);
> > > >
> > > >
> > > > ----- Original Message -----
> > > > From: "David Wysochanski" <dwysocha@redhat.com>
> > > > To: "Pavel Shilovskiy" <pshilov@microsoft.com>
> > > > Cc: "Ronnie Sahlberg" <lsahlber@redhat.com>, "linux-cifs"
> > > > <linux-cifs@vger.kernel.org>, "Frank Sorenson" <sorenson@redhat.com>
> > > > Sent: Friday, 18 October, 2019 6:34:53 AM
> > > > Subject: Re: list_del corruption while iterating retry_list in
> > > > cifs_reconnect
> > > > still seen on 5.4-rc3
> > > >
> > > > Unfortunately that did not fix the list_del corruption.
> > > > It did seem to run longer but I'm not sure runtime is meaningful.
> > > >
> > > > [ 1424.215537] list_del corruption. prev->next should be
> > > > ffff8d9b74c84d80,
> > > > but was a6787a60550c54a9 [ 1424.232688] ------------[ cut here
> > > > ]------------
> > > > [ 1424.234535] kernel BUG at lib/list_debug.c:51!
> > > > [ 1424.236502] invalid opcode: 0000 [#1] SMP PTI [ 1424.238334] CPU: 5
> > > > PID:
> > > > 10212 Comm: cifsd Kdump: loaded Not tainted 5.4.0-rc3-fix1+ #33 [
> > > > 1424.241489] Hardware name: Red Hat KVM, BIOS 0.5.1 01/01/2011 [
> > > > 1424.243770] RIP: 0010:__list_del_entry_valid.cold+0x31/0x55
> > > > [ 1424.245972] Code: 5e 15 b5 e8 54 a3 c5 ff 0f 0b 48 c7 c7 70 5f 15
> > > > b5 e8 46 a3 c5 ff 0f 0b 48 89 f2 48 89 fe 48 c7 c7 30 5f 15 b5 e8 32
> > > > a3 c5 ff <0f> 0b 48 89 fe 4c 89 c2 48 c7 c7 f8 5e 15 b5 e8 1e a3 c5 ff 0f
> > > > 0b
> > > > [ 1424.253409] RSP: 0018:ffff9a12404b3d38 EFLAGS: 00010246 [ 1424.255576]
> > > > RAX: 0000000000000054 RBX: ffff8d9b6ece1000 RCX: 0000000000000000 [
> > > > 1424.258504] RDX: 0000000000000000 RSI: ffff8d9b77b57908 RDI:
> > > > ffff8d9b77b57908 [ 1424.261404] RBP: ffff8d9b74c84d80 R08:
> > > > ffff8d9b77b57908
> > > > R09: 0000000000000280 [ 1424.264336] R10: ffff9a12404b3bf0 R11:
> > > > ffff9a12404b3bf5 R12: ffff8d9b6ece11c0 [ 1424.267285] R13:
> > > > ffff9a12404b3d48
> > > > R14: a6787a60550c54a9 R15: ffff8d9b6fcec300 [ 1424.270191] FS:
> > > > 0000000000000000(0000) GS:ffff8d9b77b40000(0000)
> > > > knlGS:0000000000000000
> > > > [ 1424.273491] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [
> > > > 1424.275831] CR2: 0000562cdf4a2000 CR3: 000000023340c000 CR4:
> > > > 00000000000406e0 [ 1424.278733] Call Trace:
> > > > [ 1424.279844]  cifs_reconnect+0x268/0x620 [cifs] [ 1424.281723]
> > > > cifs_readv_from_socket+0x220/0x250 [cifs] [ 1424.283876]
> > > > cifs_read_from_socket+0x4a/0x70 [cifs] [ 1424.285922]  ?
> > > > try_to_wake_up+0x212/0x650 [ 1424.287595]  ? cifs_small_buf_get+0x16/0x30
> > > > [cifs] [ 1424.289520]  ? allocate_buffers+0x66/0x120 [cifs] [
> > > > 1424.291421]
> > > > cifs_demultiplex_thread+0xdc/0xc30 [cifs] [ 1424.293506]
> > > > kthread+0xfb/0x130 [ 1424.294789]  ? cifs_handle_standard+0x190/0x190
> > > > [cifs] [ 1424.296833]  ? kthread_park+0x90/0x90 [ 1424.298295]
> > > > ret_from_fork+0x35/0x40 [ 1424.299717] Modules linked in: cifs libdes
> > > > libarc4 ip6t_rpfilter ip6t_REJECT nf_reject_ipv6 xt_conntrack ebtable_nat
> > > > ip6table_nat ip6table_mangle ip6table_raw ip6table_security iptable_nat
> > > > nf_nat iptable_mangle iptable_raw iptable_security nf_conntrack
> > > > nf_defrag_ipv6 nf_defrag_ipv4 ip_set nfnetlink ebtable_filter ebtables
> > > > ip6table_filter ip6_tables crct10dif_pclmul crc32_pclmul
> > > > ghash_clmulni_intel
> > > > virtio_balloon joydev i2c_piix4 nfsd nfs_acl lockd auth_rpcgss grace
> > > > sunrpc
> > > > xfs libcrc32c crc32c_intel virtio_net net_failover ata_generic serio_raw
> > > > virtio_console virtio_blk failover pata_acpi qemu_fw_cfg [ 1424.322374]
> > > > ---[
> > > > end trace 214af7e68b58e94b ]--- [ 1424.324305] RIP:
> > > > 0010:__list_del_entry_valid.cold+0x31/0x55
> > > > [ 1424.326551] Code: 5e 15 b5 e8 54 a3 c5 ff 0f 0b 48 c7 c7 70 5f 15
> > > > b5 e8 46 a3 c5 ff 0f 0b 48 89 f2 48 89 fe 48 c7 c7 30 5f 15 b5 e8 32
> > > > a3 c5 ff <0f> 0b 48 89 fe 4c 89 c2 48 c7 c7 f8 5e 15 b5 e8 1e a3 c5 ff 0f
> > > > 0b
> > > > [ 1424.333874] RSP: 0018:ffff9a12404b3d38 EFLAGS: 00010246 [ 1424.335976]
> > > > RAX: 0000000000000054 RBX: ffff8d9b6ece1000 RCX: 0000000000000000 [
> > > > 1424.338842] RDX: 0000000000000000 RSI: ffff8d9b77b57908 RDI:
> > > > ffff8d9b77b57908 [ 1424.341668] RBP: ffff8d9b74c84d80 R08:
> > > > ffff8d9b77b57908
> > > > R09: 0000000000000280 [ 1424.344511] R10: ffff9a12404b3bf0 R11:
> > > > ffff9a12404b3bf5 R12: ffff8d9b6ece11c0 [ 1424.347343] R13:
> > > > ffff9a12404b3d48
> > > > R14: a6787a60550c54a9 R15: ffff8d9b6fcec300 [ 1424.350184] FS:
> > > > 0000000000000000(0000) GS:ffff8d9b77b40000(0000)
> > > > knlGS:0000000000000000
> > > > [ 1424.353394] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033 [
> > > > 1424.355699] CR2: 0000562cdf4a2000 CR3: 000000023340c000 CR4:
> > > > 00000000000406e0
> > > >
> > > > On Thu, Oct 17, 2019 at 3:58 PM Pavel Shilovskiy <pshilov@microsoft.com>
> > > > wrote:
> > > > >
> > > > >
> > > > > The patch looks good. Let's see if it fixes the issue in your setup.
> > > > >
> > > > > --
> > > > > Best regards,
> > > > > Pavel Shilovsky
> > > > >
> > > > > -----Original Message-----
> > > > > From: David Wysochanski <dwysocha@redhat.com>
> > > > > Sent: Thursday, October 17, 2019 12:23 PM
> > > > > To: Pavel Shilovskiy <pshilov@microsoft.com>
> > > > > Cc: Ronnie Sahlberg <lsahlber@redhat.com>; linux-cifs
> > > > > <linux-cifs@vger.kernel.org>; Frank Sorenson <sorenson@redhat.com>
> > > > > Subject: Re: list_del corruption while iterating retry_list in
> > > > > cifs_reconnect still seen on 5.4-rc3 On Thu, Oct 17, 2019 at 2:29 PM
> > > > > Pavel
> > > > > Shilovskiy <pshilov@microsoft.com> wrote:
> > > > > >
> > > > > > The similar solution of taking an extra reference should apply to the
> > > > > > case of reconnect as well. The reference should be taken during the
> > > > > > process of moving mid entries to the private list. Once a callback
> > > > > > completes, such a reference should be put back thus freeing the mid.
> > > > > >
> > > > >
> > > > > Ah ok very good.  The above seems consistent with the traces I'm seeing
> > > > > of
> > > > > the race.
> > > > > I am going to test this patch as it sounds like what you're describing
> > > > > and
> > > > > similar to what Ronnie suggested earlier:
> > > > >
> > > > > --- a/fs/cifs/connect.c
> > > > > +++ b/fs/cifs/connect.c
> > > > > @@ -564,6 +564,7 @@ cifs_reconnect(struct TCP_Server_Info *server)
> > > > >         spin_lock(&GlobalMid_Lock);
> > > > >         list_for_each_safe(tmp, tmp2, &server->pending_mid_q) {
> > > > >                 mid_entry = list_entry(tmp, struct mid_q_entry,
> > > > > qhead);
> > > > > +               kref_get(&mid_entry->refcount);
> > > > >                 if (mid_entry->mid_state == MID_REQUEST_SUBMITTED)
> > > > >                         mid_entry->mid_state = MID_RETRY_NEEDED;
> > > > >                 list_move(&mid_entry->qhead, &retry_list); @@ -576,6
> > > > >                 +577,7
> > > > >                 @@ cifs_reconnect(struct TCP_Server_Info *server)
> > > > >                 mid_entry = list_entry(tmp, struct mid_q_entry, qhead);
> > > > >                 list_del_init(&mid_entry->qhead);
> > > > >                 mid_entry->callback(mid_entry);
> > > > > +               cifs_mid_q_entry_release(mid_entry);
> > > > >         }
> > > > >
> > > > >         if (cifs_rdma_enabled(server)) {
> > > > >
> > > >
> > > >
> > > > --
> > > > Dave Wysochanski
> > > > Principal Software Maintenance Engineer
> > > > T: 919-754-4024
> > > >
> >
