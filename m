Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9553B647B20
	for <lists+linux-cifs@lfdr.de>; Fri,  9 Dec 2022 02:07:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229646AbiLIBH4 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 8 Dec 2022 20:07:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbiLIBHz (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 8 Dec 2022 20:07:55 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5074C2FFF4
        for <linux-cifs@vger.kernel.org>; Thu,  8 Dec 2022 17:07:54 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id n65-20020a17090a2cc700b0021bc5ef7a14so3372544pjd.0
        for <linux-cifs@vger.kernel.org>; Thu, 08 Dec 2022 17:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=GMgcio3GEyGGRJF/K7KlPrcvkmRO7TqWfwuOwdnacGc=;
        b=gZht8F7nsvDzPIuSJ+S+zxSpiD/+2VhGF7mptjcAN5f4gCwk/vgE0OosnqNrDDiv0u
         f9Km217LaVDNYXbBzCjnptGNlh2MS6XWbXiQqi4vXsWx9ZZyBbYRhSuDyzYG4AS7O8by
         7rV0HlR2zO5ZaudpuPfsHARWP7fMiGpRmn7G8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GMgcio3GEyGGRJF/K7KlPrcvkmRO7TqWfwuOwdnacGc=;
        b=bnZcq1/xjKQuKu2ao3FSwZugCoY9aAojxP8nz+ZpEinQ772ENjfAWnJ5svtQJ5Dl/n
         UZL87ov3MrvMAgFMvJWhdBEPLuIo4dGa1Jkk2J2aCZLEn0jcLE4DMB+lqrZyRhCQFbZq
         fiNLVYo1T3FDoyzWeQqh6RqjiV6E5mobxHqR5J4UseVVkbuq8JNaW43jdvLxbj/XyE8m
         lGmhTb91AcdlfNvSmCMUOz7rDrfy7mjUtBdn5CXuo+yCqv7GAqQYpH7OO7R2xsmVpiyf
         uamrZqaatT37Ug9CUp+2PvvGhipjhom8qsoBMwuyleKX4QABmaIktInPUfkD3B40SQcQ
         s9XQ==
X-Gm-Message-State: ANoB5pkJI3Xc2rAnhysLZh+ZZfmFAoTJj8fFHraz7CK5P1xVId+LeMvp
        D1orQg09Rrrj0UpvJg+r7tlOBA==
X-Google-Smtp-Source: AA0mqf4m57nSOe++sM9RXZzuK1MXJ48TXmwuWx1bdZuYmdC/h8DAgeBR7INxXll6fJPNMVhAA/LxRA==
X-Received: by 2002:a17:902:c94d:b0:189:b36a:5448 with SMTP id i13-20020a170902c94d00b00189b36a5448mr5700057pla.44.1670548073678;
        Thu, 08 Dec 2022 17:07:53 -0800 (PST)
Received: from google.com (KD124209188001.ppp-bb.dion.ne.jp. [124.209.188.1])
        by smtp.gmail.com with ESMTPSA id h4-20020a170902b94400b001895f7c8a71sm61153pls.97.2022.12.08.17.07.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 17:07:52 -0800 (PST)
Date:   Fri, 9 Dec 2022 10:07:48 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     ye.xingchen@zte.com.cn
Cc:     linkinjeon@kernel.org, sfrench@samba.org, senozhatsky@chromium.org,
        tom@talpey.com, linux-cifs@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ksmbd: Convert to use sysfs_emit()/sysfs_emit_at() APIs
Message-ID: <Y5KKZKn8D0uvvyr+@google.com>
References: <202212070929276734686@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212070929276734686@zte.com.cn>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On (22/12/07 09:29), ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Reviewed-by: Sergey Senozhatsky <senozhatsky@chromium.org>
