Return-Path: <linux-cifs+bounces-300-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5C0808F12
	for <lists+linux-cifs@lfdr.de>; Thu,  7 Dec 2023 18:51:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F19AFB209D7
	for <lists+linux-cifs@lfdr.de>; Thu,  7 Dec 2023 17:51:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6A7C4A980;
	Thu,  7 Dec 2023 17:51:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gDwVYsb7"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8701210DA
	for <linux-cifs@vger.kernel.org>; Thu,  7 Dec 2023 09:51:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701971460;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=IocSxJJV+aeVvbf5dVtiipJ1I/lExGhWur9qd5IRbhM=;
	b=gDwVYsb79Cfz7d+QcF1MyQy2kZJ+ZxlSBbSni4mYoGFTV8rrnSCTcToY788EO8UMf+3APu
	PWB/yzmfCDKIGTR7vBEKCtlNQ8zaFHcM4J6kXCZQbt33L6PeYGWA3tVCViqAlq83RkT8Pv
	kSRoKc43EI9yW4DcltsCKKTLxhVf1Jg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-FlwmlI5vNmODlFIOVUiARA-1; Thu, 07 Dec 2023 12:50:53 -0500
X-MC-Unique: FlwmlI5vNmODlFIOVUiARA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B96A185A780;
	Thu,  7 Dec 2023 17:50:52 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 318351121312;
	Thu,  7 Dec 2023 17:50:51 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <ZXIDgvZ8/iBhYXwy@jeremy-HP-Z840-Workstation>
References: <ZXIDgvZ8/iBhYXwy@jeremy-HP-Z840-Workstation> <700923.1701964726@warthog.procyon.org.uk>
To: Jeremy Allison <jra@samba.org>
Cc: dhowells@redhat.com, Steve French <smfrench@gmail.com>,
    Namjae Jeon <linkinjeon@kernel.org>, ronniesahlberg@gmail.com,
    Tom Talpey <tom@talpey.com>, Stefan Metzmacher <metze@samba.org>,
    jlayton@kernel.org, linux-cifs@vger.kernel.org,
    samba-technical@lists.samba.org
Subject: Re: Can fallocate() ops be emulated better using SMB request compounding?
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1215460.1701971450.1@warthog.procyon.org.uk>
Date: Thu, 07 Dec 2023 17:50:50 +0000
Message-ID: <1215461.1701971450@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3

Jeremy Allison <jra@samba.org> wrote:

> >Further, are the two ops then essentially done atomically?
> 
> No. They are processed (at least in Samba) as two separate
> requests and can be raced by local or other remote access.

So just compounding them would leave us in the same situation we are in now -
which would be fine.

What do you think about the idea of having the server see a specifically
arranged compounded pair and turn them into an op that can't otherwise be
represented in the protocol?

Or is it better to try and get the protocol extended?

David


