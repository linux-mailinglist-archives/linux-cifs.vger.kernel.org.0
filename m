Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CC815A081F
	for <lists+linux-cifs@lfdr.de>; Thu, 25 Aug 2022 06:41:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229553AbiHYEla (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 25 Aug 2022 00:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbiHYEl2 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 25 Aug 2022 00:41:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E434C2AEC
        for <linux-cifs@vger.kernel.org>; Wed, 24 Aug 2022 21:41:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1661402485;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=68rnSs5rg1oEaq6J6eYw6omAPwWeZwDUkokIJKKbP90=;
        b=YUsMwCeX3KJdq3S1G2HkN+fqH3uQZQTCB9pECIPpw3Tl4tfjECKMUAsMl8Xci6A+8pQrLG
        sSzyY0eABFwzkqVLq4uGiWNFgdzn448tFW58dAsCNpvnxL7FUGl3JVazUqisEsf6I4Zrdx
        +/7Ua7GLkWhP7xF3nKADOidyZWCclUk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-342-B6G1wu1PMn2pwTFM-gJwyw-1; Thu, 25 Aug 2022 00:41:23 -0400
X-MC-Unique: B6G1wu1PMn2pwTFM-gJwyw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3CE02803520;
        Thu, 25 Aug 2022 04:41:23 +0000 (UTC)
Received: from localhost.localdomain (vpn2-52-20.bne.redhat.com [10.64.52.20])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 00B1C1410DD5;
        Thu, 25 Aug 2022 04:41:21 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4/5] cifs: enable caching of directories for which a lease is held
Date:   Thu, 25 Aug 2022 14:41:06 +1000
Message-Id: <20220825044107.3703811-5-lsahlber@redhat.com>
In-Reply-To: <20220825044107.3703811-1-lsahlber@redhat.com>
References: <20220825044107.3703811-1-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

This expands the directory caching to now cache an open handle for all
directories (up to a maximum) and not just the root directory.

In this patch, locking and refcounting is intended to work as so:

The main function to get a reference to a cached handle is
find_or_create_cached_dir() called from open_cached_dir()
These functions are protected under the cfid_list_lock spin-lock
to make sure we do not race creating new references for cached dirs
with deletion of expired ones.

An successful open_cached_dir() will take out 2 references to the cfid if
this was the very first and successful call to open the directory and
it acquired a lease from the server.
One reference is for the lease  and the other is for the cfid that we
return. The is lease reference is tracked by cfid->has_lease.
If the directory already has a handle with an active lease, then we just
take out one new reference for the cfid and return it.
It can happen that we have a thread that tries to open a cached directory
where we have a cfid already but we do not, yet, have a working lease. In
this case we will just return NULL, and this the caller will fall back to
the case when no handle was available.

In this model the total number of references we have on a cfid is
1 for while the handle is open and we have a lease, and one additional
reference for each open instance of a cfid.

Once we get a lease break (cached_dir_lease_break()) we remove the
cfid from the list under the spinlock. This prevents any new threads to
use it, and we also call smb2_cached_lease_break() via the work_queue
in order to drop the reference we got for the lease (we drop it outside
of the spin-lock.)
Anytime a thread calls close_cached_dir() we also drop a reference to the
cfid.
When the last reference to the cfid is released smb2_close_cached_fid()
will be invoked which will drop the reference ot the dentry we held for
this cfid and it will also, if we the handle is open/has a lease
also call SMB2_close() to close the handle on the server.

Two events require special handling:
invalidate_all_cached_dirs() this function is called from SMB2_tdis()
and cifs_mark_open_files_invalid().
In both cases the tcon is either gone already or will be shortly so
we do not need to actually close the handles. They will be dropped
server side as part of the tcon dropping.
But we have to be careful about a potential race with a concurrent
lease break so we need to take out additional refences to avoid the
cfid from being freed while we are still referencing it.

free_cached_dirs() which is called from tconInfoFree().
This is called quite late in the umount process so there should no longer
be any open handles or files and we can just free all the remaining data.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/cached_dir.c | 437 +++++++++++++++++++++++++------------------
 fs/cifs/cached_dir.h |  20 +-
 fs/cifs/inode.c      |   6 +-
 fs/cifs/smb2ops.c    |   2 +-
 4 files changed, 267 insertions(+), 198 deletions(-)

