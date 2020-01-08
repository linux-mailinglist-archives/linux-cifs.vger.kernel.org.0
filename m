Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9954B133964
	for <lists+linux-cifs@lfdr.de>; Wed,  8 Jan 2020 04:08:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726180AbgAHDIW (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 7 Jan 2020 22:08:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:30713 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725812AbgAHDIW (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 7 Jan 2020 22:08:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1578452901;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=aIxQJ5OGWzWFW+W3iYBzEYdH6BYzlvJttY3JCEJMmqs=;
        b=JYoo9y4QLRYgqAUkU66jkU6UmFTwaFsxPCNvti0NsgAkm5yLE/XLa29UZqhY6RAtTnACwQ
        M7ijGuh3skT+6AY0YSZhfmJMiS/iixCoVRbPiOqhbylxMmwT7tSB3xCetOZd1hLlxIhEjE
        m4Q3i5Gd6hCaCqNBIsZ5x/ZXUWFFMD0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-286-aIVKlQTkPJS0w7DkjcnPgA-1; Tue, 07 Jan 2020 22:08:18 -0500
X-MC-Unique: aIVKlQTkPJS0w7DkjcnPgA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 12E7110054E3
        for <linux-cifs@vger.kernel.org>; Wed,  8 Jan 2020 03:08:18 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-61.bne.redhat.com [10.64.54.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9E0305C1BB;
        Wed,  8 Jan 2020 03:08:17 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4/4] cifs: set correct max-buffer-size for smb2_ioctl_init()
Date:   Wed,  8 Jan 2020 13:08:07 +1000
Message-Id: <20200108030807.2460-5-lsahlber@redhat.com>
In-Reply-To: <20200108030807.2460-1-lsahlber@redhat.com>
References: <20200108030807.2460-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Fix two places where we need to adjust down the max response size for
ioctl when it is used together with compounding.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/smb2ops.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index ca8e807f9b07..f2a321e97dcc 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1523,7 +1523,9 @@ smb2_ioctl_query_info(const unsigned int xid,
 					     COMPOUND_FID, COMPOUND_FID,
 					     qi.info_type, true, buffer,
 					     qi.output_buffer_length,
-					     CIFSMaxBufSize);
+					     CIFSMaxBufSize -
+					     MAX_SMB2_CREATE_RESPONSE_SIZE -
+					     MAX_SMB2_CLOSE_RESPONSE_SIZE);
 		}
 	} else if (qi.flags == PASSTHRU_SET_INFO) {
 		/* Can eventually relax perm check since server enforces too */
@@ -2769,7 +2771,10 @@ smb2_query_symlink(const unsigned int xid, struct cifs_tcon *tcon,
 
 	rc = SMB2_ioctl_init(tcon, &rqst[1], fid.persistent_fid,
 			     fid.volatile_fid, FSCTL_GET_REPARSE_POINT,
-			     true /* is_fctl */, NULL, 0, CIFSMaxBufSize);
+			     true /* is_fctl */, NULL, 0,
+			     CIFSMaxBufSize -
+			     MAX_SMB2_CREATE_RESPONSE_SIZE -
+			     MAX_SMB2_CLOSE_RESPONSE_SIZE);
 	if (rc)
 		goto querty_exit;
 
-- 
2.13.6

