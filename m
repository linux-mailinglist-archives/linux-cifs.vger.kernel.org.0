Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A476621177E
	for <lists+linux-cifs@lfdr.de>; Thu,  2 Jul 2020 02:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgGBAzx (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 1 Jul 2020 20:55:53 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:57870 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726637AbgGBAzx (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 1 Jul 2020 20:55:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593651352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=MsUrzp3Z08StU2tAUPzvw2tctxHKNKttREgPwuRkYOQ=;
        b=Ey9rBXjttwQsTNts6xyLmfprKKjqyO5sf8Q7TMbovLNN0mYjaKfjqzu0BAY6/F8ekh3MEw
        /X5oGkRRa1hpuINDO5ULhNkf154QxXX9e+/NwMo2cJ51x6IbuysPS1oYv1M4GEK6uT+OcG
        LoVgqGQS4xe5QpfuhgNacP+15Ffxb1A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-506-WzBQyOg0P3ue6PBzmnTp9A-1; Wed, 01 Jul 2020 20:55:50 -0400
X-MC-Unique: WzBQyOg0P3ue6PBzmnTp9A-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BE346107ACCA
        for <linux-cifs@vger.kernel.org>; Thu,  2 Jul 2020 00:55:49 +0000 (UTC)
Received: from test1103.test.redhat.com (vpn2-54-135.bne.redhat.com [10.64.54.135])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 546F679222;
        Thu,  2 Jul 2020 00:55:49 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH] cifs: prevent truncation from long to int in wait_for_free_credits
Date:   Thu,  2 Jul 2020 10:55:41 +1000
Message-Id: <20200702005541.31167-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The wait_event_... defines evaluate to long so we should not assign it an int as this may truncate
the value.

Reported-by: Marshall Midden <marshallmidden@gmail.com>
Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index d11e31064679..84433d0653f9 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -523,7 +523,7 @@ wait_for_free_credits(struct TCP_Server_Info *server, const int num_credits,
 		      const int timeout, const int flags,
 		      unsigned int *instance)
 {
-	int rc;
+	long rc;
 	int *credits;
 	int optype;
 	long int t;
-- 
2.13.6