diff --git a/fs/cifs/cached_dir.c b/fs/cifs/cached_dir.c
index 0036ba6e0ab0..ce6935c3fe06 100644
--- a/fs/cifs/cached_dir.c
+++ b/fs/cifs/cached_dir.c
@@ -11,7 +11,53 @@
 #include "smb2proto.h"
 #include "cached_dir.h"
 
-struct cached_fid *init_cached_dir(const char *path);
+static struct cached_fid *init_cached_dir(const char *path);
+static void free_cached_dir(struct cached_fid *cfid);
+
+static struct cached_fid *find_or_create_cached_dir(struct cached_fids *cfids,
+						    const char *path,
+						    bool lookup_only)
+{
+	struct cached_fid *cfid;
+
+	spin_lock(&cfids->cfid_list_lock);
+	list_for_each_entry(cfid, &cfids->entries, entry) {
+		if (!strcmp(cfid->path, path)) {
+			/*
+			 * If it doesn't have a lease it is either not yet
+			 * fully cached or it may be in the process of
+			 * being deleted due to a lease break.
+			 */
+			if (!cfid->has_lease) {
+				spin_unlock(&cfids->cfid_list_lock);
+				return NULL;
+			}
+			kref_get(&cfid->refcount);
+			spin_unlock(&cfids->cfid_list_lock);
+			return cfid;
+		}
+	}
+	if (lookup_only) {
+		spin_unlock(&cfids->cfid_list_lock);
+		return NULL;
+	}
+	if (cfids->num_entries >= MAX_CACHED_FIDS) {
+		spin_unlock(&cfids->cfid_list_lock);
+		return NULL;
+	}
+	cfid = init_cached_dir(path);
+	if (cfid == NULL) {
+		spin_unlock(&cfids->cfid_list_lock);
+		return NULL;
+	}
+	cfid->cfids = cfids;
+	cfids->num_entries++;
+	list_add(&cfid->entry, &cfids->entries);
+	cfid->on_list = true;
+	kref_get(&cfid->refcount);
+	spin_unlock(&cfids->cfid_list_lock);
+	return cfid;
+}
 
 /*
  * Open the and cache a directory handle.
@@ -33,61 +79,65 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	struct kvec open_iov[SMB2_CREATE_IOV_SIZE];
 	struct kvec qi_iov[1];
 	int rc, flags = 0;
-	__le16 utf16_path = 0; /* Null - since an open of top of share */
+	__le16 *utf16_path = NULL;
 	u8 oplock = SMB2_OPLOCK_LEVEL_II;
 	struct cifs_fid *pfid;
-	struct dentry *dentry;
+	struct dentry *dentry = NULL;
 	struct cached_fid *cfid;
+	struct cached_fids *cfids;
+	  
 
