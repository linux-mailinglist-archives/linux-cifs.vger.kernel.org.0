Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C2EBE4618B5
	for <lists+linux-cifs@lfdr.de>; Mon, 29 Nov 2021 15:30:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349403AbhK2Od4 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 29 Nov 2021 09:33:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:34601 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234269AbhK2Obe (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 29 Nov 2021 09:31:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638196096;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Hf2B+E29TDBePeCDt2gmg6sWi5Ar9Nm/FxrWYvpKiOM=;
        b=Qu9iUuXTjm3ILvHkWBPttFsa35VPLwv5SUUVaYfIqMvpc5+LcxiEPSx5jB04EgmlleqCR1
        FruoS3UqowvW2EUeoVZboh6FMWOWwzNBihMjry5h257YsQQmvByDXzrK0hN4vbRrJdrs/Z
        UBAUi2rVMk8uaGC3FW49Oq2AC0RtCy0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-511-YwpaRpQqOhu_SoL0CyNx8w-1; Mon, 29 Nov 2021 09:28:12 -0500
X-MC-Unique: YwpaRpQqOhu_SoL0CyNx8w-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CC8381CCFF;
        Mon, 29 Nov 2021 14:28:10 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id BD4B25D6B1;
        Mon, 29 Nov 2021 14:28:06 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 21/64] fscache: Count data storage objects in a cache
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     dhowells@redhat.com, Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Omar Sandoval <osandov@osandov.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 14:28:05 +0000
Message-ID: <163819608594.215744.1812706538117388252.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Count the data storage objects that are currently allocated in a cache.
This is used to pin certain cache structures until cache withdrawal is
complete.

Three helpers are provided to manage and make use of the count:

 (1) void fscache_count_object(struct fscache_cache *cache);

     This should be called by the cache backend to note that an object has
     been allocated and attached to the cache.

 (2) void fscache_uncount_object(struct fscache_cache *cache);

     This should be called by the backend to note that an object has been
     destroyed.  This sends a wakeup event that allows cache withdrawal to
     proceed if it was waiting for that object.

 (3) void fscache_wait_for_objects(struct fscache_cache *cache);

     This can be used by the backend to wait for all outstanding cache
     object to be destroyed.

Each cache's counter is displayed as part of /proc/fs/fscache/caches.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/fscache/cache.c            |    2 ++
 include/linux/fscache-cache.h |   39 +++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+)

diff --git a/fs/fscache/cache.c b/fs/fscache/cache.c
index 25eac61f1c29..2749933852a9 100644
--- a/fs/fscache/cache.c
+++ b/fs/fscache/cache.c
@@ -13,6 +13,8 @@
 static LIST_HEAD(fscache_caches);
 DECLARE_RWSEM(fscache_addremove_sem);
 EXPORT_SYMBOL(fscache_addremove_sem);
+DECLARE_WAIT_QUEUE_HEAD(fscache_clearance_waiters);
+EXPORT_SYMBOL(fscache_clearance_waiters);
 
 static atomic_t fscache_cache_debug_id;
 
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 566497cf5f13..5525df056877 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -76,6 +76,7 @@ struct fscache_cache_ops {
 };
 
 extern struct workqueue_struct *fscache_wq;
+extern wait_queue_head_t fscache_clearance_waiters;
 
 /*
  * out-of-line cache backend functions
@@ -140,4 +141,42 @@ static inline struct fscache_cookie *fscache_cres_cookie(struct netfs_cache_reso
 	return cres->cache_priv;
 }
 
+/**
+ * fscache_count_object - Tell fscache that an object has been added
+ * @cache: The cache to account to
+ *
+ * Tell fscache that an object has been added to the cache.  This prevents the
+ * cache from tearing down the cache structure until the object is uncounted.
+ */
+static inline void fscache_count_object(struct fscache_cache *cache)
+{
+	atomic_inc(&cache->object_count);
+}
+
+/**
+ * fscache_uncount_object - Tell fscache that an object has been removed
+ * @cache: The cache to account to
+ *
+ * Tell fscache that an object has been removed from the cache and will no
+ * longer be accessed.  After this point, the cache cookie may be destroyed.
+ */
+static inline void fscache_uncount_object(struct fscache_cache *cache)
+{
+	if (atomic_dec_and_test(&cache->object_count))
+		wake_up_all(&fscache_clearance_waiters);
+}
+
+/**
+ * fscache_cache_wait_for_objects - Wait for all objects to be withdrawn
+ * @cache: The cache to query
+ *
+ * Wait for all extant objects in a cache to finish being withdrawn
+ * and go away.
+ */
+static inline void fscache_wait_for_objects(struct fscache_cache *cache)
+{
+	wait_event(fscache_clearance_waiters,
+		   atomic_read(&cache->object_count) == 0);
+}
+
 #endif /* _LINUX_FSCACHE_CACHE_H */


