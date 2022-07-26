Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8B307580799
	for <lists+linux-cifs@lfdr.de>; Tue, 26 Jul 2022 00:39:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237374AbiGYWjs (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 25 Jul 2022 18:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237069AbiGYWix (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 25 Jul 2022 18:38:53 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBEF825E9B
        for <linux-cifs@vger.kernel.org>; Mon, 25 Jul 2022 15:37:48 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 6DB6D33723;
        Mon, 25 Jul 2022 22:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1658788659; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DP4QZkOhtU8XxHwvbh9ePKo7uaBAAce3lxZP2/pRT2A=;
        b=1qX1enfV72bEzHXWWAXXv+LH+McVPKs+7eNPMkEh3gVZCGf2KIkHUkcXW+bs0F5n4pe/aF
        yCy/p4m2PqUf7jo0TbMKmRb9HH6WkREaBKmHvmSXrokuqixrj98vs/3VilZVQ0cFRwdeRy
        7Mf4PE+4EifZyzv9iUgIBp/l7jcjaQ8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1658788659;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DP4QZkOhtU8XxHwvbh9ePKo7uaBAAce3lxZP2/pRT2A=;
        b=7Mv343Wp5xR9iAz1/Sf5H8gDh8p3ZbtxS8f+sL3at+9WLXAyZ+30/qSn+TEyX3gHguwA+j
        v+dywfvqQv2QGLAw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id DD47F13ABB;
        Mon, 25 Jul 2022 22:37:38 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id 72bFJjIb32ISRwAAMHmgww
        (envelope-from <ematsumiya@suse.de>); Mon, 25 Jul 2022 22:37:38 +0000
From:   Enzo Matsumiya <ematsumiya@suse.de>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, pc@cjr.nz, ronniesahlberg@gmail.com,
        nspmangalore@gmail.com
Subject: [RFC PATCH v2 07/10] cifs: rename cifsFYI to debug_level
Date:   Mon, 25 Jul 2022 19:37:04 -0300
Message-Id: <20220725223707.14477-8-ematsumiya@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220725223707.14477-1-ematsumiya@suse.de>
References: <20220725223707.14477-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Rename "cifsFYI" to "debug_level" to add more meaning to it.

Signed-off-by: Enzo Matsumiya <ematsumiya@suse.de>
---
 fs/cifs/Kconfig        |  2 +-
 fs/cifs/cifs_debug.c   | 26 +++++++++++++-------------
 fs/cifs/cifs_debug.h   | 19 +++++++++----------
 fs/cifs/cifs_spnego.c  |  2 +-
 fs/cifs/cifsfs.c       |  4 ++--
 fs/cifs/netmisc.c      |  2 +-
 fs/cifs/smb2maperror.c |  2 +-
 fs/cifs/smb2misc.c     |  2 +-
 fs/cifs/transport.c    |  2 +-
 9 files changed, 30 insertions(+), 31 deletions(-)

diff --git a/fs/cifs/Kconfig b/fs/cifs/Kconfig
index 3b7e3b9e4fd2..5b3a6dbc6eda 100644
--- a/fs/cifs/Kconfig
+++ b/fs/cifs/Kconfig
@@ -61,7 +61,7 @@ config CIFS_STATS2
 	  Enabling this option will allow more detailed statistics on SMB
 	  request timing to be displayed in /proc/fs/cifs/DebugData and also
 	  allow optional logging of slow responses to dmesg (depending on the
-	  value of /proc/fs/cifs/cifsFYI). See Documentation/admin-guide/cifs/usage.rst
+	  value of /proc/fs/cifs/debug_level). See Documentation/admin-guide/cifs/usage.rst
 	  for more details. These additional statistics may have a minor effect
 	  on performance and memory utilization.
 
diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
index c88bea9d3ac3..0c08166f8f30 100644
--- a/fs/cifs/cifs_debug.c
+++ b/fs/cifs/cifs_debug.c
@@ -670,7 +670,7 @@ PROC_FILE_DEFINE(smbd_receive_credit_max);
 #endif
 
 static struct proc_dir_entry *proc_fs_cifs;
-static const struct proc_ops cifsFYI_proc_ops;
+static const struct proc_ops debug_level_proc_ops;
 static const struct proc_ops cifs_lookup_cache_proc_ops;
 static const struct proc_ops traceSMB_proc_ops;
 static const struct proc_ops cifs_security_flags_proc_ops;
@@ -691,7 +691,7 @@ cifs_proc_init(void)
 			cifs_debug_files_proc_show);
 
 	proc_create("Stats", 0644, proc_fs_cifs, &cifs_stats_proc_ops);
