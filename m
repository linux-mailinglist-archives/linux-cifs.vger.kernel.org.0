Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1DEA3A78E9
	for <lists+linux-cifs@lfdr.de>; Wed,  4 Sep 2019 04:38:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727891AbfIDCh7 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 3 Sep 2019 22:37:59 -0400
Received: from mail-io1-f47.google.com ([209.85.166.47]:38231 "EHLO
        mail-io1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727805AbfIDCh7 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 3 Sep 2019 22:37:59 -0400
Received: by mail-io1-f47.google.com with SMTP id p12so40809817iog.5
        for <linux-cifs@vger.kernel.org>; Tue, 03 Sep 2019 19:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UxMatm/CQf2ot9Kix+hu0VMV+wiVFkLkB7Tb6FurN2s=;
        b=mKqZ/8enJY45V9FrziIB6qjL8snoYFwXgW+pjZ9Z4iXm+LgdRKZYiq53wxGsw9FM/e
         efq0v4bXhZGBGc5UHddQkeXV1J3ugqwsuuQ0uBjNVObj+tsWKH1U62yvpup4u+fWcTOS
         lqCX11ejMy3latdkWBja054xMDsY0kV6DI2iDYuRb5qEyy33WFGa4g996TAJbCmeepV9
         an41wGij4owNsZwbiPDWReFY7HNzjO4m15a3qew8zbFhUtDmclusXB+v6N3Air7/WVFB
         HpzlUC7f4UCgzg8scrzTlJpZ585vAKQQwrkPJWnS1wGeuc4NqThIm9XFQtZdWC/QlDuG
         e5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UxMatm/CQf2ot9Kix+hu0VMV+wiVFkLkB7Tb6FurN2s=;
        b=sk/sUuxND0zjn20Sw1X15NjrREkPvppomOWcwpeWBXr7ftGz1mqYzP5V/nG4I8+y2x
         iwtXu4UZVJ67FnXGDCdzRmsj7gAQKNghQ70RhHprzILosmybsFwu58rCfDPW1pbN/EZe
         5uuT2d0/uM/LVCtK/nmXLVjfvV2zE/AaHtTPKcbU2fq5bcT9s3KNMyaJh4NVoYWz3z4y
         hOHihHPbLBL79TAgPYyhdZ67lfQDUG1L9gkMgwrqYm6ZGUnvW6K28Ka65GARGp0S3BOx
         c6ZiE3a/glKd4P/2NgTpqbWdISoCvV8uuB6C1JtsyreB8NUm164N0rXxSWFjbuimTLb/
         y5Tg==
X-Gm-Message-State: APjAAAUESEP12x2fu7CB0dmoLpXEQB0OyGzNcoF3JEDS6S+pKlzpsIM/
        LdPhd72qSoA4X8C5mZ8nv0wwg43exyj0Yot0TEv1Nd7p
X-Google-Smtp-Source: APXvYqznRUiBa3bFX/4JYauFqEBSC85Xl+P5XGaevounsO8S4ZvgF/liKyMOEA978Y00gbDYLt922aQRf2bIh5Qsy+c=
X-Received: by 2002:a6b:4404:: with SMTP id r4mr22106756ioa.159.1567564678298;
 Tue, 03 Sep 2019 19:37:58 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5muznTsxD2BsyPBX8jfRP5SngyAYf-GFX-tEY+-1DfdMSg@mail.gmail.com>
In-Reply-To: <CAH2r5muznTsxD2BsyPBX8jfRP5SngyAYf-GFX-tEY+-1DfdMSg@mail.gmail.com>
From:   ronnie sahlberg <ronniesahlberg@gmail.com>
Date:   Wed, 4 Sep 2019 12:37:44 +1000
Message-ID: <CAN05THTAvysJEiXp3mXaxTSzZOyRSd3y22Pw2MMJe8gQXdwZhQ@mail.gmail.com>
Subject: Re: [PATCH][SMB3] Allow skipping signing verification for perf
 sensitive use cases
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Change
bool ignore_signature;
to
bool ignore_signature:1;

And shouldn't this be part of CIFS_MOUNT_MASK too ?


On Wed, Sep 4, 2019 at 12:25 PM Steve French <smfrench@gmail.com> wrote:
>
> Add new mount option "signloosely" which enables signing but skips the
> sometimes expensive signing checks in the responses (signatures are
> calculated and sent correctly in the SMB2/SMB3 requests even with this
> mount option but skipped in the responses).  Although weaker for security
> (and also data integrity in case a packet were corrupted), this can provide
> enough of a performance benefit (calculating the signature to verify a
> packet can be expensive especially for large packets) to be useful in
> some cases.
>
>
> --
> Thanks,
>
> Steve
