Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 50D026123F
	for <lists+linux-cifs@lfdr.de>; Sat,  6 Jul 2019 18:49:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727096AbfGFQt1 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 6 Jul 2019 12:49:27 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:40467 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbfGFQt1 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 6 Jul 2019 12:49:27 -0400
Received: by mail-lf1-f68.google.com with SMTP id b17so4583747lff.7
        for <linux-cifs@vger.kernel.org>; Sat, 06 Jul 2019 09:49:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=EQKk8phXhfoAAScbmlOB3WDQQ959VprJ1CGmJErkRok=;
        b=LF1zULUjNTayuzQ+S0KocDaHGCDKHnkbQMA/SV8R+Qh4cvGbXqc5vg3C07yVE1twTC
         p2CwjA/OOLdtdsSwQmYgcXHWcs5pzLZxNfSxgd9dmMRQn1jt4HMuwugPqsWdFwvcYzfj
         uqtrh344BJcsVj0N5ClKfLakn7h2xU02XDL9Qkr3AfdGWI+S51+ASCDrOcaYAcHCne2Q
         ykrN+PjHxB3HKu3Pyr3FKFXj1N85MOQd1iH9ZBcwCYC62EG03HhYXGmyFORpUTWQ9JXh
         FQLK4nKrtZELxa5XTQBg/bpOoEfexFVvCQl1KDyA7C0ErtnnLJKrX7d9ZAEyrtzPo62A
         qvRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=EQKk8phXhfoAAScbmlOB3WDQQ959VprJ1CGmJErkRok=;
        b=tiAOn4YsoPxyQ4g4GrXCqIZPtOisMMgP95mNhUdQg13JlMcDPfjCrYIFmMnb6tbU0R
         9D5Uao0yiLnSPPLQWWb1r0rQm78LKzrWycS2cEyhz5lB72tE/kQzZiXIaJgctoP/gsmB
         EBIRWpqXP1NdDmEw3zkOjjMmB53nl5WMKh/09CsJzHh2TDEQBkq95j0qG/VyYguye7qZ
         aQUB00rNjF0PMkHLhkxND7kMXL0SVlRNLi5Skv1gEovXbhdflk//VgLIz/boqR6K9Nu5
         UzWqcQxOSbU7uN2ZRHK9Qe8kKbxf45HmENFxXh6xaW1PXc2U1Vb+CzCuYt0RVEdu7JOh
         CFiA==
X-Gm-Message-State: APjAAAUVtd0UTCf9Q04eCN+ZdckzeaUIQPxnUB8ZlgCB1vBqVU5PDy2U
        bQ3+83DskFZNBwkFEc/vgz66PnQJDzWO1CGZqoyrGiE=
X-Google-Smtp-Source: APXvYqy8Bvl+E8pfwYIzWizm+ZPfToVFwRy/hu+k6zwvL3qKSIx41mBz4sK+v+cgxsZyWX7Ou52T1jKBaryKu6Dqh+4=
X-Received: by 2002:ac2:52ac:: with SMTP id r12mr2025552lfm.54.1562431764078;
 Sat, 06 Jul 2019 09:49:24 -0700 (PDT)
MIME-Version: 1.0
References: <CAPWvxscPxF-bEy8ybgT5fSjxNbA7tf1_mXEoo5LOr79qRoukmg@mail.gmail.com>
 <CAKywueQnekHWsAzo4s+5ON2W9siLiPh8G-FHB0aCN+xrgJt4vA@mail.gmail.com> <CAPWvxsdTbq8jwTN+2syjsiZwCGGNMvmr+j8sS_ucnKe-TNLDzA@mail.gmail.com>
In-Reply-To: <CAPWvxsdTbq8jwTN+2syjsiZwCGGNMvmr+j8sS_ucnKe-TNLDzA@mail.gmail.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Sat, 6 Jul 2019 09:49:12 -0700
Message-ID: <CAKywueRUpSEgmV4MAAGFsBOR7opYqjAU4cwj5SjmTX-1NbVJgA@mail.gmail.com>
Subject: Re: General protection faults in cifs_reconnect with Azure Files
To:     Luke Carrier <luke@carrier.im>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

=D1=81=D0=B1, 6 =D0=B8=D1=8E=D0=BB. 2019 =D0=B3. =D0=B2 05:32, Luke Carrier=
 <luke@carrier.im>:
