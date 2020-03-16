Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E534C186972
	for <lists+linux-cifs@lfdr.de>; Mon, 16 Mar 2020 11:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730478AbgCPKud convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Mon, 16 Mar 2020 06:50:33 -0400
Received: from mx2.suse.de ([195.135.220.15]:51758 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730612AbgCPKud (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 16 Mar 2020 06:50:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id EA92DAE2B;
        Mon, 16 Mar 2020 10:50:31 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Subject: Re: [SMB3] New compression flags
In-Reply-To: <CAH2r5ms_oxqwHm56nzabM-x2XMR1Ni-WD1_LEYYxOW_NkswsOQ@mail.gmail.com>
References: <CAH2r5ms_oxqwHm56nzabM-x2XMR1Ni-WD1_LEYYxOW_NkswsOQ@mail.gmail.com>
Date:   Mon, 16 Mar 2020 11:50:30 +0100
Message-ID: <87sgi8mv49.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi,

Changes looks good.

I had a quick look at this new stuff with Pike recently but it seems
even the latest windows server (1909) doesn't support it yet (not
returned in negprot).

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
