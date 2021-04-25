Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D290036A416
	for <lists+linux-cifs@lfdr.de>; Sun, 25 Apr 2021 04:10:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbhDYCKl (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 24 Apr 2021 22:10:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229580AbhDYCKl (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 24 Apr 2021 22:10:41 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FD3DC061574
        for <linux-cifs@vger.kernel.org>; Sat, 24 Apr 2021 19:10:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=UzGG6RHaj/k2YPz2jml26W1R12hGGjIvqYZ55ZRNwG0=; b=CLaGliv0+liqY4+jW7+qY2oKUS
        +Oi/PvsbGlknh5Zd+CyS8IUzhYuY5I2vr0k+mw1KpXtNhTc3oYClkafwo1xQXf6UlvkC7KfRGfKz/
        JH2fS7f1FicXTR7aGVidT5d1qGq+OkZwR9MPeY/vATEe34Z4lvaCNPNPGYd4+jzI6g34LXDykofoA
        0wkP2QioZmK6nb8bu76uiJl99DpoMphDZmq/d7qEEed0MY987YVRopJlCTqrUli583wPUXA7IhqDJ
        xkaV1rT0lSuu0OBAncHiS83VexL0V6hgVMVcEc+hTTKbWZ+kE7pkdRpXwiybyvY71E1XVZJK+yZqP
        2hyC9zcg==;
Received: from willy by casper.infradead.org with local (Exim 4.94 #2 (Red Hat Linux))
        id 1laUDS-003mWy-Tc; Sun, 25 Apr 2021 02:09:56 +0000
Date:   Sun, 25 Apr 2021 03:09:46 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        Jeff Layton <jlayton@redhat.com>,
        David Howells <dhowells@redhat.com>
Subject: Re: [PATCH] smb3: add rasize mount parameter to improve performance
  of readahead
Message-ID: <20210425020946.GG235567@casper.infradead.org>
References: <CAH2r5mvfMfgGimkmC9nQxvOMt=2E7S1=dA33MJaszy5NHE2zxQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mvfMfgGimkmC9nQxvOMt=2E7S1=dA33MJaszy5NHE2zxQ@mail.gmail.com>
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Sat, Apr 24, 2021 at 02:27:11PM -0500, Steve French wrote:
> Using the buildbot test systems, this resulted in an average improvement
> of 14% to the Windows server test target for the first 12 tests I
> tried (no multichannel)
> changing to 12MB rasize (read ahead size).   Similarly increasing the
> rasize to 12MB to Azure (this time with multichannel, 4 channels)
> improved performance 37%
> 
> Note that Ceph had already introduced a mount parameter "rasize" to
> allow controlling this.  Add mount parameter "rasize" to cifs.ko to
> allow control of read ahead (rasize defaults to 4MB which is typically
> what it used to default to to the many servers whose rsize was that).

I think something was missing from this patch -- I see you parse it and
set it in the mount context, but I don't see where it then gets used to
actually affect readahead.
