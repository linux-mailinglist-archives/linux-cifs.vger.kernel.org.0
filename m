Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5DCAA29831B
	for <lists+linux-cifs@lfdr.de>; Sun, 25 Oct 2020 19:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1418131AbgJYSfS (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 25 Oct 2020 14:35:18 -0400
Received: from mail.kernel.org ([198.145.29.99]:46372 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1418126AbgJYSfS (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sun, 25 Oct 2020 14:35:18 -0400
Subject: Re: [GIT PULL] cifs/smb3 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1603650917;
        bh=rwCwrfCIyCPZU1EXyTmYe+A1dBk/8A7ESdD3EBFh5JM=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=VeIocOoCR7SyJXZemZsdzLHMrgtq8g25ItPfEVCr9+OyaihpcViT/LmNAZ/CINQHn
         0Tl9xjEFPfs39okXEwqJyiaO9A9MoLHz7jy7YzTNV7nwBcUXIHswlWF6zd9puI8gxI
         7/Ce+7ncm7KIF5eRdjWacstibA4MoBv+sAvDj2aE=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvTDPJLQQLWaUUvFdMj4sOv4VKWG3JhVw=CwcxV6NhY+A@mail.gmail.com>
References: <CAH2r5mvTDPJLQQLWaUUvFdMj4sOv4VKWG3JhVw=CwcxV6NhY+A@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvTDPJLQQLWaUUvFdMj4sOv4VKWG3JhVw=CwcxV6NhY+A@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.10-rc-smb3-fixes-part2
X-PR-Tracked-Commit-Id: aef0388aa92c5583eeac401710e16db48be4c9ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c10037f8323d2a94acb4fc6ecfbab0cda152fdd6
Message-Id: <160365091767.20889.4161370901400195229.pr-tracker-bot@kernel.org>
Date:   Sun, 25 Oct 2020 18:35:17 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The pull request you sent on Sat, 24 Oct 2020 17:21:23 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.10-rc-smb3-fixes-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c10037f8323d2a94acb4fc6ecfbab0cda152fdd6

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
