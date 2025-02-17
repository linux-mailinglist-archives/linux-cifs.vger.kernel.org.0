Return-Path: <linux-cifs+bounces-4061-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FE40A33271
	for <lists+linux-cifs@lfdr.de>; Wed, 12 Feb 2025 23:24:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1ACF5188542C
	for <lists+linux-cifs@lfdr.de>; Wed, 12 Feb 2025 22:24:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6DAB8204086;
	Wed, 12 Feb 2025 22:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bbffjb2n"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74A1F2045A0
	for <linux-cifs@vger.kernel.org>; Wed, 12 Feb 2025 22:24:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739399065; cv=none; b=UrAmV3BmuJdqKU18Fvea067a9fBXKhdfDP6EQAWPZW1o7vdJfp5qOF7/u8HHQht4wDwrn2eIpsjisFAgrlTA8btSv3DC6AICNWGuJTyW24dErj8jXi/lGZW8TdOUjAcjHiLTeHrti+1OVJDZeR0MdPUmjNK6XxkMNRt04TGdcMU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739399065; c=relaxed/simple;
	bh=o9Rvw5bGAnROKjad7sMpqrfxb3P+iaNsiQvl674qxYA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IXTcsNsAjBJw5VNxRiS276v/GQvTLsHakwwvrAe2yfGtAm/gZX5NbSu2C8pJG9w0OShrx/fxm3yjnjT7LWSDnPflvxo/+PL8q5rsarM0HE3qodWeGmokFenigawm86k96M7iXO/s6TEvN32lW5Q3dwE7TrNe/KX5h2MC9YjQQAs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bbffjb2n; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1739399061;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=j/hFCuHm3dQy3yCXNlW7/z5EXWgYM+xOP2nJGIBn15Q=;
	b=Bbffjb2n20i4wPWH+dKTMaVn1FDC9OT2iRVuwDF+EMneJbYRg0l3R/G/qO8PULdBJM1dnt
	qQebRsM5Nn8v4j2el7msZfiHKmwPbCEOn9+ZxIX99vk1eLASMZOruesMh5lzFvHVvmyjvI
	HOQ9B8E/UUlosxW9zhFHKIrhvgwHLI0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-iPLvlH5hPsCaSV9rKTnwgQ-1; Wed,
 12 Feb 2025 17:24:18 -0500
X-MC-Unique: iPLvlH5hPsCaSV9rKTnwgQ-1
X-Mimecast-MFC-AGG-ID: iPLvlH5hPsCaSV9rKTnwgQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 25E25180087B;
	Wed, 12 Feb 2025 22:24:13 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.92])
	by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id CBFAE19560A3;
	Wed, 12 Feb 2025 22:24:05 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>
Cc: David Howells <dhowells@redhat.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	Max Kellermann <max.kellermann@ionos.com>,
	Steve French <sfrench@samba.org>,
	Marc Dionne <marc.dionne@auristor.com>,
	Jeff Layton <jlayton@kernel.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Tom Talpey <tom@talpey.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Dominique Martinet <asmadeus@codewreck.org>,
	netfs@lists.linux.dev,
	linux-afs@lists.infradead.org,
	linux-cifs@vger.kernel.org,
	linux-nfs@vger.kernel.org,
	ceph-devel@vger.kernel.org,
	v9fs@lists.linux.dev,
	linux-erofs@lists.ozlabs.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] netfs: Miscellaneous fixes
Date: Wed, 12 Feb 2025 22:23:58 +0000
Message-ID: <20250212222402.3618494-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40

Hi Christian,

Here are some miscellaneous fixes and changes for netfslib, if you could
pull them:

 (1) Fix a number of read-retry hangs, including:

     (a) Incorrect getting/putting of references on subreqs as we retry
     	 them.

     (b) Failure to track whether a last old subrequest in a retried set is
     	 superfluous.

     (c) Inconsistency in the usage of wait queues used for subrequests
     	 (ie. using clear_and_wake_up_bit() whilst waiting on a private
     	 waitqueue).

     	 (Note that waitqueue consistency also needs looking at for
     	 netfs_io_request structs.)

 (2) Add stats counters for retries and publish in /proc/fs/netfs/stats.
     This is not a fix per se, but is useful in debugging and shouldn't
     otherwise change the operation of the code.

 (3) Fix the ordering of queuing subrequests with respect to setting the
     request flag that says we've now queued them all.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

Thanks,
David

David Howells (3):
  netfs: Fix a number of read-retry hangs
  netfs: Add retry stat counters
  netfs: Fix setting NETFS_RREQ_ALL_QUEUED to be after all subreqs
    queued

 fs/netfs/buffered_read.c     | 19 +++++++++++-----
 fs/netfs/internal.h          |  4 ++++
 fs/netfs/read_collect.c      |  6 +++--
 fs/netfs/read_retry.c        | 43 +++++++++++++++++++++++++++---------
 fs/netfs/stats.c             |  9 ++++++++
 fs/netfs/write_issue.c       |  1 +
 fs/netfs/write_retry.c       |  2 ++
 include/linux/netfs.h        |  2 +-
 include/trace/events/netfs.h |  4 +++-
 9 files changed, 70 insertions(+), 20 deletions(-)


