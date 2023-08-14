Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FF9077BCE4
	for <lists+linux-cifs@lfdr.de>; Mon, 14 Aug 2023 17:24:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232860AbjHNPXm (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 14 Aug 2023 11:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232922AbjHNPXS (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 14 Aug 2023 11:23:18 -0400
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD95910CC
        for <linux-cifs@vger.kernel.org>; Mon, 14 Aug 2023 08:23:14 -0700 (PDT)
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-1bc5acc627dso28971895ad.1
        for <linux-cifs@vger.kernel.org>; Mon, 14 Aug 2023 08:23:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692026594; x=1692631394;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OtMG0DQtlP2b2FWMWiSau3e98R1Mdy3L21eB8lE1r5o=;
        b=jT8fyqLuw9icYzOsfGwSjWyGDdToH70L+Cr14UjchfPRZRCiz0SLVOwuBfuDZ2+i16
         9TOl3YNnKI1Y9jUP1SG0+ITwrYriRXCakQorDwkbAm7oWmcDFm5JYZqXFjrj8QyAzPB2
         Uk9SivJpvHpX60Gj9XMIIyQlHfW9jdjtcK+Oj5uPpG4nrP1kOb2Sps7eqwzdjI3KAsA8
         ZJofn4yy/++nRzi/O0TW2S32MDJ2YC0pDUSuZ2VSGbDHCSuv6I8aHURYtQLt43vUs0gr
         FlT5N0p2sck+L545a5FwmycPWVlZGkgXu4Fcknai4N00jTVIxsUQMpRs3rYTtoGtpaSZ
         1bSg==
X-Gm-Message-State: AOJu0YzbLs4o57u57MpnGjkUDgP0kyXbArplM2Tgzn2HCQzoLX2/CaDb
        nyUGRKQBi6O4yj2DOl+xo++anwTf72A=
X-Google-Smtp-Source: AGHT+IEmJwASuLjzN7oXJQZB/2GFF0xc+17foWt55M6WD7gdsMvYcpGU322RJqsQH6XiT4hH/Xr+Pw==
X-Received: by 2002:a17:902:ce86:b0:1b7:f99f:63c9 with SMTP id f6-20020a170902ce8600b001b7f99f63c9mr9570782plg.67.1692026593179;
        Mon, 14 Aug 2023 08:23:13 -0700 (PDT)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id ij13-20020a170902ab4d00b001b9c5e07bc3sm9726244plb.238.2023.08.14.08.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Aug 2023 08:23:12 -0700 (PDT)
From:   Namjae Jeon <linkinjeon@kernel.org>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, senozhatsky@chromium.org, tom@talpey.com,
        hyc.lee@gmail.com, atteh.mailbox@gmail.com,
        Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 1/2] ksmbd: add support for read compound
Date:   Tue, 15 Aug 2023 00:19:02 +0900
Message-Id: <20230814151903.7931-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

MacOS sends a compound request including read to the server
(e.g. open-read-close). So far, ksmbd has not handled read as
a compound request. For compatibility between ksmbd and an OS that
supports SMB, This patch provides compound support for read requests.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/smb/server/auth.c       |   6 +-
 fs/smb/server/connection.c |  54 +---
 fs/smb/server/connection.h |   2 +-
 fs/smb/server/ksmbd_work.c |  90 ++++++-
 fs/smb/server/ksmbd_work.h |  34 ++-
 fs/smb/server/oplock.c     |  17 +-
 fs/smb/server/server.c     |   5 +-
 fs/smb/server/smb2pdu.c    | 501 ++++++++++++++++---------------------
 fs/smb/server/smb_common.c |  13 +-
 fs/smb/server/vfs.c        |   4 +-
 fs/smb/server/vfs.h        |   4 +-
 11 files changed, 366 insertions(+), 364 deletions(-)

diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index 5e5e120edcc2..50a16b90956e 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -1029,11 +1029,15 @@ static struct scatterlist *ksmbd_init_sg(struct kvec *iov, unsigned int nvec,
 {
 	struct scatterlist *sg;
 	unsigned int assoc_data_len = sizeof(struct smb2_transform_hdr) - 20;
-	int i, nr_entries[3] = {0}, total_entries = 0, sg_idx = 0;
+	int i, *nr_entries, total_entries = 0, sg_idx = 0;
 
 	if (!nvec)
 		return NULL;
 
+	nr_entries = kcalloc(nvec, sizeof(int), GFP_KERNEL);
+	if (!nr_entries)
+		return NULL;
+
 	for (i = 0; i < nvec - 1; i++) {
 		unsigned long kaddr = (unsigned long)iov[i + 1].iov_base;
 
diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index 2a717d158f02..081f9ea01663 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -123,28 +123,22 @@ void ksmbd_conn_enqueue_request(struct ksmbd_work *work)
 	}
 }
 
-int ksmbd_conn_try_dequeue_request(struct ksmbd_work *work)
+void ksmbd_conn_try_dequeue_request(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	int ret = 1;
 
 	if (list_empty(&work->request_entry) &&
 	    list_empty(&work->async_request_entry))
-		return 0;
+		return;
 
-	if (!work->multiRsp)
-		atomic_dec(&conn->req_running);
-	if (!work->multiRsp) {
-		spin_lock(&conn->request_lock);
-		list_del_init(&work->request_entry);
-		spin_unlock(&conn->request_lock);
-		if (work->asynchronous)
-			release_async_work(work);
-		ret = 0;
-	}
+	atomic_dec(&conn->req_running);
+	spin_lock(&conn->request_lock);
+	list_del_init(&work->request_entry);
+	spin_unlock(&conn->request_lock);
+	if (work->asynchronous)
+		release_async_work(work);
 
 	wake_up_all(&conn->req_running_q);
-	return ret;
 }
 
 void ksmbd_conn_lock(struct ksmbd_conn *conn)
@@ -193,41 +187,19 @@ void ksmbd_conn_wait_idle(struct ksmbd_conn *conn, u64 sess_id)
 int ksmbd_conn_write(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	size_t len = 0;
 	int sent;
-	struct kvec iov[3];
-	int iov_idx = 0;
 
 	if (!work->response_buf) {
 		pr_err("NULL response header\n");
 		return -EINVAL;
 	}
 
-	if (work->tr_buf) {
-		iov[iov_idx] = (struct kvec) { work->tr_buf,
-				sizeof(struct smb2_transform_hdr) + 4 };
-		len += iov[iov_idx++].iov_len;
-	}
-
-	if (work->aux_payload_sz) {
-		iov[iov_idx] = (struct kvec) { work->response_buf, work->resp_hdr_sz };
-		len += iov[iov_idx++].iov_len;
-		iov[iov_idx] = (struct kvec) { work->aux_payload_buf, work->aux_payload_sz };
-		len += iov[iov_idx++].iov_len;
-	} else {
-		if (work->tr_buf)
-			iov[iov_idx].iov_len = work->resp_hdr_sz;
-		else
-			iov[iov_idx].iov_len = get_rfc1002_len(work->response_buf) + 4;
-		iov[iov_idx].iov_base = work->response_buf;
-		len += iov[iov_idx++].iov_len;
-	}
-
 	ksmbd_conn_lock(conn);
-	sent = conn->transport->ops->writev(conn->transport, &iov[0],
-					iov_idx, len,
-					work->need_invalidate_rkey,
-					work->remote_key);
+	sent = conn->transport->ops->writev(conn->transport, work->iov,
+			work->iov_cnt,
+			get_rfc1002_len(work->iov[0].iov_base) + 4,
+			work->need_invalidate_rkey,
+			work->remote_key);
 	ksmbd_conn_unlock(conn);
 
 	if (sent < 0) {
diff --git a/fs/smb/server/connection.h b/fs/smb/server/connection.h
index ad8dfaa48ffb..ab2583f030ce 100644
--- a/fs/smb/server/connection.h
+++ b/fs/smb/server/connection.h
@@ -158,7 +158,7 @@ int ksmbd_conn_rdma_write(struct ksmbd_conn *conn,
 			  struct smb2_buffer_desc_v1 *desc,
 			  unsigned int desc_len);
 void ksmbd_conn_enqueue_request(struct ksmbd_work *work);
-int ksmbd_conn_try_dequeue_request(struct ksmbd_work *work);
+void ksmbd_conn_try_dequeue_request(struct ksmbd_work *work);
 void ksmbd_conn_init_server_callbacks(struct ksmbd_conn_ops *ops);
 int ksmbd_conn_handler_loop(void *p);
 int ksmbd_conn_transport_init(void);
diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
index 14b9caebf7a4..3fc88974346e 100644
--- a/fs/smb/server/ksmbd_work.c
+++ b/fs/smb/server/ksmbd_work.c
@@ -27,18 +27,34 @@ struct ksmbd_work *ksmbd_alloc_work_struct(void)
 		INIT_LIST_HEAD(&work->async_request_entry);
 		INIT_LIST_HEAD(&work->fp_entry);
 		INIT_LIST_HEAD(&work->interim_entry);
+		INIT_LIST_HEAD(&work->aux_read_list);
+		work->iov = kzalloc(sizeof(struct kvec) * 4, GFP_KERNEL);
+		if (!work->iov) {
+			kmem_cache_free(work_cache, work);
+			work = NULL;
+		}
+		work->iov_alloc_cnt = 4;
 	}
 	return work;
 }
 
 void ksmbd_free_work_struct(struct ksmbd_work *work)
 {
+	struct aux_read *ar, *tmp;
+
 	WARN_ON(work->saved_cred != NULL);
 
 	kvfree(work->response_buf);
-	kvfree(work->aux_payload_buf);
+
+	list_for_each_entry_safe(ar, tmp, &work->aux_read_list, entry) {
+		kvfree(ar->buf);
+		list_del(&ar->entry);
+		kfree(ar);
+	}
+
 	kfree(work->tr_buf);
 	kvfree(work->request_buf);
+	kfree(work->iov);
 	if (work->async_id)
 		ksmbd_release_id(&work->conn->async_ida, work->async_id);
 	kmem_cache_free(work_cache, work);
@@ -77,3 +93,75 @@ bool ksmbd_queue_work(struct ksmbd_work *work)
 {
 	return queue_work(ksmbd_wq, &work->work);
 }
+
+static int ksmbd_realloc_iov_pin(struct ksmbd_work *work, void *ib,
+				 unsigned int ib_len)
+{
+
+	if (work->iov_alloc_cnt <= work->iov_cnt) {
+		struct kvec *new;
+
+		work->iov_alloc_cnt += 4;
+		new = krealloc(work->iov,
+			       sizeof(struct kvec) * work->iov_alloc_cnt,
+			       GFP_KERNEL | __GFP_ZERO);
+		if (!new)
+			return -ENOMEM;
+		work->iov = new;
+	}
+
+	work->iov[++work->iov_idx].iov_base = ib;
+	work->iov[work->iov_idx].iov_len = ib_len;
+	work->iov_cnt++;
+
+	return 0;
+}
+
+static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len,
+			       void *aux_buf, unsigned int aux_size)
+{
+	/* Plus rfc_length size on first iov */
+	if (!work->iov_idx) {
+		work->iov[work->iov_idx].iov_base = work->response_buf;
+		*(__be32 *)work->iov[0].iov_base = 0;
+		work->iov[work->iov_idx].iov_len = 4;
+		work->iov_cnt++;
+	}
+
+	ksmbd_realloc_iov_pin(work, ib, len);
+	inc_rfc1001_len(work->iov[0].iov_base, len);
+
+	if (aux_size) {
+		struct aux_read *ar;
+
+		ksmbd_realloc_iov_pin(work, aux_buf, aux_size);
+		inc_rfc1001_len(work->iov[0].iov_base, aux_size);
+
+		ar = kmalloc(sizeof(struct aux_read), GFP_KERNEL);
+		if (!ar)
+			return -ENOMEM;
+
+		ar->buf = aux_buf;
+		list_add(&ar->entry, &work->aux_read_list);
+	}
+
+	return 0;
+}
+
+int ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len)
+{
+	return __ksmbd_iov_pin_rsp(work, ib, len, NULL, 0);
+}
+
+int ksmbd_iov_pin_rsp_read(struct ksmbd_work *work, void *ib, int len,
+			   void *aux_buf, unsigned int aux_size)
+{
+	return __ksmbd_iov_pin_rsp(work, ib, len, aux_buf, aux_size);
+}
+
+void ksmbd_iov_reset(struct ksmbd_work *work)
+{
+	work->iov_idx = 0;
+	work->iov_cnt = 0;
+	*(__be32 *)work->iov[0].iov_base = 0;
+}
diff --git a/fs/smb/server/ksmbd_work.h b/fs/smb/server/ksmbd_work.h
index f8ae6144c0ae..255157eb26dc 100644
--- a/fs/smb/server/ksmbd_work.h
+++ b/fs/smb/server/ksmbd_work.h
@@ -19,6 +19,11 @@ enum {
 	KSMBD_WORK_CLOSED,
 };
 
+struct aux_read {
+	void *buf;
+	struct list_head entry;
+};
+
 /* one of these for every pending CIFS request at the connection */
 struct ksmbd_work {
 	/* Server corresponding to this mid */
@@ -31,13 +36,19 @@ struct ksmbd_work {
 	/* Response buffer */
 	void                            *response_buf;
 
-	/* Read data buffer */
-	void                            *aux_payload_buf;
+	struct list_head		aux_read_list;
+
+	struct kvec			*iov;
+	int				iov_alloc_cnt;
+	int				iov_cnt;
+	int				iov_idx;
 
 	/* Next cmd hdr in compound req buf*/
 	int                             next_smb2_rcv_hdr_off;
 	/* Next cmd hdr in compound rsp buf*/
 	int                             next_smb2_rsp_hdr_off;
+	/* Current cmd hdr in compound rsp buf*/
+	int                             curr_smb2_rsp_hdr_off;
 
 	/*
 	 * Current Local FID assigned compound response if SMB2 CREATE
@@ -53,16 +64,11 @@ struct ksmbd_work {
 	unsigned int			credits_granted;
 
 	/* response smb header size */
-	unsigned int                    resp_hdr_sz;
 	unsigned int                    response_sz;
-	/* Read data count */
-	unsigned int                    aux_payload_sz;
 
 	void				*tr_buf;
 
 	unsigned char			state;
-	/* Multiple responses for one request e.g. SMB ECHO */
-	bool                            multiRsp:1;
 	/* No response for cancelled request */
 	bool                            send_no_response:1;
 	/* Request is encrypted */
@@ -95,6 +101,15 @@ static inline void *ksmbd_resp_buf_next(struct ksmbd_work *work)
 	return work->response_buf + work->next_smb2_rsp_hdr_off + 4;
 }
 
+/**
+ * ksmbd_resp_buf_curr - Get current buffer on compound response.
+ * @work: smb work containing response buffer
+ */
+static inline void *ksmbd_resp_buf_curr(struct ksmbd_work *work)
+{
+	return work->response_buf + work->curr_smb2_rsp_hdr_off + 4;
+}
+
 /**
  * ksmbd_req_buf_next - Get next buffer on compound request.
  * @work: smb work containing response buffer
@@ -113,5 +128,8 @@ int ksmbd_work_pool_init(void);
 int ksmbd_workqueue_init(void);
 void ksmbd_workqueue_destroy(void);
 bool ksmbd_queue_work(struct ksmbd_work *work);
-
+int ksmbd_iov_pin_rsp_read(struct ksmbd_work *work, void *ib, int len,
+			   void *aux_buf, unsigned int aux_size);
+int ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len);
+void ksmbd_iov_reset(struct ksmbd_work *work);
 #endif /* __KSMBD_WORK_H__ */
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 844b303baf29..c42b2cff6146 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -639,7 +639,6 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 {
 	struct smb2_oplock_break *rsp = NULL;
 	struct ksmbd_work *work = container_of(wk, struct ksmbd_work, work);
-	struct ksmbd_conn *conn = work->conn;
 	struct oplock_break_info *br_info = work->request_buf;
 	struct smb2_hdr *rsp_hdr;
 	struct ksmbd_file *fp;
@@ -656,8 +655,6 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 
 	rsp_hdr = smb2_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
-	*(__be32 *)work->response_buf =
-		cpu_to_be32(conn->vals->header_size);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->CreditRequest = cpu_to_le16(0);
@@ -684,13 +681,15 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 	rsp->PersistentFid = fp->persistent_id;
 	rsp->VolatileFid = fp->volatile_id;
 
-	inc_rfc1001_len(work->response_buf, 24);
+	ksmbd_fd_put(work, fp);
+	if (ksmbd_iov_pin_rsp(work, (void *)rsp,
+			      sizeof(struct smb2_oplock_break)))
+		goto out;
 
 	ksmbd_debug(OPLOCK,
 		    "sending oplock break v_id %llu p_id = %llu lock level = %d\n",
 		    rsp->VolatileFid, rsp->PersistentFid, rsp->OplockLevel);
 
-	ksmbd_fd_put(work, fp);
 	ksmbd_conn_write(work);
 
 out:
@@ -751,7 +750,6 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 	struct smb2_lease_break *rsp = NULL;
 	struct ksmbd_work *work = container_of(wk, struct ksmbd_work, work);
 	struct lease_break_info *br_info = work->request_buf;
-	struct ksmbd_conn *conn = work->conn;
 	struct smb2_hdr *rsp_hdr;
 
 	if (allocate_oplock_break_buf(work)) {
@@ -761,8 +759,6 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 
 	rsp_hdr = smb2_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
-	*(__be32 *)work->response_buf =
-		cpu_to_be32(conn->vals->header_size);
 	rsp_hdr->ProtocolId = SMB2_PROTO_NUMBER;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->CreditRequest = cpu_to_le16(0);
@@ -791,7 +787,9 @@ static void __smb2_lease_break_noti(struct work_struct *wk)
 	rsp->AccessMaskHint = 0;
 	rsp->ShareMaskHint = 0;
 
-	inc_rfc1001_len(work->response_buf, 44);
+	if (ksmbd_iov_pin_rsp(work, (void *)rsp,
+			      sizeof(struct smb2_lease_break)))
+		goto out;
 
 	ksmbd_conn_write(work);
 
@@ -845,6 +843,7 @@ static int smb2_lease_break_noti(struct oplock_info *opinfo)
 			setup_async_work(in_work, NULL, NULL);
 			smb2_send_interim_resp(in_work, STATUS_PENDING);
 			list_del(&in_work->interim_entry);
+			ksmbd_iov_reset(in_work);
 		}
 		INIT_WORK(&work->work, __smb2_lease_break_noti);
 		ksmbd_queue_work(work);
diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index 9df121bdf349..7862a6eaa55f 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -163,6 +163,7 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 {
 	u16 command = 0;
 	int rc;
+	bool is_chained = false;
 
 	if (conn->ops->allocate_rsp_buf(work))
 		return;
@@ -229,11 +230,13 @@ static void __handle_ksmbd_work(struct ksmbd_work *work,
 			}
 		}
 
+		is_chained = is_chained_smb2_message(work);
+
 		if (work->sess &&
 		    (work->sess->sign || smb3_11_final_sess_setup_resp(work) ||
 		     conn->ops->is_sign_req(work, command)))
 			conn->ops->set_sign_rsp(work);
-	} while (is_chained_smb2_message(work));
+	} while (is_chained == true);
 
 	if (work->send_no_response)
 		return;
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 7cc1b0c47d0a..98b923d2af48 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -150,7 +150,9 @@ void smb2_set_err_rsp(struct ksmbd_work *work)
 		err_rsp->Reserved = 0;
 		err_rsp->ByteCount = 0;
 		err_rsp->ErrorData[0] = 0;
-		inc_rfc1001_len(work->response_buf, SMB2_ERROR_STRUCTURE_SIZE2);
+		ksmbd_iov_pin_rsp(work, (void *)err_rsp,
+				  work->conn->vals->header_size +
+				  SMB2_ERROR_STRUCTURE_SIZE2);
 	}
 }
 
