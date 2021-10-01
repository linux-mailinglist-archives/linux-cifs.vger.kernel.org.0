Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E359441ED5C
	for <lists+linux-cifs@lfdr.de>; Fri,  1 Oct 2021 14:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354307AbhJAM1e (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 1 Oct 2021 08:27:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbhJAM1d (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 1 Oct 2021 08:27:33 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A0FEC061775
        for <linux-cifs@vger.kernel.org>; Fri,  1 Oct 2021 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-Id:Date:Cc:To:From;
        bh=tIMPJNkMwmzHEy12uw+TrFIwS+U0LsqW96ddHytUD7w=; b=a/GlzQlDcIj5aX3FfOV5OtGoXd
        y6gWlZjpCNS5EWtUpGZlOX3+gRW5vpahq7Sjd5nBjPv6aHyp+ZCVVYegtxodolbci7zI/iZLpB3FV
        6CUdgOvIcLrTJM/e9YJz8yy8XQ6XNyuBYSLVqvZ0wu4QH/8EhR/QE6HGPAYnvlz22nbktoHpbOeE4
        wPe/GzkfnmPa6jzKKAHC7fFRVYorRG70AAvNZW9WRsA3snT/ckUupAidIkTS9nBNcDjK8Y6fk9633
        WH+uBKpX1ni3hLIe61udnnotKhz9w302VOURvi875/bj6e6LiKDFwvky1Qo4L42B/W3st6zuGZIQW
        of79JWTAgN+CJ7IjHWlaBThbJrCsvlkPvebHUyOlWykW0AlCTYDziQGBigsziJKczrQc7F/wWtlUI
        lXNbLxIYb1LFhC5hGxWa/7txS7z1F3PpSt3d193mh7yLcgmrzxW/bPCjOlaOz3V9htnKIsn/oPZYn
        pu3BTKPc0SiLrvW5JvwERcO1;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1mWHIQ-0013Z3-0U; Fri, 01 Oct 2021 12:05:46 +0000
From:   Ralph Boehme <slow@samba.org>
To:     linux-cifs@vger.kernel.org
Cc:     Namjae Jeon <linkinjeon@kernel.org>, Tom Talpey <tom@talpey.com>,
        Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        =?UTF-8?q?Ralph=20B=C3=B6hme?= <slow@samba.org>,
        Steve French <smfrench@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hyunchul Lee <hyc.lee@gmail.com>
Subject: [PATCH v5 09/20] ksmbd: remove NTLMv1 authentication
Date:   Fri,  1 Oct 2021 14:04:10 +0200
Message-Id: <20211001120421.327245-10-slow@samba.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20211001120421.327245-1-slow@samba.org>
References: <20211001120421.327245-1-slow@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

From: Namjae Jeon <linkinjeon@kernel.org>

Remove insecure NTLMv1 authentication.

Cc: Tom Talpey <tom@talpey.com>
Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
Cc: Ralph Böhme <slow@samba.org>
Cc: Steve French <smfrench@gmail.com>
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
Cc: Hyunchul Lee <hyc.lee@gmail.com>
Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
---
 fs/ksmbd/auth.c       | 205 ------------------------------------------
 fs/ksmbd/crypto_ctx.c |  16 ----
 fs/ksmbd/crypto_ctx.h |   8 --
 3 files changed, 229 deletions(-)

diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
index de36f12070bf..71c989f1568d 100644
--- a/fs/ksmbd/auth.c
+++ b/fs/ksmbd/auth.c
@@ -68,125 +68,6 @@ void ksmbd_copy_gss_neg_header(void *buf)
 	memcpy(buf, NEGOTIATE_GSS_HEADER, AUTH_GSS_LENGTH);
 }
 
-static void
-str_to_key(unsigned char *str, unsigned char *key)
-{
-	int i;
-
-	key[0] = str[0] >> 1;
-	key[1] = ((str[0] & 0x01) << 6) | (str[1] >> 2);
-	key[2] = ((str[1] & 0x03) << 5) | (str[2] >> 3);
-	key[3] = ((str[2] & 0x07) << 4) | (str[3] >> 4);
-	key[4] = ((str[3] & 0x0F) << 3) | (str[4] >> 5);
-	key[5] = ((str[4] & 0x1F) << 2) | (str[5] >> 6);
-	key[6] = ((str[5] & 0x3F) << 1) | (str[6] >> 7);
-	key[7] = str[6] & 0x7F;
-	for (i = 0; i < 8; i++)
-		key[i] = (key[i] << 1);
-}
-
-static int
-smbhash(unsigned char *out, const unsigned char *in, unsigned char *key)
-{
-	unsigned char key2[8];
-	struct des_ctx ctx;
-
-	if (fips_enabled) {
-		ksmbd_debug(AUTH, "FIPS compliance enabled: DES not permitted\n");
-		return -ENOENT;
-	}
-
-	str_to_key(key, key2);
-	des_expand_key(&ctx, key2, DES_KEY_SIZE);
-	des_encrypt(&ctx, out, in);
-	memzero_explicit(&ctx, sizeof(ctx));
-	return 0;
-}
-
-static int ksmbd_enc_p24(unsigned char *p21, const unsigned char *c8, unsigned char *p24)
-{
-	int rc;
-
-	rc = smbhash(p24, c8, p21);
-	if (rc)
-		return rc;
-	rc = smbhash(p24 + 8, c8, p21 + 7);
-	if (rc)
-		return rc;
-	return smbhash(p24 + 16, c8, p21 + 14);
-}
-
-/* produce a md4 message digest from data of length n bytes */
-static int ksmbd_enc_md4(unsigned char *md4_hash, unsigned char *link_str,
-			 int link_len)
-{
-	int rc;
-	struct ksmbd_crypto_ctx *ctx;
-
-	ctx = ksmbd_crypto_ctx_find_md4();
-	if (!ctx) {
-		ksmbd_debug(AUTH, "Crypto md4 allocation error\n");
-		return -ENOMEM;
-	}
-
-	rc = crypto_shash_init(CRYPTO_MD4(ctx));
-	if (rc) {
-		ksmbd_debug(AUTH, "Could not init md4 shash\n");
-		goto out;
-	}
-
-	rc = crypto_shash_update(CRYPTO_MD4(ctx), link_str, link_len);
-	if (rc) {
-		ksmbd_debug(AUTH, "Could not update with link_str\n");
-		goto out;
-	}
-
-	rc = crypto_shash_final(CRYPTO_MD4(ctx), md4_hash);
-	if (rc)
-		ksmbd_debug(AUTH, "Could not generate md4 hash\n");
-out:
-	ksmbd_release_crypto_ctx(ctx);
-	return rc;
-}
-
-static int ksmbd_enc_update_sess_key(unsigned char *md5_hash, char *nonce,
-				     char *server_challenge, int len)
-{
-	int rc;
-	struct ksmbd_crypto_ctx *ctx;
-
-	ctx = ksmbd_crypto_ctx_find_md5();
-	if (!ctx) {
-		ksmbd_debug(AUTH, "Crypto md5 allocation error\n");
-		return -ENOMEM;
-	}
-
-	rc = crypto_shash_init(CRYPTO_MD5(ctx));
-	if (rc) {
-		ksmbd_debug(AUTH, "Could not init md5 shash\n");
-		goto out;
-	}
-
-	rc = crypto_shash_update(CRYPTO_MD5(ctx), server_challenge, len);
-	if (rc) {
-		ksmbd_debug(AUTH, "Could not update with challenge\n");
-		goto out;
-	}
-
-	rc = crypto_shash_update(CRYPTO_MD5(ctx), nonce, len);
-	if (rc) {
-		ksmbd_debug(AUTH, "Could not update with nonce\n");
-		goto out;
-	}
-
-	rc = crypto_shash_final(CRYPTO_MD5(ctx), md5_hash);
-	if (rc)
-		ksmbd_debug(AUTH, "Could not generate md5 hash\n");
-out:
-	ksmbd_release_crypto_ctx(ctx);
-	return rc;
-}
-
 /**
  * ksmbd_gen_sess_key() - function to generate session key
  * @sess:	session of connection
@@ -324,43 +205,6 @@ static int calc_ntlmv2_hash(struct ksmbd_session *sess, char *ntlmv2_hash,
 	return ret;
 }
 
-/**
- * ksmbd_auth_ntlm() - NTLM authentication handler
- * @sess:	session of connection
- * @pw_buf:	NTLM challenge response
- * @passkey:	user password
- *
- * Return:	0 on success, error number on error
- */
-int ksmbd_auth_ntlm(struct ksmbd_session *sess, char *pw_buf)
-{
-	int rc;
-	unsigned char p21[21];
-	char key[CIFS_AUTH_RESP_SIZE];
-
-	memset(p21, '\0', 21);
-	memcpy(p21, user_passkey(sess->user), CIFS_NTHASH_SIZE);
-	rc = ksmbd_enc_p24(p21, sess->ntlmssp.cryptkey, key);
-	if (rc) {
-		pr_err("password processing failed\n");
-		return rc;
-	}
-
-	ksmbd_enc_md4(sess->sess_key, user_passkey(sess->user),
-		      CIFS_SMB1_SESSKEY_SIZE);
-	memcpy(sess->sess_key + CIFS_SMB1_SESSKEY_SIZE, key,
-	       CIFS_AUTH_RESP_SIZE);
-	sess->sequence_number = 1;
-
-	if (strncmp(pw_buf, key, CIFS_AUTH_RESP_SIZE) != 0) {
-		ksmbd_debug(AUTH, "ntlmv1 authentication failed\n");
-		return -EINVAL;
-	}
-
-	ksmbd_debug(AUTH, "ntlmv1 authentication pass\n");
-	return 0;
-}
-
 /**
  * ksmbd_auth_ntlmv2() - NTLMv2 authentication handler
  * @sess:	session of connection
@@ -441,44 +285,6 @@ int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp *ntlmv2,
 	return rc;
 }
 
-/**
- * __ksmbd_auth_ntlmv2() - NTLM2(extended security) authentication handler
- * @sess:	session of connection
- * @client_nonce:	client nonce from LM response.
- * @ntlm_resp:		ntlm response data from client.
- *
- * Return:	0 on success, error number on error
- */
-static int __ksmbd_auth_ntlmv2(struct ksmbd_session *sess, char *client_nonce,
-			       char *ntlm_resp)
-{
-	char sess_key[CIFS_SMB1_SESSKEY_SIZE] = {0};
-	int rc;
-	unsigned char p21[21];
-	char key[CIFS_AUTH_RESP_SIZE];
-
-	rc = ksmbd_enc_update_sess_key(sess_key,
-				       client_nonce,
-				       (char *)sess->ntlmssp.cryptkey, 8);
-	if (rc) {
-		pr_err("password processing failed\n");
-		goto out;
-	}
-
-	memset(p21, '\0', 21);
-	memcpy(p21, user_passkey(sess->user), CIFS_NTHASH_SIZE);
-	rc = ksmbd_enc_p24(p21, sess_key, key);
-	if (rc) {
-		pr_err("password processing failed\n");
-		goto out;
-	}
-
-	if (memcmp(ntlm_resp, key, CIFS_AUTH_RESP_SIZE) != 0)
-		rc = -EINVAL;
-out:
-	return rc;
-}
-
 /**
  * ksmbd_decode_ntlmssp_auth_blob() - helper function to construct
  * authenticate blob
@@ -512,17 +318,6 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
 	nt_off = le32_to_cpu(authblob->NtChallengeResponse.BufferOffset);
 	nt_len = le16_to_cpu(authblob->NtChallengeResponse.Length);
 
-	/* process NTLM authentication */
-	if (nt_len == CIFS_AUTH_RESP_SIZE) {
-		if (le32_to_cpu(authblob->NegotiateFlags) &
-		    NTLMSSP_NEGOTIATE_EXTENDED_SEC)
-			return __ksmbd_auth_ntlmv2(sess, (char *)authblob +
-				lm_off, (char *)authblob + nt_off);
-		else
-			return ksmbd_auth_ntlm(sess, (char *)authblob +
-				nt_off);
-	}
-
 	/* TODO : use domain name that imported from configuration file */
 	domain_name = smb_strndup_from_utf16((const char *)authblob +
 			le32_to_cpu(authblob->DomainName.BufferOffset),
diff --git a/fs/ksmbd/crypto_ctx.c b/fs/ksmbd/crypto_ctx.c
index 5f4b1008d17e..81488d04199d 100644
--- a/fs/ksmbd/crypto_ctx.c
+++ b/fs/ksmbd/crypto_ctx.c
@@ -81,12 +81,6 @@ static struct shash_desc *alloc_shash_desc(int id)
 	case CRYPTO_SHASH_SHA512:
 		tfm = crypto_alloc_shash("sha512", 0, 0);
 		break;
-	case CRYPTO_SHASH_MD4:
-		tfm = crypto_alloc_shash("md4", 0, 0);
-		break;
-	case CRYPTO_SHASH_MD5:
-		tfm = crypto_alloc_shash("md5", 0, 0);
-		break;
 	default:
 		return NULL;
 	}
@@ -214,16 +208,6 @@ struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_sha512(void)
 	return ____crypto_shash_ctx_find(CRYPTO_SHASH_SHA512);
 }
 
-struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_md4(void)
-{
-	return ____crypto_shash_ctx_find(CRYPTO_SHASH_MD4);
-}
-
-struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_md5(void)
-{
-	return ____crypto_shash_ctx_find(CRYPTO_SHASH_MD5);
-}
-
 static struct ksmbd_crypto_ctx *____crypto_aead_ctx_find(int id)
 {
 	struct ksmbd_crypto_ctx *ctx;
diff --git a/fs/ksmbd/crypto_ctx.h b/fs/ksmbd/crypto_ctx.h
index ef11154b43df..4a367c62f653 100644
--- a/fs/ksmbd/crypto_ctx.h
+++ b/fs/ksmbd/crypto_ctx.h
@@ -15,8 +15,6 @@ enum {
 	CRYPTO_SHASH_CMACAES,
 	CRYPTO_SHASH_SHA256,
 	CRYPTO_SHASH_SHA512,
-	CRYPTO_SHASH_MD4,
-	CRYPTO_SHASH_MD5,
 	CRYPTO_SHASH_MAX,
 };
 
@@ -43,8 +41,6 @@ struct ksmbd_crypto_ctx {
 #define CRYPTO_CMACAES(c)	((c)->desc[CRYPTO_SHASH_CMACAES])
 #define CRYPTO_SHA256(c)	((c)->desc[CRYPTO_SHASH_SHA256])
 #define CRYPTO_SHA512(c)	((c)->desc[CRYPTO_SHASH_SHA512])
-#define CRYPTO_MD4(c)		((c)->desc[CRYPTO_SHASH_MD4])
-#define CRYPTO_MD5(c)		((c)->desc[CRYPTO_SHASH_MD5])
 
 #define CRYPTO_HMACMD5_TFM(c)	((c)->desc[CRYPTO_SHASH_HMACMD5]->tfm)
 #define CRYPTO_HMACSHA256_TFM(c)\
@@ -52,8 +48,6 @@ struct ksmbd_crypto_ctx {
 #define CRYPTO_CMACAES_TFM(c)	((c)->desc[CRYPTO_SHASH_CMACAES]->tfm)
 #define CRYPTO_SHA256_TFM(c)	((c)->desc[CRYPTO_SHASH_SHA256]->tfm)
 #define CRYPTO_SHA512_TFM(c)	((c)->desc[CRYPTO_SHASH_SHA512]->tfm)
-#define CRYPTO_MD4_TFM(c)	((c)->desc[CRYPTO_SHASH_MD4]->tfm)
-#define CRYPTO_MD5_TFM(c)	((c)->desc[CRYPTO_SHASH_MD5]->tfm)
 
 #define CRYPTO_GCM(c)		((c)->ccmaes[CRYPTO_AEAD_AES_GCM])
 #define CRYPTO_CCM(c)		((c)->ccmaes[CRYPTO_AEAD_AES_CCM])
@@ -64,8 +58,6 @@ struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_hmacsha256(void);
 struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_cmacaes(void);
 struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_sha512(void);
 struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_sha256(void);
-struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_md4(void);
-struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_md5(void);
 struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_gcm(void);
 struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_ccm(void);
 void ksmbd_crypto_destroy(void);
-- 
2.31.1

