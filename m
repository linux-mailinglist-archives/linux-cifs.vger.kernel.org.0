Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0C9B6224CD
	for <lists+linux-cifs@lfdr.de>; Wed,  9 Nov 2022 08:44:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbiKIHn7 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 9 Nov 2022 02:43:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbiKIHn6 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 9 Nov 2022 02:43:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A1E31114B
        for <linux-cifs@vger.kernel.org>; Tue,  8 Nov 2022 23:43:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=APKcTa1hR/RmW8NS4QKqvByff55KXcVdtHfa0tZTJ14=; b=ngO4vTXkz7fYj2rFDkQh1BtzXY
        b4KuCiolqd90OYoEZeJDfuNZQT1RQDCFN9OldY9MznOTpLu2hNnhRjPLA37ms7revHLmYHK/4mB7Y
        IChmq1fqQb9oAAXvr9CZUYLEYVXYUIa7ps96oywHhR0ZMYzfB6llOTkNpKLmI2z//aOVppjknsbBu
        s1u6xgH1+Mxo5Y13ebTcZS7N1np8PwevFUULCNFxryGjAWRsH+yjl5LCbJ/nAhUnVzwCOiY+P0nRW
        9psS1s1rH6vh+/9nrrRRQibK2+7rIhvHPJYGdbH6RJrwxmFAeKr0X1cmbC15H8NJKCNegfk+CxOxa
        khP8NWPA==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1osfkU-00Bic8-0y; Wed, 09 Nov 2022 07:43:50 +0000
Date:   Tue, 8 Nov 2022 23:43:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Jeremy Allison <jra@samba.org>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>
Subject: Re: reflink support and Samba running over XFS
Message-ID: <Y2taNrM8GfOBEDA/@infradead.org>
References: <CAH2r5mtc6rHC=zfWCjmGMex0qJrYKeuAcryW95-ru0KyZsaqpA@mail.gmail.com>
 <Y2molp4pVGNO+kaw@jeremy-acer>
 <Y2n7lENy0jrUg7XD@infradead.org>
 <Y2qXLNM5xvxZHuLQ@jeremy-acer>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2qXLNM5xvxZHuLQ@jeremy-acer>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Tue, Nov 08, 2022 at 09:51:40AM -0800, Jeremy Allison wrote:
> I'm assuming it's this:
> 
> https://man7.org/linux/man-pages/man2/ioctl_ficlonerange.2.html

Yes.
