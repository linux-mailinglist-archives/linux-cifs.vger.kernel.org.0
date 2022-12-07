Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B6E6645212
	for <lists+linux-cifs@lfdr.de>; Wed,  7 Dec 2022 03:33:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbiLGCdv (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 6 Dec 2022 21:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiLGCdu (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 6 Dec 2022 21:33:50 -0500
Received: from sender4-of-o53.zoho.com (sender4-of-o53.zoho.com [136.143.188.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A304051C00
        for <linux-cifs@vger.kernel.org>; Tue,  6 Dec 2022 18:33:49 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1670380426; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=fsORcsH4qIka3hAQ6QgxbHctd0TOLsLeSHY/YRGeDL9t8gH73DFpf3CqcTec8Pc/ZDnXO3mMKts6eAKC2a8XefkgQuFZQUl7JLkQjxvXhbY9npY+tK5nMenjDLjIG1aripKONvnzRO8vanepicSI2DBmnPVmUYTd6TQJbXiwnXc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1670380426; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=ge5ilIm3mRXy8ktCuMoLvojEH2iodOCsjT5ETJ97odY=; 
        b=Y0fxKbGTtcjJ2LZKpLdWuxKqSiyrnJteGEveom+QyQY0zx3q+G4PNh/BTaUmWXOa7GBo8KFLSh+kY6LQXabvlrQRaQb96aTsfTr/jwm/y47PW/oDvJ5ahrjnT4YRnewWQcdp1EJMVtq3G2vXYb6SPZwzYmo4K8pSUrQJT4xVetI=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        spf=pass  smtp.mailfrom=business@elijahpepe.com;
        dmarc=pass header.from=<business@elijahpepe.com>
Received: from mail.zoho.com by mx.zohomail.com
        with SMTP id 1670380425452144.04957580558596; Tue, 6 Dec 2022 18:33:45 -0800 (PST)
Date:   Tue, 06 Dec 2022 18:33:45 -0800
From:   Elijah Conners <business@elijahpepe.com>
To:     "Steve French" <smfrench@gmail.com>
Cc:     "linux-cifs" <linux-cifs@vger.kernel.org>
Message-ID: <184ea6e90df.f52d35bd3574321.8379944784397668063@elijahpepe.com>
In-Reply-To: <CAH2r5msMhSTpWWkykn8rgnvKxsMf3++qg=AR+2r5SDGqj50JFg@mail.gmail.com>
References: <184e98da458.f29c50853557171.1450964771758930681@elijahpepe.com> <CAH2r5msMhSTpWWkykn8rgnvKxsMf3++qg=AR+2r5SDGqj50JFg@mail.gmail.com>
Subject: Re: [PATCH v3] cifs: add ipv6 parsing
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Importance: Medium
User-Agent: Zoho Mail
X-Mailer: Zoho Mail
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Steve French <smfrench@gmail.com> writes:
> What were changes between v2 and 3?
I addressed the whitespace issue in v2.
