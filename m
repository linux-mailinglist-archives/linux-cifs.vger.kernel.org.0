Return-Path: <linux-cifs+bounces-9067-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id UAhzNF8fcmmPdQAAu9opvQ
	(envelope-from <linux-cifs+bounces-9067-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 14:00:15 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 378E966F73
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 14:00:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 2B7EE94AD42
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Jan 2026 12:49:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0BB722D130C;
	Thu, 22 Jan 2026 12:48:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="twAWxbOn"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CADE21F4611
	for <linux-cifs@vger.kernel.org>; Thu, 22 Jan 2026 12:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769086129; cv=none; b=CHVMHxBlhrWdBIjEGma0raHSJyeRLGZ7pGaQXxvrIC6gHhy7yhg2GYeZ+FNBwYMm+mFr+mhdAqCXQPNrwffI9yBMdoJvVOPnXhjDJb0aihY7Lw7cj/qp/4K4iUmaUBw1FvF+H5XXquXbXlELeS9AWKFuuXHAU5i707IK32DW7Mw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769086129; c=relaxed/simple;
	bh=t+X5JxZFnn197++2RdAD/gAoPaYFp00R1tv3iwBbWtE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H86U167Nm26okonN7PLQLxz6Vjv6EJTdN9sxUFbWTD+0fSoaY8UbPzFf/qdzZw1+Tj8E8nSlNXGjOf6BhZbxW+qbr0OjSp6ImDLQF7mVcPysYwMmA+gkXk6KFx+IZdunHvjonVsPzqHbziLKpkXNrO9d4gNj1eOItVdKCRN1QSI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=twAWxbOn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 576F2C19423
	for <linux-cifs@vger.kernel.org>; Thu, 22 Jan 2026 12:48:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1769086127;
	bh=t+X5JxZFnn197++2RdAD/gAoPaYFp00R1tv3iwBbWtE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=twAWxbOnBNyeVmJs/5VRbhXFoiR+OEKgTJv029Izdk3Ker238es2Ch6vLuyYIkRyx
	 pZDAjMn+JrbWJul0z/fn/Kf2OYd6NeE20BIO7nDyUS65M2qiOAevnxRSho5vizyX7G
	 zapQHend4aTCA0KlUwXMJ9/IZ5rEBNXwxiWy+2t73O8ip9wmPrW2LUuo86g23L7/RY
	 yNUkgFhHOBLqRTmNh7eZixUR1gfMRrjcC2RU2BfqSLlly+/sRlQ8IZp6zyrQnc2xkq
	 /Gk+HLGLHO+yU4XzEzAeOpufkJtTUcOSKD476/l10PNxaD75ASWkTLrSKCRo2ySxf6
	 wJeUUczv8Qj3g==
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-65814266b08so1769221a12.3
        for <linux-cifs@vger.kernel.org>; Thu, 22 Jan 2026 04:48:47 -0800 (PST)
X-Gm-Message-State: AOJu0YxdpTBd8ru+1GkixGRkhT9128CGbajXvA8k/aEGOWjw33H7KPie
	eem+ixAL0UVNA6KCkDywRm99XFCGG2wmPi1fp0SAoqW+eD1XfKER0zM/KroVAyDyPeYkotH84+6
	CHyq+kjLh+g4Os2Px/mWkdhMzu7j33Mg=
X-Received: by 2002:a05:6402:5253:b0:64d:170:7976 with SMTP id
 4fb4d7f45d1cf-65452acdaf8mr15741667a12.16.1769086125980; Thu, 22 Jan 2026
 04:48:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1769024269.git.metze@samba.org> <62cddd343ea2a283c1a6983cdfaaff25d13a5538.1769024269.git.metze@samba.org>
In-Reply-To: <62cddd343ea2a283c1a6983cdfaaff25d13a5538.1769024269.git.metze@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Thu, 22 Jan 2026 21:48:34 +0900
X-Gmail-Original-Message-ID: <CAKYAXd93CMxXMdXM+Dzxt5jVg=iFRTexQRGrHxkt1LubYi2c9w@mail.gmail.com>
X-Gm-Features: AZwV_QhOcLxOmVrAb4QbgTVkv1jRzG2F9NSajGQoiIw8bYfKJTZKbEYWuiXb_rs
Message-ID: <CAKYAXd93CMxXMdXM+Dzxt5jVg=iFRTexQRGrHxkt1LubYi2c9w@mail.gmail.com>
Subject: Re: [PATCH 07/19] smb: server: let send_done handle a completion
 without IB_SEND_SIGNALED
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>
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
	TAGGED_FROM(0.00)[bounces-9067-lists,linux-cifs=lfdr.de];
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
	RCPT_COUNT_FIVE(0.00)[5];
	TAGGED_RCPT(0.00)[linux-cifs];
	ARC_ALLOW(0.00)[subspace.kernel.org:s=arc-20240116:i=1];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:7979, ipnet:142.0.200.0/24, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[talpey.com:email,dfw.mirrors.kernel.org:helo,dfw.mirrors.kernel.org:rdns,mail.gmail.com:mid,samba.org:email]
X-Rspamd-Queue-Id: 378E966F73
X-Rspamd-Action: add header
X-Spam: Yes

On Thu, Jan 22, 2026 at 4:51=E2=80=AFAM Stefan Metzmacher <metze@samba.org>=
 wrote:
>
> With smbdirect_send_batch processing we likely have requests without
> IB_SEND_SIGNALED, which will be destroyed in the final request
> that has IB_SEND_SIGNALED set.
>
> If the connection is broken all requests are signaled
> even without explicit IB_SEND_SIGNALED.
>
> Cc: Namjae Jeon <linkinjeon@kernel.org>
> Cc: Steve French <smfrench@gmail.com>
> Cc: Tom Talpey <tom@talpey.com>
> Cc: linux-cifs@vger.kernel.org
> Cc: samba-technical@lists.samba.org
> Signed-off-by: Stefan Metzmacher <metze@samba.org>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>
Thanks!

