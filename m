Return-Path: <linux-cifs+bounces-10034-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id j9EvA8l3p2kshwAAu9opvQ
	(envelope-from <linux-cifs+bounces-10034-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Wed, 04 Mar 2026 01:07:37 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E7DA1F8B3D
	for <lists+linux-cifs@lfdr.de>; Wed, 04 Mar 2026 01:07:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id E656E3004DD6
	for <lists+linux-cifs@lfdr.de>; Wed,  4 Mar 2026 00:07:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8847D178372;
	Wed,  4 Mar 2026 00:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="dHPRhmwa"
X-Original-To: linux-cifs@vger.kernel.org
Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C6F21D590
	for <linux-cifs@vger.kernel.org>; Wed,  4 Mar 2026 00:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772582853; cv=none; b=qK82GWlz5TjZ8b252S1eUiInLHAo5Eri9Rd0u/GYmAbJeNJa5HZ709SG85awTSXrGdxAvuHsmr1IHdgY8cXodfFbhcsmB+b/uGelNlFXnJlobrfs5WPIfzw/HvdzUO94PFn4ulmns7oocQU4O97RiT0+4ybGyRE5VSanNxB1XoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772582853; c=relaxed/simple;
	bh=kvgWr9/LLaAlM/9Kwbk6u2fxtFoT6o/IiJwQXTBt2IQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oKwkL6H+dJm6WTGKZEhXp5z53MvfyogUPuA/fWYXf1OxMBGfPf/48lU9Q1FfmAup0p6xr4dksyETdLAEnERxQ2wbt65osDXvkzeYE/Kv2a6WdodhsPlZCKjsolxMdP3QjCkaN0agL5OaDth4pmD0uYVRVOc2P2Pt/Mpi2MS/Bzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=dHPRhmwa; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Message-ID: <e3b7e66b-1a03-49bb-8fd7-a1ca5ea4c0f1@linux.dev>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1772582848;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kvgWr9/LLaAlM/9Kwbk6u2fxtFoT6o/IiJwQXTBt2IQ=;
	b=dHPRhmwa0+u13hvvwoqiM57kjJ7KARRrB9mfxRAPIkbIW359UVukSkhefh1uEHMN8S8za9
	CS4Pk28rYyAgW8lBVJlWKIoQYK9lgTHbZeP3ZFNDenXD2aGcL3k69+aJXyCsQ01jiwmigQ
	61sTkChRgESa0lKByZ4rNEoouOw+VJk=
Date: Wed, 4 Mar 2026 08:07:08 +0800
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v5 1/7] smb/client: fix buffer size for smb311_posix_qinfo
 in smb2_compound_op()
To: Steve French <smfrench@gmail.com>
Cc: linkinjeon@kernel.org, pc@manguebit.org, ronniesahlberg@gmail.com,
 sprasad@microsoft.com, tom@talpey.com, bharathsm@microsoft.com,
 senozhatsky@chromium.org, dhowells@redhat.com, chenxiaosong@kylinos.cn,
 chenxiaosong@chenxiaosong.com, linux-cifs@vger.kernel.org
References: <20260303151317.136332-1-zhang.guodong@linux.dev>
 <20260303151317.136332-2-zhang.guodong@linux.dev>
 <CAH2r5msFB7KBUMmfwq7HwpF7+WLOySGhhfQm93OwZLWTmp1a9Q@mail.gmail.com>
Content-Language: en-US
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From: ZhangGuoDong <zhang.guodong@linux.dev>
In-Reply-To: <CAH2r5msFB7KBUMmfwq7HwpF7+WLOySGhhfQm93OwZLWTmp1a9Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Migadu-Flow: FLOW_OUT
X-Rspamd-Queue-Id: 5E7DA1F8B3D
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[linux.dev,none];
	R_DKIM_ALLOW(-0.20)[linux.dev:s=key1];
	R_SPF_ALLOW(-0.20)[+ip4:172.232.135.74:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-10034-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	FREEMAIL_CC(0.00)[kernel.org,manguebit.org,gmail.com,microsoft.com,talpey.com,chromium.org,redhat.com,kylinos.cn,chenxiaosong.com,vger.kernel.org];
	RCPT_COUNT_TWELVE(0.00)[12];
	RCVD_COUNT_THREE(0.00)[3];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-0.998];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[zhang.guodong@linux.dev,linux-cifs@vger.kernel.org];
	DKIM_TRACE(0.00)[linux.dev:+];
	MID_RHS_MATCH_FROM(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.232.128.0/19, country:SG];
	TAGGED_RCPT(0.00)[linux-cifs];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sto.lore.kernel.org:rdns,sto.lore.kernel.org:helo,linux.dev:dkim,linux.dev:mid]
X-Rspamd-Action: no action

I will try to test it, but this is a very obvious bug.

On 2026/3/4 07:58, Steve French wrote:
> Good catch - were you able to repro a crash or other bug when running
> without the patch?

