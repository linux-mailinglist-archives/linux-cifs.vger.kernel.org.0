Return-Path: <linux-cifs+bounces-9177-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uKUCLNW8fGlVOgIAu9opvQ
	(envelope-from <linux-cifs+bounces-9177-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Fri, 30 Jan 2026 15:14:45 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0FC17BB7EF
	for <lists+linux-cifs@lfdr.de>; Fri, 30 Jan 2026 15:14:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9408D30428A2
	for <lists+linux-cifs@lfdr.de>; Fri, 30 Jan 2026 14:12:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 32DF3319850;
	Fri, 30 Jan 2026 14:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="L0JTPy6q"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD9CC3EBF04
	for <linux-cifs@vger.kernel.org>; Fri, 30 Jan 2026 14:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769782335; cv=none; b=uv+KaOuZJ6nFQR8shrlelkqBZ8Fmnkh1CBwhv7FchimJZteJXdkYBstcuE+RtwuLpo8vVXFnRFlcXn5IsWu7Ao347rPg9QXdpj2szgAlcr9lVWkD57jN0Bm6R4LgKYjl+JkopHcpMmCNNUtQCMG0dO4FkMbZrGeQ/5b6PG1+/5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769782335; c=relaxed/simple;
	bh=ZIAMpXBcJhRLsbMUMatEbuT/qgj7PA02HdiEsv273bk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sIz63Jj2bsgr8bwICxjWdPCw07mDuMU70BoVcWk3blxPHVE9Ivbe1ne0ShpTfpbl1bgKlvP1d+Idc/VSt/lH9v97sEY73sBjcC8F/0iLFcFOtEbgYSlSbu5us7Ri7IC4+I051Kbcipa4Il25+GBD+dBudTvBOupLt4k6s0ns9gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=L0JTPy6q; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769782332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ls6zcnB25KSDjs+bswk8yHH8N1K7VE+eGHh++xVbJvI=;
	b=L0JTPy6qatfj/dhA/E1FYqIxE0EQaeRUVxiWgAVlLE1ldQpTcVOpx7LQ9dFJfwkgFbplj2
	wHLTolTf3lzojYwDW/kA/NSTtTFM/NXwPuwmUW6ae84xtq8CtLpfhiLv1AlUrgScq93ILw
	RmJDlXCLENAngAKvf9dIvD2E4iaRnNo=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-135-v0IbJLcDPiaI3AV98Z1hOQ-1; Fri,
 30 Jan 2026 09:12:11 -0500
X-MC-Unique: v0IbJLcDPiaI3AV98Z1hOQ-1
X-Mimecast-MFC-AGG-ID: v0IbJLcDPiaI3AV98Z1hOQ_1769782331
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id EB9FA1956050
	for <linux-cifs@vger.kernel.org>; Fri, 30 Jan 2026 14:12:10 +0000 (UTC)
Received: from plambri-thinkpadp16vgen1.rmtgb.csb (unknown [10.44.32.231])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 1AF2F18004D8
	for <linux-cifs@vger.kernel.org>; Fri, 30 Jan 2026 14:12:09 +0000 (UTC)
From: Pierguido Lambri <plambri@redhat.com>
To: Linux CIFS Mailing list <linux-cifs@vger.kernel.org>
Subject: [PATCH v3 2/3] docs: Enable debug logs
Date: Fri, 30 Jan 2026 14:11:27 +0000
Message-ID: <20260130141207.831439-2-plambri@redhat.com>
In-Reply-To: <20260130141207.831439-1-plambri@redhat.com>
References: <20260130141207.831439-1-plambri@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-9177-lists,linux-cifs=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[plambri@redhat.com,linux-cifs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-cifs];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,rst.in:url]
X-Rspamd-Queue-Id: 0FC17BB7EF
X-Rspamd-Action: no action

Documented a new option '-d' to enable debug logs.
By default only error logs are enabled, with this new option
debug logs can be enabled when needed.

Signed-off-by: Pierguido Lambri <plambri@redhat.com>
Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>
---
 cifs.upcall.rst.in | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/cifs.upcall.rst.in b/cifs.upcall.rst.in
index 09d0503..895efc5 100644
--- a/cifs.upcall.rst.in
+++ b/cifs.upcall.rst.in
@@ -11,7 +11,7 @@ Userspace upcall helper for Common Internet File System (CIFS)
 SYNOPSIS
 ********
 
-  cifs.upcall [--trust-dns|-t] [--version|-v] [--legacy-uid|-l]
+  cifs.upcall [--trust-dns|-t] [--version|-v] [--legacy-uid|-l] [--debug|-d]
               [--krb5conf=/path/to/krb5.conf|-k /path/to/krb5.conf]
               [--keytab=/path/to/keytab|-K /path/to/keytab] [--expire|-e nsecs] {keyid}
 
@@ -38,6 +38,9 @@ OPTIONS
 -c
   This option is deprecated and is currently ignored.
 
+--debug|-d
+  Enable debug logs. By default no debug messages are logged, only errors.
+
 --no-env-probe|-E
   Normally, ``cifs.upcall`` will probe the environment variable space of
   the process that initiated the upcall in order to fetch the value of
-- 
2.52.0


