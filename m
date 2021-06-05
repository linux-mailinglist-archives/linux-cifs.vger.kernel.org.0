Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7697939CAFC
	for <lists+linux-cifs@lfdr.de>; Sat,  5 Jun 2021 22:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhFEUrb (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 5 Jun 2021 16:47:31 -0400
Received: from mail-lj1-f177.google.com ([209.85.208.177]:36684 "EHLO
        mail-lj1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbhFEUrb (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 5 Jun 2021 16:47:31 -0400
Received: by mail-lj1-f177.google.com with SMTP id 131so16332389ljj.3;
        Sat, 05 Jun 2021 13:45:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yn/TbVn6f1UMlCFPmbCfjZI3NeczMRtP3SfRjDr4sck=;
        b=TiUc93tB+fvcHVCD3q43RWiQLi79CkumIXL99mU6fkQBIa1cTI5yEK6TuHvVb+YFds
         0rKD1gr8BCy2uVUVkopcbK6Nu3CXSaHt6RQCMY7B0+71h4D++r6ytoyIi6ZwQrY4hvo4
         SxtGq8KLRyyHfZJYZsXnkcSpO2NaBF1cy0DOlMN1WE/Z0BIqUVWHPPCJvMzttF2Z76qm
         S1sGi71wSChk4jh4cQ5N4TqIZ6+XfeW568hr9Yuf7THy72tpysgQN0TvD9boQDdL46pc
         mohZO6ZB/7MDHNXJODhbTPOZ3mYIi44DnJd/O1lAimCFxm/FtuStxE0X7I/UZeW1UXTI
         4OEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yn/TbVn6f1UMlCFPmbCfjZI3NeczMRtP3SfRjDr4sck=;
        b=WeuYg9h0FPepRugMrPRT+5x4EljdECI5DGVk9GWZhcDlsbznAkgetQIItGsQc1aTTP
         hRKSKLThKbJlcrcUjZ/EPeF3+MpeiO8rNnosSCALJns9JlW/BS6H9zGsCkZY4b/BGwYv
         lYsZaGQJoX/GtmJGlPS/uGFlWFOc6ekzW2hAypqGnLstwnD2xTiUKtoX97BeXYbr5HZJ
         5BCfcpiH3HCoMzex1a01uIgTxzHxjzTUpfCL7ettDRhGo9RXD9KncSJw6p5S4NZ32VvE
         xq+eYgeTl+bPKR6FDpCyCOdJNJQVqOxsSJa9tbqwnQQranlovy7oNAQMRr2gdCh399m1
         l82A==
X-Gm-Message-State: AOAM532tVF5pyYVDVHck9UvYKQDclR4nHPW2QoVP7ZsiNGy+Fali+aY/
        t3H4jYQUyyWa+w/7uff/7P/NE9zKu9qDrTeVVPP1WIHkF04=
X-Google-Smtp-Source: ABdhPJwaogxOuxZI2Wd3F6lbz/Fxre7xfivwqwT2cRs6sNCy+XM0a/9IVdPmgNPcZArbbQqrIKnCuFSwVYhYNkQmZIc=
X-Received: by 2002:a2e:2e05:: with SMTP id u5mr8583721lju.256.1622925868100;
 Sat, 05 Jun 2021 13:44:28 -0700 (PDT)
MIME-Version: 1.0
References: <20210529114848.19608-1-yuehaibing@huawei.com> <87eednot8g.fsf@cjr.nz>
In-Reply-To: <87eednot8g.fsf@cjr.nz>
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 5 Jun 2021 15:44:17 -0500
Message-ID: <CAH2r5mtGz1vHrjh4nXg8E2NWsyq2V3BcO3XSnCWtLD1DZqurZQ@mail.gmail.com>
Subject: Re: [PATCH -next] cifs: Remove unused inline function is_sysvol_or_netlogon()
To:     Paulo Alcantara <pc@cjr.nz>
Cc:     YueHaibing <yuehaibing@huawei.com>,
        Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

merged into cifs-2.6.git for-next

On Mon, May 31, 2021 at 9:50 AM Paulo Alcantara <pc@cjr.nz> wrote:
>
> YueHaibing <yuehaibing@huawei.com> writes:
>
> > is_sysvol_or_netlogon() is never used, so can remove it.
> >
> > Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> > ---
> >  fs/cifs/dfs_cache.c | 11 -----------
> >  1 file changed, 11 deletions(-)
>
> Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>



-- 
Thanks,

Steve
