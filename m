Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5291A255E84
	for <lists+linux-cifs@lfdr.de>; Fri, 28 Aug 2020 18:06:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725911AbgH1QGA (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 28 Aug 2020 12:06:00 -0400
Received: from mx.cjr.nz ([51.158.111.142]:19002 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725814AbgH1QF5 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 28 Aug 2020 12:05:57 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id D85667FCFE;
        Fri, 28 Aug 2020 16:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1598630753;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=kCacCX6pGTDIvMVVA9V19Ct4m61XuoZToQJAlbdWPAM=;
        b=BncZin+JyFK/l86AfHJBiH42ucDs29OZmr5IIskfh0q03HJ4wH9766hDmMzjgBiN1sJgvV
        NeiRZg5/ipWsEU7EIHq02nFUxl1reVBAmpOQVy8vYAW1MBP7tXUh88bxXKk8aNXA8w8FBc
        GWs0x/Qp225QuIboOgVkp7FYZi/UKQzEiRl2Xqs+soXgqL8/Q/Er4fdns7ZOqxKZ/wtSdL
        tJb/m1b3fipQc2cgPvIYo+BFEu9aBS401sUSm7Sbx7VN2aiHw/a3I4e6Mxlg1lhWoMQVUD
        awzQ+8XVfInn0dfkYZ7CX6eSCMa4IgsXqhZTeLRVKT5zzvsMFlRaqr312k++DA==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Steve French <smfrench@gmail.com>
Subject: Re: [PATCH] cifs: fix check of tcon dfs in smb1
In-Reply-To: <CANT5p=o2zdnioP+-McsM+AAzBGrdgNkq0pFXdXATc76=SP9YyA@mail.gmail.com>
References: <20200827142019.26968-1-pc@cjr.nz>
 <CANT5p=o2zdnioP+-McsM+AAzBGrdgNkq0pFXdXATc76=SP9YyA@mail.gmail.com>
Date:   Fri, 28 Aug 2020 13:05:48 -0300
Message-ID: <87zh6eiwmb.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Shyam Prasad N <nspmangalore@gmail.com> writes:

> These changes look good to me.
> However, I see other places in the code where these flags are checked
> separately. Don't we want to replace all those with is_tcon_dfs()
> calls?

Yes, probably.  We could do that in separate patches, however it would
require a lot of testing.

I initially did it for dfs mount because it was easily reproducible when
running smb1 tests against Windows 2019.

Thanks for pointing that out.  I can take a look at it when time
allows.
