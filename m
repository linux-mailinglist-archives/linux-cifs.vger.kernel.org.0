Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F284A1D65E9
	for <lists+linux-cifs@lfdr.de>; Sun, 17 May 2020 06:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgEQEpF (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 17 May 2020 00:45:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:38680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726979AbgEQEpE (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sun, 17 May 2020 00:45:04 -0400
Subject: Re: [GIT PULL] CIFS Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589690704;
        bh=ttZOMs5Oa9OIrdHh0/i9OPv396ks8JP/KwniQOvVbdQ=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=JJWpBsbze2/RRRZw/hXd6RgxwL/D8QO9CuxQVKrwBMmd6uJ/ExPWM6A1+jahGDfsR
         ++ha4MOjQ9J7IaR34lZ5ANV/bV1DKIJzsgWmAn0SltZIy+pQ3oOgRCE3i7395XIxTr
         oODOPb34bVBa+xXjdLpRVYGQNqKGFNHLE6LgTa3M=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mtJLcARTXSEjNjWnDacyr4MEcJk6TxZCu2mFy-_38uQng@mail.gmail.com>
References: <CAH2r5mtJLcARTXSEjNjWnDacyr4MEcJk6TxZCu2mFy-_38uQng@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mtJLcARTXSEjNjWnDacyr4MEcJk6TxZCu2mFy-_38uQng@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.7-rc5-smb3-fixes
X-PR-Tracked-Commit-Id: a48137996063d22ffba77e077425f49873856ca5
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 5a9ffb954a3933d7867f4341684a23e008d6839b
Message-Id: <158969070438.26561.12889104890106664496.pr-tracker-bot@kernel.org>
Date:   Sun, 17 May 2020 04:45:04 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The pull request you sent on Sat, 16 May 2020 21:45:57 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.7-rc5-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/5a9ffb954a3933d7867f4341684a23e008d6839b

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
