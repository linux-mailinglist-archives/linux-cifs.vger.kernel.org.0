Return-Path: <linux-cifs+bounces-9211-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id NZuOOnZqgGkd8AIAu9opvQ
	(envelope-from <linux-cifs+bounces-9211-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Mon, 02 Feb 2026 10:12:22 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3E4C9F33
	for <lists+linux-cifs@lfdr.de>; Mon, 02 Feb 2026 10:12:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 522D030117B6
	for <lists+linux-cifs@lfdr.de>; Mon,  2 Feb 2026 09:12:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A4BCA1EDA2B;
	Mon,  2 Feb 2026 09:12:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="v90m45p8"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-180.mta0.migadu.com (out-180.mta0.migadu.com [91.218.175.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62D903559C8
	for <linux-cifs@vger.kernel.org>; Mon,  2 Feb 2026 09:12:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770023540; cv=none; b=R0RnLss31QsKsM7CqIm6NxK7uV0V889mdL56Jjpfxym+Og+JNhE+V6UyB5nqiAAHmgTie6SXXeLsa3deJFzVdIHPVw+H0cY9hxvotc4X+1Lh6Xe/1sUS2bCDYe39AXc06T49cBpnweW+jTPS7/27DXkQYVnvxJoDnW31kGFI9S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770023540; c=relaxed/simple;
	bh=8hLiSEjotUQJ2+yfqqIhniS9RkwO5eJSUa/IbROf/mI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eJECalsl8SdBXeinctMq4aWOja15MtVbeZf8UnB8USgpKU9EeZ0chqUnkGWWBw3g8mpgUOx+VVwWwThRE1mLCjt4YNKTUv7xChF/AR1iGe7KBaQF2qSWj4/FZnX4fYyXveiiSzNQN7XxyZ/pVdXpLgJJ9QjP5raH4c4QcuTd5Oc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=v90m45p8; arc=none smtp.client-ip=91.218.175.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <7662c0de-b654-46c4-b3ca-aab3e4139574@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770023536;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YbPlFzeSB5+lX3KeriLs9V+sJhrJ26xdlymnSmqHwmk=;
	b=v90m45p8g1LDubl7oGzaq2cG0Ng5feRn3hRd26y2+mTLf/nchaH7D5Hyf3+RGvSZHFRvNQ
	t6ilUdasB8RHnFN6QNKw6ZktCR3ufPG4ss3oh6ZgNWNJTndQzjdKglKYNsiL8EU6oaL7ir
	tCrDuO+fcryKKB9335GB296Ci+PRH58=
Date: Mon, 2 Feb 2026 17:11:24 +0800
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 1/2] smb/client: fix memory leak in SendReceive()
To: Steve French <smfrench@gmail.com>
Cc: linkinjeon@kernel.org, pc@manguebit.org, ronniesahlberg@gmail.com,
 sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com,
 senozhatsky@chromium.org, dhowells@redhat.com, nspmangalore@gmail.com,
 henrique.carvalho@suse.com, meetakshisetiyaoss@gmail.com,
 ematsumiya@suse.de, pali@kernel.org, linux-cifs@vger.kernel.org,
 ChenXiaoSong <chenxiaosong@kylinos.cn>
References: <20260202082407.1881618-1-chenxiaosong.chenxiaosong@linux.dev>
 <20260202082407.1881618-2-chenxiaosong.chenxiaosong@linux.dev>
 <CAH2r5mt3nUrW_qvWCCHkiBPCoXg0XdwV07_wS+7Ls3p7AQ81HA@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <CAH2r5mt3nUrW_qvWCCHkiBPCoXg0XdwV07_wS+7Ls3p7AQ81HA@mail.gmail.com>
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
	TAGGED_FROM(0.00)[bounces-9211-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,manguebit.org,gmail.com,microsoft.com,talpey.com,chromium.org,redhat.com,suse.com,suse.de,vger.kernel.org,kylinos.cn];
	RCPT_COUNT_TWELVE(0.00)[16];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong.chenxiaosong@linux.dev,linux-cifs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-cifs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns,kylinos.cn:email,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 5C3E4C9F33
X-Rspamd-Action: no action

Should I send new version rebased on mainline? In that case, some of 
David's patches for the next merge window need further changes.

Thanks,
ChenXiaoSong <chenxiaosong@kylinos.cn>

On 2/2/26 4:50 PM, Steve French wrote:
> merged both into cifs-2.6.git for-next but this smb1 patch has
> dependencies on other patches for next merge window so might have been
> better to rebase on mainline so we could send sooner (although that
> would also require changing at least one other patch in for-next).


