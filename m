Return-Path: <linux-cifs+bounces-4118-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 59518A39066
	for <lists+linux-cifs@lfdr.de>; Tue, 18 Feb 2025 02:33:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E55147A35D4
	for <lists+linux-cifs@lfdr.de>; Tue, 18 Feb 2025 01:32:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6997054279;
	Tue, 18 Feb 2025 01:33:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="aQSumd+W"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A382426289
	for <linux-cifs@vger.kernel.org>; Tue, 18 Feb 2025 01:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739842421; cv=none; b=baIP2/eaWxOjQ0J3Qq/Ewh+zYj0mk6rHmvqcMPNoYQvEXrzHb88MQ/3Vi/XQrBEMzcCgB6Gb0MRJ0a0Sl64qfnsN5ECiit7OhKQtIi6DZ1XUlNKyTti7Lk4HdC+MVOUJAONz5uFoYlRvH/vlk7fwedvMft6Dro0T4/RfkglyTig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739842421; c=relaxed/simple;
	bh=PqldUid8b28osb9ruzZdoEBTz6JRlxB54ChBBiDaolI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Cs4ZoVUBTLOjKiYBvi+VGlVDAzMLTFPLuJ65JRU86kdeOUAlY36RbFzXKVXotI+MPU6+kwowt7lbPtqag8hBZB7TGQHteX3PpOsJXN9oxLgGhK3VfRCcmOQLyAJRHWh2MMipBgTfW+QEdLcKIfyCDba6wzdR3mlz6PsygSPZbf8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=aQSumd+W; arc=none smtp.client-ip=209.85.214.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f172.google.com with SMTP id d9443c01a7336-220c665ef4cso71929475ad.3
        for <linux-cifs@vger.kernel.org>; Mon, 17 Feb 2025 17:33:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1739842419; x=1740447219; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UmpmFjzx9bUrYvZxoU2dK5gnUuqgFd21wJOsMgZc0Ns=;
        b=aQSumd+WtyWu3MtKdTAvVIWEStWO9g01MpjM8dVceX6Y62HG+inQ3I5/gYcYEv5tSB
         K27maldMzqmaGIOCf80oE86gA2SEhc75fFq6H/TcuSwBWS9EvMVu/twDqvLycCf4Ixfz
         6A+ErNrvAyPcjpMbmvw/YSxWOH1rrsKJtzKzKFjbXZm3uvDhD2h79irMJ8BFsk7QQ8lu
         JG7GCIGQuoUa4oNHEmLcAEl9bRZ0hPc3IjJXUAEy9NlHrdxcZ856KTqgkklMOtBl7Ltf
         xaTQFe0ANPw/0fhFGsJbI25vk9sraUDwQ/U5ITD1Ml/YHhkuqX4VnopPg69w3VErw+PZ
         a+uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739842419; x=1740447219;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmpmFjzx9bUrYvZxoU2dK5gnUuqgFd21wJOsMgZc0Ns=;
        b=vUFKU/bf5dUCHlOZJfm85YCBcLbBcTq1d0KppAe8YbrtQvultsmOZ/4psepzeWQfsj
         MiUnTdM6YSxf4jdZSSiUiGZrlDNmx/HXWPeuqtEcojW9yTy7GT6e9Gfj+cihc1QGrlAc
         VbFVNMPtO48JZdwRehEVzm55j6w8o3DecUUiGEfN25e0Tx4WVlruHZhZaUabGT8CJtlS
         BjkH//ecuX8c0fwbTEPaqyAVtT4/9GRLudiiL8+AN0q0bQAgs+hy1lU1e0F7NrknqwTi
         x08ywVB8f3X58MjOFbBVmjGdBhtWMiO2iNc2tV2x/gKLa4z7Qpv3uwxG6S8pz0s84E3V
         ebew==
X-Forwarded-Encrypted: i=1; AJvYcCVNRxdWwHOgEulZpixOz1yU1w3lVH7FVRaaWwm0klWfm7fq+HSFRSgULdYJCzD2hPmvfN9Tyk3BdxmI@vger.kernel.org
X-Gm-Message-State: AOJu0YyorvLrOnBHiOEW1tZ5nHMjR8MkWTUOEpLE0BgBObHsn1lf2wE3
	9vc4cwsUNxjT0sXcjC2t/hR3ELrRZrHO7m1u4sVvNV7HLcgIxHESDP1JobIW8YU=
