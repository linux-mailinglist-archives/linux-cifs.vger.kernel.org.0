Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C38264162FF
	for <lists+linux-cifs@lfdr.de>; Thu, 23 Sep 2021 18:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242160AbhIWQYS (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 23 Sep 2021 12:24:18 -0400
Received: from wolff.to ([98.103.208.27]:33542 "HELO wolff.to"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S242125AbhIWQYG (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 23 Sep 2021 12:24:06 -0400
Received: (qmail 2653 invoked by uid 500); 23 Sep 2021 16:10:16 -0000
Date:   Thu, 23 Sep 2021 11:10:16 -0500
From:   Bruno Wolff III <bruno@wolff.to>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Subject: Re: setcifsacl: Shouldn't 0x0 be a valid mask?
Message-ID: <20210923161016.GA2631@wolff.to>
References: <20210923155510.GA2171@wolff.to>
 <CAH2r5msCBzGM3Rc1JofLpCQEbkfRbJ5kgY+eSJrMX5Zx3xr6hw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <CAH2r5msCBzGM3Rc1JofLpCQEbkfRbJ5kgY+eSJrMX5Zx3xr6hw@mail.gmail.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On Thu, Sep 23, 2021 at 11:15:26 -0500,
  Steve French <smfrench@gmail.com> wrote:
>Do you have an example of doing the same thing via
>
>"smbcacls" (from Linux) or "icacls" (or cacls.exe) from Windows?

Not yet. I'll see if I can get an example quickly.
