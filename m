Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 23B8E47DB1B
	for <lists+linux-cifs@lfdr.de>; Thu, 23 Dec 2021 00:28:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345237AbhLVX2L (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 22 Dec 2021 18:28:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48120 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1345073AbhLVX2J (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 22 Dec 2021 18:28:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1640215689;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4/mMltejFOBnunr+4lbQ8HqeG5CJr2IE4M+LiI+6/I8=;
        b=KyVOBTWwfNE5QaCK4rL9/sG+U4Bkn5u9svsZ7b/c1CrZZKsr7ZIPfTGUK6sYlVeJONjHpC
        5ncml3CyCqaMWw67b0uJUXSBpQLqyVyF1xOpFyw88kEPhBKi5wNUJEh0fyJUZ0K/FYKlUZ
        Yf+P1cB8qm9ffL3phVS3Hfw7tYrPRjw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-Z0hrSDepN6KC2xpWhNYOwg-1; Wed, 22 Dec 2021 18:28:05 -0500
X-MC-Unique: Z0hrSDepN6KC2xpWhNYOwg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 2DDFF1030C20;
        Wed, 22 Dec 2021 23:28:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.165])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14DFB7EFF7;
        Wed, 22 Dec 2021 23:27:56 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v4 55/68] fscache, cachefiles: Display stat of culling events
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
        JeffleXu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Wed, 22 Dec 2021 23:27:56 +0000
Message-ID: <164021567619.640689.4339228906248763197.stgit@warthog.procyon.org.uk>
In-Reply-To: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
References: <164021479106.640689.17404516570194656552.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Add a stat counter of culling events whereby the cache backend culls a file
to make space (when asked by cachefilesd in this case) and display in
/proc/fs/fscache/stats.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
Link: https://lore.kernel.org/r/163819654165.215744.3797804661644212436.stgit@warthog.procyon.org.uk/ # v1
Link: https://lore.kernel.org/r/163906961387.143852.9291157239960289090.stgit@warthog.procyon.org.uk/ # v2
Link: https://lore.kernel.org/r/163967168266.1823006.14436200166581605746.stgit@warthog.procyon.org.uk/ # v3
---

 fs/cachefiles/namei.c         |    1 +
 fs/fscache/stats.c            |    7 +++++--
 include/linux/fscache-cache.h |    3 +++
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index ab3ca598acac..9bd692870617 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -805,6 +805,7 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 	if (ret < 0)
 		goto error;
 
+	fscache_count_culled();
 	dput(victim);
 	_leave(" = 0");
 	return 0;
diff --git a/fs/fscache/stats.c b/fs/fscache/stats.c
index db2f4e225dd9..fc94e5e79f1c 100644
--- a/fs/fscache/stats.c
+++ b/fs/fscache/stats.c
@@ -46,6 +46,8 @@ atomic_t fscache_n_no_write_space;
 EXPORT_SYMBOL(fscache_n_no_write_space);
 atomic_t fscache_n_no_create_space;
 EXPORT_SYMBOL(fscache_n_no_create_space);
+atomic_t fscache_n_culled;
+EXPORT_SYMBOL(fscache_n_culled);
 
 /*
  * display the general statistics
@@ -86,9 +88,10 @@ int fscache_stats_show(struct seq_file *m, void *v)
 		   atomic_read(&fscache_n_relinquishes_retire),
 		   atomic_read(&fscache_n_relinquishes_dropped));
 
-	seq_printf(m, "NoSpace: nwr=%u ncr=%u\n",
+	seq_printf(m, "NoSpace: nwr=%u ncr=%u cull=%u\n",
 		   atomic_read(&fscache_n_no_write_space),
-		   atomic_read(&fscache_n_no_create_space));
+		   atomic_read(&fscache_n_no_create_space),
+		   atomic_read(&fscache_n_culled));
 
 	seq_printf(m, "IO     : rd=%u wr=%u\n",
 		   atomic_read(&fscache_n_read),
diff --git a/include/linux/fscache-cache.h b/include/linux/fscache-cache.h
index 007e47f38610..a174cedf4d90 100644
--- a/include/linux/fscache-cache.h
+++ b/include/linux/fscache-cache.h
@@ -188,15 +188,18 @@ extern atomic_t fscache_n_read;
 extern atomic_t fscache_n_write;
 extern atomic_t fscache_n_no_write_space;
 extern atomic_t fscache_n_no_create_space;
+extern atomic_t fscache_n_culled;
 #define fscache_count_read() atomic_inc(&fscache_n_read)
 #define fscache_count_write() atomic_inc(&fscache_n_write)
 #define fscache_count_no_write_space() atomic_inc(&fscache_n_no_write_space)
 #define fscache_count_no_create_space() atomic_inc(&fscache_n_no_create_space)
+#define fscache_count_culled() atomic_inc(&fscache_n_culled)
 #else
 #define fscache_count_read() do {} while(0)
 #define fscache_count_write() do {} while(0)
 #define fscache_count_no_write_space() do {} while(0)
 #define fscache_count_no_create_space() do {} while(0)
+#define fscache_count_culled() do {} while(0)
 #endif
 
 #endif /* _LINUX_FSCACHE_CACHE_H */


