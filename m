Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D16F77FAE7
	for <lists+linux-cifs@lfdr.de>; Thu, 17 Aug 2023 17:36:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352320AbjHQPgO (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 17 Aug 2023 11:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352348AbjHQPfr (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 17 Aug 2023 11:35:47 -0400
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB942D6D
        for <linux-cifs@vger.kernel.org>; Thu, 17 Aug 2023 08:35:44 -0700 (PDT)
From:   Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1692286543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4d17a1RbI0rCZpounCEPQdS7sJHp+LafngJafYOuqAU=;
        b=dJ/7MHgOnm56pHqVsnzb7olqgjA9afpFqeac6jWQxhcCp1ZczzquFw3agO0OeRALvXZska
        f/H9K36Vj47Rd3e1o3/4b7IDQQN8HQFShJYxpndoHbh1+emyT+wxxcDdt1T9Q+Gje9zFoU
        sVTo4QVeIB2aZFGs1zDEV+EASqgXXCUUy3TMJzKJEWKLyMzwwjW59bwlKK6a00sTf9wSVD
        EOvNhY7XCjnZKEeiGg1RkixP9NuaBOdeTh52MnXeKXpdMakokbEwysr50OZkSKV1BWEkBU
        aVcqrZjcgb12XLVvb/MdJWDdz6qYlizS7mJpvXasQJ3WrysicxcjDGavjGL+eQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1692286543;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4d17a1RbI0rCZpounCEPQdS7sJHp+LafngJafYOuqAU=;
        b=LbI50NQXZBzrNZS322z/ap+znr8TSbR1zN+xDY9hJll0insrqH2PcLfLmnqjOHng0u8Fn/
        qeI99sqmaoUBWCIZQAEfMDMQNNLOalcfpa1RzKbXt8XPnF171rURRdbBH8n3xFVlUNvKub
        Oub3zKve6iW1xcO3RwLltc3XJ66w6kH1lTCfl+IVel0xiHuXpsygt+ZV4ldRQg7nbX5AYr
        CDFyYLOVqjhKVzLXu25BjzqbD3TeAdwLYss38LR48LR73hmF5RGnnxnetdgYsBXnA3will
        wo5pNRDuBRkrmifyqpMjl49ohp/DkF+nH9xhD8olt8Qx4VKi6IvW67SnaNStiw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1692286543; a=rsa-sha256;
        cv=none;
        b=TCFiRlbiWY+uWYE6nJ1Seu2so43FJ/PKU7MPlxZXcNuoUGARoumnMjNipr4RBBWdZdzjB4
        FxYnJO9Am7bsxAX/Lk7PRwYJZ3vhjLnzYZ/MhCksh1hZxlTohm89Dm9gaJWmsercQMPZdh
        as6kLdADp3nO5g9EVvNaD6yweF0ttQLQVY2xIvthGbNUypt/GDhxMT65XsTbJmSe3q1p+k
        u15ZvrXsRFamvhuCSjwGCxrow1UbM7pVqY5FxLqv7dg+T11Ok9iXM/2szLzsEfR0AgWmY6
        GafgjvT0yHRn1hh+CnZQTuXV2fOhwzN+N2apKRpCAn0gdRaQx7q2/cyU1xERmw==
To:     smfrench@gmail.com
Cc:     linux-cifs@vger.kernel.org, Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 11/17] smb: cilent: set reparse mount points as automounts
Date:   Thu, 17 Aug 2023 12:34:09 -0300
Message-ID: <20230817153416.28083-12-pc@manguebit.com>
In-Reply-To: <20230817153416.28083-1-pc@manguebit.com>
References: <20230817153416.28083-1-pc@manguebit.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

By doing so we can selectively mark those submounts as 'noserverino'
rather than whole mount and thus avoiding inode collisions in them.

Consider a "test" SMB share that has two mounted NTFS volumes
(vol0 & vol1) inside it.

* Before patch

$ mount.cifs //srv/test /mnt/1 -o ...,serverino
$ ls -li /mnt/1/vol0
total 1
281474976710693 drwxr-xr-x 2 root root 0 Jul 15 00:23 $RECYCLE.BIN
281474976710696 drwxr-xr-x 2 root root 0 Jul 18 18:23 System Volume...
281474976710699 -rwxr-xr-x 1 root root 0 Aug 14 21:53 f0
281474976710700 -rwxr-xr-x 1 root root 0 Aug 15 18:52 f2
281474976710698 drwxr-xr-x 2 root root 0 Aug 12 19:39 foo
281474976710692 -rwxr-xr-x 1 root root 5 Aug  4 21:18 vol0_f0.txt
$ ls -li /mnt/1/vol1
total 0
281474976710693 drwxr-xr-x 2 root root 0 Jul 15 00:23 $RECYCLE.BIN
281474976710696 drwxr-xr-x 2 root root 0 Jul 18 18:23 System Volume...
281474976710698 drwxr-xr-x 2 root root 0 Aug 12 19:39 bar
281474976710699 -rwxr-xr-x 1 root root 0 Aug 14 22:03 f0
281474976710700 -rwxr-xr-x 1 root root 0 Aug 14 22:52 f1
281474976710692 -rwxr-xr-x 1 root root 0 Jul 15 00:23 vol1_f0.txt

* After patch

$ mount.cifs //srv/test /mnt/1 -o ...,serverino
$ ls -li /mnt/1/vol0
total 1
590 drwxr-xr-x 2 root root 0 Jul 15 00:23 $RECYCLE.BIN
594 drwxr-xr-x 2 root root 0 Jul 18 18:23 System Volume Information
591 -rwxr-xr-x 1 root root 0 Aug 14 21:53 f0
592 -rwxr-xr-x 1 root root 0 Aug 15 18:52 f2
593 drwxr-xr-x 2 root root 0 Aug 12 19:39 foo
595 -rwxr-xr-x 1 root root 5 Aug  4 21:18 vol0_f0.txt
$ ls -li /mnt/1/vol1
total 0
596 drwxr-xr-x 2 root root 0 Jul 15 00:23 $RECYCLE.BIN
600 drwxr-xr-x 2 root root 0 Jul 18 18:23 System Volume Information
597 drwxr-xr-x 2 root root 0 Aug 12 19:39 bar
598 -rwxr-xr-x 1 root root 0 Aug 14 22:03 f0
599 -rwxr-xr-x 1 root root 0 Aug 14 22:52 f1
601 -rwxr-xr-x 1 root root 0 Jul 15 00:23 vol1_f0.txt

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
---
 fs/smb/client/cifsglob.h  |   2 +-
 fs/smb/client/inode.c     | 352 +++++++++++++++++++++-----------------
 fs/smb/client/namespace.c |  19 +-
 fs/smb/client/readdir.c   |   1 +
 4 files changed, 198 insertions(+), 176 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 639a61417b08..6d5fa0351dce 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1094,7 +1094,7 @@ cap_unix(struct cifs_ses *ses)
  * inode with new info
  */
 
-#define CIFS_FATTR_DFS_REFERRAL		0x1
+#define CIFS_FATTR_JUNCTION		0x1
 #define CIFS_FATTR_DELETE_PENDING	0x2
 #define CIFS_FATTR_NEED_REVAL		0x4
 #define CIFS_FATTR_INO_COLLISION	0x8
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 96a09818aa5b..ba17356aa7bb 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -214,7 +214,7 @@ cifs_fattr_to_inode(struct inode *inode, struct cifs_fattr *fattr)
 	}
 	spin_unlock(&inode->i_lock);
 
