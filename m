Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05BDD4EF848
	for <lists+linux-cifs@lfdr.de>; Fri,  1 Apr 2022 18:45:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348955AbiDAQq4 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 1 Apr 2022 12:46:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349516AbiDAQqu (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 1 Apr 2022 12:46:50 -0400
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 762D916F6E8
        for <linux-cifs@vger.kernel.org>; Fri,  1 Apr 2022 09:30:19 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 38F717FC23;
        Fri,  1 Apr 2022 16:30:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1648830617;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=zDmVJUnEWQuZRdBxzL4JaocdxS6jiKjvKrWLC/41R2U=;
        b=plpqiOhd1bsta1zy7p2Z29RE8PiUfXQvTGPq8kz38zbXxahLIsPUTK2huP+PlHwsQrVVa1
        kVpuGB4KZc6Q4nTCdXXI8VoMvtIGtwW+EQmD0Knay/a7ldiqNYZE3fczGenrDDkm9pUma7
        2ib6y2rB16cTGxqoAMI3UnoIWnnELNUbUZXOT9T3QpLyhTrnj3skgHifFBVCpWvgyLU6go
        2uMF94/zbU9tVgAwbNo1mYzbm1fTAhAK6dJyx379LWb0LvdQSd+Oc3N+dKGreUH3cMoIvK
        Idkxusk0eMD4qgDHNu3xQtbWveCcje9sYF2060ILjnrudJufuYknN/7BkSXEbA==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Steve French <smfrench@gmail.com>
Subject: Re: [PATCH 2/2] cifs: force new session setup and tcon for dfs
In-Reply-To: <CANT5p=rPMsZvacpRsYUQSg9mM_TjnGtNJtUCurVsdv_JV9cVdg@mail.gmail.com>
References: <20220331180151.5301-1-pc@cjr.nz>
 <20220331180151.5301-2-pc@cjr.nz>
 <CANT5p=rPMsZvacpRsYUQSg9mM_TjnGtNJtUCurVsdv_JV9cVdg@mail.gmail.com>
Date:   Fri, 01 Apr 2022 13:30:13 -0300
Message-ID: <87h77cg416.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,DOS_RCVD_IP_TWICE_B,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Shyam Prasad N <nspmangalore@gmail.com> writes:

> This makes sense.
> Wondering if you could check if the reconnect happens to a new
> server/share and then change mark_smb_session? Maybe that complicates
> the logic.

Yes, it would complicate alot.  We expect failover to not occur quite
often, so leaving it without such logic would be OK for now, IMO.  I'm
trying to get all reconnect issues fixed and then we can talk about
possible improvements, obviously.
