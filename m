Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8AAF8295F35
	for <lists+linux-cifs@lfdr.de>; Thu, 22 Oct 2020 14:59:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2441082AbgJVM7K (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 22 Oct 2020 08:59:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439121AbgJVM7I (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 22 Oct 2020 08:59:08 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D27F1C0613CE
        for <linux-cifs@vger.kernel.org>; Thu, 22 Oct 2020 05:59:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Date:Message-ID:From:Cc:To;
        bh=dWXzIylL6x1yrEQwYikqtVE87CRrRdF6T8Swlx3cH1U=; b=WV5F6pzV0s17LBZQBMcpX+6cz0
        NUifpSP2+lEFWlNPi/NWSPkQnkBsk6PHRrVeWhGdhEvqGo0s0r6cFezg2s6en8UXs4h2g6XPpcwjd
        XoywIpvx6pAliZrNYgCd0B0SQpNWbc50NPby7AuYJmM5rABX8yHGFLY/oksplWBM1JJo9a99y/gy+
        RflIZ19UJhn88nMXJVR1l7j4LbQiEaMwXW81ZSxqRaA7CSczpnax4DkXNAVBFEcaEx+pTvKbcUR2d
        4+ZoJE6t6F4ut1rMP5ieIXrDPd9vEDp0Z46gY621uX2r5IVAg3UKcovOpnPu6jk6il4j4NQrR7Pnu
        7wEkOW3BazU36KXlot9euESw5Bc5wKWI2gQixaroAU3En4U8GOCnmHUHGTEwwFo0pF3i0hdTdWZkC
        Ioz/yeaWbF76h53teDjevwOBpoTXRNZBmLZXWMYGMIMJi7WdEquoNzqD0oKDb+y2IZYs53H0qbnGM
        FfvanOa+J7bVfiOW9RA21/8A;
Received: from [127.0.0.2] (localhost [127.0.0.1])
        by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1kVaBM-00023J-Np; Thu, 22 Oct 2020 12:59:05 +0000
To:     Steve French <smfrench@gmail.com>,
        =?UTF-8?Q?Aur=c3=a9lien_Aptel?= <aaptel@suse.com>,
        Shyam Prasad N <nspmangalore@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>
References: <CAH2r5mtAOxF=PCndMTXxj_dZVLc-NQJfoawOvMeS3FbxiCU6xw@mail.gmail.com>
 <87eelzho1b.fsf@suse.com>
 <CAH2r5mvdOBeLJsPZRqj1O8UU24aUxhc-cWEWO+8RAW9fPzYSJg@mail.gmail.com>
 <CAH2r5msGP-=qow2A3eJPiHg-CaNCM+6cvfbP9=_z3ZJSeU9UKw@mail.gmail.com>
 <CAH2r5muN34JRZOxsG2+jvh9F8X9E7Lb85gmQud6MJKR43qKZyA@mail.gmail.com>
From:   Stefan Metzmacher <metze@samba.org>
Autocrypt: addr=metze@samba.org; prefer-encrypt=mutual; keydata=
 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
 uAMlsTqBMFOwuvAcYAj2bwl7QQU6yhU=
Subject: Re: Add support for GCM256 encryption
Message-ID: <1743629c-c183-fab9-1bcf-89dbcec2c53f@samba.org>
Date:   Thu, 22 Oct 2020 14:59:00 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAH2r5muN34JRZOxsG2+jvh9F8X9E7Lb85gmQud6MJKR43qKZyA@mail.gmail.com>
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature";
 boundary="WIAeSIIn8jksHp4mmZYQCdq1X7wbjsKIA"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--WIAeSIIn8jksHp4mmZYQCdq1X7wbjsKIA
Content-Type: multipart/mixed; boundary="2gNrMaqpkAMYW7ziYV1GiKHBWVPEzgeSL";
 protected-headers="v1"
From: Stefan Metzmacher <metze@samba.org>
To: Steve French <smfrench@gmail.com>, =?UTF-8?Q?Aur=c3=a9lien_Aptel?=
 <aaptel@suse.com>, Shyam Prasad N <nspmangalore@gmail.com>
Cc: CIFS <linux-cifs@vger.kernel.org>
Message-ID: <1743629c-c183-fab9-1bcf-89dbcec2c53f@samba.org>
Subject: Re: Add support for GCM256 encryption
References: <CAH2r5mtAOxF=PCndMTXxj_dZVLc-NQJfoawOvMeS3FbxiCU6xw@mail.gmail.com>
 <87eelzho1b.fsf@suse.com>
 <CAH2r5mvdOBeLJsPZRqj1O8UU24aUxhc-cWEWO+8RAW9fPzYSJg@mail.gmail.com>
 <CAH2r5msGP-=qow2A3eJPiHg-CaNCM+6cvfbP9=_z3ZJSeU9UKw@mail.gmail.com>
 <CAH2r5muN34JRZOxsG2+jvh9F8X9E7Lb85gmQud6MJKR43qKZyA@mail.gmail.com>
In-Reply-To: <CAH2r5muN34JRZOxsG2+jvh9F8X9E7Lb85gmQud6MJKR43qKZyA@mail.gmail.com>

--2gNrMaqpkAMYW7ziYV1GiKHBWVPEzgeSL
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Am 16.10.20 um 06:45 schrieb Steve French:
> Redid patch 5 (includes Aurelien's suggestion, fixes a typo and fixes
> a problem with vers=3D3.0 mounts) - attached.
>=20
> On Thu, Oct 15, 2020 at 12:41 PM Steve French <smfrench@gmail.com> wrot=
e:
>>
>> found another typo in patch 5 ccm instead of gcm - fixing it now
>>
>> On Thu, Oct 15, 2020 at 11:33 AM Steve French <smfrench@gmail.com> wro=
te:
>>>
>>> Good point.  Updated patches attached.  Also added a one line comment=

>>> to smb2pdu.h mentioning why we don't request AES_256_CCM
>>>
>>>
>>> On Thu, Oct 15, 2020 at 3:49 AM Aur=C3=A9lien Aptel <aaptel@suse.com>=
 wrote:
>>>>
>>>> Hi Steve,
>>>>
>>>> Patch 2:
>>>>
>>>>> From 3897b440fd14dfc7b2ad2b0a922302ea7705b5d9 Mon Sep 17 00:00:00 2=
001
>>>>> From: Steve French <stfrench@microsoft.com>
>>>>> Date: Wed, 14 Oct 2020 20:24:09 -0500
>>>>> Subject: [PATCH 2/5] smb3.1.1: add new module load parm enable_gcm_=
256
>>>>> --- a/fs/cifs/smb2pdu.h
>>>>> +++ b/fs/cifs/smb2pdu.h
>>>>> @@ -361,8 +361,9 @@ struct smb2_encryption_neg_context {
>>>>>       __le16  ContextType; /* 2 */
>>>>>       __le16  DataLength;
>>>>>       __le32  Reserved;
>>>>> -     __le16  CipherCount; /* AES-128-GCM and AES-128-CCM */
>>>>> -     __le16  Ciphers[2];
>>>>> +     /* CipherCount usally 2, but can be 3 when AES256-GCM enabled=
 */
>>>>> +     __le16  CipherCount; /* AES128-GCM and AES128-CCM by defalt *=
/
>>>>
>>>> Typo defalt =3D> default
>>>>
>>>>> +     __le16  Ciphers[3];
>>>>>  } __packed;
>>>>>
>>>>>  /* See MS-SMB2 2.2.3.1.3 */
>>>>> --
>>>>> 2.25.1
>>>>>
>>>>
>>>> Patch 5:
>>>>
>>>>> From 314d7476e404c37acb77c3f9ecc142122e7afbfd Mon Sep 17 00:00:00 2=
001
>>>>> From: Steve French <stfrench@microsoft.com>
>>>>> Date: Fri, 11 Sep 2020 16:47:09 -0500
>>>>> Subject: [PATCH 5/5] smb3.1.1: set gcm256 when requested
>>>>>
>>>>> update code to set 32 byte key length and to set gcm256 when reques=
ted
>>>>> on mount.
>>>>>
>>>>> Signed-off-by: Steve French <stfrench@microsoft.com>
>>>>> ---
>>>>>  fs/cifs/smb2glob.h      |  1 +
>>>>>  fs/cifs/smb2ops.c       | 20 ++++++++++++--------
>>>>>  fs/cifs/smb2transport.c | 16 ++++++++--------
>>>>>  3 files changed, 21 insertions(+), 16 deletions(-)
>>>>>
>>>>> diff --git a/fs/cifs/smb2ops.c b/fs/cifs/smb2ops.c
>>>>> index dd1edabec328..d8e74954d101 100644
>>>>> --- a/fs/cifs/smb2ops.c
>>>>> +++ b/fs/cifs/smb2ops.c
>>>>> @@ -3954,7 +3954,12 @@ crypt_message(struct TCP_Server_Info *server=
, int num_rqst,
>>>>>
>>>>>       tfm =3D enc ? server->secmech.ccmaesencrypt :
>>>>>                                               server->secmech.ccmae=
sdecrypt;
>>>>> -     rc =3D crypto_aead_setkey(tfm, key, SMB3_SIGN_KEY_SIZE);
>>>>> +
>>>>> +     if (require_gcm_256)
>>>>> +             rc =3D crypto_aead_setkey(tfm, key, SMB3_GCM256_CRYPT=
KEY_SIZE);
>>>>
>>>> Shouldn't the check be on server->cipher_type?
>>>>
>>>>> +     else
>>>>> +             rc =3D crypto_aead_setkey(tfm, key, SMB3_SIGN_KEY_SIZ=
E);
>>>>> +

You still just use u8 key[SMB3_SIGN_KEY_SIZE];

Shouldn't smb2_get_enc_key() get the buffer size and return the size actu=
ally used?

I also don't see where you setup the 32 byte encryption/decryption keys f=
rom
the authentication session key?

[MS-SMB2] 3.3.5.5.3 Handling GSS-API Authentication point 11.)
specifies that the full authentication session key should be used as key =
derivation key
for AES256 (NTLMSSP always returns 16 bytes, kerberos can return 16 or 32=
 bytes).
3.3.1.8 Per Session says the resulting keys should be 256-bit (32 bytes) =
for AES-256.

I don't see any of this in your patchset.

Did you actually tested this successful against a Windows Server?

Can you use 'git format-patch --stdout > patches.txt' and attach patches.=
txt
as inline text attachment? Or use git send-email ...
Individual randomly sorted non text/plain attachments are very hard to co=
mment on
(at least for me).

metze


--2gNrMaqpkAMYW7ziYV1GiKHBWVPEzgeSL--

--WIAeSIIn8jksHp4mmZYQCdq1X7wbjsKIA
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCgAdFiEEfFbGo3YXpfgryIw9DbX1YShpvVYFAl+RghQACgkQDbX1YShp
vVa0NA/9GvxabnN8/MAjwSTZdMPrU76IkaCankz4eHzcZbe277M4BeFvunXJk8vB
RA5n0an/Z+FKBBPyg5JoeTNrIWKxErYV69dVfxWPFLjKDyq2c8DBgbh0dZUY1VNg
6FtOHvNqkHax2Rmkl2FLabJD8shWr0NqzZdZ0DcNjZ9j4yI+T5+XkJ+HtNLq3QWT
Ih5CK82XV4CrbKtRq5P8kbiqteKgx9tc0FX8d45fhHR93Wc1eMq44aio2DiwnnSc
KvqXAyTBZFGNW6tI6SSgB36LanWZgKLLWaSasa68lHt+/n5kUFXFv9wBnYEXUBj1
9twafDVfHxCHRUd5MC3o7jrAsu4QO9vNVevtLh6RH3qLFIRsr2NMcKUixtmB2IoK
S+nt0Bwvaq9sc5H4+5J5/MAllC4DoDQZJivu8l2zzfuiOv5IK9BhjYVNcfxLQ7e4
fGB2Bb4ZlsDdQmo6yuc+P264+s5oF9Z73gEsK8lQJODTRlq1xN9dqCV0C03Q/Mps
Kg5sGHsy9UHYJq3neoFVoaVUKPZUN8DxDROOgagYXkXObzaYEEjDRrRfydlBzkUJ
xRX9PMb1HUO6OuPvV0o+MNUgDsiA9MlZP6xfeFlYW4hB2XnMEqA41mwRRaGH1ZM/
IzSRIhmJZGVagdNZoDuDr/pEXUVzUTs/l5Ir2o94vahK/XGtDIM=
=3Vfn
-----END PGP SIGNATURE-----

--WIAeSIIn8jksHp4mmZYQCdq1X7wbjsKIA--
