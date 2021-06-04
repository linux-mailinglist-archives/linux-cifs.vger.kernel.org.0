Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94A6E39B2C5
	for <lists+linux-cifs@lfdr.de>; Fri,  4 Jun 2021 08:42:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229957AbhFDGoG (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 4 Jun 2021 02:44:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbhFDGoF (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 4 Jun 2021 02:44:05 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8392BC06174A
        for <linux-cifs@vger.kernel.org>; Thu,  3 Jun 2021 23:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Date:To:From:CC;
        bh=Tm+vHGiwBtJxp+TyrhQgWFYEoBExbhXNtWNi02ONOeM=; b=gjbONNDou6o0RddU59U7ILU2JZ
        xkFJEop/oIBSCGJZ8FiQuFDvok88UdVG2t8O4/R8aKaNxpio2mcy4VGFLTTrjeiVyIQlVTI5p1Ac8
        xj07lUWlB6sRJSZjawtG7XXEXNfu/zMDYW80cHvyZ/pOjCr5hUTTY+z65Ok6wCGcD3R3nAMTV0Bs4
        cW/hK6VctRJVvY3I5MAViSuXw3t6QDNvzrIDoA3r8F+WeL0+FbulLo4/KQmy3UL2DhU/AWR6OBmTx
        VEJMXcK7vkcmf3QNEQ3yjBZ/Hsz/7FHB5z8t92lJ8kp1I454YvxbpDtcK3XpEpJb2qhDJozstU0XT
        TM4z8wnVmtSU23IjsFBhAKqnbRWFfAgvVBBC6HbSJg54AjnVWZKMj66OTIH2j3ybzzfH5TJ9hG+Je
        31jczKiHbfuHcDfaaH3S21SwA54m1x1eAI8J7Rdg5eSIBY9tpFzkCBGpzBSck+Kgg4Vr7Y7nULgBw
        Q9T8xOYUa4aLIzQJdNSilCUe;
Received: from [2a01:4f8:192:486::6:0] (port=58330 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lp3X3-0007hb-FG
        for cifs-qa@samba.org; Fri, 04 Jun 2021 06:42:13 +0000
Received: from [::1] (port=18584 helo=bugzilla.samba.org)
        by hr6.samba.org with esmtp (Exim 4.93)
        (envelope-from <samba-bugs@samba.org>)
        id 1lp3X3-000Rt8-3V
        for cifs-qa@samba.org; Fri, 04 Jun 2021 06:42:13 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 14713] SMBv3 negotiation fails with a Solaris server
Date:   Fri, 04 Jun 2021 06:42:10 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: kernel fs
X-Bugzilla-Version: 5.x
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: metze@samba.org
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: sfrench@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-14713-10630-pZTjihxsDH@https.bugzilla.samba.org/>
In-Reply-To: <bug-14713-10630@https.bugzilla.samba.org/>
References: <bug-14713-10630@https.bugzilla.samba.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.samba.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

https://bugzilla.samba.org/show_bug.cgi?id=3D14713

--- Comment #37 from Stefan Metzmacher <metze@samba.org> ---
(In reply to Richard Flint from comment #33)

From 'man smb.conf'

...
SMB2: Re-implementation of the SMB protocol. Used by Windows Vista and later
versions of Windows. SMB2 has sub protocols available.

    SMB2_02: The earliest SMB2 version.

    SMB2_10: Windows 7 SMB2 version.

    SMB2_22: Early Windows 8 SMB2 version.

    SMB2_24: Windows 8 beta SMB2 version.

By default SMB2 selects the SMB2_10 variant.

SMB3: The same as SMB2. Used by Windows 8. SMB3 has sub protocols available.

    SMB3_00: Windows 8 SMB3 version. (mostly the same as SMB2_24)

    SMB3_02: Windows 8.1 SMB3 version.

    SMB3_10: early Windows 10 technical preview SMB3 version.

    SMB3_11: Windows 10 technical preview SMB3 version (maybe final).

By default SMB3 selects the SMB3_11 variant.
...

So '-m SMB3' is the same as '-m SMB3_11', I guess to want
'-m SMB3_00' instead in order to force 3.0.0

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
