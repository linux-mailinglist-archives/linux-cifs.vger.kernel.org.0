Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CD037BAE35
	for <lists+linux-cifs@lfdr.de>; Mon, 23 Sep 2019 08:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393357AbfIWG7h (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 23 Sep 2019 02:59:37 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2707 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2393326AbfIWG7g (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 23 Sep 2019 02:59:36 -0400
Received: from DGGEMS401-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6EFC1AF3732FF94A9824
        for <linux-cifs@vger.kernel.org>; Mon, 23 Sep 2019 14:59:33 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS401-HUB.china.huawei.com
 (10.3.19.201) with Microsoft SMTP Server id 14.3.439.0; Mon, 23 Sep 2019
 14:59:24 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <smfrench@gmail.com>, <linux-cifs@vger.kernel.org>
CC:     <yi.zhang@huawei.com>, <zhengbin13@huawei.com>
Subject: [PATCH] fs/cifs/smb2pdu.c: Make SMB2_notify_init static
Date:   Mon, 23 Sep 2019 15:06:18 +0800
Message-ID: <1569222378-22693-1-git-send-email-zhengbin13@huawei.com>
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

fs/cifs/smb2pdu.c:3200:1: warning: symbol 'SMB2_notify_init' was not declared. Should it be static?

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/cifs/smb2pdu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 8bcb278..5e87872 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3200,7 +3200,7 @@ SMB2_get_srv_num(const unsigned int xid, struct cifs_tcon *tcon,
  * See MS-SMB2 2.2.35 and 2.2.36
  */

-int
+static int
 SMB2_notify_init(const unsigned int xid, struct smb_rqst *rqst,
 		struct cifs_tcon *tcon, u64 persistent_fid, u64 volatile_fid,
 		u32 completion_filter, bool watch_tree)
--
2.7.4

