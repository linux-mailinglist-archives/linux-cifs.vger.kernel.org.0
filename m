Return-Path: <linux-cifs+bounces-176-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 85C4A7F9104
	for <lists+linux-cifs@lfdr.de>; Sun, 26 Nov 2023 03:55:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3C955281372
	for <lists+linux-cifs@lfdr.de>; Sun, 26 Nov 2023 02:55:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE0247EF;
	Sun, 26 Nov 2023 02:55:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="VsFP0Y2p"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CBA9BC
	for <linux-cifs@vger.kernel.org>; Sat, 25 Nov 2023 18:55:33 -0800 (PST)
From: Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1700967332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RchCake0izUGZnMOuokpYZnvkthSEG8+QvyEOkuahJU=;
	b=VsFP0Y2ppzu4VRt4Jg1sDdsZ5VuxasJqbNA2CROlbjQZrzSGyA1A4+BwGW0Pj2WpGzulJK
	UaCjgyVFSJqsvi8bnP0+DNFvef2jo9MwhzkHHU1i6HU/61l5rA0jZ4fVxHkeN4xrKcaO8c
	yFnrE5GHQKe+uikHQVUyGNt98PzSY4FUcTcMleBtgG1CRJrBvABywhCe2aRb2LfbkOxbO/
	i47jsqtJi5ukp1EYkc8A93n/qKsyCRyEQvQ2ZEoL2a1DbWefnu5NCOxo3w7XXTcoCu0lAu
	zIi05o9wx4F4Nh6SE+dCIRmiqhE1R0YRpHMMYjTr0yzydcNksddUV0sphEIMTg==
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1700967332; a=rsa-sha256;
	cv=none;
	b=XDkrClaq35pqfJY0LwAiIiGGBUSF6BNXQtSNgv1HZR/a2F3IQjbOR0+m4VDUfpYv21Vezs
	HKBlaeWjccoj2NtXI2pYbjvHhDhafsLDCfKP/tIS2+pEafet10jHaYN4YO1vDEFImPt2QW
	NPOLYafyVg09CVPiT7g9QpX1OOCQFeNkDC6JEs1H0B/4GrWSNEFWcfQVj4aKxHRTM8H4dL
	GXgoaMrmTL+YuyWc0N8DUIq2RbIH9FKLasIijzWJZgxRwoT/8NAjsCbiasZGQWURcwfO/Z
	5kupKcZzCC5jpwpVgVyrFPoxuSLTcH2PNE8mNtqTYuKtMM3b0J4ftqdC8SABzQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1700967332; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RchCake0izUGZnMOuokpYZnvkthSEG8+QvyEOkuahJU=;
	b=emfYiOjthQTIjlAO8pxHMXankFnzkkWP2OV/Xq2tcBXQXDE8j19hRSiHhOhBG0tSYb3I4o
	4H6Ta+YA4cR/Ihh48RkuIhjlmQqrrQP68+uGEsgyIkyC934VNzs8AGgj1+sDol8YVkpWDe
	A/kQiDX6HQcSSFMXEPdv7LVUcLIRM2NrEfVF5UjL639a0I5TZKDDljAQfigJ0Tmu6WNu1n
	P5E6zF0hK69ukKunZ4p/1TjzvapH9nmFvZTzqVws8fevSjsa67nGLadSSPNZBc0oLZbN15
	VQ768GQuZ68Q2chRtEDxlkTT+SiDzZncuLDNAn+VITPppwIFqnj6c5APj5K3tg==
To: smfrench@gmail.com
Cc: linux-cifs@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH v2 1/9] smb: client: extend smb2_compound_op() to accept more commands
Date: Sat, 25 Nov 2023 23:55:02 -0300
Message-ID: <20231126025510.28147-2-pc@manguebit.com>
In-Reply-To: <20231126025510.28147-1-pc@manguebit.com>
References: <20231126025510.28147-1-pc@manguebit.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Make smb2_compound_op() accept up to MAX_COMPOUND(5) commands to be
sent over a single compounded request.

This will allow next commits to read and write reparse files through a
single roundtrip to the server.

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
---
 fs/smb/client/cifsglob.h  |   4 +-
 fs/smb/client/smb2inode.c | 790 +++++++++++++++++++-------------------
 2 files changed, 406 insertions(+), 388 deletions(-)

diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 7558167f603c..be84683b01ee 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -2238,8 +2238,8 @@ static inline void cifs_sg_set_buf(struct sg_table *sgtable,
 
 struct smb2_compound_vars {
 	struct cifs_open_parms oparms;
-	struct kvec rsp_iov[3];
-	struct smb_rqst rqst[3];
+	struct kvec rsp_iov[MAX_COMPOUND];
+	struct smb_rqst rqst[MAX_COMPOUND];
 	struct kvec open_iov[SMB2_CREATE_IOV_SIZE];
 	struct kvec qi_iov;
 	struct kvec io_iov[SMB2_IOCTL_IOV_SIZE];
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index c94940af5d4b..98fa4f02fbd3 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -26,15 +26,6 @@
 #include "cached_dir.h"
 #include "smb2status.h"
 
-static void
-free_set_inf_compound(struct smb_rqst *rqst)
-{
-	if (rqst[1].rq_iov)
-		SMB2_set_info_free(&rqst[1]);
-	if (rqst[2].rq_iov)
-		SMB2_close_free(&rqst[2]);
-}
-
 /*
  * note: If cfile is passed, the reference to it is dropped here.
  * So make sure that you do not reuse cfile after return from this func.
@@ -45,8 +36,9 @@ free_set_inf_compound(struct smb_rqst *rqst)
  */
 static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 			    struct cifs_sb_info *cifs_sb, const char *full_path,
-			    __u32 desired_access, __u32 create_disposition, __u32 create_options,
-			    umode_t mode, void *ptr, int command, struct cifsFileInfo *cfile,
+			    __u32 desired_access, __u32 create_disposition,
+			    __u32 create_options, umode_t mode, struct kvec *in_iov,
+			    int *cmds, int num_cmds, struct cifsFileInfo *cfile,
 			    __u8 **extbuf, size_t *extbuflen,
 			    struct kvec *out_iov, int *out_buftype)
 {
@@ -59,8 +51,8 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 	struct cifs_fid fid;
 	struct cifs_ses *ses = tcon->ses;
 	struct TCP_Server_Info *server;
-	int num_rqst = 0;
-	int resp_buftype[3];
+	int num_rqst = 0, i;
+	int resp_buftype[MAX_COMPOUND];
 	struct smb2_query_info_rsp *qi_rsp = NULL;
 	struct cifs_open_info_data *idata;
 	int flags = 0;
@@ -80,7 +72,8 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 	if (smb3_encryption_required(tcon))
 		flags |= CIFS_TRANSFORM_REQ;
 
-	resp_buftype[0] = resp_buftype[1] = resp_buftype[2] = CIFS_NO_BUFFER;
+	for (i = 0; i < ARRAY_SIZE(resp_buftype); i++)
+		resp_buftype[i] = CIFS_NO_BUFFER;
 
 	/* We already have a handle so we can skip the open */
 	if (cfile)
@@ -118,242 +111,246 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 	num_rqst++;
 	rc = 0;
 
-	/* Operation */
-	switch (command) {
-	case SMB2_OP_QUERY_INFO:
-		rqst[num_rqst].rq_iov = &vars->qi_iov;
-		rqst[num_rqst].rq_nvec = 1;
+	for (i = 0; i < num_cmds; i++) {
+		/* Operation */
+		switch (cmds[i]) {
+		case SMB2_OP_QUERY_INFO:
+			rqst[num_rqst].rq_iov = &vars->qi_iov;
+			rqst[num_rqst].rq_nvec = 1;
 
-		if (cfile)
-			rc = SMB2_query_info_init(tcon, server,
-				&rqst[num_rqst],
-				cfile->fid.persistent_fid,
-				cfile->fid.volatile_fid,
-				FILE_ALL_INFORMATION,
-				SMB2_O_INFO_FILE, 0,
-				sizeof(struct smb2_file_all_info) +
-					  PATH_MAX * 2, 0, NULL);
-		else {
-			rc = SMB2_query_info_init(tcon, server,
-				&rqst[num_rqst],
-				COMPOUND_FID,
-				COMPOUND_FID,
-				FILE_ALL_INFORMATION,
-				SMB2_O_INFO_FILE, 0,
-				sizeof(struct smb2_file_all_info) +
-					  PATH_MAX * 2, 0, NULL);
-			if (!rc) {
-				smb2_set_next_command(tcon, &rqst[num_rqst]);
-				smb2_set_related(&rqst[num_rqst]);
+			if (cfile) {
+				rc = SMB2_query_info_init(tcon, server,
+							  &rqst[num_rqst],
+							  cfile->fid.persistent_fid,
+							  cfile->fid.volatile_fid,
+							  FILE_ALL_INFORMATION,
+							  SMB2_O_INFO_FILE, 0,
+							  sizeof(struct smb2_file_all_info) +
+							  PATH_MAX * 2, 0, NULL);
+			} else {
+				rc = SMB2_query_info_init(tcon, server,
+							  &rqst[num_rqst],
+							  COMPOUND_FID,
+							  COMPOUND_FID,
+							  FILE_ALL_INFORMATION,
+							  SMB2_O_INFO_FILE, 0,
+							  sizeof(struct smb2_file_all_info) +
+							  PATH_MAX * 2, 0, NULL);
+				if (!rc) {
+					smb2_set_next_command(tcon, &rqst[num_rqst]);
+					smb2_set_related(&rqst[num_rqst]);
+				}
 			}
-		}
 
-		if (rc)
-			goto finished;
-		num_rqst++;
-		trace_smb3_query_info_compound_enter(xid, ses->Suid, tcon->tid,
-						     full_path);
-		break;
-	case SMB2_OP_POSIX_QUERY_INFO:
-		rqst[num_rqst].rq_iov = &vars->qi_iov;
-		rqst[num_rqst].rq_nvec = 1;
+			if (rc)
+				goto finished;
+			num_rqst++;
+			trace_smb3_query_info_compound_enter(xid, ses->Suid,
+							     tcon->tid, full_path);
+			break;
+		case SMB2_OP_POSIX_QUERY_INFO:
+			rqst[num_rqst].rq_iov = &vars->qi_iov;
+			rqst[num_rqst].rq_nvec = 1;
 
-		if (cfile)
-			rc = SMB2_query_info_init(tcon, server,
-				&rqst[num_rqst],
-				cfile->fid.persistent_fid,
-				cfile->fid.volatile_fid,
-				SMB_FIND_FILE_POSIX_INFO,
-				SMB2_O_INFO_FILE, 0,
+			if (cfile) {
 				/* TBD: fix following to allow for longer SIDs */
-				sizeof(struct smb311_posix_qinfo *) + (PATH_MAX * 2) +
-				(sizeof(struct cifs_sid) * 2), 0, NULL);
-		else {
-			rc = SMB2_query_info_init(tcon, server,
-				&rqst[num_rqst],
-				COMPOUND_FID,
-				COMPOUND_FID,
-				SMB_FIND_FILE_POSIX_INFO,
-				SMB2_O_INFO_FILE, 0,
-				sizeof(struct smb311_posix_qinfo *) + (PATH_MAX * 2) +
-				(sizeof(struct cifs_sid) * 2), 0, NULL);
-			if (!rc) {
-				smb2_set_next_command(tcon, &rqst[num_rqst]);
-				smb2_set_related(&rqst[num_rqst]);
+				rc = SMB2_query_info_init(tcon, server,
+							  &rqst[num_rqst],
+							  cfile->fid.persistent_fid,
+							  cfile->fid.volatile_fid,
+							  SMB_FIND_FILE_POSIX_INFO,
+							  SMB2_O_INFO_FILE, 0,
+							  sizeof(struct smb311_posix_qinfo *) +
+							  (PATH_MAX * 2) +
+							  (sizeof(struct cifs_sid) * 2), 0, NULL);
+			} else {
+				rc = SMB2_query_info_init(tcon, server,
+							  &rqst[num_rqst],
+							  COMPOUND_FID,
+							  COMPOUND_FID,
+							  SMB_FIND_FILE_POSIX_INFO,
+							  SMB2_O_INFO_FILE, 0,
+							  sizeof(struct smb311_posix_qinfo *) +
+							  (PATH_MAX * 2) +
+							  (sizeof(struct cifs_sid) * 2), 0, NULL);
+				if (!rc) {
+					smb2_set_next_command(tcon, &rqst[num_rqst]);
+					smb2_set_related(&rqst[num_rqst]);
+				}
 			}
-		}
-
-		if (rc)
-			goto finished;
-		num_rqst++;
-		trace_smb3_posix_query_info_compound_enter(xid, ses->Suid, tcon->tid, full_path);
-		break;
-	case SMB2_OP_DELETE:
-		trace_smb3_delete_enter(xid, ses->Suid, tcon->tid, full_path);
-		break;
-	case SMB2_OP_MKDIR:
-		/*
-		 * Directories are created through parameters in the
-		 * SMB2_open() call.
-		 */
-		trace_smb3_mkdir_enter(xid, ses->Suid, tcon->tid, full_path);
-		break;
-	case SMB2_OP_RMDIR:
-		rqst[num_rqst].rq_iov = &vars->si_iov[0];
-		rqst[num_rqst].rq_nvec = 1;
-
-		size[0] = 1; /* sizeof __u8 See MS-FSCC section 2.4.11 */
-		data[0] = &delete_pending[0];
-
-		rc = SMB2_set_info_init(tcon, server,
-					&rqst[num_rqst], COMPOUND_FID,
-					COMPOUND_FID, current->tgid,
-					FILE_DISPOSITION_INFORMATION,
-					SMB2_O_INFO_FILE, 0, data, size);
-		if (rc)
-			goto finished;
-		smb2_set_next_command(tcon, &rqst[num_rqst]);
-		smb2_set_related(&rqst[num_rqst++]);
-		trace_smb3_rmdir_enter(xid, ses->Suid, tcon->tid, full_path);
-		break;
-	case SMB2_OP_SET_EOF:
-		rqst[num_rqst].rq_iov = &vars->si_iov[0];
-		rqst[num_rqst].rq_nvec = 1;
-
-		size[0] = 8; /* sizeof __le64 */
-		data[0] = ptr;
-
-		if (cfile) {
-			rc = SMB2_set_info_init(tcon, server,
-						&rqst[num_rqst],
-						cfile->fid.persistent_fid,
-						cfile->fid.volatile_fid,
-						current->tgid,
-						FILE_END_OF_FILE_INFORMATION,
-						SMB2_O_INFO_FILE, 0,
-						data, size);
-		} else {
-			rc = SMB2_set_info_init(tcon, server,
-						&rqst[num_rqst],
-						COMPOUND_FID,
-						COMPOUND_FID,
-						current->tgid,
-						FILE_END_OF_FILE_INFORMATION,
-						SMB2_O_INFO_FILE, 0,
-						data, size);
-			if (!rc) {
-				smb2_set_next_command(tcon, &rqst[num_rqst]);
-				smb2_set_related(&rqst[num_rqst]);
-			}
-		}
-		if (rc)
-			goto finished;
-		num_rqst++;
-		trace_smb3_set_eof_enter(xid, ses->Suid, tcon->tid, full_path);
-		break;
-	case SMB2_OP_SET_INFO:
-		rqst[num_rqst].rq_iov = &vars->si_iov[0];
-		rqst[num_rqst].rq_nvec = 1;
-
 
-		size[0] = sizeof(FILE_BASIC_INFO);
-		data[0] = ptr;
+			if (rc)
+				goto finished;
+			num_rqst++;
+			trace_smb3_posix_query_info_compound_enter(xid, ses->Suid,
+								   tcon->tid, full_path);
+			break;
+		case SMB2_OP_DELETE:
+			trace_smb3_delete_enter(xid, ses->Suid, tcon->tid, full_path);
+			break;
+		case SMB2_OP_MKDIR:
+			/*
+			 * Directories are created through parameters in the
+			 * SMB2_open() call.
+			 */
+			trace_smb3_mkdir_enter(xid, ses->Suid, tcon->tid, full_path);
+			break;
+		case SMB2_OP_RMDIR:
+			rqst[num_rqst].rq_iov = &vars->si_iov[0];
+			rqst[num_rqst].rq_nvec = 1;
+
+			size[0] = 1; /* sizeof __u8 See MS-FSCC section 2.4.11 */
+			data[0] = &delete_pending[0];
 
-		if (cfile)
 			rc = SMB2_set_info_init(tcon, server,
-				&rqst[num_rqst],
-				cfile->fid.persistent_fid,
-				cfile->fid.volatile_fid, current->tgid,
-				FILE_BASIC_INFORMATION,
-				SMB2_O_INFO_FILE, 0, data, size);
-		else {
-			rc = SMB2_set_info_init(tcon, server,
-				&rqst[num_rqst],
-				COMPOUND_FID,
-				COMPOUND_FID, current->tgid,
-				FILE_BASIC_INFORMATION,
-				SMB2_O_INFO_FILE, 0, data, size);
-			if (!rc) {
-				smb2_set_next_command(tcon, &rqst[num_rqst]);
-				smb2_set_related(&rqst[num_rqst]);
+						&rqst[num_rqst], COMPOUND_FID,
+						COMPOUND_FID, current->tgid,
+						FILE_DISPOSITION_INFORMATION,
+						SMB2_O_INFO_FILE, 0, data, size);
+			if (rc)
+				goto finished;
+			smb2_set_next_command(tcon, &rqst[num_rqst]);
+			smb2_set_related(&rqst[num_rqst++]);
+			trace_smb3_rmdir_enter(xid, ses->Suid, tcon->tid, full_path);
+			break;
+		case SMB2_OP_SET_EOF:
+			rqst[num_rqst].rq_iov = &vars->si_iov[0];
+			rqst[num_rqst].rq_nvec = 1;
+
+			size[0] = in_iov[i].iov_len;
+			data[0] = in_iov[i].iov_base;
+
+			if (cfile) {
+				rc = SMB2_set_info_init(tcon, server,
+							&rqst[num_rqst],
+							cfile->fid.persistent_fid,
+							cfile->fid.volatile_fid,
+							current->tgid,
+							FILE_END_OF_FILE_INFORMATION,
+							SMB2_O_INFO_FILE, 0,
+							data, size);
+			} else {
+				rc = SMB2_set_info_init(tcon, server,
+							&rqst[num_rqst],
+							COMPOUND_FID,
+							COMPOUND_FID,
+							current->tgid,
+							FILE_END_OF_FILE_INFORMATION,
+							SMB2_O_INFO_FILE, 0,
+							data, size);
+				if (!rc) {
+					smb2_set_next_command(tcon, &rqst[num_rqst]);
+					smb2_set_related(&rqst[num_rqst]);
+				}
+			}
+			if (rc)
+				goto finished;
+			num_rqst++;
+			trace_smb3_set_eof_enter(xid, ses->Suid, tcon->tid, full_path);
+			break;
+		case SMB2_OP_SET_INFO:
+			rqst[num_rqst].rq_iov = &vars->si_iov[0];
+			rqst[num_rqst].rq_nvec = 1;
+
+			size[0] = in_iov[i].iov_len;
+			data[0] = in_iov[i].iov_base;
+
+			if (cfile) {
+				rc = SMB2_set_info_init(tcon, server,
+							&rqst[num_rqst],
+							cfile->fid.persistent_fid,
+							cfile->fid.volatile_fid, current->tgid,
+							FILE_BASIC_INFORMATION,
+							SMB2_O_INFO_FILE, 0, data, size);
+			} else {
+				rc = SMB2_set_info_init(tcon, server,
+							&rqst[num_rqst],
+							COMPOUND_FID,
+							COMPOUND_FID, current->tgid,
+							FILE_BASIC_INFORMATION,
+							SMB2_O_INFO_FILE, 0, data, size);
+				if (!rc) {
+					smb2_set_next_command(tcon, &rqst[num_rqst]);
+					smb2_set_related(&rqst[num_rqst]);
+				}
 			}
-		}
 
-		if (rc)
-			goto finished;
-		num_rqst++;
-		trace_smb3_set_info_compound_enter(xid, ses->Suid, tcon->tid,
-						   full_path);
-		break;
-	case SMB2_OP_RENAME:
-		rqst[num_rqst].rq_iov = &vars->si_iov[0];
-		rqst[num_rqst].rq_nvec = 2;
+			if (rc)
+				goto finished;
+			num_rqst++;
+			trace_smb3_set_info_compound_enter(xid, ses->Suid,
+							   tcon->tid, full_path);
+			break;
+		case SMB2_OP_RENAME:
+			rqst[num_rqst].rq_iov = &vars->si_iov[0];
+			rqst[num_rqst].rq_nvec = 2;
+
+			len = in_iov[i].iov_len;
+
+			vars->rename_info.ReplaceIfExists = 1;
+			vars->rename_info.RootDirectory = 0;
+			vars->rename_info.FileNameLength = cpu_to_le32(len);
+
+			size[0] = sizeof(struct smb2_file_rename_info);
+			data[0] = &vars->rename_info;
+
+			size[1] = len + 2 /* null */;
+			data[1] = in_iov[i].iov_base;
+
+			if (cfile) {
+				rc = SMB2_set_info_init(tcon, server,
+							&rqst[num_rqst],
+							cfile->fid.persistent_fid,
+							cfile->fid.volatile_fid,
+							current->tgid, FILE_RENAME_INFORMATION,
+							SMB2_O_INFO_FILE, 0, data, size);
+			} else {
+				rc = SMB2_set_info_init(tcon, server,
+							&rqst[num_rqst],
+							COMPOUND_FID, COMPOUND_FID,
+							current->tgid, FILE_RENAME_INFORMATION,
+							SMB2_O_INFO_FILE, 0, data, size);
+				if (!rc) {
+					smb2_set_next_command(tcon, &rqst[num_rqst]);
+					smb2_set_related(&rqst[num_rqst]);
+				}
+			}
+			if (rc)
+				goto finished;
+			num_rqst++;
+			trace_smb3_rename_enter(xid, ses->Suid, tcon->tid, full_path);
+			break;
+		case SMB2_OP_HARDLINK:
+			rqst[num_rqst].rq_iov = &vars->si_iov[0];
+			rqst[num_rqst].rq_nvec = 2;
 
-		len = (2 * UniStrnlen((wchar_t *)ptr, PATH_MAX));
+			len = in_iov[i].iov_len;
 
-		vars->rename_info.ReplaceIfExists = 1;
-		vars->rename_info.RootDirectory = 0;
-		vars->rename_info.FileNameLength = cpu_to_le32(len);
+			vars->link_info.ReplaceIfExists = 0;
+			vars->link_info.RootDirectory = 0;
+			vars->link_info.FileNameLength = cpu_to_le32(len);
 
-		size[0] = sizeof(struct smb2_file_rename_info);
-		data[0] = &vars->rename_info;
+			size[0] = sizeof(struct smb2_file_link_info);
+			data[0] = &vars->link_info;
 
-		size[1] = len + 2 /* null */;
-		data[1] = (__le16 *)ptr;
+			size[1] = len + 2 /* null */;
+			data[1] = in_iov[i].iov_base;
 
-		if (cfile)
-			rc = SMB2_set_info_init(tcon, server,
-						&rqst[num_rqst],
-						cfile->fid.persistent_fid,
-						cfile->fid.volatile_fid,
-					current->tgid, FILE_RENAME_INFORMATION,
-					SMB2_O_INFO_FILE, 0, data, size);
-		else {
 			rc = SMB2_set_info_init(tcon, server,
-					&rqst[num_rqst],
-					COMPOUND_FID, COMPOUND_FID,
-					current->tgid, FILE_RENAME_INFORMATION,
-					SMB2_O_INFO_FILE, 0, data, size);
-			if (!rc) {
-				smb2_set_next_command(tcon, &rqst[num_rqst]);
-				smb2_set_related(&rqst[num_rqst]);
-			}
+						&rqst[num_rqst], COMPOUND_FID,
+						COMPOUND_FID, current->tgid,
+						FILE_LINK_INFORMATION,
+						SMB2_O_INFO_FILE, 0, data, size);
+			if (rc)
+				goto finished;
+			smb2_set_next_command(tcon, &rqst[num_rqst]);
+			smb2_set_related(&rqst[num_rqst++]);
+			trace_smb3_hardlink_enter(xid, ses->Suid, tcon->tid, full_path);
+			break;
+		default:
+			cifs_dbg(VFS, "Invalid command\n");
+			rc = -EINVAL;
 		}
-		if (rc)
-			goto finished;
-		num_rqst++;
-		trace_smb3_rename_enter(xid, ses->Suid, tcon->tid, full_path);
-		break;
-	case SMB2_OP_HARDLINK:
-		rqst[num_rqst].rq_iov = &vars->si_iov[0];
-		rqst[num_rqst].rq_nvec = 2;
-
-		len = (2 * UniStrnlen((wchar_t *)ptr, PATH_MAX));
-
-		vars->link_info.ReplaceIfExists = 0;
-		vars->link_info.RootDirectory = 0;
-		vars->link_info.FileNameLength = cpu_to_le32(len);
-
-		size[0] = sizeof(struct smb2_file_link_info);
-		data[0] = &vars->link_info;
-
-		size[1] = len + 2 /* null */;
-		data[1] = (__le16 *)ptr;
-
-		rc = SMB2_set_info_init(tcon, server,
-					&rqst[num_rqst], COMPOUND_FID,
-					COMPOUND_FID, current->tgid,
-					FILE_LINK_INFORMATION,
-					SMB2_O_INFO_FILE, 0, data, size);
-		if (rc)
-			goto finished;
-		smb2_set_next_command(tcon, &rqst[num_rqst]);
-		smb2_set_related(&rqst[num_rqst++]);
-		trace_smb3_hardlink_enter(xid, ses->Suid, tcon->tid, full_path);
-		break;
-	default:
-		cifs_dbg(VFS, "Invalid command\n");
-		rc = -EINVAL;
 	}
 	if (rc)
 		goto finished;
@@ -385,145 +382,142 @@ static int smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 					rqst, resp_buftype,
 					rsp_iov);
 
- finished:
-	SMB2_open_free(&rqst[0]);
+finished:
+	num_rqst = 0;
+	SMB2_open_free(&rqst[num_rqst++]);
 	if (rc == -EREMCHG) {
 		pr_warn_once("server share %s deleted\n", tcon->tree_name);
 		tcon->need_reconnect = true;
 	}
 
-	switch (command) {
-	case SMB2_OP_QUERY_INFO:
-		idata = ptr;
-		if (rc == 0 && cfile && cfile->symlink_target) {
-			idata->symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
-			if (!idata->symlink_target)
-				rc = -ENOMEM;
-		}
-		if (rc == 0) {
-			qi_rsp = (struct smb2_query_info_rsp *)
-				rsp_iov[1].iov_base;
-			rc = smb2_validate_and_copy_iov(
-				le16_to_cpu(qi_rsp->OutputBufferOffset),
-				le32_to_cpu(qi_rsp->OutputBufferLength),
-				&rsp_iov[1], sizeof(idata->fi), (char *)&idata->fi);
-		}
-		if (rqst[1].rq_iov)
-			SMB2_query_info_free(&rqst[1]);
-		if (rqst[2].rq_iov)
-			SMB2_close_free(&rqst[2]);
-		if (rc)
-			trace_smb3_query_info_compound_err(xid,  ses->Suid,
-						tcon->tid, rc);
-		else
-			trace_smb3_query_info_compound_done(xid, ses->Suid,
-						tcon->tid);
-		break;
-	case SMB2_OP_POSIX_QUERY_INFO:
-		idata = ptr;
-		if (rc == 0 && cfile && cfile->symlink_target) {
-			idata->symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
-			if (!idata->symlink_target)
-				rc = -ENOMEM;
-		}
-		if (rc == 0) {
-			qi_rsp = (struct smb2_query_info_rsp *)
-				rsp_iov[1].iov_base;
-			rc = smb2_validate_and_copy_iov(
-				le16_to_cpu(qi_rsp->OutputBufferOffset),
-				le32_to_cpu(qi_rsp->OutputBufferLength),
-				&rsp_iov[1], sizeof(idata->posix_fi) /* add SIDs */,
-				(char *)&idata->posix_fi);
-		}
-		if (rc == 0) {
-			unsigned int length = le32_to_cpu(qi_rsp->OutputBufferLength);
+	for (i = 0; i < num_cmds; i++) {
+		switch (cmds[i]) {
+		case SMB2_OP_QUERY_INFO:
+			idata = in_iov[i].iov_base;
+			if (rc == 0 && cfile && cfile->symlink_target) {
+				idata->symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
+				if (!idata->symlink_target)
+					rc = -ENOMEM;
+			}
+			if (rc == 0) {
+				qi_rsp = (struct smb2_query_info_rsp *)
+					rsp_iov[i + 1].iov_base;
+				rc = smb2_validate_and_copy_iov(
+					le16_to_cpu(qi_rsp->OutputBufferOffset),
+					le32_to_cpu(qi_rsp->OutputBufferLength),
+					&rsp_iov[i + 1], sizeof(idata->fi), (char *)&idata->fi);
+			}
+			SMB2_query_info_free(&rqst[num_rqst++]);
+			if (rc)
+				trace_smb3_query_info_compound_err(xid,  ses->Suid,
+								   tcon->tid, rc);
+			else
+				trace_smb3_query_info_compound_done(xid, ses->Suid,
+								    tcon->tid);
+			break;
+		case SMB2_OP_POSIX_QUERY_INFO:
+			idata = in_iov[i].iov_base;
+			if (rc == 0 && cfile && cfile->symlink_target) {
+				idata->symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
+				if (!idata->symlink_target)
+					rc = -ENOMEM;
+			}
+			if (rc == 0) {
+				qi_rsp = (struct smb2_query_info_rsp *)
+					rsp_iov[i + 1].iov_base;
+				rc = smb2_validate_and_copy_iov(
+					le16_to_cpu(qi_rsp->OutputBufferOffset),
+					le32_to_cpu(qi_rsp->OutputBufferLength),
+					&rsp_iov[i + 1], sizeof(idata->posix_fi) /* add SIDs */,
+					(char *)&idata->posix_fi);
+			}
+			if (rc == 0) {
+				unsigned int length = le32_to_cpu(qi_rsp->OutputBufferLength);
 
-			if (length > sizeof(idata->posix_fi)) {
-				char *base = (char *)rsp_iov[1].iov_base +
-					le16_to_cpu(qi_rsp->OutputBufferOffset) +
-					sizeof(idata->posix_fi);
-				*extbuflen = length - sizeof(idata->posix_fi);
-				*extbuf = kmemdup(base, *extbuflen, GFP_KERNEL);
-				if (!*extbuf)
-					rc = -ENOMEM;
-			} else {
-				rc = -EINVAL;
+				if (length > sizeof(idata->posix_fi)) {
+					char *base = (char *)rsp_iov[i + 1].iov_base +
+						le16_to_cpu(qi_rsp->OutputBufferOffset) +
+						sizeof(idata->posix_fi);
+					*extbuflen = length - sizeof(idata->posix_fi);
+					*extbuf = kmemdup(base, *extbuflen, GFP_KERNEL);
+					if (!*extbuf)
+						rc = -ENOMEM;
+				} else {
+					rc = -EINVAL;
+				}
 			}
+			SMB2_query_info_free(&rqst[num_rqst++]);
+			if (rc)
+				trace_smb3_posix_query_info_compound_err(xid,  ses->Suid,
+									 tcon->tid, rc);
+			else
+				trace_smb3_posix_query_info_compound_done(xid, ses->Suid,
+									  tcon->tid);
+			break;
+		case SMB2_OP_DELETE:
+			if (rc)
+				trace_smb3_delete_err(xid,  ses->Suid, tcon->tid, rc);
+			else
+				trace_smb3_delete_done(xid, ses->Suid, tcon->tid);
+			break;
+		case SMB2_OP_MKDIR:
+			if (rc)
+				trace_smb3_mkdir_err(xid,  ses->Suid, tcon->tid, rc);
+			else
+				trace_smb3_mkdir_done(xid, ses->Suid, tcon->tid);
+			break;
+		case SMB2_OP_HARDLINK:
+			if (rc)
+				trace_smb3_hardlink_err(xid,  ses->Suid, tcon->tid, rc);
+			else
+				trace_smb3_hardlink_done(xid, ses->Suid, tcon->tid);
+			SMB2_set_info_free(&rqst[num_rqst++]);
+			break;
+		case SMB2_OP_RENAME:
+			if (rc)
+				trace_smb3_rename_err(xid,  ses->Suid, tcon->tid, rc);
+			else
+				trace_smb3_rename_done(xid, ses->Suid, tcon->tid);
+			SMB2_set_info_free(&rqst[num_rqst++]);
+			break;
+		case SMB2_OP_RMDIR:
+			if (rc)
+				trace_smb3_rmdir_err(xid,  ses->Suid, tcon->tid, rc);
+			else
+				trace_smb3_rmdir_done(xid, ses->Suid, tcon->tid);
+			SMB2_set_info_free(&rqst[num_rqst++]);
+			break;
+		case SMB2_OP_SET_EOF:
+			if (rc)
+				trace_smb3_set_eof_err(xid,  ses->Suid, tcon->tid, rc);
+			else
+				trace_smb3_set_eof_done(xid, ses->Suid, tcon->tid);
+			SMB2_set_info_free(&rqst[num_rqst++]);
+			break;
+		case SMB2_OP_SET_INFO:
+			if (rc)
+				trace_smb3_set_info_compound_err(xid,  ses->Suid,
+								 tcon->tid, rc);
+			else
+				trace_smb3_set_info_compound_done(xid, ses->Suid,
+								  tcon->tid);
+			SMB2_set_info_free(&rqst[num_rqst++]);
+			break;
 		}
-		if (rqst[1].rq_iov)
-			SMB2_query_info_free(&rqst[1]);
-		if (rqst[2].rq_iov)
-			SMB2_close_free(&rqst[2]);
-		if (rc)
-			trace_smb3_posix_query_info_compound_err(xid,  ses->Suid, tcon->tid, rc);
-		else
-			trace_smb3_posix_query_info_compound_done(xid, ses->Suid, tcon->tid);
-		break;
-	case SMB2_OP_DELETE:
-		if (rc)
-			trace_smb3_delete_err(xid,  ses->Suid, tcon->tid, rc);
-		else
-			trace_smb3_delete_done(xid, ses->Suid, tcon->tid);
-		if (rqst[1].rq_iov)
-			SMB2_close_free(&rqst[1]);
-		break;
-	case SMB2_OP_MKDIR:
-		if (rc)
-			trace_smb3_mkdir_err(xid,  ses->Suid, tcon->tid, rc);
-		else
-			trace_smb3_mkdir_done(xid, ses->Suid, tcon->tid);
-		if (rqst[1].rq_iov)
-			SMB2_close_free(&rqst[1]);
-		break;
-	case SMB2_OP_HARDLINK:
-		if (rc)
-			trace_smb3_hardlink_err(xid,  ses->Suid, tcon->tid, rc);
-		else
-			trace_smb3_hardlink_done(xid, ses->Suid, tcon->tid);
-		free_set_inf_compound(rqst);
-		break;
-	case SMB2_OP_RENAME:
-		if (rc)
-			trace_smb3_rename_err(xid,  ses->Suid, tcon->tid, rc);
-		else
-			trace_smb3_rename_done(xid, ses->Suid, tcon->tid);
-		free_set_inf_compound(rqst);
-		break;
-	case SMB2_OP_RMDIR:
-		if (rc)
-			trace_smb3_rmdir_err(xid,  ses->Suid, tcon->tid, rc);
-		else
-			trace_smb3_rmdir_done(xid, ses->Suid, tcon->tid);
-		free_set_inf_compound(rqst);
-		break;
-	case SMB2_OP_SET_EOF:
-		if (rc)
-			trace_smb3_set_eof_err(xid,  ses->Suid, tcon->tid, rc);
-		else
-			trace_smb3_set_eof_done(xid, ses->Suid, tcon->tid);
-		free_set_inf_compound(rqst);
-		break;
-	case SMB2_OP_SET_INFO:
-		if (rc)
-			trace_smb3_set_info_compound_err(xid,  ses->Suid,
-						tcon->tid, rc);
-		else
-			trace_smb3_set_info_compound_done(xid, ses->Suid,
-						tcon->tid);
-		free_set_inf_compound(rqst);
-		break;
 	}
+	SMB2_close_free(&rqst[num_rqst]);
 
 	if (cfile)
 		cifsFileInfo_put(cfile);
 
+	num_cmds += 2;
 	if (out_iov && out_buftype) {
-		memcpy(out_iov, rsp_iov, 3 * sizeof(*out_iov));
-		memcpy(out_buftype, resp_buftype, 3 * sizeof(*out_buftype));
+		memcpy(out_iov, rsp_iov, num_cmds * sizeof(*out_iov));
+		memcpy(out_buftype, resp_buftype,
+		       num_cmds * sizeof(*out_buftype));
 	} else {
-		free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
-		free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
-		free_rsp_buf(resp_buftype[2], rsp_iov[2].iov_base);
+		for (i = 0; i < num_cmds; i++)
+			free_rsp_buf(resp_buftype[i], rsp_iov[i].iov_base);
 	}
 	kfree(vars);
 	return rc;
@@ -569,9 +563,10 @@ int smb2_query_path_info(const unsigned int xid,
 	struct cifsFileInfo *cfile;
 	struct cached_fid *cfid = NULL;
 	struct smb2_hdr *hdr;
-	struct kvec out_iov[3] = {};
+	struct kvec in_iov, out_iov[3] = {};
 	int out_buftype[3] = {};
 	bool islink;
+	int cmd = SMB2_OP_QUERY_INFO;
 	int rc, rc2;
 
 	data->adjust_tz = false;
@@ -593,10 +588,14 @@ int smb2_query_path_info(const unsigned int xid,
 		return rc;
 	}
 
+	in_iov.iov_base = data;
+	in_iov.iov_len = sizeof(*data);
+
 	cifs_get_readable_path(tcon, full_path, &cfile);
-	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path, FILE_READ_ATTRIBUTES, FILE_OPEN,
-			      create_options, ACL_NO_MODE, data, SMB2_OP_QUERY_INFO, cfile,
-			      NULL, NULL, out_iov, out_buftype);
+	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
+			      FILE_READ_ATTRIBUTES, FILE_OPEN,
+			      create_options, ACL_NO_MODE, &in_iov,
+			      &cmd, 1, cfile, NULL, NULL, out_iov, out_buftype);
 	hdr = out_iov[0].iov_base;
 	/*
 	 * If first iov is unset, then SMB session was dropped or we've got a
@@ -617,9 +616,8 @@ int smb2_query_path_info(const unsigned int xid,
 		cifs_get_readable_path(tcon, full_path, &cfile);
 		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 				      FILE_READ_ATTRIBUTES, FILE_OPEN,
-				      create_options, ACL_NO_MODE, data,
-				      SMB2_OP_QUERY_INFO, cfile, NULL, NULL,
-				      NULL, NULL);
+				      create_options, ACL_NO_MODE, &in_iov,
+				      &cmd, 1, cfile, NULL, NULL, NULL, NULL);
 		break;
 	case -EREMOTE:
 		break;
@@ -654,12 +652,13 @@ int smb311_posix_query_path_info(const unsigned int xid,
 	int rc;
 	__u32 create_options = 0;
 	struct cifsFileInfo *cfile;
-	struct kvec out_iov[3] = {};
+	struct kvec in_iov, out_iov[3] = {};
 	int out_buftype[3] = {};
 	__u8 *sidsbuf = NULL;
 	__u8 *sidsbuf_end = NULL;
 	size_t sidsbuflen = 0;
 	size_t owner_len, group_len;
+	int cmd = SMB2_OP_POSIX_QUERY_INFO;
 
 	data->adjust_tz = false;
 	data->reparse_point = false;
@@ -670,11 +669,14 @@ int smb311_posix_query_path_info(const unsigned int xid,
 	 * when we already have an open file handle for this. For now this is fast enough
 	 * (always using the compounded version).
 	 */
+	in_iov.iov_base = data;
+	in_iov.iov_len = sizeof(*data);
 
 	cifs_get_readable_path(tcon, full_path, &cfile);
-	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path, FILE_READ_ATTRIBUTES, FILE_OPEN,
-			      create_options, ACL_NO_MODE, data, SMB2_OP_POSIX_QUERY_INFO, cfile,
-			      &sidsbuf, &sidsbuflen, out_iov, out_buftype);
+	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
+			      FILE_READ_ATTRIBUTES, FILE_OPEN,
+			      create_options, ACL_NO_MODE, &in_iov, &cmd, 1,
+			      cfile, &sidsbuf, &sidsbuflen, out_iov, out_buftype);
 	/*
 	 * If first iov is unset, then SMB session was dropped or we've got a
 	 * cached open file (@cfile).
@@ -693,10 +695,10 @@ int smb311_posix_query_path_info(const unsigned int xid,
 		create_options |= OPEN_REPARSE_POINT;
 		/* Failed on a symbolic link - query a reparse point info */
 		cifs_get_readable_path(tcon, full_path, &cfile);
-		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path, FILE_READ_ATTRIBUTES,
-				      FILE_OPEN, create_options, ACL_NO_MODE, data,
-				      SMB2_OP_POSIX_QUERY_INFO, cfile,
-				      &sidsbuf, &sidsbuflen, NULL, NULL);
+		rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
+				      FILE_READ_ATTRIBUTES, FILE_OPEN,
+				      create_options, ACL_NO_MODE, &in_iov, &cmd, 1,
+				      cfile, &sidsbuf, &sidsbuflen, NULL, NULL);
 		break;
 	}
 
@@ -734,7 +736,8 @@ smb2_mkdir(const unsigned int xid, struct inode *parent_inode, umode_t mode,
 {
 	return smb2_compound_op(xid, tcon, cifs_sb, name,
 				FILE_WRITE_ATTRIBUTES, FILE_CREATE,
-				CREATE_NOT_FILE, mode, NULL, SMB2_OP_MKDIR,
+				CREATE_NOT_FILE, mode, NULL,
+				&(int){SMB2_OP_MKDIR}, 1,
 				NULL, NULL, NULL, NULL, NULL);
 }
 
@@ -743,21 +746,24 @@ smb2_mkdir_setinfo(struct inode *inode, const char *name,
 		   struct cifs_sb_info *cifs_sb, struct cifs_tcon *tcon,
 		   const unsigned int xid)
 {
-	FILE_BASIC_INFO data;
+	FILE_BASIC_INFO data = {};
 	struct cifsInodeInfo *cifs_i;
 	struct cifsFileInfo *cfile;
+	struct kvec in_iov;
 	u32 dosattrs;
 	int tmprc;
 
-	memset(&data, 0, sizeof(data));
+	in_iov.iov_base = &data;
+	in_iov.iov_len = sizeof(data);
 	cifs_i = CIFS_I(inode);
 	dosattrs = cifs_i->cifsAttrs | ATTR_READONLY;
 	data.Attributes = cpu_to_le32(dosattrs);
 	cifs_get_writable_path(tcon, name, FIND_WR_ANY, &cfile);
 	tmprc = smb2_compound_op(xid, tcon, cifs_sb, name,
 				 FILE_WRITE_ATTRIBUTES, FILE_CREATE,
-				 CREATE_NOT_FILE, ACL_NO_MODE,
-				 &data, SMB2_OP_SET_INFO, cfile, NULL, NULL, NULL, NULL);
+				 CREATE_NOT_FILE, ACL_NO_MODE, &in_iov,
+				 &(int){SMB2_OP_SET_INFO}, 1,
+				 cfile, NULL, NULL, NULL, NULL);
 	if (tmprc == 0)
 		cifs_i->cifsAttrs = dosattrs;
 }
@@ -767,9 +773,10 @@ smb2_rmdir(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 	   struct cifs_sb_info *cifs_sb)
 {
 	drop_cached_dir_by_name(xid, tcon, name, cifs_sb);
-	return smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FILE_OPEN,
-				CREATE_NOT_FILE, ACL_NO_MODE,
-				NULL, SMB2_OP_RMDIR, NULL, NULL, NULL, NULL, NULL);
+	return smb2_compound_op(xid, tcon, cifs_sb, name,
+				DELETE, FILE_OPEN, CREATE_NOT_FILE,
+				ACL_NO_MODE, NULL, &(int){SMB2_OP_RMDIR}, 1,
+				NULL, NULL, NULL, NULL, NULL);
 }
 
 int
