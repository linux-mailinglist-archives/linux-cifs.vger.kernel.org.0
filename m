Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 074307CAE5F
	for <lists+linux-cifs@lfdr.de>; Mon, 16 Oct 2023 17:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229633AbjJPP5E (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 16 Oct 2023 11:57:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232575AbjJPP5C (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 16 Oct 2023 11:57:02 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A69F083;
        Mon, 16 Oct 2023 08:57:00 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 994FEC433C8;
        Mon, 16 Oct 2023 15:56:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697471820;
        bh=LRmes5MLl5dWv57CxNhPlJqvUNYKl0hSV5rfkr1Vtgg=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=e+qNg02Y1X2PsoSaDDLSmRhKNWO0uNT4D0fQ6hgBlOFqOx/B5fgH3QEkZGwAww6KQ
         DSkLRRd/0wgCzLMWY0IRMzDzTcr2+l+X0to81Z1pyzkqx7kSuDhXXe1lL4a7GolyvT
         O1Bkufgwdlaoy0JtMZQJ0FJjMunJbA6DuXE2iRWTmsffhPWO6rmhV1x3XGHwpYBJSZ
         jHs4W/K+A+ThYLNDS5QiBoOGTShHxpGzlyiRmr7UREcfFwIzn+BDfqxTnBDpPvPHEw
         2ZSdUGMj4tHrkK46pW+b1Z5EYv518ECyJo+b3JKvk4w7WuvsJDreWfpGTVQ2jihZlr
         WC6d3Z297CeIA==
Message-ID: <e1351696345351cb3d168fb41c54a1ef8ccf0b16.camel@kernel.org>
Subject: Re: [RFC PATCH 09/53] netfs: Implement unbuffered/DIO vs buffered
 I/O locking
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Tom Talpey <tom@talpey.com>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        Christian Brauner <christian@brauner.io>,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org,
        linux-mm@kvack.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-cachefs@redhat.com
Date:   Mon, 16 Oct 2023 11:56:57 -0400
In-Reply-To: <20231013160423.2218093-10-dhowells@redhat.com>
References: <20231013160423.2218093-1-dhowells@redhat.com>
         <20231013160423.2218093-10-dhowells@redhat.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.4 (3.48.4-1.fc38) 
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Fri, 2023-10-13 at 17:03 +0100, David Howells wrote:
> Borrow NFS's direct-vs-buffered I/O locking into netfslib.  Similar code =
is
> also used in ceph.
>=20
> Modify it to have the correct checker annotations for i_rwsem lock
> acquisition/release and to return -ERESTARTSYS if waits are interrupted.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/netfs/Makefile     |   1 +
>  fs/netfs/locking.c    | 209 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/netfs.h |  10 ++
>  3 files changed, 220 insertions(+)
>  create mode 100644 fs/netfs/locking.c
>=20
> diff --git a/fs/netfs/Makefile b/fs/netfs/Makefile
> index cd22554d9048..647ce1935674 100644
> --- a/fs/netfs/Makefile
> +++ b/fs/netfs/Makefile
> @@ -4,6 +4,7 @@ netfs-y :=3D \
>  	buffered_read.o \
>  	io.o \
>  	iterator.o \
> +	locking.o \
>  	main.o \
>  	misc.o \
>  	objects.o
> diff --git a/fs/netfs/locking.c b/fs/netfs/locking.c
> new file mode 100644
> index 000000000000..fecca8ea6322
> --- /dev/null
> +++ b/fs/netfs/locking.c
> @@ -0,0 +1,209 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * I/O and data path helper functionality.
> + *
> + * Borrowed from NFS Copyright (c) 2016 Trond Myklebust
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/netfs.h>
> +
> +/*
> + * inode_dio_wait_interruptible - wait for outstanding DIO requests to f=
inish
> + * @inode: inode to wait for
> + *
> + * Waits for all pending direct I/O requests to finish so that we can
> + * proceed with a truncate or equivalent operation.
> + *
> + * Must be called under a lock that serializes taking new references
> + * to i_dio_count, usually by inode->i_mutex.
> + */
> +static int inode_dio_wait_interruptible(struct inode *inode)
> +{
> +	if (!atomic_read(&inode->i_dio_count))
> +		return 0;
> +
> +	wait_queue_head_t *wq =3D bit_waitqueue(&inode->i_state, __I_DIO_WAKEUP=
);
> +	DEFINE_WAIT_BIT(q, &inode->i_state, __I_DIO_WAKEUP);
> +
> +	for (;;) {
> +		prepare_to_wait(wq, &q.wq_entry, TASK_INTERRUPTIBLE);
> +		if (!atomic_read(&inode->i_dio_count))
> +			break;
> +		if (signal_pending(current))
> +			break;
> +		schedule();
> +	}
> +	finish_wait(wq, &q.wq_entry);
> +
> +	return atomic_read(&inode->i_dio_count) ? -ERESTARTSYS : 0;
> +}
> +
> +/* Call with exclusively locked inode->i_rwsem */
> +static int netfs_block_o_direct(struct netfs_inode *ictx)
> +{
> +	if (!test_bit(NETFS_ICTX_ODIRECT, &ictx->flags))
> +		return 0;
> +	clear_bit(NETFS_ICTX_ODIRECT, &ictx->flags);
> +	return inode_dio_wait_interruptible(&ictx->inode);
> +}
> +
> +/**
> + * netfs_start_io_read - declare the file is being used for buffered rea=
ds
> + * @inode: file inode
> + *
> + * Declare that a buffered read operation is about to start, and ensure
> + * that we block all direct I/O.
> + * On exit, the function ensures that the NETFS_ICTX_ODIRECT flag is uns=
et,
> + * and holds a shared lock on inode->i_rwsem to ensure that the flag
> + * cannot be changed.
> + * In practice, this means that buffered read operations are allowed to
> + * execute in parallel, thanks to the shared lock, whereas direct I/O
> + * operations need to wait to grab an exclusive lock in order to set
> + * NETFS_ICTX_ODIRECT.
> + * Note that buffered writes and truncates both take a write lock on
> + * inode->i_rwsem, meaning that those are serialised w.r.t. the reads.
> + */
> +int netfs_start_io_read(struct inode *inode)
> +	__acquires(inode->i_rwsem)
> +{
> +	struct netfs_inode *ictx =3D netfs_inode(inode);
> +
> +	/* Be an optimist! */
> +	if (down_read_interruptible(&inode->i_rwsem) < 0)
> +		return -ERESTARTSYS;
> +	if (test_bit(NETFS_ICTX_ODIRECT, &ictx->flags) =3D=3D 0)
> +		return 0;
> +	up_read(&inode->i_rwsem);
> +
> +	/* Slow path.... */
> +	if (down_write_killable(&inode->i_rwsem) < 0)
> +		return -ERESTARTSYS;
> +	if (netfs_block_o_direct(ictx) < 0) {
> +		up_write(&inode->i_rwsem);
> +		return -ERESTARTSYS;
> +	}
> +	downgrade_write(&inode->i_rwsem);
> +	return 0;
> +}
> +
> +/**
> + * netfs_end_io_read - declare that the buffered read operation is done
> + * @inode: file inode
> + *
> + * Declare that a buffered read operation is done, and release the share=
d
> + * lock on inode->i_rwsem.
> + */
> +void netfs_end_io_read(struct inode *inode)
> +	__releases(inode->i_rwsem)
> +{
> +	up_read(&inode->i_rwsem);
> +}
> +
> +/**
> + * netfs_start_io_write - declare the file is being used for buffered wr=
ites
> + * @inode: file inode
> + *
> + * Declare that a buffered read operation is about to start, and ensure
> + * that we block all direct I/O.
> + */
> +int netfs_start_io_write(struct inode *inode)
> +	__acquires(inode->i_rwsem)
> +{
> +	struct netfs_inode *ictx =3D netfs_inode(inode);
> +
> +	if (down_write_killable(&inode->i_rwsem) < 0)
> +		return -ERESTARTSYS;
> +	if (netfs_block_o_direct(ictx) < 0) {
> +		up_write(&inode->i_rwsem);
> +		return -ERESTARTSYS;
> +	}
> +	return 0;
> +}
> +
> +/**
> + * netfs_end_io_write - declare that the buffered write operation is don=
e
> + * @inode: file inode
> + *
> + * Declare that a buffered write operation is done, and release the
> + * lock on inode->i_rwsem.
> + */
> +void netfs_end_io_write(struct inode *inode)
> +	__releases(inode->i_rwsem)
> +{
> +	up_write(&inode->i_rwsem);
> +}
> +
> +/* Call with exclusively locked inode->i_rwsem */
> +static int netfs_block_buffered(struct inode *inode)
> +{
> +	struct netfs_inode *ictx =3D netfs_inode(inode);
> +	int ret;
> +
> +	if (!test_bit(NETFS_ICTX_ODIRECT, &ictx->flags)) {
> +		set_bit(NETFS_ICTX_ODIRECT, &ictx->flags);
> +		if (inode->i_mapping->nrpages !=3D 0) {
> +			unmap_mapping_range(inode->i_mapping, 0, 0, 0);
> +			ret =3D filemap_fdatawait(inode->i_mapping);
> +			if (ret < 0) {
> +				clear_bit(NETFS_ICTX_ODIRECT, &ictx->flags);
> +				return ret;
> +			}
> +		}
> +	}
> +	return 0;
> +}
> +
> +/**
> + * netfs_start_io_direct - declare the file is being used for direct i/o
> + * @inode: file inode
> + *
> + * Declare that a direct I/O operation is about to start, and ensure
> + * that we block all buffered I/O.
> + * On exit, the function ensures that the NETFS_ICTX_ODIRECT flag is set=
,
> + * and holds a shared lock on inode->i_rwsem to ensure that the flag
> + * cannot be changed.
> + * In practice, this means that direct I/O operations are allowed to
> + * execute in parallel, thanks to the shared lock, whereas buffered I/O
> + * operations need to wait to grab an exclusive lock in order to clear
> + * NETFS_ICTX_ODIRECT.
> + * Note that buffered writes and truncates both take a write lock on
> + * inode->i_rwsem, meaning that those are serialised w.r.t. O_DIRECT.
> + */
> +int netfs_start_io_direct(struct inode *inode)
> +	__acquires(inode->i_rwsem)
> +{
> +	struct netfs_inode *ictx =3D netfs_inode(inode);
> +	int ret;
> +
> +	/* Be an optimist! */
> +	if (down_read_interruptible(&inode->i_rwsem) < 0)
> +		return -ERESTARTSYS;
> +	if (test_bit(NETFS_ICTX_ODIRECT, &ictx->flags) !=3D 0)
> +		return 0;
> +	up_read(&inode->i_rwsem);
> +
> +	/* Slow path.... */
> +	if (down_write_killable(&inode->i_rwsem) < 0)
> +		return -ERESTARTSYS;
> +	ret =3D netfs_block_buffered(inode);
> +	if (ret < 0) {
> +		up_write(&inode->i_rwsem);
> +		return ret;
> +	}
> +	downgrade_write(&inode->i_rwsem);
> +	return 0;
> +}
> +
> +/**
> + * netfs_end_io_direct - declare that the direct i/o operation is done
> + * @inode: file inode
> + *
> + * Declare that a direct I/O operation is done, and release the shared
> + * lock on inode->i_rwsem.
> + */
> +void netfs_end_io_direct(struct inode *inode)
> +	__releases(inode->i_rwsem)
> +{
> +	up_read(&inode->i_rwsem);
> +}
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 02e888c170da..33d4487a91e9 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -131,6 +131,8 @@ struct netfs_inode {
>  	loff_t			remote_i_size;	/* Size of the remote file */
>  	loff_t			zero_point;	/* Size after which we assume there's no data
>  						 * on the server */
> +	unsigned long		flags;
> +#define NETFS_ICTX_ODIRECT	0		/* The file has DIO in progress */
>  };
> =20
>  /*
> @@ -315,6 +317,13 @@ ssize_t netfs_extract_user_iter(struct iov_iter *ori=
g, size_t orig_len,
>  				struct iov_iter *new,
>  				iov_iter_extraction_t extraction_flags);
> =20
> +int netfs_start_io_read(struct inode *inode);
> +void netfs_end_io_read(struct inode *inode);
> +int netfs_start_io_write(struct inode *inode);
> +void netfs_end_io_write(struct inode *inode);
> +int netfs_start_io_direct(struct inode *inode);
> +void netfs_end_io_direct(struct inode *inode);
> +
>  /**
>   * netfs_inode - Get the netfs inode context from the inode
>   * @inode: The inode to query
> @@ -341,6 +350,7 @@ static inline void netfs_inode_init(struct netfs_inod=
e *ctx,
>  	ctx->ops =3D ops;
>  	ctx->remote_i_size =3D i_size_read(&ctx->inode);
>  	ctx->zero_point =3D ctx->remote_i_size;
> +	ctx->flags =3D 0;
>  #if IS_ENABLED(CONFIG_FSCACHE)
>  	ctx->cache =3D NULL;
>  #endif
>=20

It's nice to see this go into common code, but why not go ahead and
convert ceph (and possibly NFS) to use this? Is there any reason not to?

--=20
Jeff Layton <jlayton@kernel.org>
