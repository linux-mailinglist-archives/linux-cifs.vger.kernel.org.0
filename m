Return-Path: <linux-cifs+bounces-9677-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gAqDOFIGoWkspwQAu9opvQ
	(envelope-from <linux-cifs+bounces-9677-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Fri, 27 Feb 2026 03:49:54 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6E21B21E2
	for <lists+linux-cifs@lfdr.de>; Fri, 27 Feb 2026 03:49:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 1EB71302FEBE
	for <lists+linux-cifs@lfdr.de>; Fri, 27 Feb 2026 02:49:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E078C2F1FFA;
	Fri, 27 Feb 2026 02:49:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QJoM/Sia"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EDCD2F12DB
	for <linux-cifs@vger.kernel.org>; Fri, 27 Feb 2026 02:49:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772160591; cv=none; b=JDx0BVvEnkcO82+/eJx4/iprG82WntIHWnL1ZU1ySf6Xz7eGyGdqBnrO989sk2y+zF3J3gDcdmSs/wpL0cFSQQfq2ywzy1RnYithfaTIcEoXAnFjzAr73pIFmBUJP3/ljmSsDKXk45xDQJ4YNk/dLMH4AkwQ7OUuX/RrGyjekm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772160591; c=relaxed/simple;
	bh=Met7EOpC5mu94IVgDnl7+iiehgg9c/6QNQvvqabZ4/A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=E8D9fTaWQb8EMDGqTHV3Hz9L2RuBFgP9uIQMn+qf81yQBcyRqMxeb+og95OVy+bCp1rFE+AhugBptiL6x8dhDV3iPMuJyqIWVdop7Prvvofzbkl3vdJY9UNKgtp6prtMhOGcZjisdPZ+FSWhhy2vTa1VsKJZkND7GdioWKpFpxs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QJoM/Sia; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <5f8d3202-d7c3-4ab4-a70a-6af5252b2347@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772160588;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8g+N5S9cDX3bOe8vsqVTYco+4iNlmK58E9+kl9wlIAE=;
	b=QJoM/SiaDfTmSYLiXhM6uOJCFtsNnxYL2fZY01f0PwMfMxRu3vjKtAUfCbjovVRApDG4wx
	lKhF1Nc4tx92FPPoUpTTWjuH8ZTQdS6ipyYkncV8tsEnSPi5mQbaDJAOmfej1EJu2CnJmj
	omw5rkrhnZDQV51d6fkHZL7BA6wr82w=
Date: Fri, 27 Feb 2026 10:48:54 +0800
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 3/5] smb: move filesystem_vol_info into common/fscc.h
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: smfrench@gmail.com, chenxiaosong@chenxiaosong.com,
 linux-cifs@vger.kernel.org, ZhangGuoDong <zhangguodong@kylinos.cn>,
 ChenXiaoSong <chenxiaosong@kylinos.cn>, Steve French <stfrench@microsoft.com>
References: <20260225041100.707468-1-zhang.guodong@linux.dev>
 <20260225041100.707468-4-zhang.guodong@linux.dev>
 <CAKYAXd9D5NEnJGTwk2_=zzCG7=+C=NyP6W+WTYkpfhPJq-Zf6Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ZhangGuoDong <zhang.guodong@linux.dev>
In-Reply-To: <CAKYAXd9D5NEnJGTwk2_=zzCG7=+C=NyP6W+WTYkpfhPJq-Zf6Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,chenxiaosong.com,vger.kernel.org,kylinos.cn,microsoft.com];
	TAGGED_FROM(0.00)[bounces-9677-lists,linux-cifs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhang.guodong@linux.dev,linux-cifs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	RCPT_COUNT_SEVEN(0.00)[7];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:mid,linux.dev:dkim,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 5A6E21B21E2
X-Rspamd-Action: no action

Maybe we should keep `vol_serial_number` as `u32`. I will update it in 
the next version. Do you have any suggestions for the other patches?

On 2026/2/27 10:37, Namjae Jeon wrote:
> Why did you change vol_serial_number from u32 to __le32 ?

