Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C22C24DC760
	for <lists+linux-cifs@lfdr.de>; Thu, 17 Mar 2022 14:15:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230165AbiCQNQq (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 17 Mar 2022 09:16:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231713AbiCQNQo (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 17 Mar 2022 09:16:44 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42965199E05
        for <linux-cifs@vger.kernel.org>; Thu, 17 Mar 2022 06:15:27 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-2e59939b862so57382987b3.10
        for <linux-cifs@vger.kernel.org>; Thu, 17 Mar 2022 06:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Y2zF9pHyzGC4XM+SX9EmYR2p8EUyNxzz18T1H5GibRs=;
        b=WY38F+RJMHBd9m40dKt7pJI29fo/1b3CkqXM4GgrbscXODp/BaJ5dZAdcRdFGyei4L
         XsUWdZMOtMO61rTmKIDTdRgS8VRVBUDd1V6ARhTE5OldqYQbCV282UJ6kvjJn03cj/Jm
         3VjriLJ0J0XrJXQxrV+3KcyD5j6LqttlLpu4oceEzX8MA7yQb/gCpZkEgSrYI/EvQ5B0
         bD3gzcKLEFG2H68ymYgVjhDmML4wQd+H5Q8kFQ5+derExerH/G66fAEZ68KM23jhK9ja
         1ZQkTRflvrHkzGOwNZr714Z0RSRre6DsHfeHfPGhlGd5/Hs/CsYlLPbKRPLMdfn84CzL
         zbAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Y2zF9pHyzGC4XM+SX9EmYR2p8EUyNxzz18T1H5GibRs=;
        b=os3weFg4EWL/iGWpmyIyvsHMvuM4dqMH+kEYtA2/xrsqvxK1B4DVoiue+/yxFV5RVl
         vAyH1MtxtmVhTh0lsuSU57ziODHijj18zYPnOBT15t+QlvjuLSAdI4vBLxN4yfJyWudY
         Y8Bo2Le4Fqe+KsTYR19/o3193t+1jz2gINLeRWxKWVI3SSqmEqYOEepmMYb7/BAe0Q7g
         lzRcyIZyAGor6ZsJcDKcpyRyuXi9L4pAdo8XrIH6BPH19SbGH18eIbX6Dis9ciuAOOZB
         OoXuq8gubtq2mnJ4xAM1zb3tnXE4yIlNAdB+nbAbWdBIM3CjrTcQQHBU770pWlHUzE0h
         Go1Q==
X-Gm-Message-State: AOAM530q/cAn7amOu2Ub3QKQS4uqhQzn8NsB+HPlh077JYLUb+hiWTLH
        WjotbvEkdcAt/vKRpVY+UcZu//6q+xUILXOTyZ0vXulj
X-Google-Smtp-Source: ABdhPJxddA8GJLptoVdEoE6rbWOV5I7AQdcMXpZ5nFF1xhwNAdghGzdf4TL6BlF2+v1o9HewBzBEMag5xN9sT7/tTJY=
X-Received: by 2002:a81:3ad3:0:b0:2db:49b2:5795 with SMTP id
 h202-20020a813ad3000000b002db49b25795mr5560490ywa.424.1647522926382; Thu, 17
 Mar 2022 06:15:26 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mvrgzqncUVhDC1bwn8fkrJt7RFs+gTvgByGsDpwfr9eOg@mail.gmail.com>
 <CAFrh3J_jDg=2-6j6hpfae_i9f57YVE99tHNK7nE0sxfiHXO+JQ@mail.gmail.com>
 <CANT5p=pkepEPWAYfWSF8VKM0_nM4iAf4AOPYRqYraKyFWrhc5w@mail.gmail.com> <CAFrh3J_0ROfaHf-C4R8Jo-iSRGArKVXE4oFjezEp_MQs9k4XRg@mail.gmail.com>
In-Reply-To: <CAFrh3J_0ROfaHf-C4R8Jo-iSRGArKVXE4oFjezEp_MQs9k4XRg@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Thu, 17 Mar 2022 23:15:14 +1000
Message-ID: <CAN05THROpPTY0oBbGZyBypc9dYiBUHpO+5M+U41=v41_v_3JuA@mail.gmail.com>
Subject: Re: multiuser mount option regression
To:     Satadru Pramanik <satadru@gmail.com>
Cc:     Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Thu, Mar 17, 2022 at 11:04 PM Satadru Pramanik <satadru@gmail.com> wrote:
>
> I have one of those set already:
>
> grep "UBSAN\|KASAN" /boot/config-5.17.0-051700rc8-generic
> CONFIG_ARCH_HAS_UBSAN_SANITIZE_ALL=y
> CONFIG_UBSAN=y
> # CONFIG_UBSAN_TRAP is not set
> CONFIG_CC_HAS_UBSAN_BOUNDS=y
> CONFIG_UBSAN_BOUNDS=y
> CONFIG_UBSAN_ONLY_BOUNDS=y
> CONFIG_UBSAN_SHIFT=y
> # CONFIG_UBSAN_DIV_ZERO is not set
> CONFIG_UBSAN_BOOL=y
> CONFIG_UBSAN_ENUM=y
> # CONFIG_UBSAN_ALIGNMENT is not set
> CONFIG_UBSAN_SANITIZE_ALL=y
> # CONFIG_TEST_UBSAN is not set
> CONFIG_HAVE_ARCH_KASAN=y
> CONFIG_HAVE_ARCH_KASAN_VMALLOC=y
> CONFIG_CC_HAS_KASAN_GENERIC=y
> # CONFIG_KASAN is not set
>
>
> What is weird is that this issue is only arising after suspending for
> several hours now.  I can shut my screen, and come back in a few
> minutes and reopen the screen and watch the machine come out of
> suspend now, and the mount still work.

Can you try to suspend, then reboot the server, then resume and see if
that makes any difference?
And if it reproduces the issue without having to wait several hours?
I want to rule out if "some setting might make tcp sessions take
several hours to time out".


>
> I come back after several hours after closing the screen, and that's
> when the mount is broken.
>
> I think that shows up in the following dmesg. The first several lines
> are from waking up this morning after the machine has been asleep for
> many hours. Then I manually unmount an remount the cifs mount, and
> then sleep/resume work.
> Is there a deeper sleep state after several hours which is able to trigger this?
>
> [ 3130.975013] CIFS: VFS: cifs_tree_connect: could not find superblock: -22
> [ 3132.991105] CIFS: VFS: cifs_tree_connect: could not find superblock: -22
> [ 3135.007102] CIFS: VFS: cifs_tree_connect: could not find superblock: -22
> [ 3136.296846] CIFS: VFS: cifs_tree_connect: could not find superblock: -22
> [ 3139.363995] CIFS: Attempting to mount \\cheekon\localnet
> [ 3397.489607] PM: suspend entry (deep)
> [ 3400.856311] Filesystems sync: 3.366 seconds
> [ 3400.856559] Freezing user space processes ... (elapsed 0.002 seconds) done.
> [ 3400.858844] OOM killer disabled.
> [ 3400.858845] Freezing remaining freezable tasks ... (elapsed 0.325
> seconds) done.
> [ 3401.184895] printk: Suspending console(s) (use no_console_suspend to debug)
> [ 3401.707091] ACPI: EC: interrupt blocked
> [ 3402.658748] ACPI: PM: Preparing to enter system sleep state S3
> [ 3402.659592] ACPI: EC: event blocked
> [ 3402.659593] ACPI: EC: EC stopped
> [ 3402.659594] ACPI: PM: Saving platform NVS memory
> [ 3402.659622] Disabling non-boot CPUs ...
> [ 3402.661485] smpboot: CPU 1 is now offline
> [ 3402.671576] smpboot: CPU 2 is now offline
> [ 3402.689819] smpboot: CPU 3 is now offline
> [ 3402.700758] smpboot: CPU 4 is now offline
> [ 3402.703343] smpboot: CPU 5 is now offline
> [ 3402.705884] smpboot: CPU 6 is now offline
> [ 3402.708564] smpboot: CPU 7 is now offline
> [ 3402.710867] ACPI: PM: Low-level resume complete
> [ 3402.710901] ACPI: EC: EC started
> [ 3402.710903] ACPI: PM: Restoring platform NVS memory
> [ 3402.711337] Enabling non-boot CPUs ...
> [ 3402.711422] x86: Booting SMP configuration:
> [ 3402.711424] smpboot: Booting Node 0 Processor 1 APIC 0x2
> [ 3403.034812] CPU1 is up
> [ 3403.046711] smpboot: Booting Node 0 Processor 2 APIC 0x4
> [ 3403.402877] CPU2 is up
> [ 3403.414254] smpboot: Booting Node 0 Processor 3 APIC 0x6
> [ 3403.770377] CPU3 is up
> [ 3403.780699] smpboot: Booting Node 0 Processor 4 APIC 0x1
> [ 3403.795814] CPU4 is up
> [ 3403.795848] smpboot: Booting Node 0 Processor 5 APIC 0x3
> [ 3404.207469] CPU5 is up
> [ 3404.216103] smpboot: Booting Node 0 Processor 6 APIC 0x5
> [ 3404.735629] CPU6 is up
> [ 3404.744063] smpboot: Booting Node 0 Processor 7 APIC 0x7
> [ 3405.351922] CPU7 is up
> [ 3405.358923] ACPI: PM: Waking up from system sleep state S3
> [ 3405.360630] ACPI: EC: interrupt unblocked
> [ 3405.360798] pcieport 0000:00:1c.0: Enabling MPC IRBNCE
> [ 3405.360802] pcieport 0000:00:1c.0: Intel PCH root port ACS workaround enabled
> [ 3405.361022] pcieport 0000:00:1c.2: Enabling MPC IRBNCE
> [ 3405.361025] pcieport 0000:00:1c.2: Intel PCH root port ACS workaround enabled
> [ 3405.380367] pcieport 0000:00:1c.3: Enabling MPC IRBNCE
> [ 3405.380371] pcieport 0000:00:1c.3: Intel PCH root port ACS workaround enabled
> [ 3405.440455] pcieport 0000:00:1c.4: Enabling MPC IRBNCE
> [ 3405.440459] pcieport 0000:00:1c.4: Intel PCH root port ACS workaround enabled
> [ 3405.464845] ACPI: EC: event unblocked
> [ 3405.466699] pcieport 0000:00:1c.0: pciehp: Slot(0): Card present
> [ 3405.742733] nouveau 0000:01:00.0: devinit: 0x000066e5[0]: script
> needs OR link
> [ 3406.016118] nvme nvme0: 8/0/0 default/read/poll queues
> [ 3406.117380] OOM killer enabled.
> [ 3406.117382] Restarting tasks ... done.
> [ 3406.147389] DMAR: DRHD: handling fault status reg 2
> [ 3406.147408] DMAR: [DMA Write NO_PASID] Request device [00:02.0]
> fault addr 0xfed69000 [fault reason 0x05] PTE Write access is not set
> [ 3406.202211] DMAR: DRHD: handling fault status reg 2
> [ 3406.202219] DMAR: [DMA Write NO_PASID] Request device [00:02.0]
> fault addr 0x3dffc000 [fault reason 0x05] PTE Write access is not set
> [ 3407.536312] pcieport 0000:00:1c.0: pciehp: Slot(0): No link
> [ 3408.144356] PM: suspend exit
> [ 3412.177126] IPv6: ADDRCONF(NETDEV_CHANGE): wlp3s0: link becomes ready
>
> On Thu, Mar 17, 2022 at 8:50 AM Shyam Prasad N <nspmangalore@gmail.com> wrote:
> >
> > On Thu, Mar 17, 2022 at 11:53 AM Satadru Pramanik <satadru@gmail.com> wrote:
> > >
> > > I am testing Ronnie's patch from earlier today now, and will see if
> > > the mount has broken later this morning, as I'm putting the machine to
> > > sleep now.
> > >
> > > I tried just reverting 73f9bfbe3d818bb52266d5c9f3ba57d97842ffe7 in
> > > 5.17-rc8, but it broke cifs mounting entirely with the error I
> > > mentioned earlier today:
> > >
> > > [  242.560881] INFO: task mount.smb3:3219 blocked for more than 120 seconds.
> > > [  242.560901]       Tainted: P           OE
> > > 5.17.0-051700rc8-generic #202203132130
> > > [  242.560904] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs"
> > > disables this message.
> > > [  242.560907] task:mount.smb3      state:D stack:    0 pid: 3219
> > > ppid:     1 flags:0x00004006
> > > [  242.560914] Call Trace:
> > > [  242.560918]  <TASK>
> > > [  242.560927]  __schedule+0x240/0x5a0
> > > [  242.560939]  schedule+0x55/0xd0
> > > [  242.560941]  schedule_preempt_disabled+0x15/0x20
> > > [  242.560944]  __mutex_lock.constprop.0+0x2e0/0x4b0
> > > [  242.560949]  __mutex_lock_slowpath+0x13/0x20
> > > [  242.560953]  mutex_lock+0x34/0x40
> > > [  242.560958]  cifs_get_smb_ses+0x367/0xab0 [cifs]
> > > [  242.561108]  ? __queue_delayed_work+0x5c/0x90
> > > [  242.561120]  mount_get_conns+0x63/0x430 [cifs]
> > > [  242.561182]  cifs_mount+0x86/0x420 [cifs]
> > > [  242.561222]  cifs_smb3_do_mount+0x10d/0x320 [cifs]
> > > [  242.561252]  ? cifs_smb3_do_mount+0x10d/0x320 [cifs]
> > > [  242.561283]  ? vfs_parse_fs_string+0x7f/0xb0
> > > [  242.561290]  smb3_get_tree+0x3e/0x70 [cifs]
> > > [  242.561337]  vfs_get_tree+0x27/0xc0
> > > [  242.561343]  do_new_mount+0x14b/0x1a0
> > > [  242.561348]  path_mount+0x1d4/0x530
> > > [  242.561350]  ? putname+0x55/0x60
> > > [  242.561357]  __x64_sys_mount+0x108/0x140
> > > [  242.561360]  do_syscall_64+0x59/0xc0
> > > [  242.561368]  ? do_syscall_64+0x69/0xc0
> > > [  242.561372]  ? handle_mm_fault+0xba/0x290
> > > [  242.561376]  ? do_user_addr_fault+0x1dd/0x670
> > > [  242.561382]  ? syscall_exit_to_user_mode+0x27/0x50
> > > [  242.561385]  ? exit_to_user_mode_prepare+0x37/0xb0
> > > [  242.561392]  ? irqentry_exit_to_user_mode+0x9/0x20
> > > [  242.561394]  ? irqentry_exit+0x33/0x40
> > > [  242.561397]  ? exc_page_fault+0x89/0x180
> > > [  242.561399]  ? asm_exc_page_fault+0x8/0x30
> > > [  242.561405]  entry_SYSCALL_64_after_hwframe+0x44/0xae
> > > [  242.561409] RIP: 0033:0x7f42af11ceae
> > > [  242.561414] RSP: 002b:00007fff6af66c48 EFLAGS: 00000206 ORIG_RAX:
> > > 00000000000000a5
> > > [  242.561418] RAX: ffffffffffffffda RBX: 000055dcbe40beb0 RCX: 00007f42af11ceae
> > > [  242.561420] RDX: 000055dcbe1a447e RSI: 000055dcbe1a44da RDI: 00007fff6af67ea6
> > > [  242.561421] RBP: 0000000000000000 R08: 000055dcbe40beb0 R09: 000055dcbe40cf40
> > > [  242.561423] R10: 0000000000000000 R11: 0000000000000206 R12: 00007fff6af67e9b
> > > [  242.561424] R13: 00007f42af237000 R14: 00007f42af23990f R15: 000055dcbe40cf40
> > > [  242.561427]  </TASK>
> > >
> > >
> > >
> > >
> > >
> > > On Thu, Mar 17, 2022 at 2:03 AM Steve French <smfrench@gmail.com> wrote:
> > > >
> > > > I narrowed the regression for multiuser mounts down (which Ronnie had
> > > > mentioned) to this patch (one of the first applied to 5.17 merge
> > > > window for cifs.ko).   I am curious whether this is also related to
> > > > the hard to reproduce reconnect issue that the regression tracker was
> > > > monitoring
> > > >
> > > > commit 73f9bfbe3d818bb52266d5c9f3ba57d97842ffe7 (HEAD -> tmp)
> > > > Author: Shyam Prasad N <sprasad@microsoft.com>
> > > > Date:   Mon Jul 19 17:37:52 2021 +0000
> > > >
> > > >     cifs: maintain a state machine for tcp/smb/tcon sessions
> > > >
> > > >     If functions like cifs_negotiate_protocol, cifs_setup_session,
> > > >     cifs_tree_connect are called in parallel on different channels,
> > > >     each of these will be execute the requests. This maybe unnecessary
> > > >     in some cases, and only the first caller may need to do the work.
> > > >
> > > >     This is achieved by having more states for the tcp/smb/tcon session
> > > >     status fields. And tracking the state of reconnection based on the
> > > >     state machine.
> > > >
> > > >     For example:
> > > >     for tcp connections:
> > > >     CifsNew/CifsNeedReconnect ->
> > > >       CifsNeedNegotiate ->
> > > >         CifsInNegotiate ->
> > > >           CifsNeedSessSetup ->
> > > >             CifsInSessSetup ->
> > > >               CifsGood
> > > >
> > > >     for smb sessions:
> > > >     CifsNew/CifsNeedReconnect ->
> > > >       CifsGood
> > > >
> > > >      CifsNew/CifsNeedReconnect ->
> > > >       CifsInFilesInvalidate ->
> > > >         CifsNeedTcon ->
> > > >           CifsInTcon ->
> > > >             CifsGood
> > > >
> > > >     If any channel reconnect sees that it's in the middle of
> > > >     transition to CifsGood, then they can skip the function.
> > > >
> > > >
> > > >
> > > > --
> > > > Thanks,
> > > >
> > > > Steve
> >
> > Hi Satadru,
> >
> > If you are able to build the kernel yourself, can you try building
> > with a couple of these extra config options?
> > CONFIG_KASAN=y
> > CONFIG_UBSAN=y
> >
> > I tried these two tests a few times on my VM:
> > 1. suspend/resume of the VM while share is mounted
> > 2. restart smbd when share is mounted.
> >
> > In both cases, I'm unable to repro this.
> > The above config options may slow down your system, since it enables
> > memory sanitization. You may use this customized kernel just for the
> > repro.
> >
> > --
> > Regards,
> > Shyam
