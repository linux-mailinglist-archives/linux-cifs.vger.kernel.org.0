Return-Path: <linux-cifs+bounces-9274-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id AA4tBjDrhGkj6gMAu9opvQ
	(envelope-from <linux-cifs+bounces-9274-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Thu, 05 Feb 2026 20:10:40 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 70FCFF6BB1
	for <lists+linux-cifs@lfdr.de>; Thu, 05 Feb 2026 20:10:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id E94F03003739
	for <lists+linux-cifs@lfdr.de>; Thu,  5 Feb 2026 19:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A581D313E0A;
	Thu,  5 Feb 2026 19:10:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="QT6ohywU"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-170.mta1.migadu.com (out-170.mta1.migadu.com [95.215.58.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7A9C279DB3
	for <linux-cifs@vger.kernel.org>; Thu,  5 Feb 2026 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770318633; cv=none; b=imViJPqmoFFm9boDbMdlNvjbYEp2P8YLOcZtthkDkSveH9RYDWSI9rrIoAEVPhqf6gEJqrt/TjFfrvb4x3vPc3BFIGe8H8OydurzOmfMqL2XcoOGRbWP3wVBRGnTS3mKo8xi4XyFdWz/vCzC8/yhOre2v1B+PAdB/6wuJGUl7FQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770318633; c=relaxed/simple;
	bh=SHaffgVQ3AfsAhH09BHidOacnI+0PzatJgcx+DGvBUU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=nBOYdEXjwp66vw+bDwBYzBN53IKVBWhLWZS25GaxS+VGDC4g9xUfqvqG/uvFmi6nCy+G0/BpZ+80QOzXXKBbW6DQDJD2rDwAA9wG+fVD5ZddrI8+YVOe3eG+hRctF64mxW7D+Gfz1/JuHvNMAyOxbaLaHcbqkLvODopGhO+qUTc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=QT6ohywU; arc=none smtp.client-ip=95.215.58.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <bfa4a0be-8429-4ea1-8bd6-691c3a47ff00@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1770318631;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SHaffgVQ3AfsAhH09BHidOacnI+0PzatJgcx+DGvBUU=;
	b=QT6ohywUWxVKWBRmDDcVulFl+N/cUIc67XYMirTIHRY3aol296YYq5GDbzXaQIaBBHjuEd
	dV5oZSQh8dLMp517yv3a0UZz3lyL66rYV809HWMeKxYn1UjuW/3yVpnJ0M4GAPjNbwdU2z
	V5oNdQfVVp3Pbxz0BrZ9ILiCT4215r4=
Date: Fri, 6 Feb 2026 03:10:20 +0800
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH] smb: client: fix potential UAF and double free it
 smb2_open_file()
To: Paulo Alcantara <pc@manguebit.org>, smfrench@gmail.com
Cc: David Howells <dhowells@redhat.com>, linux-cifs@vger.kernel.org
References: <20260205161952.245146-1-pc@manguebit.org>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ChenXiaoSong <chenxiaosong.chenxiaosong@linux.dev>
In-Reply-To: <20260205161952.245146-1-pc@manguebit.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9274-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[3];
	FREEMAIL_TO(0.00)[manguebit.org,gmail.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_THREE(0.00)[4];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[chenxiaosong.chenxiaosong@linux.dev,linux-cifs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-cifs];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:mid,linux.dev:dkim]
X-Rspamd-Queue-Id: 70FCFF6BB1
X-Rspamd-Action: no action

Is there a typo in the subject? Should it be "in ..." instead of "it ..."?

Thanks,
ChenXiaoSong <chenxiaosong@kylinos.cn>

On 2/6/26 12:19 AM, Paulo Alcantara wrote:
> [PATCH] smb: client: fix potential UAF and double free it smb2_open_file()


