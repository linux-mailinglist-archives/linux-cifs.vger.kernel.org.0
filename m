Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80EBD5E8B2C
	for <lists+linux-cifs@lfdr.de>; Sat, 24 Sep 2022 11:52:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233463AbiIXJwQ (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 24 Sep 2022 05:52:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbiIXJwO (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 24 Sep 2022 05:52:14 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FE4BAF0D5
        for <linux-cifs@vger.kernel.org>; Sat, 24 Sep 2022 02:52:13 -0700 (PDT)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.53])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4MZPMj0SLnz1P6sP;
        Sat, 24 Sep 2022 17:48:01 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sat, 24 Sep 2022 17:52:11 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <linux-cifs@vger.kernel.org>, <zhangxiaoxu5@huawei.com>,
        <sfrench@samba.org>, <pc@cjr.nz>, <lsahlber@redhat.com>,
        <sprasad@microsoft.com>, <rohiths@microsoft.com>,
        <smfrench@gmail.com>, <tom@talpey.com>, <linkinjeon@kernel.org>,
        <hyc.lee@gmail.com>
Subject: [PATCH v7 3/3] cifs: Refactor dialects in validate_negotiate_info_req to variable array
Date:   Sat, 24 Sep 2022 18:52:55 +0800
Message-ID: <20220924105255.336399-4-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20220924105255.336399-1-zhangxiaoxu5@huawei.com>
References: <20220924105255.336399-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The length of the message FSCTL_VALIDATE_NEGOTIATE_INFO is
depends on the count of the dialects, redefine the dialects
to variable array.

Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/cifs/smb2pdu.c         | 94 ++++++++++++++++++---------------------
 fs/smbfs_common/smb2pdu.h |  3 +-
 2 files changed, 45 insertions(+), 52 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 90ccac18f9f3..d0340af845e9 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -847,6 +847,41 @@ add_posix_context(struct kvec *iov, unsigned int *num_iovec, umode_t mode)
 	return 0;
 }
 
+static int neg_dialect_cnt(struct TCP_Server_Info *server)
+{
+	if (!strcmp(server->vals->version_string,
+		    SMB3ANY_VERSION_STRING))
+		return 3;
+	else if (!strcmp(server->vals->version_string,
+			 SMBDEFAULT_VERSION_STRING))
+		return 4;
+
+	/* otherwise specific dialect was requested */
+	return 1;
+}
+
+static int
+build_neg_dialects(struct TCP_Server_Info *server, __le16 *dialects)
+{
+	if (!strcmp(server->vals->version_string,
+		    SMB3ANY_VERSION_STRING)) {
+		dialects[0] = cpu_to_le16(SMB30_PROT_ID);
+		dialects[1] = cpu_to_le16(SMB302_PROT_ID);
+		dialects[2] = cpu_to_le16(SMB311_PROT_ID);
+		return 3;
+	} else if (!strcmp(server->vals->version_string,
+			   SMBDEFAULT_VERSION_STRING)) {
+		dialects[0] = cpu_to_le16(SMB21_PROT_ID);
+		dialects[1] = cpu_to_le16(SMB30_PROT_ID);
+		dialects[2] = cpu_to_le16(SMB302_PROT_ID);
+		dialects[3] = cpu_to_le16(SMB311_PROT_ID);
+		return 4;
+	}
+
+	/* otherwise specific dialect was requested */
+	dialects[0] = cpu_to_le16(server->vals->protocol_id);
+	return 1;
+}
 
 /*
  *
@@ -897,27 +932,9 @@ SMB2_negotiate(const unsigned int xid,
 	memset(server->preauth_sha_hash, 0, SMB2_PREAUTH_HASH_SIZE);
 	memset(ses->preauth_sha_hash, 0, SMB2_PREAUTH_HASH_SIZE);
 
-	if (strcmp(server->vals->version_string,
-		   SMB3ANY_VERSION_STRING) == 0) {
-		req->Dialects[0] = cpu_to_le16(SMB30_PROT_ID);
-		req->Dialects[1] = cpu_to_le16(SMB302_PROT_ID);
-		req->Dialects[2] = cpu_to_le16(SMB311_PROT_ID);
-		req->DialectCount = cpu_to_le16(3);
-		total_len += 6;
-	} else if (strcmp(server->vals->version_string,
-		   SMBDEFAULT_VERSION_STRING) == 0) {
-		req->Dialects[0] = cpu_to_le16(SMB21_PROT_ID);
-		req->Dialects[1] = cpu_to_le16(SMB30_PROT_ID);
-		req->Dialects[2] = cpu_to_le16(SMB302_PROT_ID);
-		req->Dialects[3] = cpu_to_le16(SMB311_PROT_ID);
-		req->DialectCount = cpu_to_le16(4);
-		total_len += 8;
-	} else {
-		/* otherwise send specific dialect */
-		req->Dialects[0] = cpu_to_le16(server->vals->protocol_id);
-		req->DialectCount = cpu_to_le16(1);
-		total_len += 2;
-	}
+	rc = build_neg_dialects(server, req->Dialects);
+	req->DialectCount = cpu_to_le16(rc);
+	total_len += rc * sizeof(req->Dialects[0]);
 
 	/* only one of SMB2 signing flags may be set in SMB2 request */
 	if (ses->sign)
