Return-Path: <linux-cifs+bounces-2396-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id EEB069407A7
	for <lists+linux-cifs@lfdr.de>; Tue, 30 Jul 2024 07:34:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7D2F12837C2
	for <lists+linux-cifs@lfdr.de>; Tue, 30 Jul 2024 05:34:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E2F6524C;
	Tue, 30 Jul 2024 05:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qi6MMfHP"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52CD233D5
	for <linux-cifs@vger.kernel.org>; Tue, 30 Jul 2024 05:34:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722317671; cv=none; b=kbzdiU6qHhrGNOv7cQ6pf6g6IBFZDIxtWcshLqqiAQ3Dw6O4VNdx5cq5FbmkBNaNaoV+PTMqSM9jJBxGHOe61RGWE+wI82Lfaqsl0gLTkmmZCFg2wCk1txP1Iwbkr+9LOYaQqMwcmlmyk0BimKUptq0oTPvQFS5IUatdAqpb+JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722317671; c=relaxed/simple;
	bh=eECQ5ULEyDbnTHint+4kJiJHno01tnPPBuJkGnQHyyU=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=DFRybVSODf/iwJLDHxnG8RBeijddPJFMNTjz3UMxZrUcG76xQX0gmrO6SIfDihSc2gED5evdUgF+LFN7q/jsV2nVq9o333bzYvpPIuzWE9g69hOKu736vdxr5Tw7my9N318aSvpUZbN7QecHX6ycx7FcDsHQIlQJOLOJM2d9ruY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qi6MMfHP; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2ef2d582e31so51094181fa.2
        for <linux-cifs@vger.kernel.org>; Mon, 29 Jul 2024 22:34:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722317667; x=1722922467; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=19YrcVfbExCDN8xnesR19+Kpu0uBX9NNvTzVMFyg3tg=;
        b=Qi6MMfHP+CMnqcGQqAYBY7QkZVqxMsNGVjm5pjoD5+gCpBHlSONgqAX9cwXKk9DblC
         lgm1i+9smKn4yukf9IxkFiV+c0ovFXrWztOS19+jDTNCOjnKt7Qs7NB2HyDnmFQXqB9z
         yPRu+65Zu3+cSdNcq/isfx9Lxxw4R1M9ah1JIMDBlBGgnL5OCcPX8uRNeaQT8UUFoD1D
         s6SCKJVYoePNl9ryWhficMHEFsjqar1W4fscolLeIASt5d5BStBoD2GlvymrfBYNdtXd
         yrMOBPF7OFDaTX6pix2mjVXDp62qVFPQomTH7ne03oJYuOL+2t0C2Bm7ycvyQZ8a2uDH
         DYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722317667; x=1722922467;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=19YrcVfbExCDN8xnesR19+Kpu0uBX9NNvTzVMFyg3tg=;
        b=OmtyMNci+xk8gg7OJMKB8iolwzqAE59/16D9uPcfYo5gBp/O2mY50pq9+70Y29xjut
         XIq7H5eR/a+d4fC17yph310QD5nfsb50KGs6iC60K7VdWY6Zg4L4c3oFx5I7SAjmYlcj
         Xk3J9AbD6azrDn6Wd0qW2fq0m3Hy23g8A286ia7UDae7nXw7Qq+4zOnQsSnPVrJetSvU
         r5uT0kUnUqv98nH8bLvlW8dOTknKRAZ2vOmwZzHRUCEAZjhJAVRoj95ZS32mf4SY2sid
         KipmQbcG42zNTbX2h/P8C5AMxZCr2eR7FGzf7B4jlu2lOpXcKQd5PsshhqmzAgCJrNgx
         +b/g==
X-Gm-Message-State: AOJu0YwDKJq8yTt1qZkmgdxCfFjwdjMnWFNrqtVB4f+opneqVahJ7y03
	6ptoKFQcGwAh4lhxXqCUaceqFa+gj0zV1j0NpJsg8PxPVWRQw5l6WuuDaH1oJPkhl+SxW4F9nZJ
	9/rKtPfspll2CYgh8smYDwzfbc8QxyQYP
