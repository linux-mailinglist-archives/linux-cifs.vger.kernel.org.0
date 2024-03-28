Return-Path: <linux-cifs+bounces-1668-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 251C7890699
	for <lists+linux-cifs@lfdr.de>; Thu, 28 Mar 2024 18:02:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B8A04B2695D
	for <lists+linux-cifs@lfdr.de>; Thu, 28 Mar 2024 17:02:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E0B22446A9;
	Thu, 28 Mar 2024 17:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+lMY3K4"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D637136E28
	for <linux-cifs@vger.kernel.org>; Thu, 28 Mar 2024 17:00:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645208; cv=none; b=r43OBpWAtVtVBc3LCseqBrb1PQ0doWdOjIYbY5SjvAWoipN/lExNshJIDhwOqmScPu5mCQohnzTB0/9q6i7JiySRGXIjghZc+vlyBXhNwp9lQD1Vqwo2eFrWbr+Bv/jtykSddkckjC3SsW8R6eIpJ+DsdrLHnsg7JZJ3W33lfJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645208; c=relaxed/simple;
	bh=1H+o+v897zLhA37MJj9BJEjve71vHhPdyEjqxJssFSQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=N+LoByZoCNDGF/6k/NQ5HZae95XWVqVsIACCirnegTOmKCO3QZuFa+9WRg9MxZCbwnAno71ePKuHpnpljCp2tu5cEp9iKOe7Cr4CXma1kJJoFzmVsG7KO3ST/oSz7ow33qgsABBWymTnxOMI1RWFUvlTZimXu9/709mW5EbjelQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R+lMY3K4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711645206;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FdETRfB8DnsEfVd472r7IU+9uzPySp2hW2I+XAgROTY=;
	b=R+lMY3K4u8aEFaVCjYaXD0JtSBB6E+mqBZ9wrsnhMIV27vlPSeCG05VmHz10UT2CJBep99
	Z7GXYHVjehK2kJG6UgQOeAGcw3PiFzBGCGlY6lif65/hua65fR9NbXz0j3WQFBMY4SpwwM
	av0O5sFH/IIPWpRuJx/xeIeLpFEiSuw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-B-6RQZNSNq6woioU60vOtQ-1; Thu,
 28 Mar 2024 13:00:00 -0400
X-MC-Unique: B-6RQZNSNq6woioU60vOtQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E51281C2CDE3;
	Thu, 28 Mar 2024 16:59:59 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id F29CF2166B31;
	Thu, 28 Mar 2024 16:59:57 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Steve French <sfrench@samba.org>,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Rohith Surabattula <rohiths.msft@gmail.com>
Subject: [PATCH v6 08/15] cifs: Add mempools for cifs_io_request and cifs_io_subrequest structs
Date: Thu, 28 Mar 2024 16:57:59 +0000
Message-ID: <20240328165845.2782259-9-dhowells@redhat.com>
In-Reply-To: <20240328165845.2782259-1-dhowells@redhat.com>
References: <20240328165845.2782259-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Add mempools for the allocation of cifs_io_request and cifs_io_subrequest
structs for netfslib to use so that it can guarantee eventual allocation in
writeback.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-mm@kvack.org
---
 fs/smb/client/cifsfs.c   | 55 +++++++++++++++++++++++++++++++++++++++-
 fs/smb/client/cifsglob.h |  2 ++
 2 files changed, 56 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 2dd29663dab1..d8c31383752a 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -370,9 +370,13 @@ static struct kmem_cache *cifs_inode_cachep;
 static struct kmem_cache *cifs_req_cachep;
 static struct kmem_cache *cifs_mid_cachep;
 static struct kmem_cache *cifs_sm_req_cachep;
+static struct kmem_cache *cifs_io_request_cachep;
+static struct kmem_cache *cifs_io_subrequest_cachep;
 mempool_t *cifs_sm_req_poolp;
 mempool_t *cifs_req_poolp;
 mempool_t *cifs_mid_poolp;
+mempool_t cifs_io_request_pool;
+mempool_t cifs_io_subrequest_pool;
 
 static struct inode *
 cifs_alloc_inode(struct super_block *sb)
@@ -1746,6 +1750,48 @@ static void destroy_mids(void)
 	kmem_cache_destroy(cifs_mid_cachep);
 }
 
+static int cifs_init_netfs(void)
+{
+	cifs_io_request_cachep =
+		kmem_cache_create("cifs_io_request",
+				  sizeof(struct netfs_io_request), 0,
+				  SLAB_HWCACHE_ALIGN, NULL);
+	if (!cifs_io_request_cachep)
+		goto nomem_req;
+
+	if (mempool_init_slab_pool(&cifs_io_request_pool, 100, cifs_io_request_cachep) < 0)
+		goto nomem_reqpool;
+
+	cifs_io_subrequest_cachep =
+		kmem_cache_create("cifs_io_subrequest",
+				  sizeof(struct cifs_io_subrequest), 0,
+				  SLAB_HWCACHE_ALIGN, NULL);
+	if (!cifs_io_subrequest_cachep)
+		goto nomem_subreq;
+
+	if (mempool_init_slab_pool(&cifs_io_subrequest_pool, 100, cifs_io_subrequest_cachep) < 0)
+		goto nomem_subreqpool;
+
+	return 0;
+
+nomem_subreqpool:
+	kmem_cache_destroy(cifs_io_subrequest_cachep);
+nomem_subreq:
+	mempool_destroy(&cifs_io_request_pool);
+nomem_reqpool:
+	kmem_cache_destroy(cifs_io_request_cachep);
+nomem_req:
+	return -ENOMEM;
+}
+
+static void cifs_destroy_netfs(void)
+{
+	mempool_destroy(&cifs_io_subrequest_pool);
+	kmem_cache_destroy(cifs_io_subrequest_cachep);
+	mempool_destroy(&cifs_io_request_pool);
+	kmem_cache_destroy(cifs_io_request_cachep);
+}
+
 static int __init
 init_cifs(void)
 {
@@ -1843,10 +1889,14 @@ init_cifs(void)
 	if (rc)
 		goto out_destroy_deferredclose_wq;
 
-	rc = init_mids();
+	rc = cifs_init_netfs();
 	if (rc)
 		goto out_destroy_inodecache;
 
+	rc = init_mids();
+	if (rc)
+		goto out_destroy_netfs;
+
 	rc = cifs_init_request_bufs();
 	if (rc)
 		goto out_destroy_mids;
@@ -1901,6 +1951,8 @@ init_cifs(void)
 	cifs_destroy_request_bufs();
 out_destroy_mids:
 	destroy_mids();
+out_destroy_netfs:
+	cifs_destroy_netfs();
 out_destroy_inodecache:
 	cifs_destroy_inodecache();
 out_destroy_deferredclose_wq:
@@ -1937,6 +1989,7 @@ exit_cifs(void)
 #endif
 	cifs_destroy_request_bufs();
 	destroy_mids();
+	cifs_destroy_netfs();
 	cifs_destroy_inodecache();
 	destroy_workqueue(deferredclose_wq);
 	destroy_workqueue(cifsoplockd_wq);
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 6436d360b9f4..057a7933b175 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -2089,6 +2089,8 @@ extern __u32 cifs_lock_secret;
 extern mempool_t *cifs_sm_req_poolp;
 extern mempool_t *cifs_req_poolp;
 extern mempool_t *cifs_mid_poolp;
+extern mempool_t cifs_io_request_pool;
+extern mempool_t cifs_io_subrequest_pool;
 
 /* Operations for different SMB versions */
 #define SMB1_VERSION_STRING	"1.0"


