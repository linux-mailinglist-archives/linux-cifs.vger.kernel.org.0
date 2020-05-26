Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 445F61B2390
	for <lists+linux-cifs@lfdr.de>; Tue, 21 Apr 2020 12:04:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727120AbgDUKEI (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 21 Apr 2020 06:04:08 -0400
Received: from mail.kernel.org ([198.145.29.99]:39214 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725920AbgDUKEH (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 21 Apr 2020 06:04:07 -0400
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 533F82076C;
        Tue, 21 Apr 2020 10:04:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587463447;
        bh=ANKsXGI8fe8Neh9lCdsV+vvune8oPz4m26bCVIYfm4k=;
        h=Subject:From:To:Date:In-Reply-To:References:From;
        b=Ls27JrX555+Yu68ccfsqgzsjRi03S6nWKyfMV1hbdYSDVPbWTHZqxc+90tpfMT8Vm
         V0qBixvh3mUaZo8m2kLWKyAgCaJZVr6CmLKiL8iwgXvIvylqKf95dBu3V9aNDd3xJV
         t/JoVhYKf6G6/3YOL6iQtxpmj1JAdDSavlD7Kcvg=
Message-ID: <4d83f046d90b3a752e42608aef598c414a4a6c88.camel@kernel.org>
Subject: Re: [PATCH] cifs: protect updating server->dstaddr with a spinlock
From:   Jeff Layton <jlayton@kernel.org>
To:     Ronnie Sahlberg <lsahlber@redhat.com>,
        linux-cifs <linux-cifs@vger.kernel.org>
Date:   Tue, 21 Apr 2020 06:04:06 -0400
In-Reply-To: <20200421023739.10708-1-lsahlber@redhat.com>
References: <20200421023739.10708-1-lsahlber@redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Tue, 2020-04-21 at 12:37 +1000, Ronnie Sahlberg wrote:
> We use a spinlock while we are reading and accessing the destination address for a server.
> We need to also use this spinlock to protect when we are modifying this adress from
> reconn_set_ipaddr().
> 
> Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> ---
>  fs/cifs/connect.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index 95b3ab0ca8c0..63830f228b4a 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -375,8 +375,10 @@ static int reconn_set_ipaddr(struct TCP_Server_Info *server)
>  		return rc;
>  	}
>  
> +	spin_lock(&cifs_tcp_ses_lock);
>  	rc = cifs_convert_address((struct sockaddr *)&server->dstaddr, ipaddr,
>  				  strlen(ipaddr));
> +	spin_unlock(&cifs_tcp_ses_lock);
>  	kfree(ipaddr);
>  
>  	return !rc ? -1 : 0;

Reviewed-by: Jeff Layton <jlayton@kernel.org>

