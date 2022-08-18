Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11C575988E2
	for <lists+linux-cifs@lfdr.de>; Thu, 18 Aug 2022 18:31:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344551AbiHRQbC (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 18 Aug 2022 12:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343661AbiHRQbC (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 18 Aug 2022 12:31:02 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [IPv6:2001:67c:2178:6::1d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662F56A486
        for <linux-cifs@vger.kernel.org>; Thu, 18 Aug 2022 09:31:01 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 23BCF20A3E;
        Thu, 18 Aug 2022 16:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1660840260; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EP8JTWLWp1Xhd4Q9xWqNlrxGR9qhuJt689YihANfbE0=;
        b=tT1TkH6K3HH+M5Mi/W1KFPMqe+U+Op9IHPFdBF0s/+FcIJ3Owl9WzkUn2sC1BywfSHILka
        +Pq609IyIIDoTYAFOn9dAlZu1JIR6wiWFydFEPqTB2WVO9TI96rxULDbfGRHoKhVhrMeN0
        8TnhscUjVDvrTBcvUw0cU80sP9PLxBA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1660840260;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EP8JTWLWp1Xhd4Q9xWqNlrxGR9qhuJt689YihANfbE0=;
        b=96mBZ/X9HsmAvX5rJ+aVUOP7VXAJQnOMIeN1RxFNdniHEjhEt0t6FnFdvTQprdnexe/f1r
        H4fg0odNHUjEldBg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 959CD139B7;
        Thu, 18 Aug 2022 16:30:59 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id AQqTFUNp/mLNLgAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Thu, 18 Aug 2022 16:30:59 +0000
Date:   Thu, 18 Aug 2022 13:30:56 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Subject: Re: mount.cifs man page
Message-ID: <20220818163056.54xunvo5rfr7hi7g@cyberdelia>
References: <CAH2r5mupcJD89SP4SqOmTLSABQ0kStyWF9EU-eMEuyZ_uA7G9w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAH2r5mupcJD89SP4SqOmTLSABQ0kStyWF9EU-eMEuyZ_uA7G9w@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On 08/18, Steve French wrote:
>I was looking at the mount.cifs man page, which is missing
>documentation for some mount options, and also could be made less
>confusing by moving some of the less commonly needed mount options.
>
>Are there good examples (of better written man pages) that we could
>borrow ideas for a a breakdown by section, etc. ?

I keep referring to nvme stuff, whether it's code or documentation. I
think they do a pretty good job in making things clear.

cf.: man 1 nvme, (e.g.) man 1 nvme-connect, drivers/nvme/*

HTH

>-- 
>Thanks,
>
>Steve

Cheers,

Enzo
