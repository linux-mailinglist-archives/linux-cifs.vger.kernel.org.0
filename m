Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE79125700C
	for <lists+linux-cifs@lfdr.de>; Sun, 30 Aug 2020 21:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727065AbgH3TRM (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 30 Aug 2020 15:17:12 -0400
Received: from mail.kernel.org ([198.145.29.99]:44428 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726465AbgH3TPd (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sun, 30 Aug 2020 15:15:33 -0400
Subject: Re: [GIT PULL] CIFS Fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598814932;
        bh=Smp7rdArAfXO/SuafC7EkEbhf4T/X6GhDs3NyOWaSMo=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=R5suTdPIVuTJxcOJu38LSAoXO1pr7UDCmvDe4wrbogFfcWNjj8w5JVjJPTpi7V038
         volIrx5wtIL8IJjhunczhhpJv2PHteaz4uXkXDqQ10x/WybF1hhS0APkV8v9ocHYpG
         dC0Od7DZFhjbETVWl36X09KYWkaDcMsoK3qpgnVM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvs8Rdy_615XjMea7cCL1YrWthhr=GJW0ffTyDUwjtSrg@mail.gmail.com>
References: <CAH2r5mvs8Rdy_615XjMea7cCL1YrWthhr=GJW0ffTyDUwjtSrg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvs8Rdy_615XjMea7cCL1YrWthhr=GJW0ffTyDUwjtSrg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.9-rc2-smb-fix
X-PR-Tracked-Commit-Id: e183785f2529b4135f00a0330a3b08e7c86530c8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 3edd8db2d53fe6c96ad66248bb1479ae62807268
Message-Id: <159881493275.11937.16692614311127964701.pr-tracker-bot@kernel.org>
Date:   Sun, 30 Aug 2020 19:15:32 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The pull request you sent on Sun, 30 Aug 2020 10:24:33 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.9-rc2-smb-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/3edd8db2d53fe6c96ad66248bb1479ae62807268

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
