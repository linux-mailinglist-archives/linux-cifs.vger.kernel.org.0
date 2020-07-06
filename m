Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 46A7D215AC3
	for <lists+linux-cifs@lfdr.de>; Mon,  6 Jul 2020 17:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729197AbgGFPcH (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 6 Jul 2020 11:32:07 -0400
Received: from mx.cjr.nz ([51.158.111.142]:53954 "EHLO mx.cjr.nz"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729316AbgGFPcG (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 6 Jul 2020 11:32:06 -0400
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id B1D2A807DC;
        Mon,  6 Jul 2020 15:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1594049132;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=khx/ikBjNFF4muTODgLmr+YcOKgU3lbzwu/iv16FiPI=;
        b=b0//zrd8B2ewkL+kCMNyy08a8t/aDRaFxHjL+XlkcGTzUHEnwCzdvs7L7KuOPNmYKc+hI1
        L05zkbsYbmJAK9A3X8DZetCyqbDDQ4z4Sk5btb4EH/APpo8SNSliIekpJ8vuJ8bqtE6+Zl
        xTDdnbAHZzVLVZrk5uZ+RE23M0wQWy844TteMLWpTNrdS9Dhzg3NhyAeignpt3Kr/U5C4t
        c84j3jM0rq4aoVnNSLYEk4GqGDrT/wOJfiuYkZbLjcAsXbJ1nm2dP/5jg3Gm9GIpvgxuNh
        Mgm9yN6BgU6+AF5AHHPjHZ4NvVFGo//iuj9Md5R+uOfkRw1u8GBXyUkiWg/ZTA==
From:   Paulo Alcantara <pc@cjr.nz>
To:     linux-cifs@vger.kernel.org, smfrench@gmail.com
Cc:     Paulo Alcantara <pc@cjr.nz>
Subject: [PATCH 7/7] cifs: document and cleanup dfs mount
Date:   Mon,  6 Jul 2020 12:24:02 -0300
Message-Id: <20200706152402.5721-8-pc@cjr.nz>
In-Reply-To: <20200706152402.5721-1-pc@cjr.nz>
References: <20200706152402.5721-1-pc@cjr.nz>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

cifs_mount() for DFS mounts is for a long time way too complex to
follow, mostly because it lacks some documentation, does a lot of
operations like resolving DFS roots and links, checking for path
components, perform failover, crap code, etc.

Besides adding some documentation to it, do some cleanup and ensure
that the following is implemented and supported:

    * non-DFS mounts
    * DFS failover
    * DFS root mounts
        - tcon and cifs_sb must contain DFS path (NOT including prefix)
        - if prefix path, then save it in cifs_sb and it must not be
	  changed
    * DFS link mounts
      - tcon and cifs_sb must contain DFS path (including prefix)
      - if prefix path, then save it in cifs_sb and it may be changed
    * prevent recursion on broken link referrals (MAX_NESTED_LINKS)
    * check every path component of the currently resolved
      target (including prefix), and chase them accordingly
    * make sure that DFS referrals go through newly resolved root
      servers

Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
---
 fs/cifs/connect.c | 371 +++++++++++++++++++++++-----------------------
 1 file changed, 182 insertions(+), 189 deletions(-)

diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index af0c19495626..1e1f84316faa 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -4423,11 +4423,11 @@ build_unc_path_to_root(const struct smb_vol *vol,
 static int
 expand_dfs_referral(const unsigned int xid, struct cifs_ses *ses,
 		    struct smb_vol *volume_info, struct cifs_sb_info *cifs_sb,
-		    int check_prefix)
+		    char *ref_path)
 {
 	int rc;
 	struct dfs_info3_param referral = {0};
-	char *full_path = NULL, *ref_path = NULL, *mdata = NULL;
+	char *full_path = NULL, *mdata = NULL;
 
 	if (cifs_sb->mnt_cifs_flags & CIFS_MOUNT_NO_DFS)
 		return -EREMOTE;
@@ -4436,9 +4436,6 @@ expand_dfs_referral(const unsigned int xid, struct cifs_ses *ses,
 	if (IS_ERR(full_path))
 		return PTR_ERR(full_path);
 
-	/* For DFS paths, skip the first '\' of the UNC */
-	ref_path = check_prefix ? full_path + 1 : volume_info->UNC + 1;
-
 	rc = dfs_cache_find(xid, ses, cifs_sb->local_nls, cifs_remap(cifs_sb),
 			    ref_path, &referral, NULL);
 	if (!rc) {
@@ -4501,13 +4498,10 @@ static int update_vol_info(const struct dfs_cache_tgt_iterator *tgt_it,
 	return 0;
 }
 
-static int setup_dfs_tgt_conn(const char *path,
+static int setup_dfs_tgt_conn(const char *path, const char *full_path,
 			      const struct dfs_cache_tgt_iterator *tgt_it,
-			      struct cifs_sb_info *cifs_sb,
-			      struct smb_vol *vol,
-			      unsigned int *xid,
-			      struct TCP_Server_Info **server,
-			      struct cifs_ses **ses,
+			      struct cifs_sb_info *cifs_sb, struct smb_vol *vol, unsigned int *xid,
+			      struct TCP_Server_Info **server, struct cifs_ses **ses,
 			      struct cifs_tcon **tcon)
 {
 	int rc;
@@ -4521,8 +4515,7 @@ static int setup_dfs_tgt_conn(const char *path,
 	if (rc)
 		return rc;
 
-	mdata = cifs_compose_mount_options(cifs_sb->mountdata, path, &ref,
-					   &fake_devname);
+	mdata = cifs_compose_mount_options(cifs_sb->mountdata, full_path + 1, &ref, &fake_devname);
 	free_dfs_info_param(&ref);
 
 	if (IS_ERR(mdata)) {
@@ -4545,7 +4538,7 @@ static int setup_dfs_tgt_conn(const char *path,
 		mount_put_conns(cifs_sb, *xid, *server, *ses, *tcon);
 		rc = mount_get_conns(&fake_vol, cifs_sb, xid, server, ses,
 				     tcon);
-		if (!rc) {
+		if (!rc || (*server && *ses)) {
 			/*
 			 * We were able to connect to new target server.
 			 * Update current volume info with new target server.
@@ -4557,14 +4550,10 @@ static int setup_dfs_tgt_conn(const char *path,
 	return rc;
 }
 
-static int mount_do_dfs_failover(const char *path,
-				 struct cifs_sb_info *cifs_sb,
-				 struct smb_vol *vol,
-				 struct cifs_ses *root_ses,
-				 unsigned int *xid,
-				 struct TCP_Server_Info **server,
-				 struct cifs_ses **ses,
-				 struct cifs_tcon **tcon)
+static int do_dfs_failover(const char *path, const char *full_path, struct cifs_sb_info *cifs_sb,
+			   struct smb_vol *vol, struct cifs_ses *root_ses, unsigned int *xid,
+			   struct TCP_Server_Info **server, struct cifs_ses **ses,
+			   struct cifs_tcon **tcon)
 {
 	int rc;
 	struct dfs_cache_tgt_list tgt_list;
@@ -4583,9 +4572,9 @@ static int mount_do_dfs_failover(const char *path,
 		if (rc)
 			break;
 		/* Connect to next DFS target */
-		rc = setup_dfs_tgt_conn(path, tgt_it, cifs_sb, vol, xid, server,
-					ses, tcon);
-		if (!rc || rc == -EACCES || rc == -EOPNOTSUPP)
+		rc = setup_dfs_tgt_conn(path, full_path, tgt_it, cifs_sb, vol, xid, server, ses,
+					tcon);
+		if (!rc || (*server && *ses))
 			break;
 	}
 	if (!rc) {
@@ -4755,207 +4744,209 @@ static int is_path_remote(struct cifs_sb_info *cifs_sb, struct smb_vol *vol,
 }
 
 #ifdef CONFIG_CIFS_DFS_UPCALL
-static inline void set_root_tcon(struct cifs_sb_info *cifs_sb,
-				 struct cifs_tcon *tcon,
-				 struct cifs_tcon **root)
+static void set_root_ses(struct cifs_sb_info *cifs_sb, struct cifs_ses *ses,
+			 struct cifs_ses **root_ses)
 {
-	spin_lock(&cifs_tcp_ses_lock);
-	tcon->tc_count++;
-	tcon->remap = cifs_remap(cifs_sb);
-	spin_unlock(&cifs_tcp_ses_lock);
-	*root = tcon;
+	if (ses) {
+		spin_lock(&cifs_tcp_ses_lock);
+		ses->ses_count++;
+		ses->tcon_ipc->remap = cifs_remap(cifs_sb);
+		spin_unlock(&cifs_tcp_ses_lock);
+	}
+	*root_ses = ses;
+}
+
+static void put_root_ses(struct cifs_ses *ses)
+{
+	if (ses)
+		cifs_put_smb_ses(ses);
+}
+
+/* Check if a path component is remote and then update @dfs_path accordingly */
+static int check_dfs_prepath(struct cifs_sb_info *cifs_sb, struct smb_vol *vol,
+			     const unsigned int xid, struct TCP_Server_Info *server,
+			     struct cifs_tcon *tcon, char **dfs_path)
+{
+	char *path, *s;
+	char sep = CIFS_DIR_SEP(cifs_sb), tmp;
+	char *npath;
+	int rc = 0;
+	int added_treename = tcon->Flags & SMB_SHARE_IS_IN_DFS;
+	int skip = added_treename;
+
+	path = cifs_build_path_to_root(vol, cifs_sb, tcon, added_treename);
+	if (!path)
+		return -ENOMEM;
+
+	/*
+	 * Walk through the path components in @path and check if they're accessible. In case any of
+	 * the components is -EREMOTE, then update @dfs_path with the next DFS referral request path
+	 * (NOT including the remaining components).
+	 */
+	s = path;
+	do {
+		/* skip separators */
+		while (*s && *s == sep)
+			s++;
+		if (!*s)
+			break;
+		/* next separator */
+		while (*s && *s != sep)
+			s++;
+		/*
+		 * if the treename is added, we then have to skip the first
+		 * part within the separators
+		 */
+		if (skip) {
+			skip = 0;
+			continue;
+		}
+		tmp = *s;
+		*s = 0;
+		rc = server->ops->is_path_accessible(xid, tcon, cifs_sb, path);
+		if (rc && rc == -EREMOTE) {
+			struct smb_vol v = {NULL};
+			/* if @path contains a tree name, skip it in the prefix path */
+			if (added_treename) {
+				rc = cifs_parse_devname(path, &v);
+				if (rc)
+					break;
+				rc = -EREMOTE;
+				npath = build_unc_path_to_root(&v, cifs_sb, true);
+				cifs_cleanup_volume_info_contents(&v);
+			} else {
+				v.UNC = vol->UNC;
+				v.prepath = path + 1;
+				npath = build_unc_path_to_root(&v, cifs_sb, true);
+			}
+			if (IS_ERR(npath)) {
+				rc = PTR_ERR(npath);
+				break;
+			}
+			kfree(*dfs_path);
+			*dfs_path = npath;
+		}
+		*s = tmp;
+	} while (rc == 0);
+
+	kfree(path);
+	return rc;
 }
 
 int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb_vol *vol)
 {
 	int rc = 0;
 	unsigned int xid;
-	struct cifs_ses *ses;
-	struct cifs_tcon *root_tcon = NULL;
+	struct TCP_Server_Info *server = NULL;
+	struct cifs_ses *ses = NULL, *root_ses = NULL;
 	struct cifs_tcon *tcon = NULL;
-	struct TCP_Server_Info *server;
-	char *root_path = NULL, *full_path = NULL;
-	char *old_mountdata, *origin_mountdata = NULL;
-	int count;
+	int count = 0;
+	char *ref_path = NULL, *full_path = NULL;
+	char *oldmnt = NULL;
+	char *mntdata = NULL;
 
 	rc = mount_get_conns(vol, cifs_sb, &xid, &server, &ses, &tcon);
-	if (!rc && tcon) {
-		/* If not a standalone DFS root, then check if path is remote */
-		rc = dfs_cache_find(xid, ses, cifs_sb->local_nls,
-				    cifs_remap(cifs_sb), vol->UNC + 1, NULL,
-				    NULL);
-		if (rc) {
-			rc = is_path_remote(cifs_sb, vol, xid, server, tcon);
-			if (!rc)
-				goto out;
-			if (rc != -EREMOTE)
-				goto error;
-		}
-	}
 	/*
-	 * If first DFS target server went offline and we failed to connect it,
-	 * server and ses pointers are NULL at this point, though we still have
-	 * chance to get a cached DFS referral in expand_dfs_referral() and
-	 * retry next target available in it.
+	 * Unconditionally try to get an DFS referral (even cached) to determine whether it is an
+	 * DFS mount.
 	 *
-	 * If a NULL ses ptr is passed to dfs_cache_find(), a lookup will be
-	 * performed against DFS path and *no* requests will be sent to server
-	 * for any new DFS referrals. Hence it's safe to skip checking whether
-	 * server or ses ptr is NULL.
+	 * Skip prefix path to provide support for DFS referrals from w2k8 servers which don't seem
+	 * to respond with PATH_NOT_COVERED to requests that include the prefix.
 	 */
-	if (rc == -EACCES || rc == -EOPNOTSUPP)
-		goto error;
-
-	root_path = build_unc_path_to_root(vol, cifs_sb, false);
-	if (IS_ERR(root_path)) {
-		rc = PTR_ERR(root_path);
-		root_path = NULL;
-		goto error;
-	}
-
-	full_path = build_unc_path_to_root(vol, cifs_sb, true);
-	if (IS_ERR(full_path)) {
-		rc = PTR_ERR(full_path);
-		full_path = NULL;
-		goto error;
-	}
-	/*
-	 * Perform an unconditional check for whether there are DFS
-	 * referrals for this path without prefix, to provide support
-	 * for DFS referrals from w2k8 servers which don't seem to respond
-	 * with PATH_NOT_COVERED to requests that include the prefix.
-	 * Chase the referral if found, otherwise continue normally.
-	 */
-	old_mountdata = cifs_sb->mountdata;
-	(void)expand_dfs_referral(xid, ses, vol, cifs_sb, false);
-
-	if (cifs_sb->mountdata == NULL) {
-		rc = -ENOENT;
-		goto error;
-	}
-
-	/* Save DFS root volume information for DFS refresh worker */
-	origin_mountdata = kstrndup(cifs_sb->mountdata,
-				    strlen(cifs_sb->mountdata), GFP_KERNEL);
-	if (!origin_mountdata) {
-		rc = -ENOMEM;
-		goto error;
-	}
-
-	if (cifs_sb->mountdata != old_mountdata) {
-		/* If we were redirected, reconnect to new target server */
-		mount_put_conns(cifs_sb, xid, server, ses, tcon);
-		rc = mount_get_conns(vol, cifs_sb, &xid, &server, &ses, &tcon);
-	}
-	if (rc) {
-		if (rc == -EACCES || rc == -EOPNOTSUPP)
-			goto error;
-		/* Perform DFS failover to any other DFS targets */
-		rc = mount_do_dfs_failover(root_path + 1, cifs_sb, vol, NULL,
-					   &xid, &server, &ses, &tcon);
+	if (dfs_cache_find(xid, ses, cifs_sb->local_nls, cifs_remap(cifs_sb), vol->UNC + 1, NULL,
+			   NULL)) {
+		/* No DFS referral was returned.  Looks like a regular share. */
 		if (rc)
 			goto error;
+		/* Check if it is fully accessible and then mount it */
+		rc = is_path_remote(cifs_sb, vol, xid, server, tcon);
+		if (!rc)
+			goto out;
+		if (rc != -EREMOTE)
+			goto error;
 	}
-
-	kfree(root_path);
-	root_path = build_unc_path_to_root(vol, cifs_sb, false);
-	if (IS_ERR(root_path)) {
-		rc = PTR_ERR(root_path);
-		root_path = NULL;
+	/* Save mount options */
+	mntdata = kstrndup(cifs_sb->mountdata, strlen(cifs_sb->mountdata), GFP_KERNEL);
+	if (!mntdata) {
+		rc = -ENOMEM;
+		goto error;
+	}
+	/* Get path of DFS root */
+	ref_path = build_unc_path_to_root(vol, cifs_sb, false);
+	if (IS_ERR(ref_path)) {
+		rc = PTR_ERR(ref_path);
+		ref_path = NULL;
 		goto error;
 	}
-	/* Cache out resolved root server */
-	(void)dfs_cache_find(xid, ses, cifs_sb->local_nls, cifs_remap(cifs_sb),
-			     root_path + 1, NULL, NULL);
-	kfree(root_path);
-	root_path = NULL;
-
-	set_root_tcon(cifs_sb, tcon, &root_tcon);
-
-	for (count = 1; ;) {
-		if (!rc && tcon) {
-			rc = is_path_remote(cifs_sb, vol, xid, server, tcon);
-			if (!rc || rc != -EREMOTE)
-				break;
-		}
-		/*
-		 * BB: when we implement proper loop detection,
-		 *     we will remove this check. But now we need it
-		 *     to prevent an indefinite loop if 'DFS tree' is
-		 *     misconfigured (i.e. has loops).
-		 */
-		if (count++ > MAX_NESTED_LINKS) {
-			rc = -ELOOP;
-			break;
-		}
 
+	set_root_ses(cifs_sb, ses, &root_ses);
+	do {
+		/* Save full path of last DFS path we used to resolve final target server */
 		kfree(full_path);
-		full_path = build_unc_path_to_root(vol, cifs_sb, true);
+		full_path = build_unc_path_to_root(vol, cifs_sb, !!count);
 		if (IS_ERR(full_path)) {
 			rc = PTR_ERR(full_path);
-			full_path = NULL;
 			break;
 		}
-
-		old_mountdata = cifs_sb->mountdata;
-		rc = expand_dfs_referral(xid, root_tcon->ses, vol, cifs_sb,
-					 true);
+		/* Chase referral */
+		oldmnt = cifs_sb->mountdata;
+		rc = expand_dfs_referral(xid, root_ses, vol, cifs_sb, ref_path + 1);
 		if (rc)
 			break;
-
-		if (cifs_sb->mountdata != old_mountdata) {
+		/* Connect to new DFS target only if we were redirected */
+		if (oldmnt != cifs_sb->mountdata) {
 			mount_put_conns(cifs_sb, xid, server, ses, tcon);
-			rc = mount_get_conns(vol, cifs_sb, &xid, &server, &ses,
-					     &tcon);
-			/*
-			 * Ensure that DFS referrals go through new root server.
-			 */
-			if (!rc && tcon &&
-			    (tcon->share_flags & (SHI1005_FLAGS_DFS |
-						  SHI1005_FLAGS_DFS_ROOT))) {
-				cifs_put_tcon(root_tcon);
-				set_root_tcon(cifs_sb, tcon, &root_tcon);
-			}
+			rc = mount_get_conns(vol, cifs_sb, &xid, &server, &ses, &tcon);
 		}
-		if (rc) {
-			if (rc == -EACCES || rc == -EOPNOTSUPP)
-				break;
-			/* Perform DFS failover to any other DFS targets */
-			rc = mount_do_dfs_failover(full_path + 1, cifs_sb, vol,
-						   root_tcon->ses, &xid,
-						   &server, &ses, &tcon);
-			if (rc == -EACCES || rc == -EOPNOTSUPP || !server ||
-			    !ses)
-				goto error;
+		if (rc && !server && !ses) {
+			/* Failed to connect. Try to connect to other targets in the referral. */
+			rc = do_dfs_failover(ref_path + 1, full_path, cifs_sb, vol, root_ses, &xid,
+					     &server, &ses, &tcon);
 		}
-	}
-	cifs_put_tcon(root_tcon);
+		if (rc == -EACCES || rc == -EOPNOTSUPP || !server || !ses)
+			break;
+		if (!tcon)
+			continue;
+		/* Make sure that requests go through new root servers */
+		if (tcon->share_flags & (SHI1005_FLAGS_DFS | SHI1005_FLAGS_DFS_ROOT)) {
+			put_root_ses(root_ses);
+			set_root_ses(cifs_sb, ses, &root_ses);
+		}
+		/* Check for remaining path components and then continue chasing them (-EREMOTE) */
+		rc = check_dfs_prepath(cifs_sb, vol, xid, server, tcon, &ref_path);
+		/* Prevent recursion on broken link referrals */
+		if (rc == -EREMOTE && ++count > MAX_NESTED_LINKS)
+			rc = -ELOOP;
+	} while (rc == -EREMOTE);
 
 	if (rc)
 		goto error;
-
-	spin_lock(&cifs_tcp_ses_lock);
-	if (!tcon->dfs_path) {
-		/* Save full path in new tcon to do failover when reconnecting tcons */
-		tcon->dfs_path = full_path;
-		full_path = NULL;
-		tcon->remap = cifs_remap(cifs_sb);
-	}
-	cifs_sb->origin_fullpath = kstrndup(tcon->dfs_path,
-					    strlen(tcon->dfs_path),
-					    GFP_ATOMIC);
+	put_root_ses(root_ses);
+	root_ses = NULL;
+	kfree(ref_path);
+	ref_path = NULL;
+	/* Store DFS full path in both superblock and tree connect structures.
+	 *
+	 * For DFS root mounts, the prefix path (cifs_sb->prepath) is preversed during reconnect so
+	 * only the root path is set in cifs_sb->origin_fullpath and tcon->dfs_path. And for DFS
+	 * links, the prefix path is included in both and may be changed during reconnect.  See
+	 * cifs_tree_connect().
+	 */
+	cifs_sb->origin_fullpath = kstrndup(full_path, strlen(full_path), GFP_KERNEL);
 	if (!cifs_sb->origin_fullpath) {
-		spin_unlock(&cifs_tcp_ses_lock);
 		rc = -ENOMEM;
 		goto error;
 	}
+	spin_lock(&cifs_tcp_ses_lock);
+	tcon->dfs_path = full_path;
+	full_path = NULL;
+	tcon->remap = cifs_remap(cifs_sb);
 	spin_unlock(&cifs_tcp_ses_lock);
 
-	rc = dfs_cache_add_vol(origin_mountdata, vol, cifs_sb->origin_fullpath);
-	if (rc) {
-		kfree(cifs_sb->origin_fullpath);
+	/* Add original volume information for DFS cache to be used when refreshing referrals */
+	rc = dfs_cache_add_vol(mntdata, vol, cifs_sb->origin_fullpath);
+	if (rc)
 		goto error;
-	}
 	/*
 	 * After reconnecting to a different server, unique ids won't
 	 * match anymore, so we disable serverino. This prevents
@@ -4977,9 +4968,11 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb_vol *vol)
 	return mount_setup_tlink(cifs_sb, ses, tcon);
 
 error:
+	kfree(ref_path);
 	kfree(full_path);
-	kfree(root_path);
-	kfree(origin_mountdata);
+	kfree(mntdata);
+	kfree(cifs_sb->origin_fullpath);
+	put_root_ses(root_ses);
 	mount_put_conns(cifs_sb, xid, server, ses, tcon);
 	return rc;
 }
-- 
2.27.0

