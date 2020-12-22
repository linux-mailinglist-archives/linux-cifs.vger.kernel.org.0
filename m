Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AC5F82DF06B
	for <lists+linux-cifs@lfdr.de>; Sat, 19 Dec 2020 17:21:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726878AbgLSQVk (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 19 Dec 2020 11:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726752AbgLSQVj (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 19 Dec 2020 11:21:39 -0500
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99B38C0613CF
        for <linux-cifs@vger.kernel.org>; Sat, 19 Dec 2020 08:20:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Date:To:From:CC;
        bh=DljRb5pgAb3NZs1X4X+k5n5azPt2sMegWuuG42isDYs=; b=vt0A95Zi7q9s3LZu3ChuVXq9zp
        J2LQpPkTe2kyyY8Sej1pGxEURZHsHopN2oE6UYjxlyQjR7Jnuwx+AfjoExR7E7m7LTS8TQL8mjT1P
        9r9Z45J336zpWWACQJRShUvfo+2vL/LWKTM6zruIgglTa3afs237VKLwkyIxznI6PpoLPlOUq7Sm1
        kZZq6Fnb/523bNpagqL88L9DW3RXyZN/fLUiva0QSioLLvjyCbb4wD9rEu9fBnwQeHiQ65EZXUyTI
        Liex949Lv5/N/UsxxMXd29tFgAILI4cT2YnHgwc+I774OCPBS21OfbG6Iws8XFahLMf+iUj+bqq5T
        MnJklwIaokbEOiOiFma5CX+tv1+rfuwZ1U3zRkxTInWjcYYHVWl2l6/BicOfQZZfiQYaeAqVD6UZX
        aHOklMF70CHFAX79skqjrVKbtZmgb8aFmZobiJ/sjwVS7gD7v7faenvzXOMwaFNAbduHIHDZKeir0
        CYNfr9ikPXYwxwAQq3C6I53w;
Received: from [2a01:4f8:192:486::6:0] (port=51394 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1kqeyX-0004uY-FO
        for cifs-qa@samba.org; Sat, 19 Dec 2020 16:20:57 +0000
Received: from [::1] (port=20824 helo=bugzilla.samba.org)
        by hr6.samba.org with esmtp (Exim 4.93)
        (envelope-from <samba-bugs@samba.org>)
        id 1kqeyW-001IYD-Tk
        for cifs-qa@samba.org; Sat, 19 Dec 2020 16:20:57 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 9346] Directories on CIFS shares shown as ordinary files
Date:   Sat, 19 Dec 2020 16:20:55 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: kernel fs
X-Bugzilla-Version: 3.x
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: bjacke@samba.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: sfrench@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: product version qa_contact component
Message-ID: <bug-9346-10630-S2t7G5vJMV@https.bugzilla.samba.org/>
In-Reply-To: <bug-9346-10630@https.bugzilla.samba.org/>
References: <bug-9346-10630@https.bugzilla.samba.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.samba.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

https://bugzilla.samba.org/show_bug.cgi?id=3D9346

Bj=C3=B6rn Jacke <bjacke@samba.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
            Product|Samba 3.6                   |CifsVFS
            Version|unspecified                 |3.x
         QA Contact|samba-qa@samba.org          |cifs-qa@samba.org
          Component|File services               |kernel fs

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
