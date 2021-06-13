Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 610583A58EA
	for <lists+linux-cifs@lfdr.de>; Sun, 13 Jun 2021 16:01:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbhFMOD0 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 13 Jun 2021 10:03:26 -0400
Received: from youngberry.canonical.com ([91.189.89.112]:53977 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231755AbhFMOD0 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 13 Jun 2021 10:03:26 -0400
Received: from 1.general.cking.uk.vpn ([10.172.193.212] helo=localhost)
        by youngberry.canonical.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
        (Exim 4.93)
        (envelope-from <colin.king@canonical.com>)
        id 1lsQg0-0004Tq-6D; Sun, 13 Jun 2021 14:01:24 +0000
From:   Colin King <colin.king@canonical.com>
To:     Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: remove redundant initialization of variable rc
Date:   Sun, 13 Jun 2021 15:01:23 +0100
Message-Id: <20210613140123.74900-1-colin.king@canonical.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

The variable rc is being initialized with a value that is never read, the
assignment is redundant and can be removed.

Addresses-Coverity: ("Unused value")
Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/cifs/cifssmb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 037c44bf48f1..277cb1044cbe 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -1238,7 +1238,7 @@ SMBLegacyOpen(const unsigned int xid, struct cifs_tcon *tcon,
 	    int *pOplock, FILE_ALL_INFO *pfile_info,
 	    const struct nls_table *nls_codepage, int remap)
 {
-	int rc = -EACCES;
+	int rc;
 	OPENX_REQ *pSMB = NULL;
 	OPENX_RSP *pSMBr = NULL;
 	int bytes_returned;
-- 
2.31.1

