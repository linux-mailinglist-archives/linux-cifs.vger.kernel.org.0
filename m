Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C032539417
	for <lists+linux-cifs@lfdr.de>; Tue, 31 May 2022 17:37:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243775AbiEaPhY (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 31 May 2022 11:37:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234153AbiEaPhX (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 31 May 2022 11:37:23 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CABE220C8
        for <linux-cifs@vger.kernel.org>; Tue, 31 May 2022 08:37:20 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id q14so3147167vsr.12
        for <linux-cifs@vger.kernel.org>; Tue, 31 May 2022 08:37:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=KIXDr92uQ+6JY68D5wvxSS/bbjUZ6aIKnxSMfoKxw+Q=;
        b=hQ6Ifiol3YcTtduW15IrVX2wlEKbUSUfHcA5CXT84dwF0R2lzxU4CLkZjufy4eq84D
         IAa6p0eEIJdJj1kU4eVG/rE3oGKABpJLr9vVNwkfRx0Mn5y0yQU0cEYdOM/yP49pfcja
         w/InffaC0kBIRAoL30wq3XtL7uizUzaFaC3jKbppF4br0mqwRsZH7I34Y94JjCslEWnX
         v+TILdzNG7/RmgwgOehH6PVJtlR1fGneObf6WeNqtjskYBioAjCQihDOQRwfS/7r9juW
         68YXvnzsSgPQl2D8knUv46T+mimc/b8566wqMXbtCiHRpzR5J/TNGVf8yDd0lqeDtVzx
         QDiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=KIXDr92uQ+6JY68D5wvxSS/bbjUZ6aIKnxSMfoKxw+Q=;
        b=7O4C1OcUB76s/2IBIWGOJclT3zrnkNwo3dFC7pFq+3yFqWZoMi+Dg1Pl0ptXRiO1GJ
         /P6PaiaJm5bI2NSJwtnWAZHrhJfX/xJmId4EJt+GSRXgTbEAbtbh/sej/thiZSwtskgR
         2n8vS4d8CuTHglQAT3w7YZ8gPmDNcMdx5Zs3P4s4JWCTr96eP9gpHy2/TQxh2KGyEHad
         u5ONjssPMQiBxAC5II028zhTZlAF6d6f8h8LEf1FT/N47lmyLqDUk1QpQep85PZQieOt
         lVIPxrWV0Q8yS41LAHyodIlkZBPHOff5xLJgb3OWvYLHJCn8FkT1MPDs2javHgzOmsx3
         /Aqw==
X-Gm-Message-State: AOAM531zE4Z/kKzycroWM/mlraIqRVZ8V2xcVH8ngVQxcfmmvoCU4lUw
        PbiYPhBlIys1bRDBZ/aXSeN/LZ9BI484s8neB1U=
X-Google-Smtp-Source: ABdhPJxDoT/W1fgWwK9HKNaCYhJ4xf8NxDhlhZ7BuDXZ/1Tf1iRKDc3kqETwLlk/hRYjpND+fW5BmesWBlzdDrEJR1U=
X-Received: by 2002:a67:fe57:0:b0:335:ef50:1b94 with SMTP id
 m23-20020a67fe57000000b00335ef501b94mr22866023vsr.6.1654011439231; Tue, 31
 May 2022 08:37:19 -0700 (PDT)
MIME-Version: 1.0
Sender: kalueke51@gmail.com
Received: by 2002:a05:6102:5089:0:0:0:0 with HTTP; Tue, 31 May 2022 08:37:18
 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Tue, 31 May 2022 17:37:18 +0200
X-Google-Sender-Auth: pwobsYnY3DfBPShmCtapaCGcvSw
Message-ID: <CAKCfqfgwBi-XRhEELOaZrxNiMeWKuXtzpep+XGFY8oX_Pu+5ig@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: Yes, score=6.6 required=5.0 tests=ADVANCE_FEE_5_NEW_MONEY,
        BAYES_80,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,
        HK_RANDOM_FROM,LOTS_OF_MONEY,MONEY_FRAUD_8,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e33 listed in]
        [list.dnswl.org]
        *  2.0 BAYES_80 BODY: Bayes spam probability is 80 to 95%
        *      [score: 0.8460]
        *  1.0 HK_RANDOM_FROM From username looks random
        *  0.5 FROM_LOCAL_NOVOWEL From: localpart has series of non-vowel
        *      letters
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [kalueke51[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [kalueke51[at]gmail.com]
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 MONEY_FRAUD_8 Lots of money and very many fraud phrases
        *  3.0 ADVANCE_FEE_5_NEW_MONEY Advance Fee fraud and lots of money
        *  0.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

May the peace of God be with you ,

   This letter might be a surprise to you, But I believe that you will
be honest to fulfill my final wish. I bring peace and love to you. It
is by the grace of god, I had no choice than to do what is lawful and
right in the sight of God for eternal life and in the sight of man for
witness of god=E2=80=99s mercy and glory upon my life. My dear, I sent this
mail praying it will find you in a good condition, since I myself am
in a very critical health condition in which I sleep every night
without knowing if I may be alive to see the next day. I am Mrs.Sophia
Erick, a widow suffering from a long time illness. I have some funds I
inherited from my late husband, the sum of ($11,000,000.00) my Doctor
told me recently that I have serious sickness which is a cancer
problem. What disturbs me most is my stroke sickness. Having known my
condition, I decided to donate this fund to a good person that will
utilize it the way I am going to instruct herein. I need a very honest
and God fearing person who can claim this money and use it for Charity
works, for orphanages and gives justice and help to the poor, needy
and widows says The Lord." Jeremiah 22:15-16.and also build schools
for less privilege that will be named after my late husband if
possible and to promote the word of god and the effort that the house
of god is maintained.

 I do not want a situation where this money will be used in an ungodly
manner. That's why I'm taking this decision. I'm not afraid of death,
so I know where I'm going. I accept this decision because I do not
have any child who will inherit this money after I die. Please I want
your sincere and urgent answer to know if you will be able to execute
this project, and I will give you more information on how the fund
will be transferred to your bank account. May the grace, peace, love
and the truth in the Word of god be with you and all those that you
love and  care for.

I am waiting for your reply.
May God Bless you,
Mrs. Sophia Erick.
