Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B54F01573D0
	for <lists+linux-cifs@lfdr.de>; Mon, 10 Feb 2020 13:03:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726796AbgBJMDU (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Mon, 10 Feb 2020 07:03:20 -0500
Received: from ishtar.tlinx.org ([173.164.175.65]:50842 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726950AbgBJMDU (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Mon, 10 Feb 2020 07:03:20 -0500
X-Greylist: delayed 1891 seconds by postgrey-1.27 at vger.kernel.org; Mon, 10 Feb 2020 07:03:20 EST
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id 01ABVkYY028755;
        Mon, 10 Feb 2020 03:31:48 -0800
Message-ID: <5E413F22.3070101@tlinx.org>
Date:   Mon, 10 Feb 2020 03:31:46 -0800
From:   L Walsh <cifs@tlinx.org>
User-Agent: Thunderbird
MIME-Version: 1.0
To:     Steve French <smfrench@gmail.com>
CC:     CIFS <linux-cifs@vger.kernel.org>
Subject: Re: [CIFS][PATCH] Add SMB2? Change Notify
References: <CAH2r5mtQRVX3_-_sVjvigRSv2LpSoUBQo7YeY5v0nXm7BGaDig@mail.gmail.com>
In-Reply-To: <CAH2r5mtQRVX3_-_sVjvigRSv2LpSoUBQo7YeY5v0nXm7BGaDig@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-cifs-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

On 2020/02/06 04:29, Steve French wrote:
> A commonly used SMB3 feature is change notification, allowing an
> app to be notified about changes to a directory. The SMB3
> Notify request blocks until the server detects a change to that
> directory or its contents that matches the completion flags
> that were passed in and the "watch_tree" flag (which indicates
> whether subdirectories under this directory should be also
> included).  See MS-SMB2 2.2.35 for additional detail.
>   
----
    How does the SMB3 feature "change notification" differ from
the SMB2 feature described in MS-SMB2 2.2.35?

    Isn't it more typical to describe features by the spec version
that they were first publish under -- especially since the doc
describing the feature is under the SMB2 documents?

    By calling it a SMB3 feature, does that mean you are removing
it from SMB2?
Thanks!



