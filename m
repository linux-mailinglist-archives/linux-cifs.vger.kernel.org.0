Return-Path: <linux-cifs+bounces-1430-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BABD877688
	for <lists+linux-cifs@lfdr.de>; Sun, 10 Mar 2024 13:04:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97164281486
	for <lists+linux-cifs@lfdr.de>; Sun, 10 Mar 2024 12:04:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AB486200C4;
	Sun, 10 Mar 2024 12:04:22 +0000 (UTC)
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A97516FF43
	for <linux-cifs@vger.kernel.org>; Sun, 10 Mar 2024 12:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710072262; cv=none; b=XGTDwGtlZedkBws0WACy63rVdeKK4J66oUcCvpR3Aw7m8SX+z3kzvkpP0nGr8WmdS3y4a7xwkyKg7y2lEqcbMFPQF5H3IsmxQWHlGMTLOxXj0yRR3Qnfs0HyFzpiRGhWJCLhWAKdQN1JuNGv1fWtUoG9W+0eTcl4WwK7Qd6aRgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710072262; c=relaxed/simple;
	bh=BwjzFBh+HGMm0O2o6EldjWLqib9UnGtTMB2RIrkcDoc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=g/uq78XzkfUp4PRppdW5B86SE9rrWOPH/1KQvQBJX4pugJ9pi806Lm325ygMaKSlt/6Uji2JB5OlbsaR9EIw7T2cZZfVzZdCLiu0Ad3zL1X0UL38z73diOYl4PVkFCaLquOjBXjSGMyemRj1CHmsLE5SEpUj+T5NYAvWK2QgrC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dd8f7d50c6so1695535ad.0
        for <linux-cifs@vger.kernel.org>; Sun, 10 Mar 2024 05:04:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710072259; x=1710677059;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bFXKezDCFzCNCJ7Omd3OTR0CwdzvmWYggmkgo13i4s0=;
        b=Ve6KYSa0VIIU8rgByMwrrggKLXXp2QmqZOIsESlh75SWrGWF0JgL1/O7wy7XPQDCuR
         W7b2DF5HUgtdkIa5oY8MC4tysC1OR1SQhsj3TvbggNUDvz+9MksN+dZXjEN5dDhlKtqG
         B08hbPjSeeLyFQXfYq8LFHc5EefrntcF6v1R+484Ya1SJ0/oFJnXL5qTV3dfvLdbTESK
         78Ll1nNTSv264WJWaIJawnzsmdM3xkmnXfhD9C5C6b/nKzZlVSSuJiPb+QdkXuo+uWV7
         dgt/WPxoWfydK5H6ct7sQAtJo7U/t7Hy7vdjhrasIlCoH4IEebfRreZfCvuRGljIm4rb
         Zqzg==
X-Gm-Message-State: AOJu0YxFfBulh4lC/NBJYA9kUKiHjYrgKwG3IWk4vyko2sBf0QyK6PdG
	WWLXwoqrgy3+b08aN/fsMZE4Ma8r8cvpEh0g43w0pQ16gB1SmHwSxmGrAf0L
X-Google-Smtp-Source: AGHT+IEnbLvxBD7hp1j+Q9wo1vII7lQK+dP32kMHetJhEo8n6cIck0uTJfs1vmelROw3hM40fvEx9w==
X-Received: by 2002:a17:902:7b96:b0:1d9:4106:b8b5 with SMTP id w22-20020a1709027b9600b001d94106b8b5mr3187413pll.11.1710072258517;
        Sun, 10 Mar 2024 05:04:18 -0700 (PDT)
Received: from localhost.localdomain ([110.14.71.32])
        by smtp.gmail.com with ESMTPSA id f10-20020a17090274ca00b001dcc8c26393sm2548445plt.225.2024.03.10.05.04.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 05:04:18 -0700 (PDT)
From: Namjae Jeon <linkinjeon@kernel.org>
To: linux-cifs@vger.kernel.org
Cc: smfrench@gmail.com,
	senozhatsky@chromium.org,
	tom@talpey.com,
	atteh.mailbox@gmail.com,
	Namjae Jeon <linkinjeon@kernel.org>
Subject: [PATCH 2/2] ksmbd: add support for durable handles v1/v2
Date: Sun, 10 Mar 2024 21:03:36 +0900
Message-Id: <20240310120336.14876-2-linkinjeon@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240310120336.14876-1-linkinjeon@kernel.org>
References: <20240310120336.14876-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Durable file handles allow reopening a file preserved on a short
network outage and transparent client reconnection within a timeout.
i.e. Durable handles aren't necessarily cleaned up when the opening
process terminates.

This patch add support for durable handle version 1 and 2.

To prove durable handles work on ksmbd, I have tested this patch with
the following smbtorture tests:

