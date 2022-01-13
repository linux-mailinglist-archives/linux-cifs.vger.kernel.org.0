Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2028B48E04B
	for <lists+linux-cifs@lfdr.de>; Thu, 13 Jan 2022 23:34:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237734AbiAMWeR (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 13 Jan 2022 17:34:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbiAMWeQ (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 13 Jan 2022 17:34:16 -0500
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51FBEC06173E
        for <linux-cifs@vger.kernel.org>; Thu, 13 Jan 2022 14:34:16 -0800 (PST)
Received: by mail-pj1-x1042.google.com with SMTP id c14-20020a17090a674e00b001b31e16749cso20203467pjm.4
        for <linux-cifs@vger.kernel.org>; Thu, 13 Jan 2022 14:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=YbEI3Q/NEjCtDTVCV1jkA7nYNYBH/Wfa2wk3IkVyJko=;
        b=PmI1q6hfnxTpvxktOArZiwOqnnyO33V8k9lk4Ab5uv/tXUMKhuD8j8DnVmdRviHBgQ
         Foc2Z7xpr0+dGrc0Uv+No6bmc1bXJ6iySDBpW0NAHvbBtPqnrOlUGfQo1kpsPy2M3ZFW
         KgAgk6tld3+pr0QWKcw/GEP/Taug5jXuIrWArSUWLjzq7fzHIjO6suVDXL4olTuQcVDc
         /fFYzdXXoLCmrN0z9qO9LILGwX6wVS411acRlSyS1xaxNoHeVcILxkxcBAlhNcOnYDeE
         uggA/kiFfwQN9TLWOZorzi/ZxPmGxx89HbiOJDPUON+39VTtdp/97BLxkI8e6lgMGfLb
         rtMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=YbEI3Q/NEjCtDTVCV1jkA7nYNYBH/Wfa2wk3IkVyJko=;
        b=HPCoezkacXgLAU3aYdnhrg/RwP8RjLVfhQavORS5xBZi+HtyjjOIxcttl6qQa4X99s
         rKcjme8s+2PQjwh4iHfwy5FEw1cCL9+u1Z7RPPaUcG1DChXkRhyrPfQsxFmJ77iA2lrF
         13Lp7FBbC3fUXEBzCOBQp5kPgkCnfFH7VGfXuoaaqYGPjFx1QVLaRCCqjwa7P/fNALGs
         z4Dquu4EbUv50pWDN/OK7c+jPUXz0yN5acmyYcZgDzExc1q+FprRwV3I3SILB4+54Pl7
         nhz+4Zp+EwCDTzRoT644Dd9nRkFgDQVVEn0XWFhZD/02biuTkknCtebpzrrTsXqGk+UD
         y6LQ==
X-Gm-Message-State: AOAM531ozRSRKRGtrQYpgwGtbm6tuaZ6lsgxr7zgWryLoQP5iExY8GNM
        reAxka61UibwVK+G6N4CHTc01r3FiVNRUoubZ+s=
X-Google-Smtp-Source: ABdhPJxPH1SPs9VBzcbfXJ3d2utoM5GhhRKP5HiIE3oBL1f64+1h4Kzxk+wuxy1TV7gelIxtN/6shqF+sQXPWsvN6EY=
X-Received: by 2002:a17:902:c443:b0:14a:30f2:95e8 with SMTP id
 m3-20020a170902c44300b0014a30f295e8mr6460931plm.43.1642113255770; Thu, 13 Jan
 2022 14:34:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6a10:f38c:0:0:0:0 with HTTP; Thu, 13 Jan 2022 14:34:15
 -0800 (PST)
Reply-To: mchristophdaniel@gmail.com
From:   Marcus Galois <marcus.galois@gmail.com>
Date:   Thu, 13 Jan 2022 23:34:15 +0100
Message-ID: <CANqBaXVDDVUk7AD8fcNLQEsEm=xAQJqUVJvKAZ0mRa9+uyUdSw@mail.gmail.com>
Subject: Good News Finally.
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hello friend.

You might find it so difficult to remember me, though it is indeed a
very long time, I am much delighted to contact you again after a long
period of time, I remember you despite circumstances that made things
not worked out as we projected then. I want to inform you that the
transaction we're doing together then finally worked out and I decided
to contact you and to let you know because of your tremendous effort
to make things work out then.

Meanwhile I must inform you that I'm presently in Caribbean Island for
numerous business negotiation with some partners. with my sincere
heart i have decided to compensate you with USD$900,000 for your
dedication then on our transaction, you tried so much that period and
I appreciated your effort. I wrote a cheque/check on your name, as
soon as you receive it, you let me know.

Contact my secretary now on his email: mchristophdaniel@gmail.com
Name: Mr. Christoph Daniel

You are to forward to him your Name........ Address.......,Phone
number......for shipment/dispatch of the cheque/Check to you

Regards,
Mr. Marcus Galois
