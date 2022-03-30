Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B26D4EB808
	for <lists+linux-cifs@lfdr.de>; Wed, 30 Mar 2022 03:58:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238077AbiC3B7n (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 29 Mar 2022 21:59:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241775AbiC3B7l (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 29 Mar 2022 21:59:41 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20870181B16
        for <linux-cifs@vger.kernel.org>; Tue, 29 Mar 2022 18:57:57 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p10so27446518lfa.12
        for <linux-cifs@vger.kernel.org>; Tue, 29 Mar 2022 18:57:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c9wgvCG6ehSqVvhld+97BlPKmw2SYKXfrIztdHxFD+g=;
        b=fFg2nGAzXQWDFCRiScLnAPEM/iEXBEwfa46BaahhYw8yxYDpAzUyIaUGvBchnnVtJy
         ML1Z2rh1T9miUSPfNlZwNHm+j6vZD7dkf2JlbBGhYKyx6UtQSHj+yh3YmRo1biXJM9gh
         4NMu6QiTlccRHDrrBok1YjlmW+X7h2ELT6Mz8WyrKvRN7uNYPhFymsmWBwYmSqbjHFfh
         AqldBGcYm3zkYUiXZquxtc3/1wNgW2UF/Z3PFiqic96g3nipIPRCnO+262jkuBJ+7zbC
         7dXMxUM3dmqiUyN2LxTL9Mp8F69mb/a6QOF5NGw3r/tW3jkartKG/DUfpTnIPNA/kl4h
         tfQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c9wgvCG6ehSqVvhld+97BlPKmw2SYKXfrIztdHxFD+g=;
        b=0QeUTQ1fTkLqL5ThD2l+b/C13gvBmdZoA85BGfCl57/3fsqS2ni6dNB7GRtjv1uN6o
         gFe8dmXt6v2HPOfVHzlMPVsixcJoY/n/6occv2e1/uE5fQ+SVoTjHkdHAwaDMnrWpjgz
         8cjKKxX4C7At3Q3Lstg8UMF3Y0O/AviAh3Sel2kriHUsZIGgZZgM80w74Kr0osko1nIE
         zYYC5NfEqjiUK6W1IMguxf0b9NJAdJvizxngm/cbLkZy3R8lRS2RvUaFEk071ZjGLIJI
         HStSafpcuzqpAsKNbwgt45i7XyVHAP8z12HAmXJywn9QDJSoZt+IhrVgBWOfbnGLIpvn
         u6xQ==
X-Gm-Message-State: AOAM530sBwEhL0HcgdaxdxtFzY8kKFO1b1eLoCKKJ+OhWCCGhlgJxymC
        XEdVIED/56PM9Shbq20AMumiwemxosjTn+qFGgI=
X-Google-Smtp-Source: ABdhPJz972+rSxlJVotrEg2X2T42xaZWsWCMqJEY4ez7Hiqe24nIPKegazp60jYIKhGSG3gBlm4G1gE+qJuGQ3MER3A=
X-Received: by 2002:a05:6512:3a83:b0:44a:b79:6988 with SMTP id
 q3-20020a0565123a8300b0044a0b796988mr4819812lfu.595.1648605475133; Tue, 29
 Mar 2022 18:57:55 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mvmUjSpb0hPjMguq8aFKi11JUDMN5JADFqxw5xhNDELCA@mail.gmail.com>
 <CAHk-=whvfwQdpHv0E6UmaSeYKRYFL_CmaiGa8beCXdtX93U32w@mail.gmail.com>
In-Reply-To: <CAHk-=whvfwQdpHv0E6UmaSeYKRYFL_CmaiGa8beCXdtX93U32w@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 29 Mar 2022 20:57:44 -0500
Message-ID: <CAH2r5msiQh6mM1o7QFhaaQq9vVqL60z_YyEZzosBcrGsgR2uhA@mail.gmail.com>
Subject: Re: [GIT PULL] ksmbd server fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
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

On Tue, Mar 29, 2022 at 8:49 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Mon, Mar 28, 2022 at 6:39 PM Steve French <smfrench@gmail.com> wrote:
> >
> > - four patches relating to dentry race
<...>
>
> This all makes me _very_ uncomfortable.
>
> I really get the feeling that we'd be much better off exporting
> something that is just a bigger part of that rename logic, not that
> really low-level __lookup_hash() thing.
>
<...>
> I'd be even happier if we could actually hjave some common helper
> starting at that
>
>         trap = lock_rename(...);
>
> because that whole locking and 'trap' logic is kind of a big deal, and
> the locking is the only thing that makes __lookup_hash() work.
>
> Adding Al to the cc in case he has any ideas. Maybe he's ok with this
> whole thing, and with his blessing I'll take this pull as-is, but as
> it is I'm not comfortable with it.

Depending on what Al's opinion is, we can remove those four and resubmit.

Also FYI - I have some cleanup patches for ksmbd/cifs common code
(that will be in the next cifs.ko P/R) that I am holding off
on for a few days to reduce change of merge conflict.


-- 
Thanks,

Steve
