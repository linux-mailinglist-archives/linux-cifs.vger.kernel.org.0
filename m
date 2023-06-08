Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C62728580
	for <lists+linux-cifs@lfdr.de>; Thu,  8 Jun 2023 18:41:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236797AbjFHQl2 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 8 Jun 2023 12:41:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236873AbjFHQkq (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 8 Jun 2023 12:40:46 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46EF2D44;
        Thu,  8 Jun 2023 09:40:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686242408; x=1717778408;
  h=date:from:to:cc:subject:message-id;
  bh=F7UVQxLgpyB+XxwUND8Ji+HgcMvfRX9thOkFLT6lrY8=;
  b=Y+xTad3f0gqPwLxRGp9hKo2Vw1EmYPibCrkkmcDls1WY2gLCOE0ckBB8
   hDanNhILoya7is4IXkx66Faae0B+92WVwQjz1E5xiIPz34ZOpEbTb+1Ne
   9C7GyrWqDBPQSfXkQ1xbV/A/pvNhbHrJxa9HOmjS+ilKQ/X77ozbkaAzS
   YvOJxAJUfZ+kcR+NH/xdC8gxnoQ9OyRCsOE9D7vJeeAcZWzhzRTeOj2B6
   jyRw9OF3AFXpM1If/7MU79SvqOV4AQdYAexZnoKm0gmjfMtDPUFkRjak5
   RRWsbLyliXtwnQrp607xnBbnzuSsEW3QK8EMhk1jhYrmHgWIXoW2axju/
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="354852421"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="354852421"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 09:39:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10735"; a="822672133"
X-IronPort-AV: E=Sophos;i="6.00,227,1681196400"; 
   d="scan'208";a="822672133"
Received: from lkp-server01.sh.intel.com (HELO 15ab08e44a81) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Jun 2023 09:39:29 -0700
Received: from kbuild by 15ab08e44a81 with local (Exim 4.96)
        (envelope-from <lkp@intel.com>)
        id 1q7IfY-00083P-1a;
        Thu, 08 Jun 2023 16:39:28 +0000
Date:   Fri, 09 Jun 2023 00:38:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Memory Management List <linux-mm@kvack.org>,
        dri-devel@lists.freedesktop.org, linux-cifs@vger.kernel.org,
        linux-leds@vger.kernel.org, linux-perf-users@vger.kernel.org,
        linux-usb@vger.kernel.org, samba-technical@lists.samba.org
Subject: [linux-next:master] BUILD REGRESSION
 db10f126048021b86e43a5d6a335ec49dec10155
Message-ID: <202306090001.ng1n5qxC-lkp@intel.com>
User-Agent: s-nail v14.9.24
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
branch HEAD: db10f126048021b86e43a5d6a335ec49dec10155  Add linux-next specific files for 20230608

Error/Warning reports:

https://lore.kernel.org/oe-kbuild-all/202306081708.gtVAcXsh-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306082325.7vvIeVZo-lkp@intel.com
https://lore.kernel.org/oe-kbuild-all/202306082341.UQtCM8PO-lkp@intel.com

Error/Warning: (recently discovered and may have been fixed)

ERROR: modpost: "uv_info" [drivers/s390/char/uvdevice.ko] undefined!
drivers/leds/leds-cht-wcove.c:142:21: warning: no previous prototype for 'cht_wc_leds_brightness_get' [-Wmissing-prototypes]
include/drm/drm_print.h:456:39: error: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Werror=format=]
include/drm/drm_print.h:456:39: warning: format '%ld' expects argument of type 'long int', but argument 4 has type 'size_t' {aka 'unsigned int'} [-Wformat=]

Unverified Error/Warning (likely false positive, please contact us if interested):