@@ -245,9 +247,7 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 	struct smb2_hdr *rsp_hdr;
 	struct smb2_negotiate_rsp *rsp;
 	struct ksmbd_conn *conn = work->conn;
-
-	*(__be32 *)work->response_buf =
-		cpu_to_be32(conn->vals->header_size);
+	int err;
 
 	rsp_hdr = smb2_get_msg(work->response_buf);
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
@@ -286,12 +286,13 @@ int init_smb2_neg_rsp(struct ksmbd_work *work)
 	rsp->SecurityBufferLength = cpu_to_le16(AUTH_GSS_LENGTH);
 	ksmbd_copy_gss_neg_header((char *)(&rsp->hdr) +
 		le16_to_cpu(rsp->SecurityBufferOffset));
-	inc_rfc1001_len(work->response_buf,
-			sizeof(struct smb2_negotiate_rsp) -
-			sizeof(struct smb2_hdr) + AUTH_GSS_LENGTH);
 	rsp->SecurityMode = SMB2_NEGOTIATE_SIGNING_ENABLED_LE;
 	if (server_conf.signing == KSMBD_CONFIG_OPT_MANDATORY)
 		rsp->SecurityMode |= SMB2_NEGOTIATE_SIGNING_REQUIRED_LE;
+	err = ksmbd_iov_pin_rsp(work, rsp,
+				sizeof(struct smb2_negotiate_rsp) + AUTH_GSS_LENGTH);
+	if (err)
+		return err;
 	conn->use_spnego = true;
 
 	ksmbd_conn_set_need_negotiate(conn);