X-Gm-Gg: ASbGncuDf+mNYxPqgRaeYaTQ7tve1VXWLyPA0xCu45RDY6UpIOpDCjlfyHTpmztDQjW
	QqZrOfvcbC3/J39yhVHlT22lRq1y0nKOxIZqGq8JheRDTjGu2wNRoIYBf7C+4+digG+SnxPtnjr
	mlfxB1gabVah5R64aRsEjXqqwNXQugzQIRNej+szVb4gKzGnIx2k958vehPBOqKjQRV82JPpxVa
	6qSSZ+8fe4b+LK7K0NXRIe4oIqPMarApdd6QvOkt1X9QfgyQpH6sNIX2w4O7g+kJbpVEHHGmmdi
	fS6b5kzzVkV7YKEmsGg5R7qXJqnfew780OrzmV1jyG3TVOhof5DOx1zE
X-Google-Smtp-Source: AGHT+IHh0FY+Jv7gaSRcfnfFJ7EpcQsaZBH/WADBW2TP7ttlwXE5cmoU6puqsc/FMsvUfWC2fhP2Rg==
X-Received: by 2002:a05:6a21:1fc8:b0:1ee:be05:1e2 with SMTP id adf61e73a8af0-1eebe05953emr5291079637.15.1739842418940;
        Mon, 17 Feb 2025 17:33:38 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-73274bdf0aasm3434763b3a.125.2025.02.17.17.33.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Feb 2025 17:33:38 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tkCUR-00000002cJb-3K4F;
	Tue, 18 Feb 2025 12:33:35 +1100
Date: Tue, 18 Feb 2025 12:33:35 +1100
From: Dave Chinner <david@fromorbit.com>
To: Amir Goldstein <amir73il@gmail.com>
Cc: Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
	Eric Biggers <ebiggers@kernel.org>,
	"Darrick J. Wong" <djwong@kernel.org>,
	ronnie sahlberg <ronniesahlberg@gmail.com>,
	Chuck Lever <chuck.lever@oracle.com>,
	Christian Brauner <brauner@kernel.org>, Jan Kara <jack@suse.cz>,
	Steve French <sfrench@samba.org>,
	Alexander Viro <viro@zeniv.linux.org.uk>,
	linux-fsdevel@vger.kernel.org, linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/4] fs: Add FS_XFLAG_COMPRESSED & FS_XFLAG_ENCRYPTED
 for FS_IOC_FS[GS]ETXATTR API
Message-ID: <Z7Pjb5tI6jJDlFZn@dread.disaster.area>
References: <20250216164029.20673-1-pali@kernel.org>
 <20250216164029.20673-2-pali@kernel.org>
 <20250216183432.GA2404@sol.localdomain>
 <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
 <20250216202441.d3re7lfky6bcozkv@pali>
 <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>

