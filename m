Return-Path: <linux-cifs+bounces-3337-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C69999C27A1
	for <lists+linux-cifs@lfdr.de>; Fri,  8 Nov 2024 23:35:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 036CF1C22DA3
	for <lists+linux-cifs@lfdr.de>; Fri,  8 Nov 2024 22:35:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333661EBFEC;
	Fri,  8 Nov 2024 22:34:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=permerror (0-bit key) header.d=darkrain42.org header.i=@darkrain42.org header.b="oKWad3Qx";
	dkim=pass (2048-bit key) header.d=darkrain42.org header.i=@darkrain42.org header.b="Pv1S2Vl6"
X-Original-To: linux-cifs@vger.kernel.org
Received: from o-chul.darkrain42.org (o-chul.darkrain42.org [74.207.241.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 671E21E25E9
	for <linux-cifs@vger.kernel.org>; Fri,  8 Nov 2024 22:34:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.207.241.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731105298; cv=none; b=apk1e7YDku31sps4opy9CMhmEK2HN5G1/fEmB/umovkV89dnEat/mzeT7xsQNk1SU6fZFV7JkWASafgOB5/YlBhe4eSVfaT52jXvunG/09AD+wA9vcp89w22Pnu/wWr4XAeKJ23fJY91hN0JCQW9SDsFyNQDBAvOaWzchV4pf/8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731105298; c=relaxed/simple;
	bh=z1NPTVEGRJgkV4NMVf7B7TXM0suCdrbH/OD523Ntd2U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YrVun4Cm84BoIzbFG/wGHVRJF5EHt0dbzOnul/NAhYN27OgZwF4gIcKOT/918EUV5pIkfMLN5lrI7vB0DB3VKiVYN0KJ71mjaiOBSQVqj9KKDaAlHHPKnx3jbydqHQSTX4g87jSPG6s+UczDsgF3OjYSTVRPcjbunI+mJ1EYpnc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=darkrain42.org; spf=pass smtp.mailfrom=darkrain42.org; dkim=permerror (0-bit key) header.d=darkrain42.org header.i=@darkrain42.org header.b=oKWad3Qx; dkim=pass (2048-bit key) header.d=darkrain42.org header.i=@darkrain42.org header.b=Pv1S2Vl6; arc=none smtp.client-ip=74.207.241.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=darkrain42.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=darkrain42.org
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed;
 d=darkrain42.org; i=@darkrain42.org; q=dns/txt; s=ed25519-2022-03;
 t=1731104986; h=from : to : cc : subject : date : message-id :
 in-reply-to : references : mime-version : content-transfer-encoding :
 from; bh=p8WpOnJxvAcVTkSylYV8ziEoDslDallo2ugU6AfzJQE=;
 b=oKWad3QxpG2t0RkxJ3mOv/jvAJVHSZ0ZZyNdC2+PD996gu0RATnAF8G71+d3JmzAntfoJ
 wQgnMDQ0V8PMetZAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=darkrain42.org;
 i=@darkrain42.org; q=dns/txt; s=rsa-2022-03; t=1731104986; h=from : to
 : cc : subject : date : message-id : in-reply-to : references :
 mime-version : content-transfer-encoding : from;
 bh=p8WpOnJxvAcVTkSylYV8ziEoDslDallo2ugU6AfzJQE=;
 b=Pv1S2Vl6KhelNvKVJa2YVe2AlsnA+BMOpWBQGIwZtwoApGpsA0PQk9B4OUYOPtlZ7gnne
 WN/YnDMgUPUuIzfRI3O72tCTvfU2nXTvjmInCfTlZOsPNT+HTSj0l7/hnGld7K1lEBm15KC
 Cw40d9UHW7zBZZXsbgOHquQ8ty0WFijkp7b6zKOc4VmNHLSntttpbLMkrq9TLWrorzP5kZ0
 H3rmkDNlkaaEPjLVVdMs6xwjoy0GNqiKDmjfMRnbjvI5rbxNUI9xlPCH+t8X7KfbLJ1rMV1
 cFnk+liQCfqwaaipGzpG7eTKFPqSQ8p1xchAWzBzMp50yRUFYB2oU81vdo4A==
Received: from [127.0.0.1] (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(Client did not present a certificate)
	by o-chul.darkrain42.org (Postfix) with ESMTPSA id 1E93481F2;
	Fri,  8 Nov 2024 14:29:46 -0800 (PST)
From: Paul Aurich <paul@darkrain42.org>
To: linux-cifs@vger.kernel.org,
	Steve French <sfrench@samba.org>
Cc: paul@darkrain42.org,
	Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	Shyam Prasad N <sprasad@microsoft.com>,
	Tom Talpey <tom@talpey.com>,
	Bharath SM <bharathsm@microsoft.com>
Subject: [PATCH 3/5] smb: prevent use-after-free due to open_cached_dir error paths
Date: Fri,  8 Nov 2024 14:29:04 -0800
Message-ID: <20241108222906.3257172-4-paul@darkrain42.org>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241108222906.3257172-1-paul@darkrain42.org>
References: <20241108222906.3257172-1-paul@darkrain42.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If open_cached_dir() encounters an error parsing the lease from the
server, the error handling may race with receiving a lease break,
resulting in open_cached_dir() freeing the cfid while the queued work is
pending.

Update open_cached_dir() to drop refs rather than directly freeing the
cfid.

Have cached_dir_lease_break(), cfids_laundromat_worker(), and
invalidate_all_cached_dirs() clear has_lease immediately while still
holding cfids->cfid_list_lock, and then use this to also simplify the
reference counting in cifds_laundromat_worker() and
invalidate_all_cached_dirs().

Fixes this KASAN splat (which manually injects an error and lease break
in open_cached_dir()):

==================================================================
BUG: KASAN: slab-use-after-free in smb2_cached_lease_break+0x27/0xb0
Read of size 8 at addr ffff88811cc24c10 by task kworker/3:1/65

CPU: 3 UID: 0 PID: 65 Comm: kworker/3:1 Not tainted 6.12.0-rc6-g255cf264e6e5-dirty #87
Hardware name: VMware, Inc. VMware Virtual Platform/440BX Desktop Reference Platform, BIOS 6.00 11/12/2020
Workqueue: cifsiod smb2_cached_lease_break
Call Trace:
 <TASK>
 dump_stack_lvl+0x77/0xb0
 print_report+0xce/0x660
 kasan_report+0xd3/0x110
 smb2_cached_lease_break+0x27/0xb0
 process_one_work+0x50a/0xc50
 worker_thread+0x2ba/0x530
 kthread+0x17c/0x1c0
 ret_from_fork+0x34/0x60
 ret_from_fork_asm+0x1a/0x30
 </TASK>

Allocated by task 2464:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 __kasan_kmalloc+0xaa/0xb0
 open_cached_dir+0xa7d/0x1fb0
 smb2_query_path_info+0x43c/0x6e0
 cifs_get_fattr+0x346/0xf10
 cifs_get_inode_info+0x157/0x210
 cifs_revalidate_dentry_attr+0x2d1/0x460
 cifs_getattr+0x173/0x470
 vfs_statx_path+0x10f/0x160
 vfs_statx+0xe9/0x150
 vfs_fstatat+0x5e/0xc0
 __do_sys_newfstatat+0x91/0xf0
 do_syscall_64+0x95/0x1a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Freed by task 2464:
 kasan_save_stack+0x33/0x60
 kasan_save_track+0x14/0x30
 kasan_save_free_info+0x3b/0x60
 __kasan_slab_free+0x51/0x70
 kfree+0x174/0x520
 open_cached_dir+0x97f/0x1fb0
 smb2_query_path_info+0x43c/0x6e0
 cifs_get_fattr+0x346/0xf10
 cifs_get_inode_info+0x157/0x210
 cifs_revalidate_dentry_attr+0x2d1/0x460
 cifs_getattr+0x173/0x470
 vfs_statx_path+0x10f/0x160
 vfs_statx+0xe9/0x150
 vfs_fstatat+0x5e/0xc0
 __do_sys_newfstatat+0x91/0xf0
 do_syscall_64+0x95/0x1a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

Last potentially related work creation:
 kasan_save_stack+0x33/0x60
 __kasan_record_aux_stack+0xad/0xc0
 insert_work+0x32/0x100
 __queue_work+0x5c9/0x870
 queue_work_on+0x82/0x90
 open_cached_dir+0x1369/0x1fb0
 smb2_query_path_info+0x43c/0x6e0
 cifs_get_fattr+0x346/0xf10
 cifs_get_inode_info+0x157/0x210
 cifs_revalidate_dentry_attr+0x2d1/0x460
 cifs_getattr+0x173/0x470
 vfs_statx_path+0x10f/0x160
 vfs_statx+0xe9/0x150
 vfs_fstatat+0x5e/0xc0
 __do_sys_newfstatat+0x91/0xf0
 do_syscall_64+0x95/0x1a0
 entry_SYSCALL_64_after_hwframe+0x76/0x7e

The buggy address belongs to the object at ffff88811cc24c00
 which belongs to the cache kmalloc-1k of size 1024
The buggy address is located 16 bytes inside of
 freed 1024-byte region [ffff88811cc24c00, ffff88811cc25000)

Cc: stable@vger.kernel.org
Signed-off-by: Paul Aurich <paul@darkrain42.org>
---
 fs/smb/client/cached_dir.c | 70 ++++++++++++++++----------------------
 1 file changed, 29 insertions(+), 41 deletions(-)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index bb9d4c284ce5..06eb19dabb0e 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -346,10 +346,11 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 oshr_free:
 	SMB2_open_free(&rqst[0]);
 	SMB2_query_info_free(&rqst[1]);
 	free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
 	free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
+out:
 	if (rc) {
 		spin_lock(&cfids->cfid_list_lock);
 		if (cfid->on_list) {
 			list_del(&cfid->entry);
 			cfid->on_list = false;
@@ -357,27 +358,18 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 		}
 		if (cfid->has_lease) {
 			/*
 			 * We are guaranteed to have two references at this
 			 * point. One for the caller and one for a potential
-			 * lease. Release the Lease-ref so that the directory
-			 * will be closed when the caller closes the cached
-			 * handle.
+			 * lease. Release one here, and the second below.
 			 */
 			cfid->has_lease = false;
-			spin_unlock(&cfids->cfid_list_lock);
 			kref_put(&cfid->refcount, smb2_close_cached_fid);
-			goto out;
 		}
 		spin_unlock(&cfids->cfid_list_lock);
-	}
-out:
-	if (rc) {
-		if (cfid->is_open)
-			SMB2_close(0, cfid->tcon, cfid->fid.persistent_fid,
-				   cfid->fid.volatile_fid);
-		free_cached_dir(cfid);
+
+		kref_put(&cfid->refcount, smb2_close_cached_fid);
 	} else {
 		*ret_cfid = cfid;
 		atomic_inc(&tcon->num_remote_opens);
 	}
 	kfree(utf16_path);
@@ -511,42 +503,38 @@ void invalidate_all_cached_dirs(struct cifs_tcon *tcon)
 	list_for_each_entry_safe(cfid, q, &cfids->entries, entry) {
 		list_move(&cfid->entry, &entry);
 		cfids->num_entries--;
 		cfid->is_open = false;
 		cfid->on_list = false;
-		/* To prevent race with smb2_cached_lease_break() */
-		kref_get(&cfid->refcount);
+		if (cfid->has_lease) {
+			/*
+			 * The lease was never cancelled from the server,
+			 * so steal that reference.
+			 */
+			cfid->has_lease = false;
+		} else
+			kref_get(&cfid->refcount);
 	}
 	spin_unlock(&cfids->cfid_list_lock);
 
 	list_for_each_entry_safe(cfid, q, &entry, entry) {
 		list_del(&cfid->entry);
 		cancel_work_sync(&cfid->lease_break);
-		if (cfid->has_lease) {
-			/*
-			 * We lease was never cancelled from the server so we
-			 * need to drop the reference.
-			 */
-			spin_lock(&cfids->cfid_list_lock);
-			cfid->has_lease = false;
-			spin_unlock(&cfids->cfid_list_lock);
-			kref_put(&cfid->refcount, smb2_close_cached_fid);
-		}
-		/* Drop the extra reference opened above*/
+		/*
+		 * Drop the ref-count from above, either the lease-ref (if there
+		 * was one) or the extra one acquired.
+		 */
 		kref_put(&cfid->refcount, smb2_close_cached_fid);
 	}
 }
 
 static void
 smb2_cached_lease_break(struct work_struct *work)
 {
 	struct cached_fid *cfid = container_of(work,
 				struct cached_fid, lease_break);
 
-	spin_lock(&cfid->cfids->cfid_list_lock);
-	cfid->has_lease = false;
-	spin_unlock(&cfid->cfids->cfid_list_lock);
 	kref_put(&cfid->refcount, smb2_close_cached_fid);
 }
 
 int cached_dir_lease_break(struct cifs_tcon *tcon, __u8 lease_key[16])
 {
@@ -560,10 +548,11 @@ int cached_dir_lease_break(struct cifs_tcon *tcon, __u8 lease_key[16])
 	list_for_each_entry(cfid, &cfids->entries, entry) {
 		if (cfid->has_lease &&
 		    !memcmp(lease_key,
 			    cfid->fid.lease_key,
 			    SMB2_LEASE_KEY_SIZE)) {
+			cfid->has_lease = false;
 			cfid->time = 0;
 			/*
 			 * We found a lease remove it from the list
 			 * so no threads can access it.
 			 */
@@ -637,12 +626,18 @@ static void cfids_laundromat_worker(struct work_struct *work)
 		if (cfid->time &&
 		    time_after(jiffies, cfid->time + HZ * dir_cache_timeout)) {
 			cfid->on_list = false;
 			list_move(&cfid->entry, &entry);
 			cfids->num_entries--;
-			/* To prevent race with smb2_cached_lease_break() */
-			kref_get(&cfid->refcount);
+			if (cfid->has_lease) {
+				/*
+				 * Our lease has not yet been cancelled from the
+				 * server. Steal that reference.
+				 */
+				cfid->has_lease = false;
+			} else
+				kref_get(&cfid->refcount);
 		}
 	}
 	spin_unlock(&cfids->cfid_list_lock);
 
 	list_for_each_entry_safe(cfid, q, &entry, entry) {
@@ -650,21 +645,14 @@ static void cfids_laundromat_worker(struct work_struct *work)
 		/*
 		 * Cancel and wait for the work to finish in case we are racing
 		 * with it.
 		 */
 		cancel_work_sync(&cfid->lease_break);
-		if (cfid->has_lease) {
-			/*
-			 * Our lease has not yet been cancelled from the server
-			 * so we need to drop the reference.
-			 */
-			spin_lock(&cfids->cfid_list_lock);
-			cfid->has_lease = false;
-			spin_unlock(&cfids->cfid_list_lock);
-			kref_put(&cfid->refcount, smb2_close_cached_fid);
-		}
-		/* Drop the extra reference opened above */
+		/*
+		 * Drop the ref-count from above, either the lease-ref (if there
+		 * was one) or the extra one acquired.
+		 */
 		kref_put(&cfid->refcount, smb2_close_cached_fid);
 	}
 	queue_delayed_work(cifsiod_wq, &cfids->laundromat_work,
 			   dir_cache_timeout * HZ);
 }
-- 
2.45.2


