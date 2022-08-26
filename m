Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 897C35A2A10
	for <lists+linux-cifs@lfdr.de>; Fri, 26 Aug 2022 16:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229946AbiHZOxE (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 26 Aug 2022 10:53:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231315AbiHZOxE (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 26 Aug 2022 10:53:04 -0400
Received: from mx.cjr.nz (mx.cjr.nz [51.158.111.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 614D7D8B2B
        for <linux-cifs@vger.kernel.org>; Fri, 26 Aug 2022 07:53:03 -0700 (PDT)
Received: from authenticated-user (mx.cjr.nz [51.158.111.142])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: pc)
        by mx.cjr.nz (Postfix) with ESMTPSA id 1A7AA80273;
        Fri, 26 Aug 2022 14:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cjr.nz; s=dkim;
        t=1661525580;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qv2Q1YBHZQt+MZby/akxO8dCpLg920FWhb1K+bMUxio=;
        b=oY8MZ2SkpqxFL7DIc0GkUVwRKqRH1zYO5/wd2qga1JHkBQlD/ixR0GpqihCSgwArrOHrut
        t8/fh6COgGbOV+gwhr3JTAXok25auiJNPSqctNfLhKYEKlE6hypmCldAZOPao+tGYM+1jT
        jy1B5ySfAHt/a49EDGwQA42qokxDXhzwnfg83n5srRRfMmKrdBHfcDvg0zhtOy/T4V520c
        cAI6HKlOu6pSPnHqAUuwl3mW/YJldf0HVoaUOeINjxlTJBRtUOFajWPs2ZbaOYdRTMPmik
        +TbaYL9sb3eUu9+KoAxjtgq0ckgOuYM7F7dVr0rbP0oehMPJxT8GByLighMzwA==
From:   Paulo Alcantara <pc@cjr.nz>
To:     Tom Talpey <tom@talpey.com>, linux-cifs@vger.kernel.org
Subject: Re: SMB client testing wiki
In-Reply-To: <8bcbba74-d6ce-3c40-4655-e67bf75f3b3f@talpey.com>
References: <8bcbba74-d6ce-3c40-4655-e67bf75f3b3f@talpey.com>
Date:   Fri, 26 Aug 2022 11:53:19 -0300
Message-ID: <878rnb3vkw.fsf@cjr.nz>
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

Tom Talpey <tom@talpey.com> writes:

> Is there an updated list of tests expected to pass, and/or
> any update for the scripting? Anything else I need to run in
> a basic local environment, to test smb3.ko client to ksmbd.ko
> and Samba servers on a pair of test machines?

For the testing environment, I'd say there is nothing special.  Just
create two shares in both samba and ksmbd servers and specify them in
local.config when running xfstests.  We usually name them as 'test' and
'scratch', respectively.

For testing SMB3 over samba, you would have something like this in your
local.config:

  [smb3samba]
  FSTYP=cifs
  TEST_DEV=//tom.samba/test
  TEST_DIR=/mnt/test
  TEST_FS_MOUNT_OPTS='-ousername=tom,password=***,noperm,vers=3.0,mfsymlinks'
  export MOUNT_OPTIONS='-ousername=tom,password=***,noperm,vers=3.0,mfsymlinks'
  export SCRATCH_DEV=//tom.samba/scratch
  export SCRATCH_MNT=/mnt/scratch

and then run xfstests

  ./check -s smb3samba ...
