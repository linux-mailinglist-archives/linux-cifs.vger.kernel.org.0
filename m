Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06104243D0E
	for <lists+linux-cifs@lfdr.de>; Thu, 13 Aug 2020 18:13:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726606AbgHMQNt (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 13 Aug 2020 12:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMQNs (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 13 Aug 2020 12:13:48 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F55C061757
        for <linux-cifs@vger.kernel.org>; Thu, 13 Aug 2020 09:13:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Date:To:From:CC;
        bh=Wz8wZ1QarTO0af7M4ZP5XDbHTxEZnt3oO9ey3vyTSMo=; b=sKhFphXcryLQv18/HJa+Q0ts80
        Hm2gnu9nfGXx2NZVTFAwqSwzVBIAYZTqOliatcB+QAUvONYzRvv6z3JlolxMgGmOL2RIM+UVaZogd
        rSR99ppX5IXKFKtXjWJEGw93JcVf3TMQenke0FePvdwQl0gnbt7fiwm6+R71vP/wDFiKh65IFGKmS
        +tAKFbyvmalrGA6k6V5znn4zQDYDF0TundRgNH2bLwBh+3SMrHL6eGsg2FIQK0z+tyDjCQTWvVez3
        vk1ahUV/QOrHDpY9rIPieGN0rYRpAWDYPzO40ogadusWTajnEzszI8+n9IxooqCnUvPMQeOcyUhyO
        vbMbv0DBSjGdexCQz58GaxLAbzPBPRHEZw0sTOOtbnnbz8U3oI8jgXV78moScz9fpVHjJ66wm/0Ca
        dByUMKCM5jBFKbqoMZryP2EduS5w234FQt/HVIDe7NVy564Y5ck1qbs8S+8v2z8n5i/YpfNUqE2dP
        A3gt1qlL47PkguvbvtNsc/ty;
Received: from [2a01:4f8:192:486::6:0] (port=53836 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1k6FrO-0002WG-GE
        for cifs-qa@samba.org; Thu, 13 Aug 2020 16:13:46 +0000
Received: from [::1] (port=39794 helo=bugzilla.samba.org)
        by hr6.samba.org with esmtp (Exim 4.93)
        (envelope-from <samba-bugs@samba.org>)
        id 1k6FrM-00932u-Dz
        for cifs-qa@samba.org; Thu, 13 Aug 2020 16:13:44 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 9078] Cifs share File corrupted after first use
Date:   Thu, 13 Aug 2020 16:13:44 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: kernel fs
X-Bugzilla-Version: 2.6
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: critical
X-Bugzilla-Who: bjacke@samba.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: sfrench@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status cc resolution
Message-ID: <bug-9078-10630-3COKF2VtAI@https.bugzilla.samba.org/>
In-Reply-To: <bug-9078-10630@https.bugzilla.samba.org/>
References: <bug-9078-10630@https.bugzilla.samba.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.samba.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

https://bugzilla.samba.org/show_bug.cgi?id=3D9078

Bj=C3=B6rn Jacke <bjacke@samba.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |RESOLVED
                 CC|                            |bjacke@samba.org
         Resolution|---                         |FIXED

--- Comment #5 from Bj=C3=B6rn Jacke <bjacke@samba.org> ---
this seems to be fixed, can you confirm? I tried 10 runs againt an old XP b=
ox,
all results OK.

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
