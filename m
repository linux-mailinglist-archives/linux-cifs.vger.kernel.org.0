Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3B24342A4
	for <lists+linux-cifs@lfdr.de>; Wed, 20 Oct 2021 02:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbhJTAua (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 19 Oct 2021 20:50:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:45164 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229602AbhJTAua (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 19 Oct 2021 20:50:30 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id E9C8860F44
        for <linux-cifs@vger.kernel.org>; Wed, 20 Oct 2021 00:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1634690896;
        bh=9Ct6B1+eHNnsV4OTG5VuIdsnGsyIKrLKokfVOUUu36g=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=J0Jc6pdOM7WS/mCdbTf0St2/wTCtGc316+/6F3KmyHbSJFVVXehtKOVMleV7XkXve
         xAeL9O5eOcZQDZb4lnRekRU7Ridxo+5Kx4zC9RznYTqn1Ha/yPNC9rdgIL/f5wRTIl
         HGNH1oZLFtaxbd2YTcIAhv2VxU3mb52uOYVFrMCIsRWT9bIyQwDK4RWL/i8f0z89ST
         3Ric3Fc37IIczq9Bm6Xlj01UOBY8OuxEvwcjytU/kFN7rCz/HgqEninKFvPZFNxGTi
         a+ot3nXk8ZDBMN9wr1tK6f8uCGztBCFubybAHn1AounpE5SzkDz/sb9DRoZVrWkl0l
         xKpdopDbSGCBg==
Received: by mail-oi1-f175.google.com with SMTP id y207so7530956oia.11
        for <linux-cifs@vger.kernel.org>; Tue, 19 Oct 2021 17:48:16 -0700 (PDT)
X-Gm-Message-State: AOAM532vfUJMYl/32vR+6qH3mrA4Jbl0h166Xliozy1rKxps3og49P37
        MDLegrD8QF2KjpC90oPNYVEulurGaoOvdjuLcOY=
X-Google-Smtp-Source: ABdhPJwGte9Zx9AkqRXFBDX6uxZJ3KMjQj3M/DgXs24V/mFjegXhTG+n5Q98XaPSOm9kURvZuSSSvSIxrglLcuxjCW0=
X-Received: by 2002:aca:3885:: with SMTP id f127mr6889808oia.65.1634690896338;
 Tue, 19 Oct 2021 17:48:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:ac9:31e7:0:0:0:0:0 with HTTP; Tue, 19 Oct 2021 17:48:15
 -0700 (PDT)
In-Reply-To: <20211019153937.412534-1-mmakassikis@freebox.fr>
References: <20211019153937.412534-1-mmakassikis@freebox.fr>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Wed, 20 Oct 2021 09:48:15 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-A-TwYfJQ7ajrSR7XZrkmeC_hFpK0K0Dt=bdysiEQ3Sg@mail.gmail.com>
Message-ID: <CAKYAXd-A-TwYfJQ7ajrSR7XZrkmeC_hFpK0K0Dt=bdysiEQ3Sg@mail.gmail.com>
Subject: Re: [PATCH v4] ksmbd: add buffer validation in session setup
To:     Marios Makassikis <mmakassikis@freebox.fr>
Cc:     linux-cifs@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

2021-10-20 0:39 GMT+09:00, Marios Makassikis <mmakassikis@freebox.fr>:
> Make sure the security buffer's length/offset are valid with regards to
> the packet length.
>
> Signed-off-by: Marios Makassikis <mmakassikis@freebox.fr>
Acked-by: Namjae Jeon <linkinjeon@kernel.org>

Thanks!
