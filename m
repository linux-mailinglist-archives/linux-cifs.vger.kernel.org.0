Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 393B02F8912
	for <lists+linux-cifs@lfdr.de>; Sat, 16 Jan 2021 00:02:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726556AbhAOXBw (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 15 Jan 2021 18:01:52 -0500
Received: from mail.kernel.org ([198.145.29.99]:33672 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726785AbhAOXBt (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 15 Jan 2021 18:01:49 -0500
Received: by mail.kernel.org (Postfix) with ESMTPS id 3ACB223382;
        Fri, 15 Jan 2021 23:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1610751669;
        bh=RMSOSi30+VbDhnELhEOOyTf3qIoQYHy5AloVA5RozOo=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=MLd3QgqX3+fuxPFwAhzi2UlJQ+uf4caNl5J2cL6OQ9l24hH/2ebKcA3tsr3f9QZ8B
         9MQ35pbkrbHwtMSi4XcvD5MArSCtnMrnxyI8hMgUQpRV/0upL5ezYyAZACahvyj45j
         HuMZaqa92Eb/r/aC6rA00FUs6Eh1uLQ828v2Hx3rkDDTHEqN2Jh5br0R5jlMdHVg2B
         HZ47XELzIDABKuDjkiO4BpRcXu1PeeudKp0LUT+U2u+FljGQGIYdH2Z80ZJDHxFboS
         XszltwDFdhuaG+8brg9M7XTj/GeSBTkM4fOUjNwhfIeXhGgS71FAivmzr7CZt+jjxi
         WTxqRmwfEpnCQ==
Received: from pdx-korg-docbuild-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-1.ci.codeaurora.org (Postfix) with ESMTP id 3026760593;
        Fri, 15 Jan 2021 23:01:09 +0000 (UTC)
Subject: Re: [GIT PULL] CIFS/SMB3 Fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mv163xBnRSDV24YJwtxtJJn2zjC4TY1-RS8=G7dLTskFw@mail.gmail.com>
References: <CAH2r5mv163xBnRSDV24YJwtxtJJn2zjC4TY1-RS8=G7dLTskFw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mv163xBnRSDV24YJwtxtJJn2zjC4TY1-RS8=G7dLTskFw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.11-rc3-smb3
X-PR-Tracked-Commit-Id: e54fd0716c3db20c0cba73fee2c3a4274b08c24e
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cd3c41261889e3ee899cd5b1583178f5fbac55e
Message-Id: <161075166919.23598.13795343815806353356.pr-tracker-bot@kernel.org>
Date:   Fri, 15 Jan 2021 23:01:09 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The pull request you sent on Thu, 14 Jan 2021 23:56:31 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.11-rc3-smb3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cd3c41261889e3ee899cd5b1583178f5fbac55e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
