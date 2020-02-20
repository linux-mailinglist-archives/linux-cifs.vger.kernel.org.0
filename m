Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF181661FE
	for <lists+linux-cifs@lfdr.de>; Thu, 20 Feb 2020 17:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726871AbgBTQMz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Thu, 20 Feb 2020 11:12:55 -0500
Received: from mx2.suse.de ([195.135.220.15]:56622 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728387AbgBTQMz (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 20 Feb 2020 11:12:55 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 62538AAC6;
        Thu, 20 Feb 2020 16:12:54 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH] [CIFS] Add missing mount option 'signloosely' to what
 is displayed in /proc/mounts
In-Reply-To: <CAH2r5msy+zQCWdBARfdw5TTk1va3vXU9f3JcWmd_xgHASJj9jQ@mail.gmail.com>
References: <CAH2r5msy+zQCWdBARfdw5TTk1va3vXU9f3JcWmd_xgHASJj9jQ@mail.gmail.com>
Date:   Thu, 20 Feb 2020 17:12:52 +0100
Message-ID: <87r1yp5jaz.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Reviewed-by: Aurelien Aptel <aaptel@suse.com>

-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
