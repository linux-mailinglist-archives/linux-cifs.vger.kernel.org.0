Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 26521388BEC
	for <lists+linux-cifs@lfdr.de>; Wed, 19 May 2021 12:47:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239519AbhESKsq (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 19 May 2021 06:48:46 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:38065 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232885AbhESKsp (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 19 May 2021 06:48:45 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04423;MF=jiapeng.chong@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0UZOsBLZ_1621421229;
Received: from j63c13417.sqa.eu95.tbsite.net(mailfrom:jiapeng.chong@linux.alibaba.com fp:SMTPD_---0UZOsBLZ_1621421229)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 19 May 2021 18:47:22 +0800
From:   Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
To:     sfrench@samba.org
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org,
        Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
Subject: [PATCH] cifs: Fix inconsistent indenting
Date:   Wed, 19 May 2021 18:47:07 +0800
Message-Id: <1621421227-34130-1-git-send-email-jiapeng.chong@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Eliminate the follow smatch warning:

fs/cifs/fs_context.c:1148 smb3_fs_context_parse_param() warn:
inconsistent indenting.

Reported-by: Abaci Robot <abaci@linux.alibaba.com>
Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
---
 fs/cifs/fs_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 5d21cd9..92d4ab0 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -1145,7 +1145,7 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
 		/* if iocharset not set then load_nls_default
 		 * is used by caller
 		 */
-		 cifs_dbg(FYI, "iocharset set to %s\n", ctx->iocharset);
+		cifs_dbg(FYI, "iocharset set to %s\n", ctx->iocharset);
 		break;
 	case Opt_netbiosname:
 		memset(ctx->source_rfc1001_name, 0x20,
-- 
1.8.3.1

