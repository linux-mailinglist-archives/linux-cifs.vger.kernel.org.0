Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4BE99BA01C
	for <lists+linux-cifs@lfdr.de>; Sun, 22 Sep 2019 03:25:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726861AbfIVBZL (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 21 Sep 2019 21:25:11 -0400
Received: from mail-pf1-f194.google.com ([209.85.210.194]:33232 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726701AbfIVBZL (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 21 Sep 2019 21:25:11 -0400
Received: by mail-pf1-f194.google.com with SMTP id q10so6925567pfl.0
        for <linux-cifs@vger.kernel.org>; Sat, 21 Sep 2019 18:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=eEvNJOALap/dBFZjPQyzquXTwasjYjCdNdMBz7Lz0V4=;
        b=jNFmdvgK+km735Gb/qL6yxab/AXKWaQiobkYBtuFYUFhy9cRX5vKsga5a1BI78xXoo
         ql2zdr/YGNGikWviOuGCWHe5GSOgylXjoHCwyxWcLw501YhNgsBQ71tyAatKT7w7b6rx
         Yb7ydvQ0fFm+M2mRaZkjkBmn8kdS+m0gsE4dkgZBGAxUvKhTXsklJuHp3fYfisrPfvIt
         mh8N4uNpfSv5nopI9KbPpTH7TsEAwhgMzMf4E5CSwubgHhj2cin0Ky2bH9ZKg4xtfngx
         tTEpmRdZcUVQoDYG1w7deeanYPKZWCrh/czQK+QuyrHtTXtYFmMnMVl2SuuAIJ9rw8Yl
         9a+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=eEvNJOALap/dBFZjPQyzquXTwasjYjCdNdMBz7Lz0V4=;
        b=rz3WLbejJPGx1WpRiJQ6Z62ORmf3+S0rGZNLD/IRD9/kl6S0wGDZVmm6e25UnhTaGX
         vSVpKLsDLKJXK7V0hO/IlGW7WhoNRpDgXw/XfciGLkzrwYT/9qSezDlnsjTuwIvyuLhq
         oxkNTQxqtxCwsCp3eqGC0g012gfHGAfNXJMAdiwiA3P0iLWdQTOSirBTrTNaeKpOrNTn
         iZD1LVI9Z6Qdyz4jOYjqvl3RoNJMj2ieATTUoBYdYClzQl+AscAyDxKc6z7wKNizSnis
         nW+vf5kS134G7j16hpMfMNe356vP9IH0M+o53HScqqZztVqIxtz1grePr/yhglrYlyeq
         CpAg==
X-Gm-Message-State: APjAAAUYyWss4maWmSZsCe4y6Pj1BL4J2SN1tu14wk45mB7ifDJg4Usm
        faoM9PheGHxGkK97knF6ffA=
X-Google-Smtp-Source: APXvYqxD/pmVzwAukn3koHbeg059n0ZPWL+ImqEfGRjfu7J9KSDze7FXsbRTc5gNqZaOPR3eZIbDIg==
X-Received: by 2002:a63:e745:: with SMTP id j5mr20349367pgk.302.1569115510344;
        Sat, 21 Sep 2019 18:25:10 -0700 (PDT)
Received: from localhost ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id b22sm6842523pfo.85.2019.09.21.18.25.08
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Sep 2019 18:25:09 -0700 (PDT)
Date:   Sun, 22 Sep 2019 09:25:01 +0800
From:   Murphy Zhou <jencce.kernel@gmail.com>
To:     =?utf-8?B?QXVyw6lsaWVu?= Aptel <aaptel@suse.com>
Cc:     Murphy Zhou <jencce.kernel@gmail.com>, linux-cifs@vger.kernel.org
Subject: Re: [PATCH] CIFS: fix max ea value size
Message-ID: <20190922012501.g6yon32sxlzdvkgj@XZHOUW.usersys.redhat.com>
References: <20190921112600.utzouyddp3cdmxhe@XZHOUW.usersys.redhat.com>
 <878sqhfqzf.fsf@suse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <878sqhfqzf.fsf@suse.com>
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Sat, Sep 21, 2019 at 08:23:32PM +0200, Aur�lien Aptel wrote:
> "Murphy Zhou" <jencce.kernel@gmail.com> writes:
> > It should not be larger then the slab max buf size. If user
> > specifies a larger size, it passes this check and goes
> > straightly to SMB2_set_info_init performing an insecure memcpy.
> 
> It's even smaller than that as CIFSMaxBufSize is the max size for the
> whole packet IIRC. The EA payload needs to fit into that. So it should
> be CIFSMaxBufSize-(largest SMB2 header size + Set EA initial header).

No need. Slab size includes the bufzise and the header size.

> And if we set multiple EA at the same time it has to be divided
> by the number of EAs etc...

They will be handled separately and slab will work well.

> 
> Cheers,
> -- 
> Aur�lien Aptel / SUSE Labs Samba Team
> GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N�rnberg, DE
> GF: Felix Imend�rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M�nchen)
