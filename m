Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CC23DB5AD8
	for <lists+linux-cifs@lfdr.de>; Wed, 18 Sep 2019 07:23:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727330AbfIRFXh (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 18 Sep 2019 01:23:37 -0400
Received: from mail-qt1-f178.google.com ([209.85.160.178]:32803 "EHLO
        mail-qt1-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727152AbfIRFXg (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 18 Sep 2019 01:23:36 -0400
Received: by mail-qt1-f178.google.com with SMTP id r5so7466719qtd.0
        for <linux-cifs@vger.kernel.org>; Tue, 17 Sep 2019 22:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monash.edu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K2W0K40xSFp5/GkLZhDmVETIJmQ1sHG91VA6A31r9b4=;
        b=KBp+JDURtTKmvPMN8qR2kJDLmKWpsbwNaxAf35ASNd/4yF8pg6sCS9Jp4U2ef42Mf6
         tCgIFKnv5UPa1lFCFKV9v+jkmFvPMdyChPrD7ol66aRZvr/RyPWqrvvwWVMlO0hXr2/+
         AK1Tb//X0PRhAa/1cbPLD89PUEZKkB+gKYgQdp7Px23dl9qjnJPvkaaHAxDUEgjQEV7J
         bUoR/a4cT1Xawne8EMppBJjsqpA2EeeqZLET3W+sHPzlw7cbLhHAwGWcjF8qLog97TBU
         voawW3lwEjh13OsKVEvuDOhuCAQfI916QgZItOYkN939pr2j5TUdkV8UnGDRKKopjeLJ
         1FMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K2W0K40xSFp5/GkLZhDmVETIJmQ1sHG91VA6A31r9b4=;
        b=XkM4l1Znv5wqQz8BDG/VIevscUTxvt71KVRU+VREVuKakKtiFaoF70Ss3MLiSy1k0/
         sthjlYVrhqOJzt6wBGasUX3+ZmlZnVOacC0zokZMpYqJ9TNaiARR4dvFF/HOpSbofiOX
         YcRiom2AmBCOIOl6m2dgBjYnr5WUATMAeUx0N0yJJWvwljIBlmyq3JV5QPqxScaeN6ye
         H7PGZBjJQOwCHlWEMRF+HeZNFA/45yVUukwRP+WgmkW3xofKCvVYM/KkUWgg5WVh/pGY
         5mVna7sL587hCcmGlun/5f2K1fK7/yJkRHGh1TqRidsPvFFXxf2yuN0w6YesAYwrXwfk
         kXyg==
X-Gm-Message-State: APjAAAXWwl9eGxHRMnLyX/C4nsYDKALIoJeKvNctHUZdMaDTArNSCGag
        jf9MTLbPas0zccYkOWqTzQ2YthQF0GY2oK94vT8SQQ==
X-Google-Smtp-Source: APXvYqxPOxMXQr0dAOjQc7csao0DBbzCUr95SuHCEkVLTClPn3xt9Dpd3komPDH2v8ebhfzFL/Ajzrb84AE0CtW2iDk=
X-Received: by 2002:a0c:8a4f:: with SMTP id 15mr1769621qvu.188.1568784215651;
 Tue, 17 Sep 2019 22:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAE78Er-YVBzqaf8jCBio_V_1J2kRiWZ_SH-HnHm7KG3t46=j6w@mail.gmail.com>
 <CAH2r5mu446ssSPrACP8q859Cs0ynUMpJopH0t5qAsR=sGrByFA@mail.gmail.com>
 <CAE78Er8KYhRts+zKNsP6_11ZVA0kaTrtjvZPhdLAkHqDXhKOWA@mail.gmail.com>
 <87pnkh7jh2.fsf@suse.com> <CAE78Er_ea5mtp-6VxyNPzCSDuPym7cXcD3=Udcpv=jGo80XhZg@mail.gmail.com>
 <CAKywueT2mr1i3Y6iNQOzXEc1CePMozfvoJUz=TJAmbnskdofhw@mail.gmail.com> <CAE78Er97k7O-GDGdMtp0qXtQ-q-1nS_d1AE6HHH+Kz6PV_G2uQ@mail.gmail.com>
In-Reply-To: <CAE78Er97k7O-GDGdMtp0qXtQ-q-1nS_d1AE6HHH+Kz6PV_G2uQ@mail.gmail.com>
From:   James Wettenhall <james.wettenhall@monash.edu>
Date:   Wed, 18 Sep 2019 15:23:24 +1000
Message-ID: <CAE78Er_L5fY31JdVaSUgbd7uyXpMAb+81adcVFD3GBQfMeWX0g@mail.gmail.com>
Subject: Re: Frequent reconnections / session startups?
To:     Pavel Shilovsky <piastryyy@gmail.com>
Cc:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Thanks Pavel,

We've been running Kernel v5.2.14 over the past week (updated using
Ukuu) and it seems to have improved the situation considerably.

I assume that the "nohandlecache" mount option recommendation was just for v5.0.

Cheers,
James
