Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C8A927CED8
	for <lists+linux-cifs@lfdr.de>; Tue, 29 Sep 2020 15:16:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728391AbgI2NQk (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 29 Sep 2020 09:16:40 -0400
Received: from mx2.suse.de ([195.135.220.15]:59828 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728366AbgI2NQk (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 29 Sep 2020 09:16:40 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601385399;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=xRTW9Z4Ys1JaqulItVcwv9t5PYzQzYzDLBFcXkHtstk=;
        b=ahMKmLaY6X8+DVYbRtGh3GwDv/RvnbNOLY7G5DRQDVQ4qcfg2UHuu92cXQ3lZ7xJ6UmyXk
        N2N6e/518TETN+rb7eBPuItpvfh1F+m/XYdQZ9/CQQ0iucvneD1pgM42Glr6JysNBrjlfm
        myV6lrsVKpDyZeGll1p1BmWbvcp8stM=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 0AEFEAD21;
        Tue, 29 Sep 2020 13:16:39 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>, sribhat.msa@outlook.com,
        rohiths.msft@gmail.com
Subject: Re: [PATCH] cifs: Return the appropriate error in cifs_sb_tlink
 instead of a generic error.
In-Reply-To: <CANT5p=ojR_Aac4bWSBqb3_FmzzjA6sHQBdN5z4o6c4nFDKmNDQ@mail.gmail.com>
References: <CANT5p=ojR_Aac4bWSBqb3_FmzzjA6sHQBdN5z4o6c4nFDKmNDQ@mail.gmail.com>
Date:   Tue, 29 Sep 2020 15:16:38 +0200
Message-ID: <87blhok9jd.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Shyam Prasad N <nspmangalore@gmail.com> writes:
> One of the cases where this behaviour is confusing is where a
> new tcon needs to be constructed, but it fails due to
> expired keys. cifs_construct_tcon then returns ENOKEY,
> but we end up returning a EACCES to the user.
>
> Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>

LGTM

Reviewed-by: Aurelien Aptel <aaptel@suse.com>

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, DE
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)
