Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A178A591D94
	for <lists+linux-cifs@lfdr.de>; Sun, 14 Aug 2022 04:19:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiHNCTP (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 13 Aug 2022 22:19:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229504AbiHNCTP (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 13 Aug 2022 22:19:15 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B5067285D
        for <linux-cifs@vger.kernel.org>; Sat, 13 Aug 2022 19:19:14 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id b4so2106267wrn.4
        for <linux-cifs@vger.kernel.org>; Sat, 13 Aug 2022 19:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc;
        bh=Wny/XYC1tqjYjbNQX4ifjJDHOXHHZF0E6BuSBTsheGI=;
        b=qlsRT+1jPkHxiGW266bMEZqgm7sUtK0/BFJ4sPEs/g7X48O5X4YrDIgkpfsrohOTKk
         BoO0EVoIuDZg7Bg4lPmbUn2+AyJDlNkdL5I5U53mG87O+zt4dbT4Sp1alsSGKg4sFVol
         QqFH4aDo4pJSm5rOdXArVSUvJ4Y4CYPLug2kkmYGLlSweieoKsHv505bTrNn7jMBaSy2
         vkfsisf2H6yQb4qeRATVhG51IpW1/pOnAzLXcgsslp+24lIJzKzpTbfa5ZV0NikGVedG
         YjbGcMIc6StY2v109cM/mOYkXUTqmvwmtqYRutTDaX5eCyItHWqHHV8Nrc4hTsGs3+Gx
         0MwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
        bh=Wny/XYC1tqjYjbNQX4ifjJDHOXHHZF0E6BuSBTsheGI=;
        b=gz+hx2koYFhPmoRzb8umQWoSaRKMGZ8qPztoQjuD9KZAuxzi44NrndR5fYp60blHUc
         Ys2INwORxi3DPTow8yfK+qbxiL7+RLi+8+r3TLqiyXqF6jQUj16yc1CgAjrKCXQqtqZI
         EyU6bxckEaznjZjg8YNMvAvEbkc6dUVDxSfw3qlgkOfOfHa6lb2RSc6KWwUle1JM7aa/
         2fx8jcRUA6xYQ7Dub7coYfC+kRblopldYjPahcwFKWEHcrsOdoIskHJVKpr8olt7eg89
         5pXOOd67dIGckniKbKxv3uUASf7fAQ+Nr1d3RSHbtU/jlh6XcU+eQbJ5JwDMXm3gXYCR
         nGZw==
X-Gm-Message-State: ACgBeo0F+7jjhs0zBRoJJGhaxSOYeIjWYarAyAxc4bh7RUYzxUwK77hE
        lKRUsBoMJySYm5iPV70DAqt+wOrxFeDI4FmxQu8=
X-Google-Smtp-Source: AA6agR4kkeVz9I4Bo2Tdw134Qct8sW+eJjrqA/r9Noxc4WZOsrfDWL2xs42CAK2lO5aByE5gQVk74aP1PG19cekg7B8=
X-Received: by 2002:a5d:63ce:0:b0:21e:cdbc:7dc0 with SMTP id
 c14-20020a5d63ce000000b0021ecdbc7dc0mr5205227wrw.136.1660443552810; Sat, 13
 Aug 2022 19:19:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220812025614.5673-1-linkinjeon@kernel.org>
In-Reply-To: <20220812025614.5673-1-linkinjeon@kernel.org>
From:   Hyunchul Lee <hyc.lee@gmail.com>
Date:   Sun, 14 Aug 2022 11:19:01 +0900
Message-ID: <CANFS6bYChCrTQHT6NKvpBX1PEuWPX1CYH_Z5TpGGgdMswV-dFw@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: don't remove dos attribute xattr on O_TRUNC open
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     linux-cifs@vger.kernel.org, smfrench@gmail.com,
        senozhatsky@chromium.org
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

2022=EB=85=84 8=EC=9B=94 12=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 11:56, =
Namjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
> When smb client open file in ksmbd share with O_TRUNC, dos attribute
> xattr is removed as well as data in file. This cause the FSCTL_SET_SPARSE
> request from the client fails because ksmbd can't update the dos attribut=
e
> after setting ATTR_SPARSE_FILE. And this patch fix xfstests generic/469
> test also.
>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/ksmbd/smb2pdu.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index b5c36657ecfd..0c2e57397dd2 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -2330,9 +2330,7 @@ static int smb2_remove_smb_xattrs(struct path *path=
)
>                         name +=3D strlen(name) + 1) {
>                 ksmbd_debug(SMB, "%s, len %zd\n", name, strlen(name));
>
> -               if (strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_LE=
N) &&
> -                   strncmp(&name[XATTR_USER_PREFIX_LEN], DOS_ATTRIBUTE_P=
REFIX,
> -                           DOS_ATTRIBUTE_PREFIX_LEN) &&
> +               if (!strncmp(name, XATTR_USER_PREFIX, XATTR_USER_PREFIX_L=
EN) &&
>                     strncmp(&name[XATTR_USER_PREFIX_LEN], STREAM_PREFIX, =
STREAM_PREFIX_LEN))
>                         continue;
>

We don't need to exclude security.*, trusted.*, system.* from deletion?

> --
> 2.25.1
>


--=20
Thanks,
Hyunchul
