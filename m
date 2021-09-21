Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7A09D412E9B
	for <lists+linux-cifs@lfdr.de>; Tue, 21 Sep 2021 08:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229827AbhIUG3D (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 21 Sep 2021 02:29:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229848AbhIUG3C (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 21 Sep 2021 02:29:02 -0400
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3758BC061574
        for <linux-cifs@vger.kernel.org>; Mon, 20 Sep 2021 23:27:34 -0700 (PDT)
Received: by mail-lf1-x131.google.com with SMTP id i25so77974364lfg.6
        for <linux-cifs@vger.kernel.org>; Mon, 20 Sep 2021 23:27:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=RTDg85Qc0HTU+iFbgIAhQHoYSQIMFTU/wtwFlzXsv2M=;
        b=Qs9D0R+4JrbGg7gcvyHhKQq4AfDZZJ+ksKUxxtFVoCuRrNewazxb3e8RrsHWWEHLKg
         7ZVS/imb6Y66igPUaPXz5WnUhYkUSK4x5QIDJuhQOUH1oC+lzPV3VzmO9aHSJyK2tmrW
         cjtZm12Y350sVgI3V37JDknrdxJU934lm6Xs+rDAJOhdy/Q313b6kfXnypV+1vDdZxqk
         0mf0GD679npq9jpJfd6DULg6Pi5l0tG4ddJhCpB5DJwFx6hUxOGPqIwRVmwiieW0EpBz
         vMbaBTolYrkcSmoaa5BrpiXF1uPXIf5v3QbUKS3mmraZvBcNPRZoAD185YAQNeoqFZfF
         Ml8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=RTDg85Qc0HTU+iFbgIAhQHoYSQIMFTU/wtwFlzXsv2M=;
        b=7H4kk+mQd+tpoL9pdvaoesjv/qlegGOsxakga4fY62BSLCOm/G2/qf2M5HjqwctPvk
         STCy9qtA4whnVUdWjA8whzeSzpr/NSViW7tgGD+VPYKydspN4zdFLIDPDh6C00VeL+9P
         LN4IaE/+5HWXoShm7d+W2FPxr9nPGt2L6/wXilToBxw/P2A6/iSfE+a2DCOT0KYuXuCI
         kCbKkieH5ehWw0YMre78JWrI5EtNZcQEJXuSV+JPpdJLz9Mcru4AX4rnWWCFQ7JqArGU
         xcT/LU5iyjQItbOrwvOKumdi3MIRUyMU+gvOovy54JwOclTLDNTyFpP7/bXLq9XKzQOn
         r9Mg==
X-Gm-Message-State: AOAM531YkcXxzCFCe8O1zEYNuSeZpjxtxPo0jove81fxFfAaOX+YvAWX
        2bAGs/HI4zkgS0nJkJDP8fMJcuO5kgYExp9jCWJWHkDyxQc=
X-Google-Smtp-Source: ABdhPJw22NW+eWtz2ZQXAqmBnJxaG90G7AMhkxaKKItTl2TujQSapKPpflitwNN961ZYh7w17j8fMdwVi1ZB9y1rRMc=
X-Received: by 2002:ac2:41c9:: with SMTP id d9mr21561841lfi.667.1632205652357;
 Mon, 20 Sep 2021 23:27:32 -0700 (PDT)
MIME-Version: 1.0
References: <20210921051933.626532-1-linkinjeon@kernel.org>
In-Reply-To: <20210921051933.626532-1-linkinjeon@kernel.org>
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 21 Sep 2021 01:27:21 -0500
Message-ID: <CAH2r5mvW8MjN46LmLexLqnkV6q1eL3YKGiaY8_whNR_b=VUn2Q@mail.gmail.com>
Subject: Re: [PATCH v3] ksmbd: remove follow symlinks support
To:     Namjae Jeon <linkinjeon@kernel.org>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        =?UTF-8?B?UmFscGggQsO2aG1l?= <slow@samba.org>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

regression tests in progress
http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/8/bui=
lds/72

against ksmbd with these six patches:

ksmbd: remove follow symlinks support
7a26fb55d40c ksmbd: add request buffer validation in smb2_set_info
927426347090 ksmbd: add validation in smb2_ioctl
88b78c62812d ksmbd: add buffer validation for SMB2_CREATE_CONTEXT
069d9345c759 ksmbd: add default data stream name in FILE_STREAM_INFORMATION
996782bfb465 ksmbd: log that server is experimental at module load

On Tue, Sep 21, 2021 at 12:19 AM Namjae Jeon <linkinjeon@kernel.org> wrote:
>
> Use  LOOKUP_NO_SYMLINKS flags for default lookup to prohibit the middle o=
f
> symlink component lookup and remove follow symlinks parameter support.
> We re-implement it as reparse point later.
>
> Test result:
> smbclient -Ulinkinjeon%1234 //172.30.1.42/share -c
> "get hacked/passwd passwd"
> NT_STATUS_OBJECT_NAME_NOT_FOUND opening remote file \hacked\passwd
>
> Cc: Ralph B=C3=B6hme <slow@samba.org>
> Cc: Steve French <smfrench@gmail.com>
> Acked-by: Ronnie Sahlberg <lsahlber@redhat.com>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  v2:
>   - reorganize path lookup in smb2_open to call only one
>     ksmbd_vfs_kern_path().
>  v3:
>   - combine "ksmbd: use LOOKUP_NO_SYMLINKS flags for default lookup"
>     patch into this patch.
>
>  fs/ksmbd/smb2pdu.c | 43 ++++++++++---------------------------------
>  fs/ksmbd/vfs.c     | 32 +++++++++-----------------------
>  2 files changed, 19 insertions(+), 56 deletions(-)
>
> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
> index 4399c399284b..baf7ce31d557 100644
> --- a/fs/ksmbd/smb2pdu.c
> +++ b/fs/ksmbd/smb2pdu.c
> @@ -2660,13 +2660,9 @@ int smb2_open(struct ksmbd_work *work)
>                 goto err_out1;
>         }
>
> -       if (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE) {
> -               /*
> -                * On delete request, instead of following up, need to
> -                * look the current entity
> -                */
> -               rc =3D ksmbd_vfs_kern_path(name, 0, &path, 1);
> -               if (!rc) {
> +       rc =3D ksmbd_vfs_kern_path(name, LOOKUP_NO_SYMLINKS, &path, 1);
> +       if (!rc) {
> +               if (req->CreateOptions & FILE_DELETE_ON_CLOSE_LE) {
>                         /*
>                          * If file exists with under flags, return access
>                          * denied error.
> @@ -2685,25 +2681,10 @@ int smb2_open(struct ksmbd_work *work)
>                                 path_put(&path);
>                                 goto err_out;
>                         }
> -               }
> -       } else {
> -               if (test_share_config_flag(work->tcon->share_conf,
> -                                          KSMBD_SHARE_FLAG_FOLLOW_SYMLIN=
KS)) {
> -                       /*
> -                        * Use LOOKUP_FOLLOW to follow the path of
> -                        * symlink in path buildup
> -                        */
> -                       rc =3D ksmbd_vfs_kern_path(name, LOOKUP_FOLLOW, &=
path, 1);
> -                       if (rc) { /* Case for broken link ?*/
> -                               rc =3D ksmbd_vfs_kern_path(name, 0, &path=
, 1);
> -                       }
> -               } else {
> -                       rc =3D ksmbd_vfs_kern_path(name, 0, &path, 1);
> -                       if (!rc && d_is_symlink(path.dentry)) {
> -                               rc =3D -EACCES;
> -                               path_put(&path);
> -                               goto err_out;
> -                       }
> +               } else if (d_is_symlink(path.dentry)) {
> +                       rc =3D -EACCES;
> +                       path_put(&path);
> +                       goto err_out;
>                 }
>         }
>
> @@ -4788,12 +4769,8 @@ static int smb2_get_info_filesystem(struct ksmbd_w=
ork *work,
>         struct path path;
>         int rc =3D 0, len;
>         int fs_infoclass_size =3D 0;
> -       int lookup_flags =3D 0;
> -
> -       if (test_share_config_flag(share, KSMBD_SHARE_FLAG_FOLLOW_SYMLINK=
S))
> -               lookup_flags =3D LOOKUP_FOLLOW;
>
> -       rc =3D ksmbd_vfs_kern_path(share->path, lookup_flags, &path, 0);
> +       rc =3D ksmbd_vfs_kern_path(share->path, LOOKUP_NO_SYMLINKS, &path=
, 0);
>         if (rc) {
>                 pr_err("cannot create vfs path\n");
>                 return -EIO;
> @@ -5370,7 +5347,7 @@ static int smb2_rename(struct ksmbd_work *work,
>         }
>
>         ksmbd_debug(SMB, "new name %s\n", new_name);
> -       rc =3D ksmbd_vfs_kern_path(new_name, 0, &path, 1);
> +       rc =3D ksmbd_vfs_kern_path(new_name, LOOKUP_NO_SYMLINKS, &path, 1=
);
>         if (rc)
>                 file_present =3D false;
>         else
> @@ -5448,7 +5425,7 @@ static int smb2_create_link(struct ksmbd_work *work=
,
>         }
>
>         ksmbd_debug(SMB, "target name is %s\n", target_name);
> -       rc =3D ksmbd_vfs_kern_path(link_name, 0, &path, 0);
> +       rc =3D ksmbd_vfs_kern_path(link_name, LOOKUP_NO_SYMLINKS, &path, =
0);
>         if (rc)
>                 file_present =3D false;
>         else
> diff --git a/fs/ksmbd/vfs.c b/fs/ksmbd/vfs.c
> index b047f2980d96..3733e4944c1d 100644
> --- a/fs/ksmbd/vfs.c
> +++ b/fs/ksmbd/vfs.c
> @@ -166,7 +166,7 @@ int ksmbd_vfs_create(struct ksmbd_work *work, const c=
har *name, umode_t mode)
>         struct dentry *dentry;
>         int err;
>
> -       dentry =3D kern_path_create(AT_FDCWD, name, &path, 0);
> +       dentry =3D kern_path_create(AT_FDCWD, name, &path, LOOKUP_NO_SYML=
INKS);
>         if (IS_ERR(dentry)) {
>                 err =3D PTR_ERR(dentry);
>                 if (err !=3D -ENOENT)
> @@ -203,7 +203,8 @@ int ksmbd_vfs_mkdir(struct ksmbd_work *work, const ch=
ar *name, umode_t mode)
>         struct dentry *dentry;
>         int err;
>
> -       dentry =3D kern_path_create(AT_FDCWD, name, &path, LOOKUP_DIRECTO=
RY);
> +       dentry =3D kern_path_create(AT_FDCWD, name, &path,
> +                                 LOOKUP_NO_SYMLINKS | LOOKUP_DIRECTORY);
>         if (IS_ERR(dentry)) {
>                 err =3D PTR_ERR(dentry);
>                 if (err !=3D -EEXIST)
> @@ -588,16 +589,11 @@ int ksmbd_vfs_remove_file(struct ksmbd_work *work, =
char *name)
>         struct path path;
>         struct dentry *parent;
>         int err;
> -       int flags =3D 0;
>
>         if (ksmbd_override_fsids(work))
>                 return -ENOMEM;
>
> -       if (test_share_config_flag(work->tcon->share_conf,
> -                                  KSMBD_SHARE_FLAG_FOLLOW_SYMLINKS))
> -               flags =3D LOOKUP_FOLLOW;
> -
> -       err =3D kern_path(name, flags, &path);
> +       err =3D kern_path(name, LOOKUP_NO_SYMLINKS, &path);
>         if (err) {
>                 ksmbd_debug(VFS, "can't get %s, err %d\n", name, err);
>                 ksmbd_revert_fsids(work);
> @@ -652,16 +648,11 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const c=
har *oldname,
>         struct path oldpath, newpath;
>         struct dentry *dentry;
>         int err;
> -       int flags =3D 0;
>
>         if (ksmbd_override_fsids(work))
>                 return -ENOMEM;
>
> -       if (test_share_config_flag(work->tcon->share_conf,
> -                                  KSMBD_SHARE_FLAG_FOLLOW_SYMLINKS))
> -               flags =3D LOOKUP_FOLLOW;
> -
> -       err =3D kern_path(oldname, flags, &oldpath);
> +       err =3D kern_path(oldname, LOOKUP_NO_SYMLINKS, &oldpath);
>         if (err) {
>                 pr_err("cannot get linux path for %s, err =3D %d\n",
>                        oldname, err);
> @@ -669,7 +660,7 @@ int ksmbd_vfs_link(struct ksmbd_work *work, const cha=
r *oldname,
>         }
>
>         dentry =3D kern_path_create(AT_FDCWD, newname, &newpath,
> -                                 flags | LOOKUP_REVAL);
> +                                 LOOKUP_NO_SYMLINKS | LOOKUP_REVAL);
>         if (IS_ERR(dentry)) {
>                 err =3D PTR_ERR(dentry);
>                 pr_err("path create err for %s, err %d\n", newname, err);
> @@ -788,7 +779,6 @@ int ksmbd_vfs_fp_rename(struct ksmbd_work *work, stru=
ct ksmbd_file *fp,
>         struct dentry *src_dent, *trap_dent, *src_child;
>         char *dst_name;
>         int err;
> -       int flags;
>
>         dst_name =3D extract_last_component(newname);
>         if (!dst_name)
> @@ -797,12 +787,8 @@ int ksmbd_vfs_fp_rename(struct ksmbd_work *work, str=
uct ksmbd_file *fp,
>         src_dent_parent =3D dget_parent(fp->filp->f_path.dentry);
>         src_dent =3D fp->filp->f_path.dentry;
>
> -       flags =3D LOOKUP_DIRECTORY;
> -       if (test_share_config_flag(work->tcon->share_conf,
> -                                  KSMBD_SHARE_FLAG_FOLLOW_SYMLINKS))
> -               flags |=3D LOOKUP_FOLLOW;
> -
> -       err =3D kern_path(newname, flags, &dst_path);
> +       err =3D kern_path(newname, LOOKUP_NO_SYMLINKS | LOOKUP_DIRECTORY,
> +                       &dst_path);
>         if (err) {
>                 ksmbd_debug(VFS, "Cannot get path for %s [%d]\n", newname=
, err);
>                 goto out;
> @@ -861,7 +847,7 @@ int ksmbd_vfs_truncate(struct ksmbd_work *work, const=
 char *name,
>         int err =3D 0;
>
>         if (name) {
> -               err =3D kern_path(name, 0, &path);
> +               err =3D kern_path(name, LOOKUP_NO_SYMLINKS, &path);
>                 if (err) {
>                         pr_err("cannot get linux path for %s, err %d\n",
>                                name, err);
> --
> 2.25.1
>


--=20
Thanks,

Steve
