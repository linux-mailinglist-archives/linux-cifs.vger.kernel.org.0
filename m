Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5696F78DA4
	for <lists+linux-cifs@lfdr.de>; Mon, 29 Jul 2019 16:19:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387778AbfG2OTr (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 29 Jul 2019 10:19:47 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:35862 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387762AbfG2OTq (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 29 Jul 2019 10:19:46 -0400
Received: by mail-qk1-f193.google.com with SMTP id g18so44235014qkl.3
        for <linux-cifs@vger.kernel.org>; Mon, 29 Jul 2019 07:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=tp13KIZyxW/HUo/k7TqlcYpzZ2vSqWCZ8hRiWQUnNrA=;
        b=oawsf/tX9gqElOJd5+WpuZm4xmAz1Ab6RkxbNDYNIMxEI56FFfOeijaPCmNE4Lj/Dq
         oawS3zAbpLWZ5LJAqqRzyqz/lDNdlGwFckSUUcmjwpvkJvCVsTnWlZXIIb2xoVpV0f7C
         S/1lZMrSb5yKjldwRHVMhnTwPDa8KANACfUKgvqJVnSzon7qohWZEBEMCCHOHv3SypH2
         rr9YhD1VWWCG6gYsYp3HZlQ22GwMHe1a1STtXa+2n6SzBi1vtqVU1sorpu9Q05JhCegV
         ktwc5iyQaigLO1fhKJ2kJaDmx2R5+xNoBC1F1wpkdzPQhUntQvc3Y30wlOU2U5GEJOZc
         U3Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=tp13KIZyxW/HUo/k7TqlcYpzZ2vSqWCZ8hRiWQUnNrA=;
        b=J4DmMUdcBesXi8s2r70+KarnskgRK5y7CHZHHxoGLSXggMZFx8sUr2kM/FluYnpJBe
         aOENRifxTxRwNrrUwXRywrDKC3iHBXUsLs+3nhWrVTNdjbkdxXAWmBGzP0YKie2j7HPL
         qw98F6p8l0dmB8Kbyod0BuDL7Qc4x4sWiHbAYs5KyUgNK2sTGQMTXxySvnm+iMpBdWP5
         E/TvA1x49HEBSFUuJMm7McI9U209wapLUKkRYlg7aubZRdOWU5KuadKkweGYI5qRhdpZ
         7c0hwWrGKwACpGXGw6NfzfssusuKAYFC+y+G3FVvhzAWz8L3trHHGgZGSLmHhodk0s/o
         +xag==
X-Gm-Message-State: APjAAAX2hq27VXibR3kvKbSDfIxDKkq8bFWX4qLF2txpXXCAQXWjX31s
        /q5aA75vI58DOM8NVs/a91U7Qg==
X-Google-Smtp-Source: APXvYqwlcdfRKnJ5qhYvNehqw7PetDVYBSyws4Kc3e74wuN7fKiYbK3taI/YYGg9dA7gVGaeqeF7pg==
X-Received: by 2002:a37:a090:: with SMTP id j138mr73759023qke.83.1564409985925;
        Mon, 29 Jul 2019 07:19:45 -0700 (PDT)
Received: from ziepe.ca (hlfxns017vw-156-34-55-100.dhcp-dynamic.fibreop.ns.bellaliant.net. [156.34.55.100])
        by smtp.gmail.com with ESMTPSA id c26sm25950347qtp.40.2019.07.29.07.19.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 29 Jul 2019 07:19:45 -0700 (PDT)
Received: from jgg by mlx.ziepe.ca with local (Exim 4.90_1)
        (envelope-from <jgg@ziepe.ca>)
        id 1hs6V7-0007FN-1r; Mon, 29 Jul 2019 11:19:45 -0300
Date:   Mon, 29 Jul 2019 11:19:45 -0300
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Leon Romanovsky <leon@kernel.org>
Cc:     Chuck Lever <chuck.lever@oracle.com>, linux-rdma@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        v9fs-developer@lists.sourceforge.net
Subject: Re: [PATCH v2] rdma: Enable ib_alloc_cq to spread work over a
 device's comp_vectors
Message-ID: <20190729141945.GF17990@ziepe.ca>
References: <20190728163027.3637.70740.stgit@manet.1015granger.net>
 <20190729054933.GK4674@mtr-leonro.mtl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190729054933.GK4674@mtr-leonro.mtl.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Mon, Jul 29, 2019 at 08:49:33AM +0300, Leon Romanovsky wrote:
> > +/**
> > + * ib_alloc_cq_any: Allocate kernel CQ
> > + * @dev: The IB device
> > + * @private: Private data attached to the CQE
> > + * @nr_cqe: Number of CQEs in the CQ
> > + * @poll_ctx: Context used for polling the CQ
> > + */
> > +static inline struct ib_cq *ib_alloc_cq_any(struct ib_device *dev,
> > +					    void *private, int nr_cqe,
> > +					    enum ib_poll_context poll_ctx)
> > +{
> > +	return __ib_alloc_cq_any(dev, private, nr_cqe, poll_ctx,
> > +				 KBUILD_MODNAME);
> > +}
> 
> This should be macro and not inline function, because compiler can be
> instructed do not inline functions (there is kconfig option for that)
> and it will cause that wrong KBUILD_MODNAME will be inserted (ib_core
> instead of ulp).

No, it can't, a static inline can only be de-inlined within the same
compilation unit, so KBUILD_MODNAME can never be mixed up.

You only need to use macros of the value changes within the
compilation unit.

Jason
