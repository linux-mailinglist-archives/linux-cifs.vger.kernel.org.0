Return-Path: <linux-cifs+bounces-9283-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +KBoHGcGhmkRJQQAu9opvQ
	(envelope-from <linux-cifs+bounces-9283-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Fri, 06 Feb 2026 16:19:03 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD12FFA37
	for <lists+linux-cifs@lfdr.de>; Fri, 06 Feb 2026 16:19:02 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 520C13035A85
	for <lists+linux-cifs@lfdr.de>; Fri,  6 Feb 2026 15:13:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 132C128151C;
	Fri,  6 Feb 2026 15:13:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O6xWP7GZ"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E502927E07E
	for <linux-cifs@vger.kernel.org>; Fri,  6 Feb 2026 15:13:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770390802; cv=none; b=i9Fcr4DiMV87gQ6iTJbOBZ9I4X1KHsBwdlhU1KWoqHPCLkAX1o/SDzh1C0xqwotwqdAnVwV7zMZn+EnyR71jqpaMRlyCtTUAkJgAADfVDJ+ypQYFkKfk5XjBu252kYRfr3qTqHh2ilAhFPqXs3BjOp08H6/4iw6M4EUe4a0FsKk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770390802; c=relaxed/simple;
	bh=v5WsSDr2tQsBS6gRjKq1ZuVHOejbvcA+jUUZFzBkAh8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=bBSwMmsac9z/zkuWZKcmmBjnZcsT0tvU+K+g8vlPboHdBxNCbXv1VPD5rGfuVQuRVmgo2dEpRHxbHe9gxgNhyBlIXiOFKuxPCY2auodqNRKhvLZjWeydSJ+gtfC7IZF+qREG0UhcXw6Z7UfeGHO/Q7bnec2rVm3j0E8t4nlvTUs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O6xWP7GZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8FAD0C19422
	for <linux-cifs@vger.kernel.org>; Fri,  6 Feb 2026 15:13:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770390801;
	bh=v5WsSDr2tQsBS6gRjKq1ZuVHOejbvcA+jUUZFzBkAh8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=O6xWP7GZ5Yb6CxXDx2Hf0YMaSJQsvOG+XH7jYb5G27toJapP7F+YIt5qWGIlSvO6I
	 Sv+Jt3ABzzPU6BX3Hzj+Uu7sDR5TGuuj1TpVgbBomSAahFlxCqmedpAojwnhixiJBc
	 +bWVptgvzjYMzC0YEBszKp9Clz1neKjHhPbHDXZos/5oRCJpXFTeG3c88YJ4PAshce
	 tkW3eprDMnlIXBMUorGPJ2tu6UbihfF9X93Ya88UARNAkJQNxFMp3pFF6v0CU9rAwZ
	 srBFZyeZOBKNcx1fVMvubhijgJtNj7Bn6orPL/tAgFQLzusKBPUoY0S6ei8QwfgsSE
	 u8mWp7eUtdL2A==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-b8850aa5b56so386485266b.2
        for <linux-cifs@vger.kernel.org>; Fri, 06 Feb 2026 07:13:21 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCXT99ygu1pM3lQbIbThiUcNQhqZmGFZyVrsynUgbWH0PO0IKfPSA3z5DYxrxUwOTRvnIZQ0qhcMmrUR@vger.kernel.org
X-Gm-Message-State: AOJu0YzdvupaI+KXvB70EYV90rNQbqyVRFOaSJ2j7nKmXYpCoyUx8aFV
	gPflahDUn8LHa1UlK96jpKR2HyPxx7uUsvD0HhtXBSdYIg9Jmpe9Ju5J/rRKDKVs44tzLFhmZzL
	2l6WRtJylR2UhDh0nrheKlBzWsu4+uWw=
X-Received: by 2002:a17:906:f58b:b0:b8d:bf4d:7458 with SMTP id
 a640c23a62f3a-b8edf1ea7c4mr170888366b.24.1770390800136; Fri, 06 Feb 2026
 07:13:20 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1770311507.git.metze@samba.org>
In-Reply-To: <cover.1770311507.git.metze@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sat, 7 Feb 2026 00:13:08 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8JgWAM-zc5CdNeuHOsKaBYKPp9NQBd9=Z8G-RNOLm9VA@mail.gmail.com>
X-Gm-Features: AZwV_QjkO1J194Rkd9CCx2iguM3WblIOsNq5A4KXpPbfuqLTBvErm-_7ID82bno
Message-ID: <CAKYAXd8JgWAM-zc5CdNeuHOsKaBYKPp9NQBd9=Z8G-RNOLm9VA@mail.gmail.com>
Subject: Re: [PATCH v5 000/144] smb: smbdirect/client/server: moving to common
 functions and smbdirect.ko
To: Stefan Metzmacher <metze@samba.org>
Cc: Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>, Long Li <longli@microsoft.com>, 
	David Howells <dhowells@redhat.com>, Paulo Alcantara <pc@manguebit.org>, linux-cifs@vger.kernel.org, 
	samba-technical@lists.samba.org
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FREEMAIL_CC(0.00)[gmail.com,talpey.com,microsoft.com,redhat.com,manguebit.org,vger.kernel.org,lists.samba.org];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-9283-lists,linux-cifs=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-cifs@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-cifs];
	RCPT_COUNT_SEVEN(0.00)[8];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: DBD12FFA37
X-Rspamd-Action: no action

> Namjae, can you please test in your setup?
There are no issues in my testing, but since there are a lot of
patches in this series, I need a few more days to review them.
Thanks.

