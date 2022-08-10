Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9495C58E39D
	for <lists+linux-cifs@lfdr.de>; Wed, 10 Aug 2022 01:15:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229456AbiHIXPg (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 9 Aug 2022 19:15:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiHIXPg (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 9 Aug 2022 19:15:36 -0400
X-Greylist: delayed 1800 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 09 Aug 2022 16:15:33 PDT
Received: from lgeamrelo11.lge.com (lgeamrelo11.lge.com [156.147.23.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CED9017A88
        for <linux-cifs@vger.kernel.org>; Tue,  9 Aug 2022 16:15:33 -0700 (PDT)
Received: from unknown (HELO lgeamrelo04.lge.com) (156.147.1.127)
        by 156.147.23.51 with ESMTP; 10 Aug 2022 07:45:31 +0900
X-Original-SENDERIP: 156.147.1.127
X-Original-MAILFROM: hyc.lee@gmail.com
Received: from unknown (HELO localhost.localdomain) (10.177.245.62)
        by 156.147.1.127 with ESMTP; 10 Aug 2022 07:45:31 +0900
X-Original-SENDERIP: 10.177.245.62
X-Original-MAILFROM: hyc.lee@gmail.com
From:   Hyunchul Lee <hyc.lee@gmail.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <smfrench@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Subject: [PATCH] ksmbd: remove unnecessary generic_fillattr in smb2_open
Date:   Wed, 10 Aug 2022 07:45:22 +0900
Message-Id: <20220809224522.11725-1-hyc.lee@gmail.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_SOFTFAIL,SPOOFED_FREEMAIL,SPOOF_GMAIL_MID,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Move the call of ksmbd_vfs_getattr above the place
where stat is needed, and remove unnecessary
the call of generic_fillattr.

This patch fixes wrong AllocationSize of SMB2_CREATE
response because generic_fillattr does not reflect
i_blocks for delayed allocation.

Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
---
 fs/ksmbd/smb2pdu.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 9751cc92c111..d0a0256334ea 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -3042,12 +3042,6 @@ int smb2_open(struct ksmbd_work *work)
 	list_add(&fp->node, &fp->f_ci->m_fp_list);
 	write_unlock(&fp->f_ci->m_lock);
 
-	rc = ksmbd_vfs_getattr(&path, &stat);
-	if (rc) {
-		generic_fillattr(user_ns, d_inode(path.dentry), &stat);
-		rc = 0;
-	}
-
 	/* Check delete pending among previous fp before oplock break */
 	if (ksmbd_inode_pending_delete(fp)) {
 		rc = -EBUSY;
@@ -3134,6 +3128,12 @@ int smb2_open(struct ksmbd_work *work)
 		}
 	}
 
+	rc = ksmbd_vfs_getattr(&path, &stat);
+	if (rc) {
+		generic_fillattr(user_ns, d_inode(path.dentry), &stat);
+		rc = 0;
+	}
+
 	if (stat.result_mask & STATX_BTIME)
 		fp->create_time = ksmbd_UnixTimeToNT(stat.btime);
 	else
@@ -3149,9 +3149,6 @@ int smb2_open(struct ksmbd_work *work)
 
 	memcpy(fp->client_guid, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
 
-	generic_fillattr(user_ns, file_inode(fp->filp),
-			 &stat);
-
 	rsp->StructureSize = cpu_to_le16(89);
 	rcu_read_lock();
 	opinfo = rcu_dereference(fp->f_opinfo);
-- 
2.17.1

