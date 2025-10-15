Return-Path: <linux-cifs+bounces-6869-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B6B66BDD0E8
	for <lists+linux-cifs@lfdr.de>; Wed, 15 Oct 2025 09:31:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D589A19C2618
	for <lists+linux-cifs@lfdr.de>; Wed, 15 Oct 2025 07:29:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E865B321F43;
	Wed, 15 Oct 2025 07:21:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="NAXKsZhM"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 359E2314D0B
	for <linux-cifs@vger.kernel.org>; Wed, 15 Oct 2025 07:21:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760512872; cv=none; b=HVw+CumP7dhj2/sbWNH7Eg3BilWt8vWJZNzeJdG+XQNv2ivHkWE3nhIzVnd8g1wzkNt+G+sbMGtcKt3k7gdIQsti6ep+LT0s0Qx4/ZH4rQnmF56A+KOiAbErhcW8CW2UEenCTuaqtxny0wTvxwgUgCbu7spq4i+OxOGZ+MVhRjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760512872; c=relaxed/simple;
	bh=2JBfFcLoT4Bf7xKwaedvpIdbTHXAaPwx6HYkxP5qPLE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=mEbLLsUGX7lQdd2c6YTxYcJFLoCOfZfA0Z4MR3I69BsvA60wGj/ocJ5avwGajIDztQjmvyZE21xg+D53SAHRNoIOSQSdyNI92eDNYeXAQPeCam3ONc/GLa6Cf4QJv6KCyKLlZZkr8momVyiJ7BvKY6mW5sOTbgHjJC+ZaroT0sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=NAXKsZhM; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=bnstyUjD/NwhiBevjWYPNMML7YrpxyTaFchZxHKMe5A=; b=NAXKsZhMMlXg0Rg76nRTI9T5ad
	dxd0zymg8SM8S+JGEdDFQyNlOPtyknUqXwscTJQTVI48NcZ6DCQOokgHX5s91Zomp86CKjbDqcnpi
	ORXh1GjqnGY0nMBBG31owktsv5MC7MY/b4g3Z16oRxUG86ZlnD5mc/M9P6l9l6IvbFda2AGYNT9tH
	yrUA/meY/CopS/NqXJpeU3eWGLPY2BQLZAL6wmsiR5frcsn0sswZLogNvtyjOGOojNMGoVeJoMsqB
	dfXtimKHtex94liUGn3QhHcWlrss0ArujHU20ZI0S4tLZGisPxOlLDGg1mbr4Nj3BB204K6b4O1RE
	w3cSibG9Cq/g904/qRAfg+wzKmk9tC7nOdXkRinhyih4O5t2dGYAIUac67ukR8CcmbJFVc8lTgWQt
	OlrpUBpC0SLaicJf3AJvqR0GDTNFXJMIyo5lKqC4EhdSBvyKlTvB5ta28eXX7M292+FPEgBMDt4/y
	/oMFTqQd1gL6b19QnAUNi3ag;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1v8vof-009HnQ-1s;
	Wed, 15 Oct 2025 07:20:58 +0000
Message-ID: <7af986c8-7050-4b51-962e-dc3984ee1f58@samba.org>
Date: Wed, 15 Oct 2025 09:20:56 +0200
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 10/10] smb: client: let destroy_mr_list() keep
 smbdirect_mr_io memory if registered
To: Steve French <smfrench@gmail.com>
Cc: Tom Talpey <tom@talpey.com>, Long Li <longli@microsoft.com>,
 Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org,
 samba-technical@lists.samba.org
References: <cover.1760295528.git.metze@samba.org>
 <6d275bab3ee66cf653c9e1e242a0a87efa352063.1760295528.git.metze@samba.org>
Content-Language: en-US
From: Stefan Metzmacher <metze@samba.org>
In-Reply-To: <6d275bab3ee66cf653c9e1e242a0a87efa352063.1760295528.git.metze@samba.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Steve,

as already discussed, one additional hunk is needed...

> @@ -2402,6 +2448,9 @@ static int allocate_mr_list(struct smbdirect_socket *sc)
>   			goto kzalloc_mr_failed;
>   		}
>   
> +		kref_init(&mr->kref);
> +		mutex_init(&mr->mutex);
> +
>   		mr->mr = ib_alloc_mr(sc->ib.pd,
>   				     sc->mr_io.type,
>   				     sp->max_frmr_depth);

Here we're missing the following hunk:

@@ -2483,6 +2483,7 @@ static int allocate_mr_list(struct smbdirect_socket *sc)
  kcalloc_sgl_failed:
         ib_dereg_mr(mr->mr);
  ib_alloc_mr_failed:
+       mutex_destroy(&mr->mutex);
         kfree(mr);
  kzalloc_mr_failed:
         destroy_mr_list(sc);

I fixed it in my for-6.18/fs-smb-20251015-v2 branch,
up to commit e4418cd1d5d80a8c24530ac0a41a5451c44f82bf.
git fetch https://git.samba.org/metze/linux/wip.git for-6.18/fs-smb-20251015-v2

The above hunk is the only difference to the current sfrench-cifs-2.6/for-next
(at commit 7949ce089965bd025a8d46dbaa2f5d0a2bd4ec77), I only moved my commits
to the top. So you can just replace 7949ce089965bd025a8d46dbaa2f5d0a2bd4ec77 by
e4418cd1d5d80a8c24530ac0a41a5451c44f82bf.

Thanks!
metze


