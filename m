Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6FBF95BD685
	for <lists+linux-cifs@lfdr.de>; Mon, 19 Sep 2022 23:38:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229449AbiISVij (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 19 Sep 2022 17:38:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbiISViQ (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 19 Sep 2022 17:38:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB8AA4D83E
        for <linux-cifs@vger.kernel.org>; Mon, 19 Sep 2022 14:38:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663623492;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=G421uWQwJswghYVzNCAGBqS1GimgjZgSliGaTFwbdXE=;
        b=GgOX9pd1oIai6PRdAtPsoNV1f2v8KhCcdg3flQjXCsGix+4lXHKq3fK9z8zBUSD+q5kpcs
        1E5LSDzheo1+YGpovDhpllmnHPWbQ7eLS2zm1gyC36jnjpgCVUtjgQcJ1OLw8tgxuBrLx5
        RaBxTGDXEBeZdjo3UC0SThqWtpt5VTk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-208-lisOogDrNtKDF5QcaJ5cyQ-1; Mon, 19 Sep 2022 17:38:08 -0400
X-MC-Unique: lisOogDrNtKDF5QcaJ5cyQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.rdu2.redhat.com [10.11.54.1])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D66523C02B7C;
        Mon, 19 Sep 2022 21:38:07 +0000 (UTC)
Received: from localhost.localdomain (vpn2-52-22.bne.redhat.com [10.64.52.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3EA8E40C2064;
        Mon, 19 Sep 2022 21:38:06 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Paulo Alcantara <pc@cjr.nz>,
        Enzo Matsumiya <ematsumiya@suse.de>
Subject: [PATCH] cifs: destage dirty pages before re-reading them for cache=none
Date:   Tue, 20 Sep 2022 07:37:59 +1000
Message-Id: <20220919213759.487123-2-lsahlber@redhat.com>
In-Reply-To: <20220919213759.487123-1-lsahlber@redhat.com>
References: <20220919213759.487123-1-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

This is the opposite case of kernel bugzilla 216301.
If we mmap a file using cache=none and then proceed to update the mmapped
area these updates are not reflected in a later pread() of that part of the
file.
To fix this we must first destage any dirty pages in the range before
we allow the pread() to proceed.

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Reviewed-by: Enzo Matsumiya <ematsumiya@suse.de>
Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/file.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 6f38b134a346..1f3eb97ef4ab 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -4271,6 +4271,15 @@ static ssize_t __cifs_readv(
 		len = ctx->len;
 	}
 
+	if (direct) {
+		rc = filemap_write_and_wait_range(file->f_inode->i_mapping,
+						  offset, offset + len - 1);
+		if (rc) {
+			kref_put(&ctx->refcount, cifs_aio_ctx_release);
+			return rc;
+		}
+	}
+
 	/* grab a lock here due to read response handlers can access ctx */
 	mutex_lock(&ctx->aio_mutex);
 
-- 
2.35.3

