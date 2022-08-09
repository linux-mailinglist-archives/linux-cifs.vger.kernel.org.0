Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C57A958D1E5
	for <lists+linux-cifs@lfdr.de>; Tue,  9 Aug 2022 04:10:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiHICKn (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 8 Aug 2022 22:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234163AbiHICG1 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 8 Aug 2022 22:06:27 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4723F1BE93
        for <linux-cifs@vger.kernel.org>; Mon,  8 Aug 2022 19:06:26 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id l4so12749562wrm.13
        for <linux-cifs@vger.kernel.org>; Mon, 08 Aug 2022 19:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=FABDv85tGTWhH1lOcerQEg81catxTbmKNhI0usVruF4=;
        b=gFF9ZEgpWGcNXj1ywscLuWLgpsVGwcfk8NT86/+O0/GEN1HfuN9/nKHuNP8LHyWB4q
         qevOL9PKEa14Fc3Z/+6PR9jdFEt321j/R9CoRGO+PLsOmMQa/87uprhAFw9RWAfH9Hky
         iHlK6V0edGmgLGUxjaAnaiefN3Pdd+WMO3oMQUKubdK5UT0lunSmZHllEBsPPfNVPhv7
         x76/xxJ+7/zTnolHrzdbdSO8Tt+DqnxLoyc8f/gYWbt8iMg6ZREQ5499v+QzlSCG+6+j
         k3b2VEYRaIMZQWvL91JLfLSZHnsttBObWyt6b0d8vPdEoBu4BcF6bSwDZyE45HkkEwYf
         vsFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=FABDv85tGTWhH1lOcerQEg81catxTbmKNhI0usVruF4=;
        b=wlTyAGC7e/UyNiKJu/mj9lM+GB+YcU8hSnO4e/nG5fmYyxAbKdh8TiL7rm5arL5WA5
         RPXyndvRwJR6DL7OpY/83GfU8GIrxM/oxDCg5lLHZO6ousKbQ8AiDPK22uQ+lTxTU378
         nR4LCLJjYDZJp+wsRywpyrLOHodf9zQMwMd1D0NZZSrVDhIsP4B13TfphBRutAUOwZH6
         1CA+b7qhNaauwBC8/QT+txb90tlTEEpIor8dbHuhtvd7vLhcRyNqlEXwapwGaF9ZdEGg
         xNH6skx8NgsBjUlghSlpn/eO8g+mYpwFGQ7qL1kZty2KSWjSJljd6UXO4QKyRZUk49P1
         9rDQ==
X-Gm-Message-State: ACgBeo0y3J3nrt9qMzFKYciE/JH27pkmTMwFEMIctitfpX0khpW1NFnL
        Ic44/HKeTPC97Ib1gHWDWU/YWpgpyZsl8i+79fY=
X-Google-Smtp-Source: AA6agR7enNGnTzYp7BKBuRJ52zc5gS9uTN5NYXJlKo0Aycow/pEgfvQGi/OvFaH+tjVe4dpACo9BWY9WENIDzBIT3CA=
X-Received: by 2002:a05:6000:15c5:b0:220:727a:24bf with SMTP id
 y5-20020a05600015c500b00220727a24bfmr13303352wry.621.1660010784866; Mon, 08
 Aug 2022 19:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220808125648.10919-1-linkinjeon@kernel.org>
In-Reply-To: <20220808125648.10919-1-linkinjeon@kernel.org>
From:   Hyunchul Lee <hyc.lee@gmail.com>
Date:   Tue, 9 Aug 2022 11:06:13 +0900
Message-ID: <CANFS6banXVvi1O3WX7maBujz0HvUbsT7H-Qun3GETHme8HvhYA@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: return STATUS_BAD_NETWORK_NAME error status if
 share is not configured
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-cifs@vger.kernel.org, smfrench@gmail.com,
        senozhatsky@chromium.org, atteh.mailbox@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

2022=EB=85=84 8=EC=9B=94 8=EC=9D=BC (=EC=9B=94) =EC=98=A4=ED=9B=84 9:57, Na=
mjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> If share is not configured in smb.conf, smb2 tree connect should return
> STATUS_BAD_NETWORK_NAME instead of STATUS_BAD_NETWORK_PATH.
>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>

Reviewed-by: Hyunchul Lee <hyc.lee@gmail.com>

> ---
>  fs/ksmbd/mgmt/tree_connect.c | 2 +-
>  fs/ksmbd/smb2pdu.c           | 3 ++-
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/fs/ksmbd/mgmt/tree_connect.c b/fs/ksmbd/mgmt/tree_connect.c
> index b35ea6a6abc5..dd262daa2c4a 100644
> --- a/fs/ksmbd/mgmt/tree_connect.c
> +++ b/fs/ksmbd/mgmt/tree_connect.c
> @@ -19,7 +19,7 @@ struct ksmbd_tree_conn_status
>  ksmbd_tree_conn_connect(struct ksmbd_conn *conn, struct ksmbd_session *s=
ess,
>                         char *share_name)
>  {
> -       struct ksmbd_tree_conn_status status =3D {-EINVAL, NULL};
> +       struct ksmbd_tree_conn_status status =3D {-ENOENT, NULL};
>         struct ksmbd_tree_connect_response *resp =3D NULL;
>         struct ksmbd_share_config *sc;
>         struct ksmbd_tree_connect *tree_conn =3D NULL;
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index 4c3c840df455..d478c3ea4215 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -1944,8 +1944,9 @@ int smb2_tree_connect(struct ksmbd_work *work)
>                 rsp->hdr.Status =3D STATUS_SUCCESS;
>                 rc =3D 0;
>                 break;
> +       case -ENOENT:
>         case KSMBD_TREE_CONN_STATUS_NO_SHARE:
> -               rsp->hdr.Status =3D STATUS_BAD_NETWORK_PATH;
> +               rsp->hdr.Status =3D STATUS_BAD_NETWORK_NAME;
>                 break;
>         case -ENOMEM:
>         case KSMBD_TREE_CONN_STATUS_NOMEM:
> --
> 2.25.1
>


--=20
Thanks,
Hyunchul
