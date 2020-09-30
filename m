Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E960727E514
	for <lists+linux-cifs@lfdr.de>; Wed, 30 Sep 2020 11:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725836AbgI3JZT (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 30 Sep 2020 05:25:19 -0400
Received: from mx2.suse.de ([195.135.220.15]:57182 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725823AbgI3JZT (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 30 Sep 2020 05:25:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601457918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=amZ77wDXvioG8jRJEGnYXQRY1yhplZyFN9RFKu4KJ2U=;
        b=ICHRn55wNiVZLNDZyG2wwdp72wel60JE70CDMxpTk7iRqkXTXUW0482cVzfmed1+Lhr+Zi
        vT4KiyMTFbcqe29vb4fptU4ar+C5bw+V2T5FxOKrINJYmcPDlxvzSAANjzz5XNWGnsZrPI
        BCyIuPeSWVeNZF1rthVnjdM1Xp7FBtg=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 43DF3AD1B;
        Wed, 30 Sep 2020 09:25:18 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Steve French <smfrench@gmail.com>,
        Boris Protopopov <boris.v.protopopov@gmail.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH] Convert trailing spaces and periods in path components
In-Reply-To: <CAH2r5mvWZSPjtg1g2FhZ+gZNpakdaFnugw=FhFV92Ed83VzAuQ@mail.gmail.com>
References: <20200924003638.2668-1-pboris@amazon.com>
 <CAHhKpQ4UFhtfRhByRiAm6KPy=KAzttYzZADLfakbMwpsp5GjpA@mail.gmail.com>
 <CAH2r5mvWZSPjtg1g2FhZ+gZNpakdaFnugw=FhFV92Ed83VzAuQ@mail.gmail.com>
Date:   Wed, 30 Sep 2020 11:25:17 +0200
Message-ID: <878scrk45e.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Steve French <smfrench@gmail.com> writes:
> tentatively merged ... running the usual functional tests
> http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/b=
uilds/399

We need to make sure it works with samba smb1&smb2 posix extensions.
In smb1 posix extensions the paths are sent with / and \ is a valid
component (and no restrictions on file name endings).

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, DE
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)
