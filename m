Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C894C230E92
	for <lists+linux-cifs@lfdr.de>; Tue, 28 Jul 2020 17:56:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730963AbgG1P4w (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 28 Jul 2020 11:56:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730679AbgG1P4v (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 28 Jul 2020 11:56:51 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67616C061794
        for <linux-cifs@vger.kernel.org>; Tue, 28 Jul 2020 08:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Date:To:From:CC;
        bh=DJi3P3f4L3dTV3yUC7JT3h9eO5LWiaH+md3pK4kRLHs=; b=XQjBe2hdT9cB2Vd+DqFfGO+Bp3
        7TiDPcAcELtE0/AKeZD1fgrTuaQtTAgT2SlCj8PS5gtsQAxhGwTmW6svV6sZm9RCN+f/evTlufS6n
        /rXzcHUfdzWD/WDGBWS9hOB7VjqvwEVYnbRVZB9VEu8pBxG2X584cxNlrQGoPptiR3AXosGl4fNEG
        KMf70/QrJP2KFjc2ohqfJEPWgW3iLswej1esMRS6FEyAuOxwqF22TiDWzL3I+6yz2hnWSLjked+io
        kJ98vUhn4bEVCVSQz/FCO7XzpyLa82ZfoVhc/LEAHuP+XZNm951CFI8+4pHTtizmXLKumLEYWwhs+
        zfw1cxjdiePI2gDc3MaPK1hiDqqyZXqnO3Pqy8j4tLH6fpFpfQR3blRuf55O84i8Pbo3v4rDtQ0Mr
        S8pz/4J9mk632CYtE8gpfQsspfxx7e6tTRuVAGMA7/wdf+JxdBqOV2XF1ff01T8N+kjUV952ACbh4
        LDbWFOufezue9dMQuj7Q6G3X;
Received: from [2a01:4f8:192:486::6:0] (port=46434 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1k0RyD-0007o4-EX
        for cifs-qa@samba.org; Tue, 28 Jul 2020 15:56:49 +0000
Received: from [::1] (port=32388 helo=bugzilla.samba.org)
        by hr6.samba.org with esmtp (Exim 4.93)
        (envelope-from <samba-bugs@samba.org>)
        id 1k0RyB-007fCA-Cq
        for cifs-qa@samba.org; Tue, 28 Jul 2020 15:56:47 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 14442] CVE-2020-14342: Shell command injection vulnerability in
 mount.cifs
Date:   Tue, 28 Jul 2020 15:56:46 +0000
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
X-Bugzilla-Changed-Fields: attachments.isobsolete attachments.created
Message-ID: <bug-14442-10630-fai1LR6FNE@https.bugzilla.samba.org/>
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

Aur=C3=A9lien Aptel <aaptel@samba.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
  Attachment #16139|0                           |1
        is obsolete|                            |

--- Comment #19 from Aur=C3=A9lien Aptel <aaptel@samba.org> ---
Created attachment 16149
  --> https://bugzilla.samba.org/attachment.cgi?id=3D16149&action=3Dedit
patch v3 for 5.6-6.1

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