@@ -778,7 +785,8 @@ smb2_unlink(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 {
 	return smb2_compound_op(xid, tcon, cifs_sb, name, DELETE, FILE_OPEN,
 				CREATE_DELETE_ON_CLOSE | OPEN_REPARSE_POINT,
-				ACL_NO_MODE, NULL, SMB2_OP_DELETE, NULL, NULL, NULL, NULL, NULL);
+				ACL_NO_MODE, NULL, &(int){SMB2_OP_DELETE}, 1,
+				NULL, NULL, NULL, NULL, NULL);
 }
 
 static int
@@ -787,6 +795,7 @@ smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
 		   struct cifs_sb_info *cifs_sb, __u32 access, int command,
 		   struct cifsFileInfo *cfile)
 {
+	struct kvec in_iov;
 	__le16 *smb2_to_name = NULL;
 	int rc;
 
@@ -795,9 +804,11 @@ smb2_set_path_attr(const unsigned int xid, struct cifs_tcon *tcon,
 		rc = -ENOMEM;
 		goto smb2_rename_path;
 	}
+	in_iov.iov_base = smb2_to_name;
+	in_iov.iov_len = 2 * UniStrnlen((wchar_t *)smb2_to_name, PATH_MAX);
 	rc = smb2_compound_op(xid, tcon, cifs_sb, from_name, access,
-			      FILE_OPEN, 0, ACL_NO_MODE, smb2_to_name,
-			      command, cfile, NULL, NULL, NULL, NULL);
+			      FILE_OPEN, 0, ACL_NO_MODE, &in_iov,
+			      &command, 1, cfile, NULL, NULL, NULL, NULL);
 smb2_rename_path:
 	kfree(smb2_to_name);
 	return rc;
