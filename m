Return-Path: <linux-cifs+bounces-2637-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9667B96105B
	for <lists+linux-cifs@lfdr.de>; Tue, 27 Aug 2024 17:08:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 155941F2250F
	for <lists+linux-cifs@lfdr.de>; Tue, 27 Aug 2024 15:08:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17A011C3F19;
	Tue, 27 Aug 2024 15:08:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Wa5gs9ra"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC4CD1E520;
	Tue, 27 Aug 2024 15:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724771282; cv=none; b=CxigwGl90CjrdGdp1hLjtMm1+ZLPwNx5lW2Lxqh0vcR5vvyCTJAeKQqVF+aE9/877+r2iNRs6tglSL4dWl7NvaiszlYTIBwxnu2YMRgE+r4i28sNHgkWB5/G2FJrJ8suP7dXKwH3DX/xat8PGkZcqT+Wx4P7drtxTPOL+kHBQ8M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724771282; c=relaxed/simple;
	bh=SLubv5c9VOYfaS6rgYrnpkRlLQMg+y32UgBRW0m2St8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=A4t9/EsnWLMiwKo/U77odXVA0N1ECcskqP1LSm7Dv9joL402hex5dAwejJr9XgopSGnsu0bMydaOzEMYMUB8OJ3krHUiDAvaJRd01LC25rqG5cy8BW2YgGcrjfCQMrYmV1O/Z/N+Kz5JouPGgyMQv3flQY5YEgmW3Jt1GwhlAb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Wa5gs9ra; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C151C61074;
	Tue, 27 Aug 2024 15:08:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1724771281;
	bh=SLubv5c9VOYfaS6rgYrnpkRlLQMg+y32UgBRW0m2St8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Wa5gs9ra3YWNYsEmedTlOrwEE/OwR15CTKasAowFOnOqIeNn8aK+O9tzdUYv3eRGp
	 n/6oIGUvfUm1NMHeavuWyMZzqdyriVSe7kPsXzfoPDPYL8JvMMOQmXzU98Ae7uZfHf
	 DqmTPu+qsDqItHdGretCnSdudNL6ugWpS310KjJs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: stable@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	patches@lists.linux.dev,
	David Howells <dhowells@redhat.com>,
	"Paulo Alcantara (Red Hat)" <pc@manguebit.com>,
	Jeff Layton <jlayton@kernel.org>,
	linux-cifs@vger.kernel.org,
	netfs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.10 142/273] cifs: Add a tracepoint to track credits involved in R/W requests
Date: Tue, 27 Aug 2024 16:37:46 +0200
Message-ID: <20240827143838.811312861@linuxfoundation.org>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827143833.371588371@linuxfoundation.org>
References: <20240827143833.371588371@linuxfoundation.org>
User-Agent: quilt/0.67
X-stable: review
X-Patchwork-Hint: ignore
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

6.10-stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Howells <dhowells@redhat.com>

[ Upstream commit 519be989717c5bffaed1dc14a439e3872cb4bb8d ]

Add a tracepoint to track the credit changes and server in_flight value
involved in the lifetime of a R/W request, logging it against the
request/subreq debugging ID.  This requires the debugging IDs to be
recorded in the cifs_credits struct.

The tracepoint can be enabled with:

	echo 1 >/sys/kernel/debug/tracing/events/cifs/smb3_rw_credits/enable

