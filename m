Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1F9571F44C
	for <lists+linux-cifs@lfdr.de>; Thu,  1 Jun 2023 22:58:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232667AbjFAU6o (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 1 Jun 2023 16:58:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232713AbjFAU6m (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 1 Jun 2023 16:58:42 -0400
Received: from smtp-fw-52003.amazon.com (smtp-fw-52003.amazon.com [52.119.213.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CD2619B;
        Thu,  1 Jun 2023 13:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1685653120; x=1717189120;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=i6srttgkU6qGV3EeLbImDmjA6xSNPGD/bhfEqg1aHOc=;
  b=PR0LINIjdK6oIi2gIK0VtbGAwd77SUJ5AsQw+kjMH0V/9881WOOzvCwh
   yOkekU2SFx1BuwCFnNArSGKoc1OrXfVDiWQ6Pj7C+M/eGfNB2lQusr6qz
   eyZ8pXA0yjpP+1Jw2PxkAkmn/DX1CzuTwgeH4Po+e+vj/HL4ZI1ge+9yV
   w=;
X-IronPort-AV: E=Sophos;i="6.00,210,1681171200"; 
   d="scan'208";a="589013675"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com) ([10.43.8.6])
  by smtp-border-fw-52003.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2023 20:58:38 +0000
Received: from EX19MTAUWB001.ant.amazon.com (pdx1-ws-svc-p6-lb9-vlan3.pdx.amazon.com [10.236.137.198])
        by email-inbound-relay-pdx-2c-m6i4x-dc7c3f8b.us-west-2.amazon.com (Postfix) with ESMTPS id BDCB5A29CB;
        Thu,  1 Jun 2023 20:58:36 +0000 (UTC)
Received: from EX19MTAUWA001.ant.amazon.com (10.250.64.204) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 1 Jun 2023 20:58:35 +0000
Received: from dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com
 (10.189.73.169) by mail-relay.amazon.com (10.250.64.204) with Microsoft SMTP
 Server id 15.2.1118.26 via Frontend Transport; Thu, 1 Jun 2023 20:58:35 +0000
Received: by dev-dsk-risbhat-2b-8bdc64cd.us-west-2.amazon.com (Postfix, from userid 22673075)
        id 74839E6E; Thu,  1 Jun 2023 20:58:35 +0000 (UTC)
From:   Rishabh Bhatnagar <risbhat@amazon.com>
To:     <gregkh@linuxfoundation.org>, <sfrench@samba.org>
CC:     <stable@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Paulo Alcantara <pc@cjr.nz>,
        Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>
Subject: [PATCH 5.4 1/2] cifs: get rid of unused parameter in reconn_setup_dfs_targets()
Date:   Thu, 1 Jun 2023 20:58:16 +0000
Message-ID: <20230601205817.3957-2-risbhat@amazon.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230601205817.3957-1-risbhat@amazon.com>
References: <20230601205817.3957-1-risbhat@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

From: Paulo Alcantara <pc@cjr.nz>

commit baf3f08ef4083b76ca67b143e135213a7f941879 upstream.

The target iterator parameter "it" is not used in
reconn_setup_dfs_targets(), so just remove it.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Reviewed-by: Aurelien Aptel <aaptel@suse.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
---
 fs/cifs/connect.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 6c8dd7c0b83a..b5cd3dc479ce 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -469,8 +469,7 @@ static void reconn_inval_dfs_target(struct TCP_Server_Info *server,
 }
 
 static inline int reconn_setup_dfs_targets(struct cifs_sb_info *cifs_sb,
-					   struct dfs_cache_tgt_list *tl,
-					   struct dfs_cache_tgt_iterator **it)
+					   struct dfs_cache_tgt_list *tl)
 {
 	if (!cifs_sb->origin_fullpath)
 		return -EOPNOTSUPP;
@@ -515,7 +514,7 @@ cifs_reconnect(struct TCP_Server_Info *server)
 	} else {
 		cifs_sb = CIFS_SB(sb);
 
-		rc = reconn_setup_dfs_targets(cifs_sb, &tgt_list, &tgt_it);
+		rc = reconn_setup_dfs_targets(cifs_sb, &tgt_list);
 		if (rc && (rc != -EOPNOTSUPP)) {
 			cifs_server_dbg(VFS, "%s: no target servers for DFS failover\n",
 				 __func__);
-- 
2.39.2

