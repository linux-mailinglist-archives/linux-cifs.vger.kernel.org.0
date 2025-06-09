Return-Path: <linux-cifs+bounces-4905-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C85AAAD1869
	for <lists+linux-cifs@lfdr.de>; Mon,  9 Jun 2025 07:51:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C43E83A391E
	for <lists+linux-cifs@lfdr.de>; Mon,  9 Jun 2025 05:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5095E18DB1E;
	Mon,  9 Jun 2025 05:51:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="rmTyXax2"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22D21610D
	for <linux-cifs@vger.kernel.org>; Mon,  9 Jun 2025 05:51:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749448316; cv=none; b=u2BCUg1MQyrg5c9y1eEYgVoGRX1YqtaLYhKbs/HV8RFaB2oH1FDFL4v0Nj5P3C4oklMMjP0bNcT3A6r/1jIrUJGiwyysq0Fcotsq1vvHhXPS0y0GC79Yn1B/yf5bZPVtOD+NLODZH1GvRuy16VFiS+7Zdb41pPKjeKgDNtyrTLk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749448316; c=relaxed/simple;
	bh=46u5AMRec64g4NvRp7uRTHkq2XlrgamLn2XNL8R3kvg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HYvNnqssi8KaRsp4TkY7PiASQRMmT2cFHk8ATD6++jgfaT2GL4E5k3U0/5U6MzUpa0oJVhEujuWL2x28MNGIFTagAjDMQTrGiZFmo22andNSHI7+9l9UbBaLH/oy7bZN9A9Qa64i15jJ8KuFk1rDGLZMWmfu/Na/NVecGbWzCN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=rmTyXax2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 987BAC4CEEB
	for <linux-cifs@vger.kernel.org>; Mon,  9 Jun 2025 05:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1749448315;
	bh=46u5AMRec64g4NvRp7uRTHkq2XlrgamLn2XNL8R3kvg=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
	b=rmTyXax21B+uZVU0pCo/pF8dAKBvcUw0xn1hhIx33uNdQLTdlgzpWCifg0xkB61WX
	 Ey2JtVQwImU24yHjfYfGFbty2r0+A9BFkF5gC5o62pZ/Asnbc9/K5yeIT/cYPfLW4V
	 Is+kCbTlU0SPTdg5MIgH7xOlaC4C2hqIqJHULWIEL2SnCQJLc0VqIMsZiZGgKsLpOT
	 FYjkfjqg124qKhEEoYWHZLLwcoyZjlaqnW6fkbIZA2oRfF0R4lUirTGxItJqJ5Ic4G
	 qeeePJNySg0zHGSMsJkzDZFXw9myB26h+1eBNUYnwbA6JaPx8WIRg65B7vzSc9c6fx
	 UzHs5NIeSxJSQ==
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ad89ee255easo716886966b.3
        for <linux-cifs@vger.kernel.org>; Sun, 08 Jun 2025 22:51:55 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy1TgjCTISyekPzNHLHBYzIZZ3A1dLgK6xTBZGjDlWlijZrQDuE
	tkdSax0qIyfPTpjg5mEYGubPjrRIRuYhajuLqhKJuUnaTJGXhBqX+qwkKV9RYPqlqnn7Vy92CR3
	5W3Za1nbAZfRGQSB5rFck+9KuvOVq810=
X-Google-Smtp-Source: AGHT+IFAtPrVSGRIrZf/fvDSDs1RGQa17LqGENfmZUrrVJaEYKpQy55lyFAVvUlvVIf2C0Yo9IC0eKQSL7IZf+bCCG4=
X-Received: by 2002:a17:907:2885:b0:ade:409c:2cb6 with SMTP id
 a640c23a62f3a-ade409c385amr515112866b.59.1749448314263; Sun, 08 Jun 2025
 22:51:54 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250608185900.439023-1-pkerling@rx2.rx-server.de>
In-Reply-To: <20250608185900.439023-1-pkerling@rx2.rx-server.de>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Mon, 9 Jun 2025 14:51:42 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-SjnnTtYp2NNvRuMWp39-MhcPa-+8xVCYKxDpGHLGsCQ@mail.gmail.com>
X-Gm-Features: AX0GCFtME7xzsQtztlZYqHC4TgCrnWTUd69ExARIXP05xWjzCDdofmgx6-ZdTho
Message-ID: <CAKYAXd-SjnnTtYp2NNvRuMWp39-MhcPa-+8xVCYKxDpGHLGsCQ@mail.gmail.com>
Subject: Re: [PATCH] smb: client: disable path remapping with POSIX extensions
To: Philipp Kerling <pkerling@casix.org>, Steve French <smfrench@gmail.com>
Cc: linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 9, 2025 at 3:59=E2=80=AFAM Philipp Kerling <pkerling@casix.org>=
 wrote:
>
> If SMB 3.1.1 POSIX Extensions are available and negotiated, the client
> should be able to use all characters and not remap anything. Currently, t=
he
> user has to explicitly request this behavior by specifying the "nomapposi=
x"
> mount option.
>
> Link: https://lore.kernel.org/4195bb677b33d680e77549890a4f4dd3b474ceaf.ca=
mel@rx2.rx-server.de
> Signed-off-by: Philipp Kerling <pkerling@casix.org>
Reviewed-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks.

