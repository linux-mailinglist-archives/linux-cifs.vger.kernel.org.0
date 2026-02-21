Return-Path: <linux-cifs+bounces-9488-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EAMnOf35mWmuXgMAu9opvQ
	(envelope-from <linux-cifs+bounces-9488-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Sat, 21 Feb 2026 19:31:25 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 625FB16D825
	for <lists+linux-cifs@lfdr.de>; Sat, 21 Feb 2026 19:31:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3749B30459FA
	for <lists+linux-cifs@lfdr.de>; Sat, 21 Feb 2026 18:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF0F11FC7C5;
	Sat, 21 Feb 2026 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K1WiqWkZ"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC30114A4F9;
	Sat, 21 Feb 2026 18:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771698676; cv=none; b=rWU5H4fyhWpOLjafpTfYU+bqVYNew/npB1Lniri8iCPaU3n9/oU3jMpFmEHpai+65V0nXZs7yx2PNypolMZvCOxq/sgoWwmuHGgww43el6NpEIdln5B12U9c7aqoop/fqwKjSrkE4TLJ3L6cl0AbIGFZ9ofJ+Du4GsGrB8Sd2xo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771698676; c=relaxed/simple;
	bh=Qx9RX9bB27dMy7iOcR7k2AYzJrr4qc83DkUlpytpeQY=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=dczU3U8EqstG07/t1ichF7f71SVpaviXJkNyCHBFLr0/HNbrRPD8r5fifrRaMir26zOQx3zHf6iVyNQcar+++F/HwS39NDFg3MWeK87o4ZQHMFLp4/H2YeCqz6o79M7moEiV4NysHJ/fdz46X07N3g/KjYzyv1yjb3HKW8cis1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K1WiqWkZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 58B30C19421;
	Sat, 21 Feb 2026 18:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1771698676;
	bh=Qx9RX9bB27dMy7iOcR7k2AYzJrr4qc83DkUlpytpeQY=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=K1WiqWkZHrC2T36LYQGL2X8dybNjqAbxZc8r8MdpozRS6RMd0pqCSw9DU5TseJnsP
	 Fy56BNPUAfG4g88NKmh2shFJ7igTX08IdFP4+AU5Cy6gp6OSlpIjrrrAs1ap7U18df
	 GWBOXX9Q7PhfZSN9bhIFd1fhoiu96zHaMqBWM+WKyBJ1CbOpsXIh0PM+0/XSQa4yFA
	 iVkB1GPed7hXPE7R/L5SNjw8C7L/UGCHhX25ZVKqHKR7dUn9TZ2hOYrVBsKUfXW+UO
	 g4ISUFR18hHWA6sRHOUGoNcZnWIrvFMotDxND3Sd3AjQpHKEz+j/DwFz4eW8329KvO
	 zGm30pwWPGXAA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DB63808200;
	Sat, 21 Feb 2026 18:31:25 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mv80H+O0VYjCuUk6ipVTMOiESAiMpZ-rYffnc=szacFfg@mail.gmail.com>
References: <CAH2r5mv80H+O0VYjCuUk6ipVTMOiESAiMpZ-rYffnc=szacFfg@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-cifs.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mv80H+O0VYjCuUk6ipVTMOiESAiMpZ-rYffnc=szacFfg@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/v7.0-rc-part2-ksmbd-server-fixes
X-PR-Tracked-Commit-Id: a09dc10d1353f0e92c21eae2a79af1c2b1ddcde8
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 8eb604d4ee8bf6183b00b8a96f0007b1be28ca9d
Message-Id: <177169868365.1180555.13758278104710150200.pr-tracker-bot@kernel.org>
Date: Sat, 21 Feb 2026 18:31:23 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9488-lists,linux-cifs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_ALL(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-cifs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	RCPT_COUNT_FIVE(0.00)[5];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 625FB16D825
X-Rspamd-Action: no action

The pull request you sent on Fri, 20 Feb 2026 19:33:47 -0600:

> git://git.samba.org/ksmbd.git tags/v7.0-rc-part2-ksmbd-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/8eb604d4ee8bf6183b00b8a96f0007b1be28ca9d

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

