Return-Path: <linux-cifs+bounces-1433-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 738B987795F
	for <lists+linux-cifs@lfdr.de>; Mon, 11 Mar 2024 01:59:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id B946DB203FB
	for <lists+linux-cifs@lfdr.de>; Mon, 11 Mar 2024 00:59:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F40CE631;
	Mon, 11 Mar 2024 00:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k1Y65Bow"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C127E622
	for <linux-cifs@vger.kernel.org>; Mon, 11 Mar 2024 00:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710118787; cv=none; b=FBo/oI1zD/2Xj46LQNPAM8eImIyhbvopd7XCmNwAVsQ6WhrTzjJRHbxiw77I4hrnv923QRJS970IrLpnAxTOEstlt52DS2qSoSQ14u1lL13IZLp5y84yws6eOmw57yWSZB3JGu/fFj08KYCdDtZeSGqU5r2GK+xl6YQnDV7+MLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710118787; c=relaxed/simple;
	bh=iweLrZqAwnEvJN1mG/w7+u1JGtyX5Bs57K9ZO1in57M=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=ooyHDh73GmKzEKf34xOOnC+/qGfIZenEdp3t3CaBReclAqzS7KYSExzxkuNBTBN7kNwF62IOZeewjm2xg8othJv9hRswJcEYnjjLQ+tpKFHgszJRu9RmurfIYY75WO2nPeoo+aTTzUBRb2LXhWG7CktqnpOg7dGL8nDE2l/KMIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k1Y65Bow; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5135e8262e4so4206012e87.0
        for <linux-cifs@vger.kernel.org>; Sun, 10 Mar 2024 17:59:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710118784; x=1710723584; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=zLiHanYCcPyFUhgUX/mu0tiE0+ER9b3OLSJaJagyzSM=;
        b=k1Y65Bowxtzs9vR7/BpXrA1U2Dzg0gXn93Jg1aDC9XEojog1Ji0sbryWkk6O1pdmYb
         qkOBocmsATgn30L3Unsr9WFAOoCkhP/d3fR+KBz7aCZrB5OiuODZWKhfIJt69/8LGVgh
         B6aOYqiRCerxoumGz4V7zXU4vlnvACrX8nb3CD9CkwmZcjnVKZ49VoB3kMQQVVvhYKdN
         BGqXBhNvuxGJmwvL8zRDVNT4v7lMyMJyiixuftVmelTbHLfhfXRI509h0HqGiQVvrqXN
         Lue159IFE9svGgBV1/A7Ur6oV/pamWyTgyGE571jKgm+fvmEi2yhMTTj8210PEmcjtX4
         XEoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710118784; x=1710723584;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zLiHanYCcPyFUhgUX/mu0tiE0+ER9b3OLSJaJagyzSM=;
        b=mugSIe686xE/04j0PJ0pM4KwSqPqjfoZRQ/R6mi80sYcl9k2g28faYovg0JCfthTUd
         HkFGxJHYyxrRLpD+K8FadQ2GmmX98BTPCKNx8fxt+OofJATJpQb7mXSD+8dd4AH2Ym63
         gl0lV/sD4SqT2k5Ypv95Kfzn6DbeotxEakdkXzlq7Dv/RTUX64b6FD7aA0YfKbbI3Fkw
         3qnedBGNScwGDV0tkfk04HzLLV2g71zv3avkhGWjWSonOb5+kohIzMFJn+O33oBfwKIy
         s0GmQuZPm1V4PghC50CXON0CWQTzPsgERO5sNAqxMQwdRzRumrcj/gtehkO3wGBtO4f3
         0zOQ==
X-Gm-Message-State: AOJu0YzkvV8x9s42PJAjHrryjnXJJLMbgjvOKdBndtnKFxC1xRNYz2QG
	HtVaijErRVHQy3xiVJH655eHlOpVkfGNuk4SWEKtkf5hJEVIImu132B4G+zsD0cL7vPh9+cSH5Q
	6JgKR0y1DApUbFXO4yYS8ifLeOl8=
X-Google-Smtp-Source: AGHT+IEK/Ono1WtERrQ+7hlPMTBsEB9VKpy04mn69PwidqW3Od9rfc3BN7nuJDV1KgdYbUHD94bM7lD0zJqs4eLe8iE=
X-Received: by 2002:a05:6512:3133:b0:513:5ec6:348b with SMTP id
 p19-20020a056512313300b005135ec6348bmr3088202lfd.6.1710118783767; Sun, 10 Mar
 2024 17:59:43 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Sun, 10 Mar 2024 19:59:32 -0500
Message-ID: <CAH2r5mshp1vSHj7RDHVtJ69A=eXdokG+fp2t+y95api0e-rzfQ@mail.gmail.com>
Subject: [SMB3 client] patches to prep for SMB3.1.1 compression support
To: Enzo Matsumiya <ematsumiya@suse.de>
Cc: CIFS <linux-cifs@vger.kernel.org>, 
	samba-technical <samba-technical@lists.samba.org>
