Return-Path: <linux-cifs+bounces-843-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 408FA832405
	for <lists+linux-cifs@lfdr.de>; Fri, 19 Jan 2024 05:17:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCF342864B2
	for <lists+linux-cifs@lfdr.de>; Fri, 19 Jan 2024 04:17:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A50186F;
	Fri, 19 Jan 2024 04:17:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="LrEj94/d"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 602B21870
	for <linux-cifs@vger.kernel.org>; Fri, 19 Jan 2024 04:17:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=167.235.159.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705637861; cv=pass; b=OzsQm741P0os6mDoFl5dImsdYjLpiXXOrrRTpX57iXck61x5r2TJevCIi8lWbOb7vyWpoDl7bt7Q2hqUKstv4wM2CFlgVzOIn94UG3hch4k687gRyJ31JZJ0w6PPo6nOx4lZVBHk4fdxGMYUZzLga/LyaocrDfVC3WuLvs/5L8s=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705637861; c=relaxed/simple;
	bh=MofMvPLW0lPLCW+sh2tdwJhDkpxOCTJTapam5QL2R04=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=S6puhTiWkpaSuuHqkRIu6WBPHbiKqLwp5LgnDAJtDHI6nN9cP6j7Rxl0nB5fRrQ12J5ix8ZpFXmlMHDx9rpj/9JLahHvYw+I1FzfTL9t/kqs8cYiD9uV85lavQG/67Nag7ODIUCZ67O36dnsDI49iZltL+4d+GMFbo9FYOILXPQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=LrEj94/d; arc=pass smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
From: Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1705637319;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=scRtB2e1kRHgib0dK7BImVNYHKu+WQf9Dn9RGu/SIZ4=;
	b=LrEj94/d9arS8P/RN6ZvWEn9nFCBGPrKzsJRpF7gzJ1tfhnk0TEOMbfFPVIaCKTaiHNVvb
	hka+M04HzNs+mC8YDTh3IvTC5JsFuW+6AHxR20AFbuslsCD2DMGkNmV+dfAz7WNWdlhdno
	AdEPIX5fjRNwgwLqqf0ZbZxWtv1aiRT9GXu7HK4upEUk9plOhFCL1B2Dyl637rKxHyV6Z6
	9jhw+lzCQbH/VyxbnTkEF0fn0qgagyL0zYNcM8Xh6vTf5LnT8eyTO2/9mf7/rvNDmXSoYX
	8IiwL5bpPPwpeTcT0bSLq2Ago6qa9m3heQscDBhegcyckDmBNCBWnRDY52tvxw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1705637319; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=scRtB2e1kRHgib0dK7BImVNYHKu+WQf9Dn9RGu/SIZ4=;
	b=FaFMDgtx2Dl50T0Ghjbn4LYt9ZvrHTEAglp4NxZh3BJoACwn1L8F8y1LDHBFzVLPcsxML4
	QIgg8q2L1h1ludgxAZbC8BoiXEsuF1efFYVjuDLgZr+0b7ZfTXCRzPf95LwTsZFmN2dJ4Q
	fE+wglDAZjlhUsXm+4vVFjiI7ntnfajdVF5AA5/OVrTqNZtcuqCrRHzwYP9VS9/3aZmTMU
	XuW3M8j9JeEd4IyTDSG0LdCnX0X05vnZghswTJDsj95hOuZisBniiNN3Zx8DluiLlpRZSu
	whohKTYFmIkaEDQ8toNRzNRqa/cjVjidk8YKGPFnZTP211Lbi5GZCw8robY3Fw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1705637319; a=rsa-sha256;
	cv=none;
	b=iAJYuuMlg2v3ejbpTwXkX7qmjpasgFRs0scxKp6ihmthkTE8yoAZsWqz9WEWKIK+sbL9GL
	+Jmzq1jjPTpHa+QGMlaz1gmEBmKTFcEBM9Irc7t3e4pMS1SrN0yLvGy8MwoQgqDiztzzGP
	DGRZS+/hXwy/3hUoVUzchByto2l9TmT91JIFMEKemVRuUUUX6Mywt8K1PH0HDHqB+L7q89
	ll5DBauTAOPb08e6omlW3e2dj9Yq4L6dy2TNggmpkEMlLXOMIFe9f2GMbiGHakqWhPo/Ad
	mo2tGw+5FH9zCW55XUbRQgdQxlSSCSDkrUinHP6CFISLE1KK+l6HiC/KyO/PEg==
