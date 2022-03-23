Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADECB4E5505
	for <lists+linux-cifs@lfdr.de>; Wed, 23 Mar 2022 16:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233340AbiCWPTR (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 23 Mar 2022 11:19:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229765AbiCWPTR (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 23 Mar 2022 11:19:17 -0400
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA2521251
        for <linux-cifs@vger.kernel.org>; Wed, 23 Mar 2022 08:17:47 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 70EF180856;
        Wed, 23 Mar 2022 15:17:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1648048666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OfzSGUxlwgcmk5Zs9o9yFHWizF+fKltKR4S8l+JAllQ=;
        b=XYLFsJLyqE1FmPM05oCOaoIklHmQnCDEBiRq2CzhVtVLtx1jVONDSTYVbiM5GmFwuzxUTw
        2u2ZRVnefj77yu3FPEiGKjsfDzlQskztE4mPdiaAb7c0S6WxX6iv5Al31qfFJvcBsCQvqW
        bfaIkZA0poo7mR8bA1kPf2VrPfvuUPylrUCs270bmZdHrmhrKnZFHJBsB/u9nhCWBoYP7m
        wlMoQjbe/RT6U9fk/cKDYpBKHc4BB/RInxxbRhto41mvABAhuYn6od5SFrLvv0PvFYVtUv
        3d0SJ4HIEsodfm8eW7qJPXmJr26vSPvS55+QmkDhb6T9vc9zet5IjdRHm/8Bjg==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Ronnie Sahlberg <lsahlber@redhat.com>,
        linux-cifs <linux-cifs@vger.kernel.org>
Cc:     Steve French <smfrench@gmail.com>
Subject: Re: [PATCH 2/2] cifs: change smb2_query_info_compound to use a
 cached fid, if available
In-Reply-To: <20220322062903.849005-2-lsahlber@redhat.com>
References: <20220322062903.849005-1-lsahlber@redhat.com>
 <20220322062903.849005-2-lsahlber@redhat.com>
Date:   Wed, 23 Mar 2022 12:17:41 -0300
Message-ID: <87tuboitpm.fsf@cjr.nz>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,DOS_RCVD_IP_TWICE_B,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Ronnie Sahlberg <lsahlber@redhat.com> writes:

> This will reduce the number of Open/Close we send on the wire and replace
> a Open/GetInfo/Close compound with just a simple GetInfo request
> IF we have a cached handle for the object.
>
> Signed-off-by: Ronnie Sahlberg <lsahlber@redhat.com>
> ---
>  fs/cifs/smb2ops.c | 45 +++++++++++++++++++++++++++++++++++----------
>  1 file changed, 35 insertions(+), 10 deletions(-)

Reviewed-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
