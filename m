Return-Path: <linux-cifs+bounces-10160-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6CXWDI0Gr2knLwIAu9opvQ
	(envelope-from <linux-cifs+bounces-10160-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Mon, 09 Mar 2026 18:42:37 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9419923DC58
	for <lists+linux-cifs@lfdr.de>; Mon, 09 Mar 2026 18:42:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BC13C3074109
	for <lists+linux-cifs@lfdr.de>; Mon,  9 Mar 2026 17:40:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AC9D2F260C;
	Mon,  9 Mar 2026 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GcoyfMkk"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D52933BBB5
	for <linux-cifs@vger.kernel.org>; Mon,  9 Mar 2026 17:40:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773078022; cv=none; b=qbf9aDIbGhmLRphQuHZFiBxOeJExxtPw3LNTzJOiOsnhLxKtVJZAPC6Btjz/oeF7Z9gA4LdZ8a/MYew1zFuLTwr6luXvXh/Uuw3A9XOAOjeLw4wk+plJPgxPTQG/BrdXFESUr1KHUPPjTl+rNNAX1CJGqIwmaSkTGUxi81a9FRY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773078022; c=relaxed/simple;
	bh=FZ7Lq8ACISHxdW+hw4p+51ywraEmx5kXn6b2dCqb0pA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OtNMujX3uclhhbono55lEEXqXEGwc1r4tkxhy05EUvYFEmrPFPwI9LlqzGrQUstddKymzoaRmcdEEQg+Nwj82x23SILpvT0P/cco0QFuDAUcqO2gp6WzhcNj4O6mrZXglvaN3WjcweMSNu5n8b5N7b90kDZxhCqFjaRQJEwY3zA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GcoyfMkk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773078020;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=OGA6374tPmO2blxe8CmQQ/3g/hvizaM5owV5IRa8o78=;
	b=GcoyfMkkYNl+ZC4drEYcccNwB/69bAoZ571eYesuASDU9314PWT8pBezLDP7iCsnddErJL
	Z+5MpBQDrCa0WhToezRgYwbcyuxeAXC3t4uDN7RMkPOVb5FXX4Vt0gEn2buvi58hvaYphF
	umjoJV1gkXXKGX4rFVZBprP2UZrPb5I=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-642-SeSodcbfN0qfZMZbKtY2IA-1; Mon,
 09 Mar 2026 13:40:14 -0400
X-MC-Unique: SeSodcbfN0qfZMZbKtY2IA-1
X-Mimecast-MFC-AGG-ID: SeSodcbfN0qfZMZbKtY2IA_1773078008
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id C0E351956095;
	Mon,  9 Mar 2026 17:40:06 +0000 (UTC)
Received: from fweimer-oldenburg.csb.redhat.com (unknown [10.2.16.175])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6997918001FE;
	Mon,  9 Mar 2026 17:39:55 +0000 (UTC)
From: Florian Weimer <fweimer@redhat.com>
To: Andy Lutomirski <luto@amacapital.net>
Cc: Christian Brauner <brauner@kernel.org>,  Jeff Layton
 <jlayton@kernel.org>,  Dorjoy Chowdhury <dorjoychy111@gmail.com>,
  linux-fsdevel@vger.kernel.org,  linux-kernel@vger.kernel.org,
  linux-api@vger.kernel.org,  ceph-devel@vger.kernel.org,
  gfs2@lists.linux.dev,  linux-nfs@vger.kernel.org,
  linux-cifs@vger.kernel.org,  v9fs@lists.linux.dev,
  linux-kselftest@vger.kernel.org,  viro@zeniv.linux.org.uk,  jack@suse.cz,
  chuck.lever@oracle.com,  alex.aring@gmail.com,  arnd@arndb.de,
  adilger@dilger.ca,  mjguzik@gmail.com,  smfrench@gmail.com,
  richard.henderson@linaro.org,  mattst88@gmail.com,  linmag7@gmail.com,
  tsbogend@alpha.franken.de,  James.Bottomley@hansenpartnership.com,
  deller@gmx.de,  davem@davemloft.net,  andreas@gaisler.com,
  idryomov@gmail.com,  amarkuze@redhat.com,  slava@dubeyko.com,
  agruenba@redhat.com,  trondmy@kernel.org,  anna@kernel.org,
  sfrench@samba.org,  pc@manguebit.org,  ronniesahlberg@gmail.com,
  sprasad@microsoft.com,  tom@talpey.com,  bharathsm@microsoft.com,
  shuah@kernel.org,  miklos@szeredi.hu,  hansg@kernel.org
Subject: Re: [PATCH v5 1/4] openat2: new OPENAT2_REGULAR flag support
In-Reply-To: <CALCETrWjb+V-zrMT412MtmgDCx9y8simJBQ7+45C9MtdiSMnuw@mail.gmail.com>
	(Andy Lutomirski's message of "Mon, 9 Mar 2026 09:50:18 -0700")
References: <20260307140726.70219-1-dorjoychy111@gmail.com>
	<20260307140726.70219-2-dorjoychy111@gmail.com>
	<CALCETrXVBA9uGEUdQPEZ2MVdxjLwwcWi5kzhOr1NdOWSSRaROw@mail.gmail.com>
	<801cf2c42b80d486726ea0a3774e52abcb158100.camel@kernel.org>
	<CALCETrVt7o+7JCMfTX3Vu9PANJJgR8hB5Z2THcXzam61kG9Gig@mail.gmail.com>
	<20260309-umsturz-herfallen-067eb2df7ec2@brauner>
	<CALCETrWjb+V-zrMT412MtmgDCx9y8simJBQ7+45C9MtdiSMnuw@mail.gmail.com>
Date: Mon, 09 Mar 2026 18:39:53 +0100
Message-ID: <lhusea8hpg6.fsf@oldenburg.str.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Queue-Id: 9419923DC58
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_TWELVE(0.00)[44];
	FREEMAIL_CC(0.00)[kernel.org,gmail.com,vger.kernel.org,lists.linux.dev,zeniv.linux.org.uk,suse.cz,oracle.com,arndb.de,dilger.ca,linaro.org,alpha.franken.de,hansenpartnership.com,gmx.de,davemloft.net,gaisler.com,redhat.com,dubeyko.com,samba.org,manguebit.org,microsoft.com,talpey.com,szeredi.hu];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-10160-lists,linux-cifs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[fweimer@redhat.com,linux-cifs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-cifs];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,oldenburg.str.redhat.com:mid]
X-Rspamd-Action: no action

* Andy Lutomirski:

> On the flip side, /proc itself can certainly be opened.  Should
> O_REGULAR be able to open the more magical /proc and /sys files?  Are
> there any that are problematic?

It seems reading from /proc/kmsg is destructive.  The file doesn't have
an end, either.  It's more like a character device.  Apparently,
/sys/kernel/tracing/trace_pipe is similar in that regard.  Maybe that's
sufficient reason for blocking access?  Although the side effect does
not happen on open.

The other issue is the incorrect size reporting in stat, which affects
most (all?) files under /proc and /sys.  Userspace has already to around
that, though.

Thanks,
Florian


