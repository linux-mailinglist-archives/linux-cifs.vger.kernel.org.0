Return-Path: <linux-cifs+bounces-3811-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD2C7A0103E
	for <lists+linux-cifs@lfdr.de>; Fri,  3 Jan 2025 23:29:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A644A16466F
	for <lists+linux-cifs@lfdr.de>; Fri,  3 Jan 2025 22:29:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 140231BBBFD;
	Fri,  3 Jan 2025 22:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="cFSuNb6S"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 398371917ED
	for <linux-cifs@vger.kernel.org>; Fri,  3 Jan 2025 22:29:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735943364; cv=none; b=IMC3OEL808jNBLbyaFZRrygfbUNZz8JzQ4jzx1u/YwXojmyVqUqYa47RfpeV4VQG6cm/+MqgZ/NhjfrqO0fE8xRVTkkFfXFKepMMgpzrHihi/lVS3me0XpFkNDZTtOkXtLLYdqpWeSAYO/gkZ/uFJX3Sph/EsgGC7/PZNmrjyjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735943364; c=relaxed/simple;
	bh=JiPUhkh6gyobeUA8yUfYWq/dgfN29sKbusue6R4jLrE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=OGtGWTzwxOnpdoueJho107XEf0R4+pRMyBU+Td7Wpw8vAVRHU9cguUZqgWfmGzuupg142Qu/rI068uYJYNjBoxUxC3VyOGGeiu/kPzfMC0JGc+tB/mJhZRQWRe3lYhNzrkvFCcTYAp1TfseA0KPBg7FOFvUKuvKQJ7wFiRuLQb0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=cFSuNb6S; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
From: Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1735943359;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=+KcThN5rTGpaX5TDR3GD1FbPQHxtkqdAmxzVVcmoXP8=;
	b=cFSuNb6ShDPNLuUmNgq9nC1tiLKwPCiDK+dIL+czZPjg7chjyB3+983ztmDxXqG33IoWea
	qpdK8ee2ci23PWGGWgoVBJgo1y9b/GNy27PNlv05FZbXo1wYUKStUcTSzfa8un68fJn/S5
	Q/GTem9HOfB8NgToCglbCK2nQlWdRHd81gTmtcdv3L21sbQedP7lEonk9CqZx/4uNOrvhf
	EGzIs/3sD3TsEEcV1+dYvx695DJkP+sLcdw0po/hYX5QzHEFq2EpDWHrWilOp1jNmgDEnE
	/t8zu18XIDyClaLHWdrkQiNoRgACS0bw40xg9Y+c32SQ3yf1NdCUdktNBp91tw==
To: smfrench@gmail.com
Cc: linux-cifs@vger.kernel.org,
	Paulo Alcantara <pc@manguebit.com>
Subject: [PATCH 1/4] smb: client: introduce av_for_each_entry() helper
Date: Fri,  3 Jan 2025 19:28:55 -0300
Message-ID: <20250103222858.87176-1-pc@manguebit.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Use new helper in find_domain_name() and find_timestamp() to avoid
duplicating code.

Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
---
 fs/smb/client/cifsencrypt.c | 123 ++++++++++++++++--------------------
 fs/smb/client/cifspdu.h     |   2 +-
 2 files changed, 54 insertions(+), 71 deletions(-)

diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index 7a43daacc815..981897ec4dcd 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -315,6 +315,39 @@ build_avpair_blob(struct cifs_ses *ses, const struct nls_table *nls_cp)
 	return 0;
 }
 
+#define AV_TYPE(av)		(le16_to_cpu(av->type))
+#define AV_LEN(av)		(le16_to_cpu(av->length))
+#define AV_DATA_PTR(av)	((void *)av->data)
+
+#define av_for_each_entry(ses, av) \
+	for (av = NULL; (av = find_next_av(ses, av));)
+
+static struct ntlmssp2_name *find_next_av(struct cifs_ses *ses,
+					  struct ntlmssp2_name *av)
+{
+	u16 len;
+	u8 *end;
+
+	end = (u8 *)ses->auth_key.response + ses->auth_key.len;
+	if (!av) {
+		if (unlikely(!ses->auth_key.response || !ses->auth_key.len))
+			return NULL;
+		av = (void *)ses->auth_key.response;
+	} else {
+		av = (void *)((u8 *)av + sizeof(*av) + AV_LEN(av));
+	}
+
+	if ((u8 *)av + sizeof(*av) > end)
+		return NULL;
+
+	len = AV_LEN(av);
+	if (AV_TYPE(av) == NTLMSSP_AV_EOL)
+		return NULL;
+	if (!len || (u8 *)av + sizeof(*av) + len > end)
+		return NULL;
+	return av;
+}
+
 /* Server has provided av pairs/target info in the type 2 challenge
  * packet and we have plucked it and stored within smb session.
  * We parse that blob here to find netbios domain name to be used
@@ -325,49 +358,23 @@ build_avpair_blob(struct cifs_ses *ses, const struct nls_table *nls_cp)
  * may not fail against other (those who are not very particular
  * about target string i.e. for some, just user name might suffice.
  */
