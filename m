Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 821D53819E4
	for <lists+linux-cifs@lfdr.de>; Sat, 15 May 2021 18:33:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbhEOQfE (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 15 May 2021 12:35:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbhEOQfD (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 15 May 2021 12:35:03 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92885C061573
        for <linux-cifs@vger.kernel.org>; Sat, 15 May 2021 09:33:50 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id m11so2699542lfg.3
        for <linux-cifs@vger.kernel.org>; Sat, 15 May 2021 09:33:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=0uqeXGgZRbELtDUly7ywqw/DuauL79TLv5tEWecrYeM=;
        b=n4iI3lrYMj92ESPdrkEcaKS5rg8tou0w1BzsbajtNviDm8hSY6tO0/5zr8dHzZXrp9
         WEZa1gfwzSmfb4yWfrslkRCQPbYzhnA1YUjtvpr673ad3EIveQDdgVas/FGgUHmtOpnz
         mpMb+8sDYa2dcR9+UTZ8Bux46wFA6qmk14RNf/DL9mUSnRETNjB32nHnk/HeaxBmerpG
         IEtz0dOsTiQ1cZNjO+WYS7XJwIttbxKlAtXBtNZsVQIwlPKcPb4pnn1/gubB//WqYFvC
         p0nLhR6TBSx3jAmZhehO8sy2VwX0uCj0bJMsE/BrOP9OxWyorefoYtjjNhMLiVOI9cQ1
         qcCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=0uqeXGgZRbELtDUly7ywqw/DuauL79TLv5tEWecrYeM=;
        b=rew5Q7kRKlAoteTp4BM7KlEVxr5IWipUZTYp8gQtpO9tDXf2pBGtkku6gMkkRDUMmG
         xw9pGFMXvgjWpqVrLYjnQ9T6HWi726ip2Vg/pEIis1NFAoARVUwrc+CWh+BvzysEuKvW
         RTvRS3FGI1Y1mpz7zl+hQO5VZtHwmvCOydG2Dd4fnXfDnikx3IX7zhJsUhEFjOa6ZUXS
         7pAaHlwQWlF9gpruIV7Q4NCEtJfL21/+QScOsoCjlcKkSsvNXQLs+wtfaaY3Mlljfsc6
         cfXZ34cZT16qgzPFsELXkmUsGJaXpKwCgiziyxuzCR021glXcHstaoDaBjB5c5EvxCEq
         0bdw==
X-Gm-Message-State: AOAM530eC5qMwYyJpViKmpLwSamC4TJ0zpQgKb7rmqq6VZj8ij5XLPTq
        1Y5l6qPN0P8s9DlFOZeyIWcZdNYYXZLXXYXyqSX6Rt30d04o1A==
X-Google-Smtp-Source: ABdhPJxEPSErEfe1kBWbcz0I6OIg+Uws3teAI2yj/pYowzX3I+OH1CKhpeYohH+Tv0kPARyOVLYSGPa7BVIVUrpYL8M=
X-Received: by 2002:ac2:4a6e:: with SMTP id q14mr24677289lfp.133.1621096428668;
 Sat, 15 May 2021 09:33:48 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 15 May 2021 11:33:37 -0500
Message-ID: <CAH2r5ms1smLAyKXH7Adfm+M62rYQdCCmo=aeyfiYoLV5bt4xJQ@mail.gmail.com>
Subject: crediting/tracing related oops in xfstest 478
To:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Saw this oops running test 478 with tracing enabled

.472990] run fstests generic/478 at 2021-05-15 11:27:59
[ 2308.033552] ------------[ cut here ]------------
[ 2308.033558] fmt: 'conn_id=0x%llx server=%s current_mid=%llu
credits=%d credit_change=%d in_flight=%d
               ' current_buffer: '   kworker/u24:6-243711  [004] ....
2193.687129: smb3_add_credits: conn_id=0x1 server='
[ 2308.033570] WARNING: CPU: 0 PID: 244568 at
kernel/trace/trace.c:3759 trace_check_vprintf+0x3a5/0x3d0
[ 2308.033586] Modules linked in: cifs(OE) md4 nls_utf8 libdes rfcomm
nfnetlink cachefiles fscache netfs cmac algif_hash algif_skcipher
af_alg bnep nls_iso8859_1 intel_tcc_cooling x86_pkg_temp_thermal
intel_powerclamp coretemp snd_sof_pci_intel_cnl
snd_sof_intel_hda_common nouveau snd_soc_hdac_hda soundwire_intel
soundwire_generic_allocation soundwire_cadence snd_sof_intel_hda
snd_sof_pci snd_sof_xtensa_dsp snd_sof snd_hda_ext_core
snd_soc_acpi_intel_match snd_soc_acpi soundwire_bus mxm_wmi mei_hdcp
intel_rapl_msr drm_ttm_helper snd_ctl_led kvm_intel snd_soc_core
snd_hda_codec_realtek snd_compress iwlmvm snd_hda_codec_generic
snd_hda_codec_hdmi ttm ac97_bus kvm mac80211 uvcvideo
snd_pcm_dmaengine crct10dif_pclmul ghash_clmulni_intel drm_kms_helper
snd_hda_intel videobuf2_vmalloc videobuf2_memops btusb aesni_intel
btrtl crypto_simd btbcm videobuf2_v4l2 cec cryptd snd_seq_midi libarc4
snd_intel_dspcfg btintel snd_intel_sdw_acpi videobuf2_common
snd_seq_midi_event snd_hda_codec rapl rc_core
[ 2308.033718]  videodev fb_sys_fops intel_cstate snd_rawmidi
snd_hda_core iwlwifi bluetooth syscopyarea thinkpad_acpi snd_hwdep
mei_me sysfillrect input_leds sysimgblt processor_thermal_device nvram
snd_seq processor_thermal_rfim serio_raw snd_pcm joydev
platform_profile efi_pstore mc nvidiafb ucsi_acpi
processor_thermal_mbox vgastate processor_thermal_rapl ecdh_generic
wmi_bmof elan_i2c intel_wmi_thunderbolt mei cfg80211 fb_ddc typec_ucsi
ee1004 intel_rapl_common snd_seq_device ecc 8250_dw ledtrig_audio
i2c_algo_bit intel_pch_thermal intel_soc_dts_iosf typec snd_timer snd
soundcore int3403_thermal int340x_thermal_zone int3400_thermal mac_hid
acpi_thermal_rel acpi_pad sch_fq_codel msr parport_pc ppdev lp parport
drm sunrpc ip_tables x_tables autofs4 xfs btrfs blake2b_generic xor
zstd_compress raid6_pq libcrc32c wacom hid_generic usbhid hid
rtsx_pci_sdmmc crc32_pclmul psmouse nvme e1000e i2c_i801 nvme_core
i2c_smbus rtsx_pci intel_lpss_pci intel_lpss xhci_pci idma64
xhci_pci_renesas wmi
[ 2308.033867]  video pinctrl_cannonlake [last unloaded: cifs]
[ 2308.033876] CPU: 0 PID: 244568 Comm: trace-cmd Tainted: G
OE     5.13.0-051300rc1-generic #202105092230
[ 2308.033884] Hardware name: LENOVO 20MAS08500/20MAS08500, BIOS
N2CET54W (1.37 ) 06/20/2020
[ 2308.033887] RIP: 0010:trace_check_vprintf+0x3a5/0x3d0
[ 2308.033897] Code: 00 00 48 39 c8 72 2e 39 c8 74 2a c6 04 0a 00 49
8b 97 b0 20 00 00 48 8b 75 b0 48 c7 c7 e8 29 bd 95 44 89 55 d0 e8 85
8e a1 00 <0f> 0b 44 8b 55 d0 e9 13 ff ff ff c6 44 02 ff 00 49 8b 97 b0
20 00
[ 2308.033903] RSP: 0018:ffffb52c864fbc40 EFLAGS: 00010286
[ 2308.033910] RAX: 0000000000000000 RBX: 0000000000000017 RCX: ffffa017bba189c8
[ 2308.033915] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffffa017bba189c0
[ 2308.033919] RBP: ffffb52c864fbc90 R08: 0000000000000000 R09: ffffb52c864fba38
[ 2308.033922] R10: ffffb52c864fba30 R11: ffffffff96555148 R12: ffffffffc170eb3e
[ 2308.033926] R13: ffffa010c4f2fdf0 R14: ffffffffc170eb28 R15: ffffa010d8bcc000
[ 2308.033930] FS:  00007f6c8ad38740(0000) GS:ffffa017bba00000(0000)
knlGS:0000000000000000
[ 2308.033936] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2308.033940] CR2: 000055ab9413e9c8 CR3: 0000000104aee006 CR4: 00000000003706f0
[ 2308.033946] Call Trace:
[ 2308.033956]  trace_event_printf+0x5e/0x80
[ 2308.033967]  trace_raw_output_smb3_credit_class+0x56/0x70 [cifs]
[ 2308.034071]  print_trace_fmt+0x10f/0x1c0
[ 2308.034081]  print_trace_line+0xc7/0x140
[ 2308.034087]  s_show+0x4c/0x160
[ 2308.034094]  seq_read_iter+0x2fb/0x520
[ 2308.034105]  seq_read+0xfa/0x140
[ 2308.034116]  vfs_read+0xa0/0x190
[ 2308.034122]  ksys_read+0x67/0xe0
[ 2308.034129]  __x64_sys_read+0x1a/0x20
[ 2308.034135]  do_syscall_64+0x40/0xb0
[ 2308.034143]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[ 2308.034153] RIP: 0033:0x7f6c8ae42b82
[ 2308.034159] Code: c0 e9 b2 fe ff ff 50 48 8d 3d ba aa 0a 00 e8 65
08 02 00 0f 1f 44 00 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75
10 0f 05 <48> 3d 00 f0 ff ff 77 56 c3 0f 1f 44 00 00 48 83 ec 28 48 89
54 24
[ 2308.034165] RSP: 002b:00007fff0909aa18 EFLAGS: 00000246 ORIG_RAX:
0000000000000000
[ 2308.034172] RAX: ffffffffffffffda RBX: 000055ab9413d330 RCX: 00007f6c8ae42b82
[ 2308.034176] RDX: 0000000000002000 RSI: 00007fff0909aab0 RDI: 0000000000000003
[ 2308.034180] RBP: 00007f6c8af1d4a0 R08: 0000000000000003 R09: 000055ab9413d9c0
[ 2308.034183] R10: 0000000000000077 R11: 0000000000000246 R12: 0000000000002000
[ 2308.034187] R13: 00007fff0909aab0 R14: 0000000000000d68 R15: 00007f6c8af1c8a0
[ 2308.034194] ---[ end trace c27dbcf0cab73015 ]---


-- 
Thanks,

Steve
