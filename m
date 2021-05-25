Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 497D13909A6
	for <lists+linux-cifs@lfdr.de>; Tue, 25 May 2021 21:27:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbhEYT32 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 25 May 2021 15:29:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbhEYT32 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 25 May 2021 15:29:28 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2510C061574
        for <linux-cifs@vger.kernel.org>; Tue, 25 May 2021 12:27:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Date:To:From:CC;
        bh=B0zHeAz6eOpwitF3F+oExUZ+UrdleY7x6frUblkUVZg=; b=wUjKih6PUCKQexD8PlQcVrwePk
        +4FoM+FSfAc2GpSFbjDnEE/hlPehaummULZcWHd92KuT+0T9mHiboPu2saB7+HVlmCs28o9Oi3JS0
        iz8PUFE5zjMhtqMnJB/suugp34rjLmbWoB7IsiVrhHAXMgH7RUZPE0xaY7/CeAZaiOQfzMACLF1xb
        uQYrwlquTjqx5pt1JKX7jFQ0bfjaJhs48ESN1nKbS+kQ24WANvvyvnHmczHQyF7JxLvkYUDhvApmG
        T5OkUmlzeACLs8H4yGmZ6f7oJhOkZgsK5wma+dGIDZ3R6kLwJRgA1e11LcpImaQLlRnB0hgq3HlZL
        nNxJ+B71E+XTYuK8H7/Xf3gguVlr455BnKzCcuhdKaERy6QUtBvQIQYvzGrCo0mWDBRu5xtuB7WtC
        hTfJcrvdMzOFkmzLzx08IL771p4WOuBkEBgcfSwVv+ssw7OZNGKMKsjCMeNylcldNtA1bM/DbYOmw
        Nd8SrItnq6hhwv70CMjFEkhV;
Received: from [2a01:4f8:192:486::6:0] (port=55952 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1llciZ-0006iZ-4h
        for cifs-qa@samba.org; Tue, 25 May 2021 19:27:55 +0000
Received: from [::1] (port=33838 helo=bugzilla.samba.org)
        by hr6.samba.org with esmtp (Exim 4.93)
        (envelope-from <samba-bugs@samba.org>)
        id 1llciY-008jwS-KE
        for cifs-qa@samba.org; Tue, 25 May 2021 19:27:54 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 14713] SMBv3 negotiation fails with a Solaris server
Date:   Tue, 25 May 2021 19:27:54 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: kernel fs
X-Bugzilla-Version: 5.x
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: richard.flint@gmail.com
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: sfrench@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-14713-10630-dWVp3iN8ZE@https.bugzilla.samba.org/>
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

--- Comment #15 from Richard Flint <richard.flint@gmail.com> ---
If there is a bug in Solaris SMBv3 encryption handling, I'm perplexed as to=
 why
it works fine when doing this from smbclient. E.g. the below appears to wor=
k:

smbclient //nonsuch/myshare --debuglevel=3D10 --encrypt --user=3Dmyuser

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
