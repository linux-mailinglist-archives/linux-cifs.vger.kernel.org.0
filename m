Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6675B58D1ED
	for <lists+linux-cifs@lfdr.de>; Tue,  9 Aug 2022 04:12:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229674AbiHICMZ (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 8 Aug 2022 22:12:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbiHICMY (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 8 Aug 2022 22:12:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 483A2186F5
        for <linux-cifs@vger.kernel.org>; Mon,  8 Aug 2022 19:12:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660011141;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=NQ9BJ8EoZd8LprfXCrSZNvOZ/gbqrpMhQFq6Vm2fCd4=;
        b=dYtuXBEevCkZODqs8qbTvLkCRngFq6lOTNR5yt9Y4laOwkqBG7a6EX2qkxZrO3SoJ1ladq
        UhsgF/UWdHstvWKI6582UuRqpp34g0QGkv74LgX9t/cy0espfySHO1huwnpgkgZV3I/K6+
        ujJfxZRruFT4Yw7ENao+MWhybjsVhiM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-587-FyRbd0EsPHeXXcV58kUAdQ-1; Mon, 08 Aug 2022 22:12:18 -0400
X-MC-Unique: FyRbd0EsPHeXXcV58kUAdQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com [10.11.54.5])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 087CA804196;
        Tue,  9 Aug 2022 02:12:18 +0000 (UTC)
Received: from localhost.localdomain (vpn2-52-16.bne.redhat.com [10.64.52.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B9BB9459C;
        Tue,  9 Aug 2022 02:12:16 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: [PATCH 4/9] cifs: Make tcon contain a wrapper structure cached_fids instead of cached_fid
Date:   Tue,  9 Aug 2022 12:11:51 +1000
Message-Id: <20220809021156.3086869-5-lsahlber@redhat.com>
In-Reply-To: <20220809021156.3086869-1-lsahlber@redhat.com>
References: <20220809021156.3086869-1-lsahlber@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.11.54.5
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

This wrapper structure will later be expanded to contain a list of
fids that are cached and not just the root fid.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/cached_dir.c | 50 ++++++++++++++++++++++++--------------------
 fs/cifs/cached_dir.h |  8 +++++--
 fs/cifs/cifsglob.h   |  2 +-
 fs/cifs/misc.c       |  6 +++---
 fs/cifs/smb2ops.c    |  2 +-
 5 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/fs/cifs/cached_dir.c b/fs/cifs/cached_dir.c
index 7ca085299890..604ac444ad25 100644
--- a/fs/cifs/cached_dir.c
+++ b/fs/cifs/cached_dir.c
@@ -52,7 +52,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 
 	dentry = cifs_sb->root;
 
-	cfid = tcon->cfid;
+	cfid = &tcon->cfids->cfid;
 	mutex_lock(&cfid->fid_mutex);
 	if (cfid->is_valid) {
 		cifs_dbg(FYI, "found a cached root file handle\n");
@@ -224,7 +224,7 @@ int open_cached_dir_by_dentry(struct cifs_tcon *tcon,
 {
 	struct cached_fid *cfid;
 
-	cfid = tcon->cfid;
+	cfid = &tcon->cfids->cfid;
 
 	mutex_lock(&cfid->fid_mutex);
 	if (cfid->dentry == dentry) {
@@ -318,7 +318,7 @@ void close_all_cached_dirs(struct cifs_sb_info *cifs_sb)
 		tcon = tlink_tcon(tlink);
 		if (IS_ERR(tcon))
 			continue;
-		cfid = tcon->cfid;
+		cfid = &tcon->cfids->cfid;
 		mutex_lock(&cfid->fid_mutex);
 		if (cfid->dentry) {
 			dput(cfid->dentry);
@@ -334,12 +334,14 @@ void close_all_cached_dirs(struct cifs_sb_info *cifs_sb)
  */
 void invalidate_all_cached_dirs(struct cifs_tcon *tcon)
 {
-	mutex_lock(&tcon->cfid->fid_mutex);
-	tcon->cfid->is_valid = false;
+	struct cached_fid *cfid = &tcon->cfids->cfid;
+
+	mutex_lock(&cfid->fid_mutex);
+	cfid->is_valid = false;
 	/* cached handle is not valid, so SMB2_CLOSE won't be sent below */
-	close_cached_dir_lease_locked(tcon->cfid);
-	memset(&tcon->cfid->fid, 0, sizeof(struct cifs_fid));
-	mutex_unlock(&tcon->cfid->fid_mutex);
+	close_cached_dir_lease_locked(cfid);
+	memset(&cfid->fid, 0, sizeof(struct cifs_fid));
+	mutex_unlock(&cfid->fid_mutex);
 }
 
 static void
@@ -353,35 +355,37 @@ smb2_cached_lease_break(struct work_struct *work)
 
 int cached_dir_lease_break(struct cifs_tcon *tcon, __u8 lease_key[16])
 {
-	if (tcon->cfid->is_valid &&
+	struct cached_fid *cfid = &tcon->cfids->cfid;
+
+	if (cfid->is_valid &&
 	    !memcmp(lease_key,
-		    tcon->cfid->fid.lease_key,
+		    cfid->fid.lease_key,
 		    SMB2_LEASE_KEY_SIZE)) {
-		tcon->cfid->time = 0;
-		INIT_WORK(&tcon->cfid->lease_break,
+		cfid->time = 0;
+		INIT_WORK(&cfid->lease_break,
 			  smb2_cached_lease_break);
 		queue_work(cifsiod_wq,
-			   &tcon->cfid->lease_break);
+			   &cfid->lease_break);
 		spin_unlock(&cifs_tcp_ses_lock);
 		return true;
 	}
 	return false;
 }
 
-struct cached_fid *init_cached_dir(void)
+struct cached_fids *init_cached_dirs(void)
 {
-	struct cached_fid *cfid;
+	struct cached_fids *cfids;
 
-	cfid = kzalloc(sizeof(*cfid), GFP_KERNEL);
-	if (!cfid)
+	cfids = kzalloc(sizeof(*cfids), GFP_KERNEL);
+	if (!cfids)
 		return NULL;
-	INIT_LIST_HEAD(&cfid->dirents.entries);
-	mutex_init(&cfid->dirents.de_mutex);
-	mutex_init(&cfid->fid_mutex);
-	return cfid;
+	INIT_LIST_HEAD(&cfids->cfid.dirents.entries);
+	mutex_init(&cfids->cfid.dirents.de_mutex);
+	mutex_init(&cfids->cfid.fid_mutex);
+	return cfids;
 }
 
-void free_cached_dir(struct cifs_tcon *tcon)
+void free_cached_dirs(struct cached_fids *cfids)
 {
-	kfree(tcon->cfid);
+	kfree(cfids);
 }
diff --git a/fs/cifs/cached_dir.h b/fs/cifs/cached_dir.h
index b44edfbd8e1a..4ea30a5ba4e7 100644
--- a/fs/cifs/cached_dir.h
+++ b/fs/cifs/cached_dir.h
@@ -45,8 +45,12 @@ struct cached_fid {
 	struct cached_dirents dirents;
 };
 
-extern struct cached_fid *init_cached_dir(void);
-extern void free_cached_dir(struct cifs_tcon *tcon);
+struct cached_fids {
+	struct cached_fid cfid;
+};
+
+extern struct cached_fids *init_cached_dirs(void);
+extern void free_cached_dirs(struct cached_fids *cfids);
 extern int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 			   const char *path,
 			   struct cifs_sb_info *cifs_sb,
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index d3b233a2737d..edee34011ffc 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1217,7 +1217,7 @@ struct cifs_tcon {
 	struct fscache_volume *fscache;	/* cookie for share */
 #endif
 	struct list_head pending_opens;	/* list of incomplete opens */
-	struct cached_fid *cfid; /* Cached root fid */
+	struct cached_fids *cfids; /* Cached root fid */
 	/* BB add field for back pointer to sb struct(s)? */
 #ifdef CONFIG_CIFS_DFS_UPCALL
 	struct list_head ulist; /* cache update list */
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 4e2e3b557591..d193c6242366 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -116,8 +116,8 @@ tconInfoAlloc(void)
 	ret_buf = kzalloc(sizeof(*ret_buf), GFP_KERNEL);
 	if (!ret_buf)
 		return NULL;
-	ret_buf->cfid = init_cached_dir();
-	if (!ret_buf->cfid) {
+	ret_buf->cfids = init_cached_dirs();
+	if (!ret_buf->cfids) {
 		kfree(ret_buf);
 		return NULL;
 	}
@@ -142,7 +142,7 @@ tconInfoFree(struct cifs_tcon *tcon)
 		cifs_dbg(FYI, "Null buffer passed to tconInfoFree\n");
 		return;
 	}
-	free_cached_dir(tcon);
+	free_cached_dirs(tcon->cfids);
 	atomic_dec(&tconInfoAllocCount);
 	kfree(tcon->nativeFileSystem);
 	kfree_sensitive(tcon->password);
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index e50b6ef309e1..780ada4d8f6e 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -784,7 +784,7 @@ smb2_is_path_accessible(const unsigned int xid, struct cifs_tcon *tcon,
 	struct cifs_open_parms oparms;
 	struct cifs_fid fid;
 
-	if ((*full_path == 0) && tcon->cfid->is_valid)
+	if ((*full_path == 0) && tcon->cfids->cfid.is_valid)
 		return 0;
 
 	utf16_path = cifs_convert_path_to_utf16(full_path, cifs_sb);
-- 
2.35.3