On Sun, Feb 16, 2025 at 09:43:02PM +0100, Amir Goldstein wrote:
> On Sun, Feb 16, 2025 at 9:24 PM Pali Rohár <pali@kernel.org> wrote:
> >
> > On Sunday 16 February 2025 21:17:55 Amir Goldstein wrote:
> > > On Sun, Feb 16, 2025 at 7:34 PM Eric Biggers <ebiggers@kernel.org> wrote:
> > > >
> > > > On Sun, Feb 16, 2025 at 05:40:26PM +0100, Pali Rohár wrote:
> > > > > This allows to get or set FS_COMPR_FL and FS_ENCRYPT_FL bits via FS_IOC_FSGETXATTR/FS_IOC_FSSETXATTR API.
> > > > >
> > > > > Signed-off-by: Pali Rohár <pali@kernel.org>
> > > >
> > > > Does this really allow setting FS_ENCRYPT_FL via FS_IOC_FSSETXATTR, and how does
> > > > this interact with the existing fscrypt support in ext4, f2fs, ubifs, and ceph
> > > > which use that flag?
> > >
> > > As far as I can tell, after fileattr_fill_xflags() call in
> > > ioctl_fssetxattr(), the call
> > > to ext4_fileattr_set() should behave exactly the same if it came some
> > > FS_IOC_FSSETXATTR or from FS_IOC_SETFLAGS.
> > > IOW, EXT4_FL_USER_MODIFIABLE mask will still apply.
> > >
> > > However, unlike the legacy API, we now have an opportunity to deal with
> > > EXT4_FL_USER_MODIFIABLE better than this:
> > >         /*
> > >          * chattr(1) grabs flags via GETFLAGS, modifies the result and
> > >          * passes that to SETFLAGS. So we cannot easily make SETFLAGS
> > >          * more restrictive than just silently masking off visible but
> > >          * not settable flags as we always did.
> > >          */
> > >
> > > if we have the xflags_mask in the new API (not only the xflags) then
> > > chattr(1) can set EXT4_FL_USER_MODIFIABLE in xflags_mask
> > > ext4_fileattr_set() can verify that
> > > (xflags_mask & ~EXT4_FL_USER_MODIFIABLE == 0).
> > >
> > > However, Pali, this is an important point that your RFC did not follow -
> > > AFAICT, the current kernel code of ext4_fileattr_set() and xfs_fileattr_set()
> > > (and other fs) does not return any error for unknown xflags, it just
> > > ignores them.
> > >
> > > This is why a new ioctl pair FS_IOC_[GS]ETFSXATTR2 is needed IMO
> > > before adding support to ANY new xflags, whether they are mapped to
> > > existing flags like in this patch or are completely new xflags.
> > >
> > > Thanks,
> > > Amir.
> >
> > But xflags_mask is available in this new API. It is available if the
> > FS_XFLAG_HASEXTFIELDS flag is set. So I think that the ext4 improvement
> > mentioned above can be included into this new API.
> >
> > Or I'm missing something?
> 
> Yes, you are missing something very fundamental to backward compat API -
> You cannot change the existing kernels.
> 
> You should ask yourself one question:
> What happens if I execute the old ioctl FS_IOC_FSSETXATTR
> on an existing old kernel with the new extended flags?

It should ignore all the things it does not know about.

But the correct usage of FS_IOC_FSSETXATTR is to call
FS_IOC_FSGETXATTR to initialise the structure with all the current
inode state. In this situation, the fsx.fsx_xflags field needs to
return a flag that says "FS_XFLAGS_HAS_WIN_ATTRS" and now userspace
knows that it can set/clear the MS windows attr flags.  Hence if the
filesystem supports windows attributes, we can require them to
-support the entire set-.

i.e. if an attempt to set a win attr that the filesystem cannot
implement (e.g. compression) then it returns an error (-EINVAL),
otherwise it will store the attr and perform whatever operation it
requires.

IMO, the whole implementation in the patchset is wrong - there is no
need for a new xflags2 field, and there is no need for whacky field
masks or anything like that. All it needs is a single bit to
indicate if the windows attributes are supported, and they are all
implemented as normal FS_XFLAG fields in the fsx_xflags field.

> The answer, to the best of my code emulation abilities is that
> old kernel will ignore the new xflags including FS_XFLAG_HASEXTFIELDS
> and this is suboptimal, because it would be better for the new chattr tool
> to get -EINVAL when trying to set new xflags and mask on an old kernel.

What new chattr tool? I would expect that xfs_io -c "chattr ..."
will be extended to support all these new fields because that is the
historical tool we use for FS_IOC_FS{GS}ETXATTR regression test
support in fstests. I would also expect that the e2fsprogs chattr(1)
program to grow support for the new FS_XFLAGS bits as well...

> It is true that the new chattr can call the old FS_IOC_FSGETXATTR
> ioctl and see that it has no FS_XFLAG_HASEXTFIELDS,
> so I agree that a new ioctl is not absolutely necessary,
> but I still believe that it is a better API design.

This is how FS{GS}ETXATTR interface has always worked. You *must*
do a GET before a SET so that the fsx structure has been correctly
initialised so the SET operation makes only the exact change being
asked for.

This makes the -API pair- backwards compatible by allowing struct
fsxattr feature bits to be reported in the GET operation. If the
feature bit is set, then those optional fields can be set. If the
feature bit is not set by the GET operation, then if you try to use
it on a SET operation you'll either get an error or it will be
silently ignored.

> Would love to hear what other fs developers prefer.

Do not overcomplicate the problem. Use the interface as intended:
GET then SET, and GET returns feature bits in the xflags field to
indicate what is valid in the overall struct fsxattr. It's trivial
to probe for native fs support of windows attributes like this. It
also allows filesystems to be converted one at a time to support the
windows attributes (e.g. as they have on-disk format support for
them added). Applications like Samba can then switch behaviours
based on what they probe from the underlying filesystem...

-Dave.
-- 
Dave Chinner
david@fromorbit.com

