Return-Path: <linux-cifs+bounces-8449-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C7F05CDBB50
	for <lists+linux-cifs@lfdr.de>; Wed, 24 Dec 2025 09:55:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 3DA68300C8C0
	for <lists+linux-cifs@lfdr.de>; Wed, 24 Dec 2025 08:55:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 010231E5B68;
	Wed, 24 Dec 2025 08:55:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="LJY8Wr2o"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-186.mta1.migadu.com (out-186.mta1.migadu.com [95.215.58.186])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FA9D1A00F0
	for <linux-cifs@vger.kernel.org>; Wed, 24 Dec 2025 08:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.186
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766566524; cv=none; b=K3OnsIqKA9ZcmRBrmSqIEC1d0lZRYzS0My1U4HZsZZu3ZqgZUxy72YFJ5yi7xfF8nswc9dtkPcB1fVV8nn7VjaYjT9RMVKVCnzfn3Kqx4+wcv4k48vfi1HDEGAz1tAamEaKJ6dYpo0J/pbUKf0usbYB7RCNu2FRQ/64t9oCe2tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766566524; c=relaxed/simple;
	bh=UHHGboSGU3FxN2m5/weH+D+0RiWy+pljLCpoAz7wW3c=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UOyw+hycOx4zFHiGMJdTAN5bjOTVms06C1hpsOJfjIt8WIp4CtxybjY4aob0xydto/0BHS+7PzE51lhKPn14PJT81Qc7mQK+zVfUBLafRGJFcVvZmrzd/2WihxnVnWeJIeEzdto6h0enEr2C8IhU32GbDIaX48jATUvBfNd/CvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=LJY8Wr2o; arc=none smtp.client-ip=95.215.58.186
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <6dbc433c-eba7-4deb-bc28-3df63a27bc63@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1766566520;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j7pNL6HYNnIsZ5mCBFhrfn9tYuEml2MjkdobdEFO1TA=;
	b=LJY8Wr2ob1CaKn6Yb78xJIGGUvpMj0MyUEwLaAtvhZjW7O+GFPVfaqW1uAEwiN7eooni/y
	NSdy7KtBqLsUr4YPcdb8dLV5LY892Obruqx8bEMNUJyVToompNxJeZQxiohpOaAb0baZHQ
	mHcn2+EFELKdyEUKAD2gp7zyOcJE9XQ=
Date: Wed, 24 Dec 2025 16:54:35 +0800
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 5/5] smb/client: introduce KUnit test to check search
 result of smb2_error_map_table
To: David Howells <dhowells@redhat.com>
Cc: smfrench@gmail.com, linkinjeon@kernel.org, pc@manguebit.org,
 ronniesahlberg@gmail.com, sprasad@microsoft.com, tom@talpey.com,
 bharathsm@microsoft.com, senozhatsky@chromium.org,
 linux-cifs@vger.kernel.org, ChenXiaoSong <chenxiaosong@kylinos.cn>
References: <20251224023145.608165-6-chenxiaosong.chenxiaosong@linux.dev>
 <20251224023145.608165-1-chenxiaosong.chenxiaosong@linux.dev>
 <1168035.1766564530@warthog.procyon.org.uk>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <1168035.1766564530@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

Thanks for your suggestions, they are very helpful.

I will update these patches in the next version.

Thanks,
ChenXiaoSong.

在 2025/12/24 16:22, David Howells 写道:
> chenxiaosong.chenxiaosong@linux.dev wrote:
> 
>> +
>> +#if IS_ENABLED(CONFIG_SMB_KUNIT_TESTS)
>> +#include "smb2maperror_test.c"
>> +#endif /* CONFIG_SMB_KUNIT_TESTS */
> 
> This feels weird, but I think I can see what you're doing.  I guess it's not a
> kunit test in loadable module form?
> 
>> +	for (i = 0; i < err_map_num; i++) {
> 
> ARRAY_SIZE(smb2_error_map_table).
> 
> David
> 


