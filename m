Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE6C97A717B
	for <lists+linux-cifs@lfdr.de>; Wed, 20 Sep 2023 06:16:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232663AbjITEQ4 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 20 Sep 2023 00:16:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232721AbjITEQu (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 20 Sep 2023 00:16:50 -0400
Received: from mout02.posteo.de (mout02.posteo.de [185.67.36.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5A3BB9
        for <linux-cifs@vger.kernel.org>; Tue, 19 Sep 2023 21:16:43 -0700 (PDT)
Received: from submission (posteo.de [185.67.36.169]) 
        by mout02.posteo.de (Postfix) with ESMTPS id B7267240101
        for <linux-cifs@vger.kernel.org>; Wed, 20 Sep 2023 06:16:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=posteo.net; s=2017;
        t=1695183400; bh=lFHfS0vsRNGeBRXvikSEJC7Vh25BRlR/CYOXlm4nVS4=;
        h=Message-ID:Date:MIME-Version:To:From:Subject:
         Content-Transfer-Encoding:From;
        b=ecwcWqAONZmLRgOefLbwWJO4L4OzT2uuYjp2xcA/pleFmXnsD7OnQeD3wfeh8uBhr
         hU4BZkyGwS7diioVRVrtnwJ9U+5Q8BsHoilZxgeznLlsWKvNzSL06L+xRMCh/+cPbn
         DyOVD4LVNA5B2g1+XGylkUp3NXzqCY84HArJv8Lkc7ya3M6kBqobSVQgJQihfbjEcf
         SRNUAYgmL78/Z0E18xkqhJcOMJQ8+Ual9F6HLutcdvKq4beBaUplLqsjiPqAZ3o9MA
         tKhmF0vsoRJKTwlr9PdX0Lqp/1StNQ9vtabmfwiSjFneSlKPtLrrNHPpDxKR4A8xDv
         caHW07GiXAixQ==
Received: from customer (localhost [127.0.0.1])
        by submission (posteo.de) with ESMTPSA id 4Rr4wm3LMGz6twB
        for <linux-cifs@vger.kernel.org>; Wed, 20 Sep 2023 06:16:40 +0200 (CEST)
Message-ID: <123deb27-bf0d-4493-8c38-db15129b8204@posteo.net>
Date:   Wed, 20 Sep 2023 04:17:46 +0000
MIME-Version: 1.0
Content-Language: en-US
To:     linux-cifs@vger.kernel.org
From:   Lucy Kueny <lucy.kueny@posteo.net>
Subject: Hardcoded sleep causes userspace hang
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

I was surprised to find a hardcoded "msleep(3000);" in the 
__cifs_reconnect function.
When using a cifs automount on wifi, a dropped connection results in an 
unusable system even in soft mode. Repeated re-connection attempts cause 
file browsers to hang for minutes. Auto-completion also freezes the 
command line, especially with zsh.
Systemd will attempt to reconnect for every file access and fail, 
letting the userspace deal with it. This behavior seems sane to me but 
requires the remount to fail as quickly as possible. Currently, it waits 
for 3 seconds every time.
Should this delay be user-adjustable?
The use case is specifically for NAS users with laptops, where leaving 
the local network is a common occurrence and hanging GUIs are undesirable.
