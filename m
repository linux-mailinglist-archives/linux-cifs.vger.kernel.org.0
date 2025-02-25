Return-Path: <linux-cifs+bounces-4183-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A7ECA433BD
	for <lists+linux-cifs@lfdr.de>; Tue, 25 Feb 2025 04:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 868DA17765E
	for <lists+linux-cifs@lfdr.de>; Tue, 25 Feb 2025 03:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE4D424CED6;
	Tue, 25 Feb 2025 03:42:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b="sVCQfkiw"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C12A367
	for <linux-cifs@vger.kernel.org>; Tue, 25 Feb 2025 03:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740454940; cv=none; b=ihbqDx/quJhDRKL90jnOn0KsBdubnp0FdybF0fOGKpwat8SoB3OmvvnxjXfZsbJXECR/d/BobhvqkMJu6ZZ8PQJhZ4zvozW2nkVv93AgaPuKnR5ByaSS9s4pjyRYf89SBouRxQUJjmfoSheLSG2ODtnrV2YxkFpOtB787QAOkyw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740454940; c=relaxed/simple;
	bh=9jj19+NzLuiuNb0sAf3HxNj5pndd5pUpK7+tsjaRNrk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Pp8UmvfuUxIPt+knYjDMBteU29WDop1+tf2oZmJ/mW/e6mfxCJhzPB6EJn5mSi3ryhKC/y3PRxxBcHAa2KMnPfUQW+RGXDMavpnx0y8vyABDxTFR8DuYZ6IreDY173PLjE27AeuIvCu5OtNLgJXG2tXSvsM9NLTLYtQY+TNnZ3I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com; spf=pass smtp.mailfrom=fromorbit.com; dkim=pass (2048-bit key) header.d=fromorbit-com.20230601.gappssmtp.com header.i=@fromorbit-com.20230601.gappssmtp.com header.b=sVCQfkiw; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fromorbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fromorbit.com
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-221050f3f00so115883625ad.2
        for <linux-cifs@vger.kernel.org>; Mon, 24 Feb 2025 19:42:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fromorbit-com.20230601.gappssmtp.com; s=20230601; t=1740454938; x=1741059738; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=heiclrdqjdt9ptSQvJcywwubX1oHcT/mg99JdqMdOJc=;
        b=sVCQfkiwm7U/0MXbJuF2xus/d6Nt0iYqQ4AXqiTcTVk22l6gG6ccQrniqq4yBWi6zN
         c/VHLu+mOFR/+k1kxlWTpDqnqU9HZxIBoN+Fpz7zxBHrkGFud5AZRF0aEqQclkzMQLjw
         NK0QHfRn8nGn17GAZTIZjy7wHJ7jOTtsHOa1e6beg6Mcluf/2Ml0DIQHaVx8qLenLfBB
         17taZWkhNGgMqIYnNNTx1Ngdbg2Tm4dsS0ca8ocbh6sOxPpj0MZhbmhZC6KiPhu2hynv
         vTFBKbX3J88WXdaW2MTNbQhwiC9v/TUryX1AzJFN5fxqR2FHohszZEEc7PuxORRM/IHA
         L9TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740454938; x=1741059738;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=heiclrdqjdt9ptSQvJcywwubX1oHcT/mg99JdqMdOJc=;
        b=WDb3RhQK2NcZK2e3zRu8IYt6TPR+fo33ETVC4BHqxL1bn5JU7jgDpICxTbpcUjovWj
         CPF6RJO17AVN3mmqa6Z9uZS+louYgf6H9hNxJeiXIugh+PG/F+nTo8hUYUNhmC3U/0vm
         gXYMi7MGygO4o9UbPMJJo9dfjECz54uXyWB0piZ6M9SBnFbeXT52mHrlkcAuvIzHcyI5
         6cntMNF1IHq2gaUEMS1j0fF3r0N/0P7DH8RyjX4T6X9aNWJx06BdeGxGAd0xY9CbARpp
         WGIN4Lw+k1uL1K8tDV0925u/wi0d2VyJ/bIsrxApAdsSHPcxtwC1E0WRcUKy15uG2b76
         oezw==
X-Forwarded-Encrypted: i=1; AJvYcCUVtpoigVgam40Nmhx3SWsPTcRFBrjlubId41kpaf19FBwn5vLdRdwkDZ8ysCiAQRLPslDNHs8RmB8C@vger.kernel.org
X-Gm-Message-State: AOJu0Yw/rgkLSgQrkVUFrpp7aBH0Q+sJDwbAaMUaVBUiVG5cUGB2l5vh
	3CZxMa/aGyJOOasMJaEYTgCfMbXENovQIZijzwSizcw1ZFYLU8Q0nCpNCnax6F0=
