Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA15212CCE1
	for <lists+linux-cifs@lfdr.de>; Mon, 30 Dec 2019 06:29:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727069AbfL3F3U (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 30 Dec 2019 00:29:20 -0500
Received: from mail-il1-f193.google.com ([209.85.166.193]:36782 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbfL3F3T (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 30 Dec 2019 00:29:19 -0500
Received: by mail-il1-f193.google.com with SMTP id b15so27047180iln.3
        for <linux-cifs@vger.kernel.org>; Sun, 29 Dec 2019 21:29:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oaq9J86A5qT7Ev0xA8fI+XgQrZQUEfev6OaFKLCG7Dw=;
        b=SMehIdrSF8BkcyHoop7g/76N+O+AJj4+31Bn0PLKZUCkw2mFTTnVBShq+bgLnQ/9u0
         wvEELyH5m+sQcYhCCKXFRMWk0NQ7qitRLqHcMk6sxP7Ymm9QrbSc2ts5V+ayAVxwA+56
         CpnU1Z4KvqVZjRSNktnuvq3y8YO4rgzCs4qoEXGj8tDWwfqTFGKxONnN+U9EJotHsGKZ
         mr6rYRtvRV8kI5FODrPH1KMSO8KA2iPcLMngz/txFhfMbtI6K3kjDQpJdTia2dLxmYRb
         tXsXXP3Mvw+KGWiDqRbZb1cY+aTTXNWhQ65r6GjW8zAhUpRE7gHUvk9A+G62hvzrZoyU
         xtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oaq9J86A5qT7Ev0xA8fI+XgQrZQUEfev6OaFKLCG7Dw=;
        b=dnP0zZmiHN2tPOHrhewOsn5gExzUrcwG9gBw1L1frmimko/pR0s6P2ysOg2bIWuvPb
         aaRlzplIvlI9LX5buARmJRfyZK9J+UnCNcch/JliJxqPa0hyxXAD7lzSoxqiVWUfD/6H
         GKe/yz9dGNStcypwNpGPugerb8ZJjCFiexSsuOXt7uvcDXhQghgeX3MkkmQ/tQ1cAEo2
         N4SFpG+qmPVKyoEplgVlhrPsvoG/8kJXgZyWIvQyF/cm8VR/QI/OwrfmkNb6HcVijVBC
         E2k98O32wWLwCggaVY3h5BCuKoqh/vh9ULM+NiRDc8qbkyLVHoSKLNL2EQ+vqRBiAJe1
         Iqrg==
X-Gm-Message-State: APjAAAXZehoAOikY0xFwEY8Hz7N1XmwkJqb3O5nYEXe+i+6xWX9COXSr
        er+XOous51LodaJXooo7bV4sICLLIMm2rrjw7Wg=
X-Google-Smtp-Source: APXvYqznxWMOc/zeoeuvpB4zDr6gxOrtbKhiqFQDRhYff1gxXRNYl6M6jFdOGJOqlPZESbiMwJfJRV7An3TD5Cy5fEY=
X-Received: by 2002:a05:6e02:d05:: with SMTP id g5mr37929888ilj.272.1577683759157;
 Sun, 29 Dec 2019 21:29:19 -0800 (PST)
MIME-Version: 1.0
References: <1577244621-117474-1-git-send-email-zhengbin13@huawei.com>
In-Reply-To: <1577244621-117474-1-git-send-email-zhengbin13@huawei.com>
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 29 Dec 2019 23:29:08 -0600
Message-ID: <CAH2r5msEOq877Rudaz1aOeF-sxe2qvy+Rc8nWc-Bq_-qZNqYHQ@mail.gmail.com>
Subject: Re: [PATCH 0/2] fs/cifs: use true,false for bool variable
To:     zhengbin <zhengbin13@huawei.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Merged into cifs-2.6.git for-next

On Tue, Dec 24, 2019 at 9:23 PM zhengbin <zhengbin13@huawei.com> wrote:
>
> zhengbin (2):
>   fs/cifs/smb2ops.c: use true,false for bool variable
>   fs/cifs/cifssmb.c: use true,false for bool variable
>
>  fs/cifs/cifssmb.c | 4 ++--
>  fs/cifs/smb2ops.c | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)
>
> --
> 2.7.4
>


-- 
Thanks,

Steve
