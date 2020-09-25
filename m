Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9456F2783FE
	for <lists+linux-cifs@lfdr.de>; Fri, 25 Sep 2020 11:29:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726255AbgIYJ36 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 25 Sep 2020 05:29:58 -0400
Received: from mx2.suse.de ([195.135.220.15]:45566 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727521AbgIYJ36 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 25 Sep 2020 05:29:58 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1601026197;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Rf+ADsETQPxtUBFxemVlyzFi2DjhK4OmkHkQUxXsGn8=;
        b=LI//GL0EpbAKsJdBc6P82sHLyuO+huA60PYaNpvIaqRJ02O+XnUe8VynAMb91pqAOyjt9Y
        iOh4rCYoDgv/nQpuz5Ews7N30uVs9UCbLkNqlwR0vkxVi/c6N4lsPomz+uufaLXi/JTLvE
        8N6oTlZGH6bZIQ9gi2qPECfbfkqNxqw=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 9040EB190;
        Fri, 25 Sep 2020 09:29:57 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Martin Schwenke <martin@meltin.net>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH] mount.cifs: ignore comment mount option
In-Reply-To: <20200925113200.371db298@martins.ozlabs.org>
References: <20200925113200.371db298@martins.ozlabs.org>
Date:   Fri, 25 Sep 2020 11:29:56 +0200
Message-ID: <87o8lujjaj.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org


Reviewed-by: Aurelien Aptel <aaptel@suse.com>

Cheers,
--=20
Aur=C3=A9lien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg, DE
GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=BC=
nchen)
