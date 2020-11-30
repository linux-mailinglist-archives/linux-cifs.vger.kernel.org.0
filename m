Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 928792C8BFE
	for <lists+linux-cifs@lfdr.de>; Mon, 30 Nov 2020 19:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387903AbgK3SDw (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 30 Nov 2020 13:03:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:45300 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728571AbgK3SDw (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 30 Nov 2020 13:03:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id 7031FACF9
        for <linux-cifs@vger.kernel.org>; Mon, 30 Nov 2020 18:03:10 +0000 (UTC)
From:   Samuel Cabrero <scabrero@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     Samuel Cabrero <scabrero@suse.de>
Subject: [PATCH v4 01/11] cifs: Make extract_hostname function public
Date:   Mon, 30 Nov 2020 19:02:47 +0100
Message-Id: <20201130180257.31787-2-scabrero@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130180257.31787-1-scabrero@suse.de>
References: <20201130180257.31787-1-scabrero@suse.de>
Reply-To: scabrero@suse.de
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Move the function to misc.c and give it a public header.

Signed-off-by: Samuel Cabrero <scabrero@suse.de>
---
 fs/cifs/cifsproto.h |  1 +
 fs/cifs/connect.c   | 34 ----------------------------------
 fs/cifs/misc.c      | 32 ++++++++++++++++++++++++++++++++
 3 files changed, 33 insertions(+), 34 deletions(-)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 24c6f36177ba..d716e81d86fa 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -620,6 +620,7 @@ int smb2_parse_query_directory(struct cifs_tcon *tcon, struct kvec *rsp_iov,
 struct super_block *cifs_get_tcp_super(struct TCP_Server_Info *server);
 void cifs_put_tcp_super(struct super_block *sb);
 int update_super_prepath(struct cifs_tcon *tcon, char *prefix);
+char *extract_hostname(const char *unc);
 
 #ifdef CONFIG_CIFS_DFS_UPCALL
 static inline int get_dfs_path(const unsigned int xid, struct cifs_ses *ses,
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 28c1459fb0fc..a938371af6ef 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -284,7 +284,6 @@ static int ip_connect(struct TCP_Server_Info *server);
 static int generic_ip_connect(struct TCP_Server_Info *server);
 static void tlink_rb_insert(struct rb_root *root, struct tcon_link *new_tlink);
 static void cifs_prune_tlinks(struct work_struct *work);
-static char *extract_hostname(const char *unc);
 
 /*
  * Resolve hostname and set ip addr in tcp ses. Useful for hostnames that may
@@ -1232,39 +1231,6 @@ cifs_demultiplex_thread(void *p)
 	module_put_and_exit(0);
 }
 
-/* extract the host portion of the UNC string */
-static char *
-extract_hostname(const char *unc)
-{
-	const char *src;
-	char *dst, *delim;
-	unsigned int len;
-
-	/* skip double chars at beginning of string */
-	/* BB: check validity of these bytes? */
-	if (strlen(unc) < 3)
-		return ERR_PTR(-EINVAL);
-	for (src = unc; *src && *src == '\\'; src++)
-		;
-	if (!*src)
-		return ERR_PTR(-EINVAL);
-
-	/* delimiter between hostname and sharename is always '\\' now */
-	delim = strchr(src, '\\');
-	if (!delim)
-		return ERR_PTR(-EINVAL);
-
-	len = delim - src;
-	dst = kmalloc((len + 1), GFP_KERNEL);
-	if (dst == NULL)
-		return ERR_PTR(-ENOMEM);
-
-	memcpy(dst, src, len);
-	dst[len] = '\0';
-
-	return dst;
-}
-
 static int get_option_ul(substring_t args[], unsigned long *option)
 {
 	int rc;
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 1c14cf01dbef..3d5cc25c167f 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -1195,3 +1195,35 @@ int update_super_prepath(struct cifs_tcon *tcon, char *prefix)
 	cifs_put_tcon_super(sb);
 	return rc;
 }
+
+/* extract the host portion of the UNC string */
+char *extract_hostname(const char *unc)
+{
+	const char *src;
+	char *dst, *delim;
+	unsigned int len;
+
+	/* skip double chars at beginning of string */
+	/* BB: check validity of these bytes? */
+	if (strlen(unc) < 3)
+		return ERR_PTR(-EINVAL);
+	for (src = unc; *src && *src == '\\'; src++)
+		;
+	if (!*src)
+		return ERR_PTR(-EINVAL);
+
+	/* delimiter between hostname and sharename is always '\\' now */
+	delim = strchr(src, '\\');
+	if (!delim)
+		return ERR_PTR(-EINVAL);
+
+	len = delim - src;
+	dst = kmalloc((len + 1), GFP_KERNEL);
+	if (dst == NULL)
+		return ERR_PTR(-ENOMEM);
+
+	memcpy(dst, src, len);
+	dst[len] = '\0';
+
+	return dst;
+}
-- 
2.29.2

