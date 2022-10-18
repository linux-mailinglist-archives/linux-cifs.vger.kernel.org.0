Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AC3602F93
	for <lists+linux-cifs@lfdr.de>; Tue, 18 Oct 2022 17:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230182AbiJRPX0 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 18 Oct 2022 11:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230188AbiJRPXR (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 18 Oct 2022 11:23:17 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86F6DD2CCB
        for <linux-cifs@vger.kernel.org>; Tue, 18 Oct 2022 08:23:13 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id g1so23088763lfu.12
        for <linux-cifs@vger.kernel.org>; Tue, 18 Oct 2022 08:23:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=430ps2sqnmyOG7CkocvHHgo7LY5uawW1HIr8oL2FOAI=;
        b=OyXWtJkhS2QiKJE7fcpy+2jtlmbybluPcm8cJBUg70fxf+QPtvrgv8zflkpr0n/C32
         TuhuF/p9JLP0Fz81MUPU6vzjPcTx6oZQbc98FCTJaYfbwvZt7j5SPzqTw4tKZAbb2uoW
         vsnlJ5rsg7aiqM6oQvCAxGIGUssuX+hHeZ+Kl/9OMQyhp4XUduAnOZd7mG0trFp7y7+u
         jy7D8Z1BVSQfIc1UQ9IQ4yN7GA4xHUDNQ3OCUPeuqwO5FczyainB//8TQlsHLPlel6Xk
         6aQUUAj1j/I7Z4koM4FjC2viaK0PvnoAHDJWwApO4E7Y4tSygl1u+5n0AI9EZ8yGZi2u
         flmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:to:subject:message-id:date:from:sender
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=430ps2sqnmyOG7CkocvHHgo7LY5uawW1HIr8oL2FOAI=;
        b=VMI5CBuujuPfV0HTHroLPtIbvneAw2PYSDd3hOhzHcVLqq40RzuWG+ujQe0ndBw1tB
         lQnPSJBkzgW3I/N6j+uZGW5iIcg4c/hClXbZsLt2/ye4yP3PIwXv3OqAGzx1sMjDAVA9
         Y0ycZgS+zox0Kf1wFI+p7Jeg/4YGPQr8E71kgsAqTQ7N9kQMxAcysZeCt+hI6JzC/bBU
         4ODY2Hqeb1a3i9wItYQgSs5aZkLcX4eVj/JFm9vH2yZBb2Nf0vM1pxOIKfus09bOrREY
         oDeFKHaIVmOPlRPlrgrzVwybavKWK9Eefet0nbfFjjYb9ZqFqwAIDXORaEFK8yHSH/8z
         juYg==
X-Gm-Message-State: ACrzQf0Gggrxe8Z8S6P6qeUCaF44arPKU3baWd2noEwcUvrI9tnya2yC
        Vq/2ESuroA15LnwEVMY6xG4uvPSXGzWqdr6RJ+U=
X-Google-Smtp-Source: AMsMyM7xhLyVP6vHJWLVKszpz3s3n/BE4bHD2KT0lCMGjloDa4uYufCQ1/EDOIR2yLjFkxmIH1NS9A3XS6rYkuRuAIE=
X-Received: by 2002:ac2:4f02:0:b0:496:d15:ea89 with SMTP id
 k2-20020ac24f02000000b004960d15ea89mr1122896lfr.69.1666106591227; Tue, 18 Oct
 2022 08:23:11 -0700 (PDT)
MIME-Version: 1.0
Sender: dayekossivi1@gmail.com
Received: by 2002:a2e:8552:0:0:0:0:0 with HTTP; Tue, 18 Oct 2022 08:23:10
 -0700 (PDT)
From:   Miss Marybeth <marybethmonson009@gmail.com>
Date:   Tue, 18 Oct 2022 15:23:10 +0000
X-Google-Sender-Auth: br_IlUabP68aAt5zs6NGzZOJ9Y0
Message-ID: <CAEgRvuxyH=aDqiziNZfvTB_MbvPiuG=37P_E2EyaqjAn+i8cWg@mail.gmail.com>
Subject: RE: HELLO DEAR
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=1.4 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,SUBJ_ALL_CAPS,
        T_HK_NAME_FM_MR_MRS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hallo,

Sie haben meine vorherige Nachricht erhalten? Ich habe Sie schon
einmal kontaktiert, aber die Nachricht ist fehlgeschlagen, also habe
ich beschlossen, noch einmal zu schreiben. Bitte best=C3=A4tigen Sie, ob
Sie dies erhalten, damit ich fortfahren kann.

warte auf deine Antwort.

Gr=C3=BC=C3=9Fe,
Fr=C3=A4ulein Marybeth