Content-Type: multipart/mixed; boundary="000000000000a17caf0613580eec"

--000000000000a17caf0613580eec
Content-Type: text/plain; charset="UTF-8"

Enzo,
I have lightly updated your patches.  See attached.

1) smb: client: negotiate compression algorithms
Fixed a minor endian issue (with "arg" being le16 and being used to
compare vs. an int) and a few minor warnings spotted by checkpatch
(seq_puts is preferred instead of seq_printf for warning messages
without arguments)

2) smb: common: fix fields sizes in compression_pattern_payload_v1
added a brief description

3) smb: common: simplify compression headers
fixed a typo that checkpatch script caught (misaligned statement which
had extra space preceding it)


-- 
Thanks,

Steve

--000000000000a17caf0613580eec
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-smb-common-fix-fields-sizes-in-compression_pattern_p.patch"
Content-Disposition: attachment; 
	filename="0002-smb-common-fix-fields-sizes-in-compression_pattern_p.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ltm8jtg02>
X-Attachment-Id: f_ltm8jtg02

RnJvbSAzYjdmZDE4NGUyZDA5YzIxZTYyYTgyZGNjZDdhZmYzYzQxZGUxZjc1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbnpvIE1hdHN1bWl5YSA8ZW1hdHN1bWl5YUBzdXNlLmRlPgpE
YXRlOiBGcmksIDggTWFyIDIwMjQgMTg6MzQ6MTAgLTAzMDAKU3ViamVjdDogW1BBVENIIDIvNF0g
c21iOiBjb21tb246IGZpeCBmaWVsZHMgc2l6ZXMgaW4KIGNvbXByZXNzaW9uX3BhdHRlcm5fcGF5
bG9hZF92MQoKU2VlIHByb3RvY29sIGRvY3VtZW50YXRpb24gaW4gTVMtU01CMiBzZWN0aW9uIDIu
Mi40Mi4yLjIKClNpZ25lZC1vZmYtYnk6IEVuem8gTWF0c3VtaXlhIDxlbWF0c3VtaXlhQHN1c2Uu
ZGU+ClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4K
LS0tCiBmcy9zbWIvY29tbW9uL3NtYjJwZHUuaCB8IDQgKystLQogMSBmaWxlIGNoYW5nZWQsIDIg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9zbWIvY29tbW9u
L3NtYjJwZHUuaCBiL2ZzL3NtYi9jb21tb24vc21iMnBkdS5oCmluZGV4IDU3ZjIzNDMxNjRhMy4u
MTdmMWJkZGI5NWQwIDEwMDY0NAotLS0gYS9mcy9zbWIvY29tbW9uL3NtYjJwZHUuaAorKysgYi9m
cy9zbWIvY29tbW9uL3NtYjJwZHUuaApAQCAtMjM4LDggKzIzOCw4IEBAIHN0cnVjdCBzbWIyX2Nv
bXByZXNzaW9uX3RyYW5zZm9ybV9oZHJfY2hhaW5lZCB7CiAKIC8qIFNlZSBNUy1TTUIyIDIuMi40
Mi4yLjIgKi8KIHN0cnVjdCBjb21wcmVzc2lvbl9wYXR0ZXJuX3BheWxvYWRfdjEgewotCV9fbGUx
NglQYXR0ZXJuOwotCV9fbGUxNglSZXNlcnZlZDE7CisJX191OAlQYXR0ZXJuOworCV9fdTgJUmVz
ZXJ2ZWQxOwogCV9fbGUxNglSZXNlcnZlZDI7CiAJX19sZTMyCVJlcGV0aXRpb25zOwogfSBfX3Bh
Y2tlZDsKLS0gCjIuNDAuMQoK
--000000000000a17caf0613580eec
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0003-smb-common-simplify-compression-headers.patch"
Content-Disposition: attachment; 
	filename="0003-smb-common-simplify-compression-headers.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ltm8jtfw1>
X-Attachment-Id: f_ltm8jtfw1

