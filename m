Return-Path: <linux-cifs+bounces-9293-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mCt2DGjgiWnGCwAAu9opvQ
	(envelope-from <linux-cifs+bounces-9293-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Mon, 09 Feb 2026 14:26:00 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B2810FA6A
	for <lists+linux-cifs@lfdr.de>; Mon, 09 Feb 2026 14:25:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id EBFF63029E48
	for <lists+linux-cifs@lfdr.de>; Mon,  9 Feb 2026 13:22:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 73D3E2DF6EA;
	Mon,  9 Feb 2026 13:22:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="PFIv+rwU"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9393377574
	for <linux-cifs@vger.kernel.org>; Mon,  9 Feb 2026 13:22:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770643375; cv=none; b=ril8wknb3R425YNxw1cjkVNYMxW0BsCWvNeIMOm3P10C+ybhh7zcAPYdi4bJT+sLAvDipJ7WrD6/eEpFX8xODGgSXbCBUIdy5/Kn1my0lBeMYcRN5wzFY14CB+B9u251TLKvCmvsZ3FFDvrBXl7lxbITzKiUScRDhbkcK+oQBSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770643375; c=relaxed/simple;
	bh=m6yLbNq8pbo0f2VeiH2CRK7RaxdcwwC81ffocnpLIsQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cwPr6ZWKEF3HiosN9ODFYqIQJbpry1uO8mNRRb+7RFDpyRW0HJcei9NZB4BFQESMeu0V7plUhrvB844L4G5fpcVUFzK5GzBA9l/Btu1w/rG4DwlQnbX+GLErf5502MxAwGw/Ok42oIp6xLRJiUcTYlYAM2W/0iuJIYh/4Qf29yM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=PFIv+rwU; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=hxwZHDu+1g7IyOpgKP2FpGJwTdgNLczpIn+wC89tEN0=; b=PFIv+rwUXWbCeRt9GO1T2eg3Zl
	7Yqw0ul2kVvGqtGaDLiutkgCzhsVXLZoNM8xEGlzOj/RaORG/5Gg97LdKKN5xhbjV0Hiyumh7ZzsD
	2yY1a6xwOmVnB/ko3AzUCyXoGbDbqOYM26UfZRBxPwuUzVAzUZhY+nsA/z6yQ8PZ/yWwvWsEd2u7Q
	seG5DHRQBsPuA6FRPwFawVd/mgUj1hvJTK2RpM3fTNCQP6RudF0t0sE5ZkWEDdBEpG5elkZWTDtLr
	ng5zyN+Wvyt/NAvfY26ZZ4nuwpeq08F3GUU5CKIIAZRMW3JcNpX0+bZDN615z8WP3hNalRdAbX5tS
	fDqg40N7EkZPV/JjKZgb0f+H1dJfumXqTla/QaDDYgTgpQyRkQ2XdzCa4nVq1INXjKLAnomPOXAMr
	wsuyz0960cZE0FGMlFux0eUZBRfIRpuTxFWS2tYSQpxktONcE7eNFeFjZCtRk1eF5FK3tUAVfoRTS
	7ZXcaobILh3HedbSco+BJtSp;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1vpRE4-00000005Dss-2018;
	Mon, 09 Feb 2026 13:22:52 +0000
Message-ID: <7140153c-7858-474b-abe5-aee69bd196a2@samba.org>
Date: Mon, 9 Feb 2026 14:22:51 +0100
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
 <CAKYAXd_CqpqXnh+k19NVdgQdDAnp6k5NbPqcyd0anocBJrGd_Q@mail.gmail.com>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <CAKYAXd_CqpqXnh+k19NVdgQdDAnp6k5NbPqcyd0anocBJrGd_Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[samba.org,quarantine];
	R_DKIM_ALLOW(-0.20)[samba.org:s=42];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9293-lists,linux-cifs=lfdr.de];
	FREEMAIL_CC(0.00)[gmail.com,talpey.com,microsoft.com,redhat.com,manguebit.org,vger.kernel.org,lists.samba.org];
	FROM_HAS_DN(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[samba.org:+];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[metze@samba.org,linux-cifs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,samba.org:mid,samba.org:url,samba.org:dkim]
X-Rspamd-Queue-Id: 88B2810FA6A
X-Rspamd-Action: no action

Am 09.02.26 um 08:29 schrieb Namjae Jeon:
>>
>> I tested with with mlx5_ib, irdma (roce) and rxe.
>> There's still a known problem with iwarp.
> Let me know what the known problem is.

It's the rw credit deadlock, as use rw credits
for the wrong thing, which means we easily deadlock
if the client uses an array smbdirect_buffer_descriptor_v1,
where the could larger than the possible rw credits
be calculated. While the max possible rw credits we calculate
is the value that is needed in order to
transfer the maximal rw size into a single
smbdirect_buffer_descriptor_v1.

This commit adds a WARN_ONCE detection for the
problem:
https://git.samba.org/?p=metze/linux/wip.git;a=commitdiff;h=e6260d7a518972ae1ca627e411cc16095c044d59

See the diff and commit messages of the top ~15 commits
in my for-6.18/ksmbd-smbdirect-regression-v4, which try to
fix the problem.

I try to fix it once I have the needed pcie adapters in
order to out my Chelsio T520-BT cards into the free x4 slot
of my testservers.

As there are some strange page fault problems with the irdma
driver, see
https://git.samba.org/?p=metze/linux/wip.git;a=commitdiff;h=a6b515cda103c1ac1537c92a4e9dbd75a31d92ef
And also
https://git.samba.org/?p=metze/samba/wip.git;a=commitdiff;h=e784b53167dc2cf4316b66a7599dab5b9e6c7208

For the client problem with irdma, see
https://git.samba.org/?p=metze/linux/wip.git;a=commitdiff;h=fb5cc2a59b4719015979a1f1355f66f27002b4cf
irdma_map_mr_sg may merge sg elements any may not return
the same value as the given sg_nents on success.

>>
>> So far I can't see any regression compared the
>> state before these 144 patches.
>>
>> Namjae, can you please test in your setup?
> 
> Is there any reason to print the log below by default?
> ksmbd: smb_direct: smbdirect_socket_schedule_cleanup(-ESHUTDOWN)
> called from smbdirect_socket_shutdown in line=650 status=LISTENING
> ksmbd: smb_direct: smbdirect_socket_schedule_cleanup(-ESHUTDOWN)
> called from smbdirect_socket_shutdown in line=650 status=LISTENING
> ksmbd: smb_direct: smbdirect_socket_schedule_cleanup(-ESHUTDOWN)
> called from smbdirect_socket_shutdown in line=650 status=CONNECTED
> ksmbd: smb_direct: smbdirect_socket_schedule_cleanup(-ESHUTDOWN)
> called from smbdirect_socket_shutdown in line=650 status=CONNECTED

I can move the above message to level INFO.

> ksmbd: smb_direct: status=ERROR first_error=-ESHUTDOWN => -ENOTCONN

This is basically the same messages as the one we
had in smb_direct_read() before:

         if (sc->status != SMBDIRECT_SOCKET_CONNECTED) {
                 pr_err("disconnected\n");
                 return -ENOTCONN;
         }

If I remember correctly it appeared just as:

'ksmbd: disconnected'

I can just move the new message to level INFO too, ok?

metze

