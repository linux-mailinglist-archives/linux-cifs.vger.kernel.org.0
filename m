Return-Path: <linux-cifs+bounces-3069-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B5C6A9935B4
	for <lists+linux-cifs@lfdr.de>; Mon,  7 Oct 2024 20:09:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A391B1C2159E
	for <lists+linux-cifs@lfdr.de>; Mon,  7 Oct 2024 18:09:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06E6D1DD553;
	Mon,  7 Oct 2024 18:09:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JObIDwY6"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4205187342;
	Mon,  7 Oct 2024 18:09:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728324557; cv=none; b=A7AQ/0gSjQCOYl17oT7ujFeBXMPDOHPdEvLgvuqj8T+tGlcpzhk+/6SkFt2VUlTp6txdcEudVS4+pDpJI8BSrjeVTX3dGEZB2whEEDX97Q+y6ZHmarh8mfVeIfS38N9CCZ40Lbqv/XOAxvHWo+qc1fFHUvE18IVUUOFA6tmjU8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728324557; c=relaxed/simple;
	bh=db+ssrkK9jD0LtKr4HWxX+haF4ORXlP6HuJjYgqu4Sc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L3vQGQBUipBrw1GCP1xSKv88Ia6XwBZ6YGKKTM6lsKaAY4sww9kjyPn6F4q0W3S278gLlwp+01qE5CROlJ7R3BRqYrPJHML7U8gxATQDHPue0hj6yOBzUpFNfm7vGyU+i1btWm54sXPqqcX45VftMl0svW/ak8DEvhDU09J+Gbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JObIDwY6; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61F48C4CEC6;
	Mon,  7 Oct 2024 18:09:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728324557;
	bh=db+ssrkK9jD0LtKr4HWxX+haF4ORXlP6HuJjYgqu4Sc=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=JObIDwY6FDhLI8icvs/xHLWCUL6XpBvmYZ37TL9g7qlm92dx65JtEHzOwZp4mCZHj
	 ESjYC3MAIIsGm31vRyyQelyZOOBeiYeAbi26NSF+GO8nR+CDAQA7H++62D8ry09gEn
	 8l9RjtwpdJThb5ihv+poR6VqxkamQxhwAJmONyKMvxO7Ag03jL31azdwy3dJlUuIQi
	 7II6O7nQZ0IJCEz2L+7z2TEeydEHUZJeb0hja/GSM8bqR6hzzTLyKQnS2i6n4VXHEB
	 p+eL3mB/02X0Cc8rsQDIX6h+6X93KOTg7MfUEmTP44nU2sdGgTiGcGGGDRm6IT2Pm4
	 P5qiCiF6VbojA==
Received: by pali.im (Postfix)
	id 3B24B792; Mon,  7 Oct 2024 20:09:11 +0200 (CEST)
Date: Mon, 7 Oct 2024 20:09:11 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Steve French <smfrench@gmail.com>
Cc: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>,
	linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 6/6] cifs: Fix creating and resolving absolute
 NT-style symlinks
Message-ID: <20241007180911.ozkjnou2py27sob5@pali>
References: <20240929185053.10554-1-pali@kernel.org>
 <20241005140300.19416-1-pali@kernel.org>
 <20241005140300.19416-7-pali@kernel.org>
 <CAH2r5mtCCSY0eLARtzi4LZF3tCmPec7DSJ=h47h09fo--_D49g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAH2r5mtCCSY0eLARtzi4LZF3tCmPec7DSJ=h47h09fo--_D49g@mail.gmail.com>
User-Agent: NeoMutt/20180716

I have figured it out. There is a new member at the end of the struct
smb3_fs_context. I have resolved this rebase conflict and pushed update
of this change into my cifs branch (based on 6.12-rc2) at:
https://git.kernel.org/pub/scm/linux/kernel/git/pali/linux.git/log/?h=cifs
Beware that this branch contains also some other WIP patches which I
have not sent yet.

