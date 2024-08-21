Return-Path: <linux-cifs+bounces-2542-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6D70C95A588
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Aug 2024 21:52:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CDF791F227DD
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Aug 2024 19:52:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC2FD16F267;
	Wed, 21 Aug 2024 19:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dzl60H3o"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 904EF16F0EF;
	Wed, 21 Aug 2024 19:51:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724269924; cv=none; b=lJhWwbYWW+Qrw+1PnPyD4nGF2BW7ZbORNdE4gbqRu6oBI0WxfWJePMOEcY1x0VeO9BrLvQ7JPsdf5t6ff8S+CFgjonfMYTo9ndMem514L4qH3oVuSKtBuLWO0JOkMAVrMBHgAc8dzjh06E1bIfe6slijCnBMpDJjT7h1P9r5sJI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724269924; c=relaxed/simple;
	bh=q2O25Z3QnMaUgbFBUDGWLhHSxCMgkO1YM8uBESzZAQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GZfUsT+ymSOkVzzm7zSiwKNYQ1WjjsqbGHC9bSQzFO5xULhSDpA+MOwlP0n7dKlFXt4LXVPRbbssqutCJHJUSDT+F7znd5dGT339xLiaMMuZx0Evj6EJPL0Sx5Bk8CFmTi4/zTo7rm3T+ayWe3wDzc66DKmwcuFhPoTIgl6Po/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dzl60H3o; arc=none smtp.client-ip=209.85.167.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-5334c4cc17fso83757e87.2;
        Wed, 21 Aug 2024 12:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724269916; x=1724874716; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=J7TMAiOzjL82YEsm1pFZYPzvKEVhAi0YcXjrJp1SvW4=;
        b=dzl60H3oy9gS0AsjCxA12ITfWaSMv8pPJERQEjkrYVc2rgDONYP+Qx2MzmuRRZmHog
         sDExk2cFGykEtP9AshhXgQVaIx2wJhSb1vaBMFzZsNvdBtqU+jg+Hfpdm4ij+dI8nitg
         FfGusJ5PlAaUumcDqGrdhmX+/1oDk2vzVKhEAPBGlYf6/KO0donYqCTVFbD5WOz/YRKC
         PttvafNpE/xIifKU8PVsNmuMzoLTacU4A0Bmx/LmNGn2dZXsMHCtOi21w7eN4CMv0cbn
         rNFnPvNrZwg9BrtFDGcyggZSwedkoi1QVfoX/T89e0aUolRObnQX9K9eBGrLYvVxTETy
         Y5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724269917; x=1724874717;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7TMAiOzjL82YEsm1pFZYPzvKEVhAi0YcXjrJp1SvW4=;
        b=RHIbimGTn7xeHipQn4aS7LsKmRENpNxslXvPWLCBszF6DJPqtBIsZqcUvpg3B2AC1o
         t3tq461DGBhqG65K9hmhgounC0fODn3Tr9POV2wmkVHDIcav/y2nkRpdAC/aUOpcHWp0
         dnt3CRS3d/+dGiwW/32NdcUxjEfYLghckLOXICtty0Aik1ErzheAlP9Hrfo26gLzWlwE
         hp/k+G7/oqZw6h9gbNKR5+vb/05oK0uqaInrOb38RHAdmhu1+UQ7qkXoUYQGlybP4TbI
         69L9GvwcJ6yX/MyeDg7p4P1qWi2b8U11emiLrH9D6I9iqxLDLOFeG6VJmWQRlKVKuUio
         UQLA==
X-Forwarded-Encrypted: i=1; AJvYcCUaMzl9qyP7bugT+9fn3Va8MxUAitKxkAQpwWTrzKWE6cqNzfd2DFwFwL+w0mF4ayz1FqBE1xny2aBr@vger.kernel.org, AJvYcCX/kUQViDv7Vcek0PF3YvDjs4GwElhaY5LxBfLnBM+OFX1jJqsIqExItzCmnPOIFRf5k86q3lQ5P55EG1lK@vger.kernel.org
X-Gm-Message-State: AOJu0YwRvD7jxwXguYZBvRa6udddLRJKHd4hrw+r+to8SgAudwtgJFDT
	JXEqu174ZKxvhGBeCyUZMayGgovp+nIcWYZ5d5+i8SuQb9+iCdRfimQDX0RgNyFUjGdpMdxYbtK
	Ju0OBASiMwQJiKQoLSJ5DgIDnGfo=
X-Google-Smtp-Source: AGHT+IGnHvy0ix3kYMpzKiZuBq9pyFXyJBBfEdEWAEvCMJTout9T7E5Syys0WY6BoorS6SdPwMUNnOh9O3CFHAD/zX4=
X-Received: by 2002:a05:6512:1386:b0:52e:8141:1b27 with SMTP id
 2adb3069b0e04-533485dbea1mr2005860e87.43.1724269915757; Wed, 21 Aug 2024
 12:51:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240820143319.274033-1-chenxiaosong@chenxiaosong.com> <20240820143319.274033-9-chenxiaosong@chenxiaosong.com>
In-Reply-To: <20240820143319.274033-9-chenxiaosong@chenxiaosong.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 21 Aug 2024 14:51:43 -0500
Message-ID: <CAH2r5msKNZS2YsgCHmq-tKAGS6TFs7oLvqn2fyPEA=DT4Cax4g@mail.gmail.com>
Subject: Re: [PATCH 8/8] smb: move SMB2 Status code to common header file
To: chenxiaosong@chenxiaosong.com
Cc: linkinjeon@kernel.org, sfrench@samba.org, senozhatsky@chromium.org, 
	tom@talpey.com, linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org, 
	pc@manguebit.com, ronniesahlberg@gmail.com, sprasad@microsoft.com, 
	bharathsm@microsoft.com, chenxiaosong@kylinos.cn, liuzhengyuan@kylinos.cn, 
	huhai@kylinos.cn, liuyun01@kylinos.cn
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

merged into cifs-2.6.git for-next-next (target for 6.12-rc1) but fixed
the typo in author name !=3D Signed-off-by

On Tue, Aug 20, 2024 at 9:44=E2=80=AFAM <chenxiaosong@chenxiaosong.com> wro=
te:
>
> From: ChenXiaoSong <chenxiaosong@kylinos.cn>
>
> There are only 4 different definitions between the client and server:
>
>   - STATUS_SERVER_UNAVAILABLE: from client/smb2status.h
>   - STATUS_FILE_NOT_AVAILABLE: from client/smb2status.h
>   - STATUS_NO_PREAUTH_INTEGRITY_HASH_OVERLAP: from server/smbstatus.h
>   - STATUS_INVALID_LOCK_RANGE: from server/smbstatus.h
>
> Rename client/smb2status.h to common/smb2status.h, and merge the
> 2 different definitions of server to common header file.
>
> Signed-off-by: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
> ---
>  fs/smb/client/smb2file.c               |    2 +-
>  fs/smb/client/smb2inode.c              |    2 +-
>  fs/smb/client/smb2maperror.c           |    2 +-
>  fs/smb/client/smb2misc.c               |    2 +-
>  fs/smb/client/smb2ops.c                |    2 +-
>  fs/smb/client/smb2pdu.c                |    2 +-
>  fs/smb/client/smb2transport.c          |    2 +-
>  fs/smb/{client =3D> common}/smb2status.h |    2 +
>  fs/smb/server/oplock.c                 |    2 +-
>  fs/smb/server/server.c                 |    2 +-
>  fs/smb/server/smb2misc.c               |    2 +-
>  fs/smb/server/smb2pdu.c                |    2 +-
>  fs/smb/server/smb_common.c             |    2 +-
>  fs/smb/server/smbstatus.h              | 1822 ------------------------
>  fs/smb/server/transport_rdma.c         |    2 +-
>  15 files changed, 15 insertions(+), 1835 deletions(-)
>  rename fs/smb/{client =3D> common}/smb2status.h (99%)
>  delete mode 100644 fs/smb/server/smbstatus.h
>
> diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
> index c23478ab1cf8..e6319f248816 100644
> --- a/fs/smb/client/smb2file.c
> +++ b/fs/smb/client/smb2file.c
> @@ -21,7 +21,7 @@
>  #include "cifs_unicode.h"
>  #include "fscache.h"
>  #include "smb2proto.h"
> -#include "smb2status.h"
> +#include "../common/smb2status.h"
>
>  static struct smb2_symlink_err_rsp *symlink_data(const struct kvec *iov)
>  {
> diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
> index 9f5bc41433c1..23eedc88213b 100644
> --- a/fs/smb/client/smb2inode.c
> +++ b/fs/smb/client/smb2inode.c
> @@ -24,7 +24,7 @@
>  #include "smb2pdu.h"
>  #include "smb2proto.h"
>  #include "cached_dir.h"
> -#include "smb2status.h"
> +#include "../common/smb2status.h"
>
>  static struct reparse_data_buffer *reparse_buf_ptr(struct kvec *iov)
>  {
> diff --git a/fs/smb/client/smb2maperror.c b/fs/smb/client/smb2maperror.c
> index 3ac17d43bb7d..96641356e4ad 100644
> --- a/fs/smb/client/smb2maperror.c
> +++ b/fs/smb/client/smb2maperror.c
> @@ -12,7 +12,7 @@
>  #include "cifs_debug.h"
>  #include "smb2pdu.h"
>  #include "smb2proto.h"
> -#include "smb2status.h"
> +#include "../common/smb2status.h"
>  #include "smb2glob.h"
>  #include "trace.h"
>
> diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
> index 677ef6f99a5b..f3c4b70b77b9 100644
> --- a/fs/smb/client/smb2misc.c
> +++ b/fs/smb/client/smb2misc.c
> @@ -13,7 +13,7 @@
>  #include "smb2proto.h"
>  #include "cifs_debug.h"
>  #include "cifs_unicode.h"
> -#include "smb2status.h"
> +#include "../common/smb2status.h"
>  #include "smb2glob.h"
>  #include "nterr.h"
>  #include "cached_dir.h"
> diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
> index 322cabc69c6f..547c5c94a3f8 100644
> --- a/fs/smb/client/smb2ops.c
> +++ b/fs/smb/client/smb2ops.c
> @@ -21,7 +21,7 @@
>  #include "cifsproto.h"
>  #include "cifs_debug.h"
>  #include "cifs_unicode.h"
> -#include "smb2status.h"
> +#include "../common/smb2status.h"
>  #include "smb2glob.h"
>  #include "cifs_ioctl.h"
>  #include "smbdirect.h"
> diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
> index 83facb54276a..23eb5dd23b72 100644
> --- a/fs/smb/client/smb2pdu.c
> +++ b/fs/smb/client/smb2pdu.c
> @@ -32,7 +32,7 @@
>  #include "cifs_unicode.h"
>  #include "cifs_debug.h"
>  #include "ntlmssp.h"
> -#include "smb2status.h"
> +#include "../common/smb2status.h"
>  #include "smb2glob.h"
>  #include "cifspdu.h"
>  #include "cifs_spnego.h"
> diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.=
c
> index 1476c445cadc..e4636fca821d 100644
> --- a/fs/smb/client/smb2transport.c
> +++ b/fs/smb/client/smb2transport.c
> @@ -23,7 +23,7 @@
>  #include "cifsproto.h"
>  #include "smb2proto.h"
>  #include "cifs_debug.h"
> -#include "smb2status.h"
> +#include "../common/smb2status.h"
>  #include "smb2glob.h"
>
>  static int
> diff --git a/fs/smb/client/smb2status.h b/fs/smb/common/smb2status.h
> similarity index 99%
> rename from fs/smb/client/smb2status.h
> rename to fs/smb/common/smb2status.h
> index 15364c4328ec..eeebdbf3c9a6 100644
> --- a/fs/smb/client/smb2status.h
> +++ b/fs/smb/common/smb2status.h
> @@ -1769,3 +1769,5 @@ struct ntstatus {
>  #define STATUS_IPSEC_INVALID_PACKET cpu_to_le32(0xC0360005)
>  #define STATUS_IPSEC_INTEGRITY_CHECK_FAILED cpu_to_le32(0xC0360006)
>  #define STATUS_IPSEC_CLEAR_TEXT_DROP cpu_to_le32(0xC0360007)
> +#define STATUS_NO_PREAUTH_INTEGRITY_HASH_OVERLAP cpu_to_le32(0xC05D0000)
> +#define STATUS_INVALID_LOCK_RANGE cpu_to_le32(0xC00001a1)
> diff --git a/fs/smb/server/oplock.c b/fs/smb/server/oplock.c
> index e8591686a037..977d6815eaa0 100644
> --- a/fs/smb/server/oplock.c
> +++ b/fs/smb/server/oplock.c
> @@ -10,7 +10,7 @@
>  #include "oplock.h"
>
>  #include "smb_common.h"
> -#include "smbstatus.h"
> +#include "../common/smb2status.h"
>  #include "connection.h"
>  #include "mgmt/user_session.h"
>  #include "mgmt/share_config.h"
> diff --git a/fs/smb/server/server.c b/fs/smb/server/server.c
> index 4d24cc105ef6..c402d4abe826 100644
> --- a/fs/smb/server/server.c
> +++ b/fs/smb/server/server.c
> @@ -15,7 +15,7 @@
>
>  #include "server.h"
>  #include "smb_common.h"
> -#include "smbstatus.h"
> +#include "../common/smb2status.h"
>  #include "connection.h"
>  #include "transport_ipc.h"
>  #include "mgmt/user_session.h"
> diff --git a/fs/smb/server/smb2misc.c b/fs/smb/server/smb2misc.c
> index 727cb49926ee..ae501024665e 100644
> --- a/fs/smb/server/smb2misc.c
> +++ b/fs/smb/server/smb2misc.c
> @@ -7,7 +7,7 @@
>  #include "glob.h"
>  #include "nterr.h"
>  #include "smb_common.h"
> -#include "smbstatus.h"
> +#include "../common/smb2status.h"
>  #include "mgmt/user_session.h"
>  #include "connection.h"
>
> diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
> index 6fd5977237ba..d391961be0d9 100644
> --- a/fs/smb/server/smb2pdu.c
> +++ b/fs/smb/server/smb2pdu.c
> @@ -30,7 +30,7 @@
>
>  #include "server.h"
>  #include "smb_common.h"
> -#include "smbstatus.h"
> +#include "../common/smb2status.h"
>  #include "ksmbd_work.h"
>  #include "mgmt/user_config.h"
>  #include "mgmt/share_config.h"
> diff --git a/fs/smb/server/smb_common.c b/fs/smb/server/smb_common.c
> index 13818ecb6e1b..cc4bb2377cbd 100644
> --- a/fs/smb/server/smb_common.c
> +++ b/fs/smb/server/smb_common.c
> @@ -9,7 +9,7 @@
>  #include "smb_common.h"
>  #include "server.h"
>  #include "misc.h"
> -#include "smbstatus.h"
> +#include "../common/smb2status.h"
>  #include "connection.h"
>  #include "ksmbd_work.h"
>  #include "mgmt/user_session.h"
> diff --git a/fs/smb/server/smbstatus.h b/fs/smb/server/smbstatus.h
> deleted file mode 100644
> index 8963deb42404..000000000000
> --- a/fs/smb/server/smbstatus.h
> +++ /dev/null
> @@ -1,1822 +0,0 @@
> -/* SPDX-License-Identifier: LGPL-2.1+ */
> -/*
> - *   fs/server/smb2status.h
> - *
> - *   SMB2 Status code (network error) definitions
> - *   Definitions are from MS-ERREF
> - *
> - *   Copyright (c) International Business Machines  Corp., 2009,2011
> - *   Author(s): Steve French (sfrench@us.ibm.com)
> - */
> -
> -/*
> - *  0 1 2 3 4 5 6 7 8 9 0 A B C D E F 0 1 2 3 4 5 6 7 8 9 A B C D E F
> - *  SEV C N <-------Facility--------> <------Error Status Code------>
> - *
> - *  C is set if "customer defined" error, N bit is reserved and MBZ
> - */
> -
> -#define STATUS_SEVERITY_SUCCESS cpu_to_le32(0x0000)
> -#define STATUS_SEVERITY_INFORMATIONAL cpu_to_le32(0x0001)
> -#define STATUS_SEVERITY_WARNING cpu_to_le32(0x0002)
> -#define STATUS_SEVERITY_ERROR cpu_to_le32(0x0003)
> -
> -struct ntstatus {
> -       /* Facility is the high 12 bits of the following field */
> -       __le32 Facility; /* low 2 bits Severity, next is Customer, then r=
srvd */
> -       __le32 Code;
> -};
> -
> -#define STATUS_SUCCESS 0x00000000
> -#define STATUS_WAIT_0 cpu_to_le32(0x00000000)
> -#define STATUS_WAIT_1 cpu_to_le32(0x00000001)
> -#define STATUS_WAIT_2 cpu_to_le32(0x00000002)
> -#define STATUS_WAIT_3 cpu_to_le32(0x00000003)
> -#define STATUS_WAIT_63 cpu_to_le32(0x0000003F)
> -#define STATUS_ABANDONED cpu_to_le32(0x00000080)
> -#define STATUS_ABANDONED_WAIT_0 cpu_to_le32(0x00000080)
> -#define STATUS_ABANDONED_WAIT_63 cpu_to_le32(0x000000BF)
> -#define STATUS_USER_APC cpu_to_le32(0x000000C0)
> -#define STATUS_KERNEL_APC cpu_to_le32(0x00000100)
> -#define STATUS_ALERTED cpu_to_le32(0x00000101)
> -#define STATUS_TIMEOUT cpu_to_le32(0x00000102)
> -#define STATUS_PENDING cpu_to_le32(0x00000103)
> -#define STATUS_REPARSE cpu_to_le32(0x00000104)
> -#define STATUS_MORE_ENTRIES cpu_to_le32(0x00000105)
> -#define STATUS_NOT_ALL_ASSIGNED cpu_to_le32(0x00000106)
> -#define STATUS_SOME_NOT_MAPPED cpu_to_le32(0x00000107)
> -#define STATUS_OPLOCK_BREAK_IN_PROGRESS cpu_to_le32(0x00000108)
> -#define STATUS_VOLUME_MOUNTED cpu_to_le32(0x00000109)
> -#define STATUS_RXACT_COMMITTED cpu_to_le32(0x0000010A)
> -#define STATUS_NOTIFY_CLEANUP cpu_to_le32(0x0000010B)
> -#define STATUS_NOTIFY_ENUM_DIR cpu_to_le32(0x0000010C)
> -#define STATUS_NO_QUOTAS_FOR_ACCOUNT cpu_to_le32(0x0000010D)
> -#define STATUS_PRIMARY_TRANSPORT_CONNECT_FAILED cpu_to_le32(0x0000010E)
> -#define STATUS_PAGE_FAULT_TRANSITION cpu_to_le32(0x00000110)
> -#define STATUS_PAGE_FAULT_DEMAND_ZERO cpu_to_le32(0x00000111)
> -#define STATUS_PAGE_FAULT_COPY_ON_WRITE cpu_to_le32(0x00000112)
> -#define STATUS_PAGE_FAULT_GUARD_PAGE cpu_to_le32(0x00000113)
> -#define STATUS_PAGE_FAULT_PAGING_FILE cpu_to_le32(0x00000114)
> -#define STATUS_CACHE_PAGE_LOCKED cpu_to_le32(0x00000115)
> -#define STATUS_CRASH_DUMP cpu_to_le32(0x00000116)
> -#define STATUS_BUFFER_ALL_ZEROS cpu_to_le32(0x00000117)
> -#define STATUS_REPARSE_OBJECT cpu_to_le32(0x00000118)
> -#define STATUS_RESOURCE_REQUIREMENTS_CHANGED cpu_to_le32(0x00000119)
> -#define STATUS_TRANSLATION_COMPLETE cpu_to_le32(0x00000120)
> -#define STATUS_DS_MEMBERSHIP_EVALUATED_LOCALLY cpu_to_le32(0x00000121)
> -#define STATUS_NOTHING_TO_TERMINATE cpu_to_le32(0x00000122)
> -#define STATUS_PROCESS_NOT_IN_JOB cpu_to_le32(0x00000123)
> -#define STATUS_PROCESS_IN_JOB cpu_to_le32(0x00000124)
> -#define STATUS_VOLSNAP_HIBERNATE_READY cpu_to_le32(0x00000125)
> -#define STATUS_FSFILTER_OP_COMPLETED_SUCCESSFULLY cpu_to_le32(0x00000126=
)
> -#define STATUS_INTERRUPT_VECTOR_ALREADY_CONNECTED cpu_to_le32(0x00000127=
)
> -#define STATUS_INTERRUPT_STILL_CONNECTED cpu_to_le32(0x00000128)
> -#define STATUS_PROCESS_CLONED cpu_to_le32(0x00000129)
> -#define STATUS_FILE_LOCKED_WITH_ONLY_READERS cpu_to_le32(0x0000012A)
> -#define STATUS_FILE_LOCKED_WITH_WRITERS cpu_to_le32(0x0000012B)
> -#define STATUS_RESOURCEMANAGER_READ_ONLY cpu_to_le32(0x00000202)
> -#define STATUS_WAIT_FOR_OPLOCK cpu_to_le32(0x00000367)
> -#define DBG_EXCEPTION_HANDLED cpu_to_le32(0x00010001)
> -#define DBG_CONTINUE cpu_to_le32(0x00010002)
> -#define STATUS_FLT_IO_COMPLETE cpu_to_le32(0x001C0001)
> -#define STATUS_OBJECT_NAME_EXISTS cpu_to_le32(0x40000000)
> -#define STATUS_THREAD_WAS_SUSPENDED cpu_to_le32(0x40000001)
> -#define STATUS_WORKING_SET_LIMIT_RANGE cpu_to_le32(0x40000002)
> -#define STATUS_IMAGE_NOT_AT_BASE cpu_to_le32(0x40000003)
> -#define STATUS_RXACT_STATE_CREATED cpu_to_le32(0x40000004)
> -#define STATUS_SEGMENT_NOTIFICATION cpu_to_le32(0x40000005)
> -#define STATUS_LOCAL_USER_SESSION_KEY cpu_to_le32(0x40000006)
> -#define STATUS_BAD_CURRENT_DIRECTORY cpu_to_le32(0x40000007)
> -#define STATUS_SERIAL_MORE_WRITES cpu_to_le32(0x40000008)
> -#define STATUS_REGISTRY_RECOVERED cpu_to_le32(0x40000009)
> -#define STATUS_FT_READ_RECOVERY_FROM_BACKUP cpu_to_le32(0x4000000A)
> -#define STATUS_FT_WRITE_RECOVERY cpu_to_le32(0x4000000B)
> -#define STATUS_SERIAL_COUNTER_TIMEOUT cpu_to_le32(0x4000000C)
> -#define STATUS_NULL_LM_PASSWORD cpu_to_le32(0x4000000D)
> -#define STATUS_IMAGE_MACHINE_TYPE_MISMATCH cpu_to_le32(0x4000000E)
> -#define STATUS_RECEIVE_PARTIAL cpu_to_le32(0x4000000F)
> -#define STATUS_RECEIVE_EXPEDITED cpu_to_le32(0x40000010)
> -#define STATUS_RECEIVE_PARTIAL_EXPEDITED cpu_to_le32(0x40000011)
> -#define STATUS_EVENT_DONE cpu_to_le32(0x40000012)
> -#define STATUS_EVENT_PENDING cpu_to_le32(0x40000013)
> -#define STATUS_CHECKING_FILE_SYSTEM cpu_to_le32(0x40000014)
> -#define STATUS_FATAL_APP_EXIT cpu_to_le32(0x40000015)
> -#define STATUS_PREDEFINED_HANDLE cpu_to_le32(0x40000016)
> -#define STATUS_WAS_UNLOCKED cpu_to_le32(0x40000017)
> -#define STATUS_SERVICE_NOTIFICATION cpu_to_le32(0x40000018)
> -#define STATUS_WAS_LOCKED cpu_to_le32(0x40000019)
> -#define STATUS_LOG_HARD_ERROR cpu_to_le32(0x4000001A)
> -#define STATUS_ALREADY_WIN32 cpu_to_le32(0x4000001B)
> -#define STATUS_WX86_UNSIMULATE cpu_to_le32(0x4000001C)
> -#define STATUS_WX86_CONTINUE cpu_to_le32(0x4000001D)
> -#define STATUS_WX86_SINGLE_STEP cpu_to_le32(0x4000001E)
> -#define STATUS_WX86_BREAKPOINT cpu_to_le32(0x4000001F)
> -#define STATUS_WX86_EXCEPTION_CONTINUE cpu_to_le32(0x40000020)
> -#define STATUS_WX86_EXCEPTION_LASTCHANCE cpu_to_le32(0x40000021)
> -#define STATUS_WX86_EXCEPTION_CHAIN cpu_to_le32(0x40000022)
> -#define STATUS_IMAGE_MACHINE_TYPE_MISMATCH_EXE cpu_to_le32(0x40000023)
> -#define STATUS_NO_YIELD_PERFORMED cpu_to_le32(0x40000024)
> -#define STATUS_TIMER_RESUME_IGNORED cpu_to_le32(0x40000025)
> -#define STATUS_ARBITRATION_UNHANDLED cpu_to_le32(0x40000026)
> -#define STATUS_CARDBUS_NOT_SUPPORTED cpu_to_le32(0x40000027)
> -#define STATUS_WX86_CREATEWX86TIB cpu_to_le32(0x40000028)
> -#define STATUS_MP_PROCESSOR_MISMATCH cpu_to_le32(0x40000029)
> -#define STATUS_HIBERNATED cpu_to_le32(0x4000002A)
> -#define STATUS_RESUME_HIBERNATION cpu_to_le32(0x4000002B)
> -#define STATUS_FIRMWARE_UPDATED cpu_to_le32(0x4000002C)
> -#define STATUS_DRIVERS_LEAKING_LOCKED_PAGES cpu_to_le32(0x4000002D)
> -#define STATUS_MESSAGE_RETRIEVED cpu_to_le32(0x4000002E)
> -#define STATUS_SYSTEM_POWERSTATE_TRANSITION cpu_to_le32(0x4000002F)
> -#define STATUS_ALPC_CHECK_COMPLETION_LIST cpu_to_le32(0x40000030)
> -#define STATUS_SYSTEM_POWERSTATE_COMPLEX_TRANSITION cpu_to_le32(0x400000=
31)
> -#define STATUS_ACCESS_AUDIT_BY_POLICY cpu_to_le32(0x40000032)
> -#define STATUS_ABANDON_HIBERFILE cpu_to_le32(0x40000033)
> -#define STATUS_BIZRULES_NOT_ENABLED cpu_to_le32(0x40000034)
> -#define STATUS_WAKE_SYSTEM cpu_to_le32(0x40000294)
> -#define STATUS_DS_SHUTTING_DOWN cpu_to_le32(0x40000370)
> -#define DBG_REPLY_LATER cpu_to_le32(0x40010001)
> -#define DBG_UNABLE_TO_PROVIDE_HANDLE cpu_to_le32(0x40010002)
> -#define DBG_TERMINATE_THREAD cpu_to_le32(0x40010003)
> -#define DBG_TERMINATE_PROCESS cpu_to_le32(0x40010004)
> -#define DBG_CONTROL_C cpu_to_le32(0x40010005)
> -#define DBG_PRINTEXCEPTION_C cpu_to_le32(0x40010006)
> -#define DBG_RIPEXCEPTION cpu_to_le32(0x40010007)
> -#define DBG_CONTROL_BREAK cpu_to_le32(0x40010008)
> -#define DBG_COMMAND_EXCEPTION cpu_to_le32(0x40010009)
> -#define RPC_NT_UUID_LOCAL_ONLY cpu_to_le32(0x40020056)
> -#define RPC_NT_SEND_INCOMPLETE cpu_to_le32(0x400200AF)
> -#define STATUS_CTX_CDM_CONNECT cpu_to_le32(0x400A0004)
> -#define STATUS_CTX_CDM_DISCONNECT cpu_to_le32(0x400A0005)
> -#define STATUS_SXS_RELEASE_ACTIVATION_CONTEXT cpu_to_le32(0x4015000D)
> -#define STATUS_RECOVERY_NOT_NEEDED cpu_to_le32(0x40190034)
> -#define STATUS_RM_ALREADY_STARTED cpu_to_le32(0x40190035)
> -#define STATUS_LOG_NO_RESTART cpu_to_le32(0x401A000C)
> -#define STATUS_VIDEO_DRIVER_DEBUG_REPORT_REQUEST cpu_to_le32(0x401B00EC)
> -#define STATUS_GRAPHICS_PARTIAL_DATA_POPULATED cpu_to_le32(0x401E000A)
> -#define STATUS_GRAPHICS_DRIVER_MISMATCH cpu_to_le32(0x401E0117)
> -#define STATUS_GRAPHICS_MODE_NOT_PINNED cpu_to_le32(0x401E0307)
> -#define STATUS_GRAPHICS_NO_PREFERRED_MODE cpu_to_le32(0x401E031E)
> -#define STATUS_GRAPHICS_DATASET_IS_EMPTY cpu_to_le32(0x401E034B)
> -#define STATUS_GRAPHICS_NO_MORE_ELEMENTS_IN_DATASET cpu_to_le32(0x401E03=
4C)
> -#define STATUS_GRAPHICS_PATH_CONTENT_GEOMETRY_TRANSFORMATION_NOT_PINNED =
       \
