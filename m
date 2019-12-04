Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA2CF113699
	for <lists+linux-cifs@lfdr.de>; Wed,  4 Dec 2019 21:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728053AbfLDUig (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 4 Dec 2019 15:38:36 -0500
Received: from mx.cjr.nz ([51.158.111.142]:1832 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728097AbfLDUif (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 4 Dec 2019 15:38:35 -0500
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id CEFD18132B;
        Wed,  4 Dec 2019 20:38:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1575491911;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=dI0Cv2bUyFm1PDdWiWJrdtjk9RVPx86NCm7HmKt+7fE=;
        b=P7/FfZczgoCiaO/+P+rfjUAnxqReGdPorGnAESntyt/n6NuheCNprBxi51ws6WQ1s6jz0H
        CWBUz0kwn+hFZnXBsdlz43KULvc6T9RWo/qTA0Kmv2NA95z3OlLXxyXjcD4xWNKANBLwBY
        DkgvgUdZTFYA8wugNJLJLchVkFlJEqC0/NC/v9QpwfpfLzDenz7h2K5pcsnR6tFViNhN6u
        eqS5JqJmNCYv+kxhAYImNcbEbT86Zw5o5612yPfizRJ97ThkpRwevYmGclI/ON0vRkr8P7
        xL0gDiMyemS2AKLa23IMUK1iKO6SqXO2mNjStxh84zmmk+TEyNN2JZY0HDZzfg==
From:   "Paulo Alcantara (SUSE)" <pc@cjr.nz>
To:     smfrench@gmail.com
Cc:     linux-cifs@vger.kernel.org, "Paulo Alcantara (SUSE)" <pc@cjr.nz>
Subject: [PATCH v4 6/6] cifs: Avoid doing network I/O while holding cache lock
Date:   Wed,  4 Dec 2019 17:38:03 -0300
Message-Id: <20191204203803.2316-7-pc@cjr.nz>
In-Reply-To: <20191204203803.2316-1-pc@cjr.nz>
References: <20191204203803.2316-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

When creating or updating a cache entry, we need to get an DFS
referral (get_dfs_referral), so avoid holding any locks during such
network operation.

To prevent that, do the following:
* change cache hashtable sync method from RCU sync to a read/write
  lock.
* use GFP_ATOMIC in memory allocations.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---
 fs/cifs/dfs_cache.c | 547 +++++++++++++++++++++++---------------------
 1 file changed, 283 insertions(+), 264 deletions(-)

diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 82c5d9a31f9e..76ffe12d64f5 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -5,8 +5,6 @@
  * Copyright (c) 2018-2019 Paulo Alcantara <palcantara@suse.de>
  */
 
-#include <linux/rcupdate.h>
-#include <linux/rculist.h>
 #include <linux/jhash.h>
 #include <linux/ktime.h>
 #include <linux/slab.h>
@@ -44,7 +42,6 @@ struct cache_entry {
 	int numtgts;
 	struct list_head tlist;
 	struct cache_dfs_tgt *tgthint;
-	struct rcu_head rcu;
 };
 
 struct vol_info {
@@ -68,10 +65,10 @@ static struct nls_table *cache_nlsc;
 /*
  * Number of entries in the cache
  */
-static size_t cache_count;
+static atomic_t cache_count;
 
 static struct hlist_head cache_htable[CACHE_HTABLE_SIZE];
-static DEFINE_MUTEX(list_lock);
+static DECLARE_RWSEM(htable_rw_lock);
 
 static LIST_HEAD(vol_list);
 static DEFINE_SPINLOCK(vol_list_lock);
@@ -121,38 +118,29 @@ static inline void free_tgts(struct cache_entry *ce)
 	}
 }
 
-static void free_cache_entry(struct rcu_head *rcu)
-{
-	struct cache_entry *ce = container_of(rcu, struct cache_entry, rcu);
-
-	kmem_cache_free(cache_slab, ce);
-}
-
 static inline void flush_cache_ent(struct cache_entry *ce)
 {
-	if (hlist_unhashed(&ce->hlist))
-		return;
-
-	hlist_del_init_rcu(&ce->hlist);
+	hlist_del_init(&ce->hlist);
 	kfree(ce->path);
 	free_tgts(ce);
-	cache_count--;
-	call_rcu(&ce->rcu, free_cache_entry);
+	atomic_dec(&cache_count);
+	kmem_cache_free(cache_slab, ce);
 }
 
 static void flush_cache_ents(void)
 {
 	int i;
 
-	rcu_read_lock();
 	for (i = 0; i < CACHE_HTABLE_SIZE; i++) {
 		struct hlist_head *l = &cache_htable[i];
+		struct hlist_node *n;
 		struct cache_entry *ce;
 
-		hlist_for_each_entry_rcu(ce, l, hlist)
-			flush_cache_ent(ce);
+		hlist_for_each_entry_safe(ce, n, l, hlist) {
+			if (!hlist_unhashed(&ce->hlist))
+				flush_cache_ent(ce);
+		}
 	}
-	rcu_read_unlock();
 }
 
 /*
@@ -160,36 +148,39 @@ static void flush_cache_ents(void)
  */
 static int dfscache_proc_show(struct seq_file *m, void *v)
 {
-	int bucket;
+	int i;
 	struct cache_entry *ce;
 	struct cache_dfs_tgt *t;
 
 	seq_puts(m, "DFS cache\n---------\n");
 
-	mutex_lock(&list_lock);
-
-	rcu_read_lock();
-	hash_for_each_rcu(cache_htable, bucket, ce, hlist) {
-		seq_printf(m,
-			   "cache entry: path=%s,type=%s,ttl=%d,etime=%ld,"
-			   "interlink=%s,path_consumed=%d,expired=%s\n",
-			   ce->path,
-			   ce->srvtype == DFS_TYPE_ROOT ? "root" : "link",
-			   ce->ttl, ce->etime.tv_nsec,
-			   IS_INTERLINK_SET(ce->flags) ? "yes" : "no",
-			   ce->path_consumed,
-			   cache_entry_expired(ce) ? "yes" : "no");
-
-		list_for_each_entry(t, &ce->tlist, list) {
-			seq_printf(m, "  %s%s\n",
-				   t->name,
-				   ce->tgthint == t ? " (target hint)" : "");
-		}
+	down_read(&htable_rw_lock);
+	for (i = 0; i < CACHE_HTABLE_SIZE; i++) {
+		struct hlist_head *l = &cache_htable[i];
 
+		hlist_for_each_entry(ce, l, hlist) {
+			if (hlist_unhashed(&ce->hlist))
+				continue;
+
+			seq_printf(m,
+				   "cache entry: path=%s,type=%s,ttl=%d,etime=%ld,"
+				   "interlink=%s,path_consumed=%d,expired=%s\n",
+				   ce->path,
+				   ce->srvtype == DFS_TYPE_ROOT ? "root" : "link",
+				   ce->ttl, ce->etime.tv_nsec,
+				   IS_INTERLINK_SET(ce->flags) ? "yes" : "no",
+				   ce->path_consumed,
+				   cache_entry_expired(ce) ? "yes" : "no");
+
+			list_for_each_entry(t, &ce->tlist, list) {
+				seq_printf(m, "  %s%s\n",
+					   t->name,
+					   ce->tgthint == t ? " (target hint)" : "");
+			}
+		}
 	}
-	rcu_read_unlock();
+	up_read(&htable_rw_lock);
 
-	mutex_unlock(&list_lock);
 	return 0;
 }
 
@@ -207,9 +198,10 @@ static ssize_t dfscache_proc_write(struct file *file, const char __user *buffer,
 		return -EINVAL;
 
 	cifs_dbg(FYI, "clearing dfs cache");
-	mutex_lock(&list_lock);
+
+	down_write(&htable_rw_lock);
 	flush_cache_ents();
-	mutex_unlock(&list_lock);
+	up_write(&htable_rw_lock);
 
 	return count;
 }
@@ -305,6 +297,7 @@ int dfs_cache_init(void)
 	for (i = 0; i < CACHE_HTABLE_SIZE; i++)
 		INIT_HLIST_HEAD(&cache_htable[i]);
 
+	atomic_set(&cache_count, 0);
 	cache_nlsc = load_nls_default();
 
 	cifs_dbg(FYI, "%s: initialized DFS referral cache\n", __func__);
@@ -356,14 +349,14 @@ static inline struct timespec64 get_expire_time(int ttl)
 }
 
 /* Allocate a new DFS target */
-static inline struct cache_dfs_tgt *alloc_tgt(const char *name)
+static struct cache_dfs_tgt *alloc_target(const char *name)
 {
 	struct cache_dfs_tgt *t;
 
-	t = kmalloc(sizeof(*t), GFP_KERNEL);
+	t = kmalloc(sizeof(*t), GFP_ATOMIC);
 	if (!t)
 		return ERR_PTR(-ENOMEM);
-	t->name = kstrndup(name, strlen(name), GFP_KERNEL);
+	t->name = kstrndup(name, strlen(name), GFP_ATOMIC);
 	if (!t->name) {
 		kfree(t);
 		return ERR_PTR(-ENOMEM);
@@ -390,7 +383,7 @@ static int copy_ref_data(const struct dfs_info3_param *refs, int numrefs,
 	for (i = 0; i < numrefs; i++) {
 		struct cache_dfs_tgt *t;
 
-		t = alloc_tgt(refs[i].node_name);
+		t = alloc_target(refs[i].node_name);
 		if (IS_ERR(t)) {
 			free_tgts(ce);
 			return PTR_ERR(t);
@@ -439,41 +432,44 @@ static struct cache_entry *alloc_cache_entry(const char *path,
 	return ce;
 }
 
+/* Must be called with htable_rw_lock held */
 static void remove_oldest_entry(void)
 {
-	int bucket;
+	int i;
 	struct cache_entry *ce;
 	struct cache_entry *to_del = NULL;
 
-	rcu_read_lock();
-	hash_for_each_rcu(cache_htable, bucket, ce, hlist) {
-		if (!to_del || timespec64_compare(&ce->etime,
-						  &to_del->etime) < 0)
-			to_del = ce;
+	for (i = 0; i < CACHE_HTABLE_SIZE; i++) {
+		struct hlist_head *l = &cache_htable[i];
+
+		hlist_for_each_entry(ce, l, hlist) {
+			if (hlist_unhashed(&ce->hlist))
+				continue;
+			if (!to_del || timespec64_compare(&ce->etime,
+							  &to_del->etime) < 0)
+				to_del = ce;
+		}
 	}
+
 	if (!to_del) {
 		cifs_dbg(FYI, "%s: no entry to remove", __func__);
-		goto out;
+		return;
 	}
+
 	cifs_dbg(FYI, "%s: removing entry", __func__);
 	dump_ce(to_del);
 	flush_cache_ent(to_del);
-out:
-	rcu_read_unlock();
 }
 
 /* Add a new DFS cache entry */
-static inline struct cache_entry *
-add_cache_entry(unsigned int hash, const char *path,
-		const struct dfs_info3_param *refs, int numrefs)
+static int add_cache_entry(const char *path, unsigned int hash,
+			   struct dfs_info3_param *refs, int numrefs)
 {
 	struct cache_entry *ce;
 
 	ce = alloc_cache_entry(path, refs, numrefs);
 	if (IS_ERR(ce))
-		return ce;
-
-	hlist_add_head_rcu(&ce->hlist, &cache_htable[hash]);
+		return PTR_ERR(ce);
 
 	spin_lock(&cache_ttl_lock);
 	if (!cache_ttl) {
@@ -485,13 +481,20 @@ add_cache_entry(unsigned int hash, const char *path,
 	}
 	spin_unlock(&cache_ttl_lock);
 
-	return ce;
+	down_write(&htable_rw_lock);
+	hlist_add_head(&ce->hlist, &cache_htable[hash]);
+	dump_ce(ce);
+	up_write(&htable_rw_lock);
+
+	return 0;
 }
 
 /*
  * Find a DFS cache entry in hash table and optionally check prefix path against
  * @path.
  * Use whole path components in the match.
+ * Must be called with htable_rw_lock held.
+ *
  * Return ERR_PTR(-ENOENT) if the entry is not found.
  */
 static struct cache_entry *lookup_cache_entry(const char *path,
@@ -503,15 +506,13 @@ static struct cache_entry *lookup_cache_entry(const char *path,
 
 	h = cache_entry_hash(path, strlen(path));
 
-	rcu_read_lock();
-	hlist_for_each_entry_rcu(ce, &cache_htable[h], hlist) {
+	hlist_for_each_entry(ce, &cache_htable[h], hlist) {
 		if (!strcasecmp(path, ce->path)) {
 			found = true;
 			dump_ce(ce);
 			break;
 		}
 	}
-	rcu_read_unlock();
 
 	if (!found)
 		ce = ERR_PTR(-ENOENT);
@@ -521,12 +522,6 @@ static struct cache_entry *lookup_cache_entry(const char *path,
 	return ce;
 }
 
-static inline void destroy_slab_cache(void)
-{
-	rcu_barrier();
-	kmem_cache_destroy(cache_slab);
-}
-
 static void __vol_release(struct vol_info *vi)
 {
 	kfree(vi->fullpath);
@@ -564,77 +559,74 @@ void dfs_cache_destroy(void)
 	unload_nls(cache_nlsc);
 	free_vol_list();
 	flush_cache_ents();
-	destroy_slab_cache();
+	kmem_cache_destroy(cache_slab);
 	destroy_workqueue(dfscache_wq);
 
 	cifs_dbg(FYI, "%s: destroyed DFS referral cache\n", __func__);
 }
 
-static inline struct cache_entry *
-__update_cache_entry(const char *path, const struct dfs_info3_param *refs,
-		     int numrefs)
+/* Must be called with htable_rw_lock held */
+static int __update_cache_entry(const char *path,
+				const struct dfs_info3_param *refs,
+				int numrefs)
 {
 	int rc;
-	unsigned int h;
 	struct cache_entry *ce;
 	char *s, *th = NULL;
 
-	ce = lookup_cache_entry(path, &h);
+	ce = lookup_cache_entry(path, NULL);
 	if (IS_ERR(ce))
-		return ce;
+		return PTR_ERR(ce);
 
 	if (ce->tgthint) {
 		s = ce->tgthint->name;
-		th = kstrndup(s, strlen(s), GFP_KERNEL);
+		th = kstrndup(s, strlen(s), GFP_ATOMIC);
 		if (!th)
-			return ERR_PTR(-ENOMEM);
+			return -ENOMEM;
 	}
 
 	free_tgts(ce);
 	ce->numtgts = 0;
 
 	rc = copy_ref_data(refs, numrefs, ce, th);
-	kfree(th);
 
-	if (rc)
-		ce = ERR_PTR(rc);
+	kfree(th);
 
-	return ce;
+	return 0;
 }
 
-/* Update an expired cache entry by getting a new DFS referral from server */
-static struct cache_entry *
-update_cache_entry(const unsigned int xid, struct cifs_ses *ses,
-		   const struct nls_table *nls_codepage, int remap,
-		   const char *path, struct cache_entry *ce)
+static int get_dfs_referral(const unsigned int xid, struct cifs_ses *ses,
+			    const struct nls_table *nls_codepage, int remap,
+			    const char *path,  struct dfs_info3_param **refs,
+			    int *numrefs)
 {
-	int rc;
-	struct dfs_info3_param *refs = NULL;
-	int numrefs = 0;
+	cifs_dbg(FYI, "%s: get an DFS referral for %s\n", __func__, path);
 
-	cifs_dbg(FYI, "%s: update expired cache entry\n", __func__);
-	/*
-	 * Check if caller provided enough parameters to update an expired
-	 * entry.
-	 */
 	if (!ses || !ses->server || !ses->server->ops->get_dfs_refer)
-		return ERR_PTR(-ETIME);
+		return -EOPNOTSUPP;
 	if (unlikely(!nls_codepage))
-		return ERR_PTR(-ETIME);
+		return -EINVAL;
 
-	cifs_dbg(FYI, "%s: DFS referral request for %s\n", __func__, path);
+	*refs = NULL;
+	*numrefs = 0;
 
-	rc = ses->server->ops->get_dfs_refer(xid, ses, path, &refs, &numrefs,
-					     nls_codepage, remap);
-	if (rc)
-		ce = ERR_PTR(rc);
-	else
-		ce = __update_cache_entry(path, refs, numrefs);
+	return ses->server->ops->get_dfs_refer(xid, ses, path, refs, numrefs,
+					       nls_codepage, remap);
+}
 
-	dump_refs(refs, numrefs);
-	free_dfs_info_array(refs, numrefs);
+/* Update an expired cache entry by getting a new DFS referral from server */
+static int update_cache_entry(const char *path,
+			      const struct dfs_info3_param *refs,
+			      int numrefs)
+{
 
-	return ce;
+	int rc;
+
+	down_write(&htable_rw_lock);
+	rc = __update_cache_entry(path, refs, numrefs);
+	up_write(&htable_rw_lock);
+
+	return rc;
 }
 
 /*
@@ -646,95 +638,86 @@ update_cache_entry(const unsigned int xid, struct cifs_ses *ses,
  * For interlinks, __cifs_dfs_mount() and expand_dfs_referral() are supposed to
  * handle them properly.
  */
-static struct cache_entry *
-do_dfs_cache_find(const unsigned int xid, struct cifs_ses *ses,
-		  const struct nls_table *nls_codepage, int remap,
-		  const char *path, bool noreq)
+static int __dfs_cache_find(const unsigned int xid, struct cifs_ses *ses,
+			    const struct nls_table *nls_codepage, int remap,
+			    const char *path, bool noreq)
 {
 	int rc;
-	unsigned int h;
+	unsigned int hash;
 	struct cache_entry *ce;
-	struct dfs_info3_param *nrefs;
-	int numnrefs;
+	struct dfs_info3_param *refs = NULL;
+	int numrefs = 0;
+	bool newent = false;
 
 	cifs_dbg(FYI, "%s: search path: %s\n", __func__, path);
 
-	ce = lookup_cache_entry(path, &h);
-	if (IS_ERR(ce)) {
-		cifs_dbg(FYI, "%s: cache miss\n", __func__);
-		/*
-		 * If @noreq is set, no requests will be sent to the server for
-		 * either updating or getting a new DFS referral.
-		 */
-		if (noreq)
-			return ce;
-		/*
-		 * No cache entry was found, so check for valid parameters that
-		 * will be required to get a new DFS referral and then create a
-		 * new cache entry.
-		 */
-		if (!ses || !ses->server || !ses->server->ops->get_dfs_refer) {
-			ce = ERR_PTR(-EOPNOTSUPP);
-			return ce;
-		}
-		if (unlikely(!nls_codepage)) {
-			ce = ERR_PTR(-EINVAL);
-			return ce;
-		}
+	down_read(&htable_rw_lock);
 
-		nrefs = NULL;
-		numnrefs = 0;
+	ce = lookup_cache_entry(path, &hash);
 
-		cifs_dbg(FYI, "%s: DFS referral request for %s\n", __func__,
-			 path);
+	/*
+	 * If @noreq is set, no requests will be sent to the server. Just return
+	 * the cache entry.
+	 */
+	if (noreq) {
+		up_read(&htable_rw_lock);
+		return IS_ERR(ce) ? PTR_ERR(ce) : 0;
+	}
 
-		rc = ses->server->ops->get_dfs_refer(xid, ses, path, &nrefs,
-						     &numnrefs, nls_codepage,
-						     remap);
-		if (rc) {
-			ce = ERR_PTR(rc);
-			return ce;
+	if (!IS_ERR(ce)) {
+		if (!cache_entry_expired(ce)) {
+			dump_ce(ce);
+			up_read(&htable_rw_lock);
+			return 0;
 		}
+	} else {
+		newent = true;
+	}
 
-		dump_refs(nrefs, numnrefs);
+	up_read(&htable_rw_lock);
 
-		cifs_dbg(FYI, "%s: new cache entry\n", __func__);
+	/*
+	 * No entry was found.
+	 *
+	 * Request a new DFS referral in order to create a new cache entry, or
+	 * updating an existing one.
+	 */
+	rc = get_dfs_referral(xid, ses, nls_codepage, remap, path,
+			      &refs, &numrefs);
+	if (rc)
+		return rc;
 
-		if (cache_count >= CACHE_MAX_ENTRIES) {
-			cifs_dbg(FYI, "%s: reached max cache size (%d)",
-				 __func__, CACHE_MAX_ENTRIES);
-			remove_oldest_entry();
-		}
-		ce = add_cache_entry(h, path, nrefs, numnrefs);
-		free_dfs_info_array(nrefs, numnrefs);
+	dump_refs(refs, numrefs);
 
-		if (IS_ERR(ce))
-			return ce;
+	if (!newent) {
+		rc = update_cache_entry(path, refs, numrefs);
+		goto out_free_refs;
+	}
 
-		cache_count++;
+	if (atomic_read(&cache_count) >= CACHE_MAX_ENTRIES) {
+		cifs_dbg(FYI, "%s: reached max cache size (%d)", __func__,
+			 CACHE_MAX_ENTRIES);
+		down_write(&htable_rw_lock);
+		remove_oldest_entry();
+		up_write(&htable_rw_lock);
 	}
 
-	dump_ce(ce);
+	rc = add_cache_entry(path, hash, refs, numrefs);
+	if (!rc)
+		atomic_inc(&cache_count);
 
-	/* Just return the found cache entry in case @noreq is set */
-	if (noreq)
-		return ce;
-
-	if (cache_entry_expired(ce)) {
-		cifs_dbg(FYI, "%s: expired cache entry\n", __func__);
-		ce = update_cache_entry(xid, ses, nls_codepage, remap, path,
-					ce);
-		if (IS_ERR(ce)) {
-			cifs_dbg(FYI, "%s: failed to update expired entry\n",
-				 __func__);
-		}
-	}
-	return ce;
+out_free_refs:
+	free_dfs_info_array(refs, numrefs);
+	return rc;
 }
 
-/* Set up a new DFS referral from a given cache entry */
-static int setup_ref(const char *path, const struct cache_entry *ce,
-		     struct dfs_info3_param *ref, const char *tgt)
+/*
+ * Set up a DFS referral from a given cache entry.
+ *
+ * Must be called with htable_rw_lock held.
+ */
+static int setup_referral(const char *path, struct cache_entry *ce,
+			  struct dfs_info3_param *ref, const char *target)
 {
 	int rc;
 
@@ -742,18 +725,17 @@ static int setup_ref(const char *path, const struct cache_entry *ce,
 
 	memset(ref, 0, sizeof(*ref));
 
-	ref->path_name = kstrndup(path, strlen(path), GFP_KERNEL);
+	ref->path_name = kstrndup(path, strlen(path), GFP_ATOMIC);
 	if (!ref->path_name)
 		return -ENOMEM;
 
-	ref->path_consumed = ce->path_consumed;
-
-	ref->node_name = kstrndup(tgt, strlen(tgt), GFP_KERNEL);
+	ref->node_name = kstrndup(target, strlen(target), GFP_ATOMIC);
 	if (!ref->node_name) {
 		rc = -ENOMEM;
 		goto err_free_path;
 	}
 
+	ref->path_consumed = ce->path_consumed;
 	ref->ttl = ce->ttl;
 	ref->server_type = ce->srvtype;
 	ref->ref_flag = ce->flags;
@@ -767,8 +749,7 @@ static int setup_ref(const char *path, const struct cache_entry *ce,
 }
 
 /* Return target list of a DFS cache entry */
-static int get_tgt_list(const struct cache_entry *ce,
-			struct dfs_cache_tgt_list *tl)
+static int get_targets(struct cache_entry *ce, struct dfs_cache_tgt_list *tl)
 {
 	int rc;
 	struct list_head *head = &tl->tl_list;
@@ -779,14 +760,13 @@ static int get_tgt_list(const struct cache_entry *ce,
 	INIT_LIST_HEAD(head);
 
 	list_for_each_entry(t, &ce->tlist, list) {
-		it = kzalloc(sizeof(*it), GFP_KERNEL);
+		it = kzalloc(sizeof(*it), GFP_ATOMIC);
 		if (!it) {
 			rc = -ENOMEM;
 			goto err_free_it;
 		}
 
-		it->it_name = kstrndup(t->name, strlen(t->name),
-				       GFP_KERNEL);
+		it->it_name = kstrndup(t->name, strlen(t->name), GFP_ATOMIC);
 		if (!it->it_name) {
 			kfree(it);
 			rc = -ENOMEM;
@@ -798,6 +778,7 @@ static int get_tgt_list(const struct cache_entry *ce,
 		else
 			list_add_tail(&it->it_list, head);
 	}
+
 	tl->tl_numtgts = ce->numtgts;
 
 	return 0;
@@ -845,19 +826,29 @@ int dfs_cache_find(const unsigned int xid, struct cifs_ses *ses,
 	if (rc)
 		return rc;
 
-	mutex_lock(&list_lock);
-	ce = do_dfs_cache_find(xid, ses, nls_codepage, remap, npath, false);
-	if (!IS_ERR(ce)) {
-		if (ref)
-			rc = setup_ref(path, ce, ref, get_tgt_name(ce));
-		else
-			rc = 0;
-		if (!rc && tgt_list)
-			rc = get_tgt_list(ce, tgt_list);
-	} else {
+	rc = __dfs_cache_find(xid, ses, nls_codepage, remap, npath, false);
+	if (rc)
+		goto out_free_path;
+
+	down_read(&htable_rw_lock);
+
+	ce = lookup_cache_entry(npath, NULL);
+	if (IS_ERR(ce)) {
+		up_read(&htable_rw_lock);
 		rc = PTR_ERR(ce);
+		goto out_free_path;
 	}
-	mutex_unlock(&list_lock);
+
+	if (ref)
+		rc = setup_referral(path, ce, ref, get_tgt_name(ce));
+	else
+		rc = 0;
+	if (!rc && tgt_list)
+		rc = get_targets(ce, tgt_list);
+
+	up_read(&htable_rw_lock);
+
+out_free_path:
 	free_normalized_path(path, npath);
 	return rc;
 }
@@ -889,22 +880,27 @@ int dfs_cache_noreq_find(const char *path, struct dfs_info3_param *ref,
 	if (rc)
 		return rc;
 
-	mutex_lock(&list_lock);
-	ce = do_dfs_cache_find(0, NULL, NULL, 0, npath, true);
+	cifs_dbg(FYI, "%s: path: %s\n", __func__, npath);
+
+	down_read(&htable_rw_lock);
+
+	ce = lookup_cache_entry(npath, NULL);
 	if (IS_ERR(ce)) {
 		rc = PTR_ERR(ce);
-		goto out;
+		goto out_unlock;
 	}
 
 	if (ref)
-		rc = setup_ref(path, ce, ref, get_tgt_name(ce));
+		rc = setup_referral(path, ce, ref, get_tgt_name(ce));
 	else
 		rc = 0;
 	if (!rc && tgt_list)
-		rc = get_tgt_list(ce, tgt_list);
-out:
-	mutex_unlock(&list_lock);
+		rc = get_targets(ce, tgt_list);
+
+out_unlock:
+	up_read(&htable_rw_lock);
 	free_normalized_path(path, npath);
+
 	return rc;
 }
 
@@ -940,21 +936,24 @@ int dfs_cache_update_tgthint(const unsigned int xid, struct cifs_ses *ses,
 	if (rc)
 		return rc;
 
-	cifs_dbg(FYI, "%s: path: %s\n", __func__, npath);
+	cifs_dbg(FYI, "%s: update target hint - path: %s\n", __func__, npath);
+
+	rc = __dfs_cache_find(xid, ses, nls_codepage, remap, npath, false);
+	if (rc)
+		goto out_free_path;
 
-	mutex_lock(&list_lock);
-	ce = do_dfs_cache_find(xid, ses, nls_codepage, remap, npath, false);
+	down_write(&htable_rw_lock);
+
+	ce = lookup_cache_entry(npath, NULL);
 	if (IS_ERR(ce)) {
 		rc = PTR_ERR(ce);
-		goto out;
+		goto out_unlock;
 	}
 
-	rc = 0;
-
 	t = ce->tgthint;
 
 	if (likely(!strcasecmp(it->it_name, t->name)))
-		goto out;
+		goto out_unlock;
 
 	list_for_each_entry(t, &ce->tlist, list) {
 		if (!strcasecmp(t->name, it->it_name)) {
@@ -965,9 +964,11 @@ int dfs_cache_update_tgthint(const unsigned int xid, struct cifs_ses *ses,
 		}
 	}
 
-out:
-	mutex_unlock(&list_lock);
+out_unlock:
+	up_write(&htable_rw_lock);
+out_free_path:
 	free_normalized_path(path, npath);
+
 	return rc;
 }
 
@@ -1002,20 +1003,19 @@ int dfs_cache_noreq_update_tgthint(const char *path,
 
 	cifs_dbg(FYI, "%s: path: %s\n", __func__, npath);
 
-	mutex_lock(&list_lock);
+	down_write(&htable_rw_lock);
 
-	ce = do_dfs_cache_find(0, NULL, NULL, 0, npath, true);
+	ce = lookup_cache_entry(npath, NULL);
 	if (IS_ERR(ce)) {
 		rc = PTR_ERR(ce);
-		goto out;
+		goto out_unlock;
 	}
 
 	rc = 0;
-
 	t = ce->tgthint;
 
 	if (unlikely(!strcasecmp(it->it_name, t->name)))
-		goto out;
+		goto out_unlock;
 
 	list_for_each_entry(t, &ce->tlist, list) {
 		if (!strcasecmp(t->name, it->it_name)) {
@@ -1026,9 +1026,10 @@ int dfs_cache_noreq_update_tgthint(const char *path,
 		}
 	}
 
-out:
-	mutex_unlock(&list_lock);
+out_unlock:
+	up_write(&htable_rw_lock);
 	free_normalized_path(path, npath);
+
 	return rc;
 }
 
@@ -1049,7 +1050,6 @@ int dfs_cache_get_tgt_referral(const char *path,
 	int rc;
 	char *npath;
 	struct cache_entry *ce;
-	unsigned int h;
 
 	if (!it || !ref)
 		return -EINVAL;
@@ -1060,21 +1060,22 @@ int dfs_cache_get_tgt_referral(const char *path,
 
 	cifs_dbg(FYI, "%s: path: %s\n", __func__, npath);
 
-	mutex_lock(&list_lock);
+	down_read(&htable_rw_lock);
 
-	ce = lookup_cache_entry(npath, &h);
+	ce = lookup_cache_entry(npath, NULL);
 	if (IS_ERR(ce)) {
 		rc = PTR_ERR(ce);
-		goto out;
+		goto out_unlock;
 	}
 
 	cifs_dbg(FYI, "%s: target name: %s\n", __func__, it->it_name);
 
-	rc = setup_ref(path, ce, ref, it->it_name);
+	rc = setup_referral(path, ce, ref, it->it_name);
 
-out:
-	mutex_unlock(&list_lock);
+out_unlock:
+	up_read(&htable_rw_lock);
 	free_normalized_path(path, npath);
+
 	return rc;
 }
 
@@ -1343,6 +1344,7 @@ static struct cifs_ses *find_root_ses(struct vol_info *vi,
 {
 	char *rpath;
 	int rc;
+	struct cache_entry *ce;
 	struct dfs_info3_param ref = {0};
 	char *mdata = NULL, *devname = NULL;
 	struct TCP_Server_Info *server;
@@ -1353,15 +1355,26 @@ static struct cifs_ses *find_root_ses(struct vol_info *vi,
 	if (IS_ERR(rpath))
 		return ERR_CAST(rpath);
 
-	memset(&vol, 0, sizeof(vol));
+	down_read(&htable_rw_lock);
+
+	ce = lookup_cache_entry(rpath, NULL);
+	if (IS_ERR(ce)) {
+		up_read(&htable_rw_lock);
+		ses = ERR_CAST(ce);
+		goto out;
+	}
 
-	rc = dfs_cache_noreq_find(rpath, &ref, NULL);
+	rc = setup_referral(path, ce, &ref, get_tgt_name(ce));
 	if (rc) {
+		up_read(&htable_rw_lock);
 		ses = ERR_PTR(rc);
 		goto out;
 	}
 
-	mdata = cifs_compose_mount_options(vi->mntdata, rpath, &ref, &devname);
+	up_read(&htable_rw_lock);
+
+	mdata = cifs_compose_mount_options(vi->mntdata, rpath, &ref,
+					   &devname);
 	free_dfs_info_param(&ref);
 
 	if (IS_ERR(mdata)) {
@@ -1395,16 +1408,15 @@ static struct cifs_ses *find_root_ses(struct vol_info *vi,
 }
 
 /* Refresh DFS cache entry from a given tcon */
-static void refresh_tcon(struct vol_info *vi, struct cifs_tcon *tcon)
+static int refresh_tcon(struct vol_info *vi, struct cifs_tcon *tcon)
 {
 	int rc = 0;
 	unsigned int xid;
 	char *path, *npath;
-	unsigned int h;
 	struct cache_entry *ce;
+	struct cifs_ses *root_ses = NULL, *ses;
 	struct dfs_info3_param *refs = NULL;
 	int numrefs = 0;
-	struct cifs_ses *root_ses = NULL, *ses;
 
 	xid = get_xid();
 
@@ -1412,19 +1424,23 @@ static void refresh_tcon(struct vol_info *vi, struct cifs_tcon *tcon)
 
 	rc = get_normalized_path(path, &npath);
 	if (rc)
-		goto out;
+		goto out_free_xid;
 
-	mutex_lock(&list_lock);
-	ce = lookup_cache_entry(npath, &h);
-	mutex_unlock(&list_lock);
+	down_read(&htable_rw_lock);
 
+	ce = lookup_cache_entry(npath, NULL);
 	if (IS_ERR(ce)) {
 		rc = PTR_ERR(ce);
-		goto out;
+		up_read(&htable_rw_lock);
+		goto out_free_path;
 	}
 
-	if (!cache_entry_expired(ce))
-		goto out;
+	if (!cache_entry_expired(ce)) {
+		up_read(&htable_rw_lock);
+		goto out_free_path;
+	}
+
+	up_read(&htable_rw_lock);
 
 	/* If it's a DFS Link, then use root SMB session for refreshing it */
 	if (is_dfs_link(npath)) {
@@ -1432,35 +1448,29 @@ static void refresh_tcon(struct vol_info *vi, struct cifs_tcon *tcon)
 		if (IS_ERR(ses)) {
 			rc = PTR_ERR(ses);
 			root_ses = NULL;
-			goto out;
+			goto out_free_path;
 		}
 	} else {
 		ses = tcon->ses;
 	}
 
-	if (unlikely(!ses->server->ops->get_dfs_refer)) {
-		rc = -EOPNOTSUPP;
-	} else {
-		rc = ses->server->ops->get_dfs_refer(xid, ses, path, &refs,
-						     &numrefs, cache_nlsc,
-						     tcon->remap);
-		if (!rc) {
-			mutex_lock(&list_lock);
-			ce = __update_cache_entry(npath, refs, numrefs);
-			mutex_unlock(&list_lock);
-			dump_refs(refs, numrefs);
-			free_dfs_info_array(refs, numrefs);
-			if (IS_ERR(ce))
-				rc = PTR_ERR(ce);
-		}
+	rc = get_dfs_referral(xid, ses, cache_nlsc, tcon->remap, npath, &refs,
+			      &numrefs);
+	if (!rc) {
+		dump_refs(refs, numrefs);
+		rc = update_cache_entry(npath, refs, numrefs);
+		free_dfs_info_array(refs, numrefs);
 	}
 
-out:
 	if (root_ses)
 		cifs_put_smb_ses(root_ses);
 
-	free_xid(xid);
+out_free_path:
 	free_normalized_path(path, npath);
+
+out_free_xid:
+	free_xid(xid);
+	return rc;
 }
 
 /*
@@ -1474,6 +1484,7 @@ static void refresh_cache_worker(struct work_struct *work)
 	LIST_HEAD(vols);
 	LIST_HEAD(tcons);
 	struct cifs_tcon *tcon, *ntcon;
+	int rc;
 
 	/*
 	 * Find SMB volumes that are eligible (server->tcpStatus == CifsGood)
@@ -1501,8 +1512,16 @@ static void refresh_cache_worker(struct work_struct *work)
 			goto next_vol;
 
 		get_tcons(server, &tcons);
+		rc = 0;
+
 		list_for_each_entry_safe(tcon, ntcon, &tcons, ulist) {
-			refresh_tcon(vi, tcon);
+			/*
+			 * Skip tcp server if any of its tcons failed to refresh
+			 * (possibily due to reconnects).
+			 */
+			if (!rc)
+				rc = refresh_tcon(vi, tcon);
+
 			list_del_init(&tcon->ulist);
 			cifs_put_tcon(tcon);
 		}
-- 
2.24.0

