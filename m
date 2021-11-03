Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2EBB444278
	for <lists+linux-cifs@lfdr.de>; Wed,  3 Nov 2021 14:34:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231405AbhKCNgk (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 3 Nov 2021 09:36:40 -0400
Received: from mail-pg1-f171.google.com ([209.85.215.171]:37415 "EHLO
        mail-pg1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbhKCNgj (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 3 Nov 2021 09:36:39 -0400
Received: by mail-pg1-f171.google.com with SMTP id s136so2399434pgs.4
        for <linux-cifs@vger.kernel.org>; Wed, 03 Nov 2021 06:34:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=YWI5QZ7h2qAR7cWtORM1LV5pr+VE6ECcf5uuEZVIp3g=;
        b=aXWKirj7Lz3Qo/gPMfMpSylJ7WYPAoKZlLyp8p1ia0lW1Y05VFHrHGvEvJiEiLBZMb
         JZvMiDML5xGLd861OjFIQkUYEi6Fzpvn4RrKY+pvEgaJoscZLj5n74mqHHuyDYb/p716
         JPVxOr7pGfwMXNsTPm+Xg7bnOkzTesfoa7xm9vk0P6GzEh3O0QZL7ghnvuL5/Gjd8AKT
         FMH1x9Y+7f/aPcZ53cSBOYGH0tMN820U3hkQ/G+rQRfiyB4fFbTnmoNU3ITey61B7Iau
         N5585RSX2A1E7Zvazxduy6MXyDJvTQDYzWLSwpTCNey9yZep0LPoNv1FQalwmfFjUUev
         DbBw==
X-Gm-Message-State: AOAM531gu5X+6S3fwkujX+NGD84vH8TU4Nudz0L2UUWDQt6lZ5UahFfL
        XXrBhVtUes7YF3KQ7oYH8Qbi0uM0m2I=
X-Google-Smtp-Source: ABdhPJz9cEvMd+Fhd6T+NvUIqqTEZzKe6trrzTfDYLqqrqMtYQXWW3rYhd8bvR8PkTRAUJGMmpFCyw==
X-Received: by 2002:a63:86c8:: with SMTP id x191mr17935250pgd.153.1635946441908;
        Wed, 03 Nov 2021 06:34:01 -0700 (PDT)
Received: from localhost.localdomain ([61.74.27.164])
        by smtp.gmail.com with ESMTPSA id s14sm2692024pfk.95.2021.11.03.06.34.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 Nov 2021 06:34:01 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 1/3] ksmbd: remove smb2_buf_length in smb2_hdr
Date:   Wed,  3 Nov 2021 22:33:51 +0900
Message-Id: <20211103133353.6650-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

To move smb2_hdr to smbfs_common, This patch remove smb2_buf_length
variable in smb2_hdr. Also, declare smb2_get_msg function to get smb2
request/response from ->request/response_buf.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ksmbd/auth.c           |   4 +-
 fs/ksmbd/connection.c     |   9 +-
 fs/ksmbd/ksmbd_work.h     |   4 +-
 fs/ksmbd/oplock.c         |  24 +--
 fs/ksmbd/smb2misc.c       |   2 +-
 fs/ksmbd/smb2pdu.c        | 440 +++++++++++++++++++-------------------
 fs/ksmbd/smb2pdu.h        |  20 +-
 fs/ksmbd/smb_common.c     |  11 +-
 fs/ksmbd/smb_common.h     |   6 -
 fs/ksmbd/transport_rdma.c |   2 +-
 10 files changed, 260 insertions(+), 262 deletions(-)

diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index 30a92ddc1817..c69c5471db1c 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -873,9 +873,9 @@ int ksmbd_gen_preauth_integrity_hash(struct ksmbd_conn *conn, char *buf,
 				     __u8 *pi_hash)
 {
 	int rc;
-	struct smb2_hdr *rcv_hdr = (struct smb2_hdr *)buf;
+	struct smb2_hdr *rcv_hdr = smb2_get_msg(buf);
 	char *all_bytes_msg = (char *)&rcv_hdr->ProtocolId;
-	int msg_size = be32_to_cpu(rcv_hdr->smb2_buf_length);
+	int msg_size = get_rfc1002_len(buf);
 	struct ksmbd_crypto_ctx *ctx = NULL;
 
 	if (conn->preauth_info->Preauth_HashId !=
diff --git a/fs/ksmbd/connection.c b/fs/ksmbd/connection.c
index b57a0d8a392f..12f710ccbdff 100644
--- a/fs/ksmbd/connection.c
+++ b/fs/ksmbd/connection.c
@@ -158,14 +158,13 @@ void ksmbd_conn_wait_idle(struct ksmbd_conn *conn)
 int ksmbd_conn_write(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb_hdr *rsp_hdr = work->response_buf;
 	size_t len = 0;
 	int sent;
 	struct kvec iov[3];
 	int iov_idx = 0;
 
 	ksmbd_conn_try_dequeue_request(work);
-	if (!rsp_hdr) {
+	if (!work->response_buf) {
 		pr_err("NULL response header\n");
 		return -EINVAL;
 	}
@@ -177,7 +176,7 @@ int ksmbd_conn_write(struct ksmbd_work *work)
 	}
 
 	if (work->aux_payload_sz) {
-		iov[iov_idx] = (struct kvec) { rsp_hdr, work->resp_hdr_sz };
+		iov[iov_idx] = (struct kvec) { work->response_buf, work->resp_hdr_sz };
 		len += iov[iov_idx++].iov_len;
 		iov[iov_idx] = (struct kvec) { work->aux_payload_buf, work->aux_payload_sz };
 		len += iov[iov_idx++].iov_len;
@@ -185,8 +184,8 @@ int ksmbd_conn_write(struct ksmbd_work *work)
 		if (work->tr_buf)
 			iov[iov_idx].iov_len = work->resp_hdr_sz;
 		else
-			iov[iov_idx].iov_len = get_rfc1002_len(rsp_hdr) + 4;
-		iov[iov_idx].iov_base = rsp_hdr;
+			iov[iov_idx].iov_len = get_rfc1002_len(work->response_buf) + 4;
+		iov[iov_idx].iov_base = work->response_buf;
 		len += iov[iov_idx++].iov_len;
 	}
 
diff --git a/fs/ksmbd/ksmbd_work.h b/fs/ksmbd/ksmbd_work.h
index f7156bc50049..5ece58e40c97 100644
--- a/fs/ksmbd/ksmbd_work.h
+++ b/fs/ksmbd/ksmbd_work.h
@@ -92,7 +92,7 @@ struct ksmbd_work {
  */
 static inline void *ksmbd_resp_buf_next(struct ksmbd_work *work)
 {
-	return work->response_buf + work->next_smb2_rsp_hdr_off;
+	return work->response_buf + work->next_smb2_rsp_hdr_off + 4;
 }
 
 /**
@@ -101,7 +101,7 @@ static inline void *ksmbd_resp_buf_next(struct ksmbd_work *work)
  */
 static inline void *ksmbd_req_buf_next(struct ksmbd_work *work)
 {
-	return work->request_buf + work->next_smb2_rcv_hdr_off;
+	return work->request_buf + work->next_smb2_rcv_hdr_off + 4;
 }
 
 struct ksmbd_work *ksmbd_alloc_work_struct(void);
diff --git a/fs/ksmbd/oplock.c b/fs/ksmbd/oplock.c
index f9dae6ef2115..ce0e85552da9 100644
--- a/fs/ksmbd/oplock.c
+++ b/fs/ksmbd/oplock.c
@@ -629,10 +629,10 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 		return;
 	}
 
-	rsp_hdr = work->response_buf;
+	rsp_hdr = smb2_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
-	rsp_hdr->smb2_buf_length =
-		cpu_to_be32(smb2_hdr_size_no_buflen(conn->vals));
+	*(__be32 *)work->response_buf =
+		cpu_to_be32(conn->vals->header_size);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->CreditRequest = cpu_to_le16(0);
@@ -645,7 +645,7 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = work->response_buf;
+	rsp = smb2_get_msg(work->response_buf);
 
 	rsp->StructureSize = cpu_to_le16(24);
 	if (!br_info->open_trunc &&
@@ -659,7 +659,7 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 	rsp->PersistentFid = cpu_to_le64(fp->persistent_id);
 	rsp->VolatileFid = cpu_to_le64(fp->volatile_id);
 
-	inc_rfc1001_len(rsp, 24);
+	inc_rfc1001_len(work->response_buf, 24);
 
 	ksmbd_debug(OPLOCK,
 		    "sending oplock break v_id %llu p_id = %llu lock level = %d\n",
@@ -736,10 +736,10 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 		return;
 	}
 
-	rsp_hdr = work->response_buf;
+	rsp_hdr = smb2_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
-	rsp_hdr->smb2_buf_length =
-		cpu_to_be32(smb2_hdr_size_no_buflen(conn->vals));
+	*(__be32 *)work->response_buf =
+		cpu_to_be32(conn->vals->header_size);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->CreditRequest = cpu_to_le16(0);
@@ -752,7 +752,7 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = work->response_buf;
+	rsp = smb2_get_msg(work->response_buf);
 	rsp->StructureSize = cpu_to_le16(44);
 	rsp->Epoch = br_info->epoch;
 	rsp->Flags = 0;
@@ -768,7 +768,7 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 	rsp->AccessMaskHint = 0;
 	rsp->ShareMaskHint = 0;
 
-	inc_rfc1001_len(rsp, 44);
+	inc_rfc1001_len(work->response_buf, 44);
 
 	ksmbd_conn_write(work);
 	ksmbd_free_work_struct(work);
@@ -1398,7 +1398,7 @@ struct lease_ctx_info *parse_lease_state(void *open_req)
 	if (!lreq)
 		return NULL;
 
-	data_offset = (char *)req + 4 + le32_to_cpu(req->CreateContextsOffset);
+	data_offset = (char *)req + le32_to_cpu(req->CreateContextsOffset);
 	cc = (struct create_context *)data_offset;
 	do {
 		cc = (struct create_context *)((char *)cc + next);
@@ -1462,7 +1462,7 @@ struct create_context *smb2_find_context_vals(void *open_req, const char *tag)
 	 * CreateContextsOffset and CreateContextsLength are guaranteed to
 	 * be valid because of ksmbd_smb2_check_message().
 	 */
-	cc = (struct create_context *)((char *)req + 4 +
+	cc = (struct create_context *)((char *)req +
 				       le32_to_cpu(req->CreateContextsOffset));
 	remain_len = le32_to_cpu(req->CreateContextsLength);
 	do {
diff --git a/fs/ksmbd/smb2misc.c b/fs/ksmbd/smb2misc.c
index 0239fa96926c..0aba1c91fd37 100644
--- a/fs/ksmbd/smb2misc.c
+++ b/fs/ksmbd/smb2misc.c
@@ -351,7 +351,7 @@ int ksmbd_smb2_check_message(struct ksmbd_work *work)
 	struct smb2_hdr *hdr = &pdu->hdr;
 	int command;
 	__u32 clc_len;  /* calculated length */
-	__u32 len = get_rfc1002_len(pdu);
+	__u32 len = get_rfc1002_len(work->request_buf);
 
 	if (le32_to_cpu(hdr->NextCommand) > 0)
 		len = le32_to_cpu(hdr->NextCommand);
diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
index 04f82b5870c3..63bf185530c2 100644
--- a/fs/ksmbd/smb2pdu.c
+++ b/fs/ksmbd/smb2pdu.c
@@ -44,8 +44,8 @@ static void __wbuf(struct ksmbd_work *work, void **req, void **rsp)
 		*req = ksmbd_req_buf_next(work);
 		*rsp = ksmbd_resp_buf_next(work);
 	} else {
-		*req = work->request_buf;
-		*rsp = work->response_buf;
+		*req = smb2_get_msg(work->request_buf);
+		*rsp = smb2_get_msg(work->response_buf);
 	}
 }
 
@@ -93,7 +93,7 @@ struct channel *lookup_chann_list(struct ksmbd_session *sess, struct ksmbd_conn
  */
 int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 {
-	struct smb2_hdr *req_hdr = work->request_buf;
+	struct smb2_hdr *req_hdr = smb2_get_msg(work->request_buf);
 	unsigned int cmd = le16_to_cpu(req_hdr->Command);
 	int tree_id;
 
@@ -131,7 +131,7 @@ void smb2_set_err_rsp(struct ksmbd_work *work)
 	if (work->next_smb2_rcv_hdr_off)
 		err_rsp = ksmbd_resp_buf_next(work);
 	else
-		err_rsp = work->response_buf;
+		err_rsp = smb2_get_msg(work->response_buf);
 
 	if (err_rsp->hdr.Status != STATUS_STOPPED_ON_SYMLINK) {
 		err_rsp->StructureSize = SMB2_ERROR_STRUCTURE_SIZE2_LE;
@@ -151,7 +151,7 @@ void smb2_set_err_rsp(struct ksmbd_work *work)
  */
 bool is_smb2_neg_cmd(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = work->request_buf;
+	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
 
 	/* is it SMB2 header ? */
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -175,7 +175,7 @@ bool is_smb2_neg_cmd(struct ksmbd_work *work)
  */
 bool is_smb2_rsp(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = work->response_buf;
+	struct smb2_hdr *hdr = smb2_get_msg(work->response_buf);
 
 	/* is it SMB2 header ? */
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -201,7 +201,7 @@ u16 get_smb2_cmd_val(struct ksmbd_work *work)
 	if (work->next_smb2_rcv_hdr_off)
 		rcv_hdr = ksmbd_req_buf_next(work);
 	else
-		rcv_hdr = work->request_buf;
+		rcv_hdr = smb2_get_msg(work->request_buf);
 	return le16_to_cpu(rcv_hdr->Command);
 }
 
@@ -217,7 +217,7 @@ void set_smb2_rsp_status(struct ksmbd_work *work, __le32 err)
 	if (work->next_smb2_rcv_hdr_off)
 		rsp_hdr = ksmbd_resp_buf_next(work);
 	else
-		rsp_hdr = work->response_buf;
+		rsp_hdr = smb2_get_msg(work->response_buf);
 	rsp_hdr->Status = err;
 	smb2_set_err_rsp(work);
 }
@@ -238,13 +238,11 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 	if (conn->need_neg == false)
 		return -EINVAL;
 
-	rsp_hdr = work->response_buf;
+	*(__be32 *)work->response_buf =
+		cpu_to_be32(conn->vals->header_size);
 
+	rsp_hdr = smb2_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
-
-	rsp_hdr->smb2_buf_length =
-		cpu_to_be32(smb2_hdr_size_no_buflen(conn->vals));
-
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->CreditRequest = cpu_to_le16(2);
@@ -257,7 +255,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 	rsp_hdr->SessionId = 0;
 	memset(rsp_hdr->Signature, 0, 16);
 
-	rsp = work->response_buf;
+	rsp = smb2_get_msg(work->response_buf);
 
 	WARN_ON(ksmbd_conn_good(work));
 
@@ -278,12 +276,12 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 
 	rsp->SecurityBufferOffset = cpu_to_le16(128);
 	rsp->SecurityBufferLength = cpu_to_le16(AUTH_GSS_LENGTH);
-	ksmbd_copy_gss_neg_header(((char *)(&rsp->hdr) +
-		sizeof(rsp->hdr.smb2_buf_length)) +
+	ksmbd_copy_gss_neg_header((char *)(&rsp->hdr) +
 		le16_to_cpu(rsp->SecurityBufferOffset));
-	inc_rfc1001_len(rsp, sizeof(struct smb2_negotiate_rsp) -
-		sizeof(struct smb2_hdr) - sizeof(rsp->Buffer) +
-		AUTH_GSS_LENGTH);
+	inc_rfc1001_len(work->response_buf,
+			sizeof(struct smb2_negotiate_rsp) -
+			sizeof(struct smb2_hdr) - sizeof(rsp->Buffer) +
+			AUTH_GSS_LENGTH);
 	rsp->SecurityMode = SMB2_NEGOTIATE_SIGNING_ENABLED_LE;
 	if (server_conf.signing == KSMBD_CONFIG_OPT_MANDATORY)
 		rsp->SecurityMode |= SMB2_NEGOTIATE_SIGNING_REQUIRED_LE;
@@ -388,8 +386,8 @@ static void init_chained_smb2_rsp(struct ksmbd_work *work)
 	next_hdr_offset = le32_to_cpu(req->NextCommand);
 
 	new_len = ALIGN(len, 8);
-	inc_rfc1001_len(work->response_buf, ((sizeof(struct smb2_hdr) - 4)
-			+ new_len - len));
+	inc_rfc1001_len(work->response_buf,
+			sizeof(struct smb2_hdr) + new_len - len);
 	rsp->NextCommand = cpu_to_le32(new_len);
 
 	work->next_smb2_rcv_hdr_off += next_hdr_offset;
@@ -407,7 +405,7 @@ static void init_chained_smb2_rsp(struct ksmbd_work *work)
 		work->compound_fid = KSMBD_NO_FID;
 		work->compound_pfid = KSMBD_NO_FID;
 	}
-	memset((char *)rsp_hdr + 4, 0, sizeof(struct smb2_hdr) + 2);
+	memset((char *)rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->Command = rcv_hdr->Command;
@@ -433,7 +431,7 @@ static void init_chained_smb2_rsp(struct ksmbd_work *work)
  */
 bool is_chained_smb2_message(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = work->request_buf;
+	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
 	unsigned int len, next_cmd;
 
 	if (hdr->ProtocolId != SMB2_PROTO_NUMBER)
@@ -484,13 +482,13 @@ bool is_chained_smb2_message(struct ksmbd_work *work)
  */
 int init_smb2_rsp_hdr(struct ksmbd_work *work)
 {
-	struct smb2_hdr *rsp_hdr = work->response_buf;
-	struct smb2_hdr *rcv_hdr = work->request_buf;
+	struct smb2_hdr *rsp_hdr = smb2_get_msg(work->response_buf);
+	struct smb2_hdr *rcv_hdr = smb2_get_msg(work->request_buf);
 	struct ksmbd_conn *conn = work->conn;
 
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
-	rsp_hdr->smb2_buf_length =
-		cpu_to_be32(smb2_hdr_size_no_buflen(conn->vals));
+	*(__be32 *)work->response_buf =
+		cpu_to_be32(conn->vals->header_size);
 	rsp_hdr->ProtocolId = rcv_hdr->ProtocolId;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->Command = rcv_hdr->Command;
@@ -523,7 +521,7 @@ int init_smb2_rsp_hdr(struct ksmbd_work *work)
  */
 int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr = work->request_buf;
+	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
 	size_t small_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
 	size_t large_sz = small_sz + work->conn->vals->max_trans_size;
 	size_t sz = small_sz;
@@ -535,7 +533,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 	if (cmd == SMB2_QUERY_INFO_HE) {
 		struct smb2_query_info_req *req;
 
-		req = work->request_buf;
+		req = smb2_get_msg(work->request_buf);
 		if (req->InfoType == SMB2_O_INFO_FILE &&
 		    (req->FileInfoClass == FILE_FULL_EA_INFORMATION ||
 		     req->FileInfoClass == FILE_ALL_INFORMATION))
@@ -562,7 +560,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
  */
 int smb2_check_user_session(struct ksmbd_work *work)
 {
-	struct smb2_hdr *req_hdr = work->request_buf;
+	struct smb2_hdr *req_hdr = smb2_get_msg(work->request_buf);
 	struct ksmbd_conn *conn = work->conn;
 	unsigned int cmd = conn->ops->get_cmd_val(work);
 	unsigned long long sess_id;
@@ -643,7 +641,7 @@ int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
 	struct ksmbd_conn *conn = work->conn;
 	int id;
 
-	rsp_hdr = work->response_buf;
+	rsp_hdr = smb2_get_msg(work->response_buf);
 	rsp_hdr->Flags |= SMB2_FLAGS_ASYNC_COMMAND;
 
 	id = ksmbd_acquire_async_msg_id(&conn->async_ida);
@@ -675,7 +673,7 @@ void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status)
 {
 	struct smb2_hdr *rsp_hdr;
 
-	rsp_hdr = work->response_buf;
+	rsp_hdr = smb2_get_msg(work->response_buf);
 	smb2_set_err_rsp(work);
 	rsp_hdr->Status = status;
 
@@ -803,11 +801,11 @@ static void build_posix_ctxt(struct smb2_posix_neg_context *pneg_ctxt)
 }
 
 static void assemble_neg_contexts(struct ksmbd_conn *conn,
-				  struct smb2_negotiate_rsp *rsp)
+				  struct smb2_negotiate_rsp *rsp,
+				  void *smb2_buf_len)
 {
-	/* +4 is to account for the RFC1001 len field */
 	char *pneg_ctxt = (char *)rsp +
-			le32_to_cpu(rsp->NegotiateContextOffset) + 4;
+			le32_to_cpu(rsp->NegotiateContextOffset);
 	int neg_ctxt_cnt = 1;
 	int ctxt_size;
 
@@ -816,7 +814,7 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 	build_preauth_ctxt((struct smb2_preauth_neg_context *)pneg_ctxt,
 			   conn->preauth_info->Preauth_HashId);
 	rsp->NegotiateContextCount = cpu_to_le16(neg_ctxt_cnt);
-	inc_rfc1001_len(rsp, AUTH_GSS_PADDING);
+	inc_rfc1001_len(smb2_buf_len, AUTH_GSS_PADDING);
 	ctxt_size = sizeof(struct smb2_preauth_neg_context);
 	/* Round to 8 byte boundary */
 	pneg_ctxt += round_up(sizeof(struct smb2_preauth_neg_context), 8);
@@ -870,7 +868,7 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 		ctxt_size += sizeof(struct smb2_signing_capabilities) + 2;
 	}
 
-	inc_rfc1001_len(rsp, ctxt_size);
+	inc_rfc1001_len(smb2_buf_len, ctxt_size);
 }
 
 static __le32 decode_preauth_ctxt(struct ksmbd_conn *conn,
@@ -953,14 +951,14 @@ static void decode_sign_cap_ctxt(struct ksmbd_conn *conn,
 }
 
 static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
-				      struct smb2_negotiate_req *req)
+				      struct smb2_negotiate_req *req,
+				      int len_of_smb)
 {
 	/* +4 is to account for the RFC1001 len field */
-	struct smb2_neg_context *pctx = (struct smb2_neg_context *)((char *)req + 4);
+	struct smb2_neg_context *pctx = (struct smb2_neg_context *)req;
 	int i = 0, len_of_ctxts;
 	int offset = le32_to_cpu(req->NegotiateContextOffset);
 	int neg_ctxt_cnt = le16_to_cpu(req->NegotiateContextCount);
-	int len_of_smb = be32_to_cpu(req->hdr.smb2_buf_length);
 	__le32 status = STATUS_INVALID_PARAMETER;
 
 	ksmbd_debug(SMB, "decoding %d negotiate contexts\n", neg_ctxt_cnt);
@@ -1045,8 +1043,8 @@ static __le32 deassemble_neg_contexts(struct ksmbd_conn *conn,
 int smb2_handle_negotiate(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_negotiate_req *req = work->request_buf;
-	struct smb2_negotiate_rsp *rsp = work->response_buf;
+	struct smb2_negotiate_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_negotiate_rsp *rsp = smb2_get_msg(work->response_buf);
 	int rc = 0;
 	unsigned int smb2_buf_len, smb2_neg_size;
 	__le32 status;
@@ -1067,7 +1065,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 	}
 
 	smb2_buf_len = get_rfc1002_len(work->request_buf);
-	smb2_neg_size = offsetof(struct smb2_negotiate_req, Dialects) - 4;
+	smb2_neg_size = offsetof(struct smb2_negotiate_req, Dialects);
 	if (smb2_neg_size > smb2_buf_len) {
 		rsp->hdr.Status = STATUS_INVALID_PARAMETER;
 		rc = -EINVAL;
@@ -1116,7 +1114,8 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 			goto err_out;
 		}
 
-		status = deassemble_neg_contexts(conn, req);
+		status = deassemble_neg_contexts(conn, req,
+						 get_rfc1002_len(work->request_buf));
 		if (status != STATUS_SUCCESS) {
 			pr_err("deassemble_neg_contexts error(0x%x)\n",
 			       status);
@@ -1136,7 +1135,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 						 conn->preauth_info->Preauth_HashValue);
 		rsp->NegotiateContextOffset =
 				cpu_to_le32(OFFSET_OF_NEG_CONTEXT);
-		assemble_neg_contexts(conn, rsp);
+		assemble_neg_contexts(conn, rsp, work->response_buf);
 		break;
 	case SMB302_PROT_ID:
 		init_smb3_02_server(conn);
@@ -1184,10 +1183,9 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 
 	rsp->SecurityBufferOffset = cpu_to_le16(128);
 	rsp->SecurityBufferLength = cpu_to_le16(AUTH_GSS_LENGTH);
-	ksmbd_copy_gss_neg_header(((char *)(&rsp->hdr) +
-				  sizeof(rsp->hdr.smb2_buf_length)) +
-				   le16_to_cpu(rsp->SecurityBufferOffset));
-	inc_rfc1001_len(rsp, sizeof(struct smb2_negotiate_rsp) -
+	ksmbd_copy_gss_neg_header((char *)(&rsp->hdr) +
+				  le16_to_cpu(rsp->SecurityBufferOffset));
+	inc_rfc1001_len(work->response_buf, sizeof(struct smb2_negotiate_rsp) -
 			sizeof(struct smb2_hdr) - sizeof(rsp->Buffer) +
 			 AUTH_GSS_LENGTH);
 	rsp->SecurityMode = SMB2_NEGOTIATE_SIGNING_ENABLED_LE;
@@ -1279,7 +1277,7 @@ static int ntlm_negotiate(struct ksmbd_work *work,
 			  struct negotiate_message *negblob,
 			  size_t negblob_len)
 {
-	struct smb2_sess_setup_rsp *rsp = work->response_buf;
+	struct smb2_sess_setup_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct challenge_message *chgblob;
 	unsigned char *spnego_blob = NULL;
 	u16 spnego_blob_len;
@@ -1387,8 +1385,8 @@ static struct ksmbd_user *session_user(struct ksmbd_conn *conn,
 
 static int ntlm_authenticate(struct ksmbd_work *work)
 {
-	struct smb2_sess_setup_req *req = work->request_buf;
-	struct smb2_sess_setup_rsp *rsp = work->response_buf;
+	struct smb2_sess_setup_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_sess_setup_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
 	struct channel *chann = NULL;
@@ -1411,7 +1409,7 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 		memcpy((char *)&rsp->hdr.ProtocolId + sz, spnego_blob, spnego_blob_len);
 		rsp->SecurityBufferLength = cpu_to_le16(spnego_blob_len);
 		kfree(spnego_blob);
-		inc_rfc1001_len(rsp, spnego_blob_len - 1);
+		inc_rfc1001_len(work->response_buf, spnego_blob_len - 1);
 	}
 
 	user = session_user(conn, req);
@@ -1523,8 +1521,8 @@ static int ntlm_authenticate(struct ksmbd_work *work)
 #ifdef CONFIG_SMB_SERVER_KERBEROS5
 static int krb5_authenticate(struct ksmbd_work *work)
 {
-	struct smb2_sess_setup_req *req = work->request_buf;
-	struct smb2_sess_setup_rsp *rsp = work->response_buf;
+	struct smb2_sess_setup_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_sess_setup_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess = work->sess;
 	char *in_blob, *out_blob;
@@ -1539,8 +1537,7 @@ static int krb5_authenticate(struct ksmbd_work *work)
 	out_blob = (char *)&rsp->hdr.ProtocolId +
 		le16_to_cpu(rsp->SecurityBufferOffset);
 	out_len = work->response_sz -
-		offsetof(struct smb2_hdr, smb2_buf_length) -
-		le16_to_cpu(rsp->SecurityBufferOffset);
+		(le16_to_cpu(rsp->SecurityBufferOffset) + 4);
 
 	/* Check previous session */
 	prev_sess_id = le64_to_cpu(req->PreviousSessionId);
@@ -1557,7 +1554,7 @@ static int krb5_authenticate(struct ksmbd_work *work)
 		return -EINVAL;
 	}
 	rsp->SecurityBufferLength = cpu_to_le16(out_len);
-	inc_rfc1001_len(rsp, out_len - 1);
+	inc_rfc1001_len(work->response_buf, out_len - 1);
 
 	if ((conn->sign || server_conf.enforced_signing) ||
 	    (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED))
@@ -1613,8 +1610,8 @@ static int krb5_authenticate(struct ksmbd_work *work)
 int smb2_sess_setup(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_sess_setup_req *req = work->request_buf;
-	struct smb2_sess_setup_rsp *rsp = work->response_buf;
+	struct smb2_sess_setup_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_sess_setup_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_session *sess;
 	struct negotiate_message *negblob;
 	unsigned int negblob_len, negblob_off;
@@ -1626,7 +1623,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 	rsp->SessionFlags = 0;
 	rsp->SecurityBufferOffset = cpu_to_le16(72);
 	rsp->SecurityBufferLength = 0;
-	inc_rfc1001_len(rsp, 9);
+	inc_rfc1001_len(work->response_buf, 9);
 
 	if (!req->hdr.SessionId) {
 		sess = ksmbd_smb2_session_create();
@@ -1700,7 +1697,7 @@ int smb2_sess_setup(struct ksmbd_work *work)
 
 	negblob_off = le16_to_cpu(req->SecurityBufferOffset);
 	negblob_len = le16_to_cpu(req->SecurityBufferLength);
-	if (negblob_off < (offsetof(struct smb2_sess_setup_req, Buffer) - 4) ||
+	if (negblob_off < offsetof(struct smb2_sess_setup_req, Buffer) ||
 	    negblob_len < offsetof(struct negotiate_message, NegotiateFlags))
 		return -EINVAL;
 
@@ -1740,7 +1737,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
 				 * Note: here total size -1 is done as an
 				 * adjustment for 0 size blob
 				 */
-				inc_rfc1001_len(rsp, le16_to_cpu(rsp->SecurityBufferLength) - 1);
+				inc_rfc1001_len(work->response_buf,
+						le16_to_cpu(rsp->SecurityBufferLength) - 1);
 
 			} else if (negblob->MessageType == NtLmAuthenticate) {
 				rc = ntlm_authenticate(work);
@@ -1829,8 +1827,8 @@ int smb2_sess_setup(struct ksmbd_work *work)
 int smb2_tree_connect(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_tree_connect_req *req = work->request_buf;
-	struct smb2_tree_connect_rsp *rsp = work->response_buf;
+	struct smb2_tree_connect_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_tree_connect_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_session *sess = work->sess;
 	char *treename = NULL, *name = NULL;
 	struct ksmbd_tree_conn_status status;
@@ -1895,7 +1893,7 @@ int smb2_tree_connect(struct ksmbd_work *work)
 	rsp->Reserved = 0;
 	/* default manual caching */
 	rsp->ShareFlags = SMB2_SHAREFLAG_MANUAL_CACHING;
-	inc_rfc1001_len(rsp, 16);
+	inc_rfc1001_len(work->response_buf, 16);
 
 	if (!IS_ERR(treename))
 		kfree(treename);
@@ -2000,17 +1998,18 @@ static int smb2_create_open_flags(bool file_present, __le32 access,
  */
 int smb2_tree_disconnect(struct ksmbd_work *work)
 {
-	struct smb2_tree_disconnect_rsp *rsp = work->response_buf;
+	struct smb2_tree_disconnect_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_session *sess = work->sess;
 	struct ksmbd_tree_connect *tcon = work->tcon;
 
 	rsp->StructureSize = cpu_to_le16(4);
-	inc_rfc1001_len(rsp, 4);
+	inc_rfc1001_len(work->response_buf, 4);
 
 	ksmbd_debug(SMB, "request\n");
 
 	if (!tcon) {
-		struct smb2_tree_disconnect_req *req = work->request_buf;
+		struct smb2_tree_disconnect_req *req =
+			smb2_get_msg(work->request_buf);
 
 		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
 		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
@@ -2032,11 +2031,11 @@ int smb2_tree_disconnect(struct ksmbd_work *work)
 int smb2_session_logoff(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_logoff_rsp *rsp = work->response_buf;
+	struct smb2_logoff_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_session *sess = work->sess;
 
 	rsp->StructureSize = cpu_to_le16(4);
-	inc_rfc1001_len(rsp, 4);
+	inc_rfc1001_len(work->response_buf, 4);
 
 	ksmbd_debug(SMB, "request\n");
 
@@ -2049,7 +2048,7 @@ int smb2_session_logoff(struct ksmbd_work *work)
 	ksmbd_conn_wait_idle(conn);
 
 	if (ksmbd_tree_conn_session_logoff(sess)) {
-		struct smb2_logoff_req *req = work->request_buf;
+		struct smb2_logoff_req *req = smb2_get_msg(work->request_buf);
 
 		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
 		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
@@ -2076,8 +2075,8 @@ int smb2_session_logoff(struct ksmbd_work *work)
  */
 static noinline int create_smb2_pipe(struct ksmbd_work *work)
 {
-	struct smb2_create_rsp *rsp = work->response_buf;
-	struct smb2_create_req *req = work->request_buf;
+	struct smb2_create_rsp *rsp = smb2_get_msg(work->response_buf);
+	struct smb2_create_req *req = smb2_get_msg(work->request_buf);
 	int id;
 	int err;
 	char *name;
@@ -2115,7 +2114,7 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
 	rsp->CreateContextsOffset = 0;
 	rsp->CreateContextsLength = 0;
 
-	inc_rfc1001_len(rsp, 88); /* StructureSize - 1*/
+	inc_rfc1001_len(work->response_buf, 88); /* StructureSize - 1*/
 	kfree(name);
 	return 0;
 
@@ -2464,7 +2463,7 @@ int smb2_open(struct ksmbd_work *work)
 	struct ksmbd_session *sess = work->sess;
 	struct ksmbd_tree_connect *tcon = work->tcon;
 	struct smb2_create_req *req;
-	struct smb2_create_rsp *rsp, *rsp_org;
+	struct smb2_create_rsp *rsp;
 	struct path path;
 	struct ksmbd_share_config *share = tcon->share_conf;
 	struct ksmbd_file *fp = NULL;
@@ -2490,7 +2489,6 @@ int smb2_open(struct ksmbd_work *work)
 	umode_t posix_mode = 0;
 	__le32 daccess, maximal_access = 0;
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	if (req->hdr.NextCommand && !work->next_smb2_rcv_hdr_off &&
@@ -3141,7 +3139,7 @@ int smb2_open(struct ksmbd_work *work)
 
 	rsp->CreateContextsOffset = 0;
 	rsp->CreateContextsLength = 0;
-	inc_rfc1001_len(rsp_org, 88); /* StructureSize - 1*/
+	inc_rfc1001_len(work->response_buf, 88); /* StructureSize - 1*/
 
 	/* If lease is request send lease context response */
 	if (opinfo && opinfo->is_lease) {
@@ -3156,7 +3154,8 @@ int smb2_open(struct ksmbd_work *work)
 		create_lease_buf(rsp->Buffer, opinfo->o_lease);
 		le32_add_cpu(&rsp->CreateContextsLength,
 			     conn->vals->create_lease_size);
-		inc_rfc1001_len(rsp_org, conn->vals->create_lease_size);
+		inc_rfc1001_len(work->response_buf,
+				conn->vals->create_lease_size);
 		next_ptr = &lease_ccontext->Next;
 		next_off = conn->vals->create_lease_size;
 	}
@@ -3176,7 +3175,8 @@ int smb2_open(struct ksmbd_work *work)
 				le32_to_cpu(maximal_access));
 		le32_add_cpu(&rsp->CreateContextsLength,
 			     conn->vals->create_mxac_size);
-		inc_rfc1001_len(rsp_org, conn->vals->create_mxac_size);
+		inc_rfc1001_len(work->response_buf,
+				conn->vals->create_mxac_size);
 		if (next_ptr)
 			*next_ptr = cpu_to_le32(next_off);
 		next_ptr = &mxac_ccontext->Next;
@@ -3194,7 +3194,8 @@ int smb2_open(struct ksmbd_work *work)
 				stat.ino, tcon->id);
 		le32_add_cpu(&rsp->CreateContextsLength,
 			     conn->vals->create_disk_id_size);
-		inc_rfc1001_len(rsp_org, conn->vals->create_disk_id_size);
+		inc_rfc1001_len(work->response_buf,
+				conn->vals->create_disk_id_size);
 		if (next_ptr)
 			*next_ptr = cpu_to_le32(next_off);
 		next_ptr = &disk_id_ccontext->Next;
@@ -3208,15 +3209,15 @@ int smb2_open(struct ksmbd_work *work)
 				fp);
 		le32_add_cpu(&rsp->CreateContextsLength,
 			     conn->vals->create_posix_size);
-		inc_rfc1001_len(rsp_org, conn->vals->create_posix_size);
+		inc_rfc1001_len(work->response_buf,
+				conn->vals->create_posix_size);
 		if (next_ptr)
 			*next_ptr = cpu_to_le32(next_off);
 	}
 
 	if (contxt_cnt > 0) {
 		rsp->CreateContextsOffset =
-			cpu_to_le32(offsetof(struct smb2_create_rsp, Buffer)
-			- 4);
+			cpu_to_le32(offsetof(struct smb2_create_rsp, Buffer));
 	}
 
 err_out:
@@ -3817,7 +3818,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	struct smb2_query_directory_req *req;
-	struct smb2_query_directory_rsp *rsp, *rsp_org;
+	struct smb2_query_directory_rsp *rsp;
 	struct ksmbd_share_config *share = work->tcon->share_conf;
 	struct ksmbd_file *dir_fp = NULL;
 	struct ksmbd_dir_info d_info;
@@ -3827,7 +3828,6 @@ int smb2_query_dir(struct ksmbd_work *work)
 	int buffer_sz;
 	struct smb2_query_dir_private query_dir_private = {NULL, };
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	if (ksmbd_override_fsids(work)) {
@@ -3948,7 +3948,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 		rsp->OutputBufferOffset = cpu_to_le16(0);
 		rsp->OutputBufferLength = cpu_to_le32(0);
 		rsp->Buffer[0] = 0;
-		inc_rfc1001_len(rsp_org, 9);
+		inc_rfc1001_len(work->response_buf, 9);
 	} else {
 		((struct file_directory_info *)
 		((char *)rsp->Buffer + d_info.last_entry_offset))
@@ -3957,7 +3957,7 @@ int smb2_query_dir(struct ksmbd_work *work)
 		rsp->StructureSize = cpu_to_le16(9);
 		rsp->OutputBufferOffset = cpu_to_le16(72);
 		rsp->OutputBufferLength = cpu_to_le32(d_info.data_count);
-		inc_rfc1001_len(rsp_org, 8 + d_info.data_count);
+		inc_rfc1001_len(work->response_buf, 8 + d_info.data_count);
 	}
 
 	kfree(srch_ptr);
@@ -4000,26 +4000,28 @@ int smb2_query_dir(struct ksmbd_work *work)
  * Return:	0 on success, otherwise error
  */
 static int buffer_check_err(int reqOutputBufferLength,
-			    struct smb2_query_info_rsp *rsp, int infoclass_size)
+			    struct smb2_query_info_rsp *rsp,
+			    void *rsp_org, int infoclass_size)
 {
 	if (reqOutputBufferLength < le32_to_cpu(rsp->OutputBufferLength)) {
 		if (reqOutputBufferLength < infoclass_size) {
 			pr_err("Invalid Buffer Size Requested\n");
 			rsp->hdr.Status = STATUS_INFO_LENGTH_MISMATCH;
-			rsp->hdr.smb2_buf_length = cpu_to_be32(sizeof(struct smb2_hdr) - 4);
+			*(__be32 *)rsp_org = cpu_to_be32(sizeof(struct smb2_hdr));
 			return -EINVAL;
 		}
 
 		ksmbd_debug(SMB, "Buffer Overflow\n");
 		rsp->hdr.Status = STATUS_BUFFER_OVERFLOW;
-		rsp->hdr.smb2_buf_length = cpu_to_be32(sizeof(struct smb2_hdr) - 4 +
+		*(__be32 *)rsp_org = cpu_to_be32(sizeof(struct smb2_hdr) +
 				reqOutputBufferLength);
 		rsp->OutputBufferLength = cpu_to_le32(reqOutputBufferLength);
 	}
 	return 0;
 }
 
-static void get_standard_info_pipe(struct smb2_query_info_rsp *rsp)
+static void get_standard_info_pipe(struct smb2_query_info_rsp *rsp,
+				   void *rsp_org)
 {
 	struct smb2_file_standard_info *sinfo;
 
@@ -4032,10 +4034,11 @@ static void get_standard_info_pipe(struct smb2_query_info_rsp *rsp)
 	sinfo->Directory = 0;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_standard_info));
-	inc_rfc1001_len(rsp, sizeof(struct smb2_file_standard_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_standard_info));
 }
 
-static void get_internal_info_pipe(struct smb2_query_info_rsp *rsp, u64 num)
+static void get_internal_info_pipe(struct smb2_query_info_rsp *rsp, u64 num,
+				   void *rsp_org)
 {
 	struct smb2_file_internal_info *file_info;
 
@@ -4045,12 +4048,13 @@ static void get_internal_info_pipe(struct smb2_query_info_rsp *rsp, u64 num)
 	file_info->IndexNumber = cpu_to_le64(num | (1ULL << 63));
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_internal_info));
-	inc_rfc1001_len(rsp, sizeof(struct smb2_file_internal_info));
+	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_internal_info));
 }
 
 static int smb2_get_info_file_pipe(struct ksmbd_session *sess,
 				   struct smb2_query_info_req *req,
-				   struct smb2_query_info_rsp *rsp)
+				   struct smb2_query_info_rsp *rsp,
+				   void *rsp_org)
 {
 	u64 id;
 	int rc;
@@ -4068,14 +4072,16 @@ static int smb2_get_info_file_pipe(struct ksmbd_session *sess,
 
 	switch (req->FileInfoClass) {
 	case FILE_STANDARD_INFORMATION:
-		get_standard_info_pipe(rsp);
+		get_standard_info_pipe(rsp, rsp_org);
 		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
-				      rsp, FILE_STANDARD_INFORMATION_SIZE);
+				      rsp, rsp_org,
+				      FILE_STANDARD_INFORMATION_SIZE);
 		break;
 	case FILE_INTERNAL_INFORMATION:
-		get_internal_info_pipe(rsp, id);
+		get_internal_info_pipe(rsp, id, rsp_org);
 		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
-				      rsp, FILE_INTERNAL_INFORMATION_SIZE);
+				      rsp, rsp_org,
+				      FILE_INTERNAL_INFORMATION_SIZE);
 		break;
 	default:
 		ksmbd_debug(SMB, "smb2_info_file_pipe for %u not supported\n",
@@ -4689,7 +4695,7 @@ static int find_file_posix_info(struct smb2_query_info_rsp *rsp,
 
 static int smb2_get_info_file(struct ksmbd_work *work,
 			      struct smb2_query_info_req *req,
-			      struct smb2_query_info_rsp *rsp, void *rsp_org)
+			      struct smb2_query_info_rsp *rsp)
 {
 	struct ksmbd_file *fp;
 	int fileinfoclass = 0;
@@ -4700,7 +4706,8 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 	if (test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_PIPE)) {
 		/* smb2 info file called for pipe */
-		return smb2_get_info_file_pipe(work->sess, req, rsp);
+		return smb2_get_info_file_pipe(work->sess, req, rsp,
+					       work->response_buf);
 	}
 
 	if (work->next_smb2_rcv_hdr_off) {
@@ -4725,77 +4732,77 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 
 	switch (fileinfoclass) {
 	case FILE_ACCESS_INFORMATION:
-		get_file_access_info(rsp, fp, rsp_org);
+		get_file_access_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_ACCESS_INFORMATION_SIZE;
 		break;
 
 	case FILE_BASIC_INFORMATION:
-		rc = get_file_basic_info(rsp, fp, rsp_org);
+		rc = get_file_basic_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_BASIC_INFORMATION_SIZE;
 		break;
 
 	case FILE_STANDARD_INFORMATION:
-		get_file_standard_info(rsp, fp, rsp_org);
+		get_file_standard_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_STANDARD_INFORMATION_SIZE;
 		break;
 
 	case FILE_ALIGNMENT_INFORMATION:
-		get_file_alignment_info(rsp, rsp_org);
+		get_file_alignment_info(rsp, work->response_buf);
 		file_infoclass_size = FILE_ALIGNMENT_INFORMATION_SIZE;
 		break;
 
 	case FILE_ALL_INFORMATION:
-		rc = get_file_all_info(work, rsp, fp, rsp_org);
+		rc = get_file_all_info(work, rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_ALL_INFORMATION_SIZE;
 		break;
 
 	case FILE_ALTERNATE_NAME_INFORMATION:
-		get_file_alternate_info(work, rsp, fp, rsp_org);
+		get_file_alternate_info(work, rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_ALTERNATE_NAME_INFORMATION_SIZE;
 		break;
 
 	case FILE_STREAM_INFORMATION:
-		get_file_stream_info(work, rsp, fp, rsp_org);
+		get_file_stream_info(work, rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_STREAM_INFORMATION_SIZE;
 		break;
 
 	case FILE_INTERNAL_INFORMATION:
-		get_file_internal_info(rsp, fp, rsp_org);
+		get_file_internal_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_INTERNAL_INFORMATION_SIZE;
 		break;
 
 	case FILE_NETWORK_OPEN_INFORMATION:
-		rc = get_file_network_open_info(rsp, fp, rsp_org);
+		rc = get_file_network_open_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_NETWORK_OPEN_INFORMATION_SIZE;
 		break;
 
 	case FILE_EA_INFORMATION:
-		get_file_ea_info(rsp, rsp_org);
+		get_file_ea_info(rsp, work->response_buf);
 		file_infoclass_size = FILE_EA_INFORMATION_SIZE;
 		break;
 
 	case FILE_FULL_EA_INFORMATION:
-		rc = smb2_get_ea(work, fp, req, rsp, rsp_org);
+		rc = smb2_get_ea(work, fp, req, rsp, work->response_buf);
 		file_infoclass_size = FILE_FULL_EA_INFORMATION_SIZE;
 		break;
 
 	case FILE_POSITION_INFORMATION:
-		get_file_position_info(rsp, fp, rsp_org);
+		get_file_position_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_POSITION_INFORMATION_SIZE;
 		break;
 
 	case FILE_MODE_INFORMATION:
-		get_file_mode_info(rsp, fp, rsp_org);
+		get_file_mode_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_MODE_INFORMATION_SIZE;
 		break;
 
 	case FILE_COMPRESSION_INFORMATION:
-		get_file_compression_info(rsp, fp, rsp_org);
+		get_file_compression_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_COMPRESSION_INFORMATION_SIZE;
 		break;
 
 	case FILE_ATTRIBUTE_TAG_INFORMATION:
-		rc = get_file_attribute_tag_info(rsp, fp, rsp_org);
+		rc = get_file_attribute_tag_info(rsp, fp, work->response_buf);
 		file_infoclass_size = FILE_ATTRIBUTE_TAG_INFORMATION_SIZE;
 		break;
 	case SMB_FIND_FILE_POSIX_INFO:
@@ -4803,7 +4810,7 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 			pr_err("client doesn't negotiate with SMB3.1.1 POSIX Extensions\n");
 			rc = -EOPNOTSUPP;
 		} else {
-			rc = find_file_posix_info(rsp, fp, rsp_org);
+			rc = find_file_posix_info(rsp, fp, work->response_buf);
 			file_infoclass_size = sizeof(struct smb311_posix_qinfo);
 		}
 		break;
@@ -4814,7 +4821,7 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 	}
 	if (!rc)
 		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
-				      rsp,
+				      rsp, work->response_buf,
 				      file_infoclass_size);
 	ksmbd_fd_put(work, fp);
 	return rc;
@@ -4822,7 +4829,7 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 
 static int smb2_get_info_filesystem(struct ksmbd_work *work,
 				    struct smb2_query_info_req *req,
-				    struct smb2_query_info_rsp *rsp, void *rsp_org)
+				    struct smb2_query_info_rsp *rsp)
 {
 	struct ksmbd_session *sess = work->sess;
 	struct ksmbd_conn *conn = sess->conn;
@@ -4858,7 +4865,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->DeviceType = cpu_to_le32(stfs.f_type);
 		info->DeviceCharacteristics = cpu_to_le32(0x00000020);
 		rsp->OutputBufferLength = cpu_to_le32(8);
-		inc_rfc1001_len(rsp_org, 8);
+		inc_rfc1001_len(work->response_buf, 8);
 		fs_infoclass_size = FS_DEVICE_INFORMATION_SIZE;
 		break;
 	}
@@ -4884,7 +4891,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->FileSystemNameLen = cpu_to_le32(len);
 		sz = sizeof(struct filesystem_attribute_info) - 2 + len;
 		rsp->OutputBufferLength = cpu_to_le32(sz);
-		inc_rfc1001_len(rsp_org, sz);
+		inc_rfc1001_len(work->response_buf, sz);
 		fs_infoclass_size = FS_ATTRIBUTE_INFORMATION_SIZE;
 		break;
 	}
@@ -4912,7 +4919,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->Reserved = 0;
 		sz = sizeof(struct filesystem_vol_info) - 2 + len;
 		rsp->OutputBufferLength = cpu_to_le32(sz);
-		inc_rfc1001_len(rsp_org, sz);
+		inc_rfc1001_len(work->response_buf, sz);
 		fs_infoclass_size = FS_VOLUME_INFORMATION_SIZE;
 		break;
 	}
@@ -4926,7 +4933,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->SectorsPerAllocationUnit = cpu_to_le32(1);
 		info->BytesPerSector = cpu_to_le32(stfs.f_bsize);
 		rsp->OutputBufferLength = cpu_to_le32(24);
-		inc_rfc1001_len(rsp_org, 24);
+		inc_rfc1001_len(work->response_buf, 24);
 		fs_infoclass_size = FS_SIZE_INFORMATION_SIZE;
 		break;
 	}
@@ -4943,7 +4950,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->SectorsPerAllocationUnit = cpu_to_le32(1);
 		info->BytesPerSector = cpu_to_le32(stfs.f_bsize);
 		rsp->OutputBufferLength = cpu_to_le32(32);
-		inc_rfc1001_len(rsp_org, 32);
+		inc_rfc1001_len(work->response_buf, 32);
 		fs_infoclass_size = FS_FULL_SIZE_INFORMATION_SIZE;
 		break;
 	}
@@ -4964,7 +4971,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->extended_info.rel_date = 0;
 		memcpy(info->extended_info.version_string, "1.1.0", strlen("1.1.0"));
 		rsp->OutputBufferLength = cpu_to_le32(64);
-		inc_rfc1001_len(rsp_org, 64);
+		inc_rfc1001_len(work->response_buf, 64);
 		fs_infoclass_size = FS_OBJECT_ID_INFORMATION_SIZE;
 		break;
 	}
@@ -4985,7 +4992,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->ByteOffsetForSectorAlignment = 0;
 		info->ByteOffsetForPartitionAlignment = 0;
 		rsp->OutputBufferLength = cpu_to_le32(28);
-		inc_rfc1001_len(rsp_org, 28);
+		inc_rfc1001_len(work->response_buf, 28);
 		fs_infoclass_size = FS_SECTOR_SIZE_INFORMATION_SIZE;
 		break;
 	}
@@ -5007,7 +5014,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->DefaultQuotaLimit = cpu_to_le64(SMB2_NO_FID);
 		info->Padding = 0;
 		rsp->OutputBufferLength = cpu_to_le32(48);
-		inc_rfc1001_len(rsp_org, 48);
+		inc_rfc1001_len(work->response_buf, 48);
 		fs_infoclass_size = FS_CONTROL_INFORMATION_SIZE;
 		break;
 	}
@@ -5028,7 +5035,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 			info->TotalFileNodes = cpu_to_le64(stfs.f_files);
 			info->FreeFileNodes = cpu_to_le64(stfs.f_ffree);
 			rsp->OutputBufferLength = cpu_to_le32(56);
-			inc_rfc1001_len(rsp_org, 56);
+			inc_rfc1001_len(work->response_buf, 56);
 			fs_infoclass_size = FS_POSIX_INFORMATION_SIZE;
 		}
 		break;
@@ -5038,7 +5045,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		return -EOPNOTSUPP;
 	}
 	rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
-			      rsp,
+			      rsp, work->response_buf,
 			      fs_infoclass_size);
 	path_put(&path);
 	return rc;
@@ -5046,7 +5053,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 
 static int smb2_get_info_sec(struct ksmbd_work *work,
 			     struct smb2_query_info_req *req,
-			     struct smb2_query_info_rsp *rsp, void *rsp_org)
+			     struct smb2_query_info_rsp *rsp)
 {
 	struct ksmbd_file *fp;
 	struct user_namespace *user_ns;
@@ -5073,7 +5080,7 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 
 		secdesclen = sizeof(struct smb_ntsd);
 		rsp->OutputBufferLength = cpu_to_le32(secdesclen);
-		inc_rfc1001_len(rsp_org, secdesclen);
+		inc_rfc1001_len(work->response_buf, secdesclen);
 
 		return 0;
 	}
@@ -5115,7 +5122,7 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 		return rc;
 
 	rsp->OutputBufferLength = cpu_to_le32(secdesclen);
-	inc_rfc1001_len(rsp_org, secdesclen);
+	inc_rfc1001_len(work->response_buf, secdesclen);
 	return 0;
 }
 
@@ -5128,10 +5135,9 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 int smb2_query_info(struct ksmbd_work *work)
 {
 	struct smb2_query_info_req *req;
-	struct smb2_query_info_rsp *rsp, *rsp_org;
+	struct smb2_query_info_rsp *rsp;
 	int rc = 0;
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	ksmbd_debug(SMB, "GOT query info request\n");
@@ -5139,15 +5145,15 @@ int smb2_query_info(struct ksmbd_work *work)
 	switch (req->InfoType) {
 	case SMB2_O_INFO_FILE:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILE\n");
-		rc = smb2_get_info_file(work, req, rsp, (void *)rsp_org);
+		rc = smb2_get_info_file(work, req, rsp);
 		break;
 	case SMB2_O_INFO_FILESYSTEM:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILESYSTEM\n");
-		rc = smb2_get_info_filesystem(work, req, rsp, (void *)rsp_org);
+		rc = smb2_get_info_filesystem(work, req, rsp);
 		break;
 	case SMB2_O_INFO_SECURITY:
 		ksmbd_debug(SMB, "GOT SMB2_O_INFO_SECURITY\n");
-		rc = smb2_get_info_sec(work, req, rsp, (void *)rsp_org);
+		rc = smb2_get_info_sec(work, req, rsp);
 		break;
 	default:
 		ksmbd_debug(SMB, "InfoType %d not supported yet\n",
@@ -5172,7 +5178,7 @@ int smb2_query_info(struct ksmbd_work *work)
 	}
 	rsp->StructureSize = cpu_to_le16(9);
 	rsp->OutputBufferOffset = cpu_to_le16(72);
-	inc_rfc1001_len(rsp_org, 8);
+	inc_rfc1001_len(work->response_buf, 8);
 	return 0;
 }
 
@@ -5185,8 +5191,8 @@ int smb2_query_info(struct ksmbd_work *work)
 static noinline int smb2_close_pipe(struct ksmbd_work *work)
 {
 	u64 id;
-	struct smb2_close_req *req = work->request_buf;
-	struct smb2_close_rsp *rsp = work->response_buf;
+	struct smb2_close_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_close_rsp *rsp = smb2_get_msg(work->response_buf);
 
 	id = le64_to_cpu(req->VolatileFileId);
 	ksmbd_session_rpc_close(work->sess, id);
@@ -5201,7 +5207,7 @@ static noinline int smb2_close_pipe(struct ksmbd_work *work)
 	rsp->AllocationSize = 0;
 	rsp->EndOfFile = 0;
 	rsp->Attributes = 0;
-	inc_rfc1001_len(rsp, 60);
+	inc_rfc1001_len(work->response_buf, 60);
 	return 0;
 }
 
@@ -5217,14 +5223,12 @@ int smb2_close(struct ksmbd_work *work)
 	u64 sess_id;
 	struct smb2_close_req *req;
 	struct smb2_close_rsp *rsp;
-	struct smb2_close_rsp *rsp_org;
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_file *fp;
 	struct inode *inode;
 	u64 time;
 	int err = 0;
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	if (test_share_config_flag(work->tcon->share_conf,
@@ -5314,7 +5318,7 @@ int smb2_close(struct ksmbd_work *work)
 			rsp->hdr.Status = STATUS_FILE_CLOSED;
 		smb2_set_err_rsp(work);
 	} else {
-		inc_rfc1001_len(rsp_org, 60);
+		inc_rfc1001_len(work->response_buf, 60);
 	}
 
 	return 0;
@@ -5328,11 +5332,11 @@ int smb2_close(struct ksmbd_work *work)
  */
 int smb2_echo(struct ksmbd_work *work)
 {
-	struct smb2_echo_rsp *rsp = work->response_buf;
+	struct smb2_echo_rsp *rsp = smb2_get_msg(work->response_buf);
 
 	rsp->StructureSize = cpu_to_le16(4);
 	rsp->Reserved = 0;
-	inc_rfc1001_len(rsp, 4);
+	inc_rfc1001_len(work->response_buf, 4);
 	return 0;
 }
 
@@ -5951,14 +5955,13 @@ static int smb2_set_info_sec(struct ksmbd_file *fp, int addition_info,
 int smb2_set_info(struct ksmbd_work *work)
 {
 	struct smb2_set_info_req *req;
-	struct smb2_set_info_rsp *rsp, *rsp_org;
+	struct smb2_set_info_rsp *rsp;
 	struct ksmbd_file *fp;
 	int rc = 0;
 	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
 
 	ksmbd_debug(SMB, "Received set info request\n");
 
-	rsp_org = work->response_buf;
 	if (work->next_smb2_rcv_hdr_off) {
 		req = ksmbd_req_buf_next(work);
 		rsp = ksmbd_resp_buf_next(work);
@@ -5969,8 +5972,8 @@ int smb2_set_info(struct ksmbd_work *work)
 			pid = work->compound_pfid;
 		}
 	} else {
-		req = work->request_buf;
-		rsp = work->response_buf;
+		req = smb2_get_msg(work->request_buf);
+		rsp = smb2_get_msg(work->response_buf);
 	}
 
 	if (!has_file_id(id)) {
@@ -6010,7 +6013,7 @@ int smb2_set_info(struct ksmbd_work *work)
 		goto err_out;
 
 	rsp->StructureSize = cpu_to_le16(2);
-	inc_rfc1001_len(rsp_org, 2);
+	inc_rfc1001_len(work->response_buf, 2);
 	ksmbd_fd_put(work, fp);
 	return 0;
 
@@ -6050,12 +6053,12 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 	int nbytes = 0, err;
 	u64 id;
 	struct ksmbd_rpc_command *rpc_resp;
-	struct smb2_read_req *req = work->request_buf;
-	struct smb2_read_rsp *rsp = work->response_buf;
+	struct smb2_read_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_read_rsp *rsp = smb2_get_msg(work->response_buf);
 
 	id = le64_to_cpu(req->VolatileFileId);
 
-	inc_rfc1001_len(rsp, 16);
+	inc_rfc1001_len(work->response_buf, 16);
 	rpc_resp = ksmbd_rpc_read(work->sess, id);
 	if (rpc_resp) {
 		if (rpc_resp->flags != KSMBD_RPC_OK) {
@@ -6074,7 +6077,7 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 		       rpc_resp->payload_sz);
 
 		nbytes = rpc_resp->payload_sz;
-		work->resp_hdr_sz = get_rfc1002_len(rsp) + 4;
+		work->resp_hdr_sz = get_rfc1002_len(work->response_buf) + 4;
 		work->aux_payload_sz = nbytes;
 		kvfree(rpc_resp);
 	}
@@ -6085,7 +6088,7 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 	rsp->DataLength = cpu_to_le32(nbytes);
 	rsp->DataRemaining = 0;
 	rsp->Reserved2 = 0;
-	inc_rfc1001_len(rsp, nbytes);
+	inc_rfc1001_len(work->response_buf, nbytes);
 	return 0;
 
 out:
@@ -6135,14 +6138,13 @@ int smb2_read(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	struct smb2_read_req *req;
-	struct smb2_read_rsp *rsp, *rsp_org;
+	struct smb2_read_rsp *rsp;
 	struct ksmbd_file *fp;
 	loff_t offset;
 	size_t length, mincount;
 	ssize_t nbytes = 0, remain_bytes = 0;
 	int err = 0;
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	if (test_share_config_flag(work->tcon->share_conf,
@@ -6224,10 +6226,10 @@ int smb2_read(struct ksmbd_work *work)
 	rsp->DataLength = cpu_to_le32(nbytes);
 	rsp->DataRemaining = cpu_to_le32(remain_bytes);
 	rsp->Reserved2 = 0;
-	inc_rfc1001_len(rsp_org, 16);
-	work->resp_hdr_sz = get_rfc1002_len(rsp_org) + 4;
+	inc_rfc1001_len(work->response_buf, 16);
+	work->resp_hdr_sz = get_rfc1002_len(work->response_buf) + 4;
 	work->aux_payload_sz = nbytes;
-	inc_rfc1001_len(rsp_org, nbytes);
+	inc_rfc1001_len(work->response_buf, nbytes);
 	ksmbd_fd_put(work, fp);
 	return 0;
 
@@ -6262,8 +6264,8 @@ int smb2_read(struct ksmbd_work *work)
  */
 static noinline int smb2_write_pipe(struct ksmbd_work *work)
 {
-	struct smb2_write_req *req = work->request_buf;
-	struct smb2_write_rsp *rsp = work->response_buf;
+	struct smb2_write_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_write_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_rpc_command *rpc_resp;
 	u64 id = 0;
 	int err = 0, ret = 0;
@@ -6274,13 +6276,14 @@ static noinline int smb2_write_pipe(struct ksmbd_work *work)
 	id = le64_to_cpu(req->VolatileFileId);
 
 	if (le16_to_cpu(req->DataOffset) ==
-	    (offsetof(struct smb2_write_req, Buffer) - 4)) {
+	    offsetof(struct smb2_write_req, Buffer)) {
 		data_buf = (char *)&req->Buffer[0];
 	} else {
-		if ((u64)le16_to_cpu(req->DataOffset) + length > get_rfc1002_len(req)) {
+		if ((u64)le16_to_cpu(req->DataOffset) + length >
+		    get_rfc1002_len(work->request_buf)) {
 			pr_err("invalid write data offset %u, smb_len %u\n",
 			       le16_to_cpu(req->DataOffset),
-			       get_rfc1002_len(req));
+			       get_rfc1002_len(work->request_buf));
 			err = -EINVAL;
 			goto out;
 		}
@@ -6312,7 +6315,7 @@ static noinline int smb2_write_pipe(struct ksmbd_work *work)
 	rsp->DataLength = cpu_to_le32(length);
 	rsp->DataRemaining = 0;
 	rsp->Reserved2 = 0;
-	inc_rfc1001_len(rsp, 16);
+	inc_rfc1001_len(work->response_buf, 16);
 	return 0;
 out:
 	if (err) {
@@ -6380,7 +6383,7 @@ static ssize_t smb2_write_rdma_channel(struct ksmbd_work *work,
 int smb2_write(struct ksmbd_work *work)
 {
 	struct smb2_write_req *req;
-	struct smb2_write_rsp *rsp, *rsp_org;
+	struct smb2_write_rsp *rsp;
 	struct ksmbd_file *fp = NULL;
 	loff_t offset;
 	size_t length;
@@ -6389,7 +6392,6 @@ int smb2_write(struct ksmbd_work *work)
 	bool writethrough = false;
 	int err = 0;
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	if (test_share_config_flag(work->tcon->share_conf, KSMBD_SHARE_FLAG_PIPE)) {
@@ -6432,13 +6434,14 @@ int smb2_write(struct ksmbd_work *work)
 	if (req->Channel != SMB2_CHANNEL_RDMA_V1 &&
 	    req->Channel != SMB2_CHANNEL_RDMA_V1_INVALIDATE) {
 		if (le16_to_cpu(req->DataOffset) ==
-		    (offsetof(struct smb2_write_req, Buffer) - 4)) {
+		    offsetof(struct smb2_write_req, Buffer)) {
 			data_buf = (char *)&req->Buffer[0];
 		} else {
-			if ((u64)le16_to_cpu(req->DataOffset) + length > get_rfc1002_len(req)) {
+			if ((u64)le16_to_cpu(req->DataOffset) + length >
+			    get_rfc1002_len(work->request_buf)) {
 				pr_err("invalid write data offset %u, smb_len %u\n",
 				       le16_to_cpu(req->DataOffset),
-				       get_rfc1002_len(req));
+				       get_rfc1002_len(work->request_buf));
 				err = -EINVAL;
 				goto out;
 			}
@@ -6476,7 +6479,7 @@ int smb2_write(struct ksmbd_work *work)
 	rsp->DataLength = cpu_to_le32(nbytes);
 	rsp->DataRemaining = 0;
 	rsp->Reserved2 = 0;
-	inc_rfc1001_len(rsp_org, 16);
+	inc_rfc1001_len(work->response_buf, 16);
 	ksmbd_fd_put(work, fp);
 	return 0;
 
@@ -6510,10 +6513,9 @@ int smb2_write(struct ksmbd_work *work)
 int smb2_flush(struct ksmbd_work *work)
 {
 	struct smb2_flush_req *req;
-	struct smb2_flush_rsp *rsp, *rsp_org;
+	struct smb2_flush_rsp *rsp;
 	int err;
 
-	rsp_org = work->response_buf;
 	WORK_BUFFERS(work, req, rsp);
 
 	ksmbd_debug(SMB, "SMB2_FLUSH called for fid %llu\n",
@@ -6527,7 +6529,7 @@ int smb2_flush(struct ksmbd_work *work)
 
 	rsp->StructureSize = cpu_to_le16(4);
 	rsp->Reserved = 0;
-	inc_rfc1001_len(rsp_org, 4);
+	inc_rfc1001_len(work->response_buf, 4);
 	return 0;
 
 out:
@@ -6548,7 +6550,7 @@ int smb2_flush(struct ksmbd_work *work)
 int smb2_cancel(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_hdr *hdr = work->request_buf;
+	struct smb2_hdr *hdr = smb2_get_msg(work->request_buf);
 	struct smb2_hdr *chdr;
 	struct ksmbd_work *cancel_work = NULL;
 	int canceled = 0;
@@ -6563,7 +6565,7 @@ int smb2_cancel(struct ksmbd_work *work)
 		spin_lock(&conn->request_lock);
 		list_for_each_entry(cancel_work, command_list,
 				    async_request_entry) {
-			chdr = cancel_work->request_buf;
+			chdr = smb2_get_msg(cancel_work->request_buf);
 
 			if (cancel_work->async_id !=
 			    le64_to_cpu(hdr->Id.AsyncId))
@@ -6582,7 +6584,7 @@ int smb2_cancel(struct ksmbd_work *work)
 
 		spin_lock(&conn->request_lock);
 		list_for_each_entry(cancel_work, command_list, request_entry) {
-			chdr = cancel_work->request_buf;
+			chdr = smb2_get_msg(cancel_work->request_buf);
 
 			if (chdr->MessageId != hdr->MessageId ||
 			    cancel_work == work)
@@ -6717,8 +6719,8 @@ static inline bool lock_defer_pending(struct file_lock *fl)
  */
 int smb2_lock(struct ksmbd_work *work)
 {
-	struct smb2_lock_req *req = work->request_buf;
-	struct smb2_lock_rsp *rsp = work->response_buf;
+	struct smb2_lock_req *req = smb2_get_msg(work->request_buf);
+	struct smb2_lock_rsp *rsp = smb2_get_msg(work->response_buf);
 	struct smb2_lock_element *lock_ele;
 	struct ksmbd_file *fp = NULL;
 	struct file_lock *flock = NULL;
@@ -7025,7 +7027,7 @@ int smb2_lock(struct ksmbd_work *work)
 	ksmbd_debug(SMB, "successful in taking lock\n");
 	rsp->hdr.Status = STATUS_SUCCESS;
 	rsp->Reserved = 0;
-	inc_rfc1001_len(rsp, 4);
+	inc_rfc1001_len(work->response_buf, 4);
 	ksmbd_fd_put(work, fp);
 	return 0;
 
@@ -7498,13 +7500,12 @@ static int fsctl_request_resume_key(struct ksmbd_work *work,
 int smb2_ioctl(struct ksmbd_work *work)
 {
 	struct smb2_ioctl_req *req;
-	struct smb2_ioctl_rsp *rsp, *rsp_org;
+	struct smb2_ioctl_rsp *rsp;
 	unsigned int cnt_code, nbytes = 0, out_buf_len, in_buf_len;
 	u64 id = KSMBD_NO_FID;
 	struct ksmbd_conn *conn = work->conn;
 	int ret = 0;
 
-	rsp_org = work->response_buf;
 	if (work->next_smb2_rcv_hdr_off) {
 		req = ksmbd_req_buf_next(work);
 		rsp = ksmbd_resp_buf_next(work);
@@ -7514,8 +7515,8 @@ int smb2_ioctl(struct ksmbd_work *work)
 			id = work->compound_fid;
 		}
 	} else {
-		req = work->request_buf;
-		rsp = work->response_buf;
+		req = smb2_get_msg(work->request_buf);
+		rsp = smb2_get_msg(work->response_buf);
 	}
 
 	if (!has_file_id(id))
@@ -7795,7 +7796,7 @@ int smb2_ioctl(struct ksmbd_work *work)
 	rsp->Reserved = cpu_to_le16(0);
 	rsp->Flags = cpu_to_le32(0);
 	rsp->Reserved2 = cpu_to_le32(0);
-	inc_rfc1001_len(rsp_org, 48 + nbytes);
+	inc_rfc1001_len(work->response_buf, 48 + nbytes);
 
 	return 0;
 
@@ -7822,8 +7823,8 @@ int smb2_ioctl(struct ksmbd_work *work)
  */
 static void smb20_oplock_break_ack(struct ksmbd_work *work)
 {
-	struct smb2_oplock_break *req = work->request_buf;
-	struct smb2_oplock_break *rsp = work->response_buf;
+	struct smb2_oplock_break *req = smb2_get_msg(work->request_buf);
+	struct smb2_oplock_break *rsp = smb2_get_msg(work->response_buf);
 	struct ksmbd_file *fp;
 	struct oplock_info *opinfo = NULL;
 	__le32 err = 0;
@@ -7930,7 +7931,7 @@ static void smb20_oplock_break_ack(struct ksmbd_work *work)
 	rsp->Reserved2 = 0;
 	rsp->VolatileFid = cpu_to_le64(volatile_id);
 	rsp->PersistentFid = cpu_to_le64(persistent_id);
-	inc_rfc1001_len(rsp, 24);
+	inc_rfc1001_len(work->response_buf, 24);
 	return;
 
 err_out:
@@ -7966,8 +7967,8 @@ static int check_lease_state(struct lease *lease, __le32 req_state)
 static void smb21_lease_break_ack(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_lease_ack *req = work->request_buf;
-	struct smb2_lease_ack *rsp = work->response_buf;
+	struct smb2_lease_ack *req = smb2_get_msg(work->request_buf);
+	struct smb2_lease_ack *rsp = smb2_get_msg(work->response_buf);
 	struct oplock_info *opinfo;
 	__le32 err = 0;
 	int ret = 0;
@@ -8079,7 +8080,7 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	memcpy(rsp->LeaseKey, req->LeaseKey, 16);
 	rsp->LeaseState = lease_state;
 	rsp->LeaseDuration = 0;
-	inc_rfc1001_len(rsp, 36);
+	inc_rfc1001_len(work->response_buf, 36);
 	return;
 
 err_out:
@@ -8100,8 +8101,8 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
  */
 int smb2_oplock_break(struct ksmbd_work *work)
 {
-	struct smb2_oplock_break *req = work->request_buf;
-	struct smb2_oplock_break *rsp = work->response_buf;
+	struct smb2_oplock_break *req = smb2_get_msg(work->request_buf);
+	struct smb2_oplock_break *rsp = smb2_get_msg(work->response_buf);
 
 	switch (le16_to_cpu(req->StructureSize)) {
 	case OP_BREAK_STRUCT_SIZE_20:
@@ -8153,7 +8154,7 @@ int smb2_notify(struct ksmbd_work *work)
  */
 bool smb2_is_sign_req(struct ksmbd_work *work, unsigned int command)
 {
-	struct smb2_hdr *rcv_hdr2 = work->request_buf;
+	struct smb2_hdr *rcv_hdr2 = smb2_get_msg(work->request_buf);
 
 	if ((rcv_hdr2->Flags & SMB2_FLAGS_SIGNED) &&
 	    command != SMB2_NEGOTIATE_HE &&
@@ -8172,22 +8173,22 @@ bool smb2_is_sign_req(struct ksmbd_work *work, unsigned int command)
  */
 int smb2_check_sign_req(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr, *hdr_org;
+	struct smb2_hdr *hdr;
 	char signature_req[SMB2_SIGNATURE_SIZE];
 	char signature[SMB2_HMACSHA256_SIZE];
 	struct kvec iov[1];
 	size_t len;
 
-	hdr_org = hdr = work->request_buf;
+	hdr = smb2_get_msg(work->request_buf);
 	if (work->next_smb2_rcv_hdr_off)
 		hdr = ksmbd_req_buf_next(work);
 
 	if (!hdr->NextCommand && !work->next_smb2_rcv_hdr_off)
-		len = be32_to_cpu(hdr_org->smb2_buf_length);
+		len = get_rfc1002_len(work->request_buf);
 	else if (hdr->NextCommand)
 		len = le32_to_cpu(hdr->NextCommand);
 	else
-		len = be32_to_cpu(hdr_org->smb2_buf_length) -
+		len = get_rfc1002_len(work->request_buf) -
 			work->next_smb2_rcv_hdr_off;
 
 	memcpy(signature_req, hdr->Signature, SMB2_SIGNATURE_SIZE);
@@ -8215,25 +8216,26 @@ int smb2_check_sign_req(struct ksmbd_work *work)
  */
 void smb2_set_sign_rsp(struct ksmbd_work *work)
 {
-	struct smb2_hdr *hdr, *hdr_org;
+	struct smb2_hdr *hdr;
 	struct smb2_hdr *req_hdr;
 	char signature[SMB2_HMACSHA256_SIZE];
 	struct kvec iov[2];
 	size_t len;
 	int n_vec = 1;
 
-	hdr_org = hdr = work->response_buf;
+	hdr = smb2_get_msg(work->response_buf);
 	if (work->next_smb2_rsp_hdr_off)
 		hdr = ksmbd_resp_buf_next(work);
 
 	req_hdr = ksmbd_req_buf_next(work);
 
 	if (!work->next_smb2_rsp_hdr_off) {
-		len = get_rfc1002_len(hdr_org);
+		len = get_rfc1002_len(work->response_buf);
 		if (req_hdr->NextCommand)
 			len = ALIGN(len, 8);
 	} else {
-		len = get_rfc1002_len(hdr_org) - work->next_smb2_rsp_hdr_off;
+		len = get_rfc1002_len(work->response_buf) -
+			work->next_smb2_rsp_hdr_off;
 		len = ALIGN(len, 8);
 	}
 
@@ -8269,23 +8271,23 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
 	char *signing_key;
-	struct smb2_hdr *hdr, *hdr_org;
+	struct smb2_hdr *hdr;
 	struct channel *chann;
 	char signature_req[SMB2_SIGNATURE_SIZE];
 	char signature[SMB2_CMACAES_SIZE];
 	struct kvec iov[1];
 	size_t len;
 
-	hdr_org = hdr = work->request_buf;
+	hdr = smb2_get_msg(work->request_buf);
 	if (work->next_smb2_rcv_hdr_off)
 		hdr = ksmbd_req_buf_next(work);
 
 	if (!hdr->NextCommand && !work->next_smb2_rcv_hdr_off)
-		len = be32_to_cpu(hdr_org->smb2_buf_length);
+		len = get_rfc1002_len(work->request_buf);
 	else if (hdr->NextCommand)
 		len = le32_to_cpu(hdr->NextCommand);
 	else
-		len = be32_to_cpu(hdr_org->smb2_buf_length) -
+		len = get_rfc1002_len(work->request_buf) -
 			work->next_smb2_rcv_hdr_off;
 
 	if (le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
@@ -8326,8 +8328,7 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 void smb3_set_sign_rsp(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_hdr *req_hdr;
-	struct smb2_hdr *hdr, *hdr_org;
+	struct smb2_hdr *req_hdr, *hdr;
 	struct channel *chann;
 	char signature[SMB2_CMACAES_SIZE];
 	struct kvec iov[2];
@@ -8335,18 +8336,19 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
 	size_t len;
 	char *signing_key;
 
-	hdr_org = hdr = work->response_buf;
+	hdr = smb2_get_msg(work->response_buf);
 	if (work->next_smb2_rsp_hdr_off)
 		hdr = ksmbd_resp_buf_next(work);
 
 	req_hdr = ksmbd_req_buf_next(work);
 
 	if (!work->next_smb2_rsp_hdr_off) {
-		len = get_rfc1002_len(hdr_org);
+		len = get_rfc1002_len(work->response_buf);
 		if (req_hdr->NextCommand)
 			len = ALIGN(len, 8);
 	} else {
-		len = get_rfc1002_len(hdr_org) - work->next_smb2_rsp_hdr_off;
+		len = get_rfc1002_len(work->response_buf) -
+			work->next_smb2_rsp_hdr_off;
 		len = ALIGN(len, 8);
 	}
 
@@ -8399,7 +8401,7 @@ void smb3_preauth_hash_rsp(struct ksmbd_work *work)
 
 	if (le16_to_cpu(req->Command) == SMB2_NEGOTIATE_HE &&
 	    conn->preauth_info)
-		ksmbd_gen_preauth_integrity_hash(conn, (char *)rsp,
+		ksmbd_gen_preauth_integrity_hash(conn, work->response_buf,
 						 conn->preauth_info->Preauth_HashValue);
 
 	if (le16_to_cpu(rsp->Command) == SMB2_SESSION_SETUP_HE && sess) {
@@ -8417,7 +8419,7 @@ void smb3_preauth_hash_rsp(struct ksmbd_work *work)
 			if (!hash_value)
 				return;
 		}
-		ksmbd_gen_preauth_integrity_hash(conn, (char *)rsp,
+		ksmbd_gen_preauth_integrity_hash(conn, work->response_buf,
 						 hash_value);
 	}
 }
@@ -8499,7 +8501,6 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 	struct ksmbd_conn *conn = work->conn;
 	struct ksmbd_session *sess;
 	char *buf = work->request_buf;
-	struct smb2_hdr *hdr;
 	unsigned int pdu_length = get_rfc1002_len(buf);
 	struct kvec iov[2];
 	int buf_data_size = pdu_length + 4 -
@@ -8534,8 +8535,7 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 		return rc;
 
 	memmove(buf + 4, iov[1].iov_base, buf_data_size);
-	hdr = (struct smb2_hdr *)buf;
-	hdr->smb2_buf_length = cpu_to_be32(buf_data_size);
+	*(__be32 *)buf = cpu_to_be32(buf_data_size);
 
 	return rc;
 }
@@ -8543,7 +8543,7 @@ int smb3_decrypt_req(struct ksmbd_work *work)
 bool smb3_11_final_sess_setup_resp(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_hdr *rsp = work->response_buf;
+	struct smb2_hdr *rsp = smb2_get_msg(work->response_buf);
 
 	if (conn->dialect < SMB30_PROT_ID)
 		return false;
diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
index ff5a2f01d34a..a70f5461bffe 100644
--- a/fs/ksmbd/smb2pdu.h
+++ b/fs/ksmbd/smb2pdu.h
@@ -130,11 +130,6 @@
 	cpu_to_le16(__SMB2_HEADER_STRUCTURE_SIZE)
 
 struct smb2_hdr {
-	__be32 smb2_buf_length;	/* big endian on wire */
-				/*
-				 * length is only two or three bytes - with
-				 * one or two byte type preceding it that MBZ
-				 */
 	__le32 ProtocolId;	/* 0xFE 'S' 'M' 'B' */
 	__le16 StructureSize;	/* 64 */
 	__le16 CreditCharge;	/* MBZ */
@@ -253,14 +248,14 @@ struct preauth_integrity_info {
 	__u8			Preauth_HashValue[PREAUTH_HASHVALUE_SIZE];
 };
 
-/* offset is sizeof smb2_negotiate_rsp - 4 but rounded up to 8 bytes. */
+/* offset is sizeof smb2_negotiate_rsp but rounded up to 8 bytes. */
 #ifdef CONFIG_SMB_SERVER_KERBEROS5
-/* sizeof(struct smb2_negotiate_rsp) - 4 =
+/* sizeof(struct smb2_negotiate_rsp) =
  * header(64) + response(64) + GSS_LENGTH(96) + GSS_PADDING(0)
  */
 #define OFFSET_OF_NEG_CONTEXT	0xe0
 #else
-/* sizeof(struct smb2_negotiate_rsp) - 4 =
+/* sizeof(struct smb2_negotiate_rsp) =
  * header(64) + response(64) + GSS_LENGTH(74) + GSS_PADDING(6)
  */
 #define OFFSET_OF_NEG_CONTEXT	0xd0
@@ -1705,4 +1700,13 @@ int smb2_ioctl(struct ksmbd_work *work);
 int smb2_oplock_break(struct ksmbd_work *work);
 int smb2_notify(struct ksmbd_work *ksmbd_work);
 
+/*
+ * Get the body of the smb2 message excluding the 4 byte rfc1002 headers
+ * from request/response buffer.
+ */
+static inline void *smb2_get_msg(void *buf)
+{
+	return buf + 4;
+}
+
 #endif	/* _SMB2PDU_H */
diff --git a/fs/ksmbd/smb_common.c b/fs/ksmbd/smb_common.c
index e1e5a071678e..ef7f42b0290a 100644
--- a/fs/ksmbd/smb_common.c
+++ b/fs/ksmbd/smb_common.c
@@ -239,14 +239,14 @@ int ksmbd_lookup_dialect_by_id(__le16 *cli_dialects, __le16 dialects_count)
 static int ksmbd_negotiate_smb_dialect(void *buf)
 {
 	int smb_buf_length = get_rfc1002_len(buf);
-	__le32 proto = ((struct smb2_hdr *)buf)->ProtocolId;
+	__le32 proto = ((struct smb2_hdr *)smb2_get_msg(buf))->ProtocolId;
 
 	if (proto == SMB2_PROTO_NUMBER) {
 		struct smb2_negotiate_req *req;
 		int smb2_neg_size =
-			offsetof(struct smb2_negotiate_req, Dialects) - 4;
+			offsetof(struct smb2_negotiate_req, Dialects);
 
-		req = (struct smb2_negotiate_req *)buf;
+		req = (struct smb2_negotiate_req *)smb2_get_msg(buf);
 		if (smb2_neg_size > smb_buf_length)
 			goto err_out;
 
@@ -445,11 +445,12 @@ int ksmbd_smb_negotiate_common(struct ksmbd_work *work, unsigned int command)
 	struct ksmbd_conn *conn = work->conn;
 	int ret;
 
-	conn->dialect = ksmbd_negotiate_smb_dialect(work->request_buf);
+	conn->dialect =
+		ksmbd_negotiate_smb_dialect(work->request_buf);
 	ksmbd_debug(SMB, "conn->dialect 0x%x\n", conn->dialect);
 
 	if (command == SMB2_NEGOTIATE_HE) {
-		struct smb2_hdr *smb2_hdr = work->request_buf;
+		struct smb2_hdr *smb2_hdr = smb2_get_msg(work->request_buf);
 
 		if (smb2_hdr->ProtocolId != SMB2_PROTO_NUMBER) {
 			ksmbd_debug(SMB, "Downgrade to SMB1 negotiation\n");
diff --git a/fs/ksmbd/smb_common.h b/fs/ksmbd/smb_common.h
index 6e79e7577f6b..35ca9b7d9979 100644
--- a/fs/ksmbd/smb_common.h
+++ b/fs/ksmbd/smb_common.h
@@ -477,12 +477,6 @@ struct smb_version_cmds {
 	int (*proc)(struct ksmbd_work *swork);
 };
 
-static inline size_t
-smb2_hdr_size_no_buflen(struct smb_version_values *vals)
-{
-	return vals->header_size - 4;
-}
-
 int ksmbd_min_protocol(void);
 int ksmbd_max_protocol(void);
 
diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 6330dfc302ff..7e57cbb0bb35 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -484,7 +484,7 @@ static int smb_direct_check_recvmsg(struct smb_direct_recvmsg *recvmsg)
 		struct smb_direct_data_transfer *req =
 			(struct smb_direct_data_transfer *)recvmsg->packet;
 		struct smb2_hdr *hdr = (struct smb2_hdr *)(recvmsg->packet
-				+ le32_to_cpu(req->data_offset) - 4);
+				+ le32_to_cpu(req->data_offset));
 		ksmbd_debug(RDMA,
 			    "CreditGranted: %u, CreditRequested: %u, DataLength: %u, RemainingDataLength: %u, SMB: %x, Command: %u\n",
 			    le16_to_cpu(req->credits_granted),
-- 
2.25.1

