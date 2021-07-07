Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5864D3BF149
	for <lists+linux-cifs@lfdr.de>; Wed,  7 Jul 2021 23:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230004AbhGGVSw (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 7 Jul 2021 17:18:52 -0400
Received: from mx.cjr.nz ([51.158.111.142]:18142 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229829AbhGGVSv (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 7 Jul 2021 17:18:51 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 0BFB77FD1E;
        Wed,  7 Jul 2021 21:16:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1625692568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=TppLu6f/hfhtK8Qwgf8ZFDQ9bFhE1Ayw8OFMu2r85ZQ=;
        b=QlgPu6mTUAlPbe501qbKcaiqFs0wJcDR98FgpkmjEtfaCoTFBHg9ruKGczhEy0vXeMPJpH
        uMKPudqIAncu8JMOdaLs4nOgUqDtt99kvGtKSs0w9/pIxxIciaVirjt8kjRxiFSXIW8p1X
        fkJYD2zI1xWOGMsQRnEfw2H11uYj15GBRwehjby42twVsJdLGzpFVlyh6xH4X9ll/X52qt
        DN/jNPSLpNtEdhkrqH1HWgPJ2i98Qmd7qs+jj3ETM0ewsxG3RyuJ/tqSSSvqCHU8vd/W25
        qpBiidm9zQZIG/Cxg9uiO27wWkRHgiyv0dl4PiFKBlK5jQi51TZvthD35umhXw==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH][CIFS] Clarify SMB1 code for POSIX Lock
In-Reply-To: <CAH2r5mtA8psGCcH_=JQbXw--im8f6e+bqy12YRRdww9gEyy6uw@mail.gmail.com>
References: <CAH2r5mtA8psGCcH_=JQbXw--im8f6e+bqy12YRRdww9gEyy6uw@mail.gmail.com>
Date:   Wed, 07 Jul 2021 18:16:03 -0300
Message-ID: <877di16d0s.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Steve French <smfrench@gmail.com> writes:

> Another trivial (Coverity reported issue) patch ...
>
> Coverity also complains about the way we calculate the offset
> (starting from the address of a 4 byte array within the
> header structure rather than from the beginning of the struct
> plus 4 bytes) for SMB1 PosixLock. This changeset
> doesn't change the address but makes it slightly clearer.
>
> Addresses-Coverity: 711520 ("Out of bounds write")
> Signed-off-by: Steve French <stfrench@microsoft.com>
> ---
>  fs/cifs/cifssmb.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
