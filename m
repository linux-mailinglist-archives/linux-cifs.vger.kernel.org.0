Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 90421175F67
	for <lists+linux-cifs@lfdr.de>; Mon,  2 Mar 2020 17:19:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727262AbgCBQTx (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 2 Mar 2020 11:19:53 -0500
Received: from mx.cjr.nz ([51.158.111.142]:43764 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgCBQTx (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 2 Mar 2020 11:19:53 -0500
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 97A0A808AE;
        Mon,  2 Mar 2020 16:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1583165991;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=+i0or/SRpbtwbliKMGumSziBrict8Y2CfjBVEo5H8iE=;
        b=B3ADLswb/Nf+z+khJOackUxd1W1trIax+rXJbExkMNLAQsmrpUDttqQVPBfOsqk4zTSdbQ
        lkYN841TBiq1l/sNtUwJjL/CbRoCLQ5v04RILP4DGGNNYUVLw2gKj+y6Xbvuv82Bagvxv2
        emG068oHNre0ePB8Mkw5tXLLnO9IEQLH2Eqiu6ePtAOO2ItXN99dKEon4gEuKQkJQd0CvN
        DPnkLphyAniW4U01VcpR6EFgyzUUSf0q/ehm6XYuK2Xph4J6uW8U6bIdSSfDymyg+eAL79
        jaV7lLA4NZHkZD9QOHRyi3qXDck4sxYJr1WszypA4+hePsBoDNg+K7xx4cvDrg==
From:   Paulo Alcantara <pc@cjr.nz>
To:     abrosich@inogs.it, CIFS <linux-cifs@vger.kernel.org>
Subject: Re: Permission denied mounting a DFS share with multiuser options
In-Reply-To: <4c74eb81aa7757e48679eb83c2f2dcbfeb841a3f.camel@inogs.it>
References: <5a987faff74646e68207e26e570a708669dd4103.camel@inogs.it>
 <CAH2r5mu5dedRmPQzRUH=E87J2txsBv3DiFYZLT-a_xYay=2czA@mail.gmail.com>
 <4c74eb81aa7757e48679eb83c2f2dcbfeb841a3f.camel@inogs.it>
Date:   Mon, 02 Mar 2020 13:19:46 -0300
Message-ID: <87a74ysp99.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

abrosich@inogs.it writes:

> I've changed the environment.
> The linux client now is a Debian machine with testing flavour to have the latest
> versions of the involved softwares. These are the versions of some of them:
>
> Kernel: #1 SMP Debian 5.4.19-1 (2020-02-13)
> cifs.upcall: version: 6.9
> keyutils: keyctl from keyutils-1.6.1 (Built 2020-02-10)
> sssd: 2.2.3
> cifs module: 2.23

I'd guess the following commit would fix your issue:

    5739375ee423 ("cifs: Fix mount options set in automount")

but could you please try it with 5.6-rc4?

Provide full dmesg logs as well.
