Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AE5D372ADA
	for <lists+linux-cifs@lfdr.de>; Tue,  4 May 2021 15:23:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230448AbhEDNYX (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 4 May 2021 09:24:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230413AbhEDNYW (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 4 May 2021 09:24:22 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B9FC061574;
        Tue,  4 May 2021 06:23:26 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id j3-20020a05600c4843b02901484662c4ebso1273908wmo.0;
        Tue, 04 May 2021 06:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=UkcPfOw1zL7OvDlpQg+xfIeD/O5P0yQ5Qy64lO5GzLE=;
        b=XPCII7ygCpVlBB1aHHi7dBrAaN5FLXYlUwmw9fncUPCKLKfSx9crjfvejvPxvSnY2B
         c02c/GpUPnM4v/JWuqo6oOHhCTa+JgIHQ+EdLetMdrPIefIo74IoEvr2cvvj6efSZCBa
         OKEVArk8xYxaWJICqo9Tn8mgNwpPfTXC0v7GmqiY9fnF8Rjcyeyp9zb1zq+OObsu0z7U
         WqyZafWtoxPEQjpup4Qdbvi0OZbwFfQD+lZBgNLRsJIL5MKEASSum3nXn8G7GzoBxapQ
         tvyiVsT8yD5lvZ6cMS1yGszIXS+vpPhaFu+SC2Pv/F7/jbr69Wr8L7v4/g866ZHdfHdl
         tDSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=UkcPfOw1zL7OvDlpQg+xfIeD/O5P0yQ5Qy64lO5GzLE=;
        b=p3ROswm8v3gZh7qzLoG0gjwncTDNWR2lrc5eJkZsTNY8i7hnPWKKD6jcXFiMJZvLaN
         Haof6NmaQA2GTgyJ3iwZysxvZgnJ08OvlISZbMlUy+HK4wC1wCnsWYkXCCNsHcnNo3RH
         +mfcaBSwMEm0KjfUaFgKkgafHlNNvOsvo3ddSQ9uFeJhinUxiJvmaZ2s465s19C5e4Vx
         mlC05nx/a+CW3zxZJXBU4oOmUAnL10TNKKxdb1+YV5/gZX3SkCrnHJEUK81ywgY8C3pp
         1YOI/u0Kbs/KpUH5tnYfwREE5F+j62eTcOLcM2IeNpgj1uFvQrfltKNbUCBA4+kICtzv
         P5iA==
X-Gm-Message-State: AOAM533uVUKJYVjA8iDLyhxACbWYFWPt8uPrdDsJLFNnAyYIGwnltxId
        AgRMmemHiFJXX91HQNal8n8=
X-Google-Smtp-Source: ABdhPJybyw5+qxLuhY8SjLukCL9vB80At/hiQZhhXOVq30HUvzM9xmsWN3hkfXGdJDnswRJz4fWCyw==
X-Received: by 2002:a7b:c38d:: with SMTP id s13mr3945898wmj.43.1620134605114;
        Tue, 04 May 2021 06:23:25 -0700 (PDT)
Received: from localhost.localdomain ([197.2.237.199])
        by smtp.gmail.com with ESMTPSA id f24sm2546301wmb.32.2021.05.04.06.23.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 May 2021 06:23:24 -0700 (PDT)
From:   Khaled ROMDHANI <khaledromdhani216@gmail.com>
To:     sfrench@samba.org
Cc:     Khaled ROMDHANI <khaledromdhani216@gmail.com>,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org
Subject: [PATCH-next] fs/cifs: Fix resource leak
Date:   Tue,  4 May 2021 14:22:57 +0100
Message-Id: <20210504132257.23632-1-khaledromdhani216@gmail.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The -EIO error return path is leaking memory allocated
to page. Fix this by invoking the free_dentry_path before
the return.

Addresses-Coverity: ("Resource leak")
Signed-off-by: Khaled ROMDHANI <khaledromdhani216@gmail.com>
---
 fs/cifs/link.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/link.c b/fs/cifs/link.c
index 1cbe7ec73728..1485c6095ba1 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -686,8 +686,10 @@ cifs_symlink(struct user_namespace *mnt_userns, struct inode *inode,
 	void *page = alloc_dentry_path();
 	struct inode *newinode = NULL;
 
-	if (unlikely(cifs_forced_shutdown(cifs_sb)))
+	if (unlikely(cifs_forced_shutdown(cifs_sb))) {
+		free_dentry_path(page);
 		return -EIO;
+	}
 
 	xid = get_xid();
 
-- 
2.17.1

