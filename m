Return-Path: <linux-cifs+bounces-482-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 97C77815112
	for <lists+linux-cifs@lfdr.de>; Fri, 15 Dec 2023 21:30:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C082FB23188
	for <lists+linux-cifs@lfdr.de>; Fri, 15 Dec 2023 20:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC70643170;
	Fri, 15 Dec 2023 20:30:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WeJdqwY1"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-lf1-f47.google.com (mail-lf1-f47.google.com [209.85.167.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F19B946531
	for <linux-cifs@vger.kernel.org>; Fri, 15 Dec 2023 20:30:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f47.google.com with SMTP id 2adb3069b0e04-50e18689828so1223717e87.2
        for <linux-cifs@vger.kernel.org>; Fri, 15 Dec 2023 12:30:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1702672209; x=1703277009; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=Zfvato7xeFiiRvNUXWN/ZG7YE0odu4fB/nCSNlJWxNU=;
        b=WeJdqwY15Gu+UT2ToJm4tySufcYPkjS5Uk+fMEInRCTzmxylNGzJSrsqd30cokCkOh
         pAaKkfnF3czHUi2h3x/CuTfTpSlUx18pfURuCInnxUA+N+uzRhvcoUaAgZpmb9yOLiK1
         MzyqOHt0Cv2farzUD12gJyNzHC1nXSFzdMjh99DNAc963UwSu1MqktkWqkXexLB5bTVJ
         mmM6GYWsmbluEugX5ivWHmAQCyoPXcIACd6y3kWWpehSECWMGnk9hGWJlP40VmrNWnra
         zqEzh7NM2cqgba/M0UwdE8EzS2FLqb3iQj0qP0xw77SnYUMt6ly7mrSzh/KzZNTOZknP
         aGSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702672209; x=1703277009;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Zfvato7xeFiiRvNUXWN/ZG7YE0odu4fB/nCSNlJWxNU=;
        b=v7hZg4QcJTOL3s27jZPfynMomj+KSLNuBCHn8fz3vTJ8pUAuSjUAB3RsRPC2afGpWo
         pFxopp5VF6TnNHth4tUSVbzwltSp6lJ5FJFhxN0hvu39ggJLuUAqCQLKWvhi+dyGSjPA
         3xy+1fj0s5md9eJzhxA204g7Itbnk50r4p5gwW0woH/GKv4rFx51q1oP338lskp7IqTy
         nvKEIXiDKMxq++37VlMrXsxnbSOfeujO1fLussFpTyYPGb2h+2iGR85jPHz4SxklWGkM
         zHTXQoqetmubzh7cQ80acCLkvMvrcllfJNGeUgwT7HpyJ8K3g7iI7WQHgaRWvW7fi9x0
         OJuA==
X-Gm-Message-State: AOJu0Yx8ht/va87wLnk/weJik/tbkc57Sjo4fG17DXLUqjGOmJAHq2jE
	i7BaKp1fIWvsoOUE4xuvK/TFryQzS7/AAfRVuQ1Fw1jl5GQ=
X-Google-Smtp-Source: AGHT+IGHgwJreU2XRtnoCdfsc0O3YKof+YjKoGUiKOeeFVWzOKnR443ZMEoJBIe1BvaeFbzgaHWt0WiyeCM0fAC82As=
X-Received: by 2002:a05:6512:108d:b0:50b:d4c7:193c with SMTP id
 j13-20020a056512108d00b0050bd4c7193cmr7394365lfg.24.1702672208342; Fri, 15
 Dec 2023 12:30:08 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Fri, 15 Dec 2023 14:29:56 -0600
Message-ID: <CAH2r5mu+LPjja0TqNaDq6yA3GSy0=uBryMXAd4RTZOWinHOkOA@mail.gmail.com>
Subject: [PATCHv2] smb3: allow files to be created with backslash in name
To: CIFS <linux-cifs@vger.kernel.org>, Paulo Alcantara <pc@manguebit.com>
Cc: samba-technical <samba-technical@lists.samba.org>, Xiaoli Feng <xifeng@redhat.com>
Content-Type: multipart/mixed; boundary="00000000000025f224060c924449"

