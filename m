Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 14E01178665
	for <lists+linux-cifs@lfdr.de>; Wed,  4 Mar 2020 00:35:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728430AbgCCXfH (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 3 Mar 2020 18:35:07 -0500
Received: from mail.kernel.org ([198.145.29.99]:58070 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728397AbgCCXfG (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 3 Mar 2020 18:35:06 -0500
Subject: Re: [GIT PULL] CIFS/SMB3 fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1583278506;
        bh=ZlBKWC3CUezAAxbExyTg5tGLv2MO1gZ5mK5qFbekgqI=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=yWJW7nNd+Qz+23ai6WAaueun8nhZLw2+pGspTcjxraRYbCb5GY87rzjrglCxRV0sx
         RyCp7NfrkfunF1MB84vsN9PnO80u7iVZ0QUJGDg8eGuBboz4B/m7ytEWzrwm4f3C8W
         bkAhb+CE/vPrhd/yZFyqlBTboblc6XsImmDUklrM=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muzDocCzjYJ_ahYXz3G2e=UA4jmfowbHBMt4iWsu6+yVg@mail.gmail.com>
References: <CAH2r5muzDocCzjYJ_ahYXz3G2e=UA4jmfowbHBMt4iWsu6+yVg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muzDocCzjYJ_ahYXz3G2e=UA4jmfowbHBMt4iWsu6+yVg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/5.6-rc4-smb3-fixes
X-PR-Tracked-Commit-Id: fb4b5f13464c468a9c10ae1ab8ba9aa352d0256a
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8b614cb8f1dcac8ca77cf4dd85f46ef3055f8238
Message-Id: <158327850616.6555.3784579214335282200.pr-tracker-bot@kernel.org>
Date:   Tue, 03 Mar 2020 23:35:06 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The pull request you sent on Tue, 3 Mar 2020 14:22:30 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/5.6-rc4-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8b614cb8f1dcac8ca77cf4dd85f46ef3055f8238

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
