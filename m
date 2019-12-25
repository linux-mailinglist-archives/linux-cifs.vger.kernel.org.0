Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 633EE12A5CB
	for <lists+linux-cifs@lfdr.de>; Wed, 25 Dec 2019 04:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726332AbfLYDXK (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 24 Dec 2019 22:23:10 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:8181 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726325AbfLYDXK (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 24 Dec 2019 22:23:10 -0500
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 5B827698E7762B11B597;
        Wed, 25 Dec 2019 11:23:08 +0800 (CST)
Received: from huawei.com (10.90.53.225) by DGGEMS408-HUB.china.huawei.com
 (10.3.19.208) with Microsoft SMTP Server id 14.3.439.0; Wed, 25 Dec 2019
 11:23:01 +0800
From:   zhengbin <zhengbin13@huawei.com>
To:     <sfrench@samba.org>, <linux-cifs@vger.kernel.org>,
        <samba-technical@lists.samba.org>
CC:     <zhengbin13@huawei.com>
Subject: [PATCH 2/2] fs/cifs/cifssmb.c: use true,false for bool variable
Date:   Wed, 25 Dec 2019 11:30:21 +0800
Message-ID: <1577244621-117474-3-git-send-email-zhengbin13@huawei.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1577244621-117474-1-git-send-email-zhengbin13@huawei.com>
References: <1577244621-117474-1-git-send-email-zhengbin13@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.90.53.225]
X-CFilter-Loop: Reflected
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Fixes coccicheck warning:

fs/cifs/cifssmb.c:4622:3-22: WARNING: Assignment of 0/1 to bool variable
fs/cifs/cifssmb.c:4756:3-22: WARNING: Assignment of 0/1 to bool variable

Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: zhengbin <zhengbin13@huawei.com>
---
 fs/cifs/cifssmb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index cc86a67..a481296 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -4619,7 +4619,7 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 				psrch_inf->unicode = false;

 			psrch_inf->ntwrk_buf_start = (char *)pSMBr;
-			psrch_inf->smallBuf = 0;
+			psrch_inf->smallBuf = false;
 			psrch_inf->srch_entries_start =
 				(char *) &pSMBr->hdr.Protocol +
 					le16_to_cpu(pSMBr->t2.DataOffset);
@@ -4753,7 +4753,7 @@ int CIFSFindNext(const unsigned int xid, struct cifs_tcon *tcon,
 				cifs_buf_release(psrch_inf->ntwrk_buf_start);
 			psrch_inf->srch_entries_start = response_data;
 			psrch_inf->ntwrk_buf_start = (char *)pSMB;
-			psrch_inf->smallBuf = 0;
+			psrch_inf->smallBuf = false;
 			if (parms->EndofSearch)
 				psrch_inf->endOfSearch = true;
 			else
--
2.7.4

