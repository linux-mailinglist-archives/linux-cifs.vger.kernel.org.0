Return-Path: <linux-cifs+bounces-141-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CCB387F3A23
	for <lists+linux-cifs@lfdr.de>; Wed, 22 Nov 2023 00:13:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EF1F71C20B78
	for <lists+linux-cifs@lfdr.de>; Tue, 21 Nov 2023 23:13:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74435482F7;
	Tue, 21 Nov 2023 23:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="WLzCI1lr"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF146191
	for <linux-cifs@vger.kernel.org>; Tue, 21 Nov 2023 15:13:09 -0800 (PST)
From: Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1700608388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFvM/ziSwfS1MNKcN6z5zKRMFP2hyjrMl6TNy4yY4fQ=;
	b=WLzCI1lrae77zF0uWDZMKmPy2KmPWSabvpY8r0VoNhK5j3GARd2rmUYR++XnEqZMCyj/rZ
	m4oC3tb1wlm5NadEJ06pWRm8oWxiXIt4+yN8cSaSGRGMkGGyx1+xtv/l6gzYoKH90g4oj3
	B3Ia67U+XBE0Om+6NECyp4CeUkSKOttk4YY9Ip2gLmeHeQtbji/wyhat/vjCifv5t6EQ0L
	fEyTYGV43iZvHEzaET19O8EDHXky/C42CK8UU2yaHm0SHbw51nPM0mbi0oYJl87ow4rHIA
	TJJb4RtWDlEBxSrnzqBHKU7dS38aqdHYe1uObVnkIzaGa7HBIfk74CA4t6+Fsg==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1700608388; a=rsa-sha256;
	cv=none;
	b=Xgztz7oB2BNdBIIBnBop3suuxytuHxYej9TOYQYzJ9+adUurpqq1T6J87Rab4D+/SYxWC3
	6P4+PYz/tOh/ReeoBaPF764/ZmU/zzDUFFfUsjxM0rlJkEesoEcKNjaCjl6T5/67+FSmXg
	FABcvfA4uaqx4m4bNVLrDW0KX8lGwe0a1JHRlbT41G5goMsCkfZqVJx0G3pRBEokYr1kQj
	O7+9PgMLGUPoaxWz0RSmy8HQqz38FxFRYoGKOfA05V3mDIwVKGjPQ2JGhxUOzntwgpjZ91
	3uAg8Fz53lQD7J15kJlIrfkXOeT5swfDUP+5PNPYDY3De/dRlF6iPCMtKkuGtg==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1700608388; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hFvM/ziSwfS1MNKcN6z5zKRMFP2hyjrMl6TNy4yY4fQ=;
	b=LqUDE26ulfiMb1NVkYCNWazpBr0Jb/3yiPWrP1+Vd9vOejAW3fAo2hqWUjwHY9KWx8tMpb
	9fWgzyWd2yZVylrdUk2PU558QuBtaC/AKnLUFrUDLKdCJfNbTTHbJ6VrvKpHk0Jdg2pXeY
	FTbITc/KcMpByjA1bJNouxJzPpOsqV0rgvblU0dQNX/wVDK0qaEg3EokBR6c3RJybjxOIy
	ordH4PesxH7YoujnZFBufOzqXIJAC3SRvyq4qnmuczEt9oqkrR7p8e3R8+wNfoU90gsOD5
	3vuqeB94d66E2Hxtv6BzlA2LCCoOHn9IUGrLjVJZp9wM4mBE8CAq/4Zoft0bcA==
To: smfrench@gmail.com
Cc: linux-cifs@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 2/7] smb: client: introduce ->parse_reparse_point()
Date: Tue, 21 Nov 2023 20:12:53 -0300
Message-ID: <20231121231258.29562-2-pc@manguebit.com>
In-Reply-To: <20231121231258.29562-1-pc@manguebit.com>
References: <20231119182209.5140-1-pc@manguebit.com>
 <20231121231258.29562-1-pc@manguebit.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse reparse point into cifs_open_info_data structure and feed it
through cifs_open_info_to_fattr().

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
---
 fs/smb/client/cifsglob.h |  6 ++++--
 fs/smb/client/inode.c    | 23 +++++++++++++---------
 fs/smb/client/smb1ops.c  | 41 ++++++++++++++++++++++------------------
 fs/smb/client/smb2ops.c  | 28 ++++++++++++++-------------
 4 files changed, 56 insertions(+), 42 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 6ffbd81bd109..111daa4ff261 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -395,8 +395,7 @@ struct smb_version_operations {
 			     struct cifs_tcon *tcon,
 			     struct cifs_sb_info *cifs_sb,
 			     const char *full_path,
-			     char **target_path,
-			     struct kvec *rsp_iov);
+			     char **target_path);
 	/* open a file for non-posix mounts */
 	int (*open)(const unsigned int xid, struct cifs_open_parms *oparms, __u32 *oplock,
 		    void *buf);
