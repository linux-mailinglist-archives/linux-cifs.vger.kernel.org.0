Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C97461965
	for <lists+linux-cifs@lfdr.de>; Mon, 29 Nov 2021 15:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345741AbhK2Oiq (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 29 Nov 2021 09:38:46 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:38091 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1378415AbhK2Ogb (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 29 Nov 2021 09:36:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638196393;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sSZtHujAOjSy1CVl9YCXdkOUvFkUIIJXCBOfjA+8J1Q=;
        b=Qqwaxx5z1DM7votMka0S1w6qhLm/cU65mA5D5ghEVH9p1qwBF6sKzSMtRI92olgXkguxHA
        FhWe2+Jh3gpqeGZ6jGzAUFKP6KvKB9aOEcvob7qwtqdcJcxVzcGSfcskDHvRv58HNo4TzG
        Qys6dvB7JDE2hTDtkvhYWRfWdsOjEp4=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-591-VFVwnmXXPPeBxokMoi4k4w-1; Mon, 29 Nov 2021 09:33:11 -0500
X-MC-Unique: VFVwnmXXPPeBxokMoi4k4w-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 765B284B9A3;
        Mon, 29 Nov 2021 14:33:09 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 210C260854;
        Mon, 29 Nov 2021 14:33:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
Subject: [PATCH 42/64] cachefiles: Add tracepoints for calls to the VFS
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
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 29 Nov 2021 14:33:05 +0000
Message-ID: <163819638517.215744.12773133137536579766.stgit@warthog.procyon.org.uk>
In-Reply-To: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
References: <163819575444.215744.318477214576928110.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.23
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Add tracepoints in cachefiles to monitor when it does various VFS
operations, such as mkdir.

Signed-off-by: David Howells <dhowells@redhat.com>
cc: linux-cachefs@redhat.com
---

 include/trace/events/cachefiles.h |  176 +++++++++++++++++++++++++++++++++++++
 1 file changed, 176 insertions(+)

diff --git a/include/trace/events/cachefiles.h b/include/trace/events/cachefiles.h
index 29fdcfddbbc2..b548dbaf85bb 100644
--- a/include/trace/events/cachefiles.h
+++ b/include/trace/events/cachefiles.h
@@ -18,6 +18,21 @@
 #ifndef __CACHEFILES_DECLARE_TRACE_ENUMS_ONCE_ONLY
 #define __CACHEFILES_DECLARE_TRACE_ENUMS_ONCE_ONLY
 
+enum fscache_why_object_killed {
+	FSCACHE_OBJECT_IS_STALE,
+	FSCACHE_OBJECT_IS_WEIRD,
+	FSCACHE_OBJECT_INVALIDATED,
+	FSCACHE_OBJECT_NO_SPACE,
+	FSCACHE_OBJECT_WAS_RETIRED,
+	FSCACHE_OBJECT_WAS_CULLED,
+};
+
+enum cachefiles_trunc_trace {
+	cachefiles_trunc_dio_adjust,
+	cachefiles_trunc_expand_tmpfile,
+	cachefiles_trunc_shrink,
+};
+
 enum cachefiles_error_trace {
 	cachefiles_trace_fallocate_error,
 	cachefiles_trace_getxattr_error,
@@ -43,6 +58,19 @@ enum cachefiles_error_trace {
 /*
  * Define enum -> string mappings for display.
  */
+#define cachefiles_obj_kill_traces				\
+	EM(FSCACHE_OBJECT_IS_STALE,	"stale")		\
+	EM(FSCACHE_OBJECT_IS_WEIRD,	"weird")		\
+	EM(FSCACHE_OBJECT_INVALIDATED,	"inval")		\
+	EM(FSCACHE_OBJECT_NO_SPACE,	"no_space")		\
+	EM(FSCACHE_OBJECT_WAS_RETIRED,	"was_retired")		\
+	E_(FSCACHE_OBJECT_WAS_CULLED,	"was_culled")
+
+#define cachefiles_trunc_traces						\
+	EM(cachefiles_trunc_dio_adjust,		"DIOADJ")		\
+	EM(cachefiles_trunc_expand_tmpfile,	"EXPTMP")		\
+	E_(cachefiles_trunc_shrink,		"SHRINK")
+
 #define cachefiles_error_traces						\
 	EM(cachefiles_trace_fallocate_error,	"fallocate")		\
 	EM(cachefiles_trace_getxattr_error,	"getxattr")		\
@@ -71,6 +99,8 @@ enum cachefiles_error_trace {
 #define EM(a, b) TRACE_DEFINE_ENUM(a);
 #define E_(a, b) TRACE_DEFINE_ENUM(a);
 
+cachefiles_obj_kill_traces;
+cachefiles_trunc_traces;
 cachefiles_error_traces;
 
 /*
@@ -83,6 +113,152 @@ cachefiles_error_traces;
 #define E_(a, b)	{ a, b }
 
 
+TRACE_EVENT(cachefiles_lookup,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct dentry *de),
+
+	    TP_ARGS(obj, de),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj	)
+		    __field(short,			error	)
+		    __field(unsigned long,		ino	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->debug_id;
+		    __entry->ino	= (!IS_ERR(de) && d_backing_inode(de) ?
+					   d_backing_inode(de)->i_ino : 0);
+		    __entry->error	= IS_ERR(de) ? PTR_ERR(de) : 0;
+			   ),
+
+	    TP_printk("o=%08x i=%lx e=%d",
+		      __entry->obj, __entry->ino, __entry->error)
+	    );
+
+TRACE_EVENT(cachefiles_tmpfile,
+	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer),
+
+	    TP_ARGS(obj, backer),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->debug_id;
+		    __entry->backer	= backer->i_ino;
+			   ),
+
+	    TP_printk("o=%08x b=%08x",
+		      __entry->obj,
+		      __entry->backer)
+	    );
+
+TRACE_EVENT(cachefiles_link,
+	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer),
+
+	    TP_ARGS(obj, backer),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->debug_id;
+		    __entry->backer	= backer->i_ino;
+			   ),
+
+	    TP_printk("o=%08x b=%08x",
+		      __entry->obj,
+		      __entry->backer)
+	    );
+
+TRACE_EVENT(cachefiles_unlink,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct dentry *de,
+		     enum fscache_why_object_killed why),
+
+	    TP_ARGS(obj, de, why),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj		)
+		    __field(struct dentry *,		de		)
+		    __field(enum fscache_why_object_killed, why		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj ? obj->debug_id : UINT_MAX;
+		    __entry->de		= de;
+		    __entry->why	= why;
+			   ),
+
+	    TP_printk("o=%08x d=%p w=%s",
+		      __entry->obj, __entry->de,
+		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
+	    );
+
+TRACE_EVENT(cachefiles_rename,
+	    TP_PROTO(struct cachefiles_object *obj,
+		     struct dentry *de,
+		     struct dentry *to,
+		     enum fscache_why_object_killed why),
+
+	    TP_ARGS(obj, de, to, why),
+
+	    /* Note that obj may be NULL */
+	    TP_STRUCT__entry(
+		    __field(unsigned int,		obj		)
+		    __field(struct dentry *,		de		)
+		    __field(struct dentry *,		to		)
+		    __field(enum fscache_why_object_killed, why		)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj ? obj->debug_id : UINT_MAX;
+		    __entry->de		= de;
+		    __entry->to		= to;
+		    __entry->why	= why;
+			   ),
+
+	    TP_printk("o=%08x d=%p t=%p w=%s",
+		      __entry->obj, __entry->de, __entry->to,
+		      __print_symbolic(__entry->why, cachefiles_obj_kill_traces))
+	    );
+
+TRACE_EVENT(cachefiles_trunc,
+	    TP_PROTO(struct cachefiles_object *obj, struct inode *backer,
+		     loff_t from, loff_t to, enum cachefiles_trunc_trace why),
+
+	    TP_ARGS(obj, backer, from, to, why),
+
+	    TP_STRUCT__entry(
+		    __field(unsigned int,			obj	)
+		    __field(unsigned int,			backer	)
+		    __field(enum cachefiles_trunc_trace,	why	)
+		    __field(loff_t,				from	)
+		    __field(loff_t,				to	)
+			     ),
+
+	    TP_fast_assign(
+		    __entry->obj	= obj->debug_id;
+		    __entry->backer	= backer->i_ino;
+		    __entry->from	= from;
+		    __entry->to		= to;
+		    __entry->why	= why;
+			   ),
+
+	    TP_printk("o=%08x b=%08x %s l=%llx->%llx",
+		      __entry->obj,
+		      __entry->backer,
+		      __print_symbolic(__entry->why, cachefiles_trunc_traces),
+		      __entry->from,
+		      __entry->to)
+	    );
+
 TRACE_EVENT(cachefiles_mark_active,
 	    TP_PROTO(struct cachefiles_object *obj,
 		     struct inode *inode),


