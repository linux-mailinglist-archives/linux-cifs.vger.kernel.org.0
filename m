Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D3E6CE5126
	for <lists+linux-cifs@lfdr.de>; Fri, 25 Oct 2019 18:24:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2505607AbfJYQYo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Fri, 25 Oct 2019 12:24:44 -0400
Received: from mx2.suse.de ([195.135.220.15]:34440 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2505599AbfJYQYn (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 25 Oct 2019 12:24:43 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 6F669B8C4;
        Fri, 25 Oct 2019 16:24:42 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Ronnie Sahlberg <lsahlber@redhat.com>,
        linux-cifs <linux-cifs@vger.kernel.org>
Subject: Re: Updated patch for the the lock_sem deadlock
In-Reply-To: <20191024235120.8059-1-lsahlber@redhat.com>
References: <20191024235120.8059-1-lsahlber@redhat.com>
Date:   Fri, 25 Oct 2019 18:24:41 +0200
Message-ID: <878sp8yera.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Ronnie Sahlberg <lsahlber@redhat.com> writes:
> This is a small update to Dave's patch to address Pavels recommendation
> that we use a helper function for the trylock/sleep loop.

Disclamer: I have not read all the emails regarding this patch but it
is not obvious to me how replacing

    lock()

by

    while (trylock())
        sleep()

is fixing things, but I'm sure I'm missing something :(

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
