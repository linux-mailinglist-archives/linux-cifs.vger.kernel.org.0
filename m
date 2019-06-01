Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6655831941
	for <lists+linux-cifs@lfdr.de>; Sat,  1 Jun 2019 05:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbfFADXG (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 31 May 2019 23:23:06 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:17642 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725934AbfFADXG (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 31 May 2019 23:23:06 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 0DDC45A0976F66316FF1;
        Sat,  1 Jun 2019 11:23:04 +0800 (CST)
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.439.0; Sat, 1 Jun 2019 11:22:54 +0800
From:   YueHaibing <yuehaibing@huawei.com>
To:     Steve French <sfrench@samba.org>
CC:     YueHaibing <yuehaibing@huawei.com>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>,
        <kernel-janitors@vger.kernel.org>
Subject: [PATCH -next] cifs: Use kmemdup in SMB2_ioctl_init()
Date:   Sat, 1 Jun 2019 03:31:10 +0000
Message-ID: <20190601033110.81011-1-yuehaibing@huawei.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Originating-IP: [10.175.113.25]
X-CFilter-Loop: Reflected
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Use kmemdup rather than duplicating its implementation

This was reported by coccinelle.

Signed-off-by: YueHaibing <yuehaibing@huawei.com>
---
 fs/cifs/smb2pdu.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 710ceb875161..02f0c2e41fcb 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2549,12 +2549,11 @@ SMB2_ioctl_init(struct cifs_tcon *tcon, struct smb_rqst *rqst,
 		 * indatalen is usually small at a couple of bytes max, so
 		 * just allocate through generic pool
 		 */
-		in_data_buf = kmalloc(indatalen, GFP_NOFS);
+		in_data_buf = kmemdup(in_data, indatalen, GFP_NOFS);
 		if (!in_data_buf) {
 			cifs_small_buf_release(req);
 			return -ENOMEM;
 		}
-		memcpy(in_data_buf, in_data, indatalen);
 	}
 
 	req->CtlCode = cpu_to_le32(opcode);



