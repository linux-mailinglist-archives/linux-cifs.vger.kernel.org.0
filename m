Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B11E8EA07A
	for <lists+linux-cifs@lfdr.de>; Wed, 30 Oct 2019 16:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728936AbfJ3P46 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 30 Oct 2019 11:56:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:58482 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726964AbfJ3P4z (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 30 Oct 2019 11:56:55 -0400
Received: from sasha-vm.mshome.net (100.50.158.77.rev.sfr.net [77.158.50.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 40BDE2083E;
        Wed, 30 Oct 2019 15:56:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1572451013;
        bh=sJExn/v6rfVY73vDlOBZHLw/udTUWt5BimvLvJe254w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=RzFdBVfQSXBGVQ39LHzvjmiidBXCApe7py+rDSeTDPAjyQZ2WfRijQaSzdhaBgZdn
         vhzEI6FQTc803cbcwE6j6eX5545zkDn2hC4mcBBElNe/RWJNsMJjFAccVSGBgQd12F
         DJtbQznmFKfaOdYYhWmWrf+StcDx3zMEU0AzXHqU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Dave Wysochanski <dwysocha@redhat.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Pavel Shilovsky <pshilov@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 4.14 22/24] cifs: Fix cifsInodeInfo lock_sem deadlock when reconnect occurs
Date:   Wed, 30 Oct 2019 11:55:53 -0400
Message-Id: <20191030155555.10494-22-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20191030155555.10494-1-sashal@kernel.org>
References: <20191030155555.10494-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

From: Dave Wysochanski <dwysocha@redhat.com>

[ Upstream commit d46b0da7a33dd8c99d969834f682267a45444ab3 ]

There's a deadlock that is possible and can easily be seen with
a test where multiple readers open/read/close of the same file
and a disruption occurs causing reconnect.  The deadlock is due
a reader thread inside cifs_strict_readv calling down_read and
obtaining lock_sem, and then after reconnect inside
cifs_reopen_file calling down_read a second time.  If in
between the two down_read calls, a down_write comes from
another process, deadlock occurs.

        CPU0                    CPU1
        ----                    ----
cifs_strict_readv()
 down_read(&cifsi->lock_sem);
                               _cifsFileInfo_put
                                  OR
                               cifs_new_fileinfo
                                down_write(&cifsi->lock_sem);
cifs_reopen_file()
 down_read(&cifsi->lock_sem);

Fix the above by changing all down_write(lock_sem) calls to
down_write_trylock(lock_sem)/msleep() loop, which in turn
makes the second down_read call benign since it will never
block behind the writer while holding lock_sem.

Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
Suggested-by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed--by: Ronnie Sahlberg <lsahlber@redhat.com>
Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsglob.h  |  5 +++++
 fs/cifs/cifsproto.h |  1 +
 fs/cifs/file.c      | 23 +++++++++++++++--------
 fs/cifs/smb2file.c  |  2 +-
 4 files changed, 22 insertions(+), 9 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 7b7ab10a9db18..600bb838c15b8 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1210,6 +1210,11 @@ void cifsFileInfo_put(struct cifsFileInfo *cifs_file);
 struct cifsInodeInfo {
 	bool can_cache_brlcks;
 	struct list_head llist;	/* locks helb by this inode */
+	/*
+	 * NOTE: Some code paths call down_read(lock_sem) twice, so
+	 * we must always use use cifs_down_write() instead of down_write()
+	 * for this semaphore to avoid deadlocks.
+	 */
 	struct rw_semaphore lock_sem;	/* protect the fields above */
 	/* BB add in lists for dirty pages i.e. write caching info for oplock */
 	struct list_head openFileList;
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index ccdb42f71b2e8..3a7fb8e750e97 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -149,6 +149,7 @@ extern int cifs_unlock_range(struct cifsFileInfo *cfile,
 			     struct file_lock *flock, const unsigned int xid);
 extern int cifs_push_mandatory_locks(struct cifsFileInfo *cfile);
 
+extern void cifs_down_write(struct rw_semaphore *sem);
 extern struct cifsFileInfo *cifs_new_fileinfo(struct cifs_fid *fid,
 					      struct file *file,
 					      struct tcon_link *tlink,
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 71a960da7cce1..40f22932343c6 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -280,6 +280,13 @@ cifs_has_mand_locks(struct cifsInodeInfo *cinode)
 	return has_locks;
 }
 
+void
+cifs_down_write(struct rw_semaphore *sem)
+{
+	while (!down_write_trylock(sem))
+		msleep(10);
+}
+
 struct cifsFileInfo *
 cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 		  struct tcon_link *tlink, __u32 oplock)
@@ -305,7 +312,7 @@ cifs_new_fileinfo(struct cifs_fid *fid, struct file *file,
 	INIT_LIST_HEAD(&fdlocks->locks);
 	fdlocks->cfile = cfile;
 	cfile->llist = fdlocks;
-	down_write(&cinode->lock_sem);
+	cifs_down_write(&cinode->lock_sem);
 	list_add(&fdlocks->llist, &cinode->llist);
 	up_write(&cinode->lock_sem);
 
@@ -457,7 +464,7 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_file, bool wait_oplock_handler)
 	 * Delete any outstanding lock records. We'll lose them when the file
 	 * is closed anyway.
 	 */
-	down_write(&cifsi->lock_sem);
+	cifs_down_write(&cifsi->lock_sem);
 	list_for_each_entry_safe(li, tmp, &cifs_file->llist->locks, llist) {
 		list_del(&li->llist);
 		cifs_del_lock_waiters(li);
@@ -1011,7 +1018,7 @@ static void
 cifs_lock_add(struct cifsFileInfo *cfile, struct cifsLockInfo *lock)
 {
 	struct cifsInodeInfo *cinode = CIFS_I(d_inode(cfile->dentry));
-	down_write(&cinode->lock_sem);
+	cifs_down_write(&cinode->lock_sem);
 	list_add_tail(&lock->llist, &cfile->llist->locks);
 	up_write(&cinode->lock_sem);
 }
@@ -1033,7 +1040,7 @@ cifs_lock_add_if(struct cifsFileInfo *cfile, struct cifsLockInfo *lock,
 
 try_again:
 	exist = false;
-	down_write(&cinode->lock_sem);
+	cifs_down_write(&cinode->lock_sem);
 
 	exist = cifs_find_lock_conflict(cfile, lock->offset, lock->length,
 					lock->type, &conf_lock, CIFS_LOCK_OP);
@@ -1055,7 +1062,7 @@ cifs_lock_add_if(struct cifsFileInfo *cfile, struct cifsLockInfo *lock,
 					(lock->blist.next == &lock->blist));
 		if (!rc)
 			goto try_again;
-		down_write(&cinode->lock_sem);
+		cifs_down_write(&cinode->lock_sem);
 		list_del_init(&lock->blist);
 	}
 
@@ -1108,7 +1115,7 @@ cifs_posix_lock_set(struct file *file, struct file_lock *flock)
 		return rc;
 
 try_again:
-	down_write(&cinode->lock_sem);
+	cifs_down_write(&cinode->lock_sem);
 	if (!cinode->can_cache_brlcks) {
 		up_write(&cinode->lock_sem);
 		return rc;
@@ -1314,7 +1321,7 @@ cifs_push_locks(struct cifsFileInfo *cfile)
 	int rc = 0;
 
 	/* we are going to update can_cache_brlcks here - need a write access */
-	down_write(&cinode->lock_sem);
+	cifs_down_write(&cinode->lock_sem);
 	if (!cinode->can_cache_brlcks) {
 		up_write(&cinode->lock_sem);
 		return rc;
@@ -1505,7 +1512,7 @@ cifs_unlock_range(struct cifsFileInfo *cfile, struct file_lock *flock,
 	if (!buf)
 		return -ENOMEM;
 
-	down_write(&cinode->lock_sem);
+	cifs_down_write(&cinode->lock_sem);
 	for (i = 0; i < 2; i++) {
 		cur = buf;
 		num = 0;
diff --git a/fs/cifs/smb2file.c b/fs/cifs/smb2file.c
index 1add404618f06..2c809233084bb 100644
--- a/fs/cifs/smb2file.c
+++ b/fs/cifs/smb2file.c
@@ -139,7 +139,7 @@ smb2_unlock_range(struct cifsFileInfo *cfile, struct file_lock *flock,
 
 	cur = buf;
 
-	down_write(&cinode->lock_sem);
+	cifs_down_write(&cinode->lock_sem);
 	list_for_each_entry_safe(li, tmp, &cfile->llist->locks, llist) {
 		if (flock->fl_start > li->offset ||
 		    (flock->fl_start + length) <
-- 
2.20.1

