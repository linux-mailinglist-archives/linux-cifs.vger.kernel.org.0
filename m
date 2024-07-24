Return-Path: <linux-cifs+bounces-2352-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id DC5E893B583
	for <lists+linux-cifs@lfdr.de>; Wed, 24 Jul 2024 19:04:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B7441C206A6
	for <lists+linux-cifs@lfdr.de>; Wed, 24 Jul 2024 17:04:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2C65415CD49;
	Wed, 24 Jul 2024 17:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OBQSxmMv"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C136282FA
	for <linux-cifs@vger.kernel.org>; Wed, 24 Jul 2024 17:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721840667; cv=none; b=aPEss3QvEFBu8Gyyqk0fHcrqmLuaXRa1L38650qn7mskWdMokAmBkkGTfcL73vH8EAdxUkO74wmALS4SCnmeZp+9UvlwwIjF4LviblFCepNpkaVXMOS1oQrtO1AjaxhtDD4LoBTMYy6X6wme2fcVMMpzJ0NUXon9nSXFH2UMpTA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721840667; c=relaxed/simple;
	bh=MbQtOO5fbZJwBl0fUYwwCPpkFc8j38L6KZo4BYx+PVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HibJhw5WLYa/NqyqnyiCaRRqZoOyTEGYy3t86IYafPe0r4mFrpiAP96DIWDlJRGRbZ73ZMwbAtwdqg18p/IwwL5/lyEQPS8eC34uWa2lotxZuWrj9lszBvB4wA+zmiefA5/zR54BPOcSJdBzY9rcFrRhYkx+PNylsCRGPXFw7Bg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OBQSxmMv; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2ef283c58f4so356341fa.1
        for <linux-cifs@vger.kernel.org>; Wed, 24 Jul 2024 10:04:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721840663; x=1722445463; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=wiLMo1YJMmuNVupFGPoSJ3iD4Mbw3f6wyolHRnNQnR0=;
        b=OBQSxmMvHIq+Lk0LQwt+7iOroOy6pf2lsqMwjLh8+kPTYrxcHjH+JC2ZRt+3AOvsKI
         9B5tOCkU2JuatDdSVuSfXGGWdwr8CgOs/8iZ7HfA8etzwwME+2DiBjwcNfLESFCn0hL/
         N7tgOW4Src4iF3msUFmvmTZGvqfQppx2ReJwG1AhgjCSrb1aq4BXmzliS/+mgxpxr1KB
         h5hWKkuiVEKiuttrkhfJC6EPHaiqbr4BgCFralhjvXyNxCTHKw9HPbU6f8mr8fwkCemQ
         AqxRYvsvnSJ3RWNflk78N7IRvA+hYJVa89froQnz9XqeQq23J4eO/Z1OubGLlE56W17A
         /yKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721840663; x=1722445463;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wiLMo1YJMmuNVupFGPoSJ3iD4Mbw3f6wyolHRnNQnR0=;
        b=tTnAXu29VVZ9dwJjVJ+7xg/MyztRT+JDq+hwdrAf7LJisXw99sP6Q6wkEZj0Pu6mgZ
         8WgWrN7f8fBq7RgcZ7UfWogXYqDUSomlQeHcLVEgOHB9JgHng6cR0cuVhnqnoFfmmtwO
         Mryy704TQnoM4SKgTXEpvZ/7oa33iJ8/kroUR4BIkek1EpkIrrT3ZyVbGRAhF89hWJ0T
         CsC7r5Q0m0bFjxuUeKV7vMD+1cwf6PiDMihS5ShZExeqcRC03eGrhDJi4FwqHFx2btpD
         hTtKukRhJCHf19dqTvrrE8T3/bGMK95ZVjveb7Omx1rBpM0F8kyC9sLW7to5LVFguK77
         9Wvw==
X-Gm-Message-State: AOJu0YwXzwXM6fLyQbpsaNH18wPWvEJRQvipm0waKfP6scZIMsnWnI7K
	hrbbseNfoHI4OnLxpEFmWPRSiGFGW+K39OwVuu0IOhWjimNtl7XrgvP6JDVZP/WVKzFR6D3Ka0N
	BTM7fovoKGi2ooNnwzO7HunPdjrg0xRI4
X-Google-Smtp-Source: AGHT+IE5NobXJmFMeEUDQZRY9YyrkcPAPPglhjtYnM3s8nH3wGSDtP4HhMgJJi6xeJwDJWglHLFm3uAta9iuIXzuhKg=
X-Received: by 2002:a2e:8613:0:b0:2ef:2e0e:c888 with SMTP id
 38308e7fff4ca-2f039f3ce48mr2699881fa.48.1721840662506; Wed, 24 Jul 2024
 10:04:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAH2r5msr2Xo=8stptjhsQbaMhot_x=FrcpOxyjeAu9crV9evtg@mail.gmail.com>
