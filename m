Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 27D9E3802FB
	for <lists+linux-cifs@lfdr.de>; Fri, 14 May 2021 06:27:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232200AbhENE26 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 14 May 2021 00:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232063AbhENE25 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 14 May 2021 00:28:57 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E4C7C061574
        for <linux-cifs@vger.kernel.org>; Thu, 13 May 2021 21:27:46 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id g4so11957088lfv.6
        for <linux-cifs@vger.kernel.org>; Thu, 13 May 2021 21:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=LXjBY2wuf8kJ94IxTWm6+cHYw65vuEULS3hitg9Cq2s=;
        b=qbYqQptcaBNavKfa52OlveHFg10CpKTa8y9w328QGkBjvMG7gbPcr1e2INmOxbFRGf
         Wwu6/ki5pInkk/+26N7TKdEdnVECVHv+teBycbZF7N31+HedanAraBcUbVIuOZTzvXzF
         pKnFpcsytHH4kMC6v0XUxNC96pFWkuf60IUUU5zFUNuL22RhuC5Svafq21b+ZfXlVHPd
         UWdvh64kzl7hCzf7jK+PiiC3P0nXzA9ICU/Wi62Cr1iuKYN1t4ZqX+haWvaYS90l3mbs
         uTy8nh7KQ9kZGjMUIjNzSe//uikQJIqFMmqEapOlqI4S4taq1SO+Fj4FO7GWK0BlAAZy
         0a9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=LXjBY2wuf8kJ94IxTWm6+cHYw65vuEULS3hitg9Cq2s=;
        b=uYjlWpbbYjcd7/vcm8B6toGguX6wyMl8FaUkiOxFp4Ia/qcaahdtEP/T5/OacfNRnR
         sNFAWLC0v7yGdGtMs7TQEI0BHqKsrLMeoZrVnTySwmBndUrL7q39LUUaMp3mdpqhcBHx
         xCWYlud5Qeggb/Vxk/PZTbCfaP6eQjdpNzK0SySREqbNB3Oj6tCuuUTBzb0h6FduoIOf
         1n6gG83GW8+uu+cToWiGl3Iyr7LmrsQg5b5vygqdjxYetHsnYFLnJi1f/+08JJHtLjn6
         2Jmo09xE1SfCT3Fe4pqtVJuJ3moFleu0jVet5rxsx2PGaWLqcNc9eYChPFPemSPoZXOd
         3WMw==
X-Gm-Message-State: AOAM533aFyROwQSN+n1sHVpMXzc+PJJ+m4XOSnpiCNqtIsiKOSizElCq
        Ogn027cf2QNwySPF2Y7fujFpkEpSWwGn5ji6ryt+RxGj+4ZKQw==
X-Google-Smtp-Source: ABdhPJw422gachSXMP1OkQ5SZ/4+WayFrqay+lpxosebcJGvTypFYnBNGNLzwATeAwALfcZ7ziBaOSHvlSlOx7rQzhk=
X-Received: by 2002:a19:5f11:: with SMTP id t17mr31346507lfb.282.1620966464632;
 Thu, 13 May 2021 21:27:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mtxZx3RG4Z_b6-9bsaLBMAHObGas-yPe3rttj1tXcFtnA@mail.gmail.com>
 <CAH2r5mtkjSwU4mqbkUJomdB3o0Uo84agSVS_Vn+Yz7t1uLYoCg@mail.gmail.com>
In-Reply-To: <CAH2r5mtkjSwU4mqbkUJomdB3o0Uo84agSVS_Vn+Yz7t1uLYoCg@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 13 May 2021 23:27:33 -0500
Message-ID: <CAH2r5mtfVHbbucj6gtWQcE4zHXX+zdYf2XzqQOW2T7-duDr04A@mail.gmail.com>
Subject: Re: Additional xfstests
To:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

And just added six more:

xfstests 461, 590 and 615 (and 630 and 632 could also be run) more
generally across multiple test groups

and tests 458, 518, 525 for target server of Samba running on btrfs

On Thu, May 13, 2021 at 10:47 PM Steve French <smfrench@gmail.com> wrote:
>
> 26 more tests added (33 more if you include the ones added last week)
>
> http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/641
>
> On Thu, May 13, 2021 at 5:49 PM Steve French <smfrench@gmail.com> wrote:
> >
> > Did some experiments running more xfstests today, and we continue to
> > be improving - can now add significantly more (e.g. to Samba server
> > running on btrfs), 25+ tests that are now working in my quick tests
> > this afternoon.  That is in addition to the ones we have added over
> > the past few weeks.
> >
> > 051, 110, 111, 115, 116, 118, 119, 121, 139, 144, 163, 164, 165, 170,
> > 183, 185, 188, 189, 190, 191, 194, 195, 196, 197, 201, 245 ... and
> > more
> >
> >
> >
> > --
> > Thanks,
> >
> > Steve
>
>
>
> --
> Thanks,
>
> Steve



-- 
Thanks,

Steve
