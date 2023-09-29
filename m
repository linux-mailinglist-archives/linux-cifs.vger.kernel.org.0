Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAD497B3D1C
	for <lists+linux-cifs@lfdr.de>; Sat, 30 Sep 2023 01:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233940AbjI2X7V (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 29 Sep 2023 19:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbjI2X7U (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 29 Sep 2023 19:59:20 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C1C1B6
        for <linux-cifs@vger.kernel.org>; Fri, 29 Sep 2023 16:59:18 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A973C433C7;
        Fri, 29 Sep 2023 23:59:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1696031958;
        bh=blXM8q0s9d30rxXtniK8B1twXeeX4xm4+gnmad6JMCU=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=TBWX4325ZLhWLB5IiJubLXidwX+BG5EkF6JC6Dd0Npg3SUYbeOk5TqnvcSm2qfNn2
         gQ4qWj2CKUWY4uIKcCapSIPa2Uo928wDg9QkljZ9OPnow8+kTk62Kh274Nvj3Dgxcb
         DcveRKXwczuxVUkbqwBojgRFxpNQMA0KO3XwaTWmHo0kYyGl7sR29bTdqDKN7tH8Qh
         MCPoz5aCIYXbKaiavH3FNa0fKzcJRnNgNzem31LWX6uXupc6rwwWB2A7x3FH+fS04G
         HOUzDawOaTgjitfYO3ThUopvnFRTGiqIo5Bf8oID8427OLaHt7AM+CYYWJ3mmV9wfu
         KJUCJPzP8voIw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 773EEC395C5;
        Fri, 29 Sep 2023 23:59:18 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muVLJV1oqGcGgrgYJynrGS-FwwpvF7wQ=SbW6LfpXY8Xw@mail.gmail.com>
References: <CAH2r5muVLJV1oqGcGgrgYJynrGS-FwwpvF7wQ=SbW6LfpXY8Xw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muVLJV1oqGcGgrgYJynrGS-FwwpvF7wQ=SbW6LfpXY8Xw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/6.6-rc3-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: 73f949ea87c7d697210653501ca21efe57295327
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 9f3ebbef746f89f860a90ced99a359202ea86fde
Message-Id: <169603195848.31385.15693572325810014859.pr-tracker-bot@kernel.org>
Date:   Fri, 29 Sep 2023 23:59:18 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Namjae Jeon <linkinjeon@kernel.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The pull request you sent on Fri, 29 Sep 2023 17:11:25 -0500:

> git://git.samba.org/ksmbd.git tags/6.6-rc3-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/9f3ebbef746f89f860a90ced99a359202ea86fde

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