X-Google-Smtp-Source: AGHT+IEmLgsM40YzHW/ueFQ/wlpk+VoNspG4Z6iuBKs0oSRoL/biWXYD41vH5gSAdeMh+KkPKWAO2a6MZIycuhq+lJ4=
X-Received: by 2002:a2e:9619:0:b0:2ef:2e3f:35da with SMTP id
 38308e7fff4ca-2f12ee634famr57909211fa.45.1722317666883; Mon, 29 Jul 2024
 22:34:26 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Tue, 30 Jul 2024 00:34:15 -0500
Message-ID: <CAH2r5msodFELeYf5h3h1qqR-tgaE6ZNMMbWvFbFDzCjDjPnqsA@mail.gmail.com>
Subject: [PATCH][SMB3 client] add dynamic tracepoints for shutdown ioctl
To: CIFS <linux-cifs@vger.kernel.org>
Cc: Shyam Prasad N <nspmangalore@gmail.com>, Bharath S M <bharathsm@microsoft.com>
Content-Type: multipart/mixed; boundary="000000000000b9bf00061e7054c9"

--000000000000b9bf00061e7054c9
Content-Type: text/plain; charset="UTF-8"

For debugging an umount failure in xfstests generic/043 generic/044 in some
configurations, we needed more information on the shutdown ioctl which
was suspected of being related to the cause, so tracepoints are added
in this patch e.g.

  "trace-cmd record -e smb3_shutdown_enter -e smb3_shutdown_done -e
smb3_shutdown_err"

Sample output:
  godown-47084   [011] .....  3313.756965: smb3_shutdown_enter:
flags=0x1 tid=0x733b3e75
  godown-47084   [011] .....  3313.756968: smb3_shutdown_done:
flags=0x1 tid=0x733b3e75

See attached



-- 
Thanks,

Steve

--000000000000b9bf00061e7054c9
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb3-add-dynamic-tracepoints-for-shutdown-ioctl.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-add-dynamic-tracepoints-for-shutdown-ioctl.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lz7zfnt70>
X-Attachment-Id: f_lz7zfnt70

