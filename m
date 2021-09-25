Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 50AF44180C4
	for <lists+linux-cifs@lfdr.de>; Sat, 25 Sep 2021 11:19:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235512AbhIYJVJ (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 25 Sep 2021 05:21:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:46872 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234271AbhIYJVJ (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sat, 25 Sep 2021 05:21:09 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 06BC46127A
        for <linux-cifs@vger.kernel.org>; Sat, 25 Sep 2021 09:19:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632561575;
        bh=ZCrilzSORV6ULCtRLrC3twR0YL2lr8htofA8hFSvKe8=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=UyKuTuJOBkm/1+DZwdDiwP5kyEkBvAMxU7YtfrAPsB4Kh62VMxrCc8Y5fLbAft0yp
         OobFLC8Qy+Sb9HM1Zy3nAMt14swR8yeZKUqwVjJehTiTapmB3TRQxy0ISa+NEDCQpt
         DVKE2uqs5vly9nYwkv2eHUupWUnJIf+yqGEvFwke3eiJ0n653+3NOmBkLbKHyQHe0n
         T1V/dE/YtgMlKLFr40OWhU+82d0uvpqzDXVv86A1ICG2naaepUX9MGepWlme1hRugU
         NdWPLe0HUVTMos4TiCx9yOo6VvSIdvEUieDHDH+GHScW5D85j0W2o6ydNCjiWQNqHD
         IAoVSvxuBny+A==
Received: by mail-ot1-f47.google.com with SMTP id j11-20020a9d190b000000b00546fac94456so16624569ota.6
        for <linux-cifs@vger.kernel.org>; Sat, 25 Sep 2021 02:19:34 -0700 (PDT)
X-Gm-Message-State: AOAM532T6CghOk+ZmuOMKExWnp9UGUqIbIlu3DaSbZVS0AJKimINa9nS
        B8wkqL0du+J3o/WISBPtLEBDNtVJkrNuVIxA6fU=
X-Google-Smtp-Source: ABdhPJy2yTgy0DOG0T0xvYQKOLxUgIRw6r0YKRcMO5wTWhtB8b0kwmAj9lXDF1ru67KqIZ9XJYC745uHmKOvePyhXOE=
X-Received: by 2002:a9d:729d:: with SMTP id t29mr7834036otj.61.1632561574351;
 Sat, 25 Sep 2021 02:19:34 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:1342:0:0:0:0:0 with HTTP; Sat, 25 Sep 2021 02:19:33
 -0700 (PDT)
In-Reply-To: <CANFS6bYot0-tRYUdBctwmwLn3OUsYOWO_C3a3aZu74tXG2k=Mw@mail.gmail.com>
References: <20210924021254.27096-1-linkinjeon@kernel.org> <20210924021254.27096-3-linkinjeon@kernel.org>
 <CANFS6bYot0-tRYUdBctwmwLn3OUsYOWO_C3a3aZu74tXG2k=Mw@mail.gmail.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Sat, 25 Sep 2021 18:19:33 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8a7ZbZ2GHJXba8853-ysrpA==K15M=4wKbsjVwEJaDqA@mail.gmail.com>
Message-ID: <CAKYAXd8a7ZbZ2GHJXba8853-ysrpA==K15M=4wKbsjVwEJaDqA@mail.gmail.com>
Subject: Re: [PATCH 2/7] ksmbd: add request buffer validation in smb2_set_info
To:     Hyunchul Lee <hyc.lee@gmail.com>
Cc:     linux-cifs <linux-cifs@vger.kernel.org>,
        Tom Talpey <tom@talpey.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        =?UTF-8?B?UmFscGggQsO2aG1l?= <slow@samba.org>,
        Steve French <smfrench@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

2021-09-25 17:13 GMT+09:00, Hyunchul Lee <hyc.lee@gmail.com>:
> 2021=EB=85=84 9=EC=9B=94 24=EC=9D=BC (=EA=B8=88) =EC=98=A4=EC=A0=84 11:13=
, Namjae Jeon <linkinjeon@kernel.org>=EB=8B=98=EC=9D=B4 =EC=9E=91=EC=84=B1:
>
>>
>> Add buffer validation in smb2_set_info, and remove unused variable
>> in set_file_basic_info. and smb2_set_info infolevel functions take
>> structure pointer argument.
>>
>> Cc: Tom Talpey <tom@talpey.com>
>> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
>> Cc: Ralph B=C3=B6hme <slow@samba.org>
>> Cc: Steve French <smfrench@gmail.com>
>> Cc: Hyunchul Lee <hyc.lee@gmail.com>
>> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
>> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
>> ---
>>  fs/ksmbd/smb2pdu.c | 149 ++++++++++++++++++++++++++++++++-------------
>>  fs/ksmbd/smb2pdu.h |   9 +++
>>  2 files changed, 116 insertions(+), 42 deletions(-)
>>
>> diff --git a/fs/ksmbd/smb2pdu.c b/fs/ksmbd/smb2pdu.c
>> index b22d4207c077..a930838fd6ac 100644
>> --- a/fs/ksmbd/smb2pdu.c
>> +++ b/fs/ksmbd/smb2pdu.c
>> @@ -2107,16 +2107,22 @@ static noinline int create_smb2_pipe(struct
>> ksmbd_work *work)
>>   * smb2_set_ea() - handler for setting extended attributes using set
>>   *             info command
>>   * @eabuf:     set info command buffer
>> + * @buf_len:   set info command buffer length
>>   * @path:      dentry path for get ea
>>   *
>>   * Return:     0 on success, otherwise error
>>   */
>> -static int smb2_set_ea(struct smb2_ea_info *eabuf, struct path *path)
>> +static int smb2_set_ea(struct smb2_ea_info *eabuf, unsigned int buf_len=
,
>> +                      struct path *path)
>>  {
>>         struct user_namespace *user_ns =3D mnt_user_ns(path->mnt);
>>         char *attr_name =3D NULL, *value;
>>         int rc =3D 0;
>> -       int next =3D 0;
>> +       unsigned int next =3D 0;
>> +
>> +       if (buf_len < sizeof(struct smb2_ea_info) + eabuf->EaNameLength =
+
>> +                       le16_to_cpu(eabuf->EaValueLength))
>> +               return -EINVAL;
>>
>>         attr_name =3D kmalloc(XATTR_NAME_MAX + 1, GFP_KERNEL);
>>         if (!attr_name)
>> @@ -2181,7 +2187,13 @@ static int smb2_set_ea(struct smb2_ea_info *eabuf=
,
>> struct path *path)
>>
>>  next:
>>                 next =3D le32_to_cpu(eabuf->NextEntryOffset);
>> +               if (next =3D=3D 0 || buf_len < next)
>> +                       break;
>> +               buf_len -=3D next;
>>                 eabuf =3D (struct smb2_ea_info *)((char *)eabuf + next);
>> +               if (next < eabuf->EaNameLength +
>> le16_to_cpu(eabuf->EaValueLength))
>> +                       break;
>> +
>>         } while (next !=3D 0);
>>
>>         kfree(attr_name);
>> @@ -2771,7 +2783,15 @@ int smb2_open(struct ksmbd_work *work)
>>                 created =3D true;
>>                 user_ns =3D mnt_user_ns(path.mnt);
>>                 if (ea_buf) {
>> -                       rc =3D smb2_set_ea(&ea_buf->ea, &path);
>> +                       if (le32_to_cpu(ea_buf->ccontext.DataLength) <
>> +                           sizeof(struct smb2_ea_info)) {
>> +                               rc =3D -EINVAL;
>> +                               goto err_out;
>> +                       }
>> +
>> +                       rc =3D smb2_set_ea(&ea_buf->ea,
>> +
>> le32_to_cpu(ea_buf->ccontext.DataLength),
>> +                                        &path);
>>                         if (rc =3D=3D -EOPNOTSUPP)
>>                                 rc =3D 0;
>>                         else if (rc)
>> @@ -5354,7 +5374,7 @@ static int smb2_rename(struct ksmbd_work *work,
>>  static int smb2_create_link(struct ksmbd_work *work,
>>                             struct ksmbd_share_config *share,
>>                             struct smb2_file_link_info *file_info,
>> -                           struct file *filp,
>> +                           unsigned int buf_len, struct file *filp,
>>                             struct nls_table *local_nls)
>>  {
>>         char *link_name =3D NULL, *target_name =3D NULL, *pathname =3D N=
ULL;
>> @@ -5362,6 +5382,10 @@ static int smb2_create_link(struct ksmbd_work
>> *work,
>>         bool file_present =3D true;
>>         int rc;
>>
>> +       if (buf_len < sizeof(struct smb2_file_link_info) +
>> +                       le32_to_cpu(file_info->FileNameLength))
>
> Do we need to cast this to u64 or check FileNameLength to prevent
> 32-bit overflow?
Yes, I will fix it on next version.

>
>> +               return -EINVAL;
>> +
>>         ksmbd_debug(SMB, "setting FILE_LINK_INFORMATION\n");
>>         pathname =3D kmalloc(PATH_MAX, GFP_KERNEL);
>>         if (!pathname)
>> @@ -5418,10 +5442,10 @@ static int smb2_create_link(struct ksmbd_work
>> *work,
>>         return rc;
>>  }
>>
>> -static int set_file_basic_info(struct ksmbd_file *fp, char *buf,
>> +static int set_file_basic_info(struct ksmbd_file *fp,
>> +                              struct smb2_file_basic_info *file_info,
>>                                struct ksmbd_share_config *share)
>>  {
>> -       struct smb2_file_all_info *file_info;
>>         struct iattr attrs;
>>         struct timespec64 ctime;
>>         struct file *filp;
>> @@ -5432,7 +5456,6 @@ static int set_file_basic_info(struct ksmbd_file
>> *fp, char *buf,
>>         if (!(fp->daccess & FILE_WRITE_ATTRIBUTES_LE))
>>                 return -EACCES;
>>
>> -       file_info =3D (struct smb2_file_all_info *)buf;
>>         attrs.ia_valid =3D 0;
>>         filp =3D fp->filp;
>>         inode =3D file_inode(filp);
>> @@ -5509,7 +5532,8 @@ static int set_file_basic_info(struct ksmbd_file
>> *fp, char *buf,
>>  }
>>
>>  static int set_file_allocation_info(struct ksmbd_work *work,
>> -                                   struct ksmbd_file *fp, char *buf)
>> +                                   struct ksmbd_file *fp,
>> +                                   struct smb2_file_alloc_info
>> *file_alloc_info)
>>  {
>>         /*
>>          * TODO : It's working fine only when store dos attributes
>> @@ -5517,7 +5541,6 @@ static int set_file_allocation_info(struct
>> ksmbd_work *work,
>>          * properly with any smb.conf option
>>          */
>>
>> -       struct smb2_file_alloc_info *file_alloc_info;
>>         loff_t alloc_blks;
>>         struct inode *inode;
>>         int rc;
>> @@ -5525,7 +5548,6 @@ static int set_file_allocation_info(struct
>> ksmbd_work *work,
>>         if (!(fp->daccess & FILE_WRITE_DATA_LE))
>>                 return -EACCES;
>>
>> -       file_alloc_info =3D (struct smb2_file_alloc_info *)buf;
>>         alloc_blks =3D (le64_to_cpu(file_alloc_info->AllocationSize) + 5=
11)
>> >> 9;
>>         inode =3D file_inode(fp->filp);
>>
>> @@ -5561,9 +5583,8 @@ static int set_file_allocation_info(struct
>> ksmbd_work *work,
>>  }
>>
>>  static int set_end_of_file_info(struct ksmbd_work *work, struct
>> ksmbd_file *fp,
>> -                               char *buf)
>> +                               struct smb2_file_eof_info *file_eof_info=
)
>>  {
>> -       struct smb2_file_eof_info *file_eof_info;
>>         loff_t newsize;
>>         struct inode *inode;
>>         int rc;
>> @@ -5571,7 +5592,6 @@ static int set_end_of_file_info(struct ksmbd_work
>> *work, struct ksmbd_file *fp,
>>         if (!(fp->daccess & FILE_WRITE_DATA_LE))
>>                 return -EACCES;
>>
>> -       file_eof_info =3D (struct smb2_file_eof_info *)buf;
>>         newsize =3D le64_to_cpu(file_eof_info->EndOfFile);
>>         inode =3D file_inode(fp->filp);
>>
>> @@ -5598,7 +5618,8 @@ static int set_end_of_file_info(struct ksmbd_work
>> *work, struct ksmbd_file *fp,
>>  }
>>
>>  static int set_rename_info(struct ksmbd_work *work, struct ksmbd_file
>> *fp,
>> -                          char *buf)
>> +                          struct smb2_file_rename_info *rename_info,
>> +                          unsigned int buf_len)
>>  {
>>         struct user_namespace *user_ns;
>>         struct ksmbd_file *parent_fp;
>> @@ -5611,6 +5632,10 @@ static int set_rename_info(struct ksmbd_work *wor=
k,
>> struct ksmbd_file *fp,
>>                 return -EACCES;
>>         }
>>
>> +       if (buf_len < sizeof(struct smb2_file_rename_info) +
>> +                       le32_to_cpu(rename_info->FileNameLength))
>
> Also we need to cast or check FileNameLength?
Yes.
> Looks good to me except these.
Thanks for your review!
>
>> +               return -EINVAL;
>> +
>>         user_ns =3D file_mnt_user_ns(fp->filp);
>>         if (ksmbd_stream_fd(fp))
>>                 goto next;
>> @@ -5633,14 +5658,13 @@ static int set_rename_info(struct ksmbd_work
>> *work, struct ksmbd_file *fp,
>>                 }
>>         }
>>  next:
>> -       return smb2_rename(work, fp, user_ns,
>> -                          (struct smb2_file_rename_info *)buf,
>> +       return smb2_rename(work, fp, user_ns, rename_info,
>>                            work->sess->conn->local_nls);
>>  }
>>
>> -static int set_file_disposition_info(struct ksmbd_file *fp, char *buf)
>> +static int set_file_disposition_info(struct ksmbd_file *fp,
>> +                                    struct smb2_file_disposition_info
>> *file_info)
>>  {
>> -       struct smb2_file_disposition_info *file_info;
>>         struct inode *inode;
>>
>>         if (!(fp->daccess & FILE_DELETE_LE)) {
>> @@ -5649,7 +5673,6 @@ static int set_file_disposition_info(struct
>> ksmbd_file *fp, char *buf)
>>         }
>>
>>         inode =3D file_inode(fp->filp);
>> -       file_info =3D (struct smb2_file_disposition_info *)buf;
>>         if (file_info->DeletePending) {
>>                 if (S_ISDIR(inode->i_mode) &&
>>                     ksmbd_vfs_empty_dir(fp) =3D=3D -ENOTEMPTY)
>> @@ -5661,15 +5684,14 @@ static int set_file_disposition_info(struct
>> ksmbd_file *fp, char *buf)
>>         return 0;
>>  }
>>
>> -static int set_file_position_info(struct ksmbd_file *fp, char *buf)
>> +static int set_file_position_info(struct ksmbd_file *fp,
>> +                                 struct smb2_file_pos_info *file_info)
>>  {
>> -       struct smb2_file_pos_info *file_info;
>>         loff_t current_byte_offset;
>>         unsigned long sector_size;
>>         struct inode *inode;
>>
>>         inode =3D file_inode(fp->filp);
>> -       file_info =3D (struct smb2_file_pos_info *)buf;
>>         current_byte_offset =3D le64_to_cpu(file_info->CurrentByteOffset=
);
>>         sector_size =3D inode->i_sb->s_blocksize;
>>
>> @@ -5685,12 +5707,11 @@ static int set_file_position_info(struct
>> ksmbd_file *fp, char *buf)
>>         return 0;
>>  }
>>
>> -static int set_file_mode_info(struct ksmbd_file *fp, char *buf)
>> +static int set_file_mode_info(struct ksmbd_file *fp,
>> +                             struct smb2_file_mode_info *file_info)
>>  {
>> -       struct smb2_file_mode_info *file_info;
>>         __le32 mode;
>>
>> -       file_info =3D (struct smb2_file_mode_info *)buf;
>>         mode =3D file_info->Mode;
>>
>>         if ((mode & ~FILE_MODE_INFO_MASK) ||
>> @@ -5720,40 +5741,74 @@ static int set_file_mode_info(struct ksmbd_file
>> *fp, char *buf)
>>   * TODO: need to implement an error handling for
>> STATUS_INFO_LENGTH_MISMATCH
>>   */
>>  static int smb2_set_info_file(struct ksmbd_work *work, struct ksmbd_fil=
e
>> *fp,
>> -                             int info_class, char *buf,
>> +                             struct smb2_set_info_req *req,
>>                               struct ksmbd_share_config *share)
>>  {
>> -       switch (info_class) {
>> +       unsigned int buf_len =3D le32_to_cpu(req->BufferLength);
>> +
>> +       switch (req->FileInfoClass) {
>>         case FILE_BASIC_INFORMATION:
>> -               return set_file_basic_info(fp, buf, share);
>> +       {
>> +               if (buf_len < sizeof(struct smb2_file_basic_info))
>> +                       return -EINVAL;
>>
>> +               return set_file_basic_info(fp, (struct
>> smb2_file_basic_info *)req->Buffer, share);
>> +       }
>>         case FILE_ALLOCATION_INFORMATION:
>> -               return set_file_allocation_info(work, fp, buf);
>> +       {
>> +               if (buf_len < sizeof(struct smb2_file_alloc_info))
>> +                       return -EINVAL;
>>
>> +               return set_file_allocation_info(work, fp,
>> +                                               (struct
>> smb2_file_alloc_info *)req->Buffer);
>> +       }
>>         case FILE_END_OF_FILE_INFORMATION:
>> -               return set_end_of_file_info(work, fp, buf);
>> +       {
>> +               if (buf_len < sizeof(struct smb2_file_eof_info))
>> +                       return -EINVAL;
>>
>> +               return set_end_of_file_info(work, fp,
>> +                                           (struct smb2_file_eof_info
>> *)req->Buffer);
>> +       }
>>         case FILE_RENAME_INFORMATION:
>> +       {
>>                 if (!test_tree_conn_flag(work->tcon,
>> KSMBD_TREE_CONN_FLAG_WRITABLE)) {
>>                         ksmbd_debug(SMB,
>>                                     "User does not have write
>> permission\n");
>>                         return -EACCES;
>>                 }
>> -               return set_rename_info(work, fp, buf);
>>
>> +               if (buf_len < sizeof(struct smb2_file_rename_info))
>> +                       return -EINVAL;
>> +
>> +               return set_rename_info(work, fp,
>> +                                      (struct smb2_file_rename_info
>> *)req->Buffer,
>> +                                      buf_len);
>> +       }
>>         case FILE_LINK_INFORMATION:
>> +       {
>> +               if (buf_len < sizeof(struct smb2_file_link_info))
>> +                       return -EINVAL;
>> +
>>                 return smb2_create_link(work, work->tcon->share_conf,
>> -                                       (struct smb2_file_link_info *)bu=
f,
>> fp->filp,
>> +                                       (struct smb2_file_link_info
>> *)req->Buffer,
>> +                                       buf_len, fp->filp,
>>                                         work->sess->conn->local_nls);
>> -
>> +       }
>>         case FILE_DISPOSITION_INFORMATION:
>> +       {
>>                 if (!test_tree_conn_flag(work->tcon,
>> KSMBD_TREE_CONN_FLAG_WRITABLE)) {
>>                         ksmbd_debug(SMB,
>>                                     "User does not have write
>> permission\n");
>>                         return -EACCES;
>>                 }
>> -               return set_file_disposition_info(fp, buf);
>>
>> +               if (buf_len < sizeof(struct smb2_file_disposition_info))
>> +                       return -EINVAL;
>> +
>> +               return set_file_disposition_info(fp,
>> +                                                (struct
>> smb2_file_disposition_info *)req->Buffer);
>> +       }
>>         case FILE_FULL_EA_INFORMATION:
>>         {
>>                 if (!(fp->daccess & FILE_WRITE_EA_LE)) {
>> @@ -5762,18 +5817,29 @@ static int smb2_set_info_file(struct ksmbd_work
>> *work, struct ksmbd_file *fp,
>>                         return -EACCES;
>>                 }
>>
>> -               return smb2_set_ea((struct smb2_ea_info *)buf,
>> -                                  &fp->filp->f_path);
>> -       }
>> +               if (buf_len < sizeof(struct smb2_ea_info))
>> +                       return -EINVAL;
>>
>> +               return smb2_set_ea((struct smb2_ea_info *)req->Buffer,
>> +                                  buf_len, &fp->filp->f_path);
>> +       }
>>         case FILE_POSITION_INFORMATION:
>> -               return set_file_position_info(fp, buf);
>> +       {
>> +               if (buf_len < sizeof(struct smb2_file_pos_info))
>> +                       return -EINVAL;
>>
>> +               return set_file_position_info(fp, (struct
>> smb2_file_pos_info *)req->Buffer);
>> +       }
>>         case FILE_MODE_INFORMATION:
>> -               return set_file_mode_info(fp, buf);
>> +       {
>> +               if (buf_len < sizeof(struct smb2_file_mode_info))
>> +                       return -EINVAL;
>> +
>> +               return set_file_mode_info(fp, (struct smb2_file_mode_inf=
o
>> *)req->Buffer);
>> +       }
>>         }
>>
>> -       pr_err("Unimplemented Fileinfoclass :%d\n", info_class);
>> +       pr_err("Unimplemented Fileinfoclass :%d\n", req->FileInfoClass);
>>         return -EOPNOTSUPP;
>>  }
>>
>> @@ -5834,8 +5900,7 @@ int smb2_set_info(struct ksmbd_work *work)
>>         switch (req->InfoType) {
>>         case SMB2_O_INFO_FILE:
>>                 ksmbd_debug(SMB, "GOT SMB2_O_INFO_FILE\n");
>> -               rc =3D smb2_set_info_file(work, fp, req->FileInfoClass,
>> -                                       req->Buffer,
>> work->tcon->share_conf);
>> +               rc =3D smb2_set_info_file(work, fp, req,
>> work->tcon->share_conf);
>>                 break;
>>         case SMB2_O_INFO_SECURITY:
>>                 ksmbd_debug(SMB, "GOT SMB2_O_INFO_SECURITY\n");
>> diff --git a/fs/ksmbd/smb2pdu.h b/fs/ksmbd/smb2pdu.h
>> index bcec845b03f3..261825d06391 100644
>> --- a/fs/ksmbd/smb2pdu.h
>> +++ b/fs/ksmbd/smb2pdu.h
>> @@ -1464,6 +1464,15 @@ struct smb2_file_all_info { /* data block encodin=
g
>> of response to level 18 */
>>         char   FileName[1];
>>  } __packed; /* level 18 Query */
>>
>> +struct smb2_file_basic_info { /* data block encoding of response to lev=
el
>> 18 */
>> +       __le64 CreationTime;    /* Beginning of FILE_BASIC_INFO equivale=
nt
>> */
>> +       __le64 LastAccessTime;
>> +       __le64 LastWriteTime;
>> +       __le64 ChangeTime;
>> +       __le32 Attributes;
>> +       __u32  Pad1;            /* End of FILE_BASIC_INFO_INFO equivalen=
t
>> */
>> +} __packed;
>> +
>>  struct smb2_file_alt_name_info {
>>         __le32 FileNameLength;
>>         char FileName[0];
>> --
>> 2.25.1
>>
>
>
> --
> Thanks,
> Hyunchul
>
