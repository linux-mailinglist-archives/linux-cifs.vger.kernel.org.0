Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D63344E32DA
	for <lists+linux-cifs@lfdr.de>; Mon, 21 Mar 2022 23:45:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229608AbiCUWqz (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 21 Mar 2022 18:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiCUWqx (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 21 Mar 2022 18:46:53 -0400
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA06B53B6A
        for <linux-cifs@vger.kernel.org>; Mon, 21 Mar 2022 15:25:27 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 5EBEB80851;
        Mon, 21 Mar 2022 21:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1647899301;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=FXngWJf7dXxQe5JOlNQu50Iqt56XKa7D6ScEImNdBGk=;
        b=kQZsLn4snovOblN8+tRRt6C3jm818R/4keoxUucKS1NJEpuLAJQV41p2keHEc5LIWN9kVo
        mztz21MrwNjnUxGp8mADqgeCeT3zu/iqblVeCmUYZ52swbwg4jageOCtlYfNrA1EiixMQq
        VYEGAahYAiELUoW48w4dVVcUIV7DxivcnJvdR762BuSuaRL41aMj+QETyVutJDN5o14xng
        0a7zua/EOyohT0m5dtkakt+AyvXSBpsLUnQW1kempC17wigKUU3TAwr/ix5pttEgtvrtiP
        fMOgBCOP1FEW2vDWLM6Q7xNCGMbMXAv7kHEbPXZTrMT0yrDadFjBzN6cGLCn2w==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        smfrench@gmail.com, linkinjeon@kernel.org
Subject: Re: [PATCH 1/2] cifs: fix bad fids sent over wire
In-Reply-To: <4fae4d1a-b6b0-d212-61fa-a6d6df8f2b6b@talpey.com>
References: <20220321160826.30814-1-pc@cjr.nz>
 <4fae4d1a-b6b0-d212-61fa-a6d6df8f2b6b@talpey.com>
Date:   Mon, 21 Mar 2022 18:48:16 -0300
Message-ID: <87zgljt1sv.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Tom Talpey <tom@talpey.com> writes:

> I agree this is the most practical way to address the issue, and
> any potential static checker warnings.
>
> Have you tested on both endian clients I assume? Might be tricky
> to catch all the ops/cases, especially that cancel.

I did some quick tests on x86_64 and s390x under QEMU against Windows
2022 server and ksmbd and all seemed to work.  Hopefully Steve & Namjae
can also help with more tests.

> Reviewed-By: Tom Talpey <tom@talpey.com>

Thanks!
