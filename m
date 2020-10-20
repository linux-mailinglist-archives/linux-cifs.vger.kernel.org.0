Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6F5782848ED
	for <lists+linux-cifs@lfdr.de>; Tue,  6 Oct 2020 11:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725977AbgJFJBe (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 6 Oct 2020 05:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725946AbgJFJBd (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 6 Oct 2020 05:01:33 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CA91C061755
        for <linux-cifs@vger.kernel.org>; Tue,  6 Oct 2020 02:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Date:To:From:CC;
        bh=lL0kU8GOzcDDkzzntwsuzgRICyn5HY4p5XHbEo7Fc3M=; b=mMe7u4R/wdKUfJ5DYeRlcOxAZ5
        VnLqUuY4Gp3ucqfLL+4VprBjZtqCGIAKmPpwJKqToLDQo764mL+gczUObuJv6iiUQ38AvjHHV4wzd
        NRBkmtsS481WsDPHD27Ij5OiuMrCAHCCveIuO8w0ZeuPMeVz3WlVLMq/k3kxnOJ/O9250S6/tfEC2
        oe2WI6LcV1W7au91BK8OQB2RxXcJdQACWE/akDtvnVBUPPuXSLp/vFbpS7LGUWpuRCXW+MYpmDsG2
        /1/Sk7hI+0EHjXsfitoHrfcnya8eIhpYgxZby8yppVCc9tbpgvDluf1vraOiyUoTUE95kOCjAemX2
        TLxh8sc2mhRdeKUqHtIhhOfSOhdxCrP3DiVBjZyeXVkZ6DBb6ET8Vn3vdxODh48ccknC2iapzzDxI
        /x3Ux0jNVyuijVWGmbCCvGwUns5T837fNjjZv6WT3RkTLEp6ghO7ei72YEPnyERc2IfusAMmulnB5
        QVSQRMW2OtfqsVfigggMOSXL;
Received: from [2a01:4f8:192:486::6:0] (port=23136 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1kPiqh-0005S9-3q
        for cifs-qa@samba.org; Tue, 06 Oct 2020 09:01:31 +0000
Received: from [::1] (port=35816 helo=bugzilla.samba.org)
        by hr6.samba.org with esmtp (Exim 4.93)
        (envelope-from <samba-bugs@samba.org>)
        id 1kPiqd-004D2n-0M
        for cifs-qa@samba.org; Tue, 06 Oct 2020 09:01:27 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 14521] CIFS mount shows only "vers=default" instead of specific
 SMB version
Date:   Tue, 06 Oct 2020 09:01:26 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: kernel fs
X-Bugzilla-Version: 4.x
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aaptel@samba.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: sfrench@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc
Message-ID: <bug-14521-10630-HcneHh3BAi@https.bugzilla.samba.org/>
In-Reply-To: <bug-14521-10630@https.bugzilla.samba.org/>
References: <bug-14521-10630@https.bugzilla.samba.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.samba.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

https://bugzilla.samba.org/show_bug.cgi?id=3D14521

Aur=C3=A9lien Aptel <aaptel@samba.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |aaptel@samba.org

--- Comment #1 from Aur=C3=A9lien Aptel <aaptel@samba.org> ---
Just to make sure I get this right:

With the same version of the kernel (openSUSE-LEAP-15.2 with Linux-5.3), wh=
en
you mount with vers=3Ddefault:
- a Windows Server 2012 share you see vers=3D3.11 in /proc/mounts
- anything else you see vers=3Ddefault in /proc/mounts

And you are expecting the see the explicit version instead of default. Is t=
hat
right?


As a side note, if you just need to version you can look at
/proc/fs/cifs/DebugData. It will list all currently active connections along
with their version as "Dialect":

    # mount.cifs //foo/bar ....
    # grep Dialect /proc/fs/cifs/DebugData=20
    Number of credits: 407 Dialect 0x311 signed

=3D> 0x311 is 3.1.1

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
