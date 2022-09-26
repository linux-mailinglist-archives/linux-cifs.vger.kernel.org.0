Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 586CC5E97F0
	for <lists+linux-cifs@lfdr.de>; Mon, 26 Sep 2022 04:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbiIZCh6 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 25 Sep 2022 22:37:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233196AbiIZChX (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 25 Sep 2022 22:37:23 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB6111EEDC
        for <linux-cifs@vger.kernel.org>; Sun, 25 Sep 2022 19:35:51 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MbRbQ5m9kzWh73;
        Mon, 26 Sep 2022 10:31:46 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 26 Sep 2022 10:35:48 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <linux-cifs@vger.kernel.org>, <zhangxiaoxu5@huawei.com>,
        <sfrench@samba.org>, <pc@cjr.nz>, <lsahlber@redhat.com>,
        <sprasad@microsoft.com>, <rohiths@microsoft.com>,
        <smfrench@gmail.com>, <tom@talpey.com>, <linkinjeon@kernel.org>,
        <hyc.lee@gmail.com>
Subject: [PATCH v8 0/3] Fix some bug in FSCTL_VALIDATE_NEGOTIATE_INFO handler
Date:   Mon, 26 Sep 2022 11:36:28 +0800
Message-ID: <20220926033631.926637-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

v7->v8: update the commit message and smb2_ioctl just ensure the
	DialectCount in the payload.
v6->v7: squash 2 and 3; use helper function to get the dialect count
v5->v6: use 'static' for 'smbx_neg_dialects'
v4->v5: reorder the patch;
	add check in smb2_ioctl() to ensure no oob read to DialectCount
v3->v4: Fix the wrong sizeof validate_negotiate_info_req in ksmbd
v2->v3: refactor the dialects in struct validate_negotiate_info_req to
	variable array
v1->v2: fix some bug in ksmbd when handle FSCTL_VALIDATE_NEGOTIATE_INFO
	message

Zhang Xiaoxu (3):
  cifs: Fix the error length of VALIDATE_NEGOTIATE_INFO message
  ksmbd: Fix wrong return value and message length check in smb2_ioctl()
  cifs: Refactor dialects in validate_negotiate_info_req to variable
    array

 fs/cifs/smb2pdu.c         | 94 ++++++++++++++++++---------------------
 fs/ksmbd/smb2pdu.c        | 13 ++++--
 fs/smbfs_common/smb2pdu.h |  3 +-
 3 files changed, 54 insertions(+), 56 deletions(-)

-- 
2.31.1

