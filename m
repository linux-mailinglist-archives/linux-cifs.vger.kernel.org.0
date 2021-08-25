Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C474E3F7069
	for <lists+linux-cifs@lfdr.de>; Wed, 25 Aug 2021 09:31:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238581AbhHYHbp (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 25 Aug 2021 03:31:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:25317 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238533AbhHYHbp (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 25 Aug 2021 03:31:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1629876659;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=9v/9wnG1WdUqezO03A17icsUpZnfq9nrNZIs9qM0MdM=;
        b=H3irGatcydL4kRwatFoNnrtHNP/WGaCLI5hwZVF0uzoZi5BzMiYzm4YoWa5WWipnJFHzAY
        87FMOlTd2m8K7Pbk35HuC0rn3Xc0im8hQwOfQbiqO2I0qGmnfHF2ojwYLl+zDsb5fMuSsb
        pHVtMQvldOgFQJs8+6IJ0OYMBoqeGTU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-129-_cQsebJxMwerkzt8de7HBQ-1; Wed, 25 Aug 2021 03:30:57 -0400
X-MC-Unique: _cQsebJxMwerkzt8de7HBQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C1033107ACF5;
        Wed, 25 Aug 2021 07:30:56 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-114.bne.redhat.com [10.64.54.114])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0821A69321;
        Wed, 25 Aug 2021 07:30:55 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: [PATCH] cifs: Do not leak EDEADLK to dgetents64 for STATUS_USER_SESSION_DELETED
Date:   Wed, 25 Aug 2021 17:30:43 +1000
Message-Id: <20210825073043.1630555-2-lsahlber@redhat.com>
In-Reply-To: <20210825073043.1630555-1-lsahlber@redhat.com>
References: <20210825073043.1630555-1-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

RHBZ: 1994393

If we hit a STATUS_USER_SESSION_DELETED for the Create part in the
Create/QueryDirectory compound that starts a directory scan
we will leak EDEADLK back to userspace and surprise glibc and the application.

Pick this up cifs_readdir() and retry a small number of tries before we
return an error to userspace.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/readdir.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index bfee176b901d..56e5d456366d 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -930,6 +930,7 @@ int cifs_readdir(struct file *file, struct dir_context *ctx)
 	unsigned int max_len;
 	const char *full_path;
 	void *page = alloc_dentry_path();
+	int retry_count = 0;
 
 	xid = get_xid();
 
@@ -944,8 +945,15 @@ int cifs_readdir(struct file *file, struct dir_context *ctx)
 	 * '..'. Otherwise we won't be able to notify VFS in case of failure.
 	 */
 	if (file->private_data == NULL) {
+		again:
 		rc = initiate_cifs_search(xid, file, full_path);
-		cifs_dbg(FYI, "initiate cifs search rc %d\n", rc);
+		if (rc == -EDEADLK && retry_count++ < 5) {
+			/*
+			 * We don't have enough credits to start reading the
+			 * directory so just try again.
+			 */
+			goto again;
+		}
 		if (rc)
 			goto rddir2_exit;
 	}
-- 
2.30.2

