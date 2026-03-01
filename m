Return-Path: <linux-cifs+bounces-9766-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YDQvGa+qo2nfJQUAu9opvQ
	(envelope-from <linux-cifs+bounces-9766-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Sun, 01 Mar 2026 03:55:43 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CDD1F1CE116
	for <lists+linux-cifs@lfdr.de>; Sun, 01 Mar 2026 03:55:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D77BA3090ECA
	for <lists+linux-cifs@lfdr.de>; Sun,  1 Mar 2026 01:46:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41A71A3165;
	Sun,  1 Mar 2026 01:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BeA+Lvi+"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91B261DF271;
	Sun,  1 Mar 2026 01:46:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772329592; cv=none; b=kmjJtIjzYRalOqEwinmyvKFkkPlLf9ecJpqlimdt+AYWPcbeDFyACRsAM4z2jQip1MQncgKVIKAk4iwz6a6HvcjbfsMTqAt4JNJQsObfLfFfgyPE9h3ip3rfoCPhSlXqdqcXVkfkI6qUDE9fsPvX0auAyCUlP+woUP+iFV1kqn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772329592; c=relaxed/simple;
	bh=29njihTX7Hp1LuY9VaK6skv569j4qG2NKkkXpuEgJNE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IPQq6nydJF6NDtpd5Er9f81JI+fhKT5yma1ewi5mq7sdHD0P5sgaBtjm39dCEGTwAatrFvIu1BSfhVIzNONRRuP9iy+P5t2a4oOHG7AAZn3iFvcniw/y8uryEtWLI7Vf8rYgljQSj7pszJUje0jvWImBoahygEB1rKOR9UrhdEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BeA+Lvi+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F7A7C19421;
	Sun,  1 Mar 2026 01:46:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772329592;
	bh=29njihTX7Hp1LuY9VaK6skv569j4qG2NKkkXpuEgJNE=;
	h=From:To:Cc:Subject:Date:From;
	b=BeA+Lvi+X7ws1Rfd9ex0Yllw4rsrlVm6oezcn0ma5crE0XX1c8wkJOfCqSeEWMWZ/
	 TYFGuAsRwhxz+cmSEdAS7BHVQLD9qOrRCe0VoNz0Qt2iKXEhjWMW2nDd5lyqYvhGWg
	 RaxwpgpKtajvckDrY8HW9KEi2fTAfIJwkbywMP0WafM6IL4Yq2KiW+kAXKS1g0SMKq
	 1YDkpkhxD46E1qfwK/6m00wWh9dwJfJ0EayDcnecMP/JIRLF51y9p53bK9A1iYZuxo
	 nsk57VdZT84I2+QGQ0IFBkTpm0pr7T0JUx3eH2dhrm4HbrBX3s2PKfZND94G/AL+h3
	 YPGh+er7iP7FQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org,
	metze@samba.org
Cc: Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Steve French <stfrench@microsoft.com>
Subject: FAILED: Patch "smb: client: let smbd_post_send_negotiate_req() use smbd_post_send()" failed to apply to 6.1-stable tree
Date: Sat, 28 Feb 2026 20:46:30 -0500
Message-ID: <20260301014630.1709488-1-sashal@kernel.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Patchwork-Hint: ignore
X-stable: review
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,talpey.com,microsoft.com,kernel.org,vger.kernel.org,lists.samba.org];
	TAGGED_FROM(0.00)[bounces-9766-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	TAGGED_RCPT(0.00)[linux-cifs];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[sashal@kernel.org,linux-cifs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	R_SPF_ALLOW(0.00)[+ip4:172.234.253.10:c];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	NEURAL_SPAM(0.00)[0.897];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_HAS_DN(0.00)[]
X-Rspamd-Queue-Id: CDD1F1CE116
X-Rspamd-Action: add header
X-Spam: Yes

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 5b1c6149657af840a02885135c700ab42e6aa322 Mon Sep 17 00:00:00 2001
From: Stefan Metzmacher <metze@samba.org>
Date: Thu, 22 Jan 2026 18:16:59 +0100
Subject: [PATCH] smb: client: let smbd_post_send_negotiate_req() use
 smbd_post_send()

The server has similar logic and it makes sure that
request->wr is used instead of a stack struct ib_send_wr send_wr.

This makes sure send_done can see request->wr.send_flags
as the next commit will check for IB_SEND_SIGNALED

Cc: <stable@vger.kernel.org> # 6.18.x
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/client/smbdirect.c | 32 +++++++-------------------------
 1 file changed, 7 insertions(+), 25 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 20faa6d7f514d..88fefb901c27f 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -35,6 +35,10 @@ static void enqueue_reassembly(
 static struct smbdirect_recv_io *_get_first_reassembly(
 		struct smbdirect_socket *sc);
 
+static int smbd_post_send(struct smbdirect_socket *sc,
+			  struct smbdirect_send_batch *batch,
+			  struct smbdirect_send_io *request);
+
 static int smbd_post_recv(
 		struct smbdirect_socket *sc,
 		struct smbdirect_recv_io *response);
@@ -1021,7 +1025,6 @@ static int smbd_ia_open(
 static int smbd_post_send_negotiate_req(struct smbdirect_socket *sc)
 {
 	struct smbdirect_socket_parameters *sp = &sc->parameters;
-	struct ib_send_wr send_wr;
 	int rc;
 	struct smbdirect_send_io *request;
 	struct smbdirect_negotiate_req *packet;
@@ -1052,33 +1055,12 @@ static int smbd_post_send_negotiate_req(struct smbdirect_socket *sc)
 	request->sge[0].length = sizeof(*packet);
 	request->sge[0].lkey = sc->ib.pd->local_dma_lkey;
 
-	ib_dma_sync_single_for_device(
-		sc->ib.dev, request->sge[0].addr,
-		request->sge[0].length, DMA_TO_DEVICE);
-
-	request->cqe.done = send_done;
-
-	send_wr.next = NULL;
-	send_wr.wr_cqe = &request->cqe;
-	send_wr.sg_list = request->sge;
-	send_wr.num_sge = request->num_sge;
-	send_wr.opcode = IB_WR_SEND;
-	send_wr.send_flags = IB_SEND_SIGNALED;
-
-	log_rdma_send(INFO, "sge addr=0x%llx length=%u lkey=0x%x\n",
-		request->sge[0].addr,
-		request->sge[0].length, request->sge[0].lkey);
-
-	atomic_inc(&sc->send_io.pending.count);
-	rc = ib_post_send(sc->ib.qp, &send_wr, NULL);
+	rc = smbd_post_send(sc, NULL, request);
 	if (!rc)
 		return 0;
 
-	/* if we reach here, post send failed */
-	log_rdma_send(ERR, "ib_post_send failed rc=%d\n", rc);
-	atomic_dec(&sc->send_io.pending.count);
-
-	smbd_disconnect_rdma_connection(sc);
+	if (rc == -EAGAIN)
+		rc = -EIO;
 
 dma_mapping_failed:
 	smbd_free_send_io(request);
-- 
2.51.0





