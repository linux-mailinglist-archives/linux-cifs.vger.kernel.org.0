Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABF8BBFDF
	for <lists+linux-cifs@lfdr.de>; Tue, 24 Sep 2019 04:07:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388704AbfIXCHA (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 23 Sep 2019 22:07:00 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:2709 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729136AbfIXCHA (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 23 Sep 2019 22:07:00 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id DEF3F643F7FD1C187B77
        for <linux-cifs@vger.kernel.org>; Tue, 24 Sep 2019 10:06:58 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Tue, 24 Sep 2019
 10:06:53 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <smfrench@gmail.com>, <linux-cifs@vger.kernel.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH] fs/cifs/sess.c: Remove set but not used variable 'capabilities'
Date:   Tue, 24 Sep 2019 10:13:47 +0800
Message-ID: <1569291227-51027-1-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Fixes gcc '-Wunused-but-set-variable' warning:

fs/cifs/sess.c: In function sess_auth_lanman:
fs/cifs/sess.c:910:8: warning: variable capabilities set but not used [-Wunused-but-set-variable]

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/cifs/sess.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index 20c73a4..82e29f8 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -910,7 +910,6 @@ sess_auth_lanman(struct sess_data *sess_data)
 	char *bcc_ptr;
 	struct cifs_ses *ses = sess_data->ses;
 	char lnm_session_key[CIFS_AUTH_RESP_SIZE];
-	__u32 capabilities;
 	__u16 bytes_remaining;

 	/* lanman 2 style sessionsetup */
@@ -921,7 +920,7 @@ sess_auth_lanman(struct sess_data *sess_data)

 	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
 	bcc_ptr = sess_data->iov[2].iov_base;
-	capabilities = cifs_ssetup_hdr(ses, pSMB);
+	(void)cifs_ssetup_hdr(ses, pSMB);

 	pSMB->req.hdr.Flags2 &= ~SMBFLG2_UNICODE;

--
2.7.4