RnJvbSA1MmVkMTNlM2Y3YmVhZmY4NzE5OTk0YWZkZWQxYmM1ZGViZWJkYTIzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbnpvIE1hdHN1bWl5YSA8ZW1hdHN1bWl5YUBzdXNlLmRlPgpE
YXRlOiBGcmksIDggTWFyIDIwMjQgMTk6MDA6MTIgLTAzMDAKU3ViamVjdDogW1BBVENIIDMvNF0g
c21iOiBjb21tb246IHNpbXBsaWZ5IGNvbXByZXNzaW9uIGhlYWRlcnMKClVuaWZ5IGNvbXByZXNz
aW9uIGhlYWRlcnMgKGNoYWluZWQgYW5kIHVuY2hhaW5lZCkgaW50byBhIHNpbmdsZSBzdHJ1Y3QK
c28gd2UgY2FuIHVzZSBpdCBmb3IgdGhlIGluaXRpYWwgY29tcHJlc3Npb24gdHJhbnNmb3JtIGhl
YWRlcgppbnRlcmNoYW5nZWFibHkuCgpBbHNvIG1ha2UgdGhlIE9yaWdpbmFsUGF5bG9hZFNpemUg
ZmllbGQgdG8gYmUgYWx3YXlzIHZpc2libGUgaW4gdGhlCmNvbXByZXNzaW9uIHBheWxvYWQgaGVh
ZGVyLCBhbmQgaGF2ZSBjYWxsZXJzIHN1YnRyYWN0IGl0cyBzaXplIHdoZW4gbm90Cm5lZWRlZC4K
ClJlbmFtZSB0aGUgcmVsYXRlZCBzdHJ1Y3RzIHRvIG1hdGNoIHRoZSBuYW1pbmcgY29udmV0aW9u
IHVzZWQgaW4gdGhlCm90aGVyIFNNQjIgc3RydWN0cy4KClNpZ25lZC1vZmYtYnk6IEVuem8gTWF0
c3VtaXlhIDxlbWF0c3VtaXlhQHN1c2UuZGU+ClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8
c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9zbWIvY29tbW9uL3NtYjJwZHUuaCB8IDQ1
ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hhbmdl
ZCwgMjYgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvc21i
L2NvbW1vbi9zbWIycGR1LmggYi9mcy9zbWIvY29tbW9uL3NtYjJwZHUuaAppbmRleCAxN2YxYmRk
Yjk1ZDAuLjIwNzg0Zjc2YTYwNCAxMDA2NDQKLS0tIGEvZnMvc21iL2NvbW1vbi9zbWIycGR1LmgK
KysrIGIvZnMvc21iL2NvbW1vbi9zbWIycGR1LmgKQEAgLTIwOCwzNiArMjA4LDQzIEBAIHN0cnVj
dCBzbWIyX3RyYW5zZm9ybV9oZHIgewogCV9fbGU2NCAgU2Vzc2lvbklkOwogfSBfX3BhY2tlZDsK
IAorLyoKKyAqIFRoZXNlIGFyZSBzaW1wbGlmaWVkIHZlcnNpb25zIGZyb20gdGhlIHNwZWMsIGFz
IHdlIGRvbid0IG5lZWQgYSBmdWxseSBmbGVkZ2VkCisgKiBmb3JtIG9mIGJvdGggdW5jaGFpbmVk
IGFuZCBjaGFpbmVkIHN0cnVjdHMuCisgKgorICogTW9yZW92ZXIsIGV2ZW4gaW4gY2hhaW5lZCBj
b21wcmVzc2VkIHBheWxvYWRzLCB0aGUgaW5pdGlhbCBjb21wcmVzc2lvbiBoZWFkZXIKKyAqIGhh
cyB0aGUgZm9ybSBvZiB0aGUgdW5jaGFpbmVkIG9uZSAtLSBpLmUuIGl0IG5ldmVyIGhhcyB0aGUK
KyAqIE9yaWdpbmFsUGF5bG9hZFNpemUgZmllbGQgYW5kIDo6T2Zmc2V0IGZpZWxkIGFsd2F5cyBy
ZXByZXNlbnQgYW4gb2Zmc2V0CisgKiAoaW5zdGVhZCBvZiBhIGxlbmd0aCwgYXMgaXQgaXMgaW4g
dGhlIGNoYWluZWQgaGVhZGVyKS4KKyAqCisgKiBTZWUgTVMtU01CMiAyLjIuNDIgZm9yIG1vcmUg
ZGV0YWlscy4KKyAqLworI2RlZmluZSBTTUIyX0NPTVBSRVNTSU9OX0ZMQUdfTk9ORQkweDAwMDAK
KyNkZWZpbmUgU01CMl9DT01QUkVTU0lPTl9GTEFHX0NIQUlORUQJMHgwMDAxCiAKLS8qIFNlZSBN
Uy1TTUIyIDIuMi40MiAqLwotc3RydWN0IHNtYjJfY29tcHJlc3Npb25fdHJhbnNmb3JtX2hkcl91
bmNoYWluZWQgewotCV9fbGUzMiBQcm90b2NvbElkOwkvKiAweEZDICdTJyAnTScgJ0InICovCitz
dHJ1Y3Qgc21iMl9jb21wcmVzc2lvbl9oZHIgeworCV9fbGUzMiBQcm90b2NvbElkOyAvKiAweEZD
ICdTJyAnTScgJ0InICovCiAJX19sZTMyIE9yaWdpbmFsQ29tcHJlc3NlZFNlZ21lbnRTaXplOwog
CV9fbGUxNiBDb21wcmVzc2lvbkFsZ29yaXRobTsKIAlfX2xlMTYgRmxhZ3M7Ci0JX19sZTE2IExl
bmd0aDsgLyogaWYgY2hhaW5lZCBpdCBpcyBsZW5ndGgsIGVsc2Ugb2Zmc2V0ICovCisJX19sZTE2
IE9mZnNldDsgLyogdGhpcyBpcyB0aGUgc2l6ZSBvZiB0aGUgdW5jb21wcmVzc2VkIFNNQjIgaGVh
ZGVyIGJlbG93ICovCisJLyogdW5jb21wcmVzc2VkIFNNQjIgaGVhZGVyIChSRUFEIG9yIFdSSVRF
KSBnb2VzIGhlcmUgKi8KKwkvKiBjb21wcmVzc2VkIGRhdGEgZ29lcyBoZXJlICovCiB9IF9fcGFj
a2VkOwogCi0vKiBTZWUgTVMtU01CMiAyLjIuNDIuMSAqLwotI2RlZmluZSBTTUIyX0NPTVBSRVNT
SU9OX0ZMQUdfTk9ORQkweDAwMDAKLSNkZWZpbmUgU01CMl9DT01QUkVTU0lPTl9GTEFHX0NIQUlO
RUQJMHgwMDAxCi0KLXN0cnVjdCBjb21wcmVzc2lvbl9wYXlsb2FkX2hlYWRlciB7CisvKgorICog
Li4uIE9UT0gsIHNldCBjb21wcmVzc2lvbiBwYXlsb2FkIGhlYWRlciB0byBhbHdheXMgaGF2ZSBP
cmlnaW5hbFBheWxvYWRTaXplCisgKiBhcyBpdCdzIGVhc2llciB0byBwYXNzIHRoZSBzdHJ1Y3Qg
c2l6ZSBtaW51cyBzaXplb2YoT3JpZ2luYWxQYXlsb2FkU2l6ZSkKKyAqIHRoYW4gdG8ganVnZ2xl
IGFyb3VuZCB0aGUgaGVhZGVyL2RhdGEgbWVtb3J5LgorICovCitzdHJ1Y3Qgc21iMl9jb21wcmVz
c2lvbl9wYXlsb2FkX2hkciB7CiAJX19sZTE2CUNvbXByZXNzaW9uQWxnb3JpdGhtOwogCV9fbGUx
NglGbGFnczsKIAlfX2xlMzIJTGVuZ3RoOyAvKiBsZW5ndGggb2YgY29tcHJlc3NlZCBwbGF5bG9h
ZCBpbmNsdWRpbmcgZmllbGQgYmVsb3cgaWYgcHJlc2VudCAqLwotCS8qIF9fbGUzMiBPcmlnaW5h
bFBheWxvYWRTaXplOyAqLyAvKiBvcHRpb25hbCwgcHJlc2VudCB3aGVuIExaTlQxLCBMWjc3LCBM
Wjc3K0h1ZmZtYW4gKi8KLX0gX19wYWNrZWQ7Ci0KLS8qIFNlZSBNUy1TTUIyIDIuMi40Mi4yICov
Ci1zdHJ1Y3Qgc21iMl9jb21wcmVzc2lvbl90cmFuc2Zvcm1faGRyX2NoYWluZWQgewotCV9fbGUz
MiBQcm90b2NvbElkOwkvKiAweEZDICdTJyAnTScgJ0InICovCi0JX19sZTMyIE9yaWdpbmFsQ29t
cHJlc3NlZFNlZ21lbnRTaXplOwotCS8qIHN0cnVjdCBjb21wcmVzc2lvbl9wYXlsb2FkX2hlYWRl
cltdICovCisJX19sZTMyIE9yaWdpbmFsUGF5bG9hZFNpemU7IC8qIGFjY291bnRlZCB3aGVuIExa
TlQxLCBMWjc3LCBMWjc3K0h1ZmZtYW4gKi8KIH0gX19wYWNrZWQ7CiAKLS8qIFNlZSBNUy1TTUIy
IDIuMi40Mi4yLjIgKi8KLXN0cnVjdCBjb21wcmVzc2lvbl9wYXR0ZXJuX3BheWxvYWRfdjEgewor
c3RydWN0IHNtYjJfY29tcHJlc3Npb25fcGF0dGVybl92MSB7CiAJX191OAlQYXR0ZXJuOwogCV9f
dTgJUmVzZXJ2ZWQxOwogCV9fbGUxNglSZXNlcnZlZDI7Ci0tIAoyLjQwLjEKCg==
--000000000000a17caf0613580eec
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb-client-negotiate-compression-algorithms.patch"
Content-Disposition: attachment; 
	filename="0001-smb-client-negotiate-compression-algorithms.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_ltm8jtfo0>
