Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DF26B489863
	for <lists+linux-cifs@lfdr.de>; Mon, 10 Jan 2022 13:15:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245333AbiAJMP6 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 10 Jan 2022 07:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245345AbiAJMPG (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 10 Jan 2022 07:15:06 -0500
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de [IPv6:2a01:488:42:1000:50ed:8234::])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 972B6C061751;
        Mon, 10 Jan 2022 04:15:05 -0800 (PST)
Received: from ip4d173d02.dynamic.kabel-deutschland.de ([77.23.61.2] helo=[192.168.66.200]); authenticated
        by wp530.webpack.hosteurope.de running ExIM with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
        id 1n6tZn-0008Q4-Rw; Mon, 10 Jan 2022 13:15:04 +0100
Message-ID: <ff982786-4033-7450-c10c-8ce71c28d6eb@leemhuis.info>
Date:   Mon, 10 Jan 2022 13:15:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: Possible regression: unable to mount CIFS 1.0 shares from older
 machines since 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
Content-Language: en-BS
To:     Davyd McColl <davydm@gmail.com>,
        "lsahlber@redhat.com" <lsahlber@redhat.com>,
        "stfrench@microsoft.com" <stfrench@microsoft.com>
Cc:     "linux-cifs@vger.kernel.org" <linux-cifs@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <D58238A4-F04E-458E-AB05-4A74235B2C65@getmailspring.com>
From:   Thorsten Leemhuis <regressions@leemhuis.info>
In-Reply-To: <D58238A4-F04E-458E-AB05-4A74235B2C65@getmailspring.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-bounce-key: webpack.hosteurope.de;regressions@leemhuis.info;1641816905;ce951aab;
X-HE-SMSGID: 1n6tZn-0008Q4-Rw
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi, this is your Linux kernel regression tracker speaking.

On 10.01.22 06:53, Davyd McColl wrote:
> 
> I'm following advice from the thread at
> https://bugzilla.kernel.org/show_bug.cgi?id=215375
> <https://bugzilla.kernel.org/show_bug.cgi?id=215375> as to how to report
> this, so please bear with me and redirect me as necessary.
> 
> Since commit 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c,

FWIW, that is "cifs: remove support for NTLM and weaker authentication
algorithms"

> I'm unable to
> mount a CIFS 1.0 share ( from a media player: mede8er med600x3d, which
> runs some older linux). Apparently I'm not the only one, according to
> that thread, though the other affected party there is windows-based.
> 
> I first logged this in the Gentoo bugtracker
> (https://bugs.gentoo.org/821895 <https://bugs.gentoo.org/821895>) and a
> reversion patch is available there for the time being.
> 
> I understand that some of the encryption methods upon which the original
> feature relied are to be removed and, as such, the ability to mount
> these older shares was removed. This is sure to affect anyone running
> older Windows virtual machines (or older, internally-visible windows
> hosts) in addition to anyone attempting to connect to shares from
> esoteric devices like mine.

> Whilst I understand the desire to clean up code and remove dead
> branches, I'd really appreciate it if this particular feature remains
> available either by kernel configuration (which suits me fine, but is
> likely to be a hassle for anyone running a binary distribution) or via
> boot parameters. In the mean-time, I'm updating my own sync software to
> support this older device because if I can't sync media to the player,
> the device is not very useful to me.

From my point of view this afaics looks like one of those issues where
the "no regressions" rule gets tricky. But I told Davyd to bring it
forward here to get it discussed in the open. I also wonder if some
middle-ground solution could be found in this particular case -- e.g.
one where the commit stated above gets reverted and the code then
slightly changed to only allow weaker authentication if the user
manually requests in somehow, for example using a module parameter or
something in /proc or /sys.

Ciao, Thorsten

P.S.: Anyway, getting this tracked:

#regzbot ^introduced 76a3c92ec9e0668e4cd0e9ff1782eb68f61a179c
#regzbot title cifs: unable to shares that require NTLM or weaker
authentication algorithms
#regzbot link: https://bugzilla.kernel.org/show_bug.cgi?id=215375
