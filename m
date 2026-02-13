Return-Path: <linux-cifs+bounces-9343-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gH0ULzosj2kPKwEAu9opvQ
	(envelope-from <linux-cifs+bounces-9343-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Fri, 13 Feb 2026 14:50:50 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 6542E136863
	for <lists+linux-cifs@lfdr.de>; Fri, 13 Feb 2026 14:50:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C3737305CAA5
	for <lists+linux-cifs@lfdr.de>; Fri, 13 Feb 2026 13:50:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5256634CFC3;
	Fri, 13 Feb 2026 13:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="oq1Omgd0"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E8CD223323;
	Fri, 13 Feb 2026 13:50:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770990609; cv=none; b=CCXMruRKY8lezsm7XRyoc7xjEo7HOtnbrwts7Rv1DOOfjFsj5P5KpyAXehTLCZeavFsL9/Hoig0h+KwqGMQ1NZd2f3qF8C3finvkhoPPshga7Ib2yoCPpG664k0X68aU+zoEDkLllJ5Y+XmEzDBQy3AnN44BYKp6yqF9HR06gyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770990609; c=relaxed/simple;
	bh=zrpzGQeAEmafNpSdLLwHHu/MJpn9UBTMWv8teTr0wz4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=d94QcDlAumAOb2BwQkDxkXmB8woCEoUAD0qmxqtCO0VO8crY7GZmvBkv+4l0083paOKwmLyupCg2ym7k06EJLcbcokX+3kwwgpukk3SxeKZTqmrjC3R6vfbJCMjTm8kF+P4+wIQrziwkzyIYWpaCV/F3XLzqPbA80jWDvyKtxXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=oq1Omgd0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5937DC116C6;
	Fri, 13 Feb 2026 13:50:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1770990608;
	bh=zrpzGQeAEmafNpSdLLwHHu/MJpn9UBTMWv8teTr0wz4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=oq1Omgd0H1cL/41K4xbmKPz4+Vq7rx5xjzFAwJ7PECZ+0vb2BjoNQWjlfrS6vwbFO
	 kovGYXwcYK0e8FGOEOJsULGJQjo41Xy1w3vjOAOtDTLMcG+sW+cji01HttXGmXE/HZ
	 vjdkLXIZ5C1lBL0Q1hA3sKK7oNNuTYtKPFjBbuOw=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org,
	Stefan Metzmacher <metze@samba.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 6.19 20/49] smb: client: split out smbd_ib_post_send()
Date: Fri, 13 Feb 2026 14:47:39 +0100
Message-ID: <20260213134709.471649789@linuxfoundation.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260213134708.713126210@linuxfoundation.org>
References: <20260213134708.713126210@linuxfoundation.org>
User-Agent: quilt/0.69
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linuxfoundation.org,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[linuxfoundation.org:s=korg];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9343-lists,linux-cifs=lfdr.de];
	PRECEDENCE_BULK(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[linuxfoundation.org,lists.linux.dev,gmail.com,talpey.com,microsoft.com,kernel.org,vger.kernel.org,lists.samba.org,samba.org];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gregkh@linuxfoundation.org,linux-cifs@vger.kernel.org];
	RCPT_COUNT_SEVEN(0.00)[11];
	MID_RHS_MATCH_FROM(0.00)[];
	DKIM_TRACE(0.00)[linuxfoundation.org:+];
	TAGGED_RCPT(0.00)[linux-cifs];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:email,talpey.com:email,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,linuxfoundation.org:mid,linuxfoundation.org:dkim,linuxfoundation.org:email]
X-Rspamd-Queue-Id: 6542E136863
X-Rspamd-Action: no action

6.19-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Stefan Metzmacher <metze@samba.org>

commit bf30515caec590316e0d08208e4252eed4c160df upstream.

This is like smb_direct_post_send() in the server
and will simplify porting the smbdirect_send_batch
and credit related logic from the server.

Cc: <stable@vger.kernel.org> # 6.18.x
Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 fs/smb/client/smbdirect.c |   33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1101,11 +1101,26 @@ static int manage_keep_alive_before_send
 	return 0;
 }
 
+static int smbd_ib_post_send(struct smbdirect_socket *sc,
+			     struct ib_send_wr *wr)
+{
+	int ret;
+
+	atomic_inc(&sc->send_io.pending.count);
+	ret = ib_post_send(sc->ib.qp, wr, NULL);
+	if (ret) {
+		pr_err("failed to post send: %d\n", ret);
+		smbd_disconnect_rdma_connection(sc);
+		ret = -EAGAIN;
+	}
+	return ret;
+}
+
 /* Post the send request */
 static int smbd_post_send(struct smbdirect_socket *sc,
 		struct smbdirect_send_io *request)
 {
-	int rc, i;
+	int i;
 
 	for (i = 0; i < request->num_sge; i++) {
 		log_rdma_send(INFO,
@@ -1126,15 +1141,7 @@ static int smbd_post_send(struct smbdire
 	request->wr.num_sge = request->num_sge;
 	request->wr.opcode = IB_WR_SEND;
 	request->wr.send_flags = IB_SEND_SIGNALED;
-
-	rc = ib_post_send(sc->ib.qp, &request->wr, NULL);
-	if (rc) {
-		log_rdma_send(ERR, "ib_post_send failed rc=%d\n", rc);
-		smbd_disconnect_rdma_connection(sc);
-		rc = -EAGAIN;
-	}
-
-	return rc;
+	return smbd_ib_post_send(sc, &request->wr);
 }
 
 static int wait_for_credits(struct smbdirect_socket *sc,
@@ -1280,12 +1287,6 @@ static int smbd_post_send_iter(struct sm
 		     le32_to_cpu(packet->data_length),
 		     le32_to_cpu(packet->remaining_data_length));
 
-	/*
-	 * Now that we got a local and a remote credit
-	 * we add us as pending
-	 */
-	atomic_inc(&sc->send_io.pending.count);
-
 	rc = smbd_post_send(sc, request);
 	if (!rc)
 		return 0;



