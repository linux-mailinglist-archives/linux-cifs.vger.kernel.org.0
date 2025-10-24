Return-Path: <linux-cifs+bounces-7035-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A5E5C0429B
	for <lists+linux-cifs@lfdr.de>; Fri, 24 Oct 2025 04:49:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7CAF01AA0F28
	for <lists+linux-cifs@lfdr.de>; Fri, 24 Oct 2025 02:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C58D478F4B;
	Fri, 24 Oct 2025 02:49:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="c9YVMJfK"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D64B28DC4
	for <linux-cifs@vger.kernel.org>; Fri, 24 Oct 2025 02:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761274162; cv=none; b=p6bluZ/wVIiSxF2zgXrU2fxL9wJxLReaJFk+D3pbba+WURZEHOUAWEiOaZOdFYcMebA/DkvzQWxwsEjtONwwAFC0mDN+w+hsGKc2bv+X4cpxtqHCY+rNRAdY/0CLWnHEBjKc65OyjUdiOjqLwX2cQx1p11oJxRxXEHjpV+nugMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761274162; c=relaxed/simple;
	bh=jTYRvZbzsnG/Yqv5KUYcMiOMMdLlylr5eAFu0u0iM6Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BmC/C+CLZLAFo51qhR8sGYRHk6JAiwBUCgRf7IeoryRlspqPNSy/hVoXs9T1f5ApYCx981KICGpwBU7ezNhMc1w6910g26Z4wfGIlYu4SIUmoDlXkUk9q78GQN8nynMDj0PC46Q188a4eowprxhpbAgj8I9xOvU54vZ2Yhvd2Xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=c9YVMJfK; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Transfer-Encoding:MIME-Version:Message-ID:
	Date:Subject:Cc:To:From:Sender:Content-Type:Reply-To:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=N98CpJ2Wm42Gq1P+oPrWQ8khHyFKV1BfJDQmJAGHppM=; b=c9YVMJfK6wb1m5Uw8TMOdOE4q5
	8QuB0lSq1wWxhMl5SMcgXY7GWF6k8iOaSX2yMMIa1iUXdj9AE2xYpkp7T9VRy2mBACAk9XGTIaZcC
	URmYaJ2J6X8SUFsCjniU0pZpmRPH8mvUNLheIDNHZoxu0m9Or8++69NvXWDlCUB2p33ArxnQuhYEp
	Ch6f6y3c5ooNBd1yOQ2Nj3MLrW661bYja1zVSUSwo7ExQ/w9n9eyvxacliX75dPxV+9Su6gNRcBNX
	VQ9IIlo9JhBwgdZN0rIGClgCj1h98qmmg5YLBHUGNDLxbxbojyUAvCH78OgOxcbxfFxtgZdFTCsmP
	qDs714gw==;
Received: from pc by mx1.manguebit.org with local (Exim 4.98.2)
	id 1vC7rZ-00000000H6T-1tYD;
	Thu, 23 Oct 2025 23:49:09 -0300
From: Paulo Alcantara <pc@manguebit.org>
To: smfrench@gmail.com
Cc: Jay Shin <jaeshin@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.org>,
	David Howells <dhowells@redhat.com>,
	linux-cifs@vger.kernel.org
Subject: [PATCH] smb: client: handle lack of IPC in dfs_cache_refresh()
Date: Thu, 23 Oct 2025 23:49:09 -0300
Message-ID: <20251024024909.474285-1-pc@manguebit.org>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In very rare cases, DFS mounts could end up with SMB sessions without
any IPC connections.  These mounts are only possible when having
unexpired cached DFS referrals, hence not requiring any IPC
connections during the mount process.

Try to establish those missing IPC connections when refreshing DFS
referrals.  If the server is still rejecting it, then simply ignore
and leave expired cached DFS referral for any potential DFS failovers.

Reported-by: Jay Shin <jaeshin@redhat.com>
Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
Cc: David Howells <dhowells@redhat.com>
Cc: linux-cifs@vger.kernel.org
---
 fs/smb/client/cifsproto.h |  2 ++
 fs/smb/client/connect.c   | 35 +++++++++++++---------------
 fs/smb/client/dfs_cache.c | 49 ++++++++++++++++++++++++++++++++-------
 3 files changed, 59 insertions(+), 27 deletions(-)

diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index fb1813cbe0eb..3528c365a452 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -616,6 +616,8 @@ extern int E_md4hash(const unsigned char *passwd, unsigned char *p16,
 extern struct TCP_Server_Info *
 cifs_find_tcp_session(struct smb3_fs_context *ctx);
 
+struct cifs_tcon *cifs_setup_ipc(struct cifs_ses *ses, bool seal);
+
 void __cifs_put_smb_ses(struct cifs_ses *ses);
 
 extern struct cifs_ses *
diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 22f37ae7a66a..22699d75a0b3 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -2021,33 +2021,26 @@ static int match_session(struct cifs_ses *ses,
  * A new IPC connection is made and stored in the session
  * tcon_ipc. The IPC tcon has the same lifetime as the session.
  */
-static int
-cifs_setup_ipc(struct cifs_ses *ses, struct smb3_fs_context *ctx)
+struct cifs_tcon *cifs_setup_ipc(struct cifs_ses *ses, bool seal)
 {
 	int rc = 0, xid;
 	struct cifs_tcon *tcon;
 	char unc[SERVER_NAME_LENGTH + sizeof("//x/IPC$")] = {0};
-	bool seal = false;
 	struct TCP_Server_Info *server = ses->server;
 
 	/*
 	 * If the mount request that resulted in the creation of the
 	 * session requires encryption, force IPC to be encrypted too.
 	 */
-	if (ctx->seal) {
-		if (server->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION)
-			seal = true;
-		else {
-			cifs_server_dbg(VFS,
-				 "IPC: server doesn't support encryption\n");
-			return -EOPNOTSUPP;
-		}
+	if (seal && !(server->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION)) {
+		cifs_server_dbg(VFS, "IPC: server doesn't support encryption\n");
+		return ERR_PTR(-EOPNOTSUPP);
 	}
 
 	/* no need to setup directory caching on IPC share, so pass in false */
 	tcon = tcon_info_alloc(false, netfs_trace_tcon_ref_new_ipc);
 	if (tcon == NULL)
-		return -ENOMEM;
+		return ERR_PTR(-ENOMEM);
 
 	spin_lock(&server->srv_lock);
 	scnprintf(unc, sizeof(unc), "\\\\%s\\IPC$", server->hostname);
@@ -2057,13 +2050,13 @@ cifs_setup_ipc(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 	tcon->ses = ses;
 	tcon->ipc = true;
 	tcon->seal = seal;
-	rc = server->ops->tree_connect(xid, ses, unc, tcon, ctx->local_nls);
+	rc = server->ops->tree_connect(xid, ses, unc, tcon, ses->local_nls);
 	free_xid(xid);
 
 	if (rc) {
-		cifs_server_dbg(VFS, "failed to connect to IPC (rc=%d)\n", rc);
+		cifs_server_dbg(VFS | ONCE, "failed to connect to IPC (rc=%d)\n", rc);
 		tconInfoFree(tcon, netfs_trace_tcon_ref_free_ipc_fail);
-		goto out;
+		return ERR_PTR(rc);
 	}
 
 	cifs_dbg(FYI, "IPC tcon rc=%d ipc tid=0x%x\n", rc, tcon->tid);
@@ -2071,9 +2064,7 @@ cifs_setup_ipc(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 	spin_lock(&tcon->tc_lock);
 	tcon->status = TID_GOOD;
 	spin_unlock(&tcon->tc_lock);
-	ses->tcon_ipc = tcon;
-out:
-	return rc;
+	return tcon;
 }
 
 static struct cifs_ses *
@@ -2347,6 +2338,7 @@ cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 {
 	struct sockaddr_in6 *addr6 = (struct sockaddr_in6 *)&server->dstaddr;
 	struct sockaddr_in *addr = (struct sockaddr_in *)&server->dstaddr;
+	struct cifs_tcon *ipc;
 	struct cifs_ses *ses;
 	unsigned int xid;
 	int retries = 0;
@@ -2525,7 +2517,12 @@ cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 	list_add(&ses->smb_ses_list, &server->smb_ses_list);
 	spin_unlock(&cifs_tcp_ses_lock);
 
-	cifs_setup_ipc(ses, ctx);
+	ipc = cifs_setup_ipc(ses, ctx->seal);
+	spin_lock(&cifs_tcp_ses_lock);
+	spin_lock(&ses->ses_lock);
+	ses->tcon_ipc = !IS_ERR(ipc) ? ipc : NULL;
+	spin_unlock(&ses->ses_lock);
+	spin_unlock(&cifs_tcp_ses_lock);
 
 	free_xid(xid);
 
diff --git a/fs/smb/client/dfs_cache.c b/fs/smb/client/dfs_cache.c
index 4dada26d56b5..7ed073a6af85 100644
--- a/fs/smb/client/dfs_cache.c
+++ b/fs/smb/client/dfs_cache.c
@@ -1120,24 +1120,57 @@ static bool target_share_equal(struct cifs_tcon *tcon, const char *s1)
 	return match;
 }
 
-static bool is_ses_good(struct cifs_ses *ses)
+static bool is_ses_good(struct cifs_tcon *tcon, struct cifs_ses *ses)
 {
 	struct TCP_Server_Info *server = ses->server;
-	struct cifs_tcon *tcon = ses->tcon_ipc;
+	struct cifs_tcon *ipc = NULL;
 	bool ret;
 
+	spin_lock(&cifs_tcp_ses_lock);
 	spin_lock(&ses->ses_lock);
 	spin_lock(&ses->chan_lock);
+
 	ret = !cifs_chan_needs_reconnect(ses, server) &&
-		ses->ses_status == SES_GOOD &&
-		!tcon->need_reconnect;
+		ses->ses_status == SES_GOOD;
+
 	spin_unlock(&ses->chan_lock);
+
+	if (!ret)
+		goto out;
+
+	if (likely(ses->tcon_ipc)) {
+		if (ses->tcon_ipc->need_reconnect) {
+			ret = false;
+			goto out;
+		}
+	} else {
+		spin_unlock(&ses->ses_lock);
+		spin_unlock(&cifs_tcp_ses_lock);
+
+		ipc = cifs_setup_ipc(ses, tcon->seal);
+
+		spin_lock(&cifs_tcp_ses_lock);
+		spin_lock(&ses->ses_lock);
+		if (!IS_ERR(ipc)) {
+			if (!ses->tcon_ipc) {
+				ses->tcon_ipc = ipc;
+				ipc = NULL;
+			}
+		} else {
+			ret = false;
+			ipc = NULL;
+		}
+	}
+
+out:
 	spin_unlock(&ses->ses_lock);
+	spin_unlock(&cifs_tcp_ses_lock);
+	tconInfoFree(ipc, netfs_trace_tcon_ref_free_ipc);
 	return ret;
 }
 
 /* Refresh dfs referral of @ses */
-static void refresh_ses_referral(struct cifs_ses *ses)
+static void refresh_ses_referral(struct cifs_tcon *tcon, struct cifs_ses *ses)
 {
 	struct cache_entry *ce;
 	unsigned int xid;
@@ -1153,7 +1186,7 @@ static void refresh_ses_referral(struct cifs_ses *ses)
 	}
 
 	ses = CIFS_DFS_ROOT_SES(ses);
-	if (!is_ses_good(ses)) {
+	if (!is_ses_good(tcon, ses)) {
 		cifs_dbg(FYI, "%s: skip cache refresh due to disconnected ipc\n",
 			 __func__);
 		goto out;
@@ -1241,7 +1274,7 @@ static void refresh_tcon_referral(struct cifs_tcon *tcon, bool force_refresh)
 	up_read(&htable_rw_lock);
 
 	ses = CIFS_DFS_ROOT_SES(ses);
-	if (!is_ses_good(ses)) {
+	if (!is_ses_good(tcon, ses)) {
 		cifs_dbg(FYI, "%s: skip cache refresh due to disconnected ipc\n",
 			 __func__);
 		goto out;
@@ -1309,7 +1342,7 @@ void dfs_cache_refresh(struct work_struct *work)
 	tcon = container_of(work, struct cifs_tcon, dfs_cache_work.work);
 
 	list_for_each_entry(ses, &tcon->dfs_ses_list, dlist)
-		refresh_ses_referral(ses);
+		refresh_ses_referral(tcon, ses);
 	refresh_tcon_referral(tcon, false);
 
 	queue_delayed_work(dfscache_wq, &tcon->dfs_cache_work,
-- 
2.51.0


