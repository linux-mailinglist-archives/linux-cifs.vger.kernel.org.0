Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 078D04C7A39
	for <lists+linux-cifs@lfdr.de>; Mon, 28 Feb 2022 21:24:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiB1UXo (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 28 Feb 2022 15:23:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiB1UXn (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 28 Feb 2022 15:23:43 -0500
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0CC155BD3
        for <linux-cifs@vger.kernel.org>; Mon, 28 Feb 2022 12:23:01 -0800 (PST)
Received: by mail-ej1-x62e.google.com with SMTP id d10so27165922eje.10
        for <linux-cifs@vger.kernel.org>; Mon, 28 Feb 2022 12:23:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Rhevy6fb5H45VxDHjLDNCxtPhjJ0u7uFLdfSx9pxlIs=;
        b=SFiiDaskyFzzbW4jCoUqiJYglpNWscp1lwtLHE93w8dRI3h8eXZkrLgebAKqQfA9oZ
         haXikdZXvfEB810zRURGwChdn/CvMC8Q7Pab3hpE0iVI/nf3FVJvcryQMcC1uZhcoZUU
         P6IZH9h2w6s9V+B5fc5q6pR5l/tJkcQrm5JJ0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Rhevy6fb5H45VxDHjLDNCxtPhjJ0u7uFLdfSx9pxlIs=;
        b=xWoPWz5a5xrehtgui9Ht3fuhutaqsyIoOHuxUYsE2HqSkxrI4ftbaOa2Xr9RBAuB01
         +5mqF63ExNkX5Leh6pIp4nMw/kL7wkJ7VIYgmS/O2mOFVdiMns4fbPjJ2x6lQfkBHvDs
         1HxrM39oh1kKPW2gkYcJiUS9kOL0yQRMrJ13hw3igJEgONf0JJ3ge2hqaArzM2oOpIQ6
         RDr6474tjshpiskgIgRxdYjoT0aw1zHEpWz7oJzLxBpKJMbcUSFqDWW+VTOWBIQdVWvA
         8ErDJLLXY0fanGfjv3LQGqIoBU3PUYv7YscqfmydwVBylN+KcGxZXplHdBY8i6sN9wFh
         deOQ==
X-Gm-Message-State: AOAM533ubMf1h1KzUjua6jP0fhTc7pU3E/DCgzd7Mec5vsPRpmSYYtMy
        7yghVe9uqavKXlwiguUXaCDeGOTOknLMccNqb4U=
X-Google-Smtp-Source: ABdhPJy0sAdTeRrLVf6NniVPfk+bFB95IYAIE9lFHEvQLPXchdDM7HZHKlkO2U2MD4e1ufiXSfPHow==
X-Received: by 2002:a17:906:8a58:b0:6ce:b104:6af5 with SMTP id gx24-20020a1709068a5800b006ceb1046af5mr16592113ejc.732.1646079780174;
        Mon, 28 Feb 2022 12:23:00 -0800 (PST)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id t2-20020aa7d702000000b0040f6617cc10sm6505681edq.89.2022.02.28.12.22.59
        for <linux-cifs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 28 Feb 2022 12:22:59 -0800 (PST)
Received: by mail-ej1-f42.google.com with SMTP id dr20so2484278ejc.6
        for <linux-cifs@vger.kernel.org>; Mon, 28 Feb 2022 12:22:59 -0800 (PST)
X-Received: by 2002:a2e:924d:0:b0:246:370c:5618 with SMTP id
 v13-20020a2e924d000000b00246370c5618mr15110351ljg.358.1646079300900; Mon, 28
 Feb 2022 12:15:00 -0800 (PST)
MIME-Version: 1.0
References: <20220228110822.491923-1-jakobkoschel@gmail.com>
 <20220228110822.491923-3-jakobkoschel@gmail.com> <2e4e95d6-f6c9-a188-e1cd-b1eae465562a@amd.com>
 <CAHk-=wgQps58DPEOe4y5cTh5oE9EdNTWRLXzgMiETc+mFX7jzw@mail.gmail.com>
 <CAHk-=wj8fkosQ7=bps5K+DDazBXk=ypfn49A0sEq+7-nZnyfXA@mail.gmail.com> <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
In-Reply-To: <CAHk-=wiTCvLQkHcJ3y0hpqH7FEk9D28LDvZZogC6OVLk7naBww@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 28 Feb 2022 12:14:44 -0800
X-Gmail-Original-Message-ID: <CAHk-=wj27SZQ3kPTesBzkiGhe-mA3gOQqr_adt_bMFzmg1VNaA@mail.gmail.com>
Message-ID: <CAHk-=wj27SZQ3kPTesBzkiGhe-mA3gOQqr_adt_bMFzmg1VNaA@mail.gmail.com>
Subject: Re: [PATCH 2/6] treewide: remove using list iterator after loop body
 as a ptr
To:     =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        alsa-devel@alsa-project.org, linux-aspeed@lists.ozlabs.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-iio@vger.kernel.org, nouveau@lists.freedesktop.org,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        Cristiano Giuffrida <c.giuffrida@vu.nl>,
        amd-gfx list <amd-gfx@lists.freedesktop.org>,
        samba-technical@lists.samba.org,
        linux1394-devel@lists.sourceforge.net, drbd-dev@lists.linbit.com,
        linux-arch <linux-arch@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        KVM list <kvm@vger.kernel.org>,
        linux-scsi <linux-scsi@vger.kernel.org>,
        linux-rdma <linux-rdma@vger.kernel.org>,
        linux-staging@lists.linux.dev, "Bos, H.J." <h.j.bos@vu.nl>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        intel-wired-lan@lists.osuosl.org,
        kgdb-bugreport@lists.sourceforge.net,
        bcm-kernel-feedback-list@broadcom.com,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        Kees Cook <keescook@chromium.org>,
        Arnd Bergman <arnd@arndb.de>,
        Linux PM <linux-pm@vger.kernel.org>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        Brian Johannesmeyer <bjohannesmeyer@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        v9fs-developer@lists.sourceforge.net,
        linux-tegra <linux-tegra@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-sgx@vger.kernel.org,
        linux-block <linux-block@vger.kernel.org>,
        Netdev <netdev@vger.kernel.org>, linux-usb@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux F2FS Dev Mailing List 
        <linux-f2fs-devel@lists.sourceforge.net>,
        tipc-discussion@lists.sourceforge.net,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        dma <dmaengine@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Andrew Morton <akpm@linux-foundation.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Mike Rapoport <rppt@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Mon, Feb 28, 2022 at 12:10 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> We can do
>
>         typeof(pos) pos
>
> in the 'for ()' loop, and never use __iter at all.
>
> That means that inside the for-loop, we use a _different_ 'pos' than outside.

The thing that makes me throw up in my mouth a bit is that in that

        typeof(pos) pos

the first 'pos' (that we use for just the typeof) is that outer-level
'pos', IOW it's a *different* 'pos' than the second 'pos' in that same
declaration that declares the inner level shadowing new 'pos'
variable.

If I was a compiler person, I would say "Linus, that thing is too ugly
to live", and I would hate it. I'm just hoping that even compiler
people say "that's *so* ugly it's almost beautiful".

Because it does seem to work. It's not pretty, but hey, it's not like
our headers are really ever be winning any beauty contests...

                Linus
