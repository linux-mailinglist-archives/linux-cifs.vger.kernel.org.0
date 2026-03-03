Return-Path: <linux-cifs+bounces-9955-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iPQSFg9PpmlCNwAAu9opvQ
	(envelope-from <linux-cifs+bounces-9955-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Tue, 03 Mar 2026 04:01:35 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 66D9A1E848E
	for <lists+linux-cifs@lfdr.de>; Tue, 03 Mar 2026 04:01:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 719D63042614
	for <lists+linux-cifs@lfdr.de>; Tue,  3 Mar 2026 03:01:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF85154774;
	Tue,  3 Mar 2026 03:00:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="FtjL4EKG"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A26A21E230E
	for <linux-cifs@vger.kernel.org>; Tue,  3 Mar 2026 03:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772506859; cv=none; b=XZvhASYV4Elh4ZcRMYM0Jq/V47gFkF9jvqSvy2txCWDz91PFhwFPvkmSRy2IVJCF5pwfXwZxl0r8zUWR5EQsCaaCUlep5Pp9cdeUm1LL5s4pyBLuQbXkjOs39UKREDIIvzUh0R55iPKSqgMFjjiU3p+hm+8jFuyZRrmedDuY56g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772506859; c=relaxed/simple;
	bh=9Kn4wBc9+L+QVqRyRlkcdfmcJlfpDm2/laanG3c31IU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rlqHEiDizTBA4nBmyr+IcT73wm74Pt5c6FjTSFbXZ+aXeDstvrk/vQgX02x3RqaCS6YTsM/SA7HzxVU9keae+6z9UuIpja2ED52aqzDWeTyZOioY84iEfEc/A3XbrXsc6/YquNVVa46b3JfJFuNQnF4NUv0NwosVNm+TIGVnr+w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=FtjL4EKG; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <09cb6f53-e5e1-4b42-9b25-b28860fe2a9e@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772506856;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WLEch/y2RM83ECNs+et/5JFV2QLg9L/eS2imK2YYq/I=;
	b=FtjL4EKG628X/DbbpfqrThNjc0u2Fbc87Bdh0wwpLzNCd+vBymV6EAQYIpgXGQhaJ68j7K
	5lrwNxkOMPWVKzG8sND1hhNiVR7HAqt8c0xdot/bi2PB5PTPEe/0/NMjrV2vBWQ1CsLDqM
	O4/vDqoacneLEsx+DAVEnQkjmOaPCqc=
Date: Tue, 3 Mar 2026 11:00:00 +0800
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
 <b257491a-e821-4b2a-8465-1aa1102d35b9@linux.dev>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ZhangGuoDong <zhang.guodong@linux.dev>
In-Reply-To: <b257491a-e821-4b2a-8465-1aa1102d35b9@linux.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 66D9A1E848E
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9955-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,chenxiaosong.com,vger.kernel.org,kylinos.cn];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.994];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhang.guodong@linux.dev,linux-cifs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	TAGGED_RCPT(0.00)[linux-cifs];
	RCPT_COUNT_FIVE(0.00)[6];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

And we cannot use `SidBuffer[32]` because the size of `SidBuffer[]` on 
the client side is not necessarily 32.

在 2026/3/3 10:41, ZhangGuoDong 写道:
> Hi Namjae,
> 
> C structure cannot have two flexible array members.
> 
> If we make `Sids[]` a flexible array member, then there cannot be any 
> members after it. However, this structure still has `filenamelength` and 
> `filename[]` after it. And `filename[]` is also a flexible array member.
> 
> Do you have any suggestions for this?
> 
> 在 2026/2/27 12:37, Namjae Jeon 写道:
>> You need to add Sids[] flex array here.
>>> +       // var sized owner SID
>>> +       // var sized group SID
>>> +       /* end of POSIX Create Context Response */
>>> +       // le32 filenamelength
>>> +       // u8 filename[]
>>> +} __packed;
> 


