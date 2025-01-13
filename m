Return-Path: <linux-cifs+bounces-3869-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AE636A0BD94
	for <lists+linux-cifs@lfdr.de>; Mon, 13 Jan 2025 17:31:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8A566188CBA0
	for <lists+linux-cifs@lfdr.de>; Mon, 13 Jan 2025 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9266122C9ED;
	Mon, 13 Jan 2025 16:29:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="qAW4+3B7"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA36F229807
	for <linux-cifs@vger.kernel.org>; Mon, 13 Jan 2025 16:29:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736785785; cv=none; b=jvSlWAfR40FWa8+HVEU8pp7HU8H+rHltDoUXmYZ3JX2EW5QYhQcGB4eVGC7geNjNclCApbvAPBYfEdzxWxswEh8LGAFaCWP7XSTpBqO8jmO0lh2gB3krgEKW9TyuY7+YnmPp90Z5jm7oNPXIAnbtYk+8DHiBb00ZDr1zzY0Ut0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736785785; c=relaxed/simple;
	bh=P3QUhybAxKVwWMxHp0B33M+WtJSFME9oVAENxGR2KaQ=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=qGJIDPQrUq9bSehcRys+mS7iskRiC+Gljdkc8aYd6SQL1uQewZXTL8MAbGSgkxTCepmmo6XlfX41D0OW9JygPbAwHP8ArSQDbULoEglcFV6uPRt0xHcihQc9fbfIU3G4Zv+LgbgDIFR02XJgRQk5Ld7zcdgsRV5qdmJuL5c7ToI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=qAW4+3B7; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
Message-ID: <6f1f7984ded4a0152854ecc07b0ab56d@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1736785781;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FIN8rEG+s+d5PSyqDk9s7Nk/OwStMpMe2I3qUH+xGDk=;
	b=qAW4+3B7aPYTjDGMqfHgrgqKih0nxHSTZkC7a37JOAjFRb8ZSL544nNFdLSyvne1hasmFU
	FnPtZuhidNP+pOP9tcL6JZQCpr29NKSuZq2L5e/BGpwFLI5G3ezhkF1W/n0KJNyGxjwab6
	G+A5vBJRklu3YsEsALv5shW/pqrJq0/oK8PZuRISkcKfi64qQMTIWQC/+N3fQ2Kt6ZNZ2h
	f0NOwh8qClt/YFKKn2cNGMOVgfg7pvRpLfnoWcc9WXgCImutzbG/EipbjPKlDedfUmDLIp
	lUuVuAR01Uyv0bFenua7W2THyb3+2KZ0Ee01NMUWWg46g2yUC+OF17lS6p3YMw==
From: Paulo Alcantara <pc@manguebit.com>
To: Shyam Prasad N <nspmangalore@gmail.com>
Cc: Steve French <smfrench@gmail.com>, Bharath SM <bharathsm.hsk@gmail.com>,
 CIFS <linux-cifs@vger.kernel.org>, David Howells <dhowells@redhat.com>, Al
 Viro <viro@zeniv.linux.org.uk>
Subject: Re: Negative dentries on Linux SMB filesystems
In-Reply-To: <CANT5p=rEjCwxm8t_zayJ3VGTcXYgBgnSaeFUHwkpuL0DfZY0=Q@mail.gmail.com>
References: <CANT5p=o-1V2ea-+Lj+M0h4=syXyJYu73JU3F0dXij=KVwWUTOw@mail.gmail.com>
 <eed163634d34c59bdfe3071c782276c2@manguebit.com>
 <CANT5p=rEjCwxm8t_zayJ3VGTcXYgBgnSaeFUHwkpuL0DfZY0=Q@mail.gmail.com>
Date: Mon, 13 Jan 2025 13:29:37 -0300
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Shyam Prasad N <nspmangalore@gmail.com> writes:

> Hi Paulo,
>
> Thanks for your replies.
>
> On Mon, Jan 13, 2025 at 8:55=E2=80=AFPM Paulo Alcantara <pc@manguebit.com=
> wrote:
>>
>> Shyam Prasad N <nspmangalore@gmail.com> writes:
>>
>> > Ideally, negative dentries should allow a filename lookup to happen
>> > entirely from the dentry cache if the lookup had happened once
>> > already. But I noticed that the SMB client goes to the server every
>> > time we do a stat of a file that does not exist.
>>
>> This is a network filesystem.  If the last lookup ended up with a
>> negative dentry in dcache, that doesn't mean the file won't exist the
>> next time we look it up again.  The file could have been created by a
>> different client, so we need to query it on server.
>
> I agree. But we do have tools to trade performance for accuracy using
> parameters like actimeo/acdirmax/acregmax.

Do you mean using these parameters for negative dentries?  These are
used for caching file attributes of files and directories, which means
they are all positive dentries.

> So we can avoid going to the server each time if it's within some interva=
l.
> If the server gives us dir leases, we can be sure that the dentries
> have not changed without us knowing. So we can definitely cache the
> negative dentries till as long as we have the lease.

Yes, that could be done with directory leases.

Note that negative dentries are also cached when @lookupCacheEnabled is
set.

