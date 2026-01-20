Return-Path: <linux-cifs+bounces-8972-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id wMgwN0/1b2m+UQAAu9opvQ
	(envelope-from <linux-cifs+bounces-8972-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Tue, 20 Jan 2026 22:36:15 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A17B4C5C8
	for <lists+linux-cifs@lfdr.de>; Tue, 20 Jan 2026 22:36:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 744A28CC0C7
	for <lists+linux-cifs@lfdr.de>; Tue, 20 Jan 2026 21:07:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB8813B9612;
	Tue, 20 Jan 2026 21:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kKEZgNbP"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5680C3A641E
	for <linux-cifs@vger.kernel.org>; Tue, 20 Jan 2026 21:07:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.210.176
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768943229; cv=pass; b=QXJLN1qKLcuj9kA4b2wnzBuzkq6ull6SjXr/lfCT2oDA3WGzsiPhmOO4/RbJLAYu9bZ8U6K/wvxnHqH4tuuRjyhdFETVNKgVGEGgioPO2MxR7EeRiLDbSA4ujujpD3J+YNn9cHvJ4LpDi40rFgNMY8XHcuCyvKgMBDjoFD7yCQs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768943229; c=relaxed/simple;
	bh=iOhVl2p7IvLcwoAOJZtY5j6TNwfE1GKs3DXwErOn2IA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ZDRcdfHEEO/LH2rUGqpcJK/w+xCJ4wvoUB1YNOJhDAv84IWsjsAND741KzExqpk6/qAdGBKjZFhCx4uMaYB2UArmeJrU/rYrZk2VQdQMXp4iQDw3mkyxYOr+kiyfxnLORwDASS2GrlpocrxXdHj/drdXkRwAOBMV07TT+xGRmE0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kKEZgNbP; arc=pass smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-7f216280242so93576b3a.1
        for <linux-cifs@vger.kernel.org>; Tue, 20 Jan 2026 13:07:05 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1768943225; cv=none;
        d=google.com; s=arc-20240605;
        b=VsgLp7VheMtvNsGegmlhSb2niyT2d7SaFz6oFGbVf1Tz2rP2dIwlyo2UVm+pUzFb04
         zN8fnKcJVIK9b915WJuSwxyg7q9afeB34xd9aJv2jAQOBlW0mAIcZ79ymKdsqjZ5fPHm
         UY1EGZCoGqWKpFtOQNGq/U2dWCqwxs+2VVVkF3DNqHoJdGsQMKmSFRoPw+ifi7WJRN/1
         R+mpFCNOPbDeBlX1Eg0ZU6hpuG+GMvlss0uRsDjzIpJofIFHNScGtV1viGkBKKadfyec
         QNeAR2Op914BatqHOBltTy8KlqvMj8xG727P++mzpQ2iRU0LIhKlxrha6WEa9BYda9Xo
         XwJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=jCJeW3GJ/JJ5bqM+NSKjsXir49GDnjGF+idw2elGnxk=;
        fh=eUP1fmGy+oMogg75QCs5ppyUMH3sUu5JQgj4PbSk6mk=;
        b=X79uiwtPzTP8S6ctl7798ENhln/NxipUM5qJA2ShzpK3ZqArSZfKE78BYEncjc8RFj
         oZOk+RAeipWTOZNlthl8zcYo51gsD+qK1E7WMxldgmzI+QssEYBivEhIHzJq2fKH57uX
         ro2tMBMUghLgCjxUCZE1BP+tjzeZiw7Y4NLtiyfDDkfD9dKvgHWtduPQj5xtp9ler8ri
         taFlxpg7jhYvdvIgBLwRP1AJKdxztjyzsfsFBwiQYph/csP4DCcuya22jen22akXBRub
         7+WhoW+ZR5DIUxIhiIlCgmbR6bB/OBhzVoB0h+SGqB3x347HvJGq3QtfZIer96QWo2If
         4EQA==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768943225; x=1769548025; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jCJeW3GJ/JJ5bqM+NSKjsXir49GDnjGF+idw2elGnxk=;
        b=kKEZgNbPCUoHZ7b8WwANXIrLpMLAkKWZ6vFlOaCpQQ4wjMIR01Bpsmg6BlDf9anKmq
         svue+XKj7AOQCOeiJoPEGJ3IwOgTgSacJigzhZW5SD99ejSOaNvww7/C5CxrvhR3Zido
         gf7NJFszPHRJAdpSuVW9NS8KAgE8O/deUjGTAta3Xaj3Bp1KaPMLZZSNYdiYDwx064AY
         /GTj5QRnMflSB4BjB8/xPSqahF3ej6Zjd1sF3+80cD0FiWOTB6Z3FGdKQ5UOfKO0vfGO
         k/lNeuX9O8evdcu/HU1gIaPv2aMP/8AzTlRREJGT6lIIhl1D5TBmzhh8+zmdfXB6tT6t
         B6Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768943225; x=1769548025;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=jCJeW3GJ/JJ5bqM+NSKjsXir49GDnjGF+idw2elGnxk=;
        b=kyZwLbayocrqhuAxqIcEcWLTHKiVO+q3hueyQ7N04cjxjbqAFe3+UDsnxp7jL3UZTA
         tDTLmXck/WpSYUHR98pxN8yge5vPqAn+auP0pct8xnVaLb8B40eNxxfcUxWiKM1Jr5/M
         Wh2vWDoxcUrWG/fVKMyMKsy1vBh6sUlsi/muQGWmZ7Y+tKYRm3wSn+TncE54Y/0hjjKN
         hDQ/duCvp/l+wkYzK4h1aUZ4nnVktnuqRtUyH0BuvmXwvZ86gCwwF+sVmCyETHgQhjGA
         hxlpdDIW+mC56YxEp/PSPRQcwgP8633WLhocquPp3nZmNPxMiXmgDPKABynCCUNPjvdl
         aPew==
X-Forwarded-Encrypted: i=1; AJvYcCUuD4lCecMY8NvPibCGCxHxRByDLsgzLF5A3HPWP9lywmkEaqbQJBejOZkfQQm+dLlGQII8wmiD9BBf@vger.kernel.org
X-Gm-Message-State: AOJu0YytyrkCce4g6KvivxaUyKA7zIIAsWiK/41f13iIOn+Q0q99htAw
	BRXwTWdbbHzKbdu5GFVCBHv7CWCGocjCLzRuyoeF+u6xpD+ieFoXsDzS2kUcPCT5cguVwm5MzaW
	00DhwgSMgdthQmBf/WWB4RdD3yWXQaOgkE9nBw9Hzxg==
X-Gm-Gg: AY/fxX4eRq8PiPOGO+W6gik2rb+WUoeSyyLP8xbiJB/q9lKgeNzmtHhD49XHX0/MpKy
	alD0+texnmPehUctYvCbnzrlxBVsFplmZWMJ0XkFo/R21O/xCIpt4R8lO5k0i/cprEf4n06Ar0h
	yPyzJr2jGJC3VGDl+nXhIDtqa9qes9CF8GsjZEWWtkwfwgmMo85bNVxgEpPegSCIX7OaAyU5Gzp
	pVT9Fud9A4Ra1jFZxRUcmTfmMXmQeJe9hRExsMDjunkVcEpfrS1KZQ8tzgLssiPF1fAuuunNvt9
	RqDT8qkrXyW4pBMwK+K+vsdePXQBHQ==
X-Received: by 2002:a05:6300:2288:b0:343:9397:c4d6 with SMTP id
 adf61e73a8af0-38dff368bd5mr12999445637.23.1768943225140; Tue, 20 Jan 2026
 13:07:05 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1768489876.git.lucien.xin@gmail.com> <3771dfc211626a9f0c603c90113e38f325ceb456.1768489876.git.lucien.xin@gmail.com>
 <71705484-46fc-469f-9357-07a076ee0e73@redhat.com> <CADvbK_dYbMa-nVi_8M-XS1QcVUw25t4CZdvcq_HcACx38bH86g@mail.gmail.com>
In-Reply-To: <CADvbK_dYbMa-nVi_8M-XS1QcVUw25t4CZdvcq_HcACx38bH86g@mail.gmail.com>
From: Xin Long <lucien.xin@gmail.com>
Date: Tue, 20 Jan 2026 16:06:53 -0500
X-Gm-Features: AZwV_QhXAoJQwRs6pDZ6UAmUhYn8QaE6UDSDLYJNb4NfLJfMXHf3sVWRjS6qDQY
Message-ID: <CADvbK_chN0KTnibDW6VL3pR4iPQqrHznDXYCUDneB=vEnVD0MA@mail.gmail.com>
Subject: Re: [PATCH net-next v7 08/16] quic: add path management
To: Paolo Abeni <pabeni@redhat.com>
Cc: network dev <netdev@vger.kernel.org>, quic@lists.linux.dev, davem@davemloft.net, 
	kuba@kernel.org, Eric Dumazet <edumazet@google.com>, Simon Horman <horms@kernel.org>, 
	Stefan Metzmacher <metze@samba.org>, Moritz Buhl <mbuhl@openbsd.org>, Tyler Fanelli <tfanelli@redhat.com>, 
	Pengtao He <hepengtao@xiaomi.com>, Thomas Dreibholz <dreibh@simula.no>, linux-cifs@vger.kernel.org, 
	Steve French <smfrench@gmail.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Paulo Alcantara <pc@manguebit.com>, Tom Talpey <tom@talpey.com>, kernel-tls-handshake@lists.linux.dev, 
	Chuck Lever <chuck.lever@oracle.com>, Jeff Layton <jlayton@kernel.org>, 
	Steve Dickson <steved@redhat.com>, Hannes Reinecke <hare@suse.de>, Alexander Aring <aahringo@redhat.com>, 
	David Howells <dhowells@redhat.com>, Matthieu Baerts <matttbe@kernel.org>, 
	John Ericson <mail@johnericson.me>, Cong Wang <xiyou.wangcong@gmail.com>, 
	"D . Wythe" <alibuda@linux.alibaba.com>, Jason Baron <jbaron@akamai.com>, 
	illiliti <illiliti@protonmail.com>, Sabrina Dubroca <sd@queasysnail.net>, 
	Marcelo Ricardo Leitner <marcelo.leitner@gmail.com>, Daniel Stenberg <daniel@haxx.se>, 
	Andy Gospodarek <andrew.gospodarek@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-0.46 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=2];
	DMARC_POLICY_ALLOW_WITH_FAILURES(-0.50)[];
	R_DKIM_ALLOW(-0.20)[gmail.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-8972-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_THREE(0.00)[4];
	FREEMAIL_FROM(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[34];
	FREEMAIL_CC(0.00)[vger.kernel.org,lists.linux.dev,davemloft.net,kernel.org,google.com,samba.org,openbsd.org,redhat.com,xiaomi.com,simula.no,gmail.com,manguebit.com,talpey.com,oracle.com,suse.de,johnericson.me,linux.alibaba.com,akamai.com,protonmail.com,queasysnail.net,haxx.se,broadcom.com];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[gmail.com:+];
	R_SPF_SOFTFAIL(0.00)[~all:c];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[lucienxin@gmail.com,linux-cifs@vger.kernel.org];
	DMARC_POLICY_ALLOW(0.00)[gmail.com,none];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	ASN(0.00)[asn:7979, ipnet:2a01:60a::/32, country:US];
	TAGGED_RCPT(0.00)[linux-cifs];
	TO_DN_SOME(0.00)[];
	MISSING_XM_UA(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[ams.mirrors.kernel.org:rdns,ams.mirrors.kernel.org:helo,mail.gmail.com:mid]
X-Rspamd-Queue-Id: 6A17B4C5C8
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Tue, Jan 20, 2026 at 10:34=E2=80=AFAM Xin Long <lucien.xin@gmail.com> wr=
ote:
>
> On Tue, Jan 20, 2026 at 9:13=E2=80=AFAM Paolo Abeni <pabeni@redhat.com> w=
rote:
> >
> > On 1/15/26 4:11 PM, Xin Long wrote:
> > > @@ -0,0 +1,524 @@
> > > +// SPDX-License-Identifier: GPL-2.0-or-later
> > > +/* QUIC kernel implementation
> > > + * (C) Copyright Red Hat Corp. 2023
> > > + *
> > > + * This file is part of the QUIC kernel implementation
> > > + *
> > > + * Initialization/cleanup for QUIC protocol support.
> > > + *
> > > + * Written or modified by:
> > > + *    Xin Long <lucien.xin@gmail.com>
> > > + */
> > > +
> > > +#include <net/udp_tunnel.h>
> > > +#include <linux/quic.h>
> > > +
> > > +#include "common.h"
> > > +#include "family.h"
> > > +#include "path.h"
> > > +
> > > +static int (*quic_path_rcv)(struct sock *sk, struct sk_buff *skb, u8=
 err);
> >
> > It's unclear why an indirect call is needed here. At least some
> > explanation is needed in the commit message, possibly you could call
> > directly a static function.
> >
> This patchset makes the path subcomponent more independent from the core
> implementation. Aside from a few shared helper functions, it doesn't
> rely on code outside the subcomponent, in particular socket.c and
> packet.c.
>
> Other subcomponents, such as stream, connid, pnspace, cong,
> crypto, common, and family follow the same approach. They expose
> APIs to the core QUIC logic and don=E2=80=99t see the main process.
>
> Will leave an explanation here.
>
To achieve this, instead of introducing an indirect call, we can use
an 'extern' declaration of quic_packet_rcv() once it is introduced.
Before that point, the code simply falls back to calling kfree_skb(skb).

Will update it.

Thanks.

> > > +
> > > +static int quic_udp_rcv(struct sock *sk, struct sk_buff *skb)
> > > +{
> > > +     memset(skb->cb, 0, sizeof(skb->cb));
> > > +     QUIC_SKB_CB(skb)->seqno =3D -1;
> > > +     QUIC_SKB_CB(skb)->time =3D quic_ktime_get_us();
> > > +
> > > +     skb_pull(skb, sizeof(struct udphdr));
> > > +     skb_dst_force(skb);
> > > +     quic_path_rcv(sk, skb, 0);
> > > +     return 0;
> >
> > Why not:
> >         return quic_path_rcv(sk, skb, 0);
> > ?
> I checked the udp tunnel users:
>
> - bareudp: bareudp_udp_encap_recv()
> - vxlan: vxlan_rcv()
> - geneve: geneve_udp_encap_recv()
> - tipc: tipc_udp_recv()
> - sctp: sctp_udp_rcv()
>
> they all are returning 0 in .encap_udp(), I think because they all
> take care of the
> skb freeing in their err path already.
>
> is it safe to return error to UDP stack if the skb is already freed?
> Do you know?
>
> >
> > > +static struct quic_udp_sock *quic_udp_sock_create(struct sock *sk, u=
nion quic_addr *a)
> > > +{
> > > +     struct udp_tunnel_sock_cfg tuncfg =3D {};
> > > +     struct udp_port_cfg udp_conf =3D {};
> > > +     struct net *net =3D sock_net(sk);
> > > +     struct quic_uhash_head *head;
> > > +     struct quic_udp_sock *us;
> > > +     struct socket *sock;
> > > +
> > > +     us =3D kzalloc(sizeof(*us), GFP_KERNEL);
> > > +     if (!us)
> > > +             return NULL;
> > > +
> > > +     quic_udp_conf_init(sk, &udp_conf, a);
> > > +     if (udp_sock_create(net, &udp_conf, &sock)) {
> > > +             pr_debug("%s: failed to create udp sock\n", __func__);
> > > +             kfree(us);
> > > +             return NULL;
> > > +     }
> > > +
> > > +     tuncfg.encap_type =3D 1;
> > > +     tuncfg.encap_rcv =3D quic_udp_rcv;
> > > +     tuncfg.encap_err_lookup =3D quic_udp_err;
> > > +     setup_udp_tunnel_sock(net, sock, &tuncfg);
> > > +
> > > +     refcount_set(&us->refcnt, 1);
> > > +     us->sk =3D sock->sk;
> > > +     memcpy(&us->addr, a, sizeof(*a));
> > > +     us->bind_ifindex =3D sk->sk_bound_dev_if;
> > > +
> > > +     head =3D quic_udp_sock_head(net, ntohs(a->v4.sin_port));
> > > +     hlist_add_head(&us->node, &head->head);
> > > +     INIT_WORK(&us->work, quic_udp_sock_put_work);
> > > +
> > > +     return us;
> > > +}
> > > +
> > > +static bool quic_udp_sock_get(struct quic_udp_sock *us)
> > > +{
> > > +     return refcount_inc_not_zero(&us->refcnt);
> > > +}
> > > +
> > > +static void quic_udp_sock_put(struct quic_udp_sock *us)
> > > +{
> > > +     if (refcount_dec_and_test(&us->refcnt))
> > > +             queue_work(quic_wq, &us->work);
> >
> > Why using a workqueue here? AFAICS all the caller are in process
> > context. Is that to break a possible deadlock due to nested mutex?
> > Likely a comment on the refcount/locking scheme would help.
> >
> quic_udp_sock_put() will also be called in the RX path via
> quic_path_unbind() for the connection migration (after changing
> to a new path.), which is in the patchset-2.
>
> I will leave a comment for an explanation here.
>
> Thanks.