> -       cpu_to_le32(0x401E0351)
> -#define STATUS_GRAPHICS_UNKNOWN_CHILD_STATUS cpu_to_le32(0x401E042F)
> -#define STATUS_GRAPHICS_LEADLINK_START_DEFERRED cpu_to_le32(0x401E0437)
> -#define STATUS_GRAPHICS_POLLING_TOO_FREQUENTLY cpu_to_le32(0x401E0439)
> -#define STATUS_GRAPHICS_START_DEFERRED cpu_to_le32(0x401E043A)
> -#define STATUS_NDIS_INDICATION_REQUIRED cpu_to_le32(0x40230001)
> -#define STATUS_GUARD_PAGE_VIOLATION cpu_to_le32(0x80000001)
> -#define STATUS_DATATYPE_MISALIGNMENT cpu_to_le32(0x80000002)
> -#define STATUS_BREAKPOINT cpu_to_le32(0x80000003)
> -#define STATUS_SINGLE_STEP cpu_to_le32(0x80000004)
> -#define STATUS_BUFFER_OVERFLOW cpu_to_le32(0x80000005)
> -#define STATUS_NO_MORE_FILES cpu_to_le32(0x80000006)
> -#define STATUS_WAKE_SYSTEM_DEBUGGER cpu_to_le32(0x80000007)
> -#define STATUS_HANDLES_CLOSED cpu_to_le32(0x8000000A)
> -#define STATUS_NO_INHERITANCE cpu_to_le32(0x8000000B)
> -#define STATUS_GUID_SUBSTITUTION_MADE cpu_to_le32(0x8000000C)
> -#define STATUS_PARTIAL_COPY cpu_to_le32(0x8000000D)
> -#define STATUS_DEVICE_PAPER_EMPTY cpu_to_le32(0x8000000E)
> -#define STATUS_DEVICE_POWERED_OFF cpu_to_le32(0x8000000F)
> -#define STATUS_DEVICE_OFF_LINE cpu_to_le32(0x80000010)
> -#define STATUS_DEVICE_BUSY cpu_to_le32(0x80000011)
> -#define STATUS_NO_MORE_EAS cpu_to_le32(0x80000012)
> -#define STATUS_INVALID_EA_NAME cpu_to_le32(0x80000013)
> -#define STATUS_EA_LIST_INCONSISTENT cpu_to_le32(0x80000014)
> -#define STATUS_INVALID_EA_FLAG cpu_to_le32(0x80000015)
> -#define STATUS_VERIFY_REQUIRED cpu_to_le32(0x80000016)
> -#define STATUS_EXTRANEOUS_INFORMATION cpu_to_le32(0x80000017)
> -#define STATUS_RXACT_COMMIT_NECESSARY cpu_to_le32(0x80000018)
> -#define STATUS_NO_MORE_ENTRIES cpu_to_le32(0x8000001A)
> -#define STATUS_FILEMARK_DETECTED cpu_to_le32(0x8000001B)
> -#define STATUS_MEDIA_CHANGED cpu_to_le32(0x8000001C)
> -#define STATUS_BUS_RESET cpu_to_le32(0x8000001D)
> -#define STATUS_END_OF_MEDIA cpu_to_le32(0x8000001E)
> -#define STATUS_BEGINNING_OF_MEDIA cpu_to_le32(0x8000001F)
> -#define STATUS_MEDIA_CHECK cpu_to_le32(0x80000020)
> -#define STATUS_SETMARK_DETECTED cpu_to_le32(0x80000021)
> -#define STATUS_NO_DATA_DETECTED cpu_to_le32(0x80000022)
> -#define STATUS_REDIRECTOR_HAS_OPEN_HANDLES cpu_to_le32(0x80000023)
> -#define STATUS_SERVER_HAS_OPEN_HANDLES cpu_to_le32(0x80000024)
> -#define STATUS_ALREADY_DISCONNECTED cpu_to_le32(0x80000025)
> -#define STATUS_LONGJUMP cpu_to_le32(0x80000026)
> -#define STATUS_CLEANER_CARTRIDGE_INSTALLED cpu_to_le32(0x80000027)
> -#define STATUS_PLUGPLAY_QUERY_VETOED cpu_to_le32(0x80000028)
> -#define STATUS_UNWIND_CONSOLIDATE cpu_to_le32(0x80000029)
> -#define STATUS_REGISTRY_HIVE_RECOVERED cpu_to_le32(0x8000002A)
> -#define STATUS_DLL_MIGHT_BE_INSECURE cpu_to_le32(0x8000002B)
> -#define STATUS_DLL_MIGHT_BE_INCOMPATIBLE cpu_to_le32(0x8000002C)
> -#define STATUS_STOPPED_ON_SYMLINK cpu_to_le32(0x8000002D)
> -#define STATUS_DEVICE_REQUIRES_CLEANING cpu_to_le32(0x80000288)
> -#define STATUS_DEVICE_DOOR_OPEN cpu_to_le32(0x80000289)
> -#define STATUS_DATA_LOST_REPAIR cpu_to_le32(0x80000803)
> -#define DBG_EXCEPTION_NOT_HANDLED cpu_to_le32(0x80010001)
> -#define STATUS_CLUSTER_NODE_ALREADY_UP cpu_to_le32(0x80130001)
> -#define STATUS_CLUSTER_NODE_ALREADY_DOWN cpu_to_le32(0x80130002)
> -#define STATUS_CLUSTER_NETWORK_ALREADY_ONLINE cpu_to_le32(0x80130003)
> -#define STATUS_CLUSTER_NETWORK_ALREADY_OFFLINE cpu_to_le32(0x80130004)
> -#define STATUS_CLUSTER_NODE_ALREADY_MEMBER cpu_to_le32(0x80130005)
> -#define STATUS_COULD_NOT_RESIZE_LOG cpu_to_le32(0x80190009)
> -#define STATUS_NO_TXF_METADATA cpu_to_le32(0x80190029)
> -#define STATUS_CANT_RECOVER_WITH_HANDLE_OPEN cpu_to_le32(0x80190031)
> -#define STATUS_TXF_METADATA_ALREADY_PRESENT cpu_to_le32(0x80190041)
> -#define STATUS_TRANSACTION_SCOPE_CALLBACKS_NOT_SET cpu_to_le32(0x8019004=
2)
> -#define STATUS_VIDEO_HUNG_DISPLAY_DRIVER_THREAD_RECOVERED      \
> -       cpu_to_le32(0x801B00EB)
> -#define STATUS_FLT_BUFFER_TOO_SMALL cpu_to_le32(0x801C0001)
> -#define STATUS_FVE_PARTIAL_METADATA cpu_to_le32(0x80210001)
> -#define STATUS_UNSUCCESSFUL cpu_to_le32(0xC0000001)
> -#define STATUS_NOT_IMPLEMENTED cpu_to_le32(0xC0000002)
> -#define STATUS_INVALID_INFO_CLASS cpu_to_le32(0xC0000003)
> -#define STATUS_INFO_LENGTH_MISMATCH cpu_to_le32(0xC0000004)
> -#define STATUS_ACCESS_VIOLATION cpu_to_le32(0xC0000005)
> -#define STATUS_IN_PAGE_ERROR cpu_to_le32(0xC0000006)
> -#define STATUS_PAGEFILE_QUOTA cpu_to_le32(0xC0000007)
> -#define STATUS_INVALID_HANDLE cpu_to_le32(0xC0000008)
> -#define STATUS_BAD_INITIAL_STACK cpu_to_le32(0xC0000009)
> -#define STATUS_BAD_INITIAL_PC cpu_to_le32(0xC000000A)
> -#define STATUS_INVALID_CID cpu_to_le32(0xC000000B)
> -#define STATUS_TIMER_NOT_CANCELED cpu_to_le32(0xC000000C)
> -#define STATUS_INVALID_PARAMETER cpu_to_le32(0xC000000D)
> -#define STATUS_NO_SUCH_DEVICE cpu_to_le32(0xC000000E)
> -#define STATUS_NO_SUCH_FILE cpu_to_le32(0xC000000F)
> -#define STATUS_INVALID_DEVICE_REQUEST cpu_to_le32(0xC0000010)
> -#define STATUS_END_OF_FILE cpu_to_le32(0xC0000011)
> -#define STATUS_WRONG_VOLUME cpu_to_le32(0xC0000012)
> -#define STATUS_NO_MEDIA_IN_DEVICE cpu_to_le32(0xC0000013)
> -#define STATUS_UNRECOGNIZED_MEDIA cpu_to_le32(0xC0000014)
> -#define STATUS_NONEXISTENT_SECTOR cpu_to_le32(0xC0000015)
> -#define STATUS_MORE_PROCESSING_REQUIRED cpu_to_le32(0xC0000016)
> -#define STATUS_NO_MEMORY cpu_to_le32(0xC0000017)
> -#define STATUS_CONFLICTING_ADDRESSES cpu_to_le32(0xC0000018)
> -#define STATUS_NOT_MAPPED_VIEW cpu_to_le32(0xC0000019)
> -#define STATUS_UNABLE_TO_FREE_VM cpu_to_le32(0xC000001A)
> -#define STATUS_UNABLE_TO_DELETE_SECTION cpu_to_le32(0xC000001B)
> -#define STATUS_INVALID_SYSTEM_SERVICE cpu_to_le32(0xC000001C)
> -#define STATUS_ILLEGAL_INSTRUCTION cpu_to_le32(0xC000001D)
> -#define STATUS_INVALID_LOCK_SEQUENCE cpu_to_le32(0xC000001E)
> -#define STATUS_INVALID_VIEW_SIZE cpu_to_le32(0xC000001F)
> -#define STATUS_INVALID_FILE_FOR_SECTION cpu_to_le32(0xC0000020)
> -#define STATUS_ALREADY_COMMITTED cpu_to_le32(0xC0000021)
> -#define STATUS_ACCESS_DENIED cpu_to_le32(0xC0000022)
> -#define STATUS_BUFFER_TOO_SMALL cpu_to_le32(0xC0000023)
> -#define STATUS_OBJECT_TYPE_MISMATCH cpu_to_le32(0xC0000024)
> -#define STATUS_NONCONTINUABLE_EXCEPTION cpu_to_le32(0xC0000025)
> -#define STATUS_INVALID_DISPOSITION cpu_to_le32(0xC0000026)
> -#define STATUS_UNWIND cpu_to_le32(0xC0000027)
> -#define STATUS_BAD_STACK cpu_to_le32(0xC0000028)
> -#define STATUS_INVALID_UNWIND_TARGET cpu_to_le32(0xC0000029)
> -#define STATUS_NOT_LOCKED cpu_to_le32(0xC000002A)
> -#define STATUS_PARITY_ERROR cpu_to_le32(0xC000002B)
> -#define STATUS_UNABLE_TO_DECOMMIT_VM cpu_to_le32(0xC000002C)
> -#define STATUS_NOT_COMMITTED cpu_to_le32(0xC000002D)
> -#define STATUS_INVALID_PORT_ATTRIBUTES cpu_to_le32(0xC000002E)
> -#define STATUS_PORT_MESSAGE_TOO_LONG cpu_to_le32(0xC000002F)
> -#define STATUS_INVALID_PARAMETER_MIX cpu_to_le32(0xC0000030)
> -#define STATUS_INVALID_QUOTA_LOWER cpu_to_le32(0xC0000031)
> -#define STATUS_DISK_CORRUPT_ERROR cpu_to_le32(0xC0000032)
> -#define STATUS_OBJECT_NAME_INVALID cpu_to_le32(0xC0000033)
> -#define STATUS_OBJECT_NAME_NOT_FOUND cpu_to_le32(0xC0000034)
> -#define STATUS_OBJECT_NAME_COLLISION cpu_to_le32(0xC0000035)
> -#define STATUS_PORT_DISCONNECTED cpu_to_le32(0xC0000037)
> -#define STATUS_DEVICE_ALREADY_ATTACHED cpu_to_le32(0xC0000038)
> -#define STATUS_OBJECT_PATH_INVALID cpu_to_le32(0xC0000039)
> -#define STATUS_OBJECT_PATH_NOT_FOUND cpu_to_le32(0xC000003A)
> -#define STATUS_OBJECT_PATH_SYNTAX_BAD cpu_to_le32(0xC000003B)
> -#define STATUS_DATA_OVERRUN cpu_to_le32(0xC000003C)
> -#define STATUS_DATA_LATE_ERROR cpu_to_le32(0xC000003D)
> -#define STATUS_DATA_ERROR cpu_to_le32(0xC000003E)
> -#define STATUS_CRC_ERROR cpu_to_le32(0xC000003F)
> -#define STATUS_SECTION_TOO_BIG cpu_to_le32(0xC0000040)
> -#define STATUS_PORT_CONNECTION_REFUSED cpu_to_le32(0xC0000041)
> -#define STATUS_INVALID_PORT_HANDLE cpu_to_le32(0xC0000042)
> -#define STATUS_SHARING_VIOLATION cpu_to_le32(0xC0000043)
> -#define STATUS_QUOTA_EXCEEDED cpu_to_le32(0xC0000044)
> -#define STATUS_INVALID_PAGE_PROTECTION cpu_to_le32(0xC0000045)
> -#define STATUS_MUTANT_NOT_OWNED cpu_to_le32(0xC0000046)
> -#define STATUS_SEMAPHORE_LIMIT_EXCEEDED cpu_to_le32(0xC0000047)
> -#define STATUS_PORT_ALREADY_SET cpu_to_le32(0xC0000048)
> -#define STATUS_SECTION_NOT_IMAGE cpu_to_le32(0xC0000049)
> -#define STATUS_SUSPEND_COUNT_EXCEEDED cpu_to_le32(0xC000004A)
> -#define STATUS_THREAD_IS_TERMINATING cpu_to_le32(0xC000004B)
> -#define STATUS_BAD_WORKING_SET_LIMIT cpu_to_le32(0xC000004C)
> -#define STATUS_INCOMPATIBLE_FILE_MAP cpu_to_le32(0xC000004D)
> -#define STATUS_SECTION_PROTECTION cpu_to_le32(0xC000004E)
> -#define STATUS_EAS_NOT_SUPPORTED cpu_to_le32(0xC000004F)
> -#define STATUS_EA_TOO_LARGE cpu_to_le32(0xC0000050)
> -#define STATUS_NONEXISTENT_EA_ENTRY cpu_to_le32(0xC0000051)
> -#define STATUS_NO_EAS_ON_FILE cpu_to_le32(0xC0000052)
> -#define STATUS_EA_CORRUPT_ERROR cpu_to_le32(0xC0000053)
> -#define STATUS_FILE_LOCK_CONFLICT cpu_to_le32(0xC0000054)
> -#define STATUS_LOCK_NOT_GRANTED cpu_to_le32(0xC0000055)
> -#define STATUS_DELETE_PENDING cpu_to_le32(0xC0000056)
> -#define STATUS_CTL_FILE_NOT_SUPPORTED cpu_to_le32(0xC0000057)
> -#define STATUS_UNKNOWN_REVISION cpu_to_le32(0xC0000058)
> -#define STATUS_REVISION_MISMATCH cpu_to_le32(0xC0000059)
> -#define STATUS_INVALID_OWNER cpu_to_le32(0xC000005A)
> -#define STATUS_INVALID_PRIMARY_GROUP cpu_to_le32(0xC000005B)
> -#define STATUS_NO_IMPERSONATION_TOKEN cpu_to_le32(0xC000005C)
> -#define STATUS_CANT_DISABLE_MANDATORY cpu_to_le32(0xC000005D)
> -#define STATUS_NO_LOGON_SERVERS cpu_to_le32(0xC000005E)
> -#define STATUS_NO_SUCH_LOGON_SESSION cpu_to_le32(0xC000005F)
> -#define STATUS_NO_SUCH_PRIVILEGE cpu_to_le32(0xC0000060)
> -#define STATUS_PRIVILEGE_NOT_HELD cpu_to_le32(0xC0000061)
> -#define STATUS_INVALID_ACCOUNT_NAME cpu_to_le32(0xC0000062)
> -#define STATUS_USER_EXISTS cpu_to_le32(0xC0000063)
> -#define STATUS_NO_SUCH_USER cpu_to_le32(0xC0000064)
> -#define STATUS_GROUP_EXISTS cpu_to_le32(0xC0000065)
> -#define STATUS_NO_SUCH_GROUP cpu_to_le32(0xC0000066)
> -#define STATUS_MEMBER_IN_GROUP cpu_to_le32(0xC0000067)
> -#define STATUS_MEMBER_NOT_IN_GROUP cpu_to_le32(0xC0000068)
> -#define STATUS_LAST_ADMIN cpu_to_le32(0xC0000069)
> -#define STATUS_WRONG_PASSWORD cpu_to_le32(0xC000006A)
> -#define STATUS_ILL_FORMED_PASSWORD cpu_to_le32(0xC000006B)
> -#define STATUS_PASSWORD_RESTRICTION cpu_to_le32(0xC000006C)
> -#define STATUS_LOGON_FAILURE cpu_to_le32(0xC000006D)
> -#define STATUS_ACCOUNT_RESTRICTION cpu_to_le32(0xC000006E)
> -#define STATUS_INVALID_LOGON_HOURS cpu_to_le32(0xC000006F)
> -#define STATUS_INVALID_WORKSTATION cpu_to_le32(0xC0000070)
> -#define STATUS_PASSWORD_EXPIRED cpu_to_le32(0xC0000071)
> -#define STATUS_ACCOUNT_DISABLED cpu_to_le32(0xC0000072)
> -#define STATUS_NONE_MAPPED cpu_to_le32(0xC0000073)
> -#define STATUS_TOO_MANY_LUIDS_REQUESTED cpu_to_le32(0xC0000074)
> -#define STATUS_LUIDS_EXHAUSTED cpu_to_le32(0xC0000075)
> -#define STATUS_INVALID_SUB_AUTHORITY cpu_to_le32(0xC0000076)
> -#define STATUS_INVALID_ACL cpu_to_le32(0xC0000077)
> -#define STATUS_INVALID_SID cpu_to_le32(0xC0000078)
> -#define STATUS_INVALID_SECURITY_DESCR cpu_to_le32(0xC0000079)
> -#define STATUS_PROCEDURE_NOT_FOUND cpu_to_le32(0xC000007A)
> -#define STATUS_INVALID_IMAGE_FORMAT cpu_to_le32(0xC000007B)
> -#define STATUS_NO_TOKEN cpu_to_le32(0xC000007C)
> -#define STATUS_BAD_INHERITANCE_ACL cpu_to_le32(0xC000007D)
> -#define STATUS_RANGE_NOT_LOCKED cpu_to_le32(0xC000007E)
> -#define STATUS_DISK_FULL cpu_to_le32(0xC000007F)
> -#define STATUS_SERVER_DISABLED cpu_to_le32(0xC0000080)
> -#define STATUS_SERVER_NOT_DISABLED cpu_to_le32(0xC0000081)
> -#define STATUS_TOO_MANY_GUIDS_REQUESTED cpu_to_le32(0xC0000082)
> -#define STATUS_GUIDS_EXHAUSTED cpu_to_le32(0xC0000083)
> -#define STATUS_INVALID_ID_AUTHORITY cpu_to_le32(0xC0000084)
> -#define STATUS_AGENTS_EXHAUSTED cpu_to_le32(0xC0000085)
> -#define STATUS_INVALID_VOLUME_LABEL cpu_to_le32(0xC0000086)
> -#define STATUS_SECTION_NOT_EXTENDED cpu_to_le32(0xC0000087)
> -#define STATUS_NOT_MAPPED_DATA cpu_to_le32(0xC0000088)
> -#define STATUS_RESOURCE_DATA_NOT_FOUND cpu_to_le32(0xC0000089)
> -#define STATUS_RESOURCE_TYPE_NOT_FOUND cpu_to_le32(0xC000008A)
> -#define STATUS_RESOURCE_NAME_NOT_FOUND cpu_to_le32(0xC000008B)
> -#define STATUS_ARRAY_BOUNDS_EXCEEDED cpu_to_le32(0xC000008C)
> -#define STATUS_FLOAT_DENORMAL_OPERAND cpu_to_le32(0xC000008D)
> -#define STATUS_FLOAT_DIVIDE_BY_ZERO cpu_to_le32(0xC000008E)
> -#define STATUS_FLOAT_INEXACT_RESULT cpu_to_le32(0xC000008F)
> -#define STATUS_FLOAT_INVALID_OPERATION cpu_to_le32(0xC0000090)
> -#define STATUS_FLOAT_OVERFLOW cpu_to_le32(0xC0000091)
> -#define STATUS_FLOAT_STACK_CHECK cpu_to_le32(0xC0000092)
> -#define STATUS_FLOAT_UNDERFLOW cpu_to_le32(0xC0000093)
> -#define STATUS_INTEGER_DIVIDE_BY_ZERO cpu_to_le32(0xC0000094)
> -#define STATUS_INTEGER_OVERFLOW cpu_to_le32(0xC0000095)
> -#define STATUS_PRIVILEGED_INSTRUCTION cpu_to_le32(0xC0000096)
> -#define STATUS_TOO_MANY_PAGING_FILES cpu_to_le32(0xC0000097)
> -#define STATUS_FILE_INVALID cpu_to_le32(0xC0000098)
> -#define STATUS_ALLOTTED_SPACE_EXCEEDED cpu_to_le32(0xC0000099)
> -#define STATUS_INSUFFICIENT_RESOURCES cpu_to_le32(0xC000009A)
> -#define STATUS_DFS_EXIT_PATH_FOUND cpu_to_le32(0xC000009B)
> -#define STATUS_DEVICE_DATA_ERROR cpu_to_le32(0xC000009C)
> -#define STATUS_DEVICE_NOT_CONNECTED cpu_to_le32(0xC000009D)
> -#define STATUS_DEVICE_POWER_FAILURE cpu_to_le32(0xC000009E)
> -#define STATUS_FREE_VM_NOT_AT_BASE cpu_to_le32(0xC000009F)
> -#define STATUS_MEMORY_NOT_ALLOCATED cpu_to_le32(0xC00000A0)
> -#define STATUS_WORKING_SET_QUOTA cpu_to_le32(0xC00000A1)
> -#define STATUS_MEDIA_WRITE_PROTECTED cpu_to_le32(0xC00000A2)
> -#define STATUS_DEVICE_NOT_READY cpu_to_le32(0xC00000A3)
> -#define STATUS_INVALID_GROUP_ATTRIBUTES cpu_to_le32(0xC00000A4)
> -#define STATUS_BAD_IMPERSONATION_LEVEL cpu_to_le32(0xC00000A5)
> -#define STATUS_CANT_OPEN_ANONYMOUS cpu_to_le32(0xC00000A6)
> -#define STATUS_BAD_VALIDATION_CLASS cpu_to_le32(0xC00000A7)
> -#define STATUS_BAD_TOKEN_TYPE cpu_to_le32(0xC00000A8)
> -#define STATUS_BAD_MASTER_BOOT_RECORD cpu_to_le32(0xC00000A9)
> -#define STATUS_INSTRUCTION_MISALIGNMENT cpu_to_le32(0xC00000AA)
> -#define STATUS_INSTANCE_NOT_AVAILABLE cpu_to_le32(0xC00000AB)
> -#define STATUS_PIPE_NOT_AVAILABLE cpu_to_le32(0xC00000AC)
> -#define STATUS_INVALID_PIPE_STATE cpu_to_le32(0xC00000AD)
> -#define STATUS_PIPE_BUSY cpu_to_le32(0xC00000AE)
> -#define STATUS_ILLEGAL_FUNCTION cpu_to_le32(0xC00000AF)
> -#define STATUS_PIPE_DISCONNECTED cpu_to_le32(0xC00000B0)
> -#define STATUS_PIPE_CLOSING cpu_to_le32(0xC00000B1)
> -#define STATUS_PIPE_CONNECTED cpu_to_le32(0xC00000B2)
> -#define STATUS_PIPE_LISTENING cpu_to_le32(0xC00000B3)
> -#define STATUS_INVALID_READ_MODE cpu_to_le32(0xC00000B4)
> -#define STATUS_IO_TIMEOUT cpu_to_le32(0xC00000B5)
> -#define STATUS_FILE_FORCED_CLOSED cpu_to_le32(0xC00000B6)
> -#define STATUS_PROFILING_NOT_STARTED cpu_to_le32(0xC00000B7)
> -#define STATUS_PROFILING_NOT_STOPPED cpu_to_le32(0xC00000B8)
> -#define STATUS_COULD_NOT_INTERPRET cpu_to_le32(0xC00000B9)
> -#define STATUS_FILE_IS_A_DIRECTORY cpu_to_le32(0xC00000BA)
> -#define STATUS_NOT_SUPPORTED cpu_to_le32(0xC00000BB)
> -#define STATUS_REMOTE_NOT_LISTENING cpu_to_le32(0xC00000BC)
> -#define STATUS_DUPLICATE_NAME cpu_to_le32(0xC00000BD)
> -#define STATUS_BAD_NETWORK_PATH cpu_to_le32(0xC00000BE)
> -#define STATUS_NETWORK_BUSY cpu_to_le32(0xC00000BF)
> -#define STATUS_DEVICE_DOES_NOT_EXIST cpu_to_le32(0xC00000C0)
> -#define STATUS_TOO_MANY_COMMANDS cpu_to_le32(0xC00000C1)
> -#define STATUS_ADAPTER_HARDWARE_ERROR cpu_to_le32(0xC00000C2)
> -#define STATUS_INVALID_NETWORK_RESPONSE cpu_to_le32(0xC00000C3)
> -#define STATUS_UNEXPECTED_NETWORK_ERROR cpu_to_le32(0xC00000C4)
> -#define STATUS_BAD_REMOTE_ADAPTER cpu_to_le32(0xC00000C5)
> -#define STATUS_PRINT_QUEUE_FULL cpu_to_le32(0xC00000C6)
> -#define STATUS_NO_SPOOL_SPACE cpu_to_le32(0xC00000C7)
> -#define STATUS_PRINT_CANCELLED cpu_to_le32(0xC00000C8)
> -#define STATUS_NETWORK_NAME_DELETED cpu_to_le32(0xC00000C9)
> -#define STATUS_NETWORK_ACCESS_DENIED cpu_to_le32(0xC00000CA)
> -#define STATUS_BAD_DEVICE_TYPE cpu_to_le32(0xC00000CB)
> -#define STATUS_BAD_NETWORK_NAME cpu_to_le32(0xC00000CC)
> -#define STATUS_TOO_MANY_NAMES cpu_to_le32(0xC00000CD)
> -#define STATUS_TOO_MANY_SESSIONS cpu_to_le32(0xC00000CE)
> -#define STATUS_SHARING_PAUSED cpu_to_le32(0xC00000CF)
> -#define STATUS_REQUEST_NOT_ACCEPTED cpu_to_le32(0xC00000D0)
> -#define STATUS_REDIRECTOR_PAUSED cpu_to_le32(0xC00000D1)
> -#define STATUS_NET_WRITE_FAULT cpu_to_le32(0xC00000D2)
> -#define STATUS_PROFILING_AT_LIMIT cpu_to_le32(0xC00000D3)
> -#define STATUS_NOT_SAME_DEVICE cpu_to_le32(0xC00000D4)
> -#define STATUS_FILE_RENAMED cpu_to_le32(0xC00000D5)
> -#define STATUS_VIRTUAL_CIRCUIT_CLOSED cpu_to_le32(0xC00000D6)
> -#define STATUS_NO_SECURITY_ON_OBJECT cpu_to_le32(0xC00000D7)
> -#define STATUS_CANT_WAIT cpu_to_le32(0xC00000D8)
> -#define STATUS_PIPE_EMPTY cpu_to_le32(0xC00000D9)
> -#define STATUS_CANT_ACCESS_DOMAIN_INFO cpu_to_le32(0xC00000DA)
> -#define STATUS_CANT_TERMINATE_SELF cpu_to_le32(0xC00000DB)
> -#define STATUS_INVALID_SERVER_STATE cpu_to_le32(0xC00000DC)
> -#define STATUS_INVALID_DOMAIN_STATE cpu_to_le32(0xC00000DD)
> -#define STATUS_INVALID_DOMAIN_ROLE cpu_to_le32(0xC00000DE)
> -#define STATUS_NO_SUCH_DOMAIN cpu_to_le32(0xC00000DF)
> -#define STATUS_DOMAIN_EXISTS cpu_to_le32(0xC00000E0)
> -#define STATUS_DOMAIN_LIMIT_EXCEEDED cpu_to_le32(0xC00000E1)
> -#define STATUS_OPLOCK_NOT_GRANTED cpu_to_le32(0xC00000E2)
> -#define STATUS_INVALID_OPLOCK_PROTOCOL cpu_to_le32(0xC00000E3)
> -#define STATUS_INTERNAL_DB_CORRUPTION cpu_to_le32(0xC00000E4)
> -#define STATUS_INTERNAL_ERROR cpu_to_le32(0xC00000E5)
> -#define STATUS_GENERIC_NOT_MAPPED cpu_to_le32(0xC00000E6)
> -#define STATUS_BAD_DESCRIPTOR_FORMAT cpu_to_le32(0xC00000E7)
> -#define STATUS_INVALID_USER_BUFFER cpu_to_le32(0xC00000E8)
> -#define STATUS_UNEXPECTED_IO_ERROR cpu_to_le32(0xC00000E9)
> -#define STATUS_UNEXPECTED_MM_CREATE_ERR cpu_to_le32(0xC00000EA)
> -#define STATUS_UNEXPECTED_MM_MAP_ERROR cpu_to_le32(0xC00000EB)
> -#define STATUS_UNEXPECTED_MM_EXTEND_ERR cpu_to_le32(0xC00000EC)
> -#define STATUS_NOT_LOGON_PROCESS cpu_to_le32(0xC00000ED)
> -#define STATUS_LOGON_SESSION_EXISTS cpu_to_le32(0xC00000EE)
> -#define STATUS_INVALID_PARAMETER_1 cpu_to_le32(0xC00000EF)
> -#define STATUS_INVALID_PARAMETER_2 cpu_to_le32(0xC00000F0)
> -#define STATUS_INVALID_PARAMETER_3 cpu_to_le32(0xC00000F1)
> -#define STATUS_INVALID_PARAMETER_4 cpu_to_le32(0xC00000F2)
> -#define STATUS_INVALID_PARAMETER_5 cpu_to_le32(0xC00000F3)
> -#define STATUS_INVALID_PARAMETER_6 cpu_to_le32(0xC00000F4)
> -#define STATUS_INVALID_PARAMETER_7 cpu_to_le32(0xC00000F5)
> -#define STATUS_INVALID_PARAMETER_8 cpu_to_le32(0xC00000F6)
> -#define STATUS_INVALID_PARAMETER_9 cpu_to_le32(0xC00000F7)
> -#define STATUS_INVALID_PARAMETER_10 cpu_to_le32(0xC00000F8)
> -#define STATUS_INVALID_PARAMETER_11 cpu_to_le32(0xC00000F9)
> -#define STATUS_INVALID_PARAMETER_12 cpu_to_le32(0xC00000FA)
> -#define STATUS_REDIRECTOR_NOT_STARTED cpu_to_le32(0xC00000FB)
> -#define STATUS_REDIRECTOR_STARTED cpu_to_le32(0xC00000FC)
> -#define STATUS_STACK_OVERFLOW cpu_to_le32(0xC00000FD)
> -#define STATUS_NO_SUCH_PACKAGE cpu_to_le32(0xC00000FE)
> -#define STATUS_BAD_FUNCTION_TABLE cpu_to_le32(0xC00000FF)
> -#define STATUS_VARIABLE_NOT_FOUND cpu_to_le32(0xC0000100)
> -#define STATUS_DIRECTORY_NOT_EMPTY cpu_to_le32(0xC0000101)
> -#define STATUS_FILE_CORRUPT_ERROR cpu_to_le32(0xC0000102)
> -#define STATUS_NOT_A_DIRECTORY cpu_to_le32(0xC0000103)
> -#define STATUS_BAD_LOGON_SESSION_STATE cpu_to_le32(0xC0000104)
> -#define STATUS_LOGON_SESSION_COLLISION cpu_to_le32(0xC0000105)
> -#define STATUS_NAME_TOO_LONG cpu_to_le32(0xC0000106)
> -#define STATUS_FILES_OPEN cpu_to_le32(0xC0000107)
> -#define STATUS_CONNECTION_IN_USE cpu_to_le32(0xC0000108)
> -#define STATUS_MESSAGE_NOT_FOUND cpu_to_le32(0xC0000109)
> -#define STATUS_PROCESS_IS_TERMINATING cpu_to_le32(0xC000010A)
> -#define STATUS_INVALID_LOGON_TYPE cpu_to_le32(0xC000010B)
> -#define STATUS_NO_GUID_TRANSLATION cpu_to_le32(0xC000010C)
> -#define STATUS_CANNOT_IMPERSONATE cpu_to_le32(0xC000010D)
> -#define STATUS_IMAGE_ALREADY_LOADED cpu_to_le32(0xC000010E)
> -#define STATUS_ABIOS_NOT_PRESENT cpu_to_le32(0xC000010F)
> -#define STATUS_ABIOS_LID_NOT_EXIST cpu_to_le32(0xC0000110)
> -#define STATUS_ABIOS_LID_ALREADY_OWNED cpu_to_le32(0xC0000111)
> -#define STATUS_ABIOS_NOT_LID_OWNER cpu_to_le32(0xC0000112)
> -#define STATUS_ABIOS_INVALID_COMMAND cpu_to_le32(0xC0000113)
> -#define STATUS_ABIOS_INVALID_LID cpu_to_le32(0xC0000114)
> -#define STATUS_ABIOS_SELECTOR_NOT_AVAILABLE cpu_to_le32(0xC0000115)
> -#define STATUS_ABIOS_INVALID_SELECTOR cpu_to_le32(0xC0000116)
> -#define STATUS_NO_LDT cpu_to_le32(0xC0000117)
> -#define STATUS_INVALID_LDT_SIZE cpu_to_le32(0xC0000118)
> -#define STATUS_INVALID_LDT_OFFSET cpu_to_le32(0xC0000119)
> -#define STATUS_INVALID_LDT_DESCRIPTOR cpu_to_le32(0xC000011A)
> -#define STATUS_INVALID_IMAGE_NE_FORMAT cpu_to_le32(0xC000011B)
> -#define STATUS_RXACT_INVALID_STATE cpu_to_le32(0xC000011C)
> -#define STATUS_RXACT_COMMIT_FAILURE cpu_to_le32(0xC000011D)
> -#define STATUS_MAPPED_FILE_SIZE_ZERO cpu_to_le32(0xC000011E)
> -#define STATUS_TOO_MANY_OPENED_FILES cpu_to_le32(0xC000011F)
> -#define STATUS_CANCELLED cpu_to_le32(0xC0000120)
> -#define STATUS_CANNOT_DELETE cpu_to_le32(0xC0000121)
> -#define STATUS_INVALID_COMPUTER_NAME cpu_to_le32(0xC0000122)
> -#define STATUS_FILE_DELETED cpu_to_le32(0xC0000123)
> -#define STATUS_SPECIAL_ACCOUNT cpu_to_le32(0xC0000124)
> -#define STATUS_SPECIAL_GROUP cpu_to_le32(0xC0000125)
> -#define STATUS_SPECIAL_USER cpu_to_le32(0xC0000126)
> -#define STATUS_MEMBERS_PRIMARY_GROUP cpu_to_le32(0xC0000127)
> -#define STATUS_FILE_CLOSED cpu_to_le32(0xC0000128)
> -#define STATUS_TOO_MANY_THREADS cpu_to_le32(0xC0000129)
> -#define STATUS_THREAD_NOT_IN_PROCESS cpu_to_le32(0xC000012A)
> -#define STATUS_TOKEN_ALREADY_IN_USE cpu_to_le32(0xC000012B)
> -#define STATUS_PAGEFILE_QUOTA_EXCEEDED cpu_to_le32(0xC000012C)
> -#define STATUS_COMMITMENT_LIMIT cpu_to_le32(0xC000012D)
> -#define STATUS_INVALID_IMAGE_LE_FORMAT cpu_to_le32(0xC000012E)
> -#define STATUS_INVALID_IMAGE_NOT_MZ cpu_to_le32(0xC000012F)
> -#define STATUS_INVALID_IMAGE_PROTECT cpu_to_le32(0xC0000130)
> -#define STATUS_INVALID_IMAGE_WIN_16 cpu_to_le32(0xC0000131)
> -#define STATUS_LOGON_SERVER_CONFLICT cpu_to_le32(0xC0000132)
> -#define STATUS_TIME_DIFFERENCE_AT_DC cpu_to_le32(0xC0000133)
> -#define STATUS_SYNCHRONIZATION_REQUIRED cpu_to_le32(0xC0000134)
> -#define STATUS_DLL_NOT_FOUND cpu_to_le32(0xC0000135)
> -#define STATUS_OPEN_FAILED cpu_to_le32(0xC0000136)
> -#define STATUS_IO_PRIVILEGE_FAILED cpu_to_le32(0xC0000137)
> -#define STATUS_ORDINAL_NOT_FOUND cpu_to_le32(0xC0000138)
> -#define STATUS_ENTRYPOINT_NOT_FOUND cpu_to_le32(0xC0000139)
> -#define STATUS_CONTROL_C_EXIT cpu_to_le32(0xC000013A)
> -#define STATUS_LOCAL_DISCONNECT cpu_to_le32(0xC000013B)
> -#define STATUS_REMOTE_DISCONNECT cpu_to_le32(0xC000013C)
> -#define STATUS_REMOTE_RESOURCES cpu_to_le32(0xC000013D)
> -#define STATUS_LINK_FAILED cpu_to_le32(0xC000013E)
> -#define STATUS_LINK_TIMEOUT cpu_to_le32(0xC000013F)
> -#define STATUS_INVALID_CONNECTION cpu_to_le32(0xC0000140)
> -#define STATUS_INVALID_ADDRESS cpu_to_le32(0xC0000141)
> -#define STATUS_DLL_INIT_FAILED cpu_to_le32(0xC0000142)
> -#define STATUS_MISSING_SYSTEMFILE cpu_to_le32(0xC0000143)
> -#define STATUS_UNHANDLED_EXCEPTION cpu_to_le32(0xC0000144)
> -#define STATUS_APP_INIT_FAILURE cpu_to_le32(0xC0000145)
> -#define STATUS_PAGEFILE_CREATE_FAILED cpu_to_le32(0xC0000146)
> -#define STATUS_NO_PAGEFILE cpu_to_le32(0xC0000147)
> -#define STATUS_INVALID_LEVEL cpu_to_le32(0xC0000148)
> -#define STATUS_WRONG_PASSWORD_CORE cpu_to_le32(0xC0000149)
> -#define STATUS_ILLEGAL_FLOAT_CONTEXT cpu_to_le32(0xC000014A)
> -#define STATUS_PIPE_BROKEN cpu_to_le32(0xC000014B)
> -#define STATUS_REGISTRY_CORRUPT cpu_to_le32(0xC000014C)
> -#define STATUS_REGISTRY_IO_FAILED cpu_to_le32(0xC000014D)
> -#define STATUS_NO_EVENT_PAIR cpu_to_le32(0xC000014E)
> -#define STATUS_UNRECOGNIZED_VOLUME cpu_to_le32(0xC000014F)
> -#define STATUS_SERIAL_NO_DEVICE_INITED cpu_to_le32(0xC0000150)
> -#define STATUS_NO_SUCH_ALIAS cpu_to_le32(0xC0000151)
> -#define STATUS_MEMBER_NOT_IN_ALIAS cpu_to_le32(0xC0000152)
> -#define STATUS_MEMBER_IN_ALIAS cpu_to_le32(0xC0000153)
> -#define STATUS_ALIAS_EXISTS cpu_to_le32(0xC0000154)
> -#define STATUS_LOGON_NOT_GRANTED cpu_to_le32(0xC0000155)
> -#define STATUS_TOO_MANY_SECRETS cpu_to_le32(0xC0000156)
> -#define STATUS_SECRET_TOO_LONG cpu_to_le32(0xC0000157)
> -#define STATUS_INTERNAL_DB_ERROR cpu_to_le32(0xC0000158)
> -#define STATUS_FULLSCREEN_MODE cpu_to_le32(0xC0000159)
> -#define STATUS_TOO_MANY_CONTEXT_IDS cpu_to_le32(0xC000015A)
> -#define STATUS_LOGON_TYPE_NOT_GRANTED cpu_to_le32(0xC000015B)
> -#define STATUS_NOT_REGISTRY_FILE cpu_to_le32(0xC000015C)
> -#define STATUS_NT_CROSS_ENCRYPTION_REQUIRED cpu_to_le32(0xC000015D)
> -#define STATUS_DOMAIN_CTRLR_CONFIG_ERROR cpu_to_le32(0xC000015E)
> -#define STATUS_FT_MISSING_MEMBER cpu_to_le32(0xC000015F)
> -#define STATUS_ILL_FORMED_SERVICE_ENTRY cpu_to_le32(0xC0000160)
> -#define STATUS_ILLEGAL_CHARACTER cpu_to_le32(0xC0000161)
> -#define STATUS_UNMAPPABLE_CHARACTER cpu_to_le32(0xC0000162)
> -#define STATUS_UNDEFINED_CHARACTER cpu_to_le32(0xC0000163)
> -#define STATUS_FLOPPY_VOLUME cpu_to_le32(0xC0000164)
> -#define STATUS_FLOPPY_ID_MARK_NOT_FOUND cpu_to_le32(0xC0000165)
> -#define STATUS_FLOPPY_WRONG_CYLINDER cpu_to_le32(0xC0000166)
> -#define STATUS_FLOPPY_UNKNOWN_ERROR cpu_to_le32(0xC0000167)
> -#define STATUS_FLOPPY_BAD_REGISTERS cpu_to_le32(0xC0000168)
> -#define STATUS_DISK_RECALIBRATE_FAILED cpu_to_le32(0xC0000169)
> -#define STATUS_DISK_OPERATION_FAILED cpu_to_le32(0xC000016A)
> -#define STATUS_DISK_RESET_FAILED cpu_to_le32(0xC000016B)
> -#define STATUS_SHARED_IRQ_BUSY cpu_to_le32(0xC000016C)
> -#define STATUS_FT_ORPHANING cpu_to_le32(0xC000016D)
> -#define STATUS_BIOS_FAILED_TO_CONNECT_INTERRUPT cpu_to_le32(0xC000016E)
> -#define STATUS_PARTITION_FAILURE cpu_to_le32(0xC0000172)
> -#define STATUS_INVALID_BLOCK_LENGTH cpu_to_le32(0xC0000173)
> -#define STATUS_DEVICE_NOT_PARTITIONED cpu_to_le32(0xC0000174)
> -#define STATUS_UNABLE_TO_LOCK_MEDIA cpu_to_le32(0xC0000175)
> -#define STATUS_UNABLE_TO_UNLOAD_MEDIA cpu_to_le32(0xC0000176)
> -#define STATUS_EOM_OVERFLOW cpu_to_le32(0xC0000177)
> -#define STATUS_NO_MEDIA cpu_to_le32(0xC0000178)
> -#define STATUS_NO_SUCH_MEMBER cpu_to_le32(0xC000017A)
> -#define STATUS_INVALID_MEMBER cpu_to_le32(0xC000017B)
> -#define STATUS_KEY_DELETED cpu_to_le32(0xC000017C)
> -#define STATUS_NO_LOG_SPACE cpu_to_le32(0xC000017D)
> -#define STATUS_TOO_MANY_SIDS cpu_to_le32(0xC000017E)
> -#define STATUS_LM_CROSS_ENCRYPTION_REQUIRED cpu_to_le32(0xC000017F)
> -#define STATUS_KEY_HAS_CHILDREN cpu_to_le32(0xC0000180)
> -#define STATUS_CHILD_MUST_BE_VOLATILE cpu_to_le32(0xC0000181)
> -#define STATUS_DEVICE_CONFIGURATION_ERROR cpu_to_le32(0xC0000182)
> -#define STATUS_DRIVER_INTERNAL_ERROR cpu_to_le32(0xC0000183)
> -#define STATUS_INVALID_DEVICE_STATE cpu_to_le32(0xC0000184)
> -#define STATUS_IO_DEVICE_ERROR cpu_to_le32(0xC0000185)
> -#define STATUS_DEVICE_PROTOCOL_ERROR cpu_to_le32(0xC0000186)
> -#define STATUS_BACKUP_CONTROLLER cpu_to_le32(0xC0000187)
> -#define STATUS_LOG_FILE_FULL cpu_to_le32(0xC0000188)
> -#define STATUS_TOO_LATE cpu_to_le32(0xC0000189)
> -#define STATUS_NO_TRUST_LSA_SECRET cpu_to_le32(0xC000018A)
> -#define STATUS_NO_TRUST_SAM_ACCOUNT cpu_to_le32(0xC000018B)
> -#define STATUS_TRUSTED_DOMAIN_FAILURE cpu_to_le32(0xC000018C)
> -#define STATUS_TRUSTED_RELATIONSHIP_FAILURE cpu_to_le32(0xC000018D)
> -#define STATUS_EVENTLOG_FILE_CORRUPT cpu_to_le32(0xC000018E)
> -#define STATUS_EVENTLOG_CANT_START cpu_to_le32(0xC000018F)
> -#define STATUS_TRUST_FAILURE cpu_to_le32(0xC0000190)
> -#define STATUS_MUTANT_LIMIT_EXCEEDED cpu_to_le32(0xC0000191)
> -#define STATUS_NETLOGON_NOT_STARTED cpu_to_le32(0xC0000192)
> -#define STATUS_ACCOUNT_EXPIRED cpu_to_le32(0xC0000193)
> -#define STATUS_POSSIBLE_DEADLOCK cpu_to_le32(0xC0000194)
> -#define STATUS_NETWORK_CREDENTIAL_CONFLICT cpu_to_le32(0xC0000195)
> -#define STATUS_REMOTE_SESSION_LIMIT cpu_to_le32(0xC0000196)
> -#define STATUS_EVENTLOG_FILE_CHANGED cpu_to_le32(0xC0000197)
> -#define STATUS_NOLOGON_INTERDOMAIN_TRUST_ACCOUNT cpu_to_le32(0xC0000198)
> -#define STATUS_NOLOGON_WORKSTATION_TRUST_ACCOUNT cpu_to_le32(0xC0000199)
> -#define STATUS_NOLOGON_SERVER_TRUST_ACCOUNT cpu_to_le32(0xC000019A)
> -#define STATUS_DOMAIN_TRUST_INCONSISTENT cpu_to_le32(0xC000019B)
> -#define STATUS_FS_DRIVER_REQUIRED cpu_to_le32(0xC000019C)
> -#define STATUS_IMAGE_ALREADY_LOADED_AS_DLL cpu_to_le32(0xC000019D)
> -#define STATUS_NETWORK_OPEN_RESTRICTION cpu_to_le32(0xC0000201)
> -#define STATUS_NO_USER_SESSION_KEY cpu_to_le32(0xC0000202)
> -#define STATUS_USER_SESSION_DELETED cpu_to_le32(0xC0000203)
> -#define STATUS_RESOURCE_LANG_NOT_FOUND cpu_to_le32(0xC0000204)
> -#define STATUS_INSUFF_SERVER_RESOURCES cpu_to_le32(0xC0000205)
> -#define STATUS_INVALID_BUFFER_SIZE cpu_to_le32(0xC0000206)
> -#define STATUS_INVALID_ADDRESS_COMPONENT cpu_to_le32(0xC0000207)
> -#define STATUS_INVALID_ADDRESS_WILDCARD cpu_to_le32(0xC0000208)
> -#define STATUS_TOO_MANY_ADDRESSES cpu_to_le32(0xC0000209)
> -#define STATUS_ADDRESS_ALREADY_EXISTS cpu_to_le32(0xC000020A)
> -#define STATUS_ADDRESS_CLOSED cpu_to_le32(0xC000020B)
> -#define STATUS_CONNECTION_DISCONNECTED cpu_to_le32(0xC000020C)
> -#define STATUS_CONNECTION_RESET cpu_to_le32(0xC000020D)
> -#define STATUS_TOO_MANY_NODES cpu_to_le32(0xC000020E)
> -#define STATUS_TRANSACTION_ABORTED cpu_to_le32(0xC000020F)
> -#define STATUS_TRANSACTION_TIMED_OUT cpu_to_le32(0xC0000210)
> -#define STATUS_TRANSACTION_NO_RELEASE cpu_to_le32(0xC0000211)
> -#define STATUS_TRANSACTION_NO_MATCH cpu_to_le32(0xC0000212)
> -#define STATUS_TRANSACTION_RESPONDED cpu_to_le32(0xC0000213)
> -#define STATUS_TRANSACTION_INVALID_ID cpu_to_le32(0xC0000214)
> -#define STATUS_TRANSACTION_INVALID_TYPE cpu_to_le32(0xC0000215)
> -#define STATUS_NOT_SERVER_SESSION cpu_to_le32(0xC0000216)
> -#define STATUS_NOT_CLIENT_SESSION cpu_to_le32(0xC0000217)
> -#define STATUS_CANNOT_LOAD_REGISTRY_FILE cpu_to_le32(0xC0000218)
> -#define STATUS_DEBUG_ATTACH_FAILED cpu_to_le32(0xC0000219)
> -#define STATUS_SYSTEM_PROCESS_TERMINATED cpu_to_le32(0xC000021A)
> -#define STATUS_DATA_NOT_ACCEPTED cpu_to_le32(0xC000021B)
> -#define STATUS_NO_BROWSER_SERVERS_FOUND cpu_to_le32(0xC000021C)
> -#define STATUS_VDM_HARD_ERROR cpu_to_le32(0xC000021D)
> -#define STATUS_DRIVER_CANCEL_TIMEOUT cpu_to_le32(0xC000021E)
> -#define STATUS_REPLY_MESSAGE_MISMATCH cpu_to_le32(0xC000021F)
> -#define STATUS_MAPPED_ALIGNMENT cpu_to_le32(0xC0000220)
> -#define STATUS_IMAGE_CHECKSUM_MISMATCH cpu_to_le32(0xC0000221)
> -#define STATUS_LOST_WRITEBEHIND_DATA cpu_to_le32(0xC0000222)
> -#define STATUS_CLIENT_SERVER_PARAMETERS_INVALID cpu_to_le32(0xC0000223)
> -#define STATUS_PASSWORD_MUST_CHANGE cpu_to_le32(0xC0000224)
> -#define STATUS_NOT_FOUND cpu_to_le32(0xC0000225)
> -#define STATUS_NOT_TINY_STREAM cpu_to_le32(0xC0000226)
> -#define STATUS_RECOVERY_FAILURE cpu_to_le32(0xC0000227)
> -#define STATUS_STACK_OVERFLOW_READ cpu_to_le32(0xC0000228)
> -#define STATUS_FAIL_CHECK cpu_to_le32(0xC0000229)
> -#define STATUS_DUPLICATE_OBJECTID cpu_to_le32(0xC000022A)
> -#define STATUS_OBJECTID_EXISTS cpu_to_le32(0xC000022B)
> -#define STATUS_CONVERT_TO_LARGE cpu_to_le32(0xC000022C)
> -#define STATUS_RETRY cpu_to_le32(0xC000022D)
> -#define STATUS_FOUND_OUT_OF_SCOPE cpu_to_le32(0xC000022E)
> -#define STATUS_ALLOCATE_BUCKET cpu_to_le32(0xC000022F)
> -#define STATUS_PROPSET_NOT_FOUND cpu_to_le32(0xC0000230)
> -#define STATUS_MARSHALL_OVERFLOW cpu_to_le32(0xC0000231)
> -#define STATUS_INVALID_VARIANT cpu_to_le32(0xC0000232)
> -#define STATUS_DOMAIN_CONTROLLER_NOT_FOUND cpu_to_le32(0xC0000233)
> -#define STATUS_ACCOUNT_LOCKED_OUT cpu_to_le32(0xC0000234)
> -#define STATUS_HANDLE_NOT_CLOSABLE cpu_to_le32(0xC0000235)
> -#define STATUS_CONNECTION_REFUSED cpu_to_le32(0xC0000236)
> -#define STATUS_GRACEFUL_DISCONNECT cpu_to_le32(0xC0000237)
> -#define STATUS_ADDRESS_ALREADY_ASSOCIATED cpu_to_le32(0xC0000238)
> -#define STATUS_ADDRESS_NOT_ASSOCIATED cpu_to_le32(0xC0000239)
> -#define STATUS_CONNECTION_INVALID cpu_to_le32(0xC000023A)
> -#define STATUS_CONNECTION_ACTIVE cpu_to_le32(0xC000023B)
> -#define STATUS_NETWORK_UNREACHABLE cpu_to_le32(0xC000023C)
> -#define STATUS_HOST_UNREACHABLE cpu_to_le32(0xC000023D)
> -#define STATUS_PROTOCOL_UNREACHABLE cpu_to_le32(0xC000023E)
> -#define STATUS_PORT_UNREACHABLE cpu_to_le32(0xC000023F)
> -#define STATUS_REQUEST_ABORTED cpu_to_le32(0xC0000240)
> -#define STATUS_CONNECTION_ABORTED cpu_to_le32(0xC0000241)
> -#define STATUS_BAD_COMPRESSION_BUFFER cpu_to_le32(0xC0000242)
> -#define STATUS_USER_MAPPED_FILE cpu_to_le32(0xC0000243)
> -#define STATUS_AUDIT_FAILED cpu_to_le32(0xC0000244)
> -#define STATUS_TIMER_RESOLUTION_NOT_SET cpu_to_le32(0xC0000245)
> -#define STATUS_CONNECTION_COUNT_LIMIT cpu_to_le32(0xC0000246)
> -#define STATUS_LOGIN_TIME_RESTRICTION cpu_to_le32(0xC0000247)
> -#define STATUS_LOGIN_WKSTA_RESTRICTION cpu_to_le32(0xC0000248)
> -#define STATUS_IMAGE_MP_UP_MISMATCH cpu_to_le32(0xC0000249)
> -#define STATUS_INSUFFICIENT_LOGON_INFO cpu_to_le32(0xC0000250)
> -#define STATUS_BAD_DLL_ENTRYPOINT cpu_to_le32(0xC0000251)
> -#define STATUS_BAD_SERVICE_ENTRYPOINT cpu_to_le32(0xC0000252)
> -#define STATUS_LPC_REPLY_LOST cpu_to_le32(0xC0000253)
> -#define STATUS_IP_ADDRESS_CONFLICT1 cpu_to_le32(0xC0000254)
> -#define STATUS_IP_ADDRESS_CONFLICT2 cpu_to_le32(0xC0000255)
> -#define STATUS_REGISTRY_QUOTA_LIMIT cpu_to_le32(0xC0000256)
> -#define STATUS_PATH_NOT_COVERED cpu_to_le32(0xC0000257)
> -#define STATUS_NO_CALLBACK_ACTIVE cpu_to_le32(0xC0000258)
> -#define STATUS_LICENSE_QUOTA_EXCEEDED cpu_to_le32(0xC0000259)
> -#define STATUS_PWD_TOO_SHORT cpu_to_le32(0xC000025A)
> -#define STATUS_PWD_TOO_RECENT cpu_to_le32(0xC000025B)
> -#define STATUS_PWD_HISTORY_CONFLICT cpu_to_le32(0xC000025C)
> -#define STATUS_PLUGPLAY_NO_DEVICE cpu_to_le32(0xC000025E)
> -#define STATUS_UNSUPPORTED_COMPRESSION cpu_to_le32(0xC000025F)
> -#define STATUS_INVALID_HW_PROFILE cpu_to_le32(0xC0000260)
> -#define STATUS_INVALID_PLUGPLAY_DEVICE_PATH cpu_to_le32(0xC0000261)
> -#define STATUS_DRIVER_ORDINAL_NOT_FOUND cpu_to_le32(0xC0000262)
> -#define STATUS_DRIVER_ENTRYPOINT_NOT_FOUND cpu_to_le32(0xC0000263)
> -#define STATUS_RESOURCE_NOT_OWNED cpu_to_le32(0xC0000264)
> -#define STATUS_TOO_MANY_LINKS cpu_to_le32(0xC0000265)
> -#define STATUS_QUOTA_LIST_INCONSISTENT cpu_to_le32(0xC0000266)
> -#define STATUS_FILE_IS_OFFLINE cpu_to_le32(0xC0000267)
> -#define STATUS_EVALUATION_EXPIRATION cpu_to_le32(0xC0000268)
> -#define STATUS_ILLEGAL_DLL_RELOCATION cpu_to_le32(0xC0000269)
> -#define STATUS_LICENSE_VIOLATION cpu_to_le32(0xC000026A)
> -#define STATUS_DLL_INIT_FAILED_LOGOFF cpu_to_le32(0xC000026B)
> -#define STATUS_DRIVER_UNABLE_TO_LOAD cpu_to_le32(0xC000026C)
> -#define STATUS_DFS_UNAVAILABLE cpu_to_le32(0xC000026D)
> -#define STATUS_VOLUME_DISMOUNTED cpu_to_le32(0xC000026E)
> -#define STATUS_WX86_INTERNAL_ERROR cpu_to_le32(0xC000026F)
> -#define STATUS_WX86_FLOAT_STACK_CHECK cpu_to_le32(0xC0000270)
> -#define STATUS_VALIDATE_CONTINUE cpu_to_le32(0xC0000271)
> -#define STATUS_NO_MATCH cpu_to_le32(0xC0000272)
> -#define STATUS_NO_MORE_MATCHES cpu_to_le32(0xC0000273)
> -#define STATUS_NOT_A_REPARSE_POINT cpu_to_le32(0xC0000275)
> -#define STATUS_IO_REPARSE_TAG_INVALID cpu_to_le32(0xC0000276)
> -#define STATUS_IO_REPARSE_TAG_MISMATCH cpu_to_le32(0xC0000277)
> -#define STATUS_IO_REPARSE_DATA_INVALID cpu_to_le32(0xC0000278)
> -#define STATUS_IO_REPARSE_TAG_NOT_HANDLED cpu_to_le32(0xC0000279)
> -#define STATUS_REPARSE_POINT_NOT_RESOLVED cpu_to_le32(0xC0000280)
> -#define STATUS_DIRECTORY_IS_A_REPARSE_POINT cpu_to_le32(0xC0000281)
> -#define STATUS_RANGE_LIST_CONFLICT cpu_to_le32(0xC0000282)
> -#define STATUS_SOURCE_ELEMENT_EMPTY cpu_to_le32(0xC0000283)
> -#define STATUS_DESTINATION_ELEMENT_FULL cpu_to_le32(0xC0000284)
> -#define STATUS_ILLEGAL_ELEMENT_ADDRESS cpu_to_le32(0xC0000285)
> -#define STATUS_MAGAZINE_NOT_PRESENT cpu_to_le32(0xC0000286)
> -#define STATUS_REINITIALIZATION_NEEDED cpu_to_le32(0xC0000287)
> -#define STATUS_ENCRYPTION_FAILED cpu_to_le32(0xC000028A)
> -#define STATUS_DECRYPTION_FAILED cpu_to_le32(0xC000028B)
> -#define STATUS_RANGE_NOT_FOUND cpu_to_le32(0xC000028C)
> -#define STATUS_NO_RECOVERY_POLICY cpu_to_le32(0xC000028D)
> -#define STATUS_NO_EFS cpu_to_le32(0xC000028E)
> -#define STATUS_WRONG_EFS cpu_to_le32(0xC000028F)
> -#define STATUS_NO_USER_KEYS cpu_to_le32(0xC0000290)
> -#define STATUS_FILE_NOT_ENCRYPTED cpu_to_le32(0xC0000291)
> -#define STATUS_NOT_EXPORT_FORMAT cpu_to_le32(0xC0000292)
> -#define STATUS_FILE_ENCRYPTED cpu_to_le32(0xC0000293)
> -#define STATUS_WMI_GUID_NOT_FOUND cpu_to_le32(0xC0000295)
> -#define STATUS_WMI_INSTANCE_NOT_FOUND cpu_to_le32(0xC0000296)
> -#define STATUS_WMI_ITEMID_NOT_FOUND cpu_to_le32(0xC0000297)
> -#define STATUS_WMI_TRY_AGAIN cpu_to_le32(0xC0000298)
> -#define STATUS_SHARED_POLICY cpu_to_le32(0xC0000299)
> -#define STATUS_POLICY_OBJECT_NOT_FOUND cpu_to_le32(0xC000029A)
> -#define STATUS_POLICY_ONLY_IN_DS cpu_to_le32(0xC000029B)
> -#define STATUS_VOLUME_NOT_UPGRADED cpu_to_le32(0xC000029C)
> -#define STATUS_REMOTE_STORAGE_NOT_ACTIVE cpu_to_le32(0xC000029D)
> -#define STATUS_REMOTE_STORAGE_MEDIA_ERROR cpu_to_le32(0xC000029E)
> -#define STATUS_NO_TRACKING_SERVICE cpu_to_le32(0xC000029F)
> -#define STATUS_SERVER_SID_MISMATCH cpu_to_le32(0xC00002A0)
> -#define STATUS_DS_NO_ATTRIBUTE_OR_VALUE cpu_to_le32(0xC00002A1)
> -#define STATUS_DS_INVALID_ATTRIBUTE_SYNTAX cpu_to_le32(0xC00002A2)
> -#define STATUS_DS_ATTRIBUTE_TYPE_UNDEFINED cpu_to_le32(0xC00002A3)
> -#define STATUS_DS_ATTRIBUTE_OR_VALUE_EXISTS cpu_to_le32(0xC00002A4)
> -#define STATUS_DS_BUSY cpu_to_le32(0xC00002A5)
> -#define STATUS_DS_UNAVAILABLE cpu_to_le32(0xC00002A6)
> -#define STATUS_DS_NO_RIDS_ALLOCATED cpu_to_le32(0xC00002A7)
> -#define STATUS_DS_NO_MORE_RIDS cpu_to_le32(0xC00002A8)
> -#define STATUS_DS_INCORRECT_ROLE_OWNER cpu_to_le32(0xC00002A9)
> -#define STATUS_DS_RIDMGR_INIT_ERROR cpu_to_le32(0xC00002AA)
> -#define STATUS_DS_OBJ_CLASS_VIOLATION cpu_to_le32(0xC00002AB)
> -#define STATUS_DS_CANT_ON_NON_LEAF cpu_to_le32(0xC00002AC)
> -#define STATUS_DS_CANT_ON_RDN cpu_to_le32(0xC00002AD)
> -#define STATUS_DS_CANT_MOD_OBJ_CLASS cpu_to_le32(0xC00002AE)
> -#define STATUS_DS_CROSS_DOM_MOVE_FAILED cpu_to_le32(0xC00002AF)
> -#define STATUS_DS_GC_NOT_AVAILABLE cpu_to_le32(0xC00002B0)
> -#define STATUS_DIRECTORY_SERVICE_REQUIRED cpu_to_le32(0xC00002B1)
> -#define STATUS_REPARSE_ATTRIBUTE_CONFLICT cpu_to_le32(0xC00002B2)
> -#define STATUS_CANT_ENABLE_DENY_ONLY cpu_to_le32(0xC00002B3)
> -#define STATUS_FLOAT_MULTIPLE_FAULTS cpu_to_le32(0xC00002B4)
> -#define STATUS_FLOAT_MULTIPLE_TRAPS cpu_to_le32(0xC00002B5)
> -#define STATUS_DEVICE_REMOVED cpu_to_le32(0xC00002B6)
> -#define STATUS_JOURNAL_DELETE_IN_PROGRESS cpu_to_le32(0xC00002B7)
> -#define STATUS_JOURNAL_NOT_ACTIVE cpu_to_le32(0xC00002B8)
> -#define STATUS_NOINTERFACE cpu_to_le32(0xC00002B9)
> -#define STATUS_DS_ADMIN_LIMIT_EXCEEDED cpu_to_le32(0xC00002C1)
> -#define STATUS_DRIVER_FAILED_SLEEP cpu_to_le32(0xC00002C2)
> -#define STATUS_MUTUAL_AUTHENTICATION_FAILED cpu_to_le32(0xC00002C3)
> -#define STATUS_CORRUPT_SYSTEM_FILE cpu_to_le32(0xC00002C4)
> -#define STATUS_DATATYPE_MISALIGNMENT_ERROR cpu_to_le32(0xC00002C5)
> -#define STATUS_WMI_READ_ONLY cpu_to_le32(0xC00002C6)
> -#define STATUS_WMI_SET_FAILURE cpu_to_le32(0xC00002C7)
> -#define STATUS_COMMITMENT_MINIMUM cpu_to_le32(0xC00002C8)
> -#define STATUS_REG_NAT_CONSUMPTION cpu_to_le32(0xC00002C9)
> -#define STATUS_TRANSPORT_FULL cpu_to_le32(0xC00002CA)
> -#define STATUS_DS_SAM_INIT_FAILURE cpu_to_le32(0xC00002CB)
> -#define STATUS_ONLY_IF_CONNECTED cpu_to_le32(0xC00002CC)
> -#define STATUS_DS_SENSITIVE_GROUP_VIOLATION cpu_to_le32(0xC00002CD)
> -#define STATUS_PNP_RESTART_ENUMERATION cpu_to_le32(0xC00002CE)
> -#define STATUS_JOURNAL_ENTRY_DELETED cpu_to_le32(0xC00002CF)
> -#define STATUS_DS_CANT_MOD_PRIMARYGROUPID cpu_to_le32(0xC00002D0)
> -#define STATUS_SYSTEM_IMAGE_BAD_SIGNATURE cpu_to_le32(0xC00002D1)
> -#define STATUS_PNP_REBOOT_REQUIRED cpu_to_le32(0xC00002D2)
> -#define STATUS_POWER_STATE_INVALID cpu_to_le32(0xC00002D3)
> -#define STATUS_DS_INVALID_GROUP_TYPE cpu_to_le32(0xC00002D4)
> -#define STATUS_DS_NO_NEST_GLOBALGROUP_IN_MIXEDDOMAIN cpu_to_le32(0xC0000=
2D5)
> -#define STATUS_DS_NO_NEST_LOCALGROUP_IN_MIXEDDOMAIN cpu_to_le32(0xC00002=
D6)
> -#define STATUS_DS_GLOBAL_CANT_HAVE_LOCAL_MEMBER cpu_to_le32(0xC00002D7)
> -#define STATUS_DS_GLOBAL_CANT_HAVE_UNIVERSAL_MEMBER cpu_to_le32(0xC00002=
D8)
> -#define STATUS_DS_UNIVERSAL_CANT_HAVE_LOCAL_MEMBER cpu_to_le32(0xC00002D=
9)
> -#define STATUS_DS_GLOBAL_CANT_HAVE_CROSSDOMAIN_MEMBER cpu_to_le32(0xC000=
02DA)
> -#define STATUS_DS_LOCAL_CANT_HAVE_CROSSDOMAIN_LOCAL_MEMBER     \
> -       cpu_to_le32(0xC00002DB)
> -#define STATUS_DS_HAVE_PRIMARY_MEMBERS cpu_to_le32(0xC00002DC)
> -#define STATUS_WMI_NOT_SUPPORTED cpu_to_le32(0xC00002DD)
> -#define STATUS_INSUFFICIENT_POWER cpu_to_le32(0xC00002DE)
> -#define STATUS_SAM_NEED_BOOTKEY_PASSWORD cpu_to_le32(0xC00002DF)
> -#define STATUS_SAM_NEED_BOOTKEY_FLOPPY cpu_to_le32(0xC00002E0)
> -#define STATUS_DS_CANT_START cpu_to_le32(0xC00002E1)
> -#define STATUS_DS_INIT_FAILURE cpu_to_le32(0xC00002E2)
> -#define STATUS_SAM_INIT_FAILURE cpu_to_le32(0xC00002E3)
> -#define STATUS_DS_GC_REQUIRED cpu_to_le32(0xC00002E4)
> -#define STATUS_DS_LOCAL_MEMBER_OF_LOCAL_ONLY cpu_to_le32(0xC00002E5)
> -#define STATUS_DS_NO_FPO_IN_UNIVERSAL_GROUPS cpu_to_le32(0xC00002E6)
> -#define STATUS_DS_MACHINE_ACCOUNT_QUOTA_EXCEEDED cpu_to_le32(0xC00002E7)
> -#define STATUS_MULTIPLE_FAULT_VIOLATION cpu_to_le32(0xC00002E8)
> -#define STATUS_CURRENT_DOMAIN_NOT_ALLOWED cpu_to_le32(0xC00002E9)
> -#define STATUS_CANNOT_MAKE cpu_to_le32(0xC00002EA)
> -#define STATUS_SYSTEM_SHUTDOWN cpu_to_le32(0xC00002EB)
> -#define STATUS_DS_INIT_FAILURE_CONSOLE cpu_to_le32(0xC00002EC)
> -#define STATUS_DS_SAM_INIT_FAILURE_CONSOLE cpu_to_le32(0xC00002ED)
> -#define STATUS_UNFINISHED_CONTEXT_DELETED cpu_to_le32(0xC00002EE)
> -#define STATUS_NO_TGT_REPLY cpu_to_le32(0xC00002EF)
> -#define STATUS_OBJECTID_NOT_FOUND cpu_to_le32(0xC00002F0)
> -#define STATUS_NO_IP_ADDRESSES cpu_to_le32(0xC00002F1)
> -#define STATUS_WRONG_CREDENTIAL_HANDLE cpu_to_le32(0xC00002F2)
> -#define STATUS_CRYPTO_SYSTEM_INVALID cpu_to_le32(0xC00002F3)
> -#define STATUS_MAX_REFERRALS_EXCEEDED cpu_to_le32(0xC00002F4)
> -#define STATUS_MUST_BE_KDC cpu_to_le32(0xC00002F5)
> -#define STATUS_STRONG_CRYPTO_NOT_SUPPORTED cpu_to_le32(0xC00002F6)
> -#define STATUS_TOO_MANY_PRINCIPALS cpu_to_le32(0xC00002F7)
> -#define STATUS_NO_PA_DATA cpu_to_le32(0xC00002F8)
> -#define STATUS_PKINIT_NAME_MISMATCH cpu_to_le32(0xC00002F9)
> -#define STATUS_SMARTCARD_LOGON_REQUIRED cpu_to_le32(0xC00002FA)
> -#define STATUS_KDC_INVALID_REQUEST cpu_to_le32(0xC00002FB)
> -#define STATUS_KDC_UNABLE_TO_REFER cpu_to_le32(0xC00002FC)
> -#define STATUS_KDC_UNKNOWN_ETYPE cpu_to_le32(0xC00002FD)
> -#define STATUS_SHUTDOWN_IN_PROGRESS cpu_to_le32(0xC00002FE)
> -#define STATUS_SERVER_SHUTDOWN_IN_PROGRESS cpu_to_le32(0xC00002FF)
> -#define STATUS_NOT_SUPPORTED_ON_SBS cpu_to_le32(0xC0000300)
> -#define STATUS_WMI_GUID_DISCONNECTED cpu_to_le32(0xC0000301)
> -#define STATUS_WMI_ALREADY_DISABLED cpu_to_le32(0xC0000302)
> -#define STATUS_WMI_ALREADY_ENABLED cpu_to_le32(0xC0000303)
> -#define STATUS_MFT_TOO_FRAGMENTED cpu_to_le32(0xC0000304)
> -#define STATUS_COPY_PROTECTION_FAILURE cpu_to_le32(0xC0000305)
> -#define STATUS_CSS_AUTHENTICATION_FAILURE cpu_to_le32(0xC0000306)
> -#define STATUS_CSS_KEY_NOT_PRESENT cpu_to_le32(0xC0000307)
> -#define STATUS_CSS_KEY_NOT_ESTABLISHED cpu_to_le32(0xC0000308)
> -#define STATUS_CSS_SCRAMBLED_SECTOR cpu_to_le32(0xC0000309)
> -#define STATUS_CSS_REGION_MISMATCH cpu_to_le32(0xC000030A)
> -#define STATUS_CSS_RESETS_EXHAUSTED cpu_to_le32(0xC000030B)
> -#define STATUS_PKINIT_FAILURE cpu_to_le32(0xC0000320)
> -#define STATUS_SMARTCARD_SUBSYSTEM_FAILURE cpu_to_le32(0xC0000321)
> -#define STATUS_NO_KERB_KEY cpu_to_le32(0xC0000322)
> -#define STATUS_HOST_DOWN cpu_to_le32(0xC0000350)
> -#define STATUS_UNSUPPORTED_PREAUTH cpu_to_le32(0xC0000351)
> -#define STATUS_EFS_ALG_BLOB_TOO_BIG cpu_to_le32(0xC0000352)
> -#define STATUS_PORT_NOT_SET cpu_to_le32(0xC0000353)
> -#define STATUS_DEBUGGER_INACTIVE cpu_to_le32(0xC0000354)
> -#define STATUS_DS_VERSION_CHECK_FAILURE cpu_to_le32(0xC0000355)
> -#define STATUS_AUDITING_DISABLED cpu_to_le32(0xC0000356)
> -#define STATUS_PRENT4_MACHINE_ACCOUNT cpu_to_le32(0xC0000357)
> -#define STATUS_DS_AG_CANT_HAVE_UNIVERSAL_MEMBER cpu_to_le32(0xC0000358)
> -#define STATUS_INVALID_IMAGE_WIN_32 cpu_to_le32(0xC0000359)
> -#define STATUS_INVALID_IMAGE_WIN_64 cpu_to_le32(0xC000035A)
> -#define STATUS_BAD_BINDINGS cpu_to_le32(0xC000035B)
> -#define STATUS_NETWORK_SESSION_EXPIRED cpu_to_le32(0xC000035C)
> -#define STATUS_APPHELP_BLOCK cpu_to_le32(0xC000035D)
> -#define STATUS_ALL_SIDS_FILTERED cpu_to_le32(0xC000035E)
> -#define STATUS_NOT_SAFE_MODE_DRIVER cpu_to_le32(0xC000035F)
> -#define STATUS_ACCESS_DISABLED_BY_POLICY_DEFAULT cpu_to_le32(0xC0000361)
> -#define STATUS_ACCESS_DISABLED_BY_POLICY_PATH cpu_to_le32(0xC0000362)
> -#define STATUS_ACCESS_DISABLED_BY_POLICY_PUBLISHER cpu_to_le32(0xC000036=
3)
> -#define STATUS_ACCESS_DISABLED_BY_POLICY_OTHER cpu_to_le32(0xC0000364)
> -#define STATUS_FAILED_DRIVER_ENTRY cpu_to_le32(0xC0000365)
> -#define STATUS_DEVICE_ENUMERATION_ERROR cpu_to_le32(0xC0000366)
> -#define STATUS_MOUNT_POINT_NOT_RESOLVED cpu_to_le32(0xC0000368)
> -#define STATUS_INVALID_DEVICE_OBJECT_PARAMETER cpu_to_le32(0xC0000369)
> -#define STATUS_MCA_OCCURRED cpu_to_le32(0xC000036A)
> -#define STATUS_DRIVER_BLOCKED_CRITICAL cpu_to_le32(0xC000036B)
> -#define STATUS_DRIVER_BLOCKED cpu_to_le32(0xC000036C)
> -#define STATUS_DRIVER_DATABASE_ERROR cpu_to_le32(0xC000036D)
> -#define STATUS_SYSTEM_HIVE_TOO_LARGE cpu_to_le32(0xC000036E)
> -#define STATUS_INVALID_IMPORT_OF_NON_DLL cpu_to_le32(0xC000036F)
> -#define STATUS_NO_SECRETS cpu_to_le32(0xC0000371)
> -#define STATUS_ACCESS_DISABLED_NO_SAFER_UI_BY_POLICY cpu_to_le32(0xC0000=
372)
> -#define STATUS_FAILED_STACK_SWITCH cpu_to_le32(0xC0000373)
> -#define STATUS_HEAP_CORRUPTION cpu_to_le32(0xC0000374)
> -#define STATUS_SMARTCARD_WRONG_PIN cpu_to_le32(0xC0000380)
> -#define STATUS_SMARTCARD_CARD_BLOCKED cpu_to_le32(0xC0000381)
> -#define STATUS_SMARTCARD_CARD_NOT_AUTHENTICATED cpu_to_le32(0xC0000382)
> -#define STATUS_SMARTCARD_NO_CARD cpu_to_le32(0xC0000383)
> -#define STATUS_SMARTCARD_NO_KEY_CONTAINER cpu_to_le32(0xC0000384)
> -#define STATUS_SMARTCARD_NO_CERTIFICATE cpu_to_le32(0xC0000385)
> -#define STATUS_SMARTCARD_NO_KEYSET cpu_to_le32(0xC0000386)
> -#define STATUS_SMARTCARD_IO_ERROR cpu_to_le32(0xC0000387)
> -#define STATUS_DOWNGRADE_DETECTED cpu_to_le32(0xC0000388)
> -#define STATUS_SMARTCARD_CERT_REVOKED cpu_to_le32(0xC0000389)
> -#define STATUS_ISSUING_CA_UNTRUSTED cpu_to_le32(0xC000038A)
> -#define STATUS_REVOCATION_OFFLINE_C cpu_to_le32(0xC000038B)
> -#define STATUS_PKINIT_CLIENT_FAILURE cpu_to_le32(0xC000038C)
> -#define STATUS_SMARTCARD_CERT_EXPIRED cpu_to_le32(0xC000038D)
> -#define STATUS_DRIVER_FAILED_PRIOR_UNLOAD cpu_to_le32(0xC000038E)
> -#define STATUS_SMARTCARD_SILENT_CONTEXT cpu_to_le32(0xC000038F)
> -#define STATUS_PER_USER_TRUST_QUOTA_EXCEEDED cpu_to_le32(0xC0000401)
> -#define STATUS_ALL_USER_TRUST_QUOTA_EXCEEDED cpu_to_le32(0xC0000402)
> -#define STATUS_USER_DELETE_TRUST_QUOTA_EXCEEDED cpu_to_le32(0xC0000403)
> -#define STATUS_DS_NAME_NOT_UNIQUE cpu_to_le32(0xC0000404)
> -#define STATUS_DS_DUPLICATE_ID_FOUND cpu_to_le32(0xC0000405)
> -#define STATUS_DS_GROUP_CONVERSION_ERROR cpu_to_le32(0xC0000406)
> -#define STATUS_VOLSNAP_PREPARE_HIBERNATE cpu_to_le32(0xC0000407)
> -#define STATUS_USER2USER_REQUIRED cpu_to_le32(0xC0000408)
> -#define STATUS_STACK_BUFFER_OVERRUN cpu_to_le32(0xC0000409)
> -#define STATUS_NO_S4U_PROT_SUPPORT cpu_to_le32(0xC000040A)
> -#define STATUS_CROSSREALM_DELEGATION_FAILURE cpu_to_le32(0xC000040B)
> -#define STATUS_REVOCATION_OFFLINE_KDC cpu_to_le32(0xC000040C)
> -#define STATUS_ISSUING_CA_UNTRUSTED_KDC cpu_to_le32(0xC000040D)
> -#define STATUS_KDC_CERT_EXPIRED cpu_to_le32(0xC000040E)
> -#define STATUS_KDC_CERT_REVOKED cpu_to_le32(0xC000040F)
> -#define STATUS_PARAMETER_QUOTA_EXCEEDED cpu_to_le32(0xC0000410)
> -#define STATUS_HIBERNATION_FAILURE cpu_to_le32(0xC0000411)
> -#define STATUS_DELAY_LOAD_FAILED cpu_to_le32(0xC0000412)
> -#define STATUS_AUTHENTICATION_FIREWALL_FAILED cpu_to_le32(0xC0000413)
> -#define STATUS_VDM_DISALLOWED cpu_to_le32(0xC0000414)
> -#define STATUS_HUNG_DISPLAY_DRIVER_THREAD cpu_to_le32(0xC0000415)
> -#define STATUS_INSUFFICIENT_RESOURCE_FOR_SPECIFIED_SHARED_SECTION_SIZE \
> -       cpu_to_le32(0xC0000416)
> -#define STATUS_INVALID_CRUNTIME_PARAMETER cpu_to_le32(0xC0000417)
> -#define STATUS_NTLM_BLOCKED cpu_to_le32(0xC0000418)
> -#define STATUS_ASSERTION_FAILURE cpu_to_le32(0xC0000420)
> -#define STATUS_VERIFIER_STOP cpu_to_le32(0xC0000421)
> -#define STATUS_CALLBACK_POP_STACK cpu_to_le32(0xC0000423)
> -#define STATUS_INCOMPATIBLE_DRIVER_BLOCKED cpu_to_le32(0xC0000424)
> -#define STATUS_HIVE_UNLOADED cpu_to_le32(0xC0000425)
> -#define STATUS_COMPRESSION_DISABLED cpu_to_le32(0xC0000426)
> -#define STATUS_FILE_SYSTEM_LIMITATION cpu_to_le32(0xC0000427)
> -#define STATUS_INVALID_IMAGE_HASH cpu_to_le32(0xC0000428)
> -#define STATUS_NOT_CAPABLE cpu_to_le32(0xC0000429)
> -#define STATUS_REQUEST_OUT_OF_SEQUENCE cpu_to_le32(0xC000042A)
> -#define STATUS_IMPLEMENTATION_LIMIT cpu_to_le32(0xC000042B)
> -#define STATUS_ELEVATION_REQUIRED cpu_to_le32(0xC000042C)
> -#define STATUS_BEYOND_VDL cpu_to_le32(0xC0000432)
> -#define STATUS_ENCOUNTERED_WRITE_IN_PROGRESS cpu_to_le32(0xC0000433)
> -#define STATUS_PTE_CHANGED cpu_to_le32(0xC0000434)
> -#define STATUS_PURGE_FAILED cpu_to_le32(0xC0000435)
> -#define STATUS_CRED_REQUIRES_CONFIRMATION cpu_to_le32(0xC0000440)
> -#define STATUS_CS_ENCRYPTION_INVALID_SERVER_RESPONSE cpu_to_le32(0xC0000=
441)
> -#define STATUS_CS_ENCRYPTION_UNSUPPORTED_SERVER cpu_to_le32(0xC0000442)
> -#define STATUS_CS_ENCRYPTION_EXISTING_ENCRYPTED_FILE cpu_to_le32(0xC0000=
443)
> -#define STATUS_CS_ENCRYPTION_NEW_ENCRYPTED_FILE cpu_to_le32(0xC0000444)
> -#define STATUS_CS_ENCRYPTION_FILE_NOT_CSE cpu_to_le32(0xC0000445)
> -#define STATUS_INVALID_LABEL cpu_to_le32(0xC0000446)
> -#define STATUS_DRIVER_PROCESS_TERMINATED cpu_to_le32(0xC0000450)
> -#define STATUS_AMBIGUOUS_SYSTEM_DEVICE cpu_to_le32(0xC0000451)
> -#define STATUS_SYSTEM_DEVICE_NOT_FOUND cpu_to_le32(0xC0000452)
> -#define STATUS_RESTART_BOOT_APPLICATION cpu_to_le32(0xC0000453)
> -#define STATUS_INVALID_TASK_NAME cpu_to_le32(0xC0000500)
> -#define STATUS_INVALID_TASK_INDEX cpu_to_le32(0xC0000501)
> -#define STATUS_THREAD_ALREADY_IN_TASK cpu_to_le32(0xC0000502)
> -#define STATUS_CALLBACK_BYPASS cpu_to_le32(0xC0000503)
> -#define STATUS_PORT_CLOSED cpu_to_le32(0xC0000700)
> -#define STATUS_MESSAGE_LOST cpu_to_le32(0xC0000701)
> -#define STATUS_INVALID_MESSAGE cpu_to_le32(0xC0000702)
> -#define STATUS_REQUEST_CANCELED cpu_to_le32(0xC0000703)
> -#define STATUS_RECURSIVE_DISPATCH cpu_to_le32(0xC0000704)
> -#define STATUS_LPC_RECEIVE_BUFFER_EXPECTED cpu_to_le32(0xC0000705)
> -#define STATUS_LPC_INVALID_CONNECTION_USAGE cpu_to_le32(0xC0000706)
> -#define STATUS_LPC_REQUESTS_NOT_ALLOWED cpu_to_le32(0xC0000707)
> -#define STATUS_RESOURCE_IN_USE cpu_to_le32(0xC0000708)
> -#define STATUS_HARDWARE_MEMORY_ERROR cpu_to_le32(0xC0000709)
> -#define STATUS_THREADPOOL_HANDLE_EXCEPTION cpu_to_le32(0xC000070A)
> -#define STATUS_THREADPOOL_SET_EVENT_ON_COMPLETION_FAILED cpu_to_le32(0xC=
000070B)
> -#define STATUS_THREADPOOL_RELEASE_SEMAPHORE_ON_COMPLETION_FAILED       \
> -       cpu_to_le32(0xC000070C)
> -#define STATUS_THREADPOOL_RELEASE_MUTEX_ON_COMPLETION_FAILED   \
> -       cpu_to_le32(0xC000070D)
> -#define STATUS_THREADPOOL_FREE_LIBRARY_ON_COMPLETION_FAILED    \
> -       cpu_to_le32(0xC000070E)
> -#define STATUS_THREADPOOL_RELEASED_DURING_OPERATION cpu_to_le32(0xC00007=
0F)
> -#define STATUS_CALLBACK_RETURNED_WHILE_IMPERSONATING cpu_to_le32(0xC0000=
710)
> -#define STATUS_APC_RETURNED_WHILE_IMPERSONATING cpu_to_le32(0xC0000711)
> -#define STATUS_PROCESS_IS_PROTECTED cpu_to_le32(0xC0000712)
> -#define STATUS_MCA_EXCEPTION cpu_to_le32(0xC0000713)
> -#define STATUS_CERTIFICATE_MAPPING_NOT_UNIQUE cpu_to_le32(0xC0000714)
> -#define STATUS_SYMLINK_CLASS_DISABLED cpu_to_le32(0xC0000715)
> -#define STATUS_INVALID_IDN_NORMALIZATION cpu_to_le32(0xC0000716)
> -#define STATUS_NO_UNICODE_TRANSLATION cpu_to_le32(0xC0000717)
> -#define STATUS_ALREADY_REGISTERED cpu_to_le32(0xC0000718)
> -#define STATUS_CONTEXT_MISMATCH cpu_to_le32(0xC0000719)
> -#define STATUS_PORT_ALREADY_HAS_COMPLETION_LIST cpu_to_le32(0xC000071A)
> -#define STATUS_CALLBACK_RETURNED_THREAD_PRIORITY cpu_to_le32(0xC000071B)
> -#define STATUS_INVALID_THREAD cpu_to_le32(0xC000071C)
> -#define STATUS_CALLBACK_RETURNED_TRANSACTION cpu_to_le32(0xC000071D)
> -#define STATUS_CALLBACK_RETURNED_LDR_LOCK cpu_to_le32(0xC000071E)
> -#define STATUS_CALLBACK_RETURNED_LANG cpu_to_le32(0xC000071F)
> -#define STATUS_CALLBACK_RETURNED_PRI_BACK cpu_to_le32(0xC0000720)
> -#define STATUS_CALLBACK_RETURNED_THREAD_AFFINITY cpu_to_le32(0xC0000721)
> -#define STATUS_DISK_REPAIR_DISABLED cpu_to_le32(0xC0000800)
> -#define STATUS_DS_DOMAIN_RENAME_IN_PROGRESS cpu_to_le32(0xC0000801)
> -#define STATUS_DISK_QUOTA_EXCEEDED cpu_to_le32(0xC0000802)
> -#define STATUS_CONTENT_BLOCKED cpu_to_le32(0xC0000804)
> -#define STATUS_BAD_CLUSTERS cpu_to_le32(0xC0000805)
> -#define STATUS_VOLUME_DIRTY cpu_to_le32(0xC0000806)
> -#define STATUS_FILE_CHECKED_OUT cpu_to_le32(0xC0000901)
> -#define STATUS_CHECKOUT_REQUIRED cpu_to_le32(0xC0000902)
> -#define STATUS_BAD_FILE_TYPE cpu_to_le32(0xC0000903)
> -#define STATUS_FILE_TOO_LARGE cpu_to_le32(0xC0000904)
> -#define STATUS_FORMS_AUTH_REQUIRED cpu_to_le32(0xC0000905)
> -#define STATUS_VIRUS_INFECTED cpu_to_le32(0xC0000906)
> -#define STATUS_VIRUS_DELETED cpu_to_le32(0xC0000907)
> -#define STATUS_BAD_MCFG_TABLE cpu_to_le32(0xC0000908)
> -#define STATUS_WOW_ASSERTION cpu_to_le32(0xC0009898)
> -#define STATUS_INVALID_SIGNATURE cpu_to_le32(0xC000A000)
> -#define STATUS_HMAC_NOT_SUPPORTED cpu_to_le32(0xC000A001)
> -#define STATUS_IPSEC_QUEUE_OVERFLOW cpu_to_le32(0xC000A010)
> -#define STATUS_ND_QUEUE_OVERFLOW cpu_to_le32(0xC000A011)
> -#define STATUS_HOPLIMIT_EXCEEDED cpu_to_le32(0xC000A012)
> -#define STATUS_PROTOCOL_NOT_SUPPORTED cpu_to_le32(0xC000A013)
> -#define STATUS_LOST_WRITEBEHIND_DATA_NETWORK_DISCONNECTED      \
> -       cpu_to_le32(0xC000A080)
> -#define STATUS_LOST_WRITEBEHIND_DATA_NETWORK_SERVER_ERROR      \
> -       cpu_to_le32(0xC000A081)
> -#define STATUS_LOST_WRITEBEHIND_DATA_LOCAL_DISK_ERROR cpu_to_le32(0xC000=
A082)
> -#define STATUS_XML_PARSE_ERROR cpu_to_le32(0xC000A083)
> -#define STATUS_XMLDSIG_ERROR cpu_to_le32(0xC000A084)
> -#define STATUS_WRONG_COMPARTMENT cpu_to_le32(0xC000A085)
> -#define STATUS_AUTHIP_FAILURE cpu_to_le32(0xC000A086)
> -#define DBG_NO_STATE_CHANGE cpu_to_le32(0xC0010001)
> -#define DBG_APP_NOT_IDLE cpu_to_le32(0xC0010002)
> -#define RPC_NT_INVALID_STRING_BINDING cpu_to_le32(0xC0020001)
> -#define RPC_NT_WRONG_KIND_OF_BINDING cpu_to_le32(0xC0020002)
> -#define RPC_NT_INVALID_BINDING cpu_to_le32(0xC0020003)
> -#define RPC_NT_PROTSEQ_NOT_SUPPORTED cpu_to_le32(0xC0020004)
> -#define RPC_NT_INVALID_RPC_PROTSEQ cpu_to_le32(0xC0020005)
> -#define RPC_NT_INVALID_STRING_UUID cpu_to_le32(0xC0020006)
> -#define RPC_NT_INVALID_ENDPOINT_FORMAT cpu_to_le32(0xC0020007)
> -#define RPC_NT_INVALID_NET_ADDR cpu_to_le32(0xC0020008)
> -#define RPC_NT_NO_ENDPOINT_FOUND cpu_to_le32(0xC0020009)
> -#define RPC_NT_INVALID_TIMEOUT cpu_to_le32(0xC002000A)
> -#define RPC_NT_OBJECT_NOT_FOUND cpu_to_le32(0xC002000B)
> -#define RPC_NT_ALREADY_REGISTERED cpu_to_le32(0xC002000C)
> -#define RPC_NT_TYPE_ALREADY_REGISTERED cpu_to_le32(0xC002000D)
> -#define RPC_NT_ALREADY_LISTENING cpu_to_le32(0xC002000E)
> -#define RPC_NT_NO_PROTSEQS_REGISTERED cpu_to_le32(0xC002000F)
> -#define RPC_NT_NOT_LISTENING cpu_to_le32(0xC0020010)
> -#define RPC_NT_UNKNOWN_MGR_TYPE cpu_to_le32(0xC0020011)
> -#define RPC_NT_UNKNOWN_IF cpu_to_le32(0xC0020012)
> -#define RPC_NT_NO_BINDINGS cpu_to_le32(0xC0020013)
> -#define RPC_NT_NO_PROTSEQS cpu_to_le32(0xC0020014)
> -#define RPC_NT_CANT_CREATE_ENDPOINT cpu_to_le32(0xC0020015)
> -#define RPC_NT_OUT_OF_RESOURCES cpu_to_le32(0xC0020016)
> -#define RPC_NT_SERVER_UNAVAILABLE cpu_to_le32(0xC0020017)
> -#define RPC_NT_SERVER_TOO_BUSY cpu_to_le32(0xC0020018)
> -#define RPC_NT_INVALID_NETWORK_OPTIONS cpu_to_le32(0xC0020019)
> -#define RPC_NT_NO_CALL_ACTIVE cpu_to_le32(0xC002001A)
> -#define RPC_NT_CALL_FAILED cpu_to_le32(0xC002001B)
> -#define RPC_NT_CALL_FAILED_DNE cpu_to_le32(0xC002001C)
> -#define RPC_NT_PROTOCOL_ERROR cpu_to_le32(0xC002001D)
> -#define RPC_NT_UNSUPPORTED_TRANS_SYN cpu_to_le32(0xC002001F)
> -#define RPC_NT_UNSUPPORTED_TYPE cpu_to_le32(0xC0020021)
> -#define RPC_NT_INVALID_TAG cpu_to_le32(0xC0020022)
> -#define RPC_NT_INVALID_BOUND cpu_to_le32(0xC0020023)
> -#define RPC_NT_NO_ENTRY_NAME cpu_to_le32(0xC0020024)
> -#define RPC_NT_INVALID_NAME_SYNTAX cpu_to_le32(0xC0020025)
> -#define RPC_NT_UNSUPPORTED_NAME_SYNTAX cpu_to_le32(0xC0020026)
> -#define RPC_NT_UUID_NO_ADDRESS cpu_to_le32(0xC0020028)
> -#define RPC_NT_DUPLICATE_ENDPOINT cpu_to_le32(0xC0020029)
> -#define RPC_NT_UNKNOWN_AUTHN_TYPE cpu_to_le32(0xC002002A)
> -#define RPC_NT_MAX_CALLS_TOO_SMALL cpu_to_le32(0xC002002B)
> -#define RPC_NT_STRING_TOO_LONG cpu_to_le32(0xC002002C)
> -#define RPC_NT_PROTSEQ_NOT_FOUND cpu_to_le32(0xC002002D)
> -#define RPC_NT_PROCNUM_OUT_OF_RANGE cpu_to_le32(0xC002002E)
> -#define RPC_NT_BINDING_HAS_NO_AUTH cpu_to_le32(0xC002002F)
> -#define RPC_NT_UNKNOWN_AUTHN_SERVICE cpu_to_le32(0xC0020030)
> -#define RPC_NT_UNKNOWN_AUTHN_LEVEL cpu_to_le32(0xC0020031)
> -#define RPC_NT_INVALID_AUTH_IDENTITY cpu_to_le32(0xC0020032)
> -#define RPC_NT_UNKNOWN_AUTHZ_SERVICE cpu_to_le32(0xC0020033)
> -#define EPT_NT_INVALID_ENTRY cpu_to_le32(0xC0020034)
> -#define EPT_NT_CANT_PERFORM_OP cpu_to_le32(0xC0020035)
> -#define EPT_NT_NOT_REGISTERED cpu_to_le32(0xC0020036)
> -#define RPC_NT_NOTHING_TO_EXPORT cpu_to_le32(0xC0020037)
> -#define RPC_NT_INCOMPLETE_NAME cpu_to_le32(0xC0020038)
> -#define RPC_NT_INVALID_VERS_OPTION cpu_to_le32(0xC0020039)
> -#define RPC_NT_NO_MORE_MEMBERS cpu_to_le32(0xC002003A)
> -#define RPC_NT_NOT_ALL_OBJS_UNEXPORTED cpu_to_le32(0xC002003B)
> -#define RPC_NT_INTERFACE_NOT_FOUND cpu_to_le32(0xC002003C)
> -#define RPC_NT_ENTRY_ALREADY_EXISTS cpu_to_le32(0xC002003D)
> -#define RPC_NT_ENTRY_NOT_FOUND cpu_to_le32(0xC002003E)
> -#define RPC_NT_NAME_SERVICE_UNAVAILABLE cpu_to_le32(0xC002003F)
> -#define RPC_NT_INVALID_NAF_ID cpu_to_le32(0xC0020040)
> -#define RPC_NT_CANNOT_SUPPORT cpu_to_le32(0xC0020041)
> -#define RPC_NT_NO_CONTEXT_AVAILABLE cpu_to_le32(0xC0020042)
> -#define RPC_NT_INTERNAL_ERROR cpu_to_le32(0xC0020043)
> -#define RPC_NT_ZERO_DIVIDE cpu_to_le32(0xC0020044)
> -#define RPC_NT_ADDRESS_ERROR cpu_to_le32(0xC0020045)
> -#define RPC_NT_FP_DIV_ZERO cpu_to_le32(0xC0020046)
> -#define RPC_NT_FP_UNDERFLOW cpu_to_le32(0xC0020047)
> -#define RPC_NT_FP_OVERFLOW cpu_to_le32(0xC0020048)
> -#define RPC_NT_CALL_IN_PROGRESS cpu_to_le32(0xC0020049)
> -#define RPC_NT_NO_MORE_BINDINGS cpu_to_le32(0xC002004A)
> -#define RPC_NT_GROUP_MEMBER_NOT_FOUND cpu_to_le32(0xC002004B)
> -#define EPT_NT_CANT_CREATE cpu_to_le32(0xC002004C)
> -#define RPC_NT_INVALID_OBJECT cpu_to_le32(0xC002004D)
> -#define RPC_NT_NO_INTERFACES cpu_to_le32(0xC002004F)
> -#define RPC_NT_CALL_CANCELLED cpu_to_le32(0xC0020050)
> -#define RPC_NT_BINDING_INCOMPLETE cpu_to_le32(0xC0020051)
> -#define RPC_NT_COMM_FAILURE cpu_to_le32(0xC0020052)
> -#define RPC_NT_UNSUPPORTED_AUTHN_LEVEL cpu_to_le32(0xC0020053)
> -#define RPC_NT_NO_PRINC_NAME cpu_to_le32(0xC0020054)
> -#define RPC_NT_NOT_RPC_ERROR cpu_to_le32(0xC0020055)
> -#define RPC_NT_SEC_PKG_ERROR cpu_to_le32(0xC0020057)
> -#define RPC_NT_NOT_CANCELLED cpu_to_le32(0xC0020058)
> -#define RPC_NT_INVALID_ASYNC_HANDLE cpu_to_le32(0xC0020062)
> -#define RPC_NT_INVALID_ASYNC_CALL cpu_to_le32(0xC0020063)
> -#define RPC_NT_PROXY_ACCESS_DENIED cpu_to_le32(0xC0020064)
> -#define RPC_NT_NO_MORE_ENTRIES cpu_to_le32(0xC0030001)
> -#define RPC_NT_SS_CHAR_TRANS_OPEN_FAIL cpu_to_le32(0xC0030002)
> -#define RPC_NT_SS_CHAR_TRANS_SHORT_FILE cpu_to_le32(0xC0030003)
> -#define RPC_NT_SS_IN_NULL_CONTEXT cpu_to_le32(0xC0030004)
> -#define RPC_NT_SS_CONTEXT_MISMATCH cpu_to_le32(0xC0030005)
> -#define RPC_NT_SS_CONTEXT_DAMAGED cpu_to_le32(0xC0030006)
> -#define RPC_NT_SS_HANDLES_MISMATCH cpu_to_le32(0xC0030007)
> -#define RPC_NT_SS_CANNOT_GET_CALL_HANDLE cpu_to_le32(0xC0030008)
> -#define RPC_NT_NULL_REF_POINTER cpu_to_le32(0xC0030009)
> -#define RPC_NT_ENUM_VALUE_OUT_OF_RANGE cpu_to_le32(0xC003000A)
> -#define RPC_NT_BYTE_COUNT_TOO_SMALL cpu_to_le32(0xC003000B)
> -#define RPC_NT_BAD_STUB_DATA cpu_to_le32(0xC003000C)
> -#define RPC_NT_INVALID_ES_ACTION cpu_to_le32(0xC0030059)
> -#define RPC_NT_WRONG_ES_VERSION cpu_to_le32(0xC003005A)
> -#define RPC_NT_WRONG_STUB_VERSION cpu_to_le32(0xC003005B)
> -#define RPC_NT_INVALID_PIPE_OBJECT cpu_to_le32(0xC003005C)
> -#define RPC_NT_INVALID_PIPE_OPERATION cpu_to_le32(0xC003005D)
> -#define RPC_NT_WRONG_PIPE_VERSION cpu_to_le32(0xC003005E)
> -#define RPC_NT_PIPE_CLOSED cpu_to_le32(0xC003005F)
> -#define RPC_NT_PIPE_DISCIPLINE_ERROR cpu_to_le32(0xC0030060)
> -#define RPC_NT_PIPE_EMPTY cpu_to_le32(0xC0030061)
> -#define STATUS_PNP_BAD_MPS_TABLE cpu_to_le32(0xC0040035)
> -#define STATUS_PNP_TRANSLATION_FAILED cpu_to_le32(0xC0040036)
> -#define STATUS_PNP_IRQ_TRANSLATION_FAILED cpu_to_le32(0xC0040037)
> -#define STATUS_PNP_INVALID_ID cpu_to_le32(0xC0040038)
> -#define STATUS_IO_REISSUE_AS_CACHED cpu_to_le32(0xC0040039)
> -#define STATUS_CTX_WINSTATION_NAME_INVALID cpu_to_le32(0xC00A0001)
> -#define STATUS_CTX_INVALID_PD cpu_to_le32(0xC00A0002)
> -#define STATUS_CTX_PD_NOT_FOUND cpu_to_le32(0xC00A0003)
> -#define STATUS_CTX_CLOSE_PENDING cpu_to_le32(0xC00A0006)
> -#define STATUS_CTX_NO_OUTBUF cpu_to_le32(0xC00A0007)
> -#define STATUS_CTX_MODEM_INF_NOT_FOUND cpu_to_le32(0xC00A0008)
> -#define STATUS_CTX_INVALID_MODEMNAME cpu_to_le32(0xC00A0009)
> -#define STATUS_CTX_RESPONSE_ERROR cpu_to_le32(0xC00A000A)
> -#define STATUS_CTX_MODEM_RESPONSE_TIMEOUT cpu_to_le32(0xC00A000B)
> -#define STATUS_CTX_MODEM_RESPONSE_NO_CARRIER cpu_to_le32(0xC00A000C)
> -#define STATUS_CTX_MODEM_RESPONSE_NO_DIALTONE cpu_to_le32(0xC00A000D)
> -#define STATUS_CTX_MODEM_RESPONSE_BUSY cpu_to_le32(0xC00A000E)
> -#define STATUS_CTX_MODEM_RESPONSE_VOICE cpu_to_le32(0xC00A000F)
> -#define STATUS_CTX_TD_ERROR cpu_to_le32(0xC00A0010)
> -#define STATUS_CTX_LICENSE_CLIENT_INVALID cpu_to_le32(0xC00A0012)
> -#define STATUS_CTX_LICENSE_NOT_AVAILABLE cpu_to_le32(0xC00A0013)
> -#define STATUS_CTX_LICENSE_EXPIRED cpu_to_le32(0xC00A0014)
> -#define STATUS_CTX_WINSTATION_NOT_FOUND cpu_to_le32(0xC00A0015)
> -#define STATUS_CTX_WINSTATION_NAME_COLLISION cpu_to_le32(0xC00A0016)
> -#define STATUS_CTX_WINSTATION_BUSY cpu_to_le32(0xC00A0017)
> -#define STATUS_CTX_BAD_VIDEO_MODE cpu_to_le32(0xC00A0018)
> -#define STATUS_CTX_GRAPHICS_INVALID cpu_to_le32(0xC00A0022)
> -#define STATUS_CTX_NOT_CONSOLE cpu_to_le32(0xC00A0024)
> -#define STATUS_CTX_CLIENT_QUERY_TIMEOUT cpu_to_le32(0xC00A0026)
> -#define STATUS_CTX_CONSOLE_DISCONNECT cpu_to_le32(0xC00A0027)
> -#define STATUS_CTX_CONSOLE_CONNECT cpu_to_le32(0xC00A0028)
> -#define STATUS_CTX_SHADOW_DENIED cpu_to_le32(0xC00A002A)
> -#define STATUS_CTX_WINSTATION_ACCESS_DENIED cpu_to_le32(0xC00A002B)
> -#define STATUS_CTX_INVALID_WD cpu_to_le32(0xC00A002E)
> -#define STATUS_CTX_WD_NOT_FOUND cpu_to_le32(0xC00A002F)
> -#define STATUS_CTX_SHADOW_INVALID cpu_to_le32(0xC00A0030)
> -#define STATUS_CTX_SHADOW_DISABLED cpu_to_le32(0xC00A0031)
> -#define STATUS_RDP_PROTOCOL_ERROR cpu_to_le32(0xC00A0032)
> -#define STATUS_CTX_CLIENT_LICENSE_NOT_SET cpu_to_le32(0xC00A0033)
> -#define STATUS_CTX_CLIENT_LICENSE_IN_USE cpu_to_le32(0xC00A0034)
> -#define STATUS_CTX_SHADOW_ENDED_BY_MODE_CHANGE cpu_to_le32(0xC00A0035)
> -#define STATUS_CTX_SHADOW_NOT_RUNNING cpu_to_le32(0xC00A0036)
> -#define STATUS_CTX_LOGON_DISABLED cpu_to_le32(0xC00A0037)
> -#define STATUS_CTX_SECURITY_LAYER_ERROR cpu_to_le32(0xC00A0038)
> -#define STATUS_TS_INCOMPATIBLE_SESSIONS cpu_to_le32(0xC00A0039)
> -#define STATUS_MUI_FILE_NOT_FOUND cpu_to_le32(0xC00B0001)
> -#define STATUS_MUI_INVALID_FILE cpu_to_le32(0xC00B0002)
> -#define STATUS_MUI_INVALID_RC_CONFIG cpu_to_le32(0xC00B0003)
> -#define STATUS_MUI_INVALID_LOCALE_NAME cpu_to_le32(0xC00B0004)
> -#define STATUS_MUI_INVALID_ULTIMATEFALLBACK_NAME cpu_to_le32(0xC00B0005)
> -#define STATUS_MUI_FILE_NOT_LOADED cpu_to_le32(0xC00B0006)
> -#define STATUS_RESOURCE_ENUM_USER_STOP cpu_to_le32(0xC00B0007)
> -#define STATUS_CLUSTER_INVALID_NODE cpu_to_le32(0xC0130001)
> -#define STATUS_CLUSTER_NODE_EXISTS cpu_to_le32(0xC0130002)
> -#define STATUS_CLUSTER_JOIN_IN_PROGRESS cpu_to_le32(0xC0130003)
> -#define STATUS_CLUSTER_NODE_NOT_FOUND cpu_to_le32(0xC0130004)
> -#define STATUS_CLUSTER_LOCAL_NODE_NOT_FOUND cpu_to_le32(0xC0130005)
> -#define STATUS_CLUSTER_NETWORK_EXISTS cpu_to_le32(0xC0130006)
> -#define STATUS_CLUSTER_NETWORK_NOT_FOUND cpu_to_le32(0xC0130007)
> -#define STATUS_CLUSTER_NETINTERFACE_EXISTS cpu_to_le32(0xC0130008)
> -#define STATUS_CLUSTER_NETINTERFACE_NOT_FOUND cpu_to_le32(0xC0130009)
> -#define STATUS_CLUSTER_INVALID_REQUEST cpu_to_le32(0xC013000A)
> -#define STATUS_CLUSTER_INVALID_NETWORK_PROVIDER cpu_to_le32(0xC013000B)
> -#define STATUS_CLUSTER_NODE_DOWN cpu_to_le32(0xC013000C)
> -#define STATUS_CLUSTER_NODE_UNREACHABLE cpu_to_le32(0xC013000D)
> -#define STATUS_CLUSTER_NODE_NOT_MEMBER cpu_to_le32(0xC013000E)
> -#define STATUS_CLUSTER_JOIN_NOT_IN_PROGRESS cpu_to_le32(0xC013000F)
> -#define STATUS_CLUSTER_INVALID_NETWORK cpu_to_le32(0xC0130010)
> -#define STATUS_CLUSTER_NO_NET_ADAPTERS cpu_to_le32(0xC0130011)
> -#define STATUS_CLUSTER_NODE_UP cpu_to_le32(0xC0130012)
> -#define STATUS_CLUSTER_NODE_PAUSED cpu_to_le32(0xC0130013)
> -#define STATUS_CLUSTER_NODE_NOT_PAUSED cpu_to_le32(0xC0130014)
> -#define STATUS_CLUSTER_NO_SECURITY_CONTEXT cpu_to_le32(0xC0130015)
> -#define STATUS_CLUSTER_NETWORK_NOT_INTERNAL cpu_to_le32(0xC0130016)
> -#define STATUS_CLUSTER_POISONED cpu_to_le32(0xC0130017)
> -#define STATUS_ACPI_INVALID_OPCODE cpu_to_le32(0xC0140001)
> -#define STATUS_ACPI_STACK_OVERFLOW cpu_to_le32(0xC0140002)
> -#define STATUS_ACPI_ASSERT_FAILED cpu_to_le32(0xC0140003)
> -#define STATUS_ACPI_INVALID_INDEX cpu_to_le32(0xC0140004)
> -#define STATUS_ACPI_INVALID_ARGUMENT cpu_to_le32(0xC0140005)
> -#define STATUS_ACPI_FATAL cpu_to_le32(0xC0140006)
> -#define STATUS_ACPI_INVALID_SUPERNAME cpu_to_le32(0xC0140007)
> -#define STATUS_ACPI_INVALID_ARGTYPE cpu_to_le32(0xC0140008)
> -#define STATUS_ACPI_INVALID_OBJTYPE cpu_to_le32(0xC0140009)
> -#define STATUS_ACPI_INVALID_TARGETTYPE cpu_to_le32(0xC014000A)
> -#define STATUS_ACPI_INCORRECT_ARGUMENT_COUNT cpu_to_le32(0xC014000B)
> -#define STATUS_ACPI_ADDRESS_NOT_MAPPED cpu_to_le32(0xC014000C)
> -#define STATUS_ACPI_INVALID_EVENTTYPE cpu_to_le32(0xC014000D)
> -#define STATUS_ACPI_HANDLER_COLLISION cpu_to_le32(0xC014000E)
> -#define STATUS_ACPI_INVALID_DATA cpu_to_le32(0xC014000F)
> -#define STATUS_ACPI_INVALID_REGION cpu_to_le32(0xC0140010)
> -#define STATUS_ACPI_INVALID_ACCESS_SIZE cpu_to_le32(0xC0140011)
> -#define STATUS_ACPI_ACQUIRE_GLOBAL_LOCK cpu_to_le32(0xC0140012)
> -#define STATUS_ACPI_ALREADY_INITIALIZED cpu_to_le32(0xC0140013)
> -#define STATUS_ACPI_NOT_INITIALIZED cpu_to_le32(0xC0140014)
> -#define STATUS_ACPI_INVALID_MUTEX_LEVEL cpu_to_le32(0xC0140015)
> -#define STATUS_ACPI_MUTEX_NOT_OWNED cpu_to_le32(0xC0140016)
> -#define STATUS_ACPI_MUTEX_NOT_OWNER cpu_to_le32(0xC0140017)
> -#define STATUS_ACPI_RS_ACCESS cpu_to_le32(0xC0140018)
> -#define STATUS_ACPI_INVALID_TABLE cpu_to_le32(0xC0140019)
> -#define STATUS_ACPI_REG_HANDLER_FAILED cpu_to_le32(0xC0140020)
> -#define STATUS_ACPI_POWER_REQUEST_FAILED cpu_to_le32(0xC0140021)
> -#define STATUS_SXS_SECTION_NOT_FOUND cpu_to_le32(0xC0150001)
> -#define STATUS_SXS_CANT_GEN_ACTCTX cpu_to_le32(0xC0150002)
> -#define STATUS_SXS_INVALID_ACTCTXDATA_FORMAT cpu_to_le32(0xC0150003)
> -#define STATUS_SXS_ASSEMBLY_NOT_FOUND cpu_to_le32(0xC0150004)
> -#define STATUS_SXS_MANIFEST_FORMAT_ERROR cpu_to_le32(0xC0150005)
> -#define STATUS_SXS_MANIFEST_PARSE_ERROR cpu_to_le32(0xC0150006)
> -#define STATUS_SXS_ACTIVATION_CONTEXT_DISABLED cpu_to_le32(0xC0150007)
> -#define STATUS_SXS_KEY_NOT_FOUND cpu_to_le32(0xC0150008)
> -#define STATUS_SXS_VERSION_CONFLICT cpu_to_le32(0xC0150009)
> -#define STATUS_SXS_WRONG_SECTION_TYPE cpu_to_le32(0xC015000A)
> -#define STATUS_SXS_THREAD_QUERIES_DISABLED cpu_to_le32(0xC015000B)
> -#define STATUS_SXS_ASSEMBLY_MISSING cpu_to_le32(0xC015000C)
> -#define STATUS_SXS_PROCESS_DEFAULT_ALREADY_SET cpu_to_le32(0xC015000E)
> -#define STATUS_SXS_EARLY_DEACTIVATION cpu_to_le32(0xC015000F)
> -#define STATUS_SXS_INVALID_DEACTIVATION cpu_to_le32(0xC0150010)
> -#define STATUS_SXS_MULTIPLE_DEACTIVATION cpu_to_le32(0xC0150011)
> -#define STATUS_SXS_SYSTEM_DEFAULT_ACTIVATION_CONTEXT_EMPTY     \
> -       cpu_to_le32(0xC0150012)
> -#define STATUS_SXS_PROCESS_TERMINATION_REQUESTED cpu_to_le32(0xC0150013)
> -#define STATUS_SXS_CORRUPT_ACTIVATION_STACK cpu_to_le32(0xC0150014)
> -#define STATUS_SXS_CORRUPTION cpu_to_le32(0xC0150015)
> -#define STATUS_SXS_INVALID_IDENTITY_ATTRIBUTE_VALUE cpu_to_le32(0xC01500=
16)
> -#define STATUS_SXS_INVALID_IDENTITY_ATTRIBUTE_NAME cpu_to_le32(0xC015001=
7)
> -#define STATUS_SXS_IDENTITY_DUPLICATE_ATTRIBUTE cpu_to_le32(0xC0150018)
> -#define STATUS_SXS_IDENTITY_PARSE_ERROR cpu_to_le32(0xC0150019)
> -#define STATUS_SXS_COMPONENT_STORE_CORRUPT cpu_to_le32(0xC015001A)
> -#define STATUS_SXS_FILE_HASH_MISMATCH cpu_to_le32(0xC015001B)
> -#define STATUS_SXS_MANIFEST_IDENTITY_SAME_BUT_CONTENTS_DIFFERENT       \
> -       cpu_to_le32(0xC015001C)
> -#define STATUS_SXS_IDENTITIES_DIFFERENT cpu_to_le32(0xC015001D)
> -#define STATUS_SXS_ASSEMBLY_IS_NOT_A_DEPLOYMENT cpu_to_le32(0xC015001E)
> -#define STATUS_SXS_FILE_NOT_PART_OF_ASSEMBLY cpu_to_le32(0xC015001F)
> -#define STATUS_ADVANCED_INSTALLER_FAILED cpu_to_le32(0xC0150020)
> -#define STATUS_XML_ENCODING_MISMATCH cpu_to_le32(0xC0150021)
> -#define STATUS_SXS_MANIFEST_TOO_BIG cpu_to_le32(0xC0150022)
> -#define STATUS_SXS_SETTING_NOT_REGISTERED cpu_to_le32(0xC0150023)
> -#define STATUS_SXS_TRANSACTION_CLOSURE_INCOMPLETE cpu_to_le32(0xC0150024=
)
> -#define STATUS_SMI_PRIMITIVE_INSTALLER_FAILED cpu_to_le32(0xC0150025)
> -#define STATUS_GENERIC_COMMAND_FAILED cpu_to_le32(0xC0150026)
> -#define STATUS_SXS_FILE_HASH_MISSING cpu_to_le32(0xC0150027)
> -#define STATUS_TRANSACTIONAL_CONFLICT cpu_to_le32(0xC0190001)
> -#define STATUS_INVALID_TRANSACTION cpu_to_le32(0xC0190002)
> -#define STATUS_TRANSACTION_NOT_ACTIVE cpu_to_le32(0xC0190003)
> -#define STATUS_TM_INITIALIZATION_FAILED cpu_to_le32(0xC0190004)
> -#define STATUS_RM_NOT_ACTIVE cpu_to_le32(0xC0190005)
> -#define STATUS_RM_METADATA_CORRUPT cpu_to_le32(0xC0190006)
> -#define STATUS_TRANSACTION_NOT_JOINED cpu_to_le32(0xC0190007)
> -#define STATUS_DIRECTORY_NOT_RM cpu_to_le32(0xC0190008)
> -#define STATUS_TRANSACTIONS_UNSUPPORTED_REMOTE cpu_to_le32(0xC019000A)
> -#define STATUS_LOG_RESIZE_INVALID_SIZE cpu_to_le32(0xC019000B)
> -#define STATUS_REMOTE_FILE_VERSION_MISMATCH cpu_to_le32(0xC019000C)
> -#define STATUS_CRM_PROTOCOL_ALREADY_EXISTS cpu_to_le32(0xC019000F)
> -#define STATUS_TRANSACTION_PROPAGATION_FAILED cpu_to_le32(0xC0190010)
> -#define STATUS_CRM_PROTOCOL_NOT_FOUND cpu_to_le32(0xC0190011)
> -#define STATUS_TRANSACTION_SUPERIOR_EXISTS cpu_to_le32(0xC0190012)
> -#define STATUS_TRANSACTION_REQUEST_NOT_VALID cpu_to_le32(0xC0190013)
> -#define STATUS_TRANSACTION_NOT_REQUESTED cpu_to_le32(0xC0190014)
> -#define STATUS_TRANSACTION_ALREADY_ABORTED cpu_to_le32(0xC0190015)
> -#define STATUS_TRANSACTION_ALREADY_COMMITTED cpu_to_le32(0xC0190016)
> -#define STATUS_TRANSACTION_INVALID_MARSHALL_BUFFER cpu_to_le32(0xC019001=
7)
> -#define STATUS_CURRENT_TRANSACTION_NOT_VALID cpu_to_le32(0xC0190018)
> -#define STATUS_LOG_GROWTH_FAILED cpu_to_le32(0xC0190019)
> -#define STATUS_OBJECT_NO_LONGER_EXISTS cpu_to_le32(0xC0190021)
> -#define STATUS_STREAM_MINIVERSION_NOT_FOUND cpu_to_le32(0xC0190022)
> -#define STATUS_STREAM_MINIVERSION_NOT_VALID cpu_to_le32(0xC0190023)
> -#define STATUS_MINIVERSION_INACCESSIBLE_FROM_SPECIFIED_TRANSACTION     \
> -       cpu_to_le32(0xC0190024)
> -#define STATUS_CANT_OPEN_MINIVERSION_WITH_MODIFY_INTENT cpu_to_le32(0xC0=
190025)
> -#define STATUS_CANT_CREATE_MORE_STREAM_MINIVERSIONS cpu_to_le32(0xC01900=
26)
> -#define STATUS_HANDLE_NO_LONGER_VALID cpu_to_le32(0xC0190028)
> -#define STATUS_LOG_CORRUPTION_DETECTED cpu_to_le32(0xC0190030)
> -#define STATUS_RM_DISCONNECTED cpu_to_le32(0xC0190032)
> -#define STATUS_ENLISTMENT_NOT_SUPERIOR cpu_to_le32(0xC0190033)
> -#define STATUS_FILE_IDENTITY_NOT_PERSISTENT cpu_to_le32(0xC0190036)
> -#define STATUS_CANT_BREAK_TRANSACTIONAL_DEPENDENCY cpu_to_le32(0xC019003=
7)
> -#define STATUS_CANT_CROSS_RM_BOUNDARY cpu_to_le32(0xC0190038)
> -#define STATUS_TXF_DIR_NOT_EMPTY cpu_to_le32(0xC0190039)
> -#define STATUS_INDOUBT_TRANSACTIONS_EXIST cpu_to_le32(0xC019003A)
> -#define STATUS_TM_VOLATILE cpu_to_le32(0xC019003B)
> -#define STATUS_ROLLBACK_TIMER_EXPIRED cpu_to_le32(0xC019003C)
> -#define STATUS_TXF_ATTRIBUTE_CORRUPT cpu_to_le32(0xC019003D)
> -#define STATUS_EFS_NOT_ALLOWED_IN_TRANSACTION cpu_to_le32(0xC019003E)
> -#define STATUS_TRANSACTIONAL_OPEN_NOT_ALLOWED cpu_to_le32(0xC019003F)
> -#define STATUS_TRANSACTED_MAPPING_UNSUPPORTED_REMOTE cpu_to_le32(0xC0190=
040)
> -#define STATUS_TRANSACTION_REQUIRED_PROMOTION cpu_to_le32(0xC0190043)
> -#define STATUS_CANNOT_EXECUTE_FILE_IN_TRANSACTION cpu_to_le32(0xC0190044=
)
> -#define STATUS_TRANSACTIONS_NOT_FROZEN cpu_to_le32(0xC0190045)
> -#define STATUS_TRANSACTION_FREEZE_IN_PROGRESS cpu_to_le32(0xC0190046)
> -#define STATUS_NOT_SNAPSHOT_VOLUME cpu_to_le32(0xC0190047)
> -#define STATUS_NO_SAVEPOINT_WITH_OPEN_FILES cpu_to_le32(0xC0190048)
> -#define STATUS_SPARSE_NOT_ALLOWED_IN_TRANSACTION cpu_to_le32(0xC0190049)
> -#define STATUS_TM_IDENTITY_MISMATCH cpu_to_le32(0xC019004A)
> -#define STATUS_FLOATED_SECTION cpu_to_le32(0xC019004B)
> -#define STATUS_CANNOT_ACCEPT_TRANSACTED_WORK cpu_to_le32(0xC019004C)
> -#define STATUS_CANNOT_ABORT_TRANSACTIONS cpu_to_le32(0xC019004D)
> -#define STATUS_TRANSACTION_NOT_FOUND cpu_to_le32(0xC019004E)
> -#define STATUS_RESOURCEMANAGER_NOT_FOUND cpu_to_le32(0xC019004F)
> -#define STATUS_ENLISTMENT_NOT_FOUND cpu_to_le32(0xC0190050)
> -#define STATUS_TRANSACTIONMANAGER_NOT_FOUND cpu_to_le32(0xC0190051)
> -#define STATUS_TRANSACTIONMANAGER_NOT_ONLINE cpu_to_le32(0xC0190052)
> -#define STATUS_TRANSACTIONMANAGER_RECOVERY_NAME_COLLISION      \
> -       cpu_to_le32(0xC0190053)
> -#define STATUS_TRANSACTION_NOT_ROOT cpu_to_le32(0xC0190054)
> -#define STATUS_TRANSACTION_OBJECT_EXPIRED cpu_to_le32(0xC0190055)
> -#define STATUS_COMPRESSION_NOT_ALLOWED_IN_TRANSACTION cpu_to_le32(0xC019=
0056)
> -#define STATUS_TRANSACTION_RESPONSE_NOT_ENLISTED cpu_to_le32(0xC0190057)
> -#define STATUS_TRANSACTION_RECORD_TOO_LONG cpu_to_le32(0xC0190058)
> -#define STATUS_NO_LINK_TRACKING_IN_TRANSACTION cpu_to_le32(0xC0190059)
> -#define STATUS_OPERATION_NOT_SUPPORTED_IN_TRANSACTION cpu_to_le32(0xC019=
005A)
> -#define STATUS_TRANSACTION_INTEGRITY_VIOLATED cpu_to_le32(0xC019005B)
> -#define STATUS_LOG_SECTOR_INVALID cpu_to_le32(0xC01A0001)
> -#define STATUS_LOG_SECTOR_PARITY_INVALID cpu_to_le32(0xC01A0002)
> -#define STATUS_LOG_SECTOR_REMAPPED cpu_to_le32(0xC01A0003)
> -#define STATUS_LOG_BLOCK_INCOMPLETE cpu_to_le32(0xC01A0004)
> -#define STATUS_LOG_INVALID_RANGE cpu_to_le32(0xC01A0005)
> -#define STATUS_LOG_BLOCKS_EXHAUSTED cpu_to_le32(0xC01A0006)
> -#define STATUS_LOG_READ_CONTEXT_INVALID cpu_to_le32(0xC01A0007)
> -#define STATUS_LOG_RESTART_INVALID cpu_to_le32(0xC01A0008)
> -#define STATUS_LOG_BLOCK_VERSION cpu_to_le32(0xC01A0009)
> -#define STATUS_LOG_BLOCK_INVALID cpu_to_le32(0xC01A000A)
> -#define STATUS_LOG_READ_MODE_INVALID cpu_to_le32(0xC01A000B)
> -#define STATUS_LOG_METADATA_CORRUPT cpu_to_le32(0xC01A000D)
> -#define STATUS_LOG_METADATA_INVALID cpu_to_le32(0xC01A000E)
> -#define STATUS_LOG_METADATA_INCONSISTENT cpu_to_le32(0xC01A000F)
> -#define STATUS_LOG_RESERVATION_INVALID cpu_to_le32(0xC01A0010)
> -#define STATUS_LOG_CANT_DELETE cpu_to_le32(0xC01A0011)
> -#define STATUS_LOG_CONTAINER_LIMIT_EXCEEDED cpu_to_le32(0xC01A0012)
> -#define STATUS_LOG_START_OF_LOG cpu_to_le32(0xC01A0013)
> -#define STATUS_LOG_POLICY_ALREADY_INSTALLED cpu_to_le32(0xC01A0014)
> -#define STATUS_LOG_POLICY_NOT_INSTALLED cpu_to_le32(0xC01A0015)
> -#define STATUS_LOG_POLICY_INVALID cpu_to_le32(0xC01A0016)
> -#define STATUS_LOG_POLICY_CONFLICT cpu_to_le32(0xC01A0017)
> -#define STATUS_LOG_PINNED_ARCHIVE_TAIL cpu_to_le32(0xC01A0018)
> -#define STATUS_LOG_RECORD_NONEXISTENT cpu_to_le32(0xC01A0019)
> -#define STATUS_LOG_RECORDS_RESERVED_INVALID cpu_to_le32(0xC01A001A)
> -#define STATUS_LOG_SPACE_RESERVED_INVALID cpu_to_le32(0xC01A001B)
> -#define STATUS_LOG_TAIL_INVALID cpu_to_le32(0xC01A001C)
> -#define STATUS_LOG_FULL cpu_to_le32(0xC01A001D)
> -#define STATUS_LOG_MULTIPLEXED cpu_to_le32(0xC01A001E)
> -#define STATUS_LOG_DEDICATED cpu_to_le32(0xC01A001F)
> -#define STATUS_LOG_ARCHIVE_NOT_IN_PROGRESS cpu_to_le32(0xC01A0020)
> -#define STATUS_LOG_ARCHIVE_IN_PROGRESS cpu_to_le32(0xC01A0021)
> -#define STATUS_LOG_EPHEMERAL cpu_to_le32(0xC01A0022)
> -#define STATUS_LOG_NOT_ENOUGH_CONTAINERS cpu_to_le32(0xC01A0023)
> -#define STATUS_LOG_CLIENT_ALREADY_REGISTERED cpu_to_le32(0xC01A0024)
> -#define STATUS_LOG_CLIENT_NOT_REGISTERED cpu_to_le32(0xC01A0025)
> -#define STATUS_LOG_FULL_HANDLER_IN_PROGRESS cpu_to_le32(0xC01A0026)
> -#define STATUS_LOG_CONTAINER_READ_FAILED cpu_to_le32(0xC01A0027)
> -#define STATUS_LOG_CONTAINER_WRITE_FAILED cpu_to_le32(0xC01A0028)
> -#define STATUS_LOG_CONTAINER_OPEN_FAILED cpu_to_le32(0xC01A0029)
> -#define STATUS_LOG_CONTAINER_STATE_INVALID cpu_to_le32(0xC01A002A)
> -#define STATUS_LOG_STATE_INVALID cpu_to_le32(0xC01A002B)
> -#define STATUS_LOG_PINNED cpu_to_le32(0xC01A002C)
> -#define STATUS_LOG_METADATA_FLUSH_FAILED cpu_to_le32(0xC01A002D)
> -#define STATUS_LOG_INCONSISTENT_SECURITY cpu_to_le32(0xC01A002E)
> -#define STATUS_LOG_APPENDED_FLUSH_FAILED cpu_to_le32(0xC01A002F)
> -#define STATUS_LOG_PINNED_RESERVATION cpu_to_le32(0xC01A0030)
> -#define STATUS_VIDEO_HUNG_DISPLAY_DRIVER_THREAD cpu_to_le32(0xC01B00EA)
> -#define STATUS_FLT_NO_HANDLER_DEFINED cpu_to_le32(0xC01C0001)
> -#define STATUS_FLT_CONTEXT_ALREADY_DEFINED cpu_to_le32(0xC01C0002)
> -#define STATUS_FLT_INVALID_ASYNCHRONOUS_REQUEST cpu_to_le32(0xC01C0003)
> -#define STATUS_FLT_DISALLOW_FAST_IO cpu_to_le32(0xC01C0004)
> -#define STATUS_FLT_INVALID_NAME_REQUEST cpu_to_le32(0xC01C0005)
> -#define STATUS_FLT_NOT_SAFE_TO_POST_OPERATION cpu_to_le32(0xC01C0006)
> -#define STATUS_FLT_NOT_INITIALIZED cpu_to_le32(0xC01C0007)
> -#define STATUS_FLT_FILTER_NOT_READY cpu_to_le32(0xC01C0008)
> -#define STATUS_FLT_POST_OPERATION_CLEANUP cpu_to_le32(0xC01C0009)
> -#define STATUS_FLT_INTERNAL_ERROR cpu_to_le32(0xC01C000A)
> -#define STATUS_FLT_DELETING_OBJECT cpu_to_le32(0xC01C000B)
> -#define STATUS_FLT_MUST_BE_NONPAGED_POOL cpu_to_le32(0xC01C000C)
> -#define STATUS_FLT_DUPLICATE_ENTRY cpu_to_le32(0xC01C000D)
> -#define STATUS_FLT_CBDQ_DISABLED cpu_to_le32(0xC01C000E)
> -#define STATUS_FLT_DO_NOT_ATTACH cpu_to_le32(0xC01C000F)
> -#define STATUS_FLT_DO_NOT_DETACH cpu_to_le32(0xC01C0010)
> -#define STATUS_FLT_INSTANCE_ALTITUDE_COLLISION cpu_to_le32(0xC01C0011)
> -#define STATUS_FLT_INSTANCE_NAME_COLLISION cpu_to_le32(0xC01C0012)
> -#define STATUS_FLT_FILTER_NOT_FOUND cpu_to_le32(0xC01C0013)
> -#define STATUS_FLT_VOLUME_NOT_FOUND cpu_to_le32(0xC01C0014)
> -#define STATUS_FLT_INSTANCE_NOT_FOUND cpu_to_le32(0xC01C0015)
> -#define STATUS_FLT_CONTEXT_ALLOCATION_NOT_FOUND cpu_to_le32(0xC01C0016)
> -#define STATUS_FLT_INVALID_CONTEXT_REGISTRATION cpu_to_le32(0xC01C0017)
> -#define STATUS_FLT_NAME_CACHE_MISS cpu_to_le32(0xC01C0018)
> -#define STATUS_FLT_NO_DEVICE_OBJECT cpu_to_le32(0xC01C0019)
> -#define STATUS_FLT_VOLUME_ALREADY_MOUNTED cpu_to_le32(0xC01C001A)
> -#define STATUS_FLT_ALREADY_ENLISTED cpu_to_le32(0xC01C001B)
> -#define STATUS_FLT_CONTEXT_ALREADY_LINKED cpu_to_le32(0xC01C001C)
> -#define STATUS_FLT_NO_WAITER_FOR_REPLY cpu_to_le32(0xC01C0020)
> -#define STATUS_MONITOR_NO_DESCRIPTOR cpu_to_le32(0xC01D0001)
> -#define STATUS_MONITOR_UNKNOWN_DESCRIPTOR_FORMAT cpu_to_le32(0xC01D0002)
> -#define STATUS_MONITOR_INVALID_DESCRIPTOR_CHECKSUM cpu_to_le32(0xC01D000=
3)
> -#define STATUS_MONITOR_INVALID_STANDARD_TIMING_BLOCK cpu_to_le32(0xC01D0=
004)
> -#define STATUS_MONITOR_WMI_DATABLOCK_REGISTRATION_FAILED cpu_to_le32(0xC=
01D0005)
> -#define STATUS_MONITOR_INVALID_SERIAL_NUMBER_MONDSC_BLOCK      \
> -       cpu_to_le32(0xC01D0006)
> -#define STATUS_MONITOR_INVALID_USER_FRIENDLY_MONDSC_BLOCK      \
> -       cpu_to_le32(0xC01D0007)
> -#define STATUS_MONITOR_NO_MORE_DESCRIPTOR_DATA cpu_to_le32(0xC01D0008)
> -#define STATUS_MONITOR_INVALID_DETAILED_TIMING_BLOCK cpu_to_le32(0xC01D0=
009)
> -#define STATUS_GRAPHICS_NOT_EXCLUSIVE_MODE_OWNER cpu_to_le32(0xC01E0000)
> -#define STATUS_GRAPHICS_INSUFFICIENT_DMA_BUFFER cpu_to_le32(0xC01E0001)
> -#define STATUS_GRAPHICS_INVALID_DISPLAY_ADAPTER cpu_to_le32(0xC01E0002)
> -#define STATUS_GRAPHICS_ADAPTER_WAS_RESET cpu_to_le32(0xC01E0003)
> -#define STATUS_GRAPHICS_INVALID_DRIVER_MODEL cpu_to_le32(0xC01E0004)
> -#define STATUS_GRAPHICS_PRESENT_MODE_CHANGED cpu_to_le32(0xC01E0005)
> -#define STATUS_GRAPHICS_PRESENT_OCCLUDED cpu_to_le32(0xC01E0006)
> -#define STATUS_GRAPHICS_PRESENT_DENIED cpu_to_le32(0xC01E0007)
> -#define STATUS_GRAPHICS_CANNOTCOLORCONVERT cpu_to_le32(0xC01E0008)
> -#define STATUS_GRAPHICS_NO_VIDEO_MEMORY cpu_to_le32(0xC01E0100)
> -#define STATUS_GRAPHICS_CANT_LOCK_MEMORY cpu_to_le32(0xC01E0101)
> -#define STATUS_GRAPHICS_ALLOCATION_BUSY cpu_to_le32(0xC01E0102)
> -#define STATUS_GRAPHICS_TOO_MANY_REFERENCES cpu_to_le32(0xC01E0103)
> -#define STATUS_GRAPHICS_TRY_AGAIN_LATER cpu_to_le32(0xC01E0104)
> -#define STATUS_GRAPHICS_TRY_AGAIN_NOW cpu_to_le32(0xC01E0105)
> -#define STATUS_GRAPHICS_ALLOCATION_INVALID cpu_to_le32(0xC01E0106)
> -#define STATUS_GRAPHICS_UNSWIZZLING_APERTURE_UNAVAILABLE cpu_to_le32(0xC=
01E0107)
> -#define STATUS_GRAPHICS_UNSWIZZLING_APERTURE_UNSUPPORTED cpu_to_le32(0xC=
01E0108)
> -#define STATUS_GRAPHICS_CANT_EVICT_PINNED_ALLOCATION cpu_to_le32(0xC01E0=
109)
> -#define STATUS_GRAPHICS_INVALID_ALLOCATION_USAGE cpu_to_le32(0xC01E0110)
> -#define STATUS_GRAPHICS_CANT_RENDER_LOCKED_ALLOCATION cpu_to_le32(0xC01E=
0111)
> -#define STATUS_GRAPHICS_ALLOCATION_CLOSED cpu_to_le32(0xC01E0112)
> -#define STATUS_GRAPHICS_INVALID_ALLOCATION_INSTANCE cpu_to_le32(0xC01E01=
13)
> -#define STATUS_GRAPHICS_INVALID_ALLOCATION_HANDLE cpu_to_le32(0xC01E0114=
)
> -#define STATUS_GRAPHICS_WRONG_ALLOCATION_DEVICE cpu_to_le32(0xC01E0115)
> -#define STATUS_GRAPHICS_ALLOCATION_CONTENT_LOST cpu_to_le32(0xC01E0116)
> -#define STATUS_GRAPHICS_GPU_EXCEPTION_ON_DEVICE cpu_to_le32(0xC01E0200)
> -#define STATUS_GRAPHICS_INVALID_VIDPN_TOPOLOGY cpu_to_le32(0xC01E0300)
> -#define STATUS_GRAPHICS_VIDPN_TOPOLOGY_NOT_SUPPORTED cpu_to_le32(0xC01E0=
301)
> -#define STATUS_GRAPHICS_VIDPN_TOPOLOGY_CURRENTLY_NOT_SUPPORTED \
> -       cpu_to_le32(0xC01E0302)
> -#define STATUS_GRAPHICS_INVALID_VIDPN cpu_to_le32(0xC01E0303)
> -#define STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE cpu_to_le32(0xC01E0=
304)
> -#define STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET cpu_to_le32(0xC01E0=
305)
> -#define STATUS_GRAPHICS_VIDPN_MODALITY_NOT_SUPPORTED cpu_to_le32(0xC01E0=
306)
> -#define STATUS_GRAPHICS_INVALID_VIDPN_SOURCEMODESET cpu_to_le32(0xC01E03=
08)
> -#define STATUS_GRAPHICS_INVALID_VIDPN_TARGETMODESET cpu_to_le32(0xC01E03=
09)
> -#define STATUS_GRAPHICS_INVALID_FREQUENCY cpu_to_le32(0xC01E030A)
> -#define STATUS_GRAPHICS_INVALID_ACTIVE_REGION cpu_to_le32(0xC01E030B)
> -#define STATUS_GRAPHICS_INVALID_TOTAL_REGION cpu_to_le32(0xC01E030C)
> -#define STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_SOURCE_MODE      \
> -       cpu_to_le32(0xC01E0310)
> -#define STATUS_GRAPHICS_INVALID_VIDEO_PRESENT_TARGET_MODE      \
> -       cpu_to_le32(0xC01E0311)
> -#define STATUS_GRAPHICS_PINNED_MODE_MUST_REMAIN_IN_SET cpu_to_le32(0xC01=
E0312)
> -#define STATUS_GRAPHICS_PATH_ALREADY_IN_TOPOLOGY cpu_to_le32(0xC01E0313)
> -#define STATUS_GRAPHICS_MODE_ALREADY_IN_MODESET cpu_to_le32(0xC01E0314)
> -#define STATUS_GRAPHICS_INVALID_VIDEOPRESENTSOURCESET cpu_to_le32(0xC01E=
0315)
> -#define STATUS_GRAPHICS_INVALID_VIDEOPRESENTTARGETSET cpu_to_le32(0xC01E=
0316)
> -#define STATUS_GRAPHICS_SOURCE_ALREADY_IN_SET cpu_to_le32(0xC01E0317)
> -#define STATUS_GRAPHICS_TARGET_ALREADY_IN_SET cpu_to_le32(0xC01E0318)
> -#define STATUS_GRAPHICS_INVALID_VIDPN_PRESENT_PATH cpu_to_le32(0xC01E031=
9)
> -#define STATUS_GRAPHICS_NO_RECOMMENDED_VIDPN_TOPOLOGY cpu_to_le32(0xC01E=
031A)
> -#define STATUS_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGESET      \
> -       cpu_to_le32(0xC01E031B)
> -#define STATUS_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE cpu_to_le32(0xC01=
E031C)
> -#define STATUS_GRAPHICS_FREQUENCYRANGE_NOT_IN_SET cpu_to_le32(0xC01E031D=
)
> -#define STATUS_GRAPHICS_FREQUENCYRANGE_ALREADY_IN_SET cpu_to_le32(0xC01E=
031F)
> -#define STATUS_GRAPHICS_STALE_MODESET cpu_to_le32(0xC01E0320)
> -#define STATUS_GRAPHICS_INVALID_MONITOR_SOURCEMODESET cpu_to_le32(0xC01E=
0321)
> -#define STATUS_GRAPHICS_INVALID_MONITOR_SOURCE_MODE cpu_to_le32(0xC01E03=
22)
> -#define STATUS_GRAPHICS_NO_RECOMMENDED_FUNCTIONAL_VIDPN cpu_to_le32(0xC0=
1E0323)
> -#define STATUS_GRAPHICS_MODE_ID_MUST_BE_UNIQUE cpu_to_le32(0xC01E0324)
> -#define STATUS_GRAPHICS_EMPTY_ADAPTER_MONITOR_MODE_SUPPORT_INTERSECTION =
       \