X-Gm-Gg: ASbGncuUH4X9bihvApuQPlQITDJvDzTVspkcRWvf74k76BGpZ7i1Z+wRwUkACLbJXEZ
	3wcgToGW03qwpKQOSTmPBCwJqovH6SUAROPQylcgDSFR8x9FCNmn4oFmfGHRqEBFsQ4ux8kNvd4
	QVOYYMnq8I6cbBMXWaHM8YQ7uEgkQo58lWGJ694vnI9Cr3IyI9Plx0SVivScEPIcJkzg4hxWjJd
	z7Cn6/ggm9SaWgLG9qMCYDuzDEuqjZt6LJyt09F1zZ/inQ/aZtLan9M9Wvwvm7WPO4s5Yrt5iJi
	6Cd6cKVhBbXiMCJzT03ebaSERGy1r/IreCi7TMcQ1zF8xzKUA3dfUYdRIZL87g/AmvKJX0okTWa
	q/A==
X-Google-Smtp-Source: AGHT+IFu9ZTqMmFmKgq2BwNevmgyVHSAbFB+fe6KcaqwYov8nGeJ6zB/x+emYSs02kt5foE3WTELdQ==
X-Received: by 2002:a05:6a00:1310:b0:730:9567:c3d5 with SMTP id d2e1a72fcca58-7347909fee5mr2844300b3a.4.1740454938499;
        Mon, 24 Feb 2025 19:42:18 -0800 (PST)
Received: from dread.disaster.area (pa49-186-89-135.pa.vic.optusnet.com.au. [49.186.89.135])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-aedaa643b1asm285306a12.49.2025.02.24.19.42.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2025 19:42:17 -0800 (PST)
Received: from dave by dread.disaster.area with local (Exim 4.98)
	(envelope-from <david@fromorbit.com>)
	id 1tmlpm-00000005cIf-1lpb;
	Tue, 25 Feb 2025 14:42:14 +1100
Date: Tue, 25 Feb 2025 14:42:14 +1100
From: Dave Chinner <david@fromorbit.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Amir Goldstein <amir73il@gmail.com>,
	Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
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
Message-ID: <Z708FirwXbRFBqGj@dread.disaster.area>
References: <CAOQ4uxigYpzpttfaRc=xAxJc=f2bz89_eCideuftf3egTiE+3A@mail.gmail.com>
 <20250216202441.d3re7lfky6bcozkv@pali>
 <CAOQ4uxj4urR70FmLB_4Qwbp1O5TwvHWSW6QPTCuq7uXp033B7Q@mail.gmail.com>
 <Z7Pjb5tI6jJDlFZn@dread.disaster.area>
 <CAOQ4uxh6aWO7Emygi=dXCE3auDcZZCmDP+jmjhgdffuz1Vx6uQ@mail.gmail.com>
 <20250218192701.4q22uaqdyjxfp4p3@pali>
 <Z7UQHL5odYOBqAvo@dread.disaster.area>
 <20250218230643.fuc546ntkq3nnnom@pali>
 <CAOQ4uxiAU7UorH1FLcPgoWMXMGRsOt77yRQ12Xkmzcxe8qYuVw@mail.gmail.com>
 <20250221163443.GA2128534@mit.edu>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250221163443.GA2128534@mit.edu>

On Fri, Feb 21, 2025 at 11:34:43AM -0500, Theodore Ts'o wrote:
> I think a few people were talking past each other, because there are two
> fileds in struct fileattr --- flags, and fsx_xflags.  The flags field
> is what was originally used by FS_IOC_EXT2_[GS]ETFLAGS, which later

I don't think anyone has been confusing the two - the entire
discussion has been about fsx_xflags and the struct fsxattr...

> started getting used by many other file systems, starting with
> resierfs and btrfs, and so it became FS_IOC_[GS]ETFLAGS.  The bits in
> that flags word were both the ioctl ABI and the on-disk encoding, and
> because we were now allowing multiple file systems to allocate bits,
> and we needed to avoid stepping on each other (for example since btrfs
> started using FS_NOCOW_FL, that bit position wouldn't be used by ext4,
> at least not for a publically exported flag).
> 
> So we started running out of space in the FS_FLAG_*_FL namespace, and
> that's why we created FS_IOC_[GS]ETXATTR and the struct fsxattr.  The

No, that is most certainly not how this API came about. 

