Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 780F3287B8F
	for <lists+linux-cifs@lfdr.de>; Thu,  8 Oct 2020 20:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgJHSTg (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 8 Oct 2020 14:19:36 -0400
Received: from mx2.suse.de ([195.135.220.15]:43132 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725857AbgJHSTf (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 8 Oct 2020 14:19:35 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1602181174;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=pAxKfRVNN4fjuSzXHEnmrskomd9Bbd0mO8zX8eMcqAs=;
        b=JiRVjPboz0mQ2sEAxGKnuNcwwYm8sz61y07MaScRcfr1quHIKooysRudbcX2NoDQaGgryK
        F/AgKjrpXGLM4iuOoQTEoSZTvTClijQZ5vX3ePKC/TlSpp43rpXK2fycKeFtmuHUBwieOF
        wRbUX67p/mjgNNN/FeQsb9+Tdat8A2g=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 8082DB29B;
        Thu,  8 Oct 2020 18:19:34 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Pavel Shilovsky <piastryyy@gmail.com>, sribhat.msa@outlook.com,
        linux-cifs <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH] Resolve data corruption of TCP server info fields
In-Reply-To: <CACdtm0YWG1Ni5JnOpnH4OVnF7RpiE_E_WXYrTBEP=K+SL=Yuog@mail.gmail.com>
References: <CACdtm0YWG1Ni5JnOpnH4OVnF7RpiE_E_WXYrTBEP=K+SL=Yuog@mail.gmail.com>
Date:   Thu, 08 Oct 2020 20:19:33 +0200
Message-ID: <875z7kinre.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi Rohith,

Rohith Surabattula <rohiths.msft@gmail.com> writes:
> server->total_read field is already updated properly during read from
> socket. So, no need to update the same field again after decryption.

Good catch! From scanning the code it looks right but better run some
tests to be sure. If you have a reproducer it could be useful to add to
the buildbot.

Reviewed-by: Aurelien Aptel <aaptel@suse.com>

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, DE
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)
