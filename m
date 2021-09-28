Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1474141B228
	for <lists+linux-cifs@lfdr.de>; Tue, 28 Sep 2021 16:32:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241227AbhI1Ody (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 28 Sep 2021 10:33:54 -0400
Received: from p3plsmtpa07-10.prod.phx3.secureserver.net ([173.201.192.239]:59059
        "EHLO p3plsmtpa07-10.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S241127AbhI1Odx (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Tue, 28 Sep 2021 10:33:53 -0400
Received: from [192.168.0.100] ([173.76.240.186])
        by :SMTPAUTH: with ESMTPSA
        id VE9VmA4yD0QhzVE9Vmxorm; Tue, 28 Sep 2021 07:32:14 -0700
X-CMAE-Analysis: v=2.4 cv=ItrbzJzg c=1 sm=1 tr=0 ts=6153276e
 a=jWrLioA5F7WmVvax94MGYQ==:117 a=jWrLioA5F7WmVvax94MGYQ==:17
 a=IkcTkHD0fZMA:10 a=SEc3moZ4AAAA:8 a=pGLkceISAAAA:8 a=hGzw-44bAAAA:8
 a=cm27Pg_UAAAA:8 a=VwQbUJbxAAAA:8 a=ACxVY8J_CaUI8xAScfkA:9 a=QEXdDO2ut3YA:10
 a=5oRCH6oROnRZc2VpWJZ3:22 a=HvKuF1_PTVFglORKqfwH:22 a=xmb-EsYY8bH0VWELuYED:22
 a=AjGcO6oz07-iQ99wixmX:22
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH 2/2] ksmbd: remove NTLMv1 authentication
To:     Namjae Jeon <linkinjeon@kernel.org>, linux-cifs@vger.kernel.org
Cc:     Ronnie Sahlberg <ronniesahlberg@gmail.com>,
        =?UTF-8?Q?Ralph_B=c3=b6hme?= <slow@samba.org>,
        Steve French <smfrench@gmail.com>,
        Sergey Senozhatsky <senozhatsky@chromium.org>,
        Hyunchul Lee <hyc.lee@gmail.com>
References: <20210927124748.5614-1-linkinjeon@kernel.org>
 <20210927124748.5614-2-linkinjeon@kernel.org>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <8af27366-2bcf-08d3-ff8a-f0635a3c002b@talpey.com>
Date:   Tue, 28 Sep 2021 10:32:13 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20210927124748.5614-2-linkinjeon@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-CMAE-Envelope: MS4xfIjcGoJnUoKQeiDXdPLVUj1zHbaBjL88/wnr8akZ4ukdbH9z6nYKJyei9TM4qLshD2ATVEq6jhxuxnhIMVQNBs5q0V5NIasrD6vIRJIuc7Yr3FYJY9Qh
 K64FXOtpIJf9PDnyE7aFuMYoyD1SqCHG7CDVu6Nv3XWlFPJHZQWC6djlKYjBKLJgXra2tZp9jgXEW8283ToYZkD5gzI5bkQ391rJ7djZtnn8G5Go0t9W5PJu
 5EFH/lCukaOJrfh7DeuBjRtmbxkgNBfGLBRkxw83Afz6yylGLzA1QFBOmPw8ceZnhtphL/oBcs7UjbfRoAWAkBppdWmDVAGIqaiecHuxjYFaUadC5XaBL4QI
 8QmolK7Rh18eGcBHm+PnGUQ8ev8LrA==
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On 9/27/2021 8:47 AM, Namjae Jeon wrote:
> Remove insecure NTLMv1 authentication.

There are some extremely confusing name overloads in this file.
Apparently "ksmbd_auth_ntlmv2()" and "__ksmb2_auth_ntlmv2()"
are entirely different things! Yes, this patch removes one,
but it's not easy to review.

> /**
>  * ksmbd_auth_ntlmv2() - NTLMv2 authentication handler
>  * @sess:	session of connection
>  * @ntlmv2:		NTLMv2 challenge response
>  * @blen:		NTLMv2 blob length
>  * @domain_name:	domain name
>  *
>  * Return:	0 on success, error number on error
>  */

> /**
>  * __ksmbd_auth_ntlmv2() - NTLM2(extended security) authentication handler
>  * @sess:	session of connection
>  * @client_nonce:	client nonce from LM response.
>  * @ntlm_resp:		ntlm response data from client.
>  *
>  * Return:	0 on success, error number on error
>  */

Two questions:
1) Have you tested this does not remove existing NTLMv2 support?
2) Does this fully clean up the rather insane function naming?

