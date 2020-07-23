Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F81622AF64
	for <lists+linux-cifs@lfdr.de>; Thu, 23 Jul 2020 14:32:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728426AbgGWMcm (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 23 Jul 2020 08:32:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727859AbgGWMcm (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 23 Jul 2020 08:32:42 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5375EC0619DC
        for <linux-cifs@vger.kernel.org>; Thu, 23 Jul 2020 05:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Date:To:From:CC;
        bh=CL70rOAxpVzdRUZ5B+YockZGzKEfLPxEh6lXfFZ1JuE=; b=ot75SLCiPVNfYHdydmjhHyoTXp
        ve8E0SLb5jZgLwrOo9T+RQzT8gprzB3zF6qv1xhocq/7j74wF35dXd9wW8s69MFkUssdlMK2zfm76
        WwtlXsL1o6H2G3Qs9KX97h1tDo/sPvkL3qhxyDd7IWW0L8FUK2uiRCrCI91q6QcWZlmkSYTYq0XGW
        nMUuRroqgPFQSSNzyoBHPC55mT23+vQcOBTSiUdQeszk1WMnbz/ioPhPU5e1ZJkQts1ZbTX2+SGAl
        hf/hoeB1wqFAMMiBEL00173OiLkQvsmXhOWtXCuJ7TfalV0d0g9UhKhDzVNED2vscuCgmyDp0PrUn
        T9CqK3Lxblp0otoSZbNWhNdyOG3q8PrnPqTOuBMsDwESZ/CGL4qlpMOWB2u/qWiMwQ8Duz67NOQHX
        Zykb0eZrqtZpOeeFAXiiHyswDg/yWf3yGJ/2v3n6W//ZD/G1e5GP5fKrghld+qc72Ew7T4yFMvBz4
        des46zD9l8ZqsFSVYvFOszph;
Received: from [2a01:4f8:192:486::6:0] (port=43246 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1jyaOu-0004Fg-Dc
        for cifs-qa@samba.org; Thu, 23 Jul 2020 12:32:40 +0000
Received: from [::1] (port=29206 helo=bugzilla.samba.org)
        by hr6.samba.org with esmtp (Exim 4.93)
        (envelope-from <samba-bugs@samba.org>)
        id 1jyaOu-007176-6N
        for cifs-qa@samba.org; Thu, 23 Jul 2020 12:32:40 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 13470] DFS mounted shares do not allow to go subdirectories
Date:   Thu, 23 Jul 2020 12:32:40 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: kernel fs
X-Bugzilla-Version: 3.x
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: aaptel@samba.org
X-Bugzilla-Status: NEEDINFO
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: sfrench@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: cc bug_status
Message-ID: <bug-13470-10630-zvcnD6ASXt@https.bugzilla.samba.org/>
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

Aur=C3=A9lien Aptel <aaptel@samba.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
                 CC|                            |aaptel@samba.org
             Status|NEW                         |NEEDINFO

--- Comment #1 from Aur=C3=A9lien Aptel <aaptel@samba.org> ---
Have you tried a recent kernel? Lot of DFS changes went in the last few yea=
rs.

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
