Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 79E53BD41C
	for <lists+linux-cifs@lfdr.de>; Tue, 24 Sep 2019 23:16:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410783AbfIXVQS convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Tue, 24 Sep 2019 17:16:18 -0400
Received: from mx2.suse.de ([195.135.220.15]:57622 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2410672AbfIXVQS (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 24 Sep 2019 17:16:18 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 848C3AC84;
        Tue, 24 Sep 2019 21:16:16 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH] CIFS: fix max ea value size
In-Reply-To: <20190922012501.g6yon32sxlzdvkgj@XZHOUW.usersys.redhat.com>
References: <20190921112600.utzouyddp3cdmxhe@XZHOUW.usersys.redhat.com>
 <878sqhfqzf.fsf@suse.com>
 <20190922012501.g6yon32sxlzdvkgj@XZHOUW.usersys.redhat.com>
Date:   Tue, 24 Sep 2019 23:16:10 +0200
Message-ID: <877e5x5rad.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

"Murphy Zhou" <jencce.kernel@gmail.com> writes:
> No need. Slab size includes the bufzise and the header size.
>
>> And if we set multiple EA at the same time it has to be divided
>> by the number of EAs etc...
>
> They will be handled separately and slab will work well.

Oh, you are right, I have no more remarks then.
We reviewed this with steve.

Thanks
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
