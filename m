Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CAB9ED14F
	for <lists+linux-cifs@lfdr.de>; Sun,  3 Nov 2019 02:21:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727360AbfKCBVZ (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 2 Nov 2019 21:21:25 -0400
Received: from mx2.suse.de ([195.135.220.15]:57522 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727346AbfKCBVZ (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sat, 2 Nov 2019 21:21:25 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 400EAADBB;
        Sun,  3 Nov 2019 01:21:24 +0000 (UTC)
From:   Aurelien Aptel <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH v4 1/6] cifs: sort interface list by speed
Date:   Sun,  3 Nov 2019 02:21:07 +0100
Message-Id: <20191103012112.12212-2-aaptel@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191103012112.12212-1-aaptel@suse.com>
References: <20191103012112.12212-1-aaptel@suse.com>
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

New channels are going to be opened by walking the list sequentially,
so by sorting it we will connect to the fastest interfaces first.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 fs/cifs/smb2ops.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index cd55af9b7cc5..ea634581791a 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -10,6 +10,7 @@
 #include <linux/falloc.h>
 #include <linux/scatterlist.h>
 #include <linux/uuid.h>
+#include <linux/sort.h>
 #include <crypto/aead.h>
 #include "cifsglob.h"
 #include "smb2pdu.h"
@@ -558,6 +559,13 @@ parse_server_interfaces(struct network_interface_info_ioctl_rsp *buf,
 	return rc;
 }
 
+static int compare_iface(const void *ia, const void *ib)
+{
+	const struct cifs_server_iface *a = (struct cifs_server_iface *)ia;
+	const struct cifs_server_iface *b = (struct cifs_server_iface *)ib;
+
+	return a->speed == b->speed ? 0 : (a->speed > b->speed ? -1 : 1);
+}
 
 static int
 SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon)
@@ -587,6 +595,9 @@ SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon)
 	if (rc)
 		goto out;
 
+	/* sort interfaces from fastest to slowest */
+	sort(iface_list, iface_count, sizeof(*iface_list), compare_iface, NULL);
+
 	spin_lock(&ses->iface_lock);
 	kfree(ses->iface_list);
 	ses->iface_list = iface_list;
-- 
2.16.4

