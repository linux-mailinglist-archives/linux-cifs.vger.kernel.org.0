Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFC5D54B648
	for <lists+linux-cifs@lfdr.de>; Tue, 14 Jun 2022 18:35:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243232AbiFNQbi (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 14 Jun 2022 12:31:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243064AbiFNQbg (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 14 Jun 2022 12:31:36 -0400
Received: from out03.mta.xmission.com (out03.mta.xmission.com [166.70.13.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D82443C9;
        Tue, 14 Jun 2022 09:31:35 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:56828)
        by out03.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o19S2-00AmWn-9i; Tue, 14 Jun 2022 10:31:34 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:40454 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1o19S0-009rSu-TN; Tue, 14 Jun 2022 10:31:33 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Frederick Lawler <fred@cloudflare.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        keyrings@vger.kernel.org, selinux@vger.kernel.org,
        serge@hallyn.com, amir73il@gmail.com, kernel-team@cloudflare.com,
        Jeff Moyer <jmoyer@redhat.com>,
        Paul Moore <paul@paul-moore.com>
References: <20220608150942.776446-1-fred@cloudflare.com>
        <87tu8oze94.fsf@email.froward.int.ebiederm.org>
        <e1b62234-9b8a-e7c2-2946-5ef9f6f23a08@cloudflare.com>
        <87y1xzyhub.fsf@email.froward.int.ebiederm.org>
        <859cb593-9e96-5846-2191-6613677b07c5@cloudflare.com>
Date:   Tue, 14 Jun 2022 11:30:54 -0500
In-Reply-To: <859cb593-9e96-5846-2191-6613677b07c5@cloudflare.com> (Frederick
        Lawler's message of "Tue, 14 Jun 2022 11:06:24 -0500")
Message-ID: <87o7yvxl4x.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1o19S0-009rSu-TN;;;mid=<87o7yvxl4x.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=softfail
X-XM-AID: U2FsdGVkX19OwrPXsW8XkXxckntCYt4oo3aNKl7qziA=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa04 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *****;Frederick Lawler <fred@cloudflare.com>
X-Spam-Relay-Country: 
X-Spam-Timing: total 748 ms - load_scoreonly_sql: 0.04 (0.0%),
        signal_user_changed: 10 (1.3%), b_tie_ro: 9 (1.2%), parse: 0.81 (0.1%),
         extract_message_metadata: 10 (1.4%), get_uri_detail_list: 2.1 (0.3%),
        tests_pri_-1000: 18 (2.4%), tests_pri_-950: 1.02 (0.1%),
        tests_pri_-900: 0.85 (0.1%), tests_pri_-90: 303 (40.5%), check_bayes:
        299 (39.9%), b_tokenize: 8 (1.1%), b_tok_get_all: 11 (1.5%),
        b_comp_prob: 2.8 (0.4%), b_tok_touch_all: 271 (36.3%), b_finish: 1.36
        (0.2%), tests_pri_0: 387 (51.7%), check_dkim_signature: 0.80 (0.1%),
        check_dkim_adsp: 2.9 (0.4%), poll_dns_idle: 0.91 (0.1%), tests_pri_10:
        3.9 (0.5%), tests_pri_500: 11 (1.5%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v3] cred: Propagate security_prepare_creds() error code
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Frederick Lawler <fred@cloudflare.com> writes:

> On 6/13/22 11:44 PM, Eric W. Biederman wrote:
>> Frederick Lawler <fred@cloudflare.com> writes:
>> 
>>> Hi Eric,
>>>
>>> On 6/13/22 12:04 PM, Eric W. Biederman wrote:
>>>> Frederick Lawler <fred@cloudflare.com> writes:
>>>>
>>>>> While experimenting with the security_prepare_creds() LSM hook, we
>>>>> noticed that our EPERM error code was not propagated up the callstack.
>>>>> Instead ENOMEM is always returned.  As a result, some tools may send a
>>>>> confusing error message to the user:
>>>>>
>>>>> $ unshare -rU
>>>>> unshare: unshare failed: Cannot allocate memory
>>>>>
>>>>> A user would think that the system didn't have enough memory, when
>>>>> instead the action was denied.
>>>>>
>>>>> This problem occurs because prepare_creds() and prepare_kernel_cred()
>>>>> return NULL when security_prepare_creds() returns an error code. Later,
>>>>> functions calling prepare_creds() and prepare_kernel_cred() return
>>>>> ENOMEM because they assume that a NULL meant there was no memory
>>>>> allocated.
>>>>>
>>>>> Fix this by propagating an error code from security_prepare_creds() up
>>>>> the callstack.
>>>> Why would it make sense for security_prepare_creds to return an error
>>>> code other than ENOMEM?
>>>>   > That seems a bit of a violation of what that function is supposed to do
>>>>
>>>
>>> The API allows LSM authors to decide what error code is returned from the
>>> cred_prepare hook. security_task_alloc() is a similar hook, and has its return
>>> code propagated.
>> It is not an api.  It is an implementation detail of the linux kernel.
>> It is a set of convenient functions that do a job.
>> The general rule is we don't support cases without an in-tree user.  I
>> don't see an in-tree user.
>> 
>>> I'm proposing we follow security_task_allocs() pattern, and add visibility for
>>> failure cases in prepare_creds().
>> I am asking why we would want to.  Especially as it is not an API, and I
>> don't see any good reason for anything but an -ENOMEM failure to be
>> supported.
>>
> We're writing a LSM BPF policy, and not a new LSM. Our policy aims to solve
> unprivileged unshare, similar to Debian's patch [1]. We're in a position such
> that we can't use that patch because we can't block _all_ of our applications
> from performing an unshare. We prefer a granular approach. LSM BPF seems like a
> good choice.

I am quite puzzled why doesn't /proc/sys/user/max_user_namespaces work
for you?

> Because LSM BPF exposes these hooks, we should probably treat them as an
> API. From that perspective, userspace expects unshare to return a EPERM 
> when the call is denied permissions.

The BPF code gets to be treated as a out of tree kernel module.

>> Without an in-tree user that cares it is probably better to go the
>> opposite direction and remove the possibility of return anything but
>> memory allocation failure.  That will make it clearer to implementors
>> that a general error code is not supported and this is not a location
>> to implement policy, this is only a hook to allocate state for the LSM.
>> 
>
> That's a good point, and it's possible we're using the wrong hook for the
> policy. Do you know of other hooks we can look into?

Not off the top of my head.

>>>> I have probably missed a very interesting discussion where that was
>>>> mentioned but I don't see link to the discussion or anything explaining
>>>> why we want to do that in this change.
>>>>
>>>
>>> AFAIK, this is the start of the discussion.
>> You were on v3 and had an out of tree piece of code so I assumed someone
>> had at least thought about why you want to implement policy in a piece
>> of code whose only purpose is to allocate memory to store state.
>> 
>
> No worries.
>
>> Eric
>> 
>> 
>
> Links:
> 1:
> https://sources.debian.org/patches/linux/3.16.56-1+deb8u1/debian/add-sysctl-to-disallow-unprivileged-CLONE_NEWUSER-by-default.patch/

Eric
