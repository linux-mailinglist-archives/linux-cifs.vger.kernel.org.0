Return-Path: <linux-cifs+bounces-9047-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uHTvMzhmcWmaGgAAu9opvQ
	(envelope-from <linux-cifs+bounces-9047-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 00:50:16 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 169DC5FA9F
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 00:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id C63C14E16D4
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Jan 2026 23:50:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C17D33EDACA;
	Wed, 21 Jan 2026 23:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Dibwf30u"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69AA93ECBFD
	for <linux-cifs@vger.kernel.org>; Wed, 21 Jan 2026 23:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769039411; cv=none; b=TClW6Cn2aAebuE28fenDptCzYNBf36SH54uhEzoz/WylhZeMdQoDnnDU7rXquqiZ5dr4X3yOODrAW2bJeF0ZayzU4eN9pdTpA7lBUu/Q/bU4xmuv5IA0f+liyD1ibEpDpY33czdTbicvqiFSEuVIseHikgxuduWF3WfU1SkRYv4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769039411; c=relaxed/simple;
	bh=XX9fne8avGeBTbal/cTHvlFAW3taxG7VJH2AE0bpKsk=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=BLg2ySsfIp9csRkY4HrmOrrs57+p/Z/HjQhk1CLeI3PLWjsJko/ffkdO1XMgukrIw7Ep5Li12mJMje5G4HrWdP/JnpHaQtq85h6e/PtsaGCl+jUsN/Hgo6tC0wgHNGRsScqTYIKQfsIc90t+qr0SgcPfl+bM+fMxYRTsBSF5k7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Dibwf30u; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769039408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=eFEQ8i2d0zk9iJFjLZnosHDZ8V28kTp7b/4nawXCUik=;
	b=Dibwf30uY2IZD1C3kTRI+aabehA5FteSk5kOhoL5wu/ByaGbftWMbfNFxEfEASXSafGKxj
	RVKGSKfugW8jaSHT7E+TOwm7cRWRtThqePS+atbEhaaycpPXrm+s/CBVHy5KGU8l5YqYsy
	Wn80Gxa7M2WjlnEf0InG4ECxcp6Mgao=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-319-Rg9Y7hF-O0G7QaD0l67d9A-1; Wed,
 21 Jan 2026 18:50:05 -0500
X-MC-Unique: Rg9Y7hF-O0G7QaD0l67d9A-1
X-Mimecast-MFC-AGG-ID: Rg9Y7hF-O0G7QaD0l67d9A_1769039403
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id CCF3F18005B9;
	Wed, 21 Jan 2026 23:50:03 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 2E11C19560A2;
	Wed, 21 Jan 2026 23:50:01 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1653031.1769038583@warthog.procyon.org.uk>
References: <1653031.1769038583@warthog.procyon.org.uk> <20260120062152.628822-4-sprasad@microsoft.com> <20260120062152.628822-1-sprasad@microsoft.com>
To: nspmangalore@gmail.com
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org, smfrench@gmail.com,
    pc@manguebit.com, bharathsm@microsoft.com,
    Shyam Prasad N <sprasad@microsoft.com>
Subject: Re: [PATCH 4/4] cifs: make retry logic in read/write path consistent with other paths
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1653264.1769039401.1@warthog.procyon.org.uk>
Date: Wed, 21 Jan 2026 23:50:01 +0000
Message-ID: <1653265.1769039401@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,manguebit.com,microsoft.com];
	DMARC_POLICY_ALLOW(0.00)[redhat.com,quarantine];
	TAGGED_FROM(0.00)[bounces-9047-lists,linux-cifs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	HAS_ORG_HEADER(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-cifs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-cifs];
	RCPT_COUNT_SEVEN(0.00)[7];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: 169DC5FA9F
X-Rspamd-Action: no action

David Howells <dhowells@redhat.com> wrote:

> Better to offload the pause to netfslib if we can.

I would suggest you look at doing it in netfs_retry_writes().  Something like:

 (1) Add a timestamp to netfs_io_request to record either the first op being
     issued or the last op being issued.

 (2) After netfs_retry_writes() finishes waiting for subreqs to quiesce, wait
     for the requisite amount of time since the timestamp recorded in (1)
     before continuing the retry.

 (3) Add a method to netfs_request_ops to allow netfslib to ask the filesystem
     what backoff delay it wants to insert.  This could call
     smb2_should_replay().

Alternatively, set a flag on cifs_io_request indicating backoff is required
and do it in cifs_prepare_write() before waiting for credits if the flag is
set - or maybe in cifs_issue_write() - at which point clear the flag.

David


