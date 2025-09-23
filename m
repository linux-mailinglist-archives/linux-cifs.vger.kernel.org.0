Return-Path: <linux-cifs+bounces-6393-lists+linux-cifs=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C8C4BB93BF8
	for <lists+linux-cifs@lfdr.de>; Tue, 23 Sep 2025 02:50:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77D1D7A5056
	for <lists+linux-cifs@lfdr.de>; Tue, 23 Sep 2025 00:48:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D4B6224F6;
	Tue, 23 Sep 2025 00:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W8ZFZKLr"
X-Original-To: linux-cifs@vger.kernel.org
Received: from mail-qv1-f41.google.com (mail-qv1-f41.google.com [209.85.219.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B8CD156C6A
	for <linux-cifs@vger.kernel.org>; Tue, 23 Sep 2025 00:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758588633; cv=none; b=rwfvZLZq7m5Afzf8e2sNKJklhrMnIyFc3SRbZsPL6EosXO6ODv3N5DcdiQ4tRoAjGD1pXO8EgUmlVyVfwB+TzG6jqjz0Iv41hL1nyifNs3vezz3fy62VWJtgthaU1Hvi58siHkjcgj1cvAN5oKyabI/iHifQKoVbL+dmNHCnxsk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758588633; c=relaxed/simple;
	bh=0IRaypG6kjraVDLxKm5HNx5q36OMIE1CYCoovQyDeDw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=tyfe8kMEkt0SBxlWKvQbJ7UVX6yAEcvziyFV2iyvi58GRaZXujc/VzpUWJnoUz5iE4v7VniCiBtr04Azd+mXSm7QF3OqiAtptncvTg1Nrq8Px70rByWM00ixdv2WK68t4FF45x1IBsoi3JqVcUTrZuxSwk+keZZjCV6GixPqlfM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W8ZFZKLr; arc=none smtp.client-ip=209.85.219.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f41.google.com with SMTP id 6a1803df08f44-78f15d5846dso56611856d6.0
        for <linux-cifs@vger.kernel.org>; Mon, 22 Sep 2025 17:50:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758588630; x=1759193430; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=jdP2OtWkp2lQ2fPom/2BpewZKCAl8tKABI3zwpUm4pU=;
        b=W8ZFZKLrTd1VyaHSGksCM9WgHMyClz6r8zH4AfKmXnzdTXFU3cccjTGlbu6ZJ/9psV
         G9POHc/qokyK7Xof49MD7+Wb3z3DdLqZajarOY7aqOdSmvyt+PkKTN5JY+j7kkFk6ZNV
         6JwiTOgTdxC8zOoOIzUq2j17Q9905c3qAchA+Qaq6UTbk+M7sxR4G/O5U7s/HF5x+Kft
         OWkgCDuoftPcmcHOJxYP3K7z6Bz3GSpHwUyQToy649E+7iZWJz0vQRpdPtFSjU1jL0hg
         oYfo+X1bWDM+pvL4Wf2b9KxP+Lj5ceusBWkyWY03l2sXO5+ZS9XanadUJmqnjpdbyVsJ
         iwBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758588630; x=1759193430;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=jdP2OtWkp2lQ2fPom/2BpewZKCAl8tKABI3zwpUm4pU=;
        b=uqUAxw4KeSTijmhvrAf+RSzbc+fWHCun7wwS+FNkwSAorBanJaUQig6Op/+T4kCfjJ
         xQeb9/oUnSuHTlaGzDMPK0pX8eHLr7kvhWg2MebIehhfZ3sIhvkORU8u3weI0TpKP2iC
         aP8RZvCgVEVBMow8tXtepXCDasN13HneNHr+4XEcn2AwayN+skDcQ3QhBIN2etUFeovq
         8ihkbZMz83KSpKgOzJpnZVDCiujzT6uZ0W0ZDPbI1+gFXtZcfkAGeraSb1nHGi2k6jfl
         e7K18hojjN/LE4z/f6Ek6VT7I+ccj9ZGtx8hmyK7pzTe/xUYYKzubUT32PoU6N/mwSUr
         nApA==
X-Gm-Message-State: AOJu0YzSwvL8bLKrmbtvSAfrBfV6dk2FRyXFnd01HCM5qI6z9kUxYotx
	ithwTWd5wZV4ltQKNAl6u5g1Iw2YkwBA6Q8acwJTDD3FbonrPMaOKG/ucAPZwllvVwhOo4DyNce
	cwb2JC7n1KtavtChQL0QIhheSpvrwKlj95Eeg
X-Gm-Gg: ASbGncun3g+Nglcru4dI/UHb1QfuMI+Z3WhFd2Yz9mdSEOJ1EHCAP+ye/2EWyVtivpu
	EI8Aaf7iDTOzptGWvZKff0IEbX3OI15Bd2CJzpfcr6KIAHbZJwilsGXSEwGrmKJnQyYE9XhxkuD
	+6pgZjbSSEqBqjcLr6xEe6kPbOZGUIOwvL76oABQNgzcZh39WNu2aS2UdvYfjWrnssQYDfYY399
	ssUIw+WLY3pgMkYrVivCPnv3JRhK2mNCyGyPWTJQdpBQKYLRawsfAhogQOApzHOZ0yWr8t+47Vj
	0fe/oSdx8WptszyUPYTSIOf0iL9U+i1Egx7EwugTW3rMWDgmLvk9N/JjLhOHCda5DyDFbwfedDh
	Hsqq8B0kuzVnJXN8xPYmIJw==
X-Google-Smtp-Source: AGHT+IHUhd58aMP0rgc02uM59oNIs9oeApj903Qn0h+Tpl83B0OpLvDs+zbCTyfmUkPC8c6oQnaXOtDvZUtLDkiCieM=
X-Received: by 2002:a05:6214:250c:b0:77b:69ec:79aa with SMTP id
 6a1803df08f44-7e6ff32e21dmr11932436d6.11.1758588629573; Mon, 22 Sep 2025
 17:50:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-cifs@vger.kernel.org
List-Id: <linux-cifs.vger.kernel.org>
List-Subscribe: <mailto:linux-cifs+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-cifs+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Steve French <smfrench@gmail.com>
Date: Mon, 22 Sep 2025 19:50:17 -0500
X-Gm-Features: AS18NWDjzuUu7Y-wr1tyaVfxk_fjEyWwC4XaQaCKjyZbe4wscwZzMF4ZpV__7sg
Message-ID: <CAH2r5muDbZTXitjyMP3LWnAHvZwdLKk5OigR8_fH849jz2ukQg@mail.gmail.com>
Subject: Fix for xfstest generic/637 (dir lease not updating for newly created
 file on same client)
To: CIFS <linux-cifs@vger.kernel.org>, 
	Henrique Carvalho <henrique.carvalho@suse.com>
Cc: Bharath S M <bharathsm@microsoft.com>
Content-Type: multipart/mixed; boundary="000000000000928b7d063f6d520a"

--000000000000928b7d063f6d520a
Content-Type: text/plain; charset="UTF-8"

Am testing this potential fix for the dir lease caching issue now.
See attached fix.  Additional testing and review would be very
helpful.

   smb client: fix dir lease bug with newly created file in cached dir

    Test generic/637 spotted a problem with create of a new file in a
    cached directory (by the same client) could cause cases where the
    new file does not show up properly in ls on that client until the
    lease times out.

    Fixes: 037e1bae588e ("smb: client: use ParentLeaseKey in cifs_do_create")
    Cc: stable@vger.kernel.org
    Signed-off-by: Bharath SM <bharathsm@microsoft.com>


-- 
Thanks,

Steve

--000000000000928b7d063f6d520a
Content-Type: text/x-patch; charset="US-ASCII"; 
	name="0001-smb-client-add-new-tracepoint-to-trace-lease-break-n.patch"
Content-Disposition: attachment; 
	filename="0001-smb-client-add-new-tracepoint-to-trace-lease-break-n.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_mfvu8ost0>
X-Attachment-Id: f_mfvu8ost0

RnJvbSAxODkzOTZlZjEyYzcwNDJmOTQ1ODIyYjNkZDdjMDI1OGNlMjY3YzEyIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBCaGFyYXRoIFNNIDxiaGFyYXRoc21AbWljcm9zb2Z0LmNvbT4K
RGF0ZTogVHVlLCAyIFNlcCAyMDI1IDIwOjEwOjI1ICswNTMwClN1YmplY3Q6IFtQQVRDSCAxLzJd
IHNtYjogY2xpZW50OiBhZGQgbmV3IHRyYWNlcG9pbnQgdG8gdHJhY2UgbGVhc2UgYnJlYWsKIG5v
dGlmaWNhdGlvbgoKQWRkIHNtYjNfbGVhc2VfYnJlYWtfZW50ZXIgdG8gdHJhY2UgbGVhc2UgYnJl
YWsgbm90aWZpY2F0aW9ucywKcmVjb3JkaW5nIGxlYXNlIHN0YXRlLCBmbGFncywgZXBvY2gsIGFu
ZCBsZWFzZSBrZXkuIEFsaWduCnNtYjNfbGVhc2Vfbm90X2ZvdW5kIHRvIHVzZSB0aGUgc2FtZSBw
YXlsb2FkIGFuZCBwcmludCBmb3JtYXQuCgpTaWduZWQtb2ZmLWJ5OiBCaGFyYXRoIFNNIDxiaGFy
YXRoc21AbWljcm9zb2Z0LmNvbT4KU2lnbmVkLW9mZi1ieTogU3RldmUgRnJlbmNoIDxzdGZyZW5j
aEBtaWNyb3NvZnQuY29tPgotLS0KIGZzL3NtYi9jbGllbnQvc21iMm1pc2MuYyB8IDE5ICsrKysr
KysrKysrLS0tLQogZnMvc21iL2NsaWVudC9zbWIycGR1LmMgIHwgIDQgKystLQogZnMvc21iL2Ns
aWVudC90cmFjZS5oICAgIHwgNTIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
Ky0tLQogMyBmaWxlcyBjaGFuZ2VkLCA2NiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQoK
ZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvc21iMm1pc2MuYyBiL2ZzL3NtYi9jbGllbnQvc21i
Mm1pc2MuYwppbmRleCBjZGRmMjczYzE0YWUuLjg5ZDkzM2I0YThiYyAxMDA2NDQKLS0tIGEvZnMv
c21iL2NsaWVudC9zbWIybWlzYy5jCisrKyBiL2ZzL3NtYi9jbGllbnQvc21iMm1pc2MuYwpAQCAt
NjE0LDYgKzYxNCwxNSBAQCBzbWIyX2lzX3ZhbGlkX2xlYXNlX2JyZWFrKGNoYXIgKmJ1ZmZlciwg
c3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2VydmVyKQogCXN0cnVjdCBjaWZzX3Rjb24gKnRjb247
CiAJc3RydWN0IGNpZnNfcGVuZGluZ19vcGVuICpvcGVuOwogCisJLyogVHJhY2UgcmVjZWlwdCBv
ZiBsZWFzZSBicmVhayByZXF1ZXN0IGZyb20gc2VydmVyICovCisJdHJhY2Vfc21iM19sZWFzZV9i
cmVha19lbnRlcihsZTMyX3RvX2NwdShyc3AtPkN1cnJlbnRMZWFzZVN0YXRlKSwKKwkJbGUzMl90
b19jcHUocnNwLT5GbGFncyksCisJCWxlMTZfdG9fY3B1KHJzcC0+RXBvY2gpLAorCQlsZTMyX3Rv
X2NwdShyc3AtPmhkci5JZC5TeW5jSWQuVHJlZUlkKSwKKwkJbGU2NF90b19jcHUocnNwLT5oZHIu
U2Vzc2lvbklkKSwKKwkJKigodTY0ICopcnNwLT5MZWFzZUtleSksCisJCSooKHU2NCAqKSZyc3At
PkxlYXNlS2V5WzhdKSk7CisKIAljaWZzX2RiZyhGWUksICJDaGVja2luZyBmb3IgbGVhc2UgYnJl
YWtcbiIpOwogCiAJLyogSWYgc2VydmVyIGlzIGEgY2hhbm5lbCwgc2VsZWN0IHRoZSBwcmltYXJ5
IGNoYW5uZWwgKi8KQEAgLTY2MCwxMCArNjY5LDEyIEBAIHNtYjJfaXNfdmFsaWRfbGVhc2VfYnJl
YWsoY2hhciAqYnVmZmVyLCBzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIpCiAJc3Bpbl91
bmxvY2soJmNpZnNfdGNwX3Nlc19sb2NrKTsKIAljaWZzX2RiZyhGWUksICJDYW4gbm90IHByb2Nl
c3MgbGVhc2UgYnJlYWsgLSBubyBsZWFzZSBtYXRjaGVkXG4iKTsKIAl0cmFjZV9zbWIzX2xlYXNl
X25vdF9mb3VuZChsZTMyX3RvX2NwdShyc3AtPkN1cnJlbnRMZWFzZVN0YXRlKSwKLQkJCQkgICBs
ZTMyX3RvX2NwdShyc3AtPmhkci5JZC5TeW5jSWQuVHJlZUlkKSwKLQkJCQkgICBsZTY0X3RvX2Nw
dShyc3AtPmhkci5TZXNzaW9uSWQpLAotCQkJCSAgICooKHU2NCAqKXJzcC0+TGVhc2VLZXkpLAot
CQkJCSAgICooKHU2NCAqKSZyc3AtPkxlYXNlS2V5WzhdKSk7CisJCQkJCSAgIGxlMzJfdG9fY3B1
KHJzcC0+RmxhZ3MpLAorCQkJCQkgICBsZTE2X3RvX2NwdShyc3AtPkVwb2NoKSwKKwkJCQkJICAg
bGUzMl90b19jcHUocnNwLT5oZHIuSWQuU3luY0lkLlRyZWVJZCksCisJCQkJCSAgIGxlNjRfdG9f
Y3B1KHJzcC0+aGRyLlNlc3Npb25JZCksCisJCQkJCSAgICooKHU2NCAqKXJzcC0+TGVhc2VLZXkp
LAorCQkJCQkgICAqKCh1NjQgKikmcnNwLT5MZWFzZUtleVs4XSkpOwogCiAJcmV0dXJuIGZhbHNl
OwogfQpkaWZmIC0tZ2l0IGEvZnMvc21iL2NsaWVudC9zbWIycGR1LmMgYi9mcy9zbWIvY2xpZW50
L3NtYjJwZHUuYwppbmRleCAyZGY5M2E3NWUzYjguLmMzYjlkM2Y2MjEwZiAxMDA2NDQKLS0tIGEv
ZnMvc21iL2NsaWVudC9zbWIycGR1LmMKKysrIGIvZnMvc21iL2NsaWVudC9zbWIycGR1LmMKQEAg
LTYxOTIsMTEgKzYxOTIsMTEgQEAgU01CMl9sZWFzZV9icmVhayhjb25zdCB1bnNpZ25lZCBpbnQg
eGlkLCBzdHJ1Y3QgY2lmc190Y29uICp0Y29uLAogCXBsZWFzZV9rZXlfaGlnaCA9IChfX3U2NCAq
KShsZWFzZV9rZXkrOCk7CiAJaWYgKHJjKSB7CiAJCWNpZnNfc3RhdHNfZmFpbF9pbmModGNvbiwg
U01CMl9PUExPQ0tfQlJFQUtfSEUpOwotCQl0cmFjZV9zbWIzX2xlYXNlX2VycihsZTMyX3RvX2Nw
dShsZWFzZV9zdGF0ZSksIHRjb24tPnRpZCwKKwkJdHJhY2Vfc21iM19sZWFzZV9hY2tfZXJyKGxl
MzJfdG9fY3B1KGxlYXNlX3N0YXRlKSwgdGNvbi0+dGlkLAogCQkJc2VzLT5TdWlkLCAqcGxlYXNl
X2tleV9sb3csICpwbGVhc2Vfa2V5X2hpZ2gsIHJjKTsKIAkJY2lmc19kYmcoRllJLCAiU2VuZCBl
cnJvciBpbiBMZWFzZSBCcmVhayA9ICVkXG4iLCByYyk7CiAJfSBlbHNlCi0JCXRyYWNlX3NtYjNf
bGVhc2VfZG9uZShsZTMyX3RvX2NwdShsZWFzZV9zdGF0ZSksIHRjb24tPnRpZCwKKwkJdHJhY2Vf
c21iM19sZWFzZV9hY2tfZG9uZShsZTMyX3RvX2NwdShsZWFzZV9zdGF0ZSksIHRjb24tPnRpZCwK
IAkJCXNlcy0+U3VpZCwgKnBsZWFzZV9rZXlfbG93LCAqcGxlYXNlX2tleV9oaWdoKTsKIAogCXJl
dHVybiByYzsKZGlmZiAtLWdpdCBhL2ZzL3NtYi9jbGllbnQvdHJhY2UuaCBiL2ZzL3NtYi9jbGll
bnQvdHJhY2UuaAppbmRleCA5M2U1YjJiYjlmMjguLmZlMGUwNzViYzYzYyAxMDA2NDQKLS0tIGEv
ZnMvc21iL2NsaWVudC90cmFjZS5oCisrKyBiL2ZzL3NtYi9jbGllbnQvdHJhY2UuaApAQCAtMTE3
MSw4ICsxMTcxLDU0IEBAIERFRklORV9FVkVOVChzbWIzX2xlYXNlX2RvbmVfY2xhc3MsIHNtYjNf
IyNuYW1lLCAgXAogCQlfX3U2NAlsZWFzZV9rZXlfaGlnaCksCVwKIAlUUF9BUkdTKGxlYXNlX3N0
YXRlLCB0aWQsIHNlc2lkLCBsZWFzZV9rZXlfbG93LCBsZWFzZV9rZXlfaGlnaCkpCiAKLURFRklO
RV9TTUIzX0xFQVNFX0RPTkVfRVZFTlQobGVhc2VfZG9uZSk7Ci1ERUZJTkVfU01CM19MRUFTRV9E
T05FX0VWRU5UKGxlYXNlX25vdF9mb3VuZCk7CitERUZJTkVfU01CM19MRUFTRV9ET05FX0VWRU5U
KGxlYXNlX2Fja19kb25lKTsKKy8qIFRyYWNlcG9pbnQgd2hlbiBhIGxlYXNlIGJyZWFrIHJlcXVl
c3QgaXMgcmVjZWl2ZWQvZW50ZXJlZCAoaW5jbHVkZXMgZXBvY2ggYW5kIGZsYWdzKSAqLworREVD
TEFSRV9FVkVOVF9DTEFTUyhzbWIzX2xlYXNlX2VudGVyX2NsYXNzLAorCVRQX1BST1RPKF9fdTMy
IGxlYXNlX3N0YXRlLAorCQlfX3UzMiBmbGFncywKKwkJX191MTYgZXBvY2gsCisJCV9fdTMyIHRp
ZCwKKwkJX191NjQgc2VzaWQsCisJCV9fdTY0IGxlYXNlX2tleV9sb3csCisJCV9fdTY0IGxlYXNl
X2tleV9oaWdoKSwKKwlUUF9BUkdTKGxlYXNlX3N0YXRlLCBmbGFncywgZXBvY2gsIHRpZCwgc2Vz
aWQsIGxlYXNlX2tleV9sb3csIGxlYXNlX2tleV9oaWdoKSwKKwlUUF9TVFJVQ1RfX2VudHJ5KAor
CQlfX2ZpZWxkKF9fdTMyLCBsZWFzZV9zdGF0ZSkKKwkJX19maWVsZChfX3UzMiwgZmxhZ3MpCisJ
CV9fZmllbGQoX191MTYsIGVwb2NoKQorCQlfX2ZpZWxkKF9fdTMyLCB0aWQpCisJCV9fZmllbGQo
X191NjQsIHNlc2lkKQorCQlfX2ZpZWxkKF9fdTY0LCBsZWFzZV9rZXlfbG93KQorCQlfX2ZpZWxk
KF9fdTY0LCBsZWFzZV9rZXlfaGlnaCkKKwkpLAorCVRQX2Zhc3RfYXNzaWduKAorCQlfX2VudHJ5
LT5sZWFzZV9zdGF0ZSA9IGxlYXNlX3N0YXRlOworCQlfX2VudHJ5LT5mbGFncyA9IGZsYWdzOwor
CQlfX2VudHJ5LT5lcG9jaCA9IGVwb2NoOworCQlfX2VudHJ5LT50aWQgPSB0aWQ7CisJCV9fZW50
cnktPnNlc2lkID0gc2VzaWQ7CisJCV9fZW50cnktPmxlYXNlX2tleV9sb3cgPSBsZWFzZV9rZXlf
bG93OworCQlfX2VudHJ5LT5sZWFzZV9rZXlfaGlnaCA9IGxlYXNlX2tleV9oaWdoOworCSksCisJ
VFBfcHJpbnRrKCJzaWQ9MHglbGx4IHRpZD0weCV4IGxlYXNlX2tleT0weCVsbHglbGx4IGxlYXNl
X3N0YXRlPTB4JXggZmxhZ3M9MHgleCBlcG9jaD0ldSIsCisJCV9fZW50cnktPnNlc2lkLCBfX2Vu
dHJ5LT50aWQsIF9fZW50cnktPmxlYXNlX2tleV9oaWdoLAorCQlfX2VudHJ5LT5sZWFzZV9rZXlf
bG93LCBfX2VudHJ5LT5sZWFzZV9zdGF0ZSwgX19lbnRyeS0+ZmxhZ3MsIF9fZW50cnktPmVwb2No
KQorKQorCisjZGVmaW5lIERFRklORV9TTUIzX0xFQVNFX0VOVEVSX0VWRU5UKG5hbWUpICAgICAg
ICBcCitERUZJTkVfRVZFTlQoc21iM19sZWFzZV9lbnRlcl9jbGFzcywgc21iM18jI25hbWUsICBc
CisJVFBfUFJPVE8oX191MzIgbGVhc2Vfc3RhdGUsICAgICAgICAgICAgXAorCQlfX3UzMiBmbGFn
cywgICAgICAgICAgICAgICBcCisJCV9fdTE2IGVwb2NoLCAgICAgICAgICAgICAgIFwKKwkJX191
MzIgdGlkLCAgICAgICAgICAgICAgICAgXAorCQlfX3U2NCBzZXNpZCwgICAgICAgICAgICAgICBc
CisJCV9fdTY0IGxlYXNlX2tleV9sb3csICAgICAgIFwKKwkJX191NjQgbGVhc2Vfa2V5X2hpZ2gp
LCAgICAgXAorCVRQX0FSR1MobGVhc2Vfc3RhdGUsIGZsYWdzLCBlcG9jaCwgdGlkLCBzZXNpZCwg
bGVhc2Vfa2V5X2xvdywgbGVhc2Vfa2V5X2hpZ2gpKQorCitERUZJTkVfU01CM19MRUFTRV9FTlRF
Ul9FVkVOVChsZWFzZV9icmVha19lbnRlcik7CisvKiBMZWFzZSBub3QgZm91bmQ6IHJldXNlIGxl
YXNlX2VudGVyIHBheWxvYWQgKGluY2x1ZGVzIGVwb2NoIGFuZCBmbGFncykgKi8KK0RFRklORV9T
TUIzX0xFQVNFX0VOVEVSX0VWRU5UKGxlYXNlX25vdF9mb3VuZCk7CiAKIERFQ0xBUkVfRVZFTlRf
Q0xBU1Moc21iM19sZWFzZV9lcnJfY2xhc3MsCiAJVFBfUFJPVE8oX191MzIJbGVhc2Vfc3RhdGUs
CkBAIC0xMjEzLDcgKzEyNTksNyBAQCBERUZJTkVfRVZFTlQoc21iM19sZWFzZV9lcnJfY2xhc3Ms
IHNtYjNfIyNuYW1lLCAgXAogCQlpbnQJcmMpLAkJCVwKIAlUUF9BUkdTKGxlYXNlX3N0YXRlLCB0
aWQsIHNlc2lkLCBsZWFzZV9rZXlfbG93LCBsZWFzZV9rZXlfaGlnaCwgcmMpKQogCi1ERUZJTkVf
U01CM19MRUFTRV9FUlJfRVZFTlQobGVhc2VfZXJyKTsKK0RFRklORV9TTUIzX0xFQVNFX0VSUl9F
VkVOVChsZWFzZV9hY2tfZXJyKTsKIAogREVDTEFSRV9FVkVOVF9DTEFTUyhzbWIzX2Nvbm5lY3Rf
Y2xhc3MsCiAJVFBfUFJPVE8oY2hhciAqaG9zdG5hbWUsCi0tIAoyLjQ4LjEKCg==
--000000000000928b7d063f6d520a--

