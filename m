Return-Path: <linux-cifs+bounces-3449-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F0809D677A
	for <lists+linux-cifs@lfdr.de>; Sat, 23 Nov 2024 05:17:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 82921B21A07
	for <lists+linux-cifs@lfdr.de>; Sat, 23 Nov 2024 04:17:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AF262AE90;
	Sat, 23 Nov 2024 04:17:25 +0000 (UTC)
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85BB61C32
	for <linux-cifs@vger.kernel.org>; Sat, 23 Nov 2024 04:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732335445; cv=none; b=gUCILz1C+3R/5+Mv8JhyYtrSSFCSdi4QYyfJpvo8QihvCfdulmzDYgRONqlZiQIMl5DkzXu06CIp/u4mdS39AjEwkI5yGApP8BQJGBY78G/5sYebx7D/92LHLN2qoDwSzTF1dFv9BychxxspL/ib53DyhQBclzyIdSsE5WwK9gA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732335445; c=relaxed/simple;
	bh=WIgngM4hf5DFdA4iJCKNaedgVioWc+GuPaXrGB47hfs=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=pL1tJayTVq383K1cOhwp/LWUkFy33tWTaVTyx6VsY/OykKsYsNzDenc40FVt+Jb3QmVWtbKS4Mxkl1RrKJctE8V/agvu4s/xuemUnZLUOgSYL87uayJ4ZQS8OKDTG22umX/Q8QNsMzObECV/WZ5wkrmE2uSHRuSbuOpP8+TIvv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-21271dc4084so27317665ad.2
        for <linux-cifs@vger.kernel.org>; Fri, 22 Nov 2024 20:17:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1732335441; x=1732940241;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qMiWtv4VNHlY9l/T3WrK1VLan7Rh4Al2B1832wXjzZY=;
        b=V9oxy4XG2DUz4JYh4LC4qTFbMuJ+KnsVMUc/pOoYSTeiMR0fZvhaJpoMw9RXRtg2d6
         2LlZMrojJ6PsWy3pDoEZFeQDRY2MoC0eKWItkyBcEJw91mOB3pQZv2sGRvcrA4ElKDDG
         84wW2+W40uJHk8KSw2MLSmz6iKRIJIL27Kc49+zySpgAaMJdSuSBMKgiAqPY+NRl/NQ0
         AStbFOl6R/DzDz19xmf51rAGwNucpZOLUWcDuZu9yziUPnkDRwS0sbgkTjRrg7W2qp2E
         lncyfuH+EvQVwZXph8lWRzCS0/oRvYS3zhxqW664o34GJbV3OSwGCc9FvNidvjKoGkTa
         URFw==
X-Gm-Message-State: AOJu0YyFBgDDeosjB8mrvCSsbkaz6YTo3/pd2Y7mBigwzGZDuc7VwxQX
	sdA7UpJBLPip1NDAD+MM+N+gO7Hk5Bx1o9aGh7nNBfE6PIKmYN9Go27Ekw==
X-Gm-Gg: ASbGncu23j8kuajc2sSPXqtEP1WYvNAxwgbGuNz4tuipMD7O1BLnIe0Xb+mU9EgMxzO
	TmC4wbh7Rqx9SSRRGXQhwh7yOGashvDdVC7jPaer0iv7hEc2Fv1r92MgwuVPGPMO2vAdEU+ZsrK
	SPTBuaZcyod5hBa4vqfjv/ytoflBTsUPUjA3OBaOCKQ9/P4Gig37mLzOGs17h4PmqldOEtEs2lc
	/92s5dnPOcsYZHNxpP4R5TB3Yf6YfbBgJD+9u7CrnI8wMrxGSz1oSptZnt/U34e
X-Google-Smtp-Source: AGHT+IFair1o9/S0E4VfCtGtmBv9YajfofjoIUcNo/OFsgFGl/KDOBr/FIv8T4nOX7be2vOY4iEGUw==
X-Received: by 2002:a17:903:8d0:b0:20c:ecca:432b with SMTP id d9443c01a7336-2129f686071mr73357925ad.35.1732335441203;
        Fri, 22 Nov 2024 20:17:21 -0800 (PST)
Received: from localhost.localdomain ([1.227.206.162])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2129dba20e2sm24437805ad.94.2024.11.22.20.17.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 Nov 2024 20:17:20 -0800 (PST)
From: Namjae Jeon <linkinjeon@kernel.org>
To: linux-cifs@vger.kernel.org
Cc: smfrench@gmail.com,
	senozhatsky@chromium.org,
	tom@talpey.com,
	atteh.mailbox@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 1/6] ksmbd: use __GFP_RETRY_MAYFAIL
Date: Sat, 23 Nov 2024 13:17:01 +0900
Message-Id: <20241123041706.4943-1-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Prefer to report ENOMEM rather than incur the oom for allocations in
ksmbd. __GFP_NORETRY could not achieve that, It would fail the allocations
just too easily. __GFP_RETRY_MAYFAIL will keep retrying the allocation
until there is no more progress and fail the allocation instead go OOM
and let the caller to deal with it.

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/smb/server/asn1.c              |  6 ++---
 fs/smb/server/auth.c              | 19 ++++++++--------
 fs/smb/server/connection.c        |  4 ++--
 fs/smb/server/crypto_ctx.c        |  6 ++---
 fs/smb/server/glob.h              |  2 ++
 fs/smb/server/ksmbd_work.c        | 10 ++++----
 fs/smb/server/mgmt/ksmbd_ida.c    | 11 +++++----
 fs/smb/server/mgmt/share_config.c | 10 ++++----
 fs/smb/server/mgmt/tree_connect.c |  5 ++--
 fs/smb/server/mgmt/user_config.c  |  8 +++----
 fs/smb/server/mgmt/user_session.c | 10 ++++----
 fs/smb/server/misc.c              | 11 +++++----
 fs/smb/server/ndr.c               | 10 ++++----
 fs/smb/server/oplock.c            | 12 +++++-----
 fs/smb/server/server.c            |  4 ++--
 fs/smb/server/smb2pdu.c           | 38 +++++++++++++++----------------
 fs/smb/server/smb_common.c        |  2 +-
 fs/smb/server/smbacl.c            | 23 ++++++++++---------
 fs/smb/server/transport_ipc.c     |  6 ++---
 fs/smb/server/transport_rdma.c    | 10 ++++----
 fs/smb/server/transport_tcp.c     | 12 +++++-----
 fs/smb/server/unicode.c           |  4 ++--
 fs/smb/server/vfs.c               | 12 +++++-----
 fs/smb/server/vfs_cache.c         | 10 ++++----
 24 files changed, 126 insertions(+), 119 deletions(-)

diff --git a/fs/smb/server/asn1.c b/fs/smb/server/asn1.c
index b931a99ab9c8..5c4c5121fece 100644
--- a/fs/smb/server/asn1.c
+++ b/fs/smb/server/asn1.c
@@ -104,7 +104,7 @@ int build_spnego_ntlmssp_neg_blob(unsigned char **pbuffer, u16 *buflen,
 			oid_len + ntlmssp_len) * 2 +
 			neg_result_len + oid_len + ntlmssp_len;
 
-	buf = kmalloc(total_len, GFP_KERNEL);
+	buf = kmalloc(total_len, KSMBD_DEFAULT_GFP);
 	if (!buf)
 		return -ENOMEM;
 
