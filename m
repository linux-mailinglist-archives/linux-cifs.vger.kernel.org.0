Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 227886C71B3
	for <lists+linux-cifs@lfdr.de>; Thu, 23 Mar 2023 21:36:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229499AbjCWUgf (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 23 Mar 2023 16:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjCWUgf (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 23 Mar 2023 16:36:35 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D072171C;
        Thu, 23 Mar 2023 13:36:32 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id by8so22657867ljb.12;
        Thu, 23 Mar 2023 13:36:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679603791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/wWKgtplskX35Ooj0rAZs8TVWsN+tlsRPpgYFNhLgjc=;
        b=QCERAZ6Vx534JVgfz+nGHSRlOHlsqXeKNYXAtrLPKiQguF7yLjPikV1QXsPrafsYXI
         2e2SaXvRhOObHxlmDm8J2FDd1mXB4PJhP0DfF3B7PI0q8gX6RZAzoUiGRVUEN1qQrsb/
         Bf6udFNVuWl5cRfgC1RrGTMM0D2KjL6Avywu2RyVKjRAgXAcmPvej/u/4mwsM0gEfR8K
         6yNPvtrYpOkCOE7twBIR7GyncR4Dx1xAupHIPoDeiuxpIWdevZ+P/aFOFwZecpwzn9Km
         Z/npkPFCJHi41ydklaNn2dd3XQoccEt2PsTZu6uTfTkbYybZHi/SFPj/VFw87S7dAaCG
         rWjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679603791;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/wWKgtplskX35Ooj0rAZs8TVWsN+tlsRPpgYFNhLgjc=;
        b=PqQICro18QQ/cAGZiC3Dvaxwpf7s1+JvqhLrEUhviXYMCAFoHcb451h3V1JETYjMSW
         FBAhFx/s5AciwwJCEk0BU99q8IJoSAXv/GAV1GRNhv3cWoZIzE3RtzrxmIGFZYCE9GaO
         Qm8pIpOkF0HQ0NUkWufKiwaHMwWrCSzVjm75A0L1c2s6CoeC8sgU65HRqc/j4CJDKQsw
         hYsoKaOlf0MCUZ54P6zHR5sYzch4LlVZzTV8PPeuYgrEG0mQ25xLUjcnn3A3HG3Q8PaS
         S9cvuoXQdNvbqA1y94RNpQQtJzUgyLQFAhuzI1BD81Ectkf9pcrR76LGc2GgviCdyU5w
         3D2w==
X-Gm-Message-State: AAQBX9evVD4fpZGpHYhheDFwtlZbuCAW/xMG8CkGTum+nMx0c371YjV3
        bVdIq/dUWFM5h7h/HVvx2AejNg1pVMO0u8dj2kL7OqVk
X-Google-Smtp-Source: AKy350YwWBk9gxR7KzJ68QeG9p+vu4IOSfqw5xttFfPBPC0dZJZXvDSKXvR5Y72WF+TdbDuvjYpzwa63XcssEqKWbn4=
X-Received: by 2002:a2e:8882:0:b0:295:945d:b381 with SMTP id
 k2-20020a2e8882000000b00295945db381mr164243lji.7.1679603790561; Thu, 23 Mar
 2023 13:36:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220826022031.GA76590@inn2.lkp.intel.com> <c8310cba-36ef-2940-b2c2-07573e015185@intel.com>
 <95e604ff-516a-4f7c-7f2c-8ff3d2cc66fa@intel.com> <CAH2r5msk7R4qZ-GQT2mKnCWzZ_MzYPUyJwWXuLRUMtt2XtApoA@mail.gmail.com>
 <997614df-10d4-af53-9571-edec36b0e2f3@intel.com>
In-Reply-To: <997614df-10d4-af53-9571-edec36b0e2f3@intel.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 23 Mar 2023 15:36:19 -0500
Message-ID: <CAH2r5mu5zDysHUPgeSK9aEL=cByz9_9vBTxKvkqZ5xOObTXAWA@mail.gmail.com>
Subject: Re: [smb3] 5efdd9122e: filebench.sum_operations/s -50.0% regression
To:     Yin Fengwei <fengwei.yin@intel.com>
Cc:     kernel test robot <yujie.liu@intel.com>,
        Steve French <stfrench@microsoft.com>, lkp@lists.01.org,
        lkp@intel.com, Bharath SM <bharathsm@microsoft.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        "Paulo Alcantara (SUSE)" <pc@cjr.nz>, linux-kernel@vger.kernel.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        ying.huang@intel.com, feng.tang@intel.com,
        zhengjun.xing@linux.intel.com, regressions@lists.linux.dev
Content-Type: multipart/mixed; boundary="0000000000004d29ac05f7973b18"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--0000000000004d29ac05f7973b18
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Patch attached to return default back to 1 second from 5 seconds
(Bharath's recent closetimeo on lease break patch may also help)

Let me know if you see any problems with it

On Thu, Mar 23, 2023 at 2:48=E2=80=AFAM Yin Fengwei <fengwei.yin@intel.com>=
 wrote:
>
> On 3/15/23 22:26, Steve French wrote:
> > Can you verify what this perf looks like with "closetime=3D0" and "clos=
etime=3D1"
> >
> > Are there differences in /proc/fs/cifs/Stats when you run the same
> > steps with "closetimeo=3D1" vs. the more recent default (5 seconds)?
> The dump of /proc/fs/cifs/Stats are attached. You can tell which
> closetimeo is used from the file name. Thanks.
>
>
> Regards
> Yin, Fengwei
>
> >
> > On Wed, Mar 15, 2023 at 2:46=E2=80=AFAM Yin, Fengwei <fengwei.yin@intel=
.com> wrote:
> >>
> >>
> >>
> >> On 8/26/2022 10:41 AM, kernel test robot wrote:
> >>> Greeting,
> >>>
> >>> FYI, we noticed a -50.0% regression of filebench.sum_operations/s due=
 to commit:
> >>>
> >>>
> >>> commit: 5efdd9122eff772eae2feae9f0fc0ec02d4846a3 ("smb3: allow deferr=
ed close timeout to be configurable")
> >>> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git maste=
r
> >>>
> >>> in testcase: filebench
> >>> on test machine: 88 threads 2 sockets Intel(R) Xeon(R) Gold 6238M CPU=
 @ 2.10GHz (Cascade Lake) with 128G memory
> >>> with following parameters:
> >>>
> >>>      disk: 1HDD
> >>>      fs: ext4
> >>>      fs2: cifs
> >>>      test: filemicro_delete.f
> >>>      cpufreq_governor: performance
> >>>      ucode: 0x5003302
> >> Please note, we still could see this regresion on v6.3-rc2. And the re=
gression is related with
> >> the commit: 5efdd9122eff772eae2feae9f0fc0ec02d4846a3. This commit chan=
ged the default timeout
> >> value from 1s to 5s. If change the timeout back to 1s as following:
> >>
> >> diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
> >> index 6d13f8207e96..6b930fb0c4bd 100644
> >> --- a/fs/cifs/fs_context.c
> >> +++ b/fs/cifs/fs_context.c
> >> @@ -1537,7 +1537,7 @@ int smb3_init_fs_context(struct fs_context *fc)
> >>
> >>          ctx->acregmax =3D CIFS_DEF_ACTIMEO;
> >>          ctx->acdirmax =3D CIFS_DEF_ACTIMEO;
> >> -       ctx->closetimeo =3D SMB3_DEF_DCLOSETIMEO;
> >> +       ctx->closetimeo =3D CIFS_DEF_ACTIMEO;
> >>
> >>          /* Most clients set timeout to 0, allows server to use its de=
fault */
> >>          ctx->handle_timeout =3D 0; /* See MS-SMB2 spec section 2.2.14=
.2.12 */
> >>
> >> The regression is gone:
> >> dcb45fd7f501f864                    v6.3-rc2 32715af441411a5a266606be0=
8f
> >> ---------------- --------------------------- -------------------------=
--
> >>         fail:runs  %reproduction    fail:runs  %reproduction    fail:r=
uns
> >>             |             |             |             |             |
> >>             :25           0%            :3           33%           1:3=
     last_state.booting
> >>             :25           0%            :3           33%           1:3=
     last_state.is_incomplete_run
> >>           %stddev     %change         %stddev     %change         %std=
dev
> >>               \          |                \          |                =
\
> >>      515.95           -50.0%     257.98            -0.0%     515.92   =
     filebench.sum_operations/s
> >>        5.04 =C2=B1  7%    +833.7%      47.09 =C2=B1  2%      -2.9%    =
   4.90 =C2=B1  2%  filebench.sum_time_ms/op
> >>       10438          -100.0%       0.33 =C2=B1141%    -100.0%       0.=
50 =C2=B1100%  filebench.time.major_page_faults
> >>      167575            -4.1%     160660            -4.4%     160140   =
     filebench.time.maximum_resident_set_size
> >>        7138 =C2=B1 11%    +141.4%      17235 =C2=B1  3%    +147.6%    =
  17677        filebench.time.minor_page_faults
> >>       28.68 =C2=B1  9%    +199.9%      86.00 =C2=B1  7%      -2.4%    =
  28.00        filebench.time.percent_of_cpu_this_job_got
> >>     2453485 =C2=B1 54%     -63.0%     907380           -66.2%     8302=
73 =C2=B1  6%  cpuidle..usage
> >>        0.61 =C2=B1 38%      +0.8        1.41 =C2=B1  3%      +0.2     =
   0.80 =C2=B1  4%  mpstat.cpu.all.sys%
> >>      142984 =C2=B1 13%     -45.6%      77725           -47.5%      751=
06        vmstat.system.in
> >>       34.23 =C2=B1  7%     +27.9%      43.79           +27.8%      43.=
74        boot-time.boot
> >>       17.09 =C2=B1 11%     +66.0%      28.38           +65.5%      28.=
28        boot-time.dhcp
> >>        2661 =C2=B1  7%     +37.5%       3659           +37.2%       36=
51        boot-time.idle
> >>      104737 =C2=B1185%     -87.8%      12762 =C2=B1 10%     -89.8%    =
  10631 =C2=B1  4%  turbostat.C1
> >>
> >>
> >> 32715af441411a5a266606be08f is v6.3-rc2 with the change to restore the=
 timeout to 1s. Thanks.
> >>
> >> Regards
> >> Yin, Fengwei
> >>
> >>
> >>>
> >>>
> >>> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> >>> compiler/cpufreq_governor/disk/fs2/fs/kconfig/rootfs/tbox_group/test/=
testcase/ucode:
> >>>    gcc-11/performance/1HDD/cifs/ext4/x86_64-rhel-8.3/debian-11.1-x86_=
64-20220510.cgz/lkp-csl-2sp9/filemicro_delete.f/filebench/0x5003302
> >>>
> >>> commit:
> >>>    dcb45fd7f5 ("cifs: Do not use tcon->cfid directly, use the cfid we=
 get from open_cached_dir")
> >>>    5efdd9122e ("smb3: allow deferred close timeout to be configurable=
")
> >>>
> >>> dcb45fd7f501f864 5efdd9122eff772eae2feae9f0f
> >>> ---------------- ---------------------------
> >>>           %stddev     %change         %stddev
> >>>               \          |                \
> >>>      515.95           -50.0%     257.98        filebench.sum_operatio=
ns/s
> >>>        4.81 =C2=B1  2%   +1038.4%      54.78 =C2=B1  6%  filebench.su=
m_time_ms/op
> >>>       29.00 =C2=B1  8%    +212.1%      90.50 =C2=B1  3%  filebench.ti=
me.percent_of_cpu_this_job_got
> >>>       24629            +2.7%      25297        filebench.time.volunta=
ry_context_switches
> >>>   7.685e+08           +19.3%  9.169e+08 =C2=B1  4%  cpuidle..time
> >>>        2.53 =C2=B1  6%     -20.6%       2.00 =C2=B1  3%  iostat.cpu.i=
owait
> >>>     1506141 =C2=B1  8%     +22.4%    1843256 =C2=B1  3%  turbostat.IR=
Q
> >>>        2.00           -50.0%       1.00        vmstat.procs.b
> >>>       21969 =C2=B1  2%      -9.5%      19885 =C2=B1  2%  vmstat.syste=
m.cs
> >>>        3.06 =C2=B1  7%      -0.7        2.35 =C2=B1  4%  mpstat.cpu.a=
ll.iowait%
> >>>        0.79 =C2=B1  5%      +0.5        1.27 =C2=B1  2%  mpstat.cpu.a=
ll.sys%
> >>>        0.89 =C2=B1  3%      -0.1        0.79 =C2=B1  3%  mpstat.cpu.a=
ll.usr%
> >>>       34.55 =C2=B1 14%     -34.8%      22.51 =C2=B1 27%  sched_debug.=
cfs_rq:/.removed.runnable_avg.avg
> >>>      119.64 =C2=B1  3%     -20.0%      95.69 =C2=B1 17%  sched_debug.=
cfs_rq:/.removed.runnable_avg.stddev
> >>>       34.55 =C2=B1 14%     -34.8%      22.51 =C2=B1 27%  sched_debug.=
cfs_rq:/.removed.util_avg.avg
> >>>      119.64 =C2=B1  3%     -20.0%      95.69 =C2=B1 17%  sched_debug.=
cfs_rq:/.removed.util_avg.stddev
> >>>        5249           +15.8%       6076        meminfo.Active
> >>>        3866 =C2=B1  2%     +17.7%       4552        meminfo.Active(an=
on)
> >>>        1382 =C2=B1  4%     +10.3%       1524 =C2=B1  4%  meminfo.Acti=
ve(file)
> >>>       69791 =C2=B1 14%     +39.8%      97553 =C2=B1  6%  meminfo.Anon=
HugePages
> >>>       72709 =C2=B1  2%     +12.5%      81779 =C2=B1  3%  meminfo.Inac=
tive(file)
> >>>       23219           +13.5%      26352 =C2=B1  3%  meminfo.KernelSta=
ck
> >>>      966.50 =C2=B1  2%     +17.7%       1137        proc-vmstat.nr_ac=
tive_anon
> >>>       74302            +6.3%      78977 =C2=B1  2%  proc-vmstat.nr_an=
on_pages
> >>>       81133            +6.0%      85973        proc-vmstat.nr_inactiv=
e_anon
> >>>       18172 =C2=B1  2%     +12.5%      20442 =C2=B1  3%  proc-vmstat.=
nr_inactive_file
> >>>       23213           +13.5%      26348 =C2=B1  3%  proc-vmstat.nr_ke=
rnel_stack
> >>>       17983            +2.3%      18400        proc-vmstat.nr_mapped
> >>>        7446 =C2=B1  2%      +5.5%       7853 =C2=B1  3%  proc-vmstat.=
nr_shmem
> >>>       26888            +1.6%      27306        proc-vmstat.nr_slab_re=
claimable
> >>>       47220            +3.4%      48803        proc-vmstat.nr_slab_un=
reclaimable
> >>>      966.50 =C2=B1  2%     +17.7%       1137        proc-vmstat.nr_zo=
ne_active_anon
> >>>       81133            +6.0%      85973        proc-vmstat.nr_zone_in=
active_anon
> >>>       18172 =C2=B1  2%     +12.5%      20442 =C2=B1  3%  proc-vmstat.=
nr_zone_inactive_file
> >>>      361460            +2.5%     370454        proc-vmstat.numa_hit
> >>>      946.67           +18.6%       1122        proc-vmstat.pgactivate
> >>>      361562            +2.5%     370553        proc-vmstat.pgalloc_no=
rmal
> >>>      187906            +4.7%     196761        proc-vmstat.pgfault
> >>>        8189            +2.5%       8395        proc-vmstat.pgreuse
> >>>   1.097e+09           +15.5%  1.267e+09 =C2=B1  7%  perf-stat.i.branc=
h-instructions
> >>>    39079265 =C2=B1  6%     -20.9%   30915354 =C2=B1  4%  perf-stat.i.=
branch-misses
> >>>     5093263 =C2=B1  4%     -23.7%    3884752 =C2=B1  9%  perf-stat.i.=
cache-misses
> >>>       29213           -18.7%      23764 =C2=B1  5%  perf-stat.i.conte=
xt-switches
> >>>   7.666e+09 =C2=B1  4%      +5.7%  8.106e+09 =C2=B1  2%  perf-stat.i.=
cpu-cycles
> >>>        1877 =C2=B1 15%     +75.1%       3287 =C2=B1 12%  perf-stat.i.=
cycles-between-cache-misses
> >>>     1735450 =C2=B1  3%     -12.9%    1512060 =C2=B1  3%  perf-stat.i.=
iTLB-load-misses
> >>>        2898 =C2=B1  3%     +34.4%       3895 =C2=B1  7%  perf-stat.i.=
instructions-per-iTLB-miss
> >>>        1493           -20.3%       1190 =C2=B1  7%  perf-stat.i.major=
-faults
> >>>        0.09 =C2=B1  3%      +5.8%       0.09 =C2=B1  2%  perf-stat.i.=
metric.GHz
> >>>       48.47 =C2=B1 11%      +8.4       56.83 =C2=B1  7%  perf-stat.i.=
node-store-miss-rate%
> >>>      283426 =C2=B1  4%     -21.6%     222190 =C2=B1 10%  perf-stat.i.=
node-stores
> >>>        3.57 =C2=B1  7%      -1.1        2.44 =C2=B1  6%  perf-stat.ov=
erall.branch-miss-rate%
> >>>        1508 =C2=B1  3%     +39.8%       2108 =C2=B1  9%  perf-stat.ov=
erall.cycles-between-cache-misses
> >>>        3022 =C2=B1  3%     +23.6%       3736 =C2=B1  5%  perf-stat.ov=
erall.instructions-per-iTLB-miss
> >>>   9.585e+08           +18.8%  1.138e+09 =C2=B1  6%  perf-stat.ps.bran=
ch-instructions
> >>>    34151514 =C2=B1  6%     -18.8%   27725316 =C2=B1  4%  perf-stat.ps=
.branch-misses
> >>>     4450329 =C2=B1  5%     -21.7%    3486409 =C2=B1  9%  perf-stat.ps=
.cache-misses
> >>>       25524           -16.4%      21333 =C2=B1  4%  perf-stat.ps.cont=
ext-switches
> >>>       77139            +2.5%      79105        perf-stat.ps.cpu-clock
> >>>   6.704e+09 =C2=B1  4%      +8.7%  7.287e+09        perf-stat.ps.cpu-=
cycles
> >>>    1.06e+09           +11.3%   1.18e+09 =C2=B1  5%  perf-stat.ps.dTLB=
-loads
> >>>     1517349 =C2=B1  3%     -10.5%    1357716 =C2=B1  2%  perf-stat.ps=
.iTLB-load-misses
> >>>   4.582e+09           +10.8%  5.075e+09 =C2=B1  6%  perf-stat.ps.inst=
ructions
> >>>        1296           -18.1%       1061 =C2=B1  6%  perf-stat.ps.majo=
r-faults
> >>>      247613 =C2=B1  4%     -19.5%     199283 =C2=B1  9%  perf-stat.ps=
.node-stores
> >>>       77139            +2.5%      79105        perf-stat.ps.task-cloc=
k
> >>>   3.697e+10           +35.3%  5.003e+10        perf-stat.total.instru=
ctions
> >>>        8.51 =C2=B1 91%      -6.9        1.59 =C2=B1223%  perf-profile=
.calltrace.cycles-pp.getdents64
> >>>        8.34 =C2=B1 83%      -6.7        1.67 =C2=B1141%  perf-profile=
.calltrace.cycles-pp.exit_to_user_mode_loop.exit_to_user_mode_prepare.sysca=
ll_exit_to_user_mode.do_syscall_64.entry_SYSCALL_64_after_hwframe
> >>>        6.25 =C2=B1107%      -6.2        0.00        perf-profile.call=
trace.cycles-pp.entry_SYSCALL_64_after_hwframe.open64
> >>>        6.25 =C2=B1107%      -6.2        0.00        perf-profile.call=
trace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.open64
> >>>        6.25 =C2=B1107%      -6.2        0.00        perf-profile.call=
trace.cycles-pp.open64
> >>>        7.63 =C2=B1 84%      -6.0        1.59 =C2=B1223%  perf-profile=
.calltrace.cycles-pp.entry_SYSCALL_64_after_hwframe.getdents64
> >>>        7.63 =C2=B1 84%      -6.0        1.59 =C2=B1223%  perf-profile=
.calltrace.cycles-pp.do_syscall_64.entry_SYSCALL_64_after_hwframe.getdents6=
4
> >>>        7.63 =C2=B1 84%      -6.0        1.59 =C2=B1223%  perf-profile=
.calltrace.cycles-pp.__x64_sys_getdents64.do_syscall_64.entry_SYSCALL_64_af=
ter_hwframe.getdents64
> >>>        7.63 =C2=B1 84%      -6.0        1.59 =C2=B1223%  perf-profile=
.calltrace.cycles-pp.iterate_dir.__x64_sys_getdents64.do_syscall_64.entry_S=
YSCALL_64_after_hwframe.getdents64
> >>>        6.26 =C2=B1115%      -5.4        0.88 =C2=B1223%  perf-profile=
.calltrace.cycles-pp.syscall_exit_to_user_mode.do_syscall_64.entry_SYSCALL_=
64_after_hwframe
> >>>        6.26 =C2=B1115%      -5.4        0.88 =C2=B1223%  perf-profile=
.calltrace.cycles-pp.exit_to_user_mode_prepare.syscall_exit_to_user_mode.do=
_syscall_64.entry_SYSCALL_64_after_hwframe
> >>>        6.26 =C2=B1115%      -4.6        1.67 =C2=B1141%  perf-profile=
.calltrace.cycles-pp.do_group_exit.get_signal.arch_do_signal_or_restart.exi=
t_to_user_mode_loop.exit_to_user_mode_prepare
> >>>        6.26 =C2=B1115%      -4.6        1.67 =C2=B1141%  perf-profile=
.calltrace.cycles-pp.do_exit.do_group_exit.get_signal.arch_do_signal_or_res=
tart.exit_to_user_mode_loop
> >>>        6.26 =C2=B1115%      -4.6        1.67 =C2=B1141%  perf-profile=
.calltrace.cycles-pp.arch_do_signal_or_restart.exit_to_user_mode_loop.exit_=
to_user_mode_prepare.syscall_exit_to_user_mode.do_syscall_64
> >>>        6.26 =C2=B1115%      -4.6        1.67 =C2=B1141%  perf-profile=
.calltrace.cycles-pp.get_signal.arch_do_signal_or_restart.exit_to_user_mode=
_loop.exit_to_user_mode_prepare.syscall_exit_to_user_mode
> >>>        4.57 =C2=B1 73%      -3.8        0.76 =C2=B1223%  perf-profile=
.calltrace.cycles-pp.asm_exc_page_fault.perf_mmap__read_head.perf_mmap__pus=
h.record__mmap_read_evlist.__cmd_record
> >>>        4.57 =C2=B1 73%      -3.8        0.76 =C2=B1223%  perf-profile=
.calltrace.cycles-pp.exc_page_fault.asm_exc_page_fault.perf_mmap__read_head=
.perf_mmap__push.record__mmap_read_evlist
> >>>        4.57 =C2=B1 73%      -3.8        0.76 =C2=B1223%  perf-profile=
.calltrace.cycles-pp.do_user_addr_fault.exc_page_fault.asm_exc_page_fault.p=
erf_mmap__read_head.perf_mmap__push
> >>>        4.57 =C2=B1 73%      -3.8        0.76 =C2=B1223%  perf-profile=
.calltrace.cycles-pp.perf_mmap__read_head.perf_mmap__push.record__mmap_read=
_evlist.__cmd_record.cmd_record
> >>>        3.38 =C2=B1103%      -3.4        0.00        perf-profile.call=
trace.cycles-pp.unmap_vmas.exit_mmap.mmput.exit_mm.do_exit
> >>>        3.38 =C2=B1103%      -3.4        0.00        perf-profile.call=
trace.cycles-pp.unmap_page_range.unmap_vmas.exit_mmap.mmput.exit_mm
> >>>        3.38 =C2=B1103%      -3.4        0.00        perf-profile.call=
trace.cycles-pp.zap_pmd_range.unmap_page_range.unmap_vmas.exit_mmap.mmput
> >>>        3.38 =C2=B1103%      -3.4        0.00        perf-profile.call=
trace.cycles-pp.zap_pte_range.zap_pmd_range.unmap_page_range.unmap_vmas.exi=
t_mmap
> >>>        8.51 =C2=B1 91%      -6.9        1.59 =C2=B1223%  perf-profile=
.children.cycles-pp.getdents64
> >>>        8.34 =C2=B1 83%      -6.7        1.67 =C2=B1141%  perf-profile=
.children.cycles-pp.exit_to_user_mode_prepare
> >>>        8.34 =C2=B1 83%      -6.7        1.67 =C2=B1141%  perf-profile=
.children.cycles-pp.exit_to_user_mode_loop
> >>>        8.34 =C2=B1 83%      -6.7        1.67 =C2=B1141%  perf-profile=
.children.cycles-pp.syscall_exit_to_user_mode
> >>>        6.25 =C2=B1107%      -6.2        0.00        perf-profile.chil=
dren.cycles-pp.open64
> >>>        7.63 =C2=B1 84%      -6.0        1.59 =C2=B1223%  perf-profile=
.children.cycles-pp.__x64_sys_getdents64
> >>>        7.63 =C2=B1 84%      -6.0        1.59 =C2=B1223%  perf-profile=
.children.cycles-pp.iterate_dir
> >>>        6.26 =C2=B1115%      -4.6        1.67 =C2=B1141%  perf-profile=
.children.cycles-pp.arch_do_signal_or_restart
> >>>        6.26 =C2=B1115%      -4.6        1.67 =C2=B1141%  perf-profile=
.children.cycles-pp.get_signal
> >>>        4.57 =C2=B1 73%      -3.8        0.76 =C2=B1223%  perf-profile=
.children.cycles-pp.perf_mmap__read_head
> >>>        3.38 =C2=B1103%      -3.4        0.00        perf-profile.chil=
dren.cycles-pp.unmap_vmas
> >>>        3.38 =C2=B1103%      -3.4        0.00        perf-profile.chil=
dren.cycles-pp.unmap_page_range
> >>>        3.38 =C2=B1103%      -3.4        0.00        perf-profile.chil=
dren.cycles-pp.zap_pmd_range
> >>>        3.38 =C2=B1103%      -3.4        0.00        perf-profile.chil=
dren.cycles-pp.zap_pte_range
> >>>        8.54 =C2=B1 43%      +8.6       17.19 =C2=B1 38%  perf-profile=
.children.cycles-pp.asm_exc_page_fault
> >>>
> >>>
> >>> If you fix the issue, kindly add following tag
> >>> Reported-by: kernel test robot <yujie.liu@intel.com>
> >>>
> >>>
> >>> To reproduce:
> >>>
> >>>          git clone https://github.com/intel/lkp-tests.git
> >>>          cd lkp-tests
> >>>          sudo bin/lkp install job.yaml           # job file is attach=
ed in this email
> >>>          bin/lkp split-job --compatible job.yaml # generate the yaml =
file for lkp run
> >>>          sudo bin/lkp run generated-yaml-file
> >>>
> >>>          # if come across any failure that blocks the test,
> >>>          # please remove ~/.lkp and /lkp dir to run from a clean stat=
e.
> >>>
> >>>
> >>> Disclaimer:
> >>> Results have been estimated based on internal Intel analysis and are =
provided
> >>> for informational purposes only. Any difference in system hardware or=
 software
> >>> design or configuration may affect actual performance.
> >>>
> >>>
> >>> #regzbot introduced: 5efdd9122e
> >>>
> >>>
> >
> >
> >



--=20
Thanks,

Steve

--0000000000004d29ac05f7973b18
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb3-lower-default-deferred-close-timeout-to-address.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-lower-default-deferred-close-timeout-to-address.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lflkpu0r0>
X-Attachment-Id: f_lflkpu0r0

RnJvbSAwZTNlNGY2NjEzMGEwNzdmMGJmMjBiZDI5YjhhZDIxZDRkNWE5MzE0IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFRodSwgMjMgTWFyIDIwMjMgMTU6MTA6MjYgLTA1MDAKU3ViamVjdDogW1BBVENIXSBz
bWIzOiBsb3dlciBkZWZhdWx0IGRlZmVycmVkIGNsb3NlIHRpbWVvdXQgdG8gYWRkcmVzcyBwZXJm
CiByZWdyZXNzaW9uCgpQZXJmb3JtYW5jZSB0ZXN0cyB3aXRoIGxhcmdlIG51bWJlciBvZiB0aHJl
YWRzIG5vdGVkIHRoYXQgdGhlIGNoYW5nZQpvZiB0aGUgZGVmYXVsdCBjbG9zZXRpbWVvIChkZWZl
cnJlZCBjbG9zZSB0aW1lb3V0IGJldHdlZW4gd2hlbgpjbG9zZSBpcyBkb25lIGJ5IGFwcGxpY2F0
aW9uIGFuZCB3aGVuIGNsaWVudCBoYXMgdG8gc2VuZCB0aGUgY2xvc2UKdG8gdGhlIHNlcnZlciks
IHRvIDUgc2Vjb25kcyBmcm9tIDEgc2Vjb25kLCBzaWduaWZpY2FudGx5IGRlZ3JhZGVkCnBlcmYg
aW4gc29tZSBjYXNlcyBsaWtlIHRoaXMgKGluIHRoZSBmaWxlYmVuY2ggZXhhbXBsZSByZXBvcnRl
ZCwKdGhlIHN0YXRzIHNob3cgY2xvc2UgcmVxdWVzdHMgb24gdGhlIHdpcmUgdGFraW5nIHR3aWNl
IGFzIGxvbmcsCmFuZCA1MCUgcmVncmVzc2lvbiBpbiBmaWxlYmVuY2ggcGVyZikuIFRoaXMgaXMg
c3RpbCBjb25maWd1cmFibGUKdmlhIG1vdW50IHBhcm0gY2xvc2V0aW1lbywgYnV0IHRvIGJlIHNh
ZmUsIGRlY3JlYXNlIGRlZmF1bHQgYmFjawp0byBpdHMgcHJldmlvdXMgdmFsdWUgb2YgMSBzZWNv
bmQuCgpSZXBvcnRlZC1ieTogWWluIEZlbmd3ZWkgPGZlbmd3ZWkueWluQGludGVsLmNvbT4KUmVw
b3J0ZWQtYnk6IGtlcm5lbCB0ZXN0IHJvYm90IDx5dWppZS5saXVAaW50ZWwuY29tPgpMaW5rOiBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9sa21sLzk5NzYxNGRmLTEwZDQtYWY1My05NTcxLWVkZWMz
NmIwZTJmM0BpbnRlbC5jb20vCkZpeGVzOiA1ZWZkZDkxMjJlZmYgKCJzbWIzOiBhbGxvdyBkZWZl
cnJlZCBjbG9zZSB0aW1lb3V0IHRvIGJlIGNvbmZpZ3VyYWJsZSIpCkNjOiBzdGFibGVAdmdlci5r
ZXJuZWwub3JnICMgNi4wKwpSZXZpZXdlZC1ieTogUGF1bG8gQWxjYW50YXJhIChTVVNFKSA8cGNA
bWFuZ3VlYml0LmNvbT4KQWNrZWQtYnk6IFNoeWFtIFByYXNhZCBOIDxzcHJhc2FkQG1pY3Jvc29m
dC5jb20+ClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNv
bT4KLS0tCiBmcy9jaWZzL2ZzX2NvbnRleHQuaCB8IDIgKy0KIDEgZmlsZSBjaGFuZ2VkLCAxIGlu
c2VydGlvbigrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvZnNfY29udGV4
dC5oIGIvZnMvY2lmcy9mc19jb250ZXh0LmgKaW5kZXggMWI4ZDRlMjdmODMxLi4zZGUwMGU3MTI3
ZWMgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvZnNfY29udGV4dC5oCisrKyBiL2ZzL2NpZnMvZnNfY29u
dGV4dC5oCkBAIC0yODYsNSArMjg2LDUgQEAgZXh0ZXJuIHZvaWQgc21iM191cGRhdGVfbW50X2Zs
YWdzKHN0cnVjdCBjaWZzX3NiX2luZm8gKmNpZnNfc2IpOwogICogbWF4IGRlZmVycmVkIGNsb3Nl
IHRpbWVvdXQgKGppZmZpZXMpIC0gMl4zMAogICovCiAjZGVmaW5lIFNNQjNfTUFYX0RDTE9TRVRJ
TUVPICgxIDw8IDMwKQotI2RlZmluZSBTTUIzX0RFRl9EQ0xPU0VUSU1FTyAoNSAqIEhaKSAvKiBD
YW4gaW5jcmVhc2UgbGF0ZXIsIG90aGVyIGNsaWVudHMgdXNlIGxhcmdlciAqLworI2RlZmluZSBT
TUIzX0RFRl9EQ0xPU0VUSU1FTyAoMSAqIEhaKSAvKiBldmVuIDEgc2VjIGVub3VnaCB0byBoZWxw
IGVnIG9wZW4vd3JpdGUvY2xvc2Uvb3Blbi9yZWFkICovCiAjZW5kaWYKLS0gCjIuMzQuMQoK
--0000000000004d29ac05f7973b18--
