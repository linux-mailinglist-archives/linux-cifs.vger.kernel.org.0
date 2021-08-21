Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F5453F3AFB
	for <lists+linux-cifs@lfdr.de>; Sat, 21 Aug 2021 16:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbhHUO0G (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 21 Aug 2021 10:26:06 -0400
Received: from p3plsmtpa07-09.prod.phx3.secureserver.net ([173.201.192.238]:53360
        "EHLO p3plsmtpa07-09.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230167AbhHUO0B (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>);
        Sat, 21 Aug 2021 10:26:01 -0400
Received: from [192.168.0.100] ([68.239.50.225])
        by :SMTPAUTH: with ESMTPSA
        id HRw0mkTozNx59HRw1mZR39; Sat, 21 Aug 2021 07:25:21 -0700
X-CMAE-Analysis: v=2.4 cv=E4EIGYRl c=1 sm=1 tr=0 ts=61210cd1
 a=Rhw2r8FBodfaBxRKvGSZLA==:117 a=Rhw2r8FBodfaBxRKvGSZLA==:17
 a=IkcTkHD0fZMA:10 a=20KFwNOVAAAA:8 a=KoWrPYjigxIXA-9RpYwA:9
 a=jjcJYxtLanm69Dt_:21 a=3gACmSt5sV6KdDEU:21 a=QEXdDO2ut3YA:10
X-SECURESERVER-ACCT: tom@talpey.com
Subject: Re: [PATCH 1/2] cifs: remove support for NTLM and weaker
 authentication algorithms
To:     Ronnie Sahlberg <lsahlber@redhat.com>,
        linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
References: <20210819103459.1291412-1-lsahlber@redhat.com>
 <20210819103459.1291412-2-lsahlber@redhat.com>
From:   Tom Talpey <tom@talpey.com>
Message-ID: <43b2f08a-0303-3ea2-5894-38c66dce4f73@talpey.com>
Date:   Sat, 21 Aug 2021 10:25:20 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210819103459.1291412-2-lsahlber@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4xfKkAq4C4ROTOd+0tsU3PzG2kajnrLEKbfNABwVca/YAvkeC4uZiePo2AgaHu2XcWLFSN0BoiYps5CPpCg4rN3OI1/9Zzu5ElZ9p+PBSNEqACzPuCmxxr
 Zt/XOESP8Y9xqEFJa8xqalyw6jckUCnw0sCGHbfBzFJwc+GYYZIPIU6JRcTK55SxJSSl6jzWj/DUAFXUmul4m3wbs2w1sxI36dh06njm3BASrWxM4pdrePov
 IBhC9lNF6muhPQ+2KPulOQ==
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

The commit log message is apparently missing a lot of text!

This removes some mount options, I guess this means that they'll
result in generic "invalid parameter" errors. That's going to
be messy for sysadmins. Would it be better to throw a nonfatal
warning, even though the mount might fail during auth? After all,
it might actually work, if the server supported something better.

Tom.


On 8/19/2021 6:34 AM, Ronnie Sahlberg wrote:
> for SMB1.
> This removes the dependency to DES.
> 
> Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> ---
>   fs/cifs/Kconfig       |  28 -----
>   fs/cifs/cifs_debug.c  |  11 --
>   fs/cifs/cifs_swn.c    |   2 -
>   fs/cifs/cifsencrypt.c |  81 --------------
>   fs/cifs/cifsfs.c      |   6 -
>   fs/cifs/cifsglob.h    |  32 +-----
>   fs/cifs/cifspdu.h     |  28 -----
>   fs/cifs/cifsproto.h   |  10 --
>   fs/cifs/cifssmb.c     | 106 +-----------------
>   fs/cifs/connect.c     |  32 ------
>   fs/cifs/fs_context.c  |  14 ---
>   fs/cifs/fs_context.h  |   3 -
>   fs/cifs/sess.c        | 255 +-----------------------------------------
>   fs/cifs/smbencrypt.c  | 117 +------------------
>   14 files changed, 5 insertions(+), 720 deletions(-)
> 
> diff --git a/fs/cifs/Kconfig b/fs/cifs/Kconfig
> index 7364950a9ef4..2e8b132efdbc 100644
> --- a/fs/cifs/Kconfig
> +++ b/fs/cifs/Kconfig
> @@ -16,7 +16,6 @@ config CIFS
>   	select CRYPTO_GCM
>   	select CRYPTO_ECB
>   	select CRYPTO_AES
> -	select CRYPTO_LIB_DES
>   	select KEYS
>   	select DNS_RESOLVER
>   	select ASN1
> @@ -85,33 +84,6 @@ config CIFS_ALLOW_INSECURE_LEGACY
>   
>   	  If unsure, say Y.
>   
> -config CIFS_WEAK_PW_HASH
> -	bool "Support legacy servers which use weaker LANMAN security"
> -	depends on CIFS && CIFS_ALLOW_INSECURE_LEGACY
> -	help
> -	  Modern CIFS servers including Samba and most Windows versions
> -	  (since 1997) support stronger NTLM (and even NTLMv2 and Kerberos)
> -	  security mechanisms. These hash the password more securely
> -	  than the mechanisms used in the older LANMAN version of the
> -	  SMB protocol but LANMAN based authentication is needed to
> -	  establish sessions with some old SMB servers.
> -
> -	  Enabling this option allows the cifs module to mount to older
> -	  LANMAN based servers such as OS/2 and Windows 95, but such
> -	  mounts may be less secure than mounts using NTLM or more recent
> -	  security mechanisms if you are on a public network.  Unless you
> -	  have a need to access old SMB servers (and are on a private
> -	  network) you probably want to say N.  Even if this support
> -	  is enabled in the kernel build, LANMAN authentication will not be
> -	  used automatically. At runtime LANMAN mounts are disabled but
> -	  can be set to required (or optional) either in
> -	  /proc/fs/cifs (see Documentation/admin-guide/cifs/usage.rst for
> -	  more detail) or via an option on the mount command. This support
> -	  is disabled by default in order to reduce the possibility of a
> -	  downgrade attack.
> -
> -	  If unsure, say N.
> -
>   config CIFS_UPCALL
>   	bool "Kerberos/SPNEGO advanced session setup"
>   	depends on CIFS
> diff --git a/fs/cifs/cifs_debug.c b/fs/cifs/cifs_debug.c
> index 8857ac7e7a14..51a824fc926a 100644
> --- a/fs/cifs/cifs_debug.c
> +++ b/fs/cifs/cifs_debug.c
> @@ -250,9 +250,6 @@ static int cifs_debug_data_proc_show(struct seq_file *m, void *v)
>   #ifdef CONFIG_CIFS_ALLOW_INSECURE_LEGACY
>   	seq_printf(m, ",ALLOW_INSECURE_LEGACY");
>   #endif
> -#ifdef CONFIG_CIFS_WEAK_PW_HASH
> -	seq_printf(m, ",WEAK_PW_HASH");
> -#endif
>   #ifdef CONFIG_CIFS_POSIX
>   	seq_printf(m, ",CIFS_POSIX");
>   #endif
> @@ -929,14 +926,6 @@ cifs_security_flags_handle_must_flags(unsigned int *flags)
>   		*flags = CIFSSEC_MUST_NTLMSSP;
>   	else if ((*flags & CIFSSEC_MUST_NTLMV2) == CIFSSEC_MUST_NTLMV2)
>   		*flags = CIFSSEC_MUST_NTLMV2;
> -	else if ((*flags & CIFSSEC_MUST_NTLM) == CIFSSEC_MUST_NTLM)
> -		*flags = CIFSSEC_MUST_NTLM;
> -	else if (CIFSSEC_MUST_LANMAN &&
> -		 (*flags & CIFSSEC_MUST_LANMAN) == CIFSSEC_MUST_LANMAN)
> -		*flags = CIFSSEC_MUST_LANMAN;
> -	else if (CIFSSEC_MUST_PLNTXT &&
> -		 (*flags & CIFSSEC_MUST_PLNTXT) == CIFSSEC_MUST_PLNTXT)
> -		*flags = CIFSSEC_MUST_PLNTXT;
>   
>   	*flags |= signflags;
>   }
> diff --git a/fs/cifs/cifs_swn.c b/fs/cifs/cifs_swn.c
> index 93b47818c6c2..12bde7bfda86 100644
> --- a/fs/cifs/cifs_swn.c
> +++ b/fs/cifs/cifs_swn.c
> @@ -147,8 +147,6 @@ static int cifs_swn_send_register_message(struct cifs_swn_reg *swnreg)
>   			goto nlmsg_fail;
>   		}
>   		break;
> -	case LANMAN:
> -	case NTLM:
>   	case NTLMv2:
>   	case RawNTLMSSP:
>   		ret = cifs_swn_auth_info_ntlm(swnreg->tcon, skb);
> diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
> index ecf15d845dbd..7680e0a9bea3 100644
> --- a/fs/cifs/cifsencrypt.c
> +++ b/fs/cifs/cifsencrypt.c
> @@ -250,87 +250,6 @@ int cifs_verify_signature(struct smb_rqst *rqst,
>   
>   }
>   
> -/* first calculate 24 bytes ntlm response and then 16 byte session key */
> -int setup_ntlm_response(struct cifs_ses *ses, const struct nls_table *nls_cp)
> -{
> -	int rc = 0;
> -	unsigned int temp_len = CIFS_SESS_KEY_SIZE + CIFS_AUTH_RESP_SIZE;
> -	char temp_key[CIFS_SESS_KEY_SIZE];
> -
> -	if (!ses)
> -		return -EINVAL;
> -
> -	ses->auth_key.response = kmalloc(temp_len, GFP_KERNEL);
> -	if (!ses->auth_key.response)
> -		return -ENOMEM;
> -
> -	ses->auth_key.len = temp_len;
> -
> -	rc = SMBNTencrypt(ses->password, ses->server->cryptkey,
> -			ses->auth_key.response + CIFS_SESS_KEY_SIZE, nls_cp);
> -	if (rc) {
> -		cifs_dbg(FYI, "%s Can't generate NTLM response, error: %d\n",
> -			 __func__, rc);
> -		return rc;
> -	}
> -
> -	rc = E_md4hash(ses->password, temp_key, nls_cp);
> -	if (rc) {
> -		cifs_dbg(FYI, "%s Can't generate NT hash, error: %d\n",
> -			 __func__, rc);
> -		return rc;
> -	}
> -
> -	rc = mdfour(ses->auth_key.response, temp_key, CIFS_SESS_KEY_SIZE);
> -	if (rc)
> -		cifs_dbg(FYI, "%s Can't generate NTLM session key, error: %d\n",
> -			 __func__, rc);
> -
> -	return rc;
> -}
> -
> -#ifdef CONFIG_CIFS_WEAK_PW_HASH
> -int calc_lanman_hash(const char *password, const char *cryptkey, bool encrypt,
> -			char *lnm_session_key)
> -{
> -	int i, len;
> -	int rc;
> -	char password_with_pad[CIFS_ENCPWD_SIZE] = {0};
> -
> -	if (password) {
> -		for (len = 0; len < CIFS_ENCPWD_SIZE; len++)
> -			if (!password[len])
> -				break;
> -
> -		memcpy(password_with_pad, password, len);
> -	}
> -
> -	if (!encrypt && global_secflags & CIFSSEC_MAY_PLNTXT) {
> -		memcpy(lnm_session_key, password_with_pad,
> -			CIFS_ENCPWD_SIZE);
> -		return 0;
> -	}
> -
> -	/* calculate old style session key */
> -	/* calling toupper is less broken than repeatedly
> -	calling nls_toupper would be since that will never
> -	work for UTF8, but neither handles multibyte code pages
> -	but the only alternative would be converting to UCS-16 (Unicode)
> -	(using a routine something like UniStrupr) then
> -	uppercasing and then converting back from Unicode - which
> -	would only worth doing it if we knew it were utf8. Basically
> -	utf8 and other multibyte codepages each need their own strupper
> -	function since a byte at a time will ont work. */
> -
> -	for (i = 0; i < CIFS_ENCPWD_SIZE; i++)
> -		password_with_pad[i] = toupper(password_with_pad[i]);
> -
> -	rc = SMBencrypt(password_with_pad, cryptkey, lnm_session_key);
> -
> -	return rc;
> -}
> -#endif /* CIFS_WEAK_PW_HASH */
> -
>   /* Build a proper attribute value/target info pairs blob.
>    * Fill in netbios and dns domain name and workstation name
>    * and client time (total five av pairs and + one end of fields indicator.
> diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> index 64b71c4e2a9d..85c884db909d 100644
> --- a/fs/cifs/cifsfs.c
> +++ b/fs/cifs/cifsfs.c
> @@ -438,15 +438,9 @@ cifs_show_security(struct seq_file *s, struct cifs_ses *ses)
>   	seq_puts(s, ",sec=");
>   
>   	switch (ses->sectype) {
> -	case LANMAN:
> -		seq_puts(s, "lanman");
> -		break;
>   	case NTLMv2:
>   		seq_puts(s, "ntlmv2");
>   		break;
> -	case NTLM:
> -		seq_puts(s, "ntlm");
> -		break;
>   	case Kerberos:
>   		seq_puts(s, "krb5");
>   		break;
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index de687a554545..0b821ccfe09f 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -114,8 +114,6 @@ enum statusEnum {
>   
>   enum securityEnum {
>   	Unspecified = 0,	/* not specified */
> -	LANMAN,			/* Legacy LANMAN auth */
> -	NTLM,			/* Legacy NTLM012 auth with NTLM hash */
>   	NTLMv2,			/* Legacy NTLM auth with NTLMv2 hash */
>   	RawNTLMSSP,		/* NTLMSSP without SPNEGO, NTLMv2 hash */
>   	Kerberos,		/* Kerberos via SPNEGO */
> @@ -634,7 +632,6 @@ struct TCP_Server_Info {
>   	struct session_key session_key;
>   	unsigned long lstrp; /* when we got last response from this server */
>   	struct cifs_secmech secmech; /* crypto sec mech functs, descriptors */
> -#define	CIFS_NEGFLAVOR_LANMAN	0	/* wct == 13, LANMAN */
>   #define	CIFS_NEGFLAVOR_UNENCAP	1	/* wct == 17, but no ext_sec */
>   #define	CIFS_NEGFLAVOR_EXTENDED	2	/* wct == 17, ext_sec bit set */
>   	char	negflavor;	/* NEGOTIATE response flavor */
> @@ -1734,16 +1731,8 @@ static inline bool is_retryable_error(int error)
>   
>   /* Security Flags: indicate type of session setup needed */
>   #define   CIFSSEC_MAY_SIGN	0x00001
> -#define   CIFSSEC_MAY_NTLM	0x00002
>   #define   CIFSSEC_MAY_NTLMV2	0x00004
>   #define   CIFSSEC_MAY_KRB5	0x00008
> -#ifdef CONFIG_CIFS_WEAK_PW_HASH
> -#define   CIFSSEC_MAY_LANMAN	0x00010
> -#define   CIFSSEC_MAY_PLNTXT	0x00020
> -#else
> -#define   CIFSSEC_MAY_LANMAN    0
> -#define   CIFSSEC_MAY_PLNTXT    0
> -#endif /* weak passwords */
>   #define   CIFSSEC_MAY_SEAL	0x00040 /* not supported yet */
>   #define   CIFSSEC_MAY_NTLMSSP	0x00080 /* raw ntlmssp with ntlmv2 */
>   
> @@ -1751,32 +1740,19 @@ static inline bool is_retryable_error(int error)
>   /* note that only one of the following can be set so the
>   result of setting MUST flags more than once will be to
>   require use of the stronger protocol */
> -#define   CIFSSEC_MUST_NTLM	0x02002
>   #define   CIFSSEC_MUST_NTLMV2	0x04004
>   #define   CIFSSEC_MUST_KRB5	0x08008
> -#ifdef CONFIG_CIFS_WEAK_PW_HASH
> -#define   CIFSSEC_MUST_LANMAN	0x10010
> -#define   CIFSSEC_MUST_PLNTXT	0x20020
> -#ifdef CONFIG_CIFS_UPCALL
> -#define   CIFSSEC_MASK          0xBF0BF /* allows weak security but also krb5 */
> -#else
> -#define   CIFSSEC_MASK          0xB70B7 /* current flags supported if weak */
> -#endif /* UPCALL */
> -#else /* do not allow weak pw hash */
> -#define   CIFSSEC_MUST_LANMAN	0
> -#define   CIFSSEC_MUST_PLNTXT	0
>   #ifdef CONFIG_CIFS_UPCALL
>   #define   CIFSSEC_MASK          0x8F08F /* flags supported if no weak allowed */
>   #else
>   #define	  CIFSSEC_MASK          0x87087 /* flags supported if no weak allowed */
>   #endif /* UPCALL */
> -#endif /* WEAK_PW_HASH */
>   #define   CIFSSEC_MUST_SEAL	0x40040 /* not supported yet */
>   #define   CIFSSEC_MUST_NTLMSSP	0x80080 /* raw ntlmssp with ntlmv2 */
>   
>   #define   CIFSSEC_DEF (CIFSSEC_MAY_SIGN | CIFSSEC_MAY_NTLMV2 | CIFSSEC_MAY_NTLMSSP)
> -#define   CIFSSEC_MAX (CIFSSEC_MUST_SIGN | CIFSSEC_MUST_NTLMV2)
> -#define   CIFSSEC_AUTH_MASK (CIFSSEC_MAY_NTLM | CIFSSEC_MAY_NTLMV2 | CIFSSEC_MAY_LANMAN | CIFSSEC_MAY_PLNTXT | CIFSSEC_MAY_KRB5 | CIFSSEC_MAY_NTLMSSP)
> +#define   CIFSSEC_MAX (CIFSSEC_MUST_NTLMV2)
> +#define   CIFSSEC_AUTH_MASK (CIFSSEC_MAY_NTLMV2 | CIFSSEC_MAY_KRB5 | CIFSSEC_MAY_NTLMSSP)
>   /*
>    *****************************************************************
>    * All constants go here
> @@ -1940,10 +1916,6 @@ static inline char *get_security_type_str(enum securityEnum sectype)
>   		return "Kerberos";
>   	case NTLMv2:
>   		return "NTLMv2";
> -	case NTLM:
> -		return "NTLM";
> -	case LANMAN:
> -		return "LANMAN";
>   	default:
>   		return "Unknown";
>   	}
> diff --git a/fs/cifs/cifspdu.h b/fs/cifs/cifspdu.h
> index f6e235001358..dc920e206336 100644
> --- a/fs/cifs/cifspdu.h
> +++ b/fs/cifs/cifspdu.h
> @@ -14,13 +14,7 @@
>   #include <asm/unaligned.h>
>   #include "smbfsctl.h"
>   
> -#ifdef CONFIG_CIFS_WEAK_PW_HASH
> -#define LANMAN_PROT 0
> -#define LANMAN2_PROT 1
> -#define CIFS_PROT   2
> -#else
>   #define CIFS_PROT   0
> -#endif
>   #define POSIX_PROT  (CIFS_PROT+1)
>   #define BAD_PROT 0xFFFF
>   
> @@ -505,30 +499,8 @@ typedef struct negotiate_req {
>   	unsigned char DialectsArray[1];
>   } __attribute__((packed)) NEGOTIATE_REQ;
>   
> -/* Dialect index is 13 for LANMAN */
> -
>   #define MIN_TZ_ADJ (15 * 60) /* minimum grid for timezones in seconds */
>   
> -typedef struct lanman_neg_rsp {
> -	struct smb_hdr hdr;	/* wct = 13 */
> -	__le16 DialectIndex;
> -	__le16 SecurityMode;
> -	__le16 MaxBufSize;
> -	__le16 MaxMpxCount;
> -	__le16 MaxNumberVcs;
> -	__le16 RawMode;
> -	__le32 SessionKey;
> -	struct {
> -		__le16 Time;
> -		__le16 Date;
> -	} __attribute__((packed)) SrvTime;
> -	__le16 ServerTimeZone;
> -	__le16 EncryptionKeyLength;
> -	__le16 Reserved;
> -	__u16  ByteCount;
> -	unsigned char EncryptionKey[1];
> -} __attribute__((packed)) LANMAN_NEG_RSP;
> -
>   #define READ_RAW_ENABLE 1
>   #define WRITE_RAW_ENABLE 2
>   #define RAW_ENABLE (READ_RAW_ENABLE | WRITE_RAW_ENABLE)
> diff --git a/fs/cifs/cifsproto.h b/fs/cifs/cifsproto.h
> index e0def0f0714b..f9740c21ca3d 100644
> --- a/fs/cifs/cifsproto.h
> +++ b/fs/cifs/cifsproto.h
> @@ -498,19 +498,12 @@ extern int cifs_sign_smb(struct smb_hdr *, struct TCP_Server_Info *, __u32 *);
>   extern int cifs_verify_signature(struct smb_rqst *rqst,
>   				 struct TCP_Server_Info *server,
>   				__u32 expected_sequence_number);
> -extern int SMBNTencrypt(unsigned char *, unsigned char *, unsigned char *,
> -			const struct nls_table *);
> -extern int setup_ntlm_response(struct cifs_ses *, const struct nls_table *);
>   extern int setup_ntlmv2_rsp(struct cifs_ses *, const struct nls_table *);
>   extern void cifs_crypto_secmech_release(struct TCP_Server_Info *server);
>   extern int calc_seckey(struct cifs_ses *);
>   extern int generate_smb30signingkey(struct cifs_ses *);
>   extern int generate_smb311signingkey(struct cifs_ses *);
>   
> -#ifdef CONFIG_CIFS_WEAK_PW_HASH
> -extern int calc_lanman_hash(const char *password, const char *cryptkey,
> -				bool encrypt, char *lnm_session_key);
> -#endif /* CIFS_WEAK_PW_HASH */
>   extern int CIFSSMBCopy(unsigned int xid,
>   			struct cifs_tcon *source_tcon,
>   			const char *fromName,
> @@ -547,11 +540,8 @@ extern int check_mf_symlink(unsigned int xid, struct cifs_tcon *tcon,
>   			      struct cifs_sb_info *cifs_sb,
>   			      struct cifs_fattr *fattr,
>   			      const unsigned char *path);
> -extern int mdfour(unsigned char *, unsigned char *, int);
>   extern int E_md4hash(const unsigned char *passwd, unsigned char *p16,
>   			const struct nls_table *codepage);
> -extern int SMBencrypt(unsigned char *passwd, const unsigned char *c8,
> -			unsigned char *p24);
>   
>   extern int
>   cifs_setup_volume_info(struct smb3_fs_context *ctx, const char *mntopts, const char *devname);
> diff --git a/fs/cifs/cifssmb.c b/fs/cifs/cifssmb.c
> index 6ab6cf669438..40187d25140f 100644
> --- a/fs/cifs/cifssmb.c
> +++ b/fs/cifs/cifssmb.c
> @@ -42,10 +42,6 @@ static struct {
>   	int index;
>   	char *name;
>   } protocols[] = {
> -#ifdef CONFIG_CIFS_WEAK_PW_HASH
> -	{LANMAN_PROT, "\2LM1.2X002"},
> -	{LANMAN2_PROT, "\2LANMAN2.1"},
> -#endif /* weak password hashing for legacy clients */
>   	{CIFS_PROT, "\2NT LM 0.12"},
>   	{POSIX_PROT, "\2POSIX 2"},
>   	{BAD_PROT, "\2"}
> @@ -55,10 +51,6 @@ static struct {
>   	int index;
>   	char *name;
>   } protocols[] = {
> -#ifdef CONFIG_CIFS_WEAK_PW_HASH
> -	{LANMAN_PROT, "\2LM1.2X002"},
> -	{LANMAN2_PROT, "\2LANMAN2.1"},
> -#endif /* weak password hashing for legacy clients */
>   	{CIFS_PROT, "\2NT LM 0.12"},
>   	{BAD_PROT, "\2"}
>   };
> @@ -66,17 +58,9 @@ static struct {
>   
>   /* define the number of elements in the cifs dialect array */
>   #ifdef CONFIG_CIFS_POSIX
> -#ifdef CONFIG_CIFS_WEAK_PW_HASH
> -#define CIFS_NUM_PROT 4
> -#else
>   #define CIFS_NUM_PROT 2
> -#endif /* CIFS_WEAK_PW_HASH */
>   #else /* not posix */
> -#ifdef CONFIG_CIFS_WEAK_PW_HASH
> -#define CIFS_NUM_PROT 3
> -#else
>   #define CIFS_NUM_PROT 1
> -#endif /* CONFIG_CIFS_WEAK_PW_HASH */
>   #endif /* CIFS_POSIX */
>   
>   /*
> @@ -475,89 +459,6 @@ cifs_enable_signing(struct TCP_Server_Info *server, bool mnt_sign_required)
>   	return 0;
>   }
>   
> -#ifdef CONFIG_CIFS_WEAK_PW_HASH
> -static int
> -decode_lanman_negprot_rsp(struct TCP_Server_Info *server, NEGOTIATE_RSP *pSMBr)
> -{
> -	__s16 tmp;
> -	struct lanman_neg_rsp *rsp = (struct lanman_neg_rsp *)pSMBr;
> -
> -	if (server->dialect != LANMAN_PROT && server->dialect != LANMAN2_PROT)
> -		return -EOPNOTSUPP;
> -
> -	server->sec_mode = le16_to_cpu(rsp->SecurityMode);
> -	server->maxReq = min_t(unsigned int,
> -			       le16_to_cpu(rsp->MaxMpxCount),
> -			       cifs_max_pending);
> -	set_credits(server, server->maxReq);
> -	server->maxBuf = le16_to_cpu(rsp->MaxBufSize);
> -	/* set up max_read for readpages check */
> -	server->max_read = server->maxBuf;
> -	/* even though we do not use raw we might as well set this
> -	accurately, in case we ever find a need for it */
> -	if ((le16_to_cpu(rsp->RawMode) & RAW_ENABLE) == RAW_ENABLE) {
> -		server->max_rw = 0xFF00;
> -		server->capabilities = CAP_MPX_MODE | CAP_RAW_MODE;
> -	} else {
> -		server->max_rw = 0;/* do not need to use raw anyway */
> -		server->capabilities = CAP_MPX_MODE;
> -	}
> -	tmp = (__s16)le16_to_cpu(rsp->ServerTimeZone);
> -	if (tmp == -1) {
> -		/* OS/2 often does not set timezone therefore
> -		 * we must use server time to calc time zone.
> -		 * Could deviate slightly from the right zone.
> -		 * Smallest defined timezone difference is 15 minutes
> -		 * (i.e. Nepal).  Rounding up/down is done to match
> -		 * this requirement.
> -		 */
> -		int val, seconds, remain, result;
> -		struct timespec64 ts;
> -		time64_t utc = ktime_get_real_seconds();
> -		ts = cnvrtDosUnixTm(rsp->SrvTime.Date,
> -				    rsp->SrvTime.Time, 0);
> -		cifs_dbg(FYI, "SrvTime %lld sec since 1970 (utc: %lld) diff: %lld\n",
> -			 ts.tv_sec, utc,
> -			 utc - ts.tv_sec);
> -		val = (int)(utc - ts.tv_sec);
> -		seconds = abs(val);
> -		result = (seconds / MIN_TZ_ADJ) * MIN_TZ_ADJ;
> -		remain = seconds % MIN_TZ_ADJ;
> -		if (remain >= (MIN_TZ_ADJ / 2))
> -			result += MIN_TZ_ADJ;
> -		if (val < 0)
> -			result = -result;
> -		server->timeAdj = result;
> -	} else {
> -		server->timeAdj = (int)tmp;
> -		server->timeAdj *= 60; /* also in seconds */
> -	}
> -	cifs_dbg(FYI, "server->timeAdj: %d seconds\n", server->timeAdj);
> -
> -
> -	/* BB get server time for time conversions and add
> -	code to use it and timezone since this is not UTC */
> -
> -	if (rsp->EncryptionKeyLength ==
> -			cpu_to_le16(CIFS_CRYPTO_KEY_SIZE)) {
> -		memcpy(server->cryptkey, rsp->EncryptionKey,
> -			CIFS_CRYPTO_KEY_SIZE);
> -	} else if (server->sec_mode & SECMODE_PW_ENCRYPT) {
> -		return -EIO; /* need cryptkey unless plain text */
> -	}
> -
> -	cifs_dbg(FYI, "LANMAN negotiated\n");
> -	return 0;
> -}
> -#else
> -static inline int
> -decode_lanman_negprot_rsp(struct TCP_Server_Info *server, NEGOTIATE_RSP *pSMBr)
> -{
> -	cifs_dbg(VFS, "mount failed, cifs module not built with CIFS_WEAK_PW_HASH support\n");
> -	return -EOPNOTSUPP;
> -}
> -#endif
> -
>   static bool
>   should_set_ext_sec_flag(enum securityEnum sectype)
>   {
> @@ -626,16 +527,12 @@ CIFSSMBNegotiate(const unsigned int xid, struct cifs_ses *ses)
>   	server->dialect = le16_to_cpu(pSMBr->DialectIndex);
>   	cifs_dbg(FYI, "Dialect: %d\n", server->dialect);
>   	/* Check wct = 1 error case */
> -	if ((pSMBr->hdr.WordCount < 13) || (server->dialect == BAD_PROT)) {
> +	if ((pSMBr->hdr.WordCount <= 13) || (server->dialect == BAD_PROT)) {
>   		/* core returns wct = 1, but we do not ask for core - otherwise
>   		small wct just comes when dialect index is -1 indicating we
>   		could not negotiate a common dialect */
>   		rc = -EOPNOTSUPP;
>   		goto neg_err_exit;
> -	} else if (pSMBr->hdr.WordCount == 13) {
> -		server->negflavor = CIFS_NEGFLAVOR_LANMAN;
> -		rc = decode_lanman_negprot_rsp(server, pSMBr);
> -		goto signing_check;
>   	} else if (pSMBr->hdr.WordCount != 17) {
>   		/* unknown wct */
>   		rc = -EOPNOTSUPP;
> @@ -677,7 +574,6 @@ CIFSSMBNegotiate(const unsigned int xid, struct cifs_ses *ses)
>   		server->capabilities &= ~CAP_EXTENDED_SECURITY;
>   	}
>   
> -signing_check:
>   	if (!rc)
>   		rc = cifs_enable_signing(server, ses->sign);
>   neg_err_exit:
> diff --git a/fs/cifs/connect.c b/fs/cifs/connect.c
> index 3781eee9360a..0db344807ef1 100644
> --- a/fs/cifs/connect.c
> +++ b/fs/cifs/connect.c
> @@ -3684,38 +3684,6 @@ CIFSTCon(const unsigned int xid, struct cifs_ses *ses,
>   		*bcc_ptr = 0; /* password is null byte */
>   		bcc_ptr++;              /* skip password */
>   		/* already aligned so no need to do it below */
> -	} else {
> -		pSMB->PasswordLength = cpu_to_le16(CIFS_AUTH_RESP_SIZE);
> -		/* BB FIXME add code to fail this if NTLMv2 or Kerberos
> -		   specified as required (when that support is added to
> -		   the vfs in the future) as only NTLM or the much
> -		   weaker LANMAN (which we do not send by default) is accepted
> -		   by Samba (not sure whether other servers allow
> -		   NTLMv2 password here) */
> -#ifdef CONFIG_CIFS_WEAK_PW_HASH
> -		if ((global_secflags & CIFSSEC_MAY_LANMAN) &&
> -		    (ses->sectype == LANMAN))
> -			calc_lanman_hash(tcon->password, ses->server->cryptkey,
> -					 ses->server->sec_mode &
> -					    SECMODE_PW_ENCRYPT ? true : false,
> -					 bcc_ptr);
> -		else
> -#endif /* CIFS_WEAK_PW_HASH */
> -		rc = SMBNTencrypt(tcon->password, ses->server->cryptkey,
> -					bcc_ptr, nls_codepage);
> -		if (rc) {
> -			cifs_dbg(FYI, "%s Can't generate NTLM rsp. Error: %d\n",
> -				 __func__, rc);
> -			cifs_buf_release(smb_buffer);
> -			return rc;
> -		}
> -
> -		bcc_ptr += CIFS_AUTH_RESP_SIZE;
> -		if (ses->capabilities & CAP_UNICODE) {
> -			/* must align unicode strings */
> -			*bcc_ptr = 0; /* null byte password */
> -			bcc_ptr++;
> -		}
>   	}
>   
>   	if (ses->server->sign)
> diff --git a/fs/cifs/fs_context.c b/fs/cifs/fs_context.c
> index eed59bc1d913..4515a0883262 100644
> --- a/fs/cifs/fs_context.c
> +++ b/fs/cifs/fs_context.c
> @@ -57,12 +57,9 @@ static const match_table_t cifs_secflavor_tokens = {
>   	{ Opt_sec_krb5p, "krb5p" },
>   	{ Opt_sec_ntlmsspi, "ntlmsspi" },
>   	{ Opt_sec_ntlmssp, "ntlmssp" },
> -	{ Opt_ntlm, "ntlm" },
> -	{ Opt_sec_ntlmi, "ntlmi" },
>   	{ Opt_sec_ntlmv2, "nontlm" },
>   	{ Opt_sec_ntlmv2, "ntlmv2" },
>   	{ Opt_sec_ntlmv2i, "ntlmv2i" },
> -	{ Opt_sec_lanman, "lanman" },
>   	{ Opt_sec_none, "none" },
>   
>   	{ Opt_sec_err, NULL }
> @@ -221,23 +218,12 @@ cifs_parse_security_flavors(struct fs_context *fc, char *value, struct smb3_fs_c
>   	case Opt_sec_ntlmssp:
>   		ctx->sectype = RawNTLMSSP;
>   		break;
> -	case Opt_sec_ntlmi:
> -		ctx->sign = true;
> -		fallthrough;
> -	case Opt_ntlm:
> -		ctx->sectype = NTLM;
> -		break;
>   	case Opt_sec_ntlmv2i:
>   		ctx->sign = true;
>   		fallthrough;
>   	case Opt_sec_ntlmv2:
>   		ctx->sectype = NTLMv2;
>   		break;
> -#ifdef CONFIG_CIFS_WEAK_PW_HASH
> -	case Opt_sec_lanman:
> -		ctx->sectype = LANMAN;
> -		break;
> -#endif
>   	case Opt_sec_none:
>   		ctx->nullauth = 1;
>   		break;
> diff --git a/fs/cifs/fs_context.h b/fs/cifs/fs_context.h
> index b6243972edf3..a42ba71d7a81 100644
> --- a/fs/cifs/fs_context.h
> +++ b/fs/cifs/fs_context.h
> @@ -47,11 +47,8 @@ enum cifs_sec_param {
>   	Opt_sec_krb5p,
>   	Opt_sec_ntlmsspi,
>   	Opt_sec_ntlmssp,
> -	Opt_ntlm,
> -	Opt_sec_ntlmi,
>   	Opt_sec_ntlmv2,
>   	Opt_sec_ntlmv2i,
> -	Opt_sec_lanman,
>   	Opt_sec_none,
>   
>   	Opt_sec_err
> diff --git a/fs/cifs/sess.c b/fs/cifs/sess.c
> index c5785fd3f52e..bb4a838eef71 100644
> --- a/fs/cifs/sess.c
> +++ b/fs/cifs/sess.c
> @@ -799,30 +799,16 @@ cifs_select_sectype(struct TCP_Server_Info *server, enum securityEnum requested)
>   		}
>   	case CIFS_NEGFLAVOR_UNENCAP:
>   		switch (requested) {
> -		case NTLM:
>   		case NTLMv2:
>   			return requested;
>   		case Unspecified:
>   			if (global_secflags & CIFSSEC_MAY_NTLMV2)
>   				return NTLMv2;
> -			if (global_secflags & CIFSSEC_MAY_NTLM)
> -				return NTLM;
>   			break;
>   		default:
>   			break;
>   		}
> -		fallthrough;	/* to attempt LANMAN authentication next */
> -	case CIFS_NEGFLAVOR_LANMAN:
> -		switch (requested) {
> -		case LANMAN:
> -			return requested;
> -		case Unspecified:
> -			if (global_secflags & CIFSSEC_MAY_LANMAN)
> -				return LANMAN;
> -			fallthrough;
> -		default:
> -			return Unspecified;
> -		}
> +		fallthrough;
>   	default:
>   		return Unspecified;
>   	}
> @@ -947,230 +933,6 @@ sess_sendreceive(struct sess_data *sess_data)
>   	return rc;
>   }
>   
> -/*
> - * LANMAN and plaintext are less secure and off by default.
> - * So we make this explicitly be turned on in kconfig (in the
> - * build) and turned on at runtime (changed from the default)
> - * in proc/fs/cifs or via mount parm.  Unfortunately this is
> - * needed for old Win (e.g. Win95), some obscure NAS and OS/2
> - */
> -#ifdef CONFIG_CIFS_WEAK_PW_HASH
> -static void
> -sess_auth_lanman(struct sess_data *sess_data)
> -{
> -	int rc = 0;
> -	struct smb_hdr *smb_buf;
> -	SESSION_SETUP_ANDX *pSMB;
> -	char *bcc_ptr;
> -	struct cifs_ses *ses = sess_data->ses;
> -	char lnm_session_key[CIFS_AUTH_RESP_SIZE];
> -	__u16 bytes_remaining;
> -
> -	/* lanman 2 style sessionsetup */
> -	/* wct = 10 */
> -	rc = sess_alloc_buffer(sess_data, 10);
> -	if (rc)
> -		goto out;
> -
> -	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
> -	bcc_ptr = sess_data->iov[2].iov_base;
> -	(void)cifs_ssetup_hdr(ses, pSMB);
> -
> -	pSMB->req.hdr.Flags2 &= ~SMBFLG2_UNICODE;
> -
> -	if (ses->user_name != NULL) {
> -		/* no capabilities flags in old lanman negotiation */
> -		pSMB->old_req.PasswordLength = cpu_to_le16(CIFS_AUTH_RESP_SIZE);
> -
> -		/* Calculate hash with password and copy into bcc_ptr.
> -		 * Encryption Key (stored as in cryptkey) gets used if the
> -		 * security mode bit in Negotiate Protocol response states
> -		 * to use challenge/response method (i.e. Password bit is 1).
> -		 */
> -		rc = calc_lanman_hash(ses->password, ses->server->cryptkey,
> -				      ses->server->sec_mode & SECMODE_PW_ENCRYPT ?
> -				      true : false, lnm_session_key);
> -		if (rc)
> -			goto out;
> -
> -		memcpy(bcc_ptr, (char *)lnm_session_key, CIFS_AUTH_RESP_SIZE);
> -		bcc_ptr += CIFS_AUTH_RESP_SIZE;
> -	} else {
> -		pSMB->old_req.PasswordLength = 0;
> -	}
> -
> -	/*
> -	 * can not sign if LANMAN negotiated so no need
> -	 * to calculate signing key? but what if server
> -	 * changed to do higher than lanman dialect and
> -	 * we reconnected would we ever calc signing_key?
> -	 */
> -
> -	cifs_dbg(FYI, "Negotiating LANMAN setting up strings\n");
> -	/* Unicode not allowed for LANMAN dialects */
> -	ascii_ssetup_strings(&bcc_ptr, ses, sess_data->nls_cp);
> -
> -	sess_data->iov[2].iov_len = (long) bcc_ptr -
> -			(long) sess_data->iov[2].iov_base;
> -
> -	rc = sess_sendreceive(sess_data);
> -	if (rc)
> -		goto out;
> -
> -	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
> -	smb_buf = (struct smb_hdr *)sess_data->iov[0].iov_base;
> -
> -	/* lanman response has a word count of 3 */
> -	if (smb_buf->WordCount != 3) {
> -		rc = -EIO;
> -		cifs_dbg(VFS, "bad word count %d\n", smb_buf->WordCount);
> -		goto out;
> -	}
> -
> -	if (le16_to_cpu(pSMB->resp.Action) & GUEST_LOGIN)
> -		cifs_dbg(FYI, "Guest login\n"); /* BB mark SesInfo struct? */
> -
> -	ses->Suid = smb_buf->Uid;   /* UID left in wire format (le) */
> -	cifs_dbg(FYI, "UID = %llu\n", ses->Suid);
> -
> -	bytes_remaining = get_bcc(smb_buf);
> -	bcc_ptr = pByteArea(smb_buf);
> -
> -	/* BB check if Unicode and decode strings */
> -	if (bytes_remaining == 0) {
> -		/* no string area to decode, do nothing */
> -	} else if (smb_buf->Flags2 & SMBFLG2_UNICODE) {
> -		/* unicode string area must be word-aligned */
> -		if (((unsigned long) bcc_ptr - (unsigned long) smb_buf) % 2) {
> -			++bcc_ptr;
> -			--bytes_remaining;
> -		}
> -		decode_unicode_ssetup(&bcc_ptr, bytes_remaining, ses,
> -				      sess_data->nls_cp);
> -	} else {
> -		decode_ascii_ssetup(&bcc_ptr, bytes_remaining, ses,
> -				    sess_data->nls_cp);
> -	}
> -
> -	rc = sess_establish_session(sess_data);
> -out:
> -	sess_data->result = rc;
> -	sess_data->func = NULL;
> -	sess_free_buffer(sess_data);
> -}
> -
> -#endif
> -
> -static void
> -sess_auth_ntlm(struct sess_data *sess_data)
> -{
> -	int rc = 0;
> -	struct smb_hdr *smb_buf;
> -	SESSION_SETUP_ANDX *pSMB;
> -	char *bcc_ptr;
> -	struct cifs_ses *ses = sess_data->ses;
> -	__u32 capabilities;
> -	__u16 bytes_remaining;
> -
> -	/* old style NTLM sessionsetup */
> -	/* wct = 13 */
> -	rc = sess_alloc_buffer(sess_data, 13);
> -	if (rc)
> -		goto out;
> -
> -	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
> -	bcc_ptr = sess_data->iov[2].iov_base;
> -	capabilities = cifs_ssetup_hdr(ses, pSMB);
> -
> -	pSMB->req_no_secext.Capabilities = cpu_to_le32(capabilities);
> -	if (ses->user_name != NULL) {
> -		pSMB->req_no_secext.CaseInsensitivePasswordLength =
> -				cpu_to_le16(CIFS_AUTH_RESP_SIZE);
> -		pSMB->req_no_secext.CaseSensitivePasswordLength =
> -				cpu_to_le16(CIFS_AUTH_RESP_SIZE);
> -
> -		/* calculate ntlm response and session key */
> -		rc = setup_ntlm_response(ses, sess_data->nls_cp);
> -		if (rc) {
> -			cifs_dbg(VFS, "Error %d during NTLM authentication\n",
> -					 rc);
> -			goto out;
> -		}
> -
> -		/* copy ntlm response */
> -		memcpy(bcc_ptr, ses->auth_key.response + CIFS_SESS_KEY_SIZE,
> -				CIFS_AUTH_RESP_SIZE);
> -		bcc_ptr += CIFS_AUTH_RESP_SIZE;
> -		memcpy(bcc_ptr, ses->auth_key.response + CIFS_SESS_KEY_SIZE,
> -				CIFS_AUTH_RESP_SIZE);
> -		bcc_ptr += CIFS_AUTH_RESP_SIZE;
> -	} else {
> -		pSMB->req_no_secext.CaseInsensitivePasswordLength = 0;
> -		pSMB->req_no_secext.CaseSensitivePasswordLength = 0;
> -	}
> -
> -	if (ses->capabilities & CAP_UNICODE) {
> -		/* unicode strings must be word aligned */
> -		if (sess_data->iov[0].iov_len % 2) {
> -			*bcc_ptr = 0;
> -			bcc_ptr++;
> -		}
> -		unicode_ssetup_strings(&bcc_ptr, ses, sess_data->nls_cp);
> -	} else {
> -		ascii_ssetup_strings(&bcc_ptr, ses, sess_data->nls_cp);
> -	}
> -
> -
> -	sess_data->iov[2].iov_len = (long) bcc_ptr -
> -			(long) sess_data->iov[2].iov_base;
> -
> -	rc = sess_sendreceive(sess_data);
> -	if (rc)
> -		goto out;
> -
> -	pSMB = (SESSION_SETUP_ANDX *)sess_data->iov[0].iov_base;
> -	smb_buf = (struct smb_hdr *)sess_data->iov[0].iov_base;
> -
> -	if (smb_buf->WordCount != 3) {
> -		rc = -EIO;
> -		cifs_dbg(VFS, "bad word count %d\n", smb_buf->WordCount);
> -		goto out;
> -	}
> -
> -	if (le16_to_cpu(pSMB->resp.Action) & GUEST_LOGIN)
> -		cifs_dbg(FYI, "Guest login\n"); /* BB mark SesInfo struct? */
> -
> -	ses->Suid = smb_buf->Uid;   /* UID left in wire format (le) */
> -	cifs_dbg(FYI, "UID = %llu\n", ses->Suid);
> -
> -	bytes_remaining = get_bcc(smb_buf);
> -	bcc_ptr = pByteArea(smb_buf);
> -
> -	/* BB check if Unicode and decode strings */
> -	if (bytes_remaining == 0) {
> -		/* no string area to decode, do nothing */
> -	} else if (smb_buf->Flags2 & SMBFLG2_UNICODE) {
> -		/* unicode string area must be word-aligned */
> -		if (((unsigned long) bcc_ptr - (unsigned long) smb_buf) % 2) {
> -			++bcc_ptr;
> -			--bytes_remaining;
> -		}
> -		decode_unicode_ssetup(&bcc_ptr, bytes_remaining, ses,
> -				      sess_data->nls_cp);
> -	} else {
> -		decode_ascii_ssetup(&bcc_ptr, bytes_remaining, ses,
> -				    sess_data->nls_cp);
> -	}
> -
> -	rc = sess_establish_session(sess_data);
> -out:
> -	sess_data->result = rc;
> -	sess_data->func = NULL;
> -	sess_free_buffer(sess_data);
> -	kfree(ses->auth_key.response);
> -	ses->auth_key.response = NULL;
> -}
> -
>   static void
>   sess_auth_ntlmv2(struct sess_data *sess_data)
>   {
> @@ -1675,21 +1437,6 @@ static int select_sec(struct cifs_ses *ses, struct sess_data *sess_data)
>   	}
>   
>   	switch (type) {
> -	case LANMAN:
> -		/* LANMAN and plaintext are less secure and off by default.
> -		 * So we make this explicitly be turned on in kconfig (in the
> -		 * build) and turned on at runtime (changed from the default)
> -		 * in proc/fs/cifs or via mount parm.  Unfortunately this is
> -		 * needed for old Win (e.g. Win95), some obscure NAS and OS/2 */
> -#ifdef CONFIG_CIFS_WEAK_PW_HASH
> -		sess_data->func = sess_auth_lanman;
> -		break;
> -#else
> -		return -EOPNOTSUPP;
> -#endif
> -	case NTLM:
> -		sess_data->func = sess_auth_ntlm;
> -		break;
>   	case NTLMv2:
>   		sess_data->func = sess_auth_ntlmv2;
>   		break;
> diff --git a/fs/cifs/smbencrypt.c b/fs/cifs/smbencrypt.c
> index 39a938443e3e..5da7eea3323f 100644
> --- a/fs/cifs/smbencrypt.c
> +++ b/fs/cifs/smbencrypt.c
> @@ -18,7 +18,6 @@
>   #include <linux/string.h>
>   #include <linux/kernel.h>
>   #include <linux/random.h>
> -#include <crypto/des.h>
>   #include "cifs_fs_sb.h"
>   #include "cifs_unicode.h"
>   #include "cifspdu.h"
> @@ -38,74 +37,8 @@
>   #define SSVALX(buf,pos,val) (CVAL(buf,pos)=(val)&0xFF,CVAL(buf,pos+1)=(val)>>8)
>   #define SSVAL(buf,pos,val) SSVALX((buf),(pos),((__u16)(val)))
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
> -	str_to_key(key, key2);
> -
> -	if (fips_enabled) {
> -		cifs_dbg(VFS, "FIPS compliance enabled: DES not permitted\n");
> -		return -ENOENT;
> -	}
> -
> -	des_expand_key(&ctx, key2, DES_KEY_SIZE);
> -	des_encrypt(&ctx, out, in);
> -	memzero_explicit(&ctx, sizeof(ctx));
> -
> -	return 0;
> -}
> -
> -static int
> -E_P16(unsigned char *p14, unsigned char *p16)
> -{
> -	int rc;
> -	unsigned char sp8[8] =
> -	    { 0x4b, 0x47, 0x53, 0x21, 0x40, 0x23, 0x24, 0x25 };
> -
> -	rc = smbhash(p16, sp8, p14);
> -	if (rc)
> -		return rc;
> -	rc = smbhash(p16 + 8, sp8, p14 + 7);
> -	return rc;
> -}
> -
> -static int
> -E_P24(unsigned char *p21, const unsigned char *c8, unsigned char *p24)
> -{
> -	int rc;
> -
> -	rc = smbhash(p24, c8, p21);
> -	if (rc)
> -		return rc;
> -	rc = smbhash(p24 + 8, c8, p21 + 7);
> -	if (rc)
> -		return rc;
> -	rc = smbhash(p24 + 16, c8, p21 + 14);
> -	return rc;
> -}
> -
>   /* produce a md4 message digest from data of length n bytes */
> -int
> +static int
>   mdfour(unsigned char *md4_hash, unsigned char *link_str, int link_len)
>   {
>   	int rc;
> @@ -135,32 +68,6 @@ mdfour(unsigned char *md4_hash, unsigned char *link_str, int link_len)
>   	return rc;
>   }
>   
> -/*
> -   This implements the X/Open SMB password encryption
> -   It takes a password, a 8 byte "crypt key" and puts 24 bytes of
> -   encrypted password into p24 */
> -/* Note that password must be uppercased and null terminated */
> -int
> -SMBencrypt(unsigned char *passwd, const unsigned char *c8, unsigned char *p24)
> -{
> -	int rc;
> -	unsigned char p14[14], p16[16], p21[21];
> -
> -	memset(p14, '\0', 14);
> -	memset(p16, '\0', 16);
> -	memset(p21, '\0', 21);
> -
> -	memcpy(p14, passwd, 14);
> -	rc = E_P16(p14, p16);
> -	if (rc)
> -		return rc;
> -
> -	memcpy(p21, p16, 16);
> -	rc = E_P24(p21, c8, p24);
> -
> -	return rc;
> -}
> -
>   /*
>    * Creates the MD4 Hash of the users password in NT UNICODE.
>    */
> @@ -186,25 +93,3 @@ E_md4hash(const unsigned char *passwd, unsigned char *p16,
>   
>   	return rc;
>   }
> -
> -/* Does the NT MD4 hash then des encryption. */
> -int
> -SMBNTencrypt(unsigned char *passwd, unsigned char *c8, unsigned char *p24,
> -		const struct nls_table *codepage)
> -{
> -	int rc;
> -	unsigned char p16[16], p21[21];
> -
> -	memset(p16, '\0', 16);
> -	memset(p21, '\0', 21);
> -
> -	rc = E_md4hash(passwd, p16, codepage);
> -	if (rc) {
> -		cifs_dbg(FYI, "%s Can't generate NT hash, error: %d\n",
> -			 __func__, rc);
> -		return rc;
> -	}
> -	memcpy(p21, p16, 16);
> -	rc = E_P24(p21, c8, p24);
> -	return rc;
> -}
> 
