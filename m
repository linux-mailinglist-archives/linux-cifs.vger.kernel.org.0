Return-Path: <linux-cifs+bounces-6520-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B3F97BA959C
	for <lists+linux-cifs@lfdr.de>; Mon, 29 Sep 2025 15:30:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6A0C93A6658
	for <lists+linux-cifs@lfdr.de>; Mon, 29 Sep 2025 13:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DABA307AD5;
	Mon, 29 Sep 2025 13:29:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hcVaWG3q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DQNrD7eD";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="hcVaWG3q";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="DQNrD7eD"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.223.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9E23074B7
	for <linux-cifs@vger.kernel.org>; Mon, 29 Sep 2025 13:29:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.135.223.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759152584; cv=none; b=BiArcoy6+Li1wZeuYNxv6OaJhwBLHxBVTsn0jN0ye4vsQwG+hAGW2PnvZHU87ZtuJ4zr4adxhOxNTg5CNlYmdHzn22hX8BD17yDyOwWNd0UeVX2vdKSeFf3vZpNpGvQUG4dIojjGPveSkmweDehf/K49TPw5fyymcc4mRn03XUM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759152584; c=relaxed/simple;
	bh=4Gavgn5QITpZDuLzkvXczKBFopEDHFmF7AXtzIXXx64=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Yd75UG+9pGuH+c+DslOhHpXgSEEwUPpxTWukUBVC0vwW1d/cKq/R1WfbBmiOyWBppXVxB7uDkP1m2jfzPLddTms6DBFMciZEDa62kqS62OyrJ5zobZXVD8QnDVMsPc6OS9VfjEKdJWiCudgk7JpmosKoNxYeAlnbelxDbOlIwIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de; spf=pass smtp.mailfrom=suse.de; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hcVaWG3q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DQNrD7eD; dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b=hcVaWG3q; dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b=DQNrD7eD; arc=none smtp.client-ip=195.135.223.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=suse.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.de
Received: from imap1.dmz-prg2.suse.org (imap1.dmz-prg2.suse.org [IPv6:2a07:de40:b281:104:10:150:64:97])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out1.suse.de (Postfix) with ESMTPS id 985AA2DABA;
	Mon, 29 Sep 2025 13:29:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759152577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D63ufxKtwColbSjfI9FJPUXeR810ZVVq/zp1+H8wTd0=;
	b=hcVaWG3qemrWAvDHdmZ5L3y2h/3wKgoJRJuDKutCey/4aP3MnaKQ9UdMPkRwBLFsM/ey8w
	giaQPewSnXJxcaZVBdK/QkaomHgPxot3qG1/nT6l+o2de7EEwlyedBrJe6MD4Bdfg5ZzcG
	fD77k+tTqz5OTi5O52V+6jQVIy/t6EQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759152577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D63ufxKtwColbSjfI9FJPUXeR810ZVVq/zp1+H8wTd0=;
	b=DQNrD7eDq5/C0ex7oKB9RxN01YSppQKKF9OFlW6H2E2jW5/KuOHgcaBY01RBVAbrYvFSY0
	UrfKMjrvDf6y/ZCg==
Authentication-Results: smtp-out1.suse.de;
	dkim=pass header.d=suse.de header.s=susede2_rsa header.b=hcVaWG3q;
	dkim=pass header.d=suse.de header.s=susede2_ed25519 header.b=DQNrD7eD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1759152577; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D63ufxKtwColbSjfI9FJPUXeR810ZVVq/zp1+H8wTd0=;
	b=hcVaWG3qemrWAvDHdmZ5L3y2h/3wKgoJRJuDKutCey/4aP3MnaKQ9UdMPkRwBLFsM/ey8w
	giaQPewSnXJxcaZVBdK/QkaomHgPxot3qG1/nT6l+o2de7EEwlyedBrJe6MD4Bdfg5ZzcG
	fD77k+tTqz5OTi5O52V+6jQVIy/t6EQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1759152577;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=D63ufxKtwColbSjfI9FJPUXeR810ZVVq/zp1+H8wTd0=;
	b=DQNrD7eDq5/C0ex7oKB9RxN01YSppQKKF9OFlW6H2E2jW5/KuOHgcaBY01RBVAbrYvFSY0
	UrfKMjrvDf6y/ZCg==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id 2590713782;
	Mon, 29 Sep 2025 13:29:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
	by imap1.dmz-prg2.suse.org with ESMTPSA
	id RLh5N8CJ2mgbHAAAD6G6ig
	(envelope-from <ematsumiya@suse.de>); Mon, 29 Sep 2025 13:29:36 +0000
From: Enzo Matsumiya <ematsumiya@suse.de>
To: linux-cifs@vger.kernel.org
Cc: smfrench@gmail.com,
	pc@manguebit.com,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	henrique.carvalho@suse.com
