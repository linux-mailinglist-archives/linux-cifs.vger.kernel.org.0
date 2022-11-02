Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78089615BAD
	for <lists+linux-cifs@lfdr.de>; Wed,  2 Nov 2022 06:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiKBFMf (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 2 Nov 2022 01:12:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKBFMe (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 2 Nov 2022 01:12:34 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CCAC252AB;
        Tue,  1 Nov 2022 22:12:32 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4N2FLS5S7NzJnJ3;
        Wed,  2 Nov 2022 13:09:36 +0800 (CST)
Received: from kwepemm600015.china.huawei.com (7.193.23.52) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 2 Nov 2022 13:12:30 +0800
Received: from huawei.com (10.175.101.6) by kwepemm600015.china.huawei.com
 (7.193.23.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 2 Nov
 2022 13:12:29 +0800
From:   ChenXiaoSong <chenxiaosong2@huawei.com>
To:     <sfrench@samba.org>, <pc@cjr.nz>, <lsahlber@redhat.com>
CC:     <linux-cifs@vger.kernel.org>, <samba-technical@lists.samba.org>,
        <linux-kernel@vger.kernel.org>, <chenxiaosong2@huawei.com>,
        <yi.zhang@huawei.com>, <zhangxiaoxu5@huawei.com>
Subject: [PATCH] cifs: fix use-after-free on the link name
Date:   Wed, 2 Nov 2022 14:16:59 +0800
Message-ID: <20221102061659.920334-1-chenxiaosong2@huawei.com>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.101.6]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemm600015.china.huawei.com (7.193.23.52)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

xfstests generic/011 reported use-after-free bug as follows:

  BUG: KASAN: use-after-free in __d_alloc+0x269/0x859
  Read of size 15 at addr ffff8880078933a0 by task dirstress/952

  CPU: 1 PID: 952 Comm: dirstress Not tainted 6.1.0-rc3+ #77
  Call Trace:
   __dump_stack+0x23/0x29
   dump_stack_lvl+0x51/0x73
   print_address_description+0x67/0x27f
   print_report+0x3e/0x5c
   kasan_report+0x7b/0xa8
   kasan_check_range+0x1b2/0x1c1
   memcpy+0x22/0x5d
   __d_alloc+0x269/0x859
   d_alloc+0x45/0x20c
   d_alloc_parallel+0xb2/0x8b2
   lookup_open+0x3b8/0x9f9
   open_last_lookups+0x63d/0xc26
   path_openat+0x11a/0x261
   do_filp_open+0xcc/0x168
   do_sys_openat2+0x13b/0x3f7
   do_sys_open+0x10f/0x146
   __se_sys_creat+0x27/0x2e
   __x64_sys_creat+0x55/0x6a
   do_syscall_64+0x40/0x96
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

  Allocated by task 952:
   kasan_save_stack+0x1f/0x42
   kasan_set_track+0x21/0x2a
   kasan_save_alloc_info+0x17/0x1d
   __kasan_kmalloc+0x7e/0x87
   __kmalloc_node_track_caller+0x59/0x155
   kstrndup+0x60/0xe6
   parse_mf_symlink+0x215/0x30b
   check_mf_symlink+0x260/0x36a
   cifs_get_inode_info+0x14e1/0x1690
   cifs_revalidate_dentry_attr+0x70d/0x964
   cifs_revalidate_dentry+0x36/0x62
   cifs_d_revalidate+0x162/0x446
   lookup_open+0x36f/0x9f9
   open_last_lookups+0x63d/0xc26
   path_openat+0x11a/0x261
   do_filp_open+0xcc/0x168
   do_sys_openat2+0x13b/0x3f7
   do_sys_open+0x10f/0x146
   __se_sys_creat+0x27/0x2e
   __x64_sys_creat+0x55/0x6a
   do_syscall_64+0x40/0x96
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

  Freed by task 950:
   kasan_save_stack+0x1f/0x42
   kasan_set_track+0x21/0x2a
   kasan_save_free_info+0x1c/0x34
   ____kasan_slab_free+0x1c1/0x1d5
   __kasan_slab_free+0xe/0x13
   __kmem_cache_free+0x29a/0x387
   kfree+0xd3/0x10e
   cifs_fattr_to_inode+0xb6a/0xc8c
   cifs_get_inode_info+0x3cb/0x1690
   cifs_revalidate_dentry_attr+0x70d/0x964
   cifs_revalidate_dentry+0x36/0x62
   cifs_d_revalidate+0x162/0x446
   lookup_open+0x36f/0x9f9
   open_last_lookups+0x63d/0xc26
   path_openat+0x11a/0x261
   do_filp_open+0xcc/0x168
   do_sys_openat2+0x13b/0x3f7
   do_sys_open+0x10f/0x146
   __se_sys_creat+0x27/0x2e
   __x64_sys_creat+0x55/0x6a
   do_syscall_64+0x40/0x96
   entry_SYSCALL_64_after_hwframe+0x63/0xcd

When opened a symlink, link name is from 'inode->i_link', but it may be
reset to a new value when revalidate the dentry. If some processes get the
link name on the race scenario, then UAF will happen on link name.

Fix this by implementing 'get_link' interface to duplicate the link name.

Fixes: 76894f3e2f71 ("cifs: improve symlink handling for smb2+")
Signed-off-by: ChenXiaoSong <chenxiaosong2@huawei.com>
---
 fs/cifs/cifsfs.c | 21 ++++++++++++++++++++-
 fs/cifs/inode.c  |  5 -----
 2 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index d0b9fec111aa..bb9592594fcc 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1143,8 +1143,27 @@ const struct inode_operations cifs_file_inode_ops = {
 	.fiemap = cifs_fiemap,
 };
 
+const char *cifs_get_link(struct dentry *dentry, struct inode *inode,
+			    struct delayed_call *done)
+{
+	char *target_path = NULL;
+
+	spin_lock(&inode->i_lock);
+	if (likely(CIFS_I(inode)->symlink_target))
+		target_path = kstrdup(CIFS_I(inode)->symlink_target,
+				      GFP_ATOMIC);
+	spin_unlock(&inode->i_lock);
+
+	if (target_path)
+		set_delayed_call(done, kfree_link, target_path);
+	else
+		target_path = ERR_PTR(-EOPNOTSUPP);
+
+	return target_path;
+}
+
 const struct inode_operations cifs_symlink_inode_ops = {
-	.get_link = simple_get_link,
+	.get_link = cifs_get_link,
 	.permission = cifs_permission,
 	.listxattr = cifs_listxattr,
 };
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 9bde08d44617..4e2ca3c6e5c0 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -215,11 +215,6 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 		kfree(cifs_i->symlink_target);
 		cifs_i->symlink_target = fattr->cf_symlink_target;
 		fattr->cf_symlink_target = NULL;
-
-		if (unlikely(!cifs_i->symlink_target))
-			inode->i_link = ERR_PTR(-EOPNOTSUPP);
-		else
-			inode->i_link = cifs_i->symlink_target;
 	}
 	spin_unlock(&inode->i_lock);
 
-- 
2.31.1

