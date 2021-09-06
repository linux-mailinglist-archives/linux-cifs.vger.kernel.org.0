Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A3ED402179
	for <lists+linux-cifs@lfdr.de>; Tue,  7 Sep 2021 01:51:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232066AbhIFXcY (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 6 Sep 2021 19:32:24 -0400
Received: from mail.kernel.org ([198.145.29.99]:55176 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229866AbhIFXcX (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 6 Sep 2021 19:32:23 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 202CF600CC;
        Mon,  6 Sep 2021 23:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1630971078;
        bh=aoF1H2UmYoxlhAhStuXzzpNjbkpPfAGfpYh/lGmuDEg=;
        h=In-Reply-To:References:From:Date:Subject:To:Cc:From;
        b=OjDLMmnnKOHtkIAlfmFhaXxgCWmpBa6lvAYUCM0kGTm8uWvUzEcjThPTAwrTCaF5i
         fUVhx41tWiSHoqrss3kt8aRM6rsBUnkPAGuTobZwnLMbZY9CC/Q3Xenpa6XRsbKRhp
         YTOjzDUp6q3Vquas3qETf4QEvVXyglMBFhgBnekU2ZCJzpvVbJy0JE/2AJQ89iwKvM
         yzwgjoYCqXNq2uJr9+tCTEPuIWkVHX+pKN+y/vrekqH9EA2QMue6D7ASKRw8fO6yBy
         Qo1cZAY/a421tTbUdINxP2Vfr9egSE1Iqf4/r92ALqhfMrG4igTjUZoBkO3XMYQDhR
         bfESv5kQRGl8w==
Received: by mail-ot1-f48.google.com with SMTP id v33-20020a0568300921b0290517cd06302dso10528022ott.13;
        Mon, 06 Sep 2021 16:31:18 -0700 (PDT)
X-Gm-Message-State: AOAM531Fzgy3YN0725ra+ySWtUjsl8xio+dtoBMD359Qm2HDkhQFJ1Ik
        91/UoXYJOHqWElWaJdAowVnwcndR58/wT6SIHCc=
X-Google-Smtp-Source: ABdhPJzZiG8rIbqxwlSWGA0Tqz4WOy8/QHQkuIyQDs+xgXpfvUI35OFZ7hYDAoZFNtK6porraGbx4rx6ZKjxKAaglRo=
X-Received: by 2002:a9d:6c04:: with SMTP id f4mr12489798otq.185.1630971077487;
 Mon, 06 Sep 2021 16:31:17 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a8a:74d:0:0:0:0:0 with HTTP; Mon, 6 Sep 2021 16:31:16 -0700 (PDT)
In-Reply-To: <20210906134438.14250-1-colin.king@canonical.com>
References: <20210906134438.14250-1-colin.king@canonical.com>
From:   Namjae Jeon <linkinjeon@kernel.org>
Date:   Tue, 7 Sep 2021 08:31:16 +0900
X-Gmail-Original-Message-ID: <CAKYAXd8Rsu88exReJCt8hW8d_D=cqpRy1G7siaK+2AOo3EOO4w@mail.gmail.com>
Message-ID: <CAKYAXd8Rsu88exReJCt8hW8d_D=cqpRy1G7siaK+2AOo3EOO4w@mail.gmail.com>
Subject: Re: [PATCH][next] ksmbd: add missing assignments to ret on
 ndr_read_int64 read calls
To:     Colin King <colin.king@canonical.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steve French <sfrench@samba.org>,
        Hyunchul Lee <hyc.lee@gmail.com>, linux-cifs@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

2021-09-06 22:44 GMT+09:00, Colin King <colin.king@canonical.com>:
> From: Colin Ian King <colin.king@canonical.com>
>
> Currently there are two ndr_read_int64 calls where ret is being checked
> for failure but ret is not being assigned a return value from the call.
> Static analyis is reporting the checks on ret as dead code.  Fix this.
>
> Addresses-Coverity: ("Logical dead code")
> Fixes: 303fff2b8c77 ("ksmbd: add validation for ndr read/write functions")
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
Applied it to my queue. I will send it to Steve after testing.
Thanks for your patch!
