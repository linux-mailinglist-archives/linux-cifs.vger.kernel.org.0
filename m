Return-Path: <linux-cifs+bounces-9173-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EC/mEXixfGmbOQIAu9opvQ
	(envelope-from <linux-cifs+bounces-9173-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Fri, 30 Jan 2026 14:26:16 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E027BAFC7
	for <lists+linux-cifs@lfdr.de>; Fri, 30 Jan 2026 14:26:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5FCC3302F704
	for <lists+linux-cifs@lfdr.de>; Fri, 30 Jan 2026 13:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 93F8A2E8B61;
	Fri, 30 Jan 2026 13:24:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="IUAeY4Vs"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F2112DFF04
	for <linux-cifs@vger.kernel.org>; Fri, 30 Jan 2026 13:24:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769779494; cv=none; b=Q9Cv++P77KO3s4OfAD13uWp5oSWaw/H2hT2AuSphC569rqLRalKXw07xLer86eozPtse4WJ160cLMvtP8ANQq5TB0JL+Fkn3+wcWAzFTO97jIfSNSurAg8jPQ1pkRIbEFVVd1AN1WTb7TIIePffAlCYecAKmz3mNHoHxB3yFSZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769779494; c=relaxed/simple;
	bh=b/hcOjFRWOOYet6L1gL6zk0O+RAvqV44hNeisWhTocU=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ayZgfsjyM5JJUmEjb2aXrSAuWtMvCXaqEzgUe4jjokJ+aMaufQTVgwYF7x/UiaRpRPKYT0pvcr3tApQzFoxBbxPiX7HDXrjuJ8Nwol6f83B1WUxXxtTrVJ6hhs4CvwmWfrnf49WfKIkLE9FC8TMO6ji7Et2RR374rbaEHc+GMZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=IUAeY4Vs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769779492;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BXM0JO7oUPN2l7gs39D3NSlPcrZU7IvbD8zukACQptk=;
	b=IUAeY4Vs3Y2i02wYyF3ESPIxewk+/MV8yFQ4xmmjOqH1iwF8UjbckaHQ8WZ4NNha/nl7BB
	M3p6QoxcHPsMA9aqPFCVudSBSuOZinySkNUHDPZ0SFGnhB4KYN3DaQGTBoYEVuMRHkhNmr
	qy8tYU7nqEViLofEP6PrgpvBoPEcJdg=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-662-R_-96B1EMiCgHMX0xqI8Dw-1; Fri,
 30 Jan 2026 08:24:46 -0500
X-MC-Unique: R_-96B1EMiCgHMX0xqI8Dw-1
X-Mimecast-MFC-AGG-ID: R_-96B1EMiCgHMX0xqI8Dw_1769779485
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 91F3E18005A7;
	Fri, 30 Jan 2026 13:24:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.44.33.164])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3D6081956056;
	Fri, 30 Jan 2026 13:24:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260129173725.887651-2-sprasad@microsoft.com>
References: <20260129173725.887651-2-sprasad@microsoft.com> <20260129173725.887651-1-sprasad@microsoft.com>
To: nspmangalore@gmail.com
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org, smfrench@gmail.com,
    pc@manguebit.org, bharathsm@microsoft.com, netfs@lists.linux.dev,
    Shyam Prasad N <sprasad@microsoft.com>
Subject: Re: [PATCH v3 2/4] netfs: when subreq is marked for retry, do not check if it faced an error
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2263608.1769779481.1@warthog.procyon.org.uk>
Date: Fri, 30 Jan 2026 13:24:41 +0000
Message-ID: <2263609.1769779481@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[redhat.com,vger.kernel.org,gmail.com,manguebit.org,microsoft.com,lists.linux.dev];
	TAGGED_FROM(0.00)[bounces-9173-lists,linux-cifs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	HAS_ORG_HEADER(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[redhat.com:+];
	MISSING_XM_UA(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[dhowells@redhat.com,linux-cifs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-cifs];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 9E027BAFC7
X-Rspamd-Action: no action

nspmangalore@gmail.com wrote:

> +	/* if need retry is set, error should not matter. pause the rreq */

I think I'd say:

	/* If need retry is set, error should not matter unless we hit too
	 * many retries.  Pause the generation of new subreqs.
	 */

But other than that:

	Acked-by: David Howells <dhowells@redhat.com>


