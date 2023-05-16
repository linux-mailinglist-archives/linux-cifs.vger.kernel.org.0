Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D82E47048F6
	for <lists+linux-cifs@lfdr.de>; Tue, 16 May 2023 11:19:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231509AbjEPJTj (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 16 May 2023 05:19:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231612AbjEPJTd (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 16 May 2023 05:19:33 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DD715266
        for <linux-cifs@vger.kernel.org>; Tue, 16 May 2023 02:19:06 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id 3f1490d57ef6-ba8374001abso180993276.2
        for <linux-cifs@vger.kernel.org>; Tue, 16 May 2023 02:19:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684228735; x=1686820735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G3PO2Pyp97ZMAD2vBcdWWuGlS8wMmQ0Anr89fdT1itg=;
        b=SnLc7z4OusgQkdLJW2gpC1baRzLHCxxry6/C+4UjVFNnTPasnfiPkwK53P1kkgTVdD
         jTKK8ss4OZD8XKjjQq8wY03VJ5Oe5RHDs1yvY8+EOTxoWcJSuTK7C11kpIWmw3gXQJHd
         Lr1Q3yVH/sbUISDc/hPO6XN45n3T4qV7q9AbqbvoF3TF/CKKfgqucw7C9ikJ60JvtEYM
         RZWq8qHyla87xTV8v+o/RkUfgaKOxVyUC2q+zgx1kDfIfEhVq+nmpO3H61poEs9vdGUc
         mOzQj6BxLBs2pa6WpFCON0vyVIFD01vnG8CwRDr7oaC2ucRGNIWDDeoHyor0/J84BNNJ
         GWWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684228735; x=1686820735;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=G3PO2Pyp97ZMAD2vBcdWWuGlS8wMmQ0Anr89fdT1itg=;
        b=WdkLerx2AHiR3y1GnJ5aW8PlVlROEa09Fl8/SiUSfGf8dd3C04cdLggxcef98yP/hW
         4pCJYQhBQ5+8Z787pV/bs9qZD1k8SzETJGnBOGmLly6qfAIi3+48vf08uRst5EyzO+JK
         mfHoYdwUcuqq8lx6p7f6QSNemZLSxWGDffQ6V7c+hTlPxzQcqTrC1PCRGCmBRt41hNnQ
         nDcUS8OwmyWU291Mr1aNokAGEsQ8BkYbFiLHRTRsDBtMeGW8fu8WDpho1DS8YtGnLFs+
         Na5mqwx0PwIh/S9qjwEe14mndwl2RdQTjxmAPmHVcRzsmz6l//PMboTm6S1J+eqwT2sZ
         u1Pw==
X-Gm-Message-State: AC+VfDyHNHxZ0UpNUsoSQW+nurmG1Cs4H++dTnPU8gryxuheqh3WQcgd
        iQftrzZwNSH3SE9CUnKsEV0wZesydm8sajM5oU+sQA==
X-Google-Smtp-Source: ACHHUZ7ouX4pR8enSVuqce0U0lt0Y3WNzSweQexHvE3MJ4CinODJS3Gxe6HEZ3NipwDnbhl+pti8r/LzgvUfPj6ua34=
X-Received: by 2002:a0d:c701:0:b0:556:d4ab:cbe with SMTP id
 j1-20020a0dc701000000b00556d4ab0cbemr34265656ywd.39.1684228735569; Tue, 16
 May 2023 02:18:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230503-virt-to-pfn-v6-4-rc1-v1-0-6c4698dcf9c8@linaro.org>
 <20230503-virt-to-pfn-v6-4-rc1-v1-2-6c4698dcf9c8@linaro.org>
 <CAMuHMdVJjjo9TMeow1-i27ybpQOu9-VZYnTkY5p8p_Cm6sW_GA@mail.gmail.com> <CAMuHMdV5Aukxx+XyC-s2=CDa2BYqvc3uRvWBhD6ri5j09tXj3A@mail.gmail.com>
In-Reply-To: <CAMuHMdV5Aukxx+XyC-s2=CDa2BYqvc3uRvWBhD6ri5j09tXj3A@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 16 May 2023 11:18:43 +0200
Message-ID: <CACRpkdbwd6ELhJVu--=N+Ckjp0MNyG3aWv5B+DQUoXNVFicDfw@mail.gmail.com>
Subject: Re: [PATCH 02/12] m68k: Pass a pointer to virt_to_pfn() virt_to_page()
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Vineet Gupta <vgupta@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Russell King <linux@armlinux.org.uk>,
        Greg Ungerer <gerg@linux-m68k.org>,
        linux-kernel@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
        linux-snps-arc@lists.infradead.org, linux-fsdevel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Fri, May 12, 2023 at 12:26=E2=80=AFPM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:

> Much simpler to drop the cast in __pte_page() instead:
>
> @@ -91,7 +91,7 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newp=
rot)
>  #define pmd_set(pmdp,ptep) do {} while (0)
>
>  #define __pte_page(pte) \
> -((unsigned long) __va ((pte_val (pte) & SUN3_PAGE_PGNUM_MASK) << PAGE_SH=
IFT))
> +        (__va ((pte_val (pte) & SUN3_PAGE_PGNUM_MASK) << PAGE_SHIFT))

Thanks, folded this into the patch!

Yours,
Linus Walleij
