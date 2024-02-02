Return-Path: <linux-cifs+bounces-1101-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B57184783A
	for <lists+linux-cifs@lfdr.de>; Fri,  2 Feb 2024 19:48:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AE9AF1C222F0
	for <lists+linux-cifs@lfdr.de>; Fri,  2 Feb 2024 18:48:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5FFA1132492;
	Fri,  2 Feb 2024 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkXcvipC"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3401E13248F;
	Fri,  2 Feb 2024 18:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706899234; cv=none; b=J78z0nnK0bQ8mtfYpgBTj8Dh1V372gx8tzAfF/IuQ7Ml8x0MBA3YdtIlvNV4MN+4Lr5AGyG7f+z4qCeuolzj/NnrosRGhsBllXaywy/ZFy1kWmN9l9Bl9rUs2gaTYkodk0yJTvZCitmO7jThHOx9ay/7d1oOBREgS5yj+I3KW2w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706899234; c=relaxed/simple;
	bh=RtHeLmIdh98WwEijBiZMJS+TopDglZJtNtIQnzs43Tw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YxvCoJF+Tn70Gn4aM/OaC4Nbcw8x6bQaA2YqUkDIZJ4a2gcYkunstLnnVSxuJ3sci8B9aHSOwk6QeeYZD89WIrCQK3WqVQmN+qOmSoJrF+XnHQ4Ph11nUqhtrU6bUfQcQUz//1M+mZwJlyUDcrpRaBO+wB53xzuAWNbrlofXzMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkXcvipC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DE27C43399;
	Fri,  2 Feb 2024 18:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706899234;
	bh=RtHeLmIdh98WwEijBiZMJS+TopDglZJtNtIQnzs43Tw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=RkXcvipCzDvz7CQRFvDCU/K52AwG5ZvWiiazAL65e91NPnje/zIejKGMmIIZkDKaQ
	 wtFmXXdKZ6Q68UYRe8hn4YE7LE6kmzAzptaaA8LVTARqsUZj1DSWkfuavbMF2wh2tO
	 6+Zmzs0RjvxjMD2yWoP4ynMdxz/glcm8ryxvzF485RPCQZ6gZOLMl/4IRlo65eC/5B
	 6bbnf1Putdiogu+UyR885WtNn8pZQRJAQ92/gfdO04GyBkb2XxjSnVMz/PfBMUaolz
	 wswQ9YMrVN+MNAUGeVmOeaA8kDNyx5J8nSiik16qYLWaQH6xyueWQNfCCkEVgTtbTX
	 E0nrkOw2D8c4A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.6 11/21] cifs: cifs_pick_channel should try selecting active channels
Date: Fri,  2 Feb 2024 13:39:58 -0500
Message-ID: <20240202184015.540966-11-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240202184015.540966-1-sashal@kernel.org>
References: <20240202184015.540966-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.15
Content-Transfer-Encoding: 8bit

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit fc43a8ac396d302ced1e991e4913827cf72c8eb9 ]

cifs_pick_channel today just selects a channel based
on the policy of least loaded channel. However, it
does not take into account if the channel needs
reconnect. As a result, we can have failures in send
that can be completely avoided.

This change doesn't make a channel a candidate for
this selection if it needs reconnect.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/transport.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/smb/client/transport.c b/fs/smb/client/transport.c
index d553b7a54621..2d0a2951cbea 100644
--- a/fs/smb/client/transport.c
+++ b/fs/smb/client/transport.c
@@ -1026,6 +1026,9 @@ struct TCP_Server_Info *cifs_pick_channel(struct cifs_ses *ses)
 		if (!server)
 			continue;
 
+		if (CIFS_CHAN_NEEDS_RECONNECT(ses, i))
+			continue;
+
 		/*
 		 * strictly speaking, we should pick up req_lock to read
 		 * server->in_flight. But it shouldn't matter much here if we
-- 
2.43.0


