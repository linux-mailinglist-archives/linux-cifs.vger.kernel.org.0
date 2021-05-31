Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 665A0396218
	for <lists+linux-cifs@lfdr.de>; Mon, 31 May 2021 16:49:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232185AbhEaOvU (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 31 May 2021 10:51:20 -0400
Received: from mx.cjr.nz ([51.158.111.142]:34918 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233991AbhEaOtP (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 31 May 2021 10:49:15 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 9400C7FC02;
        Mon, 31 May 2021 14:47:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1622472453;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qJuMoqwILVb+N2IGSWtT1m1P73SBKtjiUw0oUcTLrHM=;
        b=dEs7vZf7HWzb5ZSRlZ8wdjQCIG+TzB3r7OS87X9o42eKSfROG5UrXIf4oh+/ljFnNUSZUY
        PdUD+A04WM0AXhqqslrGmF0bgvoWWlHBMhOoDbI7JdnIeoRyBWkp7VlanY84aLE87TQ84G
        8NvLZYqi3uGhTfQwEBcNS+mHCQIv+wtYOyDA/5LQDsJGaF/CJHE4S+aHNI7mcXxZkU/4lP
        +W2ugYU6AMfkzzA3fgB7bbb+EuyTn79IK/eXlGEtTcv5WoP5JzwF0vnJQVrDXylSe16MsI
        ELUOJRgk6p0dXSG5Sdme7ZrrgjEun8FEvW8GD00tjyizjBdRIwoTqdzoAn9ENA==
From:   Paulo Alcantara <pc@cjr.nz>
To:     YueHaibing <yuehaibing@huawei.com>, sfrench@samba.org
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, YueHaibing <yuehaibing@huawei.com>
Subject: Re: [PATCH -next] cifs: Remove unused inline function
 is_sysvol_or_netlogon()
In-Reply-To: <20210529114848.19608-1-yuehaibing@huawei.com>
References: <20210529114848.19608-1-yuehaibing@huawei.com>
Date:   Mon, 31 May 2021 11:47:27 -0300
Message-ID: <87eednot8g.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

YueHaibing <yuehaibing@huawei.com> writes:

> is_sysvol_or_netlogon() is never used, so can remove it.
>
> Signed-off-by: YueHaibing <yuehaibing@huawei.com>
> ---
>  fs/cifs/dfs_cache.c | 11 -----------
>  1 file changed, 11 deletions(-)

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
