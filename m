Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC9B5A2BD8
	for <lists+linux-cifs@lfdr.de>; Fri, 26 Aug 2022 18:01:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiHZQBi (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 26 Aug 2022 12:01:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbiHZQBg (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 26 Aug 2022 12:01:36 -0400
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A861CD31DB
        for <linux-cifs@vger.kernel.org>; Fri, 26 Aug 2022 09:01:35 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 4BE2580273;
        Fri, 26 Aug 2022 16:01:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1661529694;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=sfBNT8YM5DCEcWbFtV0rcqEw/KgAhD22VnshDJiedtc=;
        b=yFvPRQdEwFRLuO0TY95Fi9ZS9t6fAKJ9/qqveQNCO8hfvQrEVyDCPQTAv4c0is7CJkM0Ew
        61qMb2rYW0J5jdPQpGDx+K64pu8KBQdS+gFg8w7PC9GlGQKGQhVqS2mdTXeyCilY0iCnkj
        c9v0UjQJrpjN9li0bxjMrVFSrG2/VLsK0UVRElPCFnBs9CF1GbU/o+spMPncTfkjrSfdar
        J/QD7On2s7JLozYN7MNh+QdZywiGAkTW1vMlmddCJ0VYP8yPZ2i6uhpygZe8dV8hlRHkwY
        j/rslUai000EZtHzaIk2y0PMK9jforZU0k6wk9dH1NSOa2Gc3Ct8VtqAeS2iPg==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org
Subject: Re: SMB client testing wiki
In-Reply-To: <93e55661-ea4e-7205-d310-59105bc767ed@talpey.com>
References: <8bcbba74-d6ce-3c40-4655-e67bf75f3b3f@talpey.com>
 <878rnb3vkw.fsf@cjr.nz> <93e55661-ea4e-7205-d310-59105bc767ed@talpey.com>
Date:   Fri, 26 Aug 2022 13:01:53 -0300
Message-ID: <8735dj3sem.fsf@cjr.nz>
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

> Easy enough! How do I know if it "passes" though? My understanding
> is that a bunch of tests are expected to fail, or at least warn.
> Do I need to test a clean client, then compare results? Or am I
> misunderstanding, and FSTYP=cifs is taking care of it?

That's a really good question.  We have a pre-defined list of tests that
get run by a specfic SMB version, server, if multichannel, etc.

Steve might send you the list of pre-defined tests that get run on our
buildbot so you can try it out.  He usually keeps those lists
up-to-date.
