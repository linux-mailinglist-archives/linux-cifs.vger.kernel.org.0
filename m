Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7A8C19D9E7
	for <lists+linux-cifs@lfdr.de>; Tue, 27 Aug 2019 01:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726487AbfHZXaX (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 26 Aug 2019 19:30:23 -0400
Received: from mx1.redhat.com ([209.132.183.28]:40720 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726278AbfHZXaX (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Mon, 26 Aug 2019 19:30:23 -0400
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BC23A10F23EF;
        Mon, 26 Aug 2019 23:30:22 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-71.bne.redhat.com [10.64.54.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9225B608AB;
        Mon, 26 Aug 2019 23:30:21 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: [PATCH] cifs: replace various strncpy with memcpy and similar
Date:   Tue, 27 Aug 2019 09:30:14 +1000
Message-Id: <20190826233014.11539-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.6.2 (mx1.redhat.com [10.5.110.66]); Mon, 26 Aug 2019 23:30:22 +0000 (UTC)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/cifsproto.h |   1 +
 fs/cifs/cifssmb.c   | 197 +++++++++++++++++-----------------------------------
 fs/cifs/connect.c   |   7 +-
 fs/cifs/dir.c       |   5 +-
 fs/cifs/misc.c      |  22 ++++++
 fs/cifs/sess.c      |  26 ++++---
 6 files changed, 112 insertions(+), 146 deletions(-)

diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index e23234207fc2..592a6cea2b79 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -579,6 +579,7 @@ extern void rqst_page_get_length(struct smb_rqst *rqst, unsigned int page,
 				unsigned int *len, unsigned int *offset);
 
 void extract_unc_hostname(const char *unc, const char **h, size_t *len);
+int copy_path_name(char *dst, const char *src);
 
 #ifdef CONFIG_CIFS_DFS_UPCALL
 static inline int get_dfs_path(const unsigned int xid, struct cifs_ses *ses,
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index e2f95965065d..3907653e63c7 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -942,10 +942,8 @@ CIFSPOSIXDelFile(const unsigned int xid, struct cifs_tcon *tcon,
 				       PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
-	} else { /* BB add path length overrun check */
-		name_len = strnlen(fileName, PATH_MAX);
-		name_len++;	/* trailing null */
-		strncpy(pSMB->FileName, fileName, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->FileName, fileName);
 	}
 
 	params = 6 + name_len;
@@ -1015,10 +1013,8 @@ CIFSSMBDelFile(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 					      remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
-	} else {		/* BB improve check for buffer overruns BB */
-		name_len = strnlen(name, PATH_MAX);
-		name_len++;	/* trailing null */
-		strncpy(pSMB->fileName, name, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->fileName, name);
 	}
 	pSMB->SearchAttributes =
 	    cpu_to_le16(ATTR_READONLY | ATTR_HIDDEN | ATTR_SYSTEM);
@@ -1062,10 +1058,8 @@ CIFSSMBRmDir(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 					      remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
-	} else {		/* BB improve check for buffer overruns BB */
-		name_len = strnlen(name, PATH_MAX);
-		name_len++;	/* trailing null */
-		strncpy(pSMB->DirName, name, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->DirName, name);
 	}
 
 	pSMB->BufferFormat = 0x04;
@@ -1107,10 +1101,8 @@ CIFSSMBMkDir(const unsigned int xid, struct cifs_tcon *tcon, const char *name,
 					      remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
-	} else {		/* BB improve check for buffer overruns BB */
-		name_len = strnlen(name, PATH_MAX);
-		name_len++;	/* trailing null */
-		strncpy(pSMB->DirName, name, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->DirName, name);
 	}
 
 	pSMB->BufferFormat = 0x04;
@@ -1157,10 +1149,8 @@ CIFSPOSIXCreate(const unsigned int xid, struct cifs_tcon *tcon,
 				       PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(name, PATH_MAX);
-		name_len++;	/* trailing null */
-		strncpy(pSMB->FileName, name, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->FileName, name);
 	}
 
 	params = 6 + name_len;
@@ -1324,11 +1314,9 @@ SMBLegacyOpen(const unsigned int xid, struct cifs_tcon *tcon,
 				      fileName, PATH_MAX, nls_codepage, remap);
 		name_len++;     /* trailing null */
 		name_len *= 2;
-	} else {                /* BB improve check for buffer overruns BB */
+	} else {
 		count = 0;      /* no pad */
-		name_len = strnlen(fileName, PATH_MAX);
-		name_len++;     /* trailing null */
-		strncpy(pSMB->fileName, fileName, name_len);
+		name_len = copy_path_name(pSMB->fileName, fileName);
 	}
 	if (*pOplock & REQ_OPLOCK)
 		pSMB->OpenFlags = cpu_to_le16(REQ_OPLOCK);
@@ -1442,11 +1430,8 @@ CIFS_open(const unsigned int xid, struct cifs_open_parms *oparms, int *oplock,
 		/* BB improve check for buffer overruns BB */
 		/* no pad */
 		count = 0;
-		name_len = strnlen(path, PATH_MAX);
-		/* trailing null */
-		name_len++;
+		name_len = copy_path_name(req->fileName, path);
 		req->NameLength = cpu_to_le16(name_len);
-		strncpy(req->fileName, path, name_len);
 	}
 
 	if (*oplock & REQ_OPLOCK)
@@ -2812,15 +2797,10 @@ CIFSSMBRename(const unsigned int xid, struct cifs_tcon *tcon,
 				       remap);
 		name_len2 += 1 /* trailing null */  + 1 /* Signature word */ ;
 		name_len2 *= 2;	/* convert to bytes */
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(from_name, PATH_MAX);
-		name_len++;	/* trailing null */
-		strncpy(pSMB->OldFileName, from_name, name_len);
-		name_len2 = strnlen(to_name, PATH_MAX);
-		name_len2++;	/* trailing null */
+	} else {
+		name_len = copy_path_name(pSMB->OldFileName, from_name);
+		name_len2 = copy_path_name(pSMB->OldFileName+name_len+1, to_name);
 		pSMB->OldFileName[name_len] = 0x04;  /* 2nd buffer format */
-		strncpy(&pSMB->OldFileName[name_len + 1], to_name, name_len2);
-		name_len2++;	/* trailing null */
 		name_len2++;	/* signature byte */
 	}
 
@@ -2962,15 +2942,10 @@ CIFSSMBCopy(const unsigned int xid, struct cifs_tcon *tcon,
 				       toName, PATH_MAX, nls_codepage, remap);
 		name_len2 += 1 /* trailing null */  + 1 /* Signature word */ ;
 		name_len2 *= 2; /* convert to bytes */
-	} else { 	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(fromName, PATH_MAX);
-		name_len++;     /* trailing null */
-		strncpy(pSMB->OldFileName, fromName, name_len);
-		name_len2 = strnlen(toName, PATH_MAX);
-		name_len2++;    /* trailing null */
+	} else {
+		name_len = copy_path_name(pSMB->OldFileName, fromName);
 		pSMB->OldFileName[name_len] = 0x04;  /* 2nd buffer format */
-		strncpy(&pSMB->OldFileName[name_len + 1], toName, name_len2);
-		name_len2++;    /* trailing null */
+		name_len2 = copy_path_name(pSMB->OldFileName+name_len+1, toName);
 		name_len2++;    /* signature byte */
 	}
 
@@ -3021,10 +2996,8 @@ CIFSUnixCreateSymLink(const unsigned int xid, struct cifs_tcon *tcon,
 		name_len++;	/* trailing null */
 		name_len *= 2;
 
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(fromName, PATH_MAX);
-		name_len++;	/* trailing null */
-		strncpy(pSMB->FileName, fromName, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->FileName, fromName);
 	}
 	params = 6 + name_len;
 	pSMB->MaxSetupCount = 0;
@@ -3044,10 +3017,8 @@ CIFSUnixCreateSymLink(const unsigned int xid, struct cifs_tcon *tcon,
 					PATH_MAX, nls_codepage, remap);
 		name_len_target++;	/* trailing null */
 		name_len_target *= 2;
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len_target = strnlen(toName, PATH_MAX);
-		name_len_target++;	/* trailing null */
-		strncpy(data_offset, toName, name_len_target);
+	} else {
+		name_len_target = copy_path_name(data_offset, toName);
 	}
 
 	pSMB->MaxParameterCount = cpu_to_le16(2);
@@ -3109,10 +3080,8 @@ CIFSUnixCreateHardLink(const unsigned int xid, struct cifs_tcon *tcon,
 		name_len++;	/* trailing null */
 		name_len *= 2;
 
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(toName, PATH_MAX);
-		name_len++;	/* trailing null */
-		strncpy(pSMB->FileName, toName, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->FileName, toName);
 	}
 	params = 6 + name_len;
 	pSMB->MaxSetupCount = 0;
@@ -3131,10 +3100,8 @@ CIFSUnixCreateHardLink(const unsigned int xid, struct cifs_tcon *tcon,
 				       PATH_MAX, nls_codepage, remap);
 		name_len_target++;	/* trailing null */
 		name_len_target *= 2;
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len_target = strnlen(fromName, PATH_MAX);
-		name_len_target++;	/* trailing null */
-		strncpy(data_offset, fromName, name_len_target);
+	} else {
+		name_len_target = copy_path_name(data_offset, fromName);
 	}
 
 	pSMB->MaxParameterCount = cpu_to_le16(2);
