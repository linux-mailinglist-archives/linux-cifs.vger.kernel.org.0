Return-Path: <linux-cifs+bounces-1813-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2583E8A2238
	for <lists+linux-cifs@lfdr.de>; Fri, 12 Apr 2024 01:21:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98E87288797
	for <lists+linux-cifs@lfdr.de>; Thu, 11 Apr 2024 23:21:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B98A47A73;
	Thu, 11 Apr 2024 23:21:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mk66TLBk"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-qt1-f174.google.com (mail-qt1-f174.google.com [209.85.160.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 246FA47A6A
	for <linux-cifs@vger.kernel.org>; Thu, 11 Apr 2024 23:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712877697; cv=none; b=D9MQg38eZAhXh4qaU2qO+RgpKYnMk/8bVXaV/E0mHXssrjf/Jy7lhlWKZrcSsViVY8fOV+r9mY93j/CsV+oz8+Mkka9iIRXogveLyGjNEtpwHQrud9hGKcUhkf+4Q2Jd8s7j2f2QDzbmkmZOf3ujkcB6fE9ir7e701olqfyRNRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712877697; c=relaxed/simple;
	bh=dCiSEaxCVpTRNxnCtUCtKENk2FKB1tT1PMfJ+D3UTPA=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=gSlVRhFOHjEAn47Zv2C8vADK4/jOU5Kgb2kDw4kV0NdN2oBnWZQTOy3WVNDgFQo8kxIlYowPZ2uMIpvwfeZiTtMKc2iz22mX7BdJgw+BIhzB8XbcIAhlTT8bzQFnCCwSEGQoz9lyL0T7kBm9bmgHyrXLxq7jyZIBK1O410ccsV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=mk66TLBk; arc=none smtp.client-ip=209.85.160.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-qt1-f174.google.com with SMTP id d75a77b69052e-434ffc2b520so55141cf.0
        for <linux-cifs@vger.kernel.org>; Thu, 11 Apr 2024 16:21:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1712877692; x=1713482492; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=2uOeNoz647y6axk//kSn5TkbyN5DyX+iv+u6cuwNVMo=;
        b=mk66TLBkaLEJV4DaxdDMFIKNCXdPBpJF1qoJFI6ZgXtd73X6x62sx4YyzGtz+cJT3Z
         qRe+JsKA/cSvvx6lG7drI3ytFo/Fp1RPjsFchLnnUoF+j2bp7hYMJG9ZxC5o3GegKAwm
         vTYb09pPgIoD1LnREKVqmx7SI9fJ/4cS/nacJs7puB6scjblf2/viKMXZi9o9ucNemST
         l2jDKDYry4oFqKXwxQp7Y4zSgNe5pGecIr5Q/w9Eed2w1N1n5PfwtKefhtUetcPlIINP
         gvKLWo/XkyajQjpXbSb26okqkS69233DAWRP2N47pOP52qlE6jaIyqm5Tb1QnuYGblZ/
         kkkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712877692; x=1713482492;
        h=to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2uOeNoz647y6axk//kSn5TkbyN5DyX+iv+u6cuwNVMo=;
        b=o8rVpEK3fnqI5addkoKpj9nxOlya+/EAqOt/E3YzmRXvrQRethmsvKXY9zCTooChSM
         xWs0LTjQIMAZRFoHGCaqhtuaJlGyhIKrWYgtA126RmaYTzrfYOmxGD5tIXacIIfV0kFi
         uVu0os4veQ6u4slStgKeXAWxy2FiXSALswIRMwUR1mRfw26CofBbSJUNXsu9CpuNQ3y1
         2vJ3edPkUV5DXqoPEnc6lL+Er0g+im5CluMBxbAzVhOvzMJV9cI32qYIYcNw/5tJn84v
         0A3/Z+2lh7+fo3+LRpM2lWa/PvHty/8xEYevQZIjapJQoFFqpFaPj3yikFDP2Qsb1sHU
         3S7A==
X-Gm-Message-State: AOJu0YyyZjTgS5/HKVsMcNa/NPGG59uUEHPYR4I9Q6OslC7f1Me7k7G/
	xyrGWqay3cGMJY93iodcT+6SHALEAinehMClMUFFiDcG6DEm9YbDSGH/KMPX/Lvv91tVAW25brL
	mMWOcoXs4hVhiLsrJcqrkHtHvmU6Uv3UlSbaAFoXUD/YYDjAiGy2v
X-Google-Smtp-Source: AGHT+IGZyBarmmVZDb2jbuZCsIDraKEMraX/uwRXB26wBGt9NdUMTrI4puyuAqKyHrnY+mJk8MU87i6JghKl0jAQPqk=
X-Received: by 2002:a05:622a:4d95:b0:434:66ce:8e2c with SMTP id
 ff21-20020a05622a4d9500b0043466ce8e2cmr64411qtb.5.1712877691402; Thu, 11 Apr
 2024 16:21:31 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Chenglong Tang <chenglongtang@google.com>
Date: Thu, 11 Apr 2024 16:21:19 -0700
Message-ID: <CAOdxtTbcvXsNAaF6wsKoFz3ioJYL_AzEGczUdJRS01xAjwj_Tg@mail.gmail.com>
Subject: kernel panic caused by kernel update from v5.15.133 to v5.15.146
To: linux-cifs@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000057ac530615da6a9d"

--00000000000057ac530615da6a9d
Content-Type: multipart/alternative; boundary="00000000000057ac530615da6a9b"

--00000000000057ac530615da6a9b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, developers,

This is Chenglong Tang from the Google Container Optimized OS team. We
recently received a kernel panic bug from the customers regarding cifs.

I sent this email again with more detailed investigation we did these days
and also because the previous one was sent to the wrong address.

Here are some steps we did in order to reproduce the issue:


   1. Deploy GKE Cluster with the same version as the customer
   v1.26.13-gke.1144000
   2. Deploy SMB CSI Driver Daemonset:
   https://github.com/kubernetes-csi/csi-driver-smb/blob/master/docs/instal=
l-csi-driver-v1.12.0.md
   3. Create SMB Server on the same cluster:
   https://github.com/kubernetes-csi/csi-driver-smb/tree/master/deploy/exam=
ple/smb-provisioner
   4. Create Pod to create Client to create a PersistentVolume on the Samba
   Server in (3):
   https://github.com/kubernetes-csi/csi-driver-smb/blob/master/deploy/exam=
ple/deployment.yaml
   5. Wait and observe to see if there are any Kernel Panics in VM Instance
   logs or Node that is running the Client pod goes into NotReady state.


Unfortunately (5) did not occur, therefore we were unable to reproduce
locally. I am not sure why in the customer's environment this issue is
present.

DS for CSI SMB node is:

image: gcr.io/iaas-gcr-reg-prd-ad3d/vendor/sig-storage/smbplugin:v1.12.0

and CSI SMB Controller

image: gcr.io/iaas-gcr-reg-prd-ad3d/vendor/sig-storage/smbplugin:v1.12.0
image: gcr.io/iaas-gcr-reg-prd-ad3d/vendor/sig-storage/livenessprobe:v2.11.=
0
image: gcr.io/iaas-gcr-reg-prd-ad3d/vendor/sig-storage/csi-provisioner:v3.6=
.0

Based on this it looks like this a pretty outdated version of the

SMB CSI Controller - since 1.12.0 was released Aug 11, 2023
------------------------------

However, our systems should be fault tolerant and not kernel panicking /
crashing - we should investigate this as many other customers might run
into the same issue.

We are not able to swap to newer versions of kernels(currently in v5.10 and
5.15).


The customer said the problem occurred because of the kernel update from
v5.15.133 to v5.15.146.


Here are the recent kernel changes we make in cifs:

   1. ded3cfd smb: client: fix OOB in smbCalcSize() by Paulo Alcantara =C2=
=B7 4
   months ago
   2. bfd18c0 smb: client: fix OOB in SMB2_query_info_init() by Paulo
   Alcantara =C2=B7 4 months ago
   3. f47e3f6 smb: client: fix OOB in smb2_query_reparse_point() by Paulo
   Alcantara =C2=B7 4 months ago
   4. fd3951b smb: client: fix NULL deref in asn1_ber_decoder() by Paulo
   Alcantara =C2=B7 4 months ago
   5. 6bbeb39 ksmbd: fix wrong name of SMB2_CREATE_ALLOCATION_SIZE by
   Namjae Jeon =C2=B7 4 months ago
   6. e5071ae smb: client: fix potential NULL deref in
   parse_dfs_referrals() by Paulo Alcantara =C2=B7 4 months ago
   7. d2bafe8 cifs: Fix non-availability of dedup breaking generic/304 by
   David Howells =C2=B7 4 months ago
   8. bb08df4 smb3: fix caching of ctime on setxattr by Steve French =C2=B7=
 5
   months ago
   9. b4329a3 smb3: fix touch -h of symlink by Steve French =C2=B7 6 months=
 ago
   10. 4968c2a cifs: fix check of rc in function generate_smb3signingkey by
   Ekaterina Esina =C2=B7 5 months ago
   11. 8d725bf cifs: spnego: add ';' in HOST_KEY_LEN by Anastasia Belova =
=C2=B7
   5 months ago
   12. 8e3cdab smb3: correct places where ENOTSUPP is used instead of
   preferred EOPNOTSUPP by Steve French =C2=B7 7 months ago


Our first diagnosis is that we think the problem might be caused by memory
corruption. From the assembly code we can see that

chenglongtang@vm01:~/cos/src/third_party/kernel/v5.15$ echo "Code: d7
49 89 f4 48 89 fb e8 1c 42 fb d3 48 83 f8 03 72 5f 49 89 c5 8a 03 3c
5c 74 04 3c 2f 75 52 49 8b 3c 24 48 8b 05 9e d6 04 00 <48> 8b 30 e8 56
45 fb d3 85 c0 75 64 48 89 df be c0 0c 00 00 e8 55" |
scripts/decodecode
Code: d7 49 89 f4 48 89 fb e8 1c 42 fb d3 48 83 f8 03 72 5f 49 89 c5
8a 03 3c 5c 74 04 3c 2f 75 52 49 8b 3c 24 48 8b 05 9e d6 04 00 <48> 8b
30 e8 56 45 fb d3 85 c0 75 64 48 89 df be c0 0c 00 00 e8 55
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   d7                      xlat   %ds:(%rbx)
   1:   49 89 f4                mov    %rsi,%r12
   4:   48 89 fb                mov    %rdi,%rbx
   7:   e8 1c 42 fb d3          call   0xffffffffd3fb4228
   c:   48 83 f8 03             cmp    $0x3,%rax
  10:   72 5f                   jb     0x71
  12:   49 89 c5                mov    %rax,%r13
  15:   8a 03                   mov    (%rbx),%al
  17:   3c 5c                   cmp    $0x5c,%al
  19:   74 04                   je     0x1f
  1b:   3c 2f                   cmp    $0x2f,%al
  1d:   75 52                   jne    0x71
  1f:   49 8b 3c 24             mov    (%r12),%rdi
  23:   48 8b 05 9e d6 04 00    mov    0x4d69e(%rip),%rax        # 0x4d6c8
  2a:*  48 8b 30                mov    (%rax),%rsi              <--
trapping instruction
  2d:   e8 56 45 fb d3          call   0xffffffffd3fb4588 #if
(unlikely(strcmp(cp->charset, cache_cp->charset))) {
  32:   85 c0                   test   %eax,%eax
  34:   75 64                   jne    0x9a
  36:   48 89 df                mov    %rbx,%rdi
  39:   be c0 0c 00 00          mov    $0xcc0,%esi
  3e:   e8                      .byte 0xe8
  3f:   55                      push   %rbp

The trapping happened before the call of 0xffffffffd3fb4588 (strcmp) and mo=
v
(%rax),%rsi is for the second argument of strcmp. And from the backtrace I
posted, we can see that rax is ffffffff00000000, which was corrupted and
that caused the segmentation fault.


We checked that it's impossible for cache_cp to be NULL and
cache_cp->charset should have a value because load_nfs_default will
definitely return a non-NULL value. That's why we believe it should be
caused by some changes related to the memory free/allocation that corrupted
the static table.


I can't narrow down anymore and am still working on it. Feel free to share
thoughts with us.


Best,


Chenglong

--00000000000057ac530615da6a9b
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div>Hi, developers,<div><br></div><div>This is Chenglong =
Tang from the Google Container Optimized OS team. We recently received a ke=
rnel panic bug from the customers regarding cifs.=C2=A0</div><div><br></div=
><div>I sent this email again=C2=A0with more detailed investigation we did =
these days and also because the previous one was sent to the wrong address.=
</div></div><div><br></div>Here are some steps we did in order to reproduce=
 the issue:<br><br><ol style=3D"font-size:13px;margin:0px;color:rgb(32,33,3=
6);font-family:Roboto,Arial,sans-serif;letter-spacing:0.185714px"><li style=
=3D"margin:0px;border:0px;font-weight:inherit;font-style:inherit;font-famil=
y:inherit;vertical-align:baseline;line-height:17px;outline-width:0px">Deplo=
y GKE Cluster with the same version as the customer=C2=A0<code style=3D"fon=
t-family:WorkAroundWebKitAndMozilla,monospace;border-radius:2px;padding:0px=
 2px">v1.26.13-gke.1144000</code></li><li style=3D"margin:0px;border:0px;fo=
nt-weight:inherit;font-style:inherit;font-family:inherit;vertical-align:bas=
eline;line-height:17px;outline-width:0px">Deploy SMB CSI Driver Daemonset: =
<a href=3D"https://github.com/kubernetes-csi/csi-driver-smb/blob/master/doc=
s/install-csi-driver-v1.12.0.md">https://github.com/kubernetes-csi/csi-driv=
er-smb/blob/master/docs/install-csi-driver-v1.12.0.md</a></li><li style=3D"=
margin:0px;border:0px;font-weight:inherit;font-style:inherit;font-family:in=
herit;vertical-align:baseline;line-height:17px;outline-width:0px">Create SM=
B Server on the same cluster: <a href=3D"https://github.com/kubernetes-csi/=
csi-driver-smb/tree/master/deploy/example/smb-provisioner">https://github.c=
om/kubernetes-csi/csi-driver-smb/tree/master/deploy/example/smb-provisioner=
</a></li><li style=3D"margin:0px;border:0px;font-weight:inherit;font-style:=
inherit;font-family:inherit;vertical-align:baseline;line-height:17px;outlin=
e-width:0px">Create Pod to create Client to create a PersistentVolume on th=
e Samba Server in (3): <a href=3D"https://github.com/kubernetes-csi/csi-dri=
ver-smb/blob/master/deploy/example/deployment.yaml">https://github.com/kube=
rnetes-csi/csi-driver-smb/blob/master/deploy/example/deployment.yaml</a></l=
i><li style=3D"margin:0px;border:0px;font-weight:inherit;font-style:inherit=
;font-family:inherit;vertical-align:baseline;line-height:17px;outline-width=
:0px">Wait and observe to see if there are any Kernel Panics in VM Instance=
 logs or Node that is running the Client pod goes into=C2=A0<code style=3D"=
font-family:WorkAroundWebKitAndMozilla,monospace;border-radius:2px;padding:=
0px 2px">NotReady</code>=C2=A0state.<br><br></li></ol><div><span style=3D"c=
olor:rgb(32,33,36);font-family:Roboto,Arial,sans-serif;font-size:13px;lette=
r-spacing:0.185714px">Unfortunately (5) did not occur, therefore we were un=
able to reproduce locally.=C2=A0</span><span style=3D"color:rgb(32,33,36);f=
ont-family:Roboto,Arial,sans-serif;font-size:13px;letter-spacing:0.185714px=
">I am not sure why in the customer&#39;s environment this issue is present=
.</span><font color=3D"#202124" face=3D"Roboto, Arial, sans-serif"><span st=
yle=3D"letter-spacing:0.185714px"><br></span></font></div><div><span style=
=3D"color:rgb(32,33,36);font-family:Roboto,Arial,sans-serif;font-size:13px;=
letter-spacing:0.185714px"><br></span></div><div><p style=3D"letter-spacing=
:0.185714px;font-size:13px;line-height:1.38462;border:0px;font-family:Robot=
o,Arial,sans-serif;vertical-align:baseline;word-break:break-word;margin:0px=
;outline-width:0px;color:rgb(32,33,36)">DS for CSI SMB node is:</p><pre sty=
le=3D"font-family:WorkAroundWebKitAndMozilla,monospace;line-height:1.5;bord=
er-radius:2px;overflow-x:auto;padding:8px 16px;color:rgb(32,33,36);font-siz=
e:13px;letter-spacing:0.185714px"><code style=3D"font-family:WorkAroundWebK=
itAndMozilla,monospace;border-radius:2px;padding:0px;line-height:1.5">image=
: <a href=3D"http://gcr.io/iaas-gcr-reg-prd-ad3d/vendor/sig-storage/smbplug=
in:v1.12.0">gcr.io/iaas-gcr-reg-prd-ad3d/vendor/sig-storage/smbplugin:v1.12=
.0</a>
</code></pre><p style=3D"letter-spacing:0.185714px;font-size:13px;line-heig=
ht:1.38462;border:0px;font-family:Roboto,Arial,sans-serif;vertical-align:ba=
seline;word-break:break-word;margin:0px;outline-width:0px;color:rgb(32,33,3=
6)">and CSI SMB Controller</p><pre style=3D"font-family:WorkAroundWebKitAnd=
Mozilla,monospace;line-height:1.5;border-radius:2px;overflow-x:auto;padding=
:8px 16px;color:rgb(32,33,36);font-size:13px;letter-spacing:0.185714px"><co=
de style=3D"font-family:WorkAroundWebKitAndMozilla,monospace;border-radius:=
2px;padding:0px;line-height:1.5">image: <a href=3D"http://gcr.io/iaas-gcr-r=
eg-prd-ad3d/vendor/sig-storage/smbplugin:v1.12.0">gcr.io/iaas-gcr-reg-prd-a=
d3d/vendor/sig-storage/smbplugin:v1.12.0</a>
image: <a href=3D"http://gcr.io/iaas-gcr-reg-prd-ad3d/vendor/sig-storage/li=
venessprobe:v2.11.0">gcr.io/iaas-gcr-reg-prd-ad3d/vendor/sig-storage/livene=
ssprobe:v2.11.0</a>
image: <a href=3D"http://gcr.io/iaas-gcr-reg-prd-ad3d/vendor/sig-storage/cs=
i-provisioner:v3.6.0">gcr.io/iaas-gcr-reg-prd-ad3d/vendor/sig-storage/csi-p=
rovisioner:v3.6.0</a>
</code></pre><p style=3D"letter-spacing:0.185714px;font-size:13px;line-heig=
ht:1.38462;border:0px;font-family:Roboto,Arial,sans-serif;vertical-align:ba=
seline;word-break:break-word;margin:0px;outline-width:0px;color:rgb(32,33,3=
6)">Based on this it looks like this a pretty outdated version of the=C2=A0=
<a style=3D"color:rgb(34,34,34);margin:0px;border:0px;font-weight:inherit;f=
ont-style:inherit;font-family:inherit;vertical-align:baseline;outline-width=
:0px"></a><span style=3D"margin:0px;border:0px;font-weight:inherit;font-sty=
le:inherit;font-family:inherit;vertical-align:baseline;outline-width:0px"><=
span role=3D"img" aria-hidden=3D"true" style=3D"background-repeat:no-repeat=
;display:inline-block;height:18px;width:18px;overflow:hidden;vertical-align=
:middle"></span></span></p><p style=3D"letter-spacing:0.185714px;font-size:=
13px;line-height:1.38462;border:0px;font-family:Roboto,Arial,sans-serif;ver=
tical-align:baseline;word-break:break-word;margin:0px;outline-width:0px;col=
or:rgb(32,33,36)"><span style=3D"margin:0px;border:0px;font-weight:inherit;=
font-style:inherit;font-family:inherit;vertical-align:baseline;outline-widt=
h:0px">SMB CSI Controller</span>=C2=A0- since 1.12.0 was released Aug 11, 2=
023</p><hr style=3D"height:0px;border-right:0px;border-bottom:0px;border-le=
ft:0px;margin:0px;color:rgb(32,33,36);font-family:Roboto,Arial,sans-serif;f=
ont-size:13px;letter-spacing:0.185714px"><p style=3D"letter-spacing:0.18571=
4px;font-size:13px;line-height:1.38462;border:0px;font-family:Roboto,Arial,=
sans-serif;vertical-align:baseline;word-break:break-word;margin:0px;outline=
-width:0px;color:rgb(32,33,36)">However, our systems should be fault tolera=
nt and not kernel panicking / crashing - we should investigate this as many=
 other customers might run into the same issue.</p><p style=3D"letter-spaci=
ng:0.185714px;font-size:13px;line-height:1.38462;border:0px;font-family:Rob=
oto,Arial,sans-serif;vertical-align:baseline;word-break:break-word;margin:0=
px;outline-width:0px;color:rgb(32,33,36)">We are not able to swap to newer =
versions of kernels(currently in v5.10 and 5.15).</p><p style=3D"letter-spa=
cing:0.185714px;font-size:13px;line-height:1.38462;border:0px;font-family:R=
oboto,Arial,sans-serif;vertical-align:baseline;word-break:break-word;margin=
:0px;outline-width:0px;color:rgb(32,33,36)"><br></p><p style=3D"letter-spac=
ing:0.185714px;font-size:13px;line-height:1.38462;border:0px;font-family:Ro=
boto,Arial,sans-serif;vertical-align:baseline;word-break:break-word;margin:=
0px;outline-width:0px;color:rgb(32,33,36)">The customer said the problem oc=
curred because of the kernel update=C2=A0<span style=3D"letter-spacing:0.18=
5714px">from v5.15.133 to v5.15.146.</span></p><p style=3D"letter-spacing:0=
.185714px;font-size:13px;line-height:1.38462;border:0px;font-family:Roboto,=
Arial,sans-serif;vertical-align:baseline;word-break:break-word;margin:0px;o=
utline-width:0px;color:rgb(32,33,36)"><span style=3D"letter-spacing:0.18571=
4px"><br></span></p><p style=3D"letter-spacing:0.185714px;font-size:13px;li=
ne-height:1.38462;border:0px;font-family:Roboto,Arial,sans-serif;vertical-a=
lign:baseline;word-break:break-word;margin:0px;outline-width:0px;color:rgb(=
32,33,36)"><span style=3D"letter-spacing:0.185714px">Here are the recent ke=
rnel changes we make in cifs:</span></p><ol style=3D"box-sizing:border-box;=
margin:0px;padding:0px;list-style:none;color:rgb(0,0,0);font-family:&quot;O=
pen Sans&quot;,sans-serif;font-size:14px"><li style=3D"margin:0px;box-sizin=
g:border-box;padding:2px 0px">ded3cfd=C2=A0smb: client: fix OOB in smbCalcS=
ize()=C2=A0<span title=3D"pc@manguebit.com" style=3D"box-sizing:border-box;=
margin:0px;padding:0px">by Paulo Alcantara</span>=C2=A0<span title=3D"Fri D=
ec 15 19:59:14 2023 -0300" style=3D"box-sizing:border-box;margin:0px;paddin=
g:0px;color:rgb(102,102,102)">=C2=B7 4 months ago</span></li><li style=3D"m=
argin:0px;box-sizing:border-box;padding:2px 0px">bfd18c0=C2=A0smb: client: =
fix OOB in SMB2_query_info_init()=C2=A0<span title=3D"pc@manguebit.com" sty=
le=3D"box-sizing:border-box;margin:0px;padding:0px">by Paulo Alcantara</spa=
n>=C2=A0<span title=3D"Wed Dec 13 12:25:57 2023 -0300" style=3D"box-sizing:=
border-box;margin:0px;padding:0px;color:rgb(102,102,102)">=C2=B7 4 months a=
go</span></li><li style=3D"margin:0px;box-sizing:border-box;padding:2px 0px=
">f47e3f6=C2=A0smb: client: fix OOB in smb2_query_reparse_point()=C2=A0<spa=
n title=3D"pc@manguebit.com" style=3D"box-sizing:border-box;margin:0px;padd=
ing:0px">by Paulo Alcantara</span>=C2=A0<span title=3D"Mon Dec 11 10:26:43 =
2023 -0300" style=3D"box-sizing:border-box;margin:0px;padding:0px;color:rgb=
(102,102,102)">=C2=B7 4 months ago</span></li><li style=3D"margin:0px;box-s=
izing:border-box;padding:2px 0px">fd3951b=C2=A0smb: client: fix NULL deref =
in asn1_ber_decoder()=C2=A0<span title=3D"pc@manguebit.com" style=3D"box-si=
zing:border-box;margin:0px;padding:0px">by Paulo Alcantara</span>=C2=A0<spa=
n title=3D"Mon Dec 11 10:26:42 2023 -0300" style=3D"box-sizing:border-box;m=
argin:0px;padding:0px;color:rgb(102,102,102)">=C2=B7 4 months ago</span></l=
i><li style=3D"margin:0px;box-sizing:border-box;padding:2px 0px">6bbeb39=C2=
=A0ksmbd: fix wrong name of SMB2_CREATE_ALLOCATION_SIZE=C2=A0<span title=3D=
"linkinjeon@kernel.org" style=3D"box-sizing:border-box;margin:0px;padding:0=
px">by Namjae Jeon</span>=C2=A0<span title=3D"Wed Dec 06 08:23:49 2023 +090=
0" style=3D"box-sizing:border-box;margin:0px;padding:0px;color:rgb(102,102,=
102)">=C2=B7 4 months ago</span></li><li style=3D"margin:0px;box-sizing:bor=
der-box;padding:2px 0px">e5071ae=C2=A0smb: client: fix potential NULL deref=
 in parse_dfs_referrals()=C2=A0<span title=3D"pc@manguebit.com" style=3D"bo=
x-sizing:border-box;margin:0px;padding:0px">by Paulo Alcantara</span>=C2=A0=
<span title=3D"Tue Dec 05 21:49:29 2023 -0300" style=3D"box-sizing:border-b=
ox;margin:0px;padding:0px;color:rgb(102,102,102)">=C2=B7 4 months ago</span=
></li><li style=3D"margin:0px;box-sizing:border-box;padding:2px 0px">d2bafe=
8=C2=A0cifs: Fix non-availability of dedup breaking generic/304=C2=A0<span =
title=3D"dhowells@redhat.com" style=3D"box-sizing:border-box;margin:0px;pad=
ding:0px">by David Howells</span>=C2=A0<span title=3D"Mon Dec 04 14:01:59 2=
023 +0000" style=3D"box-sizing:border-box;margin:0px;padding:0px;color:rgb(=
102,102,102)">=C2=B7 4 months ago</span></li><li style=3D"margin:0px;box-si=
zing:border-box;padding:2px 0px">bb08df4=C2=A0smb3: fix caching of ctime on=
 setxattr=C2=A0<span title=3D"stfrench@microsoft.com" style=3D"box-sizing:b=
