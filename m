Return-Path: <linux-cifs+bounces-7211-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id A1785C1AF57
	for <lists+linux-cifs@lfdr.de>; Wed, 29 Oct 2025 14:52:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0CED65A2976
	for <lists+linux-cifs@lfdr.de>; Wed, 29 Oct 2025 13:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90B7E34DCCC;
	Wed, 29 Oct 2025 13:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="cLoHtjWV"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BD8A34D4DC
	for <linux-cifs@vger.kernel.org>; Wed, 29 Oct 2025 13:31:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761744664; cv=none; b=d9m+Uz+lbsHT2EXJClGQEYNt2af61DVteYsjhl+LHzazlu/2IRUy6u5LML5tk+3IJdH0TIUBusgeFvvQOVSz9gpodL/9AA0G3DIeKJYWfRZ5/zvZxiTYy5DVgDMo8gdkFB7Hfe1cNh+KM4KoYCbpwEZDLdnK6V3SkhPs66ZWZXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761744664; c=relaxed/simple;
	bh=X4e+X+2/rCekbWqbbq7LA86PLYPt6pUfp8/wMrN2MSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oe3OIbga4zmTPLl6EM+uZsKw6BirhVvatqLdQvD7+FWyviNyHL7KivrpSN16+f4nCWEzHmaf49lteerP0Bh8/QPBpJ/ALn+f46q7M4eDGdxwK8G6wfhV1DfvtpJEjEYG4ryL252riC8bXnMxz7CwdM5ddGN868FHEPJkbzfyj9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=cLoHtjWV; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=fVVuDK/r2we4MtUpjXX/tnK2xQWKRCtnZ3+FFZZxfsA=; b=cLoHtjWVB0gcc6kPk7apyFI7e6
	AdYLbYjdEU0/CgwUYNbJFNNOINpEJptzy/PbtML5sN9SeeBDnn3l7olYgoJBRm7mHvwR6YjAWfY8F
	Ev/FYZZHVrR9YFM+P09OFxEkKUHcX3n7TVGr7qBru7od9epo8cJtkmZGUbIhcHpIj01ce4gjMsjEk
	/MrNIE3mFmd1DYiVNfnP2ZfKKBv51Q6Ex9b4NbubPSm9vJNi3D8LCeuB1nBHBlyeYWlxYbCZ3GH/b
	k4G8HAAg9uVj739o76LWmJxg3ENyRw7LQqDfamxNtBgJURJE0Mt+8qz40wXcK/2envnqF4htT/D4W
	zvYpc1BJ/9XS4gglq/LbAgTcD6xhrkJ/WtmxuQ3Srh/egH6VupA3yTYQpdGYWcPtMTXNO/ZYerlGJ
	i0unXUvpDQwbtqrSbqlrBYsxDEsJR2ZNHCsXKtmDy/ymcaF051D0OEiYWo0lm2R+s6a2D83ZU8kVf
	TFV+fz/pdUnvYIr3BpB2kK4M;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vE6GR-00BcSj-0X;
	Wed, 29 Oct 2025 13:30:59 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	David Howells <dhowells@redhat.com>
Subject: [PATCH v2 085/127] smb: client: make use of smbdirect_connection_send_{single_iter,immediate_work}()
Date: Wed, 29 Oct 2025 14:21:03 +0100
Message-ID: <56042dcfb400fa86f6fa71191ab711133af83062.1761742839.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1761742839.git.metze@samba.org>
References: <cover.1761742839.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

With this the low level send functions are in common,
we'll have to do some more changes in generic smb code
in order to use smbdirect_connection_send_iter() instead
of looping around smbdirect_connection_send_single_iter().

David's cleanups will allow us to use
smbdirect_connection_send_iter().

Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 fs/smb/client/smbdirect.c | 253 +++-----------------------------------
 1 file changed, 15 insertions(+), 238 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index fb3cf25b78f8..1e17daaac227 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -728,223 +728,6 @@ static int smbd_post_send_negotiate_req(struct smbdirect_socket *sc)
 	return rc;
 }
 
