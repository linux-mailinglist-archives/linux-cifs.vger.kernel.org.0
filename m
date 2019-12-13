Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4430311DB1A
	for <lists+linux-cifs@lfdr.de>; Fri, 13 Dec 2019 01:25:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731313AbfLMAZg (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 12 Dec 2019 19:25:36 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33339 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731326AbfLMAZg (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 12 Dec 2019 19:25:36 -0500
Received: by mail-lf1-f65.google.com with SMTP id n25so655550lfl.0
        for <linux-cifs@vger.kernel.org>; Thu, 12 Dec 2019 16:25:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=NK7K/MtOkBr8pC/9zl/kfIGDuDFh4Hl1P4xL5LLt4Bo=;
        b=hatYQCcbUIbdmfin7bcKpEVNGo/Qk9qsXlo3kg5GnOzWwhEjJlmekeL7O4Zs28uO7g
         u1z/Ho+EQZCgcTMUNnWiNmg2L3nIqx6f2jMA1LAo/+oK2zAn2AqolRaMLsZAgsV421S1
         Rp3MomVto4zc8SgbrXHi6+3Mna8/HokNVtwS176kfVxrcMLE90EXlX07dp+vlSOgvwpa
         nTJ4bqZCgLqG12nEGISErChJG44htlS8sE704LuQPqm9zeFLQPPF7ZxWMA2UGBYYyYU3
         S5I2+x0YFcEVBUkSqXQrohUjUAXP/g2LxwABmj6N1ai38zBhYnGH7W5EzUTjFczFHiZR
         /HVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=NK7K/MtOkBr8pC/9zl/kfIGDuDFh4Hl1P4xL5LLt4Bo=;
        b=HOl6LaJGfjiLIsMIafDZtkE9UQufOcplTccvAM7dACwxxa/FCeQvCO2Ljp8kpGsDny
         lc5uEgsOaSe7NZpVwbNEsNY5woxAIxy/xWx69lvNSb1TvVdd/TeAlcRMRXn+0uHtBF26
         cbmapbQgr2rkS4mCfCsDdp3Dz/ofj0NDyoLx2q9SS5znzl8uMTW8Kbr3rwzyCrTe6m7G
         DQLuhjMgw9QIdOMy4C06hwt26YlcmDxzSQ71y9VBO0AlGq8jf/tgVdk9HWQQ/FG6D3/d
         3H80suwrWn4UPxBVkM7FNipJMbzIdsUB9DbcNQRPr/JJr7omuEbhJcITsDR1Tqy53iuf
         ho5w==
X-Gm-Message-State: APjAAAVJHaBpUMhb5esIfydjEIV/VfywzajdIFeQD2NwGLEHyWWeWu9T
        YMe0lmGHtIM/2eZQsDWTjOKxrtAQdj619gdp8Q==
X-Google-Smtp-Source: APXvYqzD+gm7UhelJNFMh8nGN5Pdg3As6yB/tFHyxGL8gRWREBi08Ul8HpQxPfwyZtYGp98MdWFF8fw43X8kljj6NZg=
X-Received: by 2002:a19:c697:: with SMTP id w145mr7111959lff.54.1576196734632;
 Thu, 12 Dec 2019 16:25:34 -0800 (PST)
MIME-Version: 1.0
References: <20191014170625.21643-1-aaptel@suse.com>
In-Reply-To: <20191014170625.21643-1-aaptel@suse.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Thu, 12 Dec 2019 16:25:23 -0800
Message-ID: <CAKywueRyhs86UfqaXf5ByYLYAB6RxWM5GZSidkgC-2cXhKenOw@mail.gmail.com>
Subject: Re: [PATCH 1/2] smbinfo.rst: document new `keys` command
To:     Aurelien Aptel <aaptel@suse.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

=D0=BF=D0=BD, 14 =D0=BE=D0=BA=D1=82. 2019 =D0=B3. =D0=B2 10:06, Aurelien Ap=
tel <aaptel@suse.com>:
>
> Signed-off-by: Aurelien Aptel <aaptel@suse.com>
> ---
>  smbinfo.rst | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/smbinfo.rst b/smbinfo.rst
> index c8f76e6..7413849 100644
> --- a/smbinfo.rst
> +++ b/smbinfo.rst
> @@ -90,6 +90,10 @@ COMMAND
>  - File types
>  - File flags
>
> +`keys`: Dump session id, encryption keys and decryption keys so that
> +the SMB3 traffic of this mount can be decryped e.g. via wireshark
> +(requires root).
> +
>  *****
>  NOTES
>  *****
> --
> 2.16.4
>

Merged, thanks.
--
Best regards,
Pavel Shilovsky