@@ -3213,15 +3180,10 @@ CIFSCreateHardLink(const unsigned int xid, struct cifs_tcon *tcon,
 				       remap);
 		name_len2 += 1 /* trailing null */  + 1 /* Signature word */ ;
 		name_len2 *= 2;	/* convert to bytes */
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(from_name, PATH_MAX);
-		name_len++;	/* trailing null */
-		strncpy(pSMB->OldFileName, from_name, name_len);
-		name_len2 = strnlen(to_name, PATH_MAX);
-		name_len2++;	/* trailing null */
+	} else {
+		name_len = copy_path_name(pSMB->OldFileName, from_name);
 		pSMB->OldFileName[name_len] = 0x04;	/* 2nd buffer format */
-		strncpy(&pSMB->OldFileName[name_len + 1], to_name, name_len2);
-		name_len2++;	/* trailing null */
+		name_len2 = copy_path_name(pSMB->OldFileName+name_len+1, to_name);
 		name_len2++;	/* signature byte */
 	}
 
@@ -3271,10 +3233,8 @@ CIFSSMBUnixQuerySymLink(const unsigned int xid, struct cifs_tcon *tcon,
 					   remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(searchName, PATH_MAX);
-		name_len++;	/* trailing null */
-		strncpy(pSMB->FileName, searchName, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->FileName, searchName);
 	}
 
 	params = 2 /* level */  + 4 /* rsrvd */  + name_len /* incl null */ ;
