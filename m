Return-Path: <linux-cifs+bounces-5124-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 655F8AE68C7
	for <lists+linux-cifs@lfdr.de>; Tue, 24 Jun 2025 16:32:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2BC294E364B
	for <lists+linux-cifs@lfdr.de>; Tue, 24 Jun 2025 14:26:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 618BA2DECC2;
	Tue, 24 Jun 2025 14:23:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="De6nT6PZ"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE51B2DECBE
	for <linux-cifs@vger.kernel.org>; Tue, 24 Jun 2025 14:22:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750774981; cv=none; b=fHgqYkqgEAgRXjE2To9uK6YmNVrBZBMpIDUe/ejJkrsN/PYwc6THBMx4xnsZ35fytu2uryODXGQyYefehObzB/cILTHTqaHH4DyJmM1qZn4Kw05HEv32NUryrwBcizCwAMB6Tu29id39XuVhQCrIAwPgQYsSAspcV3E5LPl6Aig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750774981; c=relaxed/simple;
	bh=DyGsBcB6vv3h1JsbgAkV+Dgc9KpOte+BK0rILkrHnu4=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=tZhl8EtGHQYY32bcZwf6Gu6QQPgVjxw+HcrowrbHQbWZuBtPOoqLCvtH054wMf/Yq2crBdQy4zJZ/j3z+INen+KJBqoWmezHXCGFWtEQdm2FpJon2mBT4INULrp7YL8QFlJCAG2u4h9ZoHm+RcZ4DPnjC/snqXuEwgPlleJC9Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=De6nT6PZ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750774978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Su4dK6eziUeWtnT2n4zYWHb6UwxoSMzl876+vyWG0NY=;
	b=De6nT6PZEYaqmq1MdZpMdQ7tetDlUfxPpP9342eZZr6IRVOL83Pkv0LVUFVRigGQjCEald
	Og4Cnyg2CGQl4wDUMEjh9uLOJTzkS6bo4xedHQzBpgHeKxZb2123RVLlFnwtC+NgXUpmqS
	PfuxHv5ZRUKRxOxZYp9d+jcdfu8OD2o=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-316-fMlWeTagONaZYJyOFC7J2Q-1; Tue,
 24 Jun 2025 10:22:55 -0400
X-MC-Unique: fMlWeTagONaZYJyOFC7J2Q-1
X-Mimecast-MFC-AGG-ID: fMlWeTagONaZYJyOFC7J2Q_1750774974
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 60C8719560B3;
	Tue, 24 Jun 2025 14:22:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.81])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 94E4530001A1;
	Tue, 24 Jun 2025 14:22:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <f448a729-ca2e-40a8-be67-3334f47a3916@samba.org>
References: <f448a729-ca2e-40a8-be67-3334f47a3916@samba.org> <1107690.1750683895@warthog.procyon.org.uk>
To: Stefan Metzmacher <metze@samba.org>
Cc: dhowells@redhat.com,
    "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
    netfs@lists.linux.dev, linux-fsdevel <linux-fsdevel@vger.kernel.org>,
    Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH] cifs: Collapse smbd_recv_*() into smbd_recv() and just use copy_to_iter()
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1156126.1750774971.1@warthog.procyon.org.uk>
Date: Tue, 24 Jun 2025 15:22:51 +0100
Message-ID: <1156127.1750774971@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Stefan Metzmacher <metze@samba.org> wrote:

> >   read_rfc1002_done:
> > +		/* SMBDirect will read it all or nothing */
> > +		msg->msg_iter.count = 0;
> 
> And this iov_iter_truncate(0);

Actually, it should probably have been iov_iter_advance().

> While I'm wondering why we had this at all.
> 
> It seems all callers of cifs_read_iter_from_socket()
> don't care and the code path via sock_recvmsg() doesn't
> truncate it just calls copy_to_iter() via this chain:
> ->inet_recvmsg->tcp_recvmsg->skb_copy_datagram_msg->skb_copy_datagram_iter
> ->simple_copy_to_iter->copy_to_iter()
> 
> I think the old code should have called
> iov_iter_advance(rc) instead of msg->msg_iter.count = 0.
> 
> But the new code doesn't need it as copy_to_iter()
> calls iterate_and_advance().

Yeah, it should.  I seem to remember that there were situations in which it
didn't, but it's possible I managed to get rid of them.

> > -	default:
> > -		/* It's a bug in upper layer to get there */
> > -		cifs_dbg(VFS, "Invalid msg type %d\n",
> > -			 iov_iter_type(&msg->msg_iter));
> > -		rc = -EINVAL;
> > -	}
> 
> I guess this is actually a real fix as I just saw
> CIFS: VFS: Invalid msg type 4
> in logs while running the cifs/001 test.
> And 4 is ITER_FOLIOQ.

Ah... Were you using "-o seal"?  The encrypted data is held in a buffer formed
from a folioq with a series of folios in it.

David


