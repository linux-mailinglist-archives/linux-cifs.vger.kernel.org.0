Return-Path: <linux-cifs+bounces-9205-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SDhdOy5JgGnC5gIAu9opvQ
	(envelope-from <linux-cifs+bounces-9205-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Mon, 02 Feb 2026 07:50:22 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DB73C8F53
	for <lists+linux-cifs@lfdr.de>; Mon, 02 Feb 2026 07:50:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D7A1F3004233
	for <lists+linux-cifs@lfdr.de>; Mon,  2 Feb 2026 06:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FDE930B519;
	Mon,  2 Feb 2026 06:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="sOCiC8nY"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-171.mta0.migadu.com (out-171.mta0.migadu.com [91.218.175.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DBCD21D3CD
	for <linux-cifs@vger.kernel.org>; Mon,  2 Feb 2026 06:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770015019; cv=none; b=rDEwZX29p7luUn0fxejeZr8Xri+ZDG3YcHUTAPQ29vOLg56DY0fV1WhrJDb/S2l1Y2XzhAYb9qpKrNvk9iLzUDPuQGIi/LcXgYqHft0wGm0Goo/8m87TKNw9j4g0c/fEPbCdr1kAnOebSGjP4RiMHpwI6hr+rXa1Hv+XinjXXkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770015019; c=relaxed/simple;
	bh=IM/zlXb8FWlb1TEWYdoVaUzIhieq5S52etee9Zfedw8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SLZd+S+Nebkj31OfqyjbMgzGqkX6UiNSePnpt4vxV/xcBjJ26R4mZOF4f/WiOc+XFPdQQCcVglnwBRx66I5IEvUloV6ZNcNc31BybbTLdGHX3kR+SN9WHrrM28qPKcCN/KfL3XOF3hYZZ/2QQsR6+CMOAMX4tBxK/GKu9s+PYyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=sOCiC8nY; arc=none smtp.client-ip=91.218.175.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770015015;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=rkP2S3WVu0q6bR000I+40Jp/dIDVayCV2VfvsePZiKc=;
	b=sOCiC8nYBOWktqrvw+p+6fWIxjnP3k+lsZAVPqEXEXyDeGSPya4qsUfIGLQF4AWy2H/LqG
	Jq6HP6ZD4apgFO1yTMBbpjI+V7WvGqdvv0B3QPSFonvvjwzxODlmXXoOwhJw0FmU0HQhuY
	/8CN/R0+AoK5X6YVYypT3/RT7Gckx6M=
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
Subject: [PATCH] smb/client: fix memory leak in SendReceive()
Date: Mon,  2 Feb 2026 06:49:28 +0000
Message-ID: <20260202064928.1879323-1-chenxiaosong.chenxiaosong@linux.dev>
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
	TAGGED_FROM(0.00)[bounces-9205-lists,linux-cifs=lfdr.de];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 4DB73C8F53
X-Rspamd-Action: no action

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

Reproducer:

  1. server: supports SMB1, directories are exported read-only
  2. client: mount -t cifs -o vers=1.0 //${server_ip}/export /mnt
  3. client: dd if=/dev/zero of=/mnt/file bs=512 count=1000 oflag=direct
  4. client: umount /mnt
  5. client: sleep 1
  6. client: modprobe -r cifs

The error message is as follows:

  =============================================================================
  BUG cifs_small_rq (Not tainted): Objects remaining on __kmem_cache_shutdown()
  -----------------------------------------------------------------------------

  Object 0x00000000d34491e6 @offset=896
  Object 0x00000000bde9fab3 @offset=4480
  Object 0x00000000104a1f70 @offset=6272
  Object 0x0000000092a51bb5 @offset=7616
  Object 0x000000006714a7db @offset=13440
  ...
  WARNING: mm/slub.c:1251 at __kmem_cache_shutdown+0x379/0x3f0, CPU#7: modprobe/712
  ...
  Call Trace:
   <TASK>
   kmem_cache_destroy+0x69/0x160
   cifs_destroy_request_bufs+0x39/0x40 [cifs]
   cleanup_module+0x43/0xfc0 [cifs]
   __se_sys_delete_module+0x1d5/0x300
   __x64_sys_delete_module+0x1a/0x30
   x64_sys_call+0x2299/0x2ff0
   do_syscall_64+0x6e/0x270
   entry_SYSCALL_64_after_hwframe+0x76/0x7e
  ...
  kmem_cache_destroy cifs_small_rq: Slab cache still has objects when called from cifs_destroy_request_bufs+0x39/0x40 [cifs]
  WARNING: mm/slab_common.c:532 at kmem_cache_destroy+0x142/0x160, CPU#7: modprobe/712

Link: https://lore.kernel.org/linux-cifs/9751f02d-d1df-4265-a7d6-b19761b21834@linux.dev/T/#mf14808c144448b715f711ce5f0477a071f08eaf6
Fixes: 6be09580df5c ("cifs: Make smb1's SendReceive() wrap cifs_send_recv()")
Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/client/smb1transport.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/smb/client/smb1transport.c b/fs/smb/client/smb1transport.c
index 0528c1919961..0b8b852cfc0d 100644
--- a/fs/smb/client/smb1transport.c
+++ b/fs/smb/client/smb1transport.c
@@ -252,13 +252,15 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	rc = cifs_send_recv(xid, ses, ses->server,
 			    &rqst, &resp_buf_type, flags, &resp_iov);
 	if (rc < 0)
-		return rc;
+		goto out;
 
 	if (out_buf) {
 		*pbytes_returned = resp_iov.iov_len;
 		if (resp_iov.iov_len)
 			memcpy(out_buf, resp_iov.iov_base, resp_iov.iov_len);
 	}
+
+out:
 	free_rsp_buf(resp_buf_type, resp_iov.iov_base);
 	return rc;
 }
-- 
2.52.0


