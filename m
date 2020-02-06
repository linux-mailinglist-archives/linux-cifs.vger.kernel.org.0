Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6AE7154108
	for <lists+linux-cifs@lfdr.de>; Thu,  6 Feb 2020 10:19:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727946AbgBFJTS (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 6 Feb 2020 04:19:18 -0500
Received: from mx2.suse.de ([195.135.220.15]:53336 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726365AbgBFJTS (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 6 Feb 2020 04:19:18 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 4BEEEAF4E;
        Thu,  6 Feb 2020 09:19:17 +0000 (UTC)
From:   Aurelien Aptel <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH] cifs: make multichannel warning more visible
Date:   Thu,  6 Feb 2020 10:19:11 +0100
Message-Id: <20200206091911.13179-1-aaptel@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

When no interfaces are returned by the server we cannot open multiple
channels. Make it more obvious by reporting that to the user at the
VFS log level.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 fs/cifs/sess.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index f0795c856d8f..43a88e26d26b 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -101,7 +101,7 @@ int cifs_try_adding_channels(struct cifs_ses *ses)
 	iface_count = ses->iface_count;
 	if (iface_count <= 0) {
 		spin_unlock(&ses->iface_lock);
-		cifs_dbg(FYI, "no iface list available to open channels\n");
+		cifs_dbg(VFS, "no iface list available to open channels\n");
 		return 0;
 	}
 	ifaces = kmemdup(ses->iface_list, iface_count*sizeof(*ifaces),
-- 
2.16.4

