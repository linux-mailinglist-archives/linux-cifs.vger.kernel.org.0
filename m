Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6692013F8D0
	for <lists+linux-cifs@lfdr.de>; Thu, 16 Jan 2020 20:21:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731666AbgAPTVN (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 16 Jan 2020 14:21:13 -0500
Received: from mail-io1-f54.google.com ([209.85.166.54]:46403 "EHLO
        mail-io1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2437055AbgAPTVI (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 16 Jan 2020 14:21:08 -0500
Received: by mail-io1-f54.google.com with SMTP id t26so23234417ioi.13
        for <linux-cifs@vger.kernel.org>; Thu, 16 Jan 2020 11:21:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=l31HgNzwwaMtDE6wAVzvByJ/hV22rPADAY3M0e4bWLI=;
        b=fOHPX4wYdxlcqYVpJPtzQxAIX2ruyJpLa6tAQCbNow7UFKTaYmxZrHpDbiriCJ9TH9
         GX4SeAwgfWqhvjquRIcF07p9KyenMDvgMxqWCVcl2eT+Ibby7KVCxs3DNe/zeM6AnqfF
         dHpqUN4Frveur+G7IUptM/U/D52XmjsAoyq7DevyxoNYAg1RyPeJefPMP8J0u/ZE5115
         lfniPZgcGMFpOYMS49zpZ12ZiF7DdIDX+r6Y5aeqU6qA+8HDtBsjltHJNYp/+2Te+h2y
         Jfmh/pO8E2r+18e/p2R0S6YTF05C/sKbZdI3V92M/KairS/k17GQcLOjqZZ0Vy2ys2WR
         JZmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=l31HgNzwwaMtDE6wAVzvByJ/hV22rPADAY3M0e4bWLI=;
        b=FbPM6sHiu+4CTccM+s8hqkYv/8hnQOw/E8ZWOtEBDiX78wbCso6Bw4+INXLbywPORR
         TbLF+fKqX4lMTHaECK59QGazcaeltDsVVIIk0vgOUZIWY1GJYwU+9+aUyaxSbMM/Yg25
         MtGryuqct9U4fR8MEulx65jJNSmOrfS8nTfUl6M7syom9HsPVAi6rYkTi6/Tq1hGcxQ5
         jXJmnfEXfB4YlxQSUuLgZLK0EzgaT0tjwRcH56c/xv3k6Z7NQKErVG0xFdMQZ2JEuoAR
         aWSt0R0528YgqEmla3K6AnT1+xXm/uynRiU0MQPd6tIou4nIMo0vtpOvLpJ8m6VcKypL
         ov4w==
X-Gm-Message-State: APjAAAWrPrWVVN35mPesGAEOEOjWnalIrbNGTWU7B9Y8SGKvlw3eiX62
        g/S6mq8a8qRym2k9XAlXiPh2urZ7YuXk4xLDojLvvg==
X-Google-Smtp-Source: APXvYqxXG6MMcOM3NReoUr8B4aUlwDqE9sARferHOWSIPwH6QyzFlYwluQo6iolM5KsMimJ31J7heXvoF/W/k4YBoAg=
X-Received: by 2002:a05:6638:a99:: with SMTP id 25mr30893276jas.37.1579202468114;
 Thu, 16 Jan 2020 11:21:08 -0800 (PST)
MIME-Version: 1.0
References: <CALe0_75KJMBOMMAtSWNH=GkHv-vzvYQxOVuj8Eht6jfVfoYCcA@mail.gmail.com>
In-Reply-To: <CALe0_75KJMBOMMAtSWNH=GkHv-vzvYQxOVuj8Eht6jfVfoYCcA@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Fri, 17 Jan 2020 05:20:57 +1000
Message-ID: <CAN05THRzWK_3g+Eyt_dFThEyu6ejNwBPEFE+JzG8b0SOj7pY7A@mail.gmail.com>
Subject: Re: cruid+multiuser mount options
To:     Jacob Shivers <jshivers@redhat.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Fri, Jan 17, 2020 at 3:57 AM Jacob Shivers <jshivers@redhat.com> wrote:
>
> When mounting a Kerberized SMB share with both cruid and multiuser,
> the multiuser mount option is negated. This is not documented as
> explicit behavior. The question is whether this intended behavior or
> if it is unexpected.
>
> Does anyone have any existing thoughts on this?

To me it does not make sense to allow cruid and multiuser at the same time.
I think we should
1, document they are mutually exclusive
2, check for this and fail the mount with a log message if both
options are used concurrently.

>
