Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A55E167A6E
	for <lists+linux-cifs@lfdr.de>; Fri, 21 Feb 2020 11:19:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727150AbgBUKTP (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 21 Feb 2020 05:19:15 -0500
Received: from mx2.suse.de ([195.135.220.15]:38206 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726989AbgBUKTP (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Fri, 21 Feb 2020 05:19:15 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 88407AD3C;
        Fri, 21 Feb 2020 10:19:11 +0000 (UTC)
From:   Aurelien Aptel <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH] cifs: fix rename() by ensuring source handle opened with DELETE bit
Date:   Fri, 21 Feb 2020 11:19:06 +0100
Message-Id: <20200221101906.24023-1-aaptel@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

To rename a file in SMB2 we open it with the DELETE access and do a
special SetInfo on it. If the handle is missing the DELETE bit the
server will fail the SetInfo with STATUS_ACCESS_DENIED.

We currently try to reuse any existing opened handle we have with
cifs_get_writable_path(). That function looks for handles with WRITE
access but doesn't check for DELETE, making rename() fail if it finds
a handle to reuse. Simple reproducer below.

To select handles with the DELETE bit, this patch adds a flag argument
to cifs_get_writable_path() and find_writable_file() and the existing
'bool fsuid_only' argument is converted to a flag.

The cifsFileInfo struct only stores the UNIX open mode but not the
original SMB access flags. Since the DELETE bit is not mapped in that
mode, this patch stores the access mask in cifs_fid on file open,
which is accessible from cifsFileInfo.

Simple reproducer:

	#include <stdio.h>
	#include <stdlib.h>
	#include <sys/types.h>
	#include <sys/stat.h>
	#include <fcntl.h>
	#include <unistd.h>
	#define E(s) perror(s), exit(1)

	int main(int argc, char *argv[])
	{
		int fd, ret;
		if (argc != 3) {
			fprintf(stderr, "Usage: %s A B\n"
			"create&open A in write mode, "
			"rename A to B, close A\n", argv[0]);
			return 0;
		}

		fd = openat(AT_FDCWD, argv[1], O_WRONLY|O_CREAT|O_SYNC, 0666);
		if (fd == -1) E("openat()");

		ret = rename(argv[1], argv[2]);
		if (ret) E("rename()");

		ret = close(fd);
		if (ret) E("close()");

		return ret;
	}

$ gcc -o bugrename bugrename.c
$ ./bugrename /mnt/a /mnt/b
rename(): Permission denied

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 fs/cifs/cifsglob.h  |  7 +++++++
 fs/cifs/cifsproto.h |  5 +++--
 fs/cifs/cifssmb.c   |  3 ++-
 fs/cifs/file.c      | 19 ++++++++++++-------
 fs/cifs/inode.c     |  6 +++---
 fs/cifs/smb1ops.c   |  2 +-
 fs/cifs/smb2inode.c |  4 ++--
 fs/cifs/smb2ops.c   |  3 ++-
 fs/cifs/smb2pdu.c   |  1 +
 9 files changed, 33 insertions(+), 17 deletions(-)

diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index 0908060e1cdc..3435d2ac4e37 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -1286,6 +1286,7 @@ struct cifs_fid {
 	__u64 volatile_fid;	/* volatile file id for smb2 */
 	__u8 lease_key[SMB2_LEASE_KEY_SIZE];	/* lease key for smb2 */
 	__u8 create_guid[16];
+	__u32 access;
 	struct cifs_pending_open *pending_open;
 	unsigned int epoch;
 #ifdef CONFIG_CIFS_DEBUG2
@@ -1746,6 +1747,12 @@ static inline bool is_retryable_error(int error)
 	return false;
 }
 
+
+/* cifs_get_writable_file() flags */
+#define FIND_WR_ANY         0
+#define FIND_WR_FSUID_ONLY  1
+#define FIND_WR_WITH_DELETE 2
+
 #define   MID_FREE 0
 #define   MID_REQUEST_ALLOCATED 1
 #define   MID_REQUEST_SUBMITTED 2
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index c3295076414b..af84d526b61b 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -134,11 +134,12 @@ extern bool backup_cred(struct cifs_sb_info *);
 extern bool is_size_safe_to_change(struct cifsInodeInfo *, __u64 eof);
 extern void cifs_update_eof(struct cifsInodeInfo *cifsi, loff_t offset,
 			    unsigned int bytes_written);
-extern struct cifsFileInfo *find_writable_file(struct cifsInodeInfo *, bool);
+extern struct cifsFileInfo *find_writable_file(struct cifsInodeInfo *, int);
 extern int cifs_get_writable_file(struct cifsInodeInfo *cifs_inode,
-				  bool fsuid_only,
+				  int flags,
 				  struct cifsFileInfo **ret_file);
 extern int cifs_get_writable_path(struct cifs_tcon *tcon, const char *name,
+				  int flags,
 				  struct cifsFileInfo **ret_file);
 extern struct cifsFileInfo *find_readable_file(struct cifsInodeInfo *, bool);
 extern int cifs_get_readable_path(struct cifs_tcon *tcon, const char *name,
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 3c89569e7210..6f6fb3606a5d 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -1492,6 +1492,7 @@ CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms, int *oplock,
 	*oplock = rsp->OplockLevel;
 	/* cifs fid stays in le */
 	oparms->fid->netfid = rsp->Fid;
+	oparms->fid->access = desired_access;
 
 	/* Let caller know file was created so we can set the mode. */
 	/* Do we care about the CreateAction in any other cases? */
@@ -2115,7 +2116,7 @@ cifs_writev_requeue(struct cifs_writedata *wdata)
 		wdata2->tailsz = tailsz;
 		wdata2->bytes = cur_len;
 
-		rc = cifs_get_writable_file(CIFS_I(inode), false,
+		rc = cifs_get_writable_file(CIFS_I(inode), FIND_WR_ANY,
 					    &wdata2->cfile);
 		if (!wdata2->cfile) {
 			cifs_dbg(VFS, "No writable handle to retry writepages rc=%d\n",
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 83026ec7f7b8..15804f18856d 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -1961,7 +1961,7 @@ struct cifsFileInfo *find_readable_file(struct cifsInodeInfo *cifs_inode,
 
 /* Return -EBADF if no handle is found and general rc otherwise */
 int
-cifs_get_writable_file(struct cifsInodeInfo *cifs_inode, bool fsuid_only,
+cifs_get_writable_file(struct cifsInodeInfo *cifs_inode, int flags,
 		       struct cifsFileInfo **ret_file)
 {
 	struct cifsFileInfo *open_file, *inv_file = NULL;
@@ -1969,7 +1969,8 @@ cifs_get_writable_file(struct cifsInodeInfo *cifs_inode, bool fsuid_only,
 	bool any_available = false;
 	int rc = -EBADF;
 	unsigned int refind = 0;
-
+	bool fsuid_only = flags & FIND_WR_FSUID_ONLY;
+	bool with_delete = flags & FIND_WR_WITH_DELETE;
 	*ret_file = NULL;
 
 	/*
@@ -2001,6 +2002,8 @@ cifs_get_writable_file(struct cifsInodeInfo *cifs_inode, bool fsuid_only,
 			continue;
 		if (fsuid_only && !uid_eq(open_file->uid, current_fsuid()))
 			continue;
+		if (with_delete && !(open_file->fid.access & DELETE))
+			continue;
 		if (OPEN_FMODE(open_file->f_flags) & FMODE_WRITE) {
 			if (!open_file->invalidHandle) {
 				/* found a good writable file */
@@ -2048,12 +2051,12 @@ cifs_get_writable_file(struct cifsInodeInfo *cifs_inode, bool fsuid_only,
 }
 
 struct cifsFileInfo *
-find_writable_file(struct cifsInodeInfo *cifs_inode, bool fsuid_only)
+find_writable_file(struct cifsInodeInfo *cifs_inode, int flags)
 {
 	struct cifsFileInfo *cfile;
 	int rc;
 
-	rc = cifs_get_writable_file(cifs_inode, fsuid_only, &cfile);
+	rc = cifs_get_writable_file(cifs_inode, flags, &cfile);
 	if (rc)
 		cifs_dbg(FYI, "couldn't find writable handle rc=%d", rc);
 
@@ -2062,6 +2065,7 @@ find_writable_file(struct cifsInodeInfo *cifs_inode, bool fsuid_only)
 
 int
 cifs_get_writable_path(struct cifs_tcon *tcon, const char *name,
+		       int flags,
 		       struct cifsFileInfo **ret_file)
 {
 	struct list_head *tmp;
@@ -2088,7 +2092,7 @@ cifs_get_writable_path(struct cifs_tcon *tcon, const char *name,
 		kfree(full_path);
 		cinode = CIFS_I(d_inode(cfile->dentry));
 		spin_unlock(&tcon->open_file_lock);
-		return cifs_get_writable_file(cinode, 0, ret_file);
+		return cifs_get_writable_file(cinode, flags, ret_file);
 	}
 
 	spin_unlock(&tcon->open_file_lock);
@@ -2165,7 +2169,8 @@ static int cifs_partialpagewrite(struct page *page, unsigned from, unsigned to)
 	if (mapping->host->i_size - offset < (loff_t)to)
 		to = (unsigned)(mapping->host->i_size - offset);
 
-	rc = cifs_get_writable_file(CIFS_I(mapping->host), false, &open_file);
+	rc = cifs_get_writable_file(CIFS_I(mapping->host), FIND_WR_ANY,
+				    &open_file);
 	if (!rc) {
 		bytes_written = cifs_write(open_file, open_file->pid,
 					   write_data, to - from, &offset);
@@ -2358,7 +2363,7 @@ static int cifs_writepages(struct address_space *mapping,
 		if (cfile)
 			cifsFileInfo_put(cfile);
 
-		rc = cifs_get_writable_file(CIFS_I(inode), false, &cfile);
+		rc = cifs_get_writable_file(CIFS_I(inode), FIND_WR_ANY, &cfile);
 
 		/* in case of an error store it to return later */
 		if (rc)
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 32832319802b..8c173cfefe00 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -2188,7 +2188,7 @@ cifs_set_file_size(struct inode *inode, struct iattr *attrs,
 	 * writebehind data than the SMB timeout for the SetPathInfo
 	 * request would allow
 	 */
-	open_file = find_writable_file(cifsInode, true);
+	open_file = find_writable_file(cifsInode, FIND_WR_FSUID_ONLY);
 	if (open_file) {
 		tcon = tlink_tcon(open_file->tlink);
 		server = tcon->ses->server;
@@ -2338,7 +2338,7 @@ cifs_setattr_unix(struct dentry *direntry, struct iattr *attrs)
 		args->ctime = NO_CHANGE_64;
 
 	args->device = 0;
-	open_file = find_writable_file(cifsInode, true);
+	open_file = find_writable_file(cifsInode, FIND_WR_FSUID_ONLY);
 	if (open_file) {
 		u16 nfid = open_file->fid.netfid;
 		u32 npid = open_file->pid;
@@ -2441,7 +2441,7 @@ cifs_setattr_nounix(struct dentry *direntry, struct iattr *attrs)
 	rc = 0;
 
 	if (attrs->ia_valid & ATTR_MTIME) {
-		rc = cifs_get_writable_file(cifsInode, false, &wfile);
+		rc = cifs_get_writable_file(cifsInode, FIND_WR_ANY, &wfile);
 		if (!rc) {
 			tcon = tlink_tcon(wfile->tlink);
 			rc = tcon->ses->server->ops->flush(xid, tcon, &wfile->fid);
diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
index defd6836a5ea..739489cd0610 100644
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -766,7 +766,7 @@ smb_set_file_info(struct inode *inode, const char *full_path,
 	struct cifs_tcon *tcon;
 
 	/* if the file is already open for write, just use that fileid */
-	open_file = find_writable_file(cinode, true);
+	open_file = find_writable_file(cinode, FIND_WR_FSUID_ONLY);
 	if (open_file) {
 		fid.netfid = open_file->fid.netfid;
 		netpid = open_file->pid;
diff --git a/fs/cifs/smb2inode.c b/fs/cifs/smb2inode.c
index 1cf207564ff9..a8c301ae00ed 100644
--- a/fs/cifs/smb2inode.c
+++ b/fs/cifs/smb2inode.c
@@ -521,7 +521,7 @@ smb2_mkdir_setinfo(struct inode *inode, const char *name,
 	cifs_i = CIFS_I(inode);
 	dosattrs = cifs_i->cifsAttrs | ATTR_READONLY;
 	data.Attributes = cpu_to_le32(dosattrs);
-	cifs_get_writable_path(tcon, name, &cfile);
+	cifs_get_writable_path(tcon, name, FIND_WR_ANY, &cfile);
 	tmprc = smb2_compound_op(xid, tcon, cifs_sb, name,
 				 FILE_WRITE_ATTRIBUTES, FILE_CREATE,
 				 CREATE_NOT_FILE, ACL_NO_MODE,
@@ -577,7 +577,7 @@ smb2_rename_path(const unsigned int xid, struct cifs_tcon *tcon,
 {
 	struct cifsFileInfo *cfile;
 
-	cifs_get_writable_path(tcon, from_name, &cfile);
+	cifs_get_writable_path(tcon, from_name, FIND_WR_WITH_DELETE, &cfile);
 
 	return smb2_set_path_attr(xid, tcon, from_name, to_name,
 				  cifs_sb, DELETE, SMB2_OP_RENAME, cfile);
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 67d83460495f..a37343cdc81a 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -1334,6 +1334,7 @@ smb2_set_fid(struct cifsFileInfo *cfile, struct cifs_fid *fid, __u32 oplock)
 
 	cfile->fid.persistent_fid = fid->persistent_fid;
 	cfile->fid.volatile_fid = fid->volatile_fid;
+	cfile->fid.access = fid->access;
 #ifdef CONFIG_CIFS_DEBUG2
 	cfile->fid.mid = fid->mid;
 #endif /* CIFS_DEBUG2 */
@@ -3301,7 +3302,7 @@ static loff_t smb3_llseek(struct file *file, struct cifs_tcon *tcon, loff_t offs
 	 * some servers (Windows2016) will not reflect recent writes in
 	 * QUERY_ALLOCATED_RANGES until SMB2_flush is called.
 	 */
-	wrcfile = find_writable_file(cifsi, false);
+	wrcfile = find_writable_file(cifsi, FIND_WR_ANY);
 	if (wrcfile) {
 		filemap_write_and_wait(inode->i_mapping);
 		smb2_flush_file(xid, tcon, &wrcfile->fid);
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index dd96c89cd1d5..e8ebc26d7c23 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -2799,6 +2799,7 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	atomic_inc(&tcon->num_remote_opens);
 	oparms->fid->persistent_fid = rsp->PersistentFileId;
 	oparms->fid->volatile_fid = rsp->VolatileFileId;
+	oparms->fid->access = oparms->desired_access;
 #ifdef CONFIG_CIFS_DEBUG2
 	oparms->fid->mid = le64_to_cpu(rsp->sync_hdr.MessageId);
 #endif /* CIFS_DEBUG2 */
-- 
2.16.4

