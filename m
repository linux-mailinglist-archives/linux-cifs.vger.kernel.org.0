Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B460741703
	for <lists+linux-cifs@lfdr.de>; Wed, 28 Jun 2023 19:12:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230401AbjF1RLl (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 28 Jun 2023 13:11:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42818 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231756AbjF1RLg (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 28 Jun 2023 13:11:36 -0400
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C8D11BE4
        for <linux-cifs@vger.kernel.org>; Wed, 28 Jun 2023 10:11:35 -0700 (PDT)
Received: by mail-lj1-x235.google.com with SMTP id 38308e7fff4ca-2b698371937so550901fa.3
        for <linux-cifs@vger.kernel.org>; Wed, 28 Jun 2023 10:11:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687972293; x=1690564293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NMv3777/YTurjcvjie9GllkTQsE+XVdsYVKinVQytWQ=;
        b=GqCV+sZADqDCfBZRnme5gvJHpZrXFpfLKnVE1rHya4r0Q6wcTfrBC6lPyO+82YA+MW
         BxpFXLS3kqDmQ36qnK31IHqZmpND8bf5RWACAMNW5a/IyGa0Udq45hGR+2SKXEBG115j
         xnsh0s2G6uzi1XLUtqhvYhx1DOoKtVyjJp8MNRuma/jwkDvSdvf0s51SQXgKMTVe/ky/
         V5nsbKcgENjan4Dy1w78KlkkqHT2qXGShPOB+FeZhY0mrV7seUlUbQE/Jho1wAVmSBWF
         RrpR/uTMFScvn0NjECqomMtlHgdmUSB/5JYTccuJdZCkAvF5pKCPuYawwESNlVC8Td10
         6uuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687972293; x=1690564293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NMv3777/YTurjcvjie9GllkTQsE+XVdsYVKinVQytWQ=;
        b=Q+ldArPUg1V5Y8w7pP3F+OR4cUp1VHXwAOSupcz8MBMcqA0XVpvbp5bZbfhVmBabe7
         ytNUT+KwDuQ0pSDnMjLHHFRvIaSavNF9uTxdEz3HbzWi4z2LGqoo6q04x/DnxkVL7Ss/
         w7mbFnumMXUhS6hGvyUuj50MWmXtm8u3+GEFvVHwWCS+KKvy0KuONAkYW21rM2h467mS
         SrYyrVNfCpdYP+h+kxch5E9cRXW0EEFUitECDEwTlKPBNdcNpWuDBgzwAtTuSL3/DfKS
         7eP+HmqiCFdm5yB3zfS9wwvQ7oSlcnVjCan7eEFwOKdDqAQEIq16oyC6lxSTWMdBDAdH
         f8bg==
X-Gm-Message-State: AC+VfDzhm3bu/ht1T9L+eQMdhqYUqJSiowNuKNZu1PFBV/izidOao7Nw
        ZDWGUqDHsJHwlY9xBDA2aMhd6Q1zD5aeFmKx20ycXolu
X-Google-Smtp-Source: ACHHUZ7f8FP2Y3AEErIOwgC9/P5HaoZTB9ho3LVW2QuEN059HWJVg+je4GijGYDChP9ZBfT/IyesgyjhG0CLdP0QK74=
X-Received: by 2002:a2e:8894:0:b0:2b6:a0c2:edaa with SMTP id
 k20-20020a2e8894000000b002b6a0c2edaamr7085439lji.32.1687972293047; Wed, 28
 Jun 2023 10:11:33 -0700 (PDT)
MIME-Version: 1.0
References: <20230609174659.60327-1-sprasad@microsoft.com> <20230609174659.60327-4-sprasad@microsoft.com>
 <nlpmf2nsqosbz5ifzycdpoqmi22tkcoouuk4pjsp4exa2jtyqm@wzdmdh625e5p>
 <CANT5p=oGXceYkn=+7KjbN=9oC14S0ue16LAPB_56hyX588iOXw@mail.gmail.com>
 <CANT5p=rPRPVaRe2S4j=OqJTbOhs9onqR2ZNTMPNE1L_71aNQbw@mail.gmail.com>
 <a38028f0fbc7d6abb1f118f110537f21.pc@manguebit.com> <g6yidp2mk3sseniwodvdz6d3svgq2kt6jzsbuiuh4gb2zmj3g3@yl6cqh37q7bx>
 <CANT5p=qPivH8p+_SXMN0phKPTKqkSoEHdc+omhvM10YckbSvFw@mail.gmail.com>
 <1ca61d08-6e34-48aa-62b2-e246a5bb3ef2@talpey.com> <CANT5p=pW-O7UQgfRKR6XpFnnFka9PVQQ0y1YtOz+DcaQt9yH3Q@mail.gmail.com>
 <CANT5p=qdS6FFj9ay3bDiP+mWnU1b-NJp2TLb0YdAFyvkqZcKFw@mail.gmail.com>
In-Reply-To: <CANT5p=qdS6FFj9ay3bDiP+mWnU1b-NJp2TLb0YdAFyvkqZcKFw@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 28 Jun 2023 12:11:21 -0500
Message-ID: <CAH2r5mvweFgQeZJsprx372ae9d8KLcmBiGawnHKhWO=74B6VMQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] cifs: display the endpoint IP details in DebugData
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     Tom Talpey <tom@talpey.com>, Enzo Matsumiya <ematsumiya@suse.de>,
        Paulo Alcantara <pc@manguebit.com>, linux-cifs@vger.kernel.org,
        pc@cjr.nz, bharathsm.hsk@gmail.com,
        Shyam Prasad N <sprasad@microsoft.com>
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

also removed an extra colon in two places (IP addr dst: ..." then
"src:" already had the colon so didn't need "IP addr: dst: ..."

On Wed, Jun 28, 2023 at 5:20=E2=80=AFAM Shyam Prasad N <nspmangalore@gmail.=
com> wrote:
>
> On Tue, Jun 27, 2023 at 5:47=E2=80=AFPM Shyam Prasad N <nspmangalore@gmai=
l.com> wrote:
> >
> > On Fri, Jun 23, 2023 at 9:24=E2=80=AFPM Tom Talpey <tom@talpey.com> wro=
te:
> > >
> > > On 6/23/2023 12:21 AM, Shyam Prasad N wrote:
> > > > On Mon, Jun 12, 2023 at 8:59=E2=80=AFPM Enzo Matsumiya <ematsumiya@=
suse.de> wrote:
> > > >>
> > > >> On 06/12, Paulo Alcantara wrote:
> > > >>> Shyam Prasad N <nspmangalore@gmail.com> writes:
> > > >>>
> > > >>>> I had to use kernel_getsockname to get socket source details, no=
t
> > > >>>> kernel_getpeername.
> > > >>>
> > > >>> Why can't you use @server->srcaddr directly?
> > > >>
> > > >> That's only filled if explicitly passed through srcaddr=3D mount o=
ption
> > > >> (to bind it later in bind_socket()).
> > > >>
> > > >> Otherwise, it stays zeroed through @server's lifetime.
> > > >
> > > > Yes. As Enzo mentioned, srcaddr is only useful if the user gave tha=
t
> > > > mount option.
> > > >
> > > > Also, here's an updated version of the patch.
> > > > kernel_getsockname seems to be a blocking function, and we need to
> > > > drop the spinlock before calling it.
> > >
> > > Why does this not do anything to report RDMA endpoint addresses/ports=
?
> > > Many RDMA protocols employ IP addressing.
> > >
> > > If it's intended to not report such information, there should be some
> > > string emitted to make it clear that this is TCP-specific. But let's
> > > not be lazy here, the smbd_connection stores the rdma_cm_id which
> > > holds similar information (the "rdma_addr").
> > >
> > > Tom.
> >
> > Hi Tom,
> >
> > As always, thanks for reviewing.
> > My understanding of RDMA is very limited. That's the only reason why
> > my patch did not contain changes for RDMA.
> > Let me dig around to understand what needs to be done here.
> >
> > --
> > Regards,
> > Shyam
>
> Here's a version of the patch with changes for RDMA as well.
> But I don't know how to test this, as I do not have a setup with RDMA.
> @Tom Talpey Can you please review and test out this patch?
>
> --
> Regards,
> Shyam



--=20
Thanks,

Steve