-	if (tcon == NULL || tcon->nohandlecache ||
+	if (tcon == NULL || tcon->cfids == NULL || tcon->nohandlecache ||
 	    is_smb1_server(tcon->ses->server))
-		return -EOPNOTSUPP;
+		return -ENOTSUPP;
 
 	ses = tcon->ses;
 	server = ses->server;
+	cfids = tcon->cfids;
 
+	if (!server->ops->new_lease_key)
+		return -EIO;
+	
 	if (cifs_sb->root == NULL)
 		return -ENOENT;
 
+	/*
+	 * TODO: for better caching we need to find and use the dentry also
+	 * for non-root directories.
+	 */
 	if (!path[0])
 		dentry = cifs_sb->root;
-	else
-		return -ENOENT;
 
-	cfid = tcon->cfids->cfid;
-	if (cfid == NULL) {
-		cfid = init_cached_dir(path);
-		tcon->cfids->cfid = cfid;
-	}
-	if (cfid == NULL)
+	utf16_path = cifs_convert_path_to_utf16(path, cifs_sb);
+	if (!utf16_path)
 		return -ENOMEM;
 
-	mutex_lock(&cfid->fid_mutex);
-	if (cfid->is_valid) {
-		cifs_dbg(FYI, "found a cached root file handle\n");
+	cfid = find_or_create_cached_dir(cfids, path, lookup_only);
+	if (cfid == NULL) {
+		kfree(utf16_path);
+		return -ENOENT;
+	}
+	/*
+	 * At this point we either have a lease already and we can just
+	 * return it. If not we are guaranteed to be the only thread accessing
+	 * this cfid.
+	 */
+	if (cfid->has_lease) {
 		*ret_cfid = cfid;
-		kref_get(&cfid->refcount);
-		mutex_unlock(&cfid->fid_mutex);
+		kfree(utf16_path);
 		return 0;
 	}
 
 	/*
 	 * We do not hold the lock for the open because in case
-	 * SMB2_open needs to reconnect, it will end up calling
-	 * cifs_mark_open_files_invalid() which takes the lock again
-	 * thus causing a deadlock
+	 * SMB2_open needs to reconnect.
+	 * This is safe because no other thread will be able to get a ref
+	 * to the cfid until we have finished opening the file and (possibly)
+	 * aquired a lease.
 	 */
-	mutex_unlock(&cfid->fid_mutex);
-
-	if (lookup_only)
-		return -ENOENT;
-
 	if (smb3_encryption_required(tcon))
 		flags |= CIFS_TRANSFORM_REQ;
 
-	if (!server->ops->new_lease_key)
-		return -EIO;
-
 	pfid = &cfid->fid;
 	server->ops->new_lease_key(pfid);
 
@@ -108,7 +158,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	oparms.reconnect = false;
 
 	rc = SMB2_open_init(tcon, server,
-			    &rqst[0], &oplock, &oparms, &utf16_path);
+			    &rqst[0], &oplock, &oparms, utf16_path);
 	if (rc)
 		goto oshr_free;
 	smb2_set_next_command(tcon, &rqst[0]);
@@ -131,47 +181,13 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	rc = compound_send_recv(xid, ses, server,
 				flags, 2, rqst,
 				resp_buftype, rsp_iov);
-	mutex_lock(&cfid->fid_mutex);
-
-	/*
-	 * Now we need to check again as the cached root might have
-	 * been successfully re-opened from a concurrent process
-	 */
-
-	if (cfid->is_valid) {
-		/* work was already done */
-
-		/* stash fids for close() later */
-		struct cifs_fid fid = {
-			.persistent_fid = pfid->persistent_fid,
-			.volatile_fid = pfid->volatile_fid,
-		};
-
-		/*
-		 * caller expects this func to set the fid in cfid to valid
-		 * cached root, so increment the refcount.
-		 */
-		kref_get(&cfid->refcount);
-
-		mutex_unlock(&cfid->fid_mutex);
-
-		if (rc == 0) {
-			/* close extra handle outside of crit sec */
-			SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
-		}
-		rc = 0;
-		goto oshr_free;
-	}
-
-	/* Cached root is still invalid, continue normaly */
-
 	if (rc) {
 		if (rc == -EREMCHG) {
 			tcon->need_reconnect = true;
 			pr_warn_once("server share %s deleted\n",
 				     tcon->treeName);
 		}
-		goto oshr_exit;
+		goto oshr_free;
 	}
 
 	atomic_inc(&tcon->num_remote_opens);
@@ -184,49 +200,56 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 #endif /* CIFS_DEBUG2 */
 
 	cfid->tcon = tcon;
-	cfid->is_valid = true;
-	cfid->dentry = dentry;
-	if (dentry)
+	if (dentry) {
+		cfid->dentry = dentry;
 		dget(dentry);
-	kref_init(&cfid->refcount);
-
+	}
 	/* BB TBD check to see if oplock level check can be removed below */
-	if (o_rsp->OplockLevel == SMB2_OPLOCK_LEVEL_LEASE) {
-		/*
-		 * See commit 2f94a3125b87. Increment the refcount when we
-		 * get a lease for root, release it if lease break occurs
-		 */
-		kref_get(&cfid->refcount);
-		cfid->has_lease = true;
-		smb2_parse_contexts(server, o_rsp,
-				&oparms.fid->epoch,
-				    oparms.fid->lease_key, &oplock,
-				    NULL, NULL);
-	} else
-		goto oshr_exit;
+	if (o_rsp->OplockLevel != SMB2_OPLOCK_LEVEL_LEASE) {
+		goto oshr_free;
+	}
 
+	smb2_parse_contexts(server, o_rsp,
+			    &oparms.fid->epoch,
+			    oparms.fid->lease_key, &oplock,
+			    NULL, NULL);
+	
 	qi_rsp = (struct smb2_query_info_rsp *)rsp_iov[1].iov_base;
 	if (le32_to_cpu(qi_rsp->OutputBufferLength) < sizeof(struct smb2_file_all_info))
-		goto oshr_exit;
+		goto oshr_free;
 	if (!smb2_validate_and_copy_iov(
 				le16_to_cpu(qi_rsp->OutputBufferOffset),
 				sizeof(struct smb2_file_all_info),
 				&rsp_iov[1], sizeof(struct smb2_file_all_info),
 				(char *)&cfid->file_all_info))
 		cfid->file_all_info_is_valid = true;
-
 	cfid->time = jiffies;
+	cfid->is_open = true;
+	cfid->has_lease = true;
 
-oshr_exit:
-	mutex_unlock(&cfid->fid_mutex);
 oshr_free:
+	kfree(utf16_path);
 	SMB2_open_free(&rqst[0]);
 	SMB2_query_info_free(&rqst[1]);
 	free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
 	free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
-	if (rc == 0)
-		*ret_cfid = cfid;
-
+	spin_lock(&cfids->cfid_list_lock);
+	if (!cfid->has_lease) {
+		if (cfid->on_list) {
+			list_del(&cfid->entry);
+			cfid->on_list = false;
+			cfids->num_entries--;
+		}
+		rc = -ENOENT;
+	}
+	spin_unlock(&cfids->cfid_list_lock);
+	if (rc) {
+		free_cached_dir(cfid);
+		cfid = NULL;
+	}
+	if (rc == 0) {
+		*ret_cfid = cfid;	
+	}
 	return rc;
 }
 
