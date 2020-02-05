Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B68EE1523B9
	for <lists+linux-cifs@lfdr.de>; Wed,  5 Feb 2020 01:05:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727494AbgBEAFn (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 4 Feb 2020 19:05:43 -0500
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:41136 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727483AbgBEAFn (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 4 Feb 2020 19:05:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580861141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=MkVN0ZXTvgBQGlTU0OcVleIUETVJoiw41bdiNCgw6WA=;
        b=Oaq/ZtHc16w5ZsSyUyhvUsCBg0rVEVCbBmcl7wlA93KBLd65fVb8MbVfEjDpNfyuS5As+6
        02eeKpWhRfe/v7/Blku3sd2GsbEeTjQCZMbWleAPKHjgzK4d8Jc4GuFm76CXOYr4K6OWx7
        OWmnqwsIp3MoY81pRFmZ09cj/NiRFIA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-309-paVWk8nFNdySfORS8mdIbg-1; Tue, 04 Feb 2020 19:05:38 -0500
X-MC-Unique: paVWk8nFNdySfORS8mdIbg-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 021301413
        for <linux-cifs@vger.kernel.org>; Wed,  5 Feb 2020 00:05:38 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-71.bne.redhat.com [10.64.54.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8751E5C1D8;
        Wed,  5 Feb 2020 00:05:37 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH] cifs: fail i/o on soft mounts if sessionsetup errors out
Date:   Wed,  5 Feb 2020 10:05:29 +1000
Message-Id: <20200205000529.5936-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

RHBZ: 1579050

If we have a soft mount we should fail commands for session-setup
failures (such as the password having changed/ account being deleted/ ...)
and return an error back to the application.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/smb2pdu.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 14f209f7376f..879e058a73f9 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -350,9 +350,14 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon)
 	}
 
 	rc = cifs_negotiate_protocol(0, tcon->ses);
-	if (!rc && tcon->ses->need_reconnect)
+	if (!rc && tcon->ses->need_reconnect) {
 		rc = cifs_setup_session(0, tcon->ses, nls_codepage);
-
+		if (rc && !tcon->retry) {
+			rc = -EHOSTDOWN;
+			mutex_unlock(&tcon->ses->session_mutex);
+			goto failed;
+		}
+	}
 	if (rc || !tcon->need_reconnect) {
 		mutex_unlock(&tcon->ses->session_mutex);
 		goto out;
@@ -397,6 +402,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon)
 	case SMB2_SET_INFO:
 		rc = -EAGAIN;
 	}
+failed:
 	unload_nls(nls_codepage);
 	return rc;
 }
-- 
2.13.6