In-Reply-To: <CAH2r5msr2Xo=8stptjhsQbaMhot_x=FrcpOxyjeAu9crV9evtg@mail.gmail.com>
From: Steve French <smfrench@gmail.com>
Date: Wed, 24 Jul 2024 12:04:08 -0500
Message-ID: <CAH2r5muHHexSL3W0YJR75_7kHG2Jd0uZexK2QLxpX_WczeFQbg@mail.gmail.com>
Subject: Re: [PATCH][SMB3 client] dynamic tracepoints for copy_range and clone_range
To: CIFS <linux-cifs@vger.kernel.org>
Cc: Bharath S M <bharathsm@microsoft.com>
Content-Type: multipart/mixed; boundary="0000000000000ca1cd061e0145de"

--0000000000000ca1cd061e0145de
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Lightly updated v2 of these patches to handle a possible null tcon in
the call to smb3_copychunk_err()


On Wed, Jul 24, 2024 at 12:03=E2=80=AFAM Steve French <smfrench@gmail.com> =
wrote:
>
> Two patches that add dynamic tracepoints for copy_range and clone
> range including
>
>    smb3: add four more dynamic tracepoints for copy_file_range and reflin=
k
>
>     Add more dynamic tracepoints to help debug copy_file_range (copychunk=
)
>     and clone_range ("duplicate extents").  These are tracepoints for
>     entering the function and completing without error. For example:
>
>       "trace-cmd record -e smb3_copychunk_enter -e smb3_copychunk_done"
>       "trace-cmd record -e smb3_clone_enter -e smb3_clone_done"
>
>     Here is sample output:
>
>            TASK-PID     CPU#  |||||  TIMESTAMP  FUNCTION
>              | |         |   |||||     |         |
>            cp-5964    [005] .....  2176.168977: smb3_clone_enter:
>              xid=3D17 sid=3D0xeb275be4 tid=3D0x7ffa7cdb source fid=3D0x1e=
d02e15
>              source offset=3D0x0 target fid=3D0x1ed02e15 target offset=3D=
0x0
>              len=3D0xa0000
>            cp-5964    [005] .....  2176.170668: smb3_clone_done:
>              xid=3D17 sid=3D0xeb275be4 tid=3D0x7ffa7cdb source fid=3D0x1e=
d02e15
>              source offset=3D0x0 target fid=3D0x1ed02e15 target offset=3D=
0x0
>              len=3D0xa0000
>
> and
>
>     smb3: add dynamic tracepoints for copy_file_range and reflink errors
>
>     There are cases where debugging clone_range ("smb2_duplicate_extents"
>     function) and copy_range ("smb2_copychunk_range") can be helpful.
>     Add dynamic trace points for any errors in these two routines. e,g,
>
>       "trace-cmd record -e smb3_copychunk_err -e smb3_clone_err"
>
> See attached
>
>
> --
> Thanks,
>
> Steve



--=20
Thanks,

Steve

--0000000000000ca1cd061e0145de
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb3-add-dynamic-tracepoints-for-copy_file_range-and.patch"
Content-Disposition: attachment; 
	filename="0001-smb3-add-dynamic-tracepoints-for-copy_file_range-and.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lz03gpmc1>
X-Attachment-Id: f_lz03gpmc1

