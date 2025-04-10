Return-Path: <linux-cifs+bounces-4433-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19967A84CF7
	for <lists+linux-cifs@lfdr.de>; Thu, 10 Apr 2025 21:27:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CDA773A3653
	for <lists+linux-cifs@lfdr.de>; Thu, 10 Apr 2025 19:26:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C54B470830;
	Thu, 10 Apr 2025 19:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="EBsFXisD"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7DDD81EBFFD
	for <linux-cifs@vger.kernel.org>; Thu, 10 Apr 2025 19:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744313212; cv=none; b=r8gZ1MnV10fN8daYZMGE1tgto6ok9AJk2ot4ZO5y1Wudz4c64PbVvSP/1RNnSknLsEutfghyBqt1E6eIL5kS6Qipy4qdJBJQa3LYYJVmHVI5Nm9RH9mx9nEpS3UPSUaCoYj7Av0Q+APiETsUR+HYNyCVYcB3J3x0NzxSwo2IHeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744313212; c=relaxed/simple;
	bh=DFZsSjGTmNtZjBJwUF48LQpn1+gf4oNmep4zO1aZNQU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=MqwyF3s0Fsu4hvFLdhqf+KD/mw4KLEbST25VwzKVmthQvYTjBYJOeEak00tP7fiOrhmudOPvX/h1ewEhAuNpJfv77P3fFI7LhG7pmlacid1KjarSm+NywMXvMP/FpGMLWNszvGNPmuBsibc7CfbIkh0EJPT1/aXWPj/lGbZpH/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=EBsFXisD; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=From:Cc:To:Date:Message-ID;
	bh=DFZsSjGTmNtZjBJwUF48LQpn1+gf4oNmep4zO1aZNQU=; b=EBsFXisD2lqPXrOZF7A/oBc8Tf
	CuVATmgJxAtDYdaqgYOW8KB6eZjp+doPMuFaL8Sz/LyznCsN41/qGxGLFmEmeoixXiuQ8szvnelJF
	Xzf9xVqewAOuVcaxY1h3j4dtwgBFdrTTT5PiCVVII6XxTThhG+FgitGg7JYSQdLTwWFGAPpRvmIi4
	Ot4E9fhXpF6pSIq9/1KtoAajNGvgok+qWzC9ykOs0usOenX0ej2G7eglY+fWWc/14HfqtGAC3Usra
	PF2EsWQn0iR8CaBPKYXS/rAu87mVj8fLFnrtd8cdKFGsZqx4IkiHwI9p2uOLjYR2mKJ31MYdqfk/D
	Xgb6EVFgW+eXgbwqUo4PX5zDfRleO0294T0yqtxfaq3Zmlk+2pYIWeoCXvdijoJYKZaHOfBUPHQLT
	FOLjPuju8wElxjmqwz0beg64zQwVNzNkB+srxMXGvZ0H81OG2TfnNmQrPOGMv1j17jfOrmmZ16mdB
	pRAREr6Gf+8RTQE/6T4bZJZm;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__ECDSA_SECP256R1_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1u2xXz-009AYD-00;
	Thu, 10 Apr 2025 19:26:47 +0000
Message-ID: <6707c2c4-3677-4705-8f0c-86d572ed1810@samba.org>
Date: Thu, 10 Apr 2025 21:26:46 +0200
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: SMB3 POSIX and deleting files with FILE_ATTRIBUTE_READONLY
To: Jeremy Allison <jra@samba.org>
Cc: CIFS <linux-cifs@vger.kernel.org>,
 samba-technical <samba-technical@lists.samba.org>,
 Tom Talpey <tom@talpey.com>, Steven French <Steven.French@microsoft.com>,
 "vl@samba.org" <vl@samba.org>, Stefan Metzmacher <metze@samba.org>
References: <32f7a0c2-32cd-4ccd-b471-7cba98cc30f3@samba.org>
 <Z_b4DS3kOpbCI4pG@jeremy-HP-Z840-Workstation>
 <9f7da486-5d85-4ef3-8fcf-14b408d78700@samba.org>
 <Z_fdfszysLKt4Xij@jeremy-HP-Z840-Workstation>
Content-Language: en-US, de-DE
From: Ralph Boehme <slow@samba.org>
Autocrypt: addr=slow@samba.org; keydata=
 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
 R3NApzHw2ZqQDtSdciR9og==
