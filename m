Return-Path: <linux-cifs+bounces-9306-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id ONPsAhcRi2nAPQAAu9opvQ
	(envelope-from <linux-cifs+bounces-9306-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Tue, 10 Feb 2026 12:05:59 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 04BA4119FC0
	for <lists+linux-cifs@lfdr.de>; Tue, 10 Feb 2026 12:05:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 553F1307D4FA
	for <lists+linux-cifs@lfdr.de>; Tue, 10 Feb 2026 11:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5385634CFDA;
	Tue, 10 Feb 2026 11:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nZKsnHJa"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-181.mta1.migadu.com (out-181.mta1.migadu.com [95.215.58.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C7003612DB
	for <linux-cifs@vger.kernel.org>; Tue, 10 Feb 2026 11:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770721476; cv=none; b=jhe0SDaM+LqSUAAn56v1hAxpdqAKoHhwxR6zXROsDYuPqbrCK+eQ5ttB+5JFWfK9KRd4eqJbyibg3whgLF0HD3O1vHbJRk374uVsXwKAKZpblvY4cjQmIPEFpvQ41N0RggQOdHTt3TB9bcWvSkIGuaVUK2S3SMZxrANgjb0HjDE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770721476; c=relaxed/simple;
	bh=LG7YbVmhhGFwNk/Q0/CFSlgIHlx5jtDXvc+QsYLGRLg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gy7XtULNXOEgzJmXa0EipKx/8f3+Td3EbE4jCxD0zmI5PYw2JMy9Qg38zPsUAbzcTQm8TH3MGwLSw2eeZWAA3dz4VzUbcfx39lbT4Y9RrZUB8r6vfGrx7sUbP8GveclhE1oyK+AQLCbzyg07JIlUDLF8uyuZBL0I+XMHwzSSYVg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nZKsnHJa; arc=none smtp.client-ip=95.215.58.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <3f24a647-6133-4d45-b71e-6ede06bab02e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770721472;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=c+PiHpBIgKkKo8SVoWPoVfzBO73+OGk74HdhlYR3zR4=;
	b=nZKsnHJa/jwOE1X4NjbZkJ9+S/5xmk3vRtHKyVQwBe0u/jP6aIAniO+zW6NsR1uedtryzY
	giXgA5eWve391cDt+1/KdvzMErCQd/pGOLQe0IElFQSuei7a6xOWKBgLsa6On/B1hU0zfW
	476mgo+X/JJik21H6pCxmribiPml/Vg=
Date: Tue, 10 Feb 2026 19:03:37 +0800
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v9 1/1] smb/client: introduce KUnit test to check search
 result of smb2_error_map_table
To: Geert Uytterhoeven <geert@linux-m68k.org>
Cc: bharathsm@microsoft.com, chenxiaosong@kylinos.cn, dhowells@redhat.com,
 linkinjeon@kernel.org, Brendan Higgins <brendan.higgins@linux.dev>,
 David Gow <davidgow@google.com>, Rae Moar <raemoar63@gmail.com>,
 linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
 linux-cifs@vger.kernel.org, pc@manguebit.org, ronniesahlberg@gmail.com,
 senozhatsky@chromium.org, smfrench@gmail.com, sprasad@microsoft.com,
 tom@talpey.com
References: <20260118091313.1988168-1-chenxiaosong.chenxiaosong@linux.dev>
 <20260210081040.4156383-1-geert@linux-m68k.org>
 <5c4bbbea-d68c-4089-b3aa-adb4b05696ba@linux.dev>
 <CAMuHMdXBBCzWK8HPQ8zQYJ1_Pxim3_ku4_2-CnWXm3M4ysnQ+w@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <CAMuHMdXBBCzWK8HPQ8zQYJ1_Pxim3_ku4_2-CnWXm3M4ysnQ+w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9306-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[microsoft.com,kylinos.cn,redhat.com,kernel.org,linux.dev,google.com,gmail.com,vger.kernel.org,googlegroups.com,manguebit.org,chromium.org,talpey.com];
	RCPT_COUNT_TWELVE(0.00)[17];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong.chenxiaosong@linux.dev,linux-cifs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-cifs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,kylinos.cn:email]
X-Rspamd-Queue-Id: 04BA4119FC0
X-Rspamd-Action: no action

Thanks for your suggestions, these are really helpful. I will make the 
changes as soon as possible.

Thanks,
ChenXiaoSong <chenxiaosong@kylinos.cn>

On 2/10/26 6:38 PM, Geert Uytterhoeven wrote:
> Hi ChenXiaoSong,
> 
> On Tue, 10 Feb 2026 at 10:53, ChenXiaoSong
> <chenxiaosong.chenxiaosong@linux.dev> wrote:
>> The KUnit test cases are only executed when the CONFIG_SMB_KUNIT_TESTS
>> is enabled.
> 
> ... which defaults to KUNIT_ALL_TESTS, so if KUNIT_ALL_TESTS is enabled,
> the test is enabled by default, too.
> 
>> Making it a separate test module would require exporting local variables
>> and functions so that the test code can access them. However, exporting
>> local variables and functions would likely make the code much uglier, as
>> it would require adding "#if" conditionals into the production code to
>> isolate the test code.
>>
>> Geert, please let me know if you have a better idea.
>>
>> I am also discussing this with the ext4 community, and we all hope to
>> find a way to make the tests a separate module.
> 
> There are ways to restrict exported symbols to test modules only,
> see EXPORT_SYMBOL_FOR_TESTS_ONLY(), EXPORT_SYMBOL_FOR_MODULES(),
> and EXPORT_SYMBOL_NS().
> 
> If it is really hard to convert the tests into a separate module,
> you can add a new kernel/module parameter, which needs to be specified
> explicitly to run the test. That would avoid running the tests when just
> (auto)loading cifs.ko.
> 
>> On 2/10/26 4:10 PM, Geert Uytterhoeven wrote:
>>> Thanks for your patch, which is now commit 480afcb19b61385d
>>> ("smb/client: introduce KUnit test to check search result of
>>> smb2_error_map_table") in linus/master
>>>
>>>> The KUnit test are executed when cifs.ko is loaded.
>>> This means the tests are_always_ executed when cifs.ko is loaded,
>>> which is different from how most other test modules work.
>>> Please make it a separate test module, so it can be loaded independently
>>> of the main cifs module.  That way people can enable all tests in
>>> production kernels, without affecting the system unless a test module
>>> is actually loaded.
> 
> Gr{oetje,eeting}s,
> 
>                          Geert
> 


