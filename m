Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25674B303A
	for <lists+linux-cifs@lfdr.de>; Fri, 11 Feb 2022 23:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239585AbiBKWQq (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 11 Feb 2022 17:16:46 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354011AbiBKWQq (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 11 Feb 2022 17:16:46 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 24212D44
        for <linux-cifs@vger.kernel.org>; Fri, 11 Feb 2022 14:16:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1644617803;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=ThqPmRc9IAGJnKUvBssdh1YPQTxIIdYPxoVyWGtOFnQ=;
        b=QzxKpGyeLLWU+3ltZmufy3+OI3/zAlaRDxjSmbzYjMCoPgcNsiVmMNWf2K/AvtM7IWn2iC
        p0ETsBjSD44iBSdlB3q7xzwTS5Qs5McgOIYlRCLFFPTycuYPdK1CDqJH4xQIds2Mjp1WMs
        vzRsAjyQHATomghjYjMMXiFXGPiRfBA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-418-Fngwl2JsMVqOO2ANcAr2Vw-1; Fri, 11 Feb 2022 17:16:41 -0500
X-MC-Unique: Fngwl2JsMVqOO2ANcAr2Vw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D1E7680A19E;
        Fri, 11 Feb 2022 22:16:40 +0000 (UTC)
Received: from localhost.localdomain (vpn2-54-22.bne.redhat.com [10.64.54.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 67296610A7;
        Fri, 11 Feb 2022 22:16:38 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH] cifs: do not use uninitialized data in the owner/group sid
Date:   Sat, 12 Feb 2022 08:16:20 +1000
Message-Id: <20220211221620.3311195-1-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

When idsfromsid is used we create a special SID for owner/group.
This structure must be initialized or else the first 5 bytes
of the Authority field of the SID will contain uninitialized data
and thus not be a valid SID.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/cifsacl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/cifsacl.c b/fs/cifs/cifsacl.c
index ee3aab3dd4ac..5df21d63dd04 100644
--- a/fs/cifs/cifsacl.c
+++ b/fs/cifs/cifsacl.c
@@ -1297,7 +1297,7 @@ static int build_sec_desc(struct cifs_ntsd *pntsd, struct cifs_ntsd *pnntsd,
 
 		if (uid_valid(uid)) { /* chown */
 			uid_t id;
-			nowner_sid_ptr = kmalloc(sizeof(struct cifs_sid),
+			nowner_sid_ptr = kzalloc(sizeof(struct cifs_sid),
 								GFP_KERNEL);
 			if (!nowner_sid_ptr) {
 				rc = -ENOMEM;
@@ -1326,7 +1326,7 @@ static int build_sec_desc(struct cifs_ntsd *pntsd, struct cifs_ntsd *pnntsd,
 		}
 		if (gid_valid(gid)) { /* chgrp */
 			gid_t id;
-			ngroup_sid_ptr = kmalloc(sizeof(struct cifs_sid),
+			ngroup_sid_ptr = kzalloc(sizeof(struct cifs_sid),
 								GFP_KERNEL);
 			if (!ngroup_sid_ptr) {
 				rc = -ENOMEM;
-- 
2.30.2

