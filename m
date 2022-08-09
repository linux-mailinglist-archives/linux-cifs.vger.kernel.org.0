Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CF9758D98F
	for <lists+linux-cifs@lfdr.de>; Tue,  9 Aug 2022 15:44:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231377AbiHINog (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 9 Aug 2022 09:44:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244025AbiHINof (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 9 Aug 2022 09:44:35 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E34C51AF09
        for <linux-cifs@vger.kernel.org>; Tue,  9 Aug 2022 06:44:33 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id z25so17104358lfr.2
        for <linux-cifs@vger.kernel.org>; Tue, 09 Aug 2022 06:44:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version:from:to:cc;
        bh=TzY88Uye5os498Ay3xypvHJkoI6JF6bC3vyERXDz7hk=;
        b=IAV+d4mQQYI3KFMNKMwcDdOza4T+fpCWIyvnn+rXYcJDzBbOZCyKHFCrgT2dij7bdb
         3r9e/hiu7Ac1ZtVXwqb3nnocCRK85mdMfYomOgJwLkvi84hC8EcACazNye0qUNB3/vin
         w2XzKIR/0fOn6xJmlOeWTf3yNUYIZ3FRylbrUVYsyadlLEeFVwRUTs1xKGAaWmBMPPQo
         xKTzz8YwJlKukrPW+VPduUWsh4+G7GWqaIxmqjI5MLkDkx93GITH40rEduiAueePZ4qX
         aSqsnZH2Ac02G5bBuXqQ05VUan1WJjP1iHKkPDmksbEzngevl3DqB+sjScRROLN8BGL0
         zEOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:sender:mime-version
         :x-gm-message-state:from:to:cc;
        bh=TzY88Uye5os498Ay3xypvHJkoI6JF6bC3vyERXDz7hk=;
        b=D0O7ov5SVoTNHRIS+rzs8wCShIWsIgG1cFsBA9u5IbsCcvcVuhidqs7eD0ztKB5E8u
         tpFJYiqtie+xtSxzdJqO2PZCCPdBlUKgKNduLoXN/kHBcCq3h2D+uRq0rlmMny7CtmAG
         ass29/dQqCQ0BBH4gmkJg96aG7ni3mF4gb7HUriQfrUpfQzMC/8FOvLAsx7fRyaXU0mk
         HVwC6jhZM5BY1h2VLIULK3ynmUB1h/1KP7KXyAZ1ady9Uzasm5ZX526NGuNxJ8cr2kpR
         hEJmVH+P2npQpR2YbWrzXqjncgdTnFIAl9NHDLA9Il/YQnlFfPT5067cVCA/8XfMpq1o
         W0ww==
X-Gm-Message-State: ACgBeo2UnHFHZS6f5kqYxQUFqRDHe4ZYonHUWM31q8ZO+Pcg/H9cQFfn
        zudBBw+zTzyegJCnZxrzBHcx3gNOT2i3tA8oJsc=
X-Google-Smtp-Source: AA6agR7CcPgc6RSPFJESUSh54YIrTHqZnqmuB/IPwxDx6WOp1PNHGrffvD/DxKBltRs0q7jqYv87IEQd4my1NDP1tIY=
X-Received: by 2002:a05:6512:2383:b0:48a:bb1f:d95d with SMTP id
 c3-20020a056512238300b0048abb1fd95dmr7735351lfv.467.1660052671434; Tue, 09
 Aug 2022 06:44:31 -0700 (PDT)
MIME-Version: 1.0
Sender: richardharrisonn30@gmail.com
Received: by 2002:a05:6512:e81:0:0:0:0 with HTTP; Tue, 9 Aug 2022 06:44:30
 -0700 (PDT)
From:   Sophia Erick <sdltdkggl3455@gmail.com>
Date:   Tue, 9 Aug 2022 15:44:30 +0200
X-Google-Sender-Auth: g1DGhoc_h3i5vwb50BU91Vs6eCY
Message-ID: <CAPauVps8sj0KnFnx15ov9g6DC3XOHKDCE94+gYr6tAQaJ1iGRg@mail.gmail.com>
Subject: HELLO
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.3 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_NOVOWEL,HK_RANDOM_FROM,LOTS_OF_MONEY,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_MONEY_PERCENT,
        T_SCC_BODY_TEXT_LINE,UNDISC_MONEY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2a00:1450:4864:20:0:0:0:12e listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5346]
        *  1.0 HK_RANDOM_FROM From username looks random
        *  0.5 FROM_LOCAL_NOVOWEL From: localpart has series of non-vowel
        *      letters
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [sdltdkggl3455[at]gmail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [richardharrisonn30[at]gmail.com]
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  0.0 T_MONEY_PERCENT X% of a lot of money for you
        *  3.0 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hello ,

It is my pleasure to communicate with you, I know that this message
will be a surprise to you my name is Mrs. Sophia Erick, I am diagnosed
with ovarian cancer which my doctor have confirmed that I have only
some weeks to live so I have decided you handover the sum of($
11,000,000.00) in my account to you for help of the orphanage homes
and the needy once

Please   kindly reply me here as soon as possible to enable me give
you more information but before handing over my details to you please
assure me that you will only take 30%  of the money and share the rest
to the poor orphanage home and the needy once, thank you am waiting to
hear from you

Mrs Sophia Erick.
