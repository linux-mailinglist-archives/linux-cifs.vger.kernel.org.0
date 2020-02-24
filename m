Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D942216B2B4
	for <lists+linux-cifs@lfdr.de>; Mon, 24 Feb 2020 22:37:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgBXVhC (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 24 Feb 2020 16:37:02 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:42249 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726980AbgBXVhB (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 24 Feb 2020 16:37:01 -0500
Received: by mail-lj1-f195.google.com with SMTP id d10so11738592ljl.9
        for <linux-cifs@vger.kernel.org>; Mon, 24 Feb 2020 13:37:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=QUdcFIHu39jksi7ynt9bLceAH97MdpNVo4rpRP5wDxA=;
        b=ub27fz6DfSLSPltzurkE7UkcNJtP7RhBVVUqPEuxQP9RlCjTE3iKvaqd0KHAF/ucuv
         PQU7zcg45dalqrsYwL29u8PMfVuY5K+r89okR/sTDUS5bVdlltjwr2+ScLPZ2QX4Fvie
         sXEwZ1Dc27N/z9k3yvP1Z2bKz1tC/3wvFjI0p15aYj7+JTU1T4kRmJGpAcqghqeXUmv3
         a2jjSbcKrNNY7XfTebsP99xSbm2rQaLJppiYRsGmcow7Z0lGxTeV7mgIkuQB51Z3Sy/J
         Pgx2CHKiJ/+r2r+LAfAPiVvKuuDjTDBw5wNFR0Bku5Rut4oZbRtvRjtMgAqVTvFeB/lD
         CHcA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=QUdcFIHu39jksi7ynt9bLceAH97MdpNVo4rpRP5wDxA=;
        b=crX90z5E9OUILsjl2L2mVKdEA5UVsvPtdsT9LccXMB/4gaKB4JmyE+Q5MOUrq1uWNO
         nCTBJc3sQGJifcQlYcRGiCwy24Rs9ELTkikjOICNsM8D1BuanP1wf/vTfL2tBmuL2DW2
         Oahn9fSfItpv3K0y2vke1vVsyjkIHsr1hn9qe7FvDhXTE3TNseT1ktn19qBhdS3CO0Vh
         CkvIV+UovfpX/rBHSv1DsicpLFZ38nYxvyiAaGcGTpAflfKVd4vne70AiwFmYA7wDQ7e
         fJ+F1xe0O/jifdftooMhOBO/JUJQT0XpOCLLSmjglyTpyjKfVbhxqIUfAoZHkjfviXrH
         4JwA==
X-Gm-Message-State: APjAAAUAnkPnI5YasWKKd9nSKoFL/BwKsVYNdrpqO+W0Ms81itPng0m9
        T5DQCKmBlzmrgDkXU8ZeKO6qcYIOw1b3qOXjgA==
X-Google-Smtp-Source: APXvYqwX+BrVZpG6yKZAh3Bi2/8YkqAOC3OkW4HBtJSFo1M5z91sf3kv6h+ILziIreDIob+qa2fkjM3sHo8lRmrD7Nw=
X-Received: by 2002:a2e:9e55:: with SMTP id g21mr32261678ljk.245.1582580219775;
 Mon, 24 Feb 2020 13:36:59 -0800 (PST)
MIME-Version: 1.0
References: <20200224131510.20608-1-metze@samba.org> <20200224131510.20608-4-metze@samba.org>
 <87pne34zye.fsf@suse.com> <CAH2r5msm43TLWYUx++9+tND2rOBDUFuZJ4+vtiTPQwQiqPbSyQ@mail.gmail.com>
In-Reply-To: <CAH2r5msm43TLWYUx++9+tND2rOBDUFuZJ4+vtiTPQwQiqPbSyQ@mail.gmail.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Mon, 24 Feb 2020 13:36:48 -0800
Message-ID: <CAKywueSXfMM6Pz6Wv85pRqYsqy---PS1s-0dWVuTAdKtogdLkg@mail.gmail.com>
Subject: Re: [PATCH v1 03/13] cifs: make use of cap_unix(ses) in cifs_reconnect_tcon()
To:     Steve French <smfrench@gmail.com>
Cc:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@samba.org>,
        Stefan Metzmacher <metze@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The first tree patches look good.

Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>

--
Best regards,
Pavel Shilovsky

=D0=BF=D0=BD, 24 =D1=84=D0=B5=D0=B2=D1=80. 2020 =D0=B3. =D0=B2 12:39, Steve=
 French <smfrench@gmail.com>:
>
> First three patches in this series merged into cifs-2.6.git for-next
> (and the buildbot's github tree) pending more testing and review
>
> On Mon, Feb 24, 2020 at 12:12 PM Aur=C3=A9lien Aptel <aaptel@samba.org> w=
rote:
> >
> > Reviewed-by: Aurelien Aptel <aaptel@suse.com>
> >
> > --
> > Aur=C3=A9lien Aptel / SUSE Labs Samba Team
> > GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> > SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnber=
g, DE
> > GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=
=C3=BCnchen)
>
>
>
> --
> Thanks,
>
> Steve
