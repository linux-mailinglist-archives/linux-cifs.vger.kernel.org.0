Return-Path: <linux-cifs+bounces-9147-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id yEL8G143eml+4gEAu9opvQ
	(envelope-from <linux-cifs+bounces-9147-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Wed, 28 Jan 2026 17:20:46 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 1353BA5737
	for <lists+linux-cifs@lfdr.de>; Wed, 28 Jan 2026 17:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 9C9F630BAC98
	for <lists+linux-cifs@lfdr.de>; Wed, 28 Jan 2026 15:43:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABE56301717;
	Wed, 28 Jan 2026 15:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v2B4yXuI"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-173.mta1.migadu.com (out-173.mta1.migadu.com [95.215.58.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E62622F747F
	for <linux-cifs@vger.kernel.org>; Wed, 28 Jan 2026 15:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769614936; cv=none; b=NSuwg2M/sawCX7mmZqW80XwzJ5DoWM9HwT6QonrlZqqrIy1HnpOiv4vT6KohzelSNI/nlKU9BImj/1HZzomcVDxCcl5h1Y7I4FYDvkmIzyc0dVDs0zX/WFORGe9oUZES4aOd+nKosEpddVsj0jwWhfgN0TGTTDD8cuaJ1M3WyOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769614936; c=relaxed/simple;
	bh=STRUkd+kaykglxehmCnOalcF9S6LFTjTu5+WVLmhX1g=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pbYMUm7zdD0hicDGy0ZdEL14YXxX9xGIV+v0vSpM9wcAcP0+YYeHxnXjRRp9VC2kq/rE/conO7O80T+jJjDHcWj1y8p0PcvKvPT0VfE7WpjnFd4xA/odZg7oIaKYxJ7UfUXyuluYXqRJMBWu18egDmKSUY6tuPXQhC3xT4p4WNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v2B4yXuI; arc=none smtp.client-ip=95.215.58.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <8e81faef-2413-4995-a850-8c935e568a6f@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769614931;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=25i4XK6DRcwQj9r/BIIh7ki4lmn25XriNbssPTTUZWI=;
	b=v2B4yXuIQZU036XAjiV0Kid2WaLtqdmA6aOcr377ontajUc2rRUh22ptrTMfp/DL1QtD6f
	kpbrAuQ1r+9Vsj6TqFqNEAWdbM29qkE4GRwNoT4+9aJtyww445aq4FxFewv6ffepj+R629
	kLaG1pUJMYqqM4vVVH6XbW4P53IAJ4A=
Date: Wed, 28 Jan 2026 23:41:18 +0800
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: xfstests failed test cases
To: Steve French <smfrench@gmail.com>
Cc: Shyam Prasad N <nspmangalore@gmail.com>,
 David Howells <dhowells@redhat.com>,
 Henrique Carvalho <henrique.carvalho@suse.com>,
 Bharath S M <bharathsm@microsoft.com>,
 Meetakshi Setiya <meetakshisetiyaoss@gmail.com>,
 CIFS <linux-cifs@vger.kernel.org>, ChenXiaoSong <chenxiaosong@kylinos.cn>
References: <CAH2r5mv41nFwJQwszD82MQbtDV75zVy6=tbwqxDTOsw2hwfBpw@mail.gmail.com>
 <CANT5p=qmo_KORMQbnjonapAaGHq=UvWAMzR0jNKBBvx3UUkyjQ@mail.gmail.com>
 <CANT5p=pfQE2A++j6W4sEudrSLH6ct=ho4i=k2ZDEecUAX0cReg@mail.gmail.com>
 <CAH2r5mvakK7=1i-fZTE9hLLYd_Q3o5z557vQZ5QQtdOTkZeSew@mail.gmail.com>
 <CAH2r5mufJgC85ULoVzYSMXDq4=-RUiJ2YgppM434vz1Q4B1d+A@mail.gmail.com>
 <CAH2r5msVifsc-E0TjaYXt2Afh1MiCsJTSwMnsDAdUShRgkJ_4A@mail.gmail.com>
 <CAH2r5mukVmnfK7X3jXWwRnD-_RAMuUgzXpi+HzNjxOat4tobJA@mail.gmail.com>
 <CAH2r5mvW23-eUsjDQ_0oLrmj406Og5sDs-yPgqh6jPwdSEG+Tg@mail.gmail.com>
 <CAH2r5mu909vLwAQcKFQX7cWz421V1QmSiBAKyJeC8gUcGVb0Ew@mail.gmail.com>
 <bcd3d847-c38f-4c88-af07-3da09dad476b@linux.dev>
 <CAH2r5muyYgm4-Nwvd=d+Sqq7mmd+HGPoyM1tid6dsnN1=vt3Ng@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <CAH2r5muyYgm4-Nwvd=d+Sqq7mmd+HGPoyM1tid6dsnN1=vt3Ng@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9147-lists,linux-cifs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,redhat.com,suse.com,microsoft.com,vger.kernel.org,kylinos.cn];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	DKIM_TRACE(0.00)[linux.dev:+];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong.chenxiaosong@linux.dev,linux-cifs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	RCPT_COUNT_SEVEN(0.00)[8];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 1353BA5737
X-Rspamd-Action: no action

I will identify the cause of these test case failures as soon as possible.

Thanks,
ChenXiaoSong <chenxiaosong@kylinos.cn>

On 1/28/26 23:37, Steve French wrote:
> This is helpful. Any luck finding out if fails on both mainline and also 
> for-next and if so can we bisect it?


