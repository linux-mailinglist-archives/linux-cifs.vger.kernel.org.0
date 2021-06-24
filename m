Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 642BF3B26C3
	for <lists+linux-cifs@lfdr.de>; Thu, 24 Jun 2021 07:28:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbhFXFae (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 24 Jun 2021 01:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230138AbhFXFab (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 24 Jun 2021 01:30:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF5D4C061574
        for <linux-cifs@vger.kernel.org>; Wed, 23 Jun 2021 22:28:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=uY/GPIKAGTeMh5W5u9AYy49bNiKWDBJZb1ocuZLJgcg=; b=AqXZlsV6mUioMiuMMqQONEpy9s
        9EMzjWqBwxApftSUljLrubXwG1k4nYArbLvld2zw9WwFtkp5KzsXNOfICoYxuqWfNmeUzrfY4+Ba9
        IMLLmfzb8cxXPCiAlXiMENMm+1rOJy0eVabG5xOF9QSQWmgA2r870qWMKV3i6+D9b833ft8oSlLXI
        6nbdmSiWp2d777KaI+5HSgzoP+v7O4DXMupMtmND2/THDgkzBz0Rd+i1mDhKAtxsMzuM/YnqS0J94
        St896RMneBKdTpEMyc8avyAO6taqZR7SFnrvkREG+Fj92NSf2e+D4UlJbAOy/wN8fCoGYUiw5R3es
        RfaveqJA==;
Received: from hch by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lwHtH-00GD9C-LV; Thu, 24 Jun 2021 05:27:14 +0000
Date:   Thu, 24 Jun 2021 06:27:03 +0100
From:   Christoph Hellwig <hch@infradead.org>
To:     Namjae Jeon <namjae.jeon@samsung.com>
Cc:     linux-cifs@vger.kernel.org,
        linux-cifsd-devel@lists.sourceforge.net,
        Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: Re: [PATCH 2/2] MAINTAINERS: rename cifsd to ksmbd
Message-ID: <YNQXp7cjFAG17FVY@infradead.org>
References: <20210624005211.26886-1-namjae.jeon@samsung.com>
 <CGME20210624010231epcas1p22d8b6576f5966f45cbf9bf99331dec53@epcas1p2.samsung.com>
 <20210624005211.26886-2-namjae.jeon@samsung.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210624005211.26886-2-namjae.jeon@samsung.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Thu, Jun 24, 2021 at 09:52:11AM +0900, Namjae Jeon wrote:
> Rename cifsd to ksmbd and update Sergey's mail address.

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