--00000000000025f224060c924449
Content-Type: text/plain; charset="UTF-8"

Updated patch (rebased to current for-next-next)

Backslash is reserved in Windows (and SMB2/SMB3 by default) but
allowed in POSIX so must be remapped when POSIX extensions are
not enabled.

The default mapping for SMB3 mounts ("SFM") allows mapping backslash
(ie 0x5C in UTF8) to 0xF026 in UCS-2 (using the Unicode remapping
range reserved for these characters), but this was not mapped by
cifs.ko (unlike asterisk, greater than, question mark etc).  This patch
fixes that to allow creating files and directories with backslash
in the file or directory name.

Before this patch:
   touch "/mnt2/filewith\slash"
would return
   touch: setting times of '/mnt2/filewith\slash': Invalid argument

With the patch touch and mkdir with the backslash in the name works.

This problem was found while debugging xfstest generic/453
    https://bugzilla.kernel.org/show_bug.cgi?id=210961

Reported-by: Xiaoli Feng <xifeng@redhat.com>
Closes: https://bugzilla.kernel.org/show_bug.cgi?id=210961
Signed-off-by: Steve French <stfrench@microsoft.com>


@Paulo Alcantara  any thoughts if additional changes needed for DFS or
prefixpaths?

-- 
Thanks,

Steve

--00000000000025f224060c924449
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb3-allow-files-to-be-created-with-backslash-in-nam.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-allow-files-to-be-created-with-backslash-in-nam.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lq731rd70>
X-Attachment-Id: f_lq731rd70

