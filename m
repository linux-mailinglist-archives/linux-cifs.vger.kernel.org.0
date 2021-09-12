Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6A6407F71
	for <lists+linux-cifs@lfdr.de>; Sun, 12 Sep 2021 20:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234185AbhILSm1 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 12 Sep 2021 14:42:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:41006 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232959AbhILSm0 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sun, 12 Sep 2021 14:42:26 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 9BAE56101E;
        Sun, 12 Sep 2021 18:41:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1631472071;
        bh=uwXI0BwolZBy7OOpJeTopjZIn1eYeqmB6DQGNnXD8BA=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=FrL6wcImUUGSMkUqh9fNIiTIR1z57VS02PggnhrQoWwz1bZad9Zr7SeDZIrvaCUV7
         U62MTPPrX5cJZg2eT8f+MWhuMSVlrWphf8CL7+MCXPQP+KBkJRzUKIW3fj9cgjY+pV
         9R98NuQ6eZ1KzWf0CmRL2BrUgPi/RMBWBtbMdYeOPPWsgJZtJ+Mv4XZq8t5dtRnv2t
         msuB9dPRcpc6lBfFMbjHewLttZ87YkGEFAUjP/CBuBxmpqfDx2mSjuCYIEan4JFAJA
         sRMxI/eldbPdbQFcXgAg0FGnrkteIBcsJ3E+w3HIa4VMqkWZ0kVaYYiTUzoaOymHXN
         UbIJNbqliyBgA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 88F3960A47;
        Sun, 12 Sep 2021 18:41:11 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5ms8Tbj+Jwo6pgM--fGtOBW3vyaSkU==959G=-HtoT5EzQ@mail.gmail.com>
References: <CAH2r5ms8Tbj+Jwo6pgM--fGtOBW3vyaSkU==959G=-HtoT5EzQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5ms8Tbj+Jwo6pgM--fGtOBW3vyaSkU==959G=-HtoT5EzQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.15-rc-cifs-part2
X-PR-Tracked-Commit-Id: 9351590f51cdda49d0265932a37f099950998504
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8d4a0b5d0813c990637fa9f3c9bea5dab1fedb8f
Message-Id: <163147207150.12542.3473838924458417090.pr-tracker-bot@kernel.org>
Date:   Sun, 12 Sep 2021 18:41:11 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The pull request you sent on Sat, 11 Sep 2021 12:23:54 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.15-rc-cifs-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8d4a0b5d0813c990637fa9f3c9bea5dab1fedb8f

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
