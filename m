Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 476F11932EA
	for <lists+linux-cifs@lfdr.de>; Wed, 25 Mar 2020 22:39:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726947AbgCYVjs (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 25 Mar 2020 17:39:48 -0400
Received: from mail-lf1-f65.google.com ([209.85.167.65]:35512 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726081AbgCYVjs (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 25 Mar 2020 17:39:48 -0400
Received: by mail-lf1-f65.google.com with SMTP id t16so2285216lfl.2;
        Wed, 25 Mar 2020 14:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=vhgziHWNnGTKbEdo6ONanwBqvFeu0tKyMSevlBBoFls=;
        b=pnMICQnFK4uWO2jhCdyM9YRHyKbIXwpxe5qnIplPvGdvIIWT9AZwWThQmINBGJFaey
         Gzxu2ZDRUwP3F5cGymKYT6VnilRk8jrbpNJsJ7cPOIqtcLePVG6sCKOiKSxlNn7LGReH
         rkd45aCZznq8yjQtJ6Afyw8X/25keATgF9g3BKqC6CNihrH7yzc2sjZ3hnzlEWJqKrN9
         DOWQG6AgyN3SSk4pvbplPIfA9WbHrzJeuJL1nFo4ORxPZne/vxMII8TciWx3x//Zadbt
         4oRMb1W+1z1q3nAYdnNZsMd6fjsDBUdPzeLOykVZODlGR/XxwS9ZxdFh6KAVPo8lHjDg
         mx6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vhgziHWNnGTKbEdo6ONanwBqvFeu0tKyMSevlBBoFls=;
        b=RIcRBtArrQVS2e+cIApK2B94GC3nSLltKcxJ+1f67IqwcqsDx42Q5J34ZfKgug+mKW
         cTd41y/+/5Ii9POL/Itiat8xC5B1GUgYqgg8OMYs+5jnJyOUhqCy8ozdeq3QFA+AzMXA
         76e362vkeHpTS5pBgmny0DBElxCihzkA8oOEjnpTDMrS7l9jkoxmK/KqWxc5u4r33tiR
         9XfQucn9c0xJzKwf3fZtFSxx0zn/iyf/Rt1PRV5zv3oC/uLu6vP5CJVLUywFC5KhzwA0
         5149YDa8MT5aoMrr9hQO2zxOK8XMaXr/+AIfDoXnH6syyjXsMAjb7XpuSojZ1UcFiuHi
         JDKg==
X-Gm-Message-State: ANhLgQ3ygsXYafvgn0VS4dBb1nqI97UDI4qe0TicIQjNK12MIFx9Y3sj
        IrwMNCHSuVZ8x4qOu4dlKZABb29wSB289qGoaw==
X-Google-Smtp-Source: ADFU+vttN9Q4h/VtaSj5PLgxlxQqm6ZwZ7bZ1XU5lpc6mtfhqvB/PySTqwvsfKTw56C84PJPezIzIzB4emWHnzLyggU=
X-Received: by 2002:a19:c6cf:: with SMTP id w198mr3666214lff.86.1585172382688;
 Wed, 25 Mar 2020 14:39:42 -0700 (PDT)
MIME-Version: 1.0
References: <1585159997-115196-1-git-send-email-longli@linuxonhyperv.com>
In-Reply-To: <1585159997-115196-1-git-send-email-longli@linuxonhyperv.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Wed, 25 Mar 2020 14:39:30 -0700
Message-ID: <CAKywueQWcjWP7FNG0y-gGOSV5S1kSKJfWpspwXVzY9S2oHh+zQ@mail.gmail.com>
Subject: Re: [PATCH] cifs: Remove locking in smb2_verify_signature() when
 calculating SMB2/SMB3 signature on receiving packets
To:     Long Li <longli@microsoft.com>
Cc:     Steve French <sfrench@samba.org>,
        linux-cifs <linux-cifs@vger.kernel.org>,
        samba-technical <samba-technical@lists.samba.org>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

=D1=81=D1=80, 25 =D0=BC=D0=B0=D1=80. 2020 =D0=B3. =D0=B2 11:15, <longli@lin=
uxonhyperv.com>:
>
> From: Long Li <longli@microsoft.com>
>
> On the sending and receiving paths, CIFS uses the same cypto data structu=
res
> to calculate SMB2/SMB3 packet signatures. A lock on the receiving path is
> necessary to control shared access to crypto data structures. This lock
> degrades performance because it races with the sending path.
>
> Define separate crypto data structures for sending and receiving paths an=
d
> remove this lock.
>
> Signed-off-by: Long Li <longli@microsoft.com>
> ---
>  fs/cifs/cifsencrypt.c   |  29 +++++----
>  fs/cifs/cifsglob.h      |  21 +++++--
>  fs/cifs/smb2proto.h     |   4 +-
>  fs/cifs/smb2transport.c | 130 +++++++++++++++++++++++++---------------
>  4 files changed, 119 insertions(+), 65 deletions(-)
>
> diff --git a/fs/cifs/cifsencrypt.c b/fs/cifs/cifsencrypt.c
> index 97b7497c13ef..222e8d13302c 100644
> --- a/fs/cifs/cifsencrypt.c
> +++ b/fs/cifs/cifsencrypt.c
> @@ -804,16 +804,27 @@ calc_seckey(struct cifs_ses *ses)
>  void
>  cifs_crypto_secmech_release(struct TCP_Server_Info *server)
>  {
> -       if (server->secmech.cmacaes) {
> -               crypto_free_shash(server->secmech.cmacaes);
> -               server->secmech.cmacaes =3D NULL;
> -       }
> +       int i;
> +
> +       for (i =3D CIFS_SECMECH_DIR_IN; i < CIFS_SECMECH_DIR_MAX; i++) {
> +               if (server->secmech.cmacaes[i]) {
> +                       crypto_free_shash(server->secmech.cmacaes[i]);
> +                       server->secmech.cmacaes[i] =3D NULL;
> +               }
>
> -       if (server->secmech.hmacsha256) {
> -               crypto_free_shash(server->secmech.hmacsha256);
> -               server->secmech.hmacsha256 =3D NULL;
> +               if (server->secmech.hmacsha256[i]) {
> +                       crypto_free_shash(server->secmech.hmacsha256[i]);
> +                       server->secmech.hmacsha256[i] =3D NULL;
> +               }
> +
> +               kfree(server->secmech.sdesccmacaes[i]);
> +               server->secmech.sdesccmacaes[i] =3D NULL;
> +
> +               kfree(server->secmech.sdeschmacsha256[i]);
> +               server->secmech.sdeschmacsha256[i] =3D NULL;
>         }
>
> +
>         if (server->secmech.md5) {
>                 crypto_free_shash(server->secmech.md5);
>                 server->secmech.md5 =3D NULL;
> @@ -839,10 +850,6 @@ cifs_crypto_secmech_release(struct TCP_Server_Info *=
server)
>                 server->secmech.ccmaesdecrypt =3D NULL;
>         }
>
> -       kfree(server->secmech.sdesccmacaes);
> -       server->secmech.sdesccmacaes =3D NULL;
> -       kfree(server->secmech.sdeschmacsha256);
> -       server->secmech.sdeschmacsha256 =3D NULL;
>         kfree(server->secmech.sdeschmacmd5);
>         server->secmech.sdeschmacmd5 =3D NULL;
>         kfree(server->secmech.sdescmd5);
> diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> index 0d956360e984..e31a902ebadc 100644
> --- a/fs/cifs/cifsglob.h
> +++ b/fs/cifs/cifsglob.h
> @@ -137,17 +137,27 @@ struct sdesc {
>         char ctx[];
>  };
>
> +enum {
> +       CIFS_SECMECH_DIR_IN =3D 0,
> +       CIFS_SECMECH_DIR_OUT,
> +       CIFS_SECMECH_DIR_MAX
> +};
> +
>  /* crypto hashing related structure/fields, not specific to a sec mech *=
/
>  struct cifs_secmech {
>         struct crypto_shash *hmacmd5; /* hmac-md5 hash function */
>         struct crypto_shash *md5; /* md5 hash function */
> -       struct crypto_shash *hmacsha256; /* hmac-sha256 hash function */
> -       struct crypto_shash *cmacaes; /* block-cipher based MAC function =
*/
> +       /* hmac-sha256 hash functions */
> +       struct crypto_shash *hmacsha256[CIFS_SECMECH_DIR_MAX];
> +       /* block-cipher based MAC function */
> +       struct crypto_shash *cmacaes[CIFS_SECMECH_DIR_MAX];
>         struct crypto_shash *sha512; /* sha512 hash function */
>         struct sdesc *sdeschmacmd5;  /* ctxt to generate ntlmv2 hash, CR1=
 */
>         struct sdesc *sdescmd5; /* ctxt to generate cifs/smb signature */
> -       struct sdesc *sdeschmacsha256;  /* ctxt to generate smb2 signatur=
e */
> -       struct sdesc *sdesccmacaes;  /* ctxt to generate smb3 signature *=
/
> +       /* ctxt to generate smb2 signature */
> +       struct sdesc *sdeschmacsha256[CIFS_SECMECH_DIR_MAX];
> +       /* ctxt to generate smb3 signature */
> +       struct sdesc *sdesccmacaes[CIFS_SECMECH_DIR_MAX];
>         struct sdesc *sdescsha512; /* ctxt to generate smb3.11 signing ke=
y */
>         struct crypto_aead *ccmaesencrypt; /* smb3 encryption aead */
>         struct crypto_aead *ccmaesdecrypt; /* smb3 decryption aead */
> @@ -426,7 +436,8 @@ struct smb_version_operations {
>         /* generate new lease key */
>         void (*new_lease_key)(struct cifs_fid *);
>         int (*generate_signingkey)(struct cifs_ses *);
> -       int (*calc_signature)(struct smb_rqst *, struct TCP_Server_Info *=
);
> +       int (*calc_signature)(struct smb_rqst *, struct TCP_Server_Info *=
,
> +                             int direction);
>         int (*set_integrity)(const unsigned int, struct cifs_tcon *tcon,
>                              struct cifsFileInfo *src_file);
>         int (*enum_snapshots)(const unsigned int xid, struct cifs_tcon *t=
con,
> diff --git a/fs/cifs/smb2proto.h b/fs/cifs/smb2proto.h
> index 4d1ff7b66fdc..f5edd6ea3639 100644
> --- a/fs/cifs/smb2proto.h
> +++ b/fs/cifs/smb2proto.h
> @@ -55,9 +55,9 @@ extern struct cifs_ses *smb2_find_smb_ses(struct TCP_Se=
rver_Info *server,
>  extern struct cifs_tcon *smb2_find_smb_tcon(struct TCP_Server_Info *serv=
er,
>                                                 __u64 ses_id, __u32  tid)=
;
>  extern int smb2_calc_signature(struct smb_rqst *rqst,
> -                               struct TCP_Server_Info *server);
> +                               struct TCP_Server_Info *server, int direc=
tion);
>  extern int smb3_calc_signature(struct smb_rqst *rqst,
> -                               struct TCP_Server_Info *server);
> +                               struct TCP_Server_Info *server, int direc=
tion);
>  extern void smb2_echo_request(struct work_struct *work);
>  extern __le32 smb2_get_lease_state(struct cifsInodeInfo *cinode);
>  extern bool smb2_is_valid_oplock_break(char *buffer,
> diff --git a/fs/cifs/smb2transport.c b/fs/cifs/smb2transport.c
> index 08b703b7a15e..c8ba40d8fedf 100644
> --- a/fs/cifs/smb2transport.c
> +++ b/fs/cifs/smb2transport.c
> @@ -43,30 +43,51 @@
>  static int
>  smb2_crypto_shash_allocate(struct TCP_Server_Info *server)
>  {
> -       return cifs_alloc_hash("hmac(sha256)",
> -                              &server->secmech.hmacsha256,
> -                              &server->secmech.sdeschmacsha256);
> +       int i, rc;
> +
> +       for (i =3D CIFS_SECMECH_DIR_IN; i < CIFS_SECMECH_DIR_MAX; i++) {
> +               rc =3D cifs_alloc_hash("hmac(sha256)",
> +                              &server->secmech.hmacsha256[i],
> +                              &server->secmech.sdeschmacsha256[i]);
> +               if (rc)
> +                       goto fail;
> +       }
> +       return 0;
> +
> +fail:
> +       for (i =3D CIFS_SECMECH_DIR_IN; i < CIFS_SECMECH_DIR_MAX; i++)
> +               cifs_free_hash(
> +                      &server->secmech.hmacsha256[i],
> +                      &server->secmech.sdeschmacsha256[i]);
> +       return rc;
>  }
>
>  static int
>  smb3_crypto_shash_allocate(struct TCP_Server_Info *server)
>  {
>         struct cifs_secmech *p =3D &server->secmech;
> -       int rc;
> +       int i, rc;
>
> -       rc =3D cifs_alloc_hash("hmac(sha256)",
> -                            &p->hmacsha256,
> -                            &p->sdeschmacsha256);
> -       if (rc)
> -               goto err;
> +       for (i =3D CIFS_SECMECH_DIR_IN; i < CIFS_SECMECH_DIR_MAX; i++) {
> +               rc =3D cifs_alloc_hash("hmac(sha256)",
> +                            &p->hmacsha256[i],
> +                            &p->sdeschmacsha256[i]);
> +               if (rc)
> +                       goto fail;
>
> -       rc =3D cifs_alloc_hash("cmac(aes)", &p->cmacaes, &p->sdesccmacaes=
);
> -       if (rc)
> -               goto err;
> +               rc =3D cifs_alloc_hash("cmac(aes)",
> +                       &p->cmacaes[i], &p->sdesccmacaes[i]);
>
> +               if (rc)
> +                       goto fail;
> +       }
>         return 0;
> -err:
> -       cifs_free_hash(&p->hmacsha256, &p->sdeschmacsha256);
> +
> +fail:
> +       for (i =3D CIFS_SECMECH_DIR_IN; i < CIFS_SECMECH_DIR_MAX; i++) {
> +               cifs_free_hash(&p->hmacsha256[i], &p->sdeschmacsha256[i])=
;
> +               cifs_free_hash(&p->cmacaes[i], &p->sdesccmacaes[i]);
> +       }
>         return rc;
>  }
>
> @@ -74,27 +95,32 @@ int
>  smb311_crypto_shash_allocate(struct TCP_Server_Info *server)
>  {
>         struct cifs_secmech *p =3D &server->secmech;
> -       int rc =3D 0;
> +       int i, rc =3D 0;
>
> -       rc =3D cifs_alloc_hash("hmac(sha256)",
> -                            &p->hmacsha256,
> -                            &p->sdeschmacsha256);
> -       if (rc)
> -               return rc;
> +       for (i =3D CIFS_SECMECH_DIR_IN; i < CIFS_SECMECH_DIR_MAX; i++) {
> +               rc =3D cifs_alloc_hash("hmac(sha256)",
> +                            &p->hmacsha256[i],
> +                            &p->sdeschmacsha256[i]);
> +               if (rc)
> +                       goto fail;
>
> -       rc =3D cifs_alloc_hash("cmac(aes)", &p->cmacaes, &p->sdesccmacaes=
);
> -       if (rc)
> -               goto err;
> +               rc =3D cifs_alloc_hash("cmac(aes)",
> +                       &p->cmacaes[i], &p->sdesccmacaes[i]);
> +               if (rc)
> +                       goto fail;
> +       }
>
>         rc =3D cifs_alloc_hash("sha512", &p->sha512, &p->sdescsha512);
>         if (rc)
> -               goto err;
> +               goto fail;
>
>         return 0;
>
> -err:
> -       cifs_free_hash(&p->cmacaes, &p->sdesccmacaes);
> -       cifs_free_hash(&p->hmacsha256, &p->sdeschmacsha256);
> +fail:
> +       for (i =3D CIFS_SECMECH_DIR_IN; i < CIFS_SECMECH_DIR_MAX; i++) {
> +               cifs_free_hash(&p->hmacsha256[i], &p->sdeschmacsha256[i])=
;
> +               cifs_free_hash(&p->cmacaes[i], &p->sdesccmacaes[i]);
> +       }
>         return rc;
>  }
>
> @@ -219,7 +245,8 @@ smb2_find_smb_tcon(struct TCP_Server_Info *server, __=
u64 ses_id, __u32  tid)
>  }
>
>  int
> -smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *serve=
r)
> +smb2_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *serve=
r,
> +                   int direction)
>  {
>         int rc;
>         unsigned char smb2_signature[SMB2_HMACSHA256_SIZE];
> @@ -229,6 +256,7 @@ smb2_calc_signature(struct smb_rqst *rqst, struct TCP=
_Server_Info *server)
>         struct cifs_ses *ses;
>         struct shash_desc *shash;
>         struct smb_rqst drqst;
> +       struct crypto_shash *hmacsha256;
>
>         ses =3D smb2_find_smb_ses(server, shdr->SessionId);
>         if (!ses) {
> @@ -245,14 +273,16 @@ smb2_calc_signature(struct smb_rqst *rqst, struct T=
CP_Server_Info *server)
>                 return rc;
>         }
>
> -       rc =3D crypto_shash_setkey(server->secmech.hmacsha256,
> +       hmacsha256 =3D server->secmech.hmacsha256[direction];
> +
> +       rc =3D crypto_shash_setkey(hmacsha256,
>                                  ses->auth_key.response, SMB2_NTLMV2_SESS=
KEY_SIZE);
>         if (rc) {
>                 cifs_server_dbg(VFS, "%s: Could not update with response\=
n", __func__);
>                 return rc;
>         }
>
> -       shash =3D &server->secmech.sdeschmacsha256->shash;
> +       shash =3D &server->secmech.sdeschmacsha256[direction]->shash;
>         rc =3D crypto_shash_init(shash);
>         if (rc) {
>                 cifs_server_dbg(VFS, "%s: Could not init sha256", __func_=
_);
> @@ -296,6 +326,8 @@ static int generate_key(struct cifs_ses *ses, struct =
kvec label,
>         unsigned char prfhash[SMB2_HMACSHA256_SIZE];
>         unsigned char *hashptr =3D prfhash;
>         struct TCP_Server_Info *server =3D ses->server;
> +       struct crypto_shash *hmacsha256;
> +       struct sdesc *sdeschmacsha256;
>
>         memset(prfhash, 0x0, SMB2_HMACSHA256_SIZE);
>         memset(key, 0x0, key_size);
> @@ -306,55 +338,58 @@ static int generate_key(struct cifs_ses *ses, struc=
t kvec label,
>                 goto smb3signkey_ret;
>         }
>
> -       rc =3D crypto_shash_setkey(server->secmech.hmacsha256,
> +       hmacsha256 =3D server->secmech.hmacsha256[CIFS_SECMECH_DIR_OUT];
> +       sdeschmacsha256 =3D server->secmech.sdeschmacsha256[CIFS_SECMECH_=
DIR_OUT];
> +
> +       rc =3D crypto_shash_setkey(hmacsha256,
>                 ses->auth_key.response, SMB2_NTLMV2_SESSKEY_SIZE);
>         if (rc) {
>                 cifs_server_dbg(VFS, "%s: Could not set with session key\=
n", __func__);
>                 goto smb3signkey_ret;
>         }
>
> -       rc =3D crypto_shash_init(&server->secmech.sdeschmacsha256->shash)=
;
> +       rc =3D crypto_shash_init(&sdeschmacsha256->shash);
>         if (rc) {
>                 cifs_server_dbg(VFS, "%s: Could not init sign hmac\n", __=
func__);
>                 goto smb3signkey_ret;
>         }
>
> -       rc =3D crypto_shash_update(&server->secmech.sdeschmacsha256->shas=
h,
> +       rc =3D crypto_shash_update(&sdeschmacsha256->shash,
>                                 i, 4);
>         if (rc) {
>                 cifs_server_dbg(VFS, "%s: Could not update with n\n", __f=
unc__);
>                 goto smb3signkey_ret;
>         }
>
> -       rc =3D crypto_shash_update(&server->secmech.sdeschmacsha256->shas=
h,
> +       rc =3D crypto_shash_update(&sdeschmacsha256->shash,
>                                 label.iov_base, label.iov_len);
>         if (rc) {
>                 cifs_server_dbg(VFS, "%s: Could not update with label\n",=
 __func__);
>                 goto smb3signkey_ret;
>         }
>
> -       rc =3D crypto_shash_update(&server->secmech.sdeschmacsha256->shas=
h,
> +       rc =3D crypto_shash_update(&sdeschmacsha256->shash,
>                                 &zero, 1);
>         if (rc) {
>                 cifs_server_dbg(VFS, "%s: Could not update with zero\n", =
__func__);
>                 goto smb3signkey_ret;
>         }
>
> -       rc =3D crypto_shash_update(&server->secmech.sdeschmacsha256->shas=
h,
> +       rc =3D crypto_shash_update(&sdeschmacsha256->shash,
>                                 context.iov_base, context.iov_len);
>         if (rc) {
>                 cifs_server_dbg(VFS, "%s: Could not update with context\n=
", __func__);
>                 goto smb3signkey_ret;
>         }
>
> -       rc =3D crypto_shash_update(&server->secmech.sdeschmacsha256->shas=
h,
> +       rc =3D crypto_shash_update(&sdeschmacsha256->shash,
>                                 L, 4);
>         if (rc) {
>                 cifs_server_dbg(VFS, "%s: Could not update with L\n", __f=
unc__);
>                 goto smb3signkey_ret;
>         }
>
> -       rc =3D crypto_shash_final(&server->secmech.sdeschmacsha256->shash=
,
> +       rc =3D crypto_shash_final(&sdeschmacsha256->shash,
>                                 hashptr);
>         if (rc) {
>                 cifs_server_dbg(VFS, "%s: Could not generate sha256 hash\=
n", __func__);
> @@ -504,16 +539,18 @@ generate_smb311signingkey(struct cifs_ses *ses)
>  }
>
>  int
> -smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *serve=
r)
> +smb3_calc_signature(struct smb_rqst *rqst, struct TCP_Server_Info *serve=
r,
> +                   int direction)
>  {
>         int rc;
>         unsigned char smb3_signature[SMB2_CMACAES_SIZE];
>         unsigned char *sigptr =3D smb3_signature;
>         struct kvec *iov =3D rqst->rq_iov;
>         struct smb2_sync_hdr *shdr =3D (struct smb2_sync_hdr *)iov[0].iov=
_base;
> -       struct shash_desc *shash =3D &server->secmech.sdesccmacaes->shash=
;
> +       struct shash_desc *shash;
>         struct smb_rqst drqst;
>         u8 key[SMB3_SIGN_KEY_SIZE];
> +       struct crypto_shash *cmacaes;
>
>         rc =3D smb2_get_sign_key(shdr->SessionId, server, key);
>         if (rc)
> @@ -522,8 +559,10 @@ smb3_calc_signature(struct smb_rqst *rqst, struct TC=
P_Server_Info *server)
>         memset(smb3_signature, 0x0, SMB2_CMACAES_SIZE);
>         memset(shdr->Signature, 0x0, SMB2_SIGNATURE_SIZE);
>
> -       rc =3D crypto_shash_setkey(server->secmech.cmacaes,
> -                                key, SMB2_CMACAES_SIZE);
> +       cmacaes =3D server->secmech.cmacaes[direction];
> +       shash =3D &server->secmech.sdesccmacaes[direction]->shash;
> +
> +       rc =3D crypto_shash_setkey(cmacaes, key, SMB2_CMACAES_SIZE);
>         if (rc) {
>                 cifs_server_dbg(VFS, "%s: Could not set key for cmac aes\=
n", __func__);
>                 return rc;
> @@ -593,8 +632,7 @@ smb2_sign_rqst(struct smb_rqst *rqst, struct TCP_Serv=
er_Info *server)
>                 return 0;
>         }
>
> -       rc =3D server->ops->calc_signature(rqst, server);
> -
> +       rc =3D server->ops->calc_signature(rqst, server, CIFS_SECMECH_DIR=
_OUT);
>         return rc;
>  }
>
> @@ -631,9 +669,7 @@ smb2_verify_signature(struct smb_rqst *rqst, struct T=
CP_Server_Info *server)
>
>         memset(shdr->Signature, 0, SMB2_SIGNATURE_SIZE);
>
> -       mutex_lock(&server->srv_mutex);
> -       rc =3D server->ops->calc_signature(rqst, server);
> -       mutex_unlock(&server->srv_mutex);
> +       rc =3D server->ops->calc_signature(rqst, server, CIFS_SECMECH_DIR=
_IN);

Multiple threads may be calling smb2_verify_signature from
smb2_check_receive in separate threads (see compound_send_recv). What
will prevent races on crypto data structures once the mutex around
calc_signature is removed?

--
Best regards,
Pavel Shilovsky
