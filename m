Return-Path: <linux-cifs+bounces-387-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE67980CAF7
	for <lists+linux-cifs@lfdr.de>; Mon, 11 Dec 2023 14:27:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D961A1C202E8
	for <lists+linux-cifs@lfdr.de>; Mon, 11 Dec 2023 13:27:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0106C3E478;
	Mon, 11 Dec 2023 13:27:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="SalmdnJu"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D96CB3
	for <linux-cifs@vger.kernel.org>; Mon, 11 Dec 2023 05:27:03 -0800 (PST)
From: Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1702301221;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YWnuuY6cnhb3xQ30lNjNpm7N7j/987LT3QzkeuMcxE=;
	b=SalmdnJuK3oZmAMHoHxNnnWNsFvM1aIvm7Kpe7ZDLrfw7UHXopnLiEDYo7hw4EThdIqttA
	hVhRz2kf38/GCrxcARmTFcZdBOL2l7GK+abDdTmJSDqeivNVEyLFlGUz1Tz2BptmjWOiqx
	dpu6ijqSCBCLFn41U8ze2uEY/STJcZxo1gBmQ/Ssmsnu6BZf6QoYCsh1Ep9zWLXIs0+ScV
	P5KoKeU3hi4W1bN1A67YPGZrDW8TCqjn6j8DSDh/zwY2KQsqOXwQDzd3Ald2hOx4Du3Gsd
	8/mHCRZ73/7QFGDc1X2uerEJYMUl/xUIZ7Ru121eBuyFvWYISWqtoke+NRGoZg==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1702301221; a=rsa-sha256;
	cv=none;
	b=Dc+Nxwc+MWg7BpcGKPa4f+1eas7yubdhwxuR9qSCGfdsGvYUUg4Ci99E7RTUhgNuKPdTli
	OqIdH7e9tzR03KCJqhkwQ5mePD/2k6NE6QXTThhNU9w07lX3pqlGiT1lz6R2kZIU+PkoK4
	diWMdTj3Mt0WWYmdVaZSeTAu+akVGokOZE440+3GjZ8zV2tpvNfkmGo2IbcAAlAAjX1Mrl
	q+zRrCNBLKeEXbGU80CEA9wi0OxY4q6JClka775zn3RK2GatwXrJsmJDhW7l3L1H+I2K07
	Qx4vlkYWWWKzKLkZbKXpwksqupBtBpOhlopA2jAedXFsjjo+cni9Vzl/gseumw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1702301221; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5YWnuuY6cnhb3xQ30lNjNpm7N7j/987LT3QzkeuMcxE=;
	b=W8SOCckPeJU0x1fz8DSf09ctDTO15dw0fg04F3TFy813ThOC0GfRlvQyQ9SmyODfScfnqs
	B8TjYo21wDnnV90fvWyZvYSjgEKYSinjBMY+af695QjBG1M0m//oHi02lBFnXOox+MQlS4
	wLvklK61BMsjpUjVqej21RJfFtac6LwPkBOU8CLCV8NbAU6PtoxoLMCpVNPD+veXELMuij
	wxW3mevxxC3ssMBKLub4xXSUdUW+iCrfaNKINYRpPRiMl5BHZD5xnX/VMrFYCTLnAJlTJW
	VZTQTIuNymMBtwQHzu+VuwGpvE+vvil1bETpNEeOYKKNwbGuER/2cqXuZMkrrQ==
To: smfrench@gmail.com
Cc: linux-cifs@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>,
	Robert Morris <rtm@csail.mit.edu>
