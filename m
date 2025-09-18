Return-Path: <linux-cifs+bounces-5544-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D1CD6B1CB15
	for <lists+linux-cifs@lfdr.de>; Wed,  6 Aug 2025 19:38:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85BA518C50C4
	for <lists+linux-cifs@lfdr.de>; Wed,  6 Aug 2025 17:38:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 494E92918C8;
	Wed,  6 Aug 2025 17:37:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="XY6pJ3tD"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C3BA1A08BC
	for <linux-cifs@vger.kernel.org>; Wed,  6 Aug 2025 17:37:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754501875; cv=none; b=SKCquzGRfiVD0KYz1mYryKeSoajWeUTwoBJCOQqdg78nCD7D+QEeNkuXcciFadI5t8V6u39rN2XO27z4xYHYp75rJvi8G3PjbBxVg1dcc7zEMzLnSKQiDrZFeGp91UeWV7PLU9l0IkAnA40kSK9CahEl5h2dyqZlc/YHo2xd7v4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754501875; c=relaxed/simple;
	bh=lr07vdmNGZY79oiN8WP3SZdl4eASmmmbEkVopSIbJIc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HO3w9sAwj1pPHFXf7jYTsEMpKUP4VhXSSUtyUpUoC3D6eFrahiBR05pulNUckLgG2EjvLYWRXxTkiHxvH7QVomHWPpR+DnXSmFv/3lvfNRuzUjZWi6NkLhg1wikBmqAOO6JdQ/BwaeePYCWG3AlXUCLr18b6jcpQgY8tqWKEtAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=XY6pJ3tD; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=ajTGmmY0/GIe8VbaNEaHIfCski11ctNv2pkwy81Uirw=; b=XY6pJ3tDs0grPbADLmeatBjXSi
	mBZGaeUqRqssJefKMIVO4Y3pUD4bChQ+fo1d1xMYWeblCf2PPfETuiodJOrot5OZFRuTxAH4s+q+A
	eB30Jlk0j7McBJIKhq8S7+WeKsuQw68gTXNjKCqR+hv3vFDosrhydCFhAZLS+YEdzLiF2t9PbBM7+
	TFLb+0fulcvaZUFlyOcuzm3iiO8Gxh8itRO8zYMnhOAy52uxP1Bqi+qcSKAbmKfMPEhz8j4zXXwqI
	2UBPjwHYhKqZEs7Q5Ta43TzNbT+6nbf+oacglVb43RqfQLl+/wl5y6nqS9CZZNpMDXBZJOwCw5J2t
	zukyZBr4KsmQK5TsZk+PLDf8m/ajQNbkkPmY8V7EnfpNOVo+dq7K2lqolZ9IVN/uPdt/S3jDoEu7H
	c4N30oMEbSv3IXuIJfKk8g2OCZ9fcCz5wp8jiuBMyKPamuvpU8QEsx1KL3raN8xnvbWWyIzxtBpbV
	AqSKyNWY5hbhFMJkVQ6Q/gn2;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uji5E-001On1-1T;
	Wed, 06 Aug 2025 17:37:48 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>
Subject: [PATCH 13/18] smb: server: make use of struct smbdirect_recv_io
Date: Wed,  6 Aug 2025 19:35:59 +0200
Message-ID: <83b1bc51d813b1235e893028ab253c10662db40d.1754501401.git.metze@samba.org>
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

This will allow us to move helper functions into common code soon
as the client already uses smbdirect_recv_io.

Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 fs/smb/server/transport_rdma.c | 61 +++++++++++++++-------------------
 1 file changed, 26 insertions(+), 35 deletions(-)

diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 14d338a380a3..26d70396b0c1 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -161,15 +161,6 @@ struct smb_direct_sendmsg {
 	u8			packet[];
 };
 
-struct smb_direct_recvmsg {
-	struct smb_direct_transport	*transport;
-	struct list_head	list;
-	struct ib_sge		sge;
-	struct ib_cqe		cqe;
-	bool			first_segment;
-	u8			packet[];
-};
-
 struct smb_direct_rdma_rw_msg {
 	struct smb_direct_transport	*t;
 	struct ib_cqe		cqe;
@@ -212,7 +203,7 @@ smb_trans_direct_transfort(struct ksmbd_transport *t)
 }
 
 static inline void
-*smb_direct_recvmsg_payload(struct smb_direct_recvmsg *recvmsg)
+*smbdirect_recv_io_payload(struct smbdirect_recv_io *recvmsg)
 {
 	return (void *)recvmsg->packet;
 }
