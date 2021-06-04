Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1DCB139C37E
	for <lists+linux-cifs@lfdr.de>; Sat,  5 Jun 2021 00:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231694AbhFDW16 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 4 Jun 2021 18:27:58 -0400
Received: from mx.cjr.nz ([51.158.111.142]:9534 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231688AbhFDW1z (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 4 Jun 2021 18:27:55 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 327687FC02;
        Fri,  4 Jun 2021 22:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1622845566;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=QcP5YqnU/BZauRR6E/0EmI8bCFnycAYEOOpLINW8HPQ=;
        b=pgJzxjE5sOWV/z4S6v9d8ZjgLycxq7+Z7x8CXXQB9+cNpwzW7iiZHpAYSzJKS6ZndXgmUb
        ydaedM9sOqyDcH87hFv7VKvYI6zmFD0gPckf70CzZ+rxXUNvZCDC24+podzoQw+gQVFt1e
        BPIFNrdidggScag4N7Bnfs28ZVpvx1gP4acs7+lhUa4EPpIShkKNK3DrmB9KQbnf6YClsl
        aS9JDMtbT0JtHnOl8QrA3KOvcTchLHbrE5+fHW9WBAaW+6Pf0EoZiTMYJiEm37/8oWAjsu
        EdCMc+2JONm0M0lBHuMoyCHXeKyyOb9Z6zyIpUE9JTPRDo3ozxs/4TkTJCto4g==
From:   Paulo Alcantara <pc@cjr.nz>
To:     linux-cifs@vger.kernel.org, smfrench@gmail.com
Cc:     Paulo Alcantara <pc@cjr.nz>
Subject: [PATCH 6/7] cifs: set a minimum of 2 minutes for refreshing dfs cache
Date:   Fri,  4 Jun 2021 19:25:32 -0300
Message-Id: <20210604222533.4760-7-pc@cjr.nz>
In-Reply-To: <20210604222533.4760-1-pc@cjr.nz>
References: <20210604222533.4760-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

We don't want to refresh the dfs cache in very short intervals, so
setting a minimum interval of 2 minutes is OK.

If it needs to be refreshed immediately, one could have the cache
cleared with

	$ echo 0 > /proc/fs/cifs/dfscache

and then remounting the dfs share.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---
 fs/cifs/dfs_cache.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index f7c4874ddc17..b4df779e4248 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -24,6 +24,7 @@
 
 #define CACHE_HTABLE_SIZE 32
 #define CACHE_MAX_ENTRIES 64
+#define CACHE_MIN_TTL 120 /* 2 minutes */
 
 #define IS_INTERLINK_SET(v) ((v) & (DFSREF_REFERRAL_SERVER | \
 				    DFSREF_STORAGE_SERVER))
@@ -503,7 +504,7 @@ static int copy_ref_data(const struct dfs_info3_param *refs, int numrefs,
 {
 	int i;
 
-	ce->ttl = refs[0].ttl;
+	ce->ttl = max_t(int, refs[0].ttl, CACHE_MIN_TTL);
 	ce->etime = get_expire_time(ce->ttl);
 	ce->srvtype = refs[0].server_type;
 	ce->hdr_flags = refs[0].flags;
-- 
2.31.1

