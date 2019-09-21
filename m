Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 715A3B9F62
	for <lists+linux-cifs@lfdr.de>; Sat, 21 Sep 2019 20:23:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732281AbfIUSXj convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Sat, 21 Sep 2019 14:23:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:40704 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732278AbfIUSXj (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sat, 21 Sep 2019 14:23:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 00C8DAE1A;
        Sat, 21 Sep 2019 18:23:38 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Murphy Zhou <jencce.kernel@gmail.com>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH] CIFS: fix max ea value size
In-Reply-To: <20190921112600.utzouyddp3cdmxhe@XZHOUW.usersys.redhat.com>
References: <20190921112600.utzouyddp3cdmxhe@XZHOUW.usersys.redhat.com>
Date:   Sat, 21 Sep 2019 20:23:32 +0200
Message-ID: <878sqhfqzf.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

"Murphy Zhou" <jencce.kernel@gmail.com> writes:
> It should not be larger then the slab max buf size. If user
> specifies a larger size, it passes this check and goes
> straightly to SMB2_set_info_init performing an insecure memcpy.

It's even smaller than that as CIFSMaxBufSize is the max size for the
whole packet IIRC. The EA payload needs to fit into that. So it should
be CIFSMaxBufSize-(largest SMB2 header size + Set EA initial
header). And if we set multiple EA at the same time it has to be divided
by the number of EAs etc...

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
