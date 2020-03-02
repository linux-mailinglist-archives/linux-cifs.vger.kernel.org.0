Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F234C176075
	for <lists+linux-cifs@lfdr.de>; Mon,  2 Mar 2020 17:53:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727140AbgCBQx2 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 2 Mar 2020 11:53:28 -0500
Received: from mx2.suse.de ([195.135.220.15]:43342 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727104AbgCBQx2 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 2 Mar 2020 11:53:28 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 04635B26A;
        Mon,  2 Mar 2020 16:53:26 +0000 (UTC)
From:   Aurelien Aptel <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH] cifs: add SMB2_open() arg to return POSIX data
Date:   Mon,  2 Mar 2020 17:53:22 +0100
Message-Id: <20200302165322.7380-1-aaptel@suse.com>
X-Mailer: git-send-email 2.16.4
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

allows SMB2_open() callers to pass down a POSIX data buffer that will
trigger requesting POSIX create context and parsing the response into
the provided buffer.

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 fs/cifs/link.c      |  4 ++--
 fs/cifs/smb2file.c  |  2 +-
 fs/cifs/smb2ops.c   | 23 ++++++++++++++--------
 fs/cifs/smb2pdu.c   | 55 +++++++++++++++++++++++++++++++++++++----------------
 fs/cifs/smb2pdu.h   | 12 +++++-------
 fs/cifs/smb2proto.h |  5 ++++-
 6 files changed, 66 insertions(+), 35 deletions(-)

diff --git a/fs/cifs/link.c b/fs/cifs/link.c
index 852aa00ec729..a25ef35b023e 100644
--- a/fs/cifs/link.c
+++ b/fs/cifs/link.c
@@ -416,7 +416,7 @@ smb3_query_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	}
 
 	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, pfile_info, NULL,
-		       NULL);
+		       NULL, NULL);
 	if (rc)
 		goto qmf_out_open_fail;
 
@@ -470,7 +470,7 @@ smb3_create_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
 	oparms.reconnect = false;
 
 	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, NULL, NULL,
-		       NULL);
+		       NULL, NULL);
 	if (rc) {
 		kfree(utf16_path);
 		return rc;
diff --git a/fs/cifs/smb2file.c b/fs/cifs/smb2file.c
index afe1f03aabe3..0a19d6d8e1cc 100644
--- a/fs/cifs/smb2file.c
+++ b/fs/cifs/smb2file.c
@@ -62,7 +62,7 @@ smb2_open_file(const unsigned int xid, struct cifs_open_parms *oparms,
 	smb2_oplock = SMB2_OPLOCK_LEVEL_BATCH;
 
 	rc = SMB2_open(xid, oparms, smb2_path, &smb2_oplock, smb2_data, NULL,
-		       NULL);
+		       NULL, NULL);
 	if (rc)
 		goto out;
 
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 5fa34225a99b..076bedb261d5 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -794,7 +794,8 @@ int open_shroot(unsigned int xid, struct cifs_tcon *tcon,
 		tcon->crfid.has_lease = true;
 		smb2_parse_contexts(server, o_rsp,
 				&oparms.fid->epoch,
-				oparms.fid->lease_key, &oplock, NULL);
+				    oparms.fid->lease_key, &oplock,
+				    NULL, NULL);
 	} else
 		goto oshr_exit;
 
@@ -838,7 +839,7 @@ smb3_qfs_tcon(const unsigned int xid, struct cifs_tcon *tcon,
 
 	if (no_cached_open)
 		rc = SMB2_open(xid, &oparms, &srch_path, &oplock, NULL, NULL,
-			       NULL);
+			       NULL, NULL);
 	else
 		rc = open_shroot(xid, tcon, cifs_sb, &fid);
 
@@ -878,7 +879,8 @@ smb2_qfs_tcon(const unsigned int xid, struct cifs_tcon *tcon,
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
-	rc = SMB2_open(xid, &oparms, &srch_path, &oplock, NULL, NULL, NULL);
+	rc = SMB2_open(xid, &oparms, &srch_path, &oplock, NULL, NULL,
+		       NULL, NULL);
 	if (rc)
 		return;
 
@@ -913,7 +915,8 @@ smb2_is_path_accessible(const unsigned int xid, struct cifs_tcon *tcon,
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
-	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, NULL, NULL, NULL);
+	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, NULL, NULL, NULL,
+		       NULL);
 	if (rc) {
 		kfree(utf16_path);
 		return rc;
@@ -2122,7 +2125,8 @@ smb3_notify(const unsigned int xid, struct file *pfile,
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
-	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, NULL, NULL, NULL);
+	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, NULL, NULL, NULL,
+		       NULL);
 	if (rc)
 		goto notify_exit;
 
