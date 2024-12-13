Return-Path: <linux-cifs+bounces-3620-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 35C5B9F0DC2
	for <lists+linux-cifs@lfdr.de>; Fri, 13 Dec 2024 14:51:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 028CB16ACCE
	for <lists+linux-cifs@lfdr.de>; Fri, 13 Dec 2024 13:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CDD711E1A32;
	Fri, 13 Dec 2024 13:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rgc7YuW9"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D868C1E0B8A
	for <linux-cifs@vger.kernel.org>; Fri, 13 Dec 2024 13:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734097847; cv=none; b=qIY+XtV5DtnDRXh9MmnGDpXggHwMxmEyQxNezyGcROErDZnGUn45P32J8x8SwrcKANxvch0+2elgGR8SNCkikZOP9jxkcGjeQfQAirLC1qP0r4NJkn1iwUA3TInzwLKalp0WARHAfOxXDfbTn9Qy9tvUcoWrXRm7VFdmQQ75Nmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734097847; c=relaxed/simple;
	bh=Gn32ove2Yu+uyaaNX7UGUwI/rCfUUP4QCCBh0KLUvxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=os2vanxRteuhfboszot7uaBG8A4pyAKkFIyG9XX1MURGgL7fXytSZ9BzhKLn2SrEimNckiKalPmDI4BmdicgI9OMphxqH/1dd8+RC4qorICQ+D3gHGkCTR/pPOsDfX4K61HtEjJG3P8VbxiNrlEdYUBeJdoFHmUh/C3Xkjf7DZ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Rgc7YuW9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1734097844;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XyqR/WjDCwAE5X+NDEcLa5xYMEUn9QBuN0OBrTmThCY=;
	b=Rgc7YuW9JNB//oZMuTVw7KwzVTQrGrFlf9xWClLXtH5PrC6i37r51AuCNiUccM8+YojxA1
	iZHWFr4uTngWfXMm3tVmDEqXaUT5J6pvAczXHANEGNkBKEXobgGWN+70yBuWdsJu93tP2Z
	ynrBp9dzQoLOkh5pDU7KAJzVH/YF3vg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-73--YEkMWSgNkChCQp0_JqhQQ-1; Fri,
 13 Dec 2024 08:50:40 -0500
X-MC-Unique: -YEkMWSgNkChCQp0_JqhQQ-1
X-Mimecast-MFC-AGG-ID: -YEkMWSgNkChCQp0_JqhQQ
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 7662919560AF;
	Fri, 13 Dec 2024 13:50:37 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.48])
	by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1BF2F1956089;
	Fri, 13 Dec 2024 13:50:31 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Max Kellermann <max.kellermann@ionos.com>,
	Ilya Dryomov <idryomov@gmail.com>,
	Xiubo Li <xiubli@redhat.com>,
	Trond Myklebust <trondmy@kernel.org>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org,
	Shyam Prasad N <nspmangalore@gmail.com>,
	Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 02/10] netfs: Fix non-contiguous donation between completed reads
Date: Fri, 13 Dec 2024 13:50:02 +0000
Message-ID: <20241213135013.2964079-3-dhowells@redhat.com>
In-Reply-To: <20241213135013.2964079-1-dhowells@redhat.com>
References: <20241213135013.2964079-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15

When a read subrequest finishes, if it doesn't have sufficient coverage to
complete the folio(s) covering either side of it, it will donate the excess
coverage to the adjacent subrequests on either side, offloading
responsibility for unlocking the folio(s) covered to them.

Now, preference is given to donating down to a lower file offset over
donating up because that check is done first - but there's no check that
the lower subreq is actually contiguous, and so we can end up donating
incorrectly.

The scenario seen[1] is that an 8MiB readahead request spanning four 2MiB
folios is split into eight 1MiB subreqs (numbered 1 through 8).  These
terminate in the order 1,6,2,5,3,7,4,8.  What happens is:

	- 1 donates to 2
	- 6 donates to 5
	- 2 completes, unlocking the first folio (with 1).
	- 5 completes, unlocking the third folio (with 6).
	- 3 donates to 4
	- 7 donates to 4 incorrectly
	- 4 completes, unlocking the second folio (with 3), but can't use
	  the excess from 7.
	- 8 donates to 4, also incorrectly.

Fix this by preventing downward donation if the subreqs are not contiguous
(in the example above, 7 donates to 4 across the gap left by 5 and 6).

Reported-by: Shyam Prasad N <nspmangalore@gmail.com>
Closes: https://lore.kernel.org/r/CANT5p=qBwjBm-D8soFVVtswGEfmMtQXVW83=TNfUtvyHeFQZBA@mail.gmail.com/
Signed-off-by: David Howells <dhowells@redhat.com>
cc: Steve French <sfrench@samba.org>
cc: Paulo Alcantara <pc@manguebit.com>
cc: Jeff Layton <jlayton@kernel.org>
cc: linux-cifs@vger.kernel.org
cc: netfs@lists.linux.dev
cc: linux-fsdevel@vger.kernel.org
Link: https://lore.kernel.org/r/526707.1733224486@warthog.procyon.org.uk/ [1]
---
 fs/netfs/read_collect.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/fs/netfs/read_collect.c b/fs/netfs/read_collect.c
index 3cbb289535a8..b415e3972336 100644
--- a/fs/netfs/read_collect.c
+++ b/fs/netfs/read_collect.c
@@ -247,16 +247,17 @@ static bool netfs_consume_read_data(struct netfs_io_subrequest *subreq, bool was
 
 	/* Deal with the trickiest case: that this subreq is in the middle of a
 	 * folio, not touching either edge, but finishes first.  In such a
-	 * case, we donate to the previous subreq, if there is one, so that the
-	 * donation is only handled when that completes - and remove this
-	 * subreq from the list.
+	 * case, we donate to the previous subreq, if there is one and if it is
+	 * contiguous, so that the donation is only handled when that completes
+	 * - and remove this subreq from the list.
 	 *
 	 * If the previous subreq finished first, we will have acquired their
 	 * donation and should be able to unlock folios and/or donate nextwards.
 	 */
 	if (!subreq->consumed &&
 	    !prev_donated &&
-	    !list_is_first(&subreq->rreq_link, &rreq->subrequests)) {
+	    !list_is_first(&subreq->rreq_link, &rreq->subrequests) &&
+	    subreq->start == prev->start + prev->len) {
 		prev = list_prev_entry(subreq, rreq_link);
 		WRITE_ONCE(prev->next_donated, prev->next_donated + subreq->len);
 		subreq->start += subreq->len;


