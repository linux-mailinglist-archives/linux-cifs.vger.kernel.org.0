Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 883EF149E19
	for <lists+linux-cifs@lfdr.de>; Mon, 27 Jan 2020 02:30:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726654AbgA0BaC (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Sun, 26 Jan 2020 20:30:02 -0500
Received: from mail-il1-f181.google.com ([209.85.166.181]:46755 "EHLO
        mail-il1-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726545AbgA0BaC (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Sun, 26 Jan 2020 20:30:02 -0500
Received: by mail-il1-f181.google.com with SMTP id t17so6157470ilm.13
        for <linux-cifs@vger.kernel.org>; Sun, 26 Jan 2020 17:30:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=IIkhiuZuJ2MlF79IjMR6PwO6Xbf2gO4kE0QNWykV0Ag=;
        b=QDUYAtwME+TcGbchIvdDgrf8AMobq/0jh+WuumV1R1n804QzhinB61zcXsWf2lRBia
         wEOExDQ2lfThTQblayaSvPZkQVNUQlmxDni0Agad6Rt6AQMjwX0LKWq2sIZgk6EEfRYh
         yMemTCw4kr64KnM7/90op1aOkhVWfnjYC/Eo5CQ4QTi5SkKVTCcqWUMBRVYKBPwdyVwc
         JZyF9U8cvAAKce7wfajl05N/oz3G4mfZhg9ReqVwZNLDnmI5j4o8hq4zbmMkfFE+qDJI
         Re7/wWt7oqEsgHqNBDgD7kRB/toiZSfap9CBbQtQSSCDNjrdbgJHUg7EQfnKSyBTfwOf
         ojgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=IIkhiuZuJ2MlF79IjMR6PwO6Xbf2gO4kE0QNWykV0Ag=;
        b=F5hvhSajPGYxRrRAd0uv7h8S1IkfHvLpP/v6sZhiMP8r8rcdRzDZfxZpVBF8wys5Oz
         pVCAFtswVgr9wNCM/qf2iTmeATtE8eb3SQLep7OCQdU85G60H3nvF9xlIVGAQxlZD1zi
         v3E7bUaCobJYZthA+8CtPyqXRaYicikHg3TPSW6nuvr+yRyugqY8j9Z2U0Ag4yX9LcRR
         hXGANGQGMDxMOdFaX/qlqaJ3AoB2wAAu3bBht/rttE5SIHEKSpDI8uq9KKU9C4uJ6qGk
         68jq+AZm83NCSFiBwus9mry1Yf2Yh2Mxd5QWah3CWvFOdtWgciJtec56OZ9CZ8VGVemg
         DOkA==
X-Gm-Message-State: APjAAAV/x7evagmss8yD1yRmtCanzxhFodSkPehx54UENwd6bQxU+sUz
        lkTHeJvLU+dj+75nJKDjcM6tmlULFzPQo6wVVC3tqFJ0
X-Google-Smtp-Source: APXvYqyqSlqEZHM4i0gqT/vXkJXxhPDXzkwqyjjSZrHbnwaKdizXv0NVuzirUYnQRzDxWE5NDb7QlvopyowRZC9mcuk=
X-Received: by 2002:a05:6e02:c71:: with SMTP id f17mr681048ilj.272.1580088601487;
 Sun, 26 Jan 2020 17:30:01 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Sun, 26 Jan 2020 19:29:50 -0600
Message-ID: <CAH2r5muvULmk3eRAg+tWbqxNXbU6d5dHTg+2akJxsqZiJNGibQ@mail.gmail.com>
Subject: Linux kernel 5.5 released - prep for 5.6-rc
To:     CIFS <linux-cifs@vger.kernel.org>
Cc:     samba-technical <samba-technical@lists.samba.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Now that 5.5 kernel is released (60+ cifs/smb3 patches) and
cifs-2.6.git for-next (and the github tree used by the smb3 buildbot
(automated testing), let me know if you see any patches missing for
cifs.ko that should be in for-next but aren't (currently 25 patches
queued).

-- 
Thanks,

Steve