@@ -1124,7 +1141,10 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 	if (tcon->ses->session_flags & SMB2_SESSION_FLAG_IS_NULL)
 		cifs_tcon_dbg(VFS, "Unexpected null user (anonymous) auth flag sent by server\n");
 
-	pneg_inbuf = kmalloc(sizeof(*pneg_inbuf), GFP_NOFS);
+	inbuflen = sizeof(*pneg_inbuf) +
+			sizeof(__le16) * neg_dialect_cnt(server);
+
+	pneg_inbuf = kmalloc(inbuflen, GFP_NOFS);
 	if (!pneg_inbuf)
 		return -ENOMEM;
 
@@ -1145,34 +1165,8 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 	else
 		pneg_inbuf->SecurityMode = 0;
 
-
-	if (strcmp(server->vals->version_string,
-		SMB3ANY_VERSION_STRING) == 0) {
-		pneg_inbuf->Dialects[0] = cpu_to_le16(SMB30_PROT_ID);
-		pneg_inbuf->Dialects[1] = cpu_to_le16(SMB302_PROT_ID);
-		pneg_inbuf->Dialects[2] = cpu_to_le16(SMB311_PROT_ID);
-		pneg_inbuf->DialectCount = cpu_to_le16(3);
-		/* SMB 2.1 not included so subtract one dialect from len */
-		inbuflen = sizeof(*pneg_inbuf) -
-				(sizeof(pneg_inbuf->Dialects[0]));
-	} else if (strcmp(server->vals->version_string,
-		SMBDEFAULT_VERSION_STRING) == 0) {
-		pneg_inbuf->Dialects[0] = cpu_to_le16(SMB21_PROT_ID);
-		pneg_inbuf->Dialects[1] = cpu_to_le16(SMB30_PROT_ID);
-		pneg_inbuf->Dialects[2] = cpu_to_le16(SMB302_PROT_ID);
-		pneg_inbuf->Dialects[3] = cpu_to_le16(SMB311_PROT_ID);
-		pneg_inbuf->DialectCount = cpu_to_le16(4);
-		/* structure is big enough for 4 dialects */
-		inbuflen = sizeof(*pneg_inbuf);
-	} else {
-		/* otherwise specific dialect was requested */
-		pneg_inbuf->Dialects[0] =
-			cpu_to_le16(server->vals->protocol_id);
-		pneg_inbuf->DialectCount = cpu_to_le16(1);
-		/* structure is big enough for 4 dialects, sending only 1 */
-		inbuflen = sizeof(*pneg_inbuf) -
-				sizeof(pneg_inbuf->Dialects[0]) * 3;
-	}
+	rc = build_neg_dialects(server, pneg_inbuf->Dialects);
+	pneg_inbuf->DialectCount = cpu_to_le16(rc);
 
 	rc = SMB2_ioctl(xid, tcon, NO_FILE_ID, NO_FILE_ID,
 		FSCTL_VALIDATE_NEGOTIATE_INFO,
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

