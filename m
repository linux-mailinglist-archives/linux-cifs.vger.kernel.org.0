Return-Path: <linux-cifs+bounces-9028-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YK23Ov03cWnKfQAAu9opvQ
	(envelope-from <linux-cifs+bounces-9028-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Jan 2026 21:33:01 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 696CD5D4CA
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Jan 2026 21:33:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id DBC78A6B158
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Jan 2026 19:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AC8E635C19D;
	Wed, 21 Jan 2026 19:51:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="peGqLUHo"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 751443A7DF1
	for <linux-cifs@vger.kernel.org>; Wed, 21 Jan 2026 19:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025117; cv=none; b=m/UY/b+aOq1AUp3YDLi3SKCkd5Ao4SIVwG2iHJueq1d+3Kl4/eG539oMDdXDef6Kyrhyb7EWfJYzc345U8OxRlXPGQ+ViDHsNqqBWrQAifc39aHEFKQE50r3Bej/2P0V/dUCQi6LlRxEtwT8GRGHqaWwzIoA6p4knPugfjjqQdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025117; c=relaxed/simple;
	bh=QB6Cw02sISBLJZ+6JZ/rg9+dz3pyaCVnHx4bYtSknFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KAUfDblhOiT0RZDsDrJFmD6QdwihW3tfxvV1vhpY2YzHOSdZ3peYogFN6uD5bMI1yXAMF4rPQiUAqQQY+7rKRZq/sjKVeUq2FJ298hfrfm2k7bm6lRnA9LbChiE5WWSwCVCeekSXbhs2Mwf/Ji2yIkacdzYfFfBsnFfe8SJsWg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=peGqLUHo; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=FcyW328vx0gI+/8Sm2YtoN0tlaraS5QICHh2MQGBg9o=; b=peGqLUHord40KEI2XTqjKLwD2j
	qJLVVuL2jxsG6D0nOg65zW8rdiH3r89uZKBICaKX6Kf1LsAjmcuWAuDRGjgfAAdo4+BONSFNSxAhB
	3Q683AsH+7N46F2mo4Lihl8cNjVN7IaqjnbuMhnLRXzQIk2xgs0j0pgUpVxD4Cowdeai9gO/ux5Gm
	Q2Bw6zoRaLMLV7Lqb83Hbpojumm7utfFM5yjREOeqCHwKhxOVcF5VJCwnH4lRy1LJM+eJjgNRfRuj
	7nQ0BfcZWI2P/pvOF0rjuVkcgHiZOM8iAoP56iA4PIhAmYrj5CfFI+eTae4JQ118sd0L3Gnnbnh5c
	Y6lWUjOSh0CIoW3Qh/1Uh5PUGrhskerrmQ+Oc6LYtOyETINxsAeFyIUtGiQthjG+1eUKsGcylBdlG
	JksVaO8I7VKayfR36wJRvJwr8tC6iRIYZK99ZHVk9x80yC4AwHYBrJaowc9CDlMQVklK5WvSpfl3m
	WtFKHVPuADq80mcAWlaQFEEC;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vieF6-00000001e60-2ZgM;
	Wed, 21 Jan 2026 19:51:52 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 11/19] smb: client: remove pointless sc->recv_io.credits.count rollback
Date: Wed, 21 Jan 2026 20:50:21 +0100
Message-ID: <80c61e4e188e6a3194c9841b56395f10bf8a2e5d.1769024269.git.metze@samba.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1769024269.git.metze@samba.org>
References: <cover.1769024269.git.metze@samba.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [8.84 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[samba.org,gmail.com,talpey.com,microsoft.com,kernel.org];
	TAGGED_FROM(0.00)[bounces-9028-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	R_DKIM_ALLOW(0.00)[samba.org:s=42];
	RCVD_COUNT_THREE(0.00)[4];
	GREYLIST(0.00)[pass,meta];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[samba.org,quarantine];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-cifs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[samba.org:+];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,talpey.com:email,samba.org:email,samba.org:dkim,samba.org:mid]
X-Rspamd-Queue-Id: 696CD5D4CA
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

We either reach this code path before we call
new_credits = manage_credits_prior_sending(sc),
which means new_credits is still 0
or the connection is already broken as
smbd_post_send() already called
smbd_disconnect_rdma_connection().

This will also simplify further changes.

Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
---
 fs/smb/client/smbdirect.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index dc1e6656051a..4677e82631a9 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1289,9 +1289,6 @@ static int smbd_post_send_iter(struct smbdirect_socket *sc,
 					    DMA_TO_DEVICE);
 	mempool_free(request, sc->send_io.mem.pool);
 
-	/* roll back the granted receive credits */
-	atomic_sub(new_credits, &sc->recv_io.credits.count);
-
 err_alloc:
 	atomic_inc(&sc->send_io.credits.count);
 	wake_up(&sc->send_io.credits.wait_queue);
-- 
2.43.0


