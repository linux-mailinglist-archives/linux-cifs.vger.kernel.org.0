Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 474096D429
	for <lists+linux-cifs@lfdr.de>; Thu, 18 Jul 2019 20:46:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390853AbfGRSqn (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 18 Jul 2019 14:46:43 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:39441 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726040AbfGRSqm (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 18 Jul 2019 14:46:42 -0400
Received: by mail-pg1-f196.google.com with SMTP id u17so13283598pgi.6
        for <linux-cifs@vger.kernel.org>; Thu, 18 Jul 2019 11:46:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=a81tnllsz/90Yb8Rycdj4UdxuaOMAOvQxDmlz6GL7WU=;
        b=RVDqf8gnMge8dqm9Eag3LnSz7e+WZ62yIegnda03XIUmXsE5GukGaYeD0SkrmLeIto
         0Pz/sal5XsDzJDFBGDp2GI06Gf1ljDiOXTEgTe32aLI9T2KdiwCoL5IeexFnJMvzSv0t
         SX7HufAsHaNUhg9Gml3nXv42DTqBpBHeSmC1RjU9HS+NDK8NvcfrQiUpC7bE/xnqCNNb
         aar4zybvCgzZbgdkMTGsuFOF6FpfEQUgpMxKfWN+bXxGjfzbm7Iz7WLREZAi424qkrB4
         wSXhcA4fRVM/1sWcHwiXOgGvgMLGY1S9QT6B5Crts4APlA1+gPOuXqlttX7a01Q8fcP+
         5TFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=a81tnllsz/90Yb8Rycdj4UdxuaOMAOvQxDmlz6GL7WU=;
        b=eI91ZI7MUFPAdC2WXJXXpp0sS/1KtJnOeUQOpWfKK3LAEM1GiQn2OVApxuHFAfWfx9
         UocMbX4jSEKo1SJxnxCEEKshdUpD8uJ/bby30z45aVFdk/sFp3O/BWRTDyfoDnJTYBty
         96kDsyjUfS5jL/Uc5vWkXRvSE6NKoHQ1ouftdOOXctoBMds8MCIthaFDxYbMstQJBQVr
         L1wXh9o/F5ts14ndjQFhZQNVWi2pyYOD6S2Y0NtoOkz/LhZFPrXG4vCQ4Is6QMS3uijY
         Q8qoIvDX0lbk+zqs/aYgHEbz4k81zJPengf1J0kMheJ06BkZ2Nke1oLYv6IZOFRMNJ+m
         ZJbg==
X-Gm-Message-State: APjAAAWVHQtMP+ruwJx/cgdaE80VmuBEhPZM3NlIuCquxKO+lun3Pbz2
        Xf4q0zKpSh9XQsXU43o3YAREPrujY1Z2bRb5OH4=
X-Google-Smtp-Source: APXvYqwu4fJPyXSPTJDzQNHVX8kksd5RiVf1Lm4PvKt3PjkkqMwdJymoZLGPpi2TP/YE+dEJkYoshqsjx+PtzSadn9o=
X-Received: by 2002:a63:d4c:: with SMTP id 12mr50202836pgn.30.1563475601301;
 Thu, 18 Jul 2019 11:46:41 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mtn5SyUao9Y3f-_ubqgSV8t3RSj2fzAR9bE5ZQQ5dFcRQ@mail.gmail.com>
 <CAKywueQEk84q-3PNNvGQNYLc9DXfygy+75LNBfyTKRo-iFvmGw@mail.gmail.com>
In-Reply-To: <CAKywueQEk84q-3PNNvGQNYLc9DXfygy+75LNBfyTKRo-iFvmGw@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 18 Jul 2019 13:46:29 -0500
Message-ID: <CAH2r5mu4y69J4ChFhbejFhG50P5CnKLwKRUAZZ+C+aMx09Qg2Q@mail.gmail.com>
Subject: Re: [SMB3][PATCH] Speed up open by skipping query FILE_INTERNAL_INFORMATION
To:     Pavel Shilovsky <pavel.shilovsky@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Also fyi - did some experiments today.  Perf across the open vfs entry
point averaged about 20% better with the patch

On Thu, Jul 18, 2019 at 12:37 PM Pavel Shilovsky
<pavel.shilovsky@gmail.com> wrote:
>
> index 54bffb2a1786..e6a1fc72018f 100644
> --- a/fs/cifs/smb2file.c
> +++ b/fs/cifs/smb2file.c
> @@ -88,14 +88,20 @@ smb2_open_file(const unsigned int xid, struct
> cifs_open_parms *oparms,
>   }
>
>   if (buf) {
> - /* open response does not have IndexNumber field - get it */
> - rc =3D SMB2_get_srv_num(xid, oparms->tcon, fid->persistent_fid,
> + /* if open response does not have IndexNumber field - get it */
> + if (smb2_data->IndexNumber =3D=3D 0) {
>
> What's about a server returning 0 for the IndexNumber?
>
> - if (rsp->OplockLevel =3D=3D SMB2_OPLOCK_LEVEL_LEASE)
> - *oplock =3D smb2_parse_lease_state(server, rsp,
> - &oparms->fid->epoch,
> - oparms->fid->lease_key);
> - else
> +
> + *oplock =3D smb2_parse_contexts(server, rsp, &oparms->fid->epoch,
> +       oparms->fid->lease_key,
> +       buf);
> + if (*oplock =3D=3D 0) /* no lease open context found */
>   *oplock =3D rsp->OplockLevel;
>
> oplock being 0 here probably means that the lease state which is
> granted is NONE. You still need to keep if (rsp->OplockLevel =3D=3D
> SMB2_OPLOCK_LEVEL_LEASE) gate.
>
>  /* See MS-SMB2 2.2.14.2.9 */
>  struct on_disk_id {
>
> Please prefix the structure name with "create_".
>
> Best regards,
> Pavel Shilovskiy
>
> =D1=87=D1=82, 18 =D0=B8=D1=8E=D0=BB. 2019 =D0=B3. =D0=B2 00:43, Steve Fre=
nch via samba-technical
> <samba-technical@lists.samba.org>:
> >
> > Now that we have the qfid context returned on open we can cut 1/3 of
> > the traffic on open by not sending the query FILE_INTERNAL_INFORMATION
> >
> >
> >
> > --
> > Thanks,
> >
> > Steve



--=20
Thanks,

Steve
