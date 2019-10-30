Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A7BFE9F73
	for <lists+linux-cifs@lfdr.de>; Wed, 30 Oct 2019 16:47:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbfJ3PrB (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 30 Oct 2019 11:47:01 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:46854 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726175AbfJ3PrB (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 30 Oct 2019 11:47:01 -0400
Received: by mail-lf1-f67.google.com with SMTP id t8so1921609lfc.13
        for <linux-cifs@vger.kernel.org>; Wed, 30 Oct 2019 08:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=9yqm3LFJdptZluJ4Xg7XM5zxtyK6GhMMt4YJmrD1kNo=;
        b=I+crBLrocZV/bxir2gX07z/L9IgNnWeG09KiRbeN57q598kOHWYI8yWNWP64vvaPsf
         vaN130kmecA3CU4fM9lyO6EKBxpDQmCmUeDM7mPhTjJEsTP+AjfDo2eD3AdMhw6xw8Us
         cAJm5PS4oqjkLZae3B/xa05LvC0VpsxcSFIWEs8qEC9UG7dFexKMLxweYq7/YGUV2NWr
         bbFy8gBwtsCXqk8lynRhTBYzUWZ4AZ2ykvGa8mUoOGZhlGR3fOQqwigOi+2uPud312ow
         +TcILqVHDf7SkZnBc4wnjNxGxiruJxo4Yk+yzenk0/Z9oJKSNf2TS8y4m8GW6265dGrp
         glnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=9yqm3LFJdptZluJ4Xg7XM5zxtyK6GhMMt4YJmrD1kNo=;
        b=gn9cV8nNVyiszBtDkAXYOzcG60aapB1conhTQAb72Tr0rUIyphe/ZXm8omSTdGQFQ1
         kSsQcr3RFMOLb1cYa1g6/8mCappUxm55mOi3kT0LnHHiQtnVSIuGMCkGo+M+ighfAsva
         mXRjFJYkQgg84ibjBYeX+5kfKK+1ahsxCL5K0e0LOUGD9PnJx7RbejZMR5vpbqR3cTJZ
         JD4Oq5eL6nFJ+qmaCP4A/XJwrEgoz1mtawx1MiH4oxHByWvrrVur5+K/zyONtgSvT+pM
         b7lFEiSryg8XnkbMimj66gQgaCvZ8GUdVKm++oa9IBJTyh20XuEAkEhYC9raXAciyGMS
         vvNA==
X-Gm-Message-State: APjAAAVlgKNtcnYZQhoVVkHGjTCRR3I6aYYl147XFTBI6H+6QxgA7edE
        SnGZpY4thavdvHL4ifWGuB6uenQnyuFbXztwFQ==
X-Google-Smtp-Source: APXvYqyLizmGhPikRZK8DKur5qmNxrGJT/yU9KIK5sWYZTI0QoRFM4Gk99+VhzSiD6vM0uLE5NEE9I8CDTYeiJPGsHM=
X-Received: by 2002:ac2:5144:: with SMTP id q4mr6863509lfd.36.1572450418126;
 Wed, 30 Oct 2019 08:46:58 -0700 (PDT)
MIME-Version: 1.0
References: <20191030025906.14395-1-lsahlber@redhat.com> <20191030025906.14395-2-lsahlber@redhat.com>
In-Reply-To: <20191030025906.14395-2-lsahlber@redhat.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Wed, 30 Oct 2019 08:46:46 -0700
Message-ID: <CAKywueT11XLviGCiVp8g9YnUcWonuxWpY4nCGN2KSpTh6aXGPQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: move cifsFileInfo_put logic into a work-queue
To:     Ronnie Sahlberg <lsahlber@redhat.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

=D0=B2=D1=82, 29 =D0=BE=D0=BA=D1=82. 2019 =D0=B3. =D0=B2 19:59, Ronnie Sahl=
berg <lsahlber@redhat.com>:
>
> This patch moves the final part of the cifsFileInfo_put() logic where we
> need a write lock on lock_sem to be processed in a separate thread that
> holds no other locks.
> This is to prevent deadlocks like the one below:
>
> > there are 6 processes looping to while trying to down_write
> > cinode->lock_sem, 5 of them from _cifsFileInfo_put, and one from
> > cifs_new_fileinfo
> >
> > and there are 5 other processes which are blocked, several of them
> > waiting on either PG_writeback or PG_locked (which are both set), all
> > for the same page of the file
> >
> > 2 inode_lock() (inode->i_rwsem) for the file
> > 1 wait_on_page_writeback() for the page
> > 1 down_read(inode->i_rwsem) for the inode of the directory
> > 1 inode_lock()(inode->i_rwsem) for the inode of the directory
> > 1 __lock_page
> >
> >
> > so processes are blocked waiting on:
> >   page flags PG_locked and PG_writeback for one specific page
> >   inode->i_rwsem for the directory
> >   inode->i_rwsem for the file
> >   cifsInodeInflock_sem
> >
> >
> >
> > here are the more gory details (let me know if I need to provide
> > anything more/better):
> >
> > [0 00:48:22.765] [UN]  PID: 8863   TASK: ffff8c691547c5c0  CPU: 3
> > COMMAND: "reopen_file"
> >  #0 [ffff9965007e3ba8] __schedule at ffffffff9b6e6095
> >  #1 [ffff9965007e3c38] schedule at ffffffff9b6e64df
> >  #2 [ffff9965007e3c48] rwsem_down_write_slowpath at ffffffff9af283d7
> >  #3 [ffff9965007e3cb8] legitimize_path at ffffffff9b0f975d
> >  #4 [ffff9965007e3d08] path_openat at ffffffff9b0fe55d
> >  #5 [ffff9965007e3dd8] do_filp_open at ffffffff9b100a33
> >  #6 [ffff9965007e3ee0] do_sys_open at ffffffff9b0eb2d6
> >  #7 [ffff9965007e3f38] do_syscall_64 at ffffffff9ae04315
> > * (I think legitimize_path is bogus)
> >
> > in path_openat
> >         } else {
> >                 const char *s =3D path_init(nd, flags);
> >                 while (!(error =3D link_path_walk(s, nd)) &&
> >                         (error =3D do_last(nd, file, op)) > 0) {  <<<<
> >
> > do_last:
> >         if (open_flag & O_CREAT)
> >                 inode_lock(dir->d_inode);  <<<<
> >         else
> > so it's trying to take inode->i_rwsem for the directory
> >
> >      DENTRY           INODE           SUPERBLK     TYPE PATH
> > ffff8c68bb8e79c0 ffff8c691158ef20 ffff8c6915bf9000 DIR  /mnt/vm1_smb/
> > inode.i_rwsem is ffff8c691158efc0
> >
> > <struct rw_semaphore 0xffff8c691158efc0>:
> >         owner: <struct task_struct 0xffff8c6914275d00> (UN -   8856 -
> > reopen_file), counter: 0x0000000000000003
> >         waitlist: 2
> >         0xffff9965007e3c90     8863   reopen_file      UN 0  1:29:22.92=
6
> >   RWSEM_WAITING_FOR_WRITE
> >         0xffff996500393e00     9802   ls               UN 0  1:17:26.70=
0
> >   RWSEM_WAITING_FOR_READ
> >
> >
> > the owner of the inode.i_rwsem of the directory is:
> >
> > [0 00:00:00.109] [UN]  PID: 8856   TASK: ffff8c6914275d00  CPU: 3
> > COMMAND: "reopen_file"
> >  #0 [ffff99650065b828] __schedule at ffffffff9b6e6095
> >  #1 [ffff99650065b8b8] schedule at ffffffff9b6e64df
> >  #2 [ffff99650065b8c8] schedule_timeout at ffffffff9b6e9f89
> >  #3 [ffff99650065b940] msleep at ffffffff9af573a9
> >  #4 [ffff99650065b948] _cifsFileInfo_put.cold.63 at ffffffffc0a42dd6 [c=
ifs]
> >  #5 [ffff99650065ba38] cifs_writepage_locked at ffffffffc0a0b8f3 [cifs]
> >  #6 [ffff99650065bab0] cifs_launder_page at ffffffffc0a0bb72 [cifs]
> >  #7 [ffff99650065bb30] invalidate_inode_pages2_range at ffffffff9b04d4b=
d
> >  #8 [ffff99650065bcb8] cifs_invalidate_mapping at ffffffffc0a11339 [cif=
s]
> >  #9 [ffff99650065bcd0] cifs_revalidate_mapping at ffffffffc0a1139a [cif=
s]
> > #10 [ffff99650065bcf0] cifs_d_revalidate at ffffffffc0a014f6 [cifs]
> > #11 [ffff99650065bd08] path_openat at ffffffff9b0fe7f7
> > #12 [ffff99650065bdd8] do_filp_open at ffffffff9b100a33
> > #13 [ffff99650065bee0] do_sys_open at ffffffff9b0eb2d6
> > #14 [ffff99650065bf38] do_syscall_64 at ffffffff9ae04315
> >
> > cifs_launder_page is for page 0xffffd1e2c07d2480
> >
> > crash> page.index,mapping,flags 0xffffd1e2c07d2480
> >       index =3D 0x8
> >       mapping =3D 0xffff8c68f3cd0db0
> >   flags =3D 0xfffffc0008095
> >
> >   PAGE-FLAG       BIT  VALUE
> >   PG_locked         0  0000001
> >   PG_uptodate       2  0000004
> >   PG_lru            4  0000010
> >   PG_waiters        7  0000080
> >   PG_writeback     15  0008000
> >
> >
> > inode is ffff8c68f3cd0c40
> > inode.i_rwsem is ffff8c68f3cd0ce0
> >      DENTRY           INODE           SUPERBLK     TYPE PATH
> > ffff8c68a1f1b480 ffff8c68f3cd0c40 ffff8c6915bf9000 REG
> > /mnt/vm1_smb/testfile.8853
> >
> >
> > this process holds the inode->i_rwsem for the parent directory, is
> > laundering a page attached to the inode of the file it's opening, and i=
n
> > _cifsFileInfo_put is trying to down_write the cifsInodeInflock_sem
> > for the file itself.
> >
> >
> > <struct rw_semaphore 0xffff8c68f3cd0ce0>:
> >         owner: <struct task_struct 0xffff8c6914272e80> (UN -   8854 -
> > reopen_file), counter: 0x0000000000000003
> >         waitlist: 1
> >         0xffff9965005dfd80     8855   reopen_file      UN 0  1:29:22.91=
2
> >   RWSEM_WAITING_FOR_WRITE
> >
> > this is the inode.i_rwsem for the file
> >
> > the owner:
> >
> > [0 00:48:22.739] [UN]  PID: 8854   TASK: ffff8c6914272e80  CPU: 2
> > COMMAND: "reopen_file"
> >  #0 [ffff99650054fb38] __schedule at ffffffff9b6e6095
> >  #1 [ffff99650054fbc8] schedule at ffffffff9b6e64df
> >  #2 [ffff99650054fbd8] io_schedule at ffffffff9b6e68e2
> >  #3 [ffff99650054fbe8] __lock_page at ffffffff9b03c56f
> >  #4 [ffff99650054fc80] pagecache_get_page at ffffffff9b03dcdf
> >  #5 [ffff99650054fcc0] grab_cache_page_write_begin at ffffffff9b03ef4c
> >  #6 [ffff99650054fcd0] cifs_write_begin at ffffffffc0a064ec [cifs]
> >  #7 [ffff99650054fd30] generic_perform_write at ffffffff9b03bba4
> >  #8 [ffff99650054fda8] __generic_file_write_iter at ffffffff9b04060a
> >  #9 [ffff99650054fdf0] cifs_strict_writev.cold.70 at ffffffffc0a4469b [=
cifs]
> > #10 [ffff99650054fe48] new_sync_write at ffffffff9b0ec1dd
> > #11 [ffff99650054fed0] vfs_write at ffffffff9b0eed35
> > #12 [ffff99650054ff00] ksys_write at ffffffff9b0eefd9
> > #13 [ffff99650054ff38] do_syscall_64 at ffffffff9ae04315
> >
> > the process holds the inode->i_rwsem for the file to which it's writing=
,
> > and is trying to __lock_page for the same page as in the other processe=
s
> >
> >
> > the other tasks:
> > [0 00:00:00.028] [UN]  PID: 8859   TASK: ffff8c6915479740  CPU: 2
> > COMMAND: "reopen_file"
> >  #0 [ffff9965007b39d8] __schedule at ffffffff9b6e6095
> >  #1 [ffff9965007b3a68] schedule at ffffffff9b6e64df
> >  #2 [ffff9965007b3a78] schedule_timeout at ffffffff9b6e9f89
> >  #3 [ffff9965007b3af0] msleep at ffffffff9af573a9
> >  #4 [ffff9965007b3af8] cifs_new_fileinfo.cold.61 at ffffffffc0a42a07 [c=
ifs]
> >  #5 [ffff9965007b3b78] cifs_open at ffffffffc0a0709d [cifs]
> >  #6 [ffff9965007b3cd8] do_dentry_open at ffffffff9b0e9b7a
> >  #7 [ffff9965007b3d08] path_openat at ffffffff9b0fe34f
> >  #8 [ffff9965007b3dd8] do_filp_open at ffffffff9b100a33
> >  #9 [ffff9965007b3ee0] do_sys_open at ffffffff9b0eb2d6
> > #10 [ffff9965007b3f38] do_syscall_64 at ffffffff9ae04315
> >
> > this is opening the file, and is trying to down_write cinode->lock_sem
> >
> >
> > [0 00:00:00.041] [UN]  PID: 8860   TASK: ffff8c691547ae80  CPU: 2
> > COMMAND: "reopen_file"
> > [0 00:00:00.057] [UN]  PID: 8861   TASK: ffff8c6915478000  CPU: 3
> > COMMAND: "reopen_file"
> > [0 00:00:00.059] [UN]  PID: 8858   TASK: ffff8c6914271740  CPU: 2
> > COMMAND: "reopen_file"
> > [0 00:00:00.109] [UN]  PID: 8862   TASK: ffff8c691547dd00  CPU: 6
> > COMMAND: "reopen_file"
> >  #0 [ffff9965007c3c78] __schedule at ffffffff9b6e6095
> >  #1 [ffff9965007c3d08] schedule at ffffffff9b6e64df
> >  #2 [ffff9965007c3d18] schedule_timeout at ffffffff9b6e9f89
> >  #3 [ffff9965007c3d90] msleep at ffffffff9af573a9
> >  #4 [ffff9965007c3d98] _cifsFileInfo_put.cold.63 at ffffffffc0a42dd6 [c=
ifs]
> >  #5 [ffff9965007c3e88] cifs_close at ffffffffc0a07aaf [cifs]
> >  #6 [ffff9965007c3ea0] __fput at ffffffff9b0efa6e
> >  #7 [ffff9965007c3ee8] task_work_run at ffffffff9aef1614
> >  #8 [ffff9965007c3f20] exit_to_usermode_loop at ffffffff9ae03d6f
> >  #9 [ffff9965007c3f38] do_syscall_64 at ffffffff9ae0444c
> >
> > closing the file, and trying to down_write cifsi->lock_sem
> >
> >
> > [0 00:48:22.839] [UN]  PID: 8857   TASK: ffff8c6914270000  CPU: 7
> > COMMAND: "reopen_file"
> >  #0 [ffff9965006a7cc8] __schedule at ffffffff9b6e6095
> >  #1 [ffff9965006a7d58] schedule at ffffffff9b6e64df
> >  #2 [ffff9965006a7d68] io_schedule at ffffffff9b6e68e2
> >  #3 [ffff9965006a7d78] wait_on_page_bit at ffffffff9b03cac6
> >  #4 [ffff9965006a7e10] __filemap_fdatawait_range at ffffffff9b03b028
> >  #5 [ffff9965006a7ed8] filemap_write_and_wait at ffffffff9b040165
> >  #6 [ffff9965006a7ef0] cifs_flush at ffffffffc0a0c2fa [cifs]
> >  #7 [ffff9965006a7f10] filp_close at ffffffff9b0e93f1
> >  #8 [ffff9965006a7f30] __x64_sys_close at ffffffff9b0e9a0e
> >  #9 [ffff9965006a7f38] do_syscall_64 at ffffffff9ae04315
> >
> > in __filemap_fdatawait_range
> >                         wait_on_page_writeback(page);
> > for the same page of the file
> >
> >
> >
> > [0 00:48:22.718] [UN]  PID: 8855   TASK: ffff8c69142745c0  CPU: 7
> > COMMAND: "reopen_file"
> >  #0 [ffff9965005dfc98] __schedule at ffffffff9b6e6095
> >  #1 [ffff9965005dfd28] schedule at ffffffff9b6e64df
> >  #2 [ffff9965005dfd38] rwsem_down_write_slowpath at ffffffff9af283d7
> >  #3 [ffff9965005dfdf0] cifs_strict_writev at ffffffffc0a0c40a [cifs]
> >  #4 [ffff9965005dfe48] new_sync_write at ffffffff9b0ec1dd
> >  #5 [ffff9965005dfed0] vfs_write at ffffffff9b0eed35
> >  #6 [ffff9965005dff00] ksys_write at ffffffff9b0eefd9
> >  #7 [ffff9965005dff38] do_syscall_64 at ffffffff9ae04315
> >
> >         inode_lock(inode);
> >
> >
> > and one 'ls' later on, to see whether the rest of the mount is availabl=
e
> > (the test file is in the root, so we get blocked up on the directory
> > ->i_rwsem), so the entire mount is unavailable
> >
> > [0 00:36:26.473] [UN]  PID: 9802   TASK: ffff8c691436ae80  CPU: 4
> > COMMAND: "ls"
> >  #0 [ffff996500393d28] __schedule at ffffffff9b6e6095
> >  #1 [ffff996500393db8] schedule at ffffffff9b6e64df
> >  #2 [ffff996500393dc8] rwsem_down_read_slowpath at ffffffff9b6e9421
> >  #3 [ffff996500393e78] down_read_killable at ffffffff9b6e95e2
> >  #4 [ffff996500393e88] iterate_dir at ffffffff9b103c56
> >  #5 [ffff996500393ec8] ksys_getdents64 at ffffffff9b104b0c
> >  #6 [ffff996500393f30] __x64_sys_getdents64 at ffffffff9b104bb6
> >  #7 [ffff996500393f38] do_syscall_64 at ffffffff9ae04315
> >
> > in iterate_dir:
> >         if (shared)
> >                 res =3D down_read_killable(&inode->i_rwsem);  <<<<
> >         else
> >                 res =3D down_write_killable(&inode->i_rwsem);
> >
>
> Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> ---
>  fs/cifs/cifsfs.c   | 13 +++++++-
>  fs/cifs/cifsglob.h |  3 +-
>  fs/cifs/file.c     | 91 ++++++++++++++++++++++++++++++++++--------------=
------
>  3 files changed, 72 insertions(+), 35 deletions(-)
>
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index e4e3b573d20c..f8e201c45ccb 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -119,6 +119,7 @@ extern mempool_t *cifs_mid_poolp;
>
>  struct workqueue_struct        *cifsiod_wq;
>  struct workqueue_struct        *decrypt_wq;
> +struct workqueue_struct        *fileinfo_put_wq;
>  struct workqueue_struct        *cifsoplockd_wq;
>  __u32 cifs_lock_secret;
>
> @@ -1557,11 +1558,18 @@ init_cifs(void)
>                 goto out_destroy_cifsiod_wq;
>         }
>
> +       fileinfo_put_wq =3D alloc_workqueue("cifsfileinfoput",
> +                                    WQ_UNBOUND|WQ_FREEZABLE|WQ_MEM_RECLA=
IM, 0);
> +       if (!fileinfo_put_wq) {
> +               rc =3D -ENOMEM;
> +               goto out_destroy_decrypt_wq;
> +       }
> +
>         cifsoplockd_wq =3D alloc_workqueue("cifsoplockd",
>                                          WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
>         if (!cifsoplockd_wq) {
>                 rc =3D -ENOMEM;
> -               goto out_destroy_decrypt_wq;
> +               goto out_destroy_fileinfo_put_wq;
>         }
>
>         rc =3D cifs_fscache_register();
> @@ -1627,6 +1635,8 @@ init_cifs(void)
>         cifs_fscache_unregister();
>  out_destroy_cifsoplockd_wq:
>         destroy_workqueue(cifsoplockd_wq);
> +out_destroy_fileinfo_put_wq:
> +       destroy_workqueue(fileinfo_put_wq);
>  out_destroy_decrypt_wq:
>         destroy_workqueue(decrypt_wq);
>  out_destroy_cifsiod_wq:
> @@ -1656,6 +1666,7 @@ exit_cifs(void)
>         cifs_fscache_unregister();
>         destroy_workqueue(cifsoplockd_wq);
>         destroy_workqueue(decrypt_wq);
> +       destroy_workqueue(fileinfo_put_wq);
>         destroy_workqueue(cifsiod_wq);
>         cifs_proc_clean();
>  }
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index d78bfcc19156..0819b6498a3c 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -1265,6 +1265,7 @@ struct cifsFileInfo {
>         struct mutex fh_mutex; /* prevents reopen race after dead ses*/
>         struct cifs_search_info srch_inf;
>         struct work_struct oplock_break; /* work for oplock breaks */
> +       struct work_struct put; /* work for the final part of _put */
>  };
>
>  struct cifs_io_parms {
> @@ -1370,7 +1371,6 @@ cifsFileInfo_get_locked(struct cifsFileInfo *cifs_f=
ile)
>  }
>
>  struct cifsFileInfo *cifsFileInfo_get(struct cifsFileInfo *cifs_file);
> -void _cifsFileInfo_put(struct cifsFileInfo *cifs_file, bool wait_oplock_=
hdlr);
>  void cifsFileInfo_put(struct cifsFileInfo *cifs_file);
>
>  #define CIFS_CACHE_READ_FLG    1
> @@ -1907,6 +1907,7 @@ void cifs_queue_oplock_break(struct cifsFileInfo *c=
file);
>  extern const struct slow_work_ops cifs_oplock_break_ops;
>  extern struct workqueue_struct *cifsiod_wq;
>  extern struct workqueue_struct *decrypt_wq;
> +extern struct workqueue_struct *fileinfo_put_wq;
>  extern struct workqueue_struct *cifsoplockd_wq;
>  extern __u32 cifs_lock_secret;
>
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 67e7d0ffe385..d1dedb8fb31f 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -375,30 +375,7 @@ cifsFileInfo_get(struct cifsFileInfo *cifs_file)
>         return cifs_file;
>  }
>
> -/**
> - * cifsFileInfo_put - release a reference of file priv data
> - *
> - * Always potentially wait for oplock handler. See _cifsFileInfo_put().
> - */
> -void cifsFileInfo_put(struct cifsFileInfo *cifs_file)
> -{
> -       _cifsFileInfo_put(cifs_file, true);
> -}
> -
> -/**
> - * _cifsFileInfo_put - release a reference of file priv data
> - *
> - * This may involve closing the filehandle @cifs_file out on the
> - * server. Must be called without holding tcon->open_file_lock and
> - * cifs_file->file_info_lock.
> - *
> - * If @wait_for_oplock_handler is true and we are releasing the last
> - * reference, wait for any running oplock break handler of the file
> - * and cancel any pending one. If calling this function from the
> - * oplock break handler, you need to pass false.
> - *
> - */
> -void _cifsFileInfo_put(struct cifsFileInfo *cifs_file, bool wait_oplock_=
handler)
> +void cifsFileInfo_put_final(struct cifsFileInfo *cifs_file)
>  {
>         struct inode *inode =3D d_inode(cifs_file->dentry);
>         struct cifs_tcon *tcon =3D tlink_tcon(cifs_file->tlink);
> @@ -409,7 +386,6 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_file=
, bool wait_oplock_handler)
>         struct cifsLockInfo *li, *tmp;
>         struct cifs_fid fid;
>         struct cifs_pending_open open;
> -       bool oplock_break_cancelled;
>
>         spin_lock(&tcon->open_file_lock);
>         spin_lock(&cifsi->open_file_lock);
> @@ -449,9 +425,6 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_file=
, bool wait_oplock_handler)
>         spin_unlock(&cifsi->open_file_lock);
>         spin_unlock(&tcon->open_file_lock);
>
> -       oplock_break_cancelled =3D wait_oplock_handler ?
> -               cancel_work_sync(&cifs_file->oplock_break) : false;
> -
>         if (!tcon->need_reconnect && !cifs_file->invalidHandle) {
>                 struct TCP_Server_Info *server =3D tcon->ses->server;
>                 unsigned int xid;
> @@ -462,9 +435,6 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_file=
, bool wait_oplock_handler)
>                 _free_xid(xid);
>         }
>
> -       if (oplock_break_cancelled)
> -               cifs_done_oplock_break(cifsi);
> -
>         cifs_del_pending_open(&open);
>
>         /*
> @@ -487,6 +457,61 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_fil=
e, bool wait_oplock_handler)
>         kfree(cifs_file);
>  }
>
> +static void cifsFileInfo_put_work(struct work_struct *work)
> +{
> +       struct cifsFileInfo *cifs_file =3D container_of(work,
> +                       struct cifsFileInfo, put);
> +
> +       cifsFileInfo_put_final(cifs_file);
> +}
> +
> +/**
> + * _cifsFileInfo_put - release a reference of file priv data
> + *
> + * This may involve closing the filehandle @cifs_file out on the
> + * server. Must be called without holding tcon->open_file_lock,
> + * cinode->open_file_lock and cifs_file->file_info_lock.
> + *
> + * If @wait_for_oplock_handler is true and we are releasing the last
> + * reference, wait for any running oplock break handler of the file
> + * and cancel any pending one. If calling this function from the
> + * oplock break handler, you need to pass false.
> + *
> + */
> +void _cifsFileInfo_put(struct cifsFileInfo *cifs_file,
> +                      bool wait_oplock_handler, bool offload)
> +{
> +       struct inode *inode =3D d_inode(cifs_file->dentry);
> +       struct cifsInodeInfo *cifsi =3D CIFS_I(inode);
> +
> +       spin_lock(&cifs_file->file_info_lock);
> +       if (cifs_file->count > 1) {
> +               cifs_file->count--;
> +               spin_unlock(&cifs_file->file_info_lock);
> +               return;
> +       }
> +       spin_unlock(&cifs_file->file_info_lock);
> +
> +       if (wait_oplock_handler && cancel_work_sync(&cifs_file->oplock_br=
eak))
> +               cifs_done_oplock_break(cifsi);

At this point the file info is still in the lists and can be
referenced by other threads not only including oplock break routine.
So, we can't cancel oplock break here - it would lead to big timeouts
to other clients trying to open the file because the server will be
waiting for an oplock break ack.

Let's do it in cifsFileInfo_put_final() as it was originally in
cifsFileInfo_put() and we do not need an extra *wait_oplock_handler*
argument - just cancel it unconditionally. If a caller of this
function don't want to deadlock on himself (like cifs_oplock_break) it
will just specify *offload* as True.

> +
> +       if (offload) {
> +               INIT_WORK(&cifs_file->put, cifsFileInfo_put_work);
> +               queue_work(fileinfo_put_wq, &cifs_file->put);
> +       } else
> +               cifsFileInfo_put_final(cifs_file);
> +}
> +
> +/**
> + * cifsFileInfo_put - release a reference of file priv data
> + *
> + * Always potentially wait for oplock handler. See _cifsFileInfo_put().
> + */
> +void cifsFileInfo_put(struct cifsFileInfo *cifs_file)
> +{
> +       _cifsFileInfo_put(cifs_file, true, true);
> +}
> +
>  int cifs_open(struct inode *inode, struct file *file)
>
>  {
> @@ -808,7 +833,7 @@ cifs_reopen_file(struct cifsFileInfo *cfile, bool can=
_flush)
>  int cifs_close(struct inode *inode, struct file *file)
>  {
>         if (file->private_data !=3D NULL) {
> -               cifsFileInfo_put(file->private_data);
> +               _cifsFileInfo_put(file->private_data, true, false);
>                 file->private_data =3D NULL;
>         }
>
> @@ -4742,7 +4767,7 @@ void cifs_oplock_break(struct work_struct *work)
>                                                              cinode);
>                 cifs_dbg(FYI, "Oplock release rc =3D %d\n", rc);
>         }
> -       _cifsFileInfo_put(cfile, false /* do not wait for ourself */);
> +       _cifsFileInfo_put(cfile, false /* do not wait for ourself */, tru=
e);

As mentioned above, here we only need *offload* as True to not wait
for ourselves.

>         cifs_done_oplock_break(cinode);
>  }
>
> --
> 2.13.6
>

Other than that, I think we the patch is on the right track. It should
give us an opportunity to do file handle batching easily.

--
Best regards,
Pavel Shilovsky
