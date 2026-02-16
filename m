Return-Path: <linux-cifs+bounces-9400-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uPd9McsFk2nF0wEAu9opvQ
	(envelope-from <linux-cifs+bounces-9400-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Mon, 16 Feb 2026 12:55:55 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CE9E1432A4
	for <lists+linux-cifs@lfdr.de>; Mon, 16 Feb 2026 12:55:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id AD90130131F8
	for <lists+linux-cifs@lfdr.de>; Mon, 16 Feb 2026 11:55:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA707305E32;
	Mon, 16 Feb 2026 11:55:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="MADp3dBu"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3B42FD1BF;
	Mon, 16 Feb 2026 11:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771242952; cv=none; b=dO17TtG/qILKDXt3/pHBikcl0K2ZgfklVXwYJUej82OHwGeQ11dw6ViUHb7PGCXRaW1RDHjzw1EiHKt+ibtpgwafh+5OeKgv4JODXEWTbPBsK0UXYTv0XhjlqWEG81hYpYCerpKD2zG6QOpWk8rqt1BZpHS32vV4JPQ13FNIxZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771242952; c=relaxed/simple;
	bh=f93hYsXLuMZlhuKsF5GkrxnpOtZ5mymLiPiBJhjMyfE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ORFOssIlErjktWrc47K8ilWi8CKKdorzO4wQwBPWnAOxkARCps/lht0HU0int5DZZVIoZW/WPeXwLQA+N3Wb4hAgcm5wiBzHg2UOkiL/7NkTMxL/Wrn78GgovCXvEKLehbf2p4VVPBON+jDGkOtPez2WL9UCNRcUzBBoJNAAiWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=MADp3dBu; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=oE35lCAj6yVJIlgM36prvCB3oSo4KS122R/yLDGzMdM=; b=MADp3dBuUmDgdichSeMQtz3qkv
	hkEAxanLTUmfxvXnVdp07BFXZAhaYVdoSay29Ce86TI4aBZH1BA0q0QTgupKr74YcQ8AqT4vehyCR
	Lbi44MYla6wSbo9rsvPWZZhXBOWIHCR/tWfWjR4j6hLOEgOn900kTAyX3DQHUHDOSIMSaHMvOlgDC
	jwu2Cx03BsSVWwZ65LyGSF7h5zY8e9sw9n1Iri/jFtTgJEp5vHhIv+tkcbpk1/clBPt1HnlgWhi+D
	MuWHMxj2htotPcUTxKqJWn7Pk3CyNhLxoyaOHgYxGHo2qvsek2fvENOHjVW8oUcZUFTUwDO9JVX2N
	PDcIm4GEYmBdPVUUjNnV9Bon0H4Zrqcj2cPJwNBgmwnVRE1KzMeFbCd3MgcLeoxib4qHFWqlDO7jI
	gSI1CmZVYF+NjiPbZm9KFRRE7R1bp22dUxzGFXSi2+aKSJDHDGLuReg5QZi2etiSsl7rfva/fUJYP
	hqh+3jfJMVuy0D9uF2MiCPcH;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vrxCe-00000006b6Q-45p0;
	Mon, 16 Feb 2026 11:55:49 +0000
Message-ID: <1aeace58-7b90-4913-a6ce-7b94a1843a9d@samba.org>
Date: Mon, 16 Feb 2026 12:55:48 +0100
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smb: smbdirect: select CONFIG_SG_POOL
To: Arnd Bergmann <arnd@arndb.de>, Arnd Bergmann <arnd@kernel.org>,
 Steve French <sfrench@samba.org>, Namjae Jeon <linkinjeon@kernel.org>
Cc: Paulo Alcantara <pc@manguebit.org>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 Shyam Prasad N <sprasad@microsoft.com>, Tom Talpey <tom@talpey.com>,
 Bharath SM <bharathsm@microsoft.com>, Eric Biggers <ebiggers@kernel.org>,
 Ard Biesheuvel <ardb@kernel.org>, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org, linux-kernel@vger.kernel.org
References: <20260216105404.2381695-1-arnd@kernel.org>
 <63908802-3313-4118-bbd5-b1c677d23ac5@samba.org>
 <449b49a7-4266-41fe-b8ae-b3323339d51e@app.fastmail.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <449b49a7-4266-41fe-b8ae-b3323339d51e@app.fastmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9400-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[manguebit.org,gmail.com,microsoft.com,talpey.com,kernel.org,vger.kernel.org,lists.samba.org];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-cifs@vger.kernel.org];
	DKIM_TRACE(0.00)[samba.org:+];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samba.org:mid,samba.org:dkim]
