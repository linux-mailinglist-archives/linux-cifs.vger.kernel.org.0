Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0598F1B42C6
	for <lists+linux-cifs@lfdr.de>; Wed, 22 Apr 2020 13:07:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726965AbgDVLGO (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 22 Apr 2020 07:06:14 -0400
Received: from mga17.intel.com ([192.55.52.151]:50592 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726102AbgDVLGO (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 22 Apr 2020 07:06:14 -0400
IronPort-SDR: Ct86zFLoLdjZA3wlvGpRnAj63TH9HAqHvpqKp3buCwkSFyHtH+uOfRgF8SxBPMqA4q/fAteRtO
 ZskIAt2Ro3CA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 04:06:11 -0700
IronPort-SDR: GRCB3MSJdsYfVSakvG70wdSMwkWblL3kO9s1DMrc+B5tfLBsZ0QAucu5/FUhDea+XdfPRTCpK4
 GBTqstSiaaxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,414,1580803200"; 
   d="gz'50?scan'50,208,50";a="457107245"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 22 Apr 2020 04:06:09 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jRDCi-000FCg-T1; Wed, 22 Apr 2020 19:06:08 +0800
Date:   Wed, 22 Apr 2020 19:05:25 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Paulo Alcantara <pc@cjr.nz>
Cc:     kbuild-all@lists.01.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org,
        Steve French <stfrench@microsoft.com>,
        Aurelien Aptel <aaptel@suse.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [cifs:for-next 3/4] fs/cifs/connect.c:3378:45: error: 'struct
 cifs_tcon' has no member named 'dfs_path'
Message-ID: <202004221923.VD0dggU1%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="W/nzBZO5zC0uMSeA"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org


--W/nzBZO5zC0uMSeA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   git://git.samba.org/sfrench/cifs-2.6.git for-next
head:   db2905e7820335bdac93afe68c178a55c212c468
commit: f73409e5babde0e9e114876688697b1799b44fa9 [3/4] cifs: do not share tcons with DFS
config: m68k-sun3_defconfig (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout f73409e5babde0e9e114876688697b1799b44fa9
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day GCC_VERSION=9.3.0 make.cross ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   fs/cifs/connect.c: In function 'cifs_find_tcon':
>> fs/cifs/connect.c:3378:45: error: 'struct cifs_tcon' has no member named 'dfs_path'
    3378 |   if (!match_tcon(tcon, volume_info) || tcon->dfs_path)
         |                                             ^~

vim +3378 fs/cifs/connect.c

  3368	
  3369	static struct cifs_tcon *
  3370	cifs_find_tcon(struct cifs_ses *ses, struct smb_vol *volume_info)
  3371	{
  3372		struct list_head *tmp;
  3373		struct cifs_tcon *tcon;
  3374	
  3375		spin_lock(&cifs_tcp_ses_lock);
  3376		list_for_each(tmp, &ses->tcon_list) {
  3377			tcon = list_entry(tmp, struct cifs_tcon, tcon_list);
> 3378			if (!match_tcon(tcon, volume_info) || tcon->dfs_path)
  3379				continue;
  3380			++tcon->tc_count;
  3381			spin_unlock(&cifs_tcp_ses_lock);
  3382			return tcon;
  3383		}
  3384		spin_unlock(&cifs_tcp_ses_lock);
  3385		return NULL;
  3386	}
  3387	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--W/nzBZO5zC0uMSeA
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
g+tVom8mLdcTexv4C8BKHmv7zgAA

--W/nzBZO5zC0uMSeA--
