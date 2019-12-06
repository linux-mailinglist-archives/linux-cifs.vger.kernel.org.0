Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 05B80114D44
	for <lists+linux-cifs@lfdr.de>; Fri,  6 Dec 2019 09:10:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726834AbfLFIKq (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 6 Dec 2019 03:10:46 -0500
Received: from mail-il1-f173.google.com ([209.85.166.173]:42677 "EHLO
        mail-il1-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfLFIKp (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 6 Dec 2019 03:10:45 -0500
Received: by mail-il1-f173.google.com with SMTP id f6so5491037ilh.9
        for <linux-cifs@vger.kernel.org>; Fri, 06 Dec 2019 00:10:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=2L7B9rZLyYkKDZCJtQnFjmIh5/ggROBQ1sDIllD+XxY=;
        b=oUpnf9eD3SIiLEe1Lg9XZNnP3IjizqumAdiAdwdd7AMuqaNfz3qtMnqOENLHdVAkxJ
         H/9f1SUiamzkf6iJTsO4stdIiMc1TvO8en1nJfnOrIDljgNKx7Nt/rs83LbQPjMaGpCI
         pYXxJUHwjOugf+e1m7NYxVA6tpH5rMjTth7hol/SUUUpmiL67YuXAqRDOBDjnZqJ2RxG
         b2zvkm79h3qpxvmi/qqaz5jPAAm9Iv6urplPZdkGURVBMrOZqh0SIOJhFju7Qk8y1vNX
         3wniumGA5yZp0nnX1dnLtEMYvKpfgR37OGZAVI1xh1C0HeJ3VIdVg0rBSVrXPNOyL04A
         vGtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=2L7B9rZLyYkKDZCJtQnFjmIh5/ggROBQ1sDIllD+XxY=;
        b=kgEfmtkWpUXkX1mcAH8bHzzBn/lZ6HsmXrEER3KVmKkI18zm97kVUYsxdfDtdwmzws
         wX5XwkaiwPUESnAuKAQd6bK07M6YeeTmsozOGYNA2L3OY5fdGu71ZUye6lLOZ1kiGavB
         /NVncrXeqNH58i/BZvR5WNl3pywXbXyiVAXfbKvWvoPrhL+I4blAaRAyy1FbOY7f/TVy
         pK2laqysbaOn/4Ej6esmG1qck8btyDl1BkvJd82/xtXlSUUWViVREnEF8nzY2AETcicK
         XHqMLRfOyBUJOiBngheoAk/RUZQypB/9tU8LhOi6qjSzgMYDXgPJvqYjiEL7PwOg4hv1
         y1Gg==
X-Gm-Message-State: APjAAAVxjkygdzUeLSK15dN3k2zp6xUO06JBswYsX/c3AsbuhwUcDLVy
        MZtDgHeC7mkvKD1acp9OljWFAmftbaWxz+IzbsrVH0ff
X-Google-Smtp-Source: APXvYqzN9feCZuaDnv7ve46k9eQ3KwCW3Iel9lC7ayUlOSQUOazijOCsZj1xuofjICnXXOSC9SKRVz6+BYfEbzNtLMU=
X-Received: by 2002:a92:3dd0:: with SMTP id k77mr13069416ilf.3.1575619844076;
 Fri, 06 Dec 2019 00:10:44 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 6 Dec 2019 02:10:33 -0600
Message-ID: <CAH2r5mtKatPDSLv2G+ifeo9JZj3-=QAe9eDOPmtOKPObZiu3jQ@mail.gmail.com>
Subject: [PATCH] SMB3 pass in mode bits in sd context on SMB3 create when
 "modefromsid" mounts
To:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="0000000000001b93710599049558"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--0000000000001b93710599049558
Content-Type: text/plain; charset="UTF-8"

When using the special SID to store the mode bits in an ACE (See
http://technet.microsoft.com/en-us/library/hh509017(v=ws.10).aspx)
which is enabled with mount parm "modefromsid" we were not
passing in the mode via SMB3 create (although chmod was enabled).
SMB3 create allows a security descriptor context to be passed
in (which is more atomic and thus preferable to setting the mode
bits after create via a setinfo).

This patch enables setting the mode bits on create when using
modefromsid mount option.  In addition it fixes an endian
error in the definition of the Control field flags in the SMB3
security descriptor.

-- 
Thanks,

Steve

--0000000000001b93710599049558
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb3-fix-mode-passed-in-on-create-for-modetosid-moun.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-fix-mode-passed-in-on-create-for-modetosid-moun.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k3tvd5th0>
X-Attachment-Id: f_k3tvd5th0

RnJvbSBjMzFjYzliM2I4YjcyYmUzOTA0ZTgyYTc0NWQ1NjA4OWRhYTY0M2IzIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IEZyaSwgNiBEZWMgMjAxOSAwMjowMjozOCAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIHNt
YjM6IGZpeCBtb2RlIHBhc3NlZCBpbiBvbiBjcmVhdGUgZm9yIG1vZGV0b3NpZCBtb3VudCBvcHRp
b24KCldoZW4gdXNpbmcgdGhlIHNwZWNpYWwgU0lEIHRvIHN0b3JlIHRoZSBtb2RlIGJpdHMgaW4g
YW4gQUNFIChTZWUKaHR0cDovL3RlY2huZXQubWljcm9zb2Z0LmNvbS9lbi11cy9saWJyYXJ5L2ho
NTA5MDE3KHY9d3MuMTApLmFzcHgpCndoaWNoIGlzIGVuYWJsZWQgd2l0aCBtb3VudCBwYXJtICJt
b2RlZnJvbXNpZCIgd2Ugd2VyZSBub3QKcGFzc2luZyBpbiB0aGUgbW9kZSB2aWEgU01CMyBjcmVh
dGUgKGFsdGhvdWdoIGNobW9kIHdhcyBlbmFibGVkKS4KU01CMyBjcmVhdGUgYWxsb3dzIGEgc2Vj
dXJpdHkgZGVzY3JpcHRvciBjb250ZXh0IHRvIGJlIHBhc3NlZAppbiAod2hpY2ggaXMgbW9yZSBh
dG9taWMgYW5kIHRodXMgcHJlZmVyYWJsZSB0byBzZXR0aW5nIHRoZSBtb2RlCmJpdHMgYWZ0ZXIg
Y3JlYXRlIHZpYSBhIHNldGluZm8pLgoKVGhpcyBwYXRjaCBlbmFibGVzIHNldHRpbmcgdGhlIG1v
ZGUgYml0cyBvbiBjcmVhdGUgd2hlbiB1c2luZwptb2RlZnJvbXNpZCBtb3VudCBvcHRpb24uICBJ
biBhZGRpdGlvbiBpdCBmaXhlcyBhbiBlbmRpYW4KZXJyb3IgaW4gdGhlIGRlZmluaXRpb24gb2Yg
dGhlIENvbnRyb2wgZmllbGQgZmxhZ3MgaW4gdGhlIFNNQjMKc2VjdXJpdHkgZGVzY3JpcHRvci4K
ClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0t
CiBmcy9jaWZzL2NpZnNhY2wuYyAgIHwgNDIgKysrKysrKysrKysrKysrKy0tLS0tLS0tLS0KIGZz
L2NpZnMvY2lmc2FjbC5oICAgfCAzMiArKysrKysrKysrLS0tLS0tLS0tLQogZnMvY2lmcy9jaWZz
cHJvdG8uaCB8ICAxICsKIGZzL2NpZnMvc21iMnBkdS5jICAgfCA3MiArKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLS0KIGZzL2NpZnMvc21iMnBkdS5oICAgfCAxMCAr
KysrKysrCiA1IGZpbGVzIGNoYW5nZWQsIDEyMyBpbnNlcnRpb25zKCspLCAzNCBkZWxldGlvbnMo
LSkKCmRpZmYgLS1naXQgYS9mcy9jaWZzL2NpZnNhY2wuYyBiL2ZzL2NpZnMvY2lmc2FjbC5jCmlu
ZGV4IDA2ZmZlNTJiZGNmYS4uODlkMGRlZDU0YjhkIDEwMDY0NAotLS0gYS9mcy9jaWZzL2NpZnNh
Y2wuYworKysgYi9mcy9jaWZzL2NpZnNhY2wuYwpAQCAtODAyLDYgKzgwMiwzMSBAQCBzdGF0aWMg
dm9pZCBwYXJzZV9kYWNsKHN0cnVjdCBjaWZzX2FjbCAqcGRhY2wsIGNoYXIgKmVuZF9vZl9hY2ws
CiAJcmV0dXJuOwogfQogCisvKgorICogRmlsbCBpbiB0aGUgc3BlY2lhbCBTSUQgYmFzZWQgb24g
dGhlIG1vZGUuIFNlZQorICogaHR0cDovL3RlY2huZXQubWljcm9zb2Z0LmNvbS9lbi11cy9saWJy
YXJ5L2hoNTA5MDE3KHY9d3MuMTApLmFzcHgKKyAqLwordW5zaWduZWQgaW50IHNldHVwX3NwZWNp
YWxfbW9kZV9BQ0Uoc3RydWN0IGNpZnNfYWNlICpwbnRhY2UsIF9fdTY0IG5tb2RlKQoreworCWlu
dCBpOworCXVuc2lnbmVkIGludCBhY2Vfc2l6ZSA9IDI4OworCisJcG50YWNlLT50eXBlID0gQUND
RVNTX0FMTE9XRUQ7CisJcG50YWNlLT5mbGFncyA9IDB4MDsKKwlwbnRhY2UtPmFjY2Vzc19yZXEg
PSAwOworCXBudGFjZS0+c2lkLm51bV9zdWJhdXRoID0gMzsKKwlwbnRhY2UtPnNpZC5yZXZpc2lv
biA9IDE7CisJZm9yIChpID0gMDsgaSA8IE5VTV9BVVRIUzsgaSsrKQorCQlwbnRhY2UtPnNpZC5h
dXRob3JpdHlbaV0gPSBzaWRfdW5peF9ORlNfbW9kZS5hdXRob3JpdHlbaV07CisKKwlwbnRhY2Ut
PnNpZC5zdWJfYXV0aFswXSA9IHNpZF91bml4X05GU19tb2RlLnN1Yl9hdXRoWzBdOworCXBudGFj
ZS0+c2lkLnN1Yl9hdXRoWzFdID0gc2lkX3VuaXhfTkZTX21vZGUuc3ViX2F1dGhbMV07CisJcG50
YWNlLT5zaWQuc3ViX2F1dGhbMl0gPSBjcHVfdG9fbGUzMihubW9kZSAmIDA3Nzc3KTsKKworCS8q
IHNpemUgPSAxICsgMSArIDIgKyA0ICsgMSArIDEgKyA2ICsgKHBzaWQtPm51bV9zdWJhdXRoKjQp
ICovCisJcG50YWNlLT5zaXplID0gY3B1X3RvX2xlMTYoYWNlX3NpemUpOworCXJldHVybiBhY2Vf
c2l6ZTsKK30KIAogc3RhdGljIGludCBzZXRfY2htb2RfZGFjbChzdHJ1Y3QgY2lmc19hY2wgKnBu
ZGFjbCwgc3RydWN0IGNpZnNfc2lkICpwb3duZXJzaWQsCiAJCQlzdHJ1Y3QgY2lmc19zaWQgKnBn
cnBzaWQsIF9fdTY0IG5tb2RlLCBib29sIG1vZGVmcm9tc2lkKQpAQCAtODE1LDIzICs4NDAsOCBA
QCBzdGF0aWMgaW50IHNldF9jaG1vZF9kYWNsKHN0cnVjdCBjaWZzX2FjbCAqcG5kYWNsLCBzdHJ1
Y3QgY2lmc19zaWQgKnBvd25lcnNpZCwKIAlpZiAobW9kZWZyb21zaWQpIHsKIAkJc3RydWN0IGNp
ZnNfYWNlICpwbnRhY2UgPQogCQkJKHN0cnVjdCBjaWZzX2FjZSAqKSgoY2hhciAqKXBubmRhY2wg
KyBzaXplKTsKLQkJaW50IGk7CiAKLQkJcG50YWNlLT50eXBlID0gQUNDRVNTX0FMTE9XRUQ7Ci0J
CXBudGFjZS0+ZmxhZ3MgPSAweDA7Ci0JCXBudGFjZS0+YWNjZXNzX3JlcSA9IDA7Ci0JCXBudGFj
ZS0+c2lkLm51bV9zdWJhdXRoID0gMzsKLQkJcG50YWNlLT5zaWQucmV2aXNpb24gPSAxOwotCQlm
b3IgKGkgPSAwOyBpIDwgTlVNX0FVVEhTOyBpKyspCi0JCQlwbnRhY2UtPnNpZC5hdXRob3JpdHlb
aV0gPQotCQkJCXNpZF91bml4X05GU19tb2RlLmF1dGhvcml0eVtpXTsKLQkJcG50YWNlLT5zaWQu
c3ViX2F1dGhbMF0gPSBzaWRfdW5peF9ORlNfbW9kZS5zdWJfYXV0aFswXTsKLQkJcG50YWNlLT5z
aWQuc3ViX2F1dGhbMV0gPSBzaWRfdW5peF9ORlNfbW9kZS5zdWJfYXV0aFsxXTsKLQkJcG50YWNl
LT5zaWQuc3ViX2F1dGhbMl0gPSBjcHVfdG9fbGUzMihubW9kZSAmIDA3Nzc3KTsKLQotCQkvKiBz
aXplID0gMSArIDEgKyAyICsgNCArIDEgKyAxICsgNiArIChwc2lkLT5udW1fc3ViYXV0aCo0KSAq
LwotCQlwbnRhY2UtPnNpemUgPSBjcHVfdG9fbGUxNigyOCk7Ci0JCXNpemUgKz0gMjg7CisJCXNp
emUgKz0gc2V0dXBfc3BlY2lhbF9tb2RlX0FDRShwbnRhY2UsIG5tb2RlKTsKIAkJbnVtX2FjZXMr
KzsKIAl9CiAKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY2lmc2FjbC5oIGIvZnMvY2lmcy9jaWZzYWNs
LmgKaW5kZXggNDM5Yjk5Y2VmZWIwLi4yMWQ3ZGVlOThkMDEgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMv
Y2lmc2FjbC5oCisrKyBiL2ZzL2NpZnMvY2lmc2FjbC5oCkBAIC0xNDcsMjIgKzE0NywyMiBAQCBz
dHJ1Y3Qgc21iM19zZCB7CiB9IF9fcGFja2VkOwogCiAvKiBNZWFuaW5nIG9mICdDb250cm9sJyBm
aWVsZCBmbGFncyAqLwotI2RlZmluZSBBQ0xfQ09OVFJPTF9TUgkweDAwMDEJLyogU2VsZiByZWxh
dGl2ZSAqLwotI2RlZmluZSBBQ0xfQ09OVFJPTF9STQkweDAwMDIJLyogUmVzb3VyY2UgbWFuYWdl
ciBjb250cm9sIGJpdHMgKi8KLSNkZWZpbmUgQUNMX0NPTlRST0xfUFMJMHgwMDA0CS8qIFNBQ0wg
cHJvdGVjdGVkIGZyb20gaW5oZXJpdHMgKi8KLSNkZWZpbmUgQUNMX0NPTlRST0xfUEQJMHgwMDA4
CS8qIERBQ0wgcHJvdGVjdGVkIGZyb20gaW5oZXJpdHMgKi8KLSNkZWZpbmUgQUNMX0NPTlRST0xf
U0kJMHgwMDEwCS8qIFNBQ0wgQXV0by1Jbmhlcml0ZWQgKi8KLSNkZWZpbmUgQUNMX0NPTlRST0xf
REkJMHgwMDIwCS8qIERBQ0wgQXV0by1Jbmhlcml0ZWQgKi8KLSNkZWZpbmUgQUNMX0NPTlRST0xf
U0MJMHgwMDQwCS8qIFNBQ0wgY29tcHV0ZWQgdGhyb3VnaCBpbmhlcml0YW5jZSAqLwotI2RlZmlu
ZSBBQ0xfQ09OVFJPTF9EQwkweDAwODAJLyogREFDTCBjb21wdXRlZCB0aHJvdWdoIGluaGVyaXRl
bmNlICovCi0jZGVmaW5lIEFDTF9DT05UUk9MX1NTCTB4MDEwMAkvKiBDcmVhdGUgc2VydmVyIEFD
TCAqLwotI2RlZmluZSBBQ0xfQ09OVFJPTF9EVAkweDAyMDAJLyogREFDTCBwcm92aWRlZCBieSB0
cnVzdGVlZCBzb3VyY2UgKi8KLSNkZWZpbmUgQUNMX0NPTlRST0xfU0QJMHgwNDAwCS8qIFNBQ0wg
ZGVmYXVsdGVkICovCi0jZGVmaW5lIEFDTF9DT05UUk9MX1NQCTB4MDgwMAkvKiBTQUNMIGlzIHBy
ZXNlbnQgb24gb2JqZWN0ICovCi0jZGVmaW5lIEFDTF9DT05UUk9MX0RECTB4MTAwMAkvKiBEQUNM
IGRlZmF1bHRlZCAqLwotI2RlZmluZSBBQ0xfQ09OVFJPTF9EUAkweDIwMDAJLyogREFDTCBpcyBw
cmVzZW50IG9uIG9iamVjdCAqLwotI2RlZmluZSBBQ0xfQ09OVFJPTF9HRAkweDQwMDAJLyogR3Jv
dXAgd2FzIGRlZmF1bHRlZCAqLwotI2RlZmluZSBBQ0xfQ09OVFJPTF9PRAkweDgwMDAJLyogVXNl
ciB3YXMgZGVmYXVsdGVkICovCisjZGVmaW5lIEFDTF9DT05UUk9MX1NSCTB4ODAwMAkvKiBTZWxm
IHJlbGF0aXZlICovCisjZGVmaW5lIEFDTF9DT05UUk9MX1JNCTB4NDAwMAkvKiBSZXNvdXJjZSBt
YW5hZ2VyIGNvbnRyb2wgYml0cyAqLworI2RlZmluZSBBQ0xfQ09OVFJPTF9QUwkweDIwMDAJLyog
U0FDTCBwcm90ZWN0ZWQgZnJvbSBpbmhlcml0cyAqLworI2RlZmluZSBBQ0xfQ09OVFJPTF9QRAkw
eDEwMDAJLyogREFDTCBwcm90ZWN0ZWQgZnJvbSBpbmhlcml0cyAqLworI2RlZmluZSBBQ0xfQ09O
VFJPTF9TSQkweDA4MDAJLyogU0FDTCBBdXRvLUluaGVyaXRlZCAqLworI2RlZmluZSBBQ0xfQ09O
VFJPTF9ESQkweDA0MDAJLyogREFDTCBBdXRvLUluaGVyaXRlZCAqLworI2RlZmluZSBBQ0xfQ09O
VFJPTF9TQwkweDAyMDAJLyogU0FDTCBjb21wdXRlZCB0aHJvdWdoIGluaGVyaXRhbmNlICovCisj
ZGVmaW5lIEFDTF9DT05UUk9MX0RDCTB4MDEwMAkvKiBEQUNMIGNvbXB1dGVkIHRocm91Z2ggaW5o
ZXJpdGVuY2UgKi8KKyNkZWZpbmUgQUNMX0NPTlRST0xfU1MJMHgwMDgwCS8qIENyZWF0ZSBzZXJ2
ZXIgQUNMICovCisjZGVmaW5lIEFDTF9DT05UUk9MX0RUCTB4MDA0MAkvKiBEQUNMIHByb3ZpZGVk
IGJ5IHRydXN0ZWQgc291cmNlICovCisjZGVmaW5lIEFDTF9DT05UUk9MX1NECTB4MDAyMAkvKiBT
QUNMIGRlZmF1bHRlZCAqLworI2RlZmluZSBBQ0xfQ09OVFJPTF9TUAkweDAwMTAJLyogU0FDTCBp
cyBwcmVzZW50IG9uIG9iamVjdCAqLworI2RlZmluZSBBQ0xfQ09OVFJPTF9ERAkweDAwMDgJLyog
REFDTCBkZWZhdWx0ZWQgKi8KKyNkZWZpbmUgQUNMX0NPTlRST0xfRFAJMHgwMDA0CS8qIERBQ0wg
aXMgcHJlc2VudCBvbiBvYmplY3QgKi8KKyNkZWZpbmUgQUNMX0NPTlRST0xfR0QJMHgwMDAyCS8q
IEdyb3VwIHdhcyBkZWZhdWx0ZWQgKi8KKyNkZWZpbmUgQUNMX0NPTlRST0xfT0QJMHgwMDAxCS8q
IFVzZXIgd2FzIGRlZmF1bHRlZCAqLwogCiAvKiBNZWFuaW5nIG9mIEFjbFJldmlzaW9uIGZsYWdz
ICovCiAjZGVmaW5lIEFDTF9SRVZJU0lPTgkweDAyIC8qIFNlZSBzZWN0aW9uIDIuNC40LjEgb2Yg
TVMtRFRZUCAqLwpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzcHJvdG8uaCBiL2ZzL2NpZnMvY2lm
c3Byb3RvLmgKaW5kZXggMWVkNjk1MzM2ZjYyLi45YzIyOTQwOGEyNTEgMTAwNjQ0Ci0tLSBhL2Zz
L2NpZnMvY2lmc3Byb3RvLmgKKysrIGIvZnMvY2lmcy9jaWZzcHJvdG8uaApAQCAtMjEzLDYgKzIx
Myw3IEBAIGV4dGVybiBzdHJ1Y3QgY2lmc19udHNkICpnZXRfY2lmc19hY2xfYnlfZmlkKHN0cnVj
dCBjaWZzX3NiX2luZm8gKiwKIAkJCQkJCWNvbnN0IHN0cnVjdCBjaWZzX2ZpZCAqLCB1MzIgKik7
CiBleHRlcm4gaW50IHNldF9jaWZzX2FjbChzdHJ1Y3QgY2lmc19udHNkICosIF9fdTMyLCBzdHJ1
Y3QgaW5vZGUgKiwKIAkJCQljb25zdCBjaGFyICosIGludCk7CitleHRlcm4gdW5zaWduZWQgaW50
IHNldHVwX3NwZWNpYWxfbW9kZV9BQ0Uoc3RydWN0IGNpZnNfYWNlICpwYWNlLCBfX3U2NCBubW9k
ZSk7CiAKIGV4dGVybiB2b2lkIGRlcXVldWVfbWlkKHN0cnVjdCBtaWRfcV9lbnRyeSAqbWlkLCBi
b29sIG1hbGZvcm1lZCk7CiBleHRlcm4gaW50IGNpZnNfcmVhZF9mcm9tX3NvY2tldChzdHJ1Y3Qg
VENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIsIGNoYXIgKmJ1ZiwKZGlmZiAtLWdpdCBhL2ZzL2NpZnMv
c21iMnBkdS5jIGIvZnMvY2lmcy9zbWIycGR1LmMKaW5kZXggMTg3YTVjZTY4ODA2Li5kYzc1YTQ5
MjVhYjUgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvc21iMnBkdS5jCisrKyBiL2ZzL2NpZnMvc21iMnBk
dS5jCkBAIC0yMTkxLDYgKzIxOTEsNzMgQEAgYWRkX3R3YXJwX2NvbnRleHQoc3RydWN0IGt2ZWMg
KmlvdiwgdW5zaWduZWQgaW50ICpudW1faW92ZWMsIF9fdTY0IHRpbWV3YXJwKQogCXJldHVybiAw
OwogfQogCisvKiBTZWUgTVMtU01CMiAyLjIuMTMuMi4yIGFuZCBNUy1EVFlQIDIuNC42ICovCitz
dGF0aWMgc3RydWN0IGNydF9zZF9jdHh0ICoKK2NyZWF0ZV9zZF9idWYodW1vZGVfdCBtb2RlLCB1
bnNpZ25lZCBpbnQgKmxlbikKK3sKKwlzdHJ1Y3QgY3J0X3NkX2N0eHQgKmJ1ZjsKKwlzdHJ1Y3Qg
Y2lmc19hY2UgKnBhY2U7CisJaW50IHNkbGVuID0gMDsKKworCSpsZW4gPSByb3VuZHVwKHNpemVv
ZihzdHJ1Y3QgY3J0X3NkX2N0eHQpICsgc2l6ZW9mKHN0cnVjdCBjaWZzX2FjZSksIDgpOworCWJ1
ZiA9IGt6YWxsb2MoKmxlbiwgR0ZQX0tFUk5FTCk7CisJaWYgKGJ1ZiA9PSBOVUxMKQorCQlyZXR1
cm4gYnVmOworCisJc2RsZW4gPSBzaXplb2Yoc3RydWN0IHNtYjNfc2QpICsgc2l6ZW9mKHN0cnVj
dCBzbWIzX2FjbCkgKworCQkgc2l6ZW9mKHN0cnVjdCBjaWZzX2FjZSk7CisKKwlidWYtPmNjb250
ZXh0LkRhdGFPZmZzZXQgPSBjcHVfdG9fbGUxNihvZmZzZXRvZgorCQkJCQkoc3RydWN0IGNydF9z
ZF9jdHh0LCBzZCkpOworCWJ1Zi0+Y2NvbnRleHQuRGF0YUxlbmd0aCA9IGNwdV90b19sZTMyKHNk
bGVuKTsKKwlidWYtPmNjb250ZXh0Lk5hbWVPZmZzZXQgPSBjcHVfdG9fbGUxNihvZmZzZXRvZgor
CQkJCShzdHJ1Y3QgY3J0X3NkX2N0eHQsIE5hbWUpKTsKKwlidWYtPmNjb250ZXh0Lk5hbWVMZW5n
dGggPSBjcHVfdG9fbGUxNig0KTsKKwkvKiBTTUIyX0NSRUFURV9TRF9CVUZGRVJfVE9LRU4gaXMg
IlNlY0QiICovCisJYnVmLT5OYW1lWzBdID0gJ1MnOworCWJ1Zi0+TmFtZVsxXSA9ICdlJzsKKwli
dWYtPk5hbWVbMl0gPSAnYyc7CisJYnVmLT5OYW1lWzNdID0gJ0QnOworCWJ1Zi0+c2QuUmV2aXNp
b24gPSAxOyAgLyogTXVzdCBiZSBvbmUgc2VlIE1TLURUWVAgMi40LjYgKi8KKwkvKgorCSAqIEFD
TCBpcyAic2VsZiByZWxhdGl2ZSIgaWUgQUNMIGlzIHN0b3JlZCBpbiBjb250aWd1b3VzIGJsb2Nr
IG9mIG1lbW9yeQorCSAqIGFuZCAiRFAiIGllIHRoZSBEQUNMIGlzIHByZXNlbnQKKwkgKi8KKwli
dWYtPnNkLkNvbnRyb2wgPSBjcHVfdG9fbGUxNihBQ0xfQ09OVFJPTF9TUiB8IEFDTF9DT05UUk9M
X0RQKTsKKworCS8qIG9mZnNldCBvd25lciwgZ3JvdXAgYW5kIFNiejEgYW5kIFNBQ0wgYXJlIGFs
bCB6ZXJvICovCisJYnVmLT5zZC5PZmZzZXREYWNsID0gY3B1X3RvX2xlMzIoc2l6ZW9mKHN0cnVj
dCBzbWIzX3NkKSk7CisJYnVmLT5hY2wuQWNsUmV2aXNpb24gPSBBQ0xfUkVWSVNJT047IC8qIFNl
ZSAyLjQuNC4xIG9mIE1TLURUWVAgKi8KKworCS8qIGNyZWF0ZSBvbmUgQUNFIHRvIGhvbGQgdGhl
IG1vZGUgZW1iZWRkZWQgaW4gcmVzZXJ2ZWQgc3BlY2lhbCBTSUQgKi8KKwlwYWNlID0gKHN0cnVj
dCBjaWZzX2FjZSAqKShzaXplb2Yoc3RydWN0IGNydF9zZF9jdHh0KSArIChjaGFyICopYnVmKTsK
KwlidWYtPmFjbC5BY2xTaXplID0KKwkJY3B1X3RvX2xlMTYoc2l6ZW9mKHN0cnVjdCBjaWZzX2Fj
bCkgKworCQkJICAgIHNldHVwX3NwZWNpYWxfbW9kZV9BQ0UocGFjZSwgKF9fdTY0KW1vZGUpKTsK
KwlidWYtPmFjbC5BY2VDb3VudCA9IGNwdV90b19sZTE2KDEpOworCXJldHVybiBidWY7Cit9CisK
K3N0YXRpYyBpbnQKK2FkZF9zZF9jb250ZXh0KHN0cnVjdCBrdmVjICppb3YsIHVuc2lnbmVkIGlu
dCAqbnVtX2lvdmVjLCB1bW9kZV90IG1vZGUpCit7CisJc3RydWN0IHNtYjJfY3JlYXRlX3JlcSAq
cmVxID0gaW92WzBdLmlvdl9iYXNlOworCXVuc2lnbmVkIGludCBudW0gPSAqbnVtX2lvdmVjOwor
CXVuc2lnbmVkIGludCBsZW4gPSAwOworCisJaW92W251bV0uaW92X2Jhc2UgPSBjcmVhdGVfc2Rf
YnVmKG1vZGUsICZsZW4pOworCWlmIChpb3ZbbnVtXS5pb3ZfYmFzZSA9PSBOVUxMKQorCQlyZXR1
cm4gLUVOT01FTTsKKwlpb3ZbbnVtXS5pb3ZfbGVuID0gbGVuOworCWlmICghcmVxLT5DcmVhdGVD
b250ZXh0c09mZnNldCkKKwkJcmVxLT5DcmVhdGVDb250ZXh0c09mZnNldCA9IGNwdV90b19sZTMy
KAorCQkJCXNpemVvZihzdHJ1Y3Qgc21iMl9jcmVhdGVfcmVxKSArCisJCQkJaW92W251bSAtIDFd
Lmlvdl9sZW4pOworCWxlMzJfYWRkX2NwdSgmcmVxLT5DcmVhdGVDb250ZXh0c0xlbmd0aCwgbGVu
KTsKKwkqbnVtX2lvdmVjID0gbnVtICsgMTsKKwlyZXR1cm4gMDsKK30KKwogc3RhdGljIHN0cnVj
dCBjcnRfcXVlcnlfaWRfY3R4dCAqCiBjcmVhdGVfcXVlcnlfaWRfYnVmKHZvaWQpCiB7CkBAIC0y
NTYzLDcgKzI2MzAsNyBAQCBTTUIyX29wZW5faW5pdChzdHJ1Y3QgY2lmc190Y29uICp0Y29uLCBz
dHJ1Y3Qgc21iX3Jxc3QgKnJxc3QsIF9fdTggKm9wbG9jaywKIAkJCXJldHVybiByYzsKIAl9CiAK
LQlpZiAoKG9wYXJtcy0+ZGlzcG9zaXRpb24gPT0gRklMRV9DUkVBVEUpICYmCisJaWYgKChvcGFy
bXMtPmRpc3Bvc2l0aW9uICE9IEZJTEVfT1BFTikgJiYKIAkgICAgKG9wYXJtcy0+bW9kZSAhPSBB
Q0xfTk9fTU9ERSkpIHsKIAkJaWYgKG5faW92ID4gMikgewogCQkJc3RydWN0IGNyZWF0ZV9jb250
ZXh0ICpjY29udGV4dCA9CkBAIC0yNTcyLDcgKzI2MzksOCBAQCBTTUIyX29wZW5faW5pdChzdHJ1
Y3QgY2lmc190Y29uICp0Y29uLCBzdHJ1Y3Qgc21iX3Jxc3QgKnJxc3QsIF9fdTggKm9wbG9jaywK
IAkJCQljcHVfdG9fbGUzMihpb3Zbbl9pb3YtMV0uaW92X2xlbik7CiAJCX0KIAotCQkvKiByYyA9
IGFkZF9zZF9jb250ZXh0KGlvdiwgJm5faW92LCBvcGFybXMtPm1vZGUpOyAqLworCQljaWZzX2Ri
ZyhGWUksICJhZGQgc2Qgd2l0aCBtb2RlIDB4JXhcbiIsIG9wYXJtcy0+bW9kZSk7CisJCXJjID0g
YWRkX3NkX2NvbnRleHQoaW92LCAmbl9pb3YsIG9wYXJtcy0+bW9kZSk7CiAJCWlmIChyYykKIAkJ
CXJldHVybiByYzsKIAl9CmRpZmYgLS1naXQgYS9mcy9jaWZzL3NtYjJwZHUuaCBiL2ZzL2NpZnMv
c21iMnBkdS5oCmluZGV4IGZhMjUzM2RhMzE2ZC4uN2IxYzM3OWZkZjdhIDEwMDY0NAotLS0gYS9m
cy9jaWZzL3NtYjJwZHUuaAorKysgYi9mcy9jaWZzL3NtYjJwZHUuaApAQCAtMjUsNiArMjUsNyBA
QAogI2RlZmluZSBfU01CMlBEVV9ICiAKICNpbmNsdWRlIDxuZXQvc29jay5oPgorI2luY2x1ZGUg
PGNpZnNhY2wuaD4KIAogLyoKICAqIE5vdGUgdGhhdCwgZHVlIHRvIHRyeWluZyB0byB1c2UgbmFt
ZXMgc2ltaWxhciB0byB0aGUgcHJvdG9jb2wgc3BlY2lmaWNhdGlvbnMsCkBAIC04NTUsNiArODU2
LDE1IEBAIHN0cnVjdCBjcnRfcXVlcnlfaWRfY3R4dCB7CiAJX191OAlOYW1lWzhdOwogfSBfX3Bh
Y2tlZDsKIAorc3RydWN0IGNydF9zZF9jdHh0IHsKKwlzdHJ1Y3QgY3JlYXRlX2NvbnRleHQgY2Nv
bnRleHQ7CisJX191OAlOYW1lWzhdOworCXN0cnVjdCBzbWIzX3NkIHNkOworCXN0cnVjdCBzbWIz
X2FjbCBhY2w7CisJLyogRm9sbG93ZWQgYnkgYXQgbGVhc3QgNCBBQ0VzICovCit9IF9fcGFja2Vk
OworCisKICNkZWZpbmUgQ09QWV9DSFVOS19SRVNfS0VZX1NJWkUJMjQKIHN0cnVjdCByZXN1bWVf
a2V5X3JlcSB7CiAJY2hhciBSZXN1bWVLZXlbQ09QWV9DSFVOS19SRVNfS0VZX1NJWkVdOwotLSAK
Mi4yMy4wCgo=
--0000000000001b93710599049558--