Also add a three-state flag to struct cifs_credits to note if we're
interested in determining when the in_flight contribution ends and, if so,
to track whether we've decremented the contribution yet.

Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Steve French <stfrench@microsoft.com>
Stable-dep-of: 74c2ab6d653b ("smb/client: avoid possible NULL dereference in cifs_free_subrequest()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsglob.h  | 17 +++++++-----
 fs/smb/client/file.c      | 32 ++++++++++++++++++++++-
 fs/smb/client/smb1ops.c   |  2 +-
 fs/smb/client/smb2ops.c   | 42 ++++++++++++++++++++++++++----
 fs/smb/client/smb2pdu.c   | 40 +++++++++++++++++++++++++---
 fs/smb/client/trace.h     | 55 ++++++++++++++++++++++++++++++++++++++-
 fs/smb/client/transport.c |  8 +++---
 7 files changed, 173 insertions(+), 23 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index d4bcc7da700c6..0a271b9fbc622 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -290,7 +290,7 @@ struct smb_version_operations {
 	int (*check_receive)(struct mid_q_entry *, struct TCP_Server_Info *,
 			     bool);
 	void (*add_credits)(struct TCP_Server_Info *server,
-			    const struct cifs_credits *credits,
+			    struct cifs_credits *credits,
 			    const int optype);
 	void (*set_credits)(struct TCP_Server_Info *, const int);
 	int * (*get_credits_field)(struct TCP_Server_Info *, const int);
@@ -550,8 +550,8 @@ struct smb_version_operations {
 				size_t *, struct cifs_credits *);
 	/* adjust previously taken mtu credits to request size */
 	int (*adjust_credits)(struct TCP_Server_Info *server,
-			      struct cifs_credits *credits,
-			      const unsigned int payload_size);
+			      struct cifs_io_subrequest *subreq,
+			      unsigned int /*enum smb3_rw_credits_trace*/ trace);
 	/* check if we need to issue closedir */
 	bool (*dir_needs_close)(struct cifsFileInfo *);
 	long (*fallocate)(struct file *, struct cifs_tcon *, int, loff_t,
@@ -848,6 +848,9 @@ static inline void cifs_server_unlock(struct TCP_Server_Info *server)
 struct cifs_credits {
 	unsigned int value;
 	unsigned int instance;
+	unsigned int in_flight_check;
+	unsigned int rreq_debug_id;
+	unsigned int rreq_debug_index;
 };
 
 static inline unsigned int
@@ -873,7 +876,7 @@ has_credits(struct TCP_Server_Info *server, int *credits, int num_credits)
 }
 
 static inline void
-add_credits(struct TCP_Server_Info *server, const struct cifs_credits *credits,
+add_credits(struct TCP_Server_Info *server, struct cifs_credits *credits,
 	    const int optype)
 {
 	server->ops->add_credits(server, credits, optype);
@@ -897,11 +900,11 @@ set_credits(struct TCP_Server_Info *server, const int val)
 }
 
 static inline int
-adjust_credits(struct TCP_Server_Info *server, struct cifs_credits *credits,
-	       const unsigned int payload_size)
+adjust_credits(struct TCP_Server_Info *server, struct cifs_io_subrequest *subreq,
+	       unsigned int /* enum smb3_rw_credits_trace */ trace)
 {
 	return server->ops->adjust_credits ?
-		server->ops->adjust_credits(server, credits, payload_size) : 0;
+		server->ops->adjust_credits(server, subreq, trace) : 0;
 }
 
 static inline __le64
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 9e4f4e67768b9..b413cfef05422 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -80,6 +80,16 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 		return netfs_prepare_write_failed(subreq);
 	}
 
+	wdata->credits.rreq_debug_id = subreq->rreq->debug_id;
+	wdata->credits.rreq_debug_index = subreq->debug_index;
+	wdata->credits.in_flight_check = 1;
+	trace_smb3_rw_credits(wdata->rreq->debug_id,
+			      wdata->subreq.debug_index,
+			      wdata->credits.value,
+			      server->credits, server->in_flight,
+			      wdata->credits.value,
+			      cifs_trace_rw_credits_write_prepare);
+
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (server->smbd_conn)
 		subreq->max_nr_segs = server->smbd_conn->max_frmr_depth;
@@ -101,7 +111,7 @@ static void cifs_issue_write(struct netfs_io_subrequest *subreq)
 		goto fail;
 	}
 
-	rc = adjust_credits(wdata->server, &wdata->credits, wdata->subreq.len);
+	rc = adjust_credits(wdata->server, wdata, cifs_trace_rw_credits_issue_write_adjust);
 	if (rc)
 		goto fail;
 
