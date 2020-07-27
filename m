Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA6E22EB42
	for <lists+linux-cifs@lfdr.de>; Mon, 27 Jul 2020 13:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbgG0Ldo (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 27 Jul 2020 07:33:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbgG0Ldo (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 27 Jul 2020 07:33:44 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF33C061794
        for <linux-cifs@vger.kernel.org>; Mon, 27 Jul 2020 04:33:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Date:To:From:CC;
        bh=XKLIu0btSrkYN3CWb/LLwfMltU0XvuCt9OJiwqUS2mM=; b=z655+qG7tZ3Fzrr5A7Pe9DjyQh
        NZJf9i33sn75sjvBzscDWN29NgeD6c1qhD4GNJZnDOvhgXZlQBxN3VYaHezZxKmT5JlgM/NitmH3j
        SRxJbtNCkUBK9hLg04/S846qohR5kpIVEUxqpINrctHX+86uQWHSlf3uJKljZs5vdOYmtmUZro1n+
        g4w4l9oJmOvLidzWGZyiOQP1eX7gkIHPYn+hPgG1zIZfnh9Dgkgg6s4wBVogKJJ3QbS1hxqA4Kla1
        aPkAPGJ2/9mVeTkkhayQSH+6jMvc8k7fmNP9MOSGGnPFZP0WWgMK3bzD0hu2yeYAvVq57c1aTX+2o
        9myPl7sSn0VWcLoyD9C+srL1S4W4Ki+j/TROYcLmETrL40Wq6Jids+u44UPvzlBRjUWYDumYiTikR
        hT/EQnKCP7aXrMqEZHRSTDY1MCEswe8E+AQ5N41J2CTIcaIRNh9BvGQK8VNF8577YSOJM0JzF9ZCD
        AHV9JOYKY+2TyJApJHj4yRY1;
Received: from [2a01:4f8:192:486::6:0] (port=45428 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1k01O1-0002BY-Su
        for cifs-qa@samba.org; Mon, 27 Jul 2020 11:33:41 +0000
Received: from [::1] (port=31382 helo=bugzilla.samba.org)
        by hr6.samba.org with esmtp (Exim 4.93)
        (envelope-from <samba-bugs@samba.org>)
        id 1k01O1-007ZbX-8E
        for cifs-qa@samba.org; Mon, 27 Jul 2020 11:33:41 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 14442] CVE-2020-14342: Shell command injection vulnerability in
 mount.cifs
Date:   Mon, 27 Jul 2020 11:33:40 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: kernel fs
X-Bugzilla-Version: 2.4
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: aaptel@samba.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: sfrench@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-14442-10630-c2cHfz0hgD@https.bugzilla.samba.org/>
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

--- Comment #15 from Aur=C3=A9lien Aptel <aaptel@samba.org> ---
Created attachment 16139
  --> https://bugzilla.samba.org/attachment.cgi?id=3D16139&action=3Dedit
patch v2 for 5.6-6.1

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
