Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55E4C181693
	for <lists+linux-cifs@lfdr.de>; Wed, 11 Mar 2020 12:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726310AbgCKLOU convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Wed, 11 Mar 2020 07:14:20 -0400
Received: from mx2.suse.de ([195.135.220.15]:37156 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725834AbgCKLOT (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 11 Mar 2020 07:14:19 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id C9EB2AED2;
        Wed, 11 Mar 2020 11:14:18 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH][SMB3] Increment num_remote_opens stats counter even in
 case of smb2_query_dir_first
In-Reply-To: <CAH2r5mumjsORpsk6kp-Xp=v1+D340y_pq8Am04zjDaam2Bxzsw@mail.gmail.com>
References: <CAH2r5mumjsORpsk6kp-Xp=v1+D340y_pq8Am04zjDaam2Bxzsw@mail.gmail.com>
Date:   Wed, 11 Mar 2020 12:14:17 +0100
Message-ID: <87zhcnkut2.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Good catch! Usually compounded chains do both open and close so they
don't need to update the counter but this one doesn't close.

Reviewed-by: Aurelien Aptel <aaptel@suse.com>

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
