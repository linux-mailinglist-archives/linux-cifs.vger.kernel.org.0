Return-Path: <linux-cifs+bounces-160-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 92B197F859D
	for <lists+linux-cifs@lfdr.de>; Fri, 24 Nov 2023 22:51:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 117D1B21126
	for <lists+linux-cifs@lfdr.de>; Fri, 24 Nov 2023 21:51:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4596E3C092;
	Fri, 24 Nov 2023 21:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aE2Ckw8h"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 056CD198D
	for <linux-cifs@vger.kernel.org>; Fri, 24 Nov 2023 13:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1700862684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
	bh=Hgj8B8xMgHNPRV+C3WI4kW0phmnLrWnRPCMxmjhfjYA=;
	b=aE2Ckw8h0lbdfMX5gth4oIgYRii5bp9Gtyqs73SKf22xMeIUyouYfqElqzcTZ5RPKfkpw4
	uzmPaC2SMa5Hv+liBnSFw1J2y2iiPijrZHmY5l1wOLru6CeiQ5TH1xpPyPBWOKKLZS41ai
	eXsTYlN4sDffGlTtRQX5Qy6HWzO2xfo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-372-NQ-g0QsfPie5Dl7zSx4g0A-1; Fri, 24 Nov 2023 16:51:19 -0500
X-MC-Unique: NQ-g0QsfPie5Dl7zSx4g0A-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 96E91812C28;
	Fri, 24 Nov 2023 21:51:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 939085028;
	Fri, 24 Nov 2023 21:51:17 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
To: Steve French <sfrench@samba.org>
cc: dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>,
    Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Set the file size after doing copychunk_range
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1297338.1700862676.1@warthog.procyon.org.uk>
Date: Fri, 24 Nov 2023 21:51:16 +0000
Message-ID: <1297339.1700862676@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5

    
Set i_size on the inode after doing the copychunk_range operation as this
value may be used by various things internally.  stat() hides the issue
because setting ->time to 0 causes cifs_getatr() to revalidate the
attributes.

Also reduce the pagecache truncation to only invalidate the range of bytes
that will be copied over otherwise we will discard dirty data that isn't
inside the target range.

Fixes: 620d8745b35d ("Introduce cifs_copy_file_range()")
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Shyam Prasad N <nspmangalore@gmail.com>
cc: Rohith Surabattula <rohiths.msft@gmail.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
---
 fs/smb/client/cifsfs.c |    7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index ea3a7a668b45..5a69e93c302e 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1307,12 +1307,15 @@ ssize_t cifs_file_copychunk_range(unsigned int xid,
 		goto unlock;
 
 	/* should we flush first and last page first */
-	truncate_inode_pages(&target_inode->i_data, 0);
+	truncate_inode_pages_range(&target_inode->i_data, destoff, len);
 
 	rc = file_modified(dst_file);
-	if (!rc)
+	if (!rc) {
 		rc = target_tcon->ses->server->ops->copychunk_range(xid,
 			smb_file_src, smb_file_target, off, len, destoff);
+		if (rc > 0 && destoff + rc > i_size_read(target_inode))
+			truncate_setsize(target_inode, destoff + rc);
+	}
 
 	file_accessed(src_file);
 


