Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B6132D1E75
	for <lists+linux-cifs@lfdr.de>; Tue,  8 Dec 2020 00:39:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgLGXjh (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 7 Dec 2020 18:39:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:44798 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726402AbgLGXjh (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 7 Dec 2020 18:39:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607384291;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=DemcIf6OozsIBSCHCq7Ihx0PfHtD62K3XLE5x+ZTVMI=;
        b=OLf39NaF+hwWZEHbcawE5JO0wbAwiIHfcBAe9bUIe7ZRDx/mWwZy0xR5OaVEbzcilObcpd
        0RVVNRM59y0GCt7QfSH9ORv1G1ArvPUGn4PRxwLouwEgGmL+tazALiVpeyquXVdrvClUAr
        4ewKwZP9hF6VGZC9MvcCnmCCxJWQRi8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-212-jb2RFvV2MyGJDDdPTkKM8Q-1; Mon, 07 Dec 2020 18:38:07 -0500
X-MC-Unique: jb2RFvV2MyGJDDdPTkKM8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6D8EE107ACE4;
        Mon,  7 Dec 2020 23:38:06 +0000 (UTC)
Received: from test1103.test.redhat.com (vpn2-54-107.bne.redhat.com [10.64.54.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7B1621F471;
        Mon,  7 Dec 2020 23:38:05 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: [PATCH 13/21] cifs: add initial reconfigure support
Date:   Tue,  8 Dec 2020 09:36:38 +1000
Message-Id: <20201207233646.29823-13-lsahlber@redhat.com>
In-Reply-To: <20201207233646.29823-1-lsahlber@redhat.com>
References: <20201207233646.29823-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/fs_context.c | 36 +++++++++++++++++++++++++++++++++---
 1 file changed, 33 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 752b7da43f4c..edfdea129fcc 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -618,14 +618,44 @@ static void smb3_fs_context_free(struct fs_context *fc)
 	smb3_cleanup_fs_context(ctx);
 }
 
-static int smb3_reconfigure(struct fs_context *fc)
+/*
+ * Compare the old and new proposed context during reconfigure
+ * and check if the changes are compatible.
+ */
+static int smb3_verify_reconfigure_ctx(struct smb3_fs_context *new_ctx,
+				       struct smb3_fs_context *old_ctx)
 {
-	// TODO:  struct smb3_fs_context *ctx = smb3_fc2context(fc);
+	if (new_ctx->sectype != old_ctx->sectype) {
+		cifs_dbg(VFS, "can not change sec during remount\n");
+		return -EINVAL;
+	}
 
-	/* FIXME : add actual reconfigure */
 	return 0;
 }
 
+static int smb3_reconfigure(struct fs_context *fc)
+{
+	struct smb3_fs_context *ctx = smb3_fc2context(fc);
+	struct dentry *root = fc->root;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(root->d_sb);
+	int rc;
+
+	rc = smb3_verify_reconfigure_ctx(ctx, cifs_sb->ctx);
+	if (rc)
+		return rc;
+
+	/*
+	 * Steal the UNC from the old and to be destroyed context.
+	 */
+	ctx->UNC = cifs_sb->ctx->UNC;
+	cifs_sb->ctx->UNC = NULL;
+
+	smb3_cleanup_fs_context_contents(cifs_sb->ctx);
+	rc = smb3_fs_context_dup(cifs_sb->ctx, ctx);
+
+	return rc;
+}
+
 static int smb3_fs_context_parse_param(struct fs_context *fc,
 				      struct fs_parameter *param)
 {
-- 
2.13.6

