Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 037684C3A70
	for <lists+linux-cifs@lfdr.de>; Fri, 25 Feb 2022 01:43:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbiBYAn1 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 24 Feb 2022 19:43:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229923AbiBYAn0 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 24 Feb 2022 19:43:26 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D52A278CA8
        for <linux-cifs@vger.kernel.org>; Thu, 24 Feb 2022 16:42:56 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id n13-20020a05600c3b8d00b0037bff8a24ebso770455wms.4
        for <linux-cifs@vger.kernel.org>; Thu, 24 Feb 2022 16:42:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:from:mime-version:content-transfer-encoding
         :content-description:subject:to:date:reply-to;
        bh=ixHVzoz696qN1Cmrg9x1bmR8vdWLOLbXCVjc9DtTLhI=;
        b=nCP5TMAx1y583/QzXHHjjWmnCMU0EkD/vE14rqhwDJepycKs/tQSoIIInA/vZ9tA1S
         GTIwa7vter52aPBjBoV5RuL2CU3avJIpc5frd7KZjpItgOsbsW+WPOAdlTmeJxkOefrL
         doSSVchMMYidPHsZ8OYYPLNpeFZFTz+89Fb6hXTNGccLn8BpSU07CxwNjD7gS70iCNDk
         H9h0fyAIwJdfuXX1dJVgsxg25KB2Sex3HNA2aQ/1OpH4Co0hWfGPal5wEEcDeIU/sYPO
         S9/c0k9BUlO/FIQwelQo8s+vd4C5rEXb0jaCs0eVRRtmlqXaBHrG4cyZOTc2DThSecTl
         jtmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:from:mime-version
         :content-transfer-encoding:content-description:subject:to:date
         :reply-to;
        bh=ixHVzoz696qN1Cmrg9x1bmR8vdWLOLbXCVjc9DtTLhI=;
        b=s5hQ6DzJkZQQjjdf2ZlDPk4wHP9wq2Vz4WWgHgNzOcwbP5ru2G6nVbuL4yq/6+33Qn
         NZ+Q3ErOcVObPmY3RGowOtSLOaw7eT86WlWNqVj7gEP/rnRY1E9PgoQQY9bRXAM626Z+
         itjW4CErbNFQb/9j4IH6nUZalEZ3Ok9gj774L5bypaMJfyKAo1YZhr82LdEW4RGGiZ1w
         O9js1EAs4sJUh/5fnh2xmFXOPe2zJX7Rztq0c7lXa3DpQJxAnp6JrX3CXLODdWS5Nkdi
         pcMGYMo/2yo3mTDXAVozPjIDGiTXj/F8RdVmP7HPhQkKCRN5JGBhqakjjmA/hAJUjSuW
         F/yQ==
X-Gm-Message-State: AOAM533OKabJTvaOcne5Klliht9SigUSvu/YrnZs76LeVtauIXsL/Gqj
        qu1ZMtPEbeg7JYkMMAMdlg==
X-Google-Smtp-Source: ABdhPJzZybvnRNAtIM5kK+/8Bx5KjFTX3VYkrzQzM25fHvkdA5In3/cYFCOlwPDw4aHQl3mJLYD0vw==
X-Received: by 2002:a1c:2946:0:b0:37b:d710:f565 with SMTP id p67-20020a1c2946000000b0037bd710f565mr502097wmp.10.1645749774567;
        Thu, 24 Feb 2022 16:42:54 -0800 (PST)
Received: from [192.168.0.133] ([5.193.8.34])
        by smtp.gmail.com with ESMTPSA id j5-20020a05600c410500b0037bc3e4b526sm4101740wmi.7.2022.02.24.16.42.50
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 24 Feb 2022 16:42:53 -0800 (PST)
Message-ID: <6218260d.1c69fb81.25335.f28c@mx.google.com>
From:   Mrs Maria Elisabeth Schaeffler <geraldhelper9@gmail.com>
X-Google-Original-From: Mrs Maria Elisabeth Schaeffler
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: Spende
To:     Recipients <Mrs@vger.kernel.org>
Date:   Fri, 25 Feb 2022 04:42:44 +0400
Reply-To: mariaeisaeth001@gmail.com
X-Spam-Status: No, score=2.2 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        LOTS_OF_MONEY,MONEY_FREEMAIL_REPTO,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,TO_MALFORMED,T_HK_NAME_FM_MR_MRS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: **
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hallo,

Ich bin Frau Maria Elisabeth Schaeffler, eine deutsche Wirtschaftsmagnatin,=
 Investorin und Philanthropin. Ich bin der Vorsitzende von Wipro Limited. I=
ch habe 25 Prozent meines pers=F6nlichen Verm=F6gens f=FCr wohlt=E4tige Zwe=
cke ausgegeben. Und ich habe auch versprochen zu geben
der Rest von 25% geht dieses Jahr 2021 an Einzelpersonen. Ich habe mich ent=
schlossen, Ihnen 1.500.000,00 Euro zu spenden. Wenn Sie an meiner Spende in=
teressiert sind, kontaktieren Sie mich f=FCr weitere Informationen.

Sie k=F6nnen auch =FCber den untenstehenden Link mehr =FCber mich lesen


https://en.wikipedia.org/wiki/Maria-Elisabeth_Schaeffler

Sch=F6ne Gr=FC=DFe
Gesch=E4ftsf=FChrer Wipro Limited
Maria-Elisabeth_Schaeffler
Email: mariaeisaeth001@gmail.com
