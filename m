Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2B031E89C
	for <lists+linux-cifs@lfdr.de>; Thu, 18 Feb 2021 11:59:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbhBRKFW (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 18 Feb 2021 05:05:22 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:12557 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbhBRJ3k (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 18 Feb 2021 04:29:40 -0500
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4Dh8Vb5CWBzMYJS;
        Thu, 18 Feb 2021 17:27:03 +0800 (CST)
Received: from localhost (10.174.179.96) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.498.0; Thu, 18 Feb 2021
 17:28:48 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     <sfrench@samba.org>, <scabrero@suse.de>,
        <dan.carpenter@oracle.com>, <aaptel@suse.com>
CC:     <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <linux-kernel@vger.kernel.org>, YueHaibing <yuehaibing@huawei.com>
Subject: [PATCH] cifs: Fix inconsistent IS_ERR and PTR_ERR
Date:   Thu, 18 Feb 2021 17:28:12 +0800
Message-ID: <20210218092812.20004-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.10.2.windows.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.174.179.96]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Fix inconsistent IS_ERR and PTR_ERR in cifs_find_swn_reg(). The proper
pointer to be passed as argument to PTR_ERR() is share_name.

This bug was detected with the help of Coccinelle.

Fixes: bf80e5d4259a ("cifs: Send witness register and unregister commands to userspace daemon")
Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/cifs/cifs_swn.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifs_swn.c b/fs/cifs/cifs_swn.c
index d35f599aa00e..f2d730fffccb 100644
--- a/fs/cifs/cifs_swn.c
+++ b/fs/cifs/cifs_swn.c
@@ -272,7 +272,7 @@ static struct cifs_swn_reg *cifs_find_swn_reg(struct cifs_tcon *tcon)
 	if (IS_ERR(share_name)) {
 		int ret;
 
-		ret = PTR_ERR(net_name);
+		ret = PTR_ERR(share_name);
 		cifs_dbg(VFS, "%s: failed to extract share name from target '%s': %d\n",
 				__func__, tcon->treeName, ret);
 		kfree(net_name);
-- 
2.22.0

