Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 308C0496E61
	for <lists+linux-cifs@lfdr.de>; Sun, 23 Jan 2022 01:11:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235183AbiAWALr (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 22 Jan 2022 19:11:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235170AbiAWALo (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 22 Jan 2022 19:11:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30A41C06173B;
        Sat, 22 Jan 2022 16:11:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B741C60DCB;
        Sun, 23 Jan 2022 00:11:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35DEDC340E7;
        Sun, 23 Jan 2022 00:11:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642896703;
        bh=Tc+ralUCr4d7Hr5t+NyESJ0qiDEF2Yt26/wg7XkvEJ4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mMXDAcCDRRjMBWjpdLt2HHte69/b898lNbOIBROoCWoGsVSiy+SQ68DqMAo29C3Qm
         YNlaa8S+mQgbhqfvzYx9jSdd1wlDel+BxNxXGx5/DOtSCt1EsNwwIFpL0dzqSOqcEn
         bxht9zayqQy8zfSWhziAYTZyFMZ8DZCPAKeE9v5MpTMtygW+2ctBaEfA1x7SkBDCOK
         LgNJOrYEZtYiETUgK4BWUvXm4zAPg135PIo7HlN2xn+o8lhof5o6FOJkFDRS0g4r5i
         yvri7sj9IsZUhcnfmHvdF9Q9vCbb5j2yKHro4FzhQXITN6FE5mGwFXwbPnZE7y2nwP
         I4gbIfbew6obQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Hyunchul Lee <hyc.lee@gmail.com>,
        Namjae Jeon <linkinjeon@kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, senozhatsky@chromium.org,
        sfrench@samba.org, linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 5.16 05/19] ksmbd: smbd: call rdma_accept() under CM handler
Date:   Sat, 22 Jan 2022 19:10:58 -0500
Message-Id: <20220123001113.2460140-5-sashal@kernel.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220123001113.2460140-1-sashal@kernel.org>
References: <20220123001113.2460140-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

From: Hyunchul Lee <hyc.lee@gmail.com>

[ Upstream commit 99b7650ac51847e81b4d5139824e321e6cb76130 ]

if CONFIG_LOCKDEP is enabled, the following
kernel warning message is generated because
rdma_accept() checks whehter the handler_mutex
is held by lockdep_assert_held. CM(Connection
Manager) holds the mutex before CM handler
callback is called.

[   63.211405 ] WARNING: CPU: 1 PID: 345 at drivers/infiniband/core/cma.c:4405 rdma_accept+0x17a/0x350
[   63.212080 ] RIP: 0010:rdma_accept+0x17a/0x350
...
[   63.214036 ] Call Trace:
[   63.214098 ]  <TASK>
[   63.214185 ]  smb_direct_accept_client+0xb4/0x170 [ksmbd]
[   63.214412 ]  smb_direct_prepare+0x322/0x8c0 [ksmbd]
[   63.214555 ]  ? rcu_read_lock_sched_held+0x3a/0x70
[   63.214700 ]  ksmbd_conn_handler_loop+0x63/0x270 [ksmbd]
[   63.214826 ]  ? ksmbd_conn_alive+0x80/0x80 [ksmbd]
[   63.214952 ]  kthread+0x171/0x1a0
[   63.215039 ]  ? set_kthread_struct+0x40/0x40
[   63.215128 ]  ret_from_fork+0x22/0x30

To avoid this, move creating a queue pair and accepting
a client from transport_ops->prepare() to
smb_direct_handle_connect_request().

Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ksmbd/transport_rdma.c | 102 ++++++++++++++++++++++----------------
 1 file changed, 59 insertions(+), 43 deletions(-)

diff --git a/fs/ksmbd/transport_rdma.c b/fs/ksmbd/transport_rdma.c
index 7e57cbb0bb356..1d28175b90158 100644
--- a/fs/ksmbd/transport_rdma.c
+++ b/fs/ksmbd/transport_rdma.c
@@ -555,6 +555,7 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 		}
 		t->negotiation_requested = true;
 		t->full_packet_received = true;
+		enqueue_reassembly(t, recvmsg, 0);
 		wake_up_interruptible(&t->wait_status);
 		break;
 	case SMB_DIRECT_MSG_DATA_TRANSFER: {
@@ -1581,19 +1582,13 @@ static int smb_direct_accept_client(struct smb_direct_transport *t)
 		pr_err("error at rdma_accept: %d\n", ret);
 		return ret;
 	}
-
-	wait_event_interruptible(t->wait_status,
-				 t->status != SMB_DIRECT_CS_NEW);
-	if (t->status != SMB_DIRECT_CS_CONNECTED)
-		return -ENOTCONN;
 	return 0;
 }
 
