Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD4F41814E
	for <lists+linux-cifs@lfdr.de>; Wed,  8 May 2019 22:47:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726906AbfEHUrF (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 8 May 2019 16:47:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:34810 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726809AbfEHUrE (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 8 May 2019 16:47:04 -0400
Received: by mail-lj1-f196.google.com with SMTP id s7so123889ljh.1
        for <linux-cifs@vger.kernel.org>; Wed, 08 May 2019 13:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wl7kj2b06Id0IxhmFMyLAcUIYwHokUW4lI1UxzzHebQ=;
        b=MsCQeMlAMaTmmu8liuRJhw+OqSjOca9Yk5ZDE0pnUCLgqqGXwt4Eikr9dYZgUYu5Jn
         j2QcOzHlWVto3PMTTHCuxunWuX0TtJT7Iaw65vU84UEVIKAjU+Vmn4PXRVoqwYuqwxUC
         AByIFENIWIymm8SeSM3zdJOt7V8lGp1b7jec4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wl7kj2b06Id0IxhmFMyLAcUIYwHokUW4lI1UxzzHebQ=;
        b=Ce7SCBokKWXiW67+BDcn1s1fsMjl3QCcygHB51cPUdusB8c2RPe2PC2r/FnBNy80hf
         Zc31vXA876tAQsVjvbRrBU/1/3oZW1GWuMZCtcRylLp8+OuWuVtYTEkDFfg90zeg6Oxb
         ImldAim+gmNRMDf6ncxjKrpoQnCHVbGuB16deDYXgJp+3IOGXaMUoKQw6zpw1l6PuRd5
         XNhwVCwQgpF06yUhz+fD8wp150xFpME4HlBM/2ikPxiE4EK6CUhh310DgRGU8CHpYD5Q
         tyogmYI4dYmYc6dP8ETqVJp8IqVvaMJIlmbmtr3aRI9D79UjitvhGuXY9Oa8IL/cVlgB
         c32g==
X-Gm-Message-State: APjAAAXKoEO6o5hlDW4uMU6gY+es6PE5seJQRDB6FqwCJjk/OF5ZC07M
        4vl91peVlYmNvYjMAneoSOmrtnv0UvY=
X-Google-Smtp-Source: APXvYqzbxHX/KXe56a9CA2zpa8qh2ahaBAD+b61QXOuFNpdzTkV0Mkk23T1gIek4ijPbTWY9zSmrDQ==
X-Received: by 2002:a2e:28d:: with SMTP id y13mr8733695lje.177.1557348422353;
        Wed, 08 May 2019 13:47:02 -0700 (PDT)
Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com. [209.85.208.174])
        by smtp.gmail.com with ESMTPSA id k15sm4242768lje.21.2019.05.08.13.47.01
        for <linux-cifs@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 08 May 2019 13:47:01 -0700 (PDT)
Received: by mail-lj1-f174.google.com with SMTP id 188so84306ljf.9
        for <linux-cifs@vger.kernel.org>; Wed, 08 May 2019 13:47:01 -0700 (PDT)
X-Received: by 2002:a2e:9044:: with SMTP id n4mr7056458ljg.94.1557348420782;
 Wed, 08 May 2019 13:47:00 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mv=4JsaF-8v=U4JR3jrOyPfhtUsJPogNudLejDh09xGSA@mail.gmail.com>
 <CAHk-=wiKoePP_9CM0fn_Vv1bYom7iB5N=ULaLLz7yOST3K+k5g@mail.gmail.com>
In-Reply-To: <CAHk-=wiKoePP_9CM0fn_Vv1bYom7iB5N=ULaLLz7yOST3K+k5g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 8 May 2019 13:46:44 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiZd2cLsobjBWU6_YZo2RWWqAm_fVzLpPQsh+yoG7fk-w@mail.gmail.com>
Message-ID: <CAHk-=wiZd2cLsobjBWU6_YZo2RWWqAm_fVzLpPQsh+yoG7fk-w@mail.gmail.com>
Subject: Re: [GIT PULL] CIFS/SMB3 fixes
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Wed, May 8, 2019 at 1:37 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> So don't do the whole "rebase the day before" in the first place, but
> *DEFINITELY* don't do it when you then pick a random and bad point to
> rebase things on top of!

I've pulled, but I really hope this never happens again.

You could have rebased your work on top of 5.1 if you needed to.

Or you could have just tried to avoid rebasing in the first place.

But picking a random commit that was the top-of-the-tree on the second
day of the merge window (pretty much when things are at their most
chaotic) is just about the worst thing you can do.

I'm considering adding some automation to my pull requests to warn
about craziness like this. Because maybe you've consistently done
something like this in the past, and I've just not noticed how crazy
the pull request was.

               Linus
