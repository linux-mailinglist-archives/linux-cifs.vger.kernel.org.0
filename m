Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B3B539F67F
	for <lists+linux-cifs@lfdr.de>; Wed, 28 Aug 2019 01:00:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726034AbfH0XAg (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 27 Aug 2019 19:00:36 -0400
Received: from mail-io1-f66.google.com ([209.85.166.66]:41307 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbfH0XAg (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 27 Aug 2019 19:00:36 -0400
Received: by mail-io1-f66.google.com with SMTP id j5so1937351ioj.8
        for <linux-cifs@vger.kernel.org>; Tue, 27 Aug 2019 16:00:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ojht16GA81z8gNUYJ0iY14RCSqzo84B9UEBhb9TIvsA=;
        b=bRSwTeIQ+VkxUUUVxd1ywYvApBkDrtlwpsXwq2m/LKMNNfB5S4ulMnbCbUFlC1nmvW
         M94+70IwCvsfFaN0fAuOfQyKZFANqTN+82xdVGF4tXLfTHSOlP3sjVZiu2idLIS4f+bw
         Ekj1LJ2tg63TkZV0+PP3DHAsZKOJ0h4DfTLf2tPLm9XDaXB8PjX2csTCtjgA8RvcdXXp
         bcrioSRREg5fDdhGxMkcR6C8I222timzVe2fB8MriQ/Iou5iJvauGK8t54XjnspI/+2i
         weScAjYieN+ZaGIgNNXvkA7BeVguvR2La437Uyfx9yCD5gwKt2CzkrlrBAcPXlFCEUAT
         NVCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ojht16GA81z8gNUYJ0iY14RCSqzo84B9UEBhb9TIvsA=;
        b=TzolOzhJLL8pHs8hxiMQGN2WoXpkXqJRO9ED2idPTm80I555LmbAUESXxqdJI2Sye1
         mOiOA+y7xmvsayYmtYqm1fWakz/IyUoLF3zUJ1DuZi9JIgwKplY+RT4NhcT+OMuletoN
         z5kjPDCvvy9gUxNeoQfoGkwSmEqulsnDE4PbgI1iVbWnXphThxyCuVPJwoLRWIq3MvKs
         IBZxgqq2h6fvBoRA4CItSjhCaukyLR3rMpfn7acMsn2HTF8gp55Q42cFLaBLtlPh3BGv
         G/Do0fUxhCh1KTqmcAqxxAqsHAyh0zScAhXhPYmmbwGJCqMKULWkwNzQkScyrddwihbp
         425g==
X-Gm-Message-State: APjAAAV1NEPHK1+a1VH8QKn9df0hxUsoatOWDgef6gFdD2TK4CE4gzHC
        1NAuyhe6a+r1gIHjYsRLpvJmndgeVOniL2CP+7wHncT2
X-Google-Smtp-Source: APXvYqwppGq8NRV5DDu3AxLeVCbCcQY177ajV+yS3E1L5DqpWStVMrgnQWVg7MfUUy2XWyp0SAZ8/1EEvPaSVuzlceM=
X-Received: by 2002:a6b:ea12:: with SMTP id m18mr898504ioc.173.1566946835888;
 Tue, 27 Aug 2019 16:00:35 -0700 (PDT)
MIME-Version: 1.0
References: <20190827013558.18281-1-lsahlber@redhat.com> <20190827013558.18281-2-lsahlber@redhat.com>
In-Reply-To: <20190827013558.18281-2-lsahlber@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 27 Aug 2019 18:00:24 -0500
Message-ID: <CAH2r5mtkxUw4PbT3PwaG=4i06p7kx7iTK_U9-=4YXjNHds-oUA@mail.gmail.com>
Subject: Re: [PATCH 2/2] cifs: fix incorrect error return in build_unc_path_to_root
To:     Ronnie Sahlberg <lsahlber@redhat.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

I fixed this in an earlier patch of yours

On Mon, Aug 26, 2019 at 8:36 PM Ronnie Sahlberg <lsahlber@redhat.com> wrote:
>
> Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> ---
>  fs/cifs/connect.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index 1ed449f4a8ec..c5dc8265b671 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -4232,7 +4232,7 @@ build_unc_path_to_root(const struct smb_vol *vol,
>         unsigned int unc_len = strnlen(vol->UNC, MAX_TREE_SIZE + 1);
>
>         if (unc_len > MAX_TREE_SIZE)
> -               return -EINVAL;
> +               return ERR_PTR(-EINVAL);
>
>         full_path = kmalloc(unc_len + pplen + 1, GFP_KERNEL);
>         if (full_path == NULL)
> --
> 2.13.6
>


-- 
Thanks,

Steve
