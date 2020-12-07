Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6DAB82D1E7D
	for <lists+linux-cifs@lfdr.de>; Tue,  8 Dec 2020 00:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726746AbgLGXkw (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 7 Dec 2020 18:40:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([63.128.21.124]:24427 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726076AbgLGXkv (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 7 Dec 2020 18:40:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1607384357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=1EelHR1pldhdUhJm5qB3pMVamNDCFEnhRTa2+Qp23cw=;
        b=c2cym10h4+4ZSAyil8gxNUyLpuT066whsMdQFVs39FWPnuC9pspHPEX7DLozrz3naKwsb1
        3XWb8WDTKv29uSmwSg9gV3h3t6nGCBHUlu+gaxsAU/dB+/x/pa+wqntL6pCAO8bCsJrqZF
        fuq1pk0AgVAg4V4N3MiMQQmU7vupgsE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-270-T94J1GvFMm-xBTBWGxQnuA-1; Mon, 07 Dec 2020 18:39:15 -0500
X-MC-Unique: T94J1GvFMm-xBTBWGxQnuA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 22C86192D799;
        Mon,  7 Dec 2020 23:39:14 +0000 (UTC)
Received: from test1103.test.redhat.com (vpn2-54-107.bne.redhat.com [10.64.54.107])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0FCE860636;
        Mon,  7 Dec 2020 23:39:11 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: [PATCH 05/21] cifs: switch to new mount api
Date:   Tue,  8 Dec 2020 09:36:30 +1000
Message-Id: <20201207233646.29823-5-lsahlber@redhat.com>
In-Reply-To: <20201207233646.29823-1-lsahlber@redhat.com>
References: <20201207233646.29823-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/cifs_dfs_ref.c |    4 +
 fs/cifs/cifsencrypt.c  |    5 +
 fs/cifs/cifsfs.c       |   54 +--
 fs/cifs/cifsfs.h       |    4 +
 fs/cifs/cifsproto.h    |    5 +-
 fs/cifs/connect.c      | 1154 +-----------------------------------------------
 fs/cifs/dfs_cache.c    |    8 +-
 fs/cifs/fs_context.c   | 1067 ++++++++++++++++++++++++++++++++++++++++----
 fs/cifs/fs_context.h   |   75 ++--
 fs/cifs/sess.c         |    2 +-
 10 files changed, 1095 insertions(+), 1283 deletions(-)

diff --git a/fs/cifs/cifs_dfs_ref.c b/fs/cifs/cifs_dfs_ref.c
index cc3ada12848d..4b0b9cfe2ab1 100644
--- a/fs/cifs/cifs_dfs_ref.c
+++ b/fs/cifs/cifs_dfs_ref.c
@@ -275,6 +275,10 @@ static struct vfsmount *cifs_dfs_do_mount(struct dentry *mntpt,
 
 	convert_delimiter(devname, '/');
 
+	/* TODO: change to call fs_context_for_mount(), fill in context directly, call fc_mount */
+
+	/* See afs_mntpt_do_automount in fs/afs/mntpt.c for an example */
+
 	/* strip first '\' from fullpath */
 	mountdata = cifs_compose_mount_options(cifs_sb->mountdata,
 					       fullpath + 1, NULL, NULL);
diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
index 9daa256f69d4..85734de318f6 100644
--- a/fs/cifs/cifsencrypt.c
+++ b/fs/cifs/cifsencrypt.c
@@ -661,6 +661,11 @@ setup_ntlmv2_rsp(struct cifs_ses *ses, const struct nls_table *nls_cp)
 	unsigned char *tiblob = NULL; /* target info blob */
 	__le64 rsp_timestamp;
 
+	if (nls_cp == NULL) {
+		cifs_dbg(VFS, "setup_ntlmv2_rsp called with nls_cp==NULL\n");
+		return -EINVAL;
+	}
+
 	if (ses->server->negflavor == CIFS_NEGFLAVOR_EXTENDED) {
 		if (!ses->domainName) {
 			if (ses->domainAuto) {
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 9fb85fcff6ae..907c82428c42 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -682,13 +682,6 @@ static int cifs_show_stats(struct seq_file *s, struct dentry *root)
 }
 #endif
 
-static int cifs_remount(struct super_block *sb, int *flags, char *data)
-{
-	sync_filesystem(sb);
-	*flags |= SB_NODIRATIME;
-	return 0;
-}
-
 static int cifs_drop_inode(struct inode *inode)
 {
 	struct cifs_sb_info *cifs_sb = CIFS_SB(inode->i_sb);
@@ -710,7 +703,6 @@ static const struct super_operations cifs_super_ops = {
 	as opens */
 	.show_options = cifs_show_options,
 	.umount_begin   = cifs_umount_begin,
-	.remount_fs = cifs_remount,
 #ifdef CONFIG_CIFS_STATS2
 	.show_stats = cifs_show_stats,
 #endif
@@ -778,9 +770,9 @@ static int cifs_set_super(struct super_block *sb, void *data)
 	return set_anon_super(sb, NULL);
 }
 
-static struct dentry *
+struct dentry *
 cifs_smb3_do_mount(struct file_system_type *fs_type,
-	      int flags, const char *dev_name, void *data, bool is_smb3)
+	      int flags, struct smb3_fs_context *old_ctx)
 {
 	int rc;
 	struct super_block *sb;
@@ -794,13 +786,24 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 	 *	If CIFS_DEBUG && cifs_FYI
 	 */
 	if (cifsFYI)
-		cifs_dbg(FYI, "Devname: %s flags: %d\n", dev_name, flags);
+		cifs_dbg(FYI, "Devname: %s flags: %d\n", old_ctx->UNC, flags);
 	else
-		cifs_info("Attempting to mount %s\n", dev_name);
+		cifs_info("Attempting to mount %s\n", old_ctx->UNC);
+
+	ctx = kzalloc(sizeof(struct smb3_fs_context), GFP_KERNEL);
+	if (!ctx)
+		return ERR_PTR(-ENOMEM);
+	rc = smb3_fs_context_dup(ctx, old_ctx);
+	if (rc) {
+		root = ERR_PTR(rc);
+		goto out;
+	}
 
-	ctx = cifs_get_volume_info((char *)data, dev_name, is_smb3);
-	if (IS_ERR(ctx))
-		return ERR_CAST(ctx);
+	rc = cifs_setup_volume_info(ctx);
+	if (rc) {
+		root = ERR_PTR(rc);
+		goto out;
+	}
 
 	cifs_sb = kzalloc(sizeof(struct cifs_sb_info), GFP_KERNEL);
 	if (cifs_sb == NULL) {
@@ -808,7 +811,7 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 		goto out_nls;
 	}
 
-	cifs_sb->mountdata = kstrndup(data, PAGE_SIZE, GFP_KERNEL);
+	cifs_sb->mountdata = kstrndup(ctx->mount_options, PAGE_SIZE, GFP_KERNEL);
 	if (cifs_sb->mountdata == NULL) {
 		root = ERR_PTR(-ENOMEM);
 		goto out_free;
@@ -878,19 +881,6 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 	goto out;
 }
 
-static struct dentry *
-smb3_do_mount(struct file_system_type *fs_type,
-	      int flags, const char *dev_name, void *data)
-{
-	return cifs_smb3_do_mount(fs_type, flags, dev_name, data, true);
-}
-
-static struct dentry *
-cifs_do_mount(struct file_system_type *fs_type,
-	      int flags, const char *dev_name, void *data)
-{
-	return cifs_smb3_do_mount(fs_type, flags, dev_name, data, false);
-}
 
 static ssize_t
 cifs_loose_read_iter(struct kiocb *iocb, struct iov_iter *iter)
@@ -1027,7 +1017,8 @@ cifs_setlease(struct file *file, long arg, struct file_lock **lease, void **priv
 struct file_system_type cifs_fs_type = {
 	.owner = THIS_MODULE,
 	.name = "cifs",
-	.mount = cifs_do_mount,
+	.init_fs_context = smb3_init_fs_context,
+	.parameters = smb3_fs_parameters,
 	.kill_sb = cifs_kill_sb,
 	.fs_flags = FS_RENAME_DOES_D_MOVE,
 };
@@ -1036,7 +1027,8 @@ MODULE_ALIAS_FS("cifs");
 static struct file_system_type smb3_fs_type = {
 	.owner = THIS_MODULE,
 	.name = "smb3",
-	.mount = smb3_do_mount,
+	.init_fs_context = smb3_init_fs_context,
+	.parameters = smb3_fs_parameters,
 	.kill_sb = cifs_kill_sb,
 	.fs_flags = FS_RENAME_DOES_D_MOVE,
 };
diff --git a/fs/cifs/cifsfs.h b/fs/cifs/cifsfs.h
index 99b3180c613a..624449b47cc4 100644
--- a/fs/cifs/cifsfs.h
+++ b/fs/cifs/cifsfs.h
@@ -152,6 +152,10 @@ extern long cifs_ioctl(struct file *filep, unsigned int cmd, unsigned long arg);
 extern void cifs_setsize(struct inode *inode, loff_t offset);
 extern int cifs_truncate_page(struct address_space *mapping, loff_t from);
 
+struct smb3_fs_context;
+extern struct dentry *cifs_smb3_do_mount(struct file_system_type *fs_type,
+					 int flags, struct smb3_fs_context *ctx);
+
 #ifdef CONFIG_CIFS_NFSD_EXPORT
 extern const struct export_operations cifs_export_ops;
 #endif /* CONFIG_CIFS_NFSD_EXPORT */
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index aa66a6b9aaf5..49a122978772 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -239,8 +239,6 @@ extern int cifs_setup_cifs_sb(struct smb3_fs_context *ctx,
 			       struct cifs_sb_info *cifs_sb);
 extern int cifs_match_super(struct super_block *, void *);
 extern void cifs_cleanup_volume_info(struct smb3_fs_context *ctx);
-extern struct smb3_fs_context *cifs_get_volume_info(char *mount_data,
-					    const char *devname, bool is_smb3);
 extern int cifs_mount(struct cifs_sb_info *cifs_sb, struct smb3_fs_context *ctx);
 extern void cifs_umount(struct cifs_sb_info *);
 extern void cifs_mark_open_files_invalid(struct cifs_tcon *tcon);
@@ -554,8 +552,7 @@ extern int SMBencrypt(unsigned char *passwd, const unsigned char *c8,
 			unsigned char *p24);
 
 extern int
-cifs_setup_volume_info(struct smb3_fs_context *ctx, char *mount_data,
-		       const char *devname, bool is_smb3);
+cifs_setup_volume_info(struct smb3_fs_context *ctx);
 extern void
 cifs_cleanup_volume_info_contents(struct smb3_fs_context *ctx);
 
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index c447ace656ed..081e61a212cd 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -73,156 +73,6 @@ extern bool disable_legacy_dialects;
 /* Drop the connection to not overload the server */
 #define NUM_STATUS_IO_TIMEOUT   5
 
-static const match_table_t cifs_mount_option_tokens = {
-
-	{ Opt_user_xattr, "user_xattr" },
-	{ Opt_nouser_xattr, "nouser_xattr" },
-	{ Opt_forceuid, "forceuid" },
-	{ Opt_noforceuid, "noforceuid" },
-	{ Opt_forcegid, "forcegid" },
-	{ Opt_noforcegid, "noforcegid" },
-	{ Opt_noblocksend, "noblocksend" },
-	{ Opt_noautotune, "noautotune" },
-	{ Opt_nolease, "nolease" },
-	{ Opt_hard, "hard" },
-	{ Opt_soft, "soft" },
-	{ Opt_perm, "perm" },
-	{ Opt_noperm, "noperm" },
-	{ Opt_nodelete, "nodelete" },
-	{ Opt_mapchars, "mapchars" }, /* SFU style */
-	{ Opt_nomapchars, "nomapchars" },
-	{ Opt_mapposix, "mapposix" }, /* SFM style */
-	{ Opt_nomapposix, "nomapposix" },
-	{ Opt_sfu, "sfu" },
-	{ Opt_nosfu, "nosfu" },
-	{ Opt_nodfs, "nodfs" },
-	{ Opt_posixpaths, "posixpaths" },
-	{ Opt_noposixpaths, "noposixpaths" },
-	{ Opt_nounix, "nounix" },
-	{ Opt_nounix, "nolinux" },
-	{ Opt_nounix, "noposix" },
-	{ Opt_unix, "unix" },
-	{ Opt_unix, "linux" },
-	{ Opt_unix, "posix" },
-	{ Opt_nocase, "nocase" },
-	{ Opt_nocase, "ignorecase" },
-	{ Opt_brl, "brl" },
-	{ Opt_nobrl, "nobrl" },
-	{ Opt_handlecache, "handlecache" },
-	{ Opt_nohandlecache, "nohandlecache" },
-	{ Opt_nobrl, "nolock" },
-	{ Opt_forcemandatorylock, "forcemandatorylock" },
-	{ Opt_forcemandatorylock, "forcemand" },
-	{ Opt_setuids, "setuids" },
-	{ Opt_nosetuids, "nosetuids" },
-	{ Opt_setuidfromacl, "idsfromsid" },
-	{ Opt_dynperm, "dynperm" },
-	{ Opt_nodynperm, "nodynperm" },
-	{ Opt_nohard, "nohard" },
-	{ Opt_nosoft, "nosoft" },
-	{ Opt_nointr, "nointr" },
-	{ Opt_intr, "intr" },
-	{ Opt_nostrictsync, "nostrictsync" },
-	{ Opt_strictsync, "strictsync" },
-	{ Opt_serverino, "serverino" },
-	{ Opt_noserverino, "noserverino" },
-	{ Opt_rwpidforward, "rwpidforward" },
-	{ Opt_modesid, "modefromsid" },
-	{ Opt_cifsacl, "cifsacl" },
-	{ Opt_nocifsacl, "nocifsacl" },
-	{ Opt_acl, "acl" },
-	{ Opt_noacl, "noacl" },
-	{ Opt_locallease, "locallease" },
-	{ Opt_sign, "sign" },
-	{ Opt_ignore_signature, "signloosely" },
-	{ Opt_seal, "seal" },
-	{ Opt_noac, "noac" },
-	{ Opt_fsc, "fsc" },
-	{ Opt_mfsymlinks, "mfsymlinks" },
-	{ Opt_multiuser, "multiuser" },
-	{ Opt_sloppy, "sloppy" },
-	{ Opt_nosharesock, "nosharesock" },
-	{ Opt_persistent, "persistenthandles"},
-	{ Opt_nopersistent, "nopersistenthandles"},
-	{ Opt_resilient, "resilienthandles"},
-	{ Opt_noresilient, "noresilienthandles"},
-	{ Opt_domainauto, "domainauto"},
-	{ Opt_rdma, "rdma"},
-	{ Opt_multichannel, "multichannel" },
-	{ Opt_nomultichannel, "nomultichannel" },
-
-	{ Opt_backupuid, "backupuid=%s" },
-	{ Opt_backupgid, "backupgid=%s" },
-	{ Opt_uid, "uid=%s" },
-	{ Opt_cruid, "cruid=%s" },
-	{ Opt_gid, "gid=%s" },
-	{ Opt_file_mode, "file_mode=%s" },
-	{ Opt_dirmode, "dirmode=%s" },
-	{ Opt_dirmode, "dir_mode=%s" },
-	{ Opt_port, "port=%s" },
-	{ Opt_min_enc_offload, "esize=%s" },
-	{ Opt_blocksize, "bsize=%s" },
-	{ Opt_rsize, "rsize=%s" },
-	{ Opt_wsize, "wsize=%s" },
-	{ Opt_actimeo, "actimeo=%s" },
-	{ Opt_handletimeout, "handletimeout=%s" },
-	{ Opt_echo_interval, "echo_interval=%s" },
-	{ Opt_max_credits, "max_credits=%s" },
-	{ Opt_snapshot, "snapshot=%s" },
-	{ Opt_max_channels, "max_channels=%s" },
-	{ Opt_compress, "compress=%s" },
-
-	{ Opt_blank_user, "user=" },
-	{ Opt_blank_user, "username=" },
-	{ Opt_user, "user=%s" },
-	{ Opt_user, "username=%s" },
-	{ Opt_blank_pass, "pass=" },
-	{ Opt_blank_pass, "password=" },
-	{ Opt_pass, "pass=%s" },
-	{ Opt_pass, "password=%s" },
-	{ Opt_blank_ip, "ip=" },
-	{ Opt_blank_ip, "addr=" },
-	{ Opt_ip, "ip=%s" },
-	{ Opt_ip, "addr=%s" },
-	{ Opt_ignore, "unc=%s" },
-	{ Opt_ignore, "target=%s" },
-	{ Opt_ignore, "path=%s" },
-	{ Opt_domain, "dom=%s" },
-	{ Opt_domain, "domain=%s" },
-	{ Opt_domain, "workgroup=%s" },
-	{ Opt_srcaddr, "srcaddr=%s" },
-	{ Opt_ignore, "prefixpath=%s" },
-	{ Opt_iocharset, "iocharset=%s" },
-	{ Opt_netbiosname, "netbiosname=%s" },
-	{ Opt_servern, "servern=%s" },
-	{ Opt_ver, "ver=%s" },
-	{ Opt_vers, "vers=%s" },
-	{ Opt_sec, "sec=%s" },
-	{ Opt_cache, "cache=%s" },
-
-	{ Opt_ignore, "cred" },
-	{ Opt_ignore, "credentials" },
-	{ Opt_ignore, "cred=%s" },
-	{ Opt_ignore, "credentials=%s" },
-	{ Opt_ignore, "guest" },
-	{ Opt_ignore, "rw" },
-	{ Opt_ignore, "ro" },
-	{ Opt_ignore, "suid" },
-	{ Opt_ignore, "nosuid" },
-	{ Opt_ignore, "exec" },
-	{ Opt_ignore, "noexec" },
-	{ Opt_ignore, "nodev" },
-	{ Opt_ignore, "noauto" },
-	{ Opt_ignore, "dev" },
-	{ Opt_ignore, "mand" },
-	{ Opt_ignore, "nomand" },
-	{ Opt_ignore, "relatime" },
-	{ Opt_ignore, "_netdev" },
-	{ Opt_rootfs, "rootfs" },
-
-	{ Opt_err, NULL }
-};
-
 static int ip_connect(struct TCP_Server_Info *server);
 static int generic_ip_connect(struct TCP_Server_Info *server);
 static void tlink_rb_insert(struct rb_root *root, struct tcon_link *new_tlink);
@@ -1206,960 +1056,6 @@ extract_hostname(const char *unc)
 	return dst;
 }
 
-static int get_option_ul(substring_t args[], unsigned long *option)
-{
-	int rc;
-	char *string;
-
-	string = match_strdup(args);
-	if (string == NULL)
-		return -ENOMEM;
-	rc = kstrtoul(string, 0, option);
-	kfree(string);
-
-	return rc;
-}
-
-static int get_option_uid(substring_t args[], kuid_t *result)
-{
-	unsigned long value;
-	kuid_t uid;
-	int rc;
-
-	rc = get_option_ul(args, &value);
-	if (rc)
-		return rc;
-
-	uid = make_kuid(current_user_ns(), value);
-	if (!uid_valid(uid))
-		return -EINVAL;
-
-	*result = uid;
-	return 0;
-}
-
-static int get_option_gid(substring_t args[], kgid_t *result)
-{
-	unsigned long value;
-	kgid_t gid;
-	int rc;
-
-	rc = get_option_ul(args, &value);
-	if (rc)
-		return rc;
-
-	gid = make_kgid(current_user_ns(), value);
-	if (!gid_valid(gid))
-		return -EINVAL;
-
-	*result = gid;
-	return 0;
-}
-
-static int
-cifs_parse_mount_options(const char *mountdata, const char *devname,
-			 struct smb3_fs_context *ctx, bool is_smb3)
-{
-	char *data, *end;
-	char *mountdata_copy = NULL, *options;
-	unsigned int  temp_len, i, j;
-	char separator[2];
-	short int override_uid = -1;
-	short int override_gid = -1;
-	bool uid_specified = false;
-	bool gid_specified = false;
-	bool sloppy = false;
-	char *invalid = NULL;
-	char *nodename = utsname()->nodename;
-	char *string = NULL;
-	char *tmp_end, *value;
-	char delim;
-	bool got_ip = false;
-	bool got_version = false;
-	unsigned short port = 0;
-	struct sockaddr *dstaddr = (struct sockaddr *)&ctx->dstaddr;
-
-	separator[0] = ',';
-	separator[1] = 0;
-	delim = separator[0];
-
-	/* ensure we always start with zeroed-out ctx */
-	memset(ctx, 0, sizeof(*ctx));
-
-	/*
-	 * does not have to be perfect mapping since field is
-	 * informational, only used for servers that do not support
-	 * port 445 and it can be overridden at mount time
-	 */
-	memset(ctx->source_rfc1001_name, 0x20, RFC1001_NAME_LEN);
-	for (i = 0; i < strnlen(nodename, RFC1001_NAME_LEN); i++)
-		ctx->source_rfc1001_name[i] = toupper(nodename[i]);
-
-	ctx->source_rfc1001_name[RFC1001_NAME_LEN] = 0;
-	/* null target name indicates to use *SMBSERVR default called name
-	   if we end up sending RFC1001 session initialize */
-	ctx->target_rfc1001_name[0] = 0;
-	ctx->cred_uid = current_uid();
-	ctx->linux_uid = current_uid();
-	ctx->linux_gid = current_gid();
-	ctx->bsize = 1024 * 1024; /* can improve cp performance significantly */
-	/*
-	 * default to SFM style remapping of seven reserved characters
-	 * unless user overrides it or we negotiate CIFS POSIX where
-	 * it is unnecessary.  Can not simultaneously use more than one mapping
-	 * since then readdir could list files that open could not open
-	 */
-	ctx->remap = true;
-
-	/* default to only allowing write access to owner of the mount */
-	ctx->dir_mode = ctx->file_mode = S_IRUGO | S_IXUGO | S_IWUSR;
-
-	/* ctx->retry default is 0 (i.e. "soft" limited retry not hard retry) */
-	/* default is always to request posix paths. */
-	ctx->posix_paths = 1;
-	/* default to using server inode numbers where available */
-	ctx->server_ino = 1;
-
-	/* default is to use strict cifs caching semantics */
-	ctx->strict_io = true;
-
-	ctx->actimeo = CIFS_DEF_ACTIMEO;
-
-	/* Most clients set timeout to 0, allows server to use its default */
-	ctx->handle_timeout = 0; /* See MS-SMB2 spec section 2.2.14.2.12 */
-
-	/* offer SMB2.1 and later (SMB3 etc). Secure and widely accepted */
-	ctx->ops = &smb30_operations;
-	ctx->vals = &smbdefault_values;
-
-	ctx->echo_interval = SMB_ECHO_INTERVAL_DEFAULT;
-
-	/* default to no multichannel (single server connection) */
-	ctx->multichannel = false;
-	ctx->max_channels = 1;
-
-	if (!mountdata)
-		goto cifs_parse_mount_err;
-
-	mountdata_copy = kstrndup(mountdata, PAGE_SIZE, GFP_KERNEL);
-	if (!mountdata_copy)
-		goto cifs_parse_mount_err;
-
-	options = mountdata_copy;
-	end = options + strlen(options);
-
-	if (strncmp(options, "sep=", 4) == 0) {
-		if (options[4] != 0) {
-			separator[0] = options[4];
-			options += 5;
-		} else {
-			cifs_dbg(FYI, "Null separator not allowed\n");
-		}
-	}
-	ctx->backupuid_specified = false; /* no backup intent for a user */
-	ctx->backupgid_specified = false; /* no backup intent for a group */
-
-	switch (smb3_parse_devname(devname, ctx)) {
-	case 0:
-		break;
-	case -ENOMEM:
-		cifs_dbg(VFS, "Unable to allocate memory for devname\n");
-		goto cifs_parse_mount_err;
-	case -EINVAL:
-		cifs_dbg(VFS, "Malformed UNC in devname\n");
-		goto cifs_parse_mount_err;
-	default:
-		cifs_dbg(VFS, "Unknown error parsing devname\n");
-		goto cifs_parse_mount_err;
-	}
-
-	while ((data = strsep(&options, separator)) != NULL) {
-		substring_t args[MAX_OPT_ARGS];
-		unsigned long option;
-		int token;
-
-		if (!*data)
-			continue;
-
-		token = match_token(data, cifs_mount_option_tokens, args);
-
-		switch (token) {
-
-		/* Ingnore the following */
-		case Opt_ignore:
-			break;
-
-		/* Boolean values */
-		case Opt_user_xattr:
-			ctx->no_xattr = 0;
-			break;
-		case Opt_nouser_xattr:
-			ctx->no_xattr = 1;
-			break;
-		case Opt_forceuid:
-			override_uid = 1;
-			break;
-		case Opt_noforceuid:
-			override_uid = 0;
-			break;
-		case Opt_forcegid:
-			override_gid = 1;
-			break;
-		case Opt_noforcegid:
-			override_gid = 0;
-			break;
-		case Opt_noblocksend:
-			ctx->noblocksnd = 1;
-			break;
-		case Opt_noautotune:
-			ctx->noautotune = 1;
-			break;
-		case Opt_nolease:
-			ctx->no_lease = 1;
-			break;
-		case Opt_hard:
-			ctx->retry = 1;
-			break;
-		case Opt_soft:
-			ctx->retry = 0;
-			break;
-		case Opt_perm:
-			ctx->noperm = 0;
-			break;
-		case Opt_noperm:
-			ctx->noperm = 1;
-			break;
-		case Opt_nodelete:
-			ctx->nodelete = 1;
-			break;
-		case Opt_mapchars:
-			ctx->sfu_remap = true;
-			ctx->remap = false; /* disable SFM mapping */
-			break;
-		case Opt_nomapchars:
-			ctx->sfu_remap = false;
-			break;
-		case Opt_mapposix:
-			ctx->remap = true;
-			ctx->sfu_remap = false; /* disable SFU mapping */
-			break;
-		case Opt_nomapposix:
-			ctx->remap = false;
-			break;
-		case Opt_sfu:
-			ctx->sfu_emul = 1;
-			break;
-		case Opt_nosfu:
-			ctx->sfu_emul = 0;
-			break;
-		case Opt_nodfs:
-			ctx->nodfs = 1;
-			break;
-		case Opt_rootfs:
-#ifdef CONFIG_CIFS_ROOT
-			ctx->rootfs = true;
-#endif
-			break;
-		case Opt_posixpaths:
-			ctx->posix_paths = 1;
-			break;
-		case Opt_noposixpaths:
-			ctx->posix_paths = 0;
-			break;
-		case Opt_nounix:
-			if (ctx->linux_ext)
-				cifs_dbg(VFS,
-					"conflicting unix mount options\n");
-			ctx->no_linux_ext = 1;
-			break;
-		case Opt_unix:
-			if (ctx->no_linux_ext)
-				cifs_dbg(VFS,
-					"conflicting unix mount options\n");
-			ctx->linux_ext = 1;
-			break;
-		case Opt_nocase:
-			ctx->nocase = 1;
-			break;
-		case Opt_brl:
-			ctx->nobrl =  0;
-			break;
-		case Opt_nobrl:
-			ctx->nobrl =  1;
-			/*
-			 * turn off mandatory locking in mode
-			 * if remote locking is turned off since the
-			 * local vfs will do advisory
-			 */
-			if (ctx->file_mode ==
-				(S_IALLUGO & ~(S_ISUID | S_IXGRP)))
-				ctx->file_mode = S_IALLUGO;
-			break;
-		case Opt_nohandlecache:
-			ctx->nohandlecache = 1;
-			break;
-		case Opt_handlecache:
-			ctx->nohandlecache = 0;
-			break;
-		case Opt_forcemandatorylock:
-			ctx->mand_lock = 1;
-			break;
-		case Opt_setuids:
-			ctx->setuids = 1;
-			break;
-		case Opt_nosetuids:
-			ctx->setuids = 0;
-			break;
-		case Opt_setuidfromacl:
-			ctx->setuidfromacl = 1;
-			break;
-		case Opt_dynperm:
-			ctx->dynperm = true;
-			break;
-		case Opt_nodynperm:
-			ctx->dynperm = false;
-			break;
-		case Opt_nohard:
-			ctx->retry = 0;
-			break;
-		case Opt_nosoft:
-			ctx->retry = 1;
-			break;
-		case Opt_nointr:
-			ctx->intr = 0;
-			break;
-		case Opt_intr:
-			ctx->intr = 1;
-			break;
-		case Opt_nostrictsync:
-			ctx->nostrictsync = 1;
-			break;
-		case Opt_strictsync:
-			ctx->nostrictsync = 0;
-			break;
-		case Opt_serverino:
-			ctx->server_ino = 1;
-			break;
-		case Opt_noserverino:
-			ctx->server_ino = 0;
-			break;
-		case Opt_rwpidforward:
-			ctx->rwpidforward = 1;
-			break;
-		case Opt_modesid:
-			ctx->mode_ace = 1;
-			break;
-		case Opt_cifsacl:
-			ctx->cifs_acl = 1;
-			break;
-		case Opt_nocifsacl:
-			ctx->cifs_acl = 0;
-			break;
-		case Opt_acl:
-			ctx->no_psx_acl = 0;
-			break;
-		case Opt_noacl:
-			ctx->no_psx_acl = 1;
-			break;
-		case Opt_locallease:
-			ctx->local_lease = 1;
-			break;
-		case Opt_sign:
-			ctx->sign = true;
-			break;
-		case Opt_ignore_signature:
-			ctx->sign = true;
-			ctx->ignore_signature = true;
-			break;
-		case Opt_seal:
-			/* we do not do the following in secFlags because seal
-			 * is a per tree connection (mount) not a per socket
-			 * or per-smb connection option in the protocol
-			 * ctx->secFlg |= CIFSSEC_MUST_SEAL;
-			 */
-			ctx->seal = 1;
-			break;
-		case Opt_noac:
-			pr_warn("Mount option noac not supported. Instead set /proc/fs/cifs/LookupCacheEnabled to 0\n");
-			break;
-		case Opt_fsc:
-#ifndef CONFIG_CIFS_FSCACHE
-			cifs_dbg(VFS, "FS-Cache support needs CONFIG_CIFS_FSCACHE kernel config option set\n");
-			goto cifs_parse_mount_err;
-#endif
-			ctx->fsc = true;
-			break;
-		case Opt_mfsymlinks:
-			ctx->mfsymlinks = true;
-			break;
-		case Opt_multiuser:
-			ctx->multiuser = true;
-			break;
-		case Opt_sloppy:
-			sloppy = true;
-			break;
-		case Opt_nosharesock:
-			ctx->nosharesock = true;
-			break;
-		case Opt_nopersistent:
-			ctx->nopersistent = true;
-			if (ctx->persistent) {
-				cifs_dbg(VFS,
-				  "persistenthandles mount options conflict\n");
-				goto cifs_parse_mount_err;
-			}
-			break;
-		case Opt_persistent:
-			ctx->persistent = true;
-			if ((ctx->nopersistent) || (ctx->resilient)) {
-				cifs_dbg(VFS,
-				  "persistenthandles mount options conflict\n");
-				goto cifs_parse_mount_err;
-			}
-			break;
-		case Opt_resilient:
-			ctx->resilient = true;
-			if (ctx->persistent) {
-				cifs_dbg(VFS,
-				  "persistenthandles mount options conflict\n");
-				goto cifs_parse_mount_err;
-			}
-			break;
-		case Opt_noresilient:
-			ctx->resilient = false; /* already the default */
-			break;
-		case Opt_domainauto:
-			ctx->domainauto = true;
-			break;
-		case Opt_rdma:
-			ctx->rdma = true;
-			break;
-		case Opt_multichannel:
-			ctx->multichannel = true;
-			/* if number of channels not specified, default to 2 */
-			if (ctx->max_channels < 2)
-				ctx->max_channels = 2;
-			break;
-		case Opt_nomultichannel:
-			ctx->multichannel = false;
-			ctx->max_channels = 1;
-			break;
-		case Opt_compress:
-			ctx->compression = UNKNOWN_TYPE;
-			cifs_dbg(VFS,
-				"SMB3 compression support is experimental\n");
-			break;
-
-		/* Numeric Values */
-		case Opt_backupuid:
-			if (get_option_uid(args, &ctx->backupuid)) {
-				cifs_dbg(VFS, "%s: Invalid backupuid value\n",
-					 __func__);
-				goto cifs_parse_mount_err;
-			}
-			ctx->backupuid_specified = true;
-			break;
-		case Opt_backupgid:
-			if (get_option_gid(args, &ctx->backupgid)) {
-				cifs_dbg(VFS, "%s: Invalid backupgid value\n",
-					 __func__);
-				goto cifs_parse_mount_err;
-			}
-			ctx->backupgid_specified = true;
-			break;
-		case Opt_uid:
-			if (get_option_uid(args, &ctx->linux_uid)) {
-				cifs_dbg(VFS, "%s: Invalid uid value\n",
-					 __func__);
-				goto cifs_parse_mount_err;
-			}
-			uid_specified = true;
-			break;
-		case Opt_cruid:
-			if (get_option_uid(args, &ctx->cred_uid)) {
-				cifs_dbg(VFS, "%s: Invalid cruid value\n",
-					 __func__);
-				goto cifs_parse_mount_err;
-			}
-			break;
-		case Opt_gid:
-			if (get_option_gid(args, &ctx->linux_gid)) {
-				cifs_dbg(VFS, "%s: Invalid gid value\n",
-					 __func__);
-				goto cifs_parse_mount_err;
-			}
-			gid_specified = true;
-			break;
-		case Opt_file_mode:
-			if (get_option_ul(args, &option)) {
-				cifs_dbg(VFS, "%s: Invalid file_mode value\n",
-					 __func__);
-				goto cifs_parse_mount_err;
-			}
-			ctx->file_mode = option;
-			break;
-		case Opt_dirmode:
-			if (get_option_ul(args, &option)) {
-				cifs_dbg(VFS, "%s: Invalid dir_mode value\n",
-					 __func__);
-				goto cifs_parse_mount_err;
-			}
-			ctx->dir_mode = option;
-			break;
-		case Opt_port:
-			if (get_option_ul(args, &option) ||
-			    option > USHRT_MAX) {
-				cifs_dbg(VFS, "%s: Invalid port value\n",
-					 __func__);
-				goto cifs_parse_mount_err;
-			}
-			port = (unsigned short)option;
-			break;
-		case Opt_min_enc_offload:
-			if (get_option_ul(args, &option)) {
-				cifs_dbg(VFS, "Invalid minimum encrypted read offload size (esize)\n");
-				goto cifs_parse_mount_err;
-			}
-			ctx->min_offload = option;
-			break;
-		case Opt_blocksize:
-			if (get_option_ul(args, &option)) {
-				cifs_dbg(VFS, "%s: Invalid blocksize value\n",
-					__func__);
-				goto cifs_parse_mount_err;
-			}
-			/*
-			 * inode blocksize realistically should never need to be
-			 * less than 16K or greater than 16M and default is 1MB.
-			 * Note that small inode block sizes (e.g. 64K) can lead
-			 * to very poor performance of common tools like cp and scp
-			 */
-			if ((option < CIFS_MAX_MSGSIZE) ||
-			   (option > (4 * SMB3_DEFAULT_IOSIZE))) {
-				cifs_dbg(VFS, "%s: Invalid blocksize\n",
-					__func__);
-				goto cifs_parse_mount_err;
-			}
-			ctx->bsize = option;
-			break;
-		case Opt_rsize:
-			if (get_option_ul(args, &option)) {
-				cifs_dbg(VFS, "%s: Invalid rsize value\n",
-					 __func__);
-				goto cifs_parse_mount_err;
-			}
-			ctx->rsize = option;
-			break;
-		case Opt_wsize:
-			if (get_option_ul(args, &option)) {
-				cifs_dbg(VFS, "%s: Invalid wsize value\n",
-					 __func__);
-				goto cifs_parse_mount_err;
-			}
-			ctx->wsize = option;
-			break;
-		case Opt_actimeo:
-			if (get_option_ul(args, &option)) {
-				cifs_dbg(VFS, "%s: Invalid actimeo value\n",
-					 __func__);
-				goto cifs_parse_mount_err;
-			}
-			ctx->actimeo = HZ * option;
-			if (ctx->actimeo > CIFS_MAX_ACTIMEO) {
-				cifs_dbg(VFS, "attribute cache timeout too large\n");
-				goto cifs_parse_mount_err;
-			}
-			break;
-		case Opt_handletimeout:
-			if (get_option_ul(args, &option)) {
-				cifs_dbg(VFS, "%s: Invalid handletimeout value\n",
-					 __func__);
-				goto cifs_parse_mount_err;
-			}
-			ctx->handle_timeout = option;
-			if (ctx->handle_timeout > SMB3_MAX_HANDLE_TIMEOUT) {
-				cifs_dbg(VFS, "Invalid handle cache timeout, longer than 16 minutes\n");
-				goto cifs_parse_mount_err;
-			}
-			break;
-		case Opt_echo_interval:
-			if (get_option_ul(args, &option)) {
-				cifs_dbg(VFS, "%s: Invalid echo interval value\n",
-					 __func__);
-				goto cifs_parse_mount_err;
-			}
-			ctx->echo_interval = option;
-			break;
-		case Opt_snapshot:
-			if (get_option_ul(args, &option)) {
-				cifs_dbg(VFS, "%s: Invalid snapshot time\n",
-					 __func__);
-				goto cifs_parse_mount_err;
-			}
-			ctx->snapshot_time = option;
-			break;
-		case Opt_max_credits:
-			if (get_option_ul(args, &option) || (option < 20) ||
-			    (option > 60000)) {
-				cifs_dbg(VFS, "%s: Invalid max_credits value\n",
-					 __func__);
-				goto cifs_parse_mount_err;
-			}
-			ctx->max_credits = option;
-			break;
-		case Opt_max_channels:
-			if (get_option_ul(args, &option) || option < 1 ||
-				option > CIFS_MAX_CHANNELS) {
-				cifs_dbg(VFS, "%s: Invalid max_channels value, needs to be 1-%d\n",
-					 __func__, CIFS_MAX_CHANNELS);
-				goto cifs_parse_mount_err;
-			}
-			ctx->max_channels = option;
-			break;
-
-		/* String Arguments */
-
-		case Opt_blank_user:
-			/* null user, ie. anonymous authentication */
-			ctx->nullauth = 1;
-			ctx->username = NULL;
-			break;
-		case Opt_user:
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-
-			if (strnlen(string, CIFS_MAX_USERNAME_LEN) >
-							CIFS_MAX_USERNAME_LEN) {
-				pr_warn("username too long\n");
-				goto cifs_parse_mount_err;
-			}
-
-			kfree(ctx->username);
-			ctx->username = kstrdup(string, GFP_KERNEL);
-			if (!ctx->username)
-				goto cifs_parse_mount_err;
-			break;
-		case Opt_blank_pass:
-			/* passwords have to be handled differently
-			 * to allow the character used for deliminator
-			 * to be passed within them
-			 */
-
-			/*
-			 * Check if this is a case where the  password
-			 * starts with a delimiter
-			 */
-			tmp_end = strchr(data, '=');
-			tmp_end++;
-			if (!(tmp_end < end && tmp_end[1] == delim)) {
-				/* No it is not. Set the password to NULL */
-				kfree_sensitive(ctx->password);
-				ctx->password = NULL;
-				break;
-			}
-			fallthrough;	/* to Opt_pass below */
-		case Opt_pass:
-			/* Obtain the value string */
-			value = strchr(data, '=');
-			value++;
-
-			/* Set tmp_end to end of the string */
-			tmp_end = (char *) value + strlen(value);
-
-			/* Check if following character is the deliminator
-			 * If yes, we have encountered a double deliminator
-			 * reset the NULL character to the deliminator
-			 */
-			if (tmp_end < end && tmp_end[1] == delim) {
-				tmp_end[0] = delim;
-
-				/* Keep iterating until we get to a single
-				 * deliminator OR the end
-				 */
-				while ((tmp_end = strchr(tmp_end, delim))
-					!= NULL && (tmp_end[1] == delim)) {
-						tmp_end = (char *) &tmp_end[2];
-				}
-
-				/* Reset var options to point to next element */
-				if (tmp_end) {
-					tmp_end[0] = '\0';
-					options = (char *) &tmp_end[1];
-				} else
-					/* Reached the end of the mount option
-					 * string */
-					options = end;
-			}
-
-			kfree_sensitive(ctx->password);
-			/* Now build new password string */
-			temp_len = strlen(value);
-			ctx->password = kzalloc(temp_len+1, GFP_KERNEL);
-			if (ctx->password == NULL) {
-				pr_warn("no memory for password\n");
-				goto cifs_parse_mount_err;
-			}
-
-			for (i = 0, j = 0; i < temp_len; i++, j++) {
-				ctx->password[j] = value[i];
-				if ((value[i] == delim) &&
-				     value[i+1] == delim)
-					/* skip the second deliminator */
-					i++;
-			}
-			ctx->password[j] = '\0';
-			break;
-		case Opt_blank_ip:
-			/* FIXME: should this be an error instead? */
-			got_ip = false;
-			break;
-		case Opt_ip:
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-
-			if (!cifs_convert_address(dstaddr, string,
-					strlen(string))) {
-				pr_err("bad ip= option (%s)\n", string);
-				goto cifs_parse_mount_err;
-			}
-			got_ip = true;
-			break;
-		case Opt_domain:
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-
-			if (strnlen(string, CIFS_MAX_DOMAINNAME_LEN)
-					== CIFS_MAX_DOMAINNAME_LEN) {
-				pr_warn("domain name too long\n");
-				goto cifs_parse_mount_err;
-			}
-
-			kfree(ctx->domainname);
-			ctx->domainname = kstrdup(string, GFP_KERNEL);
-			if (!ctx->domainname) {
-				pr_warn("no memory for domainname\n");
-				goto cifs_parse_mount_err;
-			}
-			cifs_dbg(FYI, "Domain name set\n");
-			break;
-		case Opt_srcaddr:
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-
-			if (!cifs_convert_address(
-					(struct sockaddr *)&ctx->srcaddr,
-					string, strlen(string))) {
-				pr_warn("Could not parse srcaddr: %s\n",
-					string);
-				goto cifs_parse_mount_err;
-			}
-			break;
-		case Opt_iocharset:
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-
-			if (strnlen(string, 1024) >= 65) {
-				pr_warn("iocharset name too long\n");
-				goto cifs_parse_mount_err;
-			}
-
-			 if (strncasecmp(string, "default", 7) != 0) {
-				kfree(ctx->iocharset);
-				ctx->iocharset = kstrdup(string,
-							 GFP_KERNEL);
-				if (!ctx->iocharset) {
-					pr_warn("no memory for charset\n");
-					goto cifs_parse_mount_err;
-				}
-			}
-			/* if iocharset not set then load_nls_default
-			 * is used by caller
-			 */
-			 cifs_dbg(FYI, "iocharset set to %s\n", string);
-			break;
-		case Opt_netbiosname:
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-
-			memset(ctx->source_rfc1001_name, 0x20,
-				RFC1001_NAME_LEN);
-			/*
-			 * FIXME: are there cases in which a comma can
-			 * be valid in workstation netbios name (and
-			 * need special handling)?
-			 */
-			for (i = 0; i < RFC1001_NAME_LEN; i++) {
-				/* don't ucase netbiosname for user */
-				if (string[i] == 0)
-					break;
-				ctx->source_rfc1001_name[i] = string[i];
-			}
-			/* The string has 16th byte zero still from
-			 * set at top of the function
-			 */
-			if (i == RFC1001_NAME_LEN && string[i] != 0)
-				pr_warn("netbiosname longer than 15 truncated\n");
-			break;
-		case Opt_servern:
-			/* servernetbiosname specified override *SMBSERVER */
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-
-			/* last byte, type, is 0x20 for servr type */
-			memset(ctx->target_rfc1001_name, 0x20,
-				RFC1001_NAME_LEN_WITH_NULL);
-
-			/* BB are there cases in which a comma can be
-			   valid in this workstation netbios name
-			   (and need special handling)? */
-
-			/* user or mount helper must uppercase the
-			   netbios name */
-			for (i = 0; i < 15; i++) {
-				if (string[i] == 0)
-					break;
-				ctx->target_rfc1001_name[i] = string[i];
-			}
-			/* The string has 16th byte zero still from
-			   set at top of the function  */
-			if (i == RFC1001_NAME_LEN && string[i] != 0)
-				pr_warn("server netbiosname longer than 15 truncated\n");
-			break;
-		case Opt_ver:
-			/* version of mount userspace tools, not dialect */
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-
-			/* If interface changes in mount.cifs bump to new ver */
-			if (strncasecmp(string, "1", 1) == 0) {
-				if (strlen(string) > 1) {
-					pr_warn("Bad mount helper ver=%s. Did you want SMB1 (CIFS) dialect and mean to type vers=1.0 instead?\n",
-						string);
-					goto cifs_parse_mount_err;
-				}
-				/* This is the default */
-				break;
-			}
-			/* For all other value, error */
-			pr_warn("Invalid mount helper version specified\n");
-			goto cifs_parse_mount_err;
-		case Opt_vers:
-			/* protocol version (dialect) */
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-
-			if (cifs_parse_smb_version(string, ctx, is_smb3) != 0)
-				goto cifs_parse_mount_err;
-			got_version = true;
-			break;
-		case Opt_sec:
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-
-			if (cifs_parse_security_flavors(string, ctx) != 0)
-				goto cifs_parse_mount_err;
-			break;
-		case Opt_cache:
-			string = match_strdup(args);
-			if (string == NULL)
-				goto out_nomem;
-
-			if (cifs_parse_cache_flavor(string, ctx) != 0)
-				goto cifs_parse_mount_err;
-			break;
-		default:
-			/*
-			 * An option we don't recognize. Save it off for later
-			 * if we haven't already found one
-			 */
-			if (!invalid)
-				invalid = data;
-			break;
-		}
-		/* Free up any allocated string */
-		kfree(string);
-		string = NULL;
-	}
-
-	if (!sloppy && invalid) {
-		pr_err("Unknown mount option \"%s\"\n", invalid);
-		goto cifs_parse_mount_err;
-	}
-
-	if (ctx->rdma && ctx->vals->protocol_id < SMB30_PROT_ID) {
-		cifs_dbg(VFS, "SMB Direct requires Version >=3.0\n");
-		goto cifs_parse_mount_err;
-	}
-
-#ifndef CONFIG_KEYS
-	/* Muliuser mounts require CONFIG_KEYS support */
-	if (ctx->multiuser) {
-		cifs_dbg(VFS, "Multiuser mounts require kernels with CONFIG_KEYS enabled\n");
-		goto cifs_parse_mount_err;
-	}
-#endif
-	if (!ctx->UNC) {
-		cifs_dbg(VFS, "CIFS mount error: No usable UNC path provided in device string!\n");
-		goto cifs_parse_mount_err;
-	}
-
-	/* make sure UNC has a share name */
-	if (!strchr(ctx->UNC + 3, '\\')) {
-		cifs_dbg(VFS, "Malformed UNC. Unable to find share name.\n");
-		goto cifs_parse_mount_err;
-	}
-
-	if (!got_ip) {
-		int len;
-		const char *slash;
-
-		/* No ip= option specified? Try to get it from UNC */
-		/* Use the address part of the UNC. */
-		slash = strchr(&ctx->UNC[2], '\\');
-		len = slash - &ctx->UNC[2];
-		if (!cifs_convert_address(dstaddr, &ctx->UNC[2], len)) {
-			pr_err("Unable to determine destination address\n");
-			goto cifs_parse_mount_err;
-		}
-	}
-
-	/* set the port that we got earlier */
-	cifs_set_port(dstaddr, port);
-
-	if (uid_specified)
-		ctx->override_uid = override_uid;
-	else if (override_uid == 1)
-		pr_notice("ignoring forceuid mount option specified with no uid= option\n");
-
-	if (gid_specified)
-		ctx->override_gid = override_gid;
-	else if (override_gid == 1)
-		pr_notice("ignoring forcegid mount option specified with no gid= option\n");
-
-	if (got_version == false)
-		pr_warn_once("No dialect specified on mount. Default has changed to a more secure dialect, SMB2.1 or later (e.g. SMB3.1.1), from CIFS (SMB1). To use the less secure SMB1 dialect to access old servers which do not support SMB3.1.1 (or even SMB3 or SMB2.1) specify vers=1.0 on mount.\n");
-
-	kfree(mountdata_copy);
-	return 0;
-
-out_nomem:
-	pr_warn("Could not allocate temporary buffer\n");
-cifs_parse_mount_err:
-	kfree(string);
-	kfree(mountdata_copy);
-	return 1;
-}
-
 /** Returns true if srcaddr isn't specified and rhs isn't
  * specified, or if srcaddr is specified and
  * matches the IP address of the rhs argument.
@@ -3890,12 +2786,25 @@ int cifs_setup_cifs_sb(struct smb3_fs_context *ctx,
 void
 cifs_cleanup_volume_info_contents(struct smb3_fs_context *ctx)
 {
+	/*
+	 * Make sure this stays in sync with smb3_fs_context_dup()
+	 */
+	kfree(ctx->mount_options);
+	ctx->mount_options = NULL;
 	kfree(ctx->username);
+	ctx->username = NULL;
 	kfree_sensitive(ctx->password);
+	ctx->password = NULL;
 	kfree(ctx->UNC);
+	ctx->UNC = NULL;
 	kfree(ctx->domainname);
+	ctx->domainname = NULL;
+	kfree(ctx->nodename);
+	ctx->nodename = NULL;
 	kfree(ctx->iocharset);
+	ctx->iocharset = NULL;
 	kfree(ctx->prepath);
+	ctx->prepath = NULL;
 }
 
 void
@@ -4122,8 +3031,7 @@ expand_dfs_referral(const unsigned int xid, struct cifs_ses *ses,
 			mdata = NULL;
 		} else {
 			cifs_cleanup_volume_info_contents(ctx);
-			rc = cifs_setup_volume_info(ctx, mdata,
-						    fake_devname, false);
+			rc = cifs_setup_volume_info(ctx);
 		}
 		kfree(fake_devname);
 		kfree(cifs_sb->mountdata);
@@ -4193,9 +3101,7 @@ static int setup_dfs_tgt_conn(const char *path, const char *full_path,
 		rc = PTR_ERR(mdata);
 		mdata = NULL;
 	} else {
-		cifs_dbg(FYI, "%s: fake_devname: %s\n", __func__, fake_devname);
-		rc = cifs_setup_volume_info((struct smb3_fs_context *)&fake_ctx, mdata, fake_devname,
-					    false);
+		rc = cifs_setup_volume_info(&fake_ctx);
 	}
 	kfree(mdata);
 	kfree(fake_devname);
@@ -4217,7 +3123,7 @@ static int setup_dfs_tgt_conn(const char *path, const char *full_path,
 			rc = update_vol_info(tgt_it, &fake_ctx, ctx);
 		}
 	}
-	cifs_cleanup_volume_info_contents((struct smb3_fs_context *)&fake_ctx);
+	cifs_cleanup_volume_info_contents(&fake_ctx);
 	return rc;
 }
 
@@ -4263,15 +3169,14 @@ static int do_dfs_failover(const char *path, const char *full_path, struct cifs_
 }
 #endif
 
+/* TODO: all callers to this are broken. We are not parsing mount_options here
+ * we should pass a clone of the original context?
+ */
 int
-cifs_setup_volume_info(struct smb3_fs_context *ctx, char *mount_data,
-			const char *devname, bool is_smb3)
+cifs_setup_volume_info(struct smb3_fs_context *ctx)
 {
 	int rc = 0;
 
-	if (cifs_parse_mount_options(mount_data, devname, ctx, is_smb3))
-		return -EINVAL;
-
 	if (ctx->nullauth) {
 		cifs_dbg(FYI, "Anonymous login\n");
 		kfree(ctx->username);
@@ -4302,25 +3207,6 @@ cifs_setup_volume_info(struct smb3_fs_context *ctx, char *mount_data,
 	return rc;
 }
 
-struct smb3_fs_context *
-cifs_get_volume_info(char *mount_data, const char *devname, bool is_smb3)
-{
-	int rc;
-	struct smb3_fs_context *ctx;
-
-	ctx = kmalloc(sizeof(*ctx), GFP_KERNEL);
-	if (!ctx)
-		return ERR_PTR(-ENOMEM);
-
-	rc = cifs_setup_volume_info(ctx, mount_data, devname, is_smb3);
-	if (rc) {
-		cifs_cleanup_volume_info(ctx);
-		ctx = ERR_PTR(rc);
-	}
-
-	return ctx;
-}
-
 static int
 cifs_are_all_path_components_accessible(struct TCP_Server_Info *server,
 					unsigned int xid,
diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index 2b77d39d7d22..dde859c21f1a 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -18,9 +18,9 @@
 #include "cifs_debug.h"
 #include "cifs_unicode.h"
 #include "smb2glob.h"
+#include "fs_context.h"
 
 #include "dfs_cache.h"
-#include "fs_context.h"
 
 #define CACHE_HTABLE_SIZE 32
 #define CACHE_MAX_ENTRIES 64
@@ -1142,14 +1142,14 @@ int dfs_cache_get_tgt_referral(const char *path,
 }
 
 /**
- * dfs_cache_add_vol - add a cifs volume during mount() that will be handled by
+ * dfs_cache_add_vol - add a cifs context during mount() that will be handled by
  * DFS cache refresh worker.
  *
  * @mntdata: mount data.
  * @ctx: cifs context.
  * @fullpath: origin full path.
  *
- * Return zero if volume was set up correctly, otherwise non-zero.
+ * Return zero if context was set up correctly, otherwise non-zero.
  */
 int dfs_cache_add_vol(char *mntdata, struct smb3_fs_context *ctx, const char *fullpath)
 {
@@ -1453,7 +1453,7 @@ static struct cifs_ses *find_root_ses(struct vol_info *vi,
 		goto out;
 	}
 
-	rc = cifs_setup_volume_info(&ctx, mdata, devname, false);
+	rc = cifs_setup_volume_info(&ctx);
 	kfree(devname);
 
 	if (rc) {
diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
index 3b15f9a882b2..1e69fdbe76d8 100644
--- a/fs/cifs/fs_context.c
+++ b/fs/cifs/fs_context.c
@@ -6,9 +6,32 @@
  *              David Howells <dhowells@redhat.com>
  */
 
+/*
+#include <linux/module.h>
+#include <linux/nsproxy.h>
+#include <linux/slab.h>
+#include <linux/magic.h>
+#include <linux/security.h>
+#include <net/net_namespace.h>
+*/
+
+#include <linux/ctype.h>
+#include <linux/fs_context.h>
+#include <linux/fs_parser.h>
+#include <linux/fs.h>
+#include <linux/mount.h>
+#include <linux/parser.h>
+#include <linux/utsname.h>
+#include "cifsfs.h"
+#include "cifspdu.h"
 #include "cifsglob.h"
 #include "cifsproto.h"
+#include "cifs_unicode.h"
 #include "cifs_debug.h"
+#include "cifs_fs_sb.h"
+#include "ntlmssp.h"
+#include "nterr.h"
+#include "rfc1002pdu.h"
 #include "fs_context.h"
 
 static const match_table_t cifs_smb_version_tokens = {
@@ -25,77 +48,6 @@ static const match_table_t cifs_smb_version_tokens = {
 	{ Smb_version_err, NULL }
 };
 
-int
-cifs_parse_smb_version(char *value, struct smb3_fs_context *ctx, bool is_smb3)
-{
-	substring_t args[MAX_OPT_ARGS];
-
-	switch (match_token(value, cifs_smb_version_tokens, args)) {
-#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
-	case Smb_1:
-		if (disable_legacy_dialects) {
-			cifs_dbg(VFS, "mount with legacy dialect disabled\n");
-			return 1;
-		}
-		if (is_smb3) {
-			cifs_dbg(VFS, "vers=1.0 (cifs) not permitted when mounting with smb3\n");
-			return 1;
-		}
-		cifs_dbg(VFS, "Use of the less secure dialect vers=1.0 is not recommended unless required for access to very old servers\n");
-		ctx->ops = &smb1_operations;
-		ctx->vals = &smb1_values;
-		break;
-	case Smb_20:
-		if (disable_legacy_dialects) {
-			cifs_dbg(VFS, "mount with legacy dialect disabled\n");
-			return 1;
-		}
-		if (is_smb3) {
-			cifs_dbg(VFS, "vers=2.0 not permitted when mounting with smb3\n");
-			return 1;
-		}
-		ctx->ops = &smb20_operations;
-		ctx->vals = &smb20_values;
-		break;
-#else
-	case Smb_1:
-		cifs_dbg(VFS, "vers=1.0 (cifs) mount not permitted when legacy dialects disabled\n");
-		return 1;
-	case Smb_20:
-		cifs_dbg(VFS, "vers=2.0 mount not permitted when legacy dialects disabled\n");
-		return 1;
-#endif /* CIFS_ALLOW_INSECURE_LEGACY */
-	case Smb_21:
-		ctx->ops = &smb21_operations;
-		ctx->vals = &smb21_values;
-		break;
-	case Smb_30:
-		ctx->ops = &smb30_operations;
-		ctx->vals = &smb30_values;
-		break;
-	case Smb_302:
-		ctx->ops = &smb30_operations; /* currently identical with 3.0 */
-		ctx->vals = &smb302_values;
-		break;
-	case Smb_311:
-		ctx->ops = &smb311_operations;
-		ctx->vals = &smb311_values;
-		break;
-	case Smb_3any:
-		ctx->ops = &smb30_operations; /* currently identical with 3.0 */
-		ctx->vals = &smb3any_values;
-		break;
-	case Smb_default:
-		ctx->ops = &smb30_operations; /* currently identical with 3.0 */
-		ctx->vals = &smbdefault_values;
-		break;
-	default:
-		cifs_dbg(VFS, "Unknown vers= option specified: %s\n", value);
-		return 1;
-	}
-	return 0;
-}
-
 static const match_table_t cifs_secflavor_tokens = {
 	{ Opt_sec_krb5, "krb5" },
 	{ Opt_sec_krb5i, "krb5i" },
@@ -113,7 +65,117 @@ static const match_table_t cifs_secflavor_tokens = {
 	{ Opt_sec_err, NULL }
 };
 
-int cifs_parse_security_flavors(char *value, struct smb3_fs_context *ctx)
+const struct fs_parameter_spec smb3_fs_parameters[] = {
+	/* Mount options that take no arguments */
+	fsparam_flag_no("user_xattr", Opt_user_xattr),
+	fsparam_flag_no("forceuid", Opt_forceuid),
+	fsparam_flag_no("multichannel", Opt_multichannel),
+	fsparam_flag_no("forcegid", Opt_forcegid),
+	fsparam_flag("noblocksend", Opt_noblocksend),
+	fsparam_flag("noautotune", Opt_noautotune),
+	fsparam_flag("nolease", Opt_nolease),
+	fsparam_flag_no("hard", Opt_hard),
+	fsparam_flag_no("soft", Opt_soft),
+	fsparam_flag_no("perm", Opt_perm),
+	fsparam_flag("nodelete", Opt_nodelete),
+	fsparam_flag_no("mapposix", Opt_mapposix),
+	fsparam_flag("mapchars", Opt_mapchars),
+	fsparam_flag("nomapchars", Opt_nomapchars),
+	fsparam_flag_no("sfu", Opt_sfu),
+	fsparam_flag("nodfs", Opt_nodfs),
+	fsparam_flag_no("posixpaths", Opt_posixpaths),
+	fsparam_flag_no("unix", Opt_unix),
+	fsparam_flag_no("linux", Opt_unix),
+	fsparam_flag_no("posix", Opt_unix),
+	fsparam_flag("nocase", Opt_nocase),
+	fsparam_flag("ignorecase", Opt_nocase),
+	fsparam_flag_no("brl", Opt_brl),
+	fsparam_flag_no("handlecache", Opt_handlecache),
+	fsparam_flag("forcemandatorylock", Opt_forcemandatorylock),
+	fsparam_flag("forcemand", Opt_forcemandatorylock),
+	fsparam_flag("setuidfromacl", Opt_setuidfromacl),
+	fsparam_flag_no("setuids", Opt_setuids),
+	fsparam_flag_no("dynperm", Opt_dynperm),
+	fsparam_flag_no("intr", Opt_intr),
+	fsparam_flag_no("strictsync", Opt_strictsync),
+	fsparam_flag_no("serverino", Opt_serverino),
+	fsparam_flag("rwpidforward", Opt_rwpidforward),
+	fsparam_flag("cifsacl", Opt_cifsacl),
+	fsparam_flag_no("acl", Opt_acl),
+	fsparam_flag("locallease", Opt_locallease),
+	fsparam_flag("sign", Opt_sign),
+	fsparam_flag("ignore_signature", Opt_ignore_signature),
+	fsparam_flag("seal", Opt_seal),
+	fsparam_flag("noac", Opt_noac),
+	fsparam_flag("fsc", Opt_fsc),
+	fsparam_flag("mfsymlinks", Opt_mfsymlinks),
+	fsparam_flag("multiuser", Opt_multiuser),
+	fsparam_flag("sloppy", Opt_sloppy),
+	fsparam_flag("nosharesock", Opt_nosharesock),
+	fsparam_flag_no("persistent", Opt_persistent),
+	fsparam_flag_no("resilient", Opt_resilient),
+	fsparam_flag("domainauto", Opt_domainauto),
+	fsparam_flag("rdma", Opt_rdma),
+	fsparam_flag("modesid", Opt_modesid),
+	fsparam_flag("rootfs", Opt_rootfs),
+	fsparam_flag("compress", Opt_compress),
+
+	/* Mount options which take numeric value */
+	fsparam_u32("backupuid", Opt_backupuid),
+	fsparam_u32("backupgid", Opt_backupgid),
+	fsparam_u32("uid", Opt_uid),
+	fsparam_u32("cruid", Opt_cruid),
+	fsparam_u32("gid", Opt_gid),
+	fsparam_u32("file_mode", Opt_file_mode),
+	fsparam_u32("dirmode", Opt_dirmode),
+	fsparam_u32("dir_mode", Opt_dirmode),
+	fsparam_u32("port", Opt_port),
+	fsparam_u32("min_enc_offload", Opt_min_enc_offload),
+	fsparam_u32("bsize", Opt_blocksize),
+	fsparam_u32("rsize", Opt_rsize),
+	fsparam_u32("wsize", Opt_wsize),
+	fsparam_u32("actimeo", Opt_actimeo),
+	fsparam_u32("echo_interval", Opt_echo_interval),
+	fsparam_u32("max_credits", Opt_max_credits),
+	fsparam_u32("handletimeout", Opt_handletimeout),
+	fsparam_u32("snapshot", Opt_snapshot),
+	fsparam_u32("max_channels", Opt_max_channels),
+
+	/* Mount options which take string value */
+	fsparam_string("source", Opt_source),
+	fsparam_string("unc", Opt_source),
+	fsparam_string("user", Opt_user),
+	fsparam_string("username", Opt_user),
+	fsparam_string("pass", Opt_pass),
+	fsparam_string("password", Opt_pass),
+	fsparam_string("ip", Opt_ip),
+	fsparam_string("addr", Opt_ip),
+	fsparam_string("domain", Opt_domain),
+	fsparam_string("dom", Opt_domain),
+	fsparam_string("srcaddr", Opt_srcaddr),
+	fsparam_string("iocharset", Opt_iocharset),
+	fsparam_string("netbiosname", Opt_netbiosname),
+	fsparam_string("servern", Opt_servern),
+	fsparam_string("ver", Opt_ver),
+	fsparam_string("vers", Opt_vers),
+	fsparam_string("sec", Opt_sec),
+	fsparam_string("cache", Opt_cache),
+
+	/* Arguments that should be ignored */
+	fsparam_flag("guest", Opt_ignore),
+	fsparam_flag("noatime", Opt_ignore),
+	fsparam_flag("relatime", Opt_ignore),
+	fsparam_flag("_netdev", Opt_ignore),
+	fsparam_flag_no("suid", Opt_ignore),
+	fsparam_flag_no("exec", Opt_ignore),
+	fsparam_flag_no("dev", Opt_ignore),
+	fsparam_flag_no("mand", Opt_ignore),
+	fsparam_string("cred", Opt_ignore),
+	fsparam_string("credentials", Opt_ignore),
+};
+
+int
+cifs_parse_security_flavors(char *value, struct smb3_fs_context *ctx)
 {
 
 	substring_t args[MAX_OPT_ARGS];
@@ -131,25 +193,25 @@ int cifs_parse_security_flavors(char *value, struct smb3_fs_context *ctx)
 		return 1;
 	case Opt_sec_krb5i:
 		ctx->sign = true;
-		fallthrough;
+		/* Fallthrough */
 	case Opt_sec_krb5:
 		ctx->sectype = Kerberos;
 		break;
 	case Opt_sec_ntlmsspi:
 		ctx->sign = true;
-		fallthrough;
+		/* Fallthrough */
 	case Opt_sec_ntlmssp:
 		ctx->sectype = RawNTLMSSP;
 		break;
 	case Opt_sec_ntlmi:
 		ctx->sign = true;
-		fallthrough;
+		/* Fallthrough */
 	case Opt_ntlm:
 		ctx->sectype = NTLM;
 		break;
 	case Opt_sec_ntlmv2i:
 		ctx->sign = true;
-		fallthrough;
+		/* Fallthrough */
 	case Opt_sec_ntlmv2:
 		ctx->sectype = NTLMv2;
 		break;
@@ -239,6 +301,7 @@ smb3_fs_context_dup(struct smb3_fs_context *new_ctx, struct smb3_fs_context *ctx
 
 	memcpy(new_ctx, ctx, sizeof(*ctx));
 	new_ctx->prepath = NULL;
+	new_ctx->mount_options = NULL;
 	new_ctx->local_nls = NULL;
 	new_ctx->nodename = NULL;
 	new_ctx->username = NULL;
@@ -251,6 +314,7 @@ smb3_fs_context_dup(struct smb3_fs_context *new_ctx, struct smb3_fs_context *ctx
 	 * Make sure to stay in sync with cifs_cleanup_volume_info_contents()
 	 */
 	DUP_CTX_STR(prepath);
+	DUP_CTX_STR(mount_options);
 	DUP_CTX_STR(username);
 	DUP_CTX_STR(password);
 	DUP_CTX_STR(UNC);
@@ -261,6 +325,77 @@ smb3_fs_context_dup(struct smb3_fs_context *new_ctx, struct smb3_fs_context *ctx
 	return rc;
 }
 
+static int
+cifs_parse_smb_version(char *value, struct smb3_fs_context *ctx, bool is_smb3)
+{
+	substring_t args[MAX_OPT_ARGS];
+
+	switch (match_token(value, cifs_smb_version_tokens, args)) {
+#ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
+	case Smb_1:
+		if (disable_legacy_dialects) {
+			cifs_dbg(VFS, "mount with legacy dialect disabled\n");
+			return 1;
+		}
+		if (is_smb3) {
+			cifs_dbg(VFS, "vers=1.0 (cifs) not permitted when mounting with smb3\n");
+			return 1;
+		}
+		cifs_dbg(VFS, "Use of the less secure dialect vers=1.0 is not recommended unless required for access to very old servers\n");
+		ctx->ops = &smb1_operations;
+		ctx->vals = &smb1_values;
+		break;
+	case Smb_20:
+		if (disable_legacy_dialects) {
+			cifs_dbg(VFS, "mount with legacy dialect disabled\n");
+			return 1;
+		}
+		if (is_smb3) {
+			cifs_dbg(VFS, "vers=2.0 not permitted when mounting with smb3\n");
+			return 1;
+		}
+		ctx->ops = &smb20_operations;
+		ctx->vals = &smb20_values;
+		break;
+#else
+	case Smb_1:
+		cifs_dbg(VFS, "vers=1.0 (cifs) mount not permitted when legacy dialects disabled\n");
+		return 1;
+	case Smb_20:
+		cifs_dbg(VFS, "vers=2.0 mount not permitted when legacy dialects disabled\n");
+		return 1;
+#endif /* CIFS_ALLOW_INSECURE_LEGACY */
+	case Smb_21:
+		ctx->ops = &smb21_operations;
+		ctx->vals = &smb21_values;
+		break;
+	case Smb_30:
+		ctx->ops = &smb30_operations;
+		ctx->vals = &smb30_values;
+		break;
+	case Smb_302:
+		ctx->ops = &smb30_operations; /* currently identical with 3.0 */
+		ctx->vals = &smb302_values;
+		break;
+	case Smb_311:
+		ctx->ops = &smb311_operations;
+		ctx->vals = &smb311_values;
+		break;
+	case Smb_3any:
+		ctx->ops = &smb30_operations; /* currently identical with 3.0 */
+		ctx->vals = &smb3any_values;
+		break;
+	case Smb_default:
+		ctx->ops = &smb30_operations; /* currently identical with 3.0 */
+		ctx->vals = &smbdefault_values;
+		break;
+	default:
+		cifs_dbg(VFS, "Unknown vers= option specified: %s\n", value);
+		return 1;
+	}
+	return 0;
+}
+
 /*
  * Parse a devname into substrings and populate the ctx->UNC and ctx->prepath
  * fields with the result. Returns 0 on success and an error otherwise.
@@ -316,3 +451,783 @@ smb3_parse_devname(const char *devname, struct smb3_fs_context *ctx)
 	return 0;
 }
 
+static void smb3_fs_context_free(struct fs_context *fc);
+static int smb3_fs_context_parse_param(struct fs_context *fc,
+				       struct fs_parameter *param);
+static int smb3_fs_context_parse_monolithic(struct fs_context *fc,
+					    void *data);
+static int smb3_get_tree(struct fs_context *fc);
+static int smb3_reconfigure(struct fs_context *fc);
+
+static const struct fs_context_operations smb3_fs_context_ops = {
+	.free			= smb3_fs_context_free,
+	.parse_param		= smb3_fs_context_parse_param,
+	.parse_monolithic	= smb3_fs_context_parse_monolithic,
+	.get_tree		= smb3_get_tree,
+	.reconfigure		= smb3_reconfigure,
+};
+
+/*
+ * Parse a monolithic block of data from sys_mount().
+ * smb3_fs_context_parse_monolithic - Parse key[=val][,key[=val]]* mount data
+ * @ctx: The superblock configuration to fill in.
+ * @data: The data to parse
+ *
+ * Parse a blob of data that's in key[=val][,key[=val]]* form.  This can be
+ * called from the ->monolithic_mount_data() fs_context operation.
+ *
+ * Returns 0 on success or the error returned by the ->parse_option() fs_context
+ * operation on failure.
+ */
+static int smb3_fs_context_parse_monolithic(struct fs_context *fc,
+					   void *data)
+{
+	struct smb3_fs_context *ctx = smb3_fc2context(fc);
+	char *options = data, *key;
+	int ret = 0;
+
+	if (!options)
+		return 0;
+
+	ctx->mount_options = kstrdup(data, GFP_KERNEL);
+	if (ctx->mount_options == NULL)
+		return -ENOMEM;
+
+	ret = security_sb_eat_lsm_opts(options, &fc->security);
+	if (ret)
+		return ret;
+
+	/* BB Need to add support for sep= here TBD */
+	while ((key = strsep(&options, ",")) != NULL) {
+		if (*key) {
+			size_t v_len = 0;
+			char *value = strchr(key, '=');
+
+			if (value) {
+				if (value == key)
+					continue;
+				*value++ = 0;
+				v_len = strlen(value);
+			}
+			ret = vfs_parse_fs_string(fc, key, value, v_len);
+			if (ret < 0)
+				break;
+		}
+	}
+
+	return ret;
+}
+
+/*
+ * Validate the preparsed information in the config.
+ */
+static int smb3_fs_context_validate(struct fs_context *fc)
+{
+	struct smb3_fs_context *ctx = smb3_fc2context(fc);
+
+	if (ctx->rdma && ctx->vals->protocol_id < SMB30_PROT_ID) {
+		cifs_dbg(VFS, "SMB Direct requires Version >=3.0\n");
+		return -1;
+	}
+
+#ifndef CONFIG_KEYS
+	/* Muliuser mounts require CONFIG_KEYS support */
+	if (ctx->multiuser) {
+		cifs_dbg(VFS, "Multiuser mounts require kernels with CONFIG_KEYS enabled\n");
+		return -1;
+	}
+#endif
+
+	if (ctx->got_version == false)
+		pr_warn_once("No dialect specified on mount. Default has changed to a more secure dialect, SMB2.1 or later (e.g. SMB3.1.1), from CIFS (SMB1). To use the less secure SMB1 dialect to access old servers which do not support SMB3.1.1 (or even SMB3 or SMB2.1) specify vers=1.0 on mount.\n");
+
+
+	if (!ctx->UNC) {
+		cifs_dbg(VFS, "CIFS mount error: No usable UNC path provided in device string!\n");
+		return -1;
+	}
+
+	/* make sure UNC has a share name */
+	if (strlen(ctx->UNC) < 3 || !strchr(ctx->UNC + 3, '\\')) {
+		cifs_dbg(VFS, "Malformed UNC. Unable to find share name.\n");
+		return -1;
+	}
+
+	if (!ctx->got_ip) {
+		int len;
+		const char *slash;
+
+		/* No ip= option specified? Try to get it from UNC */
+		/* Use the address part of the UNC. */
+		slash = strchr(&ctx->UNC[2], '\\');
+		len = slash - &ctx->UNC[2];
+		if (!cifs_convert_address((struct sockaddr *)&ctx->dstaddr,
+					  &ctx->UNC[2], len)) {
+			pr_err("Unable to determine destination address\n");
+			return -1;
+		}
+	}
+
+	/* set the port that we got earlier */
+	cifs_set_port((struct sockaddr *)&ctx->dstaddr, ctx->port);
+
+	if (ctx->override_uid && !ctx->uid_specified) {
+		ctx->override_uid = 0;
+		pr_notice("ignoring forceuid mount option specified with no uid= option\n");
+	}
+
+	if (ctx->override_gid && !ctx->gid_specified) {
+		ctx->override_gid = 0;
+		pr_notice("ignoring forcegid mount option specified with no gid= option\n");
+	}
+
+	return 0;
+}
+
+static int smb3_get_tree_common(struct fs_context *fc)
+{
+	struct smb3_fs_context *ctx = smb3_fc2context(fc);
+	struct dentry *root;
+	int rc = 0;
+
+	root = cifs_smb3_do_mount(fc->fs_type, 0, ctx);
+	if (IS_ERR(root))
+		return PTR_ERR(root);
+
+	fc->root = root;
+
+	return rc;
+}
+
+/*
+ * Create an SMB3 superblock from the parameters passed.
+ */
+static int smb3_get_tree(struct fs_context *fc)
+{
+	int err = smb3_fs_context_validate(fc);
+
+	if (err)
+		return err;
+	return smb3_get_tree_common(fc);
+}
+
+static void smb3_fs_context_free(struct fs_context *fc)
+{
+	struct smb3_fs_context *ctx = smb3_fc2context(fc);
+
+	cifs_cleanup_volume_info(ctx);		
+}
+
+static int smb3_reconfigure(struct fs_context *fc)
+{
+	// TODO:  struct smb3_fs_context *ctx = smb3_fc2context(fc);
+
+	/* FIXME : add actual reconfigure */
+	return 0;
+}
+
+static int smb3_fs_context_parse_param(struct fs_context *fc,
+				      struct fs_parameter *param)
+{
+	struct fs_parse_result result;
+	struct smb3_fs_context *ctx = smb3_fc2context(fc);
+	int i, opt;
+	bool is_smb3 = !strcmp(fc->fs_type->name, "smb3");
+	bool skip_parsing = false;
+
+	cifs_dbg(FYI, "CIFS: parsing cifs mount option '%s'\n", param->key);
+
+	/*
+	 * fs_parse can not handle string options with an empty value so
+	 * we will need special handling of them.
+	 */
+	if (param->type == fs_value_is_string && param->string[0] == 0) {
+		if (!strcmp("pass", param->key) || !strcmp("password", param->key))
+			skip_parsing = true;
+	}
+
+	if (!skip_parsing) {
+		opt = fs_parse(fc, smb3_fs_parameters, param, &result);
+		if (opt < 0)
+			return ctx->sloppy ? 1 : opt;
+	}
+
+	switch (opt) {
+	case Opt_compress:
+		ctx->compression = UNKNOWN_TYPE;
+		cifs_dbg(VFS,
+			"SMB3 compression support is experimental\n");
+		break;
+	case Opt_nodfs:
+		ctx->nodfs = 1;
+		break;
+	case Opt_hard:
+		if (result.negated)
+			ctx->retry = 0;
+		else
+			ctx->retry = 1;
+		break;
+	case Opt_soft:
+		if (result.negated)
+			ctx->retry = 1;
+		else
+			ctx->retry = 0;
+		break;
+	case Opt_mapposix:
+		if (result.negated)
+			ctx->remap = false;
+		else {
+			ctx->remap = true;
+			ctx->sfu_remap = false; /* disable SFU mapping */
+		}
+		break;
+	case Opt_user_xattr:
+		if (result.negated)
+			ctx->no_xattr = 1;
+		else
+			ctx->no_xattr = 0;
+		break;
+	case Opt_forceuid:
+		if (result.negated)
+			ctx->override_uid = 0;
+		else
+			ctx->override_uid = 1;
+		break;
+	case Opt_forcegid:
+		if (result.negated)
+			ctx->override_gid = 0;
+		else
+			ctx->override_gid = 1;
+		break;
+	case Opt_perm:
+		if (result.negated)
+			ctx->noperm = 1;
+		else
+			ctx->noperm = 0;
+		break;
+	case Opt_dynperm:
+		if (result.negated)
+			ctx->dynperm = 0;
+		else
+			ctx->dynperm = 1;
+		break;
+	case Opt_sfu:
+		if (result.negated)
+			ctx->sfu_emul = 0;
+		else
+			ctx->sfu_emul = 1;
+		break;
+	case Opt_noblocksend:
+		ctx->noblocksnd = 1;
+		break;
+	case Opt_noautotune:
+		ctx->noautotune = 1;
+		break;
+	case Opt_nolease:
+		ctx->no_lease = 1;
+		break;
+	case Opt_nodelete:
+		ctx->nodelete = 1;
+		break;
+	case Opt_multichannel:
+		if (result.negated) {
+			ctx->multichannel = false;
+			ctx->max_channels = 1;
+		} else {
+			ctx->multichannel = true;
+			/* if number of channels not specified, default to 2 */
+			if (ctx->max_channels < 2)
+				ctx->max_channels = 2;
+		}
+		break;
+	case Opt_uid:
+		ctx->linux_uid.val = result.uint_32;
+		ctx->uid_specified = true;
+		break;
+	case Opt_cruid:
+		ctx->cred_uid.val = result.uint_32;
+		break;
+	case Opt_backupgid:
+		ctx->backupgid.val = result.uint_32;
+		ctx->backupgid_specified = true;
+		break;
+	case Opt_gid:
+		ctx->linux_gid.val = result.uint_32;
+		ctx->gid_specified = true;
+		break;
+	case Opt_port:
+		ctx->port = result.uint_32;
+		break;
+	case Opt_file_mode:
+		ctx->file_mode = result.uint_32;
+		break;
+	case Opt_dirmode:
+		ctx->dir_mode = result.uint_32;
+		break;
+	case Opt_min_enc_offload:
+		ctx->min_offload = result.uint_32;
+		break;
+	case Opt_blocksize:
+		/*
+		 * inode blocksize realistically should never need to be
+		 * less than 16K or greater than 16M and default is 1MB.
+		 * Note that small inode block sizes (e.g. 64K) can lead
+		 * to very poor performance of common tools like cp and scp
+		 */
+		if ((result.uint_32 < CIFS_MAX_MSGSIZE) ||
+		   (result.uint_32 > (4 * SMB3_DEFAULT_IOSIZE))) {
+			cifs_dbg(VFS, "%s: Invalid blocksize\n",
+				__func__);
+			goto cifs_parse_mount_err;
+		}
+		ctx->bsize = result.uint_32;
+		break;
+	case Opt_rsize:
+		ctx->rsize = result.uint_32;
+		break;
+	case Opt_wsize:
+		ctx->wsize = result.uint_32;
+		break;
+	case Opt_actimeo:
+		ctx->actimeo = HZ * result.uint_32;
+		if (ctx->actimeo > CIFS_MAX_ACTIMEO) {
+			cifs_dbg(VFS, "attribute cache timeout too large\n");
+			goto cifs_parse_mount_err;
+		}
+		break;
+	case Opt_echo_interval:
+		ctx->echo_interval = result.uint_32;
+		break;
+	case Opt_snapshot:
+		ctx->snapshot_time = result.uint_32;
+		break;
+	case Opt_max_credits:
+		if (result.uint_32 < 20 || result.uint_32 > 60000) {
+			cifs_dbg(VFS, "%s: Invalid max_credits value\n",
+				 __func__);
+			goto cifs_parse_mount_err;
+		}
+		ctx->max_credits = result.uint_32;
+		break;
+	case Opt_max_channels:
+		if (result.uint_32 < 1 || result.uint_32 > CIFS_MAX_CHANNELS) {
+			cifs_dbg(VFS, "%s: Invalid max_channels value, needs to be 1-%d\n",
+				 __func__, CIFS_MAX_CHANNELS);
+			goto cifs_parse_mount_err;
+		}
+		ctx->max_channels = result.uint_32;
+		break;
+	case Opt_handletimeout:
+		ctx->handle_timeout = result.uint_32;
+		if (ctx->handle_timeout > SMB3_MAX_HANDLE_TIMEOUT) {
+			cifs_dbg(VFS, "Invalid handle cache timeout, longer than 16 minutes\n");
+			goto cifs_parse_mount_err;
+		}
+		break;
+	case Opt_source:
+		kfree(ctx->UNC);
+		ctx->UNC = NULL;
+		switch (smb3_parse_devname(param->string, ctx)) {
+		case 0:
+			break;
+		case -ENOMEM:
+			cifs_dbg(VFS, "Unable to allocate memory for devname\n");
+			goto cifs_parse_mount_err;
+		case -EINVAL:
+			cifs_dbg(VFS, "Malformed UNC in devname\n");
+			goto cifs_parse_mount_err;
+		default:
+			cifs_dbg(VFS, "Unknown error parsing devname\n");
+			goto cifs_parse_mount_err;
+		}
+		fc->source = kstrdup(param->string, GFP_KERNEL);
+		if (fc->source == NULL) {
+			cifs_dbg(VFS, "OOM when copying UNC string\n");
+			goto cifs_parse_mount_err;
+		}
+		break;
+	case Opt_user:
+		kfree(ctx->username);
+		ctx->username = NULL;
+		if (strlen(param->string) == 0) {
+			/* null user, ie. anonymous authentication */
+			ctx->nullauth = 1;
+			break;
+		}
+
+		if (strnlen(param->string, CIFS_MAX_USERNAME_LEN) >
+		    CIFS_MAX_USERNAME_LEN) {
+			pr_warn("username too long\n");
+			goto cifs_parse_mount_err;
+		}
+		ctx->username = kstrdup(param->string, GFP_KERNEL);
+		if (ctx->username == NULL) {
+			cifs_dbg(VFS, "OOM when copying username string\n");
+			goto cifs_parse_mount_err;
+		}
+		break;
+	case Opt_pass:
+		kzfree(ctx->password);
+		ctx->password = NULL;
+		if (strlen(param->string) == 0) {
+			break;
+		}
+		ctx->password = kstrdup(param->string, GFP_KERNEL);
+		if (ctx->password == NULL) {
+			cifs_dbg(VFS, "OOM when copying password string\n");
+			goto cifs_parse_mount_err;
+		}
+		break;
+	case Opt_ip:
+		if (strlen(param->string) == 0) {
+			ctx->got_ip = false;
+			break;
+		}
+		if (!cifs_convert_address((struct sockaddr *)&ctx->dstaddr,
+					  param->string,
+					  strlen(param->string))) {
+			pr_err("bad ip= option (%s)\n", param->string);
+			goto cifs_parse_mount_err;
+		}
+		ctx->got_ip = true;
+		break;
+	case Opt_domain:
+		if (strnlen(param->string, CIFS_MAX_DOMAINNAME_LEN)
+				== CIFS_MAX_DOMAINNAME_LEN) {
+			pr_warn("domain name too long\n");
+			goto cifs_parse_mount_err;
+		}
+
+		kfree(ctx->domainname);
+		ctx->domainname = kstrdup(param->string, GFP_KERNEL);
+		if (ctx->domainname == NULL) {
+			cifs_dbg(VFS, "OOM when copying domainname string\n");
+			goto cifs_parse_mount_err;
+		}
+		cifs_dbg(FYI, "Domain name set\n");
+		break;
+	case Opt_srcaddr:
+		if (!cifs_convert_address(
+				(struct sockaddr *)&ctx->srcaddr,
+				param->string, strlen(param->string))) {
+			pr_warn("Could not parse srcaddr: %s\n",
+				param->string);
+			goto cifs_parse_mount_err;
+		}
+		break;
+	case Opt_iocharset:
+		if (strnlen(param->string, 1024) >= 65) {
+			pr_warn("iocharset name too long\n");
+			goto cifs_parse_mount_err;
+		}
+
+		 if (strncasecmp(param->string, "default", 7) != 0) {
+			kfree(ctx->iocharset);
+			ctx->iocharset = kstrdup(param->string, GFP_KERNEL);
+			if (ctx->iocharset == NULL) {
+				cifs_dbg(VFS, "OOM when copying iocharset string\n");
+				goto cifs_parse_mount_err;
+			}
+		}
+		/* if iocharset not set then load_nls_default
+		 * is used by caller
+		 */
+		 cifs_dbg(FYI, "iocharset set to %s\n", ctx->iocharset);
+		break;
+	case Opt_netbiosname:
+		memset(ctx->source_rfc1001_name, 0x20,
+			RFC1001_NAME_LEN);
+		/*
+		 * FIXME: are there cases in which a comma can
+		 * be valid in workstation netbios name (and
+		 * need special handling)?
+		 */
+		for (i = 0; i < RFC1001_NAME_LEN; i++) {
+			/* don't ucase netbiosname for user */
+			if (param->string[i] == 0)
+				break;
+			ctx->source_rfc1001_name[i] = param->string[i];
+		}
+		/* The string has 16th byte zero still from
+		 * set at top of the function
+		 */
+		if (i == RFC1001_NAME_LEN && param->string[i] != 0)
+			pr_warn("netbiosname longer than 15 truncated\n");
+		break;
+	case Opt_servern:
+		/* last byte, type, is 0x20 for servr type */
+		memset(ctx->target_rfc1001_name, 0x20,
+			RFC1001_NAME_LEN_WITH_NULL);
+		/* BB are there cases in which a comma can be
+		   valid in this workstation netbios name
+		   (and need special handling)? */
+
+		/* user or mount helper must uppercase the
+		   netbios name */
+		for (i = 0; i < 15; i++) {
+			if (param->string[i] == 0)
+				break;
+			ctx->target_rfc1001_name[i] = param->string[i];
+		}
+		/* The string has 16th byte zero still from
+		   set at top of the function  */
+		if (i == RFC1001_NAME_LEN && param->string[i] != 0)
+			pr_warn("server netbiosname longer than 15 truncated\n");
+		break;
+	case Opt_ver:
+		/* version of mount userspace tools, not dialect */
+		/* If interface changes in mount.cifs bump to new ver */
+		if (strncasecmp(param->string, "1", 1) == 0) {
+			if (strlen(param->string) > 1) {
+				pr_warn("Bad mount helper ver=%s. Did you want SMB1 (CIFS) dialect and mean to type vers=1.0 instead?\n",
+					param->string);
+				goto cifs_parse_mount_err;
+			}
+			/* This is the default */
+			break;
+		}
+		/* For all other value, error */
+		pr_warn("Invalid mount helper version specified\n");
+		goto cifs_parse_mount_err;
+	case Opt_vers:
+		/* protocol version (dialect) */
+		if (cifs_parse_smb_version(param->string, ctx, is_smb3) != 0)
+			goto cifs_parse_mount_err;
+		ctx->got_version = true;
+		break;
+	case Opt_sec:
+		if (cifs_parse_security_flavors(param->string, ctx) != 0)
+			goto cifs_parse_mount_err;
+		break;
+	case Opt_cache:
+		if (cifs_parse_cache_flavor(param->string, ctx) != 0)
+			goto cifs_parse_mount_err;
+		break;
+	case Opt_rootfs:
+#ifdef CONFIG_CIFS_ROOT
+		ctx->rootfs = true;
+#endif
+		break;
+	case Opt_posixpaths:
+		if (result.negated)
+			ctx->posix_paths = 0;
+		else
+			ctx->posix_paths = 1;
+		break;
+	case Opt_unix:
+		if (result.negated)
+			ctx->linux_ext = 0;
+		else
+			ctx->no_linux_ext = 1;
+		break;
+	case Opt_nocase:
+		ctx->nocase = 1;
+		break;
+	case Opt_brl:
+		if (result.negated) {
+			/*
+			 * turn off mandatory locking in mode
+			 * if remote locking is turned off since the
+			 * local vfs will do advisory
+			 */
+			if (ctx->file_mode ==
+				(S_IALLUGO & ~(S_ISUID | S_IXGRP)))
+				ctx->file_mode = S_IALLUGO;
+			ctx->nobrl =  1;
+		} else
+			ctx->nobrl =  0;
+		break;
+	case Opt_handlecache:
+		if (result.negated)
+			ctx->nohandlecache = 1;
+		else
+			ctx->nohandlecache = 0;
+		break;
+	case Opt_forcemandatorylock:
+		ctx->mand_lock = 1;
+		break;
+	case Opt_setuids:
+		ctx->setuids = result.negated;
+		break;
+	case Opt_intr:
+		ctx->intr = !result.negated;
+		break;
+	case Opt_setuidfromacl:
+		ctx->setuidfromacl = 1;
+		break;
+	case Opt_strictsync:
+		ctx->nostrictsync = result.negated;
+		break;
+	case Opt_serverino:
+		ctx->server_ino = !result.negated;
+		break;
+	case Opt_rwpidforward:
+		ctx->rwpidforward = 1;
+		break;
+	case Opt_modesid:
+		ctx->mode_ace = 1;
+		break;
+	case Opt_cifsacl:
+		ctx->cifs_acl = !result.negated;
+		break;
+	case Opt_acl:
+		ctx->no_psx_acl = result.negated;
+		break;
+	case Opt_locallease:
+		ctx->local_lease = 1;
+		break;
+	case Opt_sign:
+		ctx->sign = true;
+		break;
+	case Opt_ignore_signature:
+		ctx->sign = true;
+		ctx->ignore_signature = true;
+		break;
+	case Opt_seal:
+		/* we do not do the following in secFlags because seal
+		 * is a per tree connection (mount) not a per socket
+		 * or per-smb connection option in the protocol
+		 * vol->secFlg |= CIFSSEC_MUST_SEAL;
+		 */
+		ctx->seal = 1;
+		break;
+	case Opt_noac:
+		pr_warn("Mount option noac not supported. Instead set /proc/fs/cifs/LookupCacheEnabled to 0\n");
+		break;
+	case Opt_fsc:
+#ifndef CONFIG_CIFS_FSCACHE
+		cifs_dbg(VFS, "FS-Cache support needs CONFIG_CIFS_FSCACHE kernel config option set\n");
+		goto cifs_parse_mount_err;
+#endif
+		ctx->fsc = true;
+		break;
+	case Opt_mfsymlinks:
+		ctx->mfsymlinks = true;
+		break;
+	case Opt_multiuser:
+		ctx->multiuser = true;
+		break;
+	case Opt_sloppy:
+		ctx->sloppy = true;
+		break;
+	case Opt_nosharesock:
+		ctx->nosharesock = true;
+		break;
+	case Opt_persistent:
+		if (result.negated) {
+			if ((ctx->nopersistent) || (ctx->resilient)) {
+				cifs_dbg(VFS,
+				  "persistenthandles mount options conflict\n");
+				goto cifs_parse_mount_err;
+			}
+		} else {
+			ctx->nopersistent = true;
+			if (ctx->persistent) {
+				cifs_dbg(VFS,
+				  "persistenthandles mount options conflict\n");
+				goto cifs_parse_mount_err;
+			}
+		}
+		break;
+	case Opt_resilient:
+		if (result.negated) {
+			ctx->resilient = false; /* already the default */
+		} else {
+			ctx->resilient = true;
+			if (ctx->persistent) {
+				cifs_dbg(VFS,
+				  "persistenthandles mount options conflict\n");
+				goto cifs_parse_mount_err;
+			}
+		}
+		break;
+	case Opt_domainauto:
+		ctx->domainauto = true;
+		break;
+	case Opt_rdma:
+		ctx->rdma = true;
+		break;
+	}
+
+	return 0;
+
+ cifs_parse_mount_err:
+	return 1;
+}
+
+int smb3_init_fs_context(struct fs_context *fc)
+{
+	struct smb3_fs_context *ctx;
+	char *nodename = utsname()->nodename;
+	int i;
+
+	ctx = kzalloc(sizeof(struct smb3_fs_context), GFP_KERNEL);
+	if (unlikely(!ctx))
+		return -ENOMEM;
+
+	/*
+	 * does not have to be perfect mapping since field is
+	 * informational, only used for servers that do not support
+	 * port 445 and it can be overridden at mount time
+	 */
+	memset(ctx->source_rfc1001_name, 0x20, RFC1001_NAME_LEN);
+	for (i = 0; i < strnlen(nodename, RFC1001_NAME_LEN); i++)
+		ctx->source_rfc1001_name[i] = toupper(nodename[i]);
+
+	ctx->source_rfc1001_name[RFC1001_NAME_LEN] = 0;
+	/* null target name indicates to use *SMBSERVR default called name
+	   if we end up sending RFC1001 session initialize */
+	ctx->target_rfc1001_name[0] = 0;
+	ctx->cred_uid = current_uid();
+	ctx->linux_uid = current_uid();
+	ctx->linux_gid = current_gid();
+	ctx->bsize = 1024 * 1024; /* can improve cp performance significantly */
+
+	/*
+	 * default to SFM style remapping of seven reserved characters
+	 * unless user overrides it or we negotiate CIFS POSIX where
+	 * it is unnecessary.  Can not simultaneously use more than one mapping
+	 * since then readdir could list files that open could not open
+	 */
+	ctx->remap = true;
+
+	/* default to only allowing write access to owner of the mount */
+	ctx->dir_mode = ctx->file_mode = S_IRUGO | S_IXUGO | S_IWUSR;
+
+	/* ctx->retry default is 0 (i.e. "soft" limited retry not hard retry) */
+	/* default is always to request posix paths. */
+	ctx->posix_paths = 1;
+	/* default to using server inode numbers where available */
+	ctx->server_ino = 1;
+
+	/* default is to use strict cifs caching semantics */
+	ctx->strict_io = true;
+
+	ctx->actimeo = CIFS_DEF_ACTIMEO;
+
+	/* Most clients set timeout to 0, allows server to use its default */
+	ctx->handle_timeout = 0; /* See MS-SMB2 spec section 2.2.14.2.12 */
+
+	/* offer SMB2.1 and later (SMB3 etc). Secure and widely accepted */
+	ctx->ops = &smb30_operations;
+	ctx->vals = &smbdefault_values;
+
+	ctx->echo_interval = SMB_ECHO_INTERVAL_DEFAULT;
+
+	/* default to no multichannel (single server connection) */
+	ctx->multichannel = false;
+	ctx->max_channels = 1;
+
+	ctx->backupuid_specified = false; /* no backup intent for a user */
+	ctx->backupgid_specified = false; /* no backup intent for a group */
+
+/*	short int override_uid = -1;
+	short int override_gid = -1;
+	char *nodename = strdup(utsname()->nodename);
+	struct sockaddr *dstaddr = (struct sockaddr *)&vol->dstaddr;
+*/
+
+	fc->fs_private = ctx;
+	fc->ops = &smb3_fs_context_ops;
+	return 0;
+}
diff --git a/fs/cifs/fs_context.h b/fs/cifs/fs_context.h
index 3a66199f3cb7..6e98ef526895 100644
--- a/fs/cifs/fs_context.h
+++ b/fs/cifs/fs_context.h
@@ -9,8 +9,11 @@
 #ifndef _FS_CONTEXT_H
 #define _FS_CONTEXT_H
 
-#include <linux/parser.h>
 #include "cifsglob.h"
+#include <linux/parser.h>
+#include <linux/fs_parser.h>
+
+#define cifs_invalf(fc, fmt, ...) invalf(fc, fmt, ## __VA_ARGS__)
 
 enum smb_version {
 	Smb_1 = 1,
@@ -24,8 +27,6 @@ enum smb_version {
 	Smb_version_err
 };
 
-int cifs_parse_smb_version(char *value, struct smb3_fs_context *ctx, bool is_smb3);
-
 enum {
 	Opt_cache_loose,
 	Opt_cache_strict,
@@ -35,8 +36,6 @@ enum {
 	Opt_cache_err
 };
 
-int cifs_parse_cache_flavor(char *value, struct smb3_fs_context *ctx);
-
 enum cifs_sec_param {
 	Opt_sec_krb5,
 	Opt_sec_krb5i,
@@ -55,36 +54,36 @@ enum cifs_sec_param {
 
 enum cifs_param {
 	/* Mount options that take no arguments */
-	Opt_user_xattr, Opt_nouser_xattr,
-	Opt_forceuid, Opt_noforceuid,
-	Opt_forcegid, Opt_noforcegid,
+	Opt_user_xattr,
+	Opt_forceuid,
+	Opt_forcegid,
 	Opt_noblocksend,
 	Opt_noautotune,
 	Opt_nolease,
-	Opt_hard, Opt_nohard,
-	Opt_soft, Opt_nosoft,
-	Opt_perm, Opt_noperm,
+	Opt_hard,
+	Opt_soft,
+	Opt_perm,
 	Opt_nodelete,
-	Opt_mapposix, Opt_nomapposix,
+	Opt_mapposix,
 	Opt_mapchars,
 	Opt_nomapchars,
-	Opt_sfu, Opt_nosfu,
+	Opt_sfu,
 	Opt_nodfs,
-	Opt_posixpaths, Opt_noposixpaths,
-	Opt_unix, Opt_nounix,
+	Opt_posixpaths,
+	Opt_unix,
 	Opt_nocase,
-	Opt_brl, Opt_nobrl,
-	Opt_handlecache, Opt_nohandlecache,
+	Opt_brl,
+	Opt_handlecache,
 	Opt_forcemandatorylock,
 	Opt_setuidfromacl,
-	Opt_setuids, Opt_nosetuids,
-	Opt_dynperm, Opt_nodynperm,
-	Opt_intr, Opt_nointr,
-	Opt_strictsync, Opt_nostrictsync,
-	Opt_serverino, Opt_noserverino,
+	Opt_setuids,
+	Opt_dynperm,
+	Opt_intr,
+	Opt_strictsync,
+	Opt_serverino,
 	Opt_rwpidforward,
-	Opt_cifsacl, Opt_nocifsacl,
-	Opt_acl, Opt_noacl,
+	Opt_cifsacl,
+	Opt_acl,
 	Opt_locallease,
 	Opt_sign,
 	Opt_ignore_signature,
@@ -95,13 +94,13 @@ enum cifs_param {
 	Opt_multiuser,
 	Opt_sloppy,
 	Opt_nosharesock,
-	Opt_persistent, Opt_nopersistent,
-	Opt_resilient, Opt_noresilient,
+	Opt_persistent,
+	Opt_resilient,
 	Opt_domainauto,
 	Opt_rdma,
 	Opt_modesid,
 	Opt_rootfs,
-	Opt_multichannel, Opt_nomultichannel,
+	Opt_multichannel,
 	Opt_compress,
 
 	/* Mount options which take numeric value */
@@ -142,11 +141,6 @@ enum cifs_param {
 	/* Mount options to be ignored */
 	Opt_ignore,
 
-	/* Options which could be blank */
-	Opt_blank_pass,
-	Opt_blank_user,
-	Opt_blank_ip,
-
 	Opt_err
 };
 
@@ -247,9 +241,24 @@ struct smb3_fs_context {
 	unsigned int max_channels;
 	__u16 compression; /* compression algorithm 0xFFFF default 0=disabled */
 	bool rootfs:1; /* if it's a SMB root file system */
+
+	char *mount_options;
 };
 
-extern int cifs_parse_security_flavors(char *value, struct smb3_fs_context *ctx);
+extern const struct fs_parameter_spec smb3_fs_parameters[];
+
+extern int cifs_parse_cache_flavor(char *value,
+				   struct smb3_fs_context *ctx);
+extern int cifs_parse_security_flavors(char *value,
+				       struct smb3_fs_context *ctx);
+extern int smb3_init_fs_context(struct fs_context *fc);
+
+static inline struct smb3_fs_context *smb3_fc2context(const struct fs_context *fc \
+						    )
+{
+  return fc->fs_private;
+}
+
 extern int smb3_fs_context_dup(struct smb3_fs_context *new_ctx, struct smb3_fs_context *ctx);
 
 #endif
diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index f2055f99cc7b..b0e4bf2cd473 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -195,7 +195,7 @@ cifs_ses_add_channel(struct cifs_ses *ses, struct cifs_server_iface *iface)
 	 * We need to setup at least the fields used for negprot and
 	 * sesssetup.
 	 *
-	 * We only need the volume here, so we can reuse memory from
+	 * We only need the ctx here, so we can reuse memory from
 	 * the session and server without caring about memory
 	 * management.
 	 */
-- 
2.13.6