@@ -3691,10 +3651,8 @@ CIFSSMBGetPosixACL(const unsigned int xid, struct cifs_tcon *tcon,
 		name_len *= 2;
 		pSMB->FileName[name_len] = 0;
 		pSMB->FileName[name_len+1] = 0;
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(searchName, PATH_MAX);
-		name_len++;     /* trailing null */
-		strncpy(pSMB->FileName, searchName, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->FileName, searchName);
 	}
 
 	params = 2 /* level */  + 4 /* rsrvd */  + name_len /* incl null */ ;
@@ -3776,10 +3734,8 @@ CIFSSMBSetPosixACL(const unsigned int xid, struct cifs_tcon *tcon,
 					   PATH_MAX, nls_codepage, remap);
 		name_len++;     /* trailing null */
 		name_len *= 2;
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(fileName, PATH_MAX);
-		name_len++;     /* trailing null */
-		strncpy(pSMB->FileName, fileName, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->FileName, fileName);
 	}
 	params = 6 + name_len;
 	pSMB->MaxParameterCount = cpu_to_le16(2);
@@ -4184,9 +4140,7 @@ SMBQueryInformation(const unsigned int xid, struct cifs_tcon *tcon,
 		name_len++;     /* trailing null */
 		name_len *= 2;
 	} else {
-		name_len = strnlen(search_name, PATH_MAX);
-		name_len++;     /* trailing null */
-		strncpy(pSMB->FileName, search_name, name_len);
+		name_len = copy_path_name(pSMB->FileName, search_name);
 	}
 	pSMB->BufferFormat = 0x04;
 	name_len++; /* account for buffer type byte */
