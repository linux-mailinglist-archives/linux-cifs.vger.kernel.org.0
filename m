Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3B1862BADE3
	for <lists+linux-cifs@lfdr.de>; Fri, 20 Nov 2020 16:22:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728720AbgKTPLB (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 20 Nov 2020 10:11:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:34398 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728762AbgKTPLB (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 20 Nov 2020 10:11:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1605885060;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=XT1pKpebF0gtVPrcMfWMCH+HF5vrTyJrwQ/BlskOnJ4=;
        b=AXlcR7RcPC4t4Sgc1AKXISPjxaaOWXVmDXvqIcgZuCNeF5KxBh+BXPkhqbtv3OTcOvWh3s
        HZUcOpW1cjFsu6Ee1DC1JNzYEcTcLn2oDoH/pDqEMRt95XMbAPqTNK15nmwLP9CAX2SV6G
        vcNG8RvdHTqwEA//ujc8gHnqWQ+yMT4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-574-8XWVxA1TMPCutCtX6J68gg-1; Fri, 20 Nov 2020 10:10:59 -0500
X-MC-Unique: 8XWVxA1TMPCutCtX6J68gg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 395FEC73A3;
        Fri, 20 Nov 2020 15:10:57 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-246.rdu2.redhat.com [10.10.112.246])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A538E5D6AD;
        Fri, 20 Nov 2020 15:10:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [RFC PATCH 38/76] cachefiles: Split cachefiles_drop_object() up a bit
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>
Cc:     dhowells@redhat.com, Jeff Layton <jlayton@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Fri, 20 Nov 2020 15:10:50 +0000
Message-ID: <160588505087.3465195.3378506836842491220.stgit@warthog.procyon.org.uk>
In-Reply-To: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
References: <160588455242.3465195.3214733858273019178.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Split cachefiles_drop_object() up a bit to make it easier to modify later.

Signed-off-by: David Howells <dhowells@redhat.com>
---

 fs/cachefiles/interface.c |   58 ++++++++++++++++++++++++++++++---------------
 1 file changed, 39 insertions(+), 19 deletions(-)

diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index e40118e65e25..3f6d2be690bc 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -192,6 +192,42 @@ static void cachefiles_update_object(struct fscache_object *_object)
 	_leave("");
 }
 
+/*
+ * Commit changes to the object as we drop it.
+ */
+static void cachefiles_commit_object(struct cachefiles_object *object,
+				     struct cachefiles_cache *cache)
+{
+}
+
+/*
+ * Finalise and object and close the VFS structs that we have.
+ */
+static void cachefiles_clean_up_object(struct cachefiles_object *object,
+				       struct cachefiles_cache *cache,
+				       bool invalidate)
+{
+	if (invalidate && &object->fscache != cache->cache.fsdef) {
+		_debug("- inval object OBJ%x", object->fscache.debug_id);
+		cachefiles_delete_object(cache, object);
+	} else {
+		cachefiles_commit_object(object, cache);
+	}
+
+	/* close the filesystem stuff attached to the object */
+	if (object->backing_file)
+		fput(object->backing_file);
+	object->backing_file = NULL;
+
+	if (object->backer != object->dentry)
+		dput(object->backer);
+	object->backer = NULL;
+
+	cachefiles_unmark_inode_in_use(object, object->dentry);
+	dput(object->dentry);
+	object->dentry = NULL;
+}
+
 /*
  * discard the resources pinned by an object and effect retirement if
  * requested
@@ -223,25 +259,9 @@ static void cachefiles_drop_object(struct fscache_object *_object,
 	 * before we set it up.
 	 */
 	if (object->dentry) {
-		if (invalidate && _object != cache->cache.fsdef) {
-			_debug("- inval object OBJ%x", object->fscache.debug_id);
-			cachefiles_begin_secure(cache, &saved_cred);
-			cachefiles_delete_object(cache, object);
-			cachefiles_end_secure(cache, saved_cred);
-		}
-
-		/* close the filesystem stuff attached to the object */
-		if (object->backing_file)
-			fput(object->backing_file);
-		object->backing_file = NULL;
-
-		if (object->backer != object->dentry)
-			dput(object->backer);
-		object->backer = NULL;
-
-		cachefiles_unmark_inode_in_use(object, object->dentry);
-		dput(object->dentry);
-		object->dentry = NULL;
+		cachefiles_begin_secure(cache, &saved_cred);
+		cachefiles_clean_up_object(object, cache, invalidate);
+		cachefiles_end_secure(cache, saved_cred);
 	}
 
 	_leave("");


