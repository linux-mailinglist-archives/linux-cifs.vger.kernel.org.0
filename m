Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E374F57A569
	for <lists+linux-cifs@lfdr.de>; Tue, 19 Jul 2022 19:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238018AbiGSRck (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 19 Jul 2022 13:32:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239193AbiGSRci (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 19 Jul 2022 13:32:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C25D56BAD
        for <linux-cifs@vger.kernel.org>; Tue, 19 Jul 2022 10:32:36 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 42E2034079;
        Tue, 19 Jul 2022 17:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658251955; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YaA8BBRXVZ4+Oc97Wi+JnsOsDyqEaiurQ0K4DJJjs9Y=;
        b=UQItO/8+zQKfZgzwsIXIiVcQie/1gubB3JSYV1zVYbg6HOh7aBMfWeft0eZMSoWB/VI+38
        Y9xb+qe2xMfr4ZdCthMS5J5ejPTTrCNulxzCu6E1waj0ARjplkXU3wngU1+/J2lIPObyXI
        gSQHC90TrQYr29oe+QyLZ4sEXQYXZy0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658251955;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=YaA8BBRXVZ4+Oc97Wi+JnsOsDyqEaiurQ0K4DJJjs9Y=;
        b=onlE+PBsiHf0UpojSfi1W6s65DK7Jz48Fr8UO3dXuWSGem+1o21ARRS6KjWSBqbbBwibxn
        F9xq2ndbccbvvnDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id B5B6413488;
        Tue, 19 Jul 2022 17:32:34 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id RC+OHbLq1mJCQwAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Tue, 19 Jul 2022 17:32:34 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, pc@cjr.nz, ronniesahlberg@gmail.com,
        nspmangalore@gmail.com, Enzo Matsumiya <ematsumiya@suse.de>
Subject: [PATCH] smb2: simplify mid handling/dequeueing code
Date:   Tue, 19 Jul 2022 14:31:50 -0300
Message-Id: <20220719173151.12068-1-ematsumiya@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Mostly a code cleanup, aiming to simplify handle_mid(), dequeue_mid(),
and smb2_find_mid(), and their callers.

Also remove the @malformed parameter from those and their callers, since
the mid_state was already known beforehand.

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 fs/cifs/cifsglob.h  |   3 +-
 fs/cifs/cifsproto.h |   2 +-
 fs/cifs/cifssmb.c   |  33 ++++-----
 fs/cifs/connect.c   |  46 ++++++------
 fs/cifs/smb1ops.c   |  12 ++--
 fs/cifs/smb2misc.c  |  18 +++--
 fs/cifs/smb2ops.c   | 168 +++++++++++++++++---------------------------
 7 files changed, 118 insertions(+), 164 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index a643c84ff1e9..ae57ede51cd3 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -283,8 +283,7 @@ struct smb_version_operations {
 				 struct cifsInodeInfo *cinode, __u32 oplock,
 				 unsigned int epoch, bool *purge_cache);
 	/* process transaction2 response */
-	bool (*check_trans2)(struct mid_q_entry *, struct TCP_Server_Info *,
-			     char *, int);
+	bool (*check_trans2)(struct mid_q_entry *, struct TCP_Server_Info *, char *);
 	/* check if we need to negotiate */
 	bool (*need_neg)(struct TCP_Server_Info *);
 	/* negotiate to the server */
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index d59aebefa71c..9e34ea9c7b2a 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -235,7 +235,7 @@ extern unsigned int setup_authusers_ACE(struct cifs_ace *pace);
 extern unsigned int setup_special_mode_ACE(struct cifs_ace *pace, __u64 nmode);
 extern unsigned int setup_special_user_owner_ACE(struct cifs_ace *pace);
 
-extern void dequeue_mid(struct mid_q_entry *mid, bool malformed);
+extern void dequeue_mid(struct mid_q_entry *mid);
 extern int cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
 			         unsigned int to_read);
 extern ssize_t cifs_discard_from_socket(struct TCP_Server_Info *server,
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 6371b9eebdad..33513b4ee0b3 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -1406,26 +1406,17 @@ cifs_discard_remaining_data(struct TCP_Server_Info *server)
 }
 
 static int
-__cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *mid,
-		     bool malformed)
+cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
 	int length;
 
 	length = cifs_discard_remaining_data(server);
