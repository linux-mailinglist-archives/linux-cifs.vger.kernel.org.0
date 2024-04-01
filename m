Return-Path: <linux-cifs+bounces-1702-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CC933894412
	for <lists+linux-cifs@lfdr.de>; Mon,  1 Apr 2024 19:13:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 56DD51F27DD9
	for <lists+linux-cifs@lfdr.de>; Mon,  1 Apr 2024 17:13:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E401482CA;
	Mon,  1 Apr 2024 17:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="nxukXMip"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7FCB21105
	for <linux-cifs@vger.kernel.org>; Mon,  1 Apr 2024 17:13:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=167.235.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711991601; cv=pass; b=NUoJcV78V5x9Cx1MDugMTr/B8AIcLJf+LIl0YH0YtBDUBvD8t1NICtao3Nq3LzFGnXVZXNa49b33wsYDcrbLS01OGCX8/GhN7cGMx/dyJAjbTpv+tT1ggm/X4dt9YLUMwMomoC84qkyw53Y+hhIBIj2kiPZXCyZjYU/jFPIBGyM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711991601; c=relaxed/simple;
	bh=Pd1DflOgfhV2o8Ve8TEP7AdxxahZgSQOe99JJ61q71U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RXeTrk46IezSgiFKZ88xyFheMArYECfK0SjgB0ctHU+YESbjfBH8rcZQYmXXgmIzDkyfK/PRyYZubw0efxWfAMUl4Zc3dNjpSZzLt0xFPadEW577THs/Clm1rGVb4mtoZThriPaLGy6vqB75u7QtkHTnTqEmlcGqOnbHubwZ760=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=nxukXMip; arc=pass smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
From: Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1711991597;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOcT44e6+RLBiA1fb0pK8EBB5v6uWdokexORFD748pI=;
	b=nxukXMipZPZYbfQPru+Kmjxgto7mMHWXMdDwKqrbtz+mtGYbX6DsJZ7Kr7dRSnoNdTSXQr
	TsTuKZV2bfwnAr1PpJFgFqHBfl9PJtf4iYW7rLKWj8gstJ/jEu+AXl9YZancIU7OQh5mJD
	NoRoWFR6zEu0B/YvpmZDA60c89brr0L1MqrZ4RJk/aA8T/8FsOHFl78xQvbxv+BoaBYeSQ
	gKgdr30HKME/bsoMB5WZpNcppd7b6AEEn4hLQ1XphubcmlD6r9FviMLHNyQynxIXer97GY
	rR4yBMvW3mjMXyjdK6VvBiI+FqYjKryu1iUVpvql5N1ysOAtX0ShgYiaffHo1A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1711991597; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=bOcT44e6+RLBiA1fb0pK8EBB5v6uWdokexORFD748pI=;
	b=f+nYrSPI962tXc6D0VqHjsPMufKAG4BvLcO1yqpU9flrb+xmrPWwxHMyFFPgTtnksjgKKY
	vMNCtJqPZlzo8jRaBRvaAxqpybDw/6KSsF7RqfPSc1CbufHuuDKbzj0EhJTZZHmd1iKM9i
	ZgyJjkv7UTuyzTu4Wtg/IwJ4H44Eovlpkuitfz20N3dh07JC6WMuX7JpOZVpQCbuo0eCix
	1C4ZvEYNaWXkJgOda9TBHg2AEHagSlVUbOZBihvRcQr9olMb9QjnEXSL1btpyNqHW42SDv
	nB/q6QzlLEgC6pQUe5kFomriFvhgvN5jsI+fbNFn3APnXH9uNlK+uz47eJHHfg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1711991597; a=rsa-sha256;
	cv=none;
	b=praV3ybR8pIV5iEwyg52OTbgNk9yfmA3Udii34pJIYdkfueutEe+8X3qdjlvagrfNNSk8D
	novt5ZC3zYx8GaJeIGOCljc7nAF5bCxNRq8bevZRZtX3/0iO1g0lNlfN1C8nsycyyllfvV
	12eoPg9SYnoJJRTvcqnRICk5wQnjamu+w9qrwWrpIUgrJJOj1AqmiCsGcO9Bk/vHEPTC5v
	uR3kVg9Et7RUfe4kc+ndM6zp4AYeJj60GNBD1v9OZpb4QHmy4L38bbaYN85l/D4+b28sG5
	a+YPsTSaDz+1YaQcAGh8mG18hbBtvdOO8GiktnQsr6FuITyovu5RlUKbHMyESw==
