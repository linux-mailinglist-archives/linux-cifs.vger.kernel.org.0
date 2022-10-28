Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 745586109CA
	for <lists+linux-cifs@lfdr.de>; Fri, 28 Oct 2022 07:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJ1FmA (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 28 Oct 2022 01:42:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229799AbiJ1Fl7 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 28 Oct 2022 01:41:59 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 053471863E5;
        Thu, 27 Oct 2022 22:41:54 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id z24so7030508ljn.4;
        Thu, 27 Oct 2022 22:41:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=UMDC/dOy4cljPNRTKHBYaRwX000WJ6DjueBu7SmlAg8=;
        b=CVAHJsq6SxixoOWMCGb5QpSJqkLw0tqM4JzUMRRUXerlDl3W2U8/1jTgQDTpzp13il
         p9MfXRinI4Z0TtL6IgCsiepM6mjGo6CNgGGYtY2drggN4u8HiL2cq8wreawvqyKn0LXn
         qeLiiIv8jhsxhuhyjDRjdWnueZU7ls9kiJiQ5sc2Fz5tsuqCuiXV+pm8Z8n6k5+iHS/h
         DRchu+fGSXN2Y1w+BNHxOgHWQLaBAAeZB+zjOwy1+JB6SldALiX9fWd5atSRhCANLIxb
         mhxdLllP3o8tXfB0OvyE1Mn7sxTodtBGS650IBcob1g4fEZw4ctBwAfvq7z3AegLk334
         +2Bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UMDC/dOy4cljPNRTKHBYaRwX000WJ6DjueBu7SmlAg8=;
        b=vMegmSvncaOaoU42i6QIWcitm95k4dtOx/8P0FlRyz9+coWjHUdiglg5sjklh4F90b
         z1VBgi+Pwoqnotv0SF3XmXRUIJL6U6gFmfw7acasz2oKCe2oY/9aP/ACJaFi8L4P/Ry2
         D+OG3RKvLgA+cHi4zJN2wk+Y2x7l76iI1NcwDYLJFsA+p4DXe2zkfa5Ntudv6enRCWyr
         B2Y8RDP7sjtfr9ggKCTGzID6eYFirCF1ZvD9L3MS9oIaypAfKYLj6E/fLbFBpHvgCAaL
         6tQ8MvueX0fo+X7Kwi6cnMsQoCj0wkmRv84degFvXeIMbGOf+VFfCv7/1jOZp7ZDvbLZ
         Jzxw==
X-Gm-Message-State: ACrzQf3dnVlp76gT5jiGiHMh7I2xZhrmAmEJytvMSxyBrdtqXhEqYisA
        zrlToYv6UKnKIkjchfGF7QiZEShxgEZvSqB9iiM=
X-Google-Smtp-Source: AMsMyM7693AnLxq2N/ho3oYaoWG0coWbVHn6THOF59OEVVCdrYRCWzzcf089xBN4D4YeH9Vq3b2xaUHQi0O64Y38jAM=
X-Received: by 2002:a2e:a7d6:0:b0:277:221a:eb3 with SMTP id
 x22-20020a2ea7d6000000b00277221a0eb3mr4611995ljp.476.1666935712686; Thu, 27
 Oct 2022 22:41:52 -0700 (PDT)
MIME-Version: 1.0
References: <20221027124528.2487025-1-zengheng4@huawei.com>
In-Reply-To: <20221027124528.2487025-1-zengheng4@huawei.com>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Fri, 28 Oct 2022 11:11:40 +0530
Message-ID: <CANT5p=q50Kt+eyVaxyh891sizFSzC=eUp5P46ON-odHFRjMsEQ@mail.gmail.com>
Subject: Re: [PATCH v4] cifs: fix use-after-free caused by invalid pointer `hostname`
To:     Zeng Heng <zengheng4@huawei.com>
Cc:     sfrench@samba.org, tom@talpey.com, sprasad@microsoft.com,
        pc@cjr.nz, lsahlber@redhat.com, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-kernel@vger.kernel.org,
        liwei391@huawei.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Thu, Oct 27, 2022 at 6:19 PM Zeng Heng <zengheng4@huawei.com> wrote:
>
> `hostname` needs to be set as null-pointer after free in
> `cifs_put_tcp_session` function, or when `cifsd` thread attempts
> to resolve hostname and reconnect the host, the thread would deref
> the invalid pointer.
>
> Here is one of practical backtrace examples as reference:
>
> Task 477
> ---------------------------
>  do_mount
>   path_mount
>    do_new_mount
>     vfs_get_tree
>      smb3_get_tree
>       smb3_get_tree_common
>        cifs_smb3_do_mount
>         cifs_mount
>          mount_put_conns
>           cifs_put_tcp_session
>           --> kfree(server->hostname)
>
> cifsd
> ---------------------------
>  kthread
>   cifs_demultiplex_thread
>    cifs_reconnect
>     reconn_set_ipaddr_from_hostname
>     --> if (!server->hostname)
>     --> if (server->hostname[0] == '\0')  // !! UAF fault here
>
> CIFS: VFS: cifs_mount failed w/return code = -112
> mount error(112): Host is down
> BUG: KASAN: use-after-free in reconn_set_ipaddr_from_hostname+0x2ba/0x310
> Read of size 1 at addr ffff888108f35380 by task cifsd/480
> CPU: 2 PID: 480 Comm: cifsd Not tainted 6.1.0-rc2-00106-gf705792f89dd-dirty #25
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1ubuntu1.1 04/01/2014
> Call Trace:
>  <TASK>
>  dump_stack_lvl+0x68/0x85
>  print_report+0x16c/0x4a3
>  kasan_report+0x95/0x190
>  reconn_set_ipaddr_from_hostname+0x2ba/0x310
>  __cifs_reconnect.part.0+0x241/0x800
>  cifs_reconnect+0x65f/0xb60
>  cifs_demultiplex_thread+0x1570/0x2570
>  kthread+0x2c5/0x380
>  ret_from_fork+0x22/0x30
>  </TASK>
> Allocated by task 477:
>  kasan_save_stack+0x1e/0x40
>  kasan_set_track+0x21/0x30
>  __kasan_kmalloc+0x7e/0x90
>  __kmalloc_node_track_caller+0x52/0x1b0
>  kstrdup+0x3b/0x70
>  cifs_get_tcp_session+0xbc/0x19b0
>  mount_get_conns+0xa9/0x10c0
>  cifs_mount+0xdf/0x1970
>  cifs_smb3_do_mount+0x295/0x1660
>  smb3_get_tree+0x352/0x5e0
>  vfs_get_tree+0x8e/0x2e0
>  path_mount+0xf8c/0x1990
>  do_mount+0xee/0x110
>  __x64_sys_mount+0x14b/0x1f0
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> Freed by task 477:
>  kasan_save_stack+0x1e/0x40
>  kasan_set_track+0x21/0x30
>  kasan_save_free_info+0x2a/0x50
>  __kasan_slab_free+0x10a/0x190
>  __kmem_cache_free+0xca/0x3f0
>  cifs_put_tcp_session+0x30c/0x450
>  cifs_mount+0xf95/0x1970
>  cifs_smb3_do_mount+0x295/0x1660
>  smb3_get_tree+0x352/0x5e0
>  vfs_get_tree+0x8e/0x2e0
>  path_mount+0xf8c/0x1990
>  do_mount+0xee/0x110
>  __x64_sys_mount+0x14b/0x1f0
>  do_syscall_64+0x3b/0x90
>  entry_SYSCALL_64_after_hwframe+0x63/0xcd
> The buggy address belongs to the object at ffff888108f35380
>  which belongs to the cache kmalloc-16 of size 16
> The buggy address is located 0 bytes inside of
>  16-byte region [ffff888108f35380, ffff888108f35390)
> The buggy address belongs to the physical page:
> page:00000000333f8e58 refcount:1 mapcount:0 mapping:0000000000000000 index:0xffff888108f350e0 pfn:0x108f35
> flags: 0x200000000000200(slab|node=0|zone=2)
> raw: 0200000000000200 0000000000000000 dead000000000122 ffff8881000423c0
> raw: ffff888108f350e0 000000008080007a 00000001ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
> Memory state around the buggy address:
>  ffff888108f35280: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
>  ffff888108f35300: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
> >ffff888108f35380: fa fb fc fc fa fb fc fc fa fb fc fc fa fb fc fc
>                    ^
>  ffff888108f35400: fa fb fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>  ffff888108f35480: fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc fc
>
> Fixes: 7be3248f3139 ("cifs: To match file servers, make sure the server hostname matches")
> Signed-off-by: Zeng Heng <zengheng4@huawei.com>
> Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
> ---
> changes in v4:
>  - correct fix tag
>  - add reviewed-by
> ---
>  fs/cifs/connect.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index ffb291579bb9..1cc47dd3b4d6 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -1584,6 +1584,7 @@ cifs_put_tcp_session(struct TCP_Server_Info *server, int from_reconnect)
>         server->session_key.response = NULL;
>         server->session_key.len = 0;
>         kfree(server->hostname);
> +       server->hostname = NULL;
>
>         task = xchg(&server->tsk, NULL);
>         if (task)
> --
> 2.25.1
>

Good catch. But I think there can be a better fix.
How about moving the lines that follow i.e. cifsd thread kill to
before setting tcpStatus? That way, we don't leave scope for things to
race.

-- 
Regards,
Shyam
