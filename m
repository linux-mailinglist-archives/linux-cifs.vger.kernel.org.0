Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D76CF4EF750
	for <lists+linux-cifs@lfdr.de>; Fri,  1 Apr 2022 18:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344925AbiDAP4R (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 1 Apr 2022 11:56:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354313AbiDAPux (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 1 Apr 2022 11:50:53 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7832D1D833E
        for <linux-cifs@vger.kernel.org>; Fri,  1 Apr 2022 08:25:12 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out2.suse.de (Postfix) with ESMTPS id 24CE41FD01;
        Fri,  1 Apr 2022 15:25:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648826711; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RUHcQAJtktCENB0eECRS1RQy+FYsu6YNo4v3teg3Cr0=;
        b=SEVycTwMo6oQfLYQ3+fTnP8FqFeTB7S12myisl0jyQQE7Rd7q1VPbH9Uz9/E9q6eYZA3KE
        De7NNTj9d6TT//NHPvjkVkGubDCxa4YJyylh9XqbKDowEeAOI9GxAXF2aoy0ZYWQOFi6jq
        mdXOp3hLsYkjIIHvZvI9tY8bucMvHbI=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648826711;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RUHcQAJtktCENB0eECRS1RQy+FYsu6YNo4v3teg3Cr0=;
        b=X4UYNnEZXn3kTjYPJJSSJ4uEzuKC4Dsam9+kOgoNo6l/CMSt4ysyeDioFQ43+NZkXZR1h5
        bWuRytrwUAO1zjAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id A78B6132C1;
        Fri,  1 Apr 2022 15:25:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id XVFOHFYZR2JtGAAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Fri, 01 Apr 2022 15:25:10 +0000
Date:   Fri, 1 Apr 2022 12:25:08 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Tom Talpey <tom@talpey.com>
Cc:     linux-cifs@vger.kernel.org, pshilovsky@samba.org,
        smfrench@gmail.com, pc@cjr.nz
Subject: Re: [PATCH] mount.cifs.rst: add FIPS information
Message-ID: <20220401152508.edovgwz5pxn6gnhn@cyberdelia>
References: <20220331235251.4753-1-ematsumiya@suse.de>
 <efb1d822-4fcf-dc3b-2861-8394f50aedbe@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <efb1d822-4fcf-dc3b-2861-8394f50aedbe@talpey.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On 04/01, Tom Talpey wrote:
>Is SMB2 really FIPS compliant? Even if it is, a server that doesn't
>support anything higher is obviously far out of date.

It's more that the crypto stuff used by SMB1 is *not* compliant.
If SMB2 keeps using FIPS-approved hashing/crypto algorightms, I guess it
makes it FIPS compliant, and the burden is on their end to disqualify
older algorithms for their certification.

> I think it
>would be better to recommend, or maybe even require, SMB3 here.

So, I've added a bit in the SECURITY section saying that mount.cifs
doesn't enforce anything, and all crypto blocking/allowing is made on
the kernel.

Do you think we should? An informed user, with particular requirements,
might want to use SMB2 *and* still be FIPS compliant, but we would be
enforcing something (non-SMB3) that's not quite right.

And if the kernel is not in FIPS mode, we should only inform the user,
because we don't actually use/do any crypto computation in mount.cifs.


Cheers,

Enzo