@@ -163,7 +173,18 @@ static bool cifs_clamp_length(struct netfs_io_subrequest *subreq)
 		return false;
 	}
 
+	rdata->credits.in_flight_check = 1;
+	rdata->credits.rreq_debug_id = rreq->debug_id;
+	rdata->credits.rreq_debug_index = subreq->debug_index;
+
+	trace_smb3_rw_credits(rdata->rreq->debug_id,
+			      rdata->subreq.debug_index,
+			      rdata->credits.value,
+			      server->credits, server->in_flight, 0,
+			      cifs_trace_rw_credits_read_submit);
+
 	subreq->len = min_t(size_t, subreq->len, rsize);
+
 #ifdef CONFIG_CIFS_SMB_DIRECT
 	if (server->smbd_conn)
 		subreq->max_nr_segs = server->smbd_conn->max_frmr_depth;
@@ -295,6 +316,15 @@ static void cifs_free_subrequest(struct netfs_io_subrequest *subreq)
 #endif
 	}
 
+	if (rdata->credits.value != 0)
+		trace_smb3_rw_credits(rdata->rreq->debug_id,
+				      rdata->subreq.debug_index,
+				      rdata->credits.value,
+				      rdata->server ? rdata->server->credits : 0,
+				      rdata->server ? rdata->server->in_flight : 0,
+				      -rdata->credits.value,
+				      cifs_trace_rw_credits_free_subreq);
+
 	add_credits_and_wake_if(rdata->server, &rdata->credits, 0);
 	if (rdata->have_xid)
 		free_xid(rdata->xid);
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 212ec6f66ec65..e1f2feb56f45f 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -108,7 +108,7 @@ cifs_find_mid(struct TCP_Server_Info *server, char *buffer)
 
 static void
 cifs_add_credits(struct TCP_Server_Info *server,
-		 const struct cifs_credits *credits, const int optype)
+		 struct cifs_credits *credits, const int optype)
 {
 	spin_lock(&server->req_lock);
 	server->credits += credits->value;
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index c8e536540895a..7fe59235f0901 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -66,7 +66,7 @@ change_conf(struct TCP_Server_Info *server)
 
 static void
 smb2_add_credits(struct TCP_Server_Info *server,
-		 const struct cifs_credits *credits, const int optype)
+		 struct cifs_credits *credits, const int optype)
 {
 	int *val, rc = -1;
 	int scredits, in_flight;
@@ -94,7 +94,21 @@ smb2_add_credits(struct TCP_Server_Info *server,
 					    server->conn_id, server->hostname, *val,
 					    add, server->in_flight);
 	}
