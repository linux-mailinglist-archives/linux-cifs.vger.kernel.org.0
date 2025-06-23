Return-Path: <linux-cifs+bounces-5110-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 710BDAE411D
	for <lists+linux-cifs@lfdr.de>; Mon, 23 Jun 2025 14:52:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671A1189243E
	for <lists+linux-cifs@lfdr.de>; Mon, 23 Jun 2025 12:51:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CB63253B52;
	Mon, 23 Jun 2025 12:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ke/j4Kx8"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31BAA25486D
	for <linux-cifs@vger.kernel.org>; Mon, 23 Jun 2025 12:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750682963; cv=none; b=d3+QBxSEzn3g221e/16GOfn52gtuMUZjfyuGYJPGi2437CUafBda9mBXIz3f58SgRJRN9LpbTqjw4H2S1gC9+SOOw+s3rIgkui/M7sQcfBgrkjjOZJOMyo4nnZEwG7JH45/5FNv0PpQzVRuqzTKmIMMlRwi9zNXm7YBrY+QM2Lw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750682963; c=relaxed/simple;
	bh=fXJnGtulWCs/hIQRDtG5n7Esj+zDQg00tFsx8mHo/FQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=F4tE8RpkDaHLAuZjJk+BeFnYuZhWqmeEEYMXGCt2NxgjIAAtjo/qsgZjL9cIKCadbnPwkG6DXW7ZePkf68K+fO1u0d05ht1fjpSSEerrFJWKv1QdHIK5fJcq4D0zEOFOX9R0fV/pZoFg14XqwjAkUsa97CxwAYDNuMs2oSQTTzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Ke/j4Kx8; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750682960;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZGQUYwvD0lem1uL48o0gXjnpe8HRdUSOhfZ6hwrYH+s=;
	b=Ke/j4Kx8CEHYlT+vToZ6rF4ue6QsGr8sFb/iG/bhdFmTvff/oA9QiCDvcLTUwMX3hAN8xE
	NOafFSE/3QYgzHlUo/SLdzfhWDxYSl1QZ1elhbth7B1CY0dXMMRR5VmLOPJbXWTphHz4Kq
	xmhG42atR5jKTBoseyliOp+1XKikBcQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-633-g5pK0NWMMGSbnLOXAMle-A-1; Mon,
 23 Jun 2025 08:49:17 -0400
X-MC-Unique: g5pK0NWMMGSbnLOXAMle-A-1
X-Mimecast-MFC-AGG-ID: g5pK0NWMMGSbnLOXAMle-A_1750682955
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 16271195608F;
	Mon, 23 Jun 2025 12:49:15 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.81])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 710C2195608D;
	Mon, 23 Jun 2025 12:49:11 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Paulo Alcantara <pc@manguebit.com>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.org>
Subject: [PATCH 06/11] cifs: Fix prepare_write to negotiate wsize if needed
Date: Mon, 23 Jun 2025 13:48:26 +0100
Message-ID: <20250623124835.1106414-7-dhowells@redhat.com>
In-Reply-To: <20250623124835.1106414-1-dhowells@redhat.com>
References: <20250623124835.1106414-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17

Fix cifs_prepare_write() to negotiate the wsize if it is unset.

Fixes: 69c3c023af25 ("cifs: Implement netfslib hooks")
Signed-off-by: David Howells <dhowells@redhat.com>
Reviewed-by: Paulo Alcantara <pc@manguebit.org>
cc: Steve French <sfrench@samba.org>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
cc: linux-cifs@vger.kernel.org
---
 fs/smb/client/file.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 9835672267d2..e9212da32f01 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -52,6 +52,7 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 	struct netfs_io_stream *stream = &req->rreq.io_streams[subreq->stream_nr];
 	struct TCP_Server_Info *server;
 	struct cifsFileInfo *open_file = req->cfile;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(wdata->rreq->inode->i_sb);
 	size_t wsize = req->rreq.wsize;
 	int rc;
 
@@ -63,6 +64,10 @@ static void cifs_prepare_write(struct netfs_io_subrequest *subreq)
 	server = cifs_pick_channel(tlink_tcon(open_file->tlink)->ses);
 	wdata->server = server;
 
+	if (cifs_sb->ctx->wsize == 0)
+		cifs_negotiate_wsize(server, cifs_sb->ctx,
+				     tlink_tcon(req->cfile->tlink));
+
 retry:
 	if (open_file->invalidHandle) {
 		rc = cifs_reopen_file(open_file, false);
@@ -160,10 +165,9 @@ static int cifs_prepare_read(struct netfs_io_subrequest *subreq)
 	server = cifs_pick_channel(tlink_tcon(req->cfile->tlink)->ses);
 	rdata->server = server;
 
-	if (cifs_sb->ctx->rsize == 0) {
+	if (cifs_sb->ctx->rsize == 0)
 		cifs_negotiate_rsize(server, cifs_sb->ctx,
 				     tlink_tcon(req->cfile->tlink));
-	}
 
 	rc = server->ops->wait_mtu_credits(server, cifs_sb->ctx->rsize,
 					   &size, &rdata->credits);


