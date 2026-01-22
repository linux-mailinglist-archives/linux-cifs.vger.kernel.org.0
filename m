Return-Path: <linux-cifs+bounces-9062-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SEu4EywdcmmPdQAAu9opvQ
	(envelope-from <linux-cifs+bounces-9062-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 13:50:52 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2B666DC1
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 13:50:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id A0FCB6C8C50
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 12:33:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2305732BF26;
	Thu, 22 Jan 2026 12:32:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pYtj0f79"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1CE93164C2
	for <linux-cifs@vger.kernel.org>; Thu, 22 Jan 2026 12:32:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769085173; cv=none; b=uFM1ctCqlzxVSqupmvFVNglb4ztpaORiIwb2P/ep+2xTH70wrhUaiV2nn8PQb1T52mY6M7zVWGKxWn/jBPjFb5NPdASILLH2DY0XPzk/eDm1J0v8S77+nHThy8HvcP6VXSrgarLjznfw0+WTW/5YaOeS22yRE72q2/WWhYbJP2M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769085173; c=relaxed/simple;
	bh=9fPWMKy7hSQvEilxkcNEyPtXnQNOMCjs4n/ncRl0JNc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nLabGBN97DTSgSbQNU4+FgeEtJbh68am+cFuoZ6Chp+ctbdqpWDZ0SFODykydyy5lmeWmJ67oE7oh7ftYhrR9JtSyXdhKKcUTCQsc2IKtjRXLQHrH4DR+Aufh1gBadKUrHeZ0PNZ7pzLZvlRj3uFbwckqgiQ+G4jR3PlOAh++2o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pYtj0f79; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACF0BC4AF09
	for <linux-cifs@vger.kernel.org>; Thu, 22 Jan 2026 12:32:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769085172;
	bh=9fPWMKy7hSQvEilxkcNEyPtXnQNOMCjs4n/ncRl0JNc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=pYtj0f79MVJ8tQj52sqT581tMA/i9U+Y67Wdvmv23DGa5vnHTqW275K77E1t6/CGS
	 +Jt7krCIKzUU8RLw5x75tzzYc6w2UrZE+tRzD6UcPZa4iSTynBSiTApVGdnwvMVRhD
	 umFnC9bz5CBl5dUjJEqw9SFNXP9YZf7GawadmWHvtglDRhkyl3v9ZfDdSsPDYwJCsA
	 GzYssdaZu313XAGfu9gfnENLuDOoSMC2f1GfoLUQ8K/MU4bRiWT7cxiS0BuBZI4Amd
	 7myrum3w/fvJSKPSb/bxZ9gSRsBQLWX+iy1Z/ZnB9NHXfQ49ta2T/fwqJViIVxckmq
	 7/Ive3Joc8+6g==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-658034ce0e3so1684336a12.3
        for <linux-cifs@vger.kernel.org>; Thu, 22 Jan 2026 04:32:52 -0800 (PST)
X-Gm-Message-State: AOJu0YyEV2J8P/YuE+81ocrq4fYrWW+bc+6mrV7p7TkBcNLHuDrsIZ5U
	I7MxZMzjZmlkv+JLUmezAyxftoo2tQF8Kp28UPJ/ds4HtJdsm0MUw3kwbvF6mryzRMqNzBk1Fs7
	aa2671hfzrS4U7ZQL22mSqJbZyj2yxIY=
X-Received: by 2002:a05:6402:43cc:b0:658:11c3:421e with SMTP id
 4fb4d7f45d1cf-65811c346d0mr4916788a12.12.1769085171299; Thu, 22 Jan 2026
 04:32:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769024269.git.metze@samba.org> <b7a30840f1b912a924b700c3eb01f1e36e88b7ec.1769024269.git.metze@samba.org>
In-Reply-To: <b7a30840f1b912a924b700c3eb01f1e36e88b7ec.1769024269.git.metze@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 22 Jan 2026 21:32:39 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_v0AwyKBd77iyK6VBzWbe1h3gpcjBLFp_OTh7dkTdQMg@mail.gmail.com>
X-Gm-Features: AZwV_Qg7HSlQ58x-dL2uTe6q4c1AlokAAiacFBfwek0EK8c5rb6A2_QqU57naBU
Message-ID: <CAKYAXd_v0AwyKBd77iyK6VBzWbe1h3gpcjBLFp_OTh7dkTdQMg@mail.gmail.com>
Subject: Re: [PATCH 02/19] smb: smbdirect: introduce smbdirect_socket.send_io.bcredits.*
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	stable@vger.kernel.org, Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>, 
	Long Li <longli@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.samba.org,gmail.com,talpey.com,microsoft.com];
	TAGGED_FROM(0.00)[bounces-9062-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	FORGED_SENDER_MAILLIST(0.00)[];
	GREYLIST(0.00)[pass,meta];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	MISSING_XM_UA(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-cifs@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	ASN(0.00)[asn:7979, ipnet:213.196.21.0/24, country:US];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talpey.com:email,mail.gmail.com:mid,samba.org:email,ams.mirrors.kernel.org:helo,ams.mirrors.kernel.org:rdns]
X-Rspamd-Queue-Id: DC2B666DC1
X-Rspamd-Action: add header
X-Spam: Yes

On Thu, Jan 22, 2026 at 4:51=E2=80=AFAM Stefan Metzmacher <metze@samba.org>=
 wrote:
>
> It turns out that our code will corrupt the stream of
> reassabled data transfer messages when we trigger an
> immendiate (empty) send.
>
> In order to fix this we'll have a single 'batch' credit per
> connection. And code getting that credit is free to use
> as much messages until remaining_length reaches 0, then
> the batch credit it given back and the next logical send can
> happen.
>
> Cc: <stable@vger.kernel.org> # 6.18.x
> Cc: Steve French <smfrench@gmail.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: Long Li <longli@microsoft.com>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: linux-cifs@vger.kernel.org
> Cc: samba-technical@lists.samba.org
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

