Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 547D53E89CB
	for <lists+linux-cifs@lfdr.de>; Wed, 11 Aug 2021 07:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233942AbhHKFgJ (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 11 Aug 2021 01:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233776AbhHKFgI (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 11 Aug 2021 01:36:08 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A520C061765
        for <linux-cifs@vger.kernel.org>; Tue, 10 Aug 2021 22:35:45 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g30so3171758lfv.4
        for <linux-cifs@vger.kernel.org>; Tue, 10 Aug 2021 22:35:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fevpRGkLMiDxUGtR+dCPIJyuaefWqxYxSQO4eZo+/AI=;
        b=HBWXr0lvLadBOm46HohzfX2J7z2lVKcCFNO9Hu0rSf60hbnKol31toDjgdsJnxgcOV
         it30EJuKNOC62vrvZECm/+CuVK7b9hXpoy0PUb59w+sr7ma6yn3qUidCErB6PP0Rkizx
         Q+o8QYaueji8onpeKjmDcEvvRLeGbIbTw8vK0MTvS0f59BvyxDM32aY/bIyk6xpNwSSa
         JWiPOD90KA6Z6wAi532/0q/ABu43xxfHKzdIysjY5Z1QgpBFsVjLp1c8s62RpZHyud2K
         Ku9mLirGPDM6CG7uRCo7FOCdqWvmbQmRSfvz5fMfiAs3dHM4hzlZtG6GnGZtBJZvO1DM
         JkyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fevpRGkLMiDxUGtR+dCPIJyuaefWqxYxSQO4eZo+/AI=;
        b=Iv1f1sSWZrOP4cFBokjtbM5MnreRDMqvftMl2ZSet/eOr9PvUXea/JPTo7lwEpntiN
         4Hl+qzS5zNtb7GxjidOz3WnJ9O3HSROAyIbkvXS5LQYMZmzChCey7OKaf+BEpL51ABG1
         vdLBEa6Z+IcDkhdEQ3dgSjbRs7jukUndE52XRSf4+5Z0K4LnaVutb0Mko2TOjpWamhwE
         uI2Z5EuiQLFyR/pns0WHrTHEqfT9KEYj2FdnR1W46Wno1Ui75F5q9dCRcXlKIRvINQ3r
         B5HDrjD68F8hQ7P+8gEb7MOYAKTIq5S3rqNqzBJ0EuvzZrCn36AT90zpfN7HbrYuFE57
         Q8ZA==
X-Gm-Message-State: AOAM532laDSubS1aiUVp7aqJ3bFz5IHHGxYkGAlDiJIHwVom0xZy+WYf
        kxgaHCFrsxPVl5c/ZVKfI4x65FMblEdteKv8MrE=
X-Google-Smtp-Source: ABdhPJwDQTDGiaQm5Rtb5WB2f2gVLdAOdgUbyfoV4khyDouf4SKpQ7Qb/leflJ46bb2JJiIpbyK/TqfMsYL+lJquxn8=
X-Received: by 2002:ac2:5dd5:: with SMTP id x21mr23941273lfq.605.1628660143241;
 Tue, 10 Aug 2021 22:35:43 -0700 (PDT)
MIME-Version: 1.0
References: <CACdtm0Z4rDEGsi02+0DJnw2EoTV2CSC-jDN-SyDhKz0WcGZoAQ@mail.gmail.com>
 <CANT5p=rN_ogRccKmYpE+17qz=zRyUJChcKo5+cJiwDTFq_cBJw@mail.gmail.com>
 <CACdtm0aGGqtSsv1t2=VTGZZTBD52JvOsWD_oqXuUnejeDCVJFw@mail.gmail.com>
 <CAH2r5mtQCC8upykXm5zZVO94-TRbxq2HMN5S65ROASwaRqOfuA@mail.gmail.com>
 <CAH2r5mvAr5FYn3-y7MxJE=uaODvgp8c6J6NwFLiyh8u8r5LdCA@mail.gmail.com>
 <CACdtm0aekkd95jiibdC8wx0eNupP2wRQET5h1F2CVoZKRVDqaA@mail.gmail.com> <CAH2r5msqT7yUgop=DqYaeUv9L9MB5OoPPW_E289pOxRRMP5dWg@mail.gmail.com>
In-Reply-To: <CAH2r5msqT7yUgop=DqYaeUv9L9MB5OoPPW_E289pOxRRMP5dWg@mail.gmail.com>
From:   Rohith Surabattula <rohiths.msft@gmail.com>
Date:   Wed, 11 Aug 2021 11:05:31 +0530
Message-ID: <CACdtm0b8xH7dPbK_p1vzngnPtx+_5v5nPRZvG6K1kHn-OREwOQ@mail.gmail.com>
Subject: Re: [PATCH][CIFS]Call close synchronously during unlink/rename/lease break.
To:     Steve French <smfrench@gmail.com>
Cc:     Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Yes, Sounds good.

Regards,
Rohith

On Wed, Aug 11, 2021 at 10:58 AM Steve French <smfrench@gmail.com> wrote:
>
> I added
>
> Cc: stable@vger.kernel.org # 5.13
>
> Sound correct?
>
> On Tue, Aug 10, 2021 at 2:48 PM Rohith Surabattula
> <rohiths.msft@gmail.com> wrote:
> >
> > Hi All,
> >
> > I have attached an old version of patch by mistake.
> > Have attached the correct one.
> >
> > Sorry for the confusion.
> >
> > Regards.
> > Rohith
> >
> > On Wed, Aug 11, 2021 at 1:02 AM Steve French <smfrench@gmail.com> wrote:
> > >
> > > This is in http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/766
> > >
> > > On Tue, Aug 10, 2021 at 2:28 PM Steve French <smfrench@gmail.com> wrote:
> > > >
> > > > I saw some test failures in
> > > >
> > > > and looking in /var/log/messages I see e.g.
> > > >
> > > > Aug 10 14:00:22 fedora29 systemd[1]: Started /usr/bin/bash -c exit 77.
> > > > Aug 10 14:00:25 fedora29 kernel: kmemleak: 10 new suspected memory
> > > > leaks (see /sys/kernel/debug/kmemleak)
> > > > Aug 10 14:00:28 fedora29 kernel: kmemleak: 1 new suspected memory
> > > > leaks (see /sys/kernel/debug/kmemleak)
> > > > Aug 10 14:00:28 fedora29 kernel: CIFS: Attempting to mount
> > > > \\win16.vm.test\Scratch
> > > > Aug 10 14:00:28 fedora29 kernel: CIFS: Attempting to mount
> > > > \\win16.vm.test\Scratch
> > > > Aug 10 14:00:29 fedora29 root[6460]: run xfstest cifs/100
> > > > Aug 10 14:00:29 fedora29 journal: run fstests cifs/100 at 2021-08-10 14:00:29
> > > > Aug 10 14:00:29 fedora29 systemd[1]: Started /usr/bin/bash -c test -w
> > > > /proc/self/oom_score_adj && echo 250 > /proc/self/oom_score_adj; exec
> > > > ./tests/cifs/100.
> > > > Aug 10 14:00:30 fedora29 kernel: general protection fault, probably
> > > > for non-canonical address 0xdead000000000110: 0000 [#4] SMP PTI
> > > > Aug 10 14:00:30 fedora29 kernel: CPU: 0 PID: 6624 Comm: rm Tainted: G
> > > >     D           5.14.0-rc4 #1
> > > > Aug 10 14:00:30 fedora29 kernel: Hardware name: Red Hat KVM, BIOS
> > > > 0.5.1 01/01/2011
> > > > Aug 10 14:00:30 fedora29 kernel: RIP:
> > > > 0010:cifs_close_deferred_file+0x77/0x140 [cifs]
> > > > Aug 10 14:00:30 fedora29 kernel: Code: 85 de 00 00 00 4c 89 ef e8 06
> > > > 96 2e e8 48 8b 1c 24 4c 39 e3 74 55 49 bd 00 01 00 00 00 00 ad de 48
> > > > bd 22 01 00 00 00 00 ad de <48> 8b 7b 10 31 d2 be 01 00 00 00 e8 a9 c5
> > > > fe ff 48 89 df e8 61 46
> > > > Aug 10 14:00:30 fedora29 kernel: RSP: 0018:ffffb121806dbdd0 EFLAGS: 00010287
> > > > Aug 10 14:00:30 fedora29 kernel: RAX: ffff88dc55b8ca01 RBX:
> > > > dead000000000100 RCX: 00000000000034d9
> > > > Aug 10 14:00:30 fedora29 kernel: RDX: 00000000000034d8 RSI:
> > > > 67739b6f43694caa RDI: 0000000000032080
> > > >
> > > > and
> > > >
> > > > Aug 10 14:00:30 fedora29 kernel: ---[ end trace b062b12a095f4dd5 ]---
> > > > Aug 10 14:00:30 fedora29 kernel: RIP:
> > > > 0010:cifs_close_deferred_file+0x77/0x140 [cifs]
> > > > Aug 10 14:00:30 fedora29 kernel: Code: 85 de 00 00 00 4c 89 ef e8 06
> > > > 96 2e e8 48 8b 1c 24 4c 39 e3 74 55 49 bd 00 01 00 00 00 00 ad de 48
> > > > bd 22 01 00 00 00 00 ad de <48> 8b 7b 10 31 d2 be 01 00 00 00 e8 a9 c5
> > > > fe ff 48 89 df e8 61 46
> > > > Aug 10 14:00:30 fedora29 kernel: RSP: 0018:ffffb12180f0fc80 EFLAGS: 00010283
> > > > Aug 10 14:00:30 fedora29 kernel: RAX: ffff88dc5b2ca201 RBX:
> > > > dead000000000100 RCX: 0000000000002367
> > > > Aug 10 14:00:30 fedora29 kernel: RDX: 0000000000002366 RSI:
> > > > 67100f614dfd246a RDI: 0000000000032080
> > > > Aug 10 14:00:30 fedora29 kernel: RBP: dead000000000122 R08:
> > > > 0000000000000001 R09: 0000000000000001
> > > > Aug 10 14:00:30 fedora29 kernel: R10: ffffb12180f0fba0 R11:
> > > > 0000000000000001 R12: ffffb12180f0fc80
> > > >
> > > > On Tue, Aug 10, 2021 at 12:29 PM Rohith Surabattula
> > > > <rohiths.msft@gmail.com> wrote:
> > > > >
> > > > > Hi All,
> > > > >
> > > > > Have updated the patch to fix the memleak.
> > > > >
> > > > > Regards,
> > > > > Rohith
> > > > >
> > > > > On Tue, Aug 10, 2021 at 5:18 PM Shyam Prasad N <nspmangalore@gmail.com> wrote:
> > > > > >
> > > > > > Already gave my review comments along with this one to the other email.
> > > > > >
> > > > > > Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
> > > > > >
> > > > > > On Mon, Aug 9, 2021 at 3:28 PM Rohith Surabattula
> > > > > > <rohiths.msft@gmail.com> wrote:
> > > > > > >
> > > > > > > Hi Steve/All,
> > > > > > >
> > > > > > > During unlink/rename/lease break, deferred work for close is
> > > > > > > scheduled immediately but in asynchronous manner which might
> > > > > > > lead to race with actual(unlink/rename) commands.
> > > > > > >
> > > > > > > This change will schedule close synchronously which will avoid
> > > > > > > the race conditions with other commands.
> > > > > > >
> > > > > > > Regards,
> > > > > > > Rohith
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Regards,
> > > > > > Shyam
> > > >
> > > >
> > > >
> > > > --
> > > > Thanks,
> > > >
> > > > Steve
> > >
> > >
> > >
> > > --
> > > Thanks,
> > >
> > > Steve
>
>
>
> --
> Thanks,
>
> Steve
