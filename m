Return-Path: <linux-cifs+bounces-853-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D8AE83540B
	for <lists+linux-cifs@lfdr.de>; Sun, 21 Jan 2024 01:59:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 55AF6282369
	for <lists+linux-cifs@lfdr.de>; Sun, 21 Jan 2024 00:59:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1E661A73F;
	Sun, 21 Jan 2024 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h7lwKZxN"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B0B41AAA2;
	Sun, 21 Jan 2024 00:59:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705798781; cv=none; b=fR+vps8iRfw+tQ4bsHCYFrq0qh/1q5lJiLdpQaElooMvmlVN1tcdQJz1rBt+gBHsaEQvWJTYUSUZG0WTI8vtVT0WIwRCM86nfz/fCu4VwrAxndavZGR1kBlDEHkaDlzlf9MdqGKArMIqPpnwpUa4nHdIDDvTnk2oExwNROWE5bE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705798781; c=relaxed/simple;
	bh=fNRCPPNNJHA9qQsw7PBZuv7haJE79krH5N73O/ICrsQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=tevWuP5JE2vPCciW0v9VKTUrAg0OOir5B2xBkAuENITMm0KYUV3o2pSWyaBjLqv8oMHLdIOQTUxYXYVRAlA2vPx6luoOCkVAgHYG65ZLA/Cr1QlVSetjgVbfLex8CE1KA7gQEheZRDf6q4SiUb9ydhkG09WfvDOJcYjBz4CTdks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h7lwKZxN; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 72565C43390;
	Sun, 21 Jan 2024 00:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705798781;
	bh=fNRCPPNNJHA9qQsw7PBZuv7haJE79krH5N73O/ICrsQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=h7lwKZxNtBBdp5oznAvybFf98IBI1kih5y3i/lhsFQoibpQ1xaqsLctIXbG3xqm3J
	 RfFBSRM4f8l5O3c7J1EUXUCm/9+KyMwAWCz/19VxfB5KsmVx6n2nytl/caEW1sHjWs
	 mbKIpzMB3WNPsb+xhGffIi56eD0h6VT93ECyd13a5K3jb6LJ9/b814YCvFWDT0vF3I
	 TjGYGj1QT+m3FH9MluUB77TC2Vt5z4YwSXnJ21QLzKoJvHbpPLH00Z1BGK1UD4wqDJ
	 V3CO5mJHYCcq8coy3gWhpxu/e6zd6AZJ5/yA4CtR2kTKJpZg1pzI0xJAP8MlJsXlCo
	 8lah35zMUfRWw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 61A6AD8C96C;
	Sun, 21 Jan 2024 00:59:41 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvR+MhHoeJiULtRQ2=D8doE31i9nmH0Jr5rLTf1K3KFiA@mail.gmail.com>
References: <CAH2r5mvR+MhHoeJiULtRQ2=D8doE31i9nmH0Jr5rLTf1K3KFiA@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvR+MhHoeJiULtRQ2=D8doE31i9nmH0Jr5rLTf1K3KFiA@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/v6.8-rc-part2-smb-client
X-PR-Tracked-Commit-Id: 78e727e58e54efca4c23863fbd9e16e9d2d83f81
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 7a396820222d6d4c02057f41658b162bdcdadd0e
Message-Id: <170579878139.11303.4387435807973838893.pr-tracker-bot@kernel.org>
Date: Sun, 21 Jan 2024 00:59:41 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>

The pull request you sent on Sat, 20 Jan 2024 17:30:06 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/v6.8-rc-part2-smb-client

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/7a396820222d6d4c02057f41658b162bdcdadd0e

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