-static int
-find_domain_name(struct cifs_ses *ses, const struct nls_table *nls_cp)
+static int find_domain_name(struct cifs_ses *ses)
 {
-	unsigned int attrsize;
-	unsigned int type;
-	unsigned int onesize = sizeof(struct ntlmssp2_name);
-	unsigned char *blobptr;
-	unsigned char *blobend;
-	struct ntlmssp2_name *attrptr;
+	const struct nls_table *nlsc = ses->local_nls;
+	struct ntlmssp2_name *av;
+	u16 len;
 
-	if (!ses->auth_key.len || !ses->auth_key.response)
-		return 0;
-
-	blobptr = ses->auth_key.response;
-	blobend = blobptr + ses->auth_key.len;
-
-	while (blobptr + onesize < blobend) {
-		attrptr = (struct ntlmssp2_name *) blobptr;
-		type = le16_to_cpu(attrptr->type);
-		if (type == NTLMSSP_AV_EOL)
-			break;
-		blobptr += 2; /* advance attr type */
-		attrsize = le16_to_cpu(attrptr->length);
-		blobptr += 2; /* advance attr size */
-		if (blobptr + attrsize > blobend)
-			break;
-		if (type == NTLMSSP_AV_NB_DOMAIN_NAME) {
-			if (!attrsize || attrsize >= CIFS_MAX_DOMAINNAME_LEN)
-				break;
-			if (!ses->domainName) {
-				ses->domainName =
-					kmalloc(attrsize + 1, GFP_KERNEL);
-				if (!ses->domainName)
-						return -ENOMEM;
-				cifs_from_utf16(ses->domainName,
-					(__le16 *)blobptr, attrsize, attrsize,
-					nls_cp, NO_MAP_UNI_RSVD);
-				break;
-			}
+	av_for_each_entry(ses, av) {
+		len = AV_LEN(av);
+		if (AV_TYPE(av) == NTLMSSP_AV_NB_DOMAIN_NAME &&
+		    len < CIFS_MAX_DOMAINNAME_LEN && !ses->domainName) {
+			ses->domainName = kmalloc(len + 1, GFP_KERNEL);
+			if (!ses->domainName)
+				return -ENOMEM;
+			cifs_from_utf16(ses->domainName, AV_DATA_PTR(av),
+					len, len, nlsc, NO_MAP_UNI_RSVD);
 		}
-		blobptr += attrsize; /* advance attr  value */
 	}
-
 	return 0;
 }
 
@@ -377,40 +384,16 @@ find_domain_name(struct cifs_ses *ses, const struct nls_table *nls_cp)
  * as part of ntlmv2 authentication (or local current time as
  * default in case of failure)
  */
-static __le64
-find_timestamp(struct cifs_ses *ses)
+static __le64 find_timestamp(struct cifs_ses *ses)
 {
-	unsigned int attrsize;
-	unsigned int type;
-	unsigned int onesize = sizeof(struct ntlmssp2_name);
-	unsigned char *blobptr;
-	unsigned char *blobend;
-	struct ntlmssp2_name *attrptr;
+	struct ntlmssp2_name *av;
 	struct timespec64 ts;
 
-	if (!ses->auth_key.len || !ses->auth_key.response)
-		return 0;
-
-	blobptr = ses->auth_key.response;
-	blobend = blobptr + ses->auth_key.len;
-
-	while (blobptr + onesize < blobend) {
-		attrptr = (struct ntlmssp2_name *) blobptr;
-		type = le16_to_cpu(attrptr->type);
-		if (type == NTLMSSP_AV_EOL)
-			break;
-		blobptr += 2; /* advance attr type */
-		attrsize = le16_to_cpu(attrptr->length);
-		blobptr += 2; /* advance attr size */
-		if (blobptr + attrsize > blobend)
-			break;
-		if (type == NTLMSSP_AV_TIMESTAMP) {
-			if (attrsize == sizeof(u64))
-				return *((__le64 *)blobptr);
-		}
-		blobptr += attrsize; /* advance attr value */
+	av_for_each_entry(ses, av) {
+		if (AV_TYPE(av) == NTLMSSP_AV_TIMESTAMP &&
+		    AV_LEN(av) == sizeof(u64))
+			return *((__le64 *)AV_DATA_PTR(av));
 	}
-
 	ktime_get_real_ts64(&ts);
 	return cpu_to_le64(cifs_UnixTimeToNT(ts));
 }
@@ -563,7 +546,7 @@ setup_ntlmv2_rsp(struct cifs_ses *ses, const struct nls_table *nls_cp)
 	if (ses->server->negflavor == CIFS_NEGFLAVOR_EXTENDED) {
 		if (!ses->domainName) {
 			if (ses->domainAuto) {
-				rc = find_domain_name(ses, nls_cp);
+				rc = find_domain_name(ses);
 				if (rc) {
 					cifs_dbg(VFS, "error %d finding domain name\n",
 						 rc);
diff --git a/fs/smb/client/cifspdu.h b/fs/smb/client/cifspdu.h
index ee78bb6741d6..17202754e6d0 100644
--- a/fs/smb/client/cifspdu.h
+++ b/fs/smb/client/cifspdu.h
@@ -649,7 +649,7 @@ typedef union smb_com_session_setup_andx {
 struct ntlmssp2_name {
 	__le16 type;
 	__le16 length;
-/*	char   name[length]; */
+	__u8 data[];
 } __attribute__((packed));
 
 struct ntlmv2_resp {
-- 
2.47.1


