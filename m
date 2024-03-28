Return-Path: <linux-cifs+bounces-1660-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D0AF3890672
	for <lists+linux-cifs@lfdr.de>; Thu, 28 Mar 2024 17:59:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E641C30662
	for <lists+linux-cifs@lfdr.de>; Thu, 28 Mar 2024 16:59:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C04232189;
	Thu, 28 Mar 2024 16:59:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OL72U69E"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4B8C1DDEB
	for <linux-cifs@vger.kernel.org>; Thu, 28 Mar 2024 16:58:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711645140; cv=none; b=pYa5Wzl1Vvtiex4EsGEZZ+ox823KK3E0nOSRrfG1BwNLmfYcKR2b865OFq4yv9joRlw7iPWyT800orijFJ0DFqylvXukmbmsn1v516oSMvMUbbKLHq2f7dye6qSH6gofK9mzg/MiVx8ZL7aVoN9Qs/uyM1fODk4gX0P1sL5T5y4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711645140; c=relaxed/simple;
	bh=apCXXFZ6j3TcjCJV2Cam6vpg1nsRKdd8BKx/sY8Vqwc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GnVztnRkK2sD4SJvxQSDn+v/nEoSCAei/yKlLqLD3rFc8u/Od+V5z3MfLpH3wdi5xAox12IjYj6nmMe92UsAtMAA44wynupzJnXBnWOeTZVs6OrxGz3pWlkJVNEpnXLmZOOFMnkaPsY2zteCsLzP3+Y107q4vQ71MpslosgyEMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OL72U69E; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711645137;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=jiVas1tSBjQdCIB/ofa+v43rtug1Sw6ETjtuvBUyvtU=;
	b=OL72U69EMwQ/hlC2r1aZVbz7hxZoQs9tv24yChknPuLMilFykQjFBhZRGHgqDC9Rs8gmmW
	N4Ax1zwm8/s1kvK2wUvqUTc9xCx7ZfafTH+p2Xu1ToFcHIgRiInm5ir1WmtytSHpq84dgt
	8YRcN3c5h6l0l4i69nkJEJ2FsfMFfVE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-_lsKnMXBNLeQiQjtN82f-g-1; Thu,
 28 Mar 2024 12:58:54 -0400
X-MC-Unique: _lsKnMXBNLeQiQjtN82f-g-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 051F63C01C19;
	Thu, 28 Mar 2024 16:58:54 +0000 (UTC)
Received: from warthog.procyon.org.com (unknown [10.42.28.146])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 622EDC4C7A1;
	Thu, 28 Mar 2024 16:58:52 +0000 (UTC)
From: David Howells <dhowells@redhat.com>
To: Steve French <smfrench@gmail.com>
Cc: David Howells <dhowells@redhat.com>,
	Jeff Layton <jlayton@kernel.org>,
	Matthew Wilcox <willy@infradead.org>,
	Paulo Alcantara <pc@manguebit.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Christian Brauner <christian@brauner.io>,
	netfs@lists.linux.dev,
	linux-cifs@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	linux-mm@kvack.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 00/15] netfs, cifs: Delegate high-level I/O to netfslib
Date: Thu, 28 Mar 2024 16:57:51 +0000
Message-ID: <20240328165845.2782259-1-dhowells@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8

Hi Steve,

Here are patches to convert cifs to use the netfslib library.  I've tested
them with and without a cache.  Unfortunately, if "-o fsc" is specified a leak
of a tcon object shows up, particularly with the generic/013 xfstest that
prevents further testing.  I've investigated this and found that the tcon leak
is actually present upstream, but just goes unnoticed unless it also pins an
fscache volume cookie.

The patches remove around 2000 lines from CIFS.

Notes:

 (1) CIFS is made to use unbuffered I/O for unbuffered caching modes and
     write-through caching for cache=strict.

 (2) Various cifs fallocate() function implementations have issues that
     aren't easily fixed without enhanced protocol support.

 (3) It should be possible to turn on multipage folio support in CIFS now.

 (4) The then-unused CIFS code is removed in three patches, not one, to
     avoid the git patch generator from producing confusing patches in
     which it thinks code is being moved around rather than just being
     removed.

The patches can be found here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=cifs-netfs

Changes
=======
ver #6)
 - The netfslib write helpers got rewritten and, consequently, some changes
   were made here.
 - Rearranged the patch order a little to put the smaller changes first.
 - Use a different way to invalidate that doesn't use ->launder_folio().
 - Attempt to open the handle on the server READ+WRITE, even if the user
   asks for O_WRONLY, if the mount was with "-o fsc" so that we can fill in
   the gaps in partial folio writes; if we can't fall back to WRITE-only
   and disable caching.
 - Fixed the cookie key to match the key used by iget5_locked() to avoid
   "Duplicate cookie" errors.
 - Made add_credits_and_wake_if() clear the number of returned credits,
   allowing it to be called multiple times in cleanup/error handling.
 - Made ->async_writev() not return an error directly, but always set it on
   the subreq.
 - Fixed error handling from writethrough writing.

