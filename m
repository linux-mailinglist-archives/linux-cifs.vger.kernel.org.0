Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6C4A21D9FA2
	for <lists+linux-cifs@lfdr.de>; Tue, 19 May 2020 20:39:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgESSjB (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 19 May 2020 14:39:01 -0400
Received: from mx.cjr.nz ([51.158.111.142]:15636 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726643AbgESSjA (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 19 May 2020 14:39:00 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id AD90780345;
        Tue, 19 May 2020 18:38:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1589913538;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=p8jGa/Q6j9cDpGw4xrDbGdNoIBPHyou4UR0io0xTwIY=;
        b=dZ1k9LLF/XRyQfPeO7Eek924NLOmczN//WjW9cZFtUBGl8/ABVQhoRgEE3TnovJ4eeWY0l
        i9e06K8nBDTLXaHIEitPhHsieIqf3UmyhMycMQDIh3TWUgL+xiZwk2nU6PoL7Pdp7fN/FT
        nczgs86yFoW2o54ICcScifM9vwqTTNU2kJ68woEPrbuB/1zJZ5JzCIqnD8am/3GwKKZEC7
        0h+yDK+nmAZN3epZawzlOb8TiNuTX69HBXN8Q5cIctxGyC/zw6Ocvxey1H98uXjqkOXK7I
        REJwaeuR3qeOsL7LpDVt4fAfwYPaLN+GehhTESMAP8qUOYuGSdFyXXw4/el9jg==
From:   Paulo Alcantara <pc@cjr.nz>
To:     linux-cifs@vger.kernel.org, smfrench@gmail.com
Cc:     Paulo Alcantara <pc@cjr.nz>
Subject: [PATCH 1/3] cifs: set up next DFS target before generic_ip_connect()
Date:   Tue, 19 May 2020 15:38:27 -0300
Message-Id: <20200519183829.5512-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

If we mount a very specific DFS link

    \\FS0.FOO.COM\dfs\link -> \FS0\share1, \FS1\share2

where its target list contains NB names ("FS0" & "FS1") rather than
FQDN ones ("FS0.FOO.COM" & "FS1.FOO.COM"), we end up connecting to
\FOO\share1 but server->hostname will have "FOO.COM".  The reason is
because both "FS0" and "FS0.FOO.COM" resolve to same IP address and
they share same TCP server connection, but "FS0.FOO.COM" was the first
hostname set -- which is OK.

However, if the echo thread timeouts and we still have a good
connection to "FS0", in cifs_reconnect()

    rc = generic_ip_connect(server) -> success
    if (rc) {
            ...
            reconn_inval_dfs_target(server, cifs_sb, &tgt_list,
	                            &tgt_it);
            ...
     }
     ...

it successfully reconnects to "FS0" server but does not set up next
DFS target - which should be the same target server "\FS0\share1" -
and server->hostname remains set to "FS0.FOO.COM" rather than "FS0",
as reconn_inval_dfs_target() would have it set to "FS0" if called
earlier.

Finally, in __smb2_reconnect(), the reconnect of tcons would fail
because tcon->ses->server->hostname (FS0.FOO.COM) does not match DFS
target's hostname (FS0).

Fix that by calling reconn_inval_dfs_target() before
generic_ip_connect() so server->hostname will get updated correctly
prior to reconnecting its tcons in __smb2_reconnect().

With "cifs: handle hostnames that resolve to same ip in failover"
patch

    - The above problem would not occur.
    - We could save an DNS query to find out that they both resolve to
      the same ip address.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---
 fs/cifs/connect.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 28268ed461b8..47b9fbb70bf5 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -572,26 +572,26 @@ cifs_reconnect(struct TCP_Server_Info *server)
 		try_to_freeze();
 
 		mutex_lock(&server->srv_mutex);
+#ifdef CONFIG_CIFS_DFS_UPCALL
 		/*
 		 * Set up next DFS target server (if any) for reconnect. If DFS
 		 * feature is disabled, then we will retry last server we
 		 * connected to before.
 		 */
+		reconn_inval_dfs_target(server, cifs_sb, &tgt_list, &tgt_it);
+#endif
+		rc = reconn_set_ipaddr(server);
+		if (rc) {
+			cifs_dbg(FYI, "%s: failed to resolve hostname: %d\n",
+				 __func__, rc);
+		}
+
 		if (cifs_rdma_enabled(server))
 			rc = smbd_reconnect(server);
 		else
 			rc = generic_ip_connect(server);
 		if (rc) {
 			cifs_dbg(FYI, "reconnect error %d\n", rc);
-#ifdef CONFIG_CIFS_DFS_UPCALL
-			reconn_inval_dfs_target(server, cifs_sb, &tgt_list,
-						&tgt_it);
-#endif
-			rc = reconn_set_ipaddr(server);
-			if (rc) {
-				cifs_dbg(FYI, "%s: failed to resolve hostname: %d\n",
-					 __func__, rc);
-			}
 			mutex_unlock(&server->srv_mutex);
 			msleep(3000);
 		} else {
-- 
2.26.2

