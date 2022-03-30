Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9A04ED02F
	for <lists+linux-cifs@lfdr.de>; Thu, 31 Mar 2022 01:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiC3Xdw (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 30 Mar 2022 19:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234133AbiC3Xdv (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 30 Mar 2022 19:33:51 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85D91433B0
        for <linux-cifs@vger.kernel.org>; Wed, 30 Mar 2022 16:32:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 39EEFB81E6E
        for <linux-cifs@vger.kernel.org>; Wed, 30 Mar 2022 23:32:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD853C36AE2
        for <linux-cifs@vger.kernel.org>; Wed, 30 Mar 2022 23:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1648683122;
        bh=dyAw8gt2hCTCN6qN6HRNDQvR5xLPh48zF6ia0j5kEN0=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=ZoRr66OlN9lwOwTAsE2XoRAke9WyCEO92P0OGPWrkXkqJ71IqY4Ol5AbFkLtVumot
         Ar2qwnAz91HmZUNx94PqJVn2kR7vX0FARxW7J/yAgvKs7+XDssH0jWaoYM671X1SSQ
         8zu2laD3Tl1b6ZFLzz/kJ+7rywONjfYGNvu9ISo52koqqr58lC2TD+J7rL7QO4iuVE
         ZV8xemYyGLW9LB5Gbsu+vhUpWskh3kiEdYr6TJxdS0BpgHgBvomA3nNMGQqPrxs/YJ
         IwK45wc/BPNkL8UJfX/PA9umud3sbDZHjfyro93tRQPUyVfdOf8FCBWG1uutVL7B+R
         hu8RwGfR2ZGgg==
Received: by mail-wm1-f42.google.com with SMTP id r128-20020a1c4486000000b0038ccb70e239so132892wma.3
        for <linux-cifs@vger.kernel.org>; Wed, 30 Mar 2022 16:32:02 -0700 (PDT)
X-Gm-Message-State: AOAM533+ZnQQE2EwyDHIAgoL6fkQtgmDdd1MFi17WaIPcrcOxMohj0I0
        3qzucDBaTsNRpC+tJ5TVhB1hyQn/iJxjmQzeSiI=
X-Google-Smtp-Source: ABdhPJwHz/LbVPNJwEePUcWVWE6sOlv+x3CREyZNd6BNpN+7RNRC/PuoDbK93TMqOICWHtbqzE+1+3UHUam9f4o1GXg=
X-Received: by 2002:a05:600c:1910:b0:38d:1403:da8b with SMTP id
 j16-20020a05600c191000b0038d1403da8bmr2049568wmq.3.1648683121064; Wed, 30 Mar
 2022 16:32:01 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6000:2c1:0:0:0:0 with HTTP; Wed, 30 Mar 2022 16:32:00
 -0700 (PDT)
In-Reply-To: <63afe0cd-7151-45e6-a7c2-2eb9212d721b@talpey.com>
References: <CAKYAXd_XMW1-VSLwB=k3ypqgqjsux5OFNnr=Ri3B+-8w4aNHjw@mail.gmail.com>
 <63afe0cd-7151-45e6-a7c2-2eb9212d721b@talpey.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Thu, 31 Mar 2022 08:32:00 +0900
X-Gmail-Original-Message-ID: <CAKYAXd-G-NnN+1Ex2JcRJ_PDADV3PbyfRQ=qsoQ6TDq=RdHmvQ@mail.gmail.com>
Message-ID: <CAKYAXd-G-NnN+1Ex2JcRJ_PDADV3PbyfRQ=qsoQ6TDq=RdHmvQ@mail.gmail.com>
Subject: Re: Regarding to how ksmbd handles sector size request from windows cllient
To:     Tom Talpey <tom@talpey.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Christoph Hellwig <hch@infradead.org>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        Hyeoncheol Lee <hyc.lee@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

2022-03-30 21:09 GMT+09:00, Tom Talpey <tom@talpey.com>:
> On 3/30/2022 3:53 AM, Namjae Jeon wrote:
>> zfs block size is 128KB, and there is a problem when ksmbd responds to
>> this value as a sector size to the windows client.
>> This seems to judge as an error when a Windows client requests sector
>> size information from the server and receives a value larger than 4KB.
>>
>> If the logical/physical_block_size is obtained from the block layer in
>> ksmbd, You might think of this as a layer violation.
>> e.g. i_sb->s_bdev->bd_disk->queue->limits.logical_block_size.
>>
>> So I am confused as to how to fix this issue. and I'd like to hear
>> your thoughts on how to fix this correctly.
> This sounds like a problem common to any LVM or RAID layering.
> What does a Windows server return for a volume on a Storage Space?
I'm not sure if windows server & ZFS share is possible. samba & ZFS
respond 512Bytes sector size to client. I don't know why SMB client
need the disk sector size information from server...
> Look to that for guidance.
Okay:)

Thanks!
>
> Tom.
>
