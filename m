Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4716723E8
	for <lists+linux-cifs@lfdr.de>; Wed, 24 Jul 2019 03:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728520AbfGXBn6 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 23 Jul 2019 21:43:58 -0400
Received: from mx1.redhat.com ([209.132.183.28]:59752 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728502AbfGXBn6 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 23 Jul 2019 21:43:58 -0400
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1BBC333653;
        Wed, 24 Jul 2019 01:43:58 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-100.bne.redhat.com [10.64.54.100])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A4EBE60BEC;
        Wed, 24 Jul 2019 01:43:57 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH] cifs: fix a comment for the timeouts when sending echos
Date:   Wed, 24 Jul 2019 11:43:49 +1000
Message-Id: <20190724014349.6479-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Wed, 24 Jul 2019 01:43:58 +0000 (UTC)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index a4830ced0f98..78fb5cc37644 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -712,7 +712,7 @@ server_unresponsive(struct TCP_Server_Info *server)
 	 * We need to wait 3 echo intervals to make sure we handle such
 	 * situations right:
 	 * 1s  client sends a normal SMB request
-	 * 3s  client gets a response
+	 * 2s  client gets a response
 	 * 30s echo workqueue job pops, and decides we got a response recently
 	 *     and don't need to send another
 	 * ...
-- 
2.13.6

