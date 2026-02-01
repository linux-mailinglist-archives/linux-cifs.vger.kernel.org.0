Return-Path: <linux-cifs+bounces-9197-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yKf5MasKf2kEiwIAu9opvQ
	(envelope-from <linux-cifs+bounces-9197-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Sun, 01 Feb 2026 09:11:23 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id E0F4DC5304
	for <lists+linux-cifs@lfdr.de>; Sun, 01 Feb 2026 09:11:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 95A7730086CA
	for <lists+linux-cifs@lfdr.de>; Sun,  1 Feb 2026 08:11:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F4182319870;
	Sun,  1 Feb 2026 08:11:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="KkbvA5uG"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-187.mta1.migadu.com (out-187.mta1.migadu.com [95.215.58.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C54B3195FD
	for <linux-cifs@vger.kernel.org>; Sun,  1 Feb 2026 08:11:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769933480; cv=none; b=FqLPazPJv3Sg881seRbJz+956QH75G75bLHEcTaZeit4eywT9hW8lZmh+JXi/BL0aKCdWRIyRyoFQBc+1WclJPWtlcylHphwTUUMrXcNSU3M669txepGl+QAAG2QYD1gbKWPx+y7aRPMzzj/VVrty7jVmq50/r2+zGjqsYryouY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769933480; c=relaxed/simple;
	bh=6Kb7sPLVKUwby0sIgLg0IA7nTQk3Mxl5ujWih1XDwC8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tDRBXyav2Mfyd48v0y0/6L5gZFbaL37oFCGIxmLHcl6mpF1OmMpACgUxUtIiq2IV1Z28StBFIyiVrYzpDN/xb2SjEYHpVCv8S3O3D192CuJi4hfLYTELOJLc2K0YpYoPbHsAYfhEHdaknSZEK1PsNmD4V7t9/j9zSqNLY7cAkJo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=KkbvA5uG; arc=none smtp.client-ip=95.215.58.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769933476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+TAShxWglUEekw58ylxxA30urYPikDp3Gn47H8geVBE=;
	b=KkbvA5uGimr13SeW/XGBunaTuFVDrNVG/0TyKWdn7T/HJ3Oy5t0Fe4TMKefCnQXyzuMp5s
	rqfM23c0zRw37zpcyovgzyscXg9JkYVEqoJmWqlsSddiJrc22fhPwXlqWWMRIrD0j43203
	rXxLsh1eHueCzAkEoSDFBtsg1vI4Kro=
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
	ChenXiaoSong <chenxiaosong@kylinos.cn>
Subject: [PATCH] smb/client: fix memory leak in smb2_open_file()
Date: Sun,  1 Feb 2026 08:10:17 +0000
Message-ID: <20260201081017.998628-1-chenxiaosong.chenxiaosong@linux.dev>
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
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9197-lists,linux-cifs=lfdr.de];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: E0F4DC5304
X-Rspamd-Action: no action

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

Reproducer:

  1. On server, set the permissions of the shared directory to read-only
  2. mount -t cifs //${server_ip}/export /mnt
  4. dd if=/dev/zero of=/mnt/file bs=512 count=1000 oflag=direct
  5. umount /mnt
  6. sleep 1
  7. modprobe -r cifs

The error message is as follows:

  =============================================================================
  BUG cifs_small_rq (Not tainted): Objects remaining on __kmem_cache_shutdown()
  -----------------------------------------------------------------------------

  Object 0x00000000d47521be @offset=14336
  ...
  WARNING: mm/slub.c:1251 at __kmem_cache_shutdown+0x34e/0x440, CPU#0: modprobe/1577
  ...
  Call Trace:
   <TASK>
   kmem_cache_destroy+0x94/0x190
   cifs_destroy_request_bufs+0x3e/0x50 [cifs]
   cleanup_module+0x4e/0x540 [cifs]
   __se_sys_delete_module+0x278/0x400
   __x64_sys_delete_module+0x5f/0x70
   x64_sys_call+0x2299/0x2ff0
   do_syscall_64+0x89/0x350
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  ...
  kmem_cache_destroy cifs_small_rq: Slab cache still has objects when called from cifs_destroy_request_bufs+0x3e/0x50 [cifs]
  WARNING: mm/slab_common.c:532 at kmem_cache_destroy+0x16b/0x190, CPU#0: modprobe/1577

Link: https://lore.kernel.org/linux-cifs/9751f02d-d1df-4265-a7d6-b19761b21834@linux.dev/T/#mf14808c144448b715f711ce5f0477a071f08eaf6
Fixes: e255612b5ed9 ("cifs: Add fallback for SMB2 CREATE without FILE_READ_ATTRIBUTES")
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/client/smb2file.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index 0f0514be29cd..9ab0df01b774 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -178,6 +178,7 @@ int smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms,
 	rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock, smb2_data, NULL, &err_iov,
 		       &err_buftype);
 	if (rc == -EACCES && retry_without_read_attributes) {
+		free_rsp_buf(err_buftype, err_iov.iov_base);
 		oparms->desired_access &= ~FILE_READ_ATTRIBUTES;
 		rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock, smb2_data, NULL, &err_iov,
 			       &err_buftype);
-- 
2.52.0


