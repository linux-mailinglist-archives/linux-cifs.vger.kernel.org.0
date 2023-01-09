Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAA816634CD
	for <lists+linux-cifs@lfdr.de>; Tue, 10 Jan 2023 00:01:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234466AbjAIXBw (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 9 Jan 2023 18:01:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234480AbjAIXBv (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 9 Jan 2023 18:01:51 -0500
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D19738AFF
        for <linux-cifs@vger.kernel.org>; Mon,  9 Jan 2023 15:01:50 -0800 (PST)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 898567FC04;
        Mon,  9 Jan 2023 23:01:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1673305309;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=DbG4JEdHC1NfebbQQDSgn2+c6ZTocENHTzBTqGRbyqs=;
        b=uRRdBsw8qA0bdSRgBmP/4M/mMOJtERzR24TjNHGeYKKSB7clq7Xqc6MNAByp/Qn61P1lxa
        Ul3KUbFy4mZ04NZ0BEAwByFpnNcybkBSS+wgFmabswLQo8gCk6dCktV5twwdC4JswP2FJx
        Evn0SqmJqwY1AyRP04hdZvMWI8BGB5CH7muzgYj2ndreezxSicp7DUmCr7keChS3qByaXn
        9FSjJtXb1pm4v1Cbyfrj2R5tnP522aD31ZebzEmIwkuLxxhbZ6+9r7zFQyg29deDOrkRJ5
        GuUAulr0Hjq6eYU8+DOIXP7fucZ/ZxclmijePBLAHjOZiwn3IaPHcLC1hrW0Ug==
From:   Paulo Alcantara <pc@cjr.nz>
To:     ronnie sahlberg <ronniesahlberg@gmail.com>,
        linux-cifs <linux-cifs@vger.kernel.org>
Subject: Re: Fwd: [Bug 2159009] Visting CIFS Shares Freezes Machine
In-Reply-To: <CAN05THRKBAghwkyMO4+mSoEogn6RWcMkxvj_TUTysVtTBgVtdA@mail.gmail.com>
References: <bug-2159009-264875@https.bugzilla.redhat.com/>
 <bug-2159009-264875-75dbnIpzuh@https.bugzilla.redhat.com/>
 <CAN05THRKBAghwkyMO4+mSoEogn6RWcMkxvj_TUTysVtTBgVtdA@mail.gmail.com>
Date:   Mon, 09 Jan 2023 20:01:45 -0300
Message-ID: <87mt6rwbvq.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

ronnie sahlberg <ronniesahlberg@gmail.com> writes:

> Looks like upstream has a few recent regressions now. We probably need
> to look into expanding our test coverage so that we catch this before
> they hit linus tree.

Yes, agreed.  I've written the tests that catch below report and will
add to buildbot once we have access to it again.

This bug seems related to [1] and [2] and should be fixed by [3].

Thanks.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=216881
[2] https://bugzilla.kernel.org/show_bug.cgi?id=216889
[3] https://lore.kernel.org/linux-cifs/20230107200134.4822-1-pc@cjr.nz/T/#t

> ---------- Forwarded message ---------
> From: <bugzilla@redhat.com>
> Date: Sun, 8 Jan 2023 at 20:15
> Subject: [Bug 2159009] Visting CIFS Shares Freezes Machine
> To: <ronniesahlberg@gmail.com>
>
>
> https://bugzilla.redhat.com/show_bug.cgi?id=2159009
>
> Alexander Bokovoy <abokovoy@redhat.com> changed:
>
>            What    |Removed                     |Added
> ----------------------------------------------------------------------------
>                  CC|                            |acaringi@redhat.com,
>                    |                            |adscvr@gmail.com,
>                    |                            |airlied@redhat.com,
>                    |                            |alciregi@posteo.net,
>                    |                            |bskeggs@redhat.com,
>                    |                            |hdegoede@redhat.com,
>                    |                            |hpa@redhat.com,
>                    |                            |jarodwilson@gmail.com,
>                    |                            |jglisse@redhat.com,
>                    |                            |josef@toxicpanda.com,
>                    |                            |kernel-maint@redhat.com,
>                    |                            |lgoncalv@redhat.com,
>                    |                            |linville@redhat.com,
>                    |                            |masami256@gmail.com,
>                    |                            |mchehab@infradead.org,
>                    |                            |ptalbert@redhat.com,
>                    |                            |steved@redhat.com
>            Doc Type|---                         |If docs needed, set a value
>           Component|cifs-utils                  |kernel
>            Assignee|ronniesahlberg@gmail.com    |kernel-maint@redhat.com
>
>
>
> --- Comment #3 from Alexander Bokovoy <abokovoy@redhat.com> ---
> Moving to kernel package. cifs-utils is a user space one that does not
> implement the SMB protocol but rather helps to establish the session. The bug
> is in the kernel side of things.
>
>
> --
> You are receiving this mail because:
> You are on the CC list for the bug.
> You are the assignee for the bug.
> https://bugzilla.redhat.com/show_bug.cgi?id=2159009
