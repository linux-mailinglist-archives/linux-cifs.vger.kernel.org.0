Return-Path: <linux-cifs+bounces-5546-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DA5C9B1CB18
	for <lists+linux-cifs@lfdr.de>; Wed,  6 Aug 2025 19:38:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A0B918C5064
	for <lists+linux-cifs@lfdr.de>; Wed,  6 Aug 2025 17:38:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98D1D1E5B72;
	Wed,  6 Aug 2025 17:38:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="cyOezjHz"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4C2D231845
	for <linux-cifs@vger.kernel.org>; Wed,  6 Aug 2025 17:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501890; cv=none; b=tl3kgB5lpC38JQn6XUk3VKOINrkyXN7/5h33auO8pSy4oRYCkdNtM4piM2/QQ3ph+NQh4QXRy3YdRwup6XJzL4bLL2LcEZdiQWVMRNolIQfB+13IMPpuQH+6rhqd8Nhd8IPH0ohbHuERRSPYC++KYtR7XSarnfDCymZgzOs2H/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501890; c=relaxed/simple;
	bh=/r/l/6FXdunsCkrolJdtByRaYdd0Tno4zsoYgYKxRa8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ad4dxEzgyLGvdeF7AiYtbpNxsCwp5bFwu7knQ2K6ZDQyGfKtj0Fytg3bycFZcz/rjVzOdKzMVwYx0PwjA7Mk9cwYCHnnJIyleOoZ1cQMf0eMORh2pzaEd8sh/YF8ZmSzf8Niyyw759z9wzZAJKV2cE50lnPfiz3UGUc2qebvADM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=cyOezjHz; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=aaVgtGb2um16ZxY0EEo6WznoDPRZvQvo+VAFjeRVgKQ=; b=cyOezjHzT3g3BcdaLbLpwHhpr6
	PXhCmCMs7c++O3zbRtwXoAxxV8qkCvK/ENbU35uQtbCxolcpbujl4wNjVaDCLYDXD55HWGrjpB0J7
	/9nzUBlPWJiuFPdlfzdquVIbhY92o+6SzL07vvvExPKRSP1ebKwoAmgmCROk6pkUno+tXrgpJxx/s
	4vYy61hbYG4DbrvlkAjLuuODo3sHXsggQA3FkyxU5Ei1ycVMkTFCeFwYcFTP6PU/WVtEER7czuCSl
	LY36Gz30KcZ6z2wGFIYbmZqgvhPtbYwahai5VY+LUpnPfTOHFo70ptqubXSpxI6wSLN/tM6DpAMgs
	AWsxnoCbuF26jZbd+uUNRKYBJHgnYv9uWKtipU46kkyl42CuGiifDqWVoL1Pu3Ttslu3NbJxsKuep
	JFDctyUmsOiS4QwBpTcRPLVdmgWb0UZanG4MbQlqv+CjSQiriu0H//EGRYytu/LUGPT3t483OSQcB
	LaT9FncwySebSLUFcI3U1C1b;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uji5U-001OpS-0m;
	Wed, 06 Aug 2025 17:38:04 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 15/18] smb: server: make use of smbdirect_socket.recv_io.reassembly.*
