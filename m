Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0C665FBAD8
	for <lists+linux-cifs@lfdr.de>; Tue, 11 Oct 2022 20:57:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbiJKS5r (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 11 Oct 2022 14:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230041AbiJKS5f (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 11 Oct 2022 14:57:35 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09785870B2
        for <linux-cifs@vger.kernel.org>; Tue, 11 Oct 2022 11:57:18 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 927DE2275C;
        Tue, 11 Oct 2022 18:57:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1665514637; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WM8z6IDDN1fOoW208a9bjxJ673UKIIxv4HSUSOW5Kzk=;
        b=o9tmCjw+dk8fmYXlJZZBiKphyAz1vKo0GypmmzfQ89oSo7Roie7Di365FTFQWE7R1BZi2D
        vNYSVDVCo0cjO0rVUDR7eMgI7zquMsRh5IOIRxxmjpAUGLP4B0UQMqPCaBUl766PLHVzsY
        +c5Mq4XadBNkB0WqPhVkFwQ8paA8IGo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1665514637;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WM8z6IDDN1fOoW208a9bjxJ673UKIIxv4HSUSOW5Kzk=;
        b=hi4lBrZx9svBc2j7Qa0/gf4/c5TTazvQMpm6mxoR3xLV4amAwmTMLOuX4o34xV2zaabqLk
        dBbfC5Y0+2gIQdDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 1DD86139ED;
        Tue, 11 Oct 2022 18:57:16 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 7lkbN4y8RWPfPQAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Tue, 11 Oct 2022 18:57:16 +0000
Date:   Tue, 11 Oct 2022 15:57:14 -0300
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     Steve French <smfrench@gmail.com>
Cc:     Dmitry Telegin <dmitry.s.telegin@gmail.com>,
        linux-cifs@vger.kernel.org
Subject: Re: A patch to implement the already documented "sep" option for the
 CIFS file system.
Message-ID: <20221011185714.5elxjbut7cvfed6x@suse.de>
References: <CACVrvT5CMERoJN4fz-MdNOOUV9VpOT_vv764UEgzDdaUEC9nUg@mail.gmail.com>
 <CAH2r5muHfRp0yA6G4Z0iJppy7CO_n=EYoZ0__U_iTGUJFOnKpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAH2r5muHfRp0yA6G4Z0iJppy7CO_n=EYoZ0__U_iTGUJFOnKpg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On 10/11, Steve French wrote:
>makes sense.
>
>Did anyone else review this yet?  (the mount.cifs version of the patch)

At a glance, the patch seems ok and solves a real problem.

However, I think a better approach would be to parse the string in user
space, i.e. it's much easier for mount.cifs to fetch what's the
UNC/password string if they're passed quoted (shell handles it), and
then use 0x1E (ASCII Record Separator) instead of a comma.  Then, in
the kernel, we'd only need to strsep() by 0x1E.  Since 0x1E is a
non-printable ASCII character, I have a hard assumption it's not allowed
as UNC/password in most systems.  Also since it would be only used
internally between mount.cifs and cifs.ko, users would not need to know
nor care about it.

Thoughts?


Enzo

>On Sat, Oct 8, 2022 at 2:41 PM Dmitry Telegin
><dmitry.s.telegin@gmail.com> wrote:
>>
>> DESCRIPTION OF THE PROBLEM
>>
>> Some users are accustomed to using shared folders in Windows with a
>> comma in the name, for example: "//server3/Block 3,4".
>> When they try to migrate to Linux, they cannot mount such paths.
>>
>> An example of the line generated by "mount.cifs" for the kernel when
>> mounting "//server3/Block 3,4":
>> "ip=10.0.2.212,unc=\\server3\Block 3,4,iocharset=utf8,user=user1,domain=AD"
>> Accordingly, due to the extra comma, we have an error:
>> "Sep 7 21:57:18 S1 kernel: [ 795.604821] CIFS: Unknown mount option "4""
>>
>>
>> DOCUMENTATION
>>
>> https://www.kernel.org/doc/html/latest/admin-guide/cifs/usage.html
>> The "sep" parameter is described here to specify a new delimiter
>> instead of a comma.
>> I quote:
>>    "sep
>>    if first mount option (after the -o), overrides the comma as the
>> separator between the mount parms. e.g.:
>>    -o user=myname,password=mypassword,domain=mydom
>>    could be passed instead with period as the separator by:
>>    -o sep=.user=myname.password=mypassword.domain=mydom
>>    this might be useful when comma is contained within username or
>> password or domain."
>>
>>
>> RESEARCH WORK
>>
>> I looked at the "mount.cifs" code. There is no provision for the use
>> of a comma by the user, since the comma is used to form the parameter
>> string to the kernel (man 2 mount). This line can be seen by adding
>> the "--verbose" flag to the mount.
>> "mount.cifs --help" lists "sep" as a possible option, but does not
>> implement it in the code and does not describe it in "man 8
>> mount.cifs".
>>
>> I looked at the "pam-mount" code - the mount options are assembled
>> with a wildcard comma. The result is a text line: "mount -t cifs ...".
>>
>> The handling of options in the "mount" utility is based on the
>> "libmount" library, which is hardcoded to use only a comma as a
>> delimiter.
>>
>> I tried to mount "//server3/Block 3,4" with my own program (man 2
>> mount) by specifying "sep=!" - successfully.
>>
>>
>> SOLUTION
>>
>> It would be nice if we add in "mount.cifs", in "mount" utility and in
>> "pam-mount" the ability to set a custom mount option separator. In
>> other words, we need to implement the already documented "sep" option.
>>
>> 1. For "mount.cifs" I did it in:
>> https://github.com/dmitry-telegin/cifs-utils in branch
>> "custom_option_separator". Commit:
>> https://github.com/dmitry-telegin/cifs-utils/commit/04325b842a82edf655a14174e763bc0b2a6870e1
>>
>> 2. For "mount" utility I did it in:
>> https://github.com/dmitry-telegin/util-linux in branch
>> "custom_option_separator". Commit:
>> https://github.com/dmitry-telegin/util-linux/commit/5e0ecd2498edae0bf0bcab4ba6a68a9803b34ccf
>>
>> 3. For "pam-mount" I did it in:
>> https://sourceforge.net/u/dmitry-t/pam-mount/ci/master/tree/ in branch
>> "custom_option_separator". Commit:
>> https://sourceforge.net/u/dmitry-t/pam-mount/ci/9860f9234977f1110230482b5d87bdcb8bc6ce03/
>>
>> I checked the work on the Linux 5.10 kernel.
>>
>> --
>> Dmitry Telegin
>
>
>
>-- 
>Thanks,
>
>Steve