smb2.durable-open.open-oplock
smb2.durable-open.open-lease
smb2.durable-open.reopen1
smb2.durable-open.reopen1a
smb2.durable-open.reopen1a-lease
smb2.durable-open.reopen2
smb2.durable-open.reopen2a
smb2.durable-open.reopen2-lease
smb2.durable-open.reopen2-lease-v2
smb2.durable-open.reopen3
smb2.durable-open.reopen4
smb2.durable-open.delete_on_close2
smb2.durable-open.file-position
smb2.durable-open.lease
smb2.durable-open.alloc-size
smb2.durable-open.read-only
smb2.durable-v2-open.create-blob
smb2.durable-v2-open.open-oplock
smb2.durable-v2-open.open-lease
smb2.durable-v2-open.reopen1
smb2.durable-v2-open.reopen1a
smb2.durable-v2-open.reopen1a-lease
smb2.durable-v2-open.reopen2
smb2.durable-v2-open.reopen2b
smb2.durable-v2-open.reopen2c
smb2.durable-v2-open.reopen2-lease
smb2.durable-v2-open.reopen2-lease-v2

Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/smb/server/ksmbd_netlink.h     |   1 +
 fs/smb/server/mgmt/user_session.c |   1 +
 fs/smb/server/oplock.c            |  93 +++++++++--
 fs/smb/server/oplock.h            |   7 +-
 fs/smb/server/smb2ops.c           |   4 +
 fs/smb/server/smb2pdu.c           | 258 +++++++++++++++++++++++++++++-
 fs/smb/server/smb2pdu.h           |  15 ++
 fs/smb/server/vfs_cache.c         | 137 +++++++++++++++-
 fs/smb/server/vfs_cache.h         |   9 ++
 9 files changed, 505 insertions(+), 20 deletions(-)