@@ -390,11 +391,12 @@ static void init_chained_smb2_rsp(struct ksmbd_work *work)
 	next_hdr_offset = le32_to_cpu(req->NextCommand);
 
 	new_len = ALIGN(len, 8);
-	inc_rfc1001_len(work->response_buf,
-			sizeof(struct smb2_hdr) + new_len - len);
+	work->iov[work->iov_idx].iov_len += (new_len - len);
+	inc_rfc1001_len(work->response_buf, new_len - len);
 	rsp->NextCommand = cpu_to_le32(new_len);
 
 	work->next_smb2_rcv_hdr_off += next_hdr_offset;
+	work->curr_smb2_rsp_hdr_off = work->next_smb2_rsp_hdr_off;
 	work->next_smb2_rsp_hdr_off += new_len;
 	ksmbd_debug(SMB,
 		    "Compound req new_len = %d rcv off = %d rsp off = %d\n",
@@ -470,10 +472,10 @@ bool is_chained_smb2_message(struct ksmbd_work *work)
 		len = len - get_rfc1002_len(work->response_buf);
 		if (len) {
 			ksmbd_debug(SMB, "padding len %u\n", len);
+			work->iov[work->iov_idx].iov_len += len;
 			inc_rfc1001_len(work->response_buf, len);
-			if (work->aux_payload_sz)
-				work->aux_payload_sz += len;
 		}
+		work->curr_smb2_rsp_hdr_off = work->next_smb2_rsp_hdr_off;
 	}
 	return false;
 }
@@ -488,11 +490,8 @@ int init_smb2_rsp_hdr(struct ksmbd_work *work)
 {
 	struct smb2_hdr *rsp_hdr = smb2_get_msg(work->response_buf);
 	struct smb2_hdr *rcv_hdr = smb2_get_msg(work->request_buf);
-	struct ksmbd_conn *conn = work->conn;
 
 	memset(rsp_hdr, 0, sizeof(struct smb2_hdr) + 2);
-	*(__be32 *)work->response_buf =
-		cpu_to_be32(conn->vals->header_size);
 	rsp_hdr->ProtocolId = rcv_hdr->ProtocolId;
 	rsp_hdr->StructureSize = SMB2_HEADER_STRUCTURE_SIZE;
 	rsp_hdr->Command = rcv_hdr->Command;
@@ -657,7 +656,7 @@ int setup_async_work(struct ksmbd_work *work, void (*fn)(void **), void **arg)
 	struct ksmbd_conn *conn = work->conn;
 	int id;
 
-	rsp_hdr = smb2_get_msg(work->response_buf);
+	rsp_hdr = ksmbd_resp_buf_next(work);
 	rsp_hdr->Flags |= SMB2_FLAGS_ASYNC_COMMAND;
 
 	id = ksmbd_acquire_async_msg_id(&conn->async_ida);
@@ -707,14 +706,12 @@ void smb2_send_interim_resp(struct ksmbd_work *work, __le32 status)
 {
 	struct smb2_hdr *rsp_hdr;
 
-	rsp_hdr = smb2_get_msg(work->response_buf);
+	rsp_hdr = ksmbd_resp_buf_next(work);
 	smb2_set_err_rsp(work);
 	rsp_hdr->Status = status;
 
-	work->multiRsp = 1;
 	ksmbd_conn_write(work);
 	rsp_hdr->Status = 0;
-	work->multiRsp = 0;
 }
 
 static __le32 smb2_get_reparse_tag_special_file(umode_t mode)
@@ -821,9 +818,8 @@ static void build_posix_ctxt(struct smb2_posix_neg_context *pneg_ctxt)
 	pneg_ctxt->Name[15] = 0x7C;
 }
 
-static void assemble_neg_contexts(struct ksmbd_conn *conn,
-				  struct smb2_negotiate_rsp *rsp,
-				  void *smb2_buf_len)
+static unsigned int assemble_neg_contexts(struct ksmbd_conn *conn,
+				  struct smb2_negotiate_rsp *rsp)
 {
 	char * const pneg_ctxt = (char *)rsp +
 			le32_to_cpu(rsp->NegotiateContextOffset);
@@ -834,7 +830,6 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 		    "assemble SMB2_PREAUTH_INTEGRITY_CAPABILITIES context\n");
 	build_preauth_ctxt((struct smb2_preauth_neg_context *)pneg_ctxt,
 			   conn->preauth_info->Preauth_HashId);
-	inc_rfc1001_len(smb2_buf_len, AUTH_GSS_PADDING);
 	ctxt_size = sizeof(struct smb2_preauth_neg_context);
 
 	if (conn->cipher_type) {
@@ -874,7 +869,7 @@ static void assemble_neg_contexts(struct ksmbd_conn *conn,
 	}
 
 	rsp->NegotiateContextCount = cpu_to_le16(neg_ctxt_cnt);
-	inc_rfc1001_len(smb2_buf_len, ctxt_size);
+	return ctxt_size + AUTH_GSS_PADDING;
 }
 
 static __le32 decode_preauth_ctxt(struct ksmbd_conn *conn,
@@ -1090,7 +1085,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 	struct smb2_negotiate_req *req = smb2_get_msg(work->request_buf);
 	struct smb2_negotiate_rsp *rsp = smb2_get_msg(work->response_buf);
 	int rc = 0;
-	unsigned int smb2_buf_len, smb2_neg_size;
+	unsigned int smb2_buf_len, smb2_neg_size, neg_ctxt_len = 0;
 	__le32 status;
 
 	ksmbd_debug(SMB, "Received negotiate request\n");
@@ -1183,7 +1178,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 						 conn->preauth_info->Preauth_HashValue);
 		rsp->NegotiateContextOffset =
 				cpu_to_le32(OFFSET_OF_NEG_CONTEXT);
-		assemble_neg_contexts(conn, rsp, work->response_buf);
+		neg_ctxt_len = assemble_neg_contexts(conn, rsp);
 		break;
 	case SMB302_PROT_ID:
 		init_smb3_02_server(conn);
@@ -1233,8 +1228,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 	rsp->SecurityBufferLength = cpu_to_le16(AUTH_GSS_LENGTH);
 	ksmbd_copy_gss_neg_header((char *)(&rsp->hdr) +
 				  le16_to_cpu(rsp->SecurityBufferOffset));
-	inc_rfc1001_len(work->response_buf, sizeof(struct smb2_negotiate_rsp) -
-			sizeof(struct smb2_hdr) + AUTH_GSS_LENGTH);
+
 	rsp->SecurityMode = SMB2_NEGOTIATE_SIGNING_ENABLED_LE;
 	conn->use_spnego = true;
 
@@ -1252,9 +1246,13 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 	ksmbd_conn_set_need_negotiate(conn);
 
 err_out:
+	rc = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_negotiate_rsp) +
+				AUTH_GSS_LENGTH + neg_ctxt_len);
+	if (rc)
+		rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
+
 	if (rc < 0)
 		smb2_set_err_rsp(work);
-
 	return rc;
 }
 
@@ -1454,7 +1452,6 @@ static int ntlm_authenticate(struct ksmbd_work *work,
 		memcpy((char *)&rsp->hdr.ProtocolId + sz, spnego_blob, spnego_blob_len);
 		rsp->SecurityBufferLength = cpu_to_le16(spnego_blob_len);
 		kfree(spnego_blob);
-		inc_rfc1001_len(work->response_buf, spnego_blob_len - 1);
 	}
 
 	user = session_user(conn, req);
@@ -1600,7 +1597,6 @@ static int krb5_authenticate(struct ksmbd_work *work,
 		return -EINVAL;
 	}
 	rsp->SecurityBufferLength = cpu_to_le16(out_len);
-	inc_rfc1001_len(work->response_buf, out_len - 1);
 
 	if ((conn->sign || server_conf.enforced_signing) ||
 	    (req->SecurityMode & SMB2_NEGOTIATE_SIGNING_REQUIRED))
@@ -1672,7 +1668,6 @@ int smb2_sess_setup(struct ksmbd_work *work)
 	rsp->SessionFlags = 0;
 	rsp->SecurityBufferOffset = cpu_to_le16(72);
 	rsp->SecurityBufferLength = 0;
-	inc_rfc1001_len(work->response_buf, 9);
 
 	ksmbd_conn_lock(conn);
 	if (!req->hdr.SessionId) {
@@ -1808,13 +1803,6 @@ int smb2_sess_setup(struct ksmbd_work *work)
 					goto out_err;
 				rsp->hdr.Status =
 					STATUS_MORE_PROCESSING_REQUIRED;
-				/*
-				 * Note: here total size -1 is done as an
-				 * adjustment for 0 size blob
-				 */
-				inc_rfc1001_len(work->response_buf,
-						le16_to_cpu(rsp->SecurityBufferLength) - 1);
-
 			} else if (negblob->MessageType == NtLmAuthenticate) {
 				rc = ntlm_authenticate(work, req, rsp);
 				if (rc)
@@ -1899,6 +1887,17 @@ int smb2_sess_setup(struct ksmbd_work *work)
 				ksmbd_conn_set_need_negotiate(conn);
 			}
 		}
+	} else {
+		unsigned int iov_len;
+
+		if (rsp->SecurityBufferLength)
+			iov_len = offsetof(struct smb2_sess_setup_rsp, Buffer) +
+				le16_to_cpu(rsp->SecurityBufferLength);
+		else
+			iov_len = sizeof(struct smb2_sess_setup_rsp);
+		rc = ksmbd_iov_pin_rsp(work, rsp, iov_len);
+		if (rc)
+			rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
 	}
 
 	ksmbd_conn_unlock(conn);
