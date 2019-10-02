Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BAB02C4800
	for <lists+linux-cifs@lfdr.de>; Wed,  2 Oct 2019 08:58:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726070AbfJBG6m (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Wed, 2 Oct 2019 02:58:42 -0400
Received: from mail-io1-f46.google.com ([209.85.166.46]:44222 "EHLO
        mail-io1-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725851AbfJBG6l (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Wed, 2 Oct 2019 02:58:41 -0400
Received: by mail-io1-f46.google.com with SMTP id w12so26351728iol.11
        for <linux-cifs@vger.kernel.org>; Tue, 01 Oct 2019 23:58:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=di0uA66doD+N8NldM/2xifjFW2TBOClqYI82wGKLU/A=;
        b=R4EE1Wr7/ozMvowmOQfJ70MGFgBg4whPI1bnbDftNZJAy8ewI3oiv1y0E3K577A3LR
         OEoLNzqnzAe+OheoG/oee3RNNwXsuqA1TeAZt6CEzp8qOm6ogdBvZLwpVQVS8vLWSLH9
         rkGbV2HCub8HUb9oTfu2WKDCT1kg2BySxoNpNJgLqwB/wYk1m492Hi5/HfHRy9EAHe+p
         6MfaM6vBMR3RdrAVA2aDMygji2TbjEo//j0MVmZHhGV6+XloQS8vupjLILNzQdTqhztg
         meLKtz/n3HEniucgejvpqbN82X4OaYppnLebdG60WC515kuhh/8R/xEHVjJ8XQduAStB
         fN6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=di0uA66doD+N8NldM/2xifjFW2TBOClqYI82wGKLU/A=;
        b=WHYoawqBDBHzMaEJ1wzn19KjsC+SL5AixbzU178udGqtX3cBjn5X5QLxXNHopWtUou
         l6JoP58mWFNpmdcjrQ31L/SDNwt50OiSs3C2NpXffTYS5VA4nlcz/QiMy2vfwR0+++7f
         /prhdbJCSjl+2lsK10risf/Q9bO9DCpQQyi40627BHl1h7VLUjCEObgIB6kJOtK1upoa
         Ntni6qaH9O55wELBl3mGv8ftAYcc0YQKXipUeH7VFTnsjEM4WXnDukR5OnjeCo+zsOfT
         eAU7iEtWMG2X/gwE1TVxYI3/+xQiW0ImdXvsp+u3/9CIG54mXMKCeVN+LYCLmpflLbcF
         wV1w==
X-Gm-Message-State: APjAAAX3jyjXE9CXFFT8tn09ytZYxEA4LxcCHlGXh6Bi30Dq4/cZJ6TN
        1NBRLJodmNb/DBp1Wra2L+prkN6YXH8dBfDzT9w=
X-Google-Smtp-Source: APXvYqyyUelJAfKpeYPZZ5XRChAcPlk6LrrvrACW7FLgwfePKWAMwrWiY7Y6LN7zpD6l8SNFyr5C9r4tBZo+C2dRtgA=
X-Received: by 2002:a02:5dca:: with SMTP id w193mr2444616jaa.94.1569999520863;
 Tue, 01 Oct 2019 23:58:40 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5mu8idWYkmRA8+64zqL+nXX9++tbBKiJvGtxEjyqZ_2pog@mail.gmail.com>
In-Reply-To: <CAH2r5mu8idWYkmRA8+64zqL+nXX9++tbBKiJvGtxEjyqZ_2pog@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Wed, 2 Oct 2019 16:58:30 +1000
Message-ID: <CAN05THQmXJbcurZ7j8xt0AraEqSm8Tf70WLH+oOYcJH2=y7AOQ@mail.gmail.com>
Subject: Re: [PATCH][SMB3] cleanup a couple minor recent endian errors spotted
 by sparse
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Looks good.

Reviewed-by me

On Wed, Oct 2, 2019 at 4:30 PM Steve French <smfrench@gmail.com> wrote:
>
> Now that I can run sparse again, spotted two recent minor endian
> errors that it flagged.
>
>
>
> --
> Thanks,
>
> Steve