To: smfrench@gmail.com
Cc: linux-cifs@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 2/4] smb: client: parse owner/group when creating reparse points
Date: Fri, 19 Jan 2024 01:08:27 -0300
Message-ID: <20240119040829.18428-2-pc@manguebit.com>
In-Reply-To: <20240119040829.18428-1-pc@manguebit.com>
References: <20240119040829.18428-1-pc@manguebit.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse owner/group when creating special files and symlinks under
SMB3.1.1 POSIX mounts.

Move the parsing of owner/group to smb2_compound_op() so we don't have
to duplicate it in both smb2_get_reparse_inode() and
smb311_posix_query_path_info().

Signed-off-by: Paulo Alcantara <pc@manguebit.com>
---
 fs/smb/client/cifsglob.h  |   2 +
 fs/smb/client/inode.c     |  25 +++-----
 fs/smb/client/smb2inode.c | 127 ++++++++++++++++++--------------------
 fs/smb/client/smb2proto.h |   4 +-
 4 files changed, 70 insertions(+), 88 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 1f30f0bf0223..20036fb16cec 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -204,6 +204,8 @@ struct cifs_open_info_data {
 		};
 	} reparse;
 	char *symlink_target;
+	struct cifs_sid posix_owner;
+	struct cifs_sid posix_group;
 	union {
 		struct smb2_file_all_info fi;
 		struct smb311_posix_qinfo posix_fi;
diff --git a/fs/smb/client/inode.c b/fs/smb/client/inode.c
index 9f37c1758f73..cedffaad86ae 100644
--- a/fs/smb/client/inode.c
+++ b/fs/smb/client/inode.c
@@ -665,8 +665,6 @@ static int cifs_sfu_mode(struct cifs_fattr *fattr, const unsigned char *path,
 /* Fill a cifs_fattr struct with info from POSIX info struct */
 static void smb311_posix_info_to_fattr(struct cifs_fattr *fattr,
 				       struct cifs_open_info_data *data,
-				       struct cifs_sid *owner,
-				       struct cifs_sid *group,
 				       struct super_block *sb)
 {
 	struct smb311_posix_qinfo *info = &data->posix_fi;
@@ -722,8 +720,8 @@ static void smb311_posix_info_to_fattr(struct cifs_fattr *fattr,
 		fattr->cf_symlink_target = data->symlink_target;
 		data->symlink_target = NULL;
 	}
-	sid_to_id(cifs_sb, owner, fattr, SIDOWNER);
-	sid_to_id(cifs_sb, group, fattr, SIDGROUP);
+	sid_to_id(cifs_sb, &data->posix_owner, fattr, SIDOWNER);
+	sid_to_id(cifs_sb, &data->posix_group, fattr, SIDGROUP);
 
 	cifs_dbg(FYI, "POSIX query info: mode 0x%x uniqueid 0x%llx nlink %d\n",
 		fattr->cf_mode, fattr->cf_uniqueid, fattr->cf_nlink);
@@ -1070,9 +1068,7 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 				 const unsigned int xid,
 				 struct cifs_tcon *tcon,
 				 const char *full_path,
-				 struct cifs_fattr *fattr,
-				 struct cifs_sid *owner,
-				 struct cifs_sid *group)
+				 struct cifs_fattr *fattr)
 {
 	struct TCP_Server_Info *server = tcon->ses->server;
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
@@ -1117,7 +1113,7 @@ static int reparse_info_to_fattr(struct cifs_open_info_data *data,
 	}
 
 	if (tcon->posix_extensions)
-		smb311_posix_info_to_fattr(fattr, data, owner, group, sb);
+		smb311_posix_info_to_fattr(fattr, data, sb);
 	else
 		cifs_open_info_to_fattr(fattr, data, sb);
 out:
@@ -1171,8 +1167,7 @@ static int cifs_get_fattr(struct cifs_open_info_data *data,
 		 */
 		if (cifs_open_data_reparse(data)) {
 			rc = reparse_info_to_fattr(data, sb, xid, tcon,
-						   full_path, fattr,
-						   NULL, NULL);
+						   full_path, fattr);
 		} else {
 			cifs_open_info_to_fattr(fattr, data, sb);
 		}
@@ -1320,7 +1315,6 @@ static int smb311_posix_get_fattr(struct cifs_open_info_data *data,
 	struct cifs_sb_info *cifs_sb = CIFS_SB(sb);
 	struct cifs_tcon *tcon;
 	struct tcon_link *tlink;
-	struct cifs_sid owner, group;
 	int tmprc;
 	int rc = 0;
 
@@ -1334,8 +1328,7 @@ static int smb311_posix_get_fattr(struct cifs_open_info_data *data,
 	 */
 	if (!data) {
 		rc = smb311_posix_query_path_info(xid, tcon, cifs_sb,
-						  full_path, &tmp_data,
-						  &owner, &group);
+						  full_path, &tmp_data);
 		data = &tmp_data;
 	}
 
@@ -1347,11 +1340,9 @@ static int smb311_posix_get_fattr(struct cifs_open_info_data *data,
 	case 0:
 		if (cifs_open_data_reparse(data)) {
 			rc = reparse_info_to_fattr(data, sb, xid, tcon,
-						   full_path, fattr,
-						   &owner, &group);
+						   full_path, fattr);
 		} else {
-			smb311_posix_info_to_fattr(fattr, data,
-						   &owner, &group, sb);
+			smb311_posix_info_to_fattr(fattr, data, sb);
 		}
 		break;
 	case -EREMOTE:
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 5053a5550abe..f38cdc38f10c 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -56,6 +56,35 @@ static inline __u32 file_create_options(struct dentry *dentry)
 	return 0;
 }
 
+/* Parse owner and group from SMB3.1.1 POSIX query info */
+static int parse_posix_sids(struct cifs_open_info_data *data,
+			    struct kvec *rsp_iov)
+{
+	struct smb2_query_info_rsp *qi = rsp_iov->iov_base;
+	unsigned int out_len = le32_to_cpu(qi->OutputBufferLength);
+	unsigned int qi_len = sizeof(data->posix_fi);
+	int owner_len, group_len;
+	u8 *sidsbuf, *sidsbuf_end;
+
+	if (out_len <= qi_len)
+		return -EINVAL;
+
+	sidsbuf = (u8 *)qi + le16_to_cpu(qi->OutputBufferOffset) + qi_len;
+	sidsbuf_end = sidsbuf + out_len - qi_len;
+
+	owner_len = posix_info_sid_size(sidsbuf, sidsbuf_end);
+	if (owner_len == -1)
+		return -EINVAL;
+
+	memcpy(&data->posix_owner, sidsbuf, owner_len);
+	group_len = posix_info_sid_size(sidsbuf + owner_len, sidsbuf_end);
+	if (group_len == -1)
+		return -EINVAL;
+
+	memcpy(&data->posix_group, sidsbuf + owner_len, group_len);
+	return 0;
+}
+
 /*
  * note: If cfile is passed, the reference to it is dropped here.
  * So make sure that you do not reuse cfile after return from this func.
@@ -69,7 +98,6 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 			    __u32 desired_access, __u32 create_disposition,
 			    __u32 create_options, umode_t mode, struct kvec *in_iov,
 			    int *cmds, int num_cmds, struct cifsFileInfo *cfile,
-			    __u8 **extbuf, size_t *extbuflen,
 			    struct kvec *out_iov, int *out_buftype)
 {
 
@@ -494,21 +522,9 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 					&rsp_iov[i + 1], sizeof(idata->posix_fi) /* add SIDs */,
 					(char *)&idata->posix_fi);
 			}