Date: Wed,  6 Aug 2025 19:36:01 +0200
Message-ID: <ba4a6310663b710cf222370620cad34dff96e242.1754501401.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754501401.git.metze@samba.org>
References: <cover.1754501401.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This is also used by the client and will allow us to introduce
common helper functions soon.

Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 fs/smb/server/transport_rdma.c | 90 ++++++++++++++++------------------
 1 file changed, 43 insertions(+), 47 deletions(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index aebd29242a2b..7fcd80c329d7 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -95,16 +95,8 @@ struct smb_direct_transport {
 
 	struct smbdirect_socket socket;
 
-	bool			full_packet_received;
 	wait_queue_head_t	wait_status;
 
-	spinlock_t		reassembly_queue_lock;
-	struct list_head	reassembly_queue;
-	int			reassembly_data_length;
-	int			reassembly_queue_length;
-	int			first_entry_offset;
-	wait_queue_head_t	wait_reassembly_queue;
-
 	spinlock_t		receive_credit_lock;
 	int			recv_credits;
 	int			count_avail_recvmsg;
@@ -251,9 +243,11 @@ static void enqueue_reassembly(struct smb_direct_transport *t,
 			       struct smbdirect_recv_io *recvmsg,
 			       int data_length)
 {
-	spin_lock(&t->reassembly_queue_lock);
-	list_add_tail(&recvmsg->list, &t->reassembly_queue);
-	t->reassembly_queue_length++;
+	struct smbdirect_socket *sc = &t->socket;
+
+	spin_lock(&sc->recv_io.reassembly.lock);
+	list_add_tail(&recvmsg->list, &sc->recv_io.reassembly.list);
+	sc->recv_io.reassembly.queue_length++;
 	/*
 	 * Make sure reassembly_data_length is updated after list and
 	 * reassembly_queue_length are updated. On the dequeue side
@@ -261,14 +255,16 @@ static void enqueue_reassembly(struct smb_direct_transport *t,
 	 * if reassembly_queue_length and list is up to date
 	 */
 	virt_wmb();
-	t->reassembly_data_length += data_length;
-	spin_unlock(&t->reassembly_queue_lock);
+	sc->recv_io.reassembly.data_length += data_length;
+	spin_unlock(&sc->recv_io.reassembly.lock);
 }
 
 static struct smbdirect_recv_io *get_first_reassembly(struct smb_direct_transport *t)
 {
-	if (!list_empty(&t->reassembly_queue))
-		return list_first_entry(&t->reassembly_queue,
+	struct smbdirect_socket *sc = &t->socket;
+
+	if (!list_empty(&sc->recv_io.reassembly.list))
+		return list_first_entry(&sc->recv_io.reassembly.list,
 				struct smbdirect_recv_io, list);
 	else
 		return NULL;
@@ -330,11 +326,11 @@ static struct smb_direct_transport *alloc_transport(struct rdma_cm_id *cm_id)
 	sc->status = SMBDIRECT_SOCKET_CREATED;
 	init_waitqueue_head(&t->wait_status);
 
-	spin_lock_init(&t->reassembly_queue_lock);
-	INIT_LIST_HEAD(&t->reassembly_queue);
-	t->reassembly_data_length = 0;
-	t->reassembly_queue_length = 0;
-	init_waitqueue_head(&t->wait_reassembly_queue);
+	spin_lock_init(&sc->recv_io.reassembly.lock);
+	INIT_LIST_HEAD(&sc->recv_io.reassembly.list);
+	sc->recv_io.reassembly.data_length = 0;
+	sc->recv_io.reassembly.queue_length = 0;
+	init_waitqueue_head(&sc->recv_io.reassembly.wait_queue);
 	init_waitqueue_head(&t->wait_send_credits);
 	init_waitqueue_head(&t->wait_rw_credits);
 
@@ -391,17 +387,17 @@ static void free_transport(struct smb_direct_transport *t)
 
 	ksmbd_debug(RDMA, "drain the reassembly queue\n");
 	do {
-		spin_lock(&t->reassembly_queue_lock);
+		spin_lock(&sc->recv_io.reassembly.lock);
 		recvmsg = get_first_reassembly(t);
 		if (recvmsg) {
 			list_del(&recvmsg->list);
-			spin_unlock(&t->reassembly_queue_lock);
+			spin_unlock(&sc->recv_io.reassembly.lock);
 			put_recvmsg(t, recvmsg);
 		} else {
-			spin_unlock(&t->reassembly_queue_lock);
+			spin_unlock(&sc->recv_io.reassembly.lock);
 		}
 	} while (recvmsg);
-	t->reassembly_data_length = 0;
+	sc->recv_io.reassembly.data_length = 0;
 
 	if (sc->ib.send_cq)
 		ib_free_cq(sc->ib.send_cq);
@@ -533,7 +529,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 			return;
 		}
 		t->negotiation_requested = true;
-		t->full_packet_received = true;
+		sc->recv_io.reassembly.full_packet_received = true;
 		sc->status = SMBDIRECT_SOCKET_CONNECTED;
 		enqueue_reassembly(t, recvmsg, 0);
 		wake_up_interruptible(&t->wait_status);
@@ -560,13 +556,13 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 				return;
 			}
 
-			if (t->full_packet_received)
+			if (sc->recv_io.reassembly.full_packet_received)
 				recvmsg->first_segment = true;
 
 			if (le32_to_cpu(data_transfer->remaining_data_length))
-				t->full_packet_received = false;
+				sc->recv_io.reassembly.full_packet_received = false;
 			else
-				t->full_packet_received = true;
+				sc->recv_io.reassembly.full_packet_received = true;
 
 			spin_lock(&t->receive_credit_lock);
 			receive_credits = --(t->recv_credits);
@@ -597,7 +593,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 
 		if (data_length) {
 			enqueue_reassembly(t, recvmsg, (int)data_length);
-			wake_up_interruptible(&t->wait_reassembly_queue);
+			wake_up_interruptible(&sc->recv_io.reassembly.wait_queue);
 		} else
 			put_recvmsg(t, recvmsg);
 
@@ -675,7 +671,7 @@ static int smb_direct_read(struct ksmbd_transport *t, char *buf,
 	 * the only one reading from the front of the queue. The transport
 	 * may add more entries to the back of the queue at the same time
 	 */
-	if (st->reassembly_data_length >= size) {
+	if (sc->recv_io.reassembly.data_length >= size) {
 		int queue_length;
 		int queue_removed = 0;
 
@@ -687,10 +683,10 @@ static int smb_direct_read(struct ksmbd_transport *t, char *buf,
 		 * updated in SOFTIRQ as more data is received
 		 */
 		virt_rmb();
-		queue_length = st->reassembly_queue_length;
+		queue_length = sc->recv_io.reassembly.queue_length;
 		data_read = 0;
 		to_read = size;
-		offset = st->first_entry_offset;
+		offset = sc->recv_io.reassembly.first_entry_offset;
 		while (data_read < size) {
 			recvmsg = get_first_reassembly(st);
 			data_transfer = smbdirect_recv_io_payload(recvmsg);
@@ -733,9 +729,9 @@ static int smb_direct_read(struct ksmbd_transport *t, char *buf,
 				if (queue_length) {
 					list_del(&recvmsg->list);
 				} else {
-					spin_lock_irq(&st->reassembly_queue_lock);
+					spin_lock_irq(&sc->recv_io.reassembly.lock);
 					list_del(&recvmsg->list);
-					spin_unlock_irq(&st->reassembly_queue_lock);
+					spin_unlock_irq(&sc->recv_io.reassembly.lock);
 				}
 				queue_removed++;
 				put_recvmsg(st, recvmsg);
@@ -748,10 +744,10 @@ static int smb_direct_read(struct ksmbd_transport *t, char *buf,
 			data_read += to_copy;
 		}
 
-		spin_lock_irq(&st->reassembly_queue_lock);
-		st->reassembly_data_length -= data_read;
-		st->reassembly_queue_length -= queue_removed;
-		spin_unlock_irq(&st->reassembly_queue_lock);
+		spin_lock_irq(&sc->recv_io.reassembly.lock);
+		sc->recv_io.reassembly.data_length -= data_read;
+		sc->recv_io.reassembly.queue_length -= queue_removed;
+		spin_unlock_irq(&sc->recv_io.reassembly.lock);
 
 		spin_lock(&st->receive_credit_lock);
 		st->count_avail_recvmsg += queue_removed;
@@ -763,18 +759,18 @@ static int smb_direct_read(struct ksmbd_transport *t, char *buf,
 			spin_unlock(&st->receive_credit_lock);
 		}
 
-		st->first_entry_offset = offset;
+		sc->recv_io.reassembly.first_entry_offset = offset;
 		ksmbd_debug(RDMA,
 			    "returning to thread data_read=%d reassembly_data_length=%d first_entry_offset=%d\n",
-			    data_read, st->reassembly_data_length,
-			    st->first_entry_offset);
+			    data_read, sc->recv_io.reassembly.data_length,
+			    sc->recv_io.reassembly.first_entry_offset);
 read_rfc1002_done:
 		return data_read;
 	}
 
 	ksmbd_debug(RDMA, "wait_event on more data\n");
-	rc = wait_event_interruptible(st->wait_reassembly_queue,
-				      st->reassembly_data_length >= size ||
+	rc = wait_event_interruptible(sc->recv_io.reassembly.wait_queue,
+				      sc->recv_io.reassembly.data_length >= size ||
 				       sc->status != SMBDIRECT_SOCKET_CONNECTED);
 	if (rc)
 		return -EINTR;
@@ -1529,7 +1525,7 @@ static int smb_direct_cm_handler(struct rdma_cm_id *cm_id,
 
 		sc->status = SMBDIRECT_SOCKET_DISCONNECTED;
 		wake_up_interruptible(&t->wait_status);
-		wake_up_interruptible(&t->wait_reassembly_queue);
+		wake_up_interruptible(&sc->recv_io.reassembly.wait_queue);
 		wake_up(&t->wait_send_credits);
 		break;
 	}
@@ -1991,10 +1987,10 @@ static int smb_direct_prepare(struct ksmbd_transport *t)
 
 	ret = smb_direct_send_negotiate_response(st, ret);
 out:
-	spin_lock_irq(&st->reassembly_queue_lock);
-	st->reassembly_queue_length--;
+	spin_lock_irq(&sc->recv_io.reassembly.lock);
+	sc->recv_io.reassembly.queue_length--;
 	list_del(&recvmsg->list);
-	spin_unlock_irq(&st->reassembly_queue_lock);
+	spin_unlock_irq(&sc->recv_io.reassembly.lock);
 	put_recvmsg(st, recvmsg);
 
 	return ret;
-- 
2.43.0


