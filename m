Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1782EE1134
	for <lists+linux-cifs@lfdr.de>; Wed, 23 Oct 2019 06:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732748AbfJWEuy (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 23 Oct 2019 00:50:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:31076 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1732753AbfJWEuy (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 23 Oct 2019 00:50:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1571806252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Vd0e3nEW+sW/DtHq0UtXLwpUsjwVDiaera1vKpPdQDk=;
        b=W8Ccxomhv8XA0hceK1/1E4YMFkOPKMHYGl9AqNhUZAJyPsgCGxmAGolGMt7fNk+AiX1Gk6
        HjudYKLUOikWmMwzxyF6SJJjSZynJ9ZnHmUJnAq1acFP08DDAb/7kTM2SPSQHJeu/hY9D7
        oOju6sw3b+mmL9Qlg4yZvnKzhIyKqJA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-42-XiC5dDOPP2OLFUloeiLY5w-1; Wed, 23 Oct 2019 00:50:49 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 49F0847B
        for <linux-cifs@vger.kernel.org>; Wed, 23 Oct 2019 04:50:48 +0000 (UTC)
Received: from colo-mx.corp.redhat.com (colo-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.20])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 40CB460624
        for <linux-cifs@vger.kernel.org>; Wed, 23 Oct 2019 04:50:48 +0000 (UTC)
Received: from zmail25.collab.prod.int.phx2.redhat.com (zmail25.collab.prod.int.phx2.redhat.com [10.5.83.31])
        by colo-mx.corp.redhat.com (Postfix) with ESMTP id 2EF4A18089C8;
        Wed, 23 Oct 2019 04:50:48 +0000 (UTC)
Date:   Wed, 23 Oct 2019 00:50:48 -0400 (EDT)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     Dave Wysochanski <dwysocha@redhat.com>
Cc:     linux-cifs@vger.kernel.org
Message-ID: <1786263555.8106229.1571806248056.JavaMail.zimbra@redhat.com>
In-Reply-To: <1571776423-32000-1-git-send-email-dwysocha@redhat.com>
References: <1571776423-32000-1-git-send-email-dwysocha@redhat.com>
Subject: Re: [RFC PATCH] cifs: Fix cifsInodeInfo lock_sem deadlock with
 multiple readers
MIME-Version: 1.0
X-Originating-IP: [10.64.54.48, 10.4.195.11]
Thread-Topic: cifs: Fix cifsInodeInfo lock_sem deadlock with multiple readers
Thread-Index: 0yzaKb3c7PHu7jVoLit+Z/U/T5jc2w==
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-MC-Unique: XiC5dDOPP2OLFUloeiLY5w-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org





----- Original Message -----
> From: "Dave Wysochanski" <dwysocha@redhat.com>
> To: linux-cifs@vger.kernel.org
> Sent: Wednesday, 23 October, 2019 6:33:43 AM
> Subject: [RFC PATCH] cifs: Fix cifsInodeInfo lock_sem deadlock with multi=
ple readers
>=20
> NOTE: I have verified this fixes the problem but have not run
> locking tests yet.
>=20
> There's a deadlock that is possible that can easily be seen with
> multiple readers open/read/close of the same file.  The deadlock
> is due to a reader calling down_read(lock_sem) and holding
> it across the full IO, even if a network or server disruption
> occurs and the session has to be reconnected.  Upon reconnect,
> cifs_relock_file is called where down_read(lock_sem) is called
> a second time.  Normally this is not a problem, but if there is
> another process that calls down_write(lock_sem) in between the
> first and second reader call to down_read(lock_sem), this will
> cause a deadlock.  The caller of down_write (often either
> _cifsFileInfo_put that is just removing and freeing cifsLockInfo
> structures from the list of locks, or cifs_new_fileinfo, which
> is just attaching cifs_fid_locks to cifsInodeInfo->llist), will
> block due to the reader's first down_read(lock_sem) that obtains
> the semaphore (read IO in flight).  And then when the server
> comes back up, the reader that holds calls down_read(lock_sem)
> a second time, and this time is blocked too because of the
> blocked in down_write (rw_semaphores would starve writers if
> this was not the case).  Interestingly enough, the callers of
> down_write in the simple test case was not adding a
> conflicting lock at all, just either opening or closing the
> file, and modifying the list of locks attached to cifsInodeInfo,
> this ends up tripping up the reader process and causing the
> deadlock.
>=20
> The root of the problem is that lock_sem both protects the
> cifsInodeInfo fields (such as the lllist - the list of locks),
> but is also being re-used to avoid a conflicting lock coming
> in while IO is in flight.  Add a new semaphore that tracks
> just the IO in flight, and must be obtained before adding
> a new lock.  While this does add another layer of complexity
> and a semaphore ordering that must be obeyed to avoid new
> deadlocks, it does clealy solve the underlying problem.

The patch is hard to read(not your fault) since "patch" decided that almost=
 all changes are in cifs_closedir() :-(


You are reverting 560d388950. it is unfortunate because I think we should m=
ake either cifs_reopen_file() or cifs_strict_readv()
using down_read_nested() to suppress the warnings from the validator or els=
e we will get a lot of these log entries in dmesg=20
(almost) everytime we get a reconnect.

A different approach, could be to change _cifsFileInfo_put() to use a down_=
write_trylock()-sleep() loop instead of a blocking down_write() call.=20

I.e. something like this ?
(and then the same at the other places where we have a deadlock vulnerable =
down_write() call)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 936e03892e2a..530af080dc61 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -464,7 +464,8 @@ void _cifsFileInfo_put(struct cifsFileInfo *cifs_file, =
bool wait_oplock_handler)
         * Delete any outstanding lock records. We'll lose them when the fi=
le
         * is closed anyway.
         */
-       down_write(&cifsi->lock_sem);
+       while (!down_write_trylock(&cifsi->lock_sem))
+               msleep(125);
        list_for_each_entry_safe(li, tmp, &cifs_file->llist->locks, llist) =
{
                list_del(&li->llist);
                cifs_del_lock_waiters(li);




>=20
> Signed-off-by: Dave Wysochanski <dwysocha@redhat.com>
> ---
>  fs/cifs/cifsfs.c   |  1 +
>  fs/cifs/cifsglob.h |  1 +
>  fs/cifs/file.c     | 24 +++++++++++++++++++-----
>  3 files changed, 21 insertions(+), 5 deletions(-)
>=20
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index c049c7b3aa87..10f614324e4e 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -1336,6 +1336,7 @@ static ssize_t cifs_copy_file_range(struct file
> *src_file, loff_t off,
> =20
>  =09inode_init_once(&cifsi->vfs_inode);
>  =09init_rwsem(&cifsi->lock_sem);
> +=09init_rwsem(&cifsi->io_inflight_sem);
>  }
> =20
>  static int __init
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index 50dfd9049370..40e8358dc1cc 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -1392,6 +1392,7 @@ struct cifsInodeInfo {
>  =09bool can_cache_brlcks;
>  =09struct list_head llist;=09/* locks helb by this inode */
>  =09struct rw_semaphore lock_sem;=09/* protect the fields above */
> +=09struct rw_semaphore io_inflight_sem; /* Used to avoid lock conflicts =
 */
>  =09/* BB add in lists for dirty pages i.e. write caching info for oplock=
 */
>  =09struct list_head openFileList;
>  =09spinlock_t=09open_file_lock;=09/* protects openFileList */
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 5ad15de2bb4f..417baa7f5dd3 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -621,7 +621,7 @@ int cifs_open(struct inode *inode, struct file *file)
>  =09struct cifs_tcon *tcon =3D tlink_tcon(cfile->tlink);
>  =09int rc =3D 0;
> =20
> -=09down_read_nested(&cinode->lock_sem, SINGLE_DEPTH_NESTING);
> +=09down_read(&cinode->lock_sem);
>  =09if (cinode->can_cache_brlcks) {
>  =09=09/* can cache locks - no need to relock */
>  =09=09up_read(&cinode->lock_sem);
> @@ -973,6 +973,7 @@ int cifs_closedir(struct inode *inode, struct file *f=
ile)
>  =09struct cifs_fid_locks *cur;
>  =09struct cifsInodeInfo *cinode =3D CIFS_I(d_inode(cfile->dentry));
> =20
> +=09down_read(&cinode->lock_sem);
>  =09list_for_each_entry(cur, &cinode->llist, llist) {
>  =09=09rc =3D cifs_find_fid_lock_conflict(cur, offset, length, type,
>  =09=09=09=09=09=09 flags, cfile, conf_lock,
> @@ -980,6 +981,7 @@ int cifs_closedir(struct inode *inode, struct file *f=
ile)
>  =09=09if (rc)
>  =09=09=09break;
>  =09}
> +=09up_read(&cinode->lock_sem);
> =20
>  =09return rc;
>  }
> @@ -1027,9 +1029,11 @@ int cifs_closedir(struct inode *inode, struct file
> *file)
>  cifs_lock_add(struct cifsFileInfo *cfile, struct cifsLockInfo *lock)
>  {
>  =09struct cifsInodeInfo *cinode =3D CIFS_I(d_inode(cfile->dentry));
> +=09down_write(&cinode->io_inflight_sem);
>  =09down_write(&cinode->lock_sem);
>  =09list_add_tail(&lock->llist, &cfile->llist->locks);
>  =09up_write(&cinode->lock_sem);
> +=09up_write(&cinode->io_inflight_sem);
>  }
> =20
>  /*
> @@ -1049,6 +1053,7 @@ int cifs_closedir(struct inode *inode, struct file
> *file)
> =20
>  try_again:
>  =09exist =3D false;
> +=09down_write(&cinode->io_inflight_sem);
>  =09down_write(&cinode->lock_sem);
> =20
>  =09exist =3D cifs_find_lock_conflict(cfile, lock->offset, lock->length,
> @@ -1057,6 +1062,7 @@ int cifs_closedir(struct inode *inode, struct file
> *file)
>  =09if (!exist && cinode->can_cache_brlcks) {
>  =09=09list_add_tail(&lock->llist, &cfile->llist->locks);
>  =09=09up_write(&cinode->lock_sem);
> +=09=09up_write(&cinode->io_inflight_sem);
>  =09=09return rc;
>  =09}
> =20
> @@ -1077,6 +1083,7 @@ int cifs_closedir(struct inode *inode, struct file
> *file)
>  =09}
> =20
>  =09up_write(&cinode->lock_sem);
> +=09up_write(&cinode->io_inflight_sem);
>  =09return rc;
>  }
> =20
> @@ -1125,14 +1132,17 @@ int cifs_closedir(struct inode *inode, struct fil=
e
> *file)
>  =09=09return rc;
> =20
>  try_again:
> +=09down_write(&cinode->io_inflight_sem);
>  =09down_write(&cinode->lock_sem);
>  =09if (!cinode->can_cache_brlcks) {
>  =09=09up_write(&cinode->lock_sem);
> +=09=09down_write(&cinode->io_inflight_sem);
>  =09=09return rc;
>  =09}
> =20
>  =09rc =3D posix_lock_file(file, flock, NULL);
>  =09up_write(&cinode->lock_sem);
> +=09up_write(&cinode->io_inflight_sem);
>  =09if (rc =3D=3D FILE_LOCK_DEFERRED) {
>  =09=09rc =3D wait_event_interruptible(flock->fl_wait, !flock->fl_blocker=
);
>  =09=09if (!rc)
> @@ -1331,6 +1341,7 @@ struct lock_to_push {
>  =09int rc =3D 0;
> =20
>  =09/* we are going to update can_cache_brlcks here - need a write access=
 */
> +=09down_write(&cinode->io_inflight_sem);
>  =09down_write(&cinode->lock_sem);
>  =09if (!cinode->can_cache_brlcks) {
>  =09=09up_write(&cinode->lock_sem);
> @@ -1346,6 +1357,7 @@ struct lock_to_push {
> =20
>  =09cinode->can_cache_brlcks =3D false;
>  =09up_write(&cinode->lock_sem);
> +=09up_write(&cinode->io_inflight_sem);
>  =09return rc;
>  }
> =20
> @@ -1522,6 +1534,7 @@ struct lock_to_push {
>  =09if (!buf)
>  =09=09return -ENOMEM;
> =20
> +=09down_write(&cinode->io_inflight_sem);
>  =09down_write(&cinode->lock_sem);
>  =09for (i =3D 0; i < 2; i++) {
>  =09=09cur =3D buf;
> @@ -1593,6 +1606,7 @@ struct lock_to_push {
>  =09}
> =20
>  =09up_write(&cinode->lock_sem);
> +=09up_write(&cinode->io_inflight_sem);
>  =09kfree(buf);
>  =09return rc;
>  }
> @@ -3148,7 +3162,7 @@ ssize_t cifs_user_writev(struct kiocb *iocb, struct
> iov_iter *from)
>  =09 * We need to hold the sem to be sure nobody modifies lock list
>  =09 * with a brlock that prevents writing.
>  =09 */
> -=09down_read(&cinode->lock_sem);
> +=09down_read(&cinode->io_inflight_sem);
> =20
>  =09rc =3D generic_write_checks(iocb, from);
>  =09if (rc <=3D 0)
> @@ -3161,7 +3175,7 @@ ssize_t cifs_user_writev(struct kiocb *iocb, struct
> iov_iter *from)
>  =09else
>  =09=09rc =3D -EACCES;
>  out:
> -=09up_read(&cinode->lock_sem);
> +=09up_read(&cinode->io_inflight_sem);
>  =09inode_unlock(inode);
> =20
>  =09if (rc > 0)
> @@ -3887,12 +3901,12 @@ ssize_t cifs_user_readv(struct kiocb *iocb, struc=
t
> iov_iter *to)
>  =09 * We need to hold the sem to be sure nobody modifies lock list
>  =09 * with a brlock that prevents reading.
>  =09 */
> -=09down_read(&cinode->lock_sem);
> +=09down_read(&cinode->io_inflight_sem);
>  =09if (!cifs_find_lock_conflict(cfile, iocb->ki_pos, iov_iter_count(to),
>  =09=09=09=09     tcon->ses->server->vals->shared_lock_type,
>  =09=09=09=09     0, NULL, CIFS_READ_OP))
>  =09=09rc =3D generic_file_read_iter(iocb, to);
> -=09up_read(&cinode->lock_sem);
> +=09up_read(&cinode->io_inflight_sem);
>  =09return rc;
>  }
> =20
> --
> 1.8.3.1
>=20
>=20

