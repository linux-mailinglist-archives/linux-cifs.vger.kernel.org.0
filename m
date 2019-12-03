Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2F8CB10FADE
	for <lists+linux-cifs@lfdr.de>; Tue,  3 Dec 2019 10:37:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726057AbfLCJho (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 3 Dec 2019 04:37:44 -0500
Received: from mail-il1-f171.google.com ([209.85.166.171]:39666 "EHLO
        mail-il1-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725939AbfLCJho (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 3 Dec 2019 04:37:44 -0500
Received: by mail-il1-f171.google.com with SMTP id a7so2551354ild.6
        for <linux-cifs@vger.kernel.org>; Tue, 03 Dec 2019 01:37:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=v2qbrus5dvXz9bW/rb1sxeouizNhDJIU0GFXfPI61ZU=;
        b=Dv5D1716gSVeIRK7uSu3xlMhLZeV4VJINVHaBqn58AuV3B+UyOXIaCG5cQc7pVC0yQ
         8XXp7BpQrLJQp5J81Lm6v1qMzXRFuqg56gonUTKZhLRU5boIa3qh5no8B6JW9folg+sN
         rqBndoDKNZzSYu6d4MI4Bt5RTZ6tS8zdDNZXfdnLx2CYrRya4RrUnYmf15b0Q4X/ckWi
         2qhgzERh0JbO0iRfIzEPSg6mzQiAXekK+EdQ/cqcjNnB0ILg+FFBDTimr2TVBRI+LXBd
         A43PT0k9r8yVMddHOpS+epEZjcEeE60o3uUtsrsoabndKOMlEvliM2879ZffyT/0nu82
         I8nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=v2qbrus5dvXz9bW/rb1sxeouizNhDJIU0GFXfPI61ZU=;
        b=L60+0goE1h/tqavy73HS6TI3Radd5PJTGT4z0VbiIkwafA0xyT6ptbcBDhAyZCNlkI
         /YBVgJFBuvkfxBoNXPVB2y++lIYlgmkFh/9cw8R6goFjbMRkR6G5rNn/OWzFTT6QuIL1
         9rpelBshsex+Ni7KRLfFqL0wX1NPiML9fBRbsXmcrqdo/F1QNXpM8L9QR4L7erlZaU2i
         Pw3VXm6ajGIMX/2DOQuozkQ7OWYn5CbiGVJEBfiZcAMwS/e9vo+uy01xpXaUb9LRi76m
         6+ORNsoS1gkK1lMo6lb3y5ZSWn6su25D2iriftnhJwxdKh2qLkWv2GP/wcCTf0t6nMsi
         ZV1A==
X-Gm-Message-State: APjAAAVgIDvLzuKHC3Kw0p+0cShPPbzFUX+NshMj1JHR3+lszi49ZZ6q
        PDztwqXQqRON4ZM2rMKxiZhM76BXV/b98/iFn7NaaqY/
X-Google-Smtp-Source: APXvYqzyB4zwA5Yy+H21Lo5GVyHNV8uP4+SDTTnCre11d9DqOFFWr9jiEgrKXqda+n/9A1cj2uOM/5d+58nkdAVBcGQ=
X-Received: by 2002:a92:6802:: with SMTP id d2mr3753827ilc.173.1575365862779;
 Tue, 03 Dec 2019 01:37:42 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 3 Dec 2019 03:37:32 -0600
Message-ID: <CAH2r5muXMXS6S-+XykdZmZGMQGNsTunxDXM-fqX7owEG+E=RRQ@mail.gmail.com>
Subject: [PATCH][SMB3] Query timestamps on file close
To:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000a4965b0598c97251"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--000000000000a4965b0598c97251
Content-Type: text/plain; charset="UTF-8"

Since timestamps on files on most servers can be updated at
close, and since timestamps on our dentries default to one
second we can have stale timestamps in some common cases
(e.g. open, write, close, stat, wait one second, stat - will
show different mtime for the first and second stat).

The SMB2/SMB3 protocol allows querying timestamps at close
so add the code to request timestamp and attr information
(which is cheap for the server to provide) to be returned
when a file is closed (it is not needed for the many
paths that call SMB2_close that are from compounded
query infos and close nor is it needed for some of
the cases where a directory close immediately follows a
directory open.

-- 
Thanks,

Steve

--000000000000a4965b0598c97251
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb3-query-attributes-on-file-close.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-query-attributes-on-file-close.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_k3po5gi80>
X-Attachment-Id: f_k3po5gi80

RnJvbSBhMzk3Zjg1NTMxMjUxY2VjZjc5MmEzMGE1ODEzMmZmNzJjZjEzOTlmIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IE1vbiwgMiBEZWMgMjAxOSAyMTo0Njo1NCAtMDYwMApTdWJqZWN0OiBbUEFUQ0hdIHNt
YjM6IHF1ZXJ5IGF0dHJpYnV0ZXMgb24gZmlsZSBjbG9zZQoKU2luY2UgdGltZXN0YW1wcyBvbiBm
aWxlcyBvbiBtb3N0IHNlcnZlcnMgY2FuIGJlIHVwZGF0ZWQgYXQKY2xvc2UsIGFuZCBzaW5jZSB0
aW1lc3RhbXBzIG9uIG91ciBkZW50cmllcyBkZWZhdWx0IHRvIG9uZQpzZWNvbmQgd2UgY2FuIGhh
dmUgc3RhbGUgdGltZXN0YW1wcyBpbiBzb21lIGNvbW1vbiBjYXNlcwooZS5nLiBvcGVuLCB3cml0
ZSwgY2xvc2UsIHN0YXQsIHdhaXQgb25lIHNlY29uZCwgc3RhdCAtIHdpbGwKc2hvdyBkaWZmZXJl
bnQgbXRpbWUgZm9yIHRoZSBmaXJzdCBhbmQgc2Vjb25kIHN0YXQpLgoKVGhlIFNNQjIvU01CMyBw
cm90b2NvbCBhbGxvd3MgcXVlcnlpbmcgdGltZXN0YW1wcyBhdCBjbG9zZQpzbyBhZGQgdGhlIGNv
ZGUgdG8gcmVxdWVzdCB0aW1lc3RhbXAgYW5kIGF0dHIgaW5mb3JtYXRpb24KKHdoaWNoIGlzIGNo
ZWFwIGZvciB0aGUgc2VydmVyIHRvIHByb3ZpZGUpIHRvIGJlIHJldHVybmVkCndoZW4gYSBmaWxl
IGlzIGNsb3NlZCAoaXQgaXMgbm90IG5lZWRlZCBmb3IgdGhlIG1hbnkKcGF0aHMgdGhhdCBjYWxs
IFNNQjJfY2xvc2UgdGhhdCBhcmUgZnJvbSBjb21wb3VuZGVkCnF1ZXJ5IGluZm9zIGFuZCBjbG9z
ZSBub3IgaXMgaXQgbmVlZGVkIGZvciBzb21lIG9mCnRoZSBjYXNlcyB3aGVyZSBhIGRpcmVjdG9y
eSBjbG9zZSBpbW1lZGlhdGVseSBmb2xsb3dzIGEKZGlyZWN0b3J5IG9wZW4uCgpTaWduZWQtb2Zm
LWJ5OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+CkFja2VkLWJ5OiBSb25u
aWUgU2FobGJlcmcgPGxzYWhsYmVyQHJlZGhhdC5jb20+Ci0tLQogZnMvY2lmcy9jaWZzZ2xvYi5o
ICB8ICAzICsrKwogZnMvY2lmcy9maWxlLmMgICAgICB8ICA0ICsrKy0KIGZzL2NpZnMvc21iMmlu
b2RlLmMgfCAgMiArLQogZnMvY2lmcy9zbWIyb3BzLmMgICB8IDQwICsrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0tLS0KIGZzL2NpZnMvc21iMnBkdS5jICAgfCAzNSArKysrKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLQogZnMvY2lmcy9zbWIycGR1LmggICB8IDExICsr
KysrKysrKysrCiBmcy9jaWZzL3NtYjJwcm90by5oIHwgIDUgKysrKy0KIDcgZmlsZXMgY2hhbmdl
ZCwgODggaW5zZXJ0aW9ucygrKSwgMTIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvY2lm
cy9jaWZzZ2xvYi5oIGIvZnMvY2lmcy9jaWZzZ2xvYi5oCmluZGV4IGQzNGE0ZWQ4YzU3ZC4uNWI5
NzZlMDFkZDZiIDEwMDY0NAotLS0gYS9mcy9jaWZzL2NpZnNnbG9iLmgKKysrIGIvZnMvY2lmcy9j
aWZzZ2xvYi5oCkBAIC0zNjgsNiArMzY4LDkgQEAgc3RydWN0IHNtYl92ZXJzaW9uX29wZXJhdGlv
bnMgewogCS8qIGNsb3NlIGEgZmlsZSAqLwogCXZvaWQgKCpjbG9zZSkoY29uc3QgdW5zaWduZWQg
aW50LCBzdHJ1Y3QgY2lmc190Y29uICosCiAJCSAgICAgIHN0cnVjdCBjaWZzX2ZpZCAqKTsKKwkv
KiBjbG9zZSBhIGZpbGUsIHJldHVybmluZyBmaWxlIGF0dHJpYnV0ZXMgYW5kIHRpbWVzdGFtcHMg
Ki8KKwl2b2lkICgqY2xvc2VfZ2V0YXR0cikoY29uc3QgdW5zaWduZWQgaW50IHhpZCwgc3RydWN0
IGNpZnNfdGNvbiAqdGNvbiwKKwkJICAgICAgc3RydWN0IGNpZnNGaWxlSW5mbyAqcGZpbGVfaW5m
byk7CiAJLyogc2VuZCBhIGZsdXNoIHJlcXVlc3QgdG8gdGhlIHNlcnZlciAqLwogCWludCAoKmZs
dXNoKShjb25zdCB1bnNpZ25lZCBpbnQsIHN0cnVjdCBjaWZzX3Rjb24gKiwgc3RydWN0IGNpZnNf
ZmlkICopOwogCS8qIGFzeW5jIHJlYWQgZnJvbSB0aGUgc2VydmVyICovCmRpZmYgLS1naXQgYS9m
cy9jaWZzL2ZpbGUuYyBiL2ZzL2NpZnMvZmlsZS5jCmluZGV4IDlhZTQxMDQyZmEzZC4uMDQzMjg4
YjVjNzI4IDEwMDY0NAotLS0gYS9mcy9jaWZzL2ZpbGUuYworKysgYi9mcy9jaWZzL2ZpbGUuYwpA
QCAtNDk2LDcgKzQ5Niw5IEBAIHZvaWQgX2NpZnNGaWxlSW5mb19wdXQoc3RydWN0IGNpZnNGaWxl
SW5mbyAqY2lmc19maWxlLAogCQl1bnNpZ25lZCBpbnQgeGlkOwogCiAJCXhpZCA9IGdldF94aWQo
KTsKLQkJaWYgKHNlcnZlci0+b3BzLT5jbG9zZSkKKwkJaWYgKHNlcnZlci0+b3BzLT5jbG9zZV9n
ZXRhdHRyKQorCQkJc2VydmVyLT5vcHMtPmNsb3NlX2dldGF0dHIoeGlkLCB0Y29uLCBjaWZzX2Zp
bGUpOworCQllbHNlIGlmIChzZXJ2ZXItPm9wcy0+Y2xvc2UpCiAJCQlzZXJ2ZXItPm9wcy0+Y2xv
c2UoeGlkLCB0Y29uLCAmY2lmc19maWxlLT5maWQpOwogCQlfZnJlZV94aWQoeGlkKTsKIAl9CmRp
ZmYgLS1naXQgYS9mcy9jaWZzL3NtYjJpbm9kZS5jIGIvZnMvY2lmcy9zbWIyaW5vZGUuYwppbmRl
eCA0MTIxYWMxMTYzY2EuLjE4YzdhMzNhZGNlYiAxMDA2NDQKLS0tIGEvZnMvY2lmcy9zbWIyaW5v
ZGUuYworKysgYi9mcy9jaWZzL3NtYjJpbm9kZS5jCkBAIC0zMTMsNyArMzEzLDcgQEAgc21iMl9j
b21wb3VuZF9vcChjb25zdCB1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1Y3QgY2lmc190Y29uICp0Y29u
LAogCXJxc3RbbnVtX3Jxc3RdLnJxX2lvdiA9IGNsb3NlX2lvdjsKIAlycXN0W251bV9ycXN0XS5y
cV9udmVjID0gMTsKIAlyYyA9IFNNQjJfY2xvc2VfaW5pdCh0Y29uLCAmcnFzdFtudW1fcnFzdF0s
IENPTVBPVU5EX0ZJRCwKLQkJCSAgICAgQ09NUE9VTkRfRklEKTsKKwkJCSAgICAgQ09NUE9VTkRf
RklELCBmYWxzZSk7CiAJc21iMl9zZXRfcmVsYXRlZCgmcnFzdFtudW1fcnFzdF0pOwogCWlmIChy
YykKIAkJZ290byBmaW5pc2hlZDsKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvc21iMm9wcy5jIGIvZnMv
Y2lmcy9zbWIyb3BzLmMKaW5kZXggYTdmMzI4Zjc5YzZmLi5mMDFlOGU0YTdjZmYgMTAwNjQ0Ci0t
LSBhL2ZzL2NpZnMvc21iMm9wcy5jCisrKyBiL2ZzL2NpZnMvc21iMm9wcy5jCkBAIC0xMTc4LDcg
KzExNzgsNyBAQCBzbWIyX3NldF9lYShjb25zdCB1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1Y3QgY2lm
c190Y29uICp0Y29uLAogCW1lbXNldCgmY2xvc2VfaW92LCAwLCBzaXplb2YoY2xvc2VfaW92KSk7
CiAJcnFzdFsyXS5ycV9pb3YgPSBjbG9zZV9pb3Y7CiAJcnFzdFsyXS5ycV9udmVjID0gMTsKLQly
YyA9IFNNQjJfY2xvc2VfaW5pdCh0Y29uLCAmcnFzdFsyXSwgQ09NUE9VTkRfRklELCBDT01QT1VO
RF9GSUQpOworCXJjID0gU01CMl9jbG9zZV9pbml0KHRjb24sICZycXN0WzJdLCBDT01QT1VORF9G
SUQsIENPTVBPVU5EX0ZJRCwgZmFsc2UpOwogCXNtYjJfc2V0X3JlbGF0ZWQoJnJxc3RbMl0pOwog
CiAJcmMgPSBjb21wb3VuZF9zZW5kX3JlY3YoeGlkLCBzZXMsIGZsYWdzLCAzLCBycXN0LApAQCAt
MTMzMiw2ICsxMzMyLDM2IEBAIHNtYjJfY2xvc2VfZmlsZShjb25zdCB1bnNpZ25lZCBpbnQgeGlk
LCBzdHJ1Y3QgY2lmc190Y29uICp0Y29uLAogCVNNQjJfY2xvc2UoeGlkLCB0Y29uLCBmaWQtPnBl
cnNpc3RlbnRfZmlkLCBmaWQtPnZvbGF0aWxlX2ZpZCk7CiB9CiAKK3N0YXRpYyB2b2lkCitzbWIy
X2Nsb3NlX2dldGF0dHIoY29uc3QgdW5zaWduZWQgaW50IHhpZCwgc3RydWN0IGNpZnNfdGNvbiAq
dGNvbiwKKwkJICAgc3RydWN0IGNpZnNGaWxlSW5mbyAqY2ZpbGUpCit7CisJc3RydWN0IHNtYjJf
ZmlsZV9uZXR3b3JrX29wZW5faW5mbyBmaWxlX2luZjsKKwlzdHJ1Y3QgaW5vZGUgKmlub2RlOwor
CWludCByYzsKKworCXJjID0gX19TTUIyX2Nsb3NlKHhpZCwgdGNvbiwgY2ZpbGUtPmZpZC5wZXJz
aXN0ZW50X2ZpZCwKKwkJICAgY2ZpbGUtPmZpZC52b2xhdGlsZV9maWQsICZmaWxlX2luZik7CisJ
aWYgKHJjKQorCQlyZXR1cm47CisKKwlpbm9kZSA9IGRfaW5vZGUoY2ZpbGUtPmRlbnRyeSk7CisJ
Q0lGU19JKGlub2RlKS0+dGltZSA9IGppZmZpZXM7CisKKwkvKiBDcmVhdGlvbiB0aW1lIHNob3Vs
ZCBub3QgbmVlZCB0byBiZSB1cGRhdGVkIG9uIGNsb3NlICovCisJaWYgKGZpbGVfaW5mLkxhc3RX
cml0ZVRpbWUpCisJCWlub2RlLT5pX210aW1lID0gY2lmc19OVHRpbWVUb1VuaXgoZmlsZV9pbmYu
TGFzdFdyaXRlVGltZSk7CisJaWYgKGZpbGVfaW5mLkNoYW5nZVRpbWUpCisJCWlub2RlLT5pX2N0
aW1lID0gY2lmc19OVHRpbWVUb1VuaXgoZmlsZV9pbmYuQ2hhbmdlVGltZSk7CisJaWYgKGZpbGVf
aW5mLkxhc3RBY2Nlc3NUaW1lKQorCQlpbm9kZS0+aV9hdGltZSA9IGNpZnNfTlR0aW1lVG9Vbml4
KGZpbGVfaW5mLkxhc3RBY2Nlc3NUaW1lKTsKKworCS8qIEVuZCBvZiBmaWxlIGFuZCBBdHRyaWJ1
dGVzIHNob3VsZCBub3QgaGF2ZSB0byBiZSB1cGRhdGVkIG9uIGNsb3NlICovCisKKwkvKiBTaG91
bGQgQWxsb2NhdGlvblNpemUgYmUgdXBkYXRlZCBvbiBjbG9zZT8gKi8KKworfQorCiBzdGF0aWMg
aW50CiBTTUIyX3JlcXVlc3RfcmVzX2tleShjb25zdCB1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1Y3Qg
Y2lmc190Y29uICp0Y29uLAogCQkgICAgIHU2NCBwZXJzaXN0ZW50X2ZpZCwgdTY0IHZvbGF0aWxl
X2ZpZCwKQEAgLTE1MTIsNyArMTU0Miw3IEBAIHNtYjJfaW9jdGxfcXVlcnlfaW5mbyhjb25zdCB1
bnNpZ25lZCBpbnQgeGlkLAogCXJxc3RbMl0ucnFfaW92ID0gY2xvc2VfaW92OwogCXJxc3RbMl0u
cnFfbnZlYyA9IDE7CiAKLQlyYyA9IFNNQjJfY2xvc2VfaW5pdCh0Y29uLCAmcnFzdFsyXSwgQ09N
UE9VTkRfRklELCBDT01QT1VORF9GSUQpOworCXJjID0gU01CMl9jbG9zZV9pbml0KHRjb24sICZy
cXN0WzJdLCBDT01QT1VORF9GSUQsIENPTVBPVU5EX0ZJRCwgZmFsc2UpOwogCWlmIChyYykKIAkJ
Z290byBpcWluZl9leGl0OwogCXNtYjJfc2V0X3JlbGF0ZWQoJnJxc3RbMl0pOwpAQCAtMjI0MSw3
ICsyMjcxLDcgQEAgc21iMl9xdWVyeV9pbmZvX2NvbXBvdW5kKGNvbnN0IHVuc2lnbmVkIGludCB4
aWQsIHN0cnVjdCBjaWZzX3Rjb24gKnRjb24sCiAJcnFzdFsyXS5ycV9pb3YgPSBjbG9zZV9pb3Y7
CiAJcnFzdFsyXS5ycV9udmVjID0gMTsKIAotCXJjID0gU01CMl9jbG9zZV9pbml0KHRjb24sICZy
cXN0WzJdLCBDT01QT1VORF9GSUQsIENPTVBPVU5EX0ZJRCk7CisJcmMgPSBTTUIyX2Nsb3NlX2lu
aXQodGNvbiwgJnJxc3RbMl0sIENPTVBPVU5EX0ZJRCwgQ09NUE9VTkRfRklELCBmYWxzZSk7CiAJ
aWYgKHJjKQogCQlnb3RvIHFpY19leGl0OwogCXNtYjJfc2V0X3JlbGF0ZWQoJnJxc3RbMl0pOwpA
QCAtMjY1NCw3ICsyNjg0LDcgQEAgc21iMl9xdWVyeV9zeW1saW5rKGNvbnN0IHVuc2lnbmVkIGlu
dCB4aWQsIHN0cnVjdCBjaWZzX3Rjb24gKnRjb24sCiAJcnFzdFsyXS5ycV9pb3YgPSBjbG9zZV9p
b3Y7CiAJcnFzdFsyXS5ycV9udmVjID0gMTsKIAotCXJjID0gU01CMl9jbG9zZV9pbml0KHRjb24s
ICZycXN0WzJdLCBDT01QT1VORF9GSUQsIENPTVBPVU5EX0ZJRCk7CisJcmMgPSBTTUIyX2Nsb3Nl
X2luaXQodGNvbiwgJnJxc3RbMl0sIENPTVBPVU5EX0ZJRCwgQ09NUE9VTkRfRklELCBmYWxzZSk7
CiAJaWYgKHJjKQogCQlnb3RvIHF1ZXJ0eV9leGl0OwogCkBAIC00NzA3LDYgKzQ3MzcsNyBAQCBz
dHJ1Y3Qgc21iX3ZlcnNpb25fb3BlcmF0aW9ucyBzbWIzMF9vcGVyYXRpb25zID0gewogCS5vcGVu
ID0gc21iMl9vcGVuX2ZpbGUsCiAJLnNldF9maWQgPSBzbWIyX3NldF9maWQsCiAJLmNsb3NlID0g
c21iMl9jbG9zZV9maWxlLAorCS5jbG9zZV9nZXRhdHRyID0gc21iMl9jbG9zZV9nZXRhdHRyLAog
CS5mbHVzaCA9IHNtYjJfZmx1c2hfZmlsZSwKIAkuYXN5bmNfcmVhZHYgPSBzbWIyX2FzeW5jX3Jl
YWR2LAogCS5hc3luY193cml0ZXYgPSBzbWIyX2FzeW5jX3dyaXRldiwKQEAgLTQ4MTYsNiArNDg0
Nyw3IEBAIHN0cnVjdCBzbWJfdmVyc2lvbl9vcGVyYXRpb25zIHNtYjMxMV9vcGVyYXRpb25zID0g
ewogCS5vcGVuID0gc21iMl9vcGVuX2ZpbGUsCiAJLnNldF9maWQgPSBzbWIyX3NldF9maWQsCiAJ
LmNsb3NlID0gc21iMl9jbG9zZV9maWxlLAorCS5jbG9zZV9nZXRhdHRyID0gc21iMl9jbG9zZV9n
ZXRhdHRyLAogCS5mbHVzaCA9IHNtYjJfZmx1c2hfZmlsZSwKIAkuYXN5bmNfcmVhZHYgPSBzbWIy
X2FzeW5jX3JlYWR2LAogCS5hc3luY193cml0ZXYgPSBzbWIyX2FzeW5jX3dyaXRldiwKZGlmZiAt
LWdpdCBhL2ZzL2NpZnMvc21iMnBkdS5jIGIvZnMvY2lmcy9zbWIycGR1LmMKaW5kZXggY2VjNTNl
YjhhNmRhLi44NDQ0Yjg0MjU4NzYgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvc21iMnBkdS5jCisrKyBi
L2ZzL2NpZnMvc21iMnBkdS5jCkBAIC0yOTMyLDcgKzI5MzIsNyBAQCBTTUIyX3NldF9jb21wcmVz
c2lvbihjb25zdCB1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1Y3QgY2lmc190Y29uICp0Y29uLAogCiBp
bnQKIFNNQjJfY2xvc2VfaW5pdChzdHJ1Y3QgY2lmc190Y29uICp0Y29uLCBzdHJ1Y3Qgc21iX3Jx
c3QgKnJxc3QsCi0JCXU2NCBwZXJzaXN0ZW50X2ZpZCwgdTY0IHZvbGF0aWxlX2ZpZCkKKwkJdTY0
IHBlcnNpc3RlbnRfZmlkLCB1NjQgdm9sYXRpbGVfZmlkLCBib29sIHF1ZXJ5X2F0dHJzKQogewog
CXN0cnVjdCBzbWIyX2Nsb3NlX3JlcSAqcmVxOwogCXN0cnVjdCBrdmVjICppb3YgPSBycXN0LT5y
cV9pb3Y7CkBAIC0yOTQ1LDYgKzI5NDUsMTAgQEAgU01CMl9jbG9zZV9pbml0KHN0cnVjdCBjaWZz
X3Rjb24gKnRjb24sIHN0cnVjdCBzbWJfcnFzdCAqcnFzdCwKIAogCXJlcS0+UGVyc2lzdGVudEZp
bGVJZCA9IHBlcnNpc3RlbnRfZmlkOwogCXJlcS0+Vm9sYXRpbGVGaWxlSWQgPSB2b2xhdGlsZV9m
aWQ7CisJaWYgKHF1ZXJ5X2F0dHJzKQorCQlyZXEtPkZsYWdzID0gU01CMl9DTE9TRV9GTEFHX1BP
U1RRVUVSWV9BVFRSSUI7CisJZWxzZQorCQlyZXEtPkZsYWdzID0gMDsKIAlpb3ZbMF0uaW92X2Jh
c2UgPSAoY2hhciAqKXJlcTsKIAlpb3ZbMF0uaW92X2xlbiA9IHRvdGFsX2xlbjsKIApAQCAtMjk1
OSw4ICsyOTYzLDkgQEAgU01CMl9jbG9zZV9mcmVlKHN0cnVjdCBzbWJfcnFzdCAqcnFzdCkKIH0K
IAogaW50Ci1TTUIyX2Nsb3NlKGNvbnN0IHVuc2lnbmVkIGludCB4aWQsIHN0cnVjdCBjaWZzX3Rj
b24gKnRjb24sCi0JCSB1NjQgcGVyc2lzdGVudF9maWQsIHU2NCB2b2xhdGlsZV9maWQpCitfX1NN
QjJfY2xvc2UoY29uc3QgdW5zaWduZWQgaW50IHhpZCwgc3RydWN0IGNpZnNfdGNvbiAqdGNvbiwK
KwkgICAgIHU2NCBwZXJzaXN0ZW50X2ZpZCwgdTY0IHZvbGF0aWxlX2ZpZCwKKwkgICAgIHN0cnVj
dCBzbWIyX2ZpbGVfbmV0d29ya19vcGVuX2luZm8gKnBidWYpCiB7CiAJc3RydWN0IHNtYl9ycXN0
IHJxc3Q7CiAJc3RydWN0IHNtYjJfY2xvc2VfcnNwICpyc3AgPSBOVUxMOwpAQCAtMjk3MCw2ICsy
OTc1LDcgQEAgU01CMl9jbG9zZShjb25zdCB1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1Y3QgY2lmc190
Y29uICp0Y29uLAogCWludCByZXNwX2J1ZnR5cGUgPSBDSUZTX05PX0JVRkZFUjsKIAlpbnQgcmMg
PSAwOwogCWludCBmbGFncyA9IDA7CisJYm9vbCBxdWVyeV9hdHRycyA9IGZhbHNlOwogCiAJY2lm
c19kYmcoRllJLCAiQ2xvc2VcbiIpOwogCkBAIC0yOTg0LDggKzI5OTAsMTMgQEAgU01CMl9jbG9z
ZShjb25zdCB1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1Y3QgY2lmc190Y29uICp0Y29uLAogCXJxc3Qu
cnFfaW92ID0gaW92OwogCXJxc3QucnFfbnZlYyA9IDE7CiAKKwkvKiBjaGVjayBpZiBuZWVkIHRv
IGFzayBzZXJ2ZXIgdG8gcmV0dXJuIHRpbWVzdGFtcHMgaW4gY2xvc2UgcmVzcG9uc2UgKi8KKwlp
ZiAocGJ1ZikKKwkJcXVlcnlfYXR0cnMgPSB0cnVlOworCiAJdHJhY2Vfc21iM19jbG9zZV9lbnRl
cih4aWQsIHBlcnNpc3RlbnRfZmlkLCB0Y29uLT50aWQsIHNlcy0+U3VpZCk7Ci0JcmMgPSBTTUIy
X2Nsb3NlX2luaXQodGNvbiwgJnJxc3QsIHBlcnNpc3RlbnRfZmlkLCB2b2xhdGlsZV9maWQpOwor
CXJjID0gU01CMl9jbG9zZV9pbml0KHRjb24sICZycXN0LCBwZXJzaXN0ZW50X2ZpZCwgdm9sYXRp
bGVfZmlkLAorCQkJICAgICBxdWVyeV9hdHRycyk7CiAJaWYgKHJjKQogCQlnb3RvIGNsb3NlX2V4
aXQ7CiAKQEAgLTI5OTcsOSArMzAwOCwxNiBAQCBTTUIyX2Nsb3NlKGNvbnN0IHVuc2lnbmVkIGlu
dCB4aWQsIHN0cnVjdCBjaWZzX3Rjb24gKnRjb24sCiAJCXRyYWNlX3NtYjNfY2xvc2VfZXJyKHhp
ZCwgcGVyc2lzdGVudF9maWQsIHRjb24tPnRpZCwgc2VzLT5TdWlkLAogCQkJCSAgICAgcmMpOwog
CQlnb3RvIGNsb3NlX2V4aXQ7Ci0JfSBlbHNlCisJfSBlbHNlIHsKIAkJdHJhY2Vfc21iM19jbG9z
ZV9kb25lKHhpZCwgcGVyc2lzdGVudF9maWQsIHRjb24tPnRpZCwKIAkJCQkgICAgICBzZXMtPlN1
aWQpOworCQkvKgorCQkgKiBOb3RlIHRoYXQgaGF2ZSB0byBzdWJ0cmFjdCA0IHNpbmNlIHN0cnVj
dCBuZXR3b3JrX29wZW5faW5mbworCQkgKiBoYXMgYSBmaW5hbCA0IGJ5dGUgcGFkIHRoYXQgY2xv
c2UgcmVzcG9zZSBkb2VzIG5vdCBoYXZlCisJCSAqLworCQlpZiAocGJ1ZikKKwkJCW1lbWNweShw
YnVmLCAoY2hhciAqKSZyc3AtPkNyZWF0aW9uVGltZSwgc2l6ZW9mKCpwYnVmKSAtIDQpOworCX0K
IAogCWF0b21pY19kZWMoJnRjb24tPm51bV9yZW1vdGVfb3BlbnMpOwogCkBAIC0zMDIyLDYgKzMw
NDAsMTMgQEAgU01CMl9jbG9zZShjb25zdCB1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1Y3QgY2lmc190
Y29uICp0Y29uLAogCXJldHVybiByYzsKIH0KIAoraW50CitTTUIyX2Nsb3NlKGNvbnN0IHVuc2ln
bmVkIGludCB4aWQsIHN0cnVjdCBjaWZzX3Rjb24gKnRjb24sCisJCXU2NCBwZXJzaXN0ZW50X2Zp
ZCwgdTY0IHZvbGF0aWxlX2ZpZCkKK3sKKwlyZXR1cm4gX19TTUIyX2Nsb3NlKHhpZCwgdGNvbiwg
cGVyc2lzdGVudF9maWQsIHZvbGF0aWxlX2ZpZCwgTlVMTCk7Cit9CisKIGludAogc21iMl92YWxp
ZGF0ZV9pb3YodW5zaWduZWQgaW50IG9mZnNldCwgdW5zaWduZWQgaW50IGJ1ZmZlcl9sZW5ndGgs
CiAJCSAgc3RydWN0IGt2ZWMgKmlvdiwgdW5zaWduZWQgaW50IG1pbl9idWZfc2l6ZSkKZGlmZiAt
LWdpdCBhL2ZzL2NpZnMvc21iMnBkdS5oIGIvZnMvY2lmcy9zbWIycGR1LmgKaW5kZXggZjI2NGUx
ZDM2ZmUxLi5mYTI1MzNkYTMxNmQgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvc21iMnBkdS5oCisrKyBi
L2ZzL2NpZnMvc21iMnBkdS5oCkBAIC0xNTcwLDYgKzE1NzAsMTcgQEAgc3RydWN0IHNtYjJfZmls
ZV9lb2ZfaW5mbyB7IC8qIGVuY29kaW5nIG9mIHJlcXVlc3QgZm9yIGxldmVsIDEwICovCiAJX19s
ZTY0IEVuZE9mRmlsZTsgLyogbmV3IGVuZCBvZiBmaWxlIHZhbHVlICovCiB9IF9fcGFja2VkOyAv
KiBsZXZlbCAyMCBTZXQgKi8KIAorc3RydWN0IHNtYjJfZmlsZV9uZXR3b3JrX29wZW5faW5mbyB7
CisJX19sZTY0IENyZWF0aW9uVGltZTsKKwlfX2xlNjQgTGFzdEFjY2Vzc1RpbWU7CisJX19sZTY0
IExhc3RXcml0ZVRpbWU7CisJX19sZTY0IENoYW5nZVRpbWU7CisJX19sZTY0IEFsbG9jYXRpb25T
aXplOworCV9fbGU2NCBFbmRPZkZpbGU7CisJX19sZTMyIEF0dHJpYnV0ZXM7CisJX19sZTMyIFJl
c2VydmVkOworfSBfX3BhY2tlZDsgLyogbGV2ZWwgMzQgUXVlcnkgYWxzbyBzaW1pbGFyIHJldHVy
bmVkIGluIGNsb3NlIHJzcCBhbmQgb3BlbiByc3AgKi8KKwogZXh0ZXJuIGNoYXIgc21iMl9wYWRk
aW5nWzddOwogCiAjZW5kaWYJCQkJLyogX1NNQjJQRFVfSCAqLwpkaWZmIC0tZ2l0IGEvZnMvY2lm
cy9zbWIycHJvdG8uaCBiL2ZzL2NpZnMvc21iMnByb3RvLmgKaW5kZXggNWNhZWFhOTljYjdjLi5h
MTgyNzJjOTg3ZmUgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvc21iMnByb3RvLmgKKysrIGIvZnMvY2lm
cy9zbWIycHJvdG8uaApAQCAtMTU1LDEwICsxNTUsMTMgQEAgZXh0ZXJuIGludCBTTUIyX2NoYW5n
ZV9ub3RpZnkoY29uc3QgdW5zaWduZWQgaW50IHhpZCwgc3RydWN0IGNpZnNfdGNvbiAqdGNvbiwK
IAkJCXU2NCBwZXJzaXN0ZW50X2ZpZCwgdTY0IHZvbGF0aWxlX2ZpZCwgYm9vbCB3YXRjaF90cmVl
LAogCQkJdTMyIGNvbXBsZXRpb25fZmlsdGVyKTsKIAorZXh0ZXJuIGludCBfX1NNQjJfY2xvc2Uo
Y29uc3QgdW5zaWduZWQgaW50IHhpZCwgc3RydWN0IGNpZnNfdGNvbiAqdGNvbiwKKwkJCXU2NCBw
ZXJzaXN0ZW50X2ZpZCwgdTY0IHZvbGF0aWxlX2ZpZCwKKwkJCXN0cnVjdCBzbWIyX2ZpbGVfbmV0
d29ya19vcGVuX2luZm8gKnBidWYpOwogZXh0ZXJuIGludCBTTUIyX2Nsb3NlKGNvbnN0IHVuc2ln
bmVkIGludCB4aWQsIHN0cnVjdCBjaWZzX3Rjb24gKnRjb24sCiAJCSAgICAgIHU2NCBwZXJzaXN0
ZW50X2ZpbGVfaWQsIHU2NCB2b2xhdGlsZV9maWxlX2lkKTsKIGV4dGVybiBpbnQgU01CMl9jbG9z
ZV9pbml0KHN0cnVjdCBjaWZzX3Rjb24gKnRjb24sIHN0cnVjdCBzbWJfcnFzdCAqcnFzdCwKLQkJ
ICAgICAgdTY0IHBlcnNpc3RlbnRfZmlsZV9pZCwgdTY0IHZvbGF0aWxlX2ZpbGVfaWQpOworCQkg
ICAgICB1NjQgcGVyc2lzdGVudF9maWQsIHU2NCB2b2xhdGlsZV9maWQsIGJvb2wgcXVlcnlfYXR0
cnMpOwogZXh0ZXJuIHZvaWQgU01CMl9jbG9zZV9mcmVlKHN0cnVjdCBzbWJfcnFzdCAqcnFzdCk7
CiBleHRlcm4gaW50IFNNQjJfZmx1c2goY29uc3QgdW5zaWduZWQgaW50IHhpZCwgc3RydWN0IGNp
ZnNfdGNvbiAqdGNvbiwKIAkJICAgICAgdTY0IHBlcnNpc3RlbnRfZmlsZV9pZCwgdTY0IHZvbGF0
aWxlX2ZpbGVfaWQpOwotLSAKMi4yMy4wCgo=
--000000000000a4965b0598c97251--