In-Reply-To: <Z_fdfszysLKt4Xij@jeremy-HP-Z840-Workstation>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------w2n6Q8QNBUoPdxxoZza1ImX0"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------w2n6Q8QNBUoPdxxoZza1ImX0
Content-Type: multipart/mixed; boundary="------------mzfdtiiLdin1uzzaHdSomZ00";
 protected-headers="v1"
From: Ralph Boehme <slow@samba.org>
To: Jeremy Allison <jra@samba.org>
Cc: CIFS <linux-cifs@vger.kernel.org>,
 samba-technical <samba-technical@lists.samba.org>,
 Tom Talpey <tom@talpey.com>, Steven French <Steven.French@microsoft.com>,
 "vl@samba.org" <vl@samba.org>, Stefan Metzmacher <metze@samba.org>
Message-ID: <6707c2c4-3677-4705-8f0c-86d572ed1810@samba.org>
Subject: Re: SMB3 POSIX and deleting files with FILE_ATTRIBUTE_READONLY
References: <32f7a0c2-32cd-4ccd-b471-7cba98cc30f3@samba.org>
 <Z_b4DS3kOpbCI4pG@jeremy-HP-Z840-Workstation>
 <9f7da486-5d85-4ef3-8fcf-14b408d78700@samba.org>
 <Z_fdfszysLKt4Xij@jeremy-HP-Z840-Workstation>
In-Reply-To: <Z_fdfszysLKt4Xij@jeremy-HP-Z840-Workstation>
Autocrypt-Gossip: addr=jra@samba.org; keydata=
 xsDiBDxEcLsRBADMQzpWoVuu4oiq23q5AfZDbakENMP/8ZU+AnzqzGr70lIEJb2jfcudViUT
 97+RmXptlnDmE4/ILOf6w0udMlQ9Jpm+iqxbr35D/6qvFgrgE+PnNAPlKSlI2fyGuLhpv1QP
 forHV13gB3B6S/ZWHpf/owKnJMwu8ozQpjnMnqOiVwCg8QnSX2AFCMd3HLQsqVaMdlO+jBEE
 AKrMu2Pavmyc/eoNfrjgeRoNRkwHCINWO5u93o92dngWK/hN1QOOCQfAzqZ1JwS5Q+E2gGug
 4OVaZI1vZGsAzb06TSnS4fmrOfwHqltSDsCHhwd+pyWkIvi96Swx00e1NEwNExEBo5NrGunf
 fONGlfRc+WhMLIk0u2e2V14R+ebDA/42T+cQZtUR6EdBReHVpmckQXXcE8cIqsu6UpZCsdEP
 N6YjxQKgTKWQWoxE2k4lYl9KsDK1BaF6rLNz/yt2RAVb1qZVaOqpITZWwzykzH60dMaX/G1S
 GWuN28by9ghI2LIsxcXHiDhG2CZxyfogBDDXoTPXlVMdk55IwAJny8Wj4s0eSmVyZW15IEFs
 bGlzb24gPGpyYUBzYW1iYS5vcmc+wlcEExECABcFAjxEcLsFCwcKAwQDFQMCAxYCAQIXgAAK
 CRCl3XhJ1sA2rDHZAKDwxfxpGuCOAuDHaN3ULDrIzKw9DQCdHb3Sq5WKfeqeaY2ZKXT3AmXl
 Fq7OwE0EPERwvhAEAIY1K5TICtxmFOeoRMW39jtF8DNSXl/se6HBe3Wy5Cz43lMZ6NvjDATa
 1w3JlkmjUyIDP29ApqmMu78Tv4UUxAh1PhyTttX1/aorTlIdVYFjey/yW4mSDXUBhPvMpq52
 TncLRmK9HC6mIxJqS0vi6W9IqGOqDRZph3GzVzJN7WvLAAMGA/sGAyg2rVsBzs77WH0jPO+A
 QZDj+Hf/RFHOwmcyG7/XgmV6LOcQP4HfQHH3DGYihu5cZj3BeWKPDJnjOjB2qmr+FTjYEsjw
 LDBNG7rjRye412rUbNwmEtcD2/dw4xNyu5h2u+1++KVBPf4SqG/a10gDqGJXDHA1Os5MmnQl
 3CTq9sJGBBgRAgAGBQI8RHC+AAoJEKXdeEnWwDasbeIAoL6+EsZKAYrZ2w22A6V67tRNGOIe
 AJ0cV9+pk/vqEgbv8ipKU4iniZclhg==

