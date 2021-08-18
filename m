Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BE2A3EF6E1
	for <lists+linux-cifs@lfdr.de>; Wed, 18 Aug 2021 02:30:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235651AbhHRAa7 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 17 Aug 2021 20:30:59 -0400
Received: from mx.cjr.nz ([51.158.111.142]:21628 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234870AbhHRAa7 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 17 Aug 2021 20:30:59 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 3D024818D6;
        Wed, 18 Aug 2021 00:30:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1629246623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OwKoMpKsJfYGuAd5+UrIcHs7Dv7p+8pKzbl1xu55fyE=;
        b=nbJ9B3FXUUeED1pR2AuA+whx4RTm4MTvkBkk3TZRcgqwiSWtTlq5FuettUxXJN2b01es56
        2PPUYEJ6pZtdSdA9dWjpKm6nvrMcYmZfH8LXq1X+OiPeoTfbilWfKyMsb8WhbFqPFJJ9f/
        YJ/GBiVrJ8abARaqd5IAtuT0+zkDwK+Z2Jv8OOBM6l3GJA++rNNaxBseyGiCou9m5sBu1o
        MTq/vgJfDT1h8uAX67xwLvMBSyN6LSyQzUE1xqbUKzndceHAQe60CZYRYGHKRINFN7y/GP
        VNJpSB7Ryg+87uup72keukwqsQD7ENhF5GQFAoifNJzCFV+mKkqEaYVR5YY2UA==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Ding Hui <dinghui@sangfor.com.cn>, sfrench@samba.org
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, Ding Hui <dinghui@sangfor.com.cn>
Subject: Re: [PATCH] cifs: fix wrong release in sess_alloc_buffer() failed path
In-Reply-To: <20210817145510.639-1-dinghui@sangfor.com.cn>
References: <20210817145510.639-1-dinghui@sangfor.com.cn>
Date:   Tue, 17 Aug 2021 21:30:17 -0300
Message-ID: <87fsv7h9wm.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Ding Hui <dinghui@sangfor.com.cn> writes:

> smb_buf is allocated by small_smb_init_no_tc(), and buf type is
> CIFS_SMALL_BUFFER, so we should use cifs_small_buf_release() to
> release it in failed path.
>
> Signed-off-by: Ding Hui <dinghui@sangfor.com.cn>
> ---
>  fs/cifs/sess.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