-	WARN_ON_ONCE(server->in_flight == 0);
+	if (credits->in_flight_check > 1) {
+		pr_warn_once("rreq R=%08x[%x] Credits not in flight\n",
+			     credits->rreq_debug_id, credits->rreq_debug_index);
+	} else {
+		credits->in_flight_check = 2;
+	}
+	if (WARN_ON_ONCE(server->in_flight == 0)) {
+		pr_warn_once("rreq R=%08x[%x] Zero in_flight\n",
+			     credits->rreq_debug_id, credits->rreq_debug_index);
+		trace_smb3_rw_credits(credits->rreq_debug_id,
+				      credits->rreq_debug_index,
+				      credits->value,
+				      server->credits, server->in_flight, 0,
+				      cifs_trace_rw_credits_zero_in_flight);
+	}
 	server->in_flight--;
 	if (server->in_flight == 0 &&
 	   ((optype & CIFS_OP_MASK) != CIFS_NEG_OP) &&
@@ -283,16 +297,23 @@ smb2_wait_mtu_credits(struct TCP_Server_Info *server, size_t size,
 
 static int
 smb2_adjust_credits(struct TCP_Server_Info *server,
-		    struct cifs_credits *credits,
-		    const unsigned int payload_size)
+		    struct cifs_io_subrequest *subreq,
+		    unsigned int /*enum smb3_rw_credits_trace*/ trace)
 {
-	int new_val = DIV_ROUND_UP(payload_size, SMB2_MAX_BUFFER_SIZE);
+	struct cifs_credits *credits = &subreq->credits;
+	int new_val = DIV_ROUND_UP(subreq->subreq.len, SMB2_MAX_BUFFER_SIZE);
 	int scredits, in_flight;
 
 	if (!credits->value || credits->value == new_val)
 		return 0;
 
 	if (credits->value < new_val) {
+		trace_smb3_rw_credits(subreq->rreq->debug_id,
+				      subreq->subreq.debug_index,
+				      credits->value,
+				      server->credits, server->in_flight,
+				      new_val - credits->value,
+				      cifs_trace_rw_credits_no_adjust_up);
 		trace_smb3_too_many_credits(server->CurrentMid,
 				server->conn_id, server->hostname, 0, credits->value - new_val, 0);
 		cifs_server_dbg(VFS, "request has less credits (%d) than required (%d)",
@@ -308,6 +329,12 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 		in_flight = server->in_flight;
 		spin_unlock(&server->req_lock);
 
+		trace_smb3_rw_credits(subreq->rreq->debug_id,
+				      subreq->subreq.debug_index,
+				      credits->value,
+				      server->credits, server->in_flight,
+				      new_val - credits->value,
+				      cifs_trace_rw_credits_old_session);
 		trace_smb3_reconnect_detected(server->CurrentMid,
 			server->conn_id, server->hostname, scredits,
 			credits->value - new_val, in_flight);
@@ -316,6 +343,11 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 		return -EAGAIN;
 	}
 
+	trace_smb3_rw_credits(subreq->rreq->debug_id,
+			      subreq->subreq.debug_index,
+			      credits->value,
+			      server->credits, server->in_flight,
+			      new_val - credits->value, trace);
 	server->credits += credits->value - new_val;
 	scredits = server->credits;
 	in_flight = server->in_flight;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 896147ba6660e..4cd5c33be2a1a 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -4505,8 +4505,15 @@ smb2_readv_callback(struct mid_q_entry *mid)
 	struct TCP_Server_Info *server = rdata->server;
 	struct smb2_hdr *shdr =
 				(struct smb2_hdr *)rdata->iov[0].iov_base;
-	struct cifs_credits credits = { .value = 0, .instance = 0 };
+	struct cifs_credits credits = {
+		.value = 0,
+		.instance = 0,
+		.rreq_debug_id = rdata->rreq->debug_id,
+		.rreq_debug_index = rdata->subreq.debug_index,
+	};
 	struct smb_rqst rqst = { .rq_iov = &rdata->iov[1], .rq_nvec = 1 };
+	unsigned int rreq_debug_id = rdata->rreq->debug_id;
+	unsigned int subreq_debug_index = rdata->subreq.debug_index;
 
 	if (rdata->got_bytes) {
 		rqst.rq_iter	  = rdata->subreq.io_iter;
@@ -4590,10 +4597,16 @@ smb2_readv_callback(struct mid_q_entry *mid)
 		if (rdata->subreq.start < rdata->subreq.rreq->i_size)
 			rdata->result = 0;
 	}
+	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, rdata->credits.value,
+			      server->credits, server->in_flight,
+			      0, cifs_trace_rw_credits_read_response_clear);
 	rdata->credits.value = 0;
 	INIT_WORK(&rdata->subreq.work, smb2_readv_worker);
 	queue_work(cifsiod_wq, &rdata->subreq.work);
 	release_mid(mid);
+	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
+			      server->credits, server->in_flight,
+			      credits.value, cifs_trace_rw_credits_read_response_add);
 	add_credits(server, &credits, 0);
 }
 
@@ -4650,7 +4663,7 @@ smb2_async_readv(struct cifs_io_subrequest *rdata)
 				min_t(int, server->max_credits -
 						server->credits, credit_request));
 
-		rc = adjust_credits(server, &rdata->credits, rdata->subreq.len);
+		rc = adjust_credits(server, rdata, cifs_trace_rw_credits_call_readv_adjust);
 		if (rc)
 			goto async_readv_out;
 