order-box;margin:0px;padding:0px">by Steve French</span>=C2=A0<span title=
=3D"Tue Nov 07 21:38:13 2023 -0600" style=3D"box-sizing:border-box;margin:0=
px;padding:0px;color:rgb(102,102,102)">=C2=B7 5 months ago</span></li><li s=
tyle=3D"margin:0px;box-sizing:border-box;padding:2px 0px">b4329a3=C2=A0smb3=
: fix touch -h of symlink=C2=A0<span title=3D"stfrench@microsoft.com" style=
=3D"box-sizing:border-box;margin:0px;padding:0px">by Steve French</span>=C2=
=A0<span title=3D"Mon Oct 16 12:18:23 2023 -0500" style=3D"box-sizing:borde=
r-box;margin:0px;padding:0px;color:rgb(102,102,102)">=C2=B7 6 months ago</s=
pan></li><li style=3D"margin:0px;box-sizing:border-box;padding:2px 0px">496=
8c2a=C2=A0cifs: fix check of rc in function generate_smb3signingkey=C2=A0<s=
pan title=3D"eesina@astralinux.ru" style=3D"box-sizing:border-box;margin:0p=
x;padding:0px">by Ekaterina Esina</span>=C2=A0<span title=3D"Mon Nov 13 19:=
42:41 2023 +0300" style=3D"box-sizing:border-box;margin:0px;padding:0px;col=
or:rgb(102,102,102)">=C2=B7 5 months ago</span></li><li style=3D"margin:0px=
;box-sizing:border-box;padding:2px 0px">8d725bf=C2=A0cifs: spnego: add &#39=
;;&#39; in HOST_KEY_LEN=C2=A0<span title=3D"abelova@astralinux.ru" style=3D=
"box-sizing:border-box;margin:0px;padding:0px">by Anastasia Belova</span>=
=C2=A0<span title=3D"Mon Nov 13 17:52:32 2023 +0300" style=3D"box-sizing:bo=
rder-box;margin:0px;padding:0px;color:rgb(102,102,102)">=C2=B7 5 months ago=
</span></li><li style=3D"margin:0px;box-sizing:border-box;padding:2px 0px">=
8e3cdab=C2=A0smb3: correct places where ENOTSUPP is used instead of preferr=
ed EOPNOTSUPP=C2=A0<span title=3D"stfrench@microsoft.com" style=3D"box-sizi=
ng:border-box;margin:0px;padding:0px">by Steve French</span>=C2=A0<span tit=
le=3D"Fri Sep 15 01:10:40 2023 -0500" style=3D"box-sizing:border-box;margin=
:0px;padding:0px;color:rgb(102,102,102)">=C2=B7 7 months ago</span></li></o=
l><p style=3D"letter-spacing:0.185714px;font-size:13px;line-height:1.38462;=
border:0px;font-family:Roboto,Arial,sans-serif;vertical-align:baseline;word=
-break:break-word;margin:0px;outline-width:0px;color:rgb(32,33,36)"><span s=
tyle=3D"letter-spacing:0.185714px"><br></span></p><p style=3D"letter-spacin=
g:0.185714px;font-size:13px;line-height:1.38462;border:0px;font-family:Robo=
to,Arial,sans-serif;vertical-align:baseline;word-break:break-word;margin:0p=
x;outline-width:0px;color:rgb(32,33,36)"><span style=3D"letter-spacing:0.18=
5714px">Our first diagnosis is that we think the problem might be caused by=
 memory corruption. From the assembly code we can see that=C2=A0</span></p>=
<pre style=3D"font-family:WorkAroundWebKitAndMozilla,monospace;line-height:=
1.5;border-radius:2px;overflow-x:auto;padding:8px 16px;color:rgb(32,33,36);=
font-size:13px;letter-spacing:0.185714px"><code style=3D"font-family:WorkAr=
oundWebKitAndMozilla,monospace;border-radius:2px;padding:0px;line-height:1.=
5">chenglongtang@vm01:~/cos/src/third_party/kernel/v5.15$ echo &quot;Code: =
d7 49 89 f4 48 89 fb e8 1c 42 fb d3 48 83 f8 03 72 5f 49 89 c5 8a 03 3c 5c =
74 04 3c 2f 75 52 49 8b 3c 24 48 8b 05 9e d6 04 00 &lt;48&gt; 8b 30 e8 56 4=
5 fb d3 85 c0 75 64 48 89 df be c0 0c 00 00 e8 55&quot; | scripts/decodecod=
e
Code: d7 49 89 f4 48 89 fb e8 1c 42 fb d3 48 83 f8 03 72 5f 49 89 c5 8a 03 =
3c 5c 74 04 3c 2f 75 52 49 8b 3c 24 48 8b 05 9e d6 04 00 &lt;48&gt; 8b 30 e=
8 56 45 fb d3 85 c0 75 64 48 89 df be c0 0c 00 00 e8 55
All code
=3D=3D=3D=3D=3D=3D=3D=3D
   0:   d7                      xlat   %ds:(%rbx)
   1:   49 89 f4                mov    %rsi,%r12
   4:   48 89 fb                mov    %rdi,%rbx
   7:   e8 1c 42 fb d3          call   0xffffffffd3fb4228
   c:   48 83 f8 03             cmp    $0x3,%rax
  10:   72 5f                   jb     0x71
  12:   49 89 c5                mov    %rax,%r13
  15:   8a 03                   mov    (%rbx),%al
  17:   3c 5c                   cmp    $0x5c,%al
  19:   74 04                   je     0x1f
  1b:   3c 2f                   cmp    $0x2f,%al
  1d:   75 52                   jne    0x71
  1f:   49 8b 3c 24             mov    (%r12),%rdi
  23:   48 8b 05 9e d6 04 00    mov    0x4d69e(%rip),%rax        # 0x4d6c8
  2a:*  48 8b 30                mov    (%rax),%rsi              &lt;-- trap=
ping instruction
  2d:   e8 56 45 fb d3          call   0xffffffffd3fb4588 #if<span style=3D=
"box-sizing:border-box;margin:0px;padding:0px;color:rgb(0,0,0);font-family:=
&quot;Source Code Pro&quot;,monospace;font-size:13.3333px;letter-spacing:no=
rmal"> </span><span style=3D"box-sizing:border-box;margin:0px;padding:0px;c=
olor:rgb(102,102,0);font-family:&quot;Source Code Pro&quot;,monospace;font-=
size:13.3333px;letter-spacing:normal">(</span><span style=3D"box-sizing:bor=
der-box;margin:0px;padding:0px;color:rgb(0,0,0);font-family:&quot;Source Co=
de Pro&quot;,monospace;font-size:13.3333px;letter-spacing:normal">unlikely<=
/span><span style=3D"box-sizing:border-box;margin:0px;padding:0px;color:rgb=
(102,102,0);font-family:&quot;Source Code Pro&quot;,monospace;font-size:13.=
3333px;letter-spacing:normal">(</span><span style=3D"box-sizing:border-box;=
margin:0px;padding:0px;color:rgb(0,0,0);font-family:&quot;Source Code Pro&q=
uot;,monospace;font-size:13.3333px;letter-spacing:normal">strcmp</span><spa=
n style=3D"box-sizing:border-box;margin:0px;padding:0px;color:rgb(102,102,0=
);font-family:&quot;Source Code Pro&quot;,monospace;font-size:13.3333px;let=
ter-spacing:normal">(</span><span style=3D"box-sizing:border-box;margin:0px=
;padding:0px;color:rgb(0,0,0);font-family:&quot;Source Code Pro&quot;,monos=
pace;font-size:13.3333px;letter-spacing:normal">cp</span><span style=3D"box=
-sizing:border-box;margin:0px;padding:0px;color:rgb(102,102,0);font-family:=
&quot;Source Code Pro&quot;,monospace;font-size:13.3333px;letter-spacing:no=
rmal">-&gt;</span><span style=3D"box-sizing:border-box;margin:0px;padding:0=
px;color:rgb(0,0,0);font-family:&quot;Source Code Pro&quot;,monospace;font-=
size:13.3333px;letter-spacing:normal">charset</span><span style=3D"box-sizi=
ng:border-box;margin:0px;padding:0px;color:rgb(102,102,0);font-family:&quot=
;Source Code Pro&quot;,monospace;font-size:13.3333px;letter-spacing:normal"=
>,</span><span style=3D"box-sizing:border-box;margin:0px;padding:0px;color:=
rgb(0,0,0);font-family:&quot;Source Code Pro&quot;,monospace;font-size:13.3=
333px;letter-spacing:normal"> cache_cp</span><span style=3D"box-sizing:bord=
er-box;margin:0px;padding:0px;color:rgb(102,102,0);font-family:&quot;Source=
 Code Pro&quot;,monospace;font-size:13.3333px;letter-spacing:normal">-&gt;<=
/span><span style=3D"box-sizing:border-box;margin:0px;padding:0px;color:rgb=
(0,0,0);font-family:&quot;Source Code Pro&quot;,monospace;font-size:13.3333=
px;letter-spacing:normal">charset</span><span style=3D"box-sizing:border-bo=
x;margin:0px;padding:0px;color:rgb(102,102,0);font-family:&quot;Source Code=
 Pro&quot;,monospace;font-size:13.3333px;letter-spacing:normal">)))</span><=
span style=3D"box-sizing:border-box;margin:0px;padding:0px;color:rgb(0,0,0)=
;font-family:&quot;Source Code Pro&quot;,monospace;font-size:13.3333px;lett=
er-spacing:normal"> </span><span style=3D"box-sizing:border-box;margin:0px;=
padding:0px;color:rgb(102,102,0);font-family:&quot;Source Code Pro&quot;,mo=
nospace;font-size:13.3333px;letter-spacing:normal">{ </span>
  32:   85 c0                   test   %eax,%eax
  34:   75 64                   jne    0x9a
  36:   48 89 df                mov    %rbx,%rdi
  39:   be c0 0c 00 00          mov    $0xcc0,%esi
  3e:   e8                      .byte 0xe8
  3f:   55                      push   %rbp</code></pre><p style=3D"letter-=
spacing:0.185714px;font-size:13px;line-height:1.38462;border:0px;font-famil=
y:Roboto,Arial,sans-serif;vertical-align:baseline;word-break:break-word;mar=
gin:0px;outline-width:0px;color:rgb(32,33,36)"><span style=3D"letter-spacin=
g:0.185714px">The trapping happened before the call of=C2=A0</span><span st=
yle=3D"font-family:WorkAroundWebKitAndMozilla,monospace;letter-spacing:0.18=
5714px">0xffffffffd3fb4588 (strcmp) and=C2=A0</span><span style=3D"font-fam=
ily:WorkAroundWebKitAndMozilla,monospace;letter-spacing:0.185714px">mov (%r=
ax),%rsi is for the second argument of=C2=A0</span><span style=3D"font-fami=
ly:WorkAroundWebKitAndMozilla,monospace;letter-spacing:0.185714px">strcmp. =
And from the backtrace I posted, we can see that rax is ffffffff00000000, w=
hich was corrupted and that caused the segmentation fault.</span></p><p sty=
le=3D"letter-spacing:0.185714px;font-size:13px;line-height:1.38462;border:0=
px;font-family:Roboto,Arial,sans-serif;vertical-align:baseline;word-break:b=
reak-word;margin:0px;outline-width:0px;color:rgb(32,33,36)"><span style=3D"=
font-family:WorkAroundWebKitAndMozilla,monospace;letter-spacing:0.185714px"=
><br></span></p><p style=3D"letter-spacing:0.185714px;font-size:13px;line-h=
eight:1.38462;border:0px;font-family:Roboto,Arial,sans-serif;vertical-align=
:baseline;word-break:break-word;margin:0px;outline-width:0px;color:rgb(32,3=
3,36)"><span style=3D"font-family:WorkAroundWebKitAndMozilla,monospace;lett=
er-spacing:0.185714px">We checked that it&#39;s impossible for cache_cp to =
be NULL and cache_cp-&gt;charset should have a value because load_nfs_defau=
lt will definitely return a non-NULL value. That&#39;s why we believe it sh=
ould be caused by some changes related to the memory free/allocation that c=
orrupted the static table.</span></p><p style=3D"letter-spacing:0.185714px;=
font-size:13px;line-height:1.38462;border:0px;font-family:Roboto,Arial,sans=
-serif;vertical-align:baseline;word-break:break-word;margin:0px;outline-wid=
th:0px;color:rgb(32,33,36)"><span style=3D"font-family:WorkAroundWebKitAndM=
ozilla,monospace;letter-spacing:0.185714px"><br></span></p><p style=3D"lett=
er-spacing:0.185714px;font-size:13px;line-height:1.38462;border:0px;font-fa=
mily:Roboto,Arial,sans-serif;vertical-align:baseline;word-break:break-word;=
margin:0px;outline-width:0px;color:rgb(32,33,36)"><span style=3D"font-famil=
y:WorkAroundWebKitAndMozilla,monospace;letter-spacing:0.185714px">I can&#39=
;t narrow down anymore and am still working on=C2=A0it. Feel free to share =
thoughts with=C2=A0us.</span></p><p style=3D"letter-spacing:0.185714px;font=
-size:13px;line-height:1.38462;border:0px;font-family:Roboto,Arial,sans-ser=
if;vertical-align:baseline;word-break:break-word;margin:0px;outline-width:0=
px;color:rgb(32,33,36)"><span style=3D"font-family:WorkAroundWebKitAndMozil=
la,monospace;letter-spacing:0.185714px"><br></span></p><p style=3D"letter-s=
pacing:0.185714px;font-size:13px;line-height:1.38462;border:0px;font-family=
:Roboto,Arial,sans-serif;vertical-align:baseline;word-break:break-word;marg=
in:0px;outline-width:0px;color:rgb(32,33,36)"><span style=3D"font-family:Wo=
rkAroundWebKitAndMozilla,monospace;letter-spacing:0.185714px">Best,</span><=
/p><p style=3D"letter-spacing:0.185714px;font-size:13px;line-height:1.38462=
;border:0px;font-family:Roboto,Arial,sans-serif;vertical-align:baseline;wor=
d-break:break-word;margin:0px;outline-width:0px;color:rgb(32,33,36)"><span =
style=3D"font-family:WorkAroundWebKitAndMozilla,monospace;letter-spacing:0.=
185714px"><br></span></p><p style=3D"letter-spacing:0.185714px;font-size:13=
px;line-height:1.38462;border:0px;font-family:Roboto,Arial,sans-serif;verti=
cal-align:baseline;word-break:break-word;margin:0px;outline-width:0px;color=
:rgb(32,33,36)"><span style=3D"font-family:WorkAroundWebKitAndMozilla,monos=
pace;letter-spacing:0.185714px">Chenglong</span></p></div></div>

--00000000000057ac530615da6a9b--
--00000000000057ac530615da6a9d
Content-Type: text/plain; charset="US-ASCII"; name="backtrace.txt"
Content-Disposition: attachment; filename="backtrace.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_luvv4o5s0>
X-Attachment-Id: f_luvv4o5s0

UElEOiA1MjU5NiAgICBUQVNLOiBmZmZmOTkyYzkyZWRjMzAwICBDUFU6IDkgICAgQ09NTUFORDog
Im1vdW50LmNpZnMiCiAjMCBbZmZmZmIzZGJjMzRmYjk0OF0gbWFjaGluZV9rZXhlYyBhdCBmZmZm
ZmZmZjk0MDc1Zjc1CiAgICAvYnVpbGQvbGFraXR1L3RtcC9wb3J0YWdlL3N5cy1rZXJuZWwvbGFr
aXR1LWtlcm5lbC01XzE1LTUuMTUuMTQ2LXIxODEvd29yay9sYWtpdHUta2VybmVsLTVfMTUtNS4x
NS4xNDYvYXJjaC94ODYva2VybmVsL21hY2hpbmVfa2V4ZWNfNjQKLmM6IDM1OAogIzEgW2ZmZmZi
M2RiYzM0ZmI5YzhdIGNyYXNoX2tleGVjIGF0IGZmZmZmZmZmOTQxNjRiZTMKICAgIC9idWlsZC9s
YWtpdHUvdG1wL3BvcnRhZ2Uvc3lzLWtlcm5lbC9sYWtpdHUta2VybmVsLTVfMTUtNS4xNS4xNDYt
cjE4MS93b3JrL2xha2l0dS1rZXJuZWwtNV8xNS01LjE1LjE0Ni9pbmNsdWRlL2xpbnV4L2F0b21p
Yy9hdG9taWMtYXJjaAotZmFsbGJhY2suaDogMTczCiAjMiBbZmZmZmIzZGJjMzRmYmE5OF0gb29w
c19lbmQgYXQgZmZmZmZmZmY5NDA0MWI0NgogICAgL2J1aWxkL2xha2l0dS90bXAvcG9ydGFnZS9z
eXMta2VybmVsL2xha2l0dS1rZXJuZWwtNV8xNS01LjE1LjE0Ni1yMTgxL3dvcmsvbGFraXR1LWtl
cm5lbC01XzE1LTUuMTUuMTQ2L2FyY2gveDg2L2tlcm5lbC9kdW1wc3RhY2suYzogMzY0CiAjMyBb
ZmZmZmIzZGJjMzRmYmFjMF0gcGFnZV9mYXVsdF9vb3BzIGF0IGZmZmZmZmZmOTQwODhjYTcKICAg
IC9idWlsZC9sYWtpdHUvdG1wL3BvcnRhZ2Uvc3lzLWtlcm5lbC9sYWtpdHUta2VybmVsLTVfMTUt
NS4xNS4xNDYtcjE4MS93b3JrL2xha2l0dS1rZXJuZWwtNV8xNS01LjE1LjE0Ni9hcmNoL3g4Ni9t
bS9mYXVsdC5jOiA3MDgKICM0IFtmZmZmYjNkYmMzNGZiYjUwXSBleGNfcGFnZV9mYXVsdCBhdCBm
ZmZmZmZmZjk0YjYxZTA2CiAgICAvYnVpbGQvbGFraXR1L3RtcC9wb3J0YWdlL3N5cy1rZXJuZWwv
bGFraXR1LWtlcm5lbC01XzE1LTUuMTUuMTQ2LXIxODEvd29yay9sYWtpdHUta2VybmVsLTVfMTUt
NS4xNS4xNDYvYXJjaC94ODYvbW0vZmF1bHQuYzogMTQ4MwogIzUgW2ZmZmZiM2RiYzM0ZmJiODBd
IGFzbV9leGNfcGFnZV9mYXVsdCBhdCBmZmZmZmZmZjk0YzAwYmEyCiAgICAvYnVpbGQvbGFraXR1
L3RtcC9wb3J0YWdlL3N5cy1rZXJuZWwvbGFraXR1LWtlcm5lbC01XzE1LTUuMTUuMTQ2LXIxODEv
d29yay9sYWtpdHUta2VybmVsLTVfMTUtNS4xNS4xNDYvYXJjaC94ODYvaW5jbHVkZS9hc20vaWR0
ZW50cnkuaDoKIDU2OAogICAgW2V4Y2VwdGlvbiBSSVA6IGRmc19jYWNoZV9jYW5vbmljYWxfcGF0
aCs5OF0KICAgIFJJUDogZmZmZmZmZmZjMDY5ZGRlMiAgUlNQOiBmZmZmYjNkYmMzNGZiYzM4ICBS
RkxBR1M6IDAwMDEwMjQ2CiAgICBSQVg6IGZmZmZmZmZmMDAwMDAwMDAgIFJCWDogZmZmZjk5MmRk
ZDk3ODk0MSAgUkNYOiAwMDAwMDAwMDAwMDAwMDAxCiAgICBSRFg6IDAwMDAwMDAwMDAwMDAwMDEg
IFJTSTogZmZmZmZmZmZjMDcyNzEwMCAgUkRJOiBmZmZmZmZmZmMwNzI2MDAwCiAgICBSQlA6IGZm
ZmZiM2RiYzM0ZmJjNzAgICBSODogZmZmZjk5MmRkZDk3ODk0MSAgIFI5OiAwMDAwMDAwMDAwMDAw
MDAwCiAgICBSMTA6IGZmZmZiM2RiYzM0ZmJjZTggIFIxMTogZmZmZmZmZmZjMDY4MmNiMCAgUjEy
OiBmZmZmZmZmZmMwNzI3MTAwCiAgICBSMTM6IDAwMDAwMDAwMDAwMDAwMzIgIFIxNDogZmZmZmZm
ZmZmZmZmZmZlYSAgUjE1OiAwMDAwMDAwMDAwMDAwMDAxCiAgICBPUklHX1JBWDogZmZmZmZmZmZm
ZmZmZmZmZiAgQ1M6IDAwMTAgIFNTOiAwMDE4CiAgICAvYnVpbGQvbGFraXR1L3RtcC9wb3J0YWdl
L3N5cy1rZXJuZWwvbGFraXR1LWtlcm5lbC01XzE1LTUuMTUuMTQ2LXIxODEvd29yay9sYWtpdHUt
a2VybmVsLTVfMTUtNS4xNS4xNDYvZnMvY2lmcy9kZnNfY2FjaGUuYzogMTk3CiAjNiBbZmZmZmIz
ZGJjMzRmYmM3OF0gZGZzX2NhY2hlX2ZpbmQgYXQgZmZmZmZmZmZjMDY5ZTMyYiBbY2lmc10KICAg
IC9idWlsZC9sYWtpdHUvdG1wL3BvcnRhZ2Uvc3lzLWtlcm5lbC9sYWtpdHUta2VybmVsLTVfMTUt
NS4xNS4xNDYtcjE4MS93b3JrL2xha2l0dS1rZXJuZWwtNV8xNS01LjE1LjE0Ni9mcy9jaWZzL2Rm
c19jYWNoZS5jOiA5NTYKICM3IFtmZmZmYjNkYmMzNGZiY2I4XSBjaWZzX21vdW50IGF0IGZmZmZm
ZmZmYzA2NTNhZmMgW2NpZnNdCiAgICAvYnVpbGQvbGFraXR1L3RtcC9wb3J0YWdlL3N5cy1rZXJu
ZWwvbGFraXR1LWtlcm5lbC01XzE1LTUuMTUuMTQ2LXIxODEvd29yay9sYWtpdHUta2VybmVsLTVf
MTUtNS4xNS4xNDYvZnMvY2lmcy9jb25uZWN0LmM6IDMzNDQKICM4IFtmZmZmYjNkYmMzNGZiZGE4
XSBjaWZzX3NtYjNfZG9fbW91bnQgYXQgZmZmZmZmZmZjMDY0MzNmZiBbY2lmc10KICAgIC9idWls
ZC9sYWtpdHUvdG1wL3BvcnRhZ2Uvc3lzLWtlcm5lbC9sYWtpdHUta2VybmVsLTVfMTUtNS4xNS4x
NDYtcjE4MS93b3JrL2xha2l0dS1rZXJuZWwtNV8xNS01LjE1LjE0Ni9mcy9jaWZzL2NpZnNmcy5j
OiA4OTQKICM5IFtmZmZmYjNkYmMzNGZiZTAwXSBzbWIzX2dldF90cmVlIGF0IGZmZmZmZmZmYzA2
OWI4MDkgW2NpZnNdCiAgICAvYnVpbGQvbGFraXR1L3RtcC9wb3J0YWdlL3N5cy1rZXJuZWwvbGFr
aXR1LWtlcm5lbC01XzE1LTUuMTUuMTQ2LXIxODEvd29yay9sYWtpdHUta2VybmVsLTVfMTUtNS4x
NS4xNDYvaW5jbHVkZS9saW51eC9lcnIuaDogMzYKIzEwIFtmZmZmYjNkYmMzNGZiZTI4XSB2ZnNf
Z2V0X3RyZWUgYXQgZmZmZmZmZmY5NDMyM2JlYgogICAgL2J1aWxkL2xha2l0dS90bXAvcG9ydGFn
ZS9zeXMta2VybmVsL2xha2l0dS1rZXJuZWwtNV8xNS01LjE1LjE0Ni1yMTgxL3dvcmsvbGFraXR1
LWtlcm5lbC01XzE1LTUuMTUuMTQ2L2ZzL3N1cGVyLmM6IDE1MTgKIzExIFtmZmZmYjNkYmMzNGZi
ZTU4XSBkb19uZXdfbW91bnQgYXQgZmZmZmZmZmY5NDM0ZGUzNwogICAgL2J1aWxkL2xha2l0dS90
bXAvcG9ydGFnZS9zeXMta2VybmVsL2xha2l0dS1rZXJuZWwtNV8xNS01LjE1LjE0Ni1yMTgxL3dv
cmsvbGFraXR1LWtlcm5lbC01XzE1LTUuMTUuMTQ2L2ZzL25hbWVzcGFjZS5jOiAyOTk0CiMxMiBb
ZmZmZmIzZGJjMzRmYmVjMF0gX19zZV9zeXNfbW91bnQgYXQgZmZmZmZmZmY5NDM0ZTlhOQogICAg
L2J1aWxkL2xha2l0dS90bXAvcG9ydGFnZS9zeXMta2VybmVsL2xha2l0dS1rZXJuZWwtNV8xNS01
LjE1LjE0Ni1yMTgxL3dvcmsvbGFraXR1LWtlcm5lbC01XzE1LTUuMTUuMTQ2L2ZzL25hbWVzcGFj
ZS5jOiAzMzM3CiMxMyBbZmZmZmIzZGJjMzRmYmYxOF0gZG9fc3lzY2FsbF82NCBhdCBmZmZmZmZm
Zjk0YjVlNmQxCiAgICAvYnVpbGQvbGFraXR1L3RtcC9wb3J0YWdlL3N5cy1rZXJuZWwvbGFraXR1
LWtlcm5lbC01XzE1LTUuMTUuMTQ2LXIxODEvd29yay9sYWtpdHUta2VybmVsLTVfMTUtNS4xNS4x
NDYvYXJjaC94ODYvZW50cnkvY29tbW9uLmM6IDUwCiMxNCBbZmZmZmIzZGJjMzRmYmY1MF0gZW50
cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lIGF0IGZmZmZmZmZmOTRjMDAwZGEKICAgIC9idWls
ZC9sYWtpdHUvdG1wL3BvcnRhZ2Uvc3lzLWtlcm5lbC9sYWtpdHUta2VybmVsLTVfMTUtNS4xNS4x
NDYtcjE4MS93b3JrL2xha2l0dS1rZXJuZWwtNV8xNS01LjE1LjE0Ni9hcmNoL3g4Ni9lbnRyeS9l
bnRyeV82NC5TOiAxMTgKICAgIFJJUDogMDAwMDdmNTcwZGE1ZGI3YSAgUlNQOiAwMDAwN2ZmZTky
ZDE2YzU4ICBSRkxBR1M6IDAwMDAwMjAyCiAgICBSQVg6IGZmZmZmZmZmZmZmZmZmZGEgIFJCWDog
MDAwMDU1NzRjNzZjY2ViMCAgUkNYOiAwMDAwN2Y1NzBkYTVkYjdhCiAgICBSRFg6IDAwMDA1NTc0
YzVlZDM0NWIgIFJTSTogMDAwMDU1NzRjNWVkMzRmYSAgUkRJOiAwMDAwN2ZmZTkyZDE3OGEyCiAg
ICBSQlA6IDAwMDA1NTc0YzVlZDMxMDkgICBSODogMDAwMDU1NzRjNzZjY2ViMCAgIFI5OiAwMDAw
N2ZmZTkyZDE1ZmYwCiAgICBSMTA6IDAwMDAwMDAwMDAwMDAwMDAgIFIxMTogMDAwMDAwMDAwMDAw
MDIwMiAgUjEyOiAwMDAwN2ZmZTkyZDE3OGEyCiAgICBSMTM6IDAwMDA1NTc0Yzc2Y2RmNDAgIFIx
NDogMDAwMDAwMDAwMDAwMDAwYSAgUjE1OiAwMDAwN2Y1NzBkOTRlMDAwCiAgICBPUklHX1JBWDog
MDAwMDAwMDAwMDAwMDBhNSAgQ1M6IDAwMzMgIFNTOiAwMDJiCg==
--00000000000057ac530615da6a9d
Content-Type: text/plain; charset="US-ASCII"; name="dmesg.txt"
Content-Disposition: attachment; filename="dmesg.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_luvv4o651>
X-Attachment-Id: f_luvv4o651

