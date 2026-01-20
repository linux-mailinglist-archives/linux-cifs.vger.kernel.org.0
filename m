Return-Path: <linux-cifs+bounces-8937-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id KBPGF5pkcGkVXwAAu9opvQ
	(envelope-from <linux-cifs+bounces-8937-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Jan 2026 06:31:06 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 10896518AA
	for <lists+linux-cifs@lfdr.de>; Wed, 21 Jan 2026 06:31:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 7D9266C9143
	for <lists+linux-cifs@lfdr.de>; Tue, 20 Jan 2026 13:15:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C33BB421F08;
	Tue, 20 Jan 2026 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NQvTq4mS"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E37C3F23C8
	for <linux-cifs@vger.kernel.org>; Tue, 20 Jan 2026 13:13:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768914782; cv=none; b=MN+p9NHNXFKj/g5amo+IkWG/vuuTytpZiYE82GwEcvzZ66S5kowXHbQwdr/62i8zldJZ0lnbAJRDu8xetlC8Bzcgga5Urgyw3q6EOH9n0/8auuYY95vlcH7HIZiV2LlZsOSG93suLexL/WG182Odp0gLs4yUWaoNcxoZs2BGVDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768914782; c=relaxed/simple;
	bh=tzEtq0KKqjNS4zyy1FqA0LcZcpoLgcAXtUvv1kBVNsE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ipdodW2n0B+ak3Bh1NZ62zkr4q0WHaWJ0JD5Q3FkpOn0HQv2OdiGgW0hy9VRSoxsF/gCBDtmrB8/yr1kQBBXBTh992/DcqPvxCLIUpogMa5EifmaT0QilaaHpG+ndPCcs55jg/hKkZSg9iVOQx5Nj3Nxv/omMr7/i5dYRMudJBc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NQvTq4mS; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BC1BC19424
	for <linux-cifs@vger.kernel.org>; Tue, 20 Jan 2026 13:13:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1768914782;
	bh=tzEtq0KKqjNS4zyy1FqA0LcZcpoLgcAXtUvv1kBVNsE=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=NQvTq4mS26alwWrwI4xhOL1ERssj3+g+hglUQDDORgSyOgLOWhJ20+UNFLMsFyAAG
	 0c1zRjiBR4LOxPIVMY8qK2AYKLaXpCojP1AMbqbnmvImoVcZHJlB/URR2oTYy9RwVn
	 DUWaqoOetT0GQ+sFTA8KJpbWS9GfTCe7fqnFNQ1usuUHCbquRlXhfSbXyCt703yu6R
	 WNf7K2ueV/M/9f1qyzEyZ44VJuwq+ce3P7ay3s0TLUG8gQEwJrRmxiKRIIM+14b/FB
	 icgHw2W2xsq5PF7xxZKYLrgZIca6LZnuhVI3S02MSHneZOHKHfdkS201ibajDO7xpz
	 qEQKRq+CKRdmQ==
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-658072a4e56so747451a12.0
        for <linux-cifs@vger.kernel.org>; Tue, 20 Jan 2026 05:13:02 -0800 (PST)
X-Gm-Message-State: AOJu0YxXorxb+CizjWLQtg54QIRP0vnbEBmDIqa2KfKArdKgWi9B8mz0
	c+HXQ2nTeHHTGTWD1DvhjWF/MECAqRU+1t9aPqaPz9hyj28yC++h+CrFNdJBuTgXwUXZN9NhrKT
	bqhyFwh6YrJIB9NhG+ivfU7X53hZ3T7E=
X-Received: by 2002:a17:907:2d8c:b0:b87:365d:26b8 with SMTP id
 a640c23a62f3a-b8792f783e1mr1206435066b.35.1768914781032; Tue, 20 Jan 2026
 05:13:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251208154919.934760-1-metze@samba.org> <b5b92cae-d92a-426e-b6ad-fcaa9691b980@samba.org>
In-Reply-To: <b5b92cae-d92a-426e-b6ad-fcaa9691b980@samba.org>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Tue, 20 Jan 2026 22:12:48 +0900
X-Gmail-Original-Message-ID: <CAKYAXd9-BeHe7zU-xo0KZzmvzeba=BMvXOMNZnuW+yeqGcq19g@mail.gmail.com>
X-Gm-Features: AZwV_Qh9CVKbXimtnhH0quoMTgZe0wN1lycT7JouA0RLfhB_wFmkFmEBv-PnM1U
Message-ID: <CAKYAXd9-BeHe7zU-xo0KZzmvzeba=BMvXOMNZnuW+yeqGcq19g@mail.gmail.com>
Subject: Re: [PATCH] smb: server: reset smb_direct_port = SMB_DIRECT_PORT_INFINIBAND
 on init
To: Stefan Metzmacher <metze@samba.org>
Cc: linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, 
	Steve French <smfrench@gmail.com>, Tom Talpey <tom@talpey.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-1.96 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.samba.org,gmail.com,talpey.com];
	DMARC_POLICY_ALLOW(0.00)[kernel.org,quarantine];
	TAGGED_FROM(0.00)[bounces-8937-lists,linux-cifs=lfdr.de];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[linkinjeon@kernel.org,linux-cifs@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	DBL_BLOCKED_OPENRESOLVER(0.00)[mail.gmail.com:mid,ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,samba.org:email,talpey.com:email]
X-Rspamd-Queue-Id: 10896518AA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 2:40=E2=80=AFAM Stefan Metzmacher <metze@samba.org>=
 wrote:
>
> Hi Namjae,
>
> can this be merged? It makes testing between roce and iwarp
> much easier.
Looks ok. Applied it to #ksmbd-for-nex-next.
>
> I have infrastructure to listen on both iwarp and roce
> at the same time, but I haven't written the patches for
> ksmbd.ko to use it. I'll hopefully find the time
> in the next days.
I also hope it will be supported soon.
Thanks!
>
> Thanks!
> metze
>
>
> Am 08.12.25 um 16:49 schrieb Stefan Metzmacher:
> > This allows testing with different devices (iwrap vs. non-iwarp) withou=
t
> > 'rmmod ksmbd && modprobe ksmbd', but instead
> > 'ksmbd.control -s && ksmbd.mountd' is enough.
> >
> > In the long run we want to listen on iwarp and non-iwarp at the same ti=
me,
> > but requires more changes, most likely also in the rdma layer.
> >
> > Cc: Namjae Jeon <linkinjeon@kernel.org>
> > Cc: Steve French <smfrench@gmail.com>
> > Cc: Tom Talpey <tom@talpey.com>
> > Cc: linux-cifs@vger.kernel.org
> > Cc: samba-technical@lists.samba.org
> > Signed-off-by: Stefan Metzmacher <metze@samba.org>
> > ---
> >   fs/smb/server/transport_rdma.c | 1 +
> >   1 file changed, 1 insertion(+)
> >
> > diff --git a/fs/smb/server/transport_rdma.c b/fs/smb/server/transport_r=
dma.c
> > index f585359684d4..05f008ea51cd 100644
> > --- a/fs/smb/server/transport_rdma.c
> > +++ b/fs/smb/server/transport_rdma.c
> > @@ -2708,6 +2708,7 @@ int ksmbd_rdma_init(void)
> >   {
> >       int ret;
> >
> > +     smb_direct_port =3D SMB_DIRECT_PORT_INFINIBAND;
> >       smb_direct_listener.cm_id =3D NULL;
> >
> >       ret =3D ib_register_client(&smb_direct_ib_client);
>

