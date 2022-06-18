Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C105A55030F
	for <lists+linux-cifs@lfdr.de>; Sat, 18 Jun 2022 07:42:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229948AbiFRFmn (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 18 Jun 2022 01:42:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiFRFmm (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 18 Jun 2022 01:42:42 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08435DFB
        for <linux-cifs@vger.kernel.org>; Fri, 17 Jun 2022 22:42:41 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id x5so8643763edi.2
        for <linux-cifs@vger.kernel.org>; Fri, 17 Jun 2022 22:42:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=kuEgcMgVDUHYFfJyXF9gOzSC47A94xAWGdocmAZibCA=;
        b=hrlKCI4xqbP2TwLusgW+vW+uIuEhbxu11STeYZfGRjrkqf5+ojtCMS2aL1+foOI2l/
         wysNa9/1PHsu2uJfdJiM8L4tmcbWBFvvQl1TgKma9VTb1vvfoCG+FJ2rahhqf9/SU9tO
         UvuShMhaQWAeqOQRoby2WduOK3x7tkdZchyLNvucb6MWedT5Dz1UvLn3+1jytIhz7en2
         NMRbDqQiulj1s2v/dMoHWwPPobnT0q4pK1/AGkRLwXNBe88a3JAdKuaOXiXbk1RIWYJN
         GYEBhloIX3ikKIx/FIaV9tekV3gHXzUgWq+DH7J9j/6f/jTk18qwqJWZ0K0GZT/UjyPV
         8QCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to:content-transfer-encoding;
        bh=kuEgcMgVDUHYFfJyXF9gOzSC47A94xAWGdocmAZibCA=;
        b=CYi+r4Sq25e+g/iLfTG3NBlIC1r5FcTxSnCWgc3502qLhMpIt6X0TAVKXW37asP4s3
         yDCCtpodsq14Zoh2gZDcrqbRwkSoGX04VCPabffcKL4GmNFldLmjXlsn1ItsL576JlKy
         lYbYvb6usexLZoIQHu0DxrmkCuI/FjcyTqgx+vKnRlUBWFzvYIkF6GQ/AxasVrRKssTe
         vgGyebzH6aL0++gyBStYN5g36USV8N46RXQQ+hVVnW2IPD6GmCDG0pIjlkbvCW+Rj/nD
         fQ0wofT8b34FbnXhAZfs1I0ukRUsUAzorkTha2YuLRVJWTVIz99XB6QUd5FfIIJTwFPc
         0q4w==
X-Gm-Message-State: AJIora96xn7UVMKRn1dhIBOGMzaJmD1OtgiGPs90bnIOoG/XfTmXE/d5
        JCZuzQDkXOuS5bedF0u/7ZiAcgDI4+/M1a9wXDU=
X-Google-Smtp-Source: AGRyM1tj2En52NoHwJDwOGg3GGlVCgPNdGZpfXSVUgocNLwdYathvp51oKw+NIrEmwDhfiQmBaH24rMF/UWR6il2Vvc=
X-Received: by 2002:a05:6402:542:b0:42d:c7d6:4121 with SMTP id
 i2-20020a056402054200b0042dc7d64121mr16400468edx.302.1655530959529; Fri, 17
 Jun 2022 22:42:39 -0700 (PDT)
MIME-Version: 1.0
Sender: elizabeth.hoisington1@gmail.com
Received: by 2002:a05:6400:4210:0:0:0:0 with HTTP; Fri, 17 Jun 2022 22:42:39
 -0700 (PDT)
From:   Frances Patrick <francespatrick101@gmail.com>
Date:   Fri, 17 Jun 2022 22:42:39 -0700
X-Google-Sender-Auth: 9WuzNPnZARBm8IxcIQU9l5vwTqI
Message-ID: <CANhm-9sePJiyA-prGf=suE-3N4BNGx5PbnKOmaVQ1zmzOsvrCw@mail.gmail.com>
Subject: Donation to you
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=2.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLY,LOTS_OF_MONEY,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: **
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
