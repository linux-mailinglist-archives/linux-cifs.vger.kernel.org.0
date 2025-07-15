Return-Path: <linux-cifs+bounces-5343-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0796FB059F8
	for <lists+linux-cifs@lfdr.de>; Tue, 15 Jul 2025 14:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3203C1A6291A
	for <lists+linux-cifs@lfdr.de>; Tue, 15 Jul 2025 12:28:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACE4A2D8778;
	Tue, 15 Jul 2025 12:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b="XMYI0mK9"
X-Original-To: linux-cifs@vger.kernel.org
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C08A219E8
	for <linux-cifs@vger.kernel.org>; Tue, 15 Jul 2025 12:27:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=144.76.82.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752582480; cv=none; b=Ydh0vCnKYWDb4M1A1dBuBZYgojJAATzEwbNJESlshygQkP9H4YTjmXHLzTZBO7Vpm+xsc4vP2+FODh0eKjakVhZERTizGEyiqVwxb32BcRXhD+wljfB0oDa4wGZiiB8EofAyRQPgAgAfH0yDtFC+ZpFqmdbdV2Xh8NH/c/jde0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752582480; c=relaxed/simple;
	bh=/ohCHtMk2rDJUfJOSGLkjBtqTVyiDu76NEM2+5TbNcs=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=EpBarzWl67ayL84qrkgrxXZ7kuU0gOEDbvYhCVgEE3xoFHbTwFmZJT8RiQI8TmZJFukouLCxeQ3PV7o0SAXdKne3aYwmlltsP+VvSLnKXvNV4gMdY/NbyXygN1hTR4nctAL9+wgU1guf/0w5btTLZpq68SpCYvipdbx7u3Y/qM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org; spf=pass smtp.mailfrom=samba.org; dkim=pass (3072-bit key) header.d=samba.org header.i=@samba.org header.b=XMYI0mK9; arc=none smtp.client-ip=144.76.82.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=samba.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=samba.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
	s=42; h=Cc:To:From:Date:Message-ID;
	bh=/ohCHtMk2rDJUfJOSGLkjBtqTVyiDu76NEM2+5TbNcs=; b=XMYI0mK9r0MOgXvY9yY3VuBhGA
	fGtXzFP4HXwOHqL8QEIlX16X0oqpS+pLPz5zCUsVpTioSfpqdXb61r5yIm0AOks61hzPLAPjX1uCO
	iYpWPskGj+HuoxvjXsQjkixN38jJM46+1EZduWq0Y/LbuEfrhR8l47SkydkDw79YqZC7rUkoi2Atz
	XjWVl200JodeNyL6j+ytkCzjliq7qWKWcRYyq5X8SwfE8Hs4/IsevFIZJtNhpJSu/jK+ZY9twT2/d
	HAVanR18TbWNU2VrRo/z5anC2BoialbUmtVIjqHNfWiWdOCs0ryj8oZIgATfZ7qKQbSI/xZyB5fxa
	OzqNGzgzvRF0J4kN/MKCYVfYRQ+cHbzF38xOzk4Zw8x7uwgK1L1KcLvrvHZYgncozZ/FHP4vLfJQw
	M0qFGErgOHGsRSVqrnsJ5PCTh9S7A25iXhGNakReSPpg6ah5zNy/dABS84qk0FBlMcZNv0ZQeuM0m
	+ZlzX7wQ/tHCeDaKXL8HChJs;
Received: from [127.0.0.2] (localhost [127.0.0.1])
	by hr2.samba.org with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
	(Exim)
	id 1ubelC-00FSa4-37;
	Tue, 15 Jul 2025 12:27:51 +0000
Message-ID: <946b0ed2-6aca-4b52-be1e-2910bc371ba7@samba.org>
Date: Tue, 15 Jul 2025 14:27:50 +0200
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Ralph Boehme <slow@samba.org>
Subject: Re: Samba support for creating special files (via reparse points)
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Jeremy Allison <jra@samba.org>, Steve French <smfrench@gmail.com>,
 vl@samba.org, samba-technical <samba-technical@lists.samba.org>,
 Paulo Alcantara <pc@manguebit.org>, CIFS <linux-cifs@vger.kernel.org>
References: <CAH2r5muQGDkaHL78JOcgsfjL_=A64Xm9CrCBSKgOMABOjcg44w@mail.gmail.com>
 <CAH2r5msdLbvGMARXJ=V9wt0pvXJOrc=zh3eUfeF9AXEeshtByg@mail.gmail.com>
 <aHRo9VfMDIfK5MR6@jeremy-HP-Z840-Workstation>
 <42e549c1-0f92-4b95-b62b-3e0efab9aa10@samba.org>
 <5519b2d9-600c-4a3f-b44f-594877417df7@samba.org>
 <20250714165844.4hctlrwegfspiius@pali>