-	dequeue_mid(mid, malformed);
+	dequeue_mid(mid);
 	mid->resp_buf = server->smallbuf;
 	server->smallbuf = NULL;
 	return length;
 }
 
-static int
-cifs_readv_discard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
-{
-	struct cifs_readdata *rdata = mid->callback_data;
-
-	return  __cifs_readv_discard(server, mid, rdata->result);
-}
-
 int
 cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 {
@@ -1483,7 +1474,8 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		cifs_dbg(FYI, "%s: server returned error %d\n",
 			 __func__, rdata->result);
 		/* normal error on read response */
-		return __cifs_readv_discard(server, mid, false);
+		mid->mid_state = MID_RESPONSE_RECEIVED;
+		return cifs_readv_discard(server, mid);
 	}
 
 	/* Is there enough to get to the rest of the READ_RSP header? */
@@ -1491,8 +1483,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		cifs_dbg(FYI, "%s: server returned short header. got=%u expected=%zu\n",
 			 __func__, server->total_read,
 			 server->vals->read_rsp_size);
-		rdata->result = -EIO;
-		return cifs_readv_discard(server, mid);
+		goto err_discard;
 	}
 
 	data_offset = server->ops->read_data_offset(buf) +
@@ -1510,8 +1501,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 		/* data_offset is beyond the end of smallbuf */
 		cifs_dbg(FYI, "%s: data offset (%u) beyond end of smallbuf\n",
 			 __func__, data_offset);
-		rdata->result = -EIO;
-		return cifs_readv_discard(server, mid);
+		goto err_discard;
 	}
 
 	cifs_dbg(FYI, "%s: total_read=%u data_offset=%u\n",
@@ -1534,8 +1524,7 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	data_len = server->ops->read_data_length(buf, use_rdma_mr);
 	if (!use_rdma_mr && (data_offset + data_len > buflen)) {
 		/* data_len is corrupt -- discard frame */
-		rdata->result = -EIO;
-		return cifs_readv_discard(server, mid);
+		goto err_discard;
 	}
 
 	length = rdata->read_into_pages(server, rdata, data_len);
@@ -1551,10 +1540,16 @@ cifs_readv_receive(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	if (server->total_read < buflen)
 		return cifs_readv_discard(server, mid);
 
-	dequeue_mid(mid, false);
+	mid->mid_state = MID_RESPONSE_RECEIVED;
+	dequeue_mid(mid);
 	mid->resp_buf = server->smallbuf;
 	server->smallbuf = NULL;
 	return length;
+
+err_discard:
+	rdata->result = -EIO;
+	mid->mid_state = MID_RESPONSE_MALFORMED;
+	return cifs_readv_discard(server, mid);
 }
 
 static void
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 057237c9cb30..dd15e14bd433 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -844,28 +844,20 @@ is_smb_response(struct TCP_Server_Info *server, unsigned char type)
 }
 
 void
-dequeue_mid(struct mid_q_entry *mid, bool malformed)
+dequeue_mid(struct mid_q_entry *mid)
 {
 #ifdef CONFIG_CIFS_STATS2
 	mid->when_received = jiffies;
 #endif
-	spin_lock(&GlobalMid_Lock);
-	if (!malformed)
-		mid->mid_state = MID_RESPONSE_RECEIVED;
-	else
-		mid->mid_state = MID_RESPONSE_MALFORMED;
-	/*
-	 * Trying to handle/dequeue a mid after the send_recv()
-	 * function has finished processing it is a bug.
-	 */
 	if (mid->mid_flags & MID_DELETED) {
-		spin_unlock(&GlobalMid_Lock);
 		pr_warn_once("trying to dequeue a deleted mid\n");
-	} else {
-		list_del_init(&mid->qhead);
-		mid->mid_flags |= MID_DELETED;
-		spin_unlock(&GlobalMid_Lock);
+		return;
 	}
+
+	spin_lock(&GlobalMid_Lock);
+	list_del_init(&mid->qhead);
+	mid->mid_flags |= MID_DELETED;
+	spin_unlock(&GlobalMid_Lock);
 }
 
 static unsigned int
