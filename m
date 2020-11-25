Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B75012C3589
	for <lists+linux-cifs@lfdr.de>; Wed, 25 Nov 2020 01:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727329AbgKYAca (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 24 Nov 2020 19:32:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726805AbgKYAca (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 24 Nov 2020 19:32:30 -0500
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDA17C0613D6;
        Tue, 24 Nov 2020 16:32:29 -0800 (PST)
Received: by mail-qk1-x742.google.com with SMTP id x25so81283qkj.3;
        Tue, 24 Nov 2020 16:32:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QqqubA90NyDjnD5SH+OxnZbso0TzlLiuZ5gzRUm0zsY=;
        b=DYdo15DH5n4eMCA51W2vXZfybVLPbTpwO6CR+j1CET94cx9FmUQEkAzz4OadVdmrht
         /5QscdfYh1sAKLvu6dkrheNjvEoR4Mdvvl3diWkBzFiGJNP9BCqxLhr4zTkKEaaVMxi5
         qUA6kNkUTJzI9KEPxIujLpbBVVOhJKSQSAf+FeTM6jY84RGcXl9jGks4AfD2ojo1GxQQ
         uEwHm9wuAxdOf70IRL+AXs8sujZOQd+kSEI1eU2QAsFia5W6QaIddZOITngYX9DSKM5R
         mNvBJUTqyzODtQONxErP8O8dRkCcVm25oDOfEuyrse782pSy0gFJjFFgzHOgMIi8mZem
         jSGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QqqubA90NyDjnD5SH+OxnZbso0TzlLiuZ5gzRUm0zsY=;
        b=snqjE+pgbH+a6/A7jPlUdXy2whhW302EjrjCMPv8wi67+5UYB1mcpxLsEMa2AwWdgE
         Z3ogb3mnS6cm39pBmugB8Yyu3qPz760xuqoEdTA1d8tmPLlwAVAV87k5lE6QwmJQRd9e
         bUxQIDg/Aaoiuj5RrObJi3RhJzwmp+x9jUs2l/R/QX5GALJ5ha3cBth6BWrqbsnY+SlQ
         9oM5wRkqwL45XieMtADalKIGCusgMlLWbdZl9/yyhUjSbsPmZba8gE28h7YJsD1zRePl
         9PJZy42UDve6Tl95p/M8loj5o0/C+9jo+P8wdQPCB7Hs234mYNhFWxcaapjdhHr5aCdM
         iBSQ==
X-Gm-Message-State: AOAM532bS9JGxvfssjcio/Twt5CRLZKuxDtn69ZFpXhjuvaRA8Ki9on5
        /J2Dw0UU4S5F0wRU7qA4z43bOMQibjftG4sZpvQ=
X-Google-Smtp-Source: ABdhPJwwVKQFQuxzNO/2Mi/lJ3RUII3vPq9FIwhq+sZ6y3vyBbFPDKm/uCaEGwo9LU3j1fjBVCpYTO563lD14rGXSok=
X-Received: by 2002:a25:5f0f:: with SMTP id t15mr779915ybb.26.1606264348932;
 Tue, 24 Nov 2020 16:32:28 -0800 (PST)
MIME-Version: 1.0
References: <cover.1605896059.git.gustavoars@kernel.org> <20201120105344.4345c14e@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011201129.B13FDB3C@keescook> <20201120115142.292999b2@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <202011220816.8B6591A@keescook> <9b57fd4914b46f38d54087d75e072d6e947cb56d.camel@HansenPartnership.com>
 <CANiq72nZrHWTA4_Msg6MP9snTyenC6-eGfD27CyfNSu7QoVZbw@mail.gmail.com>
 <1c7d7fde126bc0acf825766de64bf2f9b888f216.camel@HansenPartnership.com>
 <CANiq72m22Jb5_+62NnwX8xds2iUdWDMAqD8PZw9cuxdHd95W0A@mail.gmail.com>
 <fc45750b6d0277c401015b7aa11e16cd15f32ab2.camel@HansenPartnership.com>
 <CANiq72k5tpDoDPmJ0ZWc1DGqm+81Gi-uEENAtvEs9v3SZcx6_Q@mail.gmail.com> <4993259d01a0064f8bb22770503490f9252f3659.camel@HansenPartnership.com>
In-Reply-To: <4993259d01a0064f8bb22770503490f9252f3659.camel@HansenPartnership.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 25 Nov 2020 01:32:17 +0100
Message-ID: <CANiq72kqO=bYMJnFS2uYRpgWATJ=uXxZuNUsTXT+3aLtrpnzvQ@mail.gmail.com>
Subject: Re: [PATCH 000/141] Fix fall-through warnings for Clang
To:     James Bottomley <James.Bottomley@hansenpartnership.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        alsa-devel@alsa-project.org, amd-gfx@lists.freedesktop.org,
        bridge@lists.linux-foundation.org, ceph-devel@vger.kernel.org,
        cluster-devel@redhat.com, coreteam@netfilter.org,
        devel@driverdev.osuosl.org, dm-devel@redhat.com,
        drbd-dev@lists.linbit.com, dri-devel@lists.freedesktop.org,
        GR-everest-linux-l2@marvell.com, GR-Linux-NIC-Dev@marvell.com,
        intel-gfx@lists.freedesktop.org, intel-wired-lan@lists.osuosl.org,
        keyrings@vger.kernel.org, linux1394-devel@lists.sourceforge.net,
        linux-acpi@vger.kernel.org, linux-afs@lists.infradead.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-arm-msm@vger.kernel.org,
        linux-atm-general@lists.sourceforge.net,
        linux-block@vger.kernel.org, linux-can@vger.kernel.org,
        linux-cifs@vger.kernel.org,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        linux-decnet-user@lists.sourceforge.net,
        Ext4 Developers List <linux-ext4@vger.kernel.org>,
        linux-fbdev@vger.kernel.org, linux-geode@lists.infradead.org,
        linux-gpio@vger.kernel.org, linux-hams@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-i3c@lists.infradead.org,
        linux-ide@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-input <linux-input@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Linux Media Mailing List <linux-media@vger.kernel.org>,
        linux-mmc@vger.kernel.org, Linux-MM <linux-mm@kvack.org>,
        linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-rdma@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        linux-scsi@vger.kernel.org, linux-sctp@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-usb@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Network Development <netdev@vger.kernel.org>,
        netfilter-devel@vger.kernel.org, nouveau@lists.freedesktop.org,
        op-tee@lists.trustedfirmware.org, oss-drivers@netronome.com,
        patches@opensource.cirrus.com, rds-devel@oss.oracle.com,
        reiserfs-devel@vger.kernel.org, samba-technical@lists.samba.org,
        selinux@vger.kernel.org, target-devel@vger.kernel.org,
        tipc-discussion@lists.sourceforge.net,
        usb-storage@lists.one-eyed-alien.net,
        virtualization@lists.linux-foundation.org,
        wcn36xx@lists.infradead.org,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        xen-devel@lists.xenproject.org, linux-hardening@vger.kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>, Joe Perches <joe@perches.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Mon, Nov 23, 2020 at 9:38 PM James Bottomley
<James.Bottomley@hansenpartnership.com> wrote:
>
> So you think a one line patch should take one minute to produce ... I
> really don't think that's grounded in reality.

No, I have not said that. Please don't put words in my mouth (again).

I have said *authoring* lines of *this* kind takes a minute per line.
Specifically: lines fixing the fallthrough warning mechanically and
repeatedly where the compiler tells you to, and doing so full-time for
a month.

For instance, take the following one from Gustavo. Are you really
saying it takes 12 minutes (your number) to write that `break;`?

diff --git a/drivers/gpu/drm/via/via_irq.c b/drivers/gpu/drm/via/via_irq.c
index 24cc445169e2..a3e0fb5b8671 100644
--- a/drivers/gpu/drm/via/via_irq.c
+++ b/drivers/gpu/drm/via/via_irq.c
@@ -364,6 +364,7 @@ int via_wait_irq(struct drm_device *dev, void
*data, struct drm_file *file_priv)
                irqwait->request.sequence +=
                        atomic_read(&cur_irq->irq_received);
                irqwait->request.type &= ~_DRM_VBLANK_RELATIVE;
+               break;
        case VIA_IRQ_ABSOLUTE:
                break;
        default:

>  I suppose a one line
> patch only takes a minute to merge with b4 if no-one reviews or tests
> it, but that's not really desirable.

I have not said that either. I said reviewing and merging those are
noise compared to any complex patch. Testing should be done by the
author comparing codegen.

> Part of what I'm trying to measure is the "and useful" bit because
> that's not a given.

It is useful since it makes intent clear. It also catches actual bugs,
which is even more valuable.

> Well, you know, subsystems are very different in terms of the amount of
> patches a maintainer has to process per release cycle of the kernel.
> If a maintainer is close to capacity, additional patches, however
> trivial, become a problem.  If a maintainer has spare cycles, trivial
> patches may look easy.

First of all, voluntary maintainers choose their own workload.
Furthermore, we already measure capacity in the `MAINTAINERS` file:
maintainers can state they can only handle a few patches. Finally, if
someone does not have time for a trivial patch, they are very unlikely
to have any time to review big ones.

> You seem to be saying that because you find it easy to merge trivial
> patches, everyone should.

Again, I have not said anything of the sort.

Cheers,
Miguel
