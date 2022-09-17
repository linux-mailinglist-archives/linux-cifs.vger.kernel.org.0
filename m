Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D705BB4D4
	for <lists+linux-cifs@lfdr.de>; Sat, 17 Sep 2022 01:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229564AbiIPX5P (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 16 Sep 2022 19:57:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbiIPX5O (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 16 Sep 2022 19:57:14 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3C52BB937
        for <linux-cifs@vger.kernel.org>; Fri, 16 Sep 2022 16:57:13 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 52A7134345;
        Fri, 16 Sep 2022 23:57:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1663372631; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xPUqcYt2T29JDn/O0YQHqD1THmhxA/jmrSS5vKpgV8Y=;
        b=NY8cluRzuRbrgqNeDl29i38q/rQUzzK/SG4t3lhNHyvmchVSbeaZhMJMKDbAHl+In75v4W
        NQE9psM9fpKfistrIVBwp6YJDtvkXJFLbgZDX/LJCKsuaOgvrZF1isvEQs9GIT3hlJhnUz
        q7/a3MeXesm4d0Lc4hDRKcW0vjg9CU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1663372631;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=xPUqcYt2T29JDn/O0YQHqD1THmhxA/jmrSS5vKpgV8Y=;
        b=Nym//mrBw9V05fFYUNdH+FGQZOueWwAONApLmkRJVdiv+hDEq8aZPFexdMjSZpOYYGYkft
        cWvfZryQ19o407Aw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C8722132DB;
        Fri, 16 Sep 2022 23:57:10 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id igbIIlYNJWOTEAAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Fri, 16 Sep 2022 23:57:10 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, pc@cjr.nz, ronniesahlberg@gmail.com,
        nspmangalore@gmail.com
Subject: [PATCH] cifs: return correct error in ->calc_signature()
Date:   Fri, 16 Sep 2022 20:57:05 -0300
Message-Id: <20220916235705.14044-1-ematsumiya@suse.de>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

If an error happens while getting the key or session in the
->calc_signature implementations, 0 (success) is returned. Fix it by
returning a proper error code.

Since it seems to be highly unlikely to happen wrap the rc check in
unlikely() too.

Fixes: 32811d242ff6 ("cifs: Start using per session key for smb2/3 for signature generation")
Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 fs/cifs/smb2transport.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/fs/cifs/smb2transport.c b/fs/cifs/smb2transport.c
index 1a5fc3314dbf..4640fc4a8b13 100644
--- a/fs/cifs/smb2transport.c
+++ b/fs/cifs/smb2transport.c
@@ -225,9 +225,9 @@ smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 	struct smb_rqst drqst;
 
 	ses = smb2_find_smb_ses(server, le64_to_cpu(shdr->SessionId));
-	if (!ses) {
+	if (unlikely(!ses)) {
 		cifs_server_dbg(VFS, "%s: Could not find session\n", __func__);
-		return 0;
+		return -ENOENT;
 	}
 
 	memset(smb2_signature, 0x0, SMB2_HMACSHA256_SIZE);
@@ -557,8 +557,10 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *server,
 	u8 key[SMB3_SIGN_KEY_SIZE];
 
 	rc = smb2_get_sign_key(le64_to_cpu(shdr->SessionId), server, key);
-	if (rc)
-		return 0;
+	if (unlikely(rc)) {
+		cifs_server_dbg(VFS, "%s: Could not get signing key\n", __func__);
+		return rc;
+	}
 
 	if (allocate_crypto) {
 		rc = cifs_alloc_hash("cmac(aes)", &hash, &sdesc);
-- 
2.35.3

