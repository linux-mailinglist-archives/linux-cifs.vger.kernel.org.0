Return-Path: <linux-cifs+bounces-3177-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227689AE816
	for <lists+linux-cifs@lfdr.de>; Thu, 24 Oct 2024 16:18:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD1E31F21090
	for <lists+linux-cifs@lfdr.de>; Thu, 24 Oct 2024 14:18:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB8220A5F6;
	Thu, 24 Oct 2024 14:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ITmoC2jY"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E21F209F49
	for <linux-cifs@vger.kernel.org>; Thu, 24 Oct 2024 14:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729778928; cv=none; b=SVi9blCEIBBiUIfhTMKLlt2xrpPNS4cPvnktTnvxK1rBiw/n8GWvnIu5sJVhNWimhmLHz9nKwtscoedAZM13U1gB+QEbqstiJQ7/nS25rHGq3a2muNBeQNAGdXJ6yZJhZByaOI+b20Jt5R97w1PNGHCiX2dUBQUxUufR985LxHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729778928; c=relaxed/simple;
	bh=raCpdqcu2ygldk7gd5VDDvJXWwDH1Uhs8ai3Ef9spQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rb3aGG+iJ9XHDyDMG+vYgqVsYIUXw4zKr9iMLCIebSJaanwzL9l8dSQAXpxjhSuBaaP9pts/pzi8o4aRFCAegIFKqkxmNyZPrJfSJPFWXd8WDGrSebpUDeeMgETZX9sdR12ds9BCyTk+WSQrTOtP7CREeunHapcQkCS/0X1AAj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ITmoC2jY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1729778925;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u3/1sOVuQqHpfo8UyVSOFEz4LX0EnJcfMGVnlE5mJ3g=;
	b=ITmoC2jYcPJheRwmU6NlzBlkjB7AZxHna1oCKcSTGjMQkb81V0AZyaWe4PcvpLAdrRHlRB
	shXL949S8xQ8gR+SbODiNuIqEt3pGkenVuUfDwvnL00cA/Py8+qtKj9+ch5D9WaCu8wGR8
	UXX+xIaCP1sBpuUHgM2BbD74LnzFiEs=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-400-s2xcwJiqNh2AsSay-NhpDA-1; Thu,
 24 Oct 2024 10:08:35 -0400
X-MC-Unique: s2xcwJiqNh2AsSay-NhpDA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 768DE1955BC7;
	Thu, 24 Oct 2024 14:08:32 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.231])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id E2EBB1955F43;
	Thu, 24 Oct 2024 14:08:26 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <smfrench@gmail.com>,
	Matthew Wilcox <willy@infradead.org>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Gao Xiang <hsiangkao@linux.alibaba.com>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Ilya Dryomov <idryomov@gmail.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 21/27] afs: Make afs_init_request() get a key if not given a file
Date: Thu, 24 Oct 2024 15:05:19 +0100
Message-ID: <20241024140539.3828093-22-dhowells@redhat.com>
In-Reply-To: <20241024140539.3828093-1-dhowells@redhat.com>
References: <20241024140539.3828093-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

In a future patch, AFS directory caching will go through netfslib and this
will involve, at times, running on behalf of ->lookup(), which doesn't
provide us with a file from which we can get an authentication key.

If a file isn't provided, make afs_init_request() get a key from the
process's keyrings instead when setting up a read.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: Marc Dionne <marc.dionne@auristor.com>
cc: linux-afs@lists.infradead.org
---
 fs/afs/file.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/fs/afs/file.c b/fs/afs/file.c
index f717168da4ab..a9d98d18407c 100644
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@ -372,10 +372,26 @@ static int afs_symlink_read_folio(struct file *file, struct folio *folio)
 
 static int afs_init_request(struct netfs_io_request *rreq, struct file *file)
 {
+	struct afs_vnode *vnode = AFS_FS_I(rreq->inode);
+
 	if (file)
 		rreq->netfs_priv = key_get(afs_file_key(file));
 	rreq->rsize = 256 * 1024;
 	rreq->wsize = 256 * 1024 * 1024;
+
+	switch (rreq->origin) {
+	case NETFS_READ_SINGLE:
+		if (!file) {
+			struct key *key = afs_request_key(vnode->volume->cell);
+
+			if (IS_ERR(key))
+				return PTR_ERR(key);
+			rreq->netfs_priv = key;
+		}
+		break;
+	default:
+		break;
+	}
 	return 0;
 }
 


