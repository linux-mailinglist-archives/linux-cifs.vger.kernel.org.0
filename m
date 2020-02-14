Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1594915D764
	for <lists+linux-cifs@lfdr.de>; Fri, 14 Feb 2020 13:26:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728748AbgBNM0t (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 14 Feb 2020 07:26:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728369AbgBNM0t (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 14 Feb 2020 07:26:49 -0500
Received: from tleilax.poochiereds.net (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F26242168B;
        Fri, 14 Feb 2020 12:26:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581683208;
        bh=PidKQNyrM3sHIFiFwwnXoclRaogibGnkeYPE3RMWjPY=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=e31p5DS9Ojgy/qeD3tr93Rop9ic4vFpb/KFyvX3itiTn3Vqkv+xOG4llaGRsvz/en
         uvh5NZyy9PWs0tCGyRrpQ0IYJTnf6zGiiMpC6t8n+D9nzX+SHYClm56SJowSqXkDCG
         Gtq4Ihg3WsfbI60wDzmWA1qogXoczNFgrtmOuN00=
Message-ID: <370134c148a5f4d12df31a3a9020b66ef316a004.camel@kernel.org>
Subject: Re: [PATCH] CIFS: unlock file across process
From:   Jeff Layton <jlayton@kernel.org>
To:     Murphy Zhou <jencce.kernel@gmail.com>, linux-cifs@vger.kernel.org
Cc:     Steve French <smfrench@gmail.com>
Date:   Fri, 14 Feb 2020 07:26:46 -0500
In-Reply-To: <20200214043513.uh2jtb62qf54nmud@xzhoux.usersys.redhat.com>
References: <20200214043513.uh2jtb62qf54nmud@xzhoux.usersys.redhat.com>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.3 (3.34.3-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Fri, 2020-02-14 at 12:35 +0800, Murphy Zhou wrote:
> Now child can't unlock the same file that has been locked by
> parent. Fix this by not skipping unlock if requesting from
> different process.
> 
> Patch tested by LTP and xfstests using samba server.
> 
> Signed-off-by: Murphy Zhou <jencce.kernel@gmail.com>
> ---
>  fs/cifs/smb2file.c | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/fs/cifs/smb2file.c b/fs/cifs/smb2file.c
> index afe1f03aabe3..b5bca0e13d51 100644
> --- a/fs/cifs/smb2file.c
> +++ b/fs/cifs/smb2file.c
> @@ -151,8 +151,6 @@ smb2_unlock_range(struct cifsFileInfo *cfile, struct file_lock *flock,
>  		    (flock->fl_start + length) <
>  		    (li->offset + li->length))
>  			continue;
> -		if (current->tgid != li->pid)
> -			continue;
>  		if (cinode->can_cache_brlcks) {
>  			/*
>  			 * We can cache brlock requests - simply remove a lock

I'm not as familiar with this code as I once was, but...

From fork(2) manpage:

       *  The  child does not inherit process-associated record locks from its
          parent (fcntl(2)).  (On the other hand,  it  does  inherit  fcntl(2)
          open file description locks and flock(2) locks from its parent.)

It looks like cifs_setlk calls mand_unlock_range, and that gets called
from both fcntl and flock codepaths.

So, I'm not sure about just removing this. It seems like the pid check
is probably correct for traditional posix locks, but probably not for
OFD and flock locks? What ensures that completely unrelated tasks can't
unlock your locks?
-- 
Jeff Layton <jlayton@kernel.org>

