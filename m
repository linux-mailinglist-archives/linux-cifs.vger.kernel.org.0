Return-Path: <linux-cifs+bounces-9053-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wAPTCcy0cWkzLgAAu9opvQ
	(envelope-from <linux-cifs+bounces-9053-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 06:25:32 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FB5561F8D
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 06:25:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 71ADF4E4F68
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 05:25:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D00E313525;
	Thu, 22 Jan 2026 05:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="SW/sPfS3"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D46734DCE2
	for <linux-cifs@vger.kernel.org>; Thu, 22 Jan 2026 05:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769059526; cv=none; b=V8b1x137XCUSMIIpIqK/XgEzu1+yOtZ1B/fuZWpD2ObqN8FPq7Nc5+JiS5z55da5ziK3RvovrFJxqCAwpjz7jRb0WgjBZAFhTB2VSb82DOhc7JVwMmYQqBRSH9HwkQVx07yyLkYr0E7rXwy48Iud9ByQOw6o6S8JojWFeK16CJ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769059526; c=relaxed/simple;
	bh=H1fuqBMTP1ZZkRcXaioZ6VqY0e1tg5Aw34qXGxqdt2Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L3iMUAF7+gmZyaCahM8KPtxUB5rX9iHl30HYxo5xzAnW5w/qHIer6rVlX/jvN8SNmgl9xTejZywYx9izpzDsy4/Upe3sekvA6YbU64HJal8wRF0TYeSSLAMtDycogyD0c+Zq5mwi0RuUJHhBvY0k+9L3PWOQrpm136nMATCsbp8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=SW/sPfS3; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769059522;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8A6GcqgW3b9jCRYhnVC6QpIHnZKhZTaWZlQ2nzZ8Otg=;
	b=SW/sPfS3WgyxAfM/Qjj26RO6QQuqk0adw5ekQGm37YZp667PfNWXGf5AWs3GzJeJs2//8J
	TSby6H6F5mfDng3JdincKILa9A2M9NRT8pvcg5AjqkSpcV2UyNyzxlHrVkiAsnb2PQBagM
	ezl9QLQyCfGJBqz0y5tCC1ucJvt5YrA=
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
Subject: [PATCH 2/7] smb/client: map NT_STATUS_BUFFER_OVERFLOW
Date: Thu, 22 Jan 2026 13:23:57 +0800
Message-ID: <20260122052402.2209206-3-chenxiaosong.chenxiaosong@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-9053-lists,linux-cifs=lfdr.de];
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
X-Rspamd-Queue-Id: 8FB5561F8D
X-Rspamd-Action: no action

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

See MS-CIFS 2.2.2.4 STATUS_BUFFER_OVERFLOW.

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/client/smb1maperror.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/smb1maperror.c b/fs/smb/client/smb1maperror.c
index 10ab889a442c..c1330d32ef09 100644
--- a/fs/smb/client/smb1maperror.c
+++ b/fs/smb/client/smb1maperror.c
@@ -114,6 +114,7 @@ static const struct {
 } ntstatus_to_dos_map[] = {
 	{
 	ERRSRV, ERR_NOTIFY_ENUM_DIR, NT_STATUS_NOTIFY_ENUM_DIR}, {
+	ERRDOS, ERRmoredata, NT_STATUS_BUFFER_OVERFLOW}, {
 	ERRDOS, ERRgeneral, NT_STATUS_UNSUCCESSFUL}, {
 	ERRDOS, ERRbadfunc, NT_STATUS_NOT_IMPLEMENTED}, {
 	ERRDOS, ERRbadpipe, NT_STATUS_INVALID_INFO_CLASS}, {
-- 
2.43.0