Content-Language: en-US, de-DE
Autocrypt: addr=slow@samba.org; keydata=
 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
 R3NApzHw2ZqQDtSdciR9og==
In-Reply-To: <20250714165844.4hctlrwegfspiius@pali>
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------zldo1VzisxkV2xLRneBVfuFy"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------------zldo1VzisxkV2xLRneBVfuFy
Content-Type: multipart/mixed; boundary="------------02RbiWYPgyIdwW0HkhWt2D6Z";
 protected-headers="v1"
From: Ralph Boehme <slow@samba.org>
To: =?UTF-8?Q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc: Jeremy Allison <jra@samba.org>, Steve French <smfrench@gmail.com>,
 vl@samba.org, samba-technical <samba-technical@lists.samba.org>,
 Paulo Alcantara <pc@manguebit.org>, CIFS <linux-cifs@vger.kernel.org>
Message-ID: <946b0ed2-6aca-4b52-be1e-2910bc371ba7@samba.org>
Subject: Re: Samba support for creating special files (via reparse points)
References: <CAH2r5muQGDkaHL78JOcgsfjL_=A64Xm9CrCBSKgOMABOjcg44w@mail.gmail.com>
 <CAH2r5msdLbvGMARXJ=V9wt0pvXJOrc=zh3eUfeF9AXEeshtByg@mail.gmail.com>
 <aHRo9VfMDIfK5MR6@jeremy-HP-Z840-Workstation>
 <42e549c1-0f92-4b95-b62b-3e0efab9aa10@samba.org>
 <5519b2d9-600c-4a3f-b44f-594877417df7@samba.org>
 <20250714165844.4hctlrwegfspiius@pali>
In-Reply-To: <20250714165844.4hctlrwegfspiius@pali>
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

--------------02RbiWYPgyIdwW0HkhWt2D6Z
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: base64

