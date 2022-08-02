Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD6B58834F
	for <lists+linux-cifs@lfdr.de>; Tue,  2 Aug 2022 23:11:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232519AbiHBVLm (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 2 Aug 2022 17:11:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiHBVLl (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 2 Aug 2022 17:11:41 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21E4346D86
        for <linux-cifs@vger.kernel.org>; Tue,  2 Aug 2022 14:11:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id C374E20BF3;
        Tue,  2 Aug 2022 21:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1659474696; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=V6EBumGn1zm2isCTZ9PaqYpDmAcaUataJjFLh6wxnro=;
        b=kXkyymrDREYNGAn+NxJvjPTB+h2srl+sbmDgWoeuwUjWUq1IN0ir3CvLMiWr7Ppk2G6qnI
        eFcyBQDdMW2NrbZUogmFW+qFw23BwkImGZrtsxQUL7dwgzapymU6BvpM4DqAhGM2EJ0D8l
        HzH4xSjmyK27DceMAJ/++QSJUK0etXA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1659474696;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=V6EBumGn1zm2isCTZ9PaqYpDmAcaUataJjFLh6wxnro=;
        b=tJOpv4SRkhbXM3RTiIzfVm4lmqVip+pGmZ7MRTtqtnEn7JO+nO2i4Iokepm4LTije+sdLR
        JKcHxZffHxchdeAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4381113A8E;
        Tue,  2 Aug 2022 21:11:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 33yYAQiT6WIZDAAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Tue, 02 Aug 2022 21:11:36 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, pc@cjr.nz, ronniesahlberg@gmail.com,
        nspmangalore@gmail.com
Subject: [PATCH] cifs: remove useless DeleteMidQEntry()
Date:   Tue,  2 Aug 2022 18:11:24 -0300
Message-Id: <20220802211124.4014-1-ematsumiya@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

DeleteMidQEntry() was just a proxy for cifs_mid_q_entry_release().

Remove DeleteMidQEntry(), rename cifs_mid_q_entry_release() to
cifs_release_mid().

Also rename the kref_put() callback _cifs_mid_q_entry_release to
__cifs_release_mid.

Update callers to cifs_mid_q_entry_release and DeleteMidQEntry to use
cifs_release_mid.

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 fs/cifs/cifsproto.h     |  3 +--
 fs/cifs/cifssmb.c       |  6 +++---
 fs/cifs/connect.c       |  8 ++++----
 fs/cifs/smb2ops.c       |  2 +-
 fs/cifs/smb2pdu.c       |  6 +++---
 fs/cifs/smb2transport.c |  2 +-
 fs/cifs/transport.c     | 25 ++++++++++---------------
 7 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index de167e3af015..853ea4c8d88e 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -81,9 +81,8 @@ extern char *cifs_compose_mount_options(const char *sb_mountdata,
 /* extern void renew_parental_timestamps(struct dentry *direntry);*/
 extern struct mid_q_entry *AllocMidQEntry(const struct smb_hdr *smb_buffer,
 					struct TCP_Server_Info *server);
-extern void DeleteMidQEntry(struct mid_q_entry *midEntry);
 extern void cifs_delete_mid(struct mid_q_entry *mid);
-extern void cifs_mid_q_entry_release(struct mid_q_entry *midEntry);
+extern void cifs_release_mid(struct mid_q_entry *mid);
 extern void cifs_wake_up_task(struct mid_q_entry *mid);
 extern int cifs_handle_standard(struct TCP_Server_Info *server,
 				struct mid_q_entry *mid);
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 26b9d2438228..f0d72575e3c0 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -591,7 +591,7 @@ cifs_echo_callback(struct mid_q_entry *mid)
 	struct TCP_Server_Info *server = mid->callback_data;
 	struct cifs_credits credits = { .value = 1, .instance = 0 };
 
-	DeleteMidQEntry(mid);
+	cifs_release_mid(mid);
 	add_credits(server, &credits, CIFS_ECHO_OP);
 }
 
@@ -1336,7 +1336,7 @@ cifs_readv_callback(struct mid_q_entry *mid)
 	}
 
 	queue_work(cifsiod_wq, &rdata->work);
-	DeleteMidQEntry(mid);
+	cifs_release_mid(mid);
 	add_credits(server, &credits, 0);
 }
 
@@ -1684,7 +1684,7 @@ cifs_writev_callback(struct mid_q_entry *mid)
 	}
 
 	queue_work(cifsiod_wq, &wdata->work);
-	DeleteMidQEntry(mid);
+	cifs_release_mid(mid);
 	add_credits(tcon->ses->server, &credits, 0);
 }
 
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index abb65dd7471f..eb7e75deb9d2 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -334,7 +334,7 @@ cifs_abort_connection(struct TCP_Server_Info *server)
 	list_for_each_entry_safe(mid, nmid, &retry_list, qhead) {
 		list_del_init(&mid->qhead);
 		mid->callback(mid);
-		cifs_mid_q_entry_release(mid);
+		cifs_release_mid(mid);
 	}
 
 	if (cifs_rdma_enabled(server)) {
@@ -1007,7 +1007,7 @@ static void clean_demultiplex_info(struct TCP_Server_Info *server)
 			cifs_dbg(FYI, "Callback mid %llu\n", mid_entry->mid);
 			list_del_init(&mid_entry->qhead);
 			mid_entry->callback(mid_entry);
-			cifs_mid_q_entry_release(mid_entry);
+			cifs_release_mid(mid_entry);
 		}
 		/* 1/8th of sec is more than enough time for them to exit */
 		msleep(125);
@@ -1246,7 +1246,7 @@ cifs_demultiplex_thread(void *p)
 		if (length < 0) {
 			for (i = 0; i < num_mids; i++)
 				if (mids[i])
-					cifs_mid_q_entry_release(mids[i]);
+					cifs_release_mid(mids[i]);
 			continue;
 		}
 
