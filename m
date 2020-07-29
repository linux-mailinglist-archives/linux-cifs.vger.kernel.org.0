Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F1E16231F42
	for <lists+linux-cifs@lfdr.de>; Wed, 29 Jul 2020 15:25:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726876AbgG2NZJ (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 29 Jul 2020 09:25:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726865AbgG2NZI (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 29 Jul 2020 09:25:08 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED694C061794
        for <linux-cifs@vger.kernel.org>; Wed, 29 Jul 2020 06:25:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Date:To:From:CC;
        bh=WoYM0tR/QpFPj2PjPOe46Aau9flIBUann7T+hiQBa64=; b=BNGqsm2y79Ii1PNlogSusRTsRl
        NItWRz/7ehxLu9muQBSBRCh1a/DV+Urx+cB2H7Vhku5U7y7eSFRuEq7zKv83OAAZWCXPZUglI6KK3
        TPAMyx+TVLnPXv8MdAPV0fqqoeLPysFq1KTfwFZ0P0HmFIl+14Hnw4u70nap64+bZVA/NCrXEvIHz
        rGg7vr7bBPmg5nO+p20IWsGmlbhX8mQrxSNbG9JTjztFA6sl/A1BwsJa5aqUmXdQ2nNKjdRmvwjhp
        59WlZAE1x72yx2n6tTOjRYSaMpkrl+W2h/5ldZ2n2AarMbIZSc+FgvU/kPOTBkVuAJ8Ofm34cJ5/h
        laXMxXs1nJlXnku4x4Va6aDWaI6J+sd9FCJ78nX4kkcJP9kadhKu4wMR5ozrjr0eNyoqPVn/bEL+h
        ZxbUOnNZpK1hIzMnD3CT0PeIjdyu6ro+QjP+XFTkfSuTr0Tou4SIREq3b2pTMvKQTZ7XscX/d7VFp
        qO6nuzVSq/nqok4Pm9KvYqwH;
Received: from [2a01:4f8:192:486::6:0] (port=46908 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1k0m4v-0000YQ-CC
        for cifs-qa@samba.org; Wed, 29 Jul 2020 13:25:05 +0000
Received: from [::1] (port=32868 helo=bugzilla.samba.org)
        by hr6.samba.org with esmtp (Exim 4.93)
        (envelope-from <samba-bugs@samba.org>)
        id 1k0m4t-007kib-Tm
        for cifs-qa@samba.org; Wed, 29 Jul 2020 13:25:03 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 13470] DFS mounted shares do not allow to go subdirectories
Date:   Wed, 29 Jul 2020 13:25:03 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: kernel fs
X-Bugzilla-Version: 3.x
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sergey_ilinykh@epam.com
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: sfrench@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-13470-10630-56ZuByEojN@https.bugzilla.samba.org/>
In-Reply-To: <bug-13470-10630@https.bugzilla.samba.org/>
References: <bug-13470-10630@https.bugzilla.samba.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.samba.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

https://bugzilla.samba.org/show_bug.cgi?id=3D13470

--- Comment #5 from Sergey <sergey_ilinykh@epam.com> ---
btw I can open smb://epam.com in KDE's Dolphin. I guess it's because it doe=
sn't
use kernel's capabilities for that.

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
