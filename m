Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D185A219048
	for <lists+linux-cifs@lfdr.de>; Wed,  8 Jul 2020 21:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726211AbgGHTQn (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 8 Jul 2020 15:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726044AbgGHTQm (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 8 Jul 2020 15:16:42 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6B6C061A0B
        for <linux-cifs@vger.kernel.org>; Wed,  8 Jul 2020 12:16:42 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id a15so7943947ybs.8
        for <linux-cifs@vger.kernel.org>; Wed, 08 Jul 2020 12:16:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=Duh0uzOj6J07aRq7UMRgOSSfvFLEiW5kUERh4WPwHHg=;
        b=MU2BzI+uKRRX9wijdtNdg9K/Ac/Jo6w5hccvcmiXRUqwLeUmzKWeu7jhgi2P0GTAY2
         SSb1Nn1zu9RhkZ0WTOr0hm5JwfJ+BkiLitNE4632uftowy24sspKlJGvV6pQYWCgTeig
         c7tAfOQQdrrN299fqm9t+xpNMWaxWMkRidW3+C3tp2gbK4Xtuh3/RUuo7sD7IlxpkUv3
         n8IJKYkikbttatKfRkMRsn7zJ6VyYrFOOhYqLIGZp4iPmfkAuQehczMpgcBcczNMkehp
         s8f3bpSqKuY7WkLmCQlNc3hWefbCa2FHMUl09wESI/nREDDthnBkK8CspaWDNUlliSRX
         VjZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=Duh0uzOj6J07aRq7UMRgOSSfvFLEiW5kUERh4WPwHHg=;
        b=KBaZeY3VAEF2BG5g5rntIn6hOwNMnan7NZIZoV8BrzBo9yls+RanCTvn9BGUhcHlxW
         IwjcUHAW0101YrBEi/jCrIX+TgoxiNbA9RK2rqiywT3X8LHIJGGQ0urBiwrELGrXi94U
         P86IFecMKwsN3ZA7Xkt7rgLmxMD+Enonpamsm5qJ1c2PfGCKi1kdVLrZTYKjyCASC5Am
         LrlPseakm7Nv4zxzitXKlIm7cT5WBUsLTxaAafQMj8m6IzzTTCYe0OfoucjZBiWAH2Tz
         mEnoXdCy94erFjSS50DYz7bFU884x0Ppk1UWBze1XUZcJ+nT4hliB6L8TTX0yddzcXPV
         s/gg==
X-Gm-Message-State: AOAM530JcCFJJvCkw9VhEr2ZO77EAsT+LBwQZfGTvFd8oMCZ1IBofnh2
        KYG2ELd5/vzHGidGYBaIBy0B4iNfo/3vkwgrfAlyDW5v
X-Google-Smtp-Source: ABdhPJwuwAqtceG27ih5x1Na0TG3AUV//us/d4NpSqjtXx4sxn/ZVrDIPWl9miGXubPobCcrPGMAN3pvHHOKaJNsYSE=
X-Received: by 2002:a25:23c7:: with SMTP id j190mr32041122ybj.167.1594235800465;
 Wed, 08 Jul 2020 12:16:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200707112741.9496-1-weiyongjun1@huawei.com> <87o8oq5bzb.fsf@suse.com>
In-Reply-To: <87o8oq5bzb.fsf@suse.com>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 8 Jul 2020 14:16:29 -0500
Message-ID: <CAH2r5mujuy6NDioDDq0MyMhabZzK1NgeVNCnjgTRnidwbK7RYw@mail.gmail.com>
Subject: Re: [PATCH -next] cifs: remove unused variable 'server'
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     Wei Yongjun <weiyongjun1@huawei.com>,
        Hulk Robot <hulkci@huawei.com>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

merged into cifs-2.6.git for-next (for 5.9 when merge window opens up)

On Wed, Jul 8, 2020 at 9:16 AM Aur=C3=A9lien Aptel via samba-technical
<samba-technical@lists.samba.org> wrote:
>
>
> Reviewed-by: Aurelien Aptel <aaptel@suse.com>
>
> --
> Aur=C3=A9lien Aptel / SUSE Labs Samba Team
> GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg,=
 DE
> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=
=BCnchen)
>


--=20
Thanks,

Steve
