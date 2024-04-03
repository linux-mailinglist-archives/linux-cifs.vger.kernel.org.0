Return-Path: <linux-cifs+bounces-1759-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 59162896FA9
	for <lists+linux-cifs@lfdr.de>; Wed,  3 Apr 2024 14:58:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 13EA8283EF4
	for <lists+linux-cifs@lfdr.de>; Wed,  3 Apr 2024 12:58:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAC621487E3;
	Wed,  3 Apr 2024 12:58:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EpTSekWd"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C81D1482F0
	for <linux-cifs@vger.kernel.org>; Wed,  3 Apr 2024 12:58:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712149111; cv=none; b=CQ87hyNf8BUhWVtLNGnXYPCiPCHsPql9t/a5ql1wXN08siaQCSqrcN8Yhzvx8POns4iAI9gwNeD+T/7PJE1czK/bfbYt4y6kviYYgbMvysKKWxjoTJ95se5KSd3FC/bawr2vA3+wX6syPUdcQzAk3VCrGo6rJ+G1yqw/zZO4qL0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712149111; c=relaxed/simple;
	bh=DAkeTo88/Q8SBcOAB+webgQsBX2i+Ci1XmPfSwoxQ0Q=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=cvQd2M4HNJ1TplPosZUQvvLgBAczDlnSQr4fH7812dXxzNS6SrLC1zI1pCXTwHMnOGMOj0AUn4b0Wo5lKhFj5i26n7d7NcDZOepaETp+t4ZZjVFLIhUa1plRllITNttbpi4dJ4Dqf7ETGUowfXLVfMn1sq1ZWYBMVRDIQv0s9rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EpTSekWd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712149109;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=5DGnORPv79MmjGVc5naevaHP+scfzBDnCLP3n2Z3Y4Q=;
	b=EpTSekWdA8BvThrBJSq0nxf6XqOsPuhXEg6DdSUK+AlAajfaszTzQVTlPFb6CSOabHl7q0
	CsbrpRCVpkFBifQTTSMI7EcdMjAUawX5FiGZkenpZHlx5ZLYdZhjNdZDDSwk+VPMLise+J
	Clbep75iCbKhKPY3xHSO+weK1Hn1jrY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522-dz7FoxU5NrCenslQwwmFtQ-1; Wed, 03 Apr 2024 08:58:24 -0400
X-MC-Unique: dz7FoxU5NrCenslQwwmFtQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E932785A588;
	Wed,  3 Apr 2024 12:58:22 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E17DAC04122;
	Wed,  3 Apr 2024 12:58:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240403124124.GA19085@lst.de>
References: <20240403124124.GA19085@lst.de> <20240403101422.GA7285@lst.de> <20240403085918.GA1178@lst.de> <20240328163424.2781320-1-dhowells@redhat.com> <20240328163424.2781320-16-dhowells@redhat.com> <3235934.1712139047@warthog.procyon.org.uk> <3300438.1712141700@warthog.procyon.org.uk>
To: Christoph Hellwig <hch@lst.de>
Cc: dhowells@redhat.com, Christian Brauner <christian@brauner.io>,
    Jeff Layton <jlayton@kernel.org>,
    Gao Xiang <hsiangkao@linux.alibaba.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Matthew Wilcox <willy@infradead.org>,
    Steve French <smfrench@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>, netfs@lists.linux.dev,
    linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
    linux-cifs@vger.kernel.org, linux-nfs@vger.kernel.org,
    ceph-devel@vger.kernel.org, v9fs@lists.linux.dev,
    linux-erofs@lists.ozlabs.org, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH 15/26] mm: Export writeback_iter()
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3326106.1712149095.1@warthog.procyon.org.uk>
Date: Wed, 03 Apr 2024 13:58:15 +0100
Message-ID: <3326107.1712149095@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Christoph Hellwig <hch@lst.de> wrote:

> > So why are we bothering with EXPORT_SYMBOL at all?  Why don't you just
> > send a patch replace all of them with EXPORT_SYMBOL_GPL()?
> 
> No my business.

Clearly it is as you're gradually replacing APIs with stuff that is GPL'd.

> But if you want to side track this let me just put this in here:
> 
> NAK to the non-GPL EXPORT of writeback_iter().

Very well, I'll switch that export to GPL.  Christian, if you can amend that
patch in your tree?

David


