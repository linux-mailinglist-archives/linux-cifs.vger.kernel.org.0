Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5C96B112CC1
	for <lists+linux-cifs@lfdr.de>; Wed,  4 Dec 2019 14:38:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727703AbfLDNif (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 4 Dec 2019 08:38:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:39016 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727530AbfLDNif (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 4 Dec 2019 08:38:35 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id B1675B38D;
        Wed,  4 Dec 2019 13:38:33 +0000 (UTC)
From:   Aurelien Aptel <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH] cifs: fix possible uninitialized access and race on iface_list
Date:   Wed,  4 Dec 2019 14:38:06 +0100
Message-Id: <20191204133806.27431-1-aaptel@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

iface[0] was accessed regardless of the count value and without
locking.

* check count before accessing any ifaces
* make copy of iface list (it's a simple POD array) and use it without
  locking.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 fs/cifs/sess.c | 30 +++++++++++++++++++++++++++---
 1 file changed, 27 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index fb3bdc44775c..6a58f8a477a2 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -77,6 +77,8 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 	int i = 0;
 	int rc = 0;
 	int tries = 0;
+	struct cifs_server_iface *ifaces = NULL;
+	size_t iface_count;
 
 	if (left <= 0) {
 		cifs_dbg(FYI,
@@ -90,6 +92,27 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 		return 0;
 	}
 
+	/*
+	 * Make a copy of the iface list at the time and use that
+	 * instead so as to not hold the iface spinlock for opening
+	 * channels
+	 */
+	spin_lock(&ses->iface_lock);
+	iface_count = ses->iface_count;
+	if (iface_count <= 0) {
+		spin_unlock(&ses->iface_lock);
+		cifs_dbg(FYI, "no iface list available to open channels\n");
+		return 0;
+	}
+	ifaces = kmemdup(ses->iface_list, iface_count*sizeof(*ifaces),
+			 GFP_ATOMIC);
+	if (!ifaces) {
+		spin_unlock(&ses->iface_lock);
+		kfree(ifaces);
+		return 0;
+	}
+	spin_unlock(&ses->iface_lock);
+
 	/*
 	 * Keep connecting to same, fastest, iface for all channels as
 	 * long as its RSS. Try next fastest one if not RSS or channel
@@ -105,9 +128,9 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 			break;
 		}
 
-		iface = &ses->iface_list[i];
+		iface = &ifaces[i];
 		if (is_ses_using_iface(ses, iface) && !iface->rss_capable) {
-			i = (i+1) % ses->iface_count;
+			i = (i+1) % iface_count;
 			continue;
 		}
 
@@ -115,7 +138,7 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 		if (rc) {
 			cifs_dbg(FYI, "failed to open extra channel on iface#%d rc=%d\n",
 				 i, rc);
-			i = (i+1) % ses->iface_count;
+			i = (i+1) % iface_count;
 			continue;
 		}
 
@@ -124,6 +147,7 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 		left--;
 	}
 
+	kfree(ifaces);
 	return ses->chan_count - old_chan_count;
 }
 
-- 
2.16.4