RnJvbSBkYTk2ZWZjNGQ5YmZhNDg3MDAzNzBiOWU4NjRkYjZlYTFhY2FlZDYxIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFR1ZSwgMjMgSnVsIDIwMjQgMTg6MTI6NDAgLTA1MDAKU3ViamVjdDogW1BBVENIIDEv
Ml0gc21iMzogYWRkIGR5bmFtaWMgdHJhY2Vwb2ludHMgZm9yIGNvcHlfZmlsZV9yYW5nZSBhbmQK
IHJlZmxpbmsgZXJyb3JzCgpUaGVyZSBhcmUgY2FzZXMgd2hlcmUgZGVidWdnaW5nIGNsb25lX3Jh
bmdlICgic21iMl9kdXBsaWNhdGVfZXh0ZW50cyIKZnVuY3Rpb24pIGFuZCBjb3B5X3JhbmdlICgi
c21iMl9jb3B5Y2h1bmtfcmFuZ2UiKSBjYW4gYmUgaGVscGZ1bC4KQWRkIGR5bmFtaWMgdHJhY2Ug
cG9pbnRzIGZvciBhbnkgZXJyb3JzIGluIHRoZXNlIHR3byByb3V0aW5lcy4gZSxnLAoKICAidHJh
Y2UtY21kIHJlY29yZCAtZSBzbWIzX2NvcHljaHVua19lcnIgLWUgc21iM19jbG9uZV9lcnIiCgpT
aWduZWQtb2ZmLWJ5OiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+Ci0tLQog
ZnMvc21iL2NsaWVudC9zbWIyb3BzLmMgfCAxNCArKysrKysrKy0tCiBmcy9zbWIvY2xpZW50L3Ry
YWNlLmggICB8IDU3ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrCiAy
IGZpbGVzIGNoYW5nZWQsIDY5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZnMvc21iL2NsaWVudC9zbWIyb3BzLmMgYi9mcy9zbWIvY2xpZW50L3NtYjJvcHMuYwpp
bmRleCA3ZmU1OTIzNWYwOTAuLmExYTgxZGNhZWU5MSAxMDA2NDQKLS0tIGEvZnMvc21iL2NsaWVu
dC9zbWIyb3BzLmMKKysrIGIvZnMvc21iL2NsaWVudC9zbWIyb3BzLmMKQEAgLTE4OTksOSArMTg5
OSwxNCBAQCBzbWIyX2NvcHljaHVua19yYW5nZShjb25zdCB1bnNpZ25lZCBpbnQgeGlkLAogY2No
dW5rX291dDoKIAlrZnJlZShwY2NodW5rKTsKIAlrZnJlZShyZXRidWYpOwotCWlmIChyYykKKwlp
ZiAocmMpIHsKKwkJaWYgKHRjb24pCisJCQl0cmFjZV9zbWIzX2NvcHljaHVua19lcnIoeGlkLCBz
cmNmaWxlLT5maWQudm9sYXRpbGVfZmlkLAorCQkJCQl0cmd0ZmlsZS0+ZmlkLnZvbGF0aWxlX2Zp
ZCwKKwkJCQkJdGNvbi0+dGlkLCB0Y29uLT5zZXMtPlN1aWQsIHNyY19vZmYsCisJCQkJCWRlc3Rf
b2ZmLCBsZW4sIHJjKTsKIAkJcmV0dXJuIHJjOwotCWVsc2UKKwl9IGVsc2UKIAkJcmV0dXJuIHRv
dGFsX2J5dGVzX3dyaXR0ZW47CiB9CiAKQEAgLTIwNzUsNiArMjA4MCwxMSBAQCBzbWIyX2R1cGxp
Y2F0ZV9leHRlbnRzKGNvbnN0IHVuc2lnbmVkIGludCB4aWQsCiAJCWNpZnNfZGJnKEZZSSwgIk5v
bi16ZXJvIHJlc3BvbnNlIGxlbmd0aCBpbiBkdXBsaWNhdGUgZXh0ZW50c1xuIik7CiAKIGR1cGxp
Y2F0ZV9leHRlbnRzX291dDoKKwlpZiAocmMpCisJCXRyYWNlX3NtYjNfY2xvbmVfZXJyKHhpZCwg
c3JjZmlsZS0+ZmlkLnZvbGF0aWxlX2ZpZCwKKwkJCQkgICAgIHRyZ3RmaWxlLT5maWQudm9sYXRp
bGVfZmlkLAorCQkJCSAgICAgdGNvbi0+dGlkLCB0Y29uLT5zZXMtPlN1aWQsIHNyY19vZmYsCisJ
CQkJICAgICBkZXN0X29mZiwgbGVuLCByYyk7CiAJcmV0dXJuIHJjOwogfQogCmRpZmYgLS1naXQg
YS9mcy9zbWIvY2xpZW50L3RyYWNlLmggYi9mcy9zbWIvY2xpZW50L3RyYWNlLmgKaW5kZXggMzZk
NTI5NWMyYTZmLi44OTFkNmQ5NzlmYWQgMTAwNjQ0Ci0tLSBhL2ZzL3NtYi9jbGllbnQvdHJhY2Uu
aAorKysgYi9mcy9zbWIvY2xpZW50L3RyYWNlLmgKQEAgLTIwNiw2ICsyMDYsNjMgQEAgREVGSU5F
X1NNQjNfT1RIRVJfRVJSX0VWRU5UKHF1ZXJ5X2Rpcl9lcnIpOwogREVGSU5FX1NNQjNfT1RIRVJf
RVJSX0VWRU5UKHplcm9fZXJyKTsKIERFRklORV9TTUIzX09USEVSX0VSUl9FVkVOVChmYWxsb2Nf
ZXJyKTsKIAorLyoKKyAqIEZvciBsb2dnaW5nIGVycm9ycyBpbiByZWZsaW5rIGFuZCBjb3B5X3Jh
bmdlIG9wcyBlLmcuIHNtYjJfY29weWNodW5rX3JhbmdlCisgKiBhbmQgc21iMl9kdXBsaWNhdGVf
ZXh0ZW50cworICovCitERUNMQVJFX0VWRU5UX0NMQVNTKHNtYjNfY29weV9yYW5nZV9lcnJfY2xh
c3MsCisJVFBfUFJPVE8odW5zaWduZWQgaW50IHhpZCwKKwkJX191NjQJc3JjX2ZpZCwKKwkJX191
NjQgICB0YXJnZXRfZmlkLAorCQlfX3UzMgl0aWQsCisJCV9fdTY0CXNlc2lkLAorCQlfX3U2NAlz
cmNfb2Zmc2V0LAorCQlfX3U2NCAgIHRhcmdldF9vZmZzZXQsCisJCV9fdTMyCWxlbiwKKwkJaW50
CXJjKSwKKwlUUF9BUkdTKHhpZCwgc3JjX2ZpZCwgdGFyZ2V0X2ZpZCwgdGlkLCBzZXNpZCwgc3Jj
X29mZnNldCwgdGFyZ2V0X29mZnNldCwgbGVuLCByYyksCisJVFBfU1RSVUNUX19lbnRyeSgKKwkJ
X19maWVsZCh1bnNpZ25lZCBpbnQsIHhpZCkKKwkJX19maWVsZChfX3U2NCwgc3JjX2ZpZCkKKwkJ
X19maWVsZChfX3U2NCwgdGFyZ2V0X2ZpZCkKKwkJX19maWVsZChfX3UzMiwgdGlkKQorCQlfX2Zp
ZWxkKF9fdTY0LCBzZXNpZCkKKwkJX19maWVsZChfX3U2NCwgc3JjX29mZnNldCkKKwkJX19maWVs
ZChfX3U2NCwgdGFyZ2V0X29mZnNldCkKKwkJX19maWVsZChfX3UzMiwgbGVuKQorCQlfX2ZpZWxk
KGludCwgcmMpCisJKSwKKwlUUF9mYXN0X2Fzc2lnbigKKwkJX19lbnRyeS0+eGlkID0geGlkOwor
CQlfX2VudHJ5LT5zcmNfZmlkID0gc3JjX2ZpZDsKKwkJX19lbnRyeS0+dGFyZ2V0X2ZpZCA9IHRh
cmdldF9maWQ7CisJCV9fZW50cnktPnRpZCA9IHRpZDsKKwkJX19lbnRyeS0+c2VzaWQgPSBzZXNp
ZDsKKwkJX19lbnRyeS0+c3JjX29mZnNldCA9IHNyY19vZmZzZXQ7CisJCV9fZW50cnktPnRhcmdl
dF9vZmZzZXQgPSB0YXJnZXRfb2Zmc2V0OworCQlfX2VudHJ5LT5sZW4gPSBsZW47CisJCV9fZW50
cnktPnJjID0gcmM7CisJKSwKKwlUUF9wcmludGsoIlx0eGlkPSV1IHNpZD0weCVsbHggdGlkPTB4
JXggc291cmNlIGZpZD0weCVsbHggc291cmNlIG9mZnNldD0weCVsbHggdGFyZ2V0IGZpZD0weCVs
bHggdGFyZ2V0IG9mZnNldD0weCVsbHggbGVuPTB4JXggcmM9JWQiLAorCQlfX2VudHJ5LT54aWQs
IF9fZW50cnktPnNlc2lkLCBfX2VudHJ5LT50aWQsIF9fZW50cnktPnRhcmdldF9maWQsCisJCV9f
ZW50cnktPnNyY19vZmZzZXQsIF9fZW50cnktPnRhcmdldF9maWQsIF9fZW50cnktPnRhcmdldF9v
ZmZzZXQsIF9fZW50cnktPmxlbiwgX19lbnRyeS0+cmMpCispCisKKyNkZWZpbmUgREVGSU5FX1NN
QjNfQ09QWV9SQU5HRV9FUlJfRVZFTlQobmFtZSkJXAorREVGSU5FX0VWRU5UKHNtYjNfY29weV9y
YW5nZV9lcnJfY2xhc3MsIHNtYjNfIyNuYW1lLCBcCisJVFBfUFJPVE8odW5zaWduZWQgaW50IHhp
ZCwJCVwKKwkJX191NjQJc3JjX2ZpZCwJCVwKKwkJX191NjQgICB0YXJnZXRfZmlkLAkJXAorCQlf
X3UzMgl0aWQsCQkJXAorCQlfX3U2NAlzZXNpZCwJCQlcCisJCV9fdTY0CXNyY19vZmZzZXQsCQlc
CisJCV9fdTY0CXRhcmdldF9vZmZzZXQsCQlcCisJCV9fdTMyCWxlbiwJCQlcCisJCWludAlyYyks
CQkJXAorCVRQX0FSR1MoeGlkLCBzcmNfZmlkLCB0YXJnZXRfZmlkLCB0aWQsIHNlc2lkLCBzcmNf
b2Zmc2V0LCB0YXJnZXRfb2Zmc2V0LCBsZW4sIHJjKSkKKworREVGSU5FX1NNQjNfQ09QWV9SQU5H
RV9FUlJfRVZFTlQoY29weWNodW5rX2Vycik7CitERUZJTkVfU01CM19DT1BZX1JBTkdFX0VSUl9F
VkVOVChjbG9uZV9lcnIpOwogCiAvKiBGb3IgbG9nZ2luZyBzdWNjZXNzZnVsIHJlYWQgb3Igd3Jp
dGUgKi8KIERFQ0xBUkVfRVZFTlRfQ0xBU1Moc21iM19yd19kb25lX2NsYXNzLAotLSAKMi40My4w
Cgo=
--0000000000000ca1cd061e0145de
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0002-smb3-add-four-dynamic-tracepoints-for-copy_file_rang.patch"
Content-Disposition: attachment; 
	filename="0002-smb3-add-four-dynamic-tracepoints-for-copy_file_rang.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_lz03gply0>
