Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27BE170E1C6
	for <lists+linux-cifs@lfdr.de>; Tue, 23 May 2023 18:29:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233067AbjEWQZi (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 23 May 2023 12:25:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjEWQZh (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 23 May 2023 12:25:37 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C308E5
        for <linux-cifs@vger.kernel.org>; Tue, 23 May 2023 09:25:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-ID:Cc:To:From:Date;
        bh=5mcoNpXcRSaOXDsBNCjRyS67OEGsy3NcToOXqG/IOaA=; b=BoAuYWerklnzYYawx6EtikPD1f
        khfBKewgyuLEu4UJCB+C3wl51DHwTw4q5Qgb6m2+pelzQLXV7vxINBKgsYtNzNTfRzvyQFv4hFJ1A
        5cgNHP2kVGGiCKJRJf9t65KdZOpsabydwpLBtto2PNoMo8eokOmudRBz1ARGdwCQMoteO4r/67W0a
        SozO6B3nPT27ypbbPo0KEOuoI6f9fYC5yE4BNjeGN+v5GD2bulrDDWWg6fUlcD0lC9gs+Dsj6r1kC
        Bv5+dRr0kCcfWQO1H9U22pbTHYzZn2JUznQY3QXECLfZ1rebcYqz+Eg3xtsTO3Ptmka57FOR82FME
        TCasuAazKbgWCLDXaZw9q1T17zjGsa+KXFznTFI2muvu6Az9pMCA7hzDE10hfeBGF2LYErBJ++VYd
        d+9HK6ksp0TrHHWLmP0E8EHfHWZkq4E4ReFxrzO1/zcKJ24TjrG5ZUex1A1Nf2WzJiSXDdONm58Ty
        ddzVoYgqBYXaR2SYX+o2XqGE;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1q1UpJ-00BVB4-5a; Tue, 23 May 2023 16:25:33 +0000
Date:   Tue, 23 May 2023 09:25:28 -0700
From:   Jeremy Allison <jra@samba.org>
To:     ronnie sahlberg <ronniesahlberg@gmail.com>
Cc:     Steve French <smfrench@gmail.com>,
        samba-technical <samba-technical@lists.samba.org>,
        CIFS <linux-cifs@vger.kernel.org>
Subject: Re: Displaying streams as xattrs
Message-ID: <ZGzo+KVlSTNk/B0r@jeremy-rocky-laptop>
Reply-To: Jeremy Allison <jra@samba.org>
References: <CAH2r5mv8nAncg-f=Z5u8LkH4o7kfJLJdtoksYQgiguF7efKZkQ@mail.gmail.com>
 <CAN05THRKq9XPD11rBWXyTL_OGSh4pP6mQyufeW+xc+J3wvkMmw@mail.gmail.com>
 <CAH2r5mtJfSiQXBRUwv6zcR5rhG2Q-pCvjH+n+_SZmVQo1pMeVg@mail.gmail.com>
 <ZGuWhzP98U9Niog+@jeremy-rocky-laptop>
 <CAN05THRnHcZtTMLxUSCYQXULVHiOXVYDU9TRy9K+_wBQQ1CFAw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAN05THRnHcZtTMLxUSCYQXULVHiOXVYDU9TRy9K+_wBQQ1CFAw@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Tue, May 23, 2023 at 10:59:27AM +1000, ronnie sahlberg wrote:

>There are really nice use-cases for ADS where one can store additional
>metadata within the "file" itself.

"Nice" for virus writers, yeah. A complete swamp for everyone
else :-).
