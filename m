Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 873ED6D3FF
	for <lists+linux-cifs@lfdr.de>; Thu, 18 Jul 2019 20:32:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391236AbfGRSaW (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 18 Jul 2019 14:30:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:49798 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391228AbfGRSaW (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 18 Jul 2019 14:30:22 -0400
Subject: Re: [GIT PULL] CIFS/SMB3 Fixes
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1563474621;
        bh=pmd53rOtUgsFpxoHIYQStrd3C0m/GR5h+29yHAh/Cwk=;
        h=From:In-Reply-To:References:Date:To:Cc:From;
        b=BLEP4Z71G9uxidZH/s6DJC14ZDnsCMGdEOUfD/RdlxePODI2TfpisUveQx0RZSGup
         Mc43JjXBehZt2953DqP8CuEp14zcQz9nNfAxIT5xA1+JAqEQHb0IHRMykHQuNE/Y5s
         oJGjRIBnbPYNdHRhRKGMMIUVSaWKIg4TqYSJ03C8=
From:   pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5ms6cYqfZvjwJ4m=U4bWktxERb6uz8-RSOaf7B9rzdUg6g@mail.gmail.com>
References: <CAH2r5ms6cYqfZvjwJ4m=U4bWktxERb6uz8-RSOaf7B9rzdUg6g@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5ms6cYqfZvjwJ4m=U4bWktxERb6uz8-RSOaf7B9rzdUg6g@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git
 tags/4.3-rc-smb3-fixes
X-PR-Tracked-Commit-Id: e9630660bd9253b3ed3926e18278b740cf218365
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: ae9b728c8dc0a9939d89f84e8603258ca2a0df22
Message-Id: <156347462168.12683.15157139278148479332.pr-tracker-bot@kernel.org>
Date:   Thu, 18 Jul 2019 18:30:21 +0000
To:     Steve French <smfrench@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        CIFS <linux-cifs@vger.kernel.org>
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The pull request you sent on Thu, 18 Jul 2019 01:10:02 -0500:

> git://git.samba.org/sfrench/cifs-2.6.git tags/4.3-rc-smb3-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/ae9b728c8dc0a9939d89f84e8603258ca2a0df22

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.wiki.kernel.org/userdoc/prtracker
