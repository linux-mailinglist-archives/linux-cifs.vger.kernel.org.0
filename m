Return-Path: <linux-cifs+bounces-4016-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 99DFFA2C3B8
	for <lists+linux-cifs@lfdr.de>; Fri,  7 Feb 2025 14:35:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E37167A1E08
	for <lists+linux-cifs@lfdr.de>; Fri,  7 Feb 2025 13:34:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C93AB1F55F8;
	Fri,  7 Feb 2025 13:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hkQCC5qa"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C251F416C
	for <linux-cifs@vger.kernel.org>; Fri,  7 Feb 2025 13:35:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738935336; cv=none; b=XtYMYdmEaK8S0gw05jLKKXvVO/ALRYG8FANM+908HxSHNj7VP40ZOmGkj/hcUY9dFSOYE/jVm3r6oje2a/1ZLuGJGP2wE8f+piw7RcJEesrGaP6ebarsyFizPJxY5bLJE5tDSJnEE1lok0PFa2X8llB8VIzNQEjqt7G3T6scLMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738935336; c=relaxed/simple;
	bh=eL6f/vBW8/55ObLxdCha+pi+VuNZTgE89zN1gtxKPtE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JKmCnv+daocBim1JCRPscf7defC69oKwASX/ixdbfWu8Zx5rtIDRt+6oEdfjy6LUC9GSnO8WQxhNYu8FH5iLHeSCpGLuajLlkaN9WTxZmPvu7DoTHaTsjdZvWdGCb0Ja/nizWM7quCAUd0zLeAZomonecg+FqA9/M6gziCaLZBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hkQCC5qa; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Fri, 7 Feb 2025 08:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1738935322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=KdpuzDJFe1T7WuWmEt+nbSUs+sR4PsDScVN/n3CHCBc=;
	b=hkQCC5qazHU4H+oUsUaMV3yAASSCCKOWp6k3WD7gc+kJiWus9ZRa6hq3JAqEK8fLre0BMZ
	VxBs6Up3SwvgeBR8nH4CGtbck3OCOTeumd1jFLXlgTfH24aOrSNScv7YaiAz+jr9Rl3fy9
	9dBPIvnKIuC/7sEsAk/wFtVsSvjdJkU=
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
Message-ID: <4bxqnnpfau5sq2h7oexvrvazqqpn55e7vsjlj44epdcas2clzf@424354eeo6dl>
References: <>
 <lfzaikkzt46fatqzqjeanxx2m2cwll46mqdcbizph22cck6stw@rhdne3332qdx>
 <173891340026.22054.12085488968187293785@noble.neil.brown.name>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <173891340026.22054.12085488968187293785@noble.neil.brown.name>
X-Migadu-Flow: FLOW_OUT

On Fri, Feb 07, 2025 at 06:30:00PM +1100, NeilBrown wrote:
> On Fri, 07 Feb 2025, Kent Overstreet wrote:
> > On Fri, Feb 07, 2025 at 05:34:23PM +1100, NeilBrown wrote:
> > > On Fri, 07 Feb 2025, Kent Overstreet wrote:
> > > > On Fri, Feb 07, 2025 at 03:53:52PM +1100, NeilBrown wrote:
> > > > > Do you think there could be a problem with changing the error returned
> > > > > in this circumstance? i.e. if you try to destroy a subvolume with a
> > > > > non-existant name on a different filesystem could getting -ENOENT
> > > > > instead of -EXDEV be noticed?
> > > > 
> > > > -EXDEV is the standard error code for "we're crossing a filesystem
> > > > boundary and we can't or aren't supposed to be", so no, let's not change
> > > > that.
> > > > 
> > > 
> > > OK.  As bcachefs is the only user of user_path_locked_at() it shouldn't
> > > be too hard.
> > 
> > Hang on, why does that require keeping user_path_locked_at()? Just
> > compare i_sb...
> > 
> 
> I changed user_path_locked_at() to not return a dentry at all when the
> full path couldn't be found.  If there is no dentry, then there is no
> ->d_sb.
> (if there was an ->i_sb, there would be an inode and this all wouldn't
> be an issue).
> 
> To recap: the difference happens if the path DOESN'T exist but the
> parent DOES exist on a DIFFERENT filesystem.  It is very much a corner
> case and the error code shouldn't matter.  But I had to ask...

Ahh...

Well, if I've scanned the series correctly (sorry, we're on different
timezones and I haven't had much caffeine yet) I hope you don't have to
keep that function just for bcachefs - but I do think the error code is
important.

Userspace getting -ENOENT and reporting -ENOENT to the user will
inevitably lead to head banging frustration by someone, somewhere, when
they're trying to delete something and the system is tell them it
doesn't exist when they can see it very much does exist, right there :)
the more precise error code is a very helpful cue...

