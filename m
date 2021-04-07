Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DE747356207
	for <lists+linux-cifs@lfdr.de>; Wed,  7 Apr 2021 05:40:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234240AbhDGDke (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 6 Apr 2021 23:40:34 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:15937 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbhDGDke (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 6 Apr 2021 23:40:34 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4FFVTw4PVCzyN8B;
        Wed,  7 Apr 2021 11:38:12 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Wed, 7 Apr 2021 11:40:12 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <namjae.jeon@samsung.com>, <zhangxiaoxu5@huawei.com>,
        <sfrench@samba.org>, <sergey.senozhatsky@gmail.com>,
        <hyc.lee@gmail.com>, <linux-cifs@vger.kernel.org>,
        <linux-cifsd-devel@lists.sourceforge.net>, <yukuai3@huawei.com>
Subject: [PATCH] cifsd: Select SG_POOL for SMB_SERVER
Date:   Tue, 6 Apr 2021 23:45:46 -0400
Message-ID: <20210407034546.2314958-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

hulk-robot following build error:
 fs/cifsd/transport_rdma.c: In function ‘read_write_done’:
 fs/cifsd/transport_rdma.c:1297:2: error: implicit declaration of function ‘sg_free_table_chained’ [-Werror=implicit-function-declaration]
  1297 |  sg_free_table_chained(&msg->sgt, SG_CHUNK_SIZE);

The reason is CONFIG_SG_POOL is not enabled in the config, to
avoid such failure, select SG_POOL in Kconfig for SMB_SERVER.

Fixes: 75b8988dfe83 ("cifsd: add server handler for central processing and tranport layers")
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/cifsd/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifsd/Kconfig b/fs/cifsd/Kconfig
index d1ac53c83125..fb57672424be 100644
--- a/fs/cifsd/Kconfig
+++ b/fs/cifsd/Kconfig
@@ -17,6 +17,7 @@ config SMB_SERVER
 	select CRYPTO_AEAD2
 	select CRYPTO_CCM
 	select CRYPTO_GCM
+	select SG_POOL
 	default n
 	help
 	  Choose Y here if you want to allow SMB3 compliant clients
-- 
2.25.4

