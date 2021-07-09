Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E0A23C2883
	for <lists+linux-cifs@lfdr.de>; Fri,  9 Jul 2021 19:37:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbhGIRjo (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 9 Jul 2021 13:39:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbhGIRjo (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 9 Jul 2021 13:39:44 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BEAC0613DD
        for <linux-cifs@vger.kernel.org>; Fri,  9 Jul 2021 10:36:59 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id b2so17589476ejg.8
        for <linux-cifs@vger.kernel.org>; Fri, 09 Jul 2021 10:36:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=g8JNK7A6L5LECjUzeuR8GAbmB0zzESlDyvW4VF0nRUo=;
        b=lUpCprxViNmddCF0a9muj1FzwmS7yVAyqpEttk/Mvq1IR0RCEQcVH54HlF47+VpwkY
         m/agQKAg0Kt0E8EBv/+cXUM2ZyImkfWbg5D+OJrG5GjdZFFXKPVmCEM96J3HDB8oI1O+
         ls9iB83SMawTgbB+mn69SYruJh61dW9BFPu7GSMeU5iBAomNslq7saz7lqtOySktH0AI
         dKOjUCBcIz4IJb8BdJ9qXpxKfdexYKrBwMSOSJuILYRFmuaTgjWhOochXqvDGyJDcJ9U
         yIrCpkgeIcRncTogUnsaC1UtHu2IEsh8d6Mn7GqfZHI/YpSUWydE197Gojs384R3xLes
         PPlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=g8JNK7A6L5LECjUzeuR8GAbmB0zzESlDyvW4VF0nRUo=;
        b=ILoWL1non1mmFm3fkE2f13qS8ATkBMWVKxdgoYabpDtpH/QsQvhi79rI7nRLozXJp1
         tsAJWw+7lrVcDvytSfaWE4TnKb0icmaSUgCK/txTof4rRLnYn1iCPTxfGc1isOkz+9eB
         Iyst2i2+aEJIAgGdHoUFx64BJKNRK6fFYp0A7Wt7/idnA8peeYMmpIYxgj4ogoGZewBv
         u16ZA7lAGrFv+OniQug0F9QesANJjWMy04ndLp0vEgueMteRBplOnxxfkUcMZHOwu2dV
         tmyuHFcSzFRB+bL2U1NvaS+7x8ceu5DYeFIUemrMGoCbR4dq/3nQnnwjxc0tHhJo/0hZ
         pUhA==
X-Gm-Message-State: AOAM533wdMi7PRYz5GD8rcDv8uMYv9ssORijRR5i/YVscBMHkoOzsB/H
        f12R+zKdK3EKhmDaHIgzrphn5ZKJ/qvFeX5ffQ==
X-Google-Smtp-Source: ABdhPJzaPYr4g7DjsK4bDJ509JW5vdwjp9oQPjXsSe6GAwu3m/f18MZzNyMa3aHp+ZqP872Ya6AOm5DqP8DfShrAeYs=
X-Received: by 2002:a17:907:397:: with SMTP id ss23mr32630196ejb.120.1625852216466;
 Fri, 09 Jul 2021 10:36:56 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mvS6aHG8dXBre0RuGPzUb0g1hh-OPnhEup9PrX5z0zv5g@mail.gmail.com>
 <CAH2r5mu_fVutwr+XY8i-EpWO9gTw+dvHoy1oFk_wxHeMuVgxqA@mail.gmail.com>
 <CAH2r5mstq3L33-RBDrJ+0Z1K2PAP0z=5bm=wQ8XHdx4th_caFw@mail.gmail.com>
 <CAN05THSBo74HOMYV+mHejb1s4tAb_uv=8cmcO1UDRScFw-WUQg@mail.gmail.com>
 <CAKywueR0JE9-a8Gs-bxvDQgmDNzpm=sodpWc7rXaG58WR1EZiQ@mail.gmail.com>
 <CAH2r5mtKzR731tZ-+_MJ+4paW3kTqP3BM07Bu3j6bRbgxiE9_Q@mail.gmail.com>
 <CAH2r5muVGTBavyVWzXMRcMqWnVe1-MJ12VWKnvEYfpNDqiOZ_g@mail.gmail.com> <CAH2r5muuH4Vqk4nf1_vU2hbtOSsO90Rn_X8yHv0vmgvw+or5zw@mail.gmail.com>
In-Reply-To: <CAH2r5muuH4Vqk4nf1_vU2hbtOSsO90Rn_X8yHv0vmgvw+or5zw@mail.gmail.com>
From:   Pavel Shilovsky <piastryyy@gmail.com>
Date:   Fri, 9 Jul 2021 10:36:44 -0700
Message-ID: <CAKywueRt7vL5Jub4xeQjaPY8W__PJc00G3edW2vveZe-jz6MpQ@mail.gmail.com>
Subject: Re: [PATCH][SMB3.1.1] add ability to send signing negotiate context
To:     Steve French <smfrench@gmail.com>
Cc:     ronnie sahlberg <ronniesahlberg@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Thanks for making the change! The patch in your for-next branch looks good:

https://git.samba.org/sfrench/?p=3Dsfrench/cifs-2.6.git;a=3Dcommitdiff;h=3D=
c99696885096f71e59023996f7453485a20ba2c8

Reviewed-by: Pavel Shilovsky <pshilovsky@samba.org>
--
Best regards,
Pavel Shilovsky

=D1=87=D1=82, 8 =D0=B8=D1=8E=D0=BB. 2021 =D0=B3. =D0=B2 16:34, Steve French=
 <smfrench@gmail.com>:
>
> I also removed the line you noted:
>           pr_warn_once("requesting GMAC signing is experimental\n");
> No point to print that unless GMAC was actually negotiated (ie until
> the followon patch which adds GMAC to the list ...)
>
>
>
> On Thu, Jul 8, 2021 at 6:29 PM Steve French <smfrench@gmail.com> wrote:
> >
> > Tentatively I made the change to clarify:
> >
> > +MODULE_PARM_DESC(enable_GMAC_signing, "Enable requesting faster
> > (GMAC) packet signing. Default: n/N/0");
> >
> > to
> >
> > +MODULE_PARM_DESC(enable_negotiate_signing, "Enable negotiating packet
> > signing algorithm with server. Default: n/N/0");
> >
> > I think it is ok to leave the GMAC comment to minimize the change in
> > the next patch (enabling GMAC) ...
> >
> > On Thu, Jul 8, 2021 at 6:19 PM Steve French <smfrench@gmail.com> wrote:
> > >
> > > It is a little tricky to figure out good wording here.
> > >
> > > "enable_negotiate_signing" (eventually) could end up requesting all 3
> > > ... which means that the server could choose SHA256 over GMAC over
> > > CMAC.  Maybe I should avoid all mention of GMAC.
> > >
> > > My reason for noting "GMAC is experimental" is that if GMAC is
> > > negotiated it is less tested than the other two (since fewer servers
> > > currently support it compared to the other two which are broadly
> > > supported and thus already tested with cifs.ko) - but the effect of
> > > the patch is to let the server choose which algorithm it prefers ...
> > > so perhaps I should avoid mentioning GMAC here.
> > >
> > > On Thu, Jul 8, 2021 at 5:06 PM Pavel Shilovsky <piastryyy@gmail.com> =
wrote:
> > > >
> > > > @@ -104,6 +105,9 @@ MODULE_PARM_DESC(enable_gcm_256, "Enable
> > > > requesting strongest (256 bit) GCM encr
> > > >  module_param(require_gcm_256, bool, 0644);
> > > >  MODULE_PARM_DESC(require_gcm_256, "Require strongest (256 bit) GCM
> > > > encryption. Default: n/N/0");
> > > >
> > > > +module_param(enable_negotiate_signing, bool, 0644);
> > > > +MODULE_PARM_DESC(enable_GMAC_signing, "Enable requesting faster
> > > > (GMAC) packet signing. Default: n/N/0");
> > > > +
> > > >
> > > > s/enable_GMAC_signing/enable_negotiate_signing/ ?
> > > >
> > > > Also the description here is misleading: this param enables sending
> > > > the signing context not requesting GMAC which is not supported yet.
> > > >
> > > >
> > > > +    if (enable_negotiate_signing) {
> > > > +        pr_warn_once("requesting GMAC signing is experimental\n");
> > > >
> > > > Here as well - we are not requesting GMAC here, we are sending the
> > > > signing context with CMAC. I don't think this should be marked as
> > > > experimental.
> > > >
> > > > --
> > > > Best regards,
> > > > Pavel Shilovsky
> > > >
> > > > =D1=81=D1=80, 7 =D0=B8=D1=8E=D0=BB. 2021 =D0=B3. =D0=B2 21:52, ronn=
ie sahlberg <ronniesahlberg@gmail.com>:
> > > > >
> > > > > lgtm
> > > > >
> > > > > On Thu, Jul 8, 2021 at 2:49 PM Steve French <smfrench@gmail.com> =
wrote:
> > > > > >
> > > > > > v4 of patch (includes minor change to set local variable "num_a=
lgs"
> > > > > > once to number of algorithms and use that throughout
> > > > > > build_signing_context to make code a little clearer)
> > > > > >
> > > > > >
> > > > > > On Wed, Jul 7, 2021 at 11:27 PM Steve French <smfrench@gmail.co=
m> wrote:
> > > > > > >
> > > > > > > v3 of patch.  Updated with additional feedback from Ronnie (t=
o make it
> > > > > > > more context len and datalength clearer)
> > > > > > >
> > > > > > >
> > > > > > > On Wed, Jul 7, 2021 at 9:44 PM Steve French <smfrench@gmail.c=
om> wrote:
> > > > > > > >
> > > > > > > > Support for faster packet signing (using GMAC instead of CM=
AC) can
> > > > > > > > now be negotiated to some newer servers, including Windows.
> > > > > > > > See MS-SMB2 section 2.2.3.17.
> > > > > > > >
> > > > > > > > This patch adds support for sending the new negotiate conte=
xt
> > > > > > > > with the first of three supported signing algorithms (AES-C=
MAC)
> > > > > > > > and decoding the response.  A followon patch will add suppo=
rt
> > > > > > > > for sending the other two (including AES-GMAC, which is fas=
test)
> > > > > > > > and changing the signing algorithm used based on what was
> > > > > > > > negotiated.
> > > > > > > >
> > > > > > > > To allow the client to request GMAC signing set module para=
meter
> > > > > > > > "enable_negotiate_signing" to 1.
> > > > > > > >
> > > > > > > > Reviewed-by: Ronnie Sahlberg <lsahlber@redhat.com>
> > > > > > > > Signed-off-by: Steve French <stfrench@microsoft.com>
> > > > > > > > ---
> > > > > > > >  fs/cifs/cifsfs.c   |  4 +++
> > > > > > > >  fs/cifs/cifsglob.h |  3 ++
> > > > > > > >  fs/cifs/smb2pdu.c  | 83 ++++++++++++++++++++++++++++++++++=
++++++------
> > > > > > > >  fs/cifs/smb2pdu.h  |  5 ++-
> > > > > > > >  4 files changed, 84 insertions(+), 11 deletions(-)
> > > > > > > >
> > > > > > > > diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
> > > > > > > > index 9fb874dd8d24..476b07213fcd 100644
> > > > > > > > --- a/fs/cifs/cifsfs.c
> > > > > > > > +++ b/fs/cifs/cifsfs.c
> > > > > > > > @@ -65,6 +65,7 @@ bool lookupCacheEnabled =3D true;
> > > > > > > >  bool disable_legacy_dialects; /* false by default */
> > > > > > > >  bool enable_gcm_256 =3D true;
> > > > > > > >  bool require_gcm_256; /* false by default */
> > > > > > > > +bool enable_negotiate_signing; /* false by default */
> > > > > > > >  unsigned int global_secflags =3D CIFSSEC_DEF;
> > > > > > > >  /* unsigned int ntlmv2_support =3D 0; */
> > > > > > > >  unsigned int sign_CIFS_PDUs =3D 1;
> > > > > > > > @@ -104,6 +105,9 @@ MODULE_PARM_DESC(enable_gcm_256, "Enabl=
e
> > > > > > > > requesting strongest (256 bit) GCM encr
> > > > > > > >  module_param(require_gcm_256, bool, 0644);
> > > > > > > >  MODULE_PARM_DESC(require_gcm_256, "Require strongest (256 =
bit) GCM
> > > > > > > > encryption. Default: n/N/0");
> > > > > > > >
> > > > > > > > +module_param(enable_negotiate_signing, bool, 0644);
> > > > > > > > +MODULE_PARM_DESC(enable_GMAC_signing, "Enable requesting f=
aster
> > > > > > > > (GMAC) packet signing. Default: n/N/0");
> > > > > > > > +
> > > > > > > >  module_param(disable_legacy_dialects, bool, 0644);
> > > > > > > >  MODULE_PARM_DESC(disable_legacy_dialects, "To improve secu=
rity it may be "
> > > > > > > >     "helpful to restrict the ability to "
> > > > > > > > diff --git a/fs/cifs/cifsglob.h b/fs/cifs/cifsglob.h
> > > > > > > > index 921680fb7931..3c2e117bb926 100644
> > > > > > > > --- a/fs/cifs/cifsglob.h
> > > > > > > > +++ b/fs/cifs/cifsglob.h
> > > > > > > > @@ -667,9 +667,11 @@ struct TCP_Server_Info {
> > > > > > > >   unsigned int max_write;
> > > > > > > >   unsigned int min_offload;
> > > > > > > >   __le16 compress_algorithm;
> > > > > > > > + __u16 signing_algorithm;
> > > > > > > >   __le16 cipher_type;
> > > > > > > >   /* save initital negprot hash */
> > > > > > > >   __u8 preauth_sha_hash[SMB2_PREAUTH_HASH_SIZE];
> > > > > > > > + bool signing_negotiated; /* true if valid signing context=
 rcvd from server */
> > > > > > > >   bool posix_ext_supported;
> > > > > > > >   struct delayed_work reconnect; /* reconnect workqueue job=
 */
> > > > > > > >   struct mutex reconnect_mutex; /* prevent simultaneous rec=
onnects */
> > > > > > > > @@ -1869,6 +1871,7 @@ extern unsigned int global_secflags; =
/* if on,
> > > > > > > > session setup sent
> > > > > > > >  extern unsigned int sign_CIFS_PDUs;  /* enable smb packet =
signing */
> > > > > > > >  extern bool enable_gcm_256; /* allow optional negotiate of=
 strongest
> > > > > > > > signing (aes-gcm-256) */
> > > > > > > >  extern bool require_gcm_256; /* require use of strongest s=
igning
> > > > > > > > (aes-gcm-256) */
> > > > > > > > +extern bool enable_negotiate_signing; /* request use of fa=
ster (GMAC)
> > > > > > > > signing if available */
> > > > > > > >  extern bool linuxExtEnabled;/*enable Linux/Unix CIFS exten=
sions*/
> > > > > > > >  extern unsigned int CIFSMaxBufSize;  /* max size not inclu=
ding hdr */
> > > > > > > >  extern unsigned int cifs_min_rcv;    /* min size of big nt=
wrk buf pool */
> > > > > > > > diff --git a/fs/cifs/smb2pdu.c b/fs/cifs/smb2pdu.c
> > > > > > > > index 962826dc3316..757f145e70e5 100644
> > > > > > > > --- a/fs/cifs/smb2pdu.c
> > > > > > > > +++ b/fs/cifs/smb2pdu.c
> > > > > > > > @@ -433,6 +433,23 @@ build_compression_ctxt(struct
> > > > > > > > smb2_compression_capabilities_context *pneg_ctxt)
> > > > > > > >   pneg_ctxt->CompressionAlgorithms[2] =3D SMB3_COMPRESS_LZN=
T1;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static void
> > > > > > > > +build_signing_ctxt(struct smb2_signing_capabilities *pneg_=
ctxt)
> > > > > > > > +{
> > > > > > > > + pneg_ctxt->ContextType =3D SMB2_SIGNING_CAPABILITIES;
> > > > > > > > + /*
> > > > > > > > + * Data length must be increased here if more than 3 signi=
ng algorithms
> > > > > > > > + * sent but currently only 3 are defined. And context Data=
 length must
> > > > > > > > + * be rounded to multiple of 8 for some servers.
> > > > > > > > + */
> > > > > > > > + pneg_ctxt->DataLength =3D
> > > > > > > > + cpu_to_le16(DIV_ROUND_UP(sizeof(struct smb2_signing_capab=
ilities) -
> > > > > > > > + sizeof(struct smb2_neg_context), 8) * 8);
> > > > > > > > + pneg_ctxt->SigningAlgorithmCount =3D cpu_to_le16(1);
> > > > > > > > + pneg_ctxt->SigningAlgorithms[0] =3D cpu_to_le16(SIGNING_A=
LG_AES_CMAC);
> > > > > > > > + /* TBD add SIGNING_ALG_AES_GMAC and/or SIGNING_ALG_HMAC_S=
HA256 */
> > > > > > > > +}
> > > > > > > > +
> > > > > > > >  static void
> > > > > > > >  build_encrypt_ctxt(struct smb2_encryption_neg_context *pne=
g_ctxt)
> > > > > > > >  {
> > > > > > > > @@ -498,7 +515,7 @@ assemble_neg_contexts(struct smb2_negot=
iate_req *req,
> > > > > > > >         struct TCP_Server_Info *server, unsigned int *total=
_len)
> > > > > > > >  {
> > > > > > > >   char *pneg_ctxt;
> > > > > > > > - unsigned int ctxt_len;
> > > > > > > > + unsigned int ctxt_len, neg_context_count;
> > > > > > > >
> > > > > > > >   if (*total_len > 200) {
> > > > > > > >   /* In case length corrupted don't want to overrun smb buf=
fer */
> > > > > > > > @@ -525,6 +542,17 @@ assemble_neg_contexts(struct smb2_nego=
tiate_req *req,
> > > > > > > >   *total_len +=3D ctxt_len;
> > > > > > > >   pneg_ctxt +=3D ctxt_len;
> > > > > > > >
> > > > > > > > + ctxt_len =3D build_netname_ctxt((struct smb2_netname_neg_=
context *)pneg_ctxt,
> > > > > > > > + server->hostname);
> > > > > > > > + *total_len +=3D ctxt_len;
> > > > > > > > + pneg_ctxt +=3D ctxt_len;
> > > > > > > > +
> > > > > > > > + build_posix_ctxt((struct smb2_posix_neg_context *)pneg_ct=
xt);
> > > > > > > > + *total_len +=3D sizeof(struct smb2_posix_neg_context);
> > > > > > > > + pneg_ctxt +=3D sizeof(struct smb2_posix_neg_context);
> > > > > > > > +
> > > > > > > > + neg_context_count =3D 4;
> > > > > > > > +
> > > > > > > >   if (server->compress_algorithm) {
> > > > > > > >   build_compression_ctxt((struct smb2_compression_capabilit=
ies_context *)
> > > > > > > >   pneg_ctxt);
> > > > > > > > @@ -533,17 +561,24 @@ assemble_neg_contexts(struct smb2_neg=
otiate_req *req,
> > > > > > > >   8) * 8;
> > > > > > > >   *total_len +=3D ctxt_len;
> > > > > > > >   pneg_ctxt +=3D ctxt_len;
> > > > > > > > - req->NegotiateContextCount =3D cpu_to_le16(5);
> > > > > > > > - } else
> > > > > > > > - req->NegotiateContextCount =3D cpu_to_le16(4);
> > > > > > > > + neg_context_count++;
> > > > > > > > + }
> > > > > > > >
> > > > > > > > - ctxt_len =3D build_netname_ctxt((struct smb2_netname_neg_=
context *)pneg_ctxt,
> > > > > > > > - server->hostname);
> > > > > > > > - *total_len +=3D ctxt_len;
> > > > > > > > - pneg_ctxt +=3D ctxt_len;
> > > > > > > > + if (enable_negotiate_signing) {
> > > > > > > > + pr_warn_once("requesting GMAC signing is experimental\n")=
;
> > > > > > > > + build_signing_ctxt((struct smb2_signing_capabilities *)
> > > > > > > > + pneg_ctxt);
> > > > > > > > + ctxt_len =3D DIV_ROUND_UP(
> > > > > > > > + sizeof(struct smb2_signing_capabilities),
> > > > > > > > + 8) * 8;
> > > > > > > > + *total_len +=3D ctxt_len;
> > > > > > > > + pneg_ctxt +=3D ctxt_len;
> > > > > > > > + neg_context_count++;
> > > > > > > > + }
> > > > > > > > +
> > > > > > > > + /* check for and add transport_capabilities and signing c=
apabilities */
> > > > > > > > + req->NegotiateContextCount =3D cpu_to_le16(neg_context_co=
unt);
> > > > > > > >
> > > > > > > > - build_posix_ctxt((struct smb2_posix_neg_context *)pneg_ct=
xt);
> > > > > > > > - *total_len +=3D sizeof(struct smb2_posix_neg_context);
> > > > > > > >  }
> > > > > > > >
> > > > > > > >  static void decode_preauth_context(struct smb2_preauth_neg=
_context *ctxt)
> > > > > > > > @@ -632,6 +667,31 @@ static int decode_encrypt_ctx(struct
> > > > > > > > TCP_Server_Info *server,
> > > > > > > >   return 0;
> > > > > > > >  }
> > > > > > > >
> > > > > > > > +static void decode_signing_ctx(struct TCP_Server_Info *ser=
ver,
> > > > > > > > +        struct smb2_signing_capabilities *pctxt)
> > > > > > > > +{
> > > > > > > > + unsigned int len =3D le16_to_cpu(pctxt->DataLength);
> > > > > > > > +
> > > > > > > > + if ((len < 4) || (len > 16)) {
> > > > > > > > + pr_warn_once("server sent bad signing negcontext\n");
> > > > > > > > + return;
> > > > > > > > + }
> > > > > > > > + if (le16_to_cpu(pctxt->SigningAlgorithmCount) !=3D 1) {
> > > > > > > > + pr_warn_once("Invalid signing algorithm count\n");
> > > > > > > > + return;
> > > > > > > > + }
> > > > > > > > + if (le16_to_cpu(pctxt->SigningAlgorithms[0]) > 2) {
> > > > > > > > + pr_warn_once("unknown signing algorithm\n");
> > > > > > > > + return;
> > > > > > > > + }
> > > > > > > > +
> > > > > > > > + server->signing_negotiated =3D true;
> > > > > > > > + server->signing_algorithm =3D le16_to_cpu(pctxt->SigningA=
lgorithms[0]);
> > > > > > > > + cifs_dbg(FYI, "signing algorithm %d chosen\n",
> > > > > > > > +      server->signing_algorithm);
> > > > > > > > +}
> > > > > > > > +
> > > > > > > > +
> > > > > > > >  static int smb311_decode_neg_context(struct smb2_negotiate=
_rsp *rsp,
> > > > > > > >        struct TCP_Server_Info *server,
> > > > > > > >        unsigned int len_of_smb)
> > > > > > > > @@ -675,6 +735,9 @@ static int smb311_decode_neg_context(st=
ruct
> > > > > > > > smb2_negotiate_rsp *rsp,
> > > > > > > >   (struct smb2_compression_capabilities_context *)pctx);
> > > > > > > >   else if (pctx->ContextType =3D=3D SMB2_POSIX_EXTENSIONS_A=
VAILABLE)
> > > > > > > >   server->posix_ext_supported =3D true;
> > > > > > > > + else if (pctx->ContextType =3D=3D SMB2_SIGNING_CAPABILITI=
ES)
> > > > > > > > + decode_signing_ctx(server,
> > > > > > > > + (struct smb2_signing_capabilities *)pctx);
> > > > > > > >   else
> > > > > > > >   cifs_server_dbg(VFS, "unknown negcontext of type %d ignor=
ed\n",
> > > > > > > >   le16_to_cpu(pctx->ContextType));
> > > > > > > > diff --git a/fs/cifs/smb2pdu.h b/fs/cifs/smb2pdu.h
> > > > > > > > index ba75e65924ac..4b27cb9105fd 100644
> > > > > > > > --- a/fs/cifs/smb2pdu.h
> > > > > > > > +++ b/fs/cifs/smb2pdu.h
> > > > > > > > @@ -329,7 +329,7 @@ struct smb2_neg_context {
> > > > > > > >   __le16 ContextType;
> > > > > > > >   __le16 DataLength;
> > > > > > > >   __le32 Reserved;
> > > > > > > > - /* Followed by array of data */
> > > > > > > > + /* Followed by array of data. NOTE: some servers require =
padding to
> > > > > > > > 8 byte boundary */
> > > > > > > >  } __packed;
> > > > > > > >
> > > > > > > >  #define SMB311_LINUX_CLIENT_SALT_SIZE 32
> > > > > > > > @@ -394,6 +394,7 @@ struct smb2_compression_capabilities_co=
ntext {
> > > > > > > >   __u16 Padding;
> > > > > > > >   __u32 Flags;
> > > > > > > >   __le16 CompressionAlgorithms[3];
> > > > > > > > + /* Check if pad needed */
> > > > > > > >  } __packed;
> > > > > > > >
> > > > > > > >  /*
> > > > > > > > @@ -420,6 +421,7 @@ struct smb2_transport_capabilities_cont=
ext {
> > > > > > > >   __le16  DataLength;
> > > > > > > >   __u32 Reserved;
> > > > > > > >   __le32 Flags;
> > > > > > > > + __u32 Pad;
> > > > > > > >  } __packed;
> > > > > > > >
> > > > > > > >  /*
> > > > > > > > @@ -458,6 +460,7 @@ struct smb2_signing_capabilities {
> > > > > > > >   __u32 Reserved;
> > > > > > > >   __le16 SigningAlgorithmCount;
> > > > > > > >   __le16 SigningAlgorithms[];
> > > > > > > > + /*  Followed by padding to 8 byte boundary (required by s=
ome servers) */
> > > > > > > >  } __packed;
> > > > > > > >
> > > > > > > >  #define POSIX_CTXT_DATA_LEN 16
> > > > > > > >
> > > > > > > > --
> > > > > > > > Thanks,
> > > > > > > >
> > > > > > > > Steve
> > > > > > >
> > > > > > >
> > > > > > >
> > > > > > > --
> > > > > > > Thanks,
> > > > > > >
> > > > > > > Steve
> > > > > >
> > > > > >
> > > > > >
> > > > > > --
> > > > > > Thanks,
> > > > > >
> > > > > > Steve
> > >
> > >
> > >
> > > --
> > > Thanks,
> > >
> > > Steve
> >
> >
> >
> > --
> > Thanks,
> >
> > Steve
>
>
>
> --
> Thanks,
>
> Steve
