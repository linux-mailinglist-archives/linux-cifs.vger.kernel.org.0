Return-Path: <linux-cifs+bounces-219-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8303D7FDDCD
	for <lists+linux-cifs@lfdr.de>; Wed, 29 Nov 2023 17:58:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3B441C20AB2
	for <lists+linux-cifs@lfdr.de>; Wed, 29 Nov 2023 16:58:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4416D1DDFA;
	Wed, 29 Nov 2023 16:58:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="W6/ryffg"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39FB1704
	for <linux-cifs@vger.kernel.org>; Wed, 29 Nov 2023 08:58:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701277090;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PN693iXv6rn+BGgKTP3UDSjbiexkCbKdKEBIGtl7gRM=;
	b=W6/ryffg4kahcXTsm6mjWf5vYW8M/cdb49C+wCp550Lvd3DSFTriSUgYANmscq5tBNLj0d
	k8aiL63zQM9ilNXfuyyDXQCB6ep+jcueZSLT6dwE4RT/3Wkg0CFiB6Pl/a4dHTRg7FZiRk
	Vm+z5sfB5pNs2CFbxkz50ZjSLLQi+rg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-344-QQwa5L16NOSyU0abYOO_GA-1; Wed,
 29 Nov 2023 11:58:07 -0500
X-MC-Unique: QQwa5L16NOSyU0abYOO_GA-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E53291C05AB5;
	Wed, 29 Nov 2023 16:58:06 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id ACA78492BFC;
	Wed, 29 Nov 2023 16:58:05 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <2056123.1701193802@warthog.procyon.org.uk>
References: <2056123.1701193802@warthog.procyon.org.uk>
To: Steve French <sfrench@samba.org>
Cc: dhowells@redhat.com, Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>,
    Jeff Layton <jlayton@kernel.org>,
    Matthew Wilcox <willy@infradead.org>, linux-cifs@vger.kernel.org,
    linux-mm@kvack.org, linux-fsdevel@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Fix issues with copy_file_range and FALLOC_FL_INSERT/ZERO_RANGE
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2355923.1701277085.1@warthog.procyon.org.uk>
Date: Wed, 29 Nov 2023 16:58:05 +0000
Message-ID: <2355925.1701277085@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10

This patch should be considered obsolete.  I've split it up, fixes another
issue and posted three replacements.

David


