Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 434F710950C
	for <lists+linux-cifs@lfdr.de>; Mon, 25 Nov 2019 22:18:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726016AbfKYVSj (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 25 Nov 2019 16:18:39 -0500
Received: from mx.cjr.nz ([51.158.111.142]:49012 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725916AbfKYVSj (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 25 Nov 2019 16:18:39 -0500
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 8F32480A53;
        Mon, 25 Nov 2019 21:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1574716717;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9b/CngWOMtwR56h+b6ZZsaxMxUpjnmIEsQ1/coH93OQ=;
        b=tF68AtQhL4wcTDpxOSRAvgCkfWZpeTeqYB6fgZyY1JQMZH2hg00NfDuoT995d8tp4OdjFC
        FfOfpOF2c814+tGGuRxmtvsaC39R7qtZrfxcOV3RsmO9KeUKcmgZDRwZLYnitBRr8dW2dy
        Dfj9TOT6E7WFJjbnnONgG5UexRBV0g9yeDW/UAq2Wrs08HE8ibaEy05THE4UQyMyLHinBH
        O+H0ZfZA4W7wr5zqwRTPK+Bsczbc9UI3X30zO/rY+HzENgLxeO/FplAA4VDMZ/KWWfvVoe
        bK9I9NDXyep1AXEaOZxQZys+jzaV52Je+obhjYpvV7rl7mdjCSwk8s9wtrO5PA==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Pavel Shilovsky <piastryyy@gmail.com>
Cc:     Steve French <smfrench@gmail.com>,
        =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>,
        linux-cifs <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH v2 4/7] cifs: Clean up DFS referral cache
In-Reply-To: <CAKywueTb_RNZKgykwrfqYaPGirzOOjfKWEqkCK7ebGd=KRipAA@mail.gmail.com>
References: <20191125165758.3793-1-pc@cjr.nz>
 <20191125165758.3793-5-pc@cjr.nz>
 <CAKywueTb_RNZKgykwrfqYaPGirzOOjfKWEqkCK7ebGd=KRipAA@mail.gmail.com>
Date:   Mon, 25 Nov 2019 18:18:32 -0300
Message-ID: <87eexvac47.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Pavel Shilovsky <piastryyy@gmail.com> writes:

> =D0=BF=D0=BD, 25 =D0=BD=D0=BE=D1=8F=D0=B1. 2019 =D0=B3. =D0=B2 09:00, Pau=
lo Alcantara (SUSE) <pc@cjr.nz>:
>>
>> This patch does a couple of things:
>>
>>   - Do some renaming in static code (cosmetic)
>>   - Use rwlock for cache list
>>   - Use spinlock for volume list
>>   - Avoid lock contention in some places
>
> Could you separate the changes into several (ideally 4) patches?  This
> patch is huge which may be a problem when viewing the changes and or
> bisecting for potential regression in future.

Sure.

Thanks!
Paulo
