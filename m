Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CCA3683531
	for <lists+linux-cifs@lfdr.de>; Tue, 31 Jan 2023 19:29:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231305AbjAaS3x (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 31 Jan 2023 13:29:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231431AbjAaS3v (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 31 Jan 2023 13:29:51 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4CBE589A6
        for <linux-cifs@vger.kernel.org>; Tue, 31 Jan 2023 10:29:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675189744;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=1skKAMSOcYitXlHWUQzUa5QecINDy3eBArvxadBodVs=;
        b=hvKSoI9sGQHS1cCQxo3LVrycTMd4ppbHsnHl1ZXvQWHIlbtgFRTHCusVoz5I+Fwh6DZE5V
        7Bc7rAGg9E4fKqNFJsyyPQRVIp1gfVBn+goA7jJA1oBTkU5Wj9rTkq4a/bHbdWnG2NvaCX
        zha0aCHG3qphoXL91DZWcaE1h2Zqfks=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-606-clOmH5KrPXC5C5_W2nDGGg-1; Tue, 31 Jan 2023 13:29:00 -0500
X-MC-Unique: clOmH5KrPXC5C5_W2nDGGg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 31BE3811E9C;
        Tue, 31 Jan 2023 18:29:00 +0000 (UTC)
Received: from warthog.procyon.org.uk.com (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 86343C15BAD;
        Tue, 31 Jan 2023 18:28:58 +0000 (UTC)
From:   David Howells <dhowells@redhat.com>
To:     Steve French <smfrench@gmail.com>
Cc:     David Howells <dhowells@redhat.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Tom Talpey <tom@talpey.com>,
        Stefan Metzmacher <metze@samba.org>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>,
        Jeff Layton <jlayton@kernel.org>, linux-cifs@vger.kernel.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 00/12] smb3: Use iov_iters down to the network transport and fix DIO page pinning
Date:   Tue, 31 Jan 2023 18:28:43 +0000
Message-Id: <20230131182855.4027499-1-dhowells@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi Steve,

Here's an updated version of my patchset to make the cifs/smb3 driver pass
iov_iters down to the lowest layers where they can be passed directly to
the network transport rather than passing lists of pages around.

I've fixed a couple of bugs and rebased on top of a merge of my two
iov_iter_extract_pages() patches onto your for-next branch.  The merge is
so that the same commits are used as are in the linux-block tree.

The series also deals with some other issues:

 (*) By pinning pages, it fixes the race between concurrent DIO read and
     fork, whereby the pages containing the DIO read buffer may end up
     belonging to the child process and not the parent - with the result
     that the parent might not see the retrieved data.

 (*) cifs shouldn't take refs on pages extracted from non-user-backed
     iterators (eg. KVEC).  With these changes, cifs will apply the
     appropriate cleanup.  Note that there is the possibility the network
     transport might, but that's beyond the scope of this patchset.

 (*) Making it easier to transition to using folios in cifs rather than
     pages by dealing with them through BVEC and XARRAY iterators.


The first couple of patches to provide function to pin or leave unpinned
the pages from an iterator (and not take a ref on them).

 (1) Define qualifying flags for extraction functions.

 (2) Define iov_iter_extract_pages() to do the extraction and
     iov_iter_extract_will_pin() to indicate how it should be cleaned up.

Then there are a couple of patches that add stuff to netfslib that I want
to use there as well as in cifs:

 (3) Add a netfslib function to extract and pin pages from an ITER_IOBUF or
     ITER_UBUF iterator into an ITER_BVEC iterator.

 (4) Add a netfslib function to extract pages from an iterator that's of
     type ITER_UBUF/IOVEC/BVEC/KVEC/XARRAY and add them to a scatterlist.
     The cleanup will need to be done as for iov_iter_extract_pages().

     BVEC, KVEC and XARRAY iterators can be rendered into elements that
     span multiple pages.

Then a fix:

 (5) Fix oops due to uncleared server->smbd_conn in reconnect

Then there are some cifs helpers that work with iterators:

 (6) Implement cifs_splice_read() to use an ITER_BVEC rather than an
     ITER_PIPE, bulk-allocating the pages, attaching them to the bvec,
     doing the I/O and then pushing the pages into the pipe.  This avoids
     the problem with cifs wanting to split the pipe iterator in a later
     patch.

 (7) Add a function to walk through an ITER_BVEC/KVEC/XARRAY iterator and
     add elements to an RDMA SGE list.  Only the DMA addresses are stored,
     and an element may span multiple pages (say if an xarray contains a
     multipage folio).

 (8) Add a function to walk through an ITER_BVEC/KVEC/XARRAY iterator and
     pass the contents into a shash function.

 (9) Add functions to walk through an ITER_XARRAY iterator and perform
     various sorts of cleanup on the folios held therein, to be used on I/O
     completion.

(10) Add a function to read from the transport TCP socket directly into an
     iterator.

Then come the patches that actually do the work of iteratorising cifs:

(11) The main patch.  Replace page lists with iterators.  It extracts the
     pages from ITER_UBUF and ITER_IOVEC iterators to an ITER_BVEC
     iterator, pinning or getting refs on them, before passing them down as
     the I/O may be done from a worker thread.

     The iterator is extracted into a scatterlist in order to talk to the
     crypto interface or to do RDMA.

(12) In the cifs RDMA code, extract the iterator into an RDMA SGE[] list,
     removing the scatterlist intermediate - at least for smbd_send().
     There appear to be other ways for cifs to talk to the RDMA layer that
     don't go through that that I haven't managed to work out.

(13) Remove a chunk of now-unused code.

(14) Fix a problem with encrypted RDMA data read.

(15) Allow DIO to/from KVEC-type iterators.

I've pushed the patches here also:

	https://git.kernel.org/pub/scm/linux/kernel/git/dhowells/linux-fs.git/log/?h=iov-cifs

David

Link: https://lore.kernel.org/r/166697254399.61150.1256557652599252121.stgit@warthog.procyon.org.uk/

David Howells (12):
  netfs: Add a function to extract a UBUF or IOVEC into a BVEC iterator
  netfs: Add a function to extract an iterator into a scatterlist
  cifs: Implement splice_read to pass down ITER_BVEC not ITER_PIPE
  cifs: Add a function to build an RDMA SGE list from an iterator
  cifs: Add a function to Hash the contents of an iterator
  cifs: Add some helper functions
  cifs: Add a function to read into an iter from a socket
  cifs: Change the I/O paths to use an iterator rather than a page list
  cifs: Build the RDMA SGE list directly from an iterator
  cifs: Remove unused code
  cifs: Fix problem with encrypted RDMA data read
  cifs: DIO to/from KVEC-type iterators should now work

 fs/cifs/Kconfig       |    1 +
 fs/cifs/cifsencrypt.c |  172 +++-
 fs/cifs/cifsfs.c      |   12 +-
 fs/cifs/cifsfs.h      |    6 +
 fs/cifs/cifsglob.h    |   66 +-
 fs/cifs/cifsproto.h   |   11 +-
 fs/cifs/cifssmb.c     |   15 +-
 fs/cifs/connect.c     |   14 +
 fs/cifs/file.c        | 1848 +++++++++++++++++++----------------------
 fs/cifs/fscache.c     |   22 +-
 fs/cifs/fscache.h     |   10 +-
 fs/cifs/misc.c        |  128 +--
 fs/cifs/smb2ops.c     |  365 ++++----
 fs/cifs/smb2pdu.c     |   53 +-
 fs/cifs/smbdirect.c   |  535 +++++++-----
 fs/cifs/smbdirect.h   |    7 +-
 fs/cifs/transport.c   |   54 +-
 fs/netfs/Makefile     |    1 +
 fs/netfs/iterator.c   |  371 +++++++++
 fs/splice.c           |    1 +
 include/linux/netfs.h |    6 +
 mm/vmalloc.c          |    1 +
 22 files changed, 2013 insertions(+), 1686 deletions(-)
 create mode 100644 fs/netfs/iterator.c

