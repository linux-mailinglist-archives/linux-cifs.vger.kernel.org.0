Return-Path: <linux-cifs+bounces-4351-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 154C5A77EA6
	for <lists+linux-cifs@lfdr.de>; Tue,  1 Apr 2025 17:13:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 51F81188B315
	for <lists+linux-cifs@lfdr.de>; Tue,  1 Apr 2025 15:13:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A910820767E;
	Tue,  1 Apr 2025 15:12:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bTpGqXYU"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD2552080C4
	for <linux-cifs@vger.kernel.org>; Tue,  1 Apr 2025 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743520367; cv=none; b=WDCKe6KDclzFptfs0b/n+u24fSq4q8/K1pWlsITIvl406JvM4XxUipcjK3+6qx+iQ0JoiMSBhr1OhgrdQwFLuyRnfk5rU9NA7za0NoMG0S9pB96DVMUm2Yx4JAeQQoRfCf9VgnFe1GMIeequqKwe8wcxaKwKDSIRc2bjIgF4+Fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743520367; c=relaxed/simple;
	bh=7eZRKXLD9h6rbe+HRh0fJZd7FslC7GDW6CZtEZmHv7c=;
	h=From:To:cc:Subject:MIME-Version:Content-Type:Date:Message-ID; b=WdhgUodOaU2pBxacF4hXW0nGTLlg4hl4wDQnTTs1EvbbblORt508tpPb0+2xFZGh6d9fsgh/MQDHxh+DNzsgLthZD6naU0xO8FIvwYp6ehK/2Zgm8kdOyZSevKz7CgyeMd10S+HOmu/ANFg6COhHjfOHWZ946+jMYm7wFcv2aUU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=bTpGqXYU; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743520364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=KIkzBrgK5G8zz9AJXZ59Q/n7j2KsS+0m8sqEKJiwDKw=;
	b=bTpGqXYUS/+WHVz/ryLrk667rrKq8IBpB4D09KZOVGHQjjGMXpZ5ersUBsqx0uQ4mFbYps
	KplmJs255QEbS9WDdAGt4BhgNyXJvKqa6Z4s7Eo7onkwoC47KtMbApnBvNxV0aID3H40qU
	3C1xSImHMO5T2arvYt3Imv+rIKt1eDI=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-HC60djJEO3iWe2mzPccZJg-1; Tue,
 01 Apr 2025 11:01:09 -0400
X-MC-Unique: HC60djJEO3iWe2mzPccZJg-1
X-Mimecast-MFC-AGG-ID: HC60djJEO3iWe2mzPccZJg_1743519666
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C78351954B36;
	Tue,  1 Apr 2025 15:01:05 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.40])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 897631828AAD;
	Tue,  1 Apr 2025 15:01:03 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <stfrench@microsoft.com>
cc: dhowells@redhat.com, Paulo Alcantara <pc@manguebit.com>,
    Matthew Wilcox <willy@infradead.org>, linux-cifs@vger.kernel.org,
    netfs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Remove cifs_truncate_page() as it should be superfluous
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <559572.1743519662.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Apr 2025 16:01:02 +0100
Message-ID: <559573.1743519662@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93

The calls to cifs_truncate_page() should be superfluous as the places that
call it also call truncate_setsize() or cifs_setsize() and therefore
truncate_pagecache() which should also clear the tail part of the folio
containing the EOF marker.

Further, smb3_simple_falloc() calls both cifs_setsize() and
truncate_setsize() in addition to cifs_truncate_page().

Remove the superfluous calls.

This gets rid of another function referring to struct page.

[Should cifs_setsize() also set inode->i_blocks?]

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <stfrench@microsoft.com>
cc: Paulo Alcantara (Red Hat) <pc@manguebit.com>
cc: Matthew Wilcox <willy@infradead.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 fs/smb/client/cifsfs.h  |    1 -
 fs/smb/client/inode.c   |   19 -------------------
 fs/smb/client/smb2ops.c |    2 --
 3 files changed, 22 deletions(-)

diff --git a/fs/smb/client/cifsfs.h b/fs/smb/client/cifsfs.h
index 8dea0cf3a8de..a769fa7ceece 100644
--- a/fs/smb/client/cifsfs.h
+++ b/fs/smb/client/cifsfs.h
@@ -135,7 +135,6 @@ extern ssize_t cifs_file_copychunk_range(unsigned int =
xid,
 =

 extern long cifs_ioctl(struct file *filep, unsigned int cmd, unsigned lon=
g arg);
 extern void cifs_setsize(struct inode *inode, loff_t offset);
-extern int cifs_truncate_page(struct address_space *mapping, loff_t from)=
;
 =

 struct smb3_fs_context;
 extern struct dentry *cifs_smb3_do_mount(struct file_system_type *fs_type=
,
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 3bb21aa58474..a00a9d91d0da 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -2901,23 +2901,6 @@ int cifs_fiemap(struct inode *inode, struct fiemap_=
extent_info *fei, u64 start,
 	return -EOPNOTSUPP;
 }
 =

-int cifs_truncate_page(struct address_space *mapping, loff_t from)
-{
-	pgoff_t index =3D from >> PAGE_SHIFT;
-	unsigned offset =3D from & (PAGE_SIZE - 1);
-	struct page *page;
-	int rc =3D 0;
-
-	page =3D grab_cache_page(mapping, index);
-	if (!page)
-		return -ENOMEM;
-
-	zero_user_segment(page, offset, PAGE_SIZE);
-	unlock_page(page);
-	put_page(page);
-	return rc;
-}
-
 void cifs_setsize(struct inode *inode, loff_t offset)
 {
 	struct cifsInodeInfo *cifs_i =3D CIFS_I(inode);
@@ -3012,8 +2995,6 @@ cifs_set_file_size(struct inode *inode, struct iattr=
 *attrs,
 		 */
 		attrs->ia_ctime =3D attrs->ia_mtime =3D current_time(inode);
 		attrs->ia_valid |=3D ATTR_CTIME | ATTR_MTIME;
-
-		cifs_truncate_page(inode->i_mapping, inode->i_size);
 	}
 =

 	return rc;
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 4dd11eafb69d..13d060e0fc33 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3526,8 +3526,6 @@ static long smb3_simple_falloc(struct file *file, st=
ruct cifs_tcon *tcon,
 		if (rc =3D=3D 0) {
 			netfs_resize_file(&cifsi->netfs, new_eof, true);
 			cifs_setsize(inode, new_eof);
-			cifs_truncate_page(inode->i_mapping, inode->i_size);
-			truncate_setsize(inode, new_eof);
 		}
 		goto out;
 	}