X-Attachment-Id: f_ltm8jtfo0

RnJvbSA4ZmVhMzQ3M2ExNzg1YTlmYzJlNjc5NWY1Nzg1ZGQyYWUzNjkzYmVlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBFbnpvIE1hdHN1bWl5YSA8ZW1hdHN1bWl5YUBzdXNlLmRlPgpE
YXRlOiBGcmksIDIzIEZlYiAyMDI0IDExOjU4OjU3IC0wMzAwClN1YmplY3Q6IFtQQVRDSCAxLzRd
IHNtYjogY2xpZW50OiBuZWdvdGlhdGUgY29tcHJlc3Npb24gYWxnb3JpdGhtcwoKQ2hhbmdlICJj
b21wcmVzcz0iIG1vdW50IG9wdGlvbiB0byBhIGJvb2xlYW4gZmxhZywgdGhhdCwgaWYgc2V0LAp3
aWxsIGVuYWJsZSBuZWdvdGlhdGluZyBjb21wcmVzc2lvbiBhbGdvcml0aG1zIHdpdGggdGhlIHNl
cnZlci4KCkRvIG5vdCBkZS9jb21wcmVzcyBhbnl0aGluZyBmb3Igbm93LgoKU2lnbmVkLW9mZi1i
eTogRW56byBNYXRzdW1peWEgPGVtYXRzdW1peWFAc3VzZS5kZT4KU2lnbmVkLW9mZi1ieTogU3Rl
dmUgRnJlbmNoIDxzdGZyZW5jaEBtaWNyb3NvZnQuY29tPgotLS0KIGZzL3NtYi9jbGllbnQvY2lm
c19kZWJ1Zy5jIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0KIGZzL3NtYi9j
bGllbnQvY2lmc2dsb2IuaCAgIHwgIDYgKysrKystCiBmcy9zbWIvY2xpZW50L2Nvbm5lY3QuYyAg
ICB8ICAyICstCiBmcy9zbWIvY2xpZW50L2ZzX2NvbnRleHQuYyB8ICAyICstCiBmcy9zbWIvY2xp
ZW50L2ZzX2NvbnRleHQuaCB8ICAyICstCiBmcy9zbWIvY2xpZW50L3NtYjJwZHUuYyAgICB8IDIw
ICsrKysrKysrKysrKysrKy0tLS0tCiA2IGZpbGVzIGNoYW5nZWQsIDQ5IGluc2VydGlvbnMoKyks
IDE1IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvY2lmc19kZWJ1Zy5j
IGIvZnMvc21iL2NsaWVudC9jaWZzX2RlYnVnLmMKaW5kZXggMjNkMjYyMmI5NjlmLi4yMjZkNDgz
NWM5MmQgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvY2lmc19kZWJ1Zy5jCisrKyBiL2ZzL3Nt
Yi9jbGllbnQvY2lmc19kZWJ1Zy5jCkBAIC0yNzgsNiArMjc4LDI0IEBAIHN0YXRpYyBpbnQgY2lm
c19kZWJ1Z19maWxlc19wcm9jX3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp2KQogCXJl
dHVybiAwOwogfQogCitzdGF0aWMgX19hbHdheXNfaW5saW5lIGNvbnN0IGNoYXIgKmNvbXByZXNz
aW9uX2FsZ19zdHIoX19sZTE2IGFsZykKK3sKKwlzd2l0Y2ggKGFsZykgeworCWNhc2UgU01CM19D
T01QUkVTU19OT05FOgorCQlyZXR1cm4gIk5PTkUiOworCWNhc2UgU01CM19DT01QUkVTU19MWk5U
MToKKwkJcmV0dXJuICJMWk5UMSI7CisJY2FzZSBTTUIzX0NPTVBSRVNTX0xaNzc6CisJCXJldHVy
biAiTFo3NyI7CisJY2FzZSBTTUIzX0NPTVBSRVNTX0xaNzdfSFVGRjoKKwkJcmV0dXJuICJMWjc3
LUh1ZmZtYW4iOworCWNhc2UgU01CM19DT01QUkVTU19QQVRURVJOOgorCQlyZXR1cm4gIlBhdHRl
cm5fVjEiOworCWRlZmF1bHQ6CisJCXJldHVybiAiaW52YWxpZCI7CisJfQorfQorCiBzdGF0aWMg
aW50IGNpZnNfZGVidWdfZGF0YV9wcm9jX3Nob3coc3RydWN0IHNlcV9maWxlICptLCB2b2lkICp2
KQogewogCXN0cnVjdCBtaWRfcV9lbnRyeSAqbWlkX2VudHJ5OwpAQCAtNDIzLDEyICs0NDEsNiBA
QCBzdGF0aWMgaW50IGNpZnNfZGVidWdfZGF0YV9wcm9jX3Nob3coc3RydWN0IHNlcV9maWxlICpt
LCB2b2lkICp2KQogCQkJc2VydmVyLT5lY2hvX2NyZWRpdHMsCiAJCQlzZXJ2ZXItPm9wbG9ja19j
cmVkaXRzLAogCQkJc2VydmVyLT5kaWFsZWN0KTsKLQkJaWYgKHNlcnZlci0+Y29tcHJlc3NfYWxn
b3JpdGhtID09IFNNQjNfQ09NUFJFU1NfTFpOVDEpCi0JCQlzZXFfcHJpbnRmKG0sICIgQ09NUFJF
U1NfTFpOVDEiKTsKLQkJZWxzZSBpZiAoc2VydmVyLT5jb21wcmVzc19hbGdvcml0aG0gPT0gU01C
M19DT01QUkVTU19MWjc3KQotCQkJc2VxX3ByaW50ZihtLCAiIENPTVBSRVNTX0xaNzciKTsKLQkJ
ZWxzZSBpZiAoc2VydmVyLT5jb21wcmVzc19hbGdvcml0aG0gPT0gU01CM19DT01QUkVTU19MWjc3
X0hVRkYpCi0JCQlzZXFfcHJpbnRmKG0sICIgQ09NUFJFU1NfTFo3N19IVUZGIik7CiAJCWlmIChz
ZXJ2ZXItPnNpZ24pCiAJCQlzZXFfcHJpbnRmKG0sICIgc2lnbmVkIik7CiAJCWlmIChzZXJ2ZXIt
PnBvc2l4X2V4dF9zdXBwb3J0ZWQpCkBAIC00NjAsNiArNDcyLDE0IEBAIHN0YXRpYyBpbnQgY2lm
c19kZWJ1Z19kYXRhX3Byb2Nfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYpCiAJCQkJ
ICAgc2VydmVyLT5sZWFmX2Z1bGxwYXRoKTsKIAkJfQogCisJCXNlcV9wdXRzKG0sICJcbkNvbXBy
ZXNzaW9uOiAiKTsKKwkJaWYgKCFzZXJ2ZXItPmNvbXByZXNzaW9uLnJlcXVlc3RlZCkKKwkJCXNl
cV9wdXRzKG0sICJkaXNhYmxlZCBvbiBtb3VudCIpOworCQllbHNlIGlmIChzZXJ2ZXItPmNvbXBy
ZXNzaW9uLmVuYWJsZWQpCisJCQlzZXFfcHJpbnRmKG0sICJlbmFibGVkICglcykiLCBjb21wcmVz
c2lvbl9hbGdfc3RyKHNlcnZlci0+Y29tcHJlc3Npb24uYWxnKSk7CisJCWVsc2UKKwkJCXNlcV9w
dXRzKG0sICJkaXNhYmxlZCAobm90IHN1cHBvcnRlZCBieSB0aGlzIHNlcnZlcikiKTsKKwogCQlz
ZXFfcHJpbnRmKG0sICJcblxuXHRTZXNzaW9uczogIik7CiAJCWkgPSAwOwogCQlsaXN0X2Zvcl9l
YWNoX2VudHJ5KHNlcywgJnNlcnZlci0+c21iX3Nlc19saXN0LCBzbWJfc2VzX2xpc3QpIHsKZGlm
ZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvY2lmc2dsb2IuaCBiL2ZzL3NtYi9jbGllbnQvY2lmc2ds
b2IuaAppbmRleCBhMDUwNmE0NWVhZTMuLjhiZTYyZWQwNTNhMiAxMDA2NDQKLS0tIGEvZnMvc21i
L2NsaWVudC9jaWZzZ2xvYi5oCisrKyBiL2ZzL3NtYi9jbGllbnQvY2lmc2dsb2IuaApAQCAtNzY5
LDcgKzc2OSwxMSBAQCBzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvIHsKIAl1bnNpZ25lZCBpbnQJbWF4
X3dyaXRlOwogCXVuc2lnbmVkIGludAltaW5fb2ZmbG9hZDsKIAl1bnNpZ25lZCBpbnQJcmV0cmFu
czsKLQlfX2xlMTYJY29tcHJlc3NfYWxnb3JpdGhtOworCXN0cnVjdCB7CisJCWJvb2wgcmVxdWVz
dGVkOyAvKiAiY29tcHJlc3MiIG1vdW50IG9wdGlvbiBzZXQqLworCQlib29sIGVuYWJsZWQ7IC8q
IGFjdHVhbGx5IG5lZ290aWF0ZWQgd2l0aCBzZXJ2ZXIgKi8KKwkJX19sZTE2IGFsZzsgLyogcHJl
ZmVycmVkIGFsZyBuZWdvdGlhdGVkIHdpdGggc2VydmVyICovCisJfSBjb21wcmVzc2lvbjsKIAlf
X3UxNglzaWduaW5nX2FsZ29yaXRobTsKIAlfX2xlMTYJY2lwaGVyX3R5cGU7CiAJIC8qIHNhdmUg
aW5pdGl0YWwgbmVncHJvdCBoYXNoICovCmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L2Nvbm5l
Y3QuYyBiL2ZzL3NtYi9jbGllbnQvY29ubmVjdC5jCmluZGV4IDVkODI5MjFkNjNkMS4uODZhZTU3
ODkwNGEyIDEwMDY0NAotLS0gYS9mcy9zbWIvY2xpZW50L2Nvbm5lY3QuYworKysgYi9mcy9zbWIv
Y2xpZW50L2Nvbm5lY3QuYwpAQCAtMTczNiw3ICsxNzM2LDcgQEAgY2lmc19nZXRfdGNwX3Nlc3Np
b24oc3RydWN0IHNtYjNfZnNfY29udGV4dCAqY3R4LAogCXRjcF9zZXMtPmNoYW5uZWxfc2VxdWVu
Y2VfbnVtID0gMDsgLyogb25seSB0cmFja2VkIGZvciBwcmltYXJ5IGNoYW5uZWwgKi8KIAl0Y3Bf
c2VzLT5yZWNvbm5lY3RfaW5zdGFuY2UgPSAxOwogCXRjcF9zZXMtPmxzdHJwID0gamlmZmllczsK
LQl0Y3Bfc2VzLT5jb21wcmVzc19hbGdvcml0aG0gPSBjcHVfdG9fbGUxNihjdHgtPmNvbXByZXNz
aW9uKTsKKwl0Y3Bfc2VzLT5jb21wcmVzc2lvbi5yZXF1ZXN0ZWQgPSBjdHgtPmNvbXByZXNzOwog
CXNwaW5fbG9ja19pbml0KCZ0Y3Bfc2VzLT5yZXFfbG9jayk7CiAJc3Bpbl9sb2NrX2luaXQoJnRj
cF9zZXMtPnNydl9sb2NrKTsKIAlzcGluX2xvY2tfaW5pdCgmdGNwX3Nlcy0+bWlkX2xvY2spOwpk
aWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC9mc19jb250ZXh0LmMgYi9mcy9zbWIvY2xpZW50L2Zz
X2NvbnRleHQuYwppbmRleCA0Yjc2N2VmYTQ3ZjEuLmJkY2JlNmZmMjczOSAxMDA2NDQKLS0tIGEv
ZnMvc21iL2NsaWVudC9mc19jb250ZXh0LmMKKysrIGIvZnMvc21iL2NsaWVudC9mc19jb250ZXh0
LmMKQEAgLTk2Myw3ICs5NjMsNyBAQCBzdGF0aWMgaW50IHNtYjNfZnNfY29udGV4dF9wYXJzZV9w
YXJhbShzdHJ1Y3QgZnNfY29udGV4dCAqZmMsCiAKIAlzd2l0Y2ggKG9wdCkgewogCWNhc2UgT3B0
X2NvbXByZXNzOgotCQljdHgtPmNvbXByZXNzaW9uID0gVU5LTk9XTl9UWVBFOworCQljdHgtPmNv
bXByZXNzID0gdHJ1ZTsKIAkJY2lmc19kYmcoVkZTLAogCQkJIlNNQjMgY29tcHJlc3Npb24gc3Vw
cG9ydCBpcyBleHBlcmltZW50YWxcbiIpOwogCQlicmVhazsKZGlmZiAtLWdpdCBhL2ZzL3NtYi9j
bGllbnQvZnNfY29udGV4dC5oIGIvZnMvc21iL2NsaWVudC9mc19jb250ZXh0LmgKaW5kZXggMWYw
OTc1NDk3N2U3Li43ODYzZjIyNDhjNGQgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvZnNfY29u
dGV4dC5oCisrKyBiL2ZzL3NtYi9jbGllbnQvZnNfY29udGV4dC5oCkBAIC0yNzMsNyArMjczLDcg
QEAgc3RydWN0IHNtYjNfZnNfY29udGV4dCB7CiAJdW5zaWduZWQgaW50IG1heF9jcmVkaXRzOyAv
KiBzbWIzIG1heF9jcmVkaXRzIDEwIDwgY3JlZGl0cyA8IDYwMDAwICovCiAJdW5zaWduZWQgaW50
IG1heF9jaGFubmVsczsKIAl1bnNpZ25lZCBpbnQgbWF4X2NhY2hlZF9kaXJzOwotCV9fdTE2IGNv
bXByZXNzaW9uOyAvKiBjb21wcmVzc2lvbiBhbGdvcml0aG0gMHhGRkZGIGRlZmF1bHQgMD1kaXNh
YmxlZCAqLworCWJvb2wgY29tcHJlc3M7IC8qIGVuYWJsZSBTTUIyIG1lc3NhZ2VzIChSRUFEL1dS
SVRFKSBkZS9jb21wcmVzc2lvbiAqLwogCWJvb2wgcm9vdGZzOjE7IC8qIGlmIGl0J3MgYSBTTUIg
cm9vdCBmaWxlIHN5c3RlbSAqLwogCWJvb2wgd2l0bmVzczoxOyAvKiB1c2Ugd2l0bmVzcyBwcm90
b2NvbCAqLwogCWNoYXIgKmxlYWZfZnVsbHBhdGg7CmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50
L3NtYjJwZHUuYyBiL2ZzL3NtYi9jbGllbnQvc21iMnBkdS5jCmluZGV4IDdkMDE1N2UwMDYxZS4u
NjBiM2Y4ZTQxYWEyIDEwMDY0NAotLS0gYS9mcy9zbWIvY2xpZW50L3NtYjJwZHUuYworKysgYi9m
cy9zbWIvY2xpZW50L3NtYjJwZHUuYwpAQCAtNzMxLDcgKzczMSw3IEBAIGFzc2VtYmxlX25lZ19j
b250ZXh0cyhzdHJ1Y3Qgc21iMl9uZWdvdGlhdGVfcmVxICpyZXEsCiAJcG5lZ19jdHh0ICs9IHNp
emVvZihzdHJ1Y3Qgc21iMl9wb3NpeF9uZWdfY29udGV4dCk7CiAJbmVnX2NvbnRleHRfY291bnQr
KzsKIAotCWlmIChzZXJ2ZXItPmNvbXByZXNzX2FsZ29yaXRobSkgeworCWlmIChzZXJ2ZXItPmNv
bXByZXNzaW9uLnJlcXVlc3RlZCkgewogCQlidWlsZF9jb21wcmVzc2lvbl9jdHh0KChzdHJ1Y3Qg
c21iMl9jb21wcmVzc2lvbl9jYXBhYmlsaXRpZXNfY29udGV4dCAqKQogCQkJCXBuZWdfY3R4dCk7
CiAJCWN0eHRfbGVuID0gQUxJR04oc2l6ZW9mKHN0cnVjdCBzbWIyX2NvbXByZXNzaW9uX2NhcGFi
aWxpdGllc19jb250ZXh0KSwgOCk7CkBAIC03NzksNiArNzc5LDkgQEAgc3RhdGljIHZvaWQgZGVj
b2RlX2NvbXByZXNzX2N0eChzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIsCiAJCQkgc3Ry
dWN0IHNtYjJfY29tcHJlc3Npb25fY2FwYWJpbGl0aWVzX2NvbnRleHQgKmN0eHQpCiB7CiAJdW5z
aWduZWQgaW50IGxlbiA9IGxlMTZfdG9fY3B1KGN0eHQtPkRhdGFMZW5ndGgpOworCV9fbGUxNiBh
bGc7CisKKwlzZXJ2ZXItPmNvbXByZXNzaW9uLmVuYWJsZWQgPSBmYWxzZTsKIAogCS8qCiAJICog
Q2FsbGVyIGNoZWNrZWQgdGhhdCBEYXRhTGVuZ3RoIHJlbWFpbnMgd2l0aGluIFNNQiBib3VuZGFy
eS4gV2Ugc3RpbGwKQEAgLTc4OSwxNSArNzkyLDIyIEBAIHN0YXRpYyB2b2lkIGRlY29kZV9jb21w
cmVzc19jdHgoc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2VydmVyLAogCQlwcl93YXJuX29uY2Uo
InNlcnZlciBzZW50IGJhZCBjb21wcmVzc2lvbiBjbnR4dFxuIik7CiAJCXJldHVybjsKIAl9CisK
IAlpZiAobGUxNl90b19jcHUoY3R4dC0+Q29tcHJlc3Npb25BbGdvcml0aG1Db3VudCkgIT0gMSkg
ewotCQlwcl93YXJuX29uY2UoIkludmFsaWQgU01CMyBjb21wcmVzcyBhbGdvcml0aG0gY291bnRc
biIpOworCQlwcl93YXJuX29uY2UoImludmFsaWQgU01CMyBjb21wcmVzcyBhbGdvcml0aG0gY291
bnRcbiIpOwogCQlyZXR1cm47CiAJfQotCWlmIChsZTE2X3RvX2NwdShjdHh0LT5Db21wcmVzc2lv
bkFsZ29yaXRobXNbMF0pID4gMykgewotCQlwcl93YXJuX29uY2UoInVua25vd24gY29tcHJlc3Np
b24gYWxnb3JpdGhtXG4iKTsKKworCWFsZyA9IGN0eHQtPkNvbXByZXNzaW9uQWxnb3JpdGhtc1sw
XTsKKworCS8qICdOT05FJyAoMCkgY29tcHJlc3NvciB0eXBlIGlzIG5ldmVyIG5lZ290aWF0ZWQg
Ki8KKwlpZiAoYWxnID09IDAgfHwgbGUxNl90b19jcHUoYWxnKSA+IDMpIHsKKwkJcHJfd2Fybl9v
bmNlKCJpbnZhbGlkIGNvbXByZXNzaW9uIGFsZ29yaXRobSAnJXUnXG4iLCBhbGcpOwogCQlyZXR1
cm47CiAJfQotCXNlcnZlci0+Y29tcHJlc3NfYWxnb3JpdGhtID0gY3R4dC0+Q29tcHJlc3Npb25B
bGdvcml0aG1zWzBdOworCisJc2VydmVyLT5jb21wcmVzc2lvbi5hbGcgPSBhbGc7CisJc2VydmVy
LT5jb21wcmVzc2lvbi5lbmFibGVkID0gdHJ1ZTsKIH0KIAogc3RhdGljIGludCBkZWNvZGVfZW5j
cnlwdF9jdHgoc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2VydmVyLAotLSAKMi40MC4xCgo=
--000000000000a17caf0613580eec--

