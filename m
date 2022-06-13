Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE45554A274
	for <lists+linux-cifs@lfdr.de>; Tue, 14 Jun 2022 01:11:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbiFMXLD (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 13 Jun 2022 19:11:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229614AbiFMXLC (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 13 Jun 2022 19:11:02 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 247A03152A
        for <linux-cifs@vger.kernel.org>; Mon, 13 Jun 2022 16:11:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C2F91B81645
        for <linux-cifs@vger.kernel.org>; Mon, 13 Jun 2022 23:11:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BAA9C3411C
        for <linux-cifs@vger.kernel.org>; Mon, 13 Jun 2022 23:10:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655161859;
        bh=89feZ9yyVZhFLc1Ur844MicgcLwDtKJzZ/Iba5PHbgM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=lofLQRo3xuB8or9RKO7yyBdiFJv2qAhXQq9ccBK5ECtMXcPR7/f+tQ1EYeYyJv8ir
         1h69zDUCnT2bxvsOElH7kIgvGJPuGWly4CGdR/1jHBwJmZP79V/JXqf/4+ohQ5hWXe
         kMOpJGCelWk3YGCkylCCLIdu4a2PqMUIXEjUQcbB0/aKhUjds1P9ba7JxZmZAqt7jy
         sBXM1BZyq5PVfgMwSu3oalhcyD6xvoKy7SukLPa5e5+S0IkRureXHJ6IeqbO7vTyoM
         cofLbJ4NcytgmvS4p1QAeUg10R9jkXzID764I3/2LtPUZZ6fu6KPGPDPNBDtuHJn8Z
         39H4qGsJBJF2w==
Received: by mail-wm1-f49.google.com with SMTP id o37-20020a05600c512500b0039c4ba4c64dso5332480wms.2
        for <linux-cifs@vger.kernel.org>; Mon, 13 Jun 2022 16:10:59 -0700 (PDT)
X-Gm-Message-State: AOAM530ha9WMrA25yFNgAR5M6sUpzG709mG/BKbh2PkTAsyJTGGMPKm8
        hJBzeZYrZMFBiwwZzOc13irT1jQZJX4hZ9kzwOg=
X-Google-Smtp-Source: ABdhPJz9KRdpBsxJB9G1WTnFuLbrujdviC19bMV0BKHsjKZz3w7SuFTe/wH2MoPNitFgUs5MKINqxGuclVeKHuxAesI=
X-Received: by 2002:a05:600c:3b05:b0:397:54ce:896 with SMTP id
 m5-20020a05600c3b0500b0039754ce0896mr1014021wms.3.1655161857707; Mon, 13 Jun
 2022 16:10:57 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4c4a:0:0:0:0:0 with HTTP; Mon, 13 Jun 2022 16:10:57
 -0700 (PDT)
In-Reply-To: <20220613230119.73475-2-hyc.lee@gmail.com>
References: <20220613230119.73475-1-hyc.lee@gmail.com> <20220613230119.73475-2-hyc.lee@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 14 Jun 2022 08:10:57 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-LW2RML1sVgViHjkKy0+RvP15pFbVfLi1VLgMREc=44g@mail.gmail.com>
Message-ID: <CAKYAXd-LW2RML1sVgViHjkKy0+RvP15pFbVfLi1VLgMREc=44g@mail.gmail.com>
Subject: Re: [PATCH 2/2] ksmbd: smbd: handle RDMA CM time wait event
To:     Hyunchul Lee <hyc.lee@gmail.com>
Cc:     linux-cifs@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <smfrench@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

2022-06-14 8:01 GMT+09:00, Hyunchul Lee <hyc.lee@gmail.com>:
> After a QP has been disconnected, it stays
> in a timewait state for in flight packets.
> After the state has completed,
> RDMA_CM_EVENT_TIMEWAIT_EXIT is reported.
> Disconnect on RDMA_CM_EVENT_TIMEWAIT_EXIT
> so that ksmbd can restart.
>
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
