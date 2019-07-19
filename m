Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 226A16EBCA
	for <lists+linux-cifs@lfdr.de>; Fri, 19 Jul 2019 22:56:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731849AbfGSU4p (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 19 Jul 2019 16:56:45 -0400
Received: from fieldses.org ([173.255.197.46]:58628 "EHLO fieldses.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbfGSU4p (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 19 Jul 2019 16:56:45 -0400
Received: by fieldses.org (Postfix, from userid 2815)
        id A1C782011; Fri, 19 Jul 2019 16:56:44 -0400 (EDT)
Date:   Fri, 19 Jul 2019 16:56:44 -0400
To:     Steve French <smfrench@gmail.com>
Cc:     linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH][CIFS] Add flock support
Message-ID: <20190719205644.GA24085@fieldses.org>
References: <CAH2r5mtXjyUP6_h86o5GmKxZ2syubbnc2-L95ctf96=TvBnbyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5mtXjyUP6_h86o5GmKxZ2syubbnc2-L95ctf96=TvBnbyA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
From:   bfields@fieldses.org (J. Bruce Fields)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Tue, Jul 16, 2019 at 07:02:48PM -0500, Steve French wrote:
> The attached patch adds support for flock support similar to AFS, NFS etc.
> 
> Although the patch did seem to work in my experiments with flock, I did notice
> that xfstest generic/504 fails because /proc/locks is not updated by cifs.ko
> after a successful lock.  Any idea which helper function does that?

You have to call into locks.c code, I'm not sure of the details off the
top of my head but you could probably look at the nfs lock code for an
example.

Could you also send in an update to the flock(2) man page?  (See the
"NFS details" section under NOTES.  Sounds like it could use a mention
of AFS as well.)

--b.

> From 9de8e68a8ab0c7e59080874f05b1df37477cf691 Mon Sep 17 00:00:00 2001
> From: Steve French <stfrench@microsoft.com>
> Date: Tue, 16 Jul 2019 18:55:38 -0500
> Subject: [PATCH] cifs: add support for flock
> 
> The flock system call locks the whole file rather than a byte
> range and is currently emulated by various other file systems
> by simply sending a byte range lock for the whole file.
> 
> This version of the patch needs a minor update to pass
> xfstest generic/504 (we need to figure out how to update
> /proc/locks after an flock call is granted)
> 
> Signed-off-by: Steve French <stfrench@microsoft.com>
> ---
>  fs/cifs/cifsfs.c |  3 +++
>  fs/cifs/cifsfs.h |  1 +
>  fs/cifs/file.c   | 54 ++++++++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 58 insertions(+)
> 
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index 320c7a6fd318..a674f52b0403 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -1168,6 +1168,7 @@ const struct file_operations cifs_file_ops = {
>  	.open = cifs_open,
>  	.release = cifs_close,
>  	.lock = cifs_lock,
> +	.flock = cifs_flock,
>  	.fsync = cifs_fsync,
>  	.flush = cifs_flush,
>  	.mmap  = cifs_file_mmap,
> @@ -1187,6 +1188,7 @@ const struct file_operations cifs_file_strict_ops = {
>  	.open = cifs_open,
>  	.release = cifs_close,
>  	.lock = cifs_lock,
> +	.flock = cifs_flock,
>  	.fsync = cifs_strict_fsync,
>  	.flush = cifs_flush,
>  	.mmap = cifs_file_strict_mmap,
> @@ -1206,6 +1208,7 @@ const struct file_operations cifs_file_direct_ops = {
>  	.open = cifs_open,
>  	.release = cifs_close,
>  	.lock = cifs_lock,
> +	.flock = cifs_flock,
>  	.fsync = cifs_fsync,
>  	.flush = cifs_flush,
>  	.mmap = cifs_file_mmap,
> diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
> index aea005703785..262f709822ee 100644
> --- a/fs/cifs/cifsfs.h
> +++ b/fs/cifs/cifsfs.h
> @@ -108,6 +108,7 @@ extern ssize_t cifs_strict_readv(struct kiocb *iocb, struct iov_iter *to);
>  extern ssize_t cifs_user_writev(struct kiocb *iocb, struct iov_iter *from);
>  extern ssize_t cifs_direct_writev(struct kiocb *iocb, struct iov_iter *from);
>  extern ssize_t cifs_strict_writev(struct kiocb *iocb, struct iov_iter *from);
> +extern int cifs_flock(struct file *file, int cmd, struct file_lock *fl);
>  extern int cifs_lock(struct file *, int, struct file_lock *);
>  extern int cifs_fsync(struct file *, loff_t, loff_t, int);
>  extern int cifs_strict_fsync(struct file *, loff_t, loff_t, int);
> diff --git a/fs/cifs/file.c b/fs/cifs/file.c
> index 97090693d182..641927755d0b 100644
> --- a/fs/cifs/file.c
> +++ b/fs/cifs/file.c
> @@ -1685,6 +1685,60 @@ cifs_setlk(struct file *file, struct file_lock *flock, __u32 type,
>  	return rc;
>  }
>  
> +int cifs_flock(struct file *file, int cmd, struct file_lock *fl)
> +{
> +	int rc, xid;
> +	int lock = 0, unlock = 0;
> +	bool wait_flag = false;
> +	bool posix_lck = false;
> +	struct cifs_sb_info *cifs_sb;
> +	struct cifs_tcon *tcon;
> +	struct cifsInodeInfo *cinode;
> +	struct cifsFileInfo *cfile;
> +	__u16 netfid;
> +	__u32 type;
> +
> +	rc = -EACCES;
> +	xid = get_xid();
> +
> +	if (!(fl->fl_flags & FL_FLOCK)) {
> +		cifs_dbg(VFS, "ret nolock\n");
> +		return -ENOLCK;
> +	}
> +
> +	cfile = (struct cifsFileInfo *)file->private_data;
> +	tcon = tlink_tcon(cfile->tlink);
> +
> +	cifs_read_flock(fl, &type, &lock, &unlock, &wait_flag,
> +			tcon->ses->server);
> +	cifs_sb = CIFS_FILE_SB(file);
> +	netfid = cfile->fid.netfid;
> +	cinode = CIFS_I(file_inode(file));
> +
> +	if (cap_unix(tcon->ses) &&
> +	    (CIFS_UNIX_FCNTL_CAP & le64_to_cpu(tcon->fsUnixInfo.Capability)) &&
> +	    ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NOPOSIXBRL) == 0))
> +		posix_lck = true;
> +
> +	if (!lock && !unlock) {
> +		/*
> +		 * if no lock or unlock then nothing to do since we do not
> +		 * know what it is
> +		 */
> +		cifs_dbg(VFS, "return FLOCK EOPNOTSUPP\n");
> +		free_xid(xid);
> +		return -EOPNOTSUPP;
> +	}
> +
> +	rc = cifs_setlk(file, fl, type, wait_flag, posix_lck, lock, unlock,
> +			xid);
> +	free_xid(xid);
> +	cifs_dbg(VFS, "FLOCK rc = %d\n", rc);
> +	return rc;
> +
> +
> +}
> +
>  int cifs_lock(struct file *file, int cmd, struct file_lock *flock)
>  {
>  	int rc, xid;
> -- 
> 2.20.1
> 

