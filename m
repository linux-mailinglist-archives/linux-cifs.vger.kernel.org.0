Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CABC92C8C09
	for <lists+linux-cifs@lfdr.de>; Mon, 30 Nov 2020 19:04:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729396AbgK3SEe (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 30 Nov 2020 13:04:34 -0500
Received: from mx2.suse.de ([195.135.220.15]:45776 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729524AbgK3SEd (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 30 Nov 2020 13:04:33 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 90755AF45
        for <linux-cifs@vger.kernel.org>; Mon, 30 Nov 2020 18:03:12 +0000 (UTC)
From:   Samuel Cabrero <scabrero@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     Samuel Cabrero <scabrero@suse.de>
Subject: [PATCH v4 09/11] cifs: Simplify reconnect code when dfs upcall is enabled
Date:   Mon, 30 Nov 2020 19:02:55 +0100
Message-Id: <20201130180257.31787-10-scabrero@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130180257.31787-1-scabrero@suse.de>
References: <20201130180257.31787-1-scabrero@suse.de>
Reply-To: scabrero@suse.de
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Some witness notifications, like client move, tell the client to
reconnect to a specific IP address. In this situation the DFS failover
code path has to be skipped so clean up as much as possible the
cifs_reconnect() code.

Signed-off-by: Samuel Cabrero <scabrero@suse.de>
---
 fs/cifs/connect.c | 21 ++++++++-------------
 1 file changed, 8 insertions(+), 13 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index a298518bebb2..3af88711643b 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -296,7 +296,7 @@ static void cifs_prune_tlinks(struct work_struct *work);
  * This should be called with server->srv_mutex held.
  */
 #ifdef CONFIG_CIFS_DFS_UPCALL
-static int reconn_set_ipaddr(struct TCP_Server_Info *server)
+static int reconn_set_ipaddr_from_hostname(struct TCP_Server_Info *server)
 {
 	int rc;
 	int len;
@@ -331,14 +331,7 @@ static int reconn_set_ipaddr(struct TCP_Server_Info *server)
 
 	return !rc ? -1 : 0;
 }
-#else
-static inline int reconn_set_ipaddr(struct TCP_Server_Info *server)
-{
-	return 0;
-}
-#endif
 
-#ifdef CONFIG_CIFS_DFS_UPCALL
 /* These functions must be called with server->srv_mutex held */
 static void reconn_set_next_dfs_target(struct TCP_Server_Info *server,
 				       struct cifs_sb_info *cifs_sb,
@@ -346,6 +339,7 @@ static void reconn_set_next_dfs_target(struct TCP_Server_Info *server,
 				       struct dfs_cache_tgt_iterator **tgt_it)
 {
 	const char *name;
+	int rc;
 
 	if (!cifs_sb || !cifs_sb->origin_fullpath)
 		return;
@@ -370,6 +364,12 @@ static void reconn_set_next_dfs_target(struct TCP_Server_Info *server,
 			 "%s: failed to extract hostname from target: %ld\n",
 			 __func__, PTR_ERR(server->hostname));
 	}
+
+	rc = reconn_set_ipaddr_from_hostname(server);
+	if (rc) {
+		cifs_dbg(FYI, "%s: failed to resolve hostname: %d\n",
+			 __func__, rc);
+	}
 }
 
 static inline int reconn_setup_dfs_targets(struct cifs_sb_info *cifs_sb,
@@ -528,11 +528,6 @@ cifs_reconnect(struct TCP_Server_Info *server)
 		 */
 		reconn_set_next_dfs_target(server, cifs_sb, &tgt_list, &tgt_it);
 #endif
-		rc = reconn_set_ipaddr(server);
-		if (rc) {
-			cifs_dbg(FYI, "%s: failed to resolve hostname: %d\n",
-				 __func__, rc);
-		}
 
 		if (cifs_rdma_enabled(server))
 			rc = smbd_reconnect(server);
-- 
2.29.2

