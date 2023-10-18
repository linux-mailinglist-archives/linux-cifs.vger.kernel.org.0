Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E721E7CE0A2
	for <lists+linux-cifs@lfdr.de>; Wed, 18 Oct 2023 17:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbjJRPDR (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 18 Oct 2023 11:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231901AbjJRPDQ (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 18 Oct 2023 11:03:16 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7D76F7;
        Wed, 18 Oct 2023 08:03:13 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF3E9C433C8;
        Wed, 18 Oct 2023 15:03:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1697641393;
        bh=L6D+qpbBdCzUDrl/li04wVioUZCLruBmB/YXF1xf4Bs=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=Gn2cvizOXkUy01k71YGxTE7X4z6vLqaoJLFafo+1V2D8V7Wv88ZBfmZ6d50ZFxvKj
         r0STRxGjErKUq13H3Iv7mn7AvIVCLxpKl0n0AqJx/zBkuo7ZkXLhcheBVnAbwngAJy
         S2skRkZqL4VlJYnoY86FUfOK7xrHRmF0ZzWNiFTOC5AyErC5YFeuU702fAYEtK/kQ0
         aIQ4dUnbHPpyCEC4k4S/zZbe8fb2opZ517pamFcrGwYG5OKsJ8cUyxGf+7h0XtSe7s
         mTD2R7Bi85VJqLSadyBjO5Aq+0cQCsfNSkx/qUgSy3TUsIJ33tfm5uq6iku67rtVOB
         05ypzoiMkKRgg==
Message-ID: <9d2fc137b4295058ac3f88f1cca7a54bc67f01fd.camel@kernel.org>
Subject: Re: [RFC PATCH 12/53] netfs: Provide tools to create a buffer in an
 xarray
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
Date:   Wed, 18 Oct 2023 11:03:10 -0400
In-Reply-To: <20231013160423.2218093-13-dhowells@redhat.com>
References: <20231013160423.2218093-1-dhowells@redhat.com>
         <20231013160423.2218093-13-dhowells@redhat.com>
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
> Provide tools to create a buffer in an xarray, with a function to add
> new folios with a mark.  This will be used to create bounce buffer and ca=
n be
> used more easily to create a list of folios the span of which would requi=
re
> more than a page's worth of bio_vec structs.
>=20
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Jeff Layton <jlayton@kernel.org>
> cc: linux-cachefs@redhat.com
> cc: linux-fsdevel@vger.kernel.org
> cc: linux-mm@kvack.org
> ---
>  fs/netfs/internal.h   |  16 +++++
>  fs/netfs/misc.c       | 140 ++++++++++++++++++++++++++++++++++++++++++
>  include/linux/netfs.h |   4 ++
>  3 files changed, 160 insertions(+)
>=20
> diff --git a/fs/netfs/internal.h b/fs/netfs/internal.h
> index 1f067aa96c50..00e01278316f 100644
> --- a/fs/netfs/internal.h
> +++ b/fs/netfs/internal.h
> @@ -52,6 +52,22 @@ static inline void netfs_proc_add_rreq(struct netfs_io=
_request *rreq) {}
>  static inline void netfs_proc_del_rreq(struct netfs_io_request *rreq) {}
>  #endif
> =20
> +/*
> + * misc.c
> + */
> +int netfs_xa_store_and_mark(struct xarray *xa, unsigned long index,
> +			    struct folio *folio, bool put_mark,
> +			    bool pagecache_mark, gfp_t gfp_mask);
> +int netfs_add_folios_to_buffer(struct xarray *buffer,
> +			       struct address_space *mapping,
> +			       pgoff_t index, pgoff_t to, gfp_t gfp_mask);
> +int netfs_set_up_buffer(struct xarray *buffer,
> +			struct address_space *mapping,
> +			struct readahead_control *ractl,
> +			struct folio *keep,
> +			pgoff_t have_index, unsigned int have_folios);
> +void netfs_clear_buffer(struct xarray *buffer);
> +
>  /*
>   * objects.c
>   */
> diff --git a/fs/netfs/misc.c b/fs/netfs/misc.c
> index c3baf2b247d9..c70f856f3129 100644
> --- a/fs/netfs/misc.c
> +++ b/fs/netfs/misc.c
> @@ -8,6 +8,146 @@
>  #include <linux/swap.h>
>  #include "internal.h"
> =20
> +/*
> + * Attach a folio to the buffer and maybe set marks on it to say that we=
 need
> + * to put the folio later and twiddle the pagecache flags.
> + */
> +int netfs_xa_store_and_mark(struct xarray *xa, unsigned long index,
> +			    struct folio *folio, bool put_mark,
> +			    bool pagecache_mark, gfp_t gfp_mask)
> +{
> +	XA_STATE_ORDER(xas, xa, index, folio_order(folio));
> +
> +retry:
> +	xas_lock(&xas);
> +	for (;;) {
> +		xas_store(&xas, folio);
> +		if (!xas_error(&xas))
> +			break;
> +		xas_unlock(&xas);
> +		if (!xas_nomem(&xas, gfp_mask))
> +			return xas_error(&xas);
> +		goto retry;
> +	}
> +
> +	if (put_mark)
> +		xas_set_mark(&xas, NETFS_BUF_PUT_MARK);
> +	if (pagecache_mark)
> +		xas_set_mark(&xas, NETFS_BUF_PAGECACHE_MARK);
> +	xas_unlock(&xas);
> +	return xas_error(&xas);
> +}
> +
> +/*
> + * Create the specified range of folios in the buffer attached to the re=
ad
> + * request.  The folios are marked with NETFS_BUF_PUT_MARK so that we kn=
ow that
> + * these need freeing later.
> + */

Some kerneldoc comments on these new helpers would be nice. I assume
that "index" and "to" are "start" and "end" for this, but it'd be nice
to make that explicit.


> +int netfs_add_folios_to_buffer(struct xarray *buffer,
> +			       struct address_space *mapping,
> +			       pgoff_t index, pgoff_t to, gfp_t gfp_mask)
> +{
> +	struct folio *folio;
> +	int ret;
> +
> +	if (to + 1 =3D=3D index) /* Page range is inclusive */
> +		return 0;
> +
> +	do {
> +		/* TODO: Figure out what order folio can be allocated here */
> +		folio =3D filemap_alloc_folio(readahead_gfp_mask(mapping), 0);
> +		if (!folio)
> +			return -ENOMEM;
> +		folio->index =3D index;
> +		ret =3D netfs_xa_store_and_mark(buffer, index, folio,
> +					      true, false, gfp_mask);
> +		if (ret < 0) {
> +			folio_put(folio);
> +			return ret;
> +		}
> +
> +		index +=3D folio_nr_pages(folio);
> +	} while (index <=3D to && index !=3D 0);
> +
> +	return 0;
> +}
> +
> +/*
> + * Set up a buffer into which to data will be read or decrypted/decompre=
ssed.
> + * The folios to be read into are attached to this buffer and the gaps f=
illed
> + * in to form a continuous region.
> + */
> +int netfs_set_up_buffer(struct xarray *buffer,
> +			struct address_space *mapping,
> +			struct readahead_control *ractl,
> +			struct folio *keep,
> +			pgoff_t have_index, unsigned int have_folios)
> +{
> +	struct folio *folio;
> +	gfp_t gfp_mask =3D readahead_gfp_mask(mapping);
> +	unsigned int want_folios =3D have_folios;
> +	pgoff_t want_index =3D have_index;
> +	int ret;
> +
> +	ret =3D netfs_add_folios_to_buffer(buffer, mapping, want_index,
> +					 have_index - 1, gfp_mask);
> +	if (ret < 0)
> +		return ret;
> +	have_folios +=3D have_index - want_index;
> +
> +	ret =3D netfs_add_folios_to_buffer(buffer, mapping,
> +					 have_index + have_folios,
> +					 want_index + want_folios - 1,
> +					 gfp_mask);

I don't get it. Why are you calling netfs_add_folios_to_buffer twice
here? Why not just make one call? Either way, a comment here explaining
that would also be nice.

> +	if (ret < 0)
> +		return ret;
> +
> +	/* Transfer the folios proposed by the VM into the buffer and take refs
> +	 * on them.  The locks will be dropped in netfs_rreq_unlock().
> +	 */
> +	if (ractl) {
> +		while ((folio =3D readahead_folio(ractl))) {
> +			folio_get(folio);
> +			if (folio =3D=3D keep)
> +				folio_get(folio);
> +			ret =3D netfs_xa_store_and_mark(buffer, folio->index, folio,
> +						      true, true, gfp_mask);
> +			if (ret < 0) {
> +				if (folio !=3D keep)
> +					folio_unlock(folio);
> +				folio_put(folio);
> +				return ret;
> +			}
> +		}
> +	} else {
> +		folio_get(keep);
> +		ret =3D netfs_xa_store_and_mark(buffer, keep->index, keep,
> +					      true, true, gfp_mask);
> +		if (ret < 0) {
> +			folio_put(keep);
> +			return ret;
> +		}
> +	}
> +	return 0;
> +}
> +
> +/*
> + * Clear an xarray buffer, putting a ref on the folios that have
> + * NETFS_BUF_PUT_MARK set.
> + */
> +void netfs_clear_buffer(struct xarray *buffer)
> +{
> +	struct folio *folio;
> +	XA_STATE(xas, buffer, 0);
> +
> +	rcu_read_lock();
> +	xas_for_each_marked(&xas, folio, ULONG_MAX, NETFS_BUF_PUT_MARK) {
> +		folio_put(folio);
> +	}
> +	rcu_read_unlock();
> +	xa_destroy(buffer);
> +}
> +
>  /**
>   * netfs_invalidate_folio - Invalidate or partially invalidate a folio
>   * @folio: Folio proposed for release
> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 66479a61ad00..e8d702ac6968 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -109,6 +109,10 @@ static inline int wait_on_page_fscache_killable(stru=
ct page *page)
>  	return folio_wait_private_2_killable(page_folio(page));
>  }
> =20
> +/* Marks used on xarray-based buffers */
> +#define NETFS_BUF_PUT_MARK	XA_MARK_0	/* - Page needs putting  */
> +#define NETFS_BUF_PAGECACHE_MARK XA_MARK_1	/* - Page needs wb/dirty flag=
 wrangling */
> +
>  enum netfs_io_source {
>  	NETFS_FILL_WITH_ZEROES,
>  	NETFS_DOWNLOAD_FROM_SERVER,
>=20

--=20
Jeff Layton <jlayton@kernel.org>
