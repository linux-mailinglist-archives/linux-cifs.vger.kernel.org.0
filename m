Return-Path: <linux-cifs+bounces-2935-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2286F988BBB
	for <lists+linux-cifs@lfdr.de>; Fri, 27 Sep 2024 23:12:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CD7451F2294A
	for <lists+linux-cifs@lfdr.de>; Fri, 27 Sep 2024 21:12:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 238611C331C;
	Fri, 27 Sep 2024 21:12:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XuqmypFe"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91FB01C2457
	for <linux-cifs@vger.kernel.org>; Fri, 27 Sep 2024 21:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727471521; cv=none; b=Mi2Bfqs++sh4A6FZzpgOi+AF58HaMy7FHk2kjop1pMu/XJllrkrja3dajjfSzFCFQtvm84HFaHctAS8IEJPzxcew/ld+W6VBpoMSDL5PhaJdwhfKVaPBlFGO+ByKH4ZhZScH7Gw1fifRmRKGfEWcSIpmDaXMTqSVc3ONOS3OeKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727471521; c=relaxed/simple;
	bh=j3c5/Zh4p82GAk9vaXtDQNsggU/jIEjNscDXUpnSLwI=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=L0ZST16XxMDgTrDWoVryqRjl9XlrL3v+K+Dggwtxhnin6lc3vut07UzZEpGzBCND3TDw2FINGqd+CSkH8MzyYa94ZqKavDQWYq63NPgyeCxaBDR8MRo/bqgiv3STDRiBg+oGgvf3saOThN8cUoqGF2F/ohzhur4WBrQOlBXD4pw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XuqmypFe; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1727471518;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8uMxOBU2H6Hw+qD+HRMDEGiSShQKw6OKRseN26Hxg0M=;
	b=XuqmypFeyWnx3Au6sc4zL9bxScex/5ER/n/N6lHeYc8xEVmUv2JUi0JvljG+6vTFY2B+m2
	law68XIWS4FMoQYLdBpO216YM1ewUotr7IqvJIBw0xrN3KOCqhP9XPszOcIULzh1gtOrxZ
	dQsXelVTnQWYzV5h9qCwddJTH8TO0jk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-528-nkGTJbKIOsK6M6_0H6aoDw-1; Fri,
 27 Sep 2024 17:11:52 -0400
X-MC-Unique: nkGTJbKIOsK6M6_0H6aoDw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (unknown [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 8F2381936B95;
	Fri, 27 Sep 2024 21:11:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.145])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BC3D43003DF2;
	Fri, 27 Sep 2024 21:11:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <55cef4bef5a14a70b97e104c4ddd8ef64430f168.camel@gmail.com>
References: <55cef4bef5a14a70b97e104c4ddd8ef64430f168.camel@gmail.com> <20240923183432.1876750-1-chantr4@gmail.com> <20240814203850.2240469-20-dhowells@redhat.com> <2663729.1727470216@warthog.procyon.org.uk>
To: Eduard Zingerman <eddyz87@gmail.com>
Cc: dhowells@redhat.com, Manu Bretelle <chantr4@gmail.com>,
    asmadeus@codewreck.org, ceph-devel@vger.kernel.org,
    christian@brauner.io, ericvh@kernel.org, hsiangkao@linux.alibaba.com,
    idryomov@gmail.com, jlayton@kernel.org,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org, linux-mm@kvack.org,
    linux-nfs@vger.kernel.org, marc.dionne@auristor.com,
    netdev@vger.kernel.org, netfs@lists.linux.dev, pc@manguebit.com,
    smfrench@gmail.com, sprasad@microsoft.com, tom@talpey.com,
    v9fs@lists.linux.dev, willy@infradead.org
Subject: Re: [PATCH v2 19/25] netfs: Speed up buffered reading
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2668611.1727471502.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Fri, 27 Sep 2024 22:11:42 +0100
Message-ID: <2668612.1727471502@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Eduard Zingerman <eddyz87@gmail.com> wrote:

> On Fri, 2024-09-27 at 21:50 +0100, David Howells wrote:
> > Is it possible for you to turn on some tracepoints and access the trac=
es?
> > Granted, you probably need to do the enablement during boot.
> =

> Yes, sure, tell me what you need.

If you look here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log=
/?h=3Dnetfs-fixes

you can see some patches I've added.  If you can try this branch or cherry
pick:

	netfs: Fix write oops in generic/346 (9p) and generic/074 (cifs)
	netfs: Advance iterator correctly rather than jumping it
	netfs: Use a folio_queue allocation and free functions
	netfs: Add a tracepoint to log the lifespan of folio_queue structs

And then turn on the following "netfs" tracepoints:

	read,sreq,rreq,failure,write,write_iter,folio,folioq,progress,donate

which can be done by:

	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_read/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_rreq/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_sreq/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_failure/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_write/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_write_iter/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_folio/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_folioq/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_progress/enable
	echo 1 >/sys/kernel/debug/tracing/events/netfs/netfs_donate/enable

or through trace-cmd.

> Alternatively I can pack this thing in a dockerfile, so that you would
> be able to reproduce locally (but that would have to wait till my evenin=
g).

I don't have Docker set up, so I'm not sure how easy that would be for me =
to
use.

Thanks,
David


