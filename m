Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1501102C3
	for <lists+linux-cifs@lfdr.de>; Tue,  3 Dec 2019 17:45:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726958AbfLCQpr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Tue, 3 Dec 2019 11:45:47 -0500
Received: from mx2.suse.de ([195.135.220.15]:38510 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726186AbfLCQpr (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 3 Dec 2019 11:45:47 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 737A2B46B;
        Tue,  3 Dec 2019 16:45:45 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH][SMB3] Query timestamps on file close
In-Reply-To: <CAH2r5muXMXS6S-+XykdZmZGMQGNsTunxDXM-fqX7owEG+E=RRQ@mail.gmail.com>
References: <CAH2r5muXMXS6S-+XykdZmZGMQGNsTunxDXM-fqX7owEG+E=RRQ@mail.gmail.com>
Date:   Tue, 03 Dec 2019 17:45:44 +0100
Message-ID: <8736e1tl1j.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Steve French <smfrench@gmail.com> writes:

> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index cec53eb8a6da..8444b8425876 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
...
> @@ -2997,9 +3008,16 @@ SMB2_close(const unsigned int xid, struct cifs_tcon *tcon,
..
>  				      ses->Suid);
> +		/*
> +		 * Note that have to subtract 4 since struct network_open_info
> +		 * has a final 4 byte pad that close respose does not have
> +		 */

respose => response typo

Otherwise LGTM

Reviewed-by: Aurelien Aptel <aaptel@suse.com>

-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 Nürnberg, DE
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 247165 (AG München)
