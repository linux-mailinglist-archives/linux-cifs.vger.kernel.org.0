Return-Path: <linux-cifs+bounces-3940-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A12F0A18E75
	for <lists+linux-cifs@lfdr.de>; Wed, 22 Jan 2025 10:34:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E53B0161315
	for <lists+linux-cifs@lfdr.de>; Wed, 22 Jan 2025 09:34:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 480A51C3C18;
	Wed, 22 Jan 2025 09:34:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="izXFrp4I"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 968A11514CE
	for <linux-cifs@vger.kernel.org>; Wed, 22 Jan 2025 09:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737538454; cv=none; b=d+hXee8kXfDjpgsuIlUlEqUvkUC0OZMHPsgLMljg7GeEjkoW5tdrxRC7x+wmN805M/CotFthuknYprzN+SP4juUVnOQwzWJZJ7tDhB92HTt/6D0ffJVsQOVsZP/fhu99WuKqdeKCdeb/mBDYFlWc5E3GwrFu76Y2UIVUkBRlDto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737538454; c=relaxed/simple;
	bh=Ih63PNoRjOCyuaAbH4Np3MqtCdd+CCchixZcjHgf77Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y8ab9C0p1MuAqZTPskdwsVSdUx6FnT48W4AJchRWxlNux9tJLpGvMRCJRPNOo1L7lUrSawXUCpFezG1h4YuSGQZdGklndzmulSFtnjFB6tEymvWX1kOwJTDKIZkKECzCiBhnOd+LSN3Fv1vadB4YvcJNoWbJQx6D+Oump+q8yiM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=izXFrp4I; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5d3f57582a2so1457648a12.1
        for <linux-cifs@vger.kernel.org>; Wed, 22 Jan 2025 01:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737538451; x=1738143251; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5QIsBAwP8k3rVSff01/p1/7nWWbCnzWPU+0ZOSqzIlU=;
        b=izXFrp4ITiRdLdIIq4gayVu3lQFZgFnJ4KJxiClpBp3ghW4aZjeGBl5C9YWsuCyeM8
         ddGYwknNa3nqbPmETnGFWdPi7oLgr4WKDo2UcGHzSb9naRIu+nKBGmHVLzNv3DPEUXlg
         R60JDYL75XvxlEwO6DF0tEh6UmPYhh3AyjJ2mC4n1lH9CFc78n8YoirFVhGOQc6o+vxn
         66J1cuvzWikRtJY6xQGzFyRphBQNqW7muV01QYkQJ2QMrWhMOs0clUbYVdP7FOOeYFTj
         jew/6KtM/oyy3AaK5uxXeiR6g8DEEL+xBIHHv4KoeswubRupxHcWvw8H1yd3+mt4Ga6e
         b2Zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737538451; x=1738143251;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5QIsBAwP8k3rVSff01/p1/7nWWbCnzWPU+0ZOSqzIlU=;
        b=WJLA4kshwGFPQ8CUzaII3RJJmeRtAwHQy1i9sq6MiazbAP3gT39zZIekWccnyv1/2t
         wifHLwgCyCBcj0I1Ad2Q2gpEFahGODrCSnjFztCVaELgyIqo9u+o3rQb6qnRmMyiwq76
         t0+knZ+IwC4pYzK2zHy9Jrbn/iMKrk5mNnLBfVVJ1rFadpQP3tRhOVY4sKdBdDihjyhz
         rpvXwp/eICPUJTIri1CDin3cEzhF4Rq08m/7jPdSXhlejOE12fHC/Q8J3396IAtOY51e
         Ay6g4pds5WuryYu+c6to3SpGLRPq7BE0NwNBbDxT//VsBEaLpbbq4qXncT77hPMjllEF
         K9zw==
X-Gm-Message-State: AOJu0YxxxeaZfrkRSZIwzmrIRRGmz1g03qO2bTB8AXMkzRu7WTb9Svg3
	veikeVZuJsyRQf1fVHQawrgMlAUjMdLMlrWigUqIaLqfgKL3vhLEm76I4KPQl9klQvAC16UNdsm
	x/PLdiw4AVjt0NRf2H/yQ1be+Hm0PMw==
X-Gm-Gg: ASbGncv8bfmmNxUxMA+8Z+nki6ZCBYwWGZSIK1PyQzfarpMfY87oldKAl5s0mMFUZXr
	ueAIOTb2ctzhLA/k3Fmvam9x+dRobyPsY6OQfRUGNkzfH5b+C2hDA
X-Google-Smtp-Source: AGHT+IE1BW3bXlBCaaFaJcoTYFvp1+Y8ocVvyW8JelStjrfP0+Sb6k6lXe6D7tokuyixq2EfztLBysLLyXXpcFmwBps=
X-Received: by 2002:a17:907:3685:b0:ab2:c0b0:3109 with SMTP id
 a640c23a62f3a-ab36e4069c4mr2112523466b.21.1737538450730; Wed, 22 Jan 2025
 01:34:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5mscBfMimoxO8yYQAB1SEdDhdjpwQxkw-45+tWL5tcsqZQ@mail.gmail.com>
In-Reply-To: <CAH2r5mscBfMimoxO8yYQAB1SEdDhdjpwQxkw-45+tWL5tcsqZQ@mail.gmail.com>
From: Shyam Prasad N <nspmangalore@gmail.com>
Date: Wed, 22 Jan 2025 15:03:59 +0530
X-Gm-Features: AbW1kvY50JvfEFOgxg_KSTL-3Rx_39NSpzkFWzbN0k4Gyld1jC604MSPXsjb6xA
Message-ID: <CANT5p=qqP2MpoG0mUmjaXaFdU81NwFaJGsD00vEjUiPdsLcrYw@mail.gmail.com>
Subject: Re: [PATCH][cifs-utils] avoid using mktemp when updating mtab
To: Steve French <smfrench@gmail.com>
Cc: CIFS <linux-cifs@vger.kernel.org>, 
	samba-technical <samba-technical@lists.samba.org>, Carlos Maiolino <cmaiolino@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 21, 2025 at 6:19=E2=80=AFAM Steve French <smfrench@gmail.com> w=
rote:
>
> Attached patch to  Fix build warning: cifs-utils/mount.cifs.c:1726:
>     warning: the use of `mktemp' is dangerous, better use `mkstemp' or `m=
kdtemp'
>
> Use of mktemp() has been deprecated (e.g. due to security issues with
> symlink races), and instead mkstemp is often recommended.  Change
> the use of mktemp to mkstemp in del_mtab in cifs-utils
>
> Fixes: f46dd7661cfb ("mount.cifs: Properly update mtab during remount")
>
> Opinions? Better way to address it?
>
> --
> Thanks,
>
> Steve

Seems like a reasonable change. RB

--=20
Regards,
Shyam

