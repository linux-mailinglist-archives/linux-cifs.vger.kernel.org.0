Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D105E40225D
	for <lists+linux-cifs@lfdr.de>; Tue,  7 Sep 2021 05:02:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229454AbhIGC5g (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 6 Sep 2021 22:57:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:60574 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233003AbhIGC5f (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 6 Sep 2021 22:57:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1630983389;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Oz0sPbdx0oOGQj/07ggP/9zRK6ddyG5S8Noa7GaZWyg=;
        b=YbrQP3yGBVETt3u42fSlHlKKQyuOyBTVui8OHUEkRlLK239/TC3v9kmXlABepeJhk8XOV6
        qFp47Axa8Lq5Th5OXal8IJR3oq8kyQWfnUhBd7A7UJHFdcXJWUzeqNP8ChMmdi6mQbKYmL
        26zsuoDMX0YvfyixGtu+mZWxo/TWEVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-5FRAVGmcO3mzMvqQxkFiZg-1; Mon, 06 Sep 2021 22:56:28 -0400
X-MC-Unique: 5FRAVGmcO3mzMvqQxkFiZg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 79CCC188353C;
        Tue,  7 Sep 2021 02:56:27 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-114.bne.redhat.com [10.64.54.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 562E9369A;
        Tue,  7 Sep 2021 02:56:26 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: [PATCH 4/4] ksmbd: use the common definitions for NEGOTIATE_PROTOCOL
Date:   Tue,  7 Sep 2021 12:56:09 +1000
Message-Id: <20210907025609.2071373-4-lsahlber@redhat.com>
In-Reply-To: <20210907025609.2071373-1-lsahlber@redhat.com>
References: <20210907025609.2071373-1-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/ksmbd/smb2ops.c    |   8 +--
 fs/ksmbd/smb2pdu.c    |  20 +++---
 fs/ksmbd/smb2pdu.h    | 143 +-----------------------------------------
 fs/ksmbd/smb_common.h |  11 ----
 4 files changed, 15 insertions(+), 167 deletions(-)

diff --git a/fs/ksmbd/smb2ops.c b/fs/ksmbd/smb2ops.c
index 7b7801d9b2b8..d089645efe96 100644
--- a/fs/ksmbd/smb2ops.c
+++ b/fs/ksmbd/smb2ops.c
@@ -203,7 +203,7 @@ void init_smb2_1_server(struct ksmbd_conn *conn)
 	conn->cmds = smb2_0_server_cmds;
 	conn->max_cmds = ARRAY_SIZE(smb2_0_server_cmds);
 	conn->max_credits = SMB2_MAX_CREDITS;
-	conn->signing_algorithm = SIGNING_ALG_HMAC_SHA256;
+	conn->signing_algorithm = SIGNING_ALG_HMAC_SHA256_LE;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
@@ -221,7 +221,7 @@ void init_smb3_0_server(struct ksmbd_conn *conn)
 	conn->cmds = smb2_0_server_cmds;
 	conn->max_cmds = ARRAY_SIZE(smb2_0_server_cmds);
 	conn->max_credits = SMB2_MAX_CREDITS;
-	conn->signing_algorithm = SIGNING_ALG_AES_CMAC;
+	conn->signing_algorithm = SIGNING_ALG_AES_CMAC_LE;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
@@ -246,7 +246,7 @@ void init_smb3_02_server(struct ksmbd_conn *conn)
 	conn->cmds = smb2_0_server_cmds;
 	conn->max_cmds = ARRAY_SIZE(smb2_0_server_cmds);
 	conn->max_credits = SMB2_MAX_CREDITS;
-	conn->signing_algorithm = SIGNING_ALG_AES_CMAC;
+	conn->signing_algorithm = SIGNING_ALG_AES_CMAC_LE;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
@@ -271,7 +271,7 @@ int init_smb3_11_server(struct ksmbd_conn *conn)
 	conn->cmds = smb2_0_server_cmds;
 	conn->max_cmds = ARRAY_SIZE(smb2_0_server_cmds);
 	conn->max_credits = SMB2_MAX_CREDITS;
-	conn->signing_algorithm = SIGNING_ALG_AES_CMAC;
+	conn->signing_algorithm = SIGNING_ALG_AES_CMAC_LE;
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB2_LEASES)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_LEASING;
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 87a041d6a0c1..c0adfb9b6248 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -771,16 +771,16 @@ static void build_encrypt_ctxt(struct smb2_encryption_neg_context *pneg_ctxt,
 	pneg_ctxt->Ciphers[0] = cipher_type;
 }
 
-static void build_compression_ctxt(struct smb2_compression_ctx *pneg_ctxt,
+static void build_compression_ctxt(struct smb2_compression_capabilities_context *pneg_ctxt,
 				   __le16 comp_algo)
 {
 	pneg_ctxt->ContextType = SMB2_COMPRESSION_CAPABILITIES;
 	pneg_ctxt->DataLength =
-		cpu_to_le16(sizeof(struct smb2_compression_ctx)
+		cpu_to_le16(sizeof(struct smb2_compression_capabilities_context)
 			- sizeof(struct smb2_neg_context));
 	pneg_ctxt->Reserved = cpu_to_le32(0);
 	pneg_ctxt->CompressionAlgorithmCount = cpu_to_le16(1);
-	pneg_ctxt->Reserved1 = cpu_to_le32(0);
+	pneg_ctxt->Flags = cpu_to_le32(0);
 	pneg_ctxt->CompressionAlgorithms[0] = comp_algo;
 }
 
@@ -857,12 +857,12 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 		ksmbd_debug(SMB,
 			    "assemble SMB2_COMPRESSION_CAPABILITIES context\n");
 		/* Temporarily set to SMB3_COMPRESS_NONE */
-		build_compression_ctxt((struct smb2_compression_ctx *)pneg_ctxt,
+		build_compression_ctxt((struct smb2_compression_capabilities_context *)pneg_ctxt,
 				       conn->compress_algorithm);
 		rsp->NegotiateContextCount = cpu_to_le16(++neg_ctxt_cnt);
-		ctxt_size += sizeof(struct smb2_compression_ctx) + 2;
+		ctxt_size += sizeof(struct smb2_compression_capabilities_context) + 2;
 		/* Round to 8 byte boundary */
-		pneg_ctxt += round_up(sizeof(struct smb2_compression_ctx) + 2,
+		pneg_ctxt += round_up(sizeof(struct smb2_compression_capabilities_context) + 2,
 				      8);
 	}
 
@@ -936,7 +936,7 @@ static void decode_encrypt_ctxt(struct ksmbd_conn *conn,
 }
 
 static void decode_compress_ctxt(struct ksmbd_conn *conn,
-				 struct smb2_compression_ctx *pneg_ctxt)
+				 struct smb2_compression_capabilities_context *pneg_ctxt)
 {
 	conn->compress_algorithm = SMB3_COMPRESS_NONE;
 }
@@ -957,8 +957,8 @@ static void decode_sign_cap_ctxt(struct ksmbd_conn *conn,
 	}
 
 	for (i = 0; i < sign_algo_cnt; i++) {
-		if (pneg_ctxt->SigningAlgorithms[i] == SIGNING_ALG_HMAC_SHA256 ||
-		    pneg_ctxt->SigningAlgorithms[i] == SIGNING_ALG_AES_CMAC) {
+		if (pneg_ctxt->SigningAlgorithms[i] == SIGNING_ALG_HMAC_SHA256_LE ||
+		    pneg_ctxt->SigningAlgorithms[i] == SIGNING_ALG_AES_CMAC_LE) {
 			ksmbd_debug(SMB, "Signing Algorithm ID = 0x%x\n",
 				    pneg_ctxt->SigningAlgorithms[i]);
 			conn->signing_negotiated = true;
@@ -1029,7 +1029,7 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 				break;
 
 			decode_compress_ctxt(conn,
-					     (struct smb2_compression_ctx *)pctx);
+					     (struct smb2_compression_capabilities_context *)pctx);
 		} else if (pctx->ContextType == SMB2_NETNAME_NEGOTIATE_CONTEXT_ID) {
 			ksmbd_debug(SMB,
 				    "deassemble SMB2_NETNAME_NEGOTIATE_CONTEXT_ID context\n");
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index 71d1411d97d9..b941c0ee6c67 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -42,9 +42,6 @@
 /* SMB2 Max Credits */
 #define SMB2_MAX_CREDITS		8192
 
-#define SMB2_CLIENT_GUID_SIZE		16
-#define SMB2_CREATE_GUID_SIZE		16
-
 /* Maximum buffer size value we can send with 1 credit */
 #define SMB2_MAX_BUFFER_SIZE 65536
 
@@ -78,48 +75,11 @@ struct smb2_err_rsp {
 	__u8   ErrorData[1];  /* variable length */
 } __packed;
 
-struct smb2_negotiate_req {
-	struct smb2_hdr hdr;
-	__le16 StructureSize; /* Must be 36 */
-	__le16 DialectCount;
-	__le16 SecurityMode;
-	__le16 Reserved;	/* MBZ */
-	__le32 Capabilities;
-	__u8   ClientGUID[SMB2_CLIENT_GUID_SIZE];
-	/* In SMB3.02 and earlier next three were MBZ le64 ClientStartTime */
-	__le32 NegotiateContextOffset; /* SMB3.1.1 only. MBZ earlier */
-	__le16 NegotiateContextCount;  /* SMB3.1.1 only. MBZ earlier */
-	__le16 Reserved2;
-	__le16 Dialects[1]; /* One dialect (vers=) at a time for now */
-} __packed;
-
-/* SecurityMode flags */
-#define SMB2_NEGOTIATE_SIGNING_ENABLED_LE	cpu_to_le16(0x0001)
-#define SMB2_NEGOTIATE_SIGNING_REQUIRED		0x0002
-#define SMB2_NEGOTIATE_SIGNING_REQUIRED_LE	cpu_to_le16(0x0002)
-/* Capabilities flags */
-#define SMB2_GLOBAL_CAP_DFS		0x00000001
-#define SMB2_GLOBAL_CAP_LEASING		0x00000002 /* Resp only New to SMB2.1 */
-#define SMB2_GLOBAL_CAP_LARGE_MTU	0X00000004 /* Resp only New to SMB2.1 */
-#define SMB2_GLOBAL_CAP_MULTI_CHANNEL	0x00000008 /* New to SMB3 */
-#define SMB2_GLOBAL_CAP_PERSISTENT_HANDLES 0x00000010 /* New to SMB3 */
-#define SMB2_GLOBAL_CAP_DIRECTORY_LEASING  0x00000020 /* New to SMB3 */
-#define SMB2_GLOBAL_CAP_ENCRYPTION	0x00000040 /* New to SMB3 */
-/* Internal types */
-#define SMB2_NT_FIND			0x00100000
-#define SMB2_LARGE_FILES		0x00200000
-
-#define SMB311_SALT_SIZE			32
-/* Hash Algorithm Types */
-#define SMB2_PREAUTH_INTEGRITY_SHA512	cpu_to_le16(0x0001)
-
-#define PREAUTH_HASHVALUE_SIZE		64
-
 struct preauth_integrity_info {
 	/* PreAuth integrity Hash ID */
 	__le16			Preauth_HashId;
 	/* PreAuth integrity Hash Value */
-	__u8			Preauth_HashValue[PREAUTH_HASHVALUE_SIZE];
+	__u8			Preauth_HashValue[SMB2_PREAUTH_HASH_SIZE];
 };
 
 /* offset is sizeof smb2_negotiate_rsp - 4 but rounded up to 8 bytes. */
@@ -135,107 +95,6 @@ struct preauth_integrity_info {
 #define OFFSET_OF_NEG_CONTEXT	0xd0
 #endif
 
-#define SMB2_PREAUTH_INTEGRITY_CAPABILITIES	cpu_to_le16(1)
-#define SMB2_ENCRYPTION_CAPABILITIES		cpu_to_le16(2)
-#define SMB2_COMPRESSION_CAPABILITIES		cpu_to_le16(3)
-#define SMB2_NETNAME_NEGOTIATE_CONTEXT_ID	cpu_to_le16(5)
-#define SMB2_SIGNING_CAPABILITIES		cpu_to_le16(8)
-#define SMB2_POSIX_EXTENSIONS_AVAILABLE		cpu_to_le16(0x100)
-
-struct smb2_neg_context {
-	__le16  ContextType;
-	__le16  DataLength;
-	__le32  Reserved;
-	/* Followed by array of data */
-} __packed;
-
-struct smb2_preauth_neg_context {
-	__le16	ContextType; /* 1 */
-	__le16	DataLength;
-	__le32	Reserved;
-	__le16	HashAlgorithmCount; /* 1 */
-	__le16	SaltLength;
-	__le16	HashAlgorithms; /* HashAlgorithms[0] since only one defined */
-	__u8	Salt[SMB311_SALT_SIZE];
-} __packed;
-
-/* Encryption Algorithms Ciphers */
-#define SMB2_ENCRYPTION_AES128_CCM	cpu_to_le16(0x0001)
-#define SMB2_ENCRYPTION_AES128_GCM	cpu_to_le16(0x0002)
-#define SMB2_ENCRYPTION_AES256_CCM	cpu_to_le16(0x0003)
-#define SMB2_ENCRYPTION_AES256_GCM	cpu_to_le16(0x0004)
-
-struct smb2_encryption_neg_context {
-	__le16	ContextType; /* 2 */
-	__le16	DataLength;
-	__le32	Reserved;
-	/* CipherCount usally 2, but can be 3 when AES256-GCM enabled */
-	__le16	CipherCount; /* AES-128-GCM and AES-128-CCM by default */
-	__le16	Ciphers[];
-} __packed;
-
-#define SMB3_COMPRESS_NONE	cpu_to_le16(0x0000)
-#define SMB3_COMPRESS_LZNT1	cpu_to_le16(0x0001)
-#define SMB3_COMPRESS_LZ77	cpu_to_le16(0x0002)
-#define SMB3_COMPRESS_LZ77_HUFF	cpu_to_le16(0x0003)
-
-struct smb2_compression_ctx {
-	__le16	ContextType; /* 3 */
-	__le16  DataLength;
-	__le32	Reserved;
-	__le16	CompressionAlgorithmCount;
-	__u16	Padding;
-	__le32	Reserved1;
-	__le16	CompressionAlgorithms[];
-} __packed;
-
-#define POSIX_CTXT_DATA_LEN     16
-struct smb2_posix_neg_context {
-	__le16	ContextType; /* 0x100 */
-	__le16	DataLength;
-	__le32	Reserved;
-	__u8	Name[16]; /* POSIX ctxt GUID 93AD25509CB411E7B42383DE968BCD7C */
-} __packed;
-
-struct smb2_netname_neg_context {
-	__le16	ContextType; /* 0x100 */
-	__le16	DataLength;
-	__le32	Reserved;
-	__le16	NetName[]; /* hostname of target converted to UCS-2 */
-} __packed;
-
-/* Signing algorithms */
-#define SIGNING_ALG_HMAC_SHA256		cpu_to_le16(0)
-#define SIGNING_ALG_AES_CMAC		cpu_to_le16(1)
-#define SIGNING_ALG_AES_GMAC		cpu_to_le16(2)
-
-struct smb2_signing_capabilities {
-	__le16	ContextType; /* 8 */
-	__le16	DataLength;
-	__le32	Reserved;
-	__le16	SigningAlgorithmCount;
-	__le16	SigningAlgorithms[];
-} __packed;
-
-struct smb2_negotiate_rsp {
-	struct smb2_hdr hdr;
-	__le16 StructureSize;	/* Must be 65 */
-	__le16 SecurityMode;
-	__le16 DialectRevision;
-	__le16 NegotiateContextCount; /* Prior to SMB3.1.1 was Reserved & MBZ */
-	__u8   ServerGUID[16];
-	__le32 Capabilities;
-	__le32 MaxTransactSize;
-	__le32 MaxReadSize;
-	__le32 MaxWriteSize;
-	__le64 SystemTime;	/* MBZ */
-	__le64 ServerStartTime;
-	__le16 SecurityBufferOffset;
-	__le16 SecurityBufferLength;
-	__le32 NegotiateContextOffset;	/* Pre:SMB3.1.1 was reserved/ignored */
-	__u8   Buffer[1];	/* variable length GSS security buffer */
-} __packed;
-
 /* Flags */
 #define SMB2_SESSION_REQ_FLAG_BINDING		0x01
 #define SMB2_SESSION_REQ_FLAG_ENCRYPT_DATA	0x04
diff --git a/fs/ksmbd/smb_common.h b/fs/ksmbd/smb_common.h
index f15ebb864ead..ebd6715d7533 100644
--- a/fs/ksmbd/smb_common.h
+++ b/fs/ksmbd/smb_common.h
@@ -33,17 +33,6 @@
 #define SMB302_VERSION_STRING	"3.02"
 #define SMB311_VERSION_STRING	"3.1.1"
 
-/* Dialects */
-#define SMB10_PROT_ID		0x00
-#define SMB20_PROT_ID		0x0202
-#define SMB21_PROT_ID		0x0210
-/* multi-protocol negotiate request */
-#define SMB2X_PROT_ID		0x02FF
-#define SMB30_PROT_ID		0x0300
-#define SMB302_PROT_ID		0x0302
-#define SMB311_PROT_ID		0x0311
-#define BAD_PROT_ID		0xFFFF
-
 #define SMB_ECHO_INTERVAL	(60 * HZ)
 
 #define CIFS_DEFAULT_IOSIZE	(64 * 1024)
-- 
2.30.2

