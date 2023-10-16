Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E862E7CADD6
	for <lists+linux-cifs@lfdr.de>; Mon, 16 Oct 2023 17:43:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjJPPnL (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 16 Oct 2023 11:43:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231508AbjJPPnK (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 16 Oct 2023 11:43:10 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 90CCAE6;
        Mon, 16 Oct 2023 08:43:08 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 70438C433C9;
        Mon, 16 Oct 2023 15:43:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697470988;
        bh=YQSftXDjlX2jFmFmLwmBjWy0+Qa2LejmfwOCODfHmbA=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=UD94NMhbAF0Hn1+u54/EiSInIpU2roomIDJ5upRsOMwiD4gpbndghYR0Y3z/fv+4c
         n4RR0XUcaGCV89ZTPYhcNgqO1pzHheP28GSQknY0DyiLSf2evkv3sUV85BJr1YFviP
         MWbvFXCBei0EDjy7na4F6lkyEd6BpjIflzijk2BSo5n64vyvFUKUaywLeMgxM6c7Rt
         Z7UZn8+coDOKKDanrSAqOmPEgCwOuy9Y2hJJXS82+jQlA/Zvf9E31UGGdpKBiyMzhj
         WhpkDThHBqGqaCh9truLhLS1Yn9oJHo701osnpf3pIFjG/1CAVk74vRPJx13IigKTT
         GrIkgpaY8NKdw==
Message-ID: <11ec6f637698feb04963c6a7c39a5ca80af95464.camel@kernel.org>
Subject: Re: [RFC PATCH 02/53] netfs: Track the fpos above which the server
 has no data
From:   Jeff Layton <jlayton@kernel.org>
To:     David Howells <dhowells@redhat.com>,
        Steve French <smfrench@gmail.com>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Marc Dionne <marc.dionne@auristor.com>,
        Paulo Alcantara <pc@manguebit.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
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
Date:   Mon, 16 Oct 2023 11:43:05 -0400
In-Reply-To: <20231013155727.2217781-3-dhowells@redhat.com>
References: <20231013155727.2217781-1-dhowells@redhat.com>
         <20231013155727.2217781-3-dhowells@redhat.com>
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

On Fri, 2023-10-13 at 16:56 +0100, David Howells wrote:
> Track the file position above which the server is not expected to have an=
y
> data and preemptively assume that we can simply fill blocks with zeroes
> locally rather than attempting to download them - even if we've written
> data back to the server.  Assume that any data that was written back abov=
e
> that position is held in the local cache.  Call this the "zero point".
>=20
> Make use of this to optimise away some reads from the server.  We need to
> set the zero point in the following circumstances:
>=20
>  (1) When we see an extant remote inode and have no cache for it, we set
>      the zero_point to i_size.
>=20
>  (2) On local inode creation, we set zero_point to 0.
>=20
>  (3) On local truncation down, we reduce zero_point to the new i_size if
>      the new i_size is lower.
>=20
>  (4) On local truncation up, we don't change zero_point.
>=20
>  (5) On local modification, we don't change zero_point.
>=20
>  (6) On remote invalidation, we set zero_point to the new i_size.
>=20
>  (7) If stored data is culled from the local cache, we must set zero_poin=
t
>      above that if the data also got written to the server.
>=20

When you say culled here, it sounds like you're just throwing out the
dirty cache without writing the data back. That shouldn't be allowed
though, so I must be misunderstanding what you mean here. Can you
explain?

>  (8) If dirty data is written back to the server, but not the local cache=
,
>      we must set zero_point above that.
>=20

How do you write back without writing to the local cache? I'm guessing
this means you're doing a non-buffered write?

> Assuming the above, any read from the server at or above the zero_point
> position will return all zeroes.
>=20
> The zero_point value can be stored in the cache, provided the above rules
> are applied to it by any code that culls part of the local cache.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/afs/inode.c           | 13 +++++++------
>  fs/netfs/buffered_read.c | 40 +++++++++++++++++++++++++---------------
>  include/linux/netfs.h    |  5 +++++
>  3 files changed, 37 insertions(+), 21 deletions(-)
>=20
> diff --git a/fs/afs/inode.c b/fs/afs/inode.c
> index 1c794a1896aa..46bc5574d6f5 100644
> --- a/fs/afs/inode.c
> +++ b/fs/afs/inode.c
> @@ -252,6 +252,7 @@ static void afs_apply_status(struct afs_operation *op=
,
>  		vnode->netfs.remote_i_size =3D status->size;
>  		if (change_size) {
>  			afs_set_i_size(vnode, status->size);
> +			vnode->netfs.zero_point =3D status->size;
>  			inode_set_ctime_to_ts(inode, t);
>  			inode->i_atime =3D t;
>  		}
> @@ -865,17 +866,17 @@ static void afs_setattr_success(struct afs_operatio=
n *op)
>  static void afs_setattr_edit_file(struct afs_operation *op)
>  {
>  	struct afs_vnode_param *vp =3D &op->file[0];
> -	struct inode *inode =3D &vp->vnode->netfs.inode;
> +	struct afs_vnode *vnode =3D vp->vnode;
> =20
>  	if (op->setattr.attr->ia_valid & ATTR_SIZE) {
>  		loff_t size =3D op->setattr.attr->ia_size;
>  		loff_t i_size =3D op->setattr.old_i_size;
> =20
> -		if (size < i_size)
> -			truncate_pagecache(inode, size);
> -		if (size !=3D i_size)
> -			fscache_resize_cookie(afs_vnode_cache(vp->vnode),
> -					      vp->scb.status.size);
> +		if (size !=3D i_size) {
> +			truncate_pagecache(&vnode->netfs.inode, size);
> +			netfs_resize_file(&vnode->netfs, size);
> +			fscache_resize_cookie(afs_vnode_cache(vnode), size);
> +		}

Isn't this an existing bug? AFS is not setting remote_i_size in the
setattr path currently? I think this probably ought to be done in a
preliminary AFS patch.

>
>  	}
>  }
> =20
> diff --git a/fs/netfs/buffered_read.c b/fs/netfs/buffered_read.c
> index 2cd3ccf4c439..a2852fa64ad0 100644
> --- a/fs/netfs/buffered_read.c
> +++ b/fs/netfs/buffered_read.c
> @@ -147,6 +147,22 @@ static void netfs_rreq_expand(struct netfs_io_reques=
t *rreq,
>  	}
>  }
> =20
> +/*
> + * Begin an operation, and fetch the stored zero point value from the co=
okie if
> + * available.
> + */
> +static int netfs_begin_cache_operation(struct netfs_io_request *rreq,
> +				       struct netfs_inode *ctx)
> +{
> +	int ret =3D -ENOBUFS;
> +
> +	if (ctx->ops->begin_cache_operation) {
> +		ret =3D ctx->ops->begin_cache_operation(rreq);
> +		/* TODO: Get the zero point value from the cache */
> +	}
> +	return ret;
> +}
> +
>  /**
>   * netfs_readahead - Helper to manage a read request
>   * @ractl: The description of the readahead request
> @@ -180,11 +196,9 @@ void netfs_readahead(struct readahead_control *ractl=
)
>  	if (IS_ERR(rreq))
>  		return;
> =20
> -	if (ctx->ops->begin_cache_operation) {
> -		ret =3D ctx->ops->begin_cache_operation(rreq);
> -		if (ret =3D=3D -ENOMEM || ret =3D=3D -EINTR || ret =3D=3D -ERESTARTSYS=
)
> -			goto cleanup_free;
> -	}
> +	ret =3D netfs_begin_cache_operation(rreq, ctx);
> +	if (ret =3D=3D -ENOMEM || ret =3D=3D -EINTR || ret =3D=3D -ERESTARTSYS)
> +		goto cleanup_free;
> =20
>  	netfs_stat(&netfs_n_rh_readahead);
>  	trace_netfs_read(rreq, readahead_pos(ractl), readahead_length(ractl),
> @@ -238,11 +252,9 @@ int netfs_read_folio(struct file *file, struct folio=
 *folio)
>  		goto alloc_error;
>  	}
> =20
> -	if (ctx->ops->begin_cache_operation) {
> -		ret =3D ctx->ops->begin_cache_operation(rreq);
> -		if (ret =3D=3D -ENOMEM || ret =3D=3D -EINTR || ret =3D=3D -ERESTARTSYS=
)
> -			goto discard;
> -	}
> +	ret =3D netfs_begin_cache_operation(rreq, ctx);
> +	if (ret =3D=3D -ENOMEM || ret =3D=3D -EINTR || ret =3D=3D -ERESTARTSYS)
> +		goto discard;
> =20
>  	netfs_stat(&netfs_n_rh_readpage);
>  	trace_netfs_read(rreq, rreq->start, rreq->len, netfs_read_trace_readpag=
e);
> @@ -390,11 +402,9 @@ int netfs_write_begin(struct netfs_inode *ctx,
>  	rreq->no_unlock_folio	=3D folio_index(folio);
>  	__set_bit(NETFS_RREQ_NO_UNLOCK_FOLIO, &rreq->flags);
> =20
> -	if (ctx->ops->begin_cache_operation) {
> -		ret =3D ctx->ops->begin_cache_operation(rreq);
> -		if (ret =3D=3D -ENOMEM || ret =3D=3D -EINTR || ret =3D=3D -ERESTARTSYS=
)
> -			goto error_put;
> -	}
> +	ret =3D netfs_begin_cache_operation(rreq, ctx);
> +	if (ret =3D=3D -ENOMEM || ret =3D=3D -EINTR || ret =3D=3D -ERESTARTSYS)
> +		goto error_put;
> =20
>  	netfs_stat(&netfs_n_rh_write_begin);
>  	trace_netfs_read(rreq, pos, len, netfs_read_trace_write_begin);
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index b447cb67f599..282511090ead 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -129,6 +129,8 @@ struct netfs_inode {
>  	struct fscache_cookie	*cache;
>  #endif
>  	loff_t			remote_i_size;	/* Size of the remote file */
> +	loff_t			zero_point;	/* Size after which we assume there's no data
> +						 * on the server */

While I understand the concept, I'm not yet sure I understand how this
new value will be used. It might be better to merge this patch in with
the patch that adds the first user of this data.

>  };
> =20
>  /*
> @@ -330,6 +332,7 @@ static inline void netfs_inode_init(struct netfs_inod=
e *ctx,
>  {
>  	ctx->ops =3D ops;
>  	ctx->remote_i_size =3D i_size_read(&ctx->inode);
> +	ctx->zero_point =3D ctx->remote_i_size;
>  #if IS_ENABLED(CONFIG_FSCACHE)
>  	ctx->cache =3D NULL;
>  #endif
> @@ -345,6 +348,8 @@ static inline void netfs_inode_init(struct netfs_inod=
e *ctx,
>  static inline void netfs_resize_file(struct netfs_inode *ctx, loff_t new=
_i_size)
>  {
>  	ctx->remote_i_size =3D new_i_size;
> +	if (new_i_size < ctx->zero_point)
> +		ctx->zero_point =3D new_i_size;
>  }
> =20
>  /**
>=20

--=20
Jeff Layton <jlayton@kernel.org>
