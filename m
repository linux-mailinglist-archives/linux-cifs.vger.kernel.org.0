Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7082B74F3D
	for <lists+linux-cifs@lfdr.de>; Thu, 25 Jul 2019 15:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727090AbfGYNZA (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 25 Jul 2019 09:25:00 -0400
Received: from mail-lf1-f41.google.com ([209.85.167.41]:46169 "EHLO
        mail-lf1-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726653AbfGYNY7 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 25 Jul 2019 09:24:59 -0400
Received: by mail-lf1-f41.google.com with SMTP id z15so30251499lfh.13
        for <linux-cifs@vger.kernel.org>; Thu, 25 Jul 2019 06:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=HF/IqXw/Vpz9m4C58NJz0K6HAN5i01s1ftF5JNhXdtA=;
        b=P2+Z949fvMsSI03rbgcP7zxp3k+JcqO0agZx9BqExouKK24O471MEcONyk5p4oKOsY
         sB4EpF6t+yQ7fpTSMyro86l4dguDXcG4/1bktNyKBy3Jdu5eGOXMbcVnCy2sM4mwG0HP
         h84JY037WOuFAX90hvMPI3kZdiaXGjDGk208gHz7M5QvPOV9kzlRkofCIy7ZPm6Q/5hp
         Zw6GK74G1BQ+maVeUvXbSuy2y62DbBf8b4SRgd1LtZnpiR98GrlPn7m8KEPjB+Q/L34J
         u9Jrl1GW/lGbNXTZlwU92nIpsk5xnsUU9W8kG00OQdNsPH58tsVuDMYMjpIHW8nFeU85
         ifmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=HF/IqXw/Vpz9m4C58NJz0K6HAN5i01s1ftF5JNhXdtA=;
        b=WJGurlxuMqTseqIgTkJybwEcsgpeuO025i7g7unJSU39SmY1Q1AzibdCOfC/sPlp9L
         +K/BfKdjIOdlMH9fT+nT5Q5EvzyrYwR9wRnuCNA6HfR5BFDwyOc/eB7kyleN/ukHxEFw
         zMIdAn0WYIdYS6G9nrdHNX25EgxnV9URp3M5DNTO3mEvCT68UQdplVjhgEC3a6rcL8OW
         kh6zs2j+ADzNx8wjLLfcvHWKHCUA6VM3ijtxLY1EzmmgGu6IVWL2UuFxMC0x4PxTLwiQ
         Kr2i8AdmOq6qurfF52E6LZBVR6sPuAv1jknh1xlHI1D93qizTpYmmXPyjjtLpH3zdRoj
         UsPA==
X-Gm-Message-State: APjAAAXkNXq1/nQx6r5qRPpK4ovoaAuSXyfV2NVKbjB6P46qh2sAjzFi
        lqBa7x/ilAV84E8I8SRyNvMEkjAAqrvirikBXv+FUFrc5QyYxQ==
X-Google-Smtp-Source: APXvYqxpDMjUcbPtuHd/7HiQcirbwD8J0QrtSrauraTLENYkD8TpMYhCyduXDMtwsGAj2r4V1cLemUtCxZIU7z36yJc=
X-Received: by 2002:ac2:47e8:: with SMTP id b8mr26028196lfp.84.1564061096892;
 Thu, 25 Jul 2019 06:24:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAO3V83L1Q9jCLBsjHgFE1jw2PPi_sHtQz4geDKC4jEPWkhNYBg@mail.gmail.com>
 <CAO3V83+iZRAQRZ5YzivPS3di0QM=-dJOg8rnVK1icUuuESd+=g@mail.gmail.com> <87zhlnvesj.fsf@suse.com>
In-Reply-To: <87zhlnvesj.fsf@suse.com>
From:   Wout Mertens <wout.mertens@gmail.com>
Date:   Thu, 25 Jul 2019 15:24:45 +0200
Message-ID: <CAO3V83+dmZNNaDQ14up=SL+pGv7ndiqG0y_rE7ciFyy1oNQCQw@mail.gmail.com>
Subject: Re: Fwd: mount.cifs fails but smbclient succeeds
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Thank you so much Aur=C3=A9lien, smbcmp was really helpful!

Is there a way to force mount.cifs to use DFS? (cifs-utils 6.8, kernel 4.19=
.57)

It turns out that when smbclient connects, it sends that it supports
DFS, but mount.cifs sends that it does NOT support DFS. Then smbclient
connects to the host and figures out the correct server to talk to,
and connects as needed, but mount.cifs just fails to do that.

What I did was to sniff the smbclient traffic for the server that has
the path I wanted, and then mount that directly using mount.cifs. That
works, but I'm worried that if they move things around it will break
again, or maybe they'll split the mount in two servers.

Here's the comparison: (-: smbclient, +: mount.cifs)
=3D=3D=3D=3D=3D=3D
smbclient first  has an extra "Negotiate Protocol Request" + Response,
which the mount.cifs doesn't do. Then there's a common "Negotiate
Protocol Request" + Response,
> Session Setup Request, NTLMSSP_NEGOTIATE  (same with the subsequent NTLMS=
SP_AUTH)
         Server Component: SMB2
     SMB2Header Length: 64
-        Credit Charge: 1
+        Credit Charge: 0
         Channel Sequence: 0
         Reserved: 0000
         Command: Session Setup (1)
-        Credits requested: 8192
-        Flags: 0x00000010, Priority
+        Credits requested: 130
+        Flags: 0x00000000
             .... .... .... .... .... .... .... ...0 =3D Response: This
is a REQUEST
             .... .... .... .... .... .... .... ..0. =3D Async command:
This is a SYNC command
             .... .... .... .... .... .... .... .0.. =3D Chained: This
pdu is NOT a chained command
             .... .... .... .... .... .... .... 0... =3D Signing: This
pdu is NOT signed
-            .... .... .... .... .... .... .001 .... =3D Priority: This
pdu contains a PRIORITY
+            .... .... .... .... .... .... .000 .... =3D Priority: This
pdu does NOT contain a PRIORITY
             ...0 .... .... .... .... .... .... .... =3D DFS operation:
This is a normal operation
             ..0. .... .... .... .... .... .... .... =3D Replay
operation: This is NOT a replay operation
         Chain Offset: 0x00000000
-        Message ID: Unknown (2)
-        Process Id: 0x00000000
+        Message ID: Unknown (1)
+        Process Id: 0x000040fc
[...]
-        Security mode: 0x01, Signing enabled
-            .... ...1 =3D Signing enabled: True
-            .... ..0. =3D Signing required: False
-        Capabilities: 0x00000001, DFS
-            .... .... .... .... .... .... .... ...1 =3D DFS: This host
supports DFS
+        Security mode: 0x02, Signing required
+            .... ...0 =3D Signing enabled: False
+            .... ..1. =3D Signing required: True
+        Capabilities: 0x00000000
+            .... .... .... .... .... .... .... ...0 =3D DFS: This host
does NOT support DFS

After that, they both do

> Session Setup Response
> Tree Connect Request Tree: \\corp.local\IPC$
> Tree Connect Response

and then smclient does
> Ioctl Request FSCTL_DFS_GET_REFERRALS, File: \corp.local\ib
but mount.cifs does
> Ioctl Request FSCTL_VALIDATE_NEGOTIATE_INFO
=3D=3D=3D=3D=3D=3D

I saw that there were fixes in 5.0 regarding crediting and DFS
reconnect, would they make a difference?

Wout.

On Tue, Jul 9, 2019 at 9:38 AM Aur=C3=A9lien Aptel <aaptel@suse.com> wrote:
>
> "Wout Mertens" <wout.mertens@gmail.com> writes:
> > Any suggestions? This is driving me crazy :-/
>
> If you make a network capture of smbclient connecting and a capture of
> mount.cifs failing you can use smbcmp [1] to compare them.
>
> https://github.com/aaptel/smbcmp
>
> --
> Aur=C3=A9lien Aptel / SUSE Labs Samba Team
> GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> SUSE Linux GmbH, Maxfeldstra=C3=9Fe 5, 90409 N=C3=BCrnberg, Germany
> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 21284 (AG N=C3=
=BCrnberg)
