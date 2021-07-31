Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0E59B3DC6EE
	for <lists+linux-cifs@lfdr.de>; Sat, 31 Jul 2021 18:32:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbhGaQca (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 31 Jul 2021 12:32:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:39350 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229449AbhGaQca (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sat, 31 Jul 2021 12:32:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPS id D1CA760F13;
        Sat, 31 Jul 2021 16:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1627749143;
        bh=U98qu25SJMulk/dJa2lRpUsz8dJeZS1hVWuXwKBXD48=;
        h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
        b=QtWR1CpJYjaapVLNqt6foT4GFofNGwcRcdDWegJec+C5tEZVSjX3sKDmtiiBeEhvf
         LSxhRdEhI8QSxqn7u/PrJL5J8Bd3EmQNUu11xpDmFYunFXgHYybnkWUCtvBndLJQ8Y
         QDbRUBwQ8LhvVZRIIOVxmHeRDJ8g0blHECTN1i5OBUePTEAYUwYHRp4i5oOHdzAnNS
         lvEcqN2z7tMMweHiiRMu1qd/h9FGvlLMd2txInOllUr95yNZeXiGv9Y46NurkFKz39
         1VX/GrCTVnmrzqr2OHx7qTLaRvIxVQGm8GBb9QzXnamqVYEM4u3GdW0NDi51qW21MH
         j+99nYEqcCMqA==
Received: from pdx-korg-docbuild-2.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
        by pdx-korg-docbuild-2.ci.codeaurora.org (Postfix) with ESMTP id BE01E60963;
        Sat, 31 Jul 2021 16:32:23 +0000 (UTC)
Subject: Re: [GIT PULL] CIFS/SMB3 fixes
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msGVA44tK4+9YAm-vrH0sAL8WqPPfdnU5Uk5++jCqoJYQ@mail.gmail.com>
References: <CAH2r5msGVA44tK4+9YAm-vrH0sAL8WqPPfdnU5Uk5++jCqoJYQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msGVA44tK4+9YAm-vrH0sAL8WqPPfdnU5Uk5++jCqoJYQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.14-rc3-smb3-fixes
X-PR-Tracked-Commit-Id: b946dbcfa4df80ec81b442964e07ad37000cc059
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: f3438b4c4e692b49b7dc2bab864d20381024be16
Message-Id: <162774914372.27499.5669882027343979348.pr-tracker-bot@kernel.org>
Date:   Sat, 31 Jul 2021 16:32:23 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The pull request you sent on Fri, 30 Jul 2021 16:09:46 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.14-rc3-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/f3438b4c4e692b49b7dc2bab864d20381024be16

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html
