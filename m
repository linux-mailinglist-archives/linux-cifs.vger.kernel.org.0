Return-Path: <linux-cifs+bounces-3791-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9FE2A9FF20D
	for <lists+linux-cifs@lfdr.de>; Tue, 31 Dec 2024 23:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E23E97A0F41
	for <lists+linux-cifs@lfdr.de>; Tue, 31 Dec 2024 22:37:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18B31B85FA;
	Tue, 31 Dec 2024 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BAjFNHKw"
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 783461B4255;
	Tue, 31 Dec 2024 22:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735684630; cv=none; b=Mvi0wH50/WbmnGD6c/Ott98axeyOT+tfpiYowmv/eIGX4ECLWfrXiJ0TXf0/x0oM5ZDRgkM8fDIZT7SU7WWggkUJP0qxE1J91/68+98saJjkMC5ZdiP8ecJ6qR5jN1Iz1DWy8EBYt/DYPxKZGjlqFdetVwmYu8st3QivUF7PwWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735684630; c=relaxed/simple;
	bh=y3q03x/1wYXPLpES29JXGvd1CgnID6pdqYEhdHdHFEg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F9f+nxQ8CY0WRqDj/qTtWuStNJOX3oPlRmH6U+/21J9l72We/VOPXAV2ZILGqQLOhH6j3NG+tIGPnuKBS6tzAhP9KUGSS1UmgF0PQqweNegg+Q/ngq7if0tuuaGh1wjhhT1QQPtnSuA5Dfd5d6UUsYKzA1AlocXbnqXJ4psAHdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BAjFNHKw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1DAC4CEDF;
	Tue, 31 Dec 2024 22:37:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1735684630;
	bh=y3q03x/1wYXPLpES29JXGvd1CgnID6pdqYEhdHdHFEg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BAjFNHKwnGT6n9+0o7j1I6iWXPV6xEC95hmgj+UokQnjilwxdUauG3wujjE9gM7A5
	 TGo9J1826M8YXwOHfXZ02uBbvFKxXipUTbI5QK8vQaOQUNNmKUD19L6XmMpYGZrnb4
	 QZQSBaGqjAsCZJq+Sw310YMZQZMDWxMBk1BO7kMDsIbJgmy+7f/8S1Q9gDzn3kyz9n
	 z3fJ+f6DdFA4A1KyN1Tw9thLv3G7WueA49WIvfLjiolPFh9k08ugB/Ar5iI7vMmmWT
	 YVaYfCEJJIpgw7XlKGwwPHrvD/QNZ3BM01/WbfnrXReQUwrBFnBUOK9dNkl2AfApOU
	 zxjLVfP8AQPdA==
Received: by pali.im (Postfix)
	id CC66CDB3; Tue, 31 Dec 2024 23:37:00 +0100 (CET)
From: =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To: Steve French <sfrench@samba.org>,
	Paulo Alcantara <pc@manguebit.com>
Cc: linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 06/12] cifs: Fix and improve cifs_query_path_info() and cifs_query_file_info()
Date: Tue, 31 Dec 2024 23:36:36 +0100
Message-Id: <20241231223642.15722-6-pali@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241231223642.15722-1-pali@kernel.org>
References: <20241231223642.15722-1-pali@kernel.org>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When CAP_NT_SMBS was not negotiated then do not issue CIFSSMBQPathInfo()
and CIFSSMBQFileInfo() commands. CIFSSMBQPathInfo() is not supported by
non-NT Win9x SMB server and CIFSSMBQFileInfo() returns from Win9x SMB
server bogus data in Attributes field (for example lot of files are marked
as reparse points, even Win9x does not support them and read-only bit is
not marked for read-only files). Correct information is returned by
CIFSFindFirst() or SMBQueryInformation() command.

So as a fallack in cifs_query_path_info() function use CIFSFindFirst() with
SMB_FIND_FILE_FULL_DIRECTORY_INFO level which is supported by both NT and
non-NT servers and as a last option use SMBQueryInformation() as it was
before.

And in function cifs_query_file_info() immediately returns -EOPNOTSUPP when
not communicating with NT server. Client then revalidate inode entry by the
cifs_query_path_info() call, which is working fine. So fstat() syscall on
already opened file will receive correct information.

