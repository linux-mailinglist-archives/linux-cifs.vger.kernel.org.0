Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24A2B7B21C4
	for <lists+linux-cifs@lfdr.de>; Thu, 28 Sep 2023 17:51:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbjI1Pvk (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 28 Sep 2023 11:51:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231887AbjI1Pvj (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 28 Sep 2023 11:51:39 -0400
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D96CDEB
        for <linux-cifs@vger.kernel.org>; Thu, 28 Sep 2023 08:51:36 -0700 (PDT)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D1FBC433CA
        for <linux-cifs@vger.kernel.org>; Thu, 28 Sep 2023 15:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1695916296;
        bh=nDz6zX2RWRPI+GURb1IJHHICnFqFbrm0CS2X8XOnBug=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=AvFUrfuZCdRrBbmbwZEemkKvIS35Mtf2CO6twRDJvoueVYYqNR6V47QSiriHunbyg
         sgb9ciCi0JJ82lI1wTRgSvIdqUHmvnLxtJitcP1g4felCG9IYlgpDyl4TvQsiSyhsm
         nijIZiFzz9GKOKXyW59oHHjNbGy0T+mG4R1qtJB4Sa53u78F4v7si71PEePoncMuxX
         JErxLrNMg91LfyArSNm7RvwoLjbhvKa1D/rtXftPhy68GRepIdW8un17+TB+u9pZiz
         7iMXFAwx0OR6DQu/bl6uIksDbinaK4cYxtbbYiPSaU4GgOy3QuLtGy+YZj0l9UlaNg
         03WXKvTldSaUw==
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-57b5f0d658dso6535956eaf.0
        for <linux-cifs@vger.kernel.org>; Thu, 28 Sep 2023 08:51:36 -0700 (PDT)
X-Gm-Message-State: AOJu0YyEMcngod9pZyBZ3XP/rEFShFJuCkD/q164Tuj4W2e3bD1FEvCx
        qXjbF0K70ON2ckTqze/OOLpfDlJ28+Qf061x/Jk=
X-Google-Smtp-Source: AGHT+IFCKc5oSMZ3T3lAWuZcKB4/hRuxzQtqNBng98LSzSOk0WK5VYXRqIoXGP+rR5Fj1clmenDH+sjc37jBO1gMM3Y=
X-Received: by 2002:a4a:751d:0:b0:57b:4f1e:96e4 with SMTP id
 j29-20020a4a751d000000b0057b4f1e96e4mr1464259ooc.1.1695916292886; Thu, 28 Sep
 2023 08:51:32 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:4ce:0:b0:4fa:bc5a:10a5 with HTTP; Thu, 28 Sep 2023
 08:51:31 -0700 (PDT)
In-Reply-To: <6f702d13-6473-844a-5873-9c70c909ca8b@talpey.com>
References: <20230927143009.8882-1-linkinjeon@kernel.org> <6f702d13-6473-844a-5873-9c70c909ca8b@talpey.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Fri, 29 Sep 2023 00:51:31 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8T7Rc1wh_aM0wyz7L7Mc-g0AYfbqHfjQ8mBe7fmMmYaQ@mail.gmail.com>
Message-ID: <CAKYAXd8T7Rc1wh_aM0wyz7L7Mc-g0AYfbqHfjQ8mBe7fmMmYaQ@mail.gmail.com>
Subject: Re: [PATCH] ksmbd: not allow to open file if delelete on close bit is set
To:     Tom Talpey <tom@talpey.com>
Cc:     linux-cifs@vger.kernel.org, smfrench@gmail.com,
        senozhatsky@chromium.org, hyc.lee@gmail.com,
        atteh.mailbox@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

2023-09-29 0:23 GMT+09:00, Tom Talpey <tom@talpey.com>:
> On 9/27/2023 10:30 AM, Namjae Jeon wrote:
>> Cthon test fail with the following error.
>>
>> check for proper open/unlink operation
>> nfsjunk files before unlink:
>>    -rwxr-xr-x 1 root root 0  9=EC=9B=94 25 11:03 ./nfs2y8Jm9
>> ./nfs2y8Jm9 open; unlink ret =3D 0
>> nfsjunk files after unlink:
>>    -rwxr-xr-x 1 root root 0  9=EC=9B=94 25 11:03 ./nfs2y8Jm9
>> data compare ok
>> nfsjunk files after close:
>>    ls: cannot access './nfs2y8Jm9': No such file or directory
>> special tests failed
>>
>> Cthon expect to second unlink failure when file is already unlinked.
>> ksmbd can not allow to open file if flags of ksmbd inode is set with
>> S_DEL_ON_CLS flags.
>>
>> Reported-by: Tom Talpey <tom@talpey.com>
>
> I don't remember reporting this.
You told me basic test of cthon run fine but special test fail.
>
> But more fundamentally, the Connectathon test is an NFS exerciser, and
> specific to NFS (and Posix) semantics. Delete-on-last-close is not one
> of them.
>
> Won't failing a new open break Windows semantics if it's enforced by
> default? Normally Windows checks for FILE_SHARE_DELETE before deciding
> this. Maybe other checks as well...
>
> Tom.
>
>> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
>> ---
>>   fs/smb/server/vfs_cache.c | 5 +++++
>>   1 file changed, 5 insertions(+)
>>
>> diff --git a/fs/smb/server/vfs_cache.c b/fs/smb/server/vfs_cache.c
>> index f41f8d6108ce..f2e2a7cc24a9 100644
>> --- a/fs/smb/server/vfs_cache.c
>> +++ b/fs/smb/server/vfs_cache.c
>> @@ -577,6 +577,11 @@ struct ksmbd_file *ksmbd_open_fd(struct ksmbd_work
>> *work, struct file *filp)
>>   		goto err_out;
>>   	}
>>
>> +	if (fp->f_ci->m_flags & S_DEL_ON_CLS) {
>> +		ret =3D -ENOENT;
>> +		goto err_out;
>> +	}
>> +
>>   	ret =3D __open_id(&work->sess->file_table, fp,
>> OPEN_ID_TYPE_VOLATILE_ID);
>>   	if (ret) {
>>   		ksmbd_inode_put(fp->f_ci);
>
