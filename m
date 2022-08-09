Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 553BA58D1EC
	for <lists+linux-cifs@lfdr.de>; Tue,  9 Aug 2022 04:12:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229578AbiHICMW (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 8 Aug 2022 22:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHICMV (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 8 Aug 2022 22:12:21 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A3AB18B09
        for <linux-cifs@vger.kernel.org>; Mon,  8 Aug 2022 19:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660011138;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=r+8lW8efHUVOfrYWlrYV/fUF0TEjHSh3+LTLMIgpMo0=;
        b=Q6GBbSySFK2yvVC2wC7wWWwUfZUeMTZJ5xbs4UtUzrcSPn6h5ArJgJWBx5vSoAiIaxGc2O
        bRIFEw+JDvPGCoZAjE39g0fUvvX9GmL0Yj+fQ6GCZpPc0L97czryviCMPQ2CZlyzWdc21v
        kORb6sotkiCv6f2QbHEU+fHlrXaObnA=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-516-ZswrbrXRNPu_onaRv_gA_A-1; Mon, 08 Aug 2022 22:12:15 -0400
X-MC-Unique: ZswrbrXRNPu_onaRv_gA_A-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BA0543C0D191;
        Tue,  9 Aug 2022 02:12:14 +0000 (UTC)
Received: from localhost.localdomain (vpn2-52-16.bne.redhat.com [10.64.52.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3740D403178;
        Tue,  9 Aug 2022 02:12:12 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 1/9] cifs: Move cached-dir functions into a separate file
Date:   Tue,  9 Aug 2022 12:11:48 +1000
Message-Id: <20220809021156.3086869-2-lsahlber@redhat.com>
In-Reply-To: <20220809021156.3086869-1-lsahlber@redhat.com>
References: <20220809021156.3086869-1-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Also rename crfid to cfid to have consistent naming for this variable.

This commit does not change any logic.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/Makefile     |   2 +-
 fs/cifs/cached_dir.c | 363 +++++++++++++++++++++++++++++++++++++++++++
 fs/cifs/cached_dir.h |  26 ++++
 fs/cifs/cifsfs.c     |  20 +--
 fs/cifs/cifsglob.h   |   2 +-
 fs/cifs/cifsproto.h  |   1 -
 fs/cifs/cifssmb.c    |   8 +-
 fs/cifs/inode.c      |   1 +
 fs/cifs/misc.c       |  12 +-
 fs/cifs/readdir.c    |   1 +
 fs/cifs/smb2inode.c  |   5 +-
 fs/cifs/smb2misc.c   |  13 +-
 fs/cifs/smb2ops.c    | 297 +----------------------------------
 fs/cifs/smb2pdu.c    |   3 +-
 fs/cifs/smb2proto.h  |  10 --
 15 files changed, 412 insertions(+), 352 deletions(-)
 create mode 100644 fs/cifs/cached_dir.c
 create mode 100644 fs/cifs/cached_dir.h

diff --git a/fs/cifs/Makefile b/fs/cifs/Makefile
index 8c9f2c00be72..343a59e0d64d 100644
--- a/fs/cifs/Makefile
+++ b/fs/cifs/Makefile
@@ -7,7 +7,7 @@ obj-$(CONFIG_CIFS) += cifs.o
 
 cifs-y := trace.o cifsfs.o cifssmb.o cifs_debug.o connect.o dir.o file.o \
 	  inode.o link.o misc.o netmisc.o smbencrypt.o transport.o \
-	  cifs_unicode.o nterr.o cifsencrypt.o \
+	  cached_dir.o cifs_unicode.o nterr.o cifsencrypt.o \
 	  readdir.o ioctl.o sess.o export.o unc.o winucase.o \
 	  smb2ops.o smb2maperror.o smb2transport.o \
 	  smb2misc.o smb2pdu.o smb2inode.o smb2file.o cifsacl.o fs_context.o \
diff --git a/fs/cifs/cached_dir.c b/fs/cifs/cached_dir.c
new file mode 100644
index 000000000000..f2e17c1d5196
--- /dev/null
+++ b/fs/cifs/cached_dir.c
@@ -0,0 +1,363 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Functions to handle the cached directory entries
+ *
+ *  Copyright (c) 2022, Ronnie Sahlberg <lsahlber@redhat.com>
+ */
+
+#include "cifsglob.h"
+#include "cifsproto.h"
+#include "cifs_debug.h"
+#include "smb2proto.h"
+#include "cached_dir.h"
+
+/*
+ * Open the and cache a directory handle.
+ * If error then *cfid is not initialized.
+ */
+int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
+		const char *path,
+		struct cifs_sb_info *cifs_sb,
+		struct cached_fid **cfid)
+{
+	struct cifs_ses *ses;
+	struct TCP_Server_Info *server;
+	struct cifs_open_parms oparms;
+	struct smb2_create_rsp *o_rsp = NULL;
+	struct smb2_query_info_rsp *qi_rsp = NULL;
+	int resp_buftype[2];
+	struct smb_rqst rqst[2];
+	struct kvec rsp_iov[2];
+	struct kvec open_iov[SMB2_CREATE_IOV_SIZE];
+	struct kvec qi_iov[1];
+	int rc, flags = 0;
+	__le16 utf16_path = 0; /* Null - since an open of top of share */
+	u8 oplock = SMB2_OPLOCK_LEVEL_II;
+	struct cifs_fid *pfid;
+	struct dentry *dentry;
+
+	if (tcon == NULL || tcon->nohandlecache ||
+	    is_smb1_server(tcon->ses->server))
+		return -ENOTSUPP;
+
+	ses = tcon->ses;
+	server = ses->server;
+
+	if (cifs_sb->root == NULL)
+		return -ENOENT;
+
+	if (strlen(path))
+		return -ENOENT;
+
+	dentry = cifs_sb->root;
+
+	mutex_lock(&tcon->cfid.fid_mutex);
+	if (tcon->cfid.is_valid) {
+		cifs_dbg(FYI, "found a cached root file handle\n");
+		*cfid = &tcon->cfid;
+		kref_get(&tcon->cfid.refcount);
+		mutex_unlock(&tcon->cfid.fid_mutex);
+		return 0;
+	}
+
+	/*
+	 * We do not hold the lock for the open because in case
+	 * SMB2_open needs to reconnect, it will end up calling
+	 * cifs_mark_open_files_invalid() which takes the lock again
+	 * thus causing a deadlock
+	 */
+
+	mutex_unlock(&tcon->cfid.fid_mutex);
+
+	if (smb3_encryption_required(tcon))
+		flags |= CIFS_TRANSFORM_REQ;
+
+	if (!server->ops->new_lease_key)
+		return -EIO;
+
+	pfid = tcon->cfid.fid;
+	server->ops->new_lease_key(pfid);
+
+	memset(rqst, 0, sizeof(rqst));
+	resp_buftype[0] = resp_buftype[1] = CIFS_NO_BUFFER;
+	memset(rsp_iov, 0, sizeof(rsp_iov));
+
+	/* Open */
+	memset(&open_iov, 0, sizeof(open_iov));
+	rqst[0].rq_iov = open_iov;
+	rqst[0].rq_nvec = SMB2_CREATE_IOV_SIZE;
+
+	oparms.tcon = tcon;
+	oparms.create_options = cifs_create_options(cifs_sb, CREATE_NOT_FILE);
+	oparms.desired_access = FILE_READ_ATTRIBUTES;
+	oparms.disposition = FILE_OPEN;
+	oparms.fid = pfid;
+	oparms.reconnect = false;
+
+	rc = SMB2_open_init(tcon, server,
+			    &rqst[0], &oplock, &oparms, &utf16_path);
+	if (rc)
+		goto oshr_free;
+	smb2_set_next_command(tcon, &rqst[0]);
+
+	memset(&qi_iov, 0, sizeof(qi_iov));
+	rqst[1].rq_iov = qi_iov;
+	rqst[1].rq_nvec = 1;
+
+	rc = SMB2_query_info_init(tcon, server,
+				  &rqst[1], COMPOUND_FID,
+				  COMPOUND_FID, FILE_ALL_INFORMATION,
+				  SMB2_O_INFO_FILE, 0,
+				  sizeof(struct smb2_file_all_info) +
+				  PATH_MAX * 2, 0, NULL);
+	if (rc)
+		goto oshr_free;
+
+	smb2_set_related(&rqst[1]);
+
+	rc = compound_send_recv(xid, ses, server,
+				flags, 2, rqst,
+				resp_buftype, rsp_iov);
+	mutex_lock(&tcon->cfid.fid_mutex);
+
+	/*
+	 * Now we need to check again as the cached root might have
+	 * been successfully re-opened from a concurrent process
+	 */
+
+	if (tcon->cfid.is_valid) {
+		/* work was already done */
+
+		/* stash fids for close() later */
+		struct cifs_fid fid = {
+			.persistent_fid = pfid->persistent_fid,
+			.volatile_fid = pfid->volatile_fid,
+		};
+
+		/*
+		 * caller expects this func to set the fid in cfid to valid
+		 * cached root, so increment the refcount.
+		 */
+		kref_get(&tcon->cfid.refcount);
+
+		mutex_unlock(&tcon->cfid.fid_mutex);
+
+		if (rc == 0) {
+			/* close extra handle outside of crit sec */
+			SMB2_close(xid, tcon, fid.persistent_fid, fid.volatile_fid);
+		}
+		rc = 0;
+		goto oshr_free;
+	}
+
+	/* Cached root is still invalid, continue normaly */
+
+	if (rc) {
+		if (rc == -EREMCHG) {
+			tcon->need_reconnect = true;
+			pr_warn_once("server share %s deleted\n",
+				     tcon->treeName);
+		}
+		goto oshr_exit;
+	}
+
+	atomic_inc(&tcon->num_remote_opens);
+
+	o_rsp = (struct smb2_create_rsp *)rsp_iov[0].iov_base;
+	oparms.fid->persistent_fid = o_rsp->PersistentFileId;
+	oparms.fid->volatile_fid = o_rsp->VolatileFileId;
+#ifdef CONFIG_CIFS_DEBUG2
+	oparms.fid->mid = le64_to_cpu(o_rsp->hdr.MessageId);
+#endif /* CIFS_DEBUG2 */
+
+	tcon->cfid.tcon = tcon;
+	tcon->cfid.is_valid = true;
+	tcon->cfid.dentry = dentry;
+	dget(dentry);
+	kref_init(&tcon->cfid.refcount);
+
+	/* BB TBD check to see if oplock level check can be removed below */
+	if (o_rsp->OplockLevel == SMB2_OPLOCK_LEVEL_LEASE) {
+		/*
+		 * See commit 2f94a3125b87. Increment the refcount when we
+		 * get a lease for root, release it if lease break occurs
+		 */
+		kref_get(&tcon->cfid.refcount);
+		tcon->cfid.has_lease = true;
+		smb2_parse_contexts(server, o_rsp,
+				&oparms.fid->epoch,
+				    oparms.fid->lease_key, &oplock,
+				    NULL, NULL);
+	} else
+		goto oshr_exit;
+
+	qi_rsp = (struct smb2_query_info_rsp *)rsp_iov[1].iov_base;
+	if (le32_to_cpu(qi_rsp->OutputBufferLength) < sizeof(struct smb2_file_all_info))
+		goto oshr_exit;
+	if (!smb2_validate_and_copy_iov(
+				le16_to_cpu(qi_rsp->OutputBufferOffset),
+				sizeof(struct smb2_file_all_info),
+				&rsp_iov[1], sizeof(struct smb2_file_all_info),
+				(char *)&tcon->cfid.file_all_info))
+		tcon->cfid.file_all_info_is_valid = true;
+	tcon->cfid.time = jiffies;
+
+
+oshr_exit:
+	mutex_unlock(&tcon->cfid.fid_mutex);
+oshr_free:
+	SMB2_open_free(&rqst[0]);
+	SMB2_query_info_free(&rqst[1]);
+	free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
+	free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
+	if (rc == 0) {
+		*cfid = &tcon->cfid;	
+}
+	return rc;
+}
+
+int open_cached_dir_by_dentry(struct cifs_tcon *tcon,
+			      struct dentry *dentry,
+			      struct cached_fid **cfid)
+{
+	mutex_lock(&tcon->cfid.fid_mutex);
+	if (tcon->cfid.dentry == dentry) {
+		cifs_dbg(FYI, "found a cached root file handle by dentry\n");
+		*cfid = &tcon->cfid;
+		kref_get(&tcon->cfid.refcount);
+		mutex_unlock(&tcon->cfid.fid_mutex);
+		return 0;
+	}
+	mutex_unlock(&tcon->cfid.fid_mutex);
+	return -ENOENT;
+}
+
+static void
+smb2_close_cached_fid(struct kref *ref)
+{
+	struct cached_fid *cfid = container_of(ref, struct cached_fid,
+					       refcount);
+	struct cached_dirent *dirent, *q;
+
+	if (cfid->is_valid) {
+		cifs_dbg(FYI, "clear cached root file handle\n");
+		SMB2_close(0, cfid->tcon, cfid->fid->persistent_fid,
+			   cfid->fid->volatile_fid);
+	}
+
+	/*
+	 * We only check validity above to send SMB2_close,
+	 * but we still need to invalidate these entries
+	 * when this function is called
+	 */
+	cfid->is_valid = false;
+	cfid->file_all_info_is_valid = false;
+	cfid->has_lease = false;
+	if (cfid->dentry) {
+		dput(cfid->dentry);
+		cfid->dentry = NULL;
+	}
+	/*
+	 * Delete all cached dirent names
+	 */
+	mutex_lock(&cfid->dirents.de_mutex);
+	list_for_each_entry_safe(dirent, q, &cfid->dirents.entries, entry) {
+		list_del(&dirent->entry);
+		kfree(dirent->name);
+		kfree(dirent);
+	}
+	cfid->dirents.is_valid = 0;
+	cfid->dirents.is_failed = 0;
+	cfid->dirents.ctx = NULL;
+	cfid->dirents.pos = 0;
+	mutex_unlock(&cfid->dirents.de_mutex);
+
+}
+
+void close_cached_dir(struct cached_fid *cfid)
+{
+	mutex_lock(&cfid->fid_mutex);
+	kref_put(&cfid->refcount, smb2_close_cached_fid);
+	mutex_unlock(&cfid->fid_mutex);
+}
+
+void close_cached_dir_lease_locked(struct cached_fid *cfid)
+{
+	if (cfid->has_lease) {
+		cfid->has_lease = false;
+		kref_put(&cfid->refcount, smb2_close_cached_fid);
+	}
+}
+
+void close_cached_dir_lease(struct cached_fid *cfid)
+{
+	mutex_lock(&cfid->fid_mutex);
+	close_cached_dir_lease_locked(cfid);
+	mutex_unlock(&cfid->fid_mutex);
+}
+
+/*
+ * Called from cifs_kill_sb when we unmount a share
+ */
+void close_all_cached_dirs(struct cifs_sb_info *cifs_sb)
+{
+	struct rb_root *root = &cifs_sb->tlink_tree;
+	struct rb_node *node;
+	struct cached_fid *cfid;
+	struct cifs_tcon *tcon;
+	struct tcon_link *tlink;
+
+	for (node = rb_first(root); node; node = rb_next(node)) {
+		tlink = rb_entry(node, struct tcon_link, tl_rbnode);
+		tcon = tlink_tcon(tlink);
+		if (IS_ERR(tcon))
+			continue;
+		cfid = &tcon->cfid;
+		mutex_lock(&cfid->fid_mutex);
+		if (cfid->dentry) {
+			dput(cfid->dentry);
+			cfid->dentry = NULL;
+		}
+		mutex_unlock(&cfid->fid_mutex);
+	}
+}
+
+/*
+ * Invalidate and close all cached dirs when a TCON has been reset
+ * due to a session loss.
+ */
+void invalidate_all_cached_dirs(struct cifs_tcon *tcon)
+{
+	mutex_lock(&tcon->cfid.fid_mutex);
+	tcon->cfid.is_valid = false;
+	/* cached handle is not valid, so SMB2_CLOSE won't be sent below */
+	close_cached_dir_lease_locked(&tcon->cfid);
+	memset(tcon->cfid.fid, 0, sizeof(struct cifs_fid));
+	mutex_unlock(&tcon->cfid.fid_mutex);
+}
+
+static void
+smb2_cached_lease_break(struct work_struct *work)
+{
+	struct cached_fid *cfid = container_of(work,
+				struct cached_fid, lease_break);
+
+	close_cached_dir_lease(cfid);
+}
+
+int cached_dir_lease_break(struct cifs_tcon *tcon, __u8 lease_key[16])
+{
+	if (tcon->cfid.is_valid &&
+	    !memcmp(lease_key,
+		    tcon->cfid.fid->lease_key,
+		    SMB2_LEASE_KEY_SIZE)) {
+		tcon->cfid.time = 0;
+		INIT_WORK(&tcon->cfid.lease_break,
+			  smb2_cached_lease_break);
+		queue_work(cifsiod_wq,
+			   &tcon->cfid.lease_break);
+		spin_unlock(&cifs_tcp_ses_lock);
+		return true;
+	}
+	return false;
+}
diff --git a/fs/cifs/cached_dir.h b/fs/cifs/cached_dir.h
new file mode 100644
index 000000000000..3731c755eea5
--- /dev/null
+++ b/fs/cifs/cached_dir.h
@@ -0,0 +1,26 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  Functions to handle the cached directory entries
+ *
+ *  Copyright (c) 2022, Ronnie Sahlberg <lsahlber@redhat.com>
+ */
+
+#ifndef _CACHED_DIR_H
+#define _CACHED_DIR_H
+
+
+extern int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
+			   const char *path,
+			   struct cifs_sb_info *cifs_sb,
+			   struct cached_fid **cfid);
+extern int open_cached_dir_by_dentry(struct cifs_tcon *tcon,
+				     struct dentry *dentry,
+				     struct cached_fid **cfid);
+extern void close_cached_dir(struct cached_fid *cfid);
+extern void close_cached_dir_lease(struct cached_fid *cfid);
+extern void close_cached_dir_lease_locked(struct cached_fid *cfid);
+extern void close_all_cached_dirs(struct cifs_sb_info *cifs_sb);
+extern void invalidate_all_cached_dirs(struct cifs_tcon *tcon);
+extern int cached_dir_lease_break(struct cifs_tcon *tcon, __u8 lease_key[16]);
+
+#endif			/* _CACHED_DIR_H */
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index f909d9e9faaa..615fbe2bff3c 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -46,6 +46,7 @@
 #include "netlink.h"
 #endif
 #include "fs_context.h"
+#include "cached_dir.h"
 
 /*
  * DOS dates from 1980/1/1 through 2107/12/31
@@ -264,30 +265,13 @@ cifs_read_super(struct super_block *sb)
 static void cifs_kill_sb(struct super_block *sb)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
-	struct cifs_tcon *tcon;
-	struct cached_fid *cfid;
-	struct rb_root *root = &cifs_sb->tlink_tree;
-	struct rb_node *node;
-	struct tcon_link *tlink;
 
 	/*
 	 * We ned to release all dentries for the cached directories
 	 * before we kill the sb.
 	 */
 	if (cifs_sb->root) {
-		for (node = rb_first(root); node; node = rb_next(node)) {
-			tlink = rb_entry(node, struct tcon_link, tl_rbnode);
-			tcon = tlink_tcon(tlink);
-			if (IS_ERR(tcon))
-				continue;
-			cfid = &tcon->crfid;
-			mutex_lock(&cfid->fid_mutex);
-			if (cfid->dentry) {
-				dput(cfid->dentry);
-				cfid->dentry = NULL;
-			}
-			mutex_unlock(&cfid->fid_mutex);
-		}
+		close_all_cached_dirs(cifs_sb);
 
 		/* finally release root dentry */
 		dput(cifs_sb->root);
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 9b7f409bfc8c..657fabb9067b 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1253,7 +1253,7 @@ struct cifs_tcon {
 	struct fscache_volume *fscache;	/* cookie for share */
 #endif
 	struct list_head pending_opens;	/* list of incomplete opens */
-	struct cached_fid crfid; /* Cached root fid */
+	struct cached_fid cfid; /* Cached root fid */
 	/* BB add field for back pointer to sb struct(s)? */
 #ifdef CONFIG_CIFS_DFS_UPCALL
 	struct list_head ulist; /* cache update list */
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index d59aebefa71c..881bf112d6ae 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -599,7 +599,6 @@ enum securityEnum cifs_select_sectype(struct TCP_Server_Info *,
 struct cifs_aio_ctx *cifs_aio_ctx_alloc(void);
 void cifs_aio_ctx_release(struct kref *refcount);
 int setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw);
-void smb2_cached_lease_break(struct work_struct *work);
 
 int cifs_alloc_hash(const char *name, struct crypto_shash **shash,
 		    struct sdesc **sdesc);
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 9ed21752f2df..78dfadd729fe 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -35,6 +35,7 @@
 #ifdef CONFIG_CIFS_DFS_UPCALL
 #include "dfs_cache.h"
 #endif
+#include "cached_dir.h"
 
 #ifdef CONFIG_CIFS_POSIX
 static struct {
@@ -91,12 +92,7 @@ cifs_mark_open_files_invalid(struct cifs_tcon *tcon)
 	}
 	spin_unlock(&tcon->open_file_lock);
 
-	mutex_lock(&tcon->crfid.fid_mutex);
-	tcon->crfid.is_valid = false;
-	/* cached handle is not valid, so SMB2_CLOSE won't be sent below */
-	close_cached_dir_lease_locked(&tcon->crfid);
-	memset(tcon->crfid.fid, 0, sizeof(struct cifs_fid));
-	mutex_unlock(&tcon->crfid.fid_mutex);
+	invalidate_all_cached_dirs(tcon);
 
 	spin_lock(&cifs_tcp_ses_lock);
 	if (tcon->status == TID_IN_FILES_INVALIDATE)
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 3ad303dd5e5a..7714f47d199b 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -25,6 +25,7 @@
 #include "fscache.h"
 #include "fs_context.h"
 #include "cifs_ioctl.h"
+#include "cached_dir.h"
 
 static void cifs_set_ops(struct inode *inode)
 {
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 16168ebd1a62..fa1a03ddbbe2 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -115,13 +115,13 @@ tconInfoAlloc(void)
 	ret_buf = kzalloc(sizeof(*ret_buf), GFP_KERNEL);
 	if (!ret_buf)
 		return NULL;
-	ret_buf->crfid.fid = kzalloc(sizeof(*ret_buf->crfid.fid), GFP_KERNEL);
-	if (!ret_buf->crfid.fid) {
+	ret_buf->cfid.fid = kzalloc(sizeof(*ret_buf->cfid.fid), GFP_KERNEL);
+	if (!ret_buf->cfid.fid) {
 		kfree(ret_buf);
 		return NULL;
 	}
-	INIT_LIST_HEAD(&ret_buf->crfid.dirents.entries);
-	mutex_init(&ret_buf->crfid.dirents.de_mutex);
+	INIT_LIST_HEAD(&ret_buf->cfid.dirents.entries);
+	mutex_init(&ret_buf->cfid.dirents.de_mutex);
 
 	atomic_inc(&tconInfoAllocCount);
 	ret_buf->status = TID_NEW;
@@ -129,7 +129,7 @@ tconInfoAlloc(void)
 	INIT_LIST_HEAD(&ret_buf->openFileList);
 	INIT_LIST_HEAD(&ret_buf->tcon_list);
 	spin_lock_init(&ret_buf->open_file_lock);
-	mutex_init(&ret_buf->crfid.fid_mutex);
+	mutex_init(&ret_buf->cfid.fid_mutex);
 	spin_lock_init(&ret_buf->stat_lock);
 	atomic_set(&ret_buf->num_local_opens, 0);
 	atomic_set(&ret_buf->num_remote_opens, 0);
@@ -147,7 +147,7 @@ tconInfoFree(struct cifs_tcon *buf_to_free)
 	atomic_dec(&tconInfoAllocCount);
 	kfree(buf_to_free->nativeFileSystem);
 	kfree_sensitive(buf_to_free->password);
-	kfree(buf_to_free->crfid.fid);
+	kfree(buf_to_free->cfid.fid);
 	kfree(buf_to_free);
 }
 
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 384cabdf47ca..a06072ae6c7e 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -21,6 +21,7 @@
 #include "cifsfs.h"
 #include "smb2proto.h"
 #include "fs_context.h"
+#include "cached_dir.h"
 
 /*
  * To be safe - for UCS to UTF-8 with strings loaded with the rare long
diff --git a/fs/cifs/smb2inode.c b/fs/cifs/smb2inode.c
index 8571a459c710..f6f9fc3f2e2d 100644
--- a/fs/cifs/smb2inode.c
+++ b/fs/cifs/smb2inode.c
@@ -23,6 +23,7 @@
 #include "smb2glob.h"
 #include "smb2pdu.h"
 #include "smb2proto.h"
+#include "cached_dir.h"
 
 static void
 free_set_inf_compound(struct smb_rqst *rqst)
@@ -518,9 +519,9 @@ smb2_query_path_info(const unsigned int xid, struct cifs_tcon *tcon,
 		rc = open_cached_dir(xid, tcon, full_path, cifs_sb, &cfid);
 	/* If it is a root and its handle is cached then use it */
 	if (!rc) {
-		if (tcon->crfid.file_all_info_is_valid) {
+		if (tcon->cfid.file_all_info_is_valid) {
 			move_smb2_info_to_cifs(data,
-					       &tcon->crfid.file_all_info);
+					       &tcon->cfid.file_all_info);
 		} else {
 			rc = SMB2_query_info(xid, tcon,
 					     cfid->fid->persistent_fid,
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index db0f27fd373b..d3d9174ddd7c 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -16,6 +16,7 @@
 #include "smb2status.h"
 #include "smb2glob.h"
 #include "nterr.h"
+#include "cached_dir.h"
 
 static int
 check_smb2_hdr(struct smb2_hdr *shdr, __u64 mid)
@@ -639,18 +640,8 @@ smb2_is_valid_lease_break(char *buffer)
 				}
 				spin_unlock(&tcon->open_file_lock);
 
-				if (tcon->crfid.is_valid &&
-				    !memcmp(rsp->LeaseKey,
-					    tcon->crfid.fid->lease_key,
-					    SMB2_LEASE_KEY_SIZE)) {
-					tcon->crfid.time = 0;
-					INIT_WORK(&tcon->crfid.lease_break,
-						  smb2_cached_lease_break);
-					queue_work(cifsiod_wq,
-						   &tcon->crfid.lease_break);
-					spin_unlock(&cifs_tcp_ses_lock);
+				if (cached_dir_lease_break(tcon, rsp->LeaseKey))
 					return true;
-				}
 			}
 		}
 	}
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index aa4c1d403708..01aafedc477e 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -27,6 +27,7 @@
 #include "smbdirect.h"
 #include "fscache.h"
 #include "fs_context.h"
+#include "cached_dir.h"
 
 /* Change credits for different ops and return the total number of credits */
 static int
@@ -701,300 +702,6 @@ SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon)
 	return rc;
 }
 
-static void
-smb2_close_cached_fid(struct kref *ref)
-{
-	struct cached_fid *cfid = container_of(ref, struct cached_fid,
-					       refcount);
-	struct cached_dirent *dirent, *q;
-
-	if (cfid->is_valid) {
-		cifs_dbg(FYI, "clear cached root file handle\n");
-		SMB2_close(0, cfid->tcon, cfid->fid->persistent_fid,
-			   cfid->fid->volatile_fid);
-	}
-
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
-	}
-	cfid->dirents.is_valid = 0;
-	cfid->dirents.is_failed = 0;
-	cfid->dirents.ctx = NULL;
-	cfid->dirents.pos = 0;
-	mutex_unlock(&cfid->dirents.de_mutex);
-
-}
-
-void close_cached_dir(struct cached_fid *cfid)
-{
-	mutex_lock(&cfid->fid_mutex);
-	kref_put(&cfid->refcount, smb2_close_cached_fid);
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
-}
-
-void
-smb2_cached_lease_break(struct work_struct *work)
-{
-	struct cached_fid *cfid = container_of(work,
-				struct cached_fid, lease_break);
-
-	close_cached_dir_lease(cfid);
-}
-
-/*
- * Open the and cache a directory handle.
- * Only supported for the root handle.
- * If error then *cfid is not initialized.
- */
-int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
-		const char *path,
-		struct cifs_sb_info *cifs_sb,
-		struct cached_fid **cfid)
-{
-	struct cifs_ses *ses;
-	struct TCP_Server_Info *server;
-	struct cifs_open_parms oparms;
-	struct smb2_create_rsp *o_rsp = NULL;
-	struct smb2_query_info_rsp *qi_rsp = NULL;
-	int resp_buftype[2];
-	struct smb_rqst rqst[2];
-	struct kvec rsp_iov[2];
-	struct kvec open_iov[SMB2_CREATE_IOV_SIZE];
-	struct kvec qi_iov[1];
-	int rc, flags = 0;
-	__le16 utf16_path = 0; /* Null - since an open of top of share */
-	u8 oplock = SMB2_OPLOCK_LEVEL_II;
-	struct cifs_fid *pfid;
-	struct dentry *dentry;
-
-	if (tcon == NULL || tcon->nohandlecache ||
-	    is_smb1_server(tcon->ses->server))
-		return -ENOTSUPP;
-
-	ses = tcon->ses;
-	server = ses->server;
-
-	if (cifs_sb->root == NULL)
-		return -ENOENT;
-
-	if (strlen(path))
-		return -ENOENT;
-
-	dentry = cifs_sb->root;
-
-	mutex_lock(&tcon->crfid.fid_mutex);
-	if (tcon->crfid.is_valid) {
-		cifs_dbg(FYI, "found a cached root file handle\n");
-		*cfid = &tcon->crfid;
-		kref_get(&tcon->crfid.refcount);
-		mutex_unlock(&tcon->crfid.fid_mutex);
-		return 0;
-	}
-
-	/*
-	 * We do not hold the lock for the open because in case
-	 * SMB2_open needs to reconnect, it will end up calling
-	 * cifs_mark_open_files_invalid() which takes the lock again
-	 * thus causing a deadlock
-	 */
-
-	mutex_unlock(&tcon->crfid.fid_mutex);
-
-	if (smb3_encryption_required(tcon))
-		flags |= CIFS_TRANSFORM_REQ;
-
-	if (!server->ops->new_lease_key)
-		return -EIO;
-
-	pfid = tcon->crfid.fid;
-	server->ops->new_lease_key(pfid);
-
-	memset(rqst, 0, sizeof(rqst));
-	resp_buftype[0] = resp_buftype[1] = CIFS_NO_BUFFER;
-	memset(rsp_iov, 0, sizeof(rsp_iov));
-
-	/* Open */
-	memset(&open_iov, 0, sizeof(open_iov));
-	rqst[0].rq_iov = open_iov;
-	rqst[0].rq_nvec = SMB2_CREATE_IOV_SIZE;
-
-	oparms.tcon = tcon;
-	oparms.create_options = cifs_create_options(cifs_sb, CREATE_NOT_FILE);
-	oparms.desired_access = FILE_READ_ATTRIBUTES;
-	oparms.disposition = FILE_OPEN;
-	oparms.fid = pfid;
-	oparms.reconnect = false;
-
-	rc = SMB2_open_init(tcon, server,
-			    &rqst[0], &oplock, &oparms, &utf16_path);
-	if (rc)
-		goto oshr_free;
-	smb2_set_next_command(tcon, &rqst[0]);
-
-	memset(&qi_iov, 0, sizeof(qi_iov));
-	rqst[1].rq_iov = qi_iov;
-	rqst[1].rq_nvec = 1;
-
-	rc = SMB2_query_info_init(tcon, server,
-				  &rqst[1], COMPOUND_FID,
-				  COMPOUND_FID, FILE_ALL_INFORMATION,
-				  SMB2_O_INFO_FILE, 0,
-				  sizeof(struct smb2_file_all_info) +
-				  PATH_MAX * 2, 0, NULL);
-	if (rc)
-		goto oshr_free;
-
-	smb2_set_related(&rqst[1]);
-
-	rc = compound_send_recv(xid, ses, server,
-				flags, 2, rqst,
-				resp_buftype, rsp_iov);
-	mutex_lock(&tcon->crfid.fid_mutex);
-
-	/*
-	 * Now we need to check again as the cached root might have
-	 * been successfully re-opened from a concurrent process
-	 */
-
-	if (tcon->crfid.is_valid) {
-		/* work was already done */
-
-		/* stash fids for close() later */
-		struct cifs_fid fid = {
-			.persistent_fid = pfid->persistent_fid,
-			.volatile_fid = pfid->volatile_fid,
-		};
-
-		/*
-		 * caller expects this func to set the fid in crfid to valid
-		 * cached root, so increment the refcount.
-		 */
-		kref_get(&tcon->crfid.refcount);
-
-		mutex_unlock(&tcon->crfid.fid_mutex);
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
-	if (rc) {
-		if (rc == -EREMCHG) {
-			tcon->need_reconnect = true;
-			pr_warn_once("server share %s deleted\n",
-				     tcon->treeName);
-		}
-		goto oshr_exit;
-	}
-
-	atomic_inc(&tcon->num_remote_opens);
-
-	o_rsp = (struct smb2_create_rsp *)rsp_iov[0].iov_base;
-	oparms.fid->persistent_fid = o_rsp->PersistentFileId;
-	oparms.fid->volatile_fid = o_rsp->VolatileFileId;
-#ifdef CONFIG_CIFS_DEBUG2
-	oparms.fid->mid = le64_to_cpu(o_rsp->hdr.MessageId);
-#endif /* CIFS_DEBUG2 */
-
-	tcon->crfid.tcon = tcon;
-	tcon->crfid.is_valid = true;
-	tcon->crfid.dentry = dentry;
-	dget(dentry);
-	kref_init(&tcon->crfid.refcount);
-
-	/* BB TBD check to see if oplock level check can be removed below */
-	if (o_rsp->OplockLevel == SMB2_OPLOCK_LEVEL_LEASE) {
-		/*
-		 * See commit 2f94a3125b87. Increment the refcount when we
-		 * get a lease for root, release it if lease break occurs
-		 */
-		kref_get(&tcon->crfid.refcount);
-		tcon->crfid.has_lease = true;
-		smb2_parse_contexts(server, o_rsp,
-				&oparms.fid->epoch,
-				    oparms.fid->lease_key, &oplock,
-				    NULL, NULL);
-	} else
-		goto oshr_exit;
-
-	qi_rsp = (struct smb2_query_info_rsp *)rsp_iov[1].iov_base;
-	if (le32_to_cpu(qi_rsp->OutputBufferLength) < sizeof(struct smb2_file_all_info))
-		goto oshr_exit;
-	if (!smb2_validate_and_copy_iov(
-				le16_to_cpu(qi_rsp->OutputBufferOffset),
-				sizeof(struct smb2_file_all_info),
-				&rsp_iov[1], sizeof(struct smb2_file_all_info),
-				(char *)&tcon->crfid.file_all_info))
-		tcon->crfid.file_all_info_is_valid = true;
-	tcon->crfid.time = jiffies;
-
-
-oshr_exit:
-	mutex_unlock(&tcon->crfid.fid_mutex);
-oshr_free:
-	SMB2_open_free(&rqst[0]);
-	SMB2_query_info_free(&rqst[1]);
-	free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
-	free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
-	if (rc == 0)
-		*cfid = &tcon->crfid;
-	return rc;
-}
-
-int open_cached_dir_by_dentry(struct cifs_tcon *tcon,
-			      struct dentry *dentry,
-			      struct cached_fid **cfid)
-{
-	mutex_lock(&tcon->crfid.fid_mutex);
-	if (tcon->crfid.dentry == dentry) {
-		cifs_dbg(FYI, "found a cached root file handle by dentry\n");
-		*cfid = &tcon->crfid;
-		kref_get(&tcon->crfid.refcount);
-		mutex_unlock(&tcon->crfid.fid_mutex);
-		return 0;
-	}
-	mutex_unlock(&tcon->crfid.fid_mutex);
-	return -ENOENT;
-}
-
 static void
 smb3_qfs_tcon(const unsigned int xid, struct cifs_tcon *tcon,
 	      struct cifs_sb_info *cifs_sb)
@@ -1077,7 +784,7 @@ smb2_is_path_accessible(const unsigned int xid, struct cifs_tcon *tcon,
 	struct cifs_open_parms oparms;
 	struct cifs_fid fid;
 
-	if ((*full_path == 0) && tcon->crfid.is_valid)
+	if ((*full_path == 0) && tcon->cfid.is_valid)
 		return 0;
 
 	utf16_path = cifs_convert_path_to_utf16(full_path, cifs_sb);
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 295ee8b88055..9ee1b6225619 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -39,6 +39,7 @@
 #ifdef CONFIG_CIFS_DFS_UPCALL
 #include "dfs_cache.h"
 #endif
+#include "cached_dir.h"
 
 /*
  *  The following table defines the expected "StructureSize" of SMB2 requests
@@ -1978,7 +1979,7 @@ SMB2_tdis(const unsigned int xid, struct cifs_tcon *tcon)
 	}
 	spin_unlock(&ses->chan_lock);
 
-	close_cached_dir_lease(&tcon->crfid);
+	close_cached_dir_lease(&tcon->cfid);
 
 	rc = smb2_plain_req_init(SMB2_TREE_DISCONNECT, tcon, ses->server,
 				 (void **) &req,
diff --git a/fs/cifs/smb2proto.h b/fs/cifs/smb2proto.h
index a69f1eed1cfe..51c5bf4a338a 100644
--- a/fs/cifs/smb2proto.h
+++ b/fs/cifs/smb2proto.h
@@ -54,16 +54,6 @@ extern bool smb2_is_valid_oplock_break(char *buffer,
 extern int smb3_handle_read_data(struct TCP_Server_Info *server,
 				 struct mid_q_entry *mid);
 
-extern int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
-			   const char *path,
-			   struct cifs_sb_info *cifs_sb,
-			   struct cached_fid **cfid);
-extern int open_cached_dir_by_dentry(struct cifs_tcon *tcon,
-				     struct dentry *dentry,
-				     struct cached_fid **cfid);
-extern void close_cached_dir(struct cached_fid *cfid);
-extern void close_cached_dir_lease(struct cached_fid *cfid);
-extern void close_cached_dir_lease_locked(struct cached_fid *cfid);
 extern void move_smb2_info_to_cifs(FILE_ALL_INFO *dst,
 				   struct smb2_file_all_info *src);
 extern int smb2_query_reparse_tag(const unsigned int xid, struct cifs_tcon *tcon,
-- 
2.35.3