-	if (fattr->cf_flags & CIFS_FATTR_DFS_REFERRAL)
+	if (fattr->cf_flags & CIFS_FATTR_JUNCTION)
 		inode->i_flags |= S_AUTOMOUNT;
 	if (inode->i_state & I_NEW)
 		cifs_set_ops(inode);
@@ -323,14 +323,14 @@ cifs_unix_basic_to_fattr(struct cifs_fattr *fattr, FILE_UNIX_BASIC_INFO *info,
  *
  * Needed to setup cifs_fattr data for the directory which is the
  * junction to the new submount (ie to setup the fake directory
- * which represents a DFS referral).
+ * which represents a DFS referral or reparse mount point).
  */
-static void
-cifs_create_dfs_fattr(struct cifs_fattr *fattr, struct super_block *sb)
+static void cifs_create_junction_fattr(struct cifs_fattr *fattr,
+				       struct super_block *sb)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 
-	cifs_dbg(FYI, "creating fake fattr for DFS referral\n");
+	cifs_dbg(FYI, "%s: creating fake fattr\n", __func__);
 
 	memset(fattr, 0, sizeof(*fattr));
 	fattr->cf_mode = S_IFDIR | S_IXUGO | S_IRWXU;
@@ -339,7 +339,33 @@ cifs_create_dfs_fattr(struct cifs_fattr *fattr, struct super_block *sb)
 	ktime_get_coarse_real_ts64(&fattr->cf_mtime);
 	fattr->cf_atime = fattr->cf_ctime = fattr->cf_mtime;
 	fattr->cf_nlink = 2;
