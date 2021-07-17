Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A3F433CC606
	for <lists+linux-cifs@lfdr.de>; Sat, 17 Jul 2021 22:13:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235163AbhGQUQe (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 17 Jul 2021 16:16:34 -0400
Received: from mail.kernel.org ([198.145.29.99]:37944 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234456AbhGQUQe (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sat, 17 Jul 2021 16:16:34 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id 48B5C610CB;
        Sat, 17 Jul 2021 20:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1626552817;
        bh=mXv2AWLSzGV7cjOOkMzpkblzTOH81G8M/4AIsEvAWkM=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=l+aItfC22jCFCdDSB9qIotQrTe0sMlqfVDHgz1ZRp/HNEXy9KdsnmDgehhEmoYTWt
         hK+Fbo92ioTRUZGq/PawmAtcw1yLjb/n1LQLH5fwwHvpgwvFfo6eMdcn8gnp7+LDf3
         foF0RjenAgjHw1ZNQg27sDkQzXUI6uXcLy8NaU7PhZlMZp1AEso1kYawEJsLY+oHAW
         U8NFvCyIG5+ZysnQ1QFl56eF8MBLcEJ6P0cripozR61H4ZtZIh6QKQizbL/KCGvkS0
         AVdSOP0pHgWpSZwaw8bj0klYv7I5ago2lIxzuZnOPBmpnemfI94lAI2A4siktRkulN
         JEMne4j+68vPA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id 3DCE160A23;
        Sat, 17 Jul 2021 20:13:37 +0000 (UTC)
Subject: Re: [GIT PULL] CIFS/SMB3 Fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5munsckwgOj8BknkB1pu+oktLTDJA8hN1cHbDucQXVJ2Nw@mail.gmail.com>
References: <CAH2r5munsckwgOj8BknkB1pu+oktLTDJA8hN1cHbDucQXVJ2Nw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5munsckwgOj8BknkB1pu+oktLTDJA8hN1cHbDucQXVJ2Nw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.14-rc1-smb3-fixes
X-PR-Tracked-Commit-Id: cdc3363065aba2711e51019b3d5787f044f8a133
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 44cb60b425ab5221a2567e420f5088ff4315c57a
Message-Id: <162655281719.27873.5172880899513558575.pr-tracker-bot@kernel.org>
Date:   Sat, 17 Jul 2021 20:13:37 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The pull request you sent on Fri, 16 Jul 2021 19:17:01 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.14-rc1-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/44cb60b425ab5221a2567e420f5088ff4315c57a

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
