Return-Path: <linux-cifs+bounces-9285-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6Ge4JLsGhmkRJQQAu9opvQ
	(envelope-from <linux-cifs+bounces-9285-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Fri, 06 Feb 2026 16:20:27 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 27C86FFAB1
	for <lists+linux-cifs@lfdr.de>; Fri, 06 Feb 2026 16:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 58C2230604AE
	for <lists+linux-cifs@lfdr.de>; Fri,  6 Feb 2026 15:17:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C00AB378D65;
	Fri,  6 Feb 2026 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="gtx23/Az"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3291B34E74D
	for <linux-cifs@vger.kernel.org>; Fri,  6 Feb 2026 15:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770391058; cv=none; b=pDt7ZiqbMg3CpSGhBa62qeJBum23XdnGKvOWm34FtPNH/NkzEtNTYsCKlCrUzb+WUNye/5H8Ky2N063TaCJ5Q8pLWMmpDyIsbcZ3BanEF8S0WXcEZkBI+Ca2Tcbn7ug3IXK08LHp1g/V2/v/RH53nwx4pXrU5/IsVA1nwFTjN68=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770391058; c=relaxed/simple;
	bh=QL+Ci8JNG4Jab+477SrUPaRyHlNgkrcnwkT3DNYVAYM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=n5NMS4Wtzg+vJCLktEDnWz7nNUgoTkDWwJS/U00JUCEgkYUveRZ4wj4POx7mZy7l/6FrCnvLEFqMQlu5MO5UYLOAna35HbwFSimdmaxYlaDxgPSu9FU+vNdVpA5bQ7t2D0kyHp6cEb9y1uQBCVFeUNKsXR0a4X/7JV+iABy2G78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=gtx23/Az; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=QL+Ci8JNG4Jab+477SrUPaRyHlNgkrcnwkT3DNYVAYM=; b=gtx23/AzHHoLA8NgOF1JGV50hI
	X4X7J8xN8g8oaBzBnI7rA+BPYYBNwbys8TbukTmd/Zjm/R7LeRo3WFSEnG/qvLNb9ieRo5q4lJXNK
	ownnXhSA+ZRtoRM/rtc2OTLTXamEuYjAPMxhFi4biBKmWElFj06aALvRo69Ds70q1VDaQbUTzHAkO
	ITPiexxpKy0yHLMz+Un68J0UWl7YucHGJrVFRR3frFf+SrGUOMzANqSu3EKZhxDLYo/wQ88pqUXtn
	cHpv2Xcpi1N85yKKCwsVFwod1hBAXomPFu3e4S9zDW0dfbqG8Ro2xosq+7qytsexb2FNSstMI7Fe9
	z4XcC6hojf4eRVrbrObaylukX8aVsnZXI8DTrhgnIhpkOnLm21s9L1W2K3GTdPj29ZbfrtCWT0AMd
	to5KW57udIzj+vZQuzTsBIBPt5sBPO7J1SKqrfb3E11j0ODK14dKw31yl5p5IOqbe6rLrTGuCfuBq
	HO/wapLtvq3Q55f4Wd0u1Gn2;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1voNaS-00000004fKV-158U;
	Fri, 06 Feb 2026 15:17:36 +0000
Message-ID: <67457856-95af-4d24-a8cc-61c94b391e80@samba.org>
Date: Fri, 6 Feb 2026 16:17:35 +0100
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 000/144] smb: smbdirect/client/server: moving to common
 functions and smbdirect.ko
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>,
 Long Li <longli@microsoft.com>, David Howells <dhowells@redhat.com>,
 Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org
References: <cover.1770311507.git.metze@samba.org>
 <CAKYAXd8JgWAM-zc5CdNeuHOsKaBYKPp9NQBd9=Z8G-RNOLm9VA@mail.gmail.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <CAKYAXd8JgWAM-zc5CdNeuHOsKaBYKPp9NQBd9=Z8G-RNOLm9VA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,talpey.com,microsoft.com,redhat.com,manguebit.org,vger.kernel.org,lists.samba.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9285-lists,linux-cifs=lfdr.de];
	DKIM_TRACE(0.00)[samba.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-cifs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[samba.org:mid,samba.org:dkim]
X-Rspamd-Queue-Id: 27C86FFAB1
X-Rspamd-Action: no action

Am 06.02.26 um 16:13 schrieb Namjae Jeon:
>> Namjae, can you please test in your setup?
> There are no issues in my testing,

Great thanks for testing!

> but since there are a lot of
> patches in this series, I need a few more days to review them.

Sure and thanks for doing it at all!

metze

