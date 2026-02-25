Return-Path: <linux-cifs+bounces-9523-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id kFOKKJt2nmnCVQQAu9opvQ
	(envelope-from <linux-cifs+bounces-9523-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Wed, 25 Feb 2026 05:12:11 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E889F19183D
	for <lists+linux-cifs@lfdr.de>; Wed, 25 Feb 2026 05:12:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 93C9F3031839
	for <lists+linux-cifs@lfdr.de>; Wed, 25 Feb 2026 04:12:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A9AD828853E;
	Wed, 25 Feb 2026 04:12:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="IMd2B/Bg"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-172.mta0.migadu.com (out-172.mta0.migadu.com [91.218.175.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0035D292B44
	for <linux-cifs@vger.kernel.org>; Wed, 25 Feb 2026 04:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771992728; cv=none; b=NZBbK8qeSpE+vHPBa941+8psw4zVuQd51D9RY4zVI91+RyRyl5pNHCoU7EdndygD4N3++fie3bhNRqyDCJ49cdETN6NIy77ZUYiEMn704UcxCeCfVffBW7O3mI2JX4Hno882qFWBwscoxx//Z+l6/6TicIzFA6kBqDgic8dS2Kw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771992728; c=relaxed/simple;
	bh=Mp6vfHmpiKi4HM85f+YfpeZLba+5CigNAXlJj1rKyhY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sd9QcxaFLYgKfIaAAOzcCjkkWQReCafgyUlRCU5MojBhnn0QAJVAyCQ3dcGC7/0OhzYJfiYlBPJWOy5POZbWXa7hk1QWYqiRNesuMxhkkr9ANLle6xo9OveygCxH0U9F3kSyvMg9OeqnwsI9crcdgFj2x+8X9asGt6BG3fJoeeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=IMd2B/Bg; arc=none smtp.client-ip=91.218.175.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1771992724;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=74/WWTn8O1In2DMOnnyjiEj+WBcsSiZlJy4ejF4x3fU=;
	b=IMd2B/BgCYtBqQoLEgsGAa/geABDVNBPC3McIPG70V2BKqHkh+Ixe1t3yno78jy9jwjsGe
	SB2/pnpZGE/SLJvbZGVXaeksoz9qV3/+sDsEMHsVbXcrh6h6x9h7fqbjlP49BB7HmBW+RM
	c0aBu5Far0ORu2d0PPDkgMLaLgga0dE=
From: zhang.guodong@linux.dev
To: smfrench@gmail.com,
	linkinjeon@kernel.org,
	chenxiaosong@chenxiaosong.com
Cc: linux-cifs@vger.kernel.org,
	ZhangGuoDong <zhangguodong@kylinos.cn>
Subject: [PATCH v4 0/5] smb: move duplicate definitions into common header file, part 2
Date: Wed, 25 Feb 2026 04:10:55 +0000
Message-ID: <20260225041100.707468-1-zhang.guodong@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9523-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,kernel.org,chenxiaosong.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhang.guodong@linux.dev,linux-cifs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	TAGGED_RCPT(0.00)[linux-cifs];
	FROM_NO_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: E889F19183D
X-Rspamd-Action: no action

From: ZhangGuoDong <zhangguodong@kylinos.cn>

v3->v4:
  - Patch #03: __le32  VolumeSerialNumber
  - Add patch #04

v3: https://lore.kernel.org/linux-cifs/20260216082018.156695-1-zhang.guodong@linux.dev/

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
  smb: move some definitions from common/smb2pdu.h into common/fscc.h
  smb: move file_basic_info into common/fscc.h
  smb: move filesystem_vol_info into common/fscc.h
  smb: update some doc references
  smb: introduce struct file_posix_info

 fs/smb/client/cifs_debug.c |   2 +-
 fs/smb/client/cifs_ioctl.h |   2 +-
 fs/smb/client/cifsfs.c     |   2 +-
 fs/smb/client/cifsglob.h   |   2 +-
 fs/smb/client/fscache.c    |   2 +-
 fs/smb/client/inode.c      |  22 +--
 fs/smb/client/readdir.c    |  28 +--
 fs/smb/client/reparse.h    |   4 +-
 fs/smb/client/smb1pdu.h    |   9 -
 fs/smb/client/smb2pdu.c    |   6 +-
 fs/smb/client/smb2pdu.h    |  22 +--
 fs/smb/common/fscc.h       | 379 ++++++++++++++++++++++++++++++++++++-
 fs/smb/common/smb2pdu.h    | 343 ---------------------------------
 fs/smb/server/smb2pdu.c    |  93 ++++-----
 fs/smb/server/smb2pdu.h    |  35 +---
 fs/smb/server/smb_common.h |   8 -
 16 files changed, 471 insertions(+), 488 deletions(-)

-- 
2.53.0


