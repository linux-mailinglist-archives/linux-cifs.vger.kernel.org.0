Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19A8677A7B3
	for <lists+linux-cifs@lfdr.de>; Sun, 13 Aug 2023 17:50:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231604AbjHMPuK (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 13 Aug 2023 11:50:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjHMPuD (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 13 Aug 2023 11:50:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C629B1730;
        Sun, 13 Aug 2023 08:49:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 62983620EA;
        Sun, 13 Aug 2023 15:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE9F6C433CC;
        Sun, 13 Aug 2023 15:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1691941795;
        bh=JH2nSLWJdP3wt0AYgzz3OVEvtKEHvG+QFee2dIqlOQA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ru+eCFRpRb4o/jxb2jeaNhgBWhl7AaWoMZKdHYUl4jgX2P8STdEoYlZwF8UDdm7/7
         h9SoVJ7lSAAyptbVi2o5/eYriyg+xxONBjHBTuSYxDm+HbXX2lTwJbmErG9fFq6Eji
         KoXzqX61L9ubB0c6+ebkdgzC/Ugt/MZtZP/q2tW9t3G646xCljHeo+SDzBn1lUwOa8
         65Znwty4VHZ2ImydstjqjZs3CbZU8IGFRD23pMwtr2k+r+pqJ3E69fKEdX2N3YaJ8+
         HtFTdyZnnT3+F1bic7HB0lthgPshz6pCzDwq0dMtfNkKi5xVvRKDQmBemnxyxkaH5D
         7dHZcwfoMPvRw==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>,
        zdi-disclosures@trendmicro.com,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, sfrench@samba.org,
        linux-cifs@vger.kernel.org
Subject: [PATCH AUTOSEL 6.4 12/54] ksmbd: validate session id and tree id in compound request
Date:   Sun, 13 Aug 2023 11:48:51 -0400
Message-Id: <20230813154934.1067569-12-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230813154934.1067569-1-sashal@kernel.org>
References: <20230813154934.1067569-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.4.10
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

[ Upstream commit 3df0411e132ee74a87aa13142dfd2b190275332e ]

`smb2_get_msg()` in smb2_get_ksmbd_tcon() and smb2_check_user_session()
will always return the first request smb2 header in a compound request.
if `SMB2_TREE_CONNECT_HE` is the first command in compound request, will
return 0, i.e. The tree id check is skipped.
This patch use ksmbd_req_buf_next() to get current command in compound.

Reported-by: zdi-disclosures@trendmicro.com # ZDI-CAN-21506
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/server/smb2pdu.c | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/smb/server/smb2pdu.c b/fs/smb/server/smb2pdu.c
index bd3da6cc6a98e..f4421d4bff0f8 100644
--- a/fs/smb/server/smb2pdu.c
+++ b/fs/smb/server/smb2pdu.c
@@ -87,9 +87,9 @@ struct channel *lookup_chann_list(struct ksmbd_session *sess, struct ksmbd_conn
  */
 int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 {
-	struct smb2_hdr *req_hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *req_hdr = ksmbd_req_buf_next(work);
 	unsigned int cmd = le16_to_cpu(req_hdr->Command);
-	int tree_id;
+	unsigned int tree_id;
 
 	if (cmd == SMB2_TREE_CONNECT_HE ||
 	    cmd ==  SMB2_CANCEL_HE ||
@@ -114,7 +114,7 @@ int smb2_get_ksmbd_tcon(struct ksmbd_work *work)
 			pr_err("The first operation in the compound does not have tcon\n");
 			return -EINVAL;
 		}
-		if (work->tcon->id != tree_id) {
+		if (tree_id != UINT_MAX && work->tcon->id != tree_id) {
 			pr_err("tree id(%u) is different with id(%u) in first operation\n",
 					tree_id, work->tcon->id);
 			return -EINVAL;
@@ -559,9 +559,9 @@ int smb2_allocate_rsp_buf(struct ksmbd_work *work)
  */
 int smb2_check_user_session(struct ksmbd_work *work)
 {
-	struct smb2_hdr *req_hdr = smb2_get_msg(work->request_buf);
+	struct smb2_hdr *req_hdr = ksmbd_req_buf_next(work);
 	struct ksmbd_conn *conn = work->conn;
-	unsigned int cmd = conn->ops->get_cmd_val(work);
+	unsigned int cmd = le16_to_cpu(req_hdr->Command);
 	unsigned long long sess_id;
 
 	/*
@@ -587,7 +587,7 @@ int smb2_check_user_session(struct ksmbd_work *work)
 			pr_err("The first operation in the compound does not have sess\n");
 			return -EINVAL;
 		}
-		if (work->sess->id != sess_id) {
+		if (sess_id != ULLONG_MAX && work->sess->id != sess_id) {
 			pr_err("session id(%llu) is different with the first operation(%lld)\n",
 					sess_id, work->sess->id);
 			return -EINVAL;
-- 
2.40.1

