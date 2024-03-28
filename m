Return-Path: <linux-cifs+bounces-1420-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C93A875576
	for <lists+linux-cifs@lfdr.de>; Thu,  7 Mar 2024 18:45:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AEB061C21D7A
	for <lists+linux-cifs@lfdr.de>; Thu,  7 Mar 2024 17:45:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81166130AFF;
	Thu,  7 Mar 2024 17:45:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="tws/8trx"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-172.mta1.migadu.com (out-172.mta1.migadu.com [95.215.58.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B6475B1FD
	for <linux-cifs@vger.kernel.org>; Thu,  7 Mar 2024 17:45:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709833524; cv=none; b=SywskLRTFz4NuwJSglq8dTyG07bmSRswIsIAMKI0saVacKIlyRqh14zmZiRm3q9FMDoj9wyYDMP1JgNw8g8AKLTs7b7re+XXQkVxH1z7uOsw7dsJBUI2FS+r33TbXX8IU3QcDBllC71wQJFZkwkgwI/B4HVgLIP6r38hTUCku1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709833524; c=relaxed/simple;
	bh=0g2CmrW3zSwMXehy0USG53S+gcTB61LcPmT7dZEnlbA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=EzshjXOlsRs0ozAD8m/PD7ZnuFZgKiHNWAYcdhtbrDAcGw722evtlHcTIEcqAHtCaOYj2PlMn6hOmbpemfXcENklplOqRW5m7KtmGQvPM/sG83O9PEhSfSExODi8Sp8ie2RJnc6rZbAqdpRisUpp7f3sFAk9iESA0CfuenRrvMI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=tws/8trx; arc=none smtp.client-ip=95.215.58.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Date: Thu, 7 Mar 2024 12:45:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1709833520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=1E6eVA0ox3wTfDXp5qDGeEi3j9jsvxPth1X63WCpYd8=;
	b=tws/8trx5AMSUNUCRnOBThosM3Fn0/xa3dAOE/V3A/jfIhXzn9SYN88RgcwU6jtzljrfAH
	MogmVxRqjwI/owyB293GOPprfgCJkEmV0J+h/fe3FFzo2gTa48HL6hOnI5rrm6FocQBM1j
	leggh2Fh6DeVOqjJVO3e2BpbIn721Kc=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: Kent Overstreet <kent.overstreet@linux.dev>
To: Steve French <smfrench@gmail.com>
Cc: Amir Goldstein <amir73il@gmail.com>, 
	lsf-pc <lsf-pc@lists.linux-foundation.org>, CIFS <linux-cifs@vger.kernel.org>, 
	samba-technical <samba-technical@lists.samba.org>, linux-fsdevel <linux-fsdevel@vger.kernel.org>, 
	Jan Kara <jack@suse.cz>, Christian Brauner <brauner@kernel.org>, 
	David Howells <dhowells@redhat.com>
Subject: Re: [LSF/MM/BPF TOPIC] statx attributes
Message-ID: <nbqjigckee7m3b5btquetn3wfj3bzcirm75jwnbmhjyxyqximr@ouyqocmrjmfa>
References: <CAH2r5mutAn2G3eC7yRByF5YeCMokzo=Br0AdVRrre0AqRRmTEQ@mail.gmail.com>
 <CAOQ4uxg8YbaYVU1ns5BMtbW8b0Wd8_k=eFWj7o36SkZ5Lokhpg@mail.gmail.com>
 <CAH2r5msvgB19yQsxJtTCeZN+1np3TGkSPnQvgu_C=VyyhT=_6Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5msvgB19yQsxJtTCeZN+1np3TGkSPnQvgu_C=VyyhT=_6Q@mail.gmail.com>
X-Migadu-Flow: FLOW_OUT

On Thu, Mar 07, 2024 at 10:37:13AM -0600, Steve French wrote:
> > Which API is used in other OS to query the offline bit?
> > Do they use SMB specific API, as Windows does?
> 
> No it is not smb specific - a local fs can also report this.  It is
> included in the attribute bits for files and directories, it also
> includes a few additional bits that are used by HSM software on local
> drives (e.g. FILE_ATTRIBUTE_PINNED when the file may not be taken
> offline by HSM software)
> ATTRIBUTE_HIDDEN
> ATTRIBUTE_SYSTEM
> ATTRIBUTE_DIRECTORY
> ATTRIGBUTE_ARCHIVE
> ATTRIBUTE_TEMPORARY
> ATTRIBUTE_SPARSE_FILE
> ATTRIBUTE_REPARE_POINT
> ATTRIBUTE_COMPRESSED
> ATTRIBUTE_NOT_CONTENT_INDEXED
> ATTRIBUTE_ENCRYPTED
> ATTRIBUTE_OFFLINE

we've already got some of these as inode flags available with the
getflags ioctl (compressed, also perhaps encrypted?) - but statx does
seem a better place for them.

statx can also report when they're supported, which does make sense for
these.

ATTRIBUTE_DIRECTORY, though?

we also need to try to define the semantics for these and not just dump
them in as just a bunch of identifiers if we want them to be used by
other things - and we do.

ATTRIBUTE_TEMPORARY is the one I'm eyeing; I've been planning tmpfile
support in bcachefs, it'll turn fsyncs into noops and also ensure files
are deleted on unmount/remount.

