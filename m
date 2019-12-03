Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20604111B8A
	for <lists+linux-cifs@lfdr.de>; Tue,  3 Dec 2019 23:17:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbfLCWRB (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 3 Dec 2019 17:17:01 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:40995 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727680AbfLCWRB (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 3 Dec 2019 17:17:01 -0500
Received: by mail-lj1-f195.google.com with SMTP id h23so5637692ljc.8
        for <linux-cifs@vger.kernel.org>; Tue, 03 Dec 2019 14:17:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=ANwYwWJbRI6uplbZubi6kj5+L3RNhlLS9CV/h/6JFo8=;
        b=JHhsbUKJDztUXerp+sNdRODENdbUHKND4hhldE0sv4wRBNwR2pSPvjZnXgUwFSrCG1
         KXgBRRcB3qe2RSXalw/TkHsATntsnXdy31Zv1pyHFXaC4fXgSD/H5cwb9iknmnv6SZST
         Fyxgnx9Za4kbb6sRmZcj1huAbBZeHdXkFbE3OxmSsN7f0gXzaScfXIwnkvq0OZEhHRnn
         uy3N+SOABuu7uBx54jpOAvYMcgNZ5AKiyiThfrFWh0yBjI1C9Qokz18o9S8027AtY1Bx
         Ln9qLmj4v+zlkVx+MZZDaM2D+akSgdXtem6lVRBURTIMQR4/kD+i5BTH+5dxQlCVQeW9
         /saA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=ANwYwWJbRI6uplbZubi6kj5+L3RNhlLS9CV/h/6JFo8=;
        b=PkOdSccz3LZ2MISguqrHEUp6ZopAo3Rz4DJhDZYPnmhncz3eitLG+pZ8pr74pVCC2o
         cK4ISVOYmXPG74HkkRoQDDcH1Jo8ShwRJGpuPROcs7rzocsuG7xy5yS3DjL9oSIzfcyo
         xFOwRi79mDC/rbT2wT26+GmIItMLX1Og4ldYEfyWxuSKDXWvLPgu5m57QYCXPm0XSX0S
         xkdN27B+Pq4GdGBNzYVUtLYIKbCJeOn0SfNGpWHg9IRZ37BeQB3m2/kqmO5dCa1KQc/6
         NCxDCT0e5FMSX3EuRFTlaNn36AuWkYCnDo4HBAqz1PYNMyBLKYn1xgS2N8/ofxkFOPnf
         253g==
X-Gm-Message-State: APjAAAW6CIly+ZA4blX37nMUp+HuZPH03dVviW/XE6yjMVBYzoUqYx0P
        h9/d3lsVa/BIh9aAyN816r0dv3vVlq3Rm3g4/w==
X-Google-Smtp-Source: APXvYqyJEBXXAPPwf0R0okR4dCDGni14LL7EhHAKlqlYJRNHtfYJ9W7Gp2SxgNbvrCDHGFf5svncwhVicxuf3Q9ghJU=
X-Received: by 2002:a2e:898a:: with SMTP id c10mr3787645lji.177.1575411419453;
 Tue, 03 Dec 2019 14:16:59 -0800 (PST)
MIME-Version: 1.0
References: <CAH2r5muXMXS6S-+XykdZmZGMQGNsTunxDXM-fqX7owEG+E=RRQ@mail.gmail.com>
 <8736e1tl1j.fsf@suse.com> <CAH2r5mu9gs+wV+s1=HC9bS0Rb1KY1uJ5ZQFZsCNycGGJH50kCA@mail.gmail.com>
 <CAKywueS7sVnbBCgc0Cc8NoqDsbEWVh2iMU7fBuoTS_2v-Hjw-A@mail.gmail.com> <CAH2r5mtmzQHMb+EgSpE+vOHr4=oPyv0mGAP4QEMjtswwoOZyLA@mail.gmail.com>
In-Reply-To: <CAH2r5mtmzQHMb+EgSpE+vOHr4=oPyv0mGAP4QEMjtswwoOZyLA@mail.gmail.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Tue, 3 Dec 2019 14:16:48 -0800
Message-ID: <CAKywueRgmMqMvu3+ymS_rq9Xb4qnOmP_CgAiKhZKyUFNgp0JmA@mail.gmail.com>
Subject: Re: [PATCH][SMB3] Query timestamps on file close
To:     Steve French <smfrench@gmail.com>
Cc:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
--
Best regards,
Pavel Shilovsky

=D0=B2=D1=82, 3 =D0=B4=D0=B5=D0=BA. 2019 =D0=B3. =D0=B2 13:49, Steve French=
 <smfrench@gmail.com>:
>
> Updated patch with Pavel's recommended change included
>
> On Tue, Dec 3, 2019 at 1:19 PM Pavel Shilovsky <piastryyy@gmail.com> wrot=
e:
> >
> > The inode locking is missed in the patch. See cifs_fattr_to_inode()
> > that takes inode->i_lock to atomically update all the attributes. The
> > similar thing is needed in +smb2_close_getattr().
> >
> > --
> > Best regards,
> > Pavel Shilovsky
> >
> > =D0=B2=D1=82, 3 =D0=B4=D0=B5=D0=BA. 2019 =D0=B3. =D0=B2 10:05, Steve Fr=
ench <smfrench@gmail.com>:
> > >
> > > Fixed typo, and added the update of AllocationSize (and added reviewe=
d
> > > by). See attached.
> > >
>
>
>
> --
> Thanks,
>
> Steve
