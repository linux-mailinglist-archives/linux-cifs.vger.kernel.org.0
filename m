Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AACAF53D49E
	for <lists+linux-cifs@lfdr.de>; Sat,  4 Jun 2022 03:29:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350537AbiFDB2R (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 3 Jun 2022 21:28:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350261AbiFDB2L (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 3 Jun 2022 21:28:11 -0400
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F190D109
        for <linux-cifs@vger.kernel.org>; Fri,  3 Jun 2022 18:26:51 -0700 (PDT)
Received: by mail-io1-xd2f.google.com with SMTP id p130so2939513iod.0
        for <linux-cifs@vger.kernel.org>; Fri, 03 Jun 2022 18:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to;
        bh=hzqCG52SPEe4tQY/Tt070sXpLEE5srR/6HSZh6AwAPo=;
        b=dGjGCi5Qd5Pg/u9e+VdneZSDMLEQ1IQw6xtwaN90ja+Y/Q227mC+xZ66ehKkSR0+QG
         Es6aJGUsyE77iK2X5upcuVDTIXPnSL8+jc7FncnoXeEJiYkG9mg2YHHcN8w4Vd5bWxvX
         M60wEDVbNNWKAZWjKWyRDN759lKZVcqxCpnEdHJ9rJ1v107C8kFHlmx1HBOtMSaM+wQ0
         sQEpT5gXlXt1y9qa1mlJoFCYOqZ/BG9a1WiHMeCBdQwWcnTyafzlhzBA2yPaQyxZc2+m
         fhFRpiTsqnitqXDINczAsN3pqWSLfkMmXeVB3EvJHUqtxGn+794WK/iXhQLlWiTnIFRw
         tskw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to;
        bh=hzqCG52SPEe4tQY/Tt070sXpLEE5srR/6HSZh6AwAPo=;
        b=bwpUl1g03hQLkkS0oivUL/imDEFNmqR3tSl75hnscM6ze6jNaYmvfT3SeRXVgeqh75
         mfygd1uJ8csiXUzSKYd9tkTdKJTuacsVYjpW3JYCq2sejLEeIjpaCTcLEJ1GV5i/IiTi
         DX9snwHkMreqfy1fX2HpuwsXqe4MTzpgW3bznUQqC4axefbNypXVDvGiae7S+naR4ctF
         smzsrGa4T3lAFNXNt/CmCauj0LckyjCvX8R1zWRkhNEbSmCHZAJ1LTVUiLeWQZJS+UGD
         fYr6sdQhoeepHPcQjn8Fx7m06cOtl+7pg0xbZ6SSCn3UKyd4NF9k44wBkio3rBm8ZKZK
         NA+A==
X-Gm-Message-State: AOAM5304HwTbobe9xdS5oqSdUwL2eMqxJ8nGmCsv81HGjMpzAK41fJ/B
        Mi5gikdHjIhsL6xnksavNii1Pl81MAgvIbgRtww=
X-Google-Smtp-Source: ABdhPJzvJJFcpoWcVyYu1Bc07MaJCKpmzntHLTfu5pl1dwf+qPeeB6I4uLLB14tMeEUYiyfIqABII+tbkEkm0IT/0zM=
X-Received: by 2002:a05:6602:2d44:b0:665:7108:2804 with SMTP id
 d4-20020a0566022d4400b0066571082804mr6050666iow.106.1654306010514; Fri, 03
 Jun 2022 18:26:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a6b:7717:0:0:0:0:0 with HTTP; Fri, 3 Jun 2022 18:26:49 -0700 (PDT)
Reply-To: mrmichaeldoku@hotmail.com
From:   mr michael <alexyfils@googlemail.com>
Date:   Sat, 4 Jun 2022 01:26:49 +0000
Message-ID: <CAKxh-BVc=nL8vwtU=hp2vY5HJsjsEHQ0oGdJj-pLcyUDuFQAsQ@mail.gmail.com>
Subject: Hello Dear
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=6.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,FREEMAIL_REPLYTO,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE,UNDISC_FREEM,
        UNDISC_MONEY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5123]
        * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:d2f listed in]
        [list.dnswl.org]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [alexyfils[at]googlemail.com]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        *  0.0 T_HK_NAME_FM_MR_MRS No description available.
        *  0.0 LOTS_OF_MONEY Huge... sums of money
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  2.8 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  2.0 MONEY_FREEMAIL_REPTO Lots of money from someone using free
        *      email?
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
        *  0.2 UNDISC_MONEY Undisclosed recipients + money/fraud signs
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Greetings,

With due respect to your person, I need your cooperation in
transferring the sum of $11.3million to your private account where
this money can be shared between us. The money has been here in our
bank lying dormant for years without anybody coming for the claim.

By indicating your interest I will send you the full details on how
the business will be executed.

Best regards,
Mr. Michael Doku.