-	proc_create("cifsFYI", 0644, proc_fs_cifs, &cifsFYI_proc_ops);
+	proc_create("debug_level", 0644, proc_fs_cifs, &debug_level_proc_ops);
 	proc_create("traceSMB", 0644, proc_fs_cifs, &traceSMB_proc_ops);
 	proc_create("LinuxExtensionsEnabled", 0644, proc_fs_cifs,
 		    &cifs_linux_ext_proc_ops);
@@ -734,7 +734,7 @@ cifs_proc_clean(void)
 
 	remove_proc_entry("DebugData", proc_fs_cifs);
 	remove_proc_entry("open_files", proc_fs_cifs);
-	remove_proc_entry("cifsFYI", proc_fs_cifs);
+	remove_proc_entry("debug_level", proc_fs_cifs);
 	remove_proc_entry("traceSMB", proc_fs_cifs);
 	remove_proc_entry("Stats", proc_fs_cifs);
 	remove_proc_entry("SecurityFlags", proc_fs_cifs);
@@ -758,18 +758,18 @@ cifs_proc_clean(void)
 	remove_proc_entry("fs/cifs", NULL);
 }
 
-static int cifsFYI_proc_show(struct seq_file *m, void *v)
+static int debug_level_proc_show(struct seq_file *m, void *v)
 {
-	seq_printf(m, "%d\n", cifsFYI);
+	seq_printf(m, "%d\n", debug_level);
 	return 0;
 }
 
-static int cifsFYI_proc_open(struct inode *inode, struct file *file)
+static int debug_level_proc_open(struct inode *inode, struct file *file)
 {
-	return single_open(file, cifsFYI_proc_show, NULL);
+	return single_open(file, debug_level_proc_show, NULL);
 }
 
