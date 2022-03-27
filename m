Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831954E8A2A
	for <lists+linux-cifs@lfdr.de>; Sun, 27 Mar 2022 23:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbiC0VQE (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 27 Mar 2022 17:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229878AbiC0VQE (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 27 Mar 2022 17:16:04 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00AF7FD39
        for <linux-cifs@vger.kernel.org>; Sun, 27 Mar 2022 14:14:23 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id h7so21659254lfl.2
        for <linux-cifs@vger.kernel.org>; Sun, 27 Mar 2022 14:14:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=KUa5DYOJ4T6jluRjP1Nt1GL+UeXKM7tjDkylxBT9uoc=;
        b=NTQ002mkXUy7GXRDWYEa2ZRqr+gw2j/QkDI1AXhX3yX1+6E6lZqt6El/IHKH5KtcSD
         hV19dBnTLdW+F8c3aFPY3F1/9p8cFRz/0jJMyVIKp290MQ9fMKhrV6CGpTtRCai6jGOv
         SmUj8X6AIHyXJbIROL1zktsGSc9YuISLC371JXWK2fUj97boRyLVhFVJ9l2oUVjy9H8C
         ZttFrVGbFVZSelADZif9xBLT1F6scWWg+Hqu752yzTYvTetqhMxpW7vOpUqUwoNJ13hr
         g8e+EI27fDpIlgaEdY18tRjbNZ52JP4gg8Qa5ARPZjpgyEqVWqSIW/B9oiDTjlktGq/n
         KccA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=KUa5DYOJ4T6jluRjP1Nt1GL+UeXKM7tjDkylxBT9uoc=;
        b=3u0Rl/pc/981h7FqUolI3ylEg8FUTKWoFuRTx9HMIRk3rH45VdZeSg7fARs6BRFE9T
         gYhFcfrYfzl94dhJSoQA8p57kKeDZGqLGblOaSFBIly1UMXpb26QQiCMRdVN0yEUKTLC
         kyYVz4irZBTFdEgWNiHqM6I0aHSENRmx/98JPi+KLhIK/wlgd8dLYnjB7tipQkWRnjwt
         6i3T9tojDCLoZJyjSg2pCcSIU22xEX2BWKfm2dkEiYdh7Rinul5RvGEP9J6/fWQhaWM0
         DfMg2F5we8WnJjmR9TM4jVpUBLZ0JJOZ4AJgAVzQWNZfhZX4g7t4X8yzo2NvU9cRACtZ
         ozlQ==
X-Gm-Message-State: AOAM532HRLugCWTiUR/6/PlPNe8jD62ZuSbUsLu99OjJXRyXW9D0Ldag
        5HtVp2SSw2r/dYWrs4rWOhewrXN9rPpV+FtjrwRRfCV8PS8=
X-Google-Smtp-Source: ABdhPJybe7gu0JGfSAw3kzxjUK/DdVAAWjn1c8y3B2fnKFcbA5HKPvNhvKymApP+w36LWUYB6RtC4japc7rTDQFE0i4=
X-Received: by 2002:ac2:5444:0:b0:44a:846e:ad2b with SMTP id
 d4-20020ac25444000000b0044a846ead2bmr7138050lfn.545.1648415662027; Sun, 27
 Mar 2022 14:14:22 -0700 (PDT)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 27 Mar 2022 16:14:11 -0500
Message-ID: <CAH2r5msLJ166+yuHWQnV7_10_SZ3R1RmMwgLyGMBbggcYks1hQ@mail.gmail.com>
Subject: [PATCH][CIFS] cleanup and clarify status of tree connections
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     Shyam Prasad N <nspmangalore@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000fa560b05db39adb3"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--000000000000fa560b05db39adb3
Content-Type: text/plain; charset="UTF-8"

Currently the way the tid (tree connection) status is tracked
is confusing.  The same enum is used for structs cifs_tcon
and cifs_ses and TCP_Server_info, but each of these three has
different states that they transition among.  The current
code also unnecessarily uses camelCase.

Convert from use of statusEnum to a new tid_status_enum for
tree connections.  The valid states for a tid are:

            TID_NEW = 0,
            TID_GOOD,
            TID_EXITING,
            TID_NEED_RECON,
            TID_NEED_TCON,
            TID_IN_TCON,
            TID_NEED_FILES_INVALIDATE, /* unused, considering removing
in future */
            TID_IN_FILES_INVALIDATE

It also removes CifsNeedTcon CifsInTcon CifsNeedFilesInvalidate and
CifsInFilesInvalidate from the statusEnum used for session and
TCP_Server_Info since they are not relevant for those.

A follow on patch will fix the places where we use the
tcon->need_reconnect flag to be more consistent with the tid->status

See attached.

Also FYI - Shyam had a work in progress patch to fix and clarify the
ses->status enum

-- 
Thanks,

Steve

--000000000000fa560b05db39adb3
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb3-cleanup-and-clarify-status-of-tree-connections.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-cleanup-and-clarify-status-of-tree-connections.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_l19s46mx0>
X-Attachment-Id: f_l19s46mx0

RnJvbSA3ZTVjOGMwMjkxMWJhOGQ3ZTYxZDRmYmQxMzAyMTUzMTgzNDNjZjYwIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFN1biwgMjcgTWFyIDIwMjIgMTY6MDc6MzAgLTA1MDAKU3ViamVjdDogW1BBVENIXSBz
bWIzOiBjbGVhbnVwIGFuZCBjbGFyaWZ5IHN0YXR1cyBvZiB0cmVlIGNvbm5lY3Rpb25zCgpDdXJy
ZW50bHkgdGhlIHdheSB0aGUgdGlkICh0cmVlIGNvbm5lY3Rpb24pIHN0YXR1cyBpcyB0cmFja2Vk
CmlzIGNvbmZ1c2luZy4gIFRoZSBzYW1lIGVudW0gaXMgdXNlZCBmb3Igc3RydWN0cyBjaWZzX3Rj
b24KYW5kIGNpZnNfc2VzIGFuZCBUQ1BfU2VydmVyX2luZm8sIGJ1dCBlYWNoIG9mIHRoZXNlIHRo
cmVlIGhhcwpkaWZmZXJlbnQgc3RhdGVzIHRoYXQgdGhleSB0cmFuc2l0aW9uIGFtb25nLiAgVGhl
IGN1cnJlbnQKY29kZSBhbHNvIHVubmVjZXNzYXJpbHkgdXNlcyBjYW1lbENhc2UuCgpDb252ZXJ0
IGZyb20gdXNlIG9mIHN0YXR1c0VudW0gdG8gYSBuZXcgdGlkX3N0YXR1c19lbnVtIGZvcgp0cmVl
IGNvbm5lY3Rpb25zLiAgVGhlIHZhbGlkIHN0YXRlcyBmb3IgYSB0aWQgYXJlOgoKICAgICAgICBU
SURfTkVXID0gMCwKICAgICAgICBUSURfR09PRCwKICAgICAgICBUSURfRVhJVElORywKICAgICAg
ICBUSURfTkVFRF9SRUNPTiwKICAgICAgICBUSURfTkVFRF9UQ09OLAogICAgICAgIFRJRF9JTl9U
Q09OLAogICAgICAgIFRJRF9ORUVEX0ZJTEVTX0lOVkFMSURBVEUsIC8qIHVudXNlZCwgY29uc2lk
ZXJpbmcgcmVtb3ZpbmcgaW4gZnV0dXJlICovCiAgICAgICAgVElEX0lOX0ZJTEVTX0lOVkFMSURB
VEUKCkl0IGFsc28gcmVtb3ZlcyBDaWZzTmVlZFRjb24sIENpZnNJblRjb24sIENpZnNOZWVkRmls
ZXNJbnZhbGlkYXRlIGFuZApDaWZzSW5GaWxlc0ludmFsaWRhdGUgZnJvbSB0aGUgc3RhdHVzRW51
bSB1c2VkIGZvciBzZXNzaW9uIGFuZApUQ1BfU2VydmVyX0luZm8gc2luY2UgdGhleSBhcmUgbm90
IHJlbGV2YW50IGZvciB0aG9zZS4KCkEgZm9sbG93IG9uIHBhdGNoIHdpbGwgZml4IHRoZSBwbGFj
ZXMgd2hlcmUgd2UgdXNlIHRoZQp0Y29uLT5uZWVkX3JlY29ubmVjdCBmbGFnIHRvIGJlIG1vcmUg
Y29uc2lzdGVudCB3aXRoIHRoZSB0aWQtPnN0YXR1cy4KClNpZ25lZC1vZmYtYnk6IFN0ZXZlIEZy
ZW5jaCA8c3RmcmVuY2hAbWljcm9zb2Z0LmNvbT4KLS0tCiBmcy9jaWZzL2NpZnNfZGVidWcuYyB8
ICAyICstCiBmcy9jaWZzL2NpZnNmcy5jICAgICB8ICA0ICsrLS0KIGZzL2NpZnMvY2lmc2dsb2Iu
aCAgIHwgMTggKysrKysrKysrKysrKy0tLS0tCiBmcy9jaWZzL2NpZnNzbWIuYyAgICB8IDExICsr
KysrLS0tLS0tCiBmcy9jaWZzL2Nvbm5lY3QuYyAgICB8IDMyICsrKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tCiBmcy9jaWZzL21pc2MuYyAgICAgICB8ICAyICstCiBmcy9jaWZzL3NtYjJw
ZHUuYyAgICB8ICA0ICsrLS0KIDcgZmlsZXMgY2hhbmdlZCwgNDAgaW5zZXJ0aW9ucygrKSwgMzMg
ZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzX2RlYnVnLmMgYi9mcy9jaWZz
L2NpZnNfZGVidWcuYwppbmRleCBlYTAwZTFhOTEyNTAuLjlkMzM0ODE2ZWFjMCAxMDA2NDQKLS0t
IGEvZnMvY2lmcy9jaWZzX2RlYnVnLmMKKysrIGIvZnMvY2lmcy9jaWZzX2RlYnVnLmMKQEAgLTk0
LDcgKzk0LDcgQEAgc3RhdGljIHZvaWQgY2lmc19kZWJ1Z190Y29uKHN0cnVjdCBzZXFfZmlsZSAq
bSwgc3RydWN0IGNpZnNfdGNvbiAqdGNvbikKIAkJICAgbGUzMl90b19jcHUodGNvbi0+ZnNEZXZJ
bmZvLkRldmljZUNoYXJhY3RlcmlzdGljcyksCiAJCSAgIGxlMzJfdG9fY3B1KHRjb24tPmZzQXR0
ckluZm8uQXR0cmlidXRlcyksCiAJCSAgIGxlMzJfdG9fY3B1KHRjb24tPmZzQXR0ckluZm8uTWF4
UGF0aE5hbWVDb21wb25lbnRMZW5ndGgpLAotCQkgICB0Y29uLT50aWRTdGF0dXMpOworCQkgICB0
Y29uLT5zdGF0dXMpOwogCWlmIChkZXZfdHlwZSA9PSBGSUxFX0RFVklDRV9ESVNLKQogCQlzZXFf
cHV0cyhtLCAiIHR5cGU6IERJU0sgIik7CiAJZWxzZSBpZiAoZGV2X3R5cGUgPT0gRklMRV9ERVZJ
Q0VfQ0RfUk9NKQpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzZnMuYyBiL2ZzL2NpZnMvY2lmc2Zz
LmMKaW5kZXggNmU1MjQ2MTIyZWUyLi45NjllYzIzMDg3NzUgMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMv
Y2lmc2ZzLmMKKysrIGIvZnMvY2lmcy9jaWZzZnMuYwpAQCAtNjk5LDE0ICs2OTksMTQgQEAgc3Rh
dGljIHZvaWQgY2lmc191bW91bnRfYmVnaW4oc3RydWN0IHN1cGVyX2Jsb2NrICpzYikKIAl0Y29u
ID0gY2lmc19zYl9tYXN0ZXJfdGNvbihjaWZzX3NiKTsKIAogCXNwaW5fbG9jaygmY2lmc190Y3Bf
c2VzX2xvY2spOwotCWlmICgodGNvbi0+dGNfY291bnQgPiAxKSB8fCAodGNvbi0+dGlkU3RhdHVz
ID09IENpZnNFeGl0aW5nKSkgeworCWlmICgodGNvbi0+dGNfY291bnQgPiAxKSB8fCAodGNvbi0+
c3RhdHVzID09IFRJRF9FWElUSU5HKSkgewogCQkvKiB3ZSBoYXZlIG90aGVyIG1vdW50cyB0byBz
YW1lIHNoYXJlIG9yIHdlIGhhdmUKIAkJICAgYWxyZWFkeSB0cmllZCB0byBmb3JjZSB1bW91bnQg
dGhpcyBhbmQgd29rZW4gdXAKIAkJICAgYWxsIHdhaXRpbmcgbmV0d29yayByZXF1ZXN0cywgbm90
aGluZyB0byBkbyAqLwogCQlzcGluX3VubG9jaygmY2lmc190Y3Bfc2VzX2xvY2spOwogCQlyZXR1
cm47CiAJfSBlbHNlIGlmICh0Y29uLT50Y19jb3VudCA9PSAxKQotCQl0Y29uLT50aWRTdGF0dXMg
PSBDaWZzRXhpdGluZzsKKwkJdGNvbi0+c3RhdHVzID0gQ2lmc0V4aXRpbmc7CiAJc3Bpbl91bmxv
Y2soJmNpZnNfdGNwX3Nlc19sb2NrKTsKIAogCS8qIGNhbmNlbF9icmxfcmVxdWVzdHModGNvbik7
ICovIC8qIEJCIG1hcmsgYWxsIGJybCBtaWRzIGFzIGV4aXRpbmcgKi8KZGlmZiAtLWdpdCBhL2Zz
L2NpZnMvY2lmc2dsb2IuaCBiL2ZzL2NpZnMvY2lmc2dsb2IuaAppbmRleCBhZDNjZDYwNTNmNGUu
LmNkOTEyNzUxMGE1NSAxMDA2NDQKLS0tIGEvZnMvY2lmcy9jaWZzZ2xvYi5oCisrKyBiL2ZzL2Np
ZnMvY2lmc2dsb2IuaApAQCAtMTE1LDEwICsxMTUsMTggQEAgZW51bSBzdGF0dXNFbnVtIHsKIAlD
aWZzSW5OZWdvdGlhdGUsCiAJQ2lmc05lZWRTZXNzU2V0dXAsCiAJQ2lmc0luU2Vzc1NldHVwLAot
CUNpZnNOZWVkVGNvbiwKLQlDaWZzSW5UY29uLAotCUNpZnNOZWVkRmlsZXNJbnZhbGlkYXRlLAot
CUNpZnNJbkZpbGVzSW52YWxpZGF0ZQorfTsKKworLyogYXNzb2NpYXRlZCB3aXRoIGVhY2ggdHJl
ZSBjb25uZWN0aW9uIHRvIHRoZSBzZXJ2ZXIgKi8KK2VudW0gdGlkX3N0YXR1c19lbnVtIHsKKwlU
SURfTkVXID0gMCwKKwlUSURfR09PRCwKKwlUSURfRVhJVElORywKKwlUSURfTkVFRF9SRUNPTiwK
KwlUSURfTkVFRF9UQ09OLAorCVRJRF9JTl9UQ09OLAorCVRJRF9ORUVEX0ZJTEVTX0lOVkFMSURB
VEUsIC8qIGN1cnJlbnRseSB1bnVzZWQgKi8KKwlUSURfSU5fRklMRVNfSU5WQUxJREFURQogfTsK
IAogZW51bSBzZWN1cml0eUVudW0gewpAQCAtMTAzMiw3ICsxMDQwLDcgQEAgc3RydWN0IGNpZnNf
dGNvbiB7CiAJY2hhciAqcGFzc3dvcmQ7CQkvKiBmb3Igc2hhcmUtbGV2ZWwgc2VjdXJpdHkgKi8K
IAlfX3UzMiB0aWQ7CQkvKiBUaGUgNCBieXRlIHRyZWUgaWQgKi8KIAlfX3UxNiBGbGFnczsJCS8q
IG9wdGlvbmFsIHN1cHBvcnQgYml0cyAqLwotCWVudW0gc3RhdHVzRW51bSB0aWRTdGF0dXM7CisJ
ZW51bSB0aWRfc3RhdHVzX2VudW0gc3RhdHVzOwogCWF0b21pY190IG51bV9zbWJzX3NlbnQ7CiAJ
dW5pb24gewogCQlzdHJ1Y3QgewpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzc21iLmMgYi9mcy9j
aWZzL2NpZnNzbWIuYwppbmRleCAwNzFlMmYyMWE3ZGIuLmFjYTkzMzhiMDg3NyAxMDA2NDQKLS0t
IGEvZnMvY2lmcy9jaWZzc21iLmMKKysrIGIvZnMvY2lmcy9jaWZzc21iLmMKQEAgLTc1LDEyICs3
NSwxMSBAQCBjaWZzX21hcmtfb3Blbl9maWxlc19pbnZhbGlkKHN0cnVjdCBjaWZzX3Rjb24gKnRj
b24pCiAKIAkvKiBvbmx5IHNlbmQgb25jZSBwZXIgY29ubmVjdCAqLwogCXNwaW5fbG9jaygmY2lm
c190Y3Bfc2VzX2xvY2spOwotCWlmICh0Y29uLT5zZXMtPnN0YXR1cyAhPSBDaWZzR29vZCB8fAot
CSAgICB0Y29uLT50aWRTdGF0dXMgIT0gQ2lmc05lZWRSZWNvbm5lY3QpIHsKKwlpZiAoKHRjb24t
PnNlcy0+c3RhdHVzICE9IENpZnNHb29kKSB8fCAodGNvbi0+c3RhdHVzICE9IFRJRF9ORUVEX1JF
Q09OKSkgewogCQlzcGluX3VubG9jaygmY2lmc190Y3Bfc2VzX2xvY2spOwogCQlyZXR1cm47CiAJ
fQotCXRjb24tPnRpZFN0YXR1cyA9IENpZnNJbkZpbGVzSW52YWxpZGF0ZTsKKwl0Y29uLT5zdGF0
dXMgPSBUSURfSU5fRklMRVNfSU5WQUxJREFURTsKIAlzcGluX3VubG9jaygmY2lmc190Y3Bfc2Vz
X2xvY2spOwogCiAJLyogbGlzdCBhbGwgZmlsZXMgb3BlbiBvbiB0cmVlIGNvbm5lY3Rpb24gYW5k
IG1hcmsgdGhlbSBpbnZhbGlkICovCkBAIC0xMDAsOCArOTksOCBAQCBjaWZzX21hcmtfb3Blbl9m
aWxlc19pbnZhbGlkKHN0cnVjdCBjaWZzX3Rjb24gKnRjb24pCiAJbXV0ZXhfdW5sb2NrKCZ0Y29u
LT5jcmZpZC5maWRfbXV0ZXgpOwogCiAJc3Bpbl9sb2NrKCZjaWZzX3RjcF9zZXNfbG9jayk7Ci0J
aWYgKHRjb24tPnRpZFN0YXR1cyA9PSBDaWZzSW5GaWxlc0ludmFsaWRhdGUpCi0JCXRjb24tPnRp
ZFN0YXR1cyA9IENpZnNOZWVkVGNvbjsKKwlpZiAodGNvbi0+c3RhdHVzID09IFRJRF9JTl9GSUxF
U19JTlZBTElEQVRFKQorCQl0Y29uLT5zdGF0dXMgPSBUSURfTkVFRF9UQ09OOwogCXNwaW5fdW5s
b2NrKCZjaWZzX3RjcF9zZXNfbG9jayk7CiAKIAkvKgpAQCAtMTM2LDcgKzEzNSw3IEBAIGNpZnNf
cmVjb25uZWN0X3Rjb24oc3RydWN0IGNpZnNfdGNvbiAqdGNvbiwgaW50IHNtYl9jb21tYW5kKQog
CSAqIGhhdmUgdGNvbikgYXJlIGFsbG93ZWQgYXMgd2Ugc3RhcnQgZm9yY2UgdW1vdW50CiAJICov
CiAJc3Bpbl9sb2NrKCZjaWZzX3RjcF9zZXNfbG9jayk7Ci0JaWYgKHRjb24tPnRpZFN0YXR1cyA9
PSBDaWZzRXhpdGluZykgeworCWlmICh0Y29uLT5zdGF0dXMgPT0gVElEX0VYSVRJTkcpIHsKIAkJ
aWYgKHNtYl9jb21tYW5kICE9IFNNQl9DT01fV1JJVEVfQU5EWCAmJgogCQkgICAgc21iX2NvbW1h
bmQgIT0gU01CX0NPTV9PUEVOX0FORFggJiYKIAkJICAgIHNtYl9jb21tYW5kICE9IFNNQl9DT01f
VFJFRV9ESVNDT05ORUNUKSB7CmRpZmYgLS1naXQgYS9mcy9jaWZzL2Nvbm5lY3QuYyBiL2ZzL2Np
ZnMvY29ubmVjdC5jCmluZGV4IGQ2ZjhjY2M3YmZlMi4uZWUzYjdjMTVlODg0IDEwMDY0NAotLS0g
YS9mcy9jaWZzL2Nvbm5lY3QuYworKysgYi9mcy9jaWZzL2Nvbm5lY3QuYwpAQCAtMjQ1LDcgKzI0
NSw3IEBAIGNpZnNfbWFya190Y3Bfc2VzX2Nvbm5zX2Zvcl9yZWNvbm5lY3Qoc3RydWN0IFRDUF9T
ZXJ2ZXJfSW5mbyAqc2VydmVyLAogCiAJCWxpc3RfZm9yX2VhY2hfZW50cnkodGNvbiwgJnNlcy0+
dGNvbl9saXN0LCB0Y29uX2xpc3QpIHsKIAkJCXRjb24tPm5lZWRfcmVjb25uZWN0ID0gdHJ1ZTsK
LQkJCXRjb24tPnRpZFN0YXR1cyA9IENpZnNOZWVkUmVjb25uZWN0OworCQkJdGNvbi0+c3RhdHVz
ID0gVElEX05FRURfUkVDT047CiAJCX0KIAkJaWYgKHNlcy0+dGNvbl9pcGMpCiAJCQlzZXMtPnRj
b25faXBjLT5uZWVkX3JlY29ubmVjdCA9IHRydWU7CkBAIC0yMjA3LDcgKzIyMDcsNyBAQCBjaWZz
X2dldF9zbWJfc2VzKHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNlcnZlciwgc3RydWN0IHNtYjNf
ZnNfY29udGV4dCAqY3R4KQogCiBzdGF0aWMgaW50IG1hdGNoX3Rjb24oc3RydWN0IGNpZnNfdGNv
biAqdGNvbiwgc3RydWN0IHNtYjNfZnNfY29udGV4dCAqY3R4KQogewotCWlmICh0Y29uLT50aWRT
dGF0dXMgPT0gQ2lmc0V4aXRpbmcpCisJaWYgKHRjb24tPnN0YXR1cyA9PSBUSURfRVhJVElORykK
IAkJcmV0dXJuIDA7CiAJaWYgKHN0cm5jbXAodGNvbi0+dHJlZU5hbWUsIGN0eC0+VU5DLCBNQVhf
VFJFRV9TSVpFKSkKIAkJcmV0dXJuIDA7CkBAIC00NDg2LDEyICs0NDg2LDEyIEBAIGludCBjaWZz
X3RyZWVfY29ubmVjdChjb25zdCB1bnNpZ25lZCBpbnQgeGlkLCBzdHJ1Y3QgY2lmc190Y29uICp0
Y29uLCBjb25zdCBzdHJ1CiAJLyogb25seSBzZW5kIG9uY2UgcGVyIGNvbm5lY3QgKi8KIAlzcGlu
X2xvY2soJmNpZnNfdGNwX3Nlc19sb2NrKTsKIAlpZiAodGNvbi0+c2VzLT5zdGF0dXMgIT0gQ2lm
c0dvb2QgfHwKLQkgICAgKHRjb24tPnRpZFN0YXR1cyAhPSBDaWZzTmV3ICYmCi0JICAgIHRjb24t
PnRpZFN0YXR1cyAhPSBDaWZzTmVlZFRjb24pKSB7CisJICAgICh0Y29uLT5zdGF0dXMgIT0gVElE
X05FVyAmJgorCSAgICB0Y29uLT5zdGF0dXMgIT0gVElEX05FRURfVENPTikpIHsKIAkJc3Bpbl91
bmxvY2soJmNpZnNfdGNwX3Nlc19sb2NrKTsKIAkJcmV0dXJuIDA7CiAJfQotCXRjb24tPnRpZFN0
YXR1cyA9IENpZnNJblRjb247CisJdGNvbi0+c3RhdHVzID0gVElEX0lOX1RDT047CiAJc3Bpbl91
bmxvY2soJmNpZnNfdGNwX3Nlc19sb2NrKTsKIAogCXRyZWUgPSBremFsbG9jKE1BWF9UUkVFX1NJ
WkUsIEdGUF9LRVJORUwpOwpAQCAtNDUzMiwxMyArNDUzMiwxMyBAQCBpbnQgY2lmc190cmVlX2Nv
bm5lY3QoY29uc3QgdW5zaWduZWQgaW50IHhpZCwgc3RydWN0IGNpZnNfdGNvbiAqdGNvbiwgY29u
c3Qgc3RydQogCiAJaWYgKHJjKSB7CiAJCXNwaW5fbG9jaygmY2lmc190Y3Bfc2VzX2xvY2spOwot
CQlpZiAodGNvbi0+dGlkU3RhdHVzID09IENpZnNJblRjb24pCi0JCQl0Y29uLT50aWRTdGF0dXMg
PSBDaWZzTmVlZFRjb247CisJCWlmICh0Y29uLT5zdGF0dXMgPT0gVElEX0lOX1RDT04pCisJCQl0
Y29uLT5zdGF0dXMgPSBUSURfTkVFRF9UQ09OOwogCQlzcGluX3VubG9jaygmY2lmc190Y3Bfc2Vz
X2xvY2spOwogCX0gZWxzZSB7CiAJCXNwaW5fbG9jaygmY2lmc190Y3Bfc2VzX2xvY2spOwotCQlp
ZiAodGNvbi0+dGlkU3RhdHVzID09IENpZnNJblRjb24pCi0JCQl0Y29uLT50aWRTdGF0dXMgPSBD
aWZzR29vZDsKKwkJaWYgKHRjb24tPnN0YXR1cyA9PSBUSURfSU5fVENPTikKKwkJCXRjb24tPnN0
YXR1cyA9IFRJRF9HT09EOwogCQlzcGluX3VubG9jaygmY2lmc190Y3Bfc2VzX2xvY2spOwogCQl0
Y29uLT5uZWVkX3JlY29ubmVjdCA9IGZhbHNlOwogCX0KQEAgLTQ1NTQsMjQgKzQ1NTQsMjQgQEAg
aW50IGNpZnNfdHJlZV9jb25uZWN0KGNvbnN0IHVuc2lnbmVkIGludCB4aWQsIHN0cnVjdCBjaWZz
X3Rjb24gKnRjb24sIGNvbnN0IHN0cnUKIAkvKiBvbmx5IHNlbmQgb25jZSBwZXIgY29ubmVjdCAq
LwogCXNwaW5fbG9jaygmY2lmc190Y3Bfc2VzX2xvY2spOwogCWlmICh0Y29uLT5zZXMtPnN0YXR1
cyAhPSBDaWZzR29vZCB8fAotCSAgICAodGNvbi0+dGlkU3RhdHVzICE9IENpZnNOZXcgJiYKLQkg
ICAgdGNvbi0+dGlkU3RhdHVzICE9IENpZnNOZWVkVGNvbikpIHsKKwkgICAgKHRjb24tPnN0YXR1
cyAhPSBUSURfTkVXICYmCisJICAgIHRjb24tPnN0YXR1cyAhPSBUSURfTkVFRF9UQ09OKSkgewog
CQlzcGluX3VubG9jaygmY2lmc190Y3Bfc2VzX2xvY2spOwogCQlyZXR1cm4gMDsKIAl9Ci0JdGNv
bi0+dGlkU3RhdHVzID0gQ2lmc0luVGNvbjsKKwl0Y29uLT5zdGF0dXMgPSBUSURfSU5fVENPTjsK
IAlzcGluX3VubG9jaygmY2lmc190Y3Bfc2VzX2xvY2spOwogCiAJcmMgPSBvcHMtPnRyZWVfY29u
bmVjdCh4aWQsIHRjb24tPnNlcywgdGNvbi0+dHJlZU5hbWUsIHRjb24sIG5sc2MpOwogCWlmIChy
YykgewogCQlzcGluX2xvY2soJmNpZnNfdGNwX3Nlc19sb2NrKTsKLQkJaWYgKHRjb24tPnRpZFN0
YXR1cyA9PSBDaWZzSW5UY29uKQotCQkJdGNvbi0+dGlkU3RhdHVzID0gQ2lmc05lZWRUY29uOwor
CQlpZiAodGNvbi0+c3RhdHVzID09IFRJRF9JTl9UQ09OKQorCQkJdGNvbi0+c3RhdHVzID0gVElE
X05FRURfVENPTjsKIAkJc3Bpbl91bmxvY2soJmNpZnNfdGNwX3Nlc19sb2NrKTsKIAl9IGVsc2Ug
ewogCQlzcGluX2xvY2soJmNpZnNfdGNwX3Nlc19sb2NrKTsKLQkJaWYgKHRjb24tPnRpZFN0YXR1
cyA9PSBDaWZzSW5UY29uKQotCQkJdGNvbi0+dGlkU3RhdHVzID0gQ2lmc0dvb2Q7CisJCWlmICh0
Y29uLT5zdGF0dXMgPT0gVElEX0lOX1RDT04pCisJCQl0Y29uLT5zdGF0dXMgPSBUSURfR09PRDsK
IAkJc3Bpbl91bmxvY2soJmNpZnNfdGNwX3Nlc19sb2NrKTsKIAkJdGNvbi0+bmVlZF9yZWNvbm5l
Y3QgPSBmYWxzZTsKIAl9CmRpZmYgLS1naXQgYS9mcy9jaWZzL21pc2MuYyBiL2ZzL2NpZnMvbWlz
Yy5jCmluZGV4IDU2NTk4ZjdkYmUwMC4uYWZhZjU5YzIyMTkzIDEwMDY0NAotLS0gYS9mcy9jaWZz
L21pc2MuYworKysgYi9mcy9jaWZzL21pc2MuYwpAQCAtMTE2LDcgKzExNiw3IEBAIHRjb25JbmZv
QWxsb2Modm9pZCkKIAl9CiAKIAlhdG9taWNfaW5jKCZ0Y29uSW5mb0FsbG9jQ291bnQpOwotCXJl
dF9idWYtPnRpZFN0YXR1cyA9IENpZnNOZXc7CisJcmV0X2J1Zi0+c3RhdHVzID0gVElEX05FVzsK
IAkrK3JldF9idWYtPnRjX2NvdW50OwogCUlOSVRfTElTVF9IRUFEKCZyZXRfYnVmLT5vcGVuRmls
ZUxpc3QpOwogCUlOSVRfTElTVF9IRUFEKCZyZXRfYnVmLT50Y29uX2xpc3QpOwpkaWZmIC0tZ2l0
IGEvZnMvY2lmcy9zbWIycGR1LmMgYi9mcy9jaWZzL3NtYjJwZHUuYwppbmRleCA1NGI1NTRjN2Fl
ZTguLjFiN2FkMGMwOTU2NiAxMDA2NDQKLS0tIGEvZnMvY2lmcy9zbWIycGR1LmMKKysrIGIvZnMv
Y2lmcy9zbWIycGR1LmMKQEAgLTE2Myw3ICsxNjMsNyBAQCBzbWIyX3JlY29ubmVjdChfX2xlMTYg
c21iMl9jb21tYW5kLCBzdHJ1Y3QgY2lmc190Y29uICp0Y29uLAogCQlyZXR1cm4gMDsKIAogCXNw
aW5fbG9jaygmY2lmc190Y3Bfc2VzX2xvY2spOwotCWlmICh0Y29uLT50aWRTdGF0dXMgPT0gQ2lm
c0V4aXRpbmcpIHsKKwlpZiAodGNvbi0+c3RhdHVzID09IFRJRF9FWElUSU5HKSB7CiAJCS8qCiAJ
CSAqIG9ubHkgdHJlZSBkaXNjb25uZWN0LCBvcGVuLCBhbmQgd3JpdGUsCiAJCSAqIChhbmQgdWxv
Z29mZiB3aGljaCBkb2VzIG5vdCBoYXZlIHRjb24pCkBAIC0zODYwLDcgKzM4NjAsNyBAQCB2b2lk
IHNtYjJfcmVjb25uZWN0X3NlcnZlcihzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspCiAJCWdvdG8g
ZG9uZTsKIAl9CiAKLQl0Y29uLT50aWRTdGF0dXMgPSBDaWZzR29vZDsKKwl0Y29uLT5zdGF0dXMg
PSBUSURfR09PRDsKIAl0Y29uLT5yZXRyeSA9IGZhbHNlOwogCXRjb24tPm5lZWRfcmVjb25uZWN0
ID0gZmFsc2U7CiAKLS0gCjIuMzIuMAoK
--000000000000fa560b05db39adb3--
