Return-Path: <linux-cifs+bounces-5423-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6ABD1B16517
	for <lists+linux-cifs@lfdr.de>; Wed, 30 Jul 2025 19:00:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 39FDA7AB445
	for <lists+linux-cifs@lfdr.de>; Wed, 30 Jul 2025 16:58:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E26FB2DE6F7;
	Wed, 30 Jul 2025 17:00:08 +0000 (UTC)
X-Original-To: linux-cifs@vger.kernel.org
Received: from air.basealt.ru (air.basealt.ru [193.43.8.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD6B42DE6F8
	for <linux-cifs@vger.kernel.org>; Wed, 30 Jul 2025 17:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.43.8.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753894808; cv=none; b=BajFrE8PhjxTA2eZhW43/NvCcZ0VtEjrasZlv4JN873icbSN/ALf5hfyuYmwSJJpzoktfZw87PKOmL9PB/9nDB5V/rf3DInNCpdA6Jq78Cv0urM/PVy4Mkh/w9iZZ3ZfhBIFxR3+DFwmxxy4bdnGFUDtA2Mo7tqhSpGVO0c495I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753894808; c=relaxed/simple;
	bh=eRhryR1/LXlZ4ljfgKbvbEjuS3p0g1YphlJZCkehUUo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qjvH21U751/HmF+GtXxiHUVUPe1fXCA5BVifmZdI5hOFAL9TjOaHcVUPcKREimt39XTxfbF9Ou0OmKrz8QdKaIkpI6T0yLRpY4JDlBpge23BrRxZtKa5Xt4UciwjmzuIP/DAZEefn+iMiq926y6SnU1tIpKxjp3wG48VqIihYYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org; spf=pass smtp.mailfrom=altlinux.org; arc=none smtp.client-ip=193.43.8.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=altlinux.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=altlinux.org
Received: from [10.64.128.185] (unknown [193.43.9.250])
	(Authenticated sender: alekseevamo)
	by air.basealt.ru (Postfix) with ESMTPSA id 5F90123372;
	Wed, 30 Jul 2025 19:54:21 +0300 (MSK)
Message-ID: <8f2ad82d-0dd4-4195-b414-59f25f859a9e@altlinux.org>
Date: Wed, 30 Jul 2025 20:54:20 +0400
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: alxvmr@altlinux.org
Subject: Re: [PATCH] fs/smb/client/fs_context: Add hostname option for CIFS
 module to work with domain-based dfs resources with Kerberos authentication
To: Steve French <smfrench@gmail.com>
Cc: pc@manguebit.com, linux-cifs@vger.kernel.org,
 Ivan Volchenko <ivolchenko86@gmail.com>, samba-technical@lists.samba.org,
 Vitaly Chikunov <vt@altlinux.org>, Tom Talpey <tom@talpey.com>
References: <20250516152201.201385-1-alxvmr@altlinux.org>
 <43os6kphihnry2wggqykiwmusz@pony.office.basealt.ru>
 <3d3160fd-e29d-495d-a02e-e28558cfec1a@altlinux.org>
 <CAH2r5mtG5pwFMRtu3EeXKPBdq0LJwjt84SbGtL0J4QuCg+AsgQ@mail.gmail.com>
 <CAH2r5msnTMCHJ9kZmFWCbUUUnejOLv8mzGussaidc3yj3nk+qQ@mail.gmail.com>
Content-Language: en-US, ru
From: Maria Alexeeva <alxvmr@altlinux.org>
In-Reply-To: <CAH2r5msnTMCHJ9kZmFWCbUUUnejOLv8mzGussaidc3yj3nk+qQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Steve,
It seems some of the discussion with review comments fell outside this
thread (I can only find vt@altlinux.org Vitaly Chikunov's remarks).
Could you please point me to where the rest of the feedback can be
found (e.g., about fixing the noisy warning the patch adds and
other comments)?

An updated patch for fs/smb/client/fs_context has been prepared, renaming
the option to dfs_domain_hostname. There's suggestion to further rename
it to dfs_server_hostname - what are your thoughts on this?

The patches will follow in subsequent messages.

Thanks!

On 7/25/25 02:50, Steve French via samba-technical wrote:
> Maria,
> Since this looks like it depends on a cifs-utils change, can you
> update your kernel patch with review comments (e.g. changing mount
> parm to "dfs_domain_hostname", and there were at least two others in
> the thread, e.g. fixing the noisy warning that the patch adds) and
> then show the cifs-utils change, so we can make the upcoming merge
> window.
> 
> On Thu, Jul 24, 2025 at 5:14 PM Steve French <smfrench@gmail.com> wrote:
>>
>> I will update the mount parm name, similar to what Tom suggested to
>> "dfs_domain_hostname" to be less confusing.
>>
>> Let me know if you had a v2 of the patch with other changes
>>
>> On Thu, Jul 3, 2025 at 8:00 AM Maria Alexeeva via samba-technical
>> <samba-technical@lists.samba.org> wrote:
>>>
>>> On 6/14/25 07:42, Vitaly Chikunov wrote:
>>>> Maria,
>>>>
>>>> On Fri, May 16, 2025 at 07:22:01PM +0400, Maria Alexeeva wrote:
>>>>> Paths to domain-based dfs resources are defined using the domain name
>>>>> of the server in the format:
>>>>> \\DOMAIN.NAME>\<dfsroot>\<path>
>>>>>
>>>>> The CIFS module, when requesting a TGS, uses the server name
>>>>> (<DOMAIN.NAME>) it obtained from the UNC for the initial connection.
>>>>> It then composes an SPN that does not match any entities
>>>>> in the domain because it is the domain name itself.
>>>> For a casual reader like me it's hard to understand (this abbreviation
>>>> filled message) what it's all about. And why we can't just change system
>>>> hostname for example.
>>>
>>> This option is needed to transfer the real name of the server to which
>>> the connection is taking place,
>>> when using the UNC path in the form of domain-based DFS. The system
>>> hostname has nothing to do with it.
>>>
>>>> Also, the summary (subject) message is 180 character which is way above
>>>> 75 characters suggested in submitting-patches.rst.
>>>>
>>>>> To eliminate this behavior, a hostname option is added, which is
>>>>> the name of the server to connect to and is used in composing the SPN.
>>>>> In the future this option will be used in the cifs-utils development.
>>>>>
>>>>> Suggested-by: Ivan Volchenko <ivolchenko86@gmail.com>
>>>>> Signed-off-by: Maria Alexeeva <alxvmr@altlinux.org>
>>>>> ---
>>>>>    fs/smb/client/fs_context.c | 35 +++++++++++++++++++++++++++++------
>>>>>    fs/smb/client/fs_context.h |  3 +++
>>>>>    2 files changed, 32 insertions(+), 6 deletions(-)
>>>>>
>>>>> diff --git a/fs/smb/client/fs_context.c b/fs/smb/client/fs_context.c
>>>>> index a634a34d4086..74de0a9de664 100644
>>>>> --- a/fs/smb/client/fs_context.c
>>>>> +++ b/fs/smb/client/fs_context.c
>>>>> @@ -177,6 +177,7 @@ const struct fs_parameter_spec smb3_fs_parameters[] = {
>>>>>       fsparam_string("password2", Opt_pass2),
>>>>>       fsparam_string("ip", Opt_ip),
>>>>>       fsparam_string("addr", Opt_ip),
>>>>> +    fsparam_string("hostname", Opt_hostname),
>>>>>       fsparam_string("domain", Opt_domain),
>>>>>       fsparam_string("dom", Opt_domain),
>>>>>       fsparam_string("srcaddr", Opt_srcaddr),
>>>>> @@ -825,16 +826,23 @@ static int smb3_fs_context_validate(struct fs_context *fc)
>>>>>               return -ENOENT;
>>>>>       }
>>>>>
>>>>> +    if (ctx->got_opt_hostname) {
>>>>> +            kfree(ctx->server_hostname);
>>>>> +            ctx->server_hostname = ctx->opt_hostname;
>>>> I am not familiar with the smb codebase but are you sure this will not
>>>> cause a race?
>>>
>>> The race condition will not occur.
>>> ctx->server_hostname is also used in smb3_parse_devname inside
>>> smb3_fs_context_parse_param.
>>> smb3_fs_context_parse_param is called earlier than the updated
>>> smb3_fs_context_validate, which is called inside smb3_get_tree:
>>>
>>> static const struct fs_context_operations smb3_fs_context_ops = {
>>>    .free   = smb3_fs_context_free,
>>>    .parse_param  = smb3_fs_context_parse_param,
>>>    .parse_monolithic = smb3_fs_context_parse_monolithic,
>>>    .get_tree  = smb3_get_tree,
>>>    .reconfigure  = smb3_reconfigure,
>>> };
>>>
>>>>> +            pr_notice("changing server hostname to name provided in hostname= option\n");
>>>>> +    }
>>>>> +
>>>>>       if (!ctx->got_ip) {
>>>>>               int len;
>>>>> -            const char *slash;
>>>>>
>>>>> -            /* No ip= option specified? Try to get it from UNC */
>>>>> -            /* Use the address part of the UNC. */
>>>>> -            slash = strchr(&ctx->UNC[2], '\\');
>>>>> -            len = slash - &ctx->UNC[2];
>>>>> +            /*
>>>>> +             * No ip= option specified? Try to get it from server_hostname
>>>>> +             * Use the address part of the UNC parsed into server_hostname
>>>>> +             * or hostname= option if specified.
>>>>> +             */
>>>>> +            len = strlen(ctx->server_hostname);
>>>>>               if (!cifs_convert_address((struct sockaddr *)&ctx->dstaddr,
>>>>> -                                      &ctx->UNC[2], len)) {
>>>>> +                                      ctx->server_hostname, len)) {
>>>>>                       pr_err("Unable to determine destination address\n");
>>>>>                       return -EHOSTUNREACH;
>>>>>               }
>>>>> @@ -1518,6 +1526,21 @@ static int smb3_fs_context_parse_param(struct fs_context *fc,
>>>>>               }
>>>>>               ctx->got_ip = true;
>>>>>               break;
>>>>> +    case Opt_hostname:
>>>>> +            if (strnlen(param->string, CIFS_NI_MAXHOST) == CIFS_NI_MAXHOST) {
>>>>> +                    pr_warn("host name too long\n");
>>>>> +                    goto cifs_parse_mount_err;
>>>>> +            }
>>>>> +
>>>>> +            kfree(ctx->opt_hostname);
>>>>> +            ctx->opt_hostname = kstrdup(param->string, GFP_KERNEL);
>>>>> +            if (ctx->opt_hostname == NULL) {
>>>>> +                    cifs_errorf(fc, "OOM when copying hostname string\n");
>>>>> +                    goto cifs_parse_mount_err;
>>>>> +            }
>>>>> +            cifs_dbg(FYI, "Host name set\n");
>>>>> +            ctx->got_opt_hostname = true;
>>>>> +            break;
>>>>>       case Opt_domain:
>>>>>               if (strnlen(param->string, CIFS_MAX_DOMAINNAME_LEN)
>>>>>                               == CIFS_MAX_DOMAINNAME_LEN) {
>>>>> diff --git a/fs/smb/client/fs_context.h b/fs/smb/client/fs_context.h
>>>>> index 9e83302ce4b8..cf0478b1eff9 100644
>>>>> --- a/fs/smb/client/fs_context.h
>>>>> +++ b/fs/smb/client/fs_context.h
>>>>> @@ -184,6 +184,7 @@ enum cifs_param {
>>>>>       Opt_pass,
>>>>>       Opt_pass2,
>>>>>       Opt_ip,
>>>>> +    Opt_hostname,
>>>>>       Opt_domain,
>>>>>       Opt_srcaddr,
>>>>>       Opt_iocharset,
>>>>> @@ -214,6 +215,7 @@ struct smb3_fs_context {
>>>>>       bool gid_specified;
>>>>>       bool sloppy;
>>>>>       bool got_ip;
>>>>> +    bool got_opt_hostname;
>>>>>       bool got_version;
>>>>>       bool got_rsize;
>>>>>       bool got_wsize;
>>>>> @@ -226,6 +228,7 @@ struct smb3_fs_context {
>>>>>       char *domainname;
>>>>>       char *source;
>>>>>       char *server_hostname;
>>>>> +    char *opt_hostname;
>>>> Perhaps, smb3_fs_context_dup and smb3_cleanup_fs_context_contents should
>>>> be aware of these new fields too.
>>>
>>> smb3_cleanup_fs_context_contents should be aware of these new fields too.
>>>
>>> Clearing in smb3_cleanup_fs_context_contents is not necessary, because
>>> if opt_hostname != NULL,
>>> then the pointer in server_hostname is replaced (it is pre-cleared by
>>> kfree), respectively, everything
>>> will be cleared by itself with the current code.
>>>
>>> In smb3_fs_context_dup, opt_hostname does not need to be processed,
>>> since this variable is
>>> essentially temporary. Immediately after parsing with the parameter, its
>>> value goes to
>>> server_hostname and it is no longer needed by itself.
>>>
>>>> Thanks,
>>>>
>>>>>       char *UNC;
>>>>>       char *nodename;
>>>>>       char workstation_name[CIFS_MAX_WORKSTATION_LEN];
>>>>>
>>>>> base-commit: bec6f00f120ea68ba584def5b7416287e7dd29a7
>>>>> --
>>>>> 2.42.2
>>>>>
>>>
>>> Apologies for the overly long subject line and unclear description.
>>> Thanks.
>>>
>>
>>
>> --
>> Thanks,
>>
>> Steve
> 
> 
> 


