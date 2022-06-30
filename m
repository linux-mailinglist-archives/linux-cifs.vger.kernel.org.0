Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1B9D56218E
	for <lists+linux-cifs@lfdr.de>; Thu, 30 Jun 2022 19:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233070AbiF3RzT (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 30 Jun 2022 13:55:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbiF3RzT (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 30 Jun 2022 13:55:19 -0400
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 780903818B
        for <linux-cifs@vger.kernel.org>; Thu, 30 Jun 2022 10:55:17 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 7E64E80266;
        Thu, 30 Jun 2022 17:55:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1656611715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QixAnLylD6BGPAHjId76SXQFdlnldIO75tAoP4yCl8I=;
        b=nW87KSKZN/Eaw/N5aFZgzhwDBC0KgaPPog1UPahQ2lJf+WKJlK8sqK8OCprQSPbJR5t9x6
        l1BY3ePOgMaxAy6pE62K4YGYhWNXm9+f5kqQfknr4EMkmMXxWESzZ8D/4WUxq4GEwsmtPW
        zldEOBmJqgS/W2WAxmUgeEl1SFHptGDyH7ICeH1OBCvNenDgg3t/J4weDpSRoQVbcPf1m1
        E7kXytoOYsBYqzNxEyMB8aSCKCXTiYo1xvaiyhsBXDB7JtSTRvNVvnWNPlEtOISWdYbp9I
        pkZap1IbaTe9Wv8ddeiBW3mrR41bb+AAnhgvW8InQDsKeDIenU1gikMdZI++TA==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Julian Sikorski <belegdol@gmail.com>,
        ronnie sahlberg <ronniesahlberg@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Subject: Re: kernel-5.18.8 breaks cifs mounts
In-Reply-To: <fee59438-7b4a-0a24-f116-07c2ac39a3ad@gmail.com>
References: <211885e7-1823-9118-836b-169c7163d7c2@gmail.com>
 <CAN05THTbuBSF6HXh5TAThchJZycU1AwiQkA0W7hDwCwKOF+4kw@mail.gmail.com>
 <fee59438-7b4a-0a24-f116-07c2ac39a3ad@gmail.com>
Date:   Thu, 30 Jun 2022 14:55:10 -0300
Message-ID: <87h7423ukh.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Julian Sikorski <belegdol@gmail.com> writes:

> Not much is there:
>
> Jun 30 18:19:34 snowball3 kernel: CIFS: Attempting to mount 
> \\odroidxu4.local\julian
>
> Jun 30 18:19:34 snowball3 kernel: CIFS: VFS: cifs_mount failed w/return 
> code = -22
>
>
> I tried reverting 16d5d91 as it was the only commit referencing smb, but 
> it did not help unfortunately.

Could you please run

	echo 'module cifs +p' > /sys/kernel/debug/dynamic_debug/control
	echo 'file fs/cifs/* +p' > /sys/kernel/debug/dynamic_debug/control
	echo 1 > /proc/fs/cifs/cifsFYI
	echo 1 > /sys/module/dns_resolver/parameters/debug
	dmesg --clear
	tcpdump -s 0 -w trace.pcap port 445 & pid=$!
	mount ...
	kill $pid
	dmesg > trace.log

and then send trace.log and trace.pcap.

What SMB server and version?
