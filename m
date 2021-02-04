Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 57E2E30F2D2
	for <lists+linux-cifs@lfdr.de>; Thu,  4 Feb 2021 13:06:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235666AbhBDMEf (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 4 Feb 2021 07:04:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235578AbhBDMEe (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 4 Feb 2021 07:04:34 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46B7CC061573
        for <linux-cifs@vger.kernel.org>; Thu,  4 Feb 2021 04:03:54 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id c3so2939710ybi.3
        for <linux-cifs@vger.kernel.org>; Thu, 04 Feb 2021 04:03:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9zZtHmriwoZ1lKOFNEfcSkaBGz0dQh6M3mSos6dE12w=;
        b=U2aQIjypNB0vVR7g23IUa8O3V72WznN1Vim0NtYzswlzWPEHd9h3m7Rrfbtw/E1nDh
         /Pzdg4vAb2pSFGyYyLXp5HBYIba1gpVJo04gTS94JiEibwNdhx6loKn1WS+KJihb+Z14
         yh7w3inED/+fRKbMB4HgEB2pqQNYVeBbc4whDSulROOiKq+WDdfED+1i1IvQ+eGAH41x
         3Fa6dq0Za/ID6oKwXMNwQdepcsBxr4RPxxS41J2H0ceBCwBqzgR7+ivUxcsgIFMe8ZUh
         mN1n+EJgmtWkI/ymf827/ayG9J8VqWPDyzfTXQ4FoS7yojSotiIiqUs8lgRl4vT1SoHh
         KcHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9zZtHmriwoZ1lKOFNEfcSkaBGz0dQh6M3mSos6dE12w=;
        b=WarBT0FwBs6SJVWpgYmsfA2wjsdZz829P8ZeWwE/UAGadlRuIA6Uebs6HGE01evN1m
         xnwzMti4AIoB8lJFrS6n9jEaVIm8IrgMs17RFN3v+usoNcbMVX8ghv15J7hxZoeCOgOd
         K7+MPCh3mWxwfPXTdvV0hvy0XLj2Ko/Qvxx1WY45aPryeZq7FrlxZMaXQ+ry0YVWHWvq
         apEvIohzzQRINUkBDuSCiCtwvt5IFkLOrQNxxnh7HX9Ioy24GOZetz8u2663EkG7at+6
         OaHt48XX3loDodUlNHeGX7U5zn4ElLESzB9pco5IaVG9MCCYZpj90qg/5MghRZf1TKSx
         76LA==
X-Gm-Message-State: AOAM530PNKxgGeqxJBq8VrCZ8fJnvZwe5fpHpr5wmSHwqvy/c/oV4XLi
        Pnm+tP2j2Ux5Cluz35EQh/+8dS1L7UGg9TW/S+Q=
X-Google-Smtp-Source: ABdhPJw6o/Tr1auGGwg4QgdhHpgqqy13siKXMmO9C+quDOYnqEPWm9xJ09OVbK1nx1SIlkXG0n8pTo3lIl1dMPNn0jA=
X-Received: by 2002:a25:7706:: with SMTP id s6mr11472027ybc.3.1612440233489;
 Thu, 04 Feb 2021 04:03:53 -0800 (PST)
MIME-Version: 1.0
References: <CANT5p=o9Tw9E+o3PWytsNh5eDKxswJ+YPLZLWac7QwR_u-UJaw@mail.gmail.com>
 <87h7msnnme.fsf@suse.com>
In-Reply-To: <87h7msnnme.fsf@suse.com>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Thu, 4 Feb 2021 04:03:42 -0800
Message-ID: <CANT5p=qGTC4E4Rf_-t9xXOo4yf3W=xtk97J1jg-WRLhwf0juBA@mail.gmail.com>
Subject: Re: [PATCH 4/4] cifs: Reformat DebugData and index connections by conn_id.
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Pavel Shilovsky <piastryyy@gmail.com>
Content-Type: multipart/mixed; boundary="00000000000056e65b05ba817f3b"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--00000000000056e65b05ba817f3b
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Sorry. I thought I had attached. :)

On Thu, Feb 4, 2021 at 2:17 AM Aur=C3=A9lien Aptel <aaptel@suse.com> wrote:
>
>
> -ENOPATCH :)
>
> Cheers,
> --
> Aur=C3=A9lien Aptel / SUSE Labs Samba Team
> GPG: 1839 CB5F 9F5B FB9B AA97  8C99 03C8 A49B 521B D5D3
> SUSE Software Solutions Germany GmbH, Maxfeldstr. 5, 90409 N=C3=BCrnberg,=
 DE