diff --git a/fs/smb/server/ksmbd_netlink.h b/fs/smb/server/ksmbd_netlink.h
index 0ebf91ffa236..8ca8a45c4c62 100644
--- a/fs/smb/server/ksmbd_netlink.h
+++ b/fs/smb/server/ksmbd_netlink.h
@@ -75,6 +75,7 @@ struct ksmbd_heartbeat {
 #define KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION	BIT(1)
 #define KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL	BIT(2)
 #define KSMBD_GLOBAL_FLAG_SMB2_ENCRYPTION_OFF	BIT(3)
+#define KSMBD_GLOBAL_FLAG_DURABLE_HANDLE	BIT(4)
 
 /*
  * IPC request for ksmbd server startup
diff --git a/fs/smb/server/mgmt/user_session.c b/fs/smb/server/mgmt/user_session.c
index 83074672fe81..aec0a7a12405 100644
--- a/fs/smb/server/mgmt/user_session.c
+++ b/fs/smb/server/mgmt/user_session.c
@@ -324,6 +324,7 @@ void destroy_previous_session(struct ksmbd_conn *conn,
 	    memcmp(user->passkey, prev_user->passkey, user->passkey_sz))
 		goto out;
 
+	ksmbd_destroy_file_table(&prev_sess->file_table);
 	prev_sess->state = SMB2_SESSION_EXPIRED;
 out:
 	up_write(&conn->session_lock);
diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
index 53dfaac425c6..0cc08cf04991 100644
--- a/fs/smb/server/oplock.c
+++ b/fs/smb/server/oplock.c
@@ -159,7 +159,8 @@ static struct oplock_info *opinfo_get_list(struct ksmbd_inode *ci)
 	opinfo = list_first_or_null_rcu(&ci->m_op_list, struct oplock_info,
 					op_entry);
 	if (opinfo) {
-		if (!atomic_inc_not_zero(&opinfo->refcount))
+		if (opinfo->conn == NULL ||
+		    !atomic_inc_not_zero(&opinfo->refcount))
 			opinfo = NULL;
 		else {
 			atomic_inc(&opinfo->conn->r_count);
@@ -527,7 +528,7 @@ static struct oplock_info *same_client_has_lease(struct ksmbd_inode *ci,
 	 */
 	read_lock(&ci->m_lock);
 	list_for_each_entry(opinfo, &ci->m_op_list, op_entry) {
-		if (!opinfo->is_lease)
+		if (!opinfo->is_lease || !opinfo->conn)
 			continue;
 		read_unlock(&ci->m_lock);
 		lease = opinfo->o_lease;
@@ -641,7 +642,7 @@ static void __smb2_oplock_break_noti(struct work_struct *wk)
 	struct smb2_hdr *rsp_hdr;
 	struct ksmbd_file *fp;
 
-	fp = ksmbd_lookup_durable_fd(br_info->fid);
+	fp = ksmbd_lookup_global_fd(br_info->fid);
 	if (!fp)
 		goto out;
 
@@ -1106,7 +1107,7 @@ void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 
 	read_lock(&p_ci->m_lock);
 	list_for_each_entry(opinfo, &p_ci->m_op_list, op_entry) {
-		if (!opinfo->is_lease)
+		if (opinfo->conn == NULL || !opinfo->is_lease)
 			continue;
 
 		if (opinfo->o_lease->state != SMB2_OPLOCK_LEVEL_NONE &&
@@ -1151,7 +1152,7 @@ void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp)
 
 	read_lock(&p_ci->m_lock);
 	list_for_each_entry(opinfo, &p_ci->m_op_list, op_entry) {
-		if (!opinfo->is_lease)
+		if (opinfo->conn == NULL || !opinfo->is_lease)
 			continue;
 
 		if (opinfo->o_lease->state != SMB2_OPLOCK_LEVEL_NONE) {
@@ -1361,6 +1362,9 @@ void smb_break_all_levII_oplock(struct ksmbd_work *work, struct ksmbd_file *fp,
 
 	rcu_read_lock();
 	list_for_each_entry_rcu(brk_op, &ci->m_op_list, op_entry) {
+		if (brk_op->conn == NULL)
+			continue;
+
 		if (!atomic_inc_not_zero(&brk_op->refcount))
 			continue;
 
@@ -1500,7 +1504,7 @@ void create_lease_buf(u8 *rbuf, struct lease *lease)
  *
  * Return:  oplock state, -ENOENT if create lease context not found
  */
-struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir)
+struct lease_ctx_info *parse_lease_state(void *open_req)
 {
 	struct create_context *cc;
 	struct smb2_create_req *req = (struct smb2_create_req *)open_req;
@@ -1518,12 +1522,7 @@ struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir)
 		struct create_lease_v2 *lc = (struct create_lease_v2 *)cc;
 
 		memcpy(lreq->lease_key, lc->lcontext.LeaseKey, SMB2_LEASE_KEY_SIZE);
-		if (is_dir) {
-			lreq->req_state = lc->lcontext.LeaseState &
-				~SMB2_LEASE_WRITE_CACHING_LE;
-			lreq->is_dir = true;
-		} else
-			lreq->req_state = lc->lcontext.LeaseState;
+		lreq->req_state = lc->lcontext.LeaseState;
 		lreq->flags = lc->lcontext.LeaseFlags;
 		lreq->epoch = lc->lcontext.Epoch;
 		lreq->duration = lc->lcontext.LeaseDuration;
@@ -1646,6 +1645,8 @@ void create_durable_v2_rsp_buf(char *cc, struct ksmbd_file *fp)
 	buf->Name[3] = 'Q';
 
 	buf->Timeout = cpu_to_le32(fp->durable_timeout);
+	if (fp->is_persistent)
+		buf->Flags = SMB2_DHANDLE_FLAG_PERSISTENT;
 }
 
 /**
@@ -1813,3 +1814,71 @@ struct oplock_info *lookup_lease_in_table(struct ksmbd_conn *conn,
 	read_unlock(&lease_list_lock);
 	return ret_op;
 }
+
+int smb2_check_durable_oplock(struct ksmbd_conn *conn,
+			      struct ksmbd_share_config *share,
+			      struct ksmbd_file *fp,
+			      struct lease_ctx_info *lctx,
+			      char *name)
+{
+	struct oplock_info *opinfo = opinfo_get(fp);
+	int ret = 0;
+
+	if (!opinfo)
+		return 0;
+
+	if (opinfo->is_lease == false) {
+		if (lctx) {
+			pr_err("create context include lease\n");
+			ret = -EBADF;
+			goto out;
+		}
+
+		if (opinfo->level != SMB2_OPLOCK_LEVEL_BATCH) {
+			pr_err("oplock level is not equal to SMB2_OPLOCK_LEVEL_BATCH\n");
+			ret = -EBADF;
+		}
+
+		goto out;
+	}
+
+	if (memcmp(conn->ClientGUID, fp->client_guid,
+				SMB2_CLIENT_GUID_SIZE)) {
+		ksmbd_debug(SMB, "Client guid of fp is not equal to the one of connction\n");
+		ret = -EBADF;
+		goto out;
+	}
+
+	if (!lctx) {
+		ksmbd_debug(SMB, "create context does not include lease\n");
+		ret = -EBADF;
+		goto out;
+	}
+
+	if (memcmp(opinfo->o_lease->lease_key, lctx->lease_key,
+				SMB2_LEASE_KEY_SIZE)) {
+		ksmbd_debug(SMB,
+			    "lease key of fp does not match lease key in create context\n");
+		ret = -EBADF;
+		goto out;
+	}
+
+	if (!(opinfo->o_lease->state & SMB2_LEASE_HANDLE_CACHING_LE)) {
+		ksmbd_debug(SMB, "lease state does not contain SMB2_LEASE_HANDLE_CACHING\n");
+		ret = -EBADF;
+		goto out;
+	}
+
+	if (opinfo->o_lease->version != lctx->version) {
+		ksmbd_debug(SMB,
+			    "lease version of fp does not match the one in create context\n");
+		ret = -EBADF;
+		goto out;
+	}
+
+	if (!ksmbd_inode_pending_delete(fp))
+		ret = ksmbd_validate_name_reconnect(share, fp, name);
+out:
+	opinfo_put(opinfo);
+	return ret;
+}
diff --git a/fs/smb/server/oplock.h b/fs/smb/server/oplock.h
index 5b93ea9196c0..e9da63f25b20 100644
--- a/fs/smb/server/oplock.h
+++ b/fs/smb/server/oplock.h
@@ -111,7 +111,7 @@ void opinfo_put(struct oplock_info *opinfo);
 
 /* Lease related functions */
 void create_lease_buf(u8 *rbuf, struct lease *lease);
-struct lease_ctx_info *parse_lease_state(void *open_req, bool is_dir);
+struct lease_ctx_info *parse_lease_state(void *open_req);
 __u8 smb2_map_lease_to_oplock(__le32 lease_state);
 int lease_read_to_write(struct oplock_info *opinfo);
 
@@ -130,4 +130,9 @@ void destroy_lease_table(struct ksmbd_conn *conn);
 void smb_send_parent_lease_break_noti(struct ksmbd_file *fp,
 				      struct lease_ctx_info *lctx);
 void smb_lazy_parent_lease_break_close(struct ksmbd_file *fp);
+int smb2_check_durable_oplock(struct ksmbd_conn *conn,
+			      struct ksmbd_share_config *share,
+			      struct ksmbd_file *fp,
+			      struct lease_ctx_info *lctx,
+			      char *name);
 #endif /* __KSMBD_OPLOCK_H */
diff --git a/fs/smb/server/smb2ops.c b/fs/smb/server/smb2ops.c
index 27a9dce3e03a..506dde3bf36a 100644
--- a/fs/smb/server/smb2ops.c
+++ b/fs/smb/server/smb2ops.c
@@ -256,6 +256,8 @@ void init_smb3_02_server(struct ksmbd_conn *conn)
 
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
+
+	conn->vals->capabilities |= SMB2_GLOBAL_CAP_PERSISTENT_HANDLES;
 }
 
 /**
@@ -283,6 +285,8 @@ int init_smb3_11_server(struct ksmbd_conn *conn)
 	if (server_conf.flags & KSMBD_GLOBAL_FLAG_SMB3_MULTICHANNEL)
 		conn->vals->capabilities |= SMB2_GLOBAL_CAP_MULTI_CHANNEL;
 
+	conn->vals->capabilities |= SMB2_GLOBAL_CAP_PERSISTENT_HANDLES;
+
 	INIT_LIST_HEAD(&conn->preauth_sess_table);
 	return 0;
 }
diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index 201d78310bde..945a37077a71 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -2618,6 +2618,166 @@ static void ksmbd_acls_fattr(struct smb_fattr *fattr,
 	}
 }
 
+enum {
+	DURABLE_RECONN_V2 = 1,
+	DURABLE_RECONN,
+	DURABLE_REQ_V2,
+	DURABLE_REQ,
+};
+
+struct durable_info {
+	struct ksmbd_file *fp;
+	unsigned short int type;
+	bool persistent;
+	bool reconnected;
+	unsigned int timeout;
+	char *CreateGuid;
+};
+
+static int parse_durable_handle_context(struct ksmbd_work *work,
+					struct smb2_create_req *req,
+					struct lease_ctx_info *lc,
+					struct durable_info *dh_info)
+{
+	struct ksmbd_conn *conn = work->conn;
+	struct create_context *context;
+	int dh_idx, err = 0;
+	u64 persistent_id = 0;
+	int req_op_level;
+	static const char * const durable_arr[] = {"DH2C", "DHnC", "DH2Q", "DHnQ"};
+
+	req_op_level = req->RequestedOplockLevel;
+	for (dh_idx = DURABLE_RECONN_V2; dh_idx <= ARRAY_SIZE(durable_arr);
+	     dh_idx++) {
+		context = smb2_find_context_vals(req, durable_arr[dh_idx - 1], 4);
+		if (IS_ERR_OR_NULL(context)) {
+			err = PTR_ERR(context);
+			if (err == -EINVAL)
+				goto out;
+			err = 0;
+			continue;
+		}
+
+		switch (dh_idx) {
+		case DURABLE_RECONN_V2:
+		{
+			struct create_durable_reconn_v2_req *recon_v2;
+
+			if (dh_info->type == DURABLE_RECONN ||
+			    dh_info->type == DURABLE_REQ_V2) {
+				err = -EINVAL;
+				goto out;
+			}
+
+			recon_v2 = (struct create_durable_reconn_v2_req *)context;
+			persistent_id = le64_to_cpu(recon_v2->Fid.PersistentFileId);
+			dh_info->fp = ksmbd_lookup_durable_fd(persistent_id);
+			if (!dh_info->fp) {
+				ksmbd_debug(SMB, "Failed to get durable handle state\n");
+				err = -EBADF;
+				goto out;
+			}
+
+			if (memcmp(dh_info->fp->create_guid, recon_v2->CreateGuid,
+				   SMB2_CREATE_GUID_SIZE)) {
+				err = -EBADF;
+				ksmbd_put_durable_fd(dh_info->fp);
+				goto out;
+			}
+
+			dh_info->type = dh_idx;
+			dh_info->reconnected = true;
+			ksmbd_debug(SMB,
+				"reconnect v2 Persistent-id from reconnect = %llu\n",
+					persistent_id);
+			break;
+		}
+		case DURABLE_RECONN:
+		{
+			struct create_durable_reconn_req *recon;
+
+			if (dh_info->type == DURABLE_RECONN_V2 ||
+			    dh_info->type == DURABLE_REQ_V2) {
+				err = -EINVAL;
+				goto out;
+			}
+
+			recon = (struct create_durable_reconn_req *)context;
+			persistent_id = le64_to_cpu(recon->Data.Fid.PersistentFileId);
+			dh_info->fp = ksmbd_lookup_durable_fd(persistent_id);
+			if (!dh_info->fp) {
+				ksmbd_debug(SMB, "Failed to get durable handle state\n");
+				err = -EBADF;
+				goto out;
+			}
+
+			dh_info->type = dh_idx;
+			dh_info->reconnected = true;
+			ksmbd_debug(SMB, "reconnect Persistent-id from reconnect = %llu\n",
+				    persistent_id);
+			break;
+		}
+		case DURABLE_REQ_V2:
+		{
+			struct create_durable_req_v2 *durable_v2_blob;
+
+			if (dh_info->type == DURABLE_RECONN ||
+			    dh_info->type == DURABLE_RECONN_V2) {
+				err = -EINVAL;
+				goto out;
+			}
+
+			durable_v2_blob =
+				(struct create_durable_req_v2 *)context;
+			ksmbd_debug(SMB, "Request for durable v2 open\n");
+			dh_info->fp = ksmbd_lookup_fd_cguid(durable_v2_blob->CreateGuid);
+			if (dh_info->fp) {
+				if (!memcmp(conn->ClientGUID, dh_info->fp->client_guid,
+					    SMB2_CLIENT_GUID_SIZE)) {
+					if (!(req->hdr.Flags & SMB2_FLAGS_REPLAY_OPERATION)) {
+						err = -ENOEXEC;
+						goto out;
+					}
+
+					dh_info->fp->conn = conn;
+					dh_info->reconnected = true;
+					goto out;
+				}
+			}
+
+			if (((lc && (lc->req_state & SMB2_LEASE_HANDLE_CACHING_LE)) ||
+			     req_op_level == SMB2_OPLOCK_LEVEL_BATCH)) {
+				dh_info->CreateGuid =
+					durable_v2_blob->CreateGuid;
+				dh_info->persistent =
+					le32_to_cpu(durable_v2_blob->Flags);
+				dh_info->timeout =
+					le32_to_cpu(durable_v2_blob->Timeout);
+				dh_info->type = dh_idx;
+			}
+			break;
+		}
+		case DURABLE_REQ:
+			if (dh_info->type == DURABLE_RECONN)
+				goto out;
+			if (dh_info->type == DURABLE_RECONN_V2 ||
+			    dh_info->type == DURABLE_REQ_V2) {
+				err = -EINVAL;
+				goto out;
+			}
+
+			if (((lc && (lc->req_state & SMB2_LEASE_HANDLE_CACHING_LE)) ||
+			     req_op_level == SMB2_OPLOCK_LEVEL_BATCH)) {
+				ksmbd_debug(SMB, "Request for durable open\n");
+				dh_info->type = dh_idx;
+			}
+		}
+	}
+
+out:
+	return err;
+}
+
 /**
  * smb2_open() - handler for smb file open request
  * @work:	smb work containing request buffer
@@ -2641,6 +2801,7 @@ int smb2_open(struct ksmbd_work *work)
 	struct lease_ctx_info *lc = NULL;
 	struct create_ea_buf_req *ea_buf = NULL;
 	struct oplock_info *opinfo;
+	struct durable_info dh_info = {0};
 	__le32 *next_ptr = NULL;
 	int req_op_level = 0, open_flags = 0, may_flags = 0, file_info = 0;
 	int rc = 0;
@@ -2721,6 +2882,49 @@ int smb2_open(struct ksmbd_work *work)
 		}
 	}
 
+	req_op_level = req->RequestedOplockLevel;
+
+	if (server_conf.flags & KSMBD_GLOBAL_FLAG_DURABLE_HANDLE &&
+	    req->CreateContextsOffset) {
+		lc = parse_lease_state(req);
+		rc = parse_durable_handle_context(work, req, lc, &dh_info);
+		if (rc) {
+			ksmbd_debug(SMB, "error parsing durable handle context\n");
+			goto err_out2;
+		}
+
+		if (dh_info.reconnected == true) {
+			rc = smb2_check_durable_oplock(conn, share, dh_info.fp, lc, name);
+			if (rc) {
+				ksmbd_put_durable_fd(dh_info.fp);
+				goto err_out2;
+			}
+
+			rc = ksmbd_reopen_durable_fd(work, dh_info.fp);
+			if (rc) {
+				ksmbd_put_durable_fd(dh_info.fp);
+				goto err_out2;
+			}
+
+			if (ksmbd_override_fsids(work)) {
+				rc = -ENOMEM;
+				ksmbd_put_durable_fd(dh_info.fp);
+				goto err_out2;
+			}
+
+			fp = dh_info.fp;
+			file_info = FILE_OPENED;
+
+			rc = ksmbd_vfs_getattr(&fp->filp->f_path, &stat);
+			if (rc)
+				goto err_out2;
+
+			ksmbd_put_durable_fd(fp);
+			goto reconnected_fp;
+		}
+	} else if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE)
+		lc = parse_lease_state(req);
+
 	if (le32_to_cpu(req->ImpersonationLevel) > le32_to_cpu(IL_DELEGATE)) {
 		pr_err("Invalid impersonationlevel : 0x%x\n",
 		       le32_to_cpu(req->ImpersonationLevel));
@@ -3183,10 +3387,6 @@ int smb2_open(struct ksmbd_work *work)
 		need_truncate = 1;
 	}
 
-	req_op_level = req->RequestedOplockLevel;
-	if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE)
-		lc = parse_lease_state(req, S_ISDIR(file_inode(filp)->i_mode));
-
 	share_ret = ksmbd_smb_check_shared_mode(fp->filp, fp);
 	if (!test_share_config_flag(work->tcon->share_conf, KSMBD_SHARE_FLAG_OPLOCKS) ||
 	    (req_op_level == SMB2_OPLOCK_LEVEL_LEASE &&
@@ -3197,6 +3397,11 @@ int smb2_open(struct ksmbd_work *work)
 		}
 	} else {
 		if (req_op_level == SMB2_OPLOCK_LEVEL_LEASE) {
+			if (S_ISDIR(file_inode(filp)->i_mode)) {
+				lc->req_state &= ~SMB2_LEASE_WRITE_CACHING_LE;
+				lc->is_dir = true;
+			}
+
 			/*
 			 * Compare parent lease using parent key. If there is no
 			 * a lease that has same parent key, Send lease break
@@ -3293,6 +3498,24 @@ int smb2_open(struct ksmbd_work *work)
 
 	memcpy(fp->client_guid, conn->ClientGUID, SMB2_CLIENT_GUID_SIZE);
 
+	if (dh_info.type == DURABLE_REQ_V2 || dh_info.type == DURABLE_REQ) {
+		if (dh_info.type == DURABLE_REQ_V2 && dh_info.persistent)
+			fp->is_persistent = true;
+		else
+			fp->is_durable = true;
+
+		if (dh_info.type == DURABLE_REQ_V2) {
+			memcpy(fp->create_guid, dh_info.CreateGuid,
+					SMB2_CREATE_GUID_SIZE);
+			if (dh_info.timeout)
+				fp->durable_timeout = min(dh_info.timeout,
+						300000);
+			else
+				fp->durable_timeout = 60;
+		}
+	}
+
+reconnected_fp:
 	rsp->StructureSize = cpu_to_le16(89);
 	rcu_read_lock();
 	opinfo = rcu_dereference(fp->f_opinfo);
@@ -3379,6 +3602,33 @@ int smb2_open(struct ksmbd_work *work)
 		next_off = conn->vals->create_disk_id_size;
 	}
 
+	if (dh_info.type == DURABLE_REQ || dh_info.type == DURABLE_REQ_V2) {
+		struct create_context *durable_ccontext;
+
+		durable_ccontext = (struct create_context *)(rsp->Buffer +
+				le32_to_cpu(rsp->CreateContextsLength));
+		contxt_cnt++;
+		if (dh_info.type == DURABLE_REQ) {
+			create_durable_rsp_buf(rsp->Buffer +
+					le32_to_cpu(rsp->CreateContextsLength));
+			le32_add_cpu(&rsp->CreateContextsLength,
+					conn->vals->create_durable_size);
+			iov_len += conn->vals->create_durable_size;
+		} else {
+			create_durable_v2_rsp_buf(rsp->Buffer +
+					le32_to_cpu(rsp->CreateContextsLength),
+					fp);
+			le32_add_cpu(&rsp->CreateContextsLength,
+					conn->vals->create_durable_v2_size);
+			iov_len += conn->vals->create_durable_v2_size;
+		}
+
+		if (next_ptr)
+			*next_ptr = cpu_to_le32(next_off);
+		next_ptr = &durable_ccontext->Next;
+		next_off = conn->vals->create_durable_size;
+	}
+
 	if (posix_ctxt) {
 		contxt_cnt++;
 		create_posix_rsp_buf(rsp->Buffer +
diff --git a/fs/smb/server/smb2pdu.h b/fs/smb/server/smb2pdu.h
index d12cfd3b0927..bd1d2a0e9203 100644
--- a/fs/smb/server/smb2pdu.h
+++ b/fs/smb/server/smb2pdu.h
@@ -72,6 +72,18 @@ struct create_durable_req_v2 {
 	__u8 CreateGuid[16];
 } __packed;
 
+struct create_durable_reconn_req {
+	struct create_context ccontext;
+	__u8   Name[8];
+	union {
+		__u8  Reserved[16];
+		struct {
+			__u64 PersistentFileId;
+			__u64 VolatileFileId;
+		} Fid;
+	} Data;
+} __packed;
+
 struct create_durable_reconn_v2_req {
 	struct create_context ccontext;
 	__u8   Name[8];
@@ -98,6 +110,9 @@ struct create_durable_rsp {
 	} Data;
 } __packed;
 
+/* See MS-SMB2 2.2.13.2.11 */
+/* Flags */
+#define SMB2_DHANDLE_FLAG_PERSISTENT	0x00000002
 struct create_durable_v2_rsp {
 	struct create_context ccontext;
 	__u8   Name[8];
diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
index 4e82ff627d12..030f70700036 100644
--- a/fs/smb/server/vfs_cache.c
+++ b/fs/smb/server/vfs_cache.c
@@ -305,7 +305,8 @@ static void __ksmbd_close_fd(struct ksmbd_file_table *ft, struct ksmbd_file *fp)
 
 	fd_limit_close();
 	__ksmbd_remove_durable_fd(fp);
-	__ksmbd_remove_fd(ft, fp);
+	if (ft)
+		__ksmbd_remove_fd(ft, fp);
 
 	close_id_del_oplock(fp);
 	filp = fp->filp;
@@ -465,11 +466,32 @@ struct ksmbd_file *ksmbd_lookup_fd_slow(struct ksmbd_work *work, u64 id,
 	return fp;
 }
 
-struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id)
+struct ksmbd_file *ksmbd_lookup_global_fd(unsigned long long id)
 {
 	return __ksmbd_lookup_fd(&global_ft, id);
 }
 
+struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id)
+{
+	struct ksmbd_file *fp;
+
+	fp = __ksmbd_lookup_fd(&global_ft, id);
+	if (fp && fp->conn) {
+		ksmbd_put_durable_fd(fp);
+		fp = NULL;
+	}
+
+	return fp;
+}
+
+void ksmbd_put_durable_fd(struct ksmbd_file *fp)
+{
+	if (!atomic_dec_and_test(&fp->refcount))
+		return;
+
+	__ksmbd_close_fd(NULL, fp);
+}
+
 struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid)
 {
 	struct ksmbd_file	*fp = NULL;
@@ -639,6 +661,32 @@ __close_file_table_ids(struct ksmbd_file_table *ft,
 	return num;
 }
 
+static inline bool is_reconnectable(struct ksmbd_file *fp)
+{
+	struct oplock_info *opinfo = opinfo_get(fp);
+	bool reconn = false;
+
+	if (!opinfo)
+		return false;
+
+	if (opinfo->op_state != OPLOCK_STATE_NONE) {
+		opinfo_put(opinfo);
+		return false;
+	}
+
+	if (fp->is_resilient || fp->is_persistent)
+		reconn = true;
+	else if (fp->is_durable && opinfo->is_lease &&
+		 opinfo->o_lease->state & SMB2_LEASE_HANDLE_CACHING_LE)
+		reconn = true;
+
+	else if (fp->is_durable && opinfo->level == SMB2_OPLOCK_LEVEL_BATCH)
+		reconn = true;
+
+	opinfo_put(opinfo);
+	return reconn;
+}
+
 static bool tree_conn_fd_check(struct ksmbd_tree_connect *tcon,
 			       struct ksmbd_file *fp)
 {
@@ -648,7 +696,28 @@ static bool tree_conn_fd_check(struct ksmbd_tree_connect *tcon,
 static bool session_fd_check(struct ksmbd_tree_connect *tcon,
 			     struct ksmbd_file *fp)
 {
-	return false;
+	struct ksmbd_inode *ci;
+	struct oplock_info *op;
+	struct ksmbd_conn *conn;
+
+	if (!is_reconnectable(fp))
+		return false;
+
+	conn = fp->conn;
+	ci = fp->f_ci;
+	write_lock(&ci->m_lock);
+	list_for_each_entry_rcu(op, &ci->m_op_list, op_entry) {
+		if (op->conn != conn)
+			continue;
+		op->conn = NULL;
+	}
+	write_unlock(&ci->m_lock);
+
+	fp->conn = NULL;
+	fp->tcon = NULL;
+	fp->volatile_id = KSMBD_NO_FID;
+
+	return true;
 }
 
 void ksmbd_close_tree_conn_fds(struct ksmbd_work *work)
@@ -687,6 +756,68 @@ void ksmbd_free_global_file_table(void)
 	ksmbd_destroy_file_table(&global_ft);
 }
 
+int ksmbd_validate_name_reconnect(struct ksmbd_share_config *share,
+				  struct ksmbd_file *fp, char *name)
+{
+	char *pathname, *ab_pathname;
+	int ret = 0;
+
+	pathname = kmalloc(PATH_MAX, GFP_KERNEL);
+	if (!pathname)
+		return -EACCES;
+
+	ab_pathname = d_path(&fp->filp->f_path, pathname, PATH_MAX);
+	if (IS_ERR(ab_pathname)) {
+		kfree(pathname);
+		return -EACCES;
+	}
+
+	if (name && strcmp(&ab_pathname[share->path_sz + 1], name)) {
+		ksmbd_debug(SMB, "invalid name reconnect %s\n", name);
+		ret = -EINVAL;
+	}
+
+	kfree(pathname);
+
+	return ret;
+}
+
+int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp)
+{
+	struct ksmbd_inode *ci;
+	struct oplock_info *op;
+
+	if (!fp->is_durable || fp->conn || fp->tcon) {
+		pr_err("Invalid durable fd [%p:%p]\n", fp->conn, fp->tcon);
+		return -EBADF;
+	}
+
+	if (has_file_id(fp->volatile_id)) {
+		pr_err("Still in use durable fd: %llu\n", fp->volatile_id);
+		return -EBADF;
+	}
+
+	fp->conn = work->conn;
+	fp->tcon = work->tcon;
+
+	ci = fp->f_ci;
+	write_lock(&ci->m_lock);
+	list_for_each_entry_rcu(op, &ci->m_op_list, op_entry) {
+		if (op->conn)
+			continue;
+		op->conn = fp->conn;
+	}
+	write_unlock(&ci->m_lock);
+
+	__open_id(&work->sess->file_table, fp, OPEN_ID_TYPE_VOLATILE_ID);
+	if (!has_file_id(fp->volatile_id)) {
+		fp->conn = NULL;
+		fp->tcon = NULL;
+		return -EBADF;
+	}
+	return 0;
+}
+
 int ksmbd_init_file_table(struct ksmbd_file_table *ft)
 {
 	ft->idr = kzalloc(sizeof(struct idr), GFP_KERNEL);
diff --git a/fs/smb/server/vfs_cache.h b/fs/smb/server/vfs_cache.h
index a528f0cc775a..ed44fb4e18e7 100644
--- a/fs/smb/server/vfs_cache.h
+++ b/fs/smb/server/vfs_cache.h
@@ -14,6 +14,7 @@
 #include <linux/workqueue.h>
 
 #include "vfs.h"
+#include "mgmt/share_config.h"
 
 /* Windows style file permissions for extended response */
 #define	FILE_GENERIC_ALL	0x1F01FF
@@ -106,6 +107,9 @@ struct ksmbd_file {
 	int				dot_dotdot[2];
 	unsigned int			f_state;
 	bool				reserve_lease_break;
+	bool				is_durable;
+	bool				is_persistent;
+	bool				is_resilient;
 };
 
 static inline void set_ctx_actor(struct dir_context *ctx,
@@ -141,7 +145,9 @@ struct ksmbd_file *ksmbd_lookup_fd_slow(struct ksmbd_work *work, u64 id,
 void ksmbd_fd_put(struct ksmbd_work *work, struct ksmbd_file *fp);
 struct ksmbd_inode *ksmbd_inode_lookup_lock(struct dentry *d);
 void ksmbd_inode_put(struct ksmbd_inode *ci);
+struct ksmbd_file *ksmbd_lookup_global_fd(unsigned long long id);
 struct ksmbd_file *ksmbd_lookup_durable_fd(unsigned long long id);
+void ksmbd_put_durable_fd(struct ksmbd_file *fp);
 struct ksmbd_file *ksmbd_lookup_fd_cguid(char *cguid);
 struct ksmbd_file *ksmbd_lookup_fd_inode(struct dentry *dentry);
 unsigned int ksmbd_open_durable_fd(struct ksmbd_file *fp);
@@ -173,6 +179,9 @@ void ksmbd_set_inode_pending_delete(struct ksmbd_file *fp);
 void ksmbd_clear_inode_pending_delete(struct ksmbd_file *fp);
 void ksmbd_fd_set_delete_on_close(struct ksmbd_file *fp,
 				  int file_info);
+int ksmbd_reopen_durable_fd(struct ksmbd_work *work, struct ksmbd_file *fp);
+int ksmbd_validate_name_reconnect(struct ksmbd_share_config *share,
+				  struct ksmbd_file *fp, char *name);
 int ksmbd_init_file_cache(void);
 void ksmbd_exit_file_cache(void);
 #endif /* __VFS_CACHE_H__ */
-- 
2.25.1


