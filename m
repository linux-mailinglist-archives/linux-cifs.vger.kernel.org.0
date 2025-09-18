Return-Path: <linux-cifs+bounces-5684-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DEC47B22E51
	for <lists+linux-cifs@lfdr.de>; Tue, 12 Aug 2025 18:53:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3D74C3ABBB2
	for <lists+linux-cifs@lfdr.de>; Tue, 12 Aug 2025 16:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4BCAF279789;
	Tue, 12 Aug 2025 16:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="Zw6AIbuC"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB2292FD1B0
	for <linux-cifs@vger.kernel.org>; Tue, 12 Aug 2025 16:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755017138; cv=none; b=gcuBoY9dZh5RAMLi2VnG8lBmDyVcQtXSIXkJlnuFArnUxSZmFRouN7Jm5eKr5eixE8uoW/Im2Z3DZAD5Rj//PmrSHhakuiqh3XwXDRhSA2mGf9q4L0TD47jgIewbIKuyBYBHx1Pl8cbFbq7VYh23I+E7Dkc4yFjTzj9YJtgHMl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755017138; c=relaxed/simple;
	bh=ZkzUjh9pXFeSppuL4YmBQYJGVEy/Xl6I2GlsH9t/Sbc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kYIF97R0EmXTAvbwUhHsMbl+jy8SyFowcUu7CX/VIa19DedfssUmtq+6JiBZaBZxO26JZwsNdQYAQm3JFurJv2aYEFeikGfiImRNJ/dMQXrMQaVE8ccflG+AEEKR3/kp7E2kF25LbjPLtLOdhn8FWOLECVqkDKg8KJ81/bF6rDw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=Zw6AIbuC; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=p7Hg42irhIchcCUCKuFHg2sA0bBPKfC/YqnwJzAjRKE=; b=Zw6AIbuCdYcskyU5Y9KpS9Ef0l
	UGZicHgwKyZERj0EX25whj7oDZNB5RiP86I+hXuz6XXKtWVmSLcemV/nGzdE7LNIa5YAJytv2/Tig
	yANLs0ylOuiZHodJAje/mDvNb3oqWD6HV94xeQvjekSj27D9oF8XOf0sSqXZ29O5zLXez+jHWdlq/
	z/vhcUOuWZ3vHjWxbWYC4m5zzJAspH/caudwJPCNrSxkjeoJTtGQ/6mm3dRpB7CSdnIdn5p2ge7n7
	xW093bPxnMogkorwIWvieiJ3/PR3gaOBn1goBNW/k62vq60U5vAyAAohJbhqBjGh+pRhQtK/FtL3R
	JJn1MTUrtcorBPomOpfCYXVJ03PZLHY9vIn/WUGJOEBUjG7a32PsYM/cLJpQUwNxQHfzJzzR/PH6K
	+rJXyrCQAIa1oVwm8XK5LEfG5/EPMXuVJAfU1/kNaINsVBRrlxFgXj7aIHINKQ0L8twc5NARxkAzv
	LQnMpawNf4HeYZ0hfKKqQdxk;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1uls7r-002SeY-0f;
	Tue, 12 Aug 2025 16:45:27 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>
Subject: [PATCH] smb: client: don't wait for info->send_pending == 0 on error
Date: Tue, 12 Aug 2025 18:45:06 +0200
Message-ID: <20250812164506.29170-1-metze@samba.org>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We already called ib_drain_qp() before and that makes sure
send_done() was called with IB_WC_WR_FLUSH_ERR, but
didn't called atomic_dec_and_test(&sc->send_io.pending.count)

So we may never reach the info->send_pending == 0 condition.

Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Fixes: 5349ae5e05fa ("smb: client: let send_done() cleanup before calling smbd_disconnect_rdma_connection()")
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 fs/smb/client/smbdirect.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index fe7e138704fc..5f32a967f553 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1402,10 +1402,6 @@ void smbd_destroy(struct TCP_Server_Info *server)
 	log_rdma_event(INFO, "cancelling idle timer\n");
 	cancel_delayed_work_sync(&info->idle_timer_work);
 
-	log_rdma_event(INFO, "wait for all send posted to IB to finish\n");
-	wait_event(info->wait_send_pending,
-		atomic_read(&info->send_pending) == 0);
-
 	/* It's not possible for upper layer to get to reassembly */
 	log_rdma_event(INFO, "drain the reassembly queue\n");
 	do {
@@ -2055,7 +2051,11 @@ int smbd_send(struct TCP_Server_Info *server,
 	 */
 
 	wait_event(info->wait_send_pending,
-		atomic_read(&info->send_pending) == 0);
+		atomic_read(&info->send_pending) == 0 ||
+		sc->status != SMBDIRECT_SOCKET_CONNECTED);
+
+	if (sc->status != SMBDIRECT_SOCKET_CONNECTED && rc == 0)
+		rc = -EAGAIN;
 
 	return rc;
 }
-- 
2.43.0