@@ -1977,13 +1976,16 @@ int smb2_tree_connect(struct ksmbd_work *work)
 		status.tree_conn->posix_extensions = true;
 
 	rsp->StructureSize = cpu_to_le16(16);
-	inc_rfc1001_len(work->response_buf, 16);
 out_err1:
 	rsp->Capabilities = 0;
 	rsp->Reserved = 0;
 	/* default manual caching */
 	rsp->ShareFlags = SMB2_SHAREFLAG_MANUAL_CACHING;
 
+	rc = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_tree_connect_rsp));
+	if (rc)
+		status.ret = KSMBD_TREE_CONN_STATUS_NOMEM;
+
 	if (!IS_ERR(treename))
 		kfree(treename);
 	if (!IS_ERR(name))
@@ -2096,20 +2098,27 @@ int smb2_tree_disconnect(struct ksmbd_work *work)
 	struct smb2_tree_disconnect_req *req;
 	struct ksmbd_session *sess = work->sess;
 	struct ksmbd_tree_connect *tcon = work->tcon;
+	int err;
 
 	WORK_BUFFERS(work, req, rsp);
 
-	rsp->StructureSize = cpu_to_le16(4);
-	inc_rfc1001_len(work->response_buf, 4);
-
 	ksmbd_debug(SMB, "request\n");
 
+	rsp->StructureSize = cpu_to_le16(4);
+	err = ksmbd_iov_pin_rsp(work, rsp,
+				sizeof(struct smb2_tree_disconnect_rsp));
+	if (err) {
+		rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
+		smb2_set_err_rsp(work);
+		return err;
+	}
+
 	if (!tcon || test_and_set_bit(TREE_CONN_EXPIRE, &tcon->status)) {
 		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
 
 		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
 		smb2_set_err_rsp(work);
-		return 0;
+		return -ENOENT;
 	}
 
 	ksmbd_close_tree_conn_fds(work);
@@ -2131,15 +2140,21 @@ int smb2_session_logoff(struct ksmbd_work *work)
 	struct smb2_logoff_rsp *rsp;
 	struct ksmbd_session *sess;
 	u64 sess_id;
+	int err;
 
 	WORK_BUFFERS(work, req, rsp);
 
+	ksmbd_debug(SMB, "request\n");
+
 	sess_id = le64_to_cpu(req->hdr.SessionId);
 
 	rsp->StructureSize = cpu_to_le16(4);
-	inc_rfc1001_len(work->response_buf, 4);
-
-	ksmbd_debug(SMB, "request\n");
+	err = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_logoff_rsp));
+	if (err) {
+		rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
+		smb2_set_err_rsp(work);
+		return err;
+	}
 
 	ksmbd_all_conn_set_status(sess_id, KSMBD_SESS_NEED_RECONNECT);
 	ksmbd_close_session_fds(work);
@@ -2154,7 +2169,7 @@ int smb2_session_logoff(struct ksmbd_work *work)
 		ksmbd_debug(SMB, "Invalid tid %d\n", req->hdr.Id.SyncId.TreeId);
 		rsp->hdr.Status = STATUS_NETWORK_NAME_DELETED;
 		smb2_set_err_rsp(work);
-		return 0;
+		return -ENOENT;
 	}
 
 	ksmbd_destroy_file_table(&sess->file_table);
@@ -2215,7 +2230,10 @@ static noinline int create_smb2_pipe(struct ksmbd_work *work)
 	rsp->CreateContextsOffset = 0;
 	rsp->CreateContextsLength = 0;
 
-	inc_rfc1001_len(work->response_buf, 88); /* StructureSize - 1*/
+	err = ksmbd_iov_pin_rsp(work, rsp, offsetof(struct smb2_create_rsp, Buffer));
+	if (err)
+		goto out;
+
 	kfree(name);
 	return 0;
 
@@ -2597,6 +2615,7 @@ int smb2_open(struct ksmbd_work *work)
 	u64 time;
 	umode_t posix_mode = 0;
 	__le32 daccess, maximal_access = 0;
+	int iov_len;
 
 	WORK_BUFFERS(work, req, rsp);
 
@@ -3248,7 +3267,7 @@ int smb2_open(struct ksmbd_work *work)
 
 	rsp->CreateContextsOffset = 0;
 	rsp->CreateContextsLength = 0;
-	inc_rfc1001_len(work->response_buf, 88); /* StructureSize - 1*/
+	iov_len = offsetof(struct smb2_create_rsp, Buffer);
 
 	/* If lease is request send lease context response */
 	if (opinfo && opinfo->is_lease) {
@@ -3263,8 +3282,7 @@ int smb2_open(struct ksmbd_work *work)
 		create_lease_buf(rsp->Buffer, opinfo->o_lease);
 		le32_add_cpu(&rsp->CreateContextsLength,
 			     conn->vals->create_lease_size);
-		inc_rfc1001_len(work->response_buf,
-				conn->vals->create_lease_size);
+		iov_len += conn->vals->create_lease_size;
 		next_ptr = &lease_ccontext->Next;
 		next_off = conn->vals->create_lease_size;
 	}
@@ -3284,8 +3302,7 @@ int smb2_open(struct ksmbd_work *work)
 				le32_to_cpu(maximal_access));
 		le32_add_cpu(&rsp->CreateContextsLength,
 			     conn->vals->create_mxac_size);
-		inc_rfc1001_len(work->response_buf,
-				conn->vals->create_mxac_size);
+		iov_len += conn->vals->create_mxac_size;
 		if (next_ptr)
 			*next_ptr = cpu_to_le32(next_off);
 		next_ptr = &mxac_ccontext->Next;
@@ -3303,8 +3320,7 @@ int smb2_open(struct ksmbd_work *work)
 				stat.ino, tcon->id);
 		le32_add_cpu(&rsp->CreateContextsLength,
 			     conn->vals->create_disk_id_size);
-		inc_rfc1001_len(work->response_buf,
-				conn->vals->create_disk_id_size);
+		iov_len += conn->vals->create_disk_id_size;
 		if (next_ptr)
 			*next_ptr = cpu_to_le32(next_off);
 		next_ptr = &disk_id_ccontext->Next;
@@ -3318,8 +3334,7 @@ int smb2_open(struct ksmbd_work *work)
 				fp);
 		le32_add_cpu(&rsp->CreateContextsLength,
 			     conn->vals->create_posix_size);
-		inc_rfc1001_len(work->response_buf,
-				conn->vals->create_posix_size);
+		iov_len += conn->vals->create_posix_size;
 		if (next_ptr)
 			*next_ptr = cpu_to_le32(next_off);
 	}
@@ -3337,7 +3352,8 @@ int smb2_open(struct ksmbd_work *work)
 	}
 	ksmbd_revert_fsids(work);
 err_out1:
-
+	if (!rc)
+		rc = ksmbd_iov_pin_rsp(work, (void *)rsp, iov_len);
 	if (rc) {
 		if (rc == -EINVAL)
 			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
@@ -4063,7 +4079,10 @@ int smb2_query_dir(struct ksmbd_work *work)
 		rsp->OutputBufferOffset = cpu_to_le16(0);
 		rsp->OutputBufferLength = cpu_to_le32(0);
 		rsp->Buffer[0] = 0;
-		inc_rfc1001_len(work->response_buf, 9);
+		rc = ksmbd_iov_pin_rsp(work, (void *)rsp,
+				       sizeof(struct smb2_query_directory_rsp));
+		if (rc)
+			goto err_out;
 	} else {
 no_buf_len:
 		((struct file_directory_info *)
@@ -4075,7 +4094,11 @@ int smb2_query_dir(struct ksmbd_work *work)
 		rsp->StructureSize = cpu_to_le16(9);
 		rsp->OutputBufferOffset = cpu_to_le16(72);
 		rsp->OutputBufferLength = cpu_to_le32(d_info.data_count);
-		inc_rfc1001_len(work->response_buf, 8 + d_info.data_count);
+		rc = ksmbd_iov_pin_rsp(work, (void *)rsp,
+				       offsetof(struct smb2_query_directory_rsp, Buffer) +
+				       d_info.data_count);
+		if (rc)
+			goto err_out;
 	}
 
 	kfree(srch_ptr);
@@ -4122,21 +4145,13 @@ int smb2_query_dir(struct ksmbd_work *work)
  */
 static int buffer_check_err(int reqOutputBufferLength,
 			    struct smb2_query_info_rsp *rsp,
-			    void *rsp_org, int infoclass_size)
+			    void *rsp_org)
 {
 	if (reqOutputBufferLength < le32_to_cpu(rsp->OutputBufferLength)) {
-		if (reqOutputBufferLength < infoclass_size) {
-			pr_err("Invalid Buffer Size Requested\n");
-			rsp->hdr.Status = STATUS_INFO_LENGTH_MISMATCH;
-			*(__be32 *)rsp_org = cpu_to_be32(sizeof(struct smb2_hdr));
-			return -EINVAL;
-		}
-
-		ksmbd_debug(SMB, "Buffer Overflow\n");
-		rsp->hdr.Status = STATUS_BUFFER_OVERFLOW;
-		*(__be32 *)rsp_org = cpu_to_be32(sizeof(struct smb2_hdr) +
-				reqOutputBufferLength);
-		rsp->OutputBufferLength = cpu_to_le32(reqOutputBufferLength);
+		pr_err("Invalid Buffer Size Requested\n");
+		rsp->hdr.Status = STATUS_INFO_LENGTH_MISMATCH;
+		*(__be32 *)rsp_org = cpu_to_be32(sizeof(struct smb2_hdr));
+		return -EINVAL;
 	}
 	return 0;
 }
@@ -4155,7 +4170,6 @@ static void get_standard_info_pipe(struct smb2_query_info_rsp *rsp,
 	sinfo->Directory = 0;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_standard_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_standard_info));
 }
 
 static void get_internal_info_pipe(struct smb2_query_info_rsp *rsp, u64 num,
@@ -4169,7 +4183,6 @@ static void get_internal_info_pipe(struct smb2_query_info_rsp *rsp, u64 num,
 	file_info->IndexNumber = cpu_to_le64(num | (1ULL << 63));
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_internal_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_internal_info));
 }
 
 static int smb2_get_info_file_pipe(struct ksmbd_session *sess,
@@ -4195,14 +4208,12 @@ static int smb2_get_info_file_pipe(struct ksmbd_session *sess,
 	case FILE_STANDARD_INFORMATION:
 		get_standard_info_pipe(rsp, rsp_org);
 		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
-				      rsp, rsp_org,
-				      FILE_STANDARD_INFORMATION_SIZE);
+				      rsp, rsp_org);
 		break;
 	case FILE_INTERNAL_INFORMATION:
 		get_internal_info_pipe(rsp, id, rsp_org);
 		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
