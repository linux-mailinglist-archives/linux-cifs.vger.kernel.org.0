Return-Path: <linux-cifs+bounces-3485-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D04F49DAEE3
	for <lists+linux-cifs@lfdr.de>; Wed, 27 Nov 2024 22:22:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38C85B22268
	for <lists+linux-cifs@lfdr.de>; Wed, 27 Nov 2024 21:22:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 62D7C204087;
	Wed, 27 Nov 2024 21:22:30 +0000 (UTC)
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3E52036EF
	for <linux-cifs@vger.kernel.org>; Wed, 27 Nov 2024 21:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732742550; cv=none; b=SkH5J2V+9dcPjScMzznm7ChuETLil+l90XrpsU1gRSDCFLLr+kFSczBCo9RBP6VX3psw87MXg9E5xFhkWEi43KDmlDibJK6XAXFsD78OyzMsYkhTljP4nKCRkFTocNxKBZUznFfOAJN6nqLAqJ74LCeiNzBrnfT2a/rHMsniEuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732742550; c=relaxed/simple;
	bh=yFbgcHeMHyIvKDJ4TL0bBAORSg87sc3mNPdjcKC4euk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=oOXgYiAVcqyNhM7f8JamGVqiFLzzckf8dmTHud0YjW7ZNpXMHZlF5KXlYN2jqud8p813bskAQVa41N+nmyLgN6VkFeT+OyeY6jis97HaHxZV4HECD5j2z/g7zUKF93dpU8ZBgXRHMlxEvj+tYhxJcrnoaRe2tSS3qJkfxKjfBgI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-8419aa81d6aso7449439f.3
        for <linux-cifs@vger.kernel.org>; Wed, 27 Nov 2024 13:22:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732742546; x=1733347346;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=c6w/ragAH6fNV1kVvMrzZ4MY5D3euj2lCORACOs9Ins=;
        b=UxAfe/Cl7NMEyxofnffqHxHiqwgRVdsakWr7mo43/S5pztVJog/1hCOROD/jouF8wh
         HA55v2MqqVma0tEMRIUQNuHE6xrLydnKAzDvFq5XQyjtuT7Ow7hTEspYGNW8C9idkomi
         CzS71Z4z81XXbYyUPKSUFlc3QQRPgRottyAjXRqKT7jH16EpabV8o0MdJu+7A9sGTEd8
         n9wfyK01ejLIPuoovXnTDrEOf4k1gYxvoWfFUUFq89pQJUKlMmuKNyYtRJD9ze5103/6
         3b9VhpooprPRm7qK6MjfzkA7JAJdwxL20Rg0mO6KMoHTEX02Hxd5x/hZGHi6oex3cP0U
         Cyqg==
X-Forwarded-Encrypted: i=1; AJvYcCV1iIcAQcg0sGE+HVQOKQwuMA4EL9+az2JWW0BT5LenaOesQKnvK4CQhKzjyOg6+k1mEWobWF2oDvzN@vger.kernel.org
X-Gm-Message-State: AOJu0YzanJPQbxlvv7+BxbR6IklhJlIc7VGLR2HNh7MPAZT7rl1W8T90
	tg1faNbhVkMgmaauOQ+uKIHIX6lcz+4/4pwXWNMb4ZqatdsTlxiw4+5veb7ABCg0oaULSpJ9U2t
	Z4WBI+QQ4fAkL4cAMZKPCz5bITBZgtJMkug2zDgACm72uftmKcohZPHE=
X-Google-Smtp-Source: AGHT+IHkmj8EeYdD0jdKVhuczxXDyaO0/L8rIBgOTIAxmjMRJSe40gzKjtwDt9Zm2d3nTBtYmpYeeyPhXdVFSHyJu5zkMDHGAN1o
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1caf:b0:3a7:8720:9de8 with SMTP id
 e9e14a558f8ab-3a7c552677amr54613075ab.5.1732742545753; Wed, 27 Nov 2024
 13:22:25 -0800 (PST)
Date: Wed, 27 Nov 2024 13:22:25 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <67478d91.050a0220.253251.0061.GAE@google.com>
Subject: [syzbot] [netfs?] INFO: task hung in netfs_unbuffered_read_iter
From: syzbot <syzbot+8965fea6a159ab9aa32d@syzkaller.appspotmail.com>
To: asmadeus@codewreck.org, bharathsm@microsoft.com, brauner@kernel.org, 
	dhowells@redhat.com, ericvh@kernel.org, jlayton@kernel.org, 
	linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org, 
	linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-trace-kernel@vger.kernel.org, linux_oss@crudebyte.com, lucho@ionkov.net, 
	marc.dionne@auristor.com, mathieu.desnoyers@efficios.com, mhiramat@kernel.org, 
	netfs@lists.linux.dev, pc@manguebit.com, ronniesahlberg@gmail.com, 
	rostedt@goodmis.org, samba-technical@lists.samba.org, sfrench@samba.org, 
	sprasad@microsoft.com, syzkaller-bugs@googlegroups.com, tom@talpey.com, 
	v9fs@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    ed9a4ad6e5bd Add linux-next specific files for 20241126
git tree:       linux-next
console+strace: https://syzkaller.appspot.com/x/log.txt?x=17615530580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e348a4873516af92
dashboard link: https://syzkaller.appspot.com/bug?extid=8965fea6a159ab9aa32d
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=175c8dc0580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=1103a1e8580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/3b9ba5fbd895/disk-ed9a4ad6.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/e30aed8d0305/vmlinux-ed9a4ad6.xz
kernel image: https://storage.googleapis.com/syzbot-assets/1092546e50cf/bzImage-ed9a4ad6.xz

The issue was bisected to:

