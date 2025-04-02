Return-Path: <linux-cifs+bounces-4360-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31068A7939F
	for <lists+linux-cifs@lfdr.de>; Wed,  2 Apr 2025 19:10:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E8DE916F4DD
	for <lists+linux-cifs@lfdr.de>; Wed,  2 Apr 2025 17:10:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFCE15CD46;
	Wed,  2 Apr 2025 17:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UrQ5Yp/Y"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCE532AEE9
	for <linux-cifs@vger.kernel.org>; Wed,  2 Apr 2025 17:09:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743613797; cv=none; b=dJbAkwiJkKoCSTod0gkuGUivtrpXFSHm6uF0jKN+rLI3S1dJRoGKKsnK4zABIQgZR4TeIWbDOF5aIBOGXOqmpNVpKePAi5VSJz8yYyWw7sLpECq01fdoOugO3pfcyYOTIwP3cAjFnw/LkCmuiYGHVX3kZfNi1KqAQarkXSv61X8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743613797; c=relaxed/simple;
	bh=HtHYDth0F/plQJwYGwda6+uF2zNn055yNiXJQVssDiY=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=lsVp7vPP3UWtJpOdKLjbXYCmN9dhRt3HkHhYLkTPildO7EprMwc6r/TqobmPzVI3TcvsUC3WPbOKNsGOeBDDpjTNgmX9ZZVDxXcRQYObfEUUWok/uIl3sw9OfMGNosMiKhj7uzcgFwd6ZLEpv72gdRXrALvn/Czd0lNyWF4YeGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UrQ5Yp/Y; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1743613794;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=oINYtJWfQ9LgmLRorSFrUIUNiQBEOvE5PqodZADRXDU=;
	b=UrQ5Yp/Y3DvEM726yoOU+tP6vj6WL0qWvYb0A1wBsI3BmkkwOOBd/RWIbBuKyGsa49Xowy
	bM3HjC84D0KlgvNWBW0W9C8ktWiNUbLjiHoD3JanK6WkNtoa6i9zWA5evS51IBLPDvUj+Y
	iSNCWgBE/PIyjFW3ketZr5eeox7psJc=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-687-gh6G64WVM5evjoEEgdgazg-1; Wed,
 02 Apr 2025 13:09:51 -0400
X-MC-Unique: gh6G64WVM5evjoEEgdgazg-1
X-Mimecast-MFC-AGG-ID: gh6G64WVM5evjoEEgdgazg_1743613790
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 3652318001E0;
	Wed,  2 Apr 2025 17:09:49 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.40])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 0E0753001D0E;
	Wed,  2 Apr 2025 17:09:46 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <7e1fc71c-2821-4294-833c-746c5fd7ee69@talpey.com>
References: <7e1fc71c-2821-4294-833c-746c5fd7ee69@talpey.com> <78c910b0-3391-484e-aa44-42e2f9ff4637@talpey.com> <563557.1743526559@warthog.procyon.org.uk> <659109.1743536087@warthog.procyon.org.uk>
To: Tom Talpey <tom@talpey.com>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Stefan Metzmacher <metze@samba.org>,
    Paulo Alcantara <pc@manguebit.com>,
    Matthew Wilcox <willy@infradead.org>, linux-cifs@vger.kernel.org
Subject: Re: cifs RDMA restrictions
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <803440.1743613785.1@warthog.procyon.org.uk>
Date: Wed, 02 Apr 2025 18:09:45 +0100
Message-ID: <803441.1743613785@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Tom Talpey <tom@talpey.com> wrote:

> > But, will the device handle that?  And can the DMA API map a single buffer
> > that big with the IOMMU?  And does it need aligning to a larger pow-of-2
> > granule?
> 
> Yes, maybe and no.
> 1 - The device just expects a base and length, so size is not an issue.
> 2 - The IOMMU is a platform question, if it's in use and the mapping
>     allows, it should work.
> 3 - No specific alignment required.

Is there a way to query the RDMA layer as to its limits?

David