-				      rsp, rsp_org,
-				      FILE_INTERNAL_INFORMATION_SIZE);
+				      rsp, rsp_org);
 		break;
 	default:
 		ksmbd_debug(SMB, "smb2_info_file_pipe for %u not supported\n",
@@ -4370,7 +4381,6 @@ static int smb2_get_ea(struct ksmbd_work *work, struct ksmbd_file *fp,
 	if (rsp_data_cnt == 0)
 		rsp->hdr.Status = STATUS_NO_EAS_ON_FILE;
 	rsp->OutputBufferLength = cpu_to_le32(rsp_data_cnt);
-	inc_rfc1001_len(rsp_org, rsp_data_cnt);
 out:
 	kvfree(xattr_list);
 	return rc;
@@ -4385,7 +4395,6 @@ static void get_file_access_info(struct smb2_query_info_rsp *rsp,
 	file_info->AccessFlags = fp->daccess;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_access_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_access_info));
 }
 
 static int get_file_basic_info(struct smb2_query_info_rsp *rsp,
@@ -4415,7 +4424,6 @@ static int get_file_basic_info(struct smb2_query_info_rsp *rsp,
 	basic_info->Pad1 = 0;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_basic_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_basic_info));
 	return 0;
 }
 
@@ -4440,8 +4448,6 @@ static void get_file_standard_info(struct smb2_query_info_rsp *rsp,
 	sinfo->Directory = S_ISDIR(stat.mode) ? 1 : 0;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_standard_info));
-	inc_rfc1001_len(rsp_org,
-			sizeof(struct smb2_file_standard_info));
 }
 
 static void get_file_alignment_info(struct smb2_query_info_rsp *rsp,
@@ -4453,8 +4459,6 @@ static void get_file_alignment_info(struct smb2_query_info_rsp *rsp,
 	file_info->AlignmentRequirement = 0;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_alignment_info));
-	inc_rfc1001_len(rsp_org,
-			sizeof(struct smb2_file_alignment_info));
 }
 
 static int get_file_all_info(struct ksmbd_work *work,
@@ -4518,7 +4522,6 @@ static int get_file_all_info(struct ksmbd_work *work,
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_all_info) + conv_len - 1);
 	kfree(filename);
-	inc_rfc1001_len(rsp_org, le32_to_cpu(rsp->OutputBufferLength));
 	return 0;
 }
 
@@ -4541,7 +4544,6 @@ static void get_file_alternate_info(struct ksmbd_work *work,
 	file_info->FileNameLength = cpu_to_le32(conv_len);
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_alt_name_info) + conv_len);
-	inc_rfc1001_len(rsp_org, le32_to_cpu(rsp->OutputBufferLength));
 }
 
 static void get_file_stream_info(struct ksmbd_work *work,
@@ -4641,7 +4643,6 @@ static void get_file_stream_info(struct ksmbd_work *work,
 	kvfree(xattr_list);
 
 	rsp->OutputBufferLength = cpu_to_le32(nbytes);
-	inc_rfc1001_len(rsp_org, nbytes);
 }
 
 static void get_file_internal_info(struct smb2_query_info_rsp *rsp,
@@ -4656,7 +4657,6 @@ static void get_file_internal_info(struct smb2_query_info_rsp *rsp,
 	file_info->IndexNumber = cpu_to_le64(stat.ino);
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_internal_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_internal_info));
 }
 
 static int get_file_network_open_info(struct smb2_query_info_rsp *rsp,
@@ -4692,7 +4692,6 @@ static int get_file_network_open_info(struct smb2_query_info_rsp *rsp,
 	file_info->Reserved = cpu_to_le32(0);
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_ntwrk_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_ntwrk_info));
 	return 0;
 }
 
@@ -4704,7 +4703,6 @@ static void get_file_ea_info(struct smb2_query_info_rsp *rsp, void *rsp_org)
 	file_info->EASize = 0;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_ea_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_ea_info));
 }
 
 static void get_file_position_info(struct smb2_query_info_rsp *rsp,
@@ -4716,7 +4714,6 @@ static void get_file_position_info(struct smb2_query_info_rsp *rsp,
 	file_info->CurrentByteOffset = cpu_to_le64(fp->filp->f_pos);
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_pos_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_pos_info));
 }
 
 static void get_file_mode_info(struct smb2_query_info_rsp *rsp,
@@ -4728,7 +4725,6 @@ static void get_file_mode_info(struct smb2_query_info_rsp *rsp,
 	file_info->Mode = fp->coption & FILE_MODE_INFO_MASK;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_mode_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_mode_info));
 }
 
 static void get_file_compression_info(struct smb2_query_info_rsp *rsp,
@@ -4750,7 +4746,6 @@ static void get_file_compression_info(struct smb2_query_info_rsp *rsp,
 
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_comp_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_comp_info));
 }
 
 static int get_file_attribute_tag_info(struct smb2_query_info_rsp *rsp,
@@ -4769,11 +4764,10 @@ static int get_file_attribute_tag_info(struct smb2_query_info_rsp *rsp,
 	file_info->ReparseTag = 0;
 	rsp->OutputBufferLength =
 		cpu_to_le32(sizeof(struct smb2_file_attr_tag_info));
-	inc_rfc1001_len(rsp_org, sizeof(struct smb2_file_attr_tag_info));
 	return 0;
 }
 
-static int find_file_posix_info(struct smb2_query_info_rsp *rsp,
+static void find_file_posix_info(struct smb2_query_info_rsp *rsp,
 				struct ksmbd_file *fp, void *rsp_org)
 {
 	struct smb311_posix_qinfo *file_info;
@@ -4811,8 +4805,6 @@ static int find_file_posix_info(struct smb2_query_info_rsp *rsp,
 		  SIDUNIX_GROUP, (struct smb_sid *)&file_info->Sids[16]);
 
 	rsp->OutputBufferLength = cpu_to_le32(out_buf_len);
-	inc_rfc1001_len(rsp_org, out_buf_len);
-	return out_buf_len;
 }
 
 static int smb2_get_info_file(struct ksmbd_work *work,
@@ -4822,7 +4814,6 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 	struct ksmbd_file *fp;
 	int fileinfoclass = 0;
 	int rc = 0;
-	int file_infoclass_size;
 	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
 
 	if (test_share_config_flag(work->tcon->share_conf,
@@ -4855,85 +4846,69 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 	switch (fileinfoclass) {
 	case FILE_ACCESS_INFORMATION:
 		get_file_access_info(rsp, fp, work->response_buf);
-		file_infoclass_size = FILE_ACCESS_INFORMATION_SIZE;
 		break;
 
 	case FILE_BASIC_INFORMATION:
 		rc = get_file_basic_info(rsp, fp, work->response_buf);
-		file_infoclass_size = FILE_BASIC_INFORMATION_SIZE;
 		break;
 
 	case FILE_STANDARD_INFORMATION:
 		get_file_standard_info(rsp, fp, work->response_buf);
-		file_infoclass_size = FILE_STANDARD_INFORMATION_SIZE;
 		break;
 
 	case FILE_ALIGNMENT_INFORMATION:
 		get_file_alignment_info(rsp, work->response_buf);
-		file_infoclass_size = FILE_ALIGNMENT_INFORMATION_SIZE;
 		break;
 
 	case FILE_ALL_INFORMATION:
 		rc = get_file_all_info(work, rsp, fp, work->response_buf);
-		file_infoclass_size = FILE_ALL_INFORMATION_SIZE;
 		break;
 
 	case FILE_ALTERNATE_NAME_INFORMATION:
 		get_file_alternate_info(work, rsp, fp, work->response_buf);
-		file_infoclass_size = FILE_ALTERNATE_NAME_INFORMATION_SIZE;
 		break;
 
 	case FILE_STREAM_INFORMATION:
 		get_file_stream_info(work, rsp, fp, work->response_buf);
-		file_infoclass_size = FILE_STREAM_INFORMATION_SIZE;
 		break;
 
 	case FILE_INTERNAL_INFORMATION:
 		get_file_internal_info(rsp, fp, work->response_buf);
-		file_infoclass_size = FILE_INTERNAL_INFORMATION_SIZE;
 		break;
 
 	case FILE_NETWORK_OPEN_INFORMATION:
 		rc = get_file_network_open_info(rsp, fp, work->response_buf);
-		file_infoclass_size = FILE_NETWORK_OPEN_INFORMATION_SIZE;
 		break;
 
 	case FILE_EA_INFORMATION:
 		get_file_ea_info(rsp, work->response_buf);
-		file_infoclass_size = FILE_EA_INFORMATION_SIZE;
 		break;
 
 	case FILE_FULL_EA_INFORMATION:
 		rc = smb2_get_ea(work, fp, req, rsp, work->response_buf);
-		file_infoclass_size = FILE_FULL_EA_INFORMATION_SIZE;
 		break;
 
 	case FILE_POSITION_INFORMATION:
 		get_file_position_info(rsp, fp, work->response_buf);
-		file_infoclass_size = FILE_POSITION_INFORMATION_SIZE;
 		break;
 
 	case FILE_MODE_INFORMATION:
 		get_file_mode_info(rsp, fp, work->response_buf);
-		file_infoclass_size = FILE_MODE_INFORMATION_SIZE;
 		break;
 
 	case FILE_COMPRESSION_INFORMATION:
 		get_file_compression_info(rsp, fp, work->response_buf);
-		file_infoclass_size = FILE_COMPRESSION_INFORMATION_SIZE;
 		break;
 
 	case FILE_ATTRIBUTE_TAG_INFORMATION:
 		rc = get_file_attribute_tag_info(rsp, fp, work->response_buf);
-		file_infoclass_size = FILE_ATTRIBUTE_TAG_INFORMATION_SIZE;
 		break;
 	case SMB_FIND_FILE_POSIX_INFO:
 		if (!work->tcon->posix_extensions) {
 			pr_err("client doesn't negotiate with SMB3.1.1 POSIX Extensions\n");
 			rc = -EOPNOTSUPP;
 		} else {
-			file_infoclass_size = find_file_posix_info(rsp, fp,
-					work->response_buf);
+			find_file_posix_info(rsp, fp, work->response_buf);
 		}
 		break;
 	default:
@@ -4943,8 +4918,7 @@ static int smb2_get_info_file(struct ksmbd_work *work,
 	}
 	if (!rc)
 		rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
-				      rsp, work->response_buf,
-				      file_infoclass_size);
+				      rsp, work->response_buf);
 	ksmbd_fd_put(work, fp);
 	return rc;
 }
@@ -4960,7 +4934,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 	struct kstatfs stfs;
 	struct path path;
 	int rc = 0, len;
-	int fs_infoclass_size = 0;
 
 	if (!share->path)
 		return -EIO;
@@ -4990,8 +4963,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->DeviceType = cpu_to_le32(stfs.f_type);
 		info->DeviceCharacteristics = cpu_to_le32(0x00000020);
 		rsp->OutputBufferLength = cpu_to_le32(8);
-		inc_rfc1001_len(work->response_buf, 8);
-		fs_infoclass_size = FS_DEVICE_INFORMATION_SIZE;
 		break;
 	}
 	case FS_ATTRIBUTE_INFORMATION:
@@ -5020,8 +4991,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->FileSystemNameLen = cpu_to_le32(len);
 		sz = sizeof(struct filesystem_attribute_info) - 2 + len;
 		rsp->OutputBufferLength = cpu_to_le32(sz);
-		inc_rfc1001_len(work->response_buf, sz);
-		fs_infoclass_size = FS_ATTRIBUTE_INFORMATION_SIZE;
 		break;
 	}
 	case FS_VOLUME_INFORMATION:
@@ -5048,8 +5017,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->Reserved = 0;
 		sz = sizeof(struct filesystem_vol_info) - 2 + len;
 		rsp->OutputBufferLength = cpu_to_le32(sz);
-		inc_rfc1001_len(work->response_buf, sz);
-		fs_infoclass_size = FS_VOLUME_INFORMATION_SIZE;
 		break;
 	}
 	case FS_SIZE_INFORMATION:
