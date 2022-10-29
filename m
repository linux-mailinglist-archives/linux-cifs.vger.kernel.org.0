Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BE3A61212D
	for <lists+linux-cifs@lfdr.de>; Sat, 29 Oct 2022 09:55:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJ2Hzw (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 29 Oct 2022 03:55:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229670AbiJ2Hzo (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 29 Oct 2022 03:55:44 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8CF56DAE1
        for <linux-cifs@vger.kernel.org>; Sat, 29 Oct 2022 00:55:38 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Mzs8b5MRPzFqSX;
        Sat, 29 Oct 2022 15:52:47 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 29 Oct 2022 15:55:37 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <linux-cifs@vger.kernel.org>, <zhangxiaoxu5@huawei.com>,
        <sfrench@samba.org>, <smfrench@gmail.com>, <pc@cjr.nz>,
        <lsahlber@redhat.com>, <sprasad@microsoft.com>, <tom@talpey.com>
Subject: [PATCH v2 4/7] cifs: Remove the redundant null pointer check in SMB2_negotiate()
Date:   Sat, 29 Oct 2022 17:00:08 +0800
Message-ID: <20221029090011.79367-5-zhangxiaoxu5@huawei.com>
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

The smb2_negotiate() is the only caller of function SMB2_negotiate(),
and it's already ensure the server not null, so remove the redundant
nullptr check.

Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/cifs/smb2pdu.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 5cda7f029b60..11643fb25347 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -846,11 +846,6 @@ SMB2_negotiate(const unsigned int xid,
 
 	cifs_dbg(FYI, "Negotiate protocol\n");
 
-	if (!server) {
-		WARN(1, "%s: server is NULL!\n", __func__);
-		return -EIO;
-	}
-
 	rc = smb2_plain_req_init(SMB2_NEGOTIATE, NULL, server,
 				 (void **) &req, &total_len);
 	if (rc)
-- 
2.31.1

