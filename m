Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6190853FACF
	for <lists+linux-cifs@lfdr.de>; Tue,  7 Jun 2022 12:05:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234841AbiFGKFh (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 7 Jun 2022 06:05:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbiFGKFe (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 7 Jun 2022 06:05:34 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DFB6EACD7
        for <linux-cifs@vger.kernel.org>; Tue,  7 Jun 2022 03:05:34 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id o6so9340613plg.2
        for <linux-cifs@vger.kernel.org>; Tue, 07 Jun 2022 03:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=jpD8MQ1T77kLpmSEyXcvEuYhw/qnF6vPNJSkAcSBB4A=;
        b=fFmQWCmSsXUJJ/PR5TWvShMYh4iK/eHK12UKlbqicW5vQeqpkqrz7oJz3yZEfsNOnY
         euwnvJB693d/BjdDxEHPoL71O2dp3eAKWUmtTOHK7JMe80qzqTE2K4ylfH+Kek0nmNWL
         9/feqWF1NLGms2hx5u1R9KYWZIfrPuONkJE52blMy6p5Xx3gJVyHKGWqDsC5g6QgFRtx
         im7rCtvqMTKjjlEBMa4lU+hxgKRdBYPejbV1/9A5gbzh0QQ6TyMOwooMJpGD+EGETJIO
         8MsGmy+0w9bvfLAKHEVecggt+CCGrjnJQQwmdESTCliKHzhaWawFtRW5P9Sddg0TPIkn
         Rojg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=jpD8MQ1T77kLpmSEyXcvEuYhw/qnF6vPNJSkAcSBB4A=;
        b=xxg0JTC+MNYeZ7vD5ZaYaO1rIVVU1F5Q9DPH0YOYJxAi3zRt9086DkEyK4axBZCRhI
         1toOQkTsFAgh6wxzlJyTxOikkv2JjLpbWuGBG2O/IOrM+jSh/hRFS4B1ZW3SPEhkQ8Hn
         i8WjXXbO0boo8Enk9s2d0xPeaBy0Cx4lC2Mjy0f7vkR4aYSCVaW/bPI9q9PyjAFUBG1K
         nic/kNAFNPl4Bo7XyIprL+0JD5fRVpduxsjvrRkIoJbwavtbA5qpFCpGrE8+H8CH7B4w
         wOE/PYTHRcTsNEo2VU841TD5+MzkY3n4yY+QeCTnXpInqKymittcEWcAw+bF6qWA31gP
         HG7g==
X-Gm-Message-State: AOAM5315F8uvPKO+UYHItE+MbHuqMOcSzkuaDRmRERxY9BSJ1Al+Zt19
        opOFOr6aa0PdYzq0VQjhH4YYT0P52GzlzA+JW4L9mc9XSOg=
X-Google-Smtp-Source: ABdhPJxm5yQIveI4UrARxLfvA1Uk9Bi16bYYRmfn6ibagCwCkKIAk4wygx2/90Ul9jfvWCEwSdoFjjActa3T07oGiDA=
X-Received: by 2002:a05:6122:892:b0:357:3b07:70c7 with SMTP id
 18-20020a056122089200b003573b0770c7mr34291873vkf.22.1654596322738; Tue, 07
 Jun 2022 03:05:22 -0700 (PDT)
MIME-Version: 1.0
Sender: stgmonicabrown01@gmail.com
Received: by 2002:a05:6102:374c:0:0:0:0 with HTTP; Tue, 7 Jun 2022 03:05:22
 -0700 (PDT)
From:   "Mrs Yu. Ging Yunnan" <yunnanmrsyuging@gmail.com>
Date:   Tue, 7 Jun 2022 10:05:22 +0000
X-Google-Sender-Auth: RQrTWsdI8NjNzoOZi_a2kTsARI8
Message-ID: <CAOZrF2LcU3N5JapFKsed_ZWULxE4VqZuHTkLYz5SOfJr496u=A@mail.gmail.com>
Subject: hello dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.1 required=5.0 tests=BAYES_60,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HK_SCAM,LOTS_OF_MONEY,MILLION_USD,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

hello
I am Mrs Yu. Ging Yunnan, and i have Covid-19 and the doctor said I
will not survive it because all vaccines has been given to me but to
no avian, am a China woman but I base here in France because am
married here and I have no child for my late husband and now am a
widow. My reason of communicating you is that i have $12.2million USD
which was deposited in BNP Paribas Bank here in France by my late
husband which  am the next of  kin to and I want you to stand as the
beneficiary for the claim now that am about to end my race according
to my doctor.I will want you to use the fund to build an orphanage
home in my name there in   country, please kindly reply to this
message urgently if willing to handle this project. God bless you and
i wait your swift response asap.