@@ -5062,8 +5029,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->SectorsPerAllocationUnit = cpu_to_le32(1);
 		info->BytesPerSector = cpu_to_le32(stfs.f_bsize);
 		rsp->OutputBufferLength = cpu_to_le32(24);
-		inc_rfc1001_len(work->response_buf, 24);
-		fs_infoclass_size = FS_SIZE_INFORMATION_SIZE;
 		break;
 	}
 	case FS_FULL_SIZE_INFORMATION:
@@ -5079,8 +5044,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->SectorsPerAllocationUnit = cpu_to_le32(1);
 		info->BytesPerSector = cpu_to_le32(stfs.f_bsize);
 		rsp->OutputBufferLength = cpu_to_le32(32);
-		inc_rfc1001_len(work->response_buf, 32);
-		fs_infoclass_size = FS_FULL_SIZE_INFORMATION_SIZE;
 		break;
 	}
 	case FS_OBJECT_ID_INFORMATION:
@@ -5100,8 +5063,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->extended_info.rel_date = 0;
 		memcpy(info->extended_info.version_string, "1.1.0", strlen("1.1.0"));
 		rsp->OutputBufferLength = cpu_to_le32(64);
-		inc_rfc1001_len(work->response_buf, 64);
-		fs_infoclass_size = FS_OBJECT_ID_INFORMATION_SIZE;
 		break;
 	}
 	case FS_SECTOR_SIZE_INFORMATION:
@@ -5123,8 +5084,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->ByteOffsetForSectorAlignment = 0;
 		info->ByteOffsetForPartitionAlignment = 0;
 		rsp->OutputBufferLength = cpu_to_le32(28);
-		inc_rfc1001_len(work->response_buf, 28);
-		fs_infoclass_size = FS_SECTOR_SIZE_INFORMATION_SIZE;
 		break;
 	}
 	case FS_CONTROL_INFORMATION:
@@ -5145,8 +5104,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		info->DefaultQuotaLimit = cpu_to_le64(SMB2_NO_FID);
 		info->Padding = 0;
 		rsp->OutputBufferLength = cpu_to_le32(48);
-		inc_rfc1001_len(work->response_buf, 48);
-		fs_infoclass_size = FS_CONTROL_INFORMATION_SIZE;
 		break;
 	}
 	case FS_POSIX_INFORMATION:
@@ -5166,8 +5123,6 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 			info->TotalFileNodes = cpu_to_le64(stfs.f_files);
 			info->FreeFileNodes = cpu_to_le64(stfs.f_ffree);
 			rsp->OutputBufferLength = cpu_to_le32(56);
-			inc_rfc1001_len(work->response_buf, 56);
-			fs_infoclass_size = FS_POSIX_INFORMATION_SIZE;
 		}
 		break;
 	}
@@ -5176,8 +5131,7 @@ static int smb2_get_info_filesystem(struct ksmbd_work *work,
 		return -EOPNOTSUPP;
 	}
 	rc = buffer_check_err(le32_to_cpu(req->OutputBufferLength),
-			      rsp, work->response_buf,
-			      fs_infoclass_size);
+			      rsp, work->response_buf);
 	path_put(&path);
 	return rc;
 }
@@ -5211,7 +5165,6 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 
 		secdesclen = sizeof(struct smb_ntsd);
 		rsp->OutputBufferLength = cpu_to_le32(secdesclen);
-		inc_rfc1001_len(work->response_buf, secdesclen);
 
 		return 0;
 	}
@@ -5256,7 +5209,6 @@ static int smb2_get_info_sec(struct ksmbd_work *work,
 		return rc;
 
 	rsp->OutputBufferLength = cpu_to_le32(secdesclen);
-	inc_rfc1001_len(work->response_buf, secdesclen);
 	return 0;
 }
 
@@ -5295,6 +5247,14 @@ int smb2_query_info(struct ksmbd_work *work)
 		rc = -EOPNOTSUPP;
 	}
 
+	if (!rc) {
+		rsp->StructureSize = cpu_to_le16(9);
+		rsp->OutputBufferOffset = cpu_to_le16(72);
+		rc = ksmbd_iov_pin_rsp(work, (void *)rsp,
+				       offsetof(struct smb2_query_info_rsp, Buffer) +
+					le32_to_cpu(rsp->OutputBufferLength));
+	}
+
 	if (rc < 0) {
 		if (rc == -EACCES)
 			rsp->hdr.Status = STATUS_ACCESS_DENIED;
@@ -5302,6 +5262,8 @@ int smb2_query_info(struct ksmbd_work *work)
 			rsp->hdr.Status = STATUS_FILE_CLOSED;
 		else if (rc == -EIO)
 			rsp->hdr.Status = STATUS_UNEXPECTED_IO_ERROR;
+		else if (rc == -ENOMEM)
+			rsp->hdr.Status = STATUS_INSUFFICIENT_RESOURCES;
 		else if (rc == -EOPNOTSUPP || rsp->hdr.Status == 0)
 			rsp->hdr.Status = STATUS_INVALID_INFO_CLASS;
 		smb2_set_err_rsp(work);
@@ -5310,9 +5272,6 @@ int smb2_query_info(struct ksmbd_work *work)
 			    rc);
 		return rc;
 	}
-	rsp->StructureSize = cpu_to_le16(9);
-	rsp->OutputBufferOffset = cpu_to_le16(72);
-	inc_rfc1001_len(work->response_buf, 8);
 	return 0;
 }
 
@@ -5343,8 +5302,9 @@ static noinline int smb2_close_pipe(struct ksmbd_work *work)
 	rsp->AllocationSize = 0;
 	rsp->EndOfFile = 0;
 	rsp->Attributes = 0;
