Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54384315F46
	for <lists+linux-cifs@lfdr.de>; Wed, 10 Feb 2021 07:16:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230473AbhBJGQO (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 10 Feb 2021 01:16:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231587AbhBJGJv (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 10 Feb 2021 01:09:51 -0500
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4FCEC061574
        for <linux-cifs@vger.kernel.org>; Tue,  9 Feb 2021 22:09:00 -0800 (PST)
Received: by mail-yb1-xb30.google.com with SMTP id e132so882884ybh.8
        for <linux-cifs@vger.kernel.org>; Tue, 09 Feb 2021 22:09:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=LkHim/I1Hau/gpEb2wqwN8nElWtjfJt2Ymu2jxM2d7o=;
        b=XZkApYCf/IpBg9YcCUOeJ222DwJrC5G3kQm282KB2IVS6hES2Vs2RwrIED0r8xYZvx
         YTlTRpb5u9y37Re5vCmK5xHG2nFeVe7FCQpM+kUBhALWvt1WUHK3dla7TacJqE7Nvwuy
         xJu44HUOTw52jf4CkmcX+18AI5o9Mb7vxf+t06b278ITnh4PEUjFpqc0jpCmjsIH9cXc
         5GfiR2fRviEstDk8c/qkYlddEfQliQoASbP19WfZXJQhoXy3RfPgttIvpZfoa7pelwLz
         y4QrK8ieFpu0reAPRRMHDQojOP0zIEVmh1KLh9Euq12m9u4rxiqfqTSo6T3+7iL4GuP+
         cK4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=LkHim/I1Hau/gpEb2wqwN8nElWtjfJt2Ymu2jxM2d7o=;
        b=uaZMAJzIPovqhJzHIiYbstX8vri9PiRPd0wF0PYxlj/h/odH4obZtKws44QPy+1xAp
         l3QWTOuCIZ1F+Nakbgo81tLU5HqUlw1i1MYJnmlRlsxFQgfOL7xq4y8RLr3SpTpV+ftN
         nS0CK8roZViMLxSVjJD/K1qEHjlBRNiD/X/+VEv/xgYaFqQxg8YmBRWdVmgMHMw9WQ00
         1KEqVSXFkhNmHd8c0hoAVkuRlFNLmqdpmvuGiJE0d1/o59oCik9cJWS38dkEixoFqxR9
         wjaxOD1fdZ2/AatQjHtmW4By/HJffJhV8UdP1VPTmmsmugx5b/SGHiA8n/2tJHO3+CJN
         sYYQ==
X-Gm-Message-State: AOAM531uicDbvcCwCdlfRGltgYgGsIbb4ZkYEjxS3jKkJ7T/csUD+Rl0
        kTCX/nScVOal4DCupMqTbI7RQ+Frl3bwJVgKoGHolHAvsWU=
X-Google-Smtp-Source: ABdhPJzAjVXq+ebyDKgH4tBNxTmvxf7PTwOUDoXEAZFIoA7Va5w6cyvNGSUges7GGhV6IAQuXFZEGv1Eb4fmvFY9rQ0=
X-Received: by 2002:a25:83cc:: with SMTP id v12mr2095212ybm.293.1612937340140;
 Tue, 09 Feb 2021 22:09:00 -0800 (PST)
MIME-Version: 1.0
References: <CANT5p=rUagVpf1aKEDVqL-DiY2+ceYUE7mLD1pGrajN-uopRig@mail.gmail.com>
 <CANT5p=og=n36LmWroyomC7nNdJvVHFpSQqLXtH0XGY1OzvVsCQ@mail.gmail.com>
 <CANT5p=pCdVzrPNx2-6wL7_ewGMSo2Q8y8BM2dRD=5aGFk4TrPQ@mail.gmail.com>
 <CANT5p=qRhFnG1qPsWhinOGE3Y+9ie=gaQ71YQXiEJr5y4v5HBQ@mail.gmail.com> <CAKywueRNLiENE2E5qhaJqgjdsEYYj5c0Br=+YKvnEig7yQtB-w@mail.gmail.com>
In-Reply-To: <CAKywueRNLiENE2E5qhaJqgjdsEYYj5c0Br=+YKvnEig7yQtB-w@mail.gmail.com>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Tue, 9 Feb 2021 22:08:49 -0800
Message-ID: <CANT5p=o0dV1SK2caUYUq_5_R9a=V7WqrkuCxqinTP=iSAbKcGQ@mail.gmail.com>
Subject: Re: [PATCH 3/4] cifs: Identify a connection by a conn_id.
To:     Pavel Shilovsky <piastryyy@gmail.com>
Cc:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000345f3405baf53d77"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

--000000000000345f3405baf53d77
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Pavel,

Thanks for the review. Attaching updated patch.

Regards,
Shyam

On Tue, Feb 9, 2021 at 12:05 PM Pavel Shilovsky <piastryyy@gmail.com> wrote=
:
>
> 108         if (server->tcpStatus =3D=3D CifsNeedReconnect
> 109             || server->tcpStatus =3D=3D CifsExiting)
> 110                 return;
>
> If you remove this check then the dmesg log may be populated by below
> VFS logs. THe intent of this check was to avoid printing them because
> they don't make sense in reconnect/umount situations and may confuse
> users.
>
> 111
> 112         switch (rc) {
> 113         case -1:
> 114                 /* change_conf hasn't been executed */
> 115                 break;
> 116         case 0:
> 117                 cifs_server_dbg(VFS, "Possible client or server
> bug - zero credits\n");
> 118                 break;
> 119         case 1:
> 120                 cifs_server_dbg(VFS, "disabling echoes and oplocks\n"=
);
> 121                 break;
> 122         case 2:
> 123                 cifs_dbg(FYI, "disabling oplocks\n");
> 124                 break;
> 125         default:
> 126                 trace_smb3_add_credits(server->CurrentMid,
> 127                         server->hostname, rc, add);
> 128                 cifs_dbg(FYI, "%s: added %u credits total=3D%d\n",
> __func__, add, rc);
> 129         }
>
>
> I would also suggest to rename sin_flight to just "in_flight" :)
>
> --
> Best regards,
> Pavel Shilovsky
>
> =D1=81=D0=B1, 6 =D1=84=D0=B5=D0=B2=D1=80. 2021 =D0=B3. =D0=B2 20:18, Shya=
m Prasad N <nspmangalore@gmail.com>:
> >
> > Forgot to attach again. :)
> >
> > On Sat, Feb 6, 2021 at 8:18 PM Shyam Prasad N <nspmangalore@gmail.com> =
wrote:
> > >
> > > Here's an updated version with some formatting changes per checkpatch=
.pl.
> > > @Pavel Shilovsky @ronnie sahlberg Hoping that one of you can review
> > > this. Particularly the above point.
> > >
> > > Regards,
> > > Shyam
> > >
> > > On Thu, Feb 4, 2021 at 12:13 AM Shyam Prasad N <nspmangalore@gmail.co=
m> wrote:
> > > >
> > > > @@ -97,17 +99,25 @@ smb2_add_credits(struct TCP_Server_Info *server=
,
> > > > -       if (server->tcpStatus =3D=3D CifsNeedReconnect
> > > > -           || server->tcpStatus =3D=3D CifsExiting)
> > > > -               return;
> > > >
> > > > @Pavel Shilovsky This check prevented a tracepoint from getting
> > > > printed. I do not see much value in these lines, since all we do is
> > > > print the tracepoint and exit. Hence removing it. Please let me kno=
w
> > > > if that is not okay.
> > > >
> > > > On Thu, Feb 4, 2021 at 12:09 AM Shyam Prasad N <nspmangalore@gmail.=
com> wrote:
> > > > >
> > > > > --
> > > > > Regards,
> > > > > Shyam
> > > >
> > > >
> > > >
> > > > --
> > > > Regards,
> > > > Shyam
> > >
> > >
> > >
> > > --
> > > Regards,
> > > Shyam
> >
> >
> >
> > --
> > Regards,
> > Shyam



--=20
Regards,
Shyam

--000000000000345f3405baf53d77
Content-Type: application/octet-stream; 
	name="0003-cifs-Identify-a-connection-by-a-conn_id.patch"
Content-Disposition: attachment; 
	filename="0003-cifs-Identify-a-connection-by-a-conn_id.patch"
Content-Transfer-Encoding: base64
Content-ID: <f_kkz18lsg0>
X-Attachment-Id: f_kkz18lsg0

RnJvbSA1MDEyYmZmNzIyYTlmMmE0NDk5OTQzNWJjMmQzMjJjMDc0ODFkMGFkIE1vbiBTZXAgMTcg
MDA6MDA6MDAgMjAwMQpGcm9tOiBTaHlhbSBQcmFzYWQgTiA8c3ByYXNhZEBtaWNyb3NvZnQuY29t
PgpEYXRlOiBXZWQsIDMgRmViIDIwMjEgMjM6MjA6NDYgLTA4MDAKU3ViamVjdDogW1BBVENIIDMv
NF0gY2lmczogSWRlbnRpZnkgYSBjb25uZWN0aW9uIGJ5IGEgY29ubl9pZC4KCkludHJvZHVjZWQg
YSBuZXcgZmllbGQgY29ubl9pZCBpbiBUQ1BfU2VydmVyX0luZm8gc3RydWN0dXJlLgpUaGlzIGlz
IGEgbm9uLXBlcnNpc3RlbnQgdW5pcXVlIGlkZW50aWZpZXIgbWFpbnRhaW5lZCBieSB0aGUgY2xp
ZW50CmZvciBhIGNvbm5lY3Rpb24gdG8gYSBmaWxlIHNlcnZlci4gRm9yIHRoaXMsIGEgZ2xvYmFs
IGNvdW50ZXIgbmFtZWQKdGNwU2VzTmV4dElkIGlzIG1haW50YWluZWQuIE9uIGFsbG9jYXRpbmcg
YSBuZXcgVENQX1NlcnZlcl9JbmZvLAp0aGlzIGNvdW50ZXIgaXMgaW5jcmVtZW50ZWQgYW5kIGFz
c2lnbmVkLgoKQ2hhbmdlZCB0aGUgZHluYW1pYyB0cmFjZXBvaW50cyByZWxhdGVkIHRvIHJlY29u
bmVjdHMgYW5kCmNyZWRpdGluZyB0byBiZSBtb3JlIGluZm9ybWF0aXZlICh3aXRoIGNvbm5faWQg
cHJpbnRlZCkuCkRlYnVnZ2luZyBhIGNyZWRpdGluZyBpc3N1ZSBoZWxwZWQgbWUgdW5kZXJzdGFu
ZCB0aGUKaW1wb3J0YW50IHRoaW5ncyB0byBwcmludCBoZXJlLgoKQWx3YXlzIGNhbGwgZHluYW1p
YyB0cmFjZXBvaW50cyBvdXRzaWRlIHRoZSBzY29wZSBvZiBzcGlubG9ja3MuClRvIGRvIHRoaXMs
IGNvcHkgb3V0IHRoZSBjcmVkaXRzIGFuZCBpbl9mbGlnaHQgZmllbGRzIG9mIHRoZQpzZXJ2ZXIg
c3RydWN0IGJlZm9yZSBkcm9wcGluZyB0aGUgbG9jay4KClNpZ25lZC1vZmYtYnk6IFNoeWFtIFBy
YXNhZCBOIDxzcHJhc2FkQG1pY3Jvc29mdC5jb20+Ci0tLQogZnMvY2lmcy9jaWZzZnMuYyAgICB8
ICAxICsKIGZzL2NpZnMvY2lmc2dsb2IuaCAgfCAgMiArKwogZnMvY2lmcy9jb25uZWN0LmMgICB8
IDExICsrKysrLS0tCiBmcy9jaWZzL3NtYjJvcHMuYyAgIHwgNjUgKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCiBmcy9jaWZzL3RyYWNlLmggICAgIHwgMzYgKysr
KysrKysrKysrKysrKysrLS0tLS0tLQogZnMvY2lmcy90cmFuc3BvcnQuYyB8IDUzICsrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLQogNiBmaWxlcyBjaGFuZ2VkLCAxMjMgaW5zZXJ0
aW9ucygrKSwgNDUgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jaWZzZnMuYyBi
L2ZzL2NpZnMvY2lmc2ZzLmMKaW5kZXggZTQ2ZGE1MzZlZDMzLi4yMDcwZjJkNDg1NjMgMTAwNjQ0
Ci0tLSBhL2ZzL2NpZnMvY2lmc2ZzLmMKKysrIGIvZnMvY2lmcy9jaWZzZnMuYwpAQCAtMTUyNSw2
ICsxNTI1LDcgQEAgaW5pdF9jaWZzKHZvaWQpCiAgKi8KIAlhdG9taWNfc2V0KCZzZXNJbmZvQWxs
b2NDb3VudCwgMCk7CiAJYXRvbWljX3NldCgmdGNvbkluZm9BbGxvY0NvdW50LCAwKTsKKwlhdG9t
aWNfc2V0KCZ0Y3BTZXNOZXh0SWQsIDApOwogCWF0b21pY19zZXQoJnRjcFNlc0FsbG9jQ291bnQs
IDApOwogCWF0b21pY19zZXQoJnRjcFNlc1JlY29ubmVjdENvdW50LCAwKTsKIAlhdG9taWNfc2V0
KCZ0Y29uSW5mb1JlY29ubmVjdENvdW50LCAwKTsKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvY2lmc2ds
b2IuaCBiL2ZzL2NpZnMvY2lmc2dsb2IuaAppbmRleCAzMTUyNjAxYTYwOGIuLjBhYTJjM2M4NzFj
OSAxMDA2NDQKLS0tIGEvZnMvY2lmcy9jaWZzZ2xvYi5oCisrKyBiL2ZzL2NpZnMvY2lmc2dsb2Iu
aApAQCAtNTc3LDYgKzU3Nyw3IEBAIGluY19yZmMxMDAxX2xlbih2b2lkICpidWYsIGludCBjb3Vu
dCkKIHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gewogCXN0cnVjdCBsaXN0X2hlYWQgdGNwX3Nlc19s
aXN0OwogCXN0cnVjdCBsaXN0X2hlYWQgc21iX3Nlc19saXN0OworCV9fdTY0IGNvbm5faWQ7IC8q
IGNvbm5lY3Rpb24gaWRlbnRpZmllciAodXNlZnVsIGZvciBkZWJ1Z2dpbmcpICovCiAJaW50IHNy
dl9jb3VudDsgLyogcmVmZXJlbmNlIGNvdW50ZXIgKi8KIAkvKiAxNSBjaGFyYWN0ZXIgc2VydmVy
IG5hbWUgKyAweDIwIDE2dGggYnl0ZSBpbmRpY2F0aW5nIHR5cGUgPSBzcnYgKi8KIAljaGFyIHNl
cnZlcl9SRkMxMDAxX25hbWVbUkZDMTAwMV9OQU1FX0xFTl9XSVRIX05VTExdOwpAQCAtMTg0Niw2
ICsxODQ3LDcgQEAgR0xPQkFMX0VYVEVSTiBzcGlubG9ja190IEdsb2JhbE1pZF9Mb2NrOyAgLyog
cHJvdGVjdHMgYWJvdmUgJiBsaXN0IG9wZXJhdGlvbnMgKi8KICAqLwogR0xPQkFMX0VYVEVSTiBh
dG9taWNfdCBzZXNJbmZvQWxsb2NDb3VudDsKIEdMT0JBTF9FWFRFUk4gYXRvbWljX3QgdGNvbklu
Zm9BbGxvY0NvdW50OworR0xPQkFMX0VYVEVSTiBhdG9taWNfdCB0Y3BTZXNOZXh0SWQ7CiBHTE9C
QUxfRVhURVJOIGF0b21pY190IHRjcFNlc0FsbG9jQ291bnQ7CiBHTE9CQUxfRVhURVJOIGF0b21p
Y190IHRjcFNlc1JlY29ubmVjdENvdW50OwogR0xPQkFMX0VYVEVSTiBhdG9taWNfdCB0Y29uSW5m
b1JlY29ubmVjdENvdW50OwpkaWZmIC0tZ2l0IGEvZnMvY2lmcy9jb25uZWN0LmMgYi9mcy9jaWZz
L2Nvbm5lY3QuYwppbmRleCAxMGZlNmQ2ZDJkZWUuLjVjZmZkNTA2ZmFjYyAxMDA2NDQKLS0tIGEv
ZnMvY2lmcy9jb25uZWN0LmMKKysrIGIvZnMvY2lmcy9jb25uZWN0LmMKQEAgLTI0Miw3ICsyNDIs
NyBAQCBjaWZzX3JlY29ubmVjdChzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIpCiAJc2Vy
dmVyLT5tYXhfcmVhZCA9IDA7CiAKIAljaWZzX2RiZyhGWUksICJNYXJrIHRjcCBzZXNzaW9uIGFz
IG5lZWQgcmVjb25uZWN0XG4iKTsKLQl0cmFjZV9zbWIzX3JlY29ubmVjdChzZXJ2ZXItPkN1cnJl
bnRNaWQsIHNlcnZlci0+aG9zdG5hbWUpOworCXRyYWNlX3NtYjNfcmVjb25uZWN0KHNlcnZlci0+
Q3VycmVudE1pZCwgc2VydmVyLT5jb25uX2lkLCBzZXJ2ZXItPmhvc3RuYW1lKTsKIAogCS8qIGJl
Zm9yZSByZWNvbm5lY3RpbmcgdGhlIHRjcCBzZXNzaW9uLCBtYXJrIHRoZSBzbWIgc2Vzc2lvbiAo
dWlkKQogCQlhbmQgdGhlIHRpZCBiYWQgc28gdGhleSBhcmUgbm90IHVzZWQgdW50aWwgcmVjb25u
ZWN0ZWQgKi8KQEAgLTg0Niw3ICs4NDYsNyBAQCBzdGF0aWMgdm9pZAogc21iMl9hZGRfY3JlZGl0
c19mcm9tX2hkcihjaGFyICpidWZmZXIsIHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNlcnZlcikK
IHsKIAlzdHJ1Y3Qgc21iMl9zeW5jX2hkciAqc2hkciA9IChzdHJ1Y3Qgc21iMl9zeW5jX2hkciAq
KWJ1ZmZlcjsKLQlpbnQgc2NyZWRpdHMgPSBzZXJ2ZXItPmNyZWRpdHM7CisJaW50IHNjcmVkaXRz
LCBpbl9mbGlnaHQ7CiAKIAkvKgogCSAqIFNNQjEgZG9lcyBub3QgdXNlIGNyZWRpdHMuCkBAIC04
NTcsMTIgKzg1NywxNCBAQCBzbWIyX2FkZF9jcmVkaXRzX2Zyb21faGRyKGNoYXIgKmJ1ZmZlciwg
c3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2VydmVyKQogCWlmIChzaGRyLT5DcmVkaXRSZXF1ZXN0
KSB7CiAJCXNwaW5fbG9jaygmc2VydmVyLT5yZXFfbG9jayk7CiAJCXNlcnZlci0+Y3JlZGl0cyAr
PSBsZTE2X3RvX2NwdShzaGRyLT5DcmVkaXRSZXF1ZXN0KTsKKwkJc2NyZWRpdHMgPSBzZXJ2ZXIt
PmNyZWRpdHM7CisJCWluX2ZsaWdodCA9IHNlcnZlci0+aW5fZmxpZ2h0OwogCQlzcGluX3VubG9j
aygmc2VydmVyLT5yZXFfbG9jayk7CiAJCXdha2VfdXAoJnNlcnZlci0+cmVxdWVzdF9xKTsKIAog
CQl0cmFjZV9zbWIzX2FkZF9jcmVkaXRzKHNlcnZlci0+Q3VycmVudE1pZCwKLQkJCQlzZXJ2ZXIt
Pmhvc3RuYW1lLCBzY3JlZGl0cywKLQkJCQlsZTE2X3RvX2NwdShzaGRyLT5DcmVkaXRSZXF1ZXN0
KSk7CisJCQkJc2VydmVyLT5jb25uX2lkLCBzZXJ2ZXItPmhvc3RuYW1lLCBzY3JlZGl0cywKKwkJ
CQlsZTE2X3RvX2NwdShzaGRyLT5DcmVkaXRSZXF1ZXN0KSwgaW5fZmxpZ2h0KTsKIAkJY2lmc19z
ZXJ2ZXJfZGJnKEZZSSwgIiVzOiBhZGRlZCAldSBjcmVkaXRzIHRvdGFsPSVkXG4iLAogCQkJCV9f
ZnVuY19fLCBsZTE2X3RvX2NwdShzaGRyLT5DcmVkaXRSZXF1ZXN0KSwKIAkJCQlzY3JlZGl0cyk7
CkBAIC0xMzE3LDYgKzEzMTksNyBAQCBjaWZzX2dldF90Y3Bfc2Vzc2lvbihzdHJ1Y3Qgc21iM19m
c19jb250ZXh0ICpjdHgpCiAJCWdvdG8gb3V0X2Vycl9jcnlwdG9fcmVsZWFzZTsKIAl9CiAKKwl0
Y3Bfc2VzLT5jb25uX2lkID0gYXRvbWljX2luY19yZXR1cm4oJnRjcFNlc05leHRJZCk7CiAJdGNw
X3Nlcy0+bm9ibG9ja2NudCA9IGN0eC0+cm9vdGZzOwogCXRjcF9zZXMtPm5vYmxvY2tzbmQgPSBj
dHgtPm5vYmxvY2tzbmQgfHwgY3R4LT5yb290ZnM7CiAJdGNwX3Nlcy0+bm9hdXRvdHVuZSA9IGN0
eC0+bm9hdXRvdHVuZTsKZGlmZiAtLWdpdCBhL2ZzL2NpZnMvc21iMm9wcy5jIGIvZnMvY2lmcy9z
bWIyb3BzLmMKaW5kZXggNDMzMzE1NTVmY2M1Li4xYmI5NWU3NzNmZDAgMTAwNjQ0Ci0tLSBhL2Zz
L2NpZnMvc21iMm9wcy5jCisrKyBiL2ZzL2NpZnMvc21iMm9wcy5jCkBAIC02MywxNyArNjMsMTkg
QEAgc21iMl9hZGRfY3JlZGl0cyhzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIsCiAJCSBj
b25zdCBzdHJ1Y3QgY2lmc19jcmVkaXRzICpjcmVkaXRzLCBjb25zdCBpbnQgb3B0eXBlKQogewog
CWludCAqdmFsLCByYyA9IC0xOworCWludCBzY3JlZGl0cywgaW5fZmxpZ2h0OwogCXVuc2lnbmVk
IGludCBhZGQgPSBjcmVkaXRzLT52YWx1ZTsKIAl1bnNpZ25lZCBpbnQgaW5zdGFuY2UgPSBjcmVk
aXRzLT5pbnN0YW5jZTsKIAlib29sIHJlY29ubmVjdF9kZXRlY3RlZCA9IGZhbHNlOworCWJvb2wg
cmVjb25uZWN0X3dpdGhfaW52YWxpZF9jcmVkaXRzID0gZmFsc2U7CiAKIAlzcGluX2xvY2soJnNl
cnZlci0+cmVxX2xvY2spOwogCXZhbCA9IHNlcnZlci0+b3BzLT5nZXRfY3JlZGl0c19maWVsZChz
ZXJ2ZXIsIG9wdHlwZSk7CiAKIAkvKiBlZyBmb3VuZCBjYXNlIHdoZXJlIHdyaXRlIG92ZXJsYXBw
aW5nIHJlY29ubmVjdCBtZXNzZWQgdXAgY3JlZGl0cyAqLwogCWlmICgoKG9wdHlwZSAmIENJRlNf
T1BfTUFTSykgPT0gQ0lGU19ORUdfT1ApICYmICgqdmFsICE9IDApKQotCQl0cmFjZV9zbWIzX3Jl
Y29ubmVjdF93aXRoX2ludmFsaWRfY3JlZGl0cyhzZXJ2ZXItPkN1cnJlbnRNaWQsCi0JCQlzZXJ2
ZXItPmhvc3RuYW1lLCAqdmFsLCBhZGQpOworCQlyZWNvbm5lY3Rfd2l0aF9pbnZhbGlkX2NyZWRp
dHMgPSB0cnVlOworCiAJaWYgKChpbnN0YW5jZSA9PSAwKSB8fCAoaW5zdGFuY2UgPT0gc2VydmVy
LT5yZWNvbm5lY3RfaW5zdGFuY2UpKQogCQkqdmFsICs9IGFkZDsKIAllbHNlCkBAIC05NywxNiAr
OTksMjggQEAgc21iMl9hZGRfY3JlZGl0cyhzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIs
CiAJCQlzZXJ2ZXItPm9wbG9ja19jcmVkaXRzKys7CiAJCX0KIAl9CisJc2NyZWRpdHMgPSAqdmFs
OworCWluX2ZsaWdodCA9IHNlcnZlci0+aW5fZmxpZ2h0OwogCXNwaW5fdW5sb2NrKCZzZXJ2ZXIt
PnJlcV9sb2NrKTsKIAl3YWtlX3VwKCZzZXJ2ZXItPnJlcXVlc3RfcSk7CiAKIAlpZiAocmVjb25u
ZWN0X2RldGVjdGVkKSB7CisJCXRyYWNlX3NtYjNfcmVjb25uZWN0X2RldGVjdGVkKHNlcnZlci0+
Q3VycmVudE1pZCwKKwkJCXNlcnZlci0+Y29ubl9pZCwgc2VydmVyLT5ob3N0bmFtZSwgc2NyZWRp
dHMsIGFkZCwgaW5fZmxpZ2h0KTsKKwogCQljaWZzX2RiZyhGWUksICJ0cnlpbmcgdG8gcHV0ICVk
IGNyZWRpdHMgZnJvbSB0aGUgb2xkIHNlcnZlciBpbnN0YW5jZSAlZFxuIiwKIAkJCSBhZGQsIGlu
c3RhbmNlKTsKIAl9CiAKKwlpZiAocmVjb25uZWN0X3dpdGhfaW52YWxpZF9jcmVkaXRzKSB7CisJ
CXRyYWNlX3NtYjNfcmVjb25uZWN0X3dpdGhfaW52YWxpZF9jcmVkaXRzKHNlcnZlci0+Q3VycmVu
dE1pZCwKKwkJCXNlcnZlci0+Y29ubl9pZCwgc2VydmVyLT5ob3N0bmFtZSwgc2NyZWRpdHMsIGFk
ZCwgaW5fZmxpZ2h0KTsKKwkJY2lmc19kYmcoRllJLCAiTmVnb3RpYXRlIG9wZXJhdGlvbiB3aGVu
IHNlcnZlciBjcmVkaXRzIGlzIG5vbi16ZXJvLiBPcHR5cGU6ICVkLCBzZXJ2ZXIgY3JlZGl0czog
JWQsIGNyZWRpdHMgYWRkZWQ6ICVkXG4iLAorCQkJIG9wdHlwZSwgc2NyZWRpdHMsIGFkZCk7CisJ
fQorCiAJaWYgKHNlcnZlci0+dGNwU3RhdHVzID09IENpZnNOZWVkUmVjb25uZWN0Ci0JICAgIHx8
IHNlcnZlci0+dGNwU3RhdHVzID09IENpZnNFeGl0aW5nKQorCQkJfHwgc2VydmVyLT50Y3BTdGF0
dXMgPT0gQ2lmc0V4aXRpbmcpCiAJCXJldHVybjsKIAogCXN3aXRjaCAocmMpIHsKQEAgLTEyMywy
MyArMTM3LDMwIEBAIHNtYjJfYWRkX2NyZWRpdHMoc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2Vy
dmVyLAogCQljaWZzX2RiZyhGWUksICJkaXNhYmxpbmcgb3Bsb2Nrc1xuIik7CiAJCWJyZWFrOwog
CWRlZmF1bHQ6Ci0JCXRyYWNlX3NtYjNfYWRkX2NyZWRpdHMoc2VydmVyLT5DdXJyZW50TWlkLAot
CQkJc2VydmVyLT5ob3N0bmFtZSwgcmMsIGFkZCk7Ci0JCWNpZnNfZGJnKEZZSSwgIiVzOiBhZGRl
ZCAldSBjcmVkaXRzIHRvdGFsPSVkXG4iLCBfX2Z1bmNfXywgYWRkLCByYyk7CisJCS8qIGNoYW5n
ZV9jb25mIHJlYmFsYW5jZWQgY3JlZGl0cyBmb3IgZGlmZmVyZW50IHR5cGVzICovCisJCWJyZWFr
OwogCX0KKworCXRyYWNlX3NtYjNfYWRkX2NyZWRpdHMoc2VydmVyLT5DdXJyZW50TWlkLAorCQkJ
c2VydmVyLT5jb25uX2lkLCBzZXJ2ZXItPmhvc3RuYW1lLCBzY3JlZGl0cywgYWRkLCBpbl9mbGln
aHQpOworCWNpZnNfZGJnKEZZSSwgIiVzOiBhZGRlZCAldSBjcmVkaXRzIHRvdGFsPSVkXG4iLCBf
X2Z1bmNfXywgYWRkLCBzY3JlZGl0cyk7CiB9CiAKIHN0YXRpYyB2b2lkCiBzbWIyX3NldF9jcmVk
aXRzKHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNlcnZlciwgY29uc3QgaW50IHZhbCkKIHsKKwlp
bnQgc2NyZWRpdHMsIGluX2ZsaWdodDsKKwogCXNwaW5fbG9jaygmc2VydmVyLT5yZXFfbG9jayk7
CiAJc2VydmVyLT5jcmVkaXRzID0gdmFsOwogCWlmICh2YWwgPT0gMSkKIAkJc2VydmVyLT5yZWNv
bm5lY3RfaW5zdGFuY2UrKzsKKwlzY3JlZGl0cyA9IHNlcnZlci0+Y3JlZGl0czsKKwlpbl9mbGln
aHQgPSBzZXJ2ZXItPmluX2ZsaWdodDsKIAlzcGluX3VubG9jaygmc2VydmVyLT5yZXFfbG9jayk7
CiAKIAl0cmFjZV9zbWIzX3NldF9jcmVkaXRzKHNlcnZlci0+Q3VycmVudE1pZCwKLQkJCXNlcnZl
ci0+aG9zdG5hbWUsIHZhbCwgdmFsKTsKKwkJCXNlcnZlci0+Y29ubl9pZCwgc2VydmVyLT5ob3N0
bmFtZSwgc2NyZWRpdHMsIHZhbCwgaW5fZmxpZ2h0KTsKIAljaWZzX2RiZyhGWUksICIlczogc2V0
ICV1IGNyZWRpdHNcbiIsIF9fZnVuY19fLCB2YWwpOwogCiAJLyogZG9uJ3QgbG9nIHdoaWxlIGhv
bGRpbmcgdGhlIGxvY2sgKi8KQEAgLTE3MSw3ICsxOTIsNyBAQCBzbWIyX3dhaXRfbXR1X2NyZWRp
dHMoc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2VydmVyLCB1bnNpZ25lZCBpbnQgc2l6ZSwKIAkJ
ICAgICAgdW5zaWduZWQgaW50ICpudW0sIHN0cnVjdCBjaWZzX2NyZWRpdHMgKmNyZWRpdHMpCiB7
CiAJaW50IHJjID0gMDsKLQl1bnNpZ25lZCBpbnQgc2NyZWRpdHM7CisJdW5zaWduZWQgaW50IHNj
cmVkaXRzLCBpbl9mbGlnaHQ7CiAKIAlzcGluX2xvY2soJnNlcnZlci0+cmVxX2xvY2spOwogCXdo
aWxlICgxKSB7CkBAIC0yMDgsMTcgKzIyOSwxOCBAQCBzbWIyX3dhaXRfbXR1X2NyZWRpdHMoc3Ry
dWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2VydmVyLCB1bnNpZ25lZCBpbnQgc2l6ZSwKIAkJCQlESVZf
Uk9VTkRfVVAoKm51bSwgU01CMl9NQVhfQlVGRkVSX1NJWkUpOwogCQkJY3JlZGl0cy0+aW5zdGFu
Y2UgPSBzZXJ2ZXItPnJlY29ubmVjdF9pbnN0YW5jZTsKIAkJCXNlcnZlci0+Y3JlZGl0cyAtPSBj
cmVkaXRzLT52YWx1ZTsKLQkJCXNjcmVkaXRzID0gc2VydmVyLT5jcmVkaXRzOwogCQkJc2VydmVy
LT5pbl9mbGlnaHQrKzsKIAkJCWlmIChzZXJ2ZXItPmluX2ZsaWdodCA+IHNlcnZlci0+bWF4X2lu
X2ZsaWdodCkKIAkJCQlzZXJ2ZXItPm1heF9pbl9mbGlnaHQgPSBzZXJ2ZXItPmluX2ZsaWdodDsK
IAkJCWJyZWFrOwogCQl9CiAJfQorCXNjcmVkaXRzID0gc2VydmVyLT5jcmVkaXRzOworCWluX2Zs
aWdodCA9IHNlcnZlci0+aW5fZmxpZ2h0OwogCXNwaW5fdW5sb2NrKCZzZXJ2ZXItPnJlcV9sb2Nr
KTsKIAogCXRyYWNlX3NtYjNfYWRkX2NyZWRpdHMoc2VydmVyLT5DdXJyZW50TWlkLAotCQkJc2Vy
dmVyLT5ob3N0bmFtZSwgc2NyZWRpdHMsIC0oY3JlZGl0cy0+dmFsdWUpKTsKKwkJCXNlcnZlci0+
Y29ubl9pZCwgc2VydmVyLT5ob3N0bmFtZSwgc2NyZWRpdHMsIC0oY3JlZGl0cy0+dmFsdWUpLCBp
bl9mbGlnaHQpOwogCWNpZnNfZGJnKEZZSSwgIiVzOiByZW1vdmVkICV1IGNyZWRpdHMgdG90YWw9
JWRcbiIsCiAJCQlfX2Z1bmNfXywgY3JlZGl0cy0+dmFsdWUsIHNjcmVkaXRzKTsKIApAQCAtMjMx
LDE0ICsyNTMsMTQgQEAgc21iMl9hZGp1c3RfY3JlZGl0cyhzdHJ1Y3QgVENQX1NlcnZlcl9JbmZv
ICpzZXJ2ZXIsCiAJCSAgICBjb25zdCB1bnNpZ25lZCBpbnQgcGF5bG9hZF9zaXplKQogewogCWlu
dCBuZXdfdmFsID0gRElWX1JPVU5EX1VQKHBheWxvYWRfc2l6ZSwgU01CMl9NQVhfQlVGRkVSX1NJ
WkUpOwotCWludCBzY3JlZGl0czsKKwlpbnQgc2NyZWRpdHMsIGluX2ZsaWdodDsKIAogCWlmICgh
Y3JlZGl0cy0+dmFsdWUgfHwgY3JlZGl0cy0+dmFsdWUgPT0gbmV3X3ZhbCkKIAkJcmV0dXJuIDA7
CiAKIAlpZiAoY3JlZGl0cy0+dmFsdWUgPCBuZXdfdmFsKSB7CiAJCXRyYWNlX3NtYjNfdG9vX21h
bnlfY3JlZGl0cyhzZXJ2ZXItPkN1cnJlbnRNaWQsCi0JCQkJc2VydmVyLT5ob3N0bmFtZSwgMCwg
Y3JlZGl0cy0+dmFsdWUgLSBuZXdfdmFsKTsKKwkJCQlzZXJ2ZXItPmNvbm5faWQsIHNlcnZlci0+
aG9zdG5hbWUsIDAsIGNyZWRpdHMtPnZhbHVlIC0gbmV3X3ZhbCwgMCk7CiAJCWNpZnNfc2VydmVy
X2RiZyhWRlMsICJyZXF1ZXN0IGhhcyBsZXNzIGNyZWRpdHMgKCVkKSB0aGFuIHJlcXVpcmVkICgl
ZCkiLAogCQkJCWNyZWRpdHMtPnZhbHVlLCBuZXdfdmFsKTsKIApAQCAtMjQ4LDkgKzI3MCwxMyBA
QCBzbWIyX2FkanVzdF9jcmVkaXRzKHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNlcnZlciwKIAlz
cGluX2xvY2soJnNlcnZlci0+cmVxX2xvY2spOwogCiAJaWYgKHNlcnZlci0+cmVjb25uZWN0X2lu
c3RhbmNlICE9IGNyZWRpdHMtPmluc3RhbmNlKSB7CisJCXNjcmVkaXRzID0gc2VydmVyLT5jcmVk
aXRzOworCQlpbl9mbGlnaHQgPSBzZXJ2ZXItPmluX2ZsaWdodDsKIAkJc3Bpbl91bmxvY2soJnNl
cnZlci0+cmVxX2xvY2spOworCiAJCXRyYWNlX3NtYjNfcmVjb25uZWN0X2RldGVjdGVkKHNlcnZl
ci0+Q3VycmVudE1pZCwKLQkJCXNlcnZlci0+aG9zdG5hbWUsIDAsIDApOworCQkJc2VydmVyLT5j
b25uX2lkLCBzZXJ2ZXItPmhvc3RuYW1lLCBzY3JlZGl0cywKKwkJCWNyZWRpdHMtPnZhbHVlIC0g
bmV3X3ZhbCwgaW5fZmxpZ2h0KTsKIAkJY2lmc19zZXJ2ZXJfZGJnKFZGUywgInRyeWluZyB0byBy
ZXR1cm4gJWQgY3JlZGl0cyB0byBvbGQgc2Vzc2lvblxuIiwKIAkJCSBjcmVkaXRzLT52YWx1ZSAt
IG5ld192YWwpOwogCQlyZXR1cm4gLUVBR0FJTjsKQEAgLTI1OCwxNSArMjg0LDE4IEBAIHNtYjJf
YWRqdXN0X2NyZWRpdHMoc3RydWN0IFRDUF9TZXJ2ZXJfSW5mbyAqc2VydmVyLAogCiAJc2VydmVy
LT5jcmVkaXRzICs9IGNyZWRpdHMtPnZhbHVlIC0gbmV3X3ZhbDsKIAlzY3JlZGl0cyA9IHNlcnZl
ci0+Y3JlZGl0czsKKwlpbl9mbGlnaHQgPSBzZXJ2ZXItPmluX2ZsaWdodDsKIAlzcGluX3VubG9j
aygmc2VydmVyLT5yZXFfbG9jayk7CiAJd2FrZV91cCgmc2VydmVyLT5yZXF1ZXN0X3EpOwotCWNy
ZWRpdHMtPnZhbHVlID0gbmV3X3ZhbDsKIAogCXRyYWNlX3NtYjNfYWRkX2NyZWRpdHMoc2VydmVy
LT5DdXJyZW50TWlkLAotCQkJc2VydmVyLT5ob3N0bmFtZSwgc2NyZWRpdHMsIGNyZWRpdHMtPnZh
bHVlIC0gbmV3X3ZhbCk7CisJCQlzZXJ2ZXItPmNvbm5faWQsIHNlcnZlci0+aG9zdG5hbWUsIHNj
cmVkaXRzLAorCQkJY3JlZGl0cy0+dmFsdWUgLSBuZXdfdmFsLCBpbl9mbGlnaHQpOwogCWNpZnNf
ZGJnKEZZSSwgIiVzOiBhZGp1c3QgYWRkZWQgJXUgY3JlZGl0cyB0b3RhbD0lZFxuIiwKIAkJCV9f
ZnVuY19fLCBjcmVkaXRzLT52YWx1ZSAtIG5ld192YWwsIHNjcmVkaXRzKTsKIAorCWNyZWRpdHMt
PnZhbHVlID0gbmV3X3ZhbDsKKwogCXJldHVybiAwOwogfQogCkBAIC0yMzY5LDcgKzIzOTgsNyBA
QCBzdGF0aWMgYm9vbAogc21iMl9pc19zdGF0dXNfcGVuZGluZyhjaGFyICpidWYsIHN0cnVjdCBU
Q1BfU2VydmVyX0luZm8gKnNlcnZlcikKIHsKIAlzdHJ1Y3Qgc21iMl9zeW5jX2hkciAqc2hkciA9
IChzdHJ1Y3Qgc21iMl9zeW5jX2hkciAqKWJ1ZjsKLQlpbnQgc2NyZWRpdHM7CisJaW50IHNjcmVk
aXRzLCBpbl9mbGlnaHQ7CiAKIAlpZiAoc2hkci0+U3RhdHVzICE9IFNUQVRVU19QRU5ESU5HKQog
CQlyZXR1cm4gZmFsc2U7CkBAIC0yMzc4LDExICsyNDA3LDEzIEBAIHNtYjJfaXNfc3RhdHVzX3Bl
bmRpbmcoY2hhciAqYnVmLCBzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIpCiAJCXNwaW5f
bG9jaygmc2VydmVyLT5yZXFfbG9jayk7CiAJCXNlcnZlci0+Y3JlZGl0cyArPSBsZTE2X3RvX2Nw
dShzaGRyLT5DcmVkaXRSZXF1ZXN0KTsKIAkJc2NyZWRpdHMgPSBzZXJ2ZXItPmNyZWRpdHM7CisJ
CWluX2ZsaWdodCA9IHNlcnZlci0+aW5fZmxpZ2h0OwogCQlzcGluX3VubG9jaygmc2VydmVyLT5y
ZXFfbG9jayk7CiAJCXdha2VfdXAoJnNlcnZlci0+cmVxdWVzdF9xKTsKIAogCQl0cmFjZV9zbWIz
X2FkZF9jcmVkaXRzKHNlcnZlci0+Q3VycmVudE1pZCwKLQkJCQlzZXJ2ZXItPmhvc3RuYW1lLCBz
Y3JlZGl0cywgbGUxNl90b19jcHUoc2hkci0+Q3JlZGl0UmVxdWVzdCkpOworCQkJCXNlcnZlci0+
Y29ubl9pZCwgc2VydmVyLT5ob3N0bmFtZSwgc2NyZWRpdHMsCisJCQkJbGUxNl90b19jcHUoc2hk
ci0+Q3JlZGl0UmVxdWVzdCksIGluX2ZsaWdodCk7CiAJCWNpZnNfZGJnKEZZSSwgIiVzOiBzdGF0
dXMgcGVuZGluZyBhZGQgJXUgY3JlZGl0cyB0b3RhbD0lZFxuIiwKIAkJCQlfX2Z1bmNfXywgbGUx
Nl90b19jcHUoc2hkci0+Q3JlZGl0UmVxdWVzdCksIHNjcmVkaXRzKTsKIAl9CmRpZmYgLS1naXQg
YS9mcy9jaWZzL3RyYWNlLmggYi9mcy9jaWZzL3RyYWNlLmgKaW5kZXggYzNkMWE1ODRmMjUxLi5j
NTMzYThmMWNkNDggMTAwNjQ0Ci0tLSBhL2ZzL2NpZnMvdHJhY2UuaAorKysgYi9mcy9jaWZzL3Ry
YWNlLmgKQEAgLTg1MSwxNyArODUxLDIxIEBAIERFRklORV9TTUIzX0xFQVNFX0VSUl9FVkVOVChs
ZWFzZV9lcnIpOwogCiBERUNMQVJFX0VWRU5UX0NMQVNTKHNtYjNfcmVjb25uZWN0X2NsYXNzLAog
CVRQX1BST1RPKF9fdTY0CWN1cnJtaWQsCisJCV9fdTY0IGNvbm5faWQsCiAJCWNoYXIgKmhvc3Ru
YW1lKSwKLQlUUF9BUkdTKGN1cnJtaWQsIGhvc3RuYW1lKSwKKwlUUF9BUkdTKGN1cnJtaWQsIGNv
bm5faWQsIGhvc3RuYW1lKSwKIAlUUF9TVFJVQ1RfX2VudHJ5KAogCQlfX2ZpZWxkKF9fdTY0LCBj
dXJybWlkKQorCQlfX2ZpZWxkKF9fdTY0LCBjb25uX2lkKQogCQlfX2ZpZWxkKGNoYXIgKiwgaG9z
dG5hbWUpCiAJKSwKIAlUUF9mYXN0X2Fzc2lnbigKIAkJX19lbnRyeS0+Y3Vycm1pZCA9IGN1cnJt
aWQ7CisJCV9fZW50cnktPmNvbm5faWQgPSBjb25uX2lkOwogCQlfX2VudHJ5LT5ob3N0bmFtZSA9
IGhvc3RuYW1lOwogCSksCi0JVFBfcHJpbnRrKCJzZXJ2ZXI9JXMgY3VycmVudF9taWQ9MHglbGx4
IiwKKwlUUF9wcmludGsoImNvbm5faWQ9MHglbGx4IHNlcnZlcj0lcyBjdXJyZW50X21pZD0lbGx1
IiwKKwkJX19lbnRyeS0+Y29ubl9pZCwKIAkJX19lbnRyeS0+aG9zdG5hbWUsCiAJCV9fZW50cnkt
PmN1cnJtaWQpCiApCkBAIC04NjksNDQgKzg3Myw1NiBAQCBERUNMQVJFX0VWRU5UX0NMQVNTKHNt
YjNfcmVjb25uZWN0X2NsYXNzLAogI2RlZmluZSBERUZJTkVfU01CM19SRUNPTk5FQ1RfRVZFTlQo
bmFtZSkgICAgICAgIFwKIERFRklORV9FVkVOVChzbWIzX3JlY29ubmVjdF9jbGFzcywgc21iM18j
I25hbWUsICBcCiAJVFBfUFJPVE8oX191NjQJY3Vycm1pZCwJCVwKLQkJY2hhciAqaG9zdG5hbWUp
LAkJXAotCVRQX0FSR1MoY3Vycm1pZCwgaG9zdG5hbWUpKQorCQlfX3U2NCBjb25uX2lkLAkJCVwK
KwkJY2hhciAqaG9zdG5hbWUpLAkJCQlcCisJVFBfQVJHUyhjdXJybWlkLCBjb25uX2lkLCBob3N0
bmFtZSkpCiAKIERFRklORV9TTUIzX1JFQ09OTkVDVF9FVkVOVChyZWNvbm5lY3QpOwogREVGSU5F
X1NNQjNfUkVDT05ORUNUX0VWRU5UKHBhcnRpYWxfc2VuZF9yZWNvbm5lY3QpOwogCiBERUNMQVJF
X0VWRU5UX0NMQVNTKHNtYjNfY3JlZGl0X2NsYXNzLAogCVRQX1BST1RPKF9fdTY0CWN1cnJtaWQs
CisJCV9fdTY0IGNvbm5faWQsCiAJCWNoYXIgKmhvc3RuYW1lLAogCQlpbnQgY3JlZGl0cywKLQkJ
aW50IGNyZWRpdHNfdG9fYWRkKSwKLQlUUF9BUkdTKGN1cnJtaWQsIGhvc3RuYW1lLCBjcmVkaXRz
LCBjcmVkaXRzX3RvX2FkZCksCisJCWludCBjcmVkaXRzX3RvX2FkZCwKKwkJaW50IGluX2ZsaWdo
dCksCisJVFBfQVJHUyhjdXJybWlkLCBjb25uX2lkLCBob3N0bmFtZSwgY3JlZGl0cywgY3JlZGl0
c190b19hZGQsIGluX2ZsaWdodCksCiAJVFBfU1RSVUNUX19lbnRyeSgKIAkJX19maWVsZChfX3U2
NCwgY3Vycm1pZCkKKwkJX19maWVsZChfX3U2NCwgY29ubl9pZCkKIAkJX19maWVsZChjaGFyICos
IGhvc3RuYW1lKQogCQlfX2ZpZWxkKGludCwgY3JlZGl0cykKIAkJX19maWVsZChpbnQsIGNyZWRp
dHNfdG9fYWRkKQorCQlfX2ZpZWxkKGludCwgaW5fZmxpZ2h0KQogCSksCiAJVFBfZmFzdF9hc3Np
Z24oCiAJCV9fZW50cnktPmN1cnJtaWQgPSBjdXJybWlkOworCQlfX2VudHJ5LT5jb25uX2lkID0g
Y29ubl9pZDsKIAkJX19lbnRyeS0+aG9zdG5hbWUgPSBob3N0bmFtZTsKIAkJX19lbnRyeS0+Y3Jl
ZGl0cyA9IGNyZWRpdHM7CiAJCV9fZW50cnktPmNyZWRpdHNfdG9fYWRkID0gY3JlZGl0c190b19h
ZGQ7CisJCV9fZW50cnktPmluX2ZsaWdodCA9IGluX2ZsaWdodDsKIAkpLAotCVRQX3ByaW50aygi
c2VydmVyPSVzIGN1cnJlbnRfbWlkPTB4JWxseCBjcmVkaXRzPSVkIGNyZWRpdHNfdG9fYWRkPSVk
IiwKKwlUUF9wcmludGsoImNvbm5faWQ9MHglbGx4IHNlcnZlcj0lcyBjdXJyZW50X21pZD0lbGx1
IgorCQkJImNyZWRpdHM9JWQgY3JlZGl0X2NoYW5nZT0lZCBpbl9mbGlnaHQ9JWQiLAorCQlfX2Vu
dHJ5LT5jb25uX2lkLAogCQlfX2VudHJ5LT5ob3N0bmFtZSwKIAkJX19lbnRyeS0+Y3Vycm1pZCwK
IAkJX19lbnRyeS0+Y3JlZGl0cywKLQkJX19lbnRyeS0+Y3JlZGl0c190b19hZGQpCisJCV9fZW50
cnktPmNyZWRpdHNfdG9fYWRkLAorCQlfX2VudHJ5LT5pbl9mbGlnaHQpCiApCiAKICNkZWZpbmUg
REVGSU5FX1NNQjNfQ1JFRElUX0VWRU5UKG5hbWUpICAgICAgICBcCiBERUZJTkVfRVZFTlQoc21i
M19jcmVkaXRfY2xhc3MsIHNtYjNfIyNuYW1lLCAgXAogCVRQX1BST1RPKF9fdTY0CWN1cnJtaWQs
CQlcCisJCV9fdTY0IGNvbm5faWQsCQkJXAogCQljaGFyICpob3N0bmFtZSwJCQlcCiAJCWludCAg
Y3JlZGl0cywJCQlcCi0JCWludCAgY3JlZGl0c190b19hZGQpLAkJXAotCVRQX0FSR1MoY3Vycm1p
ZCwgaG9zdG5hbWUsIGNyZWRpdHMsIGNyZWRpdHNfdG9fYWRkKSkKKwkJaW50ICBjcmVkaXRzX3Rv
X2FkZCwJXAorCQlpbnQgaW5fZmxpZ2h0KSwJCQlcCisJVFBfQVJHUyhjdXJybWlkLCBjb25uX2lk
LCBob3N0bmFtZSwgY3JlZGl0cywgY3JlZGl0c190b19hZGQsIGluX2ZsaWdodCkpCiAKIERFRklO
RV9TTUIzX0NSRURJVF9FVkVOVChyZWNvbm5lY3Rfd2l0aF9pbnZhbGlkX2NyZWRpdHMpOwogREVG
SU5FX1NNQjNfQ1JFRElUX0VWRU5UKHJlY29ubmVjdF9kZXRlY3RlZCk7CmRpZmYgLS1naXQgYS9m
cy9jaWZzL3RyYW5zcG9ydC5jIGIvZnMvY2lmcy90cmFuc3BvcnQuYwppbmRleCAzOWU4NzcwNTg0
MGQuLmU5MGExZDEzODBiMCAxMDA2NDQKLS0tIGEvZnMvY2lmcy90cmFuc3BvcnQuYworKysgYi9m
cy9jaWZzL3RyYW5zcG9ydC5jCkBAIC00NDUsNyArNDQ1LDcgQEAgX19zbWJfc2VuZF9ycXN0KHN0
cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNlcnZlciwgaW50IG51bV9ycXN0LAogCQkgKi8KIAkJc2Vy
dmVyLT50Y3BTdGF0dXMgPSBDaWZzTmVlZFJlY29ubmVjdDsKIAkJdHJhY2Vfc21iM19wYXJ0aWFs
X3NlbmRfcmVjb25uZWN0KHNlcnZlci0+Q3VycmVudE1pZCwKLQkJCQkJCSAgc2VydmVyLT5ob3N0
bmFtZSk7CisJCQkJCQkgIHNlcnZlci0+Y29ubl9pZCwgc2VydmVyLT5ob3N0bmFtZSk7CiAJfQog
c21iZF9kb25lOgogCWlmIChyYyA8IDAgJiYgcmMgIT0gLUVJTlRSKQpAQCAtNTI3LDcgKzUyNyw3
IEBAIHdhaXRfZm9yX2ZyZWVfY3JlZGl0cyhzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIs
IGNvbnN0IGludCBudW1fY3JlZGl0cywKIAlpbnQgKmNyZWRpdHM7CiAJaW50IG9wdHlwZTsKIAls
b25nIGludCB0OwotCWludCBzY3JlZGl0cyA9IHNlcnZlci0+Y3JlZGl0czsKKwlpbnQgc2NyZWRp
dHMsIGluX2ZsaWdodDsKIAogCWlmICh0aW1lb3V0IDwgMCkKIAkJdCA9IE1BWF9KSUZGWV9PRkZT
RVQ7CkBAIC01NTEsMjIgKzU1MSwzOCBAQCB3YWl0X2Zvcl9mcmVlX2NyZWRpdHMoc3RydWN0IFRD
UF9TZXJ2ZXJfSW5mbyAqc2VydmVyLCBjb25zdCBpbnQgbnVtX2NyZWRpdHMsCiAJCQlzZXJ2ZXIt
Pm1heF9pbl9mbGlnaHQgPSBzZXJ2ZXItPmluX2ZsaWdodDsKIAkJKmNyZWRpdHMgLT0gMTsKIAkJ
Kmluc3RhbmNlID0gc2VydmVyLT5yZWNvbm5lY3RfaW5zdGFuY2U7CisJCXNjcmVkaXRzID0gKmNy
ZWRpdHM7CisJCWluX2ZsaWdodCA9IHNlcnZlci0+aW5fZmxpZ2h0OwogCQlzcGluX3VubG9jaygm
c2VydmVyLT5yZXFfbG9jayk7CisKKwkJdHJhY2Vfc21iM19hZGRfY3JlZGl0cyhzZXJ2ZXItPkN1
cnJlbnRNaWQsCisJCQkJc2VydmVyLT5jb25uX2lkLCBzZXJ2ZXItPmhvc3RuYW1lLCBzY3JlZGl0
cywgLTEsIGluX2ZsaWdodCk7CisJCWNpZnNfZGJnKEZZSSwgIiVzOiByZW1vdmUgJXUgY3JlZGl0
cyB0b3RhbD0lZFxuIiwKKwkJCQlfX2Z1bmNfXywgMSwgc2NyZWRpdHMpOworCiAJCXJldHVybiAw
OwogCX0KIAogCXdoaWxlICgxKSB7CiAJCWlmICgqY3JlZGl0cyA8IG51bV9jcmVkaXRzKSB7CisJ
CQlzY3JlZGl0cyA9ICpjcmVkaXRzOwogCQkJc3Bpbl91bmxvY2soJnNlcnZlci0+cmVxX2xvY2sp
OworCiAJCQljaWZzX251bV93YWl0ZXJzX2luYyhzZXJ2ZXIpOwogCQkJcmMgPSB3YWl0X2V2ZW50
X2tpbGxhYmxlX3RpbWVvdXQoc2VydmVyLT5yZXF1ZXN0X3EsCiAJCQkJaGFzX2NyZWRpdHMoc2Vy
dmVyLCBjcmVkaXRzLCBudW1fY3JlZGl0cyksIHQpOwogCQkJY2lmc19udW1fd2FpdGVyc19kZWMo
c2VydmVyKTsKIAkJCWlmICghcmMpIHsKKwkJCQlzcGluX2xvY2soJnNlcnZlci0+cmVxX2xvY2sp
OworCQkJCXNjcmVkaXRzID0gKmNyZWRpdHM7CisJCQkJaW5fZmxpZ2h0ID0gc2VydmVyLT5pbl9m
bGlnaHQ7CisJCQkJc3Bpbl91bmxvY2soJnNlcnZlci0+cmVxX2xvY2spOworCiAJCQkJdHJhY2Vf
c21iM19jcmVkaXRfdGltZW91dChzZXJ2ZXItPkN1cnJlbnRNaWQsCi0JCQkJCXNlcnZlci0+aG9z
dG5hbWUsIG51bV9jcmVkaXRzLCAwKTsKKwkJCQkJCXNlcnZlci0+Y29ubl9pZCwgc2VydmVyLT5o
b3N0bmFtZSwgc2NyZWRpdHMsCisJCQkJCQludW1fY3JlZGl0cywgaW5fZmxpZ2h0KTsKIAkJCQlj
aWZzX3NlcnZlcl9kYmcoVkZTLCAid2FpdCB0aW1lZCBvdXQgYWZ0ZXIgJWQgbXNcbiIsCi0JCQkJ
CSB0aW1lb3V0KTsKKwkJCQkJCXRpbWVvdXQpOwogCQkJCXJldHVybiAtRUJVU1k7CiAJCQl9CiAJ
CQlpZiAocmMgPT0gLUVSRVNUQVJUU1lTKQpAQCAtNTk1LDYgKzYxMSw3IEBAIHdhaXRfZm9yX2Zy
ZWVfY3JlZGl0cyhzdHJ1Y3QgVENQX1NlcnZlcl9JbmZvICpzZXJ2ZXIsIGNvbnN0IGludCBudW1f
Y3JlZGl0cywKIAkJCSAgICBzZXJ2ZXItPmluX2ZsaWdodCA+IDIgKiBNQVhfQ09NUE9VTkQgJiYK
IAkJCSAgICAqY3JlZGl0cyA8PSBNQVhfQ09NUE9VTkQpIHsKIAkJCQlzcGluX3VubG9jaygmc2Vy
dmVyLT5yZXFfbG9jayk7CisKIAkJCQljaWZzX251bV93YWl0ZXJzX2luYyhzZXJ2ZXIpOwogCQkJ
CXJjID0gd2FpdF9ldmVudF9raWxsYWJsZV90aW1lb3V0KAogCQkJCQlzZXJ2ZXItPnJlcXVlc3Rf
cSwKQEAgLTYwMywxMiArNjIwLDE3IEBAIHdhaXRfZm9yX2ZyZWVfY3JlZGl0cyhzdHJ1Y3QgVENQ
X1NlcnZlcl9JbmZvICpzZXJ2ZXIsIGNvbnN0IGludCBudW1fY3JlZGl0cywKIAkJCQkJdCk7CiAJ
CQkJY2lmc19udW1fd2FpdGVyc19kZWMoc2VydmVyKTsKIAkJCQlpZiAoIXJjKSB7CisJCQkJCXNw
aW5fbG9jaygmc2VydmVyLT5yZXFfbG9jayk7CisJCQkJCXNjcmVkaXRzID0gKmNyZWRpdHM7CisJ
CQkJCWluX2ZsaWdodCA9IHNlcnZlci0+aW5fZmxpZ2h0OworCQkJCQlzcGluX3VubG9jaygmc2Vy
dmVyLT5yZXFfbG9jayk7CisKIAkJCQkJdHJhY2Vfc21iM19jcmVkaXRfdGltZW91dCgKLQkJCQkJ
CXNlcnZlci0+Q3VycmVudE1pZCwKLQkJCQkJCXNlcnZlci0+aG9zdG5hbWUsIG51bV9jcmVkaXRz
LAotCQkJCQkJMCk7CisJCQkJCQkJc2VydmVyLT5DdXJyZW50TWlkLAorCQkJCQkJCXNlcnZlci0+
Y29ubl9pZCwgc2VydmVyLT5ob3N0bmFtZSwKKwkJCQkJCQlzY3JlZGl0cywgbnVtX2NyZWRpdHMs
IGluX2ZsaWdodCk7CiAJCQkJCWNpZnNfc2VydmVyX2RiZyhWRlMsICJ3YWl0IHRpbWVkIG91dCBh
ZnRlciAlZCBtc1xuIiwKLQkJCQkJCSB0aW1lb3V0KTsKKwkJCQkJCQl0aW1lb3V0KTsKIAkJCQkJ
cmV0dXJuIC1FQlVTWTsKIAkJCQl9CiAJCQkJaWYgKHJjID09IC1FUkVTVEFSVFNZUykKQEAgLTYy
NSwxNiArNjQ3LDE4IEBAIHdhaXRfZm9yX2ZyZWVfY3JlZGl0cyhzdHJ1Y3QgVENQX1NlcnZlcl9J
bmZvICpzZXJ2ZXIsIGNvbnN0IGludCBudW1fY3JlZGl0cywKIAkJCS8qIHVwZGF0ZSAjIG9mIHJl
cXVlc3RzIG9uIHRoZSB3aXJlIHRvIHNlcnZlciAqLwogCQkJaWYgKChmbGFncyAmIENJRlNfVElN
RU9VVF9NQVNLKSAhPSBDSUZTX0JMT0NLSU5HX09QKSB7CiAJCQkJKmNyZWRpdHMgLT0gbnVtX2Ny
ZWRpdHM7Ci0JCQkJc2NyZWRpdHMgPSAqY3JlZGl0czsKIAkJCQlzZXJ2ZXItPmluX2ZsaWdodCAr
PSBudW1fY3JlZGl0czsKIAkJCQlpZiAoc2VydmVyLT5pbl9mbGlnaHQgPiBzZXJ2ZXItPm1heF9p
bl9mbGlnaHQpCiAJCQkJCXNlcnZlci0+bWF4X2luX2ZsaWdodCA9IHNlcnZlci0+aW5fZmxpZ2h0
OwogCQkJCSppbnN0YW5jZSA9IHNlcnZlci0+cmVjb25uZWN0X2luc3RhbmNlOwogCQkJfQorCQkJ
c2NyZWRpdHMgPSAqY3JlZGl0czsKKwkJCWluX2ZsaWdodCA9IHNlcnZlci0+aW5fZmxpZ2h0Owog
CQkJc3Bpbl91bmxvY2soJnNlcnZlci0+cmVxX2xvY2spOwogCiAJCQl0cmFjZV9zbWIzX2FkZF9j
cmVkaXRzKHNlcnZlci0+Q3VycmVudE1pZCwKLQkJCQkJc2VydmVyLT5ob3N0bmFtZSwgc2NyZWRp
dHMsIC0obnVtX2NyZWRpdHMpKTsKKwkJCQkJc2VydmVyLT5jb25uX2lkLCBzZXJ2ZXItPmhvc3Ru
YW1lLCBzY3JlZGl0cywKKwkJCQkJLShudW1fY3JlZGl0cyksIGluX2ZsaWdodCk7CiAJCQljaWZz
X2RiZyhGWUksICIlczogcmVtb3ZlICV1IGNyZWRpdHMgdG90YWw9JWRcbiIsCiAJCQkJCV9fZnVu
Y19fLCBudW1fY3JlZGl0cywgc2NyZWRpdHMpOwogCQkJYnJlYWs7CkBAIC02NTYsMTMgKzY4MCwx
MyBAQCB3YWl0X2Zvcl9jb21wb3VuZF9yZXF1ZXN0KHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNl
cnZlciwgaW50IG51bSwKIAkJCSAgY29uc3QgaW50IGZsYWdzLCB1bnNpZ25lZCBpbnQgKmluc3Rh
bmNlKQogewogCWludCAqY3JlZGl0czsKLQlpbnQgc2NyZWRpdHMsIHNpbl9mbGlnaHQ7CisJaW50
IHNjcmVkaXRzLCBpbl9mbGlnaHQ7CiAKIAljcmVkaXRzID0gc2VydmVyLT5vcHMtPmdldF9jcmVk
aXRzX2ZpZWxkKHNlcnZlciwgZmxhZ3MgJiBDSUZTX09QX01BU0spOwogCiAJc3Bpbl9sb2NrKCZz
ZXJ2ZXItPnJlcV9sb2NrKTsKIAlzY3JlZGl0cyA9ICpjcmVkaXRzOwotCXNpbl9mbGlnaHQgPSBz
ZXJ2ZXItPmluX2ZsaWdodDsKKwlpbl9mbGlnaHQgPSBzZXJ2ZXItPmluX2ZsaWdodDsKIAogCWlm
ICgqY3JlZGl0cyA8IG51bSkgewogCQkvKgpAQCAtNjg0LDkgKzcwOCwxMCBAQCB3YWl0X2Zvcl9j
b21wb3VuZF9yZXF1ZXN0KHN0cnVjdCBUQ1BfU2VydmVyX0luZm8gKnNlcnZlciwgaW50IG51bSwK
IAkJaWYgKHNlcnZlci0+aW5fZmxpZ2h0ID09IDApIHsKIAkJCXNwaW5fdW5sb2NrKCZzZXJ2ZXIt
PnJlcV9sb2NrKTsKIAkJCXRyYWNlX3NtYjNfaW5zdWZmaWNpZW50X2NyZWRpdHMoc2VydmVyLT5D
dXJyZW50TWlkLAotCQkJCQlzZXJ2ZXItPmhvc3RuYW1lLCBzY3JlZGl0cywgc2luX2ZsaWdodCk7
CisJCQkJCXNlcnZlci0+Y29ubl9pZCwgc2VydmVyLT5ob3N0bmFtZSwgc2NyZWRpdHMsCisJCQkJ
CW51bSwgaW5fZmxpZ2h0KTsKIAkJCWNpZnNfZGJnKEZZSSwgIiVzOiAlZCByZXF1ZXN0cyBpbiBm
bGlnaHQsIG5lZWRlZCAlZCB0b3RhbD0lZFxuIiwKLQkJCQkJX19mdW5jX18sIHNpbl9mbGlnaHQs
IG51bSwgc2NyZWRpdHMpOworCQkJCQlfX2Z1bmNfXywgaW5fZmxpZ2h0LCBudW0sIHNjcmVkaXRz
KTsKIAkJCXJldHVybiAtRURFQURMSzsKIAkJfQogCX0KLS0gCjIuMjUuMQoK
--000000000000345f3405baf53d77--
