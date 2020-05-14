Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0A07F1D3E62
	for <lists+linux-cifs@lfdr.de>; Thu, 14 May 2020 22:04:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729125AbgENUEA (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 14 May 2020 16:04:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729103AbgENUD7 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 14 May 2020 16:03:59 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8BBC061A0C;
        Thu, 14 May 2020 13:03:59 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 44DE4128D4959;
        Thu, 14 May 2020 13:03:58 -0700 (PDT)
Date:   Thu, 14 May 2020 13:03:57 -0700 (PDT)
Message-Id: <20200514.130357.1683454520750761365.davem@davemloft.net>
To:     David.Laight@ACULAB.COM
Cc:     hch@lst.de, joe@perches.com, kuba@kernel.org, edumazet@google.com,
        kuznet@ms2.inr.ac.ru, yoshfuji@linux-ipv6.org, vyasevich@gmail.com,
        nhorman@tuxdriver.com, marcelo.leitner@gmail.com,
        jmaloy@redhat.com, ying.xue@windriver.com,
        drbd-dev@lists.linbit.com, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        linux-nvme@lists.infradead.org, target-devel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        cluster-devel@redhat.com, ocfs2-devel@oss.oracle.com,
        netdev@vger.kernel.org, linux-sctp@vger.kernel.org,
        ceph-devel@vger.kernel.org, rds-devel@oss.oracle.com,
        linux-nfs@vger.kernel.org
Subject: Re: remove kernel_setsockopt and kernel_getsockopt
From:   David Miller <davem@davemloft.net>
In-Reply-To: <a76440f7305c4653877ff2abff499f4e@AcuMS.aculab.com>
References: <756758e8f0e34e2e97db470609f5fbba@AcuMS.aculab.com>
        <20200514101838.GA12548@lst.de>
        <a76440f7305c4653877ff2abff499f4e@AcuMS.aculab.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Thu, 14 May 2020 13:03:59 -0700 (PDT)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

From: David Laight <David.Laight@ACULAB.COM>
Date: Thu, 14 May 2020 10:26:41 +0000

> I doubt we are the one company with out-of-tree drivers
> that use the kernel_socket interface.

Not our problem.