If needed I can resend just this one rebased patch to the list.

On Sunday 06 October 2024 22:59:18 Steve French wrote:
> This patch had a merge conflict in fs_context.h and wouldn't apply
> cleanly.   Do you have a git branch with this series (or all three
> recent patch series) applied on 6.12-rc2?
> 
> On Sat, Oct 5, 2024 at 9:04 AM Pali Rohár <pali@kernel.org> wrote:
> >
> > If the SMB symlink is stored on NT server in absolute form then it points
> > to the NT object hierarchy, which is different from POSIX one and needs
> > some conversion / mapping.
> >
> > To make interoperability with Windows SMB server and WSL subsystem, reuse
> > its logic of mapping between NT paths and POSIX paths into Linux SMB
> > client.
> >
> > WSL subsystem on Windows uses for -t drvfs mount option -o symlinkroot=
> > which specifies the POSIX path where are expected to be mounted lowercase
> > Windows drive letters (without colon).
> >
> > Do same for Linux SMB client and add a new mount option -o symlinkroot=
> > which mimics the drvfs mount option of the same name. It specifies where in
> > the Linux VFS hierarchy is the root of the DOS / Windows drive letters, and
> > translates between absolute NT-style symlinks and absolute Linux VFS
> > symlinks. Default value of symlinkroot is "/mnt", same what is using WSL.
> >
> > Note that DOS / Windows drive letter symlinks are just subset of all
> > possible NT-style symlinks. Drive letters live in NT subtree \??\ and
> > important details about NT paths and object hierarchy are in the comments
> > in this change.
> >
> > When symlink target location from non-POSIX SMB server is in absolute form
> > (indicated by absence of SYMLINK_FLAG_RELATIVE) then it is converted to
> > Linux absolute symlink according to symlinkroot configuration.
> >
> > And when creating a new symlink on non-POSIX SMB server in absolute form
> > then Linux absolute target is converted to NT-style according to
> > symlinkroot configuration.
> >
> > When SMB server is POSIX, then this change does not affect neither reading
> > target location of symlink, nor creating a new symlink. It is expected that
> > POSIX SMB server works with POSIX paths where the absolute root is /.
> >
> > This change improves interoperability of absolute SMB symlinks with Windows
> > SMB servers.
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > ---
> >  fs/smb/client/fs_context.c |  22 +++
> >  fs/smb/client/fs_context.h |   2 +
> >  fs/smb/client/reparse.c    | 267 ++++++++++++++++++++++++++++++++++---
> >  3 files changed, 273 insertions(+), 18 deletions(-)
> >
> > diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
> > index 2f0c3894b0f7..22b550860cc8 100644
> > --- a/fs/smb/client/fs_context.c
> > +++ b/fs/smb/client/fs_context.c
> > @@ -178,6 +178,7 @@ const struct fs_parameter_spec smb3_fs_parameters[] = {
> >         fsparam_string("sec", Opt_sec),
> >         fsparam_string("cache", Opt_cache),
> >         fsparam_string("reparse", Opt_reparse),
> > +       fsparam_string("symlinkroot", Opt_symlinkroot),
> >
> >         /* Arguments that should be ignored */
> >         fsparam_flag("guest", Opt_ignore),
> > @@ -355,6 +356,7 @@ smb3_fs_context_dup(struct smb3_fs_context *new_ctx, struct smb3_fs_context *ctx
> >         new_ctx->source = NULL;
> >         new_ctx->iocharset = NULL;
> >         new_ctx->leaf_fullpath = NULL;
> > +       new_ctx->symlinkroot = NULL;
> >         /*
> >          * Make sure to stay in sync with smb3_cleanup_fs_context_contents()
> >          */
> > @@ -369,6 +371,7 @@ smb3_fs_context_dup(struct smb3_fs_context *new_ctx, struct smb3_fs_context *ctx
> >         DUP_CTX_STR(nodename);
> >         DUP_CTX_STR(iocharset);
> >         DUP_CTX_STR(leaf_fullpath);
> > +       DUP_CTX_STR(symlinkroot);
> >
> >         return 0;
> >  }
> > @@ -1614,9 +1617,26 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
> >                 if (parse_reparse_flavor(fc, param->string, ctx))
> >                         goto cifs_parse_mount_err;
> >                 break;
> > +       case Opt_symlinkroot:
> > +               if (param->string[0] != '/') {
> > +                       cifs_errorf(fc, "symlinkroot mount options must be absolute path\n");
> > +                       goto cifs_parse_mount_err;
> > +               }
> > +               kfree(ctx->symlinkroot);
> > +               ctx->symlinkroot = kstrdup(param->string, GFP_KERNEL);
> > +               if (!ctx->symlinkroot)
> > +                       goto cifs_parse_mount_err;
> > +               break;
> >         }
> >         /* case Opt_ignore: - is ignored as expected ... */
> >
> > +       /*
> > +        * By default resolve all native absolute symlinks relative to "/mnt/".
> > +        * Same default has drvfs driver running in WSL for resolving SMB shares.
> > +        */
> > +       if (!ctx->symlinkroot)
> > +               ctx->symlinkroot = kstrdup("/mnt/", GFP_KERNEL);
> > +
> >         return 0;
> >
> >   cifs_parse_mount_err:
> > @@ -1747,6 +1767,8 @@ smb3_cleanup_fs_context_contents(struct smb3_fs_context *ctx)
> >         ctx->prepath = NULL;
> >         kfree(ctx->leaf_fullpath);
> >         ctx->leaf_fullpath = NULL;
> > +       kfree(ctx->symlinkroot);
> > +       ctx->symlinkroot = NULL;
> >  }
> >
> >  void
> > diff --git a/fs/smb/client/fs_context.h b/fs/smb/client/fs_context.h
> > index cf577ec0dd0a..8dd12498ffd8 100644
> > --- a/fs/smb/client/fs_context.h
> > +++ b/fs/smb/client/fs_context.h
> > @@ -157,6 +157,7 @@ enum cifs_param {
> >         Opt_sec,
> >         Opt_cache,
> >         Opt_reparse,
> > +       Opt_symlinkroot,
> >
> >         /* Mount options to be ignored */
> >         Opt_ignore,
> > @@ -284,6 +285,7 @@ struct smb3_fs_context {
> >         struct cifs_ses *dfs_root_ses;
> >         bool dfs_automount:1; /* set for dfs automount only */
> >         enum cifs_reparse_type reparse_type;
> > +       char *symlinkroot; /* top level directory for native SMB symlinks in absolute format */
> >  };
> >
> >  extern const struct fs_parameter_spec smb3_fs_parameters[];
> > diff --git a/fs/smb/client/reparse.c b/fs/smb/client/reparse.c
> > index fb1d16b17f38..a577b2d2a4fc 100644
> > --- a/fs/smb/client/reparse.c
> > +++ b/fs/smb/client/reparse.c
> > @@ -25,33 +25,128 @@ int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
> >                                 const char *full_path, const char *symname)
> >  {
> >         struct reparse_symlink_data_buffer *buf = NULL;
> > -       struct cifs_open_info_data data;
> > +       struct cifs_open_info_data data = {};
> >         struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
> >         struct inode *new;
> >         struct kvec iov;
> > -       __le16 *path;
> > +       __le16 *path = NULL;
> >         bool directory;
> > -       char *sym, sep = CIFS_DIR_SEP(cifs_sb);
> > -       u16 len, plen;
> > +       char *symlink_target = NULL;
> > +       char *sym = NULL;
> > +       char sep = CIFS_DIR_SEP(cifs_sb);
> > +       u16 len, plen, poff, slen;
> >         int rc = 0;
> >
> > -       sym = kstrdup(symname, GFP_KERNEL);
> > -       if (!sym)
> > -               return -ENOMEM;
> > +       symlink_target = kstrdup(symname, GFP_KERNEL);
> > +       if (!symlink_target) {
> > +               rc = -ENOMEM;
> > +               goto out;
> > +       }
> >
> >         data = (struct cifs_open_info_data) {
> >                 .reparse_point = true,
> >                 .reparse = { .tag = IO_REPARSE_TAG_SYMLINK, },
> > -               .symlink_target = sym,
> > +               .symlink_target = symlink_target,
> >         };
> >
> > -       convert_delimiter(sym, sep);
> > +       if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_POSIX_PATHS) && symname[0] == '/') {
> > +               /*
> > +                * This is a request to create an absolute symlink on the server
> > +                * which does not support POSIX paths, and expects symlink in
> > +                * NT-style path. So convert absolute Linux symlink target path
> > +                * to the absolute NT-style path. Root of the NT-style path for
> > +                * symlinks is specified in "symlinkroot" mount option. This will
> > +                * ensure compatibility of this symlink stored in absolute form
> > +                * on the SMB server.
> > +                */
> > +               if (!strstarts(symname, cifs_sb->ctx->symlinkroot)) {
> > +                       /*
> > +                        * If the absolute Linux symlink target path is not
> > +                        * inside "symlinkroot" location then there is no way
> > +                        * to convert such Linux symlink to NT-style path.
> > +                        */
> > +                       cifs_dbg(VFS,
> > +                                "absolute symlink '%s' cannot be converted to NT format "
> > +                                "because it is outside of symlinkroot='%s'\n",
> > +                                symname, cifs_sb->ctx->symlinkroot);
> > +                       rc = -EINVAL;
> > +                       goto out;
> > +               }
> > +               len = strlen(cifs_sb->ctx->symlinkroot);
> > +               if (cifs_sb->ctx->symlinkroot[len-1] != '/')
> > +                       len++;
> > +               if (symname[len] >= 'a' && symname[len] <= 'z' &&
> > +                   (symname[len+1] == '/' || symname[len+1] == '\0')) {
> > +                       /*
> > +                        * Symlink points to Linux target /symlinkroot/x/path/...
> > +                        * where 'x' is the lowercase local Windows drive.
> > +                        * NT-style path for 'x' has common form \??\X:\path\...
> > +                        * with uppercase local Windows drive.
> > +                        */
> > +                       int common_path_len = strlen(symname+len+1)+1;
> > +                       sym = kzalloc(6+common_path_len, GFP_KERNEL);
> > +                       if (!sym) {
> > +                               rc = -ENOMEM;
> > +                               goto out;
> > +                       }
> > +                       memcpy(sym, "\\??\\", 4);
> > +                       sym[4] = symname[len] - ('a'-'A');
> > +                       sym[5] = ':';
> > +                       memcpy(sym+6, symname+len+1, common_path_len);
> > +               } else {
> > +                       /* Unhandled absolute symlink. Report an error. */
> > +                       cifs_dbg(
> > +                                VFS,
> > +                                "absolute symlink '%s' cannot be converted to NT format "
> > +                                "because it points to unknown target\n",
> > +                                symname);
> > +                       rc = -EINVAL;
> > +                       goto out;
> > +               }
> > +       } else {
> > +               /*
> > +                * This is request to either create an absolute symlink on
> > +                * server which expects POSIX paths or it is an request to
> > +                * create a relative symlink from the current directory.
> > +                * These paths have same format as relative SMB symlinks,
> > +                * so no conversion is needed. So just take symname as-is.
> > +                */
> > +               sym = kstrdup(symname, GFP_KERNEL);
> > +               if (!sym) {
> > +                       rc = -ENOMEM;
> > +                       goto out;
> > +               }
> > +       }
> > +
> > +       if (sep == '\\')
> > +               convert_delimiter(sym, sep);
> > +
> > +       /*
> > +        * For absolute NT symlinks it is required to pass also leading
> > +        * backslash and to not mangle NT object prefix "\\??\\" and not to
> > +        * mangle colon in drive letter. But cifs_convert_path_to_utf16()
> > +        * removes leading backslash and replaces '?' and ':'. So temporary
> > +        * mask these characters in NT object prefix by '_' and then change
> > +        * them back.
> > +        */
> > +       if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_POSIX_PATHS) && symname[0] == '/')
> > +               sym[0] = sym[1] = sym[2] = sym[5] = '_';
> > +
> >         path = cifs_convert_path_to_utf16(sym, cifs_sb);
> >         if (!path) {
> >                 rc = -ENOMEM;
> >                 goto out;
> >         }
> >
> > +       if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_POSIX_PATHS) && symname[0] == '/') {
> > +               sym[0] = '\\';
> > +               sym[1] = sym[2] = '?';
> > +               sym[5] = ':';
> > +               path[0] = '\\';
> > +               path[1] = path[2] = '?';
> > +               path[5] = ':';
> > +       }
> > +
> >         /*
> >          * SMB distinguish between symlink to directory and symlink to file.
> >          * They cannot be exchanged (symlink of file type which points to
> > @@ -64,8 +159,18 @@ int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
> >         if (rc < 0)
> >                 goto out;
> >
> > -       plen = 2 * UniStrnlen((wchar_t *)path, PATH_MAX);
> > -       len = sizeof(*buf) + plen * 2;
> > +       slen = 2 * UniStrnlen((wchar_t *)path, PATH_MAX);
> > +       poff = 0;
> > +       plen = slen;
> > +       if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_POSIX_PATHS) && symname[0] == '/') {
> > +               /*
> > +                * For absolute NT symlinks skip leading "\\??\\" in PrintName as
> > +                * PrintName is user visible location in DOS/Win32 format (not in NT format).
> > +                */
> > +               poff = 4;
> > +               plen -= 2 * poff;
> > +       }
> > +       len = sizeof(*buf) + plen + slen;
> >         buf = kzalloc(len, GFP_KERNEL);
> >         if (!buf) {
> >                 rc = -ENOMEM;
> > @@ -74,17 +179,17 @@ int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
> >
> >         buf->ReparseTag = cpu_to_le32(IO_REPARSE_TAG_SYMLINK);
> >         buf->ReparseDataLength = cpu_to_le16(len - sizeof(struct reparse_data_buffer));
> > +
> >         buf->SubstituteNameOffset = cpu_to_le16(plen);
> > -       buf->SubstituteNameLength = cpu_to_le16(plen);
> > -       memcpy(&buf->PathBuffer[plen], path, plen);
> > +       buf->SubstituteNameLength = cpu_to_le16(slen);
> > +       memcpy(&buf->PathBuffer[plen], path, slen);
> > +
> >         buf->PrintNameOffset = 0;
> >         buf->PrintNameLength = cpu_to_le16(plen);
> > -       memcpy(buf->PathBuffer, path, plen);
> > +       memcpy(buf->PathBuffer, path+poff, plen);
> > +
> >         buf->Flags = cpu_to_le32(*symname != '/' ? SYMLINK_FLAG_RELATIVE : 0);
> > -       if (*sym != sep)
> > -               buf->Flags = cpu_to_le32(SYMLINK_FLAG_RELATIVE);
> >
> > -       convert_delimiter(sym, '/');
> >         iov.iov_base = buf;
> >         iov.iov_len = len;
> >         new = smb2_get_reparse_inode(&data, inode->i_sb, xid,
> > @@ -95,6 +200,7 @@ int smb2_create_reparse_symlink(const unsigned int xid, struct inode *inode,
> >         else
> >                 rc = PTR_ERR(new);
> >  out:
> > +       kfree(sym);
> >         kfree(path);
> >         cifs_free_open_info(&data);
> >         kfree(buf);
> > @@ -540,6 +646,9 @@ int smb2_parse_native_symlink(char **target, const char *buf, unsigned int len,
> >         char sep = CIFS_DIR_SEP(cifs_sb);
> >         char *linux_target = NULL;
> >         char *smb_target = NULL;
> > +       int symlinkroot_len;
> > +       int abs_path_len;
> > +       char *abs_path;
> >         int levels;
> >         int rc;
> >         int i;
> > @@ -569,7 +678,123 @@ int smb2_parse_native_symlink(char **target, const char *buf, unsigned int len,
> >                 goto out;
> >         }
> >
> > -       if (smb_target[0] == sep && relative) {
> > +       if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_POSIX_PATHS) && !relative) {
> > +               /*
> > +                * This is an absolute symlink from the server which does not
> > +                * support POSIX paths, so the symlink is in NT-style path.
> > +                * So convert it to absolute Linux symlink target path. Root of
> > +                * the NT-style path for symlinks is specified in "symlinkroot"
> > +                * mount option.
> > +                *
> > +                * Root of the DOS and Win32 paths is at NT path \??\
> > +                * It means that DOS/Win32 path C:\folder\file.txt is
> > +                * NT path \??\C:\folder\file.txt
> > +                *
> > +                * NT systems have some well-known object symlinks in their NT
> > +                * hierarchy, which is needed to take into account when resolving
> > +                * other symlinks. Most commonly used symlink paths are:
> > +                * \?? -> \GLOBAL??
> > +                * \DosDevices -> \??
> > +                * \GLOBAL??\GLOBALROOT -> \
> > +                * \GLOBAL??\Global -> \GLOBAL??
> > +                * \GLOBAL??\NUL -> \Device\Null
> > +                * \GLOBAL??\UNC -> \Device\Mup
> > +                * \GLOBAL??\PhysicalDrive0 -> \Device\Harddisk0\DR0 (for each harddisk)
> > +                * \GLOBAL??\A: -> \Device\Floppy0 (if A: is the first floppy)
> > +                * \GLOBAL??\C: -> \Device\HarddiskVolume1 (if C: is the first harddisk)
> > +                * \GLOBAL??\D: -> \Device\CdRom0 (if D: is first cdrom)
> > +                * \SystemRoot -> \Device\Harddisk0\Partition1\WINDOWS (or where is NT system installed)
> > +                * \Volume{...} -> \Device\HarddiskVolume1 (where ... is system generated guid)
> > +                *
> > +                * In most common cases, absolute NT symlinks points to path on
> > +                * DOS/Win32 drive letter, system-specific Volume or on UNC share.
> > +                * Here are few examples of commonly used absolute NT symlinks
> > +                * created by mklink.exe tool:
> > +                * \??\C:\folder\file.txt
> > +                * \??\\C:\folder\file.txt
> > +                * \??\UNC\server\share\file.txt
> > +                * \??\\UNC\server\share\file.txt
> > +                * \??\Volume{b75e2c83-0000-0000-0000-602f00000000}\folder\file.txt
> > +                *
> > +                * It means that the most common path prefix \??\ is also NT path
> > +                * symlink (to \GLOBAL??). It is less common that second path
> > +                * separator is double backslash, but it is valid.
> > +                *
> > +                * Volume guid is randomly generated by the target system and so
> > +                * only the target system knows the mapping between guid and the
> > +                * hardisk number. Over SMB it is not possible to resolve this
> > +                * mapping, therefore symlinks pointing to target location of
> > +                * volume guids are totally unusable over SMB.
> > +                *
> > +                * For now parse only symlink paths available for DOS and Win32.
> > +                * Those are paths with \??\ prefix or paths which points to \??\
> > +                * via other NT symlink (\DosDevices\, \GLOBAL??\, ...).
> > +                */
> > +               abs_path = smb_target;
> > +globalroot:
> > +               if (strstarts(abs_path, "\\??\\"))
> > +                       abs_path += sizeof("\\??\\")-1;
> > +               else if (strstarts(abs_path, "\\DosDevices\\"))
> > +                       abs_path += sizeof("\\DosDevices\\")-1;
> > +               else if (strstarts(abs_path, "\\GLOBAL??\\"))
> > +                       abs_path += sizeof("\\GLOBAL??\\")-1;
> > +               else {
> > +                       /* Unhandled absolute symlink, points outside of DOS/Win32 */
> > +                       cifs_dbg(VFS,
> > +                                "absolute symlink '%s' cannot be converted from NT format "
> > +                                "because points to unknown target\n",
> > +                                smb_target);
> > +                       rc = -EIO;
> > +                       goto out;
> > +               }
> > +
> > +               /* Sometimes path separator after \?? is double backslash */
> > +               if (abs_path[0] == '\\')
> > +                       abs_path++;
> > +
> > +               while (strstarts(abs_path, "Global\\"))
> > +                       abs_path += sizeof("Global\\")-1;
> > +
> > +               if (strstarts(abs_path, "GLOBALROOT\\")) {
> > +                       /* Label globalroot requires path with leading '\\', so do not trim '\\' */
> > +                       abs_path += sizeof("GLOBALROOT")-1;
> > +                       goto globalroot;
> > +               }
> > +
> > +               /* For now parse only paths to drive letters */
> > +               if (((abs_path[0] >= 'A' && abs_path[0] <= 'Z') ||
> > +                    (abs_path[0] >= 'a' && abs_path[0] <= 'z')) &&
> > +                   abs_path[1] == ':' &&
> > +                   (abs_path[2] == '\\' || abs_path[2] == '\0')) {
> > +                       /* Convert drive letter to lowercase and drop colon */
> > +                       char drive_letter = abs_path[0];
> > +                       if (drive_letter >= 'A' && drive_letter <= 'Z')
> > +                               drive_letter += 'a'-'A';
> > +                       abs_path++;
> > +                       abs_path[0] = drive_letter;
> > +               } else {
> > +                       /* Unhandled absolute symlink. Report an error. */
> > +                       cifs_dbg(VFS,
> > +                                "absolute symlink '%s' cannot be converted from NT format "
> > +                                "because points to unknown target\n",
> > +                                smb_target);
> > +                       rc = -EIO;
> > +                       goto out;
> > +               }
> > +
> > +               abs_path_len = strlen(abs_path)+1;
> > +               symlinkroot_len = strlen(cifs_sb->ctx->symlinkroot);
> > +               if (cifs_sb->ctx->symlinkroot[symlinkroot_len-1] == '/')
> > +                       symlinkroot_len--;
> > +               linux_target = kmalloc(symlinkroot_len + 1 + abs_path_len, GFP_KERNEL);
> > +               if (!linux_target) {
> > +                       rc = -ENOMEM;
> > +                       goto out;
> > +               }
> > +               memcpy(linux_target, cifs_sb->ctx->symlinkroot, symlinkroot_len);
> > +               linux_target[symlinkroot_len] = '/';
> > +               memcpy(linux_target + symlinkroot_len + 1, abs_path, abs_path_len);
> > +       } else if (smb_target[0] == sep && relative) {
> >                 /*
> >                  * This is a relative SMB symlink from the top of the share,
> >                  * which is the top level directory of the Linux mount point.
> > @@ -598,6 +823,12 @@ int smb2_parse_native_symlink(char **target, const char *buf, unsigned int len,
> >                 }
> >                 memcpy(linux_target + levels*3, smb_target+1, smb_target_len); /* +1 to skip leading sep */
> >         } else {
> > +               /*
> > +                * This is either an absolute symlink in POSIX-style format
> > +                * or relative SMB symlink from the current directory.
> > +                * These paths have same format as Linux symlinks, so no
> > +                * conversion is needed.
> > +                */
> >                 linux_target = smb_target;
> >                 smb_target = NULL;
> >         }
> > --
> > 2.20.1
> >
> >
> 
> 
> -- 
> Thanks,
> 
> Steve

