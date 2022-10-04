Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D254A5F40A6
	for <lists+linux-cifs@lfdr.de>; Tue,  4 Oct 2022 12:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229792AbiJDKQx convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Tue, 4 Oct 2022 06:16:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41526 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbiJDKQs (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 4 Oct 2022 06:16:48 -0400
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::223])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 649163337F
        for <linux-cifs@vger.kernel.org>; Tue,  4 Oct 2022 03:16:40 -0700 (PDT)
Received: (Authenticated sender: pbl@bestov.io)
        by mail.gandi.net (Postfix) with ESMTPSA id C2C2A60002
        for <linux-cifs@vger.kernel.org>; Tue,  4 Oct 2022 10:16:35 +0000 (UTC)
Mime-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 04 Oct 2022 12:16:34 +0200
Message-Id: <CND27FUBGI9V.29BBF662TV9DA@enhorning>
Subject: CIFS kills my system when connection breaks
From:   "Riccardo Paolo Bestetti" <pbl@bestov.io>
To:     <linux-cifs@vger.kernel.org>
X-Mailer: aerc 0.12.0
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

TL;DR: Under conditions that I have not been able to fully identify, but
have something to do with network interruptions, CIFS seems to be
breaking my system to the point where some system calls that have
nothing to do with network filesystems and it doesn't un-break until the
CIFS fs is lazily unmounted.

I have the following setup in my /etc/fstab (apologies for long lines):
//some.host/backup		/volumes/storagebox	cifs	echo_interval=15,soft,nofail,credentials=/root/.smbstoragebox,uid=random,gid=random,iocharset=utf8,rw 0 0
/volumes/storagebox/chest	/volumes/chest		fuse./usr/bin/gocryptfs	nofail,allow_other,passfile=/root/.chest 0 0

Under normal conditions (network online, server reachable) mounts work ok:
# mount /volumes/storagebox
# mount /volumes/chest
# touch /volumes/storagebox/aFile  # takes <1 second
# touch /volumes/chest/aFile       # takes a couple seconds

However, under some conditions (my best guess is when some echo messages
from the server are missed, e.g. when I resume after suspension or
reconnect through a different network interface) the CIFS mount starts
hanging system calls. E.g. the mount command hangs indefinitely, stat on
a path under the network share never returns, and sometimes (I have not
identified exactly when) I can not even save files in my home directory
and tmpfs, which should have nothing to do with all of this.

This is mostly fixed by:
# umount -l /volumes/storagebox

I'm not sure what that does under the hood exactly, but evidently it
must be making whatever is holding the mutex release it: as soon as I
give that command, either all hanged syscalls/processes immediately resume,
or they do after a few minutes.

Please note that I've mentioned my entire setup, including the overlayed
fuse filesystem, on the off chance I'm missing anything, but all of this
happens even when /volumes/chest is not mounted.

At the end of this email you can find an extract of the kernel log from
the "hung task" kernel functionality. It shows CIFS waiting on a mutex
while attempting to reconnect. That happens a few minutes after a

CIFS: VFS: \\storage.host has not responded in 45 seconds. Reconnecting...

line is printed. (45 seconds might be my echo_interval * 3?)

While this happens, I verified with tcpdump that my computer sends about
1 packet per 2 minutes to the CIFS server, without getting any replies.

