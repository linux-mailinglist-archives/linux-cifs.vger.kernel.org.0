Return-Path: <linux-cifs+bounces-9156-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mOgwCDdqe2lEEgIAu9opvQ
	(envelope-from <linux-cifs+bounces-9156-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Thu, 29 Jan 2026 15:09:59 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C4D1B0BEF
	for <lists+linux-cifs@lfdr.de>; Thu, 29 Jan 2026 15:09:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 76EA73004F2F
	for <lists+linux-cifs@lfdr.de>; Thu, 29 Jan 2026 14:09:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4CEE37FF4E;
	Thu, 29 Jan 2026 14:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PsAVkFuQ"
X-Original-To: linux-cifs@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6494337AA70
	for <linux-cifs@vger.kernel.org>; Thu, 29 Jan 2026 14:09:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769695797; cv=none; b=K/8qQezxb/1QP1Dvxnci+eo1XKbxv2NNQ5Wfou6+xz7RP+slKZsz1pIt5OcXt52HyeLyAFhc9tkU7pXhpxXS1e/RZll4WsW8FQVXYuRl5yMXDIVTzrBWztJbDIhrEauawX5q1WpG1ZcatyAhc1oZ8v0wDBtsih4TQApQK00WIbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769695797; c=relaxed/simple;
	bh=NCawKLWJELJzHx9az5904ouL4pnWr8NhPIMgIl6jkMY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jp3aTC/0Dj5FZvsNPCNfy55GLiZ8UzOuacD12JhPhJEzuCQxputIic/EU04A6sn6JUfQSpjzAiMw9MWkU9NlWY+5hN3sQD47jn4e3eA1kg3zVJ/QvKCDzWBJcm6s8xcpVFCziX7YtmFvOnYQ7fsGIgCQs6FK6QeUIUvocmodaEE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PsAVkFuQ; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1769695795;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XkOwrv2MTXhfP9FPRpLporsQUSwXvKGEi4dTfeQNv24=;
	b=PsAVkFuQ4zZSKcWr1HsR3lJ7Qd+AFO2Iz5YHTOR2ZyA0sarz55jd5u55FEZm1PTP3MYAvM
	1u1I9DKPec1SEYNx3Ek753J5S0IiXbuZ+jv3ECoLxSzzXU+WgxUM6G/mJY0c1e8MCKV2KP
	R0L03G+Yzo6rJcRBC2U5tSwH1MG3Xio=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-67-r_EHlZ_rPySJxBfEWJP7qQ-1; Thu,
 29 Jan 2026 09:09:54 -0500
X-MC-Unique: r_EHlZ_rPySJxBfEWJP7qQ-1
X-Mimecast-MFC-AGG-ID: r_EHlZ_rPySJxBfEWJP7qQ_1769695793
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 4108D195605B
	for <linux-cifs@vger.kernel.org>; Thu, 29 Jan 2026 14:09:53 +0000 (UTC)
Received: from plambri-thinkpadp16vgen1.rmtgb.csb (unknown [10.44.33.159])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 66164180086E
	for <linux-cifs@vger.kernel.org>; Thu, 29 Jan 2026 14:09:52 +0000 (UTC)
From: Pierguido Lambri <plambri@redhat.com>
To: Linux CIFS Mailing list <linux-cifs@vger.kernel.org>
Subject: [PATCH v2 3/3] cifs.upcall: Adjust log level
Date: Thu, 29 Jan 2026 14:08:48 +0000
Message-ID: <20260129140948.621754-3-plambri@redhat.com>
In-Reply-To: <20260129140948.621754-1-plambri@redhat.com>
References: <20260129140948.621754-1-plambri@redhat.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MID_CONTAINS_FROM(1.00)[];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[redhat.com,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	R_DKIM_ALLOW(-0.20)[redhat.com:s=mimecast20190719];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_ONE(0.00)[1];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_ALL(0.00)[];
	TAGGED_FROM(0.00)[bounces-9156-lists,linux-cifs=lfdr.de];
	DKIM_TRACE(0.00)[redhat.com:+];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[plambri@redhat.com,linux-cifs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-cifs];
	NEURAL_HAM(-0.00)[-1.000];
	FORGED_SENDER_MAILLIST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0C4D1B0BEF
X-Rspamd-Action: no action

Because now only error message are logged, let's switch some messages
from DEBUG to ERROR level.
This will help see when an error occurred with cifs.upcall and
eventually turn on the debug mode.

Signed-off-by: Pierguido Lambri <plambri@redhat.com>
---
 cifs.upcall.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/cifs.upcall.c b/cifs.upcall.c
index 9c2843d..9da5289 100644
--- a/cifs.upcall.c
+++ b/cifs.upcall.c
@@ -1617,7 +1617,7 @@ int main(const int argc, char *const argv[])
 					 __func__);
 		} else {
 			 if (!get_tgt_time(ccache)) {
-				syslog(LOG_DEBUG, "%s: valid TGT is not present in credential cache",
+				syslog(LOG_ERR, "%s: valid TGT is not present in credential cache",
 						__func__);
 				krb5_cc_close(context, ccache);
 				ccache = NULL;
@@ -1720,7 +1720,7 @@ retry_new_hostname:
 	}
 
 	if (rc) {
-		syslog(LOG_DEBUG, "Unable to obtain service ticket");
+		syslog(LOG_ERR, "Unable to obtain service ticket");
 		goto out;
 	}
 
-- 
2.52.0


