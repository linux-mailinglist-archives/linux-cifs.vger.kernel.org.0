Return-Path: <linux-cifs+bounces-5327-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A2EBFB045FC
	for <lists+linux-cifs@lfdr.de>; Mon, 14 Jul 2025 18:58:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EC17A1881D22
	for <lists+linux-cifs@lfdr.de>; Mon, 14 Jul 2025 16:59:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1ED8D1F4CB3;
	Mon, 14 Jul 2025 16:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XdHsLvuL"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF57429408
	for <linux-cifs@vger.kernel.org>; Mon, 14 Jul 2025 16:58:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752512328; cv=none; b=aS8B1v1fLACaY2utafoRxCYoZ9+G9OCanUQdgGjkWcLVL3W1qA1JcPtv+aVQ3hxnNyh9Qj1Vg3U9heH6j5CbVZ20wGla+ZV1lPdIs2LCjEB4mPx31z0Bcv9fvir8CINqNMbu+D39IRGbdYbbvizgCbc/cGN19jeFpocWwyWbmVc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752512328; c=relaxed/simple;
	bh=UW6yWvELi+HzUFrzvIvQLQRJBEcwK58IBq3dkW+aSYo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a6HlU6Z6MEaV8jHV96bYSJjEhsadeiXnfKtHeKOHZum7PtpPNS7VPDqu0jraZAKlxAFzWLurx46r7V2Hh6MUxqeUkcP3IX01wsRoOfLkzAMTftE7MAmTYrxSxL2uKR6X6yTR97whAjr331ekLDVaUD8n61pkHZbf15p8DfL5Pq0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XdHsLvuL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BC10C4CEED;
	Mon, 14 Jul 2025 16:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1752512327;
	bh=UW6yWvELi+HzUFrzvIvQLQRJBEcwK58IBq3dkW+aSYo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XdHsLvuL8NJj9CdBnEXwp0/ERwOQpJ1VsVpnhouZY+IuZf3st55Vd8RkY2LlGb78V
	 SfFIukcm+I9k7hHx8YQH58o/ZMs0l0HnJTX6WZYXZKtRih2tYALo4pheajb3x5muL4
	 PV1Z8MCwtuU6GKrC2MA8G5XI09edY6pXgapPaooozuLAUVLlFozjwMXx51MF+Cx4qI
	 goS+04Dz3v/qFaZGpxE0M5le118e954G8+v2DdOOQ224h5jN4ZcYhSoAEwBcZfcTSU
	 3AmJiXn2k3WrgKvyWQPJ7GnB+FR0RfIMsZDkDKCTbQi1AVM/90MQHz9oQG0kHekrqM
	 EqvW1WPd5LlNg==
Received: by pali.im (Postfix)
	id BF007963; Mon, 14 Jul 2025 18:58:44 +0200 (CEST)
Date: Mon, 14 Jul 2025 18:58:44 +0200
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Ralph Boehme <slow@samba.org>
Cc: Jeremy Allison <jra@samba.org>, Steve French <smfrench@gmail.com>,
	vl@samba.org, samba-technical <samba-technical@lists.samba.org>,
	Paulo Alcantara <pc@manguebit.org>,
	CIFS <linux-cifs@vger.kernel.org>
Subject: Re: Samba support for creating special files (via reparse points)
Message-ID: <20250714165844.4hctlrwegfspiius@pali>
References: <CAH2r5muQGDkaHL78JOcgsfjL_=A64Xm9CrCBSKgOMABOjcg44w@mail.gmail.com>
 <CAH2r5msdLbvGMARXJ=V9wt0pvXJOrc=zh3eUfeF9AXEeshtByg@mail.gmail.com>
 <aHRo9VfMDIfK5MR6@jeremy-HP-Z840-Workstation>
 <42e549c1-0f92-4b95-b62b-3e0efab9aa10@samba.org>
 <5519b2d9-600c-4a3f-b44f-594877417df7@samba.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5519b2d9-600c-4a3f-b44f-594877417df7@samba.org>
User-Agent: NeoMutt/20180716

