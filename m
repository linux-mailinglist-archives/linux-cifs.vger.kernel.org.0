Return-Path: <linux-cifs+bounces-9212-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 2OGmJkpzgGkw8QIAu9opvQ
	(envelope-from <linux-cifs+bounces-9212-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Mon, 02 Feb 2026 10:50:02 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CA16CA4A8
	for <lists+linux-cifs@lfdr.de>; Mon, 02 Feb 2026 10:50:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 8C8D9300558F
	for <lists+linux-cifs@lfdr.de>; Mon,  2 Feb 2026 09:50:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A24B52D7DEF;
	Mon,  2 Feb 2026 09:49:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="wtS6Xak7"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10E9F2D320E
	for <linux-cifs@vger.kernel.org>; Mon,  2 Feb 2026 09:49:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770025798; cv=none; b=Q/QKQ+vvQy7nglXi2Sagwi63t5e6qhMUrDkIxR0tkvKeNgCMJvep5B6ZrsDBxZpbvCjXdwP3pBqwwy+Th/HfEdEl2CvdQXChzm4GfjPOTFkPWTWbraCx7hAOFZ7+7OZOeaIShDsaqGU2qZLAhOBZCqv7OeWszyM4SlG6+H0kkbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770025798; c=relaxed/simple;
	bh=cvVSftVXaxO6V20G+ZA72Dus+G3jzItOVnoLL2qzEow=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jhvHVzjTwkCwcKd9InrOYcswvzhpV8zw8Rkomd2+jQMvtVyImGYbN2M+87waE966TvURpVcG1OaM7gNjQvYh0WHTcA7hVECSxrUGl56W6eLeOSKYRE+Ue5swijIMoWW04VTsDmAKnTLMAgZi7pw3EOQYq+KkbboWL9Dz/wOfqsc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=wtS6Xak7; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770025793;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=1UcJbyo+VwiCE1pxmnobpcPpBOQ1942PPTVETgmnvtg=;
	b=wtS6Xak7fO4sr7lFo/wrM5FTWVNoqJe1Ao43uQVHD4ehzTnZGbqAxxMqfzRDe9W/RYcpGX
	LpLxJfAu/4ZioMScn1CAHnw0msgJj4+ASSG6wG97U+qzHSetlrwslgOe3LSq+70d2LRPm3
	YHDnmQLMm9k0hJYpU/GeF2d6JlPQsX8=
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
	nspmangalore@gmail.com,
	henrique.carvalho@suse.com,
	meetakshisetiyaoss@gmail.com,
	ematsumiya@suse.de,
	pali@kernel.org
Cc: linux-cifs@vger.kernel.org,
	ChenXiaoSong <chenxiaosong@chenxiaosong.com>
Subject: [PATCH v3 0/1] smb/client: fix memory leaks
Date: Mon,  2 Feb 2026 09:49:05 +0000
Message-ID: <20260202094906.1933479-1-chenxiaosong.chenxiaosong@linux.dev>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9212-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[16];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,manguebit.org,microsoft.com,talpey.com,chromium.org,redhat.com,suse.com,suse.de];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong.chenxiaosong@linux.dev,linux-cifs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_RCPT(0.00)[linux-cifs];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 3CA16CA4A8
X-Rspamd-Action: no action

From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>

v2->v3: rebased on mainline

v2: https://lore.kernel.org/linux-cifs/20260202082407.1881618-1-chenxiaosong.chenxiaosong@linux.dev/

The following patches from v2 have already been merged into cifs-2.6.git for-next:
  - smb/client: fix memory leak in smb2_open_file(): https://lore.kernel.org/linux-cifs/20260202082407.1881618-3-chenxiaosong.chenxiaosong@linux.dev/

For detailed information, please see the link: https://chenxiaosong.com/en/smb-buildbot.html (I will ensure this link is always accessible).

ChenXiaoSong (1):
  smb/client: fix memory leak in SendReceive()

 fs/smb/client/cifstransport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

-- 
2.52.0