@@ -883,15 +875,16 @@ smb2_get_credits_from_hdr(char *buffer, struct TCP_Server_Info *server)
 }
 
 static void
-handle_mid(struct mid_q_entry *mid, struct TCP_Server_Info *server,
-	   char *buf, int malformed)
+handle_mid(struct mid_q_entry *mid, struct TCP_Server_Info *server, char *buf)
 {
 	if (server->ops->check_trans2 &&
-	    server->ops->check_trans2(mid, server, buf, malformed))
+	    server->ops->check_trans2(mid, server, buf))
 		return;
+
 	mid->credits_received = smb2_get_credits_from_hdr(buf, server);
 	mid->resp_buf = buf;
 	mid->large_buf = server->large_buf;
+
 	/* Was previous buf put in mpx struct for multi-rsp? */
 	if (!mid->multiRsp) {
 		/* smb buffer will be freed by user thread */
@@ -900,7 +893,8 @@ handle_mid(struct mid_q_entry *mid, struct TCP_Server_Info *server,
 		else
 			server->smallbuf = NULL;
 	}
-	dequeue_mid(mid, malformed);
+
+	dequeue_mid(mid);
 }
 
 static void clean_demultiplex_info(struct TCP_Server_Info *server)
@@ -1050,9 +1044,6 @@ cifs_handle_standard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	 * into the payload for debugging purposes.
 	 */
 	rc = server->ops->check_message(buf, server->total_read, server);
-	if (rc)
-		cifs_dump_mem("Bad SMB: ", buf,
-			min_t(unsigned int, server->total_read, 48));
 
 	if (server->ops->is_session_expired &&
 	    server->ops->is_session_expired(buf)) {
@@ -1067,7 +1058,16 @@ cifs_handle_standard(struct TCP_Server_Info *server, struct mid_q_entry *mid)
 	if (!mid)
 		return rc;
 
-	handle_mid(mid, server, buf, rc);
+	if (unlikely(rc)) {
+		cifs_dump_mem("Bad SMB: ", buf,
+			      min_t(unsigned int, server->total_read, 48));
+		/* mid is malformed */
+		mid->mid_state = MID_RESPONSE_MALFORMED;
+	} else {
+		mid->mid_state = MID_RESPONSE_RECEIVED;
+	}
+
+	handle_mid(mid, server, buf);
 	return 0;
 }
 
diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
index 2e20ee4dab7b..416293fe14fb 100644
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -384,21 +384,21 @@ cifs_downgrade_oplock(struct TCP_Server_Info *server,
 
 static bool
 cifs_check_trans2(struct mid_q_entry *mid, struct TCP_Server_Info *server,
-		  char *buf, int malformed)
+		  char *buf)
 {
-	if (malformed)
-		return false;
 	if (check2ndT2(buf) <= 0)
 		return false;
 	mid->multiRsp = true;
 	if (mid->resp_buf) {
+		int rc;
 		/* merge response - fix up 1st*/
-		malformed = coalesce_t2(buf, mid->resp_buf);
-		if (malformed > 0)
+		rc = coalesce_t2(buf, mid->resp_buf);
+		if (rc > 0)
 			return true;
 		/* All parts received or packet is malformed. */
 		mid->multiEnd = true;
-		dequeue_mid(mid, malformed);
+		mid->mid_state = MID_RESPONSE_RECEIVED;
+		dequeue_mid(mid);
 		return true;
 	}
 	if (!server->large_buf) {
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index 562064fe9668..0d57341e4f4a 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -26,17 +26,15 @@ check_smb2_hdr(struct smb2_hdr *shdr, __u64 mid)
 	 * Make sure that this really is an SMB, that it is a response,
 	 * and that the message ids match.
 	 */
-	if ((shdr->ProtocolId == SMB2_PROTO_NUMBER) &&
-	    (mid == wire_mid)) {
+	if ((shdr->ProtocolId == SMB2_PROTO_NUMBER) && (mid == wire_mid)) {
 		if (shdr->Flags & SMB2_FLAGS_SERVER_TO_REDIR)
 			return 0;
-		else {
-			/* only one valid case where server sends us request */
-			if (shdr->Command == SMB2_OPLOCK_BREAK)
-				return 0;
-			else
-				cifs_dbg(VFS, "Received Request not response\n");
-		}
+
+		/* only one valid case where server sends us request */
+		if (shdr->Command == SMB2_OPLOCK_BREAK)
+			return 0;
+
+		cifs_dbg(VFS, "Received Request not response\n");
 	} else { /* bad signature or mid */
 		if (shdr->ProtocolId != SMB2_PROTO_NUMBER)
 			cifs_dbg(VFS, "Bad protocol string signature header %x\n",
@@ -45,7 +43,7 @@ check_smb2_hdr(struct smb2_hdr *shdr, __u64 mid)
 			cifs_dbg(VFS, "Mids do not match: %llu and %llu\n",
 				 mid, wire_mid);
 	}
-	cifs_dbg(VFS, "Bad SMB detected. The Mid=%llu\n", wire_mid);
+	cifs_dbg(VFS, "Bad SMB detected, mid=%llu\n", wire_mid);
 	return 1;
 }
 
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 8802995b2d3d..f63139015afa 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -335,7 +335,7 @@ smb2_revert_current_mid(struct TCP_Server_Info *server, const unsigned int val)
 }
 
 static struct mid_q_entry *
-__smb2_find_mid(struct TCP_Server_Info *server, char *buf, bool dequeue)
+smb2_find_mid(struct TCP_Server_Info *server, char *buf)
 {
 	struct mid_q_entry *mid;
 	struct smb2_hdr *shdr = (struct smb2_hdr *)buf;
@@ -352,10 +352,6 @@ __smb2_find_mid(struct TCP_Server_Info *server, char *buf, bool dequeue)
 		    (mid->mid_state == MID_REQUEST_SUBMITTED) &&
 		    (mid->command == shdr->Command)) {
 			kref_get(&mid->refcount);
-			if (dequeue) {
-				list_del_init(&mid->qhead);
-				mid->mid_flags |= MID_DELETED;
-			}
 			spin_unlock(&GlobalMid_Lock);
 			return mid;
 		}
@@ -364,18 +360,6 @@ __smb2_find_mid(struct TCP_Server_Info *server, char *buf, bool dequeue)
 	return NULL;
 }
 
-static struct mid_q_entry *
-smb2_find_mid(struct TCP_Server_Info *server, char *buf)
-{
-	return __smb2_find_mid(server, buf, false);
-}
-
-static struct mid_q_entry *
-smb2_find_dequeue_mid(struct TCP_Server_Info *server, char *buf)
-{
-	return __smb2_find_mid(server, buf, true);
-}
-
 static void
 smb2_dump_detail(void *buf, struct TCP_Server_Info *server)
 {
@@ -4912,7 +4896,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 	}
 
 	if (server->ops->is_status_pending &&
-			server->ops->is_status_pending(buf, server))
+	    server->ops->is_status_pending(buf, server))
 		return -1;
 
 	/* set up first two iov to get credits */
@@ -4931,11 +4915,9 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 		cifs_dbg(FYI, "%s: server returned error %d\n",
 			 __func__, rdata->result);
 		/* normal error on read response */
-		if (is_offloaded)
-			mid->mid_state = MID_RESPONSE_RECEIVED;
-		else
-			dequeue_mid(mid, false);
-		return 0;
+		mid->mid_state = MID_RESPONSE_RECEIVED;
+		length = 0;
+		goto err_out;
 	}
 
 	data_offset = server->ops->read_data_offset(buf);
@@ -4958,11 +4940,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 		cifs_dbg(FYI, "%s: data offset (%u) beyond end of smallbuf\n",
 			 __func__, data_offset);
 		rdata->result = -EIO;
-		if (is_offloaded)
-			mid->mid_state = MID_RESPONSE_MALFORMED;
-		else
-			dequeue_mid(mid, rdata->result);
-		return 0;
+		goto err_malformed;
 	}
 
 	pad_len = data_offset - server->vals->read_rsp_size;
