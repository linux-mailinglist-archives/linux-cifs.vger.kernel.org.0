Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B6064449F
	for <lists+linux-cifs@lfdr.de>; Tue,  6 Dec 2022 14:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233927AbiLFNeS (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 6 Dec 2022 08:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233913AbiLFNeR (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 6 Dec 2022 08:34:17 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D5C56310
        for <linux-cifs@vger.kernel.org>; Tue,  6 Dec 2022 05:34:16 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-3cbdd6c00adso151586797b3.11
        for <linux-cifs@vger.kernel.org>; Tue, 06 Dec 2022 05:34:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=plIPv+lnMIRiOFIe1dV+2tGtFokN2PX8I8Vl98aLxQc9p4eid896+qqRiD3cj5lfhx
         z1hiGYil0vHTQsGiaUgsnmnfx7Jsn5jop25MSUm4B/gJqMPAdiI+jqYGT4X+agKLBheY
         M4kLaJ4VYCDPrPdHz+VgEOo7V/8+VLiplXwZ5AxhmuB3ZAIj06bRIm6vVBa+cxsfUC69
         p7oJjaq1f7uQyzM8lwAnIzamm5TXtetx0xVW4yZv8ZN22bVtgp/BSdTYcvwessuJv/HS
         +NRVIrLiepTygJiUKe8fSjaB2LODMLrNxWaYxbpkKlISbamBewTovVPI3Q2nv//3DE4C
         AORg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SzBlYeGeT15Xra75w9IZDBjQ7Da3XKSmRdlnDJDYrko=;
        b=Ek2SBHsVnJ8DM+WaxdrRlbT3DHosWMyymMNSIRNfntDuZmvEyCx6FB4kKxm1UGOpnQ
         Gz19+DULn+4HiDX1KZi/RKdy7EdeCVZu2sD+H9oUChzjSVc7Q0hSaKaY3Lb0Dy8ussCc
         vFZsu9K2SA4A8dCBoGqz1SzYuGUD3l5tHOMVw/W9ae66pe3k39e6e0qzA8QaTjPqDqR3
         Iat65DnUj5w+tPM6fvcJPub9Zf2ahiDjPOrMOBma36arw6t3wZMO0C0SBVWJiggkEnOu
         nReMToqrqG/naAG0TvCWG+3A5JZBmqI1euMzHBkkaKPHm2FC/sNB1d/EbDsbvOvgs/eY
         U4LQ==
X-Gm-Message-State: ANoB5pk6ipeKh3aWazMwP4JFJGcUTK4C0hGD53tP/9vyZkcuCXe8MUUJ
        oIv/Y0Hh6zRlrV75PkJWnXtYDwO00SbZl4s5Kc0=
X-Google-Smtp-Source: AA0mqf5LIFZdFA8gXtM15wCQVGRPhLW0DnkI1aVHz2d7yBbqXPecX+J2gwBesGTmYMSfngKxp/YLH/vq5s11h8+sSxc=
X-Received: by 2002:a81:5243:0:b0:3d2:2098:c5fb with SMTP id
 g64-20020a815243000000b003d22098c5fbmr31224498ywb.121.1670333655770; Tue, 06
 Dec 2022 05:34:15 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:7010:a205:b0:314:d2a3:70a with HTTP; Tue, 6 Dec 2022
 05:34:15 -0800 (PST)
Reply-To: mr.abraham022@gmail.com
From:   "Mr.Abraham" <mrkojofofone01@gmail.com>
Date:   Tue, 6 Dec 2022 13:34:15 +0000
Message-ID: <CACJtp8tgBjrWD7ywREfL1yUK0-utTuArETnYq7P42dWiPJKSBA@mail.gmail.com>
Subject: Hi
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.9 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FREEMAIL_REPLYTO,FREEMAIL_REPLYTO_END_DIGIT,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_FM_MR_MRS,
        UNDISC_FREEM autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

My Greeting, Did you receive the letter i sent to you. Please answer me.
Regard, Mr.Abraham
