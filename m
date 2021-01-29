Return-Path: <linux-cifs-owner@vger.kernel.org>
X-Original-To: lists+linux-cifs@lfdr.de
Delivered-To: lists+linux-cifs@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4DB1308336
	for <lists+linux-cifs@lfdr.de>; Fri, 29 Jan 2021 02:27:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231332AbhA2B01 (ORCPT <rfc822;lists+linux-cifs@lfdr.de>);
        Thu, 28 Jan 2021 20:26:27 -0500
Received: from ishtar.tlinx.org ([173.164.175.65]:47918 "EHLO
        Ishtar.sc.tlinx.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229757AbhA2B0Z (ORCPT
        <rfc822;linux-cifs@vger.kernel.org>); Thu, 28 Jan 2021 20:26:25 -0500
X-Greylist: delayed 551 seconds by postgrey-1.27 at vger.kernel.org; Thu, 28 Jan 2021 20:26:25 EST
Received: from [192.168.3.12] (Athenae [192.168.3.12])
        by Ishtar.sc.tlinx.org (8.14.7/8.14.4/SuSE Linux 0.8) with ESMTP id 10T1GSPA045638
        for <linux-cifs@vger.kernel.org>; Thu, 28 Jan 2021 17:16:30 -0800
Message-ID: <6013618B.40707@tlinx.org>
Date:   Thu, 28 Jan 2021 17:14:51 -0800
From:   L Walsh <cifs@tlinx.org>
User-Agent: Thunderbird 2.0.0.24 (Windows/20100228)
MIME-Version: 1.0
To:     linux-cifs <linux-cifs@vger.kernel.org>
Subject: cifs _seems_ to be unneccessarily increasing memory footprint.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-cifs.vger.kernel.org>
X-Mailing-List: linux-cifs@vger.kernel.org

Looking in my loaded modules, 'cifs' is loading
libdes, fscache and libarc4.

My main question is why does a cifs filesystem that is
mounted from the network need libdes and libarc
if it is not using any encrypted connections on the wire?
(FWIW wire a a dedicated line between a Win WS, and a
linux file server, but encryption has never been needed.

So what is causing these modules to be loaded in now?