-	inc_rfc1001_len(work->response_buf, 60);
-	return 0;
+
+	return ksmbd_iov_pin_rsp(work, (void *)rsp,
+				 sizeof(struct smb2_close_rsp));
 }
 
 /**
@@ -5449,15 +5409,17 @@ int smb2_close(struct ksmbd_work *work)
 
 	err = ksmbd_close_fd(work, volatile_id);
 out:
+	if (!err)
+		err = ksmbd_iov_pin_rsp(work, (void *)rsp,
+					sizeof(struct smb2_close_rsp));
+
 	if (err) {
 		if (rsp->hdr.Status == 0)
 			rsp->hdr.Status = STATUS_FILE_CLOSED;
 		smb2_set_err_rsp(work);
-	} else {
-		inc_rfc1001_len(work->response_buf, 60);
 	}
 
-	return 0;
+	return err;
 }
 
 /**
@@ -5475,8 +5437,7 @@ int smb2_echo(struct ksmbd_work *work)
 
 	rsp->StructureSize = cpu_to_le16(4);
 	rsp->Reserved = 0;
-	inc_rfc1001_len(work->response_buf, 4);
-	return 0;
+	return ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_echo_rsp));
 }
 
 static int smb2_rename(struct ksmbd_work *work,
@@ -6068,7 +6029,10 @@ int smb2_set_info(struct ksmbd_work *work)
 		goto err_out;
 
 	rsp->StructureSize = cpu_to_le16(2);
-	inc_rfc1001_len(work->response_buf, 2);
+	rc = ksmbd_iov_pin_rsp(work, (void *)rsp,
+			       sizeof(struct smb2_set_info_rsp));
+	if (rc)
+		goto err_out;
 	ksmbd_fd_put(work, fp);
 	return 0;
 
@@ -6115,28 +6079,36 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 
 	id = req->VolatileFileId;
 
-	inc_rfc1001_len(work->response_buf, 16);
 	rpc_resp = ksmbd_rpc_read(work->sess, id);
 	if (rpc_resp) {
+		void *aux_payload_buf;
+
 		if (rpc_resp->flags != KSMBD_RPC_OK) {
 			err = -EINVAL;
 			goto out;
 		}
 
-		work->aux_payload_buf =
+		aux_payload_buf =
 			kvmalloc(rpc_resp->payload_sz, GFP_KERNEL);
-		if (!work->aux_payload_buf) {
+		if (!aux_payload_buf) {
 			err = -ENOMEM;
 			goto out;
 		}
 
-		memcpy(work->aux_payload_buf, rpc_resp->payload,
-		       rpc_resp->payload_sz);
+		memcpy(aux_payload_buf, rpc_resp->payload, rpc_resp->payload_sz);
 
 		nbytes = rpc_resp->payload_sz;
-		work->resp_hdr_sz = get_rfc1002_len(work->response_buf) + 4;
-		work->aux_payload_sz = nbytes;
 		kvfree(rpc_resp);
+		err = ksmbd_iov_pin_rsp_read(work, (void *)rsp,
+					     offsetof(struct smb2_read_rsp, Buffer),
+					     aux_payload_buf, nbytes);
+		if (err)
+			goto out;
+	} else {
+		err = ksmbd_iov_pin_rsp(work, (void *)rsp,
+					offsetof(struct smb2_read_rsp, Buffer));
+		if (err)
+			goto out;
 	}
 
 	rsp->StructureSize = cpu_to_le16(17);
@@ -6145,7 +6117,6 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 	rsp->DataLength = cpu_to_le32(nbytes);
 	rsp->DataRemaining = 0;
 	rsp->Flags = 0;
-	inc_rfc1001_len(work->response_buf, nbytes);
 	return 0;
 
 out:
@@ -6219,13 +6190,8 @@ int smb2_read(struct ksmbd_work *work)
 	int err = 0;
 	bool is_rdma_channel = false;
 	unsigned int max_read_size = conn->vals->max_read_size;
-
-	WORK_BUFFERS(work, req, rsp);
-	if (work->next_smb2_rcv_hdr_off) {
-		work->send_no_response = 1;
-		err = -EOPNOTSUPP;
-		goto out;
-	}
+	unsigned int id = KSMBD_NO_FID, pid = KSMBD_NO_FID;
+	void *aux_payload_buf;
 
 	if (test_share_config_flag(work->tcon->share_conf,
 				   KSMBD_SHARE_FLAG_PIPE)) {
@@ -6233,6 +6199,25 @@ int smb2_read(struct ksmbd_work *work)
 		return smb2_read_pipe(work);
 	}
 
+	if (work->next_smb2_rcv_hdr_off) {
+		req = ksmbd_req_buf_next(work);
+		rsp = ksmbd_resp_buf_next(work);
+		if (!has_file_id(req->VolatileFileId)) {
+			ksmbd_debug(SMB, "Compound request set FID = %llu\n",
+					work->compound_fid);
+			id = work->compound_fid;
+			pid = work->compound_pfid;
+		}
+	} else {
+		req = smb2_get_msg(work->request_buf);
+		rsp = smb2_get_msg(work->response_buf);
+	}
+
+	if (!has_file_id(id)) {
+		id = req->VolatileFileId;
+		pid = req->PersistentFileId;
+	}
+
 	if (req->Channel == SMB2_CHANNEL_RDMA_V1_INVALIDATE ||
 	    req->Channel == SMB2_CHANNEL_RDMA_V1) {
 		is_rdma_channel = true;
@@ -6255,7 +6240,7 @@ int smb2_read(struct ksmbd_work *work)
 			goto out;
 	}
 
-	fp = ksmbd_lookup_fd_slow(work, req->VolatileFileId, req->PersistentFileId);
+	fp = ksmbd_lookup_fd_slow(work, id, pid);
 	if (!fp) {
 		err = -ENOENT;
 		goto out;
@@ -6281,21 +6266,20 @@ int smb2_read(struct ksmbd_work *work)
 	ksmbd_debug(SMB, "filename %pD, offset %lld, len %zu\n",
 		    fp->filp, offset, length);
 
-	work->aux_payload_buf = kvzalloc(length, GFP_KERNEL);
-	if (!work->aux_payload_buf) {
+	aux_payload_buf = kvzalloc(length, GFP_KERNEL);
+	if (!aux_payload_buf) {
 		err = -ENOMEM;
 		goto out;
 	}
 
-	nbytes = ksmbd_vfs_read(work, fp, length, &offset);
+	nbytes = ksmbd_vfs_read(work, fp, length, &offset, aux_payload_buf);
 	if (nbytes < 0) {
 		err = nbytes;
 		goto out;
 	}
 
 	if ((nbytes == 0 && length != 0) || nbytes < mincount) {
-		kvfree(work->aux_payload_buf);
-		work->aux_payload_buf = NULL;
+		kvfree(aux_payload_buf);
 		rsp->hdr.Status = STATUS_END_OF_FILE;
 		smb2_set_err_rsp(work);
 		ksmbd_fd_put(work, fp);
@@ -6308,10 +6292,9 @@ int smb2_read(struct ksmbd_work *work)
 	if (is_rdma_channel == true) {
 		/* write data to the client using rdma channel */
 		remain_bytes = smb2_read_rdma_channel(work, req,
-						      work->aux_payload_buf,
+						      aux_payload_buf,
 						      nbytes);
-		kvfree(work->aux_payload_buf);
-		work->aux_payload_buf = NULL;
+		kvfree(aux_payload_buf);
 
 		nbytes = 0;
 		if (remain_bytes < 0) {
@@ -6326,10 +6309,11 @@ int smb2_read(struct ksmbd_work *work)
 	rsp->DataLength = cpu_to_le32(nbytes);
 	rsp->DataRemaining = cpu_to_le32(remain_bytes);
 	rsp->Flags = 0;
-	inc_rfc1001_len(work->response_buf, 16);
-	work->resp_hdr_sz = get_rfc1002_len(work->response_buf) + 4;
-	work->aux_payload_sz = nbytes;
-	inc_rfc1001_len(work->response_buf, nbytes);
+	err = ksmbd_iov_pin_rsp_read(work, (void *)rsp,
+				     offsetof(struct smb2_read_rsp, Buffer),
+				     aux_payload_buf, nbytes);
+	if (err)
+		goto out;
 	ksmbd_fd_put(work, fp);
 	return 0;
 
@@ -6412,8 +6396,8 @@ static noinline int smb2_write_pipe(struct ksmbd_work *work)
 	rsp->DataLength = cpu_to_le32(length);
 	rsp->DataRemaining = 0;
 	rsp->Reserved2 = 0;
-	inc_rfc1001_len(work->response_buf, 16);
-	return 0;
+	err = ksmbd_iov_pin_rsp(work, (void *)rsp,
+				offsetof(struct smb2_write_rsp, Buffer));
 out:
 	if (err) {
 		rsp->hdr.Status = STATUS_INVALID_HANDLE;
@@ -6569,7 +6553,9 @@ int smb2_write(struct ksmbd_work *work)
 	rsp->DataLength = cpu_to_le32(nbytes);
 	rsp->DataRemaining = 0;
 	rsp->Reserved2 = 0;
-	inc_rfc1001_len(work->response_buf, 16);
+	err = ksmbd_iov_pin_rsp(work, rsp, offsetof(struct smb2_write_rsp, Buffer));
+	if (err)
+		goto out;
 	ksmbd_fd_put(work, fp);
 	return 0;
 
@@ -6616,15 +6602,11 @@ int smb2_flush(struct ksmbd_work *work)
 
 	rsp->StructureSize = cpu_to_le16(4);
 	rsp->Reserved = 0;
-	inc_rfc1001_len(work->response_buf, 4);
-	return 0;
+	return ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_flush_rsp));
 
 out:
-	if (err) {
-		rsp->hdr.Status = STATUS_INVALID_HANDLE;
-		smb2_set_err_rsp(work);
-	}
-
+	rsp->hdr.Status = STATUS_INVALID_HANDLE;
+	smb2_set_err_rsp(work);
 	return err;
 }
 
@@ -7061,6 +7043,8 @@ int smb2_lock(struct ksmbd_work *work)
 				list_del(&work->fp_entry);
 				spin_unlock(&fp->f_lock);
 
+				ksmbd_iov_reset(work);
+
 				if (work->state != KSMBD_WORK_ACTIVE) {
 					list_del(&smb_lock->llist);
 					spin_lock(&work->conn->llist_lock);
@@ -7079,7 +7063,6 @@ int smb2_lock(struct ksmbd_work *work)
 					}
 
 					init_smb2_rsp_hdr(work);
-					smb2_set_err_rsp(work);
 					rsp->hdr.Status =
 						STATUS_RANGE_NOT_LOCKED;
 					kfree(smb_lock);
@@ -7114,7 +7097,10 @@ int smb2_lock(struct ksmbd_work *work)
 	ksmbd_debug(SMB, "successful in taking lock\n");
 	rsp->hdr.Status = STATUS_SUCCESS;
 	rsp->Reserved = 0;
-	inc_rfc1001_len(work->response_buf, 4);
+	err = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_lock_rsp));
+	if (err)
+		goto out;
+
 	ksmbd_fd_put(work, fp);
 	return 0;
 
@@ -7910,9 +7896,9 @@ int smb2_ioctl(struct ksmbd_work *work)
 	rsp->Reserved = cpu_to_le16(0);
 	rsp->Flags = cpu_to_le32(0);
 	rsp->Reserved2 = cpu_to_le32(0);
-	inc_rfc1001_len(work->response_buf, 48 + nbytes);
-
-	return 0;
+	ret = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_ioctl_rsp) + nbytes);
+	if (!ret)
+		return ret;
 
 out:
 	if (ret == -EACCES)
@@ -8047,8 +8033,9 @@ static void smb20_oplock_break_ack(struct ksmbd_work *work)
 	rsp->Reserved2 = 0;
 	rsp->VolatileFid = volatile_id;
 	rsp->PersistentFid = persistent_id;
-	inc_rfc1001_len(work->response_buf, 24);
-	return;
+	ret = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_oplock_break));
+	if (!ret)
+		return;
 
 err_out:
 	opinfo->op_state = OPLOCK_STATE_NONE;
@@ -8198,8 +8185,9 @@ static void smb21_lease_break_ack(struct ksmbd_work *work)
 	memcpy(rsp->LeaseKey, req->LeaseKey, 16);
 	rsp->LeaseState = lease_state;
 	rsp->LeaseDuration = 0;
-	inc_rfc1001_len(work->response_buf, 36);
-	return;
+	ret = ksmbd_iov_pin_rsp(work, rsp, sizeof(struct smb2_lease_ack));
+	if (!ret)
+		return;
 
 err_out:
 	opinfo->op_state = OPLOCK_STATE_NONE;
