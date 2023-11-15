Return-Path: <linux-cifs+bounces-45-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 47B267E8BDF
	for <lists+linux-cifs@lfdr.de>; Sat, 11 Nov 2023 18:24:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0140280E1F
	for <lists+linux-cifs@lfdr.de>; Sat, 11 Nov 2023 17:24:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 71B841BDC6;
	Sat, 11 Nov 2023 17:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="WgVnJZNn"
X-Original-To: linux-cifs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A5DC156CD
	for <linux-cifs@vger.kernel.org>; Sat, 11 Nov 2023 17:23:55 +0000 (UTC)
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B588D3879
	for <linux-cifs@vger.kernel.org>; Sat, 11 Nov 2023 09:23:51 -0800 (PST)
Message-ID: <c60ef5a6fb20a59ad7c4979cea5aa4d2.pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1699723429;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=MeqfbsMtj8b2HTM3CApuL2Vj5bUAYIfX3qybusR35Tg=;
	b=WgVnJZNnjuksrrQLP7lGctIae9OZTiBo0DMyDpgj64UApdqCz5tiCULSkf/jQeybFP2T2e
	cV61UQHJcWcJb/bWigys78U9LheAoEuS7UZeSDYABtIb7fTULhK+uXmThetQg52hl5AWhv
	m0V7XDm212ZB/Cva0spy3DqofCcAnzbIGx/wSn+3GwdoDtSfA3iBTiD1QEnbRsfNLu8scl
	rIxMp2//Nee3CJOwTHuSxTWeLxAk+O56V1MT/Ia1qN7CNZ9k87qDvGhW97Wxo9JVLZ+MWD
	9OGDZL3hbWBg+tCo3krHEhpIQJNLRXwZpeaWv7S5j9htC3EJl23kMjmQCSG+7g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1699723429; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MeqfbsMtj8b2HTM3CApuL2Vj5bUAYIfX3qybusR35Tg=;
	b=KFYYSdqp5ufuSctpVOXuTwYRCEB2scqASNrBuAWihmU+zGBajmbLPIptQ3I8VaxysMjorT
	AID1w9m6+QxNNvnqPvBdybi+FiJEK1ilkbBBbSFszgaJfWJ+snFyrhe2XV9OMo3Zl4zkhy
	f8UGQqXhc+sekb+Owf4xFvCtIEPGOKDnWxKdCJUZTZQI1Llod8Z7Z2kkvgqm7czhmH311i
	4XAzJjFeORHAY7PpqHh5tg2TU4xEjsstZAC8xr0TbTNqxQ7MJardUvlSd9fpkFROiSH5Yx
	iKReOK2z/wpyW7pi7mJB7eZukLpWPN9oq/hFyc3uDs/MYKJdoXFQR3oA8Ch12Q==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1699723429; a=rsa-sha256;
	cv=none;
	b=W8b0jWZrbAnuGV8wzP9YBddJ3PYlsNyquhq4aJWlY2TYVljkjeu7SAEFkOPWqHL1oAVE1W
	jlcFyLrRCN7kd3TmbUUa+Wn+jY4P54wE8geE0DoNa3PPbSdjtxLMiXb48+qvrrqVduIUgF
	a4MDvJZChO7k7YUeMKH/CLpe8o5+E0dMO63/HbgmtrrMNMqjwoE5hy4yMDnvSDy2oqp1el
	hppNQXL0SG5oSs8RZ8iv7n3cBno126Zbv62VyZaxWzxruFz3H23Q2pGfqeN4uVGEhRBNd/
	SQa5XjddriEfcPUx5UKn376W5bogqwL/t7TBxEo0smfY6THI0RmPZ0Jy8svoHg==
From: Paulo Alcantara <pc@manguebit.com>
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: smfrench@gmail.com, bharathsm.hsk@gmail.com, linux-cifs@vger.kernel.org,
 Shyam Prasad N <sprasad@microsoft.com>
Subject: Re: [PATCH 12/14] cifs: handle when server stops supporting
 multichannel
In-Reply-To: <CANT5p=p=HC_Bkc57JxE3UDeDXppw7UNecw-iG62v-9GWGnq8Aw@mail.gmail.com>
References: <20231030110020.45627-1-sprasad@microsoft.com>
 <20231030110020.45627-12-sprasad@microsoft.com>
 <5890a4eec52f50b271ba8188f1ace1c9.pc@manguebit.com>
 <147809311fa1593993c7852e32fa52fd.pc@manguebit.com>
 <CANT5p=pawpExEBXp93rK-kmoBPRY4QDMiyXvDCv7Ug0_vrxUPQ@mail.gmail.com>
 <abf890046207efea833cf9f5f9d589ab.pc@manguebit.com>
 <CANT5p=pJ5cXB+U3Zk=V_1Kzt5pkVidmgBZ_rxqmd1-Nisc6-NA@mail.gmail.com>
 <CANT5p=p=HC_Bkc57JxE3UDeDXppw7UNecw-iG62v-9GWGnq8Aw@mail.gmail.com>
Date: Sat, 11 Nov 2023 14:23:43 -0300
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shyam Prasad N <nspmangalore@gmail.com> writes:

> Can you please check if the problem is still seen with these updated patches?
> I was unable to reproduce the issue with the steps you provided.

I couldn't reproduce that reconnect issue anymore.

However, some other problems as shown below with lockdep, kmemleak and
kasan enabled.

