Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 014634C9EC4
	for <lists+linux-cifs@lfdr.de>; Wed,  2 Mar 2022 08:57:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231142AbiCBH6J (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 2 Mar 2022 02:58:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237740AbiCBH6G (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 2 Mar 2022 02:58:06 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A365CB43
        for <linux-cifs@vger.kernel.org>; Tue,  1 Mar 2022 23:57:22 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id a8so1875633ejc.8
        for <linux-cifs@vger.kernel.org>; Tue, 01 Mar 2022 23:57:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c34cIaLI1PnKUQ4CoQk1O/A4OcKXNkTPVxjm7VM0/GA=;
        b=DuCS7l9Po2w3OW9w8m8GPyCCLNxHM9xXofbY1/xKLNti5sLyeJetwk66z+GH1eOyEx
         IV21DMNgDSHoipW8Pw1SUIIKbzM0RmeIrQouqcKEdtVujIkhXJwK7CI0idEbLTvtTZLK
         6sLxsezktFPu2mtybG1yln8DafxSZF3iDlqv4au0oMS+Ht+iZGq97r4vDdPjBn/YvuBJ
         KlAZItgNI0S0weCuajRXzfsQYK09fHYQiedlCvACJ2TsbqVotOa8ndJXVFJykiOR8N6M
         eJEZGpT3e1OcDQ6+2NPgKPYTdjTNSdYy1UNEEYem2XLsOXjJzGMCm3cQqwO12X57jHxC
         UvZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c34cIaLI1PnKUQ4CoQk1O/A4OcKXNkTPVxjm7VM0/GA=;
        b=ZLLIy9ht6Urx5TLIWhhaVvnlEKJk97L2+GDOxOcoJGltwpjbsw2E12oDJAVeikYu/x
         dkTvbSCBFHNotEKwhM/1qBgV6yXRH6VbI+Ph/w8tJBR0XvXWDUogvaHEIxQkCFFfufPV
         Fm9mS4/PEQksctLg2VD0M6vEvWltNJQB3Ad+miikStnleH11rDyZBtlFUt7tK4IUbvM2
         l2xxu/2WAIU/o7E/Nh5hr3mrY46UYA1+z4Bmkj+cgdL+yxlGc9/3iuu866Jkf146W37B
         hoGDRbvEXodCJY5o+W1l9pL87+q1m5GVOxefiR/S9efqhiQa/u8Bj6b+V/5IAMqN71Ow
         Ay9w==
X-Gm-Message-State: AOAM531PnF/MUbkv0Kq8IBfo9Zk8WMh2ER6+sD6zJ4Rzic7jNHrw7xI2
        B3oXK0sKjFk/3EJEzVRn12TkCjoRyCNjhxEyQKU=
X-Google-Smtp-Source: ABdhPJwYz+Hsktt6MrZavdqMi+nJJegJ4b8ukBIKJMpuPPZQKJpGz55rpg4wmKeD98KtOFgycGMjUZA9rDQVLxjNzeU=
X-Received: by 2002:a17:907:9057:b0:6cf:d288:c9ee with SMTP id
 az23-20020a170907905700b006cfd288c9eemr21221499ejc.169.1646207840955; Tue, 01
 Mar 2022 23:57:20 -0800 (PST)
MIME-Version: 1.0
References: <CAFrh3J9soC36+BVuwHB=g9z_KB5Og2+p2_W+BBoBOZveErz14w@mail.gmail.com>
 <eae5c0cc-55d1-f8db-aba0-57cee7f10332@leemhuis.info> <CAH2r5msUiBuZ74_nPVyzn=k=g0ELpcMnoTm_z30zrMSxF4sn1A@mail.gmail.com>
 <CAFrh3J-oOR1FxPrpzKsQQvronyk9fhDSqD2CY5DNsYO5Lt0ydg@mail.gmail.com>
 <CAFrh3J-TOW4JG6QND0nz_9asiv2g0DzPmxR68BBB_an9yAQ+Vw@mail.gmail.com> <CAFrh3J83sUd3tQYHzssKoBb4uQXd3MXf9e=4jLsJ9aH7z2B3oA@mail.gmail.com>
In-Reply-To: <CAFrh3J83sUd3tQYHzssKoBb4uQXd3MXf9e=4jLsJ9aH7z2B3oA@mail.gmail.com>
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Wed, 2 Mar 2022 13:27:09 +0530
Message-ID: <CANT5p=qvrV5mrE8dN=RAmCBefGd4_3BzTfM7U98eqmZN2ZVjEg@mail.gmail.com>
Subject: Re: Failure to access cifs mount of samba share after resume from
 sleep with 5.17-rc5
To:     Satadru Pramanik <satadru@gmail.com>
Cc:     Steve French <smfrench@gmail.com>,
        Thorsten Leemhuis <regressions@leemhuis.info>,
        CIFS <linux-cifs@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
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

On Wed, Mar 2, 2022 at 3:51 AM Satadru Pramanik <satadru@gmail.com> wrote:
>
> I have put the trace.dat and other debug files here since I can not
> attach the files to a message to the list. (Apparently the trace.dat
> file is too large.)
>
> https://drive.google.com/drive/folders/1wEi968RbXxivXMMH8J7XUsHhrxu9OWDX?usp=sharing
>
> On Mon, Feb 28, 2022 at 11:12 PM Satadru Pramanik <satadru@gmail.com> wrote:
> >
> > The trace.dat file is attached, covering the period before suspend,
> > and through wake several hours later, when the mount no longer worked,
> > and showed the CIFS: VFS: cifs_tree_connect: could not find
> > superblock: -22 message, and through when I unmounted and remounted
> > the share, which then started working.
> >
> > On Mon, Feb 28, 2022 at 9:31 AM Satadru Pramanik <satadru@gmail.com> wrote:
> > >
> > > Here is the DebugData from before and after from the system with the
> > > failed mount.
> > > Both systems are now running 5.17-rc6.
> > >
> > > Working on the trace-cmd now.
> > >
> > > On Sun, Feb 27, 2022 at 9:37 PM Steve French <smfrench@gmail.com> wrote:
> > > >
> > > > I would like to see the output of:
> > > >
> > > > /proc/fs/cifs/DebugData before and after the failure if possible.
> > > >
> > > > In addition, there would be some value in seeing trace information
> > > > (e.g start tracing by
> > > > "trace-cmd record -e cifs" before the failure and then forward the
> > > > debug information displayed by "trace-cmd show" after the failure)
> > > >
> > > > On Sun, Feb 27, 2022 at 7:55 AM Thorsten Leemhuis
> > > > <regressions@leemhuis.info> wrote:
> > > > >
> > > > > [TLDR: I'm adding the regression report below to regzbot, the Linux
> > > > > kernel regression tracking bot; all text you find below is compiled from
> > > > > a few templates paragraphs you might have encountered already already
> > > > > from similar mails.]
> > > > >
> > > > > Hi, this is your Linux kernel regression tracker. Top-posting for once,
> > > > > to make this easily accessible to everyone.
> > > > >
> > > > > CCing the regression mailing list, as it should be in the loop for all
> > > > > regressions, as explained here:
> > > > > https://www.kernel.org/doc/html/latest/admin-guide/reporting-issues.html
> > > > >
> > > > > To be sure below issue doesn't fall through the cracks unnoticed, I'm
> > > > > adding it to regzbot, my Linux kernel regression tracking bot:
> > > > >
> > > > > #regzbot ^introduced v5.16.11..v5.17-rc5
> > > > > #regzbot title cifs: Failure to access cifs mount of samba share after
> > > > > resume from sleep
> > > > > #regzbot ignore-activity
> > > > >
> > > > > Reminder for developers: when fixing the issue, please add a 'Link:'
> > > > > tags pointing to the report (the mail quoted above) using
> > > > > lore.kernel.org/r/, as explained in
> > > > > 'Documentation/process/submitting-patches.rst' and
> > > > > 'Documentation/process/5.Posting.rst'. This allows the bot to connect
> > > > > the report with any patches posted or committed to fix the issue; this
> > > > > again allows the bot to show the current status of regressions and
> > > > > automatically resolve the issue when the fix hits the right tree.
> > > > >
> > > > > I'm sending this to everyone that got the initial report, to make them
> > > > > aware of the tracking. I also hope that messages like this motivate
> > > > > people to directly get at least the regression mailing list and ideally
> > > > > even regzbot involved when dealing with regressions, as messages like
> > > > > this wouldn't be needed then. And don't worry, if I need to send other
> > > > > mails regarding this regression only relevant for regzbot I'll send them
> > > > > to the regressions lists only (with a tag in the subject so people can
> > > > > filter them away). With a bit of luck no such messages will be needed
> > > > > anyway.
> > > > >
> > > > > Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> > > > >
> > > > > P.S.: As the Linux kernel's regression tracker I'm getting a lot of
> > > > > reports on my table. I can only look briefly into most of them and lack
> > > > > knowledge about most of the areas they concern. I thus unfortunately
> > > > > will sometimes get things wrong or miss something important. I hope
> > > > > that's not the case here; if you think it is, don't hesitate to tell me
> > > > > in a public reply, it's in everyone's interest to set the public record
> > > > > straight.
> > > > >
> > > > >
> > > > > On 27.02.22 03:36, Satadru Pramanik wrote:
> > > > > > I'm on a x86_64 ubuntu 22.04 system accessing a similar system running
> > > > > > samba Version 4.13.14-Ubuntu. Both systems are on ubuntu mainline
> > > > > > kernel 5.17-rc5.
> > > > > >
> > > > > > I have a samba share mounted from my fstab, and file access works fine.
> > > > > > Upon suspending my system and resuming though, the mounted samba share
> > > > > > is inaccessible, and my dmesg has many "CIFS: VFS: cifs_tree_connect:
> > > > > > could not find superblock: -22" messages.
> > > > > >
> > > > > > Unmounting and remounting the share restores access.
> > > > > >
> > > > > > When I boot into kernel 5.16.11, I do not have this issue. The cifs
> > > > > > share is accessible just fine after a suspend/resume cycle.
> > > > > >
> > > > > > I assume this is a regression with 5.17? Is there any information
> > > > > > worth providing which might help debug and fix this issue?
> > > > > >
> > > > > > Regards,
> > > > > >
> > > > > > Satadru Pramanik
> > > > >
> > > > > --
> > > > > Additional information about regzbot:
> > > > >
> > > > > If you want to know more about regzbot, check out its web-interface, the
> > > > > getting start guide, and the references documentation:
> > > > >
> > > > > https://linux-regtracking.leemhuis.info/regzbot/
> > > > > https://gitlab.com/knurd42/regzbot/-/blob/main/docs/getting_started.md
> > > > > https://gitlab.com/knurd42/regzbot/-/blob/main/docs/reference.md
> > > > >
> > > > > The last two documents will explain how you can interact with regzbot
> > > > > yourself if your want to.
> > > > >
> > > > > Hint for reporters: when reporting a regression it's in your interest to
> > > > > CC the regression list and tell regzbot about the issue, as that ensures
> > > > > the regression makes it onto the radar of the Linux kernel's regression
> > > > > tracker -- that's in your interest, as it ensures your report won't fall
> > > > > through the cracks unnoticed.
> > > > >
> > > > > Hint for developers: you normally don't need to care about regzbot once
> > > > > it's involved. Fix the issue as you normally would, just remember to
> > > > > include 'Link:' tag in the patch descriptions pointing to all reports
> > > > > about the issue. This has been expected from developers even before
> > > > > regzbot showed up for reasons explained in
> > > > > 'Documentation/process/submitting-patches.rst' and
> > > > > 'Documentation/process/5.Posting.rst'.
> > > >
> > > >
> > > >
> > > > --
> > > > Thanks,
> > > >
> > > > Steve

The DebugData shows that the connection and smb session are fine, but
the tree connect is not in a good state.
Similarly, the trace output shows that connection was reconnected
successfully, SMB session was reconnected as well. However, the tree
connect did not go over the wire.

> The trace.dat file is attached, covering the period before suspend,
> and through wake several hours later, when the mount no longer worked,
> and showed the CIFS: VFS: cifs_tree_connect: could not find
> superblock: -22 message, and through when I unmounted and remounted
> the share, which then started working.

This suggests to me that the cifs_tcp_get_super is failing.
This is odd, since it looks up the server as pointers.
Did we start undercounting the ref count somewhere?

-- 
Regards,
Shyam