Subject: [PATCH 17/20] smb: client: use cached dir on queryfs/smb2_compound_op
Date: Mon, 29 Sep 2025 10:28:02 -0300
Message-ID: <20250929132805.220558-18-ematsumiya@suse.de>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250929132805.220558-1-ematsumiya@suse.de>
References: <20250929132805.220558-1-ematsumiya@suse.de>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-3.01 / 50.00];
	BAYES_HAM(-3.00)[100.00%];
	NEURAL_HAM_LONG(-1.00)[-1.000];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	NEURAL_HAM_SHORT(-0.20)[-1.000];
	MIME_GOOD(-0.10)[text/plain];
	MX_GOOD(-0.01)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	MIME_TRACE(0.00)[0:+];
	ARC_NA(0.00)[];
	TO_MATCH_ENVRCPT_ALL(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,manguebit.com,microsoft.com,talpey.com,suse.com];
	RBL_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	RCVD_TLS_ALL(0.00)[];
	DKIM_TRACE(0.00)[suse.de:+];
	R_RATELIMIT(0.00)[to_ip_from(RL73jpmmudngk8cygugnauyh74)];
	RCVD_COUNT_TWO(0.00)[2];
	TO_DN_NONE(0.00)[];
	FROM_EQ_ENVFROM(0.00)[];
	FROM_HAS_DN(0.00)[];
	SPAMHAUS_XBL(0.00)[2a07:de40:b281:104:10:150:64:97:from];
	DNSWL_BLOCKED(0.00)[2a07:de40:b281:104:10:150:64:97:from,2a07:de40:b281:106:10:150:64:167:received];
	RCPT_COUNT_SEVEN(0.00)[8];
	DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,suse.de:dkim,suse.de:email,imap1.dmz-prg2.suse.org:helo,imap1.dmz-prg2.suse.org:rdns];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	RECEIVED_SPAMHAUS_BLOCKED_OPENRESOLVER(0.00)[2a07:de40:b281:106:10:150:64:167:received];
	FREEMAIL_ENVRCPT(0.00)[gmail.com]
X-Spam-Flag: NO
X-Spam-Level: 
X-Rspamd-Queue-Id: 985AA2DABA
X-Rspamd-Server: rspamd2.dmz-prg2.suse.org
X-Rspamd-Action: no action
X-Spam-Score: -3.01

A dentry is passed to cifs_statfs(), so pass down d_is_dir() to
smb2_queryfs() so we can cache/reuse this dir.

Other:
- make smb2_compound_op a static function, as it's not used anywhere
  else

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 fs/smb/client/cifsfs.c    |  2 +-
 fs/smb/client/cifsglob.h  |  2 +-
 fs/smb/client/smb1ops.c   |  2 +-
 fs/smb/client/smb2ops.c   | 32 +++++++++++++++++---------------
 fs/smb/client/smb2proto.h |  6 ------
 5 files changed, 20 insertions(+), 24 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index e1848276bab4..a2ecc5649860 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -339,7 +339,7 @@ cifs_statfs(struct dentry *dentry, struct kstatfs *buf)
 	buf->f_ffree = 0;	/* unlimited */
 
 	if (server->ops->queryfs)
