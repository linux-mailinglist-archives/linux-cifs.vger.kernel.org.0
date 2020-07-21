Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4396F228018
	for <lists+linux-cifs@lfdr.de>; Tue, 21 Jul 2020 14:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgGUMhq (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 21 Jul 2020 08:37:46 -0400
Received: from mx.cjr.nz ([51.158.111.142]:36988 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727106AbgGUMhq (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 21 Jul 2020 08:37:46 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 9480C7FE99;
        Tue, 21 Jul 2020 12:37:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1595335064;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zJIRc49TK1o45dF9oigIpz/fYTefYu7yO7dkrBiEy6w=;
        b=zrs3LUvx57rysAwLFvkiWz57Urf+pWGjPdRSDJHFkHyyqgeJi2T8hXL3Ib1UsH2EfVcjlI
        eMuihDGDwRZvKTMrB/AY3XhB/XcWVzdIUsbXXFBKipJBvBd5YWztCbcS+UiRRVHMMp25CI
        tCZ3IuZgbGtdXx2uWgBfCognFejrbq28UehoV2JZfQEbymIcrYdcPgv59TOTEAQZrheCiI
        JM45YxQ5RdljqUzidh6122X6uQbNlvYO0ZOfgyyIOv6cApgek2FiPEUn8sQS9OAXII6dTg
        4cuTlQKEilgBLTuJ82UtXluUx4fWz3pIsL6kOu/eeV4JJka76UB/ezwq3Hfpyw==
From:   Paulo Alcantara <pc@cjr.nz>
To:     linux-cifs@vger.kernel.org, smfrench@gmail.com
Cc:     Paulo Alcantara <pc@cjr.nz>
Subject: [PATCH v3 5/7] cifs: handle RESP_GET_DFS_REFERRAL.PathConsumed in reconnect
Date:   Tue, 21 Jul 2020 09:36:42 -0300
Message-Id: <20200721123644.14728-6-pc@cjr.nz>
In-Reply-To: <20200721123644.14728-1-pc@cjr.nz>
References: <20200721123644.14728-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Use PathConsumed field when parsing prefixes of referral paths that
either match a cache entry or are a complete prefix path of an
existing entry.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---
 fs/cifs/cifsproto.h |  3 +--
 fs/cifs/connect.c   | 17 +++++++++-----
 fs/cifs/dfs_cache.c | 57 ++++++++++++++++++++++++++++++++++-----------
 fs/cifs/dfs_cache.h |  7 +++---
 fs/cifs/misc.c      |  7 +++---
 5 files changed, 62 insertions(+), 29 deletions(-)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index c2ab937a7048..bb68cbf81074 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -617,8 +617,7 @@ int smb2_parse_query_directory(struct cifs_tcon *tcon, struct kvec *rsp_iov,
 
 struct super_block *cifs_get_tcp_super(struct TCP_Server_Info *server);
 void cifs_put_tcp_super(struct super_block *sb);
-int update_super_prepath(struct cifs_tcon *tcon, const char *prefix,
-			 size_t prefix_len);
+int update_super_prepath(struct cifs_tcon *tcon, char *prefix);
 
 #ifdef CONFIG_CIFS_DFS_UPCALL
 static inline int get_dfs_path(const unsigned int xid, struct cifs_ses *ses,
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 1f35d84ed118..2abef1c8feb3 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -5548,6 +5548,7 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 	size_t tcp_host_len;
 	const char *dfs_host;
 	size_t dfs_host_len;
+	char *share = NULL, *prefix = NULL;
 
 	tree = kzalloc(MAX_TREE_SIZE, GFP_KERNEL);
 	if (!tree)
@@ -5570,11 +5571,12 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 	extract_unc_hostname(server->hostname, &tcp_host, &tcp_host_len);
 
 	for (it = dfs_cache_get_tgt_iterator(&tl); it; it = dfs_cache_get_next_tgt(&tl, it)) {
-		const char *share, *prefix;
-		size_t share_len, prefix_len;
 		bool target_match;
 
-		rc = dfs_cache_get_tgt_share(it, &share, &share_len, &prefix, &prefix_len);
+		kfree(share);
+		kfree(prefix);
+
+		rc = dfs_cache_get_tgt_share(tcon->dfs_path + 1, it, &share, &prefix);
 		if (rc) {
 			cifs_dbg(VFS, "%s: failed to parse target share %d\n",
 				 __func__, rc);
@@ -5601,13 +5603,13 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 		}
 
 		if (tcon->ipc) {
-			scnprintf(tree, MAX_TREE_SIZE, "\\\\%.*s\\IPC$", (int)share_len, share);
+			scnprintf(tree, MAX_TREE_SIZE, "\\\\%s\\IPC$", share);
 			rc = ops->tree_connect(xid, tcon->ses, tree, tcon, nlsc);
 		} else {
-			scnprintf(tree, MAX_TREE_SIZE, "\\%.*s", (int)share_len, share);
+			scnprintf(tree, MAX_TREE_SIZE, "\\%s", share);
 			rc = ops->tree_connect(xid, tcon->ses, tree, tcon, nlsc);
 			if (!rc) {
-				rc = update_super_prepath(tcon, prefix, prefix_len);
+				rc = update_super_prepath(tcon, prefix);
 				break;
 			}
 		}
@@ -5615,6 +5617,9 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 			break;
 	}
 
+	kfree(share);
+	kfree(prefix);
+
 	if (!rc) {
 		if (it)
 			rc = dfs_cache_noreq_update_tgthint(tcon->dfs_path + 1, it);
diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index dae2f41e4f21..a44f58bbf7ab 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -29,6 +29,7 @@
 
 struct cache_dfs_tgt {
 	char *name;
+	int path_consumed;
 	struct list_head list;
 };
 
@@ -350,7 +351,7 @@ static inline struct timespec64 get_expire_time(int ttl)
 }
 
 /* Allocate a new DFS target */
-static struct cache_dfs_tgt *alloc_target(const char *name)
+static struct cache_dfs_tgt *alloc_target(const char *name, int path_consumed)
 {
 	struct cache_dfs_tgt *t;
 
@@ -362,6 +363,7 @@ static struct cache_dfs_tgt *alloc_target(const char *name)
 		kfree(t);
 		return ERR_PTR(-ENOMEM);
 	}
+	t->path_consumed = path_consumed;
 	INIT_LIST_HEAD(&t->list);
 	return t;
 }
@@ -384,7 +386,7 @@ static int copy_ref_data(const struct dfs_info3_param *refs, int numrefs,
 	for (i = 0; i < numrefs; i++) {
 		struct cache_dfs_tgt *t;
 
-		t = alloc_target(refs[i].node_name);
+		t = alloc_target(refs[i].node_name, refs[i].path_consumed);
 		if (IS_ERR(t)) {
 			free_tgts(ce);
 			return PTR_ERR(t);
@@ -830,6 +832,7 @@ static int get_targets(struct cache_entry *ce, struct dfs_cache_tgt_list *tl)
 			rc = -ENOMEM;
 			goto err_free_it;
 		}
+		it->it_path_consumed = t->path_consumed;
 
 		if (ce->tgthint == t)
 			list_add(&it->it_list, head);
@@ -1320,23 +1323,26 @@ void dfs_cache_del_vol(const char *fullpath)
 /**
  * dfs_cache_get_tgt_share - parse a DFS target
  *
+ * @path: DFS full path
  * @it: DFS target iterator.
  * @share: tree name.
- * @share_len: length of tree name.
  * @prefix: prefix path.
- * @prefix_len: length of prefix path.
  *
  * Return zero if target was parsed correctly, otherwise non-zero.
  */
-int dfs_cache_get_tgt_share(const struct dfs_cache_tgt_iterator *it,
-			    const char **share, size_t *share_len,
-			    const char **prefix, size_t *prefix_len)
+int dfs_cache_get_tgt_share(char *path, const struct dfs_cache_tgt_iterator *it,
+			    char **share, char **prefix)
 {
-	char *s, sep;
+	char *s, sep, *p;
+	size_t len;
+	size_t plen1, plen2;
 
-	if (!it || !share || !share_len || !prefix || !prefix_len)
+	if (!it || !path || !share || !prefix || strlen(path) < it->it_path_consumed)
 		return -EINVAL;
 
+	*share = NULL;
+	*prefix = NULL;
+
 	sep = it->it_name[0];
 	if (sep != '\\' && sep != '/')
 		return -EINVAL;
@@ -1345,13 +1351,38 @@ int dfs_cache_get_tgt_share(const struct dfs_cache_tgt_iterator *it,
 	if (!s)
 		return -EINVAL;
 
+	/* point to prefix in target node */
 	s = strchrnul(s + 1, sep);
 
-	*share = it->it_name;
-	*share_len = s - it->it_name;
-	*prefix = *s ? s + 1 : s;
-	*prefix_len = &it->it_name[strlen(it->it_name)] - *prefix;
+	/* extract target share */
+	*share = kstrndup(it->it_name, s - it->it_name, GFP_KERNEL);
+	if (!*share)
+		return -ENOMEM;
 
+	/* skip separator */
+	if (*s)
+		s++;
+	/* point to prefix in DFS path */
+	p = path + it->it_path_consumed;
+	if (*p == sep)
+		p++;
+
+	/* merge prefix paths from DFS path and target node */
+	plen1 = it->it_name + strlen(it->it_name) - s;
+	plen2 = path + strlen(path) - p;
+	if (plen1 || plen2) {
+		len = plen1 + plen2 + 2;
+		*prefix = kmalloc(len, GFP_KERNEL);
+		if (!*prefix) {
+			kfree(*share);
+			*share = NULL;
+			return -ENOMEM;
+		}
+		if (plen1)
+			scnprintf(*prefix, len, "%.*s%c%.*s", (int)plen1, s, sep, (int)plen2, p);
+		else
+			strscpy(*prefix, p, len);
+	}
 	return 0;
 }
 
diff --git a/fs/cifs/dfs_cache.h b/fs/cifs/dfs_cache.h
index bf94d08cfb5a..3d7c05194536 100644
--- a/fs/cifs/dfs_cache.h
+++ b/fs/cifs/dfs_cache.h
@@ -19,6 +19,7 @@ struct dfs_cache_tgt_list {
 
 struct dfs_cache_tgt_iterator {
 	char *it_name;
+	int it_path_consumed;
 	struct list_head it_list;
 };
 
@@ -48,10 +49,8 @@ extern int dfs_cache_add_vol(char *mntdata, struct smb_vol *vol,
 extern int dfs_cache_update_vol(const char *fullpath,
 				struct TCP_Server_Info *server);
 extern void dfs_cache_del_vol(const char *fullpath);
-
-extern int dfs_cache_get_tgt_share(const struct dfs_cache_tgt_iterator *it,
-				   const char **share, size_t *share_len,
-				   const char **prefix, size_t *prefix_len);
+extern int dfs_cache_get_tgt_share(char *path, const struct dfs_cache_tgt_iterator *it,
+				   char **share, char **prefix);
 
 static inline struct dfs_cache_tgt_iterator *
 dfs_cache_get_next_tgt(struct dfs_cache_tgt_list *tl,
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index e44d049142d0..764234803071 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -1164,8 +1164,7 @@ static inline void cifs_put_tcon_super(struct super_block *sb)
 }
 #endif
 
-int update_super_prepath(struct cifs_tcon *tcon, const char *prefix,
-			 size_t prefix_len)
+int update_super_prepath(struct cifs_tcon *tcon, char *prefix)
 {
 	struct super_block *sb;
 	struct cifs_sb_info *cifs_sb;
@@ -1179,8 +1178,8 @@ int update_super_prepath(struct cifs_tcon *tcon, const char *prefix,
 
 	kfree(cifs_sb->prepath);
 
-	if (*prefix && prefix_len) {
-		cifs_sb->prepath = kstrndup(prefix, prefix_len, GFP_ATOMIC);
+	if (prefix && *prefix) {
+		cifs_sb->prepath = kstrndup(prefix, strlen(prefix), GFP_ATOMIC);
 		if (!cifs_sb->prepath) {
 			rc = -ENOMEM;
 			goto out;
-- 
2.27.0