> GF: Felix Imend=C3=B6rffer, Mary Higgins, Sri Rasiah HRB 247165 (AG M=C3=
=BCnchen)
>


--=20
Regards,
Shyam

--00000000000056e65b05ba817f3b
Content-Type: application/octet-stream; 
	name="0004-cifs-Reformat-DebugData-and-index-connections-by-con.patch"
Content-Disposition: attachment; 
	filename="0004-cifs-Reformat-DebugData-and-index-connections-by-con.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kkqt9iv20>
X-Attachment-Id: f_kkqt9iv20

RnJvbSAzYmNkYjI3Nzk0ZDVjNDg2YjhjN2FlODZiZTJkMGQ1ZDhmMzllZmM3IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaHlhbSBQcmFzYWQgTiA8c3ByYXNhZEBtaWNyb3NvZnQuY29t
PgpEYXRlOiBXZWQsIDMgRmViIDIwMjEgMjM6Mjc6NTIgLTA4MDAKU3ViamVjdDogW1BBVENIIDQv
NF0gY2lmczogUmVmb3JtYXQgRGVidWdEYXRhIGFuZCBpbmRleCBjb25uZWN0aW9ucyBieQogY29u
bl9pZC4KClJlZm9ybWF0IHRoZSBvdXRwdXQgb2YgL3Byb2MvZnMvY2lmcy9EZWJ1Z0RhdGEgdG8g
cHJpbnQgdGhlCmNvbm5faWQgZm9yIGVhY2ggY29ubmVjdGlvbi4gQWxzbyByZW9yZGVyZWQgYW5k
IG51bWJlcmVkIHRoZSBkYXRhCmludG8gYSBtb3JlIHJlYWRlci1mcmllbmRseSBmb3JtYXQuCgpU
aGlzIGlzIHdoYXQgdGhlIG5ldyBmb3JtYXQgbG9va3MgbGlrZToKJCBjYXQgL3Byb2MvZnMvY2lm
cy9EZWJ1Z0RhdGEKRGlzcGxheSBJbnRlcm5hbCBDSUZTIERhdGEgU3RydWN0dXJlcyBmb3IgRGVi
dWdnaW5nCi0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQpDSUZTIFZlcnNpb24gMi4zMApGZWF0dXJlczogREZTLEZTQ0FDSEUsU1RBVFMsREVCVUcsQUxM
T1dfSU5TRUNVUkVfTEVHQUNZLFdFQUtfUFdfSEFTSCxDSUZTX1BPU0lYLFVQQ0FMTChTUE5FR08p
LFhBVFRSLEFDTApDSUZTTWF4QnVmU2l6ZTogMTYzODQKQWN0aXZlIFZGUyBSZXF1ZXN0czogMAoK
U2VydmVyczoKMSkgQ29ubmVjdGlvbklkOiAweDEKTnVtYmVyIG9mIGNyZWRpdHM6IDM3MSBEaWFs
ZWN0IDB4MzAwClRDUCBzdGF0dXM6IDEgSW5zdGFuY2U6IDEKTG9jYWwgVXNlcnMgVG8gU2VydmVy
OiAxIFNlY01vZGU6IDB4MSBSZXEgT24gV2lyZTogMCBJbiBTZW5kOiAwIEluIE1heFJlcSBXYWl0
OiAwCgogICAgICAgIFNlc3Npb25zOgogICAgICAgIDEpIE5hbWU6IDEwLjEwLjEwLjEwIFVzZXM6
IDEgQ2FwYWJpbGl0eTogMHgzMDAwNzcgICAgIFNlc3Npb24gU3RhdHVzOiAxCiAgICAgICAgU2Vj
dXJpdHkgdHlwZTogUmF3TlRMTVNTUCAgU2Vzc2lvbklkOiAweDc4NTU2MDAwMDAxOQogICAgICAg
IFVzZXI6IDEwMDAgQ3JlZCBVc2VyOiAwCgogICAgICAgIFNoYXJlczoKICAgICAgICAwKSBJUEM6
IFxcMTAuMTAuMTAuMTBcSVBDJCBNb3VudHM6IDEgRGV2SW5mbzogMHgwIEF0dHJpYnV0ZXM6IDB4
MAogICAgICAgIFBhdGhDb21wb25lbnRNYXg6IDAgU3RhdHVzOiAxIHR5cGU6IDAgU2VyaWFsIE51
bWJlcjogMHgwCiAgICAgICAgU2hhcmUgQ2FwYWJpbGl0aWVzOiBOb25lICAgICAgICBTaGFyZSBG
bGFnczogMHgzMAogICAgICAgIHRpZDogMHgxICAgICAgICBNYXhpbWFsIEFjY2VzczogMHgxMWYw
MWZmCgogICAgICAgIDEpIFxcMTAuMTAuMTAuMTBcc2h5YW1fdGVzdDIgTW91bnRzOiAxIERldklu
Zm86IDB4MjAwMjAgQXR0cmlidXRlczogMHhjNzA2ZmYKICAgICAgICBQYXRoQ29tcG9uZW50TWF4
OiAyNTUgU3RhdHVzOiAxIHR5cGU6IERJU0sgU2VyaWFsIE51bWJlcjogMHhkNDcyMzk3NQogICAg
ICAgIFNoYXJlIENhcGFiaWxpdGllczogTm9uZSBBbGlnbmVkLCBQYXJ0aXRpb24gQWxpZ25lZCwg
ICAgU2hhcmUgRmxhZ3M6IDB4MAogICAgICAgIHRpZDogMHg1ICAgICAgICBPcHRpbWFsIHNlY3Rv
ciBzaXplOiAweDEwMDAgICAgIE1heGltYWwgQWNjZXNzOiAweDFmMDFmZgoKICAgICAgICBNSURz
OgoKICAgICAgICBTZXJ2ZXIgaW50ZXJmYWNlczogMwogICAgICAgIDEpICAgICAgU3BlZWQ6IDEw
MDAwMDAwMDAwIGJwcwogICAgICAgICAgICAgICAgQ2FwYWJpbGl0aWVzOiByc3MKICAgICAgICAg
ICAgICAgIElQdjQ6IDEwLjEwLjEwLjEKCiAgICAgICAgMikgICAgICBTcGVlZDogMTAwMDAwMDAw
MDAgYnBzCiAgICAgICAgICAgICAgICBDYXBhYmlsaXRpZXM6IHJzcwogICAgICAgICAgICAgICAg
SVB2NjogZmU4MDowMDAwOjAwMDA6MDAwMDoxOGI0OjAwMDA6MDAwMDowMDAwCgogICAgICAgIDMp
ICAgICAgU3BlZWQ6IDEwMDAwMDAwMDAgYnBzCiAgICAgICAgICAgICAgICBDYXBhYmlsaXRpZXM6
IHJzcwogICAgICAgICAgICAgICAgSVB2NDogMTAuMTAuMTAuMTAKICAgICAgICAgICAgICAgIFtD
T05ORUNURURdCgpTaWduZWQtb2ZmLWJ5OiBTaHlhbSBQcmFzYWQgTiA8c3ByYXNhZEBtaWNyb3Nv
ZnQuY29tPgotLS0KIGZzL2NpZnMvY2lmc19kZWJ1Zy5jIHwgNzAgKysrKysrKysrKysrKysrKysr
KysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCAzOSBpbnNlcnRpb25z
KCspLCAzMSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9jaWZzL2NpZnNfZGVidWcuYyBi
L2ZzL2NpZnMvY2lmc19kZWJ1Zy5jCmluZGV4IGIyMzFkY2YxZDFmOS4uMmFiYjQ5NDM0NGRiIDEw
MDY0NAotLS0gYS9mcy9jaWZzL2NpZnNfZGVidWcuYworKysgYi9mcy9jaWZzL2NpZnNfZGVidWcu
YwpAQCAtMjI3LDcgKzIyNyw3IEBAIHN0YXRpYyBpbnQgY2lmc19kZWJ1Z19kYXRhX3Byb2Nfc2hv
dyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYpCiAJc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAq
c2VydmVyOwogCXN0cnVjdCBjaWZzX3NlcyAqc2VzOwogCXN0cnVjdCBjaWZzX3Rjb24gKnRjb247
Ci0JaW50IGksIGo7CisJaW50IGMsIGksIGo7CiAKIAlzZXFfcHV0cyhtLAogCQkgICAgIkRpc3Bs
YXkgSW50ZXJuYWwgQ0lGUyBEYXRhIFN0cnVjdHVyZXMgZm9yIERlYnVnZ2luZ1xuIgpAQCAtMjc1
LDE0ICsyNzUsMTkgQEAgc3RhdGljIGludCBjaWZzX2RlYnVnX2RhdGFfcHJvY19zaG93KHN0cnVj
dCBzZXFfZmlsZSAqbSwgdm9pZCAqdikKIAlzZXFfcHV0YyhtLCAnXG4nKTsKIAlzZXFfcHJpbnRm
KG0sICJDSUZTTWF4QnVmU2l6ZTogJWRcbiIsIENJRlNNYXhCdWZTaXplKTsKIAlzZXFfcHJpbnRm
KG0sICJBY3RpdmUgVkZTIFJlcXVlc3RzOiAlZFxuIiwgR2xvYmFsVG90YWxBY3RpdmVYaWQpOwot
CXNlcV9wcmludGYobSwgIlNlcnZlcnM6Iik7CiAKLQlpID0gMDsKKwlzZXFfcHJpbnRmKG0sICJc
blNlcnZlcnM6ICIpOworCisJYyA9IDA7CiAJc3Bpbl9sb2NrKCZjaWZzX3RjcF9zZXNfbG9jayk7
CiAJbGlzdF9mb3JfZWFjaCh0bXAxLCAmY2lmc190Y3Bfc2VzX2xpc3QpIHsKIAkJc2VydmVyID0g
bGlzdF9lbnRyeSh0bXAxLCBzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvLAogCQkJCSAgICB0Y3Bfc2Vz
X2xpc3QpOwogCisJCWMrKzsKKwkJc2VxX3ByaW50ZihtLCAiXG4lZCkgQ29ubmVjdGlvbklkOiAw
eCVsbHggIiwKKwkJCWMsIHNlcnZlci0+Y29ubl9pZCk7CisKICNpZmRlZiBDT05GSUdfQ0lGU19T
TUJfRElSRUNUCiAJCWlmICghc2VydmVyLT5yZG1hKQogCQkJZ290byBza2lwX3JkbWE7CkBAIC0z
NjIsNDYgKzM2Nyw0OSBAQCBzdGF0aWMgaW50IGNpZnNfZGVidWdfZGF0YV9wcm9jX3Nob3coc3Ry
dWN0IHNlcV9maWxlICptLCB2b2lkICp2KQogCQlpZiAoc2VydmVyLT5wb3NpeF9leHRfc3VwcG9y
dGVkKQogCQkJc2VxX3ByaW50ZihtLCAiIHBvc2l4Iik7CiAKLQkJaSsrOworCQlpZiAoc2VydmVy
LT5yZG1hKQorCQkJc2VxX3ByaW50ZihtLCAiXG5SRE1BICIpOworCQlzZXFfcHJpbnRmKG0sICJc
blRDUCBzdGF0dXM6ICVkIEluc3RhbmNlOiAlZCIKKwkJCQkiXG5Mb2NhbCBVc2VycyBUbyAiCisJ
CQkJIlNlcnZlcjogJWQgU2VjTW9kZTogMHgleCBSZXEgT24gV2lyZTogJWQiLAorCQkJCXNlcnZl
ci0+dGNwU3RhdHVzLAorCQkJCXNlcnZlci0+cmVjb25uZWN0X2luc3RhbmNlLAorCQkJCXNlcnZl
ci0+c3J2X2NvdW50LAorCQkJCXNlcnZlci0+c2VjX21vZGUsIGluX2ZsaWdodChzZXJ2ZXIpKTsK
KworCQlzZXFfcHJpbnRmKG0sICIgSW4gU2VuZDogJWQgSW4gTWF4UmVxIFdhaXQ6ICVkIiwKKwkJ
CQlhdG9taWNfcmVhZCgmc2VydmVyLT5pbl9zZW5kKSwKKwkJCQlhdG9taWNfcmVhZCgmc2VydmVy
LT5udW1fd2FpdGVycykpOworCisJCXNlcV9wcmludGYobSwgIlxuXG5cdFNlc3Npb25zOiAiKTsK
KwkJaSA9IDA7CiAJCWxpc3RfZm9yX2VhY2godG1wMiwgJnNlcnZlci0+c21iX3Nlc19saXN0KSB7
CiAJCQlzZXMgPSBsaXN0X2VudHJ5KHRtcDIsIHN0cnVjdCBjaWZzX3NlcywKIAkJCQkJIHNtYl9z
ZXNfbGlzdCk7CisJCQlpKys7CiAJCQlpZiAoKHNlcy0+c2VydmVyRG9tYWluID09IE5VTEwpIHx8
CiAJCQkJKHNlcy0+c2VydmVyT1MgPT0gTlVMTCkgfHwKIAkJCQkoc2VzLT5zZXJ2ZXJOT1MgPT0g
TlVMTCkpIHsKLQkJCQlzZXFfcHJpbnRmKG0sICJcbiVkKSBOYW1lOiAlcyBVc2VzOiAlZCBDYXBh
YmlsaXR5OiAweCV4XHRTZXNzaW9uIFN0YXR1czogJWQgIiwKKwkJCQlzZXFfcHJpbnRmKG0sICJc
blx0JWQpIE5hbWU6ICVzIFVzZXM6ICVkIENhcGFiaWxpdHk6IDB4JXhcdFNlc3Npb24gU3RhdHVz
OiAlZCAiLAogCQkJCQlpLCBzZXMtPnNlcnZlck5hbWUsIHNlcy0+c2VzX2NvdW50LAogCQkJCQlz
ZXMtPmNhcGFiaWxpdGllcywgc2VzLT5zdGF0dXMpOwogCQkJCWlmIChzZXMtPnNlc3Npb25fZmxh
Z3MgJiBTTUIyX1NFU1NJT05fRkxBR19JU19HVUVTVCkKLQkJCQkJc2VxX3ByaW50ZihtLCAiR3Vl
c3RcdCIpOworCQkJCQlzZXFfcHJpbnRmKG0sICJHdWVzdCAiKTsKIAkJCQllbHNlIGlmIChzZXMt
PnNlc3Npb25fZmxhZ3MgJiBTTUIyX1NFU1NJT05fRkxBR19JU19OVUxMKQotCQkJCQlzZXFfcHJp
bnRmKG0sICJBbm9ueW1vdXNcdCIpOworCQkJCQlzZXFfcHJpbnRmKG0sICJBbm9ueW1vdXMgIik7
CiAJCQl9IGVsc2UgewogCQkJCXNlcV9wcmludGYobSwKLQkJCQkgICAgIlxuJWQpIE5hbWU6ICVz
ICBEb21haW46ICVzIFVzZXM6ICVkIE9TOiIKLQkJCQkgICAgIiAlc1xuXHROT1M6ICVzXHRDYXBh
YmlsaXR5OiAweCV4XG5cdFNNQiIKLQkJCQkgICAgIiBzZXNzaW9uIHN0YXR1czogJWQgIiwKKwkJ
CQkgICAgIlxuXHQlZCkgTmFtZTogJXMgIERvbWFpbjogJXMgVXNlczogJWQgT1M6ICVzICIKKwkJ
CQkgICAgIlxuXHROT1M6ICVzXHRDYXBhYmlsaXR5OiAweCV4IgorCQkJCQkiXG5cdFNNQiBzZXNz
aW9uIHN0YXR1czogJWQgIiwKIAkJCQlpLCBzZXMtPnNlcnZlck5hbWUsIHNlcy0+c2VydmVyRG9t
YWluLAogCQkJCXNlcy0+c2VzX2NvdW50LCBzZXMtPnNlcnZlck9TLCBzZXMtPnNlcnZlck5PUywK
IAkJCQlzZXMtPmNhcGFiaWxpdGllcywgc2VzLT5zdGF0dXMpOwogCQkJfQogCi0JCQlzZXFfcHJp
bnRmKG0sIlNlY3VyaXR5IHR5cGU6ICVzXG4iLAorCQkJc2VxX3ByaW50ZihtLCJcblx0U2VjdXJp
dHkgdHlwZTogJXMgIiwKIAkJCQlnZXRfc2VjdXJpdHlfdHlwZV9zdHIoc2VydmVyLT5vcHMtPnNl
bGVjdF9zZWN0eXBlKHNlcnZlciwgc2VzLT5zZWN0eXBlKSkpOwogCi0JCQlpZiAoc2VydmVyLT5y
ZG1hKQotCQkJCXNlcV9wcmludGYobSwgIlJETUFcblx0Iik7Ci0JCQlzZXFfcHJpbnRmKG0sICJU
Q1Agc3RhdHVzOiAlZCBJbnN0YW5jZTogJWRcblx0TG9jYWwgVXNlcnMgVG8gIgotCQkJCSAgICJT
ZXJ2ZXI6ICVkIFNlY01vZGU6IDB4JXggUmVxIE9uIFdpcmU6ICVkIiwKLQkJCQkgICBzZXJ2ZXIt
PnRjcFN0YXR1cywKLQkJCQkgICBzZXJ2ZXItPnJlY29ubmVjdF9pbnN0YW5jZSwKLQkJCQkgICBz
ZXJ2ZXItPnNydl9jb3VudCwKLQkJCQkgICBzZXJ2ZXItPnNlY19tb2RlLCBpbl9mbGlnaHQoc2Vy
dmVyKSk7Ci0KLQkJCXNlcV9wcmludGYobSwgIiBJbiBTZW5kOiAlZCBJbiBNYXhSZXEgV2FpdDog
JWQiLAotCQkJCWF0b21pY19yZWFkKCZzZXJ2ZXItPmluX3NlbmQpLAotCQkJCWF0b21pY19yZWFk
KCZzZXJ2ZXItPm51bV93YWl0ZXJzKSk7Ci0KIAkJCS8qIGR1bXAgc2Vzc2lvbiBpZCBoZWxwZnVs
IGZvciB1c2Ugd2l0aCBuZXR3b3JrIHRyYWNlICovCiAJCQlzZXFfcHJpbnRmKG0sICIgU2Vzc2lv
bklkOiAweCVsbHgiLCBzZXMtPlN1aWQpOwogCQkJaWYgKHNlcy0+c2Vzc2lvbl9mbGFncyAmIFNN
QjJfU0VTU0lPTl9GTEFHX0VOQ1JZUFRfREFUQSkKQEAgLTQxNCwxMyArNDIyLDEzIEBAIHN0YXRp
YyBpbnQgY2lmc19kZWJ1Z19kYXRhX3Byb2Nfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQg
KnYpCiAJCQkJICAgZnJvbV9rdWlkKCZpbml0X3VzZXJfbnMsIHNlcy0+Y3JlZF91aWQpKTsKIAog
CQkJaWYgKHNlcy0+Y2hhbl9jb3VudCA+IDEpIHsKLQkJCQlzZXFfcHJpbnRmKG0sICJcblxuXHRF
eHRyYSBDaGFubmVsczogJXp1XG4iLAorCQkJCXNlcV9wcmludGYobSwgIlxuXG5cdEV4dHJhIENo
YW5uZWxzOiAlenUgIiwKIAkJCQkJICAgc2VzLT5jaGFuX2NvdW50LTEpOwogCQkJCWZvciAoaiA9
IDE7IGogPCBzZXMtPmNoYW5fY291bnQ7IGorKykKIAkJCQkJY2lmc19kdW1wX2NoYW5uZWwobSwg
aiwgJnNlcy0+Y2hhbnNbal0pOwogCQkJfQogCi0JCQlzZXFfcHV0cyhtLCAiXG5cblx0U2hhcmVz
OiIpOworCQkJc2VxX3B1dHMobSwgIlxuXG5cdFNoYXJlczogIik7CiAJCQlqID0gMDsKIAogCQkJ
c2VxX3ByaW50ZihtLCAiXG5cdCVkKSBJUEM6ICIsIGopOwpAQCAtNDM3LDEzICs0NDUsMTMgQEAg
c3RhdGljIGludCBjaWZzX2RlYnVnX2RhdGFfcHJvY19zaG93KHN0cnVjdCBzZXFfZmlsZSAqbSwg
dm9pZCAqdikKIAkJCQljaWZzX2RlYnVnX3Rjb24obSwgdGNvbik7CiAJCQl9CiAKLQkJCXNlcV9w
dXRzKG0sICJcblx0TUlEczpcbiIpOworCQkJc2VxX3B1dHMobSwgIlxuXG5cdE1JRHM6ICIpOwog
CiAJCQlzcGluX2xvY2soJkdsb2JhbE1pZF9Mb2NrKTsKIAkJCWxpc3RfZm9yX2VhY2godG1wMywg
JnNlcnZlci0+cGVuZGluZ19taWRfcSkgewogCQkJCW1pZF9lbnRyeSA9IGxpc3RfZW50cnkodG1w
Mywgc3RydWN0IG1pZF9xX2VudHJ5LAogCQkJCQlxaGVhZCk7Ci0JCQkJc2VxX3ByaW50ZihtLCAi
XHRTdGF0ZTogJWQgY29tOiAlZCBwaWQ6IgorCQkJCXNlcV9wcmludGYobSwgIlxuXHRTdGF0ZTog
JWQgY29tOiAlZCBwaWQ6IgogCQkJCQkgICAgICAiICVkIGNiZGF0YTogJXAgbWlkICVsbHVcbiIs
CiAJCQkJCSAgICAgIG1pZF9lbnRyeS0+bWlkX3N0YXRlLAogCQkJCQkgICAgICBsZTE2X3RvX2Nw
dShtaWRfZW50cnktPmNvbW1hbmQpLApAQCAtNDU1LDE2ICs0NjMsMTYgQEAgc3RhdGljIGludCBj
aWZzX2RlYnVnX2RhdGFfcHJvY19zaG93KHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdikKIAog
CQkJc3Bpbl9sb2NrKCZzZXMtPmlmYWNlX2xvY2spOwogCQkJaWYgKHNlcy0+aWZhY2VfY291bnQp
Ci0JCQkJc2VxX3ByaW50ZihtLCAiXG5cdFNlcnZlciBpbnRlcmZhY2VzOiAlenVcbiIsCisJCQkJ
c2VxX3ByaW50ZihtLCAiXG5cblx0U2VydmVyIGludGVyZmFjZXM6ICV6dSIsCiAJCQkJCSAgIHNl
cy0+aWZhY2VfY291bnQpOwogCQkJZm9yIChqID0gMDsgaiA8IHNlcy0+aWZhY2VfY291bnQ7IGor
KykgewogCQkJCXN0cnVjdCBjaWZzX3NlcnZlcl9pZmFjZSAqaWZhY2U7CiAKIAkJCQlpZmFjZSA9
ICZzZXMtPmlmYWNlX2xpc3Rbal07Ci0JCQkJc2VxX3ByaW50ZihtLCAiXHQlZCkiLCBqKTsKKwkJ
CQlzZXFfcHJpbnRmKG0sICJcblx0JWQpIiwgaisxKTsKIAkJCQljaWZzX2R1bXBfaWZhY2UobSwg
aWZhY2UpOwogCQkJCWlmIChpc19zZXNfdXNpbmdfaWZhY2Uoc2VzLCBpZmFjZSkpCi0JCQkJCXNl
cV9wdXRzKG0sICJcdFx0W0NPTk5FQ1RFRF1cbiIpOworCQkJCQlzZXFfcHV0cyhtLCAiXHRcdFtD
T05ORUNURURdIFxuIik7CiAJCQl9CiAJCQlzcGluX3VubG9jaygmc2VzLT5pZmFjZV9sb2NrKTsK
IAkJfQotLSAKMi4yNS4xCgo=
--00000000000056e65b05ba817f3b--