On Monday 14 July 2025 10:23:17 Ralph Boehme wrote:
> On 7/14/25 8:01 AM, Ralph Boehme via samba-technical wrote:
> > On 7/14/25 4:18 AM, Jeremy Allison wrote:
> > > It's an oversight I'm afraid.
> > 
> > hm... it seems reparse points support is mandatory for SMB3 POSIX so I
> > wonder what this additional checks buys us.

No. It is not mandatory. Getting or setting of reparse points is done
via IOCTLs which are optional. Also fs attribute for reparse points is
optional.

And that make sense as there are still lot of filesystems which do not
support reparse points (e.g. FAT) and this fs attribute is exactly what
server announce for clients and applications to tell feature support.
So application would know what features are provided and which not on
particular share. Server can support reparse points on share A but does
not have to support it on share B. E.g. when A is NTFS and B is FAT.

> > While I agree that generally we should likely set this, for SMB3 POSIX
> > the client should probably not check this and we should keep it out of
> > the spec.
> 
> one additional thought: it seems like a valid scenario to be able to support
> SMB3 POSIX on a server that does not support xattrs on the backing
> filesystem and hence may not have a way of storing arbitrary reparse points.

xattrs and reparse points are two completely different things, and they
should not be mixed or exchanged.

For example FAT on older Windows versions supported xattrs (I'm not sure
if recent Windows version still support them), but does not and never
supported reparse points.

For checking if xattrs (in MS terminology called Extended Attributes or
abbrev EAs) there is a fs attribute FILE_SUPPORTS_EXTENDED_ATTRIBUTES.

Again, application can check if server share supports xattrs by this
fs attribute and decide what to do next.

> In SMB3 POSIX we're just using them as a wire transport, not necessarily
> expecting full support from the server.
> 
> Hence, for Samba I see the following change
> 
>     smbd: announce support for FILE_SUPPORTS_REPARSE_POINTS if the share
> supports EAs

FILE_SUPPORTS_EXTENDED_ATTRIBUTES (0x00800000) != FILE_SUPPORTS_REPARSE_POINTS (0x80)

> ---
>  source3/smbd/vfs.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/source3/smbd/vfs.c b/source3/smbd/vfs.c
> index 76895f52e039..ea3fa4c8784f 100644
> --- a/source3/smbd/vfs.c
> +++ b/source3/smbd/vfs.c
> @@ -1345,6 +1345,9 @@ uint32_t vfs_get_fs_capabilities(struct
> connection_struct *conn,
>         if (lp_nt_acl_support(SNUM(conn))) {
>                 caps |= FILE_PERSISTENT_ACLS;
>         }
> +       if (lp_ea_support(SNUM(conn))) {
> +               caps |= FILE_SUPPORTS_REPARSE_POINTS;
> +       }
> 
>         caps |= lp_parm_int(SNUM(conn), "share", "fake_fscaps", 0);
> 
> https://gitlab.com/samba-team/samba/-/merge_requests/4104
> 
> For the client this would mean, it must allow reparse points for the special
> files if SMB3 POSIX is negotiated.
> 
> Makes sense?
> 
> -slow

I do not think that this is a good idea at all. It would just complicate
things, make more incompatibilities and prevent using FAT or any other
filesystem without mknod support, including cases when server itself is
configured to not support mknod for e.g. security reasons.

FILE_SUPPORTS_REPARSE_POINTS is per-share fs attribute which says if the
reparse point of any type are supported. If it was decided that special
files, like fifos or character devices are represented as reparse points
then for share/filesystem on which are special files supported, server
has to announce the FILE_SUPPORTS_REPARSE_POINTS fs attribute.

And if the server itself supports special files, but particular
filesystem like FAT does not support it, then server should not announce
the FILE_SUPPORTS_REPARSE_POINTS fs attribute.

This is how it was designed and how it is used.

It does not matter if the client or server is POSIX or not. Also on
POSIX systems there are filesystems without the support for special
files and it is common scenario on more UNIX systems that for particular
mount are special files completely disabled for security reasons.


So the result is that also when POSIX extensions are negotiated, it is
important and required to know by POSIX client whether particular
exported share supports reparse points / special files or not.
And FILE_SUPPORTS_REPARSE_POINTS is already there for it.