@@ -140,7 +140,7 @@ int build_spnego_ntlmssp_auth_blob(unsigned char **pbuffer, u16 *buflen,
 	int total_len = 4 + compute_asn_hdr_len_bytes(neg_result_len) * 2 +
 		neg_result_len;
 
-	buf = kmalloc(total_len, GFP_KERNEL);
+	buf = kmalloc(total_len, KSMBD_DEFAULT_GFP);
 	if (!buf)
 		return -ENOMEM;
 
@@ -217,7 +217,7 @@ static int ksmbd_neg_token_alloc(void *context, size_t hdrlen,
 	if (!vlen)
 		return -EINVAL;
 
-	conn->mechToken = kmemdup_nul(value, vlen, GFP_KERNEL);
+	conn->mechToken = kmemdup_nul(value, vlen, KSMBD_DEFAULT_GFP);
 	if (!conn->mechToken)
 		return -ENOMEM;
 
diff --git a/fs/smb/server/auth.c b/fs/smb/server/auth.c
index 611716bc8f27..1d1ffd0acaca 100644
--- a/fs/smb/server/auth.c
+++ b/fs/smb/server/auth.c
@@ -151,7 +151,7 @@ static int calc_ntlmv2_hash(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 
 	/* convert user_name to unicode */
 	len = strlen(user_name(sess->user));
-	uniname = kzalloc(2 + UNICODE_LEN(len), GFP_KERNEL);
+	uniname = kzalloc(2 + UNICODE_LEN(len), KSMBD_DEFAULT_GFP);
 	if (!uniname) {
 		ret = -ENOMEM;
 		goto out;
@@ -175,7 +175,7 @@ static int calc_ntlmv2_hash(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 
 	/* Convert domain name or conn name to unicode and uppercase */
 	len = strlen(dname);
-	domain = kzalloc(2 + UNICODE_LEN(len), GFP_KERNEL);
+	domain = kzalloc(2 + UNICODE_LEN(len), KSMBD_DEFAULT_GFP);
 	if (!domain) {
 		ret = -ENOMEM;
 		goto out;
@@ -254,7 +254,7 @@ int ksmbd_auth_ntlmv2(struct ksmbd_conn *conn, struct ksmbd_session *sess,
 	}
 
 	len = CIFS_CRYPTO_KEY_SIZE + blen;
-	construct = kzalloc(len, GFP_KERNEL);
+	construct = kzalloc(len, KSMBD_DEFAULT_GFP);
 	if (!construct) {
 		rc = -ENOMEM;
 		goto out;
@@ -361,7 +361,7 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
 		if (sess_key_len > CIFS_KEY_SIZE)
 			return -EINVAL;
 
-		ctx_arc4 = kmalloc(sizeof(*ctx_arc4), GFP_KERNEL);
+		ctx_arc4 = kmalloc(sizeof(*ctx_arc4), KSMBD_DEFAULT_GFP);
 		if (!ctx_arc4)
 			return -ENOMEM;
 
@@ -451,7 +451,7 @@ ksmbd_build_ntlmssp_challenge_blob(struct challenge_message *chgblob,
 
 	chgblob->NegotiateFlags = cpu_to_le32(flags);
 	len = strlen(ksmbd_netbios_name());
-	name = kmalloc(2 + UNICODE_LEN(len), GFP_KERNEL);
+	name = kmalloc(2 + UNICODE_LEN(len), KSMBD_DEFAULT_GFP);
 	if (!name)
 		return -ENOMEM;
 
@@ -1043,7 +1043,7 @@ static struct scatterlist *ksmbd_init_sg(struct kvec *iov, unsigned int nvec,
 	if (!nvec)
 		return NULL;
 
-	nr_entries = kcalloc(nvec, sizeof(int), GFP_KERNEL);
+	nr_entries = kcalloc(nvec, sizeof(int), KSMBD_DEFAULT_GFP);
 	if (!nr_entries)
 		return NULL;
 
@@ -1063,7 +1063,8 @@ static struct scatterlist *ksmbd_init_sg(struct kvec *iov, unsigned int nvec,
 	/* Add two entries for transform header and signature */
 	total_entries += 2;
 
-	sg = kmalloc_array(total_entries, sizeof(struct scatterlist), GFP_KERNEL);
+	sg = kmalloc_array(total_entries, sizeof(struct scatterlist),
+			   KSMBD_DEFAULT_GFP);
 	if (!sg) {
 		kfree(nr_entries);
 		return NULL;
@@ -1163,7 +1164,7 @@ int ksmbd_crypt_message(struct ksmbd_work *work, struct kvec *iov,
 		goto free_ctx;
 	}
 
-	req = aead_request_alloc(tfm, GFP_KERNEL);
+	req = aead_request_alloc(tfm, KSMBD_DEFAULT_GFP);
 	if (!req) {
 		rc = -ENOMEM;
 		goto free_ctx;
@@ -1182,7 +1183,7 @@ int ksmbd_crypt_message(struct ksmbd_work *work, struct kvec *iov,
 	}
 
 	iv_len = crypto_aead_ivsize(tfm);
-	iv = kzalloc(iv_len, GFP_KERNEL);
+	iv = kzalloc(iv_len, KSMBD_DEFAULT_GFP);
 	if (!iv) {
 		rc = -ENOMEM;
 		goto free_sg;
diff --git a/fs/smb/server/connection.c b/fs/smb/server/connection.c
index e6a72f75ab94..23c5ff84c9eb 100644
--- a/fs/smb/server/connection.c
+++ b/fs/smb/server/connection.c
@@ -52,7 +52,7 @@ struct ksmbd_conn *ksmbd_conn_alloc(void)
 {
 	struct ksmbd_conn *conn;
 
-	conn = kzalloc(sizeof(struct ksmbd_conn), GFP_KERNEL);
+	conn = kzalloc(sizeof(struct ksmbd_conn), KSMBD_DEFAULT_GFP);
 	if (!conn)
 		return NULL;
 
@@ -359,7 +359,7 @@ int ksmbd_conn_handler_loop(void *p)
 		/* 4 for rfc1002 length field */
 		/* 1 for implied bcc[0] */
 		size = pdu_size + 4 + 1;
-		conn->request_buf = kvmalloc(size, GFP_KERNEL);
+		conn->request_buf = kvmalloc(size, KSMBD_DEFAULT_GFP);
 		if (!conn->request_buf)
 			break;
 
diff --git a/fs/smb/server/crypto_ctx.c b/fs/smb/server/crypto_ctx.c
index 81488d04199d..ce733dc9a4a3 100644
--- a/fs/smb/server/crypto_ctx.c
+++ b/fs/smb/server/crypto_ctx.c
@@ -89,7 +89,7 @@ static struct shash_desc *alloc_shash_desc(int id)
 		return NULL;
 
 	shash = kzalloc(sizeof(*shash) + crypto_shash_descsize(tfm),
-			GFP_KERNEL);
+			KSMBD_DEFAULT_GFP);
 	if (!shash)
 		crypto_free_shash(tfm);
 	else
@@ -133,7 +133,7 @@ static struct ksmbd_crypto_ctx *ksmbd_find_crypto_ctx(void)
 		ctx_list.avail_ctx++;
 		spin_unlock(&ctx_list.ctx_lock);
 
-		ctx = kzalloc(sizeof(struct ksmbd_crypto_ctx), GFP_KERNEL);
+		ctx = kzalloc(sizeof(struct ksmbd_crypto_ctx), KSMBD_DEFAULT_GFP);
 		if (!ctx) {
 			spin_lock(&ctx_list.ctx_lock);
 			ctx_list.avail_ctx--;
@@ -258,7 +258,7 @@ int ksmbd_crypto_create(void)
 	init_waitqueue_head(&ctx_list.ctx_wait);
 	ctx_list.avail_ctx = 1;
 
-	ctx = kzalloc(sizeof(struct ksmbd_crypto_ctx), GFP_KERNEL);
+	ctx = kzalloc(sizeof(struct ksmbd_crypto_ctx), KSMBD_DEFAULT_GFP);
 	if (!ctx)
 		return -ENOMEM;
 	list_add(&ctx->list, &ctx_list.idle_ctx);
diff --git a/fs/smb/server/glob.h b/fs/smb/server/glob.h
index d528b20b37a8..afdd5809862f 100644
--- a/fs/smb/server/glob.h
+++ b/fs/smb/server/glob.h
@@ -44,4 +44,6 @@ extern int ksmbd_debug_types;
 
 #define UNICODE_LEN(x)		((x) * 2)
 
+#define KSMBD_DEFAULT_GFP	GFP_KERNEL | __GFP_RETRY_MAYFAIL
+
 #endif /* __KSMBD_GLOB_H */
diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
index d7c676c151e2..4af2e6007c29 100644
--- a/fs/smb/server/ksmbd_work.c
+++ b/fs/smb/server/ksmbd_work.c
@@ -18,7 +18,7 @@ static struct workqueue_struct *ksmbd_wq;
 
 struct ksmbd_work *ksmbd_alloc_work_struct(void)
 {
-	struct ksmbd_work *work = kmem_cache_zalloc(work_cache, GFP_KERNEL);
+	struct ksmbd_work *work = kmem_cache_zalloc(work_cache, KSMBD_DEFAULT_GFP);
 
 	if (work) {
 		work->compound_fid = KSMBD_NO_FID;
@@ -30,7 +30,7 @@ struct ksmbd_work *ksmbd_alloc_work_struct(void)
 		INIT_LIST_HEAD(&work->aux_read_list);
 		work->iov_alloc_cnt = 4;
 		work->iov = kcalloc(work->iov_alloc_cnt, sizeof(struct kvec),
-				    GFP_KERNEL);
+				    KSMBD_DEFAULT_GFP);
 		if (!work->iov) {
 			kmem_cache_free(work_cache, work);
 			work = NULL;
@@ -114,7 +114,7 @@ static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len,
 
 	if (aux_size) {
 		need_iov_cnt++;
-		ar = kmalloc(sizeof(struct aux_read), GFP_KERNEL);
+		ar = kmalloc(sizeof(struct aux_read), KSMBD_DEFAULT_GFP);
 		if (!ar)
 			return -ENOMEM;
 	}
@@ -125,7 +125,7 @@ static int __ksmbd_iov_pin_rsp(struct ksmbd_work *work, void *ib, int len,
 		work->iov_alloc_cnt += 4;
 		new = krealloc(work->iov,
 			       sizeof(struct kvec) * work->iov_alloc_cnt,
-			       GFP_KERNEL | __GFP_ZERO);
+			       KSMBD_DEFAULT_GFP | __GFP_ZERO);
 		if (!new) {
 			kfree(ar);
 			work->iov_alloc_cnt -= 4;
@@ -169,7 +169,7 @@ int ksmbd_iov_pin_rsp_read(struct ksmbd_work *work, void *ib, int len,
 
 int allocate_interim_rsp_buf(struct ksmbd_work *work)
 {
-	work->response_buf = kzalloc(MAX_CIFS_SMALL_BUFFER_SIZE, GFP_KERNEL);
+	work->response_buf = kzalloc(MAX_CIFS_SMALL_BUFFER_SIZE, KSMBD_DEFAULT_GFP);
 	if (!work->response_buf)
 		return -ENOMEM;
 	work->response_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
diff --git a/fs/smb/server/mgmt/ksmbd_ida.c b/fs/smb/server/mgmt/ksmbd_ida.c
index a18e27e9e0cd..0e2ae994ab52 100644
--- a/fs/smb/server/mgmt/ksmbd_ida.c
+++ b/fs/smb/server/mgmt/ksmbd_ida.c
@@ -4,31 +4,32 @@
  */
 
 #include "ksmbd_ida.h"
+#include "../glob.h"
 
 int ksmbd_acquire_smb2_tid(struct ida *ida)
 {
-	return ida_alloc_range(ida, 1, 0xFFFFFFFE, GFP_KERNEL);
+	return ida_alloc_range(ida, 1, 0xFFFFFFFE, KSMBD_DEFAULT_GFP);
 }
 
 int ksmbd_acquire_smb2_uid(struct ida *ida)
 {
 	int id;
 
-	id = ida_alloc_min(ida, 1, GFP_KERNEL);
+	id = ida_alloc_min(ida, 1, KSMBD_DEFAULT_GFP);
 	if (id == 0xFFFE)
-		id = ida_alloc_min(ida, 1, GFP_KERNEL);
+		id = ida_alloc_min(ida, 1, KSMBD_DEFAULT_GFP);
 
 	return id;
 }
 
 int ksmbd_acquire_async_msg_id(struct ida *ida)
 {
-	return ida_alloc_min(ida, 1, GFP_KERNEL);
+	return ida_alloc_min(ida, 1, KSMBD_DEFAULT_GFP);
 }
 
 int ksmbd_acquire_id(struct ida *ida)
 {
-	return ida_alloc(ida, GFP_KERNEL);
+	return ida_alloc(ida, KSMBD_DEFAULT_GFP);
 }
 
 void ksmbd_release_id(struct ida *ida, int id)
diff --git a/fs/smb/server/mgmt/share_config.c b/fs/smb/server/mgmt/share_config.c
index d8d03070ae44..d3d5f99bdd34 100644
--- a/fs/smb/server/mgmt/share_config.c
+++ b/fs/smb/server/mgmt/share_config.c
@@ -102,11 +102,11 @@ static int parse_veto_list(struct ksmbd_share_config *share,
 		if (!sz)
 			break;
 
-		p = kzalloc(sizeof(struct ksmbd_veto_pattern), GFP_KERNEL);
+		p = kzalloc(sizeof(struct ksmbd_veto_pattern), KSMBD_DEFAULT_GFP);
 		if (!p)
 			return -ENOMEM;
 
-		p->pattern = kstrdup(veto_list, GFP_KERNEL);
+		p->pattern = kstrdup(veto_list, KSMBD_DEFAULT_GFP);
 		if (!p->pattern) {
 			kfree(p);
 			return -ENOMEM;
@@ -150,14 +150,14 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 			goto out;
 	}
 
-	share = kzalloc(sizeof(struct ksmbd_share_config), GFP_KERNEL);
+	share = kzalloc(sizeof(struct ksmbd_share_config), KSMBD_DEFAULT_GFP);
 	if (!share)
 		goto out;
 
 	share->flags = resp->flags;
 	atomic_set(&share->refcount, 1);
 	INIT_LIST_HEAD(&share->veto_list);
-	share->name = kstrdup(name, GFP_KERNEL);
+	share->name = kstrdup(name, KSMBD_DEFAULT_GFP);
 
 	if (!test_share_config_flag(share, KSMBD_SHARE_FLAG_PIPE)) {
 		int path_len = PATH_MAX;
@@ -166,7 +166,7 @@ static struct ksmbd_share_config *share_config_request(struct ksmbd_work *work,
 			path_len = resp->payload_sz - resp->veto_list_sz;
 
 		share->path = kstrndup(ksmbd_share_config_path(resp), path_len,
-				      GFP_KERNEL);
+				      KSMBD_DEFAULT_GFP);
 		if (share->path) {
 			share->path_sz = strlen(share->path);
 			while (share->path_sz > 1 &&
diff --git a/fs/smb/server/mgmt/tree_connect.c b/fs/smb/server/mgmt/tree_connect.c
index 94a52a75014a..ecfc57508671 100644
--- a/fs/smb/server/mgmt/tree_connect.c
+++ b/fs/smb/server/mgmt/tree_connect.c
@@ -31,7 +31,8 @@ ksmbd_tree_conn_connect(struct ksmbd_work *work, const char *share_name)
 	if (!sc)
 		return status;
 
-	tree_conn = kzalloc(sizeof(struct ksmbd_tree_connect), GFP_KERNEL);
+	tree_conn = kzalloc(sizeof(struct ksmbd_tree_connect),
+			    KSMBD_DEFAULT_GFP);
 	if (!tree_conn) {
 		status.ret = -ENOMEM;
 		goto out_error;
@@ -80,7 +81,7 @@ ksmbd_tree_conn_connect(struct ksmbd_work *work, const char *share_name)
 	init_waitqueue_head(&tree_conn->refcount_q);
 
 	ret = xa_err(xa_store(&sess->tree_conns, tree_conn->id, tree_conn,
-			      GFP_KERNEL));
+			      KSMBD_DEFAULT_GFP));
 	if (ret) {
 		status.ret = -ENOMEM;
 		goto out_error;
diff --git a/fs/smb/server/mgmt/user_config.c b/fs/smb/server/mgmt/user_config.c
index 421a4a95e216..56c9a38ca878 100644
--- a/fs/smb/server/mgmt/user_config.c
+++ b/fs/smb/server/mgmt/user_config.c
@@ -36,16 +36,16 @@ struct ksmbd_user *ksmbd_alloc_user(struct ksmbd_login_response *resp,
 {
 	struct ksmbd_user *user;
 
-	user = kmalloc(sizeof(struct ksmbd_user), GFP_KERNEL);
+	user = kmalloc(sizeof(struct ksmbd_user), KSMBD_DEFAULT_GFP);
 	if (!user)
 		return NULL;
 
-	user->name = kstrdup(resp->account, GFP_KERNEL);
+	user->name = kstrdup(resp->account, KSMBD_DEFAULT_GFP);
 	user->flags = resp->status;
 	user->gid = resp->gid;
 	user->uid = resp->uid;
 	user->passkey_sz = resp->hash_sz;
-	user->passkey = kmalloc(resp->hash_sz, GFP_KERNEL);
+	user->passkey = kmalloc(resp->hash_sz, KSMBD_DEFAULT_GFP);
 	if (user->passkey)
 		memcpy(user->passkey, resp->hash, resp->hash_sz);
 
@@ -64,7 +64,7 @@ struct ksmbd_user *ksmbd_alloc_user(struct ksmbd_login_response *resp,
 
 		user->sgid = kmemdup(resp_ext->____payload,
 				     resp_ext->ngroups * sizeof(gid_t),
-				     GFP_KERNEL);
+				     KSMBD_DEFAULT_GFP);
 		if (!user->sgid)
 			goto err_free;
 
diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index ad02fe555fda..df92d746e89c 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -98,7 +98,7 @@ int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
 	if (!method)
 		return -EINVAL;
 
-	entry = kzalloc(sizeof(struct ksmbd_session_rpc), GFP_KERNEL);
+	entry = kzalloc(sizeof(struct ksmbd_session_rpc), KSMBD_DEFAULT_GFP);
 	if (!entry)
 		return -ENOMEM;
 
@@ -106,7 +106,7 @@ int ksmbd_session_rpc_open(struct ksmbd_session *sess, char *rpc_name)
 	entry->id = ksmbd_ipc_id_alloc();
 	if (entry->id < 0)
 		goto free_entry;
-	old = xa_store(&sess->rpc_handle_list, entry->id, entry, GFP_KERNEL);
+	old = xa_store(&sess->rpc_handle_list, entry->id, entry, KSMBD_DEFAULT_GFP);
 	if (xa_is_err(old))
 		goto free_id;
 
@@ -201,7 +201,7 @@ int ksmbd_session_register(struct ksmbd_conn *conn,
 	sess->dialect = conn->dialect;
 	memcpy(sess->ClientGUID, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
 	ksmbd_expire_session(conn);
-	return xa_err(xa_store(&conn->sessions, sess->id, sess, GFP_KERNEL));
+	return xa_err(xa_store(&conn->sessions, sess->id, sess, KSMBD_DEFAULT_GFP));
 }
 
 static int ksmbd_chann_del(struct ksmbd_conn *conn, struct ksmbd_session *sess)
@@ -314,7 +314,7 @@ struct preauth_session *ksmbd_preauth_session_alloc(struct ksmbd_conn *conn,
 {
 	struct preauth_session *sess;
 
-	sess = kmalloc(sizeof(struct preauth_session), GFP_KERNEL);
+	sess = kmalloc(sizeof(struct preauth_session), KSMBD_DEFAULT_GFP);
 	if (!sess)
 		return NULL;
 
@@ -398,7 +398,7 @@ static struct ksmbd_session *__session_create(int protocol)
 	if (protocol != CIFDS_SESSION_FLAG_SMB2)
 		return NULL;
 
-	sess = kzalloc(sizeof(struct ksmbd_session), GFP_KERNEL);
+	sess = kzalloc(sizeof(struct ksmbd_session), KSMBD_DEFAULT_GFP);
 	if (!sess)
 		return NULL;
 
diff --git a/fs/smb/server/misc.c b/fs/smb/server/misc.c
index 1a5faa6f6e7b..cb2a11ffb23f 100644
--- a/fs/smb/server/misc.c
+++ b/fs/smb/server/misc.c
@@ -165,7 +165,7 @@ char *convert_to_nt_pathname(struct ksmbd_share_config *share,
 	char *pathname, *ab_pathname, *nt_pathname;
 	int share_path_len = share->path_sz;
 
-	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	pathname = kmalloc(PATH_MAX, KSMBD_DEFAULT_GFP);
 	if (!pathname)
 		return ERR_PTR(-EACCES);
 
@@ -180,7 +180,8 @@ char *convert_to_nt_pathname(struct ksmbd_share_config *share,
 		goto free_pathname;
 	}
 
-	nt_pathname = kzalloc(strlen(&ab_pathname[share_path_len]) + 2, GFP_KERNEL);
+	nt_pathname = kzalloc(strlen(&ab_pathname[share_path_len]) + 2,
+			      KSMBD_DEFAULT_GFP);
 	if (!nt_pathname) {
 		nt_pathname = ERR_PTR(-ENOMEM);
 		goto free_pathname;
@@ -232,7 +233,7 @@ char *ksmbd_casefold_sharename(struct unicode_map *um, const char *name)
 	char *cf_name;
 	int cf_len;
 
-	cf_name = kzalloc(KSMBD_REQ_MAX_SHARE_NAME, GFP_KERNEL);
+	cf_name = kzalloc(KSMBD_REQ_MAX_SHARE_NAME, KSMBD_DEFAULT_GFP);
 	if (!cf_name)
 		return ERR_PTR(-ENOMEM);
 
@@ -294,7 +295,7 @@ char *convert_to_unix_name(struct ksmbd_share_config *share, const char *name)
 
 	path_len = share->path_sz;
 	name_len = strlen(name);
-	new_name = kmalloc(path_len + name_len + 2, GFP_KERNEL);
+	new_name = kmalloc(path_len + name_len + 2, KSMBD_DEFAULT_GFP);
 	if (!new_name)
 		return new_name;
 
@@ -320,7 +321,7 @@ char *ksmbd_convert_dir_info_name(struct ksmbd_dir_info *d_info,
 	if (!sz)
 		return NULL;
 
-	conv = kmalloc(sz, GFP_KERNEL);
+	conv = kmalloc(sz, KSMBD_DEFAULT_GFP);
 	if (!conv)
 		return NULL;
 
diff --git a/fs/smb/server/ndr.c b/fs/smb/server/ndr.c
index 3507d8f89074..58d71560f626 100644
--- a/fs/smb/server/ndr.c
+++ b/fs/smb/server/ndr.c
@@ -18,7 +18,7 @@ static int try_to_realloc_ndr_blob(struct ndr *n, size_t sz)
 {
 	char *data;
 
-	data = krealloc(n->data, n->offset + sz + 1024, GFP_KERNEL);
+	data = krealloc(n->data, n->offset + sz + 1024, KSMBD_DEFAULT_GFP);
 	if (!data)
 		return -ENOMEM;
 
@@ -174,7 +174,7 @@ int ndr_encode_dos_attr(struct ndr *n, struct xattr_dos_attrib *da)
 
 	n->offset = 0;
 	n->length = 1024;
-	n->data = kzalloc(n->length, GFP_KERNEL);
+	n->data = kzalloc(n->length, KSMBD_DEFAULT_GFP);
 	if (!n->data)
 		return -ENOMEM;
 
@@ -350,7 +350,7 @@ int ndr_encode_posix_acl(struct ndr *n,
 
 	n->offset = 0;
 	n->length = 1024;
-	n->data = kzalloc(n->length, GFP_KERNEL);
+	n->data = kzalloc(n->length, KSMBD_DEFAULT_GFP);
 	if (!n->data)
 		return -ENOMEM;
 
@@ -401,7 +401,7 @@ int ndr_encode_v4_ntacl(struct ndr *n, struct xattr_ntacl *acl)
 
 	n->offset = 0;
 	n->length = 2048;
-	n->data = kzalloc(n->length, GFP_KERNEL);
+	n->data = kzalloc(n->length, KSMBD_DEFAULT_GFP);
 	if (!n->data)
 		return -ENOMEM;
 
@@ -505,7 +505,7 @@ int ndr_decode_v4_ntacl(struct ndr *n, struct xattr_ntacl *acl)
 		return ret;
 
 	acl->sd_size = n->length - n->offset;
-	acl->sd_buf = kzalloc(acl->sd_size, GFP_KERNEL);
+	acl->sd_buf = kzalloc(acl->sd_size, KSMBD_DEFAULT_GFP);
 	if (!acl->sd_buf)
 		return -ENOMEM;
 
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 4142c7ad5fa9..3a3fe4afbdf0 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -34,7 +34,7 @@ static struct oplock_info *alloc_opinfo(struct ksmbd_work *work,
 	struct ksmbd_session *sess = work->sess;
 	struct oplock_info *opinfo;
 
-	opinfo = kzalloc(sizeof(struct oplock_info), GFP_KERNEL);
+	opinfo = kzalloc(sizeof(struct oplock_info), KSMBD_DEFAULT_GFP);
 	if (!opinfo)
 		return NULL;
 
@@ -94,7 +94,7 @@ static int alloc_lease(struct oplock_info *opinfo, struct lease_ctx_info *lctx)
 {
 	struct lease *lease;
 
-	lease = kmalloc(sizeof(struct lease), GFP_KERNEL);
+	lease = kmalloc(sizeof(struct lease), KSMBD_DEFAULT_GFP);
 	if (!lease)
 		return -ENOMEM;
 
@@ -709,7 +709,7 @@ static int smb2_oplock_break_noti(struct oplock_info *opinfo)
 	if (!work)
 		return -ENOMEM;
 
-	br_info = kmalloc(sizeof(struct oplock_break_info), GFP_KERNEL);
+	br_info = kmalloc(sizeof(struct oplock_break_info), KSMBD_DEFAULT_GFP);
 	if (!br_info) {
 		ksmbd_free_work_struct(work);
 		return -ENOMEM;
@@ -812,7 +812,7 @@ static int smb2_lease_break_noti(struct oplock_info *opinfo)
 	if (!work)
 		return -ENOMEM;
 
-	br_info = kmalloc(sizeof(struct lease_break_info), GFP_KERNEL);
+	br_info = kmalloc(sizeof(struct lease_break_info), KSMBD_DEFAULT_GFP);
 	if (!br_info) {
 		ksmbd_free_work_struct(work);
 		return -ENOMEM;
@@ -1057,7 +1057,7 @@ static int add_lease_global_list(struct oplock_info *opinfo)
 	}
 	read_unlock(&lease_list_lock);
 
-	lb = kmalloc(sizeof(struct lease_table), GFP_KERNEL);
+	lb = kmalloc(sizeof(struct lease_table), KSMBD_DEFAULT_GFP);
 	if (!lb)
 		return -ENOMEM;
 
@@ -1499,7 +1499,7 @@ struct lease_ctx_info *parse_lease_state(void *open_req)
 	if (IS_ERR_OR_NULL(cc))
 		return NULL;
 
-	lreq = kzalloc(sizeof(struct lease_ctx_info), GFP_KERNEL);
+	lreq = kzalloc(sizeof(struct lease_ctx_info), KSMBD_DEFAULT_GFP);
 	if (!lreq)
 		return NULL;
 
diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
index e6cfedba9992..b3dceefe6c5f 100644
--- a/fs/smb/server/server.c
+++ b/fs/smb/server/server.c
@@ -47,7 +47,7 @@ static int ___server_conf_set(int idx, char *val)
 		return -EINVAL;
 
 	kfree(server_conf.conf[idx]);
-	server_conf.conf[idx] = kstrdup(val, GFP_KERNEL);
+	server_conf.conf[idx] = kstrdup(val, KSMBD_DEFAULT_GFP);
 	if (!server_conf.conf[idx])
 		return -ENOMEM;
 	return 0;
@@ -415,7 +415,7 @@ static int __queue_ctrl_work(int type)
 {
 	struct server_ctrl_struct *ctrl;
 
-	ctrl = kmalloc(sizeof(struct server_ctrl_struct), GFP_KERNEL);
+	ctrl = kmalloc(sizeof(struct server_ctrl_struct), KSMBD_DEFAULT_GFP);
 	if (!ctrl)
 		return -ENOMEM;
 
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 599118aed205..61c82c755f6c 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -551,7 +551,7 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
 	if (le32_to_cpu(hdr->NextCommand) > 0)
 		sz = large_sz;
 
-	work->response_buf = kvzalloc(sz, GFP_KERNEL);
+	work->response_buf = kvzalloc(sz, KSMBD_DEFAULT_GFP);
 	if (!work->response_buf)
 		return -ENOMEM;
 
@@ -1147,7 +1147,7 @@ int smb2_handle_negotiate(struct ksmbd_work *work)
 	case SMB311_PROT_ID:
 		conn->preauth_info =
 			kzalloc(sizeof(struct preauth_integrity_info),
-				GFP_KERNEL);
+				KSMBD_DEFAULT_GFP);
 		if (!conn->preauth_info) {
 			rc = -ENOMEM;
 			rsp->hdr.Status = STATUS_INVALID_PARAMETER;
@@ -1266,7 +1266,7 @@ static int alloc_preauth_hash(struct ksmbd_session *sess,
 		return 0;
 
 	sess->Preauth_HashValue = kmemdup(conn->preauth_info->Preauth_HashValue,
-					  PREAUTH_HASHVALUE_SIZE, GFP_KERNEL);
+					  PREAUTH_HASHVALUE_SIZE, KSMBD_DEFAULT_GFP);
 	if (!sess->Preauth_HashValue)
 		return -ENOMEM;
 
@@ -1352,7 +1352,7 @@ static int ntlm_negotiate(struct ksmbd_work *work,
 	sz = sizeof(struct challenge_message);
 	sz += (strlen(ksmbd_netbios_name()) * 2 + 1 + 4) * 6;
 
-	neg_blob = kzalloc(sz, GFP_KERNEL);
+	neg_blob = kzalloc(sz, KSMBD_DEFAULT_GFP);
 	if (!neg_blob)
 		return -ENOMEM;
 
@@ -1543,12 +1543,12 @@ static int ntlm_authenticate(struct ksmbd_work *work,
 	if (conn->dialect >= SMB30_PROT_ID) {
 		chann = lookup_chann_list(sess, conn);
 		if (!chann) {
-			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
+			chann = kmalloc(sizeof(struct channel), KSMBD_DEFAULT_GFP);
 			if (!chann)
 				return -ENOMEM;
 
 			chann->conn = conn;
-			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
+			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, KSMBD_DEFAULT_GFP);
 		}
 	}
 
@@ -1624,12 +1624,12 @@ static int krb5_authenticate(struct ksmbd_work *work,
 	if (conn->dialect >= SMB30_PROT_ID) {
 		chann = lookup_chann_list(sess, conn);
 		if (!chann) {
-			chann = kmalloc(sizeof(struct channel), GFP_KERNEL);
+			chann = kmalloc(sizeof(struct channel), KSMBD_DEFAULT_GFP);
 			if (!chann)
 				return -ENOMEM;
 
 			chann->conn = conn;
-			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, GFP_KERNEL);
+			xa_store(&sess->ksmbd_chann_list, (long)conn, chann, KSMBD_DEFAULT_GFP);
 		}
 	}
 
@@ -2346,7 +2346,7 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len,
 			le16_to_cpu(eabuf->EaValueLength))
 		return -EINVAL;
 
-	attr_name = kmalloc(XATTR_NAME_MAX + 1, GFP_KERNEL);
+	attr_name = kmalloc(XATTR_NAME_MAX + 1, KSMBD_DEFAULT_GFP);
 	if (!attr_name)
 		return -ENOMEM;
 
@@ -2897,7 +2897,7 @@ int smb2_open(struct ksmbd_work *work)
 			goto err_out2;
 		}
 	} else {
-		name = kstrdup("", GFP_KERNEL);
+		name = kstrdup("", KSMBD_DEFAULT_GFP);
 		if (!name) {
 			rc = -ENOMEM;
 			goto err_out2;
@@ -3338,7 +3338,7 @@ int smb2_open(struct ksmbd_work *work)
 							sizeof(struct smb_sid) * 3 +
 							sizeof(struct smb_acl) +
 							sizeof(struct smb_ace) * ace_num * 2,
-							GFP_KERNEL);
+							KSMBD_DEFAULT_GFP);
 					if (!pntsd) {
 						posix_acl_release(fattr.cf_acls);
 						posix_acl_release(fattr.cf_dacls);
@@ -4946,7 +4946,7 @@ static int get_file_stream_info(struct ksmbd_work *work,
 
 		/* plus : size */
 		streamlen += 1;
-		stream_buf = kmalloc(streamlen + 1, GFP_KERNEL);
+		stream_buf = kmalloc(streamlen + 1, KSMBD_DEFAULT_GFP);
 		if (!stream_buf)
 			break;
 
@@ -5921,7 +5921,7 @@ static int smb2_create_link(struct ksmbd_work *work,
 		return -EINVAL;
 
 	ksmbd_debug(SMB, "setting FILE_LINK_INFORMATION\n");
-	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	pathname = kmalloc(PATH_MAX, KSMBD_DEFAULT_GFP);
 	if (!pathname)
 		return -ENOMEM;
 
@@ -6485,7 +6485,7 @@ static noinline int smb2_read_pipe(struct ksmbd_work *work)
 		}
 
 		aux_payload_buf =
-			kvmalloc(rpc_resp->payload_sz, GFP_KERNEL);
+			kvmalloc(rpc_resp->payload_sz, KSMBD_DEFAULT_GFP);
 		if (!aux_payload_buf) {
 			err = -ENOMEM;
 			goto out;
@@ -6664,7 +6664,7 @@ int smb2_read(struct ksmbd_work *work)
 	ksmbd_debug(SMB, "filename %pD, offset %lld, len %zu\n",
 		    fp->filp, offset, length);
 
-	aux_payload_buf = kvzalloc(length, GFP_KERNEL);
+	aux_payload_buf = kvzalloc(length, KSMBD_DEFAULT_GFP);
 	if (!aux_payload_buf) {
 		err = -ENOMEM;
 		goto out;
@@ -6816,7 +6816,7 @@ static ssize_t smb2_write_rdma_channel(struct ksmbd_work *work,
 	int ret;
 	ssize_t nbytes;
 
-	data_buf = kvzalloc(length, GFP_KERNEL);
+	data_buf = kvzalloc(length, KSMBD_DEFAULT_GFP);
 	if (!data_buf)
 		return -ENOMEM;
 
@@ -7145,7 +7145,7 @@ static struct ksmbd_lock *smb2_lock_init(struct file_lock *flock,
 {
 	struct ksmbd_lock *lock;
 
-	lock = kzalloc(sizeof(struct ksmbd_lock), GFP_KERNEL);
+	lock = kzalloc(sizeof(struct ksmbd_lock), KSMBD_DEFAULT_GFP);
 	if (!lock)
 		return NULL;
 
@@ -7413,7 +7413,7 @@ int smb2_lock(struct ksmbd_work *work)
 					    "would have to wait for getting lock\n");
 				list_add(&smb_lock->llist, &rollback_list);
 
-				argv = kmalloc(sizeof(void *), GFP_KERNEL);
+				argv = kmalloc(sizeof(void *), KSMBD_DEFAULT_GFP);
 				if (!argv) {
 					err = -ENOMEM;
 					goto out;
@@ -8907,7 +8907,7 @@ int smb3_encrypt_resp(struct ksmbd_work *work)
 	int rc = -ENOMEM;
 	void *tr_buf;
 
-	tr_buf = kzalloc(sizeof(struct smb2_transform_hdr) + 4, GFP_KERNEL);
+	tr_buf = kzalloc(sizeof(struct smb2_transform_hdr) + 4, KSMBD_DEFAULT_GFP);
 	if (!tr_buf)
 		return rc;
 
diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
index c3e4e0e95492..4e6f169fcf83 100644
--- a/fs/smb/server/smb_common.c
+++ b/fs/smb/server/smb_common.c
@@ -358,7 +358,7 @@ static int smb1_check_user_session(struct ksmbd_work *work)
 static int smb1_allocate_rsp_buf(struct ksmbd_work *work)
 {
 	work->response_buf = kzalloc(MAX_CIFS_SMALL_BUFFER_SIZE,
-			GFP_KERNEL);
+			KSMBD_DEFAULT_GFP);
 	work->response_sz = MAX_CIFS_SMALL_BUFFER_SIZE;
 
 	if (!work->response_buf) {
diff --git a/fs/smb/server/smbacl.c b/fs/smb/server/smbacl.c
index 1c9775f1efa5..d39d3e553366 100644
--- a/fs/smb/server/smbacl.c
+++ b/fs/smb/server/smbacl.c
@@ -345,10 +345,10 @@ int init_acl_state(struct posix_acl_state *state, int cnt)
 	 */
 	alloc = sizeof(struct posix_ace_state_array)
 		+ cnt * sizeof(struct posix_user_ace_state);
-	state->users = kzalloc(alloc, GFP_KERNEL);
+	state->users = kzalloc(alloc, KSMBD_DEFAULT_GFP);
 	if (!state->users)
 		return -ENOMEM;
-	state->groups = kzalloc(alloc, GFP_KERNEL);
+	state->groups = kzalloc(alloc, KSMBD_DEFAULT_GFP);
 	if (!state->groups) {
 		kfree(state->users);
 		return -ENOMEM;
@@ -410,7 +410,7 @@ static void parse_dacl(struct mnt_idmap *idmap,
 		return;
 	}
 
-	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *), GFP_KERNEL);
+	ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *), KSMBD_DEFAULT_GFP);
 	if (!ppace) {
 		free_acl_state(&default_acl_state);
 		free_acl_state(&acl_state);
@@ -553,7 +553,7 @@ static void parse_dacl(struct mnt_idmap *idmap,
 		if (IS_ENABLED(CONFIG_FS_POSIX_ACL)) {
 			fattr->cf_acls =
 				posix_acl_alloc(acl_state.users->n +
-					acl_state.groups->n + 4, GFP_KERNEL);
+					acl_state.groups->n + 4, KSMBD_DEFAULT_GFP);
 			if (fattr->cf_acls) {
 				cf_pace = fattr->cf_acls->a_entries;
 				posix_state_to_acl(&acl_state, cf_pace);
@@ -567,7 +567,7 @@ static void parse_dacl(struct mnt_idmap *idmap,
 		if (IS_ENABLED(CONFIG_FS_POSIX_ACL)) {
 			fattr->cf_dacls =
 				posix_acl_alloc(default_acl_state.users->n +
-				default_acl_state.groups->n + 4, GFP_KERNEL);
+				default_acl_state.groups->n + 4, KSMBD_DEFAULT_GFP);
 			if (fattr->cf_dacls) {
 				cf_pdace = fattr->cf_dacls->a_entries;
 				posix_state_to_acl(&default_acl_state, cf_pdace);
@@ -595,7 +595,7 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 	for (i = 0; i < fattr->cf_acls->a_count; i++, pace++) {
 		int flags = 0;
 
-		sid = kmalloc(sizeof(struct smb_sid), GFP_KERNEL);
+		sid = kmalloc(sizeof(struct smb_sid), KSMBD_DEFAULT_GFP);
 		if (!sid)
 			break;
 
@@ -662,7 +662,7 @@ static void set_posix_acl_entries_dacl(struct mnt_idmap *idmap,
 
 	pace = fattr->cf_dacls->a_entries;
 	for (i = 0; i < fattr->cf_dacls->a_count; i++, pace++) {
-		sid = kmalloc(sizeof(struct smb_sid), GFP_KERNEL);
+		sid = kmalloc(sizeof(struct smb_sid), KSMBD_DEFAULT_GFP);
 		if (!sid)
 			break;
 
@@ -906,7 +906,7 @@ int build_sec_desc(struct mnt_idmap *idmap,
 	gid_t gid;
 	unsigned int sid_type = SIDOWNER;
 
-	nowner_sid_ptr = kmalloc(sizeof(struct smb_sid), GFP_KERNEL);
+	nowner_sid_ptr = kmalloc(sizeof(struct smb_sid), KSMBD_DEFAULT_GFP);
 	if (!nowner_sid_ptr)
 		return -ENOMEM;
 
@@ -915,7 +915,7 @@ int build_sec_desc(struct mnt_idmap *idmap,
 		sid_type = SIDUNIX_USER;
 	id_to_sid(uid, sid_type, nowner_sid_ptr);
 
-	ngroup_sid_ptr = kmalloc(sizeof(struct smb_sid), GFP_KERNEL);
+	ngroup_sid_ptr = kmalloc(sizeof(struct smb_sid), KSMBD_DEFAULT_GFP);
 	if (!ngroup_sid_ptr) {
 		kfree(nowner_sid_ptr);
 		return -ENOMEM;
@@ -1032,7 +1032,8 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 		goto free_parent_pntsd;
 	}
 
-	aces_base = kmalloc(sizeof(struct smb_ace) * num_aces * 2, GFP_KERNEL);
+	aces_base = kmalloc(sizeof(struct smb_ace) * num_aces * 2,
+			    KSMBD_DEFAULT_GFP);
 	if (!aces_base) {
 		rc = -ENOMEM;
 		goto free_parent_pntsd;
@@ -1126,7 +1127,7 @@ int smb_inherit_dacl(struct ksmbd_conn *conn,
 		pntsd_alloc_size = sizeof(struct smb_ntsd) + powner_sid_size +
 			pgroup_sid_size + sizeof(struct smb_acl) + nt_size;
 
-		pntsd = kzalloc(pntsd_alloc_size, GFP_KERNEL);
+		pntsd = kzalloc(pntsd_alloc_size, KSMBD_DEFAULT_GFP);
 		if (!pntsd) {
 			rc = -ENOMEM;
 			goto free_aces_base;
diff --git a/fs/smb/server/transport_ipc.c b/fs/smb/server/transport_ipc.c
index 2f27afb695f6..48cda3350e5a 100644
--- a/fs/smb/server/transport_ipc.c
+++ b/fs/smb/server/transport_ipc.c
@@ -244,7 +244,7 @@ static struct ksmbd_ipc_msg *ipc_msg_alloc(size_t sz)
 	struct ksmbd_ipc_msg *msg;
 	size_t msg_sz = sz + sizeof(struct ksmbd_ipc_msg);
 
-	msg = kvzalloc(msg_sz, GFP_KERNEL);
+	msg = kvzalloc(msg_sz, KSMBD_DEFAULT_GFP);
 	if (msg)
 		msg->sz = sz;
 	return msg;
@@ -283,7 +283,7 @@ static int handle_response(int type, void *payload, size_t sz)
 			       entry->type + 1, type);
 		}
 
-		entry->response = kvzalloc(sz, GFP_KERNEL);
+		entry->response = kvzalloc(sz, KSMBD_DEFAULT_GFP);
 		if (!entry->response) {
 			ret = -ENOMEM;
 			break;
@@ -444,7 +444,7 @@ static int ipc_msg_send(struct ksmbd_ipc_msg *msg)
 	if (!ksmbd_tools_pid)
 		return ret;
 
-	skb = genlmsg_new(msg->sz, GFP_KERNEL);
+	skb = genlmsg_new(msg->sz, KSMBD_DEFAULT_GFP);
 	if (!skb)
 		return -ENOMEM;
 
diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdma.c
index 17c76713c6d0..7c5a0d712873 100644
--- a/fs/smb/server/transport_rdma.c
+++ b/fs/smb/server/transport_rdma.c
@@ -362,7 +362,7 @@ static struct smb_direct_transport *alloc_transport(struct rdma_cm_id *cm_id)
 	struct smb_direct_transport *t;
 	struct ksmbd_conn *conn;
 
-	t = kzalloc(sizeof(*t), GFP_KERNEL);
+	t = kzalloc(sizeof(*t), KSMBD_DEFAULT_GFP);
 	if (!t)
 		return NULL;
 
@@ -462,7 +462,7 @@ static struct smb_direct_sendmsg
 {
 	struct smb_direct_sendmsg *msg;
 
-	msg = mempool_alloc(t->sendmsg_mempool, GFP_KERNEL);
+	msg = mempool_alloc(t->sendmsg_mempool, KSMBD_DEFAULT_GFP);
 	if (!msg)
 		return ERR_PTR(-ENOMEM);
 	msg->transport = t;
@@ -1406,7 +1406,7 @@ static int smb_direct_rdma_xmit(struct smb_direct_transport *t,
 	desc_buf = buf;
 	for (i = 0; i < desc_num; i++) {
 		msg = kzalloc(struct_size(msg, sg_list, SG_CHUNK_SIZE),
-			      GFP_KERNEL);
+			      KSMBD_DEFAULT_GFP);
 		if (!msg) {
 			ret = -ENOMEM;
 			goto out;
@@ -1852,7 +1852,7 @@ static int smb_direct_create_pools(struct smb_direct_transport *t)
 	INIT_LIST_HEAD(&t->recvmsg_queue);
 
 	for (i = 0; i < t->recv_credit_max; i++) {
-		recvmsg = mempool_alloc(t->recvmsg_mempool, GFP_KERNEL);
+		recvmsg = mempool_alloc(t->recvmsg_mempool, KSMBD_DEFAULT_GFP);
 		if (!recvmsg)
 			goto err;
 		recvmsg->transport = t;
@@ -2144,7 +2144,7 @@ static int smb_direct_ib_client_add(struct ib_device *ib_dev)
 	if (!rdma_frwr_is_supported(&ib_dev->attrs))
 		return 0;
 
-	smb_dev = kzalloc(sizeof(*smb_dev), GFP_KERNEL);
+	smb_dev = kzalloc(sizeof(*smb_dev), KSMBD_DEFAULT_GFP);
 	if (!smb_dev)
 		return -ENOMEM;
 	smb_dev->ib_dev = ib_dev;
diff --git a/fs/smb/server/transport_tcp.c b/fs/smb/server/transport_tcp.c
index aaed9e293b2e..cc77ad4f765a 100644
--- a/fs/smb/server/transport_tcp.c
+++ b/fs/smb/server/transport_tcp.c
@@ -76,7 +76,7 @@ static struct tcp_transport *alloc_transport(struct socket *client_sk)
 	struct tcp_transport *t;
 	struct ksmbd_conn *conn;
 
-	t = kzalloc(sizeof(*t), GFP_KERNEL);
+	t = kzalloc(sizeof(*t), KSMBD_DEFAULT_GFP);
 	if (!t)
 		return NULL;
 	t->sock = client_sk;
@@ -151,7 +151,7 @@ static struct kvec *get_conn_iovec(struct tcp_transport *t, unsigned int nr_segs
 		return t->iov;
 
 	/* not big enough -- allocate a new one and release the old */
-	new_iov = kmalloc_array(nr_segs, sizeof(*new_iov), GFP_KERNEL);
+	new_iov = kmalloc_array(nr_segs, sizeof(*new_iov), KSMBD_DEFAULT_GFP);
 	if (new_iov) {
 		kfree(t->iov);
 		t->iov = new_iov;
@@ -528,7 +528,7 @@ static int ksmbd_netdev_event(struct notifier_block *nb, unsigned long event,
 			}
 		}
 		if (!found && bind_additional_ifaces) {
-			iface = alloc_iface(kstrdup(netdev->name, GFP_KERNEL));
+			iface = alloc_iface(kstrdup(netdev->name, KSMBD_DEFAULT_GFP));
 			if (!iface)
 				return NOTIFY_OK;
 			ret = create_socket(iface);
@@ -600,7 +600,7 @@ static struct interface *alloc_iface(char *ifname)
 	if (!ifname)
 		return NULL;
 
-	iface = kzalloc(sizeof(struct interface), GFP_KERNEL);
+	iface = kzalloc(sizeof(struct interface), KSMBD_DEFAULT_GFP);
 	if (!iface) {
 		kfree(ifname);
 		return NULL;
@@ -624,7 +624,7 @@ int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz)
 		for_each_netdev(&init_net, netdev) {
 			if (netif_is_bridge_port(netdev))
 				continue;
-			if (!alloc_iface(kstrdup(netdev->name, GFP_KERNEL))) {
+			if (!alloc_iface(kstrdup(netdev->name, KSMBD_DEFAULT_GFP))) {
 				rtnl_unlock();
 				return -ENOMEM;
 			}
@@ -635,7 +635,7 @@ int ksmbd_tcp_set_interfaces(char *ifc_list, int ifc_list_sz)
 	}
 
 	while (ifc_list_sz > 0) {
-		if (!alloc_iface(kstrdup(ifc_list, GFP_KERNEL)))
+		if (!alloc_iface(kstrdup(ifc_list, KSMBD_DEFAULT_GFP)))
 			return -ENOMEM;
 
 		sz = strlen(ifc_list);
diff --git a/fs/smb/server/unicode.c b/fs/smb/server/unicode.c
index 217106ff7b82..85e6791745ec 100644
--- a/fs/smb/server/unicode.c
+++ b/fs/smb/server/unicode.c
@@ -297,7 +297,7 @@ char *smb_strndup_from_utf16(const char *src, const int maxlen,
 	if (is_unicode) {
 		len = smb_utf16_bytes((__le16 *)src, maxlen, codepage);
 		len += nls_nullsize(codepage);
-		dst = kmalloc(len, GFP_KERNEL);
+		dst = kmalloc(len, KSMBD_DEFAULT_GFP);
 		if (!dst)
 			return ERR_PTR(-ENOMEM);
 		ret = smb_from_utf16(dst, (__le16 *)src, len, maxlen, codepage,
@@ -309,7 +309,7 @@ char *smb_strndup_from_utf16(const char *src, const int maxlen,
 	} else {
 		len = strnlen(src, maxlen);
 		len++;
-		dst = kmalloc(len, GFP_KERNEL);
+		dst = kmalloc(len, KSMBD_DEFAULT_GFP);
 		if (!dst)
 			return ERR_PTR(-ENOMEM);
 		strscpy(dst, src, len);
diff --git a/fs/smb/server/vfs.c b/fs/smb/server/vfs.c
index 7cbd580120d1..88d167a5f8b7 100644
--- a/fs/smb/server/vfs.c
+++ b/fs/smb/server/vfs.c
@@ -444,7 +444,7 @@ static int ksmbd_vfs_stream_write(struct ksmbd_file *fp, char *buf, loff_t *pos,
 	}
 
 	if (v_len < size) {
-		wbuf = kvzalloc(size, GFP_KERNEL);
+		wbuf = kvzalloc(size, KSMBD_DEFAULT_GFP);
 		if (!wbuf) {
 			err = -ENOMEM;
 			goto out;
@@ -865,7 +865,7 @@ ssize_t ksmbd_vfs_listxattr(struct dentry *dentry, char **list)
 	if (size <= 0)
 		return size;
 
-	vlist = kvzalloc(size, GFP_KERNEL);
+	vlist = kvzalloc(size, KSMBD_DEFAULT_GFP);
 	if (!vlist)
 		return -ENOMEM;
 
@@ -907,7 +907,7 @@ ssize_t ksmbd_vfs_getxattr(struct mnt_idmap *idmap,
 	if (xattr_len < 0)
 		return xattr_len;
 
-	buf = kmalloc(xattr_len + 1, GFP_KERNEL);
+	buf = kmalloc(xattr_len + 1, KSMBD_DEFAULT_GFP);
 	if (!buf)
 		return -ENOMEM;
 
@@ -1411,7 +1411,7 @@ static struct xattr_smb_acl *ksmbd_vfs_make_xattr_posix_acl(struct mnt_idmap *id
 
 	smb_acl = kzalloc(sizeof(struct xattr_smb_acl) +
 			  sizeof(struct xattr_acl_entry) * posix_acls->a_count,
-			  GFP_KERNEL);
+			  KSMBD_DEFAULT_GFP);
 	if (!smb_acl)
 		goto out;
 
@@ -1767,7 +1767,7 @@ int ksmbd_vfs_xattr_stream_name(char *stream_name, char **xattr_stream_name,
 	else
 		type = ":$DATA";
 
-	buf = kasprintf(GFP_KERNEL, "%s%s%s",
+	buf = kasprintf(KSMBD_DEFAULT_GFP, "%s%s%s",
 			XATTR_NAME_STREAM, stream_name,	type);
 	if (!buf)
 		return -ENOMEM;
@@ -1896,7 +1896,7 @@ int ksmbd_vfs_set_init_posix_acl(struct mnt_idmap *idmap,
 		acl_state.group.allow;
 	acl_state.mask.allow = 0x07;
 
-	acls = posix_acl_alloc(6, GFP_KERNEL);
+	acls = posix_acl_alloc(6, KSMBD_DEFAULT_GFP);
 	if (!acls) {
 		free_acl_state(&acl_state);
 		return -ENOMEM;
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index a19f4e563c7e..8d1f30dcba7e 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -188,7 +188,7 @@ static struct ksmbd_inode *ksmbd_inode_get(struct ksmbd_file *fp)
 	if (ci)
 		return ci;
 
-	ci = kmalloc(sizeof(struct ksmbd_inode), GFP_KERNEL);
+	ci = kmalloc(sizeof(struct ksmbd_inode), KSMBD_DEFAULT_GFP);
 	if (!ci)
 		return NULL;
 
@@ -577,7 +577,7 @@ static int __open_id(struct ksmbd_file_table *ft, struct ksmbd_file *fp,
 		return -EMFILE;
 	}
 
-	idr_preload(GFP_KERNEL);
+	idr_preload(KSMBD_DEFAULT_GFP);
 	write_lock(&ft->lock);
 	ret = idr_alloc_cyclic(ft->idr, fp, 0, INT_MAX - 1, GFP_NOWAIT);
 	if (ret >= 0) {
@@ -605,7 +605,7 @@ struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work *work, struct file *filp)
 	struct ksmbd_file *fp;
 	int ret;
 
-	fp = kmem_cache_zalloc(filp_cache, GFP_KERNEL);
+	fp = kmem_cache_zalloc(filp_cache, KSMBD_DEFAULT_GFP);
 	if (!fp) {
 		pr_err("Failed to allocate memory\n");
 		return ERR_PTR(-ENOMEM);
@@ -923,7 +923,7 @@ int ksmbd_validate_name_reconnect(struct ksmbd_share_config *share,
 	char *pathname, *ab_pathname;
 	int ret = 0;
 
-	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	pathname = kmalloc(PATH_MAX, KSMBD_DEFAULT_GFP);
 	if (!pathname)
 		return -EACCES;
 
@@ -983,7 +983,7 @@ int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
 
 int ksmbd_init_file_table(struct ksmbd_file_table *ft)
 {
-	ft->idr = kzalloc(sizeof(struct idr), GFP_KERNEL);
+	ft->idr = kzalloc(sizeof(struct idr), KSMBD_DEFAULT_GFP);
 	if (!ft->idr)
 		return -ENOMEM;
 
-- 
2.25.1


