Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DEA133708F3
	for <lists+linux-cifs@lfdr.de>; Sat,  1 May 2021 22:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231656AbhEAUug (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 1 May 2021 16:50:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231547AbhEAUug (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 1 May 2021 16:50:36 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABE8CC06174A
        for <linux-cifs@vger.kernel.org>; Sat,  1 May 2021 13:49:45 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id h10so1949251edt.13
        for <linux-cifs@vger.kernel.org>; Sat, 01 May 2021 13:49:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qXdYuOz2TSzmNOz3Svbp51VQOzryV4mpau4B6pSG3Yo=;
        b=FU8q9BT1X0YgGy/bZoA2du06OmQVoLkj9dkO+NLm2ejMl2KWGSZ1VWYLtP7OL3T+Jv
         SbkLFK+och/zSZ4Afa/VbPhg4bSOuMPowH3K/uu+QdjpzS4cpeWCFXkLcFXp8EPbJ5YC
         9Y/uZXpa4vTQOrBHOKPFvv64gG4LTv/3iLCf++JOSy4nQICgcfdm9RvrKM4v3GhPl1Hq
         dLW9XiQ1gA6ZqdUZflVycS7iPn+xCR9uc5c7Bso+2Gh9qTk/3nZjG8s4Bu5Vb7yzgbt9
         nV7f2pE7pYWt9c0pRqgy9Ts0hBmRNoQFGOESI7oBEvzdlPBNL2seu+9tk0kMfdMJ9R0I
         DuDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qXdYuOz2TSzmNOz3Svbp51VQOzryV4mpau4B6pSG3Yo=;
        b=gO1cAIWL+hcLP7h9yBDTeGE+e33+KQVGSvRU6Ba4yMMGPFEKe1vXgZwmy4YHleNRt3
         6om7fRDIrV/U/b+RqFRiBuPB/WLZpq1zb509KuUEQdEZWvl+ZKtL458vtgNYgcsUk10d
         gSZIRW+mBX+MPSZiXBgeHCE2mQvdXewP4LByNNclmkFxaW4s9VTVfJm739jfDPplVEoK
         tgJJXA+H+4UxMN0JP8hS6ZxlmT6TV+8wQkKCXZZ/tgZueqyvZsd2QAizlhmREBzqxl66
         EVDw3Kq+dI95lakbzfs0yBzzbU9biVsyDCFiZn5vcMMNN1iJYZW0MXXcPTocKIXN4RNz
         ha0A==
X-Gm-Message-State: AOAM531WMP7zXW+vIV92/5et6xcNjLB0IQfnBjALGW0c9+1+Db6mZbC+
        GOqKCBZ0WnK6OuuaqjLMmptQtD9dbnHL5NPxc/Vo7tcA
X-Google-Smtp-Source: ABdhPJySGmehGrxTuuyVQhDG1j4m87N4RpsqPC7dEu2rLfv9YLachSg7TLVFAye+GXqsbT6M+8Iv3g58kpPdcj2HE8c=
X-Received: by 2002:aa7:d88d:: with SMTP id u13mr2778567edq.114.1619902184375;
 Sat, 01 May 2021 13:49:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5muN3rpUur8jSav=fJfnt_vuJhgOXxMeGmXvT3KvxbBU5w@mail.gmail.com>
 <CAN05THQzSCZwypBWg9YZAarjrsQ74qowp4Bneo3crW9FfqVqPA@mail.gmail.com>
 <CAH2r5muu3YiBAk1Mf_xOFQJih8Ms7sQhNUKwUrFreggK-Mmr-A@mail.gmail.com> <CANT5p=rGGNdVjBSTZm1OsecEW=-5edZhZwBjSU1Q8d8dO+JsPA@mail.gmail.com>
In-Reply-To: <CANT5p=rGGNdVjBSTZm1OsecEW=-5edZhZwBjSU1Q8d8dO+JsPA@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Sun, 2 May 2021 06:49:30 +1000
Message-ID: <CAN05THTmZCNXsH4_i=0CO6CaVOYuZ=z5XHW+U_=q3Djxz6XxBA@mail.gmail.com>
Subject: Re: [PATCH] smb3.1.1: allow dumping GCM256 keys to improve debugging
 of encrypted shares
To:     Shyam Prasad N <nspmangalore@gmail.com>
Cc:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        COMMON INTERNET FILE SYSTEM SERVER 
        <linux-cifsd-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Sat, May 1, 2021 at 8:53 PM Shyam Prasad N <nspmangalore@gmail.com> wrote:
>
> Looks good to me.
>
> On a related note, we need a way for the root user to dump keys for
> another SMB session to the same path. This will be useful for
> mutli-user scenario.
> i.e. for dumping keys for SMB session as another user.
> Since we're adding a new IOCTL, perhaps we should add another arg
> which identifies the user? Maybe based on the UID:GID of the user
> session, in addition to the path supplied?

Or as an alternative, dump an array of ALL user sessions with
information about which user and which part of a multi-channel
connection that the keys belong to.
And let userspace sort out "which keys do I need for my wireshark session".

>
> Regards,
> Shyam
>
> On Sat, May 1, 2021 at 9:49 AM Steve French <smfrench@gmail.com> wrote:
> >
> > changed as suggested - see attached
> >
> > On Fri, Apr 30, 2021 at 11:00 PM ronnie sahlberg
> > <ronniesahlberg@gmail.com> wrote:
> > >
> > > These elements should probably be [32] and not
> > > + __u8 smb3encryptionkey[SMB3_ENC_DEC_KEY_SIZE];
> > >
> > > Because this is now visible to userspace and we can not allow this to
> > > ever change.
> > > Because when GCM512 is eventually released, if we bump
> > > SMB3_ENC_DEC_KEY_SIZE to a larger value we suddenly break userspace.
> > >
> > >
> > > On Sat, May 1, 2021 at 8:20 AM Steve French <smfrench@gmail.com> wrote:
> > > >
> > > > Previously we were only able to dump CCM or GCM-128 keys (see "smbinfo
> > > > keys" e.g.)
> > > > to allow network debugging (e.g. wireshark) of mounts to SMB3.1.1 encrypted
> > > > shares.  But with the addition of GCM-256 support, we have to be able to dump
> > > > 32 byte instead of 16 byte keys which requires adding an additional ioctl
> > > > for that.
> > > >
> > > > Signed-off-by: Steve French <stfrench@microsoft.com>
> > > > ---
> > > >  fs/cifs/cifs_ioctl.h | 19 +++++++++++++++++++
> > > >  fs/cifs/ioctl.c      | 33 +++++++++++++++++++++++++++++++++
> > > >  2 files changed, 52 insertions(+)
> > > >
> > > > diff --git a/fs/cifs/cifs_ioctl.h b/fs/cifs/cifs_ioctl.h
> > > > index f262c64516bc..9f2ed9cccb08 100644
> > > > --- a/fs/cifs/cifs_ioctl.h
> > > > +++ b/fs/cifs/cifs_ioctl.h
> > > > @@ -57,6 +57,12 @@ struct smb_query_info {
> > > >   /* char buffer[]; */
> > > >  } __packed;
> > > >
> > > > +/*
> > > > + * Dumping the commonly used 16 byte (e.g. CCM and GCM128) keys still supported
> > > > + * for backlevel compatibility, but is not sufficient for dumping the less
> > > > + * frequently used GCM256 (32 byte) keys (see the newer "CIFS_DUMP_FULL_KEY"
> > > > + * ioctl for dumping decryption info for GCM256 mounts)
> > > > + */
> > > >  struct smb3_key_debug_info {
> > > >   __u64 Suid;
> > > >   __u16 cipher_type;
> > > > @@ -65,6 +71,18 @@ struct smb3_key_debug_info {
> > > >   __u8 smb3decryptionkey[SMB3_SIGN_KEY_SIZE];
> > > >  } __packed;
> > > >
> > > > +/*
> > > > + * Dump full key (32 byte encrypt/decrypt keys instead of 16 bytes)
> > > > + * is needed if GCM256 (stronger encryption) negotiated
> > > > + */
> > > > +struct smb3_full_key_debug_info {
> > > > + __u64 Suid;
> > > > + __u16 cipher_type;
> > > > + __u8 auth_key[16]; /* SMB2_NTLMV2_SESSKEY_SIZE */
> > > > + __u8 smb3encryptionkey[SMB3_ENC_DEC_KEY_SIZE];
> > > > + __u8 smb3decryptionkey[SMB3_ENC_DEC_KEY_SIZE];
> > > > +} __packed;
> > > > +
> > > >  struct smb3_notify {
> > > >   __u32 completion_filter;
> > > >   bool watch_tree;
> > > > @@ -78,6 +96,7 @@ struct smb3_notify {
> > > >  #define CIFS_QUERY_INFO _IOWR(CIFS_IOCTL_MAGIC, 7, struct smb_query_info)
> > > >  #define CIFS_DUMP_KEY _IOWR(CIFS_IOCTL_MAGIC, 8, struct smb3_key_debug_info)
> > > >  #define CIFS_IOC_NOTIFY _IOW(CIFS_IOCTL_MAGIC, 9, struct smb3_notify)
> > > > +#define CIFS_DUMP_FULL_KEY _IOWR(CIFS_IOCTL_MAGIC, 10, struct
> > > > smb3_full_key_debug_info)
> > > >  #define CIFS_IOC_SHUTDOWN _IOR ('X', 125, __u32)
> > > >
> > > >  /*
> > > > diff --git a/fs/cifs/ioctl.c b/fs/cifs/ioctl.c
> > > > index ef41fa878793..e4321e2a27d2 100644
> > > > --- a/fs/cifs/ioctl.c
> > > > +++ b/fs/cifs/ioctl.c
> > > > @@ -218,6 +218,7 @@ long cifs_ioctl(struct file *filep, unsigned int
> > > > command, unsigned long arg)
> > > >  {
> > > >   struct inode *inode = file_inode(filep);
> > > >   struct smb3_key_debug_info pkey_inf;
> > > > + struct smb3_full_key_debug_info pfull_key_inf;
> > > >   int rc = -ENOTTY; /* strange error - but the precedent */
> > > >   unsigned int xid;
> > > >   struct cifsFileInfo *pSMBFile = filep->private_data;
> > > > @@ -354,6 +355,38 @@ long cifs_ioctl(struct file *filep, unsigned int
> > > > command, unsigned long arg)
> > > >   else
> > > >   rc = 0;
> > > >   break;
> > > > + /*
> > > > + * Dump full key (32 bytes instead of 16 bytes) is
> > > > + * needed if GCM256 (stronger encryption) negotiated
> > > > + */
> > > > + case CIFS_DUMP_FULL_KEY:
> > > > + if (pSMBFile == NULL)
> > > > + break;
> > > > + if (!capable(CAP_SYS_ADMIN)) {
> > > > + rc = -EACCES;
> > > > + break;
> > > > + }
> > > > +
> > > > + tcon = tlink_tcon(pSMBFile->tlink);
> > > > + if (!smb3_encryption_required(tcon)) {
> > > > + rc = -EOPNOTSUPP;
> > > > + break;
> > > > + }
> > > > + pfull_key_inf.cipher_type =
> > > > + le16_to_cpu(tcon->ses->server->cipher_type);
> > > > + pfull_key_inf.Suid = tcon->ses->Suid;
> > > > + memcpy(pfull_key_inf.auth_key, tcon->ses->auth_key.response,
> > > > + 16 /* SMB2_NTLMV2_SESSKEY_SIZE */);
> > > > + memcpy(pfull_key_inf.smb3decryptionkey,
> > > > +       tcon->ses->smb3decryptionkey, SMB3_ENC_DEC_KEY_SIZE);
> > > > + memcpy(pfull_key_inf.smb3encryptionkey,
> > > > +       tcon->ses->smb3encryptionkey, SMB3_ENC_DEC_KEY_SIZE);
> > > > + if (copy_to_user((void __user *)arg, &pfull_key_inf,
> > > > + sizeof(struct smb3_full_key_debug_info)))
> > > > + rc = -EFAULT;
> > > > + else
> > > > + rc = 0;
> > > > + break;
> > > >   case CIFS_IOC_NOTIFY:
> > > >   if (!S_ISDIR(inode->i_mode)) {
> > > >   /* Notify can only be done on directories */
> > > >
> > > > --
> > > > Thanks,
> > > >
> > > > Steve
> >
> >
> >
> > --
> > Thanks,
> >
> > Steve
>
>
>
> --
> Regards,
> Shyam
