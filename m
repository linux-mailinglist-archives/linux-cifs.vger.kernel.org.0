Return-Path: <linux-cifs+bounces-6562-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 80800BB7B18
	for <lists+linux-cifs@lfdr.de>; Fri, 03 Oct 2025 19:19:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 1D6694E601F
	for <lists+linux-cifs@lfdr.de>; Fri,  3 Oct 2025 17:19:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 948282D9EE2;
	Fri,  3 Oct 2025 17:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PKrsYLYd"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-qv1-f52.google.com (mail-qv1-f52.google.com [209.85.219.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D2532D8DA9
	for <linux-cifs@vger.kernel.org>; Fri,  3 Oct 2025 17:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759511973; cv=none; b=ekd999n6SV8KPTHpBvrkczIibppM/I9DOuLztdJlTVnPtgUuCRisLYDULymgGuUKeeMbZUjJsx2CNWu8ppCIm4HBB2q4oXEFpZd+9LbY5Swjtd7PN0EJyOcAeTEbL/LhYfkwqGoY/adlQNvTSB5EjVLXmUR3YhTUTfz585w47Rs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759511973; c=relaxed/simple;
	bh=d+hNHPCdcctqhqMwwfSI7ZqHOsINPXlQJG9fVF5g2zU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QChYn2U6T8OS2l8rSlhVUlqJk52fh5CGHETNvnz0XGkE+yvbJUOdL1HQXENk3vIpH1hLWNI8s812GeXNdx4LSNLjJcpcc9TKgfYiYcckdBm13c2oSFrCjzbo7eJiZv+3zpmi13dwz2dvWONC2BAAk5DEXmpRvsZJ+RxeZtGReiw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PKrsYLYd; arc=none smtp.client-ip=209.85.219.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f52.google.com with SMTP id 6a1803df08f44-78e4056623fso21548446d6.2
        for <linux-cifs@vger.kernel.org>; Fri, 03 Oct 2025 10:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759511969; x=1760116769; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bQeO7BRufyPD4hH+AuC8eieZK6LtCH///3sKMgHWdcs=;
        b=PKrsYLYd9YvkY0uaPodUcAjWc7wd/cRHC61t0Ne7dRTX3JeOJo+LXU0lI2Y5ETKvmT
         vdb4mxi11ZtLYsF8HsFLyK+Q+QZlzBXhQ9MzCEFlcOOJgpR/v2S1Gm+SJvv5GrL4F9BG
         pCDCb0CpTH8q2BCtavM9iAzCpUdnhIfqFxBNsf0clt5MwPho7qOgHOILXUvM6o/+m2TX
         e/XtcPxzMy+lFxJfSxPxH5SuwBzKhd1zqEG3eZIkCbgsjFb9+hCeptzW7EfgTbLCWbu2
         GBsY6iTJbAhEEiYpf68j8vvfw2ZFBPMvkSTmsbqThhbuu6crAhABko93J/XAGlC3Mzxk
         RCiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759511969; x=1760116769;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bQeO7BRufyPD4hH+AuC8eieZK6LtCH///3sKMgHWdcs=;
        b=qUIjfSPxx8EEOpm7vfepbgd7xwfxnLRhwdPYtpKpoqbP2sWVtr9FT1aEOH+6KJVuL5
         ael3DqVqJqvRpMMTE1tK8KdnQyrPkh249LAFNxssgWpkyen12RuJMnlh6+JVWycmuaFG
         +okWS7Sn2h+IqVfPK4b5CU/RoNZ5752E7rlkY3jMyafyf105EFBkBcSJ4GBNP0WBNai1
         ObfMeJPWPWrVU5P9SbYPFOM/bAWJi4k2DfVXLJV155cZ47B7yXhRujljpCW83jQuEoHb
         PZiMY7OFZ105Oz6mI83hobSFfWFptnOD5FW7Y1oWeBgw4C10xqHfSEAr1CymyxmpSkwx
         I3cw==
