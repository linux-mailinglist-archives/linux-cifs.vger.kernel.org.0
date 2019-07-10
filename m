Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA2064C27
	for <lists+linux-cifs@lfdr.de>; Wed, 10 Jul 2019 20:35:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727734AbfGJSf2 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 10 Jul 2019 14:35:28 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:42327 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbfGJSf2 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 10 Jul 2019 14:35:28 -0400
Received: by mail-lj1-f193.google.com with SMTP id t28so3088345lje.9
        for <linux-cifs@vger.kernel.org>; Wed, 10 Jul 2019 11:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=59LQqbVb+KQ/BMKWYDi9soPsvc3OIaSci70f6vwiQDg=;
        b=FqoWOUQDI8WMp245xx+rH6pVnDYOUvjDYs15fEQlF6pDz0NP8XsjV31N/mtE4tmezC
         j2UTUlQ1N7GdmP1kf74xSCxvIJJ+DHBtK3c6eKcgoseA+K8AhvGS/ovhJPv6+HASW4G8
         XOZuoCQHXi5bTBX95YG3a2jJFHuWkpZNYqeaA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=59LQqbVb+KQ/BMKWYDi9soPsvc3OIaSci70f6vwiQDg=;
        b=WNLV+kqXiT393EyL3hfIDRuHSJRhQJfa6yE7qfs3eF4HO2O1rQd9EVpq2hvEoT4zRd
         Fldt4ldXIENND6pgbvQVSfkEJcyWjdyZKjApLZne6nA60cWG4IUg6j3Yr57mlTmVLxip
         S4tSDG4zZogKJZPsKQtJfVNsiV3QbPvnytWodXgi6dabrNKYwaz0iJr3pddOWApMCb8r
         rws+9B+ieDLqLXozHhIKzPHUZDkpIlUcTxPBmLdkaCsoRhbtfyQuvFFdKzZ830eV5XoW
         FR7h3w5XulvkieBUXySlys3KOKCuJElnTqdv9kyULcAWj8PQZWysrSnhv4F7GUO9bpGu
         BC9A==
X-Gm-Message-State: APjAAAVvdPvb0nH4RBWRWgb0Lwcorr65uuuEjCOpfOb5A1lwOJsYxymb
        oa5FCsC123cz3BkHtuRrkqkZqKI8m+4=
X-Google-Smtp-Source: APXvYqwe9joE8UxUkYMf8mRYfTjjU+yRbFELFnELcSzrZ1H14JIA2y0n+ZF2cqlTESVA332aUww4MA==
X-Received: by 2002:a2e:781a:: with SMTP id t26mr4975809ljc.28.1562783725574;
        Wed, 10 Jul 2019 11:35:25 -0700 (PDT)
Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com. [209.85.167.45])
        by smtp.gmail.com with ESMTPSA id s1sm578247ljd.83.2019.07.10.11.35.24
        for <linux-cifs@vger.kernel.org>
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Wed, 10 Jul 2019 11:35:24 -0700 (PDT)
Received: by mail-lf1-f45.google.com with SMTP id 62so2293644lfa.8
        for <linux-cifs@vger.kernel.org>; Wed, 10 Jul 2019 11:35:24 -0700 (PDT)
X-Received: by 2002:a19:641a:: with SMTP id y26mr14803967lfb.29.1562783723934;
 Wed, 10 Jul 2019 11:35:23 -0700 (PDT)
MIME-Version: 1.0
References: <28477.1562362239@warthog.procyon.org.uk>
In-Reply-To: <28477.1562362239@warthog.procyon.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 10 Jul 2019 11:35:07 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjxoeMJfeBahnWH=9zShKp2bsVy527vo3_y8HfOdhwAAw@mail.gmail.com>
Message-ID: <CAHk-=wjxoeMJfeBahnWH=9zShKp2bsVy527vo3_y8HfOdhwAAw@mail.gmail.com>
Subject: Re: [GIT PULL] Keys: Set 4 - Key ACLs for 5.3
To:     David Howells <dhowells@redhat.com>
Cc:     James Morris James Morris <jmorris@namei.org>,
        keyrings@vger.kernel.org, Netdev <netdev@vger.kernel.org>,
        linux-nfs@vger.kernel.org, CIFS <linux-cifs@vger.kernel.org>,
        linux-afs@lists.infradead.org,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        linux-integrity@vger.kernel.org,
        LSM List <linux-security-module@vger.kernel.org>,
        Linux List Kernel Mailing <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Fri, Jul 5, 2019 at 2:30 PM David Howells <dhowells@redhat.com> wrote:
>
> Here's my fourth block of keyrings changes for the next merge window.  They
> change the permissions model used by keys and keyrings to be based on an
> internal ACL by the following means:

It turns out that this is broken, and I'll probably have to revert the
merge entirely.

With this merge in place, I can't boot any of the machines that have
an encrypted disk setup. The boot just stops at

  systemd[1]: Started Forward Password Requests to Plymouth Directory Watch.
  systemd[1]: Reached target Paths.

and never gets any further. I never get the prompt for a passphrase
for the disk encryption.

Apparently not a lot of developers are using encrypted volumes for
their development machines.

I'm not sure if the only requirement is an encrypted volume, or if
this is also particular to a F30 install in case you need to be able
to reproduce. But considering that you have a redhat email address,
I'm sure you can find a F30 install somewhere with an encrypted disk.

David, if you can fix this quickly, I'll hold off on the revert of it
all, but I can wait only so long. I've stopped merging stuff since I
noticed my machines don't work (this merge window has not been
pleasant so far - in addition to this issue I had another entirely
unrelated boot failure which made bisecting this one even more fun).

So if I don't see a quick fix, I'll just revert in order to then
continue to do pull requests later today. Because I do not want to do
further pulls with something that I can't boot as a base.

                 Linus
