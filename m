Return-Path: <linux-cifs+bounces-4997-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD9BEADBA5E
	for <lists+linux-cifs@lfdr.de>; Mon, 16 Jun 2025 21:56:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 79F52170F09
	for <lists+linux-cifs@lfdr.de>; Mon, 16 Jun 2025 19:56:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97C6D276059;
	Mon, 16 Jun 2025 19:56:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hfTMIphz"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 555091DDC28;
	Mon, 16 Jun 2025 19:56:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750103783; cv=none; b=ZuBFn/H3MviT3Y6KNKL0u5eTrC+wKhwWMLzjhMu+NXG+q8mql5V95H5OexH5obTT7TH6vNrV6YiPE3Ls7nP0TgnOw+6L1vuruGemPLbf3TIhxLkVn9eGxC0A/ujSVePHc5MuamvcWdKMtbmjJDIJ57QTBEPW4rayfqogbetEPzU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750103783; c=relaxed/simple;
	bh=SYgW+h+thLH1TvJkn1jGPOnBgObSoTh5b470jLYkZBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RCqdRxHonvM0QxABJ5YnOB0dXP2oVwuXXwBfimI8JvgvMfatk4LRjTs3J2nDpyrjIMCjXyvF40JZqIF5pvWyz0STtBCqCZKL6JNxJ5qfnFqvm5+CLwnDrBKzsn3OGWCTYa86OmaTIfbBTz2RGBEgscscUifAfxGigR1mHPZqnZk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hfTMIphz; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Mon, 16 Jun 2025 15:56:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1750103779;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=RY6jvlftqYj16RlZ8cMi5ktPdnRQwqLwReUIv9YTb9Y=;
	b=hfTMIphzIV1UP9YZShGN/2c5XF+1HSCXXUsJYRJXY1L6Aclc1GU2E07+0kGNeThs5vuF28
	AC/+C5qGR5vwjAZWxQnLX9XOq2VPangJK+zHBHTevwRsO8AM7teSfcER/FwsKkzBj8c3T1
	2J2uYc2bohx4O0D5BW29EVxqbVb4hNk=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Lorenzo Stoakes <lorenzo.stoakes@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-block@vger.kernel.org, 
	linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
	v9fs@lists.linux.dev, linux-fsdevel@vger.kernel.org, linux-afs@lists.infradead.org, 
	linux-aio@kvack.org, linux-unionfs@vger.kernel.org, linux-bcachefs@vger.kernel.org, 
	linux-mm@kvack.org, linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org, 
	codalist@coda.cs.cmu.edu, ecryptfs@vger.kernel.org, linux-erofs@lists.ozlabs.org, 
	linux-ext4@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, 
	linux-um@lists.infradead.org, linux-mtd@lists.infradead.org, 
	jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org, 
	ntfs3@lists.linux.dev, ocfs2-devel@lists.linux.dev, 
	linux-karma-devel@lists.sourceforge.net, devel@lists.orangefs.org, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org, linux-xfs@vger.kernel.org, nvdimm@lists.linux.dev
Subject: Re: [PATCH 00/10] convert the majority of file systems to
 mmap_prepare
Message-ID: <tz4x7atqjhxr3rixvgklfss4r5u5jod5qoeqr6iueois3ywdap@losa5evtlekp>
References: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1750099179.git.lorenzo.stoakes@oracle.com>
X-Migadu-Flow: FLOW_OUT

Mailserver is rejecting with "too many recipients" - aieeee

On Mon, Jun 16, 2025 at 08:33:19PM +0100, Lorenzo Stoakes wrote:
> REVIEWER'S NOTES
> ================
> 
> I am basing this on the mm-new branch in Andrew's tree, so let me know if I
> should rebase anything here. Given the mm bits touched I did think perhaps
> we should take it through the mm tree, however it may be more sensible to
> take it through an fs tree - let me know!
> 
> Apologies for the noise/churn, but there are some prerequisite steps here
> that inform an ordering - "fs: consistently use file_has_valid_mmap_hooks()
> helper" being especially critical, and so I put the bulk of the work in the
> same series.
> 
> Let me know if there's anything I can do to make life easier here.

This seems to be more of an mm thing than a filesystem thing? I don't
see any code changes on the filesystem side from a quick scan, just
renaming?

Are there any behavioural changes for the filesystem to be aware of?

How's it been tested, any considerations there?

If this is as simple as it looks, ack from me (and if it is that simply,
why so many recipients?).

If there are _any_ behavioural changes on the mm side that might
interact with the filesystem in funny ways, please make sure the whole
fstests suite has been run.

