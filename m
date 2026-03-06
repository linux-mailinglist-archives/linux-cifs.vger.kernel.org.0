Return-Path: <linux-cifs+bounces-10109-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cEhOA+x1qmnRRwEAu9opvQ
	(envelope-from <linux-cifs+bounces-10109-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Fri, 06 Mar 2026 07:36:28 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BCC121C1FA
	for <lists+linux-cifs@lfdr.de>; Fri, 06 Mar 2026 07:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 6271730498F7
	for <lists+linux-cifs@lfdr.de>; Fri,  6 Mar 2026 06:35:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C89D1DFE22;
	Fri,  6 Mar 2026 06:35:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ElgVPC8s"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BFFE371046
	for <linux-cifs@vger.kernel.org>; Fri,  6 Mar 2026 06:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772778943; cv=none; b=U8BqGpCORREaPV5TbunmIbmbu1zN0rhR82Atpf2+LzRb/fWWsWhbAHydoh8P6vXTqXlD1QiJ4kfvZtw8T17xxNwqmmX9TJXcNTQeOp1qDbAjx0RVkGTvdkjQKtkpnQ4WMYm8pveT4NuKjLZdZV02c532WBAKFyZvD3f726YM1Nk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772778943; c=relaxed/simple;
	bh=9cQdIdDbfHBxQdVjl1wma1djHdHSQkCaWml9R0EIOqw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Hb8LD2s2hHNhQng9ame0QYIHNbzbk+a+mP6G+nrDyP5v2cCN0hRK90mNYI/O4UMZzJeRBUkEz3S7YbV7+LN9hN66RZmaG25bp8MRTR/C1cPNu11gyMg43EUE0obNYmMClMwPgdGoAEDLJo22+6x0okMrwI6jCD4vtj+46ygOGvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ElgVPC8s; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-2ad617d5b80so57786695ad.1
        for <linux-cifs@vger.kernel.org>; Thu, 05 Mar 2026 22:35:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772778941; x=1773383741; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=O00SvXmF1/neLG6bXArW7CD/JczRf42amEzXY9wGYt8=;
        b=ElgVPC8sKDMRj4sc7J22emogY1ycBWQ/bj+kzeMim6SLxqBP6Zj3JTxvi/UZRuwg83
         KT7M9Y2MEjT5Ywz/SNDT+mZt0PIVYcanrtiS7PX5jWABI9cPru8+o5nBqVc+Tg36biaS
         eOnas/+TUq+P1mVyUD8VMwqFzxSjCT0IdSJ5FG8sDeEjaHkQugnZKQCOEZC9fOgmMyaK
         tptdlEydMT6+l/RDj7yG0difu1toTc/rwy5kEOmCckRR77IRLHhDnlKzUkTZN22Ibfd5
         IuHCakZelZeCOwDupwWmx66/PNV7kL7w6DfyNjUsf+mktwu8ZcCG3HXgOGcST+d28fIv
         6ztw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772778941; x=1773383741;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O00SvXmF1/neLG6bXArW7CD/JczRf42amEzXY9wGYt8=;
        b=KbaXVzTUzPV+t5SAeiyJg40Wv92XzzHWvfGWWs/evYJyAD8l/wqXsdITKarjuPhy03
         iMV/80w2y3OzwmOXdBbkFlTdEDpwPeM0gRMjsYr+xYo40EUV858teNQFzZp8+U/Xip9K
         IAWDqhX+aMp+r/FJ2qdi/FJsLIYRo25lhbhLrnDJ2fylGNoJGnUlfbO6fYBJp38pKnQO
         AnNQvZciMPwa+QdLBYMMIng/kX7BzWBcY2lIWqHu3xvdMTyaEdTVtz4wKKfqOMTiM4w2
         k8vu9fcMIoiOcT/S4fBo/DjcAlIJw2vOfkF7mV1SsnBonTcA8uXSL3fva0Fw63cjhUsN
         dhcg==
X-Gm-Message-State: AOJu0YwqrzxBAird4abDJ1Ahq2jzf8pCkkXaGWNakZSKk4HAm1/uXaDt
	gBKu0Itm/JeeVPQCS/w6xh8L2hm9C//efrEkiSb/Ke/Z8iGHMVvyyPVw22U7ohtRJK0=
X-Gm-Gg: ATEYQzwflWfUWYlOsIurZvYNX0Ajh5fVN4HYpge7D4qjX+pU/NsHMVE6WPkqBXtqcr8
	EP91M14pVh1lC2wVUjHrX4ijlDrDsa4rQ8RfViv+r0zzNEE1TyCmqDvrXli2JhqhcdL8HNIwpbS
	qwCZ6CefD3sFW4O06lh+90g6Fa+zUdco/rCptueGMiLwgqmeT7Y7Y7d+346CKGry9CTHMwwX0lq
	eJzjSHb91sIRX12lREadPXoU0PHNXIqRjeF2e0pm/pmXZdRYOY7Y6nYZeQAFGXqFAcl0y5TOQ0C
	56FeCdGpAlb21anxaEmyuj2C+TdcIbK8W3Kv4v1+MNbsgNdHD+H4Vss7WwEEqdlPI6suDo+kxZD
	fmLLeEhr3XCHwckCkXRDp3s2em5XVpTWONW5l0qJn/3PfFDol2g4dIaFnn6NS5js7tknLbJvYKJ
	Tv0K1qc30xHAP/R0PoByWyI6kt0Xstl9wQWxQW0vsyz70dmm/JXD3yYDs=
X-Received: by 2002:a17:903:46c4:b0:2ae:5063:b3e0 with SMTP id d9443c01a7336-2ae823febb1mr13075235ad.9.1772778941243;
        Thu, 05 Mar 2026 22:35:41 -0800 (PST)
Received: from ryzen ([2601:644:8000:56f5::8bd])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ae83f752bfsm9788055ad.60.2026.03.05.22.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2026 22:35:39 -0800 (PST)
From: Rosen Penev <rosenp@gmail.com>
To: linux-cifs@vger.kernel.org
Cc: Namjae Jeon <linkinjeon@kernel.org>,
	Steve French <smfrench@gmail.com>,
	Sergey Senozhatsky <senozhatsky@chromium.org>,
	Tom Talpey <tom@talpey.com>,
	Kees Cook <kees@kernel.org>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	linux-kernel@vger.kernel.org (open list),
	linux-hardening@vger.kernel.org (open list:KERNEL HARDENING (not covered by other areas):Keyword:\b__counted_by(_le|_be)?\b)
Subject: [PATCH] ksmbd: ipc: use kzalloc_flex and __counted_by
Date: Thu,  5 Mar 2026 22:35:22 -0800
Message-ID: <20260306063522.439782-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Queue-Id: 9BCC121C1FA
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,chromium.org,talpey.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-10109-lists,linux-cifs=lfdr.de];
	RCVD_COUNT_FIVE(0.00)[5];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[rosenp@gmail.com,linux-cifs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[9];
	NEURAL_HAM(-0.00)[-1.000];
	DKIM_TRACE(0.00)[gmail.com:+];
	TAGGED_RCPT(0.00)[linux-cifs];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

The former is just a nice macro and the latter allows runtime analysis
of the allocation and its size.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 fs/smb/server/transport_ipc.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 2dbabe2d8005..f7aa427a06fe 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -55,7 +55,7 @@ static bool ksmbd_ipc_validate_version(struct genl_info *m)
 struct ksmbd_ipc_msg {
 	unsigned int		type;
 	unsigned int		sz;
-	unsigned char		payload[];
+	unsigned char		payload[] __counted_by(sz);
 };
 
 struct ipc_msg_table_entry {
@@ -242,9 +242,8 @@ static void ipc_update_last_active(void)
 static struct ksmbd_ipc_msg *ipc_msg_alloc(size_t sz)
 {
 	struct ksmbd_ipc_msg *msg;
-	size_t msg_sz = sz + sizeof(struct ksmbd_ipc_msg);
 
-	msg = kvzalloc(msg_sz, KSMBD_DEFAULT_GFP);
+	msg = kvzalloc_flex(*msg, payload, sz, KSMBD_DEFAULT_GFP);
 	if (msg)
 		msg->sz = sz;
 	return msg;
-- 
2.53.0


