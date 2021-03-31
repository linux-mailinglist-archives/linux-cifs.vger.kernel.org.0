Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDAAF344FEA
	for <lists+linux-cifs@lfdr.de>; Mon, 22 Mar 2021 20:32:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230243AbhCVTbn (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 22 Mar 2021 15:31:43 -0400
Received: from mx.cjr.nz ([51.158.111.142]:2130 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230479AbhCVTb2 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 22 Mar 2021 15:31:28 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id CE0807FD53;
        Mon, 22 Mar 2021 19:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1616441483;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=IdCTEEv6xbJwci7QyxPlZ/yk5Qb2Gaeg8Rexjn9WUGc=;
        b=ucid2WVTebCOYAejJ9yBpOJQau5RHtNBWRe+ytLDvaS/vFbFbQ6xxrVkzBLbPqLRX3nUFk
        B1kWwoPN39tJcW2sr6JNfOCHFkV+OrQRsk+4TTHiO97DoWqnz6y9igmZgkbo+BNTrGzjkp
        rsQDNJshS4RwP5L+cga9Hjf4+Rp939jqmrrC1ceb01XVW9MiArHrgneu/GTuVpX4L6/9QL
        DrZxcARFbHvmYFNVVDEcgtVeXJ4OiRbAMNeA4niCSo4ubgPNhzhZZKiRan/+SkdDjEFQwp
        45U5YEpOrHlXSAnN/nCuE7ZFOoNGiveiB+HmcwJIOcgiov7OMQAj1FvQDp2usg==
From:   Paulo Alcantara <pc@cjr.nz>
To:     =?utf-8?Q?Aur=C3=A9lien?= Aptel <aaptel@suse.com>,
        linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>
Subject: Re: [PATCH] Documentation/admin-guide/cifs: document open_files and
 dfscache
In-Reply-To: <20210322173437.31220-1-aaptel@suse.com>
References: <20210322173437.31220-1-aaptel@suse.com>
Date:   Mon, 22 Mar 2021 16:31:19 -0300
Message-ID: <87mtuvrnnc.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Aur=C3=A9lien Aptel <aaptel@suse.com> writes:

> From: Aurelien Aptel <aaptel@suse.com>
>
> Add missing documentation for open_files and dfscache /proc files.
>
> Signed-off-by: Aurelien Aptel <aaptel@suse.com>
> ---
>  Documentation/admin-guide/cifs/usage.rst | 3 +++
>  1 file changed, 3 insertions(+)

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
