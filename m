Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0F6EB8A50
	for <lists+linux-cifs@lfdr.de>; Fri, 20 Sep 2019 07:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437191AbfITFBt (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 20 Sep 2019 01:01:49 -0400
Received: from mx2.suse.de ([195.135.220.15]:48870 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437189AbfITFBt (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 20 Sep 2019 01:01:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 17098AF11;
        Fri, 20 Sep 2019 05:01:48 +0000 (UTC)
From:   Aurelien Aptel <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH v4 4/6] cifs: sort interface list by speed
Date:   Fri, 20 Sep 2019 07:01:17 +0200
Message-Id: <20190920050119.27017-5-aaptel@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190920050119.27017-1-aaptel@suse.com>
References: <20190920050119.27017-1-aaptel@suse.com>
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 fs/cifs/smb2ops.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 1ca35672350c..0e66dc1aa1c9 100644
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

