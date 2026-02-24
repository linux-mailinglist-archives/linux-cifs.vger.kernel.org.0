Return-Path: <linux-cifs+bounces-9499-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id hy6tHAoYnWljMwQAu9opvQ
	(envelope-from <linux-cifs+bounces-9499-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Tue, 24 Feb 2026 04:16:26 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A795E18156A
	for <lists+linux-cifs@lfdr.de>; Tue, 24 Feb 2026 04:16:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D6CEA3061AD7
	for <lists+linux-cifs@lfdr.de>; Tue, 24 Feb 2026 03:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46142189B84;
	Tue, 24 Feb 2026 03:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EJtA40K9"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB0239E6C
	for <linux-cifs@vger.kernel.org>; Tue, 24 Feb 2026 03:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.218.53
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771902977; cv=pass; b=IKFclD1EszVqW97x6mRePAUgYj5z5KTD9WwoN2WRCsm8SBLkivhKtoGd9wBGIoklzBGyrp4zNaEhS/d53Z1aLJTTZm22xBWouABBzVfM2+m64k/BuBJ5VoX4Dz+M2wxmO6FaaBKDZKjY+X/31VDNkNj6xp42tOpJxGI6efcX0/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771902977; c=relaxed/simple;
	bh=/DZt0xtYa5lr6976gZvjB7WdGufQG5+fQI8ZuixrTvM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Avt+oU8kNyAvDHtXwvAna4W/xPl4nDwbSc20J4mQNF5RmGWfoP86D3ReNF+ghE6h+G6uLdLMgYR4x63gfJuNurbJovVl1R+gnCPqBt3EgjtPAbLTe5TitF9ZOqSEz7Voc6VvU6BoeZFmxNKweuQWCbhHUpPtkPxMHmt8w8OlrYI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EJtA40K9; arc=pass smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b90bb0e8376so171721166b.0
        for <linux-cifs@vger.kernel.org>; Mon, 23 Feb 2026 19:16:15 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771902974; cv=none;
        d=google.com; s=arc-20240605;
        b=M3iOVwki6DzLKYdRV43GIXhv6fmHHmguhpVWzDz1L+5zlmngUrKTgPM8uAFzMw6aai
         X1ZPlkJx1OjqyF2qcyw1vsQbq92+0wWKzdwAObJ/8JA5bCEIdbF9MTtW7usku8Qy14tF
         tgNmQdzueNAXspPAtLeBQ6F7IwqrKrqK/Ww5rUxLuaxCN0Y+aiFLVzObIA+TQ9lU3WFX
         qpsQb37rQAqFFbjxj9J4p9N1rpLBi01y7RUgWgWI3nSOzCQ7fVTxmAZLbZqFvbYsh+sx
         2YSLSpok7dCFwGTQ6NCddFnyUUz++3tHXCATSLWqVkpwYOWancaQTId3A0cMiy0fD+RS
         X13g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=/DZt0xtYa5lr6976gZvjB7WdGufQG5+fQI8ZuixrTvM=;
        fh=eYHKkHOGoF68NSHp1kLI5DBk55fpEtE1y6ay5lCi1VE=;
        b=b21fhBB1tMcXtDvY8Z6Xsi82Fjgr9T77fNrEpY/Mp1DM6w3NayFuOYGKn+9OxBpdJ7
         r5GXNVy4+L2GJwbApl40/9Lwy1v56WcFKyv/OApyZUR0gD83sragaRNxU0q0CyhBdeJ5
         xh+cr/uNkSBq819bP7ZUTwWdmR+mpJe2uAsbgAP01XkPYFcr9RkXXmUPFk99Ne46X4Cu
         3mStPqC/lZUKqiQn8NhNS5yaJaGn4s89ix4oaK+HaOqLKMasUB4mO+V+u4R845EGyb0r
         y5dHJywTm13fbQ2+kDYwmgur+NaEtgDNIwPWUDu0gC587Rs3GEshqgIkA2yUin+9J2/C
         4yZA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771902974; x=1772507774; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/DZt0xtYa5lr6976gZvjB7WdGufQG5+fQI8ZuixrTvM=;
        b=EJtA40K9HAoSdu5Nf5Nq2aG9PozmLTjJXiVzaSxUyZRnHGlsmpYrUVq/RE7WvoHJPa
         no/pdzQxnix8+xy8EOWY06jvz1LcZ4pWLu1F6rSQxFy12H/n/olMkaZg/r4zn/yiAj5s
         UKa1/Vfmc0yGnCsnK8aVMhdkc/EUlUgIQPR9ADi/gkvxat9lWFnOLpzRaSdrHUSSWXvP
         FWGJWa0DRFgIe2GFB7xjQjcgICPCoFCsooilZP4uExpbXEdORWr5lJPz5pSJNw/Zk5Lo
         CjK0Gqc4Bz53LuDP46VFJfRsdYjgtXuh23ulzt/IrTDzLwUSQdGtLu47rGMkfxvgda/O
         aiWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771902974; x=1772507774;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=/DZt0xtYa5lr6976gZvjB7WdGufQG5+fQI8ZuixrTvM=;
        b=A6VRCEFmsP9vYC79ysX4aJTR5on64qRs3zzacpzsRzTxTTKdaXwrOiC1xPk3LV5eG2
         HCoOPvdqh/U4LuFLOEkNGzsJbNhrCyH2RypoU1Aad3R9yrWvTK+eq+IRFvK6LrAvy3+g
         aqNju4ddQogC3GRAP7I+7mJeZH7QrPSBfv1i/ehtoFspWnGOAvY/doZc+Rb2cJBMZK8l
         9EG9Bok8GpTHHMnwOp8H8naqbqyBLBOS30rkHC8Rzq9wSTtoXGWjHL45FKZC4FMnSxH5
         HbWmrmN4GmNCWatFMtsbnpHShl6Rpe9+TAacaNAw/wZiqQFq2lh03u7oAyRiJE+pMR7J
         ZnGg==
X-Forwarded-Encrypted: i=1; AJvYcCXzgHYvgapJIsNZGc17THR4fwaj+Vq4hP7kyOjVUdb69HhLO3PacEB4DxCshSJ48SO/XL2jQjHUJ5Sy@vger.kernel.org
X-Gm-Message-State: AOJu0YzBOGBXSHO36hBEFXNewidX/dgpTxXw8S8lJ6ykD/+8yGkrfRIm
	daOSWpL+keD+Cs6TftagTgU+BouacK4nvd2bpclz69dmmHUSIR5KrS0ofPhbUAFN7YZOp6MbD/b
	iaCPyK76W3jxZ5u0RuNkNp+ph7RStKWk=
X-Gm-Gg: AZuq6aJLhJT3fUgQr6IBlnX7/JAUn1CXFndt1FqpuUh68WHySL4hsNjmFKwmTxcbgy1
	geHZvNuI+cZDA/zq3bIcC3an++4QaORc9LwHtJgPV0Ayi+9Rd1TwK0QB3pTdBlRT2RPOmmXvXY2
	kizL1mNaeF3u0qFZq7ldYF6lItyk19MFUsdVKQG8yaK79Wnymw3dKJTgK8+xViBMp+mwcX1wYeI
	lT4Y7Vk447naLNKj4uhdmLtvXYVcJbnbkx3SaordAd8tblJKHURvd6QCfpErzc1Y8/G9kykjACG
	G2LGzA==
X-Received: by 2002:a17:907:268c:b0:b8e:380:5669 with SMTP id
 a640c23a62f3a-b905448b905mr922119166b.32.1771902973804; Mon, 23 Feb 2026
 19:16:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANT5p=rDxeYKXoCJoWRwGGXv4tPCM2OuX+US_G3hm_tL3UyqtA@mail.gmail.com>
 <7570f43c-8f6c-4419-a8b8-141efdb1363a@app.fastmail.com> <CANT5p=rpJDx0xXfeS3G01VEWGS4SzTeFqm2vO6tEnq9kS=+iOw@mail.gmail.com>
 <510c1f0a-4f42-4ce5-ab85-20d491019c53@app.fastmail.com>
In-Reply-To: <510c1f0a-4f42-4ce5-ab85-20d491019c53@app.fastmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Tue, 24 Feb 2026 08:45:57 +0530
X-Gm-Features: AaiRm51Gum82xCPbCea-rxtnj6tTimqhg7EvD-Mp_KEO3nKBntLMk04j3n-RZRE
Message-ID: <CANT5p=q05gni_jd4=KHsmR0LnF5HE9gNfo17q6f8ngsjY5EZdw@mail.gmail.com>
Subject: Re: [LSF/MM/BPF TOPIC] Namespace-aware upcalls from kernel filesystems
To: Chuck Lever <cel@kernel.org>
Cc: lsf-pc@lists.linux-foundation.org, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, keyrings@vger.kernel.org, 
	CIFS <linux-cifs@vger.kernel.org>, linux-nfs@vger.kernel.org, 
	Christian Brauner <brauner@kernel.org>, David Howells <dhowells@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW(-0.50)[gmail.com,none];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_HAS_DN(0.00)[];
	TAGGED_FROM(0.00)[bounces-9499-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	MISSING_XM_UA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[nspmangalore@gmail.com,linux-cifs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	RCPT_COUNT_SEVEN(0.00)[8];
	FREEMAIL_FROM(0.00)[gmail.com];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: A795E18156A
X-Rspamd-Action: no action

On Tue, Feb 17, 2026 at 7:51=E2=80=AFPM Chuck Lever <cel@kernel.org> wrote:
>
>
>
> On Mon, Feb 16, 2026, at 11:14 PM, Shyam Prasad N wrote:
> > On Sat, Feb 14, 2026 at 9:10=E2=80=AFPM Chuck Lever <cel@kernel.org> wr=
ote:
> >>
> >>
> >> On Sat, Feb 14, 2026, at 5:06 AM, Shyam Prasad N wrote:
> >> > Kernel filesystems sometimes need to upcall to userspace to get some
> >> > work done, which cannot be achieved in kernel code (or rather it is
> >> > better to be done in userspace). Some examples are DNS resolutions,
> >> > user authentication, ID mapping etc.
> >> >
> >> > Filesystems like SMB and NFS clients use the kernel keys subsystem f=
or
> >> > some of these, which has an upcall facility that can exec a binary i=
n
> >> > userspace. However, this upcall mechanism is not namespace aware and
> >> > upcalls to the host namespaces (namespaces of the init process).
> >>
> >> Hello Shyam, we've been introducing netlink control interfaces, which
> >> are namespace-aware. The kernel TLS handshake mechanism now uses
> >> this approach, as does the new NFSD netlink protocol.
> >>
> >>
> >> --
> >> Chuck Lever
> >
> > Hi Chuck,
> >
> > Interesting. Let me explore this a bit more.
> > I'm assuming that this is the file that I should be looking into:
> > fs/nfsd/nfsctl.c
>
> Yes, clustered towards the end of the file. NFSD's use of netlink
> is as a downcall-style administrative control plane.
>
> net/handshake/netlink.c uses netlink as an upcall for driving
> kernel-initiated TLS handshake requests up to a user daemon. This
> mechanism has been adopted by NFSD, the NFS client, and the NVMe
> over TCP drivers. An in-kernel QUIC implementation is planned and
> will also be using this.
>
>
> > And that there would be a corresponding handler in nfs-utils?
>
> For NFSD, nfs-utils has a new tool called nfsdctl.
>
> The TLS handshake user space components are in ktls-utils. See:
> https://github.com/oracle/ktls-utils
>
> --
> Chuck Lever

Thanks Chuck. Will explore this in more detail.

--=20
Regards,
Shyam