--------------mzfdtiiLdin1uzzaHdSomZ00
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNC8xMC8yNSA1OjAyIFBNLCBKZXJlbXkgQWxsaXNvbiB3cm90ZToNCj4gT24gVGh1LCBB
cHIgMTAsIDIwMjUgYXQgMTA6MzM6NTRBTSArMDIwMCwgUmFscGggQm9laG1lIHdyb3RlOg0K
Pj4gT24gNC8xMC8yNSAxMjo0MyBBTSwgSmVyZW15IEFsbGlzb24gd3JvdGU6DQo+Pj4gRG9l
cyBXaW5kb3dzIGV2ZXIgc2VuZCBGSUxFX0RJU1BPU0lUSU9OX0lHTk9SRV9SRUFET05MWV9B
VFRSSUJVVEUgb3Zlcg0KPj4+IHRoZSB3aXJlID8NCj4+DQo+PiBObywgaXQncyBsb2NhbCBv
bmx5LCBjZiBNUy1GU0NDIGFuZCB0aGUgdGhyZWFkICJTTUIyIERFTEVURSB2cyBVTkxJTksi
IA0KPj4gb24gdGhlIExpbnV4IGNpZnMgbWFpbGluZyBsaXN0Lg0KPj4NCj4+IDxodHRwczov
L2xlYXJuLm1pY3Jvc29mdC5jb20vZW4tdXMvb3BlbnNwZWNzL3dpbmRvd3NfcHJvdG9jb2xz
L21zLSANCj4+IGZzY2MvNDcxOGZjNDAtZTUzOS00MDE0LThlMzMtYjY3NWFmNzRlM2UxPg0K
PiANCj4gT0ssIGJ1dCBkb2VzIHRoZSBXaW5kb3dzIFNNQjMgc2VydmVyIGZpbHRlciBpdCBv
dXQgPw0KDQp5ZXMuDQoNCj4gQ2FuIGEgTGludXggY2xpZW50IHNlbmQgaXQgb3ZlciB0aGUg
d2lyZSBhbmQgZG9lcw0KPiBpdCBoYXZlIHRoZSBkZXNpcmVkIGVmZmVjdCA/DQoNCm5vLiAg
Q2YgdGhlIHRocmVhZCBJIG1lbnRpb25lZC4NCg0KVGhhbmtzIQ0KLXNsb3cNCg==

--------------mzfdtiiLdin1uzzaHdSomZ00--

--------------w2n6Q8QNBUoPdxxoZza1ImX0
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE+uLGCIokJSBRxVnkqh6bcSY5nkYFAmf4G3YFAwAAAAAACgkQqh6bcSY5nkYF
hA/+KzvTZlFr7UwElEbL8PgNOtyGdkDodqOCzLc/82Ob/rWbpJU4e5zBAyJ9CRXu2NlDZJGteW7L
IKL1acCUm9nk0wlmdN4rd2K9/htwvBSkE4F79xmztkVDGKhytAjARbY/MhxcFznM++/0wBtEb3qi
De5a31q8VCIHqhY+LgtbLAzsqwHTi0fQPkyoej8sZVb5nWiuI4NVlmeu8EDDhVrKk6xI4Dw4ZN9p
nUrryzHzlECuqdLCfQQ6OreI9O7EYSrWVPNufv3vr+v8rr1mZBz0mm4MtQbulzXVOGv3tQQCos2E
D+Xxngl2la/sShXM6GGnFhKqzUP9BBcnLiqdhTVsukcMTEK/6Kk+A26L09F/EbtSJBGVianyb3bF
0ygD53UQzgXzZ3hNKb/4Wkjo86qU9JHs8fBWKy61q/5gK0yKn8ypWyvS5bOsYT+jJ6d2MrxweyrM
xi6kcGNBw8NbtHfhfuP8UJgJ/x5xYwWTLygflWO67h1cDqpe18V2bBMpsls4ltI74Jw9dip8iRAj
vvgib7K4dHwpJ33eVXuj0HmXYkZXQ1BBBRmnpbVuAgpotpq8momZjlKi/TRvloxaqKMgas+MjW/7
1N9CHWTtSvEd50330OMZoZAqAcdy1Y7fc2C2FC6B9oyl0KJC+76hsFbeh1TfyuZNUXcHOXIxrUTR
ORk=
=HE8e
-----END PGP SIGNATURE-----

--------------w2n6Q8QNBUoPdxxoZza1ImX0--