@@ -4769,7 +4782,14 @@ smb2_writev_callback(struct mid_q_entry *mid)
 	struct cifs_tcon *tcon = tlink_tcon(wdata->req->cfile->tlink);
 	struct TCP_Server_Info *server = wdata->server;
 	struct smb2_write_rsp *rsp = (struct smb2_write_rsp *)mid->resp_buf;
-	struct cifs_credits credits = { .value = 0, .instance = 0 };
+	struct cifs_credits credits = {
+		.value = 0,
+		.instance = 0,
+		.rreq_debug_id = wdata->rreq->debug_id,
+		.rreq_debug_index = wdata->subreq.debug_index,
+	};
+	unsigned int rreq_debug_id = wdata->rreq->debug_id;
+	unsigned int subreq_debug_index = wdata->subreq.debug_index;
 	ssize_t result = 0;
 	size_t written;
 
@@ -4840,9 +4860,15 @@ smb2_writev_callback(struct mid_q_entry *mid)
 				      tcon->tid, tcon->ses->Suid,
 				      wdata->subreq.start, wdata->subreq.len);
 
+	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, wdata->credits.value,
+			      server->credits, server->in_flight,
+			      0, cifs_trace_rw_credits_write_response_clear);
 	wdata->credits.value = 0;
 	cifs_write_subrequest_terminated(wdata, result ?: written, true);
 	release_mid(mid);
+	trace_smb3_rw_credits(rreq_debug_id, subreq_debug_index, 0,
+			      server->credits, server->in_flight,
+			      credits.value, cifs_trace_rw_credits_write_response_add);
 	add_credits(server, &credits, 0);
 }
 
@@ -4972,7 +4998,7 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 				min_t(int, server->max_credits -
 						server->credits, credit_request));
 
-		rc = adjust_credits(server, &wdata->credits, io_parms->length);
+		rc = adjust_credits(server, wdata, cifs_trace_rw_credits_call_writev_adjust);
 		if (rc)
 			goto async_writev_out;
 
@@ -4997,6 +5023,12 @@ smb2_async_writev(struct cifs_io_subrequest *wdata)
 	cifs_small_buf_release(req);
 out:
 	if (rc) {
+		trace_smb3_rw_credits(wdata->rreq->debug_id,
+				      wdata->subreq.debug_index,
+				      wdata->credits.value,
+				      server->credits, server->in_flight,
+				      -(int)wdata->credits.value,
+				      cifs_trace_rw_credits_write_response_clear);
 		add_credits_and_wake_if(wdata->server, &wdata->credits, 0);
 		cifs_write_subrequest_terminated(wdata, rc, true);
 	}
diff --git a/fs/smb/client/trace.h b/fs/smb/client/trace.h
index 36d47ce596317..36d5295c2a6f9 100644
--- a/fs/smb/client/trace.h
+++ b/fs/smb/client/trace.h
@@ -20,6 +20,22 @@
 /*
  * Specify enums for tracing information.
  */
+#define smb3_rw_credits_traces \
+	EM(cifs_trace_rw_credits_call_readv_adjust,	"rd-call-adj") \
+	EM(cifs_trace_rw_credits_call_writev_adjust,	"wr-call-adj") \
+	EM(cifs_trace_rw_credits_free_subreq,		"free-subreq") \
+	EM(cifs_trace_rw_credits_issue_read_adjust,	"rd-issu-adj") \
+	EM(cifs_trace_rw_credits_issue_write_adjust,	"wr-issu-adj") \
+	EM(cifs_trace_rw_credits_no_adjust_up,		"no-adj-up  ") \
+	EM(cifs_trace_rw_credits_old_session,		"old-session") \
+	EM(cifs_trace_rw_credits_read_response_add,	"rd-resp-add") \
+	EM(cifs_trace_rw_credits_read_response_clear,	"rd-resp-clr") \
+	EM(cifs_trace_rw_credits_read_submit,		"rd-submit  ") \
+	EM(cifs_trace_rw_credits_write_prepare,		"wr-prepare ") \
+	EM(cifs_trace_rw_credits_write_response_add,	"wr-resp-add") \
+	EM(cifs_trace_rw_credits_write_response_clear,	"wr-resp-clr") \
+	E_(cifs_trace_rw_credits_zero_in_flight,	"ZERO-IN-FLT")
+
 #define smb3_tcon_ref_traces					      \
 	EM(netfs_trace_tcon_ref_dec_dfs_refer,		"DEC DfsRef") \
 	EM(netfs_trace_tcon_ref_free,			"FRE       ") \
