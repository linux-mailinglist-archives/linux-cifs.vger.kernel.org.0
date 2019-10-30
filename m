Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2C86EA092
	for <lists+linux-cifs@lfdr.de>; Wed, 30 Oct 2019 16:58:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729131AbfJ3P5l (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 30 Oct 2019 11:57:41 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:45430 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbfJ3P5j (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 30 Oct 2019 11:57:39 -0400
Received: by mail-lf1-f67.google.com with SMTP id v8so1947416lfa.12
        for <linux-cifs@vger.kernel.org>; Wed, 30 Oct 2019 08:57:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=W2eXbFLah9ZZZf2+z7O7jA4tSU8FyyGWaLJY2tbd9Do=;
        b=RyUddLuDignmSHWTkI6+/4vnQqfvtWXW01SE/0MO9gcbCG3WMUqKb0cMV1gvSaS+hN
         T8bOMFkzkwMHiWI876og8xkKthRQ15sNhVlExh5rF+6kRvSIBVmI7KlwsmBA1TBrV8G4
         g4HfR7gwPhX98uwqjhkbL7E7T328a8W83qJoa6djmJBBs40ZxogB0c2X8GNDYGFiXTrA
         XfnGwpGHXhbpkHghSSIFxtoLpGoAAIkHhBkkMsG1RAlCkfePEuf+/aKpO3ywsQK+yubf
         byIlS50mDNbhf649DYagwWApuXHi/KvPCsT8y1eaKnOlxg8eiygmV6Gza4/iYg931Tn2
         EWWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=W2eXbFLah9ZZZf2+z7O7jA4tSU8FyyGWaLJY2tbd9Do=;
        b=je7IHTXVaC3Ht9vmWxkdJPSW8zrLGe6EqwM8hAaLVAZp637/4n5wxomqRC1V30iiQJ
         2hIUKoX/6d35f+Nr/0KcnVR2riQ+c3pOJ56e7+MxiMHtVZf2reHvVq8qlf53xElypNDj
         QsnudiFZRI/zj9cFy4iXlOhFxzQs/XSyQw1RiGQoFkZSCd51aGhpa6XqqcBYOOhmZkNd
         q635qPvC7r29DrKwRTsYRT1s1MlgDkw4t5Ir5t5GLTtz4GTN6K5TnkfHCoafdV6EX9wa
         uxI1U4IfGhiVP3fmb/XooBd4I+Zggp8yS/V0qSa2pokk6s4jdITQNKlYRBo+CctgpOlp
         birw==
X-Gm-Message-State: APjAAAXOyAPwTGIYL3zbqmQCPqJ6aOC5e3vmH0Z3zAc2toXyJhS2ZAhx
        YMmzDic77lbqqvhYV/Mqv9D15/6kb0T/66nF6Q==
X-Google-Smtp-Source: APXvYqzcH/nMufD4lx5BvSnIqnvnq9vww8IDZ2cYXauGCaSeVW+C1t7Bo6Kl+RiZIMk9kVoiqQO/vDeKu5LqniGnGrM=
X-Received: by 2002:ac2:5b1d:: with SMTP id v29mr6478265lfn.54.1572451055568;
 Wed, 30 Oct 2019 08:57:35 -0700 (PDT)
MIME-Version: 1.0
References: <20191029031348.13357-1-lsahlber@redhat.com> <20191029031348.13357-2-lsahlber@redhat.com>
 <CAKywueS7QFwNNW6nKnyAuAj78zK=w2VpM1u9+51ER8pp63rGZg@mail.gmail.com> <CAN05THQXgedCXqFXeXdm00Ejd-t1y3ytdHSRmzYAM3vL6vJzww@mail.gmail.com>
In-Reply-To: <CAN05THQXgedCXqFXeXdm00Ejd-t1y3ytdHSRmzYAM3vL6vJzww@mail.gmail.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Wed, 30 Oct 2019 08:57:23 -0700
Message-ID: <CAKywueR9j6EGmryNHo1wO5kojkyLjnvj0reHnDMhijUmRRaG3w@mail.gmail.com>
Subject: Re: [PATCH] cifs: move cifsFileInfo_put logic into a work-queue
To:     ronnie sahlberg <ronniesahlberg@gmail.com>
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>,
        linux-cifs <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

=D0=B2=D1=82, 29 =D0=BE=D0=BA=D1=82. 2019 =D0=B3. =D0=B2 18:25, ronnie sahl=
berg <ronniesahlberg@gmail.com>:
>
> On Wed, Oct 30, 2019 at 9:22 AM Pavel Shilovsky <piastryyy@gmail.com> wro=
te:
> >
> > =D0=B2=D1=82, 29 =D0=BE=D0=BA=D1=82. 2019 =D0=B3. =D0=B2 00:25, Ronnie =
Sahlberg <lsahlber@redhat.com>:
> > >
> > > This patch moves the final part of the cifsFileInfo_put() logic where=
 we
> > > need a write lock on lock_sem to be processed in a separate thread th=
at
> > > holds no other locks.
> > > This is to prevent deadlocks like the one below:
> > >
> > > > there are 6 processes looping to while trying to down_write
> > > > cinode->lock_sem, 5 of them from _cifsFileInfo_put, and one from
> > > > cifs_new_fileinfo
> > > >
> > > > and there are 5 other processes which are blocked, several of them
> > > > waiting on either PG_writeback or PG_locked (which are both set), a=
ll
> > > > for the same page of the file
> > > >
> > > > 2 inode_lock() (inode->i_rwsem) for the file
> > > > 1 wait_on_page_writeback() for the page
> > > > 1 down_read(inode->i_rwsem) for the inode of the directory
> > > > 1 inode_lock()(inode->i_rwsem) for the inode of the directory
> > > > 1 __lock_page
> > > >
> > > >
> > > > so processes are blocked waiting on:
> > > >   page flags PG_locked and PG_writeback for one specific page
> > > >   inode->i_rwsem for the directory
> > > >   inode->i_rwsem for the file
> > > >   cifsInodeInflock_sem
> > > >
> > > >
> > > >
> > > > here are the more gory details (let me know if I need to provide
> > > > anything more/better):
> > > >
> > > > [0 00:48:22.765] [UN]  PID: 8863   TASK: ffff8c691547c5c0  CPU: 3
> > > > COMMAND: "reopen_file"
> > > >  #0 [ffff9965007e3ba8] __schedule at ffffffff9b6e6095
> > > >  #1 [ffff9965007e3c38] schedule at ffffffff9b6e64df
> > > >  #2 [ffff9965007e3c48] rwsem_down_write_slowpath at ffffffff9af283d=
7
> > > >  #3 [ffff9965007e3cb8] legitimize_path at ffffffff9b0f975d
> > > >  #4 [ffff9965007e3d08] path_openat at ffffffff9b0fe55d
> > > >  #5 [ffff9965007e3dd8] do_filp_open at ffffffff9b100a33
> > > >  #6 [ffff9965007e3ee0] do_sys_open at ffffffff9b0eb2d6
> > > >  #7 [ffff9965007e3f38] do_syscall_64 at ffffffff9ae04315
> > > > * (I think legitimize_path is bogus)
> > > >
> > > > in path_openat
> > > >         } else {
> > > >                 const char *s =3D path_init(nd, flags);
> > > >                 while (!(error =3D link_path_walk(s, nd)) &&
> > > >                         (error =3D do_last(nd, file, op)) > 0) {  <=
<<<
> > > >
> > > > do_last:
> > > >         if (open_flag & O_CREAT)
> > > >                 inode_lock(dir->d_inode);  <<<<
> > > >         else
> > > > so it's trying to take inode->i_rwsem for the directory
> > > >
> > > >      DENTRY           INODE           SUPERBLK     TYPE PATH
> > > > ffff8c68bb8e79c0 ffff8c691158ef20 ffff8c6915bf9000 DIR  /mnt/vm1_sm=
b/
> > > > inode.i_rwsem is ffff8c691158efc0
> > > >
> > > > <struct rw_semaphore 0xffff8c691158efc0>:
> > > >         owner: <struct task_struct 0xffff8c6914275d00> (UN -   8856=
 -
> > > > reopen_file), counter: 0x0000000000000003
> > > >         waitlist: 2
> > > >         0xffff9965007e3c90     8863   reopen_file      UN 0  1:29:2=
2.926
> > > >   RWSEM_WAITING_FOR_WRITE
> > > >         0xffff996500393e00     9802   ls               UN 0  1:17:2=
6.700
> > > >   RWSEM_WAITING_FOR_READ
> > > >
> > > >
> > > > the owner of the inode.i_rwsem of the directory is:
> > > >
> > > > [0 00:00:00.109] [UN]  PID: 8856   TASK: ffff8c6914275d00  CPU: 3
> > > > COMMAND: "reopen_file"
> > > >  #0 [ffff99650065b828] __schedule at ffffffff9b6e6095
> > > >  #1 [ffff99650065b8b8] schedule at ffffffff9b6e64df
> > > >  #2 [ffff99650065b8c8] schedule_timeout at ffffffff9b6e9f89
> > > >  #3 [ffff99650065b940] msleep at ffffffff9af573a9
> > > >  #4 [ffff99650065b948] _cifsFileInfo_put.cold.63 at ffffffffc0a42dd=
6 [cifs]
> > > >  #5 [ffff99650065ba38] cifs_writepage_locked at ffffffffc0a0b8f3 [c=
ifs]
> > > >  #6 [ffff99650065bab0] cifs_launder_page at ffffffffc0a0bb72 [cifs]
> > > >  #7 [ffff99650065bb30] invalidate_inode_pages2_range at ffffffff9b0=
4d4bd
> > > >  #8 [ffff99650065bcb8] cifs_invalidate_mapping at ffffffffc0a11339 =
[cifs]
> > > >  #9 [ffff99650065bcd0] cifs_revalidate_mapping at ffffffffc0a1139a =
[cifs]
> > > > #10 [ffff99650065bcf0] cifs_d_revalidate at ffffffffc0a014f6 [cifs]
> > > > #11 [ffff99650065bd08] path_openat at ffffffff9b0fe7f7
> > > > #12 [ffff99650065bdd8] do_filp_open at ffffffff9b100a33
> > > > #13 [ffff99650065bee0] do_sys_open at ffffffff9b0eb2d6
> > > > #14 [ffff99650065bf38] do_syscall_64 at ffffffff9ae04315
> > > >
> > > > cifs_launder_page is for page 0xffffd1e2c07d2480
> > > >
> > > > crash> page.index,mapping,flags 0xffffd1e2c07d2480
> > > >       index =3D 0x8
> > > >       mapping =3D 0xffff8c68f3cd0db0
> > > >   flags =3D 0xfffffc0008095
> > > >
> > > >   PAGE-FLAG       BIT  VALUE
> > > >   PG_locked         0  0000001
> > > >   PG_uptodate       2  0000004
> > > >   PG_lru            4  0000010
> > > >   PG_waiters        7  0000080
> > > >   PG_writeback     15  0008000
> > > >
> > > >
> > > > inode is ffff8c68f3cd0c40
> > > > inode.i_rwsem is ffff8c68f3cd0ce0
> > > >      DENTRY           INODE           SUPERBLK     TYPE PATH
> > > > ffff8c68a1f1b480 ffff8c68f3cd0c40 ffff8c6915bf9000 REG
> > > > /mnt/vm1_smb/testfile.8853
> > > >
> > > >
> > > > this process holds the inode->i_rwsem for the parent directory, is
> > > > laundering a page attached to the inode of the file it's opening, a=
nd in
> > > > _cifsFileInfo_put is trying to down_write the cifsInodeInflock_sem
> > > > for the file itself.
> > > >
> > > >
> > > > <struct rw_semaphore 0xffff8c68f3cd0ce0>:
> > > >         owner: <struct task_struct 0xffff8c6914272e80> (UN -   8854=
 -
> > > > reopen_file), counter: 0x0000000000000003
> > > >         waitlist: 1
> > > >         0xffff9965005dfd80     8855   reopen_file      UN 0  1:29:2=
2.912
> > > >   RWSEM_WAITING_FOR_WRITE
> > > >
> > > > this is the inode.i_rwsem for the file
> > > >
> > > > the owner:
> > > >
> > > > [0 00:48:22.739] [UN]  PID: 8854   TASK: ffff8c6914272e80  CPU: 2
> > > > COMMAND: "reopen_file"
> > > >  #0 [ffff99650054fb38] __schedule at ffffffff9b6e6095
> > > >  #1 [ffff99650054fbc8] schedule at ffffffff9b6e64df
> > > >  #2 [ffff99650054fbd8] io_schedule at ffffffff9b6e68e2
> > > >  #3 [ffff99650054fbe8] __lock_page at ffffffff9b03c56f
> > > >  #4 [ffff99650054fc80] pagecache_get_page at ffffffff9b03dcdf
> > > >  #5 [ffff99650054fcc0] grab_cache_page_write_begin at ffffffff9b03e=
f4c
> > > >  #6 [ffff99650054fcd0] cifs_write_begin at ffffffffc0a064ec [cifs]
> > > >  #7 [ffff99650054fd30] generic_perform_write at ffffffff9b03bba4
> > > >  #8 [ffff99650054fda8] __generic_file_write_iter at ffffffff9b04060=
a
> > > >  #9 [ffff99650054fdf0] cifs_strict_writev.cold.70 at ffffffffc0a446=
9b [cifs]
> > > > #10 [ffff99650054fe48] new_sync_write at ffffffff9b0ec1dd
> > > > #11 [ffff99650054fed0] vfs_write at ffffffff9b0eed35
> > > > #12 [ffff99650054ff00] ksys_write at ffffffff9b0eefd9
> > > > #13 [ffff99650054ff38] do_syscall_64 at ffffffff9ae04315
> > > >
> > > > the process holds the inode->i_rwsem for the file to which it's wri=
ting,
> > > > and is trying to __lock_page for the same page as in the other proc=
esses
> > > >
> > > >
> > > > the other tasks:
> > > > [0 00:00:00.028] [UN]  PID: 8859   TASK: ffff8c6915479740  CPU: 2
> > > > COMMAND: "reopen_file"
> > > >  #0 [ffff9965007b39d8] __schedule at ffffffff9b6e6095
> > > >  #1 [ffff9965007b3a68] schedule at ffffffff9b6e64df
> > > >  #2 [ffff9965007b3a78] schedule_timeout at ffffffff9b6e9f89
> > > >  #3 [ffff9965007b3af0] msleep at ffffffff9af573a9
> > > >  #4 [ffff9965007b3af8] cifs_new_fileinfo.cold.61 at ffffffffc0a42a0=
7 [cifs]
> > > >  #5 [ffff9965007b3b78] cifs_open at ffffffffc0a0709d [cifs]
> > > >  #6 [ffff9965007b3cd8] do_dentry_open at ffffffff9b0e9b7a
> > > >  #7 [ffff9965007b3d08] path_openat at ffffffff9b0fe34f
> > > >  #8 [ffff9965007b3dd8] do_filp_open at ffffffff9b100a33
> > > >  #9 [ffff9965007b3ee0] do_sys_open at ffffffff9b0eb2d6
> > > > #10 [ffff9965007b3f38] do_syscall_64 at ffffffff9ae04315
> > > >
> > > > this is opening the file, and is trying to down_write cinode->lock_=
sem
> > > >
> > > >
> > > > [0 00:00:00.041] [UN]  PID: 8860   TASK: ffff8c691547ae80  CPU: 2
> > > > COMMAND: "reopen_file"
> > > > [0 00:00:00.057] [UN]  PID: 8861   TASK: ffff8c6915478000  CPU: 3
> > > > COMMAND: "reopen_file"
> > > > [0 00:00:00.059] [UN]  PID: 8858   TASK: ffff8c6914271740  CPU: 2
> > > > COMMAND: "reopen_file"
> > > > [0 00:00:00.109] [UN]  PID: 8862   TASK: ffff8c691547dd00  CPU: 6
> > > > COMMAND: "reopen_file"
> > > >  #0 [ffff9965007c3c78] __schedule at ffffffff9b6e6095
> > > >  #1 [ffff9965007c3d08] schedule at ffffffff9b6e64df
> > > >  #2 [ffff9965007c3d18] schedule_timeout at ffffffff9b6e9f89
> > > >  #3 [ffff9965007c3d90] msleep at ffffffff9af573a9
> > > >  #4 [ffff9965007c3d98] _cifsFileInfo_put.cold.63 at ffffffffc0a42dd=
6 [cifs]
> > > >  #5 [ffff9965007c3e88] cifs_close at ffffffffc0a07aaf [cifs]
> > > >  #6 [ffff9965007c3ea0] __fput at ffffffff9b0efa6e
> > > >  #7 [ffff9965007c3ee8] task_work_run at ffffffff9aef1614
> > > >  #8 [ffff9965007c3f20] exit_to_usermode_loop at ffffffff9ae03d6f
> > > >  #9 [ffff9965007c3f38] do_syscall_64 at ffffffff9ae0444c
> > > >
> > > > closing the file, and trying to down_write cifsi->lock_sem
> > > >
> > > >
> > > > [0 00:48:22.839] [UN]  PID: 8857   TASK: ffff8c6914270000  CPU: 7
> > > > COMMAND: "reopen_file"
> > > >  #0 [ffff9965006a7cc8] __schedule at ffffffff9b6e6095
> > > >  #1 [ffff9965006a7d58] schedule at ffffffff9b6e64df
> > > >  #2 [ffff9965006a7d68] io_schedule at ffffffff9b6e68e2
> > > >  #3 [ffff9965006a7d78] wait_on_page_bit at ffffffff9b03cac6
> > > >  #4 [ffff9965006a7e10] __filemap_fdatawait_range at ffffffff9b03b02=
8
> > > >  #5 [ffff9965006a7ed8] filemap_write_and_wait at ffffffff9b040165
> > > >  #6 [ffff9965006a7ef0] cifs_flush at ffffffffc0a0c2fa [cifs]
> > > >  #7 [ffff9965006a7f10] filp_close at ffffffff9b0e93f1
> > > >  #8 [ffff9965006a7f30] __x64_sys_close at ffffffff9b0e9a0e
> > > >  #9 [ffff9965006a7f38] do_syscall_64 at ffffffff9ae04315
> > > >
> > > > in __filemap_fdatawait_range
> > > >                         wait_on_page_writeback(page);
> > > > for the same page of the file
> > > >
> > > >
> > > >
> > > > [0 00:48:22.718] [UN]  PID: 8855   TASK: ffff8c69142745c0  CPU: 7
> > > > COMMAND: "reopen_file"
> > > >  #0 [ffff9965005dfc98] __schedule at ffffffff9b6e6095
> > > >  #1 [ffff9965005dfd28] schedule at ffffffff9b6e64df
> > > >  #2 [ffff9965005dfd38] rwsem_down_write_slowpath at ffffffff9af283d=
7
> > > >  #3 [ffff9965005dfdf0] cifs_strict_writev at ffffffffc0a0c40a [cifs=
]
> > > >  #4 [ffff9965005dfe48] new_sync_write at ffffffff9b0ec1dd
> > > >  #5 [ffff9965005dfed0] vfs_write at ffffffff9b0eed35
> > > >  #6 [ffff9965005dff00] ksys_write at ffffffff9b0eefd9
> > > >  #7 [ffff9965005dff38] do_syscall_64 at ffffffff9ae04315
> > > >
> > > >         inode_lock(inode);
> > > >
> > > >
> > > > and one 'ls' later on, to see whether the rest of the mount is avai=
lable
> > > > (the test file is in the root, so we get blocked up on the director=
y
> > > > ->i_rwsem), so the entire mount is unavailable
> > > >
> > > > [0 00:36:26.473] [UN]  PID: 9802   TASK: ffff8c691436ae80  CPU: 4
> > > > COMMAND: "ls"
> > > >  #0 [ffff996500393d28] __schedule at ffffffff9b6e6095
> > > >  #1 [ffff996500393db8] schedule at ffffffff9b6e64df
> > > >  #2 [ffff996500393dc8] rwsem_down_read_slowpath at ffffffff9b6e9421
> > > >  #3 [ffff996500393e78] down_read_killable at ffffffff9b6e95e2
> > > >  #4 [ffff996500393e88] iterate_dir at ffffffff9b103c56
> > > >  #5 [ffff996500393ec8] ksys_getdents64 at ffffffff9b104b0c
> > > >  #6 [ffff996500393f30] __x64_sys_getdents64 at ffffffff9b104bb6
> > > >  #7 [ffff996500393f38] do_syscall_64 at ffffffff9ae04315
> > > >
> > > > in iterate_dir:
> > > >         if (shared)
> > > >                 res =3D down_read_killable(&inode->i_rwsem);  <<<<
> > > >         else
> > > >                 res =3D down_write_killable(&inode->i_rwsem);
> > > >
> >
> > Thanks for the update.
> >
> > I would suggest to shorten the description to include only two traces
> > of deadlocked processes to improve readability. Please find my other
> > comments below.
> >
> > >
> > > Reported-by: Frank Sorenson <sorenson@redhat.com>:
> > > Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> > > ---
> > >  fs/cifs/cifsfs.c   | 13 +++++++++-
> > >  fs/cifs/cifsglob.h |  5 +++-
> > >  fs/cifs/file.c     | 72 +++++++++++++++++++++++++++++++++++---------=
----------
> > >  3 files changed, 63 insertions(+), 27 deletions(-)
> > >
> > > diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> > > index e4e3b573d20c..f8e201c45ccb 100644
> > > --- a/fs/cifs/cifsfs.c
> > > +++ b/fs/cifs/cifsfs.c
> > > @@ -119,6 +119,7 @@ extern mempool_t *cifs_mid_poolp;
> > >
> > >  struct workqueue_struct        *cifsiod_wq;
> > >  struct workqueue_struct        *decrypt_wq;
> > > +struct workqueue_struct        *fileinfo_put_wq;
> > >  struct workqueue_struct        *cifsoplockd_wq;
> > >  __u32 cifs_lock_secret;
> > >
> > > @@ -1557,11 +1558,18 @@ init_cifs(void)
> > >                 goto out_destroy_cifsiod_wq;
> > >         }
> > >
> > > +       fileinfo_put_wq =3D alloc_workqueue("cifsfileinfoput",
> > > +                                    WQ_UNBOUND|WQ_FREEZABLE|WQ_MEM_R=
ECLAIM, 0);
> > > +       if (!fileinfo_put_wq) {
> > > +               rc =3D -ENOMEM;
> > > +               goto out_destroy_decrypt_wq;
> > > +       }
> > > +
> > >         cifsoplockd_wq =3D alloc_workqueue("cifsoplockd",
> > >                                          WQ_FREEZABLE|WQ_MEM_RECLAIM,=
 0);
