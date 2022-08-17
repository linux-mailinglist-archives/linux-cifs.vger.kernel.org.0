Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B47FC59761A
	for <lists+linux-cifs@lfdr.de>; Wed, 17 Aug 2022 20:57:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238620AbiHQSxb (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 17 Aug 2022 14:53:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241319AbiHQSx2 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 17 Aug 2022 14:53:28 -0400
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD4D5F90
        for <linux-cifs@vger.kernel.org>; Wed, 17 Aug 2022 11:53:25 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id DB7047FC4F;
        Wed, 17 Aug 2022 18:53:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1660762403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hvgPlFvMMVceLYRjTqbDiwKrOjNVukrrOSx4plrLH7o=;
        b=Kir10G2pGg0yJFKvKFHu6msXwJhpRJXvTMDAAYQZaRL2qnmvtTx9lz8kFmVjouIp3Emi6b
        b9DRrg0+lyS7d6MiHrp5fWVWraaRNK/SqLYOobbLPLRk5gupTqTe37UtRQAlcEGXG++eiJ
        PZW2/Ear3hUqSyHY5JIfLeoETTamMz/+N5MsAjtuvynDswCHknHyWKDTT2JobJK8dHbOkI
        0F27UUbVaGMGXmNxldVofufScibFbk4BSe/8Z999QVRHYM1JBHjD+EEV1zAC1Vxg2t13WG
        CeuzV1jlf0TQgYKPQoWD8M353FxwRw95jaCLikCgQqTjedgvini3LzykO9LD0A==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Enzo Matsumiya <ematsumiya@suse.de>, linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com
Subject: Re: [PATCH] cifs: remove unused server parameter from calc_smb_size()
In-Reply-To: <20220817171402.7984-1-ematsumiya@suse.de>
References: <20220817171402.7984-1-ematsumiya@suse.de>
Date:   Wed, 17 Aug 2022 15:53:35 -0300
Message-ID: <87wnb67lcg.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Enzo Matsumiya <ematsumiya@suse.de> writes:

> Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
> ---
>  fs/cifs/cifs_debug.c | 2 +-
>  fs/cifs/cifsglob.h   | 2 +-
>  fs/cifs/cifsproto.h  | 2 +-
>  fs/cifs/misc.c       | 2 +-
>  fs/cifs/netmisc.c    | 2 +-
>  fs/cifs/readdir.c    | 6 ++----
>  fs/cifs/smb2misc.c   | 4 ++--
>  fs/cifs/smb2ops.c    | 2 +-
>  fs/cifs/smb2proto.h  | 2 +-
>  9 files changed, 11 insertions(+), 13 deletions(-)

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
