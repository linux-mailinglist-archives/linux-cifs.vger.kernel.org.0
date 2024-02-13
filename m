Return-Path: <linux-cifs+bounces-1271-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BCF8D852455
	for <lists+linux-cifs@lfdr.de>; Tue, 13 Feb 2024 01:49:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 28AB2B26FE7
	for <lists+linux-cifs@lfdr.de>; Tue, 13 Feb 2024 00:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F2B569E01;
	Tue, 13 Feb 2024 00:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="D0Av3weu"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F343669DF2;
	Tue, 13 Feb 2024 00:22:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783743; cv=none; b=aCNXiszXZc9r626171RvXhjZZrRXj3nBKh8IO51T3Ez7t7vdWpc8iiHsYKjxm2zehEuBzFTTXQ/YPKsRO4UnCYHrXnTnZoFSCipH2cjQjf4hgx48/DwIw1MWYadTEIk+RkWippzJn5YxhL1JColvggaajTBQqtAzCxLxcjbeORc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783743; c=relaxed/simple;
	bh=Cw4gxlkNs1pZ2LZIImiNweiDZ7fqOR7iCK8H3LT4E38=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X4d8Q7xlADUE77jPXMpqRLwOcrUNdjAlisC59I98FZN9wF+flgSSa0m7HzRA8WfkWZxKYYFbuUNHWzNe0W4yG6SVZ/qNi7ChHnfWL7gwujpNmbUba4MrCahJhWmXDRcOz/7Btr/jb8Xq1aZJXwjStT1wiSp0AG8qteV7KjVDR80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=D0Av3weu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0D6DC43394;
	Tue, 13 Feb 2024 00:22:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783742;
	bh=Cw4gxlkNs1pZ2LZIImiNweiDZ7fqOR7iCK8H3LT4E38=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=D0Av3weuwxuxENXr0KeyN1SOqwwr2zdxpBpFCdwCS8Ev3gKDEPTg/VLq2jQJyo0+d
	 71Ujd57rPn7w7a3CogmeCCCNvNUb66L5wL5WXYNXl022dIhO/KFCmCbR1SYAu2STqn
	 GhVlqTaH8ozPE/5yw9WJeIlhncRQx3Z8Q5MXC5zSKHVxCd/TGxORNOwKi33IQtdELi
	 A2wGXT928Q94VcW/u+h7ybUWVFNek5ohJtNY5LPkFNd5jKBK3Y5tA4MlRDVdaRaHgn
	 a8wy9BOOj7e908M7BPkIWO+8BOxBwSX4VgAsWj9QNeyRhT1gneqZyfvbUxrPaERsp4
	 Id6KnIo+BBW3g==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Shyam Prasad N <sprasad@microsoft.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.6 49/51] cifs: change tcon status when need_reconnect is set on it
Date: Mon, 12 Feb 2024 19:20:26 -0500
Message-ID: <20240213002052.670571-49-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002052.670571-1-sashal@kernel.org>
References: <20240213002052.670571-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.16
Content-Transfer-Encoding: 8bit

From: Shyam Prasad N <sprasad@microsoft.com>

[ Upstream commit c6e02eefd6ace3da3369c764f15429f5647056af ]

When a tcon is marked for need_reconnect, the intention
is to have it reconnected.

This change adjusts tcon->status in cifs_tree_connect
when need_reconnect is set. Also, this change has a minor
correction in resetting need_reconnect on success. It makes
sure that it is done with tc_lock held.

Signed-off-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/connect.c | 5 +++++
 fs/smb/client/dfs.c     | 7 ++++++-
 fs/smb/client/file.c    | 3 +++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/connect.c b/fs/smb/client/connect.c
index 0ed6eb915c6a..d53e725f6be5 100644
--- a/fs/smb/client/connect.c
+++ b/fs/smb/client/connect.c
@@ -4216,6 +4216,11 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 
 	/* only send once per connect */
 	spin_lock(&tcon->tc_lock);
+
+	/* if tcon is marked for needing reconnect, update state */
+	if (tcon->need_reconnect)
+		tcon->status = TID_NEED_TCON;
+
 	if (tcon->status == TID_GOOD) {
 		spin_unlock(&tcon->tc_lock);
 		return 0;
diff --git a/fs/smb/client/dfs.c b/fs/smb/client/dfs.c
index a8a1d386da65..449c59830039 100644
--- a/fs/smb/client/dfs.c
+++ b/fs/smb/client/dfs.c
@@ -565,6 +565,11 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 
 	/* only send once per connect */
 	spin_lock(&tcon->tc_lock);
+
+	/* if tcon is marked for needing reconnect, update state */
+	if (tcon->need_reconnect)
+		tcon->status = TID_NEED_TCON;
+
 	if (tcon->status == TID_GOOD) {
 		spin_unlock(&tcon->tc_lock);
 		return 0;
@@ -625,8 +630,8 @@ int cifs_tree_connect(const unsigned int xid, struct cifs_tcon *tcon, const stru
 		spin_lock(&tcon->tc_lock);
 		if (tcon->status == TID_IN_TCON)
 			tcon->status = TID_GOOD;
-		spin_unlock(&tcon->tc_lock);
 		tcon->need_reconnect = false;
+		spin_unlock(&tcon->tc_lock);
 	}
 
 	return rc;
diff --git a/fs/smb/client/file.c b/fs/smb/client/file.c
index 32a8525415d9..4cbb5487bd8d 100644
--- a/fs/smb/client/file.c
+++ b/fs/smb/client/file.c
@@ -175,6 +175,9 @@ cifs_mark_open_files_invalid(struct cifs_tcon *tcon)
 
 	/* only send once per connect */
 	spin_lock(&tcon->tc_lock);
+	if (tcon->need_reconnect)
+		tcon->status = TID_NEED_RECON;
+
 	if (tcon->status != TID_NEED_RECON) {
 		spin_unlock(&tcon->tc_lock);
 		return;
-- 
2.43.0


