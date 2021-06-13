Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9749D3A5B10
	for <lists+linux-cifs@lfdr.de>; Mon, 14 Jun 2021 01:34:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbhFMXgj (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 13 Jun 2021 19:36:39 -0400
Received: from mail-lj1-f181.google.com ([209.85.208.181]:34467 "EHLO
        mail-lj1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232181AbhFMXgj (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 13 Jun 2021 19:36:39 -0400
Received: by mail-lj1-f181.google.com with SMTP id bn21so17617247ljb.1;
        Sun, 13 Jun 2021 16:34:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vV90fcW15TwLBPqHX4M775nsbVmDSBXQLEB4HxZLGiU=;
        b=seRI9gnaOlXqsebUbY+0EN2h31nRN9n29+w6E/Yx07jhyfc5lmimOLjlpBQ2ZmWXOt
         QZZTYfQVaqTB6KlTdUGhCEFyTlFAnEZk1M6iIxWovvkZgJitCEWKbpfz+msd5OjRqAEu
         458+/fspmIX1Dn+UukB9FpSxC0XvVtmzaaf1lg+jK0OgwaKZ2q8F6LP7SZRuR2yBVtEc
         brkyT+zIPf0NauAK9rXQhU57B3zcj7sIGrVc0j14pV7NeD/pxu7SWq6Ox/Ac83oLvTjZ
         zUc4HTEQMmwTmEpvEJ3StL5Hev64Lo/ryfTlpb/yXAjn6y6cjIkkPZ0Anm3wn7++KvF1
         7LJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vV90fcW15TwLBPqHX4M775nsbVmDSBXQLEB4HxZLGiU=;
        b=SCZm+Q3zVw+0mU/d4DuOoh1D+iZFv2B1Wa8zAwSFndL2TVomcu6j4Epli024I0LjjW
         pB+dyJtpb5lJQdtfJfN6Vyc5fPqjYGgATElCx0f0lRxCwHrTTxkEQotgctZbUpFZlypC
         TzZ2K3/i8uspbtKf2sNe6p6+tGU4F8KVpmUKswg1z7GKCLuVHq2JrP0iSMA/tksYOAx0
         kJ/8hk23Y3XfcBAZlwdnxghQvR7MMHSQpMbFPFvJ682J2HtuoM58cicmElflck/ucMwd
         X/U/5OHpFbr2uUkfrERtJO9Y/yifIjWAfs8yqCGsgNQriAhsZqW11jSbODuKjrk8/dBO
         +G6Q==
X-Gm-Message-State: AOAM5323/YJGS747RJYnI/0gaLSY+iCtV70QAJfN1zaR0FIubz8pioI1
        R8NdwX1o/yd7OxMy5SRbRgDI8XCN6b7zt5yIiTmBsxzEMYM=
X-Google-Smtp-Source: ABdhPJwF5rfK6nFEkoOSqYEGVSSNwf7lZ471cE2ZhMxDz1+qpvKgXjMZibrLWN34Tem81MF0KE0MUFNh7nfE9lFIwpY=
X-Received: by 2002:a2e:a7ca:: with SMTP id x10mr11349512ljp.218.1623627201751;
 Sun, 13 Jun 2021 16:33:21 -0700 (PDT)
MIME-Version: 1.0
References: <20210613140123.74900-1-colin.king@canonical.com>
In-Reply-To: <20210613140123.74900-1-colin.king@canonical.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 13 Jun 2021 18:33:10 -0500
Message-ID: <CAH2r5msKOBuZzvW83OyN4o5S34U=pBcgLcXPFPywL8c3wV_ixQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: remove redundant initialization of variable rc
To:     Colin King <colin.king@canonical.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        kernel-janitors <kernel-janitors@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

merged into cifs-2.6.git for-next

On Sun, Jun 13, 2021 at 9:02 AM Colin King <colin.king@canonical.com> wrote:
>
> From: Colin Ian King <colin.king@canonical.com>
>
> The variable rc is being initialized with a value that is never read, the
> assignment is redundant and can be removed.
>
> Addresses-Coverity: ("Unused value")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  fs/cifs/cifssmb.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> index 037c44bf48f1..277cb1044cbe 100644
> --- a/fs/cifs/cifssmb.c
> +++ b/fs/cifs/cifssmb.c
> @@ -1238,7 +1238,7 @@ SMBLegacyOpen(const unsigned int xid, struct cifs_tcon *tcon,
>             int *pOplock, FILE_ALL_INFO *pfile_info,
>             const struct nls_table *nls_codepage, int remap)
>  {
> -       int rc = -EACCES;
> +       int rc;
>         OPENX_REQ *pSMB = NULL;
>         OPENX_RSP *pSMBr = NULL;
>         int bytes_returned;
> --
> 2.31.1
>


-- 
Thanks,

Steve
