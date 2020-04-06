Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E30C719F327
	for <lists+linux-cifs@lfdr.de>; Mon,  6 Apr 2020 12:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726799AbgDFKBm convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Mon, 6 Apr 2020 06:01:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:36756 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726784AbgDFKBm (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 6 Apr 2020 06:01:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 9DEE3AC11;
        Mon,  6 Apr 2020 10:01:40 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Pavel Shilovsky <piastryyy@gmail.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>,
        Steve French <smfrench@gmail.com>
Subject: Re: [PATCH v2] cifs: ignore cached share root handle closing errors
In-Reply-To: <CAKywueSjjN+w6v76BSNLW4EFmSi4WAma4XTL2H2xQYhnes63+g@mail.gmail.com>
References: <20200401125026.4899-1-aaptel@suse.com>
 <CAKywueSjjN+w6v76BSNLW4EFmSi4WAma4XTL2H2xQYhnes63+g@mail.gmail.com>
Date:   Mon, 06 Apr 2020 12:01:39 +0200
Message-ID: <87lfn9lypo.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi Pavel,

Thanks for the review, will send v3 :)

I thought this one would be of interest to you as it's related to your
patch in the Fixes tag.

I've noticed the shared root handle is causing us lots of issues
lately. Paulo is working on a DFS bug related to it too (when switching
servers the handle becomes invalid).

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
