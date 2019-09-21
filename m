Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 225DFB9C8F
	for <lists+linux-cifs@lfdr.de>; Sat, 21 Sep 2019 08:16:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730993AbfIUGQI (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 21 Sep 2019 02:16:08 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:34386 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730989AbfIUGQI (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sat, 21 Sep 2019 02:16:08 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3346F1E69AA13AFB05E9;
        Sat, 21 Sep 2019 14:16:01 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.439.0; Sat, 21 Sep 2019
 14:15:52 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <sfrench@samba.org>, <linux-cifs@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] fs/cifs/smb2transport.c: Make some functions static
Date:   Sat, 21 Sep 2019 14:22:46 +0800
Message-ID: <1569046966-118677-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Fix sparse warnings:

fs/cifs/smb2transport.c:52:1: warning: symbol 'smb3_crypto_shash_allocate' was not declared. Should it be static?
fs/cifs/smb2transport.c:101:4: warning: symbol 'smb2_find_chan_signkey' was not declared. Should it be static?
fs/cifs/smb2transport.c:121:17: warning: symbol 'smb2_find_global_smb_ses' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/cifs/smb2transport.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/smb2transport.c b/fs/cifs/smb2transport.c
index 12988df..7cc8641 100644
--- a/fs/cifs/smb2transport.c
+++ b/fs/cifs/smb2transport.c
@@ -48,7 +48,7 @@ smb2_crypto_shash_allocate(struct TCP_Server_Info *server)
 			       &server->secmech.sdeschmacsha256);
 }

-int
+static int
 smb3_crypto_shash_allocate(struct TCP_Server_Info *server)
 {
 	struct cifs_secmech *p = &server->secmech;
@@ -98,7 +98,8 @@ smb311_crypto_shash_allocate(struct TCP_Server_Info *server)
 	return rc;
 }

-u8 *smb2_find_chan_signkey(struct cifs_ses *ses, struct TCP_Server_Info *server)
+static u8 *
+smb2_find_chan_signkey(struct cifs_ses *ses, struct TCP_Server_Info *server)
 {
 	int i;
 	struct cifs_chan *chan;
@@ -118,7 +119,7 @@ u8 *smb2_find_chan_signkey(struct cifs_ses *ses, struct TCP_Server_Info *server)
 	return NULL;
 }

-struct cifs_ses *
+static struct cifs_ses *
 smb2_find_global_smb_ses(__u64 ses_id)
 {
 	struct TCP_Server_Info *server;
--
2.7.4

