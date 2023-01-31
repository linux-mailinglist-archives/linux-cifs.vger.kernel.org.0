Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AD4168223B
	for <lists+linux-cifs@lfdr.de>; Tue, 31 Jan 2023 03:35:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231487AbjAaCfZ (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 30 Jan 2023 21:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231515AbjAaCeu (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 30 Jan 2023 21:34:50 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E71A36FCC
        for <linux-cifs@vger.kernel.org>; Mon, 30 Jan 2023 18:34:24 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id mi9so3756776pjb.4
        for <linux-cifs@vger.kernel.org>; Mon, 30 Jan 2023 18:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=A9VhNAncouGPghsLCtxdhrn+26s29dRN0H0czKp2bTE=;
        b=ADZjED2w0momUtfafOuSNuN7ZxxrP0KeUDW1RTHuQc80r3inyDTwQ1MXq8KQQCJPA1
         2IjPoFNw6EOC1H2jGbZ0sNPpCmiE0a1bmED2KiD/tXvqcCixj5NIzO02aStn2z3ovwP6
         3Z5APDKQvCBsotmTrQZGzddlPRda1HIIj6Rto=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=A9VhNAncouGPghsLCtxdhrn+26s29dRN0H0czKp2bTE=;
        b=RMzgDnNUw0jGwp0PgCDRhLYLdR5RHZgQp3Hrz/vJyGe2OrpgJVCaFnWSGyUgPVQeed
         RT7nilwcw1i1hfUDbT9wIbi6M+cbkNqq7ThUGCpt5HhVTusDWXADVnRfO8L+bHOKZYDB
         h98H3R6b7Mb3D/muQOAqLzK8nwC6xuIPyTGl1pzzfjTB7IqXMA/aBUKp9pGI0UyR/NxP
         fzeSZW4S0L069FwY1BMqleeEIWwNefozsRGp4VFNot5Q2UftBKvTIqPUS/tK8y4DHxsr
         5D8BVhbHBmnm2yprOuS5SS6QeupXtA+EBKOJwmt49WpTdK2kdN0Sl7ZM9xkB6tIxXVDE
         3P8w==
X-Gm-Message-State: AFqh2kpMzfuvnV+J6K6K/Z8NoUhv6VKg68gx1l7fnEj8lChT0wlJ8H5S
        6RTyWdIftvZFZJy6Y0LNHGxBqw==
X-Google-Smtp-Source: AMrXdXsnmC1gw3eG1rPepfp90wWItWSXAPyy0WFX0PxqmtkL6j5e8V5dnOtluVb8V5qnNkoyExcM+g==
X-Received: by 2002:a17:902:ba85:b0:194:828d:62b0 with SMTP id k5-20020a170902ba8500b00194828d62b0mr38778219pls.48.1675132459197;
        Mon, 30 Jan 2023 18:34:19 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id y20-20020a1709027c9400b00186c5e8a8d7sm3404428pll.171.2023.01.30.18.34.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 18:34:18 -0800 (PST)
Date:   Tue, 31 Jan 2023 11:34:08 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Jens Axboe <axboe@kernel.dk>, Ilya Dryomov <idryomov@gmail.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Minchan Kim <minchan@kernel.org>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Keith Busch <kbusch@kernel.org>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Xiubo Li <xiubli@redhat.com>, Steve French <sfrench@samba.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Mike Marshall <hubcap@omnibond.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Chuck Lever <chuck.lever@oracle.com>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        devel@lists.orangefs.org, io-uring@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 10/23] zram: use bvec_set_page to initialize bvecs
Message-ID: <Y9h+ILaGkNOhYJC5@google.com>
References: <20230130092157.1759539-1-hch@lst.de>
 <20230130092157.1759539-11-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230130092157.1759539-11-hch@lst.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On (23/01/30 10:21), Christoph Hellwig wrote:
> Use the bvec_set_page helper to initialize bvecs.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