@@ -2541,7 +2545,8 @@ smb311_queryfs(const unsigned int xid, struct cifs_tcon *tcon,
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
-	rc = SMB2_open(xid, &oparms, &srch_path, &oplock, NULL, NULL, NULL);
+	rc = SMB2_open(xid, &oparms, &srch_path, &oplock, NULL, NULL,
+		       NULL, NULL);
 	if (rc)
 		return rc;
 
@@ -3026,7 +3031,8 @@ get_smb2_acl_by_path(struct cifs_sb_info *cifs_sb,
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
-	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, NULL, NULL, NULL);
+	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, NULL,NULL, NULL,
+		       NULL);
 	kfree(utf16_path);
 	if (!rc) {
 		rc = SMB2_query_acl(xid, tlink_tcon(tlink), fid.persistent_fid,
@@ -3084,7 +3090,8 @@ set_smb2_acl(struct cifs_ntsd *pnntsd, __u32 acllen,
 	oparms.fid = &fid;
 	oparms.reconnect = false;
 
-	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, NULL, NULL, NULL);
+	rc = SMB2_open(xid, &oparms, utf16_path, &oplock, NULL, NULL,
+		       NULL, NULL);
 	kfree(utf16_path);
 	if (!rc) {
 		rc = SMB2_set_acl(xid, tlink_tcon(tlink), fid.persistent_fid,
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 7356017a0821..47d3e382ecaa 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1951,25 +1951,46 @@ parse_query_id_ctxt(struct create_context *cc, struct smb2_file_all_info *buf)
 }
 
 static void
-parse_posix_ctxt(struct create_context *cc, struct smb2_file_all_info *info)
+parse_posix_ctxt(struct create_context *cc, struct smb2_file_all_info *info,
+		 struct create_posix_rsp *posix)
 {
-	/* struct create_posix_rsp *posix = (struct create_posix_rsp *)cc; */
+	int sid_len;
+	u8 *beg = (u8 *)cc + le16_to_cpu(cc->DataOffset);
+	u8 *end = beg + le32_to_cpu(cc->DataLength);
+	u8 *sid;
 
-	/*
-	 * TODO: Need to add parsing for the context and return. Can
-	 * smb2_file_all_info hold POSIX data? Need to change the
-	 * passed type from SMB2_open.
-	 */
-	printk_once(KERN_WARNING
-		    "SMB3 3.11 POSIX response context not completed yet\n");
+	memset(posix, 0, sizeof(*posix));
+
+	posix->nlink = le32_to_cpu(*(__le32 *)(beg + 0));
+	posix->reparse_tag = le32_to_cpu(*(__le32 *)(beg + 4));
+	posix->mode = le32_to_cpu(*(__le32 *)(beg + 8));
+
+	sid = beg + 12;
+	sid_len = posix_info_sid_size(sid, end);
+	if (sid_len < 0) {
+		cifs_dbg(VFS, "bad owner sid in posix create response\n");
+		return;
+	}
+	memcpy(&posix->owner, sid, sid_len);
+
+	sid = sid + sid_len;
+	sid_len = posix_info_sid_size(sid, end);
+	if (sid_len < 0) {
+		cifs_dbg(VFS, "bad group sid in posix create response\n");
+		return;
+	}
+	memcpy(&posix->group, sid, sid_len);
 
+	cifs_dbg(FYI, "nlink=%d mode=%o reparse_tag=%x\n",
+		 posix->nlink, posix->mode, posix->reparse_tag);
 }
 
 void
 smb2_parse_contexts(struct TCP_Server_Info *server,
-		       struct smb2_create_rsp *rsp,
-		       unsigned int *epoch, char *lease_key, __u8 *oplock,
-		       struct smb2_file_all_info *buf)
+		    struct smb2_create_rsp *rsp,
+		    unsigned int *epoch, char *lease_key, __u8 *oplock,
+		    struct smb2_file_all_info *buf,
+		    struct create_posix_rsp *posix)
 {
 	char *data_offset;
 	struct create_context *cc;
@@ -1999,8 +2020,9 @@ smb2_parse_contexts(struct TCP_Server_Info *server,
 		    strncmp(name, SMB2_CREATE_QUERY_ON_DISK_ID, 4) == 0)
 			parse_query_id_ctxt(cc, buf);
 		else if ((le16_to_cpu(cc->NameLength) == 16)) {
-			if (memcmp(name, smb3_create_tag_posix, 16) == 0)
-				parse_posix_ctxt(cc, buf);
+			if (posix &&
+			    memcmp(name, smb3_create_tag_posix, 16) == 0)
+				parse_posix_ctxt(cc, buf, posix);
 		}
 		/* else {
 			cifs_dbg(FYI, "Context not matched with len %d\n",
@@ -2725,6 +2747,7 @@ SMB2_open_free(struct smb_rqst *rqst)
 int
 SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 	  __u8 *oplock, struct smb2_file_all_info *buf,
+	  struct create_posix_rsp *posix,
 	  struct kvec *err_iov, int *buftype)
 {
 	struct smb_rqst rqst;
@@ -2803,7 +2826,7 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 
 
 	smb2_parse_contexts(server, rsp, &oparms->fid->epoch,
-			    oparms->fid->lease_key, oplock, buf);
+			    oparms->fid->lease_key, oplock, buf, posix);
 creat_exit:
 	SMB2_open_free(&rqst);
 	free_rsp_buf(resp_buftype, rsp);
@@ -4302,7 +4325,7 @@ SMB2_write(const unsigned int xid, struct cifs_io_parms *io_parms,
 	return rc;
 }
 
-static int posix_info_sid_size(const void *beg, const void *end)
+int posix_info_sid_size(const void *beg, const void *end)
 {
 	size_t subauth;
 	int total;
diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
index 700311978523..ad14b8505b4d 100644
--- a/fs/cifs/smb2pdu.h
+++ b/fs/cifs/smb2pdu.h
@@ -1605,13 +1605,11 @@ extern char smb2_padding[7];
 
 /* equivalent of the contents of SMB3.1.1 POSIX open context response */
 struct create_posix_rsp {
-	__le32 nlink;
-	__le32 reparse_tag;
-	__le32 mode;
-	/*
-	 * var sized owner SID
-	 * var sized group SID
-	 */
+	u32 nlink;
+	u32 reparse_tag;
+	u32 mode;
+	struct cifs_sid owner; /* var-sized on the wire */
+	struct cifs_sid group; /* var-sized on the wire */
 } __packed;
 
 /*
diff --git a/fs/cifs/smb2proto.h b/fs/cifs/smb2proto.h
index c0f0801e7e8e..4d1ff7b66fdc 100644
--- a/fs/cifs/smb2proto.h
+++ b/fs/cifs/smb2proto.h
@@ -139,6 +139,7 @@ extern int SMB2_tdis(const unsigned int xid, struct cifs_tcon *tcon);
 extern int SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms,
 		     __le16 *path, __u8 *oplock,
 		     struct smb2_file_all_info *buf,
+		     struct create_posix_rsp *posix,
 		     struct kvec *err_iov, int *resp_buftype);
 extern int SMB2_open_init(struct cifs_tcon *tcon, struct smb_rqst *rqst,
 			  __u8 *oplock, struct cifs_open_parms *oparms,
@@ -252,7 +253,8 @@ extern enum securityEnum smb2_select_sectype(struct TCP_Server_Info *,
 extern void smb2_parse_contexts(struct TCP_Server_Info *server,
 				struct smb2_create_rsp *rsp,
 				unsigned int *epoch, char *lease_key,
-				__u8 *oplock, struct smb2_file_all_info *buf);
+				__u8 *oplock, struct smb2_file_all_info *buf,
+				struct create_posix_rsp *posix);
 extern int smb3_encryption_required(const struct cifs_tcon *tcon);
 extern int smb2_validate_iov(unsigned int offset, unsigned int buffer_length,
 			     struct kvec *iov, unsigned int min_buf_size);
@@ -274,4 +276,5 @@ extern int smb2_query_info_compound(const unsigned int xid,
 				    struct cifs_sb_info *cifs_sb);
 int posix_info_parse(const void *beg, const void *end,
 		     struct smb2_posix_info_parsed *out);
+int posix_info_sid_size(const void *beg, const void *end);
 #endif			/* _SMB2PROTO_H */
-- 
2.16.4

