Return-Path: <linux-cifs+bounces-2606-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C952A95D769
	for <lists+linux-cifs@lfdr.de>; Fri, 23 Aug 2024 22:17:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D9E1F24EA0
	for <lists+linux-cifs@lfdr.de>; Fri, 23 Aug 2024 20:17:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 536D01990D8;
	Fri, 23 Aug 2024 20:08:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="AWmBNrd+"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 985E01990BD
	for <linux-cifs@vger.kernel.org>; Fri, 23 Aug 2024 20:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724443717; cv=none; b=da3q4m7DQAyV4+N0DbfdGwUnKWGOIBLYL8Ylbc4YR1hs5DznKe5iB8BuBJIr+NIt6lAZdkjhJwR+qX9btKfO4giCleMxGIVaC1iDTfcE4/vWXaAaNhlPPy0725KnC2m2lZx6o/W1Nzkc1XZNah3jpArd7I3+0TbR0XpdcB2cR6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724443717; c=relaxed/simple;
	bh=YrT9CEAX6JEor8FmJ3uXOLSmGYuTjFmykV4JUi8B/N4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bNcOdAnfZ/4xNdddxxbGMQIUkjvuuE51KQuPtQR1qCYlri1kegB8vFiEusN9XioVOonj7b8Msl+m1NpSceKVsAC/fFOq8PgcmuQdQs46e8TaWtBPpVTXk2ojCTBNtqXlOdEEpXaaayo+crFLLZd1qU7fNM8ADuEImJZwyKZsYy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=AWmBNrd+; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724443714;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=r0bfxiJNi0CTPgRC64Jy/pg3ljG8HQEqXgSdWA11B9w=;
	b=AWmBNrd+yzVwwMheApxmDCKKpoVKkXHu7axpIGsaIiAoF8cZgefBILRCXUQaR4diBPTqLv
	i5ix+IOB3x4hkGTEM+jFRmji/1QBmc6mkxr671dtSfQXnfQvpIxUcZeRhF8yq5Y/GwuqyS
	kF4p/daNOOf+T21JaZJRHRu45w0SJHE=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-523-lMoEhpcjPI23TPDJT40xdQ-1; Fri,
 23 Aug 2024 16:08:31 -0400
X-MC-Unique: lMoEhpcjPI23TPDJT40xdQ-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1CAA01955D52;
	Fri, 23 Aug 2024 20:08:28 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.42.28.30])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 7838E3001FE5;
	Fri, 23 Aug 2024 20:08:22 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Christian Brauner <christian@brauner.io>,
	Steve French <sfrench@samba.org>
Cc: David Howells <dhowells@redhat.com>,
	Pankaj Raghav <p.raghav@samsung.com>,
	Paulo Alcantara <pc@manguebit.com>,
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
	linux-kernel@vger.kernel.org
Subject: [PATCH 0/9] netfs, cifs: Combined repost of fixes for truncation, DIO read and read-retry
Date: Fri, 23 Aug 2024 21:08:08 +0100
Message-ID: <20240823200819.532106-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4

Hi Christian, Steve,

Firstly, there are some fixes for truncation, netfslib and afs that I
discovered whilst trying Pankaj Raghav's minimum folio order patchset:

 (1) Fix truncate to make it honour AS_RELEASE_ALWAYS in a couple of places
     that got missed.

 (2) Fix duplicated editing of a partially invalidated folio in afs's
     post-setattr edit phase.

 (3) Fix netfs_release_folio() to indicate that the folio is busy if the
     folio is dirty (as does iomap).

 (4) Fix the trimming of a folio that contain streaming-write data when
     truncation occurs into or past that folio

Here's a patch to netfs for short reads:

 (5) Fix netfslib's short read retry to reset the buffer iterator otherwise
     the wrong part of the buffer may get written on.

Here are a couple of fixes to DIO read handling and the retrying of reads,
particularly in relation to cifs.  They have both had some fixes to the
fixes rolled in:

 (6) Fix the missing credit renegotiation in cifs on the retrying of reads.
     The credits we had ended with the original read (or the last retry)
     and to perform a new read we need more credits otherwise the server
     can reject our read with EINVAL.

 (7) Fix the handling of short DIO reads to avoid ENODATA when the read
     retry tries to access a portion of the file after the EOF.

Here's a fix for hole punching in cifs:

 (8) Fix cifs FALLOC_FL_PUNCH_HOLE support as best I can.  If it's going to
     punch a hole in dirty data in the pagecacne, invalidating that data
     may result in the EOF not being moved correctly.  The set-zero and the
     eof-move RPC ops really need compounding to avoid third-party
     interference.

And finally, here's an adjustment to debugging statements:

 (9) Adjust three debugging output statements.  Not strictly a fix, so
     could be dropped.  Including the subreq ID in some extra debug lines
     helps a bit, though.

The patches can also be found here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=netfs-fixes

They're on top of part of Christian's vfs.fixes tree, including the partial
reversion of the commit to replace PG_fscache.

Thanks,
David

David Howells (9):
  mm: Fix missing folio invalidation calls during truncation
  afs: Fix post-setattr file edit to do truncation correctly
  netfs: Fix netfs_release_folio() to say no if folio dirty
  netfs: Fix trimming of streaming-write folios in netfs_inval_folio()
  netfs: Fix missing iterator reset on retry of short read
  cifs: Fix lack of credit renegotiation on read retry
  netfs, cifs: Fix handling of short DIO read
  cifs: Fix FALLOC_FL_PUNCH_HOLE support
  netfs, cifs: Improve some debugging bits

 fs/afs/inode.c           | 11 ++++++---
 fs/netfs/io.c            | 22 +++++++++++------
 fs/netfs/misc.c          | 53 ++++++++++++++++++++++++++++------------
 fs/smb/client/cifsglob.h |  1 +
 fs/smb/client/file.c     | 37 +++++++++++++++++++++++++---
 fs/smb/client/smb2ops.c  | 32 +++++++++++++++++++++---
 fs/smb/client/smb2pdu.c  | 41 +++++++++++++++++++------------
 fs/smb/client/trace.h    |  1 +
 include/linux/netfs.h    |  1 +
 mm/truncate.c            |  4 +--
 10 files changed, 153 insertions(+), 50 deletions(-)