$ mount.cifs //w22-root1.gandalf.test/test /mnt/1 -o username=administrator,password=***,multichannel,echo_interval=10
# disable multichannel on w22-root1.gandalf.test server
#   Set-SmbServerConfiguration -EnableMultichannel $false
$ iptables -I INPUT -s 192.168.1.11 -j DROP
$ stat -f /mnt/1
stat: cannot read file system information for '/mnt/1': Host is down
$ iptables -I INPUT -s 192.168.1.11 -j ACCEPT
$ stat -f /mnt/1
stat: cannot read file system information for '/mnt/1': Resource temporarily unavailable

...
[ 1465.290096] CIFS: VFS: \\w22-root1.gandalf.test does not support multichannel anymore. disabling all other channels
[ 1465.292488] 
[ 1465.292863] ======================================================
[ 1465.294183] WARNING: possible circular locking dependency detected
[ 1465.295309] 6.6.0 #2 Not tainted
[ 1465.295863] ------------------------------------------------------
[ 1465.296876] kworker/2:1/1127 is trying to acquire lock:
[ 1465.297745] ffff8880129482c0 (&ret_buf->iface_lock){+.+.}-{2:2}, at: cifs_disable_secondary_channels+0x117/0x280 [cifs]
[ 1465.300314] 
[ 1465.300314] but task is already holding lock:
[ 1465.301267] ffff888012948328 (&ret_buf->chan_lock){+.+.}-{2:2}, at: cifs_disable_secondary_channels+0x29/0x280 [cifs]
[ 1465.303804] 
[ 1465.303804] which lock already depends on the new lock.
[ 1465.303804] 
[ 1465.305107] 
[ 1465.305107] the existing dependency chain (in reverse order) is:
[ 1465.306309] 
[ 1465.306309] -> #1 (&ret_buf->chan_lock){+.+.}-{2:2}:
[ 1465.307391]        _raw_spin_lock+0x34/0x80
[ 1465.308093]        cifs_try_adding_channels+0x205/0x1290 [cifs]
[ 1465.309865]        cifs_mount+0xfb/0x4c0 [cifs]
[ 1465.311423]        cifs_smb3_do_mount+0x1e5/0xcc0 [cifs]
[ 1465.313094]        smb3_get_tree+0x16d/0x380 [cifs]
[ 1465.314702]        vfs_get_tree+0x4d/0x190
[ 1465.315275]        path_mount+0x3c4/0xf90
[ 1465.315811]        __x64_sys_mount+0x1aa/0x1f0
[ 1465.316392]        do_syscall_64+0x47/0xf0
[ 1465.316950]        entry_SYSCALL_64_after_hwframe+0x6f/0x77
[ 1465.317681] 
[ 1465.317681] -> #0 (&ret_buf->iface_lock){+.+.}-{2:2}:
[ 1465.318548]        __lock_acquire+0x1793/0x2110
[ 1465.319156]        lock_acquire+0x14a/0x3a0
[ 1465.319714]        _raw_spin_lock+0x34/0x80
[ 1465.320266]        cifs_disable_secondary_channels+0x117/0x280 [cifs]
[ 1465.321729]        smb2_reconnect+0x520/0xcb0 [cifs]
[ 1465.323001]        smb2_reconnect_server+0x771/0xb00 [cifs]
[ 1465.324352]        process_one_work+0x43c/0x8e0
[ 1465.324959]        worker_thread+0x397/0x690
[ 1465.325522]        kthread+0x18d/0x1d0
[ 1465.326028]        ret_from_fork+0x34/0x60
[ 1465.326564]        ret_from_fork_asm+0x1b/0x30
[ 1465.327164] 
[ 1465.327164] other info that might help us debug this:
[ 1465.327164] 
[ 1465.328180]  Possible unsafe locking scenario:
[ 1465.328180] 
[ 1465.328943]        CPU0                    CPU1
[ 1465.329523]        ----                    ----
[ 1465.330119]   lock(&ret_buf->chan_lock);
[ 1465.330649]                                lock(&ret_buf->iface_lock);
[ 1465.331493]                                lock(&ret_buf->chan_lock);
[ 1465.332326]   lock(&ret_buf->iface_lock);
[ 1465.332865] 
[ 1465.332865]  *** DEADLOCK ***
[ 1465.332865] 
[ 1465.333623] 5 locks held by kworker/2:1/1127:
[ 1465.334199]  #0: ffff88800dd09d48 ((wq_completion)cifsiod){+.+.}-{0:0}, at: process_one_work+0x39a/0x8e0
[ 1465.335430]  #1: ffff88800de97dc0 ((work_completion)(&(&tcp_ses->reconnect)->work)){+.+.}-{0:0}, at: process_one_work+0x39a/0x8e0
[ 1465.336947]  #2: ffff88800dd7a8c8 (&tcp_ses->reconnect_mutex){+.+.}-{3:3}, at: smb2_reconnect_server+0xde/0xb00 [cifs]
[ 1465.338953]  #3: ffff8880129480f0 (&ret_buf->session_mutex){+.+.}-{3:3}, at: smb2_reconnect+0x234/0xcb0 [cifs]
[ 1465.340838]  #4: ffff888012948328 (&ret_buf->chan_lock){+.+.}-{2:2}, at: cifs_disable_secondary_channels+0x29/0x280 [cifs]
[ 1465.342073] 
[ 1465.342073] stack backtrace:
[ 1465.342421] CPU: 2 PID: 1127 Comm: kworker/2:1 Not tainted 6.6.0 #2
[ 1465.342917] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 1465.343782] Workqueue: cifsiod smb2_reconnect_server [cifs]
[ 1465.344595] Call Trace:
[ 1465.344845]  <TASK>
[ 1465.345025]  dump_stack_lvl+0x4a/0x80
[ 1465.345329]  check_noncircular+0x269/0x2b0
[ 1465.345672]  ? __pfx_check_noncircular+0x10/0x10
[ 1465.346047]  ? __pfx_stack_trace_save+0x10/0x10
[ 1465.346420]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.346814]  ? lockdep_lock+0xa3/0x160
[ 1465.347128]  ? __pfx_lockdep_lock+0x10/0x10
[ 1465.347465]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.347858]  ? add_chain_block+0x1d8/0x280
[ 1465.348191]  __lock_acquire+0x1793/0x2110
[ 1465.348524]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.348918]  ? __pfx___lock_acquire+0x10/0x10
[ 1465.349271]  ? __pfx_prb_read_valid+0x10/0x10
[ 1465.349624]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.350018]  ? llist_add_batch+0x9d/0xf0
[ 1465.350344]  ? __pfx_llist_add_batch+0x10/0x10
[ 1465.350712]  lock_acquire+0x14a/0x3a0
[ 1465.351014]  ? cifs_disable_secondary_channels+0x117/0x280 [cifs]
[ 1465.351874]  ? __pfx_lock_acquire+0x10/0x10
[ 1465.352214]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.352600]  ? hlock_class+0x32/0xc0
[ 1465.352900]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.353286]  ? lock_acquired+0x2df/0x510
[ 1465.353612]  ? do_raw_spin_trylock+0xd1/0x120
[ 1465.353973]  ? __pfx_lock_acquired+0x10/0x10
[ 1465.354323]  _raw_spin_lock+0x34/0x80
[ 1465.354622]  ? cifs_disable_secondary_channels+0x117/0x280 [cifs]
[ 1465.355484]  cifs_disable_secondary_channels+0x117/0x280 [cifs]
[ 1465.356332]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.356730]  smb2_reconnect+0x520/0xcb0 [cifs]
[ 1465.357477]  smb2_reconnect_server+0x771/0xb00 [cifs]
[ 1465.358269]  ? __pfx_smb2_reconnect_server+0x10/0x10 [cifs]
[ 1465.359089]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.359478]  ? lock_is_held_type+0x90/0x100
[ 1465.359830]  ? mark_held_locks+0x1a/0x90
[ 1465.360155]  process_one_work+0x43c/0x8e0
[ 1465.360493]  ? __pfx_process_one_work+0x10/0x10
[ 1465.360912]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.361359]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.361754]  ? __list_add_valid_or_report+0x37/0xf0
[ 1465.362155]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.362544]  worker_thread+0x397/0x690
[ 1465.362863]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.363250]  ? __kthread_parkme+0xce/0xf0
[ 1465.363583]  ? __pfx_worker_thread+0x10/0x10
[ 1465.363942]  kthread+0x18d/0x1d0
[ 1465.364210]  ? kthread+0xdb/0x1d0
[ 1465.364483]  ? __pfx_kthread+0x10/0x10
[ 1465.364798]  ret_from_fork+0x34/0x60
[ 1465.365093]  ? __pfx_kthread+0x10/0x10
[ 1465.365400]  ret_from_fork_asm+0x1b/0x30
[ 1465.365733]  </TASK>
[ 1465.365954] BUG: sleeping function called from invalid context at kernel/workqueue.c:3344
[ 1465.366821] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1127, name: kworker/2:1
[ 1465.367690] preempt_count: 1, expected: 0
[ 1465.368115] RCU nest depth: 0, expected: 0
[ 1465.368547] INFO: lockdep is turned off.
[ 1465.368984] CPU: 2 PID: 1127 Comm: kworker/2:1 Not tainted 6.6.0 #2
[ 1465.369642] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 1465.370788] Workqueue: cifsiod smb2_reconnect_server [cifs]
[ 1465.371888] Call Trace:
[ 1465.372164]  <TASK>
[ 1465.372401]  dump_stack_lvl+0x64/0x80
[ 1465.372809]  __might_resched+0x23c/0x360
[ 1465.373236]  ? __pfx___might_resched+0x10/0x10
[ 1465.373722]  ? rcu_is_watching+0x23/0x50
[ 1465.374149]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.374661]  ? __might_sleep+0x2b/0xb0
[ 1465.375119]  ? __flush_work+0xc5/0x640
[ 1465.375524]  __flush_work+0xfd/0x640
[ 1465.375914]  ? __flush_work+0xc5/0x640
[ 1465.376320]  ? add_chain_block+0x1d8/0x280
[ 1465.376771]  ? __pfx___flush_work+0x10/0x10
[ 1465.377240]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.377686]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.378072]  ? try_to_grab_pending+0x47/0x3a0
[ 1465.378430]  __cancel_work_timer+0x210/0x2c0
[ 1465.378785]  ? __pfx___cancel_work_timer+0x10/0x10
[ 1465.379176]  ? do_raw_spin_trylock+0xd1/0x120
[ 1465.379537]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.379933]  ? do_raw_spin_unlock+0x9b/0x100
[ 1465.380293]  cifs_put_tcp_session+0x118/0x290 [cifs]
[ 1465.381076]  cifs_disable_secondary_channels+0xdb/0x280 [cifs]
[ 1465.381930]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.382323]  smb2_reconnect+0x520/0xcb0 [cifs]
[ 1465.383072]  smb2_reconnect_server+0x771/0xb00 [cifs]
[ 1465.383870]  ? __pfx_smb2_reconnect_server+0x10/0x10 [cifs]
[ 1465.384694]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.385084]  ? lock_is_held_type+0x90/0x100
[ 1465.385424]  ? mark_held_locks+0x1a/0x90
[ 1465.385708] CIFS: fs/smb/client/cifsfs.c: VFS: in cifs_statfs as Xid: 9 with uid: 0
[ 1465.385754]  process_one_work+0x43c/0x8e0
[ 1465.387019]  ? __pfx_process_one_work+0x10/0x10
[ 1465.387387]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.387821]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.388334]  ? __list_add_valid_or_report+0x37/0xf0
[ 1465.388870]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.389385]  worker_thread+0x397/0x690
[ 1465.389753]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.390144]  ? __kthread_parkme+0xce/0xf0
[ 1465.390476]  ? __pfx_worker_thread+0x10/0x10
[ 1465.390833]  kthread+0x18d/0x1d0
[ 1465.391103]  ? kthread+0xdb/0x1d0
[ 1465.391378]  ? __pfx_kthread+0x10/0x10
[ 1465.391695]  ret_from_fork+0x34/0x60
[ 1465.391991]  ? __pfx_kthread+0x10/0x10
[ 1465.392302]  ret_from_fork_asm+0x1b/0x30
[ 1465.392632]  </TASK>
[ 1465.393120] CIFS: fs/smb/client/connect.c: cifs_setup_session: channel connect bitmap: 0x1
[ 1465.393959] CIFS: fs/smb/client/connect.c: Free previous auth_key.response = 0000000018de71c6
[ 1465.393960] CIFS: fs/smb/client/smb2pdu.c: sess reconnect mask: 0x1, tcon reconnect: 0
[ 1465.394666] CIFS: fs/smb/client/connect.c: Security Mode: 0x1 Capabilities: 0x300067 TimeAdjust: 0
[ 1465.396191] CIFS: fs/smb/client/smb2pdu.c: Session Setup
[ 1465.396675] CIFS: fs/smb/client/smb2pdu.c: sess setup type 2
[ 1465.397269] CIFS: fs/smb/client/smb2pdu.c: Fresh session. Previous: 1e800d8000049
[ 1465.399253] CIFS: fs/smb/client/smb2maperror.c: Mapping SMB2 status code 0xc0000016 to POSIX err -5
[ 1465.400409] CIFS: fs/smb/client/sess.c: decode_ntlmssp_challenge: negotiate=0xe2088235 challenge=0xe2898235
[ 1465.401245] CIFS: fs/smb/client/smb2pdu.c: rawntlmssp session setup challenge phase
[ 1465.402058] CIFS: fs/smb/client/smb2pdu.c: Fresh session. Previous: 1e800d8000049
[ 1465.404585] CIFS: fs/smb/client/smb2pdu.c: SMB2/3 session established successfully
[ 1465.405543] CIFS: fs/smb/client/sess.c: Cleared reconnect bitmask for chan 0; now 0x0
[ 1465.406375] CIFS: fs/smb/client/connect.c: __cifs_put_smb_ses: ses_count=2
[ 1465.407092] CIFS: fs/smb/client/connect.c: __cifs_put_smb_ses: ses ipc: \\w22-root1.gandalf.test\IPC$
[ 1465.408048] CIFS: fs/smb/client/smb2pdu.c: Reconnecting tcons and channels finished
[ 1465.408794] CIFS: fs/smb/client/smb2pdu.c: Reconnecting tcons and channels
[ 1465.409349] CIFS: fs/smb/client/smb2pdu.c: Reconnecting tcons and channels finished
[ 1465.409949] CIFS: Server share \\w22-root1.gandalf.test\test deleted.
[ 1465.410961] CIFS: fs/smb/client/smb2maperror.c: Mapping SMB2 status code 0xc00000c9 to POSIX err -78
[ 1465.412204] CIFS: server share \\w22-root1.gandalf.test\test deleted
[ 1465.413298] CIFS: fs/smb/client/smb2pdu.c: sess reconnect mask: 0x0, tcon reconnect: 1
[ 1465.413311] CIFS: fs/smb/client/smb2pdu.c: reconnect tcon rc = 0
[ 1465.415272] CIFS: fs/smb/client/smb2pdu.c: sess reconnect mask: 0x0, tcon reconnect: 1
[ 1465.415285] CIFS: fs/smb/client/smb2pdu.c: reconnect tcon rc = 0
[ 1465.417047] CIFS: fs/smb/client/smb2pdu.c: Reconnecting tcons and channels
[ 1465.417911] CIFS: fs/smb/client/smb2pdu.c: sess reconnect mask: 0x0, tcon reconnect: 1
[ 1465.417924] CIFS: fs/smb/client/smb2pdu.c: reconnect tcon rc = 0
[ 1465.421431] CIFS: fs/smb/client/connect.c: cifs_put_tcon: tc_count=2
[ 1465.422397] CIFS: fs/smb/client/smb2pdu.c: Reconnecting tcons and channels finished
[ 1465.423725] ------------[ cut here ]------------
[ 1465.424158] WARNING: CPU: 3 PID: 85 at fs/smb/client/connect.c:1616 cifs_put_tcp_session+0x27a/0x290 [cifs]
[ 1465.425407] Modules linked in: cifs cifs_arc4 nls_ucs2_utils fscache cifs_md4 [last unloaded: cifs]
[ 1465.426242] CPU: 3 PID: 85 Comm: kworker/3:3 Tainted: G        W          6.6.0 #2
[ 1465.426929] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 1465.427915] Workqueue: cifsiod smb2_reconnect_server [cifs]
[ 1465.428828] RIP: 0010:cifs_put_tcp_session+0x27a/0x290 [cifs]
[ 1465.429754] Code: b1 15 c2 e9 32 fe ff ff 89 ee 48 89 df e8 9e fd ff ff e9 cd fe ff ff be 03 00 00 00 4c 89 ef e8 ac 6d ad c1 e9 11 fe ff ff 90 <0f> 0b 90 e9 c0 fd ff ff 66 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00
[ 1465.431382] RSP: 0018:ffff88800b8afc10 EFLAGS: 00010286
[ 1465.431872] RAX: 00000000ffffffff RBX: ffff88800dd7a000 RCX: dffffc0000000000
[ 1465.432498] RDX: 0000000000000003 RSI: ffffffffc00e901b RDI: ffff88800dd7a070
[ 1465.433134] RBP: 0000000000000001 R08: 0000000000000000 R09: fffffbfff082290a
[ 1465.433788] R10: ffffffff84114857 R11: 0000000000000000 R12: 1ffff11001715f90
[ 1465.434416] R13: ffff88800b8afca0 R14: ffff88800dd7a7a0 R15: ffff88800b8afc88
[ 1465.435086] FS:  0000000000000000(0000) GS:ffff88805b000000(0000) knlGS:0000000000000000
[ 1465.435818] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 1465.436330] CR2: 00007f00682affae CR3: 0000000009fe6000 CR4: 0000000000750ef0
[ 1465.436981] PKRU: 55555554
[ 1465.437227] Call Trace:
[ 1465.437458]  <TASK>
[ 1465.437676]  ? __warn+0xa5/0x200
[ 1465.437979]  ? cifs_put_tcp_session+0x27a/0x290 [cifs]
[ 1465.438833]  ? report_bug+0x1b2/0x1e0
[ 1465.439168]  ? handle_bug+0x6f/0x90
[ 1465.439484]  ? exc_invalid_op+0x17/0x50
[ 1465.439846]  ? asm_exc_invalid_op+0x1a/0x20
[ 1465.440247]  ? cifs_put_tcp_session+0x2b/0x290 [cifs]
[ 1465.441102]  ? cifs_put_tcp_session+0x27a/0x290 [cifs]
[ 1465.441970]  smb2_reconnect_server+0x646/0xb00 [cifs]
[ 1465.442823]  ? lock_sync+0xd0/0xe0
[ 1465.443138]  ? __pfx_smb2_reconnect_server+0x10/0x10 [cifs]
[ 1465.444042]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.444467]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.444912]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.445342]  ? read_word_at_a_time+0xe/0x20
[ 1465.445727]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.446150]  process_one_work+0x43c/0x8e0
[ 1465.446513]  ? __pfx_process_one_work+0x10/0x10
[ 1465.446946]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.447376]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.447826]  ? __list_add_valid_or_report+0x37/0xf0
[ 1465.448278]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.448731]  worker_thread+0x397/0x690
[ 1465.449080]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1465.449515]  ? __kthread_parkme+0xce/0xf0
[ 1465.449991]  ? __pfx_worker_thread+0x10/0x10
[ 1465.450390]  kthread+0x18d/0x1d0
[ 1465.450712]  ? kthread+0xdb/0x1d0
[ 1465.451022]  ? __pfx_kthread+0x10/0x10
[ 1465.451362]  ret_from_fork+0x34/0x60
[ 1465.451699]  ? __pfx_kthread+0x10/0x10
[ 1465.452038]  ret_from_fork_asm+0x1b/0x30
[ 1465.452405]  </TASK>
[ 1465.452605] irq event stamp: 87714
[ 1465.452927] hardirqs last  enabled at (87713): [<ffffffff82864168>] _raw_spin_unlock_irq+0x28/0x50
[ 1465.453732] hardirqs last disabled at (87714): [<ffffffff82856f8d>] __schedule+0xc0d/0x1560
[ 1465.454468] softirqs last  enabled at (87624): [<ffffffff8110918c>] process_one_work+0x43c/0x8e0
[ 1465.455257] softirqs last disabled at (87620): [<ffffffff8227f67a>] neigh_managed_work+0x2a/0x110
[ 1465.456055] ---[ end trace 0000000000000000 ]---
[ 1465.456937] CIFS: fs/smb/client/cifsfs.c: VFS: leaving cifs_statfs (xid = 9) rc = -11
[ 1528.811802] CIFS: fs/smb/client/connect.c: VFS: in smb2_query_server_interfaces as Xid: 10 with uid: 0
[ 1528.813395] CIFS: fs/smb/client/smb2pdu.c: SMB2 IOCTL
[ 1528.814246] ==================================================================
[ 1528.815401] BUG: KASAN: slab-use-after-free in cifs_pick_channel+0xa2/0x170 [cifs]
[ 1528.817404] Read of size 1 at addr ffff88800dd7a2c4 by task kworker/0:2/1114
[ 1528.818539] 
[ 1528.818810] CPU: 0 PID: 1114 Comm: kworker/0:2 Tainted: G        W          6.6.0 #2
[ 1528.820040] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 1528.821789] Workqueue: cifsiod smb2_query_server_interfaces [cifs]
[ 1528.823573] Call Trace:
[ 1528.823991]  <TASK>
[ 1528.824360]  dump_stack_lvl+0x4a/0x80
[ 1528.824976]  print_report+0xcf/0x650
[ 1528.825577]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.826361]  ? rcu_is_watching+0x23/0x50
[ 1528.827011]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.827804]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.828590]  ? __phys_addr+0x46/0x90
[ 1528.829193]  kasan_report+0xd8/0x110
[ 1528.829794]  ? cifs_pick_channel+0xa2/0x170 [cifs]
[ 1528.831379]  ? cifs_pick_channel+0xa2/0x170 [cifs]
[ 1528.832952]  cifs_pick_channel+0xa2/0x170 [cifs]
[ 1528.834506]  SMB2_ioctl+0x1b5/0x6f0 [cifs]
[ 1528.835969]  ? __pfx_console_unlock+0x10/0x10
[ 1528.836692]  ? tick_nohz_tick_stopped+0x21/0x30
[ 1528.837441]  ? __pfx_SMB2_ioctl+0x10/0x10 [cifs]
[ 1528.838992]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.839779]  ? irq_work_queue+0x2c/0x40
[ 1528.840416]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.841210]  ? lock_acquire+0xc1/0x3a0
[ 1528.841840]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.842626]  ? _printk+0xc0/0xf0
[ 1528.843191]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.843977]  ? __dynamic_pr_debug+0x1f5/0x260
[ 1528.844705]  ? __pfx___dynamic_pr_debug+0x10/0x10
[ 1528.845476]  ? lock_release+0xb6/0x5a0
[ 1528.846104]  ? __pfx_lock_acquire+0x10/0x10
[ 1528.846802]  ? SMB3_request_interfaces+0x137/0x2b0 [cifs]
[ 1528.848468]  SMB3_request_interfaces+0x137/0x2b0 [cifs]
[ 1528.850103]  ? __pfx_SMB3_request_interfaces+0x10/0x10 [cifs]
[ 1528.851828]  ? ___ratelimit+0x133/0x210
[ 1528.852535]  ? __pfx____ratelimit+0x10/0x10
[ 1528.853207]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.853839]  smb2_query_server_interfaces+0x54/0x1f0 [cifs]
[ 1528.855179]  process_one_work+0x43c/0x8e0
[ 1528.855848]  ? __pfx_process_one_work+0x10/0x10
[ 1528.856595]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.857380]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.858170]  ? __list_add_valid_or_report+0x37/0xf0
[ 1528.858985]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.859773]  worker_thread+0x397/0x690
[ 1528.860410]  ? __pfx_worker_thread+0x10/0x10
[ 1528.861124]  kthread+0x18d/0x1d0
[ 1528.861668]  ? kthread+0xdb/0x1d0
[ 1528.862226]  ? __pfx_kthread+0x10/0x10
[ 1528.862851]  ret_from_fork+0x34/0x60
[ 1528.863449]  ? __pfx_kthread+0x10/0x10
[ 1528.864074]  ret_from_fork_asm+0x1b/0x30
[ 1528.864745]  </TASK>
[ 1528.865120] 
[ 1528.865389] Allocated by task 1253:
[ 1528.865965]  kasan_save_stack+0x33/0x60
[ 1528.866602]  kasan_set_track+0x25/0x30
[ 1528.867226]  __kasan_kmalloc+0x8f/0xa0
[ 1528.867856]  cifs_get_tcp_session+0xbc/0xc70 [cifs]
[ 1528.869161]  cifs_mount_get_session+0x70/0x220 [cifs]
[ 1528.870425]  dfs_mount_share+0x249/0x1060 [cifs]
[ 1528.871650]  cifs_mount+0xda/0x4c0 [cifs]
[ 1528.872785]  cifs_smb3_do_mount+0x1e5/0xcc0 [cifs]
[ 1528.874016]  smb3_get_tree+0x16d/0x380 [cifs]
[ 1528.875208]  vfs_get_tree+0x4d/0x190
[ 1528.875684]  path_mount+0x3c4/0xf90
[ 1528.876149]  __x64_sys_mount+0x1aa/0x1f0
[ 1528.876664]  do_syscall_64+0x47/0xf0
[ 1528.877140]  entry_SYSCALL_64_after_hwframe+0x6f/0x77
[ 1528.877800] 
[ 1528.878013] Freed by task 1255:
[ 1528.878428]  kasan_save_stack+0x33/0x60
[ 1528.878934]  kasan_set_track+0x25/0x30
[ 1528.879430]  kasan_save_free_info+0x2b/0x50
[ 1528.879975]  ____kasan_slab_free+0x126/0x170
[ 1528.880536]  slab_free_freelist_hook+0x9d/0x1e0
[ 1528.881131]  __kmem_cache_free+0x9d/0x190
[ 1528.881506]  clean_demultiplex_info+0x3bb/0x640 [cifs]
[ 1528.882306]  cifs_demultiplex_thread+0x3de/0x1270 [cifs]
[ 1528.883086]  kthread+0x18d/0x1d0
[ 1528.883351]  ret_from_fork+0x34/0x60
[ 1528.883643]  ret_from_fork_asm+0x1b/0x30
[ 1528.883960] 
[ 1528.884092] Last potentially related work creation:
[ 1528.884481]  kasan_save_stack+0x33/0x60
[ 1528.884792]  __kasan_record_aux_stack+0x94/0xa0
[ 1528.885155]  __queue_work+0x334/0x8a0
[ 1528.885454]  mod_delayed_work_on+0xa5/0x100
[ 1528.885792]  smb2_reconnect+0x735/0xcb0 [cifs]
[ 1528.886518]  SMB2_query_info_init+0xca/0x250 [cifs]
[ 1528.887273]  smb2_query_info_compound+0x473/0x6d0 [cifs]
[ 1528.888065]  smb2_queryfs+0xc2/0x2c0 [cifs]
[ 1528.888763]  smb311_queryfs+0x210/0x220 [cifs]
[ 1528.889485]  cifs_statfs+0x164/0x290 [cifs]
[ 1528.890185]  statfs_by_dentry+0x9b/0xf0
[ 1528.890497]  user_statfs+0xab/0x130
[ 1528.890783]  __do_sys_statfs+0x81/0xe0
[ 1528.891090]  do_syscall_64+0x47/0xf0
[ 1528.891383]  entry_SYSCALL_64_after_hwframe+0x6f/0x77
[ 1528.891786] 
[ 1528.891918] Second to last potentially related work creation:
[ 1528.892368]  kasan_save_stack+0x33/0x60
[ 1528.892679]  __kasan_record_aux_stack+0x94/0xa0
[ 1528.893043]  __queue_work+0x334/0x8a0
[ 1528.893342]  mod_delayed_work_on+0xa5/0x100
[ 1528.893680]  smb2_reconnect+0x735/0xcb0 [cifs]
[ 1528.894409]  SMB2_open_init+0xf8/0x13f0 [cifs]
[ 1528.895135]  smb2_query_info_compound+0x2b6/0x6d0 [cifs]
[ 1528.895925]  smb2_queryfs+0xc2/0x2c0 [cifs]
[ 1528.896628]  smb311_queryfs+0x210/0x220 [cifs]
[ 1528.897353]  cifs_statfs+0x164/0x290 [cifs]
[ 1528.898060]  statfs_by_dentry+0x9b/0xf0
[ 1528.898371]  user_statfs+0xab/0x130
[ 1528.898656]  __do_sys_statfs+0x81/0xe0
[ 1528.898961]  do_syscall_64+0x47/0xf0
[ 1528.899255]  entry_SYSCALL_64_after_hwframe+0x6f/0x77
[ 1528.899658] 
[ 1528.899790] The buggy address belongs to the object at ffff88800dd7a000
[ 1528.899790]  which belongs to the cache kmalloc-4k of size 4096
[ 1528.900751] The buggy address is located 708 bytes inside of
[ 1528.900751]  freed 4096-byte region [ffff88800dd7a000, ffff88800dd7b000)
[ 1528.901699] 
[ 1528.901830] The buggy address belongs to the physical page:
[ 1528.902268] page:00000000b974ece7 refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xdd78
[ 1528.902981] head:00000000b974ece7 order:3 entire_mapcount:0 nr_pages_mapped:0 pincount:0
[ 1528.903609] anon flags: 0x100000000000840(slab|head|node=0|zone=1)
[ 1528.904098] page_type: 0xffffffff()
[ 1528.904386] raw: 0100000000000840 ffff888006443040 0000000000000000 dead000000000001
[ 1528.904989] raw: 0000000000000000 0000000000040004 00000001ffffffff 0000000000000000
[ 1528.905591] page dumped because: kasan: bad access detected
[ 1528.906030] 
[ 1528.906161] Memory state around the buggy address:
[ 1528.906542]  ffff88800dd7a180: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1528.907107]  ffff88800dd7a200: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1528.907675] >ffff88800dd7a280: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1528.908240]                                            ^
[ 1528.908660]  ffff88800dd7a300: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1528.909225]  ffff88800dd7a380: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
[ 1528.909787] ==================================================================
[ 1528.910379] Kernel panic - not syncing: kasan.fault=panic set ...
[ 1528.910867] CPU: 0 PID: 1114 Comm: kworker/0:2 Tainted: G        W          6.6.0 #2
[ 1528.911475] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
[ 1528.912368] Workqueue: cifsiod smb2_query_server_interfaces [cifs]
[ 1528.913235] Call Trace:
[ 1528.913439]  <TASK>
[ 1528.913616]  dump_stack_lvl+0x4a/0x80
[ 1528.913917]  panic+0x41f/0x460
[ 1528.914177]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.914563]  ? __pfx_panic+0x10/0x10
[ 1528.914855]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.915248]  ? check_panic_on_warn+0x2f/0x80
[ 1528.915594]  end_report+0x125/0x130
[ 1528.915882]  kasan_report+0xe8/0x110
[ 1528.916176]  ? cifs_pick_channel+0xa2/0x170 [cifs]
[ 1528.916935]  ? cifs_pick_channel+0xa2/0x170 [cifs]
[ 1528.917695]  cifs_pick_channel+0xa2/0x170 [cifs]
[ 1528.918437]  SMB2_ioctl+0x1b5/0x6f0 [cifs]
[ 1528.919138]  ? __pfx_console_unlock+0x10/0x10
[ 1528.919490]  ? tick_nohz_tick_stopped+0x21/0x30
[ 1528.919857]  ? __pfx_SMB2_ioctl+0x10/0x10 [cifs]
[ 1528.920596]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.920985]  ? irq_work_queue+0x2c/0x40
[ 1528.921298]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.921685]  ? lock_acquire+0xc1/0x3a0
[ 1528.921998]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.922416]  ? _printk+0xc0/0xf0
[ 1528.922726]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.923157]  ? __dynamic_pr_debug+0x1f5/0x260
[ 1528.923546]  ? __pfx___dynamic_pr_debug+0x10/0x10
[ 1528.924097]  ? lock_release+0xb6/0x5a0
[ 1528.924707]  ? __pfx_lock_acquire+0x10/0x10
[ 1528.925558]  ? SMB3_request_interfaces+0x137/0x2b0 [cifs]
[ 1528.926794]  SMB3_request_interfaces+0x137/0x2b0 [cifs]
[ 1528.927962]  ? __pfx_SMB3_request_interfaces+0x10/0x10 [cifs]
[ 1528.929230]  ? ___ratelimit+0x133/0x210
[ 1528.929847]  ? __pfx____ratelimit+0x10/0x10
[ 1528.930217]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.930730]  smb2_query_server_interfaces+0x54/0x1f0 [cifs]
[ 1528.931564]  process_one_work+0x43c/0x8e0
[ 1528.931900]  ? __pfx_process_one_work+0x10/0x10
[ 1528.932273]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.932663]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.933055]  ? __list_add_valid_or_report+0x37/0xf0
[ 1528.933459]  ? srso_alias_return_thunk+0x5/0xfbef5
[ 1528.933852]  worker_thread+0x397/0x690
[ 1528.934173]  ? __pfx_worker_thread+0x10/0x10
[ 1528.934526]  kthread+0x18d/0x1d0
[ 1528.934799]  ? kthread+0xdb/0x1d0
[ 1528.935077]  ? __pfx_kthread+0x10/0x10
[ 1528.935388]  ret_from_fork+0x34/0x60
[ 1528.935686]  ? __pfx_kthread+0x10/0x10
[ 1528.935997]  ret_from_fork_asm+0x1b/0x30
[ 1528.936328]  </TASK>
[ 1528.937856] Kernel Offset: disabled
[ 1528.938146] ---[ end Kernel panic - not syncing: kasan.fault=panic set ... ]---

