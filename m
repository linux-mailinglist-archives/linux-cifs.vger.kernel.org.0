Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2654054DC70
	for <lists+linux-cifs@lfdr.de>; Thu, 16 Jun 2022 10:05:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358959AbiFPIF1 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 16 Jun 2022 04:05:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359610AbiFPIF1 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 16 Jun 2022 04:05:27 -0400
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59D1E5D64D
        for <linux-cifs@vger.kernel.org>; Thu, 16 Jun 2022 01:05:26 -0700 (PDT)
Received: by mail-vs1-xe30.google.com with SMTP id d39so528997vsv.7
        for <linux-cifs@vger.kernel.org>; Thu, 16 Jun 2022 01:05:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kuEgcMgVDUHYFfJyXF9gOzSC47A94xAWGdocmAZibCA=;
        b=Gh0odiyxs+Hx1TIH7bnm6JWpbwZtm5JmXCUFNEXZC8AsSdEfyvsUoW7+lgYcUVPhYS
         sl6gm02Tllh4iXw5p5p6n6/GakPgbG5psPEG0xLfJrTxyqtwc+gIqQqro3RWnCCOIu1H
         Zs6rje4nUrZSaEmSeiQErUlst0bg3cVQe1uoXIgvXieTbG1XR9gNLRlFcQpqPi/gC9pQ
         G0SVKSj5CCBbKPXu+1SAhRixvH6WrFNcr2QFAW+RGWtvk1sYsKHgqe2K3iBZ0BzRjfIA
         1miEfnnyfidwN3zTgC/k5t5ysXbGmHm9WK15DXEzug9yAGKqKtiAWv1KBt4ByFB+Pqkn
         LXvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=kuEgcMgVDUHYFfJyXF9gOzSC47A94xAWGdocmAZibCA=;
        b=UAggCjsZfRvkKUqv21y8Vpot12Mxta73UySmmeasFsc3CPxv6mO1cL4Zv5yGFz6IJ7
         ASFrYSOU7Kd+XcIQQQmJ3A2S/pM/4N4lOAkzNG0wmvcT44Nskw54F+1HaE2U8gaWJAhj
         xIybvHo196E1/BYBqCUdRc47vox/MvVAdNADxq16hoetSbudmcLgsABvk2KLs1kgpyL9
         5gXiXv93jDIeEkJ468peAM8AE2lm+ki7wG0a6XiBQN4cQhAKT622wXkHDPGvWMm0xow3
         bHHzuIiq+DqDVT6OtAbgqcFWlLLDN0utT0WqDSEOfHh/QmWAmoiSvQxtjD33uBnJbcvI
         nFnA==
X-Gm-Message-State: AJIora86wxaRD+AJscE2en7Px/OAQL17mMr1LB/29GOYQj2+n8HA1Kwb
        ra5Em9daYGZJYXGZG4lMlSSNd77f94cqt4pTnbQ=
X-Google-Smtp-Source: AGRyM1sELq2QonT9OLUtV9GNvBglf2gEuB5MCp2yMoaq53XHlXHOfUlb2OF7r+4/d+430118gODKXzoXk5WKN4m5cRk=
X-Received: by 2002:a05:6102:7c8:b0:349:e0ea:16d0 with SMTP id
 y8-20020a05610207c800b00349e0ea16d0mr1429647vsg.36.1655366725424; Thu, 16 Jun
 2022 01:05:25 -0700 (PDT)
MIME-Version: 1.0
Sender: stgmonicabrown01@gmail.com
Received: by 2002:a05:6102:374f:0:0:0:0 with HTTP; Thu, 16 Jun 2022 01:05:25
 -0700 (PDT)
From:   Frances Patrick <francespatrick49@gmail.com>
Date:   Thu, 16 Jun 2022 01:05:25 -0700
X-Google-Sender-Auth: T0XPxyoI6pC4WFGMTNfSO81nQUE
Message-ID: <CAOZrF2K40pOuaA+c53+FBn1seZwFZ0mS_ZdmcOw1geMUQ5fSXw@mail.gmail.com>
Subject: Donation to you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--=20
Hello, Dearest Friend,

Two Million Euros has been donated to you by Frances and Patrick
Connolly, we are from County Armagh in Northern Ireland, We won the
New Year's Day EuroMillions draw of  =C2=A3115 million Euros Lottery
jackpot which was drawn on New Year=E2=80=99s Day. Email for more details:
francespatrick49@gmail.com Looking forward to hearing from you soon,
