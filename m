Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A89ED2D9842
	for <lists+linux-cifs@lfdr.de>; Mon, 14 Dec 2020 13:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2439455AbgLNMrq (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 14 Dec 2020 07:47:46 -0500
Received: from mail.kernel.org ([198.145.29.99]:52128 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731521AbgLNMrk (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 14 Dec 2020 07:47:40 -0500
X-Gm-Message-State: AOAM532pcbx/pj2t0tLbZcMn1dEyFi7lx6aCcskssXPrK0bV5UnxsfH7
        sFMLl0RXgIjWycrlmmemCl0HPPUsuIYEIOP+/Cc=
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1607950019;
        bh=FIRCdo6fliwJhtQELuc9Xh/lB9unf+wWq5yG9rp/twM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=dYOu5qWBC7617ikjmEND5Rh5z54FK423m6Mm6efxKUZ6Bt2YqUGBKLXvqU327iRZL
         x0hsJ6oOBsaZHZ2+rD/BJW+KsWBtebUvWwmoFMg9H5i6s1da+xG9kMmOR2UcQSsocP
         bZLGi/VuSap9Qp1c19djZTxxJNS+dnoarVab9tsrCPOsiDNiXj2dn2Vu1wzTUEKg+a
         TW4sE8DMOgImfoXNFLlzouEBP1R0a/2iP4RN3Yx7ogqNReLac8RkyBiSQINWJsk4Pv
         ZCqAmfPMg61PELeZ2kjLvAuzbndaW1jGV76Sf441sBIH6O/lsh/VOXuJtDgnRUhp7I
         e9D8BFCmYekGA==
X-Google-Smtp-Source: ABdhPJwF+gma3KzjYrziS8er2Xuuzq3yFqmb8c+MAUMESWoPI3Nt0KY4LrpKs7FLSfn4XRte62pfbD7ynN26jtBTr2U=
X-Received: by 2002:a4a:c293:: with SMTP id b19mr19019096ooq.74.1607950018806;
 Mon, 14 Dec 2020 04:46:58 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAH2r5muRCUzvKOv1xWRZL4t-7Pifz-nsL_Sn4qmbX0o127tnGA@mail.gmail.com>
References: <CAH2r5muRCUzvKOv1xWRZL4t-7Pifz-nsL_Sn4qmbX0o127tnGA@mail.gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Mon, 14 Dec 2020 21:46:58 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-qTqLF3M1S0xbpu-C0w1E=vS4HRFa_ou0xXnGJaFKuWg@mail.gmail.com>
Message-ID: <CAKYAXd-qTqLF3M1S0xbpu-C0w1E=vS4HRFa_ou0xXnGJaFKuWg@mail.gmail.com>
Subject: Re: updated ksmbd (cifsd)
To:     Steve French <smfrench@gmail.com>
Cc:     Namjae Jeon <namjae.jeon@samsung.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

2020-12-14 10:20 GMT+09:00, Steve French via samba-technical
<samba-technical@lists.samba.org>:
> I just rebased https://github.com/smfrench/smb3-kernel/tree/cifsd-for-next
> ontop of 5.10 kernel. Let me know if you see any problems.   xfstest
> results (and recent improvements) running Linux cifs.ko->ksmbd look
> very promising.
With the review of Ronnie, I fixed one problem in previous patch. I have sent
a pull request for this patch. And I am running the number of 118 tests
of xfstests on rebased smb3-kernel(+ the patch in pull request) again.
I will share the result as soon as it is finished.
Thanks!
>
>
>
> --
> Thanks,
>
> Steve
>
>
