Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8421161DA71
	for <lists+linux-cifs@lfdr.de>; Sat,  5 Nov 2022 13:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiKEMnz (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 5 Nov 2022 08:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbiKEMny (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 5 Nov 2022 08:43:54 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2447623BFB
        for <linux-cifs@vger.kernel.org>; Sat,  5 Nov 2022 05:43:52 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id r14so11168899edc.7
        for <linux-cifs@vger.kernel.org>; Sat, 05 Nov 2022 05:43:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=mPMWJSv9+I/YyfOX/KhSq6QJxEVF9czxBjlZfOBHyBNprqZzbXMAaGfMuCUz15WUgd
         P8+TrngI9Rc3ViQGUSuldljbiqwUWen18O0hqt/Ie0OeGmALridq11sGaHqFDDc4lalJ
         acwKewZa0Z+JmHCFhOB1EPm3VoCXqyskBeWh+qI8WdUTyGDi2ZRZxfd09WAIYwZTAuE6
         D6FM36pRhxYi0ioJBBk7CWNeJYL6Gz2n7XR51nKKfVaOUPERzSe8HFAiowZB91Qmwfcs
         4SUmlVM/PGDPqE9RxpsHH7kHCVf7N827dpoIMP0fu4UEVHZDK4bGxZoR2Xec1mMJWH/r
         0h6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:reply-to
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=c8XA1N0uaxkLO/wKHErNWHaSuu64k5Pjb5u9dmcZrOc=;
        b=lzi7cDMgDtlMpLmQSFeE/HnKRU+T3WjGh+93u68lpXMQeBhn69vSUeQibNSS3C2BMr
         440U9kixq9HXcF/zCcQZH+z7Ckamw4L3/IuCr8ZZUZDGMAPK0foijtvac+6t4w+OXSec
         e/oBK7FEAgc/B5Xd21TOHQLMgauy5DX8v0brd3pM29RInWcmNh/zxVPj7VvRc7CSim4q
         zypZVbbbPwEaAIxGu+doxOIHwsGIj8QUuh8OHljs0dJsVKwFOSBaSH8a/GeKJR0eWSkW
         gGTMcAFtdbUXnlFT43OKGKl1HVBgyT62WrVy1IMkdgblaIN3raEL7P210x/e8xaFT53k
         PeAg==
X-Gm-Message-State: ACrzQf2sjOZp+Ysj2j4yP0Eqs+q2B4fhC3Ci2EJ1CYdnOLRgDwgCuZ1n
        fYjGt7FBfmklovxGU169/BJZG58alsBC7bSPSz4=
X-Google-Smtp-Source: AMsMyM6+i/60GLAa/SmSMCVLMrWq6VlVwX7X2L0dN+kFhjV6izdhKjpdEAZB1JmiGGgnIYpSeGh29lOxg8cgnriAXMM=
X-Received: by 2002:aa7:c504:0:b0:461:122b:882b with SMTP id
 o4-20020aa7c504000000b00461122b882bmr41194609edq.14.1667652230661; Sat, 05
 Nov 2022 05:43:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:7208:33:b0:5c:ee07:e4f3 with HTTP; Sat, 5 Nov 2022
 05:43:49 -0700 (PDT)
Reply-To: stefanopessia755@hotmail.com
From:   Stefano Pessina <francisnzioka80@gmail.com>
Date:   Sat, 5 Nov 2022 15:43:49 +0300
Message-ID: <CAL5scYq=1B=-RX8Eh9M9tf4CevQNnnh7JZ63=g4o=AHLN+9dbg@mail.gmail.com>
Subject: Geldspende
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_FREEM autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--=20
Die Summe von 500.000,00 =E2=82=AC wurde Ihnen von STEFANO PESSINA gespende=
t.
Bitte kontaktieren Sie uns f=C3=BCr weitere Informationen =C3=BCber
stefanopessia755@hotmail.com
