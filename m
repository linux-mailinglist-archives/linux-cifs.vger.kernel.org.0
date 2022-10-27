Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FC3060F867
	for <lists+linux-cifs@lfdr.de>; Thu, 27 Oct 2022 15:06:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234721AbiJ0NG1 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 27 Oct 2022 09:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234988AbiJ0NGZ (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 27 Oct 2022 09:06:25 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 794F558E9A
        for <linux-cifs@vger.kernel.org>; Thu, 27 Oct 2022 06:06:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1666875983;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=h3esAL34hsd7fi8HYNIYP56t4S/yycCKV0wPq2bO/WI=;
        b=ThFU82VSu8OEcxGbfwq0+BWo17POFCaEjjovtpPRu3PFyhy3fMHfv3LosBP9jO+XFWk9g3
        TrMfCpe65ObuuF/5BgrOmva+GQAPfBQ745Y5fTKCMlLgbbA8rGLX2VCEqi044PkGRemZcq
        ZI6+k5z/yAp/hIGGFjDG/MJjE5NffK4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-673-AEZKjTL8P1mUcLgflbbgGQ-1; Thu, 27 Oct 2022 09:06:22 -0400
X-MC-Unique: AEZKjTL8P1mUcLgflbbgGQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A6D95800B30;
        Thu, 27 Oct 2022 13:06:20 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.73])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 7A9D32024CB7;
        Thu, 27 Oct 2022 13:06:19 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20221027083547.46933-9-jefflexu@linux.alibaba.com>
References: <20221027083547.46933-9-jefflexu@linux.alibaba.com> <20221027083547.46933-1-jefflexu@linux.alibaba.com>
To:     Jingbo Xu <jefflexu@linux.alibaba.com>
Cc:     dhowells@redhat.com, jlayton@kernel.org, linux-cachefs@redhat.com,
        linux-erofs@lists.ozlabs.org, linux-cifs@vger.kernel.org,
        linux-nfs@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 8/9] fscache,netfs: move PageFsCache() family helpers to fscache.h
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3306288.1666875978.1@warthog.procyon.org.uk>
Date:   Thu, 27 Oct 2022 14:06:18 +0100
Message-ID: <3306289.1666875978@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Jingbo Xu <jefflexu@linux.alibaba.com> wrote:

> Besides, it's also quite reasonable to move these helpers to fscache.h
> given their names.

They're going to go away.  Please don't use them at all unless you must.  Just
leave them where they are.

David

