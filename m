Return-Path: <linux-cifs+bounces-9969-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OJHFNKutpmnNSwAAu9opvQ
	(envelope-from <linux-cifs+bounces-9969-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Tue, 03 Mar 2026 10:45:15 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id BD3F91EC0ED
	for <lists+linux-cifs@lfdr.de>; Tue, 03 Mar 2026 10:45:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 6035530E4966
	for <lists+linux-cifs@lfdr.de>; Tue,  3 Mar 2026 09:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F0438C40F;
	Tue,  3 Mar 2026 09:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b="Vfs8bKed"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-170.mta0.migadu.com (out-170.mta0.migadu.com [91.218.175.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E5A301460
	for <linux-cifs@vger.kernel.org>; Tue,  3 Mar 2026 09:41:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772530918; cv=none; b=EPNbWxPSt+Rplc4L0t6C2ubjGlz5LwkDyZp+CvlhzqrBMplpv2eQFqau6XXHrXdWZ9YJ0wEUotbIcjSlBcbYNL1DnJTj5L4WuveBO4YxHPYJawtEsiv+o2tNvKpNPx+90VzC/PqRxESxRezy5yHFabfSM17vDgkxleOQFad2hJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772530918; c=relaxed/simple;
	bh=2nJ2rGoBlfKIEUmz7YLhn2VOgoX1CTI1Dwop277rykQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dxanw5uNULE3o1DTjlImr+2/GTpWtBtFI3GZ+e4niBiOaztX8ddQMcFyKZz3RuLmIfpMglV4+D4nKhidt221V0SP97H44eDxgjIx9I3pmwlIhHO+KWrDiEggyCkuNudyLobb5na5bNRRtvR4yXwL9uXzI7tL3SzxNNbETOte4gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com; spf=pass smtp.mailfrom=chenxiaosong.com; dkim=pass (2048-bit key) header.d=chenxiaosong.com header.i=@chenxiaosong.com header.b=Vfs8bKed; arc=none smtp.client-ip=91.218.175.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chenxiaosong.com
Message-ID: <e2763a4a-48ad-4fb5-8f40-4b78882fbc0e@chenxiaosong.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chenxiaosong.com;
	s=key1; t=1772530912;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YaEErTq6tn6IUI8wqiBujSBYmbA5HcT3rNnu3Mygfz8=;
	b=Vfs8bKedcepHRApgHcUo+9mR3Gb3gf03dWQm1ll4QhAcYMJyscfF+cz+uXTanF10zbXZSZ
	vicDRA1LWBIjFE0b0kKNIeZkKG/kIdX+lCUmzUka426p/vIE6+17ABV8a+RhEAawfw4CLR
	UFR70O+nzlP3F84qu8tfOotuMTjZoR+MgDwdyR8lHsdPgLg7eKSfI3J96OF8yTsI2Fk2bB
	/kKDj3tLBzglgy1IHowii2YKXGOdOwnkZmfuwgitT0oMOnYHsJ7qi3hT3O+OAYHZ1VQBXv
	HNJ6g/tYkgSenfenSdbZPnJwyrJ4RQL2AIz3Ir0FW0HpD7YBTuI4lRu2WmzOFA==
Date: Tue, 3 Mar 2026 17:41:02 +0800
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 5/5] smb: introduce struct file_posix_info
To: ZhangGuoDong <zhang.guodong@linux.dev>,
 Namjae Jeon <linkinjeon@kernel.org>, smfrench@gmail.com
Cc: linux-cifs@vger.kernel.org, ZhangGuoDong <zhangguodong@kylinos.cn>,
 ChenXiaoSong <chenxiaosong@kylinos.cn>
References: <20260225041100.707468-1-zhang.guodong@linux.dev>
 <20260225041100.707468-6-zhang.guodong@linux.dev>
 <CAKYAXd8ieg2fvYOK0BwBG8bbT18d9Z2A43-XoC21a5DArwsJKw@mail.gmail.com>
 <b257491a-e821-4b2a-8465-1aa1102d35b9@linux.dev>
 <09cb6f53-e5e1-4b42-9b25-b28860fe2a9e@linux.dev>
 <87181afa-553a-475c-8f08-3c292ba30ffb@chenxiaosong.com>
 <634dbb0b-9a5d-4f3d-ab5f-f4dc75e3527e@chenxiaosong.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong@chenxiaosong.com>
In-Reply-To: <634dbb0b-9a5d-4f3d-ab5f-f4dc75e3527e@chenxiaosong.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: BD3F91EC0ED
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[chenxiaosong.com,quarantine];
	R_DKIM_ALLOW(-0.20)[chenxiaosong.com:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[linux.dev,kernel.org,gmail.com];
	FORGED_SENDER_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9969-lists,linux-cifs=lfdr.de];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong@chenxiaosong.com,linux-cifs@vger.kernel.org];
	DKIM_TRACE(0.00)[chenxiaosong.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-cifs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

SMB311_posix_query_info() also has the same issue:

   output_len = sizeof(struct file_posix_info *) + ...

I have already told ZhangGuoDong to submit patches to fix these issues.

Thanks,
ChenXiaoSong <chenxiaosong@chenxiaosong.com>

在 2026/3/3 16:58, ChenXiaoSong 写道:
> In client-side, it seems there is a bug in the smb2_compound_op():
> 
>    SMB2_query_info_init(..., sizeof(struct smb311_posix_qinfo *) + ...)
> 
> We should calculate the size of `struct smb311_posix_qinfo`, not the 
> size of its pointer.
> 
> Code refactoring is very meaningful as it can uncover some potential 
> issues.


