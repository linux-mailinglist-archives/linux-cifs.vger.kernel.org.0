Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F25AB629469
	for <lists+linux-cifs@lfdr.de>; Tue, 15 Nov 2022 10:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229842AbiKOJfD (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 15 Nov 2022 04:35:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiKOJfC (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 15 Nov 2022 04:35:02 -0500
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F0413E35
        for <linux-cifs@vger.kernel.org>; Tue, 15 Nov 2022 01:35:00 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4NBLY30ZxHzJnkN;
        Tue, 15 Nov 2022 17:31:51 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 15 Nov 2022 17:34:58 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <linux-cifs@vger.kernel.org>, <zhangxiaoxu5@huawei.com>,
        <sfrench@samba.org>, <smfrench@gmail.com>, <pc@cjr.nz>,
        <lsahlber@redhat.com>, <sprasad@microsoft.com>, <tom@talpey.com>
Subject: [PATCH 2/3] cifs: Fix UAF in cifs_demultiplex_thread()
Date:   Tue, 15 Nov 2022 18:39:35 +0800
Message-ID: <20221115103936.3303416-3-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221115103936.3303416-1-zhangxiaoxu5@huawei.com>
References: <20221115103936.3303416-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

There is a UAF when xfstests on cifs:

  BUG: KASAN: use-after-free in smb2_is_network_name_deleted+0x27/0x160
  Read of size 4 at addr ffff88810103fc08 by task cifsd/923

  CPU: 1 PID: 923 Comm: cifsd Not tainted 6.1.0-rc4+ #45
  ...
  Call Trace:
   <TASK>
   dump_stack_lvl+0x34/0x44
   print_report+0x171/0x472
   kasan_report+0xad/0x130
   kasan_check_range+0x145/0x1a0
   smb2_is_network_name_deleted+0x27/0x160
   cifs_demultiplex_thread.cold+0x172/0x5a4
   kthread+0x165/0x1a0
   ret_from_fork+0x1f/0x30
   </TASK>

  Allocated by task 923:
   kasan_save_stack+0x1e/0x40
   kasan_set_track+0x21/0x30
   __kasan_slab_alloc+0x54/0x60
   kmem_cache_alloc+0x147/0x320
   mempool_alloc+0xe1/0x260
   cifs_small_buf_get+0x24/0x60
   allocate_buffers+0xa1/0x1c0
   cifs_demultiplex_thread+0x199/0x10d0
   kthread+0x165/0x1a0
   ret_from_fork+0x1f/0x30

  Freed by task 921:
   kasan_save_stack+0x1e/0x40
   kasan_set_track+0x21/0x30
   kasan_save_free_info+0x2a/0x40
   ____kasan_slab_free+0x143/0x1b0
   kmem_cache_free+0xe3/0x4d0
   cifs_small_buf_release+0x29/0x90
   SMB2_negotiate+0x8b7/0x1c60
   smb2_negotiate+0x51/0x70
   cifs_negotiate_protocol+0xf0/0x160
   cifs_get_smb_ses+0x5fa/0x13c0
   mount_get_conns+0x7a/0x750
   cifs_mount+0x103/0xd00
   cifs_smb3_do_mount+0x1dd/0xcb0
   smb3_get_tree+0x1d5/0x300
   vfs_get_tree+0x41/0xf0
   path_mount+0x9b3/0xdd0
   __x64_sys_mount+0x190/0x1d0
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

The UAF is because:

 mount(pid: 921)               | cifsd(pid: 923)
-------------------------------|-------------------------------
                               | cifs_demultiplex_thread
SMB2_negotiate                 |
 cifs_send_recv                |
  compound_send_recv           |
   smb_send_rqst               |
    wait_for_response          |
     wait_event_state      [1] |
                               |  standard_receive3
                               |   cifs_handle_standard
                               |    handle_mid
                               |     mid->resp_buf = buf;  [2]
                               |     dequeue_mid           [3]
     KILL the process      [4] |
    resp_iov[i].iov_base = buf |
 free_rsp_buf              [5] |
                               |   is_network_name_deleted [6]
                               |   callback

1. After send request to server, wait the response until
    mid->mid_state != SUBMITTED;
2. Receive response from server, and set it to mid;
3. Set the mid state to RECEIVED;
4. Kill the process, the mid state already RECEIVED, get 0;
5. Handle and release the negotiate response;
6. UAF.

It can be easily reproduce with add some delay in [3] - [6].

Only sync call has the problem since async call's callback is
executed in cifsd process.

Add an extra state to mark the mid state to READY before wakeup the
waitter, then it can get the resp safely.

Fixes: ec637e3ffb6b ("[CIFS] Avoid extra large buffer allocation (and memcpy) in cifs_readpages")
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/cifs/cifsglob.h  |  1 +
 fs/cifs/transport.c | 32 +++++++++++++++++++++-----------
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 1420acf987f0..637b33b355c6 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1810,6 +1810,7 @@ static inline bool is_retryable_error(int error)
 #define   MID_RETRY_NEEDED      8 /* session closed while this request out */
 #define   MID_RESPONSE_MALFORMED 0x10
 #define   MID_SHUTDOWN		 0x20
+#define   MID_RESPONSE_READY 0x40 /* ready for other process handle the rsp */
 
 /* Flags */
 #define   MID_WAIT_CANCELLED	 1 /* Cancelled while waiting for response */
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 575fa8f58342..dea5228899fb 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -87,7 +87,8 @@ static void __release_mid(struct kref *refcount)
 	struct TCP_Server_Info *server = midEntry->server;
 
 	if (midEntry->resp_buf && (midEntry->mid_flags & MID_WAIT_CANCELLED) &&
-	    midEntry->mid_state == MID_RESPONSE_RECEIVED &&
+	    (midEntry->mid_state == MID_RESPONSE_RECEIVED ||
+	     midEntry->mid_state == MID_RESPONSE_READY) &&
 	    server->ops->handle_cancelled_mid)
 		server->ops->handle_cancelled_mid(midEntry, server);
 
@@ -754,7 +755,8 @@ wait_for_response(struct TCP_Server_Info *server, struct mid_q_entry *midQ)
 	int error;
 
 	error = wait_event_state(server->response_q,
-				 midQ->mid_state != MID_REQUEST_SUBMITTED,
+				 midQ->mid_state != MID_REQUEST_SUBMITTED &&
+				 midQ->mid_state != MID_RESPONSE_RECEIVED,
 				 (TASK_KILLABLE|TASK_FREEZABLE_UNSAFE));
 	if (error < 0)
 		return -ERESTARTSYS;
@@ -909,7 +911,7 @@ cifs_sync_mid_result(struct mid_q_entry *mid, struct TCP_Server_Info *server)
 
 	spin_lock(&server->mid_lock);
 	switch (mid->mid_state) {
-	case MID_RESPONSE_RECEIVED:
+	case MID_RESPONSE_READY:
 		spin_unlock(&server->mid_lock);
 		return rc;
 	case MID_RETRY_NEEDED:
@@ -1008,6 +1010,9 @@ cifs_compound_callback(struct mid_q_entry *mid)
 	credits.instance = server->reconnect_instance;
 
 	add_credits(server, &credits, mid->optype);
+
+	if (mid->mid_state == MID_RESPONSE_RECEIVED)
+		mid->mid_state = MID_RESPONSE_READY;
 }
 
 static void
@@ -1205,7 +1210,8 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 			send_cancel(server, &rqst[i], midQ[i]);
 			spin_lock(&server->mid_lock);
 			midQ[i]->mid_flags |= MID_WAIT_CANCELLED;
-			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED) {
+			if (midQ[i]->mid_state == MID_REQUEST_SUBMITTED ||
+			    midQ[i]->mid_state == MID_RESPONSE_RECEIVED) {
 				midQ[i]->callback = cifs_cancelled_callback;
 				cancelled_mid[i] = true;
 				credits[i].value = 0;
@@ -1226,7 +1232,7 @@ compound_send_recv(const unsigned int xid, struct cifs_ses *ses,
 		}
 
 		if (!midQ[i]->resp_buf ||
-		    midQ[i]->mid_state != MID_RESPONSE_RECEIVED) {
+		    midQ[i]->mid_state != MID_RESPONSE_READY) {
 			rc = -EIO;
 			cifs_dbg(FYI, "Bad MID state?\n");
 			goto out;
@@ -1415,7 +1421,8 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	if (rc != 0) {
 		send_cancel(server, &rqst, midQ);
 		spin_lock(&server->mid_lock);
-		if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
+		if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		    midQ->mid_state == MID_RESPONSE_RECEIVED) {
 			/* no longer considered to be "in-flight" */
 			midQ->callback = release_mid;
 			spin_unlock(&server->mid_lock);
@@ -1432,7 +1439,7 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	}
 
 	if (!midQ->resp_buf || !out_buf ||
-	    midQ->mid_state != MID_RESPONSE_RECEIVED) {
+	    midQ->mid_state != MID_RESPONSE_READY) {
 		rc = -EIO;
 		cifs_server_dbg(VFS, "Bad MID state?\n");
 		goto out;
@@ -1558,14 +1565,16 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 
 	/* Wait for a reply - allow signals to interrupt. */
 	rc = wait_event_interruptible(server->response_q,
-		(!(midQ->mid_state == MID_REQUEST_SUBMITTED)) ||
+		(!(midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		   midQ->mid_state == MID_RESPONSE_RECEIVED)) ||
 		((server->tcpStatus != CifsGood) &&
 		 (server->tcpStatus != CifsNew)));
 
 	/* Were we interrupted by a signal ? */
 	spin_lock(&server->srv_lock);
 	if ((rc == -ERESTARTSYS) &&
-		(midQ->mid_state == MID_REQUEST_SUBMITTED) &&
+		(midQ->mid_state == MID_REQUEST_SUBMITTED ||
+		 midQ->mid_state == MID_RESPONSE_RECEIVED) &&
 		((server->tcpStatus == CifsGood) ||
 		 (server->tcpStatus == CifsNew))) {
 		spin_unlock(&server->srv_lock);
@@ -1596,7 +1605,8 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 		if (rc) {
 			send_cancel(server, &rqst, midQ);
 			spin_lock(&server->mid_lock);
-			if (midQ->mid_state == MID_REQUEST_SUBMITTED) {
+			if (midQ->mid_state == MID_REQUEST_SUBMITTED ||
+			    midQ->mid_state == MID_RESPONSE_RECEIVED) {
 				/* no longer considered to be "in-flight" */
 				midQ->callback = release_mid;
 				spin_unlock(&server->mid_lock);
@@ -1616,7 +1626,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 		return rc;
 
 	/* rcvd frame is ok */
-	if (out_buf == NULL || midQ->mid_state != MID_RESPONSE_RECEIVED) {
+	if (out_buf == NULL || midQ->mid_state != MID_RESPONSE_READY) {
 		rc = -EIO;
 		cifs_tcon_dbg(VFS, "Bad MID state?\n");
 		goto out;
-- 
2.31.1

