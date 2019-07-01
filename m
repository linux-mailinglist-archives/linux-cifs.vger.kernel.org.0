Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C4BEF5BC0F
	for <lists+linux-cifs@lfdr.de>; Mon,  1 Jul 2019 14:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727469AbfGAMqs convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Mon, 1 Jul 2019 08:46:48 -0400
Received: from mx2.suse.de ([195.135.220.15]:50558 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726329AbfGAMqs (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 1 Jul 2019 08:46:48 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 57B23AF2C;
        Mon,  1 Jul 2019 12:46:47 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: Minor cleanup of compound_send_recv
In-Reply-To: <CAH2r5mvobnG1wvyk-ymMKKUCRsAzn2ky8jA8YguFFaUjsVihGw@mail.gmail.com>
References: <CAH2r5mvobnG1wvyk-ymMKKUCRsAzn2ky8jA8YguFFaUjsVihGw@mail.gmail.com>
Date:   Mon, 01 Jul 2019 14:46:46 +0200
Message-ID: <87imslapmx.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi,

I was away for 2 weeks, reading through all my emails now.

Steve French <smfrench@gmail.com> writes:
> In Aurelien's earlier patch series I noticed a cleanup (converting
> ses->server to a local variable server=ses->server) which made code
> easier to read in this function.  This doesn't require compounding but
> probably helps his

Assuming we keep my approach that is a good idea, thanks.

-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Linux GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 21284 (AG Nürnberg)
