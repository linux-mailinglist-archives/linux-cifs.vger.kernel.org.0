Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA89D301982
	for <lists+linux-cifs@lfdr.de>; Sun, 24 Jan 2021 05:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726223AbhAXEpP (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sat, 23 Jan 2021 23:45:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726398AbhAXEo6 (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sat, 23 Jan 2021 23:44:58 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 492A2C061573;
        Sat, 23 Jan 2021 20:44:17 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id m22so13169260lfg.5;
        Sat, 23 Jan 2021 20:44:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=wFBVZXmnZXBdfPw1ERyia3H6ojlw+P+hueWjrTDhLvc=;
        b=RQP901khG7CzkHyxDbwGatbK3uyCdAxA2MBvbo1cPKkNAEAjOB0YMjqcoN1v+GTb5b
         eV7TylC7PtNSpBwLf5TPgGxEFy23LBEksSOZfMhW1Xco7xOtj2ivF6FW0TH0wag9fjdM
         93L4ZLQkXhrpU9cV/w1a12Xpz2YVEFPIMH1ec2v8qSGEHfA8tfn7e0qdR5aezfm6gyf8
         O7q4JhvRe9hZnBp/DtUCcBdcbvrx7W85f98fl9poIdthoqLgcnzSNZ2ULC+c7WdsyRBD
         Yoe2qZvtm/mkscuPQG5f5GTTHUR5c5Ox+WO/Uvoo55BoLEEoHmXRReBPHFa4JjMqZsWe
         490Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=wFBVZXmnZXBdfPw1ERyia3H6ojlw+P+hueWjrTDhLvc=;
        b=lV+f/wjrex+eqE4C5YpwUsqj88AlpfK+s5VA+hcNWOMl4Zf7VXnWKdZ+aQSHZx6r+D
         FpODff0iuU0cKdxVEzRk9zPkekiBOcuzHMVQ0uRziYdlrrFuEN5zH0Ee+FKxOgknarW+
         AONq407kPpZcwyjEbcYtW5vStZ+Cw5fEsCUvCZ9WtPsC5ALvRwul6gJlfu+iXtFR+UTo
         pzYhG5qj5HBoIVW6r9pC9XM5QwbNXYLLxZfCV4Z+2rZAa2f6uL59HVHZfOCgpnQFDeUW
         f4JifnvdYyM9n2beBLxeRr7x0iS9s1obq8P3PqegifuKcmW3CMTubRXhB4Msjy2ViWTH
         JGng==
X-Gm-Message-State: AOAM531CpKUCuVSmS7ACBR6GLUFI+HZfYYaPgzqnsAEX5SAJOM4nYivb
        PaQ9zL7bXCkFfgBL7bM0Q5pCiMyBI7g26NswH7fmAAEEzyd37w==
X-Google-Smtp-Source: ABdhPJxjBGb3m9mq1Pg12x6nPON0K5dpsVRE7TzHSVsxVEuwivn2vIU88PpEgWVhEceXwjKtRFYG5nm6NinRYWiLE9Q=
X-Received: by 2002:a05:6512:31c1:: with SMTP id j1mr125185lfe.313.1611463455692;
 Sat, 23 Jan 2021 20:44:15 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sat, 23 Jan 2021 22:44:04 -0600
Message-ID: <CAH2r5msGe3xaKkJwt6MB98Tb2X3HW7HXAbubuet9LKbR+rYcdw@mail.gmail.com>
Subject: [GIT PULL] SMB3 Fixes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Please pull the following changes since commit
19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  git://git.samba.org/sfrench/cifs-2.6.git tags/5.11-rc4-smb3

for you to fetch changes up to 214a5ea081e77346e4963dd6d20c5539ff8b6ae6:

  cifs: do not fail __smb_send_rqst if non-fatal signals are pending
(2021-01-23 01:28:20 -0600)

----------------------------------------------------------------
an important signal handling patch for stable, and two small cleanup patches

Test results: http://smb3-test-rhel-75.southcentralus.cloudapp.azure.com/#/builders/2/builds/485
----------------------------------------------------------------
Jiapeng Zhong (2):
      fs/cifs: Assign boolean values to a bool variable
      fs/cifs: Simplify bool comparison.

Ronnie Sahlberg (1):
      cifs: do not fail __smb_send_rqst if non-fatal signals are pending

 fs/cifs/connect.c   | 4 ++--
 fs/cifs/transport.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

-- 
Thanks,

Steve
