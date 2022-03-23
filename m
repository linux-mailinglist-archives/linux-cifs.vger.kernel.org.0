Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 644174E5780
	for <lists+linux-cifs@lfdr.de>; Wed, 23 Mar 2022 18:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343599AbiCWRav (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 23 Mar 2022 13:30:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343573AbiCWRau (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 23 Mar 2022 13:30:50 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB2F2AB
        for <linux-cifs@vger.kernel.org>; Wed, 23 Mar 2022 10:29:20 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 77BA7210F2;
        Wed, 23 Mar 2022 17:29:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1648056559; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AHzoRkdZ9DkeqlqLLClJe2hiyc9kFW7w3+leG3o3sS0=;
        b=NIiCU+1EniCjCXMObV7y7nyZZXeLf8AlinwI/2XT6X/ShJbcYgrGTIyn/kgyJ3vp6K4ANr
        9vEEVIKrHGd/ppxFef2hZh4EJb7Zu0PDZCbV3wY3hhsIiZDVv9C1smTfA3S0sbvrKZJYBM
        CV9JpFGyTIVbj9G1izwmioon2N33n4U=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1648056559;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AHzoRkdZ9DkeqlqLLClJe2hiyc9kFW7w3+leG3o3sS0=;
        b=WZ4Br85JnJgZ7zjkfXbkPXRLCy8L/7a5qxWZzjQP+/ghVGS9Q8mGuods7gGIR1ndVtbwTP
        cHfesVrbzi/z3EAA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 0753813302;
        Wed, 23 Mar 2022 17:29:18 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id fBn1MO5YO2LxIgAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Wed, 23 Mar 2022 17:29:18 +0000
Date:   Wed, 23 Mar 2022 14:29:13 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Tom Talpey <tom@talpey.com>
Cc:     samba-technical@lists.samba.org, linux-cifs@vger.kernel.org,
        smfrench@gmail.com
Subject: Re: Signature check for LOGOFF response
Message-ID: <20220323172913.56cr2atzfcunv5kf@cyberdelia>
References: <20220319032012.46ezg2pxjlrsdlpq@cyberdelia>
 <a0972fb5-38d3-5990-7c8e-0b7dd61d1abb@talpey.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <a0972fb5-38d3-5990-7c8e-0b7dd61d1abb@talpey.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi Tom,

On 03/19, Tom Talpey wrote:
>What server is returning this unsigned response? Assuming it's Windows,
>that is either a doc bug or (arguably) a server bug, and should be
>reported before deciding how to address it here.

It's a NetApp ONTAP 9.5P13. We've identified it's also setting wrong
signatures on READ responses with STATUS_END_OF_FILE.

Our tests against Windows Server 2019 showed it to behave ok, so it
looks like something on NetApp side.

Thanks anyway.


Enzo