ver #5)
 - Rebased to -rc3 plus SteveF's for-next branch as netfslib is now
   upstream, as are a couple of patches from this series.
 - Replace the ->replay bool Shyam added with a flag on the netfs
   subrequest.  This is tested by the code, but not currently set (see
   above).

ver #4)
 - Slimmed down the branch:
   - Split the cifs-related patches off to a separate branch (cifs-netfs)
   - Deferred the content-encryption to the in-progress ceph changes.
   - Deferred the use-PG_writeback rather than PG_fscache patch
 - Rebased on a later linux-next with afs-rotation patches.

ver #3)
 - Moved the fscache module into netfslib to avoid export cycles.
 - Fixed a bunch of bugs.
 - Got CIFS to pass as much of xfstests as possible.
 - Added a patch to make 9P use all the helpers.
 - Added a patch to stop using PG_fscache, but rather dirty pages on
   reading and have writepages write to the cache.

ver #2)
 - Folded the addition of NETFS_RREQ_NONBLOCK/BLOCKED into first patch that
   uses them.
 - Folded addition of rsize member into first user.
 - Don't set rsize in ceph (yet) and set it in kafs to 256KiB.  cifs sets
   it dynamically.
 - Moved direct_bv next to direct_bv_count in struct netfs_io_request and
   labelled it with a __counted_by().
 - Passed flags into netfs_xa_store_and_mark() rather than two bools.
 - Removed netfs_set_up_buffer() as it wasn't used.

David

Link: https://lore.kernel.org/r/20231213152350.431591-1-dhowells@redhat.com/ [1]
Link: https://lore.kernel.org/r/20231013160423.2218093-1-dhowells@redhat.com/ # v1
Link: https://lore.kernel.org/r/20231117211544.1740466-1-dhowells@redhat.com/ # v2
Link: https://lore.kernel.org/r/20231207212206.1379128-1-dhowells@redhat.com/ # v3
Link: https://lore.kernel.org/r/20231213154139.432922-1-dhowells@redhat.com/ # v4
Link: https://lore.kernel.org/r/20240205225726.3104808-1-dhowells@redhat.com/ # v5

David Howells (15):
  cifs: Replace cifs_readdata with a wrapper around netfs_io_subrequest
  cifs: Replace cifs_writedata with a wrapper around netfs_io_subrequest
  cifs: Use more fields from netfs_io_subrequest
  cifs: Make wait_mtu_credits take size_t args
  cifs: Replace the writedata replay bool with a netfs sreq flag
  cifs: Move cifs_loose_read_iter() and cifs_file_write_iter() to file.c
  cifs: Set zero_point in the copy_file_range() and remap_file_range()
  cifs: Add mempools for cifs_io_request and cifs_io_subrequest structs
  cifs: Make add_credits_and_wake_if() clear deducted credits
  cifs: Implement netfslib hooks
  cifs: When caching, try to open O_WRONLY file rdwr on server
  cifs: Cut over to using netfslib
  cifs: Remove some code that's no longer used, part 1
  cifs: Remove some code that's no longer used, part 2
  cifs: Remove some code that's no longer used, part 3

 fs/netfs/buffered_write.c    |    6 +
 fs/netfs/io.c                |    7 +-
 fs/smb/client/Kconfig        |    1 +
 fs/smb/client/cifsfs.c       |  124 +-
 fs/smb/client/cifsfs.h       |   10 +-
 fs/smb/client/cifsglob.h     |   65 +-
 fs/smb/client/cifsproto.h    |   12 +-
 fs/smb/client/cifssmb.c      |  120 +-
 fs/smb/client/dir.c          |   15 +
 fs/smb/client/file.c         | 2841 ++++++----------------------------
 fs/smb/client/fscache.c      |  109 --
 fs/smb/client/fscache.h      |   54 +-
 fs/smb/client/inode.c        |   19 +-
 fs/smb/client/smb2ops.c      |   10 +-
 fs/smb/client/smb2pdu.c      |  186 ++-
 fs/smb/client/smb2proto.h    |    5 +-
 fs/smb/client/trace.h        |  144 +-
 fs/smb/client/transport.c    |   17 +-
 include/linux/netfs.h        |    1 +
 include/trace/events/netfs.h |    1 +
 20 files changed, 946 insertions(+), 2801 deletions(-)