-		rc = server->ops->queryfs(xid, tcon, full_path, cifs_sb, buf);
+		rc = server->ops->queryfs(xid, tcon, full_path, cifs_sb, buf, d_is_dir(dentry));
 
 statfs_out:
 	free_dentry_path(page);
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 08c8131c8018..dddac55abd6f 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -519,7 +519,7 @@ struct smb_version_operations {
 			__u16 net_fid, struct cifsInodeInfo *cifs_inode);
 	/* query remote filesystem */
 	int (*queryfs)(const unsigned int, struct cifs_tcon *,
-		       const char *, struct cifs_sb_info *, struct kstatfs *);
+		       const char *, struct cifs_sb_info *, struct kstatfs *, bool);
 	/* send mandatory brlock to the server */
 	int (*mand_lock)(const unsigned int, struct cifsFileInfo *, __u64,
 			 __u64, __u32, int, int, bool);
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index d964bc9c2823..9fa1ff9ea70d 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -1105,7 +1105,7 @@ cifs_oplock_response(struct cifs_tcon *tcon, __u64 persistent_fid,
 
 static int
 cifs_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
-	     const char *path, struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
+	     const char *path, struct cifs_sb_info *cifs_sb, struct kstatfs *buf, bool is_dir)
 {
 	int rc = -EOPNOTSUPP;
 
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 8842315d2526..f691271463b5 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -1110,6 +1110,11 @@ move_smb2_ea_to_cifs(char *dst, size_t dst_size,
 	return (ssize_t)rc;
 }
 
+static int smb2_query_info_compound(const unsigned int xid, struct cifs_tcon *tcon,
+				    const char *path, u32 desired_access, u32 class, u32 type,
+				    u32 output_len, struct kvec *rsp, int *buftype,
+				    struct cifs_sb_info *cifs_sb, bool is_dir);
+
 static ssize_t
 smb2_query_eas(const unsigned int xid, struct cifs_tcon *tcon,
 	       const unsigned char *path, const unsigned char *ea_name,
@@ -1129,7 +1134,7 @@ smb2_query_eas(const unsigned int xid, struct cifs_tcon *tcon,
 				      CIFSMaxBufSize -
 				      MAX_SMB2_CREATE_RESPONSE_SIZE -
 				      MAX_SMB2_CLOSE_RESPONSE_SIZE,
-				      &rsp_iov, &buftype, cifs_sb);
+				      &rsp_iov, &buftype, cifs_sb, false);
 	if (rc) {
 		/*
 		 * If ea_name is NULL (listxattr) and there are no EAs,
@@ -1231,7 +1236,7 @@ smb2_set_ea(const unsigned int xid, struct cifs_tcon *tcon,
 				      CIFSMaxBufSize -
 				      MAX_SMB2_CREATE_RESPONSE_SIZE -
 				      MAX_SMB2_CLOSE_RESPONSE_SIZE,
-				      &rsp_iov[1], &resp_buftype[1], cifs_sb);
+				      &rsp_iov[1], &resp_buftype[1], cifs_sb, false);
 			if (rc == 0) {
 				rsp = (struct smb2_query_info_rsp *)rsp_iov[1].iov_base;
 				used_len = le32_to_cpu(rsp->OutputBufferLength);
@@ -2694,12 +2699,10 @@ bool smb2_should_replay(struct cifs_tcon *tcon,
  * Passes the query info response back to the caller on success.
  * Caller need to free this with free_rsp_buf().
  */
-int
-smb2_query_info_compound(const unsigned int xid, struct cifs_tcon *tcon,
-			 const char *path, u32 desired_access,
-			 u32 class, u32 type, u32 output_len,
-			 struct kvec *rsp, int *buftype,
-			 struct cifs_sb_info *cifs_sb)
+static int smb2_query_info_compound(const unsigned int xid, struct cifs_tcon *tcon,
+				    const char *path, u32 desired_access, u32 class, u32 type,
+				    u32 output_len, struct kvec *rsp, int *buftype,
+				    struct cifs_sb_info *cifs_sb, bool is_dir)
 {
 	struct smb2_compound_vars *vars;
 	struct cifs_ses *ses = tcon->ses;
@@ -2741,9 +2744,9 @@ smb2_query_info_compound(const unsigned int xid, struct cifs_tcon *tcon,
 	rsp_iov = vars->rsp_iov;
 
 	/*
-	 * We can only call this for things we know are directories.
+	 * We can only open + cache paths we know are directories.
 	 */
-	if (!strcmp(path, ""))
+	if (is_dir)
 		/* cfid null if open dir failed */
 		open_cached_dir(xid, tcon, path, cifs_sb, &cfid);
 
@@ -2852,7 +2855,7 @@ smb2_query_info_compound(const unsigned int xid, struct cifs_tcon *tcon,
 
 static int
 smb2_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
-	     const char *path, struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
+	     const char *path, struct cifs_sb_info *cifs_sb, struct kstatfs *buf, bool is_dir)
 {
 	struct smb2_query_info_rsp *rsp;
 	struct smb2_fs_full_size_info *info = NULL;
@@ -2860,13 +2863,12 @@ smb2_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
 	int buftype = CIFS_NO_BUFFER;
 	int rc;
 
-
 	rc = smb2_query_info_compound(xid, tcon, path,
 				      FILE_READ_ATTRIBUTES,
 				      FS_FULL_SIZE_INFORMATION,
 				      SMB2_O_INFO_FILESYSTEM,
 				      sizeof(struct smb2_fs_full_size_info),
-				      &rsp_iov, &buftype, cifs_sb);
+				      &rsp_iov, &buftype, cifs_sb, is_dir);
 	if (rc)
 		goto qfs_exit;
 
@@ -2889,7 +2891,7 @@ smb2_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
 
 static int
 smb311_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
-	       const char *path, struct cifs_sb_info *cifs_sb, struct kstatfs *buf)
+	       const char *path, struct cifs_sb_info *cifs_sb, struct kstatfs *buf, bool is_dir)
 {
 	int rc;
 	__le16 *utf16_path = NULL;
@@ -2898,7 +2900,7 @@ smb311_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
 	struct cifs_fid fid;
 
 	if (!tcon->posix_extensions)
-		return smb2_queryfs(xid, tcon, path, cifs_sb, buf);
+		return smb2_queryfs(xid, tcon, path, cifs_sb, buf, is_dir);
 
 	oparms = (struct cifs_open_parms) {
 		.tcon = tcon,
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 3e3faa7cf633..99326810a159 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -299,12 +299,6 @@ extern int smb311_crypto_shash_allocate(struct TCP_Server_Info *server);
 extern int smb311_update_preauth_hash(struct cifs_ses *ses,
 				      struct TCP_Server_Info *server,
 				      struct kvec *iov, int nvec);
-extern int smb2_query_info_compound(const unsigned int xid,
-				    struct cifs_tcon *tcon,
-				    const char *path, u32 desired_access,
-				    u32 class, u32 type, u32 output_len,
-				    struct kvec *rsp, int *buftype,
-				    struct cifs_sb_info *cifs_sb);
 /* query path info from the server using SMB311 POSIX extensions*/
 int smb311_posix_query_path_info(const unsigned int xid,
 				 struct cifs_tcon *tcon,
-- 
2.49.0


