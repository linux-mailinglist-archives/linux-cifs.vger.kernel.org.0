Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D0ED1402514
	for <lists+linux-cifs@lfdr.de>; Tue,  7 Sep 2021 10:25:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242535AbhIGI0l (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 7 Sep 2021 04:26:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29999 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S242568AbhIGI0k (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 7 Sep 2021 04:26:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1631003133;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fng4Yb9b/QbSlm6TNHIpXCJ6DEQK0xCAPlXMpvLzgVY=;
        b=jKIbuP3e57Amd74UITmrpt/nQX43wqtN47TTZ+1Aei8H4yXId13uPF6DA8g+gK522kwTD/
        hfy6V+iC5Vl6Z34Ynacsj+3TF0aszUtmlnvrfIw9hv/RIfpOb46yPNX8FQJlU33Fp7bi9U
        r8OijeVwNRx4IFO7rCenFS3bpQ1TQYo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-498-QSrfbfsOP42d0AM95s9YIg-1; Tue, 07 Sep 2021 04:25:32 -0400
X-MC-Unique: QSrfbfsOP42d0AM95s9YIg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 5C24E107ACE3;
        Tue,  7 Sep 2021 08:25:31 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-114.bne.redhat.com [10.64.54.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 697F05C25D;
        Tue,  7 Sep 2021 08:25:30 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: [PATCH 2/4] ksmbd: Move more definitions into the shared area
Date:   Tue,  7 Sep 2021 18:25:21 +1000
Message-Id: <20210907082523.2087981-2-lsahlber@redhat.com>
In-Reply-To: <20210907082523.2087981-1-lsahlber@redhat.com>
References: <20210907082523.2087981-1-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Move SMB2_SessionSetup, SMB2_Close, SMB2_Read, SMB2_Write and
SMB2_ChangeNotify commands into cifs_common/smb2pdu.h

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/ksmbd/smb2pdu.c |   8 +-
 fs/ksmbd/smb2pdu.h | 188 ---------------------------------------------
 2 files changed, 4 insertions(+), 192 deletions(-)

diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index c0adfb9b6248..cb4aa64b2098 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -5956,7 +5956,7 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 	rsp->Reserved = 0;
 	rsp->DataLength = cpu_to_le32(nbytes);
 	rsp->DataRemaining = 0;
-	rsp->Reserved2 = 0;
+	rsp->Flags = 0;
 	inc_rfc1001_len(work->response_buf, nbytes);
 	return 0;
 
@@ -6094,7 +6094,7 @@ int smb2_read(struct ksmbd_work *work)
 	rsp->Reserved = 0;
 	rsp->DataLength = cpu_to_le32(nbytes);
 	rsp->DataRemaining = cpu_to_le32(remain_bytes);
-	rsp->Reserved2 = 0;
+	rsp->Flags = 0;
 	inc_rfc1001_len(work->response_buf, 16);
 	work->resp_hdr_sz = get_rfc1002_len(work->response_buf) + 4;
 	work->aux_payload_sz = nbytes;
@@ -7945,8 +7945,8 @@ int smb2_oplock_break(struct ksmbd_work *work)
  */
 int smb2_notify(struct ksmbd_work *work)
 {
-	struct smb2_notify_req *req;
-	struct smb2_notify_rsp *rsp;
+	struct smb2_change_notify_req *req;
+	struct smb2_change_notify_rsp *rsp;
 
 	WORK_BUFFERS(work, req, rsp);
 
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index b941c0ee6c67..41e3dde87f49 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -95,59 +95,10 @@ struct preauth_integrity_info {
 #define OFFSET_OF_NEG_CONTEXT	0xd0
 #endif
 
-/* Flags */
-#define SMB2_SESSION_REQ_FLAG_BINDING		0x01
-#define SMB2_SESSION_REQ_FLAG_ENCRYPT_DATA	0x04
-
 #define SMB2_SESSION_EXPIRED		(0)
 #define SMB2_SESSION_IN_PROGRESS	BIT(0)
 #define SMB2_SESSION_VALID		BIT(1)
 
-/* Flags */
-#define SMB2_SESSION_REQ_FLAG_BINDING		0x01
-#define SMB2_SESSION_REQ_FLAG_ENCRYPT_DATA	0x04
-
-struct smb2_sess_setup_req {
-	struct smb2_hdr hdr;
-	__le16 StructureSize; /* Must be 25 */
-	__u8   Flags;
-	__u8   SecurityMode;
-	__le32 Capabilities;
-	__le32 Channel;
-	__le16 SecurityBufferOffset;
-	__le16 SecurityBufferLength;
-	__le64 PreviousSessionId;
-	__u8   Buffer[1];	/* variable length GSS security buffer */
-} __packed;
-
-/* Flags/Reserved for SMB3.1.1 */
-#define SMB2_SHAREFLAG_CLUSTER_RECONNECT	0x0001
-
-/* Currently defined SessionFlags */
-#define SMB2_SESSION_FLAG_IS_GUEST_LE		cpu_to_le16(0x0001)
-#define SMB2_SESSION_FLAG_IS_NULL_LE		cpu_to_le16(0x0002)
-#define SMB2_SESSION_FLAG_ENCRYPT_DATA_LE	cpu_to_le16(0x0004)
-struct smb2_sess_setup_rsp {
-	struct smb2_hdr hdr;
-	__le16 StructureSize; /* Must be 9 */
-	__le16 SessionFlags;
-	__le16 SecurityBufferOffset;
-	__le16 SecurityBufferLength;
-	__u8   Buffer[1];	/* variable length GSS security buffer */
-} __packed;
-
-struct smb2_logoff_req {
-	struct smb2_hdr hdr;
-	__le16 StructureSize;	/* Must be 4 */
-	__le16 Reserved;
-} __packed;
-
-struct smb2_logoff_rsp {
-	struct smb2_hdr hdr;
-	__le16 StructureSize;	/* Must be 4 */
-	__le16 Reserved;
-} __packed;
-
 #define ATTR_READONLY_LE	cpu_to_le32(ATTR_READONLY)
 #define ATTR_HIDDEN_LE		cpu_to_le32(ATTR_HIDDEN)
 #define ATTR_SYSTEM_LE		cpu_to_le32(ATTR_SYSTEM)
@@ -447,114 +398,12 @@ struct create_lease_v2 {
 	__u8   Pad[4];
 } __packed;
 
-/* Currently defined values for close flags */
-#define SMB2_CLOSE_FLAG_POSTQUERY_ATTRIB	cpu_to_le16(0x0001)
-struct smb2_close_req {
-	struct smb2_hdr hdr;
-	__le16 StructureSize;	/* Must be 24 */
-	__le16 Flags;
-	__le32 Reserved;
-	__le64  PersistentFileId;
-	__le64  VolatileFileId;
-} __packed;
-
-struct smb2_close_rsp {
-	struct smb2_hdr hdr;
-	__le16 StructureSize; /* 60 */
-	__le16 Flags;
-	__le32 Reserved;
-	__le64 CreationTime;
-	__le64 LastAccessTime;
-	__le64 LastWriteTime;
-	__le64 ChangeTime;
-	__le64 AllocationSize;	/* Beginning of FILE_STANDARD_INFO equivalent */
-	__le64 EndOfFile;
-	__le32 Attributes;
-} __packed;
-
-struct smb2_flush_req {
-	struct smb2_hdr hdr;
-	__le16 StructureSize;	/* Must be 24 */
-	__le16 Reserved1;
-	__le32 Reserved2;
-	__le64  PersistentFileId;
-	__le64  VolatileFileId;
-} __packed;
-
-struct smb2_flush_rsp {
-	struct smb2_hdr hdr;
-	__le16 StructureSize;
-	__le16 Reserved;
-} __packed;
-
 struct smb2_buffer_desc_v1 {
 	__le64 offset;
 	__le32 token;
 	__le32 length;
 } __packed;
 
-#define SMB2_CHANNEL_NONE		cpu_to_le32(0x00000000)
-#define SMB2_CHANNEL_RDMA_V1		cpu_to_le32(0x00000001)
-#define SMB2_CHANNEL_RDMA_V1_INVALIDATE cpu_to_le32(0x00000002)
-
-struct smb2_read_req {
-	struct smb2_hdr hdr;
-	__le16 StructureSize; /* Must be 49 */
-	__u8   Padding; /* offset from start of SMB2 header to place read */
-	__u8   Reserved;
-	__le32 Length;
-	__le64 Offset;
-	__le64  PersistentFileId;
-	__le64  VolatileFileId;
-	__le32 MinimumCount;
-	__le32 Channel; /* Reserved MBZ */
-	__le32 RemainingBytes;
-	__le16 ReadChannelInfoOffset; /* Reserved MBZ */
-	__le16 ReadChannelInfoLength; /* Reserved MBZ */
-	__u8   Buffer[1];
-} __packed;
-
-struct smb2_read_rsp {
-	struct smb2_hdr hdr;
-	__le16 StructureSize; /* Must be 17 */
-	__u8   DataOffset;
-	__u8   Reserved;
-	__le32 DataLength;
-	__le32 DataRemaining;
-	__u32  Reserved2;
-	__u8   Buffer[1];
-} __packed;
-
-/* For write request Flags field below the following flag is defined: */
-#define SMB2_WRITEFLAG_WRITE_THROUGH 0x00000001
-
-struct smb2_write_req {
-	struct smb2_hdr hdr;
-	__le16 StructureSize; /* Must be 49 */
-	__le16 DataOffset; /* offset from start of SMB2 header to write data */
-	__le32 Length;
-	__le64 Offset;
-	__le64  PersistentFileId;
-	__le64  VolatileFileId;
-	__le32 Channel; /* Reserved MBZ */
-	__le32 RemainingBytes;
-	__le16 WriteChannelInfoOffset; /* Reserved MBZ */
-	__le16 WriteChannelInfoLength; /* Reserved MBZ */
-	__le32 Flags;
-	__u8   Buffer[1];
-} __packed;
-
-struct smb2_write_rsp {
-	struct smb2_hdr hdr;
-	__le16 StructureSize; /* Must be 17 */
-	__u8   DataOffset;
-	__u8   Reserved;
-	__le32 DataLength;
-	__le32 DataRemaining;
-	__u32  Reserved2;
-	__u8   Buffer[1];
-} __packed;
-
 #define SMB2_0_IOCTL_IS_FSCTL 0x00000001
 
 struct duplicate_extents_to_file {
@@ -704,43 +553,6 @@ struct reparse_data_buffer {
 	__u8	DataBuffer[]; /* Variable Length */
 } __packed;
 
-/* Completion Filter flags for Notify */
-#define FILE_NOTIFY_CHANGE_FILE_NAME	0x00000001
-#define FILE_NOTIFY_CHANGE_DIR_NAME	0x00000002
-#define FILE_NOTIFY_CHANGE_NAME		0x00000003
-#define FILE_NOTIFY_CHANGE_ATTRIBUTES	0x00000004
-#define FILE_NOTIFY_CHANGE_SIZE		0x00000008
-#define FILE_NOTIFY_CHANGE_LAST_WRITE	0x00000010
-#define FILE_NOTIFY_CHANGE_LAST_ACCESS	0x00000020
-#define FILE_NOTIFY_CHANGE_CREATION	0x00000040
-#define FILE_NOTIFY_CHANGE_EA		0x00000080
-#define FILE_NOTIFY_CHANGE_SECURITY	0x00000100
-#define FILE_NOTIFY_CHANGE_STREAM_NAME	0x00000200
-#define FILE_NOTIFY_CHANGE_STREAM_SIZE	0x00000400
-#define FILE_NOTIFY_CHANGE_STREAM_WRITE	0x00000800
-
-/* Flags */
-#define SMB2_WATCH_TREE	0x0001
-
-struct smb2_notify_req {
-	struct smb2_hdr hdr;
-	__le16 StructureSize; /* Must be 32 */
-	__le16 Flags;
-	__le32 OutputBufferLength;
-	__le64 PersistentFileId;
-	__le64 VolatileFileId;
-	__u32 CompletionFileter;
-	__u32 Reserved;
-} __packed;
-
-struct smb2_notify_rsp {
-	struct smb2_hdr hdr;
-	__le16 StructureSize; /* Must be 9 */
-	__le16 OutputBufferOffset;
-	__le32 OutputBufferLength;
-	__u8 Buffer[1];
-} __packed;
-
 /* SMB2 Notify Action Flags */
 #define FILE_ACTION_ADDED		0x00000001
 #define FILE_ACTION_REMOVED		0x00000002
-- 
2.30.2