-static ssize_t cifsFYI_proc_write(struct file *file, const char __user *buffer,
+static ssize_t debug_level_proc_write(struct file *file, const char __user *buffer,
 		size_t count, loff_t *ppos)
 {
 	char c[2] = { '\0' };
@@ -780,21 +780,21 @@ static ssize_t cifsFYI_proc_write(struct file *file, const char __user *buffer,
 	if (rc)
 		return rc;
 	if (strtobool(c, &bv) == 0)
-		cifsFYI = bv;
+		debug_level = bv;
 	else if ((c[0] > '1') && (c[0] <= '9'))
-		cifsFYI = (int) (c[0] - '0'); /* see cifs_debug.h for meanings */
+		debug_level = (int) (c[0] - '0'); /* see cifs_debug.h for meanings */
 	else
 		return -EINVAL;
 
 	return count;
 }
 
-static const struct proc_ops cifsFYI_proc_ops = {
-	.proc_open	= cifsFYI_proc_open,
+static const struct proc_ops debug_level_proc_ops = {
+	.proc_open	= debug_level_proc_open,
 	.proc_read	= seq_read,
 	.proc_lseek	= seq_lseek,
 	.proc_release	= single_release,
-	.proc_write	= cifsFYI_proc_write,
+	.proc_write	= debug_level_proc_write,
 };
 
 static int cifs_linux_ext_proc_show(struct seq_file *m, void *v)
diff --git a/fs/cifs/cifs_debug.h b/fs/cifs/cifs_debug.h
index 2ac0e384fd12..3e5f9a68c62d 100644
--- a/fs/cifs/cifs_debug.h
+++ b/fs/cifs/cifs_debug.h
@@ -5,13 +5,10 @@
  *   Modified by Steve French (sfrench@us.ibm.com)
  */
 
-#ifndef _H_CIFS_DEBUG
-#define _H_CIFS_DEBUG
+#ifndef _CIFS_DEBUG_H
+#define _CIFS_DEBUG_H
 
-#ifdef pr_fmt
 #undef pr_fmt
-#endif
-
 #define pr_fmt(fmt) "CIFS: " fmt
 
 void cifs_dump_mem(char *, void *, int );
@@ -19,13 +16,15 @@ void cifs_dump_detail(void *, struct cifs_server_info *);
 void cifs_dump_mids(struct cifs_server_info *);
 extern bool traceSMB;		/* flag which enables the function below */
 void dump_smb(void *, int);
+
 #define CIFS_INFO	0x01
 #define CIFS_RC		0x02
 #define CIFS_TIMER	0x04
 
 #define VFS 1
 #define FYI 2
-extern int cifsFYI;
+extern int debug_level;
+
 #ifdef CONFIG_CIFS_DEBUG2
 #define NOISY 4
 #else
@@ -61,7 +60,7 @@ extern int cifsFYI;
 /* information message: e.g., configuration, major event */
 #define cifs_dbg_func(ratefunc, type, fmt, ...)				\
 do {									\
-	if ((type) & FYI && cifsFYI & CIFS_INFO) {			\
+	if ((type) & FYI && debug_level & CIFS_INFO) {			\
 		pr_debug_ ## ratefunc("%s: " fmt,			\
 				      __FILE__, ##__VA_ARGS__);		\
 	} else if ((type) & VFS) {					\
@@ -84,7 +83,7 @@ do {									\
 	const char *sn = "";						\
 	if (server && server->hostname)					\
 		sn = server->hostname;					\
-	if ((type) & FYI && cifsFYI & CIFS_INFO) {			\
+	if ((type) & FYI && debug_level & CIFS_INFO) {			\
 		pr_debug_ ## ratefunc("%s: \\\\%s " fmt,		\
 				      __FILE__, sn, ##__VA_ARGS__);	\
 	} else if ((type) & VFS) {					\
@@ -110,7 +109,7 @@ do {									\
 	const char *tn = "";						\
 	if (tcon && tcon->treeName)					\
 		tn = tcon->treeName;					\
-	if ((type) & FYI && cifsFYI & CIFS_INFO) {			\
+	if ((type) & FYI && debug_level & CIFS_INFO) {			\
 		pr_debug_ ## ratefunc("%s: %s "	fmt,			\
 				      __FILE__, tn, ##__VA_ARGS__);	\
 	} else if ((type) & VFS) {					\
@@ -157,4 +156,4 @@ do {									\
 	pr_info(fmt, ##__VA_ARGS__)
 #endif
 
-#endif				/* _H_CIFS_DEBUG */
+#endif /* _CIFS_DEBUG_H */
diff --git a/fs/cifs/cifs_spnego.c b/fs/cifs/cifs_spnego.c
index 60f551deb443..46a50aceb23d 100644
--- a/fs/cifs/cifs_spnego.c
+++ b/fs/cifs/cifs_spnego.c
@@ -162,7 +162,7 @@ cifs_get_spnego_key(struct cifs_ses *sesInfo,
 	revert_creds(saved_cred);
 
 #ifdef CONFIG_CIFS_DEBUG2
-	if (cifsFYI && !IS_ERR(spnego_key)) {
+	if (debug_level && !IS_ERR(spnego_key)) {
 		struct cifs_spnego_msg *msg = spnego_key->payload.data[0];
 		cifs_dump_mem("SPNEGO reply blob:", msg->data, min(1024U,
 				msg->secblob_len + msg->sesskey_len));
diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index 59e2966b3594..8017198c4a35 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -56,7 +56,7 @@
 #define SMB_DATE_MIN (0<<9 | 1<<5 | 1)
 #define SMB_TIME_MAX (23<<11 | 59<<5 | 29)
 
-int cifsFYI = 0;
+int debug_level = 0;
 bool traceSMB;
 bool enable_oplocks = true;
 bool linuxExtEnabled = true;
@@ -856,7 +856,7 @@ cifs_smb3_do_mount(struct file_system_type *fs_type,
 	 * Prints in Kernel / CIFS log the attempted mount operation
 	 *	If CIFS_DEBUG && cifs_FYI
 	 */
-	if (cifsFYI)
+	if (debug_level)
 		cifs_dbg(FYI, "Devname: %s flags: %d\n", old_ctx->UNC, flags);
 	else
 		cifs_info("Attempting to mount %s\n", old_ctx->UNC);
diff --git a/fs/cifs/netmisc.c b/fs/cifs/netmisc.c
index 0efd58db351e..33beaf148223 100644
--- a/fs/cifs/netmisc.c
+++ b/fs/cifs/netmisc.c
@@ -827,7 +827,7 @@ map_smb_to_linux_error(char *buf, bool logErr)
 		__u32 err = le32_to_cpu(smb->Status.CifsError);
 		if (logErr && (err != (NT_STATUS_MORE_PROCESSING_REQUIRED)))
 			cifs_print_status(err);
-		else if (cifsFYI & CIFS_RC)
+		else if (debug_level & CIFS_RC)
 			cifs_print_status(err);
 		ntstatus_to_dos(err, &smberrclass, &smberrcode);
 	} else {
diff --git a/fs/cifs/smb2maperror.c b/fs/cifs/smb2maperror.c
index 194799ddd382..1b0eae9c367b 100644
--- a/fs/cifs/smb2maperror.c
+++ b/fs/cifs/smb2maperror.c
@@ -2456,7 +2456,7 @@ map_smb2_to_linux_error(char *buf, bool log_err)
 	if (log_err && (smb2err != STATUS_MORE_PROCESSING_REQUIRED) &&
 	    (smb2err != STATUS_END_OF_FILE))
 		smb2_print_status(smb2err);
-	else if (cifsFYI & CIFS_RC)
+	else if (debug_level & CIFS_RC)
 		smb2_print_status(smb2err);
 
 	for (i = 0; i < sizeof(smb2_error_map_table) /
diff --git a/fs/cifs/smb2misc.c b/fs/cifs/smb2misc.c
index dbaee6343fdc..587362124842 100644
--- a/fs/cifs/smb2misc.c
+++ b/fs/cifs/smb2misc.c
@@ -260,7 +260,7 @@ smb2_check_message(char *buf, unsigned int len, struct cifs_server_info *server)
 			return 0;
 
 		/* Only log a message if len was really miscalculated */
-		if (unlikely(cifsFYI))
+		if (unlikely(debug_level))
 			cifs_dbg(FYI, "Server response too short: calculated "
 				 "length %u doesn't match read length %u (cmd=%d, mid=%llu)\n",
 				 calc_len, len, command, mid);
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index 81022ef20d62..98a40615c871 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -137,7 +137,7 @@ static void _cifs_mid_q_entry_release(struct kref *refcount)
 
 		trace_smb3_slow_rsp(smb_cmd, midEntry->mid, midEntry->pid,
 			       midEntry->when_sent, midEntry->when_received);
-		if (cifsFYI & CIFS_TIMER) {
+		if (debug_level & CIFS_TIMER) {
 			pr_debug("slow rsp: cmd %d mid %llu",
 				 midEntry->command, midEntry->mid);
 			cifs_info("A: 0x%lx S: 0x%lx R: 0x%lx\n",
-- 
2.35.3

