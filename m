Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80F005AA461
	for <lists+linux-cifs@lfdr.de>; Fri,  2 Sep 2022 02:30:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233222AbiIBAal (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 1 Sep 2022 20:30:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiIBAak (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 1 Sep 2022 20:30:40 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A78C7E339
        for <linux-cifs@vger.kernel.org>; Thu,  1 Sep 2022 17:30:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662078638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=rDZu8IIo6FPE/pW88XoO5299clxnp4rO8KLGZtj/WqU=;
        b=SPnSpBmz3dWRGHk08CSHlBzjJDq7+mtW/d+7qLjJJnwGiidMm6scgqqe/YuddU+CId6PTe
        vnZVtc+4KIiLzuUXXxlQoz6eD0FiAMT8MlvYSm11WfGJQA5pMi8B4vDvg6cgY8VYW7/QmX
        p3+dscZ8DYZxxpYhhwgYMNmQNMXHmD0=
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com
 [209.85.166.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-539-CGcXKEc2OcGgEwhPzykCJQ-1; Thu, 01 Sep 2022 20:30:37 -0400
X-MC-Unique: CGcXKEc2OcGgEwhPzykCJQ-1
Received: by mail-io1-f71.google.com with SMTP id y10-20020a5d914a000000b00688fa7b2252so376618ioq.0
        for <linux-cifs@vger.kernel.org>; Thu, 01 Sep 2022 17:30:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rDZu8IIo6FPE/pW88XoO5299clxnp4rO8KLGZtj/WqU=;
        b=TjEywjLyxh/AAUTuN1KwyiKAaX+Lp4GdiYfq83wSPwo5f3MDLHqosSMlRwvA0Ol/Oz
         0/E//FWbZNi6jsHILHp1Q7DFKCc+lnwdr1hq0WM4vCepV/1HZOI9CqKy1JJUGFQigeip
         isTlPXtgtxKcYBHFdKxP0WoCDqGN1isoyo4MQZ0pl6zKizQSBPDe3GuZ7rW/j5BbZ+Bn
         5kvyDRS4SROYbBUdBvo1sRyh1pok0x52P2d/QMhUNk7zjw0UHzmt8dk+9yCDq4weTO4W
         cfw9h+L540F1LAq5oogNHGSchltkTAstc6tAxZ9oh8s+KRv/G9va8QinAB4b/ygaLjY6
         XQWA==
X-Gm-Message-State: ACgBeo25gYapbM+HpFEKblSmBNEszjh5G+JIhEk3MKItpWeviFtmC7rY
        sQ8ZTAk6iMSkqq2kCwla3tyxpS+8hYee3r/PhBeQ8lGPOm2O0RBh4RESPQe6ruJlI1OmHGFouWD
        mErUJzxbUBIeT626J5dAryIYozUhcZqNf1j9M5Q==
X-Received: by 2002:a05:6e02:1566:b0:2e5:a1e7:7e15 with SMTP id k6-20020a056e02156600b002e5a1e77e15mr18070499ilu.122.1662078637323;
        Thu, 01 Sep 2022 17:30:37 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6GNEbo0HFrxRlkS8cFvm/4EqoJtG46l3ycAfgK47CcGAB1FjQ4c1MCzUsZ6rBC4gPoPrJawBhcVFjyIgvAjTc=
X-Received: by 2002:a05:6e02:1566:b0:2e5:a1e7:7e15 with SMTP id
 k6-20020a056e02156600b002e5a1e77e15mr18070485ilu.122.1662078637075; Thu, 01
 Sep 2022 17:30:37 -0700 (PDT)
MIME-Version: 1.0
References: <Yk9V/03wgdYi65Lb@casper.infradead.org> <Yk5W6zvvftOB+80D@casper.infradead.org>
 <164928615045.457102.10607899252434268982.stgit@warthog.procyon.org.uk>
 <164928630577.457102.8519251179327601178.stgit@warthog.procyon.org.uk>
 <469869.1649313707@warthog.procyon.org.uk> <3118843.1650888461@warthog.procyon.org.uk>
 <YmaUUezsM+AS5R4y@casper.infradead.org>
In-Reply-To: <YmaUUezsM+AS5R4y@casper.infradead.org>
From:   David Wysochanski <dwysocha@redhat.com>
Date:   Thu, 1 Sep 2022 20:30:01 -0400
Message-ID: <CALF+zOnWkEHAmGfEcGccgL8dJw1U3sPSQ1iYndqMB885k9f_eA@mail.gmail.com>
Subject: Re: [PATCH 14/14] mm, netfs, fscache: Stop read optimisation when
 folio removed from pagecache
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        linux-cachefs <linux-cachefs@redhat.com>,
        Rohith Surabattula <rohiths.msft@gmail.com>,
        Steve French <sfrench@samba.org>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mm@kvack.org, Daire Byrne <daire.byrne@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Mon, Apr 25, 2022 at 8:30 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Mon, Apr 25, 2022 at 01:07:41PM +0100, David Howells wrote:
> > Matthew Wilcox <willy@infradead.org> wrote:
> >
> > > OK.  You suggested that releasepage was an acceptable place to call it.
> > > How about we have AS_RELEASE_ALL (... or something ...) and then
> > > page_has_private() becomes a bit more complicated ... to the point
> > > where we should probably get rid of it (by embedding it into
> > > filemap_release_folio():
> >
> > I'm not sure page_has_private() is quite so easy to get rid of.
> > shrink_page_list() and collapse_file(), for example, use it to conditionalise
> > a call to try_to_release_page() plus some other bits.
>
> That's what I was saying.  Make the calls to try_to_release_page()
> unconditional and delete page_has_private() because it only confuses
> people who should actually be using PagePrivate().
>
> > I think that, for the moment, I would need to add a check for AS_RELEASE_ALL
> > to page_has_private().
> >
> > David
> >
> >
>

I am not sure what the next steps are here but I wanted to ping about
this patch.  NFS also needs this patch or something like it.  David are
you planning to submit an updated series with an updated patch?

A partial backport of David's original patch here on top of my v3 NFS
netfs conversion patches [1] resolves one of my unit test failures
where there were extra reads from the network instead of the cache.
Also Daire Byrne indicates that he too was seeing the same thing
and he tested my patches below and it resolved his issue as well.
Note that I needed another netfs patch in this series,
"netfs: Provide invalidatepage and releasepage calls"
on top of this one, to resolve the problem.

[1] https://github.com/DaveWysochanskiRH/kernel/commits/nfs-fscache-netfs-removing-folio
$ git log --oneline | head
ad90bddf6570 NFS: Add usage of new VFS API removing folio
9e2a7c301564 mm,netfs: Add removing_folio() to stop netfs read
optimization (TEST ONLY)
776088910162 netfs: Provide invalidatepage and releasepage calls
8aa1379ceb49 NFS: Convert buffered read paths to use netfs when
fscache is enabled
807808d87040 NFS: Configure support for netfs when NFS fscache is configured
43a41cce491d NFS: Rename readpage_async_filler to nfs_pageio_add_page
b90cb1053190 Linux 6.0-rc3

