Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3EFC2390A98
	for <lists+linux-cifs@lfdr.de>; Tue, 25 May 2021 22:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233279AbhEYUk0 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 25 May 2021 16:40:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233263AbhEYUk0 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 25 May 2021 16:40:26 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D424BC061574
        for <linux-cifs@vger.kernel.org>; Tue, 25 May 2021 13:38:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Date:To:From:CC;
        bh=gZ5+CnenhT65UZDkTF3+O7O7Gxbw69kADBWustogCU0=; b=mFVYFnXQ9oWb2NY9GGz3JcUdk8
        69LHLJxvOdWxNjF1FtDoRy+dWhgKsdUFIJ7/7wPt0T+OtUtHPj+7TvU0rjneTuViVVdsZQWSvmuK/
        k1nz+bwD4S68yroZlJ9mJpTLrB78IwKrhquARzSql/NJXIUfNFyjXyvJ9UbV1n5L79c5zsKwAGHDC
        tjQkEoB/KUZ9dy/r28mEW+B/xkSxbkMBHZYcNT2kGQDFvmcs+FGosRG4KcFAR32DA0EZn29hzmiU0
        RnI4fK6URS31XF+YscO0d4cBuhBnQQyktcfSwvgxX/5+jPvqB5lCXCHvHeTu/mFQA++RIVWhzFNO0
        FF0z7lUwYZ5sxGK6wSc7j++XgenZZzwTmhwBiKD3fKGV88O3oRt0NpWvP7/6jVJuxUZuXPqcumT6b
        ddjbBSJerQmqjJLpawSot2RLM8VdXckZMZ6z0KP4DfMYDO8zpCbSv6yzhGZDhUOFoyZFU9HC5KklL
        UrRFkSy6FJSQ+cJF44lrfvmI;
Received: from [2a01:4f8:192:486::6:0] (port=55996 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1lldpF-0007Dk-QL
        for cifs-qa@samba.org; Tue, 25 May 2021 20:38:53 +0000
Received: from [::1] (port=33880 helo=bugzilla.samba.org)
        by hr6.samba.org with esmtp (Exim 4.93)
        (envelope-from <samba-bugs@samba.org>)
        id 1lldpF-008k0Z-8e
        for cifs-qa@samba.org; Tue, 25 May 2021 20:38:53 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 14713] SMBv3 negotiation fails with a Solaris server
Date:   Tue, 25 May 2021 20:38:52 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: kernel fs
X-Bugzilla-Version: 5.x
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sfrench@samba.org
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: sfrench@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-14713-10630-W36GW7zTC5@https.bugzilla.samba.org/>
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

--- Comment #21 from Steve French <sfrench@samba.org> ---
Key next steps:
1) seeing if it is possible to decrypt the wireshark trace (see link provid=
ed
earlier for instructions) although this may require rebuilding the cifs.ko =
to
dump keys (does Solaris have a way to view encrypted traces taken on the se=
rver
side?)
2) looking in more detail at the server.  It doesn't indicate why it was
rejected:
./../common/fs/smbsrv/smb2_dispatch.c:smb2_dispatch_message:134:Decryption
failure (71)!
May 25 19:44:21 nonsuch smbcmn: [ID 997540 kern.warning] WARNING:
../../common/fs/smbsrv/smb2_dispatch.c:smb2_dispatch_message:134:Decryption
failure (72)!

Do you have any contacts with Solaris support to see if they can see if they
can provide more information?  My guess is that they don't like the format =
or
the flags of something specified in the tree connect (since this works to e=
very
other server type) - but they may also have some subtle rounding error with
decryption on their server side.

Googling for the error I do see one other report of similar sounding proble=
m to
Solaris so it has been around a long time (see
https://bugs.centos.org/view.php?id=3D16531)

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
