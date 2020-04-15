Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7794D1A92A4
	for <lists+linux-cifs@lfdr.de>; Wed, 15 Apr 2020 07:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2393435AbgDOFpT (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 15 Apr 2020 01:45:19 -0400
Received: from smtprelay0001.hostedemail.com ([216.40.44.1]:41912 "EHLO
        smtprelay.hostedemail.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2393419AbgDOFpN (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Wed, 15 Apr 2020 01:45:13 -0400
Received: from filter.hostedemail.com (clb03-v110.bra.tucows.net [216.40.38.60])
        by smtprelay03.hostedemail.com (Postfix) with ESMTP id 1C478837F24A;
        Wed, 15 Apr 2020 05:45:08 +0000 (UTC)
X-Session-Marker: 6A6F6540706572636865732E636F6D
X-Spam-Summary: 2,0,0,,d41d8cd98f00b204,joe@perches.com,,RULES_HIT:69:355:379:541:960:966:968:973:979:988:989:1252:1256:1260:1311:1314:1345:1437:1515:1605:1730:1747:1777:1792:2196:2198:2199:2200:2393:2559:2562:2693:2892:2894:2895:2898:2899:2901:2902:2903:2915:2922:2923:2924:2925:2926:3138:3139:3140:3141:3142:3865:3866:3867:3868:3870:3871:3872:3873:3874:4250:4321:4383:4385:4395:4559:4605:5007:6261:6691:7807:7875:7903:7904:8568:8603:8957:9010:10044:10798:10848:11026:11232:11233:11657:11914:12043:12050:12296:12297:12438:12555:12679:12683:12895:12986:13141:13230:13894:13972:14394:21080:21220:21222:21324:21433:21450:21451:21524:21611:21626:21740:21795:21796:21939:21966:21987:21990:30003:30029:30034:30037:30046:30051:30052:30054:30056:30062:30069:30070:30075:30076:30079:30080:30083,0,RBL:none,CacheIP:none,Bayesian:0.5,0.5,0.5,Netcheck:none,DomainCache:0,MSF:not bulk,SPF:,MSBL:0,DNSBL:none,Custom_rules:0:1:0,LFtime:2,LUA_SUMMARY:none
X-HE-Tag: boat67_49b5bb12ce643
X-Filterd-Recvd-Size: 73833
Received: from joe-laptop.perches.com (unknown [47.151.136.130])
        (Authenticated sender: joe@perches.com)
        by omf01.hostedemail.com (Postfix) with ESMTPA;
        Wed, 15 Apr 2020 05:45:06 +0000 (UTC)
From:   Joe Perches <joe@perches.com>
To:     Steve French <sfrench@samba.org>
Cc:     linux-cifs@vger.kernel.org, samba-technical@lists.samba.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] cifs: Standardize logging output
Date:   Tue, 14 Apr 2020 22:42:53 -0700
Message-Id: <f826fa221d6971959118d8e0bc6c294b33c7d7c1.1586929128.git.joe@perches.com>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Use pr_fmt to standardize all logging for fs/cifs.

Some logging output had no CIFS: specific prefix.

Now all output has one of three prefixes:

o CIFS:
o CIFS: VFS:
o Root-CIFS:

Miscellanea:

o Convert printks to pr_<level>
o Neaten macro definitions
o Remove embedded CIFS: prefixes from formats
o Convert "illegal" to "invalid"
o Coalesce formats
o Add missing '\n' format terminations
o Consolidate multiple cifs_dbg continuations into single calls
o More consistent use of upper case first word output logging
o Multiline statement argument alignment and wrapping

Signed-off-by: Joe Perches <joe@perches.com>
---
 fs/cifs/cifs_debug.h  | 145 ++++++++++++++++++-------------------
 fs/cifs/cifsencrypt.c |   8 +-
 fs/cifs/cifsproto.h   |  26 +++----
 fs/cifs/cifsroot.c    |   6 +-
 fs/cifs/cifssmb.c     |  26 +++----
 fs/cifs/connect.c     |  77 ++++++++------------
 fs/cifs/dfs_cache.c   |  14 ++--
 fs/cifs/file.c        |  24 +++---
 fs/cifs/inode.c       |   4 +-
 fs/cifs/misc.c        |  12 +--
 fs/cifs/netmisc.c     |   6 +-
 fs/cifs/readdir.c     |  10 +--
 fs/cifs/sess.c        |  28 +++----
 fs/cifs/smb1ops.c     |   2 +-
 fs/cifs/smb2inode.c   |   3 +-
 fs/cifs/smb2misc.c    |  20 ++---
 fs/cifs/smb2ops.c     |  31 ++++----
 fs/cifs/smb2pdu.c     |  72 +++++++++---------
 fs/cifs/smbdirect.c   | 165 +++++++++++++++++-------------------------
 fs/cifs/transport.c   |  25 +++----
 20 files changed, 321 insertions(+), 383 deletions(-)

diff --git a/fs/cifs/cifs_debug.h b/fs/cifs/cifs_debug.h
index 100b00..5e66da 100644
--- a/fs/cifs/cifs_debug.h
+++ b/fs/cifs/cifs_debug.h
@@ -8,6 +8,12 @@
 #ifndef _H_CIFS_DEBUG
 #define _H_CIFS_DEBUG
 
+#ifdef pr_fmt
+#undef pr_fmt
+#endif
+
+#define pr_fmt(fmt) "CIFS: " fmt
+
 void cifs_dump_mem(char *label, void *data, int length);
 void cifs_dump_detail(void *buf, struct TCP_Server_Info *ptcp_info);
 void cifs_dump_mids(struct TCP_Server_Info *);
@@ -46,92 +52,81 @@ extern int cifsFYI;
  */
 
 /* Information level messages, minor events */
-#define cifs_info_func(ratefunc, fmt, ...)			\
-do {								\
-	pr_info_ ## ratefunc("CIFS: " fmt, ##__VA_ARGS__); 	\
-} while (0)
+#define cifs_info_func(ratefunc, fmt, ...)				\
+	pr_info_ ## ratefunc(fmt, ##__VA_ARGS__)
 
-#define cifs_info(fmt, ...)					\
-do { 								\
-	cifs_info_func(ratelimited, fmt, ##__VA_ARGS__); 	\
-} while (0)
+#define cifs_info(fmt, ...)						\
+	cifs_info_func(ratelimited, fmt, ##__VA_ARGS__)
 
 /* information message: e.g., configuration, major event */
-#define cifs_dbg_func(ratefunc, type, fmt, ...)			\
-do {								\
-	if ((type) & FYI && cifsFYI & CIFS_INFO) {		\
-		pr_debug_ ## ratefunc("%s: "			\
-				fmt, __FILE__, ##__VA_ARGS__);	\
-	} else if ((type) & VFS) {				\
-		pr_err_ ## ratefunc("CIFS VFS: "		\
-				 fmt, ##__VA_ARGS__);		\
-	} else if ((type) & NOISY && (NOISY != 0)) {		\
-		pr_debug_ ## ratefunc(fmt, ##__VA_ARGS__);	\
-	}							\
+#define cifs_dbg_func(ratefunc, type, fmt, ...)				\
+do {									\
+	if ((type) & FYI && cifsFYI & CIFS_INFO) {			\
+		pr_debug_ ## ratefunc("%s: " fmt,			\
+				      __FILE__, ##__VA_ARGS__);		\
+	} else if ((type) & VFS) {					\
+		pr_err_ ## ratefunc("VFS: " fmt, ##__VA_ARGS__);	\
+	} else if ((type) & NOISY && (NOISY != 0)) {			\
+		pr_debug_ ## ratefunc(fmt, ##__VA_ARGS__);		\
+	}								\
 } while (0)
 
-#define cifs_dbg(type, fmt, ...) \
-do {							\
-	if ((type) & ONCE)				\
-		cifs_dbg_func(once,			\
-			 type, fmt, ##__VA_ARGS__);	\
-	else						\
-		cifs_dbg_func(ratelimited,		\
-			type, fmt, ##__VA_ARGS__);	\
+#define cifs_dbg(type, fmt, ...)					\
+do {									\
+	if ((type) & ONCE)						\
+		cifs_dbg_func(once, type, fmt, ##__VA_ARGS__);		\
+	else								\
+		cifs_dbg_func(ratelimited, type, fmt, ##__VA_ARGS__);	\
 } while (0)
 
-#define cifs_server_dbg_func(ratefunc, type, fmt, ...)		\
-do {								\
-	const char *sn = "";					\
-	if (server && server->hostname)				\
-		sn = server->hostname;				\
-	if ((type) & FYI && cifsFYI & CIFS_INFO) {		\
-		pr_debug_ ## ratefunc("%s: \\\\%s "	fmt,	\
-			__FILE__, sn, ##__VA_ARGS__);		\
-	} else if ((type) & VFS) {				\
-		pr_err_ ## ratefunc("CIFS VFS: \\\\%s " fmt,	\
-			sn, ##__VA_ARGS__);			\
-	} else if ((type) & NOISY && (NOISY != 0)) {		\
-		pr_debug_ ## ratefunc("\\\\%s " fmt,		\
-			sn, ##__VA_ARGS__);			\
-	}							\
+#define cifs_server_dbg_func(ratefunc, type, fmt, ...)			\
+do {									\
+	const char *sn = "";						\
+	if (server && server->hostname)					\
+		sn = server->hostname;					\
+	if ((type) & FYI && cifsFYI & CIFS_INFO) {			\
+		pr_debug_ ## ratefunc("%s: \\\\%s " fmt,		\
+				      __FILE__, sn, ##__VA_ARGS__);	\
+	} else if ((type) & VFS) {					\
+		pr_err_ ## ratefunc("VFS: \\\\%s " fmt,			\
+				    sn, ##__VA_ARGS__);			\
+	} else if ((type) & NOISY && (NOISY != 0)) {			\
+		pr_debug_ ## ratefunc("\\\\%s " fmt,			\
+				      sn, ##__VA_ARGS__);		\
+	}								\
 } while (0)
 
-#define cifs_server_dbg(type, fmt, ...)			\
-do {							\
-	if ((type) & ONCE)				\
-		cifs_server_dbg_func(once,		\
-			type, fmt, ##__VA_ARGS__);	\
-	else						\
-		cifs_server_dbg_func(ratelimited,	\
-			type, fmt, ##__VA_ARGS__);	\
+#define cifs_server_dbg(type, fmt, ...)					\
+do {									\
+	if ((type) & ONCE)						\
+		cifs_server_dbg_func(once, type, fmt, ##__VA_ARGS__);	\
+	else								\
+		cifs_server_dbg_func(ratelimited, type, fmt,		\
+				     ##__VA_ARGS__);			\
 } while (0)
 
-#define cifs_tcon_dbg_func(ratefunc, type, fmt, ...)		\
-do {								\
-	const char *tn = "";					\
-	if (tcon && tcon->treeName)				\
-		tn = tcon->treeName;				\
-	if ((type) & FYI && cifsFYI & CIFS_INFO) {		\
-		pr_debug_ ## ratefunc("%s: %s "	fmt,		\
-			__FILE__, tn, ##__VA_ARGS__);		\
-	} else if ((type) & VFS) {				\
-		pr_err_ ## ratefunc("CIFS VFS: %s " fmt,	\
-			tn, ##__VA_ARGS__);			\
-	} else if ((type) & NOISY && (NOISY != 0)) {		\
-		pr_debug_ ## ratefunc("%s " fmt,		\
-			tn, ##__VA_ARGS__);			\
-	}							\
+#define cifs_tcon_dbg_func(ratefunc, type, fmt, ...)			\
+do {									\
+	const char *tn = "";						\
+	if (tcon && tcon->treeName)					\
+		tn = tcon->treeName;					\
+	if ((type) & FYI && cifsFYI & CIFS_INFO) {			\
+		pr_debug_ ## ratefunc("%s: %s "	fmt,			\
+				      __FILE__, tn, ##__VA_ARGS__);	\
+	} else if ((type) & VFS) {					\
+		pr_err_ ## ratefunc("VFS: %s " fmt, tn, ##__VA_ARGS__);	\
+	} else if ((type) & NOISY && (NOISY != 0)) {			\
+		pr_debug_ ## ratefunc("%s " fmt, tn, ##__VA_ARGS__);	\
+	}								\
 } while (0)
 
-#define cifs_tcon_dbg(type, fmt, ...)			\
-do {							\
-	if ((type) & ONCE)				\
-		cifs_tcon_dbg_func(once,		\
-			type, fmt, ##__VA_ARGS__);	\
-	else						\
-		cifs_tcon_dbg_func(ratelimited,	\
-			type, fmt, ##__VA_ARGS__);	\
+#define cifs_tcon_dbg(type, fmt, ...)					\
+do {									\
+	if ((type) & ONCE)						\
+		cifs_tcon_dbg_func(once, type, fmt, ##__VA_ARGS__);	\
+	else								\
+		cifs_tcon_dbg_func(ratelimited, type, fmt,		\
+				   ##__VA_ARGS__);			\
 } while (0)
 
 /*
@@ -159,9 +154,7 @@ do {									\
 } while (0)
 
 #define cifs_info(fmt, ...)						\
-do {									\
-	pr_info("CIFS: "fmt, ##__VA_ARGS__);				\
-} while (0)
+	pr_info(fmt, ##__VA_ARGS__)
 #endif
 
 #endif				/* _H_CIFS_DEBUG */
diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
index 97b749..874a55 100644
--- a/fs/cifs/cifsencrypt.c
+++ b/fs/cifs/cifsencrypt.c
@@ -520,7 +520,7 @@ static int calc_ntlmv2_hash(struct cifs_ses *ses, char *ntlmv2_hash,
 
 	rc = crypto_shash_init(&ses->server->secmech.sdeschmacmd5->shash);
 	if (rc) {
-		cifs_dbg(VFS, "%s: could not init hmacmd5\n", __func__);
+		cifs_dbg(VFS, "%s: Could not init hmacmd5\n", __func__);
 		return rc;
 	}
 
@@ -624,7 +624,7 @@ CalcNTLMv2_response(const struct cifs_ses *ses, char *ntlmv2_hash)
 
 	rc = crypto_shash_init(&ses->server->secmech.sdeschmacmd5->shash);
 	if (rc) {
-		cifs_dbg(VFS, "%s: could not init hmacmd5\n", __func__);
+		cifs_dbg(VFS, "%s: Could not init hmacmd5\n", __func__);
 		return rc;
 	}
 
@@ -723,7 +723,7 @@ setup_ntlmv2_rsp(struct cifs_ses *ses, const struct nls_table *nls_cp)
 	/* calculate ntlmv2_hash */
 	rc = calc_ntlmv2_hash(ses, ntlmv2_hash, nls_cp);
 	if (rc) {
-		cifs_dbg(VFS, "could not get v2 hash rc %d\n", rc);
+		cifs_dbg(VFS, "Could not get v2 hash rc %d\n", rc);
 		goto unlock;
 	}
 
@@ -783,7 +783,7 @@ calc_seckey(struct cifs_ses *ses)
 
 	ctx_arc4 = kmalloc(sizeof(*ctx_arc4), GFP_KERNEL);
 	if (!ctx_arc4) {
-		cifs_dbg(VFS, "could not allocate arc4 context\n");
+		cifs_dbg(VFS, "Could not allocate arc4 context\n");
 		return -ENOMEM;
 	}
 
diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
index 12a895..530d0b 100644
--- a/fs/cifs/cifsproto.h
+++ b/fs/cifs/cifsproto.h
@@ -45,25 +45,25 @@ extern int smb_send(struct TCP_Server_Info *, struct smb_hdr *,
 			unsigned int /* length */);
 extern unsigned int _get_xid(void);
 extern void _free_xid(unsigned int);
-#define get_xid()						\
-({								\
+#define get_xid()							\
+({									\
 	unsigned int __xid = _get_xid();				\
-	cifs_dbg(FYI, "CIFS VFS: in %s as Xid: %u with uid: %d\n",	\
+	cifs_dbg(FYI, "VFS: in %s as Xid: %u with uid: %d\n",		\
 		 __func__, __xid,					\
 		 from_kuid(&init_user_ns, current_fsuid()));		\
-	trace_smb3_enter(__xid, __func__);			\
-	__xid;							\
+	trace_smb3_enter(__xid, __func__);				\
+	__xid;								\
 })
 
-#define free_xid(curr_xid)					\
-do {								\
-	_free_xid(curr_xid);					\
-	cifs_dbg(FYI, "CIFS VFS: leaving %s (xid = %u) rc = %d\n",	\
-		 __func__, curr_xid, (int)rc);			\
-	if (rc)							\
+#define free_xid(curr_xid)						\
+do {									\
+	_free_xid(curr_xid);						\
+	cifs_dbg(FYI, "VFS: leaving %s (xid = %u) rc = %d\n",		\
+		 __func__, curr_xid, (int)rc);				\
+	if (rc)								\
 		trace_smb3_exit_err(curr_xid, __func__, (int)rc);	\
-	else							\
-		trace_smb3_exit_done(curr_xid, __func__);	\
+	else								\
+		trace_smb3_exit_done(curr_xid, __func__);		\
 } while (0)
 extern int init_cifs_idmap(void);
 extern void exit_cifs_idmap(void);
diff --git a/fs/cifs/cifsroot.c b/fs/cifs/cifsroot.c
index 37edbfb..9e91a5 100644
--- a/fs/cifs/cifsroot.c
+++ b/fs/cifs/cifsroot.c
@@ -56,7 +56,7 @@ static int __init cifs_root_setup(char *line)
 		/* len is strlen(unc) + '\0' */
 		len = s - line + 1;
 		if (len > sizeof(root_dev)) {
-			printk(KERN_ERR "Root-CIFS: UNC path too long\n");
+			pr_err("Root-CIFS: UNC path too long\n");
 			return 1;
 		}
 		strlcpy(root_dev, line, len);
@@ -66,7 +66,7 @@ static int __init cifs_root_setup(char *line)
 					 sizeof(root_opts), "%s,%s",
 					 DEFAULT_MNT_OPTS, s + 1);
 			if (n >= sizeof(root_opts)) {
-				printk(KERN_ERR "Root-CIFS: mount options string too long\n");
+				pr_err("Root-CIFS: mount options string too long\n");
 				root_opts[sizeof(root_opts)-1] = '\0';
 				return 1;
 			}
@@ -83,7 +83,7 @@ __setup("cifsroot=", cifs_root_setup);
 int __init cifs_root_data(char **dev, char **opts)
 {
 	if (!root_dev[0] || root_server_addr == htonl(INADDR_NONE)) {
-		printk(KERN_ERR "Root-CIFS: no SMB server address\n");
+		pr_err("Root-CIFS: no SMB server address\n");
 		return -1;
 	}
 
diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
index 140efc..9d193d2 100644
--- a/fs/cifs/cifssmb.c
+++ b/fs/cifs/cifssmb.c
@@ -177,7 +177,7 @@ static int __cifs_reconnect_tcon(const struct nls_table *nlsc,
 
 		if (dfs_host_len != tcp_host_len
 		    || strncasecmp(dfs_host, tcp_host, dfs_host_len) != 0) {
-			cifs_dbg(FYI, "%s: skipping %.*s, doesn't match %.*s",
+			cifs_dbg(FYI, "%s: skipping %.*s, doesn't match %.*s\n",
 				 __func__,
 				 (int)dfs_host_len, dfs_host,
 				 (int)tcp_host_len, tcp_host);
@@ -262,8 +262,8 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 						      (server->tcpStatus != CifsNeedReconnect),
 						      10 * HZ);
 		if (rc < 0) {
-			cifs_dbg(FYI, "%s: aborting reconnect due to a received"
-				 " signal by the process\n", __func__);
+			cifs_dbg(FYI, "%s: aborting reconnect due to a received signal by the process\n",
+				 __func__);
 			return -ERESTARTSYS;
 		}
 
@@ -324,7 +324,7 @@ cifs_reconnect_tcon(struct cifs_tcon *tcon, int smb_command)
 	cifs_dbg(FYI, "reconnect tcon rc = %d\n", rc);
 
 	if (rc) {
-		printk_once(KERN_WARNING "reconnect tcon failed rc = %d\n", rc);
+		pr_warn_once("reconnect tcon failed rc = %d\n", rc);
 		goto out;
 	}
 
@@ -557,7 +557,7 @@ cifs_enable_signing(struct TCP_Server_Info *server, bool mnt_sign_required)
 	/* If server requires signing, does client allow it? */
 	if (srv_sign_required) {
 		if (!mnt_sign_enabled) {
-			cifs_dbg(VFS, "Server requires signing, but it's disabled in SecurityFlags!");
+			cifs_dbg(VFS, "Server requires signing, but it's disabled in SecurityFlags!\n");
 			return -ENOTSUPP;
 		}
 		server->sign = true;
@@ -566,14 +566,14 @@ cifs_enable_signing(struct TCP_Server_Info *server, bool mnt_sign_required)
 	/* If client requires signing, does server allow it? */
 	if (mnt_sign_required) {
 		if (!srv_sign_enabled) {
-			cifs_dbg(VFS, "Server does not support signing!");
+			cifs_dbg(VFS, "Server does not support signing!\n");
 			return -ENOTSUPP;
 		}
 		server->sign = true;
 	}
 
 	if (cifs_rdma_enabled(server) && server->sign)
-		cifs_dbg(VFS, "Signing is enabled, and RDMA read/write will be disabled");
+		cifs_dbg(VFS, "Signing is enabled, and RDMA read/write will be disabled\n");
 
 	return 0;
 }
@@ -701,7 +701,7 @@ CIFSSMBNegotiate(const unsigned int xid, struct cifs_ses *ses)
 	pSMB->hdr.Flags2 |= (SMBFLG2_UNICODE | SMBFLG2_ERR_STATUS);
 
 	if (should_set_ext_sec_flag(ses->sectype)) {
-		cifs_dbg(FYI, "Requesting extended security.");
+		cifs_dbg(FYI, "Requesting extended security\n");
 		pSMB->hdr.Flags2 |= SMBFLG2_EXT_SEC;
 	}
 
@@ -3864,7 +3864,7 @@ CIFSGetExtAttr(const unsigned int xid, struct cifs_tcon *tcon,
 			struct file_chattr_info *pfinfo;
 			/* BB Do we need a cast or hash here ? */
 			if (count != 16) {
-				cifs_dbg(FYI, "Illegal size ret in GetExtAttr\n");
+				cifs_dbg(FYI, "Invalid size ret in GetExtAttr\n");
 				rc = -EIO;
 				goto GetExtAttrOut;
 			}
@@ -4240,7 +4240,7 @@ CIFSSMBQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
-		cifs_dbg(FYI, "Send error in QFileInfo = %d", rc);
+		cifs_dbg(FYI, "Send error in QFileInfo = %d\n", rc);
 	} else {		/* decode response */
 		rc = validate_t2((struct smb_t2_rsp *)pSMBr);
 
@@ -4407,7 +4407,7 @@ CIFSSMBUnixQFileInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
-		cifs_dbg(FYI, "Send error in UnixQFileInfo = %d", rc);
+		cifs_dbg(FYI, "Send error in UnixQFileInfo = %d\n", rc);
 	} else {		/* decode response */
 		rc = validate_t2((struct smb_t2_rsp *)pSMBr);
 
@@ -4489,7 +4489,7 @@ CIFSSMBUnixQPathInfo(const unsigned int xid, struct cifs_tcon *tcon,
 	rc = SendReceive(xid, tcon->ses, (struct smb_hdr *) pSMB,
 			 (struct smb_hdr *) pSMBr, &bytes_returned, 0);
 	if (rc) {
-		cifs_dbg(FYI, "Send error in UnixQPathInfo = %d", rc);
+		cifs_dbg(FYI, "Send error in UnixQPathInfo = %d\n", rc);
 	} else {		/* decode response */
 		rc = validate_t2((struct smb_t2_rsp *)pSMBr);
 
@@ -4909,7 +4909,7 @@ CIFSGetSrvInodeNumber(const unsigned int xid, struct cifs_tcon *tcon,
 			struct file_internal_info *pfinfo;
 			/* BB Do we need a cast or hash here ? */
 			if (count < 8) {
-				cifs_dbg(FYI, "Illegal size ret in QryIntrnlInf\n");
+				cifs_dbg(FYI, "Invalid size ret in QryIntrnlInf\n");
 				rc = -EIO;
 				goto GetInodeNumOut;
 			}
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index 95b3ab0..869c3b 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -877,8 +877,7 @@ dequeue_mid(struct mid_q_entry *mid, bool malformed)
 	 * function has finished processing it is a bug.
 	 */
 	if (mid->mid_flags & MID_DELETED)
-		printk_once(KERN_WARNING
-			    "trying to dequeue a deleted mid\n");
+		pr_warn_once("trying to dequeue a deleted mid\n");
 	else {
 		list_del_init(&mid->qhead);
 		mid->mid_flags |= MID_DELETED;
@@ -1227,9 +1226,8 @@ cifs_demultiplex_thread(void *p)
 				smb2_add_credits_from_hdr(bufs[i], server);
 				cifs_dbg(FYI, "Received oplock break\n");
 			} else {
-				cifs_server_dbg(VFS, "No task to wake, unknown frame "
-					 "received! NumMids %d\n",
-					 atomic_read(&midCount));
+				cifs_server_dbg(VFS, "No task to wake, unknown frame received! NumMids %d\n",
+						atomic_read(&midCount));
 				cifs_dump_mem("Received Data is: ", bufs[i],
 					      HEADER_SIZE(server));
 				smb2_add_credits_from_hdr(bufs[i], server);
@@ -1474,9 +1472,7 @@ cifs_parse_smb_version(char *value, struct smb_vol *vol, bool is_smb3)
 			cifs_dbg(VFS, "vers=1.0 (cifs) not permitted when mounting with smb3\n");
 			return 1;
 		}
-		cifs_dbg(VFS, "Use of the less secure dialect vers=1.0 "
-			   "is not recommended unless required for "
-			   "access to very old servers\n");
+		cifs_dbg(VFS, "Use of the less secure dialect vers=1.0 is not recommended unless required for access to very old servers\n");
 		vol->ops = &smb1_operations;
 		vol->vals = &smb1_values;
 		break;
@@ -1543,7 +1539,7 @@ cifs_parse_devname(const char *devname, struct smb_vol *vol)
 	size_t len;
 
 	if (unlikely(!devname || !*devname)) {
-		cifs_dbg(VFS, "Device name not specified.\n");
+		cifs_dbg(VFS, "Device name not specified\n");
 		return -EINVAL;
 	}
 
@@ -1693,13 +1689,13 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 	case 0:
 		break;
 	case -ENOMEM:
-		cifs_dbg(VFS, "Unable to allocate memory for devname.\n");
+		cifs_dbg(VFS, "Unable to allocate memory for devname\n");
 		goto cifs_parse_mount_err;
 	case -EINVAL:
-		cifs_dbg(VFS, "Malformed UNC in devname.\n");
+		cifs_dbg(VFS, "Malformed UNC in devname\n");
 		goto cifs_parse_mount_err;
 	default:
-		cifs_dbg(VFS, "Unknown error parsing devname.\n");
+		cifs_dbg(VFS, "Unknown error parsing devname\n");
 		goto cifs_parse_mount_err;
 	}
 
@@ -1907,7 +1903,7 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 			vol->seal = 1;
 			break;
 		case Opt_noac:
-			pr_warn("CIFS: Mount option noac not supported. Instead set /proc/fs/cifs/LookupCacheEnabled to 0\n");
+			pr_warn("Mount option noac not supported. Instead set /proc/fs/cifs/LookupCacheEnabled to 0\n");
 			break;
 		case Opt_fsc:
 #ifndef CONFIG_CIFS_FSCACHE
@@ -2154,7 +2150,7 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 
 			if (strnlen(string, CIFS_MAX_USERNAME_LEN) >
 							CIFS_MAX_USERNAME_LEN) {
-				pr_warn("CIFS: username too long\n");
+				pr_warn("username too long\n");
 				goto cifs_parse_mount_err;
 			}
 
@@ -2220,7 +2216,7 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 			temp_len = strlen(value);
 			vol->password = kzalloc(temp_len+1, GFP_KERNEL);
 			if (vol->password == NULL) {
-				pr_warn("CIFS: no memory for password\n");
+				pr_warn("no memory for password\n");
 				goto cifs_parse_mount_err;
 			}
 
@@ -2244,7 +2240,7 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 
 			if (!cifs_convert_address(dstaddr, string,
 					strlen(string))) {
-				pr_err("CIFS: bad ip= option (%s).\n", string);
+				pr_err("bad ip= option (%s)\n", string);
 				goto cifs_parse_mount_err;
 			}
 			got_ip = true;
@@ -2256,14 +2252,14 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 
 			if (strnlen(string, CIFS_MAX_DOMAINNAME_LEN)
 					== CIFS_MAX_DOMAINNAME_LEN) {
-				pr_warn("CIFS: domain name too long\n");
+				pr_warn("domain name too long\n");
 				goto cifs_parse_mount_err;
 			}
 
 			kfree(vol->domainname);
 			vol->domainname = kstrdup(string, GFP_KERNEL);
 			if (!vol->domainname) {
-				pr_warn("CIFS: no memory for domainname\n");
+				pr_warn("no memory for domainname\n");
 				goto cifs_parse_mount_err;
 			}
 			cifs_dbg(FYI, "Domain name set\n");
@@ -2276,7 +2272,7 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 			if (!cifs_convert_address(
 					(struct sockaddr *)&vol->srcaddr,
 					string, strlen(string))) {
-				pr_warn("CIFS: Could not parse srcaddr: %s\n",
+				pr_warn("Could not parse srcaddr: %s\n",
 					string);
 				goto cifs_parse_mount_err;
 			}
@@ -2287,7 +2283,7 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 				goto out_nomem;
 
 			if (strnlen(string, 1024) >= 65) {
-				pr_warn("CIFS: iocharset name too long.\n");
+				pr_warn("iocharset name too long\n");
 				goto cifs_parse_mount_err;
 			}
 
@@ -2296,7 +2292,7 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 				vol->iocharset = kstrdup(string,
 							 GFP_KERNEL);
 				if (!vol->iocharset) {
-					pr_warn("CIFS: no memory for charset\n");
+					pr_warn("no memory for charset\n");
 					goto cifs_parse_mount_err;
 				}
 			}
@@ -2327,7 +2323,7 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 			 * set at top of the function
 			 */
 			if (i == RFC1001_NAME_LEN && string[i] != 0)
-				pr_warn("CIFS: netbiosname longer than 15 truncated.\n");
+				pr_warn("netbiosname longer than 15 truncated\n");
 			break;
 		case Opt_servern:
 			/* servernetbiosname specified override *SMBSERVER */
@@ -2353,7 +2349,7 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 			/* The string has 16th byte zero still from
 			   set at top of the function  */
 			if (i == RFC1001_NAME_LEN && string[i] != 0)
-				pr_warn("CIFS: server netbiosname longer than 15 truncated.\n");
+				pr_warn("server netbiosname longer than 15 truncated\n");
 			break;
 		case Opt_ver:
 			/* version of mount userspace tools, not dialect */
@@ -2364,17 +2360,15 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 			/* If interface changes in mount.cifs bump to new ver */
 			if (strncasecmp(string, "1", 1) == 0) {
 				if (strlen(string) > 1) {
-					pr_warn("Bad mount helper ver=%s. Did "
-						"you want SMB1 (CIFS) dialect "
-						"and mean to type vers=1.0 "
-						"instead?\n", string);
+					pr_warn("Bad mount helper ver=%s. Did you want SMB1 (CIFS) dialect and mean to type vers=1.0 instead?\n",
+						string);
 					goto cifs_parse_mount_err;
 				}
 				/* This is the default */
 				break;
 			}
 			/* For all other value, error */
-			pr_warn("CIFS: Invalid mount helper version specified\n");
+			pr_warn("Invalid mount helper version specified\n");
 			goto cifs_parse_mount_err;
 		case Opt_vers:
 			/* protocol version (dialect) */
@@ -2417,7 +2411,7 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 	}
 
 	if (!sloppy && invalid) {
-		pr_err("CIFS: Unknown mount option \"%s\"\n", invalid);
+		pr_err("Unknown mount option \"%s\"\n", invalid);
 		goto cifs_parse_mount_err;
 	}
 
@@ -2453,7 +2447,7 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 		slash = strchr(&vol->UNC[2], '\\');
 		len = slash - &vol->UNC[2];
 		if (!cifs_convert_address(dstaddr, &vol->UNC[2], len)) {
-			pr_err("Unable to determine destination address.\n");
+			pr_err("Unable to determine destination address\n");
 			goto cifs_parse_mount_err;
 		}
 	}
@@ -2464,20 +2458,15 @@ cifs_parse_mount_options(const char *mountdata, const char *devname,
 	if (uid_specified)
 		vol->override_uid = override_uid;
 	else if (override_uid == 1)
-		pr_notice("CIFS: ignoring forceuid mount option specified with no uid= option.\n");
+		pr_notice("ignoring forceuid mount option specified with no uid= option\n");
 
 	if (gid_specified)
 		vol->override_gid = override_gid;
 	else if (override_gid == 1)
-		pr_notice("CIFS: ignoring forcegid mount option specified with no gid= option.\n");
+		pr_notice("ignoring forcegid mount option specified with no gid= option\n");
 
 	if (got_version == false)
-		pr_warn_once("No dialect specified on mount. Default has changed"
-			" to a more secure dialect, SMB2.1 or later (e.g. "
-			"SMB3.1.1), from CIFS (SMB1). To use the less secure "
-			"SMB1 dialect to access old servers which do not "
-			"support SMB3.1.1 (or even SMB3 or SMB2.1) specify "
-			"vers=1.0 on mount.\n");
+		pr_warn_once("No dialect specified on mount. Default has changed to a more secure dialect, SMB2.1 or later (e.g. SMB3.1.1), from CIFS (SMB1). To use the less secure SMB1 dialect to access old servers which do not support SMB3.1.1 (or even SMB3 or SMB2.1) specify vers=1.0 on mount.\n");
 
 	kfree(mountdata_copy);
 	return 0;
@@ -3195,8 +3184,8 @@ cifs_set_cifscreds(struct smb_vol *vol, struct cifs_ses *ses)
 					   strlen(ses->domainName),
 					   GFP_KERNEL);
 		if (!vol->domainname) {
-			cifs_dbg(FYI, "Unable to allocate %zd bytes for "
-				 "domain\n", len);
+			cifs_dbg(FYI, "Unable to allocate %zd bytes for domain\n",
+				 len);
 			rc = -ENOMEM;
 			kfree(vol->username);
 			vol->username = NULL;
@@ -3513,10 +3502,9 @@ cifs_get_tcon(struct cifs_ses *ses, struct smb_vol *volume_info)
 	if (volume_info->linux_ext) {
 		if (ses->server->posix_ext_supported) {
 			tcon->posix_extensions = true;
-			printk_once(KERN_WARNING
-				"SMB3.11 POSIX Extensions are experimental\n");
+			pr_warn_once("SMB3.11 POSIX Extensions are experimental\n");
 		} else {
-			cifs_dbg(VFS, "Server does not support mounting with posix SMB3.11 extensions.\n");
+			cifs_dbg(VFS, "Server does not support mounting with posix SMB3.11 extensions\n");
 			rc = -EOPNOTSUPP;
 			goto out_fail;
 		}
@@ -4736,8 +4724,7 @@ static int is_path_remote(struct cifs_sb_info *cifs_sb, struct smb_vol *vol,
 		rc = cifs_are_all_path_components_accessible(server, xid, tcon,
 			cifs_sb, full_path, tcon->Flags & SMB_SHARE_IS_IN_DFS);
 		if (rc != 0) {
-			cifs_server_dbg(VFS, "cannot query dirs between root and final path, "
-				 "enabling CIFS_MOUNT_USE_PREFIX_PATH\n");
+			cifs_server_dbg(VFS, "cannot query dirs between root and final path, enabling CIFS_MOUNT_USE_PREFIX_PATH\n");
 			cifs_sb->mnt_cifs_flags |= CIFS_MOUNT_USE_PREFIX_PATH;
 			rc = 0;
 		}
diff --git a/fs/cifs/dfs_cache.c b/fs/cifs/dfs_cache.c
index a67f88bf..df81c7 100644
--- a/fs/cifs/dfs_cache.c
+++ b/fs/cifs/dfs_cache.c
@@ -198,7 +198,7 @@ static ssize_t dfscache_proc_write(struct file *file, const char __user *buffer,
 	if (c != '0')
 		return -EINVAL;
 
-	cifs_dbg(FYI, "clearing dfs cache");
+	cifs_dbg(FYI, "clearing dfs cache\n");
 
 	down_write(&htable_rw_lock);
 	flush_cache_ents();
@@ -234,8 +234,8 @@ static inline void dump_tgts(const struct cache_entry *ce)
 
 static inline void dump_ce(const struct cache_entry *ce)
 {
-	cifs_dbg(FYI, "cache entry: path=%s,type=%s,ttl=%d,etime=%ld,"
-		 "interlink=%s,path_consumed=%d,expired=%s\n", ce->path,
+	cifs_dbg(FYI, "cache entry: path=%s,type=%s,ttl=%d,etime=%ld,interlink=%s,path_consumed=%d,expired=%s\n",
+		 ce->path,
 		 ce->srvtype == DFS_TYPE_ROOT ? "root" : "link", ce->ttl,
 		 ce->etime.tv_nsec,
 		 IS_INTERLINK_SET(ce->flags) ? "yes" : "no",
@@ -453,11 +453,11 @@ static void remove_oldest_entry(void)
 	}
 
 	if (!to_del) {
-		cifs_dbg(FYI, "%s: no entry to remove", __func__);
+		cifs_dbg(FYI, "%s: no entry to remove\n", __func__);
 		return;
 	}
 
-	cifs_dbg(FYI, "%s: removing entry", __func__);
+	cifs_dbg(FYI, "%s: removing entry\n", __func__);
 	dump_ce(to_del);
 	flush_cache_ent(to_del);
 }
@@ -696,8 +696,8 @@ static int __dfs_cache_find(const unsigned int xid, struct cifs_ses *ses,
 	}
 
 	if (atomic_read(&cache_count) >= CACHE_MAX_ENTRIES) {
-		cifs_dbg(FYI, "%s: reached max cache size (%d)", __func__,
-			 CACHE_MAX_ENTRIES);
+		cifs_dbg(FYI, "%s: reached max cache size (%d)\n",
+			 __func__, CACHE_MAX_ENTRIES);
 		down_write(&htable_rw_lock);
 		remove_oldest_entry();
 		up_write(&htable_rw_lock);
diff --git a/fs/cifs/file.c b/fs/cifs/file.c
index 0b1528..6abc4d 100644
--- a/fs/cifs/file.c
+++ b/fs/cifs/file.c
@@ -857,7 +857,7 @@ cifs_reopen_persistent_handles(struct cifs_tcon *tcon)
 
 	tcon->need_reopen_files = false;
 
-	cifs_dbg(FYI, "Reopen persistent handles");
+	cifs_dbg(FYI, "Reopen persistent handles\n");
 	INIT_LIST_HEAD(&tmp_list);
 
 	/* list all files open on tree connection, reopen resilient handles  */
@@ -2056,7 +2056,7 @@ find_writable_file(struct cifsInodeInfo *cifs_inode, int flags)
 
 	rc = cifs_get_writable_file(cifs_inode, flags, &cfile);
 	if (rc)
-		cifs_dbg(FYI, "couldn't find writable handle rc=%d", rc);
+		cifs_dbg(FYI, "Couldn't find writable handle rc=%d\n", rc);
 
 	return cfile;
 }
@@ -2923,11 +2923,9 @@ cifs_write_from_iter(loff_t offset, size_t len, struct iov_iter *from,
 				from, &pagevec, cur_len, &start);
 			if (result < 0) {
 				cifs_dbg(VFS,
-					"direct_writev couldn't get user pages "
-					"(rc=%zd) iter type %d iov_offset %zd "
-					"count %zd\n",
-					result, iov_iter_type(from),
-					from->iov_offset, from->count);
+					 "direct_writev couldn't get user pages (rc=%zd) iter type %d iov_offset %zd count %zd\n",
+					 result, iov_iter_type(from),
+					 from->iov_offset, from->count);
 				dump_stack();
 
 				rc = result;
@@ -3654,12 +3652,10 @@ cifs_send_async_read(loff_t offset, size_t len, struct cifsFileInfo *open_file,
 					cur_len, &start);
 			if (result < 0) {
 				cifs_dbg(VFS,
-					"couldn't get user pages (rc=%zd)"
-					" iter type %d"
-					" iov_offset %zd count %zd\n",
-					result, iov_iter_type(&direct_iov),
-					direct_iov.iov_offset,
-					direct_iov.count);
+					 "Couldn't get user pages (rc=%zd) iter type %d iov_offset %zd count %zd\n",
+					 result, iov_iter_type(&direct_iov),
+					 direct_iov.iov_offset,
+					 direct_iov.count);
 				dump_stack();
 
 				rc = result;
@@ -4828,7 +4824,7 @@ static int cifs_swap_activate(struct swap_info_struct *sis,
 	}
 	*span = sis->pages;
 
-	printk_once(KERN_WARNING "Swap support over SMB3 is experimental\n");
+	pr_warn_once("Swap support over SMB3 is experimental\n");
 
 	/*
 	 * TODO: consider adding ACL (or documenting how) to prevent other
diff --git a/fs/cifs/inode.c b/fs/cifs/inode.c
index 8fbbdcd..224486 100644
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@ -1155,7 +1155,7 @@ struct inode *cifs_root_iget(struct super_block *sb)
 		/* some servers mistakenly claim POSIX support */
 		if (rc != -EOPNOTSUPP)
 			goto iget_no_retry;
-		cifs_dbg(VFS, "server does not support POSIX extensions");
+		cifs_dbg(VFS, "server does not support POSIX extensions\n");
 		tcon->unix_ext = false;
 	}
 
@@ -1999,7 +1999,7 @@ cifs_invalidate_mapping(struct inode *inode)
 	if (inode->i_mapping && inode->i_mapping->nrpages != 0) {
 		rc = invalidate_inode_pages2(inode->i_mapping);
 		if (rc)
-			cifs_dbg(VFS, "%s: could not invalidate inode %p\n",
+			cifs_dbg(VFS, "%s: Could not invalidate inode %p\n",
 				 __func__, inode);
 	}
 
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index a456feb..9d9b90 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -421,7 +421,7 @@ is_valid_oplock_break(char *buffer, struct TCP_Server_Info *srv)
 
 			if (data_offset >
 			    len - sizeof(struct file_notify_information)) {
-				cifs_dbg(FYI, "invalid data_offset %u\n",
+				cifs_dbg(FYI, "Invalid data_offset %u\n",
 					 data_offset);
 				return true;
 			}
@@ -449,7 +449,7 @@ is_valid_oplock_break(char *buffer, struct TCP_Server_Info *srv)
 		   large dirty files cached on the client */
 		if ((NT_STATUS_INVALID_HANDLE) ==
 		   le32_to_cpu(pSMB->hdr.Status.CifsError)) {
-			cifs_dbg(FYI, "invalid handle on oplock break\n");
+			cifs_dbg(FYI, "Invalid handle on oplock break\n");
 			return true;
 		} else if (ERRbadfid ==
 		   le16_to_cpu(pSMB->hdr.Status.DosError.Error)) {
@@ -530,9 +530,9 @@ cifs_autodisable_serverino(struct cifs_sb_info *cifs_sb)
 
 		cifs_sb->mnt_cifs_flags &= ~CIFS_MOUNT_SERVER_INUM;
 		cifs_sb->mnt_cifs_serverino_autodisabled = true;
-		cifs_dbg(VFS, "Autodisabling the use of server inode numbers on %s.\n",
+		cifs_dbg(VFS, "Autodisabling the use of server inode numbers on %s\n",
 			 tcon ? tcon->treeName : "new server");
-		cifs_dbg(VFS, "The server doesn't seem to support them properly or the files might be on different servers (DFS).\n");
+		cifs_dbg(VFS, "The server doesn't seem to support them properly or the files might be on different servers (DFS)\n");
 		cifs_dbg(VFS, "Hardlinks will not be recognized on this mount. Consider mounting with the \"noserverino\" option to silence this message.\n");
 
 	}
@@ -874,7 +874,7 @@ setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw)
 	while (count && npages < max_pages) {
 		rc = iov_iter_get_pages(iter, pages, count, max_pages, &start);
 		if (rc < 0) {
-			cifs_dbg(VFS, "couldn't get user pages (rc=%zd)\n", rc);
+			cifs_dbg(VFS, "Couldn't get user pages (rc=%zd)\n", rc);
 			break;
 		}
 
@@ -933,7 +933,7 @@ cifs_alloc_hash(const char *name,
 
 	*shash = crypto_alloc_shash(name, 0, 0);
 	if (IS_ERR(*shash)) {
-		cifs_dbg(VFS, "could not allocate crypto %s\n", name);
+		cifs_dbg(VFS, "Could not allocate crypto %s\n", name);
 		rc = PTR_ERR(*shash);
 		*shash = NULL;
 		*sdesc = NULL;
diff --git a/fs/cifs/netmisc.c b/fs/cifs/netmisc.c
index 9b41436..b7ca49 100644
--- a/fs/cifs/netmisc.c
+++ b/fs/cifs/netmisc.c
@@ -957,15 +957,15 @@ struct timespec64 cnvrtDosUnixTm(__le16 le_date, __le16 le_time, int offset)
 	sec = 2 * st->TwoSeconds;
 	min = st->Minutes;
 	if ((sec > 59) || (min > 59))
-		cifs_dbg(VFS, "illegal time min %d sec %lld\n", min, sec);
+		cifs_dbg(VFS, "Invalid time min %d sec %lld\n", min, sec);
 	sec += (min * 60);
 	sec += 60 * 60 * st->Hours;
 	if (st->Hours > 24)
-		cifs_dbg(VFS, "illegal hours %d\n", st->Hours);
+		cifs_dbg(VFS, "Invalid hours %d\n", st->Hours);
 	day = sd->Day;
 	month = sd->Month;
 	if (day < 1 || day > 31 || month < 1 || month > 12) {
-		cifs_dbg(VFS, "illegal date, month %d day: %d\n", month, day);
+		cifs_dbg(VFS, "Invalid date, month %d day: %d\n", month, day);
 		day = clamp(day, 1, 31);
 		month = clamp(month, 1, 12);
 	}
diff --git a/fs/cifs/readdir.c b/fs/cifs/readdir.c
index 50f776a..6df0922 100644
--- a/fs/cifs/readdir.c
+++ b/fs/cifs/readdir.c
@@ -53,7 +53,7 @@ static void dump_cifs_file_struct(struct file *file, char *label)
 			return;
 		}
 		if (cf->invalidHandle)
-			cifs_dbg(FYI, "invalid handle\n");
+			cifs_dbg(FYI, "Invalid handle\n");
 		if (cf->srch_inf.endOfSearch)
 			cifs_dbg(FYI, "end of search\n");
 		if (cf->srch_inf.emptyDir)
@@ -246,7 +246,7 @@ cifs_posix_to_fattr(struct cifs_fattr *fattr, struct smb2_posix_info *info,
 	 */
 	fattr->cf_mode = le32_to_cpu(info->Mode) & ~S_IFMT;
 
-	cifs_dbg(FYI, "posix fattr: dev %d, reparse %d, mode %o",
+	cifs_dbg(FYI, "posix fattr: dev %d, reparse %d, mode %o\n",
 		 le32_to_cpu(info->DeviceId),
 		 le32_to_cpu(info->ReparseTag),
 		 le32_to_cpu(info->Mode));
@@ -478,7 +478,7 @@ static char *nxt_dir_entry(char *old_entry, char *end_of_smb, int level)
 		u32 next_offset = le32_to_cpu(pDirInfo->NextEntryOffset);
 
 		if (old_entry + next_offset < old_entry) {
-			cifs_dbg(VFS, "invalid offset %u\n", next_offset);
+			cifs_dbg(VFS, "Invalid offset %u\n", next_offset);
 			return NULL;
 		}
 		new_entry = old_entry + next_offset;
@@ -515,7 +515,7 @@ static void cifs_fill_dirent_posix(struct cifs_dirent *de,
 
 	/* payload should have already been checked at this point */
 	if (posix_info_parse(info, NULL, &parsed) < 0) {
-		cifs_dbg(VFS, "invalid POSIX info payload");
+		cifs_dbg(VFS, "Invalid POSIX info payload\n");
 		return;
 	}
 
@@ -968,7 +968,7 @@ int cifs_readdir(struct file *file, struct dir_context *ctx)
 	} else if (current_entry != NULL) {
 		cifs_dbg(FYI, "entry %lld found\n", ctx->pos);
 	} else {
-		cifs_dbg(FYI, "could not find entry\n");
+		cifs_dbg(FYI, "Could not find entry\n");
 		goto rddir2_exit;
 	}
 	cifs_dbg(FYI, "loop through %d times filling dir for net buf %p\n",
diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index 43a88e2..3f8b43 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -162,12 +162,14 @@ cifs_ses_add_channel(struct cifs_ses *ses, struct cifs_server_iface *iface)
 	int rc;
 	unsigned int xid = get_xid();
 
-	cifs_dbg(FYI, "adding channel to ses %p (speed:%zu bps rdma:%s ",
-		 ses, iface->speed, iface->rdma_capable ? "yes" : "no");
 	if (iface->sockaddr.ss_family == AF_INET)
-		cifs_dbg(FYI, "ip:%pI4)\n", &ipv4->sin_addr);
+		cifs_dbg(FYI, "adding channel to ses %p (speed:%zu bps rdma:%s ip:%pI4)\n",
+			 ses, iface->speed, iface->rdma_capable ? "yes" : "no",
+			 &ipv4->sin_addr);
 	else
-		cifs_dbg(FYI, "ip:%pI6)\n", &ipv6->sin6_addr);
+		cifs_dbg(FYI, "adding channel to ses %p (speed:%zu bps rdma:%s ip:%pI4)\n",
+			 ses, iface->speed, iface->rdma_capable ? "yes" : "no",
+			 &ipv6->sin6_addr);
 
 	/*
 	 * Setup a smb_vol with mostly the same info as the existing
@@ -569,15 +571,15 @@ int decode_ntlmssp_challenge(char *bcc_ptr, int blob_len,
 	tioffset = le32_to_cpu(pblob->TargetInfoArray.BufferOffset);
 	tilen = le16_to_cpu(pblob->TargetInfoArray.Length);
 	if (tioffset > blob_len || tioffset + tilen > blob_len) {
-		cifs_dbg(VFS, "tioffset + tilen too high %u + %u",
-			tioffset, tilen);
+		cifs_dbg(VFS, "tioffset + tilen too high %u + %u\n",
+			 tioffset, tilen);
 		return -EINVAL;
 	}
 	if (tilen) {
 		ses->auth_key.response = kmemdup(bcc_ptr + tioffset, tilen,
 						 GFP_KERNEL);
 		if (!ses->auth_key.response) {
-			cifs_dbg(VFS, "Challenge target info alloc failure");
+			cifs_dbg(VFS, "Challenge target info alloc failure\n");
 			return -ENOMEM;
 		}
 		ses->auth_key.len = tilen;
@@ -1303,9 +1305,8 @@ sess_auth_kerberos(struct sess_data *sess_data)
 	 * sending us a response in an expected form
 	 */
 	if (msg->version != CIFS_SPNEGO_UPCALL_VERSION) {
-		cifs_dbg(VFS,
-		  "incorrect version of cifs.upcall (expected %d but got %d)",
-			      CIFS_SPNEGO_UPCALL_VERSION, msg->version);
+		cifs_dbg(VFS, "incorrect version of cifs.upcall (expected %d but got %d)\n",
+			 CIFS_SPNEGO_UPCALL_VERSION, msg->version);
 		rc = -EKEYREJECTED;
 		goto out_put_spnego_key;
 	}
@@ -1313,8 +1314,8 @@ sess_auth_kerberos(struct sess_data *sess_data)
 	ses->auth_key.response = kmemdup(msg->data, msg->sesskey_len,
 					 GFP_KERNEL);
 	if (!ses->auth_key.response) {
-		cifs_dbg(VFS, "Kerberos can't allocate (%u bytes) memory",
-				msg->sesskey_len);
+		cifs_dbg(VFS, "Kerberos can't allocate (%u bytes) memory\n",
+			 msg->sesskey_len);
 		rc = -ENOMEM;
 		goto out_put_spnego_key;
 	}
@@ -1657,8 +1658,7 @@ static int select_sec(struct cifs_ses *ses, struct sess_data *sess_data)
 	type = cifs_select_sectype(ses->server, ses->sectype);
 	cifs_dbg(FYI, "sess setup type %d\n", type);
 	if (type == Unspecified) {
-		cifs_dbg(VFS,
-			"Unable to select appropriate authentication method!");
+		cifs_dbg(VFS, "Unable to select appropriate authentication method!\n");
 		return -EINVAL;
 	}
 
diff --git a/fs/cifs/smb1ops.c b/fs/cifs/smb1ops.c
index b130efa..197ed45 100644
--- a/fs/cifs/smb1ops.c
+++ b/fs/cifs/smb1ops.c
@@ -247,7 +247,7 @@ check2ndT2(char *buf)
 	/* check for plausible wct, bcc and t2 data and parm sizes */
 	/* check for parm and data offset going beyond end of smb */
 	if (pSMB->WordCount != 10) { /* coalesce_t2 depends on this */
-		cifs_dbg(FYI, "invalid transact2 word count\n");
+		cifs_dbg(FYI, "Invalid transact2 word count\n");
 		return -EINVAL;
 	}
 
diff --git a/fs/cifs/smb2inode.c b/fs/cifs/smb2inode.c
index a8c301a..0e58398 100644
--- a/fs/cifs/smb2inode.c
+++ b/fs/cifs/smb2inode.c
@@ -336,8 +336,7 @@ smb2_compound_op(const unsigned int xid, struct cifs_tcon *tcon,
 
 	SMB2_open_free(&rqst[0]);
 	if (rc == -EREMCHG) {
-		printk_once(KERN_WARNING "server share %s deleted\n",
-			    tcon->treeName);
+		pr_warn_once("server share %s deleted\n", tcon->treeName);
 		tcon->need_reconnect = true;
 	}
 
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index 497afb..6a39451 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -110,14 +110,14 @@ static __u32 get_neg_ctxt_len(struct smb2_sync_hdr *hdr, __u32 len,
 	/* Make sure that negotiate contexts start after gss security blob */
 	nc_offset = le32_to_cpu(pneg_rsp->NegotiateContextOffset);
 	if (nc_offset < non_ctxlen) {
-		printk_once(KERN_WARNING "invalid negotiate context offset\n");
+		pr_warn_once("Invalid negotiate context offset\n");
 		return 0;
 	}
 	size_of_pad_before_neg_ctxts = nc_offset - non_ctxlen;
 
 	/* Verify that at least minimal negotiate contexts fit within frame */
 	if (len < nc_offset + (neg_count * sizeof(struct smb2_neg_context))) {
-		printk_once(KERN_WARNING "negotiate context goes beyond end\n");
+		pr_warn_once("negotiate context goes beyond end\n");
 		return 0;
 	}
 
@@ -190,14 +190,14 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *srvr)
 		return 1;
 
 	if (shdr->StructureSize != SMB2_HEADER_STRUCTURE_SIZE) {
-		cifs_dbg(VFS, "Illegal structure size %u\n",
+		cifs_dbg(VFS, "Invalid structure size %u\n",
 			 le16_to_cpu(shdr->StructureSize));
 		return 1;
 	}
 
 	command = le16_to_cpu(shdr->Command);
 	if (command >= NUMBER_OF_SMB2_COMMANDS) {
-		cifs_dbg(VFS, "Illegal SMB2 command %d\n", command);
+		cifs_dbg(VFS, "Invalid SMB2 command %d\n", command);
 		return 1;
 	}
 
@@ -205,7 +205,7 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *srvr)
 		if (command != SMB2_OPLOCK_BREAK_HE && (shdr->Status == 0 ||
 		    pdu->StructureSize2 != SMB2_ERROR_STRUCTURE_SIZE2)) {
 			/* error packets have 9 byte structure size */
-			cifs_dbg(VFS, "Illegal response size %u for command %d\n",
+			cifs_dbg(VFS, "Invalid response size %u for command %d\n",
 				 le16_to_cpu(pdu->StructureSize2), command);
 			return 1;
 		} else if (command == SMB2_OPLOCK_BREAK_HE
@@ -213,7 +213,7 @@ smb2_check_message(char *buf, unsigned int len, struct TCP_Server_Info *srvr)
 			   && (le16_to_cpu(pdu->StructureSize2) != 44)
 			   && (le16_to_cpu(pdu->StructureSize2) != 36)) {
 			/* special case for SMB2.1 lease break message */
-			cifs_dbg(VFS, "Illegal response size %d for oplock break\n",
+			cifs_dbg(VFS, "Invalid response size %d for oplock break\n",
 				 le16_to_cpu(pdu->StructureSize2));
 			return 1;
 		}
@@ -864,14 +864,14 @@ smb311_update_preauth_hash(struct cifs_ses *ses, struct kvec *iov, int nvec)
 	d = server->secmech.sdescsha512;
 	rc = crypto_shash_init(&d->shash);
 	if (rc) {
-		cifs_dbg(VFS, "%s: could not init sha512 shash\n", __func__);
+		cifs_dbg(VFS, "%s: Could not init sha512 shash\n", __func__);
 		return rc;
 	}
 
 	rc = crypto_shash_update(&d->shash, ses->preauth_sha_hash,
 				 SMB2_PREAUTH_HASH_SIZE);
 	if (rc) {
-		cifs_dbg(VFS, "%s: could not update sha512 shash\n", __func__);
+		cifs_dbg(VFS, "%s: Could not update sha512 shash\n", __func__);
 		return rc;
 	}
 
@@ -879,7 +879,7 @@ smb311_update_preauth_hash(struct cifs_ses *ses, struct kvec *iov, int nvec)
 		rc = crypto_shash_update(&d->shash,
 					 iov[i].iov_base, iov[i].iov_len);
 		if (rc) {
-			cifs_dbg(VFS, "%s: could not update sha512 shash\n",
+			cifs_dbg(VFS, "%s: Could not update sha512 shash\n",
 				 __func__);
 			return rc;
 		}
@@ -887,7 +887,7 @@ smb311_update_preauth_hash(struct cifs_ses *ses, struct kvec *iov, int nvec)
 
 	rc = crypto_shash_final(&d->shash, ses->preauth_sha_hash);
 	if (rc) {
-		cifs_dbg(VFS, "%s: could not finalize sha512 shash\n",
+		cifs_dbg(VFS, "%s: Could not finalize sha512 shash\n",
 			 __func__);
 		return rc;
 	}
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index b36c46..661419 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -79,7 +79,7 @@ smb2_add_credits(struct TCP_Server_Info *server,
 
 	if (*val > 65000) {
 		*val = 65000; /* Don't get near 64K credits, avoid srv bugs */
-		printk_once(KERN_WARNING "server overflowed SMB3 credits\n");
+		pr_warn_once("server overflowed SMB3 credits\n");
 	}
 	server->in_flight--;
 	if (server->in_flight == 0 && (optype & CIFS_OP_MASK) != CIFS_NEG_OP)
@@ -762,8 +762,8 @@ int open_shroot(unsigned int xid, struct cifs_tcon *tcon,
 	if (rc) {
 		if (rc == -EREMCHG) {
 			tcon->need_reconnect = true;
-			printk_once(KERN_WARNING "server share %s deleted\n",
-				    tcon->treeName);
+			pr_warn_once("server share %s deleted\n",
+				     tcon->treeName);
 		}
 		goto oshr_exit;
 	}
@@ -1584,7 +1584,8 @@ smb2_ioctl_query_info(const unsigned int xid,
 				  qi.input_buffer_length,
 				  qi.output_buffer_length, buffer);
 	} else { /* unknown flags */
-		cifs_tcon_dbg(VFS, "invalid passthru query flags: 0x%x\n", qi.flags);
+		cifs_tcon_dbg(VFS, "Invalid passthru query flags: 0x%x\n",
+			      qi.flags);
 		rc = -EINVAL;
 	}
 
@@ -1714,7 +1715,7 @@ smb2_copychunk_range(const unsigned int xid,
 		if (rc == 0) {
 			if (ret_data_len !=
 					sizeof(struct copychunk_ioctl_rsp)) {
-				cifs_tcon_dbg(VFS, "invalid cchunk response size\n");
+				cifs_tcon_dbg(VFS, "Invalid cchunk response size\n");
 				rc = -EIO;
 				goto cchunk_out;
 			}
@@ -1728,12 +1729,12 @@ smb2_copychunk_range(const unsigned int xid,
 			 */
 			if (le32_to_cpu(retbuf->TotalBytesWritten) >
 			    le32_to_cpu(pcchunk->Length)) {
-				cifs_tcon_dbg(VFS, "invalid copy chunk response\n");
+				cifs_tcon_dbg(VFS, "Invalid copy chunk response\n");
 				rc = -EIO;
 				goto cchunk_out;
 			}
 			if (le32_to_cpu(retbuf->ChunksWritten) != 1) {
-				cifs_tcon_dbg(VFS, "invalid num chunks written\n");
+				cifs_tcon_dbg(VFS, "Invalid num chunks written\n");
 				rc = -EIO;
 				goto cchunk_out;
 			}
@@ -2467,8 +2468,8 @@ smb2_query_info_compound(const unsigned int xid, struct cifs_tcon *tcon,
 		free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
 		if (rc == -EREMCHG) {
 			tcon->need_reconnect = true;
-			printk_once(KERN_WARNING "server share %s deleted\n",
-				    tcon->treeName);
+			pr_warn_once("server share %s deleted\n",
+				     tcon->treeName);
 		}
 		goto qic_exit;
 	}
@@ -2748,15 +2749,15 @@ parse_reparse_point(struct reparse_data_buffer *buf,
 		    struct cifs_sb_info *cifs_sb)
 {
 	if (plen < sizeof(struct reparse_data_buffer)) {
-		cifs_dbg(VFS, "reparse buffer is too small. Must be "
-			 "at least 8 bytes but was %d\n", plen);
+		cifs_dbg(VFS, "reparse buffer is too small. Must be at least 8 bytes but was %d\n",
+			 plen);
 		return -EIO;
 	}
 
 	if (plen < le16_to_cpu(buf->ReparseDataLength) +
 	    sizeof(struct reparse_data_buffer)) {
-		cifs_dbg(VFS, "srv returned invalid reparse buf "
-			 "length: %d\n", plen);
+		cifs_dbg(VFS, "srv returned invalid reparse buf length: %d\n",
+			 plen);
 		return -EIO;
 	}
 
@@ -2771,8 +2772,8 @@ parse_reparse_point(struct reparse_data_buffer *buf,
 			(struct reparse_symlink_data_buffer *)buf,
 			plen, target_path, cifs_sb);
 	default:
-		cifs_dbg(VFS, "srv returned unknown symlink buffer "
-			 "tag:0x%08x\n", le32_to_cpu(buf->ReparseTag));
+		cifs_dbg(VFS, "srv returned unknown symlink buffer tag:0x%08x\n",
+			 le32_to_cpu(buf->ReparseTag));
 		return -EOPNOTSUPP;
 	}
 }
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index b30aa3c..fc3517 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -208,7 +208,7 @@ static int __smb2_reconnect(const struct nls_table *nlsc,
 
 		if (dfs_host_len != tcp_host_len
 		    || strncasecmp(dfs_host, tcp_host, dfs_host_len) != 0) {
-			cifs_dbg(FYI, "%s: skipping %.*s, doesn't match %.*s",
+			cifs_dbg(FYI, "%s: skipping %.*s, doesn't match %.*s\n",
 				 __func__,
 				 (int)dfs_host_len, dfs_host,
 				 (int)tcp_host_len, tcp_host);
@@ -314,8 +314,8 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon)
 						      (server->tcpStatus != CifsNeedReconnect),
 						      10 * HZ);
 		if (rc < 0) {
-			cifs_dbg(FYI, "%s: aborting reconnect due to a received"
-				 " signal by the process\n", __func__);
+			cifs_dbg(FYI, "%s: aborting reconnect due to a received signal by the process\n",
+				 __func__);
 			return -ERESTARTSYS;
 		}
 
@@ -384,7 +384,7 @@ smb2_reconnect(__le16 smb2_command, struct cifs_tcon *tcon)
 	cifs_dbg(FYI, "reconnect tcon rc = %d\n", rc);
 	if (rc) {
 		/* If sess reconnected but tcon didn't, something strange ... */
-		printk_once(KERN_WARNING "reconnect tcon failed rc = %d\n", rc);
+		pr_warn_once("reconnect tcon failed rc = %d\n", rc);
 		goto out;
 	}
 
@@ -626,13 +626,13 @@ static void decode_preauth_context(struct smb2_preauth_neg_context *ctxt)
 
 	/* If invalid preauth context warn but use what we requested, SHA-512 */
 	if (len < MIN_PREAUTH_CTXT_DATA_LEN) {
-		printk_once(KERN_WARNING "server sent bad preauth context\n");
+		pr_warn_once("server sent bad preauth context\n");
 		return;
 	}
 	if (le16_to_cpu(ctxt->HashAlgorithmCount) != 1)
-		printk_once(KERN_WARNING "illegal SMB3 hash algorithm count\n");
+		pr_warn_once("Invalid SMB3 hash algorithm count\n");
 	if (ctxt->HashAlgorithms != SMB2_PREAUTH_INTEGRITY_SHA512)
-		printk_once(KERN_WARNING "unknown SMB3 hash algorithm\n");
+		pr_warn_once("unknown SMB3 hash algorithm\n");
 }
 
 static void decode_compress_ctx(struct TCP_Server_Info *server,
@@ -642,15 +642,15 @@ static void decode_compress_ctx(struct TCP_Server_Info *server,
 
 	/* sizeof compress context is a one element compression capbility struct */
 	if (len < 10) {
-		printk_once(KERN_WARNING "server sent bad compression cntxt\n");
+		pr_warn_once("server sent bad compression cntxt\n");
 		return;
 	}
 	if (le16_to_cpu(ctxt->CompressionAlgorithmCount) != 1) {
-		printk_once(KERN_WARNING "illegal SMB3 compress algorithm count\n");
+		pr_warn_once("Invalid SMB3 compress algorithm count\n");
 		return;
 	}
 	if (le16_to_cpu(ctxt->CompressionAlgorithms[0]) > 3) {
-		printk_once(KERN_WARNING "unknown compression algorithm\n");
+		pr_warn_once("unknown compression algorithm\n");
 		return;
 	}
 	server->compress_algorithm = ctxt->CompressionAlgorithms[0];
@@ -663,18 +663,18 @@ static int decode_encrypt_ctx(struct TCP_Server_Info *server,
 
 	cifs_dbg(FYI, "decode SMB3.11 encryption neg context of len %d\n", len);
 	if (len < MIN_ENCRYPT_CTXT_DATA_LEN) {
-		printk_once(KERN_WARNING "server sent bad crypto ctxt len\n");
+		pr_warn_once("server sent bad crypto ctxt len\n");
 		return -EINVAL;
 	}
 
 	if (le16_to_cpu(ctxt->CipherCount) != 1) {
-		printk_once(KERN_WARNING "illegal SMB3.11 cipher count\n");
+		pr_warn_once("Invalid SMB3.11 cipher count\n");
 		return -EINVAL;
 	}
 	cifs_dbg(FYI, "SMB311 cipher type:%d\n", le16_to_cpu(ctxt->Ciphers[0]));
 	if ((ctxt->Ciphers[0] != SMB2_ENCRYPTION_AES128_CCM) &&
 	    (ctxt->Ciphers[0] != SMB2_ENCRYPTION_AES128_GCM)) {
-		printk_once(KERN_WARNING "invalid SMB3.11 cipher returned\n");
+		pr_warn_once("Invalid SMB3.11 cipher returned\n");
 		return -EINVAL;
 	}
 	server->cipher_type = ctxt->Ciphers[0];
@@ -774,7 +774,7 @@ create_posix_buf(umode_t mode)
 	buf->Name[14] = 0xCD;
 	buf->Name[15] = 0x7C;
 	buf->Mode = cpu_to_le32(mode);
-	cifs_dbg(FYI, "mode on posix create 0%o", mode);
+	cifs_dbg(FYI, "mode on posix create 0%o\n", mode);
 	return buf;
 }
 
@@ -786,7 +786,7 @@ add_posix_context(struct kvec *iov, unsigned int *num_iovec, umode_t mode)
 
 	iov[num].iov_base = create_posix_buf(mode);
 	if (mode == ACL_NO_MODE)
-		cifs_dbg(FYI, "illegal mode\n");
+		cifs_dbg(FYI, "Invalid mode\n");
 	if (iov[num].iov_base == NULL)
 		return -ENOMEM;
 	iov[num].iov_len = sizeof(struct create_posix);
@@ -904,9 +904,7 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
 	 * cifs_stats_inc(&tcon->stats.smb2_stats.smb2_com_fail[SMB2...]);
 	 */
 	if (rc == -EOPNOTSUPP) {
-		cifs_server_dbg(VFS, "Dialect not supported by server. Consider "
-			"specifying vers=1.0 or vers=2.0 on mount for accessing"
-			" older servers\n");
+		cifs_server_dbg(VFS, "Dialect not supported by server. Consider  specifying vers=1.0 or vers=2.0 on mount for accessing older servers\n");
 		goto neg_exit;
 	} else if (rc != 0)
 		goto neg_exit;
@@ -939,8 +937,8 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
 	} else if (le16_to_cpu(rsp->DialectRevision) !=
 				server->vals->protocol_id) {
 		/* if requested single dialect ensure returned dialect matched */
-		cifs_server_dbg(VFS, "Illegal 0x%x dialect returned: not requested\n",
-			le16_to_cpu(rsp->DialectRevision));
+		cifs_server_dbg(VFS, "Invalid 0x%x dialect returned: not requested\n",
+				le16_to_cpu(rsp->DialectRevision));
 		return -EIO;
 	}
 
@@ -957,8 +955,8 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
 	else if (rsp->DialectRevision == cpu_to_le16(SMB311_PROT_ID))
 		cifs_dbg(FYI, "negotiated smb3.1.1 dialect\n");
 	else {
-		cifs_server_dbg(VFS, "Illegal dialect returned by server 0x%x\n",
-			 le16_to_cpu(rsp->DialectRevision));
+		cifs_server_dbg(VFS, "Invalid dialect returned by server 0x%x\n",
+				le16_to_cpu(rsp->DialectRevision));
 		rc = -EIO;
 		goto neg_exit;
 	}
@@ -1116,15 +1114,16 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 		rc = 0;
 		goto out_free_inbuf;
 	} else if (rc != 0) {
-		cifs_tcon_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
+		cifs_tcon_dbg(VFS, "validate protocol negotiate failed: %d\n",
+			      rc);
 		rc = -EIO;
 		goto out_free_inbuf;
 	}
 
 	rc = -EIO;
 	if (rsplen != sizeof(*pneg_rsp)) {
-		cifs_tcon_dbg(VFS, "invalid protocol negotiate response size: %d\n",
-			 rsplen);
+		cifs_tcon_dbg(VFS, "Invalid protocol negotiate response size: %d\n",
+			      rsplen);
 
 		/* relax check since Mac returns max bufsize allowed on ioctl */
 		if (rsplen > CIFSMaxBufSize || rsplen < sizeof(*pneg_rsp))
@@ -1357,9 +1356,8 @@ SMB2_auth_kerberos(struct SMB2_sess_data *sess_data)
 	 * sending us a response in an expected form
 	 */
 	if (msg->version != CIFS_SPNEGO_UPCALL_VERSION) {
-		cifs_dbg(VFS,
-			  "bad cifs.upcall version. Expected %d got %d",
-			  CIFS_SPNEGO_UPCALL_VERSION, msg->version);
+		cifs_dbg(VFS, "bad cifs.upcall version. Expected %d got %d\n",
+			 CIFS_SPNEGO_UPCALL_VERSION, msg->version);
 		rc = -EKEYREJECTED;
 		goto out_put_spnego_key;
 	}
@@ -1369,8 +1367,7 @@ SMB2_auth_kerberos(struct SMB2_sess_data *sess_data)
 		ses->auth_key.response = kmemdup(msg->data, msg->sesskey_len,
 						 GFP_KERNEL);
 		if (!ses->auth_key.response) {
-			cifs_dbg(VFS,
-				 "Kerberos can't allocate (%u bytes) memory",
+			cifs_dbg(VFS, "Kerberos can't allocate (%u bytes) memory\n",
 				 msg->sesskey_len);
 			rc = -ENOMEM;
 			goto out_put_spnego_key;
@@ -1584,8 +1581,7 @@ SMB2_select_sec(struct cifs_ses *ses, struct SMB2_sess_data *sess_data)
 	type = smb2_select_sectype(cifs_ses_server(ses), ses->sectype);
 	cifs_dbg(FYI, "sess setup type %d\n", type);
 	if (type == Unspecified) {
-		cifs_dbg(VFS,
-			"Unable to select appropriate authentication method!");
+		cifs_dbg(VFS, "Unable to select appropriate authentication method!\n");
 		return -EINVAL;
 	}
 
@@ -2812,8 +2808,8 @@ SMB2_open(const unsigned int xid, struct cifs_open_parms *oparms, __le16 *path,
 		trace_smb3_open_err(xid, tcon->tid, ses->Suid,
 				    oparms->create_options, oparms->desired_access, rc);
 		if (rc == -EREMCHG) {
-			printk_once(KERN_WARNING "server share %s deleted\n",
-				    tcon->treeName);
+			pr_warn_once("server share %s deleted\n",
+				     tcon->treeName);
 			tcon->need_reconnect = true;
 		}
 		goto creat_exit;
@@ -3225,7 +3221,7 @@ smb2_validate_iov(unsigned int offset, unsigned int buffer_length,
 	}
 
 	if ((begin_of_buf > end_of_smb) || (end_of_buf > end_of_smb)) {
-		cifs_dbg(VFS, "illegal server response, bad offset to data\n");
+		cifs_dbg(VFS, "Invalid server response, bad offset to data\n");
 		return -EINVAL;
 	}
 
@@ -4108,8 +4104,8 @@ smb2_writev_callback(struct mid_q_entry *mid)
 				     tcon->tid, tcon->ses->Suid, wdata->offset,
 				     wdata->bytes, wdata->result);
 		if (wdata->result == -ENOSPC)
-			printk_once(KERN_WARNING "Out of space writing to %s\n",
-				    tcon->treeName);
+			pr_warn_once("Out of space writing to %s\n",
+				     tcon->treeName);
 	} else
 		trace_smb3_write_done(0 /* no xid */,
 				      wdata->cfile->fid.persistent_fid,
@@ -4632,7 +4628,7 @@ smb2_parse_query_directory(struct cifs_tcon *tcon,
 	else if (resp_buftype == CIFS_SMALL_BUFFER)
 		srch_inf->smallBuf = true;
 	else
-		cifs_tcon_dbg(VFS, "illegal search buffer type\n");
+		cifs_tcon_dbg(VFS, "Invalid search buffer type\n");
 
 	return 0;
 }
diff --git a/fs/cifs/smbdirect.c b/fs/cifs/smbdirect.c
index 1a5834..b029ed3 100644
--- a/fs/cifs/smbdirect.c
+++ b/fs/cifs/smbdirect.c
@@ -294,15 +294,12 @@ static void send_done(struct ib_cq *cq, struct ib_wc *wc)
 
 static void dump_smbd_negotiate_resp(struct smbd_negotiate_resp *resp)
 {
-	log_rdma_event(INFO, "resp message min_version %u max_version %u "
-		"negotiated_version %u credits_requested %u "
-		"credits_granted %u status %u max_readwrite_size %u "
-		"preferred_send_size %u max_receive_size %u "
-		"max_fragmented_size %u\n",
-		resp->min_version, resp->max_version, resp->negotiated_version,
-		resp->credits_requested, resp->credits_granted, resp->status,
-		resp->max_readwrite_size, resp->preferred_send_size,
-		resp->max_receive_size, resp->max_fragmented_size);
+	log_rdma_event(INFO, "resp message min_version %u max_version %u negotiated_version %u credits_requested %u credits_granted %u status %u max_readwrite_size %u preferred_send_size %u max_receive_size %u max_fragmented_size %u\n",
+		       resp->min_version, resp->max_version,
+		       resp->negotiated_version, resp->credits_requested,
+		       resp->credits_granted, resp->status,
+		       resp->max_readwrite_size, resp->preferred_send_size,
+		       resp->max_receive_size, resp->max_fragmented_size);
 }
 
 /*
@@ -450,10 +447,9 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 	struct smbd_connection *info = response->info;
 	int data_length = 0;
 
-	log_rdma_recv(INFO, "response=%p type=%d wc status=%d wc opcode %d "
-		      "byte_len=%d pkey_index=%x\n",
-		response, response->type, wc->status, wc->opcode,
-		wc->byte_len, wc->pkey_index);
+	log_rdma_recv(INFO, "response=%p type=%d wc status=%d wc opcode %d byte_len=%d pkey_index=%x\n",
+		      response, response->type, wc->status, wc->opcode,
+		      wc->byte_len, wc->pkey_index);
 
 	if (wc->status != IB_WC_SUCCESS || wc->opcode != IB_WC_RECV) {
 		log_rdma_recv(INFO, "wc->status=%d opcode=%d\n",
@@ -519,12 +515,11 @@ static void recv_done(struct ib_cq *cq, struct ib_wc *wc)
 			wake_up_interruptible(&info->wait_send_queue);
 		}
 
-		log_incoming(INFO, "data flags %d data_offset %d "
-			"data_length %d remaining_data_length %d\n",
-			le16_to_cpu(data_transfer->flags),
-			le32_to_cpu(data_transfer->data_offset),
-			le32_to_cpu(data_transfer->data_length),
-			le32_to_cpu(data_transfer->remaining_data_length));
+		log_incoming(INFO, "data flags %d data_offset %d data_length %d remaining_data_length %d\n",
+			     le16_to_cpu(data_transfer->flags),
+			     le32_to_cpu(data_transfer->data_offset),
+			     le32_to_cpu(data_transfer->data_length),
+			     le32_to_cpu(data_transfer->remaining_data_length));
 
 		/* Send a KEEP_ALIVE response right away if requested */
 		info->keep_alive_requested = KEEP_ALIVE_NONE;
@@ -632,14 +627,10 @@ static int smbd_ia_open(
 	}
 
 	if (!frwr_is_supported(&info->id->device->attrs)) {
-		log_rdma_event(ERR,
-			"Fast Registration Work Requests "
-			"(FRWR) is not supported\n");
-		log_rdma_event(ERR,
-			"Device capability flags = %llx "
-			"max_fast_reg_page_list_len = %u\n",
-			info->id->device->attrs.device_cap_flags,
-			info->id->device->attrs.max_fast_reg_page_list_len);
+		log_rdma_event(ERR, "Fast Registration Work Requests (FRWR) is not supported\n");
+		log_rdma_event(ERR, "Device capability flags = %llx max_fast_reg_page_list_len = %u\n",
+			       info->id->device->attrs.device_cap_flags,
+			       info->id->device->attrs.max_fast_reg_page_list_len);
 		rc = -EPROTONOSUPPORT;
 		goto out2;
 	}
@@ -898,13 +889,12 @@ static int smbd_post_send_sgl(struct smbd_connection *info,
 	packet->remaining_data_length = cpu_to_le32(remaining_data_length);
 	packet->padding = 0;
 
-	log_outgoing(INFO, "credits_requested=%d credits_granted=%d "
-		"data_offset=%d data_length=%d remaining_data_length=%d\n",
-		le16_to_cpu(packet->credits_requested),
-		le16_to_cpu(packet->credits_granted),
-		le32_to_cpu(packet->data_offset),
-		le32_to_cpu(packet->data_length),
-		le32_to_cpu(packet->remaining_data_length));
+	log_outgoing(INFO, "credits_requested=%d credits_granted=%d data_offset=%d data_length=%d remaining_data_length=%d\n",
+		     le16_to_cpu(packet->credits_requested),
+		     le16_to_cpu(packet->credits_granted),
+		     le32_to_cpu(packet->data_offset),
+		     le32_to_cpu(packet->data_length),
+		     le32_to_cpu(packet->remaining_data_length));
 
 	/* Map the packet to DMA */
 	header_length = sizeof(struct smbd_data_transfer);
@@ -1078,11 +1068,9 @@ static int smbd_negotiate(struct smbd_connection *info)
 
 	response->type = SMBD_NEGOTIATE_RESP;
 	rc = smbd_post_recv(info, response);
-	log_rdma_event(INFO,
-		"smbd_post_recv rc=%d iov.addr=%llx iov.length=%x "
-		"iov.lkey=%x\n",
-		rc, response->sge.addr,
-		response->sge.length, response->sge.lkey);
+	log_rdma_event(INFO, "smbd_post_recv rc=%d iov.addr=%llx iov.length=%x iov.lkey=%x\n",
+		       rc, response->sge.addr,
+		       response->sge.length, response->sge.lkey);
 	if (rc)
 		return rc;
 
@@ -1540,25 +1528,19 @@ static struct smbd_connection *_smbd_get_connection(
 
 	if (smbd_send_credit_target > info->id->device->attrs.max_cqe ||
 	    smbd_send_credit_target > info->id->device->attrs.max_qp_wr) {
-		log_rdma_event(ERR,
-			"consider lowering send_credit_target = %d. "
-			"Possible CQE overrun, device "
-			"reporting max_cpe %d max_qp_wr %d\n",
-			smbd_send_credit_target,
-			info->id->device->attrs.max_cqe,
-			info->id->device->attrs.max_qp_wr);
+		log_rdma_event(ERR, "consider lowering send_credit_target = %d. Possible CQE overrun, device reporting max_cpe %d max_qp_wr %d\n",
+			       smbd_send_credit_target,
+			       info->id->device->attrs.max_cqe,
+			       info->id->device->attrs.max_qp_wr);
 		goto config_failed;
 	}
 
 	if (smbd_receive_credit_max > info->id->device->attrs.max_cqe ||
 	    smbd_receive_credit_max > info->id->device->attrs.max_qp_wr) {
-		log_rdma_event(ERR,
-			"consider lowering receive_credit_max = %d. "
-			"Possible CQE overrun, device "
-			"reporting max_cpe %d max_qp_wr %d\n",
-			smbd_receive_credit_max,
-			info->id->device->attrs.max_cqe,
-			info->id->device->attrs.max_qp_wr);
+		log_rdma_event(ERR, "consider lowering receive_credit_max = %d. Possible CQE overrun, device reporting max_cpe %d max_qp_wr %d\n",
+			       smbd_receive_credit_max,
+			       info->id->device->attrs.max_cqe,
+			       info->id->device->attrs.max_qp_wr);
 		goto config_failed;
 	}
 
@@ -1865,11 +1847,9 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
 			to_read -= to_copy;
 			data_read += to_copy;
 
-			log_read(INFO, "_get_first_reassembly memcpy %d bytes "
-				"data_transfer_length-offset=%d after that "
-				"to_read=%d data_read=%d offset=%d\n",
-				to_copy, data_length - offset,
-				to_read, data_read, offset);
+			log_read(INFO, "_get_first_reassembly memcpy %d bytes data_transfer_length-offset=%d after that to_read=%d data_read=%d offset=%d\n",
+				 to_copy, data_length - offset,
+				 to_read, data_read, offset);
 		}
 
 		spin_lock_irq(&info->reassembly_queue_lock);
@@ -1878,10 +1858,9 @@ static int smbd_recv_buf(struct smbd_connection *info, char *buf,
 		spin_unlock_irq(&info->reassembly_queue_lock);
 
 		info->first_entry_offset = offset;
-		log_read(INFO, "returning to thread data_read=%d "
-			"reassembly_data_length=%d first_entry_offset=%d\n",
-			data_read, info->reassembly_data_length,
-			info->first_entry_offset);
+		log_read(INFO, "returning to thread data_read=%d reassembly_data_length=%d first_entry_offset=%d\n",
+			 data_read, info->reassembly_data_length,
+			 info->first_entry_offset);
 read_rfc1002_done:
 		return data_read;
 	}
@@ -1952,7 +1931,7 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 
 	if (iov_iter_rw(&msg->msg_iter) == WRITE) {
 		/* It's a bug in upper layer to get there */
-		cifs_dbg(VFS, "CIFS: invalid msg iter dir %u\n",
+		cifs_dbg(VFS, "Invalid msg iter dir %u\n",
 			 iov_iter_rw(&msg->msg_iter));
 		rc = -EINVAL;
 		goto out;
@@ -1974,7 +1953,7 @@ int smbd_recv(struct smbd_connection *info, struct msghdr *msg)
 
 	default:
 		/* It's a bug in upper layer to get there */
-		cifs_dbg(VFS, "CIFS: invalid msg type %d\n",
+		cifs_dbg(VFS, "Invalid msg type %d\n",
 			 iov_iter_type(&msg->msg_iter));
 		rc = -EINVAL;
 	}
@@ -2043,10 +2022,9 @@ int smbd_send(struct TCP_Server_Info *server,
 		dump_smb(iov[i].iov_base, iov[i].iov_len);
 
 
-	log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d "
-		"rq_tailsz=%d buflen=%lu\n",
-		rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
-		rqst->rq_tailsz, smb_rqst_len(server, rqst));
+	log_write(INFO, "rqst_idx=%d nvec=%d rqst->rq_npages=%d rq_pagesz=%d rq_tailsz=%d buflen=%lu\n",
+		  rqst_idx, rqst->rq_nvec, rqst->rq_npages, rqst->rq_pagesz,
+		  rqst->rq_tailsz, smb_rqst_len(server, rqst));
 
 	start = i = 0;
 	buflen = 0;
@@ -2056,11 +2034,9 @@ int smbd_send(struct TCP_Server_Info *server,
 			if (i > start) {
 				remaining_data_length -=
 					(buflen-iov[i].iov_len);
-				log_write(INFO, "sending iov[] from start=%d "
-					"i=%d nvecs=%d "
-					"remaining_data_length=%d\n",
-					start, i, i-start,
-					remaining_data_length);
+				log_write(INFO, "sending iov[] from start=%d i=%d nvecs=%d remaining_data_length=%d\n",
+					  start, i, i - start,
+					  remaining_data_length);
 				rc = smbd_post_send_data(
 					info, &iov[start], i-start,
 					remaining_data_length);
@@ -2069,10 +2045,9 @@ int smbd_send(struct TCP_Server_Info *server,
 			} else {
 				/* iov[start] is too big, break it */
 				nvecs = (buflen+max_iov_size-1)/max_iov_size;
-				log_write(INFO, "iov[%d] iov_base=%p buflen=%d"
-					" break to %d vectors\n",
-					start, iov[start].iov_base,
-					buflen, nvecs);
+				log_write(INFO, "iov[%d] iov_base=%p buflen=%d break to %d vectors\n",
+					  start, iov[start].iov_base,
+					  buflen, nvecs);
 				for (j = 0; j < nvecs; j++) {
 					vec.iov_base =
 						(char *)iov[start].iov_base +
@@ -2084,11 +2059,9 @@ int smbd_send(struct TCP_Server_Info *server,
 							max_iov_size*(nvecs-1);
 					remaining_data_length -= vec.iov_len;
 					log_write(INFO,
-						"sending vec j=%d iov_base=%p"
-						" iov_len=%zu "
-						"remaining_data_length=%d\n",
-						j, vec.iov_base, vec.iov_len,
-						remaining_data_length);
+						"sending vec j=%d iov_base=%p iov_len=%zu remaining_data_length=%d\n",
+						  j, vec.iov_base, vec.iov_len,
+						  remaining_data_length);
 					rc = smbd_post_send_data(
 						info, &vec, 1,
 						remaining_data_length);
@@ -2106,11 +2079,9 @@ int smbd_send(struct TCP_Server_Info *server,
 			if (i == rqst->rq_nvec) {
 				/* send out all remaining vecs */
 				remaining_data_length -= buflen;
-				log_write(INFO,
-					"sending iov[] from start=%d i=%d "
-					"nvecs=%d remaining_data_length=%d\n",
-					start, i, i-start,
-					remaining_data_length);
+				log_write(INFO, "sending iov[] from start=%d i=%d nvecs=%d remaining_data_length=%d\n",
+					  start, i, i - start,
+					  remaining_data_length);
 				rc = smbd_post_send_data(info, &iov[start],
 					i-start, remaining_data_length);
 				if (rc)
@@ -2134,10 +2105,9 @@ int smbd_send(struct TCP_Server_Info *server,
 			if (j == nvecs-1)
 				size = buflen - j*max_iov_size;
 			remaining_data_length -= size;
-			log_write(INFO, "sending pages i=%d offset=%d size=%d"
-				" remaining_data_length=%d\n",
-				i, j*max_iov_size+offset, size,
-				remaining_data_length);
+			log_write(INFO, "sending pages i=%d offset=%d size=%d remaining_data_length=%d\n",
+				  i, j * max_iov_size + offset, size,
+				  remaining_data_length);
 			rc = smbd_post_send_page(
 				info, rqst->rq_pages[i],
 				j*max_iov_size + offset,
@@ -2211,11 +2181,9 @@ static void smbd_mr_recovery_work(struct work_struct *work)
 				info->pd, info->mr_type,
 				info->max_frmr_depth);
 			if (IS_ERR(smbdirect_mr->mr)) {
-				log_rdma_mr(ERR,
-					"ib_alloc_mr failed mr_type=%x "
-					"max_frmr_depth=%x\n",
-					info->mr_type,
-					info->max_frmr_depth);
+				log_rdma_mr(ERR, "ib_alloc_mr failed mr_type=%x max_frmr_depth=%x\n",
+					    info->mr_type,
+					    info->max_frmr_depth);
 				smbd_disconnect_rdma_connection(info);
 				continue;
 			}
@@ -2278,9 +2246,8 @@ static int allocate_mr_list(struct smbd_connection *info)
 		smbdirect_mr->mr = ib_alloc_mr(info->pd, info->mr_type,
 					info->max_frmr_depth);
 		if (IS_ERR(smbdirect_mr->mr)) {
-			log_rdma_mr(ERR, "ib_alloc_mr failed mr_type=%x "
-				"max_frmr_depth=%x\n",
-				info->mr_type, info->max_frmr_depth);
+			log_rdma_mr(ERR, "ib_alloc_mr failed mr_type=%x max_frmr_depth=%x\n",
+				    info->mr_type, info->max_frmr_depth);
 			goto out;
 		}
 		smbdirect_mr->sgl = kcalloc(
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index c97570..c359221 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -112,7 +112,7 @@ static void _cifs_mid_q_entry_release(struct kref *refcount)
 #ifdef CONFIG_CIFS_STATS2
 	now = jiffies;
 	if (now < midEntry->when_alloc)
-		cifs_server_dbg(VFS, "invalid mid allocation time\n");
+		cifs_server_dbg(VFS, "Invalid mid allocation time\n");
 	roundtrip_time = now - midEntry->when_alloc;
 
 	if (smb_cmd < NUMBER_OF_SMB2_COMMANDS) {
@@ -151,12 +151,12 @@ static void _cifs_mid_q_entry_release(struct kref *refcount)
 		trace_smb3_slow_rsp(smb_cmd, midEntry->mid, midEntry->pid,
 			       midEntry->when_sent, midEntry->when_received);
 		if (cifsFYI & CIFS_TIMER) {
-			pr_debug(" CIFS slow rsp: cmd %d mid %llu",
-			       midEntry->command, midEntry->mid);
-			cifs_info(" A: 0x%lx S: 0x%lx R: 0x%lx\n",
-			       now - midEntry->when_alloc,
-			       now - midEntry->when_sent,
-			       now - midEntry->when_received);
+			pr_debug("slow rsp: cmd %d mid %llu",
+				 midEntry->command, midEntry->mid);
+			cifs_info("A: 0x%lx S: 0x%lx R: 0x%lx\n",
+				  now - midEntry->when_alloc,
+				  now - midEntry->when_sent,
+				  now - midEntry->when_received);
 		}
 	}
 #endif
@@ -477,8 +477,7 @@ smb_send_rqst(struct TCP_Server_Info *server, int num_rqst,
 		return -ENOMEM;
 
 	if (!server->ops->init_transform_rq) {
-		cifs_server_dbg(VFS, "Encryption requested but transform "
-				"callback is missing\n");
+		cifs_server_dbg(VFS, "Encryption requested but transform callback is missing\n");
 		return -EIO;
 	}
 
@@ -1300,8 +1299,8 @@ SendReceive(const unsigned int xid, struct cifs_ses *ses,
 	   use ses->maxReq */
 
 	if (len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4) {
-		cifs_server_dbg(VFS, "Illegal length, greater than maximum frame, %d\n",
-			 len);
+		cifs_server_dbg(VFS, "Invalid length, greater than maximum frame, %d\n",
+				len);
 		return -EIO;
 	}
 
@@ -1441,8 +1440,8 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 	   use ses->maxReq */
 
 	if (len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4) {
-		cifs_tcon_dbg(VFS, "Illegal length, greater than maximum frame, %d\n",
-			 len);
+		cifs_tcon_dbg(VFS, "Invalid length, greater than maximum frame, %d\n",
+			      len);
 		return -EIO;
 	}
 
-- 
2.26.0