RnJvbSBhYjFlN2NmMjcyZTkxM2Q1MzdiOTYwMDQ1M2JjOGU1Y2NiMjZlZTZkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IEZyaSwgMTUgRGVjIDIwMjMgMTQ6MjU6MDIgLTA2MDAKU3ViamVjdDogW1BBVENIXSBz
bWIzOiBhbGxvdyBmaWxlcyB0byBiZSBjcmVhdGVkIHdpdGggYmFja3NsYXNoIGluIG5hbWUKCkJh
Y2tzbGFzaCBpcyByZXNlcnZlZCBpbiBXaW5kb3dzIChhbmQgU01CMi9TTUIzIGJ5IGRlZmF1bHQp
IGJ1dAphbGxvd2VkIGluIFBPU0lYIHNvIG11c3QgYmUgcmVtYXBwZWQgd2hlbiBQT1NJWCBleHRl
bnNpb25zIGFyZQpub3QgZW5hYmxlZC4KClRoZSBkZWZhdWx0IG1hcHBpbmcgZm9yIFNNQjMgbW91
bnRzICgiU0ZNIikgYWxsb3dzIG1hcHBpbmcgYmFja3NsYXNoCihpZSAweDVDIGluIFVURjgpIHRv
IDB4RjAyNiBpbiBVQ1MtMiAodXNpbmcgdGhlIFVuaWNvZGUgcmVtYXBwaW5nCnJhbmdlIHJlc2Vy
dmVkIGZvciB0aGVzZSBjaGFyYWN0ZXJzKSwgYnV0IHRoaXMgd2FzIG5vdCBtYXBwZWQgYnkKY2lm
cy5rbyAodW5saWtlIGFzdGVyaXNrLCBncmVhdGVyIHRoYW4sIHF1ZXN0aW9uIG1hcmsgZXRjKS4g
IFRoaXMgcGF0Y2gKZml4ZXMgdGhhdCB0byBhbGxvdyBjcmVhdGluZyBmaWxlcyBhbmQgZGlyZWN0
b3JpZXMgd2l0aCBiYWNrc2xhc2gKaW4gdGhlIGZpbGUgb3IgZGlyZWN0b3J5IG5hbWUuCgpCZWZv
cmUgdGhpcyBwYXRjaDoKICAgdG91Y2ggIi9tbnQyL2ZpbGV3aXRoXHNsYXNoIgp3b3VsZCByZXR1
cm4KICAgdG91Y2g6IHNldHRpbmcgdGltZXMgb2YgJy9tbnQyL2ZpbGV3aXRoXHNsYXNoJzogSW52
YWxpZCBhcmd1bWVudAoKV2l0aCB0aGUgcGF0Y2ggdG91Y2ggYW5kIG1rZGlyIHdpdGggdGhlIGJh
Y2tzbGFzaCBpbiB0aGUgbmFtZSB3b3Jrcy4KClRoaXMgcHJvYmxlbSB3YXMgZm91bmQgd2hpbGUg
ZGVidWdnaW5nIHhmc3Rlc3QgZ2VuZXJpYy80NTMKICAgIGh0dHBzOi8vYnVnemlsbGEua2VybmVs
Lm9yZy9zaG93X2J1Zy5jZ2k/aWQ9MjEwOTYxCgpSZXBvcnRlZC1ieTogWGlhb2xpIEZlbmcgPHhp
ZmVuZ0ByZWRoYXQuY29tPgpDbG9zZXM6IGh0dHBzOi8vYnVnemlsbGEua2VybmVsLm9yZy9zaG93
X2J1Zy5jZ2k/aWQ9MjEwOTYxClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8c3RmcmVuY2hA
bWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9zbWIvY2xpZW50L2NpZnNfdW5pY29kZS5jIHwgMTUgKysr
KysrKysrKy0tLS0tCiBmcy9zbWIvY2xpZW50L2NpZnNfdW5pY29kZS5oIHwgIDMgKysrCiBmcy9z
bWIvY2xpZW50L2NpZnNnbG9iLmggICAgIHwgIDUgKy0tLS0KIGZzL3NtYi9jbGllbnQvZGlyLmMg
ICAgICAgICAgfCAxOCArKysrKysrKysrKystLS0tLS0KIGZzL3NtYi9jbGllbnQvc21iMm1pc2Mu
YyAgICAgfCAxOCArKysrKysrKysrKy0tLS0tLS0KIDUgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0
aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC9jaWZz
X3VuaWNvZGUuYyBiL2ZzL3NtYi9jbGllbnQvY2lmc191bmljb2RlLmMKaW5kZXggNzlkOTlhOTEz
OTQ0Li4wMjk2Njg1MzQxOWYgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvY2lmc191bmljb2Rl
LmMKKysrIGIvZnMvc21iL2NsaWVudC9jaWZzX3VuaWNvZGUuYwpAQCAtOTYsNiArOTYsOSBAQCBj
b252ZXJ0X3NmbV9jaGFyKGNvbnN0IF9fdTE2IHNyY19jaGFyLCBjaGFyICp0YXJnZXQpCiAJY2Fz
ZSBTRk1fUEVSSU9EOgogCQkqdGFyZ2V0ID0gJy4nOwogCQlicmVhazsKKwljYXNlIFNGTV9TTEFT
SDoKKwkJKnRhcmdldCA9ICdcXCc7CisJCWJyZWFrOwogCWRlZmF1bHQ6CiAJCXJldHVybiBmYWxz
ZTsKIAl9CkBAIC00MjQsNiArNDI3LDkgQEAgc3RhdGljIF9fbGUxNiBjb252ZXJ0X3RvX3NmbV9j
aGFyKGNoYXIgc3JjX2NoYXIsIGJvb2wgZW5kX29mX3N0cmluZykKIAljYXNlICd8JzoKIAkJZGVz
dF9jaGFyID0gY3B1X3RvX2xlMTYoU0ZNX1BJUEUpOwogCQlicmVhazsKKwljYXNlICdcXCc6CisJ
CWRlc3RfY2hhciA9IGNwdV90b19sZTE2KFNGTV9TTEFTSCk7CisJCWJyZWFrOwogCWNhc2UgJy4n
OgogCQlpZiAoZW5kX29mX3N0cmluZykKIAkJCWRlc3RfY2hhciA9IGNwdV90b19sZTE2KFNGTV9Q
RVJJT0QpOwpAQCAtNDM2LDYgKzQ0Miw5IEBAIHN0YXRpYyBfX2xlMTYgY29udmVydF90b19zZm1f
Y2hhcihjaGFyIHNyY19jaGFyLCBib29sIGVuZF9vZl9zdHJpbmcpCiAJCWVsc2UKIAkJCWRlc3Rf
Y2hhciA9IDA7CiAJCWJyZWFrOworCWNhc2UgJy8nOgorCQlkZXN0X2NoYXIgPSBjcHVfdG9fbGUx
NihVQ1MyX1NMQVNIKTsKKwkJYnJlYWs7CiAJZGVmYXVsdDoKIAkJZGVzdF9jaGFyID0gMDsKIAl9
CkBAIC00OTUsMTEgKzUwNCw3IEBAIGNpZnNDb252ZXJ0VG9VVEYxNihfX2xlMTYgKnRhcmdldCwg
Y29uc3QgY2hhciAqc291cmNlLCBpbnQgc3JjbGVuLAogCQkJZHN0X2NoYXIgPSBjb252ZXJ0X3Rv
X3NmbV9jaGFyKHNyY19jaGFyLCBlbmRfb2Zfc3RyaW5nKTsKIAkJfSBlbHNlCiAJCQlkc3RfY2hh
ciA9IDA7Ci0JCS8qCi0JCSAqIEZJWE1FOiBXZSBjYW4gbm90IGhhbmRsZSByZW1hcHBpbmcgYmFj
a3NsYXNoIChVTklfU0xBU0gpCi0JCSAqIHVudGlsIGFsbCB0aGUgY2FsbHMgdG8gYnVpbGRfcGF0
aF9mcm9tX2RlbnRyeSBhcmUgbW9kaWZpZWQsCi0JCSAqIGFzIHRoZXkgdXNlIGJhY2tzbGFzaCBh
cyBzZXBhcmF0b3IuCi0JCSAqLworCiAJCWlmIChkc3RfY2hhciA9PSAwKSB7CiAJCQljaGFybGVu
ID0gY3AtPmNoYXIydW5pKHNvdXJjZSArIGksIHNyY2xlbiAtIGksICZ0bXApOwogCQkJZHN0X2No
YXIgPSBjcHVfdG9fbGUxNih0bXApOwpkaWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC9jaWZzX3Vu
aWNvZGUuaCBiL2ZzL3NtYi9jbGllbnQvY2lmc191bmljb2RlLmgKaW5kZXggZTEzN2EwZGZiYmU5
Li40ZDQxNDk2NmY1MDQgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvY2lmc191bmljb2RlLmgK
KysrIGIvZnMvc21iL2NsaWVudC9jaWZzX3VuaWNvZGUuaApAQCAtMjMsNiArMjMsOSBAQAogI2lu
Y2x1ZGUgPGxpbnV4L25scy5oPgogI2luY2x1ZGUgIi4uLy4uL25scy9ubHNfdWNzMl91dGlscy5o
IgogCisvKiBVbmljb2RlIGVuY29kaW5nIG9mIGJhY2tzbGFzaCBjaGFyYWN0ZXIgKi8KKyNkZWZp
bmUgVUNTMl9TTEFTSCAweDAwNUMKKwogLyoKICAqIE1hY3MgdXNlIGFuIG9sZGVyICJTRk0iIG1h
cHBpbmcgb2YgdGhlIHN5bWJvbHMgYWJvdmUuIEZvcnR1bmF0ZWx5IGl0IGRvZXMKICAqIG5vdCBj
b25mbGljdCAoYWx0aG91Z2ggYWxtb3N0IGRvZXMpIHdpdGggdGhlIG1hcHBpbmcgYWJvdmUuCmRp
ZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L2NpZnNnbG9iLmggYi9mcy9zbWIvY2xpZW50L2NpZnNn
bG9iLmgKaW5kZXggNTViM2NlOTQ0MDIyLi5lNmY0YTI4Mjc1YTggMTAwNjQ0Ci0tLSBhL2ZzL3Nt
Yi9jbGllbnQvY2lmc2dsb2IuaAorKysgYi9mcy9zbWIvY2xpZW50L2NpZnNnbG9iLmgKQEAgLTE1
NjgsMTAgKzE1NjgsNyBAQCBDSUZTX0ZJTEVfU0Ioc3RydWN0IGZpbGUgKmZpbGUpCiAKIHN0YXRp
YyBpbmxpbmUgY2hhciBDSUZTX0RJUl9TRVAoY29uc3Qgc3RydWN0IGNpZnNfc2JfaW5mbyAqY2lm
c19zYikKIHsKLQlpZiAoY2lmc19zYi0+bW50X2NpZnNfZmxhZ3MgJiBDSUZTX01PVU5UX1BPU0lY
X1BBVEhTKQotCQlyZXR1cm4gJy8nOwotCWVsc2UKLQkJcmV0dXJuICdcXCc7CisJcmV0dXJuICcv
JzsKIH0KIAogc3RhdGljIGlubGluZSB2b2lkCmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L2Rp
ci5jIGIvZnMvc21iL2NsaWVudC9kaXIuYwppbmRleCA1ODBhMjdhM2E3ZTYuLjZjNDQ2YjEyMTBi
YSAxMDA2NDQKLS0tIGEvZnMvc21iL2NsaWVudC9kaXIuYworKysgYi9mcy9zbWIvY2xpZW50L2Rp
ci5jCkBAIC0xNjAsMTIgKzE2MCwxOCBAQCBjaGVja19uYW1lKHN0cnVjdCBkZW50cnkgKmRpcmVu
dHJ5LCBzdHJ1Y3QgY2lmc190Y29uICp0Y29uKQogCQkgICAgIGxlMzJfdG9fY3B1KHRjb24tPmZz
QXR0ckluZm8uTWF4UGF0aE5hbWVDb21wb25lbnRMZW5ndGgpKSkKIAkJcmV0dXJuIC1FTkFNRVRP
T0xPTkc7CiAKLQlpZiAoIShjaWZzX3NiLT5tbnRfY2lmc19mbGFncyAmIENJRlNfTU9VTlRfUE9T
SVhfUEFUSFMpKSB7Ci0JCWZvciAoaSA9IDA7IGkgPCBkaXJlbnRyeS0+ZF9uYW1lLmxlbjsgaSsr
KSB7Ci0JCQlpZiAoZGlyZW50cnktPmRfbmFtZS5uYW1lW2ldID09ICdcXCcpIHsKLQkJCQljaWZz
X2RiZyhGWUksICJJbnZhbGlkIGZpbGUgbmFtZVxuIik7Ci0JCQkJcmV0dXJuIC1FSU5WQUw7Ci0J
CQl9CisJLyoKKwkgKiBTTUIzLjEuMSBQT1NJWCBFeHRlbnNpb25zLCBDSUZTIFVuaXggRXh0ZW5z
aW9ucyBhbmQgU0ZNIG1hcHBpbmdzCisJICogYWxsb3cgXCBpbiBwYXRocyAob3IgaW4gbGF0dGVy
IGNhc2UgcmVtYXBzIFwgdG8gMHhGMDI2KQorCSAqLworCWlmICgoY2lmc19zYi0+bW50X2NpZnNf
ZmxhZ3MgJiBDSUZTX01PVU5UX1BPU0lYX1BBVEhTKSB8fAorCSAgICAoY2lmc19zYi0+bW50X2Np
ZnNfZmxhZ3MgJiBDSUZTX01PVU5UX01BUF9TRk1fQ0hSKSkKKwkJcmV0dXJuIDA7CisKKwlmb3Ig
KGkgPSAwOyBpIDwgZGlyZW50cnktPmRfbmFtZS5sZW47IGkrKykgeworCQlpZiAoZGlyZW50cnkt
PmRfbmFtZS5uYW1lW2ldID09ICdcXCcpIHsKKwkJCWNpZnNfZGJnKEZZSSwgIkludmFsaWQgZmls
ZSBuYW1lXG4iKTsKKwkJCXJldHVybiAtRUlOVkFMOwogCQl9CiAJfQogCXJldHVybiAwOwpkaWZm
IC0tZ2l0IGEvZnMvc21iL2NsaWVudC9zbWIybWlzYy5jIGIvZnMvc21iL2NsaWVudC9zbWIybWlz
Yy5jCmluZGV4IGUyMGI0MzU0ZTcwMy4uMGVkYzg4OGVjM2Y4IDEwMDY0NAotLS0gYS9mcy9zbWIv
Y2xpZW50L3NtYjJtaXNjLmMKKysrIGIvZnMvc21iL2NsaWVudC9zbWIybWlzYy5jCkBAIC00Njks
MTMgKzQ2OSwxNyBAQCBjaWZzX2NvbnZlcnRfcGF0aF90b191dGYxNihjb25zdCBjaGFyICpmcm9t
LCBzdHJ1Y3QgY2lmc19zYl9pbmZvICpjaWZzX3NiKQogCWlmIChmcm9tWzBdID09ICdcXCcpCiAJ
CXN0YXJ0X29mX3BhdGggPSBmcm9tICsgMTsKIAotCS8qIFNNQjMxMSBQT1NJWCBleHRlbnNpb25z
IHBhdGhzIGRvIG5vdCBpbmNsdWRlIGxlYWRpbmcgc2xhc2ggKi8KLQllbHNlIGlmIChjaWZzX3Ni
X21hc3Rlcl90bGluayhjaWZzX3NiKSAmJgotCQkgY2lmc19zYl9tYXN0ZXJfdGNvbihjaWZzX3Ni
KS0+cG9zaXhfZXh0ZW5zaW9ucyAmJgotCQkgKGZyb21bMF0gPT0gJy8nKSkgewotCQlzdGFydF9v
Zl9wYXRoID0gZnJvbSArIDE7Ci0JfSBlbHNlCi0JCXN0YXJ0X29mX3BhdGggPSBmcm9tOworCXN0
YXJ0X29mX3BhdGggPSBmcm9tOworCS8qCisJICogT25seSBvbGQgQ0lGUyBVbml4IGV4dGVuc2lv
bnMgcGF0aHMgaW5jbHVkZSBsZWFkaW5nIHNsYXNoCisJICogTmVlZCB0byBza2lwIGlmIGZvciBT
TUIzLjEuMSBQT1NJWCBFeHRlbnNpb25zIGFuZCBTTUIxLzIvMworCSAqLworCWlmIChmcm9tWzBd
ID09ICcvJykgeworCQlpZiAoKChjaWZzX3NiLT5tbnRfY2lmc19mbGFncyAmIENJRlNfTU9VTlRf
UE9TSVhfUEFUSFMpID09IGZhbHNlKSB8fAorCQkgICAgKGNpZnNfc2JfbWFzdGVyX3RsaW5rKGNp
ZnNfc2IpICYmCisJCSAgICAgKGNpZnNfc2JfbWFzdGVyX3Rjb24oY2lmc19zYiktPnBvc2l4X2V4
dGVuc2lvbnMpKSkKKwkJCXN0YXJ0X29mX3BhdGggPSBmcm9tICsgMTsKKwl9CiAKIAl0byA9IGNp
ZnNfc3RybmR1cF90b191dGYxNihzdGFydF9vZl9wYXRoLCBQQVRIX01BWCwgJmxlbiwKIAkJCQkg
ICBjaWZzX3NiLT5sb2NhbF9ubHMsIG1hcF90eXBlKTsKLS0gCjIuNDAuMQoK
--00000000000025f224060c924449--

