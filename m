Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 707F9226D3A
	for <lists+linux-cifs@lfdr.de>; Mon, 20 Jul 2020 19:36:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731760AbgGTRfc (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 20 Jul 2020 13:35:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729307AbgGTRfb (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 20 Jul 2020 13:35:31 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FEF7C061794
        for <linux-cifs@vger.kernel.org>; Mon, 20 Jul 2020 10:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Date:To:From:CC;
        bh=q49zZvpuzsoSP/7zeTsrHVPGpF8R/4Hci0sUF29qoZQ=; b=R5RdmsyqrYaAIaj7S7bHoxZuQk
        OYNCiNIfytYZ0/uMqw2syseQTQAn05Xa2WMpWaX1w1as5L5XhBQxPw7b/P1owc3Qf6gm8awASgu1L
        HLa4rmRyk0mR2ovE7B68KNwWVb8xhOT5OdJ0jj/NMbEqRnab1U4LncdOVnKPvG22SJtU1coVZqd4z
        dU0uNaI0uL4lcOSMFnOBQAH1lSDN3o2ULdFfhrdt/X6qwEB6A/eKYlmVlP3MQv7laOcH6FrTKBnGB
        Am3BAfF3vJUsvoMfLJIAsNrBVPqzaIynKOwjvcExKomiG0YXnXeXrwdIuVHc8B4sh45sabg+OmMEN
        TJJ3fzvIWl0l6ZnonXNI1DiXmIMILQEzh4FJGjm5ziIt7hnG6zQjdBOILvRgb8rYXsQwy9okJx8uk
        R3unAEwybWMOgCy+EwdSCykTN08rniSJYhY9Rl/dfmkqUR+ZllR1viN7ggDiLM87+OSMKGCp9aPAg
        zyzSDFoSidqVjFMJ0UELxGXL;
Received: from [2a01:4f8:192:486::6:0] (port=41772 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1jxZhH-0004Xu-Ta
        for cifs-qa@samba.org; Mon, 20 Jul 2020 17:35:28 +0000
Received: from [::1] (port=27732 helo=bugzilla.samba.org)
        by hr6.samba.org with esmtp (Exim 4.93)
        (envelope-from <samba-bugs@samba.org>)
        id 1jxZhH-006jL3-7A
        for cifs-qa@samba.org; Mon, 20 Jul 2020 17:35:27 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 14442] Shell command injection vulnerability in mount.cifs
Date:   Mon, 20 Jul 2020 17:35:22 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: kernel fs
X-Bugzilla-Version: 2.4
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: jmcd@samba.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: sfrench@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_group cc
Message-ID: <bug-14442-10630-VPWErfmywa@https.bugzilla.samba.org/>
In-Reply-To: <bug-14442-10630@https.bugzilla.samba.org/>
References: <bug-14442-10630@https.bugzilla.samba.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.samba.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

https://bugzilla.samba.org/show_bug.cgi?id=3D14442

Jim McDonough <jmcd@samba.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
              Group|                            |samba-devel
                 CC|                            |jmcd@samba.org, pc@cjr.nz

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
