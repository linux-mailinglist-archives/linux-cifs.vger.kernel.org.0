Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D2BA2A7762
	for <lists+linux-cifs@lfdr.de>; Wed,  4 Sep 2019 01:00:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725990AbfICXAq (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 3 Sep 2019 19:00:46 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:40080 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725882AbfICXAq (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 3 Sep 2019 19:00:46 -0400
Received: by mail-io1-f68.google.com with SMTP id h144so24485617iof.7
        for <linux-cifs@vger.kernel.org>; Tue, 03 Sep 2019 16:00:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=tpxNAEZbBezwq3krS/EPGkxMHdh8CnRju4ktRcIZ7Zk=;
        b=uBVTXNDGAu2CZ3gfw1R8LXJIkTM7cRM1AKrXvM6VeJhI3/oxjkXgiFGfG+dU/6EXx4
         J5qofNI8wMt78KduWlVBJn7MVxUKmT4XjZ8LfUeHm/DCbRuRtJ9ZcKQ+pv7f5UgXgg5O
         CtwFNhyeyiK5L8eTToQ4g5R2i+XZ/bw3n36qRWHI93hMNkC/M9vHriIsEztNrpFFsDGL
         FoDWTQtPQDGqsIge2R7sm5PjuuevR9DEg5hoebpOpH7kqxFwYTbcFtPCq+NkL3JDL3/C
         G/Fxx3mHYbYFYkp4NgOvmhmY+QUvm6Ccu+B+pjyzvZi7iynzy30Kwabl2lhpxG02/23u
         49ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=tpxNAEZbBezwq3krS/EPGkxMHdh8CnRju4ktRcIZ7Zk=;
        b=oBW8VrEhxhFaAdAdgFdjGyT7bI3OrYduYY9De69CX65NGr1KgpSkeUutLgrToUkCfA
         kMr+ENLRsNwxQjRfvk82x00GJemJSFWBPx7WDUs/sCYr/englftx7pAXBiEOS1DZSG/4
         N6sShOiAOs4Q8QfZv9VUBu2s0UAgyYSsYEJwUfwpCV9D1Aki1RsOxg09cyMMRhaXcUTV
         r0RqFVSzZETpcOK+1IXeP5TqtYbIXnhLtLWk4Y/ENr1m34kzvYwlD1oQ6UJ6sMJHi9DD
         AIjPr2WInYi1cgSspfxGNF0PFznSDSvi97PsCseA5rn917L/aXBmgMgIKt1IrFTfOGyu
         MAOg==
X-Gm-Message-State: APjAAAXLYTQ4Qsu+Hpbrgxak/h+beNjc1Uaomh3FTBiCcR/fPsx3a9HN
        TcKdNAsh0v51AjQpq0MWcOvQlT3WVSUN2Z6cJlHISA==
X-Google-Smtp-Source: APXvYqxsOkNd+mfBG98uFsA7r0+q+sM6MuQE6T9/FQt4kuwwmZcu5yVUsRyxEhkBbMuljLlPUe2OD8dgoD6iYadwyDc=
X-Received: by 2002:a5e:d70b:: with SMTP id v11mr3421263iom.252.1567551645380;
 Tue, 03 Sep 2019 16:00:45 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mtzztgoW91TvG_wTYju10dNJ+=r8Ncx3f3bebstMZiCpA@mail.gmail.com>
In-Reply-To: <CAH2r5mtzztgoW91TvG_wTYju10dNJ+=r8Ncx3f3bebstMZiCpA@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Wed, 4 Sep 2019 09:00:33 +1000
Message-ID: <CAN05THSp4vOHiZ7jqdVfLSbN2HD8nzEkq5aU_NSGVFFM2_4wTg@mail.gmail.com>
Subject: Re: [PATCH] smb3: log warning if CSC policy conflicts with linux
 kernel client cache mount option
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>


On Wed, Sep 4, 2019 at 8:54 AM Steve French <smfrench@gmail.com> wrote:
>
> If the server config (e.g. Samba smb.conf "csc policy = disable)
> for the share indicates that the share should not be cached, log
> a warning message in the Linux kernel client if forced client side
> caching ("cache=ro" or "cache=singleclient") was requested on mount.
>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> ---
>  fs/cifs/connect.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index d9a995588c74..85f8d943a05a 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -3478,6 +3478,14 @@ cifs_get_tcon(struct cifs_ses *ses, struct
> smb_vol *volume_info)
>          tcon->use_resilient = true;
>      }
>
> +    /* If the user really knows what they are doing they can override */
> +    if (tcon->share_flags & SMB2_SHAREFLAG_NO_CACHING) {
> +        if (volume_info->cache_ro)
> +            cifs_dbg(VFS, "cache=ro requested on mount but NO_CACHING
> flag set on share\n");
> +        else if (volume_info->cache_rw)
> +            cifs_dbg(VFS, "cache=singleclient requested on mount but
> NO_CACHING flag set on share\n");
> +    }
> +
>      /*
>       * We can have only one retry value for a connection to a share so for
>       * resources mounted more than once to the same server share the last
>
> --
> Thanks,
>
> Steve
