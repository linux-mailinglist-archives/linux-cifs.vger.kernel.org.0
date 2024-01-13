Return-Path: <linux-cifs+bounces-766-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BA2E82CE69
	for <lists+linux-cifs@lfdr.de>; Sat, 13 Jan 2024 21:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 049CF1F221C7
	for <lists+linux-cifs@lfdr.de>; Sat, 13 Jan 2024 20:41:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91D0C6D39;
	Sat, 13 Jan 2024 20:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qn4xslFV"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5134579E5;
	Sat, 13 Jan 2024 20:41:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62DA4C433F1;
	Sat, 13 Jan 2024 20:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705178460;
	bh=c8BIQyP1H8lJObZSyl18dvJBZNh2pJY7zSNOX401RyQ=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=qn4xslFVH3tcADj40i6pWVh6bZyn8WaSie6SIWR0WkQSXBtyJJJ9lUMuUJctrEXxM
	 J0orl6gEIo61FRKwl2wq+Rbruo4hrelO5oD7OBsjGXsefe3ku26FyKy7gqh5Y8jVqL
	 R9gRghwdeQRGyixCVKKVnaDGR78+pekJu6fwIn/LsY36kaLkWImdmUk4zAG5/ubgqI
	 4pMqhjNxXMJsVoXEoD+EnZR7GoNBihD93TeMJyvvcCalZynDqiKmfTumxdEVJDZYVZ
	 kB0uLDJ3o6Y4PgZcqvm77scHlMb2HGwUlkOirDnNc2N51LyKAyF4FU54Ow9cbZD61/
	 Pcw6rICC9g1wg==
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Sat, 13 Jan 2024 22:40:54 +0200
Message-Id: <CYDVBBKUZ314.1VU7WLWB1IMM3@kernel.org>
From: "Jarkko Sakkinen" <jarkko@kernel.org>
To: "David Howells" <dhowells@redhat.com>, "Linus Torvalds"
 <torvalds@linux-foundation.org>, "Edward Adam Davis" <eadavis@qq.com>,
 "Pengfei Xu" <pengfei.xu@intel.com>
Cc: "Simon Horman" <horms@kernel.org>, "Markus Suvanto"
 <markus.suvanto@gmail.com>, "Jeffrey E Altman" <jaltman@auristor.com>,
 "Marc Dionne" <marc.dionne@auristor.com>, "Wang Lei"
 <wang840925@gmail.com>, "Jeff Layton" <jlayton@redhat.com>, "Steve French"
 <smfrench@gmail.com>, "David S. Miller" <davem@davemloft.net>, "Eric
 Dumazet" <edumazet@google.com>, "Jakub Kicinski" <kuba@kernel.org>, "Paolo
 Abeni" <pabeni@redhat.com>, <linux-afs@lists.infradead.org>,
 <keyrings@vger.kernel.org>, <linux-cifs@vger.kernel.org>,
 <linux-nfs@vger.kernel.org>, <ceph-devel@vger.kernel.org>,
 <netdev@vger.kernel.org>, <linux-fsdevel@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] keys, dns: Fix size check of V1 server-list header
X-Mailer: aerc 0.16.0
References: <1850031.1704921100@warthog.procyon.org.uk>
In-Reply-To: <1850031.1704921100@warthog.procyon.org.uk>

On Wed Jan 10, 2024 at 11:11 PM EET, David Howells wrote:
>    =20
> Fix the size check added to dns_resolver_preparse() for the V1 server-lis=
t
> header so that it doesn't give EINVAL if the size supplied is the same as
> the size of the header struct (which should be valid).
>
> This can be tested with:
>
>         echo -n -e '\0\0\01\xff\0\0' | keyctl padd dns_resolver desc @p
>
> which will give "add_key: Invalid argument" without this fix.
>
> Fixes: 1997b3cb4217 ("keys, dns: Fix missing size check of V1 server-list=
 header")
> Reported-by: Pengfei Xu <pengfei.xu@intel.com>
> Link: https://lore.kernel.org/r/ZZ4fyY4r3rqgZL+4@xpf.sh.intel.com/
> Signed-off-by: David Howells <dhowells@redhat.com>
> cc: Edward Adam Davis <eadavis@qq.com>
> cc: Linus Torvalds <torvalds@linux-foundation.org>
> cc: Simon Horman <horms@kernel.org>
> Cc: Jarkko Sakkinen <jarkko@kernel.org>
> Cc: Jeffrey E Altman <jaltman@auristor.com>
> Cc: Wang Lei <wang840925@gmail.com>
> Cc: Jeff Layton <jlayton@redhat.com>
> Cc: Steve French <sfrench@us.ibm.com>
> Cc: Marc Dionne <marc.dionne@auristor.com>
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> ---
>  net/dns_resolver/dns_key.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/dns_resolver/dns_key.c b/net/dns_resolver/dns_key.c
> index f18ca02aa95a..c42ddd85ff1f 100644
> --- a/net/dns_resolver/dns_key.c
> +++ b/net/dns_resolver/dns_key.c
> @@ -104,7 +104,7 @@ dns_resolver_preparse(struct key_preparsed_payload *p=
rep)
>  		const struct dns_server_list_v1_header *v1;
> =20
>  		/* It may be a server list. */
> -		if (datalen <=3D sizeof(*v1))
> +		if (datalen < sizeof(*v1))
>  			return -EINVAL;
> =20
>  		v1 =3D (const struct dns_server_list_v1_header *)data;

Reviewed-by: Jarkko Sakkinen <jarkko@kernel.org>

BR, Jarkko


