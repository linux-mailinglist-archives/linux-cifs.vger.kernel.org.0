Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59E1F5F5D08
	for <lists+linux-cifs@lfdr.de>; Thu,  6 Oct 2022 01:04:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229508AbiJEXEb (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 5 Oct 2022 19:04:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229590AbiJEXEa (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 5 Oct 2022 19:04:30 -0400
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F4CA855BB
        for <linux-cifs@vger.kernel.org>; Wed,  5 Oct 2022 16:04:28 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 08C437FE8A;
        Wed,  5 Oct 2022 23:04:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1665011066;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=csHxvuV8Sk75jLnUJEGJ+/F49nS0IeOTlikUvBXSFRc=;
        b=ALoZ61nWu3043JnvVj7m7dGejiprkkZgLOclkRWKoUn2eduiFDu/tMWeFZx8Kk3NS+nl6m
        dAQlJJ41p/0K822g3Cl1DzSqNkTccI4JsU3aMrdC7fsaM8MxwVmaBQ1taBlK/T8lwXUHrN
        Xigfjy0YULLNrlgjjzMQJKP94ZHcjcSTY/+4YoZCDYNntytzgP3V8uCyu8Tzo9RBYe9Nyb
        YnvGOdVMgcs1wRu8ZPaPgyAUCnk0ZgIkxn/Uhkt7NKcmtkF4WtuOQevkS8wX8x3qKIRhWG
        kzDEynjdlPy6xEkPfVvk7/ubBL2xdey3uSME/wTPEV4C8l59lwEqcC2KOSnzNg==
From:   Paulo Alcantara <pc@cjr.nz>
To:     smfrench@gmail.com
Cc:     linux-cifs@vger.kernel.org, Paulo Alcantara <pc@cjr.nz>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v3 2/2] cifs: fix uninitialised var in smb2_compound_op()
Date:   Wed,  5 Oct 2022 20:04:47 -0300
Message-Id: <20221005230447.9551-2-pc@cjr.nz>
In-Reply-To: <20221005230447.9551-1-pc@cjr.nz>
References: <20221004181325.15207-1-pc@cjr.nz>
 <20221005230447.9551-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Fix uninitialised variable @idata when calling smb2_compound_op() with
SMB2_OP_POSIX_QUERY_INFO.

Fixes: 5079f2691f73 ("cifs: improve symlink handling for smb2+")
Reported-by: kernel test robot <lkp@intel.com>
Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---
v2 -> v3: no changes

 fs/cifs/smb2inode.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/cifs/smb2inode.c b/fs/cifs/smb2inode.c
index adf71b328f32..a6640e6ea58b 100644
--- a/fs/cifs/smb2inode.c
+++ b/fs/cifs/smb2inode.c
@@ -415,6 +415,7 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 						tcon->tid);
 		break;
 	case SMB2_OP_POSIX_QUERY_INFO:
+		idata = ptr;
 		if (rc == 0 && cfile && cfile->symlink_target) {
 			idata->symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
 			if (!idata->symlink_target)
-- 
2.37.3

