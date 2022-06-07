Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84525540E07
	for <lists+linux-cifs@lfdr.de>; Tue,  7 Jun 2022 20:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1353477AbiFGSv6 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 7 Jun 2022 14:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354131AbiFGSqg (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 7 Jun 2022 14:46:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2575E11E1D1;
        Tue,  7 Jun 2022 11:00:10 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3EC74B81F38;
        Tue,  7 Jun 2022 18:00:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09635C341C0;
        Tue,  7 Jun 2022 18:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1654624806;
        bh=zv3owzUG00DKulByraUxelOJux4WspHORee8slLRpPU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mgNvY3sVikg/dLGCrncvscQssptZkYAXW9/hH73G30Zwcsj93CSIaZWiEOknp0sI5
         q1Zbxjsjjw1BA76KgtY2LJw0zuKGoNI3n5XRAxIROfJFKMe/eM1K8RBfO9yoBJmsBw
         R84tzgPBDa3BfGFIQRU4UY2IppdVbxfI2bfdNW0qtBxJX09sz06fRz1quEPTLr/RK8
         bgC3vEgpWnd8EPMx8sUgKBwrsCoLATTxjn4qS4BK72ON1NF2AnV/YdmBcMCWm4N1VK
         K+Cn6Jy/3yA8dBVx8OF/StuWWIZzSekm89bP8xm0WNDmgOaZkgKMdZ/UG2R3CobcCg
         QZqrlv2HBcKiQ==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Steve French <stfrench@microsoft.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>,
        Sasha Levin <sashal@kernel.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org, samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 5.10 37/38] cifs: version operations for smb20 unneeded when legacy support disabled
Date:   Tue,  7 Jun 2022 13:58:32 -0400
Message-Id: <20220607175835.480735-37-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220607175835.480735-1-sashal@kernel.org>
References: <20220607175835.480735-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

From: Steve French <stfrench@microsoft.com>

[ Upstream commit 7ef93ffccd55fb0ba000ed16ef6a81cd7dee07b5 ]

We should not be including unused smb20 specific code when legacy
support is disabled (CONFIG_CIFS_ALLOW_INSECURE_LEGACY turned
off).  For example smb2_operations and smb2_values aren't used
in that case.  Over time we can move more and more SMB1/CIFS and SMB2.0
code into the insecure legacy ifdefs

Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsglob.h | 4 +++-
 fs/cifs/smb2ops.c  | 7 ++++++-
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 6599069be690..196285b0fe46 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1982,11 +1982,13 @@ extern mempool_t *cifs_mid_poolp;
 
 /* Operations for different SMB versions */
 #define SMB1_VERSION_STRING	"1.0"
+#define SMB20_VERSION_STRING    "2.0"
+#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 extern struct smb_version_operations smb1_operations;
 extern struct smb_version_values smb1_values;
-#define SMB20_VERSION_STRING	"2.0"
 extern struct smb_version_operations smb20_operations;
 extern struct smb_version_values smb20_values;
+#endif /* CIFS_ALLOW_INSECURE_LEGACY */
 #define SMB21_VERSION_STRING	"2.1"
 extern struct smb_version_operations smb21_operations;
 extern struct smb_version_values smb21_values;
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index c758ff41b638..ece8969de850 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -4032,11 +4032,13 @@ smb3_set_oplock_level(struct cifsInodeInfo *cinode, __u32 oplock,
 	}
 }
 
+#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 static bool
 smb2_is_read_op(__u32 oplock)
 {
 	return oplock == SMB2_OPLOCK_LEVEL_II;
 }
+#endif /* CIFS_ALLOW_INSECURE_LEGACY */
 
 static bool
 smb21_is_read_op(__u32 oplock)
@@ -5122,7 +5124,7 @@ smb2_make_node(unsigned int xid, struct inode *inode,
 	return rc;
 }
 
-
+#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 struct smb_version_operations smb20_operations = {
 	.compare_fids = smb2_compare_fids,
 	.setup_request = smb2_setup_request,
@@ -5220,6 +5222,7 @@ struct smb_version_operations smb20_operations = {
 	.llseek = smb3_llseek,
 	.is_status_io_timeout = smb2_is_status_io_timeout,
 };
+#endif /* CIFS_ALLOW_INSECURE_LEGACY */
 
 struct smb_version_operations smb21_operations = {
 	.compare_fids = smb2_compare_fids,
@@ -5548,6 +5551,7 @@ struct smb_version_operations smb311_operations = {
 	.is_status_io_timeout = smb2_is_status_io_timeout,
 };
 
+#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
 struct smb_version_values smb20_values = {
 	.version_string = SMB20_VERSION_STRING,
 	.protocol_id = SMB20_PROT_ID,
@@ -5568,6 +5572,7 @@ struct smb_version_values smb20_values = {
 	.signing_required = SMB2_NEGOTIATE_SIGNING_REQUIRED,
 	.create_lease_size = sizeof(struct create_lease),
 };
+#endif /* ALLOW_INSECURE_LEGACY */
 
 struct smb_version_values smb21_values = {
 	.version_string = SMB21_VERSION_STRING,
-- 
2.35.1

