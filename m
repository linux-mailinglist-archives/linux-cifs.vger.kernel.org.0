Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 740F662C22C
	for <lists+linux-cifs@lfdr.de>; Wed, 16 Nov 2022 16:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233861AbiKPPRl (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 16 Nov 2022 10:17:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233697AbiKPPRi (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 16 Nov 2022 10:17:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801D24FF82;
        Wed, 16 Nov 2022 07:17:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C8B5B81DC0;
        Wed, 16 Nov 2022 15:17:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00854C43470;
        Wed, 16 Nov 2022 15:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668611854;
        bh=PD+6nv8c5dN3Wkd3cLoPzM9DTqnWGjUkaCEfb0sQeK0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fYfcY5d4XycDOkE9YDEPcHL4XBS6Ap8sR2ZzFJCTsummRJIZ0VwKrUh8eFbVl87qh
         2li0TrJDQzcT+loUKhy4s2X8d22RLz91mNAM74RyY2Kb2dXNqhtIgz1qgxeBJ/96Cr
         vgpy5dhy/6GCDoRNBTZ5b2vj14wt9VfO1nV+cH7AOHSkWoC+F3R9l9keDQJACmdu5n
         X64sh7AVDJLaFPxbQGv41HlApD+jcgdNNQ8tovL/65iK4cqkPnGjEDqdFFkLDguLcf
         rg0x3xWoHqI14NweRpnljW80akrlW6OtvRt95ptLjY08S0memHVrfEEyXvh/h/zJe3
         5ANR0oE7ybCBQ==
From:   Jeff Layton <jlayton@kernel.org>
To:     linux-fsdevel@vger.kernel.org
Cc:     linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org,
        linux-cifs@vger.kernel.org, chuck.lever@oracle.com,
        viro@zeniv.linux.org.uk, hch@lst.de,
        Trond Myklebust <trond.myklebust@hammerspace.com>,
        Anna Schumaker <anna@kernel.org>
Subject: [PATCH 5/7] lockd: use locks_inode_context helper
Date:   Wed, 16 Nov 2022 10:17:24 -0500
Message-Id: <20221116151726.129217-6-jlayton@kernel.org>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221116151726.129217-1-jlayton@kernel.org>
References: <20221116151726.129217-1-jlayton@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

lockd currently doesn't access i_flctx safely. This requires a
smp_load_acquire, as the pointer is set via cmpxchg (a release
operation).

Cc: Trond Myklebust <trond.myklebust@hammerspace.com>
Cc: Anna Schumaker <anna@kernel.org>
Cc: Chuck Lever <chuck.lever@oracle.com>
Signed-off-by: Jeff Layton <jlayton@kernel.org>
---
 fs/lockd/svcsubs.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/lockd/svcsubs.c b/fs/lockd/svcsubs.c
index e1c4617de771..720684345817 100644
--- a/fs/lockd/svcsubs.c
+++ b/fs/lockd/svcsubs.c
@@ -207,7 +207,7 @@ nlm_traverse_locks(struct nlm_host *host, struct nlm_file *file,
 {
 	struct inode	 *inode = nlmsvc_file_inode(file);
 	struct file_lock *fl;
-	struct file_lock_context *flctx = inode->i_flctx;
+	struct file_lock_context *flctx = locks_inode_context(inode);
 	struct nlm_host	 *lockhost;
 
 	if (!flctx || list_empty_careful(&flctx->flc_posix))
@@ -262,7 +262,7 @@ nlm_file_inuse(struct nlm_file *file)
 {
 	struct inode	 *inode = nlmsvc_file_inode(file);
 	struct file_lock *fl;
-	struct file_lock_context *flctx = inode->i_flctx;
+	struct file_lock_context *flctx = locks_inode_context(inode);
 
 	if (file->f_count || !list_empty(&file->f_blocks) || file->f_shares)
 		return 1;
-- 
2.38.1

