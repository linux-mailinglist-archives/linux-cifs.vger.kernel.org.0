Return-Path: <linux-cifs+bounces-4162-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C0AEEA41206
	for <lists+linux-cifs@lfdr.de>; Sun, 23 Feb 2025 23:23:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B8D68172BAB
	for <lists+linux-cifs@lfdr.de>; Sun, 23 Feb 2025 22:23:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 934A91ACEA7;
	Sun, 23 Feb 2025 22:23:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AzO88M6M"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 677B286330;
	Sun, 23 Feb 2025 22:23:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740349400; cv=none; b=TPXBxtdGmMLBTkJyzmpJr/pVLISXiegzhlrmx64SOVKAhwSA6ShHfYK548coxX3fuAvMwiBUfZka7imDO658ixE4QANjJwAHwR176KkexKcz5xe/vNivWpcSXRcrq3wG7law1pA9qT6PGMZtda5zl+xJpzi53gm6NqnxjEcqCtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740349400; c=relaxed/simple;
	bh=cO+03W7LKSpfkqlQl1tWjap1YNAiUiYyUXY+/lqyh54=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dn1oK3yJMd09tDjP+YfRvh3UZ+Z1+6islAUGC6BV10rDJtdVQeRx0bFtssencT/qIpbBBhjkaztqhEX74ro6vlXMDWcSqPCOv1n5bnwSyKqVli8T3X070qSpJ9QkFp7a3OlaYcCUH9jmxD1z42HavPznRoYukFFZamchWZKYKsU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AzO88M6M; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86C50C4CEDD;
	Sun, 23 Feb 2025 22:23:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740349399;
	bh=cO+03W7LKSpfkqlQl1tWjap1YNAiUiYyUXY+/lqyh54=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=AzO88M6M022VYoqB6BqZvXJjMDiRGeeOrLcuJ1xpc/b1ZWQQP0xSI/yDtRKRa/Fgt
	 91oOVlucUr0q1w24Yj03wY9ilI3cHi1W21qNSBD+1GEI2nfrDwfgHy4irMRV1Y1LWU
	 If8mXGYyKZagiDh9a/hFSwHepz5fsW0istb/haIuuv9IclSLUWHTW5Hm5JUXH7e87O
	 Q/+jm1ga9oQoka4w/8AQPuYgKTIk/BoPQo1AhZVIfNYrlzBROplu+NKv0l8+seiDrT
	 4isNZoVySHlWVa8U0aUoMu9dk0iXqxedty0L7tkiohWxvSLdAD2AV3r9+WhrjikWw0
	 Am5IRZoTaepsA==
Received: by pali.im (Postfix)
	id 75C53A00; Sun, 23 Feb 2025 23:23:06 +0100 (CET)
Date: Sun, 23 Feb 2025 23:23:06 +0100
From: Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To: Steve French <sfrench@samba.org>, Paulo Alcantara <pc@manguebit.com>,
	Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/4] cifs: Handle all name surrogate reparse points
Message-ID: <20250223222306.plgy3bpy5mjojfve@pali>
References: <20241222145845.23801-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20241222145845.23801-1-pali@kernel.org>
User-Agent: NeoMutt/20180716

Hello Steve, I see that you have merged first two changes (1/4 and 2/4)
from this patch series, but the remaining (3/4 and 4/4). Is there any
reason why 3/4 and 4/4 was not taken?

On Sunday 22 December 2024 15:58:41 Pali Rohár wrote:
> Name surrogate reparse point represents another named entity in the system.
> 
> If the name surrogate reparse point is not handled by Linux SMB client
> and it is of directory type then treat it as a new mount point.
> 
> Cleanup code for all explicit surrogate reparse points (like reparse
> points with tag IO_REPARSE_TAG_MOUNT_POINT) as they are handled by
> generic name surrogate reparse point code.
> 
> Pali Rohár (4):
>   cifs: Throw -EOPNOTSUPP error on unsupported reparse point type from
>     parse_reparse_point()
>   cifs: Treat unhandled directory name surrogate reparse points as mount
>     directory nodes
>   cifs: Remove explicit handling of IO_REPARSE_TAG_MOUNT_POINT in
>     inode.c
>   cifs: Improve handling of name surrogate reparse points in reparse.c
> 
>  fs/smb/client/inode.c    | 17 +++++++++++++----
>  fs/smb/client/reparse.c  | 24 ++++++++++--------------
>  fs/smb/common/smbfsctl.h |  3 +++
>  3 files changed, 26 insertions(+), 18 deletions(-)
> 
> -- 
> 2.20.1
> 

