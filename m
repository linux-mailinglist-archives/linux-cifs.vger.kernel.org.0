Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29FBE2C02B
	for <lists+linux-cifs@lfdr.de>; Tue, 28 May 2019 09:38:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727349AbfE1HiQ (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 28 May 2019 03:38:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:55690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726203AbfE1HiQ (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 28 May 2019 03:38:16 -0400
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 189C030842B2;
        Tue, 28 May 2019 07:38:16 +0000 (UTC)
Received: from idlethread.redhat.com (ovpn-116-19.ams2.redhat.com [10.36.116.19])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2F63C2718B;
        Tue, 28 May 2019 07:38:14 +0000 (UTC)
From:   Roberto Bergantinos Corpas <rbergant@redhat.com>
To:     sfrench@samba.org
Cc:     linux-cifs@vger.kernel.org
Subject: [PATCH] CIFS: cifs_read_allocate_pages: don't iterate through whole page array on ENOMEM
Date:   Tue, 28 May 2019 09:38:14 +0200
Message-Id: <20190528073814.984-1-rbergant@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.40]); Tue, 28 May 2019 07:38:16 +0000 (UTC)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

 In cifs_read_allocate_pages, in case of ENOMEM, we go through
whole rdata->pages array but we have failed the allocation before
nr_pages, therefore we may end up calling put_page with NULL
pointer, causing oops

Signed-off-by: Roberto Bergantinos Corpas <rbergant@redhat.com>
---
 fs/cifs/file.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index ce9a5be11df5..06e27ac6d82c 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -3216,7 +3216,9 @@ cifs_read_allocate_pages(struct cifs_readdata *rdata, unsigned int nr_pages)
 	}
 
 	if (rc) {
-		for (i = 0; i < nr_pages; i++) {
+		unsigned int nr_page_failed = i;
+
+		for (i = 0; i < nr_page_failed; i++) {
 			put_page(rdata->pages[i]);
 			rdata->pages[i] = NULL;
 		}
-- 
2.14.5

