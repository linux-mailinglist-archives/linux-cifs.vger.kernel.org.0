Return-Path: <linux-cifs+bounces-9255-lists+linux-cifs=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-cifs@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YCn+HQ6FhGl43QMAu9opvQ
	(envelope-from <linux-cifs+bounces-9255-lists+linux-cifs=lfdr.de@vger.kernel.org>)
	for <lists+linux-cifs@lfdr.de>; Thu, 05 Feb 2026 12:54:54 +0100
X-Original-To: lists+linux-cifs@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A89FF2160
	for <lists+linux-cifs@lfdr.de>; Thu, 05 Feb 2026 12:54:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 25A3C3002F68
	for <lists+linux-cifs@lfdr.de>; Thu,  5 Feb 2026 11:54:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EBC573ACEF9;
	Thu,  5 Feb 2026 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZvUyS4iC"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE9B978F4A;
	Thu,  5 Feb 2026 11:54:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770292489; cv=none; b=sqa6ix9GRUPE5yzEJ2cSrfSrR3+ddfQ8G2SGg+EZSKGNvixNSJr53c0YW/rhRE9QwDFgG4qoU+og8GMO/PXRAskiKS6KyrbksK9/3sCX/oSalnctyZ5KFqNpxxdky0yYHpliXbPKsm8ew/JB8f12QywUjZOkI3zuv+UsqEG4+GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770292489; c=relaxed/simple;
	bh=kCdeLWxKgZc6wbf+RKoW+llvQv7Hn6zi0OILEmEz9cQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RBJR5GhXbx8aPlE5HWraAiybbhc9xuLA9CxImD576x0AmIILIWHN91tu7jo9BdDdHUmDOmMjVywAC75zOzZ6/ULN0FQuz0cZQNlEpoCpLjgfpklZIwcDQ4TbyGYk2WTid8rP3uLUP8saqmLyG9Bu3hiPuvx6E2HzZUU57v5jAOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZvUyS4iC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A031AC4CEF7;
	Thu,  5 Feb 2026 11:54:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770292489;
	bh=kCdeLWxKgZc6wbf+RKoW+llvQv7Hn6zi0OILEmEz9cQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZvUyS4iCQkRge6TWPtq43LEMZnb0UYRc9QdlNHqbywxe33USBEF/xaLCv2dFXaiMT
	 oEncF4vgArN6DlRdlsqr34yPQNsqKMmu6QMX91QexNps3W94T9ou+d/ewPjbrIFSNa
	 M6qPO0tDlFozK2eTZRDQerraF2yq7IbrdOvmbaMhSvDZZMBWpK3Kr9VUtQjJWrq/Zt
	 ZQeuxXzU2maz9p0+yBQ3Eo4x8g4lyRkUAQuNcYRE8TJDOn8NmRoGSLK/zFJ7Bl1I7D
	 j/uL1gmhLZ4V8PX2MEHGoKYn3AXIgHoUCPgbSl4FTZOytBB8XdFlMIb6gQsnHgsqlf
	 MgHZKkYBU30vQ==
From: Simon Horman <horms@kernel.org>
To: lucien.xin@gmail.com
Cc: Simon Horman <horms@kernel.org>,
	steved@redhat.com,
	marcelo.leitner@gmail.com,
	aahringo@redhat.com,
	alibuda@linux.alibaba.com,
	jbaron@akamai.com,
	hare@suse.de,
	kuba@kernel.org,
	tom@talpey.com,
	linux-cifs@vger.kernel.org,
	daniel@haxx.se,
	quic@lists.linux.dev,
	jlayton@kernel.org,
	tfanelli@redhat.com,
	dhowells@redhat.com,
	linkinjeon@kernel.org,
	hepengtao@xiaomi.com,
	pc@manguebit.com,
	kernel-tls-handshake@lists.linux.dev,
	illiliti@protonmail.com,
	xiyou.wangcong@gmail.com,
	andrew.gospodarek@broadcom.com,
	mail@johnericson.me,
	edumazet@google.com,
	pabeni@redhat.com,
	matttbe@kernel.org,
	netdev@vger.kernel.org,
	smfrench@gmail.com,
	metze@samba.org,
	mbuhl@openbsd.org,
	chuck.lever@oracle.com,
	dreibh@simula.no,
	davem@davemloft.net,
	sd@queasysnail.net
