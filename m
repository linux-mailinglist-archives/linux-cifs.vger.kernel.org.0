Return-Path: <linux-cifs+bounces-4011-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BECFFA2BB3A
	for <lists+linux-cifs@lfdr.de>; Fri,  7 Feb 2025 07:14:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3642D1889D8F
	for <lists+linux-cifs@lfdr.de>; Fri,  7 Feb 2025 06:14:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 63A07234989;
	Fri,  7 Feb 2025 06:13:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="jFlX92+O"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-174.mta0.migadu.com (out-174.mta0.migadu.com [91.218.175.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D75233156
	for <linux-cifs@vger.kernel.org>; Fri,  7 Feb 2025 06:13:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738908797; cv=none; b=fRzIk25OtI/0Msg0sTbF4pjMfdWpQXmu67z4DvgGie7K17wXRnDyV0qo3eH/7p0vTD0Mzjvq+1qS1x7npAwlXde3XRA/WJy2xwjFeS6r5mMmywURoUcwCUBQsfzg45V9QI9hsp+YWnwhcaHQsz+vRhG6XxMGJYBroCXRfLAGBhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738908797; c=relaxed/simple;
	bh=Y06M5hCOP0MaetwKFX4R2tbficSbU9BmACGKYWMJz24=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k+kaQQ8fkNuKXKWnpn0CYPTYj4EaWhz1yJwGMPFlHUdz+LdDPKnjsoG9oWVLIuICc0+Y/OJffLuQaafSSGkljV+WQp+/fAcmqOxkvktBLJDNdBUtk3u/cpkHJQgUuTFMyrpvfvFdlM9BL8wNk1bcX8IJe1Ky/BJw6qY9VnV2NXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=jFlX92+O; arc=none smtp.client-ip=91.218.175.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Feb 2025 01:13:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738908788;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Vp/7w+5+gHtLzNMyTTGU+CF/tisriG9HJKcgsxxRakM=;
	b=jFlX92+OnE8ydenzK+ydzPLb2u1I4HqC5s95spytTfGnNCMvKP0vIUChpgrFUlEkEKY6ch
	1gy8ha+LqcX1vRvEwZHpCbeGrOnBxrPmWqX0vLRUp4kG5KDNYr/kaA2AHfDl2xxXA8xEFU
	Neb7kDfKR6Kbtwq39lPVcy/uwj/6D8M=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: NeilBrown <neilb@suse.de>
Cc: Christian Brauner <brauner@kernel.org>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael@kernel.org>, 
	Danilo Krummrich <dakr@kernel.org>, Trond Myklebust <trondmy@kernel.org>, 
	Anna Schumaker <anna@kernel.org>, Namjae Jeon <linkinjeon@kernel.org>, 
	Steve French <sfrench@samba.org>, Sergey Senozhatsky <senozhatsky@chromium.org>, 
	Tom Talpey <tom@talpey.com>, Paul Moore <paul@paul-moore.com>, Eric Paris <eparis@redhat.com>, 
	linux-kernel@vger.kernel.org, linux-bcachefs@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
	linux-nfs@vger.kernel.org, linux-cifs@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH 1/2] VFS: change kern_path_locked() and
 user_path_locked_at() to never return negative dentry
Message-ID: <7mxksfnkamzqromejfknfsat6cah4taggprj3wxdoputvvwc7f@qnjsm36bsrex>
References: <>
 <6p2m4jqtl62cabb2xolxt76ycule5prukjzx4nxklvhk23g6qh@luj2tzicloph>
 <173890403265.22054.8267826472424760232@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173890403265.22054.8267826472424760232@noble.neil.brown.name>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 07, 2025 at 03:53:52PM +1100, NeilBrown wrote:
> On Fri, 07 Feb 2025, Kent Overstreet wrote:
> > On Fri, Feb 07, 2025 at 02:36:47PM +1100, NeilBrown wrote:
> > > No callers of kern_path_locked() or user_path_locked_at() want a
> > > negative dentry.  So change them to return -ENOENT instead.  This
> > > simplifies callers.
> > > 
> > > This results in a subtle change to bcachefs in that an ioctl will now
> > > return -ENOENT in preference to -EXDEV.  I believe this restores the
> > > behaviour to what it was prior to
> > 
> > I'm not following how the code change matches the commit message?
> 
> Maybe it doesn't.  Let me checked.
> 
> Two of the possible error returns from bch2_ioctl_subvolume_destroy(),
> which implements the BCH_IOCTL_SUBVOLUME_DESTROY ioctl, are -ENOENT and
> -EXDEV.
> 
> -ENOENT is returned if the path named in arg.dst_ptr cannot be found.
> -EXDEV is returned if the filesystem on which that path exists is not
>  the one that the ioctl is called on.
> 
> If the target filesystem is "/foo" and the path given is "/bar/baz" and
> /bar exists but /bar/baz does not, then user_path_locked_at or
> user_path_at will return a negative dentry corresponding to the
> (non-existent) name "baz" in /bar.
> 
> In this case the dentry exists so the filesystem on which it was found
> can be tested, but the dentry is negative.  So both -ENOENT and -EXDEV
> are credible return values.
> 
> 
> - before bbe6a7c899e7 the -EXDEV is tested immediately after the call
>   to user_path_att() so there is no chance that ENOENT will be returned.
>   I cannot actually find where ENOENT could be returned ...  but that
>   doesn't really matter now.
> 
> - after that patch .... again the -EXDEV test comes first. That isn't
>   what I remember.  I must have misread it.
> 
> - after my patch user_path_locked_at() will return -ENOENT if the whole
>   name cannot be found.  So now you get -ENOENT instead of -EXDEV.
> 
> So with my patch, ENOENT always wins, and it was never like that before.
> Thanks for challenging me!

How do you always manage to be unfailingly polite? :)

> 
> Do you think there could be a problem with changing the error returned
> in this circumstance? i.e. if you try to destroy a subvolume with a
> non-existant name on a different filesystem could getting -ENOENT
> instead of -EXDEV be noticed?

-EXDEV is the standard error code for "we're crossing a filesystem
boundary and we can't or aren't supposed to be", so no, let's not change
that.

