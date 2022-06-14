Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97AEE54A374
	for <lists+linux-cifs@lfdr.de>; Tue, 14 Jun 2022 03:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231401AbiFNBJH (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 13 Jun 2022 21:09:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiFNBJG (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 13 Jun 2022 21:09:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C3645FE0
        for <linux-cifs@vger.kernel.org>; Mon, 13 Jun 2022 18:09:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28EEA615D5
        for <linux-cifs@vger.kernel.org>; Tue, 14 Jun 2022 01:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF51C3411E
        for <linux-cifs@vger.kernel.org>; Tue, 14 Jun 2022 01:09:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655168944;
        bh=uI72lDycru5ATi0aSDhT2jIZupyYMrOl8UP3vSeDiWQ=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=FcLdHqBg0h4zXi92gsZ7+aucXnYPMwUYDOmg3Nv4W3IOdF48bA+Q3Wn59hhoaqDBo
         4UvPxlWGS/YJAED1nKxTYwgKClzif0ZtLw7iVWoge8lyLmsS7WMgIw4E5QBc6sZsBk
         VBDNFSwulT8wawS9GVeYkxBP4ClBEiTWBIHo3wnJRhtHYKTLvrqofUW0Lhm20JwpUk
         hljGXAiz0FVPA+/ewzixYk7Lne1g3Ftb2IfAbFcgSAUs3EWzksct+gbqo7jSHNr3mb
         Yay3+LhYczy+Scvap9/LnERV3X15Xsi1ep0QIFcB8zLGFz4o9U+IFIE8GV4ExJDms/
         aJUuRB6ls5zmw==
Received: by mail-wm1-f47.google.com with SMTP id n185so3825667wmn.4
        for <linux-cifs@vger.kernel.org>; Mon, 13 Jun 2022 18:09:04 -0700 (PDT)
X-Gm-Message-State: AOAM533sa1zoryhi94zlCL16Ob6qAlUSO9Y8vouREGuq9Lod9Y9PwqBC
        FmplatbkYNqJqXF38SbL57McncCmlWOZYYzl52k=
X-Google-Smtp-Source: ABdhPJx1+3ykOCUisJrIHGuXELuwPyO2wJ2ufKiwmzF6CJshY/CkDezPAHU0Qy9t9Zi+S/nnwnrwMdC3R0quixMyd7g=
X-Received: by 2002:a05:600c:1553:b0:39c:8873:e241 with SMTP id
 f19-20020a05600c155300b0039c8873e241mr1473871wmg.9.1655168942876; Mon, 13 Jun
 2022 18:09:02 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a5d:4c4a:0:0:0:0:0 with HTTP; Mon, 13 Jun 2022 18:09:02
 -0700 (PDT)
In-Reply-To: <20220613232550.85071-1-hyc.lee@gmail.com>
References: <20220613232550.85071-1-hyc.lee@gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 14 Jun 2022 10:09:02 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8rzSzufJTd8oJyNEH-fr0T2=iGO2RvjAOwJPjQVUvaYA@mail.gmail.com>
Message-ID: <CAKYAXd8rzSzufJTd8oJyNEH-fr0T2=iGO2RvjAOwJPjQVUvaYA@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: remove duplicate flag set in smb2_write
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

2022-06-14 8:25 GMT+09:00, Hyunchul Lee <hyc.lee@gmail.com>:
> The writethrough flag is set again if
> is_rdma_channel is false.
>
> Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
