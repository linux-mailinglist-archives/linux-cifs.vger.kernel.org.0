Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5278E112E1B
	for <lists+linux-cifs@lfdr.de>; Wed,  4 Dec 2019 16:15:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727958AbfLDPPA (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 4 Dec 2019 10:15:00 -0500
Received: from mx2.suse.de ([195.135.220.15]:46804 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727828AbfLDPPA (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 4 Dec 2019 10:15:00 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 10836AD26;
        Wed,  4 Dec 2019 15:14:59 +0000 (UTC)
From:   Aurelien Aptel <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH v2] cifs: fix possible uninitialized access and race on iface_list
Date:   Wed,  4 Dec 2019 16:14:54 +0100
Message-Id: <20191204151454.29253-1-aaptel@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191204133806.27431-1-aaptel@suse.com>
References: <20191204133806.27431-1-aaptel@suse.com>
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
changes since v1:
* remove unecessary kfree()

 fs/cifs/sess.c | 29 ++++++++++++++++++++++++++---
 1 file changed, 26 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index fb3bdc44775c..396400cf2800 100644
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
@@ -90,6 +92,26 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
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
+		return 0;
+	}
+	spin_unlock(&ses->iface_lock);
+
 	/*
 	 * Keep connecting to same, fastest, iface for all channels as
 	 * long as its RSS. Try next fastest one if not RSS or channel
@@ -105,9 +127,9 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 			break;
 		}
 
-		iface = &ses->iface_list[i];
+		iface = &ifaces[i];
 		if (is_ses_using_iface(ses, iface) && !iface->rss_capable) {
-			i = (i+1) % ses->iface_count;
+			i = (i+1) % iface_count;
 			continue;
 		}
 
@@ -115,7 +137,7 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 		if (rc) {
 			cifs_dbg(FYI, "failed to open extra channel on iface#%d rc=%d\n",
 				 i, rc);
-			i = (i+1) % ses->iface_count;
+			i = (i+1) % iface_count;
 			continue;
 		}
 
@@ -124,6 +146,7 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 		left--;
 	}
 
+	kfree(ifaces);
 	return ses->chan_count - old_chan_count;
 }
 
-- 
2.16.4