X-Rspamd-Queue-Id: 2CE9E1432A4
X-Rspamd-Action: no action

Am 16.02.26 um 12:48 schrieb Arnd Bergmann:
> On Mon, Feb 16, 2026, at 12:15, Stefan Metzmacher wrote:
>> Hi Arnd,
>>
>> I'm wondering what the top commit is that you where compiling,
>> I guess that's before the 'smb: client: make use of smbdirect.ko'
>> commit.
> 
> I'm on today's linux-next-20260213, which contains
> 
> 4c91b67f87ac smb: client: fix data corruption due to racy lease checks
> 3774289f525c smb/client: move NT_STATUS_MORE_ENTRIES
> 617a5d2473dc smb/client: rename to NT_ERROR_INVALID_DATATYPE
> fa34d0a57033 smb/client: rename to NT_STATUS_SOME_NOT_MAPPED
> 4da735c48a27 smb/client: map NT_STATUS_PRIVILEGE_NOT_HELD
> 3e5f08342860 smb/client: map NT_STATUS_MORE_PROCESSING_REQUIRED
> e4424687fc6d smb/client: map NT_STATUS_BUFFER_OVERFLOW
> ba39063ca3ee smb/client: map NT_STATUS_NOTIFY_ENUM_DIR
> 66dc58bdbd7c cifs: SMB1 split: Remove duplicate include of cifs_debug.h
> 72f4d4803486 smb: client: fix regression with mount options parsing
> 72f4d4803486 smb: client: fix regression with mount options parsing
> 4c91b67f87ac smb: client: fix data corruption due to racy lease checks
> 3774289f525c smb/client: move NT_STATUS_MORE_ENTRIES
> 617a5d2473dc smb/client: rename to NT_ERROR_INVALID_DATATYPE
> fa34d0a57033 smb/client: rename to NT_STATUS_SOME_NOT_MAPPED
> 4da735c48a27 smb/client: map NT_STATUS_PRIVILEGE_NOT_HELD
> 3e5f08342860 smb/client: map NT_STATUS_MORE_PROCESSING_REQUIRED
> e4424687fc6d smb/client: map NT_STATUS_BUFFER_OVERFLOW
> ba39063ca3ee smb/client: map NT_STATUS_NOTIFY_ENUM_DIR
> 66dc58bdbd7c cifs: SMB1 split: Remove duplicate include of cifs_debug.h
> 72f4d4803486 smb: client: fix regression with mount options parsing
> d53f4d93f3d6 Merge tag 'v7.0-rc-part1-ksmbd-and-smbdirect-fixes' of git://git.samba.org/ksmbd
> 8f7df60fe063 ("ksmbd: fix non-IPv6 build")
> ...
> 
>> As we have this at the end of the patchset in ksmbd-for-next:
>>
>> fs/smb/common/smbdirect/Kconfig

Ah, ok, that was because Steve only had 1/3 of the patchset
applied last week.

So this problem should be gone in the next linux-next round,
will not have the problem.

> This file is not in linux-next as of today, as far as I can tell.
> 
>> config SMB_COMMON_SMBDIRECT
>>           def_tristate n
>>           depends on INFINIBAND && INFINIBAND_ADDR_TRANS
>>           depends on m || INFINIBAND != m
>>           select SG_POOL
>>
>> I'll try to change the patches to have your hunk
>> in the temporary phase in the patchset where we use
>> smbdirect_all_c_files, as it's gone at the end of
>> the patchset.

And once I tested my updated patchset and Steve
applied it, it should even work for every single
patch.

metze


