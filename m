Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E42F32744E4
	for <lists+linux-cifs@lfdr.de>; Tue, 22 Sep 2020 17:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726632AbgIVPCs (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 22 Sep 2020 11:02:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726566AbgIVPCs (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 22 Sep 2020 11:02:48 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A1FC061755
        for <linux-cifs@vger.kernel.org>; Tue, 22 Sep 2020 08:02:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Date:To:From:CC;
        bh=cOqPY3a1C3VpIjmgE6E8AYhAeOituBbZ0U50FEu1Wk4=; b=rYNzqXpWaHwIUcVbainQXWcNuK
        nu46kuOubCPE0yZcXGNhjPEbEXpPaPtLAPOwBCC28qxpOrhbvinqpb+6mQmLA+nFXGYHp41vqNMYR
        68aNQgVapLUuHMJfBNWktR4nBVUoaUIcp3MPz/Y5DtUlhAIXevLlHSZITem4IU2/q3tgIQP6tiyYu
        mOqpLeXGCrv1P2aaVS0j5BeTnQ+gGyzMspb39COe1NpPB/L3LZpRVGbCx/Ia6bOlkSHjM89dICTtl
        Z9ZTMQDym7sQHQZEHeW9T/crYzsq56CqwU+4CqAkLA2/Vb3pO6jxdOjpNtDOwjOUBJ8NWekNYZz21
        D6IDN0SwwMepuxgS1AVQ+kaK8fWzB1iKGmbEdY1EnidLS161Qy771WzqESXhUyCpj0SX8ucz3vsg8
        tTPP4sn7cZgCs6/VJsWgqYxOjIKL1U3+c56Y/Jodw6BG6F3VgLFWmPIwibIEVY2edHGSbUaPlWNoG
        0Pz0/medYJXhgIswspaE54mK;
Received: from [2a01:4f8:192:486::6:0] (port=18914 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1kKjoc-0000UF-0b
        for cifs-qa@samba.org; Tue, 22 Sep 2020 15:02:46 +0000
Received: from [::1] (port=31592 helo=bugzilla.samba.org)
        by hr6.samba.org with esmtp (Exim 4.93)
        (envelope-from <samba-bugs@samba.org>)
        id 1kKjob-0032Bi-Rf
        for cifs-qa@samba.org; Tue, 22 Sep 2020 15:02:45 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 14509] Interworking Problem OpenVMS Samba Server 4.6.5 with
 Linux Samba Client 4.7.6
Date:   Tue, 22 Sep 2020 15:02:45 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: kernel fs
X-Bugzilla-Version: 5.x
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
X-Bugzilla-Who: bjacke@samba.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: sfrench@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-14509-10630-w0bhJ82gk6@https.bugzilla.samba.org/>
In-Reply-To: <bug-14509-10630@https.bugzilla.samba.org/>
References: <bug-14509-10630@https.bugzilla.samba.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.samba.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

https://bugzilla.samba.org/show_bug.cgi?id=3D14509

--- Comment #4 from Bj=C3=B6rn Jacke <bjacke@samba.org> ---
(In reply to Bj=C3=B6rn Jacke from comment #3)
ah, you mentioned openvms in the subject, sorry :-)

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
