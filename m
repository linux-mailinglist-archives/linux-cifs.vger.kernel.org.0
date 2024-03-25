Return-Path: <linux-cifs+bounces-1560-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CCA0088AC51
	for <lists+linux-cifs@lfdr.de>; Mon, 25 Mar 2024 18:49:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 59C961FA0F09
	for <lists+linux-cifs@lfdr.de>; Mon, 25 Mar 2024 17:49:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CB6982876;
	Mon, 25 Mar 2024 17:05:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b="W+DFhOgI"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CBD81207
	for <linux-cifs@vger.kernel.org>; Mon, 25 Mar 2024 17:05:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711386327; cv=none; b=PByCkVWP0Ikw/Z+UH48Jy7WAmJbKwpYYWbCvQvUh2ARRHmtB7J3HClOl46MTgq7P930DFmIKjKZ3f/HNWYYrKvX/7uoRVQf8+5CLtasPXy0GEdoLG4uvZZ8mG87iZVoehuWP2QPFfKVGKyaykcMAiit9HTvoEE8E+v4O1s/jtBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711386327; c=relaxed/simple;
	bh=nlSSMt5mXwqBGalL5blRWfMGpq6ZzxT1oNeGbmu1GWs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hsuvpg9YJq8xOhzddNEm4rQV6DQvELHVQtKUhJOvH6lpctxa1BUjs1UogzhCEOxOaonxCCrfFmG0XVwnmZE0bxWQtuVkNL2oWZoC4ymvRoEDKFgatIsoibtN20LADsYVy8L9W0LYneS8sf3f5RuASrQn98r7Os8dNdIbssb8eT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com; spf=pass smtp.mailfrom=paul-moore.com; dkim=pass (2048-bit key) header.d=paul-moore.com header.i=@paul-moore.com header.b=W+DFhOgI; arc=none smtp.client-ip=209.85.128.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=paul-moore.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=paul-moore.com
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-609ff069a40so51822637b3.1
        for <linux-cifs@vger.kernel.org>; Mon, 25 Mar 2024 10:05:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1711386323; x=1711991123; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VLQn9MYedg2dmO1Rz4dYvveAYrX8Cm/Wfbouj1emns4=;
        b=W+DFhOgIFhgU0e5uvjoYSBKYPE8a+2gSbUGFb1I6IaMqC6VylewY6tGi2YOx0gxHRu
         SDX0cr5OLHAVhzjabpfbmac+aJHZms1LJErfHo0J8Ne+tpYHIyCXOMOmY+aM7u9RxlUI
         I9ZJJgBR5risV2OZmko9gcSKq4r3H3cWk6ZWO4pW9vJByT/m2iumfBET3QuqaFm5xhN9
         NmfHp7aAorYKPQjlf7TdbKfsqpa+qCfY+fo4eLTbIUn9pA5dU+25vkyKLCTWTlOY0Qe2
         +2g0W9sVaBHdDyTqm8aI4UgSRDh+Qo4DFB0IguHkwfuBuSOuOSRh9VHsjCRaPUmJSJpj
         IaUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711386323; x=1711991123;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VLQn9MYedg2dmO1Rz4dYvveAYrX8Cm/Wfbouj1emns4=;
        b=sVw8WxTW4iRXNGIdE8xYg4AgTuKzcZ7aJySfjMQ4cO2EB0vyeU1T2FQMPvSiRiR+YN
         5R1JUFgUSZhq45qpbwJ2pttV6A/W6+E/gSDTS1b3xJRl1Gto2p3DnDLqb2wPBAZIyClS
         GxXw97zXbq8Wj0JDPpqRuP9rlkdUWxa+O5h1Nlkw/haTb1l/C7g18uzf+q+SPfMBXH3j
         xKK4ZZooFJbUY5Do1+A93xrCLWCK5kVgzaoiBzZFyxTjOIlbPlj93Q6s8Xj01JFrBkLo
         OdzhYgTcgxAsk1fN22ooAvFupnoutIH+NxnzkYfCUFzhWSUoR2FaiHsaUNDEHkHTwUn3
         kZsg==
X-Forwarded-Encrypted: i=1; AJvYcCXbD9W9mHGRm5YiX3q/e7hUr7g+wsbwUwhNT8E7CwPuFae/K0o11DLhJsBH38HwXKYdswvK/CZ3k1o3TdTMXo6C4CLCMo7t2tWFlA==
X-Gm-Message-State: AOJu0YzqJBpXpgFfVWgldwLfYU20LMdVuvvLW3D6XDiKf4mOiC6gdb08
	cNFC5ewc019ASvuYZzVdm/dPpUWvkyI5rwNUvx9QKT47+kkKQHzIq+P67AqShjdiYIJTRI7wSnQ
	QZoC6Uc5LSU6KfnckSsn0RG7XJBUERqqvCojH
