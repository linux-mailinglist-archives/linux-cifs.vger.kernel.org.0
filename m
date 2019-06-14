Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B2D1F46841
	for <lists+linux-cifs@lfdr.de>; Fri, 14 Jun 2019 21:46:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725837AbfFNTqm (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 14 Jun 2019 15:46:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:44340 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725808AbfFNTqm (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 14 Jun 2019 15:46:42 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 27E98AEA9;
        Fri, 14 Jun 2019 19:46:41 +0000 (UTC)
From:   Aurelien Aptel <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH] cifs: add missing GCM module dependency
Date:   Fri, 14 Jun 2019 21:46:35 +0200
Message-Id: <20190614194635.21264-1-aaptel@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 fs/cifs/Kconfig  | 1 +
 fs/cifs/cifsfs.c | 1 +
 2 files changed, 2 insertions(+)

diff --git a/fs/cifs/Kconfig b/fs/cifs/Kconfig
index aae2b8b2adf5..62ad5ed26de7 100644
--- a/fs/cifs/Kconfig
+++ b/fs/cifs/Kconfig
@@ -13,6 +13,7 @@ config CIFS
 	select CRYPTO_ARC4
 	select CRYPTO_AEAD2
 	select CRYPTO_CCM
+	select CRYPTO_GCM
 	select CRYPTO_ECB
 	select CRYPTO_AES
 	select CRYPTO_DES
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 65d9771e49f9..d06edebf3a73 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1604,5 +1604,6 @@ MODULE_SOFTDEP("pre: sha256");
 MODULE_SOFTDEP("pre: sha512");
 MODULE_SOFTDEP("pre: aead2");
 MODULE_SOFTDEP("pre: ccm");
+MODULE_SOFTDEP("pre: gcm");
 module_init(init_cifs)
 module_exit(exit_cifs)
-- 
2.16.4

