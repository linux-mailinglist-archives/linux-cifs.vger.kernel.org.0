Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A1FD4E2C64
	for <lists+linux-cifs@lfdr.de>; Mon, 21 Mar 2022 16:35:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350340AbiCUPg1 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 21 Mar 2022 11:36:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350342AbiCUPg0 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 21 Mar 2022 11:36:26 -0400
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E15EF13FAC
        for <linux-cifs@vger.kernel.org>; Mon, 21 Mar 2022 08:35:00 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 4E6DA80851;
        Mon, 21 Mar 2022 15:34:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1647876898;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=6Rd9xl6Q5dGOJdoNvjs2GMKiFE/UOSCKQjARXBkwAaI=;
        b=FvJHA+59YVKhHr/eoVyNxabYz6zteFpz4TuS2mMOh+tSjVHweCKb8AeGILVmqbtS4Xq6NY
        jOgyKbwBowCbchA3zK4Am3L5yb2iXONGt8COrxHr2XZ17E9896BhMq/6ko0KusSr/wWisG
        iE3TqiaFCiGySDkXVkV2u8+bCkRBl/Ww5enp4/JSJJVNxBme832WCZQI8Nfy27Zk2XMoeN
        XXAALkG1ZZ3n5Ty57jBLJwVxQuh3W/3CCd/bWfCKPBbUJEqQxzEQsV5wIsx5xa/YDPUDw+
        3l+kzZu4StQ7zJ6RQkuDp0ZkeelrgQOL/pRHI/Bj1/xErG3SobbuGjBjspuoyg==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org,
        smfrench@gmail.com
Subject: Re: [PATCH] cifs: fix bad fids sent over wire
In-Reply-To: <2962692d-a0b5-25f2-3053-7e21620639c9@talpey.com>
References: <20220321002007.26903-1-pc@cjr.nz>
 <6ef3f7db-a6ed-62c7-226e-b2a20ef5b294@talpey.com> <878rt3v66c.fsf@cjr.nz>
 <2962692d-a0b5-25f2-3053-7e21620639c9@talpey.com>
Date:   Mon, 21 Mar 2022 12:34:52 -0300
Message-ID: <875yo7uxnn.fsf@cjr.nz>
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

> If you want to reduce a bit of code change, you could let the
> compiler generate the loads and stores via memcpy, with (perhaps)
> a struct { u8[8] } instead of the bare array.

Thanks for the suggestions.  It turned out to be more changes than I
expected.  In this case, I'm gonna fix some remaining sparse warnings
from my last patch and fix the commit message as you suggested.

Of course, we can refactor this out later and start with something like:

	struct smb2_fid {
	        __u8 Persistent[8];
	        __u8 Volatile[8];
	} __packed;

and then replace u64 integers with the above.
