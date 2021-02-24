Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1182D3247B9
	for <lists+linux-cifs@lfdr.de>; Thu, 25 Feb 2021 01:01:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234653AbhBYAAw (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 24 Feb 2021 19:00:52 -0500
Received: from mx.cjr.nz ([51.158.111.142]:15550 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234584AbhBYAAv (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 24 Feb 2021 19:00:51 -0500
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id DB2D280342;
        Thu, 25 Feb 2021 00:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1614211210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=L1aydCfOll087ZBxr1GqQrjLtH+4Gt2SkOruDFMvtRg=;
        b=Be5n8OIF5cenp2b1C1OIHZ00doSWaxK7qsrQvi9+LTy5ixXuHY9YQcces4O6o3z40WZjBk
        UX4S4MHpQ+w1FDwWhrJuUZee67NsbLsJB/MA9Xx3LnDnqD32BJskkf8a7UwtMwEbfjX9Mv
        CCVLk1GJJHpqDjg42NkrMJvgra6v67dD/EKkB3ozgDO4MElYrso/Z2gdupYk6J3ISpBS2K
        Fq34VGdBZ+tNPCu70nBsRyHbS95p8hiToqBMKJb0xXcxayMr8QjtdYM/ANLDZEYw7NeTJI
        niYwSNlnrMLWb3IgUDDKssRXR5PMbnIbOP3BaotWJduVTTg46bFSpevE2Y5lXw==
From:   Paulo Alcantara <pc@cjr.nz>
To:     linux-cifs@vger.kernel.org, smfrench@gmail.com
Cc:     Paulo Alcantara <pc@cjr.nz>
Subject: [PATCH 4/4] cifs: fix nodfs mount option
Date:   Wed, 24 Feb 2021 20:59:24 -0300
Message-Id: <20210224235924.29931-4-pc@cjr.nz>
In-Reply-To: <20210224235924.29931-1-pc@cjr.nz>
References: <20210224235924.29931-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Skip DFS resolving when mounting with 'nodfs' even if
CONFIG_CIFS_DFS_UPCALL is enabled.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---
 fs/cifs/connect.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 37452b2e24b8..6ab5f96fe1b4 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -3373,15 +3373,15 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 
 	rc = mount_get_conns(ctx, cifs_sb, &xid, &server, &ses, &tcon);
 	/*
-	 * Unconditionally try to get an DFS referral (even cached) to determine whether it is an
-	 * DFS mount.
+	 * If called with 'nodfs' mount option, then skip DFS resolving.  Otherwise unconditionally
+	 * try to get an DFS referral (even cached) to determine whether it is an DFS mount.
 	 *
 	 * Skip prefix path to provide support for DFS referrals from w2k8 servers which don't seem
 	 * to respond with PATH_NOT_COVERED to requests that include the prefix.
 	 */
-	if (dfs_cache_find(xid, ses, cifs_sb->local_nls, cifs_remap(cifs_sb), ctx->UNC + 1, NULL,
+	if ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS) ||
+	    dfs_cache_find(xid, ses, cifs_sb->local_nls, cifs_remap(cifs_sb), ctx->UNC + 1, NULL,
 			   NULL)) {
-		/* No DFS referral was returned.  Looks like a regular share. */
 		if (rc)
 			goto error;
 		/* Check if it is fully accessible and then mount it */
-- 
2.30.1