To: smfrench@gmail.com
Cc: linux-cifs@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH v2] smb: client: fix UAF in smb2_reconnect_server()
Date: Mon,  1 Apr 2024 14:13:10 -0300
Message-ID: <20240401171310.88213-1-pc@manguebit.com>
In-Reply-To: <20240401170044.86991-1-pc@manguebit.com>
References: <20240401170044.86991-1-pc@manguebit.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The UAF bug is due to smb2_reconnect_server() accessing a session that
is already being teared down by another thread that is executing
__cifs_put_smb_ses().  This can happen when (a) the client has
connection to the server but no session or (b) another thread ends up
setting @ses->ses_status again to something different than
SES_EXITING.

To fix this, we need to make sure to unconditionally set
@ses->ses_status to SES_EXITING and prevent any other threads from
setting a new status while we're still tearing it down.

The following can be reproduced by adding some delay to right after
the ipc is freed in __cifs_put_smb_ses() - which will give
smb2_reconnect_server() worker a chance to run and then accessing
@ses->ipc:

kinit ...
mount.cifs //srv/share /mnt/1 -o sec=krb5,nohandlecache,echo_interval=10
[disconnect srv]
ls /mnt/1 &>/dev/null
sleep 30
kdestroy
[reconnect srv]
sleep 10
umount /mnt/1
...
CIFS: VFS: Verify user has a krb5 ticket and keyutils is installed
CIFS: VFS: \\srv Send error in SessSetup = -126
CIFS: VFS: Verify user has a krb5 ticket and keyutils is installed
CIFS: VFS: \\srv Send error in SessSetup = -126
general protection fault, probably for non-canonical address
0x6b6b6b6b6b6b6b6b: 0000 [#1] PREEMPT SMP NOPTI
CPU: 3 PID: 50 Comm: kworker/3:1 Not tainted 6.9.0-rc2 #1
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-1.fc39
04/01/2014
Workqueue: cifsiod smb2_reconnect_server [cifs]
RIP: 0010:__list_del_entry_valid_or_report+0x33/0xf0
Code: 4f 08 48 85 d2 74 42 48 85 c9 74 59 48 b8 00 01 00 00 00 00 ad
de 48 39 c2 74 61 48 b8 22 01 00 00 00 00 74 69 <48> 8b 01 48 39 f8 75
7b 48 8b 72 08 48 39 c6 0f 85 88 00 00 00 b8
RSP: 0018:ffffc900001bfd70 EFLAGS: 00010a83
RAX: dead000000000122 RBX: ffff88810da53838 RCX: 6b6b6b6b6b6b6b6b
RDX: 6b6b6b6b6b6b6b6b RSI: ffffffffc02f6878 RDI: ffff88810da53800
RBP: ffff88810da53800 R08: 0000000000000001 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000001 R12: ffff88810c064000
R13: 0000000000000001 R14: ffff88810c064000 R15: ffff8881039cc000
FS: 0000000000000000(0000) GS:ffff888157c00000(0000)
knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fe3728b1000 CR3: 000000010caa4000 CR4: 0000000000750ef0
PKRU: 55555554
Call Trace:
 <TASK>
 ? die_addr+0x36/0x90
 ? exc_general_protection+0x1c1/0x3f0
 ? asm_exc_general_protection+0x26/0x30
 ? __list_del_entry_valid_or_report+0x33/0xf0
 __cifs_put_smb_ses+0x1ae/0x500 [cifs]
 smb2_reconnect_server+0x4ed/0x710 [cifs]
 process_one_work+0x205/0x6b0
 worker_thread+0x191/0x360
 ? __pfx_worker_thread+0x10/0x10
 kthread+0xe2/0x110
 ? __pfx_kthread+0x10/0x10
 ret_from_fork+0x34/0x50
 ? __pfx_kthread+0x10/0x10
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
---
v1 -> v2: add missing comments in reproducer

 fs/smb/client/connect.c | 87 +++++++++++++++++------------------------
 1 file changed, 36 insertions(+), 51 deletions(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 9b85b5341822..ee29bc57300c 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -232,7 +232,13 @@ cifs_mark_tcp_ses_conns_for_reconnect(struct TCP_Server_Info *server,
 
 	spin_lock(&cifs_tcp_ses_lock);
 	list_for_each_entry_safe(ses, nses, &pserver->smb_ses_list, smb_ses_list) {
-		/* check if iface is still active */
+		spin_lock(&ses->ses_lock);
+		if (ses->ses_status == SES_EXITING) {
+			spin_unlock(&ses->ses_lock);
+			continue;
+		}
+		spin_unlock(&ses->ses_lock);
+
 		spin_lock(&ses->chan_lock);
 		if (cifs_ses_get_chan_index(ses, server) ==
 		    CIFS_INVAL_CHAN_INDEX) {
@@ -1963,31 +1969,6 @@ cifs_setup_ipc(struct cifs_ses *ses, struct smb3_fs_context *ctx)
 	return rc;
 }
 
-/**
- * cifs_free_ipc - helper to release the session IPC tcon
- * @ses: smb session to unmount the IPC from
- *
- * Needs to be called everytime a session is destroyed.
- *
- * On session close, the IPC is closed and the server must release all tcons of the session.
- * No need to send a tree disconnect here.
- *
- * Besides, it will make the server to not close durable and resilient files on session close, as
- * specified in MS-SMB2 3.3.5.6 Receiving an SMB2 LOGOFF Request.
- */
-static int
-cifs_free_ipc(struct cifs_ses *ses)
-{
-	struct cifs_tcon *tcon = ses->tcon_ipc;
-
-	if (tcon == NULL)
-		return 0;
-
-	tconInfoFree(tcon);
-	ses->tcon_ipc = NULL;
-	return 0;
-}
-
 static struct cifs_ses *
 cifs_find_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 {
@@ -2019,48 +2000,52 @@ cifs_find_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 void __cifs_put_smb_ses(struct cifs_ses *ses)
 {
 	struct TCP_Server_Info *server = ses->server;
+	struct cifs_tcon *tcon;
 	unsigned int xid;
 	size_t i;
+	bool do_logoff;
 	int rc;
 
-	spin_lock(&ses->ses_lock);
-	if (ses->ses_status == SES_EXITING) {
-		spin_unlock(&ses->ses_lock);
-		return;
-	}
-	spin_unlock(&ses->ses_lock);
-
-	cifs_dbg(FYI, "%s: ses_count=%d\n", __func__, ses->ses_count);
-	cifs_dbg(FYI,
-		 "%s: ses ipc: %s\n", __func__, ses->tcon_ipc ? ses->tcon_ipc->tree_name : "NONE");
-
 	spin_lock(&cifs_tcp_ses_lock);
-	if (--ses->ses_count > 0) {
+	spin_lock(&ses->ses_lock);
+	cifs_dbg(FYI, "%s: id=0x%llx ses_count=%d ses_status=%u ipc=%s\n",
+		 __func__, ses->Suid, ses->ses_count, ses->ses_status,
+		 ses->tcon_ipc ? ses->tcon_ipc->tree_name : "none");
+	if (ses->ses_status == SES_EXITING || --ses->ses_count > 0) {
+		spin_unlock(&ses->ses_lock);
 		spin_unlock(&cifs_tcp_ses_lock);
 		return;
 	}
-	spin_lock(&ses->ses_lock);
-	if (ses->ses_status == SES_GOOD)
-		ses->ses_status = SES_EXITING;
-	spin_unlock(&ses->ses_lock);
-	spin_unlock(&cifs_tcp_ses_lock);
-
 	/* ses_count can never go negative */
 	WARN_ON(ses->ses_count < 0);
 
-	spin_lock(&ses->ses_lock);
-	if (ses->ses_status == SES_EXITING && server->ops->logoff) {
-		spin_unlock(&ses->ses_lock);
-		cifs_free_ipc(ses);
+	spin_lock(&ses->chan_lock);
+	cifs_chan_clear_need_reconnect(ses, server);
+	spin_unlock(&ses->chan_lock);
+
+	do_logoff = ses->ses_status == SES_GOOD && server->ops->logoff;
+	ses->ses_status = SES_EXITING;
+	tcon = ses->tcon_ipc;
+	ses->tcon_ipc = NULL;
+	spin_unlock(&ses->ses_lock);
+	spin_unlock(&cifs_tcp_ses_lock);
+
+	/*
+	 * On session close, the IPC is closed and the server must release all
+	 * tcons of the session.  No need to send a tree disconnect here.
+	 *
+	 * Besides, it will make the server to not close durable and resilient
+	 * files on session close, as specified in MS-SMB2 3.3.5.6 Receiving an
+	 * SMB2 LOGOFF Request.
+	 */
+	tconInfoFree(tcon);
+	if (do_logoff) {
 		xid = get_xid();
 		rc = server->ops->logoff(xid, ses);
 		if (rc)
 			cifs_server_dbg(VFS, "%s: Session Logoff failure rc=%d\n",
 				__func__, rc);
 		_free_xid(xid);
-	} else {
-		spin_unlock(&ses->ses_lock);
-		cifs_free_ipc(ses);
 	}
 
 	spin_lock(&cifs_tcp_ses_lock);
-- 
2.44.0


