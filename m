Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1578B4DD350
	for <lists+linux-cifs@lfdr.de>; Fri, 18 Mar 2022 03:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbiCRCxo (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 17 Mar 2022 22:53:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiCRCxo (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 17 Mar 2022 22:53:44 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E6A2E7126
        for <linux-cifs@vger.kernel.org>; Thu, 17 Mar 2022 19:52:26 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 17so9719095lji.1
        for <linux-cifs@vger.kernel.org>; Thu, 17 Mar 2022 19:52:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T64FUWLzth3yVyUyHfYkkV7VepzI1N+9nPzmoZ54H6A=;
        b=LwqcT8hYKA3LhxZBO5eaFMkgTdGjgnhWSkpnnllml7AzrUM0j/oRpAHqr7HslWVdPL
         DFu1cJp5mWyyHhYVAT/Xalx8DT6uYY+WNWJ6aL7qySIDplHPLokC5e/YyM21iUoO9A2A
         u6+tqxpmcwkmK0EFDI9gf8uU1vdpOJhFXpZ4Fcu/PcMRzKXmG9g/fsW3iMArCtqd8qLw
         FzYPa3KxDzDzIOakBEksQp3banrBMPmQnP9pbzik93coKV1EUGpPADaP/H3ksJBLMB7h
         oVozCymx+zkHS4E7QEBmOKVsh2FjbLyXCPQ0yVxiMVpe/RqGwdXVdxPvtplMDl8hqubg
         mTmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T64FUWLzth3yVyUyHfYkkV7VepzI1N+9nPzmoZ54H6A=;
        b=qP7mbsF54Jumuk/fnavYsXLhzH2uBcVNRb261dJQr5vGIGBPsPIgFCPZSjvL0Kbr5S
         4aqvAQWolJ6FGipzLbG5/o553QTBzOQACbUgAt5YuGZASrMf/fmWvnH+bEFlbVJrJrAV
         aoVU2Os0cJBTsA3tGAI0YMv9eSmSeOWq6M/wJhQ2uWKM7bzMrkpGFJKTUBfCHSqNQXRW
         QoLMc44tZPpgHBbuo67qvkST0ra0MJbAyCb7hdrOOmDPSNzdsxFsCyINPeBuOqPblxHe
         7UkYNVfkCiUKj650U3z+SNCCLactfTStN5MDsczfRcOR4kMkDYv3K4TDeABDsNVb3J4f
         rg9A==
X-Gm-Message-State: AOAM530W2FlqqnsZK2ojlmU385hRzW7SNvDZeov7US8kPP1oG+0h5XxL
        r/LctcDLFYW+KbPR+fLHOTJrBHhSJYUh1TSvWpE=
X-Google-Smtp-Source: ABdhPJzjIk5X/taXUbcHb6o3jfIzu6D0f+wDd4DBSxZQwzYnVQHTfgTxGozet24Fv8SF0LNwqo41q34ZifXjJonr0AI=
X-Received: by 2002:a2e:5009:0:b0:247:d738:3e90 with SMTP id
 e9-20020a2e5009000000b00247d7383e90mr4881519ljb.229.1647571944316; Thu, 17
 Mar 2022 19:52:24 -0700 (PDT)
MIME-Version: 1.0
References: <CACdtm0YuO+t46wQf9pKu9-U-=vguvwpEu6VXrkXV3JDocFM2qg@mail.gmail.com>
 <2314914.1646986773@warthog.procyon.org.uk> <2315193.1646987135@warthog.procyon.org.uk>
 <CACdtm0Y_F7JjoqvC63+3CU0brETf+iEQ_UjMyx+WzhtwE1HGSw@mail.gmail.com>
 <4085703.1647475640@warthog.procyon.org.uk> <230153.1647562888@warthog.procyon.org.uk>
In-Reply-To: <230153.1647562888@warthog.procyon.org.uk>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 17 Mar 2022 21:52:12 -0500
Message-ID: <CAH2r5mv_V5j_kr=NwCuj1GZesaBVasgZZsHajiCk2Q5UpZ4Lsw@mail.gmail.com>
Subject: Re: cifs conversion to netfslib
To:     David Howells <dhowells@redhat.com>
Cc:     Rohith Surabattula <rohiths.msft@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Paulo Alcantara <pc@cjr.nz>, Jeff Layton <jlayton@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>, natomar@microsoft.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Thu, Mar 17, 2022 at 7:21 PM David Howells <dhowells@redhat.com> wrote:
>
> Hi Rohith, Steve,
>
> I've updated my cifs-experimental branch.  What I have there seems to work
> much the same as without the patches.
>
> I've managed to run some xfstests on it.  I note that various xfstests fail,
> even without my patches, and some of them seem quite slow, again even without
> my patches.
>
> Note that I'm comparing the speed to afs which does a lot of directory
> management locally compared to other network filesystems, so I might be
> comparing apples and oranges.  For example, I can run generic/013 on afs in
> 4-7s, whereas it's 3m-7m on cifs.  However, since /013 does a bunch of
> directory ops, afs probably has an advantage by caching the entire dir
> contents locally, thereby satisfying lookup and readdir from local cache and
> using a bulk status fetch to stat files from a dir in batches of 50 or so.
> This is probably worth further investigation at some point.

Yes - this is a point that Nagendra also made recently that we could
benefit from
some of the tricks that NFS uses for caching directory contents not just the
stat and revalidate_dentry info (e.g. affected by actimeo).

Since the protocol supports directory leases it would be relatively
safe compared
to some other protocols to cache directory contents much more aggressively,
and even without directory leases, other tricks (like directory change
notification
or even simply the mtime on the directory) can be used to cache directory
contents reasonably safely.


-- 
Thanks,

Steve
