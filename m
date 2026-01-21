Return-Path: <linux-cifs+bounces-9043-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cOf6FuBgcWkHGgAAu9opvQ
	(envelope-from <linux-cifs+bounces-9043-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 00:27:28 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id D82145F7CB
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 00:27:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6A1C096A822
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Jan 2026 23:23:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BD6942E011;
	Wed, 21 Jan 2026 23:19:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R3W3AiX9"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1648F227E95
	for <linux-cifs@vger.kernel.org>; Wed, 21 Jan 2026 23:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769037548; cv=none; b=VRr6TBCOZ8WtQCoxgKw7y3xoU75JBK5PEmTBQ4gWJO7y7BDAh+E4kISXp6hK5m50jcsRdt1MfYIe1LcosoIqw6xccsCtXi9cwW5mTgqe6kUuXMA25elqm9TW7L71f+AGzI5PgPwN4Q7EanW6jMnLIZO0y9ppe94dzuUubIZ/HJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769037548; c=relaxed/simple;
	bh=PT2M30WPig5juNF7kY4rPA7QrWedNJGGNHOEIftmBls=;
	h=From:In-Reply-To:References:To:Cc:Subject:MIME-Version:
	 Content-Type:Date:Message-ID; b=ciCaGw6SEt4FwHFcynv4kHCSIMC+OKDg63mSUHh/c4a8LM7jKx/XogegNO2sxt26cpgK0ZSD5PY14mQzw1Wt5Bq8X7gs/zGoWtsfINJZU/4duA6Rn0iYjmosgvtX0eSmcoEmoszQLDqesbUbLjDFf0bE8UTp8PyWlQU5RhoXLhw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R3W3AiX9; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769037540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=fLMciNG21wymqGAVFxlUW4ByQUMWQQqY3keWMCZJA9g=;
	b=R3W3AiX9Yhxs+p9368l5cMUYnM383vVAAVOmmfCqOt/jv4JswC8uk9AtZ0Mg8W0ZYYNq/4
	Tt0/4pMWx7svXw3SsHP5126I8wTudg9m0SglpHHnVwDdtJg7sBG7ymFpBeFXNsOEycV5UG
	oqGVNM5jbW9GaS5PjZ8t0o2eue3b+1s=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-562-INvmbDIuNkit0vFMV85yAg-1; Wed,
 21 Jan 2026 18:18:55 -0500
X-MC-Unique: INvmbDIuNkit0vFMV85yAg-1
X-Mimecast-MFC-AGG-ID: INvmbDIuNkit0vFMV85yAg_1769037534
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2E4641956050;
	Wed, 21 Jan 2026 23:18:54 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.2])
	by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 9D11919560AB;
	Wed, 21 Jan 2026 23:18:52 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <20260120062152.628822-1-sprasad@microsoft.com>
References: <20260120062152.628822-1-sprasad@microsoft.com>
To: nspmangalore@gmail.com
Cc: dhowells@redhat.com, linux-cifs@vger.kernel.org, smfrench@gmail.com,
    pc@manguebit.com, bharathsm@microsoft.com,
    Shyam Prasad N <sprasad@microsoft.com>
Subject: Re: [PATCH 1/4] netfs: when subreq is marked for retry, do not check if it faced an error
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1652301.1769037531.1@warthog.procyon.org.uk>
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Jan 2026 23:18:51 +0000
Message-ID: <1652302.1769037531@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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
	TAGGED_FROM(0.00)[bounces-9043-lists,linux-cifs=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:2605:f480::/32, country:US];
	FORGED_SENDER_MAILLIST(0.00)[]
X-Rspamd-Queue-Id: D82145F7CB
X-Rspamd-Action: no action

nspmangalore@gmail.com wrote:

> @@ -547,13 +547,15 @@ void netfs_read_subreq_terminated(struct netfs_io_=
subrequest *subreq)
>  	}
>  =

>  	if (unlikely(subreq->error < 0)) {
> -		trace_netfs_failure(rreq, subreq, subreq->error, netfs_fail_read);
>  		if (subreq->source =3D=3D NETFS_READ_FROM_CACHE) {
>  			netfs_stat(&netfs_n_rh_read_failed);
>  			__set_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags);
>  		} else {
>  			netfs_stat(&netfs_n_rh_download_failed);
> -			__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
> +			if (!test_bit(NETFS_SREQ_NEED_RETRY, &subreq->flags)) {
> +				__set_bit(NETFS_SREQ_FAILED, &subreq->flags);
> +				trace_netfs_failure(rreq, subreq, subreq->error, netfs_fail_read);
> +			}
>  		}
>  		trace_netfs_rreq(rreq, netfs_rreq_trace_set_pause);
>  		set_bit(NETFS_RREQ_PAUSE, &rreq->flags);

I think I suggested moving the check for NETFS_SREQ_NEED_RETRY up in the
function - above any checks of subreq->error, but after the initial stat
counting.

Ditto for netfs_write_subrequest_terminated().  Actually, the
transferred_or_error argument of that should be got rid of and the filesys=
tem
update the subreq->error and subreq->transferred fields directly as for re=
ads.

I can poke at this tomorrow if you want.

David


