Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 665CF648706
	for <lists+linux-cifs@lfdr.de>; Fri,  9 Dec 2022 17:52:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229488AbiLIQwK (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 9 Dec 2022 11:52:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229604AbiLIQwI (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 9 Dec 2022 11:52:08 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C4F6934F7
        for <linux-cifs@vger.kernel.org>; Fri,  9 Dec 2022 08:51:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1670604671;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hEHtknj7G67yuPB9tWefZgr9ALjA/T5Vl29gdCA8cwI=;
        b=SF4wB6nt06RO5Xq96UcWeUT8IuEj0EoUkuR8W1ZKvc7m+Cmv/sLKo61FfBJftwGHgAuecj
        l7VKRADhWOjuDTPBoY/1aVKE1wmU+XiyyJOLZnkeXXDPEbdu5ZBS98saWn99+JXBwEJaAf
        sA7n+e9NoPmRG+wCHcjv/P/LtafnBWE=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-376-oZIveDTgMI2YLIKclhz5Vw-1; Fri, 09 Dec 2022 11:51:10 -0500
X-MC-Unique: oZIveDTgMI2YLIKclhz5Vw-1
Received: by mail-wm1-f72.google.com with SMTP id 9-20020a1c0209000000b003d1c0a147f6so121320wmc.4
        for <linux-cifs@vger.kernel.org>; Fri, 09 Dec 2022 08:51:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:references
         :in-reply-to:date:cc:to:from:subject:message-id:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hEHtknj7G67yuPB9tWefZgr9ALjA/T5Vl29gdCA8cwI=;
        b=Waroi746aU5qoORS/+bu9FFI2ASSuLJ4rlQylCqpTCUI9mhlTjUQXLFwKbXxSxH3NA
         0ytd5t/9WC430EoCRVgipDUw9ocRm5X+vQgXts2FcidERlfPtE+bdbOyXm1GkuxegfCi
         b3WPjR+fQlIW3Mz4HaHdV9je5oV1aTnvw9yT6cWU8yKBNRewCbRGs930HRtLSEcjQc+O
         D7uH49OfL4RE97C6MGna/4wJ3VXh3ixsq0OUETVDcfGg1aW7q5kz0El2Pm53XCcwtc+C
         FUKYQexeJrQw/vk0qn7W6ax+8D0LOYU0nZqVaLAP/KxTkzDGQL/Fkqi186UvARfXbcq5
         2gYw==
X-Gm-Message-State: ANoB5pkN4UHcNdNimT4w6JyEvORJ0fx5gXBz78OQYwupV7rqvluZc2LF
        rPvMT3Uy01CY5Q8YPnkRDFI4kjJ2aqrFYzJR57pjlw++QDmA2jU93lbscWA0ccwDGprGY6Welad
        Z0PPDGhhWEnkofDd5CiV3Hw==
X-Received: by 2002:a05:600c:4f48:b0:3cf:e850:4435 with SMTP id m8-20020a05600c4f4800b003cfe8504435mr5700775wmq.13.1670604669137;
        Fri, 09 Dec 2022 08:51:09 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4vPLwblTckd8B2URRNRbKIW7VqMLQd/PWlQAHufJr6jh2xD5egmlwfWsaGwQofLy1f6L/9tQ==
X-Received: by 2002:a05:600c:4f48:b0:3cf:e850:4435 with SMTP id m8-20020a05600c4f4800b003cfe8504435mr5700758wmq.13.1670604668951;
        Fri, 09 Dec 2022 08:51:08 -0800 (PST)
Received: from gerbillo.redhat.com (146-241-105-105.dyn.eolo.it. [146.241.105.105])
        by smtp.gmail.com with ESMTPSA id ay13-20020a05600c1e0d00b003c6bd91caa5sm302339wmb.17.2022.12.09.08.50.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 08:51:08 -0800 (PST)
Message-ID: <73186bd6e1ad62da16726b95b1a266c0aeb39719.camel@redhat.com>
Subject: Re: [PATCH v1 2/3] Treewide: Stop corrupting socket's task_frag
From:   Paolo Abeni <pabeni@redhat.com>
To:     Jakub Kicinski <kuba@kernel.org>
Cc:     Benjamin Coddington <bcodding@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Christoph =?ISO-8859-1?Q?B=F6hmwalder?= 
        <christoph.boehmwalder@linbit.com>, Jens Axboe <axboe@kernel.dk>,
        Josef Bacik <josef@toxicpanda.com>,
        Keith Busch <kbusch@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Lee Duncan <lduncan@suse.com>, Chris Leech <cleech@redhat.com>,
        Mike Christie <michael.christie@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Valentina Manea <valentina.manea.m@gmail.com>,
        Shuah Khan <shuah@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        David Howells <dhowells@redhat.com>,
        Marc Dionne <marc.dionne@auristor.com>,
        Steve French <sfrench@samba.org>,
        Christine Caulfield <ccaulfie@redhat.com>,
        David Teigland <teigland@redhat.com>,
        Mark Fasheh <mark@fasheh.com>,
        Joel Becker <jlbec@evilplan.org>,
        Joseph Qi <joseph.qi@linux.alibaba.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Ilya Dryomov <idryomov@gmail.com>,
        Xiubo Li <xiubli@redhat.com>,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>,
        Chuck Lever <chuck.lever@oracle.com>,
        Jeff Layton <jlayton@kernel.org>, drbd-dev@lists.linbit.com,
        linux-block@vger.kernel.org, nbd@other.debian.org,
        linux-nvme@lists.infradead.org, open-iscsi@googlegroups.com,
        linux-scsi@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-afs@lists.infradead.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, cluster-devel@redhat.com,
        ocfs2-devel@oss.oracle.com, v9fs-developer@lists.sourceforge.net,
        ceph-devel@vger.kernel.org, linux-nfs@vger.kernel.org
Date:   Fri, 09 Dec 2022 17:50:53 +0100
In-Reply-To: <20221209081101.7500478c@kernel.org>
References: <cover.1669036433.git.bcodding@redhat.com>
         <c2ec184226acd21a191ccc1aa46a1d7e43ca7104.1669036433.git.bcodding@redhat.com>
         <d220402a232e204676d9100d6fe4c2ae08f753ee.camel@redhat.com>
         <20221209081101.7500478c@kernel.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.42.4 (3.42.4-2.fc35) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Fri, 2022-12-09 at 08:11 -0800, Jakub Kicinski wrote:
> On Fri, 09 Dec 2022 13:37:08 +0100 Paolo Abeni wrote:
> > I think this is the most feasible way out of the existing issue, and I
> > think this patchset should go via the networking tree, targeting the
> > Linux 6.2.
> 
> FWIW some fields had been moved so this will not longer apply cleanly,
> see b534dc46c8ae016. But I think we can apply it to net since the merge
> window is upon us? Just a heads up.

We will need an additional revision, see my reply to patch 3/3. I think
the -net tree should be the appropriate target.

Thanks,

Paolo

