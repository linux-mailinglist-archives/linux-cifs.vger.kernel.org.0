Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 28609100D44
	for <lists+linux-cifs@lfdr.de>; Mon, 18 Nov 2019 21:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbfKRUrj (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 18 Nov 2019 15:47:39 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:34724 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbfKRUrj (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 18 Nov 2019 15:47:39 -0500
Received: by mail-il1-f196.google.com with SMTP id p6so17351711ilp.1
        for <linux-cifs@vger.kernel.org>; Mon, 18 Nov 2019 12:47:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=EZjrP3uhD58c7/rTnGEFgW66dKKOc3gstLNB5hi1yH0=;
        b=A9slVBcoe3vtyeeFWyq92sABKY+Ri+Z2TZTBETKZpVW+Ln3QhgXPRGvciMee/WxNAE
         +kAeB3BqFZqnDpy5A9uPHy0tAf51uLnkSBdbGQSFuXl1bsTByGb4w4ck63l5Hoy5NhS8
         80u/5rHLPscAohSfrkqj6QwAmLwuULGEyrJs6OysPcXv1dN8HhUlhHzRpcQTYw9ATz4t
         STumstEPKdCDwQelYFBSLFx1vwjVzWrQHqf5E0afKizbnSSb+hu/MHXYVQRHl3LpUN7j
         OXjHulDV/KiUt7f3tjqPkJGEQus8hp48A/d+GHRAeRtrK05FyUYY7CMqNcFfQQP7SqnM
         Hx3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EZjrP3uhD58c7/rTnGEFgW66dKKOc3gstLNB5hi1yH0=;
        b=eWGworQ/R3l1LjTLfJY9BNGLvSPVWl0R+qpBwnU/3H/IO1SHzdC0nk8hs4IV1vVqhj
         jxGW2TKGp42g7SXy4BggafXxiUmd6F4+3IUzaeNcRWUaohZZcQvKb5YiZ8GeYLeYss4I
         pZvU97mM2mBEyWkzcGVrJBq/+QNExII+mkflQqSht74H/V/HC4b0sZFRwF30yt77EPA9
         MFIC77Qby6cFBtq/osmaeVjuHnuooev/VAJVBfeIII3dPgYTPHlizCjwMZRQ4T608U50
         G5JA+rks75DeEtegN4wojepMkp8aeBxPJyr8FDg/ItZ1Obdv1tI30FRVZC88COcnVCCB
         zvDQ==
X-Gm-Message-State: APjAAAViYElt6EtQ7dfejWbueOE1Bwzc6rjeo108Bn7XOSVVPMfd2d+3
        ceW9D0o55F9OsUuVD+yVbQpbqey4RurkgfgWzGqMI7fgsGk=
X-Google-Smtp-Source: APXvYqw5PLHfTVcDXB35u7JHscfARSa4MR4HpEMliSwgt3dhLWPYKfdL/QEbWOVA0JP0LhHGZNzWgF57mfSC5/ohb+0=
X-Received: by 2002:a92:8b4e:: with SMTP id i75mr17194923ild.5.1574110057588;
 Mon, 18 Nov 2019 12:47:37 -0800 (PST)
MIME-Version: 1.0
References: <20191118200408.7863-1-aaptel@suse.com>
In-Reply-To: <20191118200408.7863-1-aaptel@suse.com>
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 18 Nov 2019 14:47:26 -0600
Message-ID: <CAH2r5mtV8DH+weP8SXTfV5XujJoObkm4DD=F-jsjAgSSNKfogQ@mail.gmail.com>
Subject: Re: [PATCH] CIFS: refactor cifs_get_inode_info()
To:     Aurelien Aptel <aaptel@suse.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Removed one extra newline (trivial change) and tentatively pushed to
for-next so I could run the buildbot with it:

http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/283

On Mon, Nov 18, 2019 at 2:04 PM Aurelien Aptel <aaptel@suse.com> wrote:
>
> Make logic of cifs_get_inode() much clearer by moving code to sub
> functions and adding comments.
>
> Document the steps this function does.
>
> cifs_get_inode_info() gets and updates a file inode metadata from its
> file path.
>
> * If caller already has raw info data from server they can pass it.
> * If inode already exists (just need to update) caller can pass it.
>
> Step 1: get raw data from server if none was passed
> Step 2: parse raw data into intermediate internal cifs_fattr struct
> Step 3: set fattr uniqueid which is later used for inode number. This
>         can sometime be done from raw data
> Step 4: tweak fattr according to mount options (file_mode, acl to mode
>         bits, uid, gid, etc)
> Step 5: update or create inode from final fattr struct
>
> * add is_smb1_server() helper
> * add is_inode_cache_good() helper
> * move SMB1-backupcreds-getinfo-retry to separate func
>   cifs_backup_query_path_info().
> * move set-uniqueid code to separate func cifs_set_fattr_ino()
> * don't clobber uniqueid from backup cred retry
> * fix some probable corner cases memleaks
>
> Signed-off-by: Aurelien Aptel <aaptel@suse.com>
> ---
>  fs/cifs/cifsglob.h |   6 +
>  fs/cifs/inode.c    | 338 +++++++++++++++++++++++++++++++----------------------
>  2 files changed, 206 insertions(+), 138 deletions(-)
>
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index 5bbd7d4ba58e..811448fc3781 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -1984,4 +1984,10 @@ extern struct smb_version_values smb302_values;
>  #define ALT_SMB311_VERSION_STRING "3.11"
>  extern struct smb_version_operations smb311_operations;
>  extern struct smb_version_values smb311_values;
> +
> +static inline bool is_smb1_server(struct TCP_Server_Info *server)
> +{
> +       return strcmp(server->vals->version_string, SMB1_VERSION_STRING) == 0;
> +}
> +
>  #endif /* _CIFS_GLOB_H */
> diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
> index df9377828e2f..1f6d174b3041 100644
> --- a/fs/cifs/inode.c
> +++ b/fs/cifs/inode.c
> @@ -297,7 +297,7 @@ cifs_unix_basic_to_fattr(struct cifs_fattr *fattr, FILE_UNIX_BASIC_INFO *info,
>                                 fattr->cf_uid = uid;
>                 }
>         }
> -
> +
>         fattr->cf_gid = cifs_sb->mnt_gid;
>         if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_OVERR_GID)) {
>                 u64 id = le64_to_cpu(info->Gid);
> @@ -727,22 +727,138 @@ static __u64 simple_hashstr(const char *str)
>         return hash;
>  }
>
> +/**
> + * cifs_backup_query_path_info - SMB1 fallback code to get ino
> + *
> + * Fallback code to get file metadata when we don't have access to
> + * @full_path (EACCESS) and have backup creds.
> + *
> + * @data will be set to search info result buffer
> + * @resp_buf will be set to cifs resp buf and needs to be freed with
> + * cifs_buf_release() when done with @data.
> + */
> +static int
> +cifs_backup_query_path_info(int xid,
> +                           struct cifs_tcon *tcon,
> +                           struct super_block *sb,
> +                           const char *full_path,
> +                           void **resp_buf,
> +                           FILE_ALL_INFO **data)
> +{
> +       struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
> +       struct cifs_search_info info = {0};
> +       u16 flags;
> +       int rc;
> +
> +       *resp_buf = NULL;
> +       info.endOfSearch = false;
> +       if (tcon->unix_ext)
> +               info.info_level = SMB_FIND_FILE_UNIX;
> +       else if ((tcon->ses->capabilities &
> +                 tcon->ses->server->vals->cap_nt_find) == 0)
> +               info.info_level = SMB_FIND_FILE_INFO_STANDARD;
> +       else if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM)
> +               info.info_level = SMB_FIND_FILE_ID_FULL_DIR_INFO;
> +       else /* no srvino useful for fallback to some netapp */
> +               info.info_level = SMB_FIND_FILE_DIRECTORY_INFO;
> +
> +       flags = CIFS_SEARCH_CLOSE_ALWAYS |
> +               CIFS_SEARCH_CLOSE_AT_END |
> +               CIFS_SEARCH_BACKUP_SEARCH;
> +
> +       rc = CIFSFindFirst(xid, tcon, full_path,
> +                          cifs_sb, NULL, flags, &info, false);
> +       if (rc)
> +               return rc;
> +
> +       *resp_buf = (void *)info.ntwrk_buf_start;
> +       *data = (FILE_ALL_INFO *)info.srch_entries_start;
> +       return 0;
> +}
> +
> +static void
> +cifs_set_fattr_ino(int xid,
> +                  struct cifs_tcon *tcon,
> +                  struct super_block *sb,
> +                  struct inode **inode,
> +                  const char *full_path,
> +                  FILE_ALL_INFO *data,
> +                  struct cifs_fattr *fattr)
> +{
> +       struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
> +       struct TCP_Server_Info *server = tcon->ses->server;
> +       int rc;
> +
> +       if (!(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM)) {
> +               if (*inode)
> +                       fattr->cf_uniqueid = CIFS_I(*inode)->uniqueid;
> +               else
> +                       fattr->cf_uniqueid = iunique(sb, ROOT_I);
> +               return;
> +       }
> +
> +       /*
> +        * If we have an inode pass a NULL tcon to ensure we don't
> +        * make a round trip to the server. This only works for SMB2+.
> +        */
> +       rc = server->ops->get_srv_inum(xid,
> +                                      *inode ? NULL : tcon,
> +                                      cifs_sb, full_path,
> +                                      &fattr->cf_uniqueid,
> +                                      data);
> +       if (rc) {
> +               /*
> +                * If that fails reuse existing ino or generate one
> +                * and disable server ones
> +                */
> +               if (*inode)
> +                       fattr->cf_uniqueid = CIFS_I(*inode)->uniqueid;
> +               else {
> +                       fattr->cf_uniqueid = iunique(sb, ROOT_I);
> +                       cifs_autodisable_serverino(cifs_sb);
> +               }
> +               return;
> +       }
> +
> +       /* If no errors, check for zero root inode (invalid) */
> +       if (fattr->cf_uniqueid == 0 && strlen(full_path) == 0) {
> +               cifs_dbg(FYI, "Invalid (0) inodenum\n");
> +               if (*inode) {
> +                       /* reuse */
> +                       fattr->cf_uniqueid = CIFS_I(*inode)->uniqueid;
> +               } else {
> +                       /* make an ino by hashing the UNC */
> +                       fattr->cf_flags |= CIFS_FATTR_FAKE_ROOT_INO;
> +                       fattr->cf_uniqueid = simple_hashstr(tcon->treeName);
> +               }
> +       }
> +}
> +
> +static inline bool is_inode_cache_good(struct inode *ino)
> +{
> +       return ino && CIFS_CACHE_READ(CIFS_I(ino)) && CIFS_I(ino)->time != 0;
> +}
> +
>  int
> -cifs_get_inode_info(struct inode **inode, const char *full_path,
> -                   FILE_ALL_INFO *data, struct super_block *sb, int xid,
> +cifs_get_inode_info(struct inode **inode,
> +                   const char *full_path,
> +                   FILE_ALL_INFO *in_data,
> +                   struct super_block *sb, int xid,
>                     const struct cifs_fid *fid)
>  {
> -       __u16 srchflgs;
> -       int rc = 0, tmprc = ENOSYS;
> +
>         struct cifs_tcon *tcon;
>         struct TCP_Server_Info *server;
>         struct tcon_link *tlink;
>         struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
> -       char *buf = NULL;
>         bool adjust_tz = false;
> -       struct cifs_fattr fattr;
> -       struct cifs_search_info *srchinf = NULL;
> +       struct cifs_fattr fattr = {0};
>         bool symlink = false;
> +       FILE_ALL_INFO *data = in_data;
> +       FILE_ALL_INFO *tmp_data = NULL;
> +       void *smb1_backup_rsp_buf = NULL;
> +       int rc = 0;
> +       int tmprc = 0;
>
>         tlink = cifs_sb_tlink(cifs_sb);
>         if (IS_ERR(tlink))
> @@ -750,142 +866,88 @@ cifs_get_inode_info(struct inode **inode, const char *full_path,
>         tcon = tlink_tcon(tlink);
>         server = tcon->ses->server;
>
> -       cifs_dbg(FYI, "Getting info on %s\n", full_path);
> +       /*
> +        * 1. Fetch file metadata if not provided (data)
> +        */
>
> -       if ((data == NULL) && (*inode != NULL)) {
> -               if (CIFS_CACHE_READ(CIFS_I(*inode)) &&
> -                   CIFS_I(*inode)->time != 0) {
> +       if (!data) {
> +               if (is_inode_cache_good(*inode)) {
>                         cifs_dbg(FYI, "No need to revalidate cached inode sizes\n");
> -                       goto cgii_exit;
> -               }
> -       }
> -
> -       /* if inode info is not passed, get it from server */
> -       if (data == NULL) {
> -               if (!server->ops->query_path_info) {
> -                       rc = -ENOSYS;
> -                       goto cgii_exit;
> +                       goto out;
>                 }
> -               buf = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
> -               if (buf == NULL) {
> +               tmp_data = kmalloc(sizeof(FILE_ALL_INFO), GFP_KERNEL);
> +               if (!tmp_data) {
>                         rc = -ENOMEM;
> -                       goto cgii_exit;
> +                       goto out;
>                 }
> -               data = (FILE_ALL_INFO *)buf;
> -               rc = server->ops->query_path_info(xid, tcon, cifs_sb, full_path,
> -                                                 data, &adjust_tz, &symlink);
> +               rc = server->ops->query_path_info(xid, tcon, cifs_sb,
> +                                                 full_path, tmp_data,
> +                                                 &adjust_tz, &symlink);
> +               data = tmp_data;
>         }
>
> -       if (!rc) {
> -               cifs_all_info_to_fattr(&fattr, data, sb, adjust_tz,
> -                                      symlink);
> -       } else if (rc == -EREMOTE) {
> +       /*
> +        * 2. Convert it to internal cifs metadata (fattr)
> +        */
> +
> +       switch (rc) {
> +       case 0:
> +               cifs_all_info_to_fattr(&fattr, data, sb, adjust_tz, symlink);
> +               break;
> +       case -EREMOTE:
> +               /* DFS link, no metadata available on this server */
>                 cifs_create_dfs_fattr(&fattr, sb);
>                 rc = 0;
> -       } else if ((rc == -EACCES) && backup_cred(cifs_sb) &&
> -                  (strcmp(server->vals->version_string, SMB1_VERSION_STRING)
> -                     == 0)) {
> +               break;
> +       case -EACCES:
>                 /*
> -                * For SMB2 and later the backup intent flag is already
> -                * sent if needed on open and there is no path based
> -                * FindFirst operation to use to retry with
> +                * perm errors, try again with backup flags if possible
> +                *
> +                * For SMB2 and later the backup intent flag
> +                * is already sent if needed on open and there
> +                * is no path based FindFirst operation to use
> +                * to retry with
>                  */
> +               if (backup_cred(cifs_sb) && is_smb1_server(server)) {
> +                       /* for easier reading */
> +                       FILE_DIRECTORY_INFO *fdi;
> +                       SEARCH_ID_FULL_DIR_INFO *si;
> +
> +                       rc = cifs_backup_query_path_info(xid, tcon, sb,
> +                                                        full_path,
> +                                                        &smb1_backup_rsp_buf,
> +                                                        &data);
> +                       if (rc)
> +                               goto out;
>
> -               srchinf = kzalloc(sizeof(struct cifs_search_info),
> -                                       GFP_KERNEL);
> -               if (srchinf == NULL) {
> -                       rc = -ENOMEM;
> -                       goto cgii_exit;
> -               }
> +                       fdi = (FILE_DIRECTORY_INFO *)data;
> +                       si = (SEARCH_ID_FULL_DIR_INFO *)data;
>
> -               srchinf->endOfSearch = false;
> -               if (tcon->unix_ext)
> -                       srchinf->info_level = SMB_FIND_FILE_UNIX;
> -               else if ((tcon->ses->capabilities &
> -                        tcon->ses->server->vals->cap_nt_find) == 0)
> -                       srchinf->info_level = SMB_FIND_FILE_INFO_STANDARD;
> -               else if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM)
> -                       srchinf->info_level = SMB_FIND_FILE_ID_FULL_DIR_INFO;
> -               else /* no srvino useful for fallback to some netapp */
> -                       srchinf->info_level = SMB_FIND_FILE_DIRECTORY_INFO;
> -
> -               srchflgs = CIFS_SEARCH_CLOSE_ALWAYS |
> -                               CIFS_SEARCH_CLOSE_AT_END |
> -                               CIFS_SEARCH_BACKUP_SEARCH;
> -
> -               rc = CIFSFindFirst(xid, tcon, full_path,
> -                       cifs_sb, NULL, srchflgs, srchinf, false);
> -               if (!rc) {
> -                       data = (FILE_ALL_INFO *)srchinf->srch_entries_start;
> +                       cifs_dir_info_to_fattr(&fattr, fdi, cifs_sb);
> +                       fattr.cf_uniqueid = le64_to_cpu(si->UniqueId);
> +                       /* uniqueid set, skip get inum step */
> +                       goto handle_mnt_opt;
> +               } else {
> +                       /* nothing we can do, bail out */
> +                       goto out;
> +               }
> +               break;
> +       default:
> +               cifs_dbg(FYI, "%s: unhandled err rc %d\n", __func__, rc);
> +               goto out;
> +       }
>
> -                       cifs_dir_info_to_fattr(&fattr,
> -                       (FILE_DIRECTORY_INFO *)data, cifs_sb);
> -                       fattr.cf_uniqueid = le64_to_cpu(
> -                       ((SEARCH_ID_FULL_DIR_INFO *)data)->UniqueId);
> +       /*
> +        * 3. Get or update inode number (fattr.cf_uniqueid)
> +        */
>
> -                       cifs_buf_release(srchinf->ntwrk_buf_start);
> -               }
> -               kfree(srchinf);
> -               if (rc)
> -                       goto cgii_exit;
> -       } else
> -               goto cgii_exit;
> +       cifs_set_fattr_ino(xid, tcon, sb, inode, full_path, data, &fattr);
>
>         /*
> -        * If an inode wasn't passed in, then get the inode number
> -        *
> -        * Is an i_ino of zero legal? Can we use that to check if the server
> -        * supports returning inode numbers?  Are there other sanity checks we
> -        * can use to ensure that the server is really filling in that field?
> +        * 4. Tweak fattr based on mount options
>          */
> -       if (*inode == NULL) {
> -               if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) {
> -                       if (server->ops->get_srv_inum)
> -                               tmprc = server->ops->get_srv_inum(xid,
> -                                                                 tcon, cifs_sb, full_path,
> -                                                                 &fattr.cf_uniqueid, data);
> -                       if (tmprc) {
> -                               cifs_dbg(FYI, "GetSrvInodeNum rc %d\n",
> -                                        tmprc);
> -                               fattr.cf_uniqueid = iunique(sb, ROOT_I);
> -                               cifs_autodisable_serverino(cifs_sb);
> -                       } else if ((fattr.cf_uniqueid == 0) &&
> -                                  strlen(full_path) == 0) {
> -                               /* some servers ret bad root ino ie 0 */
> -                               cifs_dbg(FYI, "Invalid (0) inodenum\n");
> -                               fattr.cf_flags |=
> -                                       CIFS_FATTR_FAKE_ROOT_INO;
> -                               fattr.cf_uniqueid =
> -                                       simple_hashstr(tcon->treeName);
> -                       }
> -               } else
> -                       fattr.cf_uniqueid = iunique(sb, ROOT_I);
> -       } else {
> -               if ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM)
> -                   && server->ops->get_srv_inum) {
> -                       /*
> -                        * Pass a NULL tcon to ensure we don't make a round
> -                        * trip to the server. This only works for SMB2+.
> -                        */
> -                       tmprc = server->ops->get_srv_inum(xid,
> -                               NULL, cifs_sb, full_path,
> -                               &fattr.cf_uniqueid, data);
> -                       if (tmprc)
> -                               fattr.cf_uniqueid = CIFS_I(*inode)->uniqueid;
> -                       else if ((fattr.cf_uniqueid == 0) &&
> -                                       strlen(full_path) == 0) {
> -                               /*
> -                                * Reuse existing root inode num since
> -                                * inum zero for root causes ls of . and .. to
> -                                * not be returned
> -                                */
> -                               cifs_dbg(FYI, "Srv ret 0 inode num for root\n");
> -                               fattr.cf_uniqueid = CIFS_I(*inode)->uniqueid;
> -                       }
> -               } else
> -                       fattr.cf_uniqueid = CIFS_I(*inode)->uniqueid;
> -       }
>
> +handle_mnt_opt:
>         /* query for SFU type info if supported and needed */
>         if (fattr.cf_cifsattrs & ATTR_SYSTEM &&
>             cifs_sb->mnt_cifs_flags & CIFS_MOUNT_UNX_EMUL) {
> @@ -900,16 +962,15 @@ cifs_get_inode_info(struct inode **inode, const char *full_path,
>                                        full_path, fid);
>                 if (rc) {
>                         cifs_dbg(FYI, "%s: Get mode from SID failed. rc=%d\n",
> -                               __func__, rc);
> -                       goto cgii_exit;
> +                                __func__, rc);
> +                       goto out;
>                 }
>         } else if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_CIFS_ACL) {
>                 rc = cifs_acl_to_fattr(cifs_sb, &fattr, *inode, false,
> -                                      full_path, fid);
> -               if (rc) {
> +                                      full_path, fid);         if (rc) {
>                         cifs_dbg(FYI, "%s: Getting ACL failed with error: %d\n",
>                                  __func__, rc);
> -                       goto cgii_exit;
> +                       goto out;
>                 }
>         }
>
> @@ -925,6 +986,10 @@ cifs_get_inode_info(struct inode **inode, const char *full_path,
>                         cifs_dbg(FYI, "check_mf_symlink: %d\n", tmprc);
>         }
>
> +       /*
> +        * 5. Update inode with final fattr data
> +        */
> +
>         if (!*inode) {
>                 *inode = cifs_iget(sb, &fattr);
>                 if (!*inode)
> @@ -937,7 +1002,7 @@ cifs_get_inode_info(struct inode **inode, const char *full_path,
>                     CIFS_I(*inode)->uniqueid != fattr.cf_uniqueid)) {
>                         CIFS_I(*inode)->time = 0; /* force reval */
>                         rc = -ESTALE;
> -                       goto cgii_exit;
> +                       goto out;
>                 }
>
>                 /* if filetype is different, return error */
> @@ -945,18 +1010,15 @@ cifs_get_inode_info(struct inode **inode, const char *full_path,
>                     (fattr.cf_mode & S_IFMT))) {
>                         CIFS_I(*inode)->time = 0; /* force reval */
>                         rc = -ESTALE;
> -                       goto cgii_exit;
> +                       goto out;
>                 }
>
>                 cifs_fattr_to_inode(*inode, &fattr);
>         }
> -
> -cgii_exit:
> -       if ((*inode) && ((*inode)->i_ino == 0))
> -               cifs_dbg(FYI, "inode number of zero returned\n");
> -
> -       kfree(buf);
> +out:
> +       cifs_buf_release(smb1_backup_rsp_buf);
>         cifs_put_tlink(tlink);
> +       kfree(tmp_data);
>         return rc;
>  }
>
> --
> 2.16.4
>


-- 
Thanks,

Steve
