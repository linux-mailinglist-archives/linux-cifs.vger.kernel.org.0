Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CA058ED153
	for <lists+linux-cifs@lfdr.de>; Sun,  3 Nov 2019 02:21:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbfKCBV3 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 2 Nov 2019 21:21:29 -0400
Received: from mx2.suse.de ([195.135.220.15]:57556 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727335AbfKCBV2 (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Sat, 2 Nov 2019 21:21:28 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A24E1B135;
        Sun,  3 Nov 2019 01:21:26 +0000 (UTC)
From:   Aurelien Aptel <aaptel@suse.com>
To:     linux-cifs@vger.kernel.org
Cc:     smfrench@gmail.com, Aurelien Aptel <aaptel@suse.com>
Subject: [PATCH v4 4/6] cifs: switch servers depending on binding state
Date:   Sun,  3 Nov 2019 02:21:10 +0100
Message-Id: <20191103012112.12212-5-aaptel@suse.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20191103012112.12212-1-aaptel@suse.com>
References: <20191103012112.12212-1-aaptel@suse.com>
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Currently a lot of the code to initialize a connection & session uses
the cifs_ses as input. But depending on if we are opening a new session
or a new channel we need to use different server pointers.

Add a "binding" flag in cifs_ses and a helper function that returns
the server ptr a session should use (only in the sess establishment
code path).

Signed-off-by: Aurelien Aptel <aaptel@suse.com>
---
 fs/cifs/cifs_spnego.c |  2 +-
 fs/cifs/cifsglob.h    | 10 ++++++++++
 fs/cifs/connect.c     |  4 ++--
 fs/cifs/sess.c        |  5 +++--
 fs/cifs/smb2ops.c     |  2 +-
 fs/cifs/smb2pdu.c     | 31 ++++++++++++++++---------------
 6 files changed, 33 insertions(+), 21 deletions(-)

diff --git a/fs/cifs/cifs_spnego.c b/fs/cifs/cifs_spnego.c
index 7f01c6e60791..7b9b876b513b 100644
--- a/fs/cifs/cifs_spnego.c
+++ b/fs/cifs/cifs_spnego.c
@@ -98,7 +98,7 @@ struct key_type cifs_spnego_key_type = {
 struct key *
 cifs_get_spnego_key(struct cifs_ses *sesInfo)
 {
-	struct TCP_Server_Info *server = sesInfo->server;
+	struct TCP_Server_Info *server = cifs_ses_server(sesInfo);
 	struct sockaddr_in *sa = (struct sockaddr_in *) &server->dstaddr;
 	struct sockaddr_in6 *sa6 = (struct sockaddr_in6 *) &server->dstaddr;
 	char *description, *dp;
diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
index bff3c97288e0..0426815288f4 100644
--- a/fs/cifs/cifsglob.h
+++ b/fs/cifs/cifsglob.h
@@ -994,6 +994,7 @@ struct cifs_ses {
 	bool sign;		/* is signing required? */
 	bool need_reconnect:1; /* connection reset, uid now invalid */
 	bool domainAuto:1;
+	bool binding:1; /* are we binding the session? */
 	__u16 session_flags;
 	__u8 smb3signingkey[SMB3_SIGN_KEY_SIZE];
 	__u8 smb3encryptionkey[SMB3_SIGN_KEY_SIZE];
@@ -1021,6 +1022,15 @@ struct cifs_ses {
 	atomic_t chan_seq; /* round robin state */
 };
 
+static inline
+struct TCP_Server_Info *cifs_ses_server(struct cifs_ses *ses)
+{
+	if (ses->binding)
+		return ses->chans[ses->chan_count].server;
+	else
+		return ses->server;
+}
+
 static inline bool
 cap_unix(struct cifs_ses *ses)
 {
diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
index d50f0676bf8a..9ce6301f82c3 100644
--- a/fs/cifs/connect.c
+++ b/fs/cifs/connect.c
@@ -5176,7 +5176,7 @@ int
 cifs_negotiate_protocol(const unsigned int xid, struct cifs_ses *ses)
 {
 	int rc = 0;
-	struct TCP_Server_Info *server = ses->server;
+	struct TCP_Server_Info *server = cifs_ses_server(ses);
 
 	if (!server->ops->need_neg || !server->ops->negotiate)
 		return -ENOSYS;
@@ -5203,7 +5203,7 @@ cifs_setup_session(const unsigned int xid, struct cifs_ses *ses,
 		   struct nls_table *nls_info)
 {
 	int rc = -ENOSYS;
-	struct TCP_Server_Info *server = ses->server;
+	struct TCP_Server_Info *server = cifs_ses_server(ses);
 
 	ses->capabilities = server->capabilities;
 	if (linuxExtEnabled == 0)
diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
index 85bd644f9773..bb3e506435de 100644
--- a/fs/cifs/sess.c
+++ b/fs/cifs/sess.c
@@ -342,6 +342,7 @@ int decode_ntlmssp_challenge(char *bcc_ptr, int blob_len,
 void build_ntlmssp_negotiate_blob(unsigned char *pbuffer,
 					 struct cifs_ses *ses)
 {
+	struct TCP_Server_Info *server = cifs_ses_server(ses);
 	NEGOTIATE_MESSAGE *sec_blob = (NEGOTIATE_MESSAGE *)pbuffer;
 	__u32 flags;
 
@@ -354,9 +355,9 @@ void build_ntlmssp_negotiate_blob(unsigned char *pbuffer,
 		NTLMSSP_NEGOTIATE_128 | NTLMSSP_NEGOTIATE_UNICODE |
 		NTLMSSP_NEGOTIATE_NTLM | NTLMSSP_NEGOTIATE_EXTENDED_SEC |
 		NTLMSSP_NEGOTIATE_SEAL;
-	if (ses->server->sign)
+	if (server->sign)
 		flags |= NTLMSSP_NEGOTIATE_SIGN;
-	if (!ses->server->session_estab || ses->ntlmssp->sesskey_per_smbsess)
+	if (!server->session_estab || ses->ntlmssp->sesskey_per_smbsess)
 		flags |= NTLMSSP_NEGOTIATE_KEY_XCH;
 
 	sec_blob->NegotiateFlags = cpu_to_le32(flags);
diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
index ea634581791a..9afda3dffaba 100644
--- a/fs/cifs/smb2ops.c
+++ b/fs/cifs/smb2ops.c
@@ -316,7 +316,7 @@ smb2_negotiate(const unsigned int xid, struct cifs_ses *ses)
 {
 	int rc;
 
-	ses->server->CurrentMid = 0;
+	cifs_ses_server(ses)->CurrentMid = 0;
 	rc = SMB2_negotiate(xid, ses);
 	/* BB we probably don't need to retry with modern servers */
 	if (rc == -EAGAIN)
diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
index 05149862aea4..b9a583a81542 100644
--- a/fs/cifs/smb2pdu.c
+++ b/fs/cifs/smb2pdu.c
@@ -791,7 +791,7 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
 	struct kvec rsp_iov;
 	int rc = 0;
 	int resp_buftype;
-	struct TCP_Server_Info *server = ses->server;
+	struct TCP_Server_Info *server = cifs_ses_server(ses);
 	int blob_offset, blob_length;
 	char *security_blob;
 	int flags = CIFS_NEG_OP;
@@ -813,7 +813,7 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
 	memset(server->preauth_sha_hash, 0, SMB2_PREAUTH_HASH_SIZE);
 	memset(ses->preauth_sha_hash, 0, SMB2_PREAUTH_HASH_SIZE);
 
-	if (strcmp(ses->server->vals->version_string,
+	if (strcmp(server->vals->version_string,
 		   SMB3ANY_VERSION_STRING) == 0) {
 		req->Dialects[0] = cpu_to_le16(SMB30_PROT_ID);
 		req->Dialects[1] = cpu_to_le16(SMB302_PROT_ID);
@@ -829,7 +829,7 @@ SMB2_negotiate(const unsigned int xid, struct cifs_ses *ses)
 		total_len += 8;
 	} else {
 		/* otherwise send specific dialect */
-		req->Dialects[0] = cpu_to_le16(ses->server->vals->protocol_id);
+		req->Dialects[0] = cpu_to_le16(server->vals->protocol_id);
 		req->DialectCount = cpu_to_le16(1);
 		total_len += 2;
 	}
@@ -1171,7 +1171,7 @@ SMB2_sess_alloc_buffer(struct SMB2_sess_data *sess_data)
 	int rc;
 	struct cifs_ses *ses = sess_data->ses;
 	struct smb2_sess_setup_req *req;
-	struct TCP_Server_Info *server = ses->server;
+	struct TCP_Server_Info *server = cifs_ses_server(ses);
 	unsigned int total_len;
 
 	rc = smb2_plain_req_init(SMB2_SESSION_SETUP, NULL, (void **) &req,
@@ -1258,22 +1258,23 @@ SMB2_sess_establish_session(struct SMB2_sess_data *sess_data)
 {
 	int rc = 0;
 	struct cifs_ses *ses = sess_data->ses;
+	struct TCP_Server_Info *server = cifs_ses_server(ses);
 
-	mutex_lock(&ses->server->srv_mutex);
-	if (ses->server->ops->generate_signingkey) {
-		rc = ses->server->ops->generate_signingkey(ses);
+	mutex_lock(&server->srv_mutex);
+	if (server->ops->generate_signingkey) {
+		rc = server->ops->generate_signingkey(ses);
 		if (rc) {
 			cifs_dbg(FYI,
 				"SMB3 session key generation failed\n");
-			mutex_unlock(&ses->server->srv_mutex);
+			mutex_unlock(&server->srv_mutex);
 			return rc;
 		}
 	}
-	if (!ses->server->session_estab) {
-		ses->server->sequence_number = 0x2;
-		ses->server->session_estab = true;
+	if (!server->session_estab) {
+		server->sequence_number = 0x2;
+		server->session_estab = true;
 	}
-	mutex_unlock(&ses->server->srv_mutex);
+	mutex_unlock(&server->srv_mutex);
 
 	cifs_dbg(FYI, "SMB2/3 session established successfully\n");
 	spin_lock(&GlobalMid_Lock);
@@ -1509,7 +1510,7 @@ SMB2_select_sec(struct cifs_ses *ses, struct SMB2_sess_data *sess_data)
 {
 	int type;
 
-	type = smb2_select_sectype(ses->server, ses->sectype);
+	type = smb2_select_sectype(cifs_ses_server(ses), ses->sectype);
 	cifs_dbg(FYI, "sess setup type %d\n", type);
 	if (type == Unspecified) {
 		cifs_dbg(VFS,
@@ -1537,7 +1538,7 @@ SMB2_sess_setup(const unsigned int xid, struct cifs_ses *ses,
 		const struct nls_table *nls_cp)
 {
 	int rc = 0;
-	struct TCP_Server_Info *server = ses->server;
+	struct TCP_Server_Info *server = cifs_ses_server(ses);
 	struct SMB2_sess_data *sess_data;
 
 	cifs_dbg(FYI, "Session Setup\n");
@@ -1563,7 +1564,7 @@ SMB2_sess_setup(const unsigned int xid, struct cifs_ses *ses,
 	/*
 	 * Initialize the session hash with the server one.
 	 */
-	memcpy(ses->preauth_sha_hash, ses->server->preauth_sha_hash,
+	memcpy(ses->preauth_sha_hash, server->preauth_sha_hash,
 	       SMB2_PREAUTH_HASH_SIZE);
 
 	while (sess_data->func)
-- 
2.16.4

