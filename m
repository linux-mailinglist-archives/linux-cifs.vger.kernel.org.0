Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88188164E79
	for <lists+linux-cifs@lfdr.de>; Wed, 19 Feb 2020 20:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726735AbgBSTHt (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 19 Feb 2020 14:07:49 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40280 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726613AbgBSTHs (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 19 Feb 2020 14:07:48 -0500
Received: by mail-lf1-f68.google.com with SMTP id c23so994323lfi.7
        for <linux-cifs@vger.kernel.org>; Wed, 19 Feb 2020 11:07:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PW7lNRLaUwWMkxjmDviGmCx98DZMFUxSA3+XY1xBUHc=;
        b=Hx1j/CCXthRsFcYUkCqUCZKHuALKrv53PhNO0/eSPdI55ETBuvMT4Bzt7Qa//aT+Xq
         pbz3LbAT0K7mf2O2wl4T+6nDRq33OiFGxtJRkEnoPAzmD/q8ILz+w8fB+i5OEbDM4aTv
         V5D7jcX/IJAfFXSwG3AgccJqFA6k9pBx+DkqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PW7lNRLaUwWMkxjmDviGmCx98DZMFUxSA3+XY1xBUHc=;
        b=D/ca+XBae4DueBZ0AF6spQpd93L69pQPzP8UemKGzoR7pge3x94PW9EA/k1nNKNZtw
         IcL13LUU1VX61Knp+NhSJyXZt3yHg21RyaexUi08EsCFtbXNN1wtzSGkBfReXYHEWLaN
         c8s+XEahDSct9V5Lf6gDSNCQt6x9M5xZjiKrRU169sLjpcyY/BBQ2nsc1Q/FWHf7Hagl
         yA90j5x2LQRZb4QYVIf3GftGG8jNqGkrPBINtz2KLmCv0yxmQdEdk4t6UOUjmBe6+w50
         E3PRxEDaD76MIWtvBDzLEIr2s8qP64x1Deo4fXa2hlDSsNWoFKiEHNVdY1qygUfr+Fxn
         yKRQ==
X-Gm-Message-State: APjAAAXuxXqyeSwYLOAI1VIrV2JWMoyMlqSP73WuLG0FtPmVolemjyLI
        kn8kSMJ9dJrrv3GyYM7qLcCZN2AWNtY=
X-Google-Smtp-Source: APXvYqxxhX0QBxaeGSJQISkovRAt4DEhXeRFq0105JVoNa1Tp2dY1PYo/gE2DhxyOmN1qz83MhjoFA==
X-Received: by 2002:a19:4cc6:: with SMTP id z189mr13754462lfa.171.1582139266231;
        Wed, 19 Feb 2020 11:07:46 -0800 (PST)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id t27sm330186ljd.26.2020.02.19.11.07.44
        for <linux-cifs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Feb 2020 11:07:45 -0800 (PST)
Received: by mail-lf1-f45.google.com with SMTP id c23so994251lfi.7
        for <linux-cifs@vger.kernel.org>; Wed, 19 Feb 2020 11:07:44 -0800 (PST)
X-Received: by 2002:a05:6512:687:: with SMTP id t7mr14685091lfe.30.1582139264476;
 Wed, 19 Feb 2020 11:07:44 -0800 (PST)
MIME-Version: 1.0
References: <158212290024.224464.862376690360037918.stgit@warthog.procyon.org.uk>
 <CAMuHMdV+H0p3qFV=gDz0dssXVhzd+L_eEn6s0jzrU5M79_50HQ@mail.gmail.com>
 <227117.1582124888@warthog.procyon.org.uk> <CAHk-=wjFwT-fRw0kH-dYS9M5eBz3Jg0FeUfhf6VnGrPMVDDCBg@mail.gmail.com>
 <241568.1582134931@warthog.procyon.org.uk> <CAHk-=wi=UbOwm8PMQUB1xaXRWEhhoVFdsKDSz=bX++rMQOUj0w@mail.gmail.com>
In-Reply-To: <CAHk-=wi=UbOwm8PMQUB1xaXRWEhhoVFdsKDSz=bX++rMQOUj0w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 19 Feb 2020 11:07:28 -0800
X-Gmail-Original-Message-ID: <CAHk-=whfoWHvL29PPXncxV6iprC4e_m6CQWQJ1G4-JtR+uGVUA@mail.gmail.com>
Message-ID: <CAHk-=whfoWHvL29PPXncxV6iprC4e_m6CQWQJ1G4-JtR+uGVUA@mail.gmail.com>
Subject: Re: [RFC PATCH] vfs: syscalls: Add create_automount() and remove_automount()
To:     David Howells <dhowells@redhat.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Al Viro <viro@zeniv.linux.org.uk>, coda@cs.cmu.edu,
        linux-afs@lists.infradead.org, CIFS <linux-cifs@vger.kernel.org>,
        "open list:NFS, SUNRPC, AND..." <linux-nfs@vger.kernel.org>,
        linux-btrfs <linux-btrfs@vger.kernel.org>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Wed, Feb 19, 2020 at 10:55 AM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> Why don't you just use mkdir with S_ISVTX set, or something like that?

Actually, since this is apparently a different filetype, the _logical_
thing to do is to use "mknod()".

Yes, yes, it will require a new case (and maybe a per-filesystem
callback or a flag or something) in "may_mknod()" and "do_mknodat()"
to let those new kinds through, but it sounds like mknod() is actually
what you're doing.

You presumably need a new type _anyway_ for stat() and/or the filldir
d_type field. Or do you always want to make it look exactly like a
directory to all user space?

                  Linus
