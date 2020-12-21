Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C04402DF85D
	for <lists+linux-cifs@lfdr.de>; Mon, 21 Dec 2020 05:48:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727844AbgLUEp5 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 20 Dec 2020 23:45:57 -0500
Received: from mail.kernel.org ([198.145.29.99]:35456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727837AbgLUEp4 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sun, 20 Dec 2020 23:45:56 -0500
Subject: Re: [GIT PULL] CIFS/SMB3 Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1608525916;
        bh=ckurcSdyjQOT39YCaSvKJWDFcA70IHToYtdu4nMTIuc=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Tnp3hUkGEz6FYP9QOAwPeJJ4jJ24avjO7Y21uEwMKm6KXTht+wkAM2QD/Y+0dfRJ3
         mH0c/CvBEGHS5wdgKq6QgursccyKBQVHlsxwDIvHeIaeWCNr0HHQcHzcNGLYznI3++
         RIDjqkqSYsIriHxvQe3wtJT4rIwUHFiId50U/1VQ1XUG6g4wdU0jSEYi29oeSmvzln
         TNx/oTLiUbz0hqobzFTbNxvZ8nwuk3r6Im9Awyim+H7rWwkHYAkcXbT7t8xfHUdn9J
         uFrXA1VrUyrzWLmOvBy7ooz9mnsiGaaL8pyYOTbIs46JJAAZkGVYGich6112/N72E1
         xzfQccTKA/c3w==
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muaG6M=S-E5xXvTTVUJ4_gXR7MA_aDQfOqLprcWMbBYLw@mail.gmail.com>
References: <CAH2r5muaG6M=S-E5xXvTTVUJ4_gXR7MA_aDQfOqLprcWMbBYLw@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muaG6M=S-E5xXvTTVUJ4_gXR7MA_aDQfOqLprcWMbBYLw@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.11-rc-smb3-part2
X-PR-Tracked-Commit-Id: 9541b81322e60120b299222919957becd7a13683
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 582888130702b86daa44ff6bfee585e4d4050ba0
Message-Id: <160852591615.19479.17761001069770171727.pr-tracker-bot@kernel.org>
Date:   Mon, 21 Dec 2020 04:45:16 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The pull request you sent on Sun, 20 Dec 2020 13:47:32 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.11-rc-smb3-part2

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/582888130702b86daa44ff6bfee585e4d4050ba0

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
