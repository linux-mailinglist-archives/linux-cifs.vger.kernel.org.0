Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A42A918BD66
	for <lists+linux-cifs@lfdr.de>; Thu, 19 Mar 2020 18:03:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727431AbgCSRDz (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 19 Mar 2020 13:03:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:35970 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727877AbgCSRDy (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 19 Mar 2020 13:03:54 -0400
Received: by mail-lj1-f193.google.com with SMTP id g12so3359808ljj.3
        for <linux-cifs@vger.kernel.org>; Thu, 19 Mar 2020 10:03:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=hZlhNoR1NUbr639tPEWnk6rtibaahEXONVk0uSblHyw=;
        b=PdzolwHd8u4BGwOy3TBH+tkDgJJJq29Ku2AY98NX/+LtNupYv23zCu5i/Yf4WhBQlz
         sx+sHPAJjUU2HNotn09AS139ZcD1LRS/qmlfWhz4QHWuPtad3LvhoWwPjMF2CBPnimw8
         y+h9Z6/W3Fgjlx+9J6OmzCyNdEhgwx0Hby3B4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hZlhNoR1NUbr639tPEWnk6rtibaahEXONVk0uSblHyw=;
        b=KtGUqZZeP86DJHaFZ3Kyxu7jasyvV9V3ma7NI2piPmLH76vveo2u5QTwwJ36mszQut
         Hjx7agopziNeRWDmR/REJ2jG/9TLTAlduaXyzPjg2IarT3cAyPVl7FdBzpvmNOD6wQ1m
         e++6D19qtPUwp8se4IDElkBuv7o8hPa+9fn+YuNlxeUIiHLbsyWZythOic65dJVa8XPz
         lkgAeXcG+3e7E7iLin/1P/4w5kUA+WRKWXW8wKSWPtg/zG5dGLhOnoItEpaJasANVO8P
         XKzAj1+pNG+H/fIomwWCBTPowhXtDLUuR6F8A2K4mVA+Xyy0sYVsR52LBuBbUXtyBBPw
         Jqcw==
X-Gm-Message-State: ANhLgQ1ov/sRIDsy0luI3ziQqdO1gBj63j8KTOmZLwnPj8xCiP5lVMm3
        +2gkELTITJD4wLVwpwZ7BUbHXMS7C8A=
X-Google-Smtp-Source: ADFU+vsGnS/5GO7+aQTnjG2eU0jZKcZXgFFFzu21Ky9a8ZGMObI1ZMk00khLKrlL+npGiEAJUTC3BQ==
X-Received: by 2002:a2e:8246:: with SMTP id j6mr2749360ljh.162.1584637431631;
        Thu, 19 Mar 2020 10:03:51 -0700 (PDT)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id d4sm1825075lfa.75.2020.03.19.10.03.50
        for <linux-cifs@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Mar 2020 10:03:50 -0700 (PDT)
Received: by mail-lj1-f181.google.com with SMTP id a2so3343628ljk.6
        for <linux-cifs@vger.kernel.org>; Thu, 19 Mar 2020 10:03:50 -0700 (PDT)
X-Received: by 2002:a2e:9b07:: with SMTP id u7mr2867061lji.265.1584637430170;
 Thu, 19 Mar 2020 10:03:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAH2r5msOYEYH_YrSwGn6KYW83U0kyNS9U04xLgVFMx4xr32J1Q@mail.gmail.com>
In-Reply-To: <CAH2r5msOYEYH_YrSwGn6KYW83U0kyNS9U04xLgVFMx4xr32J1Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 19 Mar 2020 10:03:34 -0700
X-Gmail-Original-Message-ID: <CAHk-=whGupJv0ge7epQViXayTmD=SCkqsONsnRNZmEOZ9_3eqg@mail.gmail.com>
Message-ID: <CAHk-=whGupJv0ge7epQViXayTmD=SCkqsONsnRNZmEOZ9_3eqg@mail.gmail.com>
Subject: Re: [GIT PULL] CIFS/SMB3 fixes
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Wed, Mar 18, 2020 at 9:51 PM Steve French <smfrench@gmail.com> wrote:
>
>   git://git.samba.org/sfrench/cifs-2.6.git 5.6-rc6-smb3-fixes

Forgot to push?

   fatal: couldn't find remote ref 5.6-rc6-smb3-fixes

I do see the commit you reference in the "for-linus" branch, but then
I wouldn't get the tag with signature.

Please push it out,

              Linus
