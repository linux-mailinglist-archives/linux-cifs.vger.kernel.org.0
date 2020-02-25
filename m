Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F0B2B16EEEE
	for <lists+linux-cifs@lfdr.de>; Tue, 25 Feb 2020 20:26:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731017AbgBYT0U (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 25 Feb 2020 14:26:20 -0500
Received: from mail-il1-f174.google.com ([209.85.166.174]:34456 "EHLO
        mail-il1-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728367AbgBYT0U (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 25 Feb 2020 14:26:20 -0500
Received: by mail-il1-f174.google.com with SMTP id l4so213167ilj.1
        for <linux-cifs@vger.kernel.org>; Tue, 25 Feb 2020 11:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to;
        bh=Vg2w9E/3hxLxS3OkDxLjagNz/LlWgHvNpy3TU70Hx/8=;
        b=UwoZKA8sgD0e03kHWXR5KT4nOdrK8j4fAQ1XjStM8PgDM7a95B9pf2u+SZnEKiyJ4q
         yYMFHEZLrHmHNGAhrT6zALaENiTvJEtR9eW7h97CMiPu2PG1Y5OG+1H/yr05gZOGe0qM
         +O1qlblh+K6tHzmQ/eb0v7Xbhzu7cISw04K3irKtt94t0YE6Rl3bG9h3bzXR64W1kKMf
         SESBjOnRTnenBGgLtQMGEffwLzj17OH+eERciF8e0eVWquHLhz+5d114NxmWcaPwHUz7
         Yh/tVkKWvp2tYsi6vsdnGdNd7cYWMGGb85A9h/hEZVADa6bDVXscbKnwx8la+t8Rot9/
         YWDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to;
        bh=Vg2w9E/3hxLxS3OkDxLjagNz/LlWgHvNpy3TU70Hx/8=;
        b=M2Z9I7SXgKJIINrrQqmRWOOMMU7yw5Wh08ZMxqmOOxndXZgKaU8b0nhDzVXsxgUGPx
         xGn0Nc8g6WlnRRg7M6ifBVmTL4UOmHo38W5sGcy8X+Eo3s/AFkxn4k7bG6zIJl9yaY1p
         rYHQhzkl+FOmlrXMyMxWH31P0FoxaMZvgmL4RGGkofXMZerTw6Zft0yEAzkYkWvdNW21
         GEoeOGeMD2W248mzvsqIoI695ZpTnn9iYyWBxgdWxoIT0+XRc3Js1LPz6Z4Mkx8rKfmJ
         mQorTY5wWuBDCH2Qmz18KJUUAB6Jjqt8PyzOL+H7Anu1jh9eFCt5p5Rer6B34YDaWJR2
         g7QQ==
X-Gm-Message-State: APjAAAW8fB6NHpEuh4YIgQUtTLYpLV0M6UJUg4oZujy9hDUzlamEANOp
        PcKn7Y2nwGCYMIGMb6ZW2gTr4RDSCLogmU/OQckQtQ==
X-Google-Smtp-Source: APXvYqx8JwlWijuCtdIqC71fW0a6y4GPl+7FQq90KdIf0sgm9nzzdVA00LbRE1kaiwu5MnO9ZCbk6IGFsODqT3AusCc=
X-Received: by 2002:a92:7301:: with SMTP id o1mr184476ilc.272.1582658779180;
 Tue, 25 Feb 2020 11:26:19 -0800 (PST)
MIME-Version: 1.0
From:   Steve French <smfrench@gmail.com>
Date:   Tue, 25 Feb 2020 13:26:08 -0600
Message-ID: <CAH2r5mtSiFk__O7pJcyHPYW_r59hthzh+XYD3rRG++zO+KzqHA@mail.gmail.com>
Subject: mount.cifs "sloppy" mount option
To:     CIFS <linux-cifs@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

I noticed that the "sloppy" mount option is not documented in the man
page.  Thoughts on whether it should be?

-- 
Thanks,

Steve
