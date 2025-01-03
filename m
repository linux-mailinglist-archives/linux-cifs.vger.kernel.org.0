Return-Path: <linux-cifs+bounces-3815-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 365EDA01042
	for <lists+linux-cifs@lfdr.de>; Fri,  3 Jan 2025 23:32:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 121671649C1
	for <lists+linux-cifs@lfdr.de>; Fri,  3 Jan 2025 22:32:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 593AF1B21BD;
	Fri,  3 Jan 2025 22:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b="GijgStQP"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mx.manguebit.com (mx.manguebit.com [167.235.159.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32962629C
	for <linux-cifs@vger.kernel.org>; Fri,  3 Jan 2025 22:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=167.235.159.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735943563; cv=none; b=LlM7WHSmAZ3TRQ1kClL+u5c9PDzzfwJVbsFxHzNj4XlymhoY8KrdUIwh7eWyI730arb5CTu1wDIWzBYhGApKf08ONA3NB4fF9GLD8APO0gcRhyQFRVE38bzA60ehc6rgwKhiSHLLJlKxamGWhM4Bi1PVZz2hlOuHrjYW5H+OuXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735943563; c=relaxed/simple;
	bh=Qu3EIwaOJxaXMuuTtMIaROkGFwDpEl8BG5j8qRcPFf8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VJM+EWJyqwU6WlKMZeyXChaoIDlRfVzafVvyAYyflhUE1wcXI9BNRgXZa287L0pqrEWnmkat3Ma95Ip5oNPGH5VAAmZYkKjtVERYygB+yGybhiTogFh4vf1pGngB+hoWFDH4yzqp35hGRrttlzr1/9THUwHL9YyX4BdcEa6XD5I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com; spf=pass smtp.mailfrom=manguebit.com; dkim=pass (2048-bit key) header.d=manguebit.com header.i=@manguebit.com header.b=GijgStQP; arc=none smtp.client-ip=167.235.159.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=manguebit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=manguebit.com
From: Paulo Alcantara <pc@manguebit.com>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=manguebit.com;
	s=dkim; t=1735943141;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=ZFGPStBVdO4K0GOx22DMvDVu/MX61EtFoDGohtYbQb4=;
	b=GijgStQPEt/wcTjzRC+vz6IPrBWRDoYw/TYGvyLrlo7qr5/rmBOJ6y3F2lrvNldC+LRsMB
	1KVk7HLI5s6mK8DXQ6HqrABjp6YpcoloX0xJLipfAW/ThzvYgex3KhhLUIbGFrF9ElygOL
	M3uN3kJFexwkIq+YLNMSvlTmtYk97BtVsWsKZy8Bnj1a1XWGR1evtGpZuo0iBc/+T7tvs8
	iIhB8Gle2ndxn0TjobQJ4HHOQlE2aFnwL96ZBcujNSCt8/VCOqCePpoKxocUPJTl+Rdvm6
	p3tFEyZuiefAxIyOwYqEPD61MSs5m3qHgU4ufStWWnIw+gQZNZ/kh/hJFZpZrA==
To: smfrench@gmail.com
Cc: linux-cifs@vger.kernel.org
Subject: [PATCH 2/4] smb: client: parse av pair type 4 in CHALLENGE_MESSAGE
Date: Fri,  3 Jan 2025 19:25:32 -0300
Message-ID: <20250103222534.86744-2-pc@manguebit.com>
In-Reply-To: <20250103222534.86744-1-pc@manguebit.com>
References: <20250103222534.86744-1-pc@manguebit.com>
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Parse FQDN of the domain in CHALLENGE_MESSAGE message as it's gonna be
useful when mounting DFS shares against old Windows Servers (2012 R2
or earlier) that return not fully qualified hostnames for DFS targets
by default.

Signed-off-by: Paulo Alcantara (Red Hat) <pc@manguebit.com>
---
 fs/smb/client/cifsencrypt.c | 63 ++++++++++++++++++++++++-------------
 fs/smb/client/cifsglob.h    |  1 +
 fs/smb/client/misc.c        |  1 +
 3 files changed, 43 insertions(+), 22 deletions(-)

diff --git a/fs/smb/client/cifsencrypt.c b/fs/smb/client/cifsencrypt.c
index 981897ec4dcd..e69968e88fe7 100644
--- a/fs/smb/client/cifsencrypt.c
+++ b/fs/smb/client/cifsencrypt.c
@@ -348,31 +348,37 @@ static struct ntlmssp2_name *find_next_av(struct cifs_ses *ses,
 	return av;
 }
 
-/* Server has provided av pairs/target info in the type 2 challenge
- * packet and we have plucked it and stored within smb session.
- * We parse that blob here to find netbios domain name to be used
- * as part of ntlmv2 authentication (in Target String), if not already
- * specified on the command line.
- * If this function returns without any error but without fetching
- * domain name, authentication may fail against some server but
- * may not fail against other (those who are not very particular
- * about target string i.e. for some, just user name might suffice.
+/*
+ * Check if server has provided av pair of @type in the NTLMSSP
+ * CHALLENGE_MESSAGE blob.
  */
-static int find_domain_name(struct cifs_ses *ses)
+static int find_av_name(struct cifs_ses *ses, u16 type, char **name, u16 maxlen)
 {
 	const struct nls_table *nlsc = ses->local_nls;
 	struct ntlmssp2_name *av;
-	u16 len;
+	u16 len, nlen;
+
+	if (*name)
+		return 0;
 
 	av_for_each_entry(ses, av) {
 		len = AV_LEN(av);
-		if (AV_TYPE(av) == NTLMSSP_AV_NB_DOMAIN_NAME &&
-		    len < CIFS_MAX_DOMAINNAME_LEN && !ses->domainName) {
-			ses->domainName = kmalloc(len + 1, GFP_KERNEL);
-			if (!ses->domainName)
+		if (AV_TYPE(av) != type)
+			continue;
+		if (!IS_ALIGNED(len, sizeof(__le16))) {
+			cifs_dbg(VFS | ONCE, "%s: bad length(%u) for type %u\n",
+				 __func__, len, type);
+			continue;
+		}
+		nlen = len / sizeof(__le16);
+		if (nlen <= maxlen) {
+			++nlen;
+			*name = kmalloc(nlen, GFP_KERNEL);
+			if (!*name)
 				return -ENOMEM;
-			cifs_from_utf16(ses->domainName, AV_DATA_PTR(av),
-					len, len, nlsc, NO_MAP_UNI_RSVD);
+			cifs_from_utf16(*name, AV_DATA_PTR(av), nlen,
+					len, nlsc, NO_MAP_UNI_RSVD);
+			break;
 		}
 	}
 	return 0;
@@ -546,16 +552,29 @@ setup_ntlmv2_rsp(struct cifs_ses *ses, const struct nls_table *nls_cp)
 	if (ses->server->negflavor == CIFS_NEGFLAVOR_EXTENDED) {
 		if (!ses->domainName) {
 			if (ses->domainAuto) {
-				rc = find_domain_name(ses);
-				if (rc) {
-					cifs_dbg(VFS, "error %d finding domain name\n",
-						 rc);
+				/*
+				 * Domain (workgroup) hasn't been specified in
+				 * mount options, so try to find it in
+				 * CHALLENGE_MESSAGE message and then use it as
+				 * part of NTLMv2 authentication.
+				 */
+				rc = find_av_name(ses, NTLMSSP_AV_NB_DOMAIN_NAME,
+						  &ses->domainName,
+						  CIFS_MAX_DOMAINNAME_LEN);
+				if (rc)
 					goto setup_ntlmv2_rsp_ret;
-				}
 			} else {
 				ses->domainName = kstrdup("", GFP_KERNEL);
+				if (!ses->domainName) {
+					rc = -ENOMEM;
+					goto setup_ntlmv2_rsp_ret;
+				}
 			}
 		}
+		rc = find_av_name(ses, NTLMSSP_AV_DNS_DOMAIN_NAME,
+				  &ses->dns_dom, CIFS_MAX_DOMAINNAME_LEN);
+		if (rc)
+			goto setup_ntlmv2_rsp_ret;
 	} else {
 		rc = build_avpair_blob(ses, nls_cp);
 		if (rc) {
diff --git a/fs/smb/client/cifsglob.h b/fs/smb/client/cifsglob.h
index 6e63abe461fd..e5982136e66f 100644
--- a/fs/smb/client/cifsglob.h
+++ b/fs/smb/client/cifsglob.h
@@ -1154,6 +1154,7 @@ struct cifs_ses {
 	/* ========= end: protected by chan_lock ======== */
 	struct cifs_ses *dfs_root_ses;
 	struct nls_table *local_nls;
+	char *dns_dom; /* FQDN of the domain */
 };
 
 static inline bool
diff --git a/fs/smb/client/misc.c b/fs/smb/client/misc.c
index 4373dd64b66d..c23d5ba44cae 100644
--- a/fs/smb/client/misc.c
+++ b/fs/smb/client/misc.c
@@ -101,6 +101,7 @@ sesInfoFree(struct cifs_ses *buf_to_free)
 	kfree_sensitive(buf_to_free->password2);
 	kfree(buf_to_free->user_name);
 	kfree(buf_to_free->domainName);
+	kfree(buf_to_free->dns_dom);
 	kfree_sensitive(buf_to_free->auth_key.response);
 	spin_lock(&buf_to_free->iface_lock);
 	list_for_each_entry_safe(iface, niface, &buf_to_free->iface_list,
-- 
2.47.1


