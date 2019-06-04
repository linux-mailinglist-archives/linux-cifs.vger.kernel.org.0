Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A7C3C3513F
	for <lists+linux-cifs@lfdr.de>; Tue,  4 Jun 2019 22:42:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726595AbfFDUmi (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 4 Jun 2019 16:42:38 -0400
Received: from mail-vs1-f66.google.com ([209.85.217.66]:37007 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726535AbfFDUme (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 4 Jun 2019 16:42:34 -0400
Received: by mail-vs1-f66.google.com with SMTP id o5so14418468vsq.4;
        Tue, 04 Jun 2019 13:42:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fbtjRdv0GJ+2D+weFM4f6etIKOiIzXQVJtgOJZJ5iLg=;
        b=IZKM7gmxCS7o0Zw1kPZ9savketj1qxdMv6m2qkPsCnHmxaOhUgwjRROoPnc2GI6ssY
         wb8UoK+08uh93uFYsYPvwNWrmfQLHFH5ltkd3UrygfpzgmTUWUYE1P/a8LIHiiYa9XOE
         U2dEceQyyO6FSMbBUz4cvlVb/WT3l9gfaQP+MS27qwCD/jmN3iEQXuhN8eVsZTYR882T
         N8u5HtljyAZ+SZVqDwwM8gBQ8MY2yGf08zLT4v66ExoUQ/j9K4qFukoqvS7zIxDh2hi3
         HoTe63ghYikb6Ev3xir5GJjCBlVfMY6VS6ElHguZxax0qcAZNosKRNKcTCSIKE91a63L
         xPwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fbtjRdv0GJ+2D+weFM4f6etIKOiIzXQVJtgOJZJ5iLg=;
        b=Rt9TyW/ku9Pf6CdWkgu77XC7ug/rU+Fo/mFszqYJzD60p+tDptJTam/7KQdkiRrA4Z
         VCN9gyk38HcThnnup13AkHq9CGVbfGIUgPOM0CBpd/JF64xUgQWkx7jbQwVeACtIt1CL
         Ijs2XnDk+/AWLHawOcc5xQSRBzENyDaxnz3EeGcqkh19S6TXq+GTuA+MdMVXKZxeLe3G
         AyfTquiQTY5H4V7EFm2mqqGuH0sLT+eFkSHxlPMAOIxJvvMspd5hmyGi8P9fLbUNTjc8
         YyKVL7525hnkEDx3NlhU7aiT4ko5Lqn8522/JNxeNMn8a9hZM6vjseHoAwlgxzpouZK+
         8vkg==
X-Gm-Message-State: APjAAAWwNpRq/XwTpX+um4QWfYzReB+sBUCh6Q6pMbOpE/LcKSXS/Fpu
        5ajfUORfa/kuDoAPFKTq7IG+D4Xoduo8UbScZ74=
X-Google-Smtp-Source: APXvYqx4Z19++9NwRG53ORZiPgGjyDXMAlT0avIaCwBDxjULpGGDW+Ev7+Q+LkLPMq1cPypN2Q6W6eLqUqLVKynvx+8=
X-Received: by 2002:a05:6102:195:: with SMTP id r21mr3136390vsq.194.1559680952957;
 Tue, 04 Jun 2019 13:42:32 -0700 (PDT)
MIME-Version: 1.0
References: <20190604135632.1487-1-amir73il@gmail.com>
In-Reply-To: <20190604135632.1487-1-amir73il@gmail.com>
From:   Olga Kornievskaia <olga.kornievskaia@gmail.com>
Date:   Tue, 4 Jun 2019 16:42:21 -0400
Message-ID: <CAN-5tyFBd4mJ84C2J9dwG_iYeEDN0tX86DjW4oaV7yscj4VR7g@mail.gmail.com>
Subject: Re: [PATCH v5 8/9] vfs: allow copy_file_range to copy across devices
To:     Amir Goldstein <amir73il@gmail.com>
Cc:     "Darrick J . Wong" <darrick.wong@oracle.com>,
        Dave Chinner <david@fromorbit.com>,
        Christoph Hellwig <hch@lst.de>,
        linux-xfs <linux-xfs@vger.kernel.org>,
        Luis Henriques <lhenriques@suse.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        ceph-devel@vger.kernel.org, linux-nfs <linux-nfs@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>,
        Steve French <stfrench@microsoft.com>,
        Dave Chinner <dchinner@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Tue, Jun 4, 2019 at 9:56 AM Amir Goldstein <amir73il@gmail.com> wrote:
>
> We want to enable cross-filesystem copy_file_range functionality
> where possible, so push the "same superblock only" checks down to
> the individual filesystem callouts so they can make their own
> decisions about cross-superblock copy offload and fallack to
> generic_copy_file_range() for cross-superblock copy.
>
> [Amir] We do not call ->remap_file_range() in case the files are not
> on the same sb and do not call ->copy_file_range() in case the files
> do not belong to the same filesystem driver.
>
> This changes behavior of the copy_file_range(2) syscall, which will
> now allow cross filesystem in-kernel copy.  CIFS already supports
> cross-superblock copy, between two shares to the same server. This
> functionality will now be available via the copy_file_range(2) syscall.
>
> Cc: Steve French <stfrench@microsoft.com>
> Signed-off-by: Dave Chinner <dchinner@redhat.com>
> Signed-off-by: Amir Goldstein <amir73il@gmail.com>
> ---
>
> Darrick,
>
> Per feedback from Olga, I am sending a modified version of this patch
> to address cross file_system_type copy issue in nfs.
>

Thanks Amir, this works for NFS with referrals.

> For the sake of global warming I am not re-posting the entire patch set.
> I removed your RVB because of the change.
>
> Thanks,
> Amir.
>
> Changes since v4:
> - Check "same filesystem driver" by comapring ->copy_file_range()
>   function pointer
>
>  fs/ceph/file.c    |  4 +++-
>  fs/cifs/cifsfs.c  |  2 +-
>  fs/fuse/file.c    |  5 ++++-
>  fs/nfs/nfs4file.c |  5 ++++-
>  fs/read_write.c   | 18 ++++++++++++------
>  5 files changed, 24 insertions(+), 10 deletions(-)
>
> diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> index e87f7b2023af..4cd41ed5cc53 100644
> --- a/fs/ceph/file.c
> +++ b/fs/ceph/file.c
> @@ -1909,6 +1909,8 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
>
>         if (src_inode == dst_inode)
>                 return -EINVAL;
> +       if (src_inode->i_sb != dst_inode->i_sb)
> +               return -EXDEV;
>         if (ceph_snap(dst_inode) != CEPH_NOSNAP)
>                 return -EROFS;
>
> @@ -2109,7 +2111,7 @@ static ssize_t ceph_copy_file_range(struct file *src_file, loff_t src_off,
>         ret = __ceph_copy_file_range(src_file, src_off, dst_file, dst_off,
>                                      len, flags);
>
> -       if (ret == -EOPNOTSUPP)
> +       if (ret == -EOPNOTSUPP || ret == -EXDEV)
>                 ret = generic_copy_file_range(src_file, src_off, dst_file,
>                                               dst_off, len, flags);
>         return ret;
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index c65823270313..f11eea6125c1 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -1149,7 +1149,7 @@ static ssize_t cifs_copy_file_range(struct file *src_file, loff_t off,
>                                         len, flags);
>         free_xid(xid);
>
> -       if (rc == -EOPNOTSUPP)
> +       if (rc == -EOPNOTSUPP || rc == -EXDEV)
>                 rc = generic_copy_file_range(src_file, off, dst_file,
>                                              destoff, len, flags);
>         return rc;
> diff --git a/fs/fuse/file.c b/fs/fuse/file.c
> index e03901ae729b..569baf286835 100644
> --- a/fs/fuse/file.c
> +++ b/fs/fuse/file.c
> @@ -3126,6 +3126,9 @@ static ssize_t __fuse_copy_file_range(struct file *file_in, loff_t pos_in,
>         if (fc->no_copy_file_range)
>                 return -EOPNOTSUPP;
>
> +       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> +               return -EXDEV;
> +
>         inode_lock(inode_out);
>
>         if (fc->writeback_cache) {
> @@ -3182,7 +3185,7 @@ static ssize_t fuse_copy_file_range(struct file *src_file, loff_t src_off,
>         ret = __fuse_copy_file_range(src_file, src_off, dst_file, dst_off,
>                                      len, flags);
>
> -       if (ret == -EOPNOTSUPP)
> +       if (ret == -EOPNOTSUPP || ret == -EXDEV)
>                 ret = generic_copy_file_range(src_file, src_off, dst_file,
>                                               dst_off, len, flags);
>         return ret;
> diff --git a/fs/nfs/nfs4file.c b/fs/nfs/nfs4file.c
> index 4842f3ab3161..f4157eb1f69d 100644
> --- a/fs/nfs/nfs4file.c
> +++ b/fs/nfs/nfs4file.c
> @@ -133,6 +133,9 @@ static ssize_t __nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
>                                       struct file *file_out, loff_t pos_out,
>                                       size_t count, unsigned int flags)
>  {
> +       /* Only offload copy if superblock is the same */
> +       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> +               return -EXDEV;
>         if (!nfs_server_capable(file_inode(file_out), NFS_CAP_COPY))
>                 return -EOPNOTSUPP;
>         if (file_inode(file_in) == file_inode(file_out))
> @@ -148,7 +151,7 @@ static ssize_t nfs4_copy_file_range(struct file *file_in, loff_t pos_in,
>
>         ret = __nfs4_copy_file_range(file_in, pos_in, file_out, pos_out, count,
>                                      flags);
> -       if (ret == -EOPNOTSUPP)
> +       if (ret == -EOPNOTSUPP || ret == -EXDEV)
>                 ret = generic_copy_file_range(file_in, pos_in, file_out,
>                                               pos_out, count, flags);
>         return ret;
> diff --git a/fs/read_write.c b/fs/read_write.c
> index cec7e7b1f693..bb594c8f4404 100644
> --- a/fs/read_write.c
> +++ b/fs/read_write.c
> @@ -1599,7 +1599,16 @@ static ssize_t do_copy_file_range(struct file *file_in, loff_t pos_in,
>                                   struct file *file_out, loff_t pos_out,
>                                   size_t len, unsigned int flags)
>  {
> -       if (file_out->f_op->copy_file_range)
> +       /*
> +        * Although we now allow filesystems to handle cross sb copy, passing
> +        * a file of the wrong filesystem type to filesystem driver can result
> +        * in an attempt to dereference the wrong type of ->private_data, so
> +        * avoid doing that until we really have a good reason.
> +        * NFS has several different file_system_type's, but they all end up
> +        * using the same ->copy_file_range() function pointer.
> +        */
> +       if (file_out->f_op->copy_file_range &&
> +           file_out->f_op->copy_file_range == file_in->f_op->copy_file_range)
>                 return file_out->f_op->copy_file_range(file_in, pos_in,
>                                                        file_out, pos_out,
>                                                        len, flags);
> @@ -1622,10 +1631,6 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>         if (flags != 0)
>                 return -EINVAL;
>
> -       /* this could be relaxed once a method supports cross-fs copies */
> -       if (file_inode(file_in)->i_sb != file_inode(file_out)->i_sb)
> -               return -EXDEV;
> -
>         ret = generic_copy_file_checks(file_in, pos_in, file_out, pos_out, &len,
>                                        flags);
>         if (unlikely(ret))
> @@ -1648,7 +1653,8 @@ ssize_t vfs_copy_file_range(struct file *file_in, loff_t pos_in,
>          * Try cloning first, this is supported by more file systems, and
>          * more efficient if both clone and copy are supported (e.g. NFS).
>          */
> -       if (file_in->f_op->remap_file_range) {
> +       if (file_in->f_op->remap_file_range &&
> +           file_inode(file_in)->i_sb == file_inode(file_out)->i_sb) {
>                 loff_t cloned;
>
>                 cloned = file_in->f_op->remap_file_range(file_in, pos_in,
> --
> 2.17.1
>
