Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 155BD20EB79
	for <lists+linux-cifs@lfdr.de>; Tue, 30 Jun 2020 04:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726288AbgF3CaT (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 29 Jun 2020 22:30:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726158AbgF3CaT (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 29 Jun 2020 22:30:19 -0400
Received: from mail.darkrain42.org (o-chul.darkrain42.org [IPv6:2600:3c01::f03c:91ff:fe96:292c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CA4CC061755
        for <linux-cifs@vger.kernel.org>; Mon, 29 Jun 2020 19:30:19 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by o-chul.darkrain42.org (Postfix) with ESMTPSA id 0A22280F1;
        Mon, 29 Jun 2020 19:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=darkrain42.org; s=a;
        t=1593484218; bh=boAtugMEhDJ9IgIvEjQxOUZM2QDafhXj7S6XfYKT6aI=;
        h=From:To:Cc:Subject:Date:From;
        b=kKuH2zjzhPdBZUbQfCVq9Q6nx8zmK0gUfNossEmwObzdENbl3I90FgrLYi75IJcgM
         Hh16CsE6lc7FKJyhgYQY9Ee+u7Rk7MA0+vB66NQ57wIoZeQcAPhYqZ1pvoQZrvodzA
         W8CWuhk7Rab0tbkZzfObUJJDbKKCB9qxQs/3PwZudfAZOF4yxfoR3nDZG0oCH1tLfp
         ckuzeU8HFaOFG28AMixliL5y69PBlyiGbMCJ2Uw7YNQr0Jnbdh7Xm/RRnhPm5uDSRX
         a0C01syJkJshkbJ3rCmL6nuNpLGvnjt8HpU1hf0E/BnXzwd6qCQUIe8w6s0YfqjYTR
         JC3Ao65Rcn35Q==
From:   Paul Aurich <paul@darkrain42.org>
To:     linux-cifs@vger.kernel.org, sfrench@samba.org
Cc:     paul@darkrain42.org, Ronnie Sahlberg <lsahlber@redhat.com>,
        =?UTF-8?q?Aur=C3=A9lien=20Aptel?= <aaptel@suse.com>
Subject: [PATCH v2] cifs: Fix leak when handling lease break for cached root fid
Date:   Mon, 29 Jun 2020 19:30:03 -0700
Message-Id: <20200630023003.1858066-1-paul@darkrain42.org>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Handling a lease break for the cached root didn't free the
smb2_lease_break_work allocation, resulting in a leak:

    unreferenced object 0xffff98383a5af480 (size 128):
      comm "cifsd", pid 684, jiffies 4294936606 (age 534.868s)
      hex dump (first 32 bytes):
        c0 ff ff ff 1f 00 00 00 88 f4 5a 3a 38 98 ff ff  ..........Z:8...
        88 f4 5a 3a 38 98 ff ff 80 88 d6 8a ff ff ff ff  ..Z:8...........
      backtrace:
        [<0000000068957336>] smb2_is_valid_oplock_break+0x1fa/0x8c0
        [<0000000073b70b9e>] cifs_demultiplex_thread+0x73d/0xcc0
        [<00000000905fa372>] kthread+0x11c/0x150
        [<0000000079378e4e>] ret_from_fork+0x22/0x30

Avoid this leak by only allocating when necessary.

Fixes: a93864d93977 ("cifs: add lease tracking to the cached root fid")
Signed-off-by: Paul Aurich <paul@darkrain42.org>
CC: Stable <stable@vger.kernel.org> # v4.18+
---
 fs/cifs/smb2misc.c | 47 ++++++++++++++++++++++++++--------------------
 1 file changed, 27 insertions(+), 20 deletions(-)

diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index 6a39451973f8..570c0521fc3c 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -505,8 +505,7 @@ cifs_ses_oplock_break(struct work_struct *work)
 }
 
 static bool
-smb2_tcon_has_lease(struct cifs_tcon *tcon, struct smb2_lease_break *rsp,
-		    struct smb2_lease_break_work *lw)
+smb2_tcon_has_lease(struct cifs_tcon *tcon, struct smb2_lease_break *rsp)
 {
 	bool found;
 	__u8 lease_state;
@@ -516,9 +515,13 @@ smb2_tcon_has_lease(struct cifs_tcon *tcon, struct smb2_lease_break *rsp,
 	struct cifsInodeInfo *cinode;
 	int ack_req = le32_to_cpu(rsp->Flags &
 				  SMB2_NOTIFY_BREAK_LEASE_FLAG_ACK_REQUIRED);
+	struct smb2_lease_break_work *lw;
+	struct tcon_link *tlink;
+	__u8 lease_key[SMB2_LEASE_KEY_SIZE];
 
 	lease_state = le32_to_cpu(rsp->NewLeaseState);
 
+	spin_lock(&tcon->open_file_lock);
 	list_for_each(tmp, &tcon->openFileList) {
 		cfile = list_entry(tmp, struct cifsFileInfo, tlist);
 		cinode = CIFS_I(d_inode(cfile->dentry));
@@ -542,7 +545,8 @@ smb2_tcon_has_lease(struct cifs_tcon *tcon, struct smb2_lease_break *rsp,
 		cfile->oplock_level = lease_state;
 
 		cifs_queue_oplock_break(cfile);
-		kfree(lw);
+		spin_unlock(&tcon->open_file_lock);
+		spin_unlock(&cifs_tcp_ses_lock);
 		return true;
 	}
 
@@ -554,10 +558,9 @@ smb2_tcon_has_lease(struct cifs_tcon *tcon, struct smb2_lease_break *rsp,
 
 		if (!found && ack_req) {
 			found = true;
-			memcpy(lw->lease_key, open->lease_key,
+			memcpy(lease_key, open->lease_key,
 			       SMB2_LEASE_KEY_SIZE);
-			lw->tlink = cifs_get_tlink(open->tlink);
-			queue_work(cifsiod_wq, &lw->lease_break);
+			tlink = cifs_get_tlink(open->tlink);
 		}
 
 		cifs_dbg(FYI, "found in the pending open list\n");
@@ -567,6 +570,23 @@ smb2_tcon_has_lease(struct cifs_tcon *tcon, struct smb2_lease_break *rsp,
 		open->oplock = lease_state;
 	}
 
+	spin_unlock(&tcon->open_file_lock);
+	if (found) {
+		spin_unlock(&cifs_tcp_ses_lock);
+
+		lw = kmalloc(sizeof(struct smb2_lease_break_work), GFP_KERNEL);
+		if (!lw) {
+			cifs_put_tlink(tlink);
+			return true;
+		}
+
+		INIT_WORK(&lw->lease_break, cifs_ses_oplock_break);
+		lw->tlink = tlink;
+		lw->lease_state = rsp->NewLeaseState;
+		memcpy(lw->lease_key, lease_key, SMB2_LEASE_KEY_SIZE);
+		queue_work(cifsiod_wq, &lw->lease_break);
+	}
+
 	return found;
 }
 
@@ -578,14 +598,6 @@ smb2_is_valid_lease_break(char *buffer)
 	struct TCP_Server_Info *server;
 	struct cifs_ses *ses;
 	struct cifs_tcon *tcon;
-	struct smb2_lease_break_work *lw;
-
-	lw = kmalloc(sizeof(struct smb2_lease_break_work), GFP_KERNEL);
-	if (!lw)
-		return false;
-
-	INIT_WORK(&lw->lease_break, cifs_ses_oplock_break);
-	lw->lease_state = rsp->NewLeaseState;
 
 	cifs_dbg(FYI, "Checking for lease break\n");
 
@@ -600,15 +612,11 @@ smb2_is_valid_lease_break(char *buffer)
 			list_for_each(tmp2, &ses->tcon_list) {
 				tcon = list_entry(tmp2, struct cifs_tcon,
 						  tcon_list);
-				spin_lock(&tcon->open_file_lock);
 				cifs_stats_inc(
 				    &tcon->stats.cifs_stats.num_oplock_brks);
-				if (smb2_tcon_has_lease(tcon, rsp, lw)) {
-					spin_unlock(&tcon->open_file_lock);
-					spin_unlock(&cifs_tcp_ses_lock);
+				if (smb2_tcon_has_lease(tcon, rsp)) {
 					return true;
 				}
-				spin_unlock(&tcon->open_file_lock);
 
 				if (tcon->crfid.is_valid &&
 				    !memcmp(rsp->LeaseKey,
@@ -625,7 +633,6 @@ smb2_is_valid_lease_break(char *buffer)
 		}
 	}
 	spin_unlock(&cifs_tcp_ses_lock);
-	kfree(lw);
 	cifs_dbg(FYI, "Can not process lease break - no lease matched\n");
 	return false;
 }
-- 
2.27.0