X-Attachment-Id: f_lz03gply0

RnJvbSA5YTgxOWYxMzU3NjQ4MDgzZGI5ZGYyN2JhNTFjODdlYjRjYzUzYzM2IE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTdGV2ZSBGcmVuY2ggPHN0ZnJlbmNoQG1pY3Jvc29mdC5jb20+
CkRhdGU6IFdlZCwgMjQgSnVsIDIwMjQgMTE6NTc6MTggLTA1MDAKU3ViamVjdDogW1BBVENIIDIv
Ml0gc21iMzogYWRkIGZvdXIgZHluYW1pYyB0cmFjZXBvaW50cyBmb3IgY29weV9maWxlX3Jhbmdl
CiBhbmQgcmVmbGluawoKQWRkIG1vcmUgZHluYW1pYyB0cmFjZXBvaW50cyB0byBoZWxwIGRlYnVn
IGNvcHlfZmlsZV9yYW5nZSAoY29weWNodW5rKQphbmQgY2xvbmVfcmFuZ2UgKCJkdXBsaWNhdGUg
ZXh0ZW50cyIpLiAgVGhlc2UgYXJlIHRyYWNlcG9pbnRzIGZvcgplbnRlcmluZyB0aGUgZnVuY3Rp
b24gYW5kIGNvbXBsZXRpbmcgd2l0aG91dCBlcnJvci4gRm9yIGV4YW1wbGU6CgogICJ0cmFjZS1j
bWQgcmVjb3JkIC1lIHNtYjNfY29weWNodW5rX2VudGVyIC1lIHNtYjNfY29weWNodW5rX2RvbmUi
CgpvcgoKICAidHJhY2UtY21kIHJlY29yZCAtZSBzbWIzX2Nsb25lX2VudGVyIC1lIHNtYjNfY2xv
bmVfZG9uZSIKCkhlcmUgaXMgc2FtcGxlIG91dHB1dDoKCiAgICAgICBUQVNLLVBJRCAgICAgQ1BV
IyAgfHx8fHwgIFRJTUVTVEFNUCAgRlVOQ1RJT04KICAgICAgICAgfCB8ICAgICAgICAgfCAgIHx8
fHx8ICAgICB8ICAgICAgICAgfAogICAgICAgY3AtNTk2NCAgICBbMDA1XSAuLi4uLiAgMjE3Ni4x
Njg5Nzc6IHNtYjNfY2xvbmVfZW50ZXI6CiAgICAgICAgIHhpZD0xNyBzaWQ9MHhlYjI3NWJlNCB0
aWQ9MHg3ZmZhN2NkYiBzb3VyY2UgZmlkPTB4MWVkMDJlMTUKICAgICAgICAgc291cmNlIG9mZnNl
dD0weDAgdGFyZ2V0IGZpZD0weDFlZDAyZTE1IHRhcmdldCBvZmZzZXQ9MHgwCiAgICAgICAgIGxl
bj0weGEwMDAwCiAgICAgICBjcC01OTY0ICAgIFswMDVdIC4uLi4uICAyMTc2LjE3MDY2ODogc21i
M19jbG9uZV9kb25lOgogICAgICAgICB4aWQ9MTcgc2lkPTB4ZWIyNzViZTQgdGlkPTB4N2ZmYTdj
ZGIgc291cmNlIGZpZD0weDFlZDAyZTE1CiAgICAgICAgIHNvdXJjZSBvZmZzZXQ9MHgwIHRhcmdl
dCBmaWQ9MHgxZWQwMmUxNSB0YXJnZXQgb2Zmc2V0PTB4MAogICAgICAgICBsZW49MHhhMDAwMAoK
U2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5jaEBtaWNyb3NvZnQuY29tPgotLS0K
IGZzL3NtYi9jbGllbnQvc21iMm9wcy5jIHwgMTggKysrKysrKysrKystLS0KIGZzL3NtYi9jbGll
bnQvdHJhY2UuaCAgIHwgNTMgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKIDIgZmlsZXMgY2hhbmdlZCwgNjggaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkKCmRp
ZmYgLS1naXQgYS9mcy9zbWIvY2xpZW50L3NtYjJvcHMuYyBiL2ZzL3NtYi9jbGllbnQvc21iMm9w
cy5jCmluZGV4IGExYTgxZGNhZWU5MS4uZWY3MzFiODA0OGM1IDEwMDY0NAotLS0gYS9mcy9zbWIv
Y2xpZW50L3NtYjJvcHMuYworKysgYi9mcy9zbWIvY2xpZW50L3NtYjJvcHMuYwpAQCAtMTgxMiw2
ICsxODEyLDkgQEAgc21iMl9jb3B5Y2h1bmtfcmFuZ2UoY29uc3QgdW5zaWduZWQgaW50IHhpZCwK
IAogCXRjb24gPSB0bGlua190Y29uKHRyZ3RmaWxlLT50bGluayk7CiAKKwl0cmFjZV9zbWIzX2Nv
cHljaHVua19lbnRlcih4aWQsIHNyY2ZpbGUtPmZpZC52b2xhdGlsZV9maWQsCisJCQkJICAgdHJn
dGZpbGUtPmZpZC52b2xhdGlsZV9maWQsIHRjb24tPnRpZCwKKwkJCQkgICB0Y29uLT5zZXMtPlN1
aWQsIHNyY19vZmYsIGRlc3Rfb2ZmLCBsZW4pOwogCXdoaWxlIChsZW4gPiAwKSB7CiAJCXBjY2h1
bmstPlNvdXJjZU9mZnNldCA9IGNwdV90b19sZTY0KHNyY19vZmYpOwogCQlwY2NodW5rLT5UYXJn
ZXRPZmZzZXQgPSBjcHVfdG9fbGU2NChkZXN0X29mZik7CkBAIC0xOTA2LDggKzE5MDksMTEgQEAg
c21iMl9jb3B5Y2h1bmtfcmFuZ2UoY29uc3QgdW5zaWduZWQgaW50IHhpZCwKIAkJCQkJdGNvbi0+
dGlkLCB0Y29uLT5zZXMtPlN1aWQsIHNyY19vZmYsCiAJCQkJCWRlc3Rfb2ZmLCBsZW4sIHJjKTsK
IAkJcmV0dXJuIHJjOwotCX0gZWxzZQotCQlyZXR1cm4gdG90YWxfYnl0ZXNfd3JpdHRlbjsKKwl9
CisJdHJhY2Vfc21iM19jb3B5Y2h1bmtfZG9uZSh4aWQsIHNyY2ZpbGUtPmZpZC52b2xhdGlsZV9m
aWQsCisJCQkJICB0cmd0ZmlsZS0+ZmlkLnZvbGF0aWxlX2ZpZCwgdGNvbi0+dGlkLAorCQkJCSAg
dGNvbi0+c2VzLT5TdWlkLCBzcmNfb2ZmLCBkZXN0X29mZiwgbGVuKTsKKwlyZXR1cm4gdG90YWxf
Ynl0ZXNfd3JpdHRlbjsKIH0KIAogc3RhdGljIGludApAQCAtMjA1MSw3ICsyMDU3LDkgQEAgc21i
Ml9kdXBsaWNhdGVfZXh0ZW50cyhjb25zdCB1bnNpZ25lZCBpbnQgeGlkLAogCWR1cF9leHRfYnVm
LkJ5dGVDb3VudCA9IGNwdV90b19sZTY0KGxlbik7CiAJY2lmc19kYmcoRllJLCAiRHVwbGljYXRl
IGV4dGVudHM6IHNyYyBvZmYgJWxsZCBkc3Qgb2ZmICVsbGQgbGVuICVsbGRcbiIsCiAJCXNyY19v
ZmYsIGRlc3Rfb2ZmLCBsZW4pOwotCisJdHJhY2Vfc21iM19jbG9uZV9lbnRlcih4aWQsIHNyY2Zp
bGUtPmZpZC52b2xhdGlsZV9maWQsCisJCQkgICAgICAgdHJndGZpbGUtPmZpZC52b2xhdGlsZV9m
aWQsIHRjb24tPnRpZCwKKwkJCSAgICAgICB0Y29uLT5zZXMtPlN1aWQsIHNyY19vZmYsIGRlc3Rf
b2ZmLCBsZW4pOwogCWlub2RlID0gZF9pbm9kZSh0cmd0ZmlsZS0+ZGVudHJ5KTsKIAlpZiAoaW5v
ZGUtPmlfc2l6ZSA8IGRlc3Rfb2ZmICsgbGVuKSB7CiAJCXJjID0gc21iMl9zZXRfZmlsZV9zaXpl
KHhpZCwgdGNvbiwgdHJndGZpbGUsIGRlc3Rfb2ZmICsgbGVuLCBmYWxzZSk7CkBAIC0yMDg1LDYg
KzIwOTMsMTAgQEAgc21iMl9kdXBsaWNhdGVfZXh0ZW50cyhjb25zdCB1bnNpZ25lZCBpbnQgeGlk
LAogCQkJCSAgICAgdHJndGZpbGUtPmZpZC52b2xhdGlsZV9maWQsCiAJCQkJICAgICB0Y29uLT50
aWQsIHRjb24tPnNlcy0+U3VpZCwgc3JjX29mZiwKIAkJCQkgICAgIGRlc3Rfb2ZmLCBsZW4sIHJj
KTsKKwllbHNlCisJCXRyYWNlX3NtYjNfY2xvbmVfZG9uZSh4aWQsIHNyY2ZpbGUtPmZpZC52b2xh
dGlsZV9maWQsCisJCQkJICAgICAgdHJndGZpbGUtPmZpZC52b2xhdGlsZV9maWQsIHRjb24tPnRp
ZCwKKwkJCQkgICAgICB0Y29uLT5zZXMtPlN1aWQsIHNyY19vZmYsIGRlc3Rfb2ZmLCBsZW4pOwog
CXJldHVybiByYzsKIH0KIApkaWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC90cmFjZS5oIGIvZnMv
c21iL2NsaWVudC90cmFjZS5oCmluZGV4IDg5MWQ2ZDk3OWZhZC4uYzFjNDY3MmYwYzVlIDEwMDY0
NAotLS0gYS9mcy9zbWIvY2xpZW50L3RyYWNlLmgKKysrIGIvZnMvc21iL2NsaWVudC90cmFjZS5o
CkBAIC0yNjQsNiArMjY0LDU5IEBAIERFRklORV9FVkVOVChzbWIzX2NvcHlfcmFuZ2VfZXJyX2Ns
YXNzLCBzbWIzXyMjbmFtZSwgXAogREVGSU5FX1NNQjNfQ09QWV9SQU5HRV9FUlJfRVZFTlQoY29w
eWNodW5rX2Vycik7CiBERUZJTkVfU01CM19DT1BZX1JBTkdFX0VSUl9FVkVOVChjbG9uZV9lcnIp
OwogCitERUNMQVJFX0VWRU5UX0NMQVNTKHNtYjNfY29weV9yYW5nZV9kb25lX2NsYXNzLAorCVRQ
X1BST1RPKHVuc2lnbmVkIGludCB4aWQsCisJCV9fdTY0CXNyY19maWQsCisJCV9fdTY0ICAgdGFy
Z2V0X2ZpZCwKKwkJX191MzIJdGlkLAorCQlfX3U2NAlzZXNpZCwKKwkJX191NjQJc3JjX29mZnNl
dCwKKwkJX191NjQgICB0YXJnZXRfb2Zmc2V0LAorCQlfX3UzMglsZW4pLAorCVRQX0FSR1MoeGlk
LCBzcmNfZmlkLCB0YXJnZXRfZmlkLCB0aWQsIHNlc2lkLCBzcmNfb2Zmc2V0LCB0YXJnZXRfb2Zm
c2V0LCBsZW4pLAorCVRQX1NUUlVDVF9fZW50cnkoCisJCV9fZmllbGQodW5zaWduZWQgaW50LCB4
aWQpCisJCV9fZmllbGQoX191NjQsIHNyY19maWQpCisJCV9fZmllbGQoX191NjQsIHRhcmdldF9m
aWQpCisJCV9fZmllbGQoX191MzIsIHRpZCkKKwkJX19maWVsZChfX3U2NCwgc2VzaWQpCisJCV9f
ZmllbGQoX191NjQsIHNyY19vZmZzZXQpCisJCV9fZmllbGQoX191NjQsIHRhcmdldF9vZmZzZXQp
CisJCV9fZmllbGQoX191MzIsIGxlbikKKwkpLAorCVRQX2Zhc3RfYXNzaWduKAorCQlfX2VudHJ5
LT54aWQgPSB4aWQ7CisJCV9fZW50cnktPnNyY19maWQgPSBzcmNfZmlkOworCQlfX2VudHJ5LT50
YXJnZXRfZmlkID0gdGFyZ2V0X2ZpZDsKKwkJX19lbnRyeS0+dGlkID0gdGlkOworCQlfX2VudHJ5
LT5zZXNpZCA9IHNlc2lkOworCQlfX2VudHJ5LT5zcmNfb2Zmc2V0ID0gc3JjX29mZnNldDsKKwkJ
X19lbnRyeS0+dGFyZ2V0X29mZnNldCA9IHRhcmdldF9vZmZzZXQ7CisJCV9fZW50cnktPmxlbiA9
IGxlbjsKKwkpLAorCVRQX3ByaW50aygiXHR4aWQ9JXUgc2lkPTB4JWxseCB0aWQ9MHgleCBzb3Vy
Y2UgZmlkPTB4JWxseCBzb3VyY2Ugb2Zmc2V0PTB4JWxseCB0YXJnZXQgZmlkPTB4JWxseCB0YXJn
ZXQgb2Zmc2V0PTB4JWxseCBsZW49MHgleCIsCisJCV9fZW50cnktPnhpZCwgX19lbnRyeS0+c2Vz
aWQsIF9fZW50cnktPnRpZCwgX19lbnRyeS0+dGFyZ2V0X2ZpZCwKKwkJX19lbnRyeS0+c3JjX29m
ZnNldCwgX19lbnRyeS0+dGFyZ2V0X2ZpZCwgX19lbnRyeS0+dGFyZ2V0X29mZnNldCwgX19lbnRy
eS0+bGVuKQorKQorCisjZGVmaW5lIERFRklORV9TTUIzX0NPUFlfUkFOR0VfRE9ORV9FVkVOVChu
YW1lKQlcCitERUZJTkVfRVZFTlQoc21iM19jb3B5X3JhbmdlX2RvbmVfY2xhc3MsIHNtYjNfIyNu
YW1lLCBcCisJVFBfUFJPVE8odW5zaWduZWQgaW50IHhpZCwJCVwKKwkJX191NjQJc3JjX2ZpZCwJ
CVwKKwkJX191NjQgICB0YXJnZXRfZmlkLAkJXAorCQlfX3UzMgl0aWQsCQkJXAorCQlfX3U2NAlz
ZXNpZCwJCQlcCisJCV9fdTY0CXNyY19vZmZzZXQsCQlcCisJCV9fdTY0CXRhcmdldF9vZmZzZXQs
CQlcCisJCV9fdTMyCWxlbiksCQkJXAorCVRQX0FSR1MoeGlkLCBzcmNfZmlkLCB0YXJnZXRfZmlk
LCB0aWQsIHNlc2lkLCBzcmNfb2Zmc2V0LCB0YXJnZXRfb2Zmc2V0LCBsZW4pKQorCitERUZJTkVf
U01CM19DT1BZX1JBTkdFX0RPTkVfRVZFTlQoY29weWNodW5rX2VudGVyKTsKK0RFRklORV9TTUIz
X0NPUFlfUkFOR0VfRE9ORV9FVkVOVChjbG9uZV9lbnRlcik7CitERUZJTkVfU01CM19DT1BZX1JB
TkdFX0RPTkVfRVZFTlQoY29weWNodW5rX2RvbmUpOworREVGSU5FX1NNQjNfQ09QWV9SQU5HRV9E
T05FX0VWRU5UKGNsb25lX2RvbmUpOworCisKIC8qIEZvciBsb2dnaW5nIHN1Y2Nlc3NmdWwgcmVh
ZCBvciB3cml0ZSAqLwogREVDTEFSRV9FVkVOVF9DTEFTUyhzbWIzX3J3X2RvbmVfY2xhc3MsCiAJ
VFBfUFJPVE8odW5zaWduZWQgaW50IHJyZXFfZGVidWdfaWQsCi0tIAoyLjQzLjAKCg==
--0000000000000ca1cd061e0145de--

