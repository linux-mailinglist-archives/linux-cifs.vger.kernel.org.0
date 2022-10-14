Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E643F5FEFB9
	for <lists+linux-cifs@lfdr.de>; Fri, 14 Oct 2022 16:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbiJNOFW (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 14 Oct 2022 10:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230319AbiJNOFE (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 14 Oct 2022 10:05:04 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F081D5872
        for <linux-cifs@vger.kernel.org>; Fri, 14 Oct 2022 07:04:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1665756180;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=k8qQltuyjmygy+O43yanVxeFaxBvrjiQoX3IXlPZtGE=;
        b=RKHBQA/A4GlnxFkvwLNIpONxGhyNEOoKxzT/Ei36YkDnL+VAzlv3bscrVdg1uB565Zn0wN
        e/Fvg0sj6dh7zV1RUi+wGHP76038mbA2w9LCAhFCtWWVnmQQGifGavsIwhIhy+tz3wGnAl
        QHUBtd+tWXuW+oAphqRgaDMVjTvnq0E=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-244-0ngC2H1gONipQ71LSLOWqQ-1; Fri, 14 Oct 2022 09:59:38 -0400
X-MC-Unique: 0ngC2H1gONipQ71LSLOWqQ-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com [10.11.54.9])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C2DFA3C10687;
        Fri, 14 Oct 2022 13:59:37 +0000 (UTC)
Received: from warthog.procyon.org.uk (unknown [10.33.36.78])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 456D84030DF;
        Fri, 14 Oct 2022 13:59:36 +0000 (UTC)
Organization: Red Hat UK Ltd. Registered Address: Red Hat UK Ltd, Amberley
        Place, 107-111 Peascod Street, Windsor, Berkshire, SI4 1TE, United
        Kingdom.
        Registered in England and Wales under Company Registration No. 3798903
From:   David Howells <dhowells@redhat.com>
In-Reply-To: <20220901220138.182896-6-vishal.moola@gmail.com>
References: <20220901220138.182896-6-vishal.moola@gmail.com> <20220901220138.182896-1-vishal.moola@gmail.com>
To:     "Vishal Moola (Oracle)" <vishal.moola@gmail.com>
Cc:     dhowells@redhat.com, linux-fsdevel@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-btrfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-ext4@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-nilfs@vger.kernel.org, linux-mm@kvack.org
Subject: Re: [PATCH 05/23] afs: Convert afs_writepages_region() to use filemap_get_folios_tag()
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-ID: <1569539.1665755974.1@warthog.procyon.org.uk>
Date:   Fri, 14 Oct 2022 14:59:34 +0100
Message-ID: <1569540.1665755974@warthog.procyon.org.uk>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.9
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Vishal Moola (Oracle) <vishal.moola@gmail.com> wrote:

> Convert to use folios throughout. This function is in preparation to
> remove find_get_pages_range_tag().
> 
> Also modified this function to write the whole batch one at a time,
> rather than calling for a new set every single write.
> 
> Signed-off-by: Vishal Moola (Oracle) <vishal.moola@gmail.com>

Tested-by: David Howells <dhowells@redhat.com>

