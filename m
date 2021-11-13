Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3407844F0C6
	for <lists+linux-cifs@lfdr.de>; Sat, 13 Nov 2021 03:32:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbhKMCfI (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 12 Nov 2021 21:35:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231618AbhKMCfH (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 12 Nov 2021 21:35:07 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCF66C061766
        for <linux-cifs@vger.kernel.org>; Fri, 12 Nov 2021 18:32:15 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id 207so21996668ljf.10
        for <linux-cifs@vger.kernel.org>; Fri, 12 Nov 2021 18:32:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=/KKi9MlyC2ajPTEhQDnm5E6c9PeX2Yx/QSrAgq67sV0=;
        b=OxJd9fpqtVno0h0eJ7fckCGLqc6vVmJSWP+3RZt5RJkWnOR0A/UMEbBK0P5PCL0xfd
         R4FJopp8JeV4EnEXef/cj40WRyOWQvz+4WdzNnuOo3a6yUSOUanSk6a8fNaUE+ZB2THA
         gNPl7cEMPGTcI5fe3cb6wNjhpF9PiQ651/AGkOAT3AXk/GeftkBNfyzUoV3sOmy9/F6T
         yL2K/dH14ckHhJEhkrt/H9Gjk7lDLWzmPoGMVzDHA1B67gsuKOkkJsaVUsZkIcsP3NNC
         qXWZV+O6wu0v1e8sgfAS5Qj561lgUOWIW07IShoyFg3Icl66p/bhYr1QckTQ9qNh11X6
         V8ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=/KKi9MlyC2ajPTEhQDnm5E6c9PeX2Yx/QSrAgq67sV0=;
        b=uR2IzGCPHqW360yQLygRt5mSF+FAZ5jgRMTx5dT5LvTbn5ewaYGQ1++mujH4wELc4+
         wpbkz19EgxeXWtxsjWM0iaQAkNAZX+4uPKP8E970wwQnUGdeg8uYS7gP7SoNvS3Pa5Uk
         tF3nLYvR1hrwGpSTay+p/K7AOaOJ1nxUWsmHXsZXISj8/Ju1+ZhwUKvlV9cDIJ5UK2IH
         MJjT2IKXELVQ+xdTA9KJD7qA+fa6uXJ8Lc5i37Ag8vZ/4dqpy9rcrOhjPSYwZDgZJWR5
         J67O/XfxXDcKNlatQa+pnHDbfu4E74xfw4IZqYOtu5Vdk9fXb5Q+KMtXj9DvaiuEZoIW
         paWg==
X-Gm-Message-State: AOAM5315zaq98v84H6tSaUUoVp5P0xqvWKY0h4TjPVYFTULrqD3fTg/3
        dUbb4Jm9KGJOl+5yYP9mFEVV9HhACG8b16Y7+JLIhaZG
X-Google-Smtp-Source: ABdhPJwJrF7Gh0KruLiHcHkvE8ooPLs9uzmqFST2tzOE8V+NFPH4+gUgYCeDHM4cTALclsYAz0BWVOuLDhvTORrZU+U=
X-Received: by 2002:a2e:7114:: with SMTP id m20mr19542957ljc.229.1636770733678;
 Fri, 12 Nov 2021 18:32:13 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Fri, 12 Nov 2021 20:32:02 -0600
Message-ID: <CAH2r5mtjQboPZfzStyWTbdB_FGVKaK=T19JG3j3xQy_ppe7LNQ@mail.gmail.com>
Subject: updated Linux client multichannel patches
To:     Shyam Prasad N <nspmangalore@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     Paulo Alcantara <pc@cjr.nz>
Content-Type: multipart/mixed; boundary="000000000000298e9905d0a26224"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--000000000000298e9905d0a26224
Content-Type: text/plain; charset="UTF-8"

I updated patch 3 of Shyam's multichannel series to fix merge
conflicts with Paulo's earlier DFS patches.  See attached.

Tentatively have merged the following 4 into for-next pending more testing.


-- 
Thanks,

Steve

--000000000000298e9905d0a26224
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-do-not-negotiate-session-if-session-already-exi.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-do-not-negotiate-session-if-session-already-exi.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kvx70jzk0>
X-Attachment-Id: f_kvx70jzk0

RnJvbSA4ZTA3NzU3YmVjZTZlODFiMGIwOTEwMzU4ZWJjZWNhMzAzMmJjNmM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaHlhbSBQcmFzYWQgTiA8c3ByYXNhZEBtaWNyb3NvZnQuY29t
PgpEYXRlOiBNb24sIDE5IEp1bCAyMDIxIDEwOjAzOjM4ICswMDAwClN1YmplY3Q6IFtQQVRDSCAx
LzRdIGNpZnM6IGRvIG5vdCBuZWdvdGlhdGUgc2Vzc2lvbiBpZiBzZXNzaW9uIGFscmVhZHkgZXhp
c3RzCgpJbiBjaWZzX2dldF9zbWJfc2VzLCBpZiB3ZSBmaW5kIGFuIGV4aXN0aW5nIG1hdGNoaW5n
IHNlc3Npb24sCndlIHNob3VsZCBub3Qgc2VuZCBhIG5lZ290aWF0ZSByZXF1ZXN0IGZvciB0aGUg
c2Vzc2lvbiBpZiBhCnNlc3Npb24gcmVjb25uZWN0IGlzIG5vdCBuZWNlc3NhcnkuCgpTaWduZWQt
b2ZmLWJ5OiBTaHlhbSBQcmFzYWQgTiA8c3ByYXNhZEBtaWNyb3NvZnQuY29tPgpSZXZpZXdlZC1i
eTogUGF1bG8gQWxjYW50YXJhIChTVVNFKSA8cGNAY2pyLm56PgpTaWduZWQtb2ZmLWJ5OiBTdGV2
ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvY2lmcy9jb25uZWN0LmMg
fCAxOCArKysrKysrKysrLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCsp
LCA4IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY29ubmVjdC5jIGIvZnMvY2lm
cy9jb25uZWN0LmMKaW5kZXggMDg0NjA1ZjdjZTk2Li40OThlYzA1Y2ExMGQgMTAwNjQ0Ci0tLSBh
L2ZzL2NpZnMvY29ubmVjdC5jCisrKyBiL2ZzL2NpZnMvY29ubmVjdC5jCkBAIC0xOTQzLDE2ICsx
OTQzLDE4IEBAIGNpZnNfZ2V0X3NtYl9zZXMoc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2VydmVy
LCBzdHJ1Y3Qgc21iM19mc19jb250ZXh0ICpjdHgpCiAJCQkgc2VzLT5zdGF0dXMpOwogCiAJCW11
dGV4X2xvY2soJnNlcy0+c2Vzc2lvbl9tdXRleCk7Ci0JCXJjID0gY2lmc19uZWdvdGlhdGVfcHJv
dG9jb2woeGlkLCBzZXMpOwotCQlpZiAocmMpIHsKLQkJCW11dGV4X3VubG9jaygmc2VzLT5zZXNz
aW9uX211dGV4KTsKLQkJCS8qIHByb2JsZW0gLS0gcHV0IG91ciBzZXMgcmVmZXJlbmNlICovCi0J
CQljaWZzX3B1dF9zbWJfc2VzKHNlcyk7Ci0JCQlmcmVlX3hpZCh4aWQpOwotCQkJcmV0dXJuIEVS
Ul9QVFIocmMpOwotCQl9CiAJCWlmIChzZXMtPm5lZWRfcmVjb25uZWN0KSB7CiAJCQljaWZzX2Ri
ZyhGWUksICJTZXNzaW9uIG5lZWRzIHJlY29ubmVjdFxuIik7CisKKwkJCXJjID0gY2lmc19uZWdv
dGlhdGVfcHJvdG9jb2woeGlkLCBzZXMpOworCQkJaWYgKHJjKSB7CisJCQkJbXV0ZXhfdW5sb2Nr
KCZzZXMtPnNlc3Npb25fbXV0ZXgpOworCQkJCS8qIHByb2JsZW0gLS0gcHV0IG91ciBzZXMgcmVm
ZXJlbmNlICovCisJCQkJY2lmc19wdXRfc21iX3NlcyhzZXMpOworCQkJCWZyZWVfeGlkKHhpZCk7
CisJCQkJcmV0dXJuIEVSUl9QVFIocmMpOworCQkJfQorCiAJCQlyYyA9IGNpZnNfc2V0dXBfc2Vz
c2lvbih4aWQsIHNlcywKIAkJCQkJCWN0eC0+bG9jYWxfbmxzKTsKIAkJCWlmIChyYykgewotLSAK
Mi4zMi4wCgo=
--000000000000298e9905d0a26224
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0004-cifs-do-not-duplicate-fscache-cookie-for-secondary-c.patch"
Content-Disposition: attachment; 
	filename="0004-cifs-do-not-duplicate-fscache-cookie-for-secondary-c.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kvx70k083>
X-Attachment-Id: f_kvx70k083

RnJvbSBhYjU1MGZlNTIxNDJhNjk1MmUzMzk3NmQzMzI2YWVkY2IxMDQ2N2Y2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaHlhbSBQcmFzYWQgTiA8c3ByYXNhZEBtaWNyb3NvZnQuY29t
PgpEYXRlOiBNb24sIDE5IEp1bCAyMDIxIDEzOjU5OjE0ICswMDAwClN1YmplY3Q6IFtQQVRDSCA0
LzRdIGNpZnM6IGRvIG5vdCBkdXBsaWNhdGUgZnNjYWNoZSBjb29raWUgZm9yIHNlY29uZGFyeQog
Y2hhbm5lbHMKCldlIGFsbG9jYXRlIGluZGV4IGNvb2tpZXMgZm9yIGVhY2ggY29ubmVjdGlvbiBm
cm9tIHRoZSBjbGllbnQuCkhvd2V2ZXIsIHdlIGRvbid0IG5lZWQgdGhpcyBpbmRleCBmb3IgZWFj
aCBjaGFubmVsIGluIGNhc2Ugb2YKbXVsdGljaGFubmVsLiBTbyBtYWtpbmcgc3VyZSB0aGF0IHdl
IGF2b2lkIGNyZWF0aW5nIGR1cGxpY2F0ZQpjb29raWVzIGJ5IGluc3RhbnRpYXRpbmcgb25seSBm
b3IgcHJpbWFyeSBjaGFubmVsLgoKU2lnbmVkLW9mZi1ieTogU2h5YW0gUHJhc2FkIE4gPHNwcmFz
YWRAbWljcm9zb2Z0LmNvbT4KU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5jaEBt
aWNyb3NvZnQuY29tPgotLS0KIGZzL2NpZnMvY29ubmVjdC5jIHwgOSArKysrKysrLS0KIDEgZmls
ZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEv
ZnMvY2lmcy9jb25uZWN0LmMgYi9mcy9jaWZzL2Nvbm5lY3QuYwppbmRleCBmODBiNzNmMmQwYTAu
LjgyNTc3YTdhNWJiMSAxMDA2NDQKLS0tIGEvZnMvY2lmcy9jb25uZWN0LmMKKysrIGIvZnMvY2lm
cy9jb25uZWN0LmMKQEAgLTEzOTcsNyArMTM5NywxMCBAQCBjaWZzX3B1dF90Y3Bfc2Vzc2lvbihz
dHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIsIGludCBmcm9tX3JlY29ubmVjdCkKIAlzcGlu
X3VubG9jaygmR2xvYmFsTWlkX0xvY2spOwogCiAJY2lmc19jcnlwdG9fc2VjbWVjaF9yZWxlYXNl
KHNlcnZlcik7Ci0JY2lmc19mc2NhY2hlX3JlbGVhc2VfY2xpZW50X2Nvb2tpZShzZXJ2ZXIpOwor
CisJLyogZnNjYWNoZSBzZXJ2ZXIgY29va2llcyBhcmUgYmFzZWQgb24gcHJpbWFyeSBjaGFubmVs
IG9ubHkgKi8KKwlpZiAoIUNJRlNfU0VSVkVSX0lTX0NIQU4oc2VydmVyKSkKKwkJY2lmc19mc2Nh
Y2hlX3JlbGVhc2VfY2xpZW50X2Nvb2tpZShzZXJ2ZXIpOwogCiAJa2ZyZWUoc2VydmVyLT5zZXNz
aW9uX2tleS5yZXNwb25zZSk7CiAJc2VydmVyLT5zZXNzaW9uX2tleS5yZXNwb25zZSA9IE5VTEw7
CkBAIC0xNTUzLDcgKzE1NTYsOSBAQCBjaWZzX2dldF90Y3Bfc2Vzc2lvbihzdHJ1Y3Qgc21iM19m
c19jb250ZXh0ICpjdHgsCiAJbGlzdF9hZGQoJnRjcF9zZXMtPnRjcF9zZXNfbGlzdCwgJmNpZnNf
dGNwX3Nlc19saXN0KTsKIAlzcGluX3VubG9jaygmY2lmc190Y3Bfc2VzX2xvY2spOwogCi0JY2lm
c19mc2NhY2hlX2dldF9jbGllbnRfY29va2llKHRjcF9zZXMpOworCS8qIGZzY2FjaGUgc2VydmVy
IGNvb2tpZXMgYXJlIGJhc2VkIG9uIHByaW1hcnkgY2hhbm5lbCBvbmx5ICovCisJaWYgKCFDSUZT
X1NFUlZFUl9JU19DSEFOKHRjcF9zZXMpKQorCQljaWZzX2ZzY2FjaGVfZ2V0X2NsaWVudF9jb29r
aWUodGNwX3Nlcyk7CiAKIAkvKiBxdWV1ZSBlY2hvIHJlcXVlc3QgZGVsYXllZCB3b3JrICovCiAJ
cXVldWVfZGVsYXllZF93b3JrKGNpZnNpb2Rfd3EsICZ0Y3Bfc2VzLT5lY2hvLCB0Y3Bfc2VzLT5l
Y2hvX2ludGVydmFsKTsKLS0gCjIuMzIuMAoK
--000000000000298e9905d0a26224
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-cifs-protect-session-channel-fields-with-chan_lock.patch"
Content-Disposition: attachment; 
	filename="0002-cifs-protect-session-channel-fields-with-chan_lock.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kvx70k021>
X-Attachment-Id: f_kvx70k021

RnJvbSA3MjQyNDRjZGIzODI4NTIyMTA5Yzg4ZTU2YTAyNDI1MzdhZWZhYmU5IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaHlhbSBQcmFzYWQgTiA8c3ByYXNhZEBtaWNyb3NvZnQuY29t
PgpEYXRlOiBNb24sIDE5IEp1bCAyMDIxIDEwOjU0OjQ2ICswMDAwClN1YmplY3Q6IFtQQVRDSCAy
LzRdIGNpZnM6IHByb3RlY3Qgc2Vzc2lvbiBjaGFubmVsIGZpZWxkcyB3aXRoIGNoYW5fbG9jawoK
SW50cm9kdWNpbmcgYSBuZXcgc3BpbiBsb2NrIHRvIHByb3RlY3QgYWxsIHRoZSBjaGFubmVsIHJl
bGF0ZWQKZmllbGRzIGluIGEgY2lmc19zZXMgc3RydWN0LiBUaGlzIGxvY2sgc2hvdWxkIGJlIHRh
a2VuCndoZW5ldmVyIGRlYWxpbmcgd2l0aCB0aGUgY2hhbm5lbCBmaWVsZHMsIGFuZCBzaG91bGQg
YmUgaGVsZApvbmx5IGZvciB2ZXJ5IHNob3J0IGludGVydmFscyB3aGljaCB3aWxsIG5vdCBzbGVl
cC4KCkN1cnJlbnRseSwgYWxsIGNoYW5uZWwgcmVsYXRlZCBmaWVsZHMgaW4gY2lmc19zZXMgc3Ry
dWN0dXJlCmFyZSBwcm90ZWN0ZWQgYnkgc2Vzc2lvbl9tdXRleC4gSG93ZXZlciwgdGhpcyBtdXRl
eCBpcyBoZWxkIGZvcgpsb25nIHBlcmlvZHMgKHNvbWV0aW1lcyB3aGlsZSB3YWl0aW5nIGZvciBh
IHJlcGx5IGZyb20gc2VydmVyKS4KVGhpcyBtYWtlcyB0aGUgY29kZXBhdGggcXVpdGUgdHJpY2t5
IHRvIGNoYW5nZS4KClNpZ25lZC1vZmYtYnk6IFNoeWFtIFByYXNhZCBOIDxzcHJhc2FkQG1pY3Jv
c29mdC5jb20+ClJldmlld2VkLWJ5OiBQYXVsbyBBbGNhbnRhcmEgKFNVU0UpIDxwY0BjanIubno+
ClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZyZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0t
CiBmcy9jaWZzL2NpZnNfZGVidWcuYyB8ICAyICsrCiBmcy9jaWZzL2NpZnNnbG9iLmggICB8ICA1
ICsrKysrCiBmcy9jaWZzL2Nvbm5lY3QuYyAgICB8IDI1ICsrKysrKysrKysrKysrKysrKystLS0K
IGZzL2NpZnMvbWlzYy5jICAgICAgIHwgIDEgKwogZnMvY2lmcy9zZXNzLmMgICAgICAgfCA1MCAr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0tLQogZnMvY2lmcy90cmFu
c3BvcnQuYyAgfCAgMyArKysKIDYgZmlsZXMgY2hhbmdlZCwgNzEgaW5zZXJ0aW9ucygrKSwgMTUg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzX2RlYnVnLmMgYi9mcy9jaWZz
L2NpZnNfZGVidWcuYwppbmRleCA5MDVhOTAxZjdmODAuLjI0OGE4Zjk3M2NmOSAxMDA2NDQKLS0t
IGEvZnMvY2lmcy9jaWZzX2RlYnVnLmMKKysrIGIvZnMvY2lmcy9jaWZzX2RlYnVnLmMKQEAgLTQx
NCwxMiArNDE0LDE0IEBAIHN0YXRpYyBpbnQgY2lmc19kZWJ1Z19kYXRhX3Byb2Nfc2hvdyhzdHJ1
Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYpCiAJCQkJICAgZnJvbV9rdWlkKCZpbml0X3VzZXJfbnMs
IHNlcy0+bGludXhfdWlkKSwKIAkJCQkgICBmcm9tX2t1aWQoJmluaXRfdXNlcl9ucywgc2VzLT5j
cmVkX3VpZCkpOwogCisJCQlzcGluX2xvY2soJnNlcy0+Y2hhbl9sb2NrKTsKIAkJCWlmIChzZXMt
PmNoYW5fY291bnQgPiAxKSB7CiAJCQkJc2VxX3ByaW50ZihtLCAiXG5cblx0RXh0cmEgQ2hhbm5l
bHM6ICV6dSAiLAogCQkJCQkgICBzZXMtPmNoYW5fY291bnQtMSk7CiAJCQkJZm9yIChqID0gMTsg
aiA8IHNlcy0+Y2hhbl9jb3VudDsgaisrKQogCQkJCQljaWZzX2R1bXBfY2hhbm5lbChtLCBqLCAm
c2VzLT5jaGFuc1tqXSk7CiAJCQl9CisJCQlzcGluX3VubG9jaygmc2VzLT5jaGFuX2xvY2spOwog
CiAJCQlzZXFfcHV0cyhtLCAiXG5cblx0U2hhcmVzOiAiKTsKIAkJCWogPSAwOwpkaWZmIC0tZ2l0
IGEvZnMvY2lmcy9jaWZzZ2xvYi5oIGIvZnMvY2lmcy9jaWZzZ2xvYi5oCmluZGV4IDY3M2VjYmZl
NmQ5YS4uM2MxOGM1NmExMTliIDEwMDY0NAotLS0gYS9mcy9jaWZzL2NpZnNnbG9iLmgKKysrIGIv
ZnMvY2lmcy9jaWZzZ2xvYi5oCkBAIC05NTIsMTYgKzk1MiwyMSBAQCBzdHJ1Y3QgY2lmc19zZXMg
ewogCSAqIGlmYWNlX2xvY2sgc2hvdWxkIGJlIHRha2VuIHdoZW4gYWNjZXNzaW5nIGFueSBvZiB0
aGVzZSBmaWVsZHMKIAkgKi8KIAlzcGlubG9ja190IGlmYWNlX2xvY2s7CisJLyogPT09PT09PT09
IGJlZ2luOiBwcm90ZWN0ZWQgYnkgaWZhY2VfbG9jayA9PT09PT09PSAqLwogCXN0cnVjdCBjaWZz
X3NlcnZlcl9pZmFjZSAqaWZhY2VfbGlzdDsKIAlzaXplX3QgaWZhY2VfY291bnQ7CiAJdW5zaWdu
ZWQgbG9uZyBpZmFjZV9sYXN0X3VwZGF0ZTsgLyogamlmZmllcyAqLworCS8qID09PT09PT09PSBl
bmQ6IHByb3RlY3RlZCBieSBpZmFjZV9sb2NrID09PT09PT09ICovCiAKKwlzcGlubG9ja190IGNo
YW5fbG9jazsKKwkvKiA9PT09PT09PT0gYmVnaW46IHByb3RlY3RlZCBieSBjaGFuX2xvY2sgPT09
PT09PT0gKi8KICNkZWZpbmUgQ0lGU19NQVhfQ0hBTk5FTFMgMTYKIAlzdHJ1Y3QgY2lmc19jaGFu
IGNoYW5zW0NJRlNfTUFYX0NIQU5ORUxTXTsKIAlzdHJ1Y3QgY2lmc19jaGFuICpiaW5kaW5nX2No
YW47CiAJc2l6ZV90IGNoYW5fY291bnQ7CiAJc2l6ZV90IGNoYW5fbWF4OwogCWF0b21pY190IGNo
YW5fc2VxOyAvKiByb3VuZCByb2JpbiBzdGF0ZSAqLworCS8qID09PT09PT09PSBlbmQ6IHByb3Rl
Y3RlZCBieSBjaGFuX2xvY2sgPT09PT09PT0gKi8KIH07CiAKIC8qCmRpZmYgLS1naXQgYS9mcy9j
aWZzL2Nvbm5lY3QuYyBiL2ZzL2NpZnMvY29ubmVjdC5jCmluZGV4IDQ5OGVjMDVjYTEwZC4uMDlh
NTMyZWQ4ZmU0IDEwMDY0NAotLS0gYS9mcy9jaWZzL2Nvbm5lY3QuYworKysgYi9mcy9jaWZzL2Nv
bm5lY3QuYwpAQCAtMTU3Nyw4ICsxNTc3LDEyIEBAIHN0YXRpYyBpbnQgbWF0Y2hfc2Vzc2lvbihz
dHJ1Y3QgY2lmc19zZXMgKnNlcywgc3RydWN0IHNtYjNfZnNfY29udGV4dCAqY3R4KQogCSAqIElm
IGFuIGV4aXN0aW5nIHNlc3Npb24gaXMgbGltaXRlZCB0byBsZXNzIGNoYW5uZWxzIHRoYW4KIAkg
KiByZXF1ZXN0ZWQsIGl0IHNob3VsZCBub3QgYmUgcmV1c2VkCiAJICovCi0JaWYgKHNlcy0+Y2hh
bl9tYXggPCBjdHgtPm1heF9jaGFubmVscykKKwlzcGluX2xvY2soJnNlcy0+Y2hhbl9sb2NrKTsK
KwlpZiAoc2VzLT5jaGFuX21heCA8IGN0eC0+bWF4X2NoYW5uZWxzKSB7CisJCXNwaW5fdW5sb2Nr
KCZzZXMtPmNoYW5fbG9jayk7CiAJCXJldHVybiAwOworCX0KKwlzcGluX3VubG9jaygmc2VzLT5j
aGFuX2xvY2spOwogCiAJc3dpdGNoIChzZXMtPnNlY3R5cGUpIHsKIAljYXNlIEtlcmJlcm9zOgpA
QCAtMTcxMyw2ICsxNzE3LDcgQEAgY2lmc19maW5kX3NtYl9zZXMoc3RydWN0IFRDUF9TZXJ2ZXJf
SW5mbyAqc2VydmVyLCBzdHJ1Y3Qgc21iM19mc19jb250ZXh0ICpjdHgpCiB2b2lkIGNpZnNfcHV0
X3NtYl9zZXMoc3RydWN0IGNpZnNfc2VzICpzZXMpCiB7CiAJdW5zaWduZWQgaW50IHJjLCB4aWQ7
CisJdW5zaWduZWQgaW50IGNoYW5fY291bnQ7CiAJc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2Vy
dmVyID0gc2VzLT5zZXJ2ZXI7CiAJY2lmc19kYmcoRllJLCAiJXM6IHNlc19jb3VudD0lZFxuIiwg
X19mdW5jX18sIHNlcy0+c2VzX2NvdW50KTsKIApAQCAtMTc1NCwxMiArMTc1OSwyNCBAQCB2b2lk
IGNpZnNfcHV0X3NtYl9zZXMoc3RydWN0IGNpZnNfc2VzICpzZXMpCiAJbGlzdF9kZWxfaW5pdCgm
c2VzLT5zbWJfc2VzX2xpc3QpOwogCXNwaW5fdW5sb2NrKCZjaWZzX3RjcF9zZXNfbG9jayk7CiAK
KwlzcGluX2xvY2soJnNlcy0+Y2hhbl9sb2NrKTsKKwljaGFuX2NvdW50ID0gc2VzLT5jaGFuX2Nv
dW50OworCXNwaW5fdW5sb2NrKCZzZXMtPmNoYW5fbG9jayk7CisKIAkvKiBjbG9zZSBhbnkgZXh0
cmEgY2hhbm5lbHMgKi8KLQlpZiAoc2VzLT5jaGFuX2NvdW50ID4gMSkgeworCWlmIChjaGFuX2Nv
dW50ID4gMSkgewogCQlpbnQgaTsKIAotCQlmb3IgKGkgPSAxOyBpIDwgc2VzLT5jaGFuX2NvdW50
OyBpKyspCisJCWZvciAoaSA9IDE7IGkgPCBjaGFuX2NvdW50OyBpKyspIHsKKwkJCS8qCisJCQkg
KiBub3RlOiBmb3Igbm93LCB3ZSdyZSBva2F5IGFjY2Vzc2luZyBzZXMtPmNoYW5zCisJCQkgKiB3
aXRob3V0IGNoYW5fbG9jay4gQnV0IHdoZW4gY2hhbnMgY2FuIGdvIGF3YXksIHdlJ2xsCisJCQkg
KiBuZWVkIHRvIGludHJvZHVjZSByZWYgY291bnRpbmcgdG8gbWFrZSBzdXJlIHRoYXQgY2hhbgor
CQkJICogaXMgbm90IGZyZWVkIGZyb20gdW5kZXIgdXMuCisJCQkgKi8KIAkJCWNpZnNfcHV0X3Rj
cF9zZXNzaW9uKHNlcy0+Y2hhbnNbaV0uc2VydmVyLCAwKTsKKwkJCXNlcy0+Y2hhbnNbaV0uc2Vy
dmVyID0gTlVMTDsKKwkJfQogCX0KIAogCXNlc0luZm9GcmVlKHNlcyk7CkBAIC0yMDE4LDkgKzIw
MzUsMTEgQEAgY2lmc19nZXRfc21iX3NlcyhzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIs
IHN0cnVjdCBzbWIzX2ZzX2NvbnRleHQgKmN0eCkKIAltdXRleF9sb2NrKCZzZXMtPnNlc3Npb25f
bXV0ZXgpOwogCiAJLyogYWRkIHNlcnZlciBhcyBmaXJzdCBjaGFubmVsICovCisJc3Bpbl9sb2Nr
KCZzZXMtPmNoYW5fbG9jayk7CiAJc2VzLT5jaGFuc1swXS5zZXJ2ZXIgPSBzZXJ2ZXI7CiAJc2Vz
LT5jaGFuX2NvdW50ID0gMTsKIAlzZXMtPmNoYW5fbWF4ID0gY3R4LT5tdWx0aWNoYW5uZWwgPyBj
dHgtPm1heF9jaGFubmVsczoxOworCXNwaW5fdW5sb2NrKCZzZXMtPmNoYW5fbG9jayk7CiAKIAly
YyA9IGNpZnNfbmVnb3RpYXRlX3Byb3RvY29sKHhpZCwgc2VzKTsKIAlpZiAoIXJjKQpkaWZmIC0t
Z2l0IGEvZnMvY2lmcy9taXNjLmMgYi9mcy9jaWZzL21pc2MuYwppbmRleCBhNjA4OWVhNTNhZDcu
LjUxNDhkNDhkNmEzNSAxMDA2NDQKLS0tIGEvZnMvY2lmcy9taXNjLmMKKysrIGIvZnMvY2lmcy9t
aXNjLmMKQEAgLTc1LDYgKzc1LDcgQEAgc2VzSW5mb0FsbG9jKHZvaWQpCiAJCUlOSVRfTElTVF9I
RUFEKCZyZXRfYnVmLT50Y29uX2xpc3QpOwogCQltdXRleF9pbml0KCZyZXRfYnVmLT5zZXNzaW9u
X211dGV4KTsKIAkJc3Bpbl9sb2NrX2luaXQoJnJldF9idWYtPmlmYWNlX2xvY2spOworCQlzcGlu
X2xvY2tfaW5pdCgmcmV0X2J1Zi0+Y2hhbl9sb2NrKTsKIAl9CiAJcmV0dXJuIHJldF9idWY7CiB9
CmRpZmYgLS1naXQgYS9mcy9jaWZzL3Nlc3MuYyBiL2ZzL2NpZnMvc2Vzcy5jCmluZGV4IDkzYTE2
MTlkNjBlNi4uMjc2NjBiZmZiOTE4IDEwMDY0NAotLS0gYS9mcy9jaWZzL3Nlc3MuYworKysgYi9m
cy9jaWZzL3Nlc3MuYwpAQCAtNTQsNDEgKzU0LDUzIEBAIGJvb2wgaXNfc2VzX3VzaW5nX2lmYWNl
KHN0cnVjdCBjaWZzX3NlcyAqc2VzLCBzdHJ1Y3QgY2lmc19zZXJ2ZXJfaWZhY2UgKmlmYWNlKQog
ewogCWludCBpOwogCisJc3Bpbl9sb2NrKCZzZXMtPmNoYW5fbG9jayk7CiAJZm9yIChpID0gMDsg
aSA8IHNlcy0+Y2hhbl9jb3VudDsgaSsrKSB7Ci0JCWlmIChpc19zZXJ2ZXJfdXNpbmdfaWZhY2Uo
c2VzLT5jaGFuc1tpXS5zZXJ2ZXIsIGlmYWNlKSkKKwkJaWYgKGlzX3NlcnZlcl91c2luZ19pZmFj
ZShzZXMtPmNoYW5zW2ldLnNlcnZlciwgaWZhY2UpKSB7CisJCQlzcGluX3VubG9jaygmc2VzLT5j
aGFuX2xvY2spOwogCQkJcmV0dXJuIHRydWU7CisJCX0KIAl9CisJc3Bpbl91bmxvY2soJnNlcy0+
Y2hhbl9sb2NrKTsKIAlyZXR1cm4gZmFsc2U7CiB9CiAKIC8qIHJldHVybnMgbnVtYmVyIG9mIGNo
YW5uZWxzIGFkZGVkICovCiBpbnQgY2lmc190cnlfYWRkaW5nX2NoYW5uZWxzKHN0cnVjdCBjaWZz
X3NiX2luZm8gKmNpZnNfc2IsIHN0cnVjdCBjaWZzX3NlcyAqc2VzKQogewotCWludCBvbGRfY2hh
bl9jb3VudCA9IHNlcy0+Y2hhbl9jb3VudDsKLQlpbnQgbGVmdCA9IHNlcy0+Y2hhbl9tYXggLSBz
ZXMtPmNoYW5fY291bnQ7CisJaW50IG9sZF9jaGFuX2NvdW50LCBuZXdfY2hhbl9jb3VudDsKKwlp
bnQgbGVmdDsKIAlpbnQgaSA9IDA7CiAJaW50IHJjID0gMDsKIAlpbnQgdHJpZXMgPSAwOwogCXN0
cnVjdCBjaWZzX3NlcnZlcl9pZmFjZSAqaWZhY2VzID0gTlVMTDsKIAlzaXplX3QgaWZhY2VfY291
bnQ7CiAKKwlpZiAoc2VzLT5zZXJ2ZXItPmRpYWxlY3QgPCBTTUIzMF9QUk9UX0lEKSB7CisJCWNp
ZnNfZGJnKFZGUywgIm11bHRpY2hhbm5lbCBpcyBub3Qgc3VwcG9ydGVkIG9uIHRoaXMgcHJvdG9j
b2wgdmVyc2lvbiwgdXNlIDMuMCBvciBhYm92ZVxuIik7CisJCXJldHVybiAwOworCX0KKworCXNw
aW5fbG9jaygmc2VzLT5jaGFuX2xvY2spOworCisJbmV3X2NoYW5fY291bnQgPSBvbGRfY2hhbl9j
b3VudCA9IHNlcy0+Y2hhbl9jb3VudDsKKwlsZWZ0ID0gc2VzLT5jaGFuX21heCAtIHNlcy0+Y2hh
bl9jb3VudDsKKwogCWlmIChsZWZ0IDw9IDApIHsKIAkJY2lmc19kYmcoRllJLAogCQkJICJzZXMg
YWxyZWFkeSBhdCBtYXhfY2hhbm5lbHMgKCV6dSksIG5vdGhpbmcgdG8gb3BlblxuIiwKIAkJCSBz
ZXMtPmNoYW5fbWF4KTsKLQkJcmV0dXJuIDA7Ci0JfQotCi0JaWYgKHNlcy0+c2VydmVyLT5kaWFs
ZWN0IDwgU01CMzBfUFJPVF9JRCkgewotCQljaWZzX2RiZyhWRlMsICJtdWx0aWNoYW5uZWwgaXMg
bm90IHN1cHBvcnRlZCBvbiB0aGlzIHByb3RvY29sIHZlcnNpb24sIHVzZSAzLjAgb3IgYWJvdmVc
biIpOworCQlzcGluX3VubG9jaygmc2VzLT5jaGFuX2xvY2spOwogCQlyZXR1cm4gMDsKIAl9CiAK
IAlpZiAoIShzZXMtPnNlcnZlci0+Y2FwYWJpbGl0aWVzICYgU01CMl9HTE9CQUxfQ0FQX01VTFRJ
X0NIQU5ORUwpKSB7CiAJCWNpZnNfZGJnKFZGUywgInNlcnZlciAlcyBkb2VzIG5vdCBzdXBwb3J0
IG11bHRpY2hhbm5lbFxuIiwgc2VzLT5zZXJ2ZXItPmhvc3RuYW1lKTsKIAkJc2VzLT5jaGFuX21h
eCA9IDE7CisJCXNwaW5fdW5sb2NrKCZzZXMtPmNoYW5fbG9jayk7CiAJCXJldHVybiAwOwogCX0K
KwlzcGluX3VubG9jaygmc2VzLT5jaGFuX2xvY2spOwogCiAJLyoKIAkgKiBNYWtlIGEgY29weSBv
ZiB0aGUgaWZhY2UgbGlzdCBhdCB0aGUgdGltZSBhbmQgdXNlIHRoYXQKQEAgLTE0MiwxMCArMTU0
LDExIEBAIGludCBjaWZzX3RyeV9hZGRpbmdfY2hhbm5lbHMoc3RydWN0IGNpZnNfc2JfaW5mbyAq
Y2lmc19zYiwgc3RydWN0IGNpZnNfc2VzICpzZXMpCiAJCWNpZnNfZGJnKEZZSSwgInN1Y2Nlc3Nm
dWxseSBvcGVuZWQgbmV3IGNoYW5uZWwgb24gaWZhY2UjJWRcbiIsCiAJCQkgaSk7CiAJCWxlZnQt
LTsKKwkJbmV3X2NoYW5fY291bnQrKzsKIAl9CiAKIAlrZnJlZShpZmFjZXMpOwotCXJldHVybiBz
ZXMtPmNoYW5fY291bnQgLSBvbGRfY2hhbl9jb3VudDsKKwlyZXR1cm4gbmV3X2NoYW5fY291bnQg
LSBvbGRfY2hhbl9jb3VudDsKIH0KIAogLyoKQEAgLTE1NywxMCArMTcwLDE0IEBAIGNpZnNfc2Vz
X2ZpbmRfY2hhbihzdHJ1Y3QgY2lmc19zZXMgKnNlcywgc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAq
c2VydmVyKQogewogCWludCBpOwogCisJc3Bpbl9sb2NrKCZzZXMtPmNoYW5fbG9jayk7CiAJZm9y
IChpID0gMDsgaSA8IHNlcy0+Y2hhbl9jb3VudDsgaSsrKSB7Ci0JCWlmIChzZXMtPmNoYW5zW2ld
LnNlcnZlciA9PSBzZXJ2ZXIpCisJCWlmIChzZXMtPmNoYW5zW2ldLnNlcnZlciA9PSBzZXJ2ZXIp
IHsKKwkJCXNwaW5fdW5sb2NrKCZzZXMtPmNoYW5fbG9jayk7CiAJCQlyZXR1cm4gJnNlcy0+Y2hh
bnNbaV07CisJCX0KIAl9CisJc3Bpbl91bmxvY2soJnNlcy0+Y2hhbl9sb2NrKTsKIAlyZXR1cm4g
TlVMTDsKIH0KIApAQCAtMTY4LDYgKzE4NSw3IEBAIHN0YXRpYyBpbnQKIGNpZnNfc2VzX2FkZF9j
aGFubmVsKHN0cnVjdCBjaWZzX3NiX2luZm8gKmNpZnNfc2IsIHN0cnVjdCBjaWZzX3NlcyAqc2Vz
LAogCQkgICAgIHN0cnVjdCBjaWZzX3NlcnZlcl9pZmFjZSAqaWZhY2UpCiB7CisJc3RydWN0IFRD
UF9TZXJ2ZXJfSW5mbyAqY2hhbl9zZXJ2ZXI7CiAJc3RydWN0IGNpZnNfY2hhbiAqY2hhbjsKIAlz
dHJ1Y3Qgc21iM19mc19jb250ZXh0IGN0eCA9IHtOVUxMfTsKIAlzdGF0aWMgY29uc3QgY2hhciB1
bmNfZm10W10gPSAiXFwlc1xcZm9vIjsKQEAgLTI0MCwxNSArMjU4LDIwIEBAIGNpZnNfc2VzX2Fk
ZF9jaGFubmVsKHN0cnVjdCBjaWZzX3NiX2luZm8gKmNpZnNfc2IsIHN0cnVjdCBjaWZzX3NlcyAq
c2VzLAogCSAgICAgICBTTUIyX0NMSUVOVF9HVUlEX1NJWkUpOwogCWN0eC51c2VfY2xpZW50X2d1
aWQgPSB0cnVlOwogCi0JbXV0ZXhfbG9jaygmc2VzLT5zZXNzaW9uX211dGV4KTsKKwljaGFuX3Nl
cnZlciA9IGNpZnNfZ2V0X3RjcF9zZXNzaW9uKCZjdHgpOwogCisJbXV0ZXhfbG9jaygmc2VzLT5z
ZXNzaW9uX211dGV4KTsKKwlzcGluX2xvY2soJnNlcy0+Y2hhbl9sb2NrKTsKIAljaGFuID0gc2Vz
LT5iaW5kaW5nX2NoYW4gPSAmc2VzLT5jaGFuc1tzZXMtPmNoYW5fY291bnRdOwotCWNoYW4tPnNl
cnZlciA9IGNpZnNfZ2V0X3RjcF9zZXNzaW9uKCZjdHgpOworCWNoYW4tPnNlcnZlciA9IGNoYW5f
c2VydmVyOwogCWlmIChJU19FUlIoY2hhbi0+c2VydmVyKSkgewogCQlyYyA9IFBUUl9FUlIoY2hh
bi0+c2VydmVyKTsKIAkJY2hhbi0+c2VydmVyID0gTlVMTDsKKwkJc3Bpbl91bmxvY2soJnNlcy0+
Y2hhbl9sb2NrKTsKIAkJZ290byBvdXQ7CiAJfQorCXNwaW5fdW5sb2NrKCZzZXMtPmNoYW5fbG9j
ayk7CisKIAlzcGluX2xvY2soJmNpZnNfdGNwX3Nlc19sb2NrKTsKIAljaGFuLT5zZXJ2ZXItPmlz
X2NoYW5uZWwgPSB0cnVlOwogCXNwaW5fdW5sb2NrKCZjaWZzX3RjcF9zZXNfbG9jayk7CkBAIC0y
ODMsOCArMzA2LDExIEBAIGNpZnNfc2VzX2FkZF9jaGFubmVsKHN0cnVjdCBjaWZzX3NiX2luZm8g
KmNpZnNfc2IsIHN0cnVjdCBjaWZzX3NlcyAqc2VzLAogCSAqIHNlcyB0byB0aGUgbmV3IHNlcnZl
ci4KIAkgKi8KIAorCXNwaW5fbG9jaygmc2VzLT5jaGFuX2xvY2spOwogCXNlcy0+Y2hhbl9jb3Vu
dCsrOwogCWF0b21pY19zZXQoJnNlcy0+Y2hhbl9zZXEsIDApOworCXNwaW5fdW5sb2NrKCZzZXMt
PmNoYW5fbG9jayk7CisKIG91dDoKIAlzZXMtPmJpbmRpbmcgPSBmYWxzZTsKIAlzZXMtPmJpbmRp
bmdfY2hhbiA9IE5VTEw7CmRpZmYgLS1naXQgYS9mcy9jaWZzL3RyYW5zcG9ydC5jIGIvZnMvY2lm
cy90cmFuc3BvcnQuYwppbmRleCBiNzM3OTMyOWI3NDEuLjYxZWEzZDNmOTViNCAxMDA2NDQKLS0t
IGEvZnMvY2lmcy90cmFuc3BvcnQuYworKysgYi9mcy9jaWZzL3RyYW5zcG9ydC5jCkBAIC0xMDQ0
LDE0ICsxMDQ0LDE3IEBAIHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKmNpZnNfcGlja19jaGFubmVs
KHN0cnVjdCBjaWZzX3NlcyAqc2VzKQogCWlmICghc2VzKQogCQlyZXR1cm4gTlVMTDsKIAorCXNw
aW5fbG9jaygmc2VzLT5jaGFuX2xvY2spOwogCWlmICghc2VzLT5iaW5kaW5nKSB7CiAJCS8qIHJv
dW5kIHJvYmluICovCiAJCWlmIChzZXMtPmNoYW5fY291bnQgPiAxKSB7CiAJCQlpbmRleCA9ICh1
aW50KWF0b21pY19pbmNfcmV0dXJuKCZzZXMtPmNoYW5fc2VxKTsKIAkJCWluZGV4ICU9IHNlcy0+
Y2hhbl9jb3VudDsKIAkJfQorCQlzcGluX3VubG9jaygmc2VzLT5jaGFuX2xvY2spOwogCQlyZXR1
cm4gc2VzLT5jaGFuc1tpbmRleF0uc2VydmVyOwogCX0gZWxzZSB7CisJCXNwaW5fdW5sb2NrKCZz
ZXMtPmNoYW5fbG9jayk7CiAJCXJldHVybiBjaWZzX3Nlc19zZXJ2ZXIoc2VzKTsKIAl9CiB9Ci0t
IAoyLjMyLjAKCg==
--000000000000298e9905d0a26224
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0003-cifs-connect-individual-channel-servers-to-primary-c.patch"
Content-Disposition: attachment; 
	filename="0003-cifs-connect-individual-channel-servers-to-primary-c.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kvx70k052>
X-Attachment-Id: f_kvx70k052

RnJvbSAwZjJiMzA1YWY5NDQ5NzNkNmZhNGFjZGI5NzE1MWVmZTViNjRhYTU1IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaHlhbSBQcmFzYWQgTiA8c3ByYXNhZEBtaWNyb3NvZnQuY29t
PgpEYXRlOiBNb24sIDE5IEp1bCAyMDIxIDExOjI2OjI0ICswMDAwClN1YmplY3Q6IFtQQVRDSCAz
LzRdIGNpZnM6IGNvbm5lY3QgaW5kaXZpZHVhbCBjaGFubmVsIHNlcnZlcnMgdG8gcHJpbWFyeQog
Y2hhbm5lbCBzZXJ2ZXIKClRvZGF5LCB3ZSBkb24ndCBoYXZlIGFueSB3YXkgdG8gZ2V0IHRoZSBz
bWIgc2Vzc2lvbiBmb3IgYW55Cm9mIHRoZSBzZWNvbmRhcnkgY2hhbm5lbHMuIEludHJvZHVjaW5n
IGEgcG9pbnRlciB0byB0aGUgcHJpbWFyeQpzZXJ2ZXIgZnJvbSBzZXJ2ZXIgc3RydWN0IG9mIGFu
eSBzZWNvbmRhcnkgY2hhbm5lbC4gVGhlIHZhbHVlIHdpbGwKYmUgTlVMTCBmb3IgdGhlIHNlcnZl
ciBvZiB0aGUgcHJpbWFyeSBjaGFubmVsLiBUaGlzIHdpbGwgZW5hYmxlIHVzCnRvIGdldCB0aGUg
c21iIHNlc3Npb24gZm9yIGFueSBjaGFubmVsLgoKVGhpcyB3aWxsIGJlIG5lZWRlZCBmb3Igc29t
ZSBvZiB0aGUgY2hhbmdlcyB0aGF0IEknbSBwbGFubmluZwp0byBtYWtlIHNvb24uCgpTaWduZWQt
b2ZmLWJ5OiBTaHlhbSBQcmFzYWQgTiA8c3ByYXNhZEBtaWNyb3NvZnQuY29tPgpTaWduZWQtb2Zm
LWJ5OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvY2lmcy9j
aWZzX2RlYnVnLmMgfCAgMyArKy0KIGZzL2NpZnMvY2lmc2dsb2IuaCAgIHwgMTAgKysrKysrKysr
LQogZnMvY2lmcy9jaWZzcHJvdG8uaCAgfCAgNSArKystLQogZnMvY2lmcy9jb25uZWN0LmMgICAg
fCAyNCArKysrKysrKysrKysrKysrKysrKy0tLS0KIGZzL2NpZnMvc2Vzcy5jICAgICAgIHwgIDYg
Ky0tLS0tCiBmcy9jaWZzL3NtYjJwZHUuYyAgICB8ICAyICstCiA2IGZpbGVzIGNoYW5nZWQsIDM2
IGluc2VydGlvbnMoKyksIDE0IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY2lm
c19kZWJ1Zy5jIGIvZnMvY2lmcy9jaWZzX2RlYnVnLmMKaW5kZXggMjQ4YThmOTczY2Y5Li5kMjgy
Y2FmOWYwMzcgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvY2lmc19kZWJ1Zy5jCisrKyBiL2ZzL2NpZnMv
Y2lmc19kZWJ1Zy5jCkBAIC0yNzEsNyArMjcxLDggQEAgc3RhdGljIGludCBjaWZzX2RlYnVnX2Rh
dGFfcHJvY19zaG93KHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdikKIAljID0gMDsKIAlzcGlu
X2xvY2soJmNpZnNfdGNwX3Nlc19sb2NrKTsKIAlsaXN0X2Zvcl9lYWNoX2VudHJ5KHNlcnZlciwg
JmNpZnNfdGNwX3Nlc19saXN0LCB0Y3Bfc2VzX2xpc3QpIHsKLQkJaWYgKHNlcnZlci0+aXNfY2hh
bm5lbCkKKwkJLyogY2hhbm5lbCBpbmZvIHdpbGwgYmUgcHJpbnRlZCBhcyBhIHBhcnQgb2Ygc2Vz
c2lvbnMgYmVsb3cgKi8KKwkJaWYgKENJRlNfU0VSVkVSX0lTX0NIQU4oc2VydmVyKSkKIAkJCWNv
bnRpbnVlOwogCiAJCWMrKzsKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY2lmc2dsb2IuaCBiL2ZzL2Np
ZnMvY2lmc2dsb2IuaAppbmRleCAzYzE4YzU2YTExOWIuLmJlNzQ2MDY3MjRjNyAxMDA2NDQKLS0t
IGEvZnMvY2lmcy9jaWZzZ2xvYi5oCisrKyBiL2ZzL2NpZnMvY2lmc2dsb2IuaApAQCAtNjkwLDcg
KzY5MCwxNSBAQCBzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvIHsKIAkgKi8KIAlpbnQgbnJfdGFyZ2V0
czsKIAlib29sIG5vYmxvY2tjbnQ7IC8qIHVzZSBub24tYmxvY2tpbmcgY29ubmVjdCgpICovCi0J
Ym9vbCBpc19jaGFubmVsOyAvKiBpZiBhIHNlc3Npb24gY2hhbm5lbCAqLworCisJLyoKKwkgKiBJ
ZiB0aGlzIGlzIGEgc2Vzc2lvbiBjaGFubmVsLAorCSAqIHByaW1hcnlfc2VydmVyIGhvbGRzIHRo
ZSByZWYtY291bnRlZAorCSAqIHBvaW50ZXIgdG8gcHJpbWFyeSBjaGFubmVsIGNvbm5lY3Rpb24g
Zm9yIHRoZSBzZXNzaW9uLgorCSAqLworI2RlZmluZSBDSUZTX1NFUlZFUl9JU19DSEFOKHNlcnZl
cikJKCEhKHNlcnZlciktPnByaW1hcnlfc2VydmVyKQorCXN0cnVjdCBUQ1BfU2VydmVyX0luZm8g
KnByaW1hcnlfc2VydmVyOworCiAjaWZkZWYgQ09ORklHX0NJRlNfU1dOX1VQQ0FMTAogCWJvb2wg
dXNlX3N3bl9kc3RhZGRyOwogCXN0cnVjdCBzb2NrYWRkcl9zdG9yYWdlIHN3bl9kc3RhZGRyOwpk
aWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzcHJvdG8uaCBiL2ZzL2NpZnMvY2lmc3Byb3RvLmgKaW5k
ZXggYjI2OTczNTZiNWU3Li5mMzA3M2E2MmNlNTcgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvY2lmc3By
b3RvLmgKKysrIGIvZnMvY2lmcy9jaWZzcHJvdG8uaApAQCAtMjY5LDggKzI2OSw5IEBAIGV4dGVy
biB2b2lkIGNpZnNfY2xvc2VfYWxsX2RlZmVycmVkX2ZpbGVzKHN0cnVjdCBjaWZzX3Rjb24gKmNp
ZnNfdGNvbik7CiAKIGV4dGVybiB2b2lkIGNpZnNfY2xvc2VfZGVmZXJyZWRfZmlsZV91bmRlcl9k
ZW50cnkoc3RydWN0IGNpZnNfdGNvbiAqY2lmc190Y29uLAogCQkJCWNvbnN0IGNoYXIgKnBhdGgp
OwotCi1leHRlcm4gc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqY2lmc19nZXRfdGNwX3Nlc3Npb24o
c3RydWN0IHNtYjNfZnNfY29udGV4dCAqY3R4KTsKK2V4dGVybiBzdHJ1Y3QgVENQX1NlcnZlcl9J
bmZvICoKK2NpZnNfZ2V0X3RjcF9zZXNzaW9uKHN0cnVjdCBzbWIzX2ZzX2NvbnRleHQgKmN0eCwK
KwkJICAgICBzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpwcmltYXJ5X3NlcnZlcik7CiBleHRlcm4g
dm9pZCBjaWZzX3B1dF90Y3Bfc2Vzc2lvbihzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIs
CiAJCQkJIGludCBmcm9tX3JlY29ubmVjdCk7CiBleHRlcm4gdm9pZCBjaWZzX3B1dF90Y29uKHN0
cnVjdCBjaWZzX3Rjb24gKnRjb24pOwpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jb25uZWN0LmMgYi9m
cy9jaWZzL2Nvbm5lY3QuYwppbmRleCAwOWE1MzJlZDhmZTQuLmY4MGI3M2YyZDBhMCAxMDA2NDQK
LS0tIGEvZnMvY2lmcy9jb25uZWN0LmMKKysrIGIvZnMvY2lmcy9jb25uZWN0LmMKQEAgLTE3Myw2
ICsxNzMsNyBAQCBzdGF0aWMgdm9pZCBjaWZzX21hcmtfdGNwX3Nlc19jb25uc19mb3JfcmVjb25u
ZWN0KHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNlcnZlcgogCXN0cnVjdCBjaWZzX3Rjb24gKnRj
b247CiAJc3RydWN0IG1pZF9xX2VudHJ5ICptaWQsICpubWlkOwogCXN0cnVjdCBsaXN0X2hlYWQg
cmV0cnlfbGlzdDsKKwlzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpwc2VydmVyOwogCiAJc2VydmVy
LT5tYXhCdWYgPSAwOwogCXNlcnZlci0+bWF4X3JlYWQgPSAwOwpAQCAtMTg0LDggKzE4NSwxMiBA
QCBzdGF0aWMgdm9pZCBjaWZzX21hcmtfdGNwX3Nlc19jb25uc19mb3JfcmVjb25uZWN0KHN0cnVj
dCBUQ1BfU2VydmVyX0luZm8gKnNlcnZlcgogCSAqIGFyZSBub3QgdXNlZCB1bnRpbCByZWNvbm5l
Y3RlZC4KIAkgKi8KIAljaWZzX2RiZyhGWUksICIlczogbWFya2luZyBzZXNzaW9ucyBhbmQgdGNv
bnMgZm9yIHJlY29ubmVjdFxuIiwgX19mdW5jX18pOworCisJLyogSWYgc2VydmVyIGlzIGEgY2hh
bm5lbCwgc2VsZWN0IHRoZSBwcmltYXJ5IGNoYW5uZWwgKi8KKwlwc2VydmVyID0gQ0lGU19TRVJW
RVJfSVNfQ0hBTihzZXJ2ZXIpID8gc2VydmVyLT5wcmltYXJ5X3NlcnZlciA6IHNlcnZlcjsKKwog
CXNwaW5fbG9jaygmY2lmc190Y3Bfc2VzX2xvY2spOwotCWxpc3RfZm9yX2VhY2hfZW50cnkoc2Vz
LCAmc2VydmVyLT5zbWJfc2VzX2xpc3QsIHNtYl9zZXNfbGlzdCkgeworCWxpc3RfZm9yX2VhY2hf
ZW50cnkoc2VzLCAmcHNlcnZlci0+c21iX3Nlc19saXN0LCBzbWJfc2VzX2xpc3QpIHsKIAkJc2Vz
LT5uZWVkX3JlY29ubmVjdCA9IHRydWU7CiAJCWxpc3RfZm9yX2VhY2hfZW50cnkodGNvbiwgJnNl
cy0+dGNvbl9saXN0LCB0Y29uX2xpc3QpCiAJCQl0Y29uLT5uZWVkX3JlY29ubmVjdCA9IHRydWU7
CkBAIC0xMzM4LDcgKzEzNDMsNyBAQCBjaWZzX2ZpbmRfdGNwX3Nlc3Npb24oc3RydWN0IHNtYjNf
ZnNfY29udGV4dCAqY3R4KQogCQkgKiBTa2lwIHNlcyBjaGFubmVscyBzaW5jZSB0aGV5J3JlIG9u
bHkgaGFuZGxlZCBpbiBsb3dlciBsYXllcnMKIAkJICogKGUuZy4gY2lmc19zZW5kX3JlY3YpLgog
CQkgKi8KLQkJaWYgKHNlcnZlci0+aXNfY2hhbm5lbCB8fCAhbWF0Y2hfc2VydmVyKHNlcnZlciwg
Y3R4KSkKKwkJaWYgKENJRlNfU0VSVkVSX0lTX0NIQU4oc2VydmVyKSB8fCAhbWF0Y2hfc2VydmVy
KHNlcnZlciwgY3R4KSkKIAkJCWNvbnRpbnVlOwogCiAJCSsrc2VydmVyLT5zcnZfY291bnQ7CkBA
IC0xMzY5LDYgKzEzNzQsMTAgQEAgY2lmc19wdXRfdGNwX3Nlc3Npb24oc3RydWN0IFRDUF9TZXJ2
ZXJfSW5mbyAqc2VydmVyLCBpbnQgZnJvbV9yZWNvbm5lY3QpCiAJbGlzdF9kZWxfaW5pdCgmc2Vy
dmVyLT50Y3Bfc2VzX2xpc3QpOwogCXNwaW5fdW5sb2NrKCZjaWZzX3RjcF9zZXNfbG9jayk7CiAK
KwkvKiBGb3Igc2Vjb25kYXJ5IGNoYW5uZWxzLCB3ZSBwaWNrIHVwIHJlZi1jb3VudCBvbiB0aGUg
cHJpbWFyeSBzZXJ2ZXIgKi8KKwlpZiAoQ0lGU19TRVJWRVJfSVNfQ0hBTihzZXJ2ZXIpKQorCQlj
aWZzX3B1dF90Y3Bfc2Vzc2lvbihzZXJ2ZXItPnByaW1hcnlfc2VydmVyLCBmcm9tX3JlY29ubmVj
dCk7CisKIAljYW5jZWxfZGVsYXllZF93b3JrX3N5bmMoJnNlcnZlci0+ZWNobyk7CiAJY2FuY2Vs
X2RlbGF5ZWRfd29ya19zeW5jKCZzZXJ2ZXItPnJlc29sdmUpOwogCkBAIC0xNDAxLDcgKzE0MTAs
OCBAQCBjaWZzX3B1dF90Y3Bfc2Vzc2lvbihzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIs
IGludCBmcm9tX3JlY29ubmVjdCkKIH0KIAogc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqCi1jaWZz
X2dldF90Y3Bfc2Vzc2lvbihzdHJ1Y3Qgc21iM19mc19jb250ZXh0ICpjdHgpCitjaWZzX2dldF90
Y3Bfc2Vzc2lvbihzdHJ1Y3Qgc21iM19mc19jb250ZXh0ICpjdHgsCisJCSAgICAgc3RydWN0IFRD
UF9TZXJ2ZXJfSW5mbyAqcHJpbWFyeV9zZXJ2ZXIpCiB7CiAJc3RydWN0IFRDUF9TZXJ2ZXJfSW5m
byAqdGNwX3NlcyA9IE5VTEw7CiAJaW50IHJjOwpAQCAtMTQzOCw2ICsxNDQ4LDEwIEBAIGNpZnNf
Z2V0X3RjcF9zZXNzaW9uKHN0cnVjdCBzbWIzX2ZzX2NvbnRleHQgKmN0eCkKIAl0Y3Bfc2VzLT5p
bl9mbGlnaHQgPSAwOwogCXRjcF9zZXMtPm1heF9pbl9mbGlnaHQgPSAwOwogCXRjcF9zZXMtPmNy
ZWRpdHMgPSAxOworCWlmIChwcmltYXJ5X3NlcnZlcikgeworCQkrK3ByaW1hcnlfc2VydmVyLT5z
cnZfY291bnQ7CisJCXRjcF9zZXMtPnByaW1hcnlfc2VydmVyID0gcHJpbWFyeV9zZXJ2ZXI7CisJ
fQogCWluaXRfd2FpdHF1ZXVlX2hlYWQoJnRjcF9zZXMtPnJlc3BvbnNlX3EpOwogCWluaXRfd2Fp
dHF1ZXVlX2hlYWQoJnRjcF9zZXMtPnJlcXVlc3RfcSk7CiAJSU5JVF9MSVNUX0hFQUQoJnRjcF9z
ZXMtPnBlbmRpbmdfbWlkX3EpOwpAQCAtMTU1OSw2ICsxNTczLDggQEAgY2lmc19nZXRfdGNwX3Nl
c3Npb24oc3RydWN0IHNtYjNfZnNfY29udGV4dCAqY3R4KQogCiBvdXRfZXJyOgogCWlmICh0Y3Bf
c2VzKSB7CisJCWlmIChDSUZTX1NFUlZFUl9JU19DSEFOKHRjcF9zZXMpKQorCQkJY2lmc19wdXRf
dGNwX3Nlc3Npb24odGNwX3Nlcy0+cHJpbWFyeV9zZXJ2ZXIsIGZhbHNlKTsKIAkJa2ZyZWUodGNw
X3Nlcy0+aG9zdG5hbWUpOwogCQlpZiAodGNwX3Nlcy0+c3NvY2tldCkKIAkJCXNvY2tfcmVsZWFz
ZSh0Y3Bfc2VzLT5zc29ja2V0KTsKQEAgLTI5NjAsNyArMjk3Niw3IEBAIHN0YXRpYyBpbnQgbW91
bnRfZ2V0X2Nvbm5zKHN0cnVjdCBtb3VudF9jdHggKm1udF9jdHgpCiAJeGlkID0gZ2V0X3hpZCgp
OwogCiAJLyogZ2V0IGEgcmVmZXJlbmNlIHRvIGEgdGNwIHNlc3Npb24gKi8KLQlzZXJ2ZXIgPSBj
aWZzX2dldF90Y3Bfc2Vzc2lvbihjdHgpOworCXNlcnZlciA9IGNpZnNfZ2V0X3RjcF9zZXNzaW9u
KGN0eCwgTlVMTCk7CiAJaWYgKElTX0VSUihzZXJ2ZXIpKSB7CiAJCXJjID0gUFRSX0VSUihzZXJ2
ZXIpOwogCQlzZXJ2ZXIgPSBOVUxMOwpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9zZXNzLmMgYi9mcy9j
aWZzL3Nlc3MuYwppbmRleCAyNzY2MGJmZmI5MTguLjJjMTBiMTg2ZWQ2ZSAxMDA2NDQKLS0tIGEv
ZnMvY2lmcy9zZXNzLmMKKysrIGIvZnMvY2lmcy9zZXNzLmMKQEAgLTI1OCw3ICsyNTgsNyBAQCBj
aWZzX3Nlc19hZGRfY2hhbm5lbChzdHJ1Y3QgY2lmc19zYl9pbmZvICpjaWZzX3NiLCBzdHJ1Y3Qg
Y2lmc19zZXMgKnNlcywKIAkgICAgICAgU01CMl9DTElFTlRfR1VJRF9TSVpFKTsKIAljdHgudXNl
X2NsaWVudF9ndWlkID0gdHJ1ZTsKIAotCWNoYW5fc2VydmVyID0gY2lmc19nZXRfdGNwX3Nlc3Np
b24oJmN0eCk7CisJY2hhbl9zZXJ2ZXIgPSBjaWZzX2dldF90Y3Bfc2Vzc2lvbigmY3R4LCBzZXMt
PnNlcnZlcik7CiAKIAltdXRleF9sb2NrKCZzZXMtPnNlc3Npb25fbXV0ZXgpOwogCXNwaW5fbG9j
aygmc2VzLT5jaGFuX2xvY2spOwpAQCAtMjcyLDEwICsyNzIsNiBAQCBjaWZzX3Nlc19hZGRfY2hh
bm5lbChzdHJ1Y3QgY2lmc19zYl9pbmZvICpjaWZzX3NiLCBzdHJ1Y3QgY2lmc19zZXMgKnNlcywK
IAl9CiAJc3Bpbl91bmxvY2soJnNlcy0+Y2hhbl9sb2NrKTsKIAotCXNwaW5fbG9jaygmY2lmc190
Y3Bfc2VzX2xvY2spOwotCWNoYW4tPnNlcnZlci0+aXNfY2hhbm5lbCA9IHRydWU7Ci0Jc3Bpbl91
bmxvY2soJmNpZnNfdGNwX3Nlc19sb2NrKTsKLQogCS8qCiAJICogV2UgbmVlZCB0byBhbGxvY2F0
ZSB0aGUgc2VydmVyIGNyeXB0byBub3cgYXMgd2Ugd2lsbCBuZWVkCiAJICogdG8gc2lnbiBwYWNr
ZXRzIGJlZm9yZSB3ZSBnZW5lcmF0ZSB0aGUgY2hhbm5lbCBzaWduaW5nIGtleQpkaWZmIC0tZ2l0
IGEvZnMvY2lmcy9zbWIycGR1LmMgYi9mcy9jaWZzL3NtYjJwZHUuYwppbmRleCA1ZTAzMmIyYjJh
ZGIuLjJmNWYyYzRjNjE4MyAxMDA2NDQKLS0tIGEvZnMvY2lmcy9zbWIycGR1LmMKKysrIGIvZnMv
Y2lmcy9zbWIycGR1LmMKQEAgLTI1Nyw3ICsyNTcsNyBAQCBzbWIyX3JlY29ubmVjdChfX2xlMTYg
c21iMl9jb21tYW5kLCBzdHJ1Y3QgY2lmc190Y29uICp0Y29uLAogCS8qCiAJICogSWYgd2UgYXJl
IHJlY29ubmVjdGluZyBhbiBleHRyYSBjaGFubmVsLCBiaW5kCiAJICovCi0JaWYgKHNlcnZlci0+
aXNfY2hhbm5lbCkgeworCWlmIChDSUZTX1NFUlZFUl9JU19DSEFOKHNlcnZlcikpIHsKIAkJc2Vz
LT5iaW5kaW5nID0gdHJ1ZTsKIAkJc2VzLT5iaW5kaW5nX2NoYW4gPSBjaWZzX3Nlc19maW5kX2No
YW4oc2VzLCBzZXJ2ZXIpOwogCX0KLS0gCjIuMzIuMAoK
--000000000000298e9905d0a26224--
