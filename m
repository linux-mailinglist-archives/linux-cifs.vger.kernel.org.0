Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2C56F1B231D
	for <lists+linux-cifs@lfdr.de>; Tue, 21 Apr 2020 11:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728285AbgDUJpQ convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Tue, 21 Apr 2020 05:45:16 -0400
Received: from mx2.suse.de ([195.135.220.15]:46608 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728162AbgDUJpQ (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 21 Apr 2020 05:45:16 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 63B06ABF4;
        Tue, 21 Apr 2020 09:45:14 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Ronnie Sahlberg <lsahlber@redhat.com>,
        Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Subject: Re: smbinfo --version
In-Reply-To: <1484605579.23547436.1587443624135.JavaMail.zimbra@redhat.com>
References: <CAH2r5msSe_j8xyRd7noarQ-9mkiS4WmM+6w1+kLP1gYf+=0avA@mail.gmail.com>
 <1484605579.23547436.1587443624135.JavaMail.zimbra@redhat.com>
Date:   Tue, 21 Apr 2020 11:45:14 +0200
Message-ID: <87ftcx2mvp.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Ronnie Sahlberg <lsahlber@redhat.com> writes:
> Would not hurt. As it is a simple python script I expect it to have bursts of contributions and
> features added or changed quite a bit so it would be useful to easily identify the exact version of the script.

+1

I'm not sure how versioning the utils works but I hope we just have a
global cifs-utils version and we make all utils print that.

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
