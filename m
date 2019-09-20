Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 01C31B8A52
	for <lists+linux-cifs@lfdr.de>; Fri, 20 Sep 2019 07:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2437193AbfITFCA (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 20 Sep 2019 01:02:00 -0400
Received: from mx2.suse.de ([195.135.220.15]:48900 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S2437189AbfITFCA (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 20 Sep 2019 01:02:00 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 21DB3AF11;
        Fri, 20 Sep 2019 05:01:59 +0000 (UTC)
From:   Aurelien Aptel <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH v4 6/6] cifs: mention if an interface has a channel connected to it
Date:   Fri, 20 Sep 2019 07:01:19 +0200
Message-Id: <20190920050119.27017-7-aaptel@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190920050119.27017-1-aaptel@suse.com>
References: <20190920050119.27017-1-aaptel@suse.com>
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 fs/cifs/cifs_debug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index 0b4eee3bed66..ef454170f37d 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -410,8 +410,12 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
 				seq_printf(m, "\n\tServer interfaces: %zu\n",
 					   ses->iface_count);
 			for (j = 0; j < ses->iface_count; j++) {
+				struct cifs_server_iface *iface;
+				iface = &ses->iface_list[j];
 				seq_printf(m, "\t%d)", j);
-				cifs_dump_iface(m, &ses->iface_list[j]);
+				cifs_dump_iface(m, iface);
+				if (is_ses_using_iface(ses, iface))
+					seq_puts(m, "\t\t[CONNECTED]\n");
 			}
 			spin_unlock(&ses->iface_lock);
 		}
-- 
2.16.4

