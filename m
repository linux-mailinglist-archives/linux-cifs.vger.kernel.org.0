Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 226FC20C4BD
	for <lists+linux-cifs@lfdr.de>; Sun, 28 Jun 2020 00:45:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgF0WpO (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 27 Jun 2020 18:45:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:43170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726789AbgF0WpN (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sat, 27 Jun 2020 18:45:13 -0400
Subject: Re: [GIT PULL] SMB3 Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1593297913;
        bh=O/YiF5uN7AprGzsXhnqP7AWeZIx0x4rNY/xL3gq71U0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=l1zUStkJP1ApIJPZ5oI5sCbJCmo+urQP4p9lHkPzHdKLHMsGxHyNB5zVVg5+p6GCp
         iQ23KhBbpsp+cYMDEjG4rA3KZ/3f+h4h7+K0fzwfBXN5CdB0IJXPWFHxt7qzyQKvCm
         Xy7NUjtdqx8IIuHJmMqRn7kpDpv50aGZwUgOsMy4=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mseacQ-UN7HB8U3KWcJFO5yciGMFPBYLw2GwqhWRD43Xg@mail.gmail.com>
References: <CAH2r5mseacQ-UN7HB8U3KWcJFO5yciGMFPBYLw2GwqhWRD43Xg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mseacQ-UN7HB8U3KWcJFO5yciGMFPBYLw2GwqhWRD43Xg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.8-rc2-smb3-fixes
X-PR-Tracked-Commit-Id: bf1028a41eaf0ce39518cbdda34cdb717f16364a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 916a3b0fc1206f7e7ae8d00a21a3114b1dc67794
Message-Id: <159329791342.3578.17783629478391524621.pr-tracker-bot@kernel.org>
Date:   Sat, 27 Jun 2020 22:45:13 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The pull request you sent on Sat, 27 Jun 2020 15:11:00 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.8-rc2-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/916a3b0fc1206f7e7ae8d00a21a3114b1dc67794

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
