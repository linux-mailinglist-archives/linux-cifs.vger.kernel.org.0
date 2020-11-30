Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0B0A22C8BFF
	for <lists+linux-cifs@lfdr.de>; Mon, 30 Nov 2020 19:04:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387904AbgK3SDw (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 30 Nov 2020 13:03:52 -0500
Received: from mx2.suse.de ([195.135.220.15]:45310 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728739AbgK3SDw (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 30 Nov 2020 13:03:52 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ADB69AE95
        for <linux-cifs@vger.kernel.org>; Mon, 30 Nov 2020 18:03:10 +0000 (UTC)
From:   Samuel Cabrero <scabrero@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     Samuel Cabrero <scabrero@suse.de>
Subject: [PATCH v4 02/11] cifs: Make extract_sharename function public
Date:   Mon, 30 Nov 2020 19:02:48 +0100
Message-Id: <20201130180257.31787-3-scabrero@suse.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201130180257.31787-1-scabrero@suse.de>
References: <20201130180257.31787-1-scabrero@suse.de>
Reply-To: scabrero@suse.de
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Move the function to misc.c

Signed-off-by: Samuel Cabrero <scabrero@suse.de>
---
 fs/cifs/cache.c     | 24 ------------------------
 fs/cifs/cifsproto.h |  1 +
 fs/cifs/fscache.c   |  1 +
 fs/cifs/fscache.h   |  1 -
 fs/cifs/misc.c      | 24 ++++++++++++++++++++++++
 5 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/fs/cifs/cache.c b/fs/cifs/cache.c
index 0f2adecb94f2..488fe0ffc1ef 100644
--- a/fs/cifs/cache.c
+++ b/fs/cifs/cache.c
@@ -53,30 +53,6 @@ const struct fscache_cookie_def cifs_fscache_server_index_def = {
 	.type = FSCACHE_COOKIE_TYPE_INDEX,
 };
 
-char *extract_sharename(const char *treename)
-{
-	const char *src;
-	char *delim, *dst;
-	int len;
-
-	/* skip double chars at the beginning */
-	src = treename + 2;
-
-	/* share name is always preceded by '\\' now */
-	delim = strchr(src, '\\');
-	if (!delim)
-		return ERR_PTR(-EINVAL);
-	delim++;
-	len = strlen(delim);
-
-	/* caller has to free the memory */
-	dst = kstrndup(delim, len, GFP_KERNEL);
-	if (!dst)
-		return ERR_PTR(-ENOMEM);
-
-	return dst;
-}
-
 static enum
 fscache_checkaux cifs_fscache_super_check_aux(void *cookie_netfs_data,
 					      const void *data,
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index d716e81d86fa..5f997a01fb45 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -621,6 +621,7 @@ struct super_block *cifs_get_tcp_super(struct TCP_Server_Info *server);
 void cifs_put_tcp_super(struct super_block *sb);
 int update_super_prepath(struct cifs_tcon *tcon, char *prefix);
 char *extract_hostname(const char *unc);
+char *extract_sharename(const char *unc);
 
 #ifdef CONFIG_CIFS_DFS_UPCALL
 static inline int get_dfs_path(const unsigned int xid, struct cifs_ses *ses,
diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
index da688185403c..20d24af33ee2 100644
--- a/fs/cifs/fscache.c
+++ b/fs/cifs/fscache.c
@@ -22,6 +22,7 @@
 #include "cifsglob.h"
 #include "cifs_debug.h"
 #include "cifs_fs_sb.h"
+#include "cifsproto.h"
 
 /*
  * Key layout of CIFS server cache index object
diff --git a/fs/cifs/fscache.h b/fs/cifs/fscache.h
index 1091633d2adb..e811f2dd7619 100644
--- a/fs/cifs/fscache.h
+++ b/fs/cifs/fscache.h
@@ -57,7 +57,6 @@ extern const struct fscache_cookie_def cifs_fscache_inode_object_def;
 
 extern int cifs_fscache_register(void);
 extern void cifs_fscache_unregister(void);
-extern char *extract_sharename(const char *);
 
 /*
  * fscache.c
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 3d5cc25c167f..f0a1c24751b2 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -1227,3 +1227,27 @@ char *extract_hostname(const char *unc)
 
 	return dst;
 }
+
+char *extract_sharename(const char *unc)
+{
+	const char *src;
+	char *delim, *dst;
+	int len;
+
+	/* skip double chars at the beginning */
+	src = unc + 2;
+
+	/* share name is always preceded by '\\' now */
+	delim = strchr(src, '\\');
+	if (!delim)
+		return ERR_PTR(-EINVAL);
+	delim++;
+	len = strlen(delim);
+
+	/* caller has to free the memory */
+	dst = kstrndup(delim, len, GFP_KERNEL);
+	if (!dst)
+		return ERR_PTR(-ENOMEM);
+
+	return dst;
+}
-- 
2.29.2

