Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AB46C1AEB7
	for <lists+linux-cifs@lfdr.de>; Mon, 13 May 2019 03:24:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727171AbfEMBY0 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 12 May 2019 21:24:26 -0400
Received: from mx1.redhat.com ([209.132.183.28]:38332 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727131AbfEMBY0 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sun, 12 May 2019 21:24:26 -0400
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A72D83082E21;
        Mon, 13 May 2019 01:24:26 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-90.bne.redhat.com [10.64.54.90])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3BAEB10018E0;
        Mon, 13 May 2019 01:24:26 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH] cifs: use the right include for signal_pending()
Date:   Mon, 13 May 2019 11:24:17 +1000
Message-Id: <20190513012417.2603-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.46]); Mon, 13 May 2019 01:24:26 +0000 (UTC)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/transport.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 9a16ff4b9f5e..60661b3f983a 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -33,7 +33,7 @@
 #include <linux/uaccess.h>
 #include <asm/processor.h>
 #include <linux/mempool.h>
-#include <linux/signal.h>
+#include <linux/sched/signal.h>
 #include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
-- 
2.13.6

