Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9B270B30C
	for <lists+linux-cifs@lfdr.de>; Mon, 22 May 2023 04:08:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjEVCIl (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 21 May 2023 22:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjEVCIk (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 21 May 2023 22:08:40 -0400
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A6AFD2
        for <linux-cifs@vger.kernel.org>; Sun, 21 May 2023 19:08:39 -0700 (PDT)
Received: by mail-lj1-x232.google.com with SMTP id 38308e7fff4ca-2af30d10d8fso16103021fa.0
        for <linux-cifs@vger.kernel.org>; Sun, 21 May 2023 19:08:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684721318; x=1687313318;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=dn6BkggV7S8KDOFMBJJveOt00Wl3O8QSoJ0+P9Ia9Kk=;
        b=IYOJmPu2xocwkze2g5QBahnyXgRKtkG639wq3gEHBJaYw2cvEiLMBn6KqrwuICadAH
         XkMPWdMZ2j5S9ZtKapNon6rPFG6KRJfV2rrADdfv5QN3+B5TJr5Hjg/rce5Ou2zOO4+0
         KhYB8GbPiVkv2RNRHnciJwWMAVCwQ89Ge/WrQt1aomeDnEzda8RX8WyXSAtzIlZD7GIn
         gGUe0vy17PpYGCoNTjEHFjRbmMjBAZENGmNdwskkEdyknPQGT/tpgkQn4rikEy9jPjTv
         E54KKCslVXWwQ2etQndLH4gx/h9XnpxT0a9TtI3g/FF22V/aiWbCzxw4DzmtJHkqGVVa
         L32A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684721318; x=1687313318;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dn6BkggV7S8KDOFMBJJveOt00Wl3O8QSoJ0+P9Ia9Kk=;
        b=BwSu4w5cMnXQcNJh7zxxFGOtYqt8t+t7rjRZeuYSTY1oOSn1op2Bezvsd7RKhjek2o
         6ekbwH+6y8Flh2e8C2VeNHTS45isaDcOs8Re536ivvV3V48xazXG/kPcG5mSXbyoDOAM
         7DQ3IpkrJYHN3iS+zq6mqqNFZKrxkLJII3JbXf4NajmADGLQKO6TTJhtr/ywr4dKdXKC
         jNzda7U9AhzBYmuLIu0L5wTc1G5Vp7bMpFr83k97xKyZUH9TmJn6zJy1lh1OHGhH4lg1
         iMdge2TDW1btbDbzRmEvT4j/W75mWCS5jOa+q1uPFRg5ciQfE+dgWc14/2YKZdR1YPJC
         ax+w==
X-Gm-Message-State: AC+VfDxEQW3SW/vArPoqrcTe8D/POd5lvwd3KA8rTZUeSD/knQg+XsOX
        sFuxcWMTF8gcYdlQTV2dxkwRnH+4bgxdUZAaJe3R/oUKx1KUfr01
X-Google-Smtp-Source: ACHHUZ4Mm2m5miUdWH7RvdE6gHaRxyMnYVbENQ6K6QrU9IWF4Lu11SIC3nk94k6UtJAKIbEqsODXpdB20nlLWN0dQko=
X-Received: by 2002:ac2:59d1:0:b0:4f3:822e:f025 with SMTP id
 x17-20020ac259d1000000b004f3822ef025mr2968146lfn.49.1684721317352; Sun, 21
 May 2023 19:08:37 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 21 May 2023 21:08:26 -0500
Message-ID: <CAH2r5mv8nAncg-f=Z5u8LkH4o7kfJLJdtoksYQgiguF7efKZkQ@mail.gmail.com>
Subject: Displaying streams as xattrs
To:     samba-technical <samba-technical@lists.samba.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Looking through code today (in fs/cifs/xattr.c) I noticed an old
reference to returning alternate data streams as pseudo-xattrs.
Although it is possible to list streams via "smbinfo filestreaminfo"
presumably it is not common (opening streams on remote files from
Linux is probably not done as commonly as it should be as well).

Any thoughts about returning alternate data streams via pseudo-xattrs?
Macs apparently allow this (see e.g.
https://www.jankyrobotsecurity.com/2018/07/24/accessing-alternate-data-streams-from-a-mac/)





--
Thanks,

Steve
