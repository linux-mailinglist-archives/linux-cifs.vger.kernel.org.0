Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B7FE2EF55C
	for <lists+linux-cifs@lfdr.de>; Fri,  8 Jan 2021 17:03:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726698AbhAHQCR (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Fri, 8 Jan 2021 11:02:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbhAHQCR (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Fri, 8 Jan 2021 11:02:17 -0500
Received: from mail-qk1-x72e.google.com (mail-qk1-x72e.google.com [IPv6:2607:f8b0:4864:20::72e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB08DC0612A3
        for <linux-cifs@vger.kernel.org>; Fri,  8 Jan 2021 08:00:56 -0800 (PST)
Received: by mail-qk1-x72e.google.com with SMTP id c7so8854650qke.1
        for <linux-cifs@vger.kernel.org>; Fri, 08 Jan 2021 08:00:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:content-transfer-encoding;
        bh=ik6B+6lkNc+iFrIPLOlH6nyfA0JsJ4cRGzVhof+Ll8w=;
        b=VpA/rpQ5qi0dFR7Mowe5aGCpF9u7a1VmQn5q9ZZuQCrdDN5tZn6sXwU9XTDBXmdfYo
         GHrqoepeF5HsPEyz7s83Q2FgcvfAPgYumhvcRGiBVC2GK+C5XV14Ui++lS3so5pA2/iT
         1rfJS9pZ3rxyDmU9J33KM0ODd0VovMdrCXj4PDHLrX+mNc/gXoaOQ9JB4dQ8+Pi+t3Y5
         owDd0dhEIxx5inTgS9uv9USD9ua3iUgbE7ZeBpPZmm3e8Mr6fY26xd3tbIKjFdXg+Z5e
         HzKpZOj3j3xkWAI+2U0PJ6WCaJvaJp4eQ7JPK2DyyOLy9Is9PPJi0kyYoCvOmtdELPp9
         eESw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:reply-to:in-reply-to:references
         :from:date:message-id:subject:to:content-transfer-encoding;
        bh=ik6B+6lkNc+iFrIPLOlH6nyfA0JsJ4cRGzVhof+Ll8w=;
        b=aMjY3BPUCi5RJW9NMDpXbD6x5Hx9RvnEKW6v5cp2VHpQCN+vDeenVCaXqEBJ4GkJoe
         grFqh8VJgCHlvZ8Qvowjp2oxbxGlj3WAcGnPe5E+aGtXR+fYu6i4iO6I02rJXPWONu4U
         CJ6zydhLI5KzCGJquXISFqGqfl7Zlmr8vTcqBXuwKovPnBNeWel14oMdkjF4fZPtJF6f
         jNSbEq+dtn/l+Ldm0EA2IudxGYFxQnO0wMAcqTiUMHZzSMPUdwamGV7GgDjrfF0uFeSG
         dSMwiVKe/3EIbOeYlr5dqgvG6uU72xTq0+g9qmJlehA6Psk/LkKmqAkhM9uoKiUmU5gm
         SkRg==
X-Gm-Message-State: AOAM532Pb0bT8OBgwQ37vU4Nd+NJJZMMd6P4zzNo7X+UlLXoe5ldHLJf
        Wx9BsqW9CCdpLhoZuTsCk9aaKUwtVG/VCXR064A=
X-Google-Smtp-Source: ABdhPJy5DcDb2tpoN6hwwNxbrQ4+6iS7cEF5BYexkcUy5+hBuogz8U9cM9vP/oN0NUHGYqGpdQYDJc3bSIrriX19zaw=
X-Received: by 2002:a37:9f14:: with SMTP id i20mr4583418qke.321.1610121655742;
 Fri, 08 Jan 2021 08:00:55 -0800 (PST)
MIME-Version: 1.0
Received: by 2002:a05:6214:148d:0:0:0:0 with HTTP; Fri, 8 Jan 2021 08:00:55
 -0800 (PST)
Reply-To: camillejackson021@gmail.com
In-Reply-To: <CAGCmbMQupVT-1ZX2--N7Bjf2eW4VuUQ4dE_hzd1qAGQuE_JBEQ@mail.gmail.com>
References: <CAGCmbMQupVT-1ZX2--N7Bjf2eW4VuUQ4dE_hzd1qAGQuE_JBEQ@mail.gmail.com>
From:   camille jackson <adamraouf78@gmail.com>
Date:   Fri, 8 Jan 2021 16:00:55 +0000
Message-ID: <CAGCmbMR9p4PyoggcTsQ1z8w+PCmEh+pd463ifnbWZyKw1o3FtQ@mail.gmail.com>
Subject: =?UTF-8?B?0JfQtNGA0LDQstGB0YLQstGD0LnRgtC1LA==?=
To:     undisclosed-recipients:;
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

0J/RgNC40LLQtdGC0YHRgtCy0YPRjiDRgtC10LHRjywg0LzQvtC5INC00YDRg9CzLCDQvdCw0LTQ
tdGO0YHRjCwg0YLRiyDQsiDQv9C+0YDRj9C00LrQtSwg0L/QvtC20LDQu9GD0LnRgdGC0LAsINC+
0YLQstC10YLRjCDQvNC90LUNCtCx0LvQsNCz0L7QtNCw0YDRjywNCg==
