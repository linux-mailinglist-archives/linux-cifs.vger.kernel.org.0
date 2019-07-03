Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DFE435ECAC
	for <lists+linux-cifs@lfdr.de>; Wed,  3 Jul 2019 21:17:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbfGCTRJ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Wed, 3 Jul 2019 15:17:09 -0400
Received: from mx2.suse.de ([195.135.220.15]:60144 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726574AbfGCTRJ (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 3 Jul 2019 15:17:09 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 3C1FAAE20;
        Wed,  3 Jul 2019 19:17:08 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>,
        linux-cifs@vger.kernel.org
Subject: Re: Many processes end up in uninterruptible sleep accessing cifs mounts
In-Reply-To: <684ed01c-cbca-2716-bc28-b0a59a0f8521@prodrive-technologies.com>
References: <684ed01c-cbca-2716-bc28-b0a59a0f8521@prodrive-technologies.com>
Date:   Wed, 03 Jul 2019 21:17:06 +0200
Message-ID: <875zojx70t.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi Martijn,

Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com> writes:
> One of the symptoms is that our monitoring system complains about not 
> being able to stat() every now and then, the next scraping cycle, stat() 
> works again. Even when the mounts are not accesses at all.
>
> Also, lot of applications get stuck on either accessing data on the 
> mounts, or performing stat() like operations on the mounts.
>
> For us, the worst part is that applications end up in 'D'. The number of 
> 'D' processes pile up really quickly, blocking users from performing 
> their work.

Gah, sorry to hear. Thanks for the report.

If you could pin down a specific way to reproduce some of those hangs
that would be of great help.

> We are running Linux 4.20.17 SMP PREEMPT on all machines. We tried 
> upgrading to > 5.x, but caused even more problems and kernel hangs.

5.0 and 5.1 really fixed a lot of issues with credits and reconnection.

> I do not really have a clue where to start debugging. I enabled kernel 
> debug options suggested on the wiki, but the amount of logging is 
> immense now.

Yes that is normal.

> Can you provide any pointers where to look or start debugging?
> Or any help on how to kill those D processes and get our Linux servers 
> stable again?

Are there any kernel oops/panic with stack traces and register dumps in
the log?

You can inspect the kernel stack trace of the hung processes (to see where
they are stuck) by printing the file /proc/<pid>/stack.

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Linux GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 21284 (AG Nürnberg)
