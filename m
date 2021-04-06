Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 961D2354EF0
	for <lists+linux-cifs@lfdr.de>; Tue,  6 Apr 2021 10:47:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235446AbhDFIsB (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Tue, 6 Apr 2021 04:48:01 -0400
Received: from ishtar.tlinx.org ([173.164.175.65]:44710 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232593AbhDFIsB (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Tue, 6 Apr 2021 04:48:01 -0400
X-Greylist: delayed 604 seconds by postgrey-1.27 at vger.kernel.org; Tue, 06 Apr 2021 04:48:00 EDT
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id 1368bg6U037088;
        Tue, 6 Apr 2021 01:37:44 -0700
Message-ID: <606C1DD6.80606@tlinx.org>
Date:   Tue, 06 Apr 2021 01:37:42 -0700
From:   "L. A. Walsh" <linux-cifs@tlinx.org>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     Dan Carpenter <dan.carpenter@oracle.com>
CC:     namjae.jeon@samsung.com, linux-cifs@vger.kernel.org
Subject: cifsd: introduce SMB3 kernel server
References: <YFNRsYSWw77UMxw1@mwanda>
In-Reply-To: <YFNRsYSWw77UMxw1@mwanda>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On 2021/03/18 06:12, Dan Carpenter wrote:
> [ cifsd: introduce SMB3 kernel server"
Is it to be Linux policy that it will give in-kernel
support for only for smb3, or is it planned to move the rest of the proto
into the kernel as well?  It sorta seems like earlier parts of the protocol,
still dominant on home networks, though it seems linux not supporting
all of linux's smb devices, from smb2.1 and before.

I'm sure those clients would benefit as well, being kernel services
could allow for a lower latency with potentially faster response
time from being a kernel service instead of user-mode client?
Is that also planned?  Isn't the base of an smb3 server the same functions
of an smb2.x server with the new smb3 extensions?

Thanks!


