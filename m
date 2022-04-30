Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D4B515A43
	for <lists+linux-cifs@lfdr.de>; Sat, 30 Apr 2022 06:11:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240046AbiD3EOh (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 30 Apr 2022 00:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239650AbiD3EOg (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 30 Apr 2022 00:14:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103812E6AC
        for <linux-cifs@vger.kernel.org>; Fri, 29 Apr 2022 21:11:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A6496091A
        for <linux-cifs@vger.kernel.org>; Sat, 30 Apr 2022 04:11:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C3943C385AD
        for <linux-cifs@vger.kernel.org>; Sat, 30 Apr 2022 04:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651291875;
        bh=9qy/l7o277+7wr2ZZ12yjFTUBmJhwutpRHfA7plIFgM=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=cjbdrjlC06yjlKpCBxEL9705vNECGelOAsl/5gtdzWGBwA9LsHoiE4iHemfXntiHy
         5gYhiFWA+dYu8Lvoi7cLK6YRgRwpRTgI+YY++JtxcPjPkUfUVKT4Bc4XpVs88iZUwy
         ZEbVMW875fklitzanVQUMn6Eekzp0XtjTC1y1Fsb4jlmigSStmFJrcICFbeosQONG/
         EESgVyb7zuv5MAnV6HOuxd6tmrYzu+r7JuSbTDUDdNpSoLrisgitca7Xz48W99vtr4
         hbOQV3I0VrVvtGKNdd88CGcxwiGQuK7WCMyYANEKNn7qWdmhWoGj294RT2Iyyg1k3w
         UjIgQwVjKc1OA==
Received: by mail-wm1-f53.google.com with SMTP id k126so2171017wme.2
        for <linux-cifs@vger.kernel.org>; Fri, 29 Apr 2022 21:11:15 -0700 (PDT)
X-Gm-Message-State: AOAM530GN7LvfQXC3Ud8ekZ5CizNzWbbJCXPwqac8fSHlJ6OJpaycgJj
        lISFwWCH0LvTEGuH7jLEuiLqsHn355KglpsnM4s=
X-Google-Smtp-Source: ABdhPJwRnt3CCeBE+tU9Mji61DF7T1d5k3KfmfR8xJlJ6DpGP963EXv5G+fLp1ww0WLj/HTmM5nNVE13WL6UZCvo8b0=
X-Received: by 2002:a05:600c:19d2:b0:393:efff:7c26 with SMTP id
 u18-20020a05600c19d200b00393efff7c26mr6140219wmq.9.1651291874013; Fri, 29 Apr
 2022 21:11:14 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:64e7:0:0:0:0:0 with HTTP; Fri, 29 Apr 2022 21:11:13
 -0700 (PDT)
In-Reply-To: <20220429233029.42741-4-hyc.lee@gmail.com>
References: <20220429233029.42741-1-hyc.lee@gmail.com> <20220429233029.42741-4-hyc.lee@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 30 Apr 2022 13:11:13 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_bJJMEbgGpXaeZatZP0Atf-KRWzjrcH3NyN=mYocD-Tw@mail.gmail.com>
Message-ID: <CAKYAXd_bJJMEbgGpXaeZatZP0Atf-KRWzjrcH3NyN=mYocD-Tw@mail.gmail.com>
Subject: Re: [PATCH v4 4/5] ksmbd: smbd: change the return value of get_sg_list
To:     Hyunchul Lee <hyc.lee@gmail.com>
Cc:     linux-cifs@vger.kernel.org,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <smfrench@gmail.com>,
        Yufan Chen <wiz.chen@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

2022-04-30 8:30 GMT+09:00, Hyunchul Lee <hyc.lee@gmail.com>:
> Make get_sg_list return EINVAL if there aren't
> mapped scatterlists.
>
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
