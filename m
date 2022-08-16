Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC65E5962F0
	for <lists+linux-cifs@lfdr.de>; Tue, 16 Aug 2022 21:14:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231545AbiHPTOr convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-cifs@lfdr.de>); Tue, 16 Aug 2022 15:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231529AbiHPTOq (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 16 Aug 2022 15:14:46 -0400
Received: from smtp.polymtl.ca (smtp.polymtl.ca [132.207.4.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FD75D139
        for <linux-cifs@vger.kernel.org>; Tue, 16 Aug 2022 12:14:45 -0700 (PDT)
Received: from comms3.kousu.ca (comms3.kousu.ca [46.23.90.174])
        by smtp.polymtl.ca (8.14.7/8.14.7) with ESMTP id 27GJEbEV007237
        (version=TLSv1/SSLv3 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 16 Aug 2022 15:14:42 -0400
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp.polymtl.ca 27GJEbEV007237
Received: from comms.kousu.ca (localhost [127.0.0.1])
        by comms3.kousu.ca (OpenSMTPD) with ESMTP id f759d546;
        Tue, 16 Aug 2022 21:14:36 +0200 (CEST)
MIME-Version: 1.0
Date:   Tue, 16 Aug 2022 19:14:36 +0000
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8BIT
X-Mailer: RainLoop/1.16.0
From:   "Nick Guenther" <nick.guenther@polymtl.ca>
Message-ID: <aee6b84aa00466880aa7eb2a82d57680@polymtl.ca>
Subject: Re: [PATCH] pam_cifscreds, tmux and session keyrings
To:     "Nick Guenther" <nick.guenther@polymtl.ca>,
        "CIFS" <linux-cifs@vger.kernel.org>
Cc:     "Shyam Prasad N" <nspmangalore@gmail.com>,
        "Steve French" <smfrench@gmail.com>
In-Reply-To: <57efeb6859dbc2a38714fba882a7635b@polymtl.ca>
References: <57efeb6859dbc2a38714fba882a7635b@polymtl.ca>
 <CAH2r5mu187eVH3pH=Ltzf8ZKaumydYEbMTjz5jxa2BdkoWYoaQ@mail.gmail.com>
 <774233f766bf26976c0d923cc1dc53c7@polymtl.ca>
 <705265ea-37a3-6029-362a-572bbaab6639@gmail.com>
 <0371d16e831be9cd9595c443d142e5fc@polymtl.ca>
X-Poly-FromMTA: (comms3.kousu.ca [46.23.90.174]) at Tue, 16 Aug 2022 19:14:37 +0000
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

August 3, 2022 4:29 PM, "Nick Guenther" <nick.guenther@polymtl.ca> wrote:

> August 1, 2022 12:10 AM, "Steve French" <smfrench@gmail.com> wrote:
> 
>> On Thu, Jul 28, 2022 at 9:50 PM Nick Guenther <nick.guenther@polymtl.ca> wrote:
>>> 
>>> Would there be interest in switching to KEY_SPEC_USER_KEYRING? Would it be a good idea? Can I
>>> assume the kernel CIFS code would need a matching change?
>>
>> Adding Shyam to this discussion - interesting questions worth investigating.
>> 
>
> I've written a patch that switches cifs-utils to KEY_SPEC_USER_KEYRING. It seems to behave --
> `keylist list @u` shows the cifs key instead of `keyctl list @s` -- but it doesn't solve my problem
> without being combined with the 'revoke' workaround, because the kernel is still using
> KEY_SPEC_SESSION_KEYRING.

Hey all,

I'm going to unsubscribe from linux-cifs. It's mostly over my head and not really my interests. But if you find some time to review this patch and find interest in it, please make sure to CC me to keep me in the loop!

Thanks for your consideration!

-Nick
