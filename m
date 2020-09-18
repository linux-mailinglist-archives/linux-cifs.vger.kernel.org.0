Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8BE5226F4E8
	for <lists+linux-cifs@lfdr.de>; Fri, 18 Sep 2020 06:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIREIs (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 18 Sep 2020 00:08:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726117AbgIREIs (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 18 Sep 2020 00:08:48 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE34C06174A
        for <linux-cifs@vger.kernel.org>; Thu, 17 Sep 2020 21:08:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Date:To:From:CC;
        bh=30kW5YumiHdhELPwG+A5BpDyoHcfx0ILrm2nWPfQ9cU=; b=XYifAyuOdPpz8Z/jwEGW1jOHbo
        VdkmB//x7NUwKXKrrIbJtxyIptBUgGqVEZ50cI/Fq2z/4SAkjcC+cUmlY8pr+Id4/Ey5d4/bskTeg
        f0NQs3ET2IXmqH0o+9swGQB3ZGY/Jyfopx99Jzquk25Xd5iC1xpCdH/6RiPVuMuinPS1/vYYOMV2d
        nnS6igFD0Y+kly69Vx01JWIDkRAGH0yJgqYFN416BsFmX5lhKinqI9PYnLGU/H1vyBqmLAz3QDCBK
        bczbCyTAa3ZLzZX8RIuyeTf1Ihrmd/9z12mF3rAmoSV3ewxDKhw3OH0zWP/aVmSzLB6QXYvxNNAb1
        qO1ItcJ4DLAo0WKKks5QlOxCEH1aybC8UtYYYME5cy9xTb/Mrx5Dl7/9g3zJM1RrFjHaG4BsgvyNn
        MPLPpcod0KqFEDH2gyw8p0z2WJNGLd8CgPBAzUa1lV4nKNMVeQm5DKW+R7Ye57aWkwc8oBSKH6YrF
        t2XNZNoy+TrVf8z7cmq4N/2/;
Received: from [2a01:4f8:192:486::6:0] (port=62748 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1kJ7hS-0001SH-4x
        for cifs-qa@samba.org; Fri, 18 Sep 2020 04:08:42 +0000
Received: from [::1] (port=27892 helo=bugzilla.samba.org)
        by hr6.samba.org with esmtp (Exim 4.93)
        (envelope-from <samba-bugs@samba.org>)
        id 1kJ7hR-002d6n-Lg
        for cifs-qa@samba.org; Fri, 18 Sep 2020 04:08:41 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 14498] Why is mount -a is not detecting an already mounted DFS
 share endpoint
Date:   Fri, 18 Sep 2020 04:08:41 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: user space tools
X-Bugzilla-Version: 3.x
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sfrench@samba.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: jlayton@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-14498-10630-uilgvv6mCS@https.bugzilla.samba.org/>
In-Reply-To: <bug-14498-10630@https.bugzilla.samba.org/>
References: <bug-14498-10630@https.bugzilla.samba.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.samba.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

https://bugzilla.samba.org/show_bug.cgi?id=3D14498

--- Comment #2 from Steve French <sfrench@samba.org> ---
What is the kernel version on the two (the failing and working kernels)?

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