> -       cpu_to_le32(0xC01E0325)
> -#define STATUS_GRAPHICS_VIDEO_PRESENT_TARGETS_LESS_THAN_SOURCES        \
> -       cpu_to_le32(0xC01E0326)
> -#define STATUS_GRAPHICS_PATH_NOT_IN_TOPOLOGY cpu_to_le32(0xC01E0327)
> -#define STATUS_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_SOURCE  \
> -       cpu_to_le32(0xC01E0328)
> -#define STATUS_GRAPHICS_ADAPTER_MUST_HAVE_AT_LEAST_ONE_TARGET  \
> -       cpu_to_le32(0xC01E0329)
> -#define STATUS_GRAPHICS_INVALID_MONITORDESCRIPTORSET cpu_to_le32(0xC01E0=
32A)
> -#define STATUS_GRAPHICS_INVALID_MONITORDESCRIPTOR cpu_to_le32(0xC01E032B=
)
> -#define STATUS_GRAPHICS_MONITORDESCRIPTOR_NOT_IN_SET cpu_to_le32(0xC01E0=
32C)
> -#define STATUS_GRAPHICS_MONITORDESCRIPTOR_ALREADY_IN_SET cpu_to_le32(0xC=
01E032D)
> -#define STATUS_GRAPHICS_MONITORDESCRIPTOR_ID_MUST_BE_UNIQUE    \
> -       cpu_to_le32(0xC01E032E)
> -#define STATUS_GRAPHICS_INVALID_VIDPN_TARGET_SUBSET_TYPE cpu_to_le32(0xC=
01E032F)
> -#define STATUS_GRAPHICS_RESOURCES_NOT_RELATED cpu_to_le32(0xC01E0330)
> -#define STATUS_GRAPHICS_SOURCE_ID_MUST_BE_UNIQUE cpu_to_le32(0xC01E0331)
> -#define STATUS_GRAPHICS_TARGET_ID_MUST_BE_UNIQUE cpu_to_le32(0xC01E0332)
> -#define STATUS_GRAPHICS_NO_AVAILABLE_VIDPN_TARGET cpu_to_le32(0xC01E0333=
)
> -#define STATUS_GRAPHICS_MONITOR_COULD_NOT_BE_ASSOCIATED_WITH_ADAPTER   \
> -       cpu_to_le32(0xC01E0334)
> -#define STATUS_GRAPHICS_NO_VIDPNMGR cpu_to_le32(0xC01E0335)
> -#define STATUS_GRAPHICS_NO_ACTIVE_VIDPN cpu_to_le32(0xC01E0336)
> -#define STATUS_GRAPHICS_STALE_VIDPN_TOPOLOGY cpu_to_le32(0xC01E0337)
> -#define STATUS_GRAPHICS_MONITOR_NOT_CONNECTED cpu_to_le32(0xC01E0338)
> -#define STATUS_GRAPHICS_SOURCE_NOT_IN_TOPOLOGY cpu_to_le32(0xC01E0339)
> -#define STATUS_GRAPHICS_INVALID_PRIMARYSURFACE_SIZE cpu_to_le32(0xC01E03=
3A)
> -#define STATUS_GRAPHICS_INVALID_VISIBLEREGION_SIZE cpu_to_le32(0xC01E033=
B)
> -#define STATUS_GRAPHICS_INVALID_STRIDE cpu_to_le32(0xC01E033C)
> -#define STATUS_GRAPHICS_INVALID_PIXELFORMAT cpu_to_le32(0xC01E033D)
> -#define STATUS_GRAPHICS_INVALID_COLORBASIS cpu_to_le32(0xC01E033E)
> -#define STATUS_GRAPHICS_INVALID_PIXELVALUEACCESSMODE cpu_to_le32(0xC01E0=
33F)
> -#define STATUS_GRAPHICS_TARGET_NOT_IN_TOPOLOGY cpu_to_le32(0xC01E0340)
> -#define STATUS_GRAPHICS_NO_DISPLAY_MODE_MANAGEMENT_SUPPORT     \
> -       cpu_to_le32(0xC01E0341)
> -#define STATUS_GRAPHICS_VIDPN_SOURCE_IN_USE cpu_to_le32(0xC01E0342)
> -#define STATUS_GRAPHICS_CANT_ACCESS_ACTIVE_VIDPN cpu_to_le32(0xC01E0343)
> -#define STATUS_GRAPHICS_INVALID_PATH_IMPORTANCE_ORDINAL cpu_to_le32(0xC0=
1E0344)
> -#define STATUS_GRAPHICS_INVALID_PATH_CONTENT_GEOMETRY_TRANSFORMATION   \
> -       cpu_to_le32(0xC01E0345)
> -#define STATUS_GRAPHICS_PATH_CONTENT_GEOMETRY_TRANSFORMATION_NOT_SUPPORT=
ED \
> -       cpu_to_le32(0xC01E0346)
> -#define STATUS_GRAPHICS_INVALID_GAMMA_RAMP cpu_to_le32(0xC01E0347)
> -#define STATUS_GRAPHICS_GAMMA_RAMP_NOT_SUPPORTED cpu_to_le32(0xC01E0348)
> -#define STATUS_GRAPHICS_MULTISAMPLING_NOT_SUPPORTED cpu_to_le32(0xC01E03=
49)
> -#define STATUS_GRAPHICS_MODE_NOT_IN_MODESET cpu_to_le32(0xC01E034A)
> -#define STATUS_GRAPHICS_INVALID_VIDPN_TOPOLOGY_RECOMMENDATION_REASON   \
> -       cpu_to_le32(0xC01E034D)
> -#define STATUS_GRAPHICS_INVALID_PATH_CONTENT_TYPE cpu_to_le32(0xC01E034E=
)
> -#define STATUS_GRAPHICS_INVALID_COPYPROTECTION_TYPE cpu_to_le32(0xC01E03=
4F)
> -#define STATUS_GRAPHICS_UNASSIGNED_MODESET_ALREADY_EXISTS      \
> -       cpu_to_le32(0xC01E0350)
> -#define STATUS_GRAPHICS_INVALID_SCANLINE_ORDERING cpu_to_le32(0xC01E0352=
)
> -#define STATUS_GRAPHICS_TOPOLOGY_CHANGES_NOT_ALLOWED cpu_to_le32(0xC01E0=
353)
> -#define STATUS_GRAPHICS_NO_AVAILABLE_IMPORTANCE_ORDINALS cpu_to_le32(0xC=
01E0354)
> -#define STATUS_GRAPHICS_INCOMPATIBLE_PRIVATE_FORMAT cpu_to_le32(0xC01E03=
55)
> -#define STATUS_GRAPHICS_INVALID_MODE_PRUNING_ALGORITHM cpu_to_le32(0xC01=
E0356)
> -#define STATUS_GRAPHICS_INVALID_MONITOR_CAPABILITY_ORIGIN      \
> -       cpu_to_le32(0xC01E0357)
> -#define STATUS_GRAPHICS_INVALID_MONITOR_FREQUENCYRANGE_CONSTRAINT      \
> -       cpu_to_le32(0xC01E0358)
> -#define STATUS_GRAPHICS_MAX_NUM_PATHS_REACHED cpu_to_le32(0xC01E0359)
> -#define STATUS_GRAPHICS_CANCEL_VIDPN_TOPOLOGY_AUGMENTATION     \
> -       cpu_to_le32(0xC01E035A)
> -#define STATUS_GRAPHICS_INVALID_CLIENT_TYPE cpu_to_le32(0xC01E035B)
> -#define STATUS_GRAPHICS_CLIENTVIDPN_NOT_SET cpu_to_le32(0xC01E035C)
> -#define STATUS_GRAPHICS_SPECIFIED_CHILD_ALREADY_CONNECTED      \
> -       cpu_to_le32(0xC01E0400)
> -#define STATUS_GRAPHICS_CHILD_DESCRIPTOR_NOT_SUPPORTED cpu_to_le32(0xC01=
E0401)
> -#define STATUS_GRAPHICS_NOT_A_LINKED_ADAPTER cpu_to_le32(0xC01E0430)
> -#define STATUS_GRAPHICS_LEADLINK_NOT_ENUMERATED cpu_to_le32(0xC01E0431)
> -#define STATUS_GRAPHICS_CHAINLINKS_NOT_ENUMERATED cpu_to_le32(0xC01E0432=
)
> -#define STATUS_GRAPHICS_ADAPTER_CHAIN_NOT_READY cpu_to_le32(0xC01E0433)
> -#define STATUS_GRAPHICS_CHAINLINKS_NOT_STARTED cpu_to_le32(0xC01E0434)
> -#define STATUS_GRAPHICS_CHAINLINKS_NOT_POWERED_ON cpu_to_le32(0xC01E0435=
)
> -#define STATUS_GRAPHICS_INCONSISTENT_DEVICE_LINK_STATE cpu_to_le32(0xC01=
E0436)
> -#define STATUS_GRAPHICS_NOT_POST_DEVICE_DRIVER cpu_to_le32(0xC01E0438)
> -#define STATUS_GRAPHICS_ADAPTER_ACCESS_NOT_EXCLUDED cpu_to_le32(0xC01E04=
3B)
> -#define STATUS_GRAPHICS_OPM_PROTECTED_OUTPUT_DOES_NOT_HAVE_COPP_SEMANTIC=
S \
> -       cpu_to_le32(0xC01E051C)
> -#define STATUS_GRAPHICS_OPM_INVALID_INFORMATION_REQUEST cpu_to_le32(0xC0=
1E051D)
> -#define STATUS_GRAPHICS_OPM_DRIVER_INTERNAL_ERROR cpu_to_le32(0xC01E051E=
)
> -#define STATUS_GRAPHICS_OPM_PROTECTED_OUTPUT_DOES_NOT_HAVE_OPM_SEMANTICS=
 \
