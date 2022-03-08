Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03E6A4D1A7D
	for <lists+linux-cifs@lfdr.de>; Tue,  8 Mar 2022 15:28:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbiCHO3J (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 8 Mar 2022 09:29:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233300AbiCHO3I (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 8 Mar 2022 09:29:08 -0500
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AA8726CA
        for <linux-cifs@vger.kernel.org>; Tue,  8 Mar 2022 06:28:11 -0800 (PST)
Received: by mail-wr1-x444.google.com with SMTP id u10so27205985wra.9
        for <linux-cifs@vger.kernel.org>; Tue, 08 Mar 2022 06:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:sender:from:date:message-id:subject:to;
        bh=+xCzDXKpurcBEhZ8+xr/1+qLsXYFBobYcsOzCn7TcBU=;
        b=fBbWWzR3GpMS+93ciajoo029c8FgxPjBA+AUU6C4eRROwd54dlPOY/99NlODG1oTRW
         W9hVeKUB97h0E3V1Idc3aD63NFEQ3QD/m89uHsN4n3lNmlLpV7Ar2pqEb/80+jtWGzKT
         OMqvcXv52pVBe84+BcQQWTWCW9jxXjQ2f5fbTRoOHfcr0Onmm2zKZ7Vex0FSpLip+VRr
         pvLLW4GqPC6CwzKy7DWD1vfdZb4ErSEs3L6vQEtGNPCTMzhomrGcMYPVf/qCM62Hi0vY
         mkAIZ1bhRLM5YYNWZXCIgXmuYTq5iReg+8bAvr9Du1D5QJV+oynDa0ttcR2LDKDpg4QH
         qjEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:sender:from:date:message-id:subject
         :to;
        bh=+xCzDXKpurcBEhZ8+xr/1+qLsXYFBobYcsOzCn7TcBU=;
        b=vExG9mndRUFWnRvSdPir+uapwdHT4BmTnIkkt4QmMfd50a58A+CKWk8yhZHrEgc75A
         H4j1/cP01FrLBc8dKG6OJNfuO1CCZLNrJCDoWvpRNhuA0f9K6aWS1xI8M60s/inURipe
         iHPa0vgbu9KTXZV3AdzFgT15WUboDT0NsWcfpuBvCJDUYqpbVLZVhjJ4DfyDDB8CNrAU
         klQjneGrQ6gZvo/rsJQQYFtKbeTM5IWLUbQpLCrzrWrsSHLTN5WOK8DQTW89/k91WM8G
         w3bVC5ci1rc3slTRZxMTzVR8ufPS4W/YU3JpylnpCnQ70rXAFc8fuQhEMZFnBgxiKLNc
         ZT8Q==
X-Gm-Message-State: AOAM530JvsmUt7bIuNp0pT8JoRLQtJSREzjcCIAfqsDQoUvjqM/0Ndul
        YLzFXRu8V6pMm/eFM3BXrchn1FbgO0xHoUSNrLA=
X-Google-Smtp-Source: ABdhPJwAGDE3POdz8NP8fTEvWR9Uo3X93XOXVBaBRCNvqtGpbm8UUalx8K7phMENQhXH3NVN6HIOw8mEt3FUJyqOw9M=
X-Received: by 2002:adf:fbcf:0:b0:1ef:d5f2:23a5 with SMTP id
 d15-20020adffbcf000000b001efd5f223a5mr12554349wrs.567.1646749689503; Tue, 08
 Mar 2022 06:28:09 -0800 (PST)
MIME-Version: 1.0
Sender: abiodunboluwatife2017@gmail.com
Received: by 2002:a05:600c:502c:0:0:0:0 with HTTP; Tue, 8 Mar 2022 06:28:08
 -0800 (PST)
From:   Lisa Williams <lw23675851@gmail.com>
Date:   Tue, 8 Mar 2022 14:28:08 +0000
X-Google-Sender-Auth: 2reQXOnF7Kh_ai6iDG3mosDekzg
Message-ID: <CADqw2PLYKkkj=yN1Gh1Wocn0wPWBmnVQMe-NZx1QG81byc9vWg@mail.gmail.com>
Subject: My name is Lisa Williams
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_20,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi Dear,

My name is Lisa  Williams, I am from the United States of America, Its
my pleasure to contact you for new and special friendship, I will be
glad to see your reply for us to know each other better.

Yours
Lisa