commit 1bd9011ee163e11f186b72705978fd6b21bdc07b
Author: David Howells <dhowells@redhat.com>
Date:   Fri Nov 8 17:32:29 2024 +0000

    netfs: Change the read result collector to only use one work item

bisection log:  https://syzkaller.appspot.com/x/bisect.txt?x=174cc3c0580000
final oops:     https://syzkaller.appspot.com/x/report.txt?x=14ccc3c0580000
console output: https://syzkaller.appspot.com/x/log.txt?x=10ccc3c0580000

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+8965fea6a159ab9aa32d@syzkaller.appspotmail.com
Fixes: 1bd9011ee163 ("netfs: Change the read result collector to only use one work item")

INFO: task syz-executor246:5857 blocked for more than 143 seconds.
      Not tainted 6.12.0-next-20241126-syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor246 state:D stack:22584 pid:5857  tgid:5857  ppid:5854   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5369 [inline]
 __schedule+0x1850/0x4c30 kernel/sched/core.c:6756
 __schedule_loop kernel/sched/core.c:6833 [inline]
 schedule+0x14b/0x320 kernel/sched/core.c:6848
 bit_wait+0x12/0xd0 kernel/sched/wait_bit.c:237
 __wait_on_bit+0xb0/0x2f0 kernel/sched/wait_bit.c:49
 out_of_line_wait_on_bit+0x1d5/0x260 kernel/sched/wait_bit.c:64
 wait_on_bit include/linux/wait_bit.h:77 [inline]
 netfs_dispatch_unbuffered_reads fs/netfs/direct_read.c:107 [inline]
 netfs_unbuffered_read fs/netfs/direct_read.c:146 [inline]
 netfs_unbuffered_read_iter_locked+0xd7e/0x1560 fs/netfs/direct_read.c:231
 netfs_unbuffered_read_iter+0xbf/0xe0 fs/netfs/direct_read.c:266
 new_sync_read fs/read_write.c:484 [inline]
 vfs_read+0x991/0xb70 fs/read_write.c:565
 ksys_read+0x18f/0x2b0 fs/read_write.c:708
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xf3/0x230 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f1999cb4f79
RSP: 002b:00007ffef9ec4f98 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0030656c69662f2e RCX: 00007f1999cb4f79
RDX: 0000000000002020 RSI: 000000002001b640 RDI: 0000000000000006
RBP: 00007f1999cfe04e R08: 0000000000000006 R09: 0000000000000006
R10: 0000000000000006 R11: 0000000000000246 R12: 00007ffef9ec4fac
R13: 431bde82d7b634db R14: 0000000000000001 R15: 0000000000000001
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/30:
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:337 [inline]
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:849 [inline]
 #0: ffffffff8e937ae0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x55/0x2a0 kernel/locking/lockdep.c:6744
5 locks held by kworker/u8:2/35:
2 locks held by getty/5592:
 #0: ffff888034e320a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002fde2f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
1 lock held by syz-executor246/5857:
 #0: ffff888072050148 (&sb->s_type->i_mutex_key#15){++++}-{4:4}, at: netfs_start_io_direct+0x1d4/0x210 fs/netfs/locking.c:188

=============================================

NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 30 Comm: khungtaskd Not tainted 6.12.0-next-20241126-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
 nmi_cpu_backtrace+0x49c/0x4d0 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x198/0x320 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:234 [inline]
 watchdog+0xffb/0x1040 kernel/hung_task.c:397
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 35 Comm: kworker/u8:2 Not tainted 6.12.0-next-20241126-syzkaller #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
Workqueue: events_unbound toggle_allocation_gate
RIP: 0010:insn_get_sib arch/x86/lib/insn.c:447 [inline]
RIP: 0010:insn_get_displacement+0x2ca/0x9a0 arch/x86/lib/insn.c:484
Code: cb f5 49 bc 00 00 00 00 00 fc ff df e9 12 04 00 00 49 8d 5d 25 48 89 d8 48 c1 e8 03 48 b9 00 00 00 00 00 fc ff df 0f b6 04 08 <84> c0 0f 85 95 05 00 00 0f b6 1b 31 ff 89 de e8 72 c9 cb f5 85 db
RSP: 0018:ffffc90000ab7790 EFLAGS: 00000a07
RAX: 0000000000000000 RBX: ffffc90000ab7945 RCX: dffffc0000000000
RDX: ffff888020a81e00 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000ab794c R08: ffffffff8bd3c21d R09: ffffffff8bd395b6
R10: 0000000000000002 R11: ffff888020a81e00 R12: 1ffff92000156f29
R13: ffffc90000ab7920 R14: 1ffff92000156f2a R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8880b8600000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fbd0e4b4580 CR3: 000000000e736000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 insn_get_immediate+0x62/0x11f0 arch/x86/lib/insn.c:650
 insn_get_length arch/x86/lib/insn.c:723 [inline]
 insn_decode+0x2d6/0x4c0 arch/x86/lib/insn.c:762
 text_poke_loc_init+0xed/0x870 arch/x86/kernel/alternative.c:2432
 arch_jump_label_transform_queue+0x8f/0x100 arch/x86/kernel/jump_label.c:138
 __jump_label_update+0x177/0x3a0 kernel/jump_label.c:513
 static_key_disable_cpuslocked+0xd2/0x1c0 kernel/jump_label.c:240
 static_key_disable+0x1a/0x20 kernel/jump_label.c:248
 toggle_allocation_gate+0x1bf/0x260 mm/kfence/core.c:854
 process_one_work kernel/workqueue.c:3229 [inline]
 process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
 worker_thread+0x870/0xd30 kernel/workqueue.c:3391
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 1.344 msecs


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
For information about bisection process see: https://goo.gl/tpsmEJ#bisection

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

