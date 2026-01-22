Return-Path: <linux-cifs+bounces-9056-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ePpOKtK0cWkzLgAAu9opvQ
	(envelope-from <linux-cifs+bounces-9056-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 06:25:38 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 5EAFB61F9B
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 06:25:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 905E54E92A0
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 05:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F07A3659F6;
	Thu, 22 Jan 2026 05:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="kbTtxp+Z"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313BF28D8D0
	for <linux-cifs@vger.kernel.org>; Thu, 22 Jan 2026 05:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769059536; cv=none; b=mmUUWv5Op50OEAkA2q2GVKjegwE5Esd+MqxiAOPrOLz75VUtxOW27/KQ3fR3SfqegMg6o3sr6E73hNVFp5V8XkWvsgGY6XyGmi9dBbN7w0XD8FxowAFqmDYpl7QvBHiRL9+SJMZsibGm4oKhHF4lMRXZur8AGymxM57xfO9n+kg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769059536; c=relaxed/simple;
	bh=OuVqWYghhnHK8hfynMmRcoTO3LdQT2pKTCoKc/SI2lE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fQ+XCsrbsJ/2kIjiJM1WtU2Qg77AK0Ki5wkYxZ/0Q9EWuDQ+7DAetmc1ywnG45bNqqEcIK2xPaBQUz64fskZj5UE/25zPtYriIYhrLLGu0EOqGz0bz2FlQpuJgDHXAqgZyYS2dlEy1d6q0zy7gno0KWsrlVsbdjzN86x0E8NkFw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=kbTtxp+Z; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769059532;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6Vmx7jptj071K4LahlLpJqBMjXKkVavKEx8yRAXj21U=;
	b=kbTtxp+Z5nmeAyrJRJTdlVLFNQ1QYK+1s3K2GLEGrhwHNdtGoaf9o51V0hpuE4Uk8UESoX
	LtnWx8Tfrj32QOBjlLTFT0NbItNtIqraEk7lS/lSAVW0RKRoeB8KT/yBRowHUfUI30wp5d
	CmwV7k5Fh7qpdobWtRmA/9VIpzY0chk=
From: chenxiaosong.chenxiaosong@linux.dev
To: smfrench@gmail.com,
	linkinjeon@kernel.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	senozhatsky@chromium.org,
	dhowells@redhat.com
Cc: linux-cifs@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH 5/7] smb/client: rename to NT_STATUS_SOME_NOT_MAPPED
Date: Thu, 22 Jan 2026 13:24:00 +0800
Message-ID: <20260122052402.2209206-6-chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20260122052402.2209206-1-chenxiaosong.chenxiaosong@linux.dev>
References: <20260122052402.2209206-1-chenxiaosong.chenxiaosong@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.46 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9056-lists,linux-cifs=lfdr.de];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,manguebit.org,microsoft.com,talpey.com,chromium.org,redhat.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong.chenxiaosong@linux.dev,linux-cifs@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DMARC_POLICY_ALLOW(0.00)[linux.dev,none];
	DKIM_TRACE(0.00)[linux.dev:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	RCPT_COUNT_SEVEN(0.00)[11];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	MISSING_XM_UA(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: 5EAFB61F9B
X-Rspamd-Action: no action

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

See MS-ERREF 2.3.1 STATUS_SOME_NOT_MAPPED.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/client/nterr.c | 2 +-
 fs/smb/client/nterr.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/smb/client/nterr.c b/fs/smb/client/nterr.c
index 806ad6d7c22a..279566cac435 100644
--- a/fs/smb/client/nterr.c
+++ b/fs/smb/client/nterr.c
@@ -695,7 +695,7 @@ const struct nt_err_code_struct nt_errs[] = {
 	{"NT_STATUS_NETWORK_SESSION_EXPIRED", NT_STATUS_NETWORK_SESSION_EXPIRED},
 	{"NT_STATUS_NO_MORE_ENTRIES", NT_STATUS_NO_MORE_ENTRIES},
 	{"NT_STATUS_MORE_ENTRIES", NT_STATUS_MORE_ENTRIES},
-	{"NT_STATUS_SOME_UNMAPPED", NT_STATUS_SOME_UNMAPPED},
+	{"NT_STATUS_SOME_NOT_MAPPED", NT_STATUS_SOME_NOT_MAPPED},
 	{"NT_STATUS_NO_SUCH_JOB", NT_STATUS_NO_SUCH_JOB},
 	{"NT_STATUS_NO_PREAUTH_INTEGRITY_HASH_OVERLAP",
 	 NT_STATUS_NO_PREAUTH_INTEGRITY_HASH_OVERLAP},
diff --git a/fs/smb/client/nterr.h b/fs/smb/client/nterr.h
index e8306704f5e3..cab16d53e11c 100644
--- a/fs/smb/client/nterr.h
+++ b/fs/smb/client/nterr.h
@@ -35,7 +35,7 @@ extern const struct nt_err_code_struct nt_errs[];
 
 #define NT_STATUS_OK                   0x0000
 #define NT_STATUS_PENDING              0x0103
-#define NT_STATUS_SOME_UNMAPPED        0x0107
+#define NT_STATUS_SOME_NOT_MAPPED      0x0107
 #define NT_STATUS_NOTIFY_ENUM_DIR      0x010c
 #define NT_STATUS_BUFFER_OVERFLOW  0x80000005
 #define NT_STATUS_NO_MORE_ENTRIES  0x8000001a
-- 
2.43.0


