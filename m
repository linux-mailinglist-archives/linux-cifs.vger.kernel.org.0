Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4CD591AAF
	for <lists+linux-cifs@lfdr.de>; Sat, 13 Aug 2022 15:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239540AbiHMNjE (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 13 Aug 2022 09:39:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239562AbiHMNi7 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 13 Aug 2022 09:38:59 -0400
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D4DB7ED
        for <linux-cifs@vger.kernel.org>; Sat, 13 Aug 2022 06:38:56 -0700 (PDT)
Received: by mail-vs1-xe33.google.com with SMTP id c3so3279988vsc.6
        for <linux-cifs@vger.kernel.org>; Sat, 13 Aug 2022 06:38:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc;
        bh=C+z24Pl7od6xO10XmMEfecsYemTIfW+XARlPRi62dVY=;
        b=RRGknfo5+uwzeBEXwp5VvC6LL0jseGdqBO/9QVbHdBbdll4M3YT8856GReYMdTplHo
         1Hp3hFnO085jTvvDq4Rqg8DZ5NGAGbovgpXFfgLUpMp2Lzg0DqT13QoSUoCGxuyGRD1U
         XjOQgh7tUsypAzpkpBuEKgIxnZ4YJJhAEEn8QsFOwCaKZH2F3H5Z31ogthrGLUH/DxGB
         7yFJGK5DMbLI3u5tWLkP45CVb2pGONJI1/cg52tcRpnSzE+Fv6laspCLo6opSRycNp18
         GBuEA5lVsjZ0fuZUWXd/RIoa+IfpegHhT5vLULa1nBQ8tOjy275K8sFdZA+teHyXhISu
         ha+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc;
        bh=C+z24Pl7od6xO10XmMEfecsYemTIfW+XARlPRi62dVY=;
        b=7LGBnvcaoCpf5emjfJyttUG/ln4+KOMfc7ERxOb/Lp0d69AWzX5pAWxecaATEurqZb
         4n3dxcZhynYjhFG5yrzfOriXt13OKDvhJqd1n2HSF4EHFFF8F8MYDtmFPMD/rZsVed0G
         Y3mJ1oAWmmgiM/I8KLn0FaDibrBy7MlkrSjhL56vQgtHgPgt5HBcTVBsZD7xA17UHY9j
         kTAAKQRYTFrZpnvGqRHSRXTf/uwoP+7YHST8hjUoc5PyRvum2i2QEfIWi/B92mCM6J6D
         P3YY+pHlO249bdX9VGdbu3dXPV/DtW1S+pLNvf4bz6YbIpaXFa/3TTp/duRvEOKxECW7
         Ostg==
X-Gm-Message-State: ACgBeo0GNCeJrv0lFBT0YUGpMJCTLKMxGV/DKmXiw7eg9/To0P3ejIBq
        3IVUfpZfJw00Sk2TUGR8G99zyGH0HvAKZR7SHZw=
X-Google-Smtp-Source: AA6agR5Wj0h/OuVBImGrVav7mYHr3+hZsZfBOXZMzLxnjpbaVRUi8Rrpt7YcmkA7x81Z7KdPzduHkzZCGmYZCBq8OQQ=
X-Received: by 2002:a05:6102:d9:b0:38a:92e8:3714 with SMTP id
 u25-20020a05610200d900b0038a92e83714mr3753178vsp.83.1660397935364; Sat, 13
 Aug 2022 06:38:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a59:cd27:0:b0:2d6:bf9f:1ce8 with HTTP; Sat, 13 Aug 2022
 06:38:54 -0700 (PDT)
Reply-To: paulmichael7787@gmail.com
From:   paul michael <edneyrichard87@gmail.com>
Date:   Sat, 13 Aug 2022 14:38:54 +0100
Message-ID: <CAEahD6zqCBRK0jZKRfisKDLBnn+xNSHrp4fc==1dwDX=HWCPLw@mail.gmail.com>
Subject: Hello
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: Yes, score=5.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [2607:f8b0:4864:20:0:0:0:e33 listed in]
        [list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.2 FREEMAIL_ENVFROM_END_DIGIT Envelope-from freemail username ends
        *       in digit
        *      [edneyrichard87[at]gmail.com]
        *  0.0 FREEMAIL_FROM Sender email is commonly abused enduser mail
        *      provider
        *      [edneyrichard87[at]gmail.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 FREEMAIL_REPLYTO_END_DIGIT Reply-To freemail username ends in
        *      digit
        *      [paulmichael7787[at]gmail.com]
        * -0.1 DKIM_VALID_EF Message has a valid DKIM or DK signature from
        *      envelope-from domain
        * -0.1 DKIM_VALID_AU Message has a valid DKIM or DK signature from
        *      author's domain
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        * -0.1 DKIM_VALID Message has at least one valid DKIM or DK signature
        * -0.0 T_SCC_BODY_TEXT_LINE No description available.
        *  3.1 UNDISC_FREEM Undisclosed recipients + freemail reply-to
        *  1.0 FREEMAIL_REPLYTO Reply-To/From or Reply-To/body contain
        *      different freemails
X-Spam-Level: *****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Every time I retest your email, it tells me to check with my ISP or
Log onto incoming mail server (POP3): Your e-mail server rejected .
Kindly verify if your email is still valid for us to talk.
