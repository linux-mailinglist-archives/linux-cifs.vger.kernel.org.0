Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 192FD2DDAC9
	for <lists+linux-cifs@lfdr.de>; Thu, 17 Dec 2020 22:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727769AbgLQVXx (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 17 Dec 2020 16:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726689AbgLQVXx (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 17 Dec 2020 16:23:53 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08F3C0617A7
        for <linux-cifs@vger.kernel.org>; Thu, 17 Dec 2020 13:23:12 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id o13so93945lfr.3
        for <linux-cifs@vger.kernel.org>; Thu, 17 Dec 2020 13:23:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=DmMUK+QXW2KkulLakiYCBygpvxxHlBl3K/yPf/mEUco=;
        b=mco18n5AYK1sb5Xve1KIvIGcexD0C7yOcOIe+35bWPRl4+XFO3x+DFzxfvj6k2Zs20
         7jWKZ3B/5dMcQUKeINQizoWgzlUHkTxH/Dq2Hn6V6p2E7hrz5pEZRCRYW8YDFvs9zsbv
         p/vdnbdiGz8XHK3pY1c2nVvPmzQDAEPtzutrwG1m/zzK62WWkVeKg9aTUhcg8PUqlCT/
         z8oDrhDDAKGHPqfS7GWKMzESQdm0H8KQ4V4fOyVBYXdkHLxApY7tGgcTVPeujqvGrQok
         dXo7UPwiLLJuq938YdLi78zoPDtf3FDu/J2+dHnwtqwKq+C+gU75Ci6VMkh6BmgfZqU7
         /PUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=DmMUK+QXW2KkulLakiYCBygpvxxHlBl3K/yPf/mEUco=;
        b=lRPlEG+j0MgU9WN7twULggSVFasjQ5otv15xrgBanZptmvuQzVin3iOmEQUVaEElZT
         nA74t7ra5l5xUAk1Pr+81WROTciRXde2K39IwWp40PrKle15PAxoT4IE8ilH6TuPe+x3
         Rgw2m2qWwG1Sxv4zAGGgAibnDuqfTO+k352F0N/CiMB5dVssV+7HNjDtmNXGNLdlzhrZ
         aZXnC+7z8DMLj6cLelt9rkNs/N9zh/VH3PxI2U6kZjMiRA7G/JbMsJA3y1lz36sl8WZZ
         ixFzn6YQ0eF8IHJyA4fs41rikLLfFD9ax/YdP23HDN4GPAxN5wIkYB7rmPVVFanH7CjK
         eyHw==
X-Gm-Message-State: AOAM5310LGJ6Fc/WGw7n3gyBpqgld2bu6M/lP3C1a8EjseOdkHLbw8/M
        JPWwZZMRNL0IGFLnkSw2obTkU8lFvUnLyNuhvXk=
X-Google-Smtp-Source: ABdhPJxHS68aQOlMMU4X9sPaxufYeQT8nFGwsvwuXJpih1f7ghDIdvYYY8ScyeMrPZAb/s6B/c/e+odhA8NyW9+SVJU=
X-Received: by 2002:a19:f11e:: with SMTP id p30mr244444lfh.395.1608240191074;
 Thu, 17 Dec 2020 13:23:11 -0800 (PST)
MIME-Version: 1.0
References: <2e241ceaece6485289b1cddb84ec77ca@atos.net> <04d24a21a7a462b3dc316959c3a3b1c8be8caac3.camel@redhat.com>
 <CAH2r5mt9r6nWop_ekbe1CsinztUiGhP2-bxWFkRqHXOP=MXcVQ@mail.gmail.com> <c49c0a18c228e6aa43dbb2cbab7e0a266d1c0371.camel@redhat.com>
In-Reply-To: <c49c0a18c228e6aa43dbb2cbab7e0a266d1c0371.camel@redhat.com>
From:   Steve French <smfrench@gmail.com>
Date:   Thu, 17 Dec 2020 15:22:59 -0600
Message-ID: <CAH2r5muOOL-MWojyKK55vcnKfS9w5N-cLGCNw0v04JDVrGsPTQ@mail.gmail.com>
Subject: Re: [gssproxy] cifs-utils, Linux cifs kernel client and gssproxy
To:     Simo Sorce <simo@redhat.com>
Cc:     The GSS-Proxy developers and users mailing list 
        <gss-proxy@lists.fedorahosted.org>,
        "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "samba-technical@lists.samba.org" <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

A couple of more specific questions:

1) Do you have a link to how the various user space tools that would
often need to use kerberos (e.g. "smbclient" and "smbcacls") integrate
with this so I could see some examples of how they tie into your
proxy?

2) Does it use the kernel keyring to store credentials or rely on the
traditional kerberos key cache?  Presumably there continues to be a
drive to keep as many credentials as possible in the kernel for
maximal security in this very challenging recent security landscape.

