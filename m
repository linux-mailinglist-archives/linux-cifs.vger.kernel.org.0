Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E1835D11E
	for <lists+linux-cifs@lfdr.de>; Mon, 12 Apr 2021 21:36:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237410AbhDLTgN (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 12 Apr 2021 15:36:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236717AbhDLTgM (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 12 Apr 2021 15:36:12 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F57CC061574
        for <linux-cifs@vger.kernel.org>; Mon, 12 Apr 2021 12:35:54 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id b26so4711319pfr.3
        for <linux-cifs@vger.kernel.org>; Mon, 12 Apr 2021 12:35:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VnJ6hE/9ejor75E+9VyTxz6IOuWJqVTi5dRKFYuua9k=;
        b=tiGnaErtrwep6yut8WJJo43Ha91jgnreD1eBpg8LiYOIdTOJvHMbga8U5wpnhbAcEW
         c6zEpeD9hvlvQe+UWvXdc/Yn3lWSz4WNzdkUskJ5GON19V3yOBGhE9t0jOi4pFjNLVWS
         2MiFiHIvrJwzJb95zNcFdKDFnU9PabHUkbQxJYG2UfPSD8EVQEd6rDhTjAzA3rQyFEqj
         9x4JHdHsxbu7hg5kvYsFhqaEaQH1AqPsHuj/pO0oOrMCck2vjsK7cJsdE6Ki9OcYHvhk
         BQpI6p8GVAbvTQ3m4NZ6uklDSLHUSULuTwLu/7xfOQegk/Qt/H++yT87pVEIUmTsrfB9
         8YrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VnJ6hE/9ejor75E+9VyTxz6IOuWJqVTi5dRKFYuua9k=;
        b=Pd23Aqz453nzI3NVRvjoqnsCdoYIpu9D8km+GUC9KIOAl+doJ161st7WcSzONTtc0l
         cnmb4YleXGjfbVPQ5bKAfT505htOZWqOuoKNaJ9pJgEEHNiH8NZ82d/3QO5zEO5Pvdm3
         lpl/yMfzdaZLCzi/UCpvKDazBzPDTAKWo1/hHIqGg3n8N4XvBFRwtEKCZJU9tnfPKcTb
         oxP99dPCWN5yFN2BwO8ocOuMmITFAviAPPIq3NUrkEPSMHxZAvOcg02TiSDoWHIc9MmN
         tewq+ljawUPubyEXFQ45wKLcAUSMJzfjFb0CPJwCKAuwuiu6D3o3VGoaNjLK+5Px2SvN
         fcjA==
X-Gm-Message-State: AOAM532NB6d86LT4bYc7zFRNg791+2qJ2aua51oUzEMVspCq8cIapgAU
        4WhNF9qa/yhuFazSCrv+pPBxlQfAtPUxlAjU4QM=
X-Google-Smtp-Source: ABdhPJwJ7hFL+3toDir+Aa76Sw1ki+X2uq9bqH69a7ug7t8fLC7en3egpDrysf15fTSysJZeTXCsQI2zr92Q0nJcDx4=
X-Received: by 2002:a65:40c7:: with SMTP id u7mr28468282pgp.29.1618256153868;
 Mon, 12 Apr 2021 12:35:53 -0700 (PDT)
MIME-Version: 1.0
References: <CACdtm0Y1NeC0jNTOtjhTtGRt0sfyhyxC=wNfMu1eqibe6qJbwA@mail.gmail.com>
 <CAH2r5mviSVQXO6BK42NDer14DKKopP4oCTD4WuiiridB7Q2Hwg@mail.gmail.com> <CAH2r5muxLnkE3qT0dsn7A_ZDMeBW8cXsHV3mCePTFjeVBJ26Vw@mail.gmail.com>
In-Reply-To: <CAH2r5muxLnkE3qT0dsn7A_ZDMeBW8cXsHV3mCePTFjeVBJ26Vw@mail.gmail.com>
From:   Rohith Surabattula <rohiths.msft@gmail.com>
Date:   Tue, 13 Apr 2021 01:05:43 +0530
Message-ID: <CACdtm0baDOoM62qW9DxVEMXA-XS5iQcB5W55Sz5jx6oWj80oWQ@mail.gmail.com>
Subject: Re: cifs: Deferred close for files
To:     Steve French <smfrench@gmail.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>,
        Pavel Shilovsky <piastryyy@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        sribhat.msa@outlook.com,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi Steve,

I didn't observe when I ran locally against Azure.
Let me try to reproduce.

Regards,
Rohith

On Mon, Apr 12, 2021 at 10:54 PM Steve French <smfrench@gmail.com> wrote:
>
> I was running to Samba server as the target
>
> On Mon, Apr 12, 2021 at 12:23 PM Steve French <smfrench@gmail.com> wrote:
> >
> > I saw some problems in dmesg ( when running test generic/005) multiple
> > similar errors.  Anyone else see them?
> >
> > Rohith,
> > Can you repro that?
> >
> > [171877.491187] run fstests generic/005 at 2021-04-12 12:20:57
> > [171878.245576] ------------[ cut here ]------------
> > [171878.245578] WARNING: CPU: 5 PID: 546266 at
> > arch/x86/include/asm/kfence.h:44 kfence_protect_page+0x33/0xa0
> > [171878.245583] Modules linked in: cifs(OE) md4 rfcomm nls_utf8 libdes
> > ccm cachefiles fscache nf_tables nfnetlink cmac algif_hash
> > algif_skcipher af_alg bnep nls_iso8859_1 mei_hdcp intel_rapl_msr
> > x86_pkg_temp_thermal intel_powerclamp snd_sof_pci_intel_cnl
> > snd_sof_intel_hda_common coretemp snd_soc_hdac_hda soundwire_intel
> > soundwire_generic_allocation soundwire_cadence snd_sof_intel_hda
> > kvm_intel snd_sof_pci nouveau snd_sof iwlmvm kvm snd_sof_xtensa_dsp
> > snd_hda_ext_core snd_soc_acpi_intel_match mac80211 snd_soc_acpi
> > crct10dif_pclmul soundwire_bus ghash_clmulni_intel aesni_intel
> > snd_hda_codec_realtek snd_soc_core mxm_wmi snd_hda_codec_generic
> > drm_ttm_helper crypto_simd ttm cryptd snd_compress snd_hda_codec_hdmi
> > libarc4 ac97_bus drm_kms_helper snd_pcm_dmaengine rapl btusb cec
> > intel_cstate snd_hda_intel uvcvideo btrtl rc_core btbcm
> > videobuf2_vmalloc btintel videobuf2_memops iwlwifi snd_intel_dspcfg
> > videobuf2_v4l2 fb_sys_fops snd_intel_sdw_acpi thinkpad_acpi serio_raw
> > videobuf2_common syscopyarea
> > [171878.245630]  bluetooth snd_hda_codec processor_thermal_device
> > efi_pstore videodev processor_thermal_rfim sysfillrect
> > processor_thermal_mbox snd_seq_midi processor_thermal_rapl sysimgblt
> > snd_hda_core ecdh_generic snd_seq_midi_event snd_hwdep nvidiafb
> > ucsi_acpi nvram intel_rapl_common input_leds mc ecc mei_me
> > platform_profile intel_wmi_thunderbolt vgastate typec_ucsi wmi_bmof
> > elan_i2c ee1004 ledtrig_audio cfg80211 8250_dw fb_ddc joydev snd_pcm
> > mei i2c_algo_bit intel_soc_dts_iosf intel_pch_thermal snd_rawmidi
> > typec snd_seq snd_seq_device snd_timer snd soundcore int3403_thermal
> > int340x_thermal_zone int3400_thermal acpi_thermal_rel acpi_pad mac_hid
> > sch_fq_codel parport_pc ppdev lp parport drm sunrpc ip_tables x_tables
> > autofs4 wacom hid_generic usbhid hid xfs btrfs blake2b_generic xor
> > raid6_pq libcrc32c rtsx_pci_sdmmc crc32_pclmul nvme psmouse e1000e
> > i2c_i801 intel_lpss_pci i2c_smbus rtsx_pci nvme_core intel_lpss
> > xhci_pci idma64 xhci_pci_renesas wmi video pinctrl_cannonlake
> > [171878.245679]  [last unloaded: cifs]
> > [171878.245680] CPU: 5 PID: 546266 Comm: kworker/5:1 Tainted: G
> > W  OE     5.12.0-051200rc6-generic #202104042231
> > [171878.245682] Hardware name: LENOVO 20MAS08500/20MAS08500, BIOS
> > N2CET54W (1.37 ) 06/20/2020
> > [171878.245684] Workqueue: cifsoplockd cifs_oplock_break [cifs]
> > [171878.245720] RIP: 0010:kfence_protect_page+0x33/0xa0
> > [171878.245724] Code: 53 89 f3 48 8d 75 e4 48 83 ec 10 65 48 8b 04 25
> > 28 00 00 00 48 89 45 e8 31 c0 e8 d8 f4 d9 ff 48 85 c0 74 06 83 7d e4
> > 01 74 06 <0f> 0b 31 c0 eb 39 48 8b 38 48 89 c2 84 db 75 47 48 89 f8 0f
> > 1f 40
> > [171878.245726] RSP: 0018:ffffa33b84d47c20 EFLAGS: 00010046
> > [171878.245727] RAX: 0000000000000000 RBX: 0000000000000000 RCX:
> > ffffa33b84d47c24
> > [171878.245729] RDX: ffffa33b84d47c24 RSI: 0000000000000000 RDI:
> > 0000000000000000
> > [171878.245730] RBP: ffffa33b84d47c40 R08: 0000000000000000 R09:
> > 0000000000000000
> > [171878.245731] R10: 0000000000000000 R11: 0000000000000000 R12:
> > 0000000000000000
> > [171878.245732] R13: ffffa33b84d47d68 R14: ffffa33b84d47d68 R15:
> > 0000000000000000
> > [171878.245734] FS:  0000000000000000(0000) GS:ffff8da17bb40000(0000)
> > knlGS:0000000000000000
> > [171878.245736] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> > [171878.245737] CR2: 0000000000000268 CR3: 0000000484e10003 CR4:
> > 00000000003706e0
> > [171878.245739] DR0: 0000000000000000 DR1: 0000000000000000 DR2:
> > 0000000000000000
> > [171878.245740] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7:
> > 0000000000000400
> > [171878.245741] Call Trace:
> > [171878.245744]  kfence_unprotect+0x17/0x30
> > [171878.245746]  kfence_handle_page_fault+0x97/0x250
> > [171878.245748]  page_fault_oops+0x88/0x130
> > [171878.245751]  do_user_addr_fault+0x323/0x670
> > [171878.245754]  ? cifsFileInfo_put_final+0x10a/0x120 [cifs]
> > [171878.245784]  exc_page_fault+0x6c/0x150
> > [171878.245808]  asm_exc_page_fault+0x1e/0x30
> > [171878.245811] RIP: 0010:_raw_spin_lock+0xc/0x30
> > [171878.245814] Code: ba 01 00 00 00 f0 0f b1 17 75 01 c3 55 89 c6 48
> > 89 e5 e8 d7 42 4b ff 66 90 5d c3 0f 1f 00 0f 1f 44 00 00 31 c0 ba 01
> > 00 00 00 <f0> 0f b1 17 75 01 c3 55 89 c6 48 89 e5 e8 b2 42 4b ff 66 90
> > 5d c3
> > [171878.245830] RSP: 0018:ffffa33b84d47e10 EFLAGS: 00010246
> > [171878.245831] RAX: 0000000000000000 RBX: ffff8d9a0994d510 RCX:
> > 000000008020001e
> > [171878.245832] RDX: 0000000000000001 RSI: 000000008020001e RDI:
> > 0000000000000268
> > [171878.245833] RBP: ffffa33b84d47e70 R08: 0000000000000001 R09:
> > 0000000000000001
> > [171878.245834] R10: ffffffffaec73500 R11: 0000000000000000 R12:
> > 0000000000000000
> > [171878.245835] R13: ffff8d9a0994d400 R14: ffff8d9f9e1f9c20 R15:
> > ffff8d9a092b1800
> > [171878.245838]  ? cifs_oplock_break+0x1e9/0x5d0 [cifs]
> > [171878.245871]  process_one_work+0x220/0x3c0
> > [171878.245874]  worker_thread+0x50/0x370
> > [171878.245876]  kthread+0x12f/0x150
> > [171878.245878]  ? process_one_work+0x3c0/0x3c0
> > [171878.245880]  ? __kthread_bind_mask+0x70/0x70
> > [171878.245882]  ret_from_fork+0x22/0x30
> > [171878.245887] ---[ end trace fefd5c5bed217748 ]---
> > [171878.245892] ------------[ cut here ]------------
> >
> > On Tue, Mar 9, 2021 at 3:11 AM Rohith Surabattula
> > <rohiths.msft@gmail.com> wrote:
> > >
> > > Hi All,
> > >
> > > Please find the attached patch which will defer the close to server.
> > > So, performance can be improved.
> > >
> > > i.e When file is open, write, close, open, read, close....
> > > As close is deferred and oplock is held, cache will not be invalidated
> > > and same handle can be used for second open.
> > >
> > > Please review the changes and let me know your thoughts.
> > >
> > > Regards,
> > > Rohith
> >
> >
> >
> > --
> > Thanks,
> >
> > Steve
>
>
>
> --
> Thanks,
>
> Steve
