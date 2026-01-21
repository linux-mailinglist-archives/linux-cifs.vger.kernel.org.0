Return-Path: <linux-cifs+bounces-9005-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yDcrETjAcGmKZgAAu9opvQ
	(envelope-from <linux-cifs+bounces-9005-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Jan 2026 13:02:00 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id ADD33566DC
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Jan 2026 13:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 7A1E49A4BB5
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Jan 2026 11:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F61536BCCE;
	Wed, 21 Jan 2026 11:51:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="vEuxWKvS"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58995410D30
	for <linux-cifs@vger.kernel.org>; Wed, 21 Jan 2026 11:50:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768996261; cv=none; b=h46nshrHIn3EKj5V+XvgeVf0sIsKX3DFK1GddcG8a5F3gwRFxFGzMERN3kdJcFrkStsrsNh+mxJkHsGT2cgAlRZx5ohgiENK5GLCC8sTAIkY4cuXDcCrI6Evy71km+6EMaJSg54ZoniN5kSHB5ufhQHEil9YPe11qy6aFHKM5Dc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768996261; c=relaxed/simple;
	bh=O8NyvUK094cAJO2TNB+gB0cfHUNmXm2X+uC83dIr01w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CJj1Zh89CrUPS+VR53NwwIJ8UFYBWN2Vl4k7L4S2maAf00DZtDf1+mxIF84kDqMWB7O+vQidlNFelLbk3RU8igMjqftR+gJZHwUUb4OAOPuI0U+uT4QZF9PDtZo8hvx5HAxeFzB0YhUYMDrMfzR8/Di1zujPIOb2J9jMhb227Pc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=vEuxWKvS; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1768996257;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=TF0bra21DXiUREwG0nKctollvPPOHCFA/gYBJxlP5NM=;
	b=vEuxWKvSnVzrrzQh/NAFfJNt8U6ynqrRc9o0KUYXZFsa5nn6W9pR19sJBJLEAwKDBFAHnW
	CylzN3Flsq+8TCUguhAp7vMu+X0G+vxm2O+DCJIPxGKGN16CwqAyG55JfTPr90pLnCK/5D
	l6EqJHyDhxl2gsG5SxqAn2137Qbvphw=
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
Subject: [PATCH 15/17] smb/client: add NT_STATUS_VOLUME_NOT_UPGRADED
Date: Wed, 21 Jan 2026 19:49:10 +0800
Message-ID: <20260121114912.2138032-16-chenxiaosong.chenxiaosong@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-9005-lists,linux-cifs=lfdr.de];
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
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,dfw.mirrors.kernel.org:rdns,dfw.mirrors.kernel.org:helo,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: ADD33566DC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

From: Huiwen He <hehuiwen@kylinos.cn>

See MS-ERREf 2.3.1 STATUS_VOLUME_NOT_UPGRADED.

Signed-off-by: Huiwen He <hehuiwen@kylinos.cn>
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/client/nterr.c        | 1 +
 fs/smb/client/nterr.h        | 1 +
 fs/smb/client/smb1maperror.c | 2 +-
 3 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/nterr.c b/fs/smb/client/nterr.c
index 256f14209f56..ab5a2119efd0 100644
--- a/fs/smb/client/nterr.c
+++ b/fs/smb/client/nterr.c
@@ -690,6 +690,7 @@ const struct nt_err_code_struct nt_errs[] = {
 	{"NT_STATUS_NO_EFS", NT_STATUS_NO_EFS},
 	{"NT_STATUS_WRONG_EFS", NT_STATUS_WRONG_EFS},
 	{"NT_STATUS_NO_USER_KEYS", NT_STATUS_NO_USER_KEYS},
+	{"NT_STATUS_VOLUME_NOT_UPGRADED", NT_STATUS_VOLUME_NOT_UPGRADED},
 	{"NT_STATUS_NETWORK_SESSION_EXPIRED", NT_STATUS_NETWORK_SESSION_EXPIRED},
 	{"NT_STATUS_NO_MORE_ENTRIES", NT_STATUS_NO_MORE_ENTRIES},
 	{"NT_STATUS_MORE_ENTRIES", NT_STATUS_MORE_ENTRIES},
diff --git a/fs/smb/client/nterr.h b/fs/smb/client/nterr.h
index b34e522e6f87..b04cd0d786b1 100644
--- a/fs/smb/client/nterr.h
+++ b/fs/smb/client/nterr.h
@@ -560,6 +560,7 @@ extern const struct nt_err_code_struct nt_errs[];
 #define NT_STATUS_NO_EFS (0xC0000000 | 0x028e)
 #define NT_STATUS_WRONG_EFS (0xC0000000 | 0x028f)
 #define NT_STATUS_NO_USER_KEYS (0xC0000000 | 0x0290)
+#define NT_STATUS_VOLUME_NOT_UPGRADED (0xC0000000 | 0x029c)
 #define NT_STATUS_NETWORK_SESSION_EXPIRED  (0xC0000000 | 0x035c)
 #define NT_STATUS_NO_SUCH_JOB (0xC0000000 | 0xEDE)	/* scheduler */
 #define NT_STATUS_NO_PREAUTH_INTEGRITY_HASH_OVERLAP (0xC0000000 | 0x5D0000)
diff --git a/fs/smb/client/smb1maperror.c b/fs/smb/client/smb1maperror.c
index 0e1c8763afff..2de241f89cb6 100644
--- a/fs/smb/client/smb1maperror.c
+++ b/fs/smb/client/smb1maperror.c
@@ -667,7 +667,7 @@ static const struct {
 	ERRDOS, ERRnoaccess, NT_STATUS_NO_EFS}, {
 	ERRDOS, ERRnoaccess, NT_STATUS_WRONG_EFS}, {
 	ERRDOS, ERRnoaccess, NT_STATUS_NO_USER_KEYS}, {
-	ERRDOS, ERRbadfunc, 0xc000029c}, {
+	ERRDOS, ERRbadfunc, NT_STATUS_VOLUME_NOT_UPGRADED}, {
 	ERRDOS, ERRsymlink, NT_STATUS_STOPPED_ON_SYMLINK}, {
 	ERRDOS, ERRunknownlevel, NT_STATUS_OS2_INVALID_LEVEL}, {
 	0, 0, 0 }
-- 
2.43.0


