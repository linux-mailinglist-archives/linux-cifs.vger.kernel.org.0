Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC10243C12
	for <lists+linux-cifs@lfdr.de>; Thu, 13 Aug 2020 17:01:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726292AbgHMPA7 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 13 Aug 2020 11:00:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726131AbgHMPA7 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 13 Aug 2020 11:00:59 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBC7FC061757
        for <linux-cifs@vger.kernel.org>; Thu, 13 Aug 2020 08:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
         s=42; h=Message-ID:Date:To:From:CC;
        bh=V/8qUWGtBjYUbbDXZs6JFwC41+w3k/+M/g5aYnEFADc=; b=OYsNbSsN6AdOnIouDlkViw5x1Z
        2HwsmBIgL/KXyDrdkxzLT8YNx75SY5aq/wutLtfjt8s28ak/H98Yss/c91UwGOqHDrsfSFMGFfSMC
        8Wyf5YjvTokoYFRcjYPe+SvebKnfRgvVdrkYmgpjot/l7oMGkv5VsMjojz3kK8+7NDutEdgsOroPk
        OyEqcdxvCAQRoe0NSDR4PZ6n8b2RQjdkpgzOk+mzRtX7Ggn+JiixUDD5l1VPG7/VKiVFgv0nf0LqQ
        efuIdHHuYePCVTb3W3+a2QtkVakehzW39dXb1DOpDCAaLHTvOA4mOlHzifgbtnkMXirNNF3hUp2QU
        EXGeT872GvWITRfLFvOqZi72NSbzeDezX8eZ89T9BCdoDRXjM635MOgreqWodS0hhmQR7I6YjZoZ3
        HjF5qeouDAvxNpAOdGRCeIiacCD+Sb7GXejEtXarR729jk/Ess/1GkWSbR6PQ8k6DgtWPngW+TpKC
        jMHeTNSgkmWS8HMo5ktXoHwj;
Received: from [2a01:4f8:192:486::6:0] (port=53738 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_RSA_CHACHA20_POLY1305:256)
        (Exim)
        id 1k6Eiq-0001se-Fc
        for cifs-qa@samba.org; Thu, 13 Aug 2020 15:00:52 +0000
Received: from [::1] (port=39694 helo=bugzilla.samba.org)
        by hr6.samba.org with esmtp (Exim 4.93)
        (envelope-from <samba-bugs@samba.org>)
        id 1k6Ein-0092wr-3D
        for cifs-qa@samba.org; Thu, 13 Aug 2020 15:00:49 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 10231] cifs vfs strtoucs char2uni of 0xffffff8e returned -22
Date:   Thu, 13 Aug 2020 15:00:48 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: kernel fs
X-Bugzilla-Version: 2.6
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: bjacke@samba.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: sfrench@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution bug_status
Message-ID: <bug-10231-10630-KVwaHXH8vp@https.bugzilla.samba.org/>
In-Reply-To: <bug-10231-10630@https.bugzilla.samba.org/>
References: <bug-10231-10630@https.bugzilla.samba.org/>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Bugzilla-URL: https://bugzilla.samba.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

https://bugzilla.samba.org/show_bug.cgi?id=3D10231

Bj=C3=B6rn Jacke <bjacke@samba.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|---                         |FIXED
             Status|NEW                         |RESOLVED

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
