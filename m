Return-Path: <linux-cifs+bounces-5460-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id E63BAB1A0E5
	for <lists+linux-cifs@lfdr.de>; Mon,  4 Aug 2025 14:11:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D78EE4E12FE
	for <lists+linux-cifs@lfdr.de>; Mon,  4 Aug 2025 12:11:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1AD6248F7D;
	Mon,  4 Aug 2025 12:11:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="F1tk5pWE"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FA914EC62
	for <linux-cifs@vger.kernel.org>; Mon,  4 Aug 2025 12:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754309494; cv=none; b=ocDlstoBvfghtiAneB6S3aptxZXZivMOx9QuHaW/BmXAUyeTKfqiqVrxZYTAMvFLrOfTl4T+PcnJJjXVuhepWN62s9xnTOmKGJzdV82HwUqoYB8GO3zxMPp7sTS5Qc9F2PyO55u3TlU7jJmbENHwcYGFIqFL+Lfiv8LLXgQwoXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754309494; c=relaxed/simple;
	bh=CJP/gpo5yne5xLpYkkPi12e97JVWBjjXYShO4RRoCeQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EZJnUNNURP58rCXEnrnXo+RmbEhTpqTPwHNqg/vO9zyo7kebeVQ1jHNVhqfNLYC3vWoJODG/Q7JANkE5xCZPpSp6iOm+4CdBAluF1snD8hIaMlRpj+GTqA2JneZ3vpHrkALbIzPXNIQJzlBlTc9r8+28g+P/Z2CXEVmE4hGfmAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=F1tk5pWE; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=to7ZLsOwz04pZ3TzBcfuBH6LG/57UBcjbzWF3eZFcFg=; b=F1tk5pWEWxuoCvJ+tNUMm7htWX
	Mloe3ECE7svfVkqKitfl5rBkGwBGP5L+feLCYuy8bhDr7gXzYrOqkJVfyOHdldnFIhAE9C/dPGox3
	1UTSMhNR/QWvsicAxZwoBZ5FhceyhRQKSiZ+Gim+Jy61r4HE/sDLCFi5a34n8oEs2+/j+mfkrUk51
	0/pHs5cH8mO9dX3Q0jWxPu5S6o+TzyvVm1WNcom6lBt7Q/00QABmYBVgKkmVqThwCuWVZ9QkwATcc
	os7ke9CfVbZsHanx2gGGL96ijb8RCVWB5ZJLyY/Y1mVzRmzvlaFrH9WmKKXP7gy0lYYnWp9H+a/Md
	2j0uxGfe9YfGEPHq2q3s5g34nwNkw62dgxlhzSt+mQA5giNgPPDULUVMg6mCLa72H9NkSotMIQAIb
	KQx3gB7ZpLHvFL6R3YW52O/wXdqscRpMxDF2/iah8WL3R2Ip5TFEwa3H+SmXPYsce8o/STRXW0KYR
	C8ynqkM3QRYA9lvPUQ/hmrM3;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uiu2M-000vts-13;
	Mon, 04 Aug 2025 12:11:30 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH 1/5] smb: client: let send_done() cleanup before calling smbd_disconnect_rdma_connection()
Date: Mon,  4 Aug 2025 14:10:12 +0200
Message-ID: <0b80cf1a140280ca75ac21d5577a141e433d35f7.1754308712.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1754308712.git.metze@samba.org>
References: <cover.1754308712.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We should call ib_dma_unmap_single() and mempool_free() before calling
smbd_disconnect_rdma_connection().

And smbd_disconnect_rdma_connection() needs to be the last function to
call as all other state might already be gone after it returns.

Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Fixes: f198186aa9bb ("CIFS: SMBD: Establish SMB Direct connection")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 fs/smb/client/smbdirect.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 754e94a0e07f..b6c369088479 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -281,18 +281,20 @@ static void send_done(struct ib_cq *cq, struct ib_wc *wc)
 	log_rdma_send(INFO, "smbd_request 0x%p completed wc->status=%d\n",
 		request, wc->status);
 
-	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_SEND) {
-		log_rdma_send(ERR, "wc->status=%d wc->opcode=%d\n",
-			wc->status, wc->opcode);
-		smbd_disconnect_rdma_connection(request->info);
-	}
-
 	for (i = 0; i < request->num_sge; i++)
 		ib_dma_unmap_single(sc->ib.dev,
 			request->sge[i].addr,
 			request->sge[i].length,
 			DMA_TO_DEVICE);
 
+	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_SEND) {
+		log_rdma_send(ERR, "wc->status=%d wc->opcode=%d\n",
+			wc->status, wc->opcode);
+		mempool_free(request, request->info->request_mempool);
+		smbd_disconnect_rdma_connection(request->info);
+		return;
+	}
+
 	if (atomic_dec_and_test(&request->info->send_pending))
 		wake_up(&request->info->wait_send_pending);
 
-- 
2.43.0


