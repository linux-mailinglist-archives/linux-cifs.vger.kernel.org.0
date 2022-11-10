Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17EC462411D
	for <lists+linux-cifs@lfdr.de>; Thu, 10 Nov 2022 12:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230429AbiKJLMm (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 10 Nov 2022 06:12:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbiKJLMl (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 10 Nov 2022 06:12:41 -0500
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D746DCD4
        for <linux-cifs@vger.kernel.org>; Thu, 10 Nov 2022 03:12:40 -0800 (PST)
Received: from canpemm500010.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4N7K1S20HKzRpCB;
        Thu, 10 Nov 2022 19:12:28 +0800 (CST)
Received: from huawei.com (10.175.101.6) by canpemm500010.china.huawei.com
 (7.192.105.118) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Thu, 10 Nov
 2022 19:12:38 +0800
From:   Liu Jian <liujian56@huawei.com>
To:     <sfrench@samba.org>, <pc@cjr.nz>, <lsahlber@redhat.com>,
        <sprasad@microsoft.com>, <tom@talpey.com>,
        <zhangxiaoxu5@huawei.com>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>
CC:     <liujian56@huawei.com>
Subject: [PATCH] cifs: use kfree in error path of cifs_writedata_alloc()
Date:   Thu, 10 Nov 2022 19:19:39 +0800
Message-ID: <20221110111939.135696-1-liujian56@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500010.china.huawei.com (7.192.105.118)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

'pages' is allocated by kcalloc(), which should freed by kfree().

Fixes: 4153d789e299 ("cifs: Fix pages array leak when writedata alloc failed in cifs_writedata_alloc()")
Signed-off-by: Liu Jian <liujian56@huawei.com>
---
 fs/cifs/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index cd9698209930..9a250fee673f 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -2440,7 +2440,7 @@ cifs_writedata_alloc(unsigned int nr_pages, work_func_t complete)
 	if (pages) {
 		writedata = cifs_writedata_direct_alloc(pages, complete);
 		if (!writedata)
-			kvfree(pages);
+			kfree(pages);
 	}
 
 	return writedata;
-- 
2.17.1

