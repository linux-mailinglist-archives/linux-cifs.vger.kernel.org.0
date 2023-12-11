Return-Path: <linux-cifs+bounces-385-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2A42D80CAF5
	for <lists+linux-cifs@lfdr.de>; Mon, 11 Dec 2023 14:27:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 319561C20FB0
	for <lists+linux-cifs@lfdr.de>; Mon, 11 Dec 2023 13:27:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B2743E482;
	Mon, 11 Dec 2023 13:27:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="VrzrMQ2o"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86DCADF
	for <linux-cifs@vger.kernel.org>; Mon, 11 Dec 2023 05:26:59 -0800 (PST)
From: Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1702301217;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GylB4GX2Wj3U+P2mGgsqQMh6p0MZvDAIFEJHvnhlWYY=;
	b=VrzrMQ2olVYNUOm6kl5j5qEbS7mKkJqqTjt9Kqmzu+Ggxe7qmJwpBfHghQ6shqJMOQ4+uN
	VAy1q8nPVShXHkwVEMmPA+SZeifkpI6BYiFIhPGskfXwU+iJKc5vN7l8+N7lkR64iXv6BE
	GvG9RHhG2ZZATdvVCo7Rp+cdHCHk5e5rtdnWtbqOn4mNwED9Dlc+QJ1x5pSzVQovyTro96
	2X5ALQgwfJLP3saN1CFNu/Rk7Mmb07t7OHufofuQYH3zJftR04p2DxP7LHxDn6J27fyAMV
	ajBxM6jnV5D6fUOG0YcUpMdczf5g7DYAuZttwyPZGTO/g9Bxm94YOKmA45ZP8A==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1702301217; a=rsa-sha256;
	cv=none;
	b=PYTmugtlSmEYJrfhngXLA9GMjOV4O7778wHhFfTsVRI3uQUcoZzI2VwmrtgJi4XPckTJW1
	EDtZIL0QuySI1YsAKvJyZCi+nRznZ+iQl6ngazxCV3Hxeta280fmEQNi4rAvRdfCKkdNxu
	AmVvPUDxJusfPLscpCgC1oRNMMnyPyx4wqiwMI5VZawqj3OrkyOHyM+SGt8uCGIbp22syN
	Jd3ShWxrGLwmwU6gzK+DyyDLRqHWJ32TFnxbSVfse4U3LfhbjIKRH4Ur81kdDquHxoVbi4
	4U7k/r5hnggzpa21OrC3Z+9whJq1w4zYktm2j5YGyc4MUo6LhGoA50fZdeEBTQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1702301217; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GylB4GX2Wj3U+P2mGgsqQMh6p0MZvDAIFEJHvnhlWYY=;
	b=DkqGzAIHI66tMG0lUk+g5fCxkF2vpav/1KNEmyq95hAlUPmH12rPDegsB707oeUec9At87
	TzeswGjwPU0rGg8/MjaqYbv3OH4pA9jRJ/OPRjC4cvQFl6kmDQPPAILJNN3e4Ucd0YP6KF
	2EmrRnv9tWZaxL8ii5rUPA337pIf9tet8dwdFRMV0baYMyelXA9lz8tggJ+u40wog4/fW/
	Ep/DuyxEUPG48mZvijMbaFDkzsLTgUK0KDes0P7x/7pJ/v2wfYGvEfIgnxqvdToC1jW5dx
	grPsYk9tCkYmj+e4iPaRc9Rp6AMosAXA4zmDxTOSAN5zIIq70SPzTfi7IN837A==
To: smfrench@gmail.com
Cc: linux-cifs@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>,
	Robert Morris <rtm@csail.mit.edu>
Subject: [PATCH 2/4] smb: client: fix potential OOBs in smb2_parse_contexts()
Date: Mon, 11 Dec 2023 10:26:41 -0300
Message-ID: <20231211132643.18724-2-pc@manguebit.com>
In-Reply-To: <20231211132643.18724-1-pc@manguebit.com>
References: <20231211132643.18724-1-pc@manguebit.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Validate offsets and lengths before dereferencing create contexts in
smb2_parse_contexts().

