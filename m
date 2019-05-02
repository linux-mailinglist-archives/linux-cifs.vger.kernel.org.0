Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DAF4D1213E
	for <lists+linux-cifs@lfdr.de>; Thu,  2 May 2019 19:47:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726175AbfEBRrU (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 2 May 2019 13:47:20 -0400
Received: from mail-pl1-f196.google.com ([209.85.214.196]:40514 "EHLO
        mail-pl1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726145AbfEBRrU (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 2 May 2019 13:47:20 -0400
Received: by mail-pl1-f196.google.com with SMTP id b3so1355089plr.7
        for <linux-cifs@vger.kernel.org>; Thu, 02 May 2019 10:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=yhShwvZBmL6xjADss8RGZ/RNYX12Ex9xoo/NrmoOZ1M=;
        b=uNuyoaYD3K+N3KPdrV71jn8wuRBWpnT7OYDc30JKj/ExEyz3btoVb6eGVXezhVmnS1
         egTQ1T8LPXNM9scjDoMz+RGtVc0vhezEkj1LA8Oa+wkA76h5lcNn2DUhbEuSLLKjxTwx
         wYs6GrE6NESF0BGOVP/dt3HIZGfDmyhMCfwhm2doWepTiKx9qY9/6vMvqcnN/d7ntwDK
         Mhtxr6uQeVmRCx+plWl+HFJguX4+PfHqym/4IZ16jXhuJXluRMh0dibbMqhcmsbKaP62
         9L+fG064/6HpDUnPu85CF92eIFw4WduLJfnvsNPswegEyQJqMgL3HxLJ4NI3YwOawJID
         ad6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=yhShwvZBmL6xjADss8RGZ/RNYX12Ex9xoo/NrmoOZ1M=;
        b=ZgP1gvueAyoCTwdjSj8Abv8TXo3LsC1XLshrs+S15REIiORk0hsN/LVNbUNpi/vfUg
         MF/tR1LwhFElNjEQBMYGr/+ozgpgwowpcMboF/rwRVchBr6hKuoWI/YlTwLlm+T5JfIE
         XWKx3gn9DvCr+I113DW7V5XnN2B8uy0i0DCwIsTurI/Om07HU2k8Hb6ZBKutQbVAfeSQ
         zgt4UmTX43Ry32Q+ZmmWazYl8WwR0nbfgFhuV8uOgN/gDrg9EnsQPWO5o9EloOSn9OS/
         doeK6x7jz5PIplDvlIrPLZryOc+U80o01wjcRwiDju8tpXvXBEvaM2UjXXvVx/2JoGKP
         e8GA==
X-Gm-Message-State: APjAAAVY4yQwefJp0jcC9Gf9do0Dfu58DtbnwHgqIAO6TuraWtVFPp/i
        nu4lgXfoMjCqouI9pJp+7gFAgcDoLcnSoq8C4TDuKj7lSDk=
X-Google-Smtp-Source: APXvYqxdEHG9hFZPsZZR1tz8eHVUhUcmPOzt2DCQyVjD8RAtwyau09O+EWB9rO7lp+mxcAXP6KErhAjrVBh82S53Js0=
X-Received: by 2002:a17:902:b105:: with SMTP id q5mr5136449plr.290.1556819239610;
 Thu, 02 May 2019 10:47:19 -0700 (PDT)
MIME-Version: 1.0
References: <20190502055257.31219-1-lsahlber@redhat.com> <CAKywueT9Lyzu5sjHdHnn_qW0+eReO_M9fBuFPCctLpoorpAhTg@mail.gmail.com>
In-Reply-To: <CAKywueT9Lyzu5sjHdHnn_qW0+eReO_M9fBuFPCctLpoorpAhTg@mail.gmail.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 2 May 2019 12:47:07 -0500
Message-ID: <CAH2r5mtMzVz+9Bog9LNT06sTgBfJB1S8pO3-GbR0cZHuDjtDaQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: fix smb3_zero_range for Azure
To:     Pavel Shilovsky <piastryyy@gmail.com>
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>,
        linux-cifs <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Yes - it fixed 112 and 469 (the only two failing ones)

http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/4/bui=
lds/157

On Thu, May 2, 2019 at 12:29 PM Pavel Shilovsky <piastryyy@gmail.com> wrote=
:
>
> =D1=81=D1=80, 1 =D0=BC=D0=B0=D1=8F 2019 =D0=B3. =D0=B2 22:53, Ronnie Sahl=
berg <lsahlber@redhat.com>:
> >
> > For zero-range that also extend the file we were sending this as a
> > compound of two different operations; a fsctl to set-zero-data for the =
range
> > and then an additional set-info to extend the file size.
> > This does not work for Azure since it does not support this fsctl which=
 leads
> > to fallocate(FALLOC_FL_ZERO_RANGE) failing but still changing the file =
size.
> >
> > To fix this we un-compound this and send these two operations as separa=
te
> > commands, firsat one command to set-zero-data for the range and it this
> > was successful we proceed to send a set-info to update the file size.
> >
> > This fixes xfstest generic/469 for Azure servers.
> >
> > Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> > ---
> >  fs/cifs/smb2ops.c | 54 +++++++----------------------------------------=
-------
> >  1 file changed, 7 insertions(+), 47 deletions(-)
> >
> > diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
> > index 9b7a2f448591..860dd1696830 100644
> > --- a/fs/cifs/smb2ops.c
> > +++ b/fs/cifs/smb2ops.c
> > @@ -2648,16 +2648,8 @@ static long smb3_zero_range(struct file *file, s=
truct cifs_tcon *tcon,
> >         struct cifsInodeInfo *cifsi;
> >         struct cifsFileInfo *cfile =3D file->private_data;
> >         struct file_zero_data_information fsctl_buf;
> > -       struct smb_rqst rqst[2];
> > -       int resp_buftype[2];
> > -       struct kvec rsp_iov[2];
> > -       struct kvec io_iov[SMB2_IOCTL_IOV_SIZE];
> > -       struct kvec si_iov[1];
> > -       unsigned int size[1];
> > -       void *data[1];
> >         long rc;
> >         unsigned int xid;
> > -       int num =3D 0, flags =3D 0;
> >         __le64 eof;
> >
> >         xid =3D get_xid();
> > @@ -2684,22 +2676,11 @@ static long smb3_zero_range(struct file *file, =
struct cifs_tcon *tcon,
> >         fsctl_buf.FileOffset =3D cpu_to_le64(offset);
> >         fsctl_buf.BeyondFinalZero =3D cpu_to_le64(offset + len);
> >
> > -       if (smb3_encryption_required(tcon))
> > -               flags |=3D CIFS_TRANSFORM_REQ;
> > -
> > -       memset(rqst, 0, sizeof(rqst));
> > -       resp_buftype[0] =3D resp_buftype[1] =3D CIFS_NO_BUFFER;
> > -       memset(rsp_iov, 0, sizeof(rsp_iov));
> > -
> > -
> > -       memset(&io_iov, 0, sizeof(io_iov));
> > -       rqst[num].rq_iov =3D io_iov;
> > -       rqst[num].rq_nvec =3D SMB2_IOCTL_IOV_SIZE;
> > -       rc =3D SMB2_ioctl_init(tcon, &rqst[num++], cfile->fid.persisten=
t_fid,
> > -                            cfile->fid.volatile_fid, FSCTL_SET_ZERO_DA=
TA,
> > -                            true /* is_fctl */, (char *)&fsctl_buf,
> > -                            sizeof(struct file_zero_data_information),
> > -                            CIFSMaxBufSize);
> > +       rc =3D SMB2_ioctl(xid, tcon, cfile->fid.persistent_fid,
> > +                       cfile->fid.volatile_fid, FSCTL_SET_ZERO_DATA, t=
rue,
> > +                       (char *)&fsctl_buf,
> > +                       sizeof(struct file_zero_data_information),
> > +                       0, NULL, NULL);
> >         if (rc)
> >                 goto zero_range_exit;
> >
> > @@ -2707,33 +2688,12 @@ static long smb3_zero_range(struct file *file, =
struct cifs_tcon *tcon,
> >          * do we also need to change the size of the file?
> >          */
> >         if (keep_size =3D=3D false && i_size_read(inode) < offset + len=
) {
> > -               smb2_set_next_command(tcon, &rqst[0]);
> > -
> > -               memset(&si_iov, 0, sizeof(si_iov));
> > -               rqst[num].rq_iov =3D si_iov;
> > -               rqst[num].rq_nvec =3D 1;
> > -
> >                 eof =3D cpu_to_le64(offset + len);
> > -               size[0] =3D 8; /* sizeof __le64 */
> > -               data[0] =3D &eof;
> > -
> > -               rc =3D SMB2_set_info_init(tcon, &rqst[num++],
> > -                                       cfile->fid.persistent_fid,
> > -                                       cfile->fid.persistent_fid,
> > -                                       current->tgid,
> > -                                       FILE_END_OF_FILE_INFORMATION,
> > -                                       SMB2_O_INFO_FILE, 0, data, size=
);
> > -               smb2_set_related(&rqst[1]);
> > +               rc =3D SMB2_set_eof(xid, tcon, cfile->fid.persistent_fi=
d,
> > +                                 cfile->fid.volatile_fid, cfile->pid, =
&eof);
> >         }
> >
> > -       rc =3D compound_send_recv(xid, ses, flags, num, rqst,
> > -                               resp_buftype, rsp_iov);
> > -
> >   zero_range_exit:
> > -       SMB2_ioctl_free(&rqst[0]);
> > -       SMB2_set_info_free(&rqst[1]);
> > -       free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
> > -       free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
> >         free_xid(xid);
> >         if (rc)
> >                 trace_smb3_zero_err(xid, cfile->fid.persistent_fid, tco=
n->tid,
> > --
> > 2.13.6
> >
>
> Does it also fix test 112?
>
> --
> Best regards,
> Pavel Shilovsky



--=20
Thanks,

Steve
