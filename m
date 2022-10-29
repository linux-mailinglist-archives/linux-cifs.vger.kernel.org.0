Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E983161212E
	for <lists+linux-cifs@lfdr.de>; Sat, 29 Oct 2022 09:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229500AbiJ2Hzw (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 29 Oct 2022 03:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbiJ2Hzo (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 29 Oct 2022 03:55:44 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA60F6EF29
        for <linux-cifs@vger.kernel.org>; Sat, 29 Oct 2022 00:55:39 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4Mzs6G4xm9zVhyl;
        Sat, 29 Oct 2022 15:50:46 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 15:55:37 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <linux-cifs@vger.kernel.org>, <zhangxiaoxu5@huawei.com>,
        <sfrench@samba.org>, <smfrench@gmail.com>, <pc@cjr.nz>,
        <lsahlber@redhat.com>, <sprasad@microsoft.com>, <tom@talpey.com>
Subject: [PATCH v2 6/7] cifs: Fix wrong return value checking when GETFLAGS
Date:   Sat, 29 Oct 2022 17:00:10 +0800
Message-ID: <20221029090011.79367-7-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221029090011.79367-1-zhangxiaoxu5@huawei.com>
References: <20221029090011.79367-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The return value of CIFSGetExtAttr is negative, should be checked
with -EOPNOTSUPP rather than EOPNOTSUPP.

Fixes: 64a5cfa6db9 ("Allow setting per-file compression via SMB2/3")
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/cifs/ioctl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/ioctl.c b/fs/cifs/ioctl.c
index c25e8442068a..1494fb5c1c45 100644
--- a/fs/cifs/ioctl.c
+++ b/fs/cifs/ioctl.c
@@ -342,7 +342,7 @@ long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg)
 					rc = put_user(ExtAttrBits &
 						FS_FL_USER_VISIBLE,
 						(int __user *)arg);
-				if (rc != EOPNOTSUPP)
+				if (rc != -EOPNOTSUPP)
 					break;
 			}
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
@@ -372,7 +372,7 @@ long cifs_ioctl(struct file *filep, unsigned int command, unsigned long arg)
 			 *		       pSMBFile->fid.netfid,
 			 *		       extAttrBits,
 			 *		       &ExtAttrMask);
-			 * if (rc != EOPNOTSUPP)
+			 * if (rc != -EOPNOTSUPP)
 			 *	break;
 			 */
 
-- 
2.31.1

