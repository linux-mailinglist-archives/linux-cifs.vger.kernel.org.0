Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D44572699
	for <lists+linux-cifs@lfdr.de>; Tue, 12 Jul 2022 21:49:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231594AbiGLTtm (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 12 Jul 2022 15:49:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233517AbiGLTs3 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 12 Jul 2022 15:48:29 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC55FBD69B
        for <linux-cifs@vger.kernel.org>; Tue, 12 Jul 2022 12:41:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-ID:Date:To:From:CC;
        bh=gdyF/uZ957at+HrL/+qd68w/f9hPqDPXFBB726PPDVY=; b=0A2jfnd6fNX3ONcHG2TPx7weQA
        Q8qdBl/5OqjpjvvD3nHj7b2YZ7tu4jjjE0Dd1OWu1Jn3pDXqryXtL+u1X4hEb6mddDxBzgh+u8sYx
        szP84yrA/jX0F4wJiBzaLdMa1arE6uPSwZ/4KKh/DfW763QTGxEUIScmel/5t2tJMQAU7IJ8RebnN
        I+kMQ4VQGO6EcQo9wZojBWADdWkUnQfFHz9JOKyNu4kymRsA93ITYIAaOPXnpgMt7xld7DQF5yMEV
        z7hYYyG7fod3xhnMEoaqDaC3cpjWzq6wiOdqVUGsvF5p1kRWwWPHMStMzNbzNp+PgfFpo3Sigyrgl
        L6NgJ6hYE0Q0Y2GICnKUxPItaaXe00E63hQXVAMVASdhwOeDF/t0BK1PjRxDwfIqzG5hEsd4hzNUd
        NGW/eZYMJ+u6Ioe1+ZPm14lk03ybozWVgokp93wEvpI71JaAiw6zAyNH1E49popMwAjNaY31auNSp
        HfpfcmMxpS4jlohfcnB73v2I;
Received: from [2a01:4f8:192:486::6:0] (port=52776 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1oBLl3-004PMk-4v
        for cifs-qa@samba.org; Tue, 12 Jul 2022 19:41:21 +0000
Received: from www-data by hr6.samba.org with local (Exim 4.93)
        (envelope-from <www-data@samba.org>)
        id 1oBLky-000TXR-Qv
        for cifs-qa@samba.org; Tue, 12 Jul 2022 19:41:16 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 15051] EBADF/EIO errors in rename/open caused by race condition
 in smb2_compound_op
Date:   Tue, 12 Jul 2022 19:41:16 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: kernel fs
X-Bugzilla-Version: 5.x
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sfrench@samba.org
X-Bugzilla-Status: RESOLVED
X-Bugzilla-Resolution: FIXED
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: sfrench@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: resolution bug_status
Message-ID: <bug-15051-10630-1seA4khDI0@https.bugzilla.samba.org/>
In-Reply-To: <bug-15051-10630@https.bugzilla.samba.org/>
References: <bug-15051-10630@https.bugzilla.samba.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="UTF-8"
X-Bugzilla-URL: https://bugzilla.samba.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

https://bugzilla.samba.org/show_bug.cgi?id=3D15051

Steve French <sfrench@samba.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
         Resolution|---                         |FIXED
             Status|ASSIGNED                    |RESOLVED

--- Comment #4 from Steve French <sfrench@samba.org> ---
Patch is in 5.19-rc1 and later, and marked for stable so will be backported

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
