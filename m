Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC2022DA39
	for <lists+linux-cifs@lfdr.de>; Sun, 26 Jul 2020 00:30:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728256AbgGYWaH (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 25 Jul 2020 18:30:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:59032 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728253AbgGYWaH (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sat, 25 Jul 2020 18:30:07 -0400
Subject: Re: [GIT PULL] CIFS Fix
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595716206;
        bh=/NjHQrw2DSxtORPlDdlH9dbJmmGdFhBePiVrPliOWw0=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=DSeNEiKb28umHhmS1QYt0yc2Vl/kkqr3uZFj7muaV8qZe/yXLtBjrmUat0UwbpRcx
         pnlZ8DmIldLSsiSVMWEbw99Pi3/pW2zG2FMR1A92lTsaYYb7SNN1xhrWO8FBxOrcx6
         yz6zjcZQn4Mr5gNHipg3UUFOSM5E8I8aHe/IM4Qo=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mt_fhSnNDaCdn=DKE9_TkLMZQtCZ9hTTDVQmk5RL9PTbg@mail.gmail.com>
References: <CAH2r5mt_fhSnNDaCdn=DKE9_TkLMZQtCZ9hTTDVQmk5RL9PTbg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mt_fhSnNDaCdn=DKE9_TkLMZQtCZ9hTTDVQmk5RL9PTbg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.8-rc6-cifs-fix
X-PR-Tracked-Commit-Id: 0e6705182d4e1b77248a93470d6d7b3013d59b30
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7cb3a5c5f6478ac0c14d01e35bc49e0ba7525e21
Message-Id: <159571620684.7388.1800445024865272164.pr-tracker-bot@kernel.org>
Date:   Sat, 25 Jul 2020 22:30:06 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The pull request you sent on Fri, 24 Jul 2020 21:38:36 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.8-rc6-cifs-fix

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7cb3a5c5f6478ac0c14d01e35bc49e0ba7525e21

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
