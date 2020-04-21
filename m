Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CACD41B1C01
	for <lists+linux-cifs@lfdr.de>; Tue, 21 Apr 2020 04:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726024AbgDUChy (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 20 Apr 2020 22:37:54 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:45300 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725829AbgDUChy (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 20 Apr 2020 22:37:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1587436673;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=jsoZwi80dr+M7YxmoORXcBzYw6P3DuIbaP9ksFgibwg=;
        b=fn7Eh0z9ohmqenMwLtwIEqfptYVHA1EdBH6VV8oDz1opwXVe5Kg0sMKKt2cfd1da4s78Yf
        UsLhSXrD/voPjwX3EYuk9JgbT+0Uisgp+FLp/Rdko33hVkJO0nijFV4gI9VvLT9+Vf1zgb
        i+UcowDcprewV3CWdTXmUr8sCWGt2f0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-122-eRoBdycEO2-H0UquXjgoGw-1; Mon, 20 Apr 2020 22:37:51 -0400
X-MC-Unique: eRoBdycEO2-H0UquXjgoGw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 677571007275
        for <linux-cifs@vger.kernel.org>; Tue, 21 Apr 2020 02:37:50 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-101.bne.redhat.com [10.64.54.101])
        by smtp.corp.redhat.com (Postfix) with ESMTP id EEDD15DA7C;
        Tue, 21 Apr 2020 02:37:49 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH] cifs: protect updating server->dstaddr with a spinlock
Date:   Tue, 21 Apr 2020 12:37:39 +1000
Message-Id: <20200421023739.10708-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

We use a spinlock while we are reading and accessing the destination address for a server.
We need to also use this spinlock to protect when we are modifying this adress from
reconn_set_ipaddr().

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/connect.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 95b3ab0ca8c0..63830f228b4a 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -375,8 +375,10 @@ static int reconn_set_ipaddr(struct TCP_Server_Info *server)
 		return rc;
 	}
 
+	spin_lock(&cifs_tcp_ses_lock);
 	rc = cifs_convert_address((struct sockaddr *)&server->dstaddr, ipaddr,
 				  strlen(ipaddr));
+	spin_unlock(&cifs_tcp_ses_lock);
 	kfree(ipaddr);
 
 	return !rc ? -1 : 0;
-- 
2.13.6