Tom.

> Cc: Tom Talpey <tom@talpey.com>
> Cc: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Cc: Ralph Böhme <slow@samba.org>
> Cc: Steve French <smfrench@gmail.com>
> Cc: Sergey Senozhatsky <senozhatsky@chromium.org>
> Cc: Hyunchul Lee <hyc.lee@gmail.com>
> Signed-off-by: Namjae Jeon <linkinjeon@kernel.org>
> ---
>   fs/ksmbd/auth.c       | 205 ------------------------------------------
>   fs/ksmbd/crypto_ctx.c |  16 ----
>   fs/ksmbd/crypto_ctx.h |   8 --
>   3 files changed, 229 deletions(-)
> 
> diff --git a/fs/ksmbd/auth.c b/fs/ksmbd/auth.c
> index de36f12070bf..71c989f1568d 100644
> --- a/fs/ksmbd/auth.c
> +++ b/fs/ksmbd/auth.c
> @@ -68,125 +68,6 @@ void ksmbd_copy_gss_neg_header(void *buf)
>   	memcpy(buf, NEGOTIATE_GSS_HEADER, AUTH_GSS_LENGTH);
>   }
>   
> -static void
> -str_to_key(unsigned char *str, unsigned char *key)
> -{
> -	int i;
> -
> -	key[0] = str[0] >> 1;
> -	key[1] = ((str[0] & 0x01) << 6) | (str[1] >> 2);
> -	key[2] = ((str[1] & 0x03) << 5) | (str[2] >> 3);
> -	key[3] = ((str[2] & 0x07) << 4) | (str[3] >> 4);
> -	key[4] = ((str[3] & 0x0F) << 3) | (str[4] >> 5);
> -	key[5] = ((str[4] & 0x1F) << 2) | (str[5] >> 6);
> -	key[6] = ((str[5] & 0x3F) << 1) | (str[6] >> 7);
> -	key[7] = str[6] & 0x7F;
> -	for (i = 0; i < 8; i++)
> -		key[i] = (key[i] << 1);
> -}
> -
> -static int
> -smbhash(unsigned char *out, const unsigned char *in, unsigned char *key)
> -{
> -	unsigned char key2[8];
> -	struct des_ctx ctx;
> -
> -	if (fips_enabled) {
> -		ksmbd_debug(AUTH, "FIPS compliance enabled: DES not permitted\n");
> -		return -ENOENT;
> -	}
> -
> -	str_to_key(key, key2);
> -	des_expand_key(&ctx, key2, DES_KEY_SIZE);
> -	des_encrypt(&ctx, out, in);
> -	memzero_explicit(&ctx, sizeof(ctx));
> -	return 0;
> -}
> -
> -static int ksmbd_enc_p24(unsigned char *p21, const unsigned char *c8, unsigned char *p24)
> -{
> -	int rc;
> -
> -	rc = smbhash(p24, c8, p21);
> -	if (rc)
> -		return rc;
> -	rc = smbhash(p24 + 8, c8, p21 + 7);
> -	if (rc)
> -		return rc;
> -	return smbhash(p24 + 16, c8, p21 + 14);
> -}
> -
> -/* produce a md4 message digest from data of length n bytes */
> -static int ksmbd_enc_md4(unsigned char *md4_hash, unsigned char *link_str,
> -			 int link_len)
> -{
> -	int rc;
> -	struct ksmbd_crypto_ctx *ctx;
> -
> -	ctx = ksmbd_crypto_ctx_find_md4();
> -	if (!ctx) {
> -		ksmbd_debug(AUTH, "Crypto md4 allocation error\n");
> -		return -ENOMEM;
> -	}
> -
> -	rc = crypto_shash_init(CRYPTO_MD4(ctx));
> -	if (rc) {
> -		ksmbd_debug(AUTH, "Could not init md4 shash\n");
> -		goto out;
> -	}
> -
> -	rc = crypto_shash_update(CRYPTO_MD4(ctx), link_str, link_len);
> -	if (rc) {
> -		ksmbd_debug(AUTH, "Could not update with link_str\n");
> -		goto out;
> -	}
> -
> -	rc = crypto_shash_final(CRYPTO_MD4(ctx), md4_hash);
> -	if (rc)
> -		ksmbd_debug(AUTH, "Could not generate md4 hash\n");
> -out:
> -	ksmbd_release_crypto_ctx(ctx);
> -	return rc;
> -}
> -
> -static int ksmbd_enc_update_sess_key(unsigned char *md5_hash, char *nonce,
> -				     char *server_challenge, int len)
> -{
> -	int rc;
> -	struct ksmbd_crypto_ctx *ctx;
> -
> -	ctx = ksmbd_crypto_ctx_find_md5();
> -	if (!ctx) {
> -		ksmbd_debug(AUTH, "Crypto md5 allocation error\n");
> -		return -ENOMEM;
> -	}
> -
> -	rc = crypto_shash_init(CRYPTO_MD5(ctx));
> -	if (rc) {
> -		ksmbd_debug(AUTH, "Could not init md5 shash\n");
> -		goto out;
> -	}
> -
> -	rc = crypto_shash_update(CRYPTO_MD5(ctx), server_challenge, len);
> -	if (rc) {
> -		ksmbd_debug(AUTH, "Could not update with challenge\n");
> -		goto out;
> -	}
> -
> -	rc = crypto_shash_update(CRYPTO_MD5(ctx), nonce, len);
> -	if (rc) {
> -		ksmbd_debug(AUTH, "Could not update with nonce\n");
> -		goto out;
> -	}
> -
> -	rc = crypto_shash_final(CRYPTO_MD5(ctx), md5_hash);
> -	if (rc)
> -		ksmbd_debug(AUTH, "Could not generate md5 hash\n");
> -out:
> -	ksmbd_release_crypto_ctx(ctx);
> -	return rc;
> -}
> -
>   /**
>    * ksmbd_gen_sess_key() - function to generate session key
>    * @sess:	session of connection
> @@ -324,43 +205,6 @@ static int calc_ntlmv2_hash(struct ksmbd_session *sess, char *ntlmv2_hash,
>   	return ret;
>   }
>   
> -/**
> - * ksmbd_auth_ntlm() - NTLM authentication handler
> - * @sess:	session of connection
> - * @pw_buf:	NTLM challenge response
> - * @passkey:	user password
> - *
> - * Return:	0 on success, error number on error
> - */
> -int ksmbd_auth_ntlm(struct ksmbd_session *sess, char *pw_buf)
> -{
> -	int rc;
> -	unsigned char p21[21];
> -	char key[CIFS_AUTH_RESP_SIZE];
> -
> -	memset(p21, '\0', 21);
> -	memcpy(p21, user_passkey(sess->user), CIFS_NTHASH_SIZE);
> -	rc = ksmbd_enc_p24(p21, sess->ntlmssp.cryptkey, key);
> -	if (rc) {
> -		pr_err("password processing failed\n");
> -		return rc;
> -	}
> -
> -	ksmbd_enc_md4(sess->sess_key, user_passkey(sess->user),
> -		      CIFS_SMB1_SESSKEY_SIZE);
> -	memcpy(sess->sess_key + CIFS_SMB1_SESSKEY_SIZE, key,
> -	       CIFS_AUTH_RESP_SIZE);
> -	sess->sequence_number = 1;
> -
> -	if (strncmp(pw_buf, key, CIFS_AUTH_RESP_SIZE) != 0) {
> -		ksmbd_debug(AUTH, "ntlmv1 authentication failed\n");
> -		return -EINVAL;
> -	}
> -
> -	ksmbd_debug(AUTH, "ntlmv1 authentication pass\n");
> -	return 0;
> -}
> -
>   /**
>    * ksmbd_auth_ntlmv2() - NTLMv2 authentication handler
>    * @sess:	session of connection
> @@ -441,44 +285,6 @@ int ksmbd_auth_ntlmv2(struct ksmbd_session *sess, struct ntlmv2_resp *ntlmv2,
>   	return rc;
>   }
>   
> -/**
> - * __ksmbd_auth_ntlmv2() - NTLM2(extended security) authentication handler
> - * @sess:	session of connection
> - * @client_nonce:	client nonce from LM response.
> - * @ntlm_resp:		ntlm response data from client.
> - *
> - * Return:	0 on success, error number on error
> - */
> -static int __ksmbd_auth_ntlmv2(struct ksmbd_session *sess, char *client_nonce,
> -			       char *ntlm_resp)
> -{
> -	char sess_key[CIFS_SMB1_SESSKEY_SIZE] = {0};
> -	int rc;
> -	unsigned char p21[21];
> -	char key[CIFS_AUTH_RESP_SIZE];
> -
> -	rc = ksmbd_enc_update_sess_key(sess_key,
> -				       client_nonce,
> -				       (char *)sess->ntlmssp.cryptkey, 8);
> -	if (rc) {
> -		pr_err("password processing failed\n");
> -		goto out;
> -	}
> -
> -	memset(p21, '\0', 21);
> -	memcpy(p21, user_passkey(sess->user), CIFS_NTHASH_SIZE);
> -	rc = ksmbd_enc_p24(p21, sess_key, key);
> -	if (rc) {
> -		pr_err("password processing failed\n");
> -		goto out;
> -	}
> -
> -	if (memcmp(ntlm_resp, key, CIFS_AUTH_RESP_SIZE) != 0)
> -		rc = -EINVAL;
> -out:
> -	return rc;
> -}
> -
>   /**
>    * ksmbd_decode_ntlmssp_auth_blob() - helper function to construct
>    * authenticate blob
> @@ -512,17 +318,6 @@ int ksmbd_decode_ntlmssp_auth_blob(struct authenticate_message *authblob,
>   	nt_off = le32_to_cpu(authblob->NtChallengeResponse.BufferOffset);
>   	nt_len = le16_to_cpu(authblob->NtChallengeResponse.Length);
>   
> -	/* process NTLM authentication */
> -	if (nt_len == CIFS_AUTH_RESP_SIZE) {
> -		if (le32_to_cpu(authblob->NegotiateFlags) &
> -		    NTLMSSP_NEGOTIATE_EXTENDED_SEC)
> -			return __ksmbd_auth_ntlmv2(sess, (char *)authblob +
> -				lm_off, (char *)authblob + nt_off);
> -		else
> -			return ksmbd_auth_ntlm(sess, (char *)authblob +
> -				nt_off);
> -	}
> -
>   	/* TODO : use domain name that imported from configuration file */
>   	domain_name = smb_strndup_from_utf16((const char *)authblob +
>   			le32_to_cpu(authblob->DomainName.BufferOffset),
> diff --git a/fs/ksmbd/crypto_ctx.c b/fs/ksmbd/crypto_ctx.c
> index 5f4b1008d17e..81488d04199d 100644
> --- a/fs/ksmbd/crypto_ctx.c
> +++ b/fs/ksmbd/crypto_ctx.c
> @@ -81,12 +81,6 @@ static struct shash_desc *alloc_shash_desc(int id)
>   	case CRYPTO_SHASH_SHA512:
>   		tfm = crypto_alloc_shash("sha512", 0, 0);
>   		break;
> -	case CRYPTO_SHASH_MD4:
> -		tfm = crypto_alloc_shash("md4", 0, 0);
> -		break;
> -	case CRYPTO_SHASH_MD5:
> -		tfm = crypto_alloc_shash("md5", 0, 0);
> -		break;
>   	default:
>   		return NULL;
>   	}
> @@ -214,16 +208,6 @@ struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_sha512(void)
>   	return ____crypto_shash_ctx_find(CRYPTO_SHASH_SHA512);
>   }
>   
> -struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_md4(void)
> -{
> -	return ____crypto_shash_ctx_find(CRYPTO_SHASH_MD4);
> -}
> -
> -struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_md5(void)
> -{
> -	return ____crypto_shash_ctx_find(CRYPTO_SHASH_MD5);
> -}
> -
>   static struct ksmbd_crypto_ctx *____crypto_aead_ctx_find(int id)
>   {
>   	struct ksmbd_crypto_ctx *ctx;
> diff --git a/fs/ksmbd/crypto_ctx.h b/fs/ksmbd/crypto_ctx.h
> index ef11154b43df..4a367c62f653 100644
> --- a/fs/ksmbd/crypto_ctx.h
> +++ b/fs/ksmbd/crypto_ctx.h
> @@ -15,8 +15,6 @@ enum {
>   	CRYPTO_SHASH_CMACAES,
>   	CRYPTO_SHASH_SHA256,
>   	CRYPTO_SHASH_SHA512,
> -	CRYPTO_SHASH_MD4,
> -	CRYPTO_SHASH_MD5,
>   	CRYPTO_SHASH_MAX,
>   };
>   
> @@ -43,8 +41,6 @@ struct ksmbd_crypto_ctx {
>   #define CRYPTO_CMACAES(c)	((c)->desc[CRYPTO_SHASH_CMACAES])
>   #define CRYPTO_SHA256(c)	((c)->desc[CRYPTO_SHASH_SHA256])
>   #define CRYPTO_SHA512(c)	((c)->desc[CRYPTO_SHASH_SHA512])
> -#define CRYPTO_MD4(c)		((c)->desc[CRYPTO_SHASH_MD4])
> -#define CRYPTO_MD5(c)		((c)->desc[CRYPTO_SHASH_MD5])
>   
>   #define CRYPTO_HMACMD5_TFM(c)	((c)->desc[CRYPTO_SHASH_HMACMD5]->tfm)
>   #define CRYPTO_HMACSHA256_TFM(c)\
> @@ -52,8 +48,6 @@ struct ksmbd_crypto_ctx {
>   #define CRYPTO_CMACAES_TFM(c)	((c)->desc[CRYPTO_SHASH_CMACAES]->tfm)
>   #define CRYPTO_SHA256_TFM(c)	((c)->desc[CRYPTO_SHASH_SHA256]->tfm)
>   #define CRYPTO_SHA512_TFM(c)	((c)->desc[CRYPTO_SHASH_SHA512]->tfm)
> -#define CRYPTO_MD4_TFM(c)	((c)->desc[CRYPTO_SHASH_MD4]->tfm)
> -#define CRYPTO_MD5_TFM(c)	((c)->desc[CRYPTO_SHASH_MD5]->tfm)
>   
>   #define CRYPTO_GCM(c)		((c)->ccmaes[CRYPTO_AEAD_AES_GCM])
>   #define CRYPTO_CCM(c)		((c)->ccmaes[CRYPTO_AEAD_AES_CCM])
> @@ -64,8 +58,6 @@ struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_hmacsha256(void);
>   struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_cmacaes(void);
>   struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_sha512(void);
>   struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_sha256(void);
> -struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_md4(void);
> -struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_md5(void);
>   struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_gcm(void);
>   struct ksmbd_crypto_ctx *ksmbd_crypto_ctx_find_ccm(void);
>   void ksmbd_crypto_destroy(void);
> 