3) Besides Kerberos and NTLMSSP what other auth protocols do you
support in gssproxy (e.g. PKU2U is one I see commonly in the list of
SPNEGO OIDs during auth).   There has been a push recently to move
away from NTLMv2/NTLMSSP (which is often encapsulated in SPNEGO) to
stronger 'peer to peer' protocols.   Macs IIRC have peer to peer
Kerberos and presumably PKU2U (see
https://tools.ietf.org/id/draft-zhu-pku2u-07.html) is reasonably
common in Windows.    It would be useful if you already have support
for PKU2U in your libraries or know how to tie them in so we would not
have to rely on NTLMSSP/NTLMv2 for peer to peer (systems that are
joined to a domain like Samba AD or Active Directory or AAD) and could
improve security in non domain joined cases.

4) Does gssproxy integrate in any way with Samba server?  There would
be strong interest in having easy ways to plug in additional security
protocols transparently into the client (cifs.ko and user space tools
like smbclient and smbcacls and Ronnie's libsmb3 etc.) and servers
(Samba and ksmbd) - so e.g. if O_AUTH became useful for file sharing,
could gssproxy help transparently enable this on the client and server
(since the SPNEGO flows, at least for SMB3 are fairly opaque and the
client and server don't really care what auth is negotiated as long as
the underlying libraries send the right list of auth protocols and
negotiate the correct 'preferred' one that was requested on mount or
in the /etc config files).

On Thu, Dec 17, 2020 at 7:39 AM Simo Sorce <simo@redhat.com> wrote:
>
> Hi Steve,
>
> GSSAPI and krb5 as implemented in system krb5 libraries exists from
> longer than Samba has implemented those capabilities, I do not think it
> make sense to reason along those lines.
>
> GSS-Proxy has been built with a protocol to talk from the kernel that
> resolved a number of issues for knfsd (eg big packet sizes when a MS-
> PAC is present).
>
> And Samba uses internally exactly the same krb5 mechanism as it defers
> to the kerberos libraries as well.
>
> Additionally GSS-Proxy can be very easily extended to also do NTLMSSP
> using the same interface as I have built the gssntlmssp long ago from
> the MS spec, and is probably the most correct NTLMSSP implementation
> you can find around.
>
> Gssntlmssp also has a Winbind backend so you get automaticaly access to
> whatever cached credentials Winbindd has for users as a bonus (although
> the integration can be improved there), yet you *can* use it w/o
> Winbindd just fine providing a credential file (smbpasswd format
> compatible).
>
> GSS-Proxy is already integrated in distributions because it is used by
> knfsd, and can be as easily used by cifsd, and you *should* really use
> it there, so we can have a single, consistent, maintained, mechanism
> for server side GSS authentication, and not have to repeat and reinvent
> kernel to userspace mechanisms.
>
> And if you add it for cifsd you have yet another reason to do it for
> cifs.ko as well.
>
> Finally the GSS-Proxy mechanism is namespace compatible, so you also
> get the ability to define different auth daemons per different
> containers, no need to invent new mechanisms for that or change yet
> again protocols/userspace to obtain container capabilities.
>
> For the client we'll need to add some XDR parsing functions in kernel,
> they were omitted from my original patches because there was no client
> side kernel consumer back then, but it i an easy, mechanical change.
>
> HTH,
> Simo.
>
> On Wed, 2020-12-16 at 16:43 -0600, Steve French wrote:
> > generally I would feel more comfortable using something (library or
> > utility) in Samba (if needed) for additional SPNEGO support if
> > something is missing (in what the kernel drivers are doing to
> > encapsulate Active Directory or Samba AD krb5 tickets in SPNEGO) as
> > Samba is better maintained/tested etc. than most components.  Is there
> > something in Samba that could be used here instead of having a
> > dependency on another project - Samba has been doing Kerberos/SPNEGO
> > longer than most ...?   There are probably others (jra, Metze etc.)
> > that have would know more about gssproxy vs. Samba equivalents though
> > and would defer to them ...
> >
> > On Wed, Dec 16, 2020 at 8:33 AM Simo Sorce <simo@redhat.com> wrote:
> > > Hi Michael,
> > > as you say the best course of action would be for cifs.ko to move to
> > > use the RPC interface we defined for knfsd (with any extensions that
> > > may  be needed), and we had discussions in the past with cifs upstrea=
m
> > > developers about it. But nothing really materialized.
> > >
> > > If something is needed in the short term, I thjink the quickest cours=
e
> > > of action is indeed to change the userspace helper to use gssapi
> > > function calls, so that they can be intercepted like we do for rpc.gs=
sd
> > > (nfs client's userspace helper).
> > >
> > > Unfortunately I do not have the cycles to work on that myself at this
> > > time :-(
> > >
> > > HTH,
> > > Simo.
> > >
> > > On Wed, 2020-12-16 at 10:01 +0000, Weiser, Michael wrote:
> > > > Hello,
> > > >
> > > > I have a use-case for authentication of Linux cifs client mounts wi=
thout the user being present (e.g. from batch jobs) using gssproxy's impers=
onation feature with Kerberos Constrained Delegation similar to how it can =
be done for NFS[1].
> > > >
> > > > My understanding is that currently neither the Linux cifs kernel cl=
ient nor cifs-utils userland tools support acquiring credentials using gssp=
roxy. The former uses a custom upcall interface to talk to cifs.spnego from=
 cifs-utils. The latter then goes looking for Kerberos ticket caches using =
libkrb5 functions, not GSSAPI, which prevents gssproxy from interacting wit=
h it.[2]
> > > >
> > > > From what I understand, the preferred method would be to switch the=
 Linux kernel client upcall to the RPC protocol defined by gssproxy[3] (as =
has been done for the Linux kernel NFS server already replacing rpc.svcgssd=
[4]). The kernel could then, at least optionally, talk to gssproxy directly=
 to try and obtain credentials.
> > > >
> > > > Failing that, cifs-utils' cifs.spnego could be switched to GSSAPI s=
o that gssproxy's interposer plugin could intercept GSSAPI calls and provid=
e them with the required credentials (similar to the NFS client rpc.gssd[5]=
).
> > > >
> > > > Assuming my understanding is correct so far:
> > > >
> > > > Is anyone doing any work on this and could use some help (testing, =
coding)?
> > > > What would be expected complexity and possible roadblocks when tryi=
ng to make a start at implementing this?
> > > > Or is the idea moot due to some constraint or recent development I'=
m not aware of?
> > > >
> > > > I have found a recent discussion of the topic on linux-cifs[6] whic=
h provided no definite answer though.
> > > >
> > > > As a crude attempt at an explicit userspace workaround I tried but =
failed to trick smbclient into initialising a ticket cache using gssproxy f=
or cifs.spnego to find later on.
> > > > Is this something that could be implemented without too much redund=
ant effort (or should already work, perhaps using a different tool)?
> > > >
> > > > [1] https://github.com/gssapi/gssproxy/blob/main/docs/NFS.md#user-i=
mpersonation-via-constrained-delegation
> > > > [2] https://pagure.io/gssproxy/issue/56
> > > > [3] https://github.com/gssapi/gssproxy/blob/main/docs/ProtocolDocum=
entation.md
> > > > [4] https://github.com/gssapi/gssproxy/blob/main/docs/NFS.md#nfs-se=
rver
> > > > [5] https://github.com/gssapi/gssproxy/blob/main/docs/NFS.md#nfs-cl=
ient
> > > > [6] https://www.spinics.net/lists/linux-cifs/msg20182.html
> > > > --
> > > > Thanks,
> > > > Michael
> > > > _______________________________________________
> > > > gss-proxy mailing list -- gss-proxy@lists.fedorahosted.org
> > > > To unsubscribe send an email to gss-proxy-leave@lists.fedorahosted.=
org
> > > > Fedora Code of Conduct: https://docs.fedoraproject.org/en-US/projec=
t/code-of-conduct/
> > > > List Guidelines: https://fedoraproject.org/wiki/Mailing_list_guidel=
ines
> > > > List Archives: https://lists.fedorahosted.org/archives/list/gss-pro=
xy@lists.fedorahosted.org
> > >
> > > --
> > > Simo Sorce
> > > RHEL Crypto Team
> > > Red Hat, Inc
> > >
> > >
> > >
> > >
> >
> >
>
> --
> Simo Sorce
> RHEL Crypto Team
> Red Hat, Inc
>
>
>
>


--=20
Thanks,

Steve