X-Forwarded-Encrypted: i=1; AJvYcCWFuw/75NzSk3ZdOG89XgzHzJ1/HJBwXsBvALBxIKI2iQymDcoxtHGn4dhHTp0dE2S7lxp7ATYdHM6A@vger.kernel.org
X-Gm-Message-State: AOJu0YxxlQlOh2AxqWuf+MNitaleJ9VKalthqk1N6ihfa3WIJZ1jqQ5R
	f9Yw/u0gRs27zdoddt6P9YI1q+c5/f6rq2g498IuICRL+icr7ud9wL1VHxVcEun+spt/qYVncpy
	Q6ra+6y+1BH7GEGBPJTJfrlTyjcMEZYg=
X-Gm-Gg: ASbGncsiKQW8ABcPxG6EN6mmBnbdWKGVUM1hZYrDZlKlOzBf1FijK/jut3GDnK1czSH
	dm/WhGyvJWFLCVjkjMmp3iiKT+rMpAraUHl1MxQE1+fNDtUbH1duU/0XAO0t1kRWHouoU5Cawh0
	WKgGyCykY3pH6m4JTOhmWYoqqvDXDhEgFxs9yYzA5vtrNLza0TPtYwCyBPm3AHc49hbi3bJgRSm
	FIng5x6/wsvdXT+t3RqBEzDzBTZupWbQ19ATtuzpMYlalFbyyHHXm1WnxI9r03/bDHoh6GZn8DQ
	jG9PSxkBsnMtJPh4BhHvQSIFIEhKhpgIIZinIMlpw6K93TDLcpdS0fOOKFaZsm7xk7WKlvN2giD
	1ebYzZ3c/bz2E8pP9FOM8
X-Google-Smtp-Source: AGHT+IHJtS/x6vYENYT9s4+gKrjo3t25fmXx0XacnE1QxzxT02WiwpVugpLzABXgwGJPhAYyxaXY2dTT9sFt+ymrUuw=
X-Received: by 2002:a05:6214:f2d:b0:78e:c8a6:e891 with SMTP id
 6a1803df08f44-879dc7c2424mr39720346d6.24.1759511969364; Fri, 03 Oct 2025
 10:19:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250925151140.57548-1-cel@kernel.org> <CAOQ4uxj-d87B+L+WgbFgmBQqdrYzrPStyfOKtVfcQ19bOEV6CQ@mail.gmail.com>
 <87tt0gqa8f.fsf@mailhost.krisman.be>
In-Reply-To: <87tt0gqa8f.fsf@mailhost.krisman.be>
From: Steve French <smfrench@gmail.com>
Date: Fri, 3 Oct 2025 12:19:17 -0500
X-Gm-Features: AS18NWAoWePf6tujqsrp1caBJcHKR4HE6V90mW4cx36rU4If80AaEbpRTvIDhcU
Message-ID: <CAH2r5mtjkgHSvWDALb6anDrw=skmg_iqZNXCgGv9vEPbci-0XA@mail.gmail.com>
Subject: Re: [RFC PATCH] fs: Plumb case sensitivity bits into statx
To: Gabriel Krisman Bertazi <gabriel@krisman.be>
Cc: Amir Goldstein <amir73il@gmail.com>, Chuck Lever <cel@kernel.org>, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, Chuck Lever <chuck.lever@oracle.com>, 
	Jeff Layton <jlayton@kernel.org>, Volker Lendecke <Volker.Lendecke@sernet.de>, 
	CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 3, 2025 at 10:52=E2=80=AFAM Gabriel Krisman Bertazi
