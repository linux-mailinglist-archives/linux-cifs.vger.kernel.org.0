Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0063F78F908
	for <lists+linux-cifs@lfdr.de>; Fri,  1 Sep 2023 09:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjIAHVO (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 1 Sep 2023 03:21:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231532AbjIAHVO (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 1 Sep 2023 03:21:14 -0400
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8462E7F
        for <linux-cifs@vger.kernel.org>; Fri,  1 Sep 2023 00:21:10 -0700 (PDT)
Received: by mail-lj1-x230.google.com with SMTP id 38308e7fff4ca-2bbbda48904so27338451fa.2
        for <linux-cifs@vger.kernel.org>; Fri, 01 Sep 2023 00:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1693552869; x=1694157669; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FRmhlKCecJgq19eOIbcoESnifBDr8W7TiGZLoV6LRy4=;
        b=Ey0LLRHtQRqzCZTnEx/rB+CS4uVyKgan3OO2ZTNQGw1XjTHGrLAejxVY2yiJtzo8Dr
         eXks3fmzYmfUkwJFrPJQSQi7nf1XRNfJoe4gM/v81e7dI7jWGUBgjZKSm1gnG82DaPfA
         88+LgO7Hpg2ZCdVv1O8IapKPspj9NJtg8LVZXzzAXYmLScUG+mXPaQYn38vHsFYNMTgm
         lfg+JEtYGvI2VMT9UCUpq6nr1W9E+IpPfODEvh2DPp+vtzaICBefawygxvDzZSrDag/K
         VRQ9YbWqimkSJZBgFAiMwuWjUhm6Vf4pszlt2ySwycZ3WXfpQQpHqVTbJ3w+c9ndqadP
         zC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1693552869; x=1694157669;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FRmhlKCecJgq19eOIbcoESnifBDr8W7TiGZLoV6LRy4=;
        b=K6ewm+3+5f6C1GZMAXw8AR6pjXG/radg8OpHoUmA+uIhZL6fPNsJ9PqS6f3u/UdYXh
         jQ/iS9yl7bstN1uEwBqR1u1rN94r1QWhGT8ctaR2tEpfjLzcv6Bbw3tt0gYRBGaLaOhI
         4MqVe3/WHDtUX3oDLZmx8b2K7hC0Noy1yRRqFFfrmXQ5myN1N76J2Dirc0hYVLTXn43c
         UPCEs4RxcwxWxtWdR3yuxYdoJ5D6YgVrWUVpvlk6W2jYwy4U/htNVXDjVWu7OumzyyU3
         mTY7HTjXsL3/Uu7WVfu9qdwBlLH/bI5qlvsi2Jnxz78ohqtA7lnfPGDR3SzZCnKbBYH5
         Tm4g==
X-Gm-Message-State: AOJu0Yx2mRvl2dvqjuOko9JKms2KUCp+yVh2XzzemKH7gzpYKuUJkDNP
        PS2eRofxUSWekKbCT31b+GjK0HOY+/GEQny1+Gr6LdoCjeYG7dVX
X-Google-Smtp-Source: AGHT+IEtv391QtBYrokvHPHFOpcmh2wHeyIQyPd278poK22enQpyRXonV4fhh0pnCL6AgtLA8RzR+kD8gLiIrGMNCGI=
X-Received: by 2002:a2e:9dc9:0:b0:2bc:bc70:263f with SMTP id
 x9-20020a2e9dc9000000b002bcbc70263fmr941850ljj.0.1693552868485; Fri, 01 Sep
 2023 00:21:08 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 1 Sep 2023 02:20:57 -0500
Message-ID: <CAH2r5ms8RrWjHKt16_=L+hYdcUt+7-Tey3Kt7cJh6sxf8g9TNg@mail.gmail.com>
Subject: [PATCH][SMB3] add mount parm to allow controlling maximum number of
 cached directories
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     Shyam Prasad N <nspmangalore@gmail.com>,
        Bharath S M <bharathsm@microsoft.com>
Content-Type: multipart/mixed; boundary="000000000000228c330604470125"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--000000000000228c330604470125
Content-Type: text/plain; charset="UTF-8"

Allow adjusting the maximum number of cached directories per share
(defaults to 16) via mount parm "max_cached_dirs"

See attached



-- 
Thanks,

Steve

--000000000000228c330604470125
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb3-allow-controlling-maximum-number-of-cached-dire.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-allow-controlling-maximum-number-of-cached-dire.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lm09mykr0>
X-Attachment-Id: f_lm09mykr0

RnJvbSAwMWVkZTVkOTJjZTkwZmU0NTQ4MDA1OWU5OGIwODBiMjNjYjBiMTcwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IEZyaSwgMSBTZXAgMjAyMyAwMjoxNToxNCAtMDUwMApTdWJqZWN0OiBbUEFUQ0hdIHNt
YjM6IGFsbG93IGNvbnRyb2xsaW5nIG1heGltdW0gbnVtYmVyIG9mIGNhY2hlZCBkaXJlY3Rvcmll
cwoKQWxsb3cgYWRqdXN0aW5nIHRoZSBtYXhpbXVtIG51bWJlciBvZiBjYWNoZWQgZGlyZWN0b3Jp
ZXMgcGVyIHNoYXJlCihkZWZhdWx0cyB0byAxNikgdmlhIG1vdW50IHBhcm0gIm1heF9jYWNoZWRf
ZGlycyIKClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNv
bT4KLS0tCiBmcy9zbWIvY2xpZW50L2NhY2hlZF9kaXIuYyB8ICA3ICsrKystLS0KIGZzL3NtYi9j
bGllbnQvY2FjaGVkX2Rpci5oIHwgIDIgKy0KIGZzL3NtYi9jbGllbnQvY2lmc2ZzLmMgICAgIHwg
IDIgKysKIGZzL3NtYi9jbGllbnQvY2lmc2dsb2IuaCAgIHwgIDEgKwogZnMvc21iL2NsaWVudC9j
b25uZWN0LmMgICAgfCAgMSArCiBmcy9zbWIvY2xpZW50L2ZzX2NvbnRleHQuYyB8IDExICsrKysr
KysrKystCiBmcy9zbWIvY2xpZW50L2ZzX2NvbnRleHQuaCB8ICA0ICsrKy0KIDcgZmlsZXMgY2hh
bmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9z
bWIvY2xpZW50L2NhY2hlZF9kaXIuYyBiL2ZzL3NtYi9jbGllbnQvY2FjaGVkX2Rpci5jCmluZGV4
IGZlNDgzZjE2M2RiYy4uNjIwNmRkYWRkNzkxIDEwMDY0NAotLS0gYS9mcy9zbWIvY2xpZW50L2Nh
Y2hlZF9kaXIuYworKysgYi9mcy9zbWIvY2xpZW50L2NhY2hlZF9kaXIuYwpAQCAtMTgsNyArMTgs
OCBAQCBzdGF0aWMgdm9pZCBzbWIyX2Nsb3NlX2NhY2hlZF9maWQoc3RydWN0IGtyZWYgKnJlZik7
CiAKIHN0YXRpYyBzdHJ1Y3QgY2FjaGVkX2ZpZCAqZmluZF9vcl9jcmVhdGVfY2FjaGVkX2Rpcihz
dHJ1Y3QgY2FjaGVkX2ZpZHMgKmNmaWRzLAogCQkJCQkJICAgIGNvbnN0IGNoYXIgKnBhdGgsCi0J
CQkJCQkgICAgYm9vbCBsb29rdXBfb25seSkKKwkJCQkJCSAgICBib29sIGxvb2t1cF9vbmx5LAor
CQkJCQkJICAgIF9fdTMyIG1heF9jYWNoZWRfZGlycykKIHsKIAlzdHJ1Y3QgY2FjaGVkX2ZpZCAq
Y2ZpZDsKIApAQCAtNDMsNyArNDQsNyBAQCBzdGF0aWMgc3RydWN0IGNhY2hlZF9maWQgKmZpbmRf
b3JfY3JlYXRlX2NhY2hlZF9kaXIoc3RydWN0IGNhY2hlZF9maWRzICpjZmlkcywKIAkJc3Bpbl91
bmxvY2soJmNmaWRzLT5jZmlkX2xpc3RfbG9jayk7CiAJCXJldHVybiBOVUxMOwogCX0KLQlpZiAo
Y2ZpZHMtPm51bV9lbnRyaWVzID49IE1BWF9DQUNIRURfRklEUykgeworCWlmIChjZmlkcy0+bnVt
X2VudHJpZXMgPj0gbWF4X2NhY2hlZF9kaXJzKSB7CiAJCXNwaW5fdW5sb2NrKCZjZmlkcy0+Y2Zp
ZF9saXN0X2xvY2spOwogCQlyZXR1cm4gTlVMTDsKIAl9CkBAIC0xNjIsNyArMTYzLDcgQEAgaW50
IG9wZW5fY2FjaGVkX2Rpcih1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1Y3QgY2lmc190Y29uICp0Y29u
LAogCWlmICghdXRmMTZfcGF0aCkKIAkJcmV0dXJuIC1FTk9NRU07CiAKLQljZmlkID0gZmluZF9v
cl9jcmVhdGVfY2FjaGVkX2RpcihjZmlkcywgcGF0aCwgbG9va3VwX29ubHkpOworCWNmaWQgPSBm
aW5kX29yX2NyZWF0ZV9jYWNoZWRfZGlyKGNmaWRzLCBwYXRoLCBsb29rdXBfb25seSwgdGNvbi0+
bWF4X2NhY2hlZF9kaXJzKTsKIAlpZiAoY2ZpZCA9PSBOVUxMKSB7CiAJCWtmcmVlKHV0ZjE2X3Bh
dGgpOwogCQlyZXR1cm4gLUVOT0VOVDsKZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvY2FjaGVk
X2Rpci5oIGIvZnMvc21iL2NsaWVudC9jYWNoZWRfZGlyLmgKaW5kZXggZmFjYzliMTU0ZDAwLi5h
ODJmZjJjZWE3ODkgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvY2FjaGVkX2Rpci5oCisrKyBi
L2ZzL3NtYi9jbGllbnQvY2FjaGVkX2Rpci5oCkBAIC00OSw3ICs0OSw3IEBAIHN0cnVjdCBjYWNo
ZWRfZmlkIHsKIAlzdHJ1Y3QgY2FjaGVkX2RpcmVudHMgZGlyZW50czsKIH07CiAKLSNkZWZpbmUg
TUFYX0NBQ0hFRF9GSURTIDE2CisvKiBkZWZhdWx0IE1BWF9DQUNIRURfRklEUyBpcyAxNiAqLwog
c3RydWN0IGNhY2hlZF9maWRzIHsKIAkvKiBNdXN0IGJlIGhlbGQgd2hlbjoKIAkgKiAtIGFjY2Vz
c2luZyB0aGUgY2ZpZHMtPmVudHJpZXMgbGlzdApkaWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC9j
aWZzZnMuYyBiL2ZzL3NtYi9jbGllbnQvY2lmc2ZzLmMKaW5kZXggYTRkOGIwZWExYzhjLi5mZjQw
NGNkYTgzMDkgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvY2lmc2ZzLmMKKysrIGIvZnMvc21i
L2NsaWVudC9jaWZzZnMuYwpAQCAtNjk1LDYgKzY5NSw4IEBAIGNpZnNfc2hvd19vcHRpb25zKHN0
cnVjdCBzZXFfZmlsZSAqcywgc3RydWN0IGRlbnRyeSAqcm9vdCkKIAkJc2VxX3ByaW50ZihzLCAi
LHNuYXBzaG90PSVsbHUiLCB0Y29uLT5zbmFwc2hvdF90aW1lKTsKIAlpZiAodGNvbi0+aGFuZGxl
X3RpbWVvdXQpCiAJCXNlcV9wcmludGYocywgIixoYW5kbGV0aW1lb3V0PSV1IiwgdGNvbi0+aGFu
ZGxlX3RpbWVvdXQpOworCWlmICh0Y29uLT5tYXhfY2FjaGVkX2RpcnMgIT0gTUFYX0NBQ0hFRF9G
SURTKQorCQlzZXFfcHJpbnRmKHMsICIsbWF4X2NhY2hlZF9kaXJzPSV1IiwgdGNvbi0+bWF4X2Nh
Y2hlZF9kaXJzKTsKIAogCS8qCiAJICogRGlzcGxheSBmaWxlIGFuZCBkaXJlY3RvcnkgYXR0cmli
dXRlIHRpbWVvdXQgaW4gc2Vjb25kcy4KZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvY2lmc2ds
b2IuaCBiL2ZzL3NtYi9jbGllbnQvY2lmc2dsb2IuaAppbmRleCA2NTdkZWU0YjJjOGMuLjJiZTZi
ZGJhMzdlMCAxMDA2NDQKLS0tIGEvZnMvc21iL2NsaWVudC9jaWZzZ2xvYi5oCisrKyBiL2ZzL3Nt
Yi9jbGllbnQvY2lmc2dsb2IuaApAQCAtMTE5MSw2ICsxMTkxLDcgQEAgc3RydWN0IGNpZnNfdGNv
biB7CiAJX191MzIgbWF4X2NodW5rczsKIAlfX3UzMiBtYXhfYnl0ZXNfY2h1bms7CiAJX191MzIg
bWF4X2J5dGVzX2NvcHk7CisJX191MzIgbWF4X2NhY2hlZF9kaXJzOwogI2lmZGVmIENPTkZJR19D
SUZTX0ZTQ0FDSEUKIAl1NjQgcmVzb3VyY2VfaWQ7CQkvKiBzZXJ2ZXIgcmVzb3VyY2UgaWQgKi8K
IAlzdHJ1Y3QgZnNjYWNoZV92b2x1bWUgKmZzY2FjaGU7CS8qIGNvb2tpZSBmb3Igc2hhcmUgKi8K
ZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvY29ubmVjdC5jIGIvZnMvc21iL2NsaWVudC9jb25u
ZWN0LmMKaW5kZXggMjM4NTM4ZGRlNGUzLi5mOTlmM2EzY2Q4YTcgMTAwNjQ0Ci0tLSBhL2ZzL3Nt
Yi9jbGllbnQvY29ubmVjdC5jCisrKyBiL2ZzL3NtYi9jbGllbnQvY29ubmVjdC5jCkBAIC0yNjU2
LDYgKzI2NTYsNyBAQCBjaWZzX2dldF90Y29uKHN0cnVjdCBjaWZzX3NlcyAqc2VzLCBzdHJ1Y3Qg
c21iM19mc19jb250ZXh0ICpjdHgpCiAJdGNvbi0+cmV0cnkgPSBjdHgtPnJldHJ5OwogCXRjb24t
Pm5vY2FzZSA9IGN0eC0+bm9jYXNlOwogCXRjb24tPmJyb2tlbl9zcGFyc2Vfc3VwID0gY3R4LT5u
b19zcGFyc2U7CisJdGNvbi0+bWF4X2NhY2hlZF9kaXJzID0gY3R4LT5tYXhfY2FjaGVkX2RpcnM7
CiAJaWYgKHNlcy0+c2VydmVyLT5jYXBhYmlsaXRpZXMgJiBTTUIyX0dMT0JBTF9DQVBfRElSRUNU
T1JZX0xFQVNJTkcpCiAJCXRjb24tPm5vaGFuZGxlY2FjaGUgPSBjdHgtPm5vaGFuZGxlY2FjaGU7
CiAJZWxzZQpkaWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC9mc19jb250ZXh0LmMgYi9mcy9zbWIv
Y2xpZW50L2ZzX2NvbnRleHQuYwppbmRleCA2N2UxNmMyYWM5MGUuLmY2MWQ3NDAxN2JjOCAxMDA2
NDQKLS0tIGEvZnMvc21iL2NsaWVudC9mc19jb250ZXh0LmMKKysrIGIvZnMvc21iL2NsaWVudC9m
c19jb250ZXh0LmMKQEAgLTE1MCw2ICsxNTAsNyBAQCBjb25zdCBzdHJ1Y3QgZnNfcGFyYW1ldGVy
X3NwZWMgc21iM19mc19wYXJhbWV0ZXJzW10gPSB7CiAJZnNwYXJhbV91MzIoImNsb3NldGltZW8i
LCBPcHRfY2xvc2V0aW1lbyksCiAJZnNwYXJhbV91MzIoImVjaG9faW50ZXJ2YWwiLCBPcHRfZWNo
b19pbnRlcnZhbCksCiAJZnNwYXJhbV91MzIoIm1heF9jcmVkaXRzIiwgT3B0X21heF9jcmVkaXRz
KSwKKwlmc3BhcmFtX3UzMigibWF4X2NhY2hlZF9kaXJzIiwgT3B0X21heF9jYWNoZWRfZGlycyks
CiAJZnNwYXJhbV91MzIoImhhbmRsZXRpbWVvdXQiLCBPcHRfaGFuZGxldGltZW91dCksCiAJZnNw
YXJhbV91NjQoInNuYXBzaG90IiwgT3B0X3NuYXBzaG90KSwKIAlmc3BhcmFtX3UzMigibWF4X2No
YW5uZWxzIiwgT3B0X21heF9jaGFubmVscyksCkBAIC0xMTY1LDYgKzExNjYsMTQgQEAgc3RhdGlj
IGludCBzbWIzX2ZzX2NvbnRleHRfcGFyc2VfcGFyYW0oc3RydWN0IGZzX2NvbnRleHQgKmZjLAog
CQlpZiAocmVzdWx0LnVpbnRfMzIgPiAxKQogCQkJY3R4LT5tdWx0aWNoYW5uZWwgPSB0cnVlOwog
CQlicmVhazsKKwljYXNlIE9wdF9tYXhfY2FjaGVkX2RpcnM6CisJCWlmIChyZXN1bHQudWludF8z
MiA8IDEpIHsKKwkJCWNpZnNfZXJyb3JmKGZjLCAiJXM6IEludmFsaWQgbWF4X2NhY2hlZF9kaXJz
LCBuZWVkcyB0byBiZSAxIG9yIG1vcmVcbiIsCisJCQkJICAgIF9fZnVuY19fKTsKKwkJCWdvdG8g
Y2lmc19wYXJzZV9tb3VudF9lcnI7CisJCX0KKwkJY3R4LT5tYXhfY2FjaGVkX2RpcnMgPSByZXN1
bHQudWludF8zMjsKKwkJYnJlYWs7CiAJY2FzZSBPcHRfaGFuZGxldGltZW91dDoKIAkJY3R4LT5o
YW5kbGVfdGltZW91dCA9IHJlc3VsdC51aW50XzMyOwogCQlpZiAoY3R4LT5oYW5kbGVfdGltZW91
dCA+IFNNQjNfTUFYX0hBTkRMRV9USU1FT1VUKSB7CkBAIC0xNTkyLDcgKzE2MDEsNyBAQCBpbnQg
c21iM19pbml0X2ZzX2NvbnRleHQoc3RydWN0IGZzX2NvbnRleHQgKmZjKQogCWN0eC0+YWNyZWdt
YXggPSBDSUZTX0RFRl9BQ1RJTUVPOwogCWN0eC0+YWNkaXJtYXggPSBDSUZTX0RFRl9BQ1RJTUVP
OwogCWN0eC0+Y2xvc2V0aW1lbyA9IFNNQjNfREVGX0RDTE9TRVRJTUVPOwotCisJY3R4LT5tYXhf
Y2FjaGVkX2RpcnMgPSBNQVhfQ0FDSEVEX0ZJRFM7CiAJLyogTW9zdCBjbGllbnRzIHNldCB0aW1l
b3V0IHRvIDAsIGFsbG93cyBzZXJ2ZXIgdG8gdXNlIGl0cyBkZWZhdWx0ICovCiAJY3R4LT5oYW5k
bGVfdGltZW91dCA9IDA7IC8qIFNlZSBNUy1TTUIyIHNwZWMgc2VjdGlvbiAyLjIuMTQuMi4xMiAq
LwogCmRpZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L2ZzX2NvbnRleHQuaCBiL2ZzL3NtYi9jbGll
bnQvZnNfY29udGV4dC5oCmluZGV4IGY0ZWFmODU1ODkwMi4uOWQ4ZDM0YWYwMjExIDEwMDY0NAot
LS0gYS9mcy9zbWIvY2xpZW50L2ZzX2NvbnRleHQuaAorKysgYi9mcy9zbWIvY2xpZW50L2ZzX2Nv
bnRleHQuaApAQCAtMTI4LDYgKzEyOCw3IEBAIGVudW0gY2lmc19wYXJhbSB7CiAJT3B0X2Nsb3Nl
dGltZW8sCiAJT3B0X2VjaG9faW50ZXJ2YWwsCiAJT3B0X21heF9jcmVkaXRzLAorCU9wdF9tYXhf
Y2FjaGVkX2RpcnMsCiAJT3B0X3NuYXBzaG90LAogCU9wdF9tYXhfY2hhbm5lbHMsCiAJT3B0X2hh
bmRsZXRpbWVvdXQsCkBAIC0yNjEsNiArMjYyLDcgQEAgc3RydWN0IHNtYjNfZnNfY29udGV4dCB7
CiAJX191MzIgaGFuZGxlX3RpbWVvdXQ7IC8qIHBlcnNpc3RlbnQgYW5kIGR1cmFibGUgaGFuZGxl
IHRpbWVvdXQgaW4gbXMgKi8KIAl1bnNpZ25lZCBpbnQgbWF4X2NyZWRpdHM7IC8qIHNtYjMgbWF4
X2NyZWRpdHMgMTAgPCBjcmVkaXRzIDwgNjAwMDAgKi8KIAl1bnNpZ25lZCBpbnQgbWF4X2NoYW5u
ZWxzOworCXVuc2lnbmVkIGludCBtYXhfY2FjaGVkX2RpcnM7CiAJX191MTYgY29tcHJlc3Npb247
IC8qIGNvbXByZXNzaW9uIGFsZ29yaXRobSAweEZGRkYgZGVmYXVsdCAwPWRpc2FibGVkICovCiAJ
Ym9vbCByb290ZnM6MTsgLyogaWYgaXQncyBhIFNNQiByb290IGZpbGUgc3lzdGVtICovCiAJYm9v
bCB3aXRuZXNzOjE7IC8qIHVzZSB3aXRuZXNzIHByb3RvY29sICovCkBAIC0yODcsNyArMjg5LDcg
QEAgZXh0ZXJuIHZvaWQgc21iM191cGRhdGVfbW50X2ZsYWdzKHN0cnVjdCBjaWZzX3NiX2luZm8g
KmNpZnNfc2IpOwogICovCiAjZGVmaW5lIFNNQjNfTUFYX0RDTE9TRVRJTUVPICgxIDw8IDMwKQog
I2RlZmluZSBTTUIzX0RFRl9EQ0xPU0VUSU1FTyAoMSAqIEhaKSAvKiBldmVuIDEgc2VjIGVub3Vn
aCB0byBoZWxwIGVnIG9wZW4vd3JpdGUvY2xvc2Uvb3Blbi9yZWFkICovCi0KKyNkZWZpbmUgTUFY
X0NBQ0hFRF9GSURTIDE2CiBleHRlcm4gY2hhciAqY2lmc19zYW5pdGl6ZV9wcmVwYXRoKGNoYXIg
KnByZXBhdGgsIGdmcF90IGdmcCk7CiAKICNlbmRpZgotLSAKMi4zOS4yCgo=
--000000000000228c330604470125--
