Return-Path: <linux-cifs+bounces-10119-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wFi1HYLxqmncYwEAu9opvQ
	(envelope-from <linux-cifs+bounces-10119-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Fri, 06 Mar 2026 16:23:46 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CF37E223B45
	for <lists+linux-cifs@lfdr.de>; Fri, 06 Mar 2026 16:23:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1507E3140887
	for <lists+linux-cifs@lfdr.de>; Fri,  6 Mar 2026 15:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8997A32AAA3;
	Fri,  6 Mar 2026 15:17:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="eU7Ku2ay"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 414B3336EEE;
	Fri,  6 Mar 2026 15:17:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772810249; cv=none; b=M/sfJPMYmjNVXnNU7TJni4c2p08vF8BXNmzX6S1TkTrj3XA0lI8TL+TNF1/CDD53m89688NgCDqCM7NBTZqTrvPAICMCR1MztLX6jHgA9j+TkyoR7cGzeria8fTle62O/U7CMjbX4DJnrrZPM5eFVpTQRxRVxFVNj7A5uJAPxRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772810249; c=relaxed/simple;
	bh=zfQvdfdAJTQ0dJxeIAqyw6Ss+gCxnIzNY7PKDfTQPvs=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=RC2JcK9ZtpbzGTm51AsnTVe6/bFL0KSkmWSHwUSm9lOPfgvqUNjkLAHH/A+fNVISwenv94rtJGKekNTYz4m1KOJGvj+8DOqk9if55mKuQEdXOsd+q7GThskcOErE47RDyRSG27T0GmZqO9Hr/gkyVkTMAGQbyKcUtZ+7TTWt7+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=eU7Ku2ay; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=2plEPPs0t8yJLPAzJK4Ki4jde70YeW+1bDaFYeVvY8g=; b=eU7Ku2ayzL/koO92jMCesaIh18
	jj5TIQKcZRqJ1uV/osmAXvw0OZOmmKJ2BixthVgtWx/BLk3LzrMnEFmfcXXBYuGUkpT8bQGHjqoj6
	K/ZXoAzX0dLWgWHJFva2XX6sFEC5bVZjFSSUmgtwgs0KyQT5HZEzF3DDjfiBT52Prl4jaxTNnWn/G
	DYll5/QmVZ1Bih/Q0MohtesVt/UY5L8fR5Ek3tL5Z74bz1q9HSnD3BV3ehu+Pcjq7usUPHJ7Kq4kd
	fK18xkqs4uuyosIfSLnZLxM/s+wdWB+x8VLkzpgsaneUuCAGc69eFVjPGzxkipKGHv5+7+V8rnniw
	pwOJd7sA==;
Received: from pc by mx1.manguebit.org with local (Exim 4.99.1)
	id 1vyWvY-00000000Nts-0hgm;
	Fri, 06 Mar 2026 12:17:20 -0300
Message-ID: <8fa24f86dcbe2ef367b3e35fb6e1da5c@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: Arnd Bergmann <arnd@kernel.org>, Steve French <sfrench@samba.org>, David
 Howells <dhowells@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Ronnie Sahlberg
 <ronniesahlberg@gmail.com>, Shyam Prasad N <sprasad@microsoft.com>, Tom
 Talpey <tom@talpey.com>, Bharath SM <bharathsm@microsoft.com>, Henrique
 Carvalho <henrique.carvalho@suse.com>, Markus Elfring
 <elfring@users.sourceforge.net>, Al Viro <viro@zeniv.linux.org.uk>,
 linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] smb: client: fix sbflags initialization
In-Reply-To: <20260306150717.483742-1-arnd@kernel.org>
References: <20260306150717.483742-1-arnd@kernel.org>
Date: Fri, 06 Mar 2026 12:17:19 -0300
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Rspamd-Queue-Id: CF37E223B45
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[manguebit.org,quarantine];
	R_MISSING_CHARSET(0.50)[];
	R_DKIM_ALLOW(-0.20)[manguebit.org:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10119-lists,linux-cifs=lfdr.de];
	FREEMAIL_CC(0.00)[arndb.de,gmail.com,microsoft.com,talpey.com,suse.com,users.sourceforge.net,zeniv.linux.org.uk,vger.kernel.org,lists.samba.org];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[14];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[manguebit.org:+];
	MISSING_XM_UA(0.00)[];
	TO_DN_SOME(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pc@manguebit.org,linux-cifs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	NEURAL_HAM(-0.00)[-0.995];
	TAGGED_RCPT(0.00)[linux-cifs];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Action: no action

Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The newly introduced variable is initialized in an #ifdef block
> but used outside of it, leading to undefined behavior when
> CONFIG_CIFS_ALLOW_INSECURE_LEGACY is disabled:
>
> fs/smb/client/dir.c:417:9: error: variable 'sbflags' is uninitialized when used here [-Werror,-Wuninitialized]
>   417 |                                 if (sbflags & CIFS_MOUNT_DYNPERM)
>       |                                     ^~~~~~~
>
> Move the initialization into the declaration, the same way as the
> other similar function do it.
>
> Fixes: 4fc3a433c139 ("smb: client: use atomic_t for mnt_cifs_flags")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  fs/smb/client/dir.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)

Reviewed-by: Paulo Alcantara (Red Hat) <pc@manguebit.org>

