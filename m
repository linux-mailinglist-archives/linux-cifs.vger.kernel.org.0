Return-Path: <linux-cifs+bounces-1275-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 705118524AC
	for <lists+linux-cifs@lfdr.de>; Tue, 13 Feb 2024 01:57:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 114C7B26E01
	for <lists+linux-cifs@lfdr.de>; Tue, 13 Feb 2024 00:57:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EF1184FC8;
	Tue, 13 Feb 2024 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lJ5n8b5N"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11C6384FC2;
	Tue, 13 Feb 2024 00:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707783804; cv=none; b=uKmuP/KkHK22cr1MhPRis2/kCknWu/zZmCLAjBys8KssKaaxC1YG0s6CmomdEwvS7F4q1oCyeE3xyCVteDXvrfS6l2ZamFMeafdGC6/y2U2Y4Sm0LXGA+L7yROlI6NJDomnhrphutKypnsOYvnHt+2oYiple8MKRMnYw60zEnlQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707783804; c=relaxed/simple;
	bh=oWzmkZ1ju8RBE5yuRIcaKQBsApDM7Iev/GO/WME2q6w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AJ9TDSL5/oKL8Kb/VwxuG1SLmR5LuPjz1ADqUCr8zA4kyN33rucDfgLSIfemN0/efGnnLEtvk8fiwjWXTfW/WNjFiVCymPOwBo7CQcWLjetRebKwbYtjrquL/HwcZMSXVgic0C70O6PY242n+tEinIJ9d2UiRS1HzzvbDR181Hw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lJ5n8b5N; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2D47C433C7;
	Tue, 13 Feb 2024 00:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1707783803;
	bh=oWzmkZ1ju8RBE5yuRIcaKQBsApDM7Iev/GO/WME2q6w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=lJ5n8b5NG1eGjRb9ZnKEkBcjeLPyRSQ1mq2Aw/R54m9kh8rygB7smrI6iTqg4wXue
	 ZWVV0tD7SDMMa/TJxzwTlg3q2qQ7iVVHuoEUC/vZVKAayuCDHuWJBklvOByYHWdABs
	 mDMgSDRbYvSiO3BwRMqwo74vQxN571GxioBVwXPvENzL0RFYgNPDaNPfa1JOBBLuaf
	 0m25lIXX8ZnKsd5/Da8yUsxPGb+EH1vpk880fTCBVIt7zykIzREFoNRWNTMj4zWZzZ
	 vDa2f2tVoH6O4MoKoI7BYhP9WDv6h6iVhr03bkOdAVisCrdmf3ObMF/V30O0A9pbCW
	 bBJYXxL5rIx2A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Steve French <stfrench@microsoft.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Sasha Levin <sashal@kernel.org>,
	sfrench@samba.org,
	linux-cifs@vger.kernel.org,
	samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 6.1 28/28] smb3: clarify mount warning
Date: Mon, 12 Feb 2024 19:22:26 -0500
Message-ID: <20240213002235.671934-28-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240213002235.671934-1-sashal@kernel.org>
References: <20240213002235.671934-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.77
Content-Transfer-Encoding: 8bit

From: Steve French <stfrench@microsoft.com>

[ Upstream commit a5cc98eba2592d6e3c5a4351319595ddde2a5901 ]

When a user tries to use the "sec=krb5p" mount parameter to encrypt
data on connection to a server (when authenticating with Kerberos), we
indicate that it is not supported, but do not note the equivalent
recommended mount parameter ("sec=krb5,seal") which turns on encryption
for that mount (and uses Kerberos for auth).  Update the warning message.

Reviewed-by: Shyam Prasad N <sprasad@microsoft.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/fs_context.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
index f4818599c00a..4d5302b58b53 100644
--- a/fs/smb/client/fs_context.c
+++ b/fs/smb/client/fs_context.c
@@ -209,7 +209,7 @@ cifs_parse_security_flavors(struct fs_context *fc, char *value, struct smb3_fs_c
 
 	switch (match_token(value, cifs_secflavor_tokens, args)) {
 	case Opt_sec_krb5p:
-		cifs_errorf(fc, "sec=krb5p is not supported!\n");
+		cifs_errorf(fc, "sec=krb5p is not supported. Use sec=krb5,seal instead\n");
 		return 1;
 	case Opt_sec_krb5i:
 		ctx->sign = true;
-- 
2.43.0


