Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 875DED2FFB
	for <lists+linux-cifs@lfdr.de>; Thu, 10 Oct 2019 20:07:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726970AbfJJSGy (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 10 Oct 2019 14:06:54 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:39707 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726387AbfJJSGy (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 10 Oct 2019 14:06:54 -0400
Received: by mail-lf1-f67.google.com with SMTP id 72so5094525lfh.6
        for <linux-cifs@vger.kernel.org>; Thu, 10 Oct 2019 11:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=BndcwX1Z+lIjfOHVWvJ0qAxRuB4weS1oprdoAEC5iHc=;
        b=F+zoyUocezVwQwiliSpeYUSFYllfJRTqsNbwggas9EDlofFE2r/6pzgZ4JxmYTnAGd
         PLszu/dwkR/HXw6/ZKeIqomgjfRUv504MGmjEyCUiyylAKO3p2m+bL9BbLbDs4qwRPWl
         c82duUvUUGwavn7//P6gkUpVqdDkkuwYnm3UaGSYBze8orfMpWDcZFA1RyY7O6JaQjr+
         ua+rIYFZUHkXTSDG7BPtn+MQa1BehO70WZUd6/Ax9OdqEEv1ZseDbRm2uNujG/vj7pK4
         ZNzYLtdZCPEJvM2MTvoVUW5xoyriU0R0Ua4lg638Q2M4Mpeg9dTqx4c4/tQtf1awgkCa
         Eg1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=BndcwX1Z+lIjfOHVWvJ0qAxRuB4weS1oprdoAEC5iHc=;
        b=GzkhhiTa3SWoIbVScb2c3ywuKZdgwkTLk0qqKoAYJJ+qm8STovQk3SY6+tdvndSRIB
         vIf4WU5lvmp4lx5QojNzbJ3MJyhdBkP82OF19tGJYU+mRX/WJtieKTYCZEoBYrebXTxK
         o0UieF96qtkzGocls/VY8GVyv/+3ToCeu9IwgsYZLr4GPTHwdi4W3QB0lW23uXJeBBZC
         GVNkN2oFwvv/kwcKsYLYvGC6NKwiAVoN5ZFkMqwSfe4vU9Ac0DQN449eIrMayk5lXaLl
         vOIOGkNieFbtwbHb+J06Hrr8nVhZXVOdlZQ08kMqN+wskNMTBaM29gBD7qxUbhnSvwz7
         XMWg==
X-Gm-Message-State: APjAAAUj7dxpyXYLvXvgTkBtfpNxojzjunc9jhlTaSvBpaEF5nS7QZFC
        hGfcf5lcodH+v89tsXJMSsgeaIla1PME3aJXRCcwV8g=
X-Google-Smtp-Source: APXvYqxjTGJmw8jqYRWx3myIhSH0hloUfypJNgzoaH7zQAHmVr4OEtmhPDYG2Exr5uixevWiE7VJXb4qkXH/KTbEou0=
X-Received: by 2002:a19:ed14:: with SMTP id y20mr6789422lfy.4.1570730812430;
 Thu, 10 Oct 2019 11:06:52 -0700 (PDT)
MIME-Version: 1.0
References: <20190930170620.29979-1-pshilov@microsoft.com> <20190930170620.29979-3-pshilov@microsoft.com>
In-Reply-To: <20190930170620.29979-3-pshilov@microsoft.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Thu, 10 Oct 2019 11:06:41 -0700
Message-ID: <CAKywueSX_KQqyFaQQgJBt2AYivNP=Y+mBmJH+XVoCbQBCsoBCg@mail.gmail.com>
Subject: Re: [PATCH 3/3] CIFS: Force reval dentry if LOOKUP_REVAL flag is set
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>,
        Pavel Shilovskiy <pshilov@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The updated version of this has been merged into for-next:

https://git.samba.org/?p=3Dsfrench/cifs-2.6.git;a=3Dcommitdiff;h=3D0b3d0ef9=
840f7be202393ca9116b857f6f793715

--
Best regards,
Pavel Shilovsky

=D0=BF=D0=BD, 30 =D1=81=D0=B5=D0=BD=D1=82. 2019 =D0=B3. =D0=B2 10:06, Pavel=
 Shilovsky <piastryyy@gmail.com>:
>
> Mark inode for force revalidation if LOOKUP_REVAL flag is set.
> This tells the client to actually send a QueryInfo request to
> the server to obtain the latest metadata in case a directory
> or a file were changed remotely.
>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Pavel Shilovsky <pshilov@microsoft.com>
> ---
>  fs/cifs/dir.c | 8 +++++++-
>  1 file changed, 7 insertions(+), 1 deletion(-)
>
> diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
> index be424e81e3ad..91a46b01d748 100644
> --- a/fs/cifs/dir.c
> +++ b/fs/cifs/dir.c
> @@ -738,10 +738,16 @@ cifs_lookup(struct inode *parent_dir_inode, struct =
dentry *direntry,
>  static int
>  cifs_d_revalidate(struct dentry *direntry, unsigned int flags)
>  {
> +       struct inode *inode;
> +
>         if (flags & LOOKUP_RCU)
>                 return -ECHILD;
>
>         if (d_really_is_positive(direntry)) {
> +               inode =3D d_inode(direntry);
> +               if (flags & LOOKUP_REVAL)
> +                       CIFS_I(inode)->time =3D 0; /* force reval */
> +
>                 if (cifs_revalidate_dentry(direntry))
>                         return 0;
>                 else {
> @@ -752,7 +758,7 @@ cifs_d_revalidate(struct dentry *direntry, unsigned i=
nt flags)
>                          * attributes will have been updated by
>                          * cifs_revalidate_dentry().
>                          */
> -                       if (IS_AUTOMOUNT(d_inode(direntry)) &&
> +                       if (IS_AUTOMOUNT(inode) &&
>                            !(direntry->d_flags & DCACHE_NEED_AUTOMOUNT)) =
{
>                                 spin_lock(&direntry->d_lock);
>                                 direntry->d_flags |=3D DCACHE_NEED_AUTOMO=
UNT;
> --
> 2.17.1
>