Note that both fallback functions in non-UNICODE mode expands wildcards.
Therefore those fallback functions cannot be used on paths which contain
SMB wildcard characters (* ? " > <).

CIFSFindFirst() returns all 4 time attributes as opposite of
SMBQueryInformation() which returns only one.

With this change it is possible to query all 4 times attributes from Win9x
server and at the same time, client minimize sending of unsupported
commands to server.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 fs/smb/client/smb1ops.c | 78 +++++++++++++++++++++++++++++++++++++----
 1 file changed, 71 insertions(+), 7 deletions(-)

diff --git a/fs/smb/client/smb1ops.c b/fs/smb/client/smb1ops.c
index bef8e03edf1d..b0813106df16 100644
--- a/fs/smb/client/smb1ops.c
+++ b/fs/smb/client/smb1ops.c
@@ -550,19 +550,76 @@ static int cifs_query_path_info(const unsigned int xid,
 				const char *full_path,
 				struct cifs_open_info_data *data)
 {
-	int rc;
+	int rc = -EOPNOTSUPP;
 	FILE_ALL_INFO fi = {};
+	FILE_FULL_DIRECTORY_INFO *di;
+	struct cifs_search_info search_info = {};
 
 	data->reparse_point = false;
 	data->adjust_tz = false;
 
-	/* could do find first instead but this returns more info */
-	rc = CIFSSMBQPathInfo(xid, tcon, full_path, &fi, 0 /* not legacy */, cifs_sb->local_nls,
-			      cifs_remap(cifs_sb));
 	/*
-	 * BB optimize code so we do not make the above call when server claims
-	 * no NT SMB support and the above call failed at least once - set flag
-	 * in tcon or mount.
+	 * First try CIFSSMBQPathInfo() function which returns more info
+	 * (NumberOfLinks) than CIFSFindFirst() fallback function.
+	 * Some servers like Win9x do not support SMB_QUERY_FILE_ALL_INFO over
+	 * TRANS2_QUERY_PATH_INFORMATION, but supports it with filehandle over
+	 * TRANS2_QUERY_FILE_INFORMATION (function CIFSSMBQFileInfo(). But SMB
+	 * Open command on non-NT servers works only for files, does not work
+	 * for directories. And moreover Win9x SMB server returns bogus data in
+	 * SMB_QUERY_FILE_ALL_INFO Attributes field. So for non-NT servers,
+	 * do not even use CIFSSMBQPathInfo() or CIFSSMBQFileInfo() function.
+	 */
+	if (tcon->ses->capabilities & CAP_NT_SMBS)
+		rc = CIFSSMBQPathInfo(xid, tcon, full_path, &fi, 0 /* not legacy */,
+				      cifs_sb->local_nls, cifs_remap(cifs_sb));
+
+	/*
+	 * Non-UNICODE variant of fallback functions below expands wildcards,
+	 * so they cannot be used for querying paths with wildcard characters.
+	 * Therefore for such paths returns -ENOENT as they cannot exist.
+	 */
+	if ((rc == -EOPNOTSUPP || rc == -EINVAL) &&
+	    !(tcon->ses->capabilities & CAP_UNICODE) &&
+	    strpbrk(full_path, "*?\"><"))
+		rc = -ENOENT;
+
+	/*
+	 * Then fallback to CIFSFindFirst() which works also with non-NT servers
+	 * but does not does not provide NumberOfLinks.
+	 */
+	if (rc == -EOPNOTSUPP || rc == -EINVAL) {
+		search_info.info_level = SMB_FIND_FILE_FULL_DIRECTORY_INFO;
+		rc = CIFSFindFirst(xid, tcon, full_path, cifs_sb, NULL,
+				   CIFS_SEARCH_CLOSE_ALWAYS | CIFS_SEARCH_CLOSE_AT_END,
+				   &search_info, false);
+		if (rc == 0) {
+			di = (FILE_FULL_DIRECTORY_INFO *)search_info.srch_entries_start;
+			fi.CreationTime = di->CreationTime;
+			fi.LastAccessTime = di->LastAccessTime;
+			fi.LastWriteTime = di->LastWriteTime;
+			fi.ChangeTime = di->ChangeTime;
+			fi.Attributes = di->ExtFileAttributes;
+			fi.AllocationSize = di->AllocationSize;
+			fi.EndOfFile = di->EndOfFile;
+			fi.EASize = di->EaSize;
+			fi.NumberOfLinks = cpu_to_le32(1);
+			fi.DeletePending = 0;
+			fi.Directory = !!(le32_to_cpu(di->ExtFileAttributes) & ATTR_DIRECTORY);
+			cifs_buf_release(search_info.ntwrk_buf_start);
+		} else if (!full_path[0]) {
+			/*
+			 * CIFSFindFirst() does not work on root path if the
+			 * root path was exported on the server from the top
+			 * level path (drive letter).
+			 */
+			rc = -EOPNOTSUPP;
+		}
+	}
+
+	/*
+	 * If everything failed then fallback to the legacy SMB command
+	 * SMB_COM_QUERY_INFORMATION which works with all servers, but
+	 * provide just few information.
 	 */
 	if ((rc == -EOPNOTSUPP) || (rc == -EINVAL)) {
 		rc = SMBQueryInformation(xid, tcon, full_path, &fi, cifs_sb->local_nls,
@@ -646,6 +703,13 @@ static int cifs_query_file_info(const unsigned int xid, struct cifs_tcon *tcon,
 	int rc;
 	FILE_ALL_INFO fi = {};
 
+	/*
+	 * CIFSSMBQFileInfo() for non-NT servers returns bogus data in
+	 * Attributes fields. So do not use this command for non-NT servers.
+	 */
+	if (!(tcon->ses->capabilities & CAP_NT_SMBS))
+		return -EOPNOTSUPP;
+
 	if (cfile->symlink_target) {
 		data->symlink_target = kstrdup(cfile->symlink_target, GFP_KERNEL);
 		if (!data->symlink_target)
-- 
2.20.1


