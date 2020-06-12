Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E30191F7585
	for <lists+linux-cifs@lfdr.de>; Fri, 12 Jun 2020 10:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726327AbgFLI4g (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 12 Jun 2020 04:56:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726319AbgFLI4f (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 12 Jun 2020 04:56:35 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FD98C03E96F
        for <linux-cifs@vger.kernel.org>; Fri, 12 Jun 2020 01:56:35 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id o4so4559419ybp.0
        for <linux-cifs@vger.kernel.org>; Fri, 12 Jun 2020 01:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=GljV///iV620qztHSQ6mDOi2C+U59nk6tthjY3B52gk=;
        b=ZkBFJS7IVh1utJ6bC3Ob8YuZrEQSHAMHZEQkxbEKEk0qIpILPX6OdkRi4eCOICkrAp
         XlFFxSATeRaIwmPf+9kq4iUwaz7422yWtCTks3GgeBjwY5gKgcmtImngnGkumAp4rDZv
         IchRC314a0CNot4FxVcSenbMt1ECOmb6sTz1vNfjRNODTgdHCzGLytmvDzzi4mSj+PCJ
         tENzTQIuy8AyG0uH/eGIcdfx+EAol3SXOc9S6oaAPBto1+uz1LALGeA/1gOErfbzKrZw
         3G5nlgu4oYN9errTJZh3c8fxclM3McWm6yVXDEkxlpLiAjsVS/iQkQU7g/9ey+Ld34fG
         +JIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=GljV///iV620qztHSQ6mDOi2C+U59nk6tthjY3B52gk=;
        b=oM5lVkvtA3CEvQ/j190morYUPpgzguBvaYhgZkS5N7qZeB4ExGH5BBftYz6D6aLmQb
         9tYsT31EOY1pjDmYLgGPLH6jCk1qFErZ9hbncH4AGr+BzFc1GYD0GOuAoc4gWc3XJUu7
         VyVK4RBAlhzd+OugJVxMjtVFZLH0/4sMjtyXDEj/fk+cer/+zpEE6eNJrM2Qu7i7Wooq
         yYh+tlr/5TltMKQNk1O+gOiqj4Mi+jk1G0nJwbHxA2GYUtFgxK+YqUGh1PFfc60ssWvM
         5+i/euh318HPurZQZXwJxA99Ln/VZ3ABSucwx1m9+oaxHMd2V2/fs8Rq5j5thK5hCDMy
         VUOg==
X-Gm-Message-State: AOAM533uLWilRaBZJrg6blIMins69S9Jy66cTP5Zj7PQrxb3fMgelbsY
        Y8ihIzeT80f8Zt7sHLZx4SpPvjUH4F/lzVSccBokgRkw
X-Google-Smtp-Source: ABdhPJyMmIkY35qcTFg/xnzar2RgqcIYGUSJpn96GXOlRIHj3UL93Ur2IHtqov8tM8jEdw4/TB459XBNtVRYmEmIE1M=
X-Received: by 2002:a25:bc81:: with SMTP id e1mr9625548ybk.375.1591952193189;
 Fri, 12 Jun 2020 01:56:33 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 12 Jun 2020 03:56:21 -0500
Message-ID: <CAH2r5mvJ3U_-EegHZwSPiaW7b8yA_PLqJhAHPdVJZE=5R8y=Qg@mail.gmail.com>
Subject: [PATCH][SMB3] Add support for POSIX Extension info level on query info
To:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000fa291005a7df40b4"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--000000000000fa291005a7df40b4
Content-Type: text/plain; charset="UTF-8"

We were only using level 100 (posix info level) on query dir not the
compounded query file info.



-- 
Thanks,

Steve

--000000000000fa291005a7df40b4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0003-smb311-Add-support-for-lookup-with-posix-extensions-.patch"
Content-Disposition: attachment; 
	filename="0003-smb311-Add-support-for-lookup-with-posix-extensions-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kbbz82f63>
X-Attachment-Id: f_kbbz82f63

RnJvbSA0MTBkY2IwNGViYjFjMmI4YmI5MWM0ZjBkYWE3MWY5ZmU0MzBlYWFjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFRodSwgMTEgSnVuIDIwMjAgMjI6Mjg6NDkgLTA1MDAKU3ViamVjdDogW1BBVENIIDMv
NV0gc21iMzExOiBBZGQgc3VwcG9ydCBmb3IgbG9va3VwIHdpdGggcG9zaXggZXh0ZW5zaW9ucwog
cXVlcnkgaW5mbwoKSW1wcm92ZSBzdXBwb3J0IGZvciBsb29rdXAgd2hlbiB1c2luZyBTTUIzLjEu
MSBwb3NpeCBtb3VudHMuClVzZSBuZXcgaW5mbyBsZXZlbCAxMDAgKHBvc2l4IHF1ZXJ5IGluZm8p
CgpTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0t
LQogZnMvY2lmcy9kaXIuYyB8IDQgKysrLQogMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygr
KSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvZGlyLmMgYi9mcy9jaWZzL2Rp
ci5jCmluZGV4IDM2ZTdiMmZkMjE5MC4uYWE2MWZmYWI4YWI4IDEwMDY0NAotLS0gYS9mcy9jaWZz
L2Rpci5jCisrKyBiL2ZzL2NpZnMvZGlyLmMKQEAgLTcwMCw3ICs3MDAsOSBAQCBjaWZzX2xvb2t1
cChzdHJ1Y3QgaW5vZGUgKnBhcmVudF9kaXJfaW5vZGUsIHN0cnVjdCBkZW50cnkgKmRpcmVudHJ5
LAogCWNpZnNfZGJnKEZZSSwgIkZ1bGwgcGF0aDogJXMgaW5vZGUgPSAweCVwXG4iLAogCQkgZnVs
bF9wYXRoLCBkX2lub2RlKGRpcmVudHJ5KSk7CiAKLQlpZiAocFRjb24tPnVuaXhfZXh0KSB7CisJ
aWYgKHBUY29uLT5wb3NpeF9leHRlbnNpb25zKQorCQlyYyA9IHNtYjMxMV9wb3NpeF9nZXRfaW5v
ZGVfaW5mbygmbmV3SW5vZGUsIGZ1bGxfcGF0aCwgcGFyZW50X2Rpcl9pbm9kZS0+aV9zYiwgeGlk
KTsKKwllbHNlIGlmIChwVGNvbi0+dW5peF9leHQpIHsKIAkJcmMgPSBjaWZzX2dldF9pbm9kZV9p
bmZvX3VuaXgoJm5ld0lub2RlLCBmdWxsX3BhdGgsCiAJCQkJCSAgICAgIHBhcmVudF9kaXJfaW5v
ZGUtPmlfc2IsIHhpZCk7CiAJfSBlbHNlIHsKLS0gCjIuMjUuMQoK
--000000000000fa291005a7df40b4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0004-smb311-add-support-for-using-info-level-for-posix-ex.patch"
Content-Disposition: attachment; 
	filename="0004-smb311-add-support-for-using-info-level-for-posix-ex.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kbbz82f02>
X-Attachment-Id: f_kbbz82f02

RnJvbSBlZmUwZWE1NTcwZTQ0N2NmODIyNDdlNTY4MTlhOTM0MmRhMDQ2YzdkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFRodSwgMTEgSnVuIDIwMjAgMjI6NDM6MDEgLTA1MDAKU3ViamVjdDogW1BBVENIIDQv
NV0gc21iMzExOiBhZGQgc3VwcG9ydCBmb3IgdXNpbmcgaW5mbyBsZXZlbCBmb3IgcG9zaXgKIGV4
dGVuc2lvbnMgcXVlcnkKCkFkZHMgY2FsbHMgdG8gdGhlIG5ld2VyIGluZm8gbGV2ZWwgZm9yIHF1
ZXJ5IGluZm8gdXNpbmcgU01CMy4xLjEgcG9zaXggZXh0ZW5zaW9ucy4KVGhlIHJlbWFpbmluZyB0
d28gcGxhY2VzIHRoYXQgY2FsbCB0aGUgb2xkZXIgcXVlcnkgaW5mbyAobm9uLVNNQjMuMS4xIFBP
U0lYKQpyZXF1aXJlIHBhc3NpbmcgaW4gdGhlIGZpZCBhbmQgY2FuIGJlIHVwZGF0ZWQgaW4gYSBs
YXRlciBwYXRjaC4KClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9z
b2Z0LmNvbT4KLS0tCiBmcy9jaWZzL2Rpci5jICAgfCAxICsKIGZzL2NpZnMvZmlsZS5jICB8IDUg
KysrKy0KIGZzL2NpZnMvaW5vZGUuYyB8IDkgKysrKysrKy0tCiBmcy9jaWZzL2xpbmsuYyAgfCA0
ICsrKy0KIDQgZmlsZXMgY2hhbmdlZCwgMTUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkK
CmRpZmYgLS1naXQgYS9mcy9jaWZzL2Rpci5jIGIvZnMvY2lmcy9kaXIuYwppbmRleCBhYTYxZmZh
YjhhYjguLjM5OGMxZWVmNzE5MCAxMDA2NDQKLS0tIGEvZnMvY2lmcy9kaXIuYworKysgYi9mcy9j
aWZzL2Rpci5jCkBAIC00MTEsNiArNDExLDcgQEAgY2lmc19kb19jcmVhdGUoc3RydWN0IGlub2Rl
ICppbm9kZSwgc3RydWN0IGRlbnRyeSAqZGlyZW50cnksIHVuc2lnbmVkIGludCB4aWQsCiAJCXJj
ID0gY2lmc19nZXRfaW5vZGVfaW5mb191bml4KCZuZXdpbm9kZSwgZnVsbF9wYXRoLCBpbm9kZS0+
aV9zYiwKIAkJCQkJICAgICAgeGlkKTsKIAllbHNlIHsKKwkJLyogVE9ETzogQWRkIHN1cHBvcnQg
Zm9yIGNhbGxpbmcgUE9TSVggcXVlcnkgaW5mbyBoZXJlLCBidXQgcGFzc2luZyBpbiBmaWQgKi8K
IAkJcmMgPSBjaWZzX2dldF9pbm9kZV9pbmZvKCZuZXdpbm9kZSwgZnVsbF9wYXRoLCBidWYsIGlu
b2RlLT5pX3NiLAogCQkJCQkgeGlkLCBmaWQpOwogCQlpZiAobmV3aW5vZGUpIHsKZGlmZiAtLWdp
dCBhL2ZzL2NpZnMvZmlsZS5jIGIvZnMvY2lmcy9maWxlLmMKaW5kZXggODI3Nzg1OWQxMmEzLi40
ZmU3NTdjZmMzNjAgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvZmlsZS5jCisrKyBiL2ZzL2NpZnMvZmls
ZS5jCkBAIC0yNDMsNiArMjQzLDcgQEAgY2lmc19udF9vcGVuKGNoYXIgKmZ1bGxfcGF0aCwgc3Ry
dWN0IGlub2RlICppbm9kZSwgc3RydWN0IGNpZnNfc2JfaW5mbyAqY2lmc19zYiwKIAlpZiAocmMp
CiAJCWdvdG8gb3V0OwogCisJLyogVE9ETzogQWRkIHN1cHBvcnQgZm9yIGNhbGxpbmcgcG9zaXgg
cXVlcnkgaW5mbyBidXQgd2l0aCBwYXNzaW5nIGluIGZpZCAqLwogCWlmICh0Y29uLT51bml4X2V4
dCkKIAkJcmMgPSBjaWZzX2dldF9pbm9kZV9pbmZvX3VuaXgoJmlub2RlLCBmdWxsX3BhdGgsIGlu
b2RlLT5pX3NiLAogCQkJCQkgICAgICB4aWQpOwpAQCAtODAwLDcgKzgwMSw5IEBAIGNpZnNfcmVv
cGVuX2ZpbGUoc3RydWN0IGNpZnNGaWxlSW5mbyAqY2ZpbGUsIGJvb2wgY2FuX2ZsdXNoKQogCQlp
ZiAoIWlzX2ludGVycnVwdF9lcnJvcihyYykpCiAJCQltYXBwaW5nX3NldF9lcnJvcihpbm9kZS0+
aV9tYXBwaW5nLCByYyk7CiAKLQkJaWYgKHRjb24tPnVuaXhfZXh0KQorCQlpZiAodGNvbi0+cG9z
aXhfZXh0ZW5zaW9ucykKKwkJCXJjID0gc21iMzExX3Bvc2l4X2dldF9pbm9kZV9pbmZvKCZpbm9k
ZSwgZnVsbF9wYXRoLCBpbm9kZS0+aV9zYiwgeGlkKTsKKwkJZWxzZSBpZiAodGNvbi0+dW5peF9l
eHQpCiAJCQlyYyA9IGNpZnNfZ2V0X2lub2RlX2luZm9fdW5peCgmaW5vZGUsIGZ1bGxfcGF0aCwK
IAkJCQkJCSAgICAgIGlub2RlLT5pX3NiLCB4aWQpOwogCQllbHNlCmRpZmYgLS1naXQgYS9mcy9j
aWZzL2lub2RlLmMgYi9mcy9jaWZzL2lub2RlLmMKaW5kZXggNzU4NDIwNjZmNDU2Li45MjQyOTAy
MzU0YzcgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvaW5vZGUuYworKysgYi9mcy9jaWZzL2lub2RlLmMK
QEAgLTEzMzMsNyArMTMzMywxMCBAQCBzdHJ1Y3QgaW5vZGUgKmNpZnNfcm9vdF9pZ2V0KHN0cnVj
dCBzdXBlcl9ibG9jayAqc2IpCiAJfQogCiAJY29udmVydF9kZWxpbWl0ZXIocGF0aCwgQ0lGU19E
SVJfU0VQKGNpZnNfc2IpKTsKLQlyYyA9IGNpZnNfZ2V0X2lub2RlX2luZm8oJmlub2RlLCBwYXRo
LCBOVUxMLCBzYiwgeGlkLCBOVUxMKTsKKwlpZiAodGNvbi0+cG9zaXhfZXh0ZW5zaW9ucykKKwkJ
cmMgPSBzbWIzMTFfcG9zaXhfZ2V0X2lub2RlX2luZm8oJmlub2RlLCBwYXRoLCBzYiwgeGlkKTsK
KwllbHNlCisJCXJjID0gY2lmc19nZXRfaW5vZGVfaW5mbygmaW5vZGUsIHBhdGgsIE5VTEwsIHNi
LCB4aWQsIE5VTEwpOwogCiBpZ2V0X25vX3JldHJ5OgogCWlmICghaW5vZGUpIHsKQEAgLTE2ODks
NyArMTY5Miw5IEBAIGNpZnNfbWtkaXJfcWluZm8oc3RydWN0IGlub2RlICpwYXJlbnQsIHN0cnVj
dCBkZW50cnkgKmRlbnRyeSwgdW1vZGVfdCBtb2RlLAogCWludCByYyA9IDA7CiAJc3RydWN0IGlu
b2RlICppbm9kZSA9IE5VTEw7CiAKLQlpZiAodGNvbi0+dW5peF9leHQpCisJaWYgKHRjb24tPnBv
c2l4X2V4dGVuc2lvbnMpCisJCXJjID0gc21iMzExX3Bvc2l4X2dldF9pbm9kZV9pbmZvKCZpbm9k
ZSwgZnVsbF9wYXRoLCBwYXJlbnQtPmlfc2IsIHhpZCk7CisJZWxzZSBpZiAodGNvbi0+dW5peF9l
eHQpCiAJCXJjID0gY2lmc19nZXRfaW5vZGVfaW5mb191bml4KCZpbm9kZSwgZnVsbF9wYXRoLCBw
YXJlbnQtPmlfc2IsCiAJCQkJCSAgICAgIHhpZCk7CiAJZWxzZQpkaWZmIC0tZ2l0IGEvZnMvY2lm
cy9saW5rLmMgYi9mcy9jaWZzL2xpbmsuYwppbmRleCBjMzgxZDJkMDNlZjYuLjk0ZGFiNDMwOWZi
YiAxMDA2NDQKLS0tIGEvZnMvY2lmcy9saW5rLmMKKysrIGIvZnMvY2lmcy9saW5rLmMKQEAgLTcw
MSw3ICs3MDEsOSBAQCBjaWZzX3N5bWxpbmsoc3RydWN0IGlub2RlICppbm9kZSwgc3RydWN0IGRl
bnRyeSAqZGlyZW50cnksIGNvbnN0IGNoYXIgKnN5bW5hbWUpCiAJCQkJCWNpZnNfc2JfdGFyZ2V0
LT5sb2NhbF9ubHMpOyAqLwogCiAJaWYgKHJjID09IDApIHsKLQkJaWYgKHBUY29uLT51bml4X2V4
dCkKKwkJaWYgKHBUY29uLT5wb3NpeF9leHRlbnNpb25zKQorCQkJcmMgPSBzbWIzMTFfcG9zaXhf
Z2V0X2lub2RlX2luZm8oJm5ld2lub2RlLCBmdWxsX3BhdGgsIGlub2RlLT5pX3NiLCB4aWQpOwor
CQllbHNlIGlmIChwVGNvbi0+dW5peF9leHQpCiAJCQlyYyA9IGNpZnNfZ2V0X2lub2RlX2luZm9f
dW5peCgmbmV3aW5vZGUsIGZ1bGxfcGF0aCwKIAkJCQkJCSAgICAgIGlub2RlLT5pX3NiLCB4aWQp
OwogCQllbHNlCi0tIAoyLjI1LjEKCg==
--000000000000fa291005a7df40b4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0005-smb311-Add-tracepoints-for-new-compound-posix-query-.patch"
Content-Disposition: attachment; 
	filename="0005-smb311-Add-tracepoints-for-new-compound-posix-query-.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kbbz82fa4>
X-Attachment-Id: f_kbbz82fa4

RnJvbSBiYjNiMWE0YTlmNzFiODJhNjQ3MjM0YjVkNTQ1YTc4ZWFiYTZjMDMxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFRodSwgMTEgSnVuIDIwMjAgMjM6MDI6MzMgLTA1MDAKU3ViamVjdDogW1BBVENIIDUv
NV0gc21iMzExOiBBZGQgdHJhY2Vwb2ludHMgZm9yIG5ldyBjb21wb3VuZCBwb3NpeCBxdWVyeSBp
bmZvCgpBZGQgZHluYW1pYyB0cmFjZXBvaW50cyBmb3IgbmV3IFNNQjMuMS4xLiBwb3NpeCBleHRl
bnNpb25zIHF1ZXJ5IGluZm8gbGV2ZWwgKDEwMCkKClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5j
aCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9jaWZzL3NtYjJpbm9kZS5jIHwgOSAr
KystLS0tLS0KIGZzL2NpZnMvdHJhY2UuaCAgICAgfCAzICsrKwogMiBmaWxlcyBjaGFuZ2VkLCA2
IGluc2VydGlvbnMoKyksIDYgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9zbWIy
aW5vZGUuYyBiL2ZzL2NpZnMvc21iMmlub2RlLmMKaW5kZXggNTE1NDk1NjMxMWYwLi5iOWRiNzM2
ODdlYWEgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvc21iMmlub2RlLmMKKysrIGIvZnMvY2lmcy9zbWIy
aW5vZGUuYwpAQCAtMTk4LDggKzE5OCw3IEBAIHNtYjJfY29tcG91bmRfb3AoY29uc3QgdW5zaWdu
ZWQgaW50IHhpZCwgc3RydWN0IGNpZnNfdGNvbiAqdGNvbiwKIAkJaWYgKHJjKQogCQkJZ290byBm
aW5pc2hlZDsKIAkJbnVtX3Jxc3QrKzsKLQkJdHJhY2Vfc21iM19xdWVyeV9pbmZvX2NvbXBvdW5k
X2VudGVyKHhpZCwgc2VzLT5TdWlkLCB0Y29uLT50aWQsCi0JCQkJCQkgICAgIGZ1bGxfcGF0aCk7
CisJCXRyYWNlX3NtYjNfcG9zaXhfcXVlcnlfaW5mb19jb21wb3VuZF9lbnRlcih4aWQsIHNlcy0+
U3VpZCwgdGNvbi0+dGlkLCBmdWxsX3BhdGgpOwogCQlicmVhazsKIAljYXNlIFNNQjJfT1BfREVM
RVRFOgogCQl0cmFjZV9zbWIzX2RlbGV0ZV9lbnRlcih4aWQsIHNlcy0+U3VpZCwgdGNvbi0+dGlk
LCBmdWxsX3BhdGgpOwpAQCAtNDI4LDExICs0MjcsOSBAQCBzbWIyX2NvbXBvdW5kX29wKGNvbnN0
IHVuc2lnbmVkIGludCB4aWQsIHN0cnVjdCBjaWZzX3Rjb24gKnRjb24sCiAJCWlmIChycXN0WzJd
LnJxX2lvdikKIAkJCVNNQjJfY2xvc2VfZnJlZSgmcnFzdFsyXSk7CiAJCWlmIChyYykKLQkJCXRy
YWNlX3NtYjNfcXVlcnlfaW5mb19jb21wb3VuZF9lcnIoeGlkLCAgc2VzLT5TdWlkLAotCQkJCQkJ
dGNvbi0+dGlkLCByYyk7CisJCQl0cmFjZV9zbWIzX3Bvc2l4X3F1ZXJ5X2luZm9fY29tcG91bmRf
ZXJyKHhpZCwgIHNlcy0+U3VpZCwgdGNvbi0+dGlkLCByYyk7CiAJCWVsc2UKLQkJCXRyYWNlX3Nt
YjNfcXVlcnlfaW5mb19jb21wb3VuZF9kb25lKHhpZCwgc2VzLT5TdWlkLAotCQkJCQkJdGNvbi0+
dGlkKTsKKwkJCXRyYWNlX3NtYjNfcG9zaXhfcXVlcnlfaW5mb19jb21wb3VuZF9kb25lKHhpZCwg
c2VzLT5TdWlkLCB0Y29uLT50aWQpOwogCQlicmVhazsKIAljYXNlIFNNQjJfT1BfREVMRVRFOgog
CQlpZiAocmMpCmRpZmYgLS1naXQgYS9mcy9jaWZzL3RyYWNlLmggYi9mcy9jaWZzL3RyYWNlLmgK
aW5kZXggNGNiMGQ1ZjdjZTQ1Li5lZWY0YjA4YzcyMDggMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvdHJh
Y2UuaAorKysgYi9mcy9jaWZzL3RyYWNlLmgKQEAgLTMxOCw2ICszMTgsNyBAQCBERUZJTkVfRVZF
TlQoc21iM19pbmZfY29tcG91bmRfZW50ZXJfY2xhc3MsIHNtYjNfIyNuYW1lLCAgICBcCiAJVFBf
QVJHUyh4aWQsIHRpZCwgc2VzaWQsIGZ1bGxfcGF0aCkpCiAKIERFRklORV9TTUIzX0lORl9DT01Q
T1VORF9FTlRFUl9FVkVOVChxdWVyeV9pbmZvX2NvbXBvdW5kX2VudGVyKTsKK0RFRklORV9TTUIz
X0lORl9DT01QT1VORF9FTlRFUl9FVkVOVChwb3NpeF9xdWVyeV9pbmZvX2NvbXBvdW5kX2VudGVy
KTsKIERFRklORV9TTUIzX0lORl9DT01QT1VORF9FTlRFUl9FVkVOVChoYXJkbGlua19lbnRlcik7
CiBERUZJTkVfU01CM19JTkZfQ09NUE9VTkRfRU5URVJfRVZFTlQocmVuYW1lX2VudGVyKTsKIERF
RklORV9TTUIzX0lORl9DT01QT1VORF9FTlRFUl9FVkVOVChybWRpcl9lbnRlcik7CkBAIC0zNTQs
NiArMzU1LDcgQEAgREVGSU5FX0VWRU5UKHNtYjNfaW5mX2NvbXBvdW5kX2RvbmVfY2xhc3MsIHNt
YjNfIyNuYW1lLCAgICBcCiAJVFBfQVJHUyh4aWQsIHRpZCwgc2VzaWQpKQogCiBERUZJTkVfU01C
M19JTkZfQ09NUE9VTkRfRE9ORV9FVkVOVChxdWVyeV9pbmZvX2NvbXBvdW5kX2RvbmUpOworREVG
SU5FX1NNQjNfSU5GX0NPTVBPVU5EX0RPTkVfRVZFTlQocG9zaXhfcXVlcnlfaW5mb19jb21wb3Vu
ZF9kb25lKTsKIERFRklORV9TTUIzX0lORl9DT01QT1VORF9ET05FX0VWRU5UKGhhcmRsaW5rX2Rv
bmUpOwogREVGSU5FX1NNQjNfSU5GX0NPTVBPVU5EX0RPTkVfRVZFTlQocmVuYW1lX2RvbmUpOwog
REVGSU5FX1NNQjNfSU5GX0NPTVBPVU5EX0RPTkVfRVZFTlQocm1kaXJfZG9uZSk7CkBAIC0zOTUs
NiArMzk3LDcgQEAgREVGSU5FX0VWRU5UKHNtYjNfaW5mX2NvbXBvdW5kX2Vycl9jbGFzcywgc21i
M18jI25hbWUsICAgIFwKIAlUUF9BUkdTKHhpZCwgdGlkLCBzZXNpZCwgcmMpKQogCiBERUZJTkVf
U01CM19JTkZfQ09NUE9VTkRfRVJSX0VWRU5UKHF1ZXJ5X2luZm9fY29tcG91bmRfZXJyKTsKK0RF
RklORV9TTUIzX0lORl9DT01QT1VORF9FUlJfRVZFTlQocG9zaXhfcXVlcnlfaW5mb19jb21wb3Vu
ZF9lcnIpOwogREVGSU5FX1NNQjNfSU5GX0NPTVBPVU5EX0VSUl9FVkVOVChoYXJkbGlua19lcnIp
OwogREVGSU5FX1NNQjNfSU5GX0NPTVBPVU5EX0VSUl9FVkVOVChyZW5hbWVfZXJyKTsKIERFRklO
RV9TTUIzX0lORl9DT01QT1VORF9FUlJfRVZFTlQocm1kaXJfZXJyKTsKLS0gCjIuMjUuMQoK
--000000000000fa291005a7df40b4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-SMB311-Add-support-for-query-info-using-posix-extens.patch"
Content-Disposition: attachment; 
	filename="0001-SMB311-Add-support-for-query-info-using-posix-extens.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kbbz82ew1>
X-Attachment-Id: f_kbbz82ew1

RnJvbSBjNGNiYTQ5MzUzOGNjYzdkYmIxZGNmYzI1YWZjNDUxNmZkM2I4ZjZiIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFRodSwgMTEgSnVuIDIwMjAgMTk6MjU6NDcgLTA1MDAKU3ViamVjdDogW1BBVENIIDEv
NV0gU01CMzExOiBBZGQgc3VwcG9ydCBmb3IgcXVlcnkgaW5mbyB1c2luZyBwb3NpeCBleHRlbnNp
b25zCiAobGV2ZWwgMTAwKQoKQWRkcyBzdXBwb3J0IGZvciBiZXR0ZXIgcXVlcnkgaW5mbyBvbiBk
ZW50cnkgcmV2YWxpZGF0aW9uICh1c2luZwp0aGUgU01CMy4xLjEgUE9TSVggZXh0ZW5zaW9ucyBs
ZXZlbCAxMDApLiAgRm9sbG93b24gcGF0Y2ggd2lsbAphZGQgc3VwcG9ydCBmb3IgdHJhbnNsYXRp
bmcgdGhlIFVJRC9HSUQgZnJvbSB0aGUgU0lEIGFuZCBhbHNvCndpbGwgYWRkIHN1cHBvcnQgZm9y
IHVzaW5nIHRoZSBwb3NpeCBxdWVyeSBpbmZvIG9uIGxvb2t1cC4KClNpZ25lZC1vZmYtYnk6IFN0
ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KUmV2aWV3ZWQtYnk6IFJvbm5pZSBT
YWhsYmVyZyA8bHNhaGxiZXJAcmVkaGF0LmNvbT4KLS0tCiBmcy9jaWZzL2NpZnNwcm90by5oIHwg
ICAyICsKIGZzL2NpZnMvaW5vZGUuYyAgICAgfCAxNzYgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKy0KIGZzL2NpZnMvc21iMmdsb2IuaCAgfCAgIDEgKwogZnMvY2lm
cy9zbWIyaW5vZGUuYyB8IDEwOCArKysrKysrKysrKysrKysrKysrKysrKysrKysKIGZzL2NpZnMv
c21iMnBkdS5oICAgfCAgMjcgKysrKysrLQogZnMvY2lmcy9zbWIycHJvdG8uaCB8ICAgNCArCiA2
IGZpbGVzIGNoYW5nZWQsIDMxNiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQoKZGlmZiAt
LWdpdCBhL2ZzL2NpZnMvY2lmc3Byb3RvLmggYi9mcy9jaWZzL2NpZnNwcm90by5oCmluZGV4IGJk
OTIwNzBjYTMwYy4uYjYwM2RhNzNmNGY1IDEwMDY0NAotLS0gYS9mcy9jaWZzL2NpZnNwcm90by5o
CisrKyBiL2ZzL2NpZnMvY2lmc3Byb3RvLmgKQEAgLTE5OCw2ICsxOTgsOCBAQCBleHRlcm4gc3Ry
dWN0IGlub2RlICpjaWZzX2lnZXQoc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwKIGV4dGVybiBpbnQg
Y2lmc19nZXRfaW5vZGVfaW5mbyhzdHJ1Y3QgaW5vZGUgKippbm9kZSwgY29uc3QgY2hhciAqZnVs
bF9wYXRoLAogCQkJICAgICAgIEZJTEVfQUxMX0lORk8gKmRhdGEsIHN0cnVjdCBzdXBlcl9ibG9j
ayAqc2IsCiAJCQkgICAgICAgaW50IHhpZCwgY29uc3Qgc3RydWN0IGNpZnNfZmlkICpmaWQpOwor
ZXh0ZXJuIGludCBzbWIzMTFfcG9zaXhfZ2V0X2lub2RlX2luZm8oc3RydWN0IGlub2RlICoqcGlu
b2RlLCBjb25zdCBjaGFyICpzZWFyY2hfcGF0aCwKKwkJCXN0cnVjdCBzdXBlcl9ibG9jayAqc2Is
IHVuc2lnbmVkIGludCB4aWQpOwogZXh0ZXJuIGludCBjaWZzX2dldF9pbm9kZV9pbmZvX3VuaXgo
c3RydWN0IGlub2RlICoqcGlub2RlLAogCQkJY29uc3QgdW5zaWduZWQgY2hhciAqc2VhcmNoX3Bh
dGgsCiAJCQlzdHJ1Y3Qgc3VwZXJfYmxvY2sgKnNiLCB1bnNpZ25lZCBpbnQgeGlkKTsKZGlmZiAt
LWdpdCBhL2ZzL2NpZnMvaW5vZGUuYyBiL2ZzL2NpZnMvaW5vZGUuYwppbmRleCA1MDcyYmNhZjRi
ZTEuLjc1ODQyMDY2ZjQ1NiAxMDA2NDQKLS0tIGEvZnMvY2lmcy9pbm9kZS5jCisrKyBiL2ZzL2Np
ZnMvaW5vZGUuYwpAQCAtMzIsNiArMzIsNyBAQAogI2luY2x1ZGUgImNpZnNwZHUuaCIKICNpbmNs
dWRlICJjaWZzZ2xvYi5oIgogI2luY2x1ZGUgImNpZnNwcm90by5oIgorI2luY2x1ZGUgInNtYjJw
cm90by5oIgogI2luY2x1ZGUgImNpZnNfZGVidWcuaCIKICNpbmNsdWRlICJjaWZzX2ZzX3NiLmgi
CiAjaW5jbHVkZSAiY2lmc191bmljb2RlLmgiCkBAIC01OTUsNiArNTk2LDYyIEBAIHN0YXRpYyBp
bnQgY2lmc19zZnVfbW9kZShzdHJ1Y3QgY2lmc19mYXR0ciAqZmF0dHIsIGNvbnN0IHVuc2lnbmVk
IGNoYXIgKnBhdGgsCiAjZW5kaWYKIH0KIAorLyogRmlsbCBhIGNpZnNfZmF0dHIgc3RydWN0IHdp
dGggaW5mbyBmcm9tIFBPU0lYIGluZm8gc3RydWN0ICovCitzdGF0aWMgdm9pZAorc21iMzExX3Bv
c2l4X2luZm9fdG9fZmF0dHIoc3RydWN0IGNpZnNfZmF0dHIgKmZhdHRyLCBzdHJ1Y3Qgc21iMzEx
X3Bvc2l4X3FpbmZvICppbmZvLAorCQkJICAgc3RydWN0IHN1cGVyX2Jsb2NrICpzYiwgYm9vbCBh
ZGp1c3RfdHosIGJvb2wgc3ltbGluaykKK3sKKwlzdHJ1Y3QgY2lmc19zYl9pbmZvICpjaWZzX3Ni
ID0gQ0lGU19TQihzYik7CisJc3RydWN0IGNpZnNfdGNvbiAqdGNvbiA9IGNpZnNfc2JfbWFzdGVy
X3Rjb24oY2lmc19zYik7CisKKwltZW1zZXQoZmF0dHIsIDAsIHNpemVvZigqZmF0dHIpKTsKKwor
CS8qIG5vIGZhdHRyLT5mbGFncyB0byBzZXQgKi8KKwlmYXR0ci0+Y2ZfY2lmc2F0dHJzID0gbGUz
Ml90b19jcHUoaW5mby0+RG9zQXR0cmlidXRlcyk7CisJZmF0dHItPmNmX3VuaXF1ZWlkID0gbGU2
NF90b19jcHUoaW5mby0+SW5vZGUpOworCisJaWYgKGluZm8tPkxhc3RBY2Nlc3NUaW1lKQorCQlm
YXR0ci0+Y2ZfYXRpbWUgPSBjaWZzX05UdGltZVRvVW5peChpbmZvLT5MYXN0QWNjZXNzVGltZSk7
CisJZWxzZQorCQlrdGltZV9nZXRfY29hcnNlX3JlYWxfdHM2NCgmZmF0dHItPmNmX2F0aW1lKTsK
KworCWZhdHRyLT5jZl9jdGltZSA9IGNpZnNfTlR0aW1lVG9Vbml4KGluZm8tPkNoYW5nZVRpbWUp
OworCWZhdHRyLT5jZl9tdGltZSA9IGNpZnNfTlR0aW1lVG9Vbml4KGluZm8tPkxhc3RXcml0ZVRp
bWUpOworCisJaWYgKGFkanVzdF90eikgeworCQlmYXR0ci0+Y2ZfY3RpbWUudHZfc2VjICs9IHRj
b24tPnNlcy0+c2VydmVyLT50aW1lQWRqOworCQlmYXR0ci0+Y2ZfbXRpbWUudHZfc2VjICs9IHRj
b24tPnNlcy0+c2VydmVyLT50aW1lQWRqOworCX0KKworCWZhdHRyLT5jZl9lb2YgPSBsZTY0X3Rv
X2NwdShpbmZvLT5FbmRPZkZpbGUpOworCWZhdHRyLT5jZl9ieXRlcyA9IGxlNjRfdG9fY3B1KGlu
Zm8tPkFsbG9jYXRpb25TaXplKTsKKwlmYXR0ci0+Y2ZfY3JlYXRldGltZSA9IGxlNjRfdG9fY3B1
KGluZm8tPkNyZWF0aW9uVGltZSk7CisKKwlmYXR0ci0+Y2ZfbmxpbmsgPSBsZTMyX3RvX2NwdShp
bmZvLT5IYXJkTGlua3MpOworCWZhdHRyLT5jZl9tb2RlID0gKHVtb2RlX3QpIGxlMzJfdG9fY3B1
KGluZm8tPk1vZGUpOworCS8qIFRoZSBzcnYgZnMgZGV2aWNlIGlkIGlzIG92ZXJyaWRkZW4gb24g
bmV0d29yayBtb3VudCBzbyBzZXR0aW5nIHJkZXYgaXNuJ3QgbmVlZGVkIGhlcmUgKi8KKy8qCWZh
dHRyLT5jZl9yZGV2ID0gbGUzMl90b19jcHUoaW5mby0+RGV2aWNlSWQpOyAqLworCisJaWYgKHN5
bWxpbmspIHsKKwkJZmF0dHItPmNmX21vZGUgfD0gU19JRkxOSzsKKwkJZmF0dHItPmNmX2R0eXBl
ID0gRFRfTE5LOworCX0gZWxzZSBpZiAoZmF0dHItPmNmX2NpZnNhdHRycyAmIEFUVFJfRElSRUNU
T1JZKSB7CisJCWZhdHRyLT5jZl9tb2RlIHw9IFNfSUZESVI7CisJCWZhdHRyLT5jZl9kdHlwZSA9
IERUX0RJUjsKKwl9IGVsc2UgeyAvKiBmaWxlICovCisJCWZhdHRyLT5jZl9tb2RlIHw9IFNfSUZS
RUc7CisJCWZhdHRyLT5jZl9kdHlwZSA9IERUX1JFRzsKKwl9CisJLyogZWxzZSBpZiByZXBhcnNl
IHBvaW50IC4uLiBUT0RPOiBhZGQgc3VwcG9ydCBmb3IgRklGTyBhbmQgYmxrIGRldjsgc3BlY2lh
bCBmaWxlIHR5cGVzICovCisKKwlmYXR0ci0+Y2ZfdWlkID0gY2lmc19zYi0+bW50X3VpZDsgLyog
VE9ETzogbWFwIHVpZCBhbmQgZ2lkIGZyb20gU0lEICovCisJZmF0dHItPmNmX2dpZCA9IGNpZnNf
c2ItPm1udF9naWQ7CisKKwljaWZzX2RiZyhGWUksICJQT1NJWCBxdWVyeSBpbmZvOiBtb2RlIDB4
JXggdW5pcXVlaWQgMHglbGx4IG5saW5rICVkXG4iLAorCQlmYXR0ci0+Y2ZfbW9kZSwgZmF0dHIt
PmNmX3VuaXF1ZWlkLCBmYXR0ci0+Y2ZfbmxpbmspOworfQorCisKIC8qIEZpbGwgYSBjaWZzX2Zh
dHRyIHN0cnVjdCB3aXRoIGluZm8gZnJvbSBGSUxFX0FMTF9JTkZPICovCiBzdGF0aWMgdm9pZAog
Y2lmc19hbGxfaW5mb190b19mYXR0cihzdHJ1Y3QgY2lmc19mYXR0ciAqZmF0dHIsIEZJTEVfQUxM
X0lORk8gKmluZm8sCkBAIC0xMDIzLDYgKzEwODAsMTIxIEBAIGNpZnNfZ2V0X2lub2RlX2luZm8o
c3RydWN0IGlub2RlICoqaW5vZGUsCiAJcmV0dXJuIHJjOwogfQogCitpbnQKK3NtYjMxMV9wb3Np
eF9nZXRfaW5vZGVfaW5mbyhzdHJ1Y3QgaW5vZGUgKippbm9kZSwKKwkJICAgIGNvbnN0IGNoYXIg
KmZ1bGxfcGF0aCwKKwkJICAgIHN0cnVjdCBzdXBlcl9ibG9jayAqc2IsIHVuc2lnbmVkIGludCB4
aWQpCit7CisJc3RydWN0IGNpZnNfdGNvbiAqdGNvbjsKKwlzdHJ1Y3QgVENQX1NlcnZlcl9JbmZv
ICpzZXJ2ZXI7CisJc3RydWN0IHRjb25fbGluayAqdGxpbms7CisJc3RydWN0IGNpZnNfc2JfaW5m
byAqY2lmc19zYiA9IENJRlNfU0Ioc2IpOworCWJvb2wgYWRqdXN0X3R6ID0gZmFsc2U7CisJc3Ry
dWN0IGNpZnNfZmF0dHIgZmF0dHIgPSB7MH07CisJYm9vbCBzeW1saW5rID0gZmFsc2U7CisJc3Ry
dWN0IHNtYjMxMV9wb3NpeF9xaW5mbyAqZGF0YSA9IE5VTEw7CisJaW50IHJjID0gMDsKKwlpbnQg
dG1wcmMgPSAwOworCisJdGxpbmsgPSBjaWZzX3NiX3RsaW5rKGNpZnNfc2IpOworCWlmIChJU19F
UlIodGxpbmspKQorCQlyZXR1cm4gUFRSX0VSUih0bGluayk7CisJdGNvbiA9IHRsaW5rX3Rjb24o
dGxpbmspOworCXNlcnZlciA9IHRjb24tPnNlcy0+c2VydmVyOworCisJLyoKKwkgKiAxLiBGZXRj
aCBmaWxlIG1ldGFkYXRhCisJICovCisKKwlpZiAoaXNfaW5vZGVfY2FjaGVfZ29vZCgqaW5vZGUp
KSB7CisJCWNpZnNfZGJnKEZZSSwgIk5vIG5lZWQgdG8gcmV2YWxpZGF0ZSBjYWNoZWQgaW5vZGUg
c2l6ZXNcbiIpOworCQlnb3RvIG91dDsKKwl9CisJZGF0YSA9IGttYWxsb2Moc2l6ZW9mKHN0cnVj
dCBzbWIzMTFfcG9zaXhfcWluZm8pLCBHRlBfS0VSTkVMKTsKKwlpZiAoIWRhdGEpIHsKKwkJcmMg
PSAtRU5PTUVNOworCQlnb3RvIG91dDsKKwl9CisKKwlyYyA9IHNtYjMxMV9wb3NpeF9xdWVyeV9w
YXRoX2luZm8oeGlkLCB0Y29uLCBjaWZzX3NiLAorCQkJCQkJICBmdWxsX3BhdGgsIGRhdGEsCisJ
CQkJCQkgICZhZGp1c3RfdHosICZzeW1saW5rKTsKKworCS8qCisJICogMi4gQ29udmVydCBpdCB0
byBpbnRlcm5hbCBjaWZzIG1ldGFkYXRhIChmYXR0cikKKwkgKi8KKworCXN3aXRjaCAocmMpIHsK
KwljYXNlIDA6CisJCXNtYjMxMV9wb3NpeF9pbmZvX3RvX2ZhdHRyKCZmYXR0ciwgZGF0YSwgc2Is
IGFkanVzdF90eiwgc3ltbGluayk7CisJCWJyZWFrOworCWNhc2UgLUVSRU1PVEU6CisJCS8qIERG
UyBsaW5rLCBubyBtZXRhZGF0YSBhdmFpbGFibGUgb24gdGhpcyBzZXJ2ZXIgKi8KKwkJY2lmc19j
cmVhdGVfZGZzX2ZhdHRyKCZmYXR0ciwgc2IpOworCQlyYyA9IDA7CisJCWJyZWFrOworCWNhc2Ug
LUVBQ0NFUzoKKwkJLyoKKwkJICogRm9yIFNNQjIgYW5kIGxhdGVyIHRoZSBiYWNrdXAgaW50ZW50
IGZsYWcKKwkJICogaXMgYWxyZWFkeSBzZW50IGlmIG5lZWRlZCBvbiBvcGVuIGFuZCB0aGVyZQor
CQkgKiBpcyBubyBwYXRoIGJhc2VkIEZpbmRGaXJzdCBvcGVyYXRpb24gdG8gdXNlCisJCSAqIHRv
IHJldHJ5IHdpdGggc28gbm90aGluZyB3ZSBjYW4gZG8sIGJhaWwgb3V0CisJCSAqLworCQlnb3Rv
IG91dDsKKwlkZWZhdWx0OgorCQljaWZzX2RiZyhGWUksICIlczogdW5oYW5kbGVkIGVyciByYyAl
ZFxuIiwgX19mdW5jX18sIHJjKTsKKwkJZ290byBvdXQ7CisJfQorCisKKwkvKgorCSAqIDQuIFR3
ZWFrIGZhdHRyIGJhc2VkIG9uIG1vdW50IG9wdGlvbnMKKwkgKi8KKworCS8qIGNoZWNrIGZvciBN
aW5zaGFsbCtGcmVuY2ggc3ltbGlua3MgKi8KKwlpZiAoY2lmc19zYi0+bW50X2NpZnNfZmxhZ3Mg
JiBDSUZTX01PVU5UX01GX1NZTUxJTktTKSB7CisJCXRtcHJjID0gY2hlY2tfbWZfc3ltbGluayh4
aWQsIHRjb24sIGNpZnNfc2IsICZmYXR0ciwKKwkJCQkJIGZ1bGxfcGF0aCk7CisJCWlmICh0bXBy
YykKKwkJCWNpZnNfZGJnKEZZSSwgImNoZWNrX21mX3N5bWxpbms6ICVkXG4iLCB0bXByYyk7CisJ
fQorCisJLyoKKwkgKiA1LiBVcGRhdGUgaW5vZGUgd2l0aCBmaW5hbCBmYXR0ciBkYXRhCisJICov
CisKKwlpZiAoISppbm9kZSkgeworCQkqaW5vZGUgPSBjaWZzX2lnZXQoc2IsICZmYXR0cik7CisJ
CWlmICghKmlub2RlKQorCQkJcmMgPSAtRU5PTUVNOworCX0gZWxzZSB7CisJCS8qIHdlIGFscmVh
ZHkgaGF2ZSBpbm9kZSwgdXBkYXRlIGl0ICovCisKKwkJLyogaWYgdW5pcXVlaWQgaXMgZGlmZmVy
ZW50LCByZXR1cm4gZXJyb3IgKi8KKwkJaWYgKHVubGlrZWx5KGNpZnNfc2ItPm1udF9jaWZzX2Zs
YWdzICYgQ0lGU19NT1VOVF9TRVJWRVJfSU5VTSAmJgorCQkgICAgQ0lGU19JKCppbm9kZSktPnVu
aXF1ZWlkICE9IGZhdHRyLmNmX3VuaXF1ZWlkKSkgeworCQkJQ0lGU19JKCppbm9kZSktPnRpbWUg
PSAwOyAvKiBmb3JjZSByZXZhbCAqLworCQkJcmMgPSAtRVNUQUxFOworCQkJZ290byBvdXQ7CisJ
CX0KKworCQkvKiBpZiBmaWxldHlwZSBpcyBkaWZmZXJlbnQsIHJldHVybiBlcnJvciAqLworCQlp
ZiAodW5saWtlbHkoKCgqaW5vZGUpLT5pX21vZGUgJiBTX0lGTVQpICE9CisJCSAgICAoZmF0dHIu
Y2ZfbW9kZSAmIFNfSUZNVCkpKSB7CisJCQlDSUZTX0koKmlub2RlKS0+dGltZSA9IDA7IC8qIGZv
cmNlIHJldmFsICovCisJCQlyYyA9IC1FU1RBTEU7CisJCQlnb3RvIG91dDsKKwkJfQorCisJCWNp
ZnNfZmF0dHJfdG9faW5vZGUoKmlub2RlLCAmZmF0dHIpOworCX0KK291dDoKKwljaWZzX3B1dF90
bGluayh0bGluayk7CisJa2ZyZWUoZGF0YSk7CisJcmV0dXJuIHJjOworfQorCisKIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgaW5vZGVfb3BlcmF0aW9ucyBjaWZzX2lwY19pbm9kZV9vcHMgPSB7CiAJLmxv
b2t1cCA9IGNpZnNfbG9va3VwLAogfTsKQEAgLTIxMTQsNyArMjI4Niw5IEBAIGludCBjaWZzX3Jl
dmFsaWRhdGVfZGVudHJ5X2F0dHIoc3RydWN0IGRlbnRyeSAqZGVudHJ5KQogCQkgZGVudHJ5LCBj
aWZzX2dldF90aW1lKGRlbnRyeSksIGppZmZpZXMpOwogCiBhZ2FpbjoKLQlpZiAoY2lmc19zYl9t
YXN0ZXJfdGNvbihDSUZTX1NCKHNiKSktPnVuaXhfZXh0KQorCWlmIChjaWZzX3NiX21hc3Rlcl90
Y29uKENJRlNfU0Ioc2IpKS0+cG9zaXhfZXh0ZW5zaW9ucykKKwkJcmMgPSBzbWIzMTFfcG9zaXhf
Z2V0X2lub2RlX2luZm8oJmlub2RlLCBmdWxsX3BhdGgsIHNiLCB4aWQpOworCWVsc2UgaWYgKGNp
ZnNfc2JfbWFzdGVyX3Rjb24oQ0lGU19TQihzYikpLT51bml4X2V4dCkKIAkJcmMgPSBjaWZzX2dl
dF9pbm9kZV9pbmZvX3VuaXgoJmlub2RlLCBmdWxsX3BhdGgsIHNiLCB4aWQpOwogCWVsc2UKIAkJ
cmMgPSBjaWZzX2dldF9pbm9kZV9pbmZvKCZpbm9kZSwgZnVsbF9wYXRoLCBOVUxMLCBzYiwKZGlm
ZiAtLWdpdCBhL2ZzL2NpZnMvc21iMmdsb2IuaCBiL2ZzL2NpZnMvc21iMmdsb2IuaAppbmRleCBk
ZDEwZjBjZTRjZDUuLmNmMjBmMGI1ZDgzNiAxMDA2NDQKLS0tIGEvZnMvY2lmcy9zbWIyZ2xvYi5o
CisrKyBiL2ZzL2NpZnMvc21iMmdsb2IuaApAQCAtNDUsNiArNDUsNyBAQAogI2RlZmluZSBTTUIy
X09QX0hBUkRMSU5LIDgKICNkZWZpbmUgU01CMl9PUF9TRVRfRU9GIDkKICNkZWZpbmUgU01CMl9P
UF9STURJUiAxMAorI2RlZmluZSBTTUIyX09QX1BPU0lYX1FVRVJZX0lORk8gMTEKIAogLyogVXNl
ZCB3aGVuIGNvbnN0cnVjdGluZyBjaGFpbmVkIHJlYWQgcmVxdWVzdHMuICovCiAjZGVmaW5lIENI
QUlORURfUkVRVUVTVCAxCmRpZmYgLS1naXQgYS9mcy9jaWZzL3NtYjJpbm9kZS5jIGIvZnMvY2lm
cy9zbWIyaW5vZGUuYwppbmRleCAwYTExNmZjNDkwYTkuLjUxNTQ5NTYzMTFmMCAxMDA2NDQKLS0t
IGEvZnMvY2lmcy9zbWIyaW5vZGUuYworKysgYi9mcy9jaWZzL3NtYjJpbm9kZS5jCkBAIC0xNjAs
NiArMTYwLDQxIEBAIHNtYjJfY29tcG91bmRfb3AoY29uc3QgdW5zaWduZWQgaW50IHhpZCwgc3Ry
dWN0IGNpZnNfdGNvbiAqdGNvbiwKIAkJCX0KIAkJfQogCisJCWlmIChyYykKKwkJCWdvdG8gZmlu
aXNoZWQ7CisJCW51bV9ycXN0Kys7CisJCXRyYWNlX3NtYjNfcXVlcnlfaW5mb19jb21wb3VuZF9l
bnRlcih4aWQsIHNlcy0+U3VpZCwgdGNvbi0+dGlkLAorCQkJCQkJICAgICBmdWxsX3BhdGgpOwor
CQlicmVhazsKKwljYXNlIFNNQjJfT1BfUE9TSVhfUVVFUllfSU5GTzoKKwkJcnFzdFtudW1fcnFz
dF0ucnFfaW92ID0gJnZhcnMtPnFpX2lvdlswXTsKKwkJcnFzdFtudW1fcnFzdF0ucnFfbnZlYyA9
IDE7CisKKwkJaWYgKGNmaWxlKQorCQkJcmMgPSBTTUIyX3F1ZXJ5X2luZm9faW5pdCh0Y29uLCBz
ZXJ2ZXIsCisJCQkJJnJxc3RbbnVtX3Jxc3RdLAorCQkJCWNmaWxlLT5maWQucGVyc2lzdGVudF9m
aWQsCisJCQkJY2ZpbGUtPmZpZC52b2xhdGlsZV9maWQsCisJCQkJU01CX0ZJTkRfRklMRV9QT1NJ
WF9JTkZPLAorCQkJCVNNQjJfT19JTkZPX0ZJTEUsIDAsCisJCQkJLyogVEJEOiBmaXggZm9sbG93
aW5nIHRvIGFsbG93IGZvciBsb25nZXIgU0lEcyAqLworCQkJCXNpemVvZihzdHJ1Y3Qgc21iMzEx
X3Bvc2l4X3FpbmZvICopICsgKFBBVEhfTUFYICogMikgKworCQkJCShzaXplb2Yoc3RydWN0IGNp
ZnNfc2lkKSAqIDIpLCAwLCBOVUxMKTsKKwkJZWxzZSB7CisJCQlyYyA9IFNNQjJfcXVlcnlfaW5m
b19pbml0KHRjb24sIHNlcnZlciwKKwkJCQkmcnFzdFtudW1fcnFzdF0sCisJCQkJQ09NUE9VTkRf
RklELAorCQkJCUNPTVBPVU5EX0ZJRCwKKwkJCQlTTUJfRklORF9GSUxFX1BPU0lYX0lORk8sCisJ
CQkJU01CMl9PX0lORk9fRklMRSwgMCwKKwkJCQlzaXplb2Yoc3RydWN0IHNtYjMxMV9wb3NpeF9x
aW5mbyAqKSArIChQQVRIX01BWCAqIDIpICsKKwkJCQkoc2l6ZW9mKHN0cnVjdCBjaWZzX3NpZCkg
KiAyKSwgMCwgTlVMTCk7CisJCQlpZiAoIXJjKSB7CisJCQkJc21iMl9zZXRfbmV4dF9jb21tYW5k
KHRjb24sICZycXN0W251bV9ycXN0XSk7CisJCQkJc21iMl9zZXRfcmVsYXRlZCgmcnFzdFtudW1f
cnFzdF0pOworCQkJfQorCQl9CisKIAkJaWYgKHJjKQogCQkJZ290byBmaW5pc2hlZDsKIAkJbnVt
X3Jxc3QrKzsKQEAgLTM3OSw2ICs0MTQsMjYgQEAgc21iMl9jb21wb3VuZF9vcChjb25zdCB1bnNp
Z25lZCBpbnQgeGlkLCBzdHJ1Y3QgY2lmc190Y29uICp0Y29uLAogCQkJdHJhY2Vfc21iM19xdWVy
eV9pbmZvX2NvbXBvdW5kX2RvbmUoeGlkLCBzZXMtPlN1aWQsCiAJCQkJCQl0Y29uLT50aWQpOwog
CQlicmVhazsKKwljYXNlIFNNQjJfT1BfUE9TSVhfUVVFUllfSU5GTzoKKwkJaWYgKHJjID09IDAp
IHsKKwkJCXFpX3JzcCA9IChzdHJ1Y3Qgc21iMl9xdWVyeV9pbmZvX3JzcCAqKQorCQkJCXJzcF9p
b3ZbMV0uaW92X2Jhc2U7CisJCQlyYyA9IHNtYjJfdmFsaWRhdGVfYW5kX2NvcHlfaW92KAorCQkJ
CWxlMTZfdG9fY3B1KHFpX3JzcC0+T3V0cHV0QnVmZmVyT2Zmc2V0KSwKKwkJCQlsZTMyX3RvX2Nw
dShxaV9yc3AtPk91dHB1dEJ1ZmZlckxlbmd0aCksCisJCQkJJnJzcF9pb3ZbMV0sIHNpemVvZihz
dHJ1Y3Qgc21iMzExX3Bvc2l4X3FpbmZvKSAvKiBhZGQgU0lEcyAqLywgcHRyKTsKKwkJfQorCQlp
ZiAocnFzdFsxXS5ycV9pb3YpCisJCQlTTUIyX3F1ZXJ5X2luZm9fZnJlZSgmcnFzdFsxXSk7CisJ
CWlmIChycXN0WzJdLnJxX2lvdikKKwkJCVNNQjJfY2xvc2VfZnJlZSgmcnFzdFsyXSk7CisJCWlm
IChyYykKKwkJCXRyYWNlX3NtYjNfcXVlcnlfaW5mb19jb21wb3VuZF9lcnIoeGlkLCAgc2VzLT5T
dWlkLAorCQkJCQkJdGNvbi0+dGlkLCByYyk7CisJCWVsc2UKKwkJCXRyYWNlX3NtYjNfcXVlcnlf
aW5mb19jb21wb3VuZF9kb25lKHhpZCwgc2VzLT5TdWlkLAorCQkJCQkJdGNvbi0+dGlkKTsKKwkJ
YnJlYWs7CiAJY2FzZSBTTUIyX09QX0RFTEVURToKIAkJaWYgKHJjKQogCQkJdHJhY2Vfc21iM19k
ZWxldGVfZXJyKHhpZCwgIHNlcy0+U3VpZCwgdGNvbi0+dGlkLCByYyk7CkBAIC01MTIsNiArNTY3
LDU5IEBAIHNtYjJfcXVlcnlfcGF0aF9pbmZvKGNvbnN0IHVuc2lnbmVkIGludCB4aWQsIHN0cnVj
dCBjaWZzX3Rjb24gKnRjb24sCiAJcmV0dXJuIHJjOwogfQogCisKK2ludAorc21iMzExX3Bvc2l4
X3F1ZXJ5X3BhdGhfaW5mbyhjb25zdCB1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1Y3QgY2lmc190Y29u
ICp0Y29uLAorCQkgICAgIHN0cnVjdCBjaWZzX3NiX2luZm8gKmNpZnNfc2IsIGNvbnN0IGNoYXIg
KmZ1bGxfcGF0aCwKKwkJICAgICBzdHJ1Y3Qgc21iMzExX3Bvc2l4X3FpbmZvICpkYXRhLCBib29s
ICphZGp1c3RfdHosIGJvb2wgKnN5bWxpbmspCit7CisJaW50IHJjOworCV9fdTMyIGNyZWF0ZV9v
cHRpb25zID0gMDsKKwlzdHJ1Y3QgY2lmc0ZpbGVJbmZvICpjZmlsZTsKKwlzdHJ1Y3Qgc21iMzEx
X3Bvc2l4X3FpbmZvICpzbWIyX2RhdGE7CisKKwkqYWRqdXN0X3R6ID0gZmFsc2U7CisJKnN5bWxp
bmsgPSBmYWxzZTsKKworCS8qIEJCIFRPRE86IE1ha2Ugc3RydWN0IGxhcmdlciB3aGVuIGFkZCBz
dXBwb3J0IGZvciBwYXJzaW5nIG93bmVyIFNJRHMgKi8KKwlzbWIyX2RhdGEgPSBremFsbG9jKHNp
emVvZihzdHJ1Y3Qgc21iMzExX3Bvc2l4X3FpbmZvKSwKKwkJCSAgICBHRlBfS0VSTkVMKTsKKwlp
ZiAoc21iMl9kYXRhID09IE5VTEwpCisJCXJldHVybiAtRU5PTUVNOworCisJLyoKKwkgKiBCQiBU
T0RPOiBBZGQgc3VwcG9ydCBmb3IgdXNpbmcgdGhlIGNhY2hlZCByb290IGhhbmRsZS4KKwkgKiBD
cmVhdGUgU01CMl9xdWVyeV9wb3NpeF9pbmZvIHdvcmtlciBmdW5jdGlvbiB0byBkbyBub24tY29t
cG91bmRlZCBxdWVyeQorCSAqIHdoZW4gd2UgYWxyZWFkeSBoYXZlIGFuIG9wZW4gZmlsZSBoYW5k
bGUgZm9yIHRoaXMuIEZvciBub3cgdGhpcyBpcyBmYXN0IGVub3VnaAorCSAqIChhbHdheXMgdXNp
bmcgdGhlIGNvbXBvdW5kZWQgdmVyc2lvbikuCisJICovCisKKwljaWZzX2dldF9yZWFkYWJsZV9w
YXRoKHRjb24sIGZ1bGxfcGF0aCwgJmNmaWxlKTsKKwlyYyA9IHNtYjJfY29tcG91bmRfb3AoeGlk
LCB0Y29uLCBjaWZzX3NiLCBmdWxsX3BhdGgsCisJCQkgICAgICBGSUxFX1JFQURfQVRUUklCVVRF
UywgRklMRV9PUEVOLCBjcmVhdGVfb3B0aW9ucywKKwkJCSAgICAgIEFDTF9OT19NT0RFLCBzbWIy
X2RhdGEsIFNNQjJfT1BfUE9TSVhfUVVFUllfSU5GTywgY2ZpbGUpOworCWlmIChyYyA9PSAtRU9Q
Tk9UU1VQUCkgeworCQkvKiBCQiBUT0RPOiBXaGVuIHN1cHBvcnQgZm9yIHNwZWNpYWwgZmlsZXMg
YWRkZWQgdG8gU2FtYmEgcmUtdmVyaWZ5IHRoaXMgcGF0aCAqLworCQkqc3ltbGluayA9IHRydWU7
CisJCWNyZWF0ZV9vcHRpb25zIHw9IE9QRU5fUkVQQVJTRV9QT0lOVDsKKworCQkvKiBGYWlsZWQg
b24gYSBzeW1ib2xpYyBsaW5rIC0gcXVlcnkgYSByZXBhcnNlIHBvaW50IGluZm8gKi8KKwkJcmMg
PSBzbWIyX2NvbXBvdW5kX29wKHhpZCwgdGNvbiwgY2lmc19zYiwgZnVsbF9wYXRoLAorCQkJCSAg
ICAgIEZJTEVfUkVBRF9BVFRSSUJVVEVTLCBGSUxFX09QRU4sCisJCQkJICAgICAgY3JlYXRlX29w
dGlvbnMsIEFDTF9OT19NT0RFLAorCQkJCSAgICAgIHNtYjJfZGF0YSwgU01CMl9PUF9QT1NJWF9R
VUVSWV9JTkZPLCBOVUxMKTsKKwl9CisJaWYgKHJjKQorCQlnb3RvIG91dDsKKworCSAvKiBUT0RP
OiB3aWxsIG5lZWQgdG8gYWxsb3cgZm9yIHRoZSAyIFNJRHMgd2hlbiBhZGQgc3VwcG9ydCBmb3Ig
Z2V0dGluZyBvd25lciBVSUQvR0lEICovCisJbWVtY3B5KGRhdGEsIHNtYjJfZGF0YSwgc2l6ZW9m
KHN0cnVjdCBzbWIzMTFfcG9zaXhfcWluZm8pKTsKKworb3V0OgorCWtmcmVlKHNtYjJfZGF0YSk7
CisJcmV0dXJuIHJjOworfQorCiBpbnQKIHNtYjJfbWtkaXIoY29uc3QgdW5zaWduZWQgaW50IHhp
ZCwgc3RydWN0IGlub2RlICpwYXJlbnRfaW5vZGUsIHVtb2RlX3QgbW9kZSwKIAkgICBzdHJ1Y3Qg
Y2lmc190Y29uICp0Y29uLCBjb25zdCBjaGFyICpuYW1lLApkaWZmIC0tZ2l0IGEvZnMvY2lmcy9z
bWIycGR1LmggYi9mcy9jaWZzL3NtYjJwZHUuaAppbmRleCAzYjBlNmFjZjlkN2QuLjIzNjgxNGQ2
MTI0OCAxMDA2NDQKLS0tIGEvZnMvY2lmcy9zbWIycGR1LmgKKysrIGIvZnMvY2lmcy9zbWIycGR1
LmgKQEAgLTE2NTMsNyArMTY1Myw3IEBAIHN0cnVjdCBjcmVhdGVfcG9zaXhfcnNwIHsKIH0gX19w
YWNrZWQ7CiAKIC8qCi0gKiBTTUIyLW9ubHkgUE9TSVggaW5mbyBsZXZlbAorICogU01CMi1vbmx5
IFBPU0lYIGluZm8gbGV2ZWwgZm9yIHF1ZXJ5IGRpcgogICoKICAqIFNlZSBwb3NpeF9pbmZvX3Np
ZF9zaXplKCksIHBvc2l4X2luZm9fZXh0cmFfc2l6ZSgpIGFuZAogICogcG9zaXhfaW5mb19wYXJz
ZSgpIHRvIGhlbHAgd2l0aCB0aGUgaGFuZGxpbmcgb2YgdGhpcyBzdHJ1Y3QuCkBAIC0xNjgzLDYg
KzE2ODMsMzEgQEAgc3RydWN0IHNtYjJfcG9zaXhfaW5mbyB7CiAJICovCiB9IF9fcGFja2VkOwog
CisvKiBMZXZlbCAxMDAgcXVlcnkgaW5mbyAqLworc3RydWN0IHNtYjMxMV9wb3NpeF9xaW5mbyB7
CisJX19sZTY0IENyZWF0aW9uVGltZTsKKwlfX2xlNjQgTGFzdEFjY2Vzc1RpbWU7CisJX19sZTY0
IExhc3RXcml0ZVRpbWU7CisJX19sZTY0IENoYW5nZVRpbWU7CisJX19sZTY0IEVuZE9mRmlsZTsK
KwlfX2xlNjQgQWxsb2NhdGlvblNpemU7CisJX19sZTMyIERvc0F0dHJpYnV0ZXM7CisJX19sZTY0
IElub2RlOworCV9fbGUzMiBEZXZpY2VJZDsKKwlfX2xlMzIgWmVybzsKKwkvKiBiZWdpbm5pbmcg
b2YgUE9TSVggQ3JlYXRlIENvbnRleHQgUmVzcG9uc2UgKi8KKwlfX2xlMzIgSGFyZExpbmtzOwor
CV9fbGUzMiBSZXBhcnNlVGFnOworCV9fbGUzMiBNb2RlOworCXU4ICAgICBTaWRzW107CisJLyoK
KwkgKiB2YXIgc2l6ZWQgb3duZXIgU0lECisJICogdmFyIHNpemVkIGdyb3VwIFNJRAorCSAqIGxl
MzIgZmlsZW5hbWVsZW5ndGgKKwkgKiB1OCAgZmlsZW5hbWVbXQorCSAqLworfSBfX3BhY2tlZDsK
KwogLyoKICAqIFBhcnNlZCB2ZXJzaW9uIG9mIHRoZSBhYm92ZSBzdHJ1Y3QuIEFsbG93cyBkaXJl
Y3QgYWNjZXNzIHRvIHRoZQogICogdmFyaWFibGUgbGVuZ3RoIGZpZWxkcwpkaWZmIC0tZ2l0IGEv
ZnMvY2lmcy9zbWIycHJvdG8uaCBiL2ZzL2NpZnMvc21iMnByb3RvLmgKaW5kZXggNzFiYTc0Nzky
YzllLi5hNWM2ZGE1OTg0N2UgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvc21iMnByb3RvLmgKKysrIGIv
ZnMvY2lmcy9zbWIycHJvdG8uaApAQCAtMjg5LDYgKzI4OSwxMCBAQCBleHRlcm4gaW50IHNtYjJf
cXVlcnlfaW5mb19jb21wb3VuZChjb25zdCB1bnNpZ25lZCBpbnQgeGlkLAogCQkJCSAgICB1MzIg
Y2xhc3MsIHUzMiB0eXBlLCB1MzIgb3V0cHV0X2xlbiwKIAkJCQkgICAgc3RydWN0IGt2ZWMgKnJz
cCwgaW50ICpidWZ0eXBlLAogCQkJCSAgICBzdHJ1Y3QgY2lmc19zYl9pbmZvICpjaWZzX3NiKTsK
Ky8qIHF1ZXJ5IHBhdGggaW5mbyBmcm9tIHRoZSBzZXJ2ZXIgdXNpbmcgU01CMzExIFBPU0lYIGV4
dGVuc2lvbnMqLworZXh0ZXJuIGludCBzbWIzMTFfcG9zaXhfcXVlcnlfcGF0aF9pbmZvKGNvbnN0
IHVuc2lnbmVkIGludCB4aWQsIHN0cnVjdCBjaWZzX3Rjb24gKnRjb24sCisJCQlzdHJ1Y3QgY2lm
c19zYl9pbmZvICpzYiwgY29uc3QgY2hhciAqcGF0aCwgc3RydWN0IHNtYjMxMV9wb3NpeF9xaW5m
byAqcWluZiwKKwkJCWJvb2wgKmFkanVzdF90eCwgYm9vbCAqc3ltbGluayk7CiBpbnQgcG9zaXhf
aW5mb19wYXJzZShjb25zdCB2b2lkICpiZWcsIGNvbnN0IHZvaWQgKmVuZCwKIAkJICAgICBzdHJ1
Y3Qgc21iMl9wb3NpeF9pbmZvX3BhcnNlZCAqb3V0KTsKIGludCBwb3NpeF9pbmZvX3NpZF9zaXpl
KGNvbnN0IHZvaWQgKmJlZywgY29uc3Qgdm9pZCAqZW5kKTsKLS0gCjIuMjUuMQoK
--000000000000fa291005a7df40b4
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-smb311-Add-support-for-SMB311-query-info-non-compoun.patch"
Content-Disposition: attachment; 
	filename="0002-smb311-Add-support-for-SMB311-query-info-non-compoun.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kbbz82dy0>
X-Attachment-Id: f_kbbz82dy0

RnJvbSAxMzY5ZGFlZGE2YzFkOTE0ZmRiYTgzYTRiOTYyN2VmYmQ4NDMxYWJjIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFRodSwgMTEgSnVuIDIwMjAgMjA6MjM6MzggLTA1MDAKU3ViamVjdDogW1BBVENIIDIv
NV0gc21iMzExOiBBZGQgc3VwcG9ydCBmb3IgU01CMzExIHF1ZXJ5IGluZm8KIChub24tY29tcG91
bmRlZCkKCkFkZCB3b3JrZXIgZnVuY3Rpb24gZm9yIG5vbi1jb21wb3VuZGVkIFNNQjMuMS4xIFBP
U0lYIEV4dGVuc2lvbnMgcXVlcnkgaW5mby4KVGhpcyBpcyBuZWVkZWQgZm9yIHJldmFsaWRhdGUg
b2Ygcm9vdCAoY2FjaGVkKSBkaXJlY3RvcnkgZm9yIGV4YW1wbGUuCgpTaWduZWQtb2ZmLWJ5OiBT
dGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+ClJldmlld2VkLWJ5OiBSb25uaWUg
U2FobGJlcmcgPGxzYWhsYmVyQHJlZGhhdC5jb20+Ci0tLQogZnMvY2lmcy9zbWIycGR1LmMgICB8
IDEzICsrKysrKysrKysrKysKIGZzL2NpZnMvc21iMnByb3RvLmggfCAgMiArKwogMiBmaWxlcyBj
aGFuZ2VkLCAxNSBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9zbWIycGR1LmMg
Yi9mcy9jaWZzL3NtYjJwZHUuYwppbmRleCBkZWQ5NmI1MjlhNGQuLmE1NWE5Njk2NzNhYSAxMDA2
NDQKLS0tIGEvZnMvY2lmcy9zbWIycGR1LmMKKysrIGIvZnMvY2lmcy9zbWIycGR1LmMKQEAgLTM0
NTYsNiArMzQ1NiwxOSBAQCBpbnQgU01CMl9xdWVyeV9pbmZvKGNvbnN0IHVuc2lnbmVkIGludCB4
aWQsIHN0cnVjdCBjaWZzX3Rjb24gKnRjb24sCiAJCQkgIE5VTEwpOwogfQogCitpbnQKK1NNQjMx
MV9wb3NpeF9xdWVyeV9pbmZvKGNvbnN0IHVuc2lnbmVkIGludCB4aWQsIHN0cnVjdCBjaWZzX3Rj
b24gKnRjb24sCisJCXU2NCBwZXJzaXN0ZW50X2ZpZCwgdTY0IHZvbGF0aWxlX2ZpZCwgc3RydWN0
IHNtYjMxMV9wb3NpeF9xaW5mbyAqZGF0YSwgdTMyICpwbGVuKQoreworCXNpemVfdCBvdXRwdXRf
bGVuID0gc2l6ZW9mKHN0cnVjdCBzbWIzMTFfcG9zaXhfcWluZm8gKikgKworCQkJKHNpemVvZihz
dHJ1Y3QgY2lmc19zaWQpICogMikgKyAoUEFUSF9NQVggKiAyKTsKKwkqcGxlbiA9IDA7CisKKwly
ZXR1cm4gcXVlcnlfaW5mbyh4aWQsIHRjb24sIHBlcnNpc3RlbnRfZmlkLCB2b2xhdGlsZV9maWQs
CisJCQkgIFNNQl9GSU5EX0ZJTEVfUE9TSVhfSU5GTywgU01CMl9PX0lORk9fRklMRSwgMCwKKwkJ
CSAgb3V0cHV0X2xlbiwgc2l6ZW9mKHN0cnVjdCBzbWIzMTFfcG9zaXhfcWluZm8pLCAodm9pZCAq
KikmZGF0YSwgcGxlbik7Cit9CisKIGludAogU01CMl9xdWVyeV9hY2woY29uc3QgdW5zaWduZWQg
aW50IHhpZCwgc3RydWN0IGNpZnNfdGNvbiAqdGNvbiwKIAkJdTY0IHBlcnNpc3RlbnRfZmlkLCB1
NjQgdm9sYXRpbGVfZmlkLApkaWZmIC0tZ2l0IGEvZnMvY2lmcy9zbWIycHJvdG8uaCBiL2ZzL2Np
ZnMvc21iMnByb3RvLmgKaW5kZXggYTVjNmRhNTk4NDdlLi4yZjhlY2JmNTQyMTQgMTAwNjQ0Ci0t
LSBhL2ZzL2NpZnMvc21iMnByb3RvLmgKKysrIGIvZnMvY2lmcy9zbWIycHJvdG8uaApAQCAtMTgy
LDYgKzE4Miw4IEBAIGV4dGVybiBpbnQgU01CMl9mbHVzaF9pbml0KGNvbnN0IHVuc2lnbmVkIGlu
dCB4aWQsIHN0cnVjdCBzbWJfcnFzdCAqcnFzdCwKIAkJCSAgIHN0cnVjdCBUQ1BfU2VydmVyX0lu
Zm8gKnNlcnZlciwKIAkJCSAgIHU2NCBwZXJzaXN0ZW50X2ZpbGVfaWQsIHU2NCB2b2xhdGlsZV9m
aWxlX2lkKTsKIGV4dGVybiB2b2lkIFNNQjJfZmx1c2hfZnJlZShzdHJ1Y3Qgc21iX3Jxc3QgKnJx
c3QpOworZXh0ZXJuIGludCBTTUIzMTFfcG9zaXhfcXVlcnlfaW5mbyhjb25zdCB1bnNpZ25lZCBp
bnQgeGlkLCBzdHJ1Y3QgY2lmc190Y29uICp0Y29uLAorCQl1NjQgcGVyc2lzdGVudF9maWQsIHU2
NCB2b2xhdGlsZV9maWQsIHN0cnVjdCBzbWIzMTFfcG9zaXhfcWluZm8gKmRhdGEsIHUzMiAqcGxl
bik7CiBleHRlcm4gaW50IFNNQjJfcXVlcnlfaW5mbyhjb25zdCB1bnNpZ25lZCBpbnQgeGlkLCBz
dHJ1Y3QgY2lmc190Y29uICp0Y29uLAogCQkJICAgdTY0IHBlcnNpc3RlbnRfZmlsZV9pZCwgdTY0
IHZvbGF0aWxlX2ZpbGVfaWQsCiAJCQkgICBzdHJ1Y3Qgc21iMl9maWxlX2FsbF9pbmZvICpkYXRh
KTsKLS0gCjIuMjUuMQoK
--000000000000fa291005a7df40b4--