X-Google-Smtp-Source: AGHT+IH8SKXcHLa/N0j8oDO0At0piSt20b+qBOvqQCAPOuA8Lr1UL1ce3qGpb4Hy9sFCBalXLz90o5YFvzmCEolwMHE=
X-Received: by 2002:a0d:f8c2:0:b0:610:1a19:14fa with SMTP id
 i185-20020a0df8c2000000b006101a1914famr5840753ywf.50.1711386323040; Mon, 25
 Mar 2024 10:05:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5msAVzxCUHHG8VKrMPUKQHmBpE6K9_vjhgDa1uAvwx4ppw@mail.gmail.com>
 <20240324054636.GT538574@ZenIV> <3441a4a1140944f5b418b70f557bca72@huawei.com>
In-Reply-To: <3441a4a1140944f5b418b70f557bca72@huawei.com>
From: Paul Moore <paul@paul-moore.com>
Date: Mon, 25 Mar 2024 13:05:12 -0400
Message-ID: <CAHC9VhQ2OO4M5XRjoUDmtkFVd2LWGUKOj0B=McxD+Mj4gv85nQ@mail.gmail.com>
Subject: Re: kernel crash in mknod
To: Roberto Sassu <roberto.sassu@huawei.com>
Cc: Al Viro <viro@zeniv.linux.org.uk>, Steve French <smfrench@gmail.com>, 
	LKML <linux-kernel@vger.kernel.org>, 
	linux-fsdevel <linux-fsdevel@vger.kernel.org>, CIFS <linux-cifs@vger.kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Christian Brauner <christian@brauner.io>, 
	Mimi Zohar <zohar@linux.ibm.com>, 
	"linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>, 
	"linux-security-module@vger.kernel.org" <linux-security-module@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Mar 24, 2024 at 12:50=E2=80=AFPM Roberto Sassu <roberto.sassu@huawe=
i.com> wrote:
> > From: Al Viro [mailto:viro@ftp.linux.org.uk] On Behalf Of Al Viro
> > Sent: Sunday, March 24, 2024 6:47 AM
> > On Sun, Mar 24, 2024 at 12:00:15AM -0500, Steve French wrote:
> > > Anyone else seeing this kernel crash in do_mknodat (I see it with a
> > > simple "mkfifo" on smb3 mount).  I started seeing this in 6.9-rc (did
> > > not see it in 6.8).   I did not see it with the 3/12/23 mainline
> > > (early in the 6.9-rc merge Window) but I do see it in the 3/22 build
> > > so it looks like the regression was introduced by:
> >
> >       FWIW, successful ->mknod() is allowed to return 0 and unhash
> > dentry, rather than bothering with lookups.  So commit in question
> > is bogus - lack of error does *NOT* mean that you have struct inode
> > existing, let alone attached to dentry.  That kind of behaviour
> > used to be common for network filesystems more than just for ->mknod(),
> > the theory being "if somebody wants to look at it, they can bloody
> > well pay the cost of lookup after dcache miss".
> >
> > Said that, the language in D/f/vfs.rst is vague as hell and is very eas=
y
> > to misread in direction of "you must instantiate".
> >
> > Thankfully, there's no counterpart with mkdir - *there* it's not just
> > possible, it's inevitable in some cases for e.g. nfs.
> >
> > What the hell is that hook doing in non-S_IFREG cases, anyway?  Move it
> > up and be done with it...
>
> Hi Al
>
> thanks for the patch. Indeed, it was like that before, when instead of
> an LSM hook there was an IMA call.
>
> However, I thought, since we were promoting it as an LSM hook,
> we should be as generic possible, and support more usages than
> what was needed for IMA.
>
> > diff --git a/fs/namei.c b/fs/namei.c
> > index ceb9ddf8dfdd..821fe0e3f171 100644
> > --- a/fs/namei.c
> > +++ b/fs/namei.c
> > @@ -4050,6 +4050,8 @@ static int do_mknodat(int dfd, struct filename *n=
ame, umode_t mode,
> >               case 0: case S_IFREG:
> >                       error =3D vfs_create(idmap, path.dentry->d_inode,
> >                                          dentry, mode, true);
> > +                     if (!error)
> > +                             error =3D security_path_post_mknod(idmap,=
 dentry);
>
> Minor issue, security_path_post_mknod() does not return an error.
>
> Also, please update the description of security_path_post_mknod() to say
> that it is not going to be called for non-regular files.
>
> Hopefully, Paul also agrees with this change.
>
> Other than that, please add my:
>
> Reviewed-by: Roberto Sassu <roberto.sassu@huawei.com>

No objections here for obvious reasons.

Acked-by: Paul Moore <paul@paul-moore.com>

--=20
paul-moore.com

