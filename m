Return-Path: <linux-cifs+bounces-28-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E41C87E62B9
	for <lists+linux-cifs@lfdr.de>; Thu,  9 Nov 2023 04:47:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 506C3B20C26
	for <lists+linux-cifs@lfdr.de>; Thu,  9 Nov 2023 03:47:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D45E5566F;
	Thu,  9 Nov 2023 03:46:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="QwDsW709"
X-Original-To: linux-cifs@vger.kernel.org
Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47DB95663
	for <linux-cifs@vger.kernel.org>; Thu,  9 Nov 2023 03:46:55 +0000 (UTC)
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E86926A4
	for <linux-cifs@vger.kernel.org>; Wed,  8 Nov 2023 19:46:54 -0800 (PST)
Message-ID: <28c55c338790757034b7a207de64bb2e.pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1699501613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=+jXEkxXPoQLyYRq9Hbw31kvg4sfgedU2UpPdnSNpznc=;
	b=QwDsW709oH1qj/QTOmq50Pt1/iNaoCrRrTShIvXuyqw7klQi/Pm8NGamIlWzY61Fx4E2u7
	5MNuAFyryhtFHHyh3rNDJ3dXHzWHHdooT6EDeTSIpsCwxeqCowkBMzilZ3+l60CxE7A4Ln
	I+AF8Mt2FBG6/QJcHEZ3yfTaVVGbXg+SLTp19jCDvzEjr0PNHW/uXozOWZ9AZCdxF6Q4A5
	ov/cLO8/1WBQl3teffTsD8o9EBhH3qIgzxImCogwErzA4ZIy4Sz0jjA4WoYnoB6NSATS79
	uGGPl0AZtR4Df3bjpRIuTezeP2uZMjgXfGKdtDQwbmZYQYOedwJy69DElFMKrA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1699501613; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+jXEkxXPoQLyYRq9Hbw31kvg4sfgedU2UpPdnSNpznc=;
	b=RbYyON928G5oxfQe0M2nthgmHeAlI8skjlX+N8c86ocVoPOgZ0+K0q+ociH9e3LTPSJvHc
	xMn6EmSCm43YxoXkOJOKKN9I9GD2hdMazBeHF4Xu0/j3h+pjKN2vTok5i9qjORkXZ0BM0j
	ga+bgOu2iUqo3rgDjUgJkJ5r0dR/zPmuhdFzt4+P14Q1WxDyhUVU+YCRVi3ABkIeYsiMk+
	hyA+PHmcOR0h6cAWNCQlkDY/GTmGoBvzUbbF90fcEL8YpQ8loBzJspKibNhhNNjnJdrznh
	AwUGbGTHmGtQamJIMEsbbFIpbxPYWQxXjhoZFIqf4gSxi1t+1tt1jYB0vpgs1w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1699501613; a=rsa-sha256;
	cv=none;
	b=kJnyToDedV3rJ5YVdrGFM1cJV3mF0sGG6fymdIrP46RH1cvr+2tSOJ55VLvgiacswjJD3K
	ZJuOZK5HihTt7kH2D8V7mvLXzKfvExHaCbDS5ntinvIQth3wkx/RI58taNXLQATC6RyF8q
	bkV2cOEgZz/wx1MfyO7aGjAbJXRqNvm2F/RBMl3TotRryMKgtQk521M5BZxarRiKycxNec
	8B+/uv1KdGdcuJVmR2XocLnSRXHL7WjqY1Ob1ygOUwB0gg3JenLJyxBMs5ri82LsIkIHJT
	o2i1yhR+zMqD7jvxafUnH+5juGoREH/oBuPPZ15NzQ5xIDGAEA0pSN8Kx1n9cQ==
From: Paulo Alcantara <pc@manguebit.com>
To: "Matthew Wilcox (Oracle)" <willy@infradead.org>, Andrew Morton
 <akpm@linux-foundation.org>
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>, David Howells
 <dhowells@redhat.com>, Steve French <sfrench@samba.org>,
 linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org
Subject: Re: [PATCH 3/4] smb: Do not test the return value of
 folio_start_writeback()
In-Reply-To: <20231108204605.745109-4-willy@infradead.org>
References: <20231108204605.745109-1-willy@infradead.org>
 <20231108204605.745109-4-willy@infradead.org>
Date: Thu, 09 Nov 2023 00:46:49 -0300
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Matthew Wilcox (Oracle)" <willy@infradead.org> writes:

> In preparation for removing the return value entirely, stop testing it
> in smb.
>
> Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> ---
>  fs/smb/client/file.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Paulo Alcantara (SUSE) <pc@manguebit.com>

