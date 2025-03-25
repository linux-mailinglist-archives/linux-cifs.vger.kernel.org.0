Return-Path: <linux-cifs+bounces-4316-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 37ED7A6FDAD
	for <lists+linux-cifs@lfdr.de>; Tue, 25 Mar 2025 13:46:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 23D27178717
	for <lists+linux-cifs@lfdr.de>; Tue, 25 Mar 2025 12:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AC2B276041;
	Tue, 25 Mar 2025 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UbkcT2aq"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27AFE276040
	for <linux-cifs@vger.kernel.org>; Tue, 25 Mar 2025 12:23:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742905383; cv=none; b=o7h6XjnTxiaVNmQhZypyi0ZPhHhv35FrEvP0oGxJDX1IY/S1guRNCy6FkGgJnqdnTlOHelUmkknmCto1cvGpkExzUUCHN1ptE8RHwif0UqLB3tS7zL+iEuNNoIUpfE7DQhVtKYyrc8JkSdxC8cUqVZC2RWoV5d977DQn0vRdQg8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742905383; c=relaxed/simple;
	bh=KXB22Cbaur2xsdVI0usm/C4UfHAs29HnieKThDifOvg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=roghRRXfh1OeFzIU9RZkIM1MHhL3Q1U7OcDwx0LUWYyUfAHE8BkZH0GQGI0krblApPL+5J6Y+KNsqeeFpnu+7Pg677NKXkzL0TMl08G/dOV35LvtQr94WZJdMvLSBu8egGhwwZJIV4p2TAb+PhCxZe1uOeMiIabTpHx0h5ai67o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UbkcT2aq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E22DC4CEE4;
	Tue, 25 Mar 2025 12:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742905383;
	bh=KXB22Cbaur2xsdVI0usm/C4UfHAs29HnieKThDifOvg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=UbkcT2aqQjO5r2X8BxHD5NILAddzkRkoXYkmvp/IexmANSW3rXUvUvl0zomEZXjqQ
	 Cd1WTPFEqpy3jPe0xhJTCXzfOiDxMD7B4M/QR6aaVGWZHNy3J0FnWxF7rRpqm3hASQ
	 DQvbbN3Kq99KshtBWXG4LSBhzuSckqIdmVwBR0iKxzcLVzhe6wyTDWsDhR5tc3UMNb
	 KUkt6Jz+BYlXVwmvyVkFt1q1yPyeBRBOt26DM4J/HFSRsNjycexpCuyCLoLf45Gky1
	 Z7UaGxDC61Leeb6ytK06vgwMFt0DkKPxRgw9wWDhjTXJup9b2eFEr4k7omiiyevrwA
	 umasp5ndHPKgg==
Date: Tue, 25 Mar 2025 14:22:50 +0200
From: Leon Romanovsky <leon@kernel.org>
To: Namjae Jeon <linkinjeon@kernel.org>
Cc: linux-cifs@vger.kernel.org, smfrench@gmail.com,
	senozhatsky@chromium.org, tom@talpey.com, atteh.mailbox@gmail.com
Subject: Re: [PATCH] ksmbd: use ib_device_get_netdev() instead of calling
 ops.get_netdev
Message-ID: <20250325122250.GA11855@unreal>
References: <20250322003054.6500-1-linkinjeon@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250322003054.6500-1-linkinjeon@kernel.org>

On Sat, Mar 22, 2025 at 09:30:54AM +0900, Namjae Jeon wrote:
> ULPs are not supposed to call to ops.* directly.
> 
> Suggested-by: Leon Romanovsky <leon@kernel.org>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>  fs/smb/server/transport_rdma.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Thanks,
Reviewed-by: Leon Romanovsky <leon@kernel.org>

