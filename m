Return-Path: <linux-cifs+bounces-8997-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cC3SDbG+cGkRZgAAu9opvQ
	(envelope-from <linux-cifs+bounces-8997-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Jan 2026 12:55:29 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C766B5653A
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Jan 2026 12:55:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id F2803349B71
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Jan 2026 11:51:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C19C40FD8B;
	Wed, 21 Jan 2026 11:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ighbgHy9"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9E0C3D523D
	for <linux-cifs@vger.kernel.org>; Wed, 21 Jan 2026 11:50:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768996241; cv=none; b=U9U5zu4MaSbfZ2uyMgA1/kMARla+a0G3ACjKkTe6b4T5vDecyqk2cV1lX31HI8qw+Hy+Qde8TSAah68OUvcjo1CmsoxLFflXWN+2jVDVgNPWc/SaDLN67o1/rjUMkqz/+SmPnYcTn0fJCDyxnkE0J9wO0x9eO/snAAZ0SXCis8I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768996241; c=relaxed/simple;
	bh=UTDEyjADdLQVZ/GsO/Wqhnyx/j1aPkoudXk6YdwxgEo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fSbvba7wBfRXAip8Ayog/Z81wIQwgO566+ToqgeTFrDlwShw6C6t+JnMEGezqqBGwoxMd4ZPimfdX8sILXz2vQ0C2V1FACaG2a8sEKjwqqrwSabGSPS39u1T4SPNgSWFhmtYhtnABPK4CnYtE7TbcXUqmmGAkFCcuUHYfzZUbzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ighbgHy9; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768996233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3IqGN72Vef/OJJipOZ+IOVfh7DhKyDxsnVlJoQFmx/Y=;
	b=ighbgHy9PVSp1kD6lhigdbkQxbjW9ndkoDncZpt3OGUTGi9Usq2aX69meTfubDyZ0PjFHA
	mpGw4EwcL6IYz+hB1m+tydkb7rGt9T5S3qivPzkBOqF6issBCa10caSXwbN08OrSQO9NA4
	qDFadIPhS/U3OzNT4uSpNTpbdKZ2gNw=
From: chenxiaosong.chenxiaosong@linux.dev
To: smfrench@gmail.com,
	linkinjeon@kernel.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	senozhatsky@chromium.org,
	dhowells@redhat.com,
	hehuiwen@kylinos.cn
Cc: linux-cifs@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH 07/17] smb/client: add NT_STATUS_DIRECTORY_IS_A_REPARSE_POINT
Date: Wed, 21 Jan 2026 19:49:02 +0800
Message-ID: <20260121114912.2138032-8-chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20260121114912.2138032-1-chenxiaosong.chenxiaosong@linux.dev>
References: <20260121114912.2138032-1-chenxiaosong.chenxiaosong@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-8997-lists,linux-cifs=lfdr.de];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,manguebit.org,microsoft.com,talpey.com,chromium.org,redhat.com,kylinos.cn];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCPT_COUNT_TWELVE(0.00)[12];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong.chenxiaosong@linux.dev,linux-cifs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_RCPT(0.00)[linux-cifs];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,kylinos.cn:email,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo]
X-Rspamd-Queue-Id: C766B5653A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Huiwen He <hehuiwen@kylinos.cn>

See MS-ERREf 2.3.1 STATUS_DIRECTORY_IS_A_REPARSE_POINT.

Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/client/nterr.c        | 2 ++
 fs/smb/client/nterr.h        | 1 +
 fs/smb/client/smb1maperror.c | 2 +-
 3 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/nterr.c b/fs/smb/client/nterr.c
index 28b6320f2d21..679ff5d600cf 100644
--- a/fs/smb/client/nterr.c
+++ b/fs/smb/client/nterr.c
@@ -681,6 +681,8 @@ const struct nt_err_code_struct nt_errs[] = {
 	{"NT_STATUS_FILE_IS_OFFLINE", NT_STATUS_FILE_IS_OFFLINE},
 	{"NT_STATUS_VOLUME_DISMOUNTED", NT_STATUS_VOLUME_DISMOUNTED},
 	{"NT_STATUS_NOT_A_REPARSE_POINT", NT_STATUS_NOT_A_REPARSE_POINT},
+	{"NT_STATUS_DIRECTORY_IS_A_REPARSE_POINT",
+	 NT_STATUS_DIRECTORY_IS_A_REPARSE_POINT},
 	{"NT_STATUS_NETWORK_SESSION_EXPIRED", NT_STATUS_NETWORK_SESSION_EXPIRED},
 	{"NT_STATUS_NO_MORE_ENTRIES", NT_STATUS_NO_MORE_ENTRIES},
 	{"NT_STATUS_MORE_ENTRIES", NT_STATUS_MORE_ENTRIES},
diff --git a/fs/smb/client/nterr.h b/fs/smb/client/nterr.h
index 2056831ea631..087f970c6ceb 100644
--- a/fs/smb/client/nterr.h
+++ b/fs/smb/client/nterr.h
@@ -552,6 +552,7 @@ extern const struct nt_err_code_struct nt_errs[];
 #define NT_STATUS_FILE_IS_OFFLINE (0xC0000000 | 0x0267)
 #define NT_STATUS_VOLUME_DISMOUNTED (0xC0000000 | 0x026e)
 #define NT_STATUS_NOT_A_REPARSE_POINT (0xC0000000 | 0x0275)
+#define NT_STATUS_DIRECTORY_IS_A_REPARSE_POINT (0xC0000000 | 0x0281)
 #define NT_STATUS_NETWORK_SESSION_EXPIRED  (0xC0000000 | 0x035c)
 #define NT_STATUS_NO_SUCH_JOB (0xC0000000 | 0xEDE)	/* scheduler */
 #define NT_STATUS_NO_PREAUTH_INTEGRITY_HASH_OVERLAP (0xC0000000 | 0x5D0000)
diff --git a/fs/smb/client/smb1maperror.c b/fs/smb/client/smb1maperror.c
index 164b721c7dda..e91d9a22d843 100644
--- a/fs/smb/client/smb1maperror.c
+++ b/fs/smb/client/smb1maperror.c
@@ -659,7 +659,7 @@ static const struct {
 	ERRHRD, ERRgeneral, NT_STATUS_QUOTA_LIST_INCONSISTENT}, {
 	ERRHRD, ERRgeneral, NT_STATUS_FILE_IS_OFFLINE}, {
 	ERRDOS, 21, NT_STATUS_VOLUME_DISMOUNTED}, {
-	ERRDOS, 161, 0xc0000281}, {
+	ERRDOS, 161, NT_STATUS_DIRECTORY_IS_A_REPARSE_POINT}, {
 	ERRDOS, ERRnoaccess, 0xc000028a}, {
 	ERRDOS, ERRnoaccess, 0xc000028b}, {
 	ERRHRD, ERRgeneral, 0xc000028c}, {
-- 
2.43.0