T24gNy8xNC8yNSA2OjU4IFBNLCBQYWxpIFJvaMOhciB3cm90ZToNCj4gT24gTW9uZGF5IDE0
IEp1bHkgMjAyNSAxMDoyMzoxNyBSYWxwaCBCb2VobWUgd3JvdGU6DQo+PiBPbiA3LzE0LzI1
IDg6MDEgQU0sIFJhbHBoIEJvZWhtZSB2aWEgc2FtYmEtdGVjaG5pY2FsIHdyb3RlOg0KPj4+
IE9uIDcvMTQvMjUgNDoxOCBBTSwgSmVyZW15IEFsbGlzb24gd3JvdGU6DQo+Pj4+IEl0J3Mg
YW4gb3ZlcnNpZ2h0IEknbSBhZnJhaWQuDQo+Pj4NCj4+PiBobS4uLiBpdCBzZWVtcyByZXBh
cnNlIHBvaW50cyBzdXBwb3J0IGlzIG1hbmRhdG9yeSBmb3IgU01CMyBQT1NJWCBzbyBJDQo+
Pj4gd29uZGVyIHdoYXQgdGhpcyBhZGRpdGlvbmFsIGNoZWNrcyBidXlzIHVzLg0KPiANCj4g
Tm8uIEl0IGlzIG5vdCBtYW5kYXRvcnkuDQoNCnNvcnJ5LCBpbXByZWNpc2Ugd29yZGluZzog
c3VwcG9ydCBmb3IgcmVjZWl2aW5nIGFuZCB1bmRlcnN0YW5kaW5nIA0KUkVQQVJTRV9UQUdf
TkZTIGFuZCBSRVBBUlNFX1RBR19TWU1MSU5LIGlzIG1hbmRhdG9yeS4gU2VydmVyIGFuZCBj
bGllbnQgDQpNVVNUIGJlIGFibGUgdG8gc2VuZC9yZWNlaXZlIGFuZCB1bmRlcnN0YW5kIHRo
ZXNlLiBUaGV5IGNhbiBzdGlsbCBmYWlsIA0Kb2YgY291cnNlIG9uIHRoZSBzZXJ2ZXIgZm9y
IHZhcmlvdXMgcmVhc29ucy4NCg0KU3VwcG9ydCBmb3Igb3RoZXIgcmVwYXJzZSBwb2ludCB0
eXBlcyBpcyBvcHRpb25hbCBhbmQgdGhlIGNsaWVudCBNQVkgDQpjaGVjayBGSUxFX1NVUFBP
UlRTX1JFUEFSU0VfUE9JTlRTIGJlZm9yZSB1c2luZyB0aG9zZS4NCg0KUkVQQVJTRV9UQUdf
TkZTIGFuZCBSRVBBUlNFX1RBR19TWU1MSU5LIGFyZSByZXBhcnNlIHBvaW50cyBvbiB0aGUg
d2lyZSwgDQpidXQgdHlwaWNhbGx5IHRoZSBzZXJ2ZXIgc3RvcmVzIHRoZW0gaW4gdGhlaXIg
Im5hdGl2ZSIgUE9TSVggZm9ybWF0IGFuZCANCnRoZSBjbGllbnQgTVVTVCByZXByZXNlbnQg
dGhlbSBpbiB0aGVpciBuYXRpdmUgUE9TSVggZm9ybWF0Lg0KDQpJdCdzIHJlYWxseSBqdXN0
IHNvbWUgYWNjb21tb2RhdGlvbiB0byB0aGUgcHJvdG9jb2wsIHdpdGggc29tZXRoaW5nIA0K
YmVpbmcgZGlzZ3Vpc2VkIGFzIGEgcmVwYXJzZSBwb2ludCB3aGVuIGl0IGlzIGFjdHVhbGx5
IHNvbWV0aGluZyBlbHNlIA0KZW50aXJlbHkuDQoNCj4gR2V0dGluZyBvciBzZXR0aW5nIG9m
IHJlcGFyc2UgcG9pbnRzIGlzIGRvbmUNCj4gdmlhIElPQ1RMcyB3aGljaCBhcmUgb3B0aW9u
YWwuDQoNClNhbWUgaGVyZS4gU2VydmVyIGFuZCBjbGllbnQgTVVTVCBiZSBhYmxlIHRvIHNl
bmQvcmVjZWl2ZSANClJFUEFSU0VfVEFHX05GUyBhbmQgUkVQQVJTRV9UQUdfU1lNTElOSy4N
Cg0KPiBBbHNvIGZzIGF0dHJpYnV0ZSBmb3IgcmVwYXJzZSBwb2ludHMgaXMNCj4gb3B0aW9u
YWwuDQoNCnllcy4gQW5kIGl0IGFwcGxpZXMgdG8gYWxsIG90aGVyIHJlcGFyc2UgcG9pbnQg
dHlwZXMuDQoNCj4gDQo+IEFuZCB0aGF0IG1ha2Ugc2Vuc2UgYXMgdGhlcmUgYXJlIHN0aWxs
IGxvdCBvZiBmaWxlc3lzdGVtcyB3aGljaCBkbyBub3QNCj4gc3VwcG9ydCByZXBhcnNlIHBv
aW50cyAoZS5nLiBGQVQpIGFuZCB0aGlzIGZzIGF0dHJpYnV0ZSBpcyBleGFjdGx5IHdoYXQN
Cj4gc2VydmVyIGFubm91bmNlIGZvciBjbGllbnRzIGFuZCBhcHBsaWNhdGlvbnMgdG8gdGVs
bCBmZWF0dXJlIHN1cHBvcnQuDQoNCklmIGEgZmlsZXN5c3RlbSBvbiB0aGUgc2VydmVyIGRv
ZXNuJ3Qgc3VwcG9ydCBzdG9yaW5nIFJFUEFSU0VfVEFHX05GUyBvciANClJFUEFSU0VfVEFH
X1NZTUxJTksgb25lIHdheSBvciBhbm90aGVyLCBpdCBpcyBmcmVlIHRvIGZhaWwgdGhlIG9w
ZXJhdGlvbiANCndpdGggc29tZSBzZW5zaWJsZSBlcnJvci4NCg0KPiBTbyBhcHBsaWNhdGlv
biB3b3VsZCBrbm93IHdoYXQgZmVhdHVyZXMgYXJlIHByb3ZpZGVkIGFuZCB3aGljaCBub3Qg
b24NCj4gcGFydGljdWxhciBzaGFyZS4NCg0KQXBwbGljYXRpb24gZG8gbm90IGFuZCBjYW4g
bm90IGNoZWNrIHRoaXMuDQoNCj4gU2VydmVyIGNhbiBzdXBwb3J0IHJlcGFyc2UgcG9pbnRz
IG9uIHNoYXJlIEEgYnV0IGRvZXMNCj4gbm90IGhhdmUgdG8gc3VwcG9ydCBpdCBvbiBzaGFy
ZSBCLiBFLmcuIHdoZW4gQSBpcyBOVEZTIGFuZCBCIGlzIEZBVC4NCg0KU2hhcmluZyBOVEZT
IGlzIHNvbWVoYXQgb3V0IG9mIHNjb3BlIGZvciBTTUIzIFBPU0lYIEV4dGVuc2lvbnMgcmVh
bGx5LCANCmFzIGlzIEZBVC4gVGhlIHNjb3BlIGlzIGVuZC10by1lbmQgUE9TSVgtdG8tUE9T
SVggY29tcGF0aWJpbGl0eS4NCg0KPj4+IFdoaWxlIEkgYWdyZWUgdGhhdCBnZW5lcmFsbHkg
d2Ugc2hvdWxkIGxpa2VseSBzZXQgdGhpcywgZm9yIFNNQjMgUE9TSVgNCj4+PiB0aGUgY2xp
ZW50IHNob3VsZCBwcm9iYWJseSBub3QgY2hlY2sgdGhpcyBhbmQgd2Ugc2hvdWxkIGtlZXAg
aXQgb3V0IG9mDQo+Pj4gdGhlIHNwZWMuDQo+Pg0KPj4gb25lIGFkZGl0aW9uYWwgdGhvdWdo
dDogaXQgc2VlbXMgbGlrZSBhIHZhbGlkIHNjZW5hcmlvIHRvIGJlIGFibGUgdG8gc3VwcG9y
dA0KPj4gU01CMyBQT1NJWCBvbiBhIHNlcnZlciB0aGF0IGRvZXMgbm90IHN1cHBvcnQgeGF0
dHJzIG9uIHRoZSBiYWNraW5nDQo+PiBmaWxlc3lzdGVtIGFuZCBoZW5jZSBtYXkgbm90IGhh
dmUgYSB3YXkgb2Ygc3RvcmluZyBhcmJpdHJhcnkgcmVwYXJzZSBwb2ludHMuDQo+IA0KPiB4
YXR0cnMgYW5kIHJlcGFyc2UgcG9pbnRzIGFyZSB0d28gY29tcGxldGVseSBkaWZmZXJlbnQg
dGhpbmdzLCBhbmQgdGhleQ0KPiBzaG91bGQgbm90IGJlIG1peGVkIG9yIGV4Y2hhbmdlZC4N
Cg0KSXQgc2VlbXMgeW91J3JlIG1pc3NpbmcgdGhlIHBvaW50OiBpZiB0aGUgc2VydmVyIGlt
cGxlbWVudGF0aW9uIHN0b3JlcyANCnJlcGFyc2UgcG9pbnRzIGFzIHhhdHRycywgdGhlbiBv
ZiBjb3Vyc2UgeW91IGNsYWltIHN1cHBvcnQgZm9yIHJlcGFyc2UgDQpwb2ludHMgb25seSBp
ZiB5b3Uga25vdyAoYnkgY29uZmlndXJhdGlvbiksIHRoYXQgdGhlIGZpbGVzeXN0ZW0gc3Vw
cG9ydHMgDQp4YXR0cnMuDQoNCkNoZWVycyENCi1zbG93DQo=

