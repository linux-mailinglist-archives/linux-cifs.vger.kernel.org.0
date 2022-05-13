Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABD2526018
	for <lists+linux-cifs@lfdr.de>; Fri, 13 May 2022 12:39:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378705AbiEMKbT (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 13 May 2022 06:31:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1379422AbiEMKau (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 13 May 2022 06:30:50 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7D855219
        for <linux-cifs@vger.kernel.org>; Fri, 13 May 2022 03:30:26 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-2ebf4b91212so85466477b3.8
        for <linux-cifs@vger.kernel.org>; Fri, 13 May 2022 03:30:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=vY5Rx9AJJIuVYgGRU7ePFlipKjV6gT9mXuOvxz5rIdI=;
        b=hNU+HvYL1h5rFCR0Jtf1t4sgl+21Snxliq/dxseyWXkNe63w/Jw1xscv01iyNJ/tHx
         QQOViM6kINDqQB07FNpXW8JG1UYDMy+1ailHDae39kfPkaJuUQj7rbrxzAL6nJDRfieM
         OxEPyhKk6yzrP8fP7Pchm5Q4P5wBDbrnJakkwmKIfrtbeGWLvMDJaaJXCYj+d63Tjb8F
         qpqAb/FCfiWc3/T8/eaRm7qm9n93bPiRLIDYT+D9A3l90BxgPmq16rxdCOCEq5z2tP/T
         BcoE3iEkcec5ZWTp/rZV8XRbIgdKNczX6ec/wmN7XLXBX6Sn1ATnVHRsArq7GRU7C1qR
         3ejQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=vY5Rx9AJJIuVYgGRU7ePFlipKjV6gT9mXuOvxz5rIdI=;
        b=ytBXPyAMJvbFlyK0RS25nLViVHg8AZ+Qcl7YNJ3NIjWDq7S1awMsSBN+rDaR/D0pao
         1+QzONXYq7qv+YkvFMOpfITTwGuJk1Ztzo3zs1slDlRS+QsIcqki827g8IwelonZGJla
         fBLOAJTSdNWpN9e7f/WZFTPB53REUibpVkdc0tL5gM6X4y1Ka3uObb+V6IHNqetHnxJY
         8zjINDMJuVHrWpRppdpF2YzHIsEFbqw9/PHCnm8acQ+IY10YhFB4onr3Veb0zC0zptCg
         qvR9RnV1js8OQi8ztwFa9kLPlLLW31cdLYP1d8wESGrd9mqniAxSGf7IYrkEeBfg5g98
         h5qw==
X-Gm-Message-State: AOAM532JfuI9ed9UIkr5mU+F/Tw+Qdw/uAv6rMCEgqkEqlqLlU5/Qk/y
        uBMIvCz2uf0e9EYN2GBYPYdkTLeW1GZypGt5JT8=
X-Google-Smtp-Source: ABdhPJymlb6v7qEIeG9jXHkWhEyFuwJwf9Hjh/trxQvUE94MZ8ZXssoluRxjmklrBf8p7cPRizvJXTwqzu1GNyB5kJM=
X-Received: by 2002:a81:e93:0:b0:2f9:effe:cf4 with SMTP id 141-20020a810e93000000b002f9effe0cf4mr4935377ywo.460.1652437825577;
 Fri, 13 May 2022 03:30:25 -0700 (PDT)
MIME-Version: 1.0
Sender: kossikoffi67@gmail.com
Received: by 2002:a05:7000:250e:0:0:0:0 with HTTP; Fri, 13 May 2022 03:30:25
 -0700 (PDT)
From:   Charles Renata <advocatecharlesranata.chembers@gmail.com>
Date:   Fri, 13 May 2022 10:30:25 +0000
X-Google-Sender-Auth: JGaJz6tvPu9HwmiC5F4Zt3m2PZo
Message-ID: <CAFO4WUkSCUkbYLdqWp9xvZgQKa9TxOAOM8OXtTXD9EV0uanOgw@mail.gmail.com>
Subject: Good Day,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=3.5 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,LOTS_OF_MONEY,MILLION_USD,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Good Day.

I am barrister Charles Renata, I am contacting you again to confirm if
you have received my previous email regarding my late client's
estimated inheritance of ($13.6 Million USD). I am writing to you
because you have the same surname as my late client and I need your
help in getting this money into your account for our mutual benefits.
Write back for more details .................

Respond for further information
Sincerely,
Charles Renata (lawyer)
