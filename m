Return-Path: <linux-cifs+bounces-9116-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id p6PnLk/wc2nLzwAAu9opvQ
	(envelope-from <linux-cifs+bounces-9116-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Fri, 23 Jan 2026 23:03:59 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id EFC197B05D
	for <lists+linux-cifs@lfdr.de>; Fri, 23 Jan 2026 23:03:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 871183009F8E
	for <lists+linux-cifs@lfdr.de>; Fri, 23 Jan 2026 22:03:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9A80F22B5AC;
	Fri, 23 Jan 2026 22:03:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/gY7fDJ"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33CA226CE33;
	Fri, 23 Jan 2026 22:03:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769205832; cv=none; b=YLs5yYusiL/xiduruKd+lucoAgI5lL8O+4qwaZ3WjVen+/vFV9hADh13DpvNBWoOfmmoeW7CmrTWCEOf+aebmI5ZSUkv8//dHGYfuGV6ef36ncJ4RtkldXp4UEIRrEWnDXcCZC/aOvgkrVEY8WgZYoRT8Q/eq+/crhZIuxoII1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769205832; c=relaxed/simple;
	bh=ktQw8/UV9IQcfJIwShqyxhvfClbqW/hNL48qcBlfSXQ=;
	h=Subject:From:In-Reply-To:References:Message-Id:Date:To:Cc; b=rPTdhDJDqzXpgilyskQFrYnAczU9iLgwgjm4vbLlZjUulgw7rYXFtvH1Wnvw67fHvM9b69m/O39/vOKTNaroe/lrbEvzdsVhLhkyQ2E55JAmBhFAWd16i3fxtSxG4CQ1aqtvI/EhXwtEwLZcepqnZCvSI3sVqRu8U+T06AVp49o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/gY7fDJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99E46C4CEF1;
	Fri, 23 Jan 2026 22:03:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769205831;
	bh=ktQw8/UV9IQcfJIwShqyxhvfClbqW/hNL48qcBlfSXQ=;
	h=Subject:From:In-Reply-To:References:Date:To:Cc:From;
	b=V/gY7fDJwK2WXIHLirk7zWreFYXTXWkB2pgHIkRzoOUYiqyp5vHjzZJuqBtalVe/6
	 rMc+AiN/8RUP6ykkqs2+JakBLKzKkfo3ljrRw6ooa1Fz2yPK98zDI+zB6YtllovsXL
	 E2fBJcBxxBlokDdzu2ihtmcca61DuOWy0bITkyX/cD2NFh7u3Y3YZsSSqi+oihRXvi
	 iZIQRMEgLvi0nmEeR3+l3cscrPKyCLZFs4tE7zd70naBBhHp56ZEp8vu4vGx+xVv98
	 ekmEpODMJ2HPZuuJIjWXzUe6wLKDewvhEUdDF3p0TRnTROYpFnJPzt+tIvOWDaUq/8
	 7vQaPn94/7UmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 8BEE43808200;
	Fri, 23 Jan 2026 22:03:48 +0000 (UTC)
Subject: Re: [GIT PULL] ksmbd server fixes
From: pr-tracker-bot@kernel.org
In-Reply-To: <CAH2r5mvaWKtqdCYTYv87mqdDzhy-Hw8vs5iTaWTryMzzD2hi9Q@mail.gmail.com>
References: <CAH2r5mvaWKtqdCYTYv87mqdDzhy-Hw8vs5iTaWTryMzzD2hi9Q@mail.gmail.com>
X-PR-Tracked-List-Id: <linux-kernel.vger.kernel.org>
X-PR-Tracked-Message-Id: <CAH2r5mvaWKtqdCYTYv87mqdDzhy-Hw8vs5iTaWTryMzzD2hi9Q@mail.gmail.com>
X-PR-Tracked-Remote: git://git.samba.org/ksmbd.git tags/v6.19-rc6-server-fixes
X-PR-Tracked-Commit-Id: 5914d98ff0f7f9ec0e3963dbe2773401b02888ac
X-PR-Merge-Tree: torvalds/linux.git
X-PR-Merge-Refname: refs/heads/master
X-PR-Merge-Commit-Id: 6d064432376627ff76f86e16b3fbc13c38e860c2
Message-Id: <176920582707.2729567.2013735540951042619.pr-tracker-bot@kernel.org>
Date: Fri, 23 Jan 2026 22:03:47 +0000
To: Steve French <smfrench@gmail.com>
Cc: Linus Torvalds <torvalds@linux-foundation.org>, Namjae Jeon <linkinjeon@kernel.org>, LKML <linux-kernel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, "Stefan (metze) Metzmacher" <metze@samba.org>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com];
	TAGGED_FROM(0.00)[bounces-9116-lists,linux-cifs=lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pr-tracker-bot@kernel.org,linux-cifs@vger.kernel.org]
X-Rspamd-Queue-Id: EFC197B05D
X-Rspamd-Action: no action

The pull request you sent on Fri, 23 Jan 2026 11:50:33 -0600:

> git://git.samba.org/ksmbd.git tags/v6.19-rc6-server-fixes

has been merged into torvalds/linux.git:
https://git.kernel.org/torvalds/c/6d064432376627ff76f86e16b3fbc13c38e860c2

Thank you!

-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/prtracker.html

