Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D477D21DBB9
	for <lists+linux-cifs@lfdr.de>; Mon, 13 Jul 2020 18:28:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729593AbgGMQ16 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 13 Jul 2020 12:27:58 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40467 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729846AbgGMQ15 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 13 Jul 2020 12:27:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594657676;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=GPqCyKmxk5bmr4GI6eZ9r8X5VU2eAhQ5GXlXXDbYfyQ=;
        b=Ergay/3FG9dJRs6g+g1nklu1911xcNDVFRocLoiAbfbEYWHq7fgd8drdBw3QYNFjxlu6JF
        qTqAdAXEhJBiTNACfLxkpXjePhc56Nm1g2PbguoInaPk96ML9Jip1+JCBa4QyXQTtsSDOK
        CiI8Rr2O3BAvzC4+BmzpZ7hqyhRyr+8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-30-UbkhdcJiO76QhtJmUg1Lqw-1; Mon, 13 Jul 2020 12:27:53 -0400
X-MC-Unique: UbkhdcJiO76QhtJmUg1Lqw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9EF7D18FF665;
        Mon, 13 Jul 2020 16:27:50 +0000 (UTC)
Received: from warthog.procyon.org.uk (ovpn-112-113.rdu2.redhat.com [10.10.112.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A6DCE1CA;
        Mon, 13 Jul 2020 16:27:44 +0000 (UTC)
Subject: [PATCH 00/14] fscache: Rewrite 1: Disable and clean in preparation
 for rewrite
From:   David Howells <dhowells@redhat.com>
To:     Trond Myklebust <trondmy@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Jeff Layton <jlayton@redhat.com>,
        Dave Wysochanski <dwysocha@redhat.com>, dhowells@redhat.com,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Mon, 13 Jul 2020 17:27:43 +0100
Message-ID: <159465766378.1376105.11619976251039287525.stgit@warthog.procyon.org.uk>
User-Agent: StGit/0.22
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org


Here's a set of patches that disables the network filesystems that use
fscache and then remove a whole chunk of the fscache codebase pending it
being rewritten.

The following parts of fscache have been removed:

    - The object state machine
    - The I/O operation manager
    - All non-transient references from fscache to the netfs's data
    - All non-transient callbacks from fscache to the netfs
    - The backing page I/O monitoring
    - The tracking of netfs pages that fscache knows about
    - The tracking of netfs pages that need writing to the cache
    - The use of bmap to work out if a page is stored in the cache
    - The copy of data to/from backing pages to netfs pages.

The corresponding cachefiles bits have also been removed.

These patches can be found as part of the branch here:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=fscache-iter

David
---
David Howells (1):
      fscache: Remove the I/O operation manager


 fs/9p/Kconfig                          |    2 +-
 fs/Makefile                            |    2 +-
 fs/afs/Kconfig                         |    1 +
 fs/afs/cache.c                         |   54 --
 fs/afs/cell.c                          |    9 +-
 fs/afs/dir.c                           |  242 +++++--
 fs/afs/file.c                          |  575 +++++++--------
 fs/afs/fs_operation.c                  |    4 +-
 fs/afs/fsclient.c                      |  154 ++--
 fs/afs/inode.c                         |   57 +-
 fs/afs/internal.h                      |   58 +-
 fs/afs/rxrpc.c                         |  150 ++--
 fs/afs/volume.c                        |    9 +-
 fs/afs/write.c                         |  413 +++++++----
 fs/afs/yfsclient.c                     |  113 ++-
 fs/cachefiles/Makefile                 |    3 +-
 fs/cachefiles/bind.c                   |   11 +-
 fs/cachefiles/content-map.c            |  476 ++++++++++++
 fs/cachefiles/daemon.c                 |   10 +-
 fs/cachefiles/interface.c              |  564 ++++++++-------
 fs/cachefiles/internal.h               |  139 ++--
 fs/cachefiles/io.c                     |  279 +++++++
 fs/cachefiles/main.c                   |   12 +-
 fs/cachefiles/namei.c                  |  508 +++++--------
 fs/cachefiles/rdwr.c                   |  974 -------------------------
 fs/cachefiles/xattr.c                  |  263 +++----
 fs/ceph/Kconfig                        |    2 +-
 fs/cifs/Kconfig                        |    2 +-
 fs/fscache/Kconfig                     |    8 +
 fs/fscache/Makefile                    |   10 +-
 fs/fscache/cache.c                     |  136 ++--
 fs/fscache/cookie.c                    |  769 ++++++++------------
 fs/fscache/dispatcher.c                |  150 ++++
 fs/fscache/fsdef.c                     |   56 +-
 fs/fscache/histogram.c                 |    2 +-
 fs/fscache/internal.h                  |  260 +++----
 fs/fscache/io.c                        |  201 +++++
 fs/fscache/main.c                      |   35 +-
 fs/fscache/netfs.c                     |   10 +-
 fs/fscache/obj.c                       |  345 +++++++++
 fs/fscache/object-list.c               |  129 +---
 fs/fscache/object.c                    | 1133 -----------------------------
 fs/fscache/object_bits.c               |  120 +++
 fs/fscache/operation.c                 |  633 ----------------
 fs/fscache/page.c                      | 1248 --------------------------------
 fs/fscache/proc.c                      |   13 +-
 fs/fscache/read_helper.c               |  688 ++++++++++++++++++
 fs/fscache/stats.c                     |  265 +++----
 fs/internal.h                          |    5 -
 fs/nfs/Kconfig                         |    2 +-
 fs/nfs/fscache-index.c                 |    4 +-
 fs/read_write.c                        |    1 +
 include/linux/fs.h                     |    2 +
 include/linux/fscache-cache.h          |  508 +++----------
 include/linux/fscache-obsolete.h       |   13 +
 include/linux/fscache.h                |  814 ++++++++-------------
 include/linux/mm.h                     |    1 +
 include/linux/pagemap.h                |   14 +
 include/linux/uio.h                    |   11 +
 include/net/af_rxrpc.h                 |    2 +-
 include/trace/events/afs.h             |   51 +-
 include/trace/events/cachefiles.h      |  285 ++++++--
 include/trace/events/fscache.h         |  421 ++---------
 include/trace/events/fscache_support.h |   91 +++
 lib/iov_iter.c                         |  286 +++++++-
 mm/filemap.c                           |   27 +-
 net/rxrpc/recvmsg.c                    |    9 +-
 67 files changed, 5598 insertions(+), 8246 deletions(-)
 create mode 100644 fs/cachefiles/content-map.c
 create mode 100644 fs/cachefiles/io.c
 delete mode 100644 fs/cachefiles/rdwr.c
 create mode 100644 fs/fscache/dispatcher.c
 create mode 100644 fs/fscache/io.c
 create mode 100644 fs/fscache/obj.c
 delete mode 100644 fs/fscache/object.c
 create mode 100644 fs/fscache/object_bits.c
 delete mode 100644 fs/fscache/operation.c
 delete mode 100644 fs/fscache/page.c
 create mode 100644 fs/fscache/read_helper.c
 create mode 100644 include/linux/fscache-obsolete.h
 create mode 100644 include/trace/events/fscache_support.h


