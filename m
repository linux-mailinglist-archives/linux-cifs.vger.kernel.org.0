Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB95371737
	for <lists+linux-cifs@lfdr.de>; Mon,  3 May 2021 16:55:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229953AbhECO4r (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 3 May 2021 10:56:47 -0400
Received: from mx.cjr.nz ([51.158.111.142]:14664 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229767AbhECO4q (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 3 May 2021 10:56:46 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 0A5FE7FD1B;
        Mon,  3 May 2021 14:55:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1620053751;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yCoecZFqdZhNYMokCHITxdVY6FjsX9QXar1MkhnIRmg=;
        b=QXJQ/cNlsQ9LOYdceo28kYntczXbxojICksGaSUjLGNDSxteVtN5YO8dbHkYTiHeSbsTk+
        akzY8WJYkDIayf5uje9WYCscTIucBGRXuRn/Sly9ZotcyYJKTUXrMvaB4RDXF5HI13NyfA
        XFlugOrJcnJ1ZuRovb01roCn+hzOKn/G/yxqjVKn8+U4zRQXuFLd6JvRaNGX8p6ac5hghm
        G15WnBLb8bc3OSII4MwScwksiuB1/b9VYq3M+raC6yyoHs/AI7kcWBFCbC4fiSOuOa525Y
        I/WLrF88xFkuxYlylcdd2q1OheiuQfNhkVeRQ+/Y/Jm+ZkR15peq455Ev/4VYw==
From:   Paulo Alcantara <pc@cjr.nz>
To:     linux-cifs@vger.kernel.org, smfrench@gmail.com
Cc:     ddiss@suse.de, aaptel@suse.com, Paulo Alcantara <pc@cjr.nz>,
        stable@vger.kernel.org
Subject: [PATCH v2] cifs: fix regression when mounting shares with prefix paths
Date:   Mon,  3 May 2021 11:55:26 -0300
Message-Id: <20210503145526.9705-1-pc@cjr.nz>
In-Reply-To: <20210430221621.7497-1-pc@cjr.nz>
References: <20210430221621.7497-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The commit 315db9a05b7a ("cifs: fix leak in cifs_smb3_do_mount() ctx")
revealed an existing bug when mounting shares that contain a prefix
path or DFS links.

cifs_setup_volume_info() requires the @devname to contain the full
path (UNC + prefix) to update the fs context with the new UNC and
prepath values, however we were passing only the UNC
path (old_ctx->UNC) in @device thus discarding any prefix paths.

Instead of concatenating both old_ctx->{UNC,prepath} and pass it in
@devname, just keep the dup'ed values of UNC and prepath in
cifs_sb->ctx after calling smb3_fs_context_dup(), and fix
smb3_parse_devname() to correctly parse and not leak the new UNC and
prefix paths.

Cc: <stable@vger.kernel.org> # v5.11+
Fixes: 315db9a05b7a ("cifs: fix leak in cifs_smb3_do_mount() ctx")
Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---
 fs/cifs/cifsfs.c     |  8 +-------
 fs/cifs/connect.c    | 24 ++++++++++++++++++------
 fs/cifs/fs_context.c |  4 ++++
 3 files changed, 23 insertions(+), 13 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 8a6894577697..d7ea9c5fe0f8 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -863,13 +863,7 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 		goto out;
 	}
 
-	/* cifs_setup_volume_info->smb3_parse_devname() redups UNC & prepath */
-	kfree(cifs_sb->ctx->UNC);
-	cifs_sb->ctx->UNC = NULL;
-	kfree(cifs_sb->ctx->prepath);
-	cifs_sb->ctx->prepath = NULL;
-
-	rc = cifs_setup_volume_info(cifs_sb->ctx, NULL, old_ctx->UNC);
+	rc = cifs_setup_volume_info(cifs_sb->ctx, NULL, NULL);
 	if (rc) {
 		root = ERR_PTR(rc);
 		goto out;
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index becd5f807787..4ce6fc24cae1 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -3159,17 +3159,29 @@ static int do_dfs_failover(const char *path, const char *full_path, struct cifs_
 int
 cifs_setup_volume_info(struct smb3_fs_context *ctx, const char *mntopts, const char *devname)
 {
-	int rc = 0;
+	int rc;
 
-	smb3_parse_devname(devname, ctx);
+	if (devname) {
+		cifs_dbg(FYI, "%s: devname=%s\n", __func__, devname);
+		rc = smb3_parse_devname(devname, ctx);
+		if (rc) {
+			cifs_dbg(VFS, "%s: failed to parse %s: %d\n", __func__, devname, rc);
+			return rc;
+		}
+	}
 
 	if (mntopts) {
 		char *ip;
 
-		cifs_dbg(FYI, "%s: mntopts=%s\n", __func__, mntopts);
 		rc = smb3_parse_opt(mntopts, "ip", &ip);
-		if (!rc && !cifs_convert_address((struct sockaddr *)&ctx->dstaddr, ip,
-						 strlen(ip))) {
+		if (rc) {
+			cifs_dbg(VFS, "%s: failed to parse ip options: %d\n", __func__, rc);
+			return rc;
+		}
+
+		rc = cifs_convert_address((struct sockaddr *)&ctx->dstaddr, ip, strlen(ip));
+		kfree(ip);
+		if (!rc) {
 			cifs_dbg(VFS, "%s: failed to convert ip address\n", __func__);
 			return -EINVAL;
 		}
@@ -3189,7 +3201,7 @@ cifs_setup_volume_info(struct smb3_fs_context *ctx, const char *mntopts, const c
 		return -EINVAL;
 	}
 
-	return rc;
+	return 0;
 }
 
 static int
diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 1d6e0e15b034..3bcf881c3ae9 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -476,6 +476,7 @@ smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx)
 
 	/* move "pos" up to delimiter or NULL */
 	pos += len;
+	kfree(ctx->UNC);
 	ctx->UNC = kstrndup(devname, pos - devname, GFP_KERNEL);
 	if (!ctx->UNC)
 		return -ENOMEM;
@@ -486,6 +487,9 @@ smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx)
 	if (*pos == '/' || *pos == '\\')
 		pos++;
 
+	kfree(ctx->prepath);
+	ctx->prepath = NULL;
+
 	/* If pos is NULL then no prepath */
 	if (!*pos)
 		return 0;
-- 
2.31.1

