Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9808B3233AF
	for <lists+linux-cifs@lfdr.de>; Tue, 23 Feb 2021 23:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232029AbhBWWX0 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 23 Feb 2021 17:23:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231978AbhBWWXZ (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 23 Feb 2021 17:23:25 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ED5C061574
        for <linux-cifs@vger.kernel.org>; Tue, 23 Feb 2021 14:22:45 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id q14so74829ljp.4
        for <linux-cifs@vger.kernel.org>; Tue, 23 Feb 2021 14:22:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=d1yC+WVgL2olp+V5fEP8Dv6k11wypUl9Ht9IO+Mjf7Y=;
        b=r+tSLTR1p5RmvWixlpdthyOKPRD25w69Ua3/ulqNnMgIuC6badmLwLZ2jah5IfwMiq
         W6FW3PuxDSEafeZIyJOgEmjj94LSAsHHnklVUk7EaQbm5EF+V1+ZLgBuIADu1GnysTBN
         XpwWe5pU9ncSJ/2d3K7TU/IK828JyEaNwZ4FiP/TXHP5jqwWeqUXJfAiUNQ1xDrw5YQl
         N/okF9HomfKruqmtLw5URcAJ3YHGgsGkE16ZnYuVHF78vqOOk7pZs6JYIG/4GfMods6g
         qBR5gbLxa/FnNpzGGTqqN+HH/y2yYKHUb0L9JAOij2GTHZQsq0tRoiMyl+eNuJXAvseK
         PmIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=d1yC+WVgL2olp+V5fEP8Dv6k11wypUl9Ht9IO+Mjf7Y=;
        b=a2Q3XgExb3TcVTHDL2ylQRm8n8Ao6uM82cyumF2SBZAtMaNQoFhBEbd50YT0y1JJdQ
         iO0++rLUogcw1btWnV93fZwMU4PQ+TrYOEKbs3659F2oPVuwiMtnuG1YLAOsXU5eNio3
         +UM7vczkssdy/vVWVTMxCmwBcyzY3ABJDTvNFPgg/p7/1TioQgs5VFTUnO4W8TeV9G7C
         U8TGHqDCdOV7At7nfI5WVGKfMDiJ9BGvPKLf/mavenYFPNT7kGrQ09jjaE8F23xA/ylv
         swIvYSKHGZA+mbHENBmUcHEUxyu35xUA607iyvUmYI+YwAyD2VO4WuqNc19EMt4oZvwD
         N+dg==
X-Gm-Message-State: AOAM531UrXBqwfe4FO2WIOE5JvNBOvR4C9oUayeXWsSFG/7Z3PQN7FZy
        Up65SrzDwIao/mHsfTAbqA11xGVvmtZ5OppgBmvu7j9D7GC/PA==
X-Google-Smtp-Source: ABdhPJzN3O/k2NY5ppB4kEDMhRssL2AijU3fx7zN2ajkhP99AwpI9nA/J9c/YY4rbo4qnALfaDVNX/gL+6+1XcT1QKQ=
X-Received: by 2002:a2e:7e11:: with SMTP id z17mr1624611ljc.477.1614118963429;
 Tue, 23 Feb 2021 14:22:43 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 23 Feb 2021 16:22:32 -0600
Message-ID: <CAH2r5msdUQ=CVM6s7ENeH7SP-teYAOioOGq7zY5sDXZFrFYiCA@mail.gmail.com>
Subject: [PATCH] convert revalidate of directories to using directory metadata
 cache timeout
To:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="00000000000070e27d05bc085bad"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--00000000000070e27d05bc085bad
Content-Type: text/plain; charset="UTF-8"

nfs and cifs on Linux currently have a mount parameter "actimeo" to
control metadata (attribute) caching but cifs does not have additional
mount parameters to allow distinguishing between caching directory
metadata (e.g. needed to revalidate paths) and that for files.

Add new mount parameter "acdirmax" to allow caching metadata for
directories more loosely than file data.  NFS adjusts metadata
caching from acdirmin to acdirmax (and another two mount parms
for files) but to reduce complexity, it is safer to just introduce
the one mount parm to allow caching directories longer (30 seconds
vs. the 1 second default for file metadata) which is still more
conservative than other Linux filesystems (e.g. NFS sets acdirmax
to 60 seconds)

-- 
Thanks,

Steve

--00000000000070e27d05bc085bad
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-Add-new-mount-parameter-acdirmax-to-allow-cachi.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-Add-new-mount-parameter-acdirmax-to-allow-cachi.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_klikq69g0>
X-Attachment-Id: f_klikq69g0

RnJvbSA1MDVkMjA0MTQ3OWY1NjhjNGY0YjlhMTcwYzQ4NGY4NjZiYzcyYzU3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFR1ZSwgMjMgRmViIDIwMjEgMTU6NTA6NTcgLTA2MDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gY2lmczogQWRkIG5ldyBtb3VudCBwYXJhbWV0ZXIgImFjZGlybWF4IiB0byBhbGxvdyBjYWNo
aW5nCiBkaXJlY3RvcnkgbWV0YWRhdGEKCm5mcyBhbmQgY2lmcyBvbiBMaW51eCBjdXJyZW50bHkg
aGF2ZSBhIG1vdW50IHBhcmFtZXRlciAiYWN0aW1lbyIgdG8gY29udHJvbAptZXRhZGF0YSAoYXR0
cmlidXRlKSBjYWNoaW5nIGJ1dCBjaWZzIGRvZXMgbm90IGhhdmUgYWRkaXRpb25hbCBtb3VudApw
YXJhbWV0ZXJzIHRvIGFsbG93IGRpc3Rpbmd1aXNoaW5nIGJldHdlZW4gY2FjaGluZyBkaXJlY3Rv
cnkgbWV0YWRhdGEKKGUuZy4gbmVlZGVkIHRvIHJldmFsaWRhdGUgcGF0aHMpIGFuZCB0aGF0IGZv
ciBmaWxlcy4KCkFkZCBuZXcgbW91bnQgcGFyYW1ldGVyICJhY2Rpcm1heCIgdG8gYWxsb3cgY2Fj
aGluZyBtZXRhZGF0YSBmb3IKZGlyZWN0b3JpZXMgbW9yZSBsb29zZWx5IHRoYW4gZmlsZSBkYXRh
LiAgTkZTIGFkanVzdHMgbWV0YWRhdGEKY2FjaGluZyBmcm9tIGFjZGlybWluIHRvIGFjZGlybWF4
IChhbmQgYW5vdGhlciB0d28gbW91bnQgcGFybXMKZm9yIGZpbGVzKSBidXQgdG8gcmVkdWNlIGNv
bXBsZXhpdHksIGl0IGlzIHNhZmVyIHRvIGp1c3QgaW50cm9kdWNlCnRoZSBvbmUgbW91bnQgcGFy
bSB0byBhbGxvdyBjYWNoaW5nIGRpcmVjdG9yaWVzIGxvbmdlciAoMzAgc2Vjb25kcwp2cy4gdGhl
IDEgc2Vjb25kIGRlZmF1bHQgZm9yIGZpbGUgbWV0YWRhdGEpIHdoaWNoIGlzIHN0aWxsIG1vcmUK
Y29uc2VydmF0aXZlIHRoYW4gb3RoZXIgTGludXggZmlsZXN5c3RlbXMgKGUuZy4gTkZTIHNldHMg
YWNkaXJtYXgKdG8gNjAgc2Vjb25kcykKClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8c3Rm
cmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9jaWZzL2NpZnNmcy5jICAgICB8IDMgKystCiBm
cy9jaWZzL2NpZnNnbG9iLmggICB8IDggKysrKysrKy0KIGZzL2NpZnMvY29ubmVjdC5jICAgIHwg
MiArKwogZnMvY2lmcy9mc19jb250ZXh0LmMgfCA5ICsrKysrKysrKwogZnMvY2lmcy9mc19jb250
ZXh0LmggfCA0ICsrKy0KIDUgZmlsZXMgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwgMyBkZWxl
dGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9jaWZzL2NpZnNmcy5jIGIvZnMvY2lmcy9jaWZzZnMu
YwppbmRleCA2ZjMzZmYzZjYyNWYuLjRlMGIwYjI2ZTg0NCAxMDA2NDQKLS0tIGEvZnMvY2lmcy9j
aWZzZnMuYworKysgYi9mcy9jaWZzL2NpZnNmcy5jCkBAIC02MzcsOCArNjM3LDkgQEAgY2lmc19z
aG93X29wdGlvbnMoc3RydWN0IHNlcV9maWxlICpzLCBzdHJ1Y3QgZGVudHJ5ICpyb290KQogCQlz
ZXFfcHJpbnRmKHMsICIsc25hcHNob3Q9JWxsdSIsIHRjb24tPnNuYXBzaG90X3RpbWUpOwogCWlm
ICh0Y29uLT5oYW5kbGVfdGltZW91dCkKIAkJc2VxX3ByaW50ZihzLCAiLGhhbmRsZXRpbWVvdXQ9
JXUiLCB0Y29uLT5oYW5kbGVfdGltZW91dCk7Ci0JLyogY29udmVydCBhY3RpbWVvIGFuZCBkaXNw
bGF5IGl0IGluIHNlY29uZHMgKi8KKwkvKiBjb252ZXJ0IGFjdGltZW8gYW5kIGRpcmVjdG9yeSBh
dHRyaWJ1dGUgdGltZW91dCBhbmQgZGlzcGxheSBpbiBzZWNvbmRzICovCiAJc2VxX3ByaW50Zihz
LCAiLGFjdGltZW89JWx1IiwgY2lmc19zYi0+Y3R4LT5hY3RpbWVvIC8gSFopOworCXNlcV9wcmlu
dGYocywgIixhY2Rpcm1heD0lbHUiLCBjaWZzX3NiLT5jdHgtPmFjZGlybWF4IC8gSFopOwogCiAJ
aWYgKHRjb24tPnNlcy0+Y2hhbl9tYXggPiAxKQogCQlzZXFfcHJpbnRmKHMsICIsbXVsdGljaGFu
bmVsLG1heF9jaGFubmVscz0lenUiLApkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzZ2xvYi5oIGIv
ZnMvY2lmcy9jaWZzZ2xvYi5oCmluZGV4IDNkZTNjNTkwOGE3Mi4uOWExNGY2ZjZlYmQ4IDEwMDY0
NAotLS0gYS9mcy9jaWZzL2NpZnNnbG9iLmgKKysrIGIvZnMvY2lmcy9jaWZzZ2xvYi5oCkBAIC01
MCwxMSArNTAsMTcgQEAKICNkZWZpbmUgQ0lGU19NSU5fUkNWX1BPT0wgNAogCiAjZGVmaW5lIE1B
WF9SRU9QRU5fQVRUCTUgLyogdGhlc2UgbWFueSBtYXhpbXVtIGF0dGVtcHRzIHRvIHJlb3BlbiBh
IGZpbGUgKi8KKwogLyoKLSAqIGRlZmF1bHQgYXR0cmlidXRlIGNhY2hlIHRpbWVvdXQgKGppZmZp
ZXMpCisgKiBkZWZhdWx0IGF0dHJpYnV0ZSBjYWNoZSB0aW1lb3V0IGZvciBmaWxlcyAoamlmZmll
cykKICAqLwogI2RlZmluZSBDSUZTX0RFRl9BQ1RJTUVPICgxICogSFopCiAKKy8qCisgKiBkZWZh
dWx0IGF0dHJpYnV0ZSBjYWNoZSB0aW1lb3V0IGZvciBkaXJlY3RvcmllcyAoamlmZmllcykKKyAq
LworI2RlZmluZSBDSUZTX0RFRl9BQ0RJUk1BWCAoMzAgKiBIWikKKwogLyoKICAqIG1heCBhdHRy
aWJ1dGUgY2FjaGUgdGltZW91dCAoamlmZmllcykgLSAyXjMwCiAgKi8KZGlmZiAtLWdpdCBhL2Zz
L2NpZnMvY29ubmVjdC5jIGIvZnMvY2lmcy9jb25uZWN0LmMKaW5kZXggY2Q2ZGJlYWYyMTY2Li5h
OWRjMzlhZWU5ZjQgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvY29ubmVjdC5jCisrKyBiL2ZzL2NpZnMv
Y29ubmVjdC5jCkBAIC0yMjc4LDYgKzIyNzgsOCBAQCBjb21wYXJlX21vdW50X29wdGlvbnMoc3Ry
dWN0IHN1cGVyX2Jsb2NrICpzYiwgc3RydWN0IGNpZnNfbW50X2RhdGEgKm1udF9kYXRhKQogCiAJ
aWYgKG9sZC0+Y3R4LT5hY3RpbWVvICE9IG5ldy0+Y3R4LT5hY3RpbWVvKQogCQlyZXR1cm4gMDsK
KwlpZiAob2xkLT5jdHgtPmFjZGlybWF4ICE9IG5ldy0+Y3R4LT5hY2Rpcm1heCkKKwkJcmV0dXJu
IDA7CiAKIAlyZXR1cm4gMTsKIH0KZGlmZiAtLWdpdCBhL2ZzL2NpZnMvZnNfY29udGV4dC5jIGIv
ZnMvY2lmcy9mc19jb250ZXh0LmMKaW5kZXggN2QwNGYyMjU1NjI0Li41NTU5NjljOGQ1ODYgMTAw
NjQ0Ci0tLSBhL2ZzL2NpZnMvZnNfY29udGV4dC5jCisrKyBiL2ZzL2NpZnMvZnNfY29udGV4dC5j
CkBAIC0xNDAsNiArMTQwLDcgQEAgY29uc3Qgc3RydWN0IGZzX3BhcmFtZXRlcl9zcGVjIHNtYjNf
ZnNfcGFyYW1ldGVyc1tdID0gewogCWZzcGFyYW1fdTMyKCJyc2l6ZSIsIE9wdF9yc2l6ZSksCiAJ
ZnNwYXJhbV91MzIoIndzaXplIiwgT3B0X3dzaXplKSwKIAlmc3BhcmFtX3UzMigiYWN0aW1lbyIs
IE9wdF9hY3RpbWVvKSwKKwlmc3BhcmFtX3UzMigiYWNkaXJtYXgiLCBPcHRfYWNkaXJtYXgpLAog
CWZzcGFyYW1fdTMyKCJlY2hvX2ludGVydmFsIiwgT3B0X2VjaG9faW50ZXJ2YWwpLAogCWZzcGFy
YW1fdTMyKCJtYXhfY3JlZGl0cyIsIE9wdF9tYXhfY3JlZGl0cyksCiAJZnNwYXJhbV91MzIoImhh
bmRsZXRpbWVvdXQiLCBPcHRfaGFuZGxldGltZW91dCksCkBAIC05MzYsNiArOTM3LDEzIEBAIHN0
YXRpYyBpbnQgc21iM19mc19jb250ZXh0X3BhcnNlX3BhcmFtKHN0cnVjdCBmc19jb250ZXh0ICpm
YywKIAkJCWdvdG8gY2lmc19wYXJzZV9tb3VudF9lcnI7CiAJCX0KIAkJYnJlYWs7CisJY2FzZSBP
cHRfYWNkaXJtYXg6CisJCWN0eC0+YWNkaXJtYXggPSBIWiAqIHJlc3VsdC51aW50XzMyOworCQlp
ZiAoY3R4LT5hY2Rpcm1heCA+IENJRlNfTUFYX0FDVElNRU8pIHsKKwkJCWNpZnNfZGJnKFZGUywg
ImFjZGlybWF4IHRvbyBsYXJnZVxuIik7CisJCQlnb3RvIGNpZnNfcGFyc2VfbW91bnRfZXJyOwor
CQl9CisJCWJyZWFrOwogCWNhc2UgT3B0X2VjaG9faW50ZXJ2YWw6CiAJCWN0eC0+ZWNob19pbnRl
cnZhbCA9IHJlc3VsdC51aW50XzMyOwogCQlicmVhazsKQEAgLTEzNjIsNiArMTM3MCw3IEBAIGlu
dCBzbWIzX2luaXRfZnNfY29udGV4dChzdHJ1Y3QgZnNfY29udGV4dCAqZmMpCiAJY3R4LT5zdHJp
Y3RfaW8gPSB0cnVlOwogCiAJY3R4LT5hY3RpbWVvID0gQ0lGU19ERUZfQUNUSU1FTzsKKwljdHgt
PmFjZGlybWF4ID0gQ0lGU19ERUZfQUNESVJNQVg7CiAKIAkvKiBNb3N0IGNsaWVudHMgc2V0IHRp
bWVvdXQgdG8gMCwgYWxsb3dzIHNlcnZlciB0byB1c2UgaXRzIGRlZmF1bHQgKi8KIAljdHgtPmhh
bmRsZV90aW1lb3V0ID0gMDsgLyogU2VlIE1TLVNNQjIgc3BlYyBzZWN0aW9uIDIuMi4xNC4yLjEy
ICovCmRpZmYgLS1naXQgYS9mcy9jaWZzL2ZzX2NvbnRleHQuaCBiL2ZzL2NpZnMvZnNfY29udGV4
dC5oCmluZGV4IDFjNDRhNDYwZTJjMC4uNDcyMzcyZmVjNGU5IDEwMDY0NAotLS0gYS9mcy9jaWZz
L2ZzX2NvbnRleHQuaAorKysgYi9mcy9jaWZzL2ZzX2NvbnRleHQuaApAQCAtMTE4LDYgKzExOCw3
IEBAIGVudW0gY2lmc19wYXJhbSB7CiAJT3B0X3JzaXplLAogCU9wdF93c2l6ZSwKIAlPcHRfYWN0
aW1lbywKKwlPcHRfYWNkaXJtYXgsCiAJT3B0X2VjaG9faW50ZXJ2YWwsCiAJT3B0X21heF9jcmVk
aXRzLAogCU9wdF9zbmFwc2hvdCwKQEAgLTIzMiw3ICsyMzMsOCBAQCBzdHJ1Y3Qgc21iM19mc19j
b250ZXh0IHsKIAl1bnNpZ25lZCBpbnQgd3NpemU7CiAJdW5zaWduZWQgaW50IG1pbl9vZmZsb2Fk
OwogCWJvb2wgc29ja29wdF90Y3Bfbm9kZWxheToxOwotCXVuc2lnbmVkIGxvbmcgYWN0aW1lbzsg
LyogYXR0cmlidXRlIGNhY2hlIHRpbWVvdXQgKGppZmZpZXMpICovCisJdW5zaWduZWQgbG9uZyBh
Y3RpbWVvOyAvKiBhdHRyaWJ1dGUgY2FjaGUgdGltZW91dCBmb3IgZmlsZXMgKGppZmZpZXMpICov
CisJdW5zaWduZWQgbG9uZyBhY2Rpcm1heDsgLyogYXR0cmlidXRlIGNhY2hlIHRpbWVvdXQgZm9y
IGRpcmVjdG9yaWVzIChqaWZmaWVzKSAqLwogCXN0cnVjdCBzbWJfdmVyc2lvbl9vcGVyYXRpb25z
ICpvcHM7CiAJc3RydWN0IHNtYl92ZXJzaW9uX3ZhbHVlcyAqdmFsczsKIAljaGFyICpwcmVwYXRo
OwotLSAKMi4yNy4wCgo=
--00000000000070e27d05bc085bad
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-cifs-convert-revalidate-of-directories-to-using-dire.patch"
Content-Disposition: attachment; 
	filename="0002-cifs-convert-revalidate-of-directories-to-using-dire.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_klikq69t1>
X-Attachment-Id: f_klikq69t1

RnJvbSA3OWY3MzFlMTQ1NTliZTU3ZDQ4NjQ3ZDIyMjgzYjkzNjAwY2FmMTkyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFR1ZSwgMjMgRmViIDIwMjEgMTY6MTY6MDkgLTA2MDAKU3ViamVjdDogW1BBVENIIDIv
Ml0gY2lmczogY29udmVydCByZXZhbGlkYXRlIG9mIGRpcmVjdG9yaWVzIHRvIHVzaW5nCiBkaXJl
Y3RvcnkgbWV0YWRhdGEgY2FjaGUgdGltZW91dAoKVGhlIG5ldyBvcHRpb25hbCBtb3VudCBwYXJt
LCAiYWNkaXJtYXgiIGFsbG93cyBjYWNoaW5nIHRoZSBtZXRhZGF0YQpmb3IgYSBkaXJlY3Rvcnkg
bG9uZ2VyIHRoYW4gZmlsZSBtZXRhZGF0YSwgd2hpY2ggY2FuIGJlIHZlcnkgaGVscGZ1bApmb3Ig
cGVyZm9ybWFuY2UuICBDb252ZXJ0IGNpZnNfaW5vZGVfbmVlZHNfcmV2YWwgdG8gY2hlY2sgYWNk
aXJtYXgKZm9yIHJldmFsaWRhdGluZyBkaXJlY3RvcnkgbWV0YWRhdGEgKGFjdGltZW8gaXMgY2hl
Y2tlZCBmb3IgZmlsZXMpCgpTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1p
Y3Jvc29mdC5jb20+Ci0tLQogZnMvY2lmcy9pbm9kZS5jIHwgMjMgKysrKysrKysrKysrKysrKyst
LS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxNyBpbnNlcnRpb25zKCspLCA2IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2ZzL2NpZnMvaW5vZGUuYyBiL2ZzL2NpZnMvaW5vZGUuYwppbmRleCBhODNi
M2E4ZmZhYWMuLmNmZDMxY2M0NTIwZiAxMDA2NDQKLS0tIGEvZnMvY2lmcy9pbm9kZS5jCisrKyBi
L2ZzL2NpZnMvaW5vZGUuYwpAQCAtMjE5OCwxMiArMjE5OCwyMyBAQCBjaWZzX2lub2RlX25lZWRz
X3JldmFsKHN0cnVjdCBpbm9kZSAqaW5vZGUpCiAJaWYgKCFsb29rdXBDYWNoZUVuYWJsZWQpCiAJ
CXJldHVybiB0cnVlOwogCi0JaWYgKCFjaWZzX3NiLT5jdHgtPmFjdGltZW8pCi0JCXJldHVybiB0
cnVlOwotCi0JaWYgKCF0aW1lX2luX3JhbmdlKGppZmZpZXMsIGNpZnNfaS0+dGltZSwKLQkJCQlj
aWZzX2ktPnRpbWUgKyBjaWZzX3NiLT5jdHgtPmFjdGltZW8pKQotCQlyZXR1cm4gdHJ1ZTsKKwkv
KgorCSAqIGRlcGVuZGluZyBvbiBpbm9kZSB0eXBlLCBjaGVjayBpZiBhdHRyaWJ1dGUgY2FjaGlu
ZyBkaXNhYmxlZCBmb3IKKwkgKiBmaWxlcyBvciBkaXJlY3RvcmllcworCSAqLworCWlmIChTX0lT
RElSKGlub2RlLT5pX21vZGUpKSB7CisJCWlmICghY2lmc19zYi0+Y3R4LT5hY2Rpcm1heCkKKwkJ
CXJldHVybiB0cnVlOworCQlpZiAoIXRpbWVfaW5fcmFuZ2UoamlmZmllcywgY2lmc19pLT50aW1l
LAorCQkJCSAgIGNpZnNfaS0+dGltZSArIGNpZnNfc2ItPmN0eC0+YWNkaXJtYXgpKQorCQkJcmV0
dXJuIHRydWU7CisJfSBlbHNlIHsgLyogZmlsZSAqLworCQlpZiAoIWNpZnNfc2ItPmN0eC0+YWN0
aW1lbykKKwkJCXJldHVybiB0cnVlOworCQlpZiAoIXRpbWVfaW5fcmFuZ2UoamlmZmllcywgY2lm
c19pLT50aW1lLAorCQkJCSAgIGNpZnNfaS0+dGltZSArIGNpZnNfc2ItPmN0eC0+YWN0aW1lbykp
CisJCQlyZXR1cm4gdHJ1ZTsKKwl9CiAKIAkvKiBoYXJkbGlua2VkIGZpbGVzIHcvIG5vc2VydmVy
aW5vIGdldCAic3BlY2lhbCIgdHJlYXRtZW50ICovCiAJaWYgKCEoY2lmc19zYi0+bW50X2NpZnNf
ZmxhZ3MgJiBDSUZTX01PVU5UX1NFUlZFUl9JTlVNKSAmJgotLSAKMi4yNy4wCgo=
--00000000000070e27d05bc085bad--
