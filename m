Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 725B55BB99D
	for <lists+linux-cifs@lfdr.de>; Sat, 17 Sep 2022 18:52:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229586AbiIQQwk (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 17 Sep 2022 12:52:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIQQwi (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 17 Sep 2022 12:52:38 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB6C2B620
        for <linux-cifs@vger.kernel.org>; Sat, 17 Sep 2022 09:52:38 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id EB9B922D0B;
        Sat, 17 Sep 2022 16:52:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663433556; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qzw60mwYIZcv5F80LTLO++xXCKfWItIsKHT1CVly7Y4=;
        b=RBhMCtvhRuwlVAlAx03PcaWHruZb8/iVvrXrY4rcE4/DJQ9rhvNnBO4qNJrL1MUzh8TUlI
        egBfcjDzHoKGc0zWbTgpn03fsbJzq4eNZwuiHSj2LVfDFicMjMH87LIiwgnmuey2TmiUBi
        VINbpBjMvSxaWIh8lLaAeEnLRNh5QB0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663433556;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Qzw60mwYIZcv5F80LTLO++xXCKfWItIsKHT1CVly7Y4=;
        b=nVMLxgam3yLKDG8+WEOTkNmit7JpP/8v87/vMQBiU6C3v1utP2NAwp4F/xhbHluMReIiRK
        JY/DPVtCJYGTgeDg==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 6F82713A49;
        Sat, 17 Sep 2022 16:52:36 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id oG/QDFT7JWOyNQAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Sat, 17 Sep 2022 16:52:36 +0000
Date:   Sat, 17 Sep 2022 13:52:33 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Tom Talpey <tom@talpey.com>
Cc:     linux-cifs@vger.kernel.org, smfrench@gmail.com, pc@cjr.nz,
        ronniesahlberg@gmail.com, nspmangalore@gmail.com
Subject: Re: [PATCH] cifs: verify signature only for valid responses
Message-ID: <20220917165233.4t5ygihmnxr5zwck@suse.de>
References: <20220917020704.25181-1-ematsumiya@suse.de>
 <bf09670b-df76-7fcc-2c8c-8b049f82d41b@talpey.com>
 <20220917162827.g3c32bh62maw7da3@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20220917162827.g3c32bh62maw7da3@suse.de>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On 09/17, Enzo Matsumiya wrote:
> So, even if 
>server->ignore_signature is false (default),

Erm server->ignore_signature is checked in smb2_verify_signature()
(obviously I was aware) and rc would be 0. I need coffee...

But I stand by the rest of the argument.


Enzo
