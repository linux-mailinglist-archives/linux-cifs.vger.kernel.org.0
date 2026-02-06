Return-Path: <linux-cifs+bounces-9280-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 6MP8JI63hWmOFgQAu9opvQ
	(envelope-from <linux-cifs+bounces-9280-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Fri, 06 Feb 2026 10:42:38 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A9FF8FC2D2
	for <lists+linux-cifs@lfdr.de>; Fri, 06 Feb 2026 10:42:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 08D67300D247
	for <lists+linux-cifs@lfdr.de>; Fri,  6 Feb 2026 09:42:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F0B2EB87D;
	Fri,  6 Feb 2026 09:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="j9pkG6RC"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 966E7360753
	for <linux-cifs@vger.kernel.org>; Fri,  6 Feb 2026 09:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770370935; cv=none; b=hQfZbXQdQQmGHAyt3N7ZbDoUYljzSQHIctJ0xluBwf9+dx/gDk3ebPq/YJlqWs7MI1ov5YTUD2RikGjgwf5DRv5RTlFSXix2CbZf5jzoONb4zq97fVD0EkFNWa3hEd58zdyAZGt28JQOtGFQsPVlWXOK9BY76a0zz3ufDGbcWCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770370935; c=relaxed/simple;
	bh=E3H8cA9O0aO8sPwiYqdsAEnScFkV7Js/6ZKjZBMILWM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Ab816GZhkcM7PV7nRp/qM937LNsMbbizhzYJvEsLjaG/XjwXs5YIlhZ+OAWh93d2k3LSAysAYrl1ZOmbgcMHQ6Rb8O20w6ih8yl4k5dJ1nSCdPZWaZC8YdhtYD/jBJMslLta/P/Q7IoctCwRIqxe7Rla6A9bTRf5a5HWnzE5djQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=j9pkG6RC; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=0rbDj6+o5EvshXrYpdmUBhOMVChKenT8+ygziM7c688=; b=j9pkG6RCgKtPj6lNhjX3OrB8I7
	y5qPgvb/LNe5Cb08nvp7uLetqX9I2LpcK6NZEc2IUFi8+yt9KU/XvPua5U32F0VzXcSQTOCk2TTNt
	pzDh45lT8mFVSwyPhrhzm4vh2G0f2MnrXMcfRaYZVUC0HdAwiunoDWgJwFIrDOl/kGHIBx6etU9HT
	faxhOB4LBgp22Xz9dOqL14Y5OhEbeiVfwCKyrpRmYnh+ZzHmodZcyggzD7pivDhfOM7b/uYntTMzZ
	tphMPtGf1TTezJ1yACWmdzMY++maSxvMPkxQYUgZkzOLbzJ8lw64fVLxw7o9drthIOXMiOYoD/Q6N
	iXoxmdu/w5SzXZ3xzvtFg1vWr1/rcvQFhzu0FLs0GWfC4qrggwIm72mcWIUooLF0X6yEUYR9EHzeV
	OdT8uYK/k61KkdWltKDZG8QO/KPoy1PyDg0p53kdifmb4z6L3MXTK6TYaNMVIddjck2mUmqJ4lcQz
	awAV6imdz89+irmBYmsp/MNV;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1voILs-00000004cY1-01Pd;
	Fri, 06 Feb 2026 09:42:12 +0000
Message-ID: <11ef6c9e-01f3-4c09-b16d-5e652624c257@samba.org>
Date: Fri, 6 Feb 2026 10:42:11 +0100
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] smb: common: add header guards to
 fs/smb/common/smb2status.h
To: David Howells <dhowells@redhat.com>
Cc: Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>,
 Long Li <longli@microsoft.com>, Namjae Jeon <linkinjeon@kernel.org>,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
References: <e2726e90-3645-44ef-9af8-2d390c4d5bc6@samba.org>
 <20260203152012.914137-1-metze@samba.org>
 <68046261-f2d9-49a2-92ea-9c7abb97cd5e@samba.org>
 <46c9afa7-7834-4ac4-8509-b7087f358c96@samba.org>
 <2901815.1770327095@warthog.procyon.org.uk>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <2901815.1770327095@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[gmail.com,talpey.com,microsoft.com,kernel.org,vger.kernel.org,lists.samba.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-9280-lists,linux-cifs=lfdr.de];
	DKIM_TRACE(0.00)[samba.org:+];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-cifs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,samba.org:email,samba.org:dkim,samba.org:mid]
X-Rspamd-Queue-Id: A9FF8FC2D2
X-Rspamd-Action: no action

Am 05.02.26 um 22:31 schrieb David Howells:
> Stefan Metzmacher <metze@samba.org> wrote:
> 
>> diff --git a/fs/smb/client/Makefile b/fs/smb/client/Makefile
>> index 802dec276e15..3abd357d6df6 100644
>> --- a/fs/smb/client/Makefile
>> +++ b/fs/smb/client/Makefile
>> @@ -47,7 +47,7 @@ cifs-$(CONFIG_CIFS_COMPRESSION) += compress.o compress/lz77.o
>>   #
>>   # Build the SMB2 error mapping table from smb2status.h
>>   #
>> -$(obj)/smb2_mapping_table.c: $(srctree)/fs/smb/common/smb2status.h \
>> +$(obj)/smb2_mapping_table.c: $(src)/../common/smb2status.h \
>>                              $(src)/gen_smb2_mapping
>>          $(call cmd,gen_smb2_mapping)
> 
> That looks reasonable.  Do you have a patch for it, if so, you can add:
> 
> 	Reviewed-by: David Howells <dhowells@redhat.com>

I'd propose that Steve just squashes this into your commit
cifs: Autogenerate SMB2 error mapping table

Thanks!
metze


