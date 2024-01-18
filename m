Return-Path: <linux-cifs+bounces-834-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C40831064
	for <lists+linux-cifs@lfdr.de>; Thu, 18 Jan 2024 01:13:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33B131F226EC
	for <lists+linux-cifs@lfdr.de>; Thu, 18 Jan 2024 00:13:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 33389191;
	Thu, 18 Jan 2024 00:13:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dqGzOJHD"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-lj1-f172.google.com (mail-lj1-f172.google.com [209.85.208.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58810623
	for <linux-cifs@vger.kernel.org>; Thu, 18 Jan 2024 00:13:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705536800; cv=none; b=Lmg0NykSUrval1AWBcIW+ys2N3jvTXmM30p4nhxcdxHx5eEBSU6HlO8/JQqlBQVFSHDQAhtKXKOWI9DI6fQjmujWTP77C1OY6mXS0l48kvSNEjTdbi1DwyUVp155R5VopF7D2EDYx3p3GVcz/0d5mLcoDvblARu61CJLuynZFgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705536800; c=relaxed/simple;
	bh=Tr0wgWj7R3C0gTqnR5lavFZRisnEfi+CxDz0K+TYS0g=;
	h=Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Google-Smtp-Source:X-Received:MIME-Version:
	 From:Date:Message-ID:Subject:To:Content-Type; b=nCjikAOSJXUCqwawQjkOxjU4mAEFn+SRqAO76WE73CWcaGlnwBqZ17WEMmmU3YUo992+pLmd4LO/p5iOs9McEfAcq07rKjQ/+YEwhKpcCfmi/Yp5Irn6vRlM5TE4kEvUc/r++e87lYwM6DEU8bpIxtGDEBN9UJj50ecR8r1eN1c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dqGzOJHD; arc=none smtp.client-ip=209.85.208.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-2cd1232a2c7so147042731fa.0
        for <linux-cifs@vger.kernel.org>; Wed, 17 Jan 2024 16:13:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1705536796; x=1706141596; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=9i8qODXe002QMPDdMmztpO3Oxegq4Xx5PYFd8vnb1Mk=;
        b=dqGzOJHDe1RkDgQKJqCkGk0kTRt6LO6BL7yKO2qS0yL9gu89/Zi2kAufsCtKAN1UJf
         yemiscsl5YFCW1ZZEMlG+WRDNA/kf13ekdG0423Z0dyWSt7HiiDBT62tgCJQmVPRMM61
         X8z+ynsXmsR5pX9P+PJPzPVfvfRddGRqt5kHbaAWw0tHKwd9y8PzTdR9dCSCIwFEnZ9k
         rTqLeUj6ccOFGoIOK0C96L3C18Uu46A/5UVqxMGRE7aDLhfWHi4OP7lUm1t0qkNxSypL
         zD7rrzxWBkrPkU+INuy0+F9M/PRb+Zf2i5oLDNdJtVNF6XFpoZK1wiNeRnbrlNSgOFnP
         79dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705536796; x=1706141596;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9i8qODXe002QMPDdMmztpO3Oxegq4Xx5PYFd8vnb1Mk=;
        b=LKJxeUfOhSY5AmMk5zrrJ+mzCVju0OW40pgQh5vSZUCoo26JxSwTviCqgylsnlVYZA
         dBMG7r57Lo2/Ng0GJQrkdiHsc6H76gPhgMGfHDFoDOu1t+5/Zk5k6OAWecs/yPxNzLyC
         +JHQX+NthPcTRb0Ez/ef/+aux6lJaz4sY6oNpdNf+LNoLr8RN6Ruv/Sj6zWKtOTsly6T
         tRxTMGNAcFuhcVRr32j66b7jkxR+ivWv9cPW4YvPm27gflKXAwD2LWvZIwXh44VzJ2wj
         qeW7GVUu+rsKFBiBrxGRRD9lHtGRzmSbL/Y3xtfOVxeASDERUeR3ZLO6/HuLt7wPvSC8
         2FSA==
