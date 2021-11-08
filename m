Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BAE23449AF5
	for <lists+linux-cifs@lfdr.de>; Mon,  8 Nov 2021 18:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236668AbhKHRpl (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 8 Nov 2021 12:45:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232449AbhKHRpk (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 8 Nov 2021 12:45:40 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5A19C061746
        for <linux-cifs@vger.kernel.org>; Mon,  8 Nov 2021 09:42:55 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id j10so12513656lfu.4
        for <linux-cifs@vger.kernel.org>; Mon, 08 Nov 2021 09:42:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=9kOlUt5tuUEdj95eOvGcbza3jkLnd6LYFBBnQwSAy1E=;
        b=Vj9lGwviHT+R60EQjILvp2Dtu5KUPLw1FmbhADndhVj1IClZKeLGhoVztZn1wHcb/G
         dwjAtjLIuFcE3zyLW8Lqt01UIUSmdsfz72FZYxTG0QBby5AKChSBHgWdVzOWKA8r8TC2
         KkArOGpSZ4gmBjoZQ84VSRO50Go4hCkb2bSnOQTxeziZKPp++d4x5nOOv+q793IFIi8m
         6CzrARaguvewaR/iPAyZ5+dgczIcFpKwJPknAUhqw/o9KKehEZm//kMhOF09a78+vsnl
         wLu2nakRWL5X7LJi9n1JqiqF4dWMioECtYb4t3Kol++lTw1za2ETvWtges34ziko9+dr
         H27A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=9kOlUt5tuUEdj95eOvGcbza3jkLnd6LYFBBnQwSAy1E=;
        b=OFxHd8SPna1cVL0ACZ38mG3DAegEFgkCrWg37gwQBQEzQcVAUZXhFZ4umxfRj8UcBR
         7sOQ1kiDocUPqFc1PnB7+7Zhv3rq1PXx7mci6W5H7zxZBjUJxATIpPqUQJYSy2DMDSBo
         vZCEoZXLxnQKciMCqpfbdbMACs0FnIRZVQciDr8PsbBkrectYqv5Mr9ZZbQuzMZihG70
         PshO8K95BzWTeiQGTVDhzy5eYQaUgHNEiIG8ZKI80JxIZBxukCNzowhqSxGYthOd4WkY
         USDoNywoYqIff9osRV24Cdf7zVUq1GQoIncuVz5KjUDb8Rc8BLilcyTWEpMT5cS3lOE3
         aX1g==
X-Gm-Message-State: AOAM531APrb5s8npYxonCSLMz+XCtg82VfuCZtu49LFw+oT5iS6bVvPr
        t8GqiFVwr3SeAEBBsUC0N2guG3qCVcq83ZloDqT9sA4v
X-Google-Smtp-Source: ABdhPJxiEQ4COKdg/6wW8BiD8x+ub2H1NRU6+0v6dCpE7twhH3P9jBUq1d4ROP/4mw/CJ5Gb3mnbGjT7xaUoo7tunZ0=
X-Received: by 2002:ac2:5ddb:: with SMTP id x27mr861439lfq.595.1636393373861;
 Mon, 08 Nov 2021 09:42:53 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Mon, 8 Nov 2021 11:42:42 -0600
Message-ID: <CAH2r5muJyT4whZyrcn-WvMm3ESE_t_uVgkKum789-QCe5ecYfQ@mail.gmail.com>
Subject: Updated version of cifs-send-workstation-name-during-ntlmssp-session-setup
 patch
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     Shyam Prasad N <nspmangalore@gmail.com>,
        Enzo Matsumiya <ematsumiya@suse.de>,
        Paulo Alcantara <pc@cjr.nz>,
        "Stefan (metze) Metzmacher" <metze@samba.org>
Content-Type: multipart/mixed; boundary="000000000000c3757305d04a85e2"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--000000000000c3757305d04a85e2
Content-Type: text/plain; charset="UTF-8"

Shyam's ntlmssp patch, lightly updated to include review feedback, attached.

Tentatively merged into cifs-2.6.git for-next


-- 
Thanks,

Steve

--000000000000c3757305d04a85e2
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-send-workstation-name-during-ntlmssp-session-se.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-send-workstation-name-during-ntlmssp-session-se.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kvqycluw0>
X-Attachment-Id: f_kvqycluw0

RnJvbSBjYTA4NWE5NWUzNmUwY2RkYTU2YTU1M2YzZjc4OTRhMzBkYjEyN2I2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaHlhbSBQcmFzYWQgTiA8c3ByYXNhZEBtaWNyb3NvZnQuY29t
PgpEYXRlOiBGcmksIDUgTm92IDIwMjEgMTk6MDM6NTcgKzAwMDAKU3ViamVjdDogW1BBVENIXSBj
aWZzOiBzZW5kIHdvcmtzdGF0aW9uIG5hbWUgZHVyaW5nIG50bG1zc3Agc2Vzc2lvbiBzZXR1cAoK
RHVyaW5nIHRoZSBudGxtc3NwIHNlc3Npb24gc2V0dXAgKGF1dGhlbnRpY2F0ZSBwaGFzZXMpCnNl
bmQgdGhlIGNsaWVudCB3b3Jrc3RhdGlvbiBpbmZvLiBUaGlzIGNhbiBtYWtlIGRlYnVnZ2luZyBl
YXNpZXIgb24Kc2VydmVycy4KClNpZ25lZC1vZmYtYnk6IFNoeWFtIFByYXNhZCBOIDxzcHJhc2Fk
QG1pY3Jvc29mdC5jb20+ClJldmlld2VkLWJ5OiBQYXVsbyBBbGNhbnRhcmEgKFNVU0UpIDxwY0Bj
anIubno+ClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNv
bT4KLS0tCiBmcy9jaWZzL2NpZnNnbG9iLmggICB8ICAgNCArCiBmcy9jaWZzL2Nvbm5lY3QuYyAg
ICB8ICAgNiArKwogZnMvY2lmcy9mc19jb250ZXh0LmMgfCAgMzQgKysrKysrKy0KIGZzL2NpZnMv
ZnNfY29udGV4dC5oIHwgICAxICsKIGZzL2NpZnMvbWlzYy5jICAgICAgIHwgICAxICsKIGZzL2Np
ZnMvbnRsbXNzcC5oICAgIHwgICA0ICstCiBmcy9jaWZzL3Nlc3MuYyAgICAgICB8IDE4OCArKysr
KysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tCiBmcy9jaWZzL3NtYjJwZHUu
YyAgICB8ICAxNyArKy0tCiA4IGZpbGVzIGNoYW5nZWQsIDE3MCBpbnNlcnRpb25zKCspLCA4NSBk
ZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9jaWZzL2NpZnNnbG9iLmggYi9mcy9jaWZzL2Np
ZnNnbG9iLmgKaW5kZXggZWVlYTUyMGVkZTBhLi40MWU5N2RmNGUwZTUgMTAwNjQ0Ci0tLSBhL2Zz
L2NpZnMvY2lmc2dsb2IuaAorKysgYi9mcy9jaWZzL2NpZnNnbG9iLmgKQEAgLTE1LDYgKzE1LDcg
QEAKICNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CiAjaW5jbHVkZSA8bGludXgvbWVtcG9vbC5oPgog
I2luY2x1ZGUgPGxpbnV4L3dvcmtxdWV1ZS5oPgorI2luY2x1ZGUgPGxpbnV4L3V0c25hbWUuaD4K
ICNpbmNsdWRlICJjaWZzX2ZzX3NiLmgiCiAjaW5jbHVkZSAiY2lmc2FjbC5oIgogI2luY2x1ZGUg
PGNyeXB0by9pbnRlcm5hbC9oYXNoLmg+CkBAIC05OSw2ICsxMDAsOCBAQAogI2RlZmluZSBYQVRU
Ul9ET1NfQVRUUklCICJ1c2VyLkRPU0FUVFJJQiIKICNlbmRpZgogCisjZGVmaW5lIENJRlNfTUFY
X1dPUktTVEFUSU9OX0xFTiAgKF9fTkVXX1VUU19MRU4gKyAxKSAgLyogcmVhc29uYWJsZSBtYXgg
Zm9yIGNsaWVudCAqLworCiAvKgogICogQ0lGUyB2ZnMgY2xpZW50IFN0YXR1cyBpbmZvcm1hdGlv
biAoYmFzZWQgb24gd2hhdCB3ZSBrbm93LikKICAqLwpAQCAtOTA5LDYgKzkxMiw3IEBAIHN0cnVj
dCBjaWZzX3NlcyB7CiAJCQkJICAgYW5kIGFmdGVyIG1vdW50IG9wdGlvbiBwYXJzaW5nIHdlIGZp
bGwgaXQgKi8KIAljaGFyICpkb21haW5OYW1lOwogCWNoYXIgKnBhc3N3b3JkOworCWNoYXIgKndv
cmtzdGF0aW9uX25hbWU7CiAJc3RydWN0IHNlc3Npb25fa2V5IGF1dGhfa2V5OwogCXN0cnVjdCBu
dGxtc3NwX2F1dGggKm50bG1zc3A7IC8qIGNpcGhlcnRleHQsIGZsYWdzLCBzZXJ2ZXIgY2hhbGxl
bmdlICovCiAJZW51bSBzZWN1cml0eUVudW0gc2VjdHlwZTsgLyogd2hhdCBzZWN1cml0eSBmbGF2
b3Igd2FzIHNwZWNpZmllZD8gKi8KZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY29ubmVjdC5jIGIvZnMv
Y2lmcy9jb25uZWN0LmMKaW5kZXggMjQ3NDJiNzQwMmQxLi5jNDVmZWQ0ZTE4YmEgMTAwNjQ0Ci0t
LSBhL2ZzL2NpZnMvY29ubmVjdC5jCisrKyBiL2ZzL2NpZnMvY29ubmVjdC5jCkBAIC0xOTQ4LDYg
KzE5NDgsMTIgQEAgY2lmc19nZXRfc21iX3NlcyhzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2
ZXIsIHN0cnVjdCBzbWIzX2ZzX2NvbnRleHQgKmN0eCkKIAkJaWYgKCFzZXMtPmRvbWFpbk5hbWUp
CiAJCQlnb3RvIGdldF9zZXNfZmFpbDsKIAl9CisJaWYgKGN0eC0+d29ya3N0YXRpb25fbmFtZSkg
eworCQlzZXMtPndvcmtzdGF0aW9uX25hbWUgPSBrc3RyZHVwKGN0eC0+d29ya3N0YXRpb25fbmFt
ZSwKKwkJCQkJCUdGUF9LRVJORUwpOworCQlpZiAoIXNlcy0+d29ya3N0YXRpb25fbmFtZSkKKwkJ
CWdvdG8gZ2V0X3Nlc19mYWlsOworCX0KIAlpZiAoY3R4LT5kb21haW5hdXRvKQogCQlzZXMtPmRv
bWFpbkF1dG8gPSBjdHgtPmRvbWFpbmF1dG87CiAJc2VzLT5jcmVkX3VpZCA9IGN0eC0+Y3JlZF91
aWQ7CmRpZmYgLS1naXQgYS9mcy9jaWZzL2ZzX2NvbnRleHQuYyBiL2ZzL2NpZnMvZnNfY29udGV4
dC5jCmluZGV4IDM4ZDk2YTQ4MDc0NS4uOWIyOWI2MzBjMWIzIDEwMDY0NAotLS0gYS9mcy9jaWZz
L2ZzX2NvbnRleHQuYworKysgYi9mcy9jaWZzL2ZzX2NvbnRleHQuYwpAQCAtMzA5LDYgKzMwOSw3
IEBAIHNtYjNfZnNfY29udGV4dF9kdXAoc3RydWN0IHNtYjNfZnNfY29udGV4dCAqbmV3X2N0eCwg
c3RydWN0IHNtYjNfZnNfY29udGV4dCAqY3R4CiAJbmV3X2N0eC0+dXNlcm5hbWUgPSBOVUxMOwog
CW5ld19jdHgtPnBhc3N3b3JkID0gTlVMTDsKIAluZXdfY3R4LT5kb21haW5uYW1lID0gTlVMTDsK
KwluZXdfY3R4LT53b3Jrc3RhdGlvbl9uYW1lID0gTlVMTDsKIAluZXdfY3R4LT5VTkMgPSBOVUxM
OwogCW5ld19jdHgtPnNvdXJjZSA9IE5VTEw7CiAJbmV3X2N0eC0+aW9jaGFyc2V0ID0gTlVMTDsK
QEAgLTMyMyw2ICszMjQsNyBAQCBzbWIzX2ZzX2NvbnRleHRfZHVwKHN0cnVjdCBzbWIzX2ZzX2Nv
bnRleHQgKm5ld19jdHgsIHN0cnVjdCBzbWIzX2ZzX2NvbnRleHQgKmN0eAogCURVUF9DVFhfU1RS
KFVOQyk7CiAJRFVQX0NUWF9TVFIoc291cmNlKTsKIAlEVVBfQ1RYX1NUUihkb21haW5uYW1lKTsK
KwlEVVBfQ1RYX1NUUih3b3Jrc3RhdGlvbl9uYW1lKTsKIAlEVVBfQ1RYX1NUUihub2RlbmFtZSk7
CiAJRFVQX0NUWF9TVFIoaW9jaGFyc2V0KTsKIApAQCAtNzIwLDYgKzcyMiwxMSBAQCBzdGF0aWMg
aW50IHNtYjNfdmVyaWZ5X3JlY29uZmlndXJlX2N0eChzdHJ1Y3QgZnNfY29udGV4dCAqZmMsCiAJ
CWNpZnNfZXJyb3JmKGZjLCAiY2FuIG5vdCBjaGFuZ2UgZG9tYWlubmFtZSBkdXJpbmcgcmVtb3Vu
dFxuIik7CiAJCXJldHVybiAtRUlOVkFMOwogCX0KKwlpZiAobmV3X2N0eC0+d29ya3N0YXRpb25f
bmFtZSAmJgorCSAgICAoIW9sZF9jdHgtPndvcmtzdGF0aW9uX25hbWUgfHwgc3RyY21wKG5ld19j
dHgtPndvcmtzdGF0aW9uX25hbWUsIG9sZF9jdHgtPndvcmtzdGF0aW9uX25hbWUpKSkgeworCQlj
aWZzX2Vycm9yZihmYywgImNhbiBub3QgY2hhbmdlIHdvcmtzdGF0aW9uX25hbWUgZHVyaW5nIHJl
bW91bnRcbiIpOworCQlyZXR1cm4gLUVJTlZBTDsKKwl9CiAJaWYgKG5ld19jdHgtPm5vZGVuYW1l
ICYmCiAJICAgICghb2xkX2N0eC0+bm9kZW5hbWUgfHwgc3RyY21wKG5ld19jdHgtPm5vZGVuYW1l
LCBvbGRfY3R4LT5ub2RlbmFtZSkpKSB7CiAJCWNpZnNfZXJyb3JmKGZjLCAiY2FuIG5vdCBjaGFu
Z2Ugbm9kZW5hbWUgZHVyaW5nIHJlbW91bnRcbiIpOwpAQCAtNzUzLDcgKzc2MCw4IEBAIHN0YXRp
YyBpbnQgc21iM19yZWNvbmZpZ3VyZShzdHJ1Y3QgZnNfY29udGV4dCAqZmMpCiAJCXJldHVybiBy
YzsKIAogCS8qCi0JICogV2UgY2FuIG5vdCBjaGFuZ2UgVU5DL3VzZXJuYW1lL3Bhc3N3b3JkL2Rv
bWFpbm5hbWUvbm9kZW5hbWUvaW9jaGFyc2V0CisJICogV2UgY2FuIG5vdCBjaGFuZ2UgVU5DL3Vz
ZXJuYW1lL3Bhc3N3b3JkL2RvbWFpbm5hbWUvCisJICogd29ya3N0YXRpb25fbmFtZS9ub2RlbmFt
ZS9pb2NoYXJzZXQKIAkgKiBkdXJpbmcgcmVjb25uZWN0IHNvIGlnbm9yZSB3aGF0IHdlIGhhdmUg
aW4gdGhlIG5ldyBjb250ZXh0IGFuZAogCSAqIGp1c3QgdXNlIHdoYXQgd2UgYWxyZWFkeSBoYXZl
IGluIGNpZnNfc2ItPmN0eC4KIAkgKi8KQEAgLTc2Miw2ICs3NzAsNyBAQCBzdGF0aWMgaW50IHNt
YjNfcmVjb25maWd1cmUoc3RydWN0IGZzX2NvbnRleHQgKmZjKQogCVNURUFMX1NUUklORyhjaWZz
X3NiLCBjdHgsIHVzZXJuYW1lKTsKIAlTVEVBTF9TVFJJTkcoY2lmc19zYiwgY3R4LCBwYXNzd29y
ZCk7CiAJU1RFQUxfU1RSSU5HKGNpZnNfc2IsIGN0eCwgZG9tYWlubmFtZSk7CisJU1RFQUxfU1RS
SU5HKGNpZnNfc2IsIGN0eCwgd29ya3N0YXRpb25fbmFtZSk7CiAJU1RFQUxfU1RSSU5HKGNpZnNf
c2IsIGN0eCwgbm9kZW5hbWUpOwogCVNURUFMX1NUUklORyhjaWZzX3NiLCBjdHgsIGlvY2hhcnNl
dCk7CiAKQEAgLTE0MTQsMTMgKzE0MjMsMjIgQEAgc3RhdGljIGludCBzbWIzX2ZzX2NvbnRleHRf
cGFyc2VfcGFyYW0oc3RydWN0IGZzX2NvbnRleHQgKmZjLAogCiBpbnQgc21iM19pbml0X2ZzX2Nv
bnRleHQoc3RydWN0IGZzX2NvbnRleHQgKmZjKQogeworCWludCByYzsKIAlzdHJ1Y3Qgc21iM19m
c19jb250ZXh0ICpjdHg7CiAJY2hhciAqbm9kZW5hbWUgPSB1dHNuYW1lKCktPm5vZGVuYW1lOwog
CWludCBpOwogCiAJY3R4ID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IHNtYjNfZnNfY29udGV4dCks
IEdGUF9LRVJORUwpOwotCWlmICh1bmxpa2VseSghY3R4KSkKLQkJcmV0dXJuIC1FTk9NRU07CisJ
aWYgKHVubGlrZWx5KCFjdHgpKSB7CisJCXJjID0gLUVOT01FTTsKKwkJZ290byBlcnJfZXhpdDsK
Kwl9CisKKwljdHgtPndvcmtzdGF0aW9uX25hbWUgPSBrc3RyZHVwKG5vZGVuYW1lLCBHRlBfS0VS
TkVMKTsKKwlpZiAodW5saWtlbHkoIWN0eC0+d29ya3N0YXRpb25fbmFtZSkpIHsKKwkJcmMgPSAt
RU5PTUVNOworCQlnb3RvIGVycl9leGl0OworCX0KIAogCS8qCiAJICogZG9lcyBub3QgaGF2ZSB0
byBiZSBwZXJmZWN0IG1hcHBpbmcgc2luY2UgZmllbGQgaXMKQEAgLTE0OTMsNiArMTUxMSwxNCBA
QCBpbnQgc21iM19pbml0X2ZzX2NvbnRleHQoc3RydWN0IGZzX2NvbnRleHQgKmZjKQogCWZjLT5m
c19wcml2YXRlID0gY3R4OwogCWZjLT5vcHMgPSAmc21iM19mc19jb250ZXh0X29wczsKIAlyZXR1
cm4gMDsKKworZXJyX2V4aXQ6CisJaWYgKGN0eCkgeworCQlrZnJlZShjdHgtPndvcmtzdGF0aW9u
X25hbWUpOworCQlrZnJlZShjdHgpOworCX0KKworCXJldHVybiByYzsKIH0KIAogdm9pZApAQCAt
MTUxOCw2ICsxNTQ0LDggQEAgc21iM19jbGVhbnVwX2ZzX2NvbnRleHRfY29udGVudHMoc3RydWN0
IHNtYjNfZnNfY29udGV4dCAqY3R4KQogCWN0eC0+c291cmNlID0gTlVMTDsKIAlrZnJlZShjdHgt
PmRvbWFpbm5hbWUpOwogCWN0eC0+ZG9tYWlubmFtZSA9IE5VTEw7CisJa2ZyZWUoY3R4LT53b3Jr
c3RhdGlvbl9uYW1lKTsKKwljdHgtPndvcmtzdGF0aW9uX25hbWUgPSBOVUxMOwogCWtmcmVlKGN0
eC0+bm9kZW5hbWUpOwogCWN0eC0+bm9kZW5hbWUgPSBOVUxMOwogCWtmcmVlKGN0eC0+aW9jaGFy
c2V0KTsKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvZnNfY29udGV4dC5oIGIvZnMvY2lmcy9mc19jb250
ZXh0LmgKaW5kZXggYjJkMjJjZjljYjE4Li5lNTQwOTBkOWVmMzYgMTAwNjQ0Ci0tLSBhL2ZzL2Np
ZnMvZnNfY29udGV4dC5oCisrKyBiL2ZzL2NpZnMvZnNfY29udGV4dC5oCkBAIC0xNzAsNiArMTcw
LDcgQEAgc3RydWN0IHNtYjNfZnNfY29udGV4dCB7CiAJY2hhciAqc2VydmVyX2hvc3RuYW1lOwog
CWNoYXIgKlVOQzsKIAljaGFyICpub2RlbmFtZTsKKwljaGFyICp3b3Jrc3RhdGlvbl9uYW1lOwog
CWNoYXIgKmlvY2hhcnNldDsgIC8qIGxvY2FsIGNvZGUgcGFnZSBmb3IgbWFwcGluZyB0byBhbmQg
ZnJvbSBVbmljb2RlICovCiAJY2hhciBzb3VyY2VfcmZjMTAwMV9uYW1lW1JGQzEwMDFfTkFNRV9M
RU5fV0lUSF9OVUxMXTsgLyogY2xudCBuYiBuYW1lICovCiAJY2hhciB0YXJnZXRfcmZjMTAwMV9u
YW1lW1JGQzEwMDFfTkFNRV9MRU5fV0lUSF9OVUxMXTsgLyogc3J2ciBuYiBuYW1lICovCmRpZmYg
LS1naXQgYS9mcy9jaWZzL21pc2MuYyBiL2ZzL2NpZnMvbWlzYy5jCmluZGV4IGJhMmMzZTg5N2Iy
OS4uZmI3NjA0MGJlNGRiIDEwMDY0NAotLS0gYS9mcy9jaWZzL21pc2MuYworKysgYi9mcy9jaWZz
L21pc2MuYwpAQCAtOTQsNiArOTQsNyBAQCBzZXNJbmZvRnJlZShzdHJ1Y3QgY2lmc19zZXMgKmJ1
Zl90b19mcmVlKQogCWtmcmVlX3NlbnNpdGl2ZShidWZfdG9fZnJlZS0+cGFzc3dvcmQpOwogCWtm
cmVlKGJ1Zl90b19mcmVlLT51c2VyX25hbWUpOwogCWtmcmVlKGJ1Zl90b19mcmVlLT5kb21haW5O
YW1lKTsKKwlrZnJlZShidWZfdG9fZnJlZS0+d29ya3N0YXRpb25fbmFtZSk7CiAJa2ZyZWVfc2Vu
c2l0aXZlKGJ1Zl90b19mcmVlLT5hdXRoX2tleS5yZXNwb25zZSk7CiAJa2ZyZWUoYnVmX3RvX2Zy
ZWUtPmlmYWNlX2xpc3QpOwogCWtmcmVlX3NlbnNpdGl2ZShidWZfdG9fZnJlZSk7CmRpZmYgLS1n
aXQgYS9mcy9jaWZzL250bG1zc3AuaCBiL2ZzL2NpZnMvbnRsbXNzcC5oCmluZGV4IDI1YTJiOGVm
ODhiOS4uZmU3MDdmNDVkYTg5IDEwMDY0NAotLS0gYS9mcy9jaWZzL250bG1zc3AuaAorKysgYi9m
cy9jaWZzL250bG1zc3AuaApAQCAtMTE5LDcgKzExOSw5IEBAIHR5cGVkZWYgc3RydWN0IF9BVVRI
RU5USUNBVEVfTUVTU0FHRSB7CiAgKi8KIAogaW50IGRlY29kZV9udGxtc3NwX2NoYWxsZW5nZShj
aGFyICpiY2NfcHRyLCBpbnQgYmxvYl9sZW4sIHN0cnVjdCBjaWZzX3NlcyAqc2VzKTsKLXZvaWQg
YnVpbGRfbnRsbXNzcF9uZWdvdGlhdGVfYmxvYih1bnNpZ25lZCBjaGFyICpwYnVmZmVyLCBzdHJ1
Y3QgY2lmc19zZXMgKnNlcyk7CitpbnQgYnVpbGRfbnRsbXNzcF9uZWdvdGlhdGVfYmxvYih1bnNp
Z25lZCBjaGFyICoqcGJ1ZmZlciwgdTE2ICpidWZsZW4sCisJCQkJIHN0cnVjdCBjaWZzX3NlcyAq
c2VzLAorCQkJCSBjb25zdCBzdHJ1Y3QgbmxzX3RhYmxlICpubHNfY3ApOwogaW50IGJ1aWxkX250
bG1zc3BfYXV0aF9ibG9iKHVuc2lnbmVkIGNoYXIgKipwYnVmZmVyLCB1MTYgKmJ1ZmxlbiwKIAkJ
CXN0cnVjdCBjaWZzX3NlcyAqc2VzLAogCQkJY29uc3Qgc3RydWN0IG5sc190YWJsZSAqbmxzX2Nw
KTsKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvc2Vzcy5jIGIvZnMvY2lmcy9zZXNzLmMKaW5kZXggMjNl
MDJkYjc5MjNmLi45M2ExNjE5ZDYwZTYgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvc2Vzcy5jCisrKyBi
L2ZzL2NpZnMvc2Vzcy5jCkBAIC01OTksMTggKzU5OSw4NSBAQCBpbnQgZGVjb2RlX250bG1zc3Bf
Y2hhbGxlbmdlKGNoYXIgKmJjY19wdHIsIGludCBibG9iX2xlbiwKIAlyZXR1cm4gMDsKIH0KIAor
c3RhdGljIGludCBzaXplX29mX250bG1zc3BfYmxvYihzdHJ1Y3QgY2lmc19zZXMgKnNlcywgaW50
IGJhc2Vfc2l6ZSkKK3sKKwlpbnQgc3ogPSBiYXNlX3NpemUgKyBzZXMtPmF1dGhfa2V5Lmxlbgor
CQktIENJRlNfU0VTU19LRVlfU0laRSArIENJRlNfQ1BIVFhUX1NJWkUgKyAyOworCisJaWYgKHNl
cy0+ZG9tYWluTmFtZSkKKwkJc3ogKz0gc2l6ZW9mKF9fbGUxNikgKiBzdHJubGVuKHNlcy0+ZG9t
YWluTmFtZSwgQ0lGU19NQVhfRE9NQUlOTkFNRV9MRU4pOworCWVsc2UKKwkJc3ogKz0gc2l6ZW9m
KF9fbGUxNik7CisKKwlpZiAoc2VzLT51c2VyX25hbWUpCisJCXN6ICs9IHNpemVvZihfX2xlMTYp
ICogc3RybmxlbihzZXMtPnVzZXJfbmFtZSwgQ0lGU19NQVhfVVNFUk5BTUVfTEVOKTsKKwllbHNl
CisJCXN6ICs9IHNpemVvZihfX2xlMTYpOworCisJc3ogKz0gc2l6ZW9mKF9fbGUxNikgKiBzdHJu
bGVuKHNlcy0+d29ya3N0YXRpb25fbmFtZSwgQ0lGU19NQVhfV09SS1NUQVRJT05fTEVOKTsKKwor
CXJldHVybiBzejsKK30KKworc3RhdGljIGlubGluZSB2b2lkIGNpZnNfc2VjdXJpdHlfYnVmZmVy
X2Zyb21fc3RyKFNFQ1VSSVRZX0JVRkZFUiAqcGJ1ZiwKKwkJCQkJCSBjaGFyICpzdHJfdmFsdWUs
CisJCQkJCQkgaW50IHN0cl9sZW5ndGgsCisJCQkJCQkgdW5zaWduZWQgY2hhciAqcHN0YXJ0LAor
CQkJCQkJIHVuc2lnbmVkIGNoYXIgKipwY3VyLAorCQkJCQkJIGNvbnN0IHN0cnVjdCBubHNfdGFi
bGUgKm5sc19jcCkKK3sKKwl1bnNpZ25lZCBjaGFyICp0bXAgPSBwc3RhcnQ7CisJaW50IGxlbjsK
KworCWlmICghcGJ1ZikKKwkJcmV0dXJuOworCisJaWYgKCFwY3VyKQorCQlwY3VyID0gJnRtcDsK
KworCWlmICghc3RyX3ZhbHVlKSB7CisJCXBidWYtPkJ1ZmZlck9mZnNldCA9IGNwdV90b19sZTMy
KCpwY3VyIC0gcHN0YXJ0KTsKKwkJcGJ1Zi0+TGVuZ3RoID0gMDsKKwkJcGJ1Zi0+TWF4aW11bUxl
bmd0aCA9IDA7CisJCSpwY3VyICs9IHNpemVvZihfX2xlMTYpOworCX0gZWxzZSB7CisJCWxlbiA9
IGNpZnNfc3RydG9VVEYxNigoX19sZTE2ICopKnBjdXIsCisJCQkJICAgICAgc3RyX3ZhbHVlLAor
CQkJCSAgICAgIHN0cl9sZW5ndGgsCisJCQkJICAgICAgbmxzX2NwKTsKKwkJbGVuICo9IHNpemVv
ZihfX2xlMTYpOworCQlwYnVmLT5CdWZmZXJPZmZzZXQgPSBjcHVfdG9fbGUzMigqcGN1ciAtIHBz
dGFydCk7CisJCXBidWYtPkxlbmd0aCA9IGNwdV90b19sZTE2KGxlbik7CisJCXBidWYtPk1heGlt
dW1MZW5ndGggPSBjcHVfdG9fbGUxNihsZW4pOworCQkqcGN1ciArPSBsZW47CisJfQorfQorCiAv
KiBCQiBNb3ZlIHRvIG50bG1zc3AuYyBldmVudHVhbGx5ICovCiAKLS8qIFdlIGRvIG5vdCBtYWxs
b2MgdGhlIGJsb2IsIGl0IGlzIHBhc3NlZCBpbiBwYnVmZmVyLCBiZWNhdXNlCi0gICBpdCBpcyBm
aXhlZCBzaXplLCBhbmQgc21hbGwsIG1ha2luZyB0aGlzIGFwcHJvYWNoIGNsZWFuZXIgKi8KLXZv
aWQgYnVpbGRfbnRsbXNzcF9uZWdvdGlhdGVfYmxvYih1bnNpZ25lZCBjaGFyICpwYnVmZmVyLAot
CQkJCQkgc3RydWN0IGNpZnNfc2VzICpzZXMpCitpbnQgYnVpbGRfbnRsbXNzcF9uZWdvdGlhdGVf
YmxvYih1bnNpZ25lZCBjaGFyICoqcGJ1ZmZlciwKKwkJCQkgdTE2ICpidWZsZW4sCisJCQkJIHN0
cnVjdCBjaWZzX3NlcyAqc2VzLAorCQkJCSBjb25zdCBzdHJ1Y3QgbmxzX3RhYmxlICpubHNfY3Ap
CiB7CisJaW50IHJjID0gMDsKIAlzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIgPSBjaWZz
X3Nlc19zZXJ2ZXIoc2VzKTsKLQlORUdPVElBVEVfTUVTU0FHRSAqc2VjX2Jsb2IgPSAoTkVHT1RJ
QVRFX01FU1NBR0UgKilwYnVmZmVyOworCU5FR09USUFURV9NRVNTQUdFICpzZWNfYmxvYjsKIAlf
X3UzMiBmbGFnczsKKwl1bnNpZ25lZCBjaGFyICp0bXA7CisJaW50IGxlbjsKKworCWxlbiA9IHNp
emVfb2ZfbnRsbXNzcF9ibG9iKHNlcywgc2l6ZW9mKE5FR09USUFURV9NRVNTQUdFKSk7CisJKnBi
dWZmZXIgPSBrbWFsbG9jKGxlbiwgR0ZQX0tFUk5FTCk7CisJaWYgKCEqcGJ1ZmZlcikgeworCQly
YyA9IC1FTk9NRU07CisJCWNpZnNfZGJnKFZGUywgIkVycm9yICVkIGR1cmluZyBOVExNU1NQIGFs
bG9jYXRpb25cbiIsIHJjKTsKKwkJKmJ1ZmxlbiA9IDA7CisJCWdvdG8gc2V0dXBfbnRsbV9uZWdf
cmV0OworCX0KKwlzZWNfYmxvYiA9IChORUdPVElBVEVfTUVTU0FHRSAqKSpwYnVmZmVyOwogCi0J
bWVtc2V0KHBidWZmZXIsIDAsIHNpemVvZihORUdPVElBVEVfTUVTU0FHRSkpOworCW1lbXNldCgq
cGJ1ZmZlciwgMCwgc2l6ZW9mKE5FR09USUFURV9NRVNTQUdFKSk7CiAJbWVtY3B5KHNlY19ibG9i
LT5TaWduYXR1cmUsIE5UTE1TU1BfU0lHTkFUVVJFLCA4KTsKIAlzZWNfYmxvYi0+TWVzc2FnZVR5
cGUgPSBOdExtTmVnb3RpYXRlOwogCkBAIC02MjQsMzQgKzY5MSwyNSBAQCB2b2lkIGJ1aWxkX250
bG1zc3BfbmVnb3RpYXRlX2Jsb2IodW5zaWduZWQgY2hhciAqcGJ1ZmZlciwKIAlpZiAoIXNlcnZl
ci0+c2Vzc2lvbl9lc3RhYiB8fCBzZXMtPm50bG1zc3AtPnNlc3NrZXlfcGVyX3NtYnNlc3MpCiAJ
CWZsYWdzIHw9IE5UTE1TU1BfTkVHT1RJQVRFX0tFWV9YQ0g7CiAKKwl0bXAgPSAqcGJ1ZmZlciAr
IHNpemVvZihORUdPVElBVEVfTUVTU0FHRSk7CiAJc2VjX2Jsb2ItPk5lZ290aWF0ZUZsYWdzID0g
Y3B1X3RvX2xlMzIoZmxhZ3MpOwogCi0Jc2VjX2Jsb2ItPldvcmtzdGF0aW9uTmFtZS5CdWZmZXJP
ZmZzZXQgPSAwOwotCXNlY19ibG9iLT5Xb3Jrc3RhdGlvbk5hbWUuTGVuZ3RoID0gMDsKLQlzZWNf
YmxvYi0+V29ya3N0YXRpb25OYW1lLk1heGltdW1MZW5ndGggPSAwOwotCi0JLyogRG9tYWluIG5h
bWUgaXMgc2VudCBvbiB0aGUgQ2hhbGxlbmdlIG5vdCBOZWdvdGlhdGUgTlRMTVNTUCByZXF1ZXN0
ICovCi0Jc2VjX2Jsb2ItPkRvbWFpbk5hbWUuQnVmZmVyT2Zmc2V0ID0gMDsKLQlzZWNfYmxvYi0+
RG9tYWluTmFtZS5MZW5ndGggPSAwOwotCXNlY19ibG9iLT5Eb21haW5OYW1lLk1heGltdW1MZW5n
dGggPSAwOwotfQotCi1zdGF0aWMgaW50IHNpemVfb2ZfbnRsbXNzcF9ibG9iKHN0cnVjdCBjaWZz
X3NlcyAqc2VzKQotewotCWludCBzeiA9IHNpemVvZihBVVRIRU5USUNBVEVfTUVTU0FHRSkgKyBz
ZXMtPmF1dGhfa2V5LmxlbgotCQktIENJRlNfU0VTU19LRVlfU0laRSArIENJRlNfQ1BIVFhUX1NJ
WkUgKyAyOwotCi0JaWYgKHNlcy0+ZG9tYWluTmFtZSkKLQkJc3ogKz0gMiAqIHN0cm5sZW4oc2Vz
LT5kb21haW5OYW1lLCBDSUZTX01BWF9ET01BSU5OQU1FX0xFTik7Ci0JZWxzZQotCQlzeiArPSAy
OworCS8qIHRoZXNlIGZpZWxkcyBzaG91bGQgYmUgbnVsbCBpbiBuZWdvdGlhdGUgcGhhc2UgTVMt
TkxNUCAzLjEuNS4xLjEgKi8KKwljaWZzX3NlY3VyaXR5X2J1ZmZlcl9mcm9tX3N0cigmc2VjX2Js
b2ItPkRvbWFpbk5hbWUsCisJCQkJICAgICAgTlVMTCwKKwkJCQkgICAgICBDSUZTX01BWF9ET01B
SU5OQU1FX0xFTiwKKwkJCQkgICAgICAqcGJ1ZmZlciwgJnRtcCwKKwkJCQkgICAgICBubHNfY3Ap
OwogCi0JaWYgKHNlcy0+dXNlcl9uYW1lKQotCQlzeiArPSAyICogc3RybmxlbihzZXMtPnVzZXJf
bmFtZSwgQ0lGU19NQVhfVVNFUk5BTUVfTEVOKTsKLQllbHNlCi0JCXN6ICs9IDI7CisJY2lmc19z
ZWN1cml0eV9idWZmZXJfZnJvbV9zdHIoJnNlY19ibG9iLT5Xb3Jrc3RhdGlvbk5hbWUsCisJCQkJ
ICAgICAgTlVMTCwKKwkJCQkgICAgICBDSUZTX01BWF9XT1JLU1RBVElPTl9MRU4sCisJCQkJICAg
ICAgKnBidWZmZXIsICZ0bXAsCisJCQkJICAgICAgbmxzX2NwKTsKIAotCXJldHVybiBzejsKKwkq
YnVmbGVuID0gdG1wIC0gKnBidWZmZXI7CitzZXR1cF9udGxtX25lZ19yZXQ6CisJcmV0dXJuIHJj
OwogfQogCiBpbnQgYnVpbGRfbnRsbXNzcF9hdXRoX2Jsb2IodW5zaWduZWQgY2hhciAqKnBidWZm
ZXIsCkBAIC02NjMsNiArNzIxLDcgQEAgaW50IGJ1aWxkX250bG1zc3BfYXV0aF9ibG9iKHVuc2ln
bmVkIGNoYXIgKipwYnVmZmVyLAogCUFVVEhFTlRJQ0FURV9NRVNTQUdFICpzZWNfYmxvYjsKIAlf
X3UzMiBmbGFnczsKIAl1bnNpZ25lZCBjaGFyICp0bXA7CisJaW50IGxlbjsKIAogCXJjID0gc2V0
dXBfbnRsbXYyX3JzcChzZXMsIG5sc19jcCk7CiAJaWYgKHJjKSB7CkBAIC02NzAsNyArNzI5LDkg
QEAgaW50IGJ1aWxkX250bG1zc3BfYXV0aF9ibG9iKHVuc2lnbmVkIGNoYXIgKipwYnVmZmVyLAog
CQkqYnVmbGVuID0gMDsKIAkJZ290byBzZXR1cF9udGxtdjJfcmV0OwogCX0KLQkqcGJ1ZmZlciA9
IGttYWxsb2Moc2l6ZV9vZl9udGxtc3NwX2Jsb2Ioc2VzKSwgR0ZQX0tFUk5FTCk7CisKKwlsZW4g
PSBzaXplX29mX250bG1zc3BfYmxvYihzZXMsIHNpemVvZihBVVRIRU5USUNBVEVfTUVTU0FHRSkp
OworCSpwYnVmZmVyID0ga21hbGxvYyhsZW4sIEdGUF9LRVJORUwpOwogCWlmICghKnBidWZmZXIp
IHsKIAkJcmMgPSAtRU5PTUVNOwogCQljaWZzX2RiZyhWRlMsICJFcnJvciAlZCBkdXJpbmcgTlRM
TVNTUCBhbGxvY2F0aW9uXG4iLCByYyk7CkBAIC02ODYsNyArNzQ3LDcgQEAgaW50IGJ1aWxkX250
bG1zc3BfYXV0aF9ibG9iKHVuc2lnbmVkIGNoYXIgKipwYnVmZmVyLAogCQlOVExNU1NQX1JFUVVF
U1RfVEFSR0VUIHwgTlRMTVNTUF9ORUdPVElBVEVfVEFSR0VUX0lORk8gfAogCQlOVExNU1NQX05F
R09USUFURV8xMjggfCBOVExNU1NQX05FR09USUFURV9VTklDT0RFIHwKIAkJTlRMTVNTUF9ORUdP
VElBVEVfTlRMTSB8IE5UTE1TU1BfTkVHT1RJQVRFX0VYVEVOREVEX1NFQyB8Ci0JCU5UTE1TU1Bf
TkVHT1RJQVRFX1NFQUw7CisJCU5UTE1TU1BfTkVHT1RJQVRFX1NFQUwgfCBOVExNU1NQX05FR09U
SUFURV9XT1JLU1RBVElPTl9TVVBQTElFRDsKIAlpZiAoc2VzLT5zZXJ2ZXItPnNpZ24pCiAJCWZs
YWdzIHw9IE5UTE1TU1BfTkVHT1RJQVRFX1NJR047CiAJaWYgKCFzZXMtPnNlcnZlci0+c2Vzc2lv
bl9lc3RhYiB8fCBzZXMtPm50bG1zc3AtPnNlc3NrZXlfcGVyX3NtYnNlc3MpCkBAIC03MTksNDIg
Kzc4MCwyMyBAQCBpbnQgYnVpbGRfbnRsbXNzcF9hdXRoX2Jsb2IodW5zaWduZWQgY2hhciAqKnBi
dWZmZXIsCiAJCXNlY19ibG9iLT5OdENoYWxsZW5nZVJlc3BvbnNlLk1heGltdW1MZW5ndGggPSAw
OwogCX0KIAotCWlmIChzZXMtPmRvbWFpbk5hbWUgPT0gTlVMTCkgewotCQlzZWNfYmxvYi0+RG9t
YWluTmFtZS5CdWZmZXJPZmZzZXQgPSBjcHVfdG9fbGUzMih0bXAgLSAqcGJ1ZmZlcik7Ci0JCXNl
Y19ibG9iLT5Eb21haW5OYW1lLkxlbmd0aCA9IDA7Ci0JCXNlY19ibG9iLT5Eb21haW5OYW1lLk1h
eGltdW1MZW5ndGggPSAwOwotCQl0bXAgKz0gMjsKLQl9IGVsc2UgewotCQlpbnQgbGVuOwotCQls
ZW4gPSBjaWZzX3N0cnRvVVRGMTYoKF9fbGUxNiAqKXRtcCwgc2VzLT5kb21haW5OYW1lLAotCQkJ
CSAgICAgIENJRlNfTUFYX0RPTUFJTk5BTUVfTEVOLCBubHNfY3ApOwotCQlsZW4gKj0gMjsgLyog
dW5pY29kZSBpcyAyIGJ5dGVzIGVhY2ggKi8KLQkJc2VjX2Jsb2ItPkRvbWFpbk5hbWUuQnVmZmVy
T2Zmc2V0ID0gY3B1X3RvX2xlMzIodG1wIC0gKnBidWZmZXIpOwotCQlzZWNfYmxvYi0+RG9tYWlu
TmFtZS5MZW5ndGggPSBjcHVfdG9fbGUxNihsZW4pOwotCQlzZWNfYmxvYi0+RG9tYWluTmFtZS5N
YXhpbXVtTGVuZ3RoID0gY3B1X3RvX2xlMTYobGVuKTsKLQkJdG1wICs9IGxlbjsKLQl9CisJY2lm
c19zZWN1cml0eV9idWZmZXJfZnJvbV9zdHIoJnNlY19ibG9iLT5Eb21haW5OYW1lLAorCQkJCSAg
ICAgIHNlcy0+ZG9tYWluTmFtZSwKKwkJCQkgICAgICBDSUZTX01BWF9ET01BSU5OQU1FX0xFTiwK
KwkJCQkgICAgICAqcGJ1ZmZlciwgJnRtcCwKKwkJCQkgICAgICBubHNfY3ApOwogCi0JaWYgKHNl
cy0+dXNlcl9uYW1lID09IE5VTEwpIHsKLQkJc2VjX2Jsb2ItPlVzZXJOYW1lLkJ1ZmZlck9mZnNl
dCA9IGNwdV90b19sZTMyKHRtcCAtICpwYnVmZmVyKTsKLQkJc2VjX2Jsb2ItPlVzZXJOYW1lLkxl
bmd0aCA9IDA7Ci0JCXNlY19ibG9iLT5Vc2VyTmFtZS5NYXhpbXVtTGVuZ3RoID0gMDsKLQkJdG1w
ICs9IDI7Ci0JfSBlbHNlIHsKLQkJaW50IGxlbjsKLQkJbGVuID0gY2lmc19zdHJ0b1VURjE2KChf
X2xlMTYgKil0bXAsIHNlcy0+dXNlcl9uYW1lLAotCQkJCSAgICAgIENJRlNfTUFYX1VTRVJOQU1F
X0xFTiwgbmxzX2NwKTsKLQkJbGVuICo9IDI7IC8qIHVuaWNvZGUgaXMgMiBieXRlcyBlYWNoICov
Ci0JCXNlY19ibG9iLT5Vc2VyTmFtZS5CdWZmZXJPZmZzZXQgPSBjcHVfdG9fbGUzMih0bXAgLSAq
cGJ1ZmZlcik7Ci0JCXNlY19ibG9iLT5Vc2VyTmFtZS5MZW5ndGggPSBjcHVfdG9fbGUxNihsZW4p
OwotCQlzZWNfYmxvYi0+VXNlck5hbWUuTWF4aW11bUxlbmd0aCA9IGNwdV90b19sZTE2KGxlbik7
Ci0JCXRtcCArPSBsZW47Ci0JfQorCWNpZnNfc2VjdXJpdHlfYnVmZmVyX2Zyb21fc3RyKCZzZWNf
YmxvYi0+VXNlck5hbWUsCisJCQkJICAgICAgc2VzLT51c2VyX25hbWUsCisJCQkJICAgICAgQ0lG
U19NQVhfVVNFUk5BTUVfTEVOLAorCQkJCSAgICAgICpwYnVmZmVyLCAmdG1wLAorCQkJCSAgICAg
IG5sc19jcCk7CiAKLQlzZWNfYmxvYi0+V29ya3N0YXRpb25OYW1lLkJ1ZmZlck9mZnNldCA9IGNw
dV90b19sZTMyKHRtcCAtICpwYnVmZmVyKTsKLQlzZWNfYmxvYi0+V29ya3N0YXRpb25OYW1lLkxl
bmd0aCA9IDA7Ci0Jc2VjX2Jsb2ItPldvcmtzdGF0aW9uTmFtZS5NYXhpbXVtTGVuZ3RoID0gMDsK
LQl0bXAgKz0gMjsKKwljaWZzX3NlY3VyaXR5X2J1ZmZlcl9mcm9tX3N0cigmc2VjX2Jsb2ItPldv
cmtzdGF0aW9uTmFtZSwKKwkJCQkgICAgICBzZXMtPndvcmtzdGF0aW9uX25hbWUsCisJCQkJICAg
ICAgQ0lGU19NQVhfV09SS1NUQVRJT05fTEVOLAorCQkJCSAgICAgICpwYnVmZmVyLCAmdG1wLAor
CQkJCSAgICAgIG5sc19jcCk7CiAKIAlpZiAoKChzZXMtPm50bG1zc3AtPnNlcnZlcl9mbGFncyAm
IE5UTE1TU1BfTkVHT1RJQVRFX0tFWV9YQ0gpIHx8CiAJCShzZXMtPm50bG1zc3AtPnNlcnZlcl9m
bGFncyAmIE5UTE1TU1BfTkVHT1RJQVRFX0VYVEVOREVEX1NFQykpCkBAIC0xMjMwLDYgKzEyNzIs
NyBAQCBzZXNzX2F1dGhfcmF3bnRsbXNzcF9uZWdvdGlhdGUoc3RydWN0IHNlc3NfZGF0YSAqc2Vz
c19kYXRhKQogCXN0cnVjdCBjaWZzX3NlcyAqc2VzID0gc2Vzc19kYXRhLT5zZXM7CiAJX191MTYg
Ynl0ZXNfcmVtYWluaW5nOwogCWNoYXIgKmJjY19wdHI7CisJdW5zaWduZWQgY2hhciAqbnRsbXNz
cGJsb2IgPSBOVUxMOwogCXUxNiBibG9iX2xlbjsKIAogCWNpZnNfZGJnKEZZSSwgInJhd250bG1z
c3Agc2Vzc2lvbiBzZXR1cCBuZWdvdGlhdGUgcGhhc2VcbiIpOwpAQCAtMTI1MywxMCArMTI5Niwx
NSBAQCBzZXNzX2F1dGhfcmF3bnRsbXNzcF9uZWdvdGlhdGUoc3RydWN0IHNlc3NfZGF0YSAqc2Vz
c19kYXRhKQogCXBTTUIgPSAoU0VTU0lPTl9TRVRVUF9BTkRYICopc2Vzc19kYXRhLT5pb3ZbMF0u
aW92X2Jhc2U7CiAKIAkvKiBCdWlsZCBzZWN1cml0eSBibG9iIGJlZm9yZSB3ZSBhc3NlbWJsZSB0
aGUgcmVxdWVzdCAqLwotCWJ1aWxkX250bG1zc3BfbmVnb3RpYXRlX2Jsb2IocFNNQi0+cmVxLlNl
Y3VyaXR5QmxvYiwgc2VzKTsKLQlzZXNzX2RhdGEtPmlvdlsxXS5pb3ZfbGVuID0gc2l6ZW9mKE5F
R09USUFURV9NRVNTQUdFKTsKLQlzZXNzX2RhdGEtPmlvdlsxXS5pb3ZfYmFzZSA9IHBTTUItPnJl
cS5TZWN1cml0eUJsb2I7Ci0JcFNNQi0+cmVxLlNlY3VyaXR5QmxvYkxlbmd0aCA9IGNwdV90b19s
ZTE2KHNpemVvZihORUdPVElBVEVfTUVTU0FHRSkpOworCXJjID0gYnVpbGRfbnRsbXNzcF9uZWdv
dGlhdGVfYmxvYigmbnRsbXNzcGJsb2IsCisJCQkJICAgICAmYmxvYl9sZW4sIHNlcywKKwkJCQkg
ICAgIHNlc3NfZGF0YS0+bmxzX2NwKTsKKwlpZiAocmMpCisJCWdvdG8gb3V0OworCisJc2Vzc19k
YXRhLT5pb3ZbMV0uaW92X2xlbiA9IGJsb2JfbGVuOworCXNlc3NfZGF0YS0+aW92WzFdLmlvdl9i
YXNlID0gbnRsbXNzcGJsb2I7CisJcFNNQi0+cmVxLlNlY3VyaXR5QmxvYkxlbmd0aCA9IGNwdV90
b19sZTE2KGJsb2JfbGVuKTsKIAogCXJjID0gX3Nlc3NfYXV0aF9yYXdudGxtc3NwX2Fzc2VtYmxl
X3JlcShzZXNzX2RhdGEpOwogCWlmIChyYykKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvc21iMnBkdS5j
IGIvZnMvY2lmcy9zbWIycGR1LmMKaW5kZXggZDJlY2IyZWEzN2MwLi41MDM0ZTUzYTQ5ZTcgMTAw
NjQ0Ci0tLSBhL2ZzL2NpZnMvc21iMnBkdS5jCisrKyBiL2ZzL2NpZnMvc21iMnBkdS5jCkBAIC0x
NDU2LDcgKzE0NTYsNyBAQCBTTUIyX3Nlc3NfYXV0aF9yYXdudGxtc3NwX25lZ290aWF0ZShzdHJ1
Y3QgU01CMl9zZXNzX2RhdGEgKnNlc3NfZGF0YSkKIAlpbnQgcmM7CiAJc3RydWN0IGNpZnNfc2Vz
ICpzZXMgPSBzZXNzX2RhdGEtPnNlczsKIAlzdHJ1Y3Qgc21iMl9zZXNzX3NldHVwX3JzcCAqcnNw
ID0gTlVMTDsKLQljaGFyICpudGxtc3NwX2Jsb2IgPSBOVUxMOworCXVuc2lnbmVkIGNoYXIgKm50
bG1zc3BfYmxvYiA9IE5VTEw7CiAJYm9vbCB1c2Vfc3BuZWdvID0gZmFsc2U7IC8qIGVsc2UgdXNl
IHJhdyBudGxtc3NwICovCiAJdTE2IGJsb2JfbGVuZ3RoID0gMDsKIApAQCAtMTQ3NSwyMiArMTQ3
NSwxNyBAQCBTTUIyX3Nlc3NfYXV0aF9yYXdudGxtc3NwX25lZ290aWF0ZShzdHJ1Y3QgU01CMl9z
ZXNzX2RhdGEgKnNlc3NfZGF0YSkKIAlpZiAocmMpCiAJCWdvdG8gb3V0X2VycjsKIAotCW50bG1z
c3BfYmxvYiA9IGttYWxsb2Moc2l6ZW9mKHN0cnVjdCBfTkVHT1RJQVRFX01FU1NBR0UpLAotCQkJ
ICAgICAgIEdGUF9LRVJORUwpOwotCWlmIChudGxtc3NwX2Jsb2IgPT0gTlVMTCkgewotCQlyYyA9
IC1FTk9NRU07Ci0JCWdvdG8gb3V0OwotCX0KKwlyYyA9IGJ1aWxkX250bG1zc3BfbmVnb3RpYXRl
X2Jsb2IoJm50bG1zc3BfYmxvYiwKKwkJCQkJICAmYmxvYl9sZW5ndGgsIHNlcywKKwkJCQkJICBz
ZXNzX2RhdGEtPm5sc19jcCk7CisJaWYgKHJjKQorCQlnb3RvIG91dF9lcnI7CiAKLQlidWlsZF9u
dGxtc3NwX25lZ290aWF0ZV9ibG9iKG50bG1zc3BfYmxvYiwgc2VzKTsKIAlpZiAodXNlX3NwbmVn
bykgewogCQkvKiBCQiBldmVudHVhbGx5IG5lZWQgdG8gYWRkIHRoaXMgKi8KIAkJY2lmc19kYmco
VkZTLCAic3BuZWdvIG5vdCBzdXBwb3J0ZWQgZm9yIFNNQjIgeWV0XG4iKTsKIAkJcmMgPSAtRU9Q
Tk9UU1VQUDsKIAkJZ290byBvdXQ7Ci0JfSBlbHNlIHsKLQkJYmxvYl9sZW5ndGggPSBzaXplb2Yo
c3RydWN0IF9ORUdPVElBVEVfTUVTU0FHRSk7Ci0JCS8qIHdpdGggcmF3IE5UTE1TU1Agd2UgZG9u
J3QgZW5jYXBzdWxhdGUgaW4gU1BORUdPICovCiAJfQogCXNlc3NfZGF0YS0+aW92WzFdLmlvdl9i
YXNlID0gbnRsbXNzcF9ibG9iOwogCXNlc3NfZGF0YS0+aW92WzFdLmlvdl9sZW4gPSBibG9iX2xl
bmd0aDsKLS0gCjIuMzIuMAoK
--000000000000c3757305d04a85e2--