@@ -4321,10 +4275,8 @@ CIFSSMBQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 				       PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(search_name, PATH_MAX);
-		name_len++;	/* trailing null */
-		strncpy(pSMB->FileName, search_name, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->FileName, search_name);
 	}
 
 	params = 2 /* level */ + 4 /* reserved */ + name_len /* includes NUL */;
@@ -4490,10 +4442,8 @@ CIFSSMBUnixQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 				       PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(searchName, PATH_MAX);
-		name_len++;	/* trailing null */
-		strncpy(pSMB->FileName, searchName, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->FileName, searchName);
 	}
 
 	params = 2 /* level */ + 4 /* reserved */ + name_len /* includes NUL */;
@@ -4593,17 +4543,16 @@ CIFSFindFirst(const unsigned int xid, struct cifs_tcon *tcon,
 			pSMB->FileName[name_len+1] = 0;
 			name_len += 2;
 		}
-	} else {	/* BB add check for overrun of SMB buf BB */
-		name_len = strnlen(searchName, PATH_MAX);
-/* BB fix here and in unicode clause above ie
-		if (name_len > buffersize-header)
-			free buffer exit; BB */
-		strncpy(pSMB->FileName, searchName, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->FileName, searchName);
 		if (msearch) {
-			pSMB->FileName[name_len] = CIFS_DIR_SEP(cifs_sb);
-			pSMB->FileName[name_len+1] = '*';
-			pSMB->FileName[name_len+2] = 0;
-			name_len += 3;
+			if (WARN_ON_ONCE(name_len > PATH_MAX-2))
+				name_len = PATH_MAX-2;
+			/* overwrite nul byte */
+			pSMB->FileName[name_len-1] = CIFS_DIR_SEP(cifs_sb);
+			pSMB->FileName[name_len] = '*';
+			pSMB->FileName[name_len+1] = 0;
+			name_len += 2;
 		}
 	}
 
@@ -4898,10 +4847,8 @@ CIFSGetSrvInodeNumber(const unsigned int xid, struct cifs_tcon *tcon,
 					   remap);
 		name_len++;     /* trailing null */
 		name_len *= 2;
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(search_name, PATH_MAX);
-		name_len++;     /* trailing null */
-		strncpy(pSMB->FileName, search_name, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->FileName, search_name);
 	}
 
 	params = 2 /* level */  + 4 /* rsrvd */  + name_len /* incl null */ ;
@@ -5008,9 +4955,7 @@ CIFSGetDFSRefer(const unsigned int xid, struct cifs_ses *ses,
 		name_len++;	/* trailing null */
 		name_len *= 2;
 	} else {	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(search_name, PATH_MAX);
-		name_len++;	/* trailing null */
-		strncpy(pSMB->RequestFileName, search_name, name_len);
+		name_len = copy_path_name(pSMB->RequestFileName, search_name);
 	}
 
 	if (ses->server->sign)
@@ -5663,10 +5608,8 @@ CIFSSMBSetEOF(const unsigned int xid, struct cifs_tcon *tcon,
 				       PATH_MAX, cifs_sb->local_nls, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(file_name, PATH_MAX);
-		name_len++;	/* trailing null */
-		strncpy(pSMB->FileName, file_name, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->FileName, file_name);
 	}
 	params = 6 + name_len;
 	data_count = sizeof(struct file_end_of_file_info);
@@ -5959,10 +5902,8 @@ CIFSSMBSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 				       PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(fileName, PATH_MAX);
-		name_len++;	/* trailing null */
-		strncpy(pSMB->FileName, fileName, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->FileName, fileName);
 	}
 
 	params = 6 + name_len;