To clarify what the email is about, my expectations - according to the
documentation and my use case - are:
- system calls should return (it's a soft mount) after some timeout or
  as soon as the fs notices the need to reconnect, which judging from
  the aforementioned line it does
- system calls which don't intersect CIFS filesystems should not hang
  because of CIFS
- CIFS should successfully reconnect (i.e. same as me manually doing
  umount -l /volumes/storagebox; mount /volumes/storagebox) when it
  notices it needs to do so

First of all, are these expectations conformant to the *intended*
behaviour of the CIFS driver, or is the observed behaviour correct? If
we can identify a cause for this issue, I'm happy to prepare and test a
patch myself.

I went through mount.cifs(8) a couple times before posting this,
apologies if I missed anything.

Best regards,
Riccardo P. Bestetti

-- 
Kernel log:
Oct 04 10:34:58 enhorning kernel: INFO: task zsh:5217 blocked for more than 245 seconds.
Oct 04 10:34:58 enhorning kernel:       Tainted: G           OE     5.19.12-arch1-1 #1
Oct 04 10:34:58 enhorning kernel: "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
Oct 04 10:34:58 enhorning kernel: task:zsh             state:D stack:    0 pid: 5217 ppid:  5201 flags:0x00000006
Oct 04 10:34:58 enhorning kernel: Call Trace:
Oct 04 10:34:58 enhorning kernel:  <TASK>
Oct 04 10:34:58 enhorning kernel:  __schedule+0x356/0x11a0
Oct 04 10:34:58 enhorning kernel:  schedule+0x5e/0xd0
Oct 04 10:34:58 enhorning kernel:  schedule_preempt_disabled+0x15/0x30
Oct 04 10:34:58 enhorning kernel:  __mutex_lock.constprop.0+0x461/0x6e0
Oct 04 10:34:58 enhorning kernel:  smb2_reconnect+0x33c/0x610 [cifs cb6635f7865b17a0b314f8877a819120d4d6ead7]
Oct 04 10:34:58 enhorning kernel:  ? cifsConvertToUTF16+0x259/0x3e0 [cifs cb6635f7865b17a0b314f8877a819120d4d6ead7]
Oct 04 10:34:58 enhorning kernel:  ? __kmalloc+0x171/0x380
Oct 04 10:34:58 enhorning kernel:  SMB2_open_init+0x7b/0xb80 [cifs cb6635f7865b17a0b314f8877a819120d4d6ead7]
Oct 04 10:34:58 enhorning kernel:  smb2_compound_op+0x5d5/0x1910 [cifs cb6635f7865b17a0b314f8877a819120d4d6ead7]
Oct 04 10:34:58 enhorning kernel:  smb2_query_path_info+0xc2/0x210 [cifs cb6635f7865b17a0b314f8877a819120d4d6ead7]
Oct 04 10:34:58 enhorning kernel:  cifs_get_inode_info+0x2bf/0xac0 [cifs cb6635f7865b17a0b314f8877a819120d4d6ead7]
Oct 04 10:34:58 enhorning kernel:  ? path_lookupat+0x97/0x1a0
Oct 04 10:34:58 enhorning kernel:  cifs_revalidate_dentry_attr+0x180/0x3b0 [cifs cb6635f7865b17a0b314f8877a819120d4d6ead7]
Oct 04 10:34:58 enhorning kernel:  cifs_getattr+0xc1/0x250 [cifs cb6635f7865b17a0b314f8877a819120d4d6ead7]
Oct 04 10:34:58 enhorning kernel:  vfs_statx+0xb6/0x140
Oct 04 10:34:58 enhorning kernel:  vfs_fstatat+0x55/0x70
Oct 04 10:34:58 enhorning kernel:  __do_sys_newfstatat+0x3f/0x80
Oct 04 10:34:58 enhorning kernel:  do_syscall_64+0x5c/0x90
Oct 04 10:34:58 enhorning kernel:  ? __x64_sys_getdents64+0xe2/0x130
Oct 04 10:34:58 enhorning kernel:  ? __ia32_sys_getdents64+0x130/0x130
Oct 04 10:34:58 enhorning kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
Oct 04 10:34:58 enhorning kernel:  ? do_syscall_64+0x6b/0x90
Oct 04 10:34:58 enhorning kernel:  ? syscall_exit_to_user_mode+0x1b/0x40
Oct 04 10:34:58 enhorning kernel:  ? do_syscall_64+0x6b/0x90
Oct 04 10:34:58 enhorning kernel:  entry_SYSCALL_64_after_hwframe+0x63/0xcd
Oct 04 10:34:58 enhorning kernel: RIP: 0033:0x7fb432e8c34e
Oct 04 10:34:58 enhorning kernel: RSP: 002b:00007ffc077b6fd8 EFLAGS: 00000202 ORIG_RAX: 0000000000000106
Oct 04 10:34:58 enhorning kernel: RAX: ffffffffffffffda RBX: 00007ffc077b7080 RCX: 00007fb432e8c34e
Oct 04 10:34:58 enhorning kernel: RDX: 00007ffc077b8300 RSI: 00007ffc077b7080 RDI: 00000000ffffff9c
Oct 04 10:34:58 enhorning kernel: RBP: 0000563dda500433 R08: 0000000000000000 R09: 00786f6265676172
Oct 04 10:34:58 enhorning kernel: R10: 0000000000000100 R11: 0000000000000202 R12: 00007ffc077b8300
Oct 04 10:34:58 enhorning kernel: R13: 00007ffc077b8300 R14: 0000000000000009 R15: 0000000000000000
Oct 04 10:34:58 enhorning kernel:  </TASK>