-	fattr->cf_flags = CIFS_FATTR_DFS_REFERRAL;
+	fattr->cf_flags = CIFS_FATTR_JUNCTION;
+}
+
+/* Update inode with final fattr data */
+static int update_inode_info(struct super_block *sb,
+			     struct cifs_fattr *fattr,
+			     struct inode **inode)
+{
+	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
+	int rc = 0;
+
+	if (!*inode) {
+		*inode = cifs_iget(sb, fattr);
+		if (!*inode)
+			rc = -ENOMEM;
+		return rc;
+	}
+	/* We already have inode, update it.
+	 *
+	 * If file type or uniqueid is different, return error.
+	 */
+	if (unlikely((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM) &&
+		     CIFS_I(*inode)->uniqueid != fattr->cf_uniqueid)) {
+		CIFS_I(*inode)->time = 0; /* force reval */
+		return -ESTALE;
+	}
+	return cifs_fattr_to_inode(*inode, fattr);
 }
 
 #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
@@ -369,7 +395,7 @@ cifs_get_file_info_unix(struct file *filp)
 	if (!rc) {
 		cifs_unix_basic_to_fattr(&fattr, &find_data, cifs_sb);
 	} else if (rc == -EREMOTE) {
-		cifs_create_dfs_fattr(&fattr, inode->i_sb);
+		cifs_create_junction_fattr(&fattr, inode->i_sb);
 		rc = 0;
 	} else
 		goto cifs_gfiunix_out;
@@ -381,17 +407,18 @@ cifs_get_file_info_unix(struct file *filp)
 	return rc;
 }
 