@@ -8337,43 +8325,19 @@ int smb2_check_sign_req(struct ksmbd_work *work)
 void smb2_set_sign_rsp(struct ksmbd_work *work)
 {
 	struct smb2_hdr *hdr;
-	struct smb2_hdr *req_hdr;
 	char signature[SMB2_HMACSHA256_SIZE];
-	struct kvec iov[2];
-	size_t len;
+	struct kvec *iov;
 	int n_vec = 1;
 
-	hdr = smb2_get_msg(work->response_buf);
-	if (work->next_smb2_rsp_hdr_off)
-		hdr = ksmbd_resp_buf_next(work);
-
-	req_hdr = ksmbd_req_buf_next(work);
-
-	if (!work->next_smb2_rsp_hdr_off) {
-		len = get_rfc1002_len(work->response_buf);
-		if (req_hdr->NextCommand)
-			len = ALIGN(len, 8);
-	} else {
-		len = get_rfc1002_len(work->response_buf) -
-			work->next_smb2_rsp_hdr_off;
-		len = ALIGN(len, 8);
-	}
-
-	if (req_hdr->NextCommand)
-		hdr->NextCommand = cpu_to_le32(len);
-
+	hdr = ksmbd_resp_buf_curr(work);
 	hdr->Flags |= SMB2_FLAGS_SIGNED;
 	memset(hdr->Signature, 0, SMB2_SIGNATURE_SIZE);
 
-	iov[0].iov_base = (char *)&hdr->ProtocolId;
-	iov[0].iov_len = len;
-
-	if (work->aux_payload_sz) {
-		iov[0].iov_len -= work->aux_payload_sz;
-
-		iov[1].iov_base = work->aux_payload_buf;
-		iov[1].iov_len = work->aux_payload_sz;
+	if (hdr->Command == SMB2_READ) {
+		iov = &work->iov[work->iov_idx - 1];
 		n_vec++;
+	} else {
+		iov = &work->iov[work->iov_idx];
 	}
 
 	if (!ksmbd_sign_smb2_pdu(work->conn, work->sess->sess_key, iov, n_vec,
@@ -8449,29 +8413,14 @@ int smb3_check_sign_req(struct ksmbd_work *work)
 void smb3_set_sign_rsp(struct ksmbd_work *work)
 {
 	struct ksmbd_conn *conn = work->conn;
-	struct smb2_hdr *req_hdr, *hdr;
+	struct smb2_hdr *hdr;
 	struct channel *chann;
 	char signature[SMB2_CMACAES_SIZE];
-	struct kvec iov[2];
+	struct kvec *iov;
 	int n_vec = 1;
-	size_t len;
 	char *signing_key;
 
-	hdr = smb2_get_msg(work->response_buf);
-	if (work->next_smb2_rsp_hdr_off)
-		hdr = ksmbd_resp_buf_next(work);
-
-	req_hdr = ksmbd_req_buf_next(work);
-
-	if (!work->next_smb2_rsp_hdr_off) {
-		len = get_rfc1002_len(work->response_buf);
-		if (req_hdr->NextCommand)
-			len = ALIGN(len, 8);
-	} else {
-		len = get_rfc1002_len(work->response_buf) -
-			work->next_smb2_rsp_hdr_off;
-		len = ALIGN(len, 8);
-	}
+	hdr = ksmbd_resp_buf_curr(work);
 
 	if (conn->binding == false &&
 	    le16_to_cpu(hdr->Command) == SMB2_SESSION_SETUP_HE) {
@@ -8487,21 +8436,18 @@ void smb3_set_sign_rsp(struct ksmbd_work *work)
 	if (!signing_key)
 		return;
 
-	if (req_hdr->NextCommand)
-		hdr->NextCommand = cpu_to_le32(len);
-
 	hdr->Flags |= SMB2_FLAGS_SIGNED;
 	memset(hdr->Signature, 0, SMB2_SIGNATURE_SIZE);
-	iov[0].iov_base = (char *)&hdr->ProtocolId;
-	iov[0].iov_len = len;
-	if (work->aux_payload_sz) {
-		iov[0].iov_len -= work->aux_payload_sz;
-		iov[1].iov_base = work->aux_payload_buf;
-		iov[1].iov_len = work->aux_payload_sz;
+
+	if (hdr->Command == SMB2_READ) {
+		iov = &work->iov[work->iov_idx - 1];
 		n_vec++;
+	} else {
+		iov = &work->iov[work->iov_idx];
 	}
 
-	if (!ksmbd_sign_smb3_pdu(conn, signing_key, iov, n_vec, signature))
+	if (!ksmbd_sign_smb3_pdu(conn, signing_key, iov, n_vec,
+				 signature))
 		memcpy(hdr->Signature, signature, SMB2_SIGNATURE_SIZE);
 }
 
@@ -8568,45 +8514,22 @@ static void fill_transform_hdr(void *tr_buf, char *old_buf, __le16 cipher_type)
 
 int smb3_encrypt_resp(struct ksmbd_work *work)
 {
-	char *buf = work->response_buf;
-	struct kvec iov[3];
+	struct kvec *iov = work->iov;
 	int rc = -ENOMEM;
-	int buf_size = 0, rq_nvec = 2 + (work->aux_payload_sz ? 1 : 0);
+	void *tr_buf;
 
-	if (ARRAY_SIZE(iov) < rq_nvec)
-		return -ENOMEM;
-
-	work->tr_buf = kzalloc(sizeof(struct smb2_transform_hdr) + 4, GFP_KERNEL);
-	if (!work->tr_buf)
+	tr_buf = kzalloc(sizeof(struct smb2_transform_hdr) + 4, GFP_KERNEL);
+	if (!tr_buf)
 		return rc;
 
 	/* fill transform header */
-	fill_transform_hdr(work->tr_buf, buf, work->conn->cipher_type);
+	fill_transform_hdr(tr_buf, work->response_buf, work->conn->cipher_type);
 
-	iov[0].iov_base = work->tr_buf;
+	iov[0].iov_base = tr_buf;
 	iov[0].iov_len = sizeof(struct smb2_transform_hdr) + 4;
-	buf_size += iov[0].iov_len - 4;
-
-	iov[1].iov_base = buf + 4;
-	iov[1].iov_len = get_rfc1002_len(buf);
-	if (work->aux_payload_sz) {
-		iov[1].iov_len = work->resp_hdr_sz - 4;
-
-		iov[2].iov_base = work->aux_payload_buf;
-		iov[2].iov_len = work->aux_payload_sz;
-		buf_size += iov[2].iov_len;
-	}
-	buf_size += iov[1].iov_len;
-	work->resp_hdr_sz = iov[1].iov_len;
+	work->tr_buf = tr_buf;
 
-	rc = ksmbd_crypt_message(work, iov, rq_nvec, 1);
-	if (rc)
-		return rc;
-
-	memmove(buf, iov[1].iov_base, iov[1].iov_len);
-	*(__be32 *)work->tr_buf = cpu_to_be32(buf_size);
-
-	return rc;
+	return ksmbd_crypt_message(work, iov, work->iov_idx + 1, 1);
 }
 
 bool smb3_is_transform_hdr(void *buf)
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index c2b75d898852..e6ba1e9b8589 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -319,12 +319,6 @@ static int init_smb1_rsp_hdr(struct ksmbd_work *work)
 	struct smb_hdr *rsp_hdr = (struct smb_hdr *)work->response_buf;
 	struct smb_hdr *rcv_hdr = (struct smb_hdr *)work->request_buf;
 
-	/*
-	 * Remove 4 byte direct TCP header.
-	 */
-	*(__be32 *)work->response_buf =
-		cpu_to_be32(sizeof(struct smb_hdr) - 4);
-
 	rsp_hdr->Command = SMB_COM_NEGOTIATE;
 	*(__le32 *)rsp_hdr->Protocol = SMB1_PROTO_NUMBER;
 	rsp_hdr->Flags = SMBFLG_RESPONSE;
@@ -560,10 +554,11 @@ static int smb_handle_negotiate(struct ksmbd_work *work)
 
 	ksmbd_debug(SMB, "Unsupported SMB1 protocol\n");
 
-	/* Add 2 byte bcc and 2 byte DialectIndex. */
-	inc_rfc1001_len(work->response_buf, 4);
-	neg_rsp->hdr.Status.CifsError = STATUS_SUCCESS;
+	if (ksmbd_iov_pin_rsp(work, (void *)neg_rsp,
+			      sizeof(struct smb_negotiate_rsp) - 4))
+		return -ENOMEM;
 
+	neg_rsp->hdr.Status.CifsError = STATUS_SUCCESS;
 	neg_rsp->hdr.WordCount = 1;
 	neg_rsp->DialectIndex = cpu_to_le16(work->conn->dialect);
 	neg_rsp->ByteCount = 0;
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 3d5d652153a5..cf9007dc2c71 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -367,15 +367,15 @@ static int check_lock_range(struct file *filp, loff_t start, loff_t end,
  * @fid:	file id of open file
  * @count:	read byte count
  * @pos:	file pos
+ * @rbuf:	read data buffer
  *
  * Return:	number of read bytes on success, otherwise error
  */
 int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
-		   loff_t *pos)
+		   loff_t *pos, char *rbuf)
 {
 	struct file *filp = fp->filp;
 	ssize_t nbytes = 0;
-	char *rbuf = work->aux_payload_buf;
 	struct inode *inode = file_inode(filp);
 
 	if (S_ISDIR(inode->i_mode))
diff --git a/fs/smb/server/vfs.h b/fs/smb/server/vfs.h
index 72f9fb4b48d1..00968081856e 100644
--- a/fs/smb/server/vfs.h
+++ b/fs/smb/server/vfs.h
@@ -76,8 +76,8 @@ void ksmbd_vfs_query_maximal_access(struct mnt_idmap *idmap,
 				   struct dentry *dentry, __le32 *daccess);
 int ksmbd_vfs_create(struct ksmbd_work *work, const char *name, umode_t mode);
 int ksmbd_vfs_mkdir(struct ksmbd_work *work, const char *name, umode_t mode);
-int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp,
-		   size_t count, loff_t *pos);
+int ksmbd_vfs_read(struct ksmbd_work *work, struct ksmbd_file *fp, size_t count,
+		   loff_t *pos, char *rbuf);
 int ksmbd_vfs_write(struct ksmbd_work *work, struct ksmbd_file *fp,
 		    char *buf, size_t count, loff_t *pos, bool sync,
 		    ssize_t *written);
-- 
2.25.1

