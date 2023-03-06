Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74BB76ABC4B
	for <lists+linux-cifs@lfdr.de>; Mon,  6 Mar 2023 11:26:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229549AbjCFK0k (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 6 Mar 2023 05:26:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230317AbjCFK00 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 6 Mar 2023 05:26:26 -0500
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D21823655
        for <linux-cifs@vger.kernel.org>; Mon,  6 Mar 2023 02:25:55 -0800 (PST)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-17671fb717cso9303245fac.8
        for <linux-cifs@vger.kernel.org>; Mon, 06 Mar 2023 02:25:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678098351;
        h=to:subject:message-id:date:from:reply-to:mime-version:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vh7FN/ulAdnmY8O0LKz7bqpIFk4oOSQ9iCZ8VQ/AkNo=;
        b=EDbhPO1WKzSJy97Cp1KR4Ue1wIcLFSscoH9L1E67CyPoJvstONJwP7RxKCqsDiuar/
         4XZc6UhnyOFrEHlIQ3KmGU6oX8xWOyZpiVA4bD6F27cjopM5KQeiwoXnQq1r2hu/0hkW
         LgiQ9FGonNq8AsMsEKBqZEvtwgOfW2lv3iUKapY2ocqE+LRWfsVifUNA3eNbIcULbvPT
         nBBU0ns0xWwmvS7ETCAh5Z5lhdCiLVSRis+m63aq8CObwyUrMLAjGQpDeSf4OVAOQav5
         5TuEH4NOUnTGCqcHGRIE0/tBavRRplzW4HaWY1DRs+pas+nyfL/37adPjYmqfexbl/Di
         PS3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678098351;
        h=to:subject:message-id:date:from:reply-to:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Vh7FN/ulAdnmY8O0LKz7bqpIFk4oOSQ9iCZ8VQ/AkNo=;
        b=jtNQcNusno9UNkbnf0es8GZ+FE/A9Qa6ELnDduxXWGPtymTXhMzn08cRMB7CaJ//QM
         804A1p8nT06RilBLA9xx8MuRa3aVvYKmJFwn40Apb+8FWAWyiuag8xP+RJCOx9ieTFk6
         +orUOEOdIfmSaUG7eVbRs6XQ+Xo8rqIV81TuQL+2NeWTM99ApFuz5HpMRBumI2IQt56E
         7Pr57GBv73auo71TrpuTdw1GjirGwy00JpciHhNIk/dMXe6gZ0dAOgRP1Plp5tTU1Sgi
         k+2pYAuyh8aBC1lKnOLnq0zWJKk4J8ASpTlneRc5kHZXvvs5C82LuYgvZJMR3lxdr3Ov
         hf5Q==
X-Gm-Message-State: AO0yUKUxz5dVrFNIixUN6Zw/GeFw98dGhV8B4WZ8lC9mA3nAyK5mO9sN
        wCCjKE8xYEDxV3QUMVAb67Mwwi+Kx1XMIMPSXqG0AxxJ4m8=
X-Google-Smtp-Source: AK7set9YqazPiOkBuGm+YrFZOLe51O90+qKBrIr6WBjXtnVrmZ9RIOYyWRLBWcHI+/rsVoNhMQhwnCpcR6G8n2Z6mzE=
X-Received: by 2002:a05:6102:e44:b0:402:999f:44d3 with SMTP id
 p4-20020a0561020e4400b00402999f44d3mr6975472vst.1.1678098330725; Mon, 06 Mar
 2023 02:25:30 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a59:ce6f:0:b0:3ae:930b:3e70 with HTTP; Mon, 6 Mar 2023
 02:25:30 -0800 (PST)
Reply-To: madis.scarl@terlera.it
From:   "Ms Eve from U.N" <denisagotou@gmail.com>
Date:   Mon, 6 Mar 2023 11:25:30 +0100
Message-ID: <CAD6bNBi6bPCYboaF4-xBgmeUTFn6JMXqU6TNepQig=NRMqhdUg@mail.gmail.com>
Subject: Re: Claim of Fund:
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=4.6 required=5.0 tests=BAYES_50,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_SCAM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,UNDISC_MONEY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Level: ****
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hello Good Morning,
This is to bring to your notice that all our efforts to contact you
through this your email ID failed Please Kindly contact Barrister.
Steven Mike { mbarrsteven@gmail.com } on his private email for the
claim of your compensation entitlement

Note: You have to pay for the delivery fee.
Yours Sincerely
Mrs EVE LEWIS
