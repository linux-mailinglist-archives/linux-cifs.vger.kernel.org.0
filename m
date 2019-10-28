Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 20A06E70EB
	for <lists+linux-cifs@lfdr.de>; Mon, 28 Oct 2019 13:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388739AbfJ1MFX convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Mon, 28 Oct 2019 08:05:23 -0400
Received: from mx2.suse.de ([195.135.220.15]:53534 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726931AbfJ1MFX (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 28 Oct 2019 08:05:23 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 23123B1C2;
        Mon, 28 Oct 2019 12:05:22 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     David Wysochanski <dwysocha@redhat.com>
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>,
        linux-cifs <linux-cifs@vger.kernel.org>
Subject: Re: Updated patch for the the lock_sem deadlock
In-Reply-To: <CALF+zOnNFSD2jsaGD1Ben1J3NBN=9TkgUUpgQkekK1jCAGwnhw@mail.gmail.com>
References: <20191024235120.8059-1-lsahlber@redhat.com>
 <878sp8yera.fsf@suse.com>
 <CALF+zOnNFSD2jsaGD1Ben1J3NBN=9TkgUUpgQkekK1jCAGwnhw@mail.gmail.com>
Date:   Mon, 28 Oct 2019 13:05:21 +0100
Message-ID: <875zk9xegu.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

David Wysochanski <dwysocha@redhat.com> writes:
> The patch removes thread2 from blocking, so #3 will never occur, hence
> removing the deadlock.

Thas was a great explanation, thanks!

-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
