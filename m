Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67409537102
	for <lists+linux-cifs@lfdr.de>; Sun, 29 May 2022 14:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230084AbiE2Mwm (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 29 May 2022 08:52:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229927AbiE2Mwl (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 29 May 2022 08:52:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C2B034B93
        for <linux-cifs@vger.kernel.org>; Sun, 29 May 2022 05:52:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653828759;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1IDqdGLArfr4gn5KVVbwW1OeNRwMY+hK8QbzyH+wdCw=;
        b=h9i5gHJsYkCgAyN11cy0M+mntLK8gFL9DWHgIFxG9+zwrOqJ2Qu6IXnPl9fBU5QGcznNKs
        wJ9mE8Z+bQzfv6gDMo9JB3HF1ZYoAdCBdNkVVpDehbCPqPDwlW+qt2KGQMzeH+KfOeONbx
        nPXUENQDAVFydbc6DbcPUK6jog31Lu4=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-170-gZvuiQt3MZWg_JEeaAxtFA-1; Sun, 29 May 2022 08:52:37 -0400
X-MC-Unique: gZvuiQt3MZWg_JEeaAxtFA-1
Received: by mail-oi1-f197.google.com with SMTP id y126-20020aca4b84000000b0032af02818e0so3020177oia.18
        for <linux-cifs@vger.kernel.org>; Sun, 29 May 2022 05:52:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=1IDqdGLArfr4gn5KVVbwW1OeNRwMY+hK8QbzyH+wdCw=;
        b=7yW5HJQ1sCsDXgFNLktHZ2CQ3k+UaSvFUGdOPZzpUmAKNRWi9VTHhj4scYTs0ZLroG
         w1sGb3wQZyBgyp7uNcc9/aY5UntNoI2RAt8Z2rinQY/fI9cNrJQIPnzbnMcEMBiUGqOq
         5h+UvABlRfL6eigY9O+87eWoe7NTrSzsCcVvH9Wy9fqfMSAQEbmhDSeEz0N7QNdGM9lw
         n24ukHkFn6Stq30tv6Kb3yB0wlq29rViaJZF022ycTgsEpONRAt1k3iUEakt9msBUXhD
         Qj/lb37RMeH8TKI8MZ5KvWcK++pZz5bGoBp7NzaRkL4LrQ0TYAAScJVZpXbpphIlxznt
         RUSg==
X-Gm-Message-State: AOAM5315GzbCg5pCQekGgcoCXsQt3IfeDlgP7OoE9rPuseZ9OTsGR/iQ
        OJN6BAH1r7yX+Dz1BUxIviYCtYAG85oW0WPZfNV399AJ/OVXQhsgY58lguq5jf73EUq2NVCNDa8
        jG4BFrm/2h2eROJjkT5K24A==
X-Received: by 2002:a05:6830:3492:b0:60b:1dda:c407 with SMTP id c18-20020a056830349200b0060b1ddac407mr11626807otu.17.1653828756734;
        Sun, 29 May 2022 05:52:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwCrjXqLqBiMZ7iKG+Mpk3oYrazd+9A6Gf21KYZyX+2mnWUSmy3fnZV9nCvr1+yHWi5tQMvmg==
X-Received: by 2002:a05:6830:3492:b0:60b:1dda:c407 with SMTP id c18-20020a056830349200b0060b1ddac407mr11626799otu.17.1653828756529;
        Sun, 29 May 2022 05:52:36 -0700 (PDT)
Received: from localhost.localdomain (024-205-208-113.res.spectrum.com. [24.205.208.113])
        by smtp.gmail.com with ESMTPSA id ny8-20020a056870be0800b000f303e9538csm1834556oab.30.2022.05.29.05.52.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 29 May 2022 05:52:35 -0700 (PDT)
Subject: Re: [PATCH] cifs: set length when cifs_copy_pages_to_iter is
 successful
To:     Steve French <smfrench@gmail.com>,
        Nick Desaulniers <ndesaulniers@google.com>
Cc:     Steve French <stfrench@microsoft.com>,
        Nathan Chancellor <nathan@kernel.org>,
        David Howells <dhowells@redhat.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        LKML <linux-kernel@vger.kernel.org>, llvm@lists.linux.dev,
        Steve French <sfrench@samba.org>
References: <20220526140226.2648689-1-trix@redhat.com>
 <CAKwvOdmPZXiMZRKyMfZVMmw-95XVocSZn3VVi3yJh0Bx1ONbJQ@mail.gmail.com>
 <CAH2r5mumSyxP8XUJjKwv9exh__NkCtG2HSiO-USqGo_7ZTb0yQ@mail.gmail.com>
From:   Tom Rix <trix@redhat.com>
Message-ID: <3144155d-47c7-ccfd-ff52-e3fa4e0468ee@redhat.com>
Date:   Sun, 29 May 2022 05:52:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <CAH2r5mumSyxP8XUJjKwv9exh__NkCtG2HSiO-USqGo_7ZTb0yQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org


On 5/28/22 4:31 PM, Steve French wrote:
> Presumably this was in Dave Howell's patch set which we took out of
> for-next to restructure in some of Al's feedback and some things found
> during testing. So nothing to fix in current mainline or for-next ...
> right?

Yup. Nothing to fix.

So drop this patch.

Tom

>
> On Sat, May 28, 2022 at 3:40 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
>> + Steve's @microsoft.com email addr.
>>
>> On Thu, May 26, 2022 at 7:02 AM Tom Rix <trix@redhat.com> wrote:
>>> clang build fails with
>>> fs/cifs/smb2ops.c:4984:7: error: variable 'length' is used uninitialized whenever 'if' condition is false [-Werror,-Wsometimes-uninitialized]
>>>    if (rdata->result != 0) {
>>>        ^~~~~~~~~~~~~~~~~~
>>>
>>> handle_read_data() returns the number of bytes handled by setting the length variable.
>>> This only happens in the copy_to_iter() branch, it needs to also happen in the
>>> cifs_copy_pages_to_iter() branch.  When cifs_copy_pages_to_iter() is successful,
>>> its parameter data_len is how many bytes were handled, so set length to data_len.
>>>
>>> Fixes: 67fd8cff2b0f ("cifs: Change the I/O paths to use an iterator rather than a page list")
>>> Signed-off-by: Tom Rix <trix@redhat.com>
>>> ---
>>>   fs/cifs/smb2ops.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
>>> index 3630e132781f..bfad482ec186 100644
>>> --- a/fs/cifs/smb2ops.c
>>> +++ b/fs/cifs/smb2ops.c
>>> @@ -4988,7 +4988,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
>>>                                  dequeue_mid(mid, rdata->result);
>>>                          return 0;
>>>                  }
>>> -               rdata->got_bytes = pages_len;
>>> +               length = rdata->got_bytes = pages_len;
>>>
>>>          } else if (buf_len >= data_offset + data_len) {
>>>                  /* read response payload is in buf */
>>> --
>>> 2.27.0
>>>
>>
>> --
>> Thanks,
>> ~Nick Desaulniers
>
>

