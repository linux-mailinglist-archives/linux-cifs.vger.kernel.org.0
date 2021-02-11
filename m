Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D015F318BC8
	for <lists+linux-cifs@lfdr.de>; Thu, 11 Feb 2021 14:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbhBKNQn (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 11 Feb 2021 08:16:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbhBKNOh (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 11 Feb 2021 08:14:37 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B5AC061574
        for <linux-cifs@vger.kernel.org>; Thu, 11 Feb 2021 05:13:54 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id x19so2791559ybe.0
        for <linux-cifs@vger.kernel.org>; Thu, 11 Feb 2021 05:13:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A1wv2RLkVtM00/wuqDOf0/Q/i0QsM1mzTiaCguSEzpQ=;
        b=Y4ymRLFRTa0OKcmc4CIJap7DkeHEA6Bh2YAVv+YTwKzQl60f8wtX+A98NHlqiQRlH1
         +oZjizCvqu5OYXN43LLZ0TRGYm1idnuuz6+lRvVrWMLB9jjXowNUs94zT2pfUsB+fuH4
         Pt4HfhTosRp/X0LffEUHxzN63lOk2IEPT2S3xHUYG+Eqgn0sFN5CucDC8eY6pOJSla4F
         WNfRtQuQfnS1zC0ncbErEUH6Gtesk8tQYPKRvdg97qkpKxWRDV0HCIWOjtRl7hy6LLQH
         dnieaFe8SvR/WxFaZOQntxKWUabq5f7xM3RcLaTTHMXZ1mdBF5Lpy2xpHm4JsxYXDjBp
         Vj8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A1wv2RLkVtM00/wuqDOf0/Q/i0QsM1mzTiaCguSEzpQ=;
        b=R3cY1BTXRVXdjtjPXrqxBI0G/FhM8Mw50Kku9Bn1mx8a06EIns/nfQJmNw/jijSr8k
         i+aLdxJxckRVBee+A7Wu8e5NsUZhWoMPXJsi0drTwC2hnMsWyADPHO/WjfG+rCm6rCwq
         lTr8alSmpUIWtSjtMfxmoJFtni4OGKnOkNpcz+/8jjixCPu05ia7IjNrZ5nyErxprpq5
         YxcFdiyNWKfMMY0yPeWfcN4fKdGOk1+mljVpyqC8G3ipo5PWkB6OkFyOrfGBX6d/UWw2
         abpiQvbLXVY0stkfgS1NPnpsLTLASgcy4WXil9NdaJ/4ls4htzGvWDstw0L/MVJDKJdZ
         3vXw==
X-Gm-Message-State: AOAM5335L77lhbvNe80v5/s51WPBvhKDVQoVgGwVIGNCYWSkxrEzGZ8i
        FBXPh0FPNOc5N+yC+d9rql79l29Uj4i1VPBKHlU=
X-Google-Smtp-Source: ABdhPJxw7bxHglIYS7cQhi45iVENUF56Eclbbb3EwkrtK+7RX+KUjad2sSl814MYWMYr4IbPgNQ5IUEZtkGftXcqv6s=
X-Received: by 2002:a25:380e:: with SMTP id f14mr11520594yba.185.1613049234123;
 Thu, 11 Feb 2021 05:13:54 -0800 (PST)
MIME-Version: 1.0
References: <CANT5p=o9Tw9E+o3PWytsNh5eDKxswJ+YPLZLWac7QwR_u-UJaw@mail.gmail.com>
 <87h7msnnme.fsf@suse.com> <CANT5p=qGTC4E4Rf_-t9xXOo4yf3W=xtk97J1jg-WRLhwf0juBA@mail.gmail.com>
 <87a6sjopsc.fsf@suse.com> <CANT5p=qQJwvF11MJpiuV7S1GpH9=HZ-g=hmfOV-a07N9xkYqnA@mail.gmail.com>
 <CAH2r5mv0TzWpYi38HtuVG2gtYvW60-RDOri3a1FUUtprn19Dzw@mail.gmail.com> <87lfbyn647.fsf@suse.com>
In-Reply-To: <87lfbyn647.fsf@suse.com>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Thu, 11 Feb 2021 05:13:42 -0800
Message-ID: <CANT5p=qJjeVk1HDhvaiAQSYH3mj-rNBNA-j2TAUnoqQVTOQ_Ww@mail.gmail.com>
Subject: Re: [PATCH 4/4] cifs: Reformat DebugData and index connections by conn_id.
To:     =?UTF-8?Q?Aur=C3=A9lien_Aptel?= <aaptel@suse.com>
Cc:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>,
        Pavel Shilovsky <piastryyy@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000009b4e3305bb0f4ac5"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--0000000000009b4e3305bb0f4ac5
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I noticed that the output looks rather odd when used with multichannel.
Attaching a revised patch with the changes.

Also attached a sample of new output.

Regards,
Shyam

On Mon, Feb 8, 2021 at 3:36 AM Aur=C3=A9lien Aptel <aaptel@suse.com> wrote:
>
> Steve French <smfrench@gmail.com> writes:
> > the multiline strings if they make it more readable are fine (probably
> > fine here), so can ignore
> >   "quoted string split across lines"
> > warning
>
> Agreed
>
> Reviewed-by: Aurelien Aptel <aaptel@suse.com>
>
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

--0000000000009b4e3305bb0f4ac5
Content-Type: text/plain; charset="US-ASCII"; name="debug.txt"
Content-Disposition: attachment; filename="debug.txt"
Content-Transfer-Encoding: base64
Content-ID: <f_kl0vumub1>
X-Attachment-Id: f_kl0vumub1

RGlzcGxheSBJbnRlcm5hbCBDSUZTIERhdGEgU3RydWN0dXJlcyBmb3IgRGVidWdnaW5nCi0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQpDSUZTIFZlcnNp
b24gMi4zMApGZWF0dXJlczogREZTLEZTQ0FDSEUsU1RBVFMsREVCVUcsQUxMT1dfSU5TRUNVUkVf
TEVHQUNZLFdFQUtfUFdfSEFTSCxDSUZTX1BPU0lYLFVQQ0FMTChTUE5FR08pLFhBVFRSLEFDTApD
SUZTTWF4QnVmU2l6ZTogMTYzODQKQWN0aXZlIFZGUyBSZXF1ZXN0czogNgoKU2VydmVyczogCjEp
IENvbm5lY3Rpb25JZDogMHgxIApOdW1iZXIgb2YgY3JlZGl0czogMzI2IERpYWxlY3QgMHgzMTEK
VENQIHN0YXR1czogMSBJbnN0YW5jZTogMQpMb2NhbCBVc2VycyBUbyBTZXJ2ZXI6IDEgU2VjTW9k
ZTogMHgxIFJlcSBPbiBXaXJlOiAwCkluIFNlbmQ6IDAgSW4gTWF4UmVxIFdhaXQ6IDAKCglTZXNz
aW9uczogCgkxKSBOYW1lOiAxMC4yMjkuMTU4LjM4IFVzZXM6IDEgQ2FwYWJpbGl0eTogMHgzMDAw
NzcJU2Vzc2lvbiBTdGF0dXM6IDEgCglTZWN1cml0eSB0eXBlOiBSYXdOVExNU1NQICBTZXNzaW9u
SWQ6IDB4N2MwMDE0MDAwMDQ5CglVc2VyOiAxMDAwIENyZWQgVXNlcjogMAoKCUV4dHJhIENoYW5u
ZWxzOiAzIAoKCQlDaGFubmVsOiAyIENvbm5lY3Rpb25JZDogMHg1CgkJTnVtYmVyIG9mIGNyZWRp
dHM6IDEzMCBEaWFsZWN0IDB4MzExCgkJVENQIHN0YXR1czogMSBJbnN0YW5jZTogMQoJCUxvY2Fs
IFVzZXJzIFRvIFNlcnZlcjogMSBTZWNNb2RlOiAweDEgUmVxIE9uIFdpcmU6IDAKCQlJbiBTZW5k
OiAwIEluIE1heFJlcSBXYWl0OiAwCgoJCUNoYW5uZWw6IDMgQ29ubmVjdGlvbklkOiAweDYKCQlO
dW1iZXIgb2YgY3JlZGl0czogMTMwIERpYWxlY3QgMHgzMTEKCQlUQ1Agc3RhdHVzOiAxIEluc3Rh
bmNlOiAxCgkJTG9jYWwgVXNlcnMgVG8gU2VydmVyOiAxIFNlY01vZGU6IDB4MSBSZXEgT24gV2ly
ZTogMAoJCUluIFNlbmQ6IDAgSW4gTWF4UmVxIFdhaXQ6IDAKCgkJQ2hhbm5lbDogNCBDb25uZWN0
aW9uSWQ6IDB4NwoJCU51bWJlciBvZiBjcmVkaXRzOiAxMzAgRGlhbGVjdCAweDMxMQoJCVRDUCBz
dGF0dXM6IDEgSW5zdGFuY2U6IDEKCQlMb2NhbCBVc2VycyBUbyBTZXJ2ZXI6IDEgU2VjTW9kZTog
MHgxIFJlcSBPbiBXaXJlOiAwCgkJSW4gU2VuZDogMCBJbiBNYXhSZXEgV2FpdDogMAoKCVNoYXJl
czogCgkwKSBJUEM6IFxcMTAuMjI5LjE1OC4zOFxJUEMkIE1vdW50czogMSBEZXZJbmZvOiAweDAg
QXR0cmlidXRlczogMHgwCglQYXRoQ29tcG9uZW50TWF4OiAwIFN0YXR1czogMSB0eXBlOiAwIFNl
cmlhbCBOdW1iZXI6IDB4MAoJU2hhcmUgQ2FwYWJpbGl0aWVzOiBOb25lCVNoYXJlIEZsYWdzOiAw
eDMwCgl0aWQ6IDB4MQlNYXhpbWFsIEFjY2VzczogMHgxMWYwMWZmCgoJMSkgXFwxMC4yMjkuMTU4
LjM4XHNoeWFtX3hmc3Rlc3RzIE1vdW50czogMSBEZXZJbmZvOiAweDIwMDIwIEF0dHJpYnV0ZXM6
IDB4YzcwNmZmCglQYXRoQ29tcG9uZW50TWF4OiAyNTUgU3RhdHVzOiAxIHR5cGU6IERJU0sgU2Vy
aWFsIE51bWJlcjogMHhkNDcyMzk3NQoJU2hhcmUgQ2FwYWJpbGl0aWVzOiBOb25lIEFsaWduZWQs
IFBhcnRpdGlvbiBBbGlnbmVkLAlTaGFyZSBGbGFnczogMHgwCgl0aWQ6IDB4NQlPcHRpbWFsIHNl
Y3RvciBzaXplOiAweDEwMDAJTWF4aW1hbCBBY2Nlc3M6IDB4MWYwMWZmCgoKCVNlcnZlciBpbnRl
cmZhY2VzOiA2CgkxKQlTcGVlZDogMTAwMDAwMDAwMDAgYnBzCgkJQ2FwYWJpbGl0aWVzOiByc3Mg
CgkJSVB2NDogMTY5LjI1NC4wLjEKCgkyKQlTcGVlZDogMTAwMDAwMDAwMDAgYnBzCgkJQ2FwYWJp
bGl0aWVzOiByc3MgCgkJSVB2NjogZmU4MDowMDAwOjAwMDA6MDAwMDoxOGI0OmYwZDY6MmNmOToy
MDBmCgoJMykJU3BlZWQ6IDEwMDAwMDAwMDAgYnBzCgkJQ2FwYWJpbGl0aWVzOiByc3MgCgkJSVB2
NjogZmU4MDowMDAwOjAwMDA6MDAwMDpkYzlhOjdmOGI6NTdhYToxNGFjCgoJNCkJU3BlZWQ6IDEw
MDAwMDAwMDAgYnBzCgkJQ2FwYWJpbGl0aWVzOiByc3MgCgkJSVB2NDogMTAuMjI5LjE1OC4zOAoJ
CVtDT05ORUNURURdCgoJNSkJU3BlZWQ6IDEwMDAwMDAwMDAgYnBzCgkJQ2FwYWJpbGl0aWVzOiBy
c3MgCgkJSVB2NDogMTY5LjI1NC4yMC4xNzIKCgk2KQlTcGVlZDogMTAwMDAwMDAwMCBicHMKCQlD
YXBhYmlsaXRpZXM6IHJzcyAKCQlJUHY2OiBmZTgwOjAwMDA6MDAwMDowMDAwOjAwODU6MWI3Mzpk
ZGE0OjI4NTEKCgoJTUlEczogCi0tCgo=
--0000000000009b4e3305bb0f4ac5
Content-Type: application/octet-stream; 
	name="0004-cifs-Reformat-DebugData-and-index-connections-by-con.patch"
Content-Disposition: attachment; 
	filename="0004-cifs-Reformat-DebugData-and-index-connections-by-con.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kl0vuavo0>
X-Attachment-Id: f_kl0vuavo0

RnJvbSA5OTJmZTJkOGMyNjdiNDRjNWNmZmQyY2U1ZjEyNzVlOWY1ZWJiY2FhIE1vbiBTZXAgMTcg
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
ZnQuY29tPgotLS0KIGZzL2NpZnMvY2lmc19kZWJ1Zy5jIHwgMTE3ICsrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA2OCBpbnNlcnRpb25z
KCspLCA0OSBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9mcy9jaWZzL2NpZnNfZGVidWcuYyBi
L2ZzL2NpZnMvY2lmc19kZWJ1Zy5jCmluZGV4IGIyMzFkY2YxZDFmOS4uMzcwY2M4OGEzZDAyIDEw
MDY0NAotLS0gYS9mcy9jaWZzL2NpZnNfZGVidWcuYworKysgYi9mcy9jaWZzL2NpZnNfZGVidWcu
YwpAQCAtMTMzLDExICsxMzMsMTIgQEAgY2lmc19kdW1wX2NoYW5uZWwoc3RydWN0IHNlcV9maWxl
ICptLCBpbnQgaSwgc3RydWN0IGNpZnNfY2hhbiAqY2hhbikKIHsKIAlzdHJ1Y3QgVENQX1NlcnZl
cl9JbmZvICpzZXJ2ZXIgPSBjaGFuLT5zZXJ2ZXI7CiAKLQlzZXFfcHJpbnRmKG0sICJcdFx0Q2hh
bm5lbCAlZCBOdW1iZXIgb2YgY3JlZGl0czogJWQgRGlhbGVjdCAweCV4ICIKLQkJICAgIlRDUCBz
dGF0dXM6ICVkIEluc3RhbmNlOiAlZCBMb2NhbCBVc2VycyBUbyBTZXJ2ZXI6ICVkICIKLQkJICAg
IlNlY01vZGU6IDB4JXggUmVxIE9uIFdpcmU6ICVkIEluIFNlbmQ6ICVkICIKLQkJICAgIkluIE1h
eFJlcSBXYWl0OiAlZFxuIiwKLQkJICAgaSsxLAorCXNlcV9wcmludGYobSwgIlxuXG5cdFx0Q2hh
bm5lbDogJWQgQ29ubmVjdGlvbklkOiAweCVsbHgiCisJCSAgICJcblx0XHROdW1iZXIgb2YgY3Jl
ZGl0czogJWQgRGlhbGVjdCAweCV4IgorCQkgICAiXG5cdFx0VENQIHN0YXR1czogJWQgSW5zdGFu
Y2U6ICVkIgorCQkgICAiXG5cdFx0TG9jYWwgVXNlcnMgVG8gU2VydmVyOiAlZCBTZWNNb2RlOiAw
eCV4IFJlcSBPbiBXaXJlOiAlZCIKKwkJICAgIlxuXHRcdEluIFNlbmQ6ICVkIEluIE1heFJlcSBX
YWl0OiAlZCIsCisJCSAgIGkrMSwgc2VydmVyLT5jb25uX2lkLAogCQkgICBzZXJ2ZXItPmNyZWRp
dHMsCiAJCSAgIHNlcnZlci0+ZGlhbGVjdCwKIAkJICAgc2VydmVyLT50Y3BTdGF0dXMsCkBAIC0y
MjcsNyArMjI4LDcgQEAgc3RhdGljIGludCBjaWZzX2RlYnVnX2RhdGFfcHJvY19zaG93KHN0cnVj
dCBzZXFfZmlsZSAqbSwgdm9pZCAqdikKIAlzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXI7
CiAJc3RydWN0IGNpZnNfc2VzICpzZXM7CiAJc3RydWN0IGNpZnNfdGNvbiAqdGNvbjsKLQlpbnQg
aSwgajsKKwlpbnQgYywgaSwgajsKIAogCXNlcV9wdXRzKG0sCiAJCSAgICAiRGlzcGxheSBJbnRl
cm5hbCBDSUZTIERhdGEgU3RydWN0dXJlcyBmb3IgRGVidWdnaW5nXG4iCkBAIC0yNzUsMTQgKzI3
NiwyMyBAQCBzdGF0aWMgaW50IGNpZnNfZGVidWdfZGF0YV9wcm9jX3Nob3coc3RydWN0IHNlcV9m
aWxlICptLCB2b2lkICp2KQogCXNlcV9wdXRjKG0sICdcbicpOwogCXNlcV9wcmludGYobSwgIkNJ
RlNNYXhCdWZTaXplOiAlZFxuIiwgQ0lGU01heEJ1ZlNpemUpOwogCXNlcV9wcmludGYobSwgIkFj
dGl2ZSBWRlMgUmVxdWVzdHM6ICVkXG4iLCBHbG9iYWxUb3RhbEFjdGl2ZVhpZCk7Ci0Jc2VxX3By
aW50ZihtLCAiU2VydmVyczoiKTsKIAotCWkgPSAwOworCXNlcV9wcmludGYobSwgIlxuU2VydmVy
czogIik7CisKKwljID0gMDsKIAlzcGluX2xvY2soJmNpZnNfdGNwX3Nlc19sb2NrKTsKIAlsaXN0
X2Zvcl9lYWNoKHRtcDEsICZjaWZzX3RjcF9zZXNfbGlzdCkgewogCQlzZXJ2ZXIgPSBsaXN0X2Vu
dHJ5KHRtcDEsIHN0cnVjdCBUQ1BfU2VydmVyX0luZm8sCiAJCQkJICAgIHRjcF9zZXNfbGlzdCk7
CiAKKwkJLyogY2hhbm5lbCBpbmZvIHdpbGwgYmUgcHJpbnRlZCBhcyBhIHBhcnQgb2Ygc2Vzc2lv
bnMgYmVsb3cgKi8KKwkJaWYgKHNlcnZlci0+aXNfY2hhbm5lbCkKKwkJCWNvbnRpbnVlOworCisJ
CWMrKzsKKwkJc2VxX3ByaW50ZihtLCAiXG4lZCkgQ29ubmVjdGlvbklkOiAweCVsbHggIiwKKwkJ
CWMsIHNlcnZlci0+Y29ubl9pZCk7CisKICNpZmRlZiBDT05GSUdfQ0lGU19TTUJfRElSRUNUCiAJ
CWlmICghc2VydmVyLT5yZG1hKQogCQkJZ290byBza2lwX3JkbWE7CkBAIC0zNjIsNDYgKzM3Miw0
OCBAQCBzdGF0aWMgaW50IGNpZnNfZGVidWdfZGF0YV9wcm9jX3Nob3coc3RydWN0IHNlcV9maWxl
ICptLCB2b2lkICp2KQogCQlpZiAoc2VydmVyLT5wb3NpeF9leHRfc3VwcG9ydGVkKQogCQkJc2Vx
X3ByaW50ZihtLCAiIHBvc2l4Iik7CiAKLQkJaSsrOworCQlpZiAoc2VydmVyLT5yZG1hKQorCQkJ
c2VxX3ByaW50ZihtLCAiXG5SRE1BICIpOworCQlzZXFfcHJpbnRmKG0sICJcblRDUCBzdGF0dXM6
ICVkIEluc3RhbmNlOiAlZCIKKwkJCQkiXG5Mb2NhbCBVc2VycyBUbyBTZXJ2ZXI6ICVkIFNlY01v
ZGU6IDB4JXggUmVxIE9uIFdpcmU6ICVkIiwKKwkJCQlzZXJ2ZXItPnRjcFN0YXR1cywKKwkJCQlz
ZXJ2ZXItPnJlY29ubmVjdF9pbnN0YW5jZSwKKwkJCQlzZXJ2ZXItPnNydl9jb3VudCwKKwkJCQlz
ZXJ2ZXItPnNlY19tb2RlLCBpbl9mbGlnaHQoc2VydmVyKSk7CisKKwkJc2VxX3ByaW50ZihtLCAi
XG5JbiBTZW5kOiAlZCBJbiBNYXhSZXEgV2FpdDogJWQiLAorCQkJCWF0b21pY19yZWFkKCZzZXJ2
ZXItPmluX3NlbmQpLAorCQkJCWF0b21pY19yZWFkKCZzZXJ2ZXItPm51bV93YWl0ZXJzKSk7CisK
KwkJc2VxX3ByaW50ZihtLCAiXG5cblx0U2Vzc2lvbnM6ICIpOworCQlpID0gMDsKIAkJbGlzdF9m
b3JfZWFjaCh0bXAyLCAmc2VydmVyLT5zbWJfc2VzX2xpc3QpIHsKIAkJCXNlcyA9IGxpc3RfZW50
cnkodG1wMiwgc3RydWN0IGNpZnNfc2VzLAogCQkJCQkgc21iX3Nlc19saXN0KTsKKwkJCWkrKzsK
IAkJCWlmICgoc2VzLT5zZXJ2ZXJEb21haW4gPT0gTlVMTCkgfHwKIAkJCQkoc2VzLT5zZXJ2ZXJP
UyA9PSBOVUxMKSB8fAogCQkJCShzZXMtPnNlcnZlck5PUyA9PSBOVUxMKSkgewotCQkJCXNlcV9w
cmludGYobSwgIlxuJWQpIE5hbWU6ICVzIFVzZXM6ICVkIENhcGFiaWxpdHk6IDB4JXhcdFNlc3Np
b24gU3RhdHVzOiAlZCAiLAorCQkJCXNlcV9wcmludGYobSwgIlxuXHQlZCkgTmFtZTogJXMgVXNl
czogJWQgQ2FwYWJpbGl0eTogMHgleFx0U2Vzc2lvbiBTdGF0dXM6ICVkICIsCiAJCQkJCWksIHNl
cy0+c2VydmVyTmFtZSwgc2VzLT5zZXNfY291bnQsCiAJCQkJCXNlcy0+Y2FwYWJpbGl0aWVzLCBz
ZXMtPnN0YXR1cyk7CiAJCQkJaWYgKHNlcy0+c2Vzc2lvbl9mbGFncyAmIFNNQjJfU0VTU0lPTl9G
TEFHX0lTX0dVRVNUKQotCQkJCQlzZXFfcHJpbnRmKG0sICJHdWVzdFx0Iik7CisJCQkJCXNlcV9w
cmludGYobSwgIkd1ZXN0ICIpOwogCQkJCWVsc2UgaWYgKHNlcy0+c2Vzc2lvbl9mbGFncyAmIFNN
QjJfU0VTU0lPTl9GTEFHX0lTX05VTEwpCi0JCQkJCXNlcV9wcmludGYobSwgIkFub255bW91c1x0
Iik7CisJCQkJCXNlcV9wcmludGYobSwgIkFub255bW91cyAiKTsKIAkJCX0gZWxzZSB7CiAJCQkJ
c2VxX3ByaW50ZihtLAotCQkJCSAgICAiXG4lZCkgTmFtZTogJXMgIERvbWFpbjogJXMgVXNlczog
JWQgT1M6IgotCQkJCSAgICAiICVzXG5cdE5PUzogJXNcdENhcGFiaWxpdHk6IDB4JXhcblx0U01C
IgotCQkJCSAgICAiIHNlc3Npb24gc3RhdHVzOiAlZCAiLAorCQkJCSAgICAiXG5cdCVkKSBOYW1l
OiAlcyAgRG9tYWluOiAlcyBVc2VzOiAlZCBPUzogJXMgIgorCQkJCSAgICAiXG5cdE5PUzogJXNc
dENhcGFiaWxpdHk6IDB4JXgiCisJCQkJCSJcblx0U01CIHNlc3Npb24gc3RhdHVzOiAlZCAiLAog
CQkJCWksIHNlcy0+c2VydmVyTmFtZSwgc2VzLT5zZXJ2ZXJEb21haW4sCiAJCQkJc2VzLT5zZXNf
Y291bnQsIHNlcy0+c2VydmVyT1MsIHNlcy0+c2VydmVyTk9TLAogCQkJCXNlcy0+Y2FwYWJpbGl0
aWVzLCBzZXMtPnN0YXR1cyk7CiAJCQl9CiAKLQkJCXNlcV9wcmludGYobSwiU2VjdXJpdHkgdHlw
ZTogJXNcbiIsCisJCQlzZXFfcHJpbnRmKG0sICJcblx0U2VjdXJpdHkgdHlwZTogJXMgIiwKIAkJ
CQlnZXRfc2VjdXJpdHlfdHlwZV9zdHIoc2VydmVyLT5vcHMtPnNlbGVjdF9zZWN0eXBlKHNlcnZl
ciwgc2VzLT5zZWN0eXBlKSkpOwogCi0JCQlpZiAoc2VydmVyLT5yZG1hKQotCQkJCXNlcV9wcmlu
dGYobSwgIlJETUFcblx0Iik7Ci0JCQlzZXFfcHJpbnRmKG0sICJUQ1Agc3RhdHVzOiAlZCBJbnN0
YW5jZTogJWRcblx0TG9jYWwgVXNlcnMgVG8gIgotCQkJCSAgICJTZXJ2ZXI6ICVkIFNlY01vZGU6
IDB4JXggUmVxIE9uIFdpcmU6ICVkIiwKLQkJCQkgICBzZXJ2ZXItPnRjcFN0YXR1cywKLQkJCQkg
ICBzZXJ2ZXItPnJlY29ubmVjdF9pbnN0YW5jZSwKLQkJCQkgICBzZXJ2ZXItPnNydl9jb3VudCwK
LQkJCQkgICBzZXJ2ZXItPnNlY19tb2RlLCBpbl9mbGlnaHQoc2VydmVyKSk7Ci0KLQkJCXNlcV9w
cmludGYobSwgIiBJbiBTZW5kOiAlZCBJbiBNYXhSZXEgV2FpdDogJWQiLAotCQkJCWF0b21pY19y
ZWFkKCZzZXJ2ZXItPmluX3NlbmQpLAotCQkJCWF0b21pY19yZWFkKCZzZXJ2ZXItPm51bV93YWl0
ZXJzKSk7Ci0KIAkJCS8qIGR1bXAgc2Vzc2lvbiBpZCBoZWxwZnVsIGZvciB1c2Ugd2l0aCBuZXR3
b3JrIHRyYWNlICovCiAJCQlzZXFfcHJpbnRmKG0sICIgU2Vzc2lvbklkOiAweCVsbHgiLCBzZXMt
PlN1aWQpOwogCQkJaWYgKHNlcy0+c2Vzc2lvbl9mbGFncyAmIFNNQjJfU0VTU0lPTl9GTEFHX0VO
Q1JZUFRfREFUQSkKQEAgLTQxNCwxMyArNDI2LDEzIEBAIHN0YXRpYyBpbnQgY2lmc19kZWJ1Z19k
YXRhX3Byb2Nfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHZvaWQgKnYpCiAJCQkJICAgZnJvbV9r
dWlkKCZpbml0X3VzZXJfbnMsIHNlcy0+Y3JlZF91aWQpKTsKIAogCQkJaWYgKHNlcy0+Y2hhbl9j
b3VudCA+IDEpIHsKLQkJCQlzZXFfcHJpbnRmKG0sICJcblxuXHRFeHRyYSBDaGFubmVsczogJXp1
XG4iLAorCQkJCXNlcV9wcmludGYobSwgIlxuXG5cdEV4dHJhIENoYW5uZWxzOiAlenUgIiwKIAkJ
CQkJICAgc2VzLT5jaGFuX2NvdW50LTEpOwogCQkJCWZvciAoaiA9IDE7IGogPCBzZXMtPmNoYW5f
Y291bnQ7IGorKykKIAkJCQkJY2lmc19kdW1wX2NoYW5uZWwobSwgaiwgJnNlcy0+Y2hhbnNbal0p
OwogCQkJfQogCi0JCQlzZXFfcHV0cyhtLCAiXG5cblx0U2hhcmVzOiIpOworCQkJc2VxX3B1dHMo
bSwgIlxuXG5cdFNoYXJlczogIik7CiAJCQlqID0gMDsKIAogCQkJc2VxX3ByaW50ZihtLCAiXG5c
dCVkKSBJUEM6ICIsIGopOwpAQCAtNDM3LDM4ICs0NDksNDUgQEAgc3RhdGljIGludCBjaWZzX2Rl
YnVnX2RhdGFfcHJvY19zaG93KHN0cnVjdCBzZXFfZmlsZSAqbSwgdm9pZCAqdikKIAkJCQljaWZz
X2RlYnVnX3Rjb24obSwgdGNvbik7CiAJCQl9CiAKLQkJCXNlcV9wdXRzKG0sICJcblx0TUlEczpc
biIpOwotCi0JCQlzcGluX2xvY2soJkdsb2JhbE1pZF9Mb2NrKTsKLQkJCWxpc3RfZm9yX2VhY2go
dG1wMywgJnNlcnZlci0+cGVuZGluZ19taWRfcSkgewotCQkJCW1pZF9lbnRyeSA9IGxpc3RfZW50
cnkodG1wMywgc3RydWN0IG1pZF9xX2VudHJ5LAotCQkJCQlxaGVhZCk7Ci0JCQkJc2VxX3ByaW50
ZihtLCAiXHRTdGF0ZTogJWQgY29tOiAlZCBwaWQ6IgotCQkJCQkgICAgICAiICVkIGNiZGF0YTog
JXAgbWlkICVsbHVcbiIsCi0JCQkJCSAgICAgIG1pZF9lbnRyeS0+bWlkX3N0YXRlLAotCQkJCQkg
ICAgICBsZTE2X3RvX2NwdShtaWRfZW50cnktPmNvbW1hbmQpLAotCQkJCQkgICAgICBtaWRfZW50
cnktPnBpZCwKLQkJCQkJICAgICAgbWlkX2VudHJ5LT5jYWxsYmFja19kYXRhLAotCQkJCQkgICAg
ICBtaWRfZW50cnktPm1pZCk7Ci0JCQl9Ci0JCQlzcGluX3VubG9jaygmR2xvYmFsTWlkX0xvY2sp
OwotCiAJCQlzcGluX2xvY2soJnNlcy0+aWZhY2VfbG9jayk7CiAJCQlpZiAoc2VzLT5pZmFjZV9j
b3VudCkKLQkJCQlzZXFfcHJpbnRmKG0sICJcblx0U2VydmVyIGludGVyZmFjZXM6ICV6dVxuIiwK
KwkJCQlzZXFfcHJpbnRmKG0sICJcblxuXHRTZXJ2ZXIgaW50ZXJmYWNlczogJXp1IiwKIAkJCQkJ
ICAgc2VzLT5pZmFjZV9jb3VudCk7CiAJCQlmb3IgKGogPSAwOyBqIDwgc2VzLT5pZmFjZV9jb3Vu
dDsgaisrKSB7CiAJCQkJc3RydWN0IGNpZnNfc2VydmVyX2lmYWNlICppZmFjZTsKIAogCQkJCWlm
YWNlID0gJnNlcy0+aWZhY2VfbGlzdFtqXTsKLQkJCQlzZXFfcHJpbnRmKG0sICJcdCVkKSIsIGop
OworCQkJCXNlcV9wcmludGYobSwgIlxuXHQlZCkiLCBqKzEpOwogCQkJCWNpZnNfZHVtcF9pZmFj
ZShtLCBpZmFjZSk7CiAJCQkJaWYgKGlzX3Nlc191c2luZ19pZmFjZShzZXMsIGlmYWNlKSkKIAkJ
CQkJc2VxX3B1dHMobSwgIlx0XHRbQ09OTkVDVEVEXVxuIik7CiAJCQl9CisJCQlpZiAoaiA9PSAw
KQorCQkJCXNlcV9wcmludGYobSwgIlxuXHRbTk9ORV0iKTsKIAkJCXNwaW5fdW5sb2NrKCZzZXMt
PmlmYWNlX2xvY2spOwogCQl9CisJCWlmIChpID09IDApCisJCQlzZXFfcHJpbnRmKG0sICJcblx0
XHRbTk9ORV0iKTsKKworCQlzZXFfcHV0cyhtLCAiXG5cblx0TUlEczogIik7CisJCXNwaW5fbG9j
aygmR2xvYmFsTWlkX0xvY2spOworCQlsaXN0X2Zvcl9lYWNoKHRtcDMsICZzZXJ2ZXItPnBlbmRp
bmdfbWlkX3EpIHsKKwkJCW1pZF9lbnRyeSA9IGxpc3RfZW50cnkodG1wMywgc3RydWN0IG1pZF9x
X2VudHJ5LAorCQkJCQlxaGVhZCk7CisJCQlzZXFfcHJpbnRmKG0sICJcblx0U3RhdGU6ICVkIGNv
bTogJWQgcGlkOiIKKwkJCQkJIiAlZCBjYmRhdGE6ICVwIG1pZCAlbGx1XG4iLAorCQkJCQltaWRf
ZW50cnktPm1pZF9zdGF0ZSwKKwkJCQkJbGUxNl90b19jcHUobWlkX2VudHJ5LT5jb21tYW5kKSwK
KwkJCQkJbWlkX2VudHJ5LT5waWQsCisJCQkJCW1pZF9lbnRyeS0+Y2FsbGJhY2tfZGF0YSwKKwkJ
CQkJbWlkX2VudHJ5LT5taWQpOworCQl9CisJCXNwaW5fdW5sb2NrKCZHbG9iYWxNaWRfTG9jayk7
CisJCXNlcV9wcmludGYobSwgIlxuLS1cbiIpOwogCX0KKwlpZiAoYyA9PSAwKQorCQlzZXFfcHJp
bnRmKG0sICJcblx0W05PTkVdIik7CisKIAlzcGluX3VubG9jaygmY2lmc190Y3Bfc2VzX2xvY2sp
OwogCXNlcV9wdXRjKG0sICdcbicpOwogCi0tIAoyLjI1LjEKCg==
--0000000000009b4e3305bb0f4ac5--