$ mount.cifs //w22-root1.gandalf.test/test /mnt/1 -o username=administrator,password=***
# ...wait until smb2_query_server_interfaces() is executed at least once...
$ cat /sys/kernel/debug/kmemleak
unreferenced object 0xffff888007821c00 (size 192):
  comm "mount.cifs", pid 885, jiffies 4294765292 (age 656.515s)
  hex dump (first 32 bytes):
    f0 52 da 16 80 88 ff ff f0 52 da 16 80 88 ff ff  .R.......R......
    01 00 00 00 00 00 00 00 00 ca 9a 3b 00 00 00 00  ...........;....
  backtrace:
    [<ffffffff8144e3f5>] __kmem_cache_alloc_node+0x295/0x2d0
    [<ffffffff813ab1aa>] kmalloc_trace+0x2a/0xc0
    [<ffffffffc0141c9d>] parse_server_interfaces+0x4ed/0xcc0 [cifs]
    [<ffffffffc014b323>] SMB3_request_interfaces+0x163/0x2b0 [cifs]
    [<ffffffffc014b5ed>] smb3_qfs_tcon+0x16d/0x2c0 [cifs]
    [<ffffffffc00f02c1>] cifs_mount_get_tcon+0x3b1/0x550 [cifs]
    [<ffffffffc0181f7a>] dfs_mount_share+0x1da/0x1060 [cifs]
    [<ffffffffc00f089a>] cifs_mount+0xda/0x4c0 [cifs]
    [<ffffffffc00e06d5>] cifs_smb3_do_mount+0x1e5/0xcc0 [cifs]
    [<ffffffffc0175a1d>] smb3_get_tree+0x16d/0x380 [cifs]
    [<ffffffff8147c1ad>] vfs_get_tree+0x4d/0x190
    [<ffffffff814c66d4>] path_mount+0x3c4/0xf90
    [<ffffffff814c7b5a>] __x64_sys_mount+0x1aa/0x1f0
    [<ffffffff8284c3d7>] do_syscall_64+0x47/0xf0
    [<ffffffff82a000eb>] entry_SYSCALL_64_after_hwframe+0x6f/0x77
    ...

$ ./scripts/faddr2line --list fs/smb/client/cifs.o parse_server_interfaces+0x4ed
parse_server_interfaces+0x4ed/0xcc0:

kmalloc at /home/pc/g/linux/./include/linux/slab.h:600
 595 
 596                    if (size > KMALLOC_MAX_CACHE_SIZE)
 597                            return kmalloc_large(size, flags);
 598 
 599                    index = kmalloc_index(size);
>600<                   return kmalloc_trace(
 601                                    kmalloc_caches[kmalloc_type(flags, _RET_IP_)][index],
 602                                    flags, size);
 603            }
 604            return __kmalloc(size, flags);
 605    }

(inlined by) parse_server_interfaces at /home/pc/g/linux/fs/smb/client/smb2ops.c:694
 689                            }
 690                    }
 691                    spin_unlock(&ses->iface_lock);
 692 
 693                    /* no match. insert the entry in the list */
>694<                   info = kmalloc(sizeof(struct cifs_server_iface),
 695                                   GFP_KERNEL);
 696                    if (!info) {
 697                            rc = -ENOMEM;
 698                            goto out;
 699                    }

