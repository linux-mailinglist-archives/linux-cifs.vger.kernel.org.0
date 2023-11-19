Return-Path: <linux-cifs+bounces-124-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5AF567F06CE
	for <lists+linux-cifs@lfdr.de>; Sun, 19 Nov 2023 15:17:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 16905280D78
	for <lists+linux-cifs@lfdr.de>; Sun, 19 Nov 2023 14:17:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABDFBDDDE;
	Sun, 19 Nov 2023 14:17:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OqQHuhfz"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9130CD51B
	for <linux-cifs@vger.kernel.org>; Sun, 19 Nov 2023 14:17:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0ED30C433CB;
	Sun, 19 Nov 2023 14:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1700403446;
	bh=7NqbVgFEGfY4te5OX45ttPp1nJ/CKMXIyvt1H9KH6XM=;
	h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
	b=OqQHuhfzdyb6alWAFOV5H3faOpoQHYdT998Wq+pFrr7JM8W6HZ6XJYaaLeS3Ds7o6
	 XoJr4j68XyEWX83lYInR0azbEn6Sj74Aw2iLtuAyGy8iu+8BoV7kjnX47gdIu+UNLJ
	 icgTpJgpjuiheenr96VXszcfJtXN8jQuwZfLwNRsudrU0sw0Y1AekIyg+najkuB6LV
	 uDzU2VMoMOXGZuAh+YaFUxg3TKkZ2tLAj0BeV3LDwYopWPfxmvpahAXlmG5i/R/sOY
	 B/pyidSg0y7ladp+YkzLFCOsHDW8lJQp6bRWkKKgEH4kLE5/AgJgc7NAkrnfFW06ZI
	 jpVVld/r3ebaA==
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-589d4033e84so1889536eaf.1;
        Sun, 19 Nov 2023 06:17:26 -0800 (PST)
X-Gm-Message-State: AOJu0YwDCb/ByLkj4MmF1M8Bd5WRYpV9r8MxjB6NXlWz4LW08+s3RSFG
	Toz61Q6+DKKn5Sycryf/8+PX+XKnqLWB1CTLtj0=
X-Google-Smtp-Source: AGHT+IHnTekgrbUxyqPF0IFPLtTVu0RUZzffYNzvpiICZRXMOqwhkSq7GmUVSqIpqZqw3Bo6UPlp/YyksWua1+u2JA0=
X-Received: by 2002:a05:6820:1623:b0:58a:1595:c645 with SMTP id
 bb35-20020a056820162300b0058a1595c645mr4943277oob.4.1700403445255; Sun, 19
 Nov 2023 06:17:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Received: by 2002:ac9:5847:0:b0:507:5de0:116e with HTTP; Sun, 19 Nov 2023
 06:17:24 -0800 (PST)
In-Reply-To: <b503d929-ff3a-4dc3-9de8-aa0eb00d181a@gmail.com>
References: <CAKYAXd8qZTiSBR3aSUk4YRSo+LG-Z20FRJfGgV1Awf+Lep4kpg@mail.gmail.com>
 <20231109011725.1798784-1-min_halo@163.com> <b503d929-ff3a-4dc3-9de8-aa0eb00d181a@gmail.com>
From: Namjae Jeon <linkinjeon@kernel.org>
Date: Sun, 19 Nov 2023 23:17:24 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-2vR7KF=gwKWmA+a3XkAOG78ntPq__u4P5Kqo35N1D5Q@mail.gmail.com>
Message-ID: <CAKYAXd-2vR7KF=gwKWmA+a3XkAOG78ntPq__u4P5Kqo35N1D5Q@mail.gmail.com>
Subject: Re: [PATCH v2] ksmbd: prevent memory leak on error return
To: Pierre Mariani <pierre.mariani@gmail.com>
Cc: Zongmin Zhou <min_halo@163.com>, linux-cifs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, senozhatsky@chromium.org, sfrench@samba.org, 
	tom@talpey.com, kernel test robot <lkp@intel.com>, Dan Carpenter <error27@gmail.com>, 
	Zongmin Zhou <zhouzongmin@kylinos.cn>
Content-Type: text/plain; charset="UTF-8"

2023-11-19 18:14 GMT+09:00, Pierre Mariani <pierre.mariani@gmail.com>:
> On 11/8/2023 5:17 PM, Zongmin Zhou wrote:
>> When allocated memory for 'new' failed,just return
>> will cause memory leak of 'ar'.
>>
>> v2: rollback iov_alloc_cnt when allocate memory failed.
>>
>> Fixes: 1819a9042999 ("ksmbd: reorganize ksmbd_iov_pin_rsp()")
>>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Reported-by: Dan Carpenter <error27@gmail.com>
>> Closes: https://lore.kernel.org/r/202311031837.H3yo7JVl-lkp@intel.com/
>> Signed-off-by: Zongmin Zhou<zhouzongmin@kylinos.cn>
>> ---
>>  fs/smb/server/ksmbd_work.c | 5 ++++-
>>  1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/fs/smb/server/ksmbd_work.c b/fs/smb/server/ksmbd_work.c
>> index a2ed441e837a..44bce4c56daf 100644
>> --- a/fs/smb/server/ksmbd_work.c
>> +++ b/fs/smb/server/ksmbd_work.c
>> @@ -123,8 +123,11 @@ static int __ksmbd_iov_pin_rsp(struct ksmbd_work
>> *work, void *ib, int len,
>>  		new = krealloc(work->iov,
>>  			       sizeof(struct kvec) * work->iov_alloc_cnt,
>>  			       GFP_KERNEL | __GFP_ZERO);
>> -		if (!new)
>> +		if (!new) {
>> +			kfree(ar);
>> +			work->iov_alloc_cnt -= 4;
>>  			return -ENOMEM;
>> +		}
>>  		work->iov = new;
>>  	}
>>
>
> A few lines above, ar is allocated inside the 'if (aux_size)' block.
> If aux_size is falsy, isn't it possible that ar will be NULL hence
> we should have 'if (ar) kfree(ar);'?
We need to initialize ar to NULL on that case. And Passing a NULL
pointer to kfree is safe, So NULL check before kfree() is not needed.

Thanks.
>

