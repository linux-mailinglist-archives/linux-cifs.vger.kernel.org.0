Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 193CFD49F3
	for <lists+linux-cifs@lfdr.de>; Fri, 11 Oct 2019 23:35:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729133AbfJKVfH (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 11 Oct 2019 17:35:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:57276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726255AbfJKVfG (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 11 Oct 2019 17:35:06 -0400
Subject: Re: [GIT PULL] SMB3 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1570829706;
        bh=k3N+q3Kc0pFtCdUFv8UE1R0g5qFghOHbS19IcSqpwWg=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=Q3Au5qZYdi8SDS/y9uQ73T5WdEj3d7UI2GDeVPvNF3+hSKgyAvfYwhpJI+06vJmAn
         zmfTTIzAa8D0fIvdRSlWL5KAFqqpuhldyLGe3h+K3hej4Ei58JeEOyMa5opoHJ6z9j
         VLJMQknCan2rNrCiGTLny7X3O+yGrqWKWUsGip+Q=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mt06W-HjArS-+XMRjuY9FvMrZGWndKn0M8-0tc=jMmG-g@mail.gmail.com>
References: <CAH2r5mt06W-HjArS-+XMRjuY9FvMrZGWndKn0M8-0tc=jMmG-g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mt06W-HjArS-+XMRjuY9FvMrZGWndKn0M8-0tc=jMmG-g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/5.4-rc2-smb3
X-PR-Tracked-Commit-Id: 0b3d0ef9840f7be202393ca9116b857f6f793715
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: c6ad7c3ce9800e91d6cc6d2f6f566339ebac5656
Message-Id: <157082970639.1897.13945525587412899960.pr-tracker-bot@kernel.org>
Date:   Fri, 11 Oct 2019 21:35:06 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The pull request you sent on Fri, 11 Oct 2019 15:40:26 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.4-rc2-smb3

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/c6ad7c3ce9800e91d6cc6d2f6f566339ebac5656

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