@@ -4977,32 +4955,19 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 			cifs_dbg(FYI, "%s: data offset (%u) beyond 1st page of response\n",
 				 __func__, data_offset);
 			rdata->result = -EIO;
-			if (is_offloaded)
-				mid->mid_state = MID_RESPONSE_MALFORMED;
-			else
-				dequeue_mid(mid, rdata->result);
-			return 0;
+			goto err_malformed;
 		}
 
 		if (data_len > page_data_size - pad_len) {
 			/* data_len is corrupt -- discard frame */
 			rdata->result = -EIO;
-			if (is_offloaded)
-				mid->mid_state = MID_RESPONSE_MALFORMED;
-			else
-				dequeue_mid(mid, rdata->result);
-			return 0;
+			goto err_malformed;
 		}
 
 		rdata->result = init_read_bvec(pages, npages, page_data_size,
 					       cur_off, &bvec);
-		if (rdata->result != 0) {
-			if (is_offloaded)
-				mid->mid_state = MID_RESPONSE_MALFORMED;
-			else
-				dequeue_mid(mid, rdata->result);
-			return 0;
-		}
+		if (rdata->result != 0)
+			goto err_malformed;
 
 		iov_iter_bvec(&iter, WRITE, bvec, npages, data_len);
 	} else if (buf_len >= data_offset + data_len) {
@@ -5015,24 +4980,26 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 		/* read response payload cannot be in both buf and pages */
 		WARN_ONCE(1, "buf can not contain only a part of read data");
 		rdata->result = -EIO;
-		if (is_offloaded)
-			mid->mid_state = MID_RESPONSE_MALFORMED;
-		else
-			dequeue_mid(mid, rdata->result);
-		return 0;
+		goto err_malformed;
 	}
 
 	length = rdata->copy_into_pages(server, rdata, &iter);
 
 	kfree(bvec);
 
-	if (length < 0)
+err_out:
+	if (length <= 0)
 		return length;
 
-	if (is_offloaded)
-		mid->mid_state = MID_RESPONSE_RECEIVED;
+err_malformed:
+	if (rdata->result != 0)
+		mid->mid_state = MID_RESPONSE_MALFORMED;
 	else
-		dequeue_mid(mid, false);
+		mid->mid_state = MID_RESPONSE_RECEIVED;
+
+	if (!is_offloaded)
+		dequeue_mid(mid);
+
 	return length;
 }
 
@@ -5061,44 +5028,45 @@ static void smb2_decrypt_offload(struct work_struct *work)
 	}
 
 	dw->server->lstrp = jiffies;