> > >         if (!cifsoplockd_wq) {
> > >                 rc =3D -ENOMEM;
> > > -               goto out_destroy_decrypt_wq;
> > > +               goto out_destroy_fileinfo_put_wq;
> > >         }
> > >
> > >         rc =3D cifs_fscache_register();
> > > @@ -1627,6 +1635,8 @@ init_cifs(void)
> > >         cifs_fscache_unregister();
> > >  out_destroy_cifsoplockd_wq:
> > >         destroy_workqueue(cifsoplockd_wq);
> > > +out_destroy_fileinfo_put_wq:
> > > +       destroy_workqueue(fileinfo_put_wq);
> > >  out_destroy_decrypt_wq:
> > >         destroy_workqueue(decrypt_wq);
> > >  out_destroy_cifsiod_wq:
> > > @@ -1656,6 +1666,7 @@ exit_cifs(void)
> > >         cifs_fscache_unregister();
> > >         destroy_workqueue(cifsoplockd_wq);
> > >         destroy_workqueue(decrypt_wq);
> > > +       destroy_workqueue(fileinfo_put_wq);
> > >         destroy_workqueue(cifsiod_wq);
> > >         cifs_proc_clean();
> > >  }
> > > diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> > > index d78bfcc19156..e0a7dc3f62b2 100644
> > > --- a/fs/cifs/cifsglob.h
> > > +++ b/fs/cifs/cifsglob.h
> > > @@ -1265,6 +1265,7 @@ struct cifsFileInfo {
> > >         struct mutex fh_mutex; /* prevents reopen race after dead ses=
*/
> > >         struct cifs_search_info srch_inf;
> > >         struct work_struct oplock_break; /* work for oplock breaks */
> > > +       struct work_struct put; /* work for the final part of _put */
> > >  };
> > >
> > >  struct cifs_io_parms {
> > > @@ -1370,7 +1371,8 @@ cifsFileInfo_get_locked(struct cifsFileInfo *ci=
fs_file)
> > >  }
> > >
> > >  struct cifsFileInfo *cifsFileInfo_get(struct cifsFileInfo *cifs_file=
);
> > > -void _cifsFileInfo_put(struct cifsFileInfo *cifs_file, bool wait_opl=
ock_hdlr);
> > > +void _cifsFileInfo_put(struct cifsFileInfo *cifs_file, bool wait_opl=
ock_hdlr,
> > > +                      bool offload);
> >
> > Do we still need wait_oplock_hdlr here? It is only being used in
> > cifs_oplock_break() and it seems that we can easily remove it and just
> > offload that occurrence to the worker thread archiving the same
> > functionality.
>
> True. Will do that change.
>
> >
> > >  void cifsFileInfo_put(struct cifsFileInfo *cifs_file);
> > >
> > >  #define CIFS_CACHE_READ_FLG    1
> > > @@ -1907,6 +1909,7 @@ void cifs_queue_oplock_break(struct cifsFileInf=
o *cfile);
> > >  extern const struct slow_work_ops cifs_oplock_break_ops;
> > >  extern struct workqueue_struct *cifsiod_wq;
> > >  extern struct workqueue_struct *decrypt_wq;
> > > +extern struct workqueue_struct *fileinfo_put_wq;
> > >  extern struct workqueue_struct *cifsoplockd_wq;
> > >  extern __u32 cifs_lock_secret;
> > >
> > > diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> > > index 67e7d0ffe385..309d6948d2f4 100644
> > > --- a/fs/cifs/file.c
> > > +++ b/fs/cifs/file.c
> > > @@ -375,6 +375,41 @@ cifsFileInfo_get(struct cifsFileInfo *cifs_file)
> > >         return cifs_file;
> > >  }
> > >
> > > +static void cifsFileInfo_put_final(struct cifsFileInfo *cifs_file)
> >
> > This should work but I actually meant something different: to offload
> > the whole _cifsFileInfo_put() by renaming it to
> > cifsFileInfo_put_final() as is and adding new _cifsFileInfo_put() -
> > see below.
> >
> > _cifsFileInfo_put(cifs_file, wait_oplock_handler, offload)
> > {
> >
> > [ with optimizations ]
> > // acquire only file info lock
> > // check reference
> > // if ref=3D1 and offload=3DTrue then put the work in the queue, drop t=
he
> > file info lock and exit
> > // else if ref>1 then just decrement, drop the lock and exit - no need
> > to take tcon and inode locks because we don't modify those lists
> > // else (meaning ref=3D1 and offload=3DFalse) drop the file info lock a=
nd
> > call cifsFileInfo_put_final()
> >
> > OR
> >
> > [ without optimizations ]
> > // just use qeueue_work() all the time when offload=3DTrue
> >
> > }
>
> We can't just unconditionally queue the work as in the "without
> optimizations" example
> because we only have a single work_struct which is part of the
> cifsFileInfo structure.

Yes, you are right. The subsequent one won't be queued.

This actually worries me about the current approach I suggested: if
the file was referenced just after we checked for ref > 1 but before
delayed work proceeded it would lead to work being submitted while
another thread holding a another reference. When that other thread
tries to put its reference, it will try to queue the work again but it
couldn't because another one is already there. This will lead to a
handle leak.


>
> We have to protect against the case where two thread call
> cifsFileInfo_put() concurrently
> and make sure we still only call queue_work() once, for the very last ref=
erence.
>
> I think what my patch does is basically already the "with
> optimizations" example above
> but it also does some additional things before, conditionally, calling
> _final() directly or via
> a work queue.
>
> It does:
> 1, check the reference, if >1 then decrement it and return immediately.
> 2,  some additional stuff while we are still holding the locks
> 3 if offload=3D=3Dtrue, invoke a work queue otherwise call _final() direc=
tly.
>
>
> But I can move more of the "additional stuff" that it does into the
> _final() function
> and make it more similar to your suggestion.
>

Thanks for doing that!

--
Best regards,
Pavel Shilovsky