X-Gm-Message-State: AOJu0Yz7AxpuyNfRKBgHQkqerClmlyAtpAJaKwo4q3l/xeakXSAczpTX
	jg0CAf/CrNekMkZBfCD7qHz0GUmh9zz+oIk1hpoUMhIW+ExehCrwa3lHVxcKjPqZlJgwVe5c+Y/
	Vqr/jfiJujGKbMPZO+Jvq1knHT+64CQwaO2g=
X-Google-Smtp-Source: AGHT+IHMGeObeMHlpTKi87fcxfm2qeR+fumWpCO01/QKmIQ/yRSM0Rfqkq8VYxNHzf5Ye6IVdkQj2a86PY7oiEjMAYk=
X-Received: by 2002:a2e:92c1:0:b0:2cd:eab7:4765 with SMTP id
 k1-20020a2e92c1000000b002cdeab74765mr31604ljh.22.1705536795815; Wed, 17 Jan
 2024 16:13:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Wed, 17 Jan 2024 18:13:04 -0600
Message-ID: <CAH2r5ms0enaYDExBmGw1XScwR6ypBsy1snfGd-LnzZrWLE4+Vw@mail.gmail.com>
Subject: [PATCH] minor updates to todo and usage for cifs.ko
To: CIFS <linux-cifs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000ddc11e060f2d3a63"

--000000000000ddc11e060f2d3a63
Content-Type: text/plain; charset="UTF-8"

See attached, minor updates to Documentation todo and usage for cifs.ko

-- 
Thanks,

Steve

--000000000000ddc11e060f2d3a63
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb3-minor-documentation-updates.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-minor-documentation-updates.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lrigk9sn0>
X-Attachment-Id: f_lrigk9sn0

