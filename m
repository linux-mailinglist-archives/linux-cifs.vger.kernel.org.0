Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AA2A7889D5
	for <lists+linux-cifs@lfdr.de>; Fri, 25 Aug 2023 16:01:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245489AbjHYOBY (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 25 Aug 2023 10:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245493AbjHYOAz (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 25 Aug 2023 10:00:55 -0400
Received: from out-247.mta1.migadu.com (out-247.mta1.migadu.com [95.215.58.247])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53FF3268F;
        Fri, 25 Aug 2023 07:00:29 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1692972015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CL8wzJoAbQ75iZcN0EHSqoGXIWt+IFMvEgcKIhs6zqE=;
        b=UXdbOLDkxTPiI/RUD6vA6Y59upGR8p9yuOS0cheVOmW9wy55dk0PwGqrHNQocUaxtZPqwl
        8SMpVuiY/GUEZaQEBzm6P0e4nsRhzT+GENJ6bzTIZGRyqbBvQsF+Q3u8++NZNdyfo398WE
        Pbto4Fcj8Lgxb50rhsqaYEakh0iY2/E=
From:   Hao Xu <hao.xu@linux.dev>
To:     io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Cc:     Dominique Martinet <asmadeus@codewreck.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        Christian Brauner <brauner@kernel.org>,
        Alexander Viro <viro@zeniv.linux.org.uk>,
        Stefan Roesch <shr@fb.com>, Clay Harris <bugs@claycon.org>,
        Dave Chinner <david@fromorbit.com>,
        "Darrick J . Wong" <djwong@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-xfs@vger.kernel.org,
        linux-ext4@vger.kernel.org, linux-cachefs@redhat.com,
        ecryptfs@vger.kernel.org, linux-nfs@vger.kernel.org,
        linux-unionfs@vger.kernel.org, bpf@vger.kernel.org,
        netdev@vger.kernel.org, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-btrfs@vger.kernel.org, codalist@coda.cs.cmu.edu,
        linux-f2fs-devel@lists.sourceforge.net, cluster-devel@redhat.com,
        linux-mm@kvack.org, linux-nilfs@vger.kernel.org,
        devel@lists.orangefs.org, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org, linux-mtd@lists.infradead.org,
        Wanpeng Li <wanpengli@tencent.com>
Subject: [PATCH 11/29] vfs: trylock inode->i_rwsem in iterate_dir() to support nowait
Date:   Fri, 25 Aug 2023 21:54:13 +0800
Message-Id: <20230825135431.1317785-12-hao.xu@linux.dev>
In-Reply-To: <20230825135431.1317785-1-hao.xu@linux.dev>
References: <20230825135431.1317785-1-hao.xu@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

From: Hao Xu <howeyxu@tencent.com>

Trylock inode->i_rwsem in iterate_dir() to support nowait semantics and
error out -EAGAIN when there is contention.

Signed-off-by: Hao Xu <howeyxu@tencent.com>
---
 fs/readdir.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/fs/readdir.c b/fs/readdir.c
index 6469f076ba6e..664ecd9665a1 100644
--- a/fs/readdir.c
+++ b/fs/readdir.c
@@ -43,6 +43,8 @@ int iterate_dir(struct file *file, struct dir_context *ctx)
 	struct inode *inode = file_inode(file);
 	bool shared = false;
 	int res = -ENOTDIR;
+	bool nowait;
+
 	if (file->f_op->iterate_shared)
 		shared = true;
 	else if (!file->f_op->iterate)
@@ -52,16 +54,22 @@ int iterate_dir(struct file *file, struct dir_context *ctx)
 	if (res)
 		goto out;
 
-	if (shared)
-		res = down_read_killable(&inode->i_rwsem);
-	else
-		res = down_write_killable(&inode->i_rwsem);
-	if (res)
+	nowait = ctx->flags & DIR_CONTEXT_F_NOWAIT;
+	if (nowait) {
+		res = shared ? down_read_trylock(&inode->i_rwsem) :
+			       down_write_trylock(&inode->i_rwsem);
+		if (!res)
+			res = -EAGAIN;
+	} else {
+		res = shared ? down_read_killable(&inode->i_rwsem) :
+			       down_write_killable(&inode->i_rwsem);
+	}
+	if (res < 0)
 		goto out;
 
 	res = -ENOENT;
 	if (!IS_DEADDIR(inode)) {
-		res = file_accessed(file, ctx->flags & DIR_CONTEXT_F_NOWAIT);
+		res = file_accessed(file, nowait);
 		if (res == -EAGAIN)
 			goto out_unlock;
 
-- 
2.25.1

