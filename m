Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FEAC416635
	for <lists+linux-cifs@lfdr.de>; Thu, 23 Sep 2021 21:50:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243039AbhIWTvn (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 23 Sep 2021 15:51:43 -0400
Received: from wolff.to ([98.103.208.27]:33602 "HELO wolff.to"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S242861AbhIWTvn (ORCPT <rfc822;linux-cifs@vger.kernel.org>);
        Thu, 23 Sep 2021 15:51:43 -0400
Received: (qmail 7811 invoked by uid 500); 23 Sep 2021 19:38:05 -0000
Date:   Thu, 23 Sep 2021 14:38:05 -0500
From:   Bruno Wolff III <bruno@wolff.to>
To:     Steve French <smfrench@gmail.com>
Cc:     CIFS <linux-cifs@vger.kernel.org>
Subject: Re: setcifsacl: Shouldn't 0x0 be a valid mask?
Message-ID: <20210923193805.GA5478@wolff.to>
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

I'm still trying to get the correct syntax for icacls, but when I 
used a GUI I was able to add an ACL with no access which icacls 
will display:
PS C:\Users\bruno-a> icacls forwards
forwards OWNER RIGHTS:
         NT AUTHORITY\SYSTEM:(I)(F)
         BUILTIN\Administrators:(I)(F)
         AD\bruno-a:(I)(F)

Successfully processed 1 files; Failed processing 0 files
