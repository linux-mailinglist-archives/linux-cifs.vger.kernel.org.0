Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC4FE9DB16
	for <lists+linux-cifs@lfdr.de>; Tue, 27 Aug 2019 03:36:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728543AbfH0BgG (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 26 Aug 2019 21:36:06 -0400
Received: from mx1.redhat.com ([209.132.183.28]:45020 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727646AbfH0BgF (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 26 Aug 2019 21:36:05 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C32B0301E136;
        Tue, 27 Aug 2019 01:36:05 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-71.bne.redhat.com [10.64.54.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 268956060D;
        Tue, 27 Aug 2019 01:36:04 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: [PATCH 2/2] cifs: fix incorrect error return in build_unc_path_to_root
Date:   Tue, 27 Aug 2019 11:35:58 +1000
Message-Id: <20190827013558.18281-2-lsahlber@redhat.com>
In-Reply-To: <20190827013558.18281-1-lsahlber@redhat.com>
References: <20190827013558.18281-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.41]); Tue, 27 Aug 2019 01:36:05 +0000 (UTC)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/connect.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 1ed449f4a8ec..c5dc8265b671 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -4232,7 +4232,7 @@ build_unc_path_to_root(const struct smb_vol *vol,
 	unsigned int unc_len = strnlen(vol->UNC, MAX_TREE_SIZE + 1);
 
 	if (unc_len > MAX_TREE_SIZE)
-		return -EINVAL;
+		return ERR_PTR(-EINVAL);
 
 	full_path = kmalloc(unc_len + pplen + 1, GFP_KERNEL);
 	if (full_path == NULL)
-- 
2.13.6

