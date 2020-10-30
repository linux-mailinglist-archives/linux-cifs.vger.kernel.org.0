Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57D632A04BF
	for <lists+linux-cifs@lfdr.de>; Fri, 30 Oct 2020 12:53:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726120AbgJ3Lwy (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 30 Oct 2020 07:52:54 -0400
Received: from mx2.suse.de ([195.135.220.15]:47500 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726055AbgJ3Lwx (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 30 Oct 2020 07:52:53 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id AB66DAF01
        for <linux-cifs@vger.kernel.org>; Fri, 30 Oct 2020 11:52:24 +0000 (UTC)
From:   Samuel Cabrero <scabrero@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     Samuel Cabrero <scabrero@suse.de>
Subject: [PATCH v3 08/11] cifs: Send witness register messages to userspace daemon in echo task
Date:   Fri, 30 Oct 2020 12:52:07 +0100
Message-Id: <20201030115210.8888-9-scabrero@suse.de>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201030115210.8888-1-scabrero@suse.de>
References: <20201030115210.8888-1-scabrero@suse.de>
Reply-To: scabrero@suse.de
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

If the daemon starts after mounting a share, or if it crashes, this
provides a mechanism to register again.

Signed-off-by: Samuel Cabrero <scabrero@suse.de>
---
 fs/cifs/cifs_swn.c | 15 +++++++++++++++
 fs/cifs/cifs_swn.h |  2 ++
 fs/cifs/connect.c  |  5 +++++
 3 files changed, 22 insertions(+)

diff --git a/fs/cifs/cifs_swn.c b/fs/cifs/cifs_swn.c
index 4396e21ef228..93e31e4a9d99 100644
--- a/fs/cifs/cifs_swn.c
+++ b/fs/cifs/cifs_swn.c
@@ -536,3 +536,18 @@ void cifs_swn_dump(struct seq_file *m)
 	mutex_unlock(&cifs_swnreg_idr_mutex);
 	seq_puts(m, "\n");
 }
+
+void cifs_swn_check(void)
+{
+	struct cifs_swn_reg *swnreg;
+	int id;
+	int ret;
+
+	mutex_lock(&cifs_swnreg_idr_mutex);
+	idr_for_each_entry(&cifs_swnreg_idr, swnreg, id) {
+		ret = cifs_swn_send_register_message(swnreg);
+		if (ret < 0)
+			cifs_dbg(FYI, "%s: Failed to send register message: %d\n", __func__, ret);
+	}
+	mutex_unlock(&cifs_swnreg_idr_mutex);
+}
diff --git a/fs/cifs/cifs_swn.h b/fs/cifs/cifs_swn.h
index 13b25cdc9295..236ecd4959d5 100644
--- a/fs/cifs/cifs_swn.h
+++ b/fs/cifs/cifs_swn.h
@@ -20,4 +20,6 @@ extern int cifs_swn_notify(struct sk_buff *skb, struct genl_info *info);
 
 extern void cifs_swn_dump(struct seq_file *m);
 
+extern void cifs_swn_check(void);
+
 #endif /* _CIFS_SWN_H */
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 0e3a88932560..cb9ca4238ae9 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -613,6 +613,11 @@ cifs_echo_request(struct work_struct *work)
 		cifs_dbg(FYI, "Unable to send echo request to server: %s\n",
 			 server->hostname);
 
+#ifdef CONFIG_CIFS_SWN_UPCALL
+	/* Check witness registrations */
+	cifs_swn_check();
+#endif
+
 requeue_echo:
 	queue_delayed_work(cifsiod_wq, &server->echo, server->echo_interval);
 }
-- 
2.29.0