This fixes following oops when accessing invalid create contexts from
server:

  BUG: unable to handle page fault for address: ffff8881178d8cc3
  #PF: supervisor read access in kernel mode
  #PF: error_code(0x0000) - not-present page
  PGD 4a01067 P4D 4a01067 PUD 0
  Oops: 0000 [#1] PREEMPT SMP NOPTI
  CPU: 3 PID: 1736 Comm: mount.cifs Not tainted 6.7.0-rc4 #1
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
  rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
  RIP: 0010:smb2_parse_contexts+0xa0/0x3a0 [cifs]
  Code: f8 10 75 13 48 b8 93 ad 25 50 9c b4 11 e7 49 39 06 0f 84 d2 00
  00 00 8b 45 00 85 c0 74 61 41 29 c5 48 01 c5 41 83 fd 0f 76 55 <0f> b7
  7d 04 0f b7 45 06 4c 8d 74 3d 00 66 83 f8 04 75 bc ba 04 00
  RSP: 0018:ffffc900007939e0 EFLAGS: 00010216
  RAX: ffffc90000793c78 RBX: ffff8880180cc000 RCX: ffffc90000793c90
  RDX: ffffc90000793cc0 RSI: ffff8880178d8cc0 RDI: ffff8880180cc000
  RBP: ffff8881178d8cbf R08: ffffc90000793c22 R09: 0000000000000000
  R10: ffff8880180cc000 R11: 0000000000000024 R12: 0000000000000000
  R13: 0000000000000020 R14: 0000000000000000 R15: ffffc90000793c22
  FS: 00007f873753cbc0(0000) GS:ffff88806bc00000(0000)
  knlGS:0000000000000000
  CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
  CR2: ffff8881178d8cc3 CR3: 00000000181ca000 CR4: 0000000000750ef0
  PKRU: 55555554
  Call Trace:
   <TASK>
   ? __die+0x23/0x70
   ? page_fault_oops+0x181/0x480
   ? search_module_extables+0x19/0x60
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? exc_page_fault+0x1b6/0x1c0
   ? asm_exc_page_fault+0x26/0x30
   ? smb2_parse_contexts+0xa0/0x3a0 [cifs]
   SMB2_open+0x38d/0x5f0 [cifs]
   ? smb2_is_path_accessible+0x138/0x260 [cifs]
   smb2_is_path_accessible+0x138/0x260 [cifs]
   cifs_is_path_remote+0x8d/0x230 [cifs]
   cifs_mount+0x7e/0x350 [cifs]
   cifs_smb3_do_mount+0x128/0x780 [cifs]
   smb3_get_tree+0xd9/0x290 [cifs]
   vfs_get_tree+0x2c/0x100
   ? capable+0x37/0x70
   path_mount+0x2d7/0xb80
   ? srso_alias_return_thunk+0x5/0xfbef5
   ? _raw_spin_unlock_irqrestore+0x44/0x60
   __x64_sys_mount+0x11a/0x150
   do_syscall_64+0x47/0xf0
   entry_SYSCALL_64_after_hwframe+0x6f/0x77
  RIP: 0033:0x7f8737657b1e

Reported-by: Robert Morris <rtm@csail.mit.edu>
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
---
 fs/smb/client/cached_dir.c | 17 ++++---
 fs/smb/client/smb2pdu.c    | 91 +++++++++++++++++++++++---------------
 fs/smb/client/smb2proto.h  | 12 ++---
 3 files changed, 74 insertions(+), 46 deletions(-)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index 59f6b8e32cc9..d64a306a414b 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -291,16 +291,23 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	oparms.fid->mid = le64_to_cpu(o_rsp->hdr.MessageId);
 #endif /* CIFS_DEBUG2 */
 
-	rc = -EINVAL;
+
 	if (o_rsp->OplockLevel != SMB2_OPLOCK_LEVEL_LEASE) {
 		spin_unlock(&cfids->cfid_list_lock);
+		rc = -EINVAL;
 		goto oshr_free;
 	}
 
-	smb2_parse_contexts(server, o_rsp,
-			    &oparms.fid->epoch,
-			    oparms.fid->lease_key, &oplock,
-			    NULL, NULL);
+	rc = smb2_parse_contexts(server, rsp_iov,
+				 &oparms.fid->epoch,
+				 oparms.fid->lease_key,
+				 &oplock, NULL, NULL);
+	if (rc) {
+		spin_unlock(&cfids->cfid_list_lock);
+		goto oshr_free;
+	}
+
+	rc = -EINVAL;
 	if (!(oplock & SMB2_LEASE_READ_CACHING_HE)) {
 		spin_unlock(&cfids->cfid_list_lock);
 		goto oshr_free;
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 20634fc6d4f0..c571760ad39a 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2236,17 +2236,18 @@ parse_posix_ctxt(struct create_context *cc, struct smb2_file_all_info *info,
 		 posix->nlink, posix->mode, posix->reparse_tag);
 }
 
-void
-smb2_parse_contexts(struct TCP_Server_Info *server,
-		    struct smb2_create_rsp *rsp,
-		    unsigned int *epoch, char *lease_key, __u8 *oplock,
-		    struct smb2_file_all_info *buf,
-		    struct create_posix_rsp *posix)
+int smb2_parse_contexts(struct TCP_Server_Info *server,
+			struct kvec *rsp_iov,
+			unsigned int *epoch,
+			char *lease_key, __u8 *oplock,
+			struct smb2_file_all_info *buf,
+			struct create_posix_rsp *posix)
 {
-	char *data_offset;
+	struct smb2_create_rsp *rsp = rsp_iov->iov_base;
 	struct create_context *cc;
-	unsigned int next;
-	unsigned int remaining;
+	size_t rem, off, len;
+	size_t doff, dlen;
+	size_t noff, nlen;
 	char *name;
 	static const char smb3_create_tag_posix[] = {
 		0x93, 0xAD, 0x25, 0x50, 0x9C,
@@ -2255,45 +2256,63 @@ smb2_parse_contexts(struct TCP_Server_Info *server,
 	};
 
 	*oplock = 0;
-	data_offset = (char *)rsp + le32_to_cpu(rsp->CreateContextsOffset);
-	remaining = le32_to_cpu(rsp->CreateContextsLength);
-	cc = (struct create_context *)data_offset;
+
+	off = le32_to_cpu(rsp->CreateContextsOffset);
+	rem = le32_to_cpu(rsp->CreateContextsLength);
+	if (check_add_overflow(off, rem, &len) || len > rsp_iov->iov_len)
+		return -EINVAL;
+	cc = (struct create_context *)((u8 *)rsp + off);
 
 	/* Initialize inode number to 0 in case no valid data in qfid context */
 	if (buf)
 		buf->IndexNumber = 0;
 
-	while (remaining >= sizeof(struct create_context)) {
-		name = le16_to_cpu(cc->NameOffset) + (char *)cc;
-		if (le16_to_cpu(cc->NameLength) == 4 &&
-		    strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4) == 0)
-			*oplock = server->ops->parse_lease_buf(cc, epoch,
-							   lease_key);
-		else if (buf && (le16_to_cpu(cc->NameLength) == 4) &&
-		    strncmp(name, SMB2_CREATE_QUERY_ON_DISK_ID, 4) == 0)
-			parse_query_id_ctxt(cc, buf);
-		else if ((le16_to_cpu(cc->NameLength) == 16)) {
-			if (posix &&
-			    memcmp(name, smb3_create_tag_posix, 16) == 0)
+	while (rem >= sizeof(*cc)) {
+		doff = le16_to_cpu(cc->DataOffset);
+		dlen = le32_to_cpu(cc->DataLength);
+		if (check_add_overflow(doff, dlen, &len) || len > rem)
+			return -EINVAL;
+
+		noff = le16_to_cpu(cc->NameOffset);
+		nlen = le16_to_cpu(cc->NameLength);
+		if (noff + nlen >= doff)
+			return -EINVAL;
+
+		name = (char *)cc + noff;
+		switch (nlen) {
+		case 4:
+			if (!strncmp(name, SMB2_CREATE_REQUEST_LEASE, 4)) {
+				*oplock = server->ops->parse_lease_buf(cc, epoch,
+								       lease_key);
+			} else if (buf &&
+				   !strncmp(name, SMB2_CREATE_QUERY_ON_DISK_ID, 4)) {
+				parse_query_id_ctxt(cc, buf);
+			}
+			break;
+		case 16:
+			if (posix && !memcmp(name, smb3_create_tag_posix, 16))
 				parse_posix_ctxt(cc, buf, posix);
+			break;
+		default:
+			cifs_dbg(FYI, "%s: unhandled context (nlen=%zu dlen=%zu)\n",
+				 __func__, nlen, dlen);
+			if (IS_ENABLED(CONFIG_CIFS_DEBUG2))
+				cifs_dump_mem("context data: ", cc, dlen);
+			break;
 		}
-		/* else {
-			cifs_dbg(FYI, "Context not matched with len %d\n",
-				le16_to_cpu(cc->NameLength));
-			cifs_dump_mem("Cctxt name: ", name, 4);
-		} */
 
-		next = le32_to_cpu(cc->Next);
-		if (!next)
+		off = le32_to_cpu(cc->Next);
+		if (!off)
 			break;
-		remaining -= next;
-		cc = (struct create_context *)((char *)cc + next);
+		if (check_sub_overflow(rem, off, &rem))
+			return -EINVAL;
+		cc = (struct create_context *)((u8 *)cc + off);
 	}
 
 	if (rsp->OplockLevel != SMB2_OPLOCK_LEVEL_LEASE)
 		*oplock = rsp->OplockLevel;
 
-	return;
+	return 0;
 }
 
 static int
@@ -3124,8 +3143,8 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	}
 
 
-	smb2_parse_contexts(server, rsp, &oparms->fid->epoch,
-			    oparms->fid->lease_key, oplock, buf, posix);
+	rc = smb2_parse_contexts(server, &rsp_iov, &oparms->fid->epoch,
+				 oparms->fid->lease_key, oplock, buf, posix);
 creat_exit:
 	SMB2_open_free(&rqst);
 	free_rsp_buf(resp_buftype, rsp);
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 46eff9ec302a..0e371f7e2854 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -251,11 +251,13 @@ extern int smb3_validate_negotiate(const unsigned int, struct cifs_tcon *);
 
 extern enum securityEnum smb2_select_sectype(struct TCP_Server_Info *,
 					enum securityEnum);
-extern void smb2_parse_contexts(struct TCP_Server_Info *server,
-				struct smb2_create_rsp *rsp,
-				unsigned int *epoch, char *lease_key,
-				__u8 *oplock, struct smb2_file_all_info *buf,
-				struct create_posix_rsp *posix);
+int smb2_parse_contexts(struct TCP_Server_Info *server,
+			struct kvec *rsp_iov,
+			unsigned int *epoch,
+			char *lease_key, __u8 *oplock,
+			struct smb2_file_all_info *buf,
+			struct create_posix_rsp *posix);
+
 extern int smb3_encryption_required(const struct cifs_tcon *tcon);
 extern int smb2_validate_iov(unsigned int offset, unsigned int buffer_length,
 			     struct kvec *iov, unsigned int min_buf_size);
-- 
2.43.0