-int cifs_get_inode_info_unix(struct inode **pinode,
-			     const unsigned char *full_path,
-			     struct super_block *sb, unsigned int xid)
+static int cifs_get_unix_fattr(const unsigned char *full_path,
+			       struct super_block *sb,
+			       struct cifs_fattr *fattr,
+			       struct inode **pinode,
+			       const unsigned int xid)
 {
-	int rc;
+	struct TCP_Server_Info *server;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	FILE_UNIX_BASIC_INFO find_data;
-	struct cifs_fattr fattr;
 	struct cifs_tcon *tcon;
-	struct TCP_Server_Info *server;
 	struct tcon_link *tlink;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
+	int rc, tmprc;
 
 	cifs_dbg(FYI, "Getting info on %s\n", full_path);
 
@@ -408,59 +435,61 @@ int cifs_get_inode_info_unix(struct inode **pinode,
 	cifs_put_tlink(tlink);
 
 	if (!rc) {
-		cifs_unix_basic_to_fattr(&fattr, &find_data, cifs_sb);
+		cifs_unix_basic_to_fattr(fattr, &find_data, cifs_sb);
 	} else if (rc == -EREMOTE) {
-		cifs_create_dfs_fattr(&fattr, sb);
+		cifs_create_junction_fattr(fattr, sb);
 		rc = 0;
 	} else {
 		return rc;
 	}
 
+	if (!*pinode)
+		cifs_fill_uniqueid(sb, fattr);
+
 	/* check for Minshall+French symlinks */
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_MF_SYMLINKS) {
-		int tmprc = check_mf_symlink(xid, tcon, cifs_sb, &fattr,
-					     full_path);
-		if (tmprc)
-			cifs_dbg(FYI, "check_mf_symlink: %d\n", tmprc);
+		tmprc = check_mf_symlink(xid, tcon, cifs_sb, fattr, full_path);
+		cifs_dbg(FYI, "check_mf_symlink: %d\n", tmprc);
 	}
 
-	if (S_ISLNK(fattr.cf_mode) && !fattr.cf_symlink_target) {
+	if (S_ISLNK(fattr->cf_mode) && !fattr->cf_symlink_target) {
 		if (!server->ops->query_symlink)
 			return -EOPNOTSUPP;
-		rc = server->ops->query_symlink(xid, tcon, cifs_sb, full_path,
-						&fattr.cf_symlink_target, NULL);
-		if (rc) {
-			cifs_dbg(FYI, "%s: query_symlink: %d\n", __func__, rc);
-			goto cgiiu_exit;
-		}
+		rc = server->ops->query_symlink(xid, tcon,
+						cifs_sb, full_path,
+						&fattr->cf_symlink_target,
+						NULL);
+		cifs_dbg(FYI, "%s: query_symlink: %d\n", __func__, rc);
 	}
+	return rc;
+}
 
-	if (*pinode == NULL) {
-		/* get new inode */
-		cifs_fill_uniqueid(sb, &fattr);
-		*pinode = cifs_iget(sb, &fattr);
-		if (!*pinode)
-			rc = -ENOMEM;
-	} else {
-		/* we already have inode, update it */
+int cifs_get_inode_info_unix(struct inode **pinode,
+			     const unsigned char *full_path,
+			     struct super_block *sb, unsigned int xid)
+{
+	struct cifs_fattr fattr = {};
+	int rc;
 
-		/* if uniqueid is different, return error */
-		if (unlikely(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM &&
-		    CIFS_I(*pinode)->uniqueid != fattr.cf_uniqueid)) {
-			CIFS_I(*pinode)->time = 0; /* force reval */
-			rc = -ESTALE;
-			goto cgiiu_exit;
-		}
+	rc = cifs_get_unix_fattr(full_path, sb, &fattr, pinode, xid);
+	if (rc)
+		goto out;
 
-		/* if filetype is different, return error */
-		rc = cifs_fattr_to_inode(*pinode, &fattr);
-	}
-
-cgiiu_exit:
+	rc = update_inode_info(sb, &fattr, pinode);
+out:
 	kfree(fattr.cf_symlink_target);
 	return rc;
 }
 #else
+static inline int cifs_get_unix_fattr(const unsigned char *full_path,
+				      struct super_block *sb,
+				      struct cifs_fattr *fattr,
+				      struct inode **pinode,
+				      const unsigned int xid)
+{
+	return -EOPNOTSUPP;
+}
+
 int cifs_get_inode_info_unix(struct inode **pinode,
 			     const unsigned char *full_path,
 			     struct super_block *sb, unsigned int xid)
@@ -826,7 +855,7 @@ cifs_get_file_info(struct file *filp)
 		cifs_open_info_to_fattr(&fattr, &data, inode->i_sb);
 		break;
 	case -EREMOTE:
-		cifs_create_dfs_fattr(&fattr, inode->i_sb);
+		cifs_create_junction_fattr(&fattr, inode->i_sb);
 		rc = 0;
 		break;
 	case -EOPNOTSUPP:
@@ -979,12 +1008,12 @@ static inline bool is_inode_cache_good(struct inode *ino)
 	return ino && CIFS_CACHE_READ(CIFS_I(ino)) && CIFS_I(ino)->time != 0;
 }
 
-static int query_reparse(struct cifs_open_info_data *data,
-			 struct super_block *sb,
-			 const unsigned int xid,
-			 struct cifs_tcon *tcon,
-			 const char *full_path,
-			 struct cifs_fattr *fattr)
+static int reparse_info_to_fattr(struct cifs_open_info_data *data,
+				 struct super_block *sb,
+				 const unsigned int xid,
+				 struct cifs_tcon *tcon,
+				 const char *full_path,
+				 struct cifs_fattr *fattr)
 {
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
@@ -1013,21 +1042,29 @@ static int query_reparse(struct cifs_open_info_data *data,
 							iov);
 		}
 		break;
+	case IO_REPARSE_TAG_MOUNT_POINT:
+		cifs_create_junction_fattr(fattr, sb);
+		goto out;
 	}
+
+	cifs_open_info_to_fattr(fattr, data, sb);
+out:
 	free_rsp_buf(rsp_buftype, rsp_iov.iov_base);
 	return rc;
 }
 