-static int smb_direct_negotiate(struct smb_direct_transport *t)
+static int smb_direct_prepare_negotiation(struct smb_direct_transport *t)
 {
 	int ret;
 	struct smb_direct_recvmsg *recvmsg;
-	struct smb_direct_negotiate_req *req;
 
 	recvmsg = get_free_recvmsg(t);
 	if (!recvmsg)
@@ -1603,44 +1598,20 @@ static int smb_direct_negotiate(struct smb_direct_transport *t)
 	ret = smb_direct_post_recv(t, recvmsg);
 	if (ret) {
 		pr_err("Can't post recv: %d\n", ret);
-		goto out;
+		goto out_err;
 	}
 
 	t->negotiation_requested = false;
 	ret = smb_direct_accept_client(t);
 	if (ret) {
 		pr_err("Can't accept client\n");
-		goto out;
+		goto out_err;
 	}
 
 	smb_direct_post_recv_credits(&t->post_recv_credits_work.work);
-
-	ksmbd_debug(RDMA, "Waiting for SMB_DIRECT negotiate request\n");
-	ret = wait_event_interruptible_timeout(t->wait_status,
-					       t->negotiation_requested ||
-						t->status == SMB_DIRECT_CS_DISCONNECTED,
-					       SMB_DIRECT_NEGOTIATE_TIMEOUT * HZ);
-	if (ret <= 0 || t->status == SMB_DIRECT_CS_DISCONNECTED) {
-		ret = ret < 0 ? ret : -ETIMEDOUT;
-		goto out;
-	}
-
-	ret = smb_direct_check_recvmsg(recvmsg);
-	if (ret == -ECONNABORTED)
-		goto out;
-
-	req = (struct smb_direct_negotiate_req *)recvmsg->packet;
-	t->max_recv_size = min_t(int, t->max_recv_size,
-				 le32_to_cpu(req->preferred_send_size));
-	t->max_send_size = min_t(int, t->max_send_size,
-				 le32_to_cpu(req->max_receive_size));
-	t->max_fragmented_send_size =
-			le32_to_cpu(req->max_fragmented_size);
-
-	ret = smb_direct_send_negotiate_response(t, ret);
-out:
-	if (recvmsg)
-		put_recvmsg(t, recvmsg);
+	return 0;
+out_err:
+	put_recvmsg(t, recvmsg);
 	return ret;
 }
 
@@ -1877,6 +1848,47 @@ static int smb_direct_create_qpair(struct smb_direct_transport *t,
 static int smb_direct_prepare(struct ksmbd_transport *t)
 {
 	struct smb_direct_transport *st = smb_trans_direct_transfort(t);
+	struct smb_direct_recvmsg *recvmsg;
+	struct smb_direct_negotiate_req *req;
+	int ret;
+
+	ksmbd_debug(RDMA, "Waiting for SMB_DIRECT negotiate request\n");
+	ret = wait_event_interruptible_timeout(st->wait_status,
+					       st->negotiation_requested ||
+					       st->status == SMB_DIRECT_CS_DISCONNECTED,
+					       SMB_DIRECT_NEGOTIATE_TIMEOUT * HZ);
+	if (ret <= 0 || st->status == SMB_DIRECT_CS_DISCONNECTED)
+		return ret < 0 ? ret : -ETIMEDOUT;
+
+	recvmsg = get_first_reassembly(st);
+	if (!recvmsg)
+		return -ECONNABORTED;
+
+	ret = smb_direct_check_recvmsg(recvmsg);
+	if (ret == -ECONNABORTED)
+		goto out;
+
+	req = (struct smb_direct_negotiate_req *)recvmsg->packet;
+	st->max_recv_size = min_t(int, st->max_recv_size,
+				  le32_to_cpu(req->preferred_send_size));
+	st->max_send_size = min_t(int, st->max_send_size,
+				  le32_to_cpu(req->max_receive_size));
+	st->max_fragmented_send_size =
+			le32_to_cpu(req->max_fragmented_size);
+
+	ret = smb_direct_send_negotiate_response(st, ret);
+out:
+	spin_lock_irq(&st->reassembly_queue_lock);
+	st->reassembly_queue_length--;
+	list_del(&recvmsg->list);
+	spin_unlock_irq(&st->reassembly_queue_lock);
+	put_recvmsg(st, recvmsg);
+
+	return ret;
+}
+
+static int smb_direct_connect(struct smb_direct_transport *st)
+{
 	int ret;
 	struct ib_qp_cap qp_cap;
 
@@ -1898,13 +1910,11 @@ static int smb_direct_prepare(struct ksmbd_transport *t)
 		return ret;
 	}
 
-	ret = smb_direct_negotiate(st);
+	ret = smb_direct_prepare_negotiation(st);
 	if (ret) {
 		pr_err("Can't negotiate: %d\n", ret);
 		return ret;
 	}
-
-	st->status = SMB_DIRECT_CS_CONNECTED;
 	return 0;
 }
 
@@ -1920,6 +1930,7 @@ static bool rdma_frwr_is_supported(struct ib_device_attr *attrs)
 static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
 {
 	struct smb_direct_transport *t;
+	int ret;
 
 	if (!rdma_frwr_is_supported(&new_cm_id->device->attrs)) {
 		ksmbd_debug(RDMA,
@@ -1932,18 +1943,23 @@ static int smb_direct_handle_connect_request(struct rdma_cm_id *new_cm_id)
 	if (!t)
 		return -ENOMEM;
 
+	ret = smb_direct_connect(t);
+	if (ret)
+		goto out_err;
+
 	KSMBD_TRANS(t)->handler = kthread_run(ksmbd_conn_handler_loop,
 					      KSMBD_TRANS(t)->conn, "ksmbd:r%u",
 					      SMB_DIRECT_PORT);
 	if (IS_ERR(KSMBD_TRANS(t)->handler)) {
-		int ret = PTR_ERR(KSMBD_TRANS(t)->handler);
-
+		ret = PTR_ERR(KSMBD_TRANS(t)->handler);
 		pr_err("Can't start thread\n");
-		free_transport(t);
-		return ret;
+		goto out_err;
 	}
 
 	return 0;
+out_err:
+	free_transport(t);
+	return ret;
 }
 
 static int smb_direct_listen_handler(struct rdma_cm_id *cm_id,
-- 
2.34.1