>
> Hi Pavel,
>
> Thanks for the prompt response.
>
> Under the 5.1.0 kernel we observed slightly different oopses, again
> during reconnection:
>
> [   64.118926] CIFS VFS: Send error in SessSetup =3D -11
> [  107.638988] CIFS VFS: Send error in SessSetup =3D -11
> [  138.487142] CIFS VFS: Send error in SessSetup =3D -11
> [  148.599239] CIFS VFS: Send error in SessSetup =3D -11
> [  186.685967] CIFS VFS: Send error in SessSetup =3D -11
> [  193.450272] CIFS VFS: Send error in SessSetup =3D -11
> [  364.918259] INFO: task kworker/3:2:271 blocked for more than 120 secon=
ds.
> [  364.924765]       Not tainted 5.1.0-050100-generic #201905052130
> [  364.931458] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  364.939006] kworker/3:2     D    0   271      2 0x80000000
> [  364.939043] Workqueue: cifsiod smb2_reconnect_server [cifs]
> [  364.939049] Call Trace:
> [  364.939057]  __schedule+0x2d3/0x840
> [  364.939061]  ? wake_up_klogd+0x34/0x40
> [  364.939063]  schedule+0x2c/0x70
> [  364.939066]  schedule_preempt_disabled+0xe/0x10
> [  364.939071]  __mutex_lock.isra.10+0x2e4/0x4c0
> [  364.939074]  ? printk+0x58/0x6f
> [  364.939079]  __mutex_lock_slowpath+0x13/0x20
> [  364.939081]  mutex_lock+0x2c/0x30
> [  364.939098]  smb2_reconnect.part.22+0xea/0x7c0 [cifs]
> [  364.939103]  ? lock_timer_base+0x6b/0x90
> [  364.939116]  ? cifs_put_tcon.part.45+0x162/0x1e0 [cifs]
> [  364.939149]  smb2_reconnect_server+0x190/0x2a0 [cifs]
> [  364.939154]  process_one_work+0x20f/0x410
> [  364.939155]  worker_thread+0x34/0x400
> [  364.939157]  kthread+0x120/0x140
> [  364.939158]  ? process_one_work+0x410/0x410
> [  364.939160]  ? __kthread_parkme+0x70/0x70
> [  364.939161]  ret_from_fork+0x35/0x40
> [  364.939184] INFO: task php-fpm7.2:1913 blocked for more than 120 secon=
ds.
> [  364.944595]       Not tainted 5.1.0-050100-generic #201905052130
> [  364.949987] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  364.957078] php-fpm7.2      D    0  1913   1325 0x00000000
> [  364.957079] Call Trace:
> [  364.957083]  __schedule+0x2d3/0x840
> [  364.957086]  ? __d_alloc+0x122/0x1d0
> [  364.957090]  schedule+0x2c/0x70
> [  364.957094]  d_alloc_parallel+0x3df/0x490
> [  364.957096]  ? __switch_to_asm+0x34/0x70
> [  364.957100]  ? wake_up_q+0x80/0x80
> [  364.957105]  __lookup_slow+0x71/0x150
> [  364.957107]  lookup_slow+0x3a/0x60
> [  364.957108]  walk_component+0x1bf/0x330
> [  364.957110]  ? link_path_walk.part.42+0x61/0x540
> [  364.957112]  path_lookupat.isra.45+0x6d/0x220
> [  364.957114]  filename_lookup.part.61+0xa0/0x170
> [  364.957118]  ? __check_object_size+0x166/0x192
> [  364.957121]  ? strncpy_from_user+0x56/0x1b0
> [  364.957123]  user_path_at_empty+0x3e/0x50
> [  364.957125]  vfs_statx+0x76/0xe0
> [  364.957126]  __do_sys_newstat+0x3d/0x70
> [  364.957129]  ? handle_mm_fault+0xe1/0x210
> [  364.957133]  ? __do_page_fault+0x259/0x4b0
> [  364.957136]  __x64_sys_newstat+0x16/0x20
> [  364.957141]  do_syscall_64+0x5a/0x110
> [  364.957145]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  364.957165] RIP: 0033:0x7f3a2ff5f775
> [  364.957171] Code: Bad RIP value.
> [  364.957171] RSP: 002b:00007ffdada63d48 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000004
> [  364.957173] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f3a2=
ff5f775
> [  364.957173] RDX: 00007ffdada63ed0 RSI: 00007ffdada63ed0 RDI: 00007f3a1=
6eeff78
> [  364.957174] RBP: 00007f3a16eeff78 R08: 000000000000ffff R09: 000000000=
0000020
> [  364.957174] R10: 00007f3a2ffdd2e0 R11: 0000000000000246 R12: 000000000=
0000000
> [  364.957175] R13: 00007ffdada63ed0 R14: 00000000fffffffb R15: 000000000=
0000000
> [  364.957179] INFO: task php-fpm7.2:1926 blocked for more than 120 secon=
ds.
> [  364.963025]       Not tainted 5.1.0-050100-generic #201905052130
> [  364.968886] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  364.976107] php-fpm7.2      D    0  1926   1325 0x00000000
> [  364.976109] Call Trace:
> [  364.976113]  __schedule+0x2d3/0x840
> [  364.976115]  schedule+0x2c/0x70
> [  364.976119]  schedule_preempt_disabled+0xe/0x10
> [  364.976123]  __mutex_lock.isra.10+0x2e4/0x4c0
> [  364.976127]  ? del_timer_sync+0x39/0x40
> [  364.976130]  __mutex_lock_slowpath+0x13/0x20
> [  364.976132]  mutex_lock+0x2c/0x30
> [  364.976188]  smb2_reconnect.part.22+0xea/0x7c0 [cifs]
> [  364.976210]  ? wait_woken+0x80/0x80
> [  364.976223]  smb2_plain_req_init+0x3e/0x270 [cifs]
> [  364.976238]  SMB2_open_init+0x69/0x760 [cifs]
> [  364.976249]  ? cifs_get_inode_info+0x28f/0xb30 [cifs]
> [  364.976263]  open_shroot+0x21e/0x4a0 [cifs]
> [  364.976277]  smb2_query_path_info+0x133/0x1f0 [cifs]
> [  364.976291]  ? smb2_query_path_info+0x133/0x1f0 [cifs]
> [  364.976294]  ? _cond_resched+0x19/0x30
> [  364.976297]  ? kmem_cache_alloc_trace+0x150/0x1d0
> [  364.976308]  cifs_get_inode_info+0x2df/0xb30 [cifs]
> [  364.976319]  ? build_path_from_dentry_optional_prefix+0xc4/0x400 [cifs=
]
> [  364.976351]  cifs_revalidate_dentry_attr+0xd5/0x360 [cifs]
> [  364.976362]  cifs_getattr+0x5a/0x1a0 [cifs]
> [  364.976365]  vfs_getattr_nosec+0x98/0xc0
> [  364.976366]  vfs_getattr+0x36/0x40
> [  364.976368]  vfs_statx+0x8d/0xe0
> [  364.976369]  __do_sys_newstat+0x3d/0x70
> [  364.976370]  __x64_sys_newstat+0x16/0x20
> [  364.976372]  do_syscall_64+0x5a/0x110
> [  364.976374]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  364.976375] RIP: 0033:0x7f3a2ff5f775
> [  364.976377] Code: Bad RIP value.
> [  364.976378] RSP: 002b:00007ffdada62ec8 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000004
> [  364.976379] RAX: ffffffffffffffda RBX: 00007f3a16eeff78 RCX: 00007f3a2=
ff5f775
> [  364.976379] RDX: 00007ffdada62ef0 RSI: 00007ffdada62ef0 RDI: 00007ffda=
da62f80
> [  364.976380] RBP: 0000000000000021 R08: 0000000000c3dfc8 R09: 000000000=
000017b
> [  364.976381] R10: 00007ffdada60e10 R11: 0000000000000246 R12: 00007ffda=
da62f81
> [  364.976381] R13: 0000000000000000 R14: 00007ffdada62f99 R15: 00007ffda=
da62f80
> [  364.976384] INFO: task php-fpm7.2:1933 blocked for more than 120 secon=
ds.
> [  364.981953]       Not tainted 5.1.0-050100-generic #201905052130
> [  364.986915] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> disables this message.
> [  364.993572] php-fpm7.2      D    0  1933   1325 0x80000000
> [  364.993574] Call Trace:
> [  364.993578]  __schedule+0x2d3/0x840
> [  364.993598]  schedule+0x2c/0x70
> [  364.993600]  schedule_preempt_disabled+0xe/0x10
> [  364.993601]  __mutex_lock.isra.10+0x2e4/0x4c0
> [  364.993603]  __mutex_lock_slowpath+0x13/0x20
> [  364.993605]  mutex_lock+0x2c/0x30
> [  364.993617]  cifs_mark_open_files_invalid+0x5b/0xa0 [cifs]
> [  364.993633]  smb2_reconnect.part.22+0x131/0x7c0 [cifs]
> [  364.993638]  ? kmem_cache_alloc_trace+0x150/0x1d0
> [  364.993641]  ? char2uni+0x29/0x70 [nls_utf8]
> [  364.993658]  smb2_plain_req_init+0x3e/0x270 [cifs]
> [  364.993673]  SMB2_open_init+0x69/0x760 [cifs]
> [  364.993687]  ? cifs_convert_path_to_utf16+0x7a/0xb0 [cifs]
> [  364.993701]  smb2_compound_op+0x189/0x1930 [cifs]
> [  364.993706]  ? prep_new_page+0x99/0x130
> [  364.993709]  ? get_page_from_freelist+0xeed/0x1350
> [  364.993711]  ? __alloc_pages_nodemask+0x16a/0x330
> [  364.993724]  smb2_query_path_info+0xc8/0x1f0 [cifs]
> [  364.993737]  ? smb2_query_path_info+0xc8/0x1f0 [cifs]
> [  364.993740]  ? _cond_resched+0x19/0x30
> [  364.993741]  ? kmem_cache_alloc_trace+0x150/0x1d0
> [  364.993752]  cifs_get_inode_info+0x2df/0xb30 [cifs]
> [  364.993753]  ? kmem_cache_alloc+0x15c/0x1c0
> [  364.993795]  ? build_path_from_dentry_optional_prefix+0x12f/0x400 [cif=
s]
> [  364.993819]  cifs_lookup+0xf3/0x7b0 [cifs]
> [  364.993823]  __lookup_slow+0x9b/0x150
> [  364.993825]  lookup_slow+0x3a/0x60
> [  364.993826]  walk_component+0x1bf/0x330
> [  364.993828]  ? link_path_walk.part.42+0x61/0x540
> [  364.993830]  path_lookupat.isra.45+0x6d/0x220
> [  364.993833]  filename_lookup.part.61+0xa0/0x170
> [  364.993835]  ? __check_object_size+0x166/0x192
> [  364.993837]  ? strncpy_from_user+0x56/0x1b0
> [  364.993839]  user_path_at_empty+0x3e/0x50
> [  364.993841]  vfs_statx+0x76/0xe0
> [  364.993843]  __do_sys_newstat+0x3d/0x70
> [  364.993845]  __x64_sys_newstat+0x16/0x20
> [  364.993847]  do_syscall_64+0x5a/0x110
> [  364.993850]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [  364.993851] RIP: 0033:0x7f3a2ff5f775
> [  364.993862] Code: Bad RIP value.
> [  364.993862] RSP: 002b:00007ffdada63d48 EFLAGS: 00000246 ORIG_RAX:
> 0000000000000004
> [  364.993864] RAX: ffffffffffffffda RBX: 0000000000000002 RCX: 00007f3a2=
ff5f775
> [  364.993865] RDX: 00007ffdada63ed0 RSI: 00007ffdada63ed0 RDI: 00007f3a1=
6eeff78
> [  364.993866] RBP: 00007f3a16eeff78 R08: 000000000000ffff R09: 000000000=
0000020
> [  364.993867] R10: 00007f3a2ffdd2e0 R11: 0000000000000246 R12: 000000000=
0000000
> [  364.993867] R13: 00007ffdada63ed0 R14: 00000000fffffffb R15: 000000000=
0000000
>
> We had been experiencing different faults under 4.18 (the current stable =
in
> Ubuntu 18.04 LTS), but had never seen a call trace that directly implicat=
ed
> memory management. If it's worth sharing these oopses I can, but I suspec=
t
> it's better to work backwards through the Ubuntu mainline kernel images t=
o
> try and isolate this fault than to dig through fairly ancient kernels?
>
> Cheers,
> Luke
>

Hi Luke,

The issue you are observing on the 5.1 kernel seems similar to the
issue in the parallel thread in the mailing list. So, this might be a
deadlock problem. Please try to mount with "nohandlecache" mount
option to see if it helps.

It also worth to mention, that the problem reported on 5.2-rc kernel
was a different one and we still don't know what may be a reason for
that.

About digging old kernels - I agree, better not to do it. It is easier
to debug the current kernel and to work backward through the images.

--
Best regards,
Pavel Shilovsky