@@ -1273,7 +1273,7 @@ cifs_demultiplex_thread(void *p)
 				if (!mids[i]->multiRsp || mids[i]->multiEnd)
 					mids[i]->callback(mids[i]);
 
-				cifs_mid_q_entry_release(mids[i]);
+				cifs_release_mid(mids[i]);
 			} else if (server->ops->is_oplock_break &&
 				   server->ops->is_oplock_break(bufs[i],
 								server)) {
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 82dd2e973753..ad3b13283717 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -5099,7 +5099,7 @@ static void smb2_decrypt_offload(struct work_struct *work)
 				spin_unlock(&dw->server->srv_lock);
 			}
 		}
-		cifs_mid_q_entry_release(mid);
+		cifs_release_mid(mid);
 	}
 
 free_pages:
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 131bec79d6fd..a24e05586d5c 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -3776,7 +3776,7 @@ smb2_echo_callback(struct mid_q_entry *mid)
 		credits.instance = server->reconnect_instance;
 	}
 
-	DeleteMidQEntry(mid);
+	cifs_release_mid(mid);
 	add_credits(server, &credits, CIFS_ECHO_OP);
 }
 
@@ -4201,7 +4201,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 				     rdata->offset, rdata->got_bytes);
 
 	queue_work(cifsiod_wq, &rdata->work);
-	DeleteMidQEntry(mid);
+	cifs_release_mid(mid);
 	add_credits(server, &credits, 0);
 }
 
@@ -4440,7 +4440,7 @@ smb2_writev_callback(struct mid_q_entry *mid)
 				      wdata->offset, wdata->bytes);
 
 	queue_work(cifsiod_wq, &wdata->work);
-	DeleteMidQEntry(mid);
+	cifs_release_mid(mid);
 	add_credits(server, &credits, 0);
 }
 
diff --git a/fs/cifs/smb2transport.c b/fs/cifs/smb2transport.c
index f64922f340b3..f3068786a199 100644
--- a/fs/cifs/smb2transport.c
+++ b/fs/cifs/smb2transport.c
@@ -890,7 +890,7 @@ smb2_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 	rc = smb2_sign_rqst(rqst, server);
 	if (rc) {
 		revert_current_mid_from_hdr(server, shdr);
-		DeleteMidQEntry(mid);
+		cifs_release_mid(mid);
 		return ERR_PTR(rc);
 	}
 
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 914a7aaf9fa7..24caf1fb7213 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -74,7 +74,7 @@ AllocMidQEntry(const struct smb_hdr *smb_buffer, struct TCP_Server_Info *server)
 	return temp;
 }
 
-static void _cifs_mid_q_entry_release(struct kref *refcount)
+static void __cifs_release_mid(struct kref *refcount)
 {
 	struct mid_q_entry *midEntry =
 			container_of(refcount, struct mid_q_entry, refcount);
@@ -153,20 +153,15 @@ static void _cifs_mid_q_entry_release(struct kref *refcount)
 	mempool_free(midEntry, cifs_mid_poolp);
 }
 
-void cifs_mid_q_entry_release(struct mid_q_entry *midEntry)
+void cifs_release_mid(struct mid_q_entry *mid)
 {
-	struct TCP_Server_Info *server = midEntry->server;
+	struct TCP_Server_Info *server = mid->server;
 
 	spin_lock(&server->mid_lock);
-	kref_put(&midEntry->refcount, _cifs_mid_q_entry_release);
+	kref_put(&mid->refcount, __cifs_release_mid);
 	spin_unlock(&server->mid_lock);
 }
 
-void DeleteMidQEntry(struct mid_q_entry *midEntry)
-{
-	cifs_mid_q_entry_release(midEntry);
-}
-
 void
 cifs_delete_mid(struct mid_q_entry *mid)
 {
@@ -177,7 +172,7 @@ cifs_delete_mid(struct mid_q_entry *mid)
 	}
 	spin_unlock(&mid->server->mid_lock);
 
-	DeleteMidQEntry(mid);
+	cifs_release_mid(mid);
 }
 
 /*
@@ -791,7 +786,7 @@ cifs_setup_async_request(struct TCP_Server_Info *server, struct smb_rqst *rqst)
 
 	rc = cifs_sign_rqst(rqst, server, &mid->sequence_number);
 	if (rc) {
-		DeleteMidQEntry(mid);
+		cifs_release_mid(mid);
 		return ERR_PTR(rc);
 	}
 
@@ -940,7 +935,7 @@ cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
 	}
 	spin_unlock(&server->mid_lock);
 
-	DeleteMidQEntry(mid);
+	cifs_release_mid(mid);
 	return rc;
 }
 
@@ -1029,7 +1024,7 @@ static void
 cifs_cancelled_callback(struct mid_q_entry *mid)
 {
 	cifs_compound_callback(mid);
-	DeleteMidQEntry(mid);
+	cifs_release_mid(mid);
 }
 
 /*
@@ -1425,7 +1420,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 		spin_lock(&server->mid_lock);
 		if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
 			/* no longer considered to be "in-flight" */
-			midQ->callback = DeleteMidQEntry;
+			midQ->callback = cifs_release_mid;
 			spin_unlock(&server->mid_lock);
 			add_credits(server, &credits, 0);
 			return rc;
@@ -1606,7 +1601,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 			spin_lock(&server->mid_lock);
 			if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
 				/* no longer considered to be "in-flight" */
-				midQ->callback = DeleteMidQEntry;
+				midQ->callback = cifs_release_mid;
 				spin_unlock(&server->mid_lock);
 				return rc;
 			}
-- 
2.35.3

