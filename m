Return-Path: <linux-cifs+bounces-125-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6BB377F084C
	for <lists+linux-cifs@lfdr.de>; Sun, 19 Nov 2023 19:22:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8CD541C204D6
	for <lists+linux-cifs@lfdr.de>; Sun, 19 Nov 2023 18:22:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E20FDDB0;
	Sun, 19 Nov 2023 18:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="nySsvraq"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [IPv6:2a01:4f8:1c1e:a2ae::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2209FC2
	for <linux-cifs@vger.kernel.org>; Sun, 19 Nov 2023 10:22:24 -0800 (PST)
From: Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1700418142;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=J9HJQnERh9xBpx6CEStyXogbwH5YA0ieZi4OivAWUR8=;
	b=nySsvraqC3Y3aJ/QyFCU6u5tQxyW13OYOovWTbf6Z113DlwcE6sPwzGAQ8gMvImQLHwVys
	KDwM6n5JTFJYgbXyorJZ32/JJDxsMU1YZFeQaO/vYCFkVT+3XNPLfLtbWo8DVjF//fPSTS
	Vfti9Rnb89G1MBnEBIsAbhCH92fcbJ9VvYnECywrASf14B//cBDTO0GERSqFFhQ6g8GkLN
	1i+T/DmIHLRG6R5bjmcplVFtXHdPobzgKt7TKaB/NG1DnrV19/teB7SYiGgm5vs5I3j1Ff
	pHvMR6rUvwqdwPbhMx6Tv03/Njoepfg8Dnw1ryvhm8t0N5+yip+YvY4fooFVnw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1700418142; h=from:from:sender:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:references; bh=J9HJQnERh9xBpx6CEStyXogbwH5YA0ieZi4OivAWUR8=;
	b=oq9fUrTXvqY+AYjeBKRd49XuFdE0+n0Zm0tpUwUNYYe2Vep5Kc72D2qIEj6MBqroD6Ujww
	JafdxMesG38T3HxgsizNX8p5OPxO7P5FBjaKIaCzuRx7hNxEGnGsmosgpU6kVkntv1sb+1
	ELBjmaAYk5WbNMgtEyUCGnSqH7kInzxTkTNFMJ0h6wWOwXuYCwhdrG8zNCyLfmUrAQi55K
	KzARE/U6M/YhDKVsMBqsLsb4K6gZXnIqSNvLZYJ63X+sa+6Ls+44daWUAhaTW5DGp1RoyQ
	BneB9xwSfQBN3GWr7CzLrr3793KQIxE8qfKwabrLLexLTgjd/qXIKT6FvKMFuA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=pc@manguebit.com smtp.mailfrom=pc@manguebit.com
ARC-Seal: i=1; s=dkim; d=manguebit.com; t=1700418142; a=rsa-sha256;
	cv=none;
	b=L8qgjFmQyX2ytV0o3P4Oc5ADKjYQXF7zmytpp6lDpYo2upfbIef5g1HUIh3wNA/0MVnNcG
	2p4LSIegLflEMHOiccmPjm9kcqi/Yvj9H8VnK8hIBRyvuI0MeDUkh4k5lSqekA3T4F9IFu
	NiCYbKJugE41pC/DpwOK6NCGg5dWmhwjkS7HFILq8wHvWLKtJ+NUa7V5ZZ8eVo5VXHeRL6
	trnFa7JcHY1UExjCpSHxk5Bt+Dg1t6KwoaJwZZX/ft74s4pUGWdsGiXYWv5SLNEsNe48u0
	ebknKwaI5HNShapm/s94MLaWST0CCvctzrdulV895qG9qZ8+XOKG/r8d3Y5Bcw==
To: smfrench@gmail.com
Cc: linux-cifs@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 1/3] smb: client: implement ->query_reparse_point() for SMB1
Date: Sun, 19 Nov 2023 15:22:07 -0300
Message-ID: <20231119182209.5140-1-pc@manguebit.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Reparse points are not limited to symlinks, so implement
->query_reparse_point() in order to handle different file types.

Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
---
 fs/smb/client/cifspdu.h   |   2 +-
 fs/smb/client/cifsproto.h |   9 ++
 fs/smb/client/cifssmb.c   | 189 +++++++++++++++-----------------------
 fs/smb/client/smb1ops.c   |  49 ++--------
 fs/smb/client/smb2ops.c   |  35 ++++---
 5 files changed, 111 insertions(+), 173 deletions(-)

diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index a75220db5c1e..2a90134331a4 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -1356,7 +1356,7 @@ typedef struct smb_com_transaction_ioctl_rsp {
 	__le32 DataDisplacement;
 	__u8 SetupCount;	/* 1 */
 	__le16 ReturnedDataLen;
-	__u16 ByteCount;
+	__le16 ByteCount;
 } __attribute__((packed)) TRANSACT_IOCTL_RSP;
 
 #define CIFS_ACL_OWNER 1
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index d87e2c26cce2..8a739c10d634 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -458,6 +458,12 @@ extern int CIFSSMBUnixQuerySymLink(const unsigned int xid,
 			struct cifs_tcon *tcon,
 			const unsigned char *searchName, char **syminfo,
 			const struct nls_table *nls_codepage, int remap);
+extern int cifs_query_reparse_point(const unsigned int xid,
+				    struct cifs_tcon *tcon,
+				    struct cifs_sb_info *cifs_sb,
+				    const char *full_path,
+				    u32 *tag, struct kvec *rsp,
+				    int *rsp_buftype);
 extern int CIFSSMBQuerySymLink(const unsigned int xid, struct cifs_tcon *tcon,
 			       __u16 fid, char **symlinkinfo,
 			       const struct nls_table *nls_codepage);
@@ -659,6 +665,9 @@ void cifs_put_tcp_super(struct super_block *sb);
 int cifs_update_super_prepath(struct cifs_sb_info *cifs_sb, char *prefix);
 char *extract_hostname(const char *unc);
 char *extract_sharename(const char *unc);