drivers/usb/cdns3/cdns3-starfive.c:23: warning: expecting prototype for cdns3(). Prototype was for USB_STRAP_HOST() instead
fs/smb/client/cifsfs.c:982 cifs_smb3_do_mount() warn: possible memory leak of 'cifs_sb'
fs/smb/client/cifssmb.c:4089 CIFSFindFirst() warn: missing error code? 'rc'
fs/smb/client/cifssmb.c:4216 CIFSFindNext() warn: missing error code? 'rc'
fs/smb/client/connect.c:2725 cifs_match_super() error: 'tlink' dereferencing possible ERR_PTR()
fs/smb/client/connect.c:2924 generic_ip_connect() error: we previously assumed 'socket' could be null (see line 2912)
fs/smb/server/oplock.c:1013 find_same_lease_key() warn: missing error code 'err'
kernel/events/uprobes.c:478 uprobe_write_opcode() warn: passing zero to 'PTR_ERR'
{standard input}:1118: Error: unrecognized symbol type ""

Error/Warning ids grouped by kconfigs:

gcc_recent_errors
|-- i386-allyesconfig
|   `-- include-drm-drm_print.h:error:format-ld-expects-argument-of-type-long-int-but-argument-has-type-size_t-aka-unsigned-int
|-- i386-buildonly-randconfig-r004-20230608
|   `-- include-drm-drm_print.h:warning:format-ld-expects-argument-of-type-long-int-but-argument-has-type-size_t-aka-unsigned-int
|-- i386-randconfig-i004-20230608
|   `-- include-drm-drm_print.h:error:format-ld-expects-argument-of-type-long-int-but-argument-has-type-size_t-aka-unsigned-int
|-- i386-randconfig-m021-20230608
|   |-- fs-smb-client-cifsfs.c-cifs_smb3_do_mount()-warn:possible-memory-leak-of-cifs_sb
|   |-- fs-smb-client-cifssmb.c-CIFSFindFirst()-warn:missing-error-code-rc
|   |-- fs-smb-client-cifssmb.c-CIFSFindNext()-warn:missing-error-code-rc
|   |-- fs-smb-client-connect.c-cifs_match_super()-error:tlink-dereferencing-possible-ERR_PTR()
|   |-- fs-smb-client-connect.c-generic_ip_connect()-error:we-previously-assumed-socket-could-be-null-(see-line-)
|   `-- kernel-events-uprobes.c-uprobe_write_opcode()-warn:passing-zero-to-PTR_ERR
|-- i386-randconfig-m031-20230608
|   |-- fs-smb-client-cifsfs.c-cifs_smb3_do_mount()-warn:possible-memory-leak-of-cifs_sb
|   |-- fs-smb-client-cifssmb.c-CIFSFindFirst()-warn:missing-error-code-rc
|   |-- fs-smb-client-cifssmb.c-CIFSFindNext()-warn:missing-error-code-rc
|   |-- fs-smb-client-connect.c-cifs_match_super()-error:tlink-dereferencing-possible-ERR_PTR()
|   |-- fs-smb-client-connect.c-generic_ip_connect()-error:we-previously-assumed-socket-could-be-null-(see-line-)
|   `-- fs-smb-server-oplock.c-find_same_lease_key()-warn:missing-error-code-err
|-- riscv-allmodconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- riscv-allyesconfig
|   `-- drivers-usb-cdns3-cdns3-starfive.c:warning:expecting-prototype-for-cdns3().-Prototype-was-for-USB_STRAP_HOST()-instead
|-- s390-randconfig-s041-20230608
|   `-- ERROR:uv_info-drivers-s390-char-uvdevice.ko-undefined
|-- sh-allmodconfig
|   `-- standard-input:Error:unrecognized-symbol-type
|-- sh-allyesconfig
|   `-- standard-input:Error:unrecognized-symbol-type
`-- x86_64-allyesconfig
    `-- drivers-leds-leds-cht-wcove.c:warning:no-previous-prototype-for-cht_wc_leds_brightness_get

elapsed time: 733m

configs tested: 155
configs skipped: 8

tested configs:
alpha                            allyesconfig   gcc  
alpha                               defconfig   gcc  
alpha                randconfig-r015-20230608   gcc  
alpha                randconfig-r022-20230608   gcc  
alpha                randconfig-r025-20230608   gcc  
arc                              allyesconfig   gcc  
arc                                 defconfig   gcc  
arc                  randconfig-r024-20230608   gcc  
arc                  randconfig-r043-20230608   gcc  
arm                              allmodconfig   gcc  
arm                              allyesconfig   gcc  
arm          buildonly-randconfig-r005-20230608   gcc  
arm                                 defconfig   clang
arm                                 defconfig   gcc  
arm                      footbridge_defconfig   gcc  
arm                  randconfig-r006-20230608   clang
arm                  randconfig-r016-20230608   gcc  
arm                  randconfig-r046-20230608   gcc  
arm                         socfpga_defconfig   clang
arm                        spear3xx_defconfig   clang
arm                           u8500_defconfig   gcc  
arm64                            allyesconfig   gcc  
arm64                               defconfig   gcc  
csky         buildonly-randconfig-r004-20230608   gcc  
csky                                defconfig   gcc  
hexagon      buildonly-randconfig-r003-20230608   clang
hexagon              randconfig-r041-20230608   clang
hexagon              randconfig-r045-20230608   clang
i386                             allyesconfig   gcc  
i386         buildonly-randconfig-r004-20230608   gcc  
i386                              debian-10.3   gcc  
i386                                defconfig   gcc  
i386                 randconfig-i001-20230608   gcc  
i386                 randconfig-i002-20230608   gcc  
i386                 randconfig-i003-20230608   gcc  
i386                 randconfig-i004-20230608   gcc  
i386                 randconfig-i005-20230608   gcc  
i386                 randconfig-i006-20230608   gcc  
i386                 randconfig-i011-20230608   clang
i386                 randconfig-i012-20230608   clang
i386                 randconfig-i013-20230608   clang
i386                 randconfig-i015-20230608   clang
i386                 randconfig-i051-20230608   gcc  
i386                 randconfig-i052-20230608   gcc  
i386                 randconfig-i053-20230608   gcc  
i386                 randconfig-i054-20230608   gcc  
i386                 randconfig-i055-20230608   gcc  
i386                 randconfig-i056-20230608   gcc  
i386                 randconfig-i061-20230608   gcc  
i386                 randconfig-i062-20230608   gcc  
i386                 randconfig-i063-20230608   gcc  
i386                 randconfig-i064-20230608   gcc  
i386                 randconfig-i065-20230608   gcc  
i386                 randconfig-i066-20230608   gcc  
i386                 randconfig-r026-20230608   clang
loongarch                        allmodconfig   gcc  
loongarch                         allnoconfig   gcc  
loongarch    buildonly-randconfig-r001-20230608   gcc  
loongarch    buildonly-randconfig-r002-20230608   gcc  
loongarch                           defconfig   gcc  
loongarch            randconfig-r036-20230608   gcc  
m68k                             allmodconfig   gcc  
m68k                             allyesconfig   gcc  
m68k                          atari_defconfig   gcc  
m68k         buildonly-randconfig-r005-20230608   gcc  
m68k                                defconfig   gcc  
m68k                 randconfig-r003-20230608   gcc  
m68k                           virt_defconfig   gcc  
microblaze           randconfig-r015-20230608   gcc  
mips                             allmodconfig   gcc  
mips                             allyesconfig   gcc  
mips                     cu1830-neo_defconfig   clang
mips                      maltasmvp_defconfig   gcc  
mips                  maltasmvp_eva_defconfig   gcc  
mips                 randconfig-r004-20230608   clang
mips                       rbtx49xx_defconfig   clang
nios2        buildonly-randconfig-r002-20230608   gcc  
nios2                               defconfig   gcc  
nios2                randconfig-r012-20230608   gcc  
nios2                randconfig-r032-20230608   gcc  
openrisc             randconfig-r011-20230608   gcc  
parisc                           allyesconfig   gcc  
parisc                              defconfig   gcc  
parisc               randconfig-r005-20230608   gcc  
parisc               randconfig-r021-20230608   gcc  
parisc64                            defconfig   gcc  
powerpc                     akebono_defconfig   clang
powerpc                          allmodconfig   gcc  
powerpc                           allnoconfig   gcc  
powerpc                 canyonlands_defconfig   gcc  
powerpc                    ge_imp3a_defconfig   clang
powerpc               mpc834x_itxgp_defconfig   clang
powerpc                      ppc64e_defconfig   clang
powerpc              randconfig-r013-20230608   clang
powerpc                    socrates_defconfig   clang
powerpc                     tqm8540_defconfig   clang
powerpc                     tqm8541_defconfig   gcc  
powerpc                     tqm8560_defconfig   clang
powerpc                 xes_mpc85xx_defconfig   clang
riscv                            allmodconfig   gcc  
riscv                             allnoconfig   gcc  
riscv                            allyesconfig   gcc  
riscv        buildonly-randconfig-r006-20230608   clang
riscv                               defconfig   gcc  
riscv                randconfig-r014-20230608   clang
riscv                randconfig-r023-20230608   clang
riscv                randconfig-r042-20230608   clang
riscv                          rv32_defconfig   gcc  
s390                             allmodconfig   gcc  
s390                             allyesconfig   gcc  
s390                                defconfig   gcc  
s390                 randconfig-r044-20230608   clang
sh                               allmodconfig   gcc  
sh                               j2_defconfig   gcc  
sparc                            alldefconfig   gcc  
sparc                            allyesconfig   gcc  
sparc        buildonly-randconfig-r003-20230608   gcc  
sparc                               defconfig   gcc  
sparc                randconfig-r016-20230608   gcc  
sparc                randconfig-r035-20230608   gcc  
sparc                       sparc64_defconfig   gcc  
sparc64              randconfig-r013-20230608   gcc  
sparc64              randconfig-r031-20230608   gcc  
um                             i386_defconfig   gcc  
um                           x86_64_defconfig   gcc  
x86_64                           allyesconfig   gcc  
x86_64       buildonly-randconfig-r001-20230608   gcc  
x86_64                              defconfig   gcc  
x86_64                                  kexec   gcc  
x86_64               randconfig-a001-20230608   gcc  
x86_64               randconfig-a002-20230608   gcc  
x86_64               randconfig-a003-20230608   gcc  
x86_64               randconfig-a004-20230608   gcc  
x86_64               randconfig-a005-20230608   gcc  
x86_64               randconfig-a006-20230608   gcc  
x86_64               randconfig-a011-20230608   clang
x86_64               randconfig-a012-20230608   clang
x86_64               randconfig-a013-20230608   clang
x86_64               randconfig-a014-20230608   clang
x86_64               randconfig-a015-20230608   clang
x86_64               randconfig-a016-20230608   clang
x86_64               randconfig-r034-20230608   gcc  
x86_64               randconfig-x051-20230608   clang
x86_64               randconfig-x052-20230608   clang
x86_64               randconfig-x053-20230608   clang
x86_64               randconfig-x054-20230608   clang
x86_64               randconfig-x055-20230608   clang
x86_64               randconfig-x056-20230608   clang
x86_64               randconfig-x061-20230608   clang
x86_64               randconfig-x062-20230608   clang
x86_64               randconfig-x063-20230608   clang
x86_64               randconfig-x064-20230608   clang
x86_64               randconfig-x065-20230608   clang
x86_64               randconfig-x066-20230608   clang
x86_64                          rhel-8.3-rust   clang
xtensa               randconfig-r033-20230608   gcc  

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
