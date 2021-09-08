Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC60F403283
	for <lists+linux-cifs@lfdr.de>; Wed,  8 Sep 2021 04:10:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347183AbhIHCLt (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 7 Sep 2021 22:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50092 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347165AbhIHCLq (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 7 Sep 2021 22:11:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631067038;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XhEfEJb62wh1BBfGX1y8tT3gWzEZAN/LsWYzN8KEcIM=;
        b=OQkuQatXH9+P6RHU3Q40M02eOsAwb4trkmV/i8j5qYKVV5jfyFZAMaPYZpyqKcc1B/Ryiy
        ESumZh/uEFljQNcYckBc2qeDm4WkD3MQCl4lU2B49sQhqqP5WrX4rEc+I0z6L5Fq9nyNcV
        xPbIYqGie6qTqwYE6vXrf6d1V9yGiHw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-362-Cx9SIhhjMyeLXceHJa6gFA-1; Tue, 07 Sep 2021 22:10:37 -0400
X-MC-Unique: Cx9SIhhjMyeLXceHJa6gFA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3908B512C;
        Wed,  8 Sep 2021 02:10:36 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-114.bne.redhat.com [10.64.54.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id ED96A60C04;
        Wed,  8 Sep 2021 02:10:34 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: [PATCH 2/4] cifs: move NEGOTIATE_PROTOCOL definitions out into the common area
Date:   Wed,  8 Sep 2021 12:10:13 +1000
Message-Id: <20210908021015.2115407-3-lsahlber@redhat.com>
In-Reply-To: <20210908021015.2115407-1-lsahlber@redhat.com>
References: <20210908021015.2115407-1-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/smb2pdu.c        |   4 +-
 fs/cifs/smb2pdu.h        | 220 -------------------------------------
 fs/cifs_common/smb2pdu.h | 229 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 231 insertions(+), 222 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 2077a7436323..21e1c5bf6fc6 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -414,8 +414,8 @@ build_preauth_ctxt(struct smb2_preauth_neg_context *pneg_ctxt)
 	pneg_ctxt->ContextType = SMB2_PREAUTH_INTEGRITY_CAPABILITIES;
 	pneg_ctxt->DataLength = cpu_to_le16(38);
 	pneg_ctxt->HashAlgorithmCount = cpu_to_le16(1);
-	pneg_ctxt->SaltLength = cpu_to_le16(SMB311_LINUX_CLIENT_SALT_SIZE);
-	get_random_bytes(pneg_ctxt->Salt, SMB311_LINUX_CLIENT_SALT_SIZE);
+	pneg_ctxt->SaltLength = cpu_to_le16(SMB311_SALT_SIZE);
+	get_random_bytes(pneg_ctxt->Salt, SMB311_SALT_SIZE);
 	pneg_ctxt->HashAlgorithms = SMB2_PREAUTH_INTEGRITY_SHA512;
 }
 
diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index 293bf2a791c2..61060a0618b4 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -116,226 +116,6 @@ struct share_redirect_error_context_rsp {
 	/* __u8 ResourceName[] */ /* Name of share as counted Unicode string */
 } __packed;
 
-#define SMB2_CLIENT_GUID_SIZE 16
-
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
-	__le16 Dialects[4]; /* BB expand this if autonegotiate > 4 dialects */
-} __packed;
-
-/* Dialects */
-#define SMB10_PROT_ID 0x0000 /* local only, not sent on wire w/CIFS negprot */
-#define SMB20_PROT_ID 0x0202
-#define SMB21_PROT_ID 0x0210
-#define SMB30_PROT_ID 0x0300
-#define SMB302_PROT_ID 0x0302
-#define SMB311_PROT_ID 0x0311
-#define BAD_PROT_ID   0xFFFF
-
-/* SecurityMode flags */
-#define	SMB2_NEGOTIATE_SIGNING_ENABLED	0x0001
-#define SMB2_NEGOTIATE_SIGNING_REQUIRED	0x0002
-#define SMB2_SEC_MODE_FLAGS_ALL		0x0003
-
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
-
-/* Negotiate Contexts - ContextTypes. See MS-SMB2 section 2.2.3.1 for details */
-#define SMB2_PREAUTH_INTEGRITY_CAPABILITIES	cpu_to_le16(1)
-#define SMB2_ENCRYPTION_CAPABILITIES		cpu_to_le16(2)
-#define SMB2_COMPRESSION_CAPABILITIES		cpu_to_le16(3)
-#define SMB2_NETNAME_NEGOTIATE_CONTEXT_ID	cpu_to_le16(5)
-#define SMB2_TRANSPORT_CAPABILITIES		cpu_to_le16(6)
-#define SMB2_RDMA_TRANSFORM_CAPABILITIES	cpu_to_le16(7)
-#define SMB2_SIGNING_CAPABILITIES		cpu_to_le16(8)
-#define SMB2_POSIX_EXTENSIONS_AVAILABLE		cpu_to_le16(0x100)
-
-struct smb2_neg_context {
-	__le16	ContextType;
-	__le16	DataLength;
-	__le32	Reserved;
-	/* Followed by array of data. NOTE: some servers require padding to 8 byte boundary */
-} __packed;
-
-#define SMB311_LINUX_CLIENT_SALT_SIZE			32
-/* Hash Algorithm Types */
-#define SMB2_PREAUTH_INTEGRITY_SHA512	cpu_to_le16(0x0001)
-#define SMB2_PREAUTH_HASH_SIZE 64
-
-/*
- * SaltLength that the server send can be zero, so the only three required
- * fields (all __le16) end up six bytes total, so the minimum context data len
- * in the response is six bytes which accounts for
- *
- *      HashAlgorithmCount, SaltLength, and 1 HashAlgorithm.
- */
-#define MIN_PREAUTH_CTXT_DATA_LEN 6
-
-struct smb2_preauth_neg_context {
-	__le16	ContextType; /* 1 */
-	__le16	DataLength;
-	__le32	Reserved;
-	__le16	HashAlgorithmCount; /* 1 */
-	__le16	SaltLength;
-	__le16	HashAlgorithms; /* HashAlgorithms[0] since only one defined */
-	__u8	Salt[SMB311_LINUX_CLIENT_SALT_SIZE];
-} __packed;
-
-/* Encryption Algorithms Ciphers */
-#define SMB2_ENCRYPTION_AES128_CCM	cpu_to_le16(0x0001)
-#define SMB2_ENCRYPTION_AES128_GCM	cpu_to_le16(0x0002)
-/* we currently do not request AES256_CCM since presumably GCM faster */
-#define SMB2_ENCRYPTION_AES256_CCM      cpu_to_le16(0x0003)
-#define SMB2_ENCRYPTION_AES256_GCM      cpu_to_le16(0x0004)
-
-/* Min encrypt context data is one cipher so 2 bytes + 2 byte count field */
-#define MIN_ENCRYPT_CTXT_DATA_LEN	4
-struct smb2_encryption_neg_context {
-	__le16	ContextType; /* 2 */
-	__le16	DataLength;
-	__le32	Reserved;
-	/* CipherCount usally 2, but can be 3 when AES256-GCM enabled */
-	__le16	CipherCount; /* AES128-GCM and AES128-CCM by default */
-	__le16	Ciphers[3];
-} __packed;
-
-/* See MS-SMB2 2.2.3.1.3 */
-#define SMB3_COMPRESS_NONE	cpu_to_le16(0x0000)
-#define SMB3_COMPRESS_LZNT1	cpu_to_le16(0x0001)
-#define SMB3_COMPRESS_LZ77	cpu_to_le16(0x0002)
-#define SMB3_COMPRESS_LZ77_HUFF	cpu_to_le16(0x0003)
-/* Pattern scanning algorithm See MS-SMB2 3.1.4.4.1 */
-#define SMB3_COMPRESS_PATTERN	cpu_to_le16(0x0004) /* Pattern_V1 */
-
-/* Compression Flags */
-#define SMB2_COMPRESSION_CAPABILITIES_FLAG_NONE		cpu_to_le32(0x00000000)
-#define SMB2_COMPRESSION_CAPABILITIES_FLAG_CHAINED	cpu_to_le32(0x00000001)
-
-struct smb2_compression_capabilities_context {
-	__le16	ContextType; /* 3 */
-	__le16  DataLength;
-	__u32	Reserved;
-	__le16	CompressionAlgorithmCount;
-	__u16	Padding;
-	__u32	Flags;
-	__le16	CompressionAlgorithms[3];
-	__u16	Pad;  /* Some servers require pad to DataLen multiple of 8 */
-	/* Check if pad needed */
-} __packed;
-
-/*
- * For smb2_netname_negotiate_context_id See MS-SMB2 2.2.3.1.4.
- * Its struct simply contains NetName, an array of Unicode characters
- */
-struct smb2_netname_neg_context {
-	__le16	ContextType; /* 5 */
-	__le16	DataLength;
-	__le32	Reserved;
-	__le16	NetName[]; /* hostname of target converted to UCS-2 */
-} __packed;
-
-/*
- * For smb2_transport_capabilities context see MS-SMB2 2.2.3.1.5
- * and 2.2.4.1.5
- */
-
-/* Flags */
-#define SMB2_ACCEPT_TRANSFORM_LEVEL_SECURITY	0x00000001
-
-struct smb2_transport_capabilities_context {
-	__le16	ContextType; /* 6 */
-	__le16  DataLength;
-	__u32	Reserved;
-	__le32	Flags;
-	__u32	Pad;
-} __packed;
-
-/*
- * For rdma transform capabilities context see MS-SMB2 2.2.3.1.6
- * and 2.2.4.1.6
- */
-
-/* RDMA Transform IDs */
-#define SMB2_RDMA_TRANSFORM_NONE	0x0000
-#define SMB2_RDMA_TRANSFORM_ENCRYPTION	0x0001
-#define SMB2_RDMA_TRANSFORM_SIGNING	0x0002
-
-struct smb2_rdma_transform_capabilities_context {
-	__le16	ContextType; /* 7 */
-	__le16  DataLength;
-	__u32	Reserved;
-	__le16	TransformCount;
-	__u16	Reserved1;
-	__u32	Reserved2;
-	__le16	RDMATransformIds[];
-} __packed;
-
-/*
- * For signing capabilities context see MS-SMB2 2.2.3.1.7
- * and 2.2.4.1.7
- */
-
-/* Signing algorithms */
-#define SIGNING_ALG_HMAC_SHA256	0
-#define SIGNING_ALG_AES_CMAC	1
-#define SIGNING_ALG_AES_GMAC	2
-
-struct smb2_signing_capabilities {
-	__le16	ContextType; /* 8 */
-	__le16	DataLength;
-	__u32	Reserved;
-	__le16	SigningAlgorithmCount;
-	__le16	SigningAlgorithms[];
-	/*  Followed by padding to 8 byte boundary (required by some servers) */
-} __packed;
-
-#define POSIX_CTXT_DATA_LEN	16
-struct smb2_posix_neg_context {
-	__le16	ContextType; /* 0x100 */
-	__le16	DataLength;
-	__le32	Reserved;
-	__u8	Name[16]; /* POSIX ctxt GUID 93AD25509CB411E7B42383DE968BCD7C */
-} __packed;
-
-struct smb2_negotiate_rsp {
-	struct smb2_hdr hdr;
-	__le16 StructureSize;	/* Must be 65 */
-	__le16 SecurityMode;
-	__le16 DialectRevision;
-	__le16 NegotiateContextCount;	/* Prior to SMB3.1.1 was Reserved & MBZ */
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
diff --git a/fs/cifs_common/smb2pdu.h b/fs/cifs_common/smb2pdu.h
index f191ed64c1ee..a1f661a1b89d 100644
--- a/fs/cifs_common/smb2pdu.h
+++ b/fs/cifs_common/smb2pdu.h
@@ -315,4 +315,233 @@ struct smb2_tree_disconnect_rsp {
 } __packed;
 
 
+/*
+ * SMB2_NEGOTIATE_PROTOCOL  See MS-SMB2 section 2.2.3
+ */
+/* SecurityMode flags */
+#define	SMB2_NEGOTIATE_SIGNING_ENABLED     0x0001
+#define	SMB2_NEGOTIATE_SIGNING_ENABLED_LE  cpu_to_le16(0x0001)
+#define SMB2_NEGOTIATE_SIGNING_REQUIRED	   0x0002
+#define SMB2_NEGOTIATE_SIGNING_REQUIRED_LE cpu_to_le16(0x0002)
+#define SMB2_SEC_MODE_FLAGS_ALL            0x0003
+
+/* Capabilities flags */
+#define SMB2_GLOBAL_CAP_DFS		0x00000001
+#define SMB2_GLOBAL_CAP_LEASING		0x00000002 /* Resp only New to SMB2.1 */
+#define SMB2_GLOBAL_CAP_LARGE_MTU	0X00000004 /* Resp only New to SMB2.1 */
+#define SMB2_GLOBAL_CAP_MULTI_CHANNEL	0x00000008 /* New to SMB3 */
+#define SMB2_GLOBAL_CAP_PERSISTENT_HANDLES 0x00000010 /* New to SMB3 */
+#define SMB2_GLOBAL_CAP_DIRECTORY_LEASING  0x00000020 /* New to SMB3 */
+#define SMB2_GLOBAL_CAP_ENCRYPTION	0x00000040 /* New to SMB3 */
+/* Internal types */
+#define SMB2_NT_FIND			0x00100000
+#define SMB2_LARGE_FILES		0x00200000
+
+#define SMB2_CLIENT_GUID_SIZE		16
+#define SMB2_CREATE_GUID_SIZE		16
+
+/* Dialects */
+#define SMB10_PROT_ID  0x0000 /* local only, not sent on wire w/CIFS negprot */
+#define SMB20_PROT_ID  0x0202
+#define SMB21_PROT_ID  0x0210
+#define SMB2X_PROT_ID  0x02FF
+#define SMB30_PROT_ID  0x0300
+#define SMB302_PROT_ID 0x0302
+#define SMB311_PROT_ID 0x0311
+#define BAD_PROT_ID    0xFFFF
+
+#define SMB311_SALT_SIZE			32
+/* Hash Algorithm Types */
+#define SMB2_PREAUTH_INTEGRITY_SHA512	cpu_to_le16(0x0001)
+#define SMB2_PREAUTH_HASH_SIZE 64
+
+/* Negotiate Contexts - ContextTypes. See MS-SMB2 section 2.2.3.1 for details */
+#define SMB2_PREAUTH_INTEGRITY_CAPABILITIES	cpu_to_le16(1)
+#define SMB2_ENCRYPTION_CAPABILITIES		cpu_to_le16(2)
+#define SMB2_COMPRESSION_CAPABILITIES		cpu_to_le16(3)
+#define SMB2_NETNAME_NEGOTIATE_CONTEXT_ID	cpu_to_le16(5)
+#define SMB2_TRANSPORT_CAPABILITIES		cpu_to_le16(6)
+#define SMB2_RDMA_TRANSFORM_CAPABILITIES	cpu_to_le16(7)
+#define SMB2_SIGNING_CAPABILITIES		cpu_to_le16(8)
+#define SMB2_POSIX_EXTENSIONS_AVAILABLE		cpu_to_le16(0x100)
+
+struct smb2_neg_context {
+	__le16	ContextType;
+	__le16	DataLength;
+	__le32	Reserved;
+	/* Followed by array of data. NOTE: some servers require padding to 8 byte boundary */
+} __packed;
+
+/*
+ * SaltLength that the server send can be zero, so the only three required
+ * fields (all __le16) end up six bytes total, so the minimum context data len
+ * in the response is six bytes which accounts for
+ *
+ *      HashAlgorithmCount, SaltLength, and 1 HashAlgorithm.
+ */
+#define MIN_PREAUTH_CTXT_DATA_LEN 6
+
+struct smb2_preauth_neg_context {
+	__le16	ContextType; /* 1 */
+	__le16	DataLength;
+	__le32	Reserved;
+	__le16	HashAlgorithmCount; /* 1 */
+	__le16	SaltLength;
+	__le16	HashAlgorithms; /* HashAlgorithms[0] since only one defined */
+	__u8	Salt[SMB311_SALT_SIZE];
+} __packed;
+
+/* Encryption Algorithms Ciphers */
+#define SMB2_ENCRYPTION_AES128_CCM	cpu_to_le16(0x0001)
+#define SMB2_ENCRYPTION_AES128_GCM	cpu_to_le16(0x0002)
+#define SMB2_ENCRYPTION_AES256_CCM      cpu_to_le16(0x0003)
+#define SMB2_ENCRYPTION_AES256_GCM      cpu_to_le16(0x0004)
+
+/* Min encrypt context data is one cipher so 2 bytes + 2 byte count field */
+#define MIN_ENCRYPT_CTXT_DATA_LEN	4
+struct smb2_encryption_neg_context {
+	__le16	ContextType; /* 2 */
+	__le16	DataLength;
+	__le32	Reserved;
+	/* CipherCount usally 2, but can be 3 when AES256-GCM enabled */
+	__le16	CipherCount; /* AES128-GCM and AES128-CCM by default */
+	__le16	Ciphers[];
+} __packed;
+
+/* See MS-SMB2 2.2.3.1.3 */
+#define SMB3_COMPRESS_NONE	cpu_to_le16(0x0000)
+#define SMB3_COMPRESS_LZNT1	cpu_to_le16(0x0001)
+#define SMB3_COMPRESS_LZ77	cpu_to_le16(0x0002)
+#define SMB3_COMPRESS_LZ77_HUFF	cpu_to_le16(0x0003)
+/* Pattern scanning algorithm See MS-SMB2 3.1.4.4.1 */
+#define SMB3_COMPRESS_PATTERN	cpu_to_le16(0x0004) /* Pattern_V1 */
+
+/* Compression Flags */
+#define SMB2_COMPRESSION_CAPABILITIES_FLAG_NONE		cpu_to_le32(0x00000000)
+#define SMB2_COMPRESSION_CAPABILITIES_FLAG_CHAINED	cpu_to_le32(0x00000001)
+
+struct smb2_compression_capabilities_context {
+	__le16	ContextType; /* 3 */
+	__le16  DataLength;
+	__le32	Reserved;
+	__le16	CompressionAlgorithmCount;
+	__le16	Padding;
+	__le32	Flags;
+	__le16	CompressionAlgorithms[3];
+	__u16	Pad;  /* Some servers require pad to DataLen multiple of 8 */
+	/* Check if pad needed */
+} __packed;
+
+/*
+ * For smb2_netname_negotiate_context_id See MS-SMB2 2.2.3.1.4.
+ * Its struct simply contains NetName, an array of Unicode characters
+ */
+struct smb2_netname_neg_context {
+	__le16	ContextType; /* 5 */
+	__le16	DataLength;
+	__le32	Reserved;
+	__le16	NetName[]; /* hostname of target converted to UCS-2 */
+} __packed;
+
+/*
+ * For smb2_transport_capabilities context see MS-SMB2 2.2.3.1.5
+ * and 2.2.4.1.5
+ */
+
+/* Flags */
+#define SMB2_ACCEPT_TRANSFORM_LEVEL_SECURITY	0x00000001
+
+struct smb2_transport_capabilities_context {
+	__le16	ContextType; /* 6 */
+	__le16  DataLength;
+	__u32	Reserved;
+	__le32	Flags;
+	__u32	Pad;
+} __packed;
+
+/*
+ * For rdma transform capabilities context see MS-SMB2 2.2.3.1.6
+ * and 2.2.4.1.6
+ */
+
+/* RDMA Transform IDs */
+#define SMB2_RDMA_TRANSFORM_NONE	0x0000
+#define SMB2_RDMA_TRANSFORM_ENCRYPTION	0x0001
+#define SMB2_RDMA_TRANSFORM_SIGNING	0x0002
+
+struct smb2_rdma_transform_capabilities_context {
+	__le16	ContextType; /* 7 */
+	__le16  DataLength;
+	__u32	Reserved;
+	__le16	TransformCount;
+	__u16	Reserved1;
+	__u32	Reserved2;
+	__le16	RDMATransformIds[];
+} __packed;
+
+/*
+ * For signing capabilities context see MS-SMB2 2.2.3.1.7
+ * and 2.2.4.1.7
+ */
+
+/* Signing algorithms */
+#define SIGNING_ALG_HMAC_SHA256    0
+#define SIGNING_ALG_HMAC_SHA256_LE cpu_to_le16(0)
+#define SIGNING_ALG_AES_CMAC       1
+#define SIGNING_ALG_AES_CMAC_LE    cpu_to_le16(1)
+#define SIGNING_ALG_AES_GMAC       2
+#define SIGNING_ALG_AES_GMAC_LE    cpu_to_le16(2)
+
+struct smb2_signing_capabilities {
+	__le16	ContextType; /* 8 */
+	__le16	DataLength;
+	__le32	Reserved;
+	__le16	SigningAlgorithmCount;
+	__le16	SigningAlgorithms[];
+	/*  Followed by padding to 8 byte boundary (required by some servers) */
+} __packed;
+
+#define POSIX_CTXT_DATA_LEN	16
+struct smb2_posix_neg_context {
+	__le16	ContextType; /* 0x100 */
+	__le16	DataLength;
+	__le32	Reserved;
+	__u8	Name[16]; /* POSIX ctxt GUID 93AD25509CB411E7B42383DE968BCD7C */
+} __packed;
+
+struct smb2_negotiate_req {
+	struct smb2_hdr hdr;
+	__le16 StructureSize; /* Must be 36 */
+	__le16 DialectCount;
+	__le16 SecurityMode;
+	__le16 Reserved;	/* MBZ */
+	__le32 Capabilities;
+	__u8   ClientGUID[SMB2_CLIENT_GUID_SIZE];
+	/* In SMB3.02 and earlier next three were MBZ le64 ClientStartTime */
+	__le32 NegotiateContextOffset; /* SMB3.1.1 only. MBZ earlier */
+	__le16 NegotiateContextCount;  /* SMB3.1.1 only. MBZ earlier */
+	__le16 Reserved2;
+	__le16 Dialects[];
+} __packed;
+
+struct smb2_negotiate_rsp {
+	struct smb2_hdr hdr;
+	__le16 StructureSize;	/* Must be 65 */
+	__le16 SecurityMode;
+	__le16 DialectRevision;
+	__le16 NegotiateContextCount;	/* Prior to SMB3.1.1 was Reserved & MBZ */
+	__u8   ServerGUID[16];
+	__le32 Capabilities;
+	__le32 MaxTransactSize;
+	__le32 MaxReadSize;
+	__le32 MaxWriteSize;
+	__le64 SystemTime;	/* MBZ */
+	__le64 ServerStartTime;
+	__le16 SecurityBufferOffset;
+	__le16 SecurityBufferLength;
+	__le32 NegotiateContextOffset;	/* Pre:SMB3.1.1 was reserved/ignored */
+	__u8   Buffer[1];	/* variable length GSS security buffer */
+} __packed;
+
+
 #endif				/* _COMMON_SMB2PDU_H */
-- 
2.30.2