-	mid = smb2_find_dequeue_mid(dw->server, dw->buf);
-	if (mid == NULL)
+	mid = smb2_find_mid(dw->server, dw->buf);
+	if (mid == NULL) {
 		cifs_dbg(FYI, "mid not found\n");
-	else {
-		mid->decrypted = true;
-		rc = handle_read_data(dw->server, mid, dw->buf,
-				      dw->server->vals->read_rsp_size,
-				      dw->ppages, dw->npages, dw->len,
-				      true);
-		if (rc >= 0) {
+		goto free_pages;
+	}
+
+	dequeue_mid(mid);
+
+	mid->decrypted = true;
+	rc = handle_read_data(dw->server, mid, dw->buf,
+			      dw->server->vals->read_rsp_size, dw->ppages,
+			      dw->npages, dw->len, true);
+	if (rc >= 0) {
 #ifdef CONFIG_CIFS_STATS2
-			mid->when_received = jiffies;
+		mid->when_received = jiffies;
 #endif
-			if (dw->server->ops->is_network_name_deleted)
-				dw->server->ops->is_network_name_deleted(dw->buf,
-									 dw->server);
+		if (dw->server->ops->is_network_name_deleted)
+			dw->server->ops->is_network_name_deleted(dw->buf, dw->server);
 
-			mid->callback(mid);
+		mid->callback(mid);
+	} else {
+		spin_lock(&cifs_tcp_ses_lock);
+		spin_lock(&GlobalMid_Lock);
+		if (dw->server->tcpStatus == CifsNeedReconnect) {
+			mid->mid_state = MID_RETRY_NEEDED;
 		} else {
-			spin_lock(&cifs_tcp_ses_lock);
-			spin_lock(&GlobalMid_Lock);
-			if (dw->server->tcpStatus == CifsNeedReconnect) {
-				mid->mid_state = MID_RETRY_NEEDED;
-				spin_unlock(&GlobalMid_Lock);
-				spin_unlock(&cifs_tcp_ses_lock);
-				mid->callback(mid);
-			} else {
-				mid->mid_state = MID_REQUEST_SUBMITTED;
-				mid->mid_flags &= ~(MID_DELETED);
-				list_add_tail(&mid->qhead,
-					&dw->server->pending_mid_q);
-				spin_unlock(&GlobalMid_Lock);
-				spin_unlock(&cifs_tcp_ses_lock);
-			}
+			mid->mid_state = MID_REQUEST_SUBMITTED;
+			mid->mid_flags &= ~(MID_DELETED);
+			list_add_tail(&mid->qhead, &dw->server->pending_mid_q);
 		}
-		cifs_mid_q_entry_release(mid);
+		spin_unlock(&GlobalMid_Lock);
+		spin_unlock(&cifs_tcp_ses_lock);
+
+		if (mid->mid_state == MID_RETRY_NEEDED)
+			mid->callback(mid);
 	}
 
+	cifs_mid_q_entry_release(mid);
+
 free_pages:
 	for (i = dw->npages-1; i >= 0; i--)
 		put_page(dw->ppages[i]);
@@ -5191,22 +5159,18 @@ receive_encrypted_read(struct TCP_Server_Info *server, struct mid_q_entry **mid,
 		goto free_pages;
 
 	*mid = smb2_find_mid(server, buf);
-	if (*mid == NULL)
+	if (*mid == NULL) {
 		cifs_dbg(FYI, "mid not found\n");
-	else {
-		cifs_dbg(FYI, "mid found\n");
-		(*mid)->decrypted = true;
-		rc = handle_read_data(server, *mid, buf,
-				      server->vals->read_rsp_size,
-				      pages, npages, len, false);
-		if (rc >= 0) {
-			if (server->ops->is_network_name_deleted) {
-				server->ops->is_network_name_deleted(buf,
-								server);
-			}
-		}
+		goto free_pages;
 	}
 
+	(*mid)->decrypted = true;
+	rc = handle_read_data(server, *mid, buf, server->vals->read_rsp_size,
+			      pages, npages, len, false);
+	if (rc >= 0)
+		if (server->ops->is_network_name_deleted)
+			server->ops->is_network_name_deleted(buf, server);
+
 free_pages:
 	for (i = i - 1; i >= 0; i--)
 		put_page(pages[i]);
@@ -5253,7 +5217,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 		return length;
 
 	next_is_large = server->large_buf;
-one_more:
+next:
 	shdr = (struct smb2_hdr *)buf;
 	if (shdr->NextCommand) {
 		if (next_is_large)
@@ -5266,10 +5230,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	}
 
 	mid_entry = smb2_find_mid(server, buf);
-	if (mid_entry == NULL)
-		cifs_dbg(FYI, "mid not found\n");
-	else {
-		cifs_dbg(FYI, "mid found\n");
+	if (mid_entry) {
 		mid_entry->decrypted = true;
 		mid_entry->resp_buf_size = server->pdu_size;
 	}
@@ -5278,6 +5239,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 		cifs_server_dbg(VFS, "too many PDUs in compound\n");
 		return -1;
 	}
+
 	bufs[*num_mids] = buf;
 	mids[(*num_mids)++] = mid_entry;
 
@@ -5293,7 +5255,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 			server->bigbuf = buf = next_buffer;
 		else
 			server->smallbuf = buf = next_buffer;
-		goto one_more;
+		goto next;
 	} else if (ret != 0) {
 		/*
 		 * ret != 0 here means that we didn't get to handle_mid() thus
-- 
2.35.3

