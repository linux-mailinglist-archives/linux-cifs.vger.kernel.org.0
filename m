Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 594661074E6
	for <lists+linux-cifs@lfdr.de>; Fri, 22 Nov 2019 16:31:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726765AbfKVPbx (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 22 Nov 2019 10:31:53 -0500
Received: from mx.cjr.nz ([51.158.111.142]:28522 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726046AbfKVPbx (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 22 Nov 2019 10:31:53 -0500
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id EBAC580A50;
        Fri, 22 Nov 2019 15:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1574436712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Z2PGlxYkqE/MbgGFMcas1SfBopHv7+wAxidRk7fDhow=;
        b=BHBSw4fFmaICbEMGilxqUfFEfP2/vV/ckqNpKBLh2V65jhfx1ACS+4dowlcrCrgxtAHRdL
        ldre1v+aYZr6W7Fo254a/PJQvgLWtOI4QVkE3gzy2yjS5YYuy6FVYpUjlbkexVg9fL1lN7
        UkNyg1Z2fQRPX0kgvnpHucVe8P/8KUyFfgnHxMjePPN/EPeMjHcTPqIm8g243xNRauD8GB
        molZX6m0EU0Kcr3VzGke9O51bvhFdlLerJXIhuoru/NpQYmCozMH/ZIl8glXCchqmUV+5L
        tpfSGdKDEmGoSyCamvIkuBNtQ4VKibnkKkYYDvWm4x7z2tVuTolx7+ytTGFUVg==
From:   "Paulo Alcantara (SUSE)" <pc@cjr.nz>
To:     smfrench@gmail.com
Cc:     linux-cifs@vger.kernel.org, "Paulo Alcantara (SUSE)" <pc@cjr.nz>
Subject: [PATCH 7/7] cifs: Always update signing key of first channel
Date:   Fri, 22 Nov 2019 12:30:57 -0300
Message-Id: <20191122153057.6608-8-pc@cjr.nz>
In-Reply-To: <20191122153057.6608-1-pc@cjr.nz>
References: <20191122153057.6608-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Update signing key of first channel whenever generating the master
sigining/encryption/decryption keys rather than only in cifs_mount().

This also fixes reconnect when re-establishing smb sessions to other
servers.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---
 fs/cifs/smb2transport.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/cifs/smb2transport.c b/fs/cifs/smb2transport.c
index 86501239cef5..387c88704c52 100644
--- a/fs/cifs/smb2transport.c
+++ b/fs/cifs/smb2transport.c
@@ -407,6 +407,10 @@ generate_smb3signingkey(struct cifs_ses *ses,
 				  SMB3_SIGN_KEY_SIZE);
 		if (rc)
 			return rc;
+
+		memcpy(ses->chans[0].signkey, ses->smb3signingkey,
+		       SMB3_SIGN_KEY_SIZE);
+
 		rc = generate_key(ses, ptriplet->encryption.label,
 				  ptriplet->encryption.context,
 				  ses->smb3encryptionkey,
-- 
2.24.0

