Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 781685344E9
	for <lists+linux-cifs@lfdr.de>; Wed, 25 May 2022 22:33:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243636AbiEYUd4 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 25 May 2022 16:33:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38966 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343655AbiEYUdy (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 25 May 2022 16:33:54 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54CB740E53
        for <linux-cifs@vger.kernel.org>; Wed, 25 May 2022 13:33:52 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id m20so43908608ejj.10
        for <linux-cifs@vger.kernel.org>; Wed, 25 May 2022 13:33:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=jF4MxsPSKKSAh34A0y7fWqFeFSCCDQ9NCjS0um7aELU=;
        b=iVWBVhb8XTv9Lw8Bi8opvkVedouKvUdAPVSBGKIzH07pEyntxt4ANgdkWWuocjAIZz
         MO43lmlKIrrkZhr4T/7i+TCmexG5NDirvIPm6/xOrY3llK3oD+5qstAT4kdEhgvxUpgg
         4TjG87reXckaQPRTQPo+KOPtSiD4soeVj1vJ9lPrjauVi1YgNRFyNuqMaBfo4pMXJK6w
         p0F0DF8acwdSylIUOa8FQFcZtlvv/g3H7mbb778ouxMiUn5hoZWoPXvT7Xk7cMFXX15n
         i5fioeJqZ3ZbvRZPzRUHsMn7PMa/Gqg27qfqoa3xk/1HaeaIesvC7Nz/4Rf+WNoOj5a5
         RIgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc
         :content-transfer-encoding;
        bh=jF4MxsPSKKSAh34A0y7fWqFeFSCCDQ9NCjS0um7aELU=;
        b=d2gEXxbwsy3xbW/KHignGgu9WP6tUA3AzfZ9/lMakiM09uC55wwO9Pvscvcx91tQcD
         Cw5Um0vKd9zjtwGd7yBlYJwRB0Sjk/0f20fry4F/Z+pYV2tD6xKQl/iwiBTX0sPCGCD/
         O42qAjlK2oNtCo52BQunZHdm5SwhUdaxdOvQB+t+dFoLDKVDV1DS30bHiwkQdmAT3Vo1
         bw+2QmEpHCI7rFnyaqNNZComidWH2qB3OxmbM9czbDfil0kqzVyBkhd22lqetf/fkXXZ
         Vk7xczWYZUpKeLbLUxp5kCKs/6dcwigW+nCAvXVy6dlFar7cTawB/zlTOl3E/iwrT92w
         XRsw==
X-Gm-Message-State: AOAM532DeS9FyLzs2vKQtj719yuXqLPy8hSEuOoY7DkI+bZ8YRvLU6U5
        P5G9MWcoOZjMewR8glB+lCt6UsHN+j7mJcuw5LM=
X-Google-Smtp-Source: ABdhPJzh1eIlvgHQMP3jfMU+cJRui7kNAvUFimc7+Wuq/i2uDmnMNV60BYqz6hIuJbit5rZaV7pgdF6OjV+D3ckPnuU=
X-Received: by 2002:a17:907:a06f:b0:6f4:d336:6baa with SMTP id
 ia15-20020a170907a06f00b006f4d3366baamr30629545ejc.638.1653510830953; Wed, 25
 May 2022 13:33:50 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ab4:a26b:0:0:0:0:0 with HTTP; Wed, 25 May 2022 13:33:50
 -0700 (PDT)
From:   Luisa Donstin <luisadonstin@gmail.com>
Date:   Wed, 25 May 2022 22:33:50 +0200
Message-ID: <CA+QBM2p8PZ1AOO0FjZutJGjwONQOXbUY6eirM9yZYAVweWRNdQ@mail.gmail.com>
Subject: Bitte kontaktaufnahme Erforderlich !!! Please Contact Required !!!
To:     contact@firstdiamondbk.com
Cc:     info@firstdiamondbk.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Guten Tag,

Ich habe mich nur gefragt, ob Sie meine vorherige E-Mail bekommen

haben ?

Ich habe versucht, Sie per E-Mail zu erreichen.

Kommen Sie bitte schnell zu mir zur=C3=BCck, es ist sehr wichtig.

Danke

Luisa Donstin

luisadonstin@gmail.com









----------------------------------




Good Afternoon,

I was just wondering if you got my Previous E-mail
have ?

I tried to reach you by E-mail.

Please come back to me quickly, it is very Important.

Thanks

Luisa Donstin

luisadonstin@gmail.com
