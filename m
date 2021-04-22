Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4F336890B
	for <lists+linux-cifs@lfdr.de>; Fri, 23 Apr 2021 00:35:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235977AbhDVWgI (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 22 Apr 2021 18:36:08 -0400
Received: from mx.cjr.nz ([51.158.111.142]:38968 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232844AbhDVWgI (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 22 Apr 2021 18:36:08 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 543FE7FC03;
        Thu, 22 Apr 2021 22:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1619130930;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SLl9Bo6c3SDKPXWvR8ugMbHn+r5MFp3lJadaJllj4KY=;
        b=CvIJ+8UEgOQ6Rp6HM/p9h3MxGQmLzZqKI0QC4sOz4/5ZHw8Pq+kWWAg4v9y5PdL9W8JoW9
        S3oppolmWyyhEWx/hYd0WLxerfVxejZGFXrN7Ee1TEw76Z+HwEpkcw9JrjjqVHThbVGnJP
        bKzBXn1xYejThGv48Cf+GjiAUrb9fQyyEt7dah+YMht8GKhol3D2Ho7SLedrLsch6H5xqP
        ZTPGlQq/AHrwMhskZiWPBZi4Xh6GcNk5Fa7ZOL6Qkk/S6FTfBHe8dIguO79lwe5pCxVJgB
        s2rfKWZvewHOw+RwMbmhJ20hvdQHm2OJQhP1gMJ7Ws1rphQnFYovDlc0VqM9fw==
From:   Paulo Alcantara <pc@cjr.nz>
To:     David Disseldorp <ddiss@suse.de>, linux-cifs@vger.kernel.org
Cc:     David Disseldorp <ddiss@suse.de>
Subject: Re: [PATCH] cifs: fix leak in cifs_smb3_do_mount() ctx
In-Reply-To: <20210422221403.13617-1-ddiss@suse.de>
References: <20210422221403.13617-1-ddiss@suse.de>
Date:   Thu, 22 Apr 2021 19:35:15 -0300
Message-ID: <8735vi54nw.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

David Disseldorp <ddiss@suse.de> writes:

> cifs_smb3_do_mount() calls smb3_fs_context_dup() and then
> cifs_setup_volume_info(). The latter's subsequent smb3_parse_devname()
> call overwrites the cifs_sb->ctx->UNC string already dup'ed by
> smb3_fs_context_dup(), resulting in a leak. E.g.
>
> unreferenced object 0xffff888002980420 (size 32):
>   comm "mount", pid 160, jiffies 4294892541 (age 30.416s)
>   hex dump (first 32 bytes):
>     5c 5c 31 39 32 2e 31 36 38 2e 31 37 34 2e 31 30  \\192.168.174.10
>     34 5c 72 61 70 69 64 6f 2d 73 68 61 72 65 00 00  4\rapido-share..
>   backtrace:
>     [<00000000069e12f6>] kstrdup+0x28/0x50
>     [<00000000b61f4032>] smb3_fs_context_dup+0x127/0x1d0 [cifs]
>     [<00000000c6e3e3bf>] cifs_smb3_do_mount+0x77/0x660 [cifs]
>     [<0000000063467a6b>] smb3_get_tree+0xdf/0x220 [cifs]
>     [<00000000716f731e>] vfs_get_tree+0x1b/0x90
>     [<00000000491d3892>] path_mount+0x62a/0x910
>     [<0000000046b2e774>] do_mount+0x50/0x70
>     [<00000000ca7b64dd>] __x64_sys_mount+0x81/0xd0
>     [<00000000b5122496>] do_syscall_64+0x33/0x40
>     [<000000002dd397af>] entry_SYSCALL_64_after_hwframe+0x44/0xae
>
> This change is a bandaid until the cifs_setup_volume_info() TODO and
> error handling issues are resolved.
>
> Signed-off-by: David Disseldorp <ddiss@suse.de>
> ---
>  fs/cifs/cifsfs.c | 6 ++++++
>  1 file changed, 6 insertions(+)

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