RnJvbSA1YTZmODJjYTQ5OGM4MGJiOTNkMGRiY2MyMDA5OGJlYWIxNjIyZTZlIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFdlZCwgMTcgSmFuIDIwMjQgMTc6NTk6NTkgLTA2MDAKU3ViamVjdDogW1BBVENIXSBz
bWIzOiBtaW5vciBkb2N1bWVudGF0aW9uIHVwZGF0ZXMKClVwZGF0ZSB0aGUgdXNhZ2UgZG9jdW1l
bnRhdGlvbiB0byBpbmNsdWRlIHNvbWUgbWlzc2luZwpjb25maWd1cmF0aW9uIG9wdGlvbnMuICBV
cGRhdGUgdGhlIHRvZG8gbGlzdCBkb2N1bWVudGF0aW9uCmZvciBjaWZzLmtvCgpTaWduZWQtb2Zm
LWJ5OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0tLQogRG9jdW1lbnRh
dGlvbi9hZG1pbi1ndWlkZS9jaWZzL3RvZG8ucnN0ICB8IDMxICsrKysrKysrKysrKysrLS0tLS0t
LS0tLQogRG9jdW1lbnRhdGlvbi9hZG1pbi1ndWlkZS9jaWZzL3VzYWdlLnJzdCB8ICA4ICsrKysr
LQogMiBmaWxlcyBjaGFuZ2VkLCAyNSBpbnNlcnRpb25zKCspLCAxNCBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2NpZnMvdG9kby5yc3QgYi9Eb2N1
bWVudGF0aW9uL2FkbWluLWd1aWRlL2NpZnMvdG9kby5yc3QKaW5kZXggMjY0NmVkMmUyZDNlLi5l
ODVjY2NjYWQxYTUgMTAwNjQ0Ci0tLSBhL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvY2lmcy90
b2RvLnJzdAorKysgYi9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2NpZnMvdG9kby5yc3QKQEAg
LTIsNyArMiw5IEBACiBUT0RPCiA9PT09CiAKLVZlcnNpb24gMi4xNCBEZWNlbWJlciAyMSwgMjAx
OAorQXMgb2YgNi43IGtlcm5lbCwgc2VlCisgICBodHRwczovL3dpa2kuc2FtYmEub3JnL2luZGV4
LnBocC9MaW51eENJRlNLZXJuZWwKK2ZvciBsaXN0IG9mIGZlYXR1cmVzIGFkZGVkIGJ5IHJlbGVh
c2UKIAogQSBQYXJ0aWFsIExpc3Qgb2YgTWlzc2luZyBGZWF0dXJlcwogPT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PQpAQCAtMTIsMTkgKzE0LDE5IEBAIGZvciB2aXNpYmxlLCBpbXBv
cnRhbnQgY29udHJpYnV0aW9ucyB0byB0aGlzIG1vZHVsZS4gIEhlcmUKIGlzIGEgcGFydGlhbCBs
aXN0IG9mIHRoZSBrbm93biBwcm9ibGVtcyBhbmQgbWlzc2luZyBmZWF0dXJlczoKIAogYSkgU01C
MyAoYW5kIFNNQjMuMS4xKSBtaXNzaW5nIG9wdGlvbmFsIGZlYXR1cmVzOgotCi0gICAtIG11bHRp
Y2hhbm5lbCAocGFydGlhbGx5IGludGVncmF0ZWQpLCBpbnRlZ3JhdGlvbiBvZiBtdWx0aWNoYW5u
ZWwgd2l0aCBSRE1BCi0gICAtIGRpcmVjdG9yeSBsZWFzZXMgKGltcHJvdmVkIG1ldGFkYXRhIGNh
Y2hpbmcpLiBDdXJyZW50bHkgb25seSBpbXBsZW1lbnRlZCBmb3Igcm9vdCBkaXIKKyAgIC0gbXVs
dGljaGFubmVsIHBlcmZvcm1hbmNlIG9wdGltaXphdGlvbnMsIGFsZ29yaXRobWljIGNoYW5uZWwg
c2VsZWN0aW9uCisgICAtIGRpcmVjdG9yeSBsZWFzZXMgb3B0aW1pemF0aW9ucwogICAgLSBUMTAg
Y29weSBvZmZsb2FkIGllICJPRFgiIChjb3B5IGNodW5rLCBhbmQgIkR1cGxpY2F0ZSBFeHRlbnRz
IiBpb2N0bAogICAgICBjdXJyZW50bHkgdGhlIG9ubHkgdHdvIHNlcnZlciBzaWRlIGNvcHkgbWVj
aGFuaXNtcyBzdXBwb3J0ZWQpCisgICAtIHN1cHBvcnQgZm9yIGZhc3RlciBwYWNrZXQgc2lnbmlu
ZyAoR01BQykKKyAgIC0gc3VwcG9ydCBmb3IgY29tcHJlc3Npb24gb3ZlciB0aGUgbmV0d29yawog
Ci1iKSBpbXByb3ZlZCBzcGFyc2UgZmlsZSBzdXBwb3J0IChmaWVtYXAgYW5kIFNFRUtfSE9MRSBh
cmUgaW1wbGVtZW50ZWQKLSAgIGJ1dCBhZGRpdGlvbmFsIGZlYXR1cmVzIHdvdWxkIGJlIHN1cHBv
cnRhYmxlIGJ5IHRoZSBwcm90b2NvbCBzdWNoCi0gICBhcyBGQUxMT0NfRkxfQ09MTEFQU0VfUkFO
R0UgYW5kIEZBTExPQ19GTF9JTlNFUlRfUkFOR0UpCitiKSBCZXR0ZXIgb3B0aW1pemVkIGNvbXBv
dW5kaW5nIGFuZCBlcnJvciBoYW5kbGluZyBmb3Igc3BhcnNlIGZpbGUgc3VwcG9ydCwKKyAgIHBl
cmhhcHMgYWRkaXRpb24gb2YgbmV3IG9wdGlvbmFsIFNNQjMuMS4xIGZzY3RscyB0byBtYWtlIGNv
bGxhcHNlIHJhbmdlCisgICBhbmQgaW5zZXJ0IHJhbmdlIG1vcmUgYXRvbWljCiAKLWMpIERpcmVj
dG9yeSBlbnRyeSBjYWNoaW5nIHJlbGllcyBvbiBhIDEgc2Vjb25kIHRpbWVyLCByYXRoZXIgdGhh
bgotICAgdXNpbmcgRGlyZWN0b3J5IExlYXNlcywgY3VycmVudGx5IG9ubHkgdGhlIHJvb3QgZmls
ZSBoYW5kbGUgaXMgY2FjaGVkIGxvbmdlcgotICAgYnkgbGV2ZXJhZ2luZyBEaXJlY3RvcnkgTGVh
c2VzCitjKSBTdXBwb3J0IGZvciBTTUIzLjEuMSBvdmVyIFFVSUMgKGFuZCBwZXJoYXBzIG90aGVy
IHNvY2tldCBiYXNlZCBwcm90b2NvbHMKKyAgIGxpa2UgU0NUUCkKIAogZCkgcXVvdGEgc3VwcG9y
dCAobmVlZHMgbWlub3Iga2VybmVsIGNoYW5nZSBzaW5jZSBxdW90YSBjYWxscyBvdGhlcndpc2UK
ICAgICB3b24ndCBtYWtlIGl0IHRvIG5ldHdvcmsgZmlsZXN5c3RlbXMgb3IgZGV2aWNlbGVzcyBm
aWxlc3lzdGVtcykuCkBAIC05MiwxMCArOTQsMTMgQEAgdCkgc3BsaXQgY2lmcyBhbmQgc21iMyBz
dXBwb3J0IGludG8gc2VwYXJhdGUgbW9kdWxlcyBzbyBsZWdhY3kgKGFuZCBsZXNzCiAKIHYpIEFk
ZGl0aW9uYWwgdGVzdGluZyBvZiBQT1NJWCBFeHRlbnNpb25zIGZvciBTTUIzLjEuMQogCi13KSBB
ZGQgc3VwcG9ydCBmb3IgYWRkaXRpb25hbCBzdHJvbmcgZW5jcnlwdGlvbiB0eXBlcywgYW5kIGFk
ZGl0aW9uYWwgc3BuZWdvCi0gICBhdXRoZW50aWNhdGlvbiBtZWNoYW5pc21zIChzZWUgTVMtU01C
MikuICBHQ00tMjU2IGlzIG5vdyBwYXJ0aWFsbHkgaW1wbGVtZW50ZWQuCit3KSBTdXBwb3J0IGZv
ciB0aGUgTWFjIFNNQjMuMS4xIGV4dGVuc2lvbnMgdG8gaW1wcm92ZSBpbnRlcm9wIHdpdGggQXBw
bGUgc2VydmVycworCit4KSBTdXBwb3J0IGZvciBhZGRpdGlvbmFsIGF1dGhlbnRpY2F0aW9uIG9w
dGlvbnMgKGUuZy4gSUFLRVJCLCBwZWVyLXRvLXBlZXIKKyAgIEtlcmJlcm9zLCBTQ1JBTSBhbmQg
b3RoZXJzIHN1cHBvcnRlZCBieSBleGlzdGluZyBzZXJ2ZXJzKQogCi14KSBGaW5pc2ggc3VwcG9y
dCBmb3IgU01CMy4xLjEgY29tcHJlc3Npb24KK3kpIEltcHJvdmVkIHRyYWNpbmcsIG1vcmUgZUJQ
RiB0cmFjZSBwb2ludHMsIGJldHRlciBzY3JpcHRzIGZvciBwZXJmb3JtYW5jZQorICAgYW5hbHlz
aXMKIAogS25vd24gQnVncwogPT09PT09PT09PQpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9h
ZG1pbi1ndWlkZS9jaWZzL3VzYWdlLnJzdCBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvY2lm
cy91c2FnZS5yc3QKaW5kZXggNWY5MzZiNGI2MDE4Li5hYTgyOTBhMjlkYzggMTAwNjQ0Ci0tLSBh
L0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUvY2lmcy91c2FnZS5yc3QKKysrIGIvRG9jdW1lbnRh
dGlvbi9hZG1pbi1ndWlkZS9jaWZzL3VzYWdlLnJzdApAQCAtODEsNyArODEsNyBAQCBtdWNoIG9s
ZGVyIGFuZCBsZXNzIHNlY3VyZSB0aGFuIHRoZSBkZWZhdWx0IGRpYWxlY3QgU01CMyB3aGljaCBp
bmNsdWRlcwogbWFueSBhZHZhbmNlZCBzZWN1cml0eSBmZWF0dXJlcyBzdWNoIGFzIGRvd25ncmFk
ZSBhdHRhY2sgZGV0ZWN0aW9uCiBhbmQgZW5jcnlwdGVkIHNoYXJlcyBhbmQgc3Ryb25nZXIgc2ln
bmluZyBhbmQgYXV0aGVudGljYXRpb24gYWxnb3JpdGhtcy4KIFRoZXJlIGFyZSBhZGRpdGlvbmFs
IG1vdW50IG9wdGlvbnMgdGhhdCBtYXkgYmUgaGVscGZ1bCBmb3IgU01CMyB0byBnZXQKLWltcHJv
dmVkIFBPU0lYIGJlaGF2aW9yIChOQjogY2FuIHVzZSB2ZXJzPTMuMCB0byBmb3JjZSBvbmx5IFNN
QjMsIG5ldmVyIDIuMSk6CitpbXByb3ZlZCBQT1NJWCBiZWhhdmlvciAoTkI6IGNhbiB1c2UgdmVy
cz0zIHRvIGZvcmNlIFNNQjMgb3IgbGF0ZXIsIG5ldmVyIDIuMSk6CiAKICAgIGBgbWZzeW1saW5r
c2BgIGFuZCBlaXRoZXIgYGBjaWZzYWNsYGAgb3IgYGBtb2RlZnJvbXNpZGBgICh1c3VhbGx5IHdp
dGggYGBpZHNmcm9tc2lkYGApCiAKQEAgLTcxNSw2ICs3MTUsNyBAQCBEZWJ1Z0RhdGEJCURpc3Bs
YXlzIGluZm9ybWF0aW9uIGFib3V0IGFjdGl2ZSBDSUZTIHNlc3Npb25zIGFuZAogU3RhdHMJCQlM
aXN0cyBzdW1tYXJ5IHJlc291cmNlIHVzYWdlIGluZm9ybWF0aW9uIGFzIHdlbGwgYXMgcGVyCiAJ
CQlzaGFyZSBzdGF0aXN0aWNzLgogb3Blbl9maWxlcwkJTGlzdCBhbGwgdGhlIG9wZW4gZmlsZSBo
YW5kbGVzIG9uIGFsbCBhY3RpdmUgU01CIHNlc3Npb25zLgorbW91bnRfcGFyYW1zICAgICAgICAg
ICAgTGlzdCBvZiBhbGwgbW91bnQgcGFyYW1ldGVycyBhdmFpbGFibGUgZm9yIHRoZSBtb2R1bGUK
ID09PT09PT09PT09PT09PT09PT09PT09ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT0KIAogQ29uZmlndXJhdGlvbiBwc2V1ZG8tZmlsZXM6CkBA
IC04NjQsNiArODY1LDExIEBAIGkuZS46OgogCiAgICAgZWNobyAidmFsdWUiID4gL3N5cy9tb2R1
bGUvY2lmcy9wYXJhbWV0ZXJzLzxwYXJhbT4KIAorTW9yZSBkZXRhaWxlZCBkZXNjcmlwdGlvbnMg
b2YgdGhlIGF2YWlsYWJsZSBtb2R1bGUgcGFyYW1ldGVycyBhbmQgdGhlaXIgdmFsdWVzCitjYW4g
YmUgc2VlbiBieSBkb2luZzoKKworICAgIG1vZGluZm8gY2lmcyAob3IgbW9kaW5mbyBzbWIzKQor
CiA9PT09PT09PT09PT09PT09PSA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09CiAxLiBlbmFibGVfb3Bsb2NrcyBFbmFibGUgb3IgZGlzYWJs
ZSBvcGxvY2tzLiBPcGxvY2tzIGFyZSBlbmFibGVkIGJ5IGRlZmF1bHQuCiAJCSAgW1kveS8xXS4g
VG8gZGlzYWJsZSB1c2UgYW55IG9mIFtOL24vMF0uCi0tIAoyLjQwLjEKCg==
--000000000000ddc11e060f2d3a63--

