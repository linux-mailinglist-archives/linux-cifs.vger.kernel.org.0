Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3CDD23FF69
	for <lists+linux-cifs@lfdr.de>; Sun,  9 Aug 2020 19:15:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726229AbgHIRPu (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 9 Aug 2020 13:15:50 -0400
Received: from smtprelay0243.hostedemail.com ([216.40.44.243]:50462 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726210AbgHIRPu (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 9 Aug 2020 13:15:50 -0400
Received: from smtprelay.hostedemail.com (10.5.19.251.rfc1918.com [10.5.19.251])
        by smtpgrave02.hostedemail.com (Postfix) with ESMTP id 88D8B18009FF0
        for <linux-cifs@vger.kernel.org>; Sun,  9 Aug 2020 17:07:10 +0000 (UTC)
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay08.hostedemail.com (Postfix) with ESMTP id 5E97B182CED2A;
        Sun,  9 Aug 2020 17:07:09 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 50,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:41:355:379:599:960:967:973:988:989:1260:1277:1311:1313:1314:1345:1359:1437:1515:1516:1518:1534:1539:1567:1593:1594:1711:1714:1730:1747:1777:1792:2194:2198:2199:2200:2393:2525:2561:2564:2682:2685:2731:2828:2859:2933:2937:2939:2942:2945:2947:2951:2954:3022:3138:3139:3140:3141:3142:3622:3865:3866:3867:3870:3871:3934:3936:3938:3941:3944:3947:3950:3953:3956:3959:4321:5007:6119:9010:9025:10004:10400:10848:11232:11658:11914:12043:12297:12740:12760:12895:13019:13069:13200:13229:13311:13357:13439:14181:14659:14721:21080:21433:21627:30054:30091,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:0:0,LFtime:1,LUA_SUMMARY:none
X-HE-Tag: crate03_55148a926fd3
X-Filterd-Recvd-Size: 1638
Received: from XPS-9350.home (unknown [47.151.133.149])
        (Authenticated sender: joe@perches.com)
        by omf07.hostedemail.com (Postfix) with ESMTPA;
        Sun,  9 Aug 2020 17:07:08 +0000 (UTC)
Message-ID: <5788fcd4bc9d055fa40302ecb6728265c7618772.camel@perches.com>
Subject: Re: [PATCH] cifs: Convert to use the fallthrough macro
From:   Joe Perches <joe@perches.com>
To:     Steve French <smfrench@gmail.com>, linmiaohe <linmiaohe@huawei.com>
Cc:     Steve French <sfrench@samba.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>
Date:   Sun, 09 Aug 2020 10:07:07 -0700
In-Reply-To: <CAH2r5mvHLXtCAam9Wcw6PJUGg3bY8PvjYG8ijFh0km-CKNEUnA@mail.gmail.com>
References: <1596875797-22710-1-git-send-email-linmiaohe@huawei.com>
         <CAH2r5mvHLXtCAam9Wcw6PJUGg3bY8PvjYG8ijFh0km-CKNEUnA@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
User-Agent: Evolution 3.36.3-0ubuntu1 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Sun, 2020-08-09 at 11:46 -0500, Steve French wrote:
> Is this conversion from "/* Fallthrough */"   to the preferred (?)
> "fallthrough;" documented anywhere?

Documentation/process/deprecated.rst

As there have been a long list of flaws `due to missing "break" statements
<https://cwe.mitre.org/data/definitions/484.html>`_, we no longer allow
implicit fall-through. In order to identify intentional fall-through
cases, we have adopted a pseudo-keyword macro "fallthrough" which
expands to gcc's extension `__attribute__((__fallthrough__))
<https://gcc.gnu.org/onlinedocs/gcc/Statement-Attributes.html>`_.



