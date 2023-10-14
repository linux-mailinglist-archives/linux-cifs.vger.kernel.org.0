Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC9B7C9000
	for <lists+linux-cifs@lfdr.de>; Sat, 14 Oct 2023 00:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjJMWFU (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 13 Oct 2023 18:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229679AbjJMWFU (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 13 Oct 2023 18:05:20 -0400
Received: from hr2.samba.org (hr2.samba.org [IPv6:2a01:4f8:192:486::2:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B57EB7
        for <linux-cifs@vger.kernel.org>; Fri, 13 Oct 2023 15:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=samba.org;
        s=42; h=Message-ID:Date:To:From:CC;
        bh=OdVw9gTgz9IwDVYMvs9kPN2ODpzZwexF6DNga8eLT9Y=; b=Ebn4Pfc5mY3608SkBXGetEmJBb
        trjxFAZolrkdSwCdWyMfiu04vgSE21iGmpqsjuwBloRVds4hENxuSpUnMW1aJFttGz3pBe243UMe9
        2AypVtkzbYHJ5NauRhq97qtZ1NXs/pJVoEgCNm+Ia39KIizS6rOsQoE6USZ7ar4237k3AxDsflNDp
        lfV500U9+cP0w9qDupEfqzbxNh2PN9t1bqixCrGZy25e0V+9tnBjaYdkH2+eHfaw1b7CSaQOgXQNR
        ig86JT5UcrunrLR9cQs6AtdnvpZ7MjsnrDeEkCq2ORwZ/o1jjfdkFuSV44QMIPSu8FGIl6ZFJWHm/
        O318EEtQip89YHzap2LMNB0lgv6lLBhcYDWzE/UrDQ6Hy5kMOPcwRzdrcr9RyKrmMgym5f/K6h+dN
        /+ye53WAjW5r1B6d4ARgRJWiGxRhO9bt4SdZNjDBe0VUeHaFhBO/3xCrL+Xd48p80Ez0ylIRCbggj
        0xjYb7UJEulziJgyrVT2nQVJ;
Received: from [2a01:4f8:192:486::6:0] (port=38316 helo=hr6.samba.org) 
        by hr2.samba.org with esmtps (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__CHACHA20_POLY1305:256)
        (Exim)
        id 1qrQHS-000Wzf-2Q
        for cifs-qa@samba.org;
        Fri, 13 Oct 2023 22:05:15 +0000
Received: from www-data by hr6.samba.org with local (Exim 4.95)
        (envelope-from <www-data@samba.org>)
        id 1qrQHQ-000ETN-RZ
        for cifs-qa@samba.org;
        Fri, 13 Oct 2023 22:05:13 +0000
From:   samba-bugs@samba.org
To:     cifs-qa@samba.org
Subject: [Bug 14476] Cannot set timestamp of Minshall-French symlinks from a
 CIFS mount
Date:   Fri, 13 Oct 2023 22:05:10 +0000
X-Bugzilla-Reason: QAcontact
X-Bugzilla-Type: changed
X-Bugzilla-Watch-Reason: None
X-Bugzilla-Product: CifsVFS
X-Bugzilla-Component: kernel fs
X-Bugzilla-Version: 5.x
X-Bugzilla-Keywords: 
X-Bugzilla-Severity: normal
X-Bugzilla-Who: sfrench@samba.org
X-Bugzilla-Status: ASSIGNED
X-Bugzilla-Resolution: 
X-Bugzilla-Priority: P5
X-Bugzilla-Assigned-To: sfrench@samba.org
X-Bugzilla-Target-Milestone: ---
X-Bugzilla-Flags: 
X-Bugzilla-Changed-Fields: bug_status
Message-ID: <bug-14476-10630-9cdQzq4WGO@https.bugzilla.samba.org/>
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

Steve French <sfrench@samba.org> changed:

           What    |Removed                     |Added
----------------------------------------------------------------------------
             Status|NEW                         |ASSIGNED

--=20
You are receiving this mail because:
You are the QA Contact for the bug.=