-/* Post the send request */
-static int smbd_post_send(struct smbdirect_socket *sc,
-		struct smbdirect_send_io *request)
-{
-	int rc, i;
-
-	for (i = 0; i < request->num_sge; i++) {
-		log_rdma_send(INFO,
-			"rdma_request sge[%d] addr=0x%llx length=%u\n",
-			i, request->sge[i].addr, request->sge[i].length);
-		ib_dma_sync_single_for_device(
-			sc->ib.dev,
-			request->sge[i].addr,
-			request->sge[i].length,
-			DMA_TO_DEVICE);
-	}
-
-	request->cqe.done = smbdirect_connection_send_io_done;
-
-	request->wr.next = NULL;
-	request->wr.wr_cqe = &request->cqe;
-	request->wr.sg_list = request->sge;
-	request->wr.num_sge = request->num_sge;
-	request->wr.opcode = IB_WR_SEND;
-	request->wr.send_flags = IB_SEND_SIGNALED;
-
-	rc = ib_post_send(sc->ib.qp, &request->wr, NULL);
-	if (rc) {
-		log_rdma_send(ERR, "ib_post_send failed rc=%d\n", rc);
-		smbdirect_connection_schedule_disconnect(sc, rc);
-		rc = -EAGAIN;
-	}
-
-	return rc;
-}
-
-static int smbd_post_send_iter(struct smbdirect_socket *sc,
-			       struct iov_iter *iter,
-			       u32 remaining_data_length)
-{
-	struct smbdirect_socket_parameters *sp = &sc->parameters;
-	int rc;
-	int header_length;
-	int data_length;
-	struct smbdirect_send_io *request;
-	struct smbdirect_data_transfer *packet;
-	u16 new_credits = 0;
-
-	if (iter) {
-		header_length = sizeof(struct smbdirect_data_transfer);
-		if (WARN_ON_ONCE(remaining_data_length == 0 ||
-				 iov_iter_count(iter) > remaining_data_length))
-			return -EINVAL;
-	} else {
-		/* If this is a packet without payload, don't send padding */
-		header_length = offsetof(struct smbdirect_data_transfer, padding);
-		if (WARN_ON_ONCE(remaining_data_length))
-			return -EINVAL;
-	}
-
-wait_lcredit:
-	/* Wait for local send credits */
-	rc = wait_event_interruptible(sc->send_io.lcredits.wait_queue,
-		atomic_read(&sc->send_io.lcredits.count) > 0 ||
-		sc->status != SMBDIRECT_SOCKET_CONNECTED);
-	if (rc)
-		goto err_wait_lcredit;
-
-	if (sc->status != SMBDIRECT_SOCKET_CONNECTED) {
-		log_outgoing(ERR, "disconnected not sending on wait_credit\n");
-		rc = -EAGAIN;
-		goto err_wait_lcredit;
-	}
-	if (unlikely(atomic_dec_return(&sc->send_io.lcredits.count) < 0)) {
-		atomic_inc(&sc->send_io.lcredits.count);
-		goto wait_lcredit;
-	}
-
-wait_credit:
-	/* Wait for send credits. A SMBD packet needs one credit */
-	rc = wait_event_interruptible(sc->send_io.credits.wait_queue,
-		atomic_read(&sc->send_io.credits.count) > 0 ||
-		sc->status != SMBDIRECT_SOCKET_CONNECTED);
-	if (rc)
-		goto err_wait_credit;
-
-	if (sc->status != SMBDIRECT_SOCKET_CONNECTED) {
-		log_outgoing(ERR, "disconnected not sending on wait_credit\n");
-		rc = -EAGAIN;
-		goto err_wait_credit;
-	}
-	if (unlikely(atomic_dec_return(&sc->send_io.credits.count) < 0)) {
-		atomic_inc(&sc->send_io.credits.count);
-		goto wait_credit;
-	}
-
-	request = smbdirect_connection_alloc_send_io(sc);
-	if (IS_ERR(request)) {
-		rc = PTR_ERR(request);
-		goto err_alloc;
-	}
-
-	memset(request->sge, 0, sizeof(request->sge));
-
-	packet = smbdirect_send_io_payload(request);
-	request->sge[0].addr = ib_dma_map_single(sc->ib.dev,
-						 (void *)packet,
-						 header_length,
-						 DMA_TO_DEVICE);
-	if (ib_dma_mapping_error(sc->ib.dev, request->sge[0].addr)) {
-		rc = -EIO;
-		goto err_dma;
-	}
-
-	request->sge[0].length = header_length;
-	request->sge[0].lkey = sc->ib.pd->local_dma_lkey;
-	request->num_sge = 1;
-
-	/* Fill in the data payload to find out how much data we can add */
-	if (iter) {
-		struct smbdirect_map_sges extract = {
-			.num_sge	= request->num_sge,
-			.max_sge	= ARRAY_SIZE(request->sge),
-			.sge		= request->sge,
-			.device		= sc->ib.dev,
-			.local_dma_lkey	= sc->ib.pd->local_dma_lkey,
-			.direction	= DMA_TO_DEVICE,
-		};
-		size_t payload_len = umin(iov_iter_count(iter),
-					  sp->max_send_size - sizeof(*packet));
-
-		rc = smbdirect_map_sges_from_iter(iter, payload_len, &extract);
-		if (rc < 0)
-			goto err_dma;
-		data_length = rc;
-		request->num_sge = extract.num_sge;
-		remaining_data_length -= data_length;
-	} else {
-		data_length = 0;
-	}
-
-	/* Fill in the packet header */
-	packet->credits_requested = cpu_to_le16(sp->send_credit_target);
-
-	new_credits = smbdirect_connection_grant_recv_credits(sc);
-	packet->credits_granted = cpu_to_le16(new_credits);
-
-	packet->flags = 0;
-	if (smbdirect_connection_request_keep_alive(sc))
-		packet->flags |= cpu_to_le16(SMBDIRECT_FLAG_RESPONSE_REQUESTED);
-
-	packet->reserved = 0;
-	if (!data_length)
-		packet->data_offset = 0;
-	else
-		packet->data_offset = cpu_to_le32(24);
-	packet->data_length = cpu_to_le32(data_length);
-	packet->remaining_data_length = cpu_to_le32(remaining_data_length);
-	packet->padding = 0;
-
-	log_outgoing(INFO, "credits_requested=%d credits_granted=%d data_offset=%d data_length=%d remaining_data_length=%d\n",
-		     le16_to_cpu(packet->credits_requested),
-		     le16_to_cpu(packet->credits_granted),
-		     le32_to_cpu(packet->data_offset),
-		     le32_to_cpu(packet->data_length),
-		     le32_to_cpu(packet->remaining_data_length));
-
-	/*
-	 * Now that we got a local and a remote credit
-	 * we add us as pending
-	 */
-	atomic_inc(&sc->send_io.pending.count);
-
-	rc = smbd_post_send(sc, request);
-	if (!rc)
-		return data_length;
-
-	if (atomic_dec_and_test(&sc->send_io.pending.count))
-		wake_up(&sc->send_io.pending.zero_wait_queue);
-
-	wake_up(&sc->send_io.pending.dec_wait_queue);
-
-err_dma:
-	smbdirect_connection_free_send_io(request);
-
-	/* roll back the granted receive credits */
-	atomic_sub(new_credits, &sc->recv_io.credits.count);
-
-err_alloc:
-	atomic_inc(&sc->send_io.credits.count);
-	wake_up(&sc->send_io.credits.wait_queue);
-
-err_wait_credit:
-	atomic_inc(&sc->send_io.lcredits.count);
-	wake_up(&sc->send_io.lcredits.wait_queue);
-
-err_wait_lcredit:
-	return rc;
-}
-
-/*
- * Send an empty message
- * Empty message is used to extend credits to peer to for keep live
- * while there is no upper layer payload to send at the time
- */
-static void smbd_post_send_empty(struct smbdirect_socket *sc)
-{
-	int ret;
-
-	sc->statistics.send_empty++;
-	ret = smbd_post_send_iter(sc, NULL, 0);
-	if (ret < 0) {
-		log_rdma_send(ERR, "smbd_post_send_iter failed ret=%d\n", ret);
-		smbdirect_connection_schedule_disconnect(sc, ret);
-	}
-}
-
 static int smbd_post_send_full_iter(struct smbdirect_socket *sc,
 				    struct iov_iter *iter,
 				    u32 remaining_data_length)
