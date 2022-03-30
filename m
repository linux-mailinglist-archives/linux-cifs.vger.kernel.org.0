Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C15FD4EBD74
	for <lists+linux-cifs@lfdr.de>; Wed, 30 Mar 2022 11:18:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234506AbiC3JTO (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 30 Mar 2022 05:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52960 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243487AbiC3JTO (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 30 Mar 2022 05:19:14 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49932559F
        for <linux-cifs@vger.kernel.org>; Wed, 30 Mar 2022 02:17:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=5SbriPEIvpd+PVBFsKKcYj18uspKFgaK5uXJiqDIBcQ=; b=E3NFQIbmNeIQiUS9XUsw5aH/SQ
        L4X56crai4k1f1GAOnR/HT8BkyZb9w772pXn5rD6wWgMAN+rY/OJEBmPFr3zFyP3scMXCUpvTTP4F
        CuSnVaFJqwdy+brICbzIrw+dQYjCGKB6NdcOQo4dPg0+e5eJdfU56Orgof+PFYRrOoYmk4Kj5c5Oa
        KmX4VJqBNYsSnxgl7o/o6jowBx5kzZ/JVu+W1vXJRAAh+EgILBH2HG7JEDic+41hTrWyjHrJ4eHUq
        TzLl8DfBtlFDkZ8bJGcFNa17l4SHtf2HmMypTsJNoMk7keVVhW6PGmHDEfeujjVosZfZhkweZUBlh
        JuubtB3Q==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZUSG-00ExaN-HX; Wed, 30 Mar 2022 09:17:28 +0000
Date:   Wed, 30 Mar 2022 02:17:28 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Steve French <smfrench@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
Subject: Re: [GIT PULL] ksmbd server fixes
Message-ID: <YkQgKKmPYxzcf19t@infradead.org>
References: <CAH2r5mvmUjSpb0hPjMguq8aFKi11JUDMN5JADFqxw5xhNDELCA@mail.gmail.com>
 <CAHk-=whvfwQdpHv0E6UmaSeYKRYFL_CmaiGa8beCXdtX93U32w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whvfwQdpHv0E6UmaSeYKRYFL_CmaiGa8beCXdtX93U32w@mail.gmail.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Tue, Mar 29, 2022 at 06:48:51PM -0700, Linus Torvalds wrote:
> On Mon, Mar 28, 2022 at 6:39 PM Steve French <smfrench@gmail.com> wrote:
> >
> > - four patches relating to dentry race
> 
> I took a look at this, and I absolutely hate it.
> 
> You are basically exporting vfs-internal functions (__lookup_hash() in
> particular) that really shouldn't be exported.

It really shouldn't indeed, and I'm rather worried that this pull
request just exports it without any relevant ACKs.

> And the _reason_ you are exporting them seems to be that you have
> copied most of do_renameat2() as ksmbd_vfs_rename() but then made
> various small changes.
> 
> This all makes me _very_ uncomfortable.
> 
> I really get the feeling that we'd be much better off exporting
> something that is just a bigger part of that rename logic, not that
> really low-level __lookup_hash() thing.

Agreed.
