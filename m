Return-Path: <linux-cifs+bounces-202-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 10D927FC07D
	for <lists+linux-cifs@lfdr.de>; Tue, 28 Nov 2023 18:46:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4B6091C20BCD
	for <lists+linux-cifs@lfdr.de>; Tue, 28 Nov 2023 17:46:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1837939AC7;
	Tue, 28 Nov 2023 17:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AmYXKikJ"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B9510A
	for <linux-cifs@vger.kernel.org>; Tue, 28 Nov 2023 09:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1701193576;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yk6j113tXJGPHpHs0u9jLw9sedPe3cO7CNbhi5A0g1k=;
	b=AmYXKikJKMs+ZQZkCPm/12PGaGJBnU/l8MnLAcRC2YDxDKHFaOKOOQOMKlLvzceGTr3EPC
	HP6gBaVzlxc0JqlsQPbf7wz5d05YZxJp0LfddKoig7C0WLEq/e9DSA085dDyNSBY1j1xEE
	hMEuy+K/1rGrPwllrt71RAdGjp04t+U=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-328-iXk2tstZPAylBdQvRh38vg-1; Tue, 28 Nov 2023 12:46:15 -0500
X-MC-Unique: iXk2tstZPAylBdQvRh38vg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 654EA101A54C;
	Tue, 28 Nov 2023 17:46:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.42.28.161])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 414BB1C060AE;
	Tue, 28 Nov 2023 17:46:10 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
	Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
	Kingdom.
	Registered in England and Wales under Company Registration No. 3798903
From: David Howells <dhowells@redhat.com>
In-Reply-To: <CAH2r5muRJqefiMiJwKdUJZp4HMprJYCCRNSzMysCUizikQC+UA@mail.gmail.com>
References: <CAH2r5muRJqefiMiJwKdUJZp4HMprJYCCRNSzMysCUizikQC+UA@mail.gmail.com> <1297339.1700862676@warthog.procyon.org.uk> <1335877.1700868425@warthog.procyon.org.uk>
To: Steve French <smfrench@gmail.com>
Cc: dhowells@redhat.com, Steve French <sfrench@samba.org>,
    Shyam Prasad N <nspmangalore@gmail.com>,
    Rohith Surabattula <rohiths.msft@gmail.com>,
    Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
    linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cifs: Set the file size after doing copychunk_range
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <2055975.1701193569.1@warthog.procyon.org.uk>
Date: Tue, 28 Nov 2023 17:46:09 +0000
Message-ID: <2055976.1701193569@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7

Okay, I have a new version.

David


