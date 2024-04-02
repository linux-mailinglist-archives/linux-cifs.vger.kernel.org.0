Return-Path: <linux-cifs+bounces-1714-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7670C894DDA
	for <lists+linux-cifs@lfdr.de>; Tue,  2 Apr 2024 10:46:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 164291F22C4E
	for <lists+linux-cifs@lfdr.de>; Tue,  2 Apr 2024 08:46:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5077456459;
	Tue,  2 Apr 2024 08:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="imRWQRvK"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B87A05336D
	for <linux-cifs@vger.kernel.org>; Tue,  2 Apr 2024 08:46:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712047587; cv=none; b=MRHP+iMhp2n1ibpHxOeTiBl/TyFCA78DLoFc+nrSD7nmAmWlR2wMivjaYc2RdQ0pNsx90oeydATqNnYATnUF1gr/lFaKHXVMwxh36cI9KppHGozzKIj50dKDNQtaUSOCieOiICajAqOkZG7Bi0Hq5VlHpNCrecjEIzyqZaGWwpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712047587; c=relaxed/simple;
	bh=0iCwHoYu3g7mLUt+X6CnAiX5DTbCc5GT+Ny5u3rTSPw=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=lZnK5UR8JavRj0oGdT4mox4Sma20HahgBvdxBGvRKmQ9jF8aSSLafA4UXNB8MwKbg2UyxP96U14Fha+3BKRQreoVmQg5JeiOsoCuZzIu+iEokmnwr1bhZPl1yOjhDW2JC572yPWExL4w7SefN4sXN0+z1nl4hHB9iE7WfdMdqOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=imRWQRvK; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712047584;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/8zVm5/YGf5Pgwy9JsdjJMXQWirBEfx89VnmYMfPJM4=;
	b=imRWQRvKTTJKTccfMYjOmH8yDyAfBtKDEDd4D7J27mU7QppWRoH7wlWbqVm/3d+NO50FwN
	JMkH1OLJvCUsEYklYgMQAWISno5eIumaz2YUWFoSd0xUFPDzlR+wekrF9NHrzZLRe06UJ6
	1REAO3gHfhJE1tj73p4sTiBiDryJECg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-158-jPb3_1pmPI27HEkPRk0xlA-1; Tue, 02 Apr 2024 04:46:21 -0400
X-MC-Unique: jPb3_1pmPI27HEkPRk0xlA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7A144185A784;
	Tue,  2 Apr 2024 08:46:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 5D5BC1C060A4;
	Tue,  2 Apr 2024 08:46:16 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20240328163424.2781320-20-dhowells@redhat.com>
References: <20240328163424.2781320-20-dhowells@redhat.com> <20240328163424.2781320-1-dhowells@redhat.com>
To: Dan Carpenter <dan.carpenter@linaro.org>,
    Naveen Mamindlapalli <naveenm@marvell.com>,
    Vadim Fedorenko <vadim.fedorenko@linux.dev>
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
    linux-kernel@vger.kernel.org, Latchesar Ionkov <lucho@ionkov.net>,
    Christian Schoenebeck <linux_oss@crudebyte.com>
Subject: Re: [PATCH 19/26] netfs: New writeback implementation
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3047563.1712047571.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Tue, 02 Apr 2024 09:46:11 +0100
Message-ID: <3047564.1712047571@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

David Howells <dhowells@redhat.com> wrote:

> +struct netfs_io_request *new_netfs_begin_writethrough(struct kiocb *ioc=
b, size_t len)
> +{
> +	struct netfs_io_request *wreq =3D NULL;
> +	struct netfs_inode *ictx =3D netfs_inode(file_inode(iocb->ki_filp));
> +
> +	mutex_lock(&ictx->wb_lock);
> +
> +	wreq =3D netfs_create_write_req(iocb->ki_filp->f_mapping, iocb->ki_fil=
p,
> +				      iocb->ki_pos, NETFS_WRITETHROUGH);
> +	if (IS_ERR(wreq))
> +		mutex_unlock(&ictx->wb_lock);

This needs a "return wreq;" adding and appropriate braces.  Thanks to thos=
e
who pointed it out.

David


