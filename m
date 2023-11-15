Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 883B87DE208
	for <lists+linux-cifs@lfdr.de>; Wed,  1 Nov 2023 15:14:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235523AbjKAOMy (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 1 Nov 2023 10:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235182AbjKAOMx (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 1 Nov 2023 10:12:53 -0400
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10ACD110
        for <linux-cifs@vger.kernel.org>; Wed,  1 Nov 2023 07:12:47 -0700 (PDT)
Message-ID: <d1c99946663662e7160bf1ed0a6b2dc6.pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1698847965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LCAC7W2hLqX/2frRNswQuSQy4/ePkwVSreq/kkvRoKs=;
        b=WPOOGqIHArIxBWa3eW6RXRMXx0K93RQwT8S9+3aeVeXOPZMNJvu+/ClwtSuejI1AgRuWDW
        5A8fEiJSdBLPxFsu9HMOOFkcbQwh86hza3gAlqLLN+xzqFjDgBXz0JiAEtJ469w7OarxW5
        3+51TV9bO8FSQ0da/GAlf0w8e6w1LtictCNpzGnoOUPKG85Vg0YHVsPMI3Z9ickYaZ7kQ7
        vp/D6+NMb0b3un0ZuGlNKMcKr67/bONGWQ4CkUjMtZgV63y90J0o9IKt83ek0agE73Rwcv
        +NkHFNgr7WhHpXx2yU+FJ64a3eCvn84FGE6rZgd2qA4EdRsBq/MQsFQqrNkiDQ==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1698847965; a=rsa-sha256;
        cv=none;
        b=mHnOT1a/AFY8HO0Iwt6DLFTpm+UQbmWY7CXdY/Z3K2Lj5ydQRyQ0T7WNEXdJp+fvoWWKwq
        srNUaFd2h2BpV8R8+V2ajPBzJhsBB86OU1kd4UokiIYS+/hd6vhhQ4deDkHf++VNj4X73I
        U4cxy6a+ywSdVEbvGptmgZ3mYwfuQ5U1R8uRk4JkUEjhzHzMOuHktUNZ+AHiFWZAqz7LBF
        DySjxbVf8aPCHJZ8rlgAKqDN1zjE4DeH2lQLsnmGWr1WXZE8DZMB1PlDWM2JAeWFGiaQYi
        cRToXZEViT+9PhJbUFAR+y/9xi8tVXvHML1tO2iOZss6Wa2yg3OTnXUaeq+wcA==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1698847965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=LCAC7W2hLqX/2frRNswQuSQy4/ePkwVSreq/kkvRoKs=;
        b=RcpQJUV/0kKNaCrafH5EbOfzOGJKU27JDEJjuXKmSMhG53xN0Iwr/fXC1DwnNc6Z4aCFT0
        LJZry7ovT65rqYjZZuVjCRYGfk8tRWsuYDniyKCgNWRUnA1q8igDZALaeo3E6n/lN5ECoX
        S9HhRLPGv7DMfkMv5l8r2Sqza5jFNAfPWN0uqrtqGfvPzVZRUcK7sBacU03XbFOYQlOtFi
        EBrsZ+QeZu4jnv31LlKdf7/dE6JvJJEPN/ruKKDBATdnwP37/e+F9sx6lOKd1LmgxDQp7O
        8PmY47fpwuPYqhTO1b3AGTy+FvRf5efpMt7atXJYytrfSARW5C/edCaM74chuQ==
From:   Paulo Alcantara <pc@manguebit.com>
To:     nspmangalore@gmail.com, smfrench@gmail.com,
        bharathsm.hsk@gmail.com, linux-cifs@vger.kernel.org
Cc:     Shyam Prasad N <sprasad@microsoft.com>
Subject: Re: [PATCH 13/14] cifs: display the endpoint IP details in DebugData
In-Reply-To: <notmuch-sha1-260ef7fe7af7face0e1486229c0fda5149fe14e2>
References: <20231030110020.45627-1-sprasad@microsoft.com>
 <20231030110020.45627-13-sprasad@microsoft.com>
Date:   Wed, 01 Nov 2023 11:12:41 -0300
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Paulo Alcantara <pc@manguebit.com> writes:

>> @@ -515,7 +573,18 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
>>  				seq_printf(m, "\n\n\tExtra Channels: %zu ",
>>  					   ses->chan_count-1);
>>  				for (j = 1; j < ses->chan_count; j++) {
>> +					/*
>> +					 * kernel_getsockname can block inside
>> +					 * cifs_dump_channel. so drop the lock first
>> +					 */
>> +					server->srv_count++;
>> +					spin_unlock(&cifs_tcp_ses_lock);
>> +
>>  					cifs_dump_channel(m, j, &ses->chans[j]);
>> +
>> +					cifs_put_tcp_session(server, 0);
>> +					spin_lock(&cifs_tcp_ses_lock);
>
> Here you are re-acquiring @cifs_tcp_ses_lock spinlock under
> @ses->chan_lock, which will introduce deadlocks in threads calling
> cifs_match_super(), cifs_signal_cifsd_for_reconnect(),
> cifs_mark_tcp_ses_conns_for_reconnect(), cifs_find_smb_ses(), ...

A simple reproducer

  $ mount.cifs //srv/share /mnt -o ...,multichannel
  $ cat /proc/fs/cifs/DebugData
  
  [ 1293.512572] BUG: sleeping function called from invalid context at net/core/sock.c:3507
  [ 1293.513915] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 1068, name: cat
  [ 1293.515381] preempt_count: 1, expected: 0
  [ 1293.516321] RCU nest depth: 0, expected: 0
  [ 1293.517294] 3 locks held by cat/1068:
  [ 1293.518165]  #0: ffff88800818fc48 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0x59/0x470
  [ 1293.519383]  #1: ffff88800aed2b28 (&ret_buf->chan_lock){+.+.}-{2:2}, at: cifs_debug_data_proc_show+0x555/0xee0 [cifs]
  [ 1293.520865]  #2: ffff888011c9a540 (sk_lock-AF_INET-CIFS){+.+.}-{0:0}, at: inet_getname+0x29/0xa0
  [ 1293.522098] CPU: 3 PID: 1068 Comm: cat Not tainted 6.6.0-rc7 #2
  [ 1293.522901] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
  [ 1293.524368] Call Trace:
  [ 1293.524711]  <TASK>
  [ 1293.525015]  dump_stack_lvl+0x64/0x80
  [ 1293.525519]  __might_resched+0x173/0x280
  [ 1293.526059]  lock_sock_nested+0x43/0x80
  [ 1293.526578]  ? inet_getname+0x29/0xa0
  [ 1293.527097]  inet_getname+0x29/0xa0
  [ 1293.527584]  cifs_debug_data_proc_show+0xcf9/0xee0 [cifs]
  [ 1293.528360]  seq_read_iter+0x118/0x470
  [ 1293.528877]  proc_reg_read_iter+0x53/0x90
  [ 1293.529419]  ? srso_alias_return_thunk+0x5/0x7f
  [ 1293.530037]  vfs_read+0x201/0x350
  [ 1293.530507]  ksys_read+0x75/0x100
  [ 1293.530968]  do_syscall_64+0x3f/0x90
  [ 1293.531461]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
  [ 1293.532138] RIP: 0033:0x7f71d767e381
  [ 1293.532630] Code: ff ff eb c3 e8 0e ea 01 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 90 90 80 3d a5 f6 0e 00 00 74 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 48 83 ec 28 48 89 54
  [ 1293.535095] RSP: 002b:00007ffc312d65a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
  [ 1293.536106] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f71d767e381
  [ 1293.537056] RDX: 0000000000020000 RSI: 00007f71d74f8000 RDI: 0000000000000003
  [ 1293.538003] RBP: 0000000000020000 R08: 00000000ffffffff R09: 0000000000000000
  [ 1293.538957] R10: 0000000000000022 R11: 0000000000000246 R12: 00007f71d74f8000
  [ 1293.539908] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000020000
  [ 1293.540877]  </TASK>
  [ 1293.541233] 
  [ 1293.541449] ======================================================
  [ 1293.542270] WARNING: possible circular locking dependency detected
  [ 1293.543098] 6.6.0-rc7 #2 Tainted: G        W         
  [ 1293.543782] ------------------------------------------------------
  [ 1293.544606] cat/1068 is trying to acquire lock:
  [ 1293.545214] ffffffffc015b5f8 (&cifs_tcp_ses_lock){+.+.}-{2:2}, at: cifs_put_tcp_session+0x1c/0x180 [cifs]
  [ 1293.546516] 
  [ 1293.546516] but task is already holding lock:
  [ 1293.547292] ffff88800aed2b28 (&ret_buf->chan_lock){+.+.}-{2:2}, at: cifs_debug_data_proc_show+0x555/0xee0 [cifs]
  [ 1293.548454] 
  [ 1293.548454] which lock already depends on the new lock.
  [ 1293.548454] 
  [ 1293.549350] 
  [ 1293.549350] the existing dependency chain (in reverse order) is:
  [ 1293.550183] 
  [ 1293.550183] -> #1 (&ret_buf->chan_lock){+.+.}-{2:2}:
  [ 1293.550899]        _raw_spin_lock+0x34/0x80
  [ 1293.551401]        cifs_debug_data_proc_show+0x555/0xee0 [cifs]
  [ 1293.552082]        seq_read_iter+0x118/0x470
  [ 1293.552556]        proc_reg_read_iter+0x53/0x90
  [ 1293.553054]        vfs_read+0x201/0x350
  [ 1293.553490]        ksys_read+0x75/0x100
  [ 1293.553925]        do_syscall_64+0x3f/0x90
  [ 1293.554389]        entry_SYSCALL_64_after_hwframe+0x6e/0xd8
  [ 1293.555004] 
  [ 1293.555004] -> #0 (&cifs_tcp_ses_lock){+.+.}-{2:2}:
  [ 1293.555709]        __lock_acquire+0x1521/0x2660
  [ 1293.556218]        lock_acquire+0xbf/0x2b0
  [ 1293.556680]        _raw_spin_lock+0x34/0x80
  [ 1293.557148]        cifs_put_tcp_session+0x1c/0x180 [cifs]
  [ 1293.557773]        cifs_debug_data_proc_show+0xd15/0xee0 [cifs]
  [ 1293.558463]        seq_read_iter+0x118/0x470
  [ 1293.558945]        proc_reg_read_iter+0x53/0x90
  [ 1293.559450]        vfs_read+0x201/0x350
  [ 1293.559882]        ksys_read+0x75/0x100
  [ 1293.560317]        do_syscall_64+0x3f/0x90
  [ 1293.560773]        entry_SYSCALL_64_after_hwframe+0x6e/0xd8
  [ 1293.561390] 
  [ 1293.561390] other info that might help us debug this:
  [ 1293.561390] 
  [ 1293.562267]  Possible unsafe locking scenario:
  [ 1293.562267] 
  [ 1293.562927]        CPU0                    CPU1
  [ 1293.563394]        ----                    ----
  [ 1293.563754]   lock(&ret_buf->chan_lock);
  [ 1293.564068]                                lock(&cifs_tcp_ses_lock);
  [ 1293.564573]                                lock(&ret_buf->chan_lock);
  [ 1293.565077]   lock(&cifs_tcp_ses_lock);
  [ 1293.565387] 
  [ 1293.565387]  *** DEADLOCK ***
  [ 1293.565387] 
  [ 1293.565852] 2 locks held by cat/1068:
  [ 1293.566147]  #0: ffff88800818fc48 (&p->lock){+.+.}-{3:3}, at: seq_read_iter+0x59/0x470
  [ 1293.566767]  #1: ffff88800aed2b28 (&ret_buf->chan_lock){+.+.}-{2:2}, at: cifs_debug_data_proc_show+0x555/0xee0 [cifs]
  [ 1293.567611] 
  [ 1293.567611] stack backtrace:
  [ 1293.567954] CPU: 3 PID: 1068 Comm: cat Tainted: G        W          6.6.0-rc7 #2
  [ 1293.568536] Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
  [ 1293.569387] Call Trace:
  [ 1293.569585]  <TASK>
  [ 1293.569755]  dump_stack_lvl+0x4a/0x80
  [ 1293.570047]  check_noncircular+0x14e/0x170
  [ 1293.570373]  ? save_trace+0x3e/0x390
  [ 1293.570659]  __lock_acquire+0x1521/0x2660
  [ 1293.570982]  lock_acquire+0xbf/0x2b0
  [ 1293.571268]  ? cifs_put_tcp_session+0x1c/0x180 [cifs]
  [ 1293.571687]  _raw_spin_lock+0x34/0x80
  [ 1293.571977]  ? cifs_put_tcp_session+0x1c/0x180 [cifs]
  [ 1293.572394]  cifs_put_tcp_session+0x1c/0x180 [cifs]
  [ 1293.572795]  cifs_debug_data_proc_show+0xd15/0xee0 [cifs]
  [ 1293.573241]  seq_read_iter+0x118/0x470
  [ 1293.573546]  proc_reg_read_iter+0x53/0x90
  [ 1293.573861]  ? srso_alias_return_thunk+0x5/0x7f
  [ 1293.574218]  vfs_read+0x201/0x350
  [ 1293.574489]  ksys_read+0x75/0x100
  [ 1293.574752]  do_syscall_64+0x3f/0x90
  [ 1293.575030]  entry_SYSCALL_64_after_hwframe+0x6e/0xd8
  [ 1293.575428] RIP: 0033:0x7f71d767e381
  [ 1293.575716] Code: ff ff eb c3 e8 0e ea 01 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 90 90 80 3d a5 f6 0e 00 00 74 13 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 57 c3 66 0f 1f 44 00 00 48 83 ec 28 48 89 54
  [ 1293.577151] RSP: 002b:00007ffc312d65a8 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
  [ 1293.577736] RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f71d767e381
  [ 1293.578286] RDX: 0000000000020000 RSI: 00007f71d74f8000 RDI: 0000000000000003
  [ 1293.578839] RBP: 0000000000020000 R08: 00000000ffffffff R09: 0000000000000000
  [ 1293.579391] R10: 0000000000000022 R11: 0000000000000246 R12: 00007f71d74f8000
  [ 1293.579951] R13: 0000000000000003 R14: 0000000000000000 R15: 0000000000020000
  [ 1293.580511]  </TASK>
