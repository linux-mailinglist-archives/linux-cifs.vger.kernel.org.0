Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE37A7849
	for <lists+linux-cifs@lfdr.de>; Wed,  4 Sep 2019 04:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727222AbfIDCBa (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 3 Sep 2019 22:01:30 -0400
Received: from mx1.redhat.com ([209.132.183.28]:58938 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726441AbfIDCBa (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 3 Sep 2019 22:01:30 -0400
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id C136281DE1;
        Wed,  4 Sep 2019 02:01:28 +0000 (UTC)
Received: from test1135.test.redhat.com (vpn2-54-71.bne.redhat.com [10.64.54.71])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 79861600C1;
        Wed,  4 Sep 2019 02:01:27 +0000 (UTC)
From:   Ronnie Sahlberg <lsahlber@redhat.com>
To:     linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: [PATCH] cifs: add a debug macto that prints \\server\share for errors
Date:   Wed,  4 Sep 2019 12:01:21 +1000
Message-Id: <20190904020121.24698-1-lsahlber@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Wed, 04 Sep 2019 02:01:28 +0000 (UTC)
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Where we have a tcon available we can log \\server\share as part
of the message. Only do this for the VFS log level.

Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
---
 fs/cifs/cifs_debug.h | 50 +++++++++++++++++++++++++++++++++++++++++-------
 fs/cifs/smb2ops.c    | 54 ++++++++++++++++++++++++++--------------------------
 fs/cifs/smb2pdu.c    | 28 +++++++++++++--------------
 fs/cifs/transport.c  |  4 ++--
 4 files changed, 86 insertions(+), 50 deletions(-)

diff --git a/fs/cifs/cifs_debug.h b/fs/cifs/cifs_debug.h
index 567af916f103..5deb3070d4e7 100644
--- a/fs/cifs/cifs_debug.h
+++ b/fs/cifs/cifs_debug.h
@@ -82,15 +82,18 @@ do {							\
 
 #define cifs_server_dbg_func(ratefunc, type, fmt, ...)		\
 do {								\
+	const char *sn = "";					\
+	if (server && server->hostname)				\
+		sn = server->hostname;				\
 	if ((type) & FYI && cifsFYI & CIFS_INFO) {		\
-		pr_debug_ ## ratefunc("%s: Server:%s "	fmt,	\
-			__FILE__, server->hostname, ##__VA_ARGS__);\
+		pr_debug_ ## ratefunc("%s: \\\\%s "	fmt,	\
+			__FILE__, sn, ##__VA_ARGS__);		\
 	} else if ((type) & VFS) {				\
-		pr_err_ ## ratefunc("CIFS VFS: Server:%s " fmt,	\
-			server->hostname, ##__VA_ARGS__);	\
+		pr_err_ ## ratefunc("CIFS VFS: \\\\%s " fmt,	\
+			sn, ##__VA_ARGS__);			\
 	} else if ((type) & NOISY && (NOISY != 0)) {		\
-		pr_debug_ ## ratefunc("Server:%s " fmt,		\
-			server->hostname, ##__VA_ARGS__);	\
+		pr_debug_ ## ratefunc("\\\\%s " fmt,		\
+			sn, ##__VA_ARGS__);			\
 	}							\
 } while (0)
 
@@ -104,6 +107,33 @@ do {							\
 			type, fmt, ##__VA_ARGS__);	\
 } while (0)
 
+#define cifs_tcon_dbg_func(ratefunc, type, fmt, ...)		\
+do {								\
+	const char *tn = "";					\
+	if (tcon && tcon->treeName)				\
+		tn = tcon->treeName;				\
+	if ((type) & FYI && cifsFYI & CIFS_INFO) {		\
+		pr_debug_ ## ratefunc("%s: %s "	fmt,		\
+			__FILE__, tn, ##__VA_ARGS__);		\
+	} else if ((type) & VFS) {				\
+		pr_err_ ## ratefunc("CIFS VFS: %s " fmt,	\
+			tn, ##__VA_ARGS__);			\
+	} else if ((type) & NOISY && (NOISY != 0)) {		\
+		pr_debug_ ## ratefunc("%s " fmt,		\
+			tn, ##__VA_ARGS__);			\
+	}							\
+} while (0)
+
+#define cifs_tcon_dbg(type, fmt, ...)			\
+do {							\
+	if ((type) & ONCE)				\
+		cifs_tcon_dbg_func(once,		\
+			type, fmt, ##__VA_ARGS__);	\
+	else						\
+		cifs_tcon_dbg_func(ratelimited,	\
+			type, fmt, ##__VA_ARGS__);	\
+} while (0)
+
 /*
  *	debug OFF
  *	---------
@@ -118,10 +148,16 @@ do {									\
 #define cifs_server_dbg(type, fmt, ...)					\
 do {									\
 	if (0)								\
-		pr_debug("Server:%s " fmt,				\
+		pr_debug("\\\\%s " fmt,					\
 			 server->hostname, ##__VA_ARGS__);		\
 } while (0)
 
+#define cifs_tcon_dbg(type, fmt, ...)					\
+do {									\
+	if (0)								\
+	  pr_debug("%s " fmt, tcon->treeName, ##__VA_ARGS__);		\
+} while (0)
+
 #define cifs_info(fmt, ...)						\
 do {									\
 	pr_info("CIFS: "fmt, ##__VA_ARGS__);				\
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index 070d0b7b21dc..83b02d74d48e 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -109,10 +109,10 @@ smb2_add_credits(struct TCP_Server_Info *server,
 		/* change_conf hasn't been executed */
 		break;
 	case 0:
-		cifs_dbg(VFS, "Possible client or server bug - zero credits\n");
+		cifs_server_dbg(VFS, "Possible client or server bug - zero credits\n");
 		break;
 	case 1:
-		cifs_dbg(VFS, "disabling echoes and oplocks\n");
+		cifs_server_dbg(VFS, "disabling echoes and oplocks\n");
 		break;
 	case 2:
 		cifs_dbg(FYI, "disabling oplocks\n");
@@ -230,7 +230,7 @@ smb2_adjust_credits(struct TCP_Server_Info *server,
 
 	if (server->reconnect_instance != credits->instance) {
 		spin_unlock(&server->req_lock);
-		cifs_dbg(VFS, "trying to return %d credits to old session\n",
+		cifs_server_dbg(VFS, "trying to return %d credits to old session\n",
 			 credits->value - new_val);
 		return -EAGAIN;
 	}
@@ -270,7 +270,7 @@ smb2_find_mid(struct TCP_Server_Info *server, char *buf)
 	__u64 wire_mid = le64_to_cpu(shdr->MessageId);
 
 	if (shdr->ProtocolId == SMB2_TRANSFORM_PROTO_NUM) {
-		cifs_dbg(VFS, "Encrypted frame parsing not supported yet\n");
+		cifs_server_dbg(VFS, "Encrypted frame parsing not supported yet\n");
 		return NULL;
 	}
 
@@ -294,10 +294,10 @@ smb2_dump_detail(void *buf, struct TCP_Server_Info *server)
 #ifdef CONFIG_CIFS_DEBUG2
 	struct smb2_sync_hdr *shdr = (struct smb2_sync_hdr *)buf;
 
-	cifs_dbg(VFS, "Cmd: %d Err: 0x%x Flags: 0x%x Mid: %llu Pid: %d\n",
+	cifs_server_dbg(VFS, "Cmd: %d Err: 0x%x Flags: 0x%x Mid: %llu Pid: %d\n",
 		 shdr->Command, shdr->Status, shdr->Flags, shdr->MessageId,
 		 shdr->ProcessId);
-	cifs_dbg(VFS, "smb buf %p len %u\n", buf,
+	cifs_server_dbg(VFS, "smb buf %p len %u\n", buf,
 		 server->ops->calc_smb_size(buf, server));
 #endif
 }
@@ -576,7 +576,7 @@ SMB3_request_interfaces(const unsigned int xid, struct cifs_tcon *tcon)
 			 "server does not support query network interfaces\n");
 		goto out;
 	} else if (rc != 0) {
-		cifs_dbg(VFS, "error %d on ioctl to get interface list\n", rc);
+		cifs_tcon_dbg(VFS, "error %d on ioctl to get interface list\n", rc);
 		goto out;
 	}
 
@@ -1330,11 +1330,11 @@ SMB2_request_res_key(const unsigned int xid, struct cifs_tcon *tcon,
 			(char **)&res_key, &ret_data_len);
 
 	if (rc) {
-		cifs_dbg(VFS, "refcpy ioctl error %d getting resume key\n", rc);
+		cifs_tcon_dbg(VFS, "refcpy ioctl error %d getting resume key\n", rc);
 		goto req_res_key_exit;
 	}
 	if (ret_data_len < sizeof(struct resume_key_req)) {
-		cifs_dbg(VFS, "Invalid refcopy resume key length\n");
+		cifs_tcon_dbg(VFS, "Invalid refcopy resume key length\n");
 		rc = -EINVAL;
 		goto req_res_key_exit;
 	}
@@ -1486,7 +1486,7 @@ smb2_ioctl_query_info(const unsigned int xid,
 				  qi.input_buffer_length,
 				  qi.output_buffer_length, buffer);
 	} else { /* unknown flags */
-		cifs_dbg(VFS, "invalid passthru query flags: 0x%x\n", qi.flags);
+		cifs_tcon_dbg(VFS, "invalid passthru query flags: 0x%x\n", qi.flags);
 		rc = -EINVAL;
 	}
 
@@ -1613,7 +1613,7 @@ smb2_copychunk_range(const unsigned int xid,
 		if (rc == 0) {
 			if (ret_data_len !=
 					sizeof(struct copychunk_ioctl_rsp)) {
-				cifs_dbg(VFS, "invalid cchunk response size\n");
+				cifs_tcon_dbg(VFS, "invalid cchunk response size\n");
 				rc = -EIO;
 				goto cchunk_out;
 			}
@@ -1627,12 +1627,12 @@ smb2_copychunk_range(const unsigned int xid,
 			 */
 			if (le32_to_cpu(retbuf->TotalBytesWritten) >
 			    le32_to_cpu(pcchunk->Length)) {
-				cifs_dbg(VFS, "invalid copy chunk response\n");
+				cifs_tcon_dbg(VFS, "invalid copy chunk response\n");
 				rc = -EIO;
 				goto cchunk_out;
 			}
 			if (le32_to_cpu(retbuf->ChunksWritten) != 1) {
-				cifs_dbg(VFS, "invalid num chunks written\n");
+				cifs_tcon_dbg(VFS, "invalid num chunks written\n");
 				rc = -EIO;
 				goto cchunk_out;
 			}
@@ -2422,7 +2422,7 @@ smb2_get_dfs_refer(const unsigned int xid, struct cifs_ses *ses,
 
 	if (rc) {
 		if ((rc != -ENOENT) && (rc != -EOPNOTSUPP))
-			cifs_dbg(VFS, "ioctl error in %s rc=%d\n", __func__, rc);
+			cifs_tcon_dbg(VFS, "ioctl error in %s rc=%d\n", __func__, rc);
 		goto out;
 	}
 
@@ -2431,7 +2431,7 @@ smb2_get_dfs_refer(const unsigned int xid, struct cifs_ses *ses,
 				 nls_codepage, remap, search_name,
 				 true /* is_unicode */);
 	if (rc) {
-		cifs_dbg(VFS, "parse error in %s rc=%d\n", __func__, rc);
+		cifs_tcon_dbg(VFS, "parse error in %s rc=%d\n", __func__, rc);
 		goto out;
 	}
 
@@ -2661,7 +2661,7 @@ smb2_query_symlink(const unsigned int xid, struct cifs_tcon *tcon,
 
 		if (plen + le32_to_cpu(ioctl_rsp->OutputOffset) >
 		    rsp_iov[1].iov_len) {
-			cifs_dbg(VFS, "srv returned invalid ioctl len: %d\n",
+			cifs_tcon_dbg(VFS, "srv returned invalid ioctl len: %d\n",
 				 plen);
 			rc = -EIO;
 			goto querty_exit;
@@ -3614,14 +3614,14 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 
 	rc = smb2_get_enc_key(server, tr_hdr->SessionId, enc, key);
 	if (rc) {
-		cifs_dbg(VFS, "%s: Could not get %scryption key\n", __func__,
+		cifs_server_dbg(VFS, "%s: Could not get %scryption key\n", __func__,
 			 enc ? "en" : "de");
 		return 0;
 	}
 
 	rc = smb3_crypto_aead_allocate(server);
 	if (rc) {
-		cifs_dbg(VFS, "%s: crypto alloc failed\n", __func__);
+		cifs_server_dbg(VFS, "%s: crypto alloc failed\n", __func__);
 		return rc;
 	}
 
@@ -3629,19 +3629,19 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 						server->secmech.ccmaesdecrypt;
 	rc = crypto_aead_setkey(tfm, key, SMB3_SIGN_KEY_SIZE);
 	if (rc) {
-		cifs_dbg(VFS, "%s: Failed to set aead key %d\n", __func__, rc);
+		cifs_server_dbg(VFS, "%s: Failed to set aead key %d\n", __func__, rc);
 		return rc;
 	}
 
 	rc = crypto_aead_setauthsize(tfm, SMB2_SIGNATURE_SIZE);
 	if (rc) {
-		cifs_dbg(VFS, "%s: Failed to set authsize %d\n", __func__, rc);
+		cifs_server_dbg(VFS, "%s: Failed to set authsize %d\n", __func__, rc);
 		return rc;
 	}
 
 	req = aead_request_alloc(tfm, GFP_KERNEL);
 	if (!req) {
-		cifs_dbg(VFS, "%s: Failed to alloc aead request\n", __func__);
+		cifs_server_dbg(VFS, "%s: Failed to alloc aead request\n", __func__);
 		return -ENOMEM;
 	}
 
@@ -3652,7 +3652,7 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 
 	sg = init_sg(num_rqst, rqst, sign);
 	if (!sg) {
-		cifs_dbg(VFS, "%s: Failed to init sg\n", __func__);
+		cifs_server_dbg(VFS, "%s: Failed to init sg\n", __func__);
 		rc = -ENOMEM;
 		goto free_req;
 	}
@@ -3660,7 +3660,7 @@ crypt_message(struct TCP_Server_Info *server, int num_rqst,
 	iv_len = crypto_aead_ivsize(tfm);
 	iv = kzalloc(iv_len, GFP_KERNEL);
 	if (!iv) {
-		cifs_dbg(VFS, "%s: Failed to alloc iv\n", __func__);
+		cifs_server_dbg(VFS, "%s: Failed to alloc iv\n", __func__);
 		rc = -ENOMEM;
 		goto free_sg;
 	}
@@ -3902,7 +3902,7 @@ handle_read_data(struct TCP_Server_Info *server, struct mid_q_entry *mid,
 	bool use_rdma_mr = false;
 
 	if (shdr->Command != SMB2_READ) {
-		cifs_dbg(VFS, "only big read responses are supported\n");
+		cifs_server_dbg(VFS, "only big read responses are supported\n");
 		return -ENOTSUPP;
 	}
 
@@ -4148,7 +4148,7 @@ receive_encrypted_standard(struct TCP_Server_Info *server,
 	}
 
 	if (*num_mids >= MAX_COMPOUND) {
-		cifs_dbg(VFS, "too many PDUs in compound\n");
+		cifs_server_dbg(VFS, "too many PDUs in compound\n");
 		return -1;
 	}
 	bufs[*num_mids] = buf;
@@ -4194,7 +4194,7 @@ smb3_receive_transform(struct TCP_Server_Info *server,
 
 	if (pdu_length < sizeof(struct smb2_transform_hdr) +
 						sizeof(struct smb2_sync_hdr)) {
-		cifs_dbg(VFS, "Transform message is too small (%u)\n",
+		cifs_server_dbg(VFS, "Transform message is too small (%u)\n",
 			 pdu_length);
 		cifs_reconnect(server);
 		wake_up(&server->response_q);
@@ -4202,7 +4202,7 @@ smb3_receive_transform(struct TCP_Server_Info *server,
 	}
 
 	if (pdu_length < orig_len + sizeof(struct smb2_transform_hdr)) {
-		cifs_dbg(VFS, "Transform message is broken\n");
+		cifs_server_dbg(VFS, "Transform message is broken\n");
 		cifs_reconnect(server);
 		wake_up(&server->response_q);
 		return -ECONNABORTED;
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 4c9c34cdf05f..dc9296569ed5 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -1019,7 +1019,7 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 	}
 
 	if (tcon->ses->session_flags & SMB2_SESSION_FLAG_IS_NULL)
-		cifs_server_dbg(VFS, "Unexpected null user (anonymous) auth flag sent by server\n");
+		cifs_tcon_dbg(VFS, "Unexpected null user (anonymous) auth flag sent by server\n");
 
 	pneg_inbuf = kmalloc(sizeof(*pneg_inbuf), GFP_NOFS);
 	if (!pneg_inbuf)
@@ -1076,18 +1076,18 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 		 * Old Windows versions or Netapp SMB server can return
 		 * not supported error. Client should accept it.
 		 */
-		cifs_server_dbg(VFS, "Server does not support validate negotiate\n");
+		cifs_tcon_dbg(VFS, "Server does not support validate negotiate\n");
 		rc = 0;
 		goto out_free_inbuf;
 	} else if (rc != 0) {
-		cifs_server_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
+		cifs_tcon_dbg(VFS, "validate protocol negotiate failed: %d\n", rc);
 		rc = -EIO;
 		goto out_free_inbuf;
 	}
 
 	rc = -EIO;
 	if (rsplen != sizeof(*pneg_rsp)) {
-		cifs_server_dbg(VFS, "invalid protocol negotiate response size: %d\n",
+		cifs_tcon_dbg(VFS, "invalid protocol negotiate response size: %d\n",
 			 rsplen);
 
 		/* relax check since Mac returns max bufsize allowed on ioctl */
@@ -1114,7 +1114,7 @@ int smb3_validate_negotiate(const unsigned int xid, struct cifs_tcon *tcon)
 	goto out_free_rsp;
 
 vneg_out:
-	cifs_server_dbg(VFS, "protocol revalidation - security settings mismatch\n");
+	cifs_tcon_dbg(VFS, "protocol revalidation - security settings mismatch\n");
 out_free_rsp:
 	kfree(pneg_rsp);
 out_free_inbuf:
@@ -1762,11 +1762,11 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 
 	if ((rsp->Capabilities & SMB2_SHARE_CAP_DFS) &&
 	    ((tcon->share_flags & SHI1005_FLAGS_DFS) == 0))
-		cifs_server_dbg(VFS, "DFS capability contradicts DFS flag\n");
+		cifs_tcon_dbg(VFS, "DFS capability contradicts DFS flag\n");
 
 	if (tcon->seal &&
 	    !(server->capabilities & SMB2_GLOBAL_CAP_ENCRYPTION))
-		cifs_server_dbg(VFS, "Encryption is requested but not supported\n");
+		cifs_tcon_dbg(VFS, "Encryption is requested but not supported\n");
 
 	init_copy_chunk_defaults(tcon);
 	if (server->ops->validate_negotiate)
@@ -1779,7 +1779,7 @@ SMB2_tcon(const unsigned int xid, struct cifs_ses *ses, const char *tree,
 
 tcon_error_exit:
 	if (rsp && rsp->sync_hdr.Status == STATUS_BAD_NETWORK_NAME) {
-		cifs_server_dbg(VFS, "BAD_NETWORK_NAME: %s\n", tree);
+		cifs_tcon_dbg(VFS, "BAD_NETWORK_NAME: %s\n", tree);
 	}
 	goto tcon_exit;
 }
@@ -2812,14 +2812,14 @@ SMB2_ioctl(const unsigned int xid, struct cifs_tcon *tcon, u64 persistent_fid,
 	if (*plen == 0)
 		goto ioctl_exit; /* server returned no data */
 	else if (*plen > rsp_iov.iov_len || *plen > 0xFF00) {
-		cifs_server_dbg(VFS, "srv returned invalid ioctl length: %d\n", *plen);
+		cifs_tcon_dbg(VFS, "srv returned invalid ioctl length: %d\n", *plen);
 		*plen = 0;
 		rc = -EIO;
 		goto ioctl_exit;
 	}
 
 	if (rsp_iov.iov_len - *plen < le32_to_cpu(rsp->OutputOffset)) {
-		cifs_server_dbg(VFS, "Malformed ioctl resp: len %d offset %d\n", *plen,
+		cifs_tcon_dbg(VFS, "Malformed ioctl resp: len %d offset %d\n", *plen,
 			le32_to_cpu(rsp->OutputOffset));
 		*plen = 0;
 		rc = -EIO;
@@ -3110,7 +3110,7 @@ query_info(const unsigned int xid, struct cifs_tcon *tcon,
 		if (!*data) {
 			*data = kmalloc(*dlen, GFP_KERNEL);
 			if (!*data) {
-				cifs_server_dbg(VFS,
+				cifs_tcon_dbg(VFS,
 					"Error %d allocating memory for acl\n",
 					rc);
 				*dlen = 0;
@@ -3505,7 +3505,7 @@ smb2_readv_callback(struct mid_q_entry *mid)
 
 			rc = smb2_verify_signature(&rqst, server);
 			if (rc)
-				cifs_server_dbg(VFS, "SMB signature verification returned error = %d\n",
+				cifs_tcon_dbg(VFS, "SMB signature verification returned error = %d\n",
 					 rc);
 		}
 		/* FIXME: should this be counted toward the initiating task? */
@@ -4095,7 +4095,7 @@ SMB2_query_directory(const unsigned int xid, struct cifs_tcon *tcon,
 		info_buf_size = sizeof(SEARCH_ID_FULL_DIR_INFO) - 1;
 		break;
 	default:
-		cifs_server_dbg(VFS, "info level %u isn't supported\n",
+		cifs_tcon_dbg(VFS, "info level %u isn't supported\n",
 			 srch_inf->info_level);
 		rc = -EINVAL;
 		goto qdir_exit;
@@ -4186,7 +4186,7 @@ SMB2_query_directory(const unsigned int xid, struct cifs_tcon *tcon,
 	else if (resp_buftype == CIFS_SMALL_BUFFER)
 		srch_inf->smallBuf = true;
 	else
-		cifs_server_dbg(VFS, "illegal search buffer type\n");
+		cifs_tcon_dbg(VFS, "illegal search buffer type\n");
 
 	trace_smb3_query_dir_done(xid, persistent_fid, tcon->tid,
 			tcon->ses->Suid, index, srch_inf->entries_in_buffer);
diff --git a/fs/cifs/transport.c b/fs/cifs/transport.c
index a90bd4d75b4d..4fccb90492e9 100644
--- a/fs/cifs/transport.c
+++ b/fs/cifs/transport.c
@@ -1403,7 +1403,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 	   use ses->maxReq */
 
 	if (len > CIFSMaxBufSize + MAX_CIFS_HDR_SIZE - 4) {
-		cifs_server_dbg(VFS, "Illegal length, greater than maximum frame, %d\n",
+		cifs_tcon_dbg(VFS, "Illegal length, greater than maximum frame, %d\n",
 			 len);
 		return -EIO;
 	}
@@ -1505,7 +1505,7 @@ SendReceiveBlockingLock(const unsigned int xid, struct cifs_tcon *tcon,
 	/* rcvd frame is ok */
 	if (out_buf == NULL || midQ->mid_state != MID_RESPONSE_RECEIVED) {
 		rc = -EIO;
-		cifs_server_dbg(VFS, "Bad MID state?\n");
+		cifs_tcon_dbg(VFS, "Bad MID state?\n");
 		goto out;
 	}
 
-- 
2.13.6

