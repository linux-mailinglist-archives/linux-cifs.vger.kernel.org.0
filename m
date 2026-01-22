Return-Path: <linux-cifs+bounces-9064-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UE//M+sdcmmPdQAAu9opvQ
	(envelope-from <linux-cifs+bounces-9064-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 13:54:03 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B12C66E53
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 13:54:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id EFC88927BE3
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 12:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74D932FF161;
	Thu, 22 Jan 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FjaWSKSs"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEA3288513
	for <linux-cifs@vger.kernel.org>; Thu, 22 Jan 2026 12:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769085411; cv=none; b=Nq1DdGHqEPcqj+wKbSIxw71aYA5U6jzqK8weZdC0ecQSg5Z+i+KG1WG0vuDEtbbq7F37ZcuCLIIKKyMsobG1nhzHmFYiiMtQNqOdp2BHf2QSw+rQgi9lJhu6fkya4Yp5A4nF2tH5QZqWnJMGBX+4/DDBkTiIbT7UibQCrTylY7M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769085411; c=relaxed/simple;
	bh=t71HJ0T7TteHu2rjW12sTSo9aXhFK1RhbfygAcXviVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Qr6xxoxRU5DDFQeVunT3ARnoLUD35ItdBsCUfLdrjJTWcx9M62/t2Tfbvl8mtKve8dmnV1MtNxycPRW43qivf01YhbeEYuWB6tYHjfB4Itmj0zbec3tMX1eh/N0Hp5k2vYk+87qBxbmWuboyQ1GJLtYu/SdNhHncWdxkQztfLdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FjaWSKSs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 002F9C19422
	for <linux-cifs@vger.kernel.org>; Thu, 22 Jan 2026 12:36:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769085411;
	bh=t71HJ0T7TteHu2rjW12sTSo9aXhFK1RhbfygAcXviVk=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=FjaWSKSsjPGg6g9lTKHjHFydAVXRuJuh97jW1U80cfEYRwtkmN9/TwtWaoNcXUmUM
	 h2BdD8XCQbUjhjuhWnBD3gyyS8ek53pvyyt+8T1QMJBj6x+UitdUBBFDe9lAHnaoo4
	 9oXiE1PLgkP/oqOSh5qaGF+yBNc2E4IDyrrDqbYEy8LKJKq8+CIJNb+qb0w74WbDAD
	 ygfZsdf+wmKkPW9v6TaS6T/3yKf/XFcjJF9GD9hLbXJQQkT/CBJA4gJfUV7dEN5Pru
	 i7EdJLcpiK95Fv5/naOKq+z8fuxUZ1W7GNnLjFzZShC7XDje3ICIzSTqs9vxqObkAm
	 VQL1/qxvd5GLg==
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-64d02c01865so1438657a12.1
        for <linux-cifs@vger.kernel.org>; Thu, 22 Jan 2026 04:36:50 -0800 (PST)
X-Gm-Message-State: AOJu0Yz5+qKbF1/S/5d6AbSZixrwQ1EuWEPdgpSsyZwvlgb+AvVRYH/k
	wvQUlNZ4PFgYQ3nXdD29JyhEFGAkZ4gaW3mrJ/VHwKq5Rgkq6kVuVkWpEA+uThwOkh4D7opJ/Zt
	WItU42N2gHspeSjqDgVEMnU+KuAuFCUM=
X-Received: by 2002:a05:6402:524e:b0:658:eb3:2031 with SMTP id
 4fb4d7f45d1cf-6580eb322c9mr4621996a12.27.1769085409568; Thu, 22 Jan 2026
 04:36:49 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769024269.git.metze@samba.org> <9c7db488c53721cae463a856b318bdf3fcb0bf39.1769024269.git.metze@samba.org>
In-Reply-To: <9c7db488c53721cae463a856b318bdf3fcb0bf39.1769024269.git.metze@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 22 Jan 2026 21:36:37 +0900
X-Gmail-Original-Message-ID: <CAKYAXd_9f_xfp4HkOOsz+7CcRRzu9QNzRQa_TuCf9bEyUSvm1A@mail.gmail.com>
X-Gm-Features: AZwV_QhZZpmoFMEDQU_C8hWFndHe_sSrvdP8IKT-wnpmAs4Ty423xO0gqORj84A
Message-ID: <CAKYAXd_9f_xfp4HkOOsz+7CcRRzu9QNzRQa_TuCf9bEyUSvm1A@mail.gmail.com>
Subject: Re: [PATCH 04/19] smb: server: let recv_done() queue a refill when
 the peer is low on credits
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	stable@vger.kernel.org, Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [7.34 / 15.00];
	URIBL_BLACK(7.50)[talpey.com:email];
	MAILLIST(-0.15)[generic];
	BAD_REP_POLICIES(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.samba.org,gmail.com,talpey.com];
	R_DKIM_ALLOW(0.00)[kernel.org:s=k20201202];
	TAGGED_FROM(0.00)[bounces-9064-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	GREYLIST(0.00)[pass,meta];
	TO_DN_SOME(0.00)[];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DMARC_POLICY_ALLOW_WITH_FAILURES(0.00)[];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-cifs@vger.kernel.org];
	RCPT_COUNT_FIVE(0.00)[6];
	TAGGED_RCPT(0.00)[linux-cifs];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talpey.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,samba.org:email,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 4B12C66E53
X-Rspamd-Action: add header
X-Spam: Yes

On Thu, Jan 22, 2026 at 4:51=E2=80=AFAM Stefan Metzmacher <metze@samba.org>=
 wrote:
>
> In captures I saw that Windows was granting 191 credits in a batch
> when its peer posted a lot of messages. We are asking for a
> credit target of 255 and 191 is 252*3/4.
>
> So we also use that logic in order to fill the
> recv buffers available to the peer.
>
> Fixes: a7eef6144c97 ("smb: server: queue post_recv_credits_work in put_re=
cvmsg() and avoid count_avail_recvmsg")
> Cc: <stable@vger.kernel.org> # 6.18.x
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Steve French <smfrench@gmail.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: linux-cifs@vger.kernel.org
> Cc: samba-technical@lists.samba.org
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

