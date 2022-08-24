Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24E5D59F311
	for <lists+linux-cifs@lfdr.de>; Wed, 24 Aug 2022 07:32:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229446AbiHXFcL (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 24 Aug 2022 01:32:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230441AbiHXFcK (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 24 Aug 2022 01:32:10 -0400
Received: from mail-ua1-x92a.google.com (mail-ua1-x92a.google.com [IPv6:2607:f8b0:4864:20::92a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D86257963C
        for <linux-cifs@vger.kernel.org>; Tue, 23 Aug 2022 22:32:09 -0700 (PDT)
Received: by mail-ua1-x92a.google.com with SMTP id z23so4786774uap.10
        for <linux-cifs@vger.kernel.org>; Tue, 23 Aug 2022 22:32:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=MuqTpPvrmg/Z4QBeI+7seUNE0dWfQYJptx0c+iLO9Qc=;
        b=eUYxEUTduqnxFhB/4NCIUxr8zH6TAwrBa0/DweQa0PpKbMgaKiLCQFfLpQ4fpQWIzF
         LDUU2SV0+Zsr4I5F7AmKK/+6hNsUBAhOENLk2PZf9+eB7v+ECrEK16uIlZXFLc6M5nMz
         dvbo7EMgwedU3UNMsrr2u7O0u1FJNcbDf+BVSD6snWyOvxv7LrXPKzRkQ2ZICBR32A4G
         W1VnVS0T1Nua+PzwbLQaSHJ3beyxzkTb/sgAWBfE9bF75hETyyDqjoYJPi+xtGAIA+x6
         v9OJRWUuh5o9G8JuWw9KGOYFZkPzjNdm+MCNEWOslPyp/lf1/OCmr7pndfWsHjI0LRap
         5fGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=MuqTpPvrmg/Z4QBeI+7seUNE0dWfQYJptx0c+iLO9Qc=;
        b=gZKHS6QutL3A+auDv72XDCt+n6/d62TF5m99JsQ8j4OJ7N9dfEl6z//2GxRc/1KV5A
         aOf0blvZmFmJvTD+aYUqEjHT6OmfcMgyurdovtRdyr1Dw475IuKsg3y+gGZ6PpQenFdZ
         fIoJDDleJMzR+sSubjhnvOWtAshsGU7873jRmgGSc5LjDph2pKMLD+DAmuL8Z0OArqjQ
         MgpGkc33TNZuShkGa7t1MDDtlBspeHighUP34YRqBtkswhzPbEAZlcz7E5xyRxHsA8PF
         +pZVLh/Oz6m6zPYz6PYH7pwfPAT+R6z3rMYDWWlsPZW24gx9ju8HBw5utm53wUuvPUv6
         CQjA==
X-Gm-Message-State: ACgBeo2OKQZ9Mo8lxgiWbMFw8hnCBQLI/mMPbU1jezDmOZA0f2dao5LI
        ds+TOED7wW+J+pf0LJZTGfoI57I7kC6lUXeRnA6T6UY60Eg=
X-Google-Smtp-Source: AA6agR5SrO/WJWvc96IWCUgOrfCJdW13pE/IF5NEk+6yDyHkKeZnzfdAUUd+5B5ahK4QxG7JchmEmyApM1TlsNWPVF8=
X-Received: by 2002:ab0:3bc6:0:b0:381:c4db:ef5 with SMTP id
 q6-20020ab03bc6000000b00381c4db0ef5mr11427212uaw.81.1661319128913; Tue, 23
 Aug 2022 22:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20220823142531.9057-1-ematsumiya@suse.de> <8735dmj1kj.fsf@cjr.nz>
In-Reply-To: <8735dmj1kj.fsf@cjr.nz>
From:   Steve French <smfrench@gmail.com>
Date:   Wed, 24 Aug 2022 00:31:58 -0500
Message-ID: <CAH2r5mte6uibVvRomxnX7FuPZ8VPcrF2iNBUtS=qQWRZSkCN_g@mail.gmail.com>
Subject: Re: [PATCH] cifs: fix some memory leak when negotiate/session setup fails
To:     Paulo Alcantara <pc@cjr.nz>
Cc:     Enzo Matsumiya <ematsumiya@suse.de>,
        CIFS <linux-cifs@vger.kernel.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

It does look like the first of these may fix a real leak

setup_ntlmv2_rsp when called from CIFS_SessSetup doesn't seem to free
ses->domainName

sesInfoFree does free it but it is not clear whether in all paths
sesInfoFree is called, but of course if it isn't called we have a much
worse leak.

Can you doublecheck about the memleak details.

On Tue, Aug 23, 2022 at 12:45 PM Paulo Alcantara <pc@cjr.nz> wrote:
>
> Enzo Matsumiya <ematsumiya@suse.de> writes:
>
> >
> > Fix memory leaks from some ses fields when cifs_negotiate_protocol() or
> > cifs_setup_session() fails in cifs_get_smb_ses().
> >
> > A leak from ses->domainName has also been identified in setup_ntlmv2_rsp()
> > when session setup fails.
>
> Those fields are already freed by sesInfoFree().
>
> > These has been reported by kmemleak.
>
> Could you please include the report in commit message?



-- 
Thanks,

Steve
