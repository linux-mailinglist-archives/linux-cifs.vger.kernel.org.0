Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E166F10893A
	for <lists+linux-cifs@lfdr.de>; Mon, 25 Nov 2019 08:34:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727127AbfKYHe1 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 25 Nov 2019 02:34:27 -0500
Received: from mail-il1-f195.google.com ([209.85.166.195]:36998 "EHLO
        mail-il1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725747AbfKYHe0 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 25 Nov 2019 02:34:26 -0500
Received: by mail-il1-f195.google.com with SMTP id s5so13272719iln.4
        for <linux-cifs@vger.kernel.org>; Sun, 24 Nov 2019 23:34:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pEMUGJWYTwPSyydTI+RdQy3OSEpBsgCFDNlSD6VASZI=;
        b=m0JEuVuEweFXGx8kOwCKEsroOIVnvhE/1mz+twG2IuEudo227l1LWMifkjptypejsP
         xt3nuMjXnJNsN/t+KbjSyl4oEaa46b+0lrjUumIyqpVprn4/v6oSlYKMpFV9NzjwpSI2
         hKVgJKwb8ilkfLMZ9JlNVDlgJhi3opJ2OVc0ZskmfDASehrj+JbLMeOCVpkz6bnVcven
         7tOFK0KFIT6KT5wV7eS1uPQqnX9C82Mo3MsZ2EVbquUNLgO3L/mqL05zu0LhPBB8hlca
         LDqcC9dcYHaNt30i6lY5+JDrBR3kyGdZRolhSCsQCu5W555uxBFMjc2o+nZXu9xG8mKV
         3yQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pEMUGJWYTwPSyydTI+RdQy3OSEpBsgCFDNlSD6VASZI=;
        b=RX/PsUKT8fxloOWGaQYXSHkzZ3kAqtOaQRub42huZ+a7oZIKs+sjScwTo4jc8BTT2T
         R95Ak5t368oiuoo4EEx+MawFye+sWvEuWnXZPlViAM3gAumhjLXKdTZmm6QwZsXnLM8/
         dFNvmQFvS2QDkArUCjhLUt6uk9vI22WEXN8O+3uEj1cGMJ+ppjt3+y7DYGmrR4gObMFh
         2cNwvmIIclu4s4qIxD8BeCJaZoMlsz+/Mbgh6CEWoP8ooPAJXdsdK8cTI2a/NjkTGPBA
         INVVC+ZLogZffjHZBGLR6rPBBhD5z0niIBFZhcN55t9Ay8Ynp6My1Dw9pOj2dBWQ4OTN
         wQuw==
X-Gm-Message-State: APjAAAUeFHoyQa1IFJ9VQ3XUenGW28c9TBs9wgmr1nHvkwx+lqhInwLd
        HSnCZooxtTVsuF9O26qcr29rSUWATI+xY7jejRMCEg==
X-Google-Smtp-Source: APXvYqyXN3hd50/zbCxWvRWgREUC0kTILdhL+RzcHhVhxiYwXqpT6hC1gpHjUNXkMN/9jZ0NIqfXxAn97kagPyNmwAg=
X-Received: by 2002:a92:381c:: with SMTP id f28mr31237323ila.169.1574667265728;
 Sun, 24 Nov 2019 23:34:25 -0800 (PST)
MIME-Version: 1.0
References: <20191122153057.6608-1-pc@cjr.nz> <20191122153057.6608-2-pc@cjr.nz>
In-Reply-To: <20191122153057.6608-2-pc@cjr.nz>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 25 Nov 2019 01:34:14 -0600
Message-ID: <CAH2r5mt0ZQyq=x_65y0sTH9k-3wA+QJp_bZdBHoqA079GdyKfA@mail.gmail.com>
Subject: Re: [PATCH 1/7] cifs: Fix use-after-free bug in cifs_reconnect()
To:     "Paulo Alcantara (SUSE)" <pc@cjr.nz>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

merged into cifs-2.6.git for-next pending testing and more reviews

On Fri, Nov 22, 2019 at 9:31 AM Paulo Alcantara (SUSE) <pc@cjr.nz> wrote:
>
> Ensure we grab an active reference in cifs superblock while doing
> failover to prevent automounts (DFS links) of expiring and then
> destroying the superblock pointer.
>
> This patch fixes the following KASAN report:
>
> [  464.301462] BUG: KASAN: use-after-free in
> cifs_reconnect+0x6ab/0x1350
> [  464.303052] Read of size 8 at addr ffff888155e580d0 by task
> cifsd/1107
>
> [  464.304682] CPU: 3 PID: 1107 Comm: cifsd Not tainted 5.4.0-rc4+ #13
> [  464.305552] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009),
> BIOS rel-1.12.1-0-ga5cab58-rebuilt.opensuse.org 04/01/2014
> [  464.307146] Call Trace:
> [  464.307875]  dump_stack+0x5b/0x90
> [  464.308631]  print_address_description.constprop.0+0x16/0x200
> [  464.309478]  ? cifs_reconnect+0x6ab/0x1350
> [  464.310253]  ? cifs_reconnect+0x6ab/0x1350
> [  464.311040]  __kasan_report.cold+0x1a/0x41
> [  464.311811]  ? cifs_reconnect+0x6ab/0x1350
> [  464.312563]  kasan_report+0xe/0x20
> [  464.313300]  cifs_reconnect+0x6ab/0x1350
> [  464.314062]  ? extract_hostname.part.0+0x90/0x90
> [  464.314829]  ? printk+0xad/0xde
> [  464.315525]  ? _raw_spin_lock+0x7c/0xd0
> [  464.316252]  ? _raw_read_lock_irq+0x40/0x40
> [  464.316961]  ? ___ratelimit+0xed/0x182
> [  464.317655]  cifs_readv_from_socket+0x289/0x3b0
> [  464.318386]  cifs_read_from_socket+0x98/0xd0
> [  464.319078]  ? cifs_readv_from_socket+0x3b0/0x3b0
> [  464.319782]  ? try_to_wake_up+0x43c/0xa90
> [  464.320463]  ? cifs_small_buf_get+0x4b/0x60
> [  464.321173]  ? allocate_buffers+0x98/0x1a0
> [  464.321856]  cifs_demultiplex_thread+0x218/0x14a0
> [  464.322558]  ? cifs_handle_standard+0x270/0x270
> [  464.323237]  ? __switch_to_asm+0x40/0x70
> [  464.323893]  ? __switch_to_asm+0x34/0x70
> [  464.324554]  ? __switch_to_asm+0x40/0x70
> [  464.325226]  ? __switch_to_asm+0x40/0x70
> [  464.325863]  ? __switch_to_asm+0x34/0x70
> [  464.326505]  ? __switch_to_asm+0x40/0x70
> [  464.327161]  ? __switch_to_asm+0x34/0x70
> [  464.327784]  ? finish_task_switch+0xa1/0x330
> [  464.328414]  ? __switch_to+0x363/0x640
> [  464.329044]  ? __schedule+0x575/0xaf0
> [  464.329655]  ? _raw_spin_lock_irqsave+0x82/0xe0
> [  464.330301]  kthread+0x1a3/0x1f0
> [  464.330884]  ? cifs_handle_standard+0x270/0x270
> [  464.331624]  ? kthread_create_on_node+0xd0/0xd0
> [  464.332347]  ret_from_fork+0x35/0x40
>
> [  464.333577] Allocated by task 1110:
> [  464.334381]  save_stack+0x1b/0x80
> [  464.335123]  __kasan_kmalloc.constprop.0+0xc2/0xd0
> [  464.335848]  cifs_smb3_do_mount+0xd4/0xb00
> [  464.336619]  legacy_get_tree+0x6b/0xa0
> [  464.337235]  vfs_get_tree+0x41/0x110
> [  464.337975]  fc_mount+0xa/0x40
> [  464.338557]  vfs_kern_mount.part.0+0x6c/0x80
> [  464.339227]  cifs_dfs_d_automount+0x336/0xd29
> [  464.339846]  follow_managed+0x1b1/0x450
> [  464.340449]  lookup_fast+0x231/0x4a0
> [  464.341039]  path_openat+0x240/0x1fd0
> [  464.341634]  do_filp_open+0x126/0x1c0
> [  464.342277]  do_sys_open+0x1eb/0x2c0
> [  464.342957]  do_syscall_64+0x5e/0x190
> [  464.343555]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> [  464.344772] Freed by task 0:
> [  464.345347]  save_stack+0x1b/0x80
> [  464.345966]  __kasan_slab_free+0x12c/0x170
> [  464.346576]  kfree+0xa6/0x270
> [  464.347211]  rcu_core+0x39c/0xc80
> [  464.347800]  __do_softirq+0x10d/0x3da
>
> [  464.348919] The buggy address belongs to the object at
> ffff888155e58000
>                 which belongs to the cache kmalloc-256 of size 256
> [  464.350222] The buggy address is located 208 bytes inside of
>                 256-byte region [ffff888155e58000, ffff888155e58100)
> [  464.351575] The buggy address belongs to the page:
> [  464.352333] page:ffffea0005579600 refcount:1 mapcount:0
> mapping:ffff88815a803400 index:0x0 compound_mapcount: 0
> [  464.353583] flags: 0x200000000010200(slab|head)
> [  464.354209] raw: 0200000000010200 ffffea0005576200 0000000400000004
> ffff88815a803400
> [  464.355353] raw: 0000000000000000 0000000080100010 00000001ffffffff
> 0000000000000000
> [  464.356458] page dumped because: kasan: bad access detected
>
> [  464.367005] Memory state around the buggy address:
> [  464.367787]  ffff888155e57f80: fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc fc
> [  464.368877]  ffff888155e58000: fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb fb
> [  464.369967] >ffff888155e58080: fb fb fb fb fb fb fb fb fb fb fb fb
> fb fb fb fb
> [  464.371111]                                                  ^
> [  464.371775]  ffff888155e58100: fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc fc
> [  464.372893]  ffff888155e58180: fc fc fc fc fc fc fc fc fc fc fc fc
> fc fc fc fc
> [  464.373983] ==================================================================
>
> Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
> ---
>  fs/cifs/connect.c | 46 +++++++++++++++++++++++++++++++++++-----------
>  1 file changed, 35 insertions(+), 11 deletions(-)
>
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index fce71a6cc3f4..668d477cc9c7 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -391,7 +391,7 @@ static inline int reconn_set_ipaddr(struct TCP_Server_Info *server)
>  #ifdef CONFIG_CIFS_DFS_UPCALL
>  struct super_cb_data {
>         struct TCP_Server_Info *server;
> -       struct cifs_sb_info *cifs_sb;
> +       struct super_block *sb;
>  };
>
>  /* These functions must be called with server->srv_mutex held */
> @@ -402,25 +402,39 @@ static void super_cb(struct super_block *sb, void *arg)
>         struct cifs_sb_info *cifs_sb;
>         struct cifs_tcon *tcon;
>
> -       if (d->cifs_sb)
> +       if (d->sb)
>                 return;
>
>         cifs_sb = CIFS_SB(sb);
>         tcon = cifs_sb_master_tcon(cifs_sb);
>         if (tcon->ses->server == d->server)
> -               d->cifs_sb = cifs_sb;
> +               d->sb = sb;
>  }
>
> -static inline struct cifs_sb_info *
> -find_super_by_tcp(struct TCP_Server_Info *server)
> +static struct super_block *get_tcp_super(struct TCP_Server_Info *server)
>  {
>         struct super_cb_data d = {
>                 .server = server,
> -               .cifs_sb = NULL,
> +               .sb = NULL,
>         };
>
>         iterate_supers_type(&cifs_fs_type, super_cb, &d);
> -       return d.cifs_sb ? d.cifs_sb : ERR_PTR(-ENOENT);
> +
> +       if (unlikely(!d.sb))
> +               return ERR_PTR(-ENOENT);
> +       /*
> +        * Grab an active reference in order to prevent automounts (DFS links)
> +        * of expiring and then freeing up our cifs superblock pointer while
> +        * we're doing failover.
> +        */
> +       cifs_sb_active(d.sb);
> +       return d.sb;
> +}
> +
> +static inline void put_tcp_super(struct super_block *sb)
> +{
> +       if (!IS_ERR_OR_NULL(sb))
> +               cifs_sb_deactive(sb);
>  }
>
>  static void reconn_inval_dfs_target(struct TCP_Server_Info *server,
> @@ -484,6 +498,7 @@ cifs_reconnect(struct TCP_Server_Info *server)
>         struct mid_q_entry *mid_entry;
>         struct list_head retry_list;
>  #ifdef CONFIG_CIFS_DFS_UPCALL
> +       struct super_block *sb = NULL;
>         struct cifs_sb_info *cifs_sb = NULL;
>         struct dfs_cache_tgt_list tgt_list = {0};
>         struct dfs_cache_tgt_iterator *tgt_it = NULL;
> @@ -493,13 +508,15 @@ cifs_reconnect(struct TCP_Server_Info *server)
>         server->nr_targets = 1;
>  #ifdef CONFIG_CIFS_DFS_UPCALL
>         spin_unlock(&GlobalMid_Lock);
> -       cifs_sb = find_super_by_tcp(server);
> -       if (IS_ERR(cifs_sb)) {
> -               rc = PTR_ERR(cifs_sb);
> +       sb = get_tcp_super(server);
> +       if (IS_ERR(sb)) {
> +               rc = PTR_ERR(sb);
>                 cifs_dbg(FYI, "%s: will not do DFS failover: rc = %d\n",
>                          __func__, rc);
> -               cifs_sb = NULL;
> +               sb = NULL;
>         } else {
> +               cifs_sb = CIFS_SB(sb);
> +
>                 rc = reconn_setup_dfs_targets(cifs_sb, &tgt_list, &tgt_it);
>                 if (rc && (rc != -EOPNOTSUPP)) {
>                         cifs_server_dbg(VFS, "%s: no target servers for DFS failover\n",
> @@ -516,6 +533,10 @@ cifs_reconnect(struct TCP_Server_Info *server)
>                 /* the demux thread will exit normally
>                 next time through the loop */
>                 spin_unlock(&GlobalMid_Lock);
> +#ifdef CONFIG_CIFS_DFS_UPCALL
> +               dfs_cache_free_tgts(&tgt_list);
> +               put_tcp_super(sb);
> +#endif
>                 return rc;
>         } else
>                 server->tcpStatus = CifsNeedReconnect;
> @@ -642,7 +663,10 @@ cifs_reconnect(struct TCP_Server_Info *server)
>                                  __func__, rc);
>                 }
>                 dfs_cache_free_tgts(&tgt_list);
> +
>         }
> +
> +       put_tcp_super(sb);
>  #endif
>         if (server->tcpStatus == CifsNeedNegotiate)
>                 mod_delayed_work(cifsiod_wq, &server->echo, 0);
> --
> 2.24.0
>


-- 
Thanks,

Steve