Subject: Re: [net-next,v9,02/15] net: build socket infrastructure for QUIC protocol
Date: Thu,  5 Feb 2026 11:54:23 +0000
Message-ID: <20260205115423.2195277-1-horms@kernel.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <28a1e36188b1a84193ef2d78f12ecbc0e43ae7f1.1770042461.git.lucien.xin@gmail.com>
References: <28a1e36188b1a84193ef2d78f12ecbc0e43ae7f1.1770042461.git.lucien.xin@gmail.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [0.84 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	MID_CONTAINS_FROM(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_MISSING_CHARSET(0.50)[];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:104.64.211.4:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-9255-lists,linux-cifs=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	RCPT_COUNT_TWELVE(0.00)[35];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_CC(0.00)[kernel.org,redhat.com,gmail.com,linux.alibaba.com,akamai.com,suse.de,talpey.com,vger.kernel.org,haxx.se,lists.linux.dev,xiaomi.com,manguebit.com,protonmail.com,broadcom.com,johnericson.me,google.com,samba.org,openbsd.org,oracle.com,simula.no,davemloft.net,queasysnail.net];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[horms@kernel.org,linux-cifs@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-cifs];
	ASN(0.00)[asn:63949, ipnet:104.64.192.0/19, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns,linux.dev:url]
X-Rspamd-Queue-Id: 9A89FF2160
X-Rspamd-Action: no action

This is an AI-generated review of your patch. The human sending this
email has considered the AI review valid, or at least plausible.

For local reproduction steps see https://netdev-ai.bots.linux.dev/ai-local.html
---
net: build socket infrastructure for QUIC protocol

This patch lays the groundwork for QUIC socket support in the kernel.
It defines the core structures and protocol hooks needed to create
QUIC sockets, without implementing any protocol behavior at this stage.
Basic integration is included to allow building the module via
CONFIG_IP_QUIC=m. This provides the scaffolding necessary for adding
actual QUIC socket behavior in follow-up patches.

> diff --git a/net/quic/protocol.c b/net/quic/protocol.c
> new file mode 100644
> index 000000000000..6ab81f1c50cc
> --- /dev/null
> +++ b/net/quic/protocol.c

[ ... ]

> @@ -0,0 +1,369 @@

[ ... ]

> +static int quic_protosw_init(void)
> +{
> +	int err;
> +
> +	err = proto_register(&quic_prot, 1);
> +	if (err)
> +		return err;
> +
> +	err = proto_register(&quicv6_prot, 1);
> +	if (err) {
> +		proto_unregister(&quic_prot);
> +		return err;
> +	}
> +
> +	inet_register_protosw(&quic_stream_protosw);
> +	inet_register_protosw(&quic_dgram_protosw);
> +	inet6_register_protosw(&quicv6_stream_protosw);
> +	inet6_register_protosw(&quicv6_dgram_protosw);
> +
> +	return 0;
> +}

Can the return values from inet6_register_protosw() be checked?

Looking at the implementation, inet6_register_protosw() returns int and
can fail with -EINVAL (if p->type >= SOCK_MAX) or -EPERM (if trying to
override a permanent protocol). The calls at lines 234-235 don't check
these return values, so if registration fails, quic_protosw_init() still
returns 0 (success).

More critically, quic_protosw_exit() unconditionally calls
inet6_unregister_protosw() on both structures:

static void quic_protosw_exit(void)
{
	inet_unregister_protosw(&quic_dgram_protosw);
	inet_unregister_protosw(&quic_stream_protosw);
	proto_unregister(&quic_prot);

	inet6_unregister_protosw(&quicv6_dgram_protosw);
	inet6_unregister_protosw(&quicv6_stream_protosw);
	proto_unregister(&quicv6_prot);
}

If a protosw was never successfully registered, its list field remains
zero-initialized (NULL pointers). inet6_unregister_protosw() calls
list_del_rcu(&p->list), which with NULL pointers will dereference NULL
in __list_del_entry() -> __list_del(NULL, NULL), causing a kernel crash.

Note that inet_register_protosw() returns void (cannot fail from caller's
perspective), but inet6_register_protosw() returns int (can fail). The
code correctly checks errors from proto_register() but not from
inet6_register_protosw().

Should the return values from inet6_register_protosw() be checked, and
should the cleanup path track which registrations succeeded so only those
are unregistered?