Subject: [PATCH 4/4] smb: client: fix OOB in smb2_query_reparse_point()
Date: Mon, 11 Dec 2023 10:26:43 -0300
Message-ID: <20231211132643.18724-4-pc@manguebit.com>
In-Reply-To: <20231211132643.18724-1-pc@manguebit.com>
References: <20231211132643.18724-1-pc@manguebit.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate @ioctl_rsp->OutputOffset and @ioctl_rsp->OutputCount so that
their sum does not wrap to a number that is smaller than @reparse_buf
and we end up with a wild pointer as follows:

  BUG: unable to handle page fault for address: ffff88809c5cd45f
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 4a01067 P4D 4a01067 PUD 0
  Oops: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 2 PID: 1260 Comm: mount.cifs Not tainted 6.7.0-rc4 #2
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
  rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
  RIP: 0010:smb2_query_reparse_point+0x3e0/0x4c0 [cifs]
  Code: ff ff e8 f3 51 fe ff 41 89 c6 58 5a 45 85 f6 0f 85 14 fe ff ff
  49 8b 57 48 8b 42 60 44 8b 42 64 42 8d 0c 00 49 39 4f 50 72 40 <8b>
  04 02 48 8b 9d f0 fe ff ff 49 8b 57 50 89 03 48 8b 9d e8 fe ff
  RSP: 0018:ffffc90000347a90 EFLAGS: 00010212
  RAX: 000000008000001f RBX: ffff88800ae11000 RCX: 00000000000000ec
  RDX: ffff88801c5cd440 RSI: 0000000000000000 RDI: ffffffff82004aa4
  RBP: ffffc90000347bb0 R08: 00000000800000cd R09: 0000000000000001
  R10: 0000000000000000 R11: 0000000000000024 R12: ffff8880114d4100
  R13: ffff8880114d4198 R14: 0000000000000000 R15: ffff8880114d4000
  FS: 00007f02c07babc0(0000) GS:ffff88806ba00000(0000)
  knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffff88809c5cd45f CR3: 0000000011750000 CR4: 0000000000750ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? __die+0x23/0x70
   ? page_fault_oops+0x181/0x480
   ? search_module_extables+0x19/0x60
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? exc_page_fault+0x1b6/0x1c0
   ? asm_exc_page_fault+0x26/0x30
   ? _raw_spin_unlock_irqrestore+0x44/0x60
   ? smb2_query_reparse_point+0x3e0/0x4c0 [cifs]
   cifs_get_fattr+0x16e/0xa50 [cifs]
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? lock_acquire+0xbf/0x2b0
   cifs_root_iget+0x163/0x5f0 [cifs]
   cifs_smb3_do_mount+0x5bd/0x780 [cifs]
   smb3_get_tree+0xd9/0x290 [cifs]
   vfs_get_tree+0x2c/0x100
   ? capable+0x37/0x70
   path_mount+0x2d7/0xb80
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? _raw_spin_unlock_irqrestore+0x44/0x60
   __x64_sys_mount+0x11a/0x150
   do_syscall_64+0x47/0xf0
   entry_SYSCALL_64_after_hwframe+0x6f/0x77
  RIP: 0033:0x7f02c08d5b1e

Fixes: 2e4564b31b64 ("smb3: add support for stat of WSL reparse points for special file types")
Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
---
 fs/smb/client/smb2ops.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index a6f4948adcbb..8f6f0a38b886 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -3003,7 +3003,7 @@ static int smb2_query_reparse_point(const unsigned int xid,
 	struct kvec *rsp_iov;
 	struct smb2_ioctl_rsp *ioctl_rsp;
 	struct reparse_data_buffer *reparse_buf;
-	u32 plen;
+	u32 off, count, len;
 
 	cifs_dbg(FYI, "%s: path: %s\n", __func__, full_path);
 
@@ -3084,16 +3084,22 @@ static int smb2_query_reparse_point(const unsigned int xid,
 	 */
 	if (rc == 0) {
 		/* See MS-FSCC 2.3.23 */
+		off = le32_to_cpu(ioctl_rsp->OutputOffset);
+		count = le32_to_cpu(ioctl_rsp->OutputCount);
+		if (check_add_overflow(off, count, &len) ||
+		    len > rsp_iov[1].iov_len) {
+			cifs_tcon_dbg(VFS, "%s: invalid ioctl: off=%d count=%d\n",
+				      __func__, off, count);
+			rc = -EIO;
+			goto query_rp_exit;
+		}
 
-		reparse_buf = (struct reparse_data_buffer *)
-			((char *)ioctl_rsp +
-			 le32_to_cpu(ioctl_rsp->OutputOffset));
-		plen = le32_to_cpu(ioctl_rsp->OutputCount);
-
-		if (plen + le32_to_cpu(ioctl_rsp->OutputOffset) >
-		    rsp_iov[1].iov_len) {
-			cifs_tcon_dbg(FYI, "srv returned invalid ioctl len: %d\n",
-				 plen);
+		reparse_buf = (void *)((u8 *)ioctl_rsp + off);
+		len = sizeof(*reparse_buf);
+		if (count < len ||
+		    count < le16_to_cpu(reparse_buf->ReparseDataLength) + len) {
+			cifs_tcon_dbg(VFS, "%s: invalid ioctl: off=%d count=%d\n",
+				      __func__, off, count);
 			rc = -EIO;
 			goto query_rp_exit;
 		}
-- 
2.43.0


