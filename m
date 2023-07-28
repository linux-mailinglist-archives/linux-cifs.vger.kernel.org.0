Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACE076758F
	for <lists+linux-cifs@lfdr.de>; Fri, 28 Jul 2023 20:38:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229457AbjG1SiD (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 28 Jul 2023 14:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjG1SiB (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 28 Jul 2023 14:38:01 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4B5423C
        for <linux-cifs@vger.kernel.org>; Fri, 28 Jul 2023 11:37:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-ID:Date:To:From:CC;
        bh=5JYhfeLuGTtYh4yUr+99DBP0PrN2whL7iVjNIoQlPqs=; b=J4YjjZqBTD4iqsfWKrQ71ZukpX
        OAewka/e4gLNW9GAGCAlyx6RLbDF9DfnB+od60K0/z/YXJV1K5/3a3+i0b+G0lHeppj8ZbHw70ZDk
        R1p76w65dpGlzbdJCbboMh8zlqvQborSF30m57FcwSEQuy1eAXoByr2Z255ke+Qc4yZQ4XKj1uMsq
        mLbInlHrJzt6GTCwL3y9ioLwNovS4VkWVv+7gBxnsXeVK2KlShsXzhhQQCDfQ8KOmVJLJmyAtNVCN
        09zQGBYRlZoSd66/lejpH88Aht4hxPBgc7k+IsA9CQ3SXZSXrcGMWuWKbo7E5H7bPOU3TAxMPKEQe
        Pb+L6le/dCA0c8tRA0NJRKjra6Ot8BXspAI7DIaXrDEqZENIKiiQewOJEw3j2YvKJm8SMCQrEUm5Q
        HtCTHmBQ4aWP16ld5+fz8WYc3wgc9YHIR8leHXe/2ss09hD49UeKl/+2M6KgDVu3SxqLKIoflBJtV
        T4kegE+gRb37ZnQrNiS+oJAl;
Received: from [2a01:4f8:192:486::6:0] (port=35396 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1qPSLd-004joy-22
        for cifs-qa@samba.org;
        Fri, 28 Jul 2023 18:37:57 +0000
Received: from www-data by hr6.samba.org with local (Exim 4.95)
        (envelope-from <www-data@samba.org>)
        id 1qPSLd-000OUK-9Q
        for cifs-qa@samba.org;
        Fri, 28 Jul 2023 18:37:57 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 15428] Linux mount.smb3 Fails With Windows Host After Update
 July 2023 Update kb5028166
Date:   Fri, 28 Jul 2023 18:37:56 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: user space tools
X-Bugzilla-Version: 4.x
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: major
X-Bugzilla-Who: sbharvey@verizon.net
X-Bugzilla-Status: NEW
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: jlayton@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: attachments.created
Message-ID: <bug-15428-10630-CkJXn2rXlK@https.bugzilla.samba.org/>
In-Reply-To: <bug-15428-10630@https.bugzilla.samba.org/>
References: <bug-15428-10630@https.bugzilla.samba.org/>
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
X-Bugzilla-URL: https://bugzilla.samba.org/
Auto-Submitted: auto-generated
MIME-Version: 1.0
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

https://bugzilla.samba.org/show_bug.cgi?id=3D15428

--- Comment #5 from Scott Harvey <sbharvey@verizon.net> ---
Created attachment 18010
  --> https://bugzilla.samba.org/attachment.cgi?id=3D18010&action=3Dedit
Window 10 not updated, Windows 11 update, Wireshark pcapng trascript

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
