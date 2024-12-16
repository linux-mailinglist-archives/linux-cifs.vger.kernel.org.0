Return-Path: <linux-cifs+bounces-3647-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 251949F3B2F
	for <lists+linux-cifs@lfdr.de>; Mon, 16 Dec 2024 21:43:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 356FD16E49D
	for <lists+linux-cifs@lfdr.de>; Mon, 16 Dec 2024 20:43:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 611D61D6DDD;
	Mon, 16 Dec 2024 20:42:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gxkeFM0U"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8800C1D7992
	for <linux-cifs@vger.kernel.org>; Mon, 16 Dec 2024 20:42:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734381722; cv=none; b=gmxaRYQBYTt1XDW9l7bhbIVHJvsPpnltPz/w5V9/79cnY/dcAh67Z9/3ABSiZC3/bghqZcb+PNWOkYqTIrFf4nkvXCSjGr0w6o02SjZOkD56DqXclL6R0GfaOeWKxLHG9sevsaqsUSKzF2wgMl6589I3nwVdvLH4E5MPydj3Ih4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734381722; c=relaxed/simple;
	bh=MJ2Vn5+2w/awQ8QXC51y0AmV16GfrAD0/WwNRye3l4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C7qwVV2WmHJhDOahkMNQD6QdxdbJ67Fybh3MqYUFZbUEE/SGF1OSwfycdnm9K4J1Gf8ayCXgzz1X2b0wJwoPPzYxUrRE/88bnuwqgu1Zc8rg00ckYs85RRXZAJ9pIjf9I8fuaVl1lOAgjnYavr5sLd6W4dg+8FTtC/7QyhuQ5jM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gxkeFM0U; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734381719;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ImLLuUlnuS58zU73BDFFYc3DK9zcBLY9IdUFoq8DTcw=;
	b=gxkeFM0UzrHdXZbQru2dPtWcxhdn/dEVG1271qlqP6FmfgOkdynzR2Ya1G1PKEhfK6M0e5
	Vi6b0XDyouKP8TcP6FhBabj+hqbGIfkaeWCSYshfKssL2oDSuRRuPVZYhr9BddheIaufHh
	BRzLsYaQx6zrhAnqWkr+W/1wKA9Atpg=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-627-UvuEeORjP-aiztK1V-7R9Q-1; Mon,
 16 Dec 2024 15:41:54 -0500
X-MC-Unique: UvuEeORjP-aiztK1V-7R9Q-1
X-Mimecast-MFC-AGG-ID: UvuEeORjP-aiztK1V-7R9Q
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id B8D031955F4A;
	Mon, 16 Dec 2024 20:41:50 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.48])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 050E219560AD;
	Mon, 16 Dec 2024 20:41:44 +0000 (UTC)
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
Subject: [PATCH v5 02/32] cachefiles: Clean up some whitespace in trace header
Date: Mon, 16 Dec 2024 20:40:52 +0000
Message-ID: <20241216204124.3752367-3-dhowells@redhat.com>
In-Reply-To: <20241216204124.3752367-1-dhowells@redhat.com>
References: <20241216204124.3752367-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Clean up some whitespace in the cachefiles trace header.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
---
 include/trace/events/cachefiles.h | 172 +++++++++++++++---------------
 1 file changed, 86 insertions(+), 86 deletions(-)

diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 7d931db02b93..74114c261bcd 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -223,10 +223,10 @@ TRACE_EVENT(cachefiles_ref,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj		)
-		    __field(unsigned int,			cookie		)
-		    __field(enum cachefiles_obj_ref_trace,	why		)
-		    __field(int,				usage		)
+		    __field(unsigned int,			obj)
+		    __field(unsigned int,			cookie)
+		    __field(enum cachefiles_obj_ref_trace,	why)
+		    __field(int,				usage)
 			     ),
 
 	    TP_fast_assign(
@@ -249,10 +249,10 @@ TRACE_EVENT(cachefiles_lookup,
 	    TP_ARGS(obj, dir, de),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj	)
-		    __field(short,			error	)
-		    __field(unsigned long,		dino	)
-		    __field(unsigned long,		ino	)
+		    __field(unsigned int,		obj)
+		    __field(short,			error)
+		    __field(unsigned long,		dino)
+		    __field(unsigned long,		ino)
 			     ),
 
 	    TP_fast_assign(
@@ -273,8 +273,8 @@ TRACE_EVENT(cachefiles_mkdir,
 	    TP_ARGS(dir, subdir),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			dir	)
-		    __field(unsigned int,			subdir	)
+		    __field(unsigned int,			dir)
+		    __field(unsigned int,			subdir)
 			     ),
 
 	    TP_fast_assign(
@@ -293,8 +293,8 @@ TRACE_EVENT(cachefiles_tmpfile,
 	    TP_ARGS(obj, backer),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj	)
-		    __field(unsigned int,			backer	)
+		    __field(unsigned int,			obj)
+		    __field(unsigned int,			backer)
 			     ),
 
 	    TP_fast_assign(
@@ -313,8 +313,8 @@ TRACE_EVENT(cachefiles_link,
 	    TP_ARGS(obj, backer),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj	)
-		    __field(unsigned int,			backer	)
+		    __field(unsigned int,			obj)
+		    __field(unsigned int,			backer)
 			     ),
 
 	    TP_fast_assign(
@@ -336,9 +336,9 @@ TRACE_EVENT(cachefiles_unlink,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(unsigned int,		ino		)
-		    __field(enum fscache_why_object_killed, why		)
+		    __field(unsigned int,		obj)
+		    __field(unsigned int,		ino)
+		    __field(enum fscache_why_object_killed, why)
 			     ),
 
 	    TP_fast_assign(
@@ -361,9 +361,9 @@ TRACE_EVENT(cachefiles_rename,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(unsigned int,		ino		)
-		    __field(enum fscache_why_object_killed, why		)
+		    __field(unsigned int,		obj)
+		    __field(unsigned int,		ino)
+		    __field(enum fscache_why_object_killed, why)
 			     ),
 
 	    TP_fast_assign(
@@ -387,10 +387,10 @@ TRACE_EVENT(cachefiles_coherency,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj	)
-		    __field(enum cachefiles_coherency_trace,	why	)
-		    __field(enum cachefiles_content,		content	)
-		    __field(u64,				ino	)
+		    __field(unsigned int,			obj)
+		    __field(enum cachefiles_coherency_trace,	why)
+		    __field(enum cachefiles_content,		content)
+		    __field(u64,				ino)
 			     ),
 
 	    TP_fast_assign(
@@ -416,9 +416,9 @@ TRACE_EVENT(cachefiles_vol_coherency,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			vol	)
-		    __field(enum cachefiles_coherency_trace,	why	)
-		    __field(u64,				ino	)
+		    __field(unsigned int,			vol)
+		    __field(enum cachefiles_coherency_trace,	why)
+		    __field(u64,				ino)
 			     ),
 
 	    TP_fast_assign(
@@ -445,14 +445,14 @@ TRACE_EVENT(cachefiles_prep_read,
 	    TP_ARGS(obj, start, len, flags, source, why, cache_inode, netfs_inode),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(unsigned short,		flags		)
-		    __field(enum netfs_io_source,	source		)
-		    __field(enum cachefiles_prepare_read_trace,	why	)
-		    __field(size_t,			len		)
-		    __field(loff_t,			start		)
-		    __field(unsigned int,		netfs_inode	)
-		    __field(unsigned int,		cache_inode	)
+		    __field(unsigned int,		obj)
+		    __field(unsigned short,		flags)
+		    __field(enum netfs_io_source,	source)
+		    __field(enum cachefiles_prepare_read_trace,	why)
+		    __field(size_t,			len)
+		    __field(loff_t,			start)
+		    __field(unsigned int,		netfs_inode)
+		    __field(unsigned int,		cache_inode)
 			     ),
 
 	    TP_fast_assign(
@@ -484,10 +484,10 @@ TRACE_EVENT(cachefiles_read,
 	    TP_ARGS(obj, backer, start, len),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj	)
-		    __field(unsigned int,			backer	)
-		    __field(size_t,				len	)
-		    __field(loff_t,				start	)
+		    __field(unsigned int,			obj)
+		    __field(unsigned int,			backer)
+		    __field(size_t,				len)
+		    __field(loff_t,				start)
 			     ),
 
 	    TP_fast_assign(
@@ -513,10 +513,10 @@ TRACE_EVENT(cachefiles_write,
 	    TP_ARGS(obj, backer, start, len),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj	)
-		    __field(unsigned int,			backer	)
-		    __field(size_t,				len	)
-		    __field(loff_t,				start	)
+		    __field(unsigned int,			obj)
+		    __field(unsigned int,			backer)
+		    __field(size_t,				len)
+		    __field(loff_t,				start)
 			     ),
 
 	    TP_fast_assign(
@@ -540,11 +540,11 @@ TRACE_EVENT(cachefiles_trunc,
 	    TP_ARGS(obj, backer, from, to, why),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj	)
-		    __field(unsigned int,			backer	)
-		    __field(enum cachefiles_trunc_trace,	why	)
-		    __field(loff_t,				from	)
-		    __field(loff_t,				to	)
+		    __field(unsigned int,			obj)
+		    __field(unsigned int,			backer)
+		    __field(enum cachefiles_trunc_trace,	why)
+		    __field(loff_t,				from)
+		    __field(loff_t,				to)
 			     ),
 
 	    TP_fast_assign(
@@ -571,8 +571,8 @@ TRACE_EVENT(cachefiles_mark_active,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(ino_t,			inode		)
+		    __field(unsigned int,		obj)
+		    __field(ino_t,			inode)
 			     ),
 
 	    TP_fast_assign(
@@ -592,8 +592,8 @@ TRACE_EVENT(cachefiles_mark_failed,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(ino_t,			inode		)
+		    __field(unsigned int,		obj)
+		    __field(ino_t,			inode)
 			     ),
 
 	    TP_fast_assign(
@@ -613,8 +613,8 @@ TRACE_EVENT(cachefiles_mark_inactive,
 
 	    /* Note that obj may be NULL */
 	    TP_STRUCT__entry(
-		    __field(unsigned int,		obj		)
-		    __field(ino_t,			inode		)
+		    __field(unsigned int,		obj)
+		    __field(ino_t,			inode)
 			     ),
 
 	    TP_fast_assign(
@@ -633,10 +633,10 @@ TRACE_EVENT(cachefiles_vfs_error,
 	    TP_ARGS(obj, backer, error, where),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj	)
-		    __field(unsigned int,			backer	)
-		    __field(enum cachefiles_error_trace,	where	)
-		    __field(short,				error	)
+		    __field(unsigned int,			obj)
+		    __field(unsigned int,			backer)
+		    __field(enum cachefiles_error_trace,	where)
+		    __field(short,				error)
 			     ),
 
 	    TP_fast_assign(
@@ -660,10 +660,10 @@ TRACE_EVENT(cachefiles_io_error,
 	    TP_ARGS(obj, backer, error, where),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,			obj	)
-		    __field(unsigned int,			backer	)
-		    __field(enum cachefiles_error_trace,	where	)
-		    __field(short,				error	)
+		    __field(unsigned int,			obj)
+		    __field(unsigned int,			backer)
+		    __field(enum cachefiles_error_trace,	where)
+		    __field(short,				error)
 			     ),
 
 	    TP_fast_assign(
@@ -687,11 +687,11 @@ TRACE_EVENT(cachefiles_ondemand_open,
 	    TP_ARGS(obj, msg, load),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	obj		)
-		    __field(unsigned int,	msg_id		)
-		    __field(unsigned int,	object_id	)
-		    __field(unsigned int,	fd		)
-		    __field(unsigned int,	flags		)
+		    __field(unsigned int,	obj)
+		    __field(unsigned int,	msg_id)
+		    __field(unsigned int,	object_id)
+		    __field(unsigned int,	fd)
+		    __field(unsigned int,	flags)
 			     ),
 
 	    TP_fast_assign(
@@ -717,9 +717,9 @@ TRACE_EVENT(cachefiles_ondemand_copen,
 	    TP_ARGS(obj, msg_id, len),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	obj	)
-		    __field(unsigned int,	msg_id	)
-		    __field(long,		len	)
+		    __field(unsigned int,	obj)
+		    __field(unsigned int,	msg_id)
+		    __field(long,		len)
 			     ),
 
 	    TP_fast_assign(
@@ -740,9 +740,9 @@ TRACE_EVENT(cachefiles_ondemand_close,
 	    TP_ARGS(obj, msg),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	obj		)
-		    __field(unsigned int,	msg_id		)
-		    __field(unsigned int,	object_id	)
+		    __field(unsigned int,	obj)
+		    __field(unsigned int,	msg_id)
+		    __field(unsigned int,	object_id)
 			     ),
 
 	    TP_fast_assign(
@@ -764,11 +764,11 @@ TRACE_EVENT(cachefiles_ondemand_read,
 	    TP_ARGS(obj, msg, load),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	obj		)
-		    __field(unsigned int,	msg_id		)
-		    __field(unsigned int,	object_id	)
-		    __field(loff_t,		start		)
-		    __field(size_t,		len		)
+		    __field(unsigned int,	obj)
+		    __field(unsigned int,	msg_id)
+		    __field(unsigned int,	object_id)
+		    __field(loff_t,		start)
+		    __field(size_t,		len)
 			     ),
 
 	    TP_fast_assign(
@@ -793,8 +793,8 @@ TRACE_EVENT(cachefiles_ondemand_cread,
 	    TP_ARGS(obj, msg_id),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	obj	)
-		    __field(unsigned int,	msg_id	)
+		    __field(unsigned int,	obj)
+		    __field(unsigned int,	msg_id)
 			     ),
 
 	    TP_fast_assign(
@@ -814,10 +814,10 @@ TRACE_EVENT(cachefiles_ondemand_fd_write,
 	    TP_ARGS(obj, backer, start, len),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	obj	)
-		    __field(unsigned int,	backer	)
-		    __field(loff_t,		start	)
-		    __field(size_t,		len	)
+		    __field(unsigned int,	obj)
+		    __field(unsigned int,	backer)
+		    __field(loff_t,		start)
+		    __field(size_t,		len)
 			     ),
 
 	    TP_fast_assign(
@@ -840,8 +840,8 @@ TRACE_EVENT(cachefiles_ondemand_fd_release,
 	    TP_ARGS(obj, object_id),
 
 	    TP_STRUCT__entry(
-		    __field(unsigned int,	obj		)
-		    __field(unsigned int,	object_id	)
+		    __field(unsigned int,	obj)
+		    __field(unsigned int,	object_id)
 			     ),
 
 	    TP_fast_assign(


