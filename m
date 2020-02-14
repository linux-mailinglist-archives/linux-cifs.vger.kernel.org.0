Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 526DC15F000
	for <lists+linux-cifs@lfdr.de>; Fri, 14 Feb 2020 18:52:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388462AbgBNRwA (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 14 Feb 2020 12:52:00 -0500
Received: from mail.kernel.org ([198.145.29.99]:43622 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388813AbgBNP7J (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 14 Feb 2020 10:59:09 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A5C452067D;
        Fri, 14 Feb 2020 15:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581695947;
        bh=w9IgFlICa2EHlmwlhKdA8RQ5CI3yH209H/WY6Ko/ox8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=omEQcHdAMBZmlxDsOYzMRRxYWywnONxrVDZlhoRuPR0StEJOVMbai/KKWp2EFQRmi
         305fNH2YrmieZewlQCMs3qEGIUcsxO8AMKCTNgDywwxcjLy1lTX66UBfitPH2GKXXu
         azuTAdRfa4WqsPwcNp1E5wp8u5vNcPP95+fwxd50=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     "Paulo Alcantara (SUSE)" <pc@cjr.nz>,
        Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>,
        Steve French <stfrench@microsoft.com>,
        Sasha Levin <sashal@kernel.org>, linux-cifs@vger.kernel.org,
        samba-technical@lists.samba.org
Subject: [PATCH AUTOSEL 5.5 479/542] cifs: Fix mount options set in automount
Date:   Fri, 14 Feb 2020 10:47:51 -0500
Message-Id: <20200214154854.6746-479-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214154854.6746-1-sashal@kernel.org>
References: <20200214154854.6746-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

From: "Paulo Alcantara (SUSE)" <pc@cjr.nz>

[ Upstream commit 5739375ee4230980166807d347cc21c305532bbc ]

Starting from 4a367dc04435, we must set the mount options based on the
DFS full path rather than the resolved target, that is, cifs_mount()
will be responsible for resolving the DFS link (cached) as well as
performing failover to any other targets in the referral.

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
Reported-by: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
Fixes: 4a367dc04435 ("cifs: Add support for failover in cifs_mount()")
Link: https://lore.kernel.org/linux-cifs/39643d7d-2abb-14d3-ced6-c394fab9a777@prodrive-technologies.com
Tested-by: Martijn de Gouw <martijn.de.gouw@prodrive-technologies.com>
Signed-off-by: Steve French <stfrench@microsoft.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifs_dfs_ref.c | 97 +++++++++++++++++++-----------------------
 1 file changed, 43 insertions(+), 54 deletions(-)

diff --git a/fs/cifs/cifs_dfs_ref.c b/fs/cifs/cifs_dfs_ref.c
index 41957b82d7960..606f26d862dc1 100644
--- a/fs/cifs/cifs_dfs_ref.c
+++ b/fs/cifs/cifs_dfs_ref.c
@@ -120,17 +120,17 @@ cifs_build_devname(char *nodename, const char *prepath)
 
 
 /**
- * cifs_compose_mount_options	-	creates mount options for refferral
+ * cifs_compose_mount_options	-	creates mount options for referral
  * @sb_mountdata:	parent/root DFS mount options (template)
  * @fullpath:		full path in UNC format
- * @ref:		server's referral
+ * @ref:		optional server's referral
  * @devname:		optional pointer for saving device name
  *
  * creates mount options for submount based on template options sb_mountdata
  * and replacing unc,ip,prefixpath options with ones we've got form ref_unc.
  *
  * Returns: pointer to new mount options or ERR_PTR.
- * Caller is responcible for freeing retunrned value if it is not error.
+ * Caller is responsible for freeing returned value if it is not error.
  */
 char *cifs_compose_mount_options(const char *sb_mountdata,
 				   const char *fullpath,
@@ -150,18 +150,27 @@ char *cifs_compose_mount_options(const char *sb_mountdata,
 	if (sb_mountdata == NULL)
 		return ERR_PTR(-EINVAL);
 
-	if (strlen(fullpath) - ref->path_consumed) {
-		prepath = fullpath + ref->path_consumed;
-		/* skip initial delimiter */
-		if (*prepath == '/' || *prepath == '\\')
-			prepath++;
-	}
+	if (ref) {
+		if (strlen(fullpath) - ref->path_consumed) {
+			prepath = fullpath + ref->path_consumed;
+			/* skip initial delimiter */
+			if (*prepath == '/' || *prepath == '\\')
+				prepath++;
+		}
 
-	name = cifs_build_devname(ref->node_name, prepath);
-	if (IS_ERR(name)) {
-		rc = PTR_ERR(name);
-		name = NULL;
-		goto compose_mount_options_err;
+		name = cifs_build_devname(ref->node_name, prepath);
+		if (IS_ERR(name)) {
+			rc = PTR_ERR(name);
+			name = NULL;
+			goto compose_mount_options_err;
+		}
+	} else {
+		name = cifs_build_devname((char *)fullpath, NULL);
+		if (IS_ERR(name)) {
+			rc = PTR_ERR(name);
+			name = NULL;
+			goto compose_mount_options_err;
+		}
 	}
 
 	rc = dns_resolve_server_name_to_ip(name, &srvIP);
@@ -225,6 +234,8 @@ char *cifs_compose_mount_options(const char *sb_mountdata,
 
 	if (devname)
 		*devname = name;
+	else
+		kfree(name);
 
 	/*cifs_dbg(FYI, "%s: parent mountdata: %s\n", __func__, sb_mountdata);*/
 	/*cifs_dbg(FYI, "%s: submount mountdata: %s\n", __func__, mountdata );*/
@@ -241,23 +252,23 @@ char *cifs_compose_mount_options(const char *sb_mountdata,
 }
 
 /**
- * cifs_dfs_do_refmount - mounts specified path using provided refferal
+ * cifs_dfs_do_mount - mounts specified path using DFS full path
+ *
+ * Always pass down @fullpath to smb3_do_mount() so we can use the root server
+ * to perform failover in case we failed to connect to the first target in the
+ * referral.
+ *
  * @cifs_sb:		parent/root superblock
  * @fullpath:		full path in UNC format
- * @ref:		server's referral
  */
-static struct vfsmount *cifs_dfs_do_refmount(struct dentry *mntpt,
-		struct cifs_sb_info *cifs_sb,
-		const char *fullpath, const struct dfs_info3_param *ref)
+static struct vfsmount *cifs_dfs_do_mount(struct dentry *mntpt,
+					  struct cifs_sb_info *cifs_sb,
+					  const char *fullpath)
 {
 	struct vfsmount *mnt;
 	char *mountdata;
 	char *devname;
 
-	/*
-	 * Always pass down the DFS full path to smb3_do_mount() so we
-	 * can use it later for failover.
-	 */
 	devname = kstrndup(fullpath, strlen(fullpath), GFP_KERNEL);
 	if (!devname)
 		return ERR_PTR(-ENOMEM);
@@ -266,7 +277,7 @@ static struct vfsmount *cifs_dfs_do_refmount(struct dentry *mntpt,
 
 	/* strip first '\' from fullpath */
 	mountdata = cifs_compose_mount_options(cifs_sb->mountdata,
-					       fullpath + 1, ref, NULL);
+					       fullpath + 1, NULL, NULL);
 	if (IS_ERR(mountdata)) {
 		kfree(devname);
 		return (struct vfsmount *)mountdata;
@@ -278,28 +289,16 @@ static struct vfsmount *cifs_dfs_do_refmount(struct dentry *mntpt,
 	return mnt;
 }
 
-static void dump_referral(const struct dfs_info3_param *ref)
-{
-	cifs_dbg(FYI, "DFS: ref path: %s\n", ref->path_name);
-	cifs_dbg(FYI, "DFS: node path: %s\n", ref->node_name);
-	cifs_dbg(FYI, "DFS: fl: %d, srv_type: %d\n",
-		 ref->flags, ref->server_type);
-	cifs_dbg(FYI, "DFS: ref_flags: %d, path_consumed: %d\n",
-		 ref->ref_flag, ref->path_consumed);
-}
-
 /*
  * Create a vfsmount that we can automount
  */
 static struct vfsmount *cifs_dfs_do_automount(struct dentry *mntpt)
 {
-	struct dfs_info3_param referral = {0};
 	struct cifs_sb_info *cifs_sb;
 	struct cifs_ses *ses;
 	struct cifs_tcon *tcon;
 	char *full_path, *root_path;
 	unsigned int xid;
-	int len;
 	int rc;
 	struct vfsmount *mnt;
 
@@ -357,7 +356,7 @@ static struct vfsmount *cifs_dfs_do_automount(struct dentry *mntpt)
 	if (!rc) {
 		rc = dfs_cache_find(xid, ses, cifs_sb->local_nls,
 				    cifs_remap(cifs_sb), full_path + 1,
-				    &referral, NULL);
+				    NULL, NULL);
 	}
 
 	free_xid(xid);
@@ -366,26 +365,16 @@ static struct vfsmount *cifs_dfs_do_automount(struct dentry *mntpt)
 		mnt = ERR_PTR(rc);
 		goto free_root_path;
 	}
-
-	dump_referral(&referral);
-
-	len = strlen(referral.node_name);
-	if (len < 2) {
-		cifs_dbg(VFS, "%s: Net Address path too short: %s\n",
-			 __func__, referral.node_name);
-		mnt = ERR_PTR(-EINVAL);
-		goto free_dfs_ref;
-	}
 	/*
-	 * cifs_mount() will retry every available node server in case
-	 * of failures.
+	 * OK - we were able to get and cache a referral for @full_path.
+	 *
+	 * Now, pass it down to cifs_mount() and it will retry every available
+	 * node server in case of failures - no need to do it here.
 	 */
-	mnt = cifs_dfs_do_refmount(mntpt, cifs_sb, full_path, &referral);
-	cifs_dbg(FYI, "%s: cifs_dfs_do_refmount:%s , mnt:%p\n", __func__,
-		 referral.node_name, mnt);
+	mnt = cifs_dfs_do_mount(mntpt, cifs_sb, full_path);
+	cifs_dbg(FYI, "%s: cifs_dfs_do_mount:%s , mnt:%p\n", __func__,
+		 full_path + 1, mnt);
 
-free_dfs_ref:
-	free_dfs_info_param(&referral);
 free_root_path:
 	kfree(root_path);
 free_full_path:
-- 
2.20.1

