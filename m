Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A53CD681C
	for <lists+linux-cifs@lfdr.de>; Mon, 14 Oct 2019 19:13:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388373AbfJNRNl convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Mon, 14 Oct 2019 13:13:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:35990 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2387910AbfJNRNl (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 14 Oct 2019 13:13:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id AE1F1B71E;
        Mon, 14 Oct 2019 17:13:40 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org
Cc:     piastryyy@gmail.com, kdsouza@redhat.com, lsahlber@redhat.com
Subject: Re: [PATCH 2/2] smbinfo: rewrite in python
In-Reply-To: <20191014170738.21724-1-aaptel@suse.com>
References: <20191014170738.21724-1-aaptel@suse.com>
Date:   Mon, 14 Oct 2019 19:13:39 +0200
Message-ID: <87a7a3b67w.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org


Note that I haven't tested the `quota` and `list-snapshots` sub-commands
as I don't know how to set that up easily on my Windows Server vm (let
me know how if you know, thx) so please give it a try, these are
untested.

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
