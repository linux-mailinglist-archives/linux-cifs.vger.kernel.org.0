Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83C35568F11
	for <lists+linux-cifs@lfdr.de>; Wed,  6 Jul 2022 18:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbiGFQZx (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 6 Jul 2022 12:25:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232950AbiGFQZv (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 6 Jul 2022 12:25:51 -0400
Received: from mail-oa1-x2b.google.com (mail-oa1-x2b.google.com [IPv6:2001:4860:4864:20::2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5964B26568
        for <linux-cifs@vger.kernel.org>; Wed,  6 Jul 2022 09:25:51 -0700 (PDT)
Received: by mail-oa1-x2b.google.com with SMTP id 586e51a60fabf-101b4f9e825so22053971fac.5
        for <linux-cifs@vger.kernel.org>; Wed, 06 Jul 2022 09:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:reply-to:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=Uk0kx353H+gGEfDDNFmV1k9XciWZTV5g6S3ovbgNaYc=;
        b=N7g1mQlEkm5X+DqU1wJgHmdcuhT2doWLe1NY7SgkFmiIu08DVgwq7QbCFZ/5xFraTD
         dzcOCr9wJ4ykWCMnyWKSSlj8x/yWWwgU2mjn60wZgP7PoL0RGa4UJaPdyWrTibbe+YSf
         cD7fthMYk82IRhPoWgfFPbyq6f4ghKnJ1l2vqSk6RgZk/Sym6Qh/cxht45dzmRVGWTC+
         DWGfa752hG6TFrKoGKbx6NaFexxng0z4+t19vd3x/SGQ6dZV02XzepdrlHhb8lFEh4Rz
         hXiDBOcbxy8PhSFSrcJtsQ9XDnkzoSzFUHBaLWhkTyv+kaGv61yduRmtFJomkpyl4Jwr
         3drQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:reply-to:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=Uk0kx353H+gGEfDDNFmV1k9XciWZTV5g6S3ovbgNaYc=;
        b=yWCs/HnK/ZqJQE5hk7sUiChNNzP9k6/0FcPZsEu6Tn0Hk8BVjz+bOvmKRm21sDa3bp
         95xsXPe21PVY+ILkHdt2mj9BgB7+K6HAn90q7X1Qc1osbW+ahtwDNXcJyZwiCmXCH4jz
         ToJ5YrW9hUlp3XgQbvVstjhh1wGFhqK0/nf2tZgvj3vv/2pTQqaiL/agFlChGIV9/Qyb
         3/O2GXg8HYhTea0PTHQdBiS71dC21ggxy+Jrf5HZAtQ1Ng+yh1bA7yD4PrQCMdoKjdQ9
         FJ0+2v4cQGlXjRVIEgxV9JwwpwIbGpwyOL3ek78WgT3YlvqvGGQotR93333plv8BstZJ
         s0lA==
X-Gm-Message-State: AJIora/H4vKkpFxOTgQ0SO3gv7Dcp8gPe/hnfpm5dk0abG92dtI/DEdO
        sRSfCf9hDbqbbKXps3H9ujQohtDnDtn+UQOpTjU=
X-Google-Smtp-Source: AGRyM1trL8UD7a38RiOfBJoYrTQYhoOXABCzv7z18CnowV47KiHsSceYtTqWLdH8BTsFRoRyE/y5QXrFj9oFyr5HNQQ=
X-Received: by 2002:a05:6870:c144:b0:eb:5ef1:7d8c with SMTP id
 g4-20020a056870c14400b000eb5ef17d8cmr26645249oad.232.1657124750635; Wed, 06
 Jul 2022 09:25:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a4a:4545:0:0:0:0:0 with HTTP; Wed, 6 Jul 2022 09:25:50 -0700 (PDT)
Reply-To: sgtkaylla202@gmail.com
From:   Kayla Manthey <avrielharry73@gmail.com>
Date:   Wed, 6 Jul 2022 16:25:50 +0000
Message-ID: <CAFSKFDaXyjkBMVRZVcAyNHF=Ems5A4GvkAxFvkMzRdiaVYKoDA@mail.gmail.com>
Subject: 
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
X-Spam-Status: No, score=4.2 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

LS0gDQrQl9C00YDQsNCy0L4g0LTRgNCw0LPQsA0K0JLQtSDQvNC+0LvQsNC8LCDQtNCw0LvQuCDR
mNCwINC00L7QsdC40LLRgtC1INC80L7RmNCw0YLQsCDQv9GA0LXRgtGF0L7QtNC90LAg0L/QvtGA
0LDQutCwLCDQstC4INCx0LvQsNCz0L7QtNCw0YDQsNC8Lg0K
