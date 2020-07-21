Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C18B6228017
	for <lists+linux-cifs@lfdr.de>; Tue, 21 Jul 2020 14:38:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgGUMhn (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 21 Jul 2020 08:37:43 -0400
Received: from mx.cjr.nz ([51.158.111.142]:36970 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbgGUMhn (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 21 Jul 2020 08:37:43 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 4ED6A7FEC8;
        Tue, 21 Jul 2020 12:37:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1595335062;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=59HI2DVsMYKdwKCrIdJVB7U/3sYGb2Ce7eq9i3VB8oE=;
        b=FBvEMzn/Gfw5ZkFS4IKh7HK6aJJGjfvrypopaehLDy7Z3tyECxMrmvRlxbJemLKq2oOjAf
        zmFqclKVPUQTHhBO82BY5z1LIgRd5ePp1Uslr8BbPru+9GXl++eWWCUX2WbGGfW6VV0CJ0
        yK33sU1wx9tGwxjaxpzsE4AZSNCsdm9rojrHJZNbh65BB5ThLZb3Xu2tNvHe2xbQFIQHlq
        eB2LjAJZaOfzSFejt9fwp5td7zbQLzz0iwqP8O968P/C9nQlUSzWO0gPWcTs44z42s5GSs
        CxN0CXS5lF0w9QawWxkwSXKRJqgBARudJNzwYTsME+Pj4IOm2GK75AJH3X3eYA==
From:   Paulo Alcantara <pc@cjr.nz>
To:     linux-cifs@vger.kernel.org, smfrench@gmail.com
Cc:     Paulo Alcantara <pc@cjr.nz>, Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH v3 4/7] cifs: handle empty list of targets in cifs_reconnect()
Date:   Tue, 21 Jul 2020 09:36:41 -0300
Message-Id: <20200721123644.14728-5-pc@cjr.nz>
In-Reply-To: <20200721123644.14728-1-pc@cjr.nz>
References: <20200721123644.14728-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

In case there were no cached DFS referrals in
reconn_setup_dfs_targets(), set cifs_sb to NULL prior to calling
reconn_set_next_dfs_target() so it would not try to access an empty
tgt_list.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
---
 fs/cifs/connect.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 9582f63b8ebc..1f35d84ed118 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -470,11 +470,13 @@ cifs_reconnect(struct TCP_Server_Info *server)
 		sb = NULL;
 	} else {
 		cifs_sb = CIFS_SB(sb);
-
 		rc = reconn_setup_dfs_targets(cifs_sb, &tgt_list);
-		if (rc && (rc != -EOPNOTSUPP)) {
-			cifs_server_dbg(VFS, "%s: no target servers for DFS failover\n",
-				 __func__);
+		if (rc) {
+			cifs_sb = NULL;
+			if (rc != -EOPNOTSUPP) {
+				cifs_server_dbg(VFS, "%s: no target servers for DFS failover\n",
+						__func__);
+			}
 		} else {
 			server->nr_targets = dfs_cache_get_nr_tgts(&tgt_list);
 		}
-- 
2.27.0

