Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11BEB4EA36E
	for <lists+linux-cifs@lfdr.de>; Tue, 29 Mar 2022 01:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230226AbiC1XGT (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 28 Mar 2022 19:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbiC1XGS (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 28 Mar 2022 19:06:18 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C828917E24
        for <linux-cifs@vger.kernel.org>; Mon, 28 Mar 2022 16:04:35 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id b43so16709533ljr.10
        for <linux-cifs@vger.kernel.org>; Mon, 28 Mar 2022 16:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=XIvYK2UMKstcSaavq/OQ1Sot61qMd7pL2HwL/T1Za8U=;
        b=CSir3lVeWBjUEQMHW6EhrmVC89tlzRTuTqmtFawNPSgWaTLamKJM/9lXCtO2npt1Ku
         cUaMgB+P8gSDJUiTSj/PgIhCZOn82bQJNPTXhdNC/nEkY0zkSWe3vXo7p3mitCkzk2PT
         0xvxSSI+jIdbgIFx0thO3GZoJAOVAIN2iWboQqqk/dNrzOdKqPQ0EFL5Dzf10XluQP/j
         FOtfFP+8eDUuzt2+KTexsLgB18TgwaT6DwJcjzEWiHM8D0GJ2eU+GrLxj/hbgmWST1er
         clWlG4kAMXXL7PZYWcKRg4RPSGqBsM6EhV4KFsJoLi/A4K+T3VkjMoLShyxhIs8OqHrO
         fANA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=XIvYK2UMKstcSaavq/OQ1Sot61qMd7pL2HwL/T1Za8U=;
        b=qZblpn3uicdDdLXtLqdal3OAPsQE27wcNumasS1qTJ6vxmONVeCllvphdGj+Hb22w6
         5kb09ZM8RUgKCRZr5fCiGC9//fOCYQ4UfU3Fli/R8fgw3wWpE+N3m00rIt4E5C/n3UTu
         8rfB7YWiubMT9tl0Rfs9wjNya3abjpTakTe1j2ENfqTtwzciMJOYo9ifVhpo61MJG9Uy
         ovci3iTfia/XkPZEzVSMUkgGc/jM27xnMvTzDdS1UqA88fmeXmTMiUwsezbP1+jyFCb7
         QDeGIuy3mc6lvGkEAZ1vBnBOkQE5UMJImdoOdgelECzKbvmI9kEUBA25ePYy7d+0AC+L
         vE3A==
X-Gm-Message-State: AOAM533QLlggiY2y8ON4s0bCl6HLD35xBQKAP7u1t8IrzWvAnOAwPUqH
        f6o4QFy/hN1j6nNJJnyAphi+qyPWNSs24gNS9mjZYT+QQoE=
X-Google-Smtp-Source: ABdhPJzUcojOo8FNlUw0AUU3Q08yYamNXWqimOCkBLS+wsSuWFgkelLINPEhgRHWBLfgsO0Kd8VULCB5k2A3TN4V8hQ=
X-Received: by 2002:a05:651c:1542:b0:249:5d86:3164 with SMTP id
 y2-20020a05651c154200b002495d863164mr22602674ljp.500.1648508673848; Mon, 28
 Mar 2022 16:04:33 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 28 Mar 2022 18:04:23 -0500
Message-ID: <CAH2r5mvDREEnghECdF3Okj6bwi1B6Dk=oM2tyxP=weYsZ7Am1g@mail.gmail.com>
Subject: [PATCH] fix ksmbd bigendian bug in oplock break, and move its struct
 and a few others to smbfs_common
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     Namjae Jeon <linkinjeon@kernel.org>, Paulo Alcantara <pc@cjr.nz>
Content-Type: multipart/mixed; boundary="000000000000ea169605db4f55ea"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--000000000000ea169605db4f55ea
Content-Type: text/plain; charset="UTF-8"

Fix an endian bug in ksmbd for one remaining use of
Persistent/VolatileFid that unnecessarily converted it (it is an
opaque endian field that does not need to be and should not
be converted) in oplock_break for ksmbd, and move the definitions
for the oplock and lease break protocol requests and responses
to fs/smbfs_common/smb2pdu.h

Also move a few more definitions for various protocol requests
that were duplicated (in fs/cifs/smb2pdu.h and fs/ksmbd/smb2pdu.h)
into fs/smbfs_common/smb2pdu.h including:

- various ioctls and reparse structures
- validate negotiate request and response structs
- duplicate extents structs

See attachedcifs

-- 
Thanks,

Steve

--000000000000ea169605db4f55ea
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb3-fix-ksmbd-bigendian-bug-in-oplock-break-and-mov.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-fix-ksmbd-bigendian-bug-in-oplock-break-and-mov.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l1bbhnaj0>
X-Attachment-Id: f_l1bbhnaj0

RnJvbSA3MzU0M2IyZjBkOGEwMGZjMWYzNzUxNmZhODNiODU5NDM1MDFhMjMyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IE1vbiwgMjggTWFyIDIwMjIgMTc6NDU6NTUgLTA1MDAKU3ViamVjdDogW1BBVENIXSBz
bWIzOiBmaXgga3NtYmQgYmlnZW5kaWFuIGJ1ZyBpbiBvcGxvY2sgYnJlYWssIGFuZCBtb3ZlIGl0
cwogc3RydWN0IHRvIHNtYmZzX2NvbW1vbgoKRml4IGFuIGVuZGlhbiBidWcgaW4ga3NtYmQgZm9y
IG9uZSByZW1haW5pbmcgdXNlIG9mClBlcnNpc3RlbnQvVm9sYXRpbGVGaWQgdGhhdCB1bm5lY2Vz
c2FyaWx5IGNvbnZlcnRlZCBpdCAoaXQgaXMgYW4Kb3BhcXVlIGVuZGlhbiBmaWVsZCB0aGF0IGRv
ZXMgbm90IG5lZWQgdG8gYmUgYW5kIHNob3VsZCBub3QKYmUgY29udmVydGVkKSBpbiBvcGxvY2tf
YnJlYWsgZm9yIGtzbWJkLCBhbmQgbW92ZSB0aGUgZGVmaW5pdGlvbnMKZm9yIHRoZSBvcGxvY2sg
YW5kIGxlYXNlIGJyZWFrIHByb3RvY29sIHJlcXVlc3RzIGFuZCByZXNwb25zZXMKdG8gZnMvc21i
ZnNfY29tbW9uL3NtYjJwZHUuaAoKQWxzbyBtb3ZlIGEgZmV3IG1vcmUgZGVmaW5pdGlvbnMgZm9y
IHZhcmlvdXMgcHJvdG9jb2wgcmVxdWVzdHMKdGhhdCB3ZXJlIGR1cGxpY2F0ZWQgKGluIGZzL2Np
ZnMvc21iMnBkdS5oIGFuZCBmcy9rc21iZC9zbWIycGR1LmgpCmludG8gZnMvc21iZnNfY29tbW9u
L3NtYjJwZHUuaCBpbmNsdWRpbmc6CgotIHZhcmlvdXMgaW9jdGxzIGFuZCByZXBhcnNlIHN0cnVj
dHVyZXMKLSB2YWxpZGF0ZSBuZWdvdGlhdGUgcmVxdWVzdCBhbmQgcmVzcG9uc2Ugc3RydWN0cwot
IGR1cGxpY2F0ZSBleHRlbnRzIHN0cnVjdHMKClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8
c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9jaWZzL3NtYjJwZHUuaCAgICAgICAgIHwg
MTEyIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KIGZzL2tzbWJkL3NtYjJw
ZHUuYyAgICAgICAgfCAgIDggKy0tCiBmcy9rc21iZC9zbWIycGR1LmggICAgICAgIHwgIDczIC0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogZnMvc21iZnNfY29tbW9uL3NtYjJwZHUuaCB8IDExMyAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogNCBmaWxlcyBjaGFuZ2VkLCAx
MTcgaW5zZXJ0aW9ucygrKSwgMTg5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2NpZnMv
c21iMnBkdS5oIGIvZnMvY2lmcy9zbWIycGR1LmgKaW5kZXggODY5MmI1OGNiZGIxLi5kOGM0Mzg4
YjE5MGQgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvc21iMnBkdS5oCisrKyBiL2ZzL2NpZnMvc21iMnBk
dS5oCkBAIC0yMjksMTIgKzIyOSw2IEBAIHN0cnVjdCBjb3B5Y2h1bmtfaW9jdGwgewogCV9fdTMy
IFJlc2VydmVkMjsKIH0gX19wYWNrZWQ7CiAKLS8qIHRoaXMgZ29lcyBpbiB0aGUgaW9jdGwgYnVm
ZmVyIHdoZW4gZG9pbmcgRlNDVExfU0VUX1pFUk9fREFUQSAqLwotc3RydWN0IGZpbGVfemVyb19k
YXRhX2luZm9ybWF0aW9uIHsKLQlfX2xlNjQJRmlsZU9mZnNldDsKLQlfX2xlNjQJQmV5b25kRmlu
YWxaZXJvOwotfSBfX3BhY2tlZDsKLQogc3RydWN0IGNvcHljaHVua19pb2N0bF9yc3AgewogCV9f
bGUzMiBDaHVua3NXcml0dGVuOwogCV9fbGUzMiBDaHVua0J5dGVzV3JpdHRlbjsKQEAgLTI4OCw1
MyArMjgyLDYgQEAgc3RydWN0IGZzY3RsX2dldF9pbnRlZ3JpdHlfaW5mb3JtYXRpb25fcnNwIHsK
IC8qIEludGVncml0eSBmbGFncyBmb3IgYWJvdmUgKi8KICNkZWZpbmUgRlNDVExfSU5URUdSSVRZ
X0ZMQUdfQ0hFQ0tTVU1fRU5GT1JDRU1FTlRfT0ZGCTB4MDAwMDAwMDEKIAotLyogUmVwYXJzZSBz
dHJ1Y3R1cmVzIC0gc2VlIE1TLUZTQ0MgMi4xLjIgKi8KLQotLyogc3RydWN0IGZzY3RsX3JlcGFy
c2VfaW5mb19yZXEgaXMgZW1wdHksIG9ubHkgcmVzcG9uc2Ugc3RydWN0cyAoc2VlIGJlbG93KSAq
LwotCi1zdHJ1Y3QgcmVwYXJzZV9kYXRhX2J1ZmZlciB7Ci0JX19sZTMyCVJlcGFyc2VUYWc7Ci0J
X19sZTE2CVJlcGFyc2VEYXRhTGVuZ3RoOwotCV9fdTE2CVJlc2VydmVkOwotCV9fdTgJRGF0YUJ1
ZmZlcltdOyAvKiBWYXJpYWJsZSBMZW5ndGggKi8KLX0gX19wYWNrZWQ7Ci0KLXN0cnVjdCByZXBh
cnNlX2d1aWRfZGF0YV9idWZmZXIgewotCV9fbGUzMglSZXBhcnNlVGFnOwotCV9fbGUxNglSZXBh
cnNlRGF0YUxlbmd0aDsKLQlfX3UxNglSZXNlcnZlZDsKLQlfX3U4CVJlcGFyc2VHdWlkWzE2XTsK
LQlfX3U4CURhdGFCdWZmZXJbXTsgLyogVmFyaWFibGUgTGVuZ3RoICovCi19IF9fcGFja2VkOwot
Ci1zdHJ1Y3QgcmVwYXJzZV9tb3VudF9wb2ludF9kYXRhX2J1ZmZlciB7Ci0JX19sZTMyCVJlcGFy
c2VUYWc7Ci0JX19sZTE2CVJlcGFyc2VEYXRhTGVuZ3RoOwotCV9fdTE2CVJlc2VydmVkOwotCV9f
bGUxNglTdWJzdGl0dXRlTmFtZU9mZnNldDsKLQlfX2xlMTYJU3Vic3RpdHV0ZU5hbWVMZW5ndGg7
Ci0JX19sZTE2CVByaW50TmFtZU9mZnNldDsKLQlfX2xlMTYJUHJpbnROYW1lTGVuZ3RoOwotCV9f
dTgJUGF0aEJ1ZmZlcltdOyAvKiBWYXJpYWJsZSBMZW5ndGggKi8KLX0gX19wYWNrZWQ7Ci0KLSNk
ZWZpbmUgU1lNTElOS19GTEFHX1JFTEFUSVZFIDB4MDAwMDAwMDEKLQotc3RydWN0IHJlcGFyc2Vf
c3ltbGlua19kYXRhX2J1ZmZlciB7Ci0JX19sZTMyCVJlcGFyc2VUYWc7Ci0JX19sZTE2CVJlcGFy
c2VEYXRhTGVuZ3RoOwotCV9fdTE2CVJlc2VydmVkOwotCV9fbGUxNglTdWJzdGl0dXRlTmFtZU9m
ZnNldDsKLQlfX2xlMTYJU3Vic3RpdHV0ZU5hbWVMZW5ndGg7Ci0JX19sZTE2CVByaW50TmFtZU9m
ZnNldDsKLQlfX2xlMTYJUHJpbnROYW1lTGVuZ3RoOwotCV9fbGUzMglGbGFnczsKLQlfX3U4CVBh
dGhCdWZmZXJbXTsgLyogVmFyaWFibGUgTGVuZ3RoICovCi19IF9fcGFja2VkOwotCi0vKiBTZWUg
TVMtRlNDQyAyLjEuMi42IGFuZCBjaWZzcGR1LmggZm9yIHN0cnVjdCByZXBhcnNlX3Bvc2l4X2Rh
dGEgKi8KLQotCiAvKiBTZWUgTVMtREZTQyAyLjIuMiAqLwogc3RydWN0IGZzY3RsX2dldF9kZnNf
cmVmZXJyYWxfcmVxIHsKIAlfX2xlMTYgTWF4UmVmZXJyYWxMZXZlbDsKQEAgLTM1MCwyMiArMjk3
LDYgQEAgc3RydWN0IG5ldHdvcmtfcmVzaWxpZW5jeV9yZXEgewogfSBfX3BhY2tlZDsKIC8qIFRo
ZXJlIGlzIG5vIGJ1ZmZlciBmb3IgdGhlIHJlc3BvbnNlIGllIG5vIHN0cnVjdCBuZXR3b3JrX3Jl
c2lsaWVuY3lfcnNwICovCiAKLQotc3RydWN0IHZhbGlkYXRlX25lZ290aWF0ZV9pbmZvX3JlcSB7
Ci0JX19sZTMyIENhcGFiaWxpdGllczsKLQlfX3U4ICAgR3VpZFtTTUIyX0NMSUVOVF9HVUlEX1NJ
WkVdOwotCV9fbGUxNiBTZWN1cml0eU1vZGU7Ci0JX19sZTE2IERpYWxlY3RDb3VudDsKLQlfX2xl
MTYgRGlhbGVjdHNbNF07IC8qIEJCIGV4cGFuZCB0aGlzIGlmIGF1dG9uZWdvdGlhdGUgPiA0IGRp
YWxlY3RzICovCi19IF9fcGFja2VkOwotCi1zdHJ1Y3QgdmFsaWRhdGVfbmVnb3RpYXRlX2luZm9f
cnNwIHsKLQlfX2xlMzIgQ2FwYWJpbGl0aWVzOwotCV9fdTggICBHdWlkW1NNQjJfQ0xJRU5UX0dV
SURfU0laRV07Ci0JX19sZTE2IFNlY3VyaXR5TW9kZTsKLQlfX2xlMTYgRGlhbGVjdDsgLyogRGlh
bGVjdCBpbiB1c2UgZm9yIHRoZSBjb25uZWN0aW9uICovCi19IF9fcGFja2VkOwotCiAjZGVmaW5l
IFJTU19DQVBBQkxFCWNwdV90b19sZTMyKDB4MDAwMDAwMDEpCiAjZGVmaW5lIFJETUFfQ0FQQUJM
RQljcHVfdG9fbGUzMigweDAwMDAwMDAyKQogCkBAIC00MDEsMTQgKzMzMiw2IEBAIHN0cnVjdCBj
b21wcmVzc19pb2N0bCB7CiAJX19sZTE2IENvbXByZXNzaW9uU3RhdGU7IC8qIFNlZSBjaWZzcGR1
LmggZm9yIHBvc3NpYmxlIGZsYWcgdmFsdWVzICovCiB9IF9fcGFja2VkOwogCi1zdHJ1Y3QgZHVw
bGljYXRlX2V4dGVudHNfdG9fZmlsZSB7Ci0JX191NjQgUGVyc2lzdGVudEZpbGVIYW5kbGU7IC8q
IHNvdXJjZSBmaWxlIGhhbmRsZSwgb3BhcXVlIGVuZGlhbm5lc3MgKi8KLQlfX3U2NCBWb2xhdGls
ZUZpbGVIYW5kbGU7Ci0JX19sZTY0IFNvdXJjZUZpbGVPZmZzZXQ7Ci0JX19sZTY0IFRhcmdldEZp
bGVPZmZzZXQ7Ci0JX19sZTY0IEJ5dGVDb3VudDsgIC8qIEJ5dGVzIHRvIGJlIGNvcGllZCAqLwot
fSBfX3BhY2tlZDsKLQogLyoKICAqIE1heGltdW0gbnVtYmVyIG9mIGlvdnMgd2UgbmVlZCBmb3Ig
YW4gaW9jdGwgcmVxdWVzdC4KICAqIFswXSA6IHN0cnVjdCBzbWIyX2lvY3RsX3JlcQpAQCAtNDE2
LDQxICszMzksNiBAQCBzdHJ1Y3QgZHVwbGljYXRlX2V4dGVudHNfdG9fZmlsZSB7CiAgKi8KICNk
ZWZpbmUgU01CMl9JT0NUTF9JT1ZfU0laRSAyCiAKLXN0cnVjdCBzbWIyX29wbG9ja19icmVhayB7
Ci0Jc3RydWN0IHNtYjJfaGRyIGhkcjsKLQlfX2xlMTYgU3RydWN0dXJlU2l6ZTsgLyogTXVzdCBi
ZSAyNCAqLwotCV9fdTggICBPcGxvY2tMZXZlbDsKLQlfX3U4ICAgUmVzZXJ2ZWQ7Ci0JX19sZTMy
IFJlc2VydmVkMjsKLQlfX3U2NCAgUGVyc2lzdGVudEZpZDsKLQlfX3U2NCAgVm9sYXRpbGVGaWQ7
Ci19IF9fcGFja2VkOwotCi0jZGVmaW5lIFNNQjJfTk9USUZZX0JSRUFLX0xFQVNFX0ZMQUdfQUNL
X1JFUVVJUkVEIGNwdV90b19sZTMyKDB4MDEpCi0KLXN0cnVjdCBzbWIyX2xlYXNlX2JyZWFrIHsK
LQlzdHJ1Y3Qgc21iMl9oZHIgaGRyOwotCV9fbGUxNiBTdHJ1Y3R1cmVTaXplOyAvKiBNdXN0IGJl
IDQ0ICovCi0JX19sZTE2IEVwb2NoOwotCV9fbGUzMiBGbGFnczsKLQlfX3U4ICAgTGVhc2VLZXlb
MTZdOwotCV9fbGUzMiBDdXJyZW50TGVhc2VTdGF0ZTsKLQlfX2xlMzIgTmV3TGVhc2VTdGF0ZTsK
LQlfX2xlMzIgQnJlYWtSZWFzb247Ci0JX19sZTMyIEFjY2Vzc01hc2tIaW50OwotCV9fbGUzMiBT
aGFyZU1hc2tIaW50OwotfSBfX3BhY2tlZDsKLQotc3RydWN0IHNtYjJfbGVhc2VfYWNrIHsKLQlz
dHJ1Y3Qgc21iMl9oZHIgaGRyOwotCV9fbGUxNiBTdHJ1Y3R1cmVTaXplOyAvKiBNdXN0IGJlIDM2
ICovCi0JX19sZTE2IFJlc2VydmVkOwotCV9fbGUzMiBGbGFnczsKLQlfX3U4ICAgTGVhc2VLZXlb
MTZdOwotCV9fbGUzMiBMZWFzZVN0YXRlOwotCV9fbGU2NCBMZWFzZUR1cmF0aW9uOwotfSBfX3Bh
Y2tlZDsKLQogLyoKICAqCVBEVSBxdWVyeSBpbmZvbGV2ZWwgc3RydWN0dXJlIGRlZmluaXRpb25z
CiAgKglCQiBjb25zaWRlciBtb3ZpbmcgdG8gYSBkaWZmZXJlbnQgaGVhZGVyCmRpZmYgLS1naXQg
YS9mcy9rc21iZC9zbWIycGR1LmMgYi9mcy9rc21iZC9zbWIycGR1LmMKaW5kZXggZTdlYjgzNTY0
OGY4Li4xOTBiMjcyZmI0ZjcgMTAwNjQ0Ci0tLSBhL2ZzL2tzbWJkL3NtYjJwZHUuYworKysgYi9m
cy9rc21iZC9zbWIycGR1LmMKQEAgLTc4ODcsOCArNzg4Nyw4IEBAIHN0YXRpYyB2b2lkIHNtYjIw
X29wbG9ja19icmVha19hY2soc3RydWN0IGtzbWJkX3dvcmsgKndvcmspCiAJY2hhciByZXFfb3Bs
ZXZlbCA9IDAsIHJzcF9vcGxldmVsID0gMDsKIAl1bnNpZ25lZCBpbnQgb3Bsb2NrX2NoYW5nZV90
eXBlOwogCi0Jdm9sYXRpbGVfaWQgPSBsZTY0X3RvX2NwdShyZXEtPlZvbGF0aWxlRmlkKTsKLQlw
ZXJzaXN0ZW50X2lkID0gbGU2NF90b19jcHUocmVxLT5QZXJzaXN0ZW50RmlkKTsKKwl2b2xhdGls
ZV9pZCA9IHJlcS0+Vm9sYXRpbGVGaWQ7CisJcGVyc2lzdGVudF9pZCA9IHJlcS0+UGVyc2lzdGVu
dEZpZDsKIAlyZXFfb3BsZXZlbCA9IHJlcS0+T3Bsb2NrTGV2ZWw7CiAJa3NtYmRfZGVidWcoT1BM
T0NLLCAidl9pZCAlbGx1LCBwX2lkICVsbHUgcmVxdWVzdCBvcGxvY2sgbGV2ZWwgJWRcbiIsCiAJ
CSAgICB2b2xhdGlsZV9pZCwgcGVyc2lzdGVudF9pZCwgcmVxX29wbGV2ZWwpOwpAQCAtNzk4Myw4
ICs3OTgzLDggQEAgc3RhdGljIHZvaWQgc21iMjBfb3Bsb2NrX2JyZWFrX2FjayhzdHJ1Y3Qga3Nt
YmRfd29yayAqd29yaykKIAlyc3AtPk9wbG9ja0xldmVsID0gcnNwX29wbGV2ZWw7CiAJcnNwLT5S
ZXNlcnZlZCA9IDA7CiAJcnNwLT5SZXNlcnZlZDIgPSAwOwotCXJzcC0+Vm9sYXRpbGVGaWQgPSBj
cHVfdG9fbGU2NCh2b2xhdGlsZV9pZCk7Ci0JcnNwLT5QZXJzaXN0ZW50RmlkID0gY3B1X3RvX2xl
NjQocGVyc2lzdGVudF9pZCk7CisJcnNwLT5Wb2xhdGlsZUZpZCA9IHZvbGF0aWxlX2lkOworCXJz
cC0+UGVyc2lzdGVudEZpZCA9IHBlcnNpc3RlbnRfaWQ7CiAJaW5jX3JmYzEwMDFfbGVuKHdvcmst
PnJlc3BvbnNlX2J1ZiwgMjQpOwogCXJldHVybjsKIApkaWZmIC0tZ2l0IGEvZnMva3NtYmQvc21i
MnBkdS5oIGIvZnMva3NtYmQvc21iMnBkdS5oCmluZGV4IDRkYjI4OTZiOTc3Yi4uYjQ1NDMwOGYz
NGJiIDEwMDY0NAotLS0gYS9mcy9rc21iZC9zbWIycGR1LmgKKysrIGIvZnMva3NtYmQvc21iMnBk
dS5oCkBAIC0xNjksMjkgKzE2OSw2IEBAIHN0cnVjdCBzbWIyX2J1ZmZlcl9kZXNjX3YxIHsKIAog
I2RlZmluZSBTTUIyXzBfSU9DVExfSVNfRlNDVEwgMHgwMDAwMDAwMQogCi1zdHJ1Y3QgZHVwbGlj
YXRlX2V4dGVudHNfdG9fZmlsZSB7Ci0JX191NjQgUGVyc2lzdGVudEZpbGVIYW5kbGU7IC8qIHNv
dXJjZSBmaWxlIGhhbmRsZSwgb3BhcXVlIGVuZGlhbm5lc3MgKi8KLQlfX3U2NCBWb2xhdGlsZUZp
bGVIYW5kbGU7Ci0JX19sZTY0IFNvdXJjZUZpbGVPZmZzZXQ7Ci0JX19sZTY0IFRhcmdldEZpbGVP
ZmZzZXQ7Ci0JX19sZTY0IEJ5dGVDb3VudDsgIC8qIEJ5dGVzIHRvIGJlIGNvcGllZCAqLwotfSBf
X3BhY2tlZDsKLQotc3RydWN0IHZhbGlkYXRlX25lZ290aWF0ZV9pbmZvX3JlcSB7Ci0JX19sZTMy
IENhcGFiaWxpdGllczsKLQlfX3U4ICAgR3VpZFtTTUIyX0NMSUVOVF9HVUlEX1NJWkVdOwotCV9f
bGUxNiBTZWN1cml0eU1vZGU7Ci0JX19sZTE2IERpYWxlY3RDb3VudDsKLQlfX2xlMTYgRGlhbGVj
dHNbMV07IC8qIGRpYWxlY3QgKHNvbWVkYXkgbWF5YmUgbGlzdCkgY2xpZW50IGFza2VkIGZvciAq
LwotfSBfX3BhY2tlZDsKLQotc3RydWN0IHZhbGlkYXRlX25lZ290aWF0ZV9pbmZvX3JzcCB7Ci0J
X19sZTMyIENhcGFiaWxpdGllczsKLQlfX3U4ICAgR3VpZFtTTUIyX0NMSUVOVF9HVUlEX1NJWkVd
OwotCV9fbGUxNiBTZWN1cml0eU1vZGU7Ci0JX19sZTE2IERpYWxlY3Q7IC8qIERpYWxlY3QgaW4g
dXNlIGZvciB0aGUgY29ubmVjdGlvbiAqLwotfSBfX3BhY2tlZDsKLQogc3RydWN0IHNtYl9zb2Nr
YWRkcl9pbiB7CiAJX19iZTE2IFBvcnQ7CiAJX19iZTMyIElQdjRhZGRyZXNzOwpAQCAtMjY1LDE4
ICsyNDIsNiBAQCBzdHJ1Y3QgZmlsZV9zcGFyc2UgewogCV9fdTgJU2V0U3BhcnNlOwogfSBfX3Bh
Y2tlZDsKIAotc3RydWN0IGZpbGVfemVyb19kYXRhX2luZm9ybWF0aW9uIHsKLQlfX2xlNjQJRmls
ZU9mZnNldDsKLQlfX2xlNjQJQmV5b25kRmluYWxaZXJvOwotfSBfX3BhY2tlZDsKLQotc3RydWN0
IHJlcGFyc2VfZGF0YV9idWZmZXIgewotCV9fbGUzMglSZXBhcnNlVGFnOwotCV9fbGUxNglSZXBh
cnNlRGF0YUxlbmd0aDsKLQlfX3UxNglSZXNlcnZlZDsKLQlfX3U4CURhdGFCdWZmZXJbXTsgLyog
VmFyaWFibGUgTGVuZ3RoICovCi19IF9fcGFja2VkOwotCiAvKiBGSUxFIEluZm8gcmVzcG9uc2Ug
c2l6ZSAqLwogI2RlZmluZSBGSUxFX0RJUkVDVE9SWV9JTkZPUk1BVElPTl9TSVpFICAgICAgIDEK
ICNkZWZpbmUgRklMRV9GVUxMX0RJUkVDVE9SWV9JTkZPUk1BVElPTl9TSVpFICAyCkBAIC0zMzIs
NDkgKzI5NywxMSBAQCBzdHJ1Y3QgZnNfdHlwZV9pbmZvIHsKIAlsb25nCQltYWdpY19udW1iZXI7
CiB9IF9fcGFja2VkOwogCi1zdHJ1Y3Qgc21iMl9vcGxvY2tfYnJlYWsgewotCXN0cnVjdCBzbWIy
X2hkciBoZHI7Ci0JX19sZTE2IFN0cnVjdHVyZVNpemU7IC8qIE11c3QgYmUgMjQgKi8KLQlfX3U4
ICAgT3Bsb2NrTGV2ZWw7Ci0JX191OCAgIFJlc2VydmVkOwotCV9fbGUzMiBSZXNlcnZlZDI7Ci0J
X19sZTY0ICBQZXJzaXN0ZW50RmlkOwotCV9fbGU2NCAgVm9sYXRpbGVGaWQ7Ci19IF9fcGFja2Vk
OwotCi0jZGVmaW5lIFNNQjJfTk9USUZZX0JSRUFLX0xFQVNFX0ZMQUdfQUNLX1JFUVVJUkVEIGNw
dV90b19sZTMyKDB4MDEpCi0KLXN0cnVjdCBzbWIyX2xlYXNlX2JyZWFrIHsKLQlzdHJ1Y3Qgc21i
Ml9oZHIgaGRyOwotCV9fbGUxNiBTdHJ1Y3R1cmVTaXplOyAvKiBNdXN0IGJlIDQ0ICovCi0JX19s
ZTE2IEVwb2NoOwotCV9fbGUzMiBGbGFnczsKLQlfX3U4ICAgTGVhc2VLZXlbMTZdOwotCV9fbGUz
MiBDdXJyZW50TGVhc2VTdGF0ZTsKLQlfX2xlMzIgTmV3TGVhc2VTdGF0ZTsKLQlfX2xlMzIgQnJl
YWtSZWFzb247Ci0JX19sZTMyIEFjY2Vzc01hc2tIaW50OwotCV9fbGUzMiBTaGFyZU1hc2tIaW50
OwotfSBfX3BhY2tlZDsKLQotc3RydWN0IHNtYjJfbGVhc2VfYWNrIHsKLQlzdHJ1Y3Qgc21iMl9o
ZHIgaGRyOwotCV9fbGUxNiBTdHJ1Y3R1cmVTaXplOyAvKiBNdXN0IGJlIDM2ICovCi0JX19sZTE2
IFJlc2VydmVkOwotCV9fbGUzMiBGbGFnczsKLQlfX3U4ICAgTGVhc2VLZXlbMTZdOwotCV9fbGUz
MiBMZWFzZVN0YXRlOwotCV9fbGU2NCBMZWFzZUR1cmF0aW9uOwotfSBfX3BhY2tlZDsKLQogLyoK
ICAqCVBEVSBxdWVyeSBpbmZvbGV2ZWwgc3RydWN0dXJlIGRlZmluaXRpb25zCiAgKglCQiBjb25z
aWRlciBtb3ZpbmcgdG8gYSBkaWZmZXJlbnQgaGVhZGVyCiAgKi8KIAotI2RlZmluZSBPUF9CUkVB
S19TVFJVQ1RfU0laRV8yMAkJMjQKLSNkZWZpbmUgT1BfQlJFQUtfU1RSVUNUX1NJWkVfMjEJCTM2
Ci0KIHN0cnVjdCBzbWIyX2ZpbGVfYWNjZXNzX2luZm8gewogCV9fbGUzMiBBY2Nlc3NGbGFnczsK
IH0gX19wYWNrZWQ7CmRpZmYgLS1naXQgYS9mcy9zbWJmc19jb21tb24vc21iMnBkdS5oIGIvZnMv
c21iZnNfY29tbW9uL3NtYjJwZHUuaAppbmRleCAxZGVmY2M4ZDZjMmMuLjA1MDdhZWNmYzY2OSAx
MDA2NDQKLS0tIGEvZnMvc21iZnNfY29tbW9uL3NtYjJwZHUuaAorKysgYi9mcy9zbWJmc19jb21t
b24vc21iMnBkdS5oCkBAIC0xMjM4LDYgKzEyMzgsODAgQEAgc3RydWN0IHNtYjJfaW9jdGxfcnNw
IHsKIAlfX3U4ICAgQnVmZmVyW107CiB9IF9fcGFja2VkOwogCisvKiB0aGlzIGdvZXMgaW4gdGhl
IGlvY3RsIGJ1ZmZlciB3aGVuIGRvaW5nIEZTQ1RMX1NFVF9aRVJPX0RBVEEgKi8KK3N0cnVjdCBm
aWxlX3plcm9fZGF0YV9pbmZvcm1hdGlvbiB7CisJX19sZTY0CUZpbGVPZmZzZXQ7CisJX19sZTY0
CUJleW9uZEZpbmFsWmVybzsKK30gX19wYWNrZWQ7CisKKy8qIFJlcGFyc2Ugc3RydWN0dXJlcyAt
IHNlZSBNUy1GU0NDIDIuMS4yICovCisKKy8qIHN0cnVjdCBmc2N0bF9yZXBhcnNlX2luZm9fcmVx
IGlzIGVtcHR5LCBvbmx5IHJlc3BvbnNlIHN0cnVjdHMgKHNlZSBiZWxvdykgKi8KK3N0cnVjdCBy
ZXBhcnNlX2RhdGFfYnVmZmVyIHsKKwlfX2xlMzIJUmVwYXJzZVRhZzsKKwlfX2xlMTYJUmVwYXJz
ZURhdGFMZW5ndGg7CisJX191MTYJUmVzZXJ2ZWQ7CisJX191OAlEYXRhQnVmZmVyW107IC8qIFZh
cmlhYmxlIExlbmd0aCAqLworfSBfX3BhY2tlZDsKKworc3RydWN0IHJlcGFyc2VfZ3VpZF9kYXRh
X2J1ZmZlciB7CisJX19sZTMyCVJlcGFyc2VUYWc7CisJX19sZTE2CVJlcGFyc2VEYXRhTGVuZ3Ro
OworCV9fdTE2CVJlc2VydmVkOworCV9fdTgJUmVwYXJzZUd1aWRbMTZdOworCV9fdTgJRGF0YUJ1
ZmZlcltdOyAvKiBWYXJpYWJsZSBMZW5ndGggKi8KK30gX19wYWNrZWQ7CisKK3N0cnVjdCByZXBh
cnNlX21vdW50X3BvaW50X2RhdGFfYnVmZmVyIHsKKwlfX2xlMzIJUmVwYXJzZVRhZzsKKwlfX2xl
MTYJUmVwYXJzZURhdGFMZW5ndGg7CisJX191MTYJUmVzZXJ2ZWQ7CisJX19sZTE2CVN1YnN0aXR1
dGVOYW1lT2Zmc2V0OworCV9fbGUxNglTdWJzdGl0dXRlTmFtZUxlbmd0aDsKKwlfX2xlMTYJUHJp
bnROYW1lT2Zmc2V0OworCV9fbGUxNglQcmludE5hbWVMZW5ndGg7CisJX191OAlQYXRoQnVmZmVy
W107IC8qIFZhcmlhYmxlIExlbmd0aCAqLworfSBfX3BhY2tlZDsKKworI2RlZmluZSBTWU1MSU5L
X0ZMQUdfUkVMQVRJVkUgMHgwMDAwMDAwMQorCitzdHJ1Y3QgcmVwYXJzZV9zeW1saW5rX2RhdGFf
YnVmZmVyIHsKKwlfX2xlMzIJUmVwYXJzZVRhZzsKKwlfX2xlMTYJUmVwYXJzZURhdGFMZW5ndGg7
CisJX191MTYJUmVzZXJ2ZWQ7CisJX19sZTE2CVN1YnN0aXR1dGVOYW1lT2Zmc2V0OworCV9fbGUx
NglTdWJzdGl0dXRlTmFtZUxlbmd0aDsKKwlfX2xlMTYJUHJpbnROYW1lT2Zmc2V0OworCV9fbGUx
NglQcmludE5hbWVMZW5ndGg7CisJX19sZTMyCUZsYWdzOworCV9fdTgJUGF0aEJ1ZmZlcltdOyAv
KiBWYXJpYWJsZSBMZW5ndGggKi8KK30gX19wYWNrZWQ7CisKKy8qIFNlZSBNUy1GU0NDIDIuMS4y
LjYgYW5kIGNpZnNwZHUuaCBmb3Igc3RydWN0IHJlcGFyc2VfcG9zaXhfZGF0YSAqLworCitzdHJ1
Y3QgdmFsaWRhdGVfbmVnb3RpYXRlX2luZm9fcmVxIHsKKwlfX2xlMzIgQ2FwYWJpbGl0aWVzOwor
CV9fdTggICBHdWlkW1NNQjJfQ0xJRU5UX0dVSURfU0laRV07CisJX19sZTE2IFNlY3VyaXR5TW9k
ZTsKKwlfX2xlMTYgRGlhbGVjdENvdW50OworCV9fbGUxNiBEaWFsZWN0c1s0XTsgLyogQkIgZXhw
YW5kIHRoaXMgaWYgYXV0b25lZ290aWF0ZSA+IDQgZGlhbGVjdHMgKi8KK30gX19wYWNrZWQ7CisK
K3N0cnVjdCB2YWxpZGF0ZV9uZWdvdGlhdGVfaW5mb19yc3AgeworCV9fbGUzMiBDYXBhYmlsaXRp
ZXM7CisJX191OCAgIEd1aWRbU01CMl9DTElFTlRfR1VJRF9TSVpFXTsKKwlfX2xlMTYgU2VjdXJp
dHlNb2RlOworCV9fbGUxNiBEaWFsZWN0OyAvKiBEaWFsZWN0IGluIHVzZSBmb3IgdGhlIGNvbm5l
Y3Rpb24gKi8KK30gX19wYWNrZWQ7CisKK3N0cnVjdCBkdXBsaWNhdGVfZXh0ZW50c190b19maWxl
IHsKKwlfX3U2NCBQZXJzaXN0ZW50RmlsZUhhbmRsZTsgLyogc291cmNlIGZpbGUgaGFuZGxlLCBv
cGFxdWUgZW5kaWFubmVzcyAqLworCV9fdTY0IFZvbGF0aWxlRmlsZUhhbmRsZTsKKwlfX2xlNjQg
U291cmNlRmlsZU9mZnNldDsKKwlfX2xlNjQgVGFyZ2V0RmlsZU9mZnNldDsKKwlfX2xlNjQgQnl0
ZUNvdW50OyAgLyogQnl0ZXMgdG8gYmUgY29waWVkICovCit9IF9fcGFja2VkOworCiAvKiBQb3Nz
aWJsZSBJbmZvVHlwZSB2YWx1ZXMgKi8KICNkZWZpbmUgU01CMl9PX0lORk9fRklMRQkweDAxCiAj
ZGVmaW5lIFNNQjJfT19JTkZPX0ZJTEVTWVNURU0JMHgwMgpAQCAtMTQ4OCw0ICsxNTYyLDQzIEBA
IHN0cnVjdCBzbWIzX2ZzX3ZvbF9pbmZvIHsKIAlfX3U4CVJlc2VydmVkOwogCV9fdTgJVm9sdW1l
TGFiZWxbXTsgLyogdmFyaWFibGUgbGVuICovCiB9IF9fcGFja2VkOworCisvKiBTZWUgTVMtU01C
MiAyLjIuMjMgdGhyb3VnaCAyLjIuMjUgKi8KK3N0cnVjdCBzbWIyX29wbG9ja19icmVhayB7CisJ
c3RydWN0IHNtYjJfaGRyIGhkcjsKKwlfX2xlMTYgU3RydWN0dXJlU2l6ZTsgLyogTXVzdCBiZSAy
NCAqLworCV9fdTggICBPcGxvY2tMZXZlbDsKKwlfX3U4ICAgUmVzZXJ2ZWQ7CisJX19sZTMyIFJl
c2VydmVkMjsKKwlfX3U2NCAgUGVyc2lzdGVudEZpZDsKKwlfX3U2NCAgVm9sYXRpbGVGaWQ7Cit9
IF9fcGFja2VkOworCisjZGVmaW5lIFNNQjJfTk9USUZZX0JSRUFLX0xFQVNFX0ZMQUdfQUNLX1JF
UVVJUkVEIGNwdV90b19sZTMyKDB4MDEpCisKK3N0cnVjdCBzbWIyX2xlYXNlX2JyZWFrIHsKKwlz
dHJ1Y3Qgc21iMl9oZHIgaGRyOworCV9fbGUxNiBTdHJ1Y3R1cmVTaXplOyAvKiBNdXN0IGJlIDQ0
ICovCisJX19sZTE2IEVwb2NoOworCV9fbGUzMiBGbGFnczsKKwlfX3U4ICAgTGVhc2VLZXlbMTZd
OworCV9fbGUzMiBDdXJyZW50TGVhc2VTdGF0ZTsKKwlfX2xlMzIgTmV3TGVhc2VTdGF0ZTsKKwlf
X2xlMzIgQnJlYWtSZWFzb247CisJX19sZTMyIEFjY2Vzc01hc2tIaW50OworCV9fbGUzMiBTaGFy
ZU1hc2tIaW50OworfSBfX3BhY2tlZDsKKworc3RydWN0IHNtYjJfbGVhc2VfYWNrIHsKKwlzdHJ1
Y3Qgc21iMl9oZHIgaGRyOworCV9fbGUxNiBTdHJ1Y3R1cmVTaXplOyAvKiBNdXN0IGJlIDM2ICov
CisJX19sZTE2IFJlc2VydmVkOworCV9fbGUzMiBGbGFnczsKKwlfX3U4ICAgTGVhc2VLZXlbMTZd
OworCV9fbGUzMiBMZWFzZVN0YXRlOworCV9fbGU2NCBMZWFzZUR1cmF0aW9uOworfSBfX3BhY2tl
ZDsKKworI2RlZmluZSBPUF9CUkVBS19TVFJVQ1RfU0laRV8yMAkJMjQKKyNkZWZpbmUgT1BfQlJF
QUtfU1RSVUNUX1NJWkVfMjEJCTM2CiAjZW5kaWYJCQkJLyogX0NPTU1PTl9TTUIyUERVX0ggKi8K
LS0gCjIuMzIuMAoK
--000000000000ea169605db4f55ea--
