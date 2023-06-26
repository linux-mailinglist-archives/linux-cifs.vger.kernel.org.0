Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2523473D697
	for <lists+linux-cifs@lfdr.de>; Mon, 26 Jun 2023 05:43:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjFZDnd (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 25 Jun 2023 23:43:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFZDnc (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 25 Jun 2023 23:43:32 -0400
Received: from smtpbgsg1.qq.com (smtpbgsg1.qq.com [54.254.200.92])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFDD188
        for <linux-cifs@vger.kernel.org>; Sun, 25 Jun 2023 20:43:29 -0700 (PDT)
X-QQ-mid: bizesmtp77t1687751000twxojzaf
Received: from localhost.localdomain ( [113.57.152.160])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Mon, 26 Jun 2023 11:43:20 +0800 (CST)
X-QQ-SSF: 01400000000000F0H000000A0000000
X-QQ-FEAT: XBN7tc9DADKXxs760OAG1jn2ehVU5Z3/jKnXCrlsBDF7h33YVS5Sxvemp2c3w
        5PB7PbsDeOExDxk/PjBagHOaqXCV0zLNq2sXXxGmtayjUVusidc6M2PEE5Js6JTuzlPgdYO
        QQRiQ/YCo3+vPMhaj98qrySkOLIhCauDC3c5P9OURY0r5p+Ex6tWbHpYOYEs42isRbdJkBQ
        tRLGQeZf2uuSv+Go9e/nyiAr4za0Do5LU4cOHEZ2YPH4QoEO5fl9QtmSk1RFUFUcPb3z4JI
        DMaE7rdq1HhT5m1bt+8GYpeyJGyBj8yZ+M7RtTYYtoq9SQKLv+eDe/XjY4gUI4+net1F0J6
        hrAhrHYOB36FI6FJTuMe5AHKeUm4Cy+FUW/Zx8uVT9POeMLyhm4pvjoBj+x5m3fmv+Fg4Pm
        gF1haFLdKaE6IsIWinodRA==
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 3740028053831755796
From:   Winston Wen <wentao@uniontech.com>
To:     sfrench@samba.org, linux-cifs@vger.kernel.org, pc@manguebit.com,
        sprasad@microsoft.com
Cc:     Winston Wen <wentao@uniontech.com>
Subject: [PATCH 2/3] cifs: fix session state check in reconnect to avoid use-after-free issue
Date:   Mon, 26 Jun 2023 11:42:56 +0800
Message-Id: <20230626034257.2078391-3-wentao@uniontech.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230626034257.2078391-1-wentao@uniontech.com>
References: <20230626034257.2078391-1-wentao@uniontech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:uniontech.com:qybglogicsvrgz:qybglogicsvrgz6a-1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Don't collect exiting session in smb2_reconnect_server(), because it
will be released soon.

Note that the exiting session will stay in server->smb_ses_list until
it complete the cifs_free_ipc() and logoff() and then delete itself
from the list.

Signed-off-by: Winston Wen <wentao@uniontech.com>
---
 fs/smb/client/smb2pdu.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 17fe212ab895..e04766fe6f80 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -3797,6 +3797,12 @@ void smb2_reconnect_server(struct work_struct *work)
 
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry(ses, &pserver->smb_ses_list, smb_ses_list) {
+		spin_lock(&ses->ses_lock);
+		if (ses->ses_status == SES_EXITING) {
+			spin_unlock(&ses->ses_lock);
+			continue;
+		}
+		spin_unlock(&ses->ses_lock);
 
 		tcon_selected = false;
 
-- 
2.40.1

