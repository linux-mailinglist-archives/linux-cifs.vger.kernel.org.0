Return-Path: <linux-cifs+bounces-998-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C2A7B83EEF9
	for <lists+linux-cifs@lfdr.de>; Sat, 27 Jan 2024 18:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 435CD1F21B0B
	for <lists+linux-cifs@lfdr.de>; Sat, 27 Jan 2024 17:21:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 529282D022;
	Sat, 27 Jan 2024 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MbL0wA/s"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B4D82C877;
	Sat, 27 Jan 2024 17:21:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706376071; cv=none; b=fK2mjZ6R3G3uii8zo/e2Wxx+3VTH3IpCjHbO+lhpIQw4khUHi79FiILNOUZoHM7NJ4YPrLoXxnHlqCaTVwNHQHdjWdu2NTSJJ3WIcS32IVQlfGUtjvytyXEcFx2eTpWQEO+fsjWKBjfJXa1RVsVLJRryIYI/Cb2V2997xfW3t+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706376071; c=relaxed/simple;
	bh=HEBUVWd0O1hYPcnE4Fe4IwKRVt6KU+VF2yNSDmEwea0=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=p+CyOzlwe/4HVdi10dYveWMnTr0ZnF8B8CjJBkYuesUm0Ln515H8//VfDVie33W6WJC84cRoPIdZL7SbYeY2gy6TyYSybTo0Q+QJbegRtixeH+5pcD0DmxsnoWKVyV8YaCmRowcZoNCyV+xO/tKqXiaAAgZ96LSTTmEl1RZDGpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MbL0wA/s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 01115C433C7;
	Sat, 27 Jan 2024 17:21:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706376071;
	bh=HEBUVWd0O1hYPcnE4Fe4IwKRVt6KU+VF2yNSDmEwea0=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=MbL0wA/slYjngdjd8HZNQry1QYtZDWMVhRfxuCP60CMwf8dZjyCvdbpblg6mXmePZ
	 qYSangfj7X3Ebmtz0W/wMwIBpRMuAGfOOAe8M6Z0QoVNjlDfYaXIdPhXXFhKc9T/Qo
	 jDEya/nwWtORSQwCINYGDt1l45iOEPGtjmGRQomH1V8UPp9RNGI779rtpPZijx2sTj
	 OHKOnGtCh5ePiSN1OpSw6kmCZwoe8XHjlEWiDABoNTZKGFJw92NZ9fcteyxmMHvPUe
	 JA8r9HowN5Gw3zq4GnwOS09yqyOA+wnM8qi/nCLomhqT3CSjc0wFAkKZGIg8uMaYok
	 sR7I19hLHulOQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id E0A94DFF760;
	Sat, 27 Jan 2024 17:21:10 +0000 (UTC)
Subject: Re: [GIT PULL] smb3 client fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5muRNnOw_2Qs8C=7MC8f8xLHwLGDo4wVOd5q6kG_Wg-CgQ@mail.gmail.com>
References: <CAH2r5muRNnOw_2Qs8C=7MC8f8xLHwLGDo4wVOd5q6kG_Wg-CgQ@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5muRNnOw_2Qs8C=7MC8f8xLHwLGDo4wVOd5q6kG_Wg-CgQ@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/sfrench/cifs-2.6.git tags/6.8-rc1-smb3-client-fixes
X-PR-Tracked-Commit-Id: 993d1c346b1a51ac41b2193609a0d4e51e9748f4
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: d1bba17e20d513e09d0977afc82cd85b91d0fef8
Message-Id: <170637607091.5716.14851862819504981547.pr-tracker-bot@kernel.org>
Date: Sat, 27 Jan 2024 17:21:10 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>

The pull request you sent on Fri, 26 Jan 2024 16:25:53 -0600:

> git://git.samba.org/sfrench/cifs-2.6.git tags/6.8-rc1-smb3-client-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/d1bba17e20d513e09d0977afc82cd85b91d0fef8

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

