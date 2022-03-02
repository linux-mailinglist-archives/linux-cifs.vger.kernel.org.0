Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 483B34CA8E5
	for <lists+linux-cifs@lfdr.de>; Wed,  2 Mar 2022 16:16:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238551AbiCBPRj (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 2 Mar 2022 10:17:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233839AbiCBPRj (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 2 Mar 2022 10:17:39 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9B3F17B555
        for <linux-cifs@vger.kernel.org>; Wed,  2 Mar 2022 07:16:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1646234210;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cevsG6GuAA4almczxp6eqYYrZ56ZbmfrcVXaTiYNgew=;
        b=VgHl1lN5SRQxuK/2qH6tT38u0vUTtt+8uL12OSW1LnylqhEMqqUceezeOzOJyn+Y7yiMgs
        p6x9CeuG6AalQtRxSpkuJ0vpWuKsbxhxehE2/7na3yGhhHsguZxbEJZI6+gmpRNEyL9z/p
        OLWugP9OwyBqLhwmiApg9sPsur+jnyA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-jOE_xmReN_yFiNHvWH9McA-1; Wed, 02 Mar 2022 10:16:47 -0500
X-MC-Unique: jOE_xmReN_yFiNHvWH9McA-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 99CE21091DA2;
        Wed,  2 Mar 2022 15:16:45 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0E7E583BEB;
        Wed,  2 Mar 2022 15:16:43 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <CACdtm0amJS+5O4=Qun-xxSK1JoCoVfEbRrpHCJ0QYVa7Tc8szQ@mail.gmail.com>
References: <CACdtm0amJS+5O4=Qun-xxSK1JoCoVfEbRrpHCJ0QYVa7Tc8szQ@mail.gmail.com> <CACdtm0Z4crPr868DRGCYNd=euVXzm+T+rPHT4PdqK66TV7iioQ@mail.gmail.com> <914621.1645046759@warthog.procyon.org.uk> <CACdtm0ZteTve1EbSgDX_jochhHT7Ufm3gJg7j28BOjmRSg8dTQ@mail.gmail.com> <2500957.1646059150@warthog.procyon.org.uk>
To:     Rohith Surabattula <rohiths.msft@gmail.com>
Cc:     dhowells@redhat.com, Steve French <smfrench@gmail.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Paulo Alcantara <pc@cjr.nz>,
        linux-cifs <linux-cifs@vger.kernel.org>
Subject: Re: [PATCH] [CIFS]: Add clamp_length support
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <3570269.1646234203.1@warthog.procyon.org.uk>
Date:   Wed, 02 Mar 2022 15:16:43 +0000
Message-ID: <3570270.1646234203@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Rohith Surabattula <rohiths.msft@gmail.com> wrote:

> >         struct netfs_read_subrequest *netfs_alloc_subrequest(

Btw, note the patches I just posted that rename these structs and some of the
functions.

David

