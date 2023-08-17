Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 111C177FAE2
	for <lists+linux-cifs@lfdr.de>; Thu, 17 Aug 2023 17:36:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352319AbjHQPgO (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 17 Aug 2023 11:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352648AbjHQPfm (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 17 Aug 2023 11:35:42 -0400
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88A6430D1
        for <linux-cifs@vger.kernel.org>; Thu, 17 Aug 2023 08:35:40 -0700 (PDT)
From:   Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1692286539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WpdE04ntbvSybELPr/OUl0HYBJZ4qbr7PZulNYTHk/g=;
        b=HzLUFc5k9vlBZgJnV5dxlu9RFP8ODME449k2b8cnZ3+W4cqov9eyeVLUpgTQIZi5fZq4YO
        Nkkx36SKNYW62y21NH0wvwwMe6V9BWD9AJ2IstfKgMlgj6u5mtazb4jW23xFqaQlgRIsN0
        V72gkcAsUtKkJ5nW1OOpnZ2E5vcQRi6l8m0xL/wHZzdQrxSjGsyjctdFzPLSsoJFYHSaIo
        0xMOkd897BeKpH88O+usUxsqdYL1VRZ7TkiYEAdbAn35I3Boq0ts6E3eoqbtVUYM0Xbl/9
        WAqHtj4SIEgHQhAyNtApYw2r6nWmFLBgn6gHtRHy38T2DBPCNuLEXCE7c/xlvQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
        s=dkim; t=1692286539;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=WpdE04ntbvSybELPr/OUl0HYBJZ4qbr7PZulNYTHk/g=;
        b=Jzznb7Su+vGa6sDVsM+1si/4DGsG3lZNC6sBycJa7a5SpuGpjkjXNOhGM9Ucb6C7mWs5yk
        Dxyi1sKT/rJt/lt4jt0QG2nJCuyVfqcmF+nKW4sKEYcqTpBsYM0n9d8YVBA5UoGMNMinN+
        Qvdhm+nluVNXoJVUq0LRE8cIF8E5V+GR2ipzfhSGJ4FXTSiCrtX3yr4pFfgg46X90k0Hy8
        h5aDMGOlA0MRDG5/MVW6VT7IqdolX+4co7UDyudvzDBZpx/iucvhRMgdO+2/5vDwbiRMkZ
        MS4wBis0CIoS6ybJXBJEmivkga7mUe19JwBmP46a6XVzCDmUPnFEfLegfmaE4g==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1692286539; a=rsa-sha256;
        cv=none;
        b=s8Gd+kSxjhT3K5KFUeAxWM4VrrNdh6rC3Wo5hrs4/CioM2ToU+pX64M/9onzC7ZpuWRCL7
        uqC5l9GE18IHoPPBd7PoScPc7CJ8S+F+c6q7DZSdmobgyaUOZWF4tLFho6xc+MUhCmx3d4
        p6GFoEmQV432W2hCztwMgkyABv3BgH14LXuYGfdZo2JMjUAuvsR8sUPiTzMkojYUyDpP2O
        N9dKRVIn1A6hCdNrXkm39+odRI1hqWmGoSH70ME3HZx/VlprTKKe+iJ+6yxCeU0LgsVYID
        ywKieRF7zn9i1TjRpNss0xKLA986uuot1MdhFjbwJ87+4TP2Zld5b+6+IIqttw==
To:     smfrench@gmail.com
Cc:     linux-cifs@vger.kernel.org, Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 09/17] smb: client: do not query reparse points twice on symlinks
Date:   Thu, 17 Aug 2023 12:34:07 -0300
Message-ID: <20230817153416.28083-10-pc@manguebit.com>
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

Save a roundtrip by getting the reparse point tag and buffer at once
in ->query_reparse_point() and then pass the buffer down to
->query_symlink().

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
---
 fs/smb/client/cifsglob.h |  20 +++--
 fs/smb/client/inode.c    |  19 +++--
 fs/smb/client/smb1ops.c  |  11 ++-
 fs/smb/client/smb2ops.c  | 166 ++++++---------------------------------
 4 files changed, 55 insertions(+), 161 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 95e62502cb01..639a61417b08 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -336,10 +336,13 @@ struct smb_version_operations {
 	/* query file data from the server */
 	int (*query_file_info)(const unsigned int xid, struct cifs_tcon *tcon,
 			       struct cifsFileInfo *cfile, struct cifs_open_info_data *data);
-	/* query reparse tag from srv to determine which type of special file */
-	int (*query_reparse_tag)(const unsigned int xid, struct cifs_tcon *tcon,
-				struct cifs_sb_info *cifs_sb, const char *path,
-				__u32 *reparse_tag);
+	/* query reparse point to determine which type of special file */
+	int (*query_reparse_point)(const unsigned int xid,
+				   struct cifs_tcon *tcon,
+				   struct cifs_sb_info *cifs_sb,
+				   const char *full_path,
+				   u32 *tag, struct kvec *rsp,
+				   int *rsp_buftype);
 	/* get server index number */
 	int (*get_srv_inum)(const unsigned int xid, struct cifs_tcon *tcon,
 			    struct cifs_sb_info *cifs_sb, const char *full_path, u64 *uniqueid,
@@ -388,9 +391,12 @@ struct smb_version_operations {
 			       const char *, const char *,
 			       struct cifs_sb_info *);
 	/* query symlink target */
-	int (*query_symlink)(const unsigned int, struct cifs_tcon *,
-			     struct cifs_sb_info *, const char *,
-			     char **, bool);
+	int (*query_symlink)(const unsigned int xid,
+			     struct cifs_tcon *tcon,
+			     struct cifs_sb_info *cifs_sb,
+			     const char *full_path,
+			     char **target_path,
+			     struct kvec *rsp_iov);
 	/* open a file for non-posix mounts */
 	int (*open)(const unsigned int xid, struct cifs_open_parms *oparms, __u32 *oplock,
 		    void *buf);
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 51e2916730cf..96a09818aa5b 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -428,7 +428,7 @@ int cifs_get_inode_info_unix(struct inode **pinode,
 		if (!server->ops->query_symlink)
 			return -EOPNOTSUPP;
 		rc = server->ops->query_symlink(xid, tcon, cifs_sb, full_path,
-						&fattr.cf_symlink_target, false);
+						&fattr.cf_symlink_target, NULL);
 		if (rc) {
 			cifs_dbg(FYI, "%s: query_symlink: %d\n", __func__, rc);
 			goto cgiiu_exit;
@@ -988,17 +988,21 @@ static int query_reparse(struct cifs_open_info_data *data,
 {
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
-	bool reparse_point = data->reparse_point;
+	struct kvec rsp_iov, *iov = NULL;
+	int rsp_buftype = CIFS_NO_BUFFER;
 	u32 tag = data->reparse_tag;
 	int rc = 0;
 
-	if (!tag && server->ops->query_reparse_tag) {
-		server->ops->query_reparse_tag(xid, tcon, cifs_sb,
-					       full_path, &tag);
+	if (!tag && server->ops->query_reparse_point) {
+		rc = server->ops->query_reparse_point(xid, tcon, cifs_sb,
+						      full_path, &tag,
+						      &rsp_iov, &rsp_buftype);
+		if (!rc)
+			iov = &rsp_iov;
 	}
 	switch ((data->reparse_tag = tag)) {
 	case 0: /* SMB1 symlink */
-		reparse_point = false;
+		iov = NULL;
 		fallthrough;
 	case IO_REPARSE_TAG_NFS:
 	case IO_REPARSE_TAG_SYMLINK:
@@ -1006,10 +1010,11 @@ static int query_reparse(struct cifs_open_info_data *data,
 			rc = server->ops->query_symlink(xid, tcon,
 							cifs_sb, full_path,
 							&data->symlink_target,
-							reparse_point);
+							iov);
 		}
 		break;
 	}
+	free_rsp_buf(rsp_buftype, rsp_iov.iov_base);
 	return rc;
 }
 
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 094ef4fe2219..9bf8735cdd1e 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -972,13 +972,16 @@ cifs_unix_dfs_readlink(const unsigned int xid, struct cifs_tcon *tcon,
 #endif
 }
 
-static int
-cifs_query_symlink(const unsigned int xid, struct cifs_tcon *tcon,
-		   struct cifs_sb_info *cifs_sb, const char *full_path,
-		   char **target_path, bool is_reparse_point)
+static int cifs_query_symlink(const unsigned int xid,
+			      struct cifs_tcon *tcon,
+			      struct cifs_sb_info *cifs_sb,
+			      const char *full_path,
+			      char **target_path,
+			      struct kvec *rsp_iov)
 {
 	int rc;
 	int oplock = 0;
+	bool is_reparse_point = !!rsp_iov;
 	struct cifs_fid fid;
 	struct cifs_open_parms oparms;
 
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 0f62bc373ad0..5eb2720f4aa7 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2948,153 +2948,30 @@ parse_reparse_point(struct reparse_data_buffer *buf,
 	}
 }
 
-static int
-smb2_query_symlink(const unsigned int xid, struct cifs_tcon *tcon,
-		   struct cifs_sb_info *cifs_sb, const char *full_path,
-		   char **target_path, bool is_reparse_point)
+static int smb2_query_symlink(const unsigned int xid,
+			      struct cifs_tcon *tcon,
+			      struct cifs_sb_info *cifs_sb,
+			      const char *full_path,
+			      char **target_path,
+			      struct kvec *rsp_iov)
 {
-	int rc;
-	__le16 *utf16_path = NULL;
-	__u8 oplock = SMB2_OPLOCK_LEVEL_NONE;
-	struct cifs_open_parms oparms;
-	struct cifs_fid fid;
-	struct kvec err_iov = {NULL, 0};
-	struct TCP_Server_Info *server = cifs_pick_channel(tcon->ses);
-	int flags = CIFS_CP_CREATE_CLOSE_OP;
-	struct smb_rqst rqst[3];
-	int resp_buftype[3];
-	struct kvec rsp_iov[3];
-	struct kvec open_iov[SMB2_CREATE_IOV_SIZE];
-	struct kvec io_iov[SMB2_IOCTL_IOV_SIZE];
-	struct kvec close_iov[1];
-	struct smb2_create_rsp *create_rsp;
-	struct smb2_ioctl_rsp *ioctl_rsp;
-	struct reparse_data_buffer *reparse_buf;
-	int create_options = is_reparse_point ? OPEN_REPARSE_POINT : 0;
-	u32 plen;
+	struct reparse_data_buffer *buf;
+	struct smb2_ioctl_rsp *io = rsp_iov->iov_base;
+	u32 plen = le32_to_cpu(io->OutputCount);
 
 	cifs_dbg(FYI, "%s: path: %s\n", __func__, full_path);
 
-	*target_path = NULL;
-
-	if (smb3_encryption_required(tcon))
-		flags |= CIFS_TRANSFORM_REQ;
-
-	memset(rqst, 0, sizeof(rqst));
-	resp_buftype[0] = resp_buftype[1] = resp_buftype[2] = CIFS_NO_BUFFER;
-	memset(rsp_iov, 0, sizeof(rsp_iov));
-
-	utf16_path = cifs_convert_path_to_utf16(full_path, cifs_sb);
-	if (!utf16_path)
-		return -ENOMEM;
-
-	/* Open */
-	memset(&open_iov, 0, sizeof(open_iov));
-	rqst[0].rq_iov = open_iov;
-	rqst[0].rq_nvec = SMB2_CREATE_IOV_SIZE;
-
-	oparms = (struct cifs_open_parms) {
-		.tcon = tcon,
-		.path = full_path,
-		.desired_access = FILE_READ_ATTRIBUTES,
-		.disposition = FILE_OPEN,
-		.create_options = cifs_create_options(cifs_sb, create_options),
-		.fid = &fid,
-	};
-
-	rc = SMB2_open_init(tcon, server,
-			    &rqst[0], &oplock, &oparms, utf16_path);
-	if (rc)
-		goto querty_exit;
-	smb2_set_next_command(tcon, &rqst[0]);
-
-
-	/* IOCTL */
-	memset(&io_iov, 0, sizeof(io_iov));
-	rqst[1].rq_iov = io_iov;
-	rqst[1].rq_nvec = SMB2_IOCTL_IOV_SIZE;
-
-	rc = SMB2_ioctl_init(tcon, server,
-			     &rqst[1], fid.persistent_fid,
-			     fid.volatile_fid, FSCTL_GET_REPARSE_POINT, NULL, 0,
-			     CIFSMaxBufSize -
-			     MAX_SMB2_CREATE_RESPONSE_SIZE -
-			     MAX_SMB2_CLOSE_RESPONSE_SIZE);
-	if (rc)
-		goto querty_exit;
-
-	smb2_set_next_command(tcon, &rqst[1]);
-	smb2_set_related(&rqst[1]);
-
-
-	/* Close */
-	memset(&close_iov, 0, sizeof(close_iov));
-	rqst[2].rq_iov = close_iov;
-	rqst[2].rq_nvec = 1;
-
-	rc = SMB2_close_init(tcon, server,
-			     &rqst[2], COMPOUND_FID, COMPOUND_FID, false);
-	if (rc)
-		goto querty_exit;
-
-	smb2_set_related(&rqst[2]);
-
-	rc = compound_send_recv(xid, tcon->ses, server,
-				flags, 3, rqst,
-				resp_buftype, rsp_iov);
-
-	create_rsp = rsp_iov[0].iov_base;
-	if (create_rsp && create_rsp->hdr.Status)
-		err_iov = rsp_iov[0];
-	ioctl_rsp = rsp_iov[1].iov_base;
-
-	/*
-	 * Open was successful and we got an ioctl response.
-	 */
-	if ((rc == 0) && (is_reparse_point)) {
-		/* See MS-FSCC 2.3.23 */
-
-		reparse_buf = (struct reparse_data_buffer *)
-			((char *)ioctl_rsp +
-			 le32_to_cpu(ioctl_rsp->OutputOffset));
-		plen = le32_to_cpu(ioctl_rsp->OutputCount);
-
-		if (plen + le32_to_cpu(ioctl_rsp->OutputOffset) >
-		    rsp_iov[1].iov_len) {
-			cifs_tcon_dbg(VFS, "srv returned invalid ioctl len: %d\n",
-				 plen);
-			rc = -EIO;
-			goto querty_exit;
-		}
-
-		rc = parse_reparse_point(reparse_buf, plen, target_path,
-					 cifs_sb);
-		goto querty_exit;
-	}
-
-	if (!rc || !err_iov.iov_base) {
-		rc = -ENOENT;
-		goto querty_exit;
-	}
-
-	rc = smb2_parse_symlink_response(cifs_sb, &err_iov, target_path);
-
- querty_exit:
-	cifs_dbg(FYI, "query symlink rc %d\n", rc);
-	kfree(utf16_path);
-	SMB2_open_free(&rqst[0]);
-	SMB2_ioctl_free(&rqst[1]);
-	SMB2_close_free(&rqst[2]);
-	free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
-	free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
-	free_rsp_buf(resp_buftype[2], rsp_iov[2].iov_base);
-	return rc;
+	buf = (struct reparse_data_buffer *)((u8 *)io +
+					     le32_to_cpu(io->OutputOffset));
+	return parse_reparse_point(buf, plen, target_path, cifs_sb);
 }
 
-int
-smb2_query_reparse_tag(const unsigned int xid, struct cifs_tcon *tcon,
-		   struct cifs_sb_info *cifs_sb, const char *full_path,
-		   __u32 *tag)
+static int smb2_query_reparse_point(const unsigned int xid,
+				    struct cifs_tcon *tcon,
+				    struct cifs_sb_info *cifs_sb,
+				    const char *full_path,
+				    u32 *tag, struct kvec *rsp,
+				    int *rsp_buftype)
 {
 	int rc;
 	__le16 *utf16_path = NULL;
@@ -3205,6 +3082,9 @@ smb2_query_reparse_tag(const unsigned int xid, struct cifs_tcon *tcon,
 			goto query_rp_exit;
 		}
 		*tag = le32_to_cpu(reparse_buf->ReparseTag);
+		*rsp = rsp_iov[1];
+		*rsp_buftype = resp_buftype[1];
+		resp_buftype[1] = CIFS_NO_BUFFER;
 	}
 
  query_rp_exit:
@@ -5503,7 +5383,7 @@ struct smb_version_operations smb30_operations = {
 	.echo = SMB2_echo,
 	.query_path_info = smb2_query_path_info,
 	/* WSL tags introduced long after smb2.1, enable for SMB3, 3.11 only */
-	.query_reparse_tag = smb2_query_reparse_tag,
+	.query_reparse_point = smb2_query_reparse_point,
 	.get_srv_inum = smb2_get_srv_inum,
 	.query_file_info = smb2_query_file_info,
 	.set_path_size = smb2_set_path_size,
@@ -5616,7 +5496,7 @@ struct smb_version_operations smb311_operations = {
 	.can_echo = smb2_can_echo,
 	.echo = SMB2_echo,
 	.query_path_info = smb2_query_path_info,
-	.query_reparse_tag = smb2_query_reparse_tag,
+	.query_reparse_point = smb2_query_reparse_point,
 	.get_srv_inum = smb2_get_srv_inum,
 	.query_file_info = smb2_query_file_info,
 	.set_path_size = smb2_set_path_size,
-- 
2.41.0