@@ -952,7 +735,7 @@ static int smbd_post_send_full_iter(struct smbdirect_socket *sc,
 	int bytes = 0;
 
 	/*
-	 * smbd_post_send_iter() respects the
+	 * smbdirect_connection_send_single_iter() respects the
 	 * negotiated max_send_size, so we need to
 	 * loop until the full iter is posted
 	 */
@@ -960,7 +743,11 @@ static int smbd_post_send_full_iter(struct smbdirect_socket *sc,
 	while (iov_iter_count(iter) > 0) {
 		int rc;
 
-		rc = smbd_post_send_iter(sc, iter, remaining_data_length);
+		rc = smbdirect_connection_send_single_iter(sc,
+							   NULL, /* batch */
+							   iter,
+							   0, /* flags */
+							   remaining_data_length);
 		if (rc < 0)
 			return rc;
 		remaining_data_length -= rc;
@@ -1013,18 +800,6 @@ static int smbd_negotiate(struct smbdirect_socket *sc)
 	return rc;
 }
 
-static void send_immediate_empty_message(struct work_struct *work)
-{
-	struct smbdirect_socket *sc =
-		container_of(work, struct smbdirect_socket, idle.immediate_work);
-
-	if (sc->status != SMBDIRECT_SOCKET_CONNECTED)
-		return;
-
-	log_keep_alive(INFO, "send an empty message\n");
-	smbd_post_send_empty(sc);
-}
-
 /*
  * Destroy the transport and related RDMA and memory resources
  * Need to go through all the pending counters and make sure on one is using
@@ -1207,7 +982,7 @@ static struct smbd_connection *_smbd_get_connection(
 	list_for_each_entry(recv_io, &sc->recv_io.free.list, list)
 		recv_io->cqe.done = recv_done;
 
-	INIT_WORK(&sc->idle.immediate_work, send_immediate_empty_message);
+	INIT_WORK(&sc->idle.immediate_work, smbdirect_connection_send_immediate_work);
 	/*
 	 * start with the negotiate timeout and SMBDIRECT_KEEPALIVE_PENDING
 	 * so that the timer will cause a disconnect.
@@ -1325,6 +1100,7 @@ int smbd_send(struct TCP_Server_Info *server,
 	struct iov_iter iter;
 	unsigned int remaining_data_length, klen;
 	int rc, i, rqst_idx;
+	int error = 0;
 
 	if (sc->status != SMBDIRECT_SOCKET_CONNECTED)
 		return -EAGAIN;
@@ -1392,14 +1168,15 @@ int smbd_send(struct TCP_Server_Info *server,
 	 * that means all the I/Os have been out and we are good to return
 	 */
 
-	wait_event(sc->send_io.pending.zero_wait_queue,
-		atomic_read(&sc->send_io.pending.count) == 0 ||
-		sc->status != SMBDIRECT_SOCKET_CONNECTED);
+	error = rc;
+	rc = smbdirect_connection_send_wait_zero_pending(sc);
+	if (unlikely(rc && !error))
+		error = -EAGAIN;
 
-	if (sc->status != SMBDIRECT_SOCKET_CONNECTED && rc == 0)
-		rc = -EAGAIN;
+	if (unlikely(error))
+		return error;
 
-	return rc;
+	return 0;
 }
 
 /*
-- 
2.43.0


