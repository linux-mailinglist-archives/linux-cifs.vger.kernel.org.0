Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29AC76660FD
	for <lists+linux-cifs@lfdr.de>; Wed, 11 Jan 2023 17:52:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbjAKQwX (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 11 Jan 2023 11:52:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232271AbjAKQv7 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 11 Jan 2023 11:51:59 -0500
Received: from mail.sernet.de (mail.sernet.de [IPv6:2a0a:a3c0:0:25::217:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A713B879
        for <linux-cifs@vger.kernel.org>; Wed, 11 Jan 2023 08:51:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sernet.de;
        s=20210621-rsa; h=In-Reply-To:Content-Type:MIME-Version:References:Reply-To:
        Message-ID:Subject:Cc:To:From:Date:Sender:Content-Transfer-Encoding:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dG706L96WtMoL8wLYjPhDehej9nE7i+cnwn5VC0/7OQ=; b=YKA865ZjGUVI1hTKZM3L7Gdbkv
        AMvWFSz75qYVOCyvO2iGDo3aBmH5P2G6PKkQmAz8iYYRy1wbhwutH2buPnaScwesar8vzW/ysJZlO
        RqB9tpCwi0Gz9Vh2Tz0rhVxHonH+NXn/Z6uE2gSrfuKnATEzKXBWPyywhUyz0EFXj9Km0ZRVkDPs1
        UbuTUtTZWn/DRgnouo5aDpKg0RGQl1V4cth68+j4euiYfO1ng/Kh1OXMDBR/omOcqRze4pedscjx/
        8USkBGT2g4IFhQlNczaDMNOriFRUdXYZS8XOFUsU+3XSfZ3iBv3c2JjDGYKyzNIhsBNhq+TeVVTUS
        jsShVW9Q==;
DKIM-Signature: v=1; a=ed25519-sha256; q=dns/txt; c=relaxed/relaxed;
        d=sernet.de; s=20210621-ed25519; h=In-Reply-To:Content-Type:MIME-Version:
        References:Reply-To:Message-ID:Subject:Cc:To:From:Date:Sender:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=dG706L96WtMoL8wLYjPhDehej9nE7i+cnwn5VC0/7OQ=; b=BvpK13ihnIQrwkRd3VVjEHXpyl
        y1oK+WeAcDJbmaZvhCvm1UemL6R8afq/WPsdgcUvHaIF2N/99Vrp9xx21FDw==;
Received: from intern.sernet.de by mail.sernet.de
        with esmtps (Exim Mail Transfer Agent)
        id 1pFeKR-005k1K-J4; Wed, 11 Jan 2023 17:51:55 +0100
Received: by intern.sernet.de
        id 1pFeKR-00DNop-AE; Wed, 11 Jan 2023 17:51:55 +0100
Date:   Wed, 11 Jan 2023 17:51:51 +0100
From:   Volker Lendecke <Volker.Lendecke@sernet.de>
To:     Steve French <smfrench@gmail.com>
Cc:     linux-cifs@vger.kernel.org
Subject: Re: Fix posix 311 symlink creation mode
Message-ID: <Y77pJ5LqbeU5uj8N@sernet.de>
Reply-To: Volker.Lendecke@sernet.de
References: <Y76gvH9ADxSgAxSw@sernet.de>
 <CAH2r5muTjUB7LBevcKE6oxWHPrm6yxY7H5jRuECMLbebQyRXpg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAH2r5muTjUB7LBevcKE6oxWHPrm6yxY7H5jRuECMLbebQyRXpg@mail.gmail.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Am Wed, Jan 11, 2023 at 10:21:07AM -0600 schrieb Steve French:
> Should this be 0777 instead of 0644?
> 
> I noticed the man page for symlink says:
> 
>      "On Linux, the permissions of an ordinary symbolic link are not
>        used in any operations; the permissions are always 0777 (read,
>        write, and execute for all user categories), and can't be
>        changed."

I thought about that as well. If you "ls -l" such a symlink once
created, it will show as 0777, probably the client does it
somehow. The problem however is that if you create it with 0777
server-side, everybody can mess with that file that the client view as
a symlink. That's why I thought that 0644 is the best approximation.

Regards, Volker