@@ -551,6 +550,9 @@ struct smb_version_operations {
 	bool (*is_status_io_timeout)(char *buf);
 	/* Check for STATUS_NETWORK_NAME_DELETED */
 	bool (*is_network_name_deleted)(char *buf, struct TCP_Server_Info *srv);
+	int (*parse_reparse_point)(struct cifs_sb_info *cifs_sb,
+				   struct kvec *rsp_iov,
+				   struct cifs_open_info_data *data);
 };
 
 struct smb_version_values {
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 86fbd3f847d6..dd482de3dc3f 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -459,8 +459,7 @@ static int cifs_get_unix_fattr(const unsigned char *full_path,
 			return -EOPNOTSUPP;
 		rc = server->ops->query_symlink(xid, tcon,
 						cifs_sb, full_path,
-						&fattr->cf_symlink_target,
-						NULL);
+						&fattr->cf_symlink_target);
 		cifs_dbg(FYI, "%s: query_symlink: %d\n", __func__, rc);
 	}
 	return rc;
@@ -1035,22 +1034,28 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 		if (!rc)
 			iov = &rsp_iov;
 	}
+
+	rc = -EOPNOTSUPP;
 	switch ((data->reparse_tag = tag)) {
 	case 0: /* SMB1 symlink */
-		iov = NULL;
-		fallthrough;
-	case IO_REPARSE_TAG_NFS:
-	case IO_REPARSE_TAG_SYMLINK:
-		if (!data->symlink_target && server->ops->query_symlink) {
+		if (server->ops->query_symlink) {
 			rc = server->ops->query_symlink(xid, tcon,
 							cifs_sb, full_path,
-							&data->symlink_target,
-							iov);
+							&data->symlink_target);
 		}
 		break;
 	case IO_REPARSE_TAG_MOUNT_POINT:
 		cifs_create_junction_fattr(fattr, sb);
+		rc = 0;
 		goto out;
+	default:
+		if (data->symlink_target) {
+			rc = 0;
+		} else if (server->ops->parse_reparse_point) {
+			rc = server->ops->parse_reparse_point(cifs_sb,
+							      iov, data);
+		}
+		break;
 	}
 
 	cifs_open_info_to_fattr(fattr, data, sb);
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 6b4d8effa79d..0dd599004e04 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -976,32 +976,36 @@ static int cifs_query_symlink(const unsigned int xid,
 			      struct cifs_tcon *tcon,
 			      struct cifs_sb_info *cifs_sb,
 			      const char *full_path,
-			      char **target_path,
-			      struct kvec *rsp_iov)
+			      char **target_path)
+{
+	int rc;
+
+	cifs_tcon_dbg(FYI, "%s: path=%s\n", __func__, full_path);
+
+	if (!cap_unix(tcon->ses))
+		return -EOPNOTSUPP;
+
+	rc = CIFSSMBUnixQuerySymLink(xid, tcon, full_path, target_path,
+				     cifs_sb->local_nls, cifs_remap(cifs_sb));
+	if (rc == -EREMOTE)
+		rc = cifs_unix_dfs_readlink(xid, tcon, full_path,
+					    target_path, cifs_sb->local_nls);
+	return rc;
+}
+
+static int cifs_parse_reparse_point(struct cifs_sb_info *cifs_sb,
+				    struct kvec *rsp_iov,
+				    struct cifs_open_info_data *data)
 {
 	struct reparse_data_buffer *buf;
 	TRANSACT_IOCTL_RSP *io = rsp_iov->iov_base;
 	bool unicode = !!(io->hdr.Flags2 & SMBFLG2_UNICODE);
 	u32 plen = le16_to_cpu(io->ByteCount);
-	int rc;
-
-	cifs_tcon_dbg(FYI, "%s: path=%s\n", __func__, full_path);
-
-	/* Check for unix extensions */
-	if (cap_unix(tcon->ses)) {
-		rc = CIFSSMBUnixQuerySymLink(xid, tcon, full_path, target_path,
-					     cifs_sb->local_nls,
-					     cifs_remap(cifs_sb));
-		if (rc == -EREMOTE)
-			rc = cifs_unix_dfs_readlink(xid, tcon, full_path,
-						    target_path,
-						    cifs_sb->local_nls);
-		return rc;
-	}
 
 	buf = (struct reparse_data_buffer *)((__u8 *)&io->hdr.Protocol +
 					     le32_to_cpu(io->DataOffset));
-	return parse_reparse_point(buf, plen, cifs_sb, unicode, target_path);
+	return parse_reparse_point(buf, plen, cifs_sb, unicode,
+				   &data->symlink_target);
 }
 
 static bool
