Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F40A33B3454
	for <lists+linux-cifs@lfdr.de>; Thu, 24 Jun 2021 19:09:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbhFXRLp (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 24 Jun 2021 13:11:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232064AbhFXRLm (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 24 Jun 2021 13:11:42 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADD78C061760
        for <linux-cifs@vger.kernel.org>; Thu, 24 Jun 2021 10:09:21 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h3so7060293ilc.9
        for <linux-cifs@vger.kernel.org>; Thu, 24 Jun 2021 10:09:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=p95plxgcKdT8+TUJCmcKdAyJL6L8C+j3muAeTI6tbvEOMwKUFZvBH22Z3GEGxdnUZH
         d9XkDasjcz/bUj2n1PkWxPPQL/Sxtf1a7ckN43IkWwU4a9v6DYeOi9Tg8DPYHl700hH/
         xlmv54Ir2NUVB8zwaX1UsxTzP5GUW3mdywmszCeflzWKbXzDgkMNhx+qVsi3FklHnD5x
         fSDWvxz3POXOJ/0yZM+F2G99rPMTFJK+bPA5TWYu0VJpvpEjmQwRSgXLB6dx+kXpC0Uz
         JX+JhI0lSB7VkwJTdkbApCrUx6TGzp99N5mAm/d0lil4hmexz93RFAPSpMzmwkjNchKB
         rXTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to;
        bh=ANhbTggsY3NFhRZExKMwUmb3VzJqye8XLvWVXSvNBkQ=;
        b=H7Tij4hS66OPAGIoB2rybmyIGAaZLvrsB0I30pVcJh8XWFCXwXqNL45d/TBGCQsl1y
         BZSGyDbpr8MnQvLcR8C9fgRHUhJqR1T6uvDNeVuCKBn4rhHAYAH4KD3/pRHwHG/KL/cd
         /RwnhE0odOAPZ4ZkEZu8ssR3JK/0+ROJAf7b63xwmabJPqKvF5HMLs98W1rs2pb9JirT
         d6BB2U1pv+Lpz57u46tNNOT9cfH34TAEBScC6vDCwYZtVRz7blaf6b55Ln+/J12cCjO/
         3BJaLCroDpiMkO6QXefR7pwIL2Py2hing6veENLmSy3ITuuB8rjlawbG5yGVVc9wsdA5
         NpHg==
X-Gm-Message-State: AOAM5310vHNE7J4ngoHOJCYN5PM4gYImWBpV1WejtJwxG47HfEtEvxAP
        lAvbIeAltZef7u9tWQOtdwpUDOUhh/xO0iF0sZE=
X-Google-Smtp-Source: ABdhPJzkYUuO368jts0QgMQyJe9SHzg0U698qd8KdfojEfYsXnHtwMfPGxVHmw7fwQ64+IhHRhAEJH5nusdeW4BWzcA=
X-Received: by 2002:a05:6e02:524:: with SMTP id h4mr4098121ils.255.1624554560853;
 Thu, 24 Jun 2021 10:09:20 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a05:6638:3aa:0:0:0:0 with HTTP; Thu, 24 Jun 2021 10:09:20
 -0700 (PDT)
Reply-To: tutywoolgar021@gmail.com
In-Reply-To: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
References: <CADB47+4Wa3T59Vq_==GTXEfHrX5x-2vQFxaTBO0dTdyAweCVpw@mail.gmail.com>
From:   tuty woolgar <faridaamadoubas@gmail.com>
Date:   Thu, 24 Jun 2021 17:09:20 +0000
Message-ID: <CADB47+607zNBfYFb4bj0nUhuuYgAdwT=G_wJ9-EeV0ESHe56Jg@mail.gmail.com>
Subject: greetings,
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

My greetings to you my friend i hope you are fine and good please respond
back to me thanks,
