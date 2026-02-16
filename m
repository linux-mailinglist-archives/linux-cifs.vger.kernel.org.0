Return-Path: <linux-cifs+bounces-9390-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EBxQLpnTkmnsygEAu9opvQ
	(envelope-from <linux-cifs+bounces-9390-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Mon, 16 Feb 2026 09:21:45 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 6077D141801
	for <lists+linux-cifs@lfdr.de>; Mon, 16 Feb 2026 09:21:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BDAD23001FE4
	for <lists+linux-cifs@lfdr.de>; Mon, 16 Feb 2026 08:21:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9ADAB27A122;
	Mon, 16 Feb 2026 08:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="K5Dywtbw"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 744C02475CB
	for <linux-cifs@vger.kernel.org>; Mon, 16 Feb 2026 08:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771230103; cv=none; b=e83B4uTxHOqFSAh8OuR0k/8HNMe9OkB/lE9PBsA2YANddYOBWh66LnUOj9fbDWkHUKTT5GTAQiZqVc8CrzCOzLZy49LAGmLKjN0LV4Cbmii4a9gQ5ThEE4V/HhAiEoLuMc3RCPRz83l/ORj+29YJryKxuG7NlcAUt9GlQY8q8Jk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771230103; c=relaxed/simple;
	bh=FWRI4OVGboiBc8ZRuHgaeZviS/w2tj/HpC8krRmNI5A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=U1wWs3RPls+8nTjC6zc2OPpDkxHRE2B6xgDIrcFbyc7Qdsc8doLCKZPuUaYBbJ335yhgNMRwrYOpDUZ7CB35Mw7bRhUxWg69njfNpggDXRqWxyiJL4E/JZWkttgpasSnDFaXMlR5WlCTulvoqxhYXDFgGlxkemxKhe7esQR/kP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=K5Dywtbw; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771230099;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=TY3qLcRDR4C1jw0Jfv0QdPn1FFbpinpizXMe0WoUhV4=;
	b=K5DywtbwbC9HClSkF3qnyHtjJQCCm+ROjZKPGEM0mJ8DNLBJ58rNsu7BXtsYYG8VuUYH20
	7yEThTQ3lyNb9ekY9l4TQKS+NX9MSw+b66Y6Pw+5MlUVMRMx/yrp6dNSdLpNbVuiZkqhqR
	m+Uv7SzduIp2WG4JQlvD1XZ8s1RpQzw=
From: zhang.guodong@linux.dev
To: smfrench@gmail.com,
	linkinjeon@kernel.org,
	pc@manguebit.org,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	tom@talpey.com,
	bharathsm@microsoft.com,
	senozhatsky@chromium.org,
	dhowells@redhat.com,
	chenxiaosong@kylinos.cn,
	chenxiaosong.chenxiaosong@linux.dev
Cc: linux-cifs@vger.kernel.org,
	ZhangGuoDong <zhangguodong@kylinos.cn>
Subject: [PATCH v3 0/5] smb: move duplicate definitions into common header file, part 2
Date: Mon, 16 Feb 2026 08:20:13 +0000
Message-ID: <20260216082018.156695-1-zhang.guodong@linux.dev>
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
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_MISSING_CHARSET(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9390-lists,linux-cifs=lfdr.de];
	RCPT_COUNT_TWELVE(0.00)[13];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,manguebit.org,microsoft.com,talpey.com,chromium.org,redhat.com,kylinos.cn,linux.dev];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhang.guodong@linux.dev,linux-cifs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_RCPT(0.00)[linux-cifs];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:helo,sto.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim,kylinos.cn:email]
X-Rspamd-Queue-Id: 6077D141801
X-Rspamd-Action: no action

From: ZhangGuoDong <zhangguodong@kylinos.cn>

v2->v3:
  - Patch #01: "__u32 VolumeSerialNumber" -> "__le32 VolumeSerialNumber"
  - Patch #02: rebased on cifs-2.6.git for-next
  - Add patch #03

v1: https://lore.kernel.org/all/20251209011020.3270989-1-chenxiaosong.chenxiaosong@linux.dev/
v2: https://lore.kernel.org/linux-cifs/20251211143228.172470-1-chenxiaosong.chenxiaosong@linux.dev/
The following patches from v1 and v2 have already been merged into mainline:
  - 94d5b8dbc5d9 smb: move some SMB1 definitions into common/smb1pdu.h
  - 2b6abb893e71 smb: move File Attributes definitions into common/fscc.h
  - c97503321ed3 smb: update struct duplicate_extents_to_file_ex
  - 2e0d224d8988 smb/server: add comment to FileSystemName of FileFsAttributeInformation
  - ab0347e67dac smb/client: remove DeviceType Flags and Device Characteristics definitions
  - 08c2a7d2bae9 smb: move file_notify_information to common/fscc.h
  - 6539e18517b6 smb: move SMB2 Notify Action Flags into common/smb2pdu.h
  - 9ec7629b430a smb: move notify completion filter flags into common/smb2pdu.h
  - bcdd6cfaf2ec smb: add documentation references for smb2 change notify definitions

This is a continuous effort to move duplicated definitions in both client
and server into common header files, which makes the code easier to maintain.

The previous work is here:
  - part 1: https://lore.kernel.org/linux-cifs/20251117112838.473051-1-chenxiaosong.chenxiaosong@linux.dev/

ZhangGuoDong (5):
  smb: move smb3_fs_vol_info into common/fscc.h
  smb: move some definitions from common/smb2pdu.h into common/fscc.h
  smb: move file_basic_info into common/fscc.h
  smb: introduce struct create_posix_ctxt_rsp
  smb: introduce struct file_posix_info

 fs/smb/client/inode.c      |  22 +--
 fs/smb/client/readdir.c    |  28 +--
 fs/smb/client/reparse.h    |   4 +-
 fs/smb/client/smb1pdu.h    |   9 -
 fs/smb/client/smb2pdu.c    |   9 +-
 fs/smb/client/smb2pdu.h    |  21 +-
 fs/smb/common/fscc.h       | 379 ++++++++++++++++++++++++++++++++++++-
 fs/smb/common/smb2pdu.h    | 360 ++---------------------------------
 fs/smb/server/oplock.c     |   8 +-
 fs/smb/server/smb2pdu.c    |  98 +++++-----
 fs/smb/server/smb2pdu.h    |  36 +---
 fs/smb/server/smb_common.h |   8 -
 12 files changed, 486 insertions(+), 496 deletions(-)

-- 
2.52.0