<gabriel@krisman.be> wrote:
>
> Amir Goldstein <amir73il@gmail.com> writes:
>
> > On Thu, Sep 25, 2025 at 5:21=E2=80=AFPM Chuck Lever <cel@kernel.org> wr=
ote:
> >>
> >> From: Chuck Lever <chuck.lever@oracle.com>
> >>
> >> Both the NFSv3 and NFSv4 protocols enable NFS clients to query NFS
> >> servers about the case sensitivity and case preservation behaviors
> >> of shared file systems. Today, the Linux NFSD implementation
> >> unconditionally returns "the export is case sensitive and case
> >> preserving".
> >>
> >> However, a few Linux in-tree file system types appear to have some
> >> ability to handle case-folded filenames. Some of our users would
> >> like to exploit that functionality from their non-POSIX NFS clients.
> >>
> >> Enable upper layers such as NFSD to retrieve case sensitivity
> >> information from file systems by adding a statx API for this
> >> purpose. Introduce a sample producer and a sample consumer for this
> >> information.
> >>
> >> If this mechanism seems sensible, a future patch might add a similar
> >> field to the user-space-visible statx structure. User-space file
> >> servers already use a variety of APIs to acquire this information.
> >>
> >> Suggested-by: Jeff Layton <jlayton@kernel.org>
> >> Cc: Volker Lendecke <Volker.Lendecke@sernet.de>
> >> Signed-off-by: Chuck Lever <chuck.lever@oracle.com>
> >> ---
> >>  fs/fat/file.c             |  5 +++++
> >>  fs/nfsd/nfs3proc.c        | 35 +++++++++++++++++++++++++++--------
> >>  include/linux/stat.h      |  1 +
> >>  include/uapi/linux/stat.h | 15 +++++++++++++++
> >>  4 files changed, 48 insertions(+), 8 deletions(-)
> >>
> >> I'm certain this RFC patch has a number of problems, but it should
> >> serve as a discussion point.
> >>
> >>
> >> diff --git a/fs/fat/file.c b/fs/fat/file.c
> >> index 4fc49a614fb8..8572e36d8f27 100644
> >> --- a/fs/fat/file.c
> >> +++ b/fs/fat/file.c
> >> @@ -413,6 +413,11 @@ int fat_getattr(struct mnt_idmap *idmap, const st=
ruct path *path,
> >>                 stat->result_mask |=3D STATX_BTIME;
> >>                 stat->btime =3D MSDOS_I(inode)->i_crtime;
> >>         }
> >> +       if (request_mask & STATX_CASE_INFO) {
> >> +               stat->result_mask |=3D STATX_CASE_INFO;
> >> +               /* STATX_CASE_PRESERVING is cleared */
> >> +               stat->case_info =3D statx_case_ascii;
> >> +       }
> >>
> >>         return 0;
> >>  }
> >> diff --git a/fs/nfsd/nfs3proc.c b/fs/nfsd/nfs3proc.c
> >> index b6d03e1ef5f7..b319d1c4385c 100644
> >> --- a/fs/nfsd/nfs3proc.c
> >> +++ b/fs/nfsd/nfs3proc.c
> >> @@ -697,6 +697,31 @@ nfsd3_proc_fsinfo(struct svc_rqst *rqstp)
> >>         return rpc_success;
> >>  }
> >>
> >> +static __be32
> >> +nfsd3_proc_case(struct svc_fh *fhp, struct nfsd3_pathconfres *resp)
> >> +{
> >> +       struct path p =3D {
> >> +               .mnt            =3D fhp->fh_export->ex_path.mnt,
> >> +               .dentry         =3D fhp->fh_dentry,
> >> +       };
> >> +       u32 request_mask =3D STATX_CASE_INFO;
> >> +       struct kstat stat;
> >> +       __be32 nfserr;
> >> +
> >> +       nfserr =3D nfserrno(vfs_getattr(&p, &stat, request_mask,
> >> +                                     AT_STATX_SYNC_AS_STAT));
> >> +       if (nfserr !=3D nfs_ok)
> >> +               return nfserr;
> >> +       if (!(stat.result_mask & STATX_CASE_INFO))
> >> +               return nfs_ok;
> >> +
> >> +       resp->p_case_insensitive =3D
> >> +               stat.case_info & STATX_CASE_FOLDING_TYPE ? 0 : 1;
> >> +       resp->p_case_preserving =3D
> >> +               stat.case_info & STATX_CASE_PRESERVING ? 1 : 0;
> >> +       return nfs_ok;
> >> +}
> >> +
> >>  /*
> >>   * Get pathconf info for the specified file
> >>   */
> >> @@ -722,17 +747,11 @@ nfsd3_proc_pathconf(struct svc_rqst *rqstp)
> >>         if (resp->status =3D=3D nfs_ok) {
> >>                 struct super_block *sb =3D argp->fh.fh_dentry->d_sb;
> >>
> >> -               /* Note that we don't care for remote fs's here */
> >> -               switch (sb->s_magic) {
> >> -               case EXT2_SUPER_MAGIC:
> >> +               if (sb->s_magic =3D=3D EXT2_SUPER_MAGIC) {
> >>                         resp->p_link_max =3D EXT2_LINK_MAX;
> >>                         resp->p_name_max =3D EXT2_NAME_LEN;
> >> -                       break;
> >> -               case MSDOS_SUPER_MAGIC:
> >> -                       resp->p_case_insensitive =3D 1;
> >> -                       resp->p_case_preserving  =3D 0;
> >> -                       break;
> >>                 }
> >> +               resp->status =3D nfsd3_proc_case(&argp->fh, resp);
> >>         }
> >>
> >>         fh_put(&argp->fh);
> >> diff --git a/include/linux/stat.h b/include/linux/stat.h
> >> index e3d00e7bb26d..abb47cbb233a 100644
> >> --- a/include/linux/stat.h
> >> +++ b/include/linux/stat.h
> >> @@ -59,6 +59,7 @@ struct kstat {
> >>         u32             atomic_write_unit_max;
> >>         u32             atomic_write_unit_max_opt;
> >>         u32             atomic_write_segments_max;
> >> +       u32             case_info;
> >>  };
> >>
> >>  /* These definitions are internal to the kernel for now. Mainly used =
by nfsd. */
> >> diff --git a/include/uapi/linux/stat.h b/include/uapi/linux/stat.h
> >> index 1686861aae20..e929b30d64b6 100644
> >> --- a/include/uapi/linux/stat.h
> >> +++ b/include/uapi/linux/stat.h
> >> @@ -219,6 +219,7 @@ struct statx {
> >>  #define STATX_SUBVOL           0x00008000U     /* Want/got stx_subvol=
 */
> >>  #define STATX_WRITE_ATOMIC     0x00010000U     /* Want/got atomic_wri=
te_* fields */
> >>  #define STATX_DIO_READ_ALIGN   0x00020000U     /* Want/got dio read a=
lignment info */
> >> +#define STATX_CASE_INFO                0x00040000U     /* Want/got ca=
se folding info */
> >>
> >>  #define STATX__RESERVED                0x80000000U     /* Reserved fo=
r future struct statx expansion */
> >>
> >> @@ -257,4 +258,18 @@ struct statx {
> >>  #define STATX_ATTR_WRITE_ATOMIC                0x00400000 /* File sup=
ports atomic write operations */
> >>
> >>
> >> +/*
> >> + * File system support for case folding is available via a bitmap.
> >> + */
> >> +#define STATX_CASE_PRESERVING          0x80000000 /* File name case i=
s preserved */
> >> +
> >> +/* Values stored in the low-order byte of .case_info */
> >> +enum {
> >> +       statx_case_sensitive =3D 0,
> >> +       statx_case_ascii,
> >> +       statx_case_utf8,
> >> +       statx_case_utf16,
> >> +};
> >> +#define STATX_CASE_FOLDING_TYPE                0x000000ff
>
> Does the protocol care about unicode version?  For userspace, it would
> be very relevant to expose it, as well as other details such as
> decomposition type.



The (SMB2/SMB3/SMB3.1.1) protocol specification documentation refers
to https://www.unicode.org/versions/Unicode5.0.0/ and states
"Unless otherwise specified, all textual strings MUST be in Unicode
version 5.0 format, as specified in [UNICODE], using the 16-bit
Unicode Transformation Format (UTF-16) form of the encoding."

--=20
Thanks,

Steve

