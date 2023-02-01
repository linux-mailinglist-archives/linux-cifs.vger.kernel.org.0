Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EC376815B6
	for <lists+linux-cifs@lfdr.de>; Mon, 30 Jan 2023 16:59:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237713AbjA3P7H (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 30 Jan 2023 10:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237499AbjA3P7E (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 30 Jan 2023 10:59:04 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A90771350F
        for <linux-cifs@vger.kernel.org>; Mon, 30 Jan 2023 07:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1675094297;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qLfIaYqKY5h8p0flnUU+ZUSKaufFe4Nci0Ya2wtNYRE=;
        b=EEUQMy0mBk2QxJbt9ID5WmVCQgamfvnoTX0pZq+IkWVaQvpAP5AUOzD/4vJjnWB4sdbUqw
        NK/XPV/VaJKcpniB4cy31X0i+I70QwLNyNFVmYtHysnslM9DL3dXUpG9jdhWW+YO3p/Z3L
        A7+p3si8XmOqkJjPkYc5fJ7dkekx554=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-329-LQbhBSgfPCWz-AZqI1IBMQ-1; Mon, 30 Jan 2023 10:58:12 -0500
X-MC-Unique: LQbhBSgfPCWz-AZqI1IBMQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 64B4B3848C21;
        Mon, 30 Jan 2023 15:58:11 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.97])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 29BD5492B05;
        Mon, 30 Jan 2023 15:58:09 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20230130092157.1759539-21-hch@lst.de>
References: <20230130092157.1759539-21-hch@lst.de> <20230130092157.1759539-1-hch@lst.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     dhowells@redhat.com
Cc:     Marc Dionne <marc.dionne@auristor.com>,
        linux-block@vger.kernel.org, ceph-devel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
        target-devel@vger.kernel.org, kvm@vger.kernel.org,
        netdev@vger.kernel.org, linux-afs@lists.infradead.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.org,
        devel@lists.orangefs.org, io-uring@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH 20/23] rxrpc: use bvec_set_page to initialize a bvec
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3499862.1675094288.1@warthog.procyon.org.uk>
Date:   Mon, 30 Jan 2023 15:58:08 +0000
Message-ID: <3499863.1675094288@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Christoph Hellwig <hch@lst.de> wrote:

> Use the bvec_set_page helper to initialize a bvec.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Acked-by: David Howells <dhowells@redhat.com>

