Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC348517E18
	for <lists+linux-cifs@lfdr.de>; Tue,  3 May 2022 09:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231458AbiECHNo (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 3 May 2022 03:13:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230427AbiECHNn (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 3 May 2022 03:13:43 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8325DB0
        for <linux-cifs@vger.kernel.org>; Tue,  3 May 2022 00:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651561810;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=vWrnv7PRJMBJVcm1vaM3839+62C+JdsJziuZUHFB4Fg=;
        b=IRyTAySFuSAuV9dFl6O/EmuL3vhB7tXe+GCxSCpRcto23/Qsh39pxsUgbMsV6P6F7PF/nD
        paOXJm0Cn9soVJXPgTSxVaTGQWuWFuoRNpxt/V6KdI1o7zg1G6DXi0Ap8WOYR9N0u9DDHI
        Kgc2sEBR+pmHz1dF0aeX0U0nHmBAwiM=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-178-uNE-CPkaOd6Ffr4o3-OeDQ-1; Tue, 03 May 2022 03:10:09 -0400
X-MC-Unique: uNE-CPkaOd6Ffr4o3-OeDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12FA53C0FEA4;
        Tue,  3 May 2022 07:10:09 +0000 (UTC)
Received: from thinkpad (vpn2-54-19.bne.redhat.com [10.64.54.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CF52C28100;
        Tue,  3 May 2022 07:10:08 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: Patch to add caching od directory entries for the cache dir
Date:   Tue,  3 May 2022 17:09:58 +1000
Message-Id: <20220503070959.2276616-1-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.8
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

List, Steve,

This is a wip patch that adds caching of directory entries while we hold a
lease to the cached directory. This makes re-scanning a directory
very cheap as long as we hold the lease.


