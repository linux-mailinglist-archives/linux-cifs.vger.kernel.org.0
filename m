Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD6D20D4D5
	for <lists+linux-cifs@lfdr.de>; Mon, 29 Jun 2020 21:15:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbgF2TLY convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Mon, 29 Jun 2020 15:11:24 -0400
Received: from mx2.suse.de ([195.135.220.15]:53592 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731053AbgF2TLY (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 29 Jun 2020 15:11:24 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AF1EFAC9F;
        Mon, 29 Jun 2020 09:59:11 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Paul Aurich <paul@darkrain42.org>, linux-cifs@vger.kernel.org,
        sfrench@samba.org
Cc:     paul@darkrain42.org, Ronnie Sahlberg <lsahlber@redhat.com>
Subject: Re: [PATCH] cifs: Fix leak when handling lease break for cached
 root fid
In-Reply-To: <20200626200248.431426-1-paul@darkrain42.org>
References: <20200626200248.431426-1-paul@darkrain42.org>
Date:   Mon, 29 Jun 2020 11:59:10 +0200
Message-ID: <87wo3qgpld.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi,

Good catch! Change looks good to me but I think we should move lw
allocation inside smb2_tcon_has_lease() so that we don't have to track
it across multiple functions as it is only used there. Could you send a
v2 doing that?

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
