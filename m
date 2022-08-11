Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E812B58FD04
	for <lists+linux-cifs@lfdr.de>; Thu, 11 Aug 2022 15:03:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235188AbiHKNDj (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 11 Aug 2022 09:03:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234456AbiHKNDi (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 11 Aug 2022 09:03:38 -0400
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 008E95C9E5
        for <linux-cifs@vger.kernel.org>; Thu, 11 Aug 2022 06:03:36 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 052318026A;
        Thu, 11 Aug 2022 13:03:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1660223015;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=cWY3YPHHgo3hexw5QZddBSyCKf6iTqpRIDloXcqjXG0=;
        b=HpdVLfISCsdy2NRTrvrz+6FHiwhGsATuwZrC1uvVRD1EyK6EOyXACnqxUo2xx2JXJf0OGK
        s4k8x7e8svY7r4Nun/O+jTAwqRj1G+0POlROJLCQv4brkSFyNJCzJJe3Zq+mS5XdoueENZ
        xwcs57X/Auh1b7V/t2sBEmVfzguF4YzSO8E/K7ZBaywF8gRzAUmFI/5RO6GJTdkjArI1ui
        vb9IiXr3aQ1exf2rbC1HqGJniyClun/3BjkNw9beNAOnXEaR1X3U/mwY2xIO+0Fjabru7p
        Vvdqw5DTJ1MBILZ0gCy6qz3BydhYBWKv5p/NNLo4IzyP+EI0A22kMhigQoR3rQ==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Ronnie Sahlberg <lsahlber@redhat.com>,
        linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>,
        Ronnie Sahlberg <lsahlber@redhat.com>
Subject: Re: [PATCH 2/9] cifs: Do not use tcon->cfid directly, use the cfid
 we get from open_cached_dir
In-Reply-To: <20220809021156.3086869-3-lsahlber@redhat.com>
References: <20220809021156.3086869-1-lsahlber@redhat.com>
 <20220809021156.3086869-3-lsahlber@redhat.com>
Date:   Thu, 11 Aug 2022 10:03:48 -0300
Message-ID: <87tu6jszij.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Ronnie Sahlberg <lsahlber@redhat.com> writes:

> They are the same right now but tcon-> will later point to a different
> type of struct containing a list of cfids.
>
> Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> ---
>  fs/cifs/smb2inode.c | 4 ++--
>  fs/cifs/smb2pdu.c   | 2 +-
>  2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
