Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4AE34E831C
	for <lists+linux-cifs@lfdr.de>; Sat, 26 Mar 2022 18:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234263AbiCZR5I (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 26 Mar 2022 13:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232395AbiCZR5H (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 26 Mar 2022 13:57:07 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3166F49FB1
        for <linux-cifs@vger.kernel.org>; Sat, 26 Mar 2022 10:55:30 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id h11so14079261ljb.2
        for <linux-cifs@vger.kernel.org>; Sat, 26 Mar 2022 10:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to;
        bh=SGPeKh25h42ausp7F4F9nRvcpfJVOaJ5hHxOk7ZJy2E=;
        b=m+fFXSHNv2wyCJjvpwF15CKnsIttSmKkxKU7nkhR/b2xKVAzs9gQf3r+tBrJtx9eaU
         NaY9ErJwFisuowSwbixmZSPTze7cRjv0DVzFP/3zMDcjJ1d65xTsH8PpRFjMU0GiF5Sy
         Zy7oUyhwc77Dni96nbW0XAVTAhL1p9Nr3tbsfQ5k6Wcf6SGo/iQy7bDyZ49Mpx9TVoFk
         4Rnbeh+MzbUi8+LSK+SY+vYY/WLWGj7cFcRdvHScWRVcNtOBONzBIVLoK5DEjIDw7EwL
         jlDqD10BxPVJNeKh4SJlS4oCP9UhIEry0izGX64FCo5z1RVXj6RmCtBX+ETDGK9v89AZ
         wCuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=SGPeKh25h42ausp7F4F9nRvcpfJVOaJ5hHxOk7ZJy2E=;
        b=xu40WLnyyOA6zqcdalVAkPdqjdq/qM2ZL8o4A0KjTkho2VQApwcELfrXuh19niZdV3
         OfJYW3IRTmOZagP69QxlNO8fU1wkcZrctp0P34JaKmD30vIxS5m8Z+yTNNqofyIH08y+
         sJd9sBVnHswKDgpTxA2idv4tylN/LrVMflbIQFkuKJ5y3eblVbRBMGlm6Ojf2F9Rjy0E
         uaaAmTYNQdtEDkNdk5ccCQAv5yqt9YychKaHypq/8dXbWZ8X7z0sJ6FnFgj9C6N+lAD0
         wgmJ1n48GUYc+p8dEtDmCjsQAIp3mtyibWYexpEP2QuTr1jT9CmbGNGCmeCvyz//vLFT
         z9OA==
X-Gm-Message-State: AOAM531VaCQQWTgs+9gQw8SbIDkxy4zP0rxtvYaTo6pPAI2+Wis0//w2
        mJ514HNtv9m3ew8dsDfWNAmSGeyLtZ8g11Xk5U/hp4QdU5Y=
X-Google-Smtp-Source: ABdhPJyEHZUiEETO51BT9s77MRzAY4dLUJGtUeDJ0vyMSdxzoy3m0/AIb+pDTcwuXrCzqp1zcdZ5J3r/xPaufhXhGKQ=
X-Received: by 2002:a2e:9919:0:b0:24a:c41a:a3f0 with SMTP id
 v25-20020a2e9919000000b0024ac41aa3f0mr3227053lji.23.1648317328430; Sat, 26
 Mar 2022 10:55:28 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 26 Mar 2022 12:55:17 -0500
Message-ID: <CAH2r5muFUWGfK8LTrZA6wFD+XbG51RRM3dNyqEvA4B3mLiAkmA@mail.gmail.com>
Subject: [PATCH][SMB3] move more protocol header definitions to fs/smbfs_common
To:     Namjae Jeon <linkinjeon@kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: multipart/mixed; boundary="000000000000d6b3bb05db22c815"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--000000000000d6b3bb05db22c815
Content-Type: text/plain; charset="UTF-8"

Move defines for ioctl protocol header and various size to smbfs_common

The definitions for the ioctl SMB3 request and response as well
as length of various fields defined in the protocol documentation
were duplicated in fs/ksmbd and fs/cifs.  Move these to the common
code in fs/smbfs_common/smb2pdu.h

See attached


-- 
Thanks,

Steve

--000000000000d6b3bb05db22c815
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb3-move-defines-for-ioctl-protocol-header-and-vari.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-move-defines-for-ioctl-protocol-header-and-vari.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l185kk7y0>
X-Attachment-Id: f_l185kk7y0

RnJvbSA4ZjAzOTA3OWJlM2E4MTNkZDM5YjBlNjFkODczOGY4MGJhOWVkM2FhIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFNhdCwgMjYgTWFyIDIwMjIgMTI6NDc6NTcgLTA1MDAKU3ViamVjdDogW1BBVENIXSBz
bWIzOiBtb3ZlIGRlZmluZXMgZm9yIGlvY3RsIHByb3RvY29sIGhlYWRlciBhbmQgdmFyaW91cyBz
aXplCiB0byBzbWJmc19jb21tb24KClRoZSBkZWZpbml0aW9ucyBmb3IgdGhlIGlvY3RsIFNNQjMg
cmVxdWVzdCBhbmQgcmVzcG9uc2UgYXMgd2VsbAphcyBsZW5ndGggb2YgdmFyaW91cyBmaWVsZHMg
ZGVmaW5lZCBpbiB0aGUgcHJvdG9jb2wgZG9jdW1lbnRhdGlvbgp3ZXJlIGR1cGxpY2F0ZWQgaW4g
ZnMva3NtYmQgYW5kIGZzL2NpZnMuICBNb3ZlIHRoZXNlIHRvIHRoZSBjb21tb24KY29kZSBpbiBm
cy9zbWJmc19jb21tb24vc21iMnBkdS5oCgpTaWduZWQtb2ZmLWJ5OiBTdGV2ZSBGcmVuY2ggPHN0
ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvY2lmcy9jaWZzZ2xvYi5oICAgICAgICB8ICA2
IC0tLQogZnMvY2lmcy9jaWZzcGR1LmggICAgICAgICB8IDEyIC0tLS0tLQogZnMvY2lmcy9zbWIy
Z2xvYi5oICAgICAgICB8IDExIC0tLS0tCiBmcy9jaWZzL3NtYjJwZHUuaCAgICAgICAgIHwgNDEg
LS0tLS0tLS0tLS0tLS0tLS0tLQogZnMva3NtYmQvc21iMnBkdS5jICAgICAgICB8ICA2ICstLQog
ZnMva3NtYmQvc21iMnBkdS5oICAgICAgICB8IDcwIC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KIGZzL3NtYmZzX2NvbW1vbi9zbWIycGR1LmggfCA4NiArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysKIDcgZmlsZXMgY2hhbmdlZCwgODkgaW5zZXJ0aW9ucygrKSwg
MTQzIGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY2lmc2dsb2IuaCBiL2ZzL2Np
ZnMvY2lmc2dsb2IuaAppbmRleCA0OGIzNDNkMDM0MzAuLmFkM2NkNjA1M2Y0ZSAxMDA2NDQKLS0t
IGEvZnMvY2lmcy9jaWZzZ2xvYi5oCisrKyBiL2ZzL2NpZnMvY2lmc2dsb2IuaApAQCAtODUyLDEz
ICs4NTIsNyBAQCBjb21wYXJlX21pZChfX3UxNiBtaWQsIGNvbnN0IHN0cnVjdCBzbWJfaGRyICpz
bWIpCiAjZGVmaW5lIENJRlNfTUFYX1JGQzEwMDJfV1NJWkUgKCgxPDwxNykgLSAxIC0gc2l6ZW9m
KFdSSVRFX1JFUSkgKyA0KQogI2RlZmluZSBDSUZTX01BWF9SRkMxMDAyX1JTSVpFICgoMTw8MTcp
IC0gMSAtIHNpemVvZihSRUFEX1JTUCkgKyA0KQogCi0vKgotICogVGhlIGRlZmF1bHQgd3NpemUg
aXMgMU0uIGZpbmRfZ2V0X3BhZ2VzIHNlZW1zIHRvIHJldHVybiBhIG1heGltdW0gb2YgMjU2Ci0g
KiBwYWdlcyBpbiBhIHNpbmdsZSBjYWxsLiBXaXRoIFBBR0VfU0laRSA9PSA0aywgdGhpcyBtZWFu
cyB3ZSBjYW4gZmlsbAotICogYSBzaW5nbGUgd3NpemUgcmVxdWVzdCB3aXRoIGEgc2luZ2xlIGNh
bGwuCi0gKi8KICNkZWZpbmUgQ0lGU19ERUZBVUxUX0lPU0laRSAoMTAyNCAqIDEwMjQpCi0jZGVm
aW5lIFNNQjNfREVGQVVMVF9JT1NJWkUgKDQgKiAxMDI0ICogMTAyNCkKIAogLyoKICAqIFdpbmRv
d3Mgb25seSBzdXBwb3J0cyBhIG1heCBvZiA2MGtiIHJlYWRzIGFuZCA2NTUzNSBieXRlIHdyaXRl
cy4gRGVmYXVsdCB0bwpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzcGR1LmggYi9mcy9jaWZzL2Np
ZnNwZHUuaAppbmRleCA2OGI5YTQzNmFmNGIuLmYyMTRjYmViMmEzNiAxMDA2NDQKLS0tIGEvZnMv
Y2lmcy9jaWZzcGR1LmgKKysrIGIvZnMvY2lmcy9jaWZzcGR1LmgKQEAgLTEyMywxOCArMTIzLDYg
QEAKICAqLwogI2RlZmluZSBDSUZTX1NFU1NfS0VZX1NJWkUgKDE2KQogCi0vKgotICogU2l6ZSBv
ZiB0aGUgc21iMyBzaWduaW5nIGtleQotICovCi0jZGVmaW5lIFNNQjNfU0lHTl9LRVlfU0laRSAo
MTYpCi0KLS8qCi0gKiBTaXplIG9mIHRoZSBzbWIzIGVuY3J5cHRpb24vZGVjcnlwdGlvbiBrZXkg
c3RvcmFnZS4KLSAqIFRoaXMgc2l6ZSBpcyBiaWcgZW5vdWdoIHRvIHN0b3JlIGFueSBjaXBoZXIg
a2V5IHR5cGVzLgotICovCi0jZGVmaW5lIFNNQjNfRU5DX0RFQ19LRVlfU0laRSAoMzIpCi0KLSNk
ZWZpbmUgQ0lGU19DTElFTlRfQ0hBTExFTkdFX1NJWkUgKDgpCiAjZGVmaW5lIENJRlNfU0VSVkVS
X0NIQUxMRU5HRV9TSVpFICg4KQogI2RlZmluZSBDSUZTX0hNQUNfTUQ1X0hBU0hfU0laRSAoMTYp
CiAjZGVmaW5lIENJRlNfQ1BIVFhUX1NJWkUgKDE2KQpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9zbWIy
Z2xvYi5oIGIvZnMvY2lmcy9zbWIyZ2xvYi5oCmluZGV4IDQxMjVmZDExM2NmYi4uODJlOTE2YWQx
NjdjIDEwMDY0NAotLS0gYS9mcy9jaWZzL3NtYjJnbG9iLmgKKysrIGIvZnMvY2lmcy9zbWIyZ2xv
Yi5oCkBAIC00MSwxNSArNDEsNCBAQAogI2RlZmluZSBFTkRfT0ZfQ0hBSU4gNAogI2RlZmluZSBS
RUxBVEVEX1JFUVVFU1QgOAogCi0jZGVmaW5lIFNNQjJfU0lHTkFUVVJFX1NJWkUgKDE2KQotI2Rl
ZmluZSBTTUIyX05UTE1WMl9TRVNTS0VZX1NJWkUgKDE2KQotI2RlZmluZSBTTUIyX0hNQUNTSEEy
NTZfU0laRSAoMzIpCi0jZGVmaW5lIFNNQjJfQ01BQ0FFU19TSVpFICgxNikKLSNkZWZpbmUgU01C
M19TSUdOS0VZX1NJWkUgKDE2KQotI2RlZmluZSBTTUIzX0dDTTEyOF9DUllQVEtFWV9TSVpFICgx
NikKLSNkZWZpbmUgU01CM19HQ00yNTZfQ1JZUFRLRVlfU0laRSAoMzIpCi0KLS8qIE1heGltdW0g
YnVmZmVyIHNpemUgdmFsdWUgd2UgY2FuIHNlbmQgd2l0aCAxIGNyZWRpdCAqLwotI2RlZmluZSBT
TUIyX01BWF9CVUZGRVJfU0laRSA2NTUzNgotCiAjZW5kaWYJLyogX1NNQjJfR0xPQl9IICovCmRp
ZmYgLS1naXQgYS9mcy9jaWZzL3NtYjJwZHUuaCBiL2ZzL2NpZnMvc21iMnBkdS5oCmluZGV4IDlh
YTJhYjhjYTVhZS4uMTYyZjFiZTg4NmZlIDEwMDY0NAotLS0gYS9mcy9jaWZzL3NtYjJwZHUuaAor
KysgYi9mcy9jaWZzL3NtYjJwZHUuaApAQCAtMTQxLDEzICsxNDEsNiBAQCBzdHJ1Y3QgY3JlYXRl
X2R1cmFibGUgewogCX0gRGF0YTsKIH0gX19wYWNrZWQ7CiAKLXN0cnVjdCBjcmVhdGVfcG9zaXgg
ewotCXN0cnVjdCBjcmVhdGVfY29udGV4dCBjY29udGV4dDsKLQlfX3U4CU5hbWVbMTZdOwotCV9f
bGUzMiAgTW9kZTsKLQlfX3UzMglSZXNlcnZlZDsKLX0gX19wYWNrZWQ7Ci0KIC8qIFNlZSBNUy1T
TUIyIDIuMi4xMy4yLjExICovCiAvKiBGbGFncyAqLwogI2RlZmluZSBTTUIyX0RIQU5ETEVfRkxB
R19QRVJTSVNURU5UCTB4MDAwMDAwMDIKQEAgLTQyOCw0MCArNDIxLDYgQEAgc3RydWN0IGR1cGxp
Y2F0ZV9leHRlbnRzX3RvX2ZpbGUgewogICovCiAjZGVmaW5lIFNNQjJfSU9DVExfSU9WX1NJWkUg
MgogCi1zdHJ1Y3Qgc21iMl9pb2N0bF9yZXEgewotCXN0cnVjdCBzbWIyX2hkciBoZHI7Ci0JX19s
ZTE2IFN0cnVjdHVyZVNpemU7CS8qIE11c3QgYmUgNTcgKi8KLQlfX3UxNiBSZXNlcnZlZDsKLQlf
X2xlMzIgQ3RsQ29kZTsKLQlfX3U2NCAgUGVyc2lzdGVudEZpbGVJZDsgLyogb3BhcXVlIGVuZGlh
bm5lc3MgKi8KLQlfX3U2NCAgVm9sYXRpbGVGaWxlSWQ7IC8qIG9wYXF1ZSBlbmRpYW5uZXNzICov
Ci0JX19sZTMyIElucHV0T2Zmc2V0OwotCV9fbGUzMiBJbnB1dENvdW50OwotCV9fbGUzMiBNYXhJ
bnB1dFJlc3BvbnNlOwotCV9fbGUzMiBPdXRwdXRPZmZzZXQ7Ci0JX19sZTMyIE91dHB1dENvdW50
OwotCV9fbGUzMiBNYXhPdXRwdXRSZXNwb25zZTsKLQlfX2xlMzIgRmxhZ3M7Ci0JX191MzIgIFJl
c2VydmVkMjsKLQlfX3U4ICAgQnVmZmVyW107Ci19IF9fcGFja2VkOwotCi1zdHJ1Y3Qgc21iMl9p
b2N0bF9yc3AgewotCXN0cnVjdCBzbWIyX2hkciBoZHI7Ci0JX19sZTE2IFN0cnVjdHVyZVNpemU7
CS8qIE11c3QgYmUgNTcgKi8KLQlfX3UxNiBSZXNlcnZlZDsKLQlfX2xlMzIgQ3RsQ29kZTsKLQlf
X3U2NCAgUGVyc2lzdGVudEZpbGVJZDsgLyogb3BhcXVlIGVuZGlhbm5lc3MgKi8KLQlfX3U2NCAg
Vm9sYXRpbGVGaWxlSWQ7IC8qIG9wYXF1ZSBlbmRpYW5uZXNzICovCi0JX19sZTMyIElucHV0T2Zm
c2V0OwotCV9fbGUzMiBJbnB1dENvdW50OwotCV9fbGUzMiBPdXRwdXRPZmZzZXQ7Ci0JX19sZTMy
IE91dHB1dENvdW50OwotCV9fbGUzMiBGbGFnczsKLQlfX3UzMiAgUmVzZXJ2ZWQyOwotCS8qIGNo
YXIgKiBidWZmZXJbXSAqLwotfSBfX3BhY2tlZDsKLQogI2RlZmluZSBTTUIyX0xPQ0tGTEFHX1NI
QVJFRF9MT0NLCTB4MDAwMQogI2RlZmluZSBTTUIyX0xPQ0tGTEFHX0VYQ0xVU0lWRV9MT0NLCTB4
MDAwMgogI2RlZmluZSBTTUIyX0xPQ0tGTEFHX1VOTE9DSwkJMHgwMDA0CmRpZmYgLS1naXQgYS9m
cy9rc21iZC9zbWIycGR1LmMgYi9mcy9rc21iZC9zbWIycGR1LmMKaW5kZXggNTQ0MGQ2MWNlYTlm
Li5lN2ViODM1NjQ4ZjggMTAwNjQ0Ci0tLSBhL2ZzL2tzbWJkL3NtYjJwZHUuYworKysgYi9mcy9r
c21iZC9zbWIycGR1LmMKQEAgLTc1ODEsNyArNzU4MSw3IEBAIGludCBzbWIyX2lvY3RsKHN0cnVj
dCBrc21iZF93b3JrICp3b3JrKQogCQlnb3RvIG91dDsKIAl9CiAKLQljbnRfY29kZSA9IGxlMzJf
dG9fY3B1KHJlcS0+Q250Q29kZSk7CisJY250X2NvZGUgPSBsZTMyX3RvX2NwdShyZXEtPkN0bENv
ZGUpOwogCXJldCA9IHNtYjJfY2FsY19tYXhfb3V0X2J1Zl9sZW4od29yaywgNDgsCiAJCQkJCWxl
MzJfdG9fY3B1KHJlcS0+TWF4T3V0cHV0UmVzcG9uc2UpKTsKIAlpZiAocmV0IDwgMCkgewpAQCAt
NzY4Nyw3ICs3Njg3LDcgQEAgaW50IHNtYjJfaW9jdGwoc3RydWN0IGtzbWJkX3dvcmsgKndvcmsp
CiAJCXJzcC0+UGVyc2lzdGVudEZpbGVJZCA9IHJlcS0+UGVyc2lzdGVudEZpbGVJZDsKIAkJZnNj
dGxfY29weWNodW5rKHdvcmssCiAJCQkJKHN0cnVjdCBjb3B5Y2h1bmtfaW9jdGxfcmVxICopJnJl
cS0+QnVmZmVyWzBdLAotCQkJCWxlMzJfdG9fY3B1KHJlcS0+Q250Q29kZSksCisJCQkJbGUzMl90
b19jcHUocmVxLT5DdGxDb2RlKSwKIAkJCQlsZTMyX3RvX2NwdShyZXEtPklucHV0Q291bnQpLAog
CQkJCXJlcS0+Vm9sYXRpbGVGaWxlSWQsCiAJCQkJcmVxLT5QZXJzaXN0ZW50RmlsZUlkLApAQCAt
Nzg0MSw3ICs3ODQxLDcgQEAgaW50IHNtYjJfaW9jdGwoc3RydWN0IGtzbWJkX3dvcmsgKndvcmsp
CiAJCWdvdG8gb3V0OwogCX0KIAotCXJzcC0+Q250Q29kZSA9IGNwdV90b19sZTMyKGNudF9jb2Rl
KTsKKwlyc3AtPkN0bENvZGUgPSBjcHVfdG9fbGUzMihjbnRfY29kZSk7CiAJcnNwLT5JbnB1dENv
dW50ID0gY3B1X3RvX2xlMzIoMCk7CiAJcnNwLT5JbnB1dE9mZnNldCA9IGNwdV90b19sZTMyKDEx
Mik7CiAJcnNwLT5PdXRwdXRPZmZzZXQgPSBjcHVfdG9fbGUzMigxMTIpOwpkaWZmIC0tZ2l0IGEv
ZnMva3NtYmQvc21iMnBkdS5oIGIvZnMva3NtYmQvc21iMnBkdS5oCmluZGV4IGJmMWY4MmQ4NTk2
ZC4uZmQwNWQzYTFlZGExIDEwMDY0NAotLS0gYS9mcy9rc21iZC9zbWIycGR1LmgKKysrIGIvZnMv
a3NtYmQvc21iMnBkdS5oCkBAIC0xNiw0MiArMTYsMTMgQEAKICNkZWZpbmUgRklMRV9DUkVBVEVE
ICAgICAgICAgICAweDAwMDAwMDAyCiAjZGVmaW5lIEZJTEVfT1ZFUldSSVRURU4gICAgICAgMHgw
MDAwMDAwMwogCi0vKgotICogU2l6ZSBvZiB0aGUgc2Vzc2lvbiBrZXkgKGNyeXB0byBrZXkgZW5j
cnlwdGVkIHdpdGggdGhlIHBhc3N3b3JkCi0gKi8KLSNkZWZpbmUgU01CMl9OVExNVjJfU0VTU0tF
WV9TSVpFCTE2Ci0jZGVmaW5lIFNNQjJfU0lHTkFUVVJFX1NJWkUJCTE2Ci0jZGVmaW5lIFNNQjJf
SE1BQ1NIQTI1Nl9TSVpFCQkzMgotI2RlZmluZSBTTUIyX0NNQUNBRVNfU0laRQkJMTYKLSNkZWZp
bmUgU01CM19HQ00xMjhfQ1JZUFRLRVlfU0laRQkxNgotI2RlZmluZSBTTUIzX0dDTTI1Nl9DUllQ
VEtFWV9TSVpFCTMyCi0KLS8qCi0gKiBTaXplIG9mIHRoZSBzbWIzIGVuY3J5cHRpb24vZGVjcnlw
dGlvbiBrZXlzCi0gKi8KLSNkZWZpbmUgU01CM19FTkNfREVDX0tFWV9TSVpFCQkzMgotCi0vKgot
ICogU2l6ZSBvZiB0aGUgc21iMyBzaWduaW5nIGtleQotICovCi0jZGVmaW5lIFNNQjNfU0lHTl9L
RVlfU0laRQkJMTYKLQotI2RlZmluZSBDSUZTX0NMSUVOVF9DSEFMTEVOR0VfU0laRQk4Ci0jZGVm
aW5lIFNNQl9TRVJWRVJfQ0hBTExFTkdFX1NJWkUJOAotCiAvKiBTTUIyIE1heCBDcmVkaXRzICov
CiAjZGVmaW5lIFNNQjJfTUFYX0NSRURJVFMJCTgxOTIKIAotLyogTWF4aW11bSBidWZmZXIgc2l6
ZSB2YWx1ZSB3ZSBjYW4gc2VuZCB3aXRoIDEgY3JlZGl0ICovCi0jZGVmaW5lIFNNQjJfTUFYX0JV
RkZFUl9TSVpFIDY1NTM2Ci0KLSNkZWZpbmUgTlVNQkVSX09GX1NNQjJfQ09NTUFORFMJMHgwMDEz
Ci0KIC8qIEJCIEZJWE1FIC0gYW5hbHl6ZSBmb2xsb3dpbmcgbGVuZ3RoIEJCICovCiAjZGVmaW5l
IE1BWF9TTUIyX0hEUl9TSVpFIDB4NzggLyogNCBsZW4gKyA2NCBoZHIgKyAoMioyNCB3Y3QpICsg
MiBiY3QgKyAyIHBhZCAqLwogCiAjZGVmaW5lIFNNQjIxX0RFRkFVTFRfSU9TSVpFCSgxMDI0ICog
MTAyNCkKLSNkZWZpbmUgU01CM19ERUZBVUxUX0lPU0laRQkoNCAqIDEwMjQgKiAxMDI0KQogI2Rl
ZmluZSBTTUIzX0RFRkFVTFRfVFJBTlNfU0laRQkoMTAyNCAqIDEwMjQpCiAjZGVmaW5lIFNNQjNf
TUlOX0lPU0laRQkoNjQgKiAxMDI0KQogI2RlZmluZSBTTUIzX01BWF9JT1NJWkUJKDggKiAxMDI0
ICogMTAyNCkKQEAgLTE0OSwxMyArMTIwLDYgQEAgc3RydWN0IGNyZWF0ZV9hbGxvY19zaXplX3Jl
cSB7CiAJX19sZTY0IEFsbG9jYXRpb25TaXplOwogfSBfX3BhY2tlZDsKIAotc3RydWN0IGNyZWF0
ZV9wb3NpeCB7Ci0Jc3RydWN0IGNyZWF0ZV9jb250ZXh0IGNjb250ZXh0OwotCV9fdTggICAgTmFt
ZVsxNl07Ci0JX19sZTMyICBNb2RlOwotCV9fdTMyICAgUmVzZXJ2ZWQ7Ci19IF9fcGFja2VkOwot
CiBzdHJ1Y3QgY3JlYXRlX2R1cmFibGVfcnNwIHsKIAlzdHJ1Y3QgY3JlYXRlX2NvbnRleHQgY2Nv
bnRleHQ7CiAJX191OCAgIE5hbWVbOF07CkBAIC0yMTMsNDAgKzE3Nyw2IEBAIHN0cnVjdCBkdXBs
aWNhdGVfZXh0ZW50c190b19maWxlIHsKIAlfX2xlNjQgQnl0ZUNvdW50OyAgLyogQnl0ZXMgdG8g
YmUgY29waWVkICovCiB9IF9fcGFja2VkOwogCi1zdHJ1Y3Qgc21iMl9pb2N0bF9yZXEgewotCXN0
cnVjdCBzbWIyX2hkciBoZHI7Ci0JX19sZTE2IFN0cnVjdHVyZVNpemU7IC8qIE11c3QgYmUgNTcg
Ki8KLQlfX2xlMTYgUmVzZXJ2ZWQ7IC8qIG9mZnNldCBmcm9tIHN0YXJ0IG9mIFNNQjIgaGVhZGVy
IHRvIHdyaXRlIGRhdGEgKi8KLQlfX2xlMzIgQ250Q29kZTsKLQlfX3U2NCAgUGVyc2lzdGVudEZp
bGVJZDsKLQlfX3U2NCAgVm9sYXRpbGVGaWxlSWQ7Ci0JX19sZTMyIElucHV0T2Zmc2V0OyAvKiBS
ZXNlcnZlZCBNQlogKi8KLQlfX2xlMzIgSW5wdXRDb3VudDsKLQlfX2xlMzIgTWF4SW5wdXRSZXNw
b25zZTsKLQlfX2xlMzIgT3V0cHV0T2Zmc2V0OwotCV9fbGUzMiBPdXRwdXRDb3VudDsKLQlfX2xl
MzIgTWF4T3V0cHV0UmVzcG9uc2U7Ci0JX19sZTMyIEZsYWdzOwotCV9fbGUzMiBSZXNlcnZlZDI7
Ci0JX191OCAgIEJ1ZmZlclsxXTsKLX0gX19wYWNrZWQ7Ci0KLXN0cnVjdCBzbWIyX2lvY3RsX3Jz
cCB7Ci0Jc3RydWN0IHNtYjJfaGRyIGhkcjsKLQlfX2xlMTYgU3RydWN0dXJlU2l6ZTsgLyogTXVz
dCBiZSA0OSAqLwotCV9fbGUxNiBSZXNlcnZlZDsgLyogb2Zmc2V0IGZyb20gc3RhcnQgb2YgU01C
MiBoZWFkZXIgdG8gd3JpdGUgZGF0YSAqLwotCV9fbGUzMiBDbnRDb2RlOwotCV9fdTY0ICBQZXJz
aXN0ZW50RmlsZUlkOwotCV9fdTY0ICBWb2xhdGlsZUZpbGVJZDsKLQlfX2xlMzIgSW5wdXRPZmZz
ZXQ7IC8qIFJlc2VydmVkIE1CWiAqLwotCV9fbGUzMiBJbnB1dENvdW50OwotCV9fbGUzMiBPdXRw
dXRPZmZzZXQ7Ci0JX19sZTMyIE91dHB1dENvdW50OwotCV9fbGUzMiBGbGFnczsKLQlfX2xlMzIg
UmVzZXJ2ZWQyOwotCV9fdTggICBCdWZmZXJbMV07Ci19IF9fcGFja2VkOwotCiBzdHJ1Y3QgdmFs
aWRhdGVfbmVnb3RpYXRlX2luZm9fcmVxIHsKIAlfX2xlMzIgQ2FwYWJpbGl0aWVzOwogCV9fdTgg
ICBHdWlkW1NNQjJfQ0xJRU5UX0dVSURfU0laRV07CmRpZmYgLS1naXQgYS9mcy9zbWJmc19jb21t
b24vc21iMnBkdS5oIGIvZnMvc21iZnNfY29tbW9uL3NtYjJwZHUuaAppbmRleCBjMjFlY2M0ODA2
ZjEuLmQyNzBjNzYwNTBiMSAxMDA2NDQKLS0tIGEvZnMvc21iZnNfY29tbW9uL3NtYjJwZHUuaAor
KysgYi9mcy9zbWJmc19jb21tb24vc21iMnBkdS5oCkBAIC02MCw2ICs2MCw0MCBAQAogCiAjZGVm
aW5lIE5VTUJFUl9PRl9TTUIyX0NPTU1BTkRTCTB4MDAxMwogCisvKgorICogU2l6ZSBvZiB0aGUg
c2Vzc2lvbiBrZXkgKGNyeXB0byBrZXkgZW5jcnlwdGVkIHdpdGggdGhlIHBhc3N3b3JkCisgKi8K
KyNkZWZpbmUgU01CMl9OVExNVjJfU0VTU0tFWV9TSVpFCTE2CisjZGVmaW5lIFNNQjJfU0lHTkFU
VVJFX1NJWkUJCTE2CisjZGVmaW5lIFNNQjJfSE1BQ1NIQTI1Nl9TSVpFCQkzMgorI2RlZmluZSBT
TUIyX0NNQUNBRVNfU0laRQkJMTYKKyNkZWZpbmUgU01CM19HQ00xMjhfQ1JZUFRLRVlfU0laRQkx
NgorI2RlZmluZSBTTUIzX0dDTTI1Nl9DUllQVEtFWV9TSVpFCTMyCisKKy8qCisgKiBTaXplIG9m
IHRoZSBzbWIzIGVuY3J5cHRpb24vZGVjcnlwdGlvbiBrZXlzCisgKiBUaGlzIHNpemUgaXMgYmln
IGVub3VnaCB0byBzdG9yZSBhbnkgY2lwaGVyIGtleSB0eXBlcy4KKyAqLworI2RlZmluZSBTTUIz
X0VOQ19ERUNfS0VZX1NJWkUJCTMyCisKKy8qCisgKiBTaXplIG9mIHRoZSBzbWIzIHNpZ25pbmcg
a2V5CisgKi8KKyNkZWZpbmUgU01CM19TSUdOX0tFWV9TSVpFCQkxNgorCisjZGVmaW5lIENJRlNf
Q0xJRU5UX0NIQUxMRU5HRV9TSVpFCTgKKworLyogTWF4aW11bSBidWZmZXIgc2l6ZSB2YWx1ZSB3
ZSBjYW4gc2VuZCB3aXRoIDEgY3JlZGl0ICovCisjZGVmaW5lIFNNQjJfTUFYX0JVRkZFUl9TSVpF
IDY1NTM2CisKKy8qCisgKiBUaGUgZGVmYXVsdCB3c2l6ZSBpcyAxTSBmb3IgU01CMiAoYW5kIGZv
ciBzb21lIENJRlMgY2FzZXMpLgorICogZmluZF9nZXRfcGFnZXMgc2VlbXMgdG8gcmV0dXJuIGEg
bWF4aW11bSBvZiAyNTYKKyAqIHBhZ2VzIGluIGEgc2luZ2xlIGNhbGwuIFdpdGggUEFHRV9TSVpF
ID09IDRrLCB0aGlzIG1lYW5zIHdlIGNhbgorICogZmlsbCBhIHNpbmdsZSB3c2l6ZSByZXF1ZXN0
IHdpdGggYSBzaW5nbGUgY2FsbC4KKyAqLworI2RlZmluZSBTTUIzX0RFRkFVTFRfSU9TSVpFICg0
ICogMTAyNCAqIDEwMjQpCisKIC8qCiAgKiBTTUIyIEhlYWRlciBEZWZpbml0aW9uCiAgKgpAQCAt
ODgsNiArMTIyLDE1IEBACiAjZGVmaW5lIFNNQjJfRkxBR1NfREZTX09QRVJBVElPTlMJY3B1X3Rv
X2xlMzIoMHgxMDAwMDAwMCkKICNkZWZpbmUgU01CMl9GTEFHU19SRVBMQVlfT1BFUkFUSU9OCWNw
dV90b19sZTMyKDB4MjAwMDAwMDApIC8qIFNNQjMgJiB1cCAqLwogCisvKgorICoJRGVmaW5pdGlv
bnMgZm9yIFNNQjIgUHJvdG9jb2wgRGF0YSBVbml0cyAobmV0d29yayBmcmFtZXMpCisgKgorICog
IFNlZSBNUy1TTUIyLlBERiBzcGVjaWZpY2F0aW9uIGZvciBwcm90b2NvbCBkZXRhaWxzLgorICog
IFRoZSBOYW1pbmcgY29udmVudGlvbiBpcyB0aGUgbG93ZXIgY2FzZSB2ZXJzaW9uIG9mIHRoZSBT
TUIyCisgKiAgY29tbWFuZCBjb2RlIG5hbWUgZm9yIHRoZSBzdHJ1Y3QuIE5vdGUgdGhhdCBzdHJ1
Y3R1cmVzIG11c3QgYmUgcGFja2VkLgorICoKKyAqLworCiAvKiBTZWUgTVMtU01CMiBzZWN0aW9u
IDIuMi4xICovCiBzdHJ1Y3Qgc21iMl9oZHIgewogCV9fbGUzMiBQcm90b2NvbElkOwkvKiAweEZF
ICdTJyAnTScgJ0InICovCkBAIC05OTcsNiArMTA0MCwxMyBAQCBzdHJ1Y3Qgc21iMl9jcmVhdGVf
cnNwIHsKIAlfX3U4ICAgQnVmZmVyWzFdOwogfSBfX3BhY2tlZDsKIAorc3RydWN0IGNyZWF0ZV9w
b3NpeCB7CisJc3RydWN0IGNyZWF0ZV9jb250ZXh0IGNjb250ZXh0OworCV9fdTggICAgTmFtZVsx
Nl07CisJX19sZTMyICBNb2RlOworCV9fdTMyICAgUmVzZXJ2ZWQ7Cit9IF9fcGFja2VkOworCiAj
ZGVmaW5lIFNNQjJfTEVBU0VfTk9ORV9MRQkJCWNwdV90b19sZTMyKDB4MDApCiAjZGVmaW5lIFNN
QjJfTEVBU0VfUkVBRF9DQUNISU5HX0xFCQljcHVfdG9fbGUzMigweDAxKQogI2RlZmluZSBTTUIy
X0xFQVNFX0hBTkRMRV9DQUNISU5HX0xFCQljcHVfdG9fbGUzMigweDAyKQpAQCAtMTAzNiw2ICsx
MDg2LDQyIEBAIHN0cnVjdCBjcmVhdGVfbGVhc2VfdjIgewogCV9fdTggICBQYWRbNF07CiB9IF9f
cGFja2VkOwogCisvKiBTZWUgTVMtU01CMiAyLjIuMzEgYW5kIDIuMi4zMiAqLworc3RydWN0IHNt
YjJfaW9jdGxfcmVxIHsKKwlzdHJ1Y3Qgc21iMl9oZHIgaGRyOworCV9fbGUxNiBTdHJ1Y3R1cmVT
aXplOyAvKiBNdXN0IGJlIDU3ICovCisJX19sZTE2IFJlc2VydmVkOyAvKiBvZmZzZXQgZnJvbSBz
dGFydCBvZiBTTUIyIGhlYWRlciB0byB3cml0ZSBkYXRhICovCisJX19sZTMyIEN0bENvZGU7CisJ
X191NjQgIFBlcnNpc3RlbnRGaWxlSWQ7CisJX191NjQgIFZvbGF0aWxlRmlsZUlkOworCV9fbGUz
MiBJbnB1dE9mZnNldDsgLyogUmVzZXJ2ZWQgTUJaICovCisJX19sZTMyIElucHV0Q291bnQ7CisJ
X19sZTMyIE1heElucHV0UmVzcG9uc2U7CisJX19sZTMyIE91dHB1dE9mZnNldDsKKwlfX2xlMzIg
T3V0cHV0Q291bnQ7CisJX19sZTMyIE1heE91dHB1dFJlc3BvbnNlOworCV9fbGUzMiBGbGFnczsK
KwlfX2xlMzIgUmVzZXJ2ZWQyOworCV9fdTggICBCdWZmZXJbXTsKK30gX19wYWNrZWQ7CisKK3N0
cnVjdCBzbWIyX2lvY3RsX3JzcCB7CisJc3RydWN0IHNtYjJfaGRyIGhkcjsKKwlfX2xlMTYgU3Ry
dWN0dXJlU2l6ZTsgLyogTXVzdCBiZSA0OSAqLworCV9fbGUxNiBSZXNlcnZlZDsKKwlfX2xlMzIg
Q3RsQ29kZTsKKwlfX3U2NCAgUGVyc2lzdGVudEZpbGVJZDsKKwlfX3U2NCAgVm9sYXRpbGVGaWxl
SWQ7CisJX19sZTMyIElucHV0T2Zmc2V0OyAvKiBSZXNlcnZlZCBNQlogKi8KKwlfX2xlMzIgSW5w
dXRDb3VudDsKKwlfX2xlMzIgT3V0cHV0T2Zmc2V0OworCV9fbGUzMiBPdXRwdXRDb3VudDsKKwlf
X2xlMzIgRmxhZ3M7CisJX19sZTMyIFJlc2VydmVkMjsKKwlfX3U4ICAgQnVmZmVyWzBdOworfSBf
X3BhY2tlZDsKKworCiAvKiBQb3NzaWJsZSBJbmZvVHlwZSB2YWx1ZXMgKi8KICNkZWZpbmUgU01C
Ml9PX0lORk9fRklMRQkweDAxCiAjZGVmaW5lIFNNQjJfT19JTkZPX0ZJTEVTWVNURU0JMHgwMgot
LSAKMi4zMi4wCgo=
--000000000000d6b3bb05db22c815--
