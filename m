Return-Path: <linux-cifs+bounces-2561-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0501995B026
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Aug 2024 10:25:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B0A60285245
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Aug 2024 08:25:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0824171092;
	Thu, 22 Aug 2024 08:24:16 +0000 (UTC)
X-Original-To: linux-cifs@vger.kernel.org
Received: from smtpbg150.qq.com (smtpbg150.qq.com [18.132.163.193])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89D531547EA;
	Thu, 22 Aug 2024 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=18.132.163.193
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724315056; cv=none; b=EG3wf8cQMWXYrczQh/IHr8de+KzmEByvm5xOn0b19pkF19fVZPOhMOiIlj6/DUkycw6ZzPR4TZpVlBVntd/Qsarh9vm28pz6bkn5ghwa0fgsR4ZxqCl5EOdTvxpWo0M4zTcfUXM8EEU03d+DJwDz9OBfT98VjDBzFgowmqcWoX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724315056; c=relaxed/simple;
	bh=sKdzp468gGsw26jKXvu72l3pMuzkEOM9VnEXnAXc8N4=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=qPFQhwjAYI4arAxx2jbfLIuSHux936yC6IjnEVaFbbn7bDAoiK0Th6/z3Y4VhE02vXma2H/vP4BAZNLTGvyV3CygXysg9pOcEu4V7iNdlqvh/rk/S/wbgwSTTWkYTllQrTNDt6MovEfGnH4E/UUQo+Kiaq1URGJ7XukoCFVHVKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com; spf=none smtp.mailfrom=chenxiaosong.com; arc=none smtp.client-ip=18.132.163.193
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=chenxiaosong.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=chenxiaosong.com
X-QQ-mid: bizesmtp78t1724314966tu1jqbsz
X-QQ-Originating-IP: aukmJBXD7LggjOiYSWRKAlyMFzQRK3CBqfB/N7XP7lo=
Received: from localhost.localdomain ( [116.128.244.171])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Thu, 22 Aug 2024 16:22:41 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 8855987532588777255
From: chenxiaosong@chenxiaosong.com
To: linkinjeon@kernel.org,
	sfrench@samba.org,
	senozhatsky@chromium.org,
	tom@talpey.com,
	linux-cifs@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	pc@manguebit.com,
	ronniesahlberg@gmail.com,
	sprasad@microsoft.com,
	bharathsm@microsoft.com
Cc: chenxiaosong@kylinos.cn,
	liuzhengyuan@kylinos.cn,
	huhai@kylinos.cn,
	liuyun01@kylinos.cn,
	chenxiaosong@chenxiaosong.com
Subject: [PATCH v2 09/12] smb/client: rename cifs_ace to smb_ace
Date: Thu, 22 Aug 2024 08:20:58 +0000
Message-Id: <20240822082101.391272-10-chenxiaosong@chenxiaosong.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20240822082101.391272-1-chenxiaosong@chenxiaosong.com>
References: <20240822082101.391272-1-chenxiaosong@chenxiaosong.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:chenxiaosong.com:qybglogicsvrsz:qybglogicsvrsz4a-0

From: ChenXiaoSong <chenxiaosong@kylinos.cn>

Preparation for moving acl definitions to new common header file.

Use the following shell command to rename:

  find fs/smb/client -type f -exec sed -i \
    's/struct cifs_ace/struct smb_ace/g' {} +

Signed-off-by: ChenXiaoSong <chenxiaosong@kylinos.cn>
---
 fs/smb/client/cifsacl.c   | 62 +++++++++++++++++++--------------------
 fs/smb/client/cifsacl.h   |  4 +--
 fs/smb/client/cifsglob.h  |  2 +-
 fs/smb/client/cifsproto.h |  6 ++--
 fs/smb/client/smb2pdu.c   |  8 ++---
 5 files changed, 41 insertions(+), 41 deletions(-)

diff --git a/fs/smb/client/cifsacl.c b/fs/smb/client/cifsacl.c
index 2e1c9b528dde..e2ec1d934335 100644
--- a/fs/smb/client/cifsacl.c
+++ b/fs/smb/client/cifsacl.c
@@ -666,7 +666,7 @@ static void mode_to_access_flags(umode_t mode, umode_t bits_to_use,
 	return;
 }
 
