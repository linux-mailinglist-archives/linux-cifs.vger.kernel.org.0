Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC0193269F8
	for <lists+linux-cifs@lfdr.de>; Fri, 26 Feb 2021 23:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230194AbhBZWYr (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 26 Feb 2021 17:24:47 -0500
Received: from mail.kernel.org ([198.145.29.99]:56104 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230188AbhBZWYo (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 26 Feb 2021 17:24:44 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 0082564EDC;
        Fri, 26 Feb 2021 22:24:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614378244;
        bh=+hzBGNHo1Ja3QWInOpdwfAgoAKXVu+HpUUba/tpuPqM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=H3JMLNFRUUzC/79sl/t2UzLoqDL8zI90b8shWeC2oDCDLHRPXGnRIbItEOX58nW5b
         82pfFD5rEXku1y3VIWZNL5VVjvlv61wiFrfQqkTvTNJZ1V0gK8A1LgQAHSMboE1tl3
         htm/EJ+SMZ02BeMTu5iSRKzdE0Heax/uyMVgrdU9fpTCTDfjBzh0lZoQ0oN6JyF2LG
         EqCzgCwwalnpWcVmbT9tqZ6Xak56t61WRwoBTWdg4jJcegCPPHw5ZYo6xKNVsfhCJf
         qvnaD7/tHGrR+Bf7qVIq0iVeqeP5vG8Ry5H0RVTwtDQzt88tIHDk7kcenuwSxxFmIs
         LhXJZC2nSVTZQ==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id ED6B9609D0;
        Fri, 26 Feb 2021 22:24:03 +0000 (UTC)
Subject: Re: [GIT PULL] CIFS/SMB3 Fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mudreWgQdGQPSn++0H6zzY-3fcCZvxga7PcNqt4EDWo9Q@mail.gmail.com>
References: <CAH2r5mudreWgQdGQPSn++0H6zzY-3fcCZvxga7PcNqt4EDWo9Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mudreWgQdGQPSn++0H6zzY-3fcCZvxga7PcNqt4EDWo9Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.12-smb3-part1
X-PR-Tracked-Commit-Id: 8369dfd7841e70711c53a065ffb8029f24520200
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c19798af2e66d9d3eb1060873bb435ea8bf4ad2e
Message-Id: <161437824396.23821.5006687014334203070.pr-tracker-bot@kernel.org>
Date:   Fri, 26 Feb 2021 22:24:03 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The pull request you sent on Fri, 26 Feb 2021 00:24:14 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.12-smb3-part1

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c19798af2e66d9d3eb1060873bb435ea8bf4ad2e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
