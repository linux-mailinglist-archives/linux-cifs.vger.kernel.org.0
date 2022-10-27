Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9116560F8C5
	for <lists+linux-cifs@lfdr.de>; Thu, 27 Oct 2022 15:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiJ0NO1 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 27 Oct 2022 09:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236175AbiJ0NOE (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 27 Oct 2022 09:14:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB4E366A68
        for <linux-cifs@vger.kernel.org>; Thu, 27 Oct 2022 06:13:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666876418;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dQxbSjhqzSOLM0ahZEXNwS5QfLD56iw/ahD7kkiNphg=;
        b=DPFh/RMCsU0Mp0HPaSboDCpqKsXY892vRSZnT3OStI/lTZyXKuzAcEyKlxuTItiDZOarU3
        JTwX9ACmjjSCSfJXsdMete4q3kZNxpTrILY1oKTZ6E0v7m8G4y8Ioo5YyeK0IjKuF5vJr2
        FOH/g3mdCUgJNJ+OPECDMuc4cET0eqg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-IoArZIJpNemIDmIp9PCBzA-1; Thu, 27 Oct 2022 09:13:34 -0400
X-MC-Unique: IoArZIJpNemIDmIp9PCBzA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3415F3C0ED55;
        Thu, 27 Oct 2022 13:13:18 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 97E181415117;
        Thu, 27 Oct 2022 13:13:04 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20221027083547.46933-10-jefflexu@linux.alibaba.com>
References: <20221027083547.46933-10-jefflexu@linux.alibaba.com> <20221027083547.46933-1-jefflexu@linux.alibaba.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, jlayton@kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 9/9] fscache,netfs: move "fscache_" prefixed structures to fscache.h
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3306695.1666876383.1@warthog.procyon.org.uk>
Date:   Thu, 27 Oct 2022 14:13:03 +0100
Message-ID: <3306696.1666876383@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.7
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> diff --git a/include/linux/netfs.h b/include/linux/netfs.h
> index 2ad4e1e88106..1977f953633a 100644
> --- a/include/linux/netfs.h
> +++ b/include/linux/netfs.h
> @@ -16,19 +16,10 @@
>  
>  #include <linux/workqueue.h>
>  #include <linux/fs.h>
> +#include <linux/fscache.h>

Please don't do that.  fscache is based on netfslib, not the other way around.

If anything, I'm tempted to move fscache into netfslib.

David

