Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C51A4BBA20
	for <lists+linux-cifs@lfdr.de>; Fri, 18 Feb 2022 14:30:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235491AbiBRNab (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 18 Feb 2022 08:30:31 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:55808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229737AbiBRNaa (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 18 Feb 2022 08:30:30 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B95729692D;
        Fri, 18 Feb 2022 05:30:13 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id e26so9985086vso.3;
        Fri, 18 Feb 2022 05:30:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vWenGxp5Hz0NOJbMbHu6FiVIIwXifwzr2lS+VLp64wQ=;
        b=Dl7Spd4yNqCuZBoBWQ/jbzaROWYYDSXlAIbRYxsdHcj2Vk4uWrPgtygnzMAwmqichG
         ZEdhy655LDxtJcNX3M5rhVwtJwH0YGIIkx597JAqEe6KJbVQRrUgXGdsEER+JnT4bBtl
         Bk32TaOyFiI0gGAJYPTh9AzRcYp2kbX+ZxDtjHjvWAXKzBGSS6SLRrVAY3Oy/vVlD3em
         iJKKQS8TxI7f15ab5HzMCEZNxExmycAaNOOCfhR/kkIratGMLSFQvbzDTWZ5GuBH9U09
         Zkqgmjx0ODsGz6aqMP0XnelPPycHi8tq5TTW4wTPjTwqWG0tLTXpxGNUzwq/QKvra0AL
         z+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vWenGxp5Hz0NOJbMbHu6FiVIIwXifwzr2lS+VLp64wQ=;
        b=eIuZlne/G1Wbuc/xJEt7z8q8FXmsaTmJTmkWsoFJ4MYdLqmoBiK5YRhK/lxWfdLKsI
         ppclfHIlhYd9Uzz6CDzGotPaLHh1nk83LfPw7GbHDjiMSzp43L+Oex0/ahWAyhTCy+uy
         qrUzTSv9Wbh/iogaZPv6aIn/HZsDKazi56OQZhV3awe5wQ5/3FUJYl80X9X5QMz6noYa
         umGjZpHuOGMsQdVKCRHL0rB1zG2vQJfvJG9GbNIDUGpxitbk8WgjOCkIzL4zj00KwIfx
         bPyVFTdRBUsR3pFS+oB/YUJ+0l4ueDGc29+FwVzsMA/yIps4FrMocnVHWqO6SIWILbkg
         u17g==
X-Gm-Message-State: AOAM531jF6+dxmfAxLnKyXkuhRCVGF2yIwknRFBe0TmDXD5gUhEv0j52
        N1R6JF5JEiEEwL4C2RfXPK0ForWZ9vdc6jOwdCuSPbW/RR4=
X-Google-Smtp-Source: ABdhPJySd6CUHOISiL0QEGym/Sp0aVsp5nhMsiQyDAio7YHWNl07/Scxwvde83+37lTGa1k1YtOGSVPeQOcDkEas+ms=
X-Received: by 2002:a05:6102:6c6:b0:315:dd8c:a with SMTP id
 m6-20020a05610206c600b00315dd8c000amr3637264vsg.57.1645191012244; Fri, 18 Feb
 2022 05:30:12 -0800 (PST)
MIME-Version: 1.0
References: <CAJjP=Bt52AW_w2sKnM=MbckPkH1hevPMJVWm_Wf+wThmR72YTg@mail.gmail.com>
 <CAH2r5mt_2f==5reyc0HmMLvYJVmP4Enykwauo+LQoFGFbVFeRQ@mail.gmail.com>
 <CAJjP=BvNVOj3KRnhFgk6xiwnxVhxE-sN98-pr6e1Kzc5Xg5EvQ@mail.gmail.com>
 <CAH2r5mvsetx5G+c=8ePh+X8ng7FvMrnuM9+FJ4Sid4b3E+T41Q@mail.gmail.com>
 <CAJjP=BvqZUnJPq=C0OUKbXr=mbJd7a6YDSJC-sNY1j_33_e-uw@mail.gmail.com>
 <CAN05THSGwCKckQoeB6D91iBv0Sed+ethK7tde7GSc1UzS-0OYg@mail.gmail.com>
 <CAJjP=BvcWrF-k_sFxak1mgHAHVVS7_JZow+h_47XB1VzG2+Drw@mail.gmail.com>
 <ebf8c487-0377-834e-fbb7-725cceae1fbb@leemhuis.info> <CAN05THRJJj48ueb34t18Yj=JYuhiwZ8hTvOssX4D6XhNpjx-bg@mail.gmail.com>
 <f7eb4a3e-9799-3fe4-d464-d84dd9e64510@leemhuis.info>
In-Reply-To: <f7eb4a3e-9799-3fe4-d464-d84dd9e64510@leemhuis.info>
From:   Davyd McColl <davydm@gmail.com>
Date:   Fri, 18 Feb 2022 15:30:00 +0200
Message-ID: <CAJjP=Bus1_ce4vbHXpiou1WrSe8a61U1NzGm4XvN5fYCPGNikA@mail.gmail.com>
Subject: Re: Possible regression: unable to mount CIFS 1.0 shares from older
 machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
To:     Thorsten Leemhuis <regressions@leemhuis.info>
Cc:     ronnie sahlberg <ronniesahlberg@gmail.com>,
        Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Apologies for the late response - I didn't see the last bit of the
mail asking for more info.

Thorsten: the only group policy modification I have on my win11
machine (which was
loaded fresh not too long ago) is to enable insecure guest logins,
which is obviously
required for samba shares where the share allows a guest login without
any password.
I have to enable this to browse the shares on my Gentoo machine from the win11
machine anyway.

-d

On Fri, 28 Jan 2022 at 16:02, Thorsten Leemhuis
<regressions@leemhuis.info> wrote:
>
> On 28.01.22 14:50, ronnie sahlberg wrote:
> > On Fri, Jan 28, 2022 at 11:30 PM Thorsten Leemhuis
> > <regressions@leemhuis.info> wrote:
> >>
> >> Hi, this is your Linux kernel regression tracker speaking.
> >>
> >> Top-posting for once, to make this easy accessible to everyone.
> >>
> >> Davyd, Ronnie, and/or Steve: What the status here? It seems after some
> >> productive debugging back and forth it seems everyone forgot about this.
> >> Or was progress made somewhere and I just missed it?
> >
> > I tried but can not find a system old enough to reproduce.
> > Remember, this is an authentication mechanism that Microsoft begged
> > people to stop using and migrate away from over 20 years ago.
> > Win2k works just fine, as does samba3.0.
> > I have no idea if Samba 2.0 works with current cifs.ko   but then
> > again  I seriously doubt you can even get samba 2.0 to even compile on
> > a modern
> > machine as so many APIs have changed or just gone away since the late 90s.
> >
> > I tried, but there is just so much time you can spend on something
> > that was declared obsolete 20 years ago.
>
> I can fully understand that -- otoh then I'd normally say "well, then
> let's just revert the commit that causes this". But in this case I can
> understand that it might not be wise.
>
> There is one thing that would help me to judge this situation better:
>
> Davyd, did a default Win11 install connect fine with standard settings
> or did you have to modify something in the registry to make it work
> there (which you might have done years ago in case you updated the
> machine!), as Ronnie suspected? Or was this already clarified in this
> thread somewhere and I just missed that (in that case: sorry!)?
>
> Ciao, Thorsten
>
> >> Ciao, Thorsten
> >>
> >> #regzbot poke
> >>
> >>
> >> On 12.01.22 06:49, Davyd McColl wrote:
> >>> Hi Ronnie
> >>>
> >>> The regular fstab line for this mount is:
> >>>
> >>> //mede8er/mede8er  /mnt/mede8er-smb  cifs
> >>> noauto,guest,users,uid=daf,gid=daf,iocharset=utf8,vers=1.0,nobrl,sec=none
> >>>  0  0
> >>>
> >>> Altering the end of the options from "sec=none" to
> >>> "username=guest,sec=ntlmssp" or "guest,sec=ntlmssp" results in failure
> >>> to mount
> >>> (tested on my patched kernel, which still supports the original fstab
> >>> line), with dmesg containing:
> >>>
> >>> [45753.525219] CIFS: VFS: Use of the less secure dialect vers=1.0 is
> >>> not recommended unless required for acc
> >>> ess to very old servers
> >>> [45753.525222] CIFS: Attempting to mount \\mede8er\mede8er
> >>> [45756.861351] CIFS: VFS: Unable to select appropriate authentication method!
> >>> [45756.861361] CIFS: VFS: \\mede8er Send error in SessSetup = -22
> >>> [45756.861395] CIFS: VFS: cifs_mount failed w/return code = -22
> >>>
> >>> There is no way that I know of to set up users for smb auth on this
> >>> device - it only supports guest connections.
> >>>
> >>> -d
> >>>
> >>>
> >>> On Wed, 12 Jan 2022 at 04:32, ronnie sahlberg <ronniesahlberg@gmail.com> wrote:
> >>>>
> >>>> Thanks for the network traces.
> >>>>
> >>>> In the traces, both win11 and linux are not using even NTLM but the
> >>>> even older "share password" authentication mode where you specify a
> >>>> password for the share in the TreeConnect command.
> >>>> That is something I think we should not support at all.
> >>>>
> >>>> What is the exact mount command line you use?
> >>>> Can you try mounting the share using a username and ntlmssp ?
> >>>> I.e. username=your-user,sec=ntlmssp  on the mount command
> >>>>
> >>>> regards
> >>>> ronnie sahlberg
> >>>>
> >>>> On Wed, Jan 12, 2022 at 6:57 AM Davyd McColl <davydm@gmail.com> wrote:
> >>>>>
> >>>>> Hi Steve
> >>>>>
> >>>>> As requested, wireshark captures to the device in question, as well as
> >>>>> the fstab entry I have for the device:
> >>>>> - win11, browsing with explorer
> >>>>> - win11, net use
> >>>>> - unpatched linux 5.16.0 attempt to mount
> >>>>> - patched linux 5.16.0 successful mount
> >>>>> - fstab entry - note that I have to specify samba version 1.0 as the
> >>>>> default has changed and the mount fails otherwise. Explicitly
> >>>>> specifying 2.0 errors and suggests that I should select a different
> >>>>> version.
> >>>>>
> >>>>> -d
> >>>>>
> >>>>> On Tue, 11 Jan 2022 at 00:13, Steve French <smfrench@gmail.com> wrote:
> >>>>>>
> >>>>>> I would be surprised if Windows 11 still negotiates (with default
> >>>>>> registry settings) SMB1 much less NTLMv1 in SMB1, but I have not tried
> >>>>>> Windows 11 with an NTLMv1 only server (they are hard to find - I may
> >>>>>> have an original NT4 and an NT3.5 CD somewhere - might be possible to
> >>>>>> install a VM with NT3.5 but that is really really old and not sure I
> >>>>>> can find those CDs).
> >>>>>>
> >>>>>> Is it possible to send me the wireshark trace (or other network trace)
> >>>>>> of the failing mount from Linux and also the one with the succeeding
> >>>>>> NET USE from Windows 11 to the same server?
> >>>>>>
> >>>>>> Hopefully it is something unrelated to NTLMv1, there has been a LOT of
> >>>>>> pushback across the world, across products in making sure no one uses
> >>>>>> SMB1 anymore.  See e.g.
> >>>>>> https://techcommunity.microsoft.com/t5/storage-at-microsoft/stop-using-smb1/ba-p/425858
> >>>>>> and https://twitter.com/nerdpyle/status/776900804712148993
> >>>>>>
> >>>>>> On Mon, Jan 10, 2022 at 2:30 PM Davyd McColl <davydm@gmail.com> wrote:
> >>>>>>>
> >>>>>>> I don't understand. I tracked down the exact commit where the issue
> >>>>>>> occurs with a 2 hour git bisect. This was after first confirming that
> >>>>>>> my older 5.14 kernel did not display the symptoms. I can still connect
> >>>>>>> to the share via windows 11 explorer. I don't know what else I need to
> >>>>>>> do here to show where the issue was introduced?
> >>>>>>>
> >>>>>>> Apologies for bouncing mails - literally no email client I have seems
> >>>>>>> to be capable of plaintext emails, so every time I forget, I have to
> >>>>>>> find a browser with the gmail web interface to reply.
> >>>>>>>
> >>>>>>> -d
> >>>>>>>
> >>>>>>> On Mon, 10 Jan 2022 at 19:31, Steve French <smfrench@gmail.com> wrote:
> >>>>>>>>
> >>>>>>>> I want to make sure that we don't have an unrelated regression
> >>>>>>>> involved here since NTLMv2 replaced NTLMv1 over 20 years ago (googling
> >>>>>>>> this e.g. I see "NTLMv2, introduced in Windows NT 4.0 SP4 and natively
> >>>>>>>> supported in Windows 2000")  and should be the default for Windows
> >>>>>>>> NT4, Windows 2000 etc. as well as any version of Samba from the last
> >>>>>>>> 15 years+.  I have significant concerns with adding mechanisms that
> >>>>>>>> were asked to be disabled ~19 years ago e.g. see
> >>>>>>>> https://support.microsoft.com/en-us/topic/security-guidance-for-ntlmv1-and-lm-network-authentication-da2168b6-4a31-0088-fb03-f081acde6e73
> >>>>>>>> due to security concerns.
> >>>>>>>>
> >>>>>>>> Can we double check that there are not other issues involved in your example?
> >>>>>>>>
> >>>>>>>> The concerns about NTLMv1 security concerns (and why it should never
> >>>>>>>> be used) are very persuasive e.g. many articles like
> >>>>>>>> https://miriamxyra.com/2017/11/08/stop-using-lan-manager-and-ntlmv1/
> >>>>>>>>
> >>>>>>>> On Mon, Jan 10, 2022 at 7:48 AM Davyd McColl <davydm@gmail.com> wrote:
> >>>>>>>>>
> >>>>>>>>> Good day
> >>>>>>>>>
> >>>>>>>>> I'm following advice from the thread at
> >>>>>>>>> https://bugzilla.kernel.org/show_bug.cgi?id=215375 as to how to report
> >>>>>>>>> this, so please bear with me and redirect me as necessary.
> >>>>>>>>>
> >>>>>>>>> Since commit 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c, I'm unable to
> >>>>>>>>> mount a CIFS 1.0 share ( from a media player: mede8er med600x3d, which
> >>>>>>>>> runs some older linux). Apparently I'm not the only one, according to
> >>>>>>>>> that thread, though the other affected party there is windows-based.
> >>>>>>>>>
> >>>>>>>>> I first logged this in the Gentoo bugtracker
> >>>>>>>>> (https://bugs.gentoo.org/821895) and a reversion patch is available
> >>>>>>>>> there for the time being.
> >>>>>>>>>
> >>>>>>>>> I understand that some of the encryption methods upon which the
> >>>>>>>>> original feature relied are to be removed and, as such, the ability to
> >>>>>>>>> mount these older shares was removed. This is sure to affect anyone
> >>>>>>>>> running older Windows virtual machines (or older, internally-visible
> >>>>>>>>> windows hosts) in addition to anyone attempting to connect to shares
> >>>>>>>>> from esoteric devices like mine.
> >>>>>>>>>
> >>>>>>>>> Whilst I understand the desire to clean up code and remove dead
> >>>>>>>>> branches, I'd really appreciate it if this particular feature remains
> >>>>>>>>> available either by kernel configuration (which suits me fine, but is
> >>>>>>>>> likely to be a hassle for anyone running a binary distribution) or via
> >>>>>>>>> boot parameters. In the mean-time, I'm updating my own sync software
> >>>>>>>>> to support this older device because if I can't sync media to the
> >>>>>>>>> player, the device is not very useful to me.
> >>>>>>>>>
> >>>>>>>>> Thanks
> >>>>>>>>> -d
> >>>>>>>>
> >>>>>>>>
> >>>>>>>>
> >>>>>>>> --
> >>>>>>>> Thanks,
> >>>>>>>>
> >>>>>>>> Steve
> >>>>>>>
> >>>>>>>
> >>>>>>>
> >>>>>>> --
> >>>>>>> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> >>>>>>> If you say that getting the money is the most important thing
> >>>>>>> You will spend your life completely wasting your time
> >>>>>>> You will be doing things you don't like doing
> >>>>>>> In order to go on living
> >>>>>>> That is, to go on doing things you don't like doing
> >>>>>>>
> >>>>>>> Which is stupid.
> >>>>>>>
> >>>>>>> - Alan Watts
> >>>>>>> https://www.youtube.com/watch?v=-gXTZM_uPMY
> >>>>>>>
> >>>>>>> Quidquid latine dictum sit, altum sonatur.
> >>>>>>
> >>>>>>
> >>>>>>
> >>>>>> --
> >>>>>> Thanks,
> >>>>>>
> >>>>>> Steve
> >>>>>
> >>>>>
> >>>>>
> >>>>> --
> >>>>> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> >>>>> If you say that getting the money is the most important thing
> >>>>> You will spend your life completely wasting your time
> >>>>> You will be doing things you don't like doing
> >>>>> In order to go on living
> >>>>> That is, to go on doing things you don't like doing
> >>>>>
> >>>>> Which is stupid.
> >>>>>
> >>>>> - Alan Watts
> >>>>> https://www.youtube.com/watch?v=-gXTZM_uPMY
> >>>>>
> >>>>> Quidquid latine dictum sit, altum sonatur.
> >>>
> >>>
> >>>
> >>
> >



-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
If you say that getting the money is the most important thing
You will spend your life completely wasting your time
You will be doing things you don't like doing
In order to go on living
That is, to go on doing things you don't like doing

Which is stupid.

- Alan Watts
https://www.youtube.com/watch?v=-gXTZM_uPMY

Quidquid latine dictum sit, altum sonatur.
