Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A8A84D50A6
	for <lists+linux-cifs@lfdr.de>; Thu, 10 Mar 2022 18:34:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245042AbiCJRfm (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 10 Mar 2022 12:35:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241154AbiCJRfm (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 10 Mar 2022 12:35:42 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6B82118A783
        for <linux-cifs@vger.kernel.org>; Thu, 10 Mar 2022 09:34:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646933678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+sI8yl68F8AaSxc5/19rLFgsuz0y8nt6Rj/YSh3VHaE=;
        b=OLTQGWpaYtuHXDafAtrAHvckTYIX7so9rgjr9MdvRg3UE7uhHY5O/ZoleWfYuprOQUsHEY
        Awl/Vjrm1jCxK5u0JLg55y/py7k0j/wqG+zgAftwCrqLLaeN9D+9+KR0zjB4RyN7w7rvad
        paJljT5Sg0/0tsfUPix37+NUJdym+LY=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-tvYR4GvTNSiR8S5O3NK1EA-1; Thu, 10 Mar 2022 12:34:37 -0500
X-MC-Unique: tvYR4GvTNSiR8S5O3NK1EA-1
Received: by mail-qk1-f199.google.com with SMTP id bj2-20020a05620a190200b005084968bb24so4290459qkb.23
        for <linux-cifs@vger.kernel.org>; Thu, 10 Mar 2022 09:34:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=+sI8yl68F8AaSxc5/19rLFgsuz0y8nt6Rj/YSh3VHaE=;
        b=E30vuE/m2kMMqeFGfCmi1u8HJfVgH/wfvMbP5RM546qzYLYdPq815sLQI3dxZa/V0q
         s7L3vO9YgEkoXpeew30kUhEgW8sMW8Gtw3Fk873xEpBaoCAF8tYW82UgI1lt2eSZej8o
         WJPL+E8W9rBUygPlIfiNr1NuJMxiDlwWFN6gbK9mRt4Q+8ANIUGL8w8KCbuZibbc+MOb
         6R4RnMfV/EF67I1qP2WBs70PjnWljjoGcouoTqNnAtq/vZJogw26fdsGBjufjqVaGXl/
         pVCa5zEmwNX6b5yIqj2pKtxJzft0z0aaBpZQb07xZIMIXizLosie4mesPF9tTxzi2m4l
         +ySg==
X-Gm-Message-State: AOAM533LgKqP48euzj1G+nqunH+j396e/BWpHddiOKsEqLlOF3xPvxCc
        lD/QLyHXTzAVuW3xZQRXCRKFIQWRlWDYkdchHtgGoh7V0rx2HETAM/ngFODEBY846EK1XQw9ltN
        twb5BAN3ZrrNiS25dwB3ckw==
X-Received: by 2002:ac8:5f84:0:b0:2e0:6965:c999 with SMTP id j4-20020ac85f84000000b002e06965c999mr4925479qta.477.1646933676605;
        Thu, 10 Mar 2022 09:34:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzM49ZVae3bPgm0svuUu3uf+AJzp4pMchlkgmKNd23/D20Xgvy0iFYR1hc8U1liK5jF6Izwyg==
X-Received: by 2002:ac8:5f84:0:b0:2e0:6965:c999 with SMTP id j4-20020ac85f84000000b002e06965c999mr4925451qta.477.1646933676349;
        Thu, 10 Mar 2022 09:34:36 -0800 (PST)
Received: from [192.168.1.3] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id t28-20020a05620a005c00b00662fb1899d2sm2562187qkt.0.2022.03.10.09.34.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Mar 2022 09:34:35 -0800 (PST)
Message-ID: <dd054c962818716e718bd9b446ee5322ca097675.camel@redhat.com>
Subject: Re: [PATCH v3 12/20] ceph: Make ceph_init_request() check caps on
 readahead
From:   Jeff Layton <jlayton@redhat.com>
To:     David Howells <dhowells@redhat.com>, linux-cachefs@redhat.com
Cc:     ceph-devel@vger.kernel.org,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        David Wysochanski <dwysocha@redhat.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-afs@lists.infradead.org, linux-nfs@vger.kernel.org,
        linux-cifs@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Date:   Thu, 10 Mar 2022 12:34:34 -0500
In-Reply-To: <164692907694.2099075.10081819855690054094.stgit@warthog.procyon.org.uk>
References: <164692883658.2099075.5745824552116419504.stgit@warthog.procyon.org.uk>
         <164692907694.2099075.10081819855690054094.stgit@warthog.procyon.org.uk>
Content-Type: text/plain; charset="ISO-8859-15"
User-Agent: Evolution 3.42.4 (3.42.4-1.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Thu, 2022-03-10 at 16:17 +0000, David Howells wrote:
> Move the caps check from ceph_readahead() to ceph_init_request(),
> conditional on the origin being NETFS_READAHEAD so that in a future patch,
> ceph can point its ->readahead() vector directly at netfs_readahead().
> 
> Changes
> =======
> ver #3)
>  - Split from the patch to add a netfs inode context[1].
>  - Need to store the caps got in rreq->netfs_priv for later freeing.
> 
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: ceph-devel@vger.kernel.org
> cc: linux-cachefs@redhat.com
> Link: https://lore.kernel.org/r/8af0d47f17d89c06bbf602496dd845f2b0bf25b3.camel@kernel.org/ [1]
> ---
> 
>  fs/ceph/addr.c |   69 +++++++++++++++++++++++++++++++++-----------------------
>  1 file changed, 41 insertions(+), 28 deletions(-)
> 
> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> index 9189257476f8..6d056db41f50 100644
> --- a/fs/ceph/addr.c
> +++ b/fs/ceph/addr.c
> @@ -354,6 +354,45 @@ static void ceph_netfs_issue_read(struct netfs_io_subrequest *subreq)
>  	dout("%s: result %d\n", __func__, err);
>  }
>  
> +static int ceph_init_request(struct netfs_io_request *rreq, struct file *file)
> +{
> +	struct inode *inode = rreq->inode;
> +	int got = 0, want = CEPH_CAP_FILE_CACHE;
> +	int ret = 0;
> +
> +	if (file) {
> +		struct ceph_rw_context *rw_ctx;
> +		struct ceph_file_info *fi = file->private_data;
> +
> +		rw_ctx = ceph_find_rw_context(fi);
> +		if (rw_ctx)
> +			return 0;
> +	}
> +
> +	if (rreq->origin != NETFS_READAHEAD)
> +		return 0;
> +

^^^
I think you should move this check above the if (file) block above it.
We don't need to anything at all if we're not in readahead.

> +	/*
> +	 * readahead callers do not necessarily hold Fcb caps
> +	 * (e.g. fadvise, madvise).
> +	 */
> +	ret = ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
> +	if (ret < 0) {
> +		dout("start_read %p, error getting cap\n", inode);
> +		return ret;
> +	}
> +
> +	if (!(got & want)) {
> +		dout("start_read %p, no cache cap\n", inode);
> +		return -EACCES;
> +	}
> +	if (ret == 0)
> +		return -EACCES;
> +
> +	rreq->netfs_priv = (void *)(uintptr_t)got;
> +	return 0;
> +}
> +
>  static void ceph_readahead_cleanup(struct address_space *mapping, void *priv)
>  {
>  	struct inode *inode = mapping->host;
> @@ -365,7 +404,7 @@ static void ceph_readahead_cleanup(struct address_space *mapping, void *priv)
>  }
>  
>  static const struct netfs_request_ops ceph_netfs_read_ops = {
> -	.is_cache_enabled	= ceph_is_cache_enabled,
> +	.init_request		= ceph_init_request,
>  	.begin_cache_operation	= ceph_begin_cache_operation,
>  	.issue_read		= ceph_netfs_issue_read,
>  	.expand_readahead	= ceph_netfs_expand_readahead,
> @@ -393,33 +432,7 @@ static int ceph_readpage(struct file *file, struct page *subpage)
>  
>  static void ceph_readahead(struct readahead_control *ractl)
>  {
> -	struct inode *inode = file_inode(ractl->file);
> -	struct ceph_file_info *fi = ractl->file->private_data;
> -	struct ceph_rw_context *rw_ctx;
> -	int got = 0;
> -	int ret = 0;
> -
> -	if (ceph_inode(inode)->i_inline_version != CEPH_INLINE_NONE)
> -		return;
> -
> -	rw_ctx = ceph_find_rw_context(fi);
> -	if (!rw_ctx) {
> -		/*
> -		 * readahead callers do not necessarily hold Fcb caps
> -		 * (e.g. fadvise, madvise).
> -		 */
> -		int want = CEPH_CAP_FILE_CACHE;
> -
> -		ret = ceph_try_get_caps(inode, CEPH_CAP_FILE_RD, want, true, &got);
> -		if (ret < 0)
> -			dout("start_read %p, error getting cap\n", inode);
> -		else if (!(got & want))
> -			dout("start_read %p, no cache cap\n", inode);
> -
> -		if (ret <= 0)
> -			return;
> -	}
> -	netfs_readahead(ractl, &ceph_netfs_read_ops, (void *)(uintptr_t)got);
> +	netfs_readahead(ractl, &ceph_netfs_read_ops, NULL);
>  }
>  
>  #ifdef CONFIG_CEPH_FSCACHE
> 
> 

-- 
Jeff Layton <jlayton@redhat.com>

