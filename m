Return-Path: <linux-cifs+bounces-7998-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F2552C8AD0E
	for <lists+linux-cifs@lfdr.de>; Wed, 26 Nov 2025 17:06:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D954A3A190C
	for <lists+linux-cifs@lfdr.de>; Wed, 26 Nov 2025 16:02:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7F829191F84;
	Wed, 26 Nov 2025 16:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b="7rt9mciT"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mx1.manguebit.org (mx1.manguebit.org [143.255.12.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B185331A6C
	for <linux-cifs@vger.kernel.org>; Wed, 26 Nov 2025 16:02:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=143.255.12.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764172931; cv=none; b=Zm4nVrdnXxl5hXHTuZrefh53R49qFi9C0A3IfY/XL4b4o6eXB5qV9nLH5OMFBR8pW6koWWBULaPBC2OJmrtVRHgfl1+nSbiAiaPYUMUIEQv00WTXWOcFHrT2Y3fHC97c6GSDEGRwt2D48tZGEuoEoPkj77g7lX26zuYUDD+JPuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764172931; c=relaxed/simple;
	bh=dYfPGEUU5MMDf41Kk6G2jRT49jwR9QiKqVhSnOYdn+M=;
	h=Message-ID:From:To:Cc:Subject:In-Reply-To:References:Date:
	 MIME-Version:Content-Type; b=aN5A6w2Pt1z3TUIQy+/vHt1Knvxi25xXovBwTNh1b+/6nEhcq03/iAX4HGFbVGWwbV+U3Qer1PHsfjHDfe+i2tJkZwRv3AoOgqU1MA7fN6qb43YZ8PIU4QxMgiv0XF4xJUnZDTlQ39i9bOleFDULtCEpbrsp4D6ORr6g7KgTCEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org; spf=pass smtp.mailfrom=manguebit.org; dkim=pass (2048-bit key) header.d=manguebit.org header.i=@manguebit.org header.b=7rt9mciT; arc=none smtp.client-ip=143.255.12.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=manguebit.org; s=dkim; h=Content-Type:MIME-Version:Date:References:
	In-Reply-To:Subject:Cc:To:From:Message-ID:Sender:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description;
	bh=dYfPGEUU5MMDf41Kk6G2jRT49jwR9QiKqVhSnOYdn+M=; b=7rt9mciTDm/gRg4gPIo7St5kEK
	pJIY2F/Ckl0bhR7tzUdduvR963/QfH0A3seCfJNrX69xgk3pf90/WxbLT8hwV5MstGHP2JaAN+p6N
	sTS+RFAjsogqbS3j1Un3p4IRqrN9s4wdJc0GCnnUtyIhV5pwh93I8EifhWGlXvXcjSvMFtuJcpyCO
	Do1WLW1NhmEue9BFr2uRUSYNZnYmjWlViLCDvEdyYOKmTD7Wm1DP3RAK9Mkpm6/TicDgl0mHJyOxs
	LMKA984CPK3BDpctUB1cspPrXH5fVteivvLZrCqEFkHamunfUKRDMWg7isi1eI/DL0mU6gseF7N2U
	OWFiFY7g==;
Received: from pc by mx1.manguebit.org with local (Exim 4.98.2)
	id 1vOHy0-00000000Xjq-2VbI;
	Wed, 26 Nov 2025 13:02:05 -0300
Message-ID: <615273d4ee88f4414d859e3e06d2afdd@manguebit.org>
From: Paulo Alcantara <pc@manguebit.org>
To: Steve French <smfrench@gmail.com>
Cc: piastryyy@gmail.com, Xiaoli Feng <xifeng@redhat.com>, Jay Shin
 <jaeshin@redhat.com>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH] cifscreds: fix parsing of commands and parameters
In-Reply-To: <CAH2r5mutuLO4s6azh8g7D6Xs286mW_NyptEkF_6X3Uy4kY=FBw@mail.gmail.com>
References: <20251125195541.1701938-1-pc@manguebit.org>
 <CAH2r5mutuLO4s6azh8g7D6Xs286mW_NyptEkF_6X3Uy4kY=FBw@mail.gmail.com>
Date: Wed, 26 Nov 2025 13:02:05 -0300
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Steve French <smfrench@gmail.com> writes:

> added to cifs-utils for-next
>
> Do you know if this is a regression of cifs-utils and if so what release/when?

It is regression introduced in cifs-utils-7.2.

