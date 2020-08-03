Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EEE4F23A70B
	for <lists+linux-cifs@lfdr.de>; Mon,  3 Aug 2020 14:58:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728813AbgHCM5R (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 3 Aug 2020 08:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726707AbgHCMVc (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 3 Aug 2020 08:21:32 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 119DFC061756
        for <linux-cifs@vger.kernel.org>; Mon,  3 Aug 2020 05:21:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Date:To:From:CC;
        bh=OdJtlZS8RFO8Dhe9Xj/3qrZ4MfA7gLt7cXqH3Ihp+aA=; b=CLaU2bIzptsVn7bG/VWqi1JXGE
        aKH/FL8cdtKA/V1qfKluiCmKz4TRdmHesUWrljLAngyCl2bavm7e+I3eZzcovWz1RkxqP3P/eaO2t
        JLT42/Bq2lzBa35AmuJiVx4sNI/uuPZ3x45kPw7/yX6LC3mxDsOJ4VQwWp8oMm14iXo65hq9gfGe2
        ODuCV2c1bzH8aZYsTHIm8s0VWNZgvcbEmymsk0My8vN9yAeX8Ph9fGlzDl6D9Pkbvn+2nepalRenV
        S8SLRcPKTc4a75lh6RM5IEKL6sQGtdL4yJHt/owMRYhz4qMUbqIsIaPoe7eLGsV9+8BP0JcGJKlKn
        YPpVfDyDlMNz76INDOzbuPwUQLA35dKRqMe993/uesdezilcCext7UgJMoD+mKghT+crIeH3Yzeuf
        zoNYx3ni05aqLL3ECuSm0HaCbOzp/7QIQX+X8/SFiK160b6jPdzgtxkQaJygjkFyQwpKiTM0vIk1c
        c9m6XZl92ZyXUDX13/xbjgay;
Received: from [2a01:4f8:192:486::6:0] (port=49332 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1k2ZT7-0007y6-7G
        for cifs-qa@samba.org; Mon, 03 Aug 2020 12:21:29 +0000
Received: from [::1] (port=35292 helo=bugzilla.samba.org)
        by hr6.samba.org with esmtp (Exim 4.93)
        (envelope-from <samba-bugs@samba.org>)
        id 1k2ZT6-008CcK-QQ
        for cifs-qa@samba.org; Mon, 03 Aug 2020 12:21:28 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 14454] cannot get symlink file attributes and target with
 cifsacl mount option
Date:   Mon, 03 Aug 2020 12:21:28 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: kernel fs
X-Bugzilla-Version: 3.x
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aaptel@samba.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: sfrench@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-14454-10630-5fYFhIDoKJ@https.bugzilla.samba.org/>
In-Reply-To: <bug-14454-10630@https.bugzilla.samba.org/>
References: <bug-14454-10630@https.bugzilla.samba.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.samba.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

https://bugzilla.samba.org/show_bug.cgi?id=3D14454

--- Comment #4 from Aur=C3=A9lien Aptel <aaptel@samba.org> ---
Created attachment 16161
  --> https://bugzilla.samba.org/attachment.cgi?id=3D16161&action=3Dedit
capture smb3.0 without cifsacl

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