--------------02RbiWYPgyIdwW0HkhWt2D6Z--

--------------zldo1VzisxkV2xLRneBVfuFy
Content-Type: application/pgp-signature; name="OpenPGP_signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="OpenPGP_signature.asc"

-----BEGIN PGP SIGNATURE-----

wsF5BAABCAAjFiEE+uLGCIokJSBRxVnkqh6bcSY5nkYFAmh2SUYFAwAAAAAACgkQqh6bcSY5nkZn
Cw//W7EUf1FFdFzdIrX9bTVD2DuCo6ZLyMZQrWjYxiNYxZvoajsaGXtc69Wfoc9wSymkZ4PRB1D/
BDASAQVHQhyog2qqVdrzN575e5+MUEr7GcT+DGPqyqCh71qVT1FI51/k1ATFklwr7JZGfjTT1oAB
ZJ+nPmAMO+6tgD9s2TsC1fq1akSXbPhmSpBONrZxFGxsphCVlEnM7guCktW4SbJN7ZdZtBRn+z3S
x/UwXKlkl5PEjvcf8vLIti3+VVYeD1R+6HS4Ks5RYb0mu8zpbUjuoNo0UFPx9Bov0SuA+V6hwHSU
Tn4vjjSrAWDYsz6BovauOUhoedv+HjPPKPOHj1miZqaLQJuz+NgC6L9pF3XyeyaYnyfYz0TK7jMt
ryHkWOA1BEnBEGevWZ13rBcphkVB+f0e9oJ0uUua0Qe25GGveok4cPOKJdXRtZsBr74OqxTKwxYa
Azi6iywwJvx7gbSUz6hT0k9drj1P6S3BC27ORxNzJEYbtRj/epsjjbCzM5RB3ro6qnjDDffQJXcc
BwpRhu+uao46ZLxSBIBtZNKSqOL9Ird56fmaK4k9onzkBHFVPs9iNRtPzwt8MDj3tEYLRK9Xmedq
0htvU+ZxOirzrWeI8ERehflDgl8V9FEEN5TQlXriOEAYnVJWcrihH0FT/vlOEWXB6ZHrRnrdv2Ld
c2c=
=XYUf
-----END PGP SIGNATURE-----

--------------zldo1VzisxkV2xLRneBVfuFy--

