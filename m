Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4FDE0B8A4E
	for <lists+linux-cifs@lfdr.de>; Fri, 20 Sep 2019 07:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437190AbfITFBj (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 20 Sep 2019 01:01:39 -0400
Received: from mx2.suse.de ([195.135.220.15]:48832 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725781AbfITFBj (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 20 Sep 2019 01:01:39 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 5908BAF84;
        Fri, 20 Sep 2019 05:01:37 +0000 (UTC)
From:   Aurelien Aptel <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH v4 2/6] cifs: add server param
Date:   Fri, 20 Sep 2019 07:01:15 +0200
Message-Id: <20190920050119.27017-3-aaptel@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190920050119.27017-1-aaptel@suse.com>
References: <20190920050119.27017-1-aaptel@suse.com>
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

pass server pointer instead of using ses-server

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 fs/cifs/cifsglob.h      |  3 ++-
 fs/cifs/cifsproto.h     |  1 +
 fs/cifs/smb2proto.h     |  3 ++-
 fs/cifs/smb2transport.c | 24 ++++++++++++------------
 fs/cifs/transport.c     |  4 ++--
 5 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 2418a1948321..e980e7b0d79d 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -230,7 +230,8 @@ struct smb_version_operations {
 	bool (*compare_fids)(struct cifsFileInfo *, struct cifsFileInfo *);
 	/* setup request: allocate mid, sign message */
 	struct mid_q_entry *(*setup_request)(struct cifs_ses *,
-						struct smb_rqst *);
+					     struct TCP_Server_Info *,
+					     struct smb_rqst *);
 	/* setup async request: allocate mid, sign message */
 	struct mid_q_entry *(*setup_async_request)(struct TCP_Server_Info *,
 						struct smb_rqst *);
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 99b1b1ef558c..ee3e6d6556a7 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -109,6 +109,7 @@ extern int SendReceive(const unsigned int /* xid */ , struct cifs_ses *,
 extern int SendReceiveNoRsp(const unsigned int xid, struct cifs_ses *ses,
 			    char *in_buf, int flags);
 extern struct mid_q_entry *cifs_setup_request(struct cifs_ses *,
+				struct TCP_Server_Info *,
 				struct smb_rqst *);
 extern struct mid_q_entry *cifs_setup_async_request(struct TCP_Server_Info *,
 						struct smb_rqst *);
diff --git a/fs/cifs/smb2proto.h b/fs/cifs/smb2proto.h
index 67a91b11fd59..804b6dc5546b 100644
--- a/fs/cifs/smb2proto.h
+++ b/fs/cifs/smb2proto.h
@@ -46,7 +46,8 @@ extern int smb2_verify_signature(struct smb_rqst *, struct TCP_Server_Info *);
 extern int smb2_check_receive(struct mid_q_entry *mid,
 			      struct TCP_Server_Info *server, bool log_error);
 extern struct mid_q_entry *smb2_setup_request(struct cifs_ses *ses,
-			      struct smb_rqst *rqst);
+					      struct TCP_Server_Info *,
+					      struct smb_rqst *rqst);
 extern struct mid_q_entry *smb2_setup_async_request(
 			struct TCP_Server_Info *server, struct smb_rqst *rqst);
 extern struct cifs_ses *smb2_find_smb_ses(struct TCP_Server_Info *server,
diff --git a/fs/cifs/smb2transport.c b/fs/cifs/smb2transport.c
index 148d7942c796..d7d89741f3f0 100644
--- a/fs/cifs/smb2transport.c
+++ b/fs/cifs/smb2transport.c
@@ -610,18 +610,18 @@ smb2_mid_entry_alloc(const struct smb2_sync_hdr *shdr,
 }
 
 static int
-smb2_get_mid_entry(struct cifs_ses *ses, struct smb2_sync_hdr *shdr,
+smb2_get_mid_entry(struct cifs_ses *ses, struct TCP_Server_Info *server, struct smb2_sync_hdr *shdr,
 		   struct mid_q_entry **mid)
 {
-	if (ses->server->tcpStatus == CifsExiting)
+	if (server->tcpStatus == CifsExiting)
 		return -ENOENT;
 
-	if (ses->server->tcpStatus == CifsNeedReconnect) {
+	if (server->tcpStatus == CifsNeedReconnect) {
 		cifs_dbg(FYI, "tcp session dead - return to caller to retry\n");
 		return -EAGAIN;
 	}
 
-	if (ses->server->tcpStatus == CifsNeedNegotiate &&
+	if (server->tcpStatus == CifsNeedNegotiate &&
 	   shdr->Command != SMB2_NEGOTIATE)
 		return -EAGAIN;
 
@@ -638,11 +638,11 @@ smb2_get_mid_entry(struct cifs_ses *ses, struct smb2_sync_hdr *shdr,
 		/* else ok - we are shutting down the session */
 	}
 
-	*mid = smb2_mid_entry_alloc(shdr, ses->server);
+	*mid = smb2_mid_entry_alloc(shdr, server);
 	if (*mid == NULL)
 		return -ENOMEM;
 	spin_lock(&GlobalMid_Lock);
-	list_add_tail(&(*mid)->qhead, &ses->server->pending_mid_q);
+	list_add_tail(&(*mid)->qhead, &server->pending_mid_q);
 	spin_unlock(&GlobalMid_Lock);
 
 	return 0;
@@ -675,24 +675,24 @@ smb2_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *server,
 }
 
 struct mid_q_entry *
-smb2_setup_request(struct cifs_ses *ses, struct smb_rqst *rqst)
+smb2_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *server, struct smb_rqst *rqst)
 {
 	int rc;
 	struct smb2_sync_hdr *shdr =
 			(struct smb2_sync_hdr *)rqst->rq_iov[0].iov_base;
 	struct mid_q_entry *mid;
 
-	smb2_seq_num_into_buf(ses->server, shdr);
+	smb2_seq_num_into_buf(server, shdr);
 
-	rc = smb2_get_mid_entry(ses, shdr, &mid);
+	rc = smb2_get_mid_entry(ses, server, shdr, &mid);
 	if (rc) {
-		revert_current_mid_from_hdr(ses->server, shdr);
+		revert_current_mid_from_hdr(server, shdr);
 		return ERR_PTR(rc);
 	}
 
-	rc = smb2_sign_rqst(rqst, ses->server);
+	rc = smb2_sign_rqst(rqst, server);
 	if (rc) {
-		revert_current_mid_from_hdr(ses->server, shdr);
+		revert_current_mid_from_hdr(server, shdr);
 		cifs_delete_mid(mid);
 		return ERR_PTR(rc);
 	}
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 308ad0f495e1..afe66f9cb15e 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -923,7 +923,7 @@ cifs_check_receive(struct mid_q_entry *mid, struct TCP_Server_Info *server,
 }
 
 struct mid_q_entry *
-cifs_setup_request(struct cifs_ses *ses, struct smb_rqst *rqst)
+cifs_setup_request(struct cifs_ses *ses, struct TCP_Server_Info *ignored, struct smb_rqst *rqst)
 {
 	int rc;
 	struct smb_hdr *hdr = (struct smb_hdr *)rqst->rq_iov[0].iov_base;
@@ -1040,7 +1040,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 	}
 
 	for (i = 0; i < num_rqst; i++) {
-		midQ[i] = server->ops->setup_request(ses, &rqst[i]);
+		midQ[i] = server->ops->setup_request(ses, server, &rqst[i]);
 		if (IS_ERR(midQ[i])) {
 			revert_current_mid(server, i);
 			for (j = 0; j < i; j++)
-- 
2.16.4