@@ -1200,6 +1204,7 @@ struct smb_version_operations smb1_operations = {
 	.rename = CIFSSMBRename,
 	.create_hardlink = CIFSCreateHardLink,
 	.query_symlink = cifs_query_symlink,
+	.parse_reparse_point = cifs_parse_reparse_point,
 	.open = cifs_open_file,
 	.set_fid = cifs_set_fid,
 	.close = cifs_close_file,
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index e9c8cff0b1d2..2955eaa51d4d 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2949,6 +2949,12 @@ int parse_reparse_point(struct reparse_data_buffer *buf,
 		return parse_reparse_symlink(
 			(struct reparse_symlink_data_buffer *)buf,
 			plen, unicode, target_path, cifs_sb);
+	case IO_REPARSE_TAG_LX_SYMLINK:
+	case IO_REPARSE_TAG_AF_UNIX:
+	case IO_REPARSE_TAG_LX_FIFO:
+	case IO_REPARSE_TAG_LX_CHR:
+	case IO_REPARSE_TAG_LX_BLK:
+		return 0;
 	default:
 		cifs_dbg(VFS, "srv returned unknown symlink buffer tag:0x%08x\n",
 			 le32_to_cpu(buf->ReparseTag));
@@ -2956,22 +2962,18 @@ int parse_reparse_point(struct reparse_data_buffer *buf,
 	}
 }
 
-static int smb2_query_symlink(const unsigned int xid,
-			      struct cifs_tcon *tcon,
-			      struct cifs_sb_info *cifs_sb,
-			      const char *full_path,
-			      char **target_path,
-			      struct kvec *rsp_iov)
+static int smb2_parse_reparse_point(struct cifs_sb_info *cifs_sb,
+				    struct kvec *rsp_iov,
+				    struct cifs_open_info_data *data)
 {
 	struct reparse_data_buffer *buf;
 	struct smb2_ioctl_rsp *io = rsp_iov->iov_base;
 	u32 plen = le32_to_cpu(io->OutputCount);
 
-	cifs_tcon_dbg(FYI, "%s: path: %s\n", __func__, full_path);
-
 	buf = (struct reparse_data_buffer *)((u8 *)io +
 					     le32_to_cpu(io->OutputOffset));
-	return parse_reparse_point(buf, plen, cifs_sb, true, target_path);
+	return parse_reparse_point(buf, plen, cifs_sb,
+				   true, &data->symlink_target);
 }
 
 static int smb2_query_reparse_point(const unsigned int xid,
@@ -5206,7 +5208,7 @@ struct smb_version_operations smb20_operations = {
 	.unlink = smb2_unlink,
 	.rename = smb2_rename_path,
 	.create_hardlink = smb2_create_hardlink,
-	.query_symlink = smb2_query_symlink,
+	.parse_reparse_point = smb2_parse_reparse_point,
 	.query_mf_symlink = smb3_query_mf_symlink,
 	.create_mf_symlink = smb3_create_mf_symlink,
 	.open = smb2_open_file,
@@ -5308,7 +5310,7 @@ struct smb_version_operations smb21_operations = {
 	.unlink = smb2_unlink,
 	.rename = smb2_rename_path,
 	.create_hardlink = smb2_create_hardlink,
-	.query_symlink = smb2_query_symlink,
+	.parse_reparse_point = smb2_parse_reparse_point,
 	.query_mf_symlink = smb3_query_mf_symlink,
 	.create_mf_symlink = smb3_create_mf_symlink,
 	.open = smb2_open_file,
@@ -5413,7 +5415,7 @@ struct smb_version_operations smb30_operations = {
 	.unlink = smb2_unlink,
 	.rename = smb2_rename_path,
 	.create_hardlink = smb2_create_hardlink,
-	.query_symlink = smb2_query_symlink,
+	.parse_reparse_point = smb2_parse_reparse_point,
 	.query_mf_symlink = smb3_query_mf_symlink,
 	.create_mf_symlink = smb3_create_mf_symlink,
 	.open = smb2_open_file,
@@ -5527,7 +5529,7 @@ struct smb_version_operations smb311_operations = {
 	.unlink = smb2_unlink,
 	.rename = smb2_rename_path,
 	.create_hardlink = smb2_create_hardlink,
-	.query_symlink = smb2_query_symlink,
+	.parse_reparse_point = smb2_parse_reparse_point,
 	.query_mf_symlink = smb3_query_mf_symlink,
 	.create_mf_symlink = smb3_create_mf_symlink,
 	.open = smb2_open_file,
-- 
2.42.1


