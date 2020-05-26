Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D5241A3220
	for <lists+linux-cifs@lfdr.de>; Thu,  9 Apr 2020 11:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgDIJzN convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Thu, 9 Apr 2020 05:55:13 -0400
Received: from mx2.suse.de ([195.135.220.15]:46548 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726632AbgDIJzN (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 9 Apr 2020 05:55:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 6E835AC24;
        Thu,  9 Apr 2020 09:55:12 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH][SMB3.1.1 POSIX] Change noisy debug message to an FYI
In-Reply-To: <CAH2r5mta--YFUVWWf89bCBvdjrDh_vaC4ty8Qphsy5W1fDuOYw@mail.gmail.com>
References: <CAH2r5mta--YFUVWWf89bCBvdjrDh_vaC4ty8Qphsy5W1fDuOYw@mail.gmail.com>
Date:   Thu, 09 Apr 2020 11:55:10 +0200
Message-ID: <877dypdlvl.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Steve French <smfrench@gmail.com> writes:
>     The noisy posix error message in readdir was supposed
>     to be an FYI (not enabled by default)
>       CIFS VFS: XXX dev 66306, reparse 0, mode 755

Oops, the XXX was not supposed to be there either. Can you remove it?

Cheers,
-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