@@ -6040,10 +5981,8 @@ CIFSSMBSetAttrLegacy(unsigned int xid, struct cifs_tcon *tcon, char *fileName,
 				       PATH_MAX, nls_codepage);
 		name_len++;     /* trailing null */
 		name_len *= 2;
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(fileName, PATH_MAX);
-		name_len++;     /* trailing null */
-		strncpy(pSMB->fileName, fileName, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->fileName, fileName);
 	}
 	pSMB->attr = cpu_to_le16(dos_attrs);
 	pSMB->BufferFormat = 0x04;
@@ -6203,10 +6142,8 @@ CIFSSMBUnixSetPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 				       PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(file_name, PATH_MAX);
-		name_len++;	/* trailing null */
-		strncpy(pSMB->FileName, file_name, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->FileName, file_name);
 	}
 
 	params = 6 + name_len;
@@ -6298,10 +6235,8 @@ CIFSSMBQAllEAs(const unsigned int xid, struct cifs_tcon *tcon,
 				       PATH_MAX, nls_codepage, remap);
 		list_len++;	/* trailing null */
 		list_len *= 2;
-	} else {	/* BB improve the check for buffer overruns BB */
-		list_len = strnlen(searchName, PATH_MAX);
-		list_len++;	/* trailing null */
-		strncpy(pSMB->FileName, searchName, list_len);
+	} else {
+		list_len = copy_path_name(pSMB->FileName, searchName);
 	}
 
 	params = 2 /* level */ + 4 /* reserved */ + list_len /* includes NUL */;
@@ -6480,10 +6415,8 @@ CIFSSMBSetEA(const unsigned int xid, struct cifs_tcon *tcon,
 				       PATH_MAX, nls_codepage, remap);
 		name_len++;	/* trailing null */
 		name_len *= 2;
-	} else {	/* BB improve the check for buffer overruns BB */
-		name_len = strnlen(fileName, PATH_MAX);
-		name_len++;	/* trailing null */
-		strncpy(pSMB->FileName, fileName, name_len);
+	} else {
+		name_len = copy_path_name(pSMB->FileName, fileName);
 	}
 
 	params = 6 + name_len;
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 6f5c3ef327bd..1ed449f4a8ec 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -4231,16 +4231,19 @@ build_unc_path_to_root(const struct smb_vol *vol,
 		strlen(vol->prepath) + 1 : 0;
 	unsigned int unc_len = strnlen(vol->UNC, MAX_TREE_SIZE + 1);
 
+	if (unc_len > MAX_TREE_SIZE)
+		return -EINVAL;
+
 	full_path = kmalloc(unc_len + pplen + 1, GFP_KERNEL);
 	if (full_path == NULL)
 		return ERR_PTR(-ENOMEM);
 
-	strncpy(full_path, vol->UNC, unc_len);
+	memcpy(full_path, vol->UNC, unc_len);
 	pos = full_path + unc_len;
 
 	if (pplen) {
 		*pos = CIFS_DIR_SEP(cifs_sb);
-		strncpy(pos + 1, vol->prepath, pplen);
+		memcpy(pos + 1, vol->prepath, pplen);
 		pos += pplen;
 	}
 
diff --git a/fs/cifs/dir.c b/fs/cifs/dir.c
index f26a48dd2e39..be424e81e3ad 100644
--- a/fs/cifs/dir.c
+++ b/fs/cifs/dir.c
@@ -69,11 +69,10 @@ cifs_build_path_to_root(struct smb_vol *vol, struct cifs_sb_info *cifs_sb,
 		return full_path;
 
 	if (dfsplen)
-		strncpy(full_path, tcon->treeName, dfsplen);
+		memcpy(full_path, tcon->treeName, dfsplen);
 	full_path[dfsplen] = CIFS_DIR_SEP(cifs_sb);
-	strncpy(full_path + dfsplen + 1, vol->prepath, pplen);
+	memcpy(full_path + dfsplen + 1, vol->prepath, pplen);
 	convert_delimiter(full_path, CIFS_DIR_SEP(cifs_sb));
-	full_path[dfsplen + pplen] = 0; /* add trailing null */
 	return full_path;
 }
 
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index f383877a6511..5ad83bdb9bea 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -1011,3 +1011,25 @@ void extract_unc_hostname(const char *unc, const char **h, size_t *len)
 	*h = unc;
 	*len = end - unc;
 }
