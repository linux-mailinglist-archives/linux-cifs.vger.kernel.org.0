Return-Path: <linux-cifs+bounces-9198-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sLZlOH0Lf2lziwIAu9opvQ
	(envelope-from <linux-cifs+bounces-9198-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Sun, 01 Feb 2026 09:14:53 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 70D34C5316
	for <lists+linux-cifs@lfdr.de>; Sun, 01 Feb 2026 09:14:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id A2DCA300231C
	for <lists+linux-cifs@lfdr.de>; Sun,  1 Feb 2026 08:14:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 85ED3319859;
	Sun,  1 Feb 2026 08:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="CMgDd2uu"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-179.mta1.migadu.com (out-179.mta1.migadu.com [95.215.58.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE2322D8DC3
	for <linux-cifs@vger.kernel.org>; Sun,  1 Feb 2026 08:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769933689; cv=none; b=M05iNLnaxWFzgyAWYN8u1ijKSJIR9Uuu+gfarErvTwzycwho7cIM3gq0TZB10XCGy3qGzYcObNMBfhKzjMgiUJW4CZOQ411AYlG1gfrC3i/Hm1C5zjj6ZI2kcF7QxsMGlvf/Gpxwv496+LSYv5lKCwk8+sRXZdb5C4aJo9+PR34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769933689; c=relaxed/simple;
	bh=1VMg1QZKau42hn0oeZvoSDlNt4C8BC0vouvwHVuPMAk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fLNZAAyjFpqUrPcHnEdj3x5bjAbm2cbuhD23rOMtfvx6GQoIXO4hpkg8DqjgkClJHHErW1IcH/NBR5huClLJUYeGMdK52klvhcv8gD58p93qLI7WiT69ge06zSN0xorZS/2BTMCQMSwWq6iRTagWvSL0zU6A4mCRsVMWwyOFIT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=CMgDd2uu; arc=none smtp.client-ip=95.215.58.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <d6a9cf34-e4ec-4792-afb0-5d7a39b46378@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1769933684;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u0IH4iV2XH1mj1VuxjvgwPVWsRggOPvkZHdzBXTda4I=;
	b=CMgDd2uuHruAvJQ4GeHwiYZ2G49XMuLLgEjNHuyYpO55fBeqaUeuGUTqxxRKb76b6x3rEe
	/p8GlX2z61UE7LDYwxHQGNjhu1mnl89TwAiKGC7HdYBncbpd8+b3FXF+0S/lm+baO5c2FO
	palE8UT8WbxjeJEHaSnrCE0aVNjA5bc=
Date: Sun, 1 Feb 2026 16:14:27 +0800
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: xfstests failed test cases
To: Steve French <smfrench@gmail.com>, Shyam Prasad N
 <nspmangalore@gmail.com>, David Howells <dhowells@redhat.com>,
 Henrique Carvalho <henrique.carvalho@suse.com>,
 Bharath S M <bharathsm@microsoft.com>,
 Meetakshi Setiya <meetakshisetiyaoss@gmail.com>,
 ChenXiaoSong <chenxiaosong@kylinos.cn>, Paulo Alcantara <pc@manguebit.org>,
 Steve French <sfrench@samba.org>, Enzo Matsumiya <ematsumiya@suse.de>
Cc: CIFS <linux-cifs@vger.kernel.org>
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
 <f1b9cd58-8a61-4fa7-a7e9-198c2c468c59@linux.dev>
 <9751f02d-d1df-4265-a7d6-b19761b21834@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <9751f02d-d1df-4265-a7d6-b19761b21834@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c09:e001:a7::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9198-lists,linux-cifs=lfdr.de];
	TO_DN_ALL(0.00)[];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,redhat.com,suse.com,microsoft.com,kylinos.cn,manguebit.org,samba.org,suse.de];
	DKIM_TRACE(0.00)[linux.dev:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c09::/32, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong.chenxiaosong@linux.dev,linux-cifs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	RCPT_COUNT_SEVEN(0.00)[11];
	MIME_TRACE(0.00)[0:+];
	DBL_BLOCKED_OPENRESOLVER(0.00)[kylinos.cn:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 70D34C5316
X-Rspamd-Action: no action

I have already submitted a patch to fix this issue: 
https://lore.kernel.org/linux-cifs/20260201081017.998628-1-chenxiaosong.chenxiaosong@linux.dev/

Thanks,
ChenXiaoSong <chenxiaosong@kylinos.cn>

On 2/1/26 2:30 PM, ChenXiaoSong wrote:
> Steve and I have completed a git bisect and found the first bad commit:
> [e255612b5ed9f179abe8196df7c2ba09dd227900] cifs: Add fallback for SMB2 
> CREATE without FILE_READ_ATTRIBUTES
> 
> For detailed information, please check the link: https:// 
> chenxiaosong.com/en/smb-buildbot.html#cifs-103-bisect
> 
> Thanks,
> ChenXiaoSong <chenxiaosong@kylinos.cn>
> 
> On 1/29/26 8:20 PM, ChenXiaoSong wrote:
>> I found the key factor that triggers kmemleak in cifs/103, the 
>> directory exported by the server must be read-only.
>>
>> When sharing a folder on Windows, do not check "Allow Change", set the 
>> permissions of the shared directory to read-only.
>>
>> Alternatively, `smb.conf` of Samba is configured as follows:
>> ```
>> [test]
>>      ...
>>      read only = yes
>> [test2]
>>      ...
>>      read only = yes
>> ```
>>
>> For detailed information, please check the link: https:// 
>> chenxiaosong.com/en/smb-buildbot.html#cifs-103
>>
>> I will first try to analyze the code, and if that doesn't work, I will 
>> try to bisect it.
>>
>> Thanks,
>> ChenXiaoSong <chenxiaosong@kylinos.cn>
>>
>> On 1/28/26 23:29, ChenXiaoSong wrote:
>>> I have reproduced the failures of these test cases. For detailed 
>>> information, please check the link: https://chenxiaosong.com/en/smb- 
>>> buildbot.html (I will ensure this link is always accessible).
>>>
>>> Perhaps sending these issues to the mailing list could help resolve 
>>> them more quickly.
> 