+int parse_reparse_point(struct reparse_data_buffer *buf,
+			u32 plen, struct cifs_sb_info *cifs_sb,
+			bool unicode, char **target_path);
 
 #ifdef CONFIG_CIFS_DFS_UPCALL
 static inline int get_dfs_path(const unsigned int xid, struct cifs_ses *ses,
diff --git a/fs/smb/client/cifssmb.c b/fs/smb/client/cifssmb.c
index 25503f1a4fd2..bad91ba6c3a9 100644
--- a/fs/smb/client/cifssmb.c
+++ b/fs/smb/client/cifssmb.c
@@ -2690,136 +2690,97 @@ CIFSSMBUnixQuerySymLink(const unsigned int xid, struct cifs_tcon *tcon,
 	return rc;
 }
 
-/*
- *	Recent Windows versions now create symlinks more frequently
- *	and they use the "reparse point" mechanism below.  We can of course
- *	do symlinks nicely to Samba and other servers which support the
- *	CIFS Unix Extensions and we can also do SFU symlinks and "client only"
- *	"MF" symlinks optionally, but for recent Windows we really need to
- *	reenable the code below and fix the cifs_symlink callers to handle this.
- *	In the interim this code has been moved to its own config option so
- *	it is not compiled in by default until callers fixed up and more tested.
- */
-int
-CIFSSMBQuerySymLink(const unsigned int xid, struct cifs_tcon *tcon,
-		    __u16 fid, char **symlinkinfo,
-		    const struct nls_table *nls_codepage)
+int cifs_query_reparse_point(const unsigned int xid,
+			     struct cifs_tcon *tcon,
+			     struct cifs_sb_info *cifs_sb,
+			     const char *full_path,
+			     u32 *tag, struct kvec *rsp,
+			     int *rsp_buftype)
 {
-	int rc = 0;
-	int bytes_returned;
-	struct smb_com_transaction_ioctl_req *pSMB;
-	struct smb_com_transaction_ioctl_rsp *pSMBr;
-	bool is_unicode;
-	unsigned int sub_len;
-	char *sub_start;
-	struct reparse_symlink_data *reparse_buf;
-	struct reparse_posix_data *posix_buf;
+	struct cifs_open_parms oparms;
+	TRANSACT_IOCTL_REQ *io_req = NULL;
+	TRANSACT_IOCTL_RSP *io_rsp = NULL;
+	struct cifs_fid fid;
 	__u32 data_offset, data_count;
-	char *end_of_smb;
+	__u8 *start, *end;
+	int io_rsp_len;
+	int oplock = 0;
+	int rc;
 
-	cifs_dbg(FYI, "In Windows reparse style QueryLink for fid %u\n", fid);
-	rc = smb_init(SMB_COM_NT_TRANSACT, 23, tcon, (void **) &pSMB,
-		      (void **) &pSMBr);
+	cifs_tcon_dbg(FYI, "%s: path=%s\n", __func__, full_path);
+
+	if (cap_unix(tcon->ses))
+		return -EOPNOTSUPP;
+
+	oparms = (struct cifs_open_parms) {
+		.tcon = tcon,
+		.cifs_sb = cifs_sb,
+		.desired_access = FILE_READ_ATTRIBUTES,
+		.create_options = cifs_create_options(cifs_sb,
+						      OPEN_REPARSE_POINT),
+		.disposition = FILE_OPEN,
+		.path = full_path,
+		.fid = &fid,
+	};
+
+	rc = CIFS_open(xid, &oparms, &oplock, NULL);
 	if (rc)
 		return rc;
 
-	pSMB->TotalParameterCount = 0 ;
-	pSMB->TotalDataCount = 0;
-	pSMB->MaxParameterCount = cpu_to_le32(2);
+	rc = smb_init(SMB_COM_NT_TRANSACT, 23, tcon,
+		      (void **)&io_req, (void **)&io_rsp);
+	if (rc)
+		goto error;
+
+	io_req->TotalParameterCount = 0;
+	io_req->TotalDataCount = 0;
+	io_req->MaxParameterCount = cpu_to_le32(2);
 	/* BB find exact data count max from sess structure BB */
-	pSMB->MaxDataCount = cpu_to_le32(CIFSMaxBufSize & 0xFFFFFF00);
-	pSMB->MaxSetupCount = 4;
-	pSMB->Reserved = 0;
-	pSMB->ParameterOffset = 0;
-	pSMB->DataCount = 0;
-	pSMB->DataOffset = 0;
-	pSMB->SetupCount = 4;
-	pSMB->SubCommand = cpu_to_le16(NT_TRANSACT_IOCTL);
-	pSMB->ParameterCount = pSMB->TotalParameterCount;
-	pSMB->FunctionCode = cpu_to_le32(FSCTL_GET_REPARSE_POINT);
-	pSMB->IsFsctl = 1; /* FSCTL */
-	pSMB->IsRootFlag = 0;
-	pSMB->Fid = fid; /* file handle always le */
-	pSMB->ByteCount = 0;
+	io_req->MaxDataCount = cpu_to_le32(CIFSMaxBufSize & 0xFFFFFF00);
+	io_req->MaxSetupCount = 4;
+	io_req->Reserved = 0;
+	io_req->ParameterOffset = 0;
+	io_req->DataCount = 0;
+	io_req->DataOffset = 0;
+	io_req->SetupCount = 4;
+	io_req->SubCommand = cpu_to_le16(NT_TRANSACT_IOCTL);
+	io_req->ParameterCount = io_req->TotalParameterCount;
+	io_req->FunctionCode = cpu_to_le32(FSCTL_GET_REPARSE_POINT);
+	io_req->IsFsctl = 1;
+	io_req->IsRootFlag = 0;
+	io_req->Fid = fid.netfid;
+	io_req->ByteCount = 0;
 
-	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
-			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
-	if (rc) {
-		cifs_dbg(FYI, "Send error in QueryReparseLinkInfo = %d\n", rc);
-		goto qreparse_out;
-	}
+	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *)io_req,
+			 (struct smb_hdr *)io_rsp, &io_rsp_len, 0);
+	if (rc)
+		goto error;
 