WyAgICAwLjAwMDAwMF0gTGludXggdmVyc2lvbiA1LjE1LjE0NisgKGJ1aWxkZXJAbG9jYWxob3N0
KSAoQ2hyb21pdW0gT1MgMTQuMF9wcmU0NDUwMDJfcDIwMjIwMjE3LXIzIGNsYW5nIHZlcnNpb24g
MTQuMC4wICgvdmFyL3RtcC9wb3J0YWdlL3N5cy1kZXZlbC9sbHZtLTE0LjBfcHJlNDQ1MDAyX3Ay
MDIyMDIxNy1yMy93b3JrL2xsdm0tMTQuMF9wcmU0NDUwMDJfcDIwMjIwMjE3L2NsYW5nIDE4MzA4
ZTE3MWI1YjFkZDk5NjI3YTRkODhjN2Q2YzVmZjIxYjhjOTYpLCBMTEQgMTQuMC4wKSAjMSBTTVAg
VHVlIEphbiAzMCAxMToxMjoxMyBVVEMgMjAyNApbICAgIDAuMDAwMDAwXSBDb21tYW5kIGxpbmU6
IEJPT1RfSU1BR0U9L3N5c2xpbnV4L3ZtbGludXouQSBpbml0PS91c3IvbGliL3N5c3RlbWQvc3lz
dGVtZCBib290PWxvY2FsIHJvb3R3YWl0IHJvIG5vcmVzdW1lIGxvZ2xldmVsPTcgY29uc29sZT10
dHkxIGNvbnNvbGU9dHR5UzAgc2VjdXJpdHk9YXBwYXJtb3IgdmlydGlvX25ldC5uYXBpX3R4PTEg
bm1pX3dhdGNoZG9nPTAgY3NtLmRpc2FibGVkPTAgY3NtLnBpcGUuZW5hYmxlZD0xIGNzbS5jb25m
aWcuZW5hYmxlZD0xICxmaXJtd2FyZSBmaXJtd2FyZV9jbGFzcy5wYXRoPS9ob21lL2t1YmVybmV0
ZXMvYmluL252aWRpYS9maXJtd2FyZSBtb2R1bGUuc2lnX2VuZm9yY2U9MCBkbV92ZXJpdHkuZXJy
b3JfYmVoYXZpb3I9MyBkbV92ZXJpdHkubWF4X2Jpb3M9LTEgZG1fdmVyaXR5LmRldl93YWl0PTEg
aTkxNS5tb2Rlc2V0PTEgY3Jvc19lZmkgY3Jhc2hrZXJuZWw9ME0tOEc6NjRNLDhHLTEyOEc6MjU2
TSwxMjhHLTo1MTJNIHVua25vd25fbm1pX3BhbmljPTEgcGFuaWNfb25fdW5yZWNvdmVyZWRfbm1p
PTEgY29zLmRpc2FibGVfc3lzdGVtZF9yb3V0ZV9tZ210IHJvb3Q9L2Rldi9kbS0wICJkbT0xIHZy
b290IG5vbmUgcm8gMSwwIDQwNzc1NjggdmVyaXR5IHBheWxvYWQ9UEFSVFVVSUQ9RDc1MTRFRkIt
M0JDRC04QjQ3LUE2RUEtMEFCOUI0MDVEQzBFIGhhc2h0cmVlPVBBUlRVVUlEPUQ3NTE0RUZCLTNC
Q0QtOEI0Ny1BNkVBLTBBQjlCNDA1REMwRSBoYXNoc3RhcnQ9NDA3NzU2OCBhbGc9c2hhMjU2IHJv
b3RfaGV4ZGlnZXN0PTNlYWE1YmE2ODQyMTAwZDQzZWZlYTAwYjY0ZTQwYTgzMjFkYjcyMTcyMDNi
OGI5MDIzMDIyNTBlODFlMmUwZjcgc2FsdD0yNzdiZTkwMjI2OTU2NTA0MmE3ZWI1YWQwODQxZTdk
NTRiYjhkNmNmZWFmZWE1N2ZkMGU1MWEzYTEwZGUxNDA0IgpbICAgIDAuMDAwMDAwXSBbRmlybXdh
cmUgQnVnXTogVFNDIGRvZXNuJ3QgY291bnQgd2l0aCBQMCBmcmVxdWVuY3khClsgICAgMC4wMDAw
MDBdIEJJT1MtcHJvdmlkZWQgcGh5c2ljYWwgUkFNIG1hcDoKWyAgICAwLjAwMDAwMF0gQklPUy1l
ODIwOiBbbWVtIDB4MDAwMDAwMDAwMDAwMDAwMC0weDAwMDAwMDAwMDAwMDBmZmZdIHJlc2VydmVk
ClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwMDAwMDEwMDAtMHgwMDAw
MDAwMDAwMDU0ZmZmXSB1c2FibGUKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAw
MDAwMDAwMDA1NTAwMC0weDAwMDAwMDAwMDAwNWZmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBd
IEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwMDAwNjAwMDAtMHgwMDAwMDAwMDAwMDk3ZmZmXSB1
c2FibGUKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDAwMDA5ODAwMC0w
eDAwMDAwMDAwMDAwOWZmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21l
bSAweDAwMDAwMDAwMDAxMDAwMDAtMHgwMDAwMDAwMGJmOGVjZmZmXSB1c2FibGUKWyAgICAwLjAw
MDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAwMDAwMDBiZjhlZDAwMC0weDAwMDAwMDAwYmZiNmNm
ZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwYmZi
NmQwMDAtMHgwMDAwMDAwMGJmYjdlZmZmXSBBQ1BJIGRhdGEKWyAgICAwLjAwMDAwMF0gQklPUy1l
ODIwOiBbbWVtIDB4MDAwMDAwMDBiZmI3ZjAwMC0weDAwMDAwMDAwYmZiZmVmZmZdIEFDUEkgTlZT
ClsgICAgMC4wMDAwMDBdIEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAwYmZiZmYwMDAtMHgwMDAw
MDAwMGJmZmRmZmZmXSB1c2FibGUKWyAgICAwLjAwMDAwMF0gQklPUy1lODIwOiBbbWVtIDB4MDAw
MDAwMDBiZmZlMDAwMC0weDAwMDAwMDAwYmZmZmZmZmZdIHJlc2VydmVkClsgICAgMC4wMDAwMDBd
IEJJT1MtZTgyMDogW21lbSAweDAwMDAwMDAxMDAwMDAwMDAtMHgwMDAwMDAwN2JmZmZmZmZmXSB1
c2FibGUKWyAgICAwLjAwMDAwMF0gTlggKEV4ZWN1dGUgRGlzYWJsZSkgcHJvdGVjdGlvbjogYWN0
aXZlClsgICAgMC4wMDAwMDBdIGVmaTogRUZJIHYyLjcwIGJ5IEVESyBJSQpbICAgIDAuMDAwMDAw
XSBlZmk6IFRQTUZpbmFsTG9nPTB4YmZiZjcwMDAgQUNQST0weGJmYjdlMDAwIEFDUEkgMi4wPTB4
YmZiN2UwMTQgU01CSU9TPTB4YmY5Y2EwMDAgTUVNQVRUUj0weGJlNGVkMDE4IE1PS3Zhcj0weGJm
OWM4MDAwIFJORz0weGJmYjczMDE4IFRQTUV2ZW50TG9nPTB4YmU0MzcwMTggClsgICAgMC4wMDAw
MDBdIFNNQklPUyAyLjQgcHJlc2VudC4KWyAgICAwLjAwMDAwMF0gRE1JOiBHb29nbGUgR29vZ2xl
IENvbXB1dGUgRW5naW5lL0dvb2dsZSBDb21wdXRlIEVuZ2luZSwgQklPUyBHb29nbGUgMDMvMjcv
MjAyNApbICAgIDAuMDAwMDAwXSBIeXBlcnZpc29yIGRldGVjdGVkOiBLVk0KWyAgICAwLjAwMDAw
MF0ga3ZtLWNsb2NrOiBVc2luZyBtc3JzIDRiNTY0ZDAxIGFuZCA0YjU2NGQwMApbICAgIDAuMDAw
MDAwXSBrdm0tY2xvY2s6IGNwdSAwLCBtc3IgM2Q4MDAwMDAxLCBwcmltYXJ5IGNwdSBjbG9jawpb
ICAgIDAuMDAwMDAxXSBrdm0tY2xvY2s6IHVzaW5nIHNjaGVkIG9mZnNldCBvZiA0MjMxNTE5NjUy
IGN5Y2xlcwpbICAgIDAuMDAwMDAyXSBjbG9ja3NvdXJjZToga3ZtLWNsb2NrOiBtYXNrOiAweGZm
ZmZmZmZmZmZmZmZmZmYgbWF4X2N5Y2xlczogMHgxY2Q0MmU0ZGZmYiwgbWF4X2lkbGVfbnM6IDg4
MTU5MDU5MTQ4MyBucwpbICAgIDAuMDAwMDA1XSB0c2M6IERldGVjdGVkIDIyNDkuOTk4IE1IeiBw
cm9jZXNzb3IKWyAgICAwLjAwMDA2Nl0gZTgyMDogdXBkYXRlIFttZW0gMHgwMDAwMDAwMC0weDAw
MDAwZmZmXSB1c2FibGUgPT0+IHJlc2VydmVkClsgICAgMC4wMDAwNjhdIGU4MjA6IHJlbW92ZSBb
bWVtIDB4MDAwYTAwMDAtMHgwMDBmZmZmZl0gdXNhYmxlClsgICAgMC4wMDAwNzNdIGxhc3RfcGZu
ID0gMHg3YzAwMDAgbWF4X2FyY2hfcGZuID0gMHg0MDAwMDAwMDAKWyAgICAwLjAwMDEyOF0geDg2
L1BBVDogQ29uZmlndXJhdGlvbiBbMC03XTogV0IgIFdDICBVQy0gVUMgIFdCICBXUCAgVUMtIFdU
ICAKWyAgICAwLjAwMDEzOV0gbGFzdF9wZm4gPSAweGJmZmUwIG1heF9hcmNoX3BmbiA9IDB4NDAw
MDAwMDAwClsgICAgMC4wMDM3ODddIFVzaW5nIEdCIHBhZ2VzIGZvciBkaXJlY3QgbWFwcGluZwpb
ICAgIDAuMDAzOTkzXSBTZWN1cmUgYm9vdCBkaXNhYmxlZApbICAgIDAuMDAzOTk1XSBBQ1BJOiBF
YXJseSB0YWJsZSBjaGVja3N1bSB2ZXJpZmljYXRpb24gZGlzYWJsZWQKWyAgICAwLjAwMzk5OV0g
QUNQSTogUlNEUCAweDAwMDAwMDAwQkZCN0UwMTQgMDAwMDI0ICh2MDIgR29vZ2xlKQpbICAgIDAu
MDA0MDAyXSBBQ1BJOiBYU0RUIDB4MDAwMDAwMDBCRkI3RDBFOCAwMDAwNUMgKHYwMSBHb29nbGUg
R09PR0ZBQ1AgMDAwMDAwMDEgICAgICAwMTAwMDAxMykKWyAgICAwLjAwNDAwN10gQUNQSTogRkFD
UCAweDAwMDAwMDAwQkZCNzgwMDAgMDAwMEY0ICh2MDIgR29vZ2xlIEdPT0dGQUNQIDAwMDAwMDAx
IEdPT0cgMDAwMDAwMDEpClsgICAgMC4wMDQwMTFdIEFDUEk6IERTRFQgMHgwMDAwMDAwMEJGQjc5
MDAwIDAwMUE2NCAodjAxIEdvb2dsZSBHT09HRFNEVCAwMDAwMDAwMSBHT09HIDAwMDAwMDAxKQpb
ICAgIDAuMDA0MDE0XSBBQ1BJOiBGQUNTIDB4MDAwMDAwMDBCRkJGMjAwMCAwMDAwNDAKWyAgICAw
LjAwNDAxNl0gQUNQSTogU1NEVCAweDAwMDAwMDAwQkZCN0MwMDAgMDAwMzE2ICh2MDIgR09PR0xF
IFRwbTJUYWJsIDAwMDAxMDAwIElOVEwgMjAyMTEyMTcpClsgICAgMC4wMDQwMThdIEFDUEk6IFRQ
TTIgMHgwMDAwMDAwMEJGQjdCMDAwIDAwMDAzNCAodjA0IEdPT0dMRSAgICAgICAgICAwMDAwMDAw
MSBHT09HIDAwMDAwMDAxKQpbICAgIDAuMDA0MDIxXSBBQ1BJOiBTUkFUIDB4MDAwMDAwMDBCRkI3
NzAwMCAwMDAxQTggKHYwMyBHb29nbGUgR09PR1NSQVQgMDAwMDAwMDEgR09PRyAwMDAwMDAwMSkK
WyAgICAwLjAwNDAyM10gQUNQSTogQVBJQyAweDAwMDAwMDAwQkZCNzYwMDAgMDAwMEU2ICh2MDUg
R29vZ2xlIEdPT0dBUElDIDAwMDAwMDAxIEdPT0cgMDAwMDAwMDEpClsgICAgMC4wMDQwMjZdIEFD
UEk6IFNTRFQgMHgwMDAwMDAwMEJGQjc1MDAwIDAwMEVDRSAodjAxIEdvb2dsZSBHT09HU1NEVCAw
MDAwMDAwMSBHT09HIDAwMDAwMDAxKQpbICAgIDAuMDA0MDI4XSBBQ1BJOiBXQUVUIDB4MDAwMDAw
MDBCRkI3NDAwMCAwMDAwMjggKHYwMSBHb29nbGUgR09PR1dBRVQgMDAwMDAwMDEgR09PRyAwMDAw
MDAwMSkKWyAgICAwLjAwNDAzMF0gQUNQSTogUmVzZXJ2aW5nIEZBQ1AgdGFibGUgbWVtb3J5IGF0
IFttZW0gMHhiZmI3ODAwMC0weGJmYjc4MGYzXQpbICAgIDAuMDA0MDMxXSBBQ1BJOiBSZXNlcnZp
bmcgRFNEVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweGJmYjc5MDAwLTB4YmZiN2FhNjNdClsgICAg
MC4wMDQwMzJdIEFDUEk6IFJlc2VydmluZyBGQUNTIHRhYmxlIG1lbW9yeSBhdCBbbWVtIDB4YmZi
ZjIwMDAtMHhiZmJmMjAzZl0KWyAgICAwLjAwNDAzM10gQUNQSTogUmVzZXJ2aW5nIFNTRFQgdGFi
bGUgbWVtb3J5IGF0IFttZW0gMHhiZmI3YzAwMC0weGJmYjdjMzE1XQpbICAgIDAuMDA0MDM0XSBB
Q1BJOiBSZXNlcnZpbmcgVFBNMiB0YWJsZSBtZW1vcnkgYXQgW21lbSAweGJmYjdiMDAwLTB4YmZi
N2IwMzNdClsgICAgMC4wMDQwMzVdIEFDUEk6IFJlc2VydmluZyBTUkFUIHRhYmxlIG1lbW9yeSBh
dCBbbWVtIDB4YmZiNzcwMDAtMHhiZmI3NzFhN10KWyAgICAwLjAwNDAzNl0gQUNQSTogUmVzZXJ2
aW5nIEFQSUMgdGFibGUgbWVtb3J5IGF0IFttZW0gMHhiZmI3NjAwMC0weGJmYjc2MGU1XQpbICAg
IDAuMDA0MDM3XSBBQ1BJOiBSZXNlcnZpbmcgU1NEVCB0YWJsZSBtZW1vcnkgYXQgW21lbSAweGJm
Yjc1MDAwLTB4YmZiNzVlY2RdClsgICAgMC4wMDQwMzhdIEFDUEk6IFJlc2VydmluZyBXQUVUIHRh
YmxlIG1lbW9yeSBhdCBbbWVtIDB4YmZiNzQwMDAtMHhiZmI3NDAyN10KWyAgICAwLjAwNDA3M10g
U1JBVDogUFhNIDAgLT4gQVBJQyAweDAwIC0+IE5vZGUgMApbICAgIDAuMDA0MDc1XSBTUkFUOiBQ
WE0gMCAtPiBBUElDIDB4MDEgLT4gTm9kZSAwClsgICAgMC4wMDQwNzVdIFNSQVQ6IFBYTSAwIC0+
IEFQSUMgMHgwMiAtPiBOb2RlIDAKWyAgICAwLjAwNDA3Nl0gU1JBVDogUFhNIDAgLT4gQVBJQyAw
eDAzIC0+IE5vZGUgMApbICAgIDAuMDA0MDc3XSBTUkFUOiBQWE0gMCAtPiBBUElDIDB4MDQgLT4g
Tm9kZSAwClsgICAgMC4wMDQwNzhdIFNSQVQ6IFBYTSAwIC0+IEFQSUMgMHgwNSAtPiBOb2RlIDAK
WyAgICAwLjAwNDA3OF0gU1JBVDogUFhNIDAgLT4gQVBJQyAweDA2IC0+IE5vZGUgMApbICAgIDAu
MDA0MDc5XSBTUkFUOiBQWE0gMCAtPiBBUElDIDB4MDcgLT4gTm9kZSAwClsgICAgMC4wMDQwODBd
IFNSQVQ6IFBYTSAwIC0+IEFQSUMgMHgwOCAtPiBOb2RlIDAKWyAgICAwLjAwNDA4MV0gU1JBVDog
UFhNIDAgLT4gQVBJQyAweDA5IC0+IE5vZGUgMApbICAgIDAuMDA0MDgxXSBTUkFUOiBQWE0gMCAt
PiBBUElDIDB4MGEgLT4gTm9kZSAwClsgICAgMC4wMDQwODJdIFNSQVQ6IFBYTSAwIC0+IEFQSUMg
MHgwYiAtPiBOb2RlIDAKWyAgICAwLjAwNDA4M10gU1JBVDogUFhNIDAgLT4gQVBJQyAweDBjIC0+
IE5vZGUgMApbICAgIDAuMDA0MDg0XSBTUkFUOiBQWE0gMCAtPiBBUElDIDB4MGQgLT4gTm9kZSAw
ClsgICAgMC4wMDQwODVdIFNSQVQ6IFBYTSAwIC0+IEFQSUMgMHgwZSAtPiBOb2RlIDAKWyAgICAw
LjAwNDA4NV0gU1JBVDogUFhNIDAgLT4gQVBJQyAweDBmIC0+IE5vZGUgMApbICAgIDAuMDA0MDg3
XSBBQ1BJOiBTUkFUOiBOb2RlIDAgUFhNIDAgW21lbSAweDAwMDAwMDAwLTB4MDAwOWZmZmZdClsg
ICAgMC4wMDQwODldIEFDUEk6IFNSQVQ6IE5vZGUgMCBQWE0gMCBbbWVtIDB4MDAxMDAwMDAtMHhi
ZmZmZmZmZl0KWyAgICAwLjAwNDA5MF0gQUNQSTogU1JBVDogTm9kZSAwIFBYTSAwIFttZW0gMHgx
MDAwMDAwMDAtMHg3YmZmZmZmZmZdClsgICAgMC4wMDQwOTJdIE5VTUE6IE5vZGUgMCBbbWVtIDB4
MDAwMDAwMDAtMHgwMDA5ZmZmZl0gKyBbbWVtIDB4MDAxMDAwMDAtMHhiZmZmZmZmZl0gLT4gW21l
bSAweDAwMDAwMDAwLTB4YmZmZmZmZmZdClsgICAgMC4wMDQwOTRdIE5VTUE6IE5vZGUgMCBbbWVt
IDB4MDAwMDAwMDAtMHhiZmZmZmZmZl0gKyBbbWVtIDB4MTAwMDAwMDAwLTB4N2JmZmZmZmZmXSAt
PiBbbWVtIDB4MDAwMDAwMDAtMHg3YmZmZmZmZmZdClsgICAgMC4wMDQwOTddIE5PREVfREFUQSgw
KSBhbGxvY2F0ZWQgW21lbSAweDdiZmZmYzAwMC0weDdiZmZmZmZmZl0KWyAgICAwLjAwNDI3M10g
UmVzZXJ2aW5nIDI1Nk1CIG9mIG1lbW9yeSBhdCAzMk1CIGZvciBjcmFzaGtlcm5lbCAoU3lzdGVt
IFJBTTogMzA3MTZNQikKWyAgICAwLjAwNDI5NF0gWm9uZSByYW5nZXM6ClsgICAgMC4wMDQyOTVd
ICAgRE1BICAgICAgW21lbSAweDAwMDAwMDAwMDAwMDEwMDAtMHgwMDAwMDAwMDAwZmZmZmZmXQpb
ICAgIDAuMDA0Mjk3XSAgIERNQTMyICAgIFttZW0gMHgwMDAwMDAwMDAxMDAwMDAwLTB4MDAwMDAw
MDBmZmZmZmZmZl0KWyAgICAwLjAwNDI5OV0gICBOb3JtYWwgICBbbWVtIDB4MDAwMDAwMDEwMDAw
MDAwMC0weDAwMDAwMDA3YmZmZmZmZmZdClsgICAgMC4wMDQzMDBdIE1vdmFibGUgem9uZSBzdGFy
dCBmb3IgZWFjaCBub2RlClsgICAgMC4wMDQzMDFdIEVhcmx5IG1lbW9yeSBub2RlIHJhbmdlcwpb
ICAgIDAuMDA0MzAyXSAgIG5vZGUgICAwOiBbbWVtIDB4MDAwMDAwMDAwMDAwMTAwMC0weDAwMDAw
MDAwMDAwNTRmZmZdClsgICAgMC4wMDQzMDRdICAgbm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMDAw
MDYwMDAwLTB4MDAwMDAwMDAwMDA5N2ZmZl0KWyAgICAwLjAwNDMwNV0gICBub2RlICAgMDogW21l
bSAweDAwMDAwMDAwMDAxMDAwMDAtMHgwMDAwMDAwMGJmOGVjZmZmXQpbICAgIDAuMDA0MzA2XSAg
IG5vZGUgICAwOiBbbWVtIDB4MDAwMDAwMDBiZmJmZjAwMC0weDAwMDAwMDAwYmZmZGZmZmZdClsg
ICAgMC4wMDQzMDddICAgbm9kZSAgIDA6IFttZW0gMHgwMDAwMDAwMTAwMDAwMDAwLTB4MDAwMDAw
MDdiZmZmZmZmZl0KWyAgICAwLjAwNDMwOV0gSW5pdG1lbSBzZXR1cCBub2RlIDAgW21lbSAweDAw
MDAwMDAwMDAwMDEwMDAtMHgwMDAwMDAwN2JmZmZmZmZmXQpbICAgIDAuMDA0NDQ2XSBPbiBub2Rl
IDAsIHpvbmUgRE1BOiAxIHBhZ2VzIGluIHVuYXZhaWxhYmxlIHJhbmdlcwpbICAgIDAuMDA0NDQ4
XSBPbiBub2RlIDAsIHpvbmUgRE1BOiAxMSBwYWdlcyBpbiB1bmF2YWlsYWJsZSByYW5nZXMKWyAg
ICAwLjAwNDQ3NF0gT24gbm9kZSAwLCB6b25lIERNQTogMTA0IHBhZ2VzIGluIHVuYXZhaWxhYmxl
IHJhbmdlcwpbICAgIDAuMDEyNjk4XSBPbiBub2RlIDAsIHpvbmUgRE1BMzI6IDc4NiBwYWdlcyBp
biB1bmF2YWlsYWJsZSByYW5nZXMKWyAgICAwLjA4Nzg2Nl0gT24gbm9kZSAwLCB6b25lIE5vcm1h
bDogMzIgcGFnZXMgaW4gdW5hdmFpbGFibGUgcmFuZ2VzClsgICAgMC4xNTU4MjFdIEFDUEk6IExB
UElDX05NSSAoYWNwaV9pZFsweGZmXSBkZmwgZGZsIGxpbnRbMHgxXSkKWyAgICAwLjE1NTg4OF0g
SU9BUElDWzBdOiBhcGljX2lkIDAsIHZlcnNpb24gMTcsIGFkZHJlc3MgMHhmZWMwMDAwMCwgR1NJ
IDAtMjMKWyAgICAwLjE1NTg5MV0gQUNQSTogSU5UX1NSQ19PVlIgKGJ1cyAwIGJ1c19pcnEgNSBn
bG9iYWxfaXJxIDUgaGlnaCBsZXZlbCkKWyAgICAwLjE1NTg5NF0gQUNQSTogSU5UX1NSQ19PVlIg
KGJ1cyAwIGJ1c19pcnEgOSBnbG9iYWxfaXJxIDkgaGlnaCBsZXZlbCkKWyAgICAwLjE1NTg5NV0g
QUNQSTogSU5UX1NSQ19PVlIgKGJ1cyAwIGJ1c19pcnEgMTAgZ2xvYmFsX2lycSAxMCBoaWdoIGxl
dmVsKQpbICAgIDAuMTU1ODk2XSBBQ1BJOiBJTlRfU1JDX09WUiAoYnVzIDAgYnVzX2lycSAxMSBn
bG9iYWxfaXJxIDExIGhpZ2ggbGV2ZWwpClsgICAgMC4xNTU4OTldIEFDUEk6IFVzaW5nIEFDUEkg
KE1BRFQpIGZvciBTTVAgY29uZmlndXJhdGlvbiBpbmZvcm1hdGlvbgpbICAgIDAuMTU1OTAzXSBz
bXBib290OiBBbGxvd2luZyAxNiBDUFVzLCAwIGhvdHBsdWcgQ1BVcwpbICAgIDAuMTU1OTI1XSBb
bWVtIDB4YzAwMDAwMDAtMHhmZmZmZmZmZl0gYXZhaWxhYmxlIGZvciBQQ0kgZGV2aWNlcwpbICAg
IDAuMTU1OTI3XSBCb290aW5nIHBhcmF2aXJ0dWFsaXplZCBrZXJuZWwgb24gS1ZNClsgICAgMC4x
NTU5MjldIGNsb2Nrc291cmNlOiByZWZpbmVkLWppZmZpZXM6IG1hc2s6IDB4ZmZmZmZmZmYgbWF4
X2N5Y2xlczogMHhmZmZmZmZmZiwgbWF4X2lkbGVfbnM6IDE5MTA5Njk5NDAzOTE0MTkgbnMKWyAg
ICAwLjE1OTc5Ml0gc2V0dXBfcGVyY3B1OiBOUl9DUFVTOjUxMiBucl9jcHVtYXNrX2JpdHM6NTEy
IG5yX2NwdV9pZHM6MTYgbnJfbm9kZV9pZHM6MQpbICAgIDAuMTYwNTEwXSBwZXJjcHU6IEVtYmVk
ZGVkIDYwIHBhZ2VzL2NwdSBzMjA4ODk2IHI4MTkyIGQyODY3MiB1MjYyMTQ0ClsgICAgMC4xNjA1
MTVdIHBjcHUtYWxsb2M6IHMyMDg4OTYgcjgxOTIgZDI4NjcyIHUyNjIxNDQgYWxsb2M9MSoyMDk3
MTUyClsgICAgMC4xNjA1MTddIHBjcHUtYWxsb2M6IFswXSAwMCAwMSAwMiAwMyAwNCAwNSAwNiAw
NyBbMF0gMDggMDkgMTAgMTEgMTIgMTMgMTQgMTUgClsgICAgMC4xNjA1MzldIGt2bS1ndWVzdDog
c3RlYWx0aW1lOiBjcHUgMCwgbXNyIDdhMWEzMjBjMApbICAgIDAuMTYwNTQzXSBrdm0tZ3Vlc3Q6
IFBWIHNwaW5sb2NrcyBlbmFibGVkClsgICAgMC4xNjA1NDVdIFBWIHFzcGlubG9jayBoYXNoIHRh
YmxlIGVudHJpZXM6IDI1NiAob3JkZXI6IDAsIDQwOTYgYnl0ZXMsIGxpbmVhcikKWyAgICAwLjE2
MDU1MV0gQnVpbHQgMSB6b25lbGlzdHMsIG1vYmlsaXR5IGdyb3VwaW5nIG9uLiAgVG90YWwgcGFn
ZXM6IDc3MzczMzYKWyAgICAwLjE2MDU1Ml0gUG9saWN5IHpvbmU6IE5vcm1hbApbICAgIDAuMTYw
NTU0XSBLZXJuZWwgY29tbWFuZCBsaW5lOiBCT09UX0lNQUdFPS9zeXNsaW51eC92bWxpbnV6LkEg
aW5pdD0vdXNyL2xpYi9zeXN0ZW1kL3N5c3RlbWQgYm9vdD1sb2NhbCByb290d2FpdCBybyBub3Jl
c3VtZSBsb2dsZXZlbD03IGNvbnNvbGU9dHR5MSBjb25zb2xlPXR0eVMwIHNlY3VyaXR5PWFwcGFy
bW9yIHZpcnRpb19uZXQubmFwaV90eD0xIG5taV93YXRjaGRvZz0wIGNzbS5kaXNhYmxlZD0wIGNz
bS5waXBlLmVuYWJsZWQ9MSBjc20uY29uZmlnLmVuYWJsZWQ9MSAsZmlybXdhcmUgZmlybXdhcmVf
Y2xhc3MucGF0aD0vaG9tZS9rdWJlcm5ldGVzL2Jpbi9udmlkaWEvZmlybXdhcmUgbW9kdWxlLnNp
Z19lbmZvcmNlPTAgZG1fdmVyaXR5LmVycm9yX2JlaGF2aW9yPTMgZG1fdmVyaXR5Lm1heF9iaW9z
PS0xIGRtX3Zlcml0eS5kZXZfd2FpdD0xIGk5MTUubW9kZXNldD0xIGNyb3NfZWZpIGNyYXNoa2Vy
bmVsPTBNLThHOjY0TSw4Ry0xMjhHOjI1Nk0sMTI4Ry06NTEyTSB1bmtub3duX25taV9wYW5pYz0x
IHBhbmljX29uX3VucmVjb3ZlcmVkX25taT0xIGNvcy5kaXNhYmxlX3N5c3RlbWRfcm91dGVfbWdt
dCByb290PS9kZXYvZG0tMCAiZG09MSB2cm9vdCBub25lIHJvIDEsMCA0MDc3NTY4IHZlcml0eSBw
YXlsb2FkPVBBUlRVVUlEPUQ3NTE0RUZCLTNCQ0QtOEI0Ny1BNkVBLTBBQjlCNDA1REMwRSBoYXNo
dHJlZT1QQVJUVVVJRD1ENzUxNEVGQi0zQkNELThCNDctQTZFQS0wQUI5QjQwNURDMEUgaGFzaHN0
YXJ0PTQwNzc1NjggYWxnPXNoYTI1NiByb290X2hleGRpZ2VzdD0zZWFhNWJhNjg0MjEwMGQ0M2Vm
ZWEwMGI2NGU0MGE4MzIxZGI3MjE3MjAzYjhiOTAyMzAyMjUwZTgxZTJlMGY3IHNhbHQ9Mjc3YmU5
MDIyNjk1NjUwNDJhN2ViNWFkMDg0MWU3ZDU0YmI4ZDZjZmVhZmVhNTdmZDBlNTFhM2ExMGRlMTQw
NCIKWyAgICAwLjE2MDY4Nl0gVW5rbm93biBrZXJuZWwgY29tbWFuZCBsaW5lIHBhcmFtZXRlcnMg
Im5vcmVzdW1lICxmaXJtd2FyZSBjcm9zX2VmaSBCT09UX0lNQUdFPS9zeXNsaW51eC92bWxpbnV6
LkEgYm9vdD1sb2NhbCBwYW5pY19vbl91bnJlY292ZXJlZF9ubWk9MSBkbT0xIHZyb290IG5vbmUg
cm8gMSwwIDQwNzc1NjggdmVyaXR5IHBheWxvYWQ9UEFSVFVVSUQ9RDc1MTRFRkItM0JDRC04QjQ3
LUE2RUEtMEFCOUI0MDVEQzBFIGhhc2h0cmVlPVBBUlRVVUlEPUQ3NTE0RUZCLTNCQ0QtOEI0Ny1B
NkVBLTBBQjlCNDA1REMwRSBoYXNoc3RhcnQ9NDA3NzU2OCBhbGc9c2hhMjU2IHJvb3RfaGV4ZGln
ZXN0PTNlYWE1YmE2ODQyMTAwZDQzZWZlYTAwYjY0ZTQwYTgzMjFkYjcyMTcyMDNiOGI5MDIzMDIy
NTBlODFlMmUwZjcgc2FsdD0yNzdiZTkwMjI2OTU2NTA0MmE3ZWI1YWQwODQxZTdkNTRiYjhkNmNm
ZWFmZWE1N2ZkMGU1MWEzYTEwZGUxNDA0Iiwgd2lsbCBiZSBwYXNzZWQgdG8gdXNlciBzcGFjZS4K
WyAgICAwLjE2NDEzM10gRGVudHJ5IGNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNDE5NDMwNCAo
b3JkZXI6IDEzLCAzMzU1NDQzMiBieXRlcywgbGluZWFyKQpbICAgIDAuMTY1NzEyXSBJbm9kZS1j
YWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDIwOTcxNTIgKG9yZGVyOiAxMiwgMTY3NzcyMTYgYnl0
ZXMsIGxpbmVhcikKWyAgICAwLjE2NTc3M10gbWVtIGF1dG8taW5pdDogc3RhY2s6YWxsKHplcm8p
LCBoZWFwIGFsbG9jOm9mZiwgaGVhcCBmcmVlOm9mZgpbICAgIDAuMjE2NTc4XSBNZW1vcnk6IDMw
NTAzMjE2Sy8zMTQ1MzU0NEsgYXZhaWxhYmxlICgxNDM0OEsga2VybmVsIGNvZGUsIDI0NTVLIHJ3
ZGF0YSwgNjAzNksgcm9kYXRhLCAyMTY4SyBpbml0LCA0NjkySyBic3MsIDk1MDA2OEsgcmVzZXJ2
ZWQsIDBLIGNtYS1yZXNlcnZlZCkKWyAgICAwLjIxNzI3NF0gU0xVQjogSFdhbGlnbj02NCwgT3Jk
ZXI9MC0zLCBNaW5PYmplY3RzPTAsIENQVXM9MTYsIE5vZGVzPTEKWyAgICAwLjIxNzMyMl0gZnRy
YWNlOiBhbGxvY2F0aW5nIDM5OTc1IGVudHJpZXMgaW4gMTU3IHBhZ2VzClsgICAgMC4yMjcyMDFd
IGZ0cmFjZTogYWxsb2NhdGVkIDE1NyBwYWdlcyB3aXRoIDUgZ3JvdXBzClsgICAgMC4yMjc1MjBd
IHJjdTogSGllcmFyY2hpY2FsIFJDVSBpbXBsZW1lbnRhdGlvbi4KWyAgICAwLjIyNzUyM10gcmN1
OiAJUkNVIHJlc3RyaWN0aW5nIENQVXMgZnJvbSBOUl9DUFVTPTUxMiB0byBucl9jcHVfaWRzPTE2
LgpbICAgIDAuMjI3NTI0XSAJUnVkZSB2YXJpYW50IG9mIFRhc2tzIFJDVSBlbmFibGVkLgpbICAg
IDAuMjI3NTI1XSAJVHJhY2luZyB2YXJpYW50IG9mIFRhc2tzIFJDVSBlbmFibGVkLgpbICAgIDAu
MjI3NTI2XSByY3U6IFJDVSBjYWxjdWxhdGVkIHZhbHVlIG9mIHNjaGVkdWxlci1lbmxpc3RtZW50
IGRlbGF5IGlzIDEwMCBqaWZmaWVzLgpbICAgIDAuMjI3NTI3XSByY3U6IEFkanVzdGluZyBnZW9t
ZXRyeSBmb3IgcmN1X2Zhbm91dF9sZWFmPTE2LCBucl9jcHVfaWRzPTE2ClsgICAgMC4yMzA2NDFd
IE5SX0lSUVM6IDMzMDI0LCBucl9pcnFzOiA1NTIsIHByZWFsbG9jYXRlZCBpcnFzOiAxNgpbICAg
IDAuMjMwODg4XSByYW5kb206IGNybmcgaW5pdCBkb25lClsgICAgMC4yMzA5MjBdIENvbnNvbGU6
IGNvbG91ciBkdW1teSBkZXZpY2UgODB4MjUKWyAgICAwLjIzMTEwMV0gcHJpbnRrOiBjb25zb2xl
IFt0dHkxXSBlbmFibGVkClsgICAgMC40MTY2MDBdIHByaW50azogY29uc29sZSBbdHR5UzBdIGVu
YWJsZWQKWyAgICAwLjQxNzMzOF0gQUNQSTogQ29yZSByZXZpc2lvbiAyMDIxMDczMApbICAgIDAu
NDE4MjQyXSBBUElDOiBTd2l0Y2ggdG8gc3ltbWV0cmljIEkvTyBtb2RlIHNldHVwClsgICAgMC40
MTk1NTBdIHgyYXBpYyBlbmFibGVkClsgICAgMC40MjQxMTFdIFN3aXRjaGVkIEFQSUMgcm91dGlu
ZyB0byBwaHlzaWNhbCB4MmFwaWMuClsgICAgMC40MzA1NTZdIC4uVElNRVI6IHZlY3Rvcj0weDMw
IGFwaWMxPTAgcGluMT0wIGFwaWMyPS0xIHBpbjI9LTEKWyAgICAwLjQzMjMwMF0gY2xvY2tzb3Vy
Y2U6IHRzYy1lYXJseTogbWFzazogMHhmZmZmZmZmZmZmZmZmZmZmIG1heF9jeWNsZXM6IDB4MjA2
ZWIyMTExZjUsIG1heF9pZGxlX25zOiA0NDA3OTUyMjI0NzEgbnMKWyAgICAwLjQzNDUyMF0gQ2Fs
aWJyYXRpbmcgZGVsYXkgbG9vcCAoc2tpcHBlZCkgcHJlc2V0IHZhbHVlLi4gNDQ5OS45OSBCb2dv
TUlQUyAobHBqPTIyNDk5OTgpClsgICAgMC40MzY1NDhdIHg4Ni9jcHU6IFVzZXIgTW9kZSBJbnN0
cnVjdGlvbiBQcmV2ZW50aW9uIChVTUlQKSBhY3RpdmF0ZWQKWyAgICAwLjQzNzczMF0gTGFzdCBs
ZXZlbCBpVExCIGVudHJpZXM6IDRLQiAxMDI0LCAyTUIgMTAyNCwgNE1CIDUxMgpbICAgIDAuNDM4
NTIwXSBMYXN0IGxldmVsIGRUTEIgZW50cmllczogNEtCIDIwNDgsIDJNQiAyMDQ4LCA0TUIgMTAy
NCwgMUdCIDAKWyAgICAwLjQzOTUyM10gU3BlY3RyZSBWMSA6IE1pdGlnYXRpb246IHVzZXJjb3B5
L3N3YXBncyBiYXJyaWVycyBhbmQgX191c2VyIHBvaW50ZXIgc2FuaXRpemF0aW9uClsgICAgMC40
NDA1MjVdIFNwZWN0cmUgVjIgOiBNaXRpZ2F0aW9uOiBSZXRwb2xpbmVzClsgICAgMC40NDE1MjBd
IFNwZWN0cmUgVjIgOiBTcGVjdHJlIHYyIC8gU3BlY3RyZVJTQiBtaXRpZ2F0aW9uOiBGaWxsaW5n
IFJTQiBvbiBjb250ZXh0IHN3aXRjaApbICAgIDAuNDQyNTI0XSBTcGVjdHJlIFYyIDogU3BlY3Ry
ZSB2MiAvIFNwZWN0cmVSU0IgOiBGaWxsaW5nIFJTQiBvbiBWTUVYSVQKWyAgICAwLjQ0MzUyMV0g
U3BlY3RyZSBWMiA6IEVuYWJsaW5nIFNwZWN1bGF0aW9uIEJhcnJpZXIgZm9yIGZpcm13YXJlIGNh
bGxzClsgICAgMC40NDQ1MjFdIFJFVEJsZWVkOiBNaXRpZ2F0aW9uOiB1bnRyYWluZWQgcmV0dXJu
IHRodW5rClsgICAgMC40NDU1MjRdIFNwZWN0cmUgVjIgOiBtaXRpZ2F0aW9uOiBFbmFibGluZyBj
b25kaXRpb25hbCBJbmRpcmVjdCBCcmFuY2ggUHJlZGljdGlvbiBCYXJyaWVyClsgICAgMC40NDY1
MjBdIFNwZWN0cmUgVjIgOiBTZWxlY3RpbmcgU1RJQlAgYWx3YXlzLW9uIG1vZGUgdG8gY29tcGxl
bWVudCByZXRibGVlZCBtaXRpZ2F0aW9uClsgICAgMC40NDc1MjBdIFNwZWN0cmUgVjIgOiBVc2Vy
IHNwYWNlOiBNaXRpZ2F0aW9uOiBTVElCUCBhbHdheXMtb24gcHJvdGVjdGlvbgpbICAgIDAuNDQ4
NTM0XSBTcGVjdWxhdGl2ZSBTdG9yZSBCeXBhc3M6IE1pdGlnYXRpb246IFNwZWN1bGF0aXZlIFN0
b3JlIEJ5cGFzcyBkaXNhYmxlZCB2aWEgcHJjdGwgYW5kIHNlY2NvbXAKWyAgICAwLjQ0OTUyM10g
U3BlY3VsYXRpdmUgUmV0dXJuIFN0YWNrIE92ZXJmbG93OiBNaXRpZ2F0aW9uOiBzYWZlIFJFVApb
ICAgIDAuNDUwNTQyXSB4ODYvZnB1OiBTdXBwb3J0aW5nIFhTQVZFIGZlYXR1cmUgMHgwMDE6ICd4
ODcgZmxvYXRpbmcgcG9pbnQgcmVnaXN0ZXJzJwpbICAgIDAuNDUxNTIwXSB4ODYvZnB1OiBTdXBw
b3J0aW5nIFhTQVZFIGZlYXR1cmUgMHgwMDI6ICdTU0UgcmVnaXN0ZXJzJwpbICAgIDAuNDUyNTIw
XSB4ODYvZnB1OiBTdXBwb3J0aW5nIFhTQVZFIGZlYXR1cmUgMHgwMDQ6ICdBVlggcmVnaXN0ZXJz
JwpbICAgIDAuNDUzNTIyXSB4ODYvZnB1OiB4c3RhdGVfb2Zmc2V0WzJdOiAgNTc2LCB4c3RhdGVf
c2l6ZXNbMl06ICAyNTYKWyAgICAwLjQ1NDUyNF0geDg2L2ZwdTogRW5hYmxlZCB4c3RhdGUgZmVh
dHVyZXMgMHg3LCBjb250ZXh0IHNpemUgaXMgODMyIGJ5dGVzLCB1c2luZyAnc3RhbmRhcmQnIGZv
cm1hdC4KWyAgICAwLjQ2NDQyNF0gRnJlZWluZyBTTVAgYWx0ZXJuYXRpdmVzIG1lbW9yeTogNDhL
ClsgICAgMC40NjQ1MjFdIHBpZF9tYXg6IGRlZmF1bHQ6IDMyNzY4IG1pbmltdW06IDMwMQpbICAg
IDAuNDcyOTMxXSBMU006IFNlY3VyaXR5IEZyYW1ld29yayBpbml0aWFsaXppbmcKWyAgICAwLjQ3
MzUzNl0gWWFtYTogYmVjb21pbmcgbWluZGZ1bC4KWyAgICAwLjQ3NDUyN10gTG9hZFBpbjogcmVh
ZHkgdG8gcGluIChjdXJyZW50bHkgZW5mb3JjaW5nKQpbICAgIDAuNDc1NTYxXSBBcHBBcm1vcjog
QXBwQXJtb3IgaW5pdGlhbGl6ZWQKWyAgICAwLjQ3NjUyMl0gTFNNIHN1cHBvcnQgZm9yIGVCUEYg
YWN0aXZlClsgICAgMC40Nzc1OTddIE1vdW50LWNhY2hlIGhhc2ggdGFibGUgZW50cmllczogNjU1
MzYgKG9yZGVyOiA3LCA1MjQyODggYnl0ZXMsIGxpbmVhcikKWyAgICAwLjQ3ODU0OV0gTW91bnRw
b2ludC1jYWNoZSBoYXNoIHRhYmxlIGVudHJpZXM6IDY1NTM2IChvcmRlcjogNywgNTI0Mjg4IGJ5
dGVzLCBsaW5lYXIpClsgICAgMC42ODQxNjRdIHNtcGJvb3Q6IENQVTA6IEFNRCBFUFlDIDdCMTIg
KGZhbWlseTogMHgxNywgbW9kZWw6IDB4MzEsIHN0ZXBwaW5nOiAweDApClsgICAgMC42ODQ2ODhd
IFBlcmZvcm1hbmNlIEV2ZW50czogQU1EIFBNVSBkcml2ZXIuClsgICAgMC42ODU1MjNdIC4uLiB2
ZXJzaW9uOiAgICAgICAgICAgICAgICAwClsgICAgMC42ODY1MjBdIC4uLiBiaXQgd2lkdGg6ICAg
ICAgICAgICAgICA0OApbICAgIDAuNjg3NTIxXSAuLi4gZ2VuZXJpYyByZWdpc3RlcnM6ICAgICAg
NApbICAgIDAuNjg4NTIwXSAuLi4gdmFsdWUgbWFzazogICAgICAgICAgICAgMDAwMGZmZmZmZmZm
ZmZmZgpbICAgIDAuNjg5NTIwXSAuLi4gbWF4IHBlcmlvZDogICAgICAgICAgICAgMDAwMDdmZmZm
ZmZmZmZmZgpbICAgIDAuNjkwNTIwXSAuLi4gZml4ZWQtcHVycG9zZSBldmVudHM6ICAgMApbICAg
IDAuNjkxMjU3XSAuLi4gZXZlbnQgbWFzazogICAgICAgICAgICAgMDAwMDAwMDAwMDAwMDAwZgpb
ICAgIDAuNjkxNjE1XSBzaWduYWw6IG1heCBzaWdmcmFtZSBzaXplOiAxNzc2ClsgICAgMC42OTI1
NjRdIHJjdTogSGllcmFyY2hpY2FsIFNSQ1UgaW1wbGVtZW50YXRpb24uClsgICAgMC42OTQwNTJd
IHNtcDogQnJpbmdpbmcgdXAgc2Vjb25kYXJ5IENQVXMgLi4uClsgICAgMC42OTQ2MTJdIHg4Njog
Qm9vdGluZyBTTVAgY29uZmlndXJhdGlvbjoKWyAgICAwLjY5NTUyM10gLi4uLiBub2RlICAjMCwg
Q1BVczogICAgICAgICMxClsgICAgMC4xOTk2NTJdIGt2bS1jbG9jazogY3B1IDEsIG1zciAzZDgw
MDAwNDEsIHNlY29uZGFyeSBjcHUgY2xvY2sKWyAgICAwLjY5NzMyN10ga3ZtLWd1ZXN0OiBzdGVh
bHRpbWU6IGNwdSAxLCBtc3IgN2ExYTcyMGMwClsgICAgMC42OTk2MThdICAgIzIKWyAgICAwLjE5
OTY1Ml0ga3ZtLWNsb2NrOiBjcHUgMiwgbXNyIDNkODAwMDA4MSwgc2Vjb25kYXJ5IGNwdSBjbG9j
awpbICAgIDAuNzAxMDQ3XSBrdm0tZ3Vlc3Q6IHN0ZWFsdGltZTogY3B1IDIsIG1zciA3YTFhYjIw
YzAKWyAgICAwLjcwMjY0N10gICAjMwpbICAgIDAuMTk5NjUyXSBrdm0tY2xvY2s6IGNwdSAzLCBt
c3IgM2Q4MDAwMGMxLCBzZWNvbmRhcnkgY3B1IGNsb2NrClsgICAgMC43MDQzNzRdIGt2bS1ndWVz
dDogc3RlYWx0aW1lOiBjcHUgMywgbXNyIDdhMWFmMjBjMApbICAgIDAuNzA1NjUxXSAgICM0Clsg
ICAgMC4xOTk2NTJdIGt2bS1jbG9jazogY3B1IDQsIG1zciAzZDgwMDAxMDEsIHNlY29uZGFyeSBj
cHUgY2xvY2sKWyAgICAwLjcwNzM0OV0ga3ZtLWd1ZXN0OiBzdGVhbHRpbWU6IGNwdSA0LCBtc3Ig
N2ExYjMyMGMwClsgICAgMC43MDk2MDhdICAgIzUKWyAgICAwLjE5OTY1Ml0ga3ZtLWNsb2NrOiBj
cHUgNSwgbXNyIDNkODAwMDE0MSwgc2Vjb25kYXJ5IGNwdSBjbG9jawpbICAgIDAuNzEwNzY1XSBr
dm0tZ3Vlc3Q6IHN0ZWFsdGltZTogY3B1IDUsIG1zciA3YTFiNzIwYzAKWyAgICAwLjcxMjY2N10g
ICAjNgpbICAgIDAuMTk5NjUyXSBrdm0tY2xvY2s6IGNwdSA2LCBtc3IgM2Q4MDAwMTgxLCBzZWNv
bmRhcnkgY3B1IGNsb2NrClsgICAgMC43MTQwODddIGt2bS1ndWVzdDogc3RlYWx0aW1lOiBjcHUg
NiwgbXNyIDdhMWJiMjBjMApbICAgIDAuNzE2NTI1XSAgICM3ClsgICAgMC4xOTk2NTJdIGt2bS1j
bG9jazogY3B1IDcsIG1zciAzZDgwMDAxYzEsIHNlY29uZGFyeSBjcHUgY2xvY2sKWyAgICAwLjcx
NzYyMl0ga3ZtLWd1ZXN0OiBzdGVhbHRpbWU6IGNwdSA3LCBtc3IgN2ExYmYyMGMwClsgICAgMC43
MTk2ODNdICAgIzgKWyAgICAwLjE5OTY1Ml0ga3ZtLWNsb2NrOiBjcHUgOCwgbXNyIDNkODAwMDIw
MSwgc2Vjb25kYXJ5IGNwdSBjbG9jawpbICAgIDAuNzIwOTMzXSBrdm0tZ3Vlc3Q6IHN0ZWFsdGlt
ZTogY3B1IDgsIG1zciA3YTFjMzIwYzAKWyAgICAwLjcyMzUyMl0gU3BlY3RyZSBWMiA6IFVwZGF0
ZSB1c2VyIHNwYWNlIFNNVCBtaXRpZ2F0aW9uOiBTVElCUCBhbHdheXMtb24KWyAgICAwLjcyNDcw
N10gICAjOQpbICAgIDAuMTk5NjUyXSBrdm0tY2xvY2s6IGNwdSA5LCBtc3IgM2Q4MDAwMjQxLCBz
ZWNvbmRhcnkgY3B1IGNsb2NrClsgICAgMC43MjU5MDFdIGt2bS1ndWVzdDogc3RlYWx0aW1lOiBj
cHUgOSwgbXNyIDdhMWM3MjBjMApbICAgIDAuNzI3NjU4XSAgIzEwClsgICAgMC4xOTk2NTJdIGt2
bS1jbG9jazogY3B1IDEwLCBtc3IgM2Q4MDAwMjgxLCBzZWNvbmRhcnkgY3B1IGNsb2NrClsgICAg
MC43MjkzNzFdIGt2bS1ndWVzdDogc3RlYWx0aW1lOiBjcHUgMTAsIG1zciA3YTFjYjIwYzAKWyAg
ICAwLjczMTc3Ml0gICMxMQpbICAgIDAuMTk5NjUyXSBrdm0tY2xvY2s6IGNwdSAxMSwgbXNyIDNk
ODAwMDJjMSwgc2Vjb25kYXJ5IGNwdSBjbG9jawpbICAgIDAuNzMyNzkwXSBrdm0tZ3Vlc3Q6IHN0
ZWFsdGltZTogY3B1IDExLCBtc3IgN2ExY2YyMGMwClsgICAgMC43MzQ2NzRdICAjMTIKWyAgICAw
LjE5OTY1Ml0ga3ZtLWNsb2NrOiBjcHUgMTIsIG1zciAzZDgwMDAzMDEsIHNlY29uZGFyeSBjcHUg
Y2xvY2sKWyAgICAwLjczNjYyMV0ga3ZtLWd1ZXN0OiBzdGVhbHRpbWU6IGNwdSAxMiwgbXNyIDdh
MWQzMjBjMApbICAgIDAuNzM4NjYzXSAgIzEzClsgICAgMC4xOTk2NTJdIGt2bS1jbG9jazogY3B1
IDEzLCBtc3IgM2Q4MDAwMzQxLCBzZWNvbmRhcnkgY3B1IGNsb2NrClsgICAgMC43NDA1NDldIGt2
bS1ndWVzdDogc3RlYWx0aW1lOiBjcHUgMTMsIG1zciA3YTFkNzIwYzAKWyAgICAwLjc0MjY0OV0g
ICMxNApbICAgIDAuMTk5NjUyXSBrdm0tY2xvY2s6IGNwdSAxNCwgbXNyIDNkODAwMDM4MSwgc2Vj
b25kYXJ5IGNwdSBjbG9jawpbICAgIDAuNzQzOTMzXSBrdm0tZ3Vlc3Q6IHN0ZWFsdGltZTogY3B1
IDE0LCBtc3IgN2ExZGIyMGMwClsgICAgMC43NDU2MjRdICAjMTUKWyAgICAwLjE5OTY1Ml0ga3Zt
LWNsb2NrOiBjcHUgMTUsIG1zciAzZDgwMDAzYzEsIHNlY29uZGFyeSBjcHUgY2xvY2sKWyAgICAw
Ljc0NzEyN10ga3ZtLWd1ZXN0OiBzdGVhbHRpbWU6IGNwdSAxNSwgbXNyIDdhMWRmMjBjMApbICAg
IDAuNzQ4NTI4XSBzbXA6IEJyb3VnaHQgdXAgMSBub2RlLCAxNiBDUFVzClsgICAgMC43NDk1MjRd
IHNtcGJvb3Q6IE1heCBsb2dpY2FsIHBhY2thZ2VzOiAxClsgICAgMC43NTA1MjJdIHNtcGJvb3Q6
IFRvdGFsIG9mIDE2IHByb2Nlc3NvcnMgYWN0aXZhdGVkICg3MTk5OS45MyBCb2dvTUlQUykKWyAg
ICAwLjc1Mzk2Ml0gZGV2dG1wZnM6IGluaXRpYWxpemVkClsgICAgMC43NTQ3MDhdIEFDUEk6IFBN
OiBSZWdpc3RlcmluZyBBQ1BJIE5WUyByZWdpb24gW21lbSAweGJmYjdmMDAwLTB4YmZiZmVmZmZd
ICg1MjQyODggYnl0ZXMpClsgICAgMC43NTY1NzNdIGNsb2Nrc291cmNlOiBqaWZmaWVzOiBtYXNr
OiAweGZmZmZmZmZmIG1heF9jeWNsZXM6IDB4ZmZmZmZmZmYsIG1heF9pZGxlX25zOiAxOTExMjYw
NDQ2Mjc1MDAwIG5zClsgICAgMC43NTc1MjRdIGZ1dGV4IGhhc2ggdGFibGUgZW50cmllczogNDA5
NiAob3JkZXI6IDYsIDI2MjE0NCBieXRlcywgbGluZWFyKQpbICAgIDAuNzU5NTIwXSBQTTogUlRD
IHRpbWU6IDE2OjE1OjE2LCBkYXRlOiAyMDI0LTA0LTA4ClsgICAgMC43NjA5ODVdIE5FVDogUmVn
aXN0ZXJlZCBQRl9ORVRMSU5LL1BGX1JPVVRFIHByb3RvY29sIGZhbWlseQpbICAgIDAuNzYxNjA0
XSBETUE6IHByZWFsbG9jYXRlZCA0MDk2IEtpQiBHRlBfS0VSTkVMIHBvb2wgZm9yIGF0b21pYyBh
bGxvY2F0aW9ucwpbICAgIDAuNzYzNTI3XSBETUE6IHByZWFsbG9jYXRlZCA0MDk2IEtpQiBHRlBf
S0VSTkVMfEdGUF9ETUEgcG9vbCBmb3IgYXRvbWljIGFsbG9jYXRpb25zClsgICAgMC43NjQ1Mjld
IERNQTogcHJlYWxsb2NhdGVkIDQwOTYgS2lCIEdGUF9LRVJORUx8R0ZQX0RNQTMyIHBvb2wgZm9y
IGF0b21pYyBhbGxvY2F0aW9ucwpbICAgIDAuNzY2NTMwXSBhdWRpdDogaW5pdGlhbGl6aW5nIG5l
dGxpbmsgc3Vic3lzIChkaXNhYmxlZCkKWyAgICAwLjc2NzU2MF0gYXVkaXQ6IHR5cGU9MjAwMCBh
dWRpdCgxNzEyNTkyOTE2LjM5NToxKTogc3RhdGU9aW5pdGlhbGl6ZWQgYXVkaXRfZW5hYmxlZD0w
IHJlcz0xClsgICAgMC43Njc2NDhdIHRoZXJtYWxfc3lzOiBSZWdpc3RlcmVkIHRoZXJtYWwgZ292
ZXJub3IgJ3N0ZXBfd2lzZScKWyAgICAwLjc2ODUyM10gdGhlcm1hbF9zeXM6IFJlZ2lzdGVyZWQg
dGhlcm1hbCBnb3Zlcm5vciAndXNlcl9zcGFjZScKWyAgICAwLjc3MDYyNV0gY3B1aWRsZTogdXNp
bmcgZ292ZXJub3IgbGFkZGVyClsgICAgMC43NzI1MjhdIGNwdWlkbGU6IHVzaW5nIGdvdmVybm9y
IG1lbnUKWyAgICAwLjc3NDU4NF0gQUNQSTogYnVzIHR5cGUgUENJIHJlZ2lzdGVyZWQKWyAgICAw
Ljc3NTIzNF0gYWNwaXBocDogQUNQSSBIb3QgUGx1ZyBQQ0kgQ29udHJvbGxlciBEcml2ZXIgdmVy
c2lvbjogMC41ClsgICAgMC43NzY1MjFdIFBDSTogVXNpbmcgY29uZmlndXJhdGlvbiB0eXBlIDEg
Zm9yIGJhc2UgYWNjZXNzClsgICAgMC43NzcyODBdIFBDSTogVXNpbmcgY29uZmlndXJhdGlvbiB0
eXBlIDEgZm9yIGV4dGVuZGVkIGFjY2VzcwpbICAgIDAuNzc5MzEzXSBrcHJvYmVzOiBrcHJvYmUg
anVtcC1vcHRpbWl6YXRpb24gaXMgZW5hYmxlZC4gQWxsIGtwcm9iZXMgYXJlIG9wdGltaXplZCBp
ZiBwb3NzaWJsZS4KWyAgICAwLjc4MTczNl0gSHVnZVRMQiByZWdpc3RlcmVkIDEuMDAgR2lCIHBh
Z2Ugc2l6ZSwgcHJlLWFsbG9jYXRlZCAwIHBhZ2VzClsgICAgMC43ODI1MjVdIEh1Z2VUTEIgcmVn
aXN0ZXJlZCAyLjAwIE1pQiBwYWdlIHNpemUsIHByZS1hbGxvY2F0ZWQgMCBwYWdlcwpbICAgIDAu
Nzg2NzYzXSBBQ1BJOiBBZGRlZCBfT1NJKE1vZHVsZSBEZXZpY2UpClsgICAgMC43ODc1MjZdIEFD
UEk6IEFkZGVkIF9PU0koUHJvY2Vzc29yIERldmljZSkKWyAgICAwLjc4ODUyMV0gQUNQSTogQWRk
ZWQgX09TSSgzLjAgX1NDUCBFeHRlbnNpb25zKQpbICAgIDAuNzg5NTIxXSBBQ1BJOiBBZGRlZCBf
T1NJKFByb2Nlc3NvciBBZ2dyZWdhdG9yIERldmljZSkKWyAgICAwLjc5MDUyNV0gQUNQSTogQWRk
ZWQgX09TSShMaW51eC1EZWxsLVZpZGVvKQpbICAgIDAuNzkxMTkyXSBBQ1BJOiBBZGRlZCBfT1NJ
KExpbnV4LUxlbm92by1OVi1IRE1JLUF1ZGlvKQpbICAgIDAuNzkxNTIzXSBBQ1BJOiBBZGRlZCBf
T1NJKExpbnV4LUhQSS1IeWJyaWQtR3JhcGhpY3MpClsgICAgMC43OTQxMTJdIEFDUEk6IDMgQUNQ
SSBBTUwgdGFibGVzIHN1Y2Nlc3NmdWxseSBhY3F1aXJlZCBhbmQgbG9hZGVkClsgICAgMC43OTY5
ODRdIEFDUEk6IEludGVycHJldGVyIGVuYWJsZWQKWyAgICAwLjc5NzUzOV0gQUNQSTogUE06IChz
dXBwb3J0cyBTMCBTMyBTNSkKWyAgICAwLjc5ODUyNl0gQUNQSTogVXNpbmcgSU9BUElDIGZvciBp
bnRlcnJ1cHQgcm91dGluZwpbICAgIDAuNzk5NTQ1XSBQQ0k6IFVzaW5nIGhvc3QgYnJpZGdlIHdp
bmRvd3MgZnJvbSBBQ1BJOyBpZiBuZWNlc3NhcnksIHVzZSAicGNpPW5vY3JzIiBhbmQgcmVwb3J0
IGEgYnVnClsgICAgMC44MDA3NTRdIEFDUEk6IEVuYWJsZWQgMTYgR1BFcyBpbiBibG9jayAwMCB0
byAwRgpbICAgIDAuODA0NzIxXSBBQ1BJOiBQQ0kgUm9vdCBCcmlkZ2UgW1BDSTBdIChkb21haW4g
MDAwMCBbYnVzIDAwLWZmXSkKWyAgICAwLjgwNTUyNV0gYWNwaSBQTlAwQTAzOjAwOiBfT1NDOiBP
UyBzdXBwb3J0cyBbRXh0ZW5kZWRDb25maWcgQVNQTSBDbG9ja1BNIFNlZ21lbnRzIE1TSSBIUFgt
VHlwZTNdClsgICAgMC44MDgwMTFdIFBDSSBob3N0IGJyaWRnZSB0byBidXMgMDAwMDowMApbICAg
IDAuODA4NTIxXSBwY2lfYnVzIDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFtpbyAgMHgwMDAw
LTB4MGNmNyB3aW5kb3ddClsgICAgMC44MDk1MjFdIHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMg
cmVzb3VyY2UgW2lvICAweDBkMDAtMHhmZmZmIHdpbmRvd10KWyAgICAwLjgxMDUyMV0gcGNpX2J1
cyAwMDAwOjAwOiByb290IGJ1cyByZXNvdXJjZSBbbWVtIDB4MDAwYTAwMDAtMHgwMDBiZmZmZiB3
aW5kb3ddClsgICAgMC44MTE1MjFdIHBjaV9idXMgMDAwMDowMDogcm9vdCBidXMgcmVzb3VyY2Ug
W21lbSAweGMwMDAwMDAwLTB4ZmViZmVmZmYgd2luZG93XQpbICAgIDAuODEzNTIxXSBwY2lfYnVz
IDAwMDA6MDA6IHJvb3QgYnVzIHJlc291cmNlIFtidXMgMDAtZmZdClsgICAgMC44MTQ3NDZdIHBj
aSAwMDAwOjAwOjAwLjA6IFs4MDg2OjEyMzddIHR5cGUgMDAgY2xhc3MgMHgwNjAwMDAKWyAgICAw
LjgxOTg2MV0gcGNpIDAwMDA6MDA6MDEuMDogWzgwODY6NzExMF0gdHlwZSAwMCBjbGFzcyAweDA2
MDEwMApbICAgIDAuODM5ODQ4XSBwY2kgMDAwMDowMDowMS4zOiBbODA4Njo3MTEzXSB0eXBlIDAw
IGNsYXNzIDB4MDY4MDAwClsgICAgMC44NTg2NDZdIHBjaSAwMDAwOjAwOjAxLjM6IHF1aXJrOiBb
aW8gIDB4YjAwMC0weGIwM2ZdIGNsYWltZWQgYnkgUElJWDQgQUNQSQpbICAgIDAuODYwOTMyXSBw
Y2kgMDAwMDowMDowMy4wOiBbMWFmNDoxMDA0XSB0eXBlIDAwIGNsYXNzIDB4MDAwMDAwClsgICAg
MC44Njg1MjZdIHBjaSAwMDAwOjAwOjAzLjA6IHJlZyAweDEwOiBbaW8gIDB4YzA0MC0weGMwN2Zd
ClsgICAgMC44NzM1MjddIHBjaSAwMDAwOjAwOjAzLjA6IHJlZyAweDE0OiBbbWVtIDB4YzAwMDIw
MDAtMHhjMDAwMjA3Zl0KWyAgICAwLjg4Njk5NV0gcGNpIDAwMDA6MDA6MDQuMDogWzFhZjQ6MTAw
MF0gdHlwZSAwMCBjbGFzcyAweDAyMDAwMApbICAgIDAuODk0NTI0XSBwY2kgMDAwMDowMDowNC4w
OiByZWcgMHgxMDogW2lvICAweGMwMDAtMHhjMDNmXQpbICAgIDAuOTAwNTI4XSBwY2kgMDAwMDow
MDowNC4wOiByZWcgMHgxNDogW21lbSAweGMwMDAwMDAwLTB4YzAwMDAzZmZdClsgICAgMC45MTcw
NDhdIHBjaSAwMDAwOjAwOjA1LjA6IFsxYWY0OjEwMDJdIHR5cGUgMDAgY2xhc3MgMHgwMGZmMDAK
WyAgICAwLjkyNTUyNl0gcGNpIDAwMDA6MDA6MDUuMDogcmVnIDB4MTA6IFtpbyAgMHhjMGEwLTB4
YzBiZl0KWyAgICAwLjkzMTUyNl0gcGNpIDAwMDA6MDA6MDUuMDogcmVnIDB4MTQ6IFttZW0gMHhj
MDAwMTAwMC0weGMwMDAxMDdmXQpbICAgIDAuOTQ3NjE5XSBwY2kgMDAwMDowMDowNi4wOiBbMWFm
NDoxMDA1XSB0eXBlIDAwIGNsYXNzIDB4MDBmZjAwClsgICAgMC45NTQ1MjddIHBjaSAwMDAwOjAw
OjA2LjA6IHJlZyAweDEwOiBbaW8gIDB4YzA4MC0weGMwOWZdClsgICAgMC45NjA1MjRdIHBjaSAw
MDAwOjAwOjA2LjA6IHJlZyAweDE0OiBbbWVtIDB4YzAwMDMwMDAtMHhjMDAwMzAzZl0KWyAgICAw
Ljk3NTQxMl0gQUNQSTogUENJOiBJbnRlcnJ1cHQgbGluayBMTktBIGNvbmZpZ3VyZWQgZm9yIElS
USAxMApbICAgIDAuOTc3NjA4XSBBQ1BJOiBQQ0k6IEludGVycnVwdCBsaW5rIExOS0IgY29uZmln
dXJlZCBmb3IgSVJRIDEwClsgICAgMC45ODA2MDNdIEFDUEk6IFBDSTogSW50ZXJydXB0IGxpbmsg
TE5LQyBjb25maWd1cmVkIGZvciBJUlEgMTEKWyAgICAwLjk4MzYzOF0gQUNQSTogUENJOiBJbnRl
cnJ1cHQgbGluayBMTktEIGNvbmZpZ3VyZWQgZm9yIElSUSAxMQpbICAgIDAuOTg2NTY2XSBBQ1BJ
OiBQQ0k6IEludGVycnVwdCBsaW5rIExOS1MgY29uZmlndXJlZCBmb3IgSVJRIDkKWyAgICAwLjk4
ODk0NF0gaW9tbXU6IERlZmF1bHQgZG9tYWluIHR5cGU6IFRyYW5zbGF0ZWQgClsgICAgMC45ODk1
MjFdIGlvbW11OiBETUEgZG9tYWluIFRMQiBpbnZhbGlkYXRpb24gcG9saWN5OiBsYXp5IG1vZGUg
ClsgICAgMC45OTA4MjJdIFNDU0kgc3Vic3lzdGVtIGluaXRpYWxpemVkClsgICAgMC45OTE1Njld
IGxpYmF0YSB2ZXJzaW9uIDMuMDAgbG9hZGVkLgpbICAgIDAuOTkxNTY5XSBwcHNfY29yZTogTGlu
dXhQUFMgQVBJIHZlci4gMSByZWdpc3RlcmVkClsgICAgMC45OTM1MjFdIHBwc19jb3JlOiBTb2Z0
d2FyZSB2ZXIuIDUuMy42IC0gQ29weXJpZ2h0IDIwMDUtMjAwNyBSb2RvbGZvIEdpb21ldHRpIDxn
aW9tZXR0aUBsaW51eC5pdD4KWyAgICAwLjk5NDUyN10gUFRQIGNsb2NrIHN1cHBvcnQgcmVnaXN0
ZXJlZApbICAgIDAuOTk1NTc4XSBSZWdpc3RlcmVkIGVmaXZhcnMgb3BlcmF0aW9ucwpbICAgIDAu
OTk2NjU0XSBQQ0k6IFVzaW5nIEFDUEkgZm9yIElSUSByb3V0aW5nClsgICAgMC45OTc1MjJdIFBD
STogcGNpX2NhY2hlX2xpbmVfc2l6ZSBzZXQgdG8gNjQgYnl0ZXMKWyAgICAwLjk5NzU4OV0gZTgy
MDogcmVzZXJ2ZSBSQU0gYnVmZmVyIFttZW0gMHgwMDA1NTAwMC0weDAwMDVmZmZmXQpbICAgIDAu
OTk3NTkxXSBlODIwOiByZXNlcnZlIFJBTSBidWZmZXIgW21lbSAweDAwMDk4MDAwLTB4MDAwOWZm
ZmZdClsgICAgMC45OTc1OTJdIGU4MjA6IHJlc2VydmUgUkFNIGJ1ZmZlciBbbWVtIDB4YmY4ZWQw
MDAtMHhiZmZmZmZmZl0KWyAgICAwLjk5NzU5M10gZTgyMDogcmVzZXJ2ZSBSQU0gYnVmZmVyIFtt
ZW0gMHhiZmZlMDAwMC0weGJmZmZmZmZmXQpbICAgIDAuOTk4NjAzXSBjbG9ja3NvdXJjZTogU3dp
dGNoZWQgdG8gY2xvY2tzb3VyY2Uga3ZtLWNsb2NrClsgICAgMS4wMDgxMDBdIFZGUzogRGlzayBx
dW90YXMgZHF1b3RfNi42LjAKWyAgICAxLjAwODg0N10gVkZTOiBEcXVvdC1jYWNoZSBoYXNoIHRh
YmxlIGVudHJpZXM6IDUxMiAob3JkZXIgMCwgNDA5NiBieXRlcykKWyAgICAxLjAxMDAyNF0gQXBw
QXJtb3I6IEFwcEFybW9yIEZpbGVzeXN0ZW0gRW5hYmxlZApbICAgIDEuMDExMjc1XSBwbnA6IFBu
UCBBQ1BJIGluaXQKWyAgICAxLjAxMjI4NF0gcG5wOiBQblAgQUNQSTogZm91bmQgNyBkZXZpY2Vz
ClsgICAgMS4wMTM2OTNdIE5FVDogUmVnaXN0ZXJlZCBQRl9JTkVUIHByb3RvY29sIGZhbWlseQpb
ICAgIDEuMDE0ODg0XSBJUCBpZGVudHMgaGFzaCB0YWJsZSBlbnRyaWVzOiAyNjIxNDQgKG9yZGVy
OiA5LCAyMDk3MTUyIGJ5dGVzLCBsaW5lYXIpClsgICAgMS4wMTc0MDRdIHRjcF9saXN0ZW5fcG9y
dGFkZHJfaGFzaCBoYXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0IChvcmRlcjogNiwgMjYyMTQ0IGJ5
dGVzLCBsaW5lYXIpClsgICAgMS4wMTg5NDRdIFRhYmxlLXBlcnR1cmIgaGFzaCB0YWJsZSBlbnRy
aWVzOiA2NTUzNiAob3JkZXI6IDYsIDI2MjE0NCBieXRlcywgbGluZWFyKQpbICAgIDEuMDIwMzMz
XSBUQ1AgZXN0YWJsaXNoZWQgaGFzaCB0YWJsZSBlbnRyaWVzOiAyNjIxNDQgKG9yZGVyOiA5LCAy
MDk3MTUyIGJ5dGVzLCBsaW5lYXIpClsgICAgMS4wMjE5NTBdIFRDUCBiaW5kIGhhc2ggdGFibGUg
ZW50cmllczogNjU1MzYgKG9yZGVyOiA4LCAxMDQ4NTc2IGJ5dGVzLCBsaW5lYXIpClsgICAgMS4w
MjMzODJdIFRDUDogSGFzaCB0YWJsZXMgY29uZmlndXJlZCAoZXN0YWJsaXNoZWQgMjYyMTQ0IGJp
bmQgNjU1MzYpClsgICAgMS4wMjQ4MTZdIFVEUCBoYXNoIHRhYmxlIGVudHJpZXM6IDE2Mzg0IChv
cmRlcjogNywgNTI0Mjg4IGJ5dGVzLCBsaW5lYXIpClsgICAgMS4wMjYxNDJdIFVEUC1MaXRlIGhh
c2ggdGFibGUgZW50cmllczogMTYzODQgKG9yZGVyOiA3LCA1MjQyODggYnl0ZXMsIGxpbmVhcikK
WyAgICAxLjAyNzY2Nl0gTkVUOiBSZWdpc3RlcmVkIFBGX1VOSVgvUEZfTE9DQUwgcHJvdG9jb2wg
ZmFtaWx5ClsgICAgMS4wMjg1MDJdIE5FVDogUmVnaXN0ZXJlZCBQRl9YRFAgcHJvdG9jb2wgZmFt
aWx5ClsgICAgMS4wMjk0MzBdIHBjaV9idXMgMDAwMDowMDogcmVzb3VyY2UgNCBbaW8gIDB4MDAw
MC0weDBjZjcgd2luZG93XQpbICAgIDEuMDMwODQwXSBwY2lfYnVzIDAwMDA6MDA6IHJlc291cmNl
IDUgW2lvICAweDBkMDAtMHhmZmZmIHdpbmRvd10KWyAgICAxLjAzMjIyMF0gcGNpX2J1cyAwMDAw
OjAwOiByZXNvdXJjZSA2IFttZW0gMHgwMDBhMDAwMC0weDAwMGJmZmZmIHdpbmRvd10KWyAgICAx
LjAzMzc0N10gcGNpX2J1cyAwMDAwOjAwOiByZXNvdXJjZSA3IFttZW0gMHhjMDAwMDAwMC0weGZl
YmZlZmZmIHdpbmRvd10KWyAgICAxLjAzNTIzN10gcGNpIDAwMDA6MDA6MDAuMDogTGltaXRpbmcg
ZGlyZWN0IFBDSS9QQ0kgdHJhbnNmZXJzClsgICAgMS4wMzY0OTFdIFBDSTogQ0xTIDAgYnl0ZXMs
IGRlZmF1bHQgNjQKWyAgICAxLjAzNzYwM10gUENJLURNQTogVXNpbmcgc29mdHdhcmUgYm91bmNl
IGJ1ZmZlcmluZyBmb3IgSU8gKFNXSU9UTEIpClsgICAgMS4wMzg2NzBdIHNvZnR3YXJlIElPIFRM
QjogbWFwcGVkIFttZW0gMHgwMDAwMDAwMGI3ZmY3MDAwLTB4MDAwMDAwMDBiYmZmNzAwMF0gKDY0
TUIpClsgICAgMS4wNDE4MjJdIGNsb2Nrc291cmNlOiB0c2M6IG1hc2s6IDB4ZmZmZmZmZmZmZmZm
ZmZmZiBtYXhfY3ljbGVzOiAweDIwNmViMjExMWY1LCBtYXhfaWRsZV9uczogNDQwNzk1MjIyNDcx
IG5zClsgICAgMS4wNDM5NDddIGNsb2Nrc291cmNlOiBTd2l0Y2hlZCB0byBjbG9ja3NvdXJjZSB0
c2MKWyAgICAxLjA1MDEyOF0gSW5pdGlhbGlzZSBzeXN0ZW0gdHJ1c3RlZCBrZXlyaW5ncwpbICAg
IDEuMDUwOTAwXSBLZXkgdHlwZSBibGFja2xpc3QgcmVnaXN0ZXJlZApbICAgIDEuMDUxNzUzXSB3
b3JraW5nc2V0OiB0aW1lc3RhbXBfYml0cz00MCBtYXhfb3JkZXI9MjMgYnVja2V0X29yZGVyPTAK
WyAgICAxLjA1NDIyNl0gU0dJIFhGUyB3aXRoIEFDTHMsIHNlY3VyaXR5IGF0dHJpYnV0ZXMsIHF1
b3RhLCBubyBkZWJ1ZyBlbmFibGVkClsgICAgMS4wNTYwNDhdIDlwOiBJbnN0YWxsaW5nIHY5ZnMg
OXAyMDAwIGZpbGUgc3lzdGVtIHN1cHBvcnQKWyAgICAxLjA1NzA3Ml0gaW50ZWdyaXR5OiBQbGF0
Zm9ybSBLZXlyaW5nIGluaXRpYWxpemVkClsgICAgMS4wNTg2NTldIE5FVDogUmVnaXN0ZXJlZCBQ
Rl9BTEcgcHJvdG9jb2wgZmFtaWx5ClsgICAgMS4wNTk1MDVdIHhvcjogYXV0b21hdGljYWxseSB1
c2luZyBiZXN0IGNoZWNrc3VtbWluZyBmdW5jdGlvbiAgIGF2eCAgICAgICAKWyAgICAxLjA2MDg1
OF0gS2V5IHR5cGUgYXN5bW1ldHJpYyByZWdpc3RlcmVkClsgICAgMS4wNjE4NThdIEFzeW1tZXRy
aWMga2V5IHBhcnNlciAneDUwOScgcmVnaXN0ZXJlZApbICAgIDEuMDYyNjc5XSBCbG9jayBsYXll
ciBTQ1NJIGdlbmVyaWMgKGJzZykgZHJpdmVyIHZlcnNpb24gMC40IGxvYWRlZCAobWFqb3IgMjQ4
KQpbICAgIDEuMDY0MDkzXSBpbyBzY2hlZHVsZXIgbXEtZGVhZGxpbmUgcmVnaXN0ZXJlZApbICAg
IDEuMDY1NzExXSBpbnB1dDogUG93ZXIgQnV0dG9uIGFzIC9kZXZpY2VzL0xOWFNZU1RNOjAwL0xO
WFBXUkJOOjAwL2lucHV0L2lucHV0MApbICAgIDEuMDY3MDIwXSBBQ1BJOiBidXR0b246IFBvd2Vy
IEJ1dHRvbiBbUFdSRl0KWyAgICAxLjA2Nzg0NF0gaW5wdXQ6IFNsZWVwIEJ1dHRvbiBhcyAvZGV2
aWNlcy9MTlhTWVNUTTowMC9MTlhTTFBCTjowMC9pbnB1dC9pbnB1dDEKWyAgICAxLjA2OTAzN10g
QUNQSTogYnV0dG9uOiBTbGVlcCBCdXR0b24gW1NMUEZdClsgICAgMS4wNzQ1NTZdIEFDUEk6IFxf
U0JfLkxOS0M6IEVuYWJsZWQgYXQgSVJRIDExClsgICAgMS4wNzU1MTVdIHZpcnRpby1wY2kgMDAw
MDowMDowMy4wOiB2aXJ0aW9fcGNpOiBsZWF2aW5nIGZvciBsZWdhY3kgZHJpdmVyClsgICAgMS4w
ODU0NzJdIEFDUEk6IFxfU0JfLkxOS0Q6IEVuYWJsZWQgYXQgSVJRIDEwClsgICAgMS4wODY0MDJd
IHZpcnRpby1wY2kgMDAwMDowMDowNC4wOiB2aXJ0aW9fcGNpOiBsZWF2aW5nIGZvciBsZWdhY3kg
ZHJpdmVyClsgICAgMS4wOTY2MTVdIEFDUEk6IFxfU0JfLkxOS0E6IEVuYWJsZWQgYXQgSVJRIDEw
ClsgICAgMS4wOTc2MDJdIHZpcnRpby1wY2kgMDAwMDowMDowNS4wOiB2aXJ0aW9fcGNpOiBsZWF2
aW5nIGZvciBsZWdhY3kgZHJpdmVyClsgICAgMS4xMDYzMDNdIEFDUEk6IFxfU0JfLkxOS0I6IEVu
YWJsZWQgYXQgSVJRIDExClsgICAgMS4xMDczMjJdIHZpcnRpby1wY2kgMDAwMDowMDowNi4wOiB2
aXJ0aW9fcGNpOiBsZWF2aW5nIGZvciBsZWdhY3kgZHJpdmVyClsgICAgMS4xMTMxODJdIFNlcmlh
bDogODI1MC8xNjU1MCBkcml2ZXIsIDQgcG9ydHMsIElSUSBzaGFyaW5nIGRpc2FibGVkClsgICAg
MS4xMTQ2NjldIDAwOjAzOiB0dHlTMCBhdCBJL08gMHgzZjggKGlycSA9IDQsIGJhc2VfYmF1ZCA9
IDExNTIwMCkgaXMgYSAxNjU1MEEKWyAgICAxLjExNjE3M10gMDA6MDQ6IHR0eVMxIGF0IEkvTyAw
eDJmOCAoaXJxID0gMywgYmFzZV9iYXVkID0gMTE1MjAwKSBpcyBhIDE2NTUwQQpbICAgIDEuMTE3
ODgwXSAwMDowNTogdHR5UzIgYXQgSS9PIDB4M2U4IChpcnEgPSA2LCBiYXNlX2JhdWQgPSAxMTUy
MDApIGlzIGEgMTY1NTBBClsgICAgMS4xMTkyNDFdIDAwOjA2OiB0dHlTMyBhdCBJL08gMHgyZTgg
KGlycSA9IDcsIGJhc2VfYmF1ZCA9IDExNTIwMCkgaXMgYSAxNjU1MEEKWyAgICAxLjEyMDY5OF0g
Tm9uLXZvbGF0aWxlIG1lbW9yeSBkcml2ZXIgdjEuMwpbICAgIDEuMTUwMDA2XSB0cG1fdGlzIE1T
RlQwMTAxOjAwOiAyLjAgVFBNIChkZXZpY2UtaWQgMHg5MDA5LCByZXYtaWQgMCkKWyAgICAxLjE2
MTk3NF0gbG9vcDogbW9kdWxlIGxvYWRlZApbICAgIDEuMTYyNjQ5XSBHdWVzdCBwZXJzb25hbGl0
eSBpbml0aWFsaXplZCBhbmQgaXMgaW5hY3RpdmUKWyAgICAxLjE2MzU5NF0gVk1DSSBob3N0IGRl
dmljZSByZWdpc3RlcmVkIChuYW1lPXZtY2ksIG1ham9yPTEwLCBtaW5vcj0xMjcpClsgICAgMS4x
NjQ5NjRdIEluaXRpYWxpemVkIGhvc3QgcGVyc29uYWxpdHkKWyAgICAxLjE4ODgwMl0gc2NzaSBo
b3N0MDogVmlydGlvIFNDU0kgSEJBClsgICAgMS4xOTQ5MzFdIHNjc2kgMDowOjE6MDogRGlyZWN0
LUFjY2VzcyAgICAgR29vZ2xlICAgUGVyc2lzdGVudERpc2sgICAxICAgIFBROiAwIEFOU0k6IDYK
WyAgICAxLjIyODU1OF0gVk13YXJlIFBWU0NTSSBkcml2ZXIgLSB2ZXJzaW9uIDEuMC43LjAtawpb
ICAgIDEuMjI5Nzk2XSBodl92bWJ1czogcmVnaXN0ZXJpbmcgZHJpdmVyIGh2X3N0b3J2c2MKWyAg
ICAxLjIzMTUzOV0gc2QgMDowOjE6MDogW3NkYV0gMjA5NzE1MjAwIDUxMi1ieXRlIGxvZ2ljYWwg
YmxvY2tzOiAoMTA3IEdCLzEwMCBHaUIpClsgICAgMS4yMzkwMjNdIHNkIDA6MDoxOjA6IFtzZGFd
IDQwOTYtYnl0ZSBwaHlzaWNhbCBibG9ja3MKWyAgICAxLjI0OTU3Nl0gc2QgMDowOjE6MDogW3Nk
YV0gV3JpdGUgUHJvdGVjdCBpcyBvZmYKWyAgICAxLjI3MDc4NV0gc2QgMDowOjE6MDogW3NkYV0g
TW9kZSBTZW5zZTogMWYgMDAgMDAgMDgKWyAgICAxLjI3MTA1NV0gc2QgMDowOjE6MDogW3NkYV0g
V3JpdGUgY2FjaGU6IGVuYWJsZWQsIHJlYWQgY2FjaGU6IGVuYWJsZWQsIGRvZXNuJ3Qgc3VwcG9y
dCBEUE8gb3IgRlVBClsgICAgMS41MjE5ODJdICBzZGE6IHNkYTEgc2RhMiBzZGEzIHNkYTQgc2Rh
NSBzZGE2IHNkYTcgc2RhOCBzZGE5IHNkYTEwIHNkYTExIHNkYTEyClsgICAgMS42MTk4MzhdIHNk
IDA6MDoxOjA6IFtzZGFdIEF0dGFjaGVkIFNDU0kgZGlzawpbICAgIDEuNzE5MTM5XSBpeGdiZXZm
OiBJbnRlbChSKSAxMCBHaWdhYml0IFBDSSBFeHByZXNzIFZpcnR1YWwgRnVuY3Rpb24gTmV0d29y
ayBEcml2ZXIKWyAgICAxLjcyMDQ5OF0gaXhnYmV2ZjogQ29weXJpZ2h0IChjKSAyMDA5IC0gMjAx
OCBJbnRlbCBDb3Jwb3JhdGlvbi4KWyAgICAxLjcyMTgzMF0gVk13YXJlIHZteG5ldDMgdmlydHVh
bCBOSUMgZHJpdmVyIC0gdmVyc2lvbiAxLjYuMC4wLWstTkFQSQpbICAgIDEuNzIyOTQzXSBodl92
bWJ1czogcmVnaXN0ZXJpbmcgZHJpdmVyIGh2X25ldHZzYwpbICAgIDEuNzIzOTU0XSBpODA0Mjog
UE5QOiBQUy8yIENvbnRyb2xsZXIgW1BOUDAzMDM6S0JELFBOUDBmMTM6TU9VXSBhdCAweDYwLDB4
NjQgaXJxIDEsMTIKWyAgICAxLjcyNTQzMl0gaTgwNDI6IFdhcm5pbmc6IEtleWxvY2sgYWN0aXZl
ClsgICAgMS43Mjg1ODNdIHNlcmlvOiBpODA0MiBLQkQgcG9ydCBhdCAweDYwLDB4NjQgaXJxIDEK
WyAgICAxLjcyOTY5OV0gc2VyaW86IGk4MDQyIEFVWCBwb3J0IGF0IDB4NjAsMHg2NCBpcnEgMTIK
WyAgICAxLjczMDYwMF0gaHZfdm1idXM6IHJlZ2lzdGVyaW5nIGRyaXZlciBoeXBlcnZfa2V5Ym9h
cmQKWyAgICAxLjczMTk2NF0gcnRjX2Ntb3MgMDA6MDA6IFJUQyBjYW4gd2FrZSBmcm9tIFM0Clsg
ICAgMS43MzQwMTVdIHJ0Y19jbW9zIDAwOjAwOiByZWdpc3RlcmVkIGFzIHJ0YzAKWyAgICAxLjcz
NDgxMl0gcnRjX2Ntb3MgMDA6MDA6IGFsYXJtcyB1cCB0byBvbmUgZGF5LCAxMTQgYnl0ZXMgbnZy
YW0KWyAgICAxLjczNTkwM10gaVRDT192ZW5kb3Jfc3VwcG9ydDogdmVuZG9yLXN1cHBvcnQ9MApb
ICAgIDEuNzM2NzkwXSBkZXZpY2UtbWFwcGVyOiBjb3JlOiBDT05GSUdfSU1BX0RJU0FCTEVfSFRB
QkxFIGlzIGRpc2FibGVkLiBEdXBsaWNhdGUgSU1BIG1lYXN1cmVtZW50cyB3aWxsIG5vdCBiZSBy
ZWNvcmRlZCBpbiB0aGUgSU1BIGxvZy4KWyAgICAxLjczOTM3Ml0gZGV2aWNlLW1hcHBlcjogaW9j
dGw6IDQuNDUuMC1pb2N0bCAoMjAyMS0wMy0yMikgaW5pdGlhbGlzZWQ6IGRtLWRldmVsQHJlZGhh
dC5jb20KWyAgICAxLjc0MTQ1Ml0gRUZJIFZhcmlhYmxlcyBGYWNpbGl0eSB2MC4wOCAyMDA0LU1h
eS0xNwpbICAgIDEuNzYzNTgyXSBwc3RvcmU6IFJlZ2lzdGVyZWQgZWZpIGFzIHBlcnNpc3RlbnQg
c3RvcmUgYmFja2VuZApbICAgIDEuNzY0OTUzXSBodl91dGlsczogUmVnaXN0ZXJpbmcgSHlwZXJW
IFV0aWxpdHkgRHJpdmVyClsgICAgMS43NjU5OTJdIGh2X3ZtYnVzOiByZWdpc3RlcmluZyBkcml2
ZXIgaHZfdXRpbHMKWyAgICAxLjc2NzAxNV0gaHZfdm1idXM6IHJlZ2lzdGVyaW5nIGRyaXZlciBo
dl9iYWxsb29uClsgICAgMS43Njc5MDhdIE1pcnJvci9yZWRpcmVjdCBhY3Rpb24gb24KWyAgICAx
Ljc2OTE1NF0gSW5pdGlhbGl6aW5nIFhGUk0gbmV0bGluayBzb2NrZXQKWyAgICAxLjc2OTg3OV0g
TkVUOiBSZWdpc3RlcmVkIFBGX0lORVQ2IHByb3RvY29sIGZhbWlseQpbICAgIDEuNzcxMDU1XSBT
ZWdtZW50IFJvdXRpbmcgd2l0aCBJUHY2ClsgICAgMS43NzE3MjhdIEluLXNpdHUgT0FNIChJT0FN
KSB3aXRoIElQdjYKWyAgICAxLjc3MjczOV0gTkVUOiBSZWdpc3RlcmVkIFBGX1BBQ0tFVCBwcm90
b2NvbCBmYW1pbHkKWyAgICAxLjc3MzQ2MV0gYnJpZGdlOiBmaWx0ZXJpbmcgdmlhIGFycC9pcC9p
cDZ0YWJsZXMgaXMgbm8gbG9uZ2VyIGF2YWlsYWJsZSBieSBkZWZhdWx0LiBVcGRhdGUgeW91ciBz
Y3JpcHRzIHRvIGxvYWQgYnJfbmV0ZmlsdGVyIGlmIHlvdSBuZWVkIHRoaXMuClsgICAgMS43NzU4
MzJdIDlwbmV0OiBJbnN0YWxsaW5nIDlQMjAwMCBzdXBwb3J0ClsgICAgMS43NzY3MjldIE5FVDog
UmVnaXN0ZXJlZCBQRl9WU09DSyBwcm90b2NvbCBmYW1pbHkKWyAgICAxLjc3OTk1MV0gSVBJIHNo
b3J0aGFuZCBicm9hZGNhc3Q6IGVuYWJsZWQKWyAgICAxLjc4MDg2OV0gc2NoZWRfY2xvY2s6IE1h
cmtpbmcgc3RhYmxlICgxNTgyMTg1ODE0LCAxOTg2NTIyOTQpLT4oMjAyODQwMTI1OSwgLTI0NzU2
MzE1MSkKWyAgICAxLjc4MjQ5N10gcmVnaXN0ZXJlZCB0YXNrc3RhdHMgdmVyc2lvbiAxClsgICAg
MS43ODMyNzBdIExvYWRpbmcgY29tcGlsZWQtaW4gWC41MDkgY2VydGlmaWNhdGVzClsgICAgMS43
ODQ1ODZdIExvYWRlZCBYLjUwOSBjZXJ0ICdHb29nbGUgTExDOiBDb250YWluZXItT3B0aW1pemVk
IE9TIGtlcm5lbCBzaWduaW5nIGtleTogNjllMDVjNWI4ZTk0ZGQ2N2ZjZTIzZWIzNzBhZDJmY2Y0
YWM1ZjA3ZScKWyAgICAxLjc4NzAwNl0gTG9hZGVkIFguNTA5IGNlcnQgJ0dvb2dsZTogQ29udGFp
bmVyLU9wdGltaXplZCBPUzogMmVmZWE0OTNmYzE0OGIzNTg1OWQwYmM4YzNkZDcxYTEzOWZjN2Fi
NDExMjgzZTA2ZjZjMTBiNWE2YjE3ZTM1NScKWyAgICAxLjc5MTIyNF0gcHN0b3JlOiBVc2luZyBj
cmFzaCBkdW1wIGNvbXByZXNzaW9uOiBkZWZsYXRlClsgICAgMS43OTIxNDRdIEFwcEFybW9yOiBB
cHBBcm1vciBzaGExIHBvbGljeSBoYXNoaW5nIGVuYWJsZWQKWyAgICAxLjc5MzYyMF0gaW50ZWdy
aXR5OiBMb2FkaW5nIFguNTA5IGNlcnRpZmljYXRlOiBVRUZJOmRiClsgICAgMS43OTQ5MTFdIGlu
dGVncml0eTogTG9hZGVkIFguNTA5IGNlcnQgJ0dvb2dsZSBMTEMuOiBVRUZJIERCIEtleSB2MTA6
IDRiNGViMjcxNThkOGRkNGE1YmI3NjBmNTY3N2YxODQ3MDhjMTVmZGFmOTRkODMwYTdlNTljOTRi
MDY1YTI3MjQnClsgICAgMS43OTc1NDZdIGltYTogQWxsb2NhdGVkIGhhc2ggYWxnb3JpdGhtOiBz
aGEyNTYKWyAgICAxLjc5ODc0Ml0gaW1hOiBDYW4gbm90IGFsbG9jYXRlIHNoYTM4NCAocmVhc29u
OiAtMikKWyAgICAxLjgyNjA4NF0gaW1hOiBObyBhcmNoaXRlY3R1cmUgcG9saWNpZXMgZm91bmQK
WyAgICAxLjgyNzcxMV0gUE06ICAgTWFnaWMgbnVtYmVyOiA0OjY6Mjg3ClsgICAgMS44MjgzOTFd
IHR0eSB0dHkyMDogaGFzaCBtYXRjaGVzClsgICAgMS44Mjg5NDJdIGFjcGkgUE5QMDQwMDowMDog
aGFzaCBtYXRjaGVzClsgICAgMS44Mjk2NDNdIGRldmljZS1tYXBwZXI6IGluaXQ6IHdhaXRpbmcg
Zm9yIGFsbCBkZXZpY2VzIHRvIGJlIGF2YWlsYWJsZSBiZWZvcmUgY3JlYXRpbmcgbWFwcGVkIGRl
dmljZXMKWyAgICAxLjk0MTQwOF0gaW5wdXQ6IEFUIFRyYW5zbGF0ZWQgU2V0IDIga2V5Ym9hcmQg
YXMgL2RldmljZXMvcGxhdGZvcm0vaTgwNDIvc2VyaW8wL2lucHV0L2lucHV0MgpbICAgIDEuOTQz
NzcxXSBkZXZpY2UtbWFwcGVyOiB2ZXJpdHk6IHNoYTI1NiB1c2luZyBpbXBsZW1lbnRhdGlvbiAi
c2hhMjU2LWdlbmVyaWMiClsgICAgMS45NDU2OTRdIGRldmljZS1tYXBwZXI6IGlvY3RsOiBkbS0w
ICh2cm9vdCkgaXMgcmVhZHkKWyAgICAxLjk0NzczMV0gbWQ6IFdhaXRpbmcgZm9yIGFsbCBkZXZp
Y2VzIHRvIGJlIGF2YWlsYWJsZSBiZWZvcmUgYXV0b2RldGVjdApbICAgIDEuOTQ5MDU3XSBtZDog
SWYgeW91IGRvbid0IHVzZSByYWlkLCB1c2UgcmFpZD1ub2F1dG9kZXRlY3QKWyAgICAxLjk0OTky
Ml0gbWQ6IEF1dG9kZXRlY3RpbmcgUkFJRCBhcnJheXMuClsgICAgMS45NTA3NzBdIG1kOiBhdXRv
cnVuIC4uLgpbICAgIDEuOTUxMjg4XSBtZDogLi4uIGF1dG9ydW4gRE9ORS4KWyAgICAxLjk1NDU2
Nl0gRVhUNC1mcyAoZG0tMCk6IG1vdW50aW5nIGV4dDIgZmlsZSBzeXN0ZW0gdXNpbmcgdGhlIGV4
dDQgc3Vic3lzdGVtClsgICAgMS45NTgyODBdIEVYVDQtZnMgKGRtLTApOiBtb3VudGVkIGZpbGVz
eXN0ZW0gd2l0aG91dCBqb3VybmFsLiBPcHRzOiAobnVsbCkuIFF1b3RhIG1vZGU6IG5vbmUuClsg
ICAgMS45NTk3MzBdIFZGUzogTW91bnRlZCByb290IChleHQyIGZpbGVzeXN0ZW0pIHJlYWRvbmx5
IG9uIGRldmljZSAyNTM6MC4KWyAgICAxLjk2MjkyMF0gZGV2dG1wZnM6IG1vdW50ZWQKWyAgICAx
Ljk2NzUwNl0gTG9hZFBpbjogZG0tMCAoMjUzOjApOiByZWFkLW9ubHkKWyAgICAxLjk2ODI0NF0g
TG9hZFBpbjogbG9hZCBwaW5uaW5nIGVuZ2FnZWQuClsgICAgMS45Njg5MzNdIExvYWRQaW46IHg1
MDktY2VydGlmaWNhdGUgcGlubmVkIG9iaj0iL2V0Yy9pbWEvcHVia2V5Lng1MDkiIHBpZD0xIGNt
ZGxpbmU9IiIKWyAgICAxLjk3MTgxOV0gaW50ZWdyaXR5OiBMb2FkaW5nIFguNTA5IGNlcnRpZmlj
YXRlOiAvZXRjL2ltYS9wdWJrZXkueDUwOQpbICAgIDEuOTczNTI0XSBpbnRlZ3JpdHk6IExvYWRl
ZCBYLjUwOSBjZXJ0ICdHb29nbGUgTExDOiBDb250YWluZXItT3B0aW1pemVkIE9TIGtlcm5lbCBz
aWduaW5nIGtleTogNjllMDVjNWI4ZTk0ZGQ2N2ZjZTIzZWIzNzBhZDJmY2Y0YWM1ZjA3ZScKWyAg
ICAxLjk3NzcxOF0gRnJlZWluZyB1bnVzZWQgZGVjcnlwdGVkIG1lbW9yeTogMjAzNksKWyAgICAx
Ljk3OTAwOF0gRnJlZWluZyB1bnVzZWQga2VybmVsIGltYWdlIChpbml0bWVtKSBtZW1vcnk6IDIx
NjhLClsgICAgMS45ODQ2OTVdIFdyaXRlIHByb3RlY3RpbmcgdGhlIGtlcm5lbCByZWFkLW9ubHkg
ZGF0YTogMjI1MjhrClsgICAgMS45ODY2MzBdIEZyZWVpbmcgdW51c2VkIGtlcm5lbCBpbWFnZSAo
dGV4dC9yb2RhdGEgZ2FwKSBtZW1vcnk6IDIwMzJLClsgICAgMS45ODgxNzVdIEZyZWVpbmcgdW51
c2VkIGtlcm5lbCBpbWFnZSAocm9kYXRhL2RhdGEgZ2FwKSBtZW1vcnk6IDEwOEsKWyAgICAxLjk4
OTQ0MF0gUnVuIC91c3IvbGliL3N5c3RlbWQvc3lzdGVtZCBhcyBpbml0IHByb2Nlc3MKWyAgICAx
Ljk5MDMyNl0gICB3aXRoIGFyZ3VtZW50czoKWyAgICAxLjk5MDMyN10gICAgIC91c3IvbGliL3N5
c3RlbWQvc3lzdGVtZApbICAgIDEuOTkwMzI4XSAgICAgbm9yZXN1bWUKWyAgICAxLjk5MDMyOF0g
ICAgICxmaXJtd2FyZQpbICAgIDEuOTkwMzI5XSAgICAgY3Jvc19lZmkKWyAgICAxLjk5MDMyOV0g
ICB3aXRoIGVudmlyb25tZW50OgpbICAgIDEuOTkwMzMwXSAgICAgSE9NRT0vClsgICAgMS45OTAz
MzFdICAgICBURVJNPWxpbnV4ClsgICAgMS45OTAzMzFdICAgICBCT09UX0lNQUdFPS9zeXNsaW51
eC92bWxpbnV6LkEKWyAgICAxLjk5MDMzMV0gICAgIGJvb3Q9bG9jYWwKWyAgICAxLjk5MDMzMl0g
ICAgIHBhbmljX29uX3VucmVjb3ZlcmVkX25taT0xClsgICAgMS45OTAzMzJdICAgICBkbT0xIHZy
b290IG5vbmUgcm8gMSwwIDQwNzc1NjggdmVyaXR5IHBheWxvYWQ9UEFSVFVVSUQ9RDc1MTRFRkIt
M0JDRC04QjQ3LUE2RUEtMEFCOUI0MDVEQzBFIGhhc2h0cmVlPVBBUlRVVUlEPUQ3NTE0RUZCLTNC
Q0QtOEI0Ny1BNkVBLTBBQjlCNDA1REMwRSBoYXNoc3RhcnQ9NDA3NzU2OCBhbGc9c2hhMjU2IHJv
b3RfaGV4ZGlnZXN0PTNlYWE1YmE2ODQyMTAwZDQzZWZlYTAwYjY0ZTQwYTgzMjFkYjcyMTcyMDNi
OGI5MDIzMDIyNTBlODFlMmUwZjcgc2FsdD0yNzdiZTkwMjI2OTU2NTA0MmE3ZWI1YWQwODQxZTdk
NTRiYjhkNmNmZWFmZWE1N2ZkMGU1MWEzYTEwZGUxNDA0ClsgICAgMi4yMTMyNzVdIHN5c3RlbWRb
MV06IHN5c3RlbWQgMjQ5IHJ1bm5pbmcgaW4gc3lzdGVtIG1vZGUgKCtQQU0gK0FVRElUIC1TRUxJ
TlVYICtBUFBBUk1PUiArSU1BICtTTUFDSyArU0VDQ09NUCArR0NSWVBUICtHTlVUTFMgK09QRU5T
U0wgLUFDTCArQkxLSUQgLUNVUkwgLUVMRlVUSUxTIC1GSURPMiArSUROMiAtSUROIC1JUFRDICtL
TU9EIC1MSUJDUllQVFNFVFVQICtMSUJGRElTSyAtUENSRTIgLVBXUVVBTElUWSAtUDExS0lUIC1R
UkVOQ09ERSAtQlpJUDIgK0xaNCAtWFogLVpMSUIgLVpTVEQgLVhLQkNPTU1PTiArVVRNUCArU1lT
VklOSVQgZGVmYXVsdC1oaWVyYXJjaHk9dW5pZmllZCkKWyAgICAyLjIxODQ4Ml0gc3lzdGVtZFsx
XTogRGV0ZWN0ZWQgdmlydHVhbGl6YXRpb24ga3ZtLgpbICAgIDIuMjE5Mjk4XSBzeXN0ZW1kWzFd
OiBEZXRlY3RlZCBhcmNoaXRlY3R1cmUgeDg2LTY0LgpbICAgIDIuMjI2OTg4XSBzeXN0ZW1kWzFd
OiBJbml0aWFsaXppbmcgbWFjaGluZSBJRCBmcm9tIFZNIFVVSUQuClsgICAgMi4yMjg0MTVdIHN5
c3RlbWRbMV06IEluc3RhbGxlZCB0cmFuc2llbnQgL2V0Yy9tYWNoaW5lLWlkIGZpbGUuClsgICAg
My41MjQwNTBdIHN5c3RlbWRbMV06IENvbmZpZ3VyYXRpb24gZmlsZSAvdXNyL2xpYi9zeXN0ZW1k
L3N5c3RlbS9zeXN0ZW1kLXRtcGZpbGVzLWNsZWFuLnRpbWVyIGlzIG1hcmtlZCB3b3JsZC1pbmFj
Y2Vzc2libGUuIFRoaXMgaGFzIG5vIGVmZmVjdCBhcyBjb25maWd1cmF0aW9uIGRhdGEgaXMgYWNj
ZXNzaWJsZSB2aWEgQVBJcyB3aXRob3V0IHJlc3RyaWN0aW9ucy4gUHJvY2VlZGluZyBhbnl3YXku
ClsgICAgMy41MzE4MDNdIHN5c3RlbWRbMV06IENvbmZpZ3VyYXRpb24gZmlsZSAvdXNyL2xpYi9z
eXN0ZW1kL3N5c3RlbS9jcmFzaC1zZW5kZXIudGltZXIgaXMgbWFya2VkIHdvcmxkLWluYWNjZXNz
aWJsZS4gVGhpcyBoYXMgbm8gZWZmZWN0IGFzIGNvbmZpZ3VyYXRpb24gZGF0YSBpcyBhY2Nlc3Np
YmxlIHZpYSBBUElzIHdpdGhvdXQgcmVzdHJpY3Rpb25zLiBQcm9jZWVkaW5nIGFueXdheS4KWyAg
ICAzLjgyMjg3MF0gc3lzdGVtZFsxXTogUXVldWVkIHN0YXJ0IGpvYiBmb3IgZGVmYXVsdCB0YXJn
ZXQgTXVsdGktVXNlciBTeXN0ZW0uClsgICAgMy44MjUxNTZdIHN5c3RlbWRbMV06IGNncm91cCBj
b21wYXRpYmlsaXR5IHRyYW5zbGF0aW9uIGJldHdlZW4gbGVnYWN5IGFuZCB1bmlmaWVkIGhpZXJh
cmNoeSBzZXR0aW5ncyBhY3RpdmF0ZWQuIFNlZSBjZ3JvdXAtY29tcGF0IGRlYnVnIG1lc3NhZ2Vz
IGZvciBkZXRhaWxzLgpbICAgIDMuODI3OTMyXSBzeXN0ZW1kWzFdOiBDcmVhdGVkIHNsaWNlIFNs
aWNlIC9zeXN0ZW0vZ2V0dHkuClsgICAgMy44MzMyOTRdIHN5c3RlbWRbMV06IENyZWF0ZWQgc2xp
Y2UgU2xpY2UgL3N5c3RlbS9tb2Rwcm9iZS4KWyAgICAzLjgzOTIyNF0gc3lzdGVtZFsxXTogQ3Jl
YXRlZCBzbGljZSBTbGljZSAvc3lzdGVtL3NlcmlhbC1nZXR0eS4KWyAgICAzLjg0NDIzNl0gc3lz
dGVtZFsxXTogQ3JlYXRlZCBzbGljZSBTbGljZSBmb3IgU3lzdGVtIERhZW1vbnMuClsgICAgMy44
NTAyMzldIHN5c3RlbWRbMV06IENyZWF0ZWQgc2xpY2UgU2xpY2UgL3N5c3RlbS9zeXN0ZW1kLWZz
Y2suClsgICAgMy44NTUxNzVdIHN5c3RlbWRbMV06IENyZWF0ZWQgc2xpY2UgVXNlciBhbmQgU2Vz
c2lvbiBTbGljZS4KWyAgICAzLjg1OTkwMF0gc3lzdGVtZFsxXTogU3RhcnRlZCBEaXNwYXRjaCBQ
YXNzd29yZCBSZXF1ZXN0cyB0byBDb25zb2xlIERpcmVjdG9yeSBXYXRjaC4KWyAgICAzLjg2NTg5
Nl0gc3lzdGVtZFsxXTogU3RhcnRlZCBGb3J3YXJkIFBhc3N3b3JkIFJlcXVlc3RzIHRvIFdhbGwg
RGlyZWN0b3J5IFdhdGNoLgpbICAgIDMuODcyMDcwXSBzeXN0ZW1kWzFdOiBTZXQgdXAgYXV0b21v
dW50IEFyYml0cmFyeSBFeGVjdXRhYmxlIEZpbGUgRm9ybWF0cyBGaWxlIFN5c3RlbSBBdXRvbW91
bnQgUG9pbnQuClsgICAgMy44Nzg4NDNdIHN5c3RlbWRbMV06IFJlYWNoZWQgdGFyZ2V0IFBhdGgg
VW5pdHMuClsgICAgMy44ODQ3MzNdIHN5c3RlbWRbMV06IFJlYWNoZWQgdGFyZ2V0IFJlbW90ZSBG
aWxlIFN5c3RlbXMuClsgICAgMy44ODk3NTZdIHN5c3RlbWRbMV06IFJlYWNoZWQgdGFyZ2V0IFNs
aWNlIFVuaXRzLgpbICAgIDMuODkzODUzXSBzeXN0ZW1kWzFdOiBSZWFjaGVkIHRhcmdldCBTd2Fw
cy4KWyAgICAzLjkwMTE0OV0gc3lzdGVtZFsxXTogTGlzdGVuaW5nIG9uIFByb2Nlc3MgQ29yZSBE
dW1wIFNvY2tldC4KWyAgICAzLjkwNTg3OF0gc3lzdGVtZFsxXTogTGlzdGVuaW5nIG9uIGluaXRj
dGwgQ29tcGF0aWJpbGl0eSBOYW1lZCBQaXBlLgpbICAgIDMuOTEyMDAwXSBzeXN0ZW1kWzFdOiBM
aXN0ZW5pbmcgb24gSm91cm5hbCBBdWRpdCBTb2NrZXQuClsgICAgMy45MTY5NTZdIHN5c3RlbWRb
MV06IExpc3RlbmluZyBvbiBKb3VybmFsIFNvY2tldCAoL2Rldi9sb2cpLgpbICAgIDMuOTIzOTcz
XSBzeXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gSm91cm5hbCBTb2NrZXQuClsgICAgMy45MjkwNTRd
IHN5c3RlbWRbMV06IExpc3RlbmluZyBvbiBOZXR3b3JrIFNlcnZpY2UgTmV0bGluayBTb2NrZXQu
ClsgICAgMy45MzM5MzBdIHN5c3RlbWRbMV06IExpc3RlbmluZyBvbiB1ZGV2IENvbnRyb2wgU29j
a2V0LgpbICAgIDMuOTM4OTIyXSBzeXN0ZW1kWzFdOiBMaXN0ZW5pbmcgb24gdWRldiBLZXJuZWwg
U29ja2V0LgpbICAgIDMuOTQ0Nzk0XSBzeXN0ZW1kWzFdOiBNb3VudGluZyBIdWdlIFBhZ2VzIEZp
bGUgU3lzdGVtLi4uClsgICAgMy45NTA2NDNdIHN5c3RlbWRbMV06IE1vdW50aW5nIFBPU0lYIE1l
c3NhZ2UgUXVldWUgRmlsZSBTeXN0ZW0uLi4KWyAgICAzLjk1OTE5Ml0gc3lzdGVtZFsxXTogTW91
bnRpbmcgL21udC9kaXNrcy4uLgpbICAgIDMuOTY1NTU5XSBzeXN0ZW1kWzFdOiBNb3VudGluZyBL
ZXJuZWwgRGVidWcgRmlsZSBTeXN0ZW0uLi4KWyAgICAzLjk3MjQ3NV0gc3lzdGVtZFsxXTogTW91
bnRpbmcgS2VybmVsIFRyYWNlIEZpbGUgU3lzdGVtLi4uClsgICAgMy45Nzk2NjddIHN5c3RlbWRb
MV06IE1vdW50aW5nIFRlbXBvcmFyeSBEaXJlY3RvcnkgL3RtcC4uLgpbICAgIDMuOTg2MTc0XSBz
eXN0ZW1kWzFdOiBTdGFydGluZyBNb3VudCAvZGV2L3NobSB3aXRoICdub2V4ZWMnLi4uClsgICAg
My45OTE5MjZdIHN5c3RlbWRbMV06IFN0YXJ0aW5nIENyZWF0ZSBMaXN0IG9mIFN0YXRpYyBEZXZp
Y2UgTm9kZXMuLi4KWyAgICAzLjk5NzcxNl0gc3lzdGVtZFsxXTogU3RhcnRpbmcgTG9hZCBLZXJu
ZWwgTW9kdWxlIGNvbmZpZ2ZzLi4uClsgICAgNC4wMDQxNDhdIHN5c3RlbWRbMV06IFN0YXJ0aW5n
IExvYWQgS2VybmVsIE1vZHVsZSBkcm0uLi4KWyAgICA0LjAxMDc1NV0gc3lzdGVtZFsxXTogU3Rh
cnRpbmcgTG9hZCBLZXJuZWwgTW9kdWxlIGZ1c2UuLi4KWyAgICA0LjAxNjgwNl0gc3lzdGVtZFsx
XTogU3RhcnRpbmcgU2V0dXAgaW5zdGFsbF9hdHRyaWJ1dGVzLnBiLi4uClsgICAgNC4wMjA1Mzdd
IGZ1c2U6IGluaXQgKEFQSSB2ZXJzaW9uIDcuMzQpClsgICAgNC4wMjQ0MDNdIHN5c3RlbWRbMV06
IFN0YXJ0aW5nIEpvdXJuYWwgU2VydmljZS4uLgpbICAgIDQuMDMyOTA1XSBzeXN0ZW1kWzFdOiBD
b25kaXRpb24gY2hlY2sgcmVzdWx0ZWQgaW4gTG9hZCBLZXJuZWwgTW9kdWxlcyBiZWluZyBza2lw
cGVkLgpbICAgIDQuMDM2NjQ5XSBzeXN0ZW1kWzFdOiBTdGFydGluZyBSZW1vdW50IFJvb3QgYW5k
IEtlcm5lbCBGaWxlIFN5c3RlbXMuLi4KWyAgICA0LjA0NDIxMV0gc3lzdGVtZFsxXTogU3RhcnRp
bmcgQXBwbHkgS2VybmVsIFZhcmlhYmxlcy4uLgpbICAgIDQuMDUwNjkxXSBzeXN0ZW1kWzFdOiBT
dGFydGluZyBDb2xkcGx1ZyBBbGwgdWRldiBEZXZpY2VzLi4uClsgICAgNC4wNTc1NTZdIHN5c3Rl
bWRbMV06IE1vdW50ZWQgSHVnZSBQYWdlcyBGaWxlIFN5c3RlbS4KWyAgICA0LjA2MDcwNV0gc3lz
dGVtZFsxXTogTW91bnRlZCBQT1NJWCBNZXNzYWdlIFF1ZXVlIEZpbGUgU3lzdGVtLgpbICAgIDQu
MDY2MDM2XSBzeXN0ZW1kWzFdOiBNb3VudGVkIC9tbnQvZGlza3MuClsgICAgNC4wNzA5MTBdIHN5
c3RlbWRbMV06IFN0YXJ0ZWQgSm91cm5hbCBTZXJ2aWNlLgpbICAgIDQuNDE3MzA1XSBjcnlwdGQ6
IG1heF9jcHVfcWxlbiBzZXQgdG8gMTAwMApbICAgIDQuNzAwMDc2XSBBVlgyIHZlcnNpb24gb2Yg
Z2NtX2VuYy9kZWMgZW5nYWdlZC4KWyAgICA0LjcwMTIwM10gQUVTIENUUiBtb2RlIGJ5OCBvcHRp
bWl6YXRpb24gZW5hYmxlZApbICAgIDQuODI4NTE4XSBFWFQ0LWZzIChzZGE4KTogbW91bnRlZCBm
aWxlc3lzdGVtIHdpdGggb3JkZXJlZCBkYXRhIG1vZGUuIE9wdHM6IChudWxsKS4gUXVvdGEgbW9k
ZTogbm9uZS4KWyAgICA2LjA3ODc4MF0gRVhUNC1mcyAoc2RhMSk6IG1vdW50ZWQgZmlsZXN5c3Rl
bSB3aXRoIG9yZGVyZWQgZGF0YSBtb2RlLiBPcHRzOiBjb21taXQ9MzAuIFF1b3RhIG1vZGU6IG5v
bmUuClsgICAgNi4xNzUyNzZdIHN5c3RlbWQtam91cm5hbGRbMjU2XTogUmVjZWl2ZWQgY2xpZW50
IHJlcXVlc3QgdG8gZmx1c2ggcnVudGltZSBqb3VybmFsLgpbICAgIDYuMjA2ODU4XSBFWFQ0LWZz
IChzZGExKTogcmUtbW91bnRlZC4gT3B0czogY29tbWl0PTMwLiBRdW90YSBtb2RlOiBub25lLgpb
ICAgIDYuMjExODUxXSBFWFQ0LWZzIChzZGExKTogcmUtbW91bnRlZC4gT3B0czogY29tbWl0PTMw
LiBRdW90YSBtb2RlOiBub25lLgpbICAgIDYuMjE4MDc2XSBFWFQ0LWZzIChzZGExKTogcmUtbW91
bnRlZC4gT3B0czogY29tbWl0PTMwLiBRdW90YSBtb2RlOiBub25lLgpbICAgIDYuMjIwMjYxXSBF
WFQ0LWZzIChzZGExKTogcmUtbW91bnRlZC4gT3B0czogY29tbWl0PTMwLiBRdW90YSBtb2RlOiBu
b25lLgpbICAgIDYuMzk0NzAxXSBzeXN0ZW1kLWpvdXJuYWxkWzI1Nl06IEZpbGUgL3Zhci9sb2cv
am91cm5hbC8zNDZiMjJiNGYxMDk4OGE3NGRkNWVhZjEzNDQ1YjY1NC9zeXN0ZW0uam91cm5hbCBj
b3JydXB0ZWQgb3IgdW5jbGVhbmx5IHNodXQgZG93biwgcmVuYW1pbmcgYW5kIHJlcGxhY2luZy4K
WyAgIDI0Ljk3Mjk5M10gRVhUNC1mcyAoc2RhMSk6IHJlLW1vdW50ZWQuIE9wdHM6IGNvbW1pdD0z
MC4gUXVvdGEgbW9kZTogbm9uZS4KWyAgIDQzLjY5NzQ3NF0gQnJpZGdlIGZpcmV3YWxsaW5nIHJl
Z2lzdGVyZWQKWyAgIDQ0LjI1OTI5NF0gRVhUNC1mcyAoc2RhMSk6IHJlLW1vdW50ZWQuIE9wdHM6
IGNvbW1pdD0zMC4gUXVvdGEgbW9kZTogbm9uZS4KWyAgIDQ3LjU3ODMzMF0gRVhUNC1mcyAoc2Rh
MSk6IHJlLW1vdW50ZWQuIE9wdHM6IGNvbW1pdD0zMC4gUXVvdGEgbW9kZTogbm9uZS4KWyAgIDQ5
LjgzMzY1N10gaW8gc2NoZWR1bGVyIGJmcSByZWdpc3RlcmVkClsgIDE1MS45NzE3MjZdIElQdjY6
IEFERFJDT05GKE5FVERFVl9DSEFOR0UpOiBldGgwOiBsaW5rIGJlY29tZXMgcmVhZHkKWyAgMTUx
Ljk3ODI0NF0gSVB2NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6IGNhbGkzMTVmYzU3M2I4ZDog
bGluayBiZWNvbWVzIHJlYWR5ClsgIDE1MS45OTk3ODBdIElQdjY6IEFERFJDT05GKE5FVERFVl9D
SEFOR0UpOiBjYWxpYTZiOGIxMTFmYWU6IGxpbmsgYmVjb21lcyByZWFkeQpbICAxNTIuMDYyMDg3
XSBJUHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdFKTogY2FsaTNhZjlmZWMzZTBkOiBsaW5rIGJl
Y29tZXMgcmVhZHkKWyAgMTUyLjY0NjE2MV0gSVB2NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6
IGNhbGkyN2Y3NzU2ZjMzYzogbGluayBiZWNvbWVzIHJlYWR5ClsgIDE3NC4yNjM4NzhdIHdpcmVn
dWFyZDogV2lyZUd1YXJkIDEuMC4wIGxvYWRlZC4gU2VlIHd3dy53aXJlZ3VhcmQuY29tIGZvciBp
bmZvcm1hdGlvbi4KWyAgMTc0LjI3MTk3MF0gd2lyZWd1YXJkOiBDb3B5cmlnaHQgKEMpIDIwMTUt
MjAxOSBKYXNvbiBBLiBEb25lbmZlbGQgPEphc29uQHp4MmM0LmNvbT4uIEFsbCBSaWdodHMgUmVz
ZXJ2ZWQuClsgIDE5MS43Mjg5NjFdIElQdjY6IEFERFJDT05GKE5FVERFVl9DSEFOR0UpOiBldGgw
OiBsaW5rIGJlY29tZXMgcmVhZHkKWyAgMTkxLjczNTY2M10gSVB2NjogQUREUkNPTkYoTkVUREVW
X0NIQU5HRSk6IGNhbGlhZjAwMzNkZjQxZjogbGluayBiZWNvbWVzIHJlYWR5ClsgIDE5Mi40NTg3
ODhdIEtleSB0eXBlIGRuc19yZXNvbHZlciByZWdpc3RlcmVkClsgIDE5Mi41MzE3OTldIEtleSB0
eXBlIGNpZnMuc3BuZWdvIHJlZ2lzdGVyZWQKWyAgMTkyLjUzNjMwNV0gS2V5IHR5cGUgY2lmcy5p
ZG1hcCByZWdpc3RlcmVkClsgIDE5Mi41NDEwOTddIENJRlM6IEF0dGVtcHRpbmcgdG8gbW91bnQg
XFxnY3BucGV1c2UxcG9jLmVycy5lcXVpZmF4LmNvbVxld3MtZXMtZ3VhcmRpYW4tZGV2ClsgIDE5
Mi43MjY5NTldIElQdjY6IEFERFJDT05GKE5FVERFVl9DSEFOR0UpOiBjYWxpY2JkZTVlN2M1ZmQ6
IGxpbmsgYmVjb21lcyByZWFkeQpbICAxOTIuNzQ3NTE0XSBJUHY2OiBBRERSQ09ORihORVRERVZf
Q0hBTkdFKTogY2FsaWNiZGU1ZTdjNWZkOiBsaW5rIGJlY29tZXMgcmVhZHkKWyAgMTkyLjgyMzg4
OF0gQ0lGUzogVkZTOiBcXGdjcG5wZXVzZTFwb2MuZXJzLmVxdWlmYXguY29tIHNtYjJfZ2V0X3Np
Z25fa2V5OiBDb3VsZCBub3QgZmluZCBzZXNzaW9uIDB4MApbICAxOTIuODMzMjYzXSBDSUZTOiBW
RlM6IFxcZ2NwbnBldXNlMXBvYy5lcnMuZXF1aWZheC5jb20gc21iM19jYWxjX3NpZ25hdHVyZTog
Q291bGQgbm90IGdldCBzaWduaW5nIGtleQpbICAxOTIuODQzMjQyXSAtLS0tLS0tLS0tLS1bIGN1
dCBoZXJlIF0tLS0tLS0tLS0tLS0KWyAgMTkyLjg0ODAxNl0gdmlydF90b19jYWNoZTogT2JqZWN0
IGlzIG5vdCBhIFNsYWIgcGFnZSEKWyAgMTkyLjg1MzIyNF0gV0FSTklORzogQ1BVOiA5IFBJRDog
ODcyNCBhdCBtbS9zbGFiLmg6NDE0IGNhY2hlX2Zyb21fb2JqKzB4YTEvMHgxMTAKWyAgMTkyLjg2
MDc2Nl0gTW9kdWxlcyBsaW5rZWQgaW46IHNoYTUxMl9nZW5lcmljIGNtYWMgbmxzX3V0ZjggY2lm
cyBjaWZzX2FyYzQgY2lmc19tZDQgZG5zX3Jlc29sdmVyIHh0X211bHRpcG9ydCBpcHRfcnBmaWx0
ZXIgaXB0YWJsZV9yYXcgaXBfc2V0X2hhc2hfaXAgaXBfc2V0X2hhc2hfbmV0IGlwX3NldCB3aXJl
Z3VhcmQgaXA2X3VkcF90dW5uZWwgdWRwX3R1bm5lbCBsaWJjaGFjaGEyMHBvbHkxMzA1IHBvbHkx
MzA1X3g4Nl82NCBjaGFjaGFfeDg2XzY0IGxpYmNoYWNoYSBjdXJ2ZTI1NTE5X3g4Nl82NCBsaWJj
dXJ2ZTI1NTE5X2dlbmVyaWMgdmV0aCB4dF9zdGF0aXN0aWMgaXA2dGFibGVfbmF0IGlwNnRhYmxl
X21hbmdsZSB4dF9tYXJrIGJmcSB4dF9uYXQgeHRfTUFTUVVFUkFERSBpcHRhYmxlX25hdCBuZl9u
YXQgeHRfYWRkcnR5cGUgYnJfbmV0ZmlsdGVyIHh0X3N0YXRlIGFlc25pX2ludGVsIGNyeXB0b19z
aW1kIGNyeXB0ZCB2aXJ0aW9fYmFsbG9vbiBmdXNlIGNvbmZpZ2ZzClsgIDE5Mi45MDM3NTVdIElQ
djY6IEFERFJDT05GKE5FVERFVl9DSEFOR0UpOiBjYWxpMWIxMjYxNGYzOGQ6IGxpbmsgYmVjb21l
cyByZWFkeQpbICAxOTIuOTA1MzM2XSBDUFU6IDkgUElEOiA4NzI0IENvbW06IHVtb3VudCBLZHVt
cDogbG9hZGVkIE5vdCB0YWludGVkIDUuMTUuMTQ2KyAjMQpbICAxOTIuOTIwMzM2XSBIYXJkd2Fy
ZSBuYW1lOiBHb29nbGUgR29vZ2xlIENvbXB1dGUgRW5naW5lL0dvb2dsZSBDb21wdXRlIEVuZ2lu
ZSwgQklPUyBHb29nbGUgMDMvMjcvMjAyNApbICAxOTIuOTI5OTQzXSBSSVA6IDAwMTA6Y2FjaGVf
ZnJvbV9vYmorMHhhMS8weDExMApbICAxOTIuOTM0NzM4XSBDb2RlOiAwMSA3NCAwZCA0MSBmNyBj
NCAwMCAwMiAwMCAwMCA3NSAyOSAzMSBkYiBlYiAzMyBjNiAwNSAyOCAwNCA1NSAwMSAwMSA0OCBj
NyBjNyAyMyBmNyAyMiA5NSA0OCBjNyBjNiA1OSA0MyAxYSA5NSBlOCAwZiAzOSBkYiBmZiA8MGY+
IDBiIDQxIGY3IGM0IDAwIDAyIDAwIDAwIDc0IGQ3IDQ4IDhiIDViIDE4IDQ4IDg1IGRiIDc0IDA1
IDRjIDM5ClsgIDE5Mi45NTQwMThdIFJTUDogMDAxODpmZmZmYjNkYmMyNTczOWYwIEVGTEFHUzog
MDAwMTAyNDYKWyAgMTkyLjk2MDc3MV0gUkFYOiBiNWY4NWMwNjA5NzVjMDAwIFJCWDogZmZmZmZh
NjE5MDA5YmFjMCBSQ1g6IDAwMDAwMDAwMDAwMDAwMDAKWyAgMTkyLjk2ODkwOV0gUkRYOiBmZmZm
OTkzMzIxYzZiZmY4IFJTSTogZmZmZjk5MzMyMWM2MDQ0OCBSREk6IGZmZmY5OTMzMjFjNjA0NDgK
WyAgMTkyLjk3ODI5OF0gUkJQOiBmZmZmYjNkYmMyNTczYTEwIFIwODogMDAwMDAwMDAwMDAwMDAw
MCBSMDk6IGZmZmZmZmZmOTU2OTI2MDAKWyAgMTkyLjk4NTkwNV0gUjEwOiAwMDAwMDAwMGZmZmZk
ZmZmIFIxMTogZmZmZmIzZGJjMjU3MzdiOCBSMTI6IDAyMDAwMDAwMDAwMDAwMDAKWyAgMTkyLjk5
MzM2OF0gUjEzOiBmZmZmOTkyYzhmMTYwODAwIFIxNDogZmZmZjk5MmNkMGM2YjEwMCBSMTU6IGZm
ZmZmZmZmYzA2ZWI0NjQKWyAgMTkzLjAwMDkyMl0gRlM6ICAwMDAwN2ZhNWU4NzRiODQwKDAwMDAp
IEdTOmZmZmY5OTMzMjFjNDAwMDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMApbICAxOTMu
MDA5MjAxXSBDUzogIDAwMTAgRFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMz
ClsgIDE5My4wMTU1NTJdIENSMjogMDAwMDdmYTVlOGE2ZjViMCBDUjM6IDAwMDAwMDAxYjk0MDgw
MDAgQ1I0OiAwMDAwMDAwMDAwMzUwZWUwClsgIDE5My4wMjMwNzhdIENhbGwgVHJhY2U6ClsgIDE5
My4wMjYxNzJdICA8VEFTSz4KWyAgMTkzLjAyODY0MF0gID8gX193YXJuKzB4Y2MvMHgxYjAKWyAg
MTkzLjAzMjkzNV0gID8gY2FjaGVfZnJvbV9vYmorMHhhMS8weDExMApbICAxOTMuMDM3Mzk1XSAg
PyByZXBvcnRfYnVnKzB4MTA4LzB4MTYwClsgIDE5My4wNDE0MjhdICA/IGhhbmRsZV9idWcrMHg0
Ny8weDgwClsgIDE5My4wNDUyNThdICA/IGV4Y19pbnZhbGlkX29wKzB4MWIvMHg1MApbICAxOTMu
MDQ5ODY0XSAgPyBhc21fZXhjX2ludmFsaWRfb3ArMHgxNi8weDIwClsgIDE5My4wNTU3MjZdICA/
IGNhY2hlX2Zyb21fb2JqKzB4YTEvMHgxMTAKWyAgMTkzLjA2MDgwM10gIGttZW1fY2FjaGVfZnJl
ZSsweDJiLzB4MjkwClsgIDE5My4wNjUxNzRdICBjaWZzX3NtYWxsX2J1Zl9yZWxlYXNlKzB4MWEv
MHgzMCBbY2lmc10KWyAgMTkzLjA3MjIwMF0gIFNNQjJfb3Blbl9mcmVlKzB4MjYvMHg3MCBbY2lm
c10KWyAgMTkzLjA3OTE1MF0gIHNtYjJfcXVlcnlfaW5mb19jb21wb3VuZCsweDRhNi8weDYwMCBb
Y2lmc10KWyAgMTkzLjA4NTA3Ml0gID8gc2VjdXJpdHlfaW5vZGVfcGVybWlzc2lvbisweDNhLzB4
NjAKWyAgMTkzLjA5MDA1MV0gIHNtYjJfcXVlcnlmcysweDZjLzB4ZjAgW2NpZnNdClsgIDE5My4w
OTQzMTFdICBjaWZzX3N0YXRmcysweGQzLzB4MTgwIFtjaWZzXQpbICAxOTMuMDk4NjAyXSAgdmZz
X3N0YXRmcysweGM5LzB4MTYwClsgIDE5My4xMDIxODldICBfX3g2NF9zeXNfZnN0YXRmcysweGYz
LzB4MTgwClsgIDE5My4xMDYzNjhdICA/IHN5c2NhbGxfZW50ZXJfZnJvbV91c2VyX21vZGUrMHgx
YjEvMHgxYzAKWyAgMTkzLjExMTc2MF0gIGRvX3N5c2NhbGxfNjQrMHg1MS8weGIwClsgIDE5My4x
MTU1ODRdICA/IGV4Y19wYWdlX2ZhdWx0KzB4NzgvMHhmMApbICAxOTMuMTE5NTY5XSAgZW50cnlf
U1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4NjIvMHhjYwpbICAxOTMuMTI0Nzk2XSBSSVA6IDAw
MzM6MHg3ZmE1ZTg5NjZhMjcKWyAgMTkzLjEyODcxOV0gQ29kZTogNzcgMDEgYzMgNDggOGIgMTUg
ZDkgYTMgMGQgMDAgZjcgZDggNjQgODkgMDIgYjggZmYgZmYgZmYgZmYgYzMgNjYgMmUgMGYgMWYg
ODQgMDAgMDAgMDAgMDAgMDAgMGYgMWYgNDAgMDAgYjggOGEgMDAgMDAgMDAgMGYgMDUgPDQ4PiAz
ZCAwMCBmMCBmZiBmZiA3NyAwMSBjMyA0OCA4YiAxNSBhOSBhMyAwZCAwMCBmNyBkOCA2NCA4OSAw
MiBiOApbICAxOTMuMTQ4MTA4XSBSU1A6IDAwMmI6MDAwMDdmZmRhNDE1MDA2OCBFRkxBR1M6IDAw
MDAwMjA2IE9SSUdfUkFYOiAwMDAwMDAwMDAwMDAwMDhhClsgIDE5My4xNTU5MzVdIFJBWDogZmZm
ZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDAwMDAwMDAwMDAwMDMgUkNYOiAwMDAwN2ZhNWU4OTY2YTI3
ClsgIDE5My4xNjMyMjhdIFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDA3ZmZkYTQxNTAw
YjAgUkRJOiAwMDAwMDAwMDAwMDAwMDAzClsgIDE5My4xNzA1OTNdIFJCUDogMDAwMDdmYTVlOGFi
MjI2NCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAwMDAwNTU4YmFiYzczYzIwClsgIDE5My4x
Nzc4OTBdIFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAwMDAyMDYgUjEyOiAw
MDAwN2ZmZGE0MTUwMGIwClsgIDE5My4xODUxNzRdIFIxMzogMDAwMDdmYTVlOGFiMjI2NCBSMTQ6
IDAwMDAwMDAwZmZmZmZmZmYgUjE1OiAwMDAwNTU4YmFiYzczOWYwClsgIDE5My4xOTI0NjFdICA8
L1RBU0s+ClsgIDE5My4xOTQ3ODVdIC0tLVsgZW5kIHRyYWNlIDRjOGFmZTliNWMzNjRhMTEgXS0t
LQpbICAxOTMuMjE0MzQwXSBJUHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdFKTogY2FsaTk3NzQz
ZmQxZTkxOiBsaW5rIGJlY29tZXMgcmVhZHkKWyAgMTkzLjIyMjQzOV0gSVB2NjogQUREUkNPTkYo
TkVUREVWX0NIQU5HRSk6IGNhbGlmMzJkZjViZjA1OTogbGluayBiZWNvbWVzIHJlYWR5ClsgIDE5
My4yMzA0ODVdIElQdjY6IEFERFJDT05GKE5FVERFVl9DSEFOR0UpOiBjYWxpZjFiOWRjNmIzYWM6
IGxpbmsgYmVjb21lcyByZWFkeQpbICAxOTMuMjM1OTUxXSBDSUZTOiBWRlM6IFxcZ2NwbnBldXNl
MXBvYy5lcnMuZXF1aWZheC5jb20gc21iMl9nZXRfc2lnbl9rZXk6IENvdWxkIG5vdCBmaW5kIHNl
c3Npb24gMHgwClsgIDE5My4yNDk2MjVdIENJRlM6IFZGUzogXFxnY3BucGV1c2UxcG9jLmVycy5l
cXVpZmF4LmNvbSBzbWIzX2NhbGNfc2lnbmF0dXJlOiBDb3VsZCBub3QgZ2V0IHNpZ25pbmcga2V5
ClsgIDE5My4zNjM2NzFdIElQdjY6IEFERFJDT05GKE5FVERFVl9DSEFOR0UpOiBjYWxpYWIyMjAy
MGI2OGE6IGxpbmsgYmVjb21lcyByZWFkeQpbICAxOTMuNjMyNjQwXSBJUHY2OiBBRERSQ09ORihO
RVRERVZfQ0hBTkdFKTogY2FsaWYxYjUzZDVkZTFjOiBsaW5rIGJlY29tZXMgcmVhZHkKWyAgMTkz
Ljc0NTUyMl0gSVB2NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6IGNhbGkwYzA3N2Q5YzZkNzog
bGluayBiZWNvbWVzIHJlYWR5ClsgIDE5My43NjY4MjBdIElQdjY6IEFERFJDT05GKE5FVERFVl9D
SEFOR0UpOiBjYWxpMGMwNzdkOWM2ZDc6IGxpbmsgYmVjb21lcyByZWFkeQpbICAxOTMuODA4NjI4
XSBJUHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdFKTogY2FsaTVjZWM2Mzg5ODUwOiBsaW5rIGJl
Y29tZXMgcmVhZHkKWyAgMTkzLjgzMjk2M10gSVB2NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6
IGNhbGkzZTA3ZGYzZmU5ZDogbGluayBiZWNvbWVzIHJlYWR5ClsgIDE5My44NjE1MzldIElQdjY6
IEFERFJDT05GKE5FVERFVl9DSEFOR0UpOiBjYWxpZmRjYWJlZGVhNjc6IGxpbmsgYmVjb21lcyBy
ZWFkeQpbICAxOTMuODg0MjAwXSBJUHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdFKTogY2FsaTEx
M2NlYmE0ZmJhOiBsaW5rIGJlY29tZXMgcmVhZHkKWyAgMTkzLjkxMDI0Nl0gSVB2NjogQUREUkNP
TkYoTkVUREVWX0NIQU5HRSk6IGNhbGk3MzE1MWNlMWRlZjogbGluayBiZWNvbWVzIHJlYWR5Clsg
IDE5My45MzQwNTddIElQdjY6IEFERFJDT05GKE5FVERFVl9DSEFOR0UpOiBjYWxpOTZjZjkwOWRl
Yjk6IGxpbmsgYmVjb21lcyByZWFkeQpbICAxOTQuMzE0NzEzXSBJUHY2OiBBRERSQ09ORihORVRE
RVZfQ0hBTkdFKTogY2FsaTQ0MmZiOTRjMmM2OiBsaW5rIGJlY29tZXMgcmVhZHkKWyAgMTk0LjQ3
OTQyOV0gSVB2NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6IGNhbGk5Yjc1YTkxZDMxMzogbGlu
ayBiZWNvbWVzIHJlYWR5ClsgIDE5NC41NDQyOTNdIElQdjY6IEFERFJDT05GKE5FVERFVl9DSEFO
R0UpOiBjYWxpOTQ5ZjJiMTRjMWY6IGxpbmsgYmVjb21lcyByZWFkeQpbICAxOTQuOTg1MjI4XSBJ
UHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdFKTogZXRoMDogbGluayBiZWNvbWVzIHJlYWR5Clsg
IDE5NC45OTE4MjNdIElQdjY6IEFERFJDT05GKE5FVERFVl9DSEFOR0UpOiBjYWxpMjIwOTFiYTVl
ZDU6IGxpbmsgYmVjb21lcyByZWFkeQpbICAxOTUuMDg1OTg5XSBJUHY2OiBBRERSQ09ORihORVRE
RVZfQ0hBTkdFKTogY2FsaTZmNTQwODY1OTJiOiBsaW5rIGJlY29tZXMgcmVhZHkKWyAgMTk1LjEz
NjI5M10gSVB2NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6IGNhbGkyODgwN2FiZDZlYTogbGlu
ayBiZWNvbWVzIHJlYWR5ClsgIDE5NS4xNzE5ODhdIElQdjY6IEFERFJDT05GKE5FVERFVl9DSEFO
R0UpOiBjYWxpNzMxNmEzOGRhZmQ6IGxpbmsgYmVjb21lcyByZWFkeQpbICAxOTUuMTgxMjM2XSBJ
UHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdFKTogY2FsaTVhMGVmMDdhMjVjOiBsaW5rIGJlY29t
ZXMgcmVhZHkKWyAgMTk1LjE5MTM1OF0gSVB2NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6IGNh
bGlhMTc3ZmQ2NTMxNzogbGluayBiZWNvbWVzIHJlYWR5ClsgIDE5NS4xOTk3NThdIElQdjY6IEFE
RFJDT05GKE5FVERFVl9DSEFOR0UpOiBjYWxpOTczZGUzZTQ5YjE6IGxpbmsgYmVjb21lcyByZWFk
eQpbICAxOTUuMjA5MTY3XSBJUHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdFKTogY2FsaWY5ODNh
MGQzYTczOiBsaW5rIGJlY29tZXMgcmVhZHkKWyAgMjg0LjgwODg2OF0gSVB2NjogQUREUkNPTkYo
TkVUREVWX0NIQU5HRSk6IGV0aDA6IGxpbmsgYmVjb21lcyByZWFkeQpbICAyODQuODE1MzQ4XSBJ
UHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdFKTogY2FsaWU3MDdjNzU1MTc3OiBsaW5rIGJlY29t
ZXMgcmVhZHkKWyAgMzg0LjI3OTgyNl0gdHJhcHM6IGRvdG5ldFsyMDQxNl0gZ2VuZXJhbCBwcm90
ZWN0aW9uIGZhdWx0IGlwOjdmOGRiZTk0Zjg5OCBzcDo3ZmZkNGY2MDhjYzAgZXJyb3I6MCBpbiBs
aWJjLnNvLjZbN2Y4ZGJlOTRmMDAwKzE5NTAwMF0KWyAgNDA0LjY0NjE0OV0gSVB2NjogQUREUkNP
TkYoTkVUREVWX0NIQU5HRSk6IGV0aDA6IGxpbmsgYmVjb21lcyByZWFkeQpbICA0MDQuNjUyNjQ0
XSBJUHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdFKTogY2FsaWQxZjkyMzRjMTFlOiBsaW5rIGJl
Y29tZXMgcmVhZHkKWyAgNDE3Ljc4MzQ3NF0gdHJhcHM6IGRvdG5ldFsyNDk0Ml0gZ2VuZXJhbCBw
cm90ZWN0aW9uIGZhdWx0IGlwOjdmYmY2OTQ2ZTg5OCBzcDo3ZmZmNDI3OTU4ZjAgZXJyb3I6MCBp
biBsaWJjLnNvLjZbN2ZiZjY5NDZlMDAwKzE5NTAwMF0KWyAgNDU5Ljg5NjA5N10gdHJhcHM6IGRv
dG5ldFsyNzg2N10gZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0IGlwOjdmZWE1YjJkNjg5OCBzcDo3
ZmZmNTVlZTI0ZTAgZXJyb3I6MCBpbiBsaWJjLnNvLjZbN2ZlYTViMmQ2MDAwKzE5NTAwMF0KWyAg
NTI0LjU5MjE5MF0gSVB2NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6IGV0aDA6IGxpbmsgYmVj
b21lcyByZWFkeQpbICA1MjQuNTk4ODEwXSBJUHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdFKTog
Y2FsaWNlNTk3OWI2NjFkOiBsaW5rIGJlY29tZXMgcmVhZHkKWyAgNTI5LjIwNDM1NF0gdHJhcHM6
IGRvdG5ldFszMTM1OF0gZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0IGlwOjdmNWNjNmU4Njg5OCBz
cDo3ZmZlYWQxMjdjNDAgZXJyb3I6MCBpbiBsaWJjLnNvLjZbN2Y1Y2M2ZTg2MDAwKzE5NTAwMF0K
WyAgNTg3LjU1NDA1NF0gSVB2NDogbWFydGlhbiBzb3VyY2UgMTAwLjEwMC4yMjguMTE0IGZyb20g
MTAwLjEwMC4yMjguMTEwLCBvbiBkZXYgZXRoMApbICA1ODcuNTYxODA5XSBsbCBoZWFkZXI6IDAw
MDAwMDAwOiA0MiAwMSAwYSA4MiBiNyAzMiA0MiAwMSAwYSA4MiBiNyAwMSAwOCAwMApbICA1ODgu
NTU5Mjc4XSBJUHY0OiBtYXJ0aWFuIHNvdXJjZSAxMDAuMTAwLjIyOC4xMTQgZnJvbSAxMDAuMTAw
LjIyOC4xMTAsIG9uIGRldiBldGgwClsgIDU4OC41NjcwNDldIGxsIGhlYWRlcjogMDAwMDAwMDA6
IDQyIDAxIDBhIDgyIGI3IDMyIDQyIDAxIDBhIDgyIGI3IDAxIDA4IDAwClsgIDU5MC42MDcyNjBd
IElQdjQ6IG1hcnRpYW4gc291cmNlIDEwMC4xMDAuMjI4LjExNCBmcm9tIDEwMC4xMDAuMjI4LjEx
MCwgb24gZGV2IGV0aDAKWyAgNTkwLjYxNTAxNl0gbGwgaGVhZGVyOiAwMDAwMDAwMDogNDIgMDEg
MGEgODIgYjcgMzIgNDIgMDEgMGEgODIgYjcgMDEgMDggMDAKWyAgNTk0LjYzOTI1NV0gSVB2NDog
bWFydGlhbiBzb3VyY2UgMTAwLjEwMC4yMjguMTE0IGZyb20gMTAwLjEwMC4yMjguMTEwLCBvbiBk
ZXYgZXRoMApbICA1OTQuNjQ3MDIxXSBsbCBoZWFkZXI6IDAwMDAwMDAwOiA0MiAwMSAwYSA4MiBi
NyAzMiA0MiAwMSAwYSA4MiBiNyAwMSAwOCAwMApbICA2MDQuNTU3MzkzXSBJUHY0OiBtYXJ0aWFu
IHNvdXJjZSAxMDAuMTAwLjIyOC45MiBmcm9tIDEwMC4xMDAuMjI4LjExMCwgb24gZGV2IGV0aDAK
WyAgNjA0LjU2NTE0Ml0gbGwgaGVhZGVyOiAwMDAwMDAwMDogNDIgMDEgMGEgODIgYjcgMzIgNDIg
MDEgMGEgODIgYjcgMDEgMDggMDAKWyAgNjA1LjU4NDIwNl0gSVB2NDogbWFydGlhbiBzb3VyY2Ug
MTAwLjEwMC4yMjguOTIgZnJvbSAxMDAuMTAwLjIyOC4xMTAsIG9uIGRldiBldGgwClsgIDYwNS41
OTIwNDBdIGxsIGhlYWRlcjogMDAwMDAwMDA6IDQyIDAxIDBhIDgyIGI3IDMyIDQyIDAxIDBhIDgy
IGI3IDAxIDA4IDAwClsgIDYwNy42MzEyNzZdIElQdjQ6IG1hcnRpYW4gc291cmNlIDEwMC4xMDAu
MjI4LjkyIGZyb20gMTAwLjEwMC4yMjguMTEwLCBvbiBkZXYgZXRoMApbICA2MDcuNjM4OTYwXSBs
bCBoZWFkZXI6IDAwMDAwMDAwOiA0MiAwMSAwYSA4MiBiNyAzMiA0MiAwMSAwYSA4MiBiNyAwMSAw
OCAwMApbICA2MTEuNjYzMjM2XSBJUHY0OiBtYXJ0aWFuIHNvdXJjZSAxMDAuMTAwLjIyOC45MiBm
cm9tIDEwMC4xMDAuMjI4LjExMCwgb24gZGV2IGV0aDAKWyAgNjExLjY3MDkxM10gbGwgaGVhZGVy
OiAwMDAwMDAwMDogNDIgMDEgMGEgODIgYjcgMzIgNDIgMDEgMGEgODIgYjcgMDEgMDggMDAKWyAg
NjE5LjU1OTA4OV0gSVB2NDogbWFydGlhbiBzb3VyY2UgMTAwLjEwMC4yMjguOTIgZnJvbSAxMDAu
MTAwLjIyOC4xMTAsIG9uIGRldiBldGgwClsgIDYxOS41NjY3NDddIGxsIGhlYWRlcjogMDAwMDAw
MDA6IDQyIDAxIDBhIDgyIGI3IDMyIDQyIDAxIDBhIDgyIGI3IDAxIDA4IDAwClsgIDYyMC41NjAy
MjZdIElQdjQ6IG1hcnRpYW4gc291cmNlIDEwMC4xMDAuMjI4LjkyIGZyb20gMTAwLjEwMC4yMjgu
MTEwLCBvbiBkZXYgZXRoMApbICA2MjAuNTY3ODg0XSBsbCBoZWFkZXI6IDAwMDAwMDAwOiA0MiAw
MSAwYSA4MiBiNyAzMiA0MiAwMSAwYSA4MiBiNyAwMSAwOCAwMApbICA2MjIuNjA3NDYwXSBJUHY0
OiBtYXJ0aWFuIHNvdXJjZSAxMDAuMTAwLjIyOC45MiBmcm9tIDEwMC4xMDAuMjI4LjExMCwgb24g
ZGV2IGV0aDAKWyAgNjIyLjYxNTE1Ml0gbGwgaGVhZGVyOiAwMDAwMDAwMDogNDIgMDEgMGEgODIg
YjcgMzIgNDIgMDEgMGEgODIgYjcgMDEgMDggMDAKWyAgNjI2LjYzOTIyNF0gSVB2NDogbWFydGlh
biBzb3VyY2UgMTAwLjEwMC4yMjguOTIgZnJvbSAxMDAuMTAwLjIyOC4xMTAsIG9uIGRldiBldGgw
ClsgIDYyNi42NDY5MDRdIGxsIGhlYWRlcjogMDAwMDAwMDA6IDQyIDAxIDBhIDgyIGI3IDMyIDQy
IDAxIDBhIDgyIGI3IDAxIDA4IDAwClsgIDYzNS45NjIzNDVdIHRyYXBzOiBkb3RuZXRbMzc3OTFd
IGdlbmVyYWwgcHJvdGVjdGlvbiBmYXVsdCBpcDo3ZjYxNGFmNDY4OTggc3A6N2ZmZGFlNGVmM2Uw
IGVycm9yOjAgaW4gbGliYy5zby42WzdmNjE0YWY0NjAwMCsxOTUwMDBdClsgIDY0NC41NTg4ODBd
IElQdjY6IEFERFJDT05GKE5FVERFVl9DSEFOR0UpOiBldGgwOiBsaW5rIGJlY29tZXMgcmVhZHkK
WyAgNjQ0LjU2NTQ3MV0gSVB2NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6IGNhbGkxMTI3OWVi
YzhkMTogbGluayBiZWNvbWVzIHJlYWR5ClsgIDY2Mi4xNjczNzhdIElQdjY6IEFERFJDT05GKE5F
VERFVl9DSEFOR0UpOiBldGgwOiBsaW5rIGJlY29tZXMgcmVhZHkKWyAgNjYyLjE3NDA5OF0gSVB2
NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6IGNhbGk2MjdiN2QwZWQ3ZTogbGluayBiZWNvbWVz
IHJlYWR5ClsgIDY5MC41NzI1NzVdIElQdjQ6IG1hcnRpYW4gc291cmNlIDEwMC4xMDAuMjI4Ljg2
IGZyb20gMTAwLjEwMC4yMjguMTEwLCBvbiBkZXYgZXRoMApbICA2OTAuNTgwMjMyXSBsbCBoZWFk
ZXI6IDAwMDAwMDAwOiA0MiAwMSAwYSA4MiBiNyAzMiA0MiAwMSAwYSA4MiBiNyAwMSAwOCAwMApb
ICA2OTEuNTk5NDAzXSBJUHY0OiBtYXJ0aWFuIHNvdXJjZSAxMDAuMTAwLjIyOC44NiBmcm9tIDEw
MC4xMDAuMjI4LjExMCwgb24gZGV2IGV0aDAKWyAgNjkxLjYwNzEwMF0gbGwgaGVhZGVyOiAwMDAw
MDAwMDogNDIgMDEgMGEgODIgYjcgMzIgNDIgMDEgMGEgODIgYjcgMDEgMDggMDAKWyAgNjkzLjY0
NzQ1MF0gSVB2NDogbWFydGlhbiBzb3VyY2UgMTAwLjEwMC4yMjguODYgZnJvbSAxMDAuMTAwLjIy
OC4xMTAsIG9uIGRldiBldGgwClsgIDY5My42NTUyNzBdIGxsIGhlYWRlcjogMDAwMDAwMDA6IDQy
IDAxIDBhIDgyIGI3IDMyIDQyIDAxIDBhIDgyIGI3IDAxIDA4IDAwClsgIDY5Ny42NzkyODVdIElQ
djQ6IG1hcnRpYW4gc291cmNlIDEwMC4xMDAuMjI4Ljg2IGZyb20gMTAwLjEwMC4yMjguMTEwLCBv
biBkZXYgZXRoMApbICA2OTcuNjg3MTUyXSBsbCBoZWFkZXI6IDAwMDAwMDAwOiA0MiAwMSAwYSA4
MiBiNyAzMiA0MiAwMSAwYSA4MiBiNyAwMSAwOCAwMApbICA3MDUuNTY5NjE5XSBJUHY0OiBtYXJ0
aWFuIHNvdXJjZSAxMDAuMTAwLjIyOC44NiBmcm9tIDEwMC4xMDAuMjI4LjExMCwgb24gZGV2IGV0
aDAKWyAgNzA1LjU3NzQxOV0gbGwgaGVhZGVyOiAwMDAwMDAwMDogNDIgMDEgMGEgODIgYjcgMzIg
NDIgMDEgMGEgODIgYjcgMDEgMDggMDAKWyAgNzA2LjU3NTQ1N10gSVB2NDogbWFydGlhbiBzb3Vy
Y2UgMTAwLjEwMC4yMjguODYgZnJvbSAxMDAuMTAwLjIyOC4xMTAsIG9uIGRldiBldGgwClsgIDcw
Ni41ODMxMzldIGxsIGhlYWRlcjogMDAwMDAwMDA6IDQyIDAxIDBhIDgyIGI3IDMyIDQyIDAxIDBh
IDgyIGI3IDAxIDA4IDAwClsgIDcwOC42MjMzNjNdIElQdjQ6IG1hcnRpYW4gc291cmNlIDEwMC4x
MDAuMjI4Ljg2IGZyb20gMTAwLjEwMC4yMjguMTEwLCBvbiBkZXYgZXRoMApbICA3MDguNjMxMTk5
XSBsbCBoZWFkZXI6IDAwMDAwMDAwOiA0MiAwMSAwYSA4MiBiNyAzMiA0MiAwMSAwYSA4MiBiNyAw
MSAwOCAwMApbICA3MTIuNjU1MzY2XSBJUHY0OiBtYXJ0aWFuIHNvdXJjZSAxMDAuMTAwLjIyOC44
NiBmcm9tIDEwMC4xMDAuMjI4LjExMCwgb24gZGV2IGV0aDAKWyAgNzEyLjY2MzQyMV0gbGwgaGVh
ZGVyOiAwMDAwMDAwMDogNDIgMDEgMGEgODIgYjcgMzIgNDIgMDEgMGEgODIgYjcgMDEgMDggMDAK
WyAgNzY0LjU2NTAwN10gSVB2NjogQUREUkNPTkYoTkVUREVWX0NIQU5HRSk6IGV0aDA6IGxpbmsg
YmVjb21lcyByZWFkeQpbICA3NjQuNTcxNTk1XSBJUHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdF
KTogY2FsaWVmNGU4ZjBlNTBkOiBsaW5rIGJlY29tZXMgcmVhZHkKWyAgODEzLjQ3MDA3OV0gdHJh
cHM6IGRvdG5ldFs0ODIwN10gZ2VuZXJhbCBwcm90ZWN0aW9uIGZhdWx0IGlwOjdmZTQxOThkYTg5
OCBzcDo3ZmZmMmVmMjliZjAgZXJyb3I6MCBpbiBsaWJjLnNvLjZbN2ZlNDE5OGRhMDAwKzE5NTAw
MF0KWyAgODMwLjU1NDczMF0gSVB2NDogbWFydGlhbiBzb3VyY2UgMTAwLjEwMC4yMjguMTE3IGZy
b20gMTAwLjEwMC4yMjguMTEwLCBvbiBkZXYgZXRoMApbICA4MzAuNTYyNTI4XSBsbCBoZWFkZXI6
IDAwMDAwMDAwOiA0MiAwMSAwYSA4MiBiNyAzMiA0MiAwMSAwYSA4MiBiNyAwMSAwOCAwMApbICA4
MzEuNTY3NTE0XSBJUHY0OiBtYXJ0aWFuIHNvdXJjZSAxMDAuMTAwLjIyOC4xMTcgZnJvbSAxMDAu
MTAwLjIyOC4xMTAsIG9uIGRldiBldGgwClsgIDgzMS41NzUyNzVdIGxsIGhlYWRlcjogMDAwMDAw
MDA6IDQyIDAxIDBhIDgyIGI3IDMyIDQyIDAxIDBhIDgyIGI3IDAxIDA4IDAwClsgIDgzMy42MTU0
ODFdIElQdjQ6IG1hcnRpYW4gc291cmNlIDEwMC4xMDAuMjI4LjExNyBmcm9tIDEwMC4xMDAuMjI4
LjExMCwgb24gZGV2IGV0aDAKWyAgODMzLjYyMzI0OV0gbGwgaGVhZGVyOiAwMDAwMDAwMDogNDIg
MDEgMGEgODIgYjcgMzIgNDIgMDEgMGEgODIgYjcgMDEgMDggMDAKWyAgODM3LjY0NzQyMV0gSVB2
NDogbWFydGlhbiBzb3VyY2UgMTAwLjEwMC4yMjguMTE3IGZyb20gMTAwLjEwMC4yMjguMTEwLCBv
biBkZXYgZXRoMApbICA4MzcuNjU1MTU3XSBsbCBoZWFkZXI6IDAwMDAwMDAwOiA0MiAwMSAwYSA4
MiBiNyAzMiA0MiAwMSAwYSA4MiBiNyAwMSAwOCAwMApbICA4ODQuNDkyNTEzXSBDSUZTOiBBdHRl
bXB0aW5nIHRvIG1vdW50IFxcZ2NwbnBldXNlMXBvYy5lcnMuZXF1aWZheC5jb21cZXdzLWVzLWd1
YXJkaWFuLWRldgpbICA4ODQuNjE4NjM5XSBCVUc6IHVuYWJsZSB0byBoYW5kbGUgcGFnZSBmYXVs
dCBmb3IgYWRkcmVzczogZmZmZmZmZmYwMDAwMDAwMApbICA4ODQuNjI1NjYzXSAjUEY6IHN1cGVy
dmlzb3IgcmVhZCBhY2Nlc3MgaW4ga2VybmVsIG1vZGUKWyAgODg0LjYzMDkxN10gI1BGOiBlcnJv
cl9jb2RlKDB4MDAwMCkgLSBub3QtcHJlc2VudCBwYWdlClsgIDg4NC42MzYxNjddIFBHRCAzZDc2
MTAwNjcgUDREIDNkNzYxMDA2NyBQVUQgMCAKWyAgODg0LjY0MDg2OF0gT29wczogMDAwMCBbIzFd
IFNNUCBOT1BUSQpbICA4ODQuNjQ0NjQ1XSBDUFU6IDkgUElEOiA1MjU5NiBDb21tOiBtb3VudC5j
aWZzIEtkdW1wOiBsb2FkZWQgVGFpbnRlZDogRyAgICAgICAgVyAgICAgICAgIDUuMTUuMTQ2KyAj
MQpbICA4ODQuNjUyNTQyXSBJUHY2OiBBRERSQ09ORihORVRERVZfQ0hBTkdFKTogZXRoMDogbGlu
ayBiZWNvbWVzIHJlYWR5ClsgIDg4NC42NTM5OTldIEhhcmR3YXJlIG5hbWU6IEdvb2dsZSBHb29n
bGUgQ29tcHV0ZSBFbmdpbmUvR29vZ2xlIENvbXB1dGUgRW5naW5lLCBCSU9TIEdvb2dsZSAwMy8y
Ny8yMDI0ClsgIDg4NC42NTQwMDJdIFJJUDogMDAxMDpkZnNfY2FjaGVfY2Fub25pY2FsX3BhdGgr
MHg2Mi8weDE4MCBbY2lmc10KWyAgODg0LjY1NDAxNV0gQ29kZTogZDcgNDkgODkgZjQgNDggODkg
ZmIgZTggMWMgNDIgZmIgZDMgNDggODMgZjggMDMgNzIgNWYgNDkgODkgYzUgOGEgMDMgM2MgNWMg
NzQgMDQgM2MgMmYgNzUgNTIgNDkgOGIgM2MgMjQgNDggOGIgMDUgOWUgZDYgMDQgMDAgPDQ4PiA4
YiAzMCBlOCA1NiA0NSBmYiBkMyA4NSBjMCA3NSA2NCA0OCA4OSBkZiBiZSBjMCAwYyAwMCAwMCBl
OCA1NQpbICA4ODQuNjU0MDE3XSBSU1A6IDAwMTg6ZmZmZmIzZGJjMzRmYmMzOCBFRkxBR1M6IDAw
MDEwMjQ2ClsgIDg4NC42NjA1MDhdIElQdjY6IEFERFJDT05GKE5FVERFVl9DSEFOR0UpOiBjYWxp
MjMwYWZhMzAwMTg6IGxpbmsgYmVjb21lcyByZWFkeQpbICA4ODQuNjY5Nzk2XSAKWyAgODg0LjY2
OTc5OF0gUkFYOiBmZmZmZmZmZjAwMDAwMDAwIFJCWDogZmZmZjk5MmRkZDk3ODk0MSBSQ1g6IDAw
MDAwMDAwMDAwMDAwMDEKWyAgODg0LjY2OTgwMF0gUkRYOiAwMDAwMDAwMDAwMDAwMDAxIFJTSTog
ZmZmZmZmZmZjMDcyNzEwMCBSREk6IGZmZmZmZmZmYzA3MjYwMDAKWyAgODg0LjY2OTgwMV0gUkJQ
OiBmZmZmYjNkYmMzNGZiYzcwIFIwODogZmZmZjk5MmRkZDk3ODk0MSBSMDk6IDAwMDAwMDAwMDAw
MDAwMDAKWyAgODg0LjY2OTgwMl0gUjEwOiBmZmZmYjNkYmMzNGZiY2U4IFIxMTogZmZmZmZmZmZj
MDY4MmNiMCBSMTI6IGZmZmZmZmZmYzA3MjcxMDAKWyAgODg0LjY2OTgwM10gUjEzOiAwMDAwMDAw
MDAwMDAwMDMyIFIxNDogZmZmZmZmZmZmZmZmZmZlYSBSMTU6IDAwMDAwMDAwMDAwMDAwMDEKWyAg
ODg0LjY2OTgwNl0gRlM6ICAwMDAwN2Y1NzBkOTUxNzgwKDAwMDApIEdTOmZmZmY5OTMzMjFjNDAw
MDAoMDAwMCkga25sR1M6MDAwMDAwMDAwMDAwMDAwMApbICA4ODQuNjY5ODA4XSBDUzogIDAwMTAg
RFM6IDAwMDAgRVM6IDAwMDAgQ1IwOiAwMDAwMDAwMDgwMDUwMDMzClsgIDg4NC42Njk4MDldIENS
MjogZmZmZmZmZmYwMDAwMDAwMCBDUjM6IDAwMDAwMDAxYzU2N2MwMDAgQ1I0OiAwMDAwMDAwMDAw
MzUwZWUwClsgIDg4NC42Njk4MTJdIENhbGwgVHJhY2U6ClsgIDg4NC42Njk4MTVdICA8VEFTSz4K
WyAgODg0LjY2OTgxOF0gID8gX19kaWVfYm9keSsweDZiLzB4YjAKWyAgODg0LjY2OTgyM10gID8g
cGFnZV9mYXVsdF9vb3BzKzB4MzUxLzB4M2QwClsgIDg4NC42Njk4MjZdICA/IGtlcm5lbG1vZGVf
Zml4dXBfb3Jfb29wcysweGNiLzB4MTIwClsgIDg4NC42Njk4MjhdICA/IGV4Y19wYWdlX2ZhdWx0
KzB4ZDYvMHhmMApbICA4ODQuNjY5ODMwXSAgPyBhc21fZXhjX3BhZ2VfZmF1bHQrMHgyMi8weDMw
ClsgIDg4NC42Njk4MzVdICA/IHNtYjNfbmVnb3RpYXRlX3dzaXplKzB4NTAvMHg1MCBbY2lmc10K
WyAgODg0LjY2OTg0OF0gID8gZGZzX2NhY2hlX2Nhbm9uaWNhbF9wYXRoKzB4NjIvMHgxODAgW2Np
ZnNdClsgIDg4NC44MTQzMjJdICA/IGRmc19jYWNoZV9jYW5vbmljYWxfcGF0aCsweDQ0LzB4MTgw
IFtjaWZzXQpbICA4ODQuODIwMDIyXSAgZGZzX2NhY2hlX2ZpbmQrMHgyYi8weDE4MCBbY2lmc10K
WyAgODg0LjgyNDUxMF0gIGNpZnNfbW91bnQrMHhmYy8weDlhMCBbY2lmc10KWyAgODg0LjgyODcz
N10gID8gX19rbWFsbG9jX3RyYWNrX2NhbGxlcisweDE2ZC8weDJjMApbICA4ODQuODM0MzExXSAg
PyBzbWIzX2ZzX2NvbnRleHRfZHVwKzB4MTZlLzB4MWQwIFtjaWZzXQpbICA4ODQuODQwMzEyXSAg
Y2lmc19zbWIzX2RvX21vdW50KzB4MTNmLzB4MjYwIFtjaWZzXQpbICA4ODQuODQ1NTg1XSAgc21i
M19nZXRfdHJlZSsweDE0OS8weDI3MCBbY2lmc10KWyAgODg0Ljg1MDM1MF0gIHZmc19nZXRfdHJl
ZSsweDJiLzB4YzAKWyAgODg0Ljg1NDQ2M10gIGRvX25ld19tb3VudCsweDE0Ny8weDM5MApbICA4
ODQuODU4NDU1XSAgX19zZV9zeXNfbW91bnQrMHgxNDkvMHgxYjAKWyAgODg0Ljg2MjQxOF0gIGRv
X3N5c2NhbGxfNjQrMHg1MS8weGIwClsgIDg4NC44NjY0NTRdICA/IGV4Y19wYWdlX2ZhdWx0KzB4
NzgvMHhmMApbICA4ODQuODcwNjg0XSAgZW50cnlfU1lTQ0FMTF82NF9hZnRlcl9od2ZyYW1lKzB4
NjIvMHhjYwpbICA4ODQuODc3NzA2XSBSSVA6IDAwMzM6MHg3ZjU3MGRhNWRiN2EKWyAgODg0Ljg4
MTY5Ml0gQ29kZTogNDggOGIgMGQgODkgODIgMGMgMDAgZjcgZDggNjQgODkgMDEgNDggODMgYzgg
ZmYgYzMgNjYgMmUgMGYgMWYgODQgMDAgMDAgMDAgMDAgMDAgMGYgMWYgNDQgMDAgMDAgNDkgODkg
Y2EgYjggYTUgMDAgMDAgMDAgMGYgMDUgPDQ4PiAzZCAwMSBmMCBmZiBmZiA3MyAwMSBjMyA0OCA4
YiAwZCA1NiA4MiAwYyAwMCBmNyBkOCA2NCA4OSAwMSA0OApbICA4ODQuOTAzMzU0XSBSU1A6IDAw
MmI6MDAwMDdmZmU5MmQxNmM1OCBFRkxBR1M6IDAwMDAwMjAyIE9SSUdfUkFYOiAwMDAwMDAwMDAw
MDAwMGE1ClsgIDg4NC45MTE5NjFdIFJBWDogZmZmZmZmZmZmZmZmZmZkYSBSQlg6IDAwMDA1NTc0
Yzc2Y2NlYjAgUkNYOiAwMDAwN2Y1NzBkYTVkYjdhClsgIDg4NC45MjA3NDddIFJEWDogMDAwMDU1
NzRjNWVkMzQ1YiBSU0k6IDAwMDA1NTc0YzVlZDM0ZmEgUkRJOiAwMDAwN2ZmZTkyZDE3OGEyClsg
IDg4NC45MzA1MDFdIFJCUDogMDAwMDU1NzRjNWVkMzEwOSBSMDg6IDAwMDA1NTc0Yzc2Y2NlYjAg
UjA5OiAwMDAwN2ZmZTkyZDE1ZmYwClsgIDg4NC45NDA1NDldIFIxMDogMDAwMDAwMDAwMDAwMDAw
MCBSMTE6IDAwMDAwMDAwMDAwMDAyMDIgUjEyOiAwMDAwN2ZmZTkyZDE3OGEyClsgIDg4NC45NDkx
NTRdIFIxMzogMDAwMDU1NzRjNzZjZGY0MCBSMTQ6IDAwMDAwMDAwMDAwMDAwMGEgUjE1OiAwMDAw
N2Y1NzBkOTRlMDAwClsgIDg4NC45NTc5NDBdICA8L1RBU0s+ClsgIDg4NC45NjA2NjJdIE1vZHVs
ZXMgbGlua2VkIGluOiB4dF9SRURJUkVDVCB4dF9DVCBzaGE1MTJfZ2VuZXJpYyBjbWFjIG5sc191
dGY4IGNpZnMgY2lmc19hcmM0IGNpZnNfbWQ0IGRuc19yZXNvbHZlciB4dF9tdWx0aXBvcnQgaXB0
X3JwZmlsdGVyIGlwdGFibGVfcmF3IGlwX3NldF9oYXNoX2lwIGlwX3NldF9oYXNoX25ldCBpcF9z
ZXQgd2lyZWd1YXJkIGlwNl91ZHBfdHVubmVsIHVkcF90dW5uZWwgbGliY2hhY2hhMjBwb2x5MTMw
NSBwb2x5MTMwNV94ODZfNjQgY2hhY2hhX3g4Nl82NCBsaWJjaGFjaGEgY3VydmUyNTUxOV94ODZf
NjQgbGliY3VydmUyNTUxOV9nZW5lcmljIHZldGggeHRfc3RhdGlzdGljIGlwNnRhYmxlX25hdCBp
cDZ0YWJsZV9tYW5nbGUgeHRfbWFyayBiZnEgeHRfbmF0IHh0X01BU1FVRVJBREUgaXB0YWJsZV9u
YXQgbmZfbmF0IHh0X2FkZHJ0eXBlIGJyX25ldGZpbHRlciB4dF9zdGF0ZSBhZXNuaV9pbnRlbCBj
cnlwdG9fc2ltZCBjcnlwdGQgdmlydGlvX2JhbGxvb24gZnVzZSBjb25maWdmcwpbICA4ODUuMDE4
MzUyXSBDUjI6IGZmZmZmZmZmMDAwMDAwMDAK
--00000000000057ac530615da6a9d--