@@ -59,7 +75,8 @@
 #define EM(a, b) a,
 #define E_(a, b) a
 
-enum smb3_tcon_ref_trace { smb3_tcon_ref_traces } __mode(byte);
+enum smb3_rw_credits_trace	{ smb3_rw_credits_traces } __mode(byte);
+enum smb3_tcon_ref_trace	{ smb3_tcon_ref_traces } __mode(byte);
 
 #undef EM
 #undef E_
@@ -71,6 +88,7 @@ enum smb3_tcon_ref_trace { smb3_tcon_ref_traces } __mode(byte);
 #define EM(a, b) TRACE_DEFINE_ENUM(a);
 #define E_(a, b) TRACE_DEFINE_ENUM(a);
 
+smb3_rw_credits_traces;
 smb3_tcon_ref_traces;
 
 #undef EM
@@ -1316,6 +1334,41 @@ TRACE_EVENT(smb3_tcon_ref,
 		      __entry->ref)
 	    );
 
+TRACE_EVENT(smb3_rw_credits,
+	    TP_PROTO(unsigned int rreq_debug_id,
+		     unsigned int subreq_debug_index,
+		     unsigned int subreq_credits,
+		     unsigned int server_credits,
+		     int server_in_flight,
+		     int credit_change,
+		     enum smb3_rw_credits_trace trace),
+	    TP_ARGS(rreq_debug_id, subreq_debug_index, subreq_credits,
+		    server_credits, server_in_flight, credit_change, trace),
+	    TP_STRUCT__entry(
+		    __field(unsigned int, rreq_debug_id)
+		    __field(unsigned int, subreq_debug_index)
+		    __field(unsigned int, subreq_credits)
+		    __field(unsigned int, server_credits)
+		    __field(int,	  in_flight)
+		    __field(int,	  credit_change)
+		    __field(enum smb3_rw_credits_trace, trace)
+			     ),
+	    TP_fast_assign(
+		    __entry->rreq_debug_id	= rreq_debug_id;
+		    __entry->subreq_debug_index	= subreq_debug_index;
+		    __entry->subreq_credits	= subreq_credits;
+		    __entry->server_credits	= server_credits;
+		    __entry->in_flight		= server_in_flight;
+		    __entry->credit_change	= credit_change;
+		    __entry->trace		= trace;
+			   ),
+	    TP_printk("R=%08x[%x] %s cred=%u chg=%d pool=%u ifl=%d",
+		      __entry->rreq_debug_id, __entry->subreq_debug_index,
+		      __print_symbolic(__entry->trace, smb3_rw_credits_traces),
+		      __entry->subreq_credits, __entry->credit_change,
+		      __entry->server_credits, __entry->in_flight)
+	    );
+
 
 #undef EM
 #undef E_
diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index 012b9bd069952..adfe0d0587010 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -988,10 +988,10 @@ static void
 cifs_compound_callback(struct mid_q_entry *mid)
 {
 	struct TCP_Server_Info *server = mid->server;
-	struct cifs_credits credits;
-
-	credits.value = server->ops->get_credits(mid);
-	credits.instance = server->reconnect_instance;
+	struct cifs_credits credits = {
+		.value = server->ops->get_credits(mid),
+		.instance = server->reconnect_instance,
+	};
 
 	add_credits(server, &credits, mid->optype);
 
-- 
2.43.0