RnJvbSAwYWVhZTM0M2RhNjlhZjhjMDUxNmI2NjUwMzEyYmU1MTdkNGZmNmE4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFR1ZSwgMzAgSnVsIDIwMjQgMDA6MjY6MjEgLTA1MDAKU3ViamVjdDogW1BBVENIXSBz
bWIzOiBhZGQgZHluYW1pYyB0cmFjZXBvaW50cyBmb3Igc2h1dGRvd24gaW9jdGwKCkZvciBkZWJ1
Z2dpbmcgYW4gdW1vdW50IGZhaWx1cmUgaW4geGZzdGVzdHMgZ2VuZXJpYy8wNDMgZ2VuZXJpYy8w
NDQgaW4gc29tZQpjb25maWd1cmF0aW9ucywgd2UgbmVlZGVkIG1vcmUgaW5mb3JtYXRpb24gb24g
dGhlIHNodXRkb3duIGlvY3RsIHdoaWNoCndhcyBzdXNwZWN0ZWQgb2YgYmVpbmcgcmVsYXRlZCB0
byB0aGUgY2F1c2UsIHNvIHRyYWNlcG9pbnRzIGFyZSBhZGRlZAppbiB0aGlzIHBhdGNoIGUuZy4K
CiAgInRyYWNlLWNtZCByZWNvcmQgLWUgc21iM19zaHV0ZG93bl9lbnRlciAtZSBzbWIzX3NodXRk
b3duX2RvbmUgLWUgc21iM19zaHV0ZG93bl9lcnIiCgpTYW1wbGUgb3V0cHV0OgogIGdvZG93bi00
NzA4NCAgIFswMTFdIC4uLi4uICAzMzEzLjc1Njk2NTogc21iM19zaHV0ZG93bl9lbnRlcjogZmxh
Z3M9MHgxIHRpZD0weDczM2IzZTc1CiAgZ29kb3duLTQ3MDg0ICAgWzAxMV0gLi4uLi4gIDMzMTMu
NzU2OTY4OiBzbWIzX3NodXRkb3duX2RvbmU6IGZsYWdzPTB4MSB0aWQ9MHg3MzNiM2U3NQoKU2ln
bmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5jaEBtaWNyb3NvZnQuY29tPgotLS0KIGZz
L3NtYi9jbGllbnQvaW9jdGwuYyB8IDM4ICsrKysrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
CiBmcy9zbWIvY2xpZW50L3RyYWNlLmggfCA1MSArKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKystCiAyIGZpbGVzIGNoYW5nZWQsIDc5IGluc2VydGlvbnMoKyksIDEwIGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvaW9jdGwuYyBiL2ZzL3NtYi9j
bGllbnQvaW9jdGwuYwppbmRleCA4NTVhYzVhNjJlZGYuLjkwYmIyYzk4OWFhYiAxMDA2NDQKLS0t
IGEvZnMvc21iL2NsaWVudC9pb2N0bC5jCisrKyBiL2ZzL3NtYi9jbGllbnQvaW9jdGwuYwpAQCAt
MTcwLDIyICsxNzAsMzQgQEAgc3RhdGljIGxvbmcgc21iX21udF9nZXRfZnNpbmZvKHVuc2lnbmVk
IGludCB4aWQsIHN0cnVjdCBjaWZzX3Rjb24gKnRjb24sCiBzdGF0aWMgaW50IGNpZnNfc2h1dGRv
d24oc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgdW5zaWduZWQgbG9uZyBhcmcpCiB7CiAJc3RydWN0
IGNpZnNfc2JfaW5mbyAqc2JpID0gQ0lGU19TQihzYik7CisJc3RydWN0IHRjb25fbGluayAqdGxp
bms7CisJc3RydWN0IGNpZnNfdGNvbiAqdGNvbjsKIAlfX3UzMiBmbGFnczsKKwlpbnQgcmM7CiAK
LQlpZiAoIWNhcGFibGUoQ0FQX1NZU19BRE1JTikpCi0JCXJldHVybiAtRVBFUk07CisJaWYgKCFj
YXBhYmxlKENBUF9TWVNfQURNSU4pKSB7CisJCXJjID0gLUVQRVJNOworCQlnb3RvIHNodXRkb3du
X291dF9lcnI7CisJfQogCiAJaWYgKGdldF91c2VyKGZsYWdzLCAoX191MzIgX191c2VyICopYXJn
KSkKIAkJcmV0dXJuIC1FRkFVTFQ7CiAKLQlpZiAoZmxhZ3MgPiBDSUZTX0dPSU5HX0ZMQUdTX05P
TE9HRkxVU0gpCi0JCXJldHVybiAtRUlOVkFMOworCXRsaW5rID0gY2lmc19zYl90bGluayhzYmkp
OworCWlmIChJU19FUlIodGxpbmspKQorCQlyZXR1cm4gUFRSX0VSUih0bGluayk7CisJdGNvbiA9
IHRsaW5rX3Rjb24odGxpbmspOworCisJdHJhY2Vfc21iM19zaHV0ZG93bl9lbnRlcihmbGFncywg
dGNvbi0+dGlkKTsKKwlpZiAoZmxhZ3MgPiBDSUZTX0dPSU5HX0ZMQUdTX05PTE9HRkxVU0gpIHsK
KwkJcmMgPSAtRUlOVkFMOworCQlnb3RvIHNodXRkb3duX291dF9lcnI7CisJfQogCiAJaWYgKGNp
ZnNfZm9yY2VkX3NodXRkb3duKHNiaSkpCi0JCXJldHVybiAwOworCQlnb3RvIHNodXRkb3duX2dv
b2Q7CiAKIAljaWZzX2RiZyhWRlMsICJzaHV0IGRvd24gcmVxdWVzdGVkICglZCkiLCBmbGFncyk7
Ci0vKgl0cmFjZV9jaWZzX3NodXRkb3duKHNiLCBmbGFncyk7Ki8KIAogCS8qCiAJICogc2VlOgpA
QCAtMjAxLDcgKzIxMyw4IEBAIHN0YXRpYyBpbnQgY2lmc19zaHV0ZG93bihzdHJ1Y3Qgc3VwZXJf
YmxvY2sgKnNiLCB1bnNpZ25lZCBsb25nIGFyZykKIAkgKi8KIAljYXNlIENJRlNfR09JTkdfRkxB
R1NfREVGQVVMVDoKIAkJY2lmc19kYmcoRllJLCAic2h1dGRvd24gd2l0aCBkZWZhdWx0IGZsYWcg
bm90IHN1cHBvcnRlZFxuIik7Ci0JCXJldHVybiAtRUlOVkFMOworCQlyYyA9IC1FSU5WQUw7CisJ
CWdvdG8gc2h1dGRvd25fb3V0X2VycjsKIAkvKgogCSAqIEZMQUdTX0xPR0ZMVVNIIGlzIGVhc3kg
c2luY2UgaXQgYXNrcyB0byB3cml0ZSBvdXQgbWV0YWRhdGEgKG5vdAogCSAqIGRhdGEpIGJ1dCBt
ZXRhZGF0YSB3cml0ZXMgYXJlIG5vdCBjYWNoZWQgb24gdGhlIGNsaWVudCwgc28gY2FuIHRyZWF0
CkBAIC0yMTAsMTEgKzIyMywxOCBAQCBzdGF0aWMgaW50IGNpZnNfc2h1dGRvd24oc3RydWN0IHN1
cGVyX2Jsb2NrICpzYiwgdW5zaWduZWQgbG9uZyBhcmcpCiAJY2FzZSBDSUZTX0dPSU5HX0ZMQUdT
X0xPR0ZMVVNIOgogCWNhc2UgQ0lGU19HT0lOR19GTEFHU19OT0xPR0ZMVVNIOgogCQlzYmktPm1u
dF9jaWZzX2ZsYWdzIHw9IENJRlNfTU9VTlRfU0hVVERPV047Ci0JCXJldHVybiAwOworCQlnb3Rv
IHNodXRkb3duX2dvb2Q7CiAJZGVmYXVsdDoKLQkJcmV0dXJuIC1FSU5WQUw7CisJCXJjID0gLUVJ
TlZBTDsKKwkJZ290byBzaHV0ZG93bl9vdXRfZXJyOwogCX0KKworc2h1dGRvd25fZ29vZDoKKwl0
cmFjZV9zbWIzX3NodXRkb3duX2RvbmUoZmxhZ3MsIHRjb24tPnRpZCk7CiAJcmV0dXJuIDA7Citz
aHV0ZG93bl9vdXRfZXJyOgorCXRyYWNlX3NtYjNfc2h1dGRvd25fZXJyKHJjLCBmbGFncywgdGNv
bi0+dGlkKTsKKwlyZXR1cm4gcmM7CiB9CiAKIHN0YXRpYyBpbnQgY2lmc19kdW1wX2Z1bGxfa2V5
KHN0cnVjdCBjaWZzX3Rjb24gKnRjb24sIHN0cnVjdCBzbWIzX2Z1bGxfa2V5X2RlYnVnX2luZm8g
X191c2VyICppbikKZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvdHJhY2UuaCBiL2ZzL3NtYi9j
bGllbnQvdHJhY2UuaAppbmRleCA2YjNiZGZiOTcyMTEuLjBmMGMxMGM3YWRhNyAxMDA2NDQKLS0t
IGEvZnMvc21iL2NsaWVudC90cmFjZS5oCisrKyBiL2ZzL3NtYi9jbGllbnQvdHJhY2UuaApAQCAt
MTM4OCw3ICsxMzg4LDcgQEAgREVDTEFSRV9FVkVOVF9DTEFTUyhzbWIzX2lvY3RsX2NsYXNzLAog
CQlfX2VudHJ5LT5jb21tYW5kID0gY29tbWFuZDsKIAkpLAogCVRQX3ByaW50aygieGlkPSV1IGZp
ZD0weCVsbHggaW9jdGwgY21kPTB4JXgiLAotCQlfX2VudHJ5LT54aWQsIF9fZW50cnktPmZpZCwg
X19lbnRyeS0+Y29tbWFuZCkKKwkJICBfX2VudHJ5LT54aWQsIF9fZW50cnktPmZpZCwgX19lbnRy
eS0+Y29tbWFuZCkKICkKIAogI2RlZmluZSBERUZJTkVfU01CM19JT0NUTF9FVkVOVChuYW1lKSAg
ICAgICAgXApAQCAtMTQwMCw5ICsxNDAwLDU4IEBAIERFRklORV9FVkVOVChzbWIzX2lvY3RsX2Ns
YXNzLCBzbWIzXyMjbmFtZSwgIFwKIAogREVGSU5FX1NNQjNfSU9DVExfRVZFTlQoaW9jdGwpOwog
CitERUNMQVJFX0VWRU5UX0NMQVNTKHNtYjNfc2h1dGRvd25fY2xhc3MsCisJVFBfUFJPVE8oX191
MzIgZmxhZ3MsCisJCV9fdTMyIHRpZCksCisJVFBfQVJHUyhmbGFncywgdGlkKSwKKwlUUF9TVFJV
Q1RfX2VudHJ5KAorCQlfX2ZpZWxkKF9fdTMyLCBmbGFncykKKwkJX19maWVsZChfX3UzMiwgdGlk
KQorCSksCisJVFBfZmFzdF9hc3NpZ24oCisJCV9fZW50cnktPmZsYWdzID0gZmxhZ3M7CisJCV9f
ZW50cnktPnRpZCA9IHRpZDsKKwkpLAorCVRQX3ByaW50aygiZmxhZ3M9MHgleCB0aWQ9MHgleCIs
CisJCSAgX19lbnRyeS0+ZmxhZ3MsIF9fZW50cnktPnRpZCkKKykKKworI2RlZmluZSBERUZJTkVf
U01CM19TSFVURE9XTl9FVkVOVChuYW1lKSAgICAgICAgXAorREVGSU5FX0VWRU5UKHNtYjNfc2h1
dGRvd25fY2xhc3MsIHNtYjNfIyNuYW1lLCAgXAorCVRQX1BST1RPKF9fdTMyIGZsYWdzLAkJICAg
ICBcCisJCV9fdTMyIHRpZCksCQkgICAgIFwKKwlUUF9BUkdTKGZsYWdzLCB0aWQpKQorCitERUZJ
TkVfU01CM19TSFVURE9XTl9FVkVOVChzaHV0ZG93bl9lbnRlcik7CitERUZJTkVfU01CM19TSFVU
RE9XTl9FVkVOVChzaHV0ZG93bl9kb25lKTsKIAorREVDTEFSRV9FVkVOVF9DTEFTUyhzbWIzX3No
dXRkb3duX2Vycl9jbGFzcywKKwlUUF9QUk9UTyhpbnQgcmMsCisJCV9fdTMyIGZsYWdzLAorCQlf
X3UzMiB0aWQpLAorCVRQX0FSR1MocmMsIGZsYWdzLCB0aWQpLAorCVRQX1NUUlVDVF9fZW50cnko
CisJCV9fZmllbGQoaW50LCByYykKKwkJX19maWVsZChfX3UzMiwgZmxhZ3MpCisJCV9fZmllbGQo
X191MzIsIHRpZCkKKwkpLAorCVRQX2Zhc3RfYXNzaWduKAorCQlfX2VudHJ5LT5yYyA9IHJjOwor
CQlfX2VudHJ5LT5mbGFncyA9IGZsYWdzOworCQlfX2VudHJ5LT50aWQgPSB0aWQ7CisJKSwKKwlU
UF9wcmludGsoInJjPSVkIGZsYWdzPTB4JXggdGlkPTB4JXgiLAorCQlfX2VudHJ5LT5yYywgX19l
bnRyeS0+ZmxhZ3MsIF9fZW50cnktPnRpZCkKKykKIAorI2RlZmluZSBERUZJTkVfU01CM19TSFVU
RE9XTl9FUlJfRVZFTlQobmFtZSkgICAgICAgIFwKK0RFRklORV9FVkVOVChzbWIzX3NodXRkb3du
X2Vycl9jbGFzcywgc21iM18jI25hbWUsICBcCisJVFBfUFJPVE8oaW50IHJjLAkJICAgICBcCisJ
CV9fdTMyIGZsYWdzLAkJICAgICBcCisJCV9fdTMyIHRpZCksCQkgICAgIFwKKwlUUF9BUkdTKHJj
LCBmbGFncywgdGlkKSkKIAorREVGSU5FX1NNQjNfU0hVVERPV05fRVJSX0VWRU5UKHNodXRkb3du
X2Vycik7CiAKIERFQ0xBUkVfRVZFTlRfQ0xBU1Moc21iM19jcmVkaXRfY2xhc3MsCiAJVFBfUFJP
VE8oX191NjQJY3Vycm1pZCwKLS0gCjIuNDMuMAoK
--000000000000b9bf00061e7054c9--

