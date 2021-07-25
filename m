Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2D5B83D4AC1
	for <lists+linux-cifs@lfdr.de>; Sun, 25 Jul 2021 02:34:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbhGXXyM (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 24 Jul 2021 19:54:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:50372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229601AbhGXXyL (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sat, 24 Jul 2021 19:54:11 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id ADF4C600D4;
        Sun, 25 Jul 2021 00:34:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627173282;
        bh=Wr+k0F9LGhr559tSyNTKoziwtWchXvOjTd4wEDimnkc=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=Y5dCqxgY1xgirpCQ6kiry83eaSZBHiMFKAzRZUkHsUxyuFl+A9AFxt+BAjAOiGJ6i
         ETVBRVYkpP7qm4L7IQmhvdOtoRSgV++ClA00vwN+Xsi8zWOogMW9iuy/2Sm0D8VH/X
         io9KJc+tnf48jOzr3nmagc/v91+BzM0wcjE4xNJTgtjKPCgr0G1XyexHwxv4BXaqad
         L+RRUCuqJe3RDe4tY3ISZTSWl41zk+Jku8EU5BXliIyHBPhimwW36mJMzsvcS6ELPi
         ntE5ZltHQAfv0IW3ddEATwUnape6GRzJuY79gi8HvWgBSFz2agdFTMP4RVty+TE/30
         4SyrfhCrbhvWg==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 99EE860967;
        Sun, 25 Jul 2021 00:34:42 +0000 (UTC)
Subject: Re: [GIT PULL] CIFS/SMB3 Fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtnAgJo_C_=NRVU_Z6hZByLyv5EKedhr7NY7AcT7-KBXA@mail.gmail.com>
References: <CAH2r5mtnAgJo_C_=NRVU_Z6hZByLyv5EKedhr7NY7AcT7-KBXA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtnAgJo_C_=NRVU_Z6hZByLyv5EKedhr7NY7AcT7-KBXA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.14-rc2-smb3-fixes
X-PR-Tracked-Commit-Id: 488968a8945c119859d91bb6a8dc13bf50002f15
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d8079fac168168b25677dc16c00ffaf9fb7df723
Message-Id: <162717328257.17472.17474909796875893432.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Jul 2021 00:34:42 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The pull request you sent on Sat, 24 Jul 2021 17:20:30 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.14-rc2-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d8079fac168168b25677dc16c00ffaf9fb7df723

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
