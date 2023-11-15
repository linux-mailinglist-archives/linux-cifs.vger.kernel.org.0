Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BFEF67DC4BF
	for <lists+linux-cifs@lfdr.de>; Tue, 31 Oct 2023 04:09:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbjJaDJb (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 30 Oct 2023 23:09:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230409AbjJaDJa (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 30 Oct 2023 23:09:30 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52393C5
        for <linux-cifs@vger.kernel.org>; Mon, 30 Oct 2023 20:09:27 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-507a62d4788so7905778e87.0
        for <linux-cifs@vger.kernel.org>; Mon, 30 Oct 2023 20:09:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1698721765; x=1699326565; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Dp89Mf2Z7ioNSsRL6We7b1JmShYaNpD1HE9D48OMeV8=;
        b=ez8bpwUbI335gnP4djOed4JE4LAPT2kxy6o3tCmBmezA9tt0sDdZbp8xt9us6Wl7ft
         vb54vO29RAUwTxIFSTYeb+s3ROZSbOrX4xkIpKA8JYDw8la771Gj+NAh7IDK+ebO5EdQ
         DvBegOK6ueiawTJ27gCZUpkWD7d3ijoDQX5l5vyqUvDJAtnJ7whLQXdY1CF7CJdngGCf
         x23617cVMZvbBTQPJgworEux6fRuRLwxwgIzchv/rG2BWWZb/8sbWkOEHP6EQgCAH3/U
         O9WuL5dHlJ0+S7bYthbc8r7vLM2DZaNHvjIeO8WVYLySWgQwK+7YnVSNftzLp73mXg+E
         cXpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1698721765; x=1699326565;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Dp89Mf2Z7ioNSsRL6We7b1JmShYaNpD1HE9D48OMeV8=;
        b=VEJsY/HxvOsby7R1E2qqnQqOzFKDYRW0Ri2T5qLTmzzOslgcbyYOyR4QI5lTdHYVzl
         T9qDzxHaj9tndxeSsxwG74Xdp2MVuK8OxeY9QeoXnZ3rYapxv8mKeUnJsSwlb1sI7Vaq
         /E0WER59wzkVQtyaxxMegifC8mUD9jmxWqpMH+3ECqzlLKT61U3zhQ/EljE2RpNAbkhj
         7uwaQ64WF/1+kHcOsNtTI7s64HYH/yFpio26BzPQe13CUF5C72glnMsaxUA67FVxnFdZ
         Z/1Ot/ZWsMIVjh8Kvnv/zlPHYFunrclVEuIDJAZbg9U3Nyr47oK4anvoD7X1gnTXOuSS
         qXZw==
X-Gm-Message-State: AOJu0Yx7wCwWpK9TptZvAf7LlVo8gsNFEmwQk/4tSeKV1p/YsSvl9zi5
        Yv2mSlM6wm69/X1vEWZIMOuRIQ89GN3aEXsyewgAS12TSz8=
X-Google-Smtp-Source: AGHT+IFzZuPcXh4AAZi03PS4kPR0GabUibXoRZHixd3tG39YTi1S3yeE9HrJX7GxTZVEw6uuBFeC8/3o6Hq079DWFM0=
X-Received: by 2002:a05:6512:3d94:b0:507:9701:26ff with SMTP id
 k20-20020a0565123d9400b00507970126ffmr10652647lfv.31.1698721764977; Mon, 30
 Oct 2023 20:09:24 -0700 (PDT)
MIME-Version: 1.0
References: <20231030201956.2660-1-pc@manguebit.com> <20231030201956.2660-4-pc@manguebit.com>
In-Reply-To: <20231030201956.2660-4-pc@manguebit.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 30 Oct 2023 22:09:13 -0500
Message-ID: <CAH2r5mssykiPGpzUS33=roxwYOa4pwsrFZ7eYia7A-NygV-iWA@mail.gmail.com>
Subject: Re: [PATCH 4/4] smb: client: fix use-after-free in smb2_query_info_compound()
To:     Paulo Alcantara <pc@manguebit.com>
Cc:     linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

added Cc: stable and tentatively merged this to for-next

On Mon, Oct 30, 2023 at 3:20=E2=80=AFPM Paulo Alcantara <pc@manguebit.com> =
wrote:
>
> The following UAF was triggered when running fstests generic/072 with
> KASAN enabled against Windows Server 2022 and mount options
> 'multichannel,max_channels=3D2,vers=3D3.1.1,mfsymlinks,noperm'
>
>   BUG: KASAN: slab-use-after-free in smb2_query_info_compound+0x423/0x6d0=
 [cifs]
>   Read of size 8 at addr ffff888014941048 by task xfs_io/27534
>
>   CPU: 0 PID: 27534 Comm: xfs_io Not tainted 6.6.0-rc7 #1
>   Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
>   rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
>   Call Trace:
>    dump_stack_lvl+0x4a/0x80
>    print_report+0xcf/0x650
>    ? srso_alias_return_thunk+0x5/0x7f
>    ? srso_alias_return_thunk+0x5/0x7f
>    ? __phys_addr+0x46/0x90
>    kasan_report+0xda/0x110
>    ? smb2_query_info_compound+0x423/0x6d0 [cifs]
>    ? smb2_query_info_compound+0x423/0x6d0 [cifs]
>    smb2_query_info_compound+0x423/0x6d0 [cifs]
>    ? __pfx_smb2_query_info_compound+0x10/0x10 [cifs]
>    ? srso_alias_return_thunk+0x5/0x7f
>    ? __stack_depot_save+0x39/0x480
>    ? kasan_save_stack+0x33/0x60
>    ? kasan_set_track+0x25/0x30
>    ? ____kasan_slab_free+0x126/0x170
>    smb2_queryfs+0xc2/0x2c0 [cifs]
>    ? __pfx_smb2_queryfs+0x10/0x10 [cifs]
>    ? __pfx___lock_acquire+0x10/0x10
>    smb311_queryfs+0x210/0x220 [cifs]
>    ? __pfx_smb311_queryfs+0x10/0x10 [cifs]
>    ? srso_alias_return_thunk+0x5/0x7f
>    ? __lock_acquire+0x480/0x26c0
>    ? lock_release+0x1ed/0x640
>    ? srso_alias_return_thunk+0x5/0x7f
>    ? do_raw_spin_unlock+0x9b/0x100
>    cifs_statfs+0x18c/0x4b0 [cifs]
>    statfs_by_dentry+0x9b/0xf0
>    fd_statfs+0x4e/0xb0
>    __do_sys_fstatfs+0x7f/0xe0
>    ? __pfx___do_sys_fstatfs+0x10/0x10
>    ? srso_alias_return_thunk+0x5/0x7f
>    ? lockdep_hardirqs_on_prepare+0x136/0x200
>    ? srso_alias_return_thunk+0x5/0x7f
>    do_syscall_64+0x3f/0x90
>    entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>
>   Allocated by task 27534:
>    kasan_save_stack+0x33/0x60
>    kasan_set_track+0x25/0x30
>    __kasan_kmalloc+0x8f/0xa0
>    open_cached_dir+0x71b/0x1240 [cifs]
>    smb2_query_info_compound+0x5c3/0x6d0 [cifs]
>    smb2_queryfs+0xc2/0x2c0 [cifs]
>    smb311_queryfs+0x210/0x220 [cifs]
>    cifs_statfs+0x18c/0x4b0 [cifs]
>    statfs_by_dentry+0x9b/0xf0
>    fd_statfs+0x4e/0xb0
>    __do_sys_fstatfs+0x7f/0xe0
>    do_syscall_64+0x3f/0x90
>    entry_SYSCALL_64_after_hwframe+0x6e/0xd8
>
>   Freed by task 27534:
>    kasan_save_stack+0x33/0x60
>    kasan_set_track+0x25/0x30
>    kasan_save_free_info+0x2b/0x50
>    ____kasan_slab_free+0x126/0x170
>    slab_free_freelist_hook+0xd0/0x1e0
>    __kmem_cache_free+0x9d/0x1b0
>    open_cached_dir+0xff5/0x1240 [cifs]
>    smb2_query_info_compound+0x5c3/0x6d0 [cifs]
>    smb2_queryfs+0xc2/0x2c0 [cifs]
>
> This is a race between open_cached_dir() and cached_dir_lease_break()
> where the cache entry for the open directory handle receives a lease
> break while creating it.  And before returning from open_cached_dir(),
> we put the last reference of the new @cfid because of
> !@cfid->has_lease.
>
> Besides the UAF, while running xfstests a lot of missed lease breaks
> have been noticed in tests that run several concurrent statfs(2) calls
> on those cached fids
>
>   CIFS: VFS: \\w22-root1.gandalf.test No task to wake, unknown frame...
>   CIFS: VFS: \\w22-root1.gandalf.test Cmd: 18 Err: 0x0 Flags: 0x1...
>   CIFS: VFS: \\w22-root1.gandalf.test smb buf 00000000715bfe83 len 108
>   CIFS: VFS: Dump pending requests:
>   CIFS: VFS: \\w22-root1.gandalf.test No task to wake, unknown frame...
>   CIFS: VFS: \\w22-root1.gandalf.test Cmd: 18 Err: 0x0 Flags: 0x1...
>   CIFS: VFS: \\w22-root1.gandalf.test smb buf 000000005aa7316e len 108
>   ...
>
> To fix both, in open_cached_dir() ensure that @cfid->has_lease is set
> right before sending out compounded request so that any potential
> lease break will be get processed by demultiplex thread while we're
> still caching @cfid.  And, if open failed for some reason, re-check
> @cfid->has_lease to decide whether or not put lease reference.
>
> Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
> ---
>  fs/smb/client/cached_dir.c | 84 ++++++++++++++++++++++----------------
>  1 file changed, 49 insertions(+), 35 deletions(-)
>
> diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
> index fe1bf5b6e0cb..59f6b8e32cc9 100644
> --- a/fs/smb/client/cached_dir.c
> +++ b/fs/smb/client/cached_dir.c
> @@ -32,7 +32,7 @@ static struct cached_fid *find_or_create_cached_dir(str=
uct cached_fids *cfids,
>                          * fully cached or it may be in the process of
>                          * being deleted due to a lease break.
>                          */
> -                       if (!cfid->has_lease) {
> +                       if (!cfid->time || !cfid->has_lease) {
>                                 spin_unlock(&cfids->cfid_list_lock);
>                                 return NULL;
>                         }
> @@ -193,10 +193,20 @@ int open_cached_dir(unsigned int xid, struct cifs_t=
con *tcon,
>         npath =3D path_no_prefix(cifs_sb, path);
>         if (IS_ERR(npath)) {
>                 rc =3D PTR_ERR(npath);
> -               kfree(utf16_path);
> -               return rc;
> +               goto out;
>         }
>
> +       if (!npath[0]) {
> +               dentry =3D dget(cifs_sb->root);
> +       } else {
> +               dentry =3D path_to_dentry(cifs_sb, npath);
> +               if (IS_ERR(dentry)) {
> +                       rc =3D -ENOENT;
> +                       goto out;
> +               }
> +       }
> +       cfid->dentry =3D dentry;
> +
>         /*
>          * We do not hold the lock for the open because in case
>          * SMB2_open needs to reconnect.
> @@ -249,6 +259,15 @@ int open_cached_dir(unsigned int xid, struct cifs_tc=
on *tcon,
>
>         smb2_set_related(&rqst[1]);
>
> +       /*
> +        * Set @cfid->has_lease to true before sending out compounded req=
uest so
> +        * its lease reference can be put in cached_dir_lease_break() due=
 to a
> +        * potential lease break right after the request is sent or while=
 @cfid
> +        * is still being cached.  Concurrent processes won't be to use i=
t yet
> +        * due to @cfid->time being zero.
> +        */
> +       cfid->has_lease =3D true;
> +
>         rc =3D compound_send_recv(xid, ses, server,
>                                 flags, 2, rqst,
>                                 resp_buftype, rsp_iov);
> @@ -263,6 +282,8 @@ int open_cached_dir(unsigned int xid, struct cifs_tco=
n *tcon,
>         cfid->tcon =3D tcon;
>         cfid->is_open =3D true;
>
> +       spin_lock(&cfids->cfid_list_lock);
> +
>         o_rsp =3D (struct smb2_create_rsp *)rsp_iov[0].iov_base;
>         oparms.fid->persistent_fid =3D o_rsp->PersistentFileId;
>         oparms.fid->volatile_fid =3D o_rsp->VolatileFileId;
> @@ -270,18 +291,25 @@ int open_cached_dir(unsigned int xid, struct cifs_t=
con *tcon,
>         oparms.fid->mid =3D le64_to_cpu(o_rsp->hdr.MessageId);
>  #endif /* CIFS_DEBUG2 */
>
> -       if (o_rsp->OplockLevel !=3D SMB2_OPLOCK_LEVEL_LEASE)
> +       rc =3D -EINVAL;
> +       if (o_rsp->OplockLevel !=3D SMB2_OPLOCK_LEVEL_LEASE) {
> +               spin_unlock(&cfids->cfid_list_lock);
>                 goto oshr_free;
> +       }
>
>         smb2_parse_contexts(server, o_rsp,
>                             &oparms.fid->epoch,
>                             oparms.fid->lease_key, &oplock,
>                             NULL, NULL);
> -       if (!(oplock & SMB2_LEASE_READ_CACHING_HE))
> +       if (!(oplock & SMB2_LEASE_READ_CACHING_HE)) {
> +               spin_unlock(&cfids->cfid_list_lock);
>                 goto oshr_free;
> +       }
>         qi_rsp =3D (struct smb2_query_info_rsp *)rsp_iov[1].iov_base;
> -       if (le32_to_cpu(qi_rsp->OutputBufferLength) < sizeof(struct smb2_=
file_all_info))
> +       if (le32_to_cpu(qi_rsp->OutputBufferLength) < sizeof(struct smb2_=
file_all_info)) {
> +               spin_unlock(&cfids->cfid_list_lock);
>                 goto oshr_free;
> +       }
>         if (!smb2_validate_and_copy_iov(
>                                 le16_to_cpu(qi_rsp->OutputBufferOffset),
>                                 sizeof(struct smb2_file_all_info),
> @@ -289,37 +317,24 @@ int open_cached_dir(unsigned int xid, struct cifs_t=
con *tcon,
>                                 (char *)&cfid->file_all_info))
>                 cfid->file_all_info_is_valid =3D true;
>
> -       if (!npath[0])
> -               dentry =3D dget(cifs_sb->root);
> -       else {
> -               dentry =3D path_to_dentry(cifs_sb, npath);
> -               if (IS_ERR(dentry)) {
> -                       rc =3D -ENOENT;
> -                       goto oshr_free;
> -               }
> -       }
> -       spin_lock(&cfids->cfid_list_lock);
> -       cfid->dentry =3D dentry;
>         cfid->time =3D jiffies;
> -       cfid->has_lease =3D true;
>         spin_unlock(&cfids->cfid_list_lock);
> +       /* At this point the directory handle is fully cached */
> +       rc =3D 0;
>
>  oshr_free:
> -       kfree(utf16_path);
>         SMB2_open_free(&rqst[0]);
>         SMB2_query_info_free(&rqst[1]);
>         free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
>         free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
> -       spin_lock(&cfids->cfid_list_lock);
> -       if (!cfid->has_lease) {
> -               if (rc) {
> -                       if (cfid->on_list) {
> -                               list_del(&cfid->entry);
> -                               cfid->on_list =3D false;
> -                               cfids->num_entries--;
> -                       }
> -                       rc =3D -ENOENT;
> -               } else {
> +       if (rc) {
> +               spin_lock(&cfids->cfid_list_lock);
> +               if (cfid->on_list) {
> +                       list_del(&cfid->entry);
> +                       cfid->on_list =3D false;
> +                       cfids->num_entries--;
> +               }
> +               if (cfid->has_lease) {
>                         /*
>                          * We are guaranteed to have two references at th=
is
>                          * point. One for the caller and one for a potent=
ial
> @@ -327,25 +342,24 @@ int open_cached_dir(unsigned int xid, struct cifs_t=
con *tcon,
>                          * will be closed when the caller closes the cach=
ed
>                          * handle.
>                          */
> +                       cfid->has_lease =3D false;
>                         spin_unlock(&cfids->cfid_list_lock);
>                         kref_put(&cfid->refcount, smb2_close_cached_fid);
>                         goto out;
>                 }
> +               spin_unlock(&cfids->cfid_list_lock);
>         }
> -       spin_unlock(&cfids->cfid_list_lock);
> +out:
>         if (rc) {
>                 if (cfid->is_open)
>                         SMB2_close(0, cfid->tcon, cfid->fid.persistent_fi=
d,
>                                    cfid->fid.volatile_fid);
>                 free_cached_dir(cfid);
> -               cfid =3D NULL;
> -       }
> -out:
> -       if (rc =3D=3D 0) {
> +       } else {
>                 *ret_cfid =3D cfid;
>                 atomic_inc(&tcon->num_remote_opens);
>         }
> -
> +       kfree(utf16_path);
>         return rc;
>  }
>
> --
> 2.42.0
>


--=20
Thanks,

Steve
