Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 375F536B9D5
	for <lists+linux-cifs@lfdr.de>; Mon, 26 Apr 2021 21:15:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239941AbhDZTQ3 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 26 Apr 2021 15:16:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51270 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238175AbhDZTQ1 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 26 Apr 2021 15:16:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619464545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NjlPen1encdZDkGM0wilUuVPtH5U8CDDV8DYPkgdQBU=;
        b=i/jhZeHGBpZUzi72TqQ6dwfZSK4OhJIYhawDDlDroEkpOdwv7ORQZQK63e7G6x7qUJXNDT
        9o2ocHbbwuu7/qPd3Lg4B/98Bw/Icip1P3Ml1XDzM4lNAqxxfFhkfa4e45J3/vAEnHFAzB
        Y24bShZNYayCCITzaE+ElgJyI/8Vx70=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-557-HMXNNL1oOr2s2FoWlB_5Jw-1; Mon, 26 Apr 2021 15:15:41 -0400
X-MC-Unique: HMXNNL1oOr2s2FoWlB_5Jw-1
Received: by mail-qt1-f198.google.com with SMTP id h14-20020ac846ce0000b02901ba21d99130so13908627qto.13
        for <linux-cifs@vger.kernel.org>; Mon, 26 Apr 2021 12:15:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:user-agent:mime-version:content-transfer-encoding;
        bh=NjlPen1encdZDkGM0wilUuVPtH5U8CDDV8DYPkgdQBU=;
        b=tLSDDMV0faeqrwqysU0XSoraG2u+HqpDJrZzQQf1tNFdhsBXaRKWGM249cmWU96RxF
         LqSF1RwkIJPM5PjEI7sE5GMAJoGsN2sbeZzPZF698pPUkoOsFILobVRHr8WEgralC2NG
         CKfMRw5uJISTGKVQbCA6+9+wY2W5/Xhbh8f90mwAx6D6A1BiRKJ79By8bCEwlMX99wgR
         2yA1nf+vcR4lv2TbKfam42krSIDAMq7it4UKzf7gqnzXV4SluWx1GbtnkQHlZNUn+GWZ
         ++RXdd2iyYcw7ANgaemJNjurFDecHJle0wBkTePES5xkV7GXMIjDoqjY5C1mGZ3AnFz9
         GvBw==
X-Gm-Message-State: AOAM531GYybKVQ1wAwJpyAW/9UaB9MldBOtSZcsqM/kq79N3x6yLw4+L
        ryFu8ogsfevg2citzhlcliDSK3lFBzRFmnmtWMZDHFa1s2hRLkQtMwLSdYwb10XojimvLHSLEVu
        Gfx5hoBk8UzXl+AX7a+O6mg==
X-Received: by 2002:a37:de14:: with SMTP id h20mr18965535qkj.34.1619464540671;
        Mon, 26 Apr 2021 12:15:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZYRAHl+eWnQtgdg3ck30c64eIGwlxsQ5wJdm+wrQWh9LXuumEJb2NQlXbEra5jinaPsZTlQ==
X-Received: by 2002:a37:de14:: with SMTP id h20mr18965510qkj.34.1619464540455;
        Mon, 26 Apr 2021 12:15:40 -0700 (PDT)
Received: from [192.168.1.180] (68-20-15-154.lightspeed.rlghnc.sbcglobal.net. [68.20.15.154])
        by smtp.gmail.com with ESMTPSA id c15sm12638215qtg.31.2021.04.26.12.15.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Apr 2021 12:15:40 -0700 (PDT)
Message-ID: <8114b7a1151edf52e3a20cf30d2673cd177191bf.camel@redhat.com>
Subject: Re: [PATCH v7 01/31] iov_iter: Add ITER_XARRAY
From:   Jeff Layton <jlayton@redhat.com>
To:     Al Viro <viro@zeniv.linux.org.uk>,
        David Howells <dhowells@redhat.com>
Cc:     linux-fsdevel@vger.kernel.org,
        Dave Wysochanski <dwysocha@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-cachefs@redhat.com, linux-afs@lists.infradead.org,
        linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org,
        ceph-devel@vger.kernel.org, v9fs-developer@lists.sourceforge.net,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna.schumaker@netapp.com>,
        Steve French <sfrench@samba.org>,
        Dominique Martinet <asmadeus@codewreck.org>,
        linux-kernel@vger.kernel.org
Date:   Mon, 26 Apr 2021 15:15:39 -0400
In-Reply-To: <YIcMVCkp4xswHolw@zeniv-ca.linux.org.uk>
References: <161918446704.3145707.14418606303992174310.stgit@warthog.procyon.org.uk>
         <161918448151.3145707.11541538916600921083.stgit@warthog.procyon.org.uk>
         <YIcMVCkp4xswHolw@zeniv-ca.linux.org.uk>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.40.0 (3.40.0-1.fc34) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Mon, 2021-04-26 at 18:54 +0000, Al Viro wrote:
> On Fri, Apr 23, 2021 at 02:28:01PM +0100, David Howells wrote:
> > -#define iterate_all_kinds(i, n, v, I, B, K) {			\
> > +#define iterate_xarray(i, n, __v, skip, STEP) {		\
> > +	struct page *head = NULL;				\
> > +	size_t wanted = n, seg, offset;				\
> > +	loff_t start = i->xarray_start + skip;			\
> > +	pgoff_t index = start >> PAGE_SHIFT;			\
> > +	int j;							\
> > +								\
> > +	XA_STATE(xas, i->xarray, index);			\
> > +								\
> > +	rcu_read_lock();						\
> > +	xas_for_each(&xas, head, ULONG_MAX) {				\
> > +		if (xas_retry(&xas, head))				\
> > +			continue;					\
> 
> OK, now I'm really confused; what's to guarantee that restart will not have
> you hit the same entry more than once?  STEP might be e.g.
> 
> 		memcpy_to_page(v.bv_page, v.bv_offset,
> 			       (from += v.bv_len) - v.bv_len, v.bv_len)
> 
> which is clearly not idempotent - from gets incremented, after all.
> What am I missing here?
> 

Not sure I understand the issue you see. If xas_retry returns true,
we'll restart, but we won't have called STEP yet for that entry. I
don't see how we'd retry there and have an issue with idempotency.

> > +		if (WARN_ON(xa_is_value(head)))				\
> > +			break;						\
> > +		if (WARN_ON(PageHuge(head)))				\
> > +			break;						\
> > +		for (j = (head->index < index) ? index - head->index : 0; \
> > +		     j < thp_nr_pages(head); j++) {			\
> > +			__v.bv_page = head + j;				\
> > +			offset = (i->xarray_start + skip) & ~PAGE_MASK;	\
> > +			seg = PAGE_SIZE - offset;			\
> > +			__v.bv_offset = offset;				\
> > +			__v.bv_len = min(n, seg);			\
> > +			(void)(STEP);					\
> > +			n -= __v.bv_len;				\
> > +			skip += __v.bv_len;				\
> > +			if (n == 0)					\
> > +				break;					\
> > +		}							\
> > +		if (n == 0)						\
> > +			break;						\
> > +	}							\
> > +	rcu_read_unlock();					\
> > +	n = wanted - n;						\
> > +}