-	data_offset = le32_to_cpu(pSMBr->DataOffset);
-	data_count = le32_to_cpu(pSMBr->DataCount);
-	if (get_bcc(&pSMBr->hdr) < 2 || data_offset > 512) {
-		/* BB also check enough total bytes returned */
-		rc = -EIO;	/* bad smb */
-		goto qreparse_out;
-	}
-	if (!data_count || (data_count > 2048)) {
-		rc = -EIO;
-		cifs_dbg(FYI, "Invalid return data count on get reparse info ioctl\n");
-		goto qreparse_out;
-	}
-	end_of_smb = 2 + get_bcc(&pSMBr->hdr) + (char *)&pSMBr->ByteCount;
-	reparse_buf = (struct reparse_symlink_data *)
-				((char *)&pSMBr->hdr.Protocol + data_offset);
-	if ((char *)reparse_buf >= end_of_smb) {
+	data_offset = le32_to_cpu(io_rsp->DataOffset);
+	data_count = le32_to_cpu(io_rsp->DataCount);
+	if (get_bcc(&io_rsp->hdr) < 2 || data_offset > 512 ||
+	    !data_count || data_count > 2048) {
 		rc = -EIO;
-		goto qreparse_out;
-	}
-	if (reparse_buf->ReparseTag == cpu_to_le32(IO_REPARSE_TAG_NFS)) {
-		cifs_dbg(FYI, "NFS style reparse tag\n");
-		posix_buf =  (struct reparse_posix_data *)reparse_buf;
-
-		if (posix_buf->InodeType != cpu_to_le64(NFS_SPECFILE_LNK)) {
-			cifs_dbg(FYI, "unsupported file type 0x%llx\n",
-				 le64_to_cpu(posix_buf->InodeType));
-			rc = -EOPNOTSUPP;
-			goto qreparse_out;
-		}
-		is_unicode = true;
-		sub_len = le16_to_cpu(reparse_buf->ReparseDataLength);
-		if (posix_buf->PathBuffer + sub_len > end_of_smb) {
-			cifs_dbg(FYI, "reparse buf beyond SMB\n");
-			rc = -EIO;
-			goto qreparse_out;
-		}
-		*symlinkinfo = cifs_strndup_from_utf16(posix_buf->PathBuffer,
-				sub_len, is_unicode, nls_codepage);
-		goto qreparse_out;
-	} else if (reparse_buf->ReparseTag !=
-			cpu_to_le32(IO_REPARSE_TAG_SYMLINK)) {
-		rc = -EOPNOTSUPP;
-		goto qreparse_out;
+		goto error;
 	}
 
-	/* Reparse tag is NTFS symlink */
-	sub_start = le16_to_cpu(reparse_buf->SubstituteNameOffset) +
-				reparse_buf->PathBuffer;
-	sub_len = le16_to_cpu(reparse_buf->SubstituteNameLength);
-	if (sub_start + sub_len > end_of_smb) {
-		cifs_dbg(FYI, "reparse buf beyond SMB\n");
+	end = 2 + get_bcc(&io_rsp->hdr) + (__u8 *)&io_rsp->ByteCount;
+	start = (__u8 *)&io_rsp->hdr.Protocol + data_offset;
+	if (start >= end) {
 		rc = -EIO;
-		goto qreparse_out;
+		goto error;
 	}
-	if (pSMBr->hdr.Flags2 & SMBFLG2_UNICODE)
-		is_unicode = true;
-	else
-		is_unicode = false;
 
-	/* BB FIXME investigate remapping reserved chars here */
-	*symlinkinfo = cifs_strndup_from_utf16(sub_start, sub_len, is_unicode,
-					       nls_codepage);
-	if (!*symlinkinfo)
-		rc = -ENOMEM;
-qreparse_out:
-	cifs_buf_release(pSMB);
+	*tag = le32_to_cpu(((struct reparse_data_buffer *)start)->ReparseTag);
+	rsp->iov_base = io_rsp;
+	rsp->iov_len = io_rsp_len;
+	*rsp_buftype = CIFS_LARGE_BUFFER;
+	CIFSSMBClose(xid, tcon, fid.netfid);
+	return 0;
 
-	/*
-	 * Note: On -EAGAIN error only caller can retry on handle based calls
-	 * since file handle passed in no longer valid.
-	 */
+error:
+	cifs_buf_release(io_req);
+	CIFSSMBClose(xid, tcon, fid.netfid);
 	return rc;
 }
 
diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index 9bf8735cdd1e..6b4d8effa79d 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -979,18 +979,13 @@ static int cifs_query_symlink(const unsigned int xid,
 			      char **target_path,
 			      struct kvec *rsp_iov)
 {
+	struct reparse_data_buffer *buf;
+	TRANSACT_IOCTL_RSP *io = rsp_iov->iov_base;
+	bool unicode = !!(io->hdr.Flags2 & SMBFLG2_UNICODE);
+	u32 plen = le16_to_cpu(io->ByteCount);
 	int rc;
-	int oplock = 0;
-	bool is_reparse_point = !!rsp_iov;
-	struct cifs_fid fid;
-	struct cifs_open_parms oparms;
 
-	cifs_dbg(FYI, "%s: path: %s\n", __func__, full_path);
-
-	if (is_reparse_point) {
-		cifs_dbg(VFS, "reparse points not handled for SMB1 symlinks\n");
-		return -EOPNOTSUPP;
-	}
+	cifs_tcon_dbg(FYI, "%s: path=%s\n", __func__, full_path);
 
 	/* Check for unix extensions */
 	if (cap_unix(tcon->ses)) {
@@ -1001,37 +996,12 @@ static int cifs_query_symlink(const unsigned int xid,
 			rc = cifs_unix_dfs_readlink(xid, tcon, full_path,
 						    target_path,
 						    cifs_sb->local_nls);
-
-		goto out;
+		return rc;
 	}
 
-	oparms = (struct cifs_open_parms) {
-		.tcon = tcon,
-		.cifs_sb = cifs_sb,
-		.desired_access = FILE_READ_ATTRIBUTES,
-		.create_options = cifs_create_options(cifs_sb,
-						      OPEN_REPARSE_POINT),
-		.disposition = FILE_OPEN,
-		.path = full_path,
-		.fid = &fid,
-	};
-
-	rc = CIFS_open(xid, &oparms, &oplock, NULL);
-	if (rc)
-		goto out;
-
-	rc = CIFSSMBQuerySymLink(xid, tcon, fid.netfid, target_path,
-				 cifs_sb->local_nls);
-	if (rc)
-		goto out_close;
-
-	convert_delimiter(*target_path, '/');
-out_close:
-	CIFSSMBClose(xid, tcon, fid.netfid);
-out:
-	if (!rc)
-		cifs_dbg(FYI, "%s: target path: %s\n", __func__, *target_path);
-	return rc;
+	buf = (struct reparse_data_buffer *)((__u8 *)&io->hdr.Protocol +
+					     le32_to_cpu(io->DataOffset));
+	return parse_reparse_point(buf, plen, cifs_sb, unicode, target_path);
 }
 
 static bool
@@ -1214,6 +1184,7 @@ struct smb_version_operations smb1_operations = {
 	.is_path_accessible = cifs_is_path_accessible,
 	.can_echo = cifs_can_echo,
 	.query_path_info = cifs_query_path_info,
+	.query_reparse_point = cifs_query_reparse_point,
 	.query_file_info = cifs_query_file_info,
 	.get_srv_inum = cifs_get_srv_inum,
 	.set_path_size = CIFSSMBSetEOF,
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index a959ed2c9b22..e9c8cff0b1d2 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -2894,27 +2894,26 @@ parse_reparse_posix(struct reparse_posix_data *symlink_buf,
 	return 0;
 }
 
-static int
-parse_reparse_symlink(struct reparse_symlink_data_buffer *symlink_buf,
-		      u32 plen, char **target_path,
-		      struct cifs_sb_info *cifs_sb)
+static int parse_reparse_symlink(struct reparse_symlink_data_buffer *sym,
+				 u32 plen, bool unicode, char **target_path,
+				 struct cifs_sb_info *cifs_sb)
 {
 	unsigned int sub_len;
 	unsigned int sub_offset;
 
 	/* We handle Symbolic Link reparse tag here. See: MS-FSCC 2.1.2.4 */
 
-	sub_offset = le16_to_cpu(symlink_buf->SubstituteNameOffset);
-	sub_len = le16_to_cpu(symlink_buf->SubstituteNameLength);
+	sub_offset = le16_to_cpu(sym->SubstituteNameOffset);
+	sub_len = le16_to_cpu(sym->SubstituteNameLength);
 	if (sub_offset + 20 > plen ||
 	    sub_offset + sub_len + 20 > plen) {
 		cifs_dbg(VFS, "srv returned malformed symlink buffer\n");
 		return -EIO;
 	}
 
-	*target_path = cifs_strndup_from_utf16(
-				symlink_buf->PathBuffer + sub_offset,
-				sub_len, true, cifs_sb->local_nls);
+	*target_path = cifs_strndup_from_utf16(sym->PathBuffer + sub_offset,
+					       sub_len, unicode,
+					       cifs_sb->local_nls);
 	if (!(*target_path))
 		return -ENOMEM;
 
@@ -2924,19 +2923,17 @@ parse_reparse_symlink(struct reparse_symlink_data_buffer *symlink_buf,
 	return 0;
 }
 
-static int
-parse_reparse_point(struct reparse_data_buffer *buf,
-		    u32 plen, char **target_path,
-		    struct cifs_sb_info *cifs_sb)
+int parse_reparse_point(struct reparse_data_buffer *buf,
+			u32 plen, struct cifs_sb_info *cifs_sb,
+			bool unicode, char **target_path)
 {
-	if (plen < sizeof(struct reparse_data_buffer)) {
+	if (plen < sizeof(*buf)) {
 		cifs_dbg(VFS, "reparse buffer is too small. Must be at least 8 bytes but was %d\n",
 			 plen);
 		return -EIO;
 	}
 
-	if (plen < le16_to_cpu(buf->ReparseDataLength) +
-	    sizeof(struct reparse_data_buffer)) {
+	if (plen < le16_to_cpu(buf->ReparseDataLength) + sizeof(*buf)) {
 		cifs_dbg(VFS, "srv returned invalid reparse buf length: %d\n",
 			 plen);
 		return -EIO;
@@ -2951,7 +2948,7 @@ parse_reparse_point(struct reparse_data_buffer *buf,
 	case IO_REPARSE_TAG_SYMLINK:
 		return parse_reparse_symlink(
 			(struct reparse_symlink_data_buffer *)buf,
-			plen, target_path, cifs_sb);
+			plen, unicode, target_path, cifs_sb);
 	default:
 		cifs_dbg(VFS, "srv returned unknown symlink buffer tag:0x%08x\n",
 			 le32_to_cpu(buf->ReparseTag));
@@ -2970,11 +2967,11 @@ static int smb2_query_symlink(const unsigned int xid,
 	struct smb2_ioctl_rsp *io = rsp_iov->iov_base;
 	u32 plen = le32_to_cpu(io->OutputCount);
 
-	cifs_dbg(FYI, "%s: path: %s\n", __func__, full_path);
+	cifs_tcon_dbg(FYI, "%s: path: %s\n", __func__, full_path);
 
 	buf = (struct reparse_data_buffer *)((u8 *)io +
 					     le32_to_cpu(io->OutputOffset));
-	return parse_reparse_point(buf, plen, target_path, cifs_sb);
+	return parse_reparse_point(buf, plen, cifs_sb, true, target_path);
 }
 
 static int smb2_query_reparse_point(const unsigned int xid,
-- 
2.42.1


