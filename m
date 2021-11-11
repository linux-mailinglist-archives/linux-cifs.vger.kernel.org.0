Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CD92444D9A7
	for <lists+linux-cifs@lfdr.de>; Thu, 11 Nov 2021 16:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbhKKQAA (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 11 Nov 2021 11:00:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234026AbhKKP77 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 11 Nov 2021 10:59:59 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026B9C061767
        for <linux-cifs@vger.kernel.org>; Thu, 11 Nov 2021 07:57:10 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id f7-20020a1c1f07000000b0032ee11917ceso4768852wmf.0
        for <linux-cifs@vger.kernel.org>; Thu, 11 Nov 2021 07:57:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=ePYZWHXANTLAfCGNIrDqR/tKQ8RPUIxsEL1GS7U8994=;
        b=CI5U/ClEkgmaXPjph61/8xm3ZsFA34wsTVrjkMV+pJgFJHX7zNYsLYvVwap+S3hcbr
         AfxRJzHnZJre+l6xzwebJd6mJoY5LXEKSNbPUro4dY05zIkSmLQDzUUcuQhzsEFnHdIC
         nvoV511dZjV4zU0ixkJPX7RdC8YdTo39sS32QIQmxmi65qooFe7K+NvoSdS2GgvBuOjD
         q7wypv7ZrZUooQsUYaZc8r0uwYVF4OPdQgNxAie5UT3bHIRS9OOwoUpgNd+RP8gYuRO5
         OwAlfF28Wua+117x3fm8grsQhiOP/BB/IJis5gkd0waS+9Ie/w9X3pCTAFabC0IXHUyq
         hJPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=ePYZWHXANTLAfCGNIrDqR/tKQ8RPUIxsEL1GS7U8994=;
        b=z/pIH1mDopQNbWfMEXDvreEVNckdT0kQ6W4Bzz6wawKyzXs01B+aLz+7I7tSxl0Vos
         ts2hjlgRDFl4jz7pdK9GK2gplrSPiONOO64NmINlsdoT/Mm5oR4Lze42ag5Y7mUtk4nS
         fQ/oAiDpRcUlNj1oPq7uBclxuVCG/eOa3yLNQlhRKdJLO1yubdCquFTg9nMwIlceLYHV
         t3+W84QPozws1xAjpPrnkDW8vF/qyrdGKGjmXBrhd5z8OvV0Ge+wcbIfwhK21IuL88oN
         MvlN25ffM0Wgit7jmNKOwJIjK/PhM8UqKfvqcyCqjrq7jE8XiRvKz3nr1xrJR7y3hGF2
         BpuQ==
X-Gm-Message-State: AOAM530ge4Onp/Jkyt1Cyg5Vz1g88cH3o0YFjHh9PO9iDGKDkedsba54
        ZGFe+5og7GnDpLPrBysqnwmIYL0EYQ34as0dBN8=
X-Google-Smtp-Source: ABdhPJyS5fbJQwxu9potWuTth7je0Hcmp4zS6OmDf4tEaA98C+VByls44MfAUfQCa+IcC55zcWbCzLdWg9NutIIJYpg=
X-Received: by 2002:a05:600c:253:: with SMTP id 19mr26469668wmj.179.1636646228257;
 Thu, 11 Nov 2021 07:57:08 -0800 (PST)
MIME-Version: 1.0
Sender: rev.benaldjoseph@gmail.com
Received: by 2002:adf:ebc4:0:0:0:0:0 with HTTP; Thu, 11 Nov 2021 07:57:07
 -0800 (PST)
From:   Anderson Thereza <anderson.thereza24@gmail.com>
Date:   Thu, 11 Nov 2021 07:57:07 -0800
X-Google-Sender-Auth: xLpfmkep_w13PiCmtLGNFATwt60
Message-ID: <CALZVc+Tpzk-GqQy6W5-ywkQJ5JtHuW-Yh3W0+4YoVXDj+jL99Q@mail.gmail.com>
Subject: Re: Greetings My Dear,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Greetings,

I sent this mail praying it will find you in a good condition, since I
myself am in a very critical health condition in which I sleep every
night without knowing if I may be alive to see the next day. I am
mrs.theresa anderson, a widow suffering from a long time illness. I
have some funds I inherited from my late husband, the sum of
($11,000,000.00, Eleven Million Dollars) my Doctor told me recently
that I have serious sickness which is a cancer problem. What disturbs
me most is my stroke sickness. Having known my condition, I decided to
donate this fund to a good person that will utilize it the way I am
going to instruct herein. I need a very honest God.

fearing a person who can claim this money and use it for Charity
works, for orphanages, widows and also build schools for less
privileges that will be named after my late husband if possible and to
promote the word of God and the effort that the house of God is
maintained. I do not want a situation where this money will be used in
an ungodly manner. That's why I' making this decision. I'm not afraid
of death so I know where I'm going. I accept this decision because I
do not have any child who will inherit this money after I die. Please
I want your sincere and urgent answer to know if you will be able to
execute this project, and I will give you more information on how the
fund will be transferred to your bank account. I am waiting for your
reply.

May God Bless you,
mrs.theresa anderson.
