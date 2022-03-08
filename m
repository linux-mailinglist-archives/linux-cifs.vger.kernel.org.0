Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC874D277F
	for <lists+linux-cifs@lfdr.de>; Wed,  9 Mar 2022 05:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231143AbiCIBje (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 8 Mar 2022 20:39:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48210 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiCIBjd (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 8 Mar 2022 20:39:33 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1DF07C791C
        for <linux-cifs@vger.kernel.org>; Tue,  8 Mar 2022 17:38:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646789914;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KBFHdKKHoDjr1TUu4BsB9HH3Wp0sMYIusKKTd5TPCQ0=;
        b=Oi9p9oBZo2ko2eAbJc8+exW8GZ89NTeavhs9PHqPFZeBH0mwl5h6YGlvNUCoJXeGk8IZPz
        loqthUVemqs2c5ciowF5qLTBvIi9aKN7oUQcBKypbWeLho48UGzT3eIpJvgrrUaNI8rmnq
        EBqELOerbxoWdsZL+IL8XE+ubs+1/Us=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-658-a1TV6opdOWGPrxazKtqIXg-1; Tue, 08 Mar 2022 18:25:21 -0500
X-MC-Unique: a1TV6opdOWGPrxazKtqIXg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 746CC801AFE;
        Tue,  8 Mar 2022 23:25:19 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5A1021006910;
        Tue,  8 Mar 2022 23:25:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH v2 01/19] fscache: export fscache_end_operation()
From:   David Howells <dhowells@redhat.com>
To:     linux-cachefs@redhat.com
Cc:     Jeffle Xu <jefflexu@linux.alibaba.com>, dhowells@redhat.com,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Tue, 08 Mar 2022 23:25:03 +0000
Message-ID: <164678190346.1200972.7453733431978569479.stgit@warthog.procyon.org.uk>
In-Reply-To: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
References: <164678185692.1200972.597611902374126174.stgit@warthog.procyon.org.uk>
User-Agent: StGit/1.4
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

From: Jeffle Xu <jefflexu@linux.alibaba.com>

Export fscache_end_operation() to avoid code duplication.

Besides, considering the paired fscache_begin_read_operation() is
already exported, it shall make sense to also export
fscache_end_operation().

Signed-off-by: Jeffle Xu <jefflexu@linux.alibaba.com>
Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com

Link: https://lore.kernel.org/r/20220302125134.131039-2-jefflexu@linux.alibaba.com/ # Jeffle's v4
Link: https://lore.kernel.org/r/164622971432.3564931.12184135678781328146.stgit@warthog.procyon.org.uk/ # v1
---

 fs/cifs/fscache.c       |    8 --------
 fs/fscache/internal.h   |   11 -----------
 fs/nfs/fscache.c        |    8 --------
 include/linux/fscache.h |   14 ++++++++++++++
 4 files changed, 14 insertions(+), 27 deletions(-)

diff --git a/fs/cifs/fscache.c b/fs/cifs/fscache.c
index 33af72e0ac0c..b47c2011ce5b 100644
--- a/fs/cifs/fscache.c
+++ b/fs/cifs/fscache.c
@@ -134,14 +134,6 @@ void cifs_fscache_release_inode_cookie(struct inode *inode)
 	}
 }
 
-static inline void fscache_end_operation(struct netfs_cache_resources *cres)
-{
-	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
-
-	if (ops)
-		ops->end_operation(cres);
-}
-
 /*
  * Fallback page reading interface.
  */
diff --git a/fs/fscache/internal.h b/fs/fscache/internal.h
index f121c21590dc..ed1c9ed737f2 100644
--- a/fs/fscache/internal.h
+++ b/fs/fscache/internal.h
@@ -70,17 +70,6 @@ static inline void fscache_see_cookie(struct fscache_cookie *cookie,
 			     where);
 }
 
-/*
- * io.c
- */
-static inline void fscache_end_operation(struct netfs_cache_resources *cres)
-{
-	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
-
-	if (ops)
-		ops->end_operation(cres);
-}
-
 /*
  * main.c
  */
diff --git a/fs/nfs/fscache.c b/fs/nfs/fscache.c
index cfe901650ab0..39654ca72d3d 100644
--- a/fs/nfs/fscache.c
+++ b/fs/nfs/fscache.c
@@ -249,14 +249,6 @@ void nfs_fscache_release_file(struct inode *inode, struct file *filp)
 	}
 }
 
-static inline void fscache_end_operation(struct netfs_cache_resources *cres)
-{
-	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
-
-	if (ops)
-		ops->end_operation(cres);
-}
-
 /*
  * Fallback page reading interface.
  */
diff --git a/include/linux/fscache.h b/include/linux/fscache.h
index 296c5f1d9f35..d2430da8aa67 100644
--- a/include/linux/fscache.h
+++ b/include/linux/fscache.h
@@ -456,6 +456,20 @@ int fscache_begin_read_operation(struct netfs_cache_resources *cres,
 	return -ENOBUFS;
 }
 
+/**
+ * fscache_end_operation - End the read operation for the netfs lib
+ * @cres: The cache resources for the read operation
+ *
+ * Clean up the resources at the end of the read request.
+ */
+static inline void fscache_end_operation(struct netfs_cache_resources *cres)
+{
+	const struct netfs_cache_ops *ops = fscache_operation_valid(cres);
+
+	if (ops)
+		ops->end_operation(cres);
+}
+
 /**
  * fscache_read - Start a read from the cache.
  * @cres: The cache resources to use


