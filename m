Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA9BE113698
	for <lists+linux-cifs@lfdr.de>; Wed,  4 Dec 2019 21:38:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728104AbfLDUic (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 4 Dec 2019 15:38:32 -0500
Received: from mx.cjr.nz ([51.158.111.142]:1820 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728053AbfLDUic (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 4 Dec 2019 15:38:32 -0500
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id E1FB28132A;
        Wed,  4 Dec 2019 20:38:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1575491909;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oShPpuq+ITPYDA5oK34v7g5z/ZzXy6EQV3uSSERETH8=;
        b=e7NGvD4PZiof/bWeTHWNeLn9O7MWFiB+OekfSF6TPwq9M7xU4M7qLPc7OT8gA8Mbe38QtJ
        NqaMjtnro3DhEUuwxpvh5pbFEEdxIlkcmNquriiGgvKk3bppyBlCEHna6R7sYCI2lVIe9B
        mKGSxVCpWEZ5vfl4ugynFdglMD10IfCyQMCeWJvPJoKxkuPFtzhaGq4OcziKOwxbq0qvwd
        +Wdc0XECKAja/g1c3oCt5NgCYxEN93VTcMqrwXNaxjNmg65z4J5UD0tifmEjphr9qOeWpC
        ZdMx4it5/dbtsgiwPcLZudl/FbYqgDymLGh1Vknos53bVk6wP3cmywCSpZF4kg==
From:   "Paulo Alcantara (SUSE)" <pc@cjr.nz>
To:     smfrench@gmail.com
Cc:     linux-cifs@vger.kernel.org, "Paulo Alcantara (SUSE)" <pc@cjr.nz>
Subject: [PATCH v4 5/6] cifs: Fix potential deadlock when updating vol in cifs_reconnect()
Date:   Wed,  4 Dec 2019 17:38:02 -0300
Message-Id: <20191204203803.2316-6-pc@cjr.nz>
In-Reply-To: <20191204203803.2316-1-pc@cjr.nz>
References: <20191204203803.2316-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

We can't acquire volume lock while refreshing the DFS cache because
cifs_reconnect() may call dfs_cache_update_vol() while we are walking
through the volume list.

To prevent that, make vol_info refcounted, create a temp list with all
volumes eligible for refreshing, and then use it without any locks
held.

Besides, replace vol_lock with a spinlock and protect cache_ttl from
concurrent accesses or changes.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---
 fs/cifs/dfs_cache.c | 109 +++++++++++++++++++++++++++++++-------------
 1 file changed, 77 insertions(+), 32 deletions(-)

diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 1d1f7c03931b..82c5d9a31f9e 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -49,15 +49,20 @@ struct cache_entry {
 
 struct vol_info {
 	char *fullpath;
+	spinlock_t smb_vol_lock;
 	struct smb_vol smb_vol;
 	char *mntdata;
 	struct list_head list;
+	struct list_head rlist;
+	struct kref refcnt;
 };
 
 static struct kmem_cache *cache_slab __read_mostly;
 static struct workqueue_struct *dfscache_wq __read_mostly;
 
 static int cache_ttl;
+static DEFINE_SPINLOCK(cache_ttl_lock);
+
 static struct nls_table *cache_nlsc;
 
 /*
@@ -69,7 +74,7 @@ static struct hlist_head cache_htable[CACHE_HTABLE_SIZE];
 static DEFINE_MUTEX(list_lock);
 
 static LIST_HEAD(vol_list);
-static DEFINE_MUTEX(vol_lock);
+static DEFINE_SPINLOCK(vol_list_lock);
 
 static void refresh_cache_worker(struct work_struct *work);
 
@@ -300,7 +305,6 @@ int dfs_cache_init(void)
 	for (i = 0; i < CACHE_HTABLE_SIZE; i++)
 		INIT_HLIST_HEAD(&cache_htable[i]);
 
-	cache_ttl = -1;
 	cache_nlsc = load_nls_default();
 
 	cifs_dbg(FYI, "%s: initialized DFS referral cache\n", __func__);
@@ -471,15 +475,15 @@ add_cache_entry(unsigned int hash, const char *path,
 
 	hlist_add_head_rcu(&ce->hlist, &cache_htable[hash]);
 
-	mutex_lock(&vol_lock);
-	if (cache_ttl < 0) {
+	spin_lock(&cache_ttl_lock);
+	if (!cache_ttl) {
 		cache_ttl = ce->ttl;
 		queue_delayed_work(dfscache_wq, &refresh_task, cache_ttl * HZ);
 	} else {
 		cache_ttl = min_t(int, cache_ttl, ce->ttl);
 		mod_delayed_work(dfscache_wq, &refresh_task, cache_ttl * HZ);
 	}
-	mutex_unlock(&vol_lock);
+	spin_unlock(&cache_ttl_lock);
 
 	return ce;
 }
@@ -523,21 +527,32 @@ static inline void destroy_slab_cache(void)
 	kmem_cache_destroy(cache_slab);
 }
 
-static inline void free_vol(struct vol_info *vi)
+static void __vol_release(struct vol_info *vi)
 {
-	list_del(&vi->list);
 	kfree(vi->fullpath);
 	kfree(vi->mntdata);
 	cifs_cleanup_volume_info_contents(&vi->smb_vol);
 	kfree(vi);
 }
 
+static void vol_release(struct kref *kref)
+{
+	struct vol_info *vi = container_of(kref, struct vol_info, refcnt);
+
+	spin_lock(&vol_list_lock);
+	list_del(&vi->list);
+	spin_unlock(&vol_list_lock);
+	__vol_release(vi);
+}
+
 static inline void free_vol_list(void)
 {
 	struct vol_info *vi, *nvi;
 
-	list_for_each_entry_safe(vi, nvi, &vol_list, list)
-		free_vol(vi);
+	list_for_each_entry_safe(vi, nvi, &vol_list, list) {
+		list_del_init(&vi->list);
+		__vol_release(vi);
+	}
 }
 
 /**
@@ -1156,10 +1171,13 @@ int dfs_cache_add_vol(char *mntdata, struct smb_vol *vol, const char *fullpath)
 		goto err_free_fullpath;
 
 	vi->mntdata = mntdata;
+	spin_lock_init(&vi->smb_vol_lock);
+	kref_init(&vi->refcnt);
 
-	mutex_lock(&vol_lock);
+	spin_lock(&vol_list_lock);
 	list_add_tail(&vi->list, &vol_list);
-	mutex_unlock(&vol_lock);
+	spin_unlock(&vol_list_lock);
+
 	return 0;
 
 err_free_fullpath:
@@ -1169,7 +1187,8 @@ int dfs_cache_add_vol(char *mntdata, struct smb_vol *vol, const char *fullpath)
 	return rc;
 }
 
-static inline struct vol_info *find_vol(const char *fullpath)
+/* Must be called with vol_list_lock held */
+static struct vol_info *find_vol(const char *fullpath)
 {
 	struct vol_info *vi;
 
@@ -1191,7 +1210,6 @@ static inline struct vol_info *find_vol(const char *fullpath)
  */
 int dfs_cache_update_vol(const char *fullpath, struct TCP_Server_Info *server)
 {
-	int rc;
 	struct vol_info *vi;
 
 	if (!fullpath || !server)
@@ -1199,22 +1217,24 @@ int dfs_cache_update_vol(const char *fullpath, struct TCP_Server_Info *server)
 
 	cifs_dbg(FYI, "%s: fullpath: %s\n", __func__, fullpath);
 
-	mutex_lock(&vol_lock);
-
+	spin_lock(&vol_list_lock);
 	vi = find_vol(fullpath);
 	if (IS_ERR(vi)) {
-		rc = PTR_ERR(vi);
-		goto out;
+		spin_unlock(&vol_list_lock);
+		return PTR_ERR(vi);
 	}
+	kref_get(&vi->refcnt);
+	spin_unlock(&vol_list_lock);
 
 	cifs_dbg(FYI, "%s: updating volume info\n", __func__);
+	spin_lock(&vi->smb_vol_lock);
 	memcpy(&vi->smb_vol.dstaddr, &server->dstaddr,
 	       sizeof(vi->smb_vol.dstaddr));
-	rc = 0;
+	spin_unlock(&vi->smb_vol_lock);
 
-out:
-	mutex_unlock(&vol_lock);
-	return rc;
+	kref_put(&vi->refcnt, vol_release);
+
+	return 0;
 }
 
 /**
@@ -1231,11 +1251,11 @@ void dfs_cache_del_vol(const char *fullpath)
 
 	cifs_dbg(FYI, "%s: fullpath: %s\n", __func__, fullpath);
 
-	mutex_lock(&vol_lock);
+	spin_lock(&vol_list_lock);
 	vi = find_vol(fullpath);
-	if (!IS_ERR(vi))
-		free_vol(vi);
-	mutex_unlock(&vol_lock);
+	spin_unlock(&vol_list_lock);
+
+	kref_put(&vi->refcnt, vol_release);
 }
 
 /* Get all tcons that are within a DFS namespace and can be refreshed */
@@ -1449,27 +1469,52 @@ static void refresh_tcon(struct vol_info *vi, struct cifs_tcon *tcon)
  */
 static void refresh_cache_worker(struct work_struct *work)
 {
-	struct vol_info *vi;
+	struct vol_info *vi, *nvi;
 	struct TCP_Server_Info *server;
-	LIST_HEAD(list);
+	LIST_HEAD(vols);
+	LIST_HEAD(tcons);
 	struct cifs_tcon *tcon, *ntcon;
 
-	mutex_lock(&vol_lock);
-
+	/*
+	 * Find SMB volumes that are eligible (server->tcpStatus == CifsGood)
+	 * for refreshing.
+	 */
+	spin_lock(&vol_list_lock);
 	list_for_each_entry(vi, &vol_list, list) {
 		server = get_tcp_server(&vi->smb_vol);
 		if (!server)
 			continue;
 
-		get_tcons(server, &list);
-		list_for_each_entry_safe(tcon, ntcon, &list, ulist) {
+		kref_get(&vi->refcnt);
+		list_add_tail(&vi->rlist, &vols);
+		put_tcp_server(server);
+	}
+	spin_unlock(&vol_list_lock);
+
+	/* Walk through all TCONs and refresh any expired cache entry */
+	list_for_each_entry_safe(vi, nvi, &vols, rlist) {
+		spin_lock(&vi->smb_vol_lock);
+		server = get_tcp_server(&vi->smb_vol);
+		spin_unlock(&vi->smb_vol_lock);
+
+		if (!server)
+			goto next_vol;
+
+		get_tcons(server, &tcons);
+		list_for_each_entry_safe(tcon, ntcon, &tcons, ulist) {
 			refresh_tcon(vi, tcon);
 			list_del_init(&tcon->ulist);
 			cifs_put_tcon(tcon);
 		}
 
 		put_tcp_server(server);
+
+next_vol:
+		list_del_init(&vi->rlist);
+		kref_put(&vi->refcnt, vol_release);
 	}
+
+	spin_lock(&cache_ttl_lock);
 	queue_delayed_work(dfscache_wq, &refresh_task, cache_ttl * HZ);
-	mutex_unlock(&vol_lock);
+	spin_unlock(&cache_ttl_lock);
 }
-- 
2.24.0