The FS_IOC_[GS]ETXATTR ioctls were first implement on IRIX close on
30 years ago. They were ported to Linux with the XFS linux port over
2 decades ago. Indeed, we've been using them for xfsdump/xfs_restore
since before XFS was ported to linux.

They got lifted to the VFS back in 2016 so that ext4 could use the
interface for getting/setting project IDs on files. This was done so
that existing userspace functionality for setting up
project/directory quotas on XFS could also be used on ext4.

> FS_XFLAG_*_FL space has plenty of space; there are 14 unassigned bit
> positions, by my count.
> 
> As far as the arguments about "proper interface design", as far as
> Linux is concerned, backwards compatibility trumps "we should have
> done if it differently".  The one and only guarantee that we have that
> FS_IOC_GETXATTR followed by FS_IOC_SETXATTR will work.  Nothing else.

That's a somewhat naive understanding of the overall API. The struct
fsxattr information is also directly exported to userspace via the
XFS blukstat ioctls. i.e. extent size hints, fsx_xflags, project
IDs, etc are all exported to userspace via multiple ioctl
interfaces.

This is all used by xfsdump/xfs_restore to be able to back up and
restore the inode state that is exposed/controlled by the
GET/SETXATTR interfaces.

> The use case of "what if a backup program wants to backup the flags
> and restore on a different file system" is one that hasn't been
> considered, and I don't think any backup programs do it today.

Wrong. As I've already said: we have been doing exactly this for 20+
years with xfsdump/restore.

xfsdump uses the bulkstat version of the GET interface, whilst
restore uses the FS_IOC_SETXATTR interface.

> For
> that matter, some of the flags, such as the NODUMP flag, are designed
> to be instructions to a dump/restore system, and not really one that
> *should* be backed up.

Yes. xfsdump sees this in the bulkstat flags field for the inode and
then omits the inode from the dump.

Further, xfs_fsr (the online file defragmenter for XFS) uses
bulkstat and looks at the FS_XFLAGS returned from bulkstat for each
inode it scans.

> Again, the only semantic that was guaranteed
> is GETXATTR or GETXATTR followed by SETXATTR.

For making a single delta state change, yes.

For the dump/restore case, calling SETXATTR on a newly created file
with a preconstructed struct fsxattr state retreived at dump time is
also supported.

This is not a general use case - it will destroy any existing state
that file was created with (e.g. override admin inheritence
settings) by overwriting it with the state from the backup.

It should also be noted that xfs_restore does this in two SETXATTR
calls, not one. i.e. it splits the set operation into a
pre-data restore SETXATTR, and one post-data restore SETXATTR.

Why?

Because stuff like extent size hints and realtime state needs to be
restored before any data is written whilst others can only be set
after the data has been written because they would otherwise prevent
data restoration:

/* extended inode flags that can only be set after all data
 * has been restored to a file.
 */
#define POST_DATA_XFLAGS        (XFS_XFLAG_IMMUTABLE |          \
                                  XFS_XFLAG_APPEND |            \
                                  XFS_XFLAG_SYNC)

Yup, you can't restore data to the file if it has already been
marked as immutable....

IOWs, any changes to the flag space also needs to be compatible with
the XFS bulkstat shadowing of the fsxattr fields+flags and the
existing usage of these APIs by xfsdump, xfs_restore and xfs_fsr.

> We can define some new interface for return what xflags are supported
> by a particular file system.

Why do we even care?

On the get side, it just doesn't matter - if the flag isn't set, it
either is not active or not supported. Either way, it doesn't
matter if there's a "this is supported mask".

On the set side, adding a mask isn't going to change historic
behaviour: existing applications will ignore the new mask because
they haven't been coded to understand it. And vice versa, an old
kernel will ignore the feature mask if the app uses it because it
ignores unknown flags/fields.

IOWs, adding a feature mask doesn't solve any of the problems
related to forwards/backwards compatibility of new features, and so
we are back to needing to use the API as a GET/SET pair where the
GET sets all the known state correctly such that a SET operation
will either do nothing, change the state or return an error because
an invalid combination of known parameters was passed.

> I suppose the field could double as the bitmask field when
> FS_IOC_SETXATTR is called, but that just seems to be an overly complex
> set of semantics.  If someone really wants to do that, I wouldn't
> really complain, but then what we would actually call the field
> "flags_supported_on_get_bitmask_on_set" would seem a bit wordy.  :-)

That effectively prevents the existing dump/restore usage of the
API.

-Dave.
-- 
Dave Chinner
david@fromorbit.com