> -       cpu_to_le32(0xC01E051F)
> -#define STATUS_GRAPHICS_OPM_SIGNALING_NOT_SUPPORTED cpu_to_le32(0xC01E05=
20)
> -#define STATUS_GRAPHICS_OPM_INVALID_CONFIGURATION_REQUEST      \
> -       cpu_to_le32(0xC01E0521)
> -#define STATUS_GRAPHICS_OPM_NOT_SUPPORTED cpu_to_le32(0xC01E0500)
> -#define STATUS_GRAPHICS_COPP_NOT_SUPPORTED cpu_to_le32(0xC01E0501)
> -#define STATUS_GRAPHICS_UAB_NOT_SUPPORTED cpu_to_le32(0xC01E0502)
> -#define STATUS_GRAPHICS_OPM_INVALID_ENCRYPTED_PARAMETERS cpu_to_le32(0xC=
01E0503)
> -#define STATUS_GRAPHICS_OPM_PARAMETER_ARRAY_TOO_SMALL cpu_to_le32(0xC01E=
0504)
> -#define STATUS_GRAPHICS_OPM_NO_PROTECTED_OUTPUTS_EXIST cpu_to_le32(0xC01=
E0505)
> -#define STATUS_GRAPHICS_PVP_NO_DISPLAY_DEVICE_CORRESPONDS_TO_NAME      \
> -       cpu_to_le32(0xC01E0506)
> -#define STATUS_GRAPHICS_PVP_DISPLAY_DEVICE_NOT_ATTACHED_TO_DESKTOP     \
> -       cpu_to_le32(0xC01E0507)
> -#define STATUS_GRAPHICS_PVP_MIRRORING_DEVICES_NOT_SUPPORTED    \
> -       cpu_to_le32(0xC01E0508)
> -#define STATUS_GRAPHICS_OPM_INVALID_POINTER cpu_to_le32(0xC01E050A)
> -#define STATUS_GRAPHICS_OPM_INTERNAL_ERROR cpu_to_le32(0xC01E050B)
> -#define STATUS_GRAPHICS_OPM_INVALID_HANDLE cpu_to_le32(0xC01E050C)
> -#define STATUS_GRAPHICS_PVP_NO_MONITORS_CORRESPOND_TO_DISPLAY_DEVICE   \
> -       cpu_to_le32(0xC01E050D)
> -#define STATUS_GRAPHICS_PVP_INVALID_CERTIFICATE_LENGTH cpu_to_le32(0xC01=
E050E)
> -#define STATUS_GRAPHICS_OPM_SPANNING_MODE_ENABLED cpu_to_le32(0xC01E050F=
)
> -#define STATUS_GRAPHICS_OPM_THEATER_MODE_ENABLED cpu_to_le32(0xC01E0510)
> -#define STATUS_GRAPHICS_PVP_HFS_FAILED cpu_to_le32(0xC01E0511)
> -#define STATUS_GRAPHICS_OPM_INVALID_SRM cpu_to_le32(0xC01E0512)
> -#define STATUS_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_HDCP cpu_to_le32(0xC=
01E0513)
> -#define STATUS_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_ACP cpu_to_le32(0xC0=
1E0514)
> -#define STATUS_GRAPHICS_OPM_OUTPUT_DOES_NOT_SUPPORT_CGMSA      \
> -       cpu_to_le32(0xC01E0515)
> -#define STATUS_GRAPHICS_OPM_HDCP_SRM_NEVER_SET cpu_to_le32(0xC01E0516)
> -#define STATUS_GRAPHICS_OPM_RESOLUTION_TOO_HIGH cpu_to_le32(0xC01E0517)
> -#define STATUS_GRAPHICS_OPM_ALL_HDCP_HARDWARE_ALREADY_IN_USE   \
> -       cpu_to_le32(0xC01E0518)
> -#define STATUS_GRAPHICS_OPM_PROTECTED_OUTPUT_NO_LONGER_EXISTS  \
> -       cpu_to_le32(0xC01E051A)
> -#define STATUS_GRAPHICS_OPM_SESSION_TYPE_CHANGE_IN_PROGRESS    \
> -       cpu_to_le32(0xC01E051B)
> -#define STATUS_GRAPHICS_I2C_NOT_SUPPORTED cpu_to_le32(0xC01E0580)
> -#define STATUS_GRAPHICS_I2C_DEVICE_DOES_NOT_EXIST cpu_to_le32(0xC01E0581=
)
> -#define STATUS_GRAPHICS_I2C_ERROR_TRANSMITTING_DATA cpu_to_le32(0xC01E05=
82)
> -#define STATUS_GRAPHICS_I2C_ERROR_RECEIVING_DATA cpu_to_le32(0xC01E0583)
> -#define STATUS_GRAPHICS_DDCCI_VCP_NOT_SUPPORTED cpu_to_le32(0xC01E0584)
> -#define STATUS_GRAPHICS_DDCCI_INVALID_DATA cpu_to_le32(0xC01E0585)
> -#define STATUS_GRAPHICS_DDCCI_MONITOR_RETURNED_INVALID_TIMING_STATUS_BYT=
E \
> -       cpu_to_le32(0xC01E0586)
> -#define STATUS_GRAPHICS_DDCCI_INVALID_CAPABILITIES_STRING      \
> -       cpu_to_le32(0xC01E0587)
> -#define STATUS_GRAPHICS_MCA_INTERNAL_ERROR cpu_to_le32(0xC01E0588)
> -#define STATUS_GRAPHICS_DDCCI_INVALID_MESSAGE_COMMAND cpu_to_le32(0xC01E=
0589)
> -#define STATUS_GRAPHICS_DDCCI_INVALID_MESSAGE_LENGTH cpu_to_le32(0xC01E0=
58A)
> -#define STATUS_GRAPHICS_DDCCI_INVALID_MESSAGE_CHECKSUM cpu_to_le32(0xC01=
E058B)
> -#define STATUS_GRAPHICS_INVALID_PHYSICAL_MONITOR_HANDLE cpu_to_le32(0xC0=
1E058C)
> -#define STATUS_GRAPHICS_MONITOR_NO_LONGER_EXISTS cpu_to_le32(0xC01E058D)
> -#define STATUS_GRAPHICS_ONLY_CONSOLE_SESSION_SUPPORTED cpu_to_le32(0xC01=
E05E0)
> -#define STATUS_GRAPHICS_NO_DISPLAY_DEVICE_CORRESPONDS_TO_NAME  \
> -       cpu_to_le32(0xC01E05E1)
> -#define STATUS_GRAPHICS_DISPLAY_DEVICE_NOT_ATTACHED_TO_DESKTOP \
> -       cpu_to_le32(0xC01E05E2)
> -#define STATUS_GRAPHICS_MIRRORING_DEVICES_NOT_SUPPORTED cpu_to_le32(0xC0=
1E05E3)
> -#define STATUS_GRAPHICS_INVALID_POINTER cpu_to_le32(0xC01E05E4)
> -#define STATUS_GRAPHICS_NO_MONITORS_CORRESPOND_TO_DISPLAY_DEVICE       \
> -       cpu_to_le32(0xC01E05E5)
> -#define STATUS_GRAPHICS_PARAMETER_ARRAY_TOO_SMALL cpu_to_le32(0xC01E05E6=
)
> -#define STATUS_GRAPHICS_INTERNAL_ERROR cpu_to_le32(0xC01E05E7)
> -#define STATUS_GRAPHICS_SESSION_TYPE_CHANGE_IN_PROGRESS cpu_to_le32(0xC0=
1E05E8)
> -#define STATUS_FVE_LOCKED_VOLUME cpu_to_le32(0xC0210000)
> -#define STATUS_FVE_NOT_ENCRYPTED cpu_to_le32(0xC0210001)
> -#define STATUS_FVE_BAD_INFORMATION cpu_to_le32(0xC0210002)
> -#define STATUS_FVE_TOO_SMALL cpu_to_le32(0xC0210003)
> -#define STATUS_FVE_FAILED_WRONG_FS cpu_to_le32(0xC0210004)
> -#define STATUS_FVE_FAILED_BAD_FS cpu_to_le32(0xC0210005)
> -#define STATUS_FVE_FS_NOT_EXTENDED cpu_to_le32(0xC0210006)
> -#define STATUS_FVE_FS_MOUNTED cpu_to_le32(0xC0210007)
> -#define STATUS_FVE_NO_LICENSE cpu_to_le32(0xC0210008)
> -#define STATUS_FVE_ACTION_NOT_ALLOWED cpu_to_le32(0xC0210009)
> -#define STATUS_FVE_BAD_DATA cpu_to_le32(0xC021000A)
> -#define STATUS_FVE_VOLUME_NOT_BOUND cpu_to_le32(0xC021000B)
> -#define STATUS_FVE_NOT_DATA_VOLUME cpu_to_le32(0xC021000C)
> -#define STATUS_FVE_CONV_READ_ERROR cpu_to_le32(0xC021000D)
> -#define STATUS_FVE_CONV_WRITE_ERROR cpu_to_le32(0xC021000E)
> -#define STATUS_FVE_OVERLAPPED_UPDATE cpu_to_le32(0xC021000F)
> -#define STATUS_FVE_FAILED_SECTOR_SIZE cpu_to_le32(0xC0210010)
> -#define STATUS_FVE_FAILED_AUTHENTICATION cpu_to_le32(0xC0210011)
> -#define STATUS_FVE_NOT_OS_VOLUME cpu_to_le32(0xC0210012)
> -#define STATUS_FVE_KEYFILE_NOT_FOUND cpu_to_le32(0xC0210013)
> -#define STATUS_FVE_KEYFILE_INVALID cpu_to_le32(0xC0210014)
> -#define STATUS_FVE_KEYFILE_NO_VMK cpu_to_le32(0xC0210015)
> -#define STATUS_FVE_TPM_DISABLED cpu_to_le32(0xC0210016)
> -#define STATUS_FVE_TPM_SRK_AUTH_NOT_ZERO cpu_to_le32(0xC0210017)
> -#define STATUS_FVE_TPM_INVALID_PCR cpu_to_le32(0xC0210018)
> -#define STATUS_FVE_TPM_NO_VMK cpu_to_le32(0xC0210019)
> -#define STATUS_FVE_PIN_INVALID cpu_to_le32(0xC021001A)
> -#define STATUS_FVE_AUTH_INVALID_APPLICATION cpu_to_le32(0xC021001B)
> -#define STATUS_FVE_AUTH_INVALID_CONFIG cpu_to_le32(0xC021001C)
> -#define STATUS_FVE_DEBUGGER_ENABLED cpu_to_le32(0xC021001D)
> -#define STATUS_FVE_DRY_RUN_FAILED cpu_to_le32(0xC021001E)
> -#define STATUS_FVE_BAD_METADATA_POINTER cpu_to_le32(0xC021001F)
> -#define STATUS_FVE_OLD_METADATA_COPY cpu_to_le32(0xC0210020)
> -#define STATUS_FVE_REBOOT_REQUIRED cpu_to_le32(0xC0210021)
> -#define STATUS_FVE_RAW_ACCESS cpu_to_le32(0xC0210022)
> -#define STATUS_FVE_RAW_BLOCKED cpu_to_le32(0xC0210023)
> -#define STATUS_FWP_CALLOUT_NOT_FOUND cpu_to_le32(0xC0220001)
> -#define STATUS_FWP_CONDITION_NOT_FOUND cpu_to_le32(0xC0220002)
> -#define STATUS_FWP_FILTER_NOT_FOUND cpu_to_le32(0xC0220003)
> -#define STATUS_FWP_LAYER_NOT_FOUND cpu_to_le32(0xC0220004)
> -#define STATUS_FWP_PROVIDER_NOT_FOUND cpu_to_le32(0xC0220005)
> -#define STATUS_FWP_PROVIDER_CONTEXT_NOT_FOUND cpu_to_le32(0xC0220006)
> -#define STATUS_FWP_SUBLAYER_NOT_FOUND cpu_to_le32(0xC0220007)
> -#define STATUS_FWP_NOT_FOUND cpu_to_le32(0xC0220008)
> -#define STATUS_FWP_ALREADY_EXISTS cpu_to_le32(0xC0220009)
> -#define STATUS_FWP_IN_USE cpu_to_le32(0xC022000A)
> -#define STATUS_FWP_DYNAMIC_SESSION_IN_PROGRESS cpu_to_le32(0xC022000B)
> -#define STATUS_FWP_WRONG_SESSION cpu_to_le32(0xC022000C)
> -#define STATUS_FWP_NO_TXN_IN_PROGRESS cpu_to_le32(0xC022000D)
> -#define STATUS_FWP_TXN_IN_PROGRESS cpu_to_le32(0xC022000E)
> -#define STATUS_FWP_TXN_ABORTED cpu_to_le32(0xC022000F)
> -#define STATUS_FWP_SESSION_ABORTED cpu_to_le32(0xC0220010)
> -#define STATUS_FWP_INCOMPATIBLE_TXN cpu_to_le32(0xC0220011)
> -#define STATUS_FWP_TIMEOUT cpu_to_le32(0xC0220012)
> -#define STATUS_FWP_NET_EVENTS_DISABLED cpu_to_le32(0xC0220013)
> -#define STATUS_FWP_INCOMPATIBLE_LAYER cpu_to_le32(0xC0220014)
> -#define STATUS_FWP_KM_CLIENTS_ONLY cpu_to_le32(0xC0220015)
> -#define STATUS_FWP_LIFETIME_MISMATCH cpu_to_le32(0xC0220016)
> -#define STATUS_FWP_BUILTIN_OBJECT cpu_to_le32(0xC0220017)
> -#define STATUS_FWP_TOO_MANY_BOOTTIME_FILTERS cpu_to_le32(0xC0220018)
> -#define STATUS_FWP_TOO_MANY_CALLOUTS cpu_to_le32(0xC0220018)
> -#define STATUS_FWP_NOTIFICATION_DROPPED cpu_to_le32(0xC0220019)
> -#define STATUS_FWP_TRAFFIC_MISMATCH cpu_to_le32(0xC022001A)
> -#define STATUS_FWP_INCOMPATIBLE_SA_STATE cpu_to_le32(0xC022001B)
> -#define STATUS_FWP_NULL_POINTER cpu_to_le32(0xC022001C)
> -#define STATUS_FWP_INVALID_ENUMERATOR cpu_to_le32(0xC022001D)
> -#define STATUS_FWP_INVALID_FLAGS cpu_to_le32(0xC022001E)
> -#define STATUS_FWP_INVALID_NET_MASK cpu_to_le32(0xC022001F)
> -#define STATUS_FWP_INVALID_RANGE cpu_to_le32(0xC0220020)
> -#define STATUS_FWP_INVALID_INTERVAL cpu_to_le32(0xC0220021)
> -#define STATUS_FWP_ZERO_LENGTH_ARRAY cpu_to_le32(0xC0220022)
> -#define STATUS_FWP_NULL_DISPLAY_NAME cpu_to_le32(0xC0220023)
> -#define STATUS_FWP_INVALID_ACTION_TYPE cpu_to_le32(0xC0220024)
> -#define STATUS_FWP_INVALID_WEIGHT cpu_to_le32(0xC0220025)
> -#define STATUS_FWP_MATCH_TYPE_MISMATCH cpu_to_le32(0xC0220026)
> -#define STATUS_FWP_TYPE_MISMATCH cpu_to_le32(0xC0220027)
> -#define STATUS_FWP_OUT_OF_BOUNDS cpu_to_le32(0xC0220028)
> -#define STATUS_FWP_RESERVED cpu_to_le32(0xC0220029)
> -#define STATUS_FWP_DUPLICATE_CONDITION cpu_to_le32(0xC022002A)
> -#define STATUS_FWP_DUPLICATE_KEYMOD cpu_to_le32(0xC022002B)
> -#define STATUS_FWP_ACTION_INCOMPATIBLE_WITH_LAYER cpu_to_le32(0xC022002C=
)
> -#define STATUS_FWP_ACTION_INCOMPATIBLE_WITH_SUBLAYER cpu_to_le32(0xC0220=
02D)
> -#define STATUS_FWP_CONTEXT_INCOMPATIBLE_WITH_LAYER cpu_to_le32(0xC022002=
E)
> -#define STATUS_FWP_CONTEXT_INCOMPATIBLE_WITH_CALLOUT cpu_to_le32(0xC0220=
02F)
> -#define STATUS_FWP_INCOMPATIBLE_AUTH_METHOD cpu_to_le32(0xC0220030)
> -#define STATUS_FWP_INCOMPATIBLE_DH_GROUP cpu_to_le32(0xC0220031)
> -#define STATUS_FWP_EM_NOT_SUPPORTED cpu_to_le32(0xC0220032)
> -#define STATUS_FWP_NEVER_MATCH cpu_to_le32(0xC0220033)
> -#define STATUS_FWP_PROVIDER_CONTEXT_MISMATCH cpu_to_le32(0xC0220034)
> -#define STATUS_FWP_INVALID_PARAMETER cpu_to_le32(0xC0220035)
> -#define STATUS_FWP_TOO_MANY_SUBLAYERS cpu_to_le32(0xC0220036)
> -#define STATUS_FWP_CALLOUT_NOTIFICATION_FAILED cpu_to_le32(0xC0220037)
> -#define STATUS_FWP_INCOMPATIBLE_AUTH_CONFIG cpu_to_le32(0xC0220038)
> -#define STATUS_FWP_INCOMPATIBLE_CIPHER_CONFIG cpu_to_le32(0xC0220039)
> -#define STATUS_FWP_TCPIP_NOT_READY cpu_to_le32(0xC0220100)
> -#define STATUS_FWP_INJECT_HANDLE_CLOSING cpu_to_le32(0xC0220101)
> -#define STATUS_FWP_INJECT_HANDLE_STALE cpu_to_le32(0xC0220102)
> -#define STATUS_FWP_CANNOT_PEND cpu_to_le32(0xC0220103)
> -#define STATUS_NDIS_CLOSING cpu_to_le32(0xC0230002)
> -#define STATUS_NDIS_BAD_VERSION cpu_to_le32(0xC0230004)
> -#define STATUS_NDIS_BAD_CHARACTERISTICS cpu_to_le32(0xC0230005)
> -#define STATUS_NDIS_ADAPTER_NOT_FOUND cpu_to_le32(0xC0230006)
> -#define STATUS_NDIS_OPEN_FAILED cpu_to_le32(0xC0230007)
> -#define STATUS_NDIS_DEVICE_FAILED cpu_to_le32(0xC0230008)
> -#define STATUS_NDIS_MULTICAST_FULL cpu_to_le32(0xC0230009)
> -#define STATUS_NDIS_MULTICAST_EXISTS cpu_to_le32(0xC023000A)
> -#define STATUS_NDIS_MULTICAST_NOT_FOUND cpu_to_le32(0xC023000B)
> -#define STATUS_NDIS_REQUEST_ABORTED cpu_to_le32(0xC023000C)
> -#define STATUS_NDIS_RESET_IN_PROGRESS cpu_to_le32(0xC023000D)
> -#define STATUS_NDIS_INVALID_PACKET cpu_to_le32(0xC023000F)
> -#define STATUS_NDIS_INVALID_DEVICE_REQUEST cpu_to_le32(0xC0230010)
> -#define STATUS_NDIS_ADAPTER_NOT_READY cpu_to_le32(0xC0230011)
> -#define STATUS_NDIS_INVALID_LENGTH cpu_to_le32(0xC0230014)
> -#define STATUS_NDIS_INVALID_DATA cpu_to_le32(0xC0230015)
> -#define STATUS_NDIS_BUFFER_TOO_SHORT cpu_to_le32(0xC0230016)
> -#define STATUS_NDIS_INVALID_OID cpu_to_le32(0xC0230017)
> -#define STATUS_NDIS_ADAPTER_REMOVED cpu_to_le32(0xC0230018)
> -#define STATUS_NDIS_UNSUPPORTED_MEDIA cpu_to_le32(0xC0230019)
> -#define STATUS_NDIS_GROUP_ADDRESS_IN_USE cpu_to_le32(0xC023001A)
> -#define STATUS_NDIS_FILE_NOT_FOUND cpu_to_le32(0xC023001B)
> -#define STATUS_NDIS_ERROR_READING_FILE cpu_to_le32(0xC023001C)
> -#define STATUS_NDIS_ALREADY_MAPPED cpu_to_le32(0xC023001D)
> -#define STATUS_NDIS_RESOURCE_CONFLICT cpu_to_le32(0xC023001E)
> -#define STATUS_NDIS_MEDIA_DISCONNECTED cpu_to_le32(0xC023001F)
> -#define STATUS_NDIS_INVALID_ADDRESS cpu_to_le32(0xC0230022)
> -#define STATUS_NDIS_PAUSED cpu_to_le32(0xC023002A)
> -#define STATUS_NDIS_INTERFACE_NOT_FOUND cpu_to_le32(0xC023002B)
> -#define STATUS_NDIS_UNSUPPORTED_REVISION cpu_to_le32(0xC023002C)
> -#define STATUS_NDIS_INVALID_PORT cpu_to_le32(0xC023002D)
> -#define STATUS_NDIS_INVALID_PORT_STATE cpu_to_le32(0xC023002E)
> -#define STATUS_NDIS_LOW_POWER_STATE cpu_to_le32(0xC023002F)
> -#define STATUS_NDIS_NOT_SUPPORTED cpu_to_le32(0xC02300BB)
> -#define STATUS_NDIS_DOT11_AUTO_CONFIG_ENABLED cpu_to_le32(0xC0232000)
> -#define STATUS_NDIS_DOT11_MEDIA_IN_USE cpu_to_le32(0xC0232001)
> -#define STATUS_NDIS_DOT11_POWER_STATE_INVALID cpu_to_le32(0xC0232002)
> -#define STATUS_IPSEC_BAD_SPI cpu_to_le32(0xC0360001)
> -#define STATUS_IPSEC_SA_LIFETIME_EXPIRED cpu_to_le32(0xC0360002)
> -#define STATUS_IPSEC_WRONG_SA cpu_to_le32(0xC0360003)
> -#define STATUS_IPSEC_REPLAY_CHECK_FAILED cpu_to_le32(0xC0360004)
> -#define STATUS_IPSEC_INVALID_PACKET cpu_to_le32(0xC0360005)
> -#define STATUS_IPSEC_INTEGRITY_CHECK_FAILED cpu_to_le32(0xC0360006)
> -#define STATUS_IPSEC_CLEAR_TEXT_DROP cpu_to_le32(0xC0360007)
> -
> -#define STATUS_NO_PREAUTH_INTEGRITY_HASH_OVERLAP cpu_to_le32(0xC05D0000)
> -#define STATUS_INVALID_LOCK_RANGE cpu_to_le32(0xC00001a1)
> diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_rdm=
a.c
> index cf4418f72772..44c87e300c16 100644
> --- a/fs/smb/server/transport_rdma.c
> +++ b/fs/smb/server/transport_rdma.c
> @@ -21,7 +21,7 @@
>  #include "glob.h"
>  #include "connection.h"
>  #include "smb_common.h"
> -#include "smbstatus.h"
> +#include "../common/smb2status.h"
>  #include "transport_rdma.h"
>
>  #define SMB_DIRECT_PORT_IWARP          5445
> --
> 2.34.1
>
>


--=20
Thanks,

Steve

