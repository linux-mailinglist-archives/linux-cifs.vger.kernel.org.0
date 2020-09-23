Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2489927524A
	for <lists+linux-cifs@lfdr.de>; Wed, 23 Sep 2020 09:28:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726647AbgIWH2e (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 23 Sep 2020 03:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgIWH2e (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 23 Sep 2020 03:28:34 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF67DC061755
        for <linux-cifs@vger.kernel.org>; Wed, 23 Sep 2020 00:28:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Date:To:From:CC;
        bh=geUM4RuaxNk5A0dbynUMHjGSRVgbK5Kd22NUN0x8TBk=; b=hoQQYqq4Ch+DGmKusr1JyXREcS
        WSYq6NAQx8aM8VhyXIRkLeRrm5m2JFnqi+ctVb7m9ysJmI74T7v49Mj85z3nU+3oTIYEbx3VuGUpJ
        b1ImohfFyJQFVhakGAnk0eVRyiD6djSWCZoMsnIvafnV5Y2+ek+a/5LxR7ljLHLluvjk7o+53YTGo
        X5wt1P1LZZHTAongmLc3vhg6nNBW2FwLpUgPgPS0IKXd9VkAflkPB2OqJ5t0+pkcb1Q53IIbD8bWZ
        8OmEqYQGu30sFBs8/nbsLFN+7P244kRLCYbYfFmT/1A2CPv/Q17dSYlWU4TJLxnA0k9WHXbu8HMlD
        A6pbmjClAT8avxQH1N42Lvpu+0HibHfM5yLWHnCcLZX/mTDRdn8ZPhdUiopCFZhCoFcey+0wPyZz5
        0xcUf1vidOYXMt7hQ3CXMVy4gO8O7Q7mV3Ceix1u8B33XDdmudWptCIyftjl38+dut7c1RoXFU6nZ
        EJfWsoT/5m5VSQm7LcsetoFT;
Received: from [2a01:4f8:192:486::6:0] (port=19142 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1kKzCY-0007qn-L1
        for cifs-qa@samba.org; Wed, 23 Sep 2020 07:28:30 +0000
Received: from [::1] (port=31820 helo=bugzilla.samba.org)
        by hr6.samba.org with esmtp (Exim 4.93)
        (envelope-from <samba-bugs@samba.org>)
        id 1kKzCY-00391m-9k
        for cifs-qa@samba.org; Wed, 23 Sep 2020 07:28:30 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 14509] Interworking Problem OpenVMS Samba Server 4.6.5 with
 Linux Samba Client 4.7.6
Date:   Wed, 23 Sep 2020 07:28:29 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: kernel fs
X-Bugzilla-Version: 5.x
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: minor
X-Bugzilla-Who: john.dite@compinia.de
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: sfrench@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-14509-10630-Um9Ihjr35k@https.bugzilla.samba.org/>
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

--- Comment #9 from John Dite <john.dite@compinia.de> ---
It's not a 100% clear for me.=20

If "filename MUST be at least one character but no more than 255 characters=
 in
length" why does it not lead to a protocol violation on the part of the Lin=
ux
Client SMB state M/C. I don't see that in my Wireshark trace.

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