@@ -832,13 +843,18 @@ smb2_set_path_size(const unsigned int xid, struct cifs_tcon *tcon,
 		   const char *full_path, __u64 size,
 		   struct cifs_sb_info *cifs_sb, bool set_alloc)
 {
+	struct cifsFileInfo *cfile;
+	struct kvec in_iov;
 	__le64 eof = cpu_to_le64(size);
-	struct cifsFileInfo *cfile;
 
+	in_iov.iov_base = &eof;
+	in_iov.iov_len = sizeof(eof);
 	cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
 	return smb2_compound_op(xid, tcon, cifs_sb, full_path,
-				FILE_WRITE_DATA, FILE_OPEN, 0, ACL_NO_MODE,
-				&eof, SMB2_OP_SET_EOF, cfile, NULL, NULL, NULL, NULL);
+				FILE_WRITE_DATA, FILE_OPEN,
+				0, ACL_NO_MODE, &in_iov,
+				&(int){SMB2_OP_SET_EOF}, 1,
+				cfile, NULL, NULL, NULL, NULL);
 }
 
 int
@@ -849,6 +865,7 @@ smb2_set_file_info(struct inode *inode, const char *full_path,
 	struct tcon_link *tlink;
 	struct cifs_tcon *tcon;
 	struct cifsFileInfo *cfile;
+	struct kvec in_iov = { .iov_base = buf, .iov_len = sizeof(*buf), };
 	int rc;
 
 	if ((buf->CreationTime == 0) && (buf->LastAccessTime == 0) &&
@@ -864,7 +881,8 @@ smb2_set_file_info(struct inode *inode, const char *full_path,
 	cifs_get_writable_path(tcon, full_path, FIND_WR_ANY, &cfile);
 	rc = smb2_compound_op(xid, tcon, cifs_sb, full_path,
 			      FILE_WRITE_ATTRIBUTES, FILE_OPEN,
-			      0, ACL_NO_MODE, buf, SMB2_OP_SET_INFO, cfile,
+			      0, ACL_NO_MODE, &in_iov,
+			      &(int){SMB2_OP_SET_INFO}, 1, cfile,
 			      NULL, NULL, NULL, NULL);
 	cifs_put_tlink(tlink);
 	return rc;
-- 
2.43.0


