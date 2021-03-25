Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07F3E349278
	for <lists+linux-cifs@lfdr.de>; Thu, 25 Mar 2021 13:54:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230196AbhCYMyB (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 25 Mar 2021 08:54:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230381AbhCYMxu (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 25 Mar 2021 08:53:50 -0400
Received: from mail-yb1-xb29.google.com (mail-yb1-xb29.google.com [IPv6:2607:f8b0:4864:20::b29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C7A5C06174A
        for <linux-cifs@vger.kernel.org>; Thu, 25 Mar 2021 05:53:50 -0700 (PDT)
Received: by mail-yb1-xb29.google.com with SMTP id 8so2104558ybc.13
        for <linux-cifs@vger.kernel.org>; Thu, 25 Mar 2021 05:53:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=RAJRDYvsZX6zACbur6IB0PrNh3S3vG/dwzTRq8yaXhk=;
        b=ZcmphdZmF/nAeuwjJbVSA4xFTKu3EBb+0y3DOJSLKrJyMv8qsQQ0ElIhYnvOwTArwL
         1OAb6W5zt/oWCWdArXCwvTiXZbPPag5X/QIr6RpbxE0YveC5HIg5ozjFHCdBZfl2eWmc
         Eo8UkYK745/APOiiERGvVcg38jg8RnAdC8J1yE6Z95Ay67AmVLJpuIejJkJlhugoBNLP
         wnxHzm/lJ/P7QqXRv54o8gtVQgqOyIUf0bQCarmmYuhqZdKnoAF/WM/Svz2aVSpFXZK5
         dqnZj5wklK2jt/38fnrIxWnH+pFzmNWRS8Ck8fPKPEMCIcedMtUmRTRExxAgmIhu/evR
         P1NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=RAJRDYvsZX6zACbur6IB0PrNh3S3vG/dwzTRq8yaXhk=;
        b=EinfyFCpDPfS951rFSWx1sU8gR8fh4gDaLs03EOhVOZQReZtd3HNjKwg/9Lt3uRLUi
         5dwYr388sERZzRs4jzSeeqjn+7cwU9hsV1/fXEL7MHMVE70Zm1IEQjxQCl0xPVnSjyde
         rMcJztKYLgB1lmkzQhK8VLrerCP5bDGR/l0u5368T/cAsfDzGWlp6PZdCgxMJtBAM39n
         tw8v1Haqx9jBnkufGG8jIOq4PbnSQVWlRjnVqFFd67uAv0Bp95UanmH42NlJfu3Ctq/7
         2nzjjhLeRKlnhmt00ZV3bbJQxmRMVRK42BgOJiUbi/HJVekVz4bklCX2/qOB2IAYvfyu
         XNew==
X-Gm-Message-State: AOAM533MTxdke0FssyxHPgiNHSB6xd8RCK5CenY7muz+YkmynmgmwvhN
        tk+L5pCUA8ou4WgmvrXG9Q3fTlUXwu9DhZQBRsg=
X-Google-Smtp-Source: ABdhPJzVe+PO+BZJRIkUnu6fmJVW6XQt6kTA8YUkojT4JIjCTlD/6um0DZonwvdmenwXWG/srhcgNfgF4FjsEbmStUU=
X-Received: by 2002:a25:9d08:: with SMTP id i8mr12207915ybp.293.1616676829699;
 Thu, 25 Mar 2021 05:53:49 -0700 (PDT)
MIME-Version: 1.0
From:   Shyam Prasad N <nspmangalore@gmail.com>
Date:   Thu, 25 Mar 2021 18:23:38 +0530
Message-ID: <CANT5p=qKxu17O__xWzwfbJJ4RAAK4whg63Yx6P6FGKVYrMkxOg@mail.gmail.com>
Subject: [PATCH] cifs: Adjust key sizes and key generation routines for AES256 encryptions.
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>,
        ronnie sahlberg <ronniesahlberg@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Hi Steve,

Please include this fix for AES 256 encryption algorithm based mounts.
I've validated this by mounting and performing I/O.

-- 
Regards,
Shyam
