Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD61A2C04
	for <lists+linux-cifs@lfdr.de>; Fri, 30 Aug 2019 03:00:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727294AbfH3BAH (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 29 Aug 2019 21:00:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:56620 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726991AbfH3BAH (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 29 Aug 2019 21:00:07 -0400
Subject: Re: [GIT PULL] CIFS/SMB3 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1567126806;
        bh=ZUShZNpFUixyVLuy8uYDVHWxr3Ryo5KoxN+jOx6fv20=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=mkSO3pFVbVUSlsF8jBnzswcsGH1l8Fwtvf7ncgbk4FJWYWMgO2IirG9AkDFaE2c66
         nG0lpaZLW1eDUCM2HSD3ICtH9iBvOMFNX8ZOE8EqubIeQTTnkXD65tzkA+By+qeR6c
         KMQlmo7IRq5Hw4DqoCQu8sjMeofedSFbB3q2e+Aw=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5msAQiYEoNCSqQYv8vHO09hgNjt0ExS+e0tE4eNj6e9ALQ@mail.gmail.com>
References: <CAH2r5msAQiYEoNCSqQYv8vHO09hgNjt0ExS+e0tE4eNj6e9ALQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5msAQiYEoNCSqQYv8vHO09hgNjt0ExS+e0tE4eNj6e9ALQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.3-rc6-smb3-fixes
X-PR-Tracked-Commit-Id: 36e337744c0d9ea23a64a8b62bddec6173e93975
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 26538100499460ee81546a0dc8d6f14f5151d427
Message-Id: <156712680671.29395.1688818799072231923.pr-tracker-bot@kernel.org>
Date:   Fri, 30 Aug 2019 01:00:06 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The pull request you sent on Thu, 29 Aug 2019 17:54:38 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.3-rc6-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/26538100499460ee81546a0dc8d6f14f5151d427

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
