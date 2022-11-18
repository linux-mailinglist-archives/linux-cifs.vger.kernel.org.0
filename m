Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18B4F62EE89
	for <lists+linux-cifs@lfdr.de>; Fri, 18 Nov 2022 08:37:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241278AbiKRHhl (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 18 Nov 2022 02:37:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241352AbiKRHhf (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 18 Nov 2022 02:37:35 -0500
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92652898C4
        for <linux-cifs@vger.kernel.org>; Thu, 17 Nov 2022 23:37:32 -0800 (PST)
Received: from dggpeml500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4ND7nJ6FQHzbmnM;
        Fri, 18 Nov 2022 15:33:40 +0800 (CST)
Received: from localhost.localdomain (10.175.101.6) by
 dggpeml500023.china.huawei.com (7.185.36.114) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 18 Nov 2022 15:37:30 +0800
From:   Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
To:     <linux-cifs@vger.kernel.org>, <zhangxiaoxu5@huawei.com>,
        <sfrench@samba.org>, <smfrench@gmail.com>, <pc@cjr.nz>,
        <lsahlber@redhat.com>, <sprasad@microsoft.com>, <tom@talpey.com>,
        <longli@microsoft.com>
Subject: [PATCH 2/2] cifs: Fix warning and UAF when destroy the MR list
Date:   Fri, 18 Nov 2022 16:42:08 +0800
Message-ID: <20221118084208.3214951-3-zhangxiaoxu5@huawei.com>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20221118084208.3214951-1-zhangxiaoxu5@huawei.com>
References: <20221118084208.3214951-1-zhangxiaoxu5@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpeml500023.china.huawei.com (7.185.36.114)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

If the MR allocate failed, the MR recovery work not initialized
and list not cleared. Then will be warning and UAF when release
the MR:

  WARNING: CPU: 4 PID: 824 at kernel/workqueue.c:3066 __flush_work.isra.0+0xf7/0x110
  CPU: 4 PID: 824 Comm: mount.cifs Not tainted 6.1.0-rc5+ #82
  RIP: 0010:__flush_work.isra.0+0xf7/0x110
  Call Trace:
   <TASK>
   __cancel_work_timer+0x2ba/0x2e0
   smbd_destroy+0x4e1/0x990
   _smbd_get_connection+0x1cbd/0x2110
   smbd_get_connection+0x21/0x40
   cifs_get_tcp_session+0x8ef/0xda0
   mount_get_conns+0x60/0x750
   cifs_mount+0x103/0xd00
   cifs_smb3_do_mount+0x1dd/0xcb0
   smb3_get_tree+0x1d5/0x300
   vfs_get_tree+0x41/0xf0
   path_mount+0x9b3/0xdd0
   __x64_sys_mount+0x190/0x1d0
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

  BUG: KASAN: use-after-free in smbd_destroy+0x4fc/0x990
  Read of size 8 at addr ffff88810b156a08 by task mount.cifs/824
  CPU: 4 PID: 824 Comm: mount.cifs Tainted: G        W          6.1.0-rc5+ #82
  Call Trace:
   dump_stack_lvl+0x34/0x44
   print_report+0x171/0x472
   kasan_report+0xad/0x130
   smbd_destroy+0x4fc/0x990
   _smbd_get_connection+0x1cbd/0x2110
   smbd_get_connection+0x21/0x40
   cifs_get_tcp_session+0x8ef/0xda0
   mount_get_conns+0x60/0x750
   cifs_mount+0x103/0xd00
   cifs_smb3_do_mount+0x1dd/0xcb0
   smb3_get_tree+0x1d5/0x300
   vfs_get_tree+0x41/0xf0
   path_mount+0x9b3/0xdd0
   __x64_sys_mount+0x190/0x1d0
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

  Allocated by task 824:
   kasan_save_stack+0x1e/0x40
   kasan_set_track+0x21/0x30
   __kasan_kmalloc+0x7a/0x90
   _smbd_get_connection+0x1b6f/0x2110
   smbd_get_connection+0x21/0x40
   cifs_get_tcp_session+0x8ef/0xda0
   mount_get_conns+0x60/0x750
   cifs_mount+0x103/0xd00
   cifs_smb3_do_mount+0x1dd/0xcb0
   smb3_get_tree+0x1d5/0x300
   vfs_get_tree+0x41/0xf0
   path_mount+0x9b3/0xdd0
   __x64_sys_mount+0x190/0x1d0
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

  Freed by task 824:
   kasan_save_stack+0x1e/0x40
   kasan_set_track+0x21/0x30
   kasan_save_free_info+0x2a/0x40
   ____kasan_slab_free+0x143/0x1b0
   __kmem_cache_free+0xc8/0x330
   _smbd_get_connection+0x1c6a/0x2110
   smbd_get_connection+0x21/0x40
   cifs_get_tcp_session+0x8ef/0xda0
   mount_get_conns+0x60/0x750
   cifs_mount+0x103/0xd00
   cifs_smb3_do_mount+0x1dd/0xcb0
   smb3_get_tree+0x1d5/0x300
   vfs_get_tree+0x41/0xf0
   path_mount+0x9b3/0xdd0
   __x64_sys_mount+0x190/0x1d0
   do_syscall_64+0x35/0x80
   entry_SYSCALL_64_after_hwframe+0x46/0xb0

Let's initialize the MR recovery work before MR allocate to prevent
the warning, remove the MRs from the list to prevent the UAF.

Fixes: c7398583340a ("CIFS: SMBD: Implement RDMA memory registration")
Signed-off-by: Zhang Xiaoxu <zhangxiaoxu5@huawei.com>
---
 fs/cifs/smbdirect.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index a874c2e1ae41..7013fdb4ea51 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -2217,6 +2217,7 @@ static int allocate_mr_list(struct smbd_connection *info)
 	atomic_set(&info->mr_ready_count, 0);
 	atomic_set(&info->mr_used_count, 0);
 	init_waitqueue_head(&info->wait_for_mr_cleanup);
+	INIT_WORK(&info->mr_recovery_work, smbd_mr_recovery_work);
 	/* Allocate more MRs (2x) than hardware responder_resources */
 	for (i = 0; i < info->responder_resources * 2; i++) {
 		smbdirect_mr = kzalloc(sizeof(*smbdirect_mr), GFP_KERNEL);
@@ -2244,13 +2245,13 @@ static int allocate_mr_list(struct smbd_connection *info)
 		list_add_tail(&smbdirect_mr->list, &info->mr_list);
 		atomic_inc(&info->mr_ready_count);
 	}
-	INIT_WORK(&info->mr_recovery_work, smbd_mr_recovery_work);
 	return 0;
 
 out:
 	kfree(smbdirect_mr);
 
 	list_for_each_entry_safe(smbdirect_mr, tmp, &info->mr_list, list) {
+		list_del(&smbdirect_mr->list);
 		ib_dereg_mr(smbdirect_mr->mr);
 		kfree(smbdirect_mr->sgl);
 		kfree(smbdirect_mr);
-- 
2.31.1

