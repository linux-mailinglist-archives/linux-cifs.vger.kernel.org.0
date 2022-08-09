Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C932758D317
	for <lists+linux-cifs@lfdr.de>; Tue,  9 Aug 2022 07:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbiHIFLq (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 9 Aug 2022 01:11:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbiHIFLo (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 9 Aug 2022 01:11:44 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 409351EED6
        for <linux-cifs@vger.kernel.org>; Mon,  8 Aug 2022 22:11:43 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id v128so10835771vsb.10
        for <linux-cifs@vger.kernel.org>; Mon, 08 Aug 2022 22:11:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=miTEw8LC5NaQAm+ykLphAFNNkaAcmCcx5VsX9OURAFc=;
        b=F0xVlEOqvhK/7JBGn870hZv7HO0ar8KvebO5E/lM+VD1XeGSsY9JXzEsdJ4It/TxS2
         ctbikDuqzluotMwGOvmxUFbayTCuhDEyyiqfoUvYuUO3RGiriK1laTvN30LOBxf6oNfU
         lOwxSE6jPRf7075FUPd4C+y1ZPLFFTKtIFpxpcmlWEeNt+SIkiHV0ZOFzNHGGII509VF
         4EErp9oHf9e9zZra7TuI4lgOCcyuM5TT9vg6zpjLbAPJ6538iPXJ++fFtNPz/bSZ5lmO
         s2jAtS7fvo0M8qh3E4K8ypbJBAmNlxfaGjk1ENfMtcfWs4MnfTCcvF+9s35s4/RP3JF3
         BMCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=miTEw8LC5NaQAm+ykLphAFNNkaAcmCcx5VsX9OURAFc=;
        b=ecYWaOAdOtN2k9EAf24v+qtY2QMWbFSWLnOnEgoJetkD5Z/wQL3jKnzZ8Ln93SKcJp
         8yQoPbEoPXhgA/BrF/kf/JkE16z1ZDUfRXacetMiSaGKht+XZwkfaZ3C5P9guXEDhhSo
         2v2JTxIp3/SOeYZ4s9b/oge7GJNo1vaHyRkKZ/cOu6Fcw1ETUBEKJuUIFlznFP94sUZO
         SHUcgY7VKbhJt4Q+6n2rkvaz+ZXMtVJKWFjD4342w36k/bEl/7KK0q+KtRxWuGElfcp9
         abAjP3Kn9kAhryLud4A/6Y9G/yW/aBKwYiO/4koMdMWrCMEqSoVrlZVjDIoY/be/47l/
         CsKg==
X-Gm-Message-State: ACgBeo0WzOYyZkMtCbV5nK6sqqhuxU8JJhPX7W5t9fUzTOxemH36/JFI
        QGUR4MCX3ukwfQ2/XwXsXmbEJCK0hef+d5Rdsyo+kWyPBEs=
X-Google-Smtp-Source: AA6agR4zXiSpiQdzHLjx5EC/LPpdj98PrMvVxefjxTX7cTSj3yWbeAtrV+X0kpmPI1kvS9FxdAxhuZ5kJKWnbbUKlww=
X-Received: by 2002:a67:b24b:0:b0:357:31a6:1767 with SMTP id
 s11-20020a67b24b000000b0035731a61767mr8651957vsh.29.1660021901836; Mon, 08
 Aug 2022 22:11:41 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 9 Aug 2022 00:11:31 -0500
Message-ID: <CAH2r5muR_X4FQMYv=-w-yP8Gv-qFLGEtXZD_36FJSCDracgnBA@mail.gmail.com>
Subject: [PATCH] fcntl F_GETLK return F_ULOCK if the whole file is locked by F_WRLCK
To:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000c756ff05e5c7f762"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--000000000000c756ff05e5c7f762
Content-Type: text/plain; charset="UTF-8"

Any comments on Paulo's patch?

It fixes a regression in connectathon test 2

I tentatively merged it into cifs-2.6.git for-next and added Cc:Stable


-- 
Thanks,

Steve

--000000000000c756ff05e5c7f762
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-cifs-fix-lock-length-calculation.patch"
Content-Disposition: attachment; 
	filename="0001-cifs-fix-lock-length-calculation.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l6lq4vu00>
X-Attachment-Id: f_l6lq4vu00

RnJvbSA5N2JiYTI0YzlmODBhNzE4MWJmYzU4YmJmODE5MjA5ZmI4YjIxMTI4IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBQYXVsbyBBbGNhbnRhcmEgPHBjQGNqci5uej4KRGF0ZTogTW9u
LCA4IEF1ZyAyMDIyIDEzOjQxOjE4IC0wMzAwClN1YmplY3Q6IFtQQVRDSF0gY2lmczogZml4IGxv
Y2sgbGVuZ3RoIGNhbGN1bGF0aW9uCgpUaGUgbG9jayBsZW5ndGggd2FzIHdyb25nbHkgc2V0IHRv
IDAgd2hlbiBmbF9lbmQgPT0gT0ZGU0VUX01BWCwgdGh1cwpmYWlsaW5nIHRvIGxvY2sgdGhlIHdo
b2xlIGZpbGUgd2hlbiBsX3N0YXJ0PTAgYW5kIGxfbGVuPTAuCgpUaGlzIGZpeGVzIHRlc3QgMiBm
cm9tIGN0aG9uMDQuCgpCZWZvcmUgcGF0Y2g6CgokIC4vY3Rob24wNC9sb2NrL3Rsb2NrbGZzIC10
IDIgL21udAoKQ3JlYXRpbmcgcGFyZW50L2NoaWxkIHN5bmNocm9uaXphdGlvbiBwaXBlcy4KClRl
c3QgIzEgLSBUZXN0IHJlZ2lvbnMgb2YgYW4gdW5sb2NrZWQgZmlsZS4KICAgICAgICBQYXJlbnQ6
IDEuMSAgLSBGX1RFU1QgIFsgICAgICAgICAgICAgICAwLCAgICAgICAgICAgICAgIDFdIFBBU1NF
RC4KICAgICAgICBQYXJlbnQ6IDEuMiAgLSBGX1RFU1QgIFsgICAgICAgICAgICAgICAwLCAgICAg
ICAgICBFTkRJTkddIFBBU1NFRC4KICAgICAgICBQYXJlbnQ6IDEuMyAgLSBGX1RFU1QgIFsgICAg
ICAgICAgICAgICAwLDdmZmZmZmZmZmZmZmZmZmZdIFBBU1NFRC4KICAgICAgICBQYXJlbnQ6IDEu
NCAgLSBGX1RFU1QgIFsgICAgICAgICAgICAgICAxLCAgICAgICAgICAgICAgIDFdIFBBU1NFRC4K
ICAgICAgICBQYXJlbnQ6IDEuNSAgLSBGX1RFU1QgIFsgICAgICAgICAgICAgICAxLCAgICAgICAg
ICBFTkRJTkddIFBBU1NFRC4KICAgICAgICBQYXJlbnQ6IDEuNiAgLSBGX1RFU1QgIFsgICAgICAg
ICAgICAgICAxLDdmZmZmZmZmZmZmZmZmZmZdIFBBU1NFRC4KICAgICAgICBQYXJlbnQ6IDEuNyAg
LSBGX1RFU1QgIFs3ZmZmZmZmZmZmZmZmZmZmLCAgICAgICAgICAgICAgIDFdIFBBU1NFRC4KICAg
ICAgICBQYXJlbnQ6IDEuOCAgLSBGX1RFU1QgIFs3ZmZmZmZmZmZmZmZmZmZmLCAgICAgICAgICBF
TkRJTkddIFBBU1NFRC4KICAgICAgICBQYXJlbnQ6IDEuOSAgLSBGX1RFU1QgIFs3ZmZmZmZmZmZm
ZmZmZmZmLDdmZmZmZmZmZmZmZmZmZmZdIFBBU1NFRC4KClRlc3QgIzIgLSBUcnkgdG8gbG9jayB0
aGUgd2hvbGUgZmlsZS4KICAgICAgICBQYXJlbnQ6IDIuMCAgLSBGX1RMT0NLIFsgICAgICAgICAg
ICAgICAwLCAgICAgICAgICBFTkRJTkddIFBBU1NFRC4KICAgICAgICBDaGlsZDogIDIuMSAgLSBG
X1RFU1QgIFsgICAgICAgICAgICAgICAwLCAgICAgICAgICAgICAgIDFdIEZBSUxFRCEKICAgICAg
ICBDaGlsZDogICoqKiogRXhwZWN0ZWQgRUFDQ0VTLCByZXR1cm5lZCBzdWNjZXNzLi4uCiAgICAg
ICAgQ2hpbGQ6ICAqKioqIFByb2JhYmx5IGltcGxlbWVudGF0aW9uIGVycm9yLgoKKiogIENISUxE
IHBhc3MgMSByZXN1bHRzOiAwLzAgcGFzcywgMC8wIHdhcm4sIDEvMSBmYWlsIChwYXNzL3RvdGFs
KS4KICAgICAgICBQYXJlbnQ6IENoaWxkIGRpZWQKCioqIFBBUkVOVCBwYXNzIDEgcmVzdWx0czog
MTAvMTAgcGFzcywgMC8wIHdhcm4sIDAvMCBmYWlsIChwYXNzL3RvdGFsKS4KCkFmdGVyIHBhdGNo
OgoKJCAuL2N0aG9uMDQvbG9jay90bG9ja2xmcyAtdCAyIC9tbnQKCkNyZWF0aW5nIHBhcmVudC9j
aGlsZCBzeW5jaHJvbml6YXRpb24gcGlwZXMuCgpUZXN0ICMyIC0gVHJ5IHRvIGxvY2sgdGhlIHdo
b2xlIGZpbGUuCiAgICAgICAgUGFyZW50OiAyLjAgIC0gRl9UTE9DSyBbICAgICAgICAgICAgICAg
MCwgICAgICAgICAgRU5ESU5HXSBQQVNTRUQuCiAgICAgICAgQ2hpbGQ6ICAyLjEgIC0gRl9URVNU
ICBbICAgICAgICAgICAgICAgMCwgICAgICAgICAgICAgICAxXSBQQVNTRUQuCiAgICAgICAgQ2hp
bGQ6ICAyLjIgIC0gRl9URVNUICBbICAgICAgICAgICAgICAgMCwgICAgICAgICAgRU5ESU5HXSBQ
QVNTRUQuCiAgICAgICAgQ2hpbGQ6ICAyLjMgIC0gRl9URVNUICBbICAgICAgICAgICAgICAgMCw3
ZmZmZmZmZmZmZmZmZmZmXSBQQVNTRUQuCiAgICAgICAgQ2hpbGQ6ICAyLjQgIC0gRl9URVNUICBb
ICAgICAgICAgICAgICAgMSwgICAgICAgICAgICAgICAxXSBQQVNTRUQuCiAgICAgICAgQ2hpbGQ6
ICAyLjUgIC0gRl9URVNUICBbICAgICAgICAgICAgICAgMSwgICAgICAgICAgRU5ESU5HXSBQQVNT
RUQuCiAgICAgICAgQ2hpbGQ6ICAyLjYgIC0gRl9URVNUICBbICAgICAgICAgICAgICAgMSw3ZmZm
ZmZmZmZmZmZmZmZmXSBQQVNTRUQuCiAgICAgICAgQ2hpbGQ6ICAyLjcgIC0gRl9URVNUICBbN2Zm
ZmZmZmZmZmZmZmZmZiwgICAgICAgICAgICAgICAxXSBQQVNTRUQuCiAgICAgICAgQ2hpbGQ6ICAy
LjggIC0gRl9URVNUICBbN2ZmZmZmZmZmZmZmZmZmZiwgICAgICAgICAgRU5ESU5HXSBQQVNTRUQu
CiAgICAgICAgQ2hpbGQ6ICAyLjkgIC0gRl9URVNUICBbN2ZmZmZmZmZmZmZmZmZmZiw3ZmZmZmZm
ZmZmZmZmZmZmXSBQQVNTRUQuCiAgICAgICAgUGFyZW50OiAyLjEwIC0gRl9VTE9DSyBbICAgICAg
ICAgICAgICAgMCwgICAgICAgICAgRU5ESU5HXSBQQVNTRUQuCgoqKiBQQVJFTlQgcGFzcyAxIHJl
c3VsdHM6IDIvMiBwYXNzLCAwLzAgd2FybiwgMC8wIGZhaWwgKHBhc3MvdG90YWwpLgoKKiogIENI
SUxEIHBhc3MgMSByZXN1bHRzOiA5LzkgcGFzcywgMC8wIHdhcm4sIDAvMCBmYWlsIChwYXNzL3Rv
dGFsKS4KCkZpeGVzOiBkODBjNjk4NDZkZGYgKCJjaWZzOiBmaXggc2lnbmVkIGludGVnZXIgb3Zl
cmZsb3cgd2hlbiBmbF9lbmQgaXMgT0ZGU0VUX01BWCIpClJlcG9ydGVkLWJ5OiBYaWFvbGkgRmVu
ZyA8eGlmZW5nQHJlZGhhdC5jb20+CkNjOiA8c3RhYmxlQHZnZXIua2VybmVsLm9yZz4KU2lnbmVk
LW9mZi1ieTogUGF1bG8gQWxjYW50YXJhIChTVVNFKSA8cGNAY2pyLm56PgpTaWduZWQtb2ZmLWJ5
OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvY2lmcy9jaWZz
Z2xvYi5oIHwgNCArKy0tCiBmcy9jaWZzL2ZpbGUuYyAgICAgfCA1ICsrLS0tCiAyIGZpbGVzIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgNSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9j
aWZzL2NpZnNnbG9iLmggYi9mcy9jaWZzL2NpZnNnbG9iLmgKaW5kZXggMzA3MDQwN2NhZmE3Li40
NWE3YTRhOTI2NDMgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvY2lmc2dsb2IuaAorKysgYi9mcy9jaWZz
L2NpZnNnbG9iLmgKQEAgLTIxMzIsOSArMjEzMiw5IEBAIHN0YXRpYyBpbmxpbmUgYm9vbCBjaWZz
X2lzX3JlZmVycmFsX3NlcnZlcihzdHJ1Y3QgY2lmc190Y29uICp0Y29uLAogCXJldHVybiBpc190
Y29uX2Rmcyh0Y29uKSB8fCAocmVmICYmIChyZWYtPmZsYWdzICYgREZTUkVGX1JFRkVSUkFMX1NF
UlZFUikpOwogfQogCi1zdGF0aWMgaW5saW5lIHU2NCBjaWZzX2Zsb2NrX2xlbihzdHJ1Y3QgZmls
ZV9sb2NrICpmbCkKK3N0YXRpYyBpbmxpbmUgdTY0IGNpZnNfZmxvY2tfbGVuKGNvbnN0IHN0cnVj
dCBmaWxlX2xvY2sgKmZsKQogewotCXJldHVybiBmbC0+ZmxfZW5kID09IE9GRlNFVF9NQVggPyAw
IDogZmwtPmZsX2VuZCAtIGZsLT5mbF9zdGFydCArIDE7CisJcmV0dXJuIGZsLT5mbF9lbmQgLSBm
bC0+Zmxfc3RhcnQgKyAxOwogfQogCiBzdGF0aWMgaW5saW5lIHNpemVfdCBudGxtc3NwX3dvcmtz
dGF0aW9uX25hbWVfc2l6ZShjb25zdCBzdHJ1Y3QgY2lmc19zZXMgKnNlcykKZGlmZiAtLWdpdCBh
L2ZzL2NpZnMvZmlsZS5jIGIvZnMvY2lmcy9maWxlLmMKaW5kZXggODVmMmFiY2IyNzk1Li40YmEw
MTljMjYwYWEgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvZmlsZS5jCisrKyBiL2ZzL2NpZnMvZmlsZS5j
CkBAIC0xOTM2LDkgKzE5MzYsOCBAQCBpbnQgY2lmc19sb2NrKHN0cnVjdCBmaWxlICpmaWxlLCBp
bnQgY21kLCBzdHJ1Y3QgZmlsZV9sb2NrICpmbG9jaykKIAlyYyA9IC1FQUNDRVM7CiAJeGlkID0g
Z2V0X3hpZCgpOwogCi0JY2lmc19kYmcoRllJLCAiTG9jayBwYXJtOiAweCV4IGZsb2NrZmxhZ3M6
IDB4JXggZmxvY2t0eXBlOiAweCV4IHN0YXJ0OiAlbGxkIGVuZDogJWxsZFxuIiwKLQkJIGNtZCwg
ZmxvY2stPmZsX2ZsYWdzLCBmbG9jay0+ZmxfdHlwZSwKLQkJIGZsb2NrLT5mbF9zdGFydCwgZmxv
Y2stPmZsX2VuZCk7CisJY2lmc19kYmcoRllJLCAiJXM6ICVwRDIgY21kPTB4JXggdHlwZT0weCV4
IGZsYWdzPTB4JXggcj0lTGQ6JUxkXG4iLCBfX2Z1bmNfXywgZmlsZSwgY21kLAorCQkgZmxvY2st
PmZsX2ZsYWdzLCBmbG9jay0+ZmxfdHlwZSwgZmxvY2stPmZsX3N0YXJ0LCBmbG9jay0+ZmxfZW5k
KTsKIAogCWNmaWxlID0gKHN0cnVjdCBjaWZzRmlsZUluZm8gKilmaWxlLT5wcml2YXRlX2RhdGE7
CiAJdGNvbiA9IHRsaW5rX3Rjb24oY2ZpbGUtPnRsaW5rKTsKLS0gCjIuMzQuMQoK
--000000000000c756ff05e5c7f762--