+
+/**
+ * copy_path_name - copy src path to dst, possibly truncating
+ *
+ * returns number of bytes written (including trailing nul)
+ */
+int copy_path_name(char *dst, const char *src)
+{
+	int name_len;
+
+	/*
+	 * PATH_MAX includes nul, so if strlen(src) >= PATH_MAX it
+	 * will truncate and strlen(dst) will be PATH_MAX-1
+	 */
+	name_len = strscpy(dst, src, PATH_MAX);
+	if (WARN_ON_ONCE(name_len < 0))
+		name_len = PATH_MAX-1;
+
+	/* we count the trailing nul */
+	name_len++;
+	return name_len;
+}
diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index dcd49ad60c83..4c764ff7edd2 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -159,13 +159,16 @@ static void ascii_ssetup_strings(char **pbcc_area, struct cifs_ses *ses,
 				 const struct nls_table *nls_cp)
 {
 	char *bcc_ptr = *pbcc_area;
+	int len;
 
 	/* copy user */
 	/* BB what about null user mounts - check that we do this BB */
 	/* copy user */
 	if (ses->user_name != NULL) {
-		strncpy(bcc_ptr, ses->user_name, CIFS_MAX_USERNAME_LEN);
-		bcc_ptr += strnlen(ses->user_name, CIFS_MAX_USERNAME_LEN);
+		len = strscpy(bcc_ptr, ses->user_name, CIFS_MAX_USERNAME_LEN);
+		if (WARN_ON_ONCE(len < 0))
+			len = CIFS_MAX_USERNAME_LEN - 1;
+		bcc_ptr += len;
 	}
 	/* else null user mount */
 	*bcc_ptr = 0;
@@ -173,8 +176,10 @@ static void ascii_ssetup_strings(char **pbcc_area, struct cifs_ses *ses,
 
 	/* copy domain */
 	if (ses->domainName != NULL) {
-		strncpy(bcc_ptr, ses->domainName, CIFS_MAX_DOMAINNAME_LEN);
-		bcc_ptr += strnlen(ses->domainName, CIFS_MAX_DOMAINNAME_LEN);
+		len = strscpy(bcc_ptr, ses->domainName, CIFS_MAX_DOMAINNAME_LEN);
+		if (WARN_ON_ONCE(len < 0))
+			len = CIFS_MAX_DOMAINNAME_LEN - 1;
+		bcc_ptr += len;
 	} /* else we will send a null domain name
 	     so the server will default to its own domain */
 	*bcc_ptr = 0;
@@ -242,9 +247,10 @@ static void decode_ascii_ssetup(char **pbcc_area, __u16 bleft,
 
 	kfree(ses->serverOS);
 
-	ses->serverOS = kzalloc(len + 1, GFP_KERNEL);
+	ses->serverOS = kmalloc(len + 1, GFP_KERNEL);
 	if (ses->serverOS) {
-		strncpy(ses->serverOS, bcc_ptr, len);
+		memcpy(ses->serverOS, bcc_ptr, len);
+		ses->serverOS[len] = 0;
 		if (strncmp(ses->serverOS, "OS/2", 4) == 0)
 			cifs_dbg(FYI, "OS/2 server\n");
 	}
@@ -258,9 +264,11 @@ static void decode_ascii_ssetup(char **pbcc_area, __u16 bleft,
 
 	kfree(ses->serverNOS);
 
-	ses->serverNOS = kzalloc(len + 1, GFP_KERNEL);
-	if (ses->serverNOS)
-		strncpy(ses->serverNOS, bcc_ptr, len);
+	ses->serverNOS = kmalloc(len + 1, GFP_KERNEL);
+	if (ses->serverNOS) {
+		memcpy(ses->serverNOS, bcc_ptr, len);
+		ses->serverNOS[len] = 0;
+	}
 
 	bcc_ptr += len + 1;
 	bleft -= len + 1;
-- 
2.13.6

