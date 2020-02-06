Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 089FD153F5A
	for <lists+linux-cifs@lfdr.de>; Thu,  6 Feb 2020 08:47:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727860AbgBFHrk convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Thu, 6 Feb 2020 02:47:40 -0500
Received: from mx2.suse.de ([195.135.220.15]:51630 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727768AbgBFHrk (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 6 Feb 2020 02:47:40 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 86837AEC4;
        Thu,  6 Feb 2020 07:47:35 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH] cifs: fail i/o on soft mounts if sessionsetup errors out
In-Reply-To: <CAH2r5mt+d_NTaA40-4nKRSdr3qXdtLjhPPLos99azYyK8hde5g@mail.gmail.com>
References: <20200205010801.27759-1-lsahlber@redhat.com>
 <CAH2r5mt+d_NTaA40-4nKRSdr3qXdtLjhPPLos99azYyK8hde5g@mail.gmail.com>
Date:   Thu, 06 Feb 2020 08:47:32 +0100
Message-ID: <874kw4nomj.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Steve French <smfrench@gmail.com> writes:
>> If we have a soft mount we should fail commands for session-setup
>> failures (such as the password having changed/ account being deleted/ ...)
>> and return an error back to the application.

Looks good to me but we need to make sure it doesnt break failover on the
buildbot.

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
