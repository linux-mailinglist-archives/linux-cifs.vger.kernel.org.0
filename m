Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6038532D5C
	for <lists+linux-cifs@lfdr.de>; Mon,  3 Jun 2019 12:00:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726555AbfFCKAu convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Mon, 3 Jun 2019 06:00:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:52306 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726541AbfFCKAu (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 3 Jun 2019 06:00:50 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 713FFAF41;
        Mon,  3 Jun 2019 10:00:49 +0000 (UTC)
From:   =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>
To:     Ronnie Sahlberg <lsahlber@redhat.com>,
        linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: Re: [PATCH] cifs: fix panic in smb2_reconnect
In-Reply-To: <20190603073138.25211-1-lsahlber@redhat.com>
References: <20190603073138.25211-1-lsahlber@redhat.com>
Date:   Mon, 03 Jun 2019 12:00:47 +0200
Message-ID: <87sgsrounk.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Ronnie Sahlberg <lsahlber@redhat.com> writes:
> diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> index 565b60b62f4d..c4f3e2403b58 100644
> --- a/fs/cifs/smb2pdu.c
> +++ b/fs/cifs/smb2pdu.c
> @@ -3116,6 +3116,7 @@ void smb2_reconnect_server(struct work_struct *work)

I would add a comment here. Something like:

    /* IPC has the same lifetime as its session and uses its
       refcount */

>  		if (ses->tcon_ipc && ses->tcon_ipc->need_reconnect) {
>  			list_add_tail(&ses->tcon_ipc->rlist, &tmp_list);
>  			tcon_exist = true;
> +			ses->ses_count++;
>  		}
>  	}
>  	/*
> @@ -3134,6 +3135,8 @@ void smb2_reconnect_server(struct work_struct *work)
>  		else
>  			resched = true;
>  		list_del_init(&tcon->rlist);
> +		if (tcon->ipc)
> +			cifs_put_smb_ses(tcon->ses);
>  		cifs_put_tcon(tcon);

Since cifs_put_tcon() is a noop on IPC this looks correct but I think an
putting it in an "else" would make the logic clearer.

Reviewed-by: Aurelien Aptel <aaptel@suse.com>

-- 
Aurélien Aptel / SUSE Labs Samba Team
GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
SUSE Linux GmbH, Maxfeldstraße 5, 90409 Nürnberg, Germany
GF: Felix Imendörffer, Mary Higgins, Sri Rasiah HRB 21284 (AG Nürnberg)
