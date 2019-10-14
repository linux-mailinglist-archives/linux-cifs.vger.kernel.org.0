Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 44FCED5EFD
	for <lists+linux-cifs@lfdr.de>; Mon, 14 Oct 2019 11:33:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730860AbfJNJc7 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Mon, 14 Oct 2019 05:32:59 -0400
Received: from mx2.suse.de ([195.135.220.15]:52602 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730667AbfJNJc7 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 14 Oct 2019 05:32:59 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id D48A9BC8C;
        Mon, 14 Oct 2019 09:32:57 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     ronnie sahlberg <ronniesahlberg@gmail.com>,
        Roberto Bergantinos Corpas <rbergant@redhat.com>
Cc:     "samba-technical\@lists.samba.org" <samba-technical@lists.samba.org>,
        Steve French <sfrench@samba.org>,
        linux-cifs <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH] CIFS: avoid using MID 0xFFFF
In-Reply-To: <CAN05THQTb=aechQB5rqUxZLpfwocqfLPMVW5mAz4F5dn3ryj0w@mail.gmail.com>
References: <20191014085923.14967-1-rbergant@redhat.com>
 <CAN05THQTb=aechQB5rqUxZLpfwocqfLPMVW5mAz4F5dn3ryj0w@mail.gmail.com>
Date:   Mon, 14 Oct 2019 11:32:56 +0200
Message-ID: <87ftjvbrjr.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

"ronnie sahlberg" <ronniesahlberg@gmail.com> writes:
> Steve, can we get this pushed to linus soonish?  It is a bad issue.

Probably a good idea to CC: stable 

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
