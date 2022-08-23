Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D3E059E7D5
	for <lists+linux-cifs@lfdr.de>; Tue, 23 Aug 2022 18:51:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242407AbiHWQrj (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 23 Aug 2022 12:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41368 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344195AbiHWQq4 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 23 Aug 2022 12:46:56 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C32E0BF7A
        for <linux-cifs@vger.kernel.org>; Tue, 23 Aug 2022 07:25:37 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6FE60336D1;
        Tue, 23 Aug 2022 14:25:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1661264736; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2pQebq73Ru6L/krotJs1SW8tHwV8b7h2EqxLJjir+II=;
        b=Di2brpKfd9cHVhHCUya+rwnDN5H9/bZF4SB/3w+0OMSKAXWwJGgYUAL2qts1CqezvJEZF+
        mOcZ2iQHieW3rPGJwF8h9oiOF0JYunZv+ofcWIJUeTWSgyVOrUFEyDuGpNciSpKNQUlxwX
        jyKSb0sEv62s9Z8BlOpI8q5UT2hSDFo=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1661264736;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=2pQebq73Ru6L/krotJs1SW8tHwV8b7h2EqxLJjir+II=;
        b=IfX3KCO0jvA3eRHBeUczILVh1VnF+Q5ouN4h1RzX3EiP+z+VlgrXCwymU3AxxC/NaCmbVG
        sW7mGE1gUj4XY6Cw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DF64E13AB7;
        Tue, 23 Aug 2022 14:25:35 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id PcPwJ1/jBGM9fwAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Tue, 23 Aug 2022 14:25:35 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, pc@cjr.nz, ronniesahlberg@gmail.com,
        nspmangalore@gmail.com
Subject: [PATCH] cifs: fix some memory leak when negotiate/session setup fails
Date:   Tue, 23 Aug 2022 11:25:31 -0300
Message-Id: <20220823142531.9057-1-ematsumiya@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Fix memory leaks from some ses fields when cifs_negotiate_protocol() or
cifs_setup_session() fails in cifs_get_smb_ses().

A leak from ses->domainName has also been identified in setup_ntlmv2_rsp()
when session setup fails.

These has been reported by kmemleak.

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 fs/cifs/cifsencrypt.c |  5 +++++
 fs/cifs/connect.c     | 22 ++++++++++++++++------
 2 files changed, 21 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
index 8f7835ccbca1..6b681b7084f5 100644
--- a/fs/cifs/cifsencrypt.c
+++ b/fs/cifs/cifsencrypt.c
@@ -680,6 +680,11 @@ setup_ntlmv2_rsp(struct cifs_ses *ses, const struct nls_table *nls_cp)
 unlock:
 	cifs_server_unlock(ses->server);
 setup_ntlmv2_rsp_ret:
+	if (rc && ses->domainName) {
+		kfree(ses->domainName);
+		ses->domainName = NULL;
+	}
+
 	kfree(tiblob);
 
 	return rc;
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 3da5da9f16b0..49162973ca30 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -2215,7 +2215,7 @@ cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 	cifs_dbg(FYI, "Existing smb sess not found\n");
 	ses = sesInfoAlloc();
 	if (ses == NULL)
-		goto get_ses_fail;
+		goto out;
 
 	/* new SMB session uses our server ref */
 	ses->server = server;
@@ -2227,19 +2227,19 @@ cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 	if (ctx->username) {
 		ses->user_name = kstrdup(ctx->username, GFP_KERNEL);
 		if (!ses->user_name)
-			goto get_ses_fail;
+			goto out_free_ses;
 	}
 
 	/* ctx->password freed at unmount */
 	if (ctx->password) {
 		ses->password = kstrdup(ctx->password, GFP_KERNEL);
 		if (!ses->password)
-			goto get_ses_fail;
+			goto out_free_username;
 	}
 	if (ctx->domainname) {
 		ses->domainName = kstrdup(ctx->domainname, GFP_KERNEL);
 		if (!ses->domainName)
-			goto get_ses_fail;
+			goto out_free_pw;
 	}
 
 	strscpy(ses->workstation_name, ctx->workstation_name, sizeof(ses->workstation_name));
@@ -2273,7 +2273,7 @@ cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 	spin_unlock(&ses->chan_lock);
 
 	if (rc)
-		goto get_ses_fail;
+		goto out_free_domain;
 
 	/*
 	 * success, put it on the list and add it as first channel
@@ -2290,8 +2290,18 @@ cifs_get_smb_ses(struct TCP_Server_Info *server, struct smb3_fs_context *ctx)
 
 	return ses;
 
-get_ses_fail:
+out_free_domain:
+	kfree(ses->domainName);
+	ses->domainName = NULL;
+out_free_pw:
+	kfree(ses->password);
+	ses->password = NULL;
+out_free_username:
+	kfree(ses->user_name);
+	ses->user_name = NULL;
+out_free_ses:
 	sesInfoFree(ses);
+out:
 	free_xid(xid);
 	return ERR_PTR(rc);
 }
-- 
2.35.3