-			if (rc == 0) {
-				unsigned int length = le32_to_cpu(qi_rsp->OutputBufferLength);
+			if (rc == 0)
+				rc = parse_posix_sids(idata, &rsp_iov[i + 1]);
 
-				if (length > sizeof(idata->posix_fi)) {
-					char *base = (char *)rsp_iov[i + 1].iov_base +
-						le16_to_cpu(qi_rsp->OutputBufferOffset) +
-						sizeof(idata->posix_fi);
-					*extbuflen = length - sizeof(idata->posix_fi);
-					*extbuf = kmemdup(base, *extbuflen, GFP_KERNEL);
-					if (!*extbuf)
-						rc = -ENOMEM;
-				} else {
-					rc = -EINVAL;
-				}
-			}
 			SMB2_query_info_free(&rqst[num_rqst++]);
 			if (rc)
 				trace_smb3_posix_query_info_compound_err(xid,  ses->Suid,
@@ -693,9 +709,8 @@ int smb2_query_path_info(const unsigned int xid,
 	cifs_get_readable_path(tcon, full_path, &cfile);
 	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 			      FILE_READ_ATTRIBUTES, FILE_OPEN,
-			      create_options, ACL_NO_MODE,
-			      in_iov, cmds, 1, cfile,
-			      NULL, NULL, out_iov, out_buftype);
+			      create_options, ACL_NO_MODE, in_iov,
+			      cmds, 1, cfile, out_iov, out_buftype);
 	hdr = out_iov[0].iov_base;
 	/*
 	 * If first iov is unset, then SMB session was dropped or we've got a
@@ -722,8 +737,8 @@ int smb2_query_path_info(const unsigned int xid,
 		cifs_get_readable_path(tcon, full_path, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      FILE_READ_ATTRIBUTES, FILE_OPEN,
-				      create_options, ACL_NO_MODE, in_iov, cmds,
-				      num_cmds, cfile, NULL, NULL, NULL, NULL);
+				      create_options, ACL_NO_MODE, in_iov,
+				      cmds, num_cmds, cfile, NULL, NULL);
 		break;
 	case -EREMOTE:
 		break;
@@ -750,19 +765,13 @@ int smb311_posix_query_path_info(const unsigned int xid,
 				 struct cifs_tcon *tcon,
 				 struct cifs_sb_info *cifs_sb,
 				 const char *full_path,
-				 struct cifs_open_info_data *data,
-				 struct cifs_sid *owner,
-				 struct cifs_sid *group)
+				 struct cifs_open_info_data *data)
 {
 	int rc;
 	__u32 create_options = 0;
 	struct cifsFileInfo *cfile;
 	struct kvec in_iov[2], out_iov[3] = {};
 	int out_buftype[3] = {};
-	__u8 *sidsbuf = NULL;
-	__u8 *sidsbuf_end = NULL;
-	size_t sidsbuflen = 0;
-	size_t owner_len, group_len;
 	int cmds[2] = { SMB2_OP_POSIX_QUERY_INFO,  };
 	int i, num_cmds;
 
@@ -782,8 +791,8 @@ int smb311_posix_query_path_info(const unsigned int xid,
 	cifs_get_readable_path(tcon, full_path, &cfile);
 	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 			      FILE_READ_ATTRIBUTES, FILE_OPEN,
-			      create_options, ACL_NO_MODE, in_iov, cmds, 1,
-			      cfile, &sidsbuf, &sidsbuflen, out_iov, out_buftype);
+			      create_options, ACL_NO_MODE, in_iov,
+			      cmds, 1, cfile, out_iov, out_buftype);
 	/*
 	 * If first iov is unset, then SMB session was dropped or we've got a
 	 * cached open file (@cfile).
@@ -810,32 +819,12 @@ int smb311_posix_query_path_info(const unsigned int xid,
 		cifs_get_readable_path(tcon, full_path, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      FILE_READ_ATTRIBUTES, FILE_OPEN,
-				      create_options, ACL_NO_MODE, in_iov, cmds,
-				      num_cmds, cfile, &sidsbuf, &sidsbuflen, NULL, NULL);
+				      create_options, ACL_NO_MODE, in_iov,
+				      cmds, num_cmds, cfile, NULL, NULL);
 		break;
 	}
 
 out:
-	if (rc == 0) {
-		sidsbuf_end = sidsbuf + sidsbuflen;
-
-		owner_len = posix_info_sid_size(sidsbuf, sidsbuf_end);
-		if (owner_len == -1) {
-			rc = -EINVAL;
-			goto out;
-		}
-		memcpy(owner, sidsbuf, owner_len);
-
-		group_len = posix_info_sid_size(
-			sidsbuf + owner_len, sidsbuf_end);
-		if (group_len == -1) {
-			rc = -EINVAL;
-			goto out;
-		}
-		memcpy(group, sidsbuf + owner_len, group_len);
-	}
-
-	kfree(sidsbuf);
 	for (i = 0; i < ARRAY_SIZE(out_buftype); i++)
 		free_rsp_buf(out_buftype[i], out_iov[i].iov_base);
 	return rc;
@@ -848,9 +837,9 @@ smb2_mkdir(const unsigned int xid, struct inode *parent_inode, umode_t mode,
 {
 	return smb2_compound_op(xid, tcon, cifs_sb, name,
 				FILE_WRITE_ATTRIBUTES, FILE_CREATE,
-				CREATE_NOT_FILE, mode, NULL,
-				&(int){SMB2_OP_MKDIR}, 1,
-				NULL, NULL, NULL, NULL, NULL);
+				CREATE_NOT_FILE, mode,
+				NULL, &(int){SMB2_OP_MKDIR}, 1,
+				NULL, NULL, NULL);
 }
 
 void
@@ -875,7 +864,7 @@ smb2_mkdir_setinfo(struct inode *inode, const char *name,
 				 FILE_WRITE_ATTRIBUTES, FILE_CREATE,
 				 CREATE_NOT_FILE, ACL_NO_MODE, &in_iov,
 				 &(int){SMB2_OP_SET_INFO}, 1,
-				 cfile, NULL, NULL, NULL, NULL);
+				 cfile, NULL, NULL);
 	if (tmprc == 0)
 		cifs_i->cifsAttrs = dosattrs;
 }
@@ -887,8 +876,9 @@ smb2_rmdir(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 	drop_cached_dir_by_name(xid, tcon, name, cifs_sb);
 	return smb2_compound_op(xid, tcon, cifs_sb, name,
 				DELETE, FILE_OPEN, CREATE_NOT_FILE,
-				ACL_NO_MODE, NULL, &(int){SMB2_OP_RMDIR}, 1,
-				NULL, NULL, NULL, NULL, NULL);
+				ACL_NO_MODE, NULL,
+				&(int){SMB2_OP_RMDIR}, 1,
+				NULL, NULL, NULL);
 }
 
 int
@@ -897,8 +887,9 @@ smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 {
 	return smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FILE_OPEN,
 				CREATE_DELETE_ON_CLOSE | OPEN_REPARSE_POINT,
-				ACL_NO_MODE, NULL, &(int){SMB2_OP_DELETE}, 1,
-				NULL, NULL, NULL, NULL, NULL);
+				ACL_NO_MODE, NULL,
+				&(int){SMB2_OP_DELETE}, 1,
+				NULL, NULL, NULL);
 }
 
 static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
@@ -919,8 +910,8 @@ static int smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
 	in_iov.iov_base = smb2_to_name;
 	in_iov.iov_len = 2 * UniStrnlen((wchar_t *)smb2_to_name, PATH_MAX);
 	rc = smb2_compound_op(xid, tcon, cifs_sb, from_name, access,
-			      FILE_OPEN, create_options, ACL_NO_MODE, &in_iov,
-			      &command, 1, cfile, NULL, NULL, NULL, NULL);
+			      FILE_OPEN, create_options, ACL_NO_MODE,
+			      &in_iov, &command, 1, cfile, NULL, NULL);
 smb2_rename_path:
 	kfree(smb2_to_name);
 	return rc;
@@ -971,7 +962,7 @@ smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
 				FILE_WRITE_DATA, FILE_OPEN,
 				0, ACL_NO_MODE, &in_iov,
 				&(int){SMB2_OP_SET_EOF}, 1,
-				cfile, NULL, NULL, NULL, NULL);
+				cfile, NULL, NULL);
 }
 
 int
@@ -999,8 +990,8 @@ smb2_set_file_info(struct inode *inode, const char *full_path,
 	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 			      FILE_WRITE_ATTRIBUTES, FILE_OPEN,
 			      0, ACL_NO_MODE, &in_iov,
-			      &(int){SMB2_OP_SET_INFO}, 1, cfile,
-			      NULL, NULL, NULL, NULL);
+			      &(int){SMB2_OP_SET_INFO}, 1,
+			      cfile, NULL, NULL);
 	cifs_put_tlink(tlink);
 	return rc;
 }
@@ -1035,7 +1026,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 		cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      da, cd, co, ACL_NO_MODE, in_iov,
-				      cmds, 2, cfile, NULL, NULL, NULL, NULL);
+				      cmds, 2, cfile, NULL, NULL);
 		if (!rc) {
 			rc = smb311_posix_get_inode_info(&new, full_path,
 							 data, sb, xid);
@@ -1045,7 +1036,7 @@ struct inode *smb2_get_reparse_inode(struct cifs_open_info_data *data,
 		cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      da, cd, co, ACL_NO_MODE, in_iov,
-				      cmds, 2, cfile, NULL, NULL, NULL, NULL);
+				      cmds, 2, cfile, NULL, NULL);
 		if (!rc) {
 			rc = cifs_get_inode_info(&new, full_path,
 						 data, sb, xid, NULL);
@@ -1072,8 +1063,8 @@ int smb2_query_reparse_point(const unsigned int xid,
 	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 			      FILE_READ_ATTRIBUTES, FILE_OPEN,
 			      OPEN_REPARSE_POINT, ACL_NO_MODE, &in_iov,
-			      &(int){SMB2_OP_GET_REPARSE}, 1, cfile,
-			      NULL, NULL, NULL, NULL);
+			      &(int){SMB2_OP_GET_REPARSE}, 1,
+			      cfile, NULL, NULL);
 	if (rc)
 		goto out;
 
diff --git a/fs/smb/client/smb2proto.h b/fs/smb/client/smb2proto.h
index 343ada691e76..0034b537b0b3 100644
--- a/fs/smb/client/smb2proto.h
+++ b/fs/smb/client/smb2proto.h
@@ -299,9 +299,7 @@ int smb311_posix_query_path_info(const unsigned int xid,
 				 struct cifs_tcon *tcon,
 				 struct cifs_sb_info *cifs_sb,
 				 const char *full_path,
-				 struct cifs_open_info_data *data,
-				 struct cifs_sid *owner,
-				 struct cifs_sid *group);
+				 struct cifs_open_info_data *data);
 int posix_info_parse(const void *beg, const void *end,
 		     struct smb2_posix_info_parsed *out);
 int posix_info_sid_size(const void *beg, const void *end);
-- 
2.43.0


