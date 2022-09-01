Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75FC85A9871
	for <lists+linux-cifs@lfdr.de>; Thu,  1 Sep 2022 15:23:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiIANXd (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 1 Sep 2022 09:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233919AbiIANXL (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 1 Sep 2022 09:23:11 -0400
Received: from dggsgout11.his.huawei.com (unknown [45.249.212.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBD0110D3
        for <linux-cifs@vger.kernel.org>; Thu,  1 Sep 2022 06:23:09 -0700 (PDT)
Received: from mail02.huawei.com (unknown [172.30.67.169])
        by dggsgout11.his.huawei.com (SkyGuard) with ESMTP id 4MJMBr71MHzlDpP
        for <linux-cifs@vger.kernel.org>; Thu,  1 Sep 2022 21:21:40 +0800 (CST)
Received: from huaweicloud.com (unknown [10.175.104.170])
        by APP1 (Coremail) with SMTP id cCh0CgCnei41shBjzFjeAA--.29386S9;
        Thu, 01 Sep 2022 21:23:07 +0800 (CST)
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     linux-cifs@vger.kernel.org, zhangxiaoxu5@huawei.com,
        sfrench@samba.org, pc@cjr.nz, lsahlber@redhat.com,
        sprasad@microsoft.com, rohiths@microsoft.com, smfrench@gmail.com,
        tom@talpey.com, linkinjeon@kernel.org, hyc.lee@gmail.com
Subject: [PATCH v4 5/5] cifs: Refactor dialects in validate_negotiate_info_req to variable array
Date:   Thu,  1 Sep 2022 22:24:13 +0800
Message-Id: <20220901142413.3351804-6-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220901142413.3351804-1-zhangxiaoxu5@huawei.com>
References: <20220901142413.3351804-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgCnei41shBjzFjeAA--.29386S9
X-Coremail-Antispam: 1UD129KBjvJXoWxAF17tFy7XF4ruw4fJw43KFg_yoW5XFyUpr
        9agFn7GFZ3Jr1xur10yrn8Wa4Fgwn5Wr1jkr4DG34SqF9a9r4Uu3ZYy3s8Ww1FkayDAr40
        qw4vva12yay5AaDanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
        9KBjDU0xBIdaVrnRJUUUmKb4IE77IF4wAFF20E14v26rWj6s0DM7CY07I20VC2zVCF04k2
        6cxKx2IYs7xG6r106r1rM7CIcVAFz4kK6r1j6r18M28IrcIa0xkI8VA2jI8067AKxVWUAV
        Cq3wA2048vs2IY020Ec7CjxVAFwI0_Xr0E3s1l8cAvFVAK0II2c7xJM28CjxkF64kEwVA0
        rcxSw2x7M28EF7xvwVC0I7IYx2IY67AKxVWDJVCq3wA2z4x0Y4vE2Ix0cI8IcVCY1x0267
        AKxVW8Jr0_Cr1UM28EF7xvwVC2z280aVAFwI0_GcCE3s1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26rxl6s0DM2AIxVAIcxkEcVAq07x20xvEncxIr21l5I8CrVACY4xI64kE6c02F40Ex7
        xfMcIj6xIIjxv20xvE14v26r1Y6r17McIj6I8E87Iv67AKxVWUJVW8JwAm72CE4IkC6x0Y
        z7v_Jr0_Gr1lF7xvr2IYc2Ij64vIr41lFIxGxcIEc7CjxVA2Y2ka0xkIwI1lc7CjxVAaw2
        AFwI0_Jw0_GFyl42xK82IYc2Ij64vIr41l42xK82IY64kExVAvwVAq07x20xyl4I8I3I0E
        4IkC6x0Yz7v_Jr0_Gr1lx2IqxVAqx4xG67AKxVWUJVWUGwC20s026x8GjcxK67AKxVWUGV
        WUWwC2zVAF1VAY17CE14v26r1q6r43MIIYrxkI7VAKI48JMIIF0xvE2Ix0cI8IcVAFwI0_
        Gr0_Xr1lIxAIcVC0I7IYx2IY6xkF7I0E14v26r4UJVWxJr1lIxAIcVCF04k26cxKx2IYs7
        xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7CjxVAFwI0_Gr1j
        6F4UJbIYCTnIWIevJa73UjIFyTuYvjxUrMKZDUUUU
Sender: zhangxiaoxu@huaweicloud.com
X-CM-SenderInfo: x2kd0wp0ld053x6k3tpzhluzxrxghudrp/
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The length of the message FSCTL_VALIDATE_NEGOTIATE_INFO is
depends on the count of the dialects, the dialects count is
depending on the smb version, so the dialects should be
variable array.

Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/cifs/smb2pdu.c         | 7 ++++---
 fs/ksmbd/smb2pdu.c        | 2 +-
 fs/smbfs_common/smb2pdu.h | 3 +--
 3 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 1fbb8ccf1ff6..82cd21c26c60 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1105,7 +1105,10 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 	if (tcon->ses->session_flags & SMB2_SESSION_FLAG_IS_NULL)
 		cifs_tcon_dbg(VFS, "Unexpected null user (anonymous) auth flag sent by server\n");
 
-	pneg_inbuf = kmalloc(sizeof(*pneg_inbuf), GFP_NOFS);
+	inbuflen = sizeof(*pneg_inbuf) +
+			sizeof(__le16) * server->vals->neg_dialect_cnt;
+
+	pneg_inbuf = kmalloc(inbuflen, GFP_NOFS);
 	if (!pneg_inbuf)
 		return -ENOMEM;
 
@@ -1129,8 +1132,6 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 	pneg_inbuf->DialectCount = cpu_to_le16(server->vals->neg_dialect_cnt);
 	memcpy(pneg_inbuf->Dialects, server->vals->neg_dialects,
 		server->vals->neg_dialect_cnt * sizeof(__le16));
-	inbuflen = offsetof(struct validate_negotiate_info_req, Dialects) +
-		sizeof(pneg_inbuf->Dialects[0]) * server->vals->neg_dialect_cnt;
 
 	rc = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
 		FSCTL_VALIDATE_NEGOTIATE_INFO,
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 7da0ec466887..52a524fd2f3b 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -7392,7 +7392,7 @@ static int fsctl_validate_negotiate_info(struct ksmbd_conn *conn,
 	int ret = 0;
 	int dialect;
 
-	if (in_buf_len < offsetof(struct validate_negotiate_info_req, Dialects) +
+	if (in_buf_len < sizeof(*neg_req) +
 			le16_to_cpu(neg_req->DialectCount) * sizeof(__le16))
 		return -EINVAL;
 
diff --git a/fs/smbfs_common/smb2pdu.h b/fs/smbfs_common/smb2pdu.h
index 2cab413fffee..4780c72e9b3a 100644
--- a/fs/smbfs_common/smb2pdu.h
+++ b/fs/smbfs_common/smb2pdu.h
@@ -1388,13 +1388,12 @@ struct reparse_symlink_data_buffer {
 } __packed;
 
 /* See MS-FSCC 2.1.2.6 and cifspdu.h for struct reparse_posix_data */
-
 struct validate_negotiate_info_req {
 	__le32 Capabilities;
 	__u8   Guid[SMB2_CLIENT_GUID_SIZE];
 	__le16 SecurityMode;
 	__le16 DialectCount;
-	__le16 Dialects[4]; /* BB expand this if autonegotiate > 4 dialects */
+	__le16 Dialects[];
 } __packed;
 
 struct validate_negotiate_info_rsp {
-- 
2.31.1

