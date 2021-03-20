Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 33CEA342A7E
	for <lists+linux-cifs@lfdr.de>; Sat, 20 Mar 2021 05:36:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229893AbhCTEfp (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 20 Mar 2021 00:35:45 -0400
Received: from zeniv-ca.linux.org.uk ([142.44.231.140]:58360 "EHLO
        zeniv-ca.linux.org.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229772AbhCTEfT (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 20 Mar 2021 00:35:19 -0400
Received: from viro by zeniv-ca.linux.org.uk with local (Exim 4.94 #2 (Red Hat Linux))
        id 1lNTIO-007ZDO-4h; Sat, 20 Mar 2021 04:33:04 +0000
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     linux-cifs@vger.kernel.org
Cc:     Steve French <sfrench@samba.org>, linux-fsdevel@vger.kernel.org
Subject: [PATCH 1/7] cifs: don't cargo-cult strndup()
Date:   Sat, 20 Mar 2021 04:32:58 +0000
Message-Id: <20210320043304.1803623-1-viro@zeniv.linux.org.uk>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <YFV6iexd6YQTybPr@zeniv-ca.linux.org.uk>
References: <YFV6iexd6YQTybPr@zeniv-ca.linux.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: Al Viro <viro@ftp.linux.org.uk>
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

strndup(s, strlen(s)) is a highly unidiomatic way to spell strdup(s);
it's *NOT* safer in any way, since strlen() is just as sensitive to
NUL-termination as strdup() is.

strndup() is for situations when you need a copy of a known-sized
substring, not a magic security juju to drive the bad spirits away.

Signed-off-by: Al Viro <viro@zeniv.linux.org.uk>
---
 fs/cifs/cifs_dfs_ref.c |  2 +-
 fs/cifs/connect.c      |  9 +++------
 fs/cifs/dfs_cache.c    | 18 +++++++++---------
 fs/cifs/fs_context.c   |  2 +-
 fs/cifs/misc.c         |  2 +-
 fs/cifs/smb1ops.c      |  4 +---
 fs/cifs/unc.c          |  4 +---
 7 files changed, 17 insertions(+), 24 deletions(-)

diff --git a/fs/cifs/cifs_dfs_ref.c b/fs/cifs/cifs_dfs_ref.c
index 6b1ce4efb591..ecee2864972d 100644
--- a/fs/cifs/cifs_dfs_ref.c
+++ b/fs/cifs/cifs_dfs_ref.c
@@ -270,7 +270,7 @@ static struct vfsmount *cifs_dfs_do_mount(struct dentry *mntpt,
 	char *mountdata;
 	char *devname;
 
-	devname = kstrndup(fullpath, strlen(fullpath), GFP_KERNEL);
+	devname = kstrdup(fullpath, GFP_KERNEL);
 	if (!devname)
 		return ERR_PTR(-ENOMEM);
 
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 112692300fb6..6d77b945218b 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -1770,9 +1770,7 @@ cifs_set_cifscreds(struct smb3_fs_context *ctx, struct cifs_ses *ses)
 	 * for the request.
 	 */
 	if (is_domain && ses->domainName) {
-		ctx->domainname = kstrndup(ses->domainName,
-					   strlen(ses->domainName),
-					   GFP_KERNEL);
+		ctx->domainname = kstrdup(ses->domainName, GFP_KERNEL);
 		if (!ctx->domainname) {
 			cifs_dbg(FYI, "Unable to allocate %zd bytes for domain\n",
 				 len);
@@ -3411,8 +3409,7 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 			goto error;
 	}
 	/* Save mount options */
-	mntdata = kstrndup(cifs_sb->ctx->mount_options,
-			   strlen(cifs_sb->ctx->mount_options), GFP_KERNEL);
+	mntdata = kstrdup(cifs_sb->ctx->mount_options, GFP_KERNEL);
 	if (!mntdata) {
 		rc = -ENOMEM;
 		goto error;
@@ -3485,7 +3482,7 @@ int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx)
 	 * links, the prefix path is included in both and may be changed during reconnect.  See
 	 * cifs_tree_connect().
 	 */
-	cifs_sb->origin_fullpath = kstrndup(full_path, strlen(full_path), GFP_KERNEL);
+	cifs_sb->origin_fullpath = kstrdup(full_path, GFP_KERNEL);
 	if (!cifs_sb->origin_fullpath) {
 		rc = -ENOMEM;
 		goto error;
diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 098b4bc8da59..e4617ccf0a23 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -89,7 +89,7 @@ static int get_normalized_path(const char *path, char **npath)
 	if (*path == '\\') {
 		*npath = (char *)path;
 	} else {
-		*npath = kstrndup(path, strlen(path), GFP_KERNEL);
+		*npath = kstrdup(path, GFP_KERNEL);
 		if (!*npath)
 			return -ENOMEM;
 		convert_delimiter(*npath, '\\');
@@ -358,7 +358,7 @@ static struct cache_dfs_tgt *alloc_target(const char *name, int path_consumed)
 	t = kmalloc(sizeof(*t), GFP_ATOMIC);
 	if (!t)
 		return ERR_PTR(-ENOMEM);
-	t->name = kstrndup(name, strlen(name), GFP_ATOMIC);
+	t->name = kstrdup(name, GFP_ATOMIC);
 	if (!t->name) {
 		kfree(t);
 		return ERR_PTR(-ENOMEM);
@@ -419,7 +419,7 @@ static struct cache_entry *alloc_cache_entry(const char *path,
 	if (!ce)
 		return ERR_PTR(-ENOMEM);
 
-	ce->path = kstrndup(path, strlen(path), GFP_KERNEL);
+	ce->path = kstrdup(path, GFP_KERNEL);
 	if (!ce->path) {
 		kmem_cache_free(cache_slab, ce);
 		return ERR_PTR(-ENOMEM);
@@ -531,7 +531,7 @@ static struct cache_entry *lookup_cache_entry(const char *path, unsigned int *ha
 	char *s, *e;
 	char sep;
 
-	npath = kstrndup(path, strlen(path), GFP_KERNEL);
+	npath = kstrdup(path, GFP_KERNEL);
 	if (!npath)
 		return ERR_PTR(-ENOMEM);
 
@@ -641,7 +641,7 @@ static int __update_cache_entry(const char *path,
 
 	if (ce->tgthint) {
 		s = ce->tgthint->name;
-		th = kstrndup(s, strlen(s), GFP_ATOMIC);
+		th = kstrdup(s, GFP_ATOMIC);
 		if (!th)
 			return -ENOMEM;
 	}
@@ -786,11 +786,11 @@ static int setup_referral(const char *path, struct cache_entry *ce,
 
 	memset(ref, 0, sizeof(*ref));
 
-	ref->path_name = kstrndup(path, strlen(path), GFP_ATOMIC);
+	ref->path_name = kstrdup(path, GFP_ATOMIC);
 	if (!ref->path_name)
 		return -ENOMEM;
 
-	ref->node_name = kstrndup(target, strlen(target), GFP_ATOMIC);
+	ref->node_name = kstrdup(target, GFP_ATOMIC);
 	if (!ref->node_name) {
 		rc = -ENOMEM;
 		goto err_free_path;
@@ -828,7 +828,7 @@ static int get_targets(struct cache_entry *ce, struct dfs_cache_tgt_list *tl)
 			goto err_free_it;
 		}
 
-		it->it_name = kstrndup(t->name, strlen(t->name), GFP_ATOMIC);
+		it->it_name = kstrdup(t->name, GFP_ATOMIC);
 		if (!it->it_name) {
 			kfree(it);
 			rc = -ENOMEM;
@@ -1166,7 +1166,7 @@ int dfs_cache_add_vol(char *mntdata, struct smb3_fs_context *ctx, const char *fu
 	if (!vi)
 		return -ENOMEM;
 
-	vi->fullpath = kstrndup(fullpath, strlen(fullpath), GFP_KERNEL);
+	vi->fullpath = kstrdup(fullpath, GFP_KERNEL);
 	if (!vi->fullpath) {
 		rc = -ENOMEM;
 		goto err_free_vi;
diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 892f51a21278..472b543adc45 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -430,7 +430,7 @@ int smb3_parse_opt(const char *options, const char *key, char **val)
 			if (nval == p)
 				continue;
 			*nval++ = 0;
-			*val = kstrndup(nval, strlen(nval), GFP_KERNEL);
+			*val = kstrdup(nval, GFP_KERNEL);
 			rc = !*val ? -ENOMEM : 0;
 			goto out;
 		}
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index 82e176720ca6..c15a90e422be 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -1180,7 +1180,7 @@ int update_super_prepath(struct cifs_tcon *tcon, char *prefix)
 	kfree(cifs_sb->prepath);
 
 	if (prefix && *prefix) {
-		cifs_sb->prepath = kstrndup(prefix, strlen(prefix), GFP_ATOMIC);
+		cifs_sb->prepath = kstrdup(prefix, GFP_ATOMIC);
 		if (!cifs_sb->prepath) {
 			rc = -ENOMEM;
 			goto out;
diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
index e31b939e628c..85fa254c7a6b 100644
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -926,9 +926,7 @@ cifs_unix_dfs_readlink(const unsigned int xid, struct cifs_tcon *tcon,
 			  0);
 
 	if (!rc) {
-		*symlinkinfo = kstrndup(referral.node_name,
-					strlen(referral.node_name),
-					GFP_KERNEL);
+		*symlinkinfo = kstrdup(referral.node_name, GFP_KERNEL);
 		free_dfs_info_param(&referral);
 		if (!*symlinkinfo)
 			rc = -ENOMEM;
diff --git a/fs/cifs/unc.c b/fs/cifs/unc.c
index 394aa00cea40..f6fc5e343ea4 100644
--- a/fs/cifs/unc.c
+++ b/fs/cifs/unc.c
@@ -50,7 +50,6 @@ char *extract_sharename(const char *unc)
 {
 	const char *src;
 	char *delim, *dst;
-	int len;
 
 	/* skip double chars at the beginning */
 	src = unc + 2;
@@ -60,10 +59,9 @@ char *extract_sharename(const char *unc)
 	if (!delim)
 		return ERR_PTR(-EINVAL);
 	delim++;
-	len = strlen(delim);
 
 	/* caller has to free the memory */
-	dst = kstrndup(delim, len, GFP_KERNEL);
+	dst = kstrdup(delim, GFP_KERNEL);
 	if (!dst)
 		return ERR_PTR(-ENOMEM);
 
-- 
2.11.0

