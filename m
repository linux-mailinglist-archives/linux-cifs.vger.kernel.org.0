Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34D225354A9
	for <lists+linux-cifs@lfdr.de>; Thu, 26 May 2022 22:41:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348492AbiEZUk5 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 26 May 2022 16:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348645AbiEZUku (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 26 May 2022 16:40:50 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D9E3B5A5B8
        for <linux-cifs@vger.kernel.org>; Thu, 26 May 2022 13:40:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1653597649;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qeYoBwClMquOdM4mrLC20XcvsQqVIaRivM3jxGFd6y4=;
        b=etOBz8ifbPQ6+ihF5viZXNJWblqk+4NjWTl8ucNJ8syPgAvMxaPFmKelMgrSqD1+3jE49E
        cqlHDHx2oAMFsG6NvLMYmPGEAGUV66A6Lmi8BH1+zw+EARc9wKq0L1JjMtMcMOFAHWlsw7
        i6qYPDUZUkSeZFIf0ujUkJWksq44eC4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-112-mc-1D6SBM96eFkb1G_VMfw-1; Thu, 26 May 2022 16:40:40 -0400
X-MC-Unique: mc-1D6SBM96eFkb1G_VMfw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A2A5D185A7A4;
        Thu, 26 May 2022 20:40:39 +0000 (UTC)
Received: from segfault.boston.devel.redhat.com (segfault.boston.devel.redhat.com [10.19.60.26])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 31DDF1121315;
        Thu, 26 May 2022 20:40:39 +0000 (UTC)
From:   Jeff Moyer <jmoyer@redhat.com>
To:     Frederick Lawler <fred@cloudflare.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-aio@kvack.org, linux-fsdevel@vger.kernel.org,
        linux-cachefs@redhat.com, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-mm@kvack.org,
        linux-nfs@vger.kernel.org, linux-unionfs@vger.kernel.org,
        linux-security-module@vger.kernel.org, netdev@vger.kernel.org,
        keyrings@vger.kernel.org, selinux@vger.kernel.org,
        serge@hallyn.com, amir73il@gmail.com, kernel-team@cloudflare.com
Subject: Re: [PATCH v2] cred: Propagate security_prepare_creds() error code
References: <20220525183703.466936-1-fred@cloudflare.com>
X-PGP-KeyID: 1F78E1B4
X-PGP-CertKey: F6FE 280D 8293 F72C 65FD  5A58 1FF8 A7CA 1F78 E1B4
Date:   Thu, 26 May 2022 16:43:44 -0400
In-Reply-To: <20220525183703.466936-1-fred@cloudflare.com> (Frederick Lawler's
        message of "Wed, 25 May 2022 13:37:03 -0500")
Message-ID: <x49o7zkvxbz.fsf@segfault.boston.devel.redhat.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Frederick Lawler <fred@cloudflare.com> writes:

> While experimenting with the security_prepare_creds() LSM hook, we
> noticed that our EPERM error code was not propagated up the callstack.
> Instead ENOMEM is always returned.  As a result, some tools may send a
> confusing error message to the user:
>
> $ unshare -rU
> unshare: unshare failed: Cannot allocate memory
>
> A user would think that the system didn't have enough memory, when
> instead the action was denied.
>
> This problem occurs because prepare_creds() and prepare_kernel_cred()
> return NULL when security_prepare_creds() returns an error code. Later,
> functions calling prepare_creds() and prepare_kernel_cred() return
> ENOMEM because they assume that a NULL meant there was no memory
> allocated.
>
> Fix this by propagating an error code from security_prepare_creds() up
> the callstack.
>
> Signed-off-by: Frederick Lawler <fred@cloudflare.com>

The fs/aio.c part looks ok to me.  We should probably also update the
man page for io_submit, though, to document the conditions under which
EPERM can be returned.

Acked-by: Jeff Moyer <jmoyer@redhat.com>

