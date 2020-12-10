Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CAAE62D4FFD
	for <lists+linux-cifs@lfdr.de>; Thu, 10 Dec 2020 02:00:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728643AbgLJA7G (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 9 Dec 2020 19:59:06 -0500
Received: from p3plsmtpa09-02.prod.phx3.secureserver.net ([173.201.193.231]:43793
        "EHLO p3plsmtpa09-02.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728218AbgLJA64 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 9 Dec 2020 19:58:56 -0500
Received: from [192.168.0.116] ([71.184.94.153])
        by :SMTPAUTH: with ESMTPSA
        id nAHWkGUv1G3o4nAHWk7Xmu; Wed, 09 Dec 2020 17:58:06 -0700
X-CMAE-Analysis: v=2.4 cv=aKg1FZxm c=1 sm=1 tr=0 ts=5fd1729e
 a=vbvdVb1zh1xTTaY8rfQfKQ==:117 a=vbvdVb1zh1xTTaY8rfQfKQ==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=yMhMjlubAAAA:8 a=pGLkceISAAAA:8
 a=VwQbUJbxAAAA:8 a=1aaORK9rCHh-kRRiZKUA:9 a=QEXdDO2ut3YA:10
 a=5oRCH6oROnRZc2VpWJZ3:22 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH][SMB3.1.1] remove confusing mount warning when no SPNEGO
 info on negprot rsp
To:     Steve French <smfrench@gmail.com>
Cc:     Pavel Shilovsky <piastryyy@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
References: <CAH2r5mvr6JebH9cr9dO-XbiXdsfBjs=C4WhqkqXUwDCmOY20zA@mail.gmail.com>
 <CAKywueRMTMy7shp_qT3Cu6E1EZ0AwdSvjsWF=MU4KQWkw+YL-A@mail.gmail.com>
 <c885d7a2-4f41-d2c0-51ae-43e8ef9cc2d6@talpey.com>
 <CAH2r5mtfAzgh4ojq3XxgmVwbU4YnD42O9=G+FqB9r=AqA=qihQ@mail.gmail.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <16b615a1-d499-381e-88ad-7792d105a646@talpey.com>
Date:   Wed, 9 Dec 2020 19:58:06 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.1
MIME-Version: 1.0
In-Reply-To: <CAH2r5mtfAzgh4ojq3XxgmVwbU4YnD42O9=G+FqB9r=AqA=qihQ@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfAqzMlFVfN4J/9FSqIdKTX/JI/ZA5e98TdwN5HKMvNFFnYvrxolX1P7ku7REIHmSWeQIx9Lq3wZq175C3Gh/2Q366awMnHqyU7mPuf8DPym2GJZyPwQD
 RZ31uQ24LfFIBFD8RS493NDXAeNVQU00Mndg1tWFxgflGnIbzCjzFW3wrmJ2m+PlwlFaXknCWOwy46s5phkpPjke/oJkaIIx+G1OFc8XhxIadWcbtLGyKi7v
 YJPhpPWeEB4Rt90QfEvhZw==
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Except for the typo "wnich", looks fine.

On 12/9/2020 5:49 PM, Steve French wrote:
> Changed the comment in followon to:
> 
> -       /* Make sure that negotiate contexts start after gss security blob */
> +       /*
> +        * if SPNEGO blob present (ie the RFC2478 GSS info which indicates
> +        * wnich security mechanisms the server supports) make sure that
> +        * the negotiate contexts start after it
> +        */
> 
> On Wed, Dec 9, 2020 at 3:26 PM Tom Talpey <tom@talpey.com> wrote:
>>
>> The protocol allows omitting the SPNEGO blob altogether, btw. That
>> leads to the client deciding how to authenticate, although the Windows
>> server doesn't offer that.
>>
>> So I'd suggest removing the comment, too:
>>
>>   >> /* Make sure that negotiate contexts start after gss security blob */
>>
>>
>> On 12/9/2020 12:39 PM, Pavel Shilovsky wrote:
>>> Looks good.
>>>
>>> Reviewed-by: Pavel Shilovsky <pshilov@microsoft.com>
>>>
>>> --
>>> Best regards,
>>> Pavel Shilovsky
>>>
>>> вт, 8 дек. 2020 г. в 23:23, Steve French <smfrench@gmail.com>:
>>>>
>>>> Azure does not send an SPNEGO blob in the negotiate protocol response,
>>>> so we shouldn't assume that it is there when validating the location
>>>> of the first negotiate context.  This avoids the potential confusing
>>>> mount warning:
>>>>
>>>>      CIFS: Invalid negotiate context offset
>>>>
>>>> CC: Stable <stable@vger.kernel.org>
>>>> Signed-off-by: Steve French <stfrench@microsoft.com>
>>>> ---
>>>>    fs/cifs/smb2misc.c | 11 +++++++----
>>>>    1 file changed, 7 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
>>>> index d88e2683626e..513507e4c4ad 100644
>>>> --- a/fs/cifs/smb2misc.c
>>>> +++ b/fs/cifs/smb2misc.c
>>>> @@ -109,11 +109,14 @@ static __u32 get_neg_ctxt_len(struct
>>>> smb2_sync_hdr *hdr, __u32 len,
>>>>
>>>>     /* Make sure that negotiate contexts start after gss security blob */
>>>>     nc_offset = le32_to_cpu(pneg_rsp->NegotiateContextOffset);
>>>> - if (nc_offset < non_ctxlen) {
>>>> - pr_warn_once("Invalid negotiate context offset\n");
>>>> + if (nc_offset + 1 < non_ctxlen) {
>>>> + pr_warn_once("Invalid negotiate context offset %d\n", nc_offset);
>>>>     return 0;
>>>> - }
>>>> - size_of_pad_before_neg_ctxts = nc_offset - non_ctxlen;
>>>> + } else if (nc_offset + 1 == non_ctxlen) {
>>>> + cifs_dbg(FYI, "no SPNEGO security blob in negprot rsp\n");
>>>> + size_of_pad_before_neg_ctxts = 0;
>>>> + } else
>>>> + size_of_pad_before_neg_ctxts = nc_offset - non_ctxlen;
>>>>
>>>>     /* Verify that at least minimal negotiate contexts fit within frame */
>>>>     if (len < nc_offset + (neg_count * sizeof(struct smb2_neg_context))) {
>>>>
>>>> --
>>>> Thanks,
>>>>
>>>> Steve
>>>
> 
> 
> 