-int cifs_get_inode_info(struct inode **inode, const char *full_path,
-			struct cifs_open_info_data *data, struct super_block *sb, int xid,
-			const struct cifs_fid *fid)
+static int cifs_get_fattr(struct cifs_open_info_data *data,
+			  struct super_block *sb, int xid,
+			  const struct cifs_fid *fid,
+			  struct cifs_fattr *fattr,
+			  struct inode **inode,
+			  const char *full_path)
 {
-	struct cifs_tcon *tcon;
-	struct TCP_Server_Info *server;
-	struct tcon_link *tlink;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
-	struct cifs_fattr fattr = {0};
 	struct cifs_open_info_data tmp_data = {};
+	struct cifs_tcon *tcon;
+	struct TCP_Server_Info *server;
+	struct tcon_link *tlink;
+	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	void *smb1_backup_rsp_buf = NULL;
 	int rc = 0;
 	int tmprc = 0;
@@ -1043,10 +1080,6 @@ int cifs_get_inode_info(struct inode **inode, const char *full_path,
 	 */
 
 	if (!data) {
-		if (is_inode_cache_good(*inode)) {
-			cifs_dbg(FYI, "No need to revalidate cached inode sizes\n");
-			goto out;
-		}
 		rc = server->ops->query_path_info(xid, tcon, cifs_sb,
 						  full_path, &tmp_data);
 		data = &tmp_data;
@@ -1064,15 +1097,15 @@ int cifs_get_inode_info(struct inode **inode, const char *full_path,
 		 * special file type e.g. symlink or fifo or char etc.
 		 */
 		if (cifs_open_data_reparse(data)) {
-			rc = query_reparse(data, sb, xid, tcon,
-					   full_path, &fattr);
+			rc = reparse_info_to_fattr(data, sb, xid, tcon,
+						   full_path, fattr);
+		} else {
+			cifs_open_info_to_fattr(fattr, data, sb);
 		}
-		if (!rc)
-			cifs_open_info_to_fattr(&fattr, data, sb);
 		break;
 	case -EREMOTE:
 		/* DFS link, no metadata available on this server */
-		cifs_create_dfs_fattr(&fattr, sb);
+		cifs_create_junction_fattr(fattr, sb);
 		rc = 0;
 		break;
 	case -EACCES:
@@ -1102,8 +1135,8 @@ int cifs_get_inode_info(struct inode **inode, const char *full_path,
 			fdi = (FILE_DIRECTORY_INFO *)fi;
 			si = (SEARCH_ID_FULL_DIR_INFO *)fi;
 
-			cifs_dir_info_to_fattr(&fattr, fdi, cifs_sb);
-			fattr.cf_uniqueid = le64_to_cpu(si->UniqueId);
+			cifs_dir_info_to_fattr(fattr, fdi, cifs_sb);
+			fattr->cf_uniqueid = le64_to_cpu(si->UniqueId);
 			/* uniqueid set, skip get inum step */
 			goto handle_mnt_opt;
 		} else {
@@ -1120,10 +1153,10 @@ int cifs_get_inode_info(struct inode **inode, const char *full_path,
 	}
 
 	/*
-	 * 3. Get or update inode number (fattr.cf_uniqueid)
+	 * 3. Get or update inode number (fattr->cf_uniqueid)
 	 */
 
-	cifs_set_fattr_ino(xid, tcon, sb, inode, full_path, data, &fattr);
+	cifs_set_fattr_ino(xid, tcon, sb, inode, full_path, data, fattr);
 
 	/*
 	 * 4. Tweak fattr based on mount options
@@ -1132,17 +1165,17 @@ int cifs_get_inode_info(struct inode **inode, const char *full_path,
 handle_mnt_opt:
 #endif /* CONFIG_CIFS_ALLOW_INSECURE_LEGACY */
 	/* query for SFU type info if supported and needed */
-	if (fattr.cf_cifsattrs & ATTR_SYSTEM &&
-	    cifs_sb->mnt_cifs_flags & CIFS_MOUNT_UNX_EMUL) {
-		tmprc = cifs_sfu_type(&fattr, full_path, cifs_sb, xid);
+	if ((fattr->cf_cifsattrs & ATTR_SYSTEM) &&
+	    (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_UNX_EMUL)) {
+		tmprc = cifs_sfu_type(fattr, full_path, cifs_sb, xid);
 		if (tmprc)
 			cifs_dbg(FYI, "cifs_sfu_type failed: %d\n", tmprc);
 	}
 
 	/* fill in 0777 bits from ACL */
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_MODE_FROM_SID) {
-		rc = cifs_acl_to_fattr(cifs_sb, &fattr, *inode, true,
-				       full_path, fid);
+		rc = cifs_acl_to_fattr(cifs_sb, fattr, *inode,
+				       true, full_path, fid);
 		if (rc == -EREMOTE)
 			rc = 0;
 		if (rc) {
@@ -1151,8 +1184,8 @@ int cifs_get_inode_info(struct inode **inode, const char *full_path,
 			goto out;
 		}
 	} else if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_CIFS_ACL) {
-		rc = cifs_acl_to_fattr(cifs_sb, &fattr, *inode, false,
-				       full_path, fid);
+		rc = cifs_acl_to_fattr(cifs_sb, fattr, *inode,
+				       false, full_path, fid);
 		if (rc == -EREMOTE)
 			rc = 0;
 		if (rc) {
@@ -1164,58 +1197,57 @@ int cifs_get_inode_info(struct inode **inode, const char *full_path,
 
 	/* fill in remaining high mode bits e.g. SUID, VTX */
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_UNX_EMUL)
-		cifs_sfu_mode(&fattr, full_path, cifs_sb, xid);
+		cifs_sfu_mode(fattr, full_path, cifs_sb, xid);
 
 	/* check for Minshall+French symlinks */
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_MF_SYMLINKS) {
-		tmprc = check_mf_symlink(xid, tcon, cifs_sb, &fattr,
-					 full_path);
-		if (tmprc)
-			cifs_dbg(FYI, "check_mf_symlink: %d\n", tmprc);
+		tmprc = check_mf_symlink(xid, tcon, cifs_sb, fattr, full_path);
+		cifs_dbg(FYI, "check_mf_symlink: %d\n", tmprc);
 	}
 
-	/*
-	 * 5. Update inode with final fattr data
-	 */
-
-	if (!*inode) {
-		*inode = cifs_iget(sb, &fattr);
-		if (!*inode)
-			rc = -ENOMEM;
-	} else {
-		/* we already have inode, update it */
-
-		/* if uniqueid is different, return error */
-		if (unlikely(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM &&
-		    CIFS_I(*inode)->uniqueid != fattr.cf_uniqueid)) {
-			CIFS_I(*inode)->time = 0; /* force reval */
-			rc = -ESTALE;
-			goto out;
-		}
-		/* if filetype is different, return error */
-		rc = cifs_fattr_to_inode(*inode, &fattr);
-	}
 out:
 	cifs_buf_release(smb1_backup_rsp_buf);
 	cifs_put_tlink(tlink);
 	cifs_free_open_info(&tmp_data);
+	return rc;
+}
+
+int cifs_get_inode_info(struct inode **inode,
+			const char *full_path,
+			struct cifs_open_info_data *data,
+			struct super_block *sb, int xid,
+			const struct cifs_fid *fid)
+{
+	struct cifs_fattr fattr = {};
+	int rc;
+
+	if (is_inode_cache_good(*inode)) {
+		cifs_dbg(FYI, "No need to revalidate cached inode sizes\n");
+		return 0;
+	}
+
+	rc = cifs_get_fattr(data, sb, xid, fid, &fattr, inode, full_path);
+	if (rc)
+		goto out;
+
+	rc = update_inode_info(sb, &fattr, inode);
+out:
 	kfree(fattr.cf_symlink_target);
 	return rc;
 }
 
-int
-smb311_posix_get_inode_info(struct inode **inode,
-		    const char *full_path,
-		    struct super_block *sb, unsigned int xid)
+static int smb311_posix_get_fattr(struct cifs_fattr *fattr,
+				  const char *full_path,
+				  struct super_block *sb,
+				  const unsigned int xid)
 {
+	struct cifs_open_info_data data = {};
+	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifs_tcon *tcon;
 	struct tcon_link *tlink;
-	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
-	struct cifs_fattr fattr = {0};
-	struct cifs_open_info_data data = {};
 	struct cifs_sid owner, group;
-	int rc = 0;
-	int tmprc = 0;
+	int tmprc;
+	int rc;
 
 	tlink = cifs_sb_tlink(cifs_sb);
 	if (IS_ERR(tlink))
@@ -1226,11 +1258,6 @@ smb311_posix_get_inode_info(struct inode **inode,
 	 * 1. Fetch file metadata
 	 */
 
-	if (is_inode_cache_good(*inode)) {
-		cifs_dbg(FYI, "No need to revalidate cached inode sizes\n");
-		goto out;
-	}
-
 	rc = smb311_posix_query_path_info(xid, tcon, cifs_sb,
 					  full_path, &data,
 					  &owner, &group);
@@ -1241,11 +1268,11 @@ smb311_posix_get_inode_info(struct inode **inode,
 
 	switch (rc) {
 	case 0:
-		smb311_posix_info_to_fattr(&fattr, &data, &owner, &group, sb);
+		smb311_posix_info_to_fattr(fattr, &data, &owner, &group, sb);
 		break;
 	case -EREMOTE:
 		/* DFS link, no metadata available on this server */
-		cifs_create_dfs_fattr(&fattr, sb);
+		cifs_create_junction_fattr(fattr, sb);
 		rc = 0;
 		break;
 	case -EACCES:
@@ -1261,49 +1288,42 @@ smb311_posix_get_inode_info(struct inode **inode,
 		goto out;
 	}
 
-
 	/*
 	 * 3. Tweak fattr based on mount options
 	 */
-
 	/* check for Minshall+French symlinks */
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_MF_SYMLINKS) {
-		tmprc = check_mf_symlink(xid, tcon, cifs_sb, &fattr,
-					 full_path);
-		if (tmprc)
-			cifs_dbg(FYI, "check_mf_symlink: %d\n", tmprc);
+		tmprc = check_mf_symlink(xid, tcon, cifs_sb, fattr, full_path);
+		cifs_dbg(FYI, "check_mf_symlink: %d\n", tmprc);
 	}
 
-	/*
-	 * 4. Update inode with final fattr data
-	 */
-
-	if (!*inode) {
-		*inode = cifs_iget(sb, &fattr);
-		if (!*inode)
-			rc = -ENOMEM;
-	} else {
-		/* we already have inode, update it */
-
-		/* if uniqueid is different, return error */
-		if (unlikely(cifs_sb->mnt_cifs_flags & CIFS_MOUNT_SERVER_INUM &&
-		    CIFS_I(*inode)->uniqueid != fattr.cf_uniqueid)) {
-			CIFS_I(*inode)->time = 0; /* force reval */
-			rc = -ESTALE;
-			goto out;
-		}
-
-		/* if filetype is different, return error */
-		rc = cifs_fattr_to_inode(*inode, &fattr);
-	}
 out:
 	cifs_put_tlink(tlink);
 	cifs_free_open_info(&data);
+	return rc;
+}
+
+int smb311_posix_get_inode_info(struct inode **inode, const char *full_path,
+				struct super_block *sb, const unsigned int xid)
+{
+	struct cifs_fattr fattr = {};
+	int rc;
+
+	if (is_inode_cache_good(*inode)) {
+		cifs_dbg(FYI, "No need to revalidate cached inode sizes\n");
+		return 0;
+	}
+
+	rc = smb311_posix_get_fattr(&fattr, full_path, sb, xid);
+	if (rc)
+		goto out;
+
+	rc = update_inode_info(sb, &fattr, inode);
+out:
 	kfree(fattr.cf_symlink_target);
 	return rc;
 }
 
-
 static const struct inode_operations cifs_ipc_inode_ops = {
 	.lookup = cifs_lookup,
 };
@@ -1407,13 +1427,14 @@ cifs_iget(struct super_block *sb, struct cifs_fattr *fattr)
 /* gets root inode */
 struct inode *cifs_root_iget(struct super_block *sb)
 {
-	unsigned int xid;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
-	struct inode *inode = NULL;
-	long rc;
+	struct cifs_fattr fattr = {};
 	struct cifs_tcon *tcon = cifs_sb_master_tcon(cifs_sb);
+	struct inode *inode = NULL;
+	unsigned int xid;
 	char *path = NULL;
 	int len;
+	int rc;
 
 	if ((cifs_sb->mnt_cifs_flags & CIFS_MOUNT_USE_PREFIX_PATH)
 	    && cifs_sb->prepath) {
@@ -1431,21 +1452,29 @@ struct inode *cifs_root_iget(struct super_block *sb)
 
 	xid = get_xid();
 	if (tcon->unix_ext) {
-		rc = cifs_get_inode_info_unix(&inode, path, sb, xid);
+		rc = cifs_get_unix_fattr(path, sb, &fattr, &inode, xid);
 		/* some servers mistakenly claim POSIX support */
 		if (rc != -EOPNOTSUPP)
-			goto iget_no_retry;
+			goto iget_root;
 		cifs_dbg(VFS, "server does not support POSIX extensions\n");
 		tcon->unix_ext = false;
 	}
 
 	convert_delimiter(path, CIFS_DIR_SEP(cifs_sb));
 	if (tcon->posix_extensions)
-		rc = smb311_posix_get_inode_info(&inode, path, sb, xid);
+		rc = smb311_posix_get_fattr(&fattr, path, sb, xid);
 	else
-		rc = cifs_get_inode_info(&inode, path, NULL, sb, xid, NULL);
+		rc = cifs_get_fattr(NULL, sb, xid, NULL, &fattr, &inode, path);
+
+iget_root:
+	if (!rc) {
+		if (fattr.cf_flags & CIFS_FATTR_JUNCTION) {
+			fattr.cf_flags &= ~CIFS_FATTR_JUNCTION;
+			cifs_autodisable_serverino(cifs_sb);
+		}
+		inode = cifs_iget(sb, &fattr);
+	}
 
-iget_no_retry:
 	if (!inode) {
 		inode = ERR_PTR(rc);
 		goto out;
@@ -1469,6 +1498,7 @@ struct inode *cifs_root_iget(struct super_block *sb)
 out:
 	kfree(path);
 	free_xid(xid);
+	kfree(fattr.cf_symlink_target);
 	return inode;
 }
 
diff --git a/fs/smb/client/namespace.c b/fs/smb/client/namespace.c
index 3252fe33f7a3..c8f5ed8a69f1 100644
--- a/fs/smb/client/namespace.c
+++ b/fs/smb/client/namespace.c
@@ -126,9 +126,11 @@ static char *automount_fullpath(struct dentry *dentry, void *page)
 	char *s;
 
 	spin_lock(&tcon->tc_lock);
-	if (unlikely(!tcon->origin_fullpath)) {
+	if (!tcon->origin_fullpath) {
 		spin_unlock(&tcon->tc_lock);
-		return ERR_PTR(-EREMOTE);
+		return build_path_from_dentry_optional_prefix(dentry,
+							      page,
+							      true);
 	}
 	spin_unlock(&tcon->tc_lock);
 
@@ -162,7 +164,6 @@ static struct vfsmount *cifs_do_automount(struct path *path)
 	int rc;
 	struct dentry *mntpt = path->dentry;
 	struct fs_context *fc;
-	struct cifs_sb_info *cifs_sb;
 	void *page = NULL;
 	struct smb3_fs_context *ctx, *cur_ctx;
 	struct smb3_fs_context tmp;
@@ -172,17 +173,7 @@ static struct vfsmount *cifs_do_automount(struct path *path)
 	if (IS_ROOT(mntpt))
 		return ERR_PTR(-ESTALE);
 
-	/*
-	 * The MSDFS spec states that paths in DFS referral requests and
-	 * responses must be prefixed by a single '\' character instead of
-	 * the double backslashes usually used in the UNC. This function
-	 * gives us the latter, so we must adjust the result.
-	 */
-	cifs_sb = CIFS_SB(mntpt->d_sb);
-	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS)
-		return ERR_PTR(-EREMOTE);
-
-	cur_ctx = cifs_sb->ctx;
+	cur_ctx = CIFS_SB(mntpt->d_sb)->ctx;
 
 	fc = fs_context_for_submount(path->mnt->mnt_sb->s_type, mntpt);
 	if (IS_ERR(fc))
diff --git a/fs/smb/client/readdir.c b/fs/smb/client/readdir.c
index 59bf542d5211..47fc22de8d20 100644
--- a/fs/smb/client/readdir.c
+++ b/fs/smb/client/readdir.c
@@ -143,6 +143,7 @@ static bool reparse_file_needs_reval(const struct cifs_fattr *fattr)
 	case IO_REPARSE_TAG_DFSR:
 	case IO_REPARSE_TAG_SYMLINK:
 	case IO_REPARSE_TAG_NFS:
+	case IO_REPARSE_TAG_MOUNT_POINT:
 	case 0:
 		return true;
 	}
-- 
2.41.0