-static __u16 cifs_copy_ace(struct cifs_ace *dst, struct cifs_ace *src, struct smb_sid *psid)
+static __u16 cifs_copy_ace(struct smb_ace *dst, struct smb_ace *src, struct smb_sid *psid)
 {
 	__u16 size = 1 + 1 + 2 + 4;
 
@@ -685,7 +685,7 @@ static __u16 cifs_copy_ace(struct cifs_ace *dst, struct cifs_ace *src, struct sm
 	return size;
 }
 
-static __u16 fill_ace_for_sid(struct cifs_ace *pntace,
+static __u16 fill_ace_for_sid(struct smb_ace *pntace,
 			const struct smb_sid *psid, __u64 nmode,
 			umode_t bits, __u8 access_type,
 			bool allow_delete_child)
@@ -723,7 +723,7 @@ static __u16 fill_ace_for_sid(struct cifs_ace *pntace,
 
 
 #ifdef CONFIG_CIFS_DEBUG2
-static void dump_ace(struct cifs_ace *pace, char *end_of_acl)
+static void dump_ace(struct smb_ace *pace, char *end_of_acl)
 {
 	int num_subauth;
 
@@ -766,7 +766,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 	int num_aces = 0;
 	int acl_size;
 	char *acl_base;
-	struct cifs_ace **ppace;
+	struct smb_ace **ppace;
 
 	/* BB need to add parm so we can store the SID BB */
 
@@ -799,15 +799,15 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 	if (num_aces > 0) {
 		umode_t denied_mode = 0;
 
-		if (num_aces > ULONG_MAX / sizeof(struct cifs_ace *))
+		if (num_aces > ULONG_MAX / sizeof(struct smb_ace *))
 			return;
-		ppace = kmalloc_array(num_aces, sizeof(struct cifs_ace *),
+		ppace = kmalloc_array(num_aces, sizeof(struct smb_ace *),
 				      GFP_KERNEL);
 		if (!ppace)
 			return;
 
 		for (i = 0; i < num_aces; ++i) {
-			ppace[i] = (struct cifs_ace *) (acl_base + acl_size);
+			ppace[i] = (struct smb_ace *) (acl_base + acl_size);
 #ifdef CONFIG_CIFS_DEBUG2
 			dump_ace(ppace[i], end_of_acl);
 #endif
@@ -849,7 +849,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 
 /*			memcpy((void *)(&(cifscred->aces[i])),
 				(void *)ppace[i],
-				sizeof(struct cifs_ace)); */
+				sizeof(struct smb_ace)); */
 
 			acl_base = (char *)ppace[i];
 			acl_size = le16_to_cpu(ppace[i]->size);
@@ -861,7 +861,7 @@ static void parse_dacl(struct smb_acl *pdacl, char *end_of_acl,
 	return;
 }
 
-unsigned int setup_authusers_ACE(struct cifs_ace *pntace)
+unsigned int setup_authusers_ACE(struct smb_ace *pntace)
 {
 	int i;
 	unsigned int ace_size = 20;
@@ -885,7 +885,7 @@ unsigned int setup_authusers_ACE(struct cifs_ace *pntace)
  * Fill in the special SID based on the mode. See
  * https://technet.microsoft.com/en-us/library/hh509017(v=ws.10).aspx
  */
-unsigned int setup_special_mode_ACE(struct cifs_ace *pntace, __u64 nmode)
+unsigned int setup_special_mode_ACE(struct smb_ace *pntace, __u64 nmode)
 {
 	int i;
 	unsigned int ace_size = 28;
@@ -907,7 +907,7 @@ unsigned int setup_special_mode_ACE(struct cifs_ace *pntace, __u64 nmode)
 	return ace_size;
 }
 
-unsigned int setup_special_user_owner_ACE(struct cifs_ace *pntace)
+unsigned int setup_special_user_owner_ACE(struct smb_ace *pntace)
 {
 	int i;
 	unsigned int ace_size = 28;
@@ -944,17 +944,17 @@ static void populate_new_aces(char *nacl_base,
 	__u64 deny_user_mode = 0;
 	__u64 deny_group_mode = 0;
 	bool sticky_set = false;
-	struct cifs_ace *pnntace = NULL;
+	struct smb_ace *pnntace = NULL;
 
 	nmode = *pnmode;
 	num_aces = *pnum_aces;
 	nsize = *pnsize;
 
 	if (modefromsid) {
-		pnntace = (struct cifs_ace *) (nacl_base + nsize);
+		pnntace = (struct smb_ace *) (nacl_base + nsize);
 		nsize += setup_special_mode_ACE(pnntace, nmode);
 		num_aces++;
-		pnntace = (struct cifs_ace *) (nacl_base + nsize);
+		pnntace = (struct smb_ace *) (nacl_base + nsize);
 		nsize += setup_authusers_ACE(pnntace);
 		num_aces++;
 		goto set_size;
@@ -992,7 +992,7 @@ static void populate_new_aces(char *nacl_base,
 		sticky_set = true;
 
 	if (deny_user_mode) {
-		pnntace = (struct cifs_ace *) (nacl_base + nsize);
+		pnntace = (struct smb_ace *) (nacl_base + nsize);
 		nsize += fill_ace_for_sid(pnntace, pownersid, deny_user_mode,
 				0700, ACCESS_DENIED, false);
 		num_aces++;
@@ -1000,31 +1000,31 @@ static void populate_new_aces(char *nacl_base,
 
 	/* Group DENY ACE does not conflict with owner ALLOW ACE. Keep in preferred order*/
 	if (deny_group_mode && !(deny_group_mode & (user_mode >> 3))) {
-		pnntace = (struct cifs_ace *) (nacl_base + nsize);
+		pnntace = (struct smb_ace *) (nacl_base + nsize);
 		nsize += fill_ace_for_sid(pnntace, pgrpsid, deny_group_mode,
 				0070, ACCESS_DENIED, false);
 		num_aces++;
 	}
 
-	pnntace = (struct cifs_ace *) (nacl_base + nsize);
+	pnntace = (struct smb_ace *) (nacl_base + nsize);
 	nsize += fill_ace_for_sid(pnntace, pownersid, user_mode,
 			0700, ACCESS_ALLOWED, true);
 	num_aces++;
 
 	/* Group DENY ACE conflicts with owner ALLOW ACE. So keep it after. */
 	if (deny_group_mode && (deny_group_mode & (user_mode >> 3))) {
-		pnntace = (struct cifs_ace *) (nacl_base + nsize);
+		pnntace = (struct smb_ace *) (nacl_base + nsize);
 		nsize += fill_ace_for_sid(pnntace, pgrpsid, deny_group_mode,
 				0070, ACCESS_DENIED, false);
 		num_aces++;
 	}
 
-	pnntace = (struct cifs_ace *) (nacl_base + nsize);
+	pnntace = (struct smb_ace *) (nacl_base + nsize);
 	nsize += fill_ace_for_sid(pnntace, pgrpsid, group_mode,
 			0070, ACCESS_ALLOWED, !sticky_set);
 	num_aces++;
 
-	pnntace = (struct cifs_ace *) (nacl_base + nsize);
+	pnntace = (struct smb_ace *) (nacl_base + nsize);
 	nsize += fill_ace_for_sid(pnntace, &sid_everyone, other_mode,
 			0007, ACCESS_ALLOWED, !sticky_set);
 	num_aces++;
@@ -1040,11 +1040,11 @@ static __u16 replace_sids_and_copy_aces(struct smb_acl *pdacl, struct smb_acl *p
 {
 	int i;
 	u16 size = 0;
-	struct cifs_ace *pntace = NULL;
+	struct smb_ace *pntace = NULL;
 	char *acl_base = NULL;
 	u32 src_num_aces = 0;
 	u16 nsize = 0;
-	struct cifs_ace *pnntace = NULL;
+	struct smb_ace *pnntace = NULL;
 	char *nacl_base = NULL;
 	u16 ace_size = 0;
 
@@ -1057,8 +1057,8 @@ static __u16 replace_sids_and_copy_aces(struct smb_acl *pdacl, struct smb_acl *p
 
 	/* Go through all the ACEs */
 	for (i = 0; i < src_num_aces; ++i) {
-		pntace = (struct cifs_ace *) (acl_base + size);
-		pnntace = (struct cifs_ace *) (nacl_base + nsize);
+		pntace = (struct smb_ace *) (acl_base + size);
+		pnntace = (struct smb_ace *) (nacl_base + nsize);
 
 		if (pnownersid && compare_sids(&pntace->sid, pownersid) == 0)
 			ace_size = cifs_copy_ace(pnntace, pntace, pnownersid);
@@ -1080,11 +1080,11 @@ static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 {
 	int i;
 	u16 size = 0;
-	struct cifs_ace *pntace = NULL;
+	struct smb_ace *pntace = NULL;
 	char *acl_base = NULL;
 	u32 src_num_aces = 0;
 	u16 nsize = 0;
-	struct cifs_ace *pnntace = NULL;
+	struct smb_ace *pnntace = NULL;
 	char *nacl_base = NULL;
 	u32 num_aces = 0;
 	bool new_aces_set = false;
@@ -1108,7 +1108,7 @@ static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 
 	/* Retain old ACEs which we can retain */
 	for (i = 0; i < src_num_aces; ++i) {
-		pntace = (struct cifs_ace *) (acl_base + size);
+		pntace = (struct smb_ace *) (acl_base + size);
 
 		if (!new_aces_set && (pntace->flags & INHERITED_ACE)) {
 			/* Place the new ACEs in between existing explicit and inherited */
@@ -1130,7 +1130,7 @@ static int set_chmod_dacl(struct smb_acl *pdacl, struct smb_acl *pndacl,
 		}
 
 		/* update the pointer to the next ACE to populate*/
-		pnntace = (struct cifs_ace *) (nacl_base + nsize);
+		pnntace = (struct smb_ace *) (nacl_base + nsize);
 
 		nsize += cifs_copy_ace(pnntace, pntace, NULL);
 		num_aces++;
@@ -1625,9 +1625,9 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 	nsecdesclen = secdesclen;
 	if (pnmode && *pnmode != NO_CHANGE_64) { /* chmod */
 		if (mode_from_sid)
-			nsecdesclen += 2 * sizeof(struct cifs_ace);
+			nsecdesclen += 2 * sizeof(struct smb_ace);
 		else /* cifsacl */
-			nsecdesclen += 5 * sizeof(struct cifs_ace);
+			nsecdesclen += 5 * sizeof(struct smb_ace);
 	} else { /* chown */
 		/* When ownership changes, changes new owner sid length could be different */
 		nsecdesclen = sizeof(struct smb_ntsd) + (sizeof(struct smb_sid) * 2);
@@ -1636,7 +1636,7 @@ id_mode_to_cifs_acl(struct inode *inode, const char *path, __u64 *pnmode,
 			dacl_ptr = (struct smb_acl *)((char *)pntsd + dacloffset);
 			if (mode_from_sid)
 				nsecdesclen +=
-					le32_to_cpu(dacl_ptr->num_aces) * sizeof(struct cifs_ace);
+					le32_to_cpu(dacl_ptr->num_aces) * sizeof(struct smb_ace);
 			else /* cifsacl */
 				nsecdesclen += le16_to_cpu(dacl_ptr->size);
 		}
diff --git a/fs/smb/client/cifsacl.h b/fs/smb/client/cifsacl.h
index a23d59987828..cbaed8038e36 100644
--- a/fs/smb/client/cifsacl.h
+++ b/fs/smb/client/cifsacl.h
@@ -35,7 +35,7 @@
  */
 #define DEFAULT_SEC_DESC_LEN (sizeof(struct smb_ntsd) + \
 			      sizeof(struct smb_acl) + \
-			      (sizeof(struct cifs_ace) * 4))
+			      (sizeof(struct smb_ace) * 4))
 
 /*
  * Maximum size of a string representation of a SID:
@@ -111,7 +111,7 @@ struct smb_acl {
 #define SUCCESSFUL_ACCESS_ACE_FLAG 0x40
 #define FAILED_ACCESS_ACE_FLAG	0x80
 
-struct cifs_ace {
+struct smb_ace {
 	__u8 type; /* see above and MS-DTYP 2.4.4.1 */
 	__u8 flags;
 	__le16 size;
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index dd944f160973..a27daf5b4ddb 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -205,7 +205,7 @@ struct cifs_cred {
 	struct smb_sid osid;
 	struct smb_sid gsid;
 	struct cifs_ntace *ntaces;
-	struct cifs_ace *aces;
+	struct smb_ace *aces;
 };
 
 struct cifs_open_info_data {
diff --git a/fs/smb/client/cifsproto.h b/fs/smb/client/cifsproto.h
index 33ca3c98900d..1fd82ce970f9 100644
--- a/fs/smb/client/cifsproto.h
+++ b/fs/smb/client/cifsproto.h
@@ -243,9 +243,9 @@ extern int cifs_set_acl(struct mnt_idmap *idmap,
 			struct dentry *dentry, struct posix_acl *acl, int type);
 extern int set_cifs_acl(struct smb_ntsd *, __u32, struct inode *,
 				const char *, int);
-extern unsigned int setup_authusers_ACE(struct cifs_ace *pace);
-extern unsigned int setup_special_mode_ACE(struct cifs_ace *pace, __u64 nmode);
-extern unsigned int setup_special_user_owner_ACE(struct cifs_ace *pace);
+extern unsigned int setup_authusers_ACE(struct smb_ace *pace);
+extern unsigned int setup_special_mode_ACE(struct smb_ace *pace, __u64 nmode);
+extern unsigned int setup_special_user_owner_ACE(struct smb_ace *pace);
 
 extern void dequeue_mid(struct mid_q_entry *mid, bool malformed);
 extern int cifs_read_from_socket(struct TCP_Server_Info *server, char *buf,
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index bb56543e0a2a..1df4174e06ca 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -2623,7 +2623,7 @@ create_sd_buf(umode_t mode, bool set_owner, unsigned int *len)
 	unsigned int group_offset = 0;
 	struct smb3_acl acl = {};
 
-	*len = round_up(sizeof(struct crt_sd_ctxt) + (sizeof(struct cifs_ace) * 4), 8);
+	*len = round_up(sizeof(struct crt_sd_ctxt) + (sizeof(struct smb_ace) * 4), 8);
 
 	if (set_owner) {
 		/* sizeof(struct owner_group_sids) is already multiple of 8 so no need to round */
@@ -2672,21 +2672,21 @@ create_sd_buf(umode_t mode, bool set_owner, unsigned int *len)
 	ptr += sizeof(struct smb3_acl);
 
 	/* create one ACE to hold the mode embedded in reserved special SID */
-	acelen = setup_special_mode_ACE((struct cifs_ace *)ptr, (__u64)mode);
+	acelen = setup_special_mode_ACE((struct smb_ace *)ptr, (__u64)mode);
 	ptr += acelen;
 	acl_size = acelen + sizeof(struct smb3_acl);
 	ace_count = 1;
 
 	if (set_owner) {
 		/* we do not need to reallocate buffer to add the two more ACEs. plenty of space */
-		acelen = setup_special_user_owner_ACE((struct cifs_ace *)ptr);
+		acelen = setup_special_user_owner_ACE((struct smb_ace *)ptr);
 		ptr += acelen;
 		acl_size += acelen;
 		ace_count += 1;
 	}
 
 	/* and one more ACE to allow access for authenticated users */
-	acelen = setup_authusers_ACE((struct cifs_ace *)ptr);
+	acelen = setup_authusers_ACE((struct smb_ace *)ptr);
 	ptr += acelen;
 	acl_size += acelen;
 	ace_count += 1;
-- 
2.34.1