@@ -225,14 +216,14 @@ static inline bool is_receive_credit_post_required(int receive_credits,
 }
 
 static struct
-smb_direct_recvmsg *get_free_recvmsg(struct smb_direct_transport *t)
+smbdirect_recv_io *get_free_recvmsg(struct smb_direct_transport *t)
 {
-	struct smb_direct_recvmsg *recvmsg = NULL;
+	struct smbdirect_recv_io *recvmsg = NULL;
 
 	spin_lock(&t->recvmsg_queue_lock);
 	if (!list_empty(&t->recvmsg_queue)) {
 		recvmsg = list_first_entry(&t->recvmsg_queue,
-					   struct smb_direct_recvmsg,
+					   struct smbdirect_recv_io,
 					   list);
 		list_del(&recvmsg->list);
 	}
@@ -241,7 +232,7 @@ smb_direct_recvmsg *get_free_recvmsg(struct smb_direct_transport *t)
 }
 
 static void put_recvmsg(struct smb_direct_transport *t,
-			struct smb_direct_recvmsg *recvmsg)
+			struct smbdirect_recv_io *recvmsg)
 {
 	struct smbdirect_socket *sc = &t->socket;
 
@@ -259,7 +250,7 @@ static void put_recvmsg(struct smb_direct_transport *t,
 }
 
 static void enqueue_reassembly(struct smb_direct_transport *t,
-			       struct smb_direct_recvmsg *recvmsg,
+			       struct smbdirect_recv_io *recvmsg,
 			       int data_length)
 {
 	spin_lock(&t->reassembly_queue_lock);
@@ -276,11 +267,11 @@ static void enqueue_reassembly(struct smb_direct_transport *t,
 	spin_unlock(&t->reassembly_queue_lock);
 }
 
-static struct smb_direct_recvmsg *get_first_reassembly(struct smb_direct_transport *t)
+static struct smbdirect_recv_io *get_first_reassembly(struct smb_direct_transport *t)
 {
 	if (!list_empty(&t->reassembly_queue))
 		return list_first_entry(&t->reassembly_queue,
-				struct smb_direct_recvmsg, list);
+				struct smbdirect_recv_io, list);
 	else
 		return NULL;
 }
@@ -380,7 +371,7 @@ static void smb_direct_free_transport(struct ksmbd_transport *kt)
 static void free_transport(struct smb_direct_transport *t)
 {
 	struct smbdirect_socket *sc = &t->socket;
-	struct smb_direct_recvmsg *recvmsg;
+	struct smbdirect_recv_io *recvmsg;
 
 	wake_up_interruptible(&t->wait_send_credits);
 
@@ -458,9 +449,9 @@ static void smb_direct_free_sendmsg(struct smb_direct_transport *t,
 	mempool_free(msg, t->sendmsg_mempool);
 }
 
-static int smb_direct_check_recvmsg(struct smb_direct_recvmsg *recvmsg)
+static int smb_direct_check_recvmsg(struct smbdirect_recv_io *recvmsg)
 {
-	struct smbdirect_socket *sc = &recvmsg->transport->socket;
+	struct smbdirect_socket *sc = recvmsg->socket;
 
 	switch (sc->recv_io.expected) {
 	case SMBDIRECT_EXPECT_DATA_TRANSFER: {
@@ -509,13 +500,13 @@ static int smb_direct_check_recvmsg(struct smb_direct_recvmsg *recvmsg)
 
 static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 {
-	struct smb_direct_recvmsg *recvmsg;
+	struct smbdirect_recv_io *recvmsg;
 	struct smb_direct_transport *t;
 	struct smbdirect_socket *sc;
 
-	recvmsg = container_of(wc->wr_cqe, struct smb_direct_recvmsg, cqe);
-	t = recvmsg->transport;
-	sc = &t->socket;
+	recvmsg = container_of(wc->wr_cqe, struct smbdirect_recv_io, cqe);
+	sc = recvmsg->socket;
+	t = container_of(sc, struct smb_direct_transport, socket);
 
 	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_RECV) {
 		put_recvmsg(t, recvmsg);
@@ -627,7 +618,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 }
 
 static int smb_direct_post_recv(struct smb_direct_transport *t,
-				struct smb_direct_recvmsg *recvmsg)
+				struct smbdirect_recv_io *recvmsg)
 {
 	struct smbdirect_socket *sc = &t->socket;
 	struct smbdirect_socket_parameters *sp = &sc->parameters;
@@ -666,7 +657,7 @@ static int smb_direct_post_recv(struct smb_direct_transport *t,
 static int smb_direct_read(struct ksmbd_transport *t, char *buf,
 			   unsigned int size, int unused)
 {
-	struct smb_direct_recvmsg *recvmsg;
+	struct smbdirect_recv_io *recvmsg;
 	struct smbdirect_data_transfer *data_transfer;
 	int to_copy, to_read, data_read, offset;
 	u32 data_length, remaining_data_length, data_offset;
@@ -703,7 +694,7 @@ static int smb_direct_read(struct ksmbd_transport *t, char *buf,
 		offset = st->first_entry_offset;
 		while (data_read < size) {
 			recvmsg = get_first_reassembly(st);
-			data_transfer = smb_direct_recvmsg_payload(recvmsg);
+			data_transfer = smbdirect_recv_io_payload(recvmsg);
 			data_length = le32_to_cpu(data_transfer->data_length);
 			remaining_data_length =
 				le32_to_cpu(data_transfer->remaining_data_length);
@@ -796,7 +787,7 @@ static void smb_direct_post_recv_credits(struct work_struct *work)
 {
 	struct smb_direct_transport *t = container_of(work,
 		struct smb_direct_transport, post_recv_credits_work.work);
-	struct smb_direct_recvmsg *recvmsg;
+	struct smbdirect_recv_io *recvmsg;
 	int receive_credits, credits = 0;
 	int ret;
 
@@ -1677,7 +1668,7 @@ static int smb_direct_prepare_negotiation(struct smb_direct_transport *t)
 {
 	struct smbdirect_socket *sc = &t->socket;
 	int ret;
-	struct smb_direct_recvmsg *recvmsg;
+	struct smbdirect_recv_io *recvmsg;
 
 	sc->recv_io.expected = SMBDIRECT_EXPECT_NEGOTIATE_REQ;
 
@@ -1806,7 +1797,7 @@ static int smb_direct_init_params(struct smb_direct_transport *t,
 
 static void smb_direct_destroy_pools(struct smb_direct_transport *t)
 {
-	struct smb_direct_recvmsg *recvmsg;
+	struct smbdirect_recv_io *recvmsg;
 
 	while ((recvmsg = get_free_recvmsg(t)))
 		mempool_free(recvmsg, t->recvmsg_mempool);
@@ -1830,7 +1821,7 @@ static int smb_direct_create_pools(struct smb_direct_transport *t)
 	struct smbdirect_socket_parameters *sp = &sc->parameters;
 	char name[80];
 	int i;
-	struct smb_direct_recvmsg *recvmsg;
+	struct smbdirect_recv_io *recvmsg;
 
 	snprintf(name, sizeof(name), "smb_direct_rqst_pool_%p", t);
 	t->sendmsg_cache = kmem_cache_create(name,
@@ -1846,9 +1837,9 @@ static int smb_direct_create_pools(struct smb_direct_transport *t)
 	if (!t->sendmsg_mempool)
 		goto err;
 
-	snprintf(name, sizeof(name), "smb_direct_resp_%p", t);
+	snprintf(name, sizeof(name), "smbdirect_recv_io_pool_%p", t);
 	t->recvmsg_cache = kmem_cache_create(name,
-					     sizeof(struct smb_direct_recvmsg) +
+					     sizeof(struct smbdirect_recv_io) +
 					     sp->max_recv_size,
 					     0, SLAB_HWCACHE_ALIGN, NULL);
 	if (!t->recvmsg_cache)
@@ -1866,7 +1857,7 @@ static int smb_direct_create_pools(struct smb_direct_transport *t)
 		recvmsg = mempool_alloc(t->recvmsg_mempool, KSMBD_DEFAULT_GFP);
 		if (!recvmsg)
 			goto err;
-		recvmsg->transport = t;
+		recvmsg->socket = sc;
 		recvmsg->sge.length = 0;
 		list_add(&recvmsg->list, &t->recvmsg_queue);
 	}
@@ -1971,7 +1962,7 @@ static int smb_direct_prepare(struct ksmbd_transport *t)
 	struct smb_direct_transport *st = smb_trans_direct_transfort(t);
 	struct smbdirect_socket *sc = &st->socket;
 	struct smbdirect_socket_parameters *sp = &sc->parameters;
-	struct smb_direct_recvmsg *recvmsg;
+	struct smbdirect_recv_io *recvmsg;
 	struct smbdirect_negotiate_req *req;
 	int ret;
 
-- 
2.43.0


