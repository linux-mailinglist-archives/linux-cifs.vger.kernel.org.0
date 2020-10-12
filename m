Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A08F328B1C1
	for <lists+linux-cifs@lfdr.de>; Mon, 12 Oct 2020 11:50:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729458AbgJLJu3 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 12 Oct 2020 05:50:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:45902 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726104AbgJLJu1 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 12 Oct 2020 05:50:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602496225;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=znID3Yp0OfR3dmXjA/b3uU1xhv9pYAA6FAm5lFz4kww=;
        b=Z5k4XGUSGqc2F1wrXMswb8PEkChTI+eFnBFLZhqWA2EXfKz8iFrT/StKBXQzf+ZHJDi4VM
        q8/AJR4rKxfZkYTd+JZoR+DGRl6CvPz2rBrFaTlzg2XE9pa87S8CXvU6v+7YdPZ3qZbb4w
        OVyLcgrfb8YHKnFJi8/cXNE/NopFOEI=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id B766DADA8;
        Mon, 12 Oct 2020 09:50:25 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Stefan Metzmacher <metze@samba.org>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     samba-technical <samba-technical@lists.samba.org>
Subject: Re: [PATCH][SMB3.1.1] Add defines for new signing context
In-Reply-To: <bd8f21ed-5fd4-0974-f15a-16d2f3ee607f@samba.org>
References: <CAH2r5mtwBHTk-Xoeuo+RbgNwiNw-cWTAhdy1YG5y+vXnNDSv4w@mail.gmail.com>
 <bd8f21ed-5fd4-0974-f15a-16d2f3ee607f@samba.org>
Date:   Mon, 12 Oct 2020 11:50:24 +0200
Message-ID: <87r1q3hixr.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Patch LGTM

Reviewed-by: Aurelien Aptel <aaptel@suse.com>

Stefan Metzmacher via samba-technical <samba-technical@lists.samba.org>
> This isn't in MS-SMB2 yet.
>
> Is this AES_128?

This is returned in latest Windows Server Insider builds but it's not
documented yet.

https://www.microsoft.com/en-us/software-download/windowsinsiderpreviewserv=
er

I've asked dochelp about it during the SDC plugfest and they gave me
this:

    The new ContextType is:
    SMB2_SIGNING_CAPABILITIES 0x0008
    The Data field contains a list of signing algorithms.
    =E2=80=A2    It adds a new negotiate context, which enables SMB to deco=
uple signing algorithms from dialects. E.g. if both client and server suppo=
rts it, a session may use HMAC-SHA256 with SMB 3.1.1.
    =E2=80=A2    It adds the AES-GMAC algorithm.
=20=20=20=20=20
    SigningAlgorithmCount (2 bytes): Count of signing algorithms
    SigningAlgorithms (variable): An array of SigningAlgorithmCount 16-bit =
integer IDs specifying the supported signing algorithms.
=20=20=20=20=20
    The following IDs are assigned:=20
    0 =3D HMAC-SHA256
    1 =3D AES-CMAC
    2 =3D AES-GMAC


I've been CCed in a Microsoft email thread later on and it seems to be
unclear why this was missed/wasn't documented. Maybe this is subject to
change so take with a grain of salt.

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, DE
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)