@@ -235,20 +258,22 @@ int open_cached_dir_by_dentry(struct cifs_tcon *tcon,
 			      struct cached_fid **ret_cfid)
 {
 	struct cached_fid *cfid;
+	struct cached_fids *cfids = tcon->cfids;
 
-	cfid = tcon->cfids->cfid;
-	if (cfid == NULL)
+	if (cfids == NULL)
 		return -ENOENT;
 
-	mutex_lock(&cfid->fid_mutex);
-	if (cfid->dentry == dentry) {
-		cifs_dbg(FYI, "found a cached root file handle by dentry\n");
-		*ret_cfid = cfid;
-		kref_get(&cfid->refcount);
-		mutex_unlock(&cfid->fid_mutex);
-		return 0;
+	spin_lock(&cfids->cfid_list_lock);
+	list_for_each_entry(cfid, &cfids->entries, entry) {
+		if (dentry && cfid->dentry == dentry) {
+			cifs_dbg(FYI, "found a cached root file handle by dentry\n");
+			kref_get(&cfid->refcount);
+			*ret_cfid = cfid;	
+			spin_unlock(&cfids->cfid_list_lock);
+			return 0;
+		}
 	}
-	mutex_unlock(&cfid->fid_mutex);
+	spin_unlock(&cfids->cfid_list_lock);
 	return -ENOENT;
 }
 
@@ -257,63 +282,29 @@ smb2_close_cached_fid(struct kref *ref)
 {
 	struct cached_fid *cfid = container_of(ref, struct cached_fid,
 					       refcount);
-	struct cached_dirent *dirent, *q;
 
-	if (cfid->is_valid) {
-		cifs_dbg(FYI, "clear cached root file handle\n");
-		SMB2_close(0, cfid->tcon, cfid->fid.persistent_fid,
-			   cfid->fid.volatile_fid);
+	spin_lock(&cfid->cfids->cfid_list_lock);
+	if (cfid->on_list) {
+		list_del(&cfid->entry);
+		cfid->on_list = false;
+		cfid->cfids->num_entries--;
 	}
+	spin_unlock(&cfid->cfids->cfid_list_lock);
 
-	/*
-	 * We only check validity above to send SMB2_close,
-	 * but we still need to invalidate these entries
-	 * when this function is called
-	 */
-	cfid->is_valid = false;
-	cfid->file_all_info_is_valid = false;
-	cfid->has_lease = false;
-	if (cfid->dentry) {
-		dput(cfid->dentry);
-		cfid->dentry = NULL;
-	}
-	/*
-	 * Delete all cached dirent names
-	 */
-	mutex_lock(&cfid->dirents.de_mutex);
-	list_for_each_entry_safe(dirent, q, &cfid->dirents.entries, entry) {
-		list_del(&dirent->entry);
-		kfree(dirent->name);
-		kfree(dirent);
+	dput(cfid->dentry);
+	cfid->dentry = NULL;
+
+	if (cfid->is_open) {
+		SMB2_close(0, cfid->tcon, cfid->fid.persistent_fid,
+			   cfid->fid.volatile_fid);
 	}
-	cfid->dirents.is_valid = 0;
-	cfid->dirents.is_failed = 0;
-	cfid->dirents.ctx = NULL;
-	cfid->dirents.pos = 0;
-	mutex_unlock(&cfid->dirents.de_mutex);
 
+	free_cached_dir(cfid);
 }
 
 void close_cached_dir(struct cached_fid *cfid)
 {
-	mutex_lock(&cfid->fid_mutex);
 	kref_put(&cfid->refcount, smb2_close_cached_fid);
-	mutex_unlock(&cfid->fid_mutex);
-}
-
-void close_cached_dir_lease_locked(struct cached_fid *cfid)
-{
-	if (cfid->has_lease) {
-		cfid->has_lease = false;
-		kref_put(&cfid->refcount, smb2_close_cached_fid);
-	}
-}
-
-void close_cached_dir_lease(struct cached_fid *cfid)
-{
-	mutex_lock(&cfid->fid_mutex);
-	close_cached_dir_lease_locked(cfid);
-	mutex_unlock(&cfid->fid_mutex);
 }
 
 /*
@@ -326,41 +317,62 @@ void close_all_cached_dirs(struct cifs_sb_info *cifs_sb)
 	struct cached_fid *cfid;
 	struct cifs_tcon *tcon;
 	struct tcon_link *tlink;
+	struct cached_fids *cfids;
 
 	for (node = rb_first(root); node; node = rb_next(node)) {
 		tlink = rb_entry(node, struct tcon_link, tl_rbnode);
 		tcon = tlink_tcon(tlink);
 		if (IS_ERR(tcon))
 			continue;
-		cfid = tcon->cfids->cfid;
-		if (cfid == NULL)
+		cfids = tcon->cfids;
+		if (cfids == NULL)
 			continue;
-		mutex_lock(&cfid->fid_mutex);
-		if (cfid->dentry) {
+		list_for_each_entry(cfid, &cfids->entries, entry) {
 			dput(cfid->dentry);
 			cfid->dentry = NULL;
 		}
-		mutex_unlock(&cfid->fid_mutex);
 	}
 }
 
 /*
- * Invalidate and close all cached dirs when a TCON has been reset
+ * Invalidate all cached dirs when a TCON has been reset
  * due to a session loss.
  */
 void invalidate_all_cached_dirs(struct cifs_tcon *tcon)
 {
-	struct cached_fid *cfid = tcon->cfids->cfid;
-
-	if (cfid == NULL)
-		return;
-
-	mutex_lock(&cfid->fid_mutex);
-	cfid->is_valid = false;
-	/* cached handle is not valid, so SMB2_CLOSE won't be sent below */
-	close_cached_dir_lease_locked(cfid);
-	memset(&cfid->fid, 0, sizeof(struct cifs_fid));
-	mutex_unlock(&cfid->fid_mutex);
+	struct cached_fids *cfids = tcon->cfids;
+	struct cached_fid *cfid, *q;
+	struct list_head entry;
+
+	INIT_LIST_HEAD(&entry);
+	spin_lock(&cfids->cfid_list_lock);
+	list_for_each_entry_safe(cfid, q, &cfids->entries, entry) {
+		list_del(&cfid->entry);
+		list_add(&cfid->entry, &entry);
+		cfids->num_entries--;
+		cfid->is_open = false;
+		/* To prevent race with smb2_cached_lease_break() */
+		kref_get(&cfid->refcount);
+	}
+	spin_unlock(&cfids->cfid_list_lock);
+
+	list_for_each_entry_safe(cfid, q, &entry, entry) {
+		cfid->on_list = false;
+		list_del(&cfid->entry);
+		cancel_work_sync(&cfid->lease_break);
+		if (cfid->has_lease) {
+			/*
+			 * We lease was never cancelled from the server so we
+			 * we need to drop the reference.
+			 */
+			spin_lock(&cfids->cfid_list_lock);
+			cfid->has_lease = false;
+			spin_unlock(&cfids->cfid_list_lock);
+			kref_put(&cfid->refcount, smb2_close_cached_fid);
+		}
+		/* Drop the extra reference opened above*/
+		kref_put(&cfid->refcount, smb2_close_cached_fid);
+	}
 }
 
 static void
@@ -369,51 +381,83 @@ smb2_cached_lease_break(struct work_struct *work)
 	struct cached_fid *cfid = container_of(work,
 				struct cached_fid, lease_break);
 
-	close_cached_dir_lease(cfid);
+	spin_lock(&cfid->cfids->cfid_list_lock);
+	cfid->has_lease = false;
+	spin_unlock(&cfid->cfids->cfid_list_lock);
+	kref_put(&cfid->refcount, smb2_close_cached_fid);
 }
 
 int cached_dir_lease_break(struct cifs_tcon *tcon, __u8 lease_key[16])
 {
-	struct cached_fid *cfid = tcon->cfids->cfid;
+	struct cached_fids *cfids = tcon->cfids;
+	struct cached_fid *cfid;
 
-	if (cfid == NULL)
+	if (cfids == NULL)
 		return false;
 
-	if (cfid->is_valid &&
-	    !memcmp(lease_key,
-		    cfid->fid.lease_key,
-		    SMB2_LEASE_KEY_SIZE)) {
-		cfid->time = 0;
-		INIT_WORK(&cfid->lease_break,
-			  smb2_cached_lease_break);
-		queue_work(cifsiod_wq,
-			   &cfid->lease_break);
-		return true;
+	spin_lock(&cfids->cfid_list_lock);
+	list_for_each_entry(cfid, &cfids->entries, entry) {
+		if (cfid->has_lease &&
+		    !memcmp(lease_key,
+			    cfid->fid.lease_key,
+			    SMB2_LEASE_KEY_SIZE)) {
+			cfid->time = 0;
+			/*
+			 * We found a lease remove it from the list
+			 * so no threads threads can access it.
+			 */
+			list_del(&cfid->entry);
+			cfid->on_list = false;
+			cfids->num_entries--;
+
+			queue_work(cifsiod_wq,
+				   &cfid->lease_break);
+			spin_unlock(&cfids->cfid_list_lock);
+			return true;
+		}
 	}
+	spin_unlock(&cfids->cfid_list_lock);
 	return false;
 }
 
-struct cached_fid *init_cached_dir(const char *path)
+static struct cached_fid *init_cached_dir(const char *path)
 {
 	struct cached_fid *cfid;
 
-	cfid = kzalloc(sizeof(*cfid), GFP_KERNEL);
+	cfid = kzalloc(sizeof(*cfid), GFP_ATOMIC);
 	if (!cfid)
 		return NULL;
-	cfid->path = kstrdup(path, GFP_KERNEL);
+	cfid->path = kstrdup(path, GFP_ATOMIC);
 	if (!cfid->path) {
 		kfree(cfid);
 		return NULL;
 	}
 
+	INIT_WORK(&cfid->lease_break, smb2_cached_lease_break);
+	INIT_LIST_HEAD(&cfid->entry);
 	INIT_LIST_HEAD(&cfid->dirents.entries);
 	mutex_init(&cfid->dirents.de_mutex);
-	mutex_init(&cfid->fid_mutex);
+	spin_lock_init(&cfid->fid_lock);
+	kref_init(&cfid->refcount);
 	return cfid;
 }
 
-void free_cached_dir(struct cached_fid *cfid)
+static void free_cached_dir(struct cached_fid *cfid)
 {
+	struct cached_dirent *dirent, *q;
+
+	dput(cfid->dentry);
+	cfid->dentry = NULL;
+
+	/*
+	 * Delete all cached dirent names
+	 */
+	list_for_each_entry_safe(dirent, q, &cfid->dirents.entries, entry) {
+		list_del(&dirent->entry);
+		kfree(dirent->name);
+		kfree(dirent);
+	}
+
 	kfree(cfid->path);
 	cfid->path = NULL;
 	kfree(cfid);
@@ -426,15 +470,34 @@ struct cached_fids *init_cached_dirs(void)
 	cfids = kzalloc(sizeof(*cfids), GFP_KERNEL);
 	if (!cfids)
 		return NULL;
-	mutex_init(&cfids->cfid_list_mutex);
+	spin_lock_init(&cfids->cfid_list_lock);
+	INIT_LIST_HEAD(&cfids->entries);
 	return cfids;
 }
 
+/*
+ * Called from tconInfoFree when we are tearing down the tcon.
+ * There are no active users or open files/directories at this point.
+ */
 void free_cached_dirs(struct cached_fids *cfids)
 {
-	if (cfids->cfid) {
-		free_cached_dir(cfids->cfid);
-		cfids->cfid = NULL;
+	struct cached_fid *cfid, *q;
+	struct list_head entry;
+
+       	INIT_LIST_HEAD(&entry);
+	spin_lock(&cfids->cfid_list_lock);
+	list_for_each_entry_safe(cfid, q, &cfids->entries, entry) {
+		cfid->on_list = false;
+		cfid->is_open = false;
+		list_del(&cfid->entry);
+		list_add(&cfid->entry, &entry);
 	}
-	kfree(cfids);
+	spin_unlock(&cfids->cfid_list_lock);
+
+	list_for_each_entry_safe(cfid, q, &entry, entry) {
+		list_del(&cfid->entry);
+		free_cached_dir(cfid);
+	}
+
+ 	kfree(cfids);
 }
diff --git a/fs/cifs/cached_dir.h b/fs/cifs/cached_dir.h
index bdf6c3866653..e536304ca2ce 100644
--- a/fs/cifs/cached_dir.h
+++ b/fs/cifs/cached_dir.h
@@ -31,14 +31,17 @@ struct cached_dirents {
 };
 
 struct cached_fid {
+	struct list_head entry;
+	struct cached_fids *cfids;
 	const char *path;
-	bool is_valid:1;	/* Do we have a useable root fid */
-	bool file_all_info_is_valid:1;
 	bool has_lease:1;
+	bool is_open:1;
+	bool on_list:1;
+	bool file_all_info_is_valid:1;
 	unsigned long time; /* jiffies of when lease was taken */
 	struct kref refcount;
 	struct cifs_fid fid;
-	struct mutex fid_mutex;
+	spinlock_t fid_lock;
 	struct cifs_tcon *tcon;
 	struct dentry *dentry;
 	struct work_struct lease_break;
@@ -46,9 +49,14 @@ struct cached_fid {
 	struct cached_dirents dirents;
 };
 
+#define MAX_CACHED_FIDS 16
 struct cached_fids {
-	struct mutex cfid_list_mutex;
-	struct cached_fid *cfid;
+	/* Must be held when:
+	 * - accessing the cfids->entries list
+	 */
+	spinlock_t cfid_list_lock;
+	int num_entries;
+	struct list_head entries;
 };
 
 extern struct cached_fids *init_cached_dirs(void);
@@ -61,8 +69,6 @@ extern int open_cached_dir_by_dentry(struct cifs_tcon *tcon,
 				     struct dentry *dentry,
 				     struct cached_fid **cfid);
 extern void close_cached_dir(struct cached_fid *cfid);
-extern void close_cached_dir_lease(struct cached_fid *cfid);
-extern void close_cached_dir_lease_locked(struct cached_fid *cfid);
 extern void close_all_cached_dirs(struct cifs_sb_info *cifs_sb);
 extern void invalidate_all_cached_dirs(struct cifs_tcon *tcon);
 extern int cached_dir_lease_break(struct cifs_tcon *tcon, __u8 lease_key[16]);
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index bac08c20f559..a42397b52882 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2265,13 +2265,13 @@ cifs_dentry_needs_reval(struct dentry *dentry)
 		return true;
 
 	if (!open_cached_dir_by_dentry(tcon, dentry->d_parent, &cfid)) {
-		mutex_lock(&cfid->fid_mutex);
+		spin_lock(&cfid->fid_lock);
 		if (cfid->time && cifs_i->time > cfid->time) {
-			mutex_unlock(&cfid->fid_mutex);
+			spin_unlock(&cfid->fid_lock);
 			close_cached_dir(cfid);
 			return false;
 		}
-		mutex_unlock(&cfid->fid_mutex);
+		spin_unlock(&cfid->fid_lock);
 		close_cached_dir(cfid);
 	}
 	/*
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 96f3b0573606..1ed4b4992025 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -787,7 +787,7 @@ smb2_is_path_accessible(const unsigned int xid, struct cifs_tcon *tcon,
 
 	rc = open_cached_dir(xid, tcon, full_path, cifs_sb, true, &cfid);
 	if (!rc) {
-		if (cfid->is_valid) {
+		if (cfid->has_lease) {
 			close_cached_dir(cfid);
 			return 0;
 		}
-- 
2.35.3

