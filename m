Return-Path: <linux-cifs+bounces-622-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 923F4822454
	for <lists+linux-cifs@lfdr.de>; Tue,  2 Jan 2024 23:02:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9972B1C21794
	for <lists+linux-cifs@lfdr.de>; Tue,  2 Jan 2024 22:02:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52105171C2;
	Tue,  2 Jan 2024 21:49:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GvwVa26c"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87183171BF
	for <linux-cifs@vger.kernel.org>; Tue,  2 Jan 2024 21:49:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1704232186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NfIqhioGhHP/wJG1PyBueewTz4bWCmx/gOhAGW5jQdE=;
	b=GvwVa26caIkhMhOkeHydufPNl32yA/XiJu0r+3T4OUqxE5RV8mSF189dIcCcwyVpZzshH+
	A/mIIY2RWncnMam8ha+K3aJaztiuz+7gYJSWc/8c8qEvN2dal4WaNFSokIIfYqR9wkzSmG
	0YdO8l8wbJuMYruYw/1229s+wCdQJR8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-53-fjvlDl11PWuF-0vej4x9hg-1; Tue, 02 Jan 2024 16:49:43 -0500
X-MC-Unique: fjvlDl11PWuF-0vej4x9hg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C03CB86D4D5;
	Tue,  2 Jan 2024 21:49:42 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.68])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 9617D492BE6;
	Tue,  2 Jan 2024 21:49:39 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20231221132400.1601991-41-dhowells@redhat.com>
References: <20231221132400.1601991-41-dhowells@redhat.com> <20231221132400.1601991-1-dhowells@redhat.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Latchesar Ionkov <lucho@ionkov.net>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Steve French <smfrench@gmail.com>,
    Matthew Wilcox <willy@infradead.org>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Ilya Dryomov <idryomov@gmail.com>,
    Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org,
    Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: [PATCH] 9p: Fix initialisation of netfs_inode for 9p
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <292836.1704232179.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Jan 2024 21:49:39 +0000
Message-ID: <292837.1704232179@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

This needs a fix that I would fold in.  Somehow it gets through xfstests
without it, but it seems problems can be caused with executables.

David
---
9p: Fix initialisation of netfs_inode for 9p

The 9p filesystem is calling netfs_inode_init() in v9fs_init_inode() -
before the struct inode fields have been initialised from the obtained fil=
e
stats (ie. after v9fs_stat2inode*() has been called), but netfslib wants t=
o
set a couple of its fields from i_size.

Reported-by: Marc Dionne <marc.dionne@auristor.com>
Signed-off-by: David Howells <dhowells@redhat.com>
Tested-by: Marc Dionne <marc.dionne@auristor.com>
cc: Eric Van Hensbergen <ericvh@kernel.org>
cc: Latchesar Ionkov <lucho@ionkov.net>
cc: Dominique Martinet <asmadeus@codewreck.org>
cc: Christian Schoenebeck <linux_oss@crudebyte.com>
cc: v9fs@lists.linux.dev
cc: linux-cachefs@redhat.com
cc: linux-fsdevel@vger.kernel.org
---
 fs/9p/v9fs_vfs.h       |    1 +
 fs/9p/vfs_inode.c      |    6 +++---
 fs/9p/vfs_inode_dotl.c |    1 +
 3 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/fs/9p/v9fs_vfs.h b/fs/9p/v9fs_vfs.h
index 731e3d14b67d..0e8418066a48 100644
--- a/fs/9p/v9fs_vfs.h
+++ b/fs/9p/v9fs_vfs.h
@@ -42,6 +42,7 @@ struct inode *v9fs_alloc_inode(struct super_block *sb);
 void v9fs_free_inode(struct inode *inode);
 struct inode *v9fs_get_inode(struct super_block *sb, umode_t mode,
 			     dev_t rdev);
+void v9fs_set_netfs_context(struct inode *inode);
 int v9fs_init_inode(struct v9fs_session_info *v9ses,
 		    struct inode *inode, umode_t mode, dev_t rdev);
 void v9fs_evict_inode(struct inode *inode);
diff --git a/fs/9p/vfs_inode.c b/fs/9p/vfs_inode.c
index b66466e97459..32572982f72e 100644
--- a/fs/9p/vfs_inode.c
+++ b/fs/9p/vfs_inode.c
@@ -246,7 +246,7 @@ void v9fs_free_inode(struct inode *inode)
 /*
  * Set parameters for the netfs library
  */
-static void v9fs_set_netfs_context(struct inode *inode)
+void v9fs_set_netfs_context(struct inode *inode)
 {
 	struct v9fs_inode *v9inode =3D V9FS_I(inode);
 	netfs_inode_init(&v9inode->netfs, &v9fs_req_ops, true);
@@ -326,8 +326,6 @@ int v9fs_init_inode(struct v9fs_session_info *v9ses,
 		err =3D -EINVAL;
 		goto error;
 	}
-
-	v9fs_set_netfs_context(inode);
 error:
 	return err;
 =

@@ -359,6 +357,7 @@ struct inode *v9fs_get_inode(struct super_block *sb, u=
mode_t mode, dev_t rdev)
 		iput(inode);
 		return ERR_PTR(err);
 	}
+	v9fs_set_netfs_context(inode);
 	return inode;
 }
 =

@@ -461,6 +460,7 @@ static struct inode *v9fs_qid_iget(struct super_block =
*sb,
 		goto error;
 =

 	v9fs_stat2inode(st, inode, sb, 0);
+	v9fs_set_netfs_context(inode);
 	v9fs_cache_inode_get_cookie(inode);
 	unlock_new_inode(inode);
 	return inode;
diff --git a/fs/9p/vfs_inode_dotl.c b/fs/9p/vfs_inode_dotl.c
index e25fbc988f09..3505227e1704 100644
--- a/fs/9p/vfs_inode_dotl.c
+++ b/fs/9p/vfs_inode_dotl.c
@@ -128,6 +128,7 @@ static struct inode *v9fs_qid_iget_dotl(struct super_b=
lock *sb,
 		goto error;
 =

 	v9fs_stat2inode_dotl(st, inode, 0);
+	v9fs_set_netfs_context(inode);
 	v9fs_cache_inode_get_cookie(inode);
 	retval =3D v9fs_get_acl(inode, fid);
 	if (retval)


