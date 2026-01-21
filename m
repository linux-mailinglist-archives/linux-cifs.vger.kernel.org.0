Return-Path: <linux-cifs+bounces-9027-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wEe0L7JBcWn2fgAAu9opvQ
	(envelope-from <linux-cifs+bounces-9027-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Jan 2026 22:14:26 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 688755DE28
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Jan 2026 22:14:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 231D680498E
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Jan 2026 19:51:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E407D33D4E5;
	Wed, 21 Jan 2026 19:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="Ki7iVQif"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37E4E331219
	for <linux-cifs@vger.kernel.org>; Wed, 21 Jan 2026 19:51:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769025113; cv=none; b=eoTccy40IAr6SQkKwtUupAQmd2kZBgag+cxYoB4YqVImvX361bhlGrREFVSQuQCwyrWMfp3NZOjRYa9Sx961gQXFEldt83y3iwbrT2jg2eivisrSeEEkiYJ148D2oLK1tkH+II+V9EAMhPKP/IAJ4QMtVW2mow0Wwn+8kbB9kiw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769025113; c=relaxed/simple;
	bh=zvfBSqzWdMJxQB/NtmzTyuilF3mISA5qKXGjBfYO6kA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=inERuHu1yC3OPPayM9ja93ZjT/boGq3IKnxIGA9rF0nOJP8zm79s9ZIvJvToR3lO+0ko1HDG5l7ESuH4jeF5Kc9hSCsCYAJGYVIjBoXCwGehubHABoq0hWrE6pIqxangA3xNAV56wCVKPmWqIkEtzorJwSgTrLm2KTfalwhNBLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=Ki7iVQif; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Message-ID:Date:Cc:To:From;
	bh=Xge18jOfHry7lIFiZsNCjADIj2Kb1EH5QrsdXKSoAss=; b=Ki7iVQifVgHwAD9ZV6VFioE8da
	8uGi1cTOaX8nCgid0TDdrDrc4XfQrqrNUrdaapC2p4sAj9XOCO3PPnfmmsk8zngleP0lUPgrde2N5
	kxcdPMB74DXYWproyd8zlPjvQI+fy5Pd4+ZlKaCBZIOC3HAnERkX6gXt2IPHeZMqOJQ3DwRJ+7FDY
	5wtM/I9F/sFkwCqixjdq13ebm5NPjAF+d5lfqh1k2dafxzCfd418cdl+2EbwLn+N9RRxsmq59yOuC
	X0dox/VpN4/CPTFW+/pNtOjxBESJB5GcNvUUpIWuWfBGIyhaTrYHt9+HKAF2DdeXbfV0xS7NWZfNL
	f0SgeGbNxdrfh0IRs19mJlvBvAS7JwDixiQD9MyrwExIXItVydJkCMxkTDGpWbZpW1EE37q/TeJ2C
	DDAwHQYANeYbTtblsOuzWkcSgdn0RvoNT35dLIHDD10ZHU+DAXKPEhAS0eIw89DAIy+cnKI7QNVlz
	HcKafJxb9P7r97NdOkjoQ+N5;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vieEz-00000001e4g-3wjM;
	Wed, 21 Jan 2026 19:51:46 +0000
From: Stefan Metzmacher <metze@samba.org>
To: linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Cc: metze@samba.org,
	Steve French <smfrench@gmail.com>,
	Tom Talpey <tom@talpey.com>,
	Long Li <longli@microsoft.com>,
	Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <stfrench@microsoft.com>
Subject: [PATCH 10/19] smb: client: let smbd_post_send() make use of request->wr
Date: Wed, 21 Jan 2026 20:50:20 +0100
Message-ID: <89ba36dd68324c70f72c9df433a3d04ead254cdf.1769024269.git.metze@samba.org>
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
	TAGGED_FROM(0.00)[bounces-9027-lists,linux-cifs=lfdr.de];
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
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,talpey.com:email,samba.org:email,samba.org:dkim,samba.org:mid,send_wr.next:url]
X-Rspamd-Queue-Id: 688755DE28
X-Rspamd-Action: add header
X-Rspamd-Server: lfdr
X-Spam: Yes

We don't need a stack variable in addition.

Cc: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>
Cc: Long Li <longli@microsoft.com>
Cc: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Signed-off-by: Stefan Metzmacher <metze@samba.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/smb/client/smbdirect.c | 15 +++++++--------
 1 file changed, 7 insertions(+), 8 deletions(-)

diff --git a/fs/smb/client/smbdirect.c b/fs/smb/client/smbdirect.c
index 826fe7cc6ab6..dc1e6656051a 100644
--- a/fs/smb/client/smbdirect.c
+++ b/fs/smb/client/smbdirect.c
@@ -1105,7 +1105,6 @@ static int manage_keep_alive_before_sending(struct smbdirect_socket *sc)
 static int smbd_post_send(struct smbdirect_socket *sc,
 		struct smbdirect_send_io *request)
 {
-	struct ib_send_wr send_wr;
 	int rc, i;
 
 	for (i = 0; i < request->num_sge; i++) {
@@ -1121,14 +1120,14 @@ static int smbd_post_send(struct smbdirect_socket *sc,
 
 	request->cqe.done = send_done;
 
-	send_wr.next = NULL;
-	send_wr.wr_cqe = &request->cqe;
-	send_wr.sg_list = request->sge;
-	send_wr.num_sge = request->num_sge;
-	send_wr.opcode = IB_WR_SEND;
-	send_wr.send_flags = IB_SEND_SIGNALED;
+	request->wr.next = NULL;
+	request->wr.wr_cqe = &request->cqe;
+	request->wr.sg_list = request->sge;
+	request->wr.num_sge = request->num_sge;
+	request->wr.opcode = IB_WR_SEND;
+	request->wr.send_flags = IB_SEND_SIGNALED;
 
-	rc = ib_post_send(sc->ib.qp, &send_wr, NULL);
+	rc = ib_post_send(sc->ib.qp, &request->wr, NULL);
 	if (rc) {
 		log_rdma_send(ERR, "ib_post_send failed rc=%d\n", rc);
 		smbd_disconnect_rdma_connection(sc);
-- 
2.43.0


