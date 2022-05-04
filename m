Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50B59519390
	for <lists+linux-cifs@lfdr.de>; Wed,  4 May 2022 03:44:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234308AbiEDBr5 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 3 May 2022 21:47:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233223AbiEDBr4 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 3 May 2022 21:47:56 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E4C0228E3D
        for <linux-cifs@vger.kernel.org>; Tue,  3 May 2022 18:44:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1651628657;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=JG4nQbhkIb1QoHfZI8Py7ylnm1ydXNGoEWttGn5gVhE=;
        b=Phsq+t118G8QlKJHfqFvB7Cc/tm5J9eWemSvelJCz1arxKhMeZdy7/yLQII++CFXcO/Rb6
        ezqQSit2VFsBC8oipI6upGtSmfPxSQ00Uoz7vjyeHVgHd3u1K/m0bPyLXN0RU1FUsBs+U5
        1fuk4ZIvzVjae3HbG9QXNJHJfVymKE4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-HN9uw2cQPN-KdWf0KZO5WQ-1; Tue, 03 May 2022 21:44:16 -0400
X-MC-Unique: HN9uw2cQPN-KdWf0KZO5WQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 12C19811E76;
        Wed,  4 May 2022 01:44:16 +0000 (UTC)
Received: from thinkpad (vpn2-54-170.bne.redhat.com [10.64.54.170])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 6CFCBC27D8F;
        Wed,  4 May 2022 01:44:15 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: cache dirent names for the cached directory while we hold a lease
Date:   Wed,  4 May 2022 11:44:06 +1000
Message-Id: <20220504014407.2301906-1-lsahlber@redhat.com>
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

List, Steve, Paulo,

v2: Update with Paulos suggestions.



