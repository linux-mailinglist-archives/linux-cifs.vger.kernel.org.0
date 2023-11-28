Return-Path: <linux-cifs+bounces-204-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 990057FC457
	for <lists+linux-cifs@lfdr.de>; Tue, 28 Nov 2023 20:37:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 53CCE282995
	for <lists+linux-cifs@lfdr.de>; Tue, 28 Nov 2023 19:37:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6ED4046BB0;
	Tue, 28 Nov 2023 19:37:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="ozIHZ3Cx"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C5361988
	for <linux-cifs@vger.kernel.org>; Tue, 28 Nov 2023 11:37:36 -0800 (PST)
From: Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1701200254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=08Md64FrFcOS6/xl4u2o+6lEXFTej/bgz4SHAy9m3f4=;
	b=ozIHZ3CxwBWP5IGpXLaL69yM/ZE1BQBhaeBuG8MHSsbu8PFWtS9blnB12zO2k8FKbVffPP
	jbNeA0r4ZemPivGZsiM/DIK/6NTlA1OQn3ZhwCRr3Vmn3lyPwGMQzXqrKWv1hDUBoTQX9u
	ull/70jgyNkPcXtTCye5o4BnAl7uN03+v6s8nyKel//20RRWBaYgYneij29/t6cjdANRbT
	9vU0EYbQSHTLZM+SQ+gqkNofa1B8Vaj3/UGzPmQcCAZHggVW0JzLD93Nr3Y6GdeIQcvEm9
	JSdGbTWoIsT1nvBjAu1qp+5v5dm9c5faTpNxGnZOCBJAhxXg6hcz3o1nGDF8Mg==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1701200254; a=rsa-sha256;
	cv=none;
	b=kDGXYrAkCRA9y+cMkgMRGui226LvxMsY7trcIAEDdA0ya8GyohdD6G+hTYKgS+LwKGQGH1
	1+5yvVYKyugdB4pt928liZnoM+VAtIhG3Rj2ih74+89aeQdNNxiEEUINSwOZHubas53fD7
	HE+Z4OgRkahgoQ6knDwhU/yBw09h0Hp6VwUDb/KAiZ4POYkrP0sCOtmHD3s+qobwumlb5b
	ZX0YwdJEas7N5VC0KnL0wS31K/hq9hCqPJ15jHgppTkITvcAdyw2WNX3XOA7mV9m2kSwv+
	25zLUwRszvXywxpBduAlvueo0O73C7WP/xNHASY93vPxyYB+TXMrZKukPY1Oqw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1701200254; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=08Md64FrFcOS6/xl4u2o+6lEXFTej/bgz4SHAy9m3f4=;
	b=jfuMw1oOthYIGSvouCItP1L8StRZRNN6nYEy4b6+1jT1Q1w2ju1xsNCVXC9ReUJPmh/4NO
	uJEnEEW2HwvSOvtWKimVE/GecYr1YgA0tAmv++323ZvIs5HdkG+Zc73ypUydO3YlgO2VD4
	NwhNsT3YffJJ3Z5z/0IN6QYnmSbvxizu14j3bY/FPAaGKG8IPPbRCRUkpeTLAwyhs11Qe2
	Uv2eMEwIGsF2o2QRfDU6/FzOEU9IhObTZoKD1zWDxHwHr0kND3oE+S+CirSN+/8cgM0nxR
	h1x1dlN58GctJKwG0teMjxX8BzmSqzD2ZwUG11N/qbFnXjH6Ds51A/Ajc2+duw==
To: smfrench@gmail.com
Cc: linux-cifs@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH] smb: client: report correct st_size for SMB and NFS symlinks
Date: Tue, 28 Nov 2023 16:37:19 -0300
Message-ID: <20231128193719.11919-1-pc@manguebit.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

We can't rely on FILE_STANDARD_INFORMATION::EndOfFile for reparse
points as they will be always zero.  Set it to symlink target's length
as specified by POSIX.

This will make stat() family of syscalls return the correct st_size
for such files.

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
---
 fs/smb/client/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 01c7d2973d66..0b05e664008e 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -866,6 +866,8 @@ static void cifs_open_info_to_fattr(struct cifs_fattr *fattr,
 
 out_reparse:
 	if (S_ISLNK(fattr->cf_mode)) {
+		if (likely(data->symlink_target))
+			fattr->cf_eof = strnlen(data->symlink_target, PATH_MAX);
 		fattr->cf_symlink_target = data->symlink_target;
 		data->symlink_target = NULL;
 	}
-- 
2.43.0


