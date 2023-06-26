Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8E1B73D80F
	for <lists+linux-cifs@lfdr.de>; Mon, 26 Jun 2023 08:54:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFZGy4 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 26 Jun 2023 02:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjFZGyw (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 26 Jun 2023 02:54:52 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 933CBE6E
        for <linux-cifs@vger.kernel.org>; Sun, 25 Jun 2023 23:54:48 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f957a45b10so3426093e87.0
        for <linux-cifs@vger.kernel.org>; Sun, 25 Jun 2023 23:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687762487; x=1690354487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WbgjiPC3hxEdDyEqqzabtUxopI3EfRgXVlP9gUMkL98=;
        b=AGe+bnuIp7B1gBV/V+9aIE5DnLNA+mVoQ5+zLBNvkZTDyezM4342CuFsgtEKD1GxYt
         7YinaF6eWgaazYoBF+N1I2yJJ48jgDoY6iuGrXNgh3L1V28c6ksOkxw5pSIm7/2goOfF
         XWKNP2PaPd3HJUZeCnCCFuX+3FpMckmFb4nEJ8zFFaUJ7wiw4ABYI/4J+PWAITBuiXnh
         WbcO87PeE7rugIp5tALLnkZNS//A3e2UMCQV0qvHosp3ZYH4JMpNhyWQYfc1lEwSC0iI
         CB2RJmEIuYBFLpddkE0BHYUL6q87XdgHwg41Ry6kZxa/E4s+kCiAgzVEbEulzVSWUyKl
         VF3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687762487; x=1690354487;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WbgjiPC3hxEdDyEqqzabtUxopI3EfRgXVlP9gUMkL98=;
        b=MWar/UfHVtRfZuvZohXA5P2V9ay4tFiBp4+W7FLa63eoGYQGN5Q3YkktSMlGW82Z6P
         1IonXNB0q6oSJgQsY8hMLMT6W/C1JZa3OMUMoBU8eGkKaj+TUOl7qxxrKy28xA54CBKH
         MOG/N+DmvBSSz/voVTlt34P3bazoto6FklV6PImEIeNx1zs0JcM8jNBh7vJnbnkEuWdu
         Rj2Ik3DdWTnA7GvjpzMRjpU+p8mjKGO6O1y55GAz/8cWUr0lwhVm3H9WT5n35cBVs9/3
         nNavTrOtKFDq0EQgdltgxsOEhLb0CvcUUn48ER5CaptNKzTCq6qt5GE8kMZNmLXos8mZ
         a6eQ==
X-Gm-Message-State: AC+VfDxGcGPiQzZDSjX51ZVafhtX/eoFezNR1Uq/QAe/s4j2DtGqL2/X
        rY2izXSqPqjsx0EcI3a2XfmIkQs9YexeVi5g7U36sLLI7KFYH6qX
X-Google-Smtp-Source: ACHHUZ4WPvx3JNREvQk6bixvUBZg9mcy/B2K751CDsch7Ta0UfPVZan6EMKVWiU+QMeiKoVN4dcFsqnR1gUOQD1l5/w=
X-Received: by 2002:a05:6512:3ec:b0:4fa:fc12:2bdd with SMTP id
 n12-20020a05651203ec00b004fafc122bddmr1074145lfq.40.1687762486545; Sun, 25
 Jun 2023 23:54:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230626034257.2078391-1-wentao@uniontech.com>
 <20230626034257.2078391-2-wentao@uniontech.com> <CANT5p=pD+s8h33rgyjLHkJhz-OkAt3PMP5Oz612Qm3GO-PE2EQ@mail.gmail.com>
 <CAH2r5mtE8EmEPdxHc+AT256-ekzH1wjmTO+DbODHx+5PEYC9eA@mail.gmail.com>
In-Reply-To: <CAH2r5mtE8EmEPdxHc+AT256-ekzH1wjmTO+DbODHx+5PEYC9eA@mail.gmail.com>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Mon, 26 Jun 2023 12:24:35 +0530
Message-ID: <CANT5p=oETR0vg29rGohLXoeqw0Lrrt8GsLbhjV6snLth7od=Nw@mail.gmail.com>
Subject: Re: [PATCH 1/3] cifs: fix session state transition to avoid
 use-after-free issue
To:     Steve French <smfrench@gmail.com>
Cc:     Winston Wen <wentao@uniontech.com>, sfrench@samba.org,
        linux-cifs@vger.kernel.org, pc@manguebit.com, sprasad@microsoft.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Mon, Jun 26, 2023 at 10:54=E2=80=AFAM Steve French <smfrench@gmail.com> =
wrote:
>
> Added Cc: stable and Shyam's RB and merged into cifs-2.6.git for-next
>
> On Mon, Jun 26, 2023 at 12:15=E2=80=AFAM Shyam Prasad N <nspmangalore@gma=
il.com> wrote:
> >
> > On Mon, Jun 26, 2023 at 9:25=E2=80=AFAM Winston Wen <wentao@uniontech.c=
om> wrote:
> > >
> > > We switch session state to SES_EXITING without cifs_tcp_ses_lock now,
> > > it may lead to potential use-after-free issue.
> > >
> > > Consider the following execution processes:
> > >
> > > Thread 1:
> > > __cifs_put_smb_ses()
> > >     spin_lock(&cifs_tcp_ses_lock)
> > >     if (--ses->ses_count > 0)
> > >         spin_unlock(&cifs_tcp_ses_lock)
> > >         return
> > >     spin_unlock(&cifs_tcp_ses_lock)
> > >         ---> **GAP**
> > >     spin_lock(&ses->ses_lock)
> > >     if (ses->ses_status =3D=3D SES_GOOD)
> > >         ses->ses_status =3D SES_EXITING
> > >     spin_unlock(&ses->ses_lock)
> > >
> > > Thread 2:
> > > cifs_find_smb_ses()
> > >     spin_lock(&cifs_tcp_ses_lock)
> > >     list_for_each_entry(ses, ...)
> > >         spin_lock(&ses->ses_lock)
> > >         if (ses->ses_status =3D=3D SES_EXITING)
> > >             spin_unlock(&ses->ses_lock)
> > >             continue
> > >         ...
> > >         spin_unlock(&ses->ses_lock)
> > >     if (ret)
> > >         cifs_smb_ses_inc_refcount(ret)
> > >     spin_unlock(&cifs_tcp_ses_lock)
> > >
> > > If thread 1 is preempted in the gap and thread 2 start executing, thr=
ead 2
> > > will get the session, and soon thread 1 will switch the session state=
 to
> > > SES_EXITING and start releasing it, even though thread 1 had increase=
d the
> > > session's refcount and still uses it.
> > >
> > > So switch session state under cifs_tcp_ses_lock to eliminate this gap=
.
> > >
> > > Signed-off-by: Winston Wen <wentao@uniontech.com>
> > > ---
> > >  fs/smb/client/connect.c | 7 ++++---
> > >  1 file changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
> > > index 9d16626e7a66..165ecb222c19 100644
> > > --- a/fs/smb/client/connect.c
> > > +++ b/fs/smb/client/connect.c
> > > @@ -1963,15 +1963,16 @@ void __cifs_put_smb_ses(struct cifs_ses *ses)
> > >                 spin_unlock(&cifs_tcp_ses_lock);
> > >                 return;
> > >         }
> > > +       spin_lock(&ses->ses_lock);
> > > +       if (ses->ses_status =3D=3D SES_GOOD)
> > > +               ses->ses_status =3D SES_EXITING;
> > > +       spin_unlock(&ses->ses_lock);
> > >         spin_unlock(&cifs_tcp_ses_lock);
> > >
> > >         /* ses_count can never go negative */
> > >         WARN_ON(ses->ses_count < 0);
> > >
> > >         spin_lock(&ses->ses_lock);
> > > -       if (ses->ses_status =3D=3D SES_GOOD)
> > > -               ses->ses_status =3D SES_EXITING;
> > > -
> > >         if (ses->ses_status =3D=3D SES_EXITING && server->ops->logoff=
) {
> > >                 spin_unlock(&ses->ses_lock);
> > >                 cifs_free_ipc(ses);
> > > --
> > > 2.40.1
> > >
> >
> > Good catch.
> > Looks good to me.
> > @Steve French Please CC stable for this one.
> >
> > --
> > Regards,
> > Shyam
>
>
>
> --
> Thanks,
>
> Steve

@Winston Wen I think the following change should be sufficient to fix
this issue:
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 9d16626e7a66..78874eb2537d 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -1963,10 +1963,11 @@ void __cifs_put_smb_ses(struct cifs_ses *ses)
                spin_unlock(&cifs_tcp_ses_lock);
                return;
        }
-       spin_unlock(&cifs_tcp_ses_lock);

        /* ses_count can never go negative */
        WARN_ON(ses->ses_count < 0);
+       list_del_init(&ses->smb_ses_list);
+       spin_unlock(&cifs_tcp_ses_lock);

        spin_lock(&ses->ses_lock);
        if (ses->ses_status =3D=3D SES_GOOD)
@@ -1986,9 +1987,6 @@ void __cifs_put_smb_ses(struct cifs_ses *ses)
                cifs_free_ipc(ses);
        }

-       spin_lock(&cifs_tcp_ses_lock);
-       list_del_init(&ses->smb_ses_list);
-       spin_unlock(&cifs_tcp_ses_lock);

        chan_count =3D ses->chan_count;

The bug was that the ses was kept in the smb ses list, even after the
ref count had reached 0.
With the above change, that should be fixed, and no one should be able
to get to the ses from that point.

Please let me know if you see a problem with this.

--=20
Regards,
Shyam
