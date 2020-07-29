Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 988F8231FD2
	for <lists+linux-cifs@lfdr.de>; Wed, 29 Jul 2020 16:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726476AbgG2ODC convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Wed, 29 Jul 2020 10:03:02 -0400
Received: from mx2.suse.de ([195.135.220.15]:59974 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726449AbgG2ODC (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 29 Jul 2020 10:03:02 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 94FCDAC83;
        Wed, 29 Jul 2020 14:03:12 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Paul Aurich <paul@darkrain42.org>, linux-cifs@vger.kernel.org,
        sfrench@samba.org
Cc:     paul@darkrain42.org, Ronnie Sahlberg <lsahlber@redhat.com>
Subject: Re: [PATCH v4] cifs: Fix leak when handling lease break for cached
 root fid
In-Reply-To: <20200710050116.623540-1-paul@darkrain42.org>
References: <20200710050116.623540-1-paul@darkrain42.org>
Date:   Wed, 29 Jul 2020 16:02:59 +0200
Message-ID: <87lfj25sh8.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Sorry for the delay...

Reviewed-by: Aurelien Aptel <aaptel@suse.com>

-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
