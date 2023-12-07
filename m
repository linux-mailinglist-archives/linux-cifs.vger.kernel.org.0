Return-Path: <linux-cifs+bounces-367-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B5BBB8094FC
	for <lists+linux-cifs@lfdr.de>; Thu,  7 Dec 2023 22:58:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3F641C20C08
	for <lists+linux-cifs@lfdr.de>; Thu,  7 Dec 2023 21:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B44B8840F7;
	Thu,  7 Dec 2023 21:58:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zn4BRdw5"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 493701733
	for <linux-cifs@vger.kernel.org>; Thu,  7 Dec 2023 13:58:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701986281;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2gpuqenBf/seLQmhrTte/4HdPOyV33jxxLbSCYkPyeM=;
	b=Zn4BRdw5e9GjbQlK/IzkyGHo2P2snQ9aVjyzHl7CBGCn0Ug/azInrjBWraSxiqU6lLvDvt
	Upc4q8kY9wUuP1rRG0Ey4tcGouk/mzkKkmOzf9Vk9Ajf+AF0jerdG9jj6htXGO7Xo+SHhb
	ssmpxCkT0UKGx21cgU8rmIUBI7T4Gmg=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-494-3pxRZfFcM5CBFUREWELNAA-1; Thu,
 07 Dec 2023 16:57:57 -0500
X-MC-Unique: 3pxRZfFcM5CBFUREWELNAA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B64C1C0BB50;
	Thu,  7 Dec 2023 21:57:56 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id E59971C060AF;
	Thu,  7 Dec 2023 21:57:53 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZXI7aGHkxZyiytXg@casper.infradead.org>
References: <ZXI7aGHkxZyiytXg@casper.infradead.org> <20231207212206.1379128-1-dhowells@redhat.com> <20231207212206.1379128-60-dhowells@redhat.com>
To: Matthew Wilcox <willy@infradead.org>
Cc: dhowells@redhat.com, Jeff Layton <jlayton@kernel.org>,
    Steve French <smfrench@gmail.com>,
    Marc Dionne <marc.dionne@auristor.com>,
    Paulo Alcantara <pc@manguebit.com>,
    Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
    Dominique Martinet <asmadeus@codewreck.org>,
    Eric Van Hensbergen <ericvh@kernel.org>,
    Ilya Dryomov <idryomov@gmail.com>,
    Christian Brauner <christian@brauner.io>, linux-cachefs@redhat.com,
    linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
    linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
    v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
    linux-mm@kvack.org, netdev@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 59/59] netfs: Eliminate PG_fscache by setting folio->private and marking dirty
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1451125.1701986273.1@warthog.procyon.org.uk>
Date: Thu, 07 Dec 2023 21:57:53 +0000
Message-ID: <1451127.1701986273@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Matthew Wilcox <willy@infradead.org> wrote:

> On Thu, Dec 07, 2023 at 09:22:06PM +0000, David Howells wrote:
> > With this, PG_fscache is no longer required.
> 
> ... for filesystems that use netfslib, right?  ie we can't delete
> folio_wait_private_2_killable() and friends because nfs still uses it?

Yeah.  Though I have my eye on NFS too ;-)

David


