Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD517C8FFF
	for <lists+linux-cifs@lfdr.de>; Sat, 14 Oct 2023 00:05:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjJMWE7 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 13 Oct 2023 18:04:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMWE6 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 13 Oct 2023 18:04:58 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062A5B7
        for <linux-cifs@vger.kernel.org>; Fri, 13 Oct 2023 15:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-ID:Date:To:From:CC;
        bh=xXKxhbRxTTo3F0kWWKdFXJWvGmHodXUeAWg+zIz7tKE=; b=DVv5KUzfSPCnIFTlWWFoOnZCdR
        wWjVfHXJuMqZav7HK2Ltpb8CQ/eAbgi1Ut0mxmdU3Wz3MVpDsuHjP1X4GwrzDweYn3PUVjw5a20rv
        TXeip//UidoESfnGRfV6tNoVbILvbVekf/n6jWhj8Znm1aK+KIGTWpp5wpAJL2uVgaPUyRT0uFt85
        dsePDyBrzRFx4tokfK0J4PQcbcuug8S6khbtC9QCQ43Es+Eo05VJVGhr+IC+NI7csK5B7Y+vgGBZi
        uU372O8BBfz+GZ0NpD+JSlF6dXLgPCOz24cs2fQbACv6zbLLVTr4NCL2nXjeJM2x/km9roFA77/Kz
        A2hbpx7qjYfbE/zZ5VFYcqYv2XbshtkyueqzgXDRpFhNCoPQ2HpNn6+M4eEz3XFk3imcdTnUK88Dp
        XXVSN4wgp154+T49jyn3EHciHbEaSJZ/2iE6PuKU64p1STZC6vzVzfkSEoj67QPj3wQzFAVNrf8XU
        8mhQn4akF2KNNRhkCF02kQP3;
Received: from [2a01:4f8:192:486::6:0] (port=63956 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1qrQH6-000Wxi-22
        for cifs-qa@samba.org;
        Fri, 13 Oct 2023 22:04:54 +0000
Received: from www-data by hr6.samba.org with local (Exim 4.95)
        (envelope-from <www-data@samba.org>)
        id 1qrQH5-000ET1-Qw
        for cifs-qa@samba.org;
        Fri, 13 Oct 2023 22:04:51 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 14476] Cannot set timestamp of Minshall-French symlinks from a
 CIFS mount
Date:   Fri, 13 Oct 2023 22:04:51 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: kernel fs
X-Bugzilla-Version: 5.x
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sfrench@samba.org
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: sfrench@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: 
Message-ID: <bug-14476-10630-CqxrNo90we@https.bugzilla.samba.org/>
In-Reply-To: <bug-14476-10630@https.bugzilla.samba.org/>
References: <bug-14476-10630@https.bugzilla.samba.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugzilla.samba.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

https://bugzilla.samba.org/show_bug.cgi?id=3D14476

--- Comment #2 from Steve French <sfrench@samba.org> ---
David Howells spotted the problem - cifs.ko is missing setattr in the
cifs_symlink_inode_operations

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
