Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE941359692
	for <lists+linux-cifs@lfdr.de>; Fri,  9 Apr 2021 09:41:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231496AbhDIHl1 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 9 Apr 2021 03:41:27 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:16429 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbhDIHl0 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 9 Apr 2021 03:41:26 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.58])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FGqlB5r3ZzlWFc;
        Fri,  9 Apr 2021 15:39:18 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 DGGEMS407-HUB.china.huawei.com (10.3.19.207) with Microsoft SMTP Server id
 14.3.498.0; Fri, 9 Apr 2021 15:40:59 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <zhangxiaoxu5@huawei.com>, <sfrench@samba.org>,
        <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <yukuai3@huawei.com>, <sprasad@microsoft.com>
Subject: [PATCH] cifs: Fix build error when no CONFIG_DNS_RESOLVER
Date:   Fri, 9 Apr 2021 03:46:34 -0400
Message-ID: <20210409074634.1809521-1-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

hulk robot following build error:
  ld: fs/cifs/dns_resolve.o: in function `dns_resolve_server_name_to_ip':
  dns_resolve.c:(.text+0x154): undefined reference to `dns_query'
  make: *** [Makefile:1251: vmlinux] Error 1

Fixes: e488292a31fa ("cifs: On cifs_reconnect, resolve the hostname again.")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/cifs/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/Kconfig b/fs/cifs/Kconfig
index fe03cbdae959..0d8199765045 100644
--- a/fs/cifs/Kconfig
+++ b/fs/cifs/Kconfig
@@ -18,6 +18,7 @@ config CIFS
 	select CRYPTO_AES
 	select CRYPTO_LIB_DES
 	select KEYS
+	select DNS_RESOLVER
 	help
 	  This is the client VFS module for the SMB3 family of NAS protocols,
 	  (including support for the most recent, most secure dialect SMB3.1.1)
@@ -179,7 +180,6 @@ config CIFS_DEBUG_DUMP_KEYS
 config CIFS_DFS_UPCALL
 	bool "DFS feature support"
 	depends on CIFS
-	select DNS_RESOLVER
 	help
 	  Distributed File System (DFS) support is used to access shares
 	  transparently in an enterprise name space, even if the share
-- 
2.25.4

