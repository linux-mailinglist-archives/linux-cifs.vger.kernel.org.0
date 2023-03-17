Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E29836BE7C7
	for <lists+linux-cifs@lfdr.de>; Fri, 17 Mar 2023 12:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbjCQLQA (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 17 Mar 2023 07:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229652AbjCQLP5 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 17 Mar 2023 07:15:57 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DBF35550C
        for <linux-cifs@vger.kernel.org>; Fri, 17 Mar 2023 04:15:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=zQWewxIqdzIXhHn7HsZjdcXiI+j/t7AbiYxHsi/YCRk=; b=OpZVlBpAsgbA+rvmzwul10Pfd7
        KsLm7IlLX/NzHFIPBX1CgMGaQkLCrQ6l3q3ACPngltCGUmmPjHaGhC9TlQBY5JC8KUM+CZMMtTgz/
        63T6zxaYGcRvjV/SzKW3TGs6ZfMgKvMk9J8+re+1wxBR9/PDjcK3LF1U5xkcxkqy1PkTNIp+4Nez8
        fSUO4zE5/jmcLf0PZ39E1RgHr8QNlW4wFZHNI9nChHwmE1CxZLZOtmwD2VQa2qSJbay77/bNJRIc+
        OPgPHTEnthbwZXo397hZSk3Nizaa4QpycVqg4d5dAOWzPgD83VDxJsFLeX+N7OUA7BoPw/Zq1iA79
        UvrYh+XlsR+NqjZAqUdn4Fg8ZseMySN++C1bm1fb3ziiqaQTCNVSVJCG6sKAU0Q8aJGkmnJJzejZT
        uRy0CgPvCvl6ZhsBRePVc8utT1xpEgAxGYiszzpOJIOaqSrnQoSy3bqIUCxpP4UEoBsPo+S9jWg+l
        vCh0w9fpMBvmCC1MTl3Upz8l;
Received: from [2a01:4f8:252:410e::177:224] (port=37520 helo=atb-devel-224..) 
        by hr2.samba.org with esmtp (Exim)
        id 1pd83o-003p4x-S7; Fri, 17 Mar 2023 11:15:49 +0000
From:   Volker Lendecke <vl@samba.org>
To:     linux-cifs@vger.kernel.org
Cc:     Volker Lendecke <vl@samba.org>
Subject: [PATCH 7/7] cifs: Avoid a cast in add_query_id_context()
Date:   Fri, 17 Mar 2023 11:15:28 +0000
Message-Id: <fdbbd11b8aa2363f01e6748f23d9dc253ba31e18.1679051552.git.vl@samba.org>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1679051552.git.vl@samba.org>
References: <cover.1679051552.git.vl@samba.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

We have the correctly-typed struct smb2_create_req * available in the
caller.

Signed-off-by: Volker Lendecke <vl@samba.org>
---
 fs/cifs/smb2pdu.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 9e9267da28a2..2ea7e211391f 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2524,9 +2524,9 @@ create_query_id_buf(void)
 
 /* See MS-SMB2 2.2.13.2.9 */
 static int
-add_query_id_context(struct kvec *iov, unsigned int *num_iovec)
+add_query_id_context(struct smb2_create_req *req,
+		     struct kvec *iov, unsigned int *num_iovec)
 {
-	struct smb2_create_req *req = iov[0].iov_base;
 	unsigned int num = *num_iovec;
 
 	iov[num].iov_base = create_query_id_buf();
@@ -2922,7 +2922,7 @@ SMB2_open_init(struct cifs_tcon *tcon, struct TCP_Server_Info *server,
 			(struct create_context *)iov[n_iov-1].iov_base;
 		ccontext->Next = cpu_to_le32(iov[n_iov-1].iov_len);
 	}
-	add_query_id_context(iov, &n_iov);
+	add_query_id_context(req, iov, &n_iov);
 
 	rqst->rq_nvec = n_iov;
 	return 0;
-- 
2.30.2

