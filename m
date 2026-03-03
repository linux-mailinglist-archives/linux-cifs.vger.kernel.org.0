Return-Path: <linux-cifs+bounces-9954-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sOBsDHlKpmleNgAAu9opvQ
	(envelope-from <linux-cifs+bounces-9954-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Tue, 03 Mar 2026 03:42:01 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B8091E8230
	for <lists+linux-cifs@lfdr.de>; Tue, 03 Mar 2026 03:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 068F63055CAE
	for <lists+linux-cifs@lfdr.de>; Tue,  3 Mar 2026 02:41:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49AC2374E71;
	Tue,  3 Mar 2026 02:41:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="nDkwIwO1"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-179.mta0.migadu.com (out-179.mta0.migadu.com [91.218.175.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7BC219ADB0
	for <linux-cifs@vger.kernel.org>; Tue,  3 Mar 2026 02:41:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772505718; cv=none; b=fN9M2aEEnUMgGWNDdCS1EN4wfGlcNwprb7Pmh707Ad58I0doqxRR6sLLY/E7GAdl6x58QjjUVRx3eOAd1NgX4ghSj2yCZonpZVjpsOl0CThN3VXqzQOWhavF4zc1hEmoWEeC/IVIDH9Z50OREkxSIugY72N9wYWwhttt8wiE7JQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772505718; c=relaxed/simple;
	bh=yfR4WW73Chsypf7R/DSKzbpJukZGpzI3aU99AeL5R3E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=N0jjKF199VpBpxJ9vhL5QOFrnsGDopmxSKEG1v0FIBLpzdwymII+Fc64SDp+LmNXAefDhNZIJ0hgk891KM4wCFQKpPA0OfmrAnaen8Nm0BgkPQltVYP7obsZfQDxPdXqiLG1ptAnuCtCNVcpgp2Drhw6WvhxYUYFtA51AzzyY48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=nDkwIwO1; arc=none smtp.client-ip=91.218.175.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <b257491a-e821-4b2a-8465-1aa1102d35b9@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772505715;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2ZStrX35wTKSSx0VLv53Wsqliczl7CjvFkvPYYlZg/o=;
	b=nDkwIwO1BxfKuRHJ5feROa2o8S7F8YFdwm4I9XcnNo/Wwdwc5TsnjNf8oJ/U/ik2Ihc/M/
	sFobxXlUosFpLdgLUlARQbGahjxXcRNNqLQoUP2FU8Erd2moX23vkcGH2u6vT+v7LPmWxb
	IMqIRukwq6UNZIGyfRxq3fcp2/YYqnM=
Date: Tue, 3 Mar 2026 10:41:03 +0800
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v4 5/5] smb: introduce struct file_posix_info
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: smfrench@gmail.com, chenxiaosong@chenxiaosong.com,
 linux-cifs@vger.kernel.org, ZhangGuoDong <zhangguodong@kylinos.cn>,
 ChenXiaoSong <chenxiaosong@kylinos.cn>
References: <20260225041100.707468-1-zhang.guodong@linux.dev>
 <20260225041100.707468-6-zhang.guodong@linux.dev>
 <CAKYAXd8ieg2fvYOK0BwBG8bbT18d9Z2A43-XoC21a5DArwsJKw@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ZhangGuoDong <zhang.guodong@linux.dev>
In-Reply-To: <CAKYAXd8ieg2fvYOK0BwBG8bbT18d9Z2A43-XoC21a5DArwsJKw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 8B8091E8230
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9954-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,chenxiaosong.com,vger.kernel.org,kylinos.cn];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.993];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhang.guodong@linux.dev,linux-cifs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TAGGED_RCPT(0.00)[linux-cifs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

Hi Namjae,

C structure cannot have two flexible array members.

If we make `Sids[]` a flexible array member, then there cannot be any 
members after it. However, this structure still has `filenamelength` and 
`filename[]` after it. And `filename[]` is also a flexible array member.

Do you have any suggestions for this?

在 2026/2/27 12:37, Namjae Jeon 写道:
> You need to add Sids[] flex array here.
>> +       // var sized owner SID
>> +       // var sized group SID
>> +       /* end of POSIX Create Context Response */
>> +       // le32 filenamelength
>> +       // u8 filename[]
>> +} __packed;


